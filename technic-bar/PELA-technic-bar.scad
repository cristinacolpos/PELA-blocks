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

include <../PELA-print-parameters.scad>
include <../PELA-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>

/* [Technic Pin Array Options] */

l=6;


///////////////
// Display
///////////////
technic_bar();


module technic_bar(l=l) {
    l2 = l + 1;

    translate([block_width(-1), block_width(-0.5), 0]) {
        intersection() {
            translate([0, block_width(), 0]) {
                rotate([90, 0, 0]) {
                    PELA_technic_block(l=l2, w=1, h=1, sockets=false, knobs=false, panel=false, bolt_holes=false, solid_bottom_layer=true, end_holes=0, skin=0);
                }
            }

            hull() {
                translate([block_width(1), block_width(0.5), 0]) {
                    cylinder(d=block_width(1), h=block_height());
                }

                translate([block_width(l), block_width(0.5), 0]) {
                    cylinder(d=block_width(1), h=block_height());
                }
            }
        }
    }
}
