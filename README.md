## Requirements
- openBabel
- Bader scripts
- vmd
- NEB folder structure

## Workflow
#### set up bader charge calculation
- NEB folder structure as a start
- copy POSCARs and CONTCARs and start Bader charge calculations in similar folder structure
- 
#### process bader results
- use Bader scripts to get ACF.dat file [Bader program](http://theory.cm.utexas.edu/henkelman/code/bader/)
- convert ACF to bader.pqr to bader.mol2
- convert CONTCAR to pdb and create animation.pdb file

#### 
- use baderVis.sh at first level of Bader folder structure with tcl script as input