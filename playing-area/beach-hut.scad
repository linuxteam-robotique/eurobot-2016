
$fn = 13;    // speed up rendering
t1r = 1.5;  // radius of the tool T1

workpiece_number = 0;   // 10mm rendering green beach hut in assembly mode
//workpiece_number = 1;   // 10mm 1 * (left and right side walls, door and front bottom wall)
//workpiece_number = 2;   // 10mm 2 * (roof top left and right, front and back top walls)
//workpiece_number = 3;   // 22mm

step_down = 2; // note: if step_down=(mt-0.6)/2 then 3 passes: 2.1, 2.1 then 0.6
mt = 10;       // material thickness
mt22 = 22;     // material thickness

carving_settings(tool_change_height=35);
carving_tool(tool_number=1, name="T1" , diameter=t1r*2);
carving_tool_speed(tool="T1", material="wood", spindle_speed=7000, feedrate=400, step_down=step_down);


module roof(length, width, champfer, id) {
    l = length / 2;
    w = width / 2;
//    translate([l, w]) {
        for(i = [ 1 :  1 : 9]) {
            carving_path2d("T1", [ (10-t1r),  (w-champfer-i+t1r)], thickness = 10-i) {
                carving_line(    [-(10-t1r),  (w-champfer-i+t1r)]);
            }
        }
        carving_path2d("T1", [-(l+t1r), -(w+t1r)], id) {
            carving_line([ (l+t1r), -(w+t1r)]);
            carving_line([ (l+t1r),  (w+t1r)]);
            carving_line([ (10-t1r),  (w+t1r)]);
            carving_line([ (10-t1r),  (w-champfer+t1r)]);
            carving_line([-(10-t1r),  (w-champfer+t1r)]);
            carving_line([-(10-t1r),  (w+t1r)]);
            carving_line([-(l+t1r),  (w+t1r)]);
            carving_line([-(l+t1r), -(w+t1r)]);
        }
//    }
}

module roof_1_2() {
    roof(100, 75, 4, "roof_1_2");
}

module roof_2_3() {
    roof(100, 85, 14, "roof_2_3");
}


module wall_with_side_back(side_left, id)
{
    l = 100 / 2;
    w = 210 / 2;
    back_length = 23;
    back_pos_y  = (210 - 115) - w;
//    translate([l, w]) {
        for(i = [ 1 :  1 : 9]) {
            carving_path2d("T1", [-(l+t1r),  -(w-i+t1r)], thickness = 10-i) {
                carving_line([ +(l+t1r),  -(w-i+t1r)]);
            }
        }
        carving_path2d("T1", [-(l+t1r), -(w+t1r)], id) {
            carving_line([ (l+t1r), -(w+t1r)]);
            if (side_left == false) {
                carving_line([ (l+t1r),              (back_pos_y+t1r)]);
                carving_line([ (l+t1r-back_length),  (back_pos_y+t1r)]);
                carving_line([ (l+t1r-back_length),  (w+t1r)]);
            } else {
                carving_line([ (l+t1r),  (w+t1r)]);
            }
            if (side_left) {
                carving_line([-(l+t1r-back_length),  (w+t1r)]);
                carving_line([-(l+t1r-back_length),  (back_pos_y+t1r)]);
                carving_line([-(l+t1r),  (back_pos_y+t1r)]);
            } else {
                carving_line([-(l+t1r),  (w+t1r)]);
            }
            carving_line([-(l+t1r), -(w+t1r)]);
        }
//    }
}


module wall_2_5() {
    wall_with_side_back(false, "wall_2_5");
}
module wall_1_4() {
    wall_with_side_back(true, "wall_1_4");
}


module wall_with_roof(length, width, roof_height, id, pos)
{
    l = length / 2;
    w = (width - roof_height) / 2;
    t1r45 = t1r * cos(45);
//    translate([l,w]) {
        carving_path2d("T1", [-(l+t1r), -(w+t1r)], id, pos) {
            carving_line([ (l+t1r), -(w+t1r)]);
            if (roof_height != 0) {
                carving_line([ (l+t1r),   (w)]);
                carving_arc( [ (l+t1r45), (w+t1r45)], [l, w], ccw=true);
                carving_line([ t1r45,     (w+t1r45+roof_height)]);
                carving_arc( [-t1r45,     (w+t1r45+roof_height)], [0, w+roof_height], ccw=true);
                carving_line([-(l+t1r45), (w+t1r45)]);
                carving_arc( [-(l+t1r),   (w)], [-l, w], ccw=true);
            } else {
                carving_line([ (l+t1r),  (w+t1r)]);
            }
            carving_line([-(l+t1r),  (w+t1r)]);
            carving_line([-(l+t1r), -(w+t1r)]);
        }
//    }
}

module wall_3_11() {
    wall_with_roof(80, 70, 0, "wall_3_11", [0, 0]);

}

module wall_back_6() {
    wall_with_roof(80, 100, 40, "wall_back_6", [0, 0]);
}

module wall_front_7() {
    wall_with_roof(80, 135, 40, "wall_front_7", [0, -(135-40)/2]);
}

module door_8() {
    wall_with_roof(100, 200, 0, "door_8", [0, -100]);
}

