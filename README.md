# Linux-Kernel_MiSTer_build
Docker for building Linux kernel for the MiSTer

## Description

First stage is building a docker, that in essence is a debian installation with
the build requirements, cross compiler is downloaded and unpacked, MiSTer
sources are downloaded and unpacked, and a kernel is buildt with default
configuration.

The second stage is running the docker, which will (if needed), configure and
rebuild the kernel, and assemble as zImage_dtb for you to copy to your MiSTer.
You should run the docker with a mounted volume, which is where the finished
kernel image will be copied. I typically run it with `-v $(pwd):/mnt`, which
mounts current directory as `/mnt` inside the docker instance. If there is a
file `MiSTer_config` in the specified directory, it will be copied to the new
kernel config, before the kernel config menu is presented. Make your changes to
the kernel (or not) and exit the menu config, and the kernel is recompiled with
the new options (since the kernel has already been built in the initial docker,
the build time highly reduced compared to building from scratch). At last the
new kernel and the new config are copied out to the bind mounted volume on
`/mnt`, in my case current directory, as `zImage_dtb` and `MiSTer_config`.

### Using Docker

```
docker build -t mister_kernel https://github.com/kowoba/Linux-Kernel_MiSTer_build.git
docker run -v $(pwd):/mnt -ti mister_kernel
```

