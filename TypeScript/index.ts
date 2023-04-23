import {
    createWriteStream,
    mkdirSync,
    existsSync
} from 'fs'
import {
    get
} from 'https';

if (!existsSync("./Hentai")) mkdirSync("./Hentai");


async function download(url: string, filepath: string) {
    await get(url, res => res.pipe(createWriteStream("./Hentai/" + filepath)))
}
var array = ["https://nekobot.xyz/api/image?type=hentai", "https://api.waifu.pics/nsfw/waifu", "https://api.waifu.pics/nsfw/neko", "https://api.waifu.pics/nsfw/blowjob"]


var i = 1

setInterval(() => {
    var link = array[Math.floor(Math.random() * array.length)]
    var data;
    get(link, async res => {
        await res.on("data", chunk => data = JSON.parse(chunk.toString()))
        link = link.includes("waifu") ? data.url : data.message
        var fileName = link.split("/").pop() || "cc"
        download(link, fileName).then(() => console.log(`\x1b[32m[+] Downloaded ${i++} Hentai\x1b[0m`))
    })
}, 1500)