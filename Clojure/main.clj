(ns HentaiDownloader
  (:require [clojure.java.io :as io]
            [clj-http.client :as http]
            [clojure.data.json :as json]))

(def URLS
  ["https://nekobot.xyz/api/image?type=hentai"
   "https://api.waifu.pics/nsfw/waifu"
   "https://api.waifu.pics/nsfw/neko"
   "https://api.waifu.pics/nsfw/blowjob"])

(let [hentai-dir "./Hentai"]
  (when-not (.isDirectory (io/file hentai-dir))
    (.mkdirs (io/file hentai-dir))))

(defn parseJson [map]
    (reduce #(assoc %1 (-> (key %2) keyword) (val %2)) {} map))

(def i (atom 1))
  
(defn download-file [url destination]
  (let [response (http/get url {:as :byte-array})]
    (with-open [out (io/output-stream destination)]
      (io/copy (io/input-stream (:body response)) out))
      (println (str "Downloaded " @i " Hentai"))))

(defn getURL [url i]
  (let [res (http/get url)
        res-json (json/read-str (:body res))
        res-json (parseJson res-json)
        message (if (clojure.string/includes? url "waifu") (get res-json :url) (get res-json :message) )
        f (-> message (clojure.string/split #"/") (last))
        _ (download-file message (str "./Hentai/" f))]))

(defn main [] 
  (while true
    (doseq [url URLS]
      (getURL url i)
      (swap! i inc)))
  )
(main)