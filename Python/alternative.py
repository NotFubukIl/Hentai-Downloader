from genericpath import exists
import requests,os,random,sys
from concurrent.futures import ThreadPoolExecutor
url = [
    "https://api.waifu.pics/many/nsfw/waifu",
    "https://api.waifu.pics/many/nsfw/neko",
    "https://api.waifu.pics/many/nsfw/blowjob"
]
if not exists("./hentai"): os.mkdir("./hentai")
def download(url):
    filename = url.split('/')[3]
    try:
        with requests.get(url, stream=True) as r:
            r.raise_for_status()
            with open(f'./hentai/{filename}', 'wb') as f:
                for ch in r.iter_content(1024):
                    f.write(ch)
    except Exception:
        pass

def getHentai(url):
    i = 0
    exclusion = os.listdir('./hentai')
    datas = {
        "exclude": exclusion,
        "referer": "https://waifu.pics/"
    }
    r = requests.post(url, data=datas)
    match r.status_code:
        case 200:
            images = r.json()
            for stuff in images["files"]:
                download(stuff)
                i += 30
                print(f"[+] Downloaded {i} hentai")
        case _:
            print('[-] Error')

def randomize():
    getHentai(random.choice(url))

def clear():
    match sys.platform:
        case "windows":
            os.system("cls")
        case "linux":
            os.system("clear")

clear()
threads = int(input("Threads: "))
pool = ThreadPoolExecutor(threads)
for _ in range(threads):
    pool.submit(randomize)