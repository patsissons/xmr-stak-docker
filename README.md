# xmr-stak Universal Docker Miner

[![Docker Stars](https://img.shields.io/docker/stars/patsissons/xmr-stak.svg)](https://hub.docker.com/r/patsissons/xmr-stak/) [![Docker Pulls](https://img.shields.io/docker/pulls/patsissons/xmr-stak.svg)](https://hub.docker.com/r/patsissons/xmr-stak/) [![Docker Build Status](https://img.shields.io/docker/build/patsissons/xmr-stak.svg)](https://hub.docker.com/r/patsissons/xmr-stak/)

`xmr-stak` docker image that can mine CPU, AMD, and NVIDIA at the same time. One mining container to rule them all!

## Usage

`docker run --runtime=nvidia --device /dev/dri --device /dev/kfd --group-add=video -it -d --name xmr-stak -p 8000:8000  -v xmr-stak-config:/config patsissons/xmr-stak:develop -o ca.minexmr.com:5555 -u 47NHecs6qjvDcbx3eW6cDGDwdm3gDqbHs7G8hzPYRxf3YRTcDJw8kXhDxfHinsjHUwVwdFusSn76UHkaz68KurUgHvFmPMH.github -p x --currency monero --httpd 8000`

## AMD Requirements

You need to have installed the [`AMDGPU-Pro` drivers](https://www.amd.com/en/support/kb/release-notes/rn-radpro-lin-mining-beta) on the host machine and then run the docker image with `--device /dev/dri --device /dev/kfd --group-add=video`.

## NVIDIA Requirements

You need to have already installed [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) to enable passthru on the nvidia card(s). You will also need to have the [`cuda-drivers`](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64) installed. Run the docker container with `--runtime=nvidia` to enable the NVIDIA passthrough.

### CUDA drivers

Installing cuda drivers on [ubuntu 16.04](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=debnetwork) is the easiest way to get things going. You can install the drivers with `apt-get install --no-install-recommends cuda-drivers`. Make sure to reboot after installing new drivers.

## Donations

If you find this docker image useful, donations for work on dockerizing the build and mining app are appreciated at any of the folllowing addresses:

- BTC: `1LNY9wSPs913Y9jXMTrrVze1E41nhm6Qv7`
- LTC: `LhnwdbrnQaQbjDkqxXFmxXGPcFhMBA9gFu`
- ETH: `a05c67acbec8afc30287704540b215284a7c21a9`
- XMR: `47NHecs6qjvDcbx3eW6cDGDwdm3gDqbHs7G8hzPYRxf3YRTcDJw8kXhDxfHinsjHUwVwdFusSn76UHkaz68KurUgHvFmPMH`
- XRP: `rG9vAB1rbgDW3Ds7HFqJeF9Pi4fGRbEs93`

## Acknowledgements

* [`bananajamma/docker-xmr-stak-amd-vega`](https://github.com/bananajamma/docker-xmr-stak-amd-vega) for the initial concept
* [`merxnet/xmr-stak-amd-docker`](https://github.com/merxnet/xmr-stak-amd-docker) for the multi-stage build concept
