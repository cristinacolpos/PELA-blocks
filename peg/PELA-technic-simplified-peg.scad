/*
PELA Parametric LEGO-compatible Technic Connector Peg

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
use <PELA-technic-pin.scad>

/* [Technic Simplified Pin] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]
// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

// An axle which fits loosely in a technic bearing hole
_axle_radius = 2.2; // [0.1:0.01:4]

// Size of the hollow inside a pin
_pin_center_radius=0.0; // [0.1:0.1:4]

// Size of the connector lock-in bump at the ends of a Pin
_pin_tip_length = 0.7; // [0.1:0.1:4]

// Width of the long vertical flexture slots in the side of a pin
_pin_slot_thickness = 0.0; // [0.1:0.1:4]

// Size of the flat bottom cut to make the pin more easily printable
_bottom_flatness = 0.4; // [0.0:0.1:5]

// Size of the end angle cuts to ease tip flex
_end_cut_length = 6; // [0.0:0.1:10]





///////////////////////////////
// DISPLAY
///////////////////////////////

simplified_pin(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, axle_radius=_axle_radius, pin_center_radius=_pin_center_radius, peg_length=_peg_length, pin_tip_length=_pin_tip_length, pin_slot_thickness=_pin_slot_thickness, bottom_flatness=_bottom_flatness, end_cut_length=_end_cut_length);



//////////////////
// Functions
//////////////////

module simplified_pin(material, large_nozzle, cut_line, axle_radius, pin_center_radius, peg_length, pin_tip_length, pin_slot_thickness, bottom_flatness, end_cut_length) {

    intersection() {
        translate([0, 0, axle_radius - bottom_flatness]) {
            rotate([0, 90, 0]) {
                pin(material=material, large_nozzle=large_nozzle, cut_line=cut_line, axle_radius=axle_radius, pin_center_radius=pin_center_radius, peg_length=peg_length, pin_tip_length=pin_tip_length, pin_slot_thickness=pin_slot_thickness);
            }
        }
        
        simplified_peg_cut(peg_length=peg_length, end_cut_length=end_cut_length, axle_radius=axle_radius);
    }
}


module simplified_peg_cut(peg_length, end_cut_length, axle_radius) {
    difference() {
        union() {
            translate([-100, -axle_radius, 0]) {
                cube([200, 2*axle_radius, 100]);
            }

            translate([-peg_length/2, -100, 0]) {
                cube([peg_length, 200, 100]);
            }
        }

        union() {
            translate([-end_cut_length, -10, 0]) {
                rotate([0, -135, 0]) {
                    cube([20, 20, 20]);
                }
            }
                
            translate([end_cut_length, -10, 0]) {
                rotate([0, 45, 0]) {
                    cube([20, 20, 20]);
                }
            }
        }
    }
}