import std/[json, os, random, strutils, locks], puppy

createDir("./hentai")
var i = 0
proc download(): void {.thread.} =
    while true:
        try:
            randomize()
            let urlArray = [
                "https://api.waifu.pics/nsfw/blowjob",
                "https://api.waifu.pics/nsfw/waifu",
                "https://api.waifu.pics/nsfw/neko",
                "https://nekobot.xyz/api/image?type=hentai"
            ]
            var urlRandom = sample(urlArray)
            let 
                req = Request(
                    url: parseUrl(urlRandom),
                    verb: "GET",
                    headers: @[Header(
                        key: "Content-Type",
                        value: "application/json"
                    )]
                )
                res = fetch(req).body
                JsonResponse = if "waifu.pics" in urlRandom: $parseJson(res)["url"] else: $parseJson(res)["message"]
                url = JsonResponse[1 .. ^2]
                fileName = if "waifu.pics" in urlRandom: "./hentai/" & $url.split("/")[3] else: "./hentai/" & $url.split("/")[6]
                res2 = fetch(url)
            writeFile(fileName, res2)
            i += 1
            echo i, " Hentai Downloaded !"
        except Exception:
            discard

discard os.execShellCmd("clear")
echo "Thread amount?"
var thread: string = readLine(stdin)
var cLock: Lock
initLock(cLock)
var t: Thread[void]

for i in 0..thread.parseInt:
    createThread[void](t, download)

joinThreads(t)
