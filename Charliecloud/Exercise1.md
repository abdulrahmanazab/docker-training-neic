# Exercise 1
## Simple container example
1.	Download the CSCS archive file to your local system.
2.	Go to the directory ……/Dockerfiles/SimpleMPI
3.	Open the file …../Dockerfiles/SimpleMPI/Dockerfile with the editor of your choice.
    1.	Examine the Dockerfile operations.
    2.	Modify the Dockerfile to copy the makefile into the /MPI_TESTS directory
4.	Build a Docker image from the Dockerfile
```
$ sudo docker build -t simple_mpi .
```
This will build a new Docker image with the name simple_mpi

5.	Verify that the new image has been added to your local Docker repository
```
$ sudo docker images
```
This should display a table of all the Docker images in your local repository.

6.	Convert the Docker image to a Charliecloud tar.gz archive
```
$ sudo ch-builder2tar simple_mpi /dir/to/save
```
This should create the file /dir/to/save/simple_mpi.tar.gz

7.	Copy the simple_mpi.tar.gz file to the HPC system

8.	Unpack the Charliecloud image archive using the Charliecloud command
```
$ ch-tar2dir simple_mpi.tar.gz /dir/for/image
```
This should create a directory /dir/for/image/simple_mpi

9.	Start a bash shell in the container
```
$ ch-run -w /dir/for/image/simple_mpi – bash
```
To verify that the container bash shell has started go to the directory /MPI_TESTS
```
$ cd /MPI_TESTS
$ ls
```
This should display the file mpi_hello_world.c

10.	Build the mpi_hello_world example using the makefile
```
$ make
```
11.	Exit the container
```
$ exit
```
12.	Allocate 2 node for interactive computing
```
$ salloc -p debug -N 2 -C gpu -A class02 --time=00:10:00
```

13.	Execute the mpi_hello_world from outside the container using the system MPI

```
$ srun -N 2 ch-run -w ./simple_mpi/ -- /MPI_TESTS/mpi_hello_world
```

14.	Mount the module system in the container
    1.	Start a bash shell in the container (see above)
    2.	In the container create a directory that matches the hosts module system parent directory.

```
$ mkdir /host/module/dir
$ exit
```

 15. Start a bash shell in the container with the mount command

```
$ ch-run -w -b /module/dir/.:/module/dir/ ./simple_mpi/ -- bash
$ ls /module/dir
$ exit
```
Note: the -w flag mounts the image read-write (by default, the image is mounted read-only)

16.	Use a application or library from the hosts module system from inside the container.
```
$ ch-run -w -b /module/dir/.:/module/dir/ ./simple_mpi/ -- host_module_app
```
