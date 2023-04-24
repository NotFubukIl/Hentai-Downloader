var urls = [
    "https://nekobot.xyz/api/image?type=hentai",
    "https://api.waifu.pics/nsfw/waifu",
    "https://api.waifu.pics/nsfw/neko",
    "https://api.waifu.pics/nsfw/blowjob"
]
var count = 0;

function getHentai(url) {
    var xhr = new ActiveXObject("MSXML2.XMLHTTP");
    xhr.open("GET", url, false);
    xhr.send();
    var res = eval("(" + xhr.responseText + ")")
    var img = url.indexOf("waifu.pics") !== -1 ? res.url : res.message
    var filename = img.split("/")[img.split("/").length - 1]
    downloadImage(img, ".\\hentai\\" + filename)
    count++;
    WScript.Echo("Downloaded " + count + " Hentai")
}

function downloadImage(url, path) {
    var xhr = new ActiveXObject("MSXML2.XMLHTTP");
    xhr.open("GET", url, false)
    xhr.send()
    if (xhr.status == 200) {
        var stream = new ActiveXObject("ADODB.Stream");
        stream.Type = 1;
        stream.Open();
        stream.Write(xhr.responseBody);
        stream.SaveToFile(path, 2);
        stream.Close();
    }
}

var fs = new ActiveXObject("Scripting.FileSystemObject")
if (!fs.FolderExists(".\\hentai\\")) fs.CreateFolder(".\\hentai\\")

while (true) {
    for (var i = 0; i < urls.length; i++) {
        getHentai(urls[i])
    }
}