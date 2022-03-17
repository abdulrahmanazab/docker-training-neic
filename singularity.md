# Singularity

Install
--------
* Easy installation:
```bash
$ sudo yum update -y && \
    sudo yum install -y epel-release && \
    sudo yum update -y && \
    sudo yum install -y singularity
```
* Install as specific release 
	* Install required packages
```bash
sudo yum -y update && sudo yum -y install \
    wget \
    rpm-build \
    git \
    gcc \
    libuuid-devel \
    openssl-devel \
    libseccomp-devel \
    squashfs-tools \
    epel-release \
    golang \
    cryptsetup
```

Install the release of your choice. The releases page is [here](https://github.com/singularityware/singularity/releases)
```bash
export VERSION=3.7.2  # this is the singularity version, change as you need

wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz && \
    rpmbuild -tb singularity-${VERSION}.tar.gz && \
    sudo rpm --install -vh ~/rpmbuild/RPMS/x86_64/singularity-${VERSION}-1.el7.x86_64.rpm && \
    rm -rf ~/rpmbuild singularity-${VERSION}*.tar.gz
```
* [Installation admin guide](https://sylabs.io/guides/3.5/admin-guide/installation.html)

Update
-------
Updating Singularity is just like installing it, but with the ``--upgrade`` flag instead of ``--install``. Make sure you pick the latest tarball from the [Github relese page](https://github.com/sylabs/singularity/releases)

```bash
export VERSION=3.2.0  # the newest singularity version, change as you need

wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz && \
    rpmbuild -tb singularity-${VERSION}.tar.gz && \
    sudo rpm --upgrade -vh ~/rpmbuild/RPMS/x86_64/singularity-${VERSION}-1.el7.x86_64.rpm && \
    rm -rf ~/rpmbuild singularity-${VERSION}*.tar.gz
```
* Erase
```bash
sudo rpm --erase singularity
```

Getting started
----------------
* See the interface
```bash
$ singularity help

Linux container platform optimized for High Performance Computing (HPC) and
Enterprise Performance Computing (EPC)

Usage:
  singularity [global options...]

Description:
  Singularity containers provide an application virtualization layer enabling
  mobility of compute via both application and environment portability. With
  Singularity one is capable of building a root file system that runs on any
  other Linux system where Singularity is installed.

Options:
  -c, --config string   specify a configuration file (for root or
                        unprivileged installation only) (default
                        "/etc/singularity/singularity.conf")
  -d, --debug           print debugging information (highest verbosity)
  -h, --help            help for singularity
      --nocolor         print without color output (default False)
  -q, --quiet           suppress normal output
  -s, --silent          only print errors
  -v, --verbose         print additional information

Available Commands:
  build       Build a Singularity image
  cache       Manage the local cache
  capability  Manage Linux capabilities for users and groups
  completion  generate the autocompletion script for the specified shell
  config      Manage various singularity configuration (root user only)
  delete      Deletes requested image from the library
  exec        Run a command within a container
  help        Help about any command
  inspect     Show metadata for an image
  instance    Manage containers running as services
  key         Manage OpenPGP keys
  oci         Manage OCI containers
  overlay     Manage an EXT3 writable overlay image
  plugin      Manage Singularity plugins
  pull        Pull an image from a URI
  push        Upload image to the provided URI
  remote      Manage singularity remote endpoints, keyservers and OCI/Docker registry credentials
  run         Run the user-defined default command within a container
  run-help    Show the user-defined help for an image
  search      Search a Container Library for images
  shell       Run a shell within a container
  sif         siftool is a program for Singularity Image Format (SIF) file manipulation
  sign        Attach digital signature(s) to an image
  test        Run the user-defined tests within a container
  verify      Verify cryptographic signatures attached to an image
  version     Show the version for Singularity

Examples:
  $ singularity help <command> [<subcommand>]
  $ singularity help build
  $ singularity help instance start


For additional help or support, please visit https://singularity.hpcng.org/help/
```
* Get help
```bash
$ singularity help <subcommand>
$ singularity --help <subcommand>
$ singularity -h <subcommand>
$ singularity <subcommand> --help
$ singularity <subcommand -h
```
* Download pre-built containers

From singularity hub:
```bash
$ singularity pull shub://vsoch/hello-world   # pull with default name, vsoch-hello-world-master.sif
$ singularity pull --name hello.sif shub://vsoch/hello-world   # pull with custom name
```
From Docker hub:
```bash
$ singularity pull docker://godlovedc/lolcow  # with default name
$ singularity pull --name funny.sif docker://godlovedc/lolcow # with custom name
```

Build a container
------------------
The ``build`` command can produce containers in two different formats:
- compressed read-only Singularity Image File (SIF) format suitable for production (default)
- writable (ch)root directory called a sandbox for interactive development ( ``--sandbox`` option)

Build options:
* **Build from a remote repository:** The target defines the method that build uses to create the container. It can be one of the following:

    * ``library://`` to build from the Container Library
    * ``docker://`` to build from Docker Hub
    * ``shub://`` to build from Singularity Hub

Search for a container
```bash
$ singularity search bowtie
Found 3 container images for amd64 matching "bowtie":

	library://btmiller/default/testimg-bowtie2-samtools:latest

	library://hindrek/nipt/bowtie2_samtools:1.0.0

	library://yh549848/rnaseqde/bowtie2:2.4.1
```
Build a container
```bash
$ singularity build bowtie2.sif library://yh549848/rnaseqde/bowtie2:2.4.1
$ singularity build hello-world.sif shub://vsoch/hello-world
$ singularity build lolcow.sif docker://godlovedc/lolcow
```
* Interact with containers
```bash
$ singularity exec bowtie2.sif bowtie2 --version
/opt/conda/bin/bowtie2-align-s version 2.4.1
64-bit
Built on
Fri Feb 28 17:23:43 UTC 2020
Compiler: gcc version 7.3.0 (crosstool-NG 1.23.0.450-d54ae)
Options: -O3 -msse2 -funroll-loops -g3 -fvisibility-inlines-hidden -std=c++17 -fmessage-length=0 -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /opt/conda/include -fdebug-prefix-map=/opt/conda/conda-bld/bowtie2_1582910401777/work=/usr/local/src/conda/bowtie2-2.4.1 -fdebug-prefix-map=/opt/conda=/usr/local/src/conda-prefix -DPOPCNT_CAPABILITY -DWITH_TBB -std=c++11 -DNO_SPINLOCK -DWITH_QUEUELOCK=1
Sizeof {int, long, long long, void*, size_t, off_t}: {4, 8, 8, 8, 8, 8}

$ singularity shell docker://genomicpariscentre/bowtie2
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
Getting image source signatures
Copying blob sha256:a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4
 32 B / 32 B [==============================================================] 0s
Copying blob sha256:3a2f32a545118c8c188c752e7dc358aa16646c75120745a6450f79c412284e8f
 41.59 MiB / 41.59 MiB [====================================================] 4s
Copying blob sha256:2e674b483741e5b67d285f2f67712faf7e2055644e40b580e43be3e2897d9fe6
 56.50 KiB / 56.50 KiB [====================================================] 0s
.....
Skipping fetch of repeat blob sha256:a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4
Copying config sha256:0db9e54682b0d34c67c033907fe5e6a2afafd3444de2872a09c5aaac8aa5bff4
 6.15 KiB / 6.15 KiB [======================================================] 0s
Writing manifest to image destination
Storing signatures
INFO:    Creating SIF file...
INFO:    Build complete: /home/cloud-user/.singularity/cache/oci-tmp/0a14633b467bc1425e5e3ae7e4f6b100b7e8399be9dc52068ca76972e7d11dd2/bowtie2_latest.sif

Singularity bowtie2_latest.sif:~> bowtie2 --version
/usr/local/bin/bowtie2-align-s version 2.2.4
64-bit
Built on fbc229a23508
Wed Mar 25 10:48:32 UTC 2015
Compiler: gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
Options: -O3 -m64 -msse2  -funroll-loops -g3 -DPOPCNT_CAPABILITY
Sizeof {int, long, long long, void*, size_t, off_t}: {4, 8, 8, 8, 8, 8}
Singularity bowtie2_latest.sif:~> exit
exit
```
* ``exec`` also works with the ``shub://`` and ``docker://`` URIs. This creates an ephemeral container that executes a command and disappears.
```bash
$ singularity exec shub://singularityhub/ubuntu cat /etc/os-release
```
* **Creating writable ``--sandbox`` directories:**
Remote to sandbox:
```bash
$ sudo singularity build --sandbox lolcow/ library://sylabs-jms/testing/lolcow
$ sudo singularity shell --writable lolcow/
```
Local SIF to sandbox:
```bash
$ sudo singularity build --sandbox bowtie bowtie2.sif
$ sudo singularity shell --writable bowtie2/
```
Sandbox to SIF:
```bash
$ sudo singularity build lolcow.sif lolcow/
```
* **Singularity recipes:**
```bash
cat >> ubuntu.def
BootStrap: docker
From: ubuntu:16.04

%runscript
    echo "This is what happens when you run the container..."
    

%post
    echo "Hello from the container"
    echo "Install additional software here"
    # This part is for Abel and colossus clusters at UiO:
    mkdir /cluster /work /tsd /usit /projects
```
* Build the container from the def file
```bash
sudo singularity build ubuntu.img ubuntu.def
```


* Interact with a pulled image
```bash
$ singularity pull --name hello-world.sif shub://vsoch/hello-world
$ singularity shell hello-world.sif
Singularity: Invoking an interactive shell within container...

# I am the same user inside as outside!
Singularity hello-world.simg:~/Desktop> whoami
vanessa

Singularity hello-world.sif:~/Desktop> id
uid=1000(vanessa) gid=1000(vanessa) groups=1000(vanessa),4(adm),24,27,30(tape),46,113,128,999(input)
```
* Execute a command on a pulled image
```bash
$ singularity exec hello-world.sif ls /
anaconda-post.log  etc	 lib64	     mnt   root  singularity  tmp
bin		   home  lost+found  opt   run	 srv	      usr
dev		   lib	 media	     proc  sbin  sys	      var
```
``exec`` also works with the ``shub://`` and ``docker://`` URIs. This creates an ephemeral container that executes a command and disappears.
```bash
$ singularity exec shub://singularityhub/ubuntu cat /etc/os-release
```


Bind mounts
------------
Here’s an example of using the ``-B`` option and binding ``/tmp`` on the host to ``/scratch`` in the container:
```bash
$ singularity shell -B /tmp:/scratch /tmp/Centos7-ompi.img
Singularity: Invoking an interactive shell within container...

Singularity.Centos7-ompi.img> ls /scratch
ssh-7vywtVeOez  systemd-private-cd84c81dda754fe4a7a593647d5a5765-ntpd.service-12nMO4
```
More: [File sharing](http://singularity.lbl.gov/docs-mount)

Signing and Verifying Containers
---------------------------------
[User Guide](https://www.sylabs.io/guides/3.2/user-guide/signNverify.html)

Use a Singularity container on your institutional cluster
----------------------------------------------------------
HPC clusters usually have a shared file system for data storage, software modules, and user homes. Each with a specific root directory. For example, the [Abel](http://www.uio.no/english/services/it/research/hpc/abel/) cluster at the university of Oslo has ``/usit`` for user homes, ``/cluster`` for software modules, ``/work`` as the scatch directory for HPC jobs, and ``/projects`` for data storage. For a singularity container to work on your cluster, those root directories **need** to exist on the container. This exercise works for the Abel cluster. You may do similar procedure for your institutional cluster.

* On your VM:

```bash
docker search bowtie2
...
sudo singularity build --sandbox bowtie2/ docker://genomicpariscentre/bowtie2
sudo singularity shell -w bowtie2/
singularity> mkdir /cluster /work /usit /tsd /net /projects
singularity > exit
sudo singularity build bowtie2.sif bowtie2/

scp bowtie2.sif <abel-user>@abel.uio.no:~/
```
* Now go to Abel:

```bash
ssh <abel-user>@abel.uio.no
[<abel-user>@login-0-1 ~]$ module avail singularity
---------------------------------------------- /cluster/etc/modulefiles -----------------------------------------------
singularity/2.2.1          singularity/2.4.2          singularity/2.4.5(default)
singularity/2.4            singularity/2.4.4
[<abel-user>@login-0-1 ~]$ module load singularity
[<abel-user>@login-0-1 ~]$ qlogin -A <project>
salloc: Pending job allocation 20627631
salloc: job 20627631 queued and waiting for resources
salloc: job 20627631 has been allocated resources
salloc: Granted job allocation 20627631
srun: Job step created
bash-4.1$ singularity exec bowtie2.simg bowtie2 --version
/home/biodocker/bin/bowtie2-align-s version 2.2.9
64-bit
Built on localhost.localdomain
Thu Apr 21 18:36:37 EDT 2016
Compiler: gcc version 4.1.2 20080704 (Red Hat 4.1.2-54)
Options: -O3 -m64 -msse2  -funroll-loops -g3 -DPOPCNT_CAPABILITY
Sizeof {int, long, long long, void*, size_t, off_t}: {4, 8, 8, 8, 8, 8}
bash-4.1$
```
* Submit a [test singularity job](https://github.com/abdulrahmanazab/docker-training-neic/blob/research-bazaar-2019/singularity-slurm-simple.sbatch) to slurm on abel

Useful links
-------------
* [Docs](https://www.sylabs.io/docs/)
