#!/usr/bin/env bash

URL=$(curl -s https://api.github.com/repos/kelseyhightower/confd/releases | \
	grep browser_download_url | grep 'linux-amd64' | head -n 1 | cut -d '"' -f 4)

wget ${URL} -O /usr/local/bin/confd
chmod +x /usr/local/bin/confd