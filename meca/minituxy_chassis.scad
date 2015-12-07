include <hinge_40mm.scad>
include <encoder_omron_e6b2_cwz6c_2000.scad>
include <encoder_wheel.scad>
include <motor_pololu_37d_19_1_encoder.scad>
include <motor_pololu_37d_19_1_encoder_bracket.scad>
include <hub_pololu_6mm.scad>
include <ball_caster_dfrobot_miniq.scad>
// TODO better motor wheel?

motor_wheel_r = 72/2;
motor_wheel_w = 10;

axe_padding = 1.5;
chassis_encoder_dy = 47;
chassis_motor_wheel_center_dx = 83;
chassis_motor_dx = chassis_motor_wheel_center_dx-axe_padding-motor_wheel_w/2;

chassis_encoder_center_dx = sqrt(
    chassis_motor_wheel_center_dx*chassis_motor_wheel_center_dx -
    chassis_encoder_dy*chassis_encoder_dy );
chassis_encoder_dx = chassis_encoder_center_dx-axe_padding-encoder_wheel_w/2;
chassis_thickness = 3;
chassis_hinge_dx = hinge_w/2 + 5;
chassis_l = 144;    // before = 200mm, today = 87*2 = 174 => 25mm gain
chassis_w = 110;    // before = 110mmm
chassis_z = 5.2;      // position in z of the chassis from the ground
ball_caster_dy = -65;

module debug() {
debug_line_th = 0.4;
color("orange") {
    for( h = [0]) {
    //for( h = [ 0, encoder_wheel_r-debug_line_th , motor_wheel_r-debug_line_th]) {
        translate([0,0,h]) {
            difference() {
                cylinder(h = debug_line_th, r = chassis_motor_wheel_center_dx);
                translate([0,0,-0.1]) cylinder(h = debug_line_th+0.2, r = chassis_motor_wheel_center_dx-1);
            }
        }
    }
    
    translate([-chassis_motor_wheel_center_dx, 0, 0])
        cube([chassis_motor_wheel_center_dx*2, debug_line_th, debug_line_th]);
    translate([-chassis_motor_wheel_center_dx, -20, 0])
        cube([debug_line_th, 40, debug_line_th]);
    translate([chassis_motor_wheel_center_dx, -20, 0])
        cube([debug_line_th, 40, debug_line_th]);
    
    translate([-chassis_encoder_center_dx, -chassis_encoder_dy, 0])
        cube([chassis_encoder_center_dx*2, debug_line_th, debug_line_th]);
    translate([-chassis_encoder_center_dx, -chassis_encoder_dy-10, 0])
        cube([debug_line_th, 20, debug_line_th]);
    translate([chassis_encoder_center_dx, -chassis_encoder_dy-10, 0])
        cube([debug_line_th, 20, debug_line_th]);
}}

module motor_wheel() {
    rotate([0,90,0]) cylinder(h=motor_wheel_w, r=motor_wheel_r);
}

module motor_right() {
    translate([chassis_motor_dx,0,motor_wheel_r]) {
%        motor_pololu_37d_19_1_encoder();
        motor_pololu_37d_19_1_encoder_bracket();
    }
%    translate([chassis_motor_dx+axe_padding,0,motor_wheel_r]) motor_wheel();
}

module motor_left() {
    mirror([1,0,0]) motor_right();
}

module encoder_right() {
    hinge_z = encoder_wheel_r + omron_encoder_e6b2_cwz6c_2000_r - hinge_r;
    translate([chassis_hinge_dx,-chassis_encoder_dy,hinge_z]) rotate([0,0,90]) hinge_40mm();
    translate([chassis_encoder_dx, -chassis_encoder_dy, encoder_wheel_r]) {
%        encoder_omron_e6b2_cwz6c_2000();
#        translate([axe_padding,0,0]) encoder_wheel();
        translate([axe_padding+encoder_wheel_w-hub_pololu_6mm_small_axe_h,0,0]) hub_pololu_6mm();
    }
}

module encoder_left() {
    mirror([1,0,0]) encoder_right();
}

module ball_caster() {
    translate([0, ball_caster_dy, 0])
            ball_caster_dfrobot_miniq();
}


module casing() {
    casing_h=40;
    casing_w=chassis_l-ball_caster_dfrobot_miniq_r*3-10/*FIXME padding*/;
    translate([-chassis_l/2, -casing_w+motor_wheel_r, chassis_z+chassis_thickness+casing_h]) {
        cube([chassis_l, casing_w, 1.5]);
    }
    translate([-chassis_l/2, -casing_w+motor_wheel_r+1.5,chassis_z+chassis_thickness])
        rotate([90,0,0])
            cube([chassis_l, casing_h, 1.5]);
    translate([-chassis_l/2, motor_wheel_r,chassis_z+chassis_thickness])
        rotate([90,0,0])
            cube([chassis_l, casing_h, 1.5]);
}

module chassis_base() {
    translate([-chassis_l/2, -chassis_w+motor_wheel_r, chassis_z]) {
        difference() {
            cube([chassis_l, chassis_w, chassis_thickness]);
            translate([-0.1,-0.1,-0.1])
                cube([chassis_l/2-chassis_hinge_dx-hinge_w/2+0.1,
                      chassis_w - (motor_wheel_r+pololu_3d_19_1_encoder_d/2+0.1),
                      chassis_thickness+0.2]);
            translate([chassis_l/2+chassis_hinge_dx+hinge_w/2,-0.1,-0.1])
                cube([chassis_l/2-chassis_hinge_dx-hinge_w/2+0.1,
                      chassis_w - (motor_wheel_r+pololu_3d_19_1_encoder_d/2+0.1),
                      chassis_thickness+0.2]);
        }
    }
}

module minituxy_chassis() {
#    chassis_base();
    motor_right();
    motor_left();
    encoder_left();
    encoder_right();
    ball_caster();
%    casing();
    
    debug();
}

minituxy_chassis();