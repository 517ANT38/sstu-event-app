<?php

namespace App\Console\Commands;

use App\Services\NewsService;
use Illuminate\Console\Command;
use App\Http\Clients\HttpClient;
use App\Services\NewsParserService;
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

    public function handle(NewsParserService $newsparser,NewsService $service,HttpClient $client)
    {

        foreach($this->mapSiteUrls as $siteName => $siteUrl){
            $resPageNews = $client->get($siteUrl);
            $rootUrl = $siteName == 'sstu' ? Config("app.mainUrl") : $siteUrl;
            $newsHeaders = $newsparser->parseAllUrlFromHeadersNews($resPageNews,$rootUrl);
            $service->addHeadersNews($siteName,$newsHeaders);
            foreach ($newsHeaders as $newHeader) {
                $resNewPage = $client->get($newHeader->url);
                $newDto = $newsparser->parseOneNew($resNewPage);
                $service->setNew($newHeader->url,$newDto);
            }
        }

    }
}
