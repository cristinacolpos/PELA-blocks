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
use <PELA-technic-raspberry-pi3-mount.scad>
include <PELA-technic-mount.scad>

/* [Technic Pin Array Options] */

length = 85.9;
width = 56.4;
thickness = 1.9;
innercut = 0.5; // How far in from the outside edges the board support can extend without hitting board bottom surface parts
base_thickness = block_height(); // The thickness of the base below an array of half-pins

///////////////
// Display
///////////////

pi3_technic_top();

module pi3_technic_top() {

    l = fit_mm_to_pela_blocks(length, length_tightness) - 1;
    w = fit_mm_to_pela_blocks(width, width_tightness);

    union() {
        flat_mount(l=l, w=w);
        
        translate([block_width(10), 0, 0]) {
            rotate([0, 0, 90]) {
                technic_bar(l=10);
            }
        }
        
        translate([block_width(0.5), block_width(0.5), 0]) {
            PELA_socket_panel(l=9, w=8, bolt_holes=false, skin=0, block_height=block_height);
        }
    }
}
