/*
PELA Raspberry Pi3 Technic Mount - 3D Printed LEGO-compatible PCB mount on which other technic and PELA parts can be stacked to create a complete case

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

include <../parameters.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../socket-panel/PELA-socket-panel.scad>
use <../knob-mount/PELA-knob-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-twist-bar.scad>
include <PELA-technic-board-mount.scad>

/* [Raspberry Pi3 Technic Mount Options] */

length = 86.2; // board space length [mm]
width = 56.8; // board space width [mm]
length_tightness = 1.5; // closeness of board fit lengthwise inside a ring of blocks [blocks/blocks] (increase to make outer box slightly larger)
width_tightness = 1.5; // closeness of board fit widthwise inside a ring of blocks [blocks/blocks] (increase to make outer box slightly larger)
twist_length = 2; // How many blocks in from  length ends do the technic holes rotate 90 degrees
twist_width = 2; // How many blocks in from width ends do the technic holes rotate 90 degrees
thickness = 1.9; // board space height [mm]
innercut = 0.8; // Step in from board space edges to support the board [mm]
bottom_corner_bolt_holes = true; // Mounting holes inset from the corners




///////////////////////////////
// DISPLAY
///////////////////////////////

pi3_technic_mount();



///////////////////////////////////
// MODULES
///////////////////////////////////

module pi3_technic_mount(length=length, width=width, length_tightness=length_tightness, width_tightness=width_tightness, twist_length=twist_length, twist_width=twist_width) {

    l_fit = 1;
    l = fit_mm_to_pela_blocks(length, length_tightness) - l_fit;
    w = fit_mm_to_pela_blocks(width, width_tightness);
    x=1;
    y=0.5;
    l1 = l - 2*twist_length;    
    l3 = l1;
    l2 = l - l1 - l3;
    w1 = w - 2*twist_width;
    w3 = w1;
    w2 = w - w1 - w3;

    difference() {
        union() {
            technic_board_mount(length=length, width=width, length_tightness=length_tightness, width_tightness=width_tightness, twist_length=twist_length, twist_width=twist_width, thickness=thickness, innercut=innercut, block_width=block_width);

            translate([0, 0, block_height(1, block_height=block_height)]) {
                technic_board_mount(length=length-block_width, width=width, length_tightness=length_tightness, width_tightness=width_tightness, twist_length=twist_length, twist_width=twist_width, thickness=0, innercut=0);
//                technic_rectangle(l1=l1, l2=l2, l3=l3, w1=w1, w2=w2, w3=w3);
            }

            retaining_ridge_sd_card_side();
        }
        
#        union() {
            main_board(l=l+2_fit, w=w, length=length, width=width, block_height=block_height);
            sd_card_cutout();
            front_connector_cutout();
            ethernet_cutout();
            daughterboard_cutout();
        }
    }

    bottom(x=x, y=y, l=l-x-0.5-l_fit, w=w-y-1.5, bottom_corner_bolt_holes=bottom_corner_bolt_holes, block_height=block_height);
}


module bottom(x, y, l, w, bottom_corner_bolt_holes=bottom_corner_bolt_holes, block_height=block_height) {

    translate([block_width(x) - skin, block_width(y), 0]) {
        skinned_block(l=l, w=w, h=0.25, skin=0, ridge_width=0, ridge_depth=0, block_height=block_height);
    }
}


module retaining_ridge_sd_card_side() {

    translate([block_width(0.5), block_width(0.5), block_height(0.5, block_height=block_height)]) {
        cube([block_width(0.5), block_width(2), block_height(2.5, block_height=block_height)]);
    }

    translate([block_width(0.5), block_width(6.5), block_height(0.5, block_height=block_height)]) {
        cube([block_width(0.5), block_width(2), block_height(2.5, block_height=block_height)]);
    }
}


module sd_card_cutout() {

    translate([block_width(-1.6), block_width(1.5), 0]) {
        cube([block_width(3), block_width(6), block_height(3, block_height=block_height)]);
    }
    
    translate([block_width(0.5), block_width(1.5), 0]) {
        cube([block_width(3), block_width(6), block_height(3, block_height=block_height)]);
    }
}


module ethernet_cutout() {

    translate([block_width(10), block_width(0.5), block_height(1, block_height=block_height)]) {
        cube([block_width(3), block_width(8), block_height(3, block_height=block_height)]);
    }
}


module front_connector_cutout() {

    translate([block_width(1.5), block_width(-0.6), block_height(0.5, block_height=block_height)]) {
        cube([block_width(8), block_width(2), block_height(3, block_height=block_height)]);
    }
}


module daughterboard_cutout() {

    translate([block_width(-0.5), block_width(-0.5), block_height(2, block_height=block_height)]) {
        cube([block_width(10), block_width(10), block_height(3, block_height=block_height)]);
    }
}
