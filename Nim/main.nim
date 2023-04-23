import std/[json, os, strutils, httpclient]

var 
    i: int = 0
    urls: seq[string] = @[
        "https://api.waifu.pics/nsfw/blowjob",
        "https://api.waifu.pics/nsfw/waifu",
        "https://api.waifu.pics/nsfw/neko",
        "https://nekobot.xyz/api/image?type=hentai"
    ]

proc download(): void =
    var client = newHttpClient()
    for url in urls:
        let
            res = client.request(url, HttpGet)
            parsed = parseJson(res.body)
            image = if "waifu.pics" in url: parsed["url"].getStr() else: parsed["message"].getStr()
            imagedata = client.request(image, HttpGet)
        writeFile((getCurrentDir() / "hentai" / image.split("/")[image.split("/").high]), imagedata.body)
        inc i
        echo "[+] Downloaded " & $i & " hentai"


when isMainModule:
    discard os.execShellCmd(when defined(windows): "cls" else: "clear")
    createDir("./hentai/")
    while true:
        download()