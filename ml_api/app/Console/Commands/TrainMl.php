<?php

namespace App\Console\Commands;

use App\Services\MlService;
use Rubix\ML\Datasets\Labeled;
use Illuminate\Console\Command;

class TrainMl extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:train-ml';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'train ml';

    /**
     * Execute the console command.
     */
    public function handle(MlService $serv)
    {
        $samples = $labels = [];
        $path = storage_path('app');
        foreach (['positive', 'negative'] as $label) {
            foreach (glob("$path/train/$label/*.txt") as $file) {
                $samples[] = [file_get_contents($file)];
                $labels[] = $label;
            }
        }

        $dataset = new Labeled($samples, $labels);
        $serv->train($dataset);
    }
}
