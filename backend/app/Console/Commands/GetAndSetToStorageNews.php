<?php

namespace App\Console\Commands;

use App\Services\NewsService;
use Illuminate\Console\Command;
use App\Http\Clients\HttpClient;
use App\Services\NewsParserService;
use App\Services\NewsSstuStartParser;
use Illuminate\Support\Facades\File;
class GetAndSetToStorageNews extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:get-and-set-to-storage-news';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Get News from site sstu and set to storage';

    private array $mapSiteUrls;
    private NewsParserService $newsparser;
    private NewsSstuStartParser $startsstuparser;
    private NewsService $service;
    private HttpClient $client;

    public function __construct(NewsParserService $newsparser,NewsSstuStartParser $startsstuparser,NewsService $service,HttpClient $client)
    {
        parent::__construct();
        $this->mapSiteUrls = File::json(base_path('site_sstu.json'));
        $this->newsparser = $newsparser;
        $this->startsstuparser = $startsstuparser;
        $this->service = $service;
        $this->client =$client;

    }

    public function handle()
    {
        $mailUrl = Config("app.mainUrl");
        foreach($this->mapSiteUrls as $siteName => $siteUrl){
            $resPageNews = $this->client->get($siteUrl);
            $rootUrl = $siteName == 'sstu' ? $mailUrl : $siteUrl;
            if ($siteName == "start-sstu")
                [$tmpNews,$tmpNewsHeaders] = $this->parseStartSSTU($resPageNews,$rootUrl);
            else
                [$tmpNews,$tmpNewsHeaders] = $this->parseNewsSSTU($resPageNews,$rootUrl);
            $news = $newsHeaders = [];
            for($i=0;$i<count($tmpNewsHeaders);$i++){
                $checkRes = $this->client->post(Config('app.mlApiUrl'),['text'=>str_replace('\r\n','',$tmpNews[$i]->desc)]);
                if ($checkRes['result'] != 'positive') continue;
                array_push($newsHeaders,$tmpNewsHeaders[$i]);
                array_push($news,$tmpNews[$i]);
            }
            $this->service->addNews($siteName,$newsHeaders,$news);
        }
    }

    private function parseStartSSTU(string $resPageNews, string $rootUrl){
        $tmpNewsHeaders = $this->startsstuparser->parseHeaders($resPageNews,$rootUrl);
        $tmpNews = [];
        foreach($tmpNewsHeaders as $head){
            $new = $this->startsstuparser->parseNew($resPageNews,$head->url,$rootUrl);
            array_push($tmpNews,$new);
        }
        return [$tmpNews,$tmpNewsHeaders];
    }

    private function parseNewsSSTU(string $resPageNews,string $rootUrl){
        $tmpNewsHeaders = $this->newsparser->parseAllUrlFromHeadersNews($resPageNews,$rootUrl);
        $tmpNews = [];
        foreach($tmpNewsHeaders as $head){
            $page = $this->client->get($head->url);
            $new = $this->newsparser->parseOneNew($page,$rootUrl);
            array_push($tmpNews,$new);
        }
        return [$tmpNews,$tmpNewsHeaders];
    }
}
