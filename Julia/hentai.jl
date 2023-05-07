using HTTP, FileIO, JSON

URLS = [
    "https://nekobot.xyz/api/image?type=hentai",
    "https://api.waifu.pics/nsfw/waifu",
    "https://api.waifu.pics/nsfw/neko",
    "https://api.waifu.pics/nsfw/blowjob"
]

if !isdir("./Hentai")
    mkdir("./Hentai")
end

i = 0

function main(i)
    while true
        for url in URLS
            res = HTTP.get(url)
            res = JSON.parse(String(res.body))
            println(res)
            if occursin("waifu", url)
                link = res["url"]
            else
                link = res["message"]
            end
            s = split(link, "/")
            Name = pop!(s)
            try
                download(link, "./Hentai/$Name")
                i += 1
                println("Downloaded $i hentai")
            catch e
                @show e
            end
        end
    end
end

main(i)
