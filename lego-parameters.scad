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

// Length of the block (LEGO unit count)
l = 4; 

// Width of the block (LEGO unit count)
w = 4;

// Height of the block (LEGO unit count)
h = 1;

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0; // [0:no holes, 1:holes]

// Size of corner holes for M3 mountings bolts
bolt_hole_radius=1.5;

// Interior fill for layers above the bottom
solid_upper_layers = 0; // [0:empty, 1:solid]

/* [3D Printing Adjustments] */

// Top connector size tweak => + = more tight fit, 0 for PLA with 0.6mm nozzle
top_tweak = 0;

// Bottom connector size tweak => + = more tight fit, 0 for PLA with 0.6mm nozzle
bottom_tweak = 0;

// Technic connector hole size tweak => + = more loose fit, 0 for PLA with 0.6mm nozzle
axle_hole_tweak = 0;

// Height of the easy connect slope near connector top (0 to disable is standard a slightly faster to generate the model, a bigger value such as 0.4 may help if you adjust a tight fit but most printers' slicers will simplify away most usable bevels)
knob_bevel=0;

// Number of flexure cuts across the inside of each knob
knob_slice_count=0;

// Width of flexure cuts across the top of the knob
knob_slice_width=0.2;

// Length of the slice the knob from inside towards the edge
knob_slice_length_ratio=0.8;

// Presence of bottom connector sockets
sockets= 1; // [0:no sockets, 1:sockets]

/* [LEGO Technics] */

// Add full width through holes spaced along the length for LEGO Techics connectors
side_holes = 3;  // [0:no holes, 1:simple air vents, 2:full width connector, 3:short connector]

// Add a sheath around side holes (disable for extra ventilation or rotating shafts, enable for connectors)
side_hole_sheaths = 1; // [0:disabled, 1:enabled]

// Add short end holes spaced along the width for LEGO Techics connectors
end_holes = 2;  // [0:no, 1:simple air vents, 2:short connector]

// Add a sheath around end holes (turn off for extra ventilation)
end_hole_sheaths = 1; // [0:disabled, 1:enabled]


/* [Top Ventilation] */

// Add holes in the top deck to improve airflow and reduce weight
top_vents = 1; // [0:disabled, 1:enabled]

// Size of a hole in the top of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
knob_flexture_airhole_radius=0;

/* [Advanced] */

// Minimum angle to approximate a circle
$fa=10;

// Minimum segment length to approximate a circle
$fs=0.3;

// Basic unit horizontal size of LEGO
block_width=8;

// Basic unit vertical size of LEGO
block_height=9.6;

// Thickness of the solid outside surface of LEGO
shell=1.2;

// Thickness of the solid top surface of LEGO
top_shell=1.4;

// Clearance space around the outer surface of bricks
skin = 0.1; 

// Width of a line etched in the side of multi-layer block sets (0 to disable)
ridge_width = 0.15;

// Depth of a line etched in the side of multi-layer block sets
ridge_depth = 0.3;

// Distance below knob top surface and the internal cutout
knob_top_thickness=0.8;

// Size of the connectors (calibrated for PLA, change 'top_tweak' to adjust)
knob_radius=2.45+0.06;

// Height of the connectors (1.8 is Lego standard, 2.2 gives a stronger hold while still maintaining most compatibility)
knob_height=1.8;

// Size of the small flexture cavity inside each knob
knob_flexture_radius=1.5;

// Height of the hole beneath each knob
knob_flexture_height=4.5;

// Width of horizontal surface strengthening slats between the bottom rings
bottom_stiffener_width=3.1;

// Height of horizontal surface strengthening slats (appears between the bottom rings)
bottom_stiffener_height=4;

// Base distance which small stiffeners protrude inwards from outside edge
outside_lock_thickness=1.6;

// Distance from outside lock and connector rings which small flexture-fit rims protrude inwards
side_lock_thickness=0.07;

// Depth which the inside of connectors are hollowed out
socket_flexture_height= 7.4;

// Bottom connector assistance ring size
ring_radius=3.25;

/* [Advanced LEGO Technic Options] */

// Technic connector hole
axle_hole_radius = 2.47;

// Technic connector inset radius
counterbore_inset_radius = 3.1;

// Technic connector inset depth
counterbore_inset_depth = 0.8;

// Contact length of axle to brick (not including inset length and end snap fit flexture in pin connectors)
peg_length = 6.15;

// Size of an cylinder wrapped around the entrance to bearing holes
bearing_sheath_thickness = 0.6;

/* [Advanced Reference] */

// An axle which fits loosely in a technic bearing hole
axle_radius = 2.4;
