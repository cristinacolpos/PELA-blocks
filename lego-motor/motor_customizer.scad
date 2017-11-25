
include <../lego-parameters.scad>
use <../lego.scad>
use <../lego-technic.scad>

/* [LEGO Connector Fit Options] */

// Interior fill for layers above the bottom
solid_upper_layers = 1; // [0:empty, 1:solid]

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0; // [0:no holes, 1:holes]

side_holes=1;

end_holes=0;

end_hole_sheaths = 1;

bottom_stiffener_height=9.6;

top_vents(0);

/* [Motor Options] */
motor_radius=6.1;
motor_round_length=17;
motor_square_length=9.5;
motor_shaft_radius=2;
motor_shaft_length=9.4;
motor_width=10.2;

l=4;
w=2;
h=1.66666666667;
top_snap=0.2;

////////////////////

solid_upper_layers=1;

lego_with_top_slot();

module lego_with_top_slot() {
    difference() {
        lego_technic(l, w, h);
        
        translate([(lego_width(l)-motor_round_length-motor_square_length)/2, (lego_width(w)-motor_width)/2, lego_height(h)-2*motor_radius])
        motor_slot();
    }
}


module motor() {
    intersection() {
        union() {
            translate([0, motor_radius, motor_radius])
                rotate([0, 90, 0])
                    cylinder(r=motor_radius, h=motor_round_length);
    
            translate([motor_round_length,0,0])
                cube([motor_square_length, motor_radius*2, motor_radius*2]);
        }
        
        translate([0, (2*motor_radius-motor_width)/2], 0)
            cube([motor_round_length+motor_square_length, motor_width, motor_radius*2]);
    }
    
    
    translate([0, motor_radius, motor_radius])
        rotate([0, 90, 0])
            cylinder(r=motor_shaft_radius, h=motor_round_length+motor_square_length+motor_shaft_length);
}

module motor_slot() {
    translate([0, -(2*motor_radius-motor_width)/2, 0])
        motor();

    translate([0, 0, motor_radius])
        cube([motor_square_length+motor_round_length, motor_width, motor_radius]);    

    translate([top_snap, top_snap, 2*motor_radius])
        cube([motor_square_length+motor_round_length-2*top_snap, motor_width-2*top_snap, motor_radius]);    
}
