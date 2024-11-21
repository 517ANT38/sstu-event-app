<?php
namespace App\Repositories;

use App\Models\DTO\HeaderNewDto;
use App\Models\DTO\NewsDto;
use Illuminate\Support\Facades\Redis;

class NewsRepository implements NewsRepositoryInterface{

    public function addHeadersNews(string $siteName, array $news):void{
        Redis::rPush($siteName, array_map(fn($it)=>json_encode($it),$news));
    }

    public function getHeadersNews(string $siteName,int $start=0,int $end=-1):array{
        $news = json_decode(Redis::lRange($siteName,$start,$end),true);
        return array_map(fn($item)=>HeaderNewDto::transform($item),$news);
    }

    public function getNew(string $url):NewsDto{
        $new = json_decode(Redis::get($url),true);
        return NewsDto::transform($new);
    }

    public function setNew(string $url,NewsDto $new,int $ttl = 21600):void{
        Redis::set($url,json_encode($new),"EX",$ttl);
    }

    public function delete(string $key): void {
        Redis::del($key);
    }
}
