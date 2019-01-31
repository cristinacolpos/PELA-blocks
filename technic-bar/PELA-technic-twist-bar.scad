/*
PELA technic angle - 3D Printed LEGO-compatible 30 degree bend

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
use <PELA-technic-bar.scad>

/* [Technic Twist Bar] */

// Printing material
material = pla; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Left side length of upward facing connectors [blocks]
left = 2;

// Center length of sideways facing connectors [blocks]
center = 4;

// Right side length of upward facing connectors [blocks]
right = 2;



///////////////////////////////
// DISPLAY
///////////////////////////////

technic_twist_bar();



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_twist_bar(left=left, center=center, right=right) {
    assert(left > 0, "Left side of twist bar must be at least 1")
    assert(center >= 0, "Center of twist bar must be at least 0")
    assert(right > 0, "Right side of twist bar must be at least 1")

    if (center == 0) {
        technic_bar(l=left+right);
    } else {
        left_square_end_bar(l=left);

        translate([block_width(left), 0, 0]) {
            translate([0, block_width(0.5), block_width(0.5)]) {
                rotate([90, 0, 0]) {
                    square_end_bar(l=center);
                }
            }

            translate([block_width(center), 0, 0]) {
                right_square_end_bar(l=right);
            }
        }
    }
}


module square_end_bar(l=4) {
    intersection() {
        translate([-block_width(1), 0, 0]) {
            technic_bar(l=l+2);
        }

       bar_space(l=l);
    }
}


module right_square_end_bar(l=4) {
    intersection() {
        translate([-block_width(1), 0, 0]) {
            technic_bar(l=l+1);
        }

       bar_space(l=l);
    }
}


module left_square_end_bar(l=4) {
    translate([block_width(l-1), 0, block_height()]) {
        rotate([0, 180, 0]) {
            right_square_end_bar(l=l);
        }
    }
}


module bar_space(l=4) {
    translate([block_width(-0.5), block_width(-0.5), 0]) {
        skinned_block(l=l, w=1, h=1, skin=0, block_height=8);
    }
}
