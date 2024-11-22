<?php

namespace App\Http\Controllers;
use App\Http\Requests\RequestEventRequest;
use App\Services\EventRequestService;
use Symfony\Component\HttpFoundation\Response;
class RequestEventController extends Controller
{

    public function __construct(
        private EventRequestService $service
    ){}


    public function create(RequestEventRequest $request)
    {
        $res  = $request->validated();
        $this->service->save($res);
        return response()->noContent(Response::HTTP_CREATED);
    }


    public function show()
    {
        return response()->json($this->service->show());
    }

}
