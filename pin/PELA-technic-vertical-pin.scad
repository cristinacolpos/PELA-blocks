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

array_count = 3; // The number of half-pins in an array supported by as base

base_thickness = panel_height(); // The thickness of the base below an array of half-pins

array_spacing = block_height();

///////////////
// Display
///////////////

pin_array(array_count=array_count, array_spacing=array_spacing, base_thickness=base_thickness);
