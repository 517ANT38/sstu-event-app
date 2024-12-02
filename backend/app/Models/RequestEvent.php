<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class RequestEvent extends Model
{
    protected $fillable = [
            'secondName' ,
            'firstName' ,
            'middleName',
            'edu',
            'phone',
            'countChild',
            'fromClass',
            'toClass',
            'urlEvent'
        ];

}
