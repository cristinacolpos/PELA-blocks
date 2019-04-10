/*
PELA Slot Mount - 3D Printed LEGO-compatible PCB mount, vertical slide-in

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    https://www.futurice.com

All modules are setup for stateless functional-style reuse in other OpenSCAD files.
To this end, you can always pass in and override all parameters to create
a new effect. Doing this is not natural to OpenSCAD, so apologies for all
the boilerplate arguments which are passed in to each module or any errors
that may be hidden by the sensible default values. This is an evolving art.
*/

include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../PELA-socket-panel.scad>
use <../PELA-knob-panel.scad>
use <../technic-beam/PELA-technic-beam.scad>
use <../technic-beam/PELA-technic-twist-beam.scad>


/* [Technic Box] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Select parts to render
render_modules = 2; // [0:technic box, 1:technic cover, 2:technic box and cover]

// Total length [blocks]
l = 6; // [2:1:20]

// Total width [blocks]
w = 4; // [2:1:20]

// Distance from length ends of connector twist [blocks]
twist_l = 1; // [1:18]

// Distance from width ends of connector twist [blocks]
twist_w = 2; // [1:18]

// Height of the enclosure [blocks]
h = 2; // [1:1:20]

// Interior fill style
center = 0; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel]

// Presence of sockets if center is "socket panel"
center_sockets = true;

// Presence of knobs if center is "knob panel"
center_knobs = true;

// Size of hole in the center of knobs if "center" or "cover center" is "knob panel"
knob_vent_radius = 0.0; // [0.0:0.1:3.9]

// Text label
text = "Box";
 
// Depth of text etching into top surface
text_depth = 0.5; // [0.0:0.1:2]



/* [Cover] */

// Text label
cover_text = "Cover";

// Interior fill style
cover_center = 5; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel]

// Height of the cover [blocks]
cover_h = 1; // [1:1:20]

// Presence of sockets if "cover center" is "socket panel"
cover_sockets = true;

// Presence of knobs if "cover center" is "knob panel"
cover_knobs = true;



/* [Hidden] */

// Basic unit vertical size of each block
block_height = 8; // [8:technic, 9.6:traditional blocks]




///////////////////////////////
// DISPLAY
///////////////////////////////

if (render_modules != 0) {
    translate([0, -block_width(w + 1), 0]) {
        technic_box(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=cover_h, twist_l=twist_l, twist_w=twist_w, sockets=cover_sockets, knobs=cover_knobs, knob_vent_radius=knob_vent_radius, solid_first_layer=solid_first_layer, center=cover_center, text=cover_text, text_depth=text_depth, block_height=block_height);
    }
}

if (render_modules != 1) {
    technic_box(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, twist_l=twist_l, twist_w=twist_w, sockets=sockets, knobs=knobs, knob_vent_radius=knob_vent_radius, solid_first_layer=solid_first_layer, center=center, text=text, text_depth=text_depth, block_height=block_height);
}




///////////////////////////////////
// FUNCTIONS
///////////////////////////////////

function first_l(twist_l=undef, l=undef) = min(twist_l, ceil(l/2));

function mid_l(l=undef, l1=undef, l3=undef) = max(0, l - l1 - l3);



///////////////////////////////////
// MODULES
///////////////////////////////////


module technic_box(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, h=undef, twist_l=undef, twist_w=undef, sockets=undef, knobs=undef, knob_vent_radius=undef, solid_first_layer=undef, center=undef, text=undef, text_depth=undef, block_height=undef) {

    assert(w >= 2);
    assert(twist_w > 0);
    assert(twist_l > 0);
    assert(l >= twist_w + twist_l);
    assert(center >= 0);
    assert(center <= 6);
    assert(text != undef);
    assert(text_depth != undef);
    assert(block_height != undef);

    difference() {
        union() {
            technic_only_box(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, h=h, twist_l=twist_l, twist_w=twist_w, center=center, text=text, text_depth=text_depth, block_height=block_height);
            
            lc = l - 2;
            wc = w - 2;

            if (center == 5 && lc > 0 && wc > 0) {
                translate([block_width(0.5), block_width(0.5), 0]) {
                    socket_panel(material=material, large_nozzle=large_nozzle, l=lc, w=wc, skin=0, block_height=block_height, sockets=sockets, solid_first_layer=solid_first_layer);
                }
            } else if (center == 6 && lc > 0 && wc > 0) {
                translate([block_width(0.5), block_width(0.5), 0]) {
                    knob_panel(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=lc, w=wc, top_vents=top_vents, solid_first_layer=solid_first_layer, corner_bolt_holes=false, knobs=knobs, sockets=sockets, skip_edge_knobs=0, bottom_stiffener_height=0, block_height=block_height, knob_vent_radius=knob_vent_radius, skin=0);
                }
            }
        }

        translate([-block_width(0.5), -block_width(0.5), 0]) {
            cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=h, block_height=block_height, knob_height=knob_height);
        }
    }
}


module technic_only_box(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, h=undef, twist_l=undef, twist_w=undef, center=undef, text=undef, text_depth=undef, block_height=block_height) {

    tl = first_l(twist_l, l);
    l1 = tl;
    l2 = mid_l(l, l1, l1);
    l3 = l - l1 - l2;
    tw = first_l(twist_w, w);
    w1 = tw;
    w2 = mid_l(w, w1, w1);
    w3 = w - w1 - w2;

