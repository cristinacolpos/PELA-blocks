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
use <../socket-panel/PELA-socket-panel.scad>
use <PELA-raspberry-pi3-technic-mount.scad>
include <PELA-technic-board-mount.scad>

/* [Technic Pin Array Options] */

length = 85.9;
width = 56.4;


module technic_top_panel(length=length, width=width) {

    l = fit_mm_to_pela_blocks(length, length_tightness) - 1;
    w = fit_mm_to_pela_blocks(width, width_tightness);
    l1 = l - 2*twist;    
    l3 = l1;
    l2 = l - l1 - l3;
    w1 = w - 2*twist;
    w3 = w1;
    w2 = w - w1 - w2;

    union() {
        technic-rectangle(l1=l1, l2=l2, l3=l3, w1=w1, w2=w2, w3=w3);
        
        translate([block_width(0.5), block_width(0.5), 0]) {
            socket_panel(l=l-2, w=w-2, bolt_holes=false, skin=0, block_height=block_height);
        }
    }
}
