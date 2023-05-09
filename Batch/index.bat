@echo off
setlocal EnableDelayedExpansion

set links[0]=https://api.waifu.pics/nsfw/waifu
set links[1]=https://api.waifu.pics/nsfw/neko
set links[2]=https://api.waifu.pics/nsfw/blowjob

if not exist "Hentai" mkdir Hentai

set /a i=0

:loop
for /L %%n in (0,1,2) do (
    for /f "tokens=*" %%i in ('curl -s "!links[%%n]!" ^| jq -r ".url"') do (
        set "img=%%i"
        for /f "tokens=3 delims=/" %%j in ("!img!") do (
            set "Name=%%j"
            call :download "!img!" "hentai\!Name!"
        )
    )
)

set /a i+=3
echo Downloaded %i% hentai

goto :loop

:download
curl -s "%~1" > "%~2"
goto :eof