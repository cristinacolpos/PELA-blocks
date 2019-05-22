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

include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../technic-beam/PELA-technic-beam.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]
// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

/* [Technic Corner] */

// Length of the first beam [blocks]
_l1 = 3; // [1:1:30]

// Length of the second beam [blocks]
_l2 = 3; // [1:1:30]

// Length of the beams [blocks]
_h = 1; // [1:1:30]

// Angle between the two beams
_angle = 90; // [65:1:295]

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_horizontal_skin = 0.1; // [0:0.02:0.5]

// Vertical clearance space between two parts to be placed next to one another on a 8mm grid [mm]
_vertical_skin = 0.1; // [0:0.02:0.5]


/* [Hidden] */

// Width of the beams [blocks]
_w = 1; // [1:1:30]



///////////////////////////////
// DISPLAY
///////////////////////////////

technic_corner(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l1=_l1, l2=_l2, w=_w, h=_h, angle=_angle, horizontal_skin=_horizontal_skin, vertical_skin=_vertical_skin);




///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_corner(material, large_nozzle, cut_line, l1, l2, w, h, angle, horizontal_skin, vertical_skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l1!=undef);
    assert(l2!=undef);
    assert(w!=undef);
    assert(angle >= 65, "Angle must be at least 65 degrees");
    assert(angle <= 295, "Angle must be at least 65 degrees");
    assert(h!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    difference() {
        union() {
            technic_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=l1, w=w, h=h, side_holes=2, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);

            rotate([0, 0, angle]) {
                technic_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=l2, w=w, h=h, side_holes=2, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
            }
        }

        translate([block_width(-0.5) + cos(angle)*block_width(l1), block_width(-0.5), 0]) {
            cut_space(material=material, large_nozzle=large_nozzle, w=l1+l2, l=l1+l2+2, cut_line=cut_line, h=h, block_height=_block_height, knob_height=0);
        }
    }
}