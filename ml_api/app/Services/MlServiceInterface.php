<?php
namespace App\Services;
use Rubix\ML\Datasets\Labeled;
use Rubix\ML\Datasets\Unlabeled;
interface MlServiceInterface{
    function train(Labeled $dataset);
    function validate(Labeled $dataset);
    function predict(Unlabeled $dataset);
}
