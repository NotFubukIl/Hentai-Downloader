$hentai = @(
    "https://api.waifu.pics/nsfw/waifu",
    "https://api.waifu.pics/nsfw/neko",
    "https://api.waifu.pics/nsfw/blowjob"
)
if ((Test-Path -Path "./hentai") -eq $false) {
    New-Item -Type Directory -Name "hentai"
}
$downloader = New-Object System.Net.WebClient
$i = 1

function Get-Hentai {
    foreach ($links in $hentai) {
        $jsonhentai = (Invoke-WebRequest -Uri $links | ConvertFrom-Json).url
        $name = $jsonhentai.split("/")[3]
        Start-BitsTransfer -Source $links -Destination ".\hentai\$name" -Asynchronous
        $i += 1
        Write-Host "Downloaded $i hentai"
    }
}
while ($true) {
    Get-Hentai
}


