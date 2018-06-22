#!/bin/bash
#SBATCH --job-name=hello
#SBATCH --partition workq
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --time=00:05:00
#SBATCH --export=ALL
#SBATCH -o log.out

export OMP_NUM_THREADS=4

module load craype-accel-nvidia35
module load cudatoolkit
module load perftools-lite
module list

time -p srun --ntasks 2 --ntasks-per-node 2 --cpus-per-task 4 ./hello_world_with_threads
