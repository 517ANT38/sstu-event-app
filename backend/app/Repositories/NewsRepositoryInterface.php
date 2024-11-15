<?php
namespace App\Repositories;

use App\Models\DTO\NewsDto;
use Illuminate\Support\Collection;

interface NewsRepositoryInterface{
    function addHeadersNews(string $siteName, array $news):void;
    function getHeadersNews(string $siteName,int $start=0,int $end=-1):Collection;
    function getNew(string $siteName,string $url):NewsDto;
    function setNew(string $siteName,string $url,NewsDto $new):void;
}
