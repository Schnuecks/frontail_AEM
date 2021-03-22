# Frontail for openHAB

This is a fork from the [official Frontail](https://github.com/mthenw/frontail). 
Frontail is a Node.js application for streaming logs to the browser. It's a tail -F with UI.
This version of Frontail is intended to work especially with openHAB log files, in particular regarding highlighting rules - but can be easily customized to work with any other log files, if using different rules in the json and css files.


## Features

*   Ability to use Regular Expressions in the highlighting rules definition
*   Use of html classes (instead of inline css rules) to define the appearance in a separate css file
*   custom highlighting rules, intended for openHAB
*   New theming function, allowing to switch between light and dark mode in the same page (instead of having to choose among the two)
*   Use of HTML Web Storage API to remember the last used theme


## Look & Feel

![Light Theme](https://community-openhab-org.s3.dualstack.eu-central-1.amazonaws.com/optimized/3X/4/c/4c7cf71bb4a91b42a5897e8eedae9b40cb69af93_2_690x460.jpeg)

![Dark Theme](https://community-openhab-org.s3.dualstack.eu-central-1.amazonaws.com/optimized/3X/f/c/fcaebc3ca9cb3f182d8d59ef3aa5f322a6fd9a55_2_690x460.jpeg)


## About

It started as a personal modification on the Frontail installation in my openHABian, the full story is in the first post of this thread:
<https://community.openhab.org/t/frontail-custom-theme-coloring/116673>

Long story short, some modifications where made to the following files:
```
web/index.html
web/assets/app.js
```

And some files were added:
```
preset/openhab_AEM.json
web/assets/styles/openhab_AEM.css
```

## Installation via docker image

* image is multiarch for linux/amd64 linux/arm/v7 linux/arm64

* edit docker-compose.yml

```
  frontail:
    image: schnuecks/frontail-multi:latest
    container_name: frontail
    command: --disable-usage-stats --ui-highlight --ui-highlight-preset /frontail/preset/openhab_AEM.json -t openhab_AEM -l 5000 -n 100 /logs/openhab.log /logs/events.log
    volumes:
    - /opt/openhab/userdata/logs:/logs:ro
    ports:
    - "9001:9001"
    restart: unless-stopped
```

* modify the volume and add your openhab userdata logs directory 
* run it with `docker-compose up -d`
* open http://127.0.0.1:9001


## Installation via local build

* `git clone https://github.com/Schnuecks/frontail_AEM.git`

* edit docker-compose.yml

```
frontail:
    container_name: frontail
    build: ./frontail
    command: --disable-usage-stats --ui-highlight --ui-highlight-preset /frontail/preset/openhab_AEM.json -t openhab_AEM -l 2000 -n 100 /logs/openhab.log /logs/events.log
    volumes:
    - /opt/openhab/userdata/logs:/logs:ro
    ports:
    - "9001:9001"
    restart: unless-stopped
```

* modify build path where you cloned the repo
* modify the volume and add your openhab userdata logs directory 
* to build `docker-compose build` and run it with `docker-compose up -d`
* open http://127.0.0.1:9001

## Thanks

Thanks to the work of [Ethan Dye](https://github.com/ecdye) this is also the standard frontail version on [openHABian](https://github.com/openhab/openhabian) starting from version 1.6.4: you can install it using openhabian-config, menu 21.

I would also like to thank [Schnuecks](https://github.com/Schnuecks) for helping me and giving some great suggestions. He also created a Repository for the installation via docker image, you can find it [here](https://github.com/Schnuecks/frontail_AEM).
