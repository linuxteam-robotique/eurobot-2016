include <hinge_40mm.scad>
include <encoder_omron_e6b2_cwz6c_2000.scad>
include <motor_pololu_37d_19_1_encoder.scad>
// TODO include <ball_caster_pololu_xxx.scad>
// TODO add motor support in motor_pololu_...
// TODO better motor wheel?
// TODO encoder wheel

motor_wheel_r = 72/2;
motor_wheel_w = 10;
encoder_wheel_r = 50/2;
encoder_wheel_w = 4.5;

axe_padding = 1.5;
chassis_encoder_dy = 45;
chassis_motor_wheel_center_dx = 83;
chassis_motor_dx = chassis_motor_wheel_center_dx - axe_padding - motor_wheel_w/2;

chassis_encoder_center_dx = sqrt(
    chassis_motor_wheel_center_dx*chassis_motor_wheel_center_dx -
    chassis_encoder_dy*chassis_encoder_dy );
chassis_encoder_dx = chassis_encoder_center_dx-axe_padding-encoder_wheel_w/2;
chassis_thickness = 3;
chassis_l = 140;
chassis_w = 110;
chassis_z = 5;      // position in z of the chassis from the ground

debug_line_th = 0.4;
module debug() {
    for( h = [ 0, encoder_wheel_r-debug_line_th , motor_wheel_r-debug_line_th]) {
        translate([0,0,h]) {
#            difference() {
                cylinder(h = debug_line_th, r = chassis_motor_wheel_center_dx);
                translate([0,0,-0.1]) cylinder(h = debug_line_th+0.2, r = chassis_motor_wheel_center_dx-0.1);
            }
        }
    }
#    translate([-chassis_motor_wheel_center_dx, 0, 0])
        cube([chassis_motor_wheel_center_dx*2, debug_line_th, debug_line_th]);
#    translate([-chassis_motor_wheel_center_dx, -20, 0])
        cube([debug_line_th, 40, debug_line_th]);
#    translate([chassis_motor_wheel_center_dx, -20, 0])
        cube([debug_line_th, 40, debug_line_th]);
    
#    translate([-chassis_encoder_center_dx, -chassis_encoder_dy, 0])
        cube([chassis_encoder_center_dx*2, debug_line_th, debug_line_th]);
#    translate([-chassis_encoder_center_dx, -chassis_encoder_dy-10, 0])
        cube([debug_line_th, 20, debug_line_th]);
#    translate([chassis_encoder_center_dx, -chassis_encoder_dy-10, 0])
        cube([debug_line_th, 20, debug_line_th]);
}

module motor_wheel() {
    rotate([0,90,0]) cylinder(h=motor_wheel_w, r=motor_wheel_r);
}

module encoder_wheel() {
    rotate([0,90,0]) cylinder(h=encoder_wheel_w, r=encoder_wheel_r);
}

module motor_right() {
    translate([chassis_motor_dx,0,motor_wheel_r]) motor_pololu_37d_19_1_encoder();
    translate([chassis_motor_dx+2,0,motor_wheel_r]) motor_wheel();
}

module motor_left() {
    mirror([1,0,0]) motor_right();
}

module encoder_right() {
    hinge_z = encoder_wheel_r + omron_encoder_e6b2_cwz6c_2000_r - hinge_r;
    translate([10,-chassis_encoder_dy,hinge_z]) rotate([0,0,90]) hinge_40mm();
    translate([chassis_encoder_dx, -chassis_encoder_dy, encoder_wheel_r]) encoder_omron_e6b2_cwz6c_2000();
    translate([chassis_encoder_dx+2,-chassis_encoder_dy,encoder_wheel_r]) encoder_wheel();
}

module encoder_left() {
    mirror([1,0,0]) encoder_right();
}

module chassis_base() {
    translate([-chassis_l/2, -chassis_w+motor_wheel_r, chassis_z])
    cube([chassis_l, chassis_w, chassis_thickness]);
}

module minituxy_chassis() {
    chassis_base();
    motor_right();
    motor_left();
    encoder_left();
    encoder_right();
    debug();
}

minituxy_chassis();