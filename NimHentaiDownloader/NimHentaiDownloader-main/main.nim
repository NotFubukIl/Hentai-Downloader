import puppy
import std/[json, os, random, strutils, locks]

createDir("./hentai")
var i = 0
proc download(): void {.thread.} =
    while true:
        try:
            let urlArray = [
                "https://api.waifu.pics/nsfw/blowjob",
                "https://api.waifu.pics/nsfw/waifu",
                "https://api.waifu.pics/nsfw/neko",
                "https://nekobot.xyz/api/image?type=hentai"
            ]
            var urlRandom = sample(urlArray)
            let req = Request(
                url: parseUrl(urlRandom)
            )
            let res = fetch(req).body
            let JsonResponse = if "waifu.pics" in urlRandom: $parseJson(res)["url"] else: $parseJson(res)["message"]
            let url = JsonResponse[1 .. ^2]
            let fileName = if "waifu.pics" in urlRandom: "./hentai/" & $url.split("/")[3] else: "./hentai/" & $url.split("/")[6]
            let res2 = fetch(url)
            writeFile(fileName, res2)
            i += 1
            echo i, " Hentai Downloaded !"
        except Exception:
            discard

var t: Thread[void]

for i in 0..150:
    createThread[void](t, download)

joinThreads(t)
