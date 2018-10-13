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
use <../box-enclosure/PELA-box-enclosure.scad>
use <../board-mount/PELA-board-mount.scad>
use <../technics-bar/PELA-technics-bar.scad>

/* [Technic Pin Array Options] */

length = 39.5;
width = 39.5;
thickness = 1.8;
undercut = 2.3; // How far below the bottom of the board surface parts protude (not indlucing big things like an SD card holder)
innercut = 2; // How far in from the outside edges the board support can extend without hitting board bottom surface parts
base_thickness = block_height(); // The thickness of the base below an array of half-pins
slot_depth = 2;
end_lock_d = 1.2;
array_spacing = block_width();
length_tightness = 2;
width_tightness = 2;
angle = 45;

///////////////
// Display
///////////////
camera_holder();


module camera_holder() {
    
    difference() {
        camera_mount();
        union() {
            camera_board();
            camera_back();
        }
    }
}


module camera_mount() {

    l = fit_mm_to_pela_blocks(length, length_tightness);
    w = fit_mm_to_pela_blocks(width, width_tightness);

    technic_bar(l=l);

    rotate([0, 0, 90]) {
        technic_bar(l=w);
    }

    translate([0, block_width(w-1), 0]) {
        technic_bar(l=l);
    }

    rotate([0, 0, 90]) {
        translate([0, -block_width(w-1), 0]) {
            technic_bar(l=l);
        }
    }

    translate([block_width(0.5)-skin, block_width(0.5)-skin, 0]) {
        color("red") cube([block_width(l-2)+2*skin, block_width(w-2)+2*skin, block_height()]);
    }
}


module camera_board(l=l, w=w) {
    l2 = ((block_width(l) - length) / 2);
    w2 = ((block_width(w) - width) / 2);

    translate([block_width() + l2, block_width() + w2, block_height() - 1.8]) {
        cube([length, width, 1.8]);
    }
}

module camera_back(l=l, w=w) {
    l2 = ((block_width(l) - length - 2) / 2);
    w2 = ((block_width(w) - width - 2) / 2);

#    translate([block_width(0.5) + 4, block_width(0.5) + 4, 0]) {
        cube([length - 8, width - 8, block_height()]);
    }
}


// Edge support for the board
module slot(l, w, length=length, width=width, base_thickness=base_thickness, thickness=thickness) {
    x_inset = (block_width(w)-width)/2;
    y_inset = (block_width(l)-width)/2;
    z_inset = (base_thickness-thickness)/2;

    translate([x_inset, block_width(1)+y_inset, z_inset]) {
        cube([width, length*2, thickness]);
    }
}


// Space in front of and behind the board
module board_access(l, w, length=length, width=width, slot_depth=slot_depth, base_thickness=base_thickness) {
    x_inset = (block_width(w)-width)/2 + slot_depth;
    y_inset = (block_width(l)-width)/2 + slot_depth;

    translate([x_inset, block_width(1)+y_inset, -0.1]) {
        cube([width - 2*slot_depth, 2*length, base_thickness + 0.2]);
    }
}


// A tab to keep the board from sliding out of the slot
module end_lock(x, y, end_lock_d=end_lock_d, base_thickness=base_thickness) {
    translate([x, y, 0]) {
       cylinder(d=end_lock_d, h=base_thickness);
    }
}


module end_locks(l, w, length=length, width=width, end_lock_d=end_lock_d, base_thickness=base_thickness) {
    x_inset = (block_width(w)-width)/2;
    y_inset = (block_width(l)-width)/2;

    end_lock(x=x_inset, y=block_width(1) + y_inset + length + end_lock_d/2, end_lock_d=end_lock_d, base_thickness=base_thickness);

    end_lock(x=x_inset + width, y=block_width(1) + y_inset + length + end_lock_d/2, end_lock_d=end_lock_d, base_thickness=base_thickness);
}