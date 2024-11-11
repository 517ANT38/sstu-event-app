<?php

namespace App\Services;
use Symfony\Component\DomCrawler\Crawler;
use App\Models\DTO\NewsDto;

class NewsParser{

    public function __construct(
        private string $mainUrl
    ){}

    public function parseAllUrlFromHeadersNews(string $html) {
        $crw = new Crawler($html,$this->mainUrl);
        return $crw->filter('.news-list > .media > a')
            ->each(fn(Crawler $node, $i)=>$node->link()->getUri());

    }

    public function parseOneNew(string $html){
        $crw = new Crawler($html,$this->mainUrl);
        $title = $crw->filter('.block > h1')->text();
        $imgsUrls = $crw->filter('.news-detail img')
            ->each(fn(Crawler $node, $i)=>$node->image()->getUri());
        $desc = implode('\n', $crw->filter('.news-detail > p')
            ->each(fn(Crawler $node, $i)=>$node->text()));
        $date = $crw->filter('.news-detail div.date>span')->text();
        return new NewsDto($imgsUrls,$title,$desc,$date);
    }

}
