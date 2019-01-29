/*
PELA Parametric LEGO-compatible Technic Connector Pin

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

include <../parameters.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>

/* [Technic Pin Options] */

// An axle which fits loosely in a technic bearing hole
axle_radius = 2.2;

// Size of the hollow inside a pin
pin_center_radius=axle_radius/3;

// Size of the connector lock-in bump at the ends of a Pin
pin_tip_length = 0.7;

// Width of the long vertical flexture slots in the side of a pin
pin_slot_thickness = 0.4;

counterbore_holder_radius = counterbore_inset_radius - skin;

counterbore_holder_height = counterbore_inset_depth * 2;


/* [Technic Pin Array Options] */

array_count = 4; // The number of half-pins in an array supported by as base

base_thickness = panel_height(block_height=block_height); // The thickness of the base below an array of half-pins

array_spacing = block_width();

// Trim the base connecting a pin array to the minimum rounded shape
minimum_base = true;




///////////////////////////////
// DISPLAY
///////////////////////////////

pin();



//////////////////
// Functions
//////////////////

function technic_pin_length(pin_tip_length=pin_tip_length, peg_length=peg_length, counterbore_holder_height=counterbore_holder_height) = (peg_length+pin_tip_length)*2 + counterbore_holder_height;



//////////////////
// MODULES
//////////////////

module axle_cross_negative_space(axle_rounding=axle_rounding, axle_radius=axle_radius, length=length) {
    
    for (rot=[0:90:270]) {
        rotate([0, 0, rot]) {
            hull() {
                translate([axle_rounding*2, axle_rounding*2, -defeather]) {
                    cylinder(r=axle_rounding, h=length+2*defeather);

                    translate([axle_radius, 0, 0])
                        cylinder(r=axle_rounding, h=length+2*defeather);

                    translate([0, axle_radius, 0])
                        cylinder(r=axle_rounding, h=length+2*defeather);
                }
            }
        }
    }
}


// A connector pin between two sockets
module pin(axle_radius=axle_radius, pin_center_radius=pin_center_radius, peg_length=peg_length, pin_tip_length=pin_tip_length, counterbore_holder_height=counterbore_holder_height) {

    length = technic_pin_length(pin_tip_length=pin_tip_length, peg_length=peg_length, counterbore_holder_height=counterbore_holder_height);

    slot_length=3*length/5;

    translate([0, 0, -length/2]) {
        rotate([0, 0, 90]) {
            difference() {
                union() {
                    cylinder(r=axle_radius, h=length);
                    
                    translate([0, 0, peg_length+pin_tip_length]) {
                        cylinder(r=counterbore_holder_radius, h=counterbore_holder_height);
                    }
                    
                    tip(axle_radius=axle_radius, pin_tip_length=pin_tip_length);
                    
                    translate([0, 0, length-pin_tip_length]) {
                        tip(axle_radius=axle_radius, pin_tip_length=pin_tip_length);
                    }
                }
                
                union() {
                    translate([0, 0, -defeather]) {
                        cylinder(r=pin_center_radius, h=length+2*defeather);
                    }

                    translate([0, 0, pin_slot_thickness]) {
                        rounded_slot(thickness=pin_slot_thickness, slot_length=slot_length);
                    }
                    
                    translate([0, 0, length-pin_slot_thickness]) {
                        rounded_slot(thickness=pin_slot_thickness, slot_length=slot_length);
                    }
                    
                    translate([0, 0, length/2]) {
                        rotate([0, 0, 90])
                        rounded_slot(thickness=pin_slot_thickness, slot_length=slot_length);
                    }
                }
            }
        }
    }
}


// An end ridge to allow a Pin to lock in to a Technic-compatible block
module tip(axle_radius=axle_radius, pin_tip_length=pin_tip_length) {
    rounded_disc(radius=axle_radius+pin_tip_length, thickness=pin_tip_length);
}


// A disc with rounded outer edge for pin tips
module rounded_disc(radius=10, thickness=1) {
    translate([0, 0, thickness/2])
        minkowski() {
            cylinder(r=radius-thickness, h=defeather);
        
            sphere(r=thickness/2, $fn=16);
        }
}


// Side flexture slot with easement holes at each end
module rounded_slot(thickness=2, slot_length=10) {
    width = 10;
    
