<?php
namespace App\Services;
use App\Repositories\NewsRepositoryInterface;
use App\Models\DTO\NewsDto;
use App\Exceptions\NewNotFoundException;
use App\Exceptions\HeadersNewsNotFoundException;
class NewsService{

    public function __construct(private NewsRepositoryInterface $repo){}

    public function addHeadersNews(string $siteName, array $news){
        foreach($news as $new){
            $new->id = uniqid();
        }
        $this->repo->addHeadersNews($siteName,$news);
        return $news;
    }

    public function getHeadersNews(string $siteName){
        $headers = $this->repo->getHeadersNews($siteName);
        if($headers == null){
            throw new HeadersNewsNotFoundException($siteName);
        }
        return $headers;
    }

    public function getNew(string $id){
        $new  = $this->repo->getNew($id);
        if($new == null){
            throw new NewNotFoundException($id);
        }
        return $new;
    }

    public function setNew(string $id,NewsDto $dto){
        $this->repo->setNew($id,$dto);
    }

    public function deleteNew(string $id){$this->repo->delete($id);}
}
