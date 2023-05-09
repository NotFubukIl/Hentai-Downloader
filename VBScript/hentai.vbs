Const ForReading = 1
Const ForWriting = 2
Const TriStateUseDefault = -2

set FileSystemObject = CreateObject("Scripting.FileSystemObject")

Dim hentai
hentai = Array("https://api.waifu.pics/nsfw/waifu", "https://api.waifu.pics/nsfw/neko", "https://api.waifu.pics/nsfw/blowjob")

If Not FileSystemObject.FolderExists("hentai") Then
    Set hentaiFolder = FileSystemObject.CreateFolder("hentai")
End If

Set webClient = CreateObject("WinHttp.WinHttpRequest.5.1")
i = 1

Function GetHentai()
    For Each link In hentai
        webClient.Open "GET", link, False
        webClient.Send
        url = Split(webClient.ResponseText, """url"":""")(1)
        url = Split(url, """")(0)
        name = Split(url, "/")(UBound(Split(url, "/")))
        webClient.Open "GET", url, False
        webClient.Send
        Set stream = CreateObject("ADODB.Stream")
        stream.Type = 1 'binary
        stream.Open
        stream.Write webClient.ResponseBody
        stream.SaveToFile ".\hentai\" & name, ForWriting
        stream.Close
        Set stream = Nothing
        i = i + 1
        WScript.Echo "Downloaded " & i & " hentai"
    Next
End Function

While True
    GetHentai
Wend