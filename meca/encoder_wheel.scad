
include <hub_pololu_6mm.scad>
encoder_wheel_r = 23; // 46
encoder_wheel_torus_d = 3.6;
encoder_wheel_inside_r = encoder_wheel_r - encoder_wheel_torus_d + 1.6; // estimation = 21mm
echo("encoder_wheel_inside_r", encoder_wheel_inside_r);
encoder_wheel_w = 4.5;

module encoder_wheel() {
    translate([4.5/2,0,0]) rotate([0,90,0])
    union() {
        translate([0,0,-4.5/2]) difference() {
            cylinder(r=encoder_wheel_inside_r, h=4.5);
            for( i = [30:60:330]) 
                translate([cos(i)*hub_pololu_6mm_holes_r, sin(i)*hub_pololu_6mm_holes_r, -0.1])
                    cylinder(d=3, h=4.5+0.2);
            translate([0,0,-0.1]) cylinder(r=hub_pololu_6mm_small_axe_r,h=4.5+0.2); 
        }
        rotate_extrude(convexity = 10)
            translate([encoder_wheel_inside_r, 0, 0])
                circle(d=encoder_wheel_torus_d); 
    }
}

/*
translate([0+hub_pololu_6mm_small_axe_h,0,0]) mirror(1,0,0) hub_pololu_6mm();
encoder_wheel();
//*/