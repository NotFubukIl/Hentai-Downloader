#!/usr/bin/elvish
use str

var urls = [
    'https://api.waifu.pics/nsfw/waifu'
    'https://api.waifu.pics/nsfw/neko'
    'https://api.waifu.pics/nsfw/blowjob'
    'https://nekobot.xyz/api/image?type=hentai'
]

mkdir -p ./hentai
var total = 0

while $true {
  for url $urls {
    var body = (curl $url 2>/dev/null | from-json)
    var link = (try { put $body[url]} catch e { put $body[message] })

    curl $link 2>/dev/null > ./hentai/(echo [(str:split / $link)][-1])
    set total = (+ $total 1)
    /usr/bin/echo -n scraped $total hentai "\r"
  }
}