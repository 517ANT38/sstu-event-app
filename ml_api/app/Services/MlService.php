<?php
namespace App\Services;
use Rubix\ML\Datasets\Labeled;
use Rubix\ML\Datasets\Unlabeled;
use Rubix\ML\Loggers\Screen;
use Rubix\ML\PersistentModel;
use Rubix\ML\Pipeline;
use Rubix\ML\Transformers\TextNormalizer;
use Rubix\ML\Transformers\WordCountVectorizer;
use Rubix\ML\Tokenizers\NGram;
use Rubix\ML\Transformers\TfIdfTransformer;
use Rubix\ML\Transformers\ZScaleStandardizer;
use Rubix\ML\Classifiers\MultilayerPerceptron;
use Rubix\ML\NeuralNet\Layers\Dense;
use Rubix\ML\NeuralNet\Layers\Activation;
use Rubix\ML\NeuralNet\Layers\PReLU;
use Rubix\ML\NeuralNet\Layers\BatchNorm;
use Rubix\ML\NeuralNet\ActivationFunctions\LeakyReLU;
use Rubix\ML\NeuralNet\Optimizers\AdaMax;
use Rubix\ML\Persisters\Filesystem;
use Rubix\ML\Extractors\CSV;
use Rubix\ML\CrossValidation\Reports\AggregateReport;
use Rubix\ML\CrossValidation\Reports\ConfusionMatrix;
use Rubix\ML\CrossValidation\Reports\MulticlassBreakdown;
class MlService implements MlServiceInterface{

    private PersistentModel $estimator;

    public function __construct()
    {
        if(file_exists('sentiment.rbx')){
            $this->estimator = PersistentModel::load(new Filesystem('sentiment.rbx'));
        }
        else
            $this->estimator = new PersistentModel(
                new Pipeline([
                    new TextNormalizer(),
                    new WordCountVectorizer(5000, 2, 0.1, new NGram(1, 2)),
                    new TfIdfTransformer(),
                    new ZScaleStandardizer(),
                ], new MultilayerPerceptron([
                    new Dense(100),
                    new Activation(new LeakyReLU()),
                    new Dense(100),
                    new Activation(new LeakyReLU()),
                    new Dense(100, 0.0, false),
                    new BatchNorm(),
                    new Activation(new LeakyReLU()),
                    new Dense(50),
                    new PReLU(),
                    new Dense(50),
                    new PReLU(),
                ], 256, new AdaMax(0.0001))),
                new Filesystem('sentiment.rbx',true)
            );
        $this->estimator->setLogger(new Screen());
    }

    public function train(Labeled $dataset){
        $this->estimator->train($dataset);

        $extractor = new CSV('progress.csv', true);

        $extractor->export($this->estimator->steps());
        $this->estimator->save();
    }
    public function validate(Labeled $dataset){
        $predictions = $this->estimator->predict($dataset);
        $report = new AggregateReport([
            new MulticlassBreakdown(),
            new ConfusionMatrix(),
        ]);
        $results = $report->generate($predictions, $dataset->labels());
        $results->toJSON()->saveTo(new Filesystem('report.json'));
    }
    public function predict(Unlabeled $dataset){
        return current($this->estimator->predict($dataset));
    }
}
