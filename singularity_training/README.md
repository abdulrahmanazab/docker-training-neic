# Singularity @ HPC Workshop on Containers and Unikernels, On-line PRACE Event, July 5th-9th 2021

Welcome to the hands-on repository of **Singulary** at the **HPC Workshop on Containers and Unikernels** organized by **PRACE**.

In this repository are available some basic exercise to practice with singularity, organized in sub-directories. 

On the basis of how the exercise is, in the related directory you can find the recipes, the source codes and the slurm job script templates for the exercise proposed during the lessons.

The singularity tutorial is done on PizDaint cluster at CSCS.

Build a singularity container
-----------------------------

Login in Ela, than in PizDaint and move to \$SCRATCH directory, where you can write your Singularity recipes and build your container image

	$ ssh <username>@ela.cscs.ch

	$ ssh daint

	$ cd $SCRATCH 

Once that the Singularity recipe is written, load the singularity module, submit an interactive job and build your Singularity container image
  	 
   	$ cd $SCRATCH/\<subdir with the Singularity recipe\>

	$ srun -C gpu -A class02 --pty -u bash ==> submit an interactive job tu build your container with fakeroot singularity

Once that the resources for your job have been allocated, build your container image by the command:

	$ module load singularity 

	$ singularity build --fakeroot --fix-perms <SIF image name> <Singularity recipe name>


Run a container on PizDaint 
---------------------------

Submit an interactive slurm job: 

 	$ module load singularity
	$ module load 
	$ srun -C gpu -A class02 -N 2 --ntasks-per-node=2 singularity 
		

