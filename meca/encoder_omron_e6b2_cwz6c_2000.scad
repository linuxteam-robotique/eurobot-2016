
// http://www.ia.omron.com/data_pdf/cat/e6b2-c_ds_e_5_1_csm491.pdf?id=487

omron_encoder_e6b2_cwz6c_2000_l = 44;
omron_encoder_e6b2_cwz6c_2000_r = 40/2;
omron_encoder_e6b2_cwz6c_2000_axe_l = 15;
omron_encoder_e6b2_cwz6c_2000_axe_d = 6;

module encoder_omron_e6b2_cwz6c_2000() {
    translate([-5,0,0]) {
        difference() {
            rotate([0,-90,0]) cylinder(r=omron_encoder_e6b2_cwz6c_2000_r, h=39);
            for (angle = [ 0 : 120 : 240]) {
                rotate([angle,0]) translate([1, 15.5,0]) rotate([0,-90,0]) cylinder(d=3, h=4);
            }
        }
        rotate([0, 90,0]) cylinder(d=20, h=5);
        difference() {
          translate([5,0,0]) rotate([0, 90,0]) cylinder(d=6, h=15);
          translate([10,-3,3-0.5]) cube([15,6, 6]);
        }
    }
}

//encoder_omron_e6b2_cwz6c_2000();
