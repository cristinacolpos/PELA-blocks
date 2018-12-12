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

include <../PELA-parameters.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>

/* [Technic Pin Options] */

// Axle length
axle_length = block_width(3);

// An axle which fits loosely in a technic bearing hole
axle_radius = 2.2;

// Size of the hollow inside an axle
axle_center_radius=axle_radius/2;

///////////////

axle();

    
//////////////////


// A round rotation axle
module axle(axle_radius=axle_radius, axle_center_radius=axle_center_radius, axle_length=axle_length) {

    difference() {
        cylinder(r=axle_radius, h=axle_length);
        translate([0, 0, -defeather])
            cylinder(r=axle_center_radius, h=axle_length+2*defeather);
    }
}
