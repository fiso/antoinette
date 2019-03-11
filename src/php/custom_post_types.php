<?php

function create_post_types() {
    acf_add_options_page(array(
        'page_title' => 'Site options',
        'menu_title' => 'Site options',
        'menu_slug' => 'globals',
        'capability'=> 'edit_posts',
        'redirect' => false
    ));
    acf_add_options_page(array(
        'page_title' => 'OG & Meta-tags',
        'menu_title' => 'OG & Meta-tags',
        'menu_slug' => 'og-meta-settings',
        'capability'=> 'edit_posts',
        'redirect' => false
    ));
    register_post_type('acme_product',
        array(
        'labels' => array(
            'name' => __('Products'),
            'singular_name' => __('Product')
        ),
        'public' => true,
        'has_archive' => true,
        )
    );
}

add_action('init', 'create_post_types');
