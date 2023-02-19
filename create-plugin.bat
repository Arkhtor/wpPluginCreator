@echo off

:: Set the directory where you want to create the plugin
set plugin_dir=%cd%

:: Prompt for the plugin name
set /p plugin_name=Enter plugin name:

:: Create the plugin directory
mkdir %plugin_dir%\%plugin_name%

:: Navigate to the plugin directory
cd %plugin_dir%\%plugin_name%

:: Create the plugin PHP file
echo ^<?php > %plugin_name%.php

:: Add the plugin header information
echo ^/* >> %plugin_name%.php
echo Plugin Name: %plugin_name% >> %plugin_name%.php
echo Plugin URI: # >> %plugin_name%.php
echo Description: >> %plugin_name%.php
echo Version: 1.0 >> %plugin_name%.php
echo Author: Your name >> %plugin_name%.php
echo Author URI: # >> %plugin_name%.php
echo License: GPL2 >> %plugin_name%.php
echo */ >> %plugin_name%.php

:: Create the subdirectories
mkdir admin
mkdir public
mkdir includes
@echo off
:: Create the CSS and JS files
echo /* Add your CSS here */ > public\%plugin_name%-public.css
echo /* Add your JS here */ ^(function($) {

                            	// $ Works! You can test it with next line if you like
                             	// console.log($);

                             ^})( jQuery );> public\%plugin_name%-public.js
echo /* Add your CSS here */ > admin\%plugin_name%-admin.css
echo /* Add your JS here */ ^(function($) {

                            	// $ Works! You can test it with next line if you like
                            	// console.log($);

                             ^})( jQuery );> admin\%plugin_name%-admin.js

:: Create the functions file
echo ^<?php > includes\functions.php

:: Include the functions file and enqueue the CSS and JS files in the main plugin file
echo include_once( plugin_dir_path( __FILE__ ) . 'includes/functions.php' ); >> %plugin_name%.php
echo add_action( 'wp_enqueue_scripts', '%plugin_name%_enqueue_scripts' ); >> %plugin_name%.php
echo function %plugin_name%_enqueue_scripts() { >> %plugin_name%.php
echo   wp_enqueue_style( '%plugin_name%-public', plugins_url( '/public/%plugin_name%-public.css', __FILE__ ) ); >> %plugin_name%.php
echo   wp_enqueue_script( '%plugin_name%-public', plugins_url( '/public/%plugin_name%-public.js', __FILE__ ), array(), '1.0.0', true ); >> %plugin_name%.php
echo } >> %plugin_name%.php
echo add_action( 'admin_enqueue_scripts', '%plugin_name%_admin_enqueue_scripts' ); >> %plugin_name%.php
echo function %plugin_name%_admin_enqueue_scripts() { >> %plugin_name%.php
echo   wp_enqueue_style( '%plugin_name%-admin', plugins_url( '/admin/%plugin_name%-admin.css', __FILE__ ) ); >> %plugin_name%.php
echo   wp_enqueue_script( '%plugin_name%-admin', plugins_url( '/admin/%plugin_name%-admin.js', __FILE__ ), array(), '1.0.0', true ); >> %plugin_name%.php
echo } >> %plugin_name%.php

echo Plugin created successfully!
pause
