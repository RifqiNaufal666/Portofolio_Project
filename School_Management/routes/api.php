<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\gurucontroller;
use App\Http\Controllers\muridcontroller;
use App\Http\Controllers\mapelcontroller;
use App\Http\Controllers\authController;

Route::post('/register', [authController::class, 'register']);
Route::post('/login', [authController::class, 'login']);
Route::get('/guru', [gurucontroller::class, 'index']);
Route::get('/murid', [muridcontroller::class, 'index']);
Route::get('/mapel', [mapelcontroller::class, 'index']);

Route::middleware('auth:sanctum')->group(function () {
    //Logout
    Route::post('/logout', [authController::class, 'logout']);
    //Guru
    Route::post('/guru', [gurucontroller::class, 'store']);
    Route::put('/guru/{id}', [gurucontroller::class, 'update']);
    Route::delete('/guru/{id}', [gurucontroller::class, 'destroy']);
    //Murid
    Route::post('/murid', [muridcontroller::class, 'store']);
    Route::put('/murid/{id}', [muridcontroller::class, 'update']);
    Route::delete('/murid/{id}', [muridcontroller::class, 'destroy']);
    //Mapel
    Route::post('/mapel', [mapelcontroller::class, 'store']);
    Route::put('/mapel/{id}', [mapelcontroller::class, 'update']);
    Route::delete('/mapel/{id}', [mapelcontroller::class, 'destroy']);
});