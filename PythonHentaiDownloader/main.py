import requests,os,random
from threading import active_count, Thread

URLS = [ "https://nekobot.xyz/api/image?type=hentai", "https://api.waifu.pics/nsfw/waifu", "https://api.waifu.pics/nsfw/neko", "https://api.waifu.pics/nsfw/blowjob" ]

if not os.path.exists("./Hentai"): os.mkdir("./Hentai")


def main():
    url = random.choice(URLS)

    res = requests.get(url)
    res = res.json()

    if "waifu" in url: link = res["url"]
    else: link = res["message"]

    s = link.split("/")
    Name = s.pop()

    try:
        response = requests.get(link)

        with open(f"./Hentai/{Name}", "wb") as f:
            response.raise_for_status()
            for ch in response.iter_content(1024):
                f.write(ch)
            print("+1 Hentai Downloaded")
    except Exception: pass
    
for _ in iter(int, 1):
    while True:
        if (active_count() <= 15):
            Thread( target = main ).start()
            break