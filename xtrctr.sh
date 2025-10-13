#!/bin/bash
#SBATCH --job-name=xtrctr
#SBATCH --account=project_2002251
#SBATCH --partition=fmi
#SBATCH --time=72:00:00
#SBATCH --mem-per-cpu=150G
#SBATCH -o xtrctr_out.log
#SBATCH -e xtrctr_err.log
#SBATCH --ntasks=1
#SBATCH --nodes=1

module load python-data

# check for any files

# define stations
stat=("GF1"    "GF2"    "LL3A"   "LL4A"   "LL5"    "LL6A"   "LL7"    "LL9"    "LL11"   "LL12"  )
lats=(59.70500 59.83850 60.06717 60.01683 59.91683 59.91683 59.84650 59.70017 59.58350 59.48350)
lons=(24.68217 25.85683 26.34667 26.08017 25.59700 25.03017 24.83782 24.03017 23.29683 22.89683)

sleep 5m

dir="/scratch/project_2002251/twelves/nemo-gof/EXP_FABM"
files=$(find $dir -mindepth 1 -type f -name "IOWgof_1h*")
echo "list of files"
echo $files

# need to add a loop here to keep this running...

while [[ ( -n $files ) ]];
do
	# pause to prevent opening file currently being written...
	sleep 5m
	for file in $files
	do
		echo "file!"
		echo $file
		for i in {0..9}
		do
			# set latitude and longitude in python script
			cp -p get_points.py get_point.py
			sed -i.bak "s/#latitude/lat=${lats[$i]}/" get_point.py
			sed -i.bak "s/#longitude/lon=${lons[$i]}/" get_point.py
			new_name=${file/IOWgof/${stat[$i]}}
			tmp_name="$dir/temp_file.nc"
			py_name="$dir/output.nc"
			mv $file $tmp_name
			python get_point.py
			mv $py_name $new_name
			rm tmp_name
			rm get_point.py
			rm get_point.py.bak
			echo $new_name
		done
	done
	files=$(find $dir -mindepth 1 -type f -name "IOWgof_1h*")
done

for i in {0..9}
do
	mkdir station_${stat[$i]}
	cd station_${stat[$i]}
	mv ../${stat[$i]}* .
	cd ..
done	
