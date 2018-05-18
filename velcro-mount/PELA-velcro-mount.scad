/*
Parametric PELA Velcro Mount

A part for inserting velcro straps to attachment PELA parts to other
objects. Other types of strap can also be used. The slots

The current design omits top knobs which would interfere with the
matching "PELA-vive-tracker-mount.scad".

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
use <../knob-panel/PELA-knob-panel.scad>

/* [PELA Panel Options] */

// Eliminate a few select knobs that are in the way of a PELA-vive-tracker-mount.scad sitting on top of this part
hide_vive_mount_knobs = true;

// Length of the block (PELA unit count)
l = 6; 

// Width of the block (PELA unit count)
w = 6;

top_vents = false;

// Interior fill for layers above the bottom
solid_bottom_layer = false;

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
bolt_holes = false;

// Size of corner holes for M3 mountings bolts
bolt_hole_radius = 1.5;

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



// Display
top_panel();
velcro_mount();


module top_panel(hide_vive_mount_knobs=hide_vive_mount_knobs) {
    translate([block_width(-3), block_width(-2), 0]) {
        cube([block_width(w), block_width(4), panel_height()]);
    }

    translate([block_width(-l/2), block_width(-w/2)]) {
        difference() {
            PELA_knob_panel(l=l, w=w, top_vents=top_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs);

            union() {
                if (hide_vive_mount_knobs) {
                    translate([block_width(l/2-1), block_width(w/2-1), panel_height()]) {
                        cube([block_width(2), block_width(2), panel_height()]);
                    }
                
                    translate([block_width(l/2-3), block_width(w/2-2), panel_height()]) {
                        cube([block_width(2), block_width(4), panel_height()]);
                    }
                }
            }
        }
    }
}


module velcro_mount() {
    difference() {
        rail_body(w=holder_width);
        slot();
    }
}


module rail_body(w=undef, body_height=body_height) {
    translate([-body_length/2, -w/2, -body_height]) {
        cube([body_length, w, body_height]);    
    }
}


module slot() {
    rotate([0, 0, 90]) {
        rail_body(w=body_width, body_height=body_height/2);
    }
}
