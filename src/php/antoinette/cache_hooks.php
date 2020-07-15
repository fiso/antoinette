<?php

function flush_redis() {
    if (!class_exists('Redis')) {
        return;
    }

    try {
        $redis = new Redis();
        $redis->connect('127.0.0.1');
        $redis->flushAll();
    } catch (Exception $e) {
        error_log('Redis unavailable');
        error_log($e);
    }
}
add_action('save_post', 'flush_redis');
add_action('updated_option', 'flush_redis');
