# Exercise 5
## Cuda GPU container example
1.	Go to the directory on the HPC system that contains the Cuda Charliecloud image 
2.	Load the Cuda modules for Piz Daint
```
$ module load daint-gpu
$ module load cudatoolkit
$ module swap PrgEnv-cray PrgEnv-gnu
```
3.	Test that the environment is set correctly
```
$ nvccc -o sum sum.cu
$ ./sum
```
4.	Build and execute a simple cuda example inside the container
```
$ ch-run -w -b /apps/.:/apps --set-env=./simple_cuda/ch/environment ./simple_cuda -- bash
$ cd MyExamples
$ nvcc -o sum sum.cu
$ ./sum
```
