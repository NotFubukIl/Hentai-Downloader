//
// Created by TaxMachine on 2023-07-04.
//

#include <string>
#include <vector>
#include "../utils/HTTP.h"
#include <regex>
#include <iostream>

namespace Hentai {
    class Downloader {
        public:
        Downloader();

        Downloader(std::string url);
            void GetHentai();
            void GetAlternative();
        private:
            std::string url;
    };
}
