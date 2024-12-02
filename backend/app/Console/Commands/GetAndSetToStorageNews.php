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

            if ($siteName == "start-sstu") {
                $newsHeaders = $startsstuparser->parseHeaders($resPageNews,$siteUrl);
                $news = array_map(fn(HeaderNewDto $dto)=>$startsstuparser->parseNew($resPageNews,$dto->url,$siteUrl),
                    $newsHeaders);
            }else{
                $rootUrl = $siteName == 'sstu' ? $mailUrl : $siteUrl;
                $newsHeaders = $newsparser->parseAllUrlFromHeadersNews($resPageNews,$rootUrl);
                $news = array_map(function (HeaderNewDto $dto) use ($client,$rootUrl,$newsparser){
                    $page = $client->get($dto->url);
                    return $newsparser->parseOneNew($page,$rootUrl);
                },$newsHeaders);
            }
            $newsHeadersWithIds = $service->addHeadersNews($siteName,$newsHeaders);
            for ($i=0; $i < count($newsHeadersWithIds) ; $i++) {
                $service->setNew($newsHeadersWithIds[$i]->id,$news[$i]);
            }

        }

    }
}
