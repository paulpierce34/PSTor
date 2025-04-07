# PSTor
Connect to the Tor network seamlessly with Powershell! The purpose of this script is to provide easy function calls for starting/stopping a local Tor proxy and connecting to this proxy via Selenium. This will provide the capability to web crawl any site on the deep darkweb.

The ideal workflow is to run Start-Tor to initialize your Tor proxy, and then Start-WebCrawl to begin your webcrawling excursions. By default, this function will navigate to https://check.torproject.org/ to verify Tor network connection. Use Stop-Tor when you are finished.

## PREREQUISITES:
- Tor installed (tor.exe binary required)
- Selenium & Chrome webdriver (if you want to execute optional Start-WebCrawl function)

## HOW TO USE:
- Git clone to your machine
- Execute script to load 3 functions into memory: Start-Tor, Start-Webcrawl, Stop-Tor
- Call the Start-Tor function to initialize Tor local proxy
- Start-Webcrawl to verify Tor connectivity and begin your web crawling excursions
- Call Stop-Tor to kill your process

**NOTE: ** By default assumes your Tor directory is located here: $env:USERPROFILE\Desktop\Tor Browser\Browser\TorBrowser\Tor\. Modify $TorPath variable to change.

## EXAMPLE USAGE:

![ClipChamp-Tor-Video-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/f995c250-9d38-4473-b598-e3a7aa6e431c)
