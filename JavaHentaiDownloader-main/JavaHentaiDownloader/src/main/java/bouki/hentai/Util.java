package src.main.java.bouki.hentai;

import java.io.*;
import java.net.*;
import org.json.*;
import java.util.Random;
public class Util {
    public static String getUrlToDownload(String urL) throws Exception {

        StringBuilder result = new StringBuilder();
        URL url = new URL(urL);

        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("GET");
        conn.setRequestProperty("User-Agent", "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36");

        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(conn.getInputStream()))) {
            for (String line; (line = reader.readLine()) != null;) {
                result.append(line);
            }
        }

        JSONObject json = new JSONObject(result.toString());

        if (urL.contains("nekobot")) return (String) json.get("message");
        else return (String) json.get("url");
    }

    public static void download(String url, String path) throws Exception {

        URL URI = new URL(url);
        HttpURLConnection connect = (HttpURLConnection) URI.openConnection();

        connect.setRequestProperty("User-Agent", "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36");

        String code = String.valueOf(connect.getResponseCode());
        if (code.equals(304)) {
            System.out.println("Error While Downlaoding Hentai.");
            return;
        }

        InputStream in = connect.getInputStream();
        OutputStream out = new FileOutputStream(path);

        int c;
        byte[] b = new byte[1024];

        while ((c = in.read(b)) != -1) out.write(b, 0, c);

        in.close();
        out.close();
    }
    public static void clearConsole() throws Exception {
        if (System.getProperty("os.name").contains("Windows")) new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
        else Runtime.getRuntime().exec("clear");
    }
    public static void changeTitle() throws Exception {
        if (System.getProperty("os.name").contains("Windows")) new ProcessBuilder("cmd", "/c", "title = JavaHentaiDownloader").inheritIO().start().waitFor();
        else Runtime.getRuntime().exec("title = JavaHentaiDownloader");
    }
    public static String Color(String type) {
        String RESET = "\033[0m";  // Text Reset
        String RED = "\033[0;31m";     // RED
        String GREEN = "\033[0;32m";   // GREEN
        String YELLOW = "\033[0;33m";  // YELLOW
        String BLUE = "\033[0;34m";    // BLUE
        String PURPLE = "\033[0;35m";  // PURPLE
        String CYAN = "\033[0;36m";    // CYAN
        if (type == "RESET") return RESET;
        String[] n = { GREEN, YELLOW, RED, BLUE, CYAN, PURPLE};
        int rnd = new Random().nextInt(n.length);
        return n[rnd];
    }
}
