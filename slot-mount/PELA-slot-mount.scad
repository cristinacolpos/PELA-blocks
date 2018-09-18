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
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../board-mount/PELA-board-mount.scad>

/* [Technic Pin Array Options] */

length = 38;
width = 38;
thickness = 1.6;
l = fit_mm_to_pela_blocks(38);
w = fit_mm_to_pela_blocks(38);
undercut = 2.3; // How far below the bottom of the board surface parts protude (not indlucing big things like an SD card holder)
innercut = 0.8; // How far in from the outside edges the board support can extend without hitting board bottom surface parts

array_count = w; // The number of half-pins in an array supported by as base

base_thickness = panel_height(2); // The thickness of the base below an array of half-pins

slot_depth = 2;

end_lock_d = 1.2;

///////////////
// Display
///////////////
slot_mount();


module slot_mount() {
    pin_array(array_count=array_count, base_thickness=base_thickness);
    end_locks();

    difference() {
        back();

        union() {
            board_access();
            slot();
        }
    }
}


// The base piece from which the board support slot is cut
module back() {
    translate([0, block_width(1), 0]) {
        cube([block_width(w), block_width(l), base_thickness]);
    }
}


// Edge support for the board
module slot() {
    x_inset = (block_width(w)-width)/2;
    y_inset = (block_width(l)-width)/2;
    z_inset = (base_thickness-thickness)/2;

    translate([x_inset, block_width(1)+y_inset, z_inset]) {
        cube([width, length*2, thickness]);
    }
}


// Space in front of and behind the board
module board_access() {
    x_inset = (block_width(w)-width)/2 + slot_depth;
    y_inset = (block_width(l)-width)/2 + slot_depth;

    translate([x_inset, block_width(1)+y_inset, -0.1]) {
        cube([width - 2*slot_depth, 2*length, base_thickness + 0.2]);
    }
}


// A tab to keep the board from sliding out of the slot
module end_lock(x=-1, y=-1) {
    translate([x, y, 0]) {
       cylinder(d=end_lock_d, h=base_thickness);
    }
}


module end_locks() {
    x_inset = (block_width(w)-width)/2;
    y_inset = (block_width(l)-width)/2;

    end_lock(x=x_inset, y=block_width(1) + y_inset + length + end_lock_d/2);
    end_lock(x=x_inset + width, y=block_width(1) + y_inset + length + end_lock_d/2);
}