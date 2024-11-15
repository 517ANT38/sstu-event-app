<?php
namespace App\Services;
use App\Repositories\NewsRepositoryInterface;
use App\Models\DTO\NewsDto;
class NewsService{

    public function __construct(private NewsRepositoryInterface $repo){}

    public function addHeadersNews(string $siteName, array $news){
        $this->repo->addHeadersNews($siteName,$news);
    }

    public function getHeadersNews(string $siteName){
        return $this->repo->getHeadersNews($siteName);
    }

    public function getNew(string $siteName,string $url){
        return $this->repo->getNew($siteName,$url);
    }

    public function setNew(string $siteName,string $url,NewsDto $dto){
        $this->repo->setNew($siteName,$url,$dto);
    }
}
