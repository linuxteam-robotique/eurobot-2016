
/*
charniere casto http://www.castorama.fr/store/Lot-de-2-charnieres-universelles-nylon-noir-40-mm-prod6070118.html
42.50 x 10.50 x 15.50 d8.8
*/
$fn=32;

hinge_h = 40.3;
hinge_w = 10;
hinge_l = 10.50;
hinge_hole_d = 3;
hinge_hole1_dx = 4.5;
hinge_hole2_dx = 26.5;

translate([0,-hinge_w/2,0]) {
    difference() {
        cube([hinge_h, hinge_w, 3.4]);
        translate([hinge_hole1_dx, hinge_w/2, -0.1]) cylinder(h=3.5+0.2, d=3);
        translate([hinge_hole2_dx, hinge_w/2, -0.1]) cylinder(h=3.5+0.2, d=3);
    }
}

translate([9,0,0]) difference() {
    union() {
        translate([0, -8.7/2,0]) {
        translate([0, 0, 3.4]) cube([11, 8.7, (12-3.4-8.7/2)]);
        }
    translate([0, 0, 3.4+8.7/2]) rotate([0,90,0]) cylinder(d=8.7, h=11);
  }
  translate([-0.1, 0, 3.4+8.7/2]) rotate([0,90,0]) cylinder(d=3, h=11+0.2);
}

translate([hinge_h-9,0,0]) difference() {
    union() {
        translate([0, -8.7/2,0]) {
        translate([0, 0, 3.4]) cube([9, 8.7, (12-3.4-8.7/2)]);
        }
    translate([0, 0, 3.4+8.7/2]) rotate([0,90,0]) cylinder(d=8.7, h=9);
  }
  translate([-0.1, 0, 3.4+8.7/2]) rotate([0,90,0]) cylinder(d=3.4, h=9+0.2);
}


// tube diameter 3.4, 41.8-hinge_h tete 6.9
translate([0,0,3.4+8.7/2]) rotate([0,90,0]) cylinder(h=hinge_h, d=3.4);
translate([-0.5,0,3.4+8.7/2]) rotate([0,90,0]) cylinder(h=0.5, d=6.9);