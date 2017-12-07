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
use <../lego-socket-panel/lego-socket-panel.scad>

/* [LEGO Panel Options] */

// Length of the block (LEGO unit count)
l = 6; 

// Width of the block (LEGO unit count)
w = 6;

top_vents = 1;

// Interior fill for layers above the bottom
solid_bottom_layer = 0; // [0:empty, 1:solid]

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0; // [0:no holes, 1:holes]

// Size of corner holes for M3 mountings bolts
bolt_hole_radius=1.5;

// Presence of top connector knobs
knobs=1; // [0:disabled, 1:enabled]

// Distance between Vive connector pins
pin_spacing = 3.5;

// Vive pin dimensions
d1 = 3.2;
h1 = 0.5;
h1_2 = 0.5;
d2 = 1.75;
h2 = 1.35;
d3 = 2.55;
h2_3 = 0.5;
h3 = 0.5;
d4 = 0.95;
h4 = 2.75;
pin_height=h1+h1_2+h2+h2_3+h3+h4;
pin_vertical_offset=h1+h1_2+h2+h2_3;

// Vive connector dimensions
channel_d = 7;
channel_l = 19;

/////////////////////////////////////
// LEGO panel display
/////////////////////////////////////

vive_connector();
//vive_connector_left();
//vive_connector_right();
//lego_vive_tracker_mount();

/////////////////////////////////////
// LEGO VIVE TRACKER modules
/////////////////////////////////////

module lego_vive_tracker_mount() {
    difference() {
        union() {
            lego_socket_panel(l=l, w=w, top_tweak=top_tweak, bottom_tweak=bottom_tweak, top_vents=top_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius);

            translate([13, 9, 0])
                rotate([0, 0, 90])
                    connector();
        }
        
#        translate([lego_width(0.5), lego_width(1.5)])
            cube([lego_width(1), lego_width(3), panel_height()]);
    }
    
}

module connector() {
    translate([14.5, -17.5, panel_height()])
        import("ViveTrackerConnector.stl", convexity=3);
}

module vive_connector_left() {
    intersection() {
        vive_connector();
        translate([0, -channel_d/2, 0])
            cube([channel_d, channel_l+channel_d, channel_d]);
    }
    
%    vive_pin_array();    
}

module vive_connector_right() {
    difference() {
        vive_connector();
        translate([0, -channel_d/2, 0])
            cube([channel_d, channel_l+channel_d, channel_d]);
    }
    
%    vive_pin_array();    
}


module vive_connector() {
    difference() {
        channel();
        vive_pin_array();
    }
}


module vive_pin_array(count=6) {
    for (i=[0:pin_spacing:pin_spacing*count]) {
        translate([0, pin_spacing/2 + i - (channel_l+channel_d-count*pin_spacing)/2, pin_vertical_offset])
            rotate([180, 0, 0])
                vive_pin();
    }
}

// A pin to connect to a Vive, slightly over actual size to create an associated negative space
module vive_pin() {
    $fn=32;
    
    cylinder(d=d1, h = h1);
    translate([0, 0, h1]) {
        cylinder(d1=d1, d2=d2, h=h1_2);
        translate([0, 0, h1_2]) {
            cylinder(d=d2, h=h2);
            translate([0, 0, h2]) {
                cylinder(d1=d2, d2=d3, h=h2_3);
                translate([0, 0, h2_3]) {
                    cylinder(d=d3, h=h3);
                    translate([0, 0, h3]) {
                        cylinder(d=d4, h=h4);
                    } 
                } 
            } 
        } 
     }
}

module channel() {
    intersection() {
        hull() {
            sphere(d=channel_d);
        
            translate([0, channel_l, 0])
                sphere(d=channel_d);
        }
            
        translate([-channel_d/2, -channel_d/2, 0])
            cube([channel_d, channel_l+channel_d, pin_vertical_offset]);
        }
}