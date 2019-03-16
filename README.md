# xmr-stak Universal Docker Miner

[![Docker Stars](https://img.shields.io/docker/stars/patsissons/xmr-stak.svg)](https://hub.docker.com/r/patsissons/xmr-stak/) [![Docker Pulls](https://img.shields.io/docker/pulls/patsissons/xmr-stak.svg)](https://hub.docker.com/r/patsissons/xmr-stak/) [![Docker Build Status](https://img.shields.io/docker/cloud/build/patsissons/xmr-stak.svg)](https://hub.docker.com/r/patsissons/xmr-stak/)

`xmr-stak` docker image that can mine CPU, AMD, and NVIDIA at the same time. One mining container to rule them all!

## Tags

* `latest`: the latest stable version
* `develop`: the latest testing version (may not be stable). A new version of `xmr-stak` will start here and typically migrate to `latest` in a couple of days.

## Usage

* A simple one liner to get the container mining right awa

`docker run --runtime=nvidia --device=/dev/dri --device=/dev/kfd --group-add=video -it -d --name xmr-stak -p 8000:8000  -v xmr-stak-config:/config patsissons/xmr-stak:develop -o ca.minexmr.com:5555 -u 47NHecs6qjvDcbx3eW6cDGDwdm3gDqbHs7G8hzPYRxf3YRTcDJw8kXhDxfHinsjHUwVwdFusSn76UHkaz68KurUgHvFmPMH.github-xmr-stak -p x --currency monero --httpd 8000`

* A more [comprehensive script](https://github.com/patsissons/xmr-stak-docker/blob/master/start-xmr-stak.sh) to simplify the process of starting and uprading the miner. Running `sudo ./start-xmr-stak.sh` will pull down the latest version while still mining, then stop and upgrade the container to resume mining with minimal downtime. If you want to use this script with the latest `develop` builds, run `sudo ./start-xmr-stak.sh develop` instead. The script is ready to accept overrides for a few environment variables to simplify multi-host distribution.

|Environment Variable|Default Value|Notes|
|-|-|-|
|`ADDRESS`|N/A|make sure to replace the default with your own address or you will be mining to my address|
|`HOST`|`hostname -s`|override this if you want a custom host name that is different from your actual host name|
|`PORT`|`8000`|if another container or process is already using port `8000` this can be adjusted|
|`POOL_HOST`|N/A|make sure to replace this with your own pool remote uri|
|`POOL_USER`|`$ADDRESS.$HOST-$TAG`|adjust this to your needs|
|`POOL_PASS`|`x`|adjust this to your needs|
|`CURRENCY`|`monero`|adjust this to your needs|

## Host requirements

Everything has been tested on [Ubuntu 16 LTS (Xenial)](http://archive.ubuntu.com/ubuntu/dists/xenial/main/installer-amd64/current/images/netboot/mini.iso), but may also possibly work on [Ubuntu 18 (Bionic)](http://archive.ubuntu.com/ubuntu/dists/bionic/main/installer-amd64/current/images/netboot/mini.iso). For the most stable results, try and ensure your docker container environments match the host environment, especially for driver versions.

### AMD Requirements

AMD requires only drivers installed on the host to interact with the hardware.

#### `amdgpu-pro`

You need to have installed the [`AMDGPU-Pro` drivers (`17.40-492261`)](https://www.amd.com/en/support/kb/release-notes/rn-prorad-lin-amdgpupro) on the host machine and then run the docker image with `--device=/dev/dri --device=/dev/kfd --group-add=video`.

#### Testing

* check the status of the `amdgpu-pro` host driver installation.

`/opt/amdgpu-pro/bin/clinfo`

* check the status of the docker integration

`docker run -it --rm --device=/dev/dri --device=/dev/kfd --group-add=video --entrypoint=/bin/sh patsissons/xmr-stak -c /opt/amdgpu-pro/bin/clinfo`

### NVIDIA Requirements

NVIDIA requires both a docker runtime and cuda drivers installed on the host to interact with the hardware.

#### `nvidia-docker`

You need to have already installed [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) to enable passthru on the nvidia card(s). You will also need to have the [`cuda-drivers` (`10.1`)](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64) installed. Run the docker container with `--runtime=nvidia` to enable the NVIDIA passthrough.

#### `cuda-drivers`

Installing cuda drivers on [Ubuntu 16 LTS](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=debnetwork) is the easiest way to get things going. You can install the drivers with `apt-get install --no-install-recommends cuda-drivers`. Make sure to reboot after installing new drivers.

#### Testing

* check the status of the `cuda-drivers` host driver installation.

`/usr/bin/nvidia-smi`

* check the status of the docker integration

`docker run -it --rm --runtime=nvidia --entrypoint=/bin/sh patsissons/xmr-stak -c /usr/bin/nvidia-smi`

## Donations

If you find this docker image useful, donations for work on dockerizing mining app are appreciated at any of the following addresses:

- BTC: `1LNY9wSPs913Y9jXMTrrVze1E41nhm6Qv7`
- LTC: `LhnwdbrnQaQbjDkqxXFmxXGPcFhMBA9gFu`
- XMR: `47NHecs6qjvDcbx3eW6cDGDwdm3gDqbHs7G8hzPYRxf3YRTcDJw8kXhDxfHinsjHUwVwdFusSn76UHkaz68KurUgHvFmPMH`

## Acknowledgements

* [`bananajamma/docker-xmr-stak-amd-vega`](https://github.com/bananajamma/docker-xmr-stak-amd-vega) for the initial concept
* [`merxnet/xmr-stak-amd-docker`](https://github.com/merxnet/xmr-stak-amd-docker) for the multi-stage build concept
