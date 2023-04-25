package bouki.hentaiDownloader;

import java.io.Console;
import java.io.File;
import java.util.Objects;

public class Hentai {

    public static void main(String[] args) throws Exception {
        String[] URLS = {
                "https://nekobot.xyz/api/image?type=hentai",
                "https://api.waifu.pics/nsfw/waifu",
                "https://api.waifu.pics/nsfw/neko",
                "https://api.waifu.pics/nsfw/blowjob"
        };
        String[] alternativeUrls = {
                "https://api.waifu.pics/many/nsfw/waifu",
                "https://api.waifu.pics/many/nsfw/neko",
                "https://api.waifu.pics/many/nsfw/blowjob"
        };
        File dir = new File(".\\hentai\\");
        if (!dir.exists()) {
            boolean t = dir.mkdir();
        }
        if (System.getProperty("os.name").contains("Windows")) new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
        else Runtime.getRuntime().exec("clear");

        Console cs = System.console();
        assert cs != null;

        String choice = cs.readLine("normal or alternative generation mode (alternative is faster) (1/2): ");

        Downloader download = new Downloader();
        while (true) {
            if (Objects.equals(choice, "1")) {
                for (String url : URLS) {
                    download.GetHentai(url);
                }
            } else {
                for (String url : alternativeUrls) {
                    download.GetAlternativeHentai(url);
                }
            }
        }
    }

}
