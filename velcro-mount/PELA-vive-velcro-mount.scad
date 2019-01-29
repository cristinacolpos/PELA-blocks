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

include <../style.scad>
include <../print-style.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <PELA-velcro-mount.scad>


/* [PELA Panel Options] */

l = 6; // Length of the mount [blocks]

w = 6; // Width of the mount [blocks]

h = 1; // Height of the mount [blocks]

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

// Interior fill for layers above the bottom
solid_bottom_layer = true;

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
corner_bolt_holes = false;

side_holes = 0;

end_holes = 2;

end_sheaths = 0;

// Presence of top connector knobs
knobs = true;

// Picatinny/NATO Rail Mount Dimensions
body_width = 21.2 - skin;

top_width = 19;

body_height = 9;

body_length = block_width(l-1);

top_height = 2.74;

top_vertical_offset = 4.17;

base_width = 15.67 + skin;

holder_width = block_width(w - 2.5);


////////////////////////////////////
// DISPLAY
///////////////////////////////////

vive_velcro_mount();



///////////////////////////////////
// MODULES
///////////////////////////////////

module vive_velcro_mount(l=l, w=w, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, solid_bottom_layer=solid_bottom_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, block_height=block_height) {

    difference() {
        velcro_mount(l=l, w=w, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, solid_bottom_layer=solid_bottom_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs);

        union() {
            translate([block_width(l/2-1), block_width(w/2-1), panel_height(block_height=block_height)]) {
                cube([block_width(2), block_width(2), block_height(1, block_height=block_height)]);
            }
        
#            translate([block_width(l/2-2), block_width(w/2-2), panel_height(block_height=block_height)]) {
                cube([block_width(1), block_width(4), block_height(1, block_height=block_height)]);
            }
        
#            translate([block_width(l/2-3), block_width(w/2-2), block_height(1, block_height=block_height)]) {
                cube([block_width(1), block_width(4), block_height(1, block_height=block_height)]);
            }
        }
    }
}
