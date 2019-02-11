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

// Board space length [mm]
length = 39.5; 

// Board space width [mm]
width = 39.5;

// Board space height [mm]
thickness = 1.8;

// Closeness of board fit lengthwise [blocks]
l_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Closeness of board fit widthwise [blocks]
w_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Height of the model [blocks]
h = 1; // [1:1:20]

// Interior fill style
center = 2; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes]

// Distance from length ends of connector twist [blocks]
twist_l = 2;

// Distance from width ends of connector twist [blocks]
twist_w = 2;

// Step in from board space edges to support the board [mm]
innercut = 1.0;




///////////////////////////////
// DISPLAY
///////////////////////////////

technic_board_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, l_pad=l_pad, w_pad=w_pad, h=h, twist_l=twist_l, twist_w=twist_w, thickness=thickness, innercut=innercut);



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_board_mount(material=undef, large_nozzle=undef, cut_line=undef, length=undef, width=undef, h=undef, l_pad=undef, w_pad=undef, twist_l=undef, twist_w=undef, thickness=undef, innercut=undef) {

    assert(l_pad == floor(l_pad), "l_pad must be an integer");
    assert(l_pad >= 0, "l_pad must be >= 0");
    assert(l_pad <= 2, "l_pad must be <= 2");
    assert(w_pad == floor(w_pad), "w_pad must be an integer");
    assert(w_pad >= 0, "w_pad must be >= 0");
    assert(w_pad <= 2, "w_pad must be <= 2");

    echo("length", length);
    echo("l_pad", l_pad);
    l = fit_mm_to_blocks(length, l_pad, block_width=block_width);
    w = fit_mm_to_blocks(width, w_pad, block_width=block_width);
    echo("l", l);
    echo("w", l);

    assert(l - 2*twist_l, "The board length is quite small- consider decreasing twist_l or increasing l_pad");
    assert(w - 2*twist_w, "The board width is quite small- consider decreasing twist_w or increasing w_pad");

    difference() {
        technic_box(material=material, large_nozzle=large_nozzle, cut_line=cut_line, w=w, twist_w=twist_w, l=l, twist_l=twist_l, h=h, center=center);
        
        union() {
            color("green") main_board(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, length=length, width=width, thickness=thickness, block_height=block_height);

            translate([innercut, innercut, 0]) {            
                main_board_back(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, length=length-2*innercut, width=width-2*innercut, block_height=block_height);
            }

            translate([block_width(-0.5, block_width=block_width), block_width(-0.5, block_width=block_width), 0]) {
                
                cut_space(material=material, large_nozzle=large_nozzle, w=w, l=l, h=h, cut_line=cut_line, block_width=block_width, block_height=block_height, knob_height=knob_height);
            }
        }
    }
}


module main_board(material=undef, large_nozzle=undef, l=undef, w=undef, h=undef, length=undef, width=undef, thickness=undef, block_height=undef) {
    
    l2 = block_width(l, block_width=block_width);
    w2 = block_width(w, block_width=block_width);

    translate([block_width(-2.5) + (l2-l)/2, block_width(-2.5) + (w2-w)/2, block_height(h, block_height=block_height) - thickness]) {
        
        cube([length, width, thickness + defeather]);
    }
}


module main_board_back(material=undef, large_nozzle=undef, l=undef, w=undef, h=undef, length=undef, width=undef, block_height=undef) {

    l2 = block_width(l, block_width=block_width);
    w2 = block_width(w, block_width=block_width);

    translate([block_width(-2.5) + (l2-l)/2, block_width(-2.5) + (w2-w)/2, -defeather]) {
        
        cube([length, width, block_height(h, block_height=block_height) + defeather]);
    }
}
