# Docker

Your VM is a CentOS 7

Install Docker
---------------
* [**Offecial instructions**](https://docs.docker.com/engine/install/centos/)

* Install required packages:
```bash
$ sudo yum install -y yum-utils device-mapper-persistent-data lvm2
```
* set up the stable repository:
```bash
$ sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
```
* Update the yum package index.:
```bash
$ sudo yum makecache fast
```
* Install the latest version of Docker:
```bash
sudo yum install docker-ce docker-ce-cli containerd.io
```
Accept this fingerprint ``060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35``

Try Docker
-----------
* Start the docker service
```bash
sudo service docker start
```
* List images:
```bash
$ docker run hello-world
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.27/images/json: dial unix /var/run/docker.sock: connect: permission denied
```
* You need to be a member of the docker group:
```bash
$ sudo groupadd docker
$ sudo usermod -aG docker centos
$ exit
$ ssh -i nrec.pem centos@<IP-Address>
```
* Now you can use docker:
```bash
$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
78445dd45222: Pull complete
Digest: sha256:c5515758d4c5e1e838e9cd307f6c6a0d620b5e07e6f927b07d05f6d12a1ac8d7
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://cloud.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/engine/userguide/
```
* [Official page](https://docs.docker.com/engine/installation/linux/centos/)

Here we go...
--------------
1. [Run your first container](http://training.play-with-docker.com/ops-s1-hello/)
2. [Docker images](http://training.play-with-docker.com/ops-s1-images/)
3. [Docker volumes](http://training.play-with-docker.com/docker-volumes/)
4. Docker continuous integration ([Slides](https://github.com/abdulrahmanazab/docker-training-neic/blob/research-bazaar-2020/Docker-continous-integration.pdf)), ([exercise](https://github.com/abdulrahmanazab/docker-training-neic/blob/research-bazaar-2020/docker-continuous-integration.md))
5. [Docker Compose](https://github.com/abdulrahmanazab/docker-training-neic/blob/research-bazaar-2020/docker-compose.md)
6. [Docker swarm](http://training.play-with-docker.com/swarm-mode-intro/)
4. [Advanced example](http://training.play-with-docker.com/beginner-linux/)
5. [Docker with user namespaces](https://github.com/abdulrahmanazab/docker-training-neic/blob/research-bazaar-2020/docker-userns.md)
9. [Compose advanced features with swarm](http://training.play-with-docker.com/ops-s1-swarm-intro/)


