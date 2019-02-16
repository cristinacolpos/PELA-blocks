/*
Parametric PELA Strap Mount

A part for inserting strap straps to attachment PELA parts to other
objects. Other types of strap can also be used. The slots

The current design omits top knobs which would interfere with the
matching "PELA-vive-tracker-mount.scad".

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


/* [strap Mount] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Model length [blocks]
l = 4; // [1:1:20]

// Model width [blocks]
w = 4; // [1:1:20]

// Model height [blocks]
h = 1; // [1:1:20]

// Fraction of a normal panel height for the center section where a stap holds the block in place
panel_height_ratio = 1.0; // [0.1:0.1:2.0]

// Add short end holes spaced along the width for techic connectors
end_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around end holes (disable for extra ventilation but loose lock notches)
end_sheaths = false;

// Presence of top connector knobs
knobs = true;

sockets = false;

/* [Hidden] */

// Add full width through holes spaced along the length for techic connectors
side_holes = 0; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around end holes (disable for extra ventilation but loose lock notches)
side_sheaths = true;


///////////////////////////////
// DISPLAY
///////////////////////////////

strap_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, panel_height_ratio=panel_height_ratio, side_holes=side_holes, end_holes=end_holes, sockets=sockets, knobs=knobs, block_height=block_height);



///////////////////////////////////
// MODULES
///////////////////////////////////

module strap_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, panel_height_ratio=panel_height_ratio, side_holes=side_holes, end_holes=end_holes, sockets=sockets, knobs=knobs, block_height=block_height) {

    difference() {
        union() {
            difference() {
                PELA_technic_block(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, side_holes=side_holes, end_holes=end_holes, sockets=sockets, knobs=knobs, block_height=block_height);

                slot(l=l, w=w, block_height=block_height);
            }

            if (sockets) {
                height = max(knob_height + skin, panel_height_ratio*panel_height(block_height=block_height));

                ss = side_shell(large_nozzle);

                translate([block_width(1)- ss, 0, height]) {
                    cube([ss, block_width(w, block_width), block_height(h, block_height) - height]);
                }

                translate([block_width(l-1), 0, height]) {
                    cube([ss, block_width(w, block_width), block_height(h, block_height) - height]);
                }
            }
        }
        
        cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=h, block_width=block_width, block_height=block_height, knob_height=knob_height);

    }
}


module slot(material=material, large_nozzle=large_nozzle, l=l, w=w, block_height=block_height) {
    
    translate([block_width(), -0.01, panel_height_ratio*panel_height(block_height=block_height)]) {
        cube([block_width(l-2), block_width(w, block_width)+0.02, block_height(h+1, block_height=block_height)]);
    }
}
