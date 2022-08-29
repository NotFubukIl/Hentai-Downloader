package src.main.java.bouki.hentai;

import java.io.*;
import java.util.Random;
public class main {

    public static void main(String[] args) throws Exception {
        Util.clearConsole();
        Util.changeTitle();
        int i = 1;
        String[] URLS = {"https://nekobot.xyz/api/image?type=hentai", "https://api.waifu.pics/nsfw/waifu", "https://api.waifu.pics/nsfw/neko", "https://api.waifu.pics/nsfw/blowjob"};

        while (true) {
            String n = URLS[new Random().nextInt(URLS.length)];
            String url = Util.getUrlToDownload(n);

            String[] FileName = url.split("/");
            String fileName = FileName[FileName.length - 1];

            File file = new File("./Hentai");
            String Path = file + "/" + fileName;

            if (!file.exists()) file.mkdir();

            Util.download(url, Path);
            System.out.println(Util.Color("RANDOM") + i++ + " Hentai Downloaded." + Util.Color("RESET"));
        }

    }

}
