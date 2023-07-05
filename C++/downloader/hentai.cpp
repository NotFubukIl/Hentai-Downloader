//
// Created by TaxMachine on 2023-07-04.
//

#include "hentai.h"
#include "../utils/strutils.h"
#include <filesystem>
#include "../utils/json.hpp"

using json = nlohmann::json;

using std::regex, std::string, std::regex_search, std::endl, std::smatch, std::move, std::vector;

struct HentaiPayload {
    string referer;
    vector<string> exclude;
};

void Hentai::Downloader::GetHentai() {
    Request req = HTTP::Get(url);
    smatch cm;
    regex reg(R"(https?://(i.waifu.pics/|cdn.nekobot.xyz/[\w\d+]/[\w\d+]/[\w\d+]/).*(jpg|png|gif))");
    if (regex_search(req.body, cm, reg)) {
        string pUrl = cm[0];
        string filename = ".\\downloader\\" + strutils::get_filename(pUrl);
        try {
            HTTP::DownloadImage(pUrl, filename.c_str());
        } catch (const std::invalid_argument &e) {
            std::cout << e.what() << endl;
        }
    }
}

Hentai::Downloader::Downloader(string url) {
    this->url = move(url);
}

void Hentai::Downloader::GetAlternative() {
    vector<string> excludes;
    regex filereg(R"(.*\.(png|jpg|gif))");
    for (auto const& dir : std::filesystem::directory_iterator{".\\downloader"}) {
        if (!dir.is_regular_file() && !std::regex_match(dir.path().string(), filereg)) continue;
        excludes.push_back(dir.path().string());
    }
    json parsed;
    parsed["referer"] = "https://waifu.pics";
    parsed["exclude"] = excludes;
    Request req = HTTP::Post(url, parsed.dump());
    json j = json::parse(req.body);
    vector<string> files = j["files"].template get<vector<string>>();
    for (const string& f : files) {
        try {
            string filename = ".\\downloader\\" + strutils::get_filename(f);
            HTTP::DownloadImage(f, filename.c_str());
        } catch (const std::invalid_argument& e) {
            std::cout << e.what() << endl;
        }
    }
}
