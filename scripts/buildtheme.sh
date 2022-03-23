#!/bin/bash

env=$1

if [ "$env" != "dev" ]; then
  composer install --no-dev
fi

mkdir -p build/wp-content/themes/antoinette
cp -R src/php/* build/wp-content/themes/antoinette
cp -R src/meta/wp-theme-meta/* build/wp-content/themes/antoinette
cp -R src/plugins/* build/wp-content/plugins
cp -R vendor build/wp-content/themes/antoinette
cp -R src/webroot/* build/ 2>/dev/null || :
cp src/wp-config.php build

if [ "$env" != "dev" ]; then
  composer install
fi
