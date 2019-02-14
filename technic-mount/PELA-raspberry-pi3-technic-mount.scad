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

include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../PELA-socket-panel.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-twist-bar.scad>
include <PELA-technic-board-mount.scad>



/* [Raspberry Pi3 Technic Mount] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Closeness of board fit lengthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)
l_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Closeness of board fit widthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)
w_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// How many blocks in from length ends do the technic holes rotate 90 degrees
twist_l = 2; // [1:18]

// How many blocks in from width ends do the technic holes rotate 90 degrees
twist_w = 2; // [1:18]

// Interior fill style
center = 2; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes]



/* [Board] */

// Board space length [mm]
length = 86.2; // Board space length [mm]

// Board space width [mm]
width = 56.8; // Board space width [mm]

// Board space height [mm]
thickness = 1.9; // Board space height [mm]

// Step in from board space edges to support the board [mm]
innercut = 0.8;



/* [Hidden] */

 // Mounting holes inset from the corners
bottom_corner_bolt_holes = true;




///////////////////////////////
// DISPLAY
///////////////////////////////

pi3_technic_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, l_pad=l_pad, w_pad=w_pad, twist_l=twist_l, twist_w=twist_w, thickness=thickness, innercut=innercut);



///////////////////////////////////
// MODULES
///////////////////////////////////

module pi3_technic_mount(material=undef, large_nozzle=undef, cut_line=undef, length=undef, width=undef, l_pad=undef, w_pad=undef, twist_l=undef, twist_w=undef, thickness=undef, innercut=undef) {

//    l_fit = 1;
    l = fit_mm_to_blocks(length, l_pad, block_width=block_width); // - l_fit;
    w = fit_mm_to_blocks(width, w_pad, block_width=block_width);
/*    x = 1;
    y = 0.5;
    l1 = l - 2*twist_l;    
    l3 = l1;
    l2 = l - l1 - l3;
    w1 = w - 2*twist_w;
    w3 = w1;
    w2 = w - w1 - w3; */

    difference() {
        union() {
            technic_board_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, l_pad=l_pad, w_pad=w_pad, h=h, twist_l=twist_l, twist_w=twist_w, thickness=thickness, innercut=innercut, center=center);

            translate([0, 0, block_height(1, block_height=block_height)]) {
                technic_board_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, l_pad=l_pad, w_pad=w_pad, h=h, twist_l=twist_l, twist_w=twist_w, thickness=0, innercut=0, center=0);
            }

            retaining_ridge_sd_card_side(material=material);
        }
        
        union() {
            main_board(material=material, large_nozzle=large_nozzle, l=l, w=w, length=length, width=width, thickness=thickness, block_height=block_height);

            sd_card_cutout(material=material, large_nozzle=large_nozzle);

            front_connector_cutout(material=material, large_nozzle=large_nozzle);

            ethernet_cutout(material=material, large_nozzle=large_nozzle);

            daughterboard_cutout(material=material, large_nozzle=large_nozzle);
        }
    }

    bottom(material=material, large_nozzle=large_nozzle, x=x, y=y, l=l-x-0.5-l_fit, w=w-y-1.5, bottom_corner_bolt_holes=bottom_corner_bolt_holes, block_height=block_height);
}


module bottom(material=material, large_nozzle=large_nozzle, x=undef, y=undef, l=undef, w=undef, bottom_corner_bolt_holes=bottom_corner_bolt_holes, block_height=block_height) {

    translate([block_width(x) - skin, block_width(y), 0]) {
        skinned_block(material=material, large_nozzle=large_nozzle, l=l, w=w, h=0.25, skin=0, ridge_width=0, ridge_depth=0, block_height=block_height);
    }
}


module retaining_ridge_sd_card_side(material=material, large_nozzle=large_nozzle) {

    translate([block_width(0.5), block_width(0.5), block_height(0.5, block_height=block_height)]) {
        cube([block_width(0.5), block_width(2), block_height(2.5, block_height=block_height)]);
    }

    translate([block_width(0.5), block_width(6.5), block_height(0.5, block_height=block_height)]) {
        cube([block_width(0.5), block_width(2), block_height(2.5, block_height=block_height)]);
    }
}


module sd_card_cutout(material=material, large_nozzle=large_nozzle) {

    translate([block_width(-1.6), block_width(1.5), 0]) {
        cube([block_width(3), block_width(6), block_height(4, block_height=block_height)]);
    }
    
    translate([block_width(0.5), block_width(1.5), 0]) {
        cube([block_width(3), block_width(6), block_height(4, block_height=block_height)]);
    }
}


module ethernet_cutout(material=material, large_nozzle=large_nozzle) {

    translate([block_width(10), block_width(0.5), block_height(1, block_height=block_height)]) {
        cube([block_width(3), block_width(8), block_height(4, block_height=block_height)]);
    }
}


module front_connector_cutout(material=material, large_nozzle=large_nozzle) {

    translate([block_width(1.5), block_width(-0.6), block_height(0.5, block_height=block_height)]) {
        cube([block_width(8), block_width(2), block_height(4, block_height=block_height)]);
    }
}


module daughterboard_cutout(material=material, large_nozzle=large_nozzle) {

    translate([block_width(-0.5), block_width(-0.5), block_height(2, block_height=block_height)]) {
        cube([block_width(10), block_width(10), block_height(4, block_height=block_height)]);
    }
}
