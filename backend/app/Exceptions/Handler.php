<?php

namespace App\Exceptions;

use Psr\Log\LogLevel;
use Illuminate\Support\Facades\Log;
use App\Exceptions\NewNotFoundException;
use Illuminate\Http\Client\RequestException;
use Illuminate\Http\Client\ConnectionException;
use App\Exceptions\HeadersNewsNotFoundException;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;

class Handler extends ExceptionHandler
{

    public function register(): void
    {

        $this->reportable(function (RequestException $e){
            $status = $e->response->status();
            Log::critical("Error status $status");
        });
        $this->reportable(function (ConnectionException $e){

            Log::critical("Connect error");
        });

        $this->renderable(function (NewNotFoundException $e) {
            $id = $e->getId();
            return response()->json([
                'message' => "New not found by url=$id."
            ],404);
        });
        $this->renderable(function (HeadersNewsNotFoundException $e) {
            $siteName = $e->getSiteName();
            return response()->json([
                'message' => "New not found by siteName=$siteName."
            ],404);
        });
    }
}
