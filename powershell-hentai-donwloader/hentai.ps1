$hentai = @(
    "https://api.waifu.pics/nsfw/waifu",
    "https://api.waifu.pics/nsfw/neko",
    "https://api.waifu.pics/nsfw/blowjob"
)
if (Test-Path -Path "./hentai") {
    Write-Host "Scraping started"
} else {
    New-Item -Type Directory -Name "hentai"
}
$downloader = New-Object System.Net.WebClient
function Download-Hentai {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$url,
        [Parameter()]
        [String]$path
    )
    switch -Exact ($url) {
        {$url.EndsWith(".png")} {$end = "png"; break}
        {$url.EndsWith(".jpg")} {$end = "jpg"; break}
        {$url.EndsWith(".jpeg")} {$end = "jpeg"; break}
        {$url.EndsWith(".gif")} {$end = "gif"; break}
    }
    $downloader.DownloadFile($url, "$path.$end")
}
function Get-Hentai {
    foreach ($links in $hentai) {
        $jsonhentai = (Invoke-WebRequest -Uri $links | ConvertFrom-Json).url
        $name = $jsonhentai.split("/")[3]
        Download-Hentai -url $jsonhentai -path "./hentai/$name"
    }
}
$i = 1
while ($true) {
    Get-Hentai
    Write-Host "Downloaded $i hentai"
    $i++
}


