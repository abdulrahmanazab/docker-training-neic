# Singularity Open MPI exercise

In this exercise you will install Open MPI on your host/VM, create a singularity container with Open MPI installed, then execute mpirun from the host with the parallel processes running in containers.

Install Open MPI on the host (centos)
--------------------------------------
Here we install a bit old version of openmpi so that can match old installations on your cluster
```bash
# pre-requisites
sudo yum groupinstall 'Development Tools'
# Download openmpi 1.10.2
wget https://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.2.tar.bz2
tar xvjf openmpi-1.10.2.tar.bz2
cd openmpi-1.10.2
# Install openmpi 
./configure --prefix=/usr/local
make
sudo make install
# Compile and test the ring example
mpicc examples/ring_c.c -o ring
mpirun -np 2 ring
```
Create the ubuntu container
---------------------------
Create an image file with 4 GiB size:
```bash
singularity image.create -s 4096 ~/ubuntu.simg
```
Build an *old* ubuntu container inside that image:
```bash
sudo singularity build -w ~/ubuntu.simg docker://ubuntu:12.04
```
Install Open MPI on the container
----------------------------------
Here we install the *same* openmpi version, that we installed on the host, on the container.
* Install the pre-requisites:
```bash
sudo singularity exec -w ~/ubuntu.simg apt-get update
sudo singularity exec -w ~/ubuntu.simg apt-get install build-essential
```
* Make another directory for the openmpi source/build on the ubuntu container
```bash
mkdir ~/openmpi-ubuntu
cd ~/openmpi-ubuntu
```
* Download and install openmpi
```bash
wget https://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.2.tar.bz2
tar xvjf openmpi-1.10.2.tar.bz2
cd openmpi-1.10.2
singularity exec ~/ubuntu.simg ./configure --prefix=/usr/local
singularity exec ~/ubuntu.simg make
sudo singularity exec -w -B /home ~/ubuntu.simg make install
# for mpicc to work:
sudo singularity exec -w -B /home ~/ubuntu.simg ldconfig
```
* Test openmpi
```bash
singularity exec ~/ubuntu.simg mpicc examples/ring_c.c -o ring
singularity exec ~/ubuntu.simg mpirun -np 2 ring
```
Use openmpi from the host with container processes
---------------------------------------------------
* Copy the ring binary to ``/usr/bin`` inside the container
```bash
sudo singularity exec -w -B /home ~/ubuntu.simg cp ./ring /usr/bin/ring
```
* Run mpirun
```bash
mpirun -np 2 singularity exec ~/ubuntu.simg /usr/bin/ring
```
