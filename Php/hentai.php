<?php
$urls = [
    "https://nekobot.xyz/api/image?type=hentai",
    "https://api.waifu.pics/nsfw/waifu",
    "https://api.waifu.pics/nsfw/neko",
    "https://api.waifu.pics/nsfw/blowjob"
];

function downloadImage($url, $path) {
    $data = file_get_contents($url);
    file_put_contents($path, $data);
}

if (!file_exists("./hentai/")) {
    mkdir("./hentai/");
}

$downloaded = 0;
while (true) {
    foreach ($urls as $url) {
        $data = json_decode(file_get_contents($url), true);
        $img = strpos($url, "waifu") ? $data["url"] : $data["message"];
        $parts = explode('/', $img);
        downloadImage($img, "./hentai/" . end($parts));
        echo "[+] Downloaded " . $downloaded . " hentai" . PHP_EOL;
        $downloaded++;
    }
}