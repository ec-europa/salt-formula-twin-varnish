#!/bin/bash
set -e
# Just compile the code, at least making sure include is working :

varnishd -C -f /etc/varnish/default.vcl

# TODO : Implements varnish test from here