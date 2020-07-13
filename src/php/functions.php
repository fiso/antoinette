<?php

function get_static_base_path() {
    return get_template_directory_uri();
}

function sa_sanitize_chars($filename) {
    return strtolower(preg_replace('/[^a-zA-Z0-9-_\.]/', '', $filename));
}
add_filter('sanitize_file_name', 'sa_sanitize_chars', 10);

function antoinette_setup() {
    add_theme_support('title-tag');
    add_theme_support('post-thumbnails');
    register_nav_menus(
        array('main-menu' => __('Main Menu', 'antoinette'))
    );
}
add_action('after_setup_theme', 'antoinette_setup');

function add_mime_types($mimes) {
    $mimes['svg'] = 'image/svg+xml';
    $mimes['svgz'] = 'image/svg+xml';
    return $mimes;
}
add_filter('upload_mimes', 'add_mime_types');

include('custom_post_types.php');
include('antoinette/antoinette.php');
