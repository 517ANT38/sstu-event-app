<?php
namespace App\Services;
use App\Repositories\RequestEventRepositoryInterface;
use App\Repositories\NewsRepositoryInterface;

class EventRequestService{

    public function __construct(
        private RequestEventRepositoryInterface $repo,
        private NewsRepositoryInterface $repoNews
    ){}

    public function save(array $reqEvent){
        $new = $this->repoNews->getNew($reqEvent['idEvent']);
        if ($new != null) {
            $reqEvent['nameEvent'] = $new->title;
        }
        $this->repo->save($reqEvent);

    }

    public function show(){
        return $this->repo->show();
    }
}
