# Linux-Kernel_MiSTer_build
Docker for building Linux kernel for the MiSTer

## Building

First stage is building a docker, that in essence is a debian installation with the build requirements, cross compiler is downloaded and unpacked, MiSTer sources are downloaded and unpacked, and a kernel is buildt with default configuration.

The second stage is running the docker, using the build.sh as an entrypoint. The build.sh script will copy the MiSTer_config to the new kernel config, and start the kernel config menu before rebuilding the kernel with the new options (since the kernel has already been built in the initial docker, the build time only depends on the build differences, so the rebuild should be much quicket than building from scratch). At last the new kernel and the new config are packed to stdout with tar, to be unpacked via the pipe.

### Using Docker

```
docker build -t mister_kernel https://github.com/kowoba/Linux-Kernel_MiSTer_build.git
docker run -v $(pwd):/mnt -ti mister_kernel /mnt/build.sh
```

