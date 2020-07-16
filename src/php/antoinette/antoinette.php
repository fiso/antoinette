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

function sanitize_fields ($obj, $field_object) {
    return array_map(function ($item) use (&$field_object) {
        foreach ($field_object['layouts'] as $id => $layout) {
            if ($layout['name'] === $item['acf_fc_layout']) {
                foreach ($layout['sub_fields'] as $sub_field) {
                    // ACF delivers a repeater with zero children as 'false'
                    // because "fuck you that's why".
                    // Here we look for those (empty repeaters) and change them
                    // to an empty array, which objectively makes more sense.
                    if ($sub_field['type'] === 'repeater') {
                        if ($item[$sub_field['name']] === false) {
                            $item[$sub_field['name']] = array();
                        }
                    }
                }
            }
        }
        return $item;
    }, $obj);
}

function format_page_object ($page_object) {
    return array(
        'page' => [
            'title' => $page_object->post_title,
            'postId' => $page_object->ID,
            'type' => $page_object->post_type,
            'modified' => $page_object->post_modified,
            'published' => $page_object->post_date,
            'sections' => sanitize_fields(
                get_field('sections', $page_object->ID),
                get_field_object('sections', $page_object->ID),
            ),
        ],
        'options' => get_all_options(),
    );
}

function get_page_by_id(WP_REST_Request $request) {
    $id = $request['id'];
    $page_object = get_post($id);

    if ($page_object && $page_object->post_status === 'publish') {
        return json_response(format_page_object($page_object));
    } else {
        return new WP_Error('antoinette_no_page', 'No such page', array( 'status' => 404 ) );
    }
}

function get_page_by_slug(WP_REST_Request $request) {
    $slug = $request['slug'];

    if ($slug === 'frontpage') {
        $frontpage_id = get_option('page_on_front');
        $page_object = get_post($frontpage_id);
    } else {
        $page_object = get_page_by_path($slug, OBJECT, 'page');
    }

    if ($page_object && $page_object->post_status === 'publish') {
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

/*
    Rewrite "page link" field to use relative url
*/
function acf_pagelink_filter($value, $post_id, $field) {
    if (is_user_logged_in()) {
        return $value;
    }
    $slug = parse_url($value, PHP_URL_PATH);
    return $slug;
}
add_filter('acf/format_value/type=page_link', 'acf_pagelink_filter', 20, 3);

/*
    Rewrite all permalinks to use relative urls
*/
function filter_permalink_for_frontend($url, $post) {
    $slug = parse_url($url, PHP_URL_PATH);
    $frontend_url = get_field('general', 'option')['frontend_base_url'];
    if (is_user_logged_in()) {
        return $frontend_url . $slug;
    }
    return $slug;
}
add_filter('post_type_link', 'filter_permalink_for_frontend', 10, 2);

/*
    Rewrite all permalinks for backend, when admin wants to preview etc.
*/
function rewrite_permalink_for_backend($url, $post) {
    $frontend_url = get_field('general', 'option')['frontend_base_url'];
    $slug = parse_url($url, PHP_URL_PATH);
    if (is_user_logged_in()) {
        return $frontend_url . $slug;
    }
    return $slug;
}
add_filter('page_link', 'rewrite_permalink_for_backend', 10, 2);
add_filter('post_link', 'rewrite_permalink_for_backend', 10, 2);
