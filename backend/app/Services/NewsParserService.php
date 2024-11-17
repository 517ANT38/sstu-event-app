<?php

namespace App\Services;
use Exception;
use App\Models\DTO\NewsDto;
use App\Models\DTO\HeaderNewDto;
use App\Exceptions\NotMatchesException;

class NewsParserService{

    private static string $PATTERN_URL_GET_ALL_NEWS = '/<div\s+class=["\']media["\'].*?>\s*<a\s+[^>]*?class=["\'](media|pull)-left["\'][^>]*?href=["\'](.*?)["\']/si';
    private static string $PATTERN_TITLE_GET_ALL_NEWS = '/<div\s+class=["\']media["\'].*?>\s*<a\s+[^>]*?class=["\'](media|pull)-left["\'][^>]*?title=["\'](.*?)["\']/si';
    private static string $PATTERN_IMG_GET_ALL_NEWS = '/<div\s+class=["\']media["\'].*?>\s*<img\s+[^>]*?class=["\']media-object["\'][^>]*?src=["\'](.*?)["\']/si';
    private static string $PATTERN_GET_IMGS = '/<div\s+class=["\'](photo|news-detail).*?["\'][^>]*>.*?<img\s+[^>]*?src=["\'](.*?)["\']/si';
    private static string $PATTERN_GET_TITLE ='/<div\s+class=["\']block["\'].*?>\s*<h1.*?>(.*?)<\/h1>/si';
    private static string $PATTERN_GET_TEXTS = '/<(p|blockquote) style="text-align: justify;">(.*?)<\/\1>/si';
    private static string $PATTERN_GET_DATE = '/<span>(\d{2}\.\d{2}\.\d{4})<\/span>/si';

    private string $mainUrl;

    public function __construct()
    {
      $this->mainUrl = Config("app.mainUrl");
    }

    public function parseAllUrlFromHeadersNews(string $html,string $rootUrl) {
        $matchesUrls = $this->parseWithRegexMany(NewsParserService::$PATTERN_URL_GET_ALL_NEWS,$html,2,"urls");
        $matchesTitles = $this->parseWithRegexMany(NewsParserService::$PATTERN_TITLE_GET_ALL_NEWS,$html,2,"titles");
        $matchesImgs = $this->parseWithRegexMany(NewsParserService::$PATTERN_IMG_GET_ALL_NEWS,$html,1,"imgs");
        $countMatchs = count($matchesUrls);
        if ($countMatchs != count($matchesTitles) || $countMatchs!= count($matchesImgs)) {
            throw new NotMatchesException("Not eq count matches in field dto");
        }
        $headers = [];
        for ($i=0; $i < $countMatchs; $i++) {
            array_push($headers,new HeaderNewDto(
                $this->mainUrl.$matchesImgs[$i],
                $matchesTitles[$i],
                $rootUrl.$matchesUrls[$i]
            ));
        }
        return $headers;
    }


    private function parseWithRegexMany(string $regx,string $html,int $gIndex,string $desc){
        if(preg_match_all($regx,$html,$matches)){
            return $matches[$gIndex];
        }
        throw new NotMatchesException("Not matches $desc");

    }

    private function parseWithRegexOne(string $regx,string $html,string $desc){
        if (preg_match($regx,$html,$matches)) {
            return $matches[1];
        }
        throw new NotMatchesException("Not matches $desc");
    }

    public function parseOneNew(string $html){
        $title = $this->parseWithRegexOne(NewsParserService::$PATTERN_GET_TITLE,$html,"title");
        $imgs = $this->parseWithRegexMany(NewsParserService::$PATTERN_GET_IMGS,$html,2,"imgs");
        $imgs = array_map(fn($item)=>$this->mainUrl.$item,$imgs);
        $texts = $this->parseWithRegexMany(NewsParserService::$PATTERN_GET_TEXTS,$html,2,"texts");
        $texts = array_map(fn($it)=>strip_tags($it),$texts);
        $date = $this->parseWithRegexOne(NewsParserService::$PATTERN_GET_DATE,$html,"date");
        return new NewsDto($imgs,$title,implode("\n",$texts),$date);

    }

}
