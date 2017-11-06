/*
Parametric LEGO Block Parameters

Published at
    http://www.thingiverse.com/thing:2303714
Maintained at
    https://github.com/paulirotta/parametric_lego
See also the related files
    LEGO Sign Generator - https://www.thingiverse.com/thing:2546028
    LEGO Enclosure Generator - https://www.thingiverse.com/thing:2544197


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com

Import this into other design files to set baseline constants:
    include <lego_parameters.scad>
*/

/* [LEGO Basic Options] */

// What type of object to generate: 1=>block, 2=>block without top knobs, 3=>block without bottom connector, 4=>block without top knob or bottom connector
mode=1; // [1:1, 2:2, 3:3, 4:4]

// Length of the block (LEGO knob count)
l = 4; 

// Width of the block (LEGO knob count)
w = 3;

// Height of the block (LEGO brick layer count)
h = 1;

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0; // [0:0, 1:1]

/* [3D Printing Adjustments] */

// Top connector size tweak => + = more tight fit, 0.06 for PLA, 0 for ABS, 0.07 for NGEN
top_tweak = 0;

// Bottom connector size tweak => + = more tight fit, -0.03 for PLA, 0 for ABS, -0.01 NGEN
bottom_tweak = 0;

// Height of the easy connect slope near connector top (0 to disable is standard a slightly faster to generate the model, a bigger value such as 0.4 may help if you adjust a tight fit but most printers' slicers will simplify away most usable bevels)
knob_bevel=0;

// Number of flexure cuts across the inside of each knob
knob_slice_count=0;

// Width of flexure cuts across the top of the knob
knob_slice_width=0.15;

// Length of the slice the knob from inside towards the edge
knob_slice_length_ratio=0.7;

/* [LEGO Technics] */

// Add full width through holes spaced along the length for LEGO Techics connectors (0=>no holes, 1=>simple air vents, 2=>single ended Technic connector, 3=>dual ended Technic connector)
side_holes = 1;  // [0:0, 1:1, 2:2, 3:3]

// Add a sheath around side holes (turn off for extra ventilation or rotating shafts)
side_hole_sheaths = 0; // [0:0, 1:1]

// Add short end holes spaced along the width for LEGO Techics connectors (0=>no holes, 1=>simple air vents, 2=>technics connector)
end_holes = 2;  // [0:0, 1:1, 2:2]

// Add a sheath around end holes (turn off for extra ventilation or rotating shafts)
end_hole_sheaths = 1; // [0:0, 1:1]

// Technic connector hole size tweak => + = more loose fit
bearing_hole_tweak = 0;


/* [Heat Ventilation] */

// Add holes in the top deck to improve airflow and reduce weight (0=>no holes, 1=>holes)
top_vents = 1;

// Size of a hole in the top of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
knob_flexture_airhole_radius=0;

/* [Advanced] */

// Number of facets to form a circle (big numbers are more round which affects fit, but may take a long time to render)
fn=64;

// Clearance space on the outer surface of bricks
skin = 0.1; 

// Width of a line etched in the side of multi-layer block sets (0 to disable)
ridge_width = 0.15;

// Depth of a line etched in the side of multi-layer block sets
ridge_depth = 0.3;

// Distance below knob top surface and the internal cutout
knob_top_thickness=1;

// Size of the connectors
knob_radius=2.4;

// Height of the connectors (1.8 is Lego standard, longer valie like 2.4 gives a stronger hold while still maintaining compatibility)
knob_height=2.4;

// Size of the small flexture cavity inside each connector
knob_flexture_radius=1.5;

// Height of the hole beneath each knob
knob_flexture_height=4.55;

// Number of side to simulate a circle in the air hole and (smaller numbers render faster and are usually sufficient)
airhole_fn=16;

// Width of horizontal surface strengthening slats (usually between the bottom rings)
bottom_stiffener_width=3.8;

// Height of horizontal surface strengthening slats (appears between the bottom rings)
bottom_stiffener_height=4.5;

// Width of horizontal surface strengthening slats (usually between the bottom rings)
side_stiffener_width=0.8;

// Distance from inside walls which small stiffeners protrude inwards
side_stiffener_thickness=0.2;

// Basic unit horizonal size of LEGO
block_width=8;

// Basic unit vertial size of LEGO
block_height=9.6;

// Thickness of the solid outside surface of LEGO
block_shell=1.6; // thickness

// Depth which connectors may press into part bottom
socket_height= 8.6;

// Depth which the inside of connectors are hollowed out
socket_flexture_height= 7.4;

// Bottom connector assistance ring size
ring_radius=3.25;

/* [Advanced LEGO Technic Options] */

// Technic connector hole
bearing_hole_radius = 2.45;

// Technic connector inset radius
bearing_inset_radius = 3.1;

// Technic connector inset depth
bearing_inset_depth = 0.8;

// Technic connector additional depth when cut into a solid surface
bearing_inset_depth_clearance = 1;

// An axle which fits loosely in a technic bearing hole
technic_axle_radius = 2.4;

// How deep into a brick should a hole go before flaring out to grip
technic_bearing_length = 6.2;

// Size of an cylinder wrapped around the entrance to bearing holes
technic_sheath_thickness = 0.6;