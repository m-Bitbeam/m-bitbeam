// NAME: Terrain Wheel 7x3
// CATEGORY: Wheel
// LDRAW: 8

include <bitbeam-lib/bitbeam-lib.scad>
use <lib/wheel.scad>

color("gray"){
    large_wheel(7,3);
    for (a=[0:0.6:360])
        rotate([0, 0, a])
        translate([unit*3.46, 0, a % 4*5.41+1.7])
        hull(){
            cube([1, 2, 2.5], true);
            translate([1, 0, 0])
            cube([1, 1, 1.2], true);
        }
}
