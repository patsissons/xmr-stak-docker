ARG CUDA_VERSION=10.1
ARG BUILD_FLAVOUR=devel
ARG RUN_FLAVOUR=runtime
ARG DISTRO_NAME=ubuntu
ARG DISTRO_VERSION=16.04

FROM nvidia/cuda:${CUDA_VERSION}-${BUILD_FLAVOUR}-${DISTRO_NAME}${DISTRO_VERSION} as build

ENV GIT_REPOSITORY https://github.com/fireice-uk/xmr-stak.git
ENV XMRSTAK_CMAKE_FLAGS -DXMR-STAK_COMPILE=generic -DCUDA_ENABLE=ON -DOpenCL_ENABLE=ON

COPY donate-level.patch /tmp

RUN apt-get update \
    && set -x \
    && apt-get install -qq --no-install-recommends -y build-essential ca-certificates cmake cuda-core-10-1 git cuda-cudart-dev-10-1 libhwloc-dev libmicrohttpd-dev libssl-dev ocl-icd-opencl-dev \
    && git clone $GIT_REPOSITORY \
    && git -C xmr-stak apply /tmp/donate-level.patch \
    && cd /xmr-stak \
    && cmake ${XMRSTAK_CMAKE_FLAGS} . \
    && make \
    && cd - \
    && apt-get purge -y -qq build-essential cmake cuda-core-10-1 git cuda-cudart-dev-10-1 libhwloc-dev libmicrohttpd-dev libssl-dev ocl-icd-opencl-dev \
    && apt-get clean -qq

FROM nvidia/cuda:${CUDA_VERSION}-${RUN_FLAVOUR}-${DISTRO_NAME}${DISTRO_VERSION}

ARG DISTRO_NAME
ARG DISTRO_VERSION

ENV DEBIAN_FRONTEND=noninteractive \
    AMDGPU_VERSION=17.40-492261
#    AMDGPU_VERSION=18.50-725072
#ENV AMDGPU_DRIVER_NAME=amdgpu-pro-${AMDGPU_VERSION}-${DISTRO_NAME}-${DISTRO_VERSION}
#ENV AMDGPU_DRIVER_URI=https://drivers.amd.com/drivers/linux/${AMDGPU_DRIVER_NAME}.tar.xz
ENV AMDGPU_DRIVER_NAME=amdgpu-pro-${AMDGPU_VERSION}
ENV AMDGPU_DRIVER_URI=https://www2.ati.com/drivers/linux/${DISTRO_NAME}/${AMDGPU_DRIVER_NAME}.tar.xz

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -qq --no-install-recommends -y ca-certificates libhwloc5 libmicrohttpd10 libssl1.0.0 libuv1 wget xz-utils \
    && wget -q --show-progress --progress=bar:force:noscroll --referer https://support.amd.com ${AMDGPU_DRIVER_URI} \
    && tar -xvf ${AMDGPU_DRIVER_NAME}.tar.xz \
    && SUDO_FORCE_REMOVE=yes apt-get -y remove --purge wget xz-utils \
    && rm ${AMDGPU_DRIVER_NAME}.tar.xz \
    && chmod +x ./${AMDGPU_DRIVER_NAME}/amdgpu-pro-install \
#    && ./${AMDGPU_DRIVER_NAME}/amdgpu-pro-install -y --headless --opencl=legacy \
    && ./${AMDGPU_DRIVER_NAME}/amdgpu-pro-install -y \
    && rm -r ${AMDGPU_DRIVER_NAME} \
    && apt-get -y autoremove \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

COPY --from=build /xmr-stak/bin/* /usr/local/bin/

WORKDIR /config
VOLUME /config

ENTRYPOINT ["/usr/local/bin/xmr-stak"]

CMD ["-h"]
