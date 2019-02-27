/*
PELA Technic Board Mount - 3D Printed LEGO-compatible PCB mount used for including printed ciruit boards in technic models

This is a library module used by other models

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
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-twist-bar.scad>
use <PELA-technic-box.scad>



/* [Technic Board Mount] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Select parts to render
render_modules = 2; // [0:technic mount, 1:technic cover, 2:technic mount and cover]

// Board space length [mm]
length = 39.5; // [0:0.1:300]

// Board space width [mm]
width = 39.5; // [0:0.1:300]

// Board space height [mm]
thickness = 1.8; // [0:0.1:300]

// Distance from length ends of connector twist [blocks]
twist_l = 1; // [1:18]

// Distance from width ends of connector twist [blocks]
twist_w = 2; // [1:18]

// Closeness of board fit lengthwise [blocks]
l_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Closeness of board fit widthwise [blocks]
w_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Height of the model [blocks]
h = 1; // [1:1:20]

// Interior fill style
center = 2; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel]]

// Step in from board space edges to support the board [mm]
innercut = 1.0; // [0:0.1:100]

// Step down from board bottom to give room board components [mm]
undercut = 1.0; // [0:0.1:100]

// Presence of sockets if center is "socket panel"
center_sockets = true;

// Presence of knobs if center is "knob panel"
center_knobs = true;

// Size of hole in the center of knobs if "center" or "cover center" is "knob panel"
knob_vent_radius = 0.0; // [0.0:0.1:3.9]

// Text label
text = "PCB";

// Depth of text etching into top surface
text_depth = 0.5; // [0.0:0.1:2]

// Basic unit vertical size of each block
block_height = 8; // [8:technic, 9.6:traditional blocks]



/* [Technic Cover] */

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




///////////////////////////////
// DISPLAY
///////////////////////////////

technic_mount_and_cover(render_modules=render_modules, material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, thickness=thickness, h=h, l_pad=l_pad, w_pad=w_pad, twist_l=twist_l, twist_w=twist_w, center_sockets=center_sockets, center_knobs=center_knobs, cover_sockets=cover_sockets, cover_knobs=cover_knobs, knob_vent_radius=knob_vent_radius, solid_first_layer=solid_first_layer, innercut=innercut, undercut=undercut, center=center, text=text, cover_text=cover_text, text_depth=text_depth, block_height=block_height);



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_mount_and_cover(render_modules=undef, material=undef, large_nozzle=undef, cut_line=undef, length=undef, width=undef, thickness=undef, h=undef, l_pad=undef, w_pad=undef, twist_l=undef, twist_w=undef, center_sockets=undef, center_knobs=undef, cover_sockets=undef, cover_knobs=undef, knob_vent_radius=undef, solid_first_layer=undef, innercut=undef, undercut=undef, center=undef, text=undef, cover_text=undef, text_depth=undef, block_height=undef) {

    if (render_modules != 0) {
        l = fit_mm_to_blocks(length, l_pad, block_width=block_width);
        w = fit_mm_to_blocks(width, w_pad, block_width=block_width);

        translate([0, -block_width(w + 0.5, block_width), 0]) {
            technic_box(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=cover_h, twist_l=twist_l, twist_w=twist_w, sockets=cover_sockets, knobs=cover_knobs, knob_vent_radius=knob_vent_radius, solid_first_layer=solid_first_layer, center=cover_center, text=cover_text, text_depth=text_depth, block_height=block_height);
        }
    }

    if (render_modules != 1) {
        technic_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, thickness=thickness, h=h, l_pad=l_pad, w_pad=w_pad, twist_l=twist_l, twist_w=twist_w, sockets=center_sockets, knobs=center_knobs, knob_vent_radius=knob_vent_radius, solid_first_layer=solid_first_layer, innercut=innercut, undercut=undercut, center=center, text=text, text_depth=text_depth, block_height=block_height);
    }
}


module technic_mount(material=undef, large_nozzle=undef, cut_line=undef, length=undef, width=undef, thickness=undef, h=undef, l_pad=undef, w_pad=undef, twist_l=undef, twist_w=undef, sockets=undef, knobs=undef, knob_vent_radius=undef, solid_first_layer=undef, innercut=undef, undercut=undef, center=undef, text=undef, text_depth=undef, block_height=undef) {

    assert(l_pad == floor(l_pad), "l_pad must be an integer");
    assert(l_pad >= 0);
    assert(l_pad <= 2);
    assert(w_pad == floor(w_pad), "w_pad must be an integer");
    assert(w_pad >= 0);
    assert(w_pad <= 2);
    assert(text != undef);
    assert(text_depth != undef);
    assert(sockets != undef);
    assert(knobs != undef);

    l = fit_mm_to_blocks(length, l_pad, block_width=block_width);
    w = fit_mm_to_blocks(width, w_pad, block_width=block_width);
    echo("l", l);
    echo("w", l);

    assert(l - 2*twist_l, "Board length is quite small- decrease twist_l or increase l_pad");
    assert(w - 2*twist_w, "Board width is quite small- decrease twist_w or increase w_pad");

    difference() {
        technic_box(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, twist_l=twist_l, twist_w=twist_w, sockets=sockets, knobs=knobs, knob_vent_radius=knob_vent_radius, solid_first_layer=solid_first_layer, center=center, text=text, text_depth=text_depth, block_height=block_height);
        
        union() {
            color("green") main_board(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, length=length, width=width, thickness=thickness, block_height=block_height);

            translate([innercut, innercut, 0]) {            
                main_board_back(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, length=length, width=width, thickness=thickness, innercut=innercut, undercut=undercut, block_height=block_height);
            }

            translate([block_width(-0.5, block_width=block_width), block_width(-0.5, block_width=block_width), 0]) {
                
                cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, cut_line=cut_line, block_width=block_width, block_height=block_height, knob_height=knob_height);
            }
        }
    }
}


module main_board(material=undef, large_nozzle=undef, l=undef, w=undef, h=undef, length=undef, width=undef, thickness=undef, block_height=undef) {
    
    l2 = block_width(l-1, block_width);
    w2 = block_width(w-1, block_width);
    hl = l2/2 - length/2;
    hw = w2/2 - width/2;

    translate([hl, hw, block_height(h, block_height) - thickness]) {
        
        cube([length, width, thickness + defeather]);
    }
}


module main_board_back(material=undef, large_nozzle=undef, l=undef, w=undef, h=undef, length=undef, width=undef, thickness=undef, innercut=undef, undercut=undef, block_height=undef) {

    l2 = block_width(l-1, block_width);
    w2 = block_width(w-1, block_width);
    hl = l2/2 - length/2 - innercut;
    hw = w2/2 - width/2 - innercut;

    translate([hl+innercut, hw+innercut, block_height(h, block_height) - thickness - undercut]) {
        
        cube ([length-2*innercut, width-2*innercut, undercut + 2*defeather]);
    }
}
