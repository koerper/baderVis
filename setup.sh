#!/bin/bash

#### Set according to your machine ####
vmd_path='usr/local/bin/vmd'
bader_path='/home/tim/bin/bader'
openbabel_path='/usr/local/bin/babel'
#######################################

# Do not make changes from this point
baderVis_dir=$(pwd)

# baderSet
sed -i "s,ROOT_DIR,${baderVis_dir}," bin/baderProc.sh

# baderProc
sed -i "s,ROOT_DIR,${baderVis_dir}," bin/baderProc.sh
sed -i "s,BADER_PATH,${bader_path}," bin/baderProc.sh
sed -i "s,BABEL_PATH,${openbabel_path}," bin/baderProc.sh

# baderVis
sed -i "s,ROOT_DIR,${baderVis_dir}," bin/baderVis.sh
sed -i "s,VMD_PATH,${vmd_path}," bin/baderVis.sh
