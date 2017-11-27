
include <../lego-parameters.scad>
use <../lego.scad>
use <../lego-technic.scad>

/* [LEGO Connector Fit Options] */

// Interior fill for layers above the bottom
solid_upper_layers = 1; // [0:empty, 1:solid]

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0; // [0:no holes, 1:holes]

bottom_stiffener_height=9.6;


/* [Motor Enclosure Size] */
l=4;

w=2;

h=1.66666666667;


/* [Motor Options] */
motor_radius=6.1;
motor_round_length=15.5;
motor_square_length=9.5;
motor_shaft_radius=1.9;
motor_shaft_length=9.4;
motor_width=10+2*skin;
electric_radius=4.5;
electric_length=20;


////////////////////


lego_motor_bottom();
lego_motor_top();

module lego_motor_bottom() {
    difference() {
        lego_technic(l, w, h, knob_flexture_radius=0, side_holes=1, side_sheaths=0, end_holes=0, solid_upper_layers=1, inverted_print_rim=0);
        
#        union() {
        translate([(lego_width(l)-motor_round_length-motor_square_length)/2, (lego_width(w)-motor_width)/2, lego_height(h)-motor_radius-lego_width(0.5)]) {
            motor_slot();
            shaft_slot();
            electric_slot();
        }
        
        translate([0, 0, lego_height(h-1)])
            side_connector_hole_set();
        }
    }
}


module lego_motor_top() {
    rotate([180, 0, 0])
    translate([0, lego_width(0.5), -(lego_height()+knob_height)]) {
        difference() {
            lego_technic(l, w, 1 , side_holes=0, end_holes=0, top_vents=1, knob_vent_radius=1.5);
    
    #        union() {
                cube([lego_width(l), lego_width(w), lego_height(0.6666666667)]);
            
                translate([(lego_width(l)-motor_round_length-motor_square_length)/2, (lego_width(w)-motor_radius*2)/2, lego_height(0.6666666667)-motor_radius-lego_width(0.5)]) {
                    motor();
                }
            }
        }
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
    
    motor_shaft();
}


module motor_shaft() {
    translate([0, motor_radius, motor_radius])
        rotate([0, 90, 0])
            cylinder(r=motor_shaft_radius, h=motor_round_length+motor_square_length+motor_shaft_length);
}

module electric_cutout() {
    translate([0, motor_radius, motor_radius])
        rotate([0, -90, 0])
            cylinder(r=electric_radius, h=electric_length);    
}

module motor_slot() {
    translate([0, -(2*motor_radius-motor_width)/2, 0])
        motor();

    translate([0, 0, motor_radius])
        cube([motor_square_length+motor_round_length, motor_width, motor_radius]);    
}

module shaft_slot() {
    hull() {
        translate([0, -(2*motor_radius-motor_width)/2, 0])
            motor_shaft();

        translate([0, -(2*motor_radius-motor_width)/2, lego_height()])
            motor_shaft();
    }    
}

module electric_slot() {
    hull() {
        translate([0, -(2*motor_radius-motor_width)/2, 0])
            electric_cutout();

        translate([0, -(2*motor_radius-motor_width)/2, lego_height()])
            electric_cutout();
    }    
}
