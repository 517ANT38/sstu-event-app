<?php

namespace App\Http\Controllers;
use App\Services\NewsService;

class NewsController extends Controller
{

    public function __construct(
        private NewsService $service
    ){}

    public function showNewsHeaders(string $universityСode)
    {
        return response()->json($this->service->getHeadersNews($universityСode));

    }
    public function showNew(string $id)
    {
        return response()->json($this->service->getNew($id));
    }
}
