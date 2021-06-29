
# Charliecloud tutorial introduction #
In these exercises we will be working with Charliecloud HPC containers. Containers are an OS-level virtualization paradigm that allow multiple, isolated user environments to run concurrently. There are several different container technologies that address a variety of use cases and due to the Open Container Initiative (OCI), we can convert containers from one format to another.

The first container technology that most people learn is Docker. Docker is designed in such a way that the identity access management (IAM) model does not map well to HPC systems. That is, you must have escalated privledges (root) in order to use it. Because of this, most HPC systems do not support Docker. However, there are multiple, alternative HPC container technologies such as Singularity, Charliecloud and Sarus that allow users to run Docker/OCI containers in userspace without admin privledges.

In these exercises, we will take Docker containers, convert them to Charliecloud containers and then run them on the cluster. 

Install Docker and Charliecloud
First install Docker and Charliecloud on your local system where you have root access.
For Docker use the OS repository if posssible using apt, yum or zypper
For Charliecloud follow the instructions from the website https://hpc.github.io/charliecloud/
Build HPC containers from Dockerfiles ON THE DESKTOP OR LAPTOP (DEMONSTRATED)

Build docker image from Dockerfile
In the directory where the Dockerfile is located, execute the following command:
```
$ sudo docker build -t image_name .
```
View the new Docker image in your local Docker repository:
```
$ sudo docker image ls
```
| REPOSITORY | TAG | IMAGE ID | CREATED | SIZE |
| ---------- | --- | -------- | ------- |----- |
| image_name | latest | 02d6e22ec5ec | 2 days ago | 5.74GB |
| bash | latest | 16463e0c481e | 7 weeks ago | 15.2MB |
| ubuntu | 16.04 | 7e87e2b3bf7a | 7 months ago | 117MB |
| debian | stretch | de8b49d4b0b3 | 8 months ago | 101MB |

Convert docker image to charliecloud on desktop
```
$ sudo ch-builder2tar image /dir/to/save
```
This creates the file /dir/to/save/image_name.tar.gz

Copy the tar.gz file to the HPC system

Exercises
1.	Basic container
    1.	Mounting in the container directories from the host
    2.	Using applications and libraries from the host module system 
    3.	MPI helloworld example
2.	TensorFlow container
    1.	Distributed training example with MPI
3.	Julia based quantum gate simulator 
    1.	Setting the environment to the Docker environment
4.	oneAPI HPC container
    1.	Using LLVM compilers
    2.	Using profiling tools
 
If time permitting a simple Cuda example for GPUs
