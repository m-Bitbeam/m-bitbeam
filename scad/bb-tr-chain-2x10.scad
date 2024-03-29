// NAME: Track Chain 2x10
// CATEGORY: Wheel
// LDRAW: 0

include <bitbeam-lib/bitbeam-lib.scad>

$fn=40;

shift=12.6/2;       // track wheel X/6
// minimum wheel size 4 = maximum angle between chain pieces is 45

module socket(){
    intersection(){
        union(){
            translate([0, 0, -unit*1.5-7/3.8])
                cylinder(d1=unit*1.5, d2=unit, h=7/1.95, center=true);
            translate([0, 0, unit*1.5+7/3.8])
                cylinder(d2=unit*1.5, d1=unit, h=7/1.95, center=true);

            translate([0, 0, -7/3.8])
                cylinder(d2=unit*1.5, d1=unit, h=7/1.9, center=true);
            translate([0, 0, 7/3.8])
                cylinder(d1=unit*1.5, d2=unit, h=7/1.9, center=true);
            cylinder(d=unit, h=unit*4-1, center=true);
        }
        cylinder(d=unit*1.3, h=unit*4-1, center=true);
        hull(){
            cylinder(d=unit, h=unit*4-1, center=true);
            translate([unit, unit, 0])
                cylinder(d=unit*3, h=unit*4-1, center=true);
        }
    }
}

module track(){
    hull(){
        translate([unit*0.25,0,0])
            cube([unit/2, unit*7, 1.6], true);
        translate([unit/6,0, 3.155])
            cube([unit/3, unit*4-1, 0.1], true);
    }
    translate([unit*0.25,0,0])
        cube([unit/2, unit*10, 1.6], true);

    difference(){
        hull(){
            translate([4, 0, 0])
                cube([0.01, unit*4-1, 1.6], true);
            translate([shift, 0, 0])
                cube([0.01, unit*4-1, 1.6], true);
        }
        translate([shift+3, 0, 0])
            cube([10, 3, 5], true);
    }

    translate([shift, 0, hole/2+0.8])
        rotate([90, 0, 0])
        difference(){
            rotate([0, 0, 60])
                socket();

            cylinder(d=hole, h=unit*4, center=true);

            hull(){
                translate([0, 0, 0])
                    cylinder(d=4, h=unit*5, center=true);
                translate([0, 5, 0])
                    cylinder(d=4, h=unit*5, center=true);
            }

            translate([0, -4.3-1.7, 0])
                cube([unit*1.5, 4, unit*4], true);
            translate([0, +4.3+1.7, 0])
                cube([unit*1.5, 4, unit*4], true);

            translate([3, 0, 0])
                cube([10, 10, 3], true);
        }

    translate([-shift, 0, 4.7/2+1])
        rotate([90, 0, 0])
        cylinder(d=4.3, h=unit*5, center=true);

    for(y=[-1, 1]){
        hull(){
            translate([-shift, y*(unit*5/2-2), 4.7/2+1])
                rotate([90, 0, 0])
                cylinder(d=4.3, h=unit*0.5, center=true);
            translate([3.95, y*(unit*5/2+unit*0.25), 0])
                cube([0.1, unit*1.5, 1.6], true);
            translate([-6, y*(unit*5.5/2+unit*0.25), 0])
                rotate([90, 0, 0])
                cylinder(d=1.6, h=unit, center=true);
        }

        hull(){
            translate([0, y*(unit*8/2+unit*0.25), 0])
                cube([0.1, unit*1.5, 1.6], true);
            translate([-6, y*(unit*7.5/2+unit*0.25), 0])
                rotate([90, 0, 0])
                cylinder(d=1.6, h=unit*2, center=true);
        }
    }

    hull(){
        translate([-shift, 0, 4.7/2+1])
            rotate([90, 0, 0])
            cylinder(d=4.3, h=2, center=true);
        translate([3.95, 0, 0.8])
            cube([0.1, 2, 3.2], true);
        translate([-6, 0, 0])
            rotate([90, 0, 0])
            cylinder(d=1.6, h=2, center=true);
    }
}

color("#404040")
    track();
%translate([shift*2+0.4, 0, 5.2])
    rotate([0, -45, 0])
    track();
%translate([-shift*2, 0, 0])
    track();
