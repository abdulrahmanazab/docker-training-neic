#!/bin/bash

# Job name:
#SBATCH --job-name=Jobname
#
# Project:
#SBATCH --account=ln0004k
#
# Wall clock limit:
#SBATCH --time=00:01:00
#
# Max memory usage:
#SBATCH --mem-per-cpu=10

## Set up job environment:
source /cluster/bin/jobsetup
module purge   # clear any inherited modules
module load singularity
set -o errexit # exit on errors

## Copy input files to the work directory:

## Make sure the results are copied back to the submit directory (see Work Directory below):


## Do some work:
cd $SCRATCH
singularity exec /usit/abel/u1/<username>/ubuntu.img cat /etc/os-release
