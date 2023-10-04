<?php


$defaultConfig = require 'defaults.php';

$localConfig = file_exists(__DIR__ . '/local.php') ? require __DIR__ . '/local.php' : [];

// fusion of 2 tables
$config = array_merge($defaultConfig, $localConfig);

// getenv() = getting env. variable
$config['host'] = getenv('PH_PORTAIL_MYSQL_HOST') ?: $config['host'];
$config['dbname'] = getenv('PH_PORTAIL_MYSQL_DBNAME') ?: $config['dbname'];
$config['user'] = getenv('PH_PORTAIL_MYSQL_USER') ?: $config['user'];
$config['password'] = getenv('PH_PORTAIL_MYSQL_PASSWORD') ?: $config['password'];


return $config;
