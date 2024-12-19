<?php

namespace App\Http\Controllers;

use App\Http\Requests\NewTextRequest;
use App\Services\MlService;
use Rubix\ML\Datasets\Unlabeled;

class CheckNewController extends Controller
{
    public function __construct(
        private MlService $service
    ){}
    public function checkNewText(NewTextRequest $req){
        $data = $req->validated();
        $dataset = new Unlabeled([
            [$data['text']],
        ]);
        $resultCheck = $this->service->predict($dataset);
        return response()->json(['result'=>$resultCheck]);
    }
}
