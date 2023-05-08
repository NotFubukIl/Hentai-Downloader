const fetch = require("node-fetch")
const fs = require("fs")
var urls = [
    "https://nekobot.xyz/api/image?type=hentai",
    "https://api.waifu.pics/nsfw/waifu",
    "https://api.waifu.pics/nsfw/neko",
    "https://api.waifu.pics/nsfw/blowjob"
]
if (!fs.existsSync("Hentai")) fs.mkdirSync("Hentai");

;(async function main(){
    while (true) {
        var url = urls[Math.floor(Math.random() * 4)]
        fetch(url).then(x => x.json()).then(download)
        await new Promise(x => setTimeout(x, 1200))
    }
})() 
var i = 1
function download(json) {
    if (json.url) var link = json.url
    else var link = json.message
    fetch(link).then(x => {
        var Name = link.split("/").pop()
        var stream = fs.createWriteStream("./Hentai/" + Name)
        x.body.pipe(stream)
        x.body.on("error", err => console.error(err));
        stream.on("finish", x => console.log(`${i++} Hentai Downloaded`));
    })
}