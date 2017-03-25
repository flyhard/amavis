#!/usr/bin/env sh
echo "postfix postfix/main_mailer_type string Internet site" > preseed.txt
echo "postfix postfix/mailname.tmpl string mail.abich.com" >> preseed.txt
debconf-set-selections preseed.txt

apk update

apk add amavisd-new clamav-daemon
DEBIAN_FRONTEND=noninteractive apt-get install -y amavisd-new spamassassin clamav-daemon \
                       pyzor razor libencode-detect-perl libdbi-perl libdbd-mysql-perl libzmq3\
                       arj cabextract cpio nomarch pax unzip zip curl wget
rm -rf /var/lib/apt/lists/*
freshclam