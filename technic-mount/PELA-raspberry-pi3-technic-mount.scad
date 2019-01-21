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

include <../parameters.scad>
include <../print-parameters.scad>
use <../block.scad>
use <../technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../socket-panel/PELA-socket-panel.scad>
use <../knob-mount/PELA-knob-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
include <PELA-technic-board-mount.scad>

/* [Technic Pin Array Options] */

length = 86.2;
width = 56.8;
twist = 2; // How many blocks in from rectangle ends do the technic holes rotate 90 degrees
thickness = 1.9;
innercut = 0.5; // How far in from the outside edges the board support can extend without hitting board bottom surface parts
bottom_bolt_holes = true; // Mounting holes inset from the corners

///////////////
// Display
///////////////
pi3_technic_mount();


module pi3_technic_mount() {

    l_fit = 1;
    l = fit_mm_to_pela_blocks(length, length_tightness) - l_fit;
    w = fit_mm_to_pela_blocks(width, width_tightness);
    x=1;
    y=0.5;
    l1 = l - 2*twist;    
    l3 = l1;
    l2 = l - l1 - l3;
    w1 = w - 2*twist;
    w3 = w1;
    w2 = w - w1 - w2;

    difference() {
        union() {
            technic_board_mount(length=length, width=width, thickness=thickness, innercut=innercut);

            translate([0, 0, block_height(1, block_height=block_height)]) {
                technic-rectangle(l1=l1, l2=l2, l3=l3, w1=w1, w2=w2, w3=w3);
            }

            translate([0, 0, block_height(2, block_height=block_height)]) {
                technic-rectangle(l1=l1, l2=l2, l3=l3, w1=w1, w2=w2, w3=w3);
            }

            retaining_ridge_sd_card_side();
        }
        
#        union() {
            main_board(l=l+l_fit, w=w, length=length, width=width, block_height=block_height);
            sd_card_cutout();
            front_connector_cutout();
            ethernet_cutout();
            daughterboard_cutout();
        }
    }

    bottom(x=x, y=y, l=l-x-0.5-l_fit, w=w-y-1.5, bottom_bolt_holes=bottom_bolt_holes, block_height=block_height);
}


module bottom(x, y, l, w, bottom_bolt_holes=bottom_bolt_holes, block_height=block_height) {

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