module ground_9() {
    l = 80 / 2;
    w = 100 / 2;
    carving_path2d("T1", [-(l+21+(3-t1r)), -(w-11)]) {      // 6mm drill hole
        carving_arc([-(l+21+(3-t1r)), -(w-11)], [-(l+21), -(w-11)]);
    }
    carving_path2d("T1", [-(8-t1r), 0]) {      // 16mm drill hole
        carving_arc([-(8-t1r), 0], [0, 0]);
    }
    carving_path2d("T1", [-(l+t1r), -(w+t1r)], "ground_9") {
        carving_line([ (l+t1r), -(w+t1r)]);
        carving_line([ (l+t1r),  (w+t1r)]);
        carving_line([-(l+t1r),  (w+t1r)]);
        carving_line([-(l+t1r), -(w-22-t1r)]);
        carving_line([-(l+21), -(w-22-t1r)]);
        carving_arc( [-(l+21), -(w+t1r)], [-(l+21), -(w-11)], ccw = true);
        carving_line([-(l+t1r), -(w+t1r)]);
    }
}

module door_2_10() {
    carving_path2d("T1", [-11+(3-t1r), -11]) {      // 6mm drill hole
        carving_arc(     [-11+(3-t1r), -11], [-11, -11]);
    }
    carving_path2d("T1", [-50+(15-t1r), -72]) {      // 30mm drill hole
        carving_arc(     [-50+(15-t1r), -72], [-50, -72]);
    }
    r = 95 + t1r;
    y1 = (22-t1r);
    x1 = sqrt(r*r - y1*y1);
    x2 = 11 + t1r;
    y2 = sqrt(r*r - x2*x2);
    carving_path2d("T1", [-11-(11+t1r), -11         ], "door_2_10", [-11,-22]) {
        carving_line(    [-11-(11+t1r), -11-(22-t1r)]);
        carving_line(    [-11-x1,       -11-y1      ]);
        carving_arc(     [-11+x2,       -11-y2      ], [-11, -11], ccw=true);
        carving_line(    [    t1r,      -11         ], ccw=true);
        carving_arc(     [-11-(11+t1r), -11         ], [-11, -11], ccw=true);
    }
}

module beach_hut_green()
{
%   translate([40+10, 0, 150+100])                      // move to roof top
        translate([-75 * cos(45), 0, -75 * cos(45)])    // origin is bottom right
            translate([-mt*cos(45), 0, mt*cos(45)])     // origin is bottom left
                rotate([0,135,0]) rotate([0,0,90]) carving_part("roof_1_2"); // left
%   translate([40+10-mt*cos(45), 0, 150+100+mt*cos(45)])      // move to roof top
        translate([+85 * cos(45), 0, -85 * cos(45)])    // origin is left bottom
            translate([+mt*cos(45), 100, mt*cos(45)])   // 
                rotate([0,-135,0]) rotate([0,0,-90]) carving_part("roof_2_3"); // right
%    translate([10,77,0]) rotate([90,0,0]) carving_part("wall_3_11");        // center
    translate([10,10,150]) rotate([90,0,0]) carving_part("wall_back_6");
%    translate([10,100,115]) rotate([90,0,0]) carving_part("wall_front_7");
    translate([0,100,200]) rotate([-90,0,45]) carving_part("door_8");
    translate([10,0,210]) rotate([-90,0,90]) carving_part("wall_2_5");      // left
    translate([90,100,210]) rotate([-90,0,-90]) carving_part("wall_1_4");   // right
}

if (workpiece_number == 0) {

    carving_workpiece([850, 250], "wood", thickness=mt) {
        translate([60, 45]) roof_1_2();
        translate([170, 50]) roof_2_3();
        translate([270, 43]) wall_3_11();
        translate([360, 38]) wall_back_6();
        translate([450, 55]) wall_front_7();
        translate([550, 108]) door_8();
        translate([660, 113]) wall_2_5();
        translate([770, 113]) wall_1_4();    
    }
    carving_assembly() {
        beach_hut_green();
    }

} else if (workpiece_number == 1) {

    carving_workpiece([240, 400], "wood", thickness=mt) {
        translate([110, 55]) rotate([0,0,90]) wall_2_5();
        translate([56, 195])  rotate([0,0,0]) door_8();
        translate([160, 149]) wall_3_11();
        translate([150, 233]) rotate([0,0,-90]) wall_back_6();
        translate([110, 332]) rotate([0,0,90]) wall_1_4();
    }

} else if (workpiece_number == 2) {

    carving_workpiece([240, 350], "wood", thickness=mt) {
        translate([56, 45]) roof_1_2();
        translate([170, 50]) roof_2_3();
        translate([56, 145]) wall_front_7();

        translate([101, 335, 0]) rotate([0,0,180]) translate([-125, 0, 0]) {
            translate([56, 145]) wall_front_7();
            translate([170, 50]) roof_2_3();
            translate([56, 45]) roof_1_2();
        }
    }

} else if (workpiece_number == 3) {

    carving_workpiece([240, 240], "wood", thickness=mt22) {
        translate([78, 55]) ground_9();
        translate([232, 112]) door_2_10();
        translate([78, 170]) ground_9();
        translate([129, 100]) rotate([0,0,180]) door_2_10();
    }
    carving_assembly() {
        translate([0,0,20]) carving_part("ground_9");
        translate([0,0,50]) carving_part("door_2_10");
    }
}
