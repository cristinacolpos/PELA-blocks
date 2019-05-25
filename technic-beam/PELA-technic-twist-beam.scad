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
_material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]
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
_horizontal_skin = 0.1; // [0:0.02:0.5]

// Vertical clearance space between two parts to be placed next to one another on a 8mm grid [mm]
_vertical_skin = 0.1; // [0:0.02:0.5]


/* [Hidden] */

// Basic unit vertical size of each block
_block_height = 8; // [8:technic, 9.6:traditional knobs]


///////////////////////////////
// DISPLAY
///////////////////////////////

technic_twist_beam(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, left=_left, center=_center, right=_right, h=_h, side_holes=_side_holes, horizontal_skin=_horizontal_skin, vertical_skin=_vertical_skin);



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_twist_beam(material, large_nozzle, cut_line=_cut_line, left, center, right, h, side_holes, horizontal_skin, vertical_skin) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(left > 0, "Left side of twist beam must be at least 1");
    assert(center >= 0, "Center of twist beam must be at least 0");
    assert(right > 0, "Right side of twist beam must be at least 1");
    assert(h!=undef);
    assert(side_holes!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    w=1;

    if (center == 0) {
        technic_beam(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=left+right, side_holes=side_holes, w=w, h=h, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
    } else {
        difference() {
            union() {
                translate([0, 0, block_height(h-1, _block_height)-2*vertical_skin]) {
                    left_square_end_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=left, w=w, h=h, side_holes=side_holes, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
                }

                translate([block_width(left), 0, 0]) {
//                    intersection() {
//                        translate([block_width(-0.5)+horizontal_skin, block_width(-0.5)+horizontal_skin, 0]) {
//                            cube([block_width(center), block_width(w)-2*horizontal_skin, block_height(h, _block_height)-2*vertical_skin]);
//                        }
                        
                        for (i=[0:1:h-1]) {
                            translate([0, block_width(0.5)-horizontal_skin, block_width(0.5+i)-vertical_skin]) {
                                rotate([90, 0, 0]) {
                                    square_end_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=center, w=w, h=1, side_holes=side_holes, horizontal_skin=vertical_skin, vertical_skin=horizontal_skin);
                                }
                            }
//                        }
                    }

                    translate([block_width(center), 0, 0]) {
                        right_square_end_beam(material=material, large_nozzle=large_nozzle, cut_line=0, l=right, w=w, h=h, side_holes=side_holes, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
                    }
                }
            }

            translate([block_width(-0.5), block_width(-0.5), 0]) {
                cut_space(material=material, large_nozzle=large_nozzle, w=left+center+right, l=left+center+right, cut_line=cut_line, h=1, block_height=_block_height, knob_height=0);
            }
        }
    }
}


module square_end_beam(material, large_nozzle, cut_line=_cut_line, l, w, h, side_holes, horizontal_skin, vertical_skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(side_holes!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    intersection() {
        translate([-block_width(1), 0, 0]) {
            technic_beam(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l+2, w=w, h=h, side_holes=side_holes, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
        }

       beam_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, horizontal_skin=0, vertical_skin=vertical_skin);
    }
}


module right_square_end_beam(material, large_nozzle, cut_line=_cut_line, l, w, h, side_holes, horizontal_skin, vertical_skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(side_holes!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    intersection() {
        translate([-block_width(1), 0, 0]) {
            technic_beam(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l+1, w=w, h=h, side_holes=side_holes, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
        }

       beam_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, horizontal_skin=0, vertical_skin=0);
    }
}


module left_square_end_beam(material, large_nozzle, cut_line=_cut_line, l, w, h, side_holes, horizontal_skin, vertical_skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    translate([block_width(l-1), 0, block_width()]) {
        rotate([0, 180, 0]) {
            right_square_end_beam(material=material, large_nozzle=large_nozzle,cut_line=cut_line, l=l, w=w, h=h, side_holes=side_holes, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin);
        }
    }
}


module beam_space(material, large_nozzle, l, w, h, horizontal_skin, vertical_skin) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(h!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);

    translate([block_width(-0.5)+horizontal_skin, block_width(-0.5)+horizontal_skin, 0]) {
        cube([block_width(l)-2*horizontal_skin, block_width(w)-2*horizontal_skin, block_width(h)-2*vertical_skin]);
    }
}
