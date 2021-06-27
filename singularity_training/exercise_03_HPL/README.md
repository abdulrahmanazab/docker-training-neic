Exercise 03 - Singularity High Performance Linpack 
==================================================

Goals: 
------

1. Compile HPL inside a container
2. Directory binding (HOME is authomatic) 


Introduction 
-------------
HPL is the most famous benchmark for HPC cluster. The aim of this exercise is to download and install HPL and its dependecises inside a container and then run it on PizDaint
HPL binary needs a input file (HPL.dat). Usually this file has to be modify many times to run HPL with differnt configuration, we cannot put it inside the container.


Build a HPL container
---------------------

Starting from the container image built during the exercise 03, let's add BLAS library. BLAS is a basic linear algebra library and we need it to compile HPL.
For benchmarcking purposes one has to use machine-specific optimaized BLAS libraries, such as MKL or OpenBLAS, but for our testing purpose we can use BLAS.
In order to compile BLAS and HPL you need to modify their makefile in a proper way. This is not the topic of this school, so we have provided you the necessary Makefile to build BLAS and HPL (*make.inc* and *Make.Linux\_Blas respectively*). They are not optimized but work fine for our purpose. For more info please visit the website <https://www.netlib.org/benchmark/hpl/>
Add these file to the container using the secttion **%files**

	%files
	make.inc /workdir/
	Make.Linux_BALS /workdir/

Download BLAS source files from <http://www.netlib.org/blas/blas-3.8.0.tgz>, *untar* the compressed archive and copy inside the file *make.inc*. Use the command make all to compile the static library. Dynamic library is not necessary, but if you want to build also shared object you can run the command "gfortran -shared -fPIC -O3 -march=core-avx2 \*.f -o libblas.so". Finally copy BLAS library to the install directory, we have chosen /opt/blas/3.8.0/lib

	cd /workdir
	wget http://www.netlib.org/blas/blas-3.8.0.tgz
	tar -xvf  blas-3.8.0.tgz
	cd BLAS-3.8.0
	
	# Build static library
	cp /workdir/make.inc .
	make all
	
	# Build shared object
	gfortran -shared -fPIC -O3 -march=core-avx2 *.f -o libblas.so
	
	# Copy binary files to the install dir
	mkdir -p /opt/blas/3.8.0/lib
	cp libblas.so libblas.a /opt/blas/3.8.0/lib/
	
	# export the LD_LIBRARY_PATH
	export LD_LIBRARY_PATH=/opt/blas/3.8.0/lib:${LD_LIBRARY_PATH}

Download HPL source file from <https://www.netlib.org/benchmark/hpl/hpl-2.3.tar.gz>, *untar* the archive and copy inside the file *Make.Linux_BLAS*. To build HPL simpy run the command "make arch=Linux\_BLAS" inside the directory /workdir/hpl-2.3. As what we have already done for BLAS, copy the xhpl (HPL binary file) in its installation directory (/opt/hpl/2.3/bin/). This operation is not necessary, but it helps to have al executable files under the same /opt directory.

	cd /workdir
	wget https://www.netlib.org/benchmark/hpl/hpl-2.3.tar.gz
	tar -xvf hpl-2.3.tar.gz
	
	## Build hpl-2.3
	cd hpl-2.3
	cp /workdir/Make.Linux_blas .
	make arch=Linux_blas
	
	# Install HPL in its install directory
	mkdir -p /opt/hpl/2.3/bin
	cp /workdir/hpl-2.3/bin/Linux_blas/xhpl /opt/hpl/2.3/bin/
	export PATH=/opt/hpl/2.3/bin:${PATH}
	export MANPATH=/workdir/hpl-2.3/man:${MANPATH}

**Remark**: if you have installed BLAS library in a different PATH you have to modify properly the Make.Linux\_Blas file

Please remebrer to define in the **%environment** section all the necessary runtime paths.

	  export LD_LIBRARY_PATH=/opt/blas/3.8.0/lib:${LD_LIBRARY_PATH}
	  export PATH=/opt/hpl/2.3/bin:${PATH}
	  export MANPATH=/workdir/hpl-2.3/man:${MANPATH}


Copy the container image on Galileo and run it
----------------------------------------------

In order to run HPL container on Galileo you need to copy it togheter with its input file HPL.dat.

	scp /local/path/to/HPL.dat   a08trb**#login.galileo.cineca.it:~/
	scp /local/path/to/<image>.sif   a08trb**#login.galileo.cineca.it:~/

Create a job script to run HPL on 2 nodes using 4 tasks per node. Please note that the number of tasks is wirtten inside HPL.dat, if you want to run HPL benchmark on a different number of tasks you have to modify the input file HPL.dat. 
Please, for more details refer to <https://www.netlib.org/benchmark/hpl/tuning.html> 
	
	(SBATCH directives)
	...
	(loading needed modules)
	
	mpirun -np 8 singularity exec -B $TMPDIR <image>.sif xhpl

**Remark**: you don't need to specify the input file, but HPL.dat needs to be in the current working directory when xhpl is executed. This works because we have copu HPL.dat in our HOME direcotry and we are executing xhpl from here. If we use a different working directory we have to use the flag --bind. In order to test it, make a directory inside your $CINECA\_SCRATCH, copy the container, the input file (HPL.dat) and the job script inside it and try to execute the container from this new direcotry.

	cd $CINECA_SCRATCH
	mkdir bind_test
	cp ~/HPL.dat ~/<image>.sif ~/job_script_hpl.sh .

Remeber to modify your job script as follow.

	mpirun -np 8 singularity --bind $TMPDIR,$CINECA_SCRATCH/bind_test <image>.sif xhpl
