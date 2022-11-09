https = require "https"
fs = require "fs"

i = 1
hentaiArray = ["https://nekobot.xyz/api/image?type=hentai", "https://api.waifu.pics/nsfw/waifu", "https://api.waifu.pics/nsfw/neko", "https://api.waifu.pics/nsfw/blowjob"]

download = (url) ->
    file = url.split "/" 
    write = fs.createWriteStream "./Hentai/" + file.pop()
    https.get url, (data) ->
        data.pipe write
    await write.on "finish", () ->
        console.log (i++) + " Hentai Downloaded"
    return "a"


if !fs.existsSync "./Hentai"
    fs.mkdirSync("./Hentai");


main = ->
    link = hentaiArray[Math.floor Math.random() * hentaiArray.length]
    data = ""

    await https.get link, (data) ->
        data.on "data", (chunk) -> 
            json = JSON.parse chunk.toString()
        
            b = await download json.url ? json.message

setInterval ->
    main()
, 3000