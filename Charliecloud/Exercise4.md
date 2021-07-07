# Exercise 4
## Intel oneAPI HPC container example
1.	Go to the directory on the HPC system that contains the intel_hpc_oneapi Charliecloud image.
2.	Print out the default system paths based on loaded modules.
```
$ echo $PATH
/opt/ohpc/pub/libs/charliecloud/0.15/bin:/home/centos/.local/bin:/home/centos/bin:/opt/ohpc/pub/mpi/libfabric/1.10.1/bin:/opt/ohpc/pub/mpi/mpich-ofi-gnu9 ohpc/3.3.2/bin:/opt/ohpc/pub/compiler/gcc/9.3.0/bin:/opt/ohpc/pub/utils/prun/2.0:/opt/ohpc/pub/utils/autotools/bin:/opt/ohpc/pub/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
```
3.	Print out the paths based from within the container.
```
$ ch-run -w ./intel-oneapi -- bash
$ echo $PATH
/home/centos/.local/bin:/home/centos/bin:/opt/ohpc/pub/libs/charliecloud/0.15/bin:/home/centos/.local/bin:/home/centos/bin:/opt/ohpc/pub/mpi/libfabric/1.10.1/bin:/opt/ohpc/pub/mpi/mpich-ofi-gnu9ohpc/3.3.2/bin:/opt/ohpc/pub/compiler/gcc/9.3.0/bin:/opt/ohpc/pub/utils/prun/2.0:/opt/ohpc/pub/utils/autotools/bin:/opt/ohpc/pub/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/bin
$ exit
```
Simply starting a container does not set your PATH to the same as the container build environment.

However, you can use the –set-env option to modify your environment upon starting the container and if you use $IMAGE/ch/environment, it will be your original builder (Docker) runtime environment.

4.	Repeat step 3, but set the environment to the environment to the original Docker environment.
```
$ ch-run --set-env=./intel-oneapi/ch/environment -w ./intel-oneapi -- bash
$ echo $PATH
/home/centos/.local/bin:/home/centos/bin:/opt/intel/oneapi/inspector/2021.1-beta10/bin64:/opt/intel/oneapi/itac/2021.1-beta10/bin:/opt/intel/oneapi/itac/2021.1-beta10/bin:/opt/intel/oneapi/clck/2021.1-beta10/bin/intel64:/opt/intel/oneapi/debugger/10.0-beta10/gdb/intel64/bin:/opt/intel/oneapi/dev-utilities/2021.1-beta10/bin:/opt/intel/oneapi/intelpython/latest/bin:/opt/intel/oneapi/intelpython/latest/condabin:/opt/intel/oneapi/mpi/2021.1-beta10/libfabric/bin:/opt/intel/oneapi/mpi/2021.1-beta10/bin:/opt/intel/oneapi/vtune/2021.1-beta10/bin64:/opt/intel/oneapi/mkl/
2021.1-beta10/bin/intel64:/opt/intel/oneapi/compiler/2021.1-beta10/linux/lib/oclfpga/llvm/aocl-bin:/opt/intel/oneapi/compiler/2021.1-beta10/linux/lib/oclfpga/bin:/opt/intel/oneapi/compiler/2021.1-beta10/linux/bin/intel64:/opt/intel/oneapi/compiler/2021.1-beta10/linux/bin:/opt/intel/o
neapi/compiler/2021.1-beta10/linux/ioc/bin:/opt/intel/oneapi/advisor/2021.1-beta10/bin64:/opt/intel/oneapi/vpl/2021.1-beta10/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```
Now exit the container.
```
$ exit
```
Notice that the environment printed out is now the original Docker image environment.

Gotchas, tips and “real world” examples
In your dockerfile avoid building your application and copying/storing your data in /home, as when executing the Charliecloud container the users /home directory will map to the containers /home directory and you will not be able to access the data the dockerfile build placed in /home.

Mount your data directory such as $SCRATCH and/or $WORK in the container to avoid storing your data in the container.

Use the system MPI environment (via mounting) when executing on a production HPC system.

Install the software/drivers of the high performance interconnects inside the container. The transport layer can default to TCP instead of using the high performance network.

Keep your container as small as possible. As creating the container is done on your laptop or desktop.

Use the HPC module system inside the container if possible for optimized, tested and/or licensed software.
