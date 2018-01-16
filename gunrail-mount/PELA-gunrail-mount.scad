/*
Parametric PELA Long Gun Rail Mount

A "rail" is a Picatinny/NATO metal bar for attachments along the
the barrel of a gun. See also the "PELA-gunrib-mount.scad" for an
alternative design.

The current design omits top knobs which would interfere with the
matching "PELA-vive-tracker-mount.scad".

Published at
    http://www.thingiverse.com/thing:2303714
Maintained at
    https://github.com/paulirotta/parametric_PELA
See also the related files
    PELA Sign Generator - https://www.thingiverse.com/thing:2546028
    PELA Enclosure Generator - https://www.thingiverse.com/thing:2544197


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
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
use <../knob-panel/PELA-knob-panel.scad>

/* [PELA Panel Options] */

// Eliminate knobs that are in the way of PELA-vive-tracker-mount.scad sitting on top of this part
hide_vive_mount_knobs = 1;

// Length of the block (PELA unit count)
l = 6; 

// Width of the block (PELA unit count)
w = 6;

top_vents = 0;

// Interior fill for layers above the bottom
solid_bottom_layer = 0; // [0:empty, 1:solid]

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0; // [0:no holes, 1:holes]

// Size of corner holes for M3 mountings bolts
bolt_hole_radius=1.5;

// Presence of top connector knobs
knobs=1; // [0:disabled, 1:enabled]

// Picatinny/NATO Rail Mount Dimensions
body_width = 21.2 - skin;

top_width = 19;

body_height = 9;

body_length = block_width(l-1);

top_height = 2.74;

top_vertical_offset = 4.17;

base_width = 15.67 + skin;

holder_width = block_width(w-2.5);



// Display
top_panel();
rail_mount();


module top_panel(hide_vive_mount_knobs=hide_vive_mount_knobs) {
    translate([block_width(-3), block_width(-2), 0])
        cube([block_width(w), block_width(4), panel_height()]);

    translate([block_width(-l/2), block_width(-w/2)])
        difference() {
            PELA_knob_panel(l=l, w=w, top_vents=top_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs);

            union() {
                if (is_true(hide_vive_mount_knobs)) {
                    translate([block_width(l/2-1), block_width(w/2-1), panel_height()])
                        cube([block_width(2), block_width(2), panel_height()]);
                
                    translate([block_width(l/2-3), block_width(w/2-2), panel_height()])
                        cube([block_width(2), block_width(4), panel_height()]);
                }
            }
        }
}


module rail_mount() {
    difference() {
        rail_body(w=holder_width);
        rail();
    }
}


module rail_body(w=undef) {
    translate([-body_length/2, -w/2, -body_height])
        cube([body_length, w, body_height]);    
}


module rail() {
    difference() {
        rail_body(w=body_width);
        
        union() {
            top_cut();
            rotate([0, 0, 180])
                top_cut();
        }
    }

    translate([-body_length/2, -base_width/2, -body_height])
        cube([body_length, base_width, body_height]);
}

// 45 degree angle cuts from the top of the body of the rail
module top_cut() {
    translate([-body_length/2-defeather, -body_width/2, -top_vertical_offset+top_height/2]) {
        rotate([45, 0, 0])
            translate([0, -top_width/2, 0])
                cube([body_length+2*defeather, top_width, body_height]);

        rotate([135, 0, 0])
            translate([0, -top_width/2, 0])
                cube([body_length+2*defeather, top_width, body_height]);
    }
}
