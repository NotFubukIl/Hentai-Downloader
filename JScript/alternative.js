var urls = [
    "https://api.waifu.pics/many/nsfw/waifu",
    "https://api.waifu.pics/many/nsfw/neko",
    "https://api.waifu.pics/many/nsfw/blowjob"
]
var count = 0
WScript.Echo("I Suggest you use cscript.exe instead of wscript.exe\n\n")
function getHentai(url) {
    var xhr = new ActiveXObject("MSXML2.XMLHTTP");
    xhr.open("POST", url, false);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send('{"referer":"https://waifu.pics/","exclude":[]}');

    var res = eval("(" + xhr.responseText + ")")
    for (var i = 0; i < res.files.length; i++) {
        var img = res.files[i]
        var filename = img.split("/")[img.split("/").length - 1]
        downloadImage(img, ".\\hentai\\" + filename)
        count++;
        WScript.Echo("[+] Downloaded " + count + " Hentai")
    }
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