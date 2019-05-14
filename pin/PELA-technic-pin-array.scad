/*
PELA Parametric LEGO-compatible Technic Connector Pin Set

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



/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Technic Pin] */

// An axle which fits loosely in a technic bearing hole
_axle_radius = 2.2; // [0.1:0.1:4]

// Size of the hollow inside a pin
_pin_center_radius= 0.7; // [0:0.1:4]

// Size of the connector lock-in bump at the ends of a Pin
_pin_tip_length = 0.7; // [0.1:0.1:4]

// Width of the long vertical flexture slots in the side of a pin
_pin_slot_thickness = 0.4; // [0.1:0.1:4]


/* [Technic Pin Array] */

// The number of half-pins in an array supported by as base
_array_count = 2; // [1:1:20]

 // The thickness of the base below an array of half-pins
 _base_thickness = 4; // [0:0.1:20]

// Distance between pins
_array_spacing = 8;

// Trim the base connecting a pin array to the minimum rounded shape
_minimum_base = true;



///////////////////////////////
// DISPLAY
///////////////////////////////

pin_array(material=_material, large_nozzle=_large_nozzle, array_count=_array_count, array_spacing=_array_spacing, base_thichness=_base_thickness, axle_radius=_axle_radius, pin_center_radius=_pin_center_radius, peg_length=_peg_length, pin_tip_length=_pin_tip_length, minimum_base=_minimum_base, base_thickness=_base_thickness, block_height=_block_height);
