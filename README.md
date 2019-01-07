# arm-gcc-docker

## An enviroment for ARM Cortex-M series MCUs

### Components

1. a docker includes gcc-arm-none-eabi, make, cmake, fish
2. a GUI helper for building makefile(developing)

### Usage

1. setup projects with STM32CUBEMX
2. write codes with vscode
3. run docker and copy/link project files to docker
4. run cmake/make in docker
5. download/debug with [JLink](https://www.segger.com/products/debug-probes/j-link/) and [Ozone](https://www.segger.com/products/development-tools/ozone-j-link-debugger/)

### Docker commands

1. run docker
> docker run -ti --name arm dandjinh/arm-gcc fish

2. run docker and link project
> docker run -ti --name arm -v /d/project:/root/workplace/project dandjinh/arm-gcc fish
