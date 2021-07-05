#!/bin/bash
#SBATCH -N 2  
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH -A class02 
#SBATCH -C gpu 
#SBATCH --reservation=prace
#SBATCH --job-name=hpl

module load daint-gpu
module load singularity/3.6.4-daint
module unload xalt

echo "### HPL execution"
srun singularity exec --bind <dir_to_ex_03>/exercise_03_HPL  hpl.sif  /workdir/hpl-2.3/bin/Linux_blas/xhpl


