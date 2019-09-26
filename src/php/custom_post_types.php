<?php

function create_post_types() {
    acf_add_options_page(array(
        'page_title' => 'Site options',
        'menu_title' => 'Site options',
        'menu_slug' => 'globals',
        'capability'=> 'edit_posts',
        'redirect' => false
    ));
}

add_action('init', 'create_post_types');
