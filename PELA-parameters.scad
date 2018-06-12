/*
PELA Parametric Block Parameters

Published at http://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    http://futurice.com

Import this into other design files to set baseline constants:
    include <PELA_parameters.scad>
*/

include <PELA-print-parameters.scad>


/* [PELA Block Dimensions] */

// Length of the block (PELA unit count)
l = 4; 

// Width of the block (PELA unit count)
w = 4;

// Height of the block (PELA unit count)
h = 1;


/* [Basic Block Features] */

// Presence of bottom connector sockets
sockets = true;

// Presence of top connector knobs
knobs = true;

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
bolt_holes = false;

// Size of corner holes for M3 mountings bolts
bolt_hole_radius=1.6;

// Interior fill for layers above the bottom
solid_upper_layers = false;

// Interior fill for layers above the bottom
solid_bottom_layer = false;


/* [Technic Features] */

// Add full width through holes spaced along the length for PELA Techics connectors
side_holes = 3;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a sheath around technic side holes (only used if there are side_holes, disable for extra ventilation, enable for connector lock notches)
side_sheaths = true;

// Add short end holes spaced along the width for PELA Techics connectors
end_holes = 2;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full length connectors]

// Add a sheath around end holes  (only used if there are end_holes, disable for extra ventilation, enable for connector lock notches)
end_sheaths = true;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

// Size of a hole in the top of each knob. 0 to disable or use for air circulation/aesthetics/drain resin from the cutout, but larger holes change flexture such that knobs may not hold as well.
knob_vent_radius = 0;


/* [Aesthetic Options for Basic Blocks] */

// Width of a line etched in the side of multi-layer block sets (0 to disable)
ridge_width = 0.15;

// Depth of a line etched in the side of multi-layer block sets
ridge_depth = 0.3;


/* [Advanced Options for Basic Blocks] */

// Minimum angle to approximate a circle
$fa = 15;

// Minimum segment length to approximate a circle
$fs = 0.5;

// Display where knobs of a block below would be
show_shadow_knobs = false;

// Basic unit horizontal size of each block
block_width = 8;

// Basic unit vertical size of each block
block_height = 9.6;

// Horizontal clearance space around the outer surface of the set of blocks to allow two parts to be placed next to one another
skin = 0.1;

// Height of the hole beneath each knob which facilitates click lock in low-flex materials by variable side pressure on any block above
knob_flexture_height = 4.5;

// Width of horizontal surface strengthening slats between the bottom rings
bottom_stiffener_width = 2.6;

// Height of horizontal surface strengthening slats (appears between the bottom rings, default is print-parameters.scad:knob_height)
bottom_stiffener_height = knob_height;

/////////////////////////////////////
// FUNCTIONS
/////////////////////////////////////

// Horizontal size
function block_width(i=1) = i*block_width;

// Vertical size
function block_height(h=1) = h*block_height;

// Test if this is a corner block
function is_corner(x, y, l=l, w=w) = (x==0 || x==l-1) && (y==0 || y==w-1);

// Thickness of a flat panel
function panel_height(i=1) = block_height(i)/3;

// Thickness of a default panel
panel_height = panel_height();


/* [Advanced Options for Technic Features] */

// Technic connector inset radius
counterbore_inset_radius = 3.1;

// Technic connector inset depth
counterbore_inset_depth = 0.8;

// Contact length of axle to block (not including inset length and end snap fit flexture in pin connectors)
peg_length = 6.5;

// Size of an optional cylinder wrapped around the bearing holes
bearing_sheath_thickness = 0.9;

/* [Hidden] */

// Slight visual offset to work around prevent goldfeather rendering bugs in OpenSCAD (visual, not affecting final print geometry)
defeather = 0.01;

// Roundness of bottom connector rings (Use 8 for octagonal sockets- many parts of the geomoetry must be adjusted if you change this)
ring_fn=8;
