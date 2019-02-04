/*
PELA Parametric Block Style

Alter the baseline style of all designs. Many designs will locally override some but not all of these parameters.

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Import this into other design files to set baseline constants:
    include <style.scad>
*/

include <print-parameters.scad>

/* [Printer] */

// Minimum printable width of the printer-slicer combination has an effect on wall thickness and bottom socket gemoetry. When true, some features are larger. If set to false, printing is marginally faster and due to the reduction in material used.
large_nozzle = true; // [true:nozzle >= 0.5mm, false:nozzle < 0.5mm]


/* [Block] */

// Presence of bottom connector sockets
sockets = true;

// Presence of top connector knobs
knobs = true;

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
corner_bolt_holes = false;

// Size of corner holes for M3 mountings bolts
bolt_hole_radius = 1.6;

// Add interior fill for the base layer
solid_first_layer = false;

// Add interior fill for upper layers
solid_upper_layers = false;


/* [Knob] */

// Knob top surface strength
knob_top_thickness = 0.8;

// Height of traditional connectors [mm] (taller gives a stronger hold especially for flexible materials, too tall can cause problems when connecting to thin panels)
knob_height = 2.9; // [1.8:traditional blocks, 2.9:PELA improved 3D print fit]

// Height of a small bottom knob insert easement, flaring the bottom edges to make assembly easier
socket_insert_bevel = 0.1;




/* [Technic] */

// Technic connector hole
//axle_hole_radius = 2.45 + axle_hole_tweak;

// Add full width through holes spaced along the length for PELA Techics connectors
side_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around technic side holes (only used if there are side_holes, disable for extra ventilation, enable for connector lock notches)
side_sheaths = true;

// Add short end holes spaced along the width for PELA Techics connectors
end_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full length connectors]

// Add a wrapper around end holes  (only used if there are end_holes, disable for extra ventilation, enable for connector lock notches)
end_sheaths = true;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

// Size of a hole in the top of each knob. 0 to disable or use for air circulation/aesthetics/drain resin from the cutout, but larger holes change flexture such that knobs may not hold as well.
knob_vent_radius = 0.0;


/* [Shell] */

// Thickness of the solid outside surface of the block
side_shell = large_nozzle ? 1.2 : 1.0;

// Thickness of the solid top surface of the block
top_shell = 1;


/* [Advanced Block] */

// Basic unit vertical size of each block
block_height = 8; // [8:technic, 9.6:traditional blocks]

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid
skin = 0.1;

// Height of the hole beneath each knob which facilitates click lock in low-flex materials by variable side pressure on any block above
knob_flexture_height = 4.5;

// Width of horizontal surface strengthening slats between the bottom rings
bottom_stiffener_width = 2.6;

// Height of horizontal surface strengthening slats (appears between the bottom rings, default is print-parameters.scad:knob_height)
bottom_stiffener_height = knob_height;


/* [Advanced Technic] */

// Technic connector hole inset radius
counterbore_inset_radius = 3.1;

// Technic connector hole inset depth
counterbore_inset_depth = 0.8;

// Contact length of axle to block (not including inset length and end snap fit flexture in pin connectors)
peg_length = 6.5;

// Size of the cylinder wrapped around the technic holes
bearing_sheath_thickness = 0.9;


/* [Block Aesthetics] */

// Width of a line etched in the side of multi-layer block sets (0 to disable)
ridge_width = 0.15;

// Depth of a line etched in the side of multi-layer block sets
ridge_depth = 0.3;


/* [Baked Print Supports] */

// Generate print-time support aid structures for models which offer this. Turn this off if you will use slicer-generated print supports, but be aware that these may make the bottom connectors difficult to post process.
print_supports = true;

// Space between support/support.scad and the part)
support_offset_from_part = 0.1;

// Thickness of each rotating layer in a twisting support [mm]
support_layer_height = 2;

// Thickness of a base panel for holding supports together [mm]
support_connection_height = 0.5;

// Length of sides of a support equilateral triangle [mm]
support_side_length = 4;

// Per layer support rotation for strength [degrees]
support_layer_rotation = 6;

// Reverse direction of support rotation periodically to constrain size [degrees] (0 to disable)
support_max_rotation = 0;


/* [Hidden] */

// Basic unit horizontal size of each block
block_width = 8; // [8:technic and traditional blocks]

// In some models, the user will load two STL files into the slicer for a dual-material printer, one for each material/color. If "false" then the user wants a simplified, single material model
two_color_print = false; // WIP

// Add a text label to models which support that. The two_color_print setting will also affect if these is raised or colored text
text_labels = true; // WIP

// Height of the connectors commercial blocks use
official_knob_height = 1.8; // [1.8:traditional blocks]

// How far up or down for artistic purposes to move the ridge which marks each layer
ridge_z_offset = 0;

// Slight visual offset to work around prevent goldfeather rendering bugs in OpenSCAD (visual, not affecting final print geometry)
defeather = 0.01;

// Roundness of bottom connector rings (Use 8 for octagonal sockets- many parts of the geomoetry must be adjusted if you change this)
ring_fn=8;

// Roundness of bottom connector rings (Use 8 for octagonal sockets- many parts of the geomoetry must be adjusted if you change this)
axle_hole_fn=32;

// Minimum angle to approximate a circle
$fa = 15;

// Minimum segment length to approximate a circle
$fs = 0.5;


/////////////////////////////////////
// FUNCTIONS
/////////////////////////////////////

// Horizontal size
function block_width(i=1, block_width=block_width) = i*block_width;

// Vertical size
function block_height(h=1, block_height=block_height) = h*block_height;

// Bottom connector flexture ring wall thickness (note that some plastics are more slippery or brittle than ABS and this may negatively affect results or part lifetime, the value below is tuned for Taz 6 with 0.5 nozzle, Lulzbot Cura default and NGEN)
function ring_thickness(large_nozzle) = large_nozzle ? 1.2 : 0.8;

// Bottom connector flexture ring size (note that some plastics are more slippery or brittle than ABS and this may negatively affect results or part lifetime, the value below is tuned for Taz 6 with 0.5 nozzle, Lulzbot Cura default and NGEN)

function ring_radius(large_nozzle, bottom_tweak=undef) = 2.75 + ring_thickness(large_nozzle=large_nozzle) + bottom_tweak;

// Size of the small flexture cavity inside each knob (set to 0 for flexible materials, if the knobs delaminate and detach, or to avoid holes if the knobs are removed)
function knob_flexture_radius(material) = is_flexible(material) ? 0.6 : 0.8;

// Height of the knob top slope to ease connections (helps compensate for top surface artifacts, 0 to disable)
function knob_bevel(material) = is_flexible(material) ? 0.3 : 0.2;


// Test if this is a corner block
function is_corner(x, y, l=l, w=w) = (x==0 || x==l-1) && (y==0 || y==w-1);

// Ratio of a flat panel thickness to a regular block thickness (1/2 for PELA 8mm tall blocks, 1/3 for LEGO 9.6mm block_height blocks)
function panel_height_ratio(block_height=block_height) = block_height < 9.6 ? 1/2 : 1/3;

// Thickness of a flat panel
function panel_height(block_height=block_height) = block_height(1, block_height=block_height)*panel_height_ratio(block_height=block_height);

// Bottom connector additional distance from outside lock and connector rings which small flexture-fit rims protrude inwards to grab the base of knobs for asymmetric side pressure to assist with snap fit
function side_lock_thickness(material) = is_flexible(material) ? 0.06 : 0.02;

// Horizontal width of each side of a support triangle
function support_line_width(large_nozzle) = large_nozzle ? 0.7 : 0.5;
