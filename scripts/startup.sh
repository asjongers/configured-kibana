#!/bin/bash

# load saved objects
atd
at now +2 minutes -f /usr/share/kibana/scripts/load-kibana-objects.sh

set -e

# Add kibana as command if needed
if [[ "$1" == -* ]]; then
	set -- kibana "$@"
fi

# Run as user "kibana" if the command is "kibana"
if [ "$1" = 'kibana' ]; then
	# move kibana.yml to proper directory
	cp /usr/share/kibana/config/kibana.yml /etc/kibana/kibana.yml
	if [ "$ELASTICSEARCH_URL" ]; then
		sed -ri "s!^(\#\s*)?(elasticsearch\.url:).*!\2 '$ELASTICSEARCH_URL'!" /etc/kibana/kibana.yml
	fi

	set -- gosu kibana tini -- "$@"
fi

exec "$@"
