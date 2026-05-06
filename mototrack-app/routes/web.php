<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\SparepartController;
use App\Http\Controllers\ServiceLogController;

Route::get('/', function () { return view('welcome');});

// Rute Sparepart
Route::get('/spareparts', [SparepartController::class, 'index']);
Route::get('/spareparts/create', [SparepartController::class, 'create']);
Route::post('/spareparts', [SparepartController::class, 'store']);
Route::get('/spareparts/{id}/edit', [SparepartController::class, 'edit']);
Route::put('/spareparts/{id}', [SparepartController::class, 'update']);
Route::delete('/spareparts/{id}', [SparepartController::class, 'destroy']);

// Rute service
Route::get('/services', [ServiceLogController::class, 'index']);
Route::get('/services/create', [ServiceLogController::class, 'create']);
Route::post('/services', [ServiceLogController::class, 'store']);
Route::get('/services/{id}/edit', [ServiceLogController::class, 'edit']);
Route::put('/services/{id}', [ServiceLogController::class, 'update']);
Route::delete('/services/{id}', [ServiceLogController::class, 'destroy']);
