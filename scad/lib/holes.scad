include <../bitbeam-lib/bitbeam-lib.scad>

module shaft_hole(size){
    difference(){
        cylinder(d=hole, h=size*unit+0.1, center=true);
        for (y = [-1, 1])
            translate([0, 4*y, 0])
            cube([3.9, 3.9, size*unit+0.2], true);
    }
    translate([0, 0, (-size*unit-0.1)/2])
        cylinder(d1=hole+0.5, d2=4, h=0.5);
}

shaft_hole(1);


module cap(){
    difference(){
        cylinder(d=5.2, h=edge*2);
        translate([0, 0, -0.01])
        cylinder(d1=5, d2=4.6, h=edge+0.01);
    }

}
