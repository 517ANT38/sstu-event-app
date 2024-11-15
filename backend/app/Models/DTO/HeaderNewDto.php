<?php

namespace App\Models\DTO;

class HeaderNewDto{
    public function __construct(
        public string $imgUrl,
        public string $title,
        public string $url
    ){}
    public static function transform(mixed $args)
    {
        return new self(
            $args['imgUrl'],
            $args['title'],
            $args['url']
        );
    }
}
