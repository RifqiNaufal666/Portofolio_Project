<?php

use Illuminate\Support\Facades\Route;
use function Laravel\Prompts\form;
use App\Http\Controllers\HomeController;

Route::get('/', function () {
    return view('home');
});

Route::get('/produk', [HomeController::class, 'index'])->name('produk.index');


