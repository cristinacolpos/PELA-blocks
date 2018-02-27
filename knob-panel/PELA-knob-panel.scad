/*
PELA Parametric Knob Panel

Published at http://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com

Import this into other design files:
    use <PELA-block.scad>
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>

/* [PELA Panel Options] */

// Length of the block (PELA unit count)
l = 4; 

// Width of the block (PELA unit count)
w = 4;

// Thickness of the panel
panel_height = panel_height(1);

// Add holes in the top deck to improve airflow and reduce weight
top_vents = 0; // [0:disabled, 1:enabled]

// Interior fill for layers above the bottom
solid_bottom_layer = 0; // [0:empty, 1:solid]

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
bolt_holes=1; // [0:no holes, 1:holes]

// Size of corner holes for M3 mountings bolts
bolt_hole_radius=1.5;

// Presence of top connector knobs
knobs=1; // [0:disabled, 1:enabled]

// Height of horizontal surface strengthening slats (appears between the bottom rings)
bottom_stiffener_height=0;



/////////////////////////////////////
// PELA panel display
/////////////////////////////////////

PELA_knob_panel();

/////////////////////////////////////
// PELA PANEL modules
/////////////////////////////////////

module PELA_knob_panel(l=l, w=w, panel_height=panel_height, top_vents=top_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, sockets=sockets, skin=skin) {

    intersection() {
        PELA_technic_block(l=l, w=w, h=1, top_vents=top_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, side_holes=0, end_holes=0, bottom_stiffener_height=bottom_stiffener_height, knobs=knobs, sockets=sockets, skin=skin);
    
#        translate([-defeather, -defeather, -panel_height]) {
                cube([block_width(l+1), block_width(w+1), block_height()]);
        }
    }
}

