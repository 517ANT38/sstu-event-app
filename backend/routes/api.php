<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\NewsController;
use App\Http\Controllers\RequestEventController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('news/{universityСode}',[NewsController::class,'showNewsHeaders']);
Route::get('news/url/{url?}',[NewsController::class,'showNew'])->where("url","(.*)");
Route::post("events/create",[RequestEventController::class,'create']);
Route::post("events/",[RequestEventController::class,'show']);
