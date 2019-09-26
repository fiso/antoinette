<?php

function flush_redis() {
    if (!class_exists('Redis')) {
        return;
    }

    $redis = new Redis();
    $redis->connect('127.0.0.1');
    $redis->flushAll();
}
add_action('save_post', 'flush_redis');
add_action('updated_option', 'flush_redis');
