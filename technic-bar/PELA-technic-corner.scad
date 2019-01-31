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
use <../technic-bar/PELA-technic-bar.scad>


/* [Technic Corner] */

// Printing material
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Length of the first bar [blocks]
l1 = 2;

// Length of the second bar [blocks]
l2 = 2;

// Angle between the two bars
angle = 90;

///////////////////////////////
// DISPLAY
///////////////////////////////

pi3_corner();




///////////////////////////////////
// MODULES
///////////////////////////////////

module pi3_corner(material=material, l1=l1, l2=l2, angle=angle) {

    assert(angle >= 65, "Angle must be at least 65 degrees");
    assert(angle <= 295, "Angle must be at least 65 degrees");

    technic_bar(material=material, l=l1);

    rotate([0, 0, angle]) {
        technic_bar(material=material, l=l2);
    }
}