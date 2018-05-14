FROM debian:stretch
WORKDIR /root/
SHELL ["/bin/bash", "-c"]
ENV ARCH arm
ENV CROSS_COMPILE /root/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-
RUN (apt-get update; apt-get -y upgrade; apt-get -y install build-essential bc liblz4-tool device-tree-compiler wget libncurses5-dev libncursesw5-dev) >/dev/null 2>&1
RUN wget -q -O - https://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/arm-linux-gnueabihf/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf.tar.xz | tar xJf -
RUN wget -q -O - https://github.com/MiSTer-devel/Linux-Kernel_4.5.0_MiSTer/archive/socfpga-4.5.tar.gz | tar xzf -
RUN make -C Linux-Kernel_4.5.0_MiSTer-socfpga-4.5 --quiet clean mrproper MiSTer_defconfig zImage modules dtbs
