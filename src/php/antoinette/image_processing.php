<?php

add_image_size('x_wide', 1440, 1440);
add_image_size('xx_wide', 1600, 1600);
add_image_size('xxx_wide', 2000, 2000);
add_image_size('xxxx_wide', 3000, 3000);
add_image_size('xxxxx_wide', 4000, 4000);

add_filter('wp_generate_attachment_metadata', 'compress_image', 10, 2);
function compress_image($image_data, $file) {
    if ($image_data) {
        $base_path = 'wp-content/uploads/' . dirname($image_data['file']) . '/';
        wp_schedule_single_event(time(), 'perform_compression', ['wp-content/uploads/' . $image_data['file']]);
        foreach ($image_data['sizes'] as $size) {
            wp_schedule_single_event(time(), 'perform_compression', [$base_path . $size['file']]);
        }
    } elseif ($file) {
        $path = get_attached_file($file);
        if (strrpos($path, '.') !== -1) {
            $ending = strtolower(substr($path, strrpos($path, '.') + 1));
            if ($ending === 'svg') {
                wp_schedule_single_event(time(), 'perform_compression', [$path]);
            }
        }
    }

    return $image_data;
}

add_action('perform_compression', 'perform_compression_in_place');
function perform_compression_in_place($path) {
    $ending = strtolower(substr($path, strrpos($path, '.') + 1));

    try {
        if ($ending === 'jpg' || $ending === 'jpeg') {
            $webpPath = substr($path, 0, strrpos($path, '.') + 1) . 'webp';
            exec('cwebp ' . $path . ' -q 90 -o ' . $webpPath);
        } elseif ($ending === 'png') {
            exec('pngquant ' . $path . ' -f --skip-if-larger --ext ".png"');
        } elseif ($ending === 'svg') {
            exec('svgo ' . $path);
        }
    } catch (Exception $e) {
        error_log('Compression failed for ' . $path);
        error_log($e);
    }
}
