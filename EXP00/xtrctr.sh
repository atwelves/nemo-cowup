#!/bin/bash
#SBATCH --job-name=xtrctr
#SBATCH --account=project_2002251
#SBATCH --partition=fmi
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=150G
#SBATCH -o xtrctr_out.log
#SBATCH -e xtrctr_err.log
#SBATCH --ntasks=1
#SBATCH --nodes=1

module load python-data

# check for any files

dir="/scratch/project_2002251/twelves/nemo-gof/EXP_FABM"
files=$(find $dir -mindepth 1 -type f -name "BALgof_1h*")
echo "list of files"
echo $files

# need to add a loop here to keep this running...

while [[ ( -n $files ) ]];
do
	# pause to prevent opening file currently being written...
	sleep 10m
	for file in $files
	do
		echo "file!"
		echo $file
		ext="profile"
		new_name=${file/BALgof/$ext}
		tmp_name="$dir/temp_file.nc"
		py_name="$dir/output.nc"
		mv $file $tmp_name
		python get_points.py
		mv $py_name $new_name
		rm tmp_name
		echo $new_name
	done
	files=$(find $dir -mindepth 1 -type f -name "BALgof_1h*")
done