    hull() {
        translate([-width/2, 0, slot_length/2 - thickness]) {
            rotate([0, 90, 0]) {
                cylinder(r=thickness/2, h=width);
            }
        }
            
        translate([-width/2, 0, -slot_length/2 + thickness]) {
            rotate([0, 90, 0]) {
                cylinder(r=thickness/2, h=width);
            }
        }
    }
    
    circle_to_slot_ratio = 1.1;
    
    translate([-width/2, 0, slot_length/2 - thickness]) {
        rotate([0, 90, 0]) {
            cylinder(r=thickness/circle_to_slot_ratio, h=width);
        }
    }
            
    translate([-width/2, 0, -slot_length/2 + thickness]) {
        rotate([0, 90, 0]) {
            cylinder(r=thickness/circle_to_slot_ratio, h=width);
        }
    }
}


// A set of half-pins connected by at the base
module pin_array(array_count=array_count, array_spacing=array_spacing, base_thichness=base_thickness, axle_radius=axle_radius, pin_center_radius=pin_center_radius, peg_length=peg_length, pin_tip_length=pin_tip_length, minimum_base=minimum_base,counterbore_holder_radius=counterbore_holder_radius, counterbore_holder_height=counterbore_holder_height, block_height=block_height) {

    length = technic_pin_length(pin_tip_length=pin_tip_length, peg_length=peg_length, counterbore_holder_height=counterbore_holder_height);

    intersection() {
        translate([block_width(1/2), block_width(1/2), base_thickness]) {
            difference() {
                for (i = [0 : array_count-1]) {
                    translate([i*array_spacing, 0, 0]) {
                        pin(axle_radius=axle_radius, pin_center_radius=pin_center_radius, peg_length=peg_length, pin_tip_length=pin_tip_length, counterbore_holder_height=counterbore_holder_height);
                    }
                }
                
                translate([-block_width(), -block_width(), -block_height(1, block_height=block_height)-skin]) {
                    cube([block_width(array_count+1), block_width(2), block_height(1, block_height=block_height)]);
                }
            }
            
            pin_base(length, array_count=array_count, array_spacing=array_spacing, base_thickness=base_thickness, minimum_base=minimum_base, peg_length=peg_length, counterbore_holder_radius=counterbore_holder_radius);
        }

        if (minimum_base) {
            translate([0, block_width(1/2), -skin]) {
                 pin_array_envelope(length=length, counterbore_holder_radius=counterbore_holder_radius, array_count=array_count, array_spacing=array_spacing, peg_length=peg_length, counterbore_holder_height=counterbore_holder_height);
            }
        } else {
            cube([block_width(array_count), block_width(), length]);
        }
    }
}


// The default connector between base pins
module pin_base(length, array_count=array_count, array_spacing=array_spacing, base_thichness=base_thickness, minimum_base=minimum_base, peg_length=peg_length, counterbore_holder_radius=counterbore_holder_radius) {
    
    translate([-block_width(1/2), -block_width(1/2), -base_thickness-skin]) {
        difference() {
            cube([array_count*array_spacing, block_width(1), base_thickness]);
        
            translate([0, block_width(1/2)- pin_slot_thickness/2, 0]) {
                cube([array_count*array_spacing, pin_slot_thickness, base_thickness]);
            }
        }
    }
}


// The cylindrical space which fully encloses one pin
module pin_envelope(length, counterbore_holder_radius=counterbore_holder_radius) {

    cylinder(r=counterbore_holder_radius, h=length);
}


// The rounded space which just encloses the pin array but not the rest of the array base
module pin_array_envelope(counterbore_holder_radius=counterbore_holder_radius, array_count=array_count, array_spacing=array_spacing, peg_length=peg_length, counterbore_holder_height=counterbore_holder_height) {

    length = technic_pin_length(pin_tip_length=pin_tip_length, peg_length=peg_length, counterbore_holder_height=counterbore_holder_height);

    translate([block_width(0.5), 0, 0]) {
        hull() {
            pin_envelope(length=length, counterbore_holder_radius=counterbore_holder_radius);

            translate([(array_count-1)*array_spacing, 0, 0]) {
                pin_envelope(length=length, counterbore_holder_radius=counterbore_holder_radius);
            }
        }
    }
}
