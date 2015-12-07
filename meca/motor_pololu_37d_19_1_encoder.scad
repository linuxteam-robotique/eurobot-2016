/*
  19:1 Metal Gearmotor 37Dx68L mm with 64 CPR Encoder
  https://www.pololu.com/product/2822 
*/

pololu_3d_19_1_encoder_l = 74.6;
pololu_3d_19_1_encoder_d = 37;
pololu_3d_19_1_encoder_axe_l = 15.5;
pololu_3d_19_1_encoder_axe_d = 6;
pololu_3d_19_1_encoder_axe_dx = 0;
pololu_3d_19_1_encoder_axe_dy = 7;

module motor_pololu_37d_19_1_encoder() {
    translate([-6.5, 0, -7]) {
        difference() {
            rotate([0,-90,0]) cylinder(d=37, h=68.1);
            for (angle = [ 0 : 60 : 300]) {
                rotate([angle,0]) translate([1, 15.5,0]) rotate([0,-90,0]) cylinder(d=3, h=4);
            }
        }
        translate([0,0,7]) rotate([0, 90,0]) cylinder(d=12, h=6.5);
        difference() {
          translate([6.5,0,7]) rotate([0, 90,0]) cylinder(d=6, h=15.5);
          translate([9,-3,-4-0.3]) cube([15,6, 6]);
        }
    }
}


//motor_pololu_37d_19_1_encoder();