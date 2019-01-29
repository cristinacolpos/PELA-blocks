/*
Parametric PELA Velcro Mount

A part for inserting velcro straps to attachment PELA parts to other
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

include <../parameters.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../knob-panel/PELA-knob-panel.scad>


/* [PELA Velcro Mount Options] */

l = 4; // Length of the mount [blocks]

w = 4; // Width of the mount [blocks]

h = 1; // Height of the mount [blocks]

// Interior fill for layers above the bottom
solid_bottom_layer = true;

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
corner_bolt_holes = false;

side_holes = 0;

end_holes = 2;

end_sheaths = 0;

// Presence of top connector knobs
knobs = true;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;



///////////////////////////////
// Display
///////////////////////////////

velcro_mount();



///////////////////////////////////
// Modules
///////////////////////////////////

module velcro_mount(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, solid_bottom_layer=solid_bottom_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, block_height=block_height) {

    difference() {
        PELA_technic_block(l=l, w=w, h=h, side_holes=side_holes, end_holes=end_holes, solid_bottom_layer=solid_bottom_layer, sockets=false, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, block_height=block_height);

        slot(l=l, w=w, block_height=block_height);
    }
}


module slot(l=l, w=w, block_height=block_height) {
    
    translate([block_width(), -0.01, 0.5*panel_height(block_height=block_height)]) {
        cube([block_width(l-2), block_width(w)+0.02, panel_height(block_height=block_height)]);
    }
}
