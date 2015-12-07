
/*
charniere casto http://www.castorama.fr/store/Lot-de-2-charnieres-universelles-nylon-noir-40-mm-prod6070118.html

public module:

  hinge_40mm(angle)
    angle: [-90:+90], default=0
        change the angle between the 2 sides
  
public variables:

    hinge_l = length of the hingle
    hinge_w = width of the base of the hingle
    hinge_r = radius of the hingle (between the center of the hingle and the outside of the base)
    hinge_hole_d = diameter of the 2 screw holes
    hinge_hole1_dx = position from the border of the base of the first hole for the screw
    hinge_hole2_dx = position from the border of the base of the second hole for the screw

*/

hinge_l = 40.3;
hinge_w = 10.3;
hinge_hole_d = 3;
hinge_hole1_dx = 4.5;
hinge_hole2_dx = 26.5;
hinge_side_base_h = 3.4;
hinge_side_inside_r = 3.4;
hinge_side_outside_r = 8.7/2;
hinge_r = hinge_side_base_h + hinge_side_outside_r;

module hinge_side_part(l) {
    difference() {
        union() {
            translate([0, -hinge_side_outside_r,-hinge_side_outside_r])
                cube([l, hinge_side_outside_r*2, hinge_side_outside_r]);
            translate([0,0,0]) rotate([0,90,0]) cylinder(r=hinge_side_outside_r, h=l);
      }
      translate([-0.1,0,0]) rotate([0,90,0]) cylinder(d=hinge_hole_d, h=l+0.2);
    }
}

module hinge_side() {
    translate([0,-hinge_w/2,-hinge_r]) {
        difference() {
            cube([hinge_l, hinge_w, hinge_side_base_h]);
            translate([hinge_hole1_dx, hinge_w/2, -0.1]) cylinder(h=hinge_side_base_h+0.2, d=hinge_hole_d);
            translate([hinge_hole2_dx, hinge_w/2, -0.1]) cylinder(h=hinge_side_base_h+0.2, d=hinge_hole_d);
        }
    }
    translate([9,0,0]) hinge_side_part(11);
    translate([hinge_l-9,0,0]) hinge_side_part(9);
}

module hinge_axe() {
    rotate([0,90,0]) cylinder(h=hinge_l, d=3.4);
    translate([hinge_l,0,0]) rotate([0,90,0]) cylinder(h=0.5, d=6.9);
}

module hinge_40mm(angle=0) {
    translate([-hinge_l/2, 0, 0]) {
        hinge_side();
        hinge_axe();
        rotate([angle,0,0]) 
            translate([hinge_l/2,0,0]) rotate([0,180,0]) translate([-hinge_l/2,0,0])
                hinge_side();
    }
}

//hinge_40mm();
