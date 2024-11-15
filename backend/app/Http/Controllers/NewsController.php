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
        return response()->json($this->service->getNews($universityСode));

    }
    public function showNew(string $url)
    {
        return response()->json($this->service->getNew($url));
    }
}
