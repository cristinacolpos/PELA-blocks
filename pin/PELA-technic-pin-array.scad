/*
PELA Parametric LEGO-compatible Technic Connector Pin Set

PELA Parametric Blocks - 3D Printed LEGO-compatible parametric blocks

Published at http://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    http://futurice.com
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <PELA-technic-pin.scad>

/* [Technic Pin Array Options] */

array_count = 4; // The number of half-pins in an array supported by as base

base_thickness = panel_height(); // The thickness of the base below an array of half-pins

array_spacing = block_width();

// Size of the connector lock-in bump at the ends of a Pin
pin_tip_length = 0.7;

// Trim the base connecting a pin array to the minimum rounded shape
minimum_base = true;

///////////////
// Display
///////////////

pin_array(array_count=array_count, base_thickness=base_thickness, minimum_base=minimum_base, pin_tip_length=pin_tip_length);
