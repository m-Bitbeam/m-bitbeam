// NAME: Shaft 1.5
// LDRAW: 0
// CATEGORY: Support

include <bitbeam-lib/bitbeam-lib.scad>
use <lib/shafts.scad>
use <lib/pins.scad>

color("#404040")
{
    t_shaft(1.5);
    
    difference(){
        pin(1.5);
        translate([0, 0, -unit*0.75+0.5])
            cube(unit, true);
    }
    
    translate([0, 0, -unit*0.25])
        difference(){
            cylinder(d1=4.3, d2=4.6, h=0.5);
            
            translate([0, 4.8/2+1, 0.25])
                cube([unit, 3.1, 0.6], center=true);
            translate([0, -4.8/2-1, 0.25])
                cube([unit, 3.1, 0.6], center=true);
        }
}