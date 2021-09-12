# A Docker image for providing gnu-arm cross compilers as containers

This image provides gcc-arm cross compiler for arm linux gnueabihf target (arm-none-linux-gnueabi-gxx) as a container. The binaries are taken directly from [here](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-a/downloads) without any modifications.

The repo of the project can be found [here](https://github.com/hoo2/gcc-arm-none-linux-gnueabihf-docker).

## Supported tags

Bellow is the list with the supported tags as links to the Dockerfile of the version.

  * [`9.2.1`, `9.2`, `9`, `9.2-2019.12`](https://github.com/hoo2/gcc-arm-none-linux-gnueabihf-docker/blob/master/Dockerfile)


## What is GCC?

The GNU Compiler Collection (GCC) is a compiler system produced by the GNU Project that supports various programming languages. GCC is a key component of the GNU toolchain. The Free Software Foundation (FSF) distributes GCC under the GNU General Public License (GNU GPL). GCC has played an important role in the growth of free software, as both a tool and an example.

see: https://en.wikipedia.org/wiki/GNU_Compiler_Collection

## What is arm-none-eabi?

The GNU Toolchain for the Cortex-A Family is a ready-to-use, open source suite of tools for C, C++ and Assembly programming. This toolchain targets processors from the Arm Cortex-A family and implements the Arm A-profile architecture. The toolchain includes the GNU Compiler (GCC) and is available free of charge directly for Windows and Linux operating systems. Follow the links on this page to download the correct version for your development environment.


## How to use this image

### 1) Start a GCC instance running your app

The most straightforward way to use this image is to use a gcc container as both the build and runtime environment. In your Dockerfile, writing something along the lines of the following will compile and run your project:

    FROM hoo2/gcc-arm-none-linux-gnueabihf:latest
    COPY . /usr/src/myapp
    WORKDIR /usr/src/myapp
    RUN gcc -o myapp main.c
    CMD ["./myapp"]

Then, build and run the Docker image:

    $ docker build -t appImage .
    $ docker run -it --rm --name my-running-app appImage

### 2) Compile your app using the compiler from inside the container

There may be occasions where it is not appropriate to run your app inside a container. To compile, but not run your app inside the Docker instance, you can write something like:

    $ docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp hoo2/gcc-arm-none-linux-gnueabihf:8.3 arm-none-linux-gnueabihf-gcc -o myapp myapp.c

This will add your current directory, as a volume, to the container, set the working directory to the volume, and run the command `arm-none-linux-gnueabihf-gcc -o myapp myapp.c`. This tells gcc to compile the code in myapp.c and output the executable to myapp.

### 3) Alternatively, running make using the make from inside the container

if you have a Makefile, you can instead run the make command inside your container

    $ docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp hoo2/gcc-arm-none-linux-gnueabihf make

## TODO

  1. Add support for other platforms besides linux_x64