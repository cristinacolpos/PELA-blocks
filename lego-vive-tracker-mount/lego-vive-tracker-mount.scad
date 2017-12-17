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
use <../threads/threads.scad>

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
knobs=0; // [0:disabled, 1:enabled]

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

// Winchester Ranger Model 120
winchester_rail_w = 9.55;
winchester_rail_h = 3.15;
winchester_rail_clearance = 7; // top to barrel


// Vive connector dimensions
channel_d = 7;
channel_l = 19;

// Knob disconnect from center region
connector_holder_center_lift = 0.15;

// Screwhole and alignment pin
thumscrew_offset_from_edge = lego_width()+17.4;
thumbscrew_hole_d=7;
thumbscrew_border_d=11;
alignment_pin_h = 5.5;
alignment_pin_d = 4.8;
alignment_pin_offset_from_screwhole = 13.9;
cut = 0.8;

/* [LEGO-compatible Options] */

// What type of object to generate: 1=>block, 2=>block without top knobs, 3=>block without bottom connector, 4=>block without top knob or bottom connector
mode=1; // [1:1, 2:2, 3:3, 4:4]

/////////////////////////////////////
// LEGO vive mount and screw display
/////////////////////////////////////

if (mode==1) {
    lego_vive_tracker_mount();
} else if (mode==2) {
    thumbscrew();
} else if (mode==3) {
    lego_vive_tracker_mount();
    translate([-5, -5])
        thumbscrew();
} else {
    echo("<b>Unsupported mode: please check <i>mode</i> variable is 1-3</b>");
}


/////////////////////////////////////
// LEGO panel display
/////////////////////////////////////

lego_vive_tracker_mount();

//translate([-5, -5]) thumbscrew();

//vive_connector();
//vive_connector_left();
//vive_connector_right();


/////////////////////////////////////
// LEGO VIVE TRACKER modules
/////////////////////////////////////


module thumbscrew() {
    height=panel_height(0.5)-skin;
    
    translate([0, 0, height])
        us_bolt_thread(dInch=0.25, hInch=1/4, tpi=20);

    thumbscrew_head(height=height);
}


module thumbscrew_head(height=undef) {
    cylinder(d=thumbscrew_border_d/2, h=height);

    difference() {
        difference() {
            cylinder(d=thumbscrew_border_d-0.2, h=height);
            translate([-cut/2, 0])
                cube([cut, thumbscrew_border_d, cut]);
            
        }
        union() {
            for (i = [30:30:360]) {
                rotate([0, 0, i])
                    translate([-cut/2, 0])
                        cube([cut, thumbscrew_border_d, cut]);
            }
        }
    }
}


module thumbscrew_hole() {
    translate([thumscrew_offset_from_edge, lego_width(w/2)])
        cylinder(d=thumbscrew_hole_d, h=panel_height()+0.1);
}


// The negative space to remove to make room for the thumbscrew head to flush mount inside the panel
module thumbscrew_head_hole() {
    translate([thumscrew_offset_from_edge, lego_width(w/2), -panel_height(0.5)+skin])
        cylinder(d=thumbscrew_border_d, h=panel_height());
}


module thumbscrew_hole_border() {
    translate([thumscrew_offset_from_edge, lego_width(w/2)])
        cylinder(d=thumbscrew_border_d, h=panel_height());
}


module alignment_pin() {
    translate([thumscrew_offset_from_edge+alignment_pin_offset_from_screwhole, lego_width(w/2), panel_height(0.5)])
        cylinder(d=alignment_pin_d, h=panel_height(0.5)+alignment_pin_h);

    translate([lego_width(5), lego_width(3), panel_height(0.5)])
        cylinder(r=ring_radius, h=panel_height(0.5));
}


module lego_vive_tracker_mount() {
    difference() {
        union() {
            lego_socket_panel(l=l, w=w, top_tweak=top_tweak, bottom_tweak=bottom_tweak, top_vents=top_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius);

            translate([lego_width(), 2.4+lego_width(1.5), panel_height()])
                vive_connector();
            
            thumbscrew_hole_border();
            
            alignment_pin();

            hull() {
                translate([lego_width(1), lego_width(1.81)])
                    cylinder(d=channel_d, h=panel_height());

                translate([lego_width(1), lego_width(4.19)])
                    cylinder(d=channel_d, h=panel_height());
            }
        }
        
        union() {
            hull() {
                translate([lego_width(1), lego_width(2)])
                    cylinder(d=lego_width(0.6), h=panel_height());

                translate([lego_width(1), lego_width(4)])
                    cylinder(d=lego_width(0.6), h=panel_height());
            }
            
            thumbscrew_hole();
            thumbscrew_head_hole();
        }
    }
    
}


// For display of interenal function and pin position
module vive_connector_left() {
    intersection() {
        vive_connector();
        translate([0, -channel_d/2, 0])
            cube([channel_d, channel_l+channel_d, channel_d]);
    }
    
%    vive_pin_array();    
}

// For display of interenal function and pin position
module vive_connector_right() {
    difference() {
        vive_connector();
        translate([0, -channel_d/2, 0])
            cube([channel_d, channel_l+channel_d, channel_d]);
    }
    
%    vive_pin_array();    
}


// 
module vive_connector() {
    difference() {
        channel();
        union () {
            vive_cutout_array();
            
            translate([0, (channel_l-5*pin_spacing)/2, 0])
                hull() {
                    cylinder(d=cd2c, h=2*connector_holder_center_lift);
                    translate([0, channel_l-pin_spacing/2, 0])
                        cylinder(d=cd2c, h=2*connector_holder_center_lift);
                }
        }
    }
}


// A set of pins
module vive_pin_array(count=6) {
    for (i=[0:pin_spacing:pin_spacing*(count-1)]) {
        translate([0, i + (channel_l-(count-1)*pin_spacing)/2, pin_vertical_offset])
            rotate([180, 0, 0])
                vive_pin();
    }
}


// A set of negative space for pins
module vive_cutout_array(count=6) {
    for (i=[0:pin_spacing:pin_spacing*(count-1)]) {
        translate([0, i + (channel_l-(count-1)*pin_spacing)/2, pin_vertical_offset])
            rotate([180, 0, 0])
                vive_cutout();
    }
}

// A pin to connect to a Vive, slightly over actual size to create an associated negative space
module vive_pin() {
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
module vive_cutout() {
    $fn=32;
    
    cylinder(d=cd1, h=ch1);
            slice();
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
module slice() {
    translate([-cd2d/2, -slice_width/2])
        cube([cd2d, slice_width, pin_height]);
}

// The himisphical body into which pins are inserted
module channel() {
    intersection() {
        hull() {
            sphere(d=channel_d);
        
            translate([0, channel_l, 0])
                sphere(d=channel_d);
        }
            
        translate([-channel_d/2, -channel_d/2, 0])
            cube([channel_d, channel_l+channel_d, pin_holder_height]);
        }
}