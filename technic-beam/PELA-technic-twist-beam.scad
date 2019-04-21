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

include <../material.scad>
include <../style.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <PELA-technic-beam.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

/* [Technic Twist Beam] */

// Left side length of upward facing connectors [blocks]
_left = 2; // [1:20]

// Center length of sideways facing connectors [blocks]
_center = 4; // [0:20]

// Right side length of upward facing connectors [blocks]
_right = 2; // [1:20]

// Model height [blocks]
_h = 1; // [1:1:30]

// Add full width through holes spaced along the length for techic connectors
_side_holes = 2; // [0:disabled, 1:short air vents, 2:full width connectors, 3:short connectors]


// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_skin = 0.1; // [0:0.02:0.5]


/* [Hidden] */

// Basic unit vertical size of each block
_block_height = 8; // [8:technic, 9.6:traditional blocks]


///////////////////////////////
// DISPLAY
///////////////////////////////

technic_twist_beam(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, left=_left, center=_center, right=_right, h=_h, side_holes=_side_holes, skin=_skin);



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_twist_beam(material=undef, large_nozzle=undef, cut_line=undef, left=undef, center=undef, right=undef, h=undef, side_holes=undef, skin=undef) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(left > 0, "Left side of twist beam must be at least 1");
    assert(center >= 0, "Center of twist beam must be at least 0");
    assert(right > 0, "Right side of twist beam must be at least 1");

    w=1;

    if (center == 0) {
        technic_beam(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=left+right, side_holes=side_holes, h=h, skin=skin);
    } else {
        difference() {
            union() {
                left_square_end_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=left, w=w, h=h, side_holes=side_holes, skin=skin);

                translate([block_width(left), 0, 0]) {
                    translate([0, block_width(0.5), block_width(0.5)]) {
                        rotate([90, 0, 0]) {
                            square_end_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=center, w=w, h=h, side_holes=side_holes, skin=skin);
                        }
                    }

                    translate([block_width(center), 0, 0]) {
                        right_square_end_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=right, w=w, h=h, side_holes=side_holes, skin=skin);
                    }
                }
            }

            translate([block_width(-0.5), block_width(-0.5), 0]) {
                cut_space(material=material, large_nozzle=large_nozzle, w=left+center+right, l=left+center+right, cut_line=cut_line, h=1, block_height=_block_height, knob_height=0);
            }
        }
    }
}


module square_end_beam(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, h=undef, side_holes=undef, skin=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(side_holes!=undef);
    assert(skin!=undef);

    intersection() {
        translate([-block_width(1), 0, 0]) {
            technic_beam(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l+2, h=h, side_holes=side_holes, skin=skin);
        }

       beam_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, skin=skin);
    }
}


module right_square_end_beam(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, h=undef, side_holes=undef, skin=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(side_holes!=undef);
    assert(skin!=undef);

    intersection() {
        translate([-block_width(1), 0, 0]) {
            technic_beam(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l+1, h=h, side_holes=side_holes, skin=skin);
        }

       beam_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, skin=skin);
    }
}


module left_square_end_beam(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, h=undef, side_holes=undef, skin=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(skin!=undef);

    translate([block_width(l-1), 0, block_height(1, block_height=_block_height)]) {
        rotate([0, 180, 0]) {
            right_square_end_beam(material=material, large_nozzle=large_nozzle,cut_line=cut_line, l=l, w=w, h=h, side_holes=side_holes, skin=skin);
        }
    }
}


module beam_space(material=material, large_nozzle=large_nozzle, l=undef, w=undef, h=undef, skin=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(h!=undef);
    assert(skin!=undef);

    translate([block_width(-0.5), block_width(-0.5)+skin, skin]) {
        cube([block_width(l), block_width(w)-2*skin, block_width(h)-2*skin]);
    }
}
