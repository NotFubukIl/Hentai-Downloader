package bouki.hentaiDownloader;

import okhttp3.*;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class Downloader {
    private int Count;

    public Downloader() {
    }

    public void GetHentai(String Url) throws Exception {
        JSONObject body = HttpGet(Url);
        String img = Url.contains("waifu.pics") ? body.getString("url") : body.getString("message");
        String name = img.split("/")[img.split("/").length - 1];
        DownloadImage(img, ".\\hentai\\" + name);
        Count++;
        System.out.println("[+] Downloaded " + Count + " Hentai");
    }

    public void GetAlternativeHentai(String Url) throws Exception {
        JSONObject hentai = HttpPost(Url);
        for (Object h : hentai.getJSONArray("files")) {
            String name = h.toString().split("/")[3];
            DownloadImage(h.toString(), ".\\hentai\\" + name);
            Count++;
            System.out.println("[+] Downloaded " + Count + " Hentai");
        }
    }

    public JSONObject HttpGet(String Url) {
        JSONObject result;
        OkHttpClient client = new OkHttpClient();
        Request req = new Request.Builder()
                .url(Url)
                .build();
        try (Response res = client.newCall(req).execute()) {
            assert res.body() != null;
            result = new JSONObject(res.body().string());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    public List<String> ListDir() {
        List<String> fileList = new ArrayList<>();
        File directory = new File(".\\hentai\\");
        File[] files = directory.listFiles();
        assert files != null;
        for (File file : files) {
            if (file.isFile()) {
                String fileName = file.getName();
                fileList.add(fileName);
            }
        }

        return fileList;
    }

    private JSONObject HttpPost(String Url) {
        JSONObject result;
        JSONArray excludeFiles = new JSONArray();
        for (String file : ListDir()) {
            excludeFiles.put(file);
        }
        MediaType JSON = MediaType.get("application/json");
        JSONObject payload = new JSONObject();
        payload.append("referer", "https://waifu.pics");
        payload.append("exclude", excludeFiles.toString());
        RequestBody body = RequestBody.create(JSON, payload.toString());
        OkHttpClient client = new OkHttpClient();
        Request req = new Request.Builder()
                .url(Url)
                .post(body)
                .build();
        try (Response res = client.newCall(req).execute()) {
            assert res.body() != null;
            result = new JSONObject(res.body().string());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    private static void DownloadImage(String url, String path) throws Exception {

        URL URI = new URL(url);
        HttpURLConnection connect = (HttpURLConnection) URI.openConnection();

        connect.setRequestProperty("User-Agent", "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36");

        String code = String.valueOf(connect.getResponseCode());
        if (code.equals("304")) {
            System.out.println("Error While Downloading Hentai.");
            return;
        }

        InputStream in = connect.getInputStream();
        OutputStream out = Files.newOutputStream(Paths.get(path));

        int c;
        byte[] b = new byte[1024];

        while ((c = in.read(b)) != -1) out.write(b, 0, c);

        in.close();
        out.close();
    }
}
