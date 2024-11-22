<?php

namespace App\Exceptions;

use Psr\Log\LogLevel;
use Illuminate\Http\Client\RequestException;
use Illuminate\Http\Client\ConnectionException;
use App\Exceptions\NotMatchesException;
use App\Exceptions\NewNotFoundException;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;

class Handler extends ExceptionHandler
{
    protected $levels = [
        NotMatchesException::class => LogLevel::CRITICAL,
        RequestException::class => LogLevel::CRITICAL,
        ConnectionException::class => LogLevel::CRITICAL

    ];

    public function register(): void
    {

        $this->renderable(function (NewNotFoundException $e) {
            $url = $e->getUrl();
            return response()->json([
                'message' => "New not found by url=$url."
            ],404);
        });
    }
}
