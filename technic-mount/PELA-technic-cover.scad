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
use <../block.scad>
use <../technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../knob-mount/PELA-knob-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-twist-bar.scad>
use <../socket-panel/PELA-socket-panel.scad>
use <PELA-raspberry-pi3-technic-mount.scad>
include <PELA-technic-board-mount.scad>

/* [Technic Cover Options] */
length = 35;
width = 35;
twist = 2;
length_tightness = 1;
width_tightness = 1;

technic_cover();


module technic_cover(length=length, width=width, twist=twist, length_tightness=length_tightness, width_tightness=width_tightness) {

    assert(twist >= 0, "TWIST must be >= 0");

    l = fit_mm_to_pela_blocks(length, length_tightness);
    w = fit_mm_to_pela_blocks(width, width_tightness);

    assert(twist*2 <= l, "TWIST must <= l/2, please reduce TWIST or increate LENGTH");
    assert(twist*2 <= w, "TWIST must <= w/2, please reduce TWIST or increate WIDTH");

    l2 = max(0, l - 2*twist);
    w2 = max(0, w - 2*twist);
    
    echo("twist=", twist, "l=", l, " l1=", l1, " l2=", l2, " l3=", l3);

    echo( "w=", w, " w1=", w1, " w2=", w2, " w3=", w3);

    union() {
        technic_rectangle(l1=twist, l2=l2, l3=twist, w1=twist, w2=w2, w3=twist);
        
        translate([block_width(0.5), block_width(0.5), 0]) {
            socket_panel(l=l-2, w=w-2, bolt_holes=false, skin=0, block_height=block_height);
        }
    }        
}
