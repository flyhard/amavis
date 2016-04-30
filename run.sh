#!/bin/bash
if [[ $# -eq 0 ]]
then
	consul_node=consul
else
	consul_node=$1
fi
consul agent -config-dir /etc/consul -join ${consul_node} &

sleep 2

curl -X PUT -d "$HOSTNAME.local" http://localhost:8500/v1/kv/mail/amavis/hostname

sleep 1

/usr/local/bin/confd -onetime -backend consul -node consul:8500

/usr/sbin/amavisd-new foreground