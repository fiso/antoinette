<?php

function json_response($json_content) {
    return new WP_REST_Response(
        array_map(convert_keys_to_camel_case, $json_content),
        200,
        array('Content-Type' => 'application/json')
    );
}

function convert_keys_to_camel_case($apiResponseArray) {
    $arr = [];

    if(!is_array($apiResponseArray)) {
        return $apiResponseArray;
    }

    foreach ($apiResponseArray as $key => $value) {
        $key = strtolower($key);
        $key = lcfirst(implode('', array_map('ucfirst', explode('_', $key))));

        if (is_array($value)) {
            $value = convert_keys_to_camel_case($value);
        }

        $arr[$key] = $value;
    }
    return $arr;
}

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

// acf/load_value/type={$field_type} - filter for a value load based on it's field type
add_filter('acf/load_value/type=wysiwyg', 'acf_apply_post_content_filter', 10, 3);
function acf_apply_post_content_filter($value, $post_id, $field) {
    return apply_filters('the_content', $value);
}



function get_options(WP_REST_Request $request) {
    $options = get_fields('options');
    return json_response(array(
        'options' => $options,
    ));
}

function get_page_by_slug(WP_REST_Request $request) {
    $slug = $request['slug'];
    $page_object = get_page_by_path($slug, OBJECT, 'page');

    if ($page_object && $page_object->post_status == 'publish') {
        return json_response(array(
            'title' => $page_object->post_title,
            'postId' => $page_object->ID,
            'sections' => get_field('sections', $page_object->ID),
        ));
    } else {
        return new WP_Error('antoinette_no_page', 'No such page', array( 'status' => 404 ) );
    }
}

function get_page_by_id(WP_REST_Request $request) {
    $id = $request['id'];
    $page_object = get_post($id);

    if ($page_object && $page_object->post_status == 'publish') {
        $sections = get_field('sections', $id);
        return json_response(array(
            'title' => $page_object->post_title,
            'postId' => $page_object->ID,
            'sections' => $sections,
        ));
    } else {
        return new WP_Error('antoinette_no_page', 'No such page', array( 'status' => 404 ) );
    }
}

function get_all_pages(WP_REST_Request $request) {
    return json_response(get_pages());
}
