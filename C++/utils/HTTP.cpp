//
// Created by TaxMachine on 2023-07-04.
//

#include "HTTP.h"
#include <curl/curl.h>
#include <stdexcept>

static size_t WriteCallback(void *contents, size_t size, size_t nmemb, void *userp)
{
    ((std::string*)userp)->append((char*)contents, size * nmemb);
    return size * nmemb;
}
size_t WriteData(void *ptr, size_t size, size_t nmemb, void *stream) {
    size_t written = fwrite(ptr, size, nmemb, (FILE *)stream);
    return written;
}

Request HTTP::Get(std::string url) {
    Request req;
    CURL *curl;
    CURLcode res;

    curl = curl_easy_init();
    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &req.body);
        curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &req.status);
        res = curl_easy_perform(curl);
        curl_easy_cleanup(curl);
    }

    return req;
}

Request HTTP::Post(std::string url, std::string body) {
    Request req;
    CURL *curl;
    CURLcode res;

    curl = curl_easy_init();
    if (curl) {

        struct curl_slist *headers = NULL;
        headers = curl_slist_append(headers, "Content-Type: application/json");

        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
        curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
        curl_easy_setopt(curl, CURLOPT_POST, 1L);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, body.c_str());

        curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &req.status);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &req.body);

        res = curl_easy_perform(curl);

        curl_slist_free_all(headers);
        curl_easy_cleanup(curl);


    }
    return req;
}

void HTTP::DownloadImage(std::string url, const char* output) {
    FILE* fp = fopen(output, "wb");
    if (!fp) throw std::invalid_argument("Failed to create a file on the given path");
    CURL* curl;
    CURLcode res;

    curl = curl_easy_init();

    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteData);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, fp);

        res = curl_easy_perform(curl);
        if (res) throw std::invalid_argument("Failed to download " + url + "\n");
        long code;
        curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &code);
        if (code != 200) throw std::invalid_argument("Invalid request, HTTP code: " + std::to_string(code) + "\n");
        curl_easy_cleanup(curl);
    }
    fclose(fp);
}
