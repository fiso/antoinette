<?php

add_action('rest_api_init', function () {
    register_rest_route('antoinette', '/pages/slug/(?P<slug>\S+)', array(
        'methods' => 'GET',
        'callback' => 'get_page_by_slug',
    ));
});

function json_response($json_content) {
    return new WP_REST_Response(
        array_map(convert_keys_to_camel_case, $json_content),
        200,
        array('Content-Type' => 'application/json')
    );
}

function convert_keys_to_camel_case($apiResponseArray) {
    $arr = [];

    if (!is_array($apiResponseArray)) {
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

/*
    Apply "the_content" filter for all wysiwyg editors
*/
function acf_apply_post_content_filter($value, $post_id, $field) {
    if (is_user_logged_in()) {
        return $value;
    }
    return apply_filters('the_content', $value);
}
add_filter('acf/format_value/type=wysiwyg', 'acf_apply_post_content_filter', 20, 3);

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
    Rewrite "relationship" field to only include the relevant part of the post, and also the custom fields
*/
function acf_relationship_filter($value, $post_id, $field) {
    if (is_user_logged_in()) {
        return $value;
    }

    $result = array();
    if (is_array($value) && count($value) > 0) {
        foreach ($value as $idx => $id_or_obj) {
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
                'permalink' => get_permalink($relationship_post->ID),
                'fields' => get_fields($id),
                'date'       => array(
                    'y' => get_the_date('Y', $relationship_post),
                    'm' => get_the_date('m  ', $relationship_post),
                    'd' => get_the_date('d', $relationship_post),
                ),
                'categories' => get_all_categories_for_post_id($relationship_post->ID),
                'tags'       => get_all_tags_for_post_id($relationship_post->ID),
            );
        }
    }

    return $result;
}
add_filter('acf/format_value/type=relationship', 'acf_relationship_filter', 20, 3);

/*
    Rewrite "post object" field to only include the relevant part of the post, and also the custom fields
*/
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
                'permalink' => get_permalink($relationship_post->ID),
                'fields' => get_fields($relationship_post->ID),
                'date'       => array(
                    'y' => get_the_date('Y', $relationship_post),
                    'm' => get_the_date('m  ', $relationship_post),
                    'd' => get_the_date('d', $relationship_post),
                ),
                'categories' => get_all_categories_for_post_id($relationship_post->ID),
                'tags'       => get_all_tags_for_post_id($relationship_post->ID),

            );
        }
        return $result;
    } else {
        /* single value */
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
            'permalink' => get_permalink($relationship_post->ID),
            'fields' => get_fields($relationship_post->ID),
            'date'       => array(
                'y' => get_the_date('Y', $relationship_post),
                'm' => get_the_date('m  ', $relationship_post),
                'd' => get_the_date('d', $relationship_post),
            ),
            'categories' => get_all_categories_for_post_id($relationship_post->ID),
            'tags'       => get_all_tags_for_post_id($relationship_post->ID),
        );
    }
}
add_filter('acf/format_value/type=post_object', 'acf_postobject_filter', 20, 3);

/*
    Rewrite all permalinks to use relative urls
*/
function filter_permalink_for_frontend($url, $post) {
    $slug = parse_url($url, PHP_URL_PATH);
    $frontend_url = get_field('antoinette_frontend_url', 'option');

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
    $frontend_url = get_field('antoinette_frontend_url', 'option');
    $slug = parse_url($url, PHP_URL_PATH);

    if (is_user_logged_in()) {
        return $frontend_url . $slug;
    }
    return $url;
}
add_filter('page_link', 'rewrite_permalink_for_backend', 10, 2);
add_filter('post_link', 'rewrite_permalink_for_backend', 10, 2);

/*
    Attempt to get a wordpress post object by slug
*/
function get_page_by_slug(WP_REST_Request $request) {
    $slug = $request['slug'];
    $is_custom_post_type = false;
    $is_preview = false;

    // @TODO: check preview nonce and verify
    /* if (isset($_GET['preview']) && $_GET['preview'] == true) {
        $preview_id = $_GET['preview_id'];
        $page_object = get_post($preview_id);
        $is_preview = true;

        var_dump('hello preview!');
        var_dump($page_object);
        exit;
    } */

    // non-preview
    if (!$page_object) {
        if ($slug == "frontpage") {
            $frontpage_id = get_option('page_on_front');
            $page_object = get_post($frontpage_id);
        } else {
            // loop through all custom post types and see if our slug matches one of them
            $custom_post_types = get_post_types(array('public' => true, '_builtin' => false), 'objects');
            foreach ($custom_post_types as $cpt) {
                if (isset($cpt->rewrite['slug'])) {
                    if (strpos($slug, $cpt->rewrite['slug'].'/') > -1) {
                        $page_object = get_page_by_path(basename(untrailingslashit($slug)), OBJECT, $cpt->name);
                        $is_custom_post_type = true;
                        break;
                    }
                }
            }

            // otherwise just attempt to match a normal post/page
            if (!$page_object) {
                $page_object = get_page_by_path($slug, OBJECT, array('post', 'page'));
            }
        }
    }

    $post_type = $page_object->post_type;
    $post_data = array(
        'title' => $page_object->post_title,
        'id' => $page_object->ID,
        'content' => apply_filters('the_content', $page_object->post_content),
        'date'       => array(
            'y' => get_the_date('Y', $page_object),
            'm' => get_the_date('m  ', $page_object),
            'd' => get_the_date('d', $page_object),
        ),
        'categories' => get_all_categories_for_post_id($page_object->ID),
        'tags'       => get_all_tags_for_post_id($page_object->ID),
    );

    if ($post_type == 'post') {
        $post_data['fields'] = get_fields($page_object->ID);
    }

    if ($is_custom_post_type) {
        $post_type = $page_object->post_type;
        $post_data['fields'] = get_fields($page_object->ID);
        $page_builder_content = apply_filters('antoinette/custom_post_type_rows', $page_object);
    } else {
        $page_builder_content = get_field('page_builder_content', $page_object->ID);
    }

    $options = get_fields('options');

    if (($page_object && $page_object->post_status == 'publish')) {
        $options = apply_filters('antoinette/format_options_data', $options);
        $options['site_title'] = get_bloginfo('name');
        return json_response(array(
            'options' => apply_filters('antoinette/format_options_data', $options),
            'page' => array(
                'page_builder_content' => apply_filters('antoinette/format_rows_data', $page_builder_content),
                'meta' => array(
                    'openGraph' => get_og_tags($page_object)
                ),
                'post_type' => $post_type,
                'post_data' => $post_data,
            ),
        ));
    } else {
        return new WP_Error('antoinette_no_page', 'No such page', array( 'status' => 404));
    }
}

function get_all_tags_for_post_id($id) {
    $post_tags = array();
    $all_post_tags = get_the_tags($id);
    if (is_array($all_post_tags) && count($all_post_tags) > 0) {
        foreach($all_post_tags as $pt) {
            $post_tags[] = array(
                'name' => $pt->name,
                'slug' => $pt->slug,
            );
        }
    }
    return $post_tags;
}

function get_all_categories_for_post_id($id) {
    $post_categories = array();
    $all_post_categories = wp_get_post_categories($id);
    if (is_array($all_post_categories) && count($all_post_categories) > 0) {
        foreach ($all_post_categories as $pc) {
            $cat = get_category($pc);
            $post_categories[] = array(
                'name' => $cat->name,
                'slug' => $cat->slug,
            );
        }
    }
    return $post_categories;
}

function get_all_pages(WP_REST_Request $request) {
    return json_response(get_pages());
}
