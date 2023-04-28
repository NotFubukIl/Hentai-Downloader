import net.http
import os
import x.json2
import term
import time

const urls = [
    'https://api.waifu.pics/many/nsfw/waifu',
    'https://api.waifu.pics/many/nsfw/neko',
    'https://api.waifu.pics/many/nsfw/blowjob'
]

fn main() {
	if !os.exists('./hentai') { os.mkdir('./hentai')! }
	mut total := 0
	for {
		for url in urls {
			resp := http.post_json(url, '{"exclude":[],"referer":"https://waifu.pics/"}') or { eprintln(err) continue }
			obj := json2.raw_decode(resp.body) or { eprintln(err) continue }

			for link in obj.as_map()['files'].arr() {
				gif := http.get(link.str()) or { eprintln(err) continue }

				mut file := os.open_append('./hentai/${link.str().after('/')}') or { eprintln(err) continue }
				file.write(gif.body.bytes()) or { eprintln(err) continue }

				total++
				print('scraped $total hentai\r')
				flush_stdout()
			}
		}
	}
}

