#!/bin/bash
#SBATCH -N 2 
#SBATCH --ntasks-per-node=3
#SBATCH --time=00:10:00
#SBATCH -A class02 
#SBATCH -C gpu 
#SBATCH --job-name=mpi_multi-node

module load daint-gpu
module load singularity/3.6.4-daint
module unload xalt

module list 

srun singularity exec ex_02.sif /data/hello_world_MPI.bin  



