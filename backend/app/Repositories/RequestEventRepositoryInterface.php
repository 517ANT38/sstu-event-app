<?php
namespace App\Repositories;
use App\Models\RequestEvent;
use Illuminate\Database\Eloquent\Collection;

interface RequestEventRepositoryInterface
{
    function save(array $requestEvent):void;
    function show():Collection;
}
