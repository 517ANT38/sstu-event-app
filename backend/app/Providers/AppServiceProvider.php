<?php

namespace App\Providers;


use App\Repositories\NewsRepository;
use Illuminate\Support\ServiceProvider;
use App\Repositories\NewsRepositoryInterface;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(NewsRepositoryInterface::class,NewsRepository::class);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
    }
}
