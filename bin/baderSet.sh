#!/bin/bash

folder_root=$(pwd)
baderVis_dir='ROOT_DIR'

if [ ! -e POTCAR ] || [! -e KPOINTS ] || ([ ! -e POSCAR ] && [ ! -e CONTCAR ] && [ ! -e 00/POSCAR ])
then
    echo "Essential files are missing! Are you sure you are in the directory of a VASP calculation?"
    exit 1
fi

mkdir bader
cd bader


while getopts ":m:" opt; do
  case $opt in
    m)
      if [[ "$OPTARG" == "neb" ]]
      then
	  for i in `seq -w 00 99`
	  do		 
	      if [[ ! -d $folder_root/$i ]]
	      then
		  break
	      fi
	      mkdir $i
	      cp $folder_root/POTCAR $i/.
	      cp -f $folder_root/$i/POSCAR $i/POSCAR
	      cp -f $folder_root/$i/CONTCAR $i/POSCAR
	      cp $folder_root/KPOINTS $i/.
	      cp $baderVis_dir/templates/runscript $i/.
	      cp $baderVis_dir/templates/INCAR $i/.
	  done
      elif [[ "$OPTARG" == "single" ]]
      then
	  cp $folder_root/POTCAR .
	  cp -f $folder_root/POSCAR POSCAR
	  cp -f $folder_root/CONTCAR POSCAR
	  cp $folder_root/KPOINTS .
	  cp $baderVis_dir/templates/runscript .
	  cp $baderVis_dir/templates/INCAR .
      else
	  echo "Cannot understand argument after -m! Try \"neb\" or \"single\"!"
      fi
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

cd ..

if (( $OPTIND == 1 )); then
   echo "Missing flag! Set either \"-m single\" or \"-m neb\"."
fi



