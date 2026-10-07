<?php

use Illuminate\Support\Facades\Route;

// Uji build cache Docker tugas 4
Route::get('/', function () {
    return view('welcome');
});
