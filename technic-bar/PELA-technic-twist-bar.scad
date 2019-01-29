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
include <../parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <PELA-technic-bar.scad>

/* [Technic Pin Array Options] */

left = 2;
center = 4;
right = 2;

///////////////
// Display
///////////////
technic_twist_bar();

module technic_twist_bar(left=left, center=center, right=right) {

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

#       bar_space(l=l);
    }
}


module right_square_end_bar(l=4) {
    intersection() {
        translate([-block_width(1), 0, 0]) {
            technic_bar(l=l+1);
        }

#       bar_space(l=l);
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
