/*
PELA Parametric Knob Panel

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Import this into other design files:
    use <PELA-block.scad>
*/

include <../print-parameters.scad>
include <../style.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>

/* [Knob Panel] */

// Printing material
material = pla; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Length of the block [blocks]
l = 8; 

// Width of the block [blocks]
w = 8;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

// Add interior fill for upper layers
// Add interior fill for the base layer
solid_first_layer = false;

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
corner_bolt_holes = true;

// Presence of top connector knobs (vs flat)
knobs = true;

// Presence of bottom socket connectors (vs flat)
sockets = true;

// Height of horizontal surface strengthening slats (appears between the bottom rings)
bottom_stiffener_height = 0.0;

// How many outside rows and columns on all edges to omit before adding knobs
skip_edge_knobs = 0;



///////////////////////////////
// DISPLAY
///////////////////////////////

PELA_knob_panel();




///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_knob_panel(l=l, w=w, top_vents=top_vents, solid_first_layer=solid_first_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, sockets=sockets, skip_edge_knobs=skip_edge_knobs, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height) {

    hr=panel_height_ratio(block_height=block_height);

    if (skip_edge_knobs > 0) {
        PELA_technic_block(l=l, w=w, h=hr, top_vents=top_vents, solid_first_layer=solid_first_layer, corner_bolt_holes=corner_bolt_holes, side_holes=0, end_holes=0, bottom_stiffener_height=bottom_stiffener_height, knobs=false, sockets=sockets, block_height=block_height);

        echo("knob l", l);
        echo("knob w", w);
        if (l>2 && w>2) {
            translate([block_width(skip_edge_knobs), block_width(skip_edge_knobs), 0]) {
                top_knob_set(l=l-2*skip_edge_knobs, w=w-2*skip_edge_knobs, h=hr, knob_radius=knob_radius, corner_bolt_holes=false, block_height=block_height);
            }
        }
    } else {
        PELA_technic_block(l=l, w=w, h=hr, top_vents=top_vents, solid_first_layer=solid_first_layer, corner_bolt_holes=corner_bolt_holes, side_holes=0, end_holes=0, bottom_stiffener_height=bottom_stiffener_height, knobs=knobs, sockets=sockets, block_height=block_height);
    }
}
