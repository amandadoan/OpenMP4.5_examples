#!/bin/bash
#SBATCH --job-name=dotp
#SBATCH --partition workq
#SBATCH --nodes=1
#SBATCH --time=00:05:00
#SBATCH --exclusive
#SBATCH -C K40
#SBATCH -o log.out
#SBATCH --gres=gpu

export OMP_NUM_THREADS=4

module list

time -p srun --ntasks 1 --ntasks-per-node 1 ./dot_product

