
ball_caster_dfrobot_miniq_h=14.6;
ball_caster_dfrobot_miniq_sphere_h=3.1;
ball_caster_dfrobot_miniq_r=7.9;

module ball_caster_dfrobot_miniq()
{
    translate([0,0,ball_caster_dfrobot_miniq_sphere_h]) {
        difference() {
            union() {
                cylinder(h=11.5, r=ball_caster_dfrobot_miniq_r);
                translate([+7.9,0,0]) cylinder(h=11.5, r=2.8);
                translate([-7.9,0,0]) cylinder(h=11.5, r=2.8);
            }
            translate([+7.9,0,11.5/2]) cylinder(h=11.5/2+0.1, r=1);
            translate([-7.9,0,11.5/2]) cylinder(h=11.5/2+0.1, r=1);
        }
        translate([0,0,6-ball_caster_dfrobot_miniq_sphere_h]) sphere(r=6);
    }
}

/*
ball_caster_dfrobot_miniq();
//*/