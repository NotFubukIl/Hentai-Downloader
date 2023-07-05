#include <iostream>
#include <vector>
#include <filesystem>
#include "hentai/hentai.h"
#include "utils/strutils.h"
#include <windows.h>

int main() {
    std::vector<std::string> urls = {
            "https://nekobot.xyz/api/image?type=hentai", "https://api.waifu.pics/nsfw/waifu",
            "https://api.waifu.pics/nsfw/neko", "https://api.waifu.pics/nsfw/blowjob"
    };
    std::vector<std::string> alturls = {
            "https://api.waifu.pics/many/nsfw/waifu",
            "https://api.waifu.pics/many/nsfw/neko",
            "https://api.waifu.pics/many/nsfw/blowjob"
    };

    if (!std::filesystem::exists(".\\hentai")) {
        auto status = std::filesystem::create_directory(".\\hentai");
        if (!status) std::cerr << "failed to create directory" << std::endl;
    }

    std::string choice;
    std::cout << "What generation method do you want to use\n1 - default 1 by 1\n2 - alternative 30 by request\nChoice: ";
    std::cin >> choice;
    std::cout << "You can stop the generation by pressing backspace" << std::endl;
    if (choice == "1") {
        int image = 1;
        while (!GetAsyncKeyState(VK_BACK)) {
            Hentai::Downloader(strutils::getRandomElement(urls)).GetHentai();
            std::cout << std::to_string(image) << " Image downloaded" << std::endl;
            image++;
        }
    } else if (choice == "2"){
        int image = 30;
        while (!GetAsyncKeyState(VK_BACK)) {
            Hentai::Downloader(strutils::getRandomElement(alturls)).GetAlternative();
            std::cout << std::to_string(image) << " Images downloaded" << std::endl;
            image += 30;
        }
    } else {
        std::cout << "Wrong choice";
    }
    return 0;
}
