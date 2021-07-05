Exercise 02 - Pure MPI 'Hello world' Singularity container 
==========================================================

Write the Singularity definition file
-------------------------------------

The Bind MPI approach will be used to execute the Singularity MPI container on Piz Daint cluster.

On \$SCRATCH directory in Piz Daint, write a recipe with a pure MPI Hello World code, such that: 

1) use Debian Jessie as Base OS. As a bootstrap source, use the Debian release available in the Docker Hub [click here](https://hub.docker.com/_/debianhttps://hub.docker.com/_/debian).

2) add your name as author of the container

3) update the system

4) install the packages: file g++ gcc gfortran make gdb strace realpath wget ca-certificates --no-install-recommends 

5) install the MPICH version 3.4.2, configuring by the options '' --disable-fortran --enable-fast=all,O3 --prefix=/usr --with-device=ch3'' .
The snippet of the steps for the installation are:

		wget -q http://www.mpich.org/static/downloads/3.4.2/mpich-3.4.2.tar.gz
		tar xf mpich-3.4.2.tar.gz
		cd mpich-3.4.2
		./configure --disable-fortran --enable-fast=all,O3 --prefix=/usr --with-device=ch3
		make -j$(nproc)
		make install
		ldconfig

6) Moreover, copy in the **/data** directory within the container the code **hello\_world\_MPI.c**, available in this repo directory (remember the **%files** section) and add in the recipe the command for compiling such code: 

		mpicc -o hello_world_MPI.bin  hello_world_MPI.c


Build the Singularity container 
-------------------------------

Build the container on Piz Daint compute node using the fakeroot feature. 

Submit an interactive job: 

	$ srun -C gpu -A class02 --reservation=prace --pty -u bash

then, since the MPI BINDING approach is beeing used,  load the following modules: 

	$ module load daint-gpu
	$ module load singularity/3.6.4-daint
 	$ module unload xalt

All the host network and mpi library are set and autatically binded into the container. 

Build the container by using the command:

	$ singularity build --fakeroot --fix-perms ex_02.sif Singularity_02_PureMPI


Execute the Singularity container
---------------------------------

### Batch Execution

To execute the 'Hello world' code present in the Singularity container just build, submit a Slurm job batch on Piz Daint. 

Run the test on 2 nodes, asking for 4 tasks per node. In the job script remember to load the modules: 

	$ module load daint-gpu
	$ module load singularity/3.6.4-daint
	$ module unload xalt

Open a new shell in Piz Daint, write the slurm job batch script where the container will be executed by the command: 

	$ srun singularity exec ex_02.sif /data/hello_world.bin  
   
Then, run the tests on a different number of nodes by changing the number of MPI tasks also. 

Plese refer to <https://user.cscs.ch/access/running/piz_daint/> for additional informations about the job submission on Piz Daint. 

### Interactive Execution

To submit an interactive job, open a new shell in Piz Daint, load the modules: 

	$ module load daint-gpu
	$ module load singularity/3.6.4-daint
	$ module unload xalt

then type a command like: 

	$ srun -C gpu -A class02 -N2 --ntasks-per-node=4 --reservation=prace singularity exec ex_02.sif /data/hello_world_MPI.bin


Solution
--------

The complete solution of the exercise is in the recipe **Singularity\_02\_MPI**  available in this repo directory.

The slurm job batch script is also provided, named **job\_script\_ex\_02\_PureMPI.sh**.




