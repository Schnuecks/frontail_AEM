# Frontail for openHAB
## Streaming openHAB logs to the browser

This is a fork from the [official Frontail](https://github.com/mthenw/frontail). It is intended to work especially with [openHAB](https://www.openhab.org) log files.


## Features

*   Ability to use Regular Expressions in the highlighting rules definition
*   Use of html classes (instead of inline css rules) to define the appearance in a separate css file
*   Custom highlighting rules, intended for openHAB
*   New theming function, allowing to switch between light and dark mode in the same page (instead of having to choose among the two)
*   Use of HTML Web Storage API to remember the last used theme


## Look & Feel

![Light Theme](https://community-openhab-org.s3.dualstack.eu-central-1.amazonaws.com/optimized/3X/4/c/4c7cf71bb4a91b42a5897e8eedae9b40cb69af93_2_690x460.jpeg)

![Dark Theme](https://community-openhab-org.s3.dualstack.eu-central-1.amazonaws.com/optimized/3X/f/c/fcaebc3ca9cb3f182d8d59ef3aa5f322a6fd9a55_2_690x460.jpeg)

## Installation
> **Note**
> It can be that the paths differ with you, depending on the system version.  Please adjust accordingly.

We install the necessary applications:
```
sudo apt-get install nodejs
sudo apt-get install npm
```

Then the frontail itself:
```
sudo npm i frontail -g
```
Get (linux-specific) frontail installation folder:
```
echo "$(npm list -g | head -n 1)/node_modules/frontail"
```
### Copy modified files to frontail
Copy modified files from this repo to the frontail installations dir, i.e.: ```/usr/lib/node_modules/frontail/```

### Let's create a new system service:
```
cd /etc/systemd/system/
sudo nano frontail.service
```
And in the editor that opens, paste the following script:
```
#!/bin/sh -

[Unit]
Description=Frontail

[Service]
ExecStart=/usr/lib/node_modules/frontail/bin/frontail --disable-usage-stats --ui-highlight --ui-highlight-preset /usr/lib/node_modules/frontail/preset/openhab_AEM.json --theme openhab_AEM --lines 2000 --number 200 /var/log/openhab/openhab.log /var/log/openhab/events.log /var/log/openhab/zwave.log
Restart=always
User=openhab
Group=openhab

[Install]
WantedBy=multi-user.target
Alias=frontail.service
```
You may need to change the User and Group values ​​to those that openHab runs under on your system. Save and then run the following commands:
```
sudo chmod 644 /etc/systemd/system/frontail.service
sudo systemctl daemon-reload
sudo systemctl enable frontail.service
sudo systemctl start frontail.service
```
If everything is done correctly, then by going to http://<server_addres>:9001 in the browser we will see the treasured logs.

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


## Thanks

Thanks to the work of [Ethan Dye](https://github.com/ecdye) this is also the standard Frontail version on [OpenHABian](https://github.com/openhab/openhabian) starting from version 1.6.4: you can install it using openhabian-config, menu 21.

Thanks to [Grzegorz Miasko](https://github.com/gieemek/openHAB_Frontail_AGM_Theme) who [contributed with new rules and color theme](https://community.openhab.org/t/frontail-custom-theme-coloring/116673/98). See his GitHub repository [here](https://github.com/gieemek/openHAB_Frontail_AGM_Theme).

I would also like to thank [Schnuecks](https://github.com/Schnuecks) for helping me and giving some great suggestions. He also created a Repository for the installation via docker image, you can find it [here](https://github.com/Schnuecks/frontail_AEM).
