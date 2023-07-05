//
// Created by TaxMachine on 2023-07-04.
//

#include <string>

class Request {
    public:
        int status;
        std::string body;
};

class HTTP {
    public:
        static Request Get(std::string url);
        static Request Post(std::string url, std::string body);
        static void DownloadImage(std::string url, const char* output);
};