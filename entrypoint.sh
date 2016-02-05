#!/bin/bash

/usr/local/bin/confd -onetime -backend consul -node consul:8500

exec $@
