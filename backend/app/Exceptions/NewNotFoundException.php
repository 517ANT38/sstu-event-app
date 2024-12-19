<?php

namespace App\Exceptions;

use Exception;

class NewNotFoundException extends Exception
{
    private string $id;

    public function __construct(string $id)
    {
        parent::__construct();
        $this->id = $id;
    }

    public function getId(){
        return $this->id;
    }

    public function context(): array
    {
        return ['id' => $this->id];
    }

}
