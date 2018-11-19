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
use <../technic-bar/PELA-technic-bar.scad>
include <PELA-technic-board-mount.scad>

/* [Technic Pin Array Options] */

length = 85;
width = 56;
thickness = 1.7;
innercut = 0.5; // How far in from the outside edges the board support can extend without hitting board bottom surface parts
base_thickness = block_height(); // The thickness of the base below an array of half-pins

///////////////
// Display
///////////////
pi3b_technic_mount();


module pi3b_technic_mount() {
    difference() {
        union() {
        technic_board_mount(length=length, width=width, thickness=thickness, innercut=innercut, base_thickness=base_thickness);
        }
        
        union() {
            sd_card_cutout();
            front_connector_cutout();
        }
    }
}



module sd_card_cutout() {

    translate([block_width(-0.6), block_width(2.5), block_height(0.5, block_height=block_height)]) {
        cube([block_width(2), block_width(3), block_height(1, block_height=block_height)]);
    }
}

module front_connector_cutout() {

    translate([block_width(1.5), block_width(-0.6), block_height(0.5, block_height=block_height)]) {
        cube([block_width(8), block_width(2), block_height(1, block_height=block_height)]);
    }
}
