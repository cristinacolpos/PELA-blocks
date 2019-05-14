/*
PELA HTC Vive Tracker Mount Generator


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
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../PELA-socket-panel.scad>
use <../threads/threads.scad>



/* [HTC Vive Tracker Mount] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100] // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Length of the block [blocks]
l = 6; // [1:1:20]

// Add interior fill for the base layer
solid_first_layer = false;

// Distance between Vive connector pins
pin_spacing = 3.5;



/* [Hidden] */

// Model width [blocks]
w = 6; // [1:1:20]

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
pin_vertical_offset=h1+h1_2+h2+h2_3+h3;
pin_holder_height=h1+h1_2+h2+h2_3;

// Vive cutout dimensions
pin_skin=0.15;
cd1 = 3.2+pin_skin;
ch1 = 0.5;
ch1_2 = 0.5;
cd2 = 1.75+pin_skin;
ch2 = 1.35;
cd3 = 2.55+pin_skin;
ch2_3 = 0.5;
ch3 = 0.5;
cd4 = 0.95+pin_skin;
ch4 = 2.75;
cd2b = 2.4+pin_skin;
cd2c = cd2b+2.3+pin_skin;
cd2d = cd2c-0.5+pin_skin;
slice_width = 0.6;


// Vive connector dimensions
channel_d = 7;
channel_l = 19;

// Knob disconnect from center region
connector_holder_center_lift = 0.15;

// Screwhole and alignment pin
thumscrew_offset_from_edge = block_width()+17.4;
thumbscrew_hole_d=7;
thumbscrew_border_d=11;
alignment_pin_h = 5.5;
alignment_pin_d = 4.8;
alignment_pin_offset_from_screwhole = 13.9;
cut = 0.8;



///////////////////////////////
// DISPLAY
///////////////////////////////

PELA_vive_tracker_mount(material=material, large_nozzle=large_nozzle, block_height=block_height, l=l, w=w);




///////////////////////////////////
// MODULES
///////////////////////////////////



module PELA_vive_tracker_mount(material=material, large_nozzle=large_nozzle, block_height=block_height, l=l, w=w) {

    difference() {
        union() {
            socket_panel(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, sockets=true, solid_first_layer=solid_first_layer, skin=skin, block_height=block_height);

            translate([block_width(), 2.4+block_width(1.5), panel_height()]) {
                vive_connector(material=material);
            }
            
            thumbscrew_hole_border(material=material, large_nozzle=large_nozzle, block_height=block_height, l=l, w=w);
            
            alignment_pin(material=material, large_nozzle=large_nozzle, block_height=block_height, l=l, w=w);

            hull() {
                translate([block_width(), block_width(1.81)]) {
                    cylinder(d=channel_d, h=panel_height());
                }

                translate([block_width(), block_width(4.19)]) {
                    cylinder(d=channel_d, h=panel_height());
                }
            }
        }
        
        union() {
            hull() {
                translate([block_width(), block_width(2)]) {
                    cylinder(d=block_width(0.6), h=panel_height());
                }

                translate([block_width(), block_width(4)]) {
                    cylinder(d=block_width(0.6), h=panel_height());
                }
            }
            
            thumbscrew_hole(material=material);

            thumbscrew_head_hole(material=material);

            cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=2, block_height=block_height, knob_height=knob_height);
        }
    }
}


module thumbscrew_hole(material=material, large_nozzle=large_nozzle, block_height=block_height, l=l, w=w) {
    translate([thumscrew_offset_from_edge, block_width(w/2)]) {
        cylinder(d=thumbscrew_hole_d, h=panel_height(block_height=block_height)+0.1);
    }
}


// The negative space to remove to make room for the thumbscrew head to flush mount inside the panel
module thumbscrew_head_hole(material=material, large_nozzle=large_nozzle, block_height=block_height, l=l, w=w) {

    translate([thumscrew_offset_from_edge, block_width(w/2), -0.5*panel_height(block_height=block_height)+skin]) {

        cylinder(d=thumbscrew_border_d, h=panel_height(block_height=block_height));
    }
}


module thumbscrew_hole_border(material=material, large_nozzle=large_nozzle, block_height=block_height, l=l, w=w) {

    translate([thumscrew_offset_from_edge, block_width(w/2)]) {
        cylinder(d=thumbscrew_border_d, h=panel_height(block_height=block_height));
    }
}


