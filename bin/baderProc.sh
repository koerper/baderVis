#!/bin/bash

# Description: execute at base of NEB folder structure

baderVis_dir='ROOT_DIR'
bader='BADER_PATH'
babel='BABEL_PATH'


if [[ -e neb_animation.pdb ]]
then
   rm neb_animation.pdb
fi

for i in `seq -s " " -f %02g $1 $2`
   do cd $i
   echo "Compute Bader charges of folder ${i} ..."
   $baderVis_dir/utilities/chgsum.pl AECCAR0 AECCAR2 > /dev/null 2>&1
   $bader CHGCAR -ref CHGCAR_sum > /dev/null 2>&1
   echo "Wrap things up ..."
   python $baderVis_dir/utilities/bader2pqr.py
   $babel -ipqr bader.pqr -omol2 bader.mol2 > /dev/null 2>&1
   $babel -ivasp CONTCAR -opdb CONTCAR.pdb > /dev/null 2>&1
   cat CONTCAR.pdb | grep -v "CONECT" >> ../neb_animation.pdb
   rm CONTCAR.pdb bader.pqr 
      echo "Finished folder ${i}!"
   cd ..
done
