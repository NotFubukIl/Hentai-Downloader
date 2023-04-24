using Hentai;

namespace Hentai;

public class Program
{
    public static void Main()
    {
        if (!Directory.Exists("./hentai"))
        {
            Directory.CreateDirectory("./hentai");
        }
        string[] urls =
        {
            "https://nekobot.xyz/api/image?type=hentai", "https://api.waifu.pics/nsfw/waifu",
            "https://api.waifu.pics/nsfw/neko", "https://api.waifu.pics/nsfw/blowjob"
        };
        string[] alternativeUrls =
        {
            "https://api.waifu.pics/many/nsfw/waifu",
            "https://api.waifu.pics/many/nsfw/neko",
            "https://api.waifu.pics/many/nsfw/blowjob"
        };
        Console.Write("Do you want to download the normal or alternative way (alternative is faster) (1/2): ");
        int choice = 0;
        while (true)
        {
            try
            {
                choice = int.Parse(Console.ReadLine() ?? throw new ArgumentException("Invalid choice"));
                break;
            }
            catch (ArgumentException e)
            {
                Console.WriteLine(e.Message);
            }
        }

        if (choice == 0) return;
        
        while (true)
        {
            foreach (var url in choice == 1 ? urls : alternativeUrls)
            {
                var download = new Downloader(url);
                if (url.Contains("many")) download.GetAlternativeHentai().GetAwaiter().GetResult();
                else download.GetHentai().GetAwaiter().GetResult();
            }
        }
    }
}