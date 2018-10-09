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



/* [Shell Adjustments] */

// Thickness of the solid outside surface of the block
shell = large_nozzle ? 1.2 : 1.0;

// Thickness of the solid top surface of the block
top_shell = 1.5;


/* [Top Connector Adjustments] */

// Size of the top connectors (slippery or brittle plastics negatively affect results and lifetime- the value below is roughly in the middle of various materials tested)
knob_radius = 2.45 + 0.12 + top_tweak;

// Distance below knob top surface and the internal flexture
knob_top_thickness = 0.8;

// Size of the small flexture cavity inside each knob (set to 0 for flexible materials, if the knobs delaminate and detach, or to avoid holes if the knobs are removed)
knob_flexture_radius = flexible_material ? 0.6 : 0.8;

// Height of the knob top slope to ease connections (helps compensate for top surface artifacts, 0 to disable)
knob_bevel = flexible_material ? 0.3 : 0.1;

// Height of the connectors (LEGO uses 1.8- taller gives a stronger hold, flexible materials should be even taller if possible)
knob_height = 9.6/3; //flexible_material ? 9.6/3 : 2.0;

// Height of the connectors LEGO uses- this affects flexture heights)
official_knob_height = 1.8;

// Height of a small bottom knob insert easement, flaring the bottom edges to make assembly easier
socket_insert_bevel = 0.1;


/* [Bottom Connector Adjustments] */

// Bottom connector flexture ring wall thickness (note that some plastics are more slippery or brittle than ABS and this may negatively affect results or part lifetime, the value below is tuned for Taz 6 with 0.5 nozzle, Lulzbot Cura default and NGEN)
ring_thickness = large_nozzle ? 1.2 : 0.8;

// Bottom connector flexture ring size (note that some plastics are more slippery or brittle than ABS and this may negatively affect results or part lifetime, the value below is tuned for Taz 6 with 0.5 nozzle, Lulzbot Cura default and NGEN)
ring_radius = 2.75 + ring_thickness + bottom_tweak;

// Bottom connector additional distance from outside lock and connector rings which small flexture-fit rims protrude inwards to grab the base of knobs for asymmetric side pressure to assist with snap fit
side_lock_thickness = flexible_material ? 0.06 : 0.02;


/* [3D Printing Side Connector Adjustments] */

// Technic connector hole
axle_hole_radius = 2.45 + axle_hole_tweak;


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

// How far up or down for artistic purposes to move the thin outside shell ridge which shows the height of each layer
ridge_z_offset = 0;


/* [Advanced Options for Basic Blocks] */

// Minimum angle to approximate a circle
$fa = 15;

// Minimum segment length to approximate a circle
$fs = 0.5;

// Display where knobs of a block below would be
show_shadow_knobs = false;

// Basic unit horizontal size of each block
block_width = 8;

// Basic unit vertical size of each block (8 is technics standard, 9.6 is LEGO standard)
block_height = 8;

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
function block_width(i=1) = i*8; //TODO OPENSCAD Error, parameters in functions?

// Vertical size
function block_height(h=1) = h*block_height;

// Test if this is a corner block
function is_corner(x, y, l=l, w=w) = (x==0 || x==l-1) && (y==0 || y==w-1);

// Ratio of a flat panel thickness to a regular block thickness
function panel_height_ratio() = 1/2;

// Thickness of a flat panel
function panel_height(i=1) = block_height(i)*panel_height_ratio();


/* [Advanced Options for Technic Features] */

// Technic connector inset radius
counterbore_inset_radius = 3.1;

// Technic connector inset depth
counterbore_inset_depth = 0.8;

// Contact length of axle to block (not including inset length and end snap fit flexture in pin connectors)
peg_length = 6.5;

// Size of an optional cylinder wrapped around the bearing holes
bearing_sheath_thickness = 0.9;


/* [Print Supports] */

// Difference between the top and/or bottom of a support column to make columns easier to separate in post-processing (add this to your model only where desired - it is not done for you in support/support.scad)
support_offset_from_part = 0.05;

// Thickness of each rotating layer in a twisting support
support_layer_height = 2;

// Thickness of a base panel for holding supports together
support_connection_height = 0.5;

// Horizontal width of each side of a support triangle
support_line_width = large_nozzle ? 0.7 : 0.5;

// Length of sides of a support equilateral triangle
support_side_length = 4;

// Degrees to rotate for strength at each successive layer
support_layer_rotation = 6; // Degrees

// Max rotation before reversing direction to keep shape basically triangular but still strong (0 to disable)
support_max_rotation = 0; // Degrees


/* [Hidden] */

// Slight visual offset to work around prevent goldfeather rendering bugs in OpenSCAD (visual, not affecting final print geometry)
defeather = 0.01;

// Roundness of bottom connector rings (Use 8 for octagonal sockets- many parts of the geomoetry must be adjusted if you change this)
ring_fn=8;

// Roundness of bottom connector rings (Use 8 for octagonal sockets- many parts of the geomoetry must be adjusted if you change this)
axle_hole_fn=32;

