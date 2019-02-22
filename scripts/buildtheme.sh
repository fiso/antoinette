#!/bin/bash

mkdir -p build/wp-content/themes/akademi
cp -R src/php/* build/wp-content/themes/akademi
cp -R src/meta/wp-theme-meta/* build/wp-content/themes/akademi
cp -R src/plugins/* build/wp-content/plugins
cp -R src/webroot/* build/ 2>/dev/null || :
cp src/wp-config.php build
