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
    register_rest_route('antionette', '/pages(?:/(?P<id>\d+))?', array(
        'methods' => 'GET',
        'callback' => 'get_site_page',
    ));
});

// $options = get_fields('options');

function get_site_page(WP_REST_Request $request) {
    $id = $request['id'];

    if ($id) {
        return json_response(array(
            'sections' => get_field('sections', $id),
        ));
    } else {
        return json_response(get_pages());
    }
}
