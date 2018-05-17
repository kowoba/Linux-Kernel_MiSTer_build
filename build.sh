#! /bin/bash
set -e
cp -v /mnt/MiSTer_config Linux-Kernel_4.5.0_MiSTer-socfpga-4.5/.config
make -C Linux-Kernel_4.5.0_MiSTer-socfpga-4.5 --quiet menuconfig zImage modules dtbs
cat Linux-Kernel_4.5.0_MiSTer-socfpga-4.5/arch/arm/boot/zImage \
    Linux-Kernel_4.5.0_MiSTer-socfpga-4.5/arch/arm/boot/dts/socfpga_cyclone5_de10_nano.dtb > zImage_dtb 
cp -v zImage_dtb /mnt/zImage_dtb
cp -v Linux-Kernel_4.5.0_MiSTer-socfpga-4.5/.config /mnt/MiSTer_config
