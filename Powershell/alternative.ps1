$hentai = @(
    "https://api.waifu.pics/many/nsfw/waifu", 
    "https://api.waifu.pics/many/nsfw/neko", 
    "https://api.waifu.pics/many/nsfw/blowjob"
)

if ((Test-Path -Path "./hentai") -eq $false) {
    New-Item -Type Directory -Name "hentai"
}

$i = 1
function Get-Hentai {
    foreach ($links in $hentai) {
        $files = @()
        foreach ($file in (Get-ChildItem -Path "./hentai/" -Include "*.*")) {
            $files.Add($file)
        }
        $payload = @{
            "referer" = "https://waifu.pics/"
            "exclude" = ($files | ConvertTo-Json -Depth 3)
        }
        $list = (Invoke-WebRequest -Uri $links -Method "POST" -Body ($payload | ConvertTo-Json -Depth 3) | ConvertFrom-Json -Depth 3).files
        foreach ($img in $list) {
            $name = $img.split("/")[3]
            $dest = ".\hentai\$name"
            Start-BitsTransfer -Source $img -Destination $dest
            $i += 1
            Write-Host "Downloaded $i hentai"
        }
    }
}
while ($true) {
    Get-Hentai
}
