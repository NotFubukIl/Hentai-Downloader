Set http = CreateObject("MSXML2.XMLHTTP")
Set sc = CreateObject("MSScriptControl.ScriptControl")
Set fs = CreateObject("Scripting.FileSystemObject")

sc.Language = "JScript"

Dim urls
urls = Array("https://nekobot.xyz/api/image?type=hentai", "https://api.waifu.pics/nsfw/waifu", "https://api.waifu.pics/nsfw/neko", "https://api.waifu.pics/nsfw/blowjob")

Function GetHentai(url)
    
    http.Open "GET", url, False
    http.Send
    res = sc.eval("(" & http.responseText & ")")
    Dim img
    If InStr(url, "waifu.pics") > 0 Then
        img = res.url
    Else
        img = res.message
    End If

    http.Open "GET", img, False
    http.Send

    image = http.responseBody
    filename = UBound(Split(img, "/"))
    Set outfile = fs.CreateTextFile(".\hentai\" & filename, True)
    outfile.Write image
    outfile.Close()

End Function


GetHentai(urls(0))