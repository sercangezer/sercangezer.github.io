#!/bin/bash

# Sitemap URL'leri
SITEMAP_URLS=("https://www.sercangezer.com.tr/sitemap.xml" 
              "https://www.sercangezer.com.tr/feed.xml" 
              "https://www.sercangezer.com.tr/atom.xml")

# Arama Motorları Ping URL'leri
GOOGLE_PING_URL="http://www.google.com/ping?sitemap="
BING_PING_URL="http://www.bing.com/ping?sitemap="
YANDEX_PING_URL="http://blogs.yandex.ru/pings/?status=success&url="

# Her bir sitemap için ping işlemi
for SITEMAP_URL in "${SITEMAP_URLS[@]}"
do
    echo "Pinging Google for $SITEMAP_URL"
    curl -s ${GOOGLE_PING_URL}${SITEMAP_URL} > /dev/null

    echo "Pinging Bing for $SITEMAP_URL"
    curl -s ${BING_PING_URL}${SITEMAP_URL} > /dev/null

    echo "Pinging Yandex for $SITEMAP_URL"
    curl -s ${YANDEX_PING_URL}${SITEMAP_URL} > /dev/null

    echo "Ping completed for $SITEMAP_URL"
done

echo "All pings completed!"
