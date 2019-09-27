<?php

add_filter('get_image_tag_class', '__return_empty_string');

remove_action('wp_head', '_wp_render_title_tag', 1);

function mytheme_admin_bar_render() {
    global $wp_admin_bar;
    $wp_admin_bar->remove_menu('comments');
}
add_action('wp_before_admin_bar_render', 'mytheme_admin_bar_render');

function remove_menus() {
    remove_post_type_support('post', 'comments');
    remove_post_type_support('page', 'comments');
    remove_menu_page('index.php');
    remove_menu_page('edit.php');
    remove_menu_page('edit-comments.php');
    remove_menu_page('themes.php');
    remove_menu_page('users.php');
    remove_menu_page('tools.php');
    remove_submenu_page('options-general.php', 'privacy.php');
    remove_submenu_page('options-general.php', 'options-writing.php');
    remove_submenu_page('options-general.php', 'options-reading.php');
    remove_submenu_page('options-general.php', 'options-discussion.php');
    remove_submenu_page('options-general.php', 'options-media.php');

    if (current_user_can('update_core')) {
        return;
    }

    remove_menu_page('edit.php?post_type=acf-field-group');
    remove_menu_page('plugins.php');
}
add_action('admin_menu', 'remove_menus');

function remove_core_updates() {
    global $wp_version;
    return(object) array('last_checked'=> time(),'version_checked'=> $wp_version);
}
remove_action('wp_version_check', 'wp_version_check');
remove_action('wp_update_plugins', 'wp_update_plugins');
remove_action('wp_update_themes', 'wp_update_themes');
add_filter('pre_site_transient_update_core', 'remove_core_updates'); // hide updates for WordPress itself
add_filter('pre_site_transient_update_plugins', 'remove_core_updates'); // hide updates for all plugins
add_filter('pre_site_transient_update_themes', 'remove_core_updates'); // hide updates for all themes

function wpdocs_dequeue_dashicon() {
    if (current_user_can('update_core')) {
        return;
    }
    wp_deregister_style('dashicons');
}
add_action('wp_enqueue_scripts', 'wpdocs_dequeue_dashicon');

function my_deregister_styles() {
    wp_deregister_style('dashicons');
}
add_action('wp_print_styles', 'my_deregister_styles', 100);

function disable_admin_bar() {
    add_filter('show_admin_bar', '__return_false');
}
add_action('init', 'disable_admin_bar', 1);

// Remove admin bar and inline style from body to push content down
function remove_admin_bar_from_head() {
    remove_action('wp_head', '_admin_bar_bump_cb');
    show_admin_bar(false);
}
add_action('get_header', 'remove_admin_bar_from_head');

 // Remove the horrible bloat that is "wp emojis"
function disable_wp_emojicons() {
    remove_action('admin_print_styles', 'print_emoji_styles');
    remove_action('wp_head', 'print_emoji_detection_script', 7);
    remove_action('admin_print_scripts', 'print_emoji_detection_script');
    remove_action('wp_print_styles', 'print_emoji_styles');
    remove_filter('wp_mail', 'wp_staticize_emoji_for_email');
    remove_filter('the_content_feed', 'wp_staticize_emoji');
    remove_filter('comment_text_rss', 'wp_staticize_emoji');
}
add_action('init', 'disable_wp_emojicons');

function my_deregister_scripts() {
    wp_deregister_script('wp-embed');
}
add_action('wp_footer', 'my_deregister_scripts');
