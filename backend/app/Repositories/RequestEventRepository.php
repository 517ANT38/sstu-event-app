<?php
namespace App\Repositories;
use App\Models\RequestEvent;
use Illuminate\Database\Eloquent\Collection;

class RequestEventRepository implements RequestEventRepositoryInterface
{
    public function save(array $requestEvent):void
    {
        RequestEvent::create($requestEvent);
    }

    public function show(): Collection
    {
        return RequestEvent::all();
    }

}
