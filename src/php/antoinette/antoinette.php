<?php

/*
    Do not add your project-specific functionality here. Add it to
    [projectname].php and include that
*/

include('strip_wp_bloat.php');
include('image_processing.php');
include('cache_hooks.php');

add_action('rest_api_init', function () {
    register_rest_route('antoinette', '/pages/id/(?P<id>\d+)', array(
        'methods' => 'GET',
        'callback' => 'get_page_by_id',
    ));

    register_rest_route('antoinette', '/pages/slug/(?P<slug>\S+)', array(
        'methods' => 'GET',
        'callback' => 'get_page_by_slug',
    ));

    register_rest_route('antoinette', '/pages', array(
        'methods' => 'GET',
        'callback' => 'get_all_pages',
    ));

    register_rest_route('antoinette', '/options', array(
        'methods' => 'GET',
        'callback' => 'get_options',
    ));
});

function json_response($json_content) {
    return new WP_REST_Response(
        array_map('convert_keys_to_camel_case', $json_content),
        200,
        array('Content-Type' => 'application/json')
    );
}

function snake_to_camel ($string) {
    return lcfirst(str_replace('-', '', ucwords($string, '-')));
}

function convert_keys_to_camel_case($api_response_array) {
    $arr = [];

    if (!is_array($api_response_array)) {
        return $api_response_array;
    }

    foreach ($api_response_array as $key => $value) {
        $key = strtolower($key);
        $key = lcfirst(implode('', array_map('ucfirst', explode('_', $key))));

        if (is_array($value)) {
            $value = convert_keys_to_camel_case($value);
        }

        $arr[$key] = $value;
    }
    return $arr;
}

function get_all_options () {
    $options = get_fields('options') ?: new ArrayObject();
    $options['site_title'] = get_bloginfo('name');
    return $options;
}

function format_page_object ($page_object) {
    return array(
        'page' => [
            'title' => $page_object->post_title,
            'postId' => $page_object->ID,
            'type' => $page_object->post_type,
            'modified' => $page_object->post_modified,
            'published' => $post->post_date,
            'sections' => get_field('sections', $page_object->ID),
        ],
        'options' => get_all_options(),
    );
}

function get_page_by_id(WP_REST_Request $request) {
    $id = $request['id'];
    $page_object = get_post($id);

    if ($page_object && $page_object->post_status == 'publish') {
        return json_response(format_page_object($page_object));
    } else {
        return new WP_Error('antoinette_no_page', 'No such page', array( 'status' => 404 ) );
    }
}

function get_page_by_slug(WP_REST_Request $request) {
    $slug = $request['slug'];

    if ($slug == 'frontpage') {
        $frontpage_id = get_option('page_on_front');
        $page_object = get_post($frontpage_id);
    } else {
        $page_object = get_page_by_path($slug, OBJECT, 'page');
    }

    if ($page_object && $page_object->post_status == 'publish') {
        return json_response(format_page_object($page_object));
    } else {
        return new WP_Error('antoinette_no_page', 'No such page', array( 'status' => 404 ) );
    }
}

function get_all_pages(WP_REST_Request $request) {
    return json_response(get_pages());
}

function get_options(WP_REST_Request $request) {
    return json_response(array(
        'options' => get_all_options(),
    ));
}
