<?php
namespace App\Services;
use App\Models\RequestEvent;
use App\Repositories\RequestEventRepositoryInterface;

class EventRequestService{

    public function __construct(
        private RequestEventRepositoryInterface $repo
    ){}

    public function save(array $reqEvent){
        $this->repo->save($reqEvent);

    }

    public function show(){
        return $this->repo->show();
    }
}
