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

#SBATCH --ntasks=64

source /cluster/bin/jobsetup
module purge   # clear any inherited modules
set -o errexit # exit on errors


module load singularity/2.5.0
module load openmpi.gnu/1.10.2

mpirun singularity exec -B /work:/work  ~/ubuntu.simg /usr/bin/hello
