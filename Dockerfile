FROM debian:jessie
MAINTAINER Per Abich <per.abich@gmail.com>

ADD scripts/install.sh /tmp/scripts/
RUN /tmp/scripts/install.sh

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
