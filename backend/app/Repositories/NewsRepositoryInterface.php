<?php
namespace App\Repositories;

use App\Models\DTO\NewsDto;
use Illuminate\Support\Collection;

interface NewsRepositoryInterface{
    function addHeadersNews(string $siteName, array $news):void;
    function getHeadersNews(string $siteName,int $start=0,int $end=-1):array;
    function getNew(string $url):NewsDto;
    function setNew(string $url,NewsDto $new):void;
    function delete(string $key):void;
}
