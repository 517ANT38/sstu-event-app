<?php

namespace App\Models\DTO;

final class NewsDto{
    public function __construct(
        public array $imgUrls,
        public string $title,
        public string $desc,
        public string $date
    ){}
}