    difference() {
        union() {
            for (i = [1:h]) {
                translate([0, 0, block_height(i-1, block_height)]) {
                    t = (i==h) ? text : "";
                    
                    technic_rectangle(material=material, large_nozzle=large_nozzle, l1=l1, l2=l2, l3=l3, w1=w1, w2=w2, w3=w3, text=t, text_depth=text_depth, block_height=block_height);
               }
            }

            if (center > 0 && center < 5) {
                difference() {
                    translate([block_width(0.5), block_width(0.5), 0]) {
                        cube([block_width(l-2), block_width(w-2), block_height(h, block_height)]);
                    }
                    
                    cheese_holes(material=material, large_nozzle=large_nozzle, center=center, l=l, w=w, h=h, l1=l1, l2=l2, w1=w1, w2=w2);
                }
            }
        }
        
        translate([block_width(-0.5), block_width(-0.5), 0]) {
            
            cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=h, block_height=block_height, knob_height=knob_height);
        }
    }
}


module edge_text(l=undef, w=undef, h=undef, text=undef, text_depth=undef) {

    translate([block_width((l-1)/2), block_width(w-1), block_height(h, block_height) - text_depth]) {
        font = "Liberation Sans";

        color("black") linear_extrude(height = text_depth + _defeather) {
            text(text, font = font, size = 4.8, valign = "center", halign = "center");
        }
    }
}


module technic_rectangle(material=material, large_nozzle=large_nozzle, l1=undef, l2=undef, l3=undef, w1=undef, w2=undef, w3=undef, text=undef, text_depth=undef, block_height=undef) {

    assert(l1 > 0, "increase first l section to 1");
    assert(l2 >= 0, "increase second l section to 0");
    assert(l3 > 0,"increase third l section to 1");
    assert(w1 > 0, "increase first w section to 1");
    assert(w2 >= 0, "increase second w section to 0");
    assert(w3 > 0, "increase third w section to at least 1");
    assert(block_height == 8);

    ll = l1+l2+l3;
    ww = w1+w2+w3;

    difference() {
        union() {
            technic_twist_beam(material=material, large_nozzle=large_nozzle, left=l1, center=l2, right=l3);

            rotate([0, 0, 90]) {
                technic_twist_beam(material=material, large_nozzle=large_nozzle, left=w1, center=w2, right=w3);
            }

            translate([0, block_width(ww-1), 0]) {
                technic_twist_beam(material=material, large_nozzle=large_nozzle, left=l1, center=l2, right=l3);
            }

            rotate([0, 0, 90]) {
                translate([0, -block_width(ll-1), 0]) {
                    technic_twist_beam(material=material, large_nozzle=large_nozzle, left=w1, center=w2, right=w3);
                }
            }
        }
        
        edge_text(l=ll, w=ww, h=1, text=text, text_depth=text_depth);
    }
}


module cheese_holes(material=undef, large_nozzle=undef, center=undef, l=undef, w=undef, h=undef, l1=undef, l2=undef, w1=undef, w2=undef) {

    assert(l >= l1+l2, "l must be at least l1+l2");
    assert(w >= w1+w2, "l must be at least l1+l2");
    assert(center >= 0, "center must be at least 0");
    assert(center <= 4, "center must be at most 4");

    if (center > 1) {
        if (l2 > 0 && center != 3) {
            side_cheese_holes(material=material, large_nozzle=large_nozzle, w=w, l1=l1, l2=l2, h=h, block_height=block_height);
        }
        
        if (w2 > 0 && center != 3) {
            end_cheese_holes(material=material, large_nozzle=large_nozzle, l=l, w1=w1, w2=w2, h=h, block_height=block_height);
        }
        
        if (w > 2 && l > 2 && center !=2) {
            bottom_cheese_holes(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, block_height=block_height);
            
            top_cheese_holes(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, block_height=block_height);
        }
    }
}


module side_cheese_holes(material=undef, large_nozzle=undef, w=undef, l1=undef, l2=undef, h=undef, block_height=block_height) {
    
    for (i = [0:l2-1]) {
        for (j = [0:h-1]) {
            translate([block_width(l1+i), block_width(-0.5), block_height(0.5+j, block_height=block_height)]) {
                rotate([-90, 0, 0]) {
                    axle_hole(material=material, large_nozzle=large_nozzle, hole_type=2, radius=material_axle_hole_radius(material=material, large_nozzle=large_nozzle), length=block_width(w));
                }
            }
        }
    }    
}


module end_cheese_holes(material=undef, large_nozzle=undef, l=undef, w1=undef, w2=undef, h=undef, block_width=undef, block_height=undef) {

    translate([block_width(l-1), 0, 0]) {
        rotate([0, 0, 90]) {
            side_cheese_holes(material=material, large_nozzle=large_nozzle, w=l, l1=w1, l2=w2, h=h, block_height=block_height);
        }
    }
}


module bottom_cheese_holes(material=undef, large_nozzle=undef, w=undef, l=undef, h=undef, block_width=undef, block_height=undef) {

    for (i = [1:l-2]) {
        for (j = [1:w-2]) {
            translate([block_width(i), block_width(j), -_defeather]) {
                 axle_hole(material=material, large_nozzle=large_nozzle, hole_type=2, radius=material_axle_hole_radius(material=material, large_nozzle=large_nozzle), length=block_height(h, block_height)+2*_defeather);
            }
        }
    }    
}


module top_cheese_holes(material=undef, large_nozzle=undef, w=undef, l=undef, h=undef, block_width=undef, block_height=undef) {
    
    translate([block_width(0), block_width(w-1), block_height(h, block_height)]) {
        
        rotate([180, 0, 0]) {
            bottom_cheese_holes(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, block_height=block_height);
        }
    }
}
