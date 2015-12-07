

include <motor_pololu_37d_19_1_encoder.scad>

module motor_pololu_37d_19_1_encoder_bracket()
{
    translate([-6.5,0,-2.0-37.6/2-7]) {
        translate([2.0,0,2.0]) rotate([0,-90,0])
        difference() {
            union() {
                translate([0,-37.6/2,0]) cube([37.6/2, 37.6, 2.0]);
                translate([37.6/2,0,0]) cylinder(d=37.6, h=2.0);
            }
            translate([37.6/2,0,0])
                for(i = [30:60:330]) 
                    translate([cos(i)*15.5, sin(i)*15.5, -0.1])
                        cylinder(d=3.3, h=2.0+0.2);
            translate([37.6/2-7,0,-0.1])
                cylinder(d=13.2,h=2.0+0.2);
            translate([37.6/2+7,0,-0.1])
                cylinder(d=13.2,h=2.0+0.2);
            translate([37.6/2-7,-13.2/2,-0.1])
                cube([14,13.2,2.0+0.2]);
        }

        translate([2.0,0,0]) rotate([0,0,180])
        difference() {
            translate([0,-37.6/2,0]) cube([49.2+2.0, 37.6, 2.0]);
            for(i=[0:6.4:7*6.4]) {
                translate([i+8.4,+(37.6/2-3.2),-0.1]) cylinder(d=3.2,h=2.0+0.2);
                translate([i+8.4,-(37.6/2-3.2),-0.1]) cylinder(d=3.2,h=2.0+0.2);
            }
        }
    }
}


/*
motor_pololu_37d_19_1_encoder_bracket();
//*/
