Exercise 04 - Singularity and NVIDIA GPUs
=========================================

Goals: 
------
1. Compile an application using CUDA inside a container
2. Run a container on GPUs

Build the container image
-------------------------

Aim of this exercise is build a container with the 'gpu burn' code and test it on GALILEO GPU nodes. 

Write a Singularity recipe starting from the nvidia/cuda:9.0-devel-centos7 docker repository. 

Install git application and clone the gpu-burn repo, available at https://github.com/wilicc/gpu-burn.git. 

We suggest creating a temporary directory where you put the source code (as an example /opt). 

Compile gpu-burn code using make command. Please, follow the instruction in README.md file on gpu-burn github, In particular you need to specify the compute capability of Nvidia K80 GPU.

	export COMPUTE=37

Define a script to run gpu-burn application on GALILEO. Plase note that in order to run the **gpu\_burn 120** executable, the input file 'compare.ptx' must be in the current working directory.

Remember to export the right $PATH environment variable.

Copy and run on GALILEO 
-----------------------
Transfer your container on GALILEO, and run by submitting a job asking for 1 node and both the 2 GPUs. 

You can monitoring GPU usage with nvidia-smi tool:

	$$ ssh <node number> nvidia-smi -l 1

You can find the Singularity recipe and the slurm job script here in this repo directory.  


Multi-stage build 
------------------

We have seen during the exercise that the size of a container could be an inssue, expecially if you need to copy the image from your laptop to a HPC cluster. To reduce the size of the final image we can use multi-stage build.
Here you can find the Singularity guide about it <https://sylabs.io/guides/3.7/user-guide/definition_files.html#multi-stage-builds>

The definition file Singularity\_04\_multistage is an example of how to use it. A devel version of cuda-9 container is used to compile the source code (gpu-burn), but we use the cuda-9-runtime image as bootstrap for the final image.


