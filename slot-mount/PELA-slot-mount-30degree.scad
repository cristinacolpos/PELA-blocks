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
mount_30degree();


module mount_30degree(angle=angle, length=length, width=width, slot_depth=slot_depth, array_spacing=array_spacing, base_thickness=base_thickness, thickness=thickness, length_tightness=length_tightness, width_tightness=width_tightness, end_lock_d=end_lock_d) {

    translate([0, 0, block_height(1)]) {
        rotate([angle, 0, 0]) {
            PELA_technic_block(l=6, w=1, h=1, sockets=false, knobs=false, panel=false, bolt_holes=false, solid_bottom_layer=true, end_holes=0);
        }
    }

    rotate([90, 0, 0]) {
        PELA_technic_block(l=6, w=1, h=1, sockets=false, knobs=false, panel=false, bolt_holes=false, solid_bottom_layer=true, end_holes=0);
    }

    hull() {
        translate([0, 0, block_height(1)]) {
            rotate([angle+90, 0, 0]) {
                cube([block_width(6), block_width(1), 0.01]);
            }
        }

        translate([0, block_width(-1), block_height(1)]) {
            cube([block_width(6), block_width(1), 0.01]);
        }
    }
}
