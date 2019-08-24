![Signal Logo](https://i.imgur.com/dnmDW6F.jpg)

**Official Signal client in docker container (for X11 server with GUI)**
===

Signal provides only an amd64 architecture version, so this docker images is only for amd64 systems as well.   

Versions in the latest image
-----
- [Signal](https://signal.org "Signal Homepage") Version: 1.26.2
- [Debian Base Image](https://hub.docker.com/_/debian "Debian Docker Repo") Version: 9-slim

Start your container
-----
Use the below start sequence to get a running Signal client displaying on your host X11 server.    
Be aware, that this way of accessing the X11 server is not the safest, you will find more secure methods online.       

```
docker run -it \
      --memory 1gb \
      -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
      -e DISPLAY=$DISPLAY \ # to display on your host X11
      --device /dev/snd \ # to have sound output
      --device /dev/dri/card0 \ # to use graphics card acceleration (if needed)
      -v /dev/shm:/dev/shm \ 
      -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \ # might need a change to your system
      -v $HOME/.config/signal:/home/signal/.config/Signal \ # make your settings persistent
     --name signal \
      avpnusr/signal:latest
```
   
If you close the signal window, you can restart the container any time with:     
```
docker start signal
```
