using System;
using System.Linq;
using System.Text;
using Newtonsoft.Json.Linq;
using System.Net;
using System.IO;

namespace HentaiDownloader {
    static class Downloader {
        static void Main() {
            if (!Directory.Exists("./hentai")) {
                Directory.CreateDirectory("./hentai");
            }
            int number;
            Console.Write("\x1b[32mEnter The Wanted Number Of Hentai Pics: \x1b[0m");
            number = Convert.ToInt32(Console.ReadLine());
            for (int i = 0; i <= number; i++) {
                var client = new HttpClient();
                var response = await client.GetAsync("https://api.waifu.pics/nsfw/waifu");
                response.EnsureSuccessStatusCode();
                string responseBody = await response.Content.ReadAsStringAsync();
                dynamic cc = JObject.Parse(responseBody);
                string thisURL = cc.url;
                string format = thisURL.Split(".").Last();
                var negr = new WebClient();
                negr.DownloadFile(new Uri(thisURL), @"./hentai/" + i);
            }
            Console.WriteLine("\x1b[35m" + number + " Hentai Downloaded.\x1b[0m");
            Console.ReadLine();
        }
    }
};