# Frontail for openHAB – streaming openHAB logs to the browser

This is a fork from the official Frontail. It is intended to work especially with openHAB log files.


## Light Theme

![alt text](https://community-openhab-org.s3.dualstack.eu-central-1.amazonaws.com/optimized/3X/4/c/4c7cf71bb4a91b42a5897e8eedae9b40cb69af93_2_690x460.jpeg)

## Dark Theme

![alt text](https://community-openhab-org.s3.dualstack.eu-central-1.amazonaws.com/optimized/3X/f/c/fcaebc3ca9cb3f182d8d59ef3aa5f322a6fd9a55_2_690x460.jpeg)


It started as a personal modification on the Frontail installation in my openHABian, the full story is in the first post of this thread:
https://community.openhab.org/t/frontail-custom-theme-coloring/116673

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

The functions implemented in this version are:

* Ability to use Regular Expressions in the highlighting rules definition
* Use of html classes (instead of inline css rules) to define the appearance in a separate css file
* custom highlighting rules, intended for openHAB
* New theming function, allowing to switch between light and dark mode in the same page (instead of having to choose among the two)
* Use of HTML Web Storage API to remember the last used theme

Thanks to the work of [Ethan Dye] (https://github.com/ecdye) this is also becoming the standard Frontail version on [OpenHABian] (https://github.com/openhab/openhabian).
If you are on the main branch, you can install it using openhabian-config, menu 21.

I would also like to thank [Schnuecks] (https://github.com/Schnuecks) for helping me, he also created a Repository for the installation via docker image, you can find it [here] (https://github.com/Schnuecks/frontail).



## Original version

<details>
    <summary>Click to expand</summary>
# frontail – streaming logs to the browser

`frontail` is a Node.js application for streaming logs to the browser. It's a `tail -F` with UI.

![frontial](https://user-images.githubusercontent.com/455261/29570317-660c8122-8756-11e7-9d2f-8fea19e05211.gif)

[![Docker Pulls](https://img.shields.io/docker/pulls/mthenw/frontail.svg)](https://hub.docker.com/r/mthenw/frontail/)

## Quick start

- `npm i frontail -g` or download a binary file from [Releases](https://github.com/mthenw/frontail/releases) page
- `frontail /var/log/syslog`
- visit [http://127.0.0.1:9001](http://127.0.0.1:9001)

## Features

- log rotation (not on Windows)
- auto-scrolling
- marking logs
- pausing logs
- number of unread logs in favicon
- themes (default, dark)
- [highlighting](#highlighting)
- search (`Tab` to focus, `Esc` to clear)
- set filter from url parameter `filter`
- tailing [multiple files](#tailing-multiple-files) and [stdin](#stdin)
- basic authentication

## Installation options

- download a binary file from [Releases](https://github.com/mthenw/frontail/releases) pagegit st
- using [npm package](https://www.npmjs.com/package/frontail): `npm i frontail -g`
- using [Docker image](https://cloud.docker.com/repository/docker/mthenw/frontail): `docker run -d -P -v /var/log:/log mthenw/frontail /log/syslog`

## Usage

    frontail [options] [file ...]

    Options:

      -V, --version                 output the version number
      -h, --host <host>             listening host, default 0.0.0.0
      -p, --port <port>             listening port, default 9001
      -n, --number <number>         starting lines number, default 10
      -l, --lines <lines>           number on lines stored in browser, default 2000
      -t, --theme <theme>           name of the theme (default, dark)
      -d, --daemonize               run as daemon
      -U, --user <username>         Basic Authentication username, option works only along with -P option
      -P, --password <password>     Basic Authentication password, option works only along with -U option
      -k, --key <key.pem>           Private Key for HTTPS, option works only along with -c option
      -c, --certificate <cert.pem>  Certificate for HTTPS, option works only along with -k option
      --pid-path <path>             if run as daemon file that will store the process id, default /var/run/frontail.pid
      --log-path <path>             if run as daemon file that will be used as a log, default /dev/null
      --url-path <path>             URL path for the browser application, default /
      --ui-hide-topbar              hide topbar (log file name and search box)
      --ui-no-indent                don't indent log lines
      --ui-highlight                highlight words or lines if defined string found in logs, default preset
      --ui-highlight-preset <path>  custom preset for highlighting (see ./preset/default.json)
      --path <path>                 prefix path for the running application, default /
      --disable-usage-stats         disable gathering usage statistics
      --help                        output usage information

Web interface runs on **http://[host]:[port]**.

### Tailing multiple files

`[file ...]` accepts multiple paths, `*`, `?` and other shell special characters([Wildcards, Quotes, Back Quotes and Apostrophes in shell commands](http://www.codecoffee.com/tipsforlinux/articles/26-1.html)).

### stdin

Use `-` for streaming stdin:

    ./server | frontail -

### Highlighting

`--ui-highlight` option turns on highlighting in UI. By default preset from `./preset/default.json` is used:

```
{
    "words": {
        "err": "color: red;"
    },
    "lines": {
        "err": "font-weight: bold;"
    }
}
```

which means that every "err" string will be in red and every line containing "err" will be bolded.

_New presets are very welcome. If you don't like default or you would like to share yours, please create PR with json file._

Available presets:

- default
- npmlog
- python

### Running behind nginx

Using the `--url-path` option `frontail` can run behind nginx with the example configuration

Using `frontail` with `--url-path /frontail`

```
events {
    worker_connections 1024;
}

http {
    server {
        listen      8080;
        server_name localhost;

        location /frontail {
            proxy_pass http://127.0.0.1:9001/frontail;

            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
        }
    }
}
```

### Usage statistics

`frontail` by default (from `v4.5.0`) gathers **anonymous** usage statistics in Google Analytics. It can be disabled with
`--disable-usage-stats`.

The data is used to help me understand how `frontail` is used and I can make it better.

</details>
