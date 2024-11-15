<?php

namespace App\Models\DTO;

final class NewsDto{
    public function __construct(
        public array $imgUrls,
        public string $title,
        public string $desc,
        public string $date
    ){}
    public static function transform(array $args)
    {
        return new self(
            $args['imgUrls'],
            $args['title'],
            $args['desc'],
            $args['date']
        );
    }
}

