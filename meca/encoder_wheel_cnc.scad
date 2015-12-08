
$fn = 24;
t1r = 1.5; // radius of the tool T1 in mm
mt = 1.5;    // material thickness in mm

// Definition of the tools
carving_settings(tool_change_height=35);
carving_tool(tool_number=1, name="T1" , diameter=t1r*2);
carving_tool(tool_number=2, name="T2" , diameter=2.5);
carving_tool_speed(tool="T1", material="alu", spindle_speed=7000, feedrate=150, step_down=mt);
carving_tool_speed(tool="T2", material="alu", spindle_speed=7000, feedrate=150, step_down=mt);

encoder_wheel_outside_r = 21;
encoder_holes_r = 16;
hub_pololu_6mm_holes_r = 9.5;
hub_pololu_6mm_small_axe_r = 6;
hub_pololu_6mm_r = 12.7;

module part1() {
    for( i = [30:60:330]) 
        carving_drill("T2", [cos(i)*encoder_holes_r, sin(i)*encoder_holes_r]);
    carving_path2d("T1",[hub_pololu_6mm_r-t1r, 0]) {
        carving_arc([hub_pololu_6mm_r-t1r, 0], [0, 0]);
    }
    carving_path2d("T1",[encoder_wheel_outside_r+t1r, 0], id="part1", pos=[10,10]) {
        carving_arc([encoder_wheel_outside_r+t1r, 0], [0, 0]);
    }
}
module part2() {
    for( i = [30:60:330]) 
        carving_drill("T2", [cos(i)*encoder_holes_r, sin(i)*encoder_holes_r]);
    carving_path2d("T1",[hub_pololu_6mm_r-t1r, 0]) {
        carving_arc([hub_pololu_6mm_r-t1r, 0], [0, 0]);
    }
    carving_path2d("T1",[encoder_wheel_outside_r-1.5+t1r, 0], id="part2", pos=[10,10]) {
        carving_arc([encoder_wheel_outside_r-1.5+t1r, 0], [0, 0]);
    }
}

module part3() {
    for( i = [30:60:330]) 
        carving_drill("T2", [cos(i)*encoder_holes_r, sin(i)*encoder_holes_r]);
    for( i = [0:60:320]) 
        carving_drill("T2", [cos(i)*hub_pololu_6mm_holes_r, sin(i)*hub_pololu_6mm_holes_r]);
    carving_path2d("T1",[hub_pololu_6mm_small_axe_r-t1r, 0]) {
        carving_arc([hub_pololu_6mm_small_axe_r-t1r, 0], [0, 0]);
    }
    carving_path2d("T1",[encoder_wheel_outside_r+t1r, 0], id="part3", pos=[10,10]) {
        carving_arc([encoder_wheel_outside_r+t1r, 0], [0, 0]);
    }
}

// Render milling path with View -> Carving -> Render Milling Path, F5
// Render carving result with View -> Carving -> Render Carving Result, F5
carving_workpiece([170, 60], "alu", thickness=mt) {
    translate([1*encoder_wheel_outside_r+ 4,1*encoder_wheel_outside_r+4]) part1();
    translate([3*encoder_wheel_outside_r+10,1*encoder_wheel_outside_r+4]) part2();
    translate([5*encoder_wheel_outside_r+16,1*encoder_wheel_outside_r+4]) part3();
}

// Render milling path with View -> Carving -> Render Milling Path, F5
// Render carving result with View -> Carving -> Render Carving Result, F5
carving_assembly() {
    translate([-encoder_wheel_outside_r,    -encoder_wheel_outside_r,    0  ]) carving_part("part1");
    translate([-encoder_wheel_outside_r+1.5,-encoder_wheel_outside_r+1.5,1.5]) carving_part("part2");
    translate([-encoder_wheel_outside_r,    -encoder_wheel_outside_r,    3  ]) carving_part("part3");
}
