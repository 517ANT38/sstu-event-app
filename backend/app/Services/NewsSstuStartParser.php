<?php
namespace App\Services;
use App\Models\DTO\HeaderNewDto;
use App\Models\DTO\NewsDto;
use Symfony\Component\DomCrawler\Crawler;

class NewsSstuStartParser{

    public function parseHeaders(string $html,?string $mainUrl){
        $crawler = new Crawler($html,$mainUrl);
        return $crawler->filter('.project-card')
        ->each(function (Crawler $node, $i){
            return new HeaderNewDto(
                null,
                $node->filter('img')->image()->getUri(),
                $node->filter('h3')->text(),
                $node->filter('a')->attr('href')
            );
        });
    }

    public function parseNew(string $html,string $urlId,?string $mainUrl){
        $crawler = new Crawler($html,$mainUrl);
        $node = $crawler->filter("$urlId");
        return new NewsDto(
            $node->filter('img')->each(fn($it)=>$it->image()->getUri()),
            $node->filter('h2')->text(),
            implode('\r\n',$node->filter('.about-text > p')->each(fn($it)=>$it->text()))
        );

    }


}
