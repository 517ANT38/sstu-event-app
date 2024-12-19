<?php

namespace App\Providers;


use App\Repositories\NewsRepository;
use Illuminate\Support\ServiceProvider;
use App\Repositories\NewsRepositoryInterface;
use App\Repositories\RequestEventRepository;
use App\Repositories\RequestEventRepositoryInterface;


class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(NewsRepositoryInterface::class,NewsRepository::class);
        $this->app->bind(RequestEventRepositoryInterface::class,RequestEventRepository::class);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
    }
}
