<?php

use Illuminate\Support\Facades\Route;



Route::get('/', function () {
    return view('welcome');
});


// Route::get('/', function () {
//     dispatch(new ExampleJob());
//     return 'Job dispatched!';
// });