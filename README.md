# docker-rootless-nvidia-stack
rootless docker + docker in docker + nvidia driver container

![architecture](./images/architecture.png)

This repository was created to work with rootless docker and nvidia drivers. There is no installation on the host other than docker (rootful). Rootless Docker and Nvidia drivers both run as containers inside Docker. Users access the public rootless Docker by exposing a port or mounting a socket to the host.

## Deployment Example

```
# For example, we expose the port on localhost:2375.
$ cat << EOF >> docker-compose.yml
    ports:
    - 127.0.0.1:2375:2375
EOF
$ docker-compose up -d

# There is an initial wait time of 3 minutes to wait for the nvidia-driver to
# load. When looking at the log through the "docker-compose logs" command, if
# there are outputs like the following, the installation is complete.
$ docker-compose logs
nvidia-driver    | Done, now waiting for signal
...
dind-rootless    | time="2022-12-22T04:49:33.223259903Z" level=info msg="API listen on /run/user/100000/docker.sock"
dind-rootless    | time="2022-12-22T04:49:33.235296028Z" level=info msg="API listen on [::]:2375"
```

## User Example

```
# If you exposed the port above, you can access it through localhost.
$ docker -H localhost ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
$ docker -H localhost run --rm --gpus all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi
Thu Dec 22 04:52:12 2022
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 525.60.13    Driver Version: 525.60.13    CUDA Version: 12.0     |
|-------------------------------+----------------------+----------------------+
...
+-------------------------------+----------------------+----------------------+

# or regular users, you can alias docker commands.
$ alias "docker=docker -H localhost"
$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

