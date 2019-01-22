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
use <../knob-mount/PELA-knob-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-twist-bar.scad>

/* [Technic Pin Array Options] */

length = 39.5;
width = 39.5;
twist = 2; // How many blocks in from rectangle ends do the technic holes rotate 90 degrees
thickness = 1.8;
innercut = 05; // How far in from the outside edges the board support can extend without hitting board bottom surface parts
slot_depth = 2;
end_lock_d = 1.2;
array_spacing = block_width();
length_tightness = 2;
width_tightness = 2;


///////////////
// Display
///////////////
module technic_board_mount(length=length, width=width, thickness=thickness, innercut=innercut) {

    l = fit_mm_to_pela_blocks(length, length_tightness);
    w = fit_mm_to_pela_blocks(width, width_tightness);
    l1 = l - 2*twist;    
    l3 = l1;
    l2 = l - l1 - l3;
    w1 = w - 2*twist;
    w3 = w1;
    w2 = w - w1 - w2;

    difference() {
        union() {
            technic_rectangle(l1=l1, l2=l2, l3=l3, w1=w1, w2=w2, w3=w3);
            technic_rectangle_infill(l=l, w=w);
        }
        
        union() {
            main_board(l=l, w=w, length=length, width=width, thickness=thickness, block_height=block_height);
            main_board_back(l=l, w=w, length=length, width=width, innercut=innercut, block_height=block_height);
        }
    }
}


module technic_rectangle(l1=l1, l2=l2, l3=l3, w1=w1, w2=w2, w3=w3) {

    l = l1+l2+l3;
    w = w1+w2+w3;
    technic_twist_bar(left=l1, center=l2, right=l3);

    rotate([0, 0, 90]) {
        technic_twist_bar(left=w1, center=w2, right=w3);
    }

    translate([0, block_width(w-1), 0]) {
        technic_twist_bar(left=l3, center=l2, right=l1);
    }

    rotate([0, 0, 90]) {
        translate([0, -block_width(l-1), 0]) {
            technic_twist_bar(left=w3, center=w2, right=w1);
        }
    }
}


module technic_rectangle_infill(l=l, w=w) {
    translate([block_width(0.5)-skin, block_width(0.5)-skin, 0]) {
        cube([block_width(l-2)+2*skin, block_width(w-2)+2*skin, block_height()]);
    }
}


module main_board(l=l, w=w, length=length, width=width, thickness=thickness, block_height=block_height) {
    l2 = ((block_width(l) - length) / 2);
    w2 = ((block_width(w) - width) / 2);

    translate([l2-block_width(0.5), w2-block_width(0.5), block_height(1, block_height=block_height) - thickness]) {
        color("blue") cube([length, width, thickness]);
    }
}


module main_board_back(l=l, w=w, length=length, width=width, innercut=innercut, block_height=block_height) {
    l2 = ((block_width(l - 0.25) - length) / 2);
    w2 = ((block_width(w - 0.25) - width) / 2);

    translate([l2, w2, 0]) {
        color("green") cube([length-2*innercut-block_width(0.25), width-2*innercut-block_width(0.25), block_height(1, block_height=block_height)]);
    }
}
