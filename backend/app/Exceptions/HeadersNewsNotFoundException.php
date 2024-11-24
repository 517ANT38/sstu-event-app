<?php

namespace App\Exceptions;

use Exception;

class HeadersNewsNotFoundException extends Exception
{
    private string $siteName;

    public function __construct(string $siteName)
    {
        parent::__construct();
        $this->siteName = $siteName;
    }

    public function getSiteName(){
        return $this->siteName;
    }

    public function context(): array
    {
        return ['siteName' => $this->siteName];
    }
}
