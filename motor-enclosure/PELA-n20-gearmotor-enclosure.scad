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


include <../style.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>



/* [N20 Gearmotor Enclosure] */

// Show the inside structure [mm]
cut_line = 0;

// Printing material
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the nozzle >= 0.5mm? If so, some features are larger to make printing easier (and slightly slower)
large_nozzle = true;

// Add interior fill for upper layers
solid_upper_layers = true;

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
corner_bolt_holes = false;

// Height of horizontal surface strengthening slats (appears between the bottom rings)
bottom_stiffener_height = 9.6;


/* [Motor Enclosure Size] */

// Length of the motor enclosure [blocks]
l = 4; 

// Width of the motor enclosure [blocks]
w = 2;

// Height of the bottom part of the motor enclosure (block count, the top part is always 1/3)
h_bottom = 1;

// Height of the bottom part of the motor enclosure (block count, the top part is always 1/3)
h_top = 1;


/* [Motor Options] */
// Diameter of the rounded part of the motor body (if no rounding, set length as appropriate and this to 1/2 the motor width)
motor_radius = 6.1 + skin;

// Shaft-axis ditance of the rounded part of the motor body (motor_width may reduce this)
motor_round_length = 15.5 + skin;

// Shaft-axis distance of the square part of the motor body (motor_width may reduce this)
motor_square_length = 9.5 + skin;

// Width of the motor slot body (may reduce rounding, add space to more easily insert the motor)
motor_width = 10.15 + 2*skin;

// Vertical position of the motor inside the enclosure
motor_offset = block_height(4/3)-motor_radius-block_width(0.5);

// Radius of the motor shaft cutout slot
motor_shaft_radius = 1.9;

// Distance the motor shaft extends from the motor body
motor_shaft_length = 9.4;

// Radius of motor end cutout slot for electrical connectors
electric_radius = 1.9;

// Additional depth to the electrical cutout
electric_vertical_displacement = -3.0;

// Distance the electrical connector cutout extends from the body
electric_length = 20.0;

// Heat ventilation holes in the sides
side_holes = 1; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Heat ventilation holes in the top surface
top_vents = true;

// Size of a hole in the top of each knob. 0 to disable or use for air circulation/aesthetics/drain resin from the cutout, but larger holes change flexture such that knobs may not hold as well.
knob_vent_radius = 0.0;




///////////////////////////////
// DISPLAY
///////////////////////////////

motor_enclosure_bottom();

translate([0, block_width(w + 0.5), 0]) {
    motor_enclosure_top();
}



///////////////////////////////////
// MODULES
///////////////////////////////////

module motor_enclosure_bottom(material=material) {
    difference() {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h_bottom, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, top_vents=0, knob_vent_radius=0, side_holes=side_holes, side_sheaths=0, end_holes=end_holes, knob_vent_radius=0, corner_bolt_holes=corner_bolt_holes);
        
        motor_cutouts(material=material);
    }
}


module motor_enclosure_top(material=material) {
    difference() {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h_top, side_holes=side_holes, end_holes=end_holes, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, top_vents=top_vents, knob_vent_radius=knob_vent_radius, corner_bolt_holes=corner_bolt_holes);

        translate([0, 0, block_height(-h_top)]) {
            motor_cutouts(material=material, large_nozzle=large_nozzle, ss=false);
        }
    }
}


// Space for the motor and connectors and shafts to be removed from the block
module motor_cutouts(material=material, large_nozzle=large_nozzle, ms=true, ss=true, es=true) {

    translate([(block_width(l)-motor_round_length-motor_square_length)/2, (block_width(w)-motor_width)/2, motor_offset]) {
        if (ms) {
            motor_slot(material=material);
        }
        if (es) {
            electric_slot(material=material);
        }
        if (ss) {
            shaft_slot(material=material);
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
    
    motor_shaft(material=material);
}


// Drive shaft sticking from one end of the motor
module motor_shaft(material=material) {
    translate([0, motor_radius, motor_radius]) {
        rotate([0, 90, 0]) {
            cylinder(r=motor_shaft_radius, h=motor_round_length+motor_square_length+motor_shaft_length);
        }
    }
}


// Electrical connections on the end opposite the shaft
module electric_cutout(material=material) {
    translate([0, motor_radius, motor_radius+electric_vertical_displacement]) {
        rotate([0, -90, 0]) {
            cylinder(r=electric_radius, h=electric_length);    
        }
    }
}


// For inserting the motor from the top
module motor_slot(material=material) {
    translate([0, -(2*motor_radius-motor_width)/2, 0]) {
        motor();
    }

    translate([0, 0, motor_radius]) {
        cube([motor_square_length+motor_round_length, motor_width, motor_radius]);    
    }
}


// For the shaft when the motor slides down into the bottom half of the enclosure
module shaft_slot(material=material, large_nozzle=large_nozzle, block_height=block_height) {
    hull() {
        translate([0, -(2*motor_radius-motor_width)/2, 0]) {
            motor_shaft(material=material);
        }

        translate([0, -(2*motor_radius-motor_width)/2, block_height(1, block_height=block_height)]) {
            motor_shaft(material=material);
        }
    }    
}


// For the electrical connections when the motor slides down into the bottom half of the enclosure
module electric_slot(material=material) {
    hull() {
        translate([0, -(2*motor_radius-motor_width)/2, 0]) {
            electric_cutout(material=material);
        }

        translate([0, -(2*motor_radius-motor_width)/2, block_height(3/4)]) {
            electric_cutout(material=material);
        }
    }    
}
