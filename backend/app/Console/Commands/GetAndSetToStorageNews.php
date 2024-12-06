<?php

namespace App\Console\Commands;

use App\Services\NewsService;
use Illuminate\Console\Command;
use App\Http\Clients\HttpClient;
use App\Models\DTO\HeaderNewDto;
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

    public function __construct()
    {
        parent::__construct();
        $this->mapSiteUrls = File::json(base_path('site_sstu.json'));

    }

    public function handle(NewsParserService $newsparser,NewsSstuStartParser $startsstuparser,NewsService $service,HttpClient $client)
    {
        $mailUrl = Config("app.mainUrl");
        foreach($this->mapSiteUrls as $siteName => $siteUrl){
            $resPageNews = $client->get($siteUrl);
            $rootUrl = $siteName == 'sstu' ? $mailUrl : $siteUrl;
            if ($siteName == "start-sstu")
                $tmpNewsHeaders = $startsstuparser->parseHeaders($resPageNews,$rootUrl);
            else
                $tmpNewsHeaders = $newsparser->parseAllUrlFromHeadersNews($resPageNews,$rootUrl);
            $news = $newsHeaders = [];
            foreach($tmpNewsHeaders as $head){
                if ($siteName == "start-sstu")
                    $tmpNewsHeaders = $startsstuparser->parseNew($resPageNews,$head->url,$rootUrl);
                else{
                    $page = $client->get($head->url);
                    $new = $newsparser->parseOneNew($page,$rootUrl);
                }
                $checkRes = $client->post(Config('app.mlApiUrl'),['text'=>str_replace('\r\n','',$new->desc)]);
                if ($checkRes['result'] != 'positive') continue;
                array_push($news,$new);array_push($newsHeaders,$head);
            }
            $newsHeadersWithIds = $service->addHeadersNews($siteName,$newsHeaders);
            array_walk($newsHeadersWithIds,fn($head,$i)=>$service->setNew($head->id,$news[$i]));
        }
    }
}
