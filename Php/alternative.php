<?php

$urls = [
    "https://api.waifu.pics/many/nsfw/waifu",
    "https://api.waifu.pics/many/nsfw/neko",
    "https://api.waifu.pics/many/nsfw/blowjob"
];
function downloadImage($url, $path) {
    $data = file_get_contents($url);
    file_put_contents($path, $data);
}

function httppost($url, $data) {
    $options = array(
        'http' => array(
            'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
            'method'  => 'POST',
            'content' => http_build_query($data)
        )
    );
    $context  = stream_context_create($options);
    return file_get_contents($url, false, $context);
}

if (!file_exists("./hentai/")) {
    mkdir("./hentai");
}
$downloaded = 0;
while (true) {
    foreach ($urls as $url) {
        $data = [
            "exclude" => array_diff(scandir("./hentai/"), array(".", "..")),
            "referer" => "https://waifu.pics/"
        ];
        $data = httppost($url, $data);
        $files = json_decode($data, true)["files"];
        foreach ($files as $file) {
            downloadImage($file, "./hentai/" . (explode("/", $file)[3]));
            echo "[+] Downloaded " . $downloaded . " hentai" . PHP_EOL;
            $downloaded++;
        }
    }
}