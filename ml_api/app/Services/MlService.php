<?php
namespace App\Services;
use Rubix\ML\Pipeline;
use Rubix\ML\Extractors\CSV;
use Rubix\ML\Loggers\Screen;
use Rubix\ML\PersistentModel;
use Rubix\ML\Datasets\Labeled;
use Rubix\ML\Tokenizers\NGram;
use Rubix\ML\Datasets\Unlabeled;
use Rubix\ML\Persisters\Filesystem;
use Illuminate\Support\Facades\Storage;
use Rubix\ML\NeuralNet\Layers\Dense;
use Rubix\ML\NeuralNet\Layers\PReLU;
use Rubix\ML\NeuralNet\Layers\BatchNorm;
use Rubix\ML\NeuralNet\Layers\Activation;
use Rubix\ML\NeuralNet\Optimizers\AdaMax;
use Rubix\ML\Transformers\TextNormalizer;
use Rubix\ML\Transformers\TfIdfTransformer;
use Rubix\ML\Transformers\ZScaleStandardizer;
use Rubix\ML\Classifiers\MultilayerPerceptron;
use Rubix\ML\Transformers\WordCountVectorizer;
use Rubix\ML\CrossValidation\Reports\AggregateReport;
use Rubix\ML\CrossValidation\Reports\ConfusionMatrix;
use Rubix\ML\NeuralNet\ActivationFunctions\LeakyReLU;
use Rubix\ML\CrossValidation\Reports\MulticlassBreakdown;

class MlService implements MlServiceInterface{

    private PersistentModel $estimator;
    private string $path;

    public function __construct()
    {
        $this->path = storage_path('app');
        Storage::makeDirectory('reports');
        $filesystem = new Filesystem("$this->path/sentiment.rbx");
        if(file_exists("$this->path/sentiment.rbx")){
            $this->estimator = PersistentModel::load($filesystem);
        }
        else
            $this->estimator = new PersistentModel(
                new Pipeline([
                    new TextNormalizer(),
                    new WordCountVectorizer(10000, 2, 0.1, new NGram(1, 2)),
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
                ], 256, new AdaMax(0.0003))),
                $filesystem
            );
        $this->estimator->setLogger(new Screen());
    }

    public function train(Labeled $dataset){
        $this->estimator->train($dataset);

        $extractor = new CSV("$this->path/reports/progress.csv", true);

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
        $results->toJSON()->saveTo(new Filesystem("$this->path/reports/report.json"));
    }
    public function predict(Unlabeled $dataset){
        return current($this->estimator->predict($dataset));
    }
}
