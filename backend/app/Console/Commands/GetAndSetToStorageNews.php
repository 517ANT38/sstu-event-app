<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Services\NewsService;
use App\Services\NewsParserService;
use Illuminate\Support\Facades\Http;
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

    public function handle(NewsParserService $newsparser,NewsService $service)
    {

        $mainUrl = Config("app.mainUrl");
        foreach($this->mapSiteUrls as $siteName => $siteUrl){
            $res = Http::get($siteUrl);
            if(!$res->ok())continue;
            $newsHeaders = $newsparser->parseAllUrlFromHeadersNews($res->body(),
                $siteName == "sstu"?$mainUrl:$siteUrl);
            $service->addHeadersNews($siteName,$newsHeaders);

            foreach($newsHeaders as $head){
                $head->
            }
        }

    }
}
