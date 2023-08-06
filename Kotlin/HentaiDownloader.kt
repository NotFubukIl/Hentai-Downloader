import io.ktor.client.*
import io.ktor.client.engine.cio.*
import io.ktor.client.request.*
import kotlinx.coroutines.delay
import java.io.File

suspend fun main() {
    val client = HttpClient(CIO)
    val urls = listOf(
        "https://nekobot.xyz/api/image?type=hentai",
        "https://api.waifu.pics/nsfw/waifu",
        "https://api.waifu.pics/nsfw/neko",
        "https://api.waifu.pics/nsfw/blowjob"
    )
    
    File("Hentai").mkdir()

    var i = 1
    while (true) {
        val url = urls.random()
        val response = client.get<String>(url)
        download(response, i++)
        delay(1200)
    }
}

fun download(link: String, index: Int) {
    val name = link.split("/").last()
    val client = HttpClient(CIO)
    
    client.get<ByteArray>(link).let { data ->
        File("./Hentai/$name").writeBytes(data)
        println("$index Hentai Downloaded")
    }
}
