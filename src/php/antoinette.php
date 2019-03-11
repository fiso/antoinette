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

add_filter('acf/format_value/type=wysiwyg', 'acf_apply_post_content_filter', 20, 3);
function acf_apply_post_content_filter($value, $post_id, $field) {
    if (is_user_logged_in()) {
        return $value;
    }
    return apply_filters('the_content', $value);
}

add_filter('acf/format_value/type=relationship', 'acf_relationship_filter', 20, 3);
function acf_relationship_filter($value, $post_id, $field) {
    if (is_user_logged_in()) {
        return $value;
    }

    $result = array();
    if (is_array($value) && count($value) > 0) {
        foreach ($value as $idx => $id_or_obj) {
            // var_dump($id);
            if (is_object($id_or_obj)) {
                $id = $id_or_obj->ID;
            } else {
                $id = $id_or_obj;
            }
            $relationship_post = get_post($id);
            $result[] = array(
                'title' => $relationship_post->post_title,
                'type' => $relationship_post->post_type,
                'postId' => $id,
                'content' => $relationship_post->post_content,
                'fields' => get_fields($id)
            );
        }
    }

    return $result;
}

add_filter('acf/format_value/type=post_object', 'acf_postobject_filter', 20, 3);
function acf_postobject_filter($value, $post_id, $field) {
    if (is_user_logged_in()) {
        return $value;
    }

    // multiple values?
    if (is_array($value)) {
        $result = array();

        if (count($value) <= 0) {
            return $result;
        }

        foreach ($value as $id_or_obj) {
            if (is_object($id_or_obj)) {
                $relationship_post = $id_or_obj;
            } else {
                $relationship_post = get_post($id_or_obj);
            }
            $result[] = array(
                'title' => $relationship_post->post_title,
                'type' => $relationship_post->post_type,
                'postId' => $relationship_post->ID,
                'content' => $relationship_post->post_content,
                'fields' => get_fields($relationship_post->ID)
            );
        }
        return $result;
    }
    /* single value */
    else {
        if (is_object($value)) {
            $relationship_post = $value;
        } else {
            $relationship_post = get_post($value);
        }

        if (!$relationship_post) {
            return null;
        }

        return array(
            'title' => $relationship_post->post_title,
            'type' => $relationship_post->post_type,
            'postId' => $relationship_post->ID,
            'content' => $relationship_post->post_content,
            'fields' => get_fields($relationship_post->ID)
        );
    }
}

function get_options(WP_REST_Request $request) {
    $options = get_fields('options');
    return json_response(array(
        'options' => $options,
    ));
}

function get_page_by_slug(WP_REST_Request $request) {
    $slug = $request['slug'];

    if ($slug == "frontpage") {
        $frontpage_id = get_option('page_on_front');
        $page_object = get_post($frontpage_id);
    } else {
        $page_object = get_page_by_path($slug, OBJECT, 'page');
    }

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
        var_dump($sections);
        exit;
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
