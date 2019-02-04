include <bitbeam-lib/bitbeam-lib.scad>

mdbw = 67.4;
mdbh = 62;

// kitronic motor driver board http://www.kitronik.co.uk/5620 for micro:bit
module drv_mbkitronic(){
    difference(){
        cube([mdbw, mdbh, 1.6]);

        for (y=[0, 1]){
            for (x=[0, 1]){
                translate([4+x*(mdbw-8), 4+y*(41-8), -0.05])
                    cylinder(d=4, h=1.7);
            }
        }

        for (i=[0:21]){
            translate([10+i*2.54, mdbh-6, -0.05])
                cylinder(d=1, h=1.7);
        }
    }
    translate([4, 42, 0])
        cube([mdbw-8, 10, 16]);
}

/*
translate([-unit/2+(unit*10-mdbw)/2, unit/2+(unit*8-mdbh)/2, 0])
    color([0.2, 0.2, 0.2])
    kitronic_mdb();
*/

module bb_drv_mbkitronic(){
    difference(){
        translate([-unit/2, unit/2, -unit*0.5])
            cube([unit*10, unit*8, unit*0.25]);

        translate([-unit/2+(unit*10-mdbw)/2, (unit*8-mdbh)/2+mdbh-6, -unit*0.5-0.05])
            cube([mdbw, 8, 2.1]);

        translate([-unit/2+(unit*10-mdbw)/2, unit/2+(unit*8-mdbh)/2, -unit*0.5])
            for (y=[0, 1]){
                for (x=[0, 1]){
                    translate([4+x*(mdbw-8), 4+y*(41-8), -0.05])
                        cylinder(d=4, h=2.1);
                }
            }
    }

    translate([-unit/2, unit/2, -unit*0.5])
        cube([unit*0.5, unit*8, unit*0.5]);
    translate([-unit/2+unit*9.5, unit/2, -unit*0.5])
        cube([unit*0.5, unit*8, unit*0.5]);

    for (y=[0, 1]) {
        for (x=[0, 1]) {
            translate([x*unit*(8-y), y*unit*9, 0])
                cube_arm(2+y, side_holes=false);
        }
    }
}


translate([4-5*unit, 4-5*unit, 4])
    bb_drv_mbkitronic();

/*
translate([-unit/2+(unit*10-mdbw)/2+4-5*unit, unit/2+(unit*8-mdbh)/2+4-5*unit, 4])
    color([0.2, 0.2, 0.2])
    drv_mbkitronic();
*/