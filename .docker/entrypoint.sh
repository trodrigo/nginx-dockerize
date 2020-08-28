#!/bin/bash

dockerize -template ./.docker/app/.env:.env -wait tcp://db:3306

composer install

php artisan key:generate
php artisan migrate

php-fpm
