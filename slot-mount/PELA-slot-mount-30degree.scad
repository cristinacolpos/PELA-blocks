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

/* [Technic Pin Array Options] */

length = 39;
width = 39;
thickness = 1.7;
undercut = 2.3; // How far below the bottom of the board surface parts protude (not indlucing big things like an SD card holder)
innercut = 0.8; // How far in from the outside edges the board support can extend without hitting board bottom surface parts
base_thickness = block_height(); // The thickness of the base below an array of half-pins
slot_depth = 2;
end_lock_d = 1.2;
array_spacing = block_width();
length_tightness = 1;
width_tightness = 1;
angle = 30;

///////////////
// Display
///////////////
slot_mount_30degree(length=length, width=width, thickness=thickness, array_spacing=array_spacing);


module slot_mount_30degree(length=length, width=width, slot_depth=slot_depth, array_spacing=array_spacing, base_thickness=base_thickness, thickness=thickness, length_tightness=length_tightness, width_tightness=width_tightness, end_lock_d=end_lock_d) {
    l = fit_mm_to_pela_blocks(length, length_tightness);
    w = fit_mm_to_pela_blocks(width, width_tightness);
    echo("l", l);
    echo("w", w);

    bar_offset = base_thickness + 4;

    translate([0, block_width(3.5), bar_offset]) {
        rotate([angle, 0, 0]) {
            PELA_technic_block(l=6, w=1, h=1, sockets=false, knobs=false, panel=false, bolt_holes=false, solid_bottom_layer=true, end_holes=0);
        }

        hull() {
            rotate([angle, 0, 0]) {        
                cube([block_width(6), block_width(1), 0.01]);
            }

            translate([0, 0, -bar_offset + panel_height()]) {
                cube([block_width(6), block_width(1), 0.01]);
            }
        } 
    }

    end_locks(l=l, w=w, length=length, width=width, end_lock_d=end_lock_d, base_thickness=base_thickness);

    difference() {
        back(l=l, w=w, base_thickness=base_thickness);

        union() {
            board_access(l, w, length=length, width=width, slot_depth=slot_depth, base_thickness=base_thickness);
            slot(l=l, w=w, length=length, width=width, base_thickness=base_thickness, thickness=thickness);
        }
    }
}


// The base piece from which the board support slot is cut
module back(l, w, length=length, width=width, base_thickness=base_thickness) {
    translate([0, block_width(1), 0]) {
        cube([block_width(w), block_width(l), base_thickness]);
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