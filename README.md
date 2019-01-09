# arm-gcc-docker

## An enviroment for ARM Cortex-M series MCUs

### Components

1. a docker where gcc-arm-none-eabi, make, cmake, fish installed
2. a GUI helper for building makefile and communicating with server in docker (in development) 
3. a server application running in docker and communicates with host (in development)

### Docker commands

1. just run docker
> docker run -ti --name arm dandjinh/arm-gcc fish

2. run docker and start server
> docker run -d --name arm -p 12345:12345 dandjinh/arm-gcc helper-server
