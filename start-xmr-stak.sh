#!/bin/bash

TAG=${1:-latest}
ADDRESS=${ADDRESS:-47NHecs6qjvDcbx3eW6cDGDwdm3gDqbHs7G8hzPYRxf3YRTcDJw8kXhDxfHinsjHUwVwdFusSn76UHkaz68KurUgHvFmPMH}
HOST=${HOST:-$(hostname -s)}
PORT=${PORT:-8000}
POOL_HOST=${POOL:-ca.minexmr.com:5555}
POOL_USER=${POOL_USER:-$ADDRESS.$HOST-$TAG}
POOL_PASS=${POOL_PASS:-x}
CURRENCY=${CURRENCY:-monero}

docker pull patsissons/xmr-stak:$TAG && \
docker rm -f xmr-stak-$TAG 2> /dev/null && \
docker run --runtime=nvidia --device /dev/dri --device /dev/kfd --group-add=video -it -d --name xmr-stak-$TAG -v xmr-stak-config:/config -p $PORT:8000 patsissons/xmr-stak:$TAG -o $POOL_HOST -u $POOL_USER -p $POOL_PASS --currency $CURRENCY --httpd 8000
