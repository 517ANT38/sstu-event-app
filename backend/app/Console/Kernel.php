<?php

namespace App\Console;

use App\Services\NewsParser;
use Exception;
use GrahamCampbell\ResultType\Error;
use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;
use Illuminate\Support\Facades\Http;
use Symfony\Component\ErrorHandler\ThrowableUtils;

class Kernel extends ConsoleKernel
{


    protected function schedule(Schedule $schedule): void
    {

    }

    /**
     * Register the commands for the application.
     */
    protected function commands(): void
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }
}
