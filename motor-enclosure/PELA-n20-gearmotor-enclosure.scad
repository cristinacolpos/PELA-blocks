/*
PELA Parametric LEGO-compatible Technic N20 Gearmotor Enclosure

PELA Parametric Blocks - 3D Printed LEGO-compatible parametric blocks

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/
*/


include <../PELA-parameters.scad>
include <../print-parameters.scad>
use <../block.scad>
use <../technic-block.scad>

/* [Block Connector Fit Options] */

// Interior fill for layers above the bottom
solid_upper_layers = true;

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes = false;

bottom_stiffener_height = 9.6;


/* [Motor Enclosure Size] */
// Length of the motor enclosure (block count)
l = 4; 

// Width of the motor enclosure (block count)
w = 2;

// Height of the bottom part of the motor enclosure (block count, the top part is always 1/3)
h_bottom = 1;

// Height of the bottom part of the motor enclosure (block count, the top part is always 1/3)
h_top = 1;


/* [Motor Options] */
// Diameter of the rounded part of the motor body (if no rounding, set length as appropriate and this to 1/2 the motor width)
motor_radius = 6.1+skin;

// Shaft-axis ditance of the rounded part of the motor body (motor_width may reduce this)
motor_round_length = 15.5+skin;

// Shaft-axis distance of the square part of the motor body (motor_width may reduce this)
motor_square_length = 9.5+skin;

// Width of the motor slot body (may reduce rounding, add space to more easily insert the motor)
motor_width = 10.15+2*skin;

// Vertical position of the motor inside the enclosure
motor_offset = block_height(4/3)-motor_radius-block_width(0.5);

// Radius of the motor shaft cutout slot
motor_shaft_radius = 1.9;

// Distance the motor shaft extends from the motor body
motor_shaft_length = 9.4;

// Radius of motor end cutout slot for electrical connectors
electric_radius = 1.9;

// Additional depth to the electrical cutout
electric_vertical_displacement = -3;

// Distance the electrical connector cutout extends from the body
electric_length = 20;

// Heat ventilation holes in the sides
side_holes = true;

// Heat ventilation holes in the top surface
top_vents = true;

// Size of a hole in the top of each knob. 0 to disable or use for air circulation/aesthetics/drain resin from the cutout, but larger holes change flexture such that knobs may not hold as well.
knob_vent_radius = 0;


////////////////////
// Test print
////////////////////
motor_enclosure_bottom();

translate([0, block_width(w + 0.5), 0]) {
    motor_enclosure_top();
}


////////////////////
// Modules
////////////////////

// Bottom of the enclosure
module motor_enclosure_bottom() {
    difference() {
        PELA_technic_block(l=l, w=w, h=h_bottom, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, top_vents=0, knob_vent_radius=0, side_holes=side_holes, side_sheaths=0, end_holes=end_holes, knob_vent_radius=0, bolt_holes=bolt_holes);
        
        motor_cutouts();
    }
}


// Top of the enclosure
module motor_enclosure_top() {
    difference() {
        PELA_technic_block(l=l, w=w, h=h_top, side_holes=side_holes, end_holes=end_holes, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, top_vents=top_vents, knob_vent_radius=knob_vent_radius, bolt_holes=bolt_holes);

        translate([0, 0, block_height(-h_top)]) {
            motor_cutouts(ss=false);
        }
    }
}


// Space for the motor and connectors and shafts to be removed from the block
module motor_cutouts(ms=true, ss=true, es=true) {

    translate([(block_width(l)-motor_round_length-motor_square_length)/2, (block_width(w)-motor_width)/2, motor_offset]) {
        if (ms) {
            motor_slot();
        }
        if (es) {
            electric_slot();
        }
        if (ss) {
            shaft_slot();
        }
    }
}


// Shape of the motor body
module motor() {
    intersection() {
        union() {
            translate([0, motor_radius, motor_radius]) {
                rotate([0, 90, 0]) {
                    cylinder(r=motor_radius, h=motor_round_length);
                }
            }
    
            translate([motor_round_length,0,0]) {
                cube([motor_square_length, motor_radius*2, motor_radius*2]);
            }
        }
        
        translate([0, (2*motor_radius-motor_width)/2], 0) {
            cube([motor_round_length+motor_square_length, motor_width, motor_radius*2]);
        }
    }    
    
    motor_shaft();
}


// Drive shaft sticking from one end of the motor
module motor_shaft() {
    translate([0, motor_radius, motor_radius]) {
        rotate([0, 90, 0]) {
            cylinder(r=motor_shaft_radius, h=motor_round_length+motor_square_length+motor_shaft_length);
        }
    }
}


// Electrical connections on the end opposite the shaft
module electric_cutout() {
    translate([0, motor_radius, motor_radius+electric_vertical_displacement]) {
        rotate([0, -90, 0]) {
            cylinder(r=electric_radius, h=electric_length);    
        }
    }
}


// For inserting the motor from the top
module motor_slot() {
    translate([0, -(2*motor_radius-motor_width)/2, 0]) {
        motor();
    }

    translate([0, 0, motor_radius]) {
        cube([motor_square_length+motor_round_length, motor_width, motor_radius]);    
    }
}


// For the shaft when the motor slides down into the bottom half of the enclosure
module shaft_slot(block_height=block_height) {
    hull() {
        translate([0, -(2*motor_radius-motor_width)/2, 0]) {
            motor_shaft();
        }

        translate([0, -(2*motor_radius-motor_width)/2, block_height(1, block_height=block_height)]) {
            motor_shaft();
        }
    }    
}


// For the electrical connections when the motor slides down into the bottom half of the enclosure
module electric_slot() {
    hull() {
        translate([0, -(2*motor_radius-motor_width)/2, 0]) {
            electric_cutout();
        }

        translate([0, -(2*motor_radius-motor_width)/2, block_height(3/4)]) {
            electric_cutout();
        }
    }    
}
