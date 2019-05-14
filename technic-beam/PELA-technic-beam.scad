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



/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:16]

// Printing material (set to select calibrated knob, socket and axle hole fit)
<<<<<<< HEAD
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]
=======
material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]
>>>>>>> master

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Technic Beam] */

// Beam length [blocks]
_l = 15; // [1:1:30]

// Beam width [blocks]
_w = 1; // [1:1:30]

// Beam height [blocks]
_h = 1; // [1:1:30]

// Add full width through holes spaced along the length for techic connectors
_side_holes = 2; // [0:disabled, 1:short air vents, 2:full width connectors, 3:short connectors]

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_skin = 0.1; // [0:0.02:0.5]


/* [Hidden] */

_block_height = 8;


///////////////////////////////
// DISPLAY
///////////////////////////////

technic_beam(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, h=_h, side_holes=_side_holes, skin=_skin);



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_beam(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, h=undef, side_holes=undef, skin=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(skin!=undef);
    assert(l > 0, "Technic beam length must be greater than zero");
    assert(w > 0, "Technic beam width must be greater than zero");
    assert(h > 0, "Technic beam height must be greater than zero");
    assert(side_holes>=0 && side_holes<=4);

    l2 = l + 1;

    translate([block_width(-1), block_width(-0.5), 0]) {

        difference() {
            intersection() {
                for (i=[0:1:w]) {
                    translate([0, block_width(i), 0]) {
                        rotate([90, 0, 0]) {
                            PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l2, w=h, h=1, sockets=false, knobs=false, top_vents=false, corner_bolt_holes=false, solid_first_layer=true, end_holes=0, side_holes=side_holes, side_sheaths=true, skin=skin, block_height=_block_height);
                        }
                    }
                }

                hull() {
                    for (i=[0:1:w-1]) {
                        translate([block_width(1), block_width(0.5+i), skin]) {
                            cylinder(d=block_width(1)-2*skin, h=block_height(h, _block_height)-2*skin);
                        }

                        translate([block_width(l), block_width(0.5+i), skin]) {
                            cylinder(d=block_width(1)-2*skin, h=block_height(h, _block_height)-2*skin);
                        }
                    }
                }
            }

            cut_space(material=material, large_nozzle=large_nozzle, w=l+1, l=l+1, cut_line=cut_line, h=1, block_height=_block_height, knob_height=0);
        }
    }
}


// The 2D profile of the beam (for rotations and other uses)
module technic_beam_slice(material=undef, large_nozzle=undef, l=undef, skin=undef) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(skin!=undef);
    
    l2 = l + 1;

    hull() {
        translate([0, block_width(0.5), 0]) {
            cylinder(d=block_width(1)-2*skin, h=0.01);
        }

        translate([block_width(l-1), block_width(0.5), 0]) {
            cylinder(d=block_width(1)-2*skin, h=0.01);
        }
    }
}


// The 2D profile of the negative space of the beam (for rotations and other uses)
module technic_beam_slice_negative(material=undef, large_nozzle=undef, l=undef, w=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    
    l2 = l + 1;

    union() {
        for (i = [0:block_width(w):block_width(l)]) {
            translate([i, block_width(0.5), -_defeather]) {
                cylinder(r=_counterbore_inset_radius, h=0.01 + _defeather);
            }
        }
    }
}
