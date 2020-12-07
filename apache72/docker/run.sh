#!/bin/bash
rm -f /var/run/apache2/apache2.pid && exec /usr/sbin/apache2ctl -DFOREGROUND
