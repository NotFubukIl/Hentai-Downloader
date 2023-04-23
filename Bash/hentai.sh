#!/usr/bin/env bash
links=("https://api.waifu.pics/nsfw/waifu" "https://api.waifu.pics/nsfw/neko" "https://api.waifu.pics/nsfw/blowjob")
[ ! -d "./hentai" ] && mkdir hentai

function download {
    curl -s "$1" > "$2"
}

function hentai {
    for things in "${links[@]}"; do
        img=$(curl -s "$things" | jq -r '.url')
        IFS='/'
        read -ra thingy <<< "$img"
        download "$img" "./hentai/${thingy[3]}"
    done
}
i=0
while true; do
    hentai
    ((i=i+3))
    echo "Downloaded $i hentai"
done
