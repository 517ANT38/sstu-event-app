<?php

namespace App\Services;
use Symfony\Component\DomCrawler\Crawler;
use App\Models\DTO\NewsDto;
use App\Models\DTO\HeaderNewDto;
class NewsParserService{

    public function parseAllUrlFromHeadersNews(string $html,string $mainUrl) {
        $crw = new Crawler($html,$mainUrl);
        return $crw->filter('.news-list > .media ')
            ->each(fn(Crawler $node, $i)=>new HeaderNewDto(
                null,
                $node->filter('img')->image()->getUri(),
                $node->filter('a')->attr('title'),
                $node->filter('a')->link()->getUri()
            ));

    }

    public function parseOneNew(string $html,?string $mainUrl){
        $crw = new Crawler($html,$mainUrl);
        $title = $crw->filter('.block > h1')->text();
        $imgsUrls = $crw->filter('.news-detail img')
            ->each(fn(Crawler $node, $i)=>$node->image()->getUri());
        $desc = implode('\r\n', $crw->filter('.news-detail p')
            ->each(fn(Crawler $node, $i)=>$node->text()));
        $date = $crw->filter('.news-detail div.date>span')->text();
        return new NewsDto($imgsUrls,$title,$desc,$date);
    }

}
