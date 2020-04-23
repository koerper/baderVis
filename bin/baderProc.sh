#!/bin/bash

# Description: execute at base of NEB folder structure

baderVis_dir='ROOT_DIR'
bader='BADER_PATH'
babel='BABEL_PATH'


while getopts ":m:" opt; do
  case $opt in
    m)
      if [[ "$OPTARG" == "neb" ]]
      then
	  rm -f baderVis.pdb

	  for i in `seq -w 00 99`
	  do		 
	      if [[ ! -d $i ]]
		 then
		     break
		 fi
	  cd $i
	     if [ ! -e POTCAR ]
	     then
		 echo "POTCAR missing! Cannot continue! Check your Bader calculation!"
		 exit 1
	     fi
	     echo "Compute Bader charges of folder ${i} ..."
	     if [ ! -e AECCAR0 ] || [ ! -e AECCAR2 ]
	     then
		 echo "AECCAR files missing. Skipping this step."
	     elif [ -e ACF.dat ]
	     then
		 echo "ACF.dat file found. Skipping this step."
	     else
		 $baderVis_dir/utilities/chgsum.pl AECCAR0 AECCAR2 > /dev/null 2>&1
		 $bader CHGCAR -ref CHGCAR_sum > /dev/null 2>&1
	     fi
	     echo "Wrap things up ..."
	     if [ ! -e ACF.dat ]
	     then
		 echo "ACF.dat missing! Cannot continue! Check your Bader calculation!"
		 exit 1
	     fi
	     python $baderVis_dir/utilities/bader2pqr.py
	     $babel -ipqr bader.pqr -omol2 bader.mol2 > /dev/null 2>&1
	     $babel -ivasp CONTCAR -opdb CONTCAR.pdb > /dev/null 2>&1
	     cat CONTCAR.pdb | grep -v "CONECT" >> ../baderVis.pdb
	     rm CONTCAR.pdb bader.pqr 
	     echo "Finished folder ${i}!"
	     cd ..
	  done
      elif [[ "$OPTARG" == "single" ]]
      then
	  if [ ! -e POTCAR ]
	  then
	      echo "POTCAR missing! Cannot continue! Check your Bader calculation!"
	      exit 1
	  fi
	  echo "Compute Bader charges ..."
	  if [ ! -e AECCAR0 ] || [ ! -e AECCAR2 ]
	  then
	      echo "AECCAR files missing. Skipping this step."
	  elif [ -e ACF.dat ]
	  then
	      echo "ACF.dat file found. Skipping this step."
	  else
	      $baderVis_dir/utilities/chgsum.pl AECCAR0 AECCAR2 > /dev/null 2>&1
	      $bader CHGCAR -ref CHGCAR_sum > /dev/null 2>&1
	  fi
	  echo "Wrap things up ..."
	  if [ ! -e ACF.dat ]
	  then
	      echo "ACF.dat missing! Cannot continue! Check your Bader calculation!"
	      exit 1	  
	  fi
	  python $baderVis_dir/utilities/bader2pqr.py
	  $babel -ipqr bader.pqr -omol2 bader.mol2 > /dev/null 2>&1
	  $babel -ivasp CONTCAR -opdb CONTCAR.pdb > /dev/null 2>&1
	  cat CONTCAR.pdb | grep -v "CONECT" > baderVis.pdb
	  rm CONTCAR.pdb bader.pqr 
	  echo "Finished folder!"
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

if (( $OPTIND == 1 )); then
   echo "Missing flag! Set either \"-m single\" or \"-m neb\"."
fi
