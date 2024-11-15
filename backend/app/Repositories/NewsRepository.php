<?php
namespace App\Repositories;

use App\Models\DTO\HeaderNewDto;
use App\Models\DTO\NewsDto;
use Illuminate\Support\Facades\Redis;
use Illuminate\Support\Collection;


class NewsRepository implements NewsRepositoryInterface{

    public function addHeadersNews(string $siteName, array $news):void{
        Redis::rPush($siteName, array_map(fn($it)=>json_encode($it),$news));
    }

    public function getHeadersNews(string $siteName,int $start=0,int $end=-1):Collection{
        $news = json_decode(Redis::lRange($siteName,$start,$end),true);
        return new Collection(array_map(fn($item)=>HeaderNewDto::transform($item),$news));
    }

    public function getNew(string $siteName,string $url):NewsDto{
        $new = json_decode(Redis::hGet($siteName,$url),true);
        return NewsDto::transform($new);
    }

    public function setNew(string $siteName,string $url,NewsDto $new):void{
        Redis::hSet($siteName,$url,json_encode($new));
    }

}
