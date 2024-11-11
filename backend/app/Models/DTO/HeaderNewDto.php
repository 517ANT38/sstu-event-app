<?php

namespace App\Models\DTO;

class HeaderNewDto{
    public function __construct(
        public string $imgUrl,
        public string $title,
        public string $url
    ){}
}
