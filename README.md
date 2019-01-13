# xmr-stak Universal Docker Miner

[![Docker Stars](https://img.shields.io/docker/stars/patsissons/xmr-stak.svg)](https://hub.docker.com/r/patsissons/xmr-stak/) [![Docker Pulls](https://img.shields.io/docker/pulls/patsissons/xmr-stak.svg)](https://hub.docker.com/r/patsissons/xmr-stak/) [![Docker Build Status](https://img.shields.io/docker/build/patsissons/xmr-stak.svg)](https://hub.docker.com/r/patsissons/xmr-stak/)

`xmr-stak` docker image that can mine CPU, AMD, and NVIDIA

## Usage

`docker run --runtime=nvidia --device /dev/dri --device /dev/kfd --group-add=video -it --rm --name xmr-stak-develop -v xmr-stak-config:/config patsissons/xmr-stak:develop -o ca.minexmr.com:5555 -u 47NHecs6qjvDcbx3eW6cDGDwdm3gDqbHs7G8hzPYRxf3YRTcDJw8kXhDxfHinsjHUwVwdFusSn76UHkaz68KurUgHvFmPMH.docker-mining-worker-test -p x --currency monero --httpd 8000`
