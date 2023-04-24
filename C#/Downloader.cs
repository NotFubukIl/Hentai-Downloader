using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace Hentai;

public class HentaiPayload
{
    public string referer { get; set; }
    public List<string> exclude { get; set; }
    
    public HentaiPayload(string referer, List<string> exclude)
    {
        this.referer = referer;
        this.exclude = exclude;
    }
}

public class Downloader
{
    private string _url;
    private int _count = 0;

    public Downloader(string url)
    {
        _url = url;
    }
    
    public async Task GetHentai()
    {
        var client = new HttpClient();
        var response = client.GetAsync(_url);
        var body = await response.Result.Content.ReadAsStringAsync();
        dynamic res = JObject.Parse(body);
        string img = _url.Contains("waifu.pics") ? res["url"].ToString() : res["message"].ToString();
        await DownloadImage(img);
        _count++;
        Console.WriteLine($"Downloaded {_count} hentai");
    }

    public async Task GetAlternativeHentai()
    {
        var client = new HttpClient();
        var exclude = new List<string>();
        Directory.GetFiles("./hentai").ToList().ForEach(x => exclude.Add(x.Split("\\").Last()));
        var payload = new HentaiPayload("https://waifu.pics", exclude);
        var response = client.PostAsync(_url, new StringContent(JsonConvert.SerializeObject(payload), Encoding.UTF8, "application/json"));
        var body = await response.Result.Content.ReadAsStringAsync();
        dynamic res = JObject.Parse(body);
        var img = res["files"];
        foreach (var hentai in img)
        {
            await DownloadImage(hentai.ToString());
            _count++;
            Console.WriteLine($"Downloaded {_count} hentai");
        }
    }

    private static async Task DownloadImage(string url)
    {
        var hc = new HttpClient();
        var rs = hc.GetByteArrayAsync(url).Result;
        var format = url.Split("/").Last();
        await using var writer = new BinaryWriter(File.OpenWrite($".\\hentai\\{format}"));
        writer.Write(rs);
        writer.Close();
    }
}