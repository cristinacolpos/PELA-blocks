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

include <../print-parameters.scad>
include <../style.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>

/* [Technic Bar Options] */

// Length [blocks]
l = 15;

// Height [blocks]
h = 1;




///////////////////////////////
// DISPLAY
///////////////////////////////

technic_bar();



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_bar(l=l, h=h, side_holes=2, block_width=block_width) {
    assert(l > 0, "Technic bar length must be greater than zero");

    l2 = l + 1;

    translate([block_width(-1, block_width=block_width), block_width(-0.5, block_width=block_width), 0]) {
        intersection() {
            translate([0, block_width(1, block_width=block_width), 0]) {
                rotate([90, 0, 0]) {
                    PELA_technic_block(l=l2, w=h, h=1, sockets=false, knobs=false, panel=false, corner_bolt_holes=false, solid_first_layer=true, end_holes=0, side_holes=side_holes, skin=0, block_height=block_height);
                }
            }

            hull() {
                translate([block_width(1), block_width(0.5), 0]) {
                    cylinder(d=block_width(1, block_width=block_width), h=block_height(h, block_height=block_height));
                }

                translate([block_width(l), block_width(0.5), 0]) {
                    cylinder(d=block_width(1, block_width=block_width), h=block_height(h, block_height=block_height));
                }
            }
        }
    }
}


// The 2D profile of the bar (for rotations and other uses)
module technic_bar_slice(l=l, block_width=block_width) {
    l2 = l + 1;

    hull() {
        translate([0, block_width(0.5), 0]) {
            cylinder(d=block_width(1, block_width=block_width), h=0.01);
        }

        translate([block_width(l-1), block_width(0.5), 0]) {
            cylinder(d=block_width(1, block_width=block_width), h=0.01);
        }
    }
}


// The 2D profile of the negative space of the bar (for rotations and other uses)
module technic_bar_slice_negative(l=l, block_width=block_width) {
    l2 = l + 1;

    union() {
        for (i = [0:block_width(1, block_width=block_width):block_width(l, block_width=block_width)]) {
            translate([i, block_width(0.5, block_width=block_width), -defeather]) {
                cylinder(r=counterbore_inset_radius, h=0.01 + defeather);
            }
        }
    }
}
