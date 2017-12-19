/*
Parametric LEGO Block

Published at
    http://www.thingiverse.com/thing:2303714
Maintained at
    https://github.com/paulirotta/parametric_lego
See also the related files
    LEGO Sign Generator - https://www.thingiverse.com/thing:2546028
    LEGO Enclosure Generator - https://www.thingiverse.com/thing:2544197


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com

Import this into other design files:
    use <lego.scad>
*/

include <../lego-parameters.scad>
use <../lego.scad>
use <../technic.scad>
use <../lego-knob-panel/lego-knob-panel.scad>

/* [LEGO Panel Options] */

// Length of the block (LEGO unit count)
l = 6; 

// Width of the block (LEGO unit count)
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

mount_type = 1; //[0:Picatinny/NATO, 1:Shotgun Rib]

// Picatinny/NATO Rail Mount Dimensions
body_width = 21.2 - skin;

top_width = 19;

body_height = 9;

body_length = lego_width(l-1);

top_height = 2.74;

top_vertical_offset = 4.17;

base_width = 15.67 + skin;

holder_width = lego_width(w-2.5);


// Shotgun Square Rib Mount Dimensions (these are not standardized and may taper down towards the tip, measure the gun)
rib_width = 15;

rib_thickness = 25.4/4;

rib_holder_height = 25.4;

rib_body_width = 20;

rib_body_thickness = 8;

rib_base_width = rib_width - 1;

defeather = 0.01;



// Display
top_panel();

if (mount_type == 1) {
    rail_mount();
} else if (mount_type == 2) {
    rib_mount();
} else {
    echo("<b>Unsupported mount type: please check <i>mode</i> variable is 1-4</b>");
}


module top_panel() {
    translate([lego_width(-3), lego_width(-2), 0])
        cube([lego_width(w), lego_width(4), panel_height()]);

    translate([lego_width(-l/2), lego_width(-w/2)])
        difference() {
            lego_knob_panel(l=l, w=w, top_vents=top_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs);

            union() {
                translate([lego_width(l/2-1), lego_width(w/2-1), panel_height()])
                    cube([lego_width(2), lego_width(2), panel_height()]);
                
                translate([lego_width(l/2-3), lego_width(w/2-2), panel_height()])
                    cube([lego_width(2), lego_width(4), panel_height()]);
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

module rib_mount() {
    difference() {
        rib_body();
        rib();
    }
}

module rib() {
    translate([-body_length/2, -rib_width/2, -rib_thickness])
        cube([body_length, rib_width, rib_thickness]);

    translate([-body_length/2, -rib_base_width/2, -rib_body_thickness])
        cube([body_length, rib_base_width, rib_body_thickness]);
}

module rib_body() {
    translate([-body_length/2, -rib_body_width/2, -rib_body_thickness])
        cube([body_length, rib_body_width, rib_body_thickness]);
}

