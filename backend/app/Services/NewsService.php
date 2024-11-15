<?php
namespace App\Services;

use App\Models\DTO\HeaderNewDto;
use Illuminate\Support\Facades\Redis;
use App\Services\NewsParserService;
use Illuminate\Support\Facades\Http;

class NewsService{

    public function __construct(private NewsParserService $parser){}

    public function setNews(string $siteName, array $news){
        Redis::set($siteName,json_encode($news));
    }

    public function getNews(string $siteName){
        $news = json_decode(Redis::get($siteName),true);
        return array_map(fn($item)=>HeaderNewDto::transform($item),$news);
    }

    public function getNew(string $url){
        $res = Http::get($url);
        $res->throw();
        return $this->parser->parseOneNew($res->body(),Config("app.mainUrl"));
    }

}
