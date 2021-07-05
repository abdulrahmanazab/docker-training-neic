Exercise 03 - Singularity High Performance Linpack 
==================================================

Introduction 
-------------
HPL is the most famous benchmark for HPC cluster. The aim of this exercise is to download and install HPL and its dependecises inside a container and then run it on PizDaint
HPL binary needs a input file (HPL.dat). Usually this file has to be modify many times to run HPL with differnt configuration, we cannot put it inside the container.


Build a HPL container
---------------------

Starting from the container image built during the exercise 02, let's add BLAS library. BLAS is a basic linear algebra library and we need it to compile HPL.
For benchmarcking purposes one has to use machine-specific optimaized BLAS libraries, such as MKL or OpenBLAS, but for our testing purpose we can use BLAS.
In order to compile BLAS and HPL you need to modify their makefile in a proper way. This is not the topic of this tutorial, so we have provided you the necessary Makefile to build BLAS and HPL (*make.inc* and *Make.Linux\_Blas respectively*). They are not optimized but work fine for our purpose. For more info please visit the website <https://www.netlib.org/benchmark/hpl/>
Add these file to the container using the secttion **%files**

	%files
	make.inc /workdir/
	Make.Linux_BALS /workdir/

Download BLAS source files from <http://www.netlib.org/blas/blas-3.8.0.tgz>, *untar* the compressed archive and copy inside the file *make.inc*. Use the command make all to compile the static library. To build also shared object, run the command "gfortran -shared -fPIC -O3 \*.f -o libblas.so". Finally copy BLAS library to the install directory, we have chosen /workdir/BLAS-3.8.0/lib

	cd /workdir
	wget http://www.netlib.org/blas/blas-3.8.0.tgz
	tar -xvf  blas-3.8.0.tgz
	cd BLAS-3.8.0
	
	# Build static library
	cp /workdir/make.inc .
	make all
	
	# Build shared object
	gfortran -shared -fPIC -O3 *.f -o libblas.so
        ldconfig
	
	# Copy binary files to the install dir
	mkdir -p /wordir/BLAS/3.8.0/lib
	cp libblas.so libblas.a /workdir/blas/3.8.0/lib/
	
	# export the LD_LIBRARY_PATH
	export LD_LIBRARY_PATH=/workdir/BLAS/3.8.0/lib:${LD_LIBRARY_PATH}

Download HPL source file from <https://www.netlib.org/benchmark/hpl/hpl-2.3.tar.gz>, *untar* the archive and copy inside the file *Make.Linux_BLAS*. To build HPL simpy run the command "make arch=Linux\_BLAS" inside the directory /workdir/hpl-2.3. As what we have already done for BLAS, copy the xhpl (HPL binary file) in its installation directory (/workdir/hpl-2.3/bin/Linux\_blas). This operation is not necessary, but it helps to have al executable files under the same /opt directory.

	cd /workdir
	wget https://www.netlib.org/benchmark/hpl/hpl-2.3.tar.gz
	tar -xvf hpl-2.3.tar.gz
	
	## Build hpl-2.3
	cd hpl-2.3
	cp /workdir/Make.Linux_blas .
	make arch=Linux_blas
	
**Remark**: if you have installed BLAS library in a different PATH you have to modify properly the Make.Linux\_Blas file


Build the container 
-------------------

Build the container on Piz Daint compute node using the fakeroot feature.

Submit an interactive job:

        $ srun -C gpu -A class02 --reservation=prace --pty -u bash

then, since the MPI BINDING approach is beeing used,  load the following modules:

        $ module load daint-gpu
        $ module load singularity/3.6.4-daint
        $ module unload xalt

All the host network and mpi library are set and autatically binded into the container.

Build the container by using the command:

        $ singularity build --fakeroot --fix-perms hpl.sif Singularity_03_HPL_complete


Execute the container
---------------------

In order to run HPL container you need to have in the same directory both the container image and the HPL.dat file. 

Run the test on 2 nodes, asking for 4 tasks per node. Please note that the number of tasks is wirtten inside HPL.dat, if you want to run HPL benchmark on a different number of tasks you have to modify the input file HPL.dat. For more details refer to <https://www.netlib.org/benchmark/hpl/tuning.html>. 

In the job script remember to load the modules:

        $ module load daint-gpu
        $ module load singularity/3.6.4-daint
        $ module unload xalt

Open a new shell in Piz Daint, write the slurm job batch script where the container will be executed by the command:

        $ srun singularity exec --bind <path to dir with HPL.dat file> hpl.sif /workdir/hpl-2.3/bin/Linux_blas/xhpl


**Remark**: you don't need to specify the input file, but HPL.dat needs to be in the current working directory when xhpl is executed. If we use a different working directory we have to use the flag --bind (or -B).


Solution
--------

The complete solution of the exercise is in the recipe **Singularity\_03\_HPL**  available in this repo directory.

The slurm job batch script is also provided, named **job\_script\_ex\_03\_HPL.sh**.

