# Setup
## Install Charliecloud locally
1. Copy the Charliecloud tar.gz file to a location in your local directory.
2. Unpack the tar.gz archive
```
$ tar -xvf charliecloud.tar.gz
```
3. configure and build the Charliecloud application
```
$ ./configure --prefix=/location/of/the/application
$ make
$ make install
'''
4. Add the Charliecloud bin directory to your path and test
'''
$ export PATH=/location/of/the/application/bin:$PATH
$ ch-run
```
## Additional steps for Piz Daint
1. unset the LD_PRELOAD (removes "false" error messages in the container runtime.)
```
$ unset LD_PRELOAD
```
2. Inject Cray MPI into the container to fix specific Cray MPI issues (for more details see the official ch-fromhost documentation). This is required for every container using MPI.
```
$ fromhost --cray-mpi ./container
```
This might generate the following errors :
```
/sbin/ldconfig: Can't stat /libx32: No such file or directory
/sbin/ldconfig: Can't stat /usr/libx32: No such file or directory
```
This is a known issue, ldconfig is called by ch-fromhost and attempts to stat this directories which will fail. This issue, while annoying, is non-fatal to the ch-fromhost process and can be ignored.
