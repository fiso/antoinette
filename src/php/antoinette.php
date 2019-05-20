<?php

add_action('rest_api_init', function () {
    register_rest_route('antoinette', '/pages/slug/(?P<slug>\S+)', array(
        'methods' => 'GET',
        'callback' => 'get_page_by_slug',
    ));

    register_rest_route('antoinette', '/posts', array(
        'methods' => 'GET',
        'callback' => 'antoinette_get_posts',
    ));

    register_rest_route('antoinette', '/posts/count', array(
        'methods' => 'GET',
        'callback' => 'antoinette_get_num_posts',
    ));
});

function json_response($json_content) {
    return new WP_REST_Response(
        array_map('convert_keys_to_camel_case', $json_content),
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
            $result[] = format_post($relationship_post);
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
            $result[] = format_post($relationship_post);
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

        return format_post($relationship_post);
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
    return $slug;
}
add_filter('page_link', 'rewrite_permalink_for_backend', 10, 2);
add_filter('post_link', 'rewrite_permalink_for_backend', 10, 2);

/*
    Get the total number of posts of post_type
*/
function antoinette_get_num_posts(WP_REST_Request $request) {
    $post_type = 'post';

    if (isset($_GET['post_type'])) {
        $post_type = $_GET['post_type'];
    }

    $wp_count_posts = wp_count_posts($post_type);

    return json_response(array(
        'num_posts' => intval($wp_count_posts->publish)
    ));
}

/*
    Attempt to get posts with certain parameters for filtering
*/
function antoinette_get_posts(WP_REST_Request $request) {

    $criteria = array(
        'post_type' => 'post',
        'posts_per_page' => -1,
        'post_status' => 'publish',
    );

    if (isset($_GET['post_type'])) {
        $criteria['post_type'] = $_GET['post_type'];
    }

    if (isset($_GET['posts_per_page'])) {
        $criteria['posts_per_page'] = intval($_GET['posts_per_page']);
    }

    if (isset($_GET['offset'])) {
        $criteria['offset'] = intval($_GET['offset']);
    }

    if (isset($_GET['orderby'])) {
        $criteria['orderby'] = $_GET['orderby'];
    }

    if (isset($_GET['order'])) {
        $criteria['order'] = $_GET['order'];
    }

    if (isset($_GET['meta_key'])) {
        $criteria['meta_key'] = $_GET['meta_key'];
    }

    if (isset($_GET['meta_value'])) {
        $criteria['meta_value'] = $_GET['meta_value'];
    }

    if (isset($_GET['include'])) {
        $criteria['include'] = $_GET['include'];
    }

    if (isset($_GET['exclude'])) {
        $criteria['exclude'] = $_GET['exclude'];
    }

    if (isset($_GET['post_parent'])) {
        $criteria['post_parent'] = $_GET['post_parent'];
    }

    if (isset($_GET['category_name'])) {
        $criteria['category_name'] = $_GET['category_name'];
    }

    $posts = get_posts($criteria);

    $result = array();
    foreach ($posts as $post) {
        $result[] = format_post($post);
    }

    $wp_count_posts = wp_count_posts($criteria['post_type']);

    return json_response(array(
        'posts' => $result,
        'num_posts' => intval($wp_count_posts->publish)
    ));
}

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
        $page_builder_content = apply_filters('antoinette/custom_post_type_rows', $page_object);

        // check if no filter was applied

        // this is still a WP post object, means we do not have any page_builder_content
        if (is_object($page_builder_content)) {
            $page_builder_content = array();
        }
        // we somehow got an array but have no default rows, so I guess no page_builder_content
        else if (!isset($page_builder_content['rows_default_rows'])) {
            $page_builder_content = array();
        }
    } else {
        $page_builder_content = get_field('page_builder_content', $page_object->ID);

        // no need to include page builder content twice
        unset($post_data['fields']['page_builder_content']);
    }

    $options = get_fields('options');

    if (($page_object && $page_object->post_status == 'publish')) {
        $options['site_title'] = get_bloginfo('name');
        $options = apply_filters('antoinette/format_options_data', $options);
        return json_response(array(
            'options' => $options,
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

function format_post($post) {
    return array(
        'title'      => $post->post_title,
        'type'       => $post->post_type,
        'postId'     => $post->ID,
        'content'    => apply_filters('the_content', $post->post_content),
        'permalink'  => get_permalink($post->ID),
        'fields'     => get_fields($post->ID),
        'date'       => array(
            'y' => get_the_date('Y', $post),
            'm' => get_the_date('m', $post),
            'd' => get_the_date('d', $post),
        ),
        'categories' => get_all_categories_for_post_id($post->ID),
        'tags'       => get_all_tags_for_post_id($post->ID),
    );
}
