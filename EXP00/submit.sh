#!/bin/bash
#SBATCH --job-name=gof
#SBATCH --account=project_2002251
#SBATCH --partition=fmi
#SBATCH --time=72:00:00
#SBATCH --mem-per-cpu=10G
#SBATCH -o stdout.log
#SBATCH -e stderr.log
#SBATCH --ntasks=100
#SBATCH --nodes=10

module load intel-oneapi-compilers-classic
module load intel-oneapi-mpi
module load hdf5/1.12.2-mpi
module load netcdf-c
module load netcdf-fortran
module load boost/1.79.0-mpi
module list
 
srun -n 99 --nodes 9 ./nemo 
srun -n 1 --nodes 1 ./xios_server.exe 
