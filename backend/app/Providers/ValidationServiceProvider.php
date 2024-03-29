<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class ValidationServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap the application services.
     *
     * @return void
     */
    public function boot()
    {
        //

        $this->app['validator']->extend('composite_unique', function ($attribute, $value, $parameters, $validator) {
            // Custom validation logic

            // remove first parameter and assume it is the table name
            $table = array_shift( $parameters ); 

            // start building the conditions
            $fields = [ $attribute => $value ]; // current field, company_code in your case

            // iterates over the other parameters and build the conditions for all the required fields
            while ( $field = array_shift( $parameters ) ) {
                $fields[ $field ] = \Request::get( $field );
            }
            // dd($fields);
            // query the table with all the conditions
            $result = \DB::table( $table )->select( \DB::raw( 1 ) )->where( $fields )->first();

            return empty( $result );
        }, trans('validation.username_unique'));
    }

    /**
     * Register the application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }
}