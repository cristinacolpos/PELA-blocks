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

include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>

/* [Technic Pin] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]
// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

// An axle which fits loosely in a technic bearing hole
_axle_radius = 2.2; // [0.1:0.1:4]

// Size of the hollow inside a pin
_pin_center_radius=axle_radius/3;

// Size of the connector lock-in bump at the ends of a Pin
_pin_tip_length = 0.7; // [0.1:0.1:4]

// Width of the long vertical flexture slots in the side of a pin
_pin_slot_thickness = 0.4; // [0.1:0.1:4]

_counterbore_holder_radius = _counterbore_inset_radius - skin;

_counterbore_holder_height = _counterbore_inset_depth * 2;



///////////////////////////////
// DISPLAY
///////////////////////////////

pin(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, axle_radius=_axle_radius, pin_center_radius=_pin_center_radius, peg_length=_peg_length, pin_tip_length=_pin_tip_length, counterbore_holder_height=_counterbore_holder_height);



//////////////////
// Functions
//////////////////

function technic_pin_length(pin_tip_length, peg_length, counterbore_holder_height) = (peg_length + pin_tip_length)*2 + counterbore_holder_height;



//////////////////
// MODULES
//////////////////

// A connector pin between two sockets
module pin(material=undef, large_nozzle=undef, cut_line=undef, axle_radius=undef, pin_center_radius=undef, peg_length=undef, pin_tip_length=undef, counterbore_holder_height=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(axle_radius > 0, "Technic pin axle radius must be positive");
    assert(pin_center_radius < axle_radius, "Technic pin center radius must be less than axle radius");
    assert(peg_length > 0);
    assert(pin_tip_length>=0);
    
    length = technic_pin_length(pin_tip_length=pin_tip_length, peg_length=peg_length, counterbore_holder_height=counterbore_holder_height);

    slot_length=3*length/5;

    difference() {
        translate([0, 0, -length/2]) {
            rotate([0, 0, 90]) {
                difference() {
                    union() {
                        cylinder(r=axle_radius, h=length);
                        
                        translate([0, 0, peg_length+pin_tip_length]) {
                            cylinder(r=counterbore_holder_radius, h=counterbore_holder_height);
                        }
                        
                        tip(material=material, large_nozzle=large_nozzle, axle_radius=axle_radius, pin_tip_length=pin_tip_length);
                        
                        translate([0, 0, length-pin_tip_length]) {
                            tip(material=material, large_nozzle=large_nozzle, axle_radius=axle_radius, pin_tip_length=pin_tip_length);
                        }
                    }
                    
                    union() {
                        translate([0, 0, -_defeather]) {
                            cylinder(r=pin_center_radius, h=length+2*_defeather);
                        }

                        translate([0, 0, pin_slot_thickness]) {
                            rounded_slot(material=material, large_nozzle=large_nozzle, thickness=pin_slot_thickness, slot_length=slot_length);
                        }
                        
                        translate([0, 0, length-pin_slot_thickness]) {
                            rounded_slot(material=material, large_nozzle=large_nozzle, thickness=pin_slot_thickness, slot_length=slot_length);
                        }
                        
                        translate([0, 0, length/2]) {
                            rotate([0, 0, 90]) {
                                rounded_slot(material=material, large_nozzle=large_nozzle, thickness=pin_slot_thickness, slot_length=slot_length);
                            }
                        }

                        translate([-block_width(), -counterbore_holder_radius, 0]) {
                            cut_space(material=material, large_nozzle=large_nozzle, l=4, cut_line=cut_line, h=4, block_height=block_height, knob_height=knob_height);
                        }
                    }
                }
            }
        }
    }
}


module axle_cross_negative_space(material=material, large_nozzle=large_nozzle, axle_rounding=axle_rounding, axle_radius=axle_radius, length=length) {
    
    for (rot=[0:90:270]) {
        rotate([0, 0, rot]) {
            hull() {
                translate([axle_rounding*2, axle_rounding*2, -_defeather]) {
                    cylinder(r=axle_rounding, h=length+2*_defeather);

                    translate([axle_radius, 0, 0])
                        cylinder(r=axle_rounding, h=length+2*_defeather);

                    translate([0, axle_radius, 0])
                        cylinder(r=axle_rounding, h=length+2*_defeather);
                }
            }
        }
    }
}


// An end ridge to allow a Pin to lock in to a Technic-compatible block
module tip(material=material, large_nozzle=large_nozzle, axle_radius=axle_radius, pin_tip_length=pin_tip_length) {
    rounded_disc(material=material, large_nozzle=large_nozzle, radius=axle_radius+pin_tip_length, thickness=pin_tip_length);
}


// A disc with rounded outer edge for pin tips
module rounded_disc(material=material, large_nozzle=large_nozzle, radius=10, thickness=1) {
    translate([0, 0, thickness/2])
        minkowski() {
            cylinder(r=radius-thickness, h=_defeather);
        
            sphere(r=thickness/2, $fn=16);
        }
}


// Side flexture slot with easement holes at each end
module rounded_slot(material=material, large_nozzle=large_nozzle, thickness=2, slot_length=10) {
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
module pin_array(material=material, large_nozzle=large_nozzle, array_count, array_spacing, base_thichness, axle_radius, pin_center_radius=pin_center_radius, peg_length=peg_length, pin_tip_length=pin_tip_length, minimum_base, counterbore_holder_radius=counterbore_holder_radius, counterbore_holder_height=counterbore_holder_height, base_thickness, block_height=block_height) {

    length = technic_pin_length(pin_tip_length=pin_tip_length, peg_length=peg_length, counterbore_holder_height=counterbore_holder_height);

    difference() {
        intersection() {
            translate([block_width(1/2), block_width(1/2), base_thickness]) {
                difference() {
                    for (i = [0 : array_count-1]) {
                        translate([i*array_spacing, 0, 0]) {
                            pin(material=material, large_nozzle=large_nozzle, axle_radius=axle_radius, pin_center_radius=pin_center_radius, peg_length=peg_length, pin_tip_length=pin_tip_length, counterbore_holder_height=counterbore_holder_height);
                        }
                    }
                    
                    translate([-block_width(), -block_width(), -block_height(1, block_height=block_height)-skin]) {
                        cube([block_width(array_count+1), block_width(2), block_height(1, block_height=block_height)]);
                    }
                }
                
                pin_base(material=material, large_nozzle=large_nozzle, length=length, array_count=array_count, array_spacing=array_spacing, base_thickness=base_thickness, minimum_base=minimum_base, peg_length=peg_length, counterbore_holder_radius=counterbore_holder_radius);
            }

            if (minimum_base) {
                translate([0, block_width(1/2), 0]) {
                    pin_array_envelope(material=material, large_nozzle=large_nozzle, counterbore_holder_radius=counterbore_holder_radius, array_count=array_count, array_spacing=array_spacing, peg_length=peg_length, counterbore_holder_height=counterbore_holder_height);
                }
            } else {
                cube([block_width(array_count), block_width(), length]);
            }
        }

        cut_space(material=material, large_nozzle=large_nozzle, l=4, cut_line=cut_line, h=2, block_height=block_height, knob_height=knob_height);
    }
}


// The default connector between base pins
module pin_base(material=material, large_nozzle=large_nozzle, length, array_count, array_spacing, base_thickness, minimum_base, peg_length=peg_length, counterbore_holder_radius=counterbore_holder_radius) {
    
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
module pin_envelope(material=material, large_nozzle=large_nozzle, length, counterbore_holder_radius=counterbore_holder_radius) {

    cylinder(r=counterbore_holder_radius, h=length);
}


// The rounded space which just encloses the pin array but not the rest of the array base
module pin_array_envelope(material=material, large_nozzle=large_nozzle, counterbore_holder_radius=counterbore_holder_radius, array_count, array_spacing, peg_length=peg_length, counterbore_holder_height=counterbore_holder_height) {

    length = technic_pin_length(pin_tip_length=pin_tip_length, peg_length=peg_length, counterbore_holder_height=counterbore_holder_height);

    translate([block_width(0.5), 0, 0]) {
        hull() {
            pin_envelope(material=material, large_nozzle=large_nozzle, length=length, counterbore_holder_radius=counterbore_holder_radius);

            translate([(array_count-1)*array_spacing, 0, 0]) {
                pin_envelope(material=material, large_nozzle=large_nozzle, length=length, counterbore_holder_radius=counterbore_holder_radius);
            }
        }
    }
}
