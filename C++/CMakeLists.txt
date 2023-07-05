cmake_minimum_required(VERSION 3.25)
project(HentaiDownloader)

set(CMAKE_CXX_STANDARD 23)


find_package(CURL REQUIRED)
set(CURL_INCLUDE_DIR "libs/curl/include")
include_directories(${CURL_INCLUDE_DIR})

add_executable(HentaiDownloader main.cpp utils/HTTP.cpp utils/HTTP.h hentai/hentai.cpp hentai/hentai.h utils/strutils.cpp utils/strutils.h utils/json.hpp)

target_link_libraries(HentaiDownloader ${CURL_LIBRARIES})