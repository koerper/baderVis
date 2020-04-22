#!/bin/bash

neb_root=$(pwd)
baderVis_dir='ROOT_DIR'

mkdir bader
cd bader
for i in `seq -s " " -f %02g $1 $2`
do
   mkdir $i
   cp $neb_root/$i/POTCAR $i/.
   cp $neb_root/$i/CONTCAR $i/POSCAR
   cp $neb_root/$i/KPOINTS $i/.
   cp $baderVis_dir/templates/runscript $i/.
   cp $baderVis_dir/templates/INCAR $i/.
done
cd ..
