/*
PELA Parametric Socket Panel Generator

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
l = 8; 

// Width of the block (PELA unit count)
w = 8;

// Thickness of the panel
panel_height = panel_height(1);

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0; // [0:no holes, 1:holes]

// Size of corner holes for M3 mountings bolts
bolt_hole_radius=1.6;

// Presence of top connector knobs
knobs=1; // [0:disabled, 1:enabled]


/////////////////////////////////////
// PELA panel display
/////////////////////////////////////

PELA_socket_panel();


/////////////////////////////////////
// PELA PANEL modules
/////////////////////////////////////

// Accept knobs from both top and bottom surface
module PELA_socket_panel(l=l, w=w, pane_height=panel_height, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, skin=skin) {
    
    PELA_socket_panel_one_sided(l=l, w=w, panel_height=panel_height, top_vents=top_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, skin=skin);
    
    translate([0, block_width(w), panel_height()])
        rotate([180, 0, 0])
            PELA_socket_panel_one_sided(l=l, w=w, panel_height=panel_height, top_vents=top_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, skin=skin);
}


// Accept knobs from the bottom surface only
module PELA_socket_panel_one_sided(l=l, w=w, panel_height=panel_height, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, skin=skin) {
    
        intersection() {
            PELA_technic_block(l=l, w=w, h=1, top_vents=0, solid_bottom_layer=1, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, side_holes=0, end_holes=0, skin=skin);
    
            translate([skin, skin, 0])
                cube([block_width(l)-2*skin, block_width(w)-2*skin, panel_height]);
        }
}

