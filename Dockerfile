FROM debian:jessie
MAINTAINER Per Abich <per.abich@gmail.com>

RUN echo "postfix postfix/main_mailer_type string Internet site" > preseed.txt
RUN echo "postfix postfix/mailname string mail.abich.com" >> preseed.txt
RUN debconf-set-selections preseed.txt
RUN apt-get update &&\
 DEBIAN_FRONTEND=noninteractive apt-get install -y amavisd-new spamassassin clamav-daemon \
                       pyzor razor libencode-detect-perl libdbi-perl libdbd-mysql-perl libzmq3\
                       arj cabextract cpio nomarch pax unzip zip curl wget &&\
    rm -rf /var/lib/apt/lists/*\
	freshclam
ADD getConfdLatest.sh /
RUN /getConfdLatest.sh
ADD conf /etc/confd

# Use syslog-ng to get Postfix logs (rsyslog uses upstart which does not seem
# to run within Docker).
#RUN apt-get install -q -y syslog-ng
ADD entrypoint.sh /
EXPOSE 10024
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/amavisd-new", "foreground"]
