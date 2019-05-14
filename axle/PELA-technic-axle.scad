/*
PELA Parametric LEGO-compatible Technic Axle

PELA Parametric Blocks - 3D Printed LEGO-compatible parametric blocks

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/
*/

include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>

/* [Technic Axle] */

// Show the inside structure [mm]
cut_line = 0; // [0:0.5:5]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Axle length [blocks]
l = 3; // [1:1:20]

// An axle which fits loosely in a technic bearing hole [mm]
axle_radius = 2.2; // [0.2:0.1:3.9]

// Size of the hollow inside an axle [mm]
center_radius = 1.1; // [0.0:0.1:3.8]



///////////////////////////////
// DISPLAY
///////////////////////////////

axle(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, axle_radius=axle_radius, center_radius=center_radius);
  



/////////////////////////////////////
// MODULES
/////////////////////////////////////

module axle(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, axle_radius=axle_radius, center_radius=center_radius) {

    axle_length = block_width(l);

    difference() {
        cylinder(r=axle_radius, h=axle_length);

        union() {
            translate([0, 0, -_defeather]) {
                cylinder(r=center_radius, h=axle_length + 2*_defeather);
            }

            translate([-axle_radius, -axle_radius, 0]) {
                cut_space(material=material, large_nozzle=large_nozzle, l=2, cut_line=cut_line, h=l, block_height=block_height, knob_height=knob_height);
            }
        }
    }
}
