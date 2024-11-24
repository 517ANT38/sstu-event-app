<?php
namespace App\Services;
use App\Repositories\NewsRepositoryInterface;
use App\Models\DTO\NewsDto;
use App\Exceptions\NewNotFoundException;
use App\Exceptions\HeadersNewsNotFoundException;
class NewsService{

    public function __construct(private NewsRepositoryInterface $repo){}

    public function addHeadersNews(string $siteName, array $news){
        $this->repo->addHeadersNews($siteName,$news);
    }

    public function getHeadersNews(string $siteName){
        $headers = $this->repo->getHeadersNews($siteName);
        if($headers == null){
            throw new HeadersNewsNotFoundException($siteName);
        }
        return $headers;
    }

    public function getNew(string $url){
        $new  = $this->repo->getNew($url);
        if($new == null){
            throw new NewNotFoundException($url);
        }
        return $new;
    }

    public function setNew(string $url,NewsDto $dto){
        $this->repo->setNew($url,$dto);
    }

    public function deleteNew(string $url){$this->repo->delete($url);}
}
