Exercise 01 - Build, test and run your first Singularity container
==================================================================

Write the Singularity definition file 
-------------------------------------

Login in PizDaint: 

	$ ssh <username>@ela.cscs.ch
	$ ssh daint.cscs.sh 

then move to the \$SCRATCH directory 

	$ cd $SCRATCH 

and write a Singularity definition file such that:

1) use CentOS7 as Base OS. As a bootstrap source, use the CentOS release available in Docker Hub [click here](https://hub.docker.com/_/centos). 

2) add your name as author of the container 

3) update the system

4) install the packages: vim, which, wget, tar and bzip2.

5) install the GNU compilers v 7

      By default, on CentOS7 the GNU compilers version 4 are available but, for development purposes, it could be needed to use a higher version of GNU compilers. 

      So, install GNU compilers v 7, by installing **devtoolset-7**, the Developer Toolset designed for developers working on CentOS or Red Hat Enterprise Linux platform. It provides current versions of the GNU Compiler Collection, GNU Debugger, and other development, debugging, and performance monitoring tools. 

      Use the following installation commands in the recipe:

		yum -y install centos-release-scl
		yum -y install devtoolset-7

5) Taking care that the default binary path of devtoolset-7 is

		/opt/rh/devtoolset-7/root/usr/bin 

      and that the library path is 

		/opt/rh/devtoolset-7/root/usr/lib

      set in your recipe the environment variables $PATH and $LD_LIBRARY_PATH, both at building and container image execution time.

6) Test the installation at building time by inserting in the **%post** section of the recipe the commands 
	
		which gcc									(1.1)
		gcc --version 									(1.2)

7) Add the commands for creating the directory **/workdir** into the final container image. 

8) copy the file "hello\_world\_openMP.c" in **/data/** directory 


Build the Singularity container
-------------------------------

Build your Singularity container on Piz Daint using the fakeroot feature, that is available on the compute nodes.

Submit an interactive job by the command: 
	
	$ srun -C gpu -A class02 --reservation=prace --pty -u bash				(1.3)

then load the following modules
	
	$ module load daint-gpu									(1.4)
	$ module load singularity 								(1.5)

**WARNING:** Please unload the xalt module, in order to avoid an not-important error at runtime:
	
	$ module unload xalt									(1.6) 


Finally build your Singularity container sandbox:

	$ singularity build --fakeroot --fix-perms --sandbox ex_01.sandbox Singularity_01_OpenMP	(1.7)

During the building phase, check on the terminal the output of the commands (1.1) and (1.2):

Questions: 

- Where is the gcc binary located? Is it in **/usr/bin/gcc** or in **/opt/rh/devtoolset-7/root/usr/bin/gcc** path?
- What is the version of gcc printed in standard output? Is it version 7.\*, or 4.\* ? 

Interact with the container sandbox
-----------------------------------
  
After that the sandbox has been created, let's check the property of your container image with the command:

	$ singularity inspect ex_01.sandbox 							(1.8)

Then, test your GNU compiler v7 installation by executing the command 

	$ singularity exec ex_01.sandbox gcc --version						(1.9)

Is the gcc v7 available in $PATH? 

If not, please take care of the fact that the environment variables set at building time (e.g in the **%post** section of your recipe) are not maintained at container execution time. To have the environment variables set and available in the container image at the  execution time, you have to export the environment variables into the **%environment** section of your recipe. 

So, modify properly your recipe, build again the container by the command (1.7) and check again the version of gcc available in $PATH by the command (1.9). 

Use the Singularity sandbox for development purpouses
-----------------------------------------------------

The container image SIF is immutable. Thus, during the development phase of a software stack and/or applications, it would be more convenient to build a Singularity sandbox container. Such sandbox will be the place where it is possible to install and develop models, tests, software stack, etc. Then, when the development is completed, it is possible to convert such a sandbox into an immutable SIF image container to run into the production system. 

Open a writable shell into the sandbox by the command:

	$ singularity shell --fakeroot --writable ex_01.sandbox					(1.10)

The prompt will change to: 

	$ Singularity>   

All the changes will stay within the sandbox space, no-exchange with the host will be done. 

Now compile and run the hello\_world\_openMP.c inside the sandbox

	$ Singularity> cd /data
	$ Singularity> gcc -o hello_world_openMP.bin -fopenmp   hello_world_openMP.c 
	$ Singularity> export OMP_NUM_THREADS=4
	$ Singularity> ./hello_world_openMP.bin 

If everything was correct you should see the following output:

	Hello World... from thread = 0
	Hello World... from thread = 1
	Hello World... from thread = 2
	Hello World... from thread = 3

Convert the sandobox in an immutable SIF image and execute a command in the container
-------------------------------------------------------------------------------------

Now, exit from the container sandbox and convert such sandbox in a SIF image by the command: 

	$ singularity build --fakeroot --fix-perms ex_01.sif ex_01.sandbox  			(1.11)

Then execute the **hello\_world\_openMP.bin** binary available in the container.
 
Open a new shell in Piz Daint, load the modules:

	$ module load daint-gpu
	$ module load singularity
	$ module unload xalt 

and then exec the **hello world** in the container 

	$ srun -C gpu -A class02 -N1 --reservation=prace singularity exec ex_01.sif /data/hello_world_openMP.bin

How many threads are running? 

Note that the environments variables defined in the host are visible also in the container. 

Solution
--------

The complete solution of the exercise is in the recipe **Singularity\_01\_OpenMP**  available in this repo directory.


