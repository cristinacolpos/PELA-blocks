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

include <../parameters.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../knob-mount/PELA-knob-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-twist-bar.scad>
use <../socket-panel/PELA-socket-panel.scad>
use <PELA-raspberry-pi3-technic-mount.scad>
include <PELA-technic-board-mount.scad>


/* [Technic Cover Options] */

length = 35; // board space length [mm]

width = 35; // board space width [mm]

length_tightness = 1.0; // closeness of board fit lengthwise inside a ring of blocks [blocks/blocks] (increase to make outer box slightly larger)

width_tightness = 1.0; // closeness of board fit widthwise inside a ring of blocks [blocks/blocks] (increase to make outer box slightly larger)

twist_length = 1; // Distance from length ends to rotate 90 degrees [blocks]

twist_width = 1; // Distance from width ends to rotate 90 degrees [blocks]



///////////////////////////////
// DISPLAY
///////////////////////////////

technic_cover();



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_cover(length=length, width=width, twist_length=twist_length, twist_width=twist_width, length_tightness=length_tightness, width_tightness=width_tightness) {

    assert(twist_length >= 0, "TWIST_LENGTH must be >= 0");
    assert(twist_width >= 0, "TWIST_LENGTH must be >= 0");
    assert(length_tightness > 0, "LENGTH_TIGHTNESS must be > 0 (usually 1 to 1.5)");
    assert(width_tightness > 0, "WIDTH_TIGHTNESS must be > 0 (usually 1 to 1.5)");
    assert(twist_length*2 <= l, "TWIST_LENGTH must <= l/2, please reduce TWIST_LENGTH or increate LENGTH");
    assert(twist_width*2 <= w, "TWIST_WIDTH must <= w/2, please reduce TWIST_WIDTH or increate WIDTH");

    l = fit_mm_to_pela_blocks(length, length_tightness);
    w = fit_mm_to_pela_blocks(width, width_tightness);

    l2 = max(0, l - 2*twist_length);
    w2 = max(0, w - 2*twist_width);

    union() {
        technic_rectangle(l1=twist_length, l2=l2, l3=twist_length, w1=twist_width, w2=w2, w3=twist_width);
        
        translate([block_width(0.5), block_width(0.5), 0]) {
            socket_panel(l=l-2, w=w-2, corner_bolt_holes=false, skin=0, block_height=block_height);
        }
    }        
}
