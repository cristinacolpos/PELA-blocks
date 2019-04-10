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

include <../material.scad>
include <../style.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>



/* [Technic Beam] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Model length [blocks]
l = 15; // [1:1:20]

// Model height [blocks]
h = 1; // [1:1:20]




///////////////////////////////
// DISPLAY
///////////////////////////////

technic_beam(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, h=h, side_holes=2);



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_beam(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, h=h, side_holes=2) {

    assert(l > 0, "Technic beam length must be greater than zero");
    assert(h > 0, "Technic beam height must be greater than zero");

    l2 = l + 1;

    translate([block_width(-1), block_width(-0.5), 0]) {

        difference() {
            intersection() {
                translate([0, block_width(1), 0]) {
                    rotate([90, 0, 0]) {
                        PELA_technic_block(material=material, large_nozzle=large_nozzle, l=l2, w=h, h=1, sockets=false, knobs=false, corner_bolt_holes=false, solid_first_layer=true, end_holes=0, side_holes=side_holes, skin=0, block_height=block_height);
                    }
                }

                hull() {
                    translate([block_width(1), block_width(0.5), 0]) {
                        cylinder(d=block_width(1), h=block_height(h, block_height));
                    }

                    translate([block_width(l), block_width(0.5), 0]) {
                        cylinder(d=block_width(1), h=block_height(h, block_height));
                    }
                }
            }

            cut_space(material=material, large_nozzle=large_nozzle, w=l+1, l=l+1, cut_line=cut_line, h=1, block_height=block_height, knob_height=knob_height);
        }
    }
}


// The 2D profile of the beam (for rotations and other uses)
module technic_beam_slice(material=material, large_nozzle=large_nozzle, l=l) {
    l2 = l + 1;

    hull() {
        translate([0, block_width(0.5), 0]) {
            cylinder(d=block_width(1), h=0.01);
        }

        translate([block_width(l-1), block_width(0.5), 0]) {
            cylinder(d=block_width(1), h=0.01);
        }
    }
}


// The 2D profile of the negative space of the beam (for rotations and other uses)
module technic_beam_slice_negative(material=material, large_nozzle=large_nozzle, l=l) {
    l2 = l + 1;

    union() {
        for (i = [0:block_width(1):block_width(l)]) {
            translate([i, block_width(0.5), -defeather]) {
                cylinder(r=counterbore_inset_radius, h=0.01 + defeather);
            }
        }
    }
}