module alignment_pin(material=material, large_nozzle=large_nozzle, block_height=block_height, large_nozzle=large_nozzle, l=l, w=w) {

    translate([thumscrew_offset_from_edge+alignment_pin_offset_from_screwhole, block_width(w/2), panel_height(0.5)]) {
        cylinder(d=alignment_pin_d, h=panel_height(0.5) + alignment_pin_h);
    }

    translate([block_width(5), block_width(3), 0.5*panel_height(block_height=block_height)]) {

        r = override_ring_radius(material=material, large_nozzle=large_nozzle);
        
        cylinder(r=r, h=0.5*panel_height(block_height=block_height));
    }
}


// For display of interenal function and pin position
module vive_connector_left(material=material) {
    intersection() {
        vive_connector(material=material);
        translate([0, -channel_d/2, 0]) {
            cube([channel_d, channel_l+channel_d, channel_d]);
        }
    }
    
%    vive_pin_array(material=material);    
}

// For display of interenal function and pin position
module vive_connector_right(material=material, l=l, w=w) {
    difference() {
        vive_connector(material=material);
        translate([0, -channel_d/2, 0]) {
            cube([channel_d, channel_l+channel_d, channel_d]);
        }
    }
    
%    vive_pin_array(material=material, l=l, w=w);    
}


// 
module vive_connector(material=material, l=l, w=w) {
    difference() {
        channel(material=material);
        union () {
            vive_cutout_array(material=material);
            
            translate([0, (channel_l-5*pin_spacing)/2, 0]) {
                hull() {
                    cylinder(d=cd2c, h=2*connector_holder_center_lift);
                    translate([0, channel_l-pin_spacing/2, 0]) {
                        cylinder(d=cd2c, h=2*connector_holder_center_lift);
                    }
                }
            }
        }
    }
}


// A set of pins
module vive_pin_array(material=material, large_nozzle=large_nozzle, count=6) {
    for (i=[0:pin_spacing:pin_spacing*(count-1)]) {
        translate([0, i + (channel_l-(count-1)*pin_spacing)/2, pin_vertical_offset]) {
            rotate([180, 0, 0]) {
                vive_pin(material=material);
            }
        }
    }
}


// A set of negative space for pins
module vive_cutout_array(material=material, large_nozzle=large_nozzle, count=6) {
    for (i=[0:pin_spacing:pin_spacing*(count-1)]) {
        translate([0, i + (channel_l-(count-1)*pin_spacing)/2, pin_vertical_offset]) {
            rotate([180, 0, 0]) {
                vive_cutout(material=material);
            }
        }
    }
}

// A pin to connect to a Vive, slightly over actual size to create an associated negative space
module vive_pin(material=material) {
    $fn=32;
    
    cylinder(d=d1, h=h1);
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

// A pin to connect to a Vive, slightly over actual size to create an associated negative space
module vive_cutout(material=material) {
    $fn=32;
    
    cylinder(d=cd1, h=ch1);
    slice(material=material);
    translate([0, 0, ch1]) {
        cylinder(d1=cd1, d2=cd2, h=ch1_2);
        cylinder(d=cd2b, h=pin_height);
        
        translate([0, 0, ch1_2]) {
            cylinder(d=cd2, h=ch2);

            translate([0, 0, ch2]) {
                cylinder(d1=cd2, d2=cd3, h=ch2_3);
                translate([0, 0, ch2_3]) {
                    cylinder(d=cd3, h=ch3);
                    translate([0, 0, ch3]) {
                        cylinder(d=cd4, h=ch4);
                    } 
                } 
            } 
        } 
     }
}

// A flexture cut through the ring around a pin to facilitate pin insertion
module slice(material=material) {
    translate([-cd2d/2, -slice_width/2]) {
        cube([cd2d, slice_width, pin_height]);
    }
}

// The himisphical body into which pins are inserted
module channel(material=material) {
    intersection() {
        hull() {
            sphere(d=channel_d);
        
            translate([0, channel_l, 0]) {
                sphere(d=channel_d);
            }
        }
            
        translate([-channel_d/2, -channel_d/2, 0]) {
            cube([channel_d, channel_l+channel_d, pin_holder_height]);
        }
    }
}