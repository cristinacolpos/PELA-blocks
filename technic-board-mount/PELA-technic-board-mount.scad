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

include <../PELA-parameters.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../board-mount/PELA-board-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>

/* [Technic Pin Array Options] */

length = 39.5;
width = 39.5;
thickness = 1.8;
innercut = 05; // How far in from the outside edges the board support can extend without hitting board bottom surface parts
base_thickness = block_height(); // The thickness of the base below an array of half-pins
slot_depth = 2;
end_lock_d = 1.2;
array_spacing = block_width();
length_tightness = 2;
width_tightness = 2;



///////////////
// Display
///////////////
module technic_board_mount(length=length, width=width, thickness=thickness, innercut=innercut, base_thickness=base_thickness) {

    l = fit_mm_to_pela_blocks(length, length_tightness);
    w = fit_mm_to_pela_blocks(width, width_tightness);
    
    difference() {
        union() {
            flat_mount(l=l, w=w);
            flat_mount_infill(l=l, w=w);
        }
        
        union() {
            main_board(l=l, w=w, length=length, width=width, block_height=block_height);
            main_board_back(l=l, w=w, length=length, width=width, innercut=innercut, block_height=block_height);
        }
    }
}


module flat_mount(l=l, w=w) {

    technic_bar(l=l);

    rotate([0, 0, 90]) {
        technic_bar(l=w);
    }

    translate([0, block_width(w-1), 0]) {
        technic_bar(l=l);
    }

    rotate([0, 0, 90]) {
        translate([0, -block_width(l-1), 0]) {
            technic_bar(l=w);
        }
    }
}


module flat_mount_infill(l=l, w=w) {
    translate([block_width(0.5)-skin, block_width(0.5)-skin, 0]) {
        cube([block_width(l-2)+2*skin, block_width(w-2)+2*skin, block_height()]);
    }
}


module main_board(l=l, w=w, length=length, width=width, block_height=block_height) {
    l2 = ((block_width(l) - length) / 2);
    w2 = ((block_width(w) - width) / 2);

    translate([l2-block_width(0.5), w2-block_width(0.5), block_height(1, block_height=block_height) - 1.8]) {
        color("blue") cube([length, width, 1.8]);
    }
}


module main_board_back(l=l, w=w, length=length, width=width, innercut=innercut, block_height=block_height) {
    l2 = ((block_width(l) - length) / 2);
    w2 = ((block_width(w) - width) / 2);

    translate([l2 - block_width(0.25) + innercut, w2 - block_width(0.25) + innercut, 0]) {
        color("green") cube([length-2*innercut-block_width(0.25), width-2*innercut-block_width(0.25), block_height(1, block_height=block_height)]);
    }
}
