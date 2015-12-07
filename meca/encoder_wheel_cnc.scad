
$fn = 24;
t1r = 1.5; // radius of the tool T1 in mm
mt = 1.5;    // material thickness in mm

// Definition of the tools
carving_settings(tool_change_height=35);
carving_tool(tool_number=1, name="T1" , diameter=t1r*2);
carving_tool(tool_number=2, name="T2" , diameter=2.5);
carving_tool_speed(tool="T1", material="alu", spindle_speed=7000, feedrate=150, step_down=mt);
carving_tool_speed(tool="T2", material="alu", spindle_speed=7000, feedrate=150, step_down=mt);

encoder_wheel_r = 25;
hub_pololu_6mm_holes_r = 9.5;

// Definition of part1
module part(name, size) {

    for( i = [0:60:320]) 
        carving_drill("T2", [cos(i)*hub_pololu_6mm_holes_r, sin(i)*hub_pololu_6mm_holes_r]);
    
    carving_path2d("T1",[size, 0], id=name) {
        carving_arc([size, 0], [0, 0]);
    }
}

module part1() {
    part("part1", encoder_wheel_r);
}
module part2() {
    part("part2", encoder_wheel_r-1.5);
}

module part3() {
    part("part3", encoder_wheel_r);
}

// Render milling path with View -> Carving -> Render Milling Path, F5
// Render carving result with View -> Carving -> Render Carving Result, F5
carving_workpiece([170, 60], "alu", thickness=mt) {
    translate([1*encoder_wheel_r+ 1,1*encoder_wheel_r+1]) part1();
    translate([3*encoder_wheel_r+ 7,1*encoder_wheel_r+1]) part2();
    translate([5*encoder_wheel_r+11,1*encoder_wheel_r+1]) part3();
}

// Render milling path with View -> Carving -> Render Milling Path, F5
// Render carving result with View -> Carving -> Render Carving Result, F5
carving_assembly() {
    translate([-encoder_wheel_r,    -encoder_wheel_r,    0  ]) carving_part("part1");
    translate([-encoder_wheel_r+1.5,-encoder_wheel_r+1.5,1.5]) carving_part("part2");
    translate([-encoder_wheel_r,    -encoder_wheel_r,    3  ]) carving_part("part3");
}
