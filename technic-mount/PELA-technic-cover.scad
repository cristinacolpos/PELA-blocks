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
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../knob-mount/PELA-knob-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-twist-bar.scad>
use <../PELA-socket-panel.scad>
use <PELA-raspberry-pi3-technic-mount.scad>
include <PELA-technic-board-mount.scad>


/* [Technic Cover] */

// Printing material
material = pla; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

length = 35; // Board space length [mm]

width = 35; // Board space width [mm]

length_padding = 1; // [0:tight, 1:+1 block, 2:+2 blocks] // Closeness of board fit lengthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)

width_padding = 1; // [0:tight, 1:+1 block, 2:+2 blocks] // Closeness of board fit widthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)

twist_length = 1; // Distance from length ends to rotate 90 degrees [blocks]

twist_width = 1; // Distance from width ends to rotate 90 degrees [blocks]



///////////////////////////////
// DISPLAY
///////////////////////////////

technic_cover();



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_cover(material=material, length=length, width=width, twist_length=twist_length, twist_width=twist_width, length_padding=length_padding, width_padding=width_padding) {

    assert(twist_length >= 0, "twist_length must be >= 0");
    assert(twist_width >= 0, "twist_length must be >= 0");
    assert(length_padding > 0, "length_padding must be > 0 (usually 1 to 1.5)");
    assert(width_padding > 0, "width_padding must be > 0 (usually 1 to 1.5)");
    assert(twist_length*2 <= l, "twist_length must <= l/2, please reduce twist_length or increate LENGTH");
    assert(twist_width*2 <= w, "twist_width must <= w/2, please reduce twist_width or increate WIDTH");

    l = fit_mm_to_blocks(length, length_padding);
    w = fit_mm_to_blocks(width, width_padding);

    l2 = max(0, l - 2*twist_length);
    w2 = max(0, w - 2*twist_width);

    union() {
        technic_rectangle(material=material, l1=twist_length, l2=l2, l3=twist_length, w1=twist_width, w2=w2, w3=twist_width);
        
        translate([block_width(0.5), block_width(0.5), 0]) {
            socket_panel(material=material, l=l-2, w=w-2, corner_bolt_holes=false, skin=0, block_height=block_height);
        }
    }        
}
