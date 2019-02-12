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
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>



/* [Motor Enclosure] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Add interior fill for first layer
solid_first_layer = true;

// Add interior fill for upper layers
solid_upper_layers = true;


/* [Motor Enclosure Size] */

// Length of the motor enclosure [blocks]
l = 5; // [1:1:20]

// Width of the motor enclosure [blocks]
w = 4; // [1:1:20]

// Height of the bottom part of the motor enclosure (block count, the top part is always 1/3)
h = 4;


/* [Motor Options] */
// Diameter of the rounded part of the motor body (if no rounding, set length as appropriate and this to 1/2 the motor width)
motor_d = 24 + skin;

// Shaft-axis ditance of the rounded part of the motor body
motor_length = 30 + 2*skin;

// Radius of the motor shaft cutout slot
motor_shaft_radius = 1.9;

// Heat ventilation holes in the sides
side_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Heat ventilation holes in the ends
end_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors] 

// Heat ventilation holes in the top surface
top_vents = true;

// Size of a hole in the top of each knob. 0 to disable or use for air circulation/aesthetics/drain resin from the cutout, but larger holes change flexture such that knobs may not hold as well
knob_vent_radius = 1.8; // [0.0:0.1:3.9]

// Motor offset on the X axis
motor_x = 8; // [0.1:0.1:16]

// Motor shaft hole diameter
shaft_d = 1.5; // [0.1:0.1:4]

// Slot diameter for electrial cabling
electric_d = 5.5; // [0.1:0.1:16]

// Vertial offset from shaft of two M2.5 mounting holes
mount_hole_y = 8; // [0.1:0.1:16]

// M2.5 mount hole diameter
mount_hole_d = 2.7; // [0.1:0.1:8]


/* [Hidden] */

// Height of the top part of the motor enclosure (block count, the top part is always 1/3)
h_top = h/2;

h_bottom = h - h_top;

shaft_l = 10;



///////////////////////////////
// DISPLAY
///////////////////////////////

motor_enclosure_bottom(material=material, large_nozzle=large_nozzle);

translate([0, block_width(w + 0.5), 0]) {
    motor_enclosure_top(material=material, large_nozzle=large_nozzle);
}



///////////////////////////////////
// MODULES
///////////////////////////////////

module motor_enclosure_bottom(material=material, large_nozzle=large_nozzle) {
    
    difference() {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h_bottom, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, top_vents=0, knob_vent_radius=knob_vent_radius, side_holes=side_holes, end_holes=end_holes, corner_bolt_holes=corner_bolt_holes);
        
        translate([0, 0, block_height(h_bottom, block_height)]) {
            motor(material=material, large_nozzle=large_nozzle);
        }
    }
}


module motor_enclosure_top(material=material, large_nozzle=large_nozzle) {
    
    difference() {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h_top, side_holes=side_holes, end_holes=end_holes, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, top_vents=top_vents, knob_vent_radius=knob_vent_radius, corner_bolt_holes=corner_bolt_holes);

        motor(material=material, large_nozzle=large_nozzle);
    }
}


// Shape of the motor body
module motor(material=material, large_nozzle=large_nozzle) {
    translate([motor_x, block_width(w/2, block_width), 0]) {
        rotate([0, 90, 0]) {
            cylinder(d=motor_d, h=motor_length);
            
            translate([0, 0, motor_length]) {
                cylinder(d=shaft_d, h=shaft_l);
            }

            hull() {            
                translate([-motor_d/2, 0, -shaft_l]) {
                    cylinder(d=electric_d, h=shaft_l);
                }

                translate([motor_d/2, 0, -shaft_l]) {
                    cylinder(d=electric_d, h=shaft_l);
                }
            }
            
            translate([mount_hole_y, 0, motor_length]) {
                cylinder(d=mount_hole_d, h=shaft_l);
            }
            
            translate([-mount_hole_y, 0, motor_length]) {
                cylinder(d=mount_hole_d, h=shaft_l);
            }
        }
    }
}
