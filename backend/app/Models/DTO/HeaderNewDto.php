<?php

namespace App\Models\DTO;

class HeaderNewDto{
    public function __construct(
        public ?string $id,
        public string $imgUrl,
        public string $title,
        public string $url
    ){}
    public static function transform(array $args)
    {
        return new self(
            $args['id'],
            $args['imgUrl'],
            $args['title'],
            $args['url']
        );
    }
}
