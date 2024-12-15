<?php

namespace App\Services;
use Symfony\Component\DomCrawler\Crawler;
use App\Models\DTO\NewsDto;
use App\Models\DTO\HeaderNewDto;

use function Laravel\Prompts\text;

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
        $descs = $crw->filter('.news-detail p')
            ->each(fn(Crawler $node, $i)=>$node->text());
        $descs=array_map(fn($it)=>trim($it),$descs);
        $descs=array_filter($descs,fn($it)=>$it !== '');
        $desc= implode('\r\n',$descs);
        if ($desc == '') {
            $desc = preg_replace('/((\r\n)|\n)+/si','\r\n',$crw->filter('.news-detail')->text());
            $desc = trim($desc);
        }
        $date = $crw->filter('.news-detail div.date>span')->text();
        $isfind = preg_match('/\d{2}\.\d{2}\.\d{2,4}/',$date,$matches);
        $date = $isfind ? $matches[0] : $date;
        return new NewsDto($imgsUrls,$title,$desc,$date);
    }


}
