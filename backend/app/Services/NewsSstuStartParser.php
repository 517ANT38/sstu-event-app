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
                $node->filter('a')->link()->getUri(),
                null
            );
        });
    }

    public function parseNew(string $html,string $urlNew,?string $mainUrl){
        $crawler = new Crawler($html,$mainUrl);
        $urlId = explode("#",$urlNew)[1];
        $node = $crawler->filter("#$urlId");
        $descs=array_map(fn($it)=>trim($it),$node->filter('.about-text > p')->each(fn($it)=>$it->text()));
        $descs=array_filter($descs,fn($it)=>$it !== '');
        return new NewsDto(
            $node->filter('img')->each(fn($it)=>$it->image()->getUri()),
            $node->filter('h2')->text(),
            implode('\r\n',$descs)
        );

    }


}
