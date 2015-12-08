
hub_pololu_6mm_r = 12.7;
hub_pololu_6mm_small_axe_h = 4.2;
hub_pololu_6mm_small_axe_r = 6;
hub_pololu_6mm_h = 9.2;
hub_pololu_6mm_holes_r = 9.5;
hub_pololu_6mm_big_axe_h = hub_pololu_6mm_h - hub_pololu_6mm_small_axe_h; // 9.2-4.2 = 5

module hub_pololu_6mm()
{
//    translate([hub_pololu_6mm_h,0,0]) rotate([0,-90,0])
    translate([0,0,0]) rotate([0,90,0])
    difference() {
        union() {
            cylinder(r=hub_pololu_6mm_r, h=hub_pololu_6mm_big_axe_h);
            translate([0,0,hub_pololu_6mm_big_axe_h])
                cylinder(r=hub_pololu_6mm_small_axe_r, h=hub_pololu_6mm_small_axe_h);
        }
        translate([0,0,-0.1]) cylinder(r=3, h=hub_pololu_6mm_h+0.2);
        for( i = [30:60:330])
           translate([cos(i)*hub_pololu_6mm_holes_r, sin(i)*hub_pololu_6mm_holes_r,-0.1])
                cylinder(d=3, h=5+0.2);
    }

}

//hub_pololu_6mm();
