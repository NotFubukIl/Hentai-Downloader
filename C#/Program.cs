using System;
using System.Linq;
using System.Text;
using Newtonsoft.Json.Linq;
using System.Net;
using System.IO;



if (!Directory.Exists("./hentai"))
{
    Directory.CreateDirectory("./hentai");
}
int number;
Console.Write("Enter The Wanted Number Of Hentai Pics: ");
number = Convert.ToInt32(Console.ReadLine());
for (int i = 1; i <= number; i++) {
    Random e = new Random();
    string[] array = { "https://nekobot.xyz/api/image?type=hentai", "https://api.waifu.pics/nsfw/waifu", "https://api.waifu.pics/nsfw/neko", "https://api.waifu.pics/nsfw/blowjob" };
    string url = array[e.Next(0, 4)];
    var client = new HttpClient();
    var response = await client.GetAsync(url);
    response.EnsureSuccessStatusCode();
    string responseBody = await response.Content.ReadAsStringAsync();
    dynamic cc = JObject.Parse(responseBody);
    Console.WriteLine(cc);
    string thisURL;
    if (url.Contains("waifu"))
    {
        thisURL = cc.url;
    }
    else
    {
        thisURL = cc.message;
    }
    string format = thisURL.Split("/").Last();
    var negr = new WebClient();
    negr.DownloadFile(new Uri(thisURL), @"./hentai/" + format);
}
Console.WriteLine(number + " Hentai Downloaded.");
Console.ReadLine(); 
