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
        $news = Redis::lRange($siteName,$start,$end);
        return array_map(fn($item)=>HeaderNewDto::transform(json_decode($item,true)),$news);
    }

    public function getNew(string $url):?NewsDto{
        $new = json_decode(Redis::get($url),true);
        if($new != null)
            return NewsDto::transform($new);
        return null;
    }

    public function setNew(string $url,NewsDto $new,int $ttl = 21600):void{
        Redis::set($url,json_encode($new),"EX",$ttl);
    }

    public function delete(string $key): void {
        Redis::del($key);
    }
}
