## Description
Tool to analyze the charge evolution in a reaction pathway as investigated with the nudged elastic band (NEB) method.

```
baderVis
│   README.md
│   setup.sh
│
└───bin
│   │   baderProc.sh
│   │   baderSet.sh
│   │   baderVis.sh
│   
└───examples
│   └───volmer@Mg
│
└───templates
│   │   INCAR
│   │   runscript
│   
└───utilities
    │   bader.tcl
    │   bader2pqr.py
    │   chgsum.pl
    │   get_lattice.exe
    │   get_lattice.f90
```

## Requirements
- [Open Babel](http://openbabel.org/wiki/Category:Installation)
- [Bader analysis program](http://theory.cm.utexas.edu/henkelman/code/bader/)
- [VMD 1.9.3](https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD)

## Workflow
1. Start from the NEB folder structure	
```console
foo@bar:~$ ls
00 01 02 03 04 05 06 07 08 09
```

2. Set up Bader charge analyses
  * Adapt the template files in `.../baderVis/templates/` according to your system and cluster architecture
  * Use `baderSet.sh` at the base of the NEB folder structure to create a subfolder `bader` and setup Bader charge anaylses for the respective NEB images.	
  * Run simulations
```console
foo@bar:~$ baderSet.sh 00 09
foo@bar:~$ cd bader
foo@bar:~$ for i in `seq -w 00 09`; do cd $i; sbatch runscript; cd ..; done
```

3. Process the Bader charge analyses
```console
foo@bar:~$ baderProc.sh 00 09
```

4. Visualize the Bader charges in the investigated system

```console
foo@bar:~$ baderVis.sh
```