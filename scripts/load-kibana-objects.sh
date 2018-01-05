#!/bin/bash
elasticdump --output http://elasticsearch:9200/.kibana --input /usr/share/kibana/config/kibana-objects.json
echo 'recreated visualizations'
