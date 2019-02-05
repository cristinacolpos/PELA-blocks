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



/* [Socket Panel] */

// Show the inside structure [mm]
cut_line = 0;

// Printing material
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the nozzle >= 0.5mm? If so, some features are larger to make printing easier (and slightly slower)
large_nozzle = true;

// Length of the block [blocks]
l = 8; 

// Width of the block [blocks]
w = 8;

// Presence of sockets vs a plain panel
sockets = true;

// Add interior fill for the base layer
solid_first_layer = false;

// Basic unit vertical size of each block
block_height = 8; // [8:technic, 9.6:traditional blocks]


/* [Hidden] */

// Place holes in the corners for mountings screws
corner_bolt_holes = false;

// Size of corner holes for M3 mountings bolts
bolt_hole_radius = 1.6;


///////////////////////////////
// DISPLAY
///////////////////////////////

socket_panel(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, sockets=sockets, solid_first_layer=solid_first_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, skin=skin, block_height=block_height);




///////////////////////////////////
// MODULES
///////////////////////////////////

module socket_panel(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, sockets=sockets, solid_first_layer=solid_first_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, skin=skin, block_height=block_height) {
    
    difference() {
        union() {
            socket_panel_one_sided(material=material, large_nozzle=large_nozzle, l=l, w=w, sockets=sockets, solid_first_layer=solid_first_layer, knob_height=knob_height, skin=skin, block_height=block_height, half_height=true);

            translate([0, block_width(w), panel_height(block_height=block_height)]) {
                rotate([180, 0, 0]) {
                    socket_panel_one_sided(material=material, large_nozzle=large_nozzle, l=l, w=w, sockets=sockets, solid_first_layer=solid_first_layer, skin=skin, block_height=block_height, half_height=true);
                }
            }
        }

        cut_space(material=material, large_nozzle=large_nozzle, w=w, l=l, cut_line=cut_line, h=1, block_height=block_height);
    }
}


module socket_panel_one_sided(material=material, large_nozzle=large_nozzle, l=l, w=w, sockets=sockets, solid_first_layer=solid_first_layer, knob_height=knob_height, skin=skin, block_height=block_height, half_height=false) {
    
    intersection() {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, l=l, w=w, h=1, top_vents=false, solid_first_layer=solid_first_layer, corner_bolt_holes=false, side_holes=0, end_holes=0, skin=skin, knobs=false, block_height=block_height, sockets=sockets);

            denom = half_height ? 2 : 1;
            
            cube([block_width(l), block_width(w), panel_height(block_height=block_height)/denom]);
    }
}

