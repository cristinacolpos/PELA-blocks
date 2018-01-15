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

/* [LEGO-compatible Options] */

// Length of the block (LEGO unit count)
l = 4; 

// Width of the block (LEGO unit count)
w = 2;

// Height of the block (LEGO unit count)
h = 1;


/* [Basic Block Features] */

// Presence of bottom connector sockets
sockets= 1; // [0:no sockets, 1:sockets]

// Presence of top connector knobs
knobs=1; // [0:disabled, 1:enabled]

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0; // [0:no holes, 1:holes]

// Size of corner holes for M3 mountings bolts
bolt_hole_radius=1.5;

// Interior fill for layers above the bottom
solid_upper_layers = 0; // [0:empty, 1:solid]

// Interior fill for layers above the bottom
solid_bottom_layer = 0; // [0:empty, 1:solid]


/* [Technic-compatible Block Features] */

// Add full width through holes spaced along the length for LEGO Techics connectors
side_holes = 0;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a sheath around Technic side holes (only used if there are side_holes, disable for extra ventilation, enable for connector lock notches)
side_sheaths = 1; // [0:disabled, 1:enabled]

// Add short end holes spaced along the width for LEGO Techics connectors
end_holes = 2;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full length connectors]

// Add a sheath around end holes  (only used if there are end_holes, disable for extra ventilation, enable for connector lock notches)
end_sheaths = 1; // [0:disabled, 1:enabled]

// Add holes in the top deck to improve airflow and reduce weight
top_vents = 1; // [0:disabled, 1:enabled]

// Size of a hole in the top of each knob to keep the cutout as part of the outside surface (slicer-friendly manifold shape). 0 to disable or use for air circulation/aesthetics/drain resin from the cutout, but larger holes change flexture such that knobs may not hold as well.
knob_vent_radius = 0;

// Add bars on the bottom surface between rings (recommended, holds the rings in position during printing, material flex and if upper structures are cut away)
ring_bars = 1;// [0:disabled, 1:bars between bottom rings]


/* [Aesthetic Options for Basic Blocks] */

// Width of a line etched in the side of multi-layer block sets (0 to disable)
ridge_width = 0.15;

// Depth of a line etched in the side of multi-layer block sets
ridge_depth = 0.3;



include <print-parameters.scad>

function dummy(x)=x; // This first function will block all uncommon parameters below from appearing in the online customizer


/* [Advanced Options for Basic Blocks] */

// Minimum angle to approximate a circle
$fa=10;

// Minimum segment length to approximate a circle
$fs=0.3;

// Roundness of bottom connector rings
ring_fn=8;

// Basic unit horizontal size of each block
block_width=8;

// Basic unit vertical size of each block
block_height=9.6;

// Horizontal clearance space around the outer surface of the set of blocks to allow two parts to be placed next to one another
skin = 0.1;

// Distance below knob top surface and the internal cutout
knob_top_thickness=0.8;

// Height of the hole beneath each knob
knob_flexture_height=4.5;

// Width of horizontal surface strengthening slats between the bottom rings
bottom_stiffener_width=2.7;

// Height of horizontal surface strengthening slats (appears between the bottom rings, default is print-parameters.scad:knob_height)
bottom_stiffener_height=knob_height;


/* [Advanced Options for Technic-compatible Blocks] */

// Technic connector inset radius
counterbore_inset_radius = 3.1;

// Technic connector inset depth
counterbore_inset_depth = 0.8;

// Contact length of axle to brick (not including inset length and end snap fit flexture in pin connectors)
peg_length = 6.5;

// Size of an optional cylinder wrapped around the bearing holes
bearing_sheath_thickness = 0.9;

// Slight visual offset to work around prevent goldfeather rendering bugs in OpenSCAD (visual, not affecting final print geometry)
defeather = 0.01;
