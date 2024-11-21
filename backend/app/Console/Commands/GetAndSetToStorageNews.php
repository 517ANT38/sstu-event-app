<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Services\NewsService;
use App\Services\NewsParserService;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Redis;
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

    public function handle(NewsParserService $newsparser,NewsService $service)
    {

        foreach($this->mapSiteUrls as $siteName => $siteUrl){
            $resPageNews = Http::get($siteUrl);
            if(!$resPageNews->ok())continue;
            $rootUrl = $siteName == 'sstu' ? Config("app.mainUrl") : $siteUrl;
            $newsHeaders = $newsparser->parseAllUrlFromHeadersNews($resPageNews->body(),$rootUrl);
            $service->deleteHeaders($siteName);
            $service->addHeadersNews($siteName,$newsHeaders);
            foreach ($newsHeaders as $newHeader) {
                $resNewPage = Http::get($newHeader->url);
                if(!$resPageNews->ok())continue;
                print($newHeader->url."\n\r\n\r");
                $newDto = $newsparser->parseOneNew($resNewPage->body());
                $service->setNew($newHeader->url,$newDto);
            }
        }

    }
}
