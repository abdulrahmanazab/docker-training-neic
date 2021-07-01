Exercise 04 - Singularity and NVIDIA GPUs
=========================================

Build the container image
-------------------------

Aim of this exercise is build a container with the 'gpu burn' code and test it on Piz Daint GPU nodes. 

Write a Singularity recipe starting from the nvidia/cuda:10.2-devel-centos7 docker repository. 

Install git application and clone the gpu-burn repo, available at https://github.com/wilicc/gpu-burn.git. 

We suggest creating a temporary directory where you put the source code (as an example /opt). 

Compile gpu-burn code using make command. Please, follow the instruction in README.md file on gpu-burn github, In particular you need to specify the compute capability of Nvidia Tesla P100-PCIE-16GB GPU.

	export COMPUTE=60

Define a script to run gpu-burn application on Piz Daint. Plase note that in order to run the **gpu\_burn 240** executable, the input file 'compare.ptx' must be in the current working directory.

Remember to export the right $PATH environment variable.

Build and run on Piz Daint
--------------------------

Build the container on Piz Daint compute node with fakeroot, as in the previous exercises and run by submitting a job asking for 1 node. 

You can monitoring GPU usage with nvidia-smi tool:

	$ ssh <node number> nvidia-smi -l 1


Al alternative approach is to create an allocation and log onto the compute node directly, by using the command: 

	$ srun -C gpu -A <account> --pty -u -N1 bash -l. 

This will give you an interactive shell on the compute node. There you can run your gpu\_burn directly and on the background: 

	$ singularity exec --nv ex_04.sif /opt/gpu-burn/gpu_burn.sh > gpu_burn.out &

While gpu\_burn executes on the background you can run nvidia-smi to check what is happening on the gpu.


Multi-stage build 
------------------

We have seen during the exercise that the size of a container could be an inssue, expecially if you need to copy the image from your laptop to a HPC cluster. To reduce the size of the final image we can use multi-stage build.
Here you can find the Singularity guide about it <https://sylabs.io/guides/3.7/user-guide/definition_files.html#multi-stage-builds>

The definition file Singularity\_04\_multistage is an example of how to use it. A devel version of cuda-10 container is used to compile the source code (gpu-burn), but we use the cuda-10-runtime image as bootstrap for the final image.

Solution
--------

You can find the Singularity recipe and the slurm job script here in this repo directory.  
