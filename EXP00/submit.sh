#!/bin/bash
#SBATCH --job-name=gof
#SBATCH --account=project_2012773
#SBATCH --partition=medium
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=720G
#SBATCH -o stdout.log
#SBATCH -e stderr.log
#SBATCH --ntasks=120
#SBATCH --nodes=6

module load gcc/15.2.0
module load openmpi/5.0.10
module load boost/1.90.0
module load openblas/0.3.30
module load netcdf-c/4.9.3 netcdf-fortran/4.6.2 parallel-netcdf/1.14.1
module load hdf5/1.14.6
 
srun ./nordic_nemo.exe 
