# Hentai Downloader in Kotlin

This is a small Kotlin program that downloads images from specific websites. The program makes HTTP requests to predefined URLs and saves downloaded images in the `Hentai` folder.

## Requirements

- Kotlin installed on your system. You can download it from: https://kotlinlang.org/
- An Internet connection to make HTTP requests.

## Use

1. Clone this repository or download the Kotlin file (`HentaiDownloader.kt`).

2. Open a terminal and navigate to the location where the `HentaiDownloader.kt` file is located.

3. Compile the Kotlin file using the command:
```bash
kotlinc HentaiDownloader.kt -include-runtime -d HentaiDownloader.jar
```
4. Run the program with the following command:
```bash
kotlin HentaiDownloader.jar
```

5. The program will start downloading images and save them in the `Hentai` folder.

6. To stop the program, press `Ctrl + C` in the terminal.

## Grades

- The program uses the Ktor library to make HTTP requests. Make sure you have the proper dependencies configured in your build file (`build.gradle.kts` or `build.gradle`).

- The downloaded images will be saved in the `Hentai` folder in the same directory where the Kotlin file is located.

- Please note that this program is provided for demonstration and educational purposes. Make sure you comply with all local laws and regulations when using it.

---

**WARNING**: The content downloaded by this program may be inappropriate or NSFW (Not Safe for Work). Use this program with responsibility and discretion.
