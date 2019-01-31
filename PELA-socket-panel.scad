/*
PELA Parametric Socket Panel Generator

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

include <style.scad>
include <print-parameters.scad>
use <PELA-block.scad>
use <PELA-technic-block.scad>

/* [PELA Panel Options] */

// Length of the block [blocks]
l = 8; 

// Width of the block [blocks]
w = 8;

// Size of corner holes for M3 mountings bolts
bolt_hole_radius = 1.6;

// Add interior fill for the base layer
solid_first_layer = false;


/* [Hidden] */

// Place holes in the corners for mountings screws
corner_bolt_holes = false;


///////////////////////////////
// DISPLAY
///////////////////////////////

socket_panel();




///////////////////////////////////
// MODULES
///////////////////////////////////

module socket_panel(l=l, w=w, solid_first_layer=solid_first_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, skin=skin, block_height=block_height) {
    
    socket_panel_one_sided(l=l, w=w, solid_first_layer=solid_first_layer, knob_height=knob_height, skin=skin, block_height=block_height);

    translate([0, block_width(w), panel_height(block_height=block_height)]) {
        rotate([180, 0, 0]) {
            socket_panel_one_sided(l=l, w=w, solid_first_layer=solid_first_layer, skin=skin, block_height=block_height);
        }
    }
}


module socket_panel_one_sided(l=l, w=w, solid_first_layer=solid_first_layer, knob_height=knob_height, skin=skin, block_height=block_height) {
    
    intersection() {
        PELA_technic_block(l=l, w=w, h=1, top_vents=false, solid_first_layer=solid_first_layer, corner_bolt_holes=false, side_holes=0, end_holes=0, skin=skin, knobs=false, block_height=block_height);

        translate([skin, skin, 0]) {
            cube([block_width(l)-2*skin, block_width(w)-2*skin, panel_height(block_height=block_height)]);
        }
    }
}
