class HentaiDownloader 
    def initialize
        i = 0
        t = Time.now
        require 'rubygems'
        require 'mechanize'
        require 'json'

        _agent = Mechanize.new
        agent = Mechanize.new
        links = [ "https://nekobot.xyz/api/image?type=hentai", "https://api.waifu.pics/nsfw/waifu", "https://api.waifu.pics/nsfw/neko", "https://api.waifu.pics/nsfw/blowjob" ]
        link = links.sample

        response = _agent.get(link).body
        
        if link.include? "waifu" then
            url = JSON.parse(response)["url"]
        else  
            url = JSON.parse(response)["message"]
        end

        splitLink = url.split("/")
        name = splitLink[splitLink.length - 1]
        agent.get(url).save "Hentai/" + name
        i += 1
        puts "Downloaded " + String(i) + " Hentai in " + String(Time.now - t) + " Seconds"
        
    end
  end
  
while true
    HentaiDownloader.new
end