# Python MPI helloworld example to run on Abel/Colossus

Install mpi4py
---------------
```bash
module load openmpi.intel
module load python2
pip install --user mpi4py
```
hello world example
---------------------
* Create the python MPI code file:
```bash
03:28 PM login-0-2 ~/mpi4py-example> cat hw.py
#!/usr/bin/env python

from mpi4py import MPI


comm = MPI.COMM_WORLD

print "Hello! I'm rank %d from %d running in total..." % (comm.rank, comm.size)

comm.Barrier()   # wait for everybody to synchronize _here_
```
* Write the slurm script:
```bash
03:28 PM login-0-2 ~/mpi4py-example> cat hw.slurm
#!/bin/bash

# Job name:
#SBATCH --job-name=hello
#
# Project:
#SBATCH --account=staff
#
# Wall clock limit:
#SBATCH --time=0:02:00
#
# Max memory usage:
#SBATCH --mem-per-cpu=1G

#SBATCH --ntasks=4

## Set up job environment:
source /cluster/bin/jobsetup
module purge   # clear any inherited modules
set -o errexit # exit on errors

module load openmpi.intel
module load python2

## Copy input files to the work directory:
cp hw.py $SCRATCH

## Do some work:
cd $SCRATCH

mpirun python hw.py
```
* Submit the job:
```bash
03:29 PM login-0-2 ~/mpi4py-example> sbatch --ntasks 4 hw.slurm
Submitted batch job 13750925
```
* Print the output:
```bash
03:32 PM login-0-2 ~/mpi4py-example> cat slurm-13750925.out
Starting job 13750925 ("hello") on c2-[24,26] at Wed Jan 13 15:30:11 CET 2016
Hello! I'm rank 0 from 4 running in total...
Hello! I'm rank 3 from 4 running in total...
Hello! I'm rank 1 from 4 running in total...
Hello! I'm rank 2 from 4 running in total...

Currently Loaded Modulefiles:
  1) intel/2015.3          3) libffi/3.0.13
  2) openmpi.intel/1.8.8   4) python2/2.7.10

Job step resource usage:
       JobID    JobName  AllocCPUS  MaxVMSize     MaxRSS    Elapsed ExitCode
------------ ---------- ---------- ---------- ---------- ---------- --------
13750925          hello          4                         00:00:07      0:0
13750925.0         true          2    270464K      1540K   00:00:00      0:0
13750925.1        orted          1          0          0   00:00:02      0:0

Job 13750925 ("hello") completed on c2-[24,26] at Wed Jan 13 15:30:16 CET 2016
03:33 PM login-0-2 ~/mpi4py-example>
```
