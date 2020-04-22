set mol [mol addfile neb_animation.pdb waitfor all]
set lat [pbc get]
set nf [molinfo $mol get numframes]
set sel [atomselect $mol all]
animate delete all
for {set i 0} {$i < $nf} {incr i} {
$sel frame $i
    set mol_tmp [mol addfile [format "%02d" $i]/bader.mol2]
    set sel_tmp [atomselect $mol_tmp all]
    $sel set user [$sel_tmp get charge]
}
$sel delete
unset sel

#pbc set {9.556    9.556   32.625  90.00  90.00 120.00} -all
pbc set [expr $lat] -all

mol modcolor 0 0 User
mol modstyle 0 0 VDW 0.800000 12.000000
mol selection all
mol modmaterial 0 0 AOChalky
mol colupdate 0 0 1
mol scaleminmax 0 0 auto
