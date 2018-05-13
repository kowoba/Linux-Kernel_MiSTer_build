FROM debian:stretch
WORKDIR /root/
SHELL ["/bin/bash", "-c"]
ENV ARCH arm
ENV CROSS_COMPILE /root/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-
ENV GREEN "\x1b[1;32m"
ENV NORMAL "\x1b[0m"
RUN echo -e "\n${GREEN}Preparing Debian...${NORMAL}" ;\
    apt-get -qq update ;\
    apt-get -qq -y upgrade ;\
    apt-get -qq -y install build-essential bc liblz4-tool device-tree-compiler wget git ;\
    echo -e "\n${GREEN}Debian docker prepared!${NORMAL}\n"
RUN echo -e "\n${GREEN}Downloading and unpacking cross-compiler" ;\
    echo -n "Be patient... " ;\
    wget -q -O - https://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/arm-linux-gnueabihf/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf.tar.xz | tar xJf - ;\
    echo -e "done!${NORMAL}"
RUN echo -e "\n${GREEN}Cloning https://github.com/MiSTer-devel/Linux-Kernel_4.5.0_MiSTer" ;\
    echo -e "Be VERY patient...${NORMAL}" ;\
    git clone -b socfpga-4.5 https://github.com/MiSTer-devel/Linux-Kernel_4.5.0_MiSTer
RUN echo -e "\n${GREEN}Updating Linux-Kernel_4.5.0_MiSTer...${NORMAL}" ;\
    git -C Linux-Kernel_4.5.0_MiSTer pull ;\
    echo -e "\n${GREEN}Building default kernel using MiSTer_defconfig, more patience...${NORMAL}" ;\
    make -C Linux-Kernel_4.5.0_MiSTer --quiet clean ;\
    make -C Linux-Kernel_4.5.0_MiSTer --quiet mrproper ;\
    make -C Linux-Kernel_4.5.0_MiSTer --quiet MiSTer_defconfig ;\
    make -C Linux-Kernel_4.5.0_MiSTer --quiet zImage modules dtbs
COPY MiSTer_config MiSTer_config
RUN mv -v MiSTer_config Linux-Kernel_4.5.0_MiSTer/.config ;\
    echo -e "\n${GREEN}Building custom kernel using MiSTer_config, even more patience...${NORMAL}" ;\
    make -C Linux-Kernel_4.5.0_MiSTer --quiet zImage modules dtbs ;\
    echo -en "\n${GREEN}Assembling zImage_dtb... " ;\
    cat Linux-Kernel_4.5.0_MiSTer/arch/arm/boot/zImage \
        Linux-Kernel_4.5.0_MiSTer/arch/arm/boot/dts/socfpga_cyclone5_de10_nano.dtb > zImage_dtb ;\
    echo -e "done!${NORMAL}"
#   echo -e "\nTry...\n   docker exec -it <containerIdOrName> bash"
#   sleep 9999
CMD tar c zImage_dtb
