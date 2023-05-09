use std::fs;
use reqwest::blocking::get;
use serde_json::from_str;
use url::Url;

fn main() {
    let urls = vec![
        "https://nekobot.xyz/api/image?type=hentai",
        "https://api.waifu.pics/nsfw/waifu",
        "https://api.waifu.pics/nsfw/neko",
        "https://api.waifu.pics/nsfw/blowjob"
    ];
    if !fs::metadata("./Hentai").is_ok() {
        fs::create_dir("./Hentai").unwrap();
    }
    let mut i = 0;
    loop {
        for url in &urls {
            let res = get(Url::parse(url).unwrap()).unwrap().text().unwrap();
            let res_json: serde_json::Value = from_str(&res).unwrap();
            let link = if url.contains("waifu") {
                res_json["url"].as_str().unwrap()
            } else {
                res_json["message"].as_str().unwrap()
            };
            let name = link.split("/").last().unwrap();
            let response = get(link);
            match response {
                Ok(mut res) => {
                    let mut file = fs::File::create(format!("./Hentai/{}", name)).unwrap();
                    res.copy_to(&mut file).unwrap();
                    i += 1;
                    println!("Downloaded {} hentai", i);
                },
                Err(e) => {
                    println!("{:?}", e);
                }
            }
        }
    }
}