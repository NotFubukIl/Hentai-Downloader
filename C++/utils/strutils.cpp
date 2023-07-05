//
// Created by TaxMachine on 2023-07-04.
//

#include "strutils.h"
#include <vector>
#include <sstream>
#include <string>
#include <random>

std::string strutils::get_filename(std::string url) {
    size_t pos = url.find_last_of('/');
    return url.substr(pos + 1);
}

std::string strutils::getRandomElement(std::vector<std::string> &vec) {
    std::random_device rd;
    std::mt19937 gen(rd());
    return vec[gen() % vec.size()];
}
