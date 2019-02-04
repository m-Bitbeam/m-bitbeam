include <bitbeam-lib/bitbeam-lib.scad>

// wheel for gear motor

$fn=60;

diameter_1 = 5.5*1.02;      // printer corection 2% bigger wheel hole
diameter_2 = 3.84*1.02;

module center(){
    difference(){
        cylinder(r=unit, h=unit, center=true);

        difference(){
            cylinder(d=diameter_1, h=unit+0.1, center=true);
            translate([0, 1.5+diameter_2/2, 0])
                cube([diameter_1, 3, unit+0.1], center=true);
            translate([0, -1.5-diameter_2/2, 0])
                cube([diameter_1, 3, unit+0.1], center=true);
        }
    }
}

// Could be use O ring 50
module o_ring_53(){
    rotate_extrude(convexity =1)
        translate([55/2+1.5, 0, 0])
        circle(d = 5);
}

module wheel_53(){
    difference(){
        cylinder(d=55, h=5, center=true);
        cylinder(d=45, h=5.1, center=true);
        o_ring_53();

        for (i = [0:3]){
            rotate([0, 0, i*90])
                translate([unit*3, 0, unit/2-2.5])
                holes(1);
        }
    }

    difference(){
        for (i = [0:3]){
            rotate([0, 0, i*90])
                translate([unit, 0, unit/2-2.5])
                cube_arm(3, side_holes=false);
        }

        o_ring_53();
        translate([0, 0, unit/2-2.5])
            difference(){
                cylinder(d=unit*8, h=unit+0.1, center=true);
                cylinder(d=55, h=unit+0.2, center=true);
            }
    }

    translate([0, 0, unit/2-2.5])
        difference(){
            rotate([0, 0, 45])
                center();
            for (i = [0:3]){
                rotate([0, 0, i*90])
                    translate([unit, 0, 0])
                    holes(1);
            }
        }
}

translate([0, 0, 2.5])
    wheel_53();
//translate([0, 0, 2.5])
//color("black")
//    o_ring_53();
