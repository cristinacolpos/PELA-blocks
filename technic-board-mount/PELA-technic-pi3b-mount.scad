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
use <../board-mount/PELA-board-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
include <PELA-technic-board-mount.scad>

/* [Technic Pin Array Options] */

length = 85.9;
width = 56.4;
thickness = 1.9;
innercut = 0.5; // How far in from the outside edges the board support can extend without hitting board bottom surface parts
base_thickness = block_height(); // The thickness of the base below an array of half-pins
bottom_bolt_holes = true; // Mounting holes inset from the corners

///////////////
// Display
///////////////
pi3b_technic_mount();


module pi3b_technic_mount() {

    l = fit_mm_to_pela_blocks(length, length_tightness);
    w = fit_mm_to_pela_blocks(width, width_tightness);
    x=0.5;
    y=0.5;

    difference() {
        union() {
            technic_board_mount(length=length, width=width, thickness=thickness, innercut=innercut, base_thickness=base_thickness);

            translate([0, 0, block_height(1, block_height=block_height)]) {
                flat_mount(l=l-1, w=w);
            }

            translate([0, 0, block_height(2, block_height=block_height)]) {
                flat_mount(l=l-1, w=w);
            }

            retaining_ridge_sd_card_side();
        }
        
#        union() {
            main_board(l=l, w=w, length=length, width=width, block_height=block_height);
            sd_card_cutout();
            front_connector_cutout();
            ethernet_cutout();
            daughterboard_cutout();
        }
    }

    bottom(x=x, y=y, l=l-x-2, w=w-y-2);
}


module bottom(x, y, l, w, bottom_bolt_holes=bottom_bolt_holes, block_height=block_height) {
    translate([block_width(x), block_width(y), 0]) {
    PELA_socket_panel(l=l, w=w, bolt_holes=bottom_bolt_holes, skin=0, block_height=block_height);
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
