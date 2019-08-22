<?php

$remote = 'http://localhost:9090';
$strip_from_request = $_SERVER['SCRIPT_NAME'];

error_log('===========================');
$request_path = str_replace($strip_from_request, '', $_SERVER['REQUEST_URI']);
error_log('> ' . $request_path);

function make_request($url) {
    global $remote;
    $response = file_get_contents(
        $remote . $url,
        FALSE,
        stream_context_create([
            'http' => ['ignore_errors' => TRUE],
        ])
    );

    return [
        'headers' => $http_response_header,
        'body' => $response,
    ];
}

function present_result($result) {
    error_log('sending response');
    foreach ($result['headers'] as $header) {
        header($header);
    }
    header_remove('link');
    echo $result['body'];
}

if (!class_exists('Redis')) {
    error_log('redis unavailable');
    present_result(make_request($request_path));
    exit(0);
}

$redis = new Redis();
$redis->connect('127.0.0.1');

$cached = $redis->get($request_path);
if ($cached === FALSE) {
    error_log('cache miss');
    $result = make_request($request_path);
} else {
    error_log('cache hit');
    $result = json_decode($cached, TRUE);
}

present_result($result);

if ($cached === FALSE) {
    error_log('writing result to redis');
    $redis->set($request_path, json_encode($result));
}
