<?php

namespace App\Http\Controllers;
use Illuminate\Routing\Controller;
use App\Services\EventRequestService;
use App\Http\Requests\RequestEventRequest;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class RequestEventController extends Controller
{

    public function __construct(
        private EventRequestService $service
    ){}


    public function create(RequestEventRequest $req)
    {
        $res  = $req->validated();
        $this->service->save($res);
        return response()->noContent(Response::HTTP_CREATED);

    }


    public function show()
    {
        return response()->json($this->service->show());
    }

}
