//
// Created by TaxMachine on 2023-07-04.
//

#ifndef HENTAIDOWNLOADER_STRUTILS_H
#define HENTAIDOWNLOADER_STRUTILS_H

#include <string>
#include <vector>

class strutils {
    public:
        static std::string get_filename(std::string url);
        static std::string getRandomElement(std::vector<std::string> &vec);
};

#endif //HENTAIDOWNLOADER_STRUTILS_H
