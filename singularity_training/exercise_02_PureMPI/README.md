Exercise 03 - GNU 7 + OpenMPI Matrioska building process
========================================================

Goals:
------
1. Matrioska building
2. MPI run on a single node (intra-node)

Matrioska building
------------------

Starting from the container image built during the exercise 02, let's add in the container both the packages and the OpenMPI libraries needed to compile an MPI applciation and to run on GALILEO cluster. 

To do this, write a singularity definition file that has as bootstrapt the container image built during exercise 02.
So, the HEADER of the recipe will be as : 

	Bootstrap: localimage
	From: <local_path_to>/ex_02.sif 
	IncludeCmd: yes
	
	... ...

Then add the installation of the following packages: 

	yum -y install epel-release           
	yum -y install libibverbs.x86_64
	yum -y install libpsm2-devel.x86_64  
	yum -y install opa-fastfabric.x86_64
	yum -y install libfabric-devel.x86_64
	yum -y install infinipath-psm-devel.x86_64
	yum -y install libsysfs.x86_64
	yum -y install slurm-pmi-devel.x86_64
	yum -y install libffi-devel.x86_64
	yum -y install rdma-core-devel.x86_64

Now, add the instructions to download and install OpenMPI.  
Due to the ABI (Application Binary Interface) compatibility with the OpenMPI version available on GALILEO, install the OpenMPI version 3.1.4 .

Below are listed the commands needed to install OpenMPI, that must be added in the **%post** section of the new definition file. The url to use for downloading OpenMPI is https://download.open-mpi.org/release/open-mpi/v3.1/openmpi-3.1.4.tar.gz

	cd /workdir
	wget https://download.open-mpi.org/release/open-mpi/v3.1/openmpi-3.1.4.tar.gz
	tar -xvf /workdir/openmpi-3.1.4.tar.gz
	cd openmpi-3.1.4
	export FC="gfortran"
	export CC="gcc"
	export CFLAGS="-g -O2 -march=core-avx2"
	export CXXFLAGS="$CFLAGS"
	export FCFLAGS="-g -O2 -march=core-avx2"
	export LDFLAGS="-g -O2 -ldl -march=core-avx2"
	./configure --prefix=/opt/openmpi/3.1.4 FC=gfortran CC=gcc  --with-psm2=yes --with-memory-manager=none  \
                    --enable-static=yes --with-pmix --with-pmi --with-pmi-libdir="/usr/lib64/" \
                    --enable-shared --with-verbs --enable-mpirun-prefix-by-default --disable-dlopen
	make -j 8
	make install

	export PATH=/opt/openmpi/3.1.4/bin:${PATH}
	export LD_LIBRARY_PATH=/opt/openmpi/3.1.4/lib:${LD_LIBRARY_PATH}
	export MANPATH=/opt/openmpi/3.1.4/share/man:${MANPATH}
	export INFOPATH=/opt/openmpi/3.1.4/share/info:${INFOPATH}
 

Moreover, copy in the container the code **hello\_world\_MPI.c**, available in this repo directory (remember the **%files** section) and add in the recipe the command t compile such code: 

	mpicc -o hello_world_MPI.bin  hello_world_MPI.c

Finally, build the container by the command:

	$ sudo singularity build ex_03.sif Singularity_03

(Building time: ~20 minutes)

Remember that loading the previous image 'ex\_02.sif' implies that you will have already available all the software and environment variables installed during the exercise 2.  


Interact with the container
---------------------------

After the buit was finished, check the correct software versions for gcc and mpi by the commands:

**GCC:**

	$ singularity exec ex_03.sif gcc --version

	gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
	Copyright (C) 2017 Free Software Foundation, Inc.
	This is free software; see the source for copying conditions.  There is NO
	warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

**MPI:**

	$ singularity exec ex_03.sif mpirun --version
	
	mpirun (Open MPI) 3.1.4
	Report bugs to http://www.open-mpi.org/community/help/


Now execute the **hello\_world\_MPI.bin** with 4 processors by the command:

	$ singularity exec ex_3.sif mpirun -np 4 /data/hello_world_MPI.bin 

The output should be as: 

	Hello world from processor <proc>, rank 1 out of 4 processors
	Hello world from processor <proc>, rank 2 out of 4 processors
	Hello world from processor <proc>, rank 3 out of 4 processors
	Hello world from processor <proc>, rank 0 out of 4 processors

Solution
--------

In the file Singularity\_03\_complete in this repo, the full recipe is provided. 


Exercise 05 -  Transfer and run the container image on GALILEO HPC cluster
==========================================================================

Goals:
1. Learn how to run a MPI singularity application on GALILEO multi-nodes

Singularity exec on a HPC cluster multi-nodes
---------------------------------------------

Now that you built a working parallel container (during exercise 03) you can copy your \*.sif local image into GALILEO and run it inside a job script. 

Copy the SIF image from your laptop to your $HOME directory on Galileo by using the scp command:

	$ scp /local path/to/<sif image> a08trb**@login.galileo.cineca.it:~/

If you are using WindowsOS, you can transfer files to/from GALILEO using Filezilla or WinSCP.

In the repo is available the template of the slurm job script. Dowload it on GALILEO and modify to adapt to your needs. 

To run an MPI code multi nodes, you have to 

1) load the singularity module 
2) load the OpenMPI 3.1.4 module 
3) run the MPI code on GALILEO using the singularity command in a form like:  

		$ mpirun -np <num of mpi procs> singularity exec -B $TMPDIR <path_to_SIF image container_on GALILEO> ./your_app  
   
Note that on GALILEO the only directory binded by default to the container filesystem is $HOME. 

Run the tests on a different number of nodes changing the number of MPI tasks accordingly:

- run the test on 1 node,
- run the test on 2 nodes,
- run the test on 4 nodes.





ON PIZDAINT: 
srun -C gpu -A class02 --ntasks-per-node=8 singularity exec ex_03.sif mpirun -np 8 /data/hello_world_MPI.bin^C




