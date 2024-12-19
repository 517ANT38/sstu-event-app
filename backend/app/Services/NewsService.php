<?php
namespace App\Services;
use App\Repositories\NewsRepositoryInterface;
use App\Models\DTO\NewsDto;
use App\Exceptions\NewNotFoundException;
use App\Exceptions\HeadersNewsNotFoundException;
class NewsService{

    public function __construct(private NewsRepositoryInterface $repo){}

    public function addNews(string $siteName, array $headNews,array $news){
        foreach($headNews as $new){
            $new->id = bin2hex($new->url.'_'.date(DATE_ATOM));
        }
        array_walk($headNews,fn($head,$i)=>$this->setNew($head->id,$news[$i]));
        $this->repo->addHeadersNews($siteName,$headNews);
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

    private function setNew(string $id,NewsDto $dto){
        $this->repo->setNew($id,$dto);
    }

    public function deleteNew(string $id){$this->repo->delete($id);}
}
