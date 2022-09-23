import std/[locks, os, random, strutils, json], puppy

createDir("./hentai")
var i = 0
proc download(): void =
    while true:
        randomize()
        let urls = [
            "https://api.waifu.pics/many/nsfw/waifu", 
            "https://api.waifu.pics/many/nsfw/neko", 
            "https://api.waifu.pics/many/nsfw/blowjob"
        ]
        var rdmurl = sample(urls)
        try:
            let
                body = %*{
                    "referer": "https://waifu.pics/"
                }
                req = Request(
                    url: parseUrl(rdmurl),
                    verb: "POST",
                    headers: @[Header(
                        key: "Content-Type",
                        value: "application/json"
                    )],
                    body: $body
                )
                res = parseJson(fetch(req).body)
            for stuff in res["files"]:
                let
                    JsonResponse = $stuff
                    url = JsonResponse[1 .. ^2]
                    fileName = "./hentai/" & url.split("/")[3]
                    res2 = fetch(url)
                writeFile(fileName, res2)
                i += 1
                echo i, " Hentai Fetched!"
        except Exception:
            discard

discard os.execShellCmd("clear")
echo "Thread amount? (Warning that shit is fast asf)"
var thread: string = readLine(stdin)
var cLock: Lock
initLock(cLock)
var t: Thread[void]

for i in 0..thread.parseInt:
    createThread[void](t, download)

joinThreads(t)