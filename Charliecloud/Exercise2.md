# Exercise 2
## TensorFlow container example
1.	Go to the directory on the HPC system that contains the TensorFlow Charliecloud image 
2.	Execute a simple Horovod TensorFlow example, which prints out the Horovod ranks.
```
$ srun -n 2 ch-run -w ./cscs_tensorflow_image/ -- python /MPI_TEST/Horovod/simple_mpi.py
```
3.	Open the Slurm submission script file with the editor of your choice. That should look similar to :
```Shell
#!/bin/bash
#SBATCH --job-name="charliecloud_tensorflow_tutorial_mpich_test"
#SBATCH --output="output_charliecloud_horovod_tutorial_mpich_test.txt"
#SBATCH --error="error_charliecloud_horovod_tutorial_mpich_test.txt"
#SBATCH --time=00:30:00
#SBATCH -N 2 # Request two nodes
#SBATCH -n 2 # Request 2 cores; one MPI task per node

#load charliecloud module
module load charliecloud

#tensorflow cpu best practice from:
#https://software.intel.com/content/www/us/en/develop/articles/maximize-tensorflow-performance-on-cpu-considerations-and-recommendations-for-inference.html
#Recommended settings for CNN → OMP_NUM_THREADS = num physical cores
export OMP_NUM_THREADS=8

export KMP_AFFINITY=granularity=fine,verbose,compact,1,0
mpiexec -n 2 ch-run -w /home/centos/ContainersHPC/cscs_tensorflow_image --  python /tensorflow/benchmarks/scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py -
-model alexnet --batch_size 128 --data_format NCHW --num_batches 100 --distortions=False --mkl=True --local_parameter_device cpu --num_warmup_batches 10 --optimizer rmsprop --display_every 10 --variable_update horovod --horovod_device cpu --num_intra_threads 8 --kmp_blocktime 0 --num_inter_threads 2
```
4.	Submit the slurm script to the system
```
$ sbatch slurm_script.sh
```
