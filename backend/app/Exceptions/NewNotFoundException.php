<?php

namespace App\Exceptions;

use Exception;

class NewNotFoundException extends Exception
{
    private string $url;

    public function __construct(string $url)
    {
        parent::__construct();
        $this->url = $url;
    }

    public function getUrl(){
        return $this->url;
    }

    public function context(): array
    {
        return ['url' => $this->url];
    }

}
