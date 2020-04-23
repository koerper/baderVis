#!/bin/bash

baderVis_dir=ROOT_DIR
vmd=VMD_PATH

if [[ -e bader.mol2 && baderVis.pdb ]]
then
    $vmd -e $baderVis_dir/utilities/bader_single.tcl 
    exit 1

elif [[ -e 00/bader.mol2 && baderVis.pdb ]]
then
     $vmd -e $baderVis_dir/utilities/bader_neb.tcl 
     exit 1

else
    echo "Couldn't find bader.mol2 and/or baderVis.pdb. Did you use baderProc.sh? Are you sure you are in the right place?"
fi
