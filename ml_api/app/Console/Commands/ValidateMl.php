<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Services\MlService;
use Rubix\ML\Datasets\Labeled;

class ValidateMl extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:validate-ml';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'validate ml';

    /**
     * Execute the console command.
     */
    public function handle(MlService $serv)
    {
        $samples = $labels = [];
        $path = storage_path('app/files');
        foreach (['positive', 'negative'] as $label) {
            foreach (glob("$path/test/$label/*.txt") as $file) {
                $samples[] = [file_get_contents($file)];
                $labels[] = $label;
            }
        }

        $dataset = Labeled::build($samples, $labels)->randomize()->take((int)(count($labels)*0.8));
        $serv->validate($dataset);
    }
}
