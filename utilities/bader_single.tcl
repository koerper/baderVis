set mol [mol addfile baderVis.pdb waitfor all]
set lat [pbc get]
set nf [molinfo $mol get numframes]
set sel [atomselect $mol all]
animate delete all

$sel frame 0
set mol_tmp [mol addfile bader.mol2]
set sel_tmp [atomselect $mol_tmp all]
$sel set user [$sel_tmp get charge] 

$sel delete
unset sel

pbc set [expr $lat] -all

mol modcolor 0 0 User
mol modstyle 0 0 VDW 0.800000 12.000000
mol selection all
mol modmaterial 0 0 AOChalky
mol colupdate 0 0 1
mol scaleminmax 0 0 auto
