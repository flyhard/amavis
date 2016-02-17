#!/bin/bash

curl -X PUT -d '{"Datacenter":"dc1", "Node":"amavis","Address": "amavis", "Service": {"Service":"amavis", "Port": 10024}}' http://${CONSUL_PORT_8500_TCP_ADDR}:${CONSUL_PORT_8500_TCP_PORT}/v1/catalog/register

/usr/local/bin/confd -onetime -backend consul -node consul:8500

exec $@
