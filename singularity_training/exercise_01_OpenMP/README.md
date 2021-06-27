Exercise 01 - Build and test and run your first Singularity container
=====================================================================

Write the Singularity definition file 
-------------------------------------

Login in PizDaint, move to the $SCRATCH directory and write a Singularity definition file such that:

1) use CentOS7 as Base OS. As a bootstrap source, use the CentOS release available in Docker Hub [click here](https://hub.docker.com/_/centos). 

2) add your name as author of the container 

3) update the system

4) install the following packages: vim, which, wget, tar and bzip2.

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


Build a Singularity container sandbox
---------------------------------------
Build your Singularity container sandbox on PizDaint using the fakeroot feature. 

Submit an interactive job by the command 
	
	$ srun -C gpu -A class02 --pty -u bash							(1.3)

load the singularity module

	$ module load  singularity 								(1.4)

and then build your Singularity container sandbox:

	$ singularity build --fakeroot --fix-perms --sandbox ex_01.sandbox Singularity_01	(1.5)

During the building phase, check on the terminal the output of the commands (1.1) and (1.2):

Questions: 

- Where is the gcc binary located? Is it in **/usr/bin/gcc** or in **/opt/rh/devtoolset-7/root/usr/bin/gcc** path?
- What is the version of gcc printed in standard output? Is it version 7.\*, or 4.\* ? 

Interact with the container sandbox
-----------------------------------
  
After the SIF image has been created, check the property of your container image with the command:

	$ singularity inspect ex_01.sandbox

Then, test your GNU compiler v7 installation by executing the command 

	$ singularity exec ex_01.sandbox gcc --version						(1.6)

Is the gcc v7 available in $PATH? 

If not, please take care of the fact that the environment variables set at building time (e.g in the **%post** section of your recipe) are not maintained at container execution time. To have the environment variables set and available in the container image at the  execution time, you have to export the environment variables into the **%environment** section of your recipe. 

So, modify properly your recipe, build again the container by the command (1.5) and check again the version of gcc available in $PATH by the command (1.6). 


Use the Singularity sandbox for development purpouses
-----------------------------------------------------

The container image SIF is immutable. Thus, during the development phase of a software stack and/or applications, it would be more convenient to build a Singularity sandbox container. Such sandbox will be the place where it is possible to install and develop models, tests, software stack, etc. Then, when the development is completed, it is possible to convert such a sandbox into an immutable SIF image container to run into the production system. 

Open a shell into the sandbox built during the exercise 01 by the command:

	$ singularity shell --fakeroot --writable ex_01.sandbox

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

Convert the sandobox in an immutable SIF image
----------------------------------------------

Now, exit from the container sandbox and convert such sandbox in a SIF image by the command: 

	$ singularity build --fakeroot --fix-perms ex_01.sif ex_01.sandbox  

Then execute the **hello\_world\_openMP.bin** binary in the container: 

	$ export OMP_NUM_THREADS=4
	$ singularity exec ex_01.sif /data/hello_world_openMP.bin

The output will be the same as before.

Note that the environment variables defined in the host are visible also in the container. 

Solution
--------

The complete solution of the exercise is in the recipe Singularity\_01\_OpenMP\_complete present in this repo directory.


