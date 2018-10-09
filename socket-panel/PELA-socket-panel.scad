/*
PELA Parametric Socket Panel Generator

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
    use <PELA-block.scad>
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>

/* [PELA Panel Options] */

// Length of the block (PELA unit count)
l = 6; 

// Width of the block (PELA unit count)
w = 6;

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
bolt_holes = false;

// Size of corner holes for M3 mountings bolts
bolt_hole_radius = 1.5;

// Presence of top connector knobs
knobs = true;


/////////////////////////////////////
// PELA panel display
/////////////////////////////////////

PELA_socket_panel();


/////////////////////////////////////
// PELA PANEL modules
/////////////////////////////////////

// Accept knobs from both top and bottom surface
module PELA_socket_panel(l=l, w=w, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, skin=skin) {
    
    PELA_socket_panel_one_sided(l=l, w=w, top_vents=top_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, knob_height=knob_height, skin=skin);

    translate([0, block_width(w), panel_height()]) {
        rotate([180, 0, 0]) {
            PELA_socket_panel_one_sided(l=l, w=w, top_vents=top_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, skin=skin);
        }
    }
}


// Accept knobs from the bottom surface only
module PELA_socket_panel_one_sided(l=l, w=w, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, knob_height=knob_height, skin=skin) {
    
        intersection() {
            PELA_technic_block(l=l, w=w, h=1, top_vents=false, solid_bottom_layer=true, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, side_holes=0, end_holes=0, skin=skin, knobs=false);
    
            translate([skin, skin, 0])
                cube([block_width(l)-2*skin, block_width(w)-2*skin, panel_height()]);
        }
}

