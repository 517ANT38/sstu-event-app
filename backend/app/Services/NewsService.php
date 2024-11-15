<?php
namespace App\Services;

use App\Models\DTO\HeaderNewDto;
use Illuminate\Support\Facades\Redis;

class NewsService{

    public function setNews(string $siteName, array $news){
        Redis::set($siteName,json_encode($news));
    }

    public function getNews(string $siteName){
        $news = json_decode(Redis::get($siteName));
        return array_map(fn($item)=>HeaderNewDto::transform($item),$news);
    }

}
