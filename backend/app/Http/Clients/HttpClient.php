<?php
namespace App\Http\Clients;

use Illuminate\Http\Client\Response;
use Illuminate\Support\Facades\Http;

class HttpClient{
    public function get(string $url){
        $res = Http::get($url);
        $res->throwIf(fn (Response $response) => !$response->ok());
        return $res->body();
    }
}
