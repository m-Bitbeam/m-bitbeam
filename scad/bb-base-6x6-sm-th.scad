// NAME: Base plate 6x6 Smooth Thin
// LDRAW: 2

include <bitbeam-lib/bitbeam-lib.scad>

translate([unit*-2.5, unit*-2.5, unit*0.5])
    color("green")
    cube_base(6, 6, x2=6, h=0.5, fill_holes=false);