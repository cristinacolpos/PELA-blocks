/*
PELA 1x1x1 Parametric Block with LEGO-compatible technic connectors

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

Import this into other design files:
    include <PELA-parameters.scad>
    use <technic.scad>
    
All modules have sensible defaults derived from <PELA_parameters.scad>. 
You can ignore values you are not tampering with and only need to pass a
parameter if you are overriding.

All modules are setup for stateless functional-style reuse in other OpenSCAD files.
To this end, you can always pass in and override all parameters to create
a new effect. Doing this is not natural to OpenSCAD, so apologies for all
the boilerplate arguments which are passed in to each module or any errors
that may be hidden by the sensible default values. This is an evolving art.
*/

include <PELA-parameters.scad>
include <PELA-print-parameters.scad>
use <PELA-block.scad>
use <PELA-technic-block.scad>

/* [PELA-compatible Options] */

// What type of top connector
top_type = 3; // [0:flat, 1:knob, 2:vented knob, 3:screw hole]

// What type of bottom connector
bottom_type = 1; // [0:flat, 1:socket, 2:screw hole]

technic_sides = false;

technic_ends = false;

panel = false;

sockets = true;

/////////////////////////////////////
// PELA display
/////////////////////////////////////

PELA_single_block();


/////////////////////////////////////
// MODULES
/////////////////////////////////////

// A PELA block with optional side and top vent holes
module PELA_single_block(panel=panel, top_type=top_type, bottom_type=bottom_type, technic_sides=technic_sides, technic_ends=technic_ends) {

    if (top_type == 0) {
        knobs = false;
        bolt_holes = false;
    } else if (top_type == 1) {
        knobs = true;
        bolt_holes = false;
        knob_vent_radius = 0;
    } else if (top_type == 2) {
        knobs = true;
        bolt_holes = false;
        knob_vent_radius = 1.2;
    } else if (top_type == 3) {
        knobs = false;
        bolt_holes = true;
    }

    if (bottom_type == 0) {
        solid_bottom_layer = true;
    }

    if (technic_sides) {
        side_holes = 3;
        side_sheaths = true;
    } else {
        side_holes = 0;
    }

    if (technic_ends) {
        end_holes = 3;
        end_sheaths = true;
    } else {
        end_holes = 0;
    }

    PELA_technic_block(l=1, w=1, h=1, sockets=sockets, knobs=knobs, knob_vent_radius=knob_vent_radius, panel=panel, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, solid_bottom_layer=solid_bottom_layer, skin=0, shell=0);
}
