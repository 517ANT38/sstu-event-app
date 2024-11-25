<?php
namespace App\Repositories;

use App\Models\DTO\HeaderNewDto;
use App\Models\DTO\NewsDto;
use Illuminate\Support\Facades\Redis;
class NewsRepository implements NewsRepositoryInterface{

    public function addHeadersNews(string $siteName, array $news):void{
        Redis::set($siteName, json_encode($news));
    }

    public function getHeadersNews(string $siteName):?array{
        $news = json_decode(Redis::get($siteName),true);
        if($news != null){
            return array_map(fn($item)=>HeaderNewDto::transform($item),$news);
        }
        return null;

    }

    public function getNew(string $url):?NewsDto{
        $new = json_decode(Redis::get($url),true);
        if($new != null)
            return NewsDto::transform($new);
        return null;
    }

    public function setNew(string $url,NewsDto $new,int $ttl = 23400):void{
        Redis::set($url,json_encode($new),"EX",$ttl);
    }

    public function delete(string $key): void {
        Redis::del($key);
    }
}
