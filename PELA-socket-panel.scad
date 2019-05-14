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
include <material.scad>
use <PELA-block.scad>
use <PELA-technic-block.scad>



/* [Socket Panel] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Length of the block [blocks]
l = 8; // [1:1:20]

// Width of the block [blocks]
w = 8; // [1:1:20]

// Presence of sockets vs a plain panel
sockets = true;

// Add interior fill for the base layer
solid_first_layer = false;

// Basic unit vertical size of each block
block_height = 8; // [8:technic, 9.6:traditional blocks]


///////////////////////////////
// DISPLAY
///////////////////////////////

socket_panel(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, sockets=sockets, solid_first_layer=solid_first_layer, skin=_skin, block_height=block_height);




///////////////////////////////////
// MODULES
///////////////////////////////////

module socket_panel(material=undef, large_nozzle=undef, cut_line=cut_line, l=undef, w=undef, sockets=undef, solid_first_layer=undef, skin=_skin, block_height=undef) {
    
    assert(material != undef);
    assert(large_nozzle != undef);
    assert(cut_line != undef);
    assert(l != undef);
    assert(w != undef);
    assert(sockets != undef);
    assert(solid_first_layer != undef);
    assert(block_height != undef);

    difference() {
        union() {
            socket_panel_one_sided(material=material, large_nozzle=large_nozzle, l=l, w=w, sockets=sockets, solid_first_layer=solid_first_layer, knob_height=_knob_height, skin=skin, block_height=block_height, half_height=true);

            translate([0, block_width(w), panel_height(block_height=block_height)]) {
                rotate([180, 0, 0]) {
                    socket_panel_one_sided(material=material, large_nozzle=large_nozzle, l=l, w=w, sockets=sockets, solid_first_layer=solid_first_layer, skin=skin, block_height=block_height, half_height=true);
                }
            }
        }

        cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=1, block_height=block_height, knob_height=0);
    }
}


module socket_panel_one_sided(material=undef, large_nozzle=undef, l=undef, w=undef, sockets=undef, solid_first_layer=undef, knob_height=undef, skin=undef, block_height=undef, half_height=false) {
    
    intersection() {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, h=1, top_vents=false, solid_first_layer=solid_first_layer, corner_bolt_holes=false, side_holes=0, end_holes=0, skin=skin, knobs=false, block_height=block_height, sockets=sockets, side_sheaths=false, end_sheaths=false, knob_height=0, knob_vent_radius=0);

            denom = half_height ? 2 : 1;
            
            cube([block_width(l), block_width(w), panel_height(block_height=block_height)/denom]);
    }
}

