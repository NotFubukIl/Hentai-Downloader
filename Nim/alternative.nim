import std/[os, strutils, json, httpclient]

proc download(): void =
    var 
        urls: seq[string] = @[
            "https://api.waifu.pics/many/nsfw/waifu", 
            "https://api.waifu.pics/many/nsfw/neko", 
            "https://api.waifu.pics/many/nsfw/blowjob"
        ]
        i: int = 0
    while true:
        for url in urls:
            try:
                let
                    client = newHttpClient()
                    body = %*{
                        "referer": "https://waifu.pics/",
                        "exclude": []
                    }
                    
                    res = parseJson(client.request(url, HttpPost, $body).body)
                if res.hasKey("message"):
                    raise newException(Exception, res{"message"}.getStr())
                for stuff in res["files"].getElems():
                    let
                        content = client.request(stuff.getStr(), HttpGet)
                    writeFile(stuff.getStr().split("/")[stuff.getStr().split("/").high], content.body)
                    i += 1
                    echo "[+] Downloaded " & $i & " Hentai"
            except Exception:
                discard

when isMainModule:
    createDir("./hentai")
    download()