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
    var client = new HttpClient();
    var response = await client.GetAsync("https://api.waifu.pics/nsfw/waifu");
    response.EnsureSuccessStatusCode();
    string responseBody = await response.Content.ReadAsStringAsync();
    dynamic cc = JObject.Parse(responseBody);
    string thisURL = cc.url;
    string format = thisURL.Split(".").Last();
    var negr = new WebClient();
    negr.DownloadFile(new Uri(thisURL), @"./hentai/" + i + "." + format);
}
Console.WriteLine(number + " Hentai Downloaded.");
Console.ReadLine();