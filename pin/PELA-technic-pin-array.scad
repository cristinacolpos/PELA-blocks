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
include <../print-parameters.scad>
use <../PELA-block.scad>
use <PELA-technic-pin.scad>


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

pin_array(array_count=array_count, array_spacing=array_spacing, base_thichness=base_thickness, axle_radius=axle_radius, pin_center_radius=pin_center_radius, peg_length=peg_length, pin_tip_length=pin_tip_length, minimum_base=minimum_base,counterbore_holder_radius=counterbore_holder_radius, counterbore_holder_height=counterbore_holder_height, base_thickness=base_thickness, block_height=block_height);
