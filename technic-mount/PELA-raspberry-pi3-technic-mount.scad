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
use <PELA-technic-box.scad>
use <PELA-technic-board-mount.scad>



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
thickness = 1.9; // [0:0.1:4]

// Step in from board space edges to support the board [mm]
innercut = 1;

// Step down from board bottom to give room board components [mm]
undercut = 3; // [0:0.1:100]



/* [Hidden] */

 // Mounting holes inset from the corners
bottom_corner_bolt_holes = true;




///////////////////////////////
// DISPLAY
///////////////////////////////

pi3_technic_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, l_pad=l_pad, w_pad=w_pad, twist_l=twist_l, twist_w=twist_w, thickness=thickness, innercut=innercut, undercut=undercut, center=center);



///////////////////////////////////
// MODULES
///////////////////////////////////

module pi3_technic_mount(material=undef, large_nozzle=undef, cut_line=undef, length=undef, width=undef, l_pad=undef, w_pad=undef, twist_l=undef, twist_w=undef, thickness=undef, innercut=undef, undercut=undef, center=undef) {

    l = fit_mm_to_blocks(length, l_pad, block_width=block_width);
    w = fit_mm_to_blocks(width, w_pad, block_width=block_width);

    difference() {
        union() {
            technic_board_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, l_pad=l_pad, w_pad=w_pad, h=1, twist_l=twist_l, twist_w=twist_w, thickness=thickness, innercut=innercut, undercut=undercut, center=center);

            translate([0, 0, block_height(1, block_height=block_height)]) {

                tl = min(twist_l, ceil(l/2));
                l1 = tl;
                l3 = l1;
                l2 = max(0, l - l1 - l3);
                tw = min(twist_w, ceil(w/2));
                w1 = tw;
                w3 = w1;
                w2 = max(0, w - w1 - w3);

                technic_rectangle(material=material, large_nozzle=large_nozzle, l1=l1, l2=l2-1, l3=l3, w1=w1, w2=w2, w3=w3);
            }

            retaining_ridge_sd_card_side(material=material);
        }
        
        union() {
            sd_card_cutout(material=material, large_nozzle=large_nozzle);

            front_connector_cutout(material=material, large_nozzle=large_nozzle);

            ethernet_cutout(material=material, large_nozzle=large_nozzle);

            daughterboard_cutout(material=material, large_nozzle=large_nozzle);
        }
    }
}


module retaining_ridge_sd_card_side(material=material, large_nozzle=large_nozzle) {

    translate([block_width(0.5), block_width(0.5), block_height(1, block_height)]) {
        cube([block_width(0.5), block_width(2), block_height(1, block_height)]);
    }

    translate([block_width(0.5), block_width(6.5), block_height(0.5, block_height)]) {
        cube([block_width(0.5), block_width(2), block_height(1.5, block_height)]);
    }
}


module sd_card_cutout(material=material, large_nozzle=large_nozzle) {

    translate([block_width(-1.6), block_width(1.5, block_width), -defeather]) {
        cube([block_width(3), block_width(6), block_height(4, block_height)]);
    }
    
    translate([block_width(0.5, block_width), block_width(1.5, block_width), 0]) {
        cube([block_width(3, block_width), block_width(6, block_width), block_height(4, block_height)]);
    }
}


module ethernet_cutout(material=material, large_nozzle=large_nozzle) {

    translate([block_width(10), block_width(0.5), block_height(1, block_height)]) {
        cube([block_width(3), block_width(8), block_height(4, block_height)]);
    }
}


module front_connector_cutout(material=material, large_nozzle=large_nozzle) {

    translate([block_width(1.5), block_width(-0.6), block_height(0.5, block_height)]) {
        cube([block_width(8), block_width(2), block_height(4, block_height)]);
    }
}


module daughterboard_cutout(material=material, large_nozzle=large_nozzle) {

    translate([block_width(-0.5), block_width(-0.5), block_height(2, block_height)]) {
        cube([block_width(10), block_width(10), block_height(4, block_height)]);
    }
}
