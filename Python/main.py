import requests,os
from concurrent.futures import ThreadPoolExecutor

URLS = [
    "https://nekobot.xyz/api/image?type=hentai",
    "https://api.waifu.pics/nsfw/waifu",
    "https://api.waifu.pics/nsfw/neko",
    "https://api.waifu.pics/nsfw/blowjob"
]

if not os.path.exists("./Hentai"): os.mkdir("./Hentai")

i = 0

def main():
    while True:
        for url in URLS:
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
                i += 1
                print(f"Downloaded {i} hentai")
            except Exception: pass
    
pool = ThreadPoolExecutor(10)
for _ in range(10):
    pool.submit(main)