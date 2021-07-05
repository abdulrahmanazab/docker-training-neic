"HPC Workshop on Containers and Unikernel" -- PRACE on-line event, July 5th-9th, 2021 
=====================================================================================

DOCKER INSTALLATION
-------------------

Official reference link:  https://docs.docker.com/get-docker/

### Linux Users
Install Docker Engine on your Linux workstation.
A variety of Linux platforms are supported, like CentOS, Debian, Fedora, Raspbian and Ubuntu, please refer to https://docs.docker.com/engine/install/ .

Hereafter the procedure for a CentOS7 is described, using the official .rpm packages provided by Docker. 

Uninstall older versions of Docker, if present.
 
Then open a shell in your workstation and run the following commands, to set up the repository and install Docker Engine:

	$ sudo yum install -y yum-utils
	$ sudo yum-config-manager --add-repo \ 
		https://download.docker.com/linux/centos/docker-ce.repo
	$ sudo yum install docker-ce docker-ce-cli containerd.io

If every step was fine so far, congratulations: you have installed Docker on our workstation. 

Now, start Docker and verify that it is installed correctly with the following commands:

	$ sudo systemctl start docker
	$ sudo docker run hello-world 

The last command downloads a test image and runs it in a container. When the container runs, it prints an informational message and exits.  

To automatically start Docker and Containerd on boot, use the commands below:

	$ sudo systemctl enable docker.service
	$ sudo systemctl enable containerd.service

Now, to use Docker as a non-root user, you need to add your own user into the "docker" linux group: 

	$ sudo groupadd docker 
	$ sudo usermod -aG docker $USER

Log out and log back in so that your group membership is re-evaluated. 

Verify that you can run docker commands without sudo running: 

	$ docker run hello-world

it prints an informational message and exits. 

### Windows or Mac Users
Please, for Windows refer to: https://docs.docker.com/docker-for-windows/install/

For Mac, refer to: https://docs.docker.com/docker-for-mac/install/


SINGULARITY INSTALLATION
------------------------

Official reference link: https://sylabs.io/guides/3.6/admin-guide/

### Linux Users

#### 1. Install from repo

It is possible to install Singularity using the CentOS/RHEL .rpm package that is regularly updated into the EPEL (Extra Packages for Enterprise Linux) repos. 

Uninstall older versions of Singularity, if present.

Open a shell and run the following commands to update your system and install the EPEL repo and Singularity:

	$ sudo yum update -y 
	$ sudo yum install -y epel-release
	$ sudo yum update -y 
	$ sudo yum install -y singularity

#### 2. Install from source

If the previous solution does not work on your laptop, or for another Linux distribution, you can install Singularity from source. 

Uninstall older versions of Singularity, if present.

Open a terminal, and install all the needed dependencies: 

**For Red Hat Enterprise Linux or CentOS**

	$ sudo yum update -y 
	$ sudo yum groupinstall -y 'Development Tools' 
	$ sudo yum install -y \
		openssl-devel \
		libuuid-devel \
		libseccomp-devel \
		wget \
		squashfs-tools \
		cryptsetup

**Alternatively, for Ubuntu or Debian**

	$ sudo apt-get update && sudo apt-get install -y \
		build-essential \
		uuid-dev \
		libgpgme-dev \
		squashfs-tools \
		libseccomp-dev \
		wget \
		pkg-config \
		git \
		cryptsetup-bin

Now, by root user, install Go with the following commands:

	$ cd /tmp/
	$ export GO_VERSION=1.15.3 GO_OS=linux GO_ARCH=amd64
	$ wget  https://dl.google.com/go/go${GO_VERSION}.${GO_OS}-${GO_ARCH}.tar.gz
	$ tar -C /usr/local/ -xvf go${GO_VERSION}.${GO_OS}-${GO_ARCH}.tar.gz
	$ echo 'export GOPATH=${HOME}/go' >> ~/.bashrc
	$ echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin'
    		>> ~/.bashrc
	$ source ~/.bashrc

Always as root user, install Singularity:

	$ mkdir -p $GOPATH/src/github.com/sylabs
	$ cd $GOPATH/src/github.com/sylabs
	$ git clone https://github.com/sylabs/singularity.git
	$ cd singularity/
	$ go get -u -v github.com/golang/dep/cmd/dep
	$ export SINGULARITY_VERSION=v3.6.1
	$ git checkout ${SINGULARITY_VERSION}
	$ ./mconfig
	$ make -C builddir
	$ make -C builddir install

Exit as root and log in as your local user. In the ~/.bashrc of your local user set:

	$ export PATH=/usr/local/bin:$PATH
	$ export GOPATH=/root/go
	$ export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin

Further documentation about Singularity installation is available at
https://sylabs.io/guides/3.6/admin-guide/installation.html

### Windows or Mac Users

Please refer to https://sylabs.io/guides/3.6/admin-guide/installation.html#installation-on-windows-or-mac .

HUBS SET UP
-----------

In order to simplify the sharing of the container there are many hubs that allow you to upload your local recipes and images of containers for free.

Now we are going to set up the most importants:

- GitHub, https://github.com/
- Docker Hub, https://hub.docker.com/
- Singularity Hub, https://singularity-hub.org/

If you do not already have an account on these hubs, please reads the following procedures.

### GIT HUB
Git is a distributed version-control system for tracking changes in source code during software development. The version-control system is quite powerful and a bit complex, in this tutorial we are going only to scratch all the potentials of this system.

We are going to create your personal account in GitHub in order to have a place where save your container recipe files (as text files). 

You have to sign up in the GitHub (https://github.com) creating your own username and connecting it to your email.

After the registration you will receive an email to your address to verify your new account. Do that and enjoy a free plan in GitHub.

At the end of the procedure, if you login you should see the main window. From this page you can create your new repository where to put your code.

### DOCKER HUB
Docker Hub is a hosted repository service provided by Docker for finding and sharing container images with your team. 

Key features include: 

- Private/Public Repositories: push and pull container images;
- Automated Builds: automatically build container images from GitHub (we will do this during the hands-on sessions).

We are going to create your personal account in Docker Hub in order to have a place where to save your container image files. 

You have to sign up in the Docker Hub (https://hub.docker.com) creating your own username and connecting it to your email.

After the registration you will receive an email to your address to verify your new account. Do that and enjoy a free plan in Docker Hub.
From the main page you can create your new repository where to put your container images. 

### SINGULARITY HUB
Singularity Hub is a hosted repository service provided by Singularity (pretty similar to Docker Hub) for finding and sharing container images with your team. 

Key features include: 

- Private/Public repositories; push and pull container images; 
- Image signature; 
- Automated builds: automatically build container images from GitHub (we will do this during the hands-on sessions).

We are going to create your personal account in Singularity Hub in order to have a place to save your container image files. 

You have to sign up in the Singularity Hub (https://singularity-hub.org) connecting it to your email. You can also use your previous GitHub login to get the access also to Singularity Hub, by selecting the option "GITHUB (WITH PRIVATE)". Do that and enjoy a free plan in Singularity Hub. From the main page you can create your new collection where to put your container images.  

