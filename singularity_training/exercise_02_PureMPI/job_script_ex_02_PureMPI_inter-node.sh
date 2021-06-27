#!/bin/bash
#SBATCH -N 2 
#SBATCH --ntasks-per-node=3
#SBATCH --time=00:10:00
#SBATCH -A class02 
#SBATCH -C gpu 
#SBATCH --job-name=mpi_multi-node_example

module purge
module load daint-gpu
module load singularity

# OpenMPI
srun singularity exec /scratch/snx3000/class102/singularity/exercise_02_PureMPI/ex_02.sif /data/hello_world_MPI.bin  



