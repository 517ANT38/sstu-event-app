<?php
namespace App\Services;
use App\Repositories\NewsRepositoryInterface;
use App\Models\DTO\NewsDto;
use App\Exceptions\NewNotFoundException;
class NewsService{

    public function __construct(private NewsRepositoryInterface $repo){}

    public function addHeadersNews(string $siteName, array $news){
        $this->repo->addHeadersNews($siteName,$news);
    }

    public function getHeadersNews(string $siteName){
        return $this->repo->getHeadersNews($siteName);
    }

    public function getNew(string $url){
        $new  = $this->repo->getNew($url);
        if($new == null){
            throw new NewNotFoundException($url);
        }
        return null;
    }

    public function setNew(string $url,NewsDto $dto){
        $this->repo->setNew($url,$dto);
    }

    public function deleteHeaders(string $siteName){$this->repo->delete($siteName);}

    public function deleteNew(string $url){$this->repo->delete($url);}
}
