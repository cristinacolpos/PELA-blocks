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
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-bar.scad>


/* [Technic Corner] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Length of the first bar [blocks]
l1 = 4; // [1:1:20]

// Length of the second bar [blocks]
l2 = 4; // [1:1:20]

// Length of the bars [blocks]
h = 1; // [1:1:20]

// Fill the block interior
solid_center = false;



/* [Technic Corner] */

// Angle between the front and sides
angle = 90;




///////////////////////////////
// DISPLAY
///////////////////////////////

technic_box(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l1=l1, l2=l2, angle=angle, h=h);




///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_box(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l1=l1, l2=l2, angle=angle, h=h) {

/*    technic_corner(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l1=l1, l2=l2, angle=angle, h=h);

    difference() {
        union() {
            translate([block_width(l1 - 1, block_width=block_width), block_width(l2 - 1, block_width=block_width), 0]) {
                rotate([0, 0, 180]) {
                    technic_corner(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l1=l1, l2=l2, angle=angle, h=h);
                }
            }
        }

        translate([block_width(-0.5, block_width=block_width) + cos(angle)*block_width(l1, block_width=block_width), block_width(-0.5, block_width=block_width), 0]) {
            cut_space(material=material, large_nozzle=large_nozzle, w=l1+l2, l=l1+l2+2, cut_line=cut_line, h=h, block_width=block_width, block_height=block_height, knob_height=knob_height);
        }
    }
*/

    technic_rectangle(material=material, large_nozzle=large_nozzle, l1=undef, l2=undef, l3=undef, w1=undef, w2=undef, w3=undef);
}


module technic_rectangle(material=material, large_nozzle=large_nozzle, l1, l2, l3, w1, w2, w3) {

    assert(twist_length >= 0, "twist_length must be >= 0");
    assert(twist_width >= 0, "twist_length must be >= 0");
    assert(length_padding >= 0, "length_padding must be >= 0");
    assert(length_padding <= 2, "length_padding must be <= 2");
    assert(width_padding >= 0, "width_padding must be >= 0");
    assert(width_padding <= 2, "width_padding must be <= 2");
    assert(twist_length*2 <= l, "twist_length must <= l/2, please reduce twist_length or increate LENGTH");
    assert(twist_width*2 <= w, "twist_width must <= w/2, please reduce twist_width or increate WIDTH");

    ll = l1+l2+l3;
    ww = w1+w2+w3;

color("red")    technic_twist_bar(material=material, large_nozzle=large_nozzle, left=l1, center=l2, right=l3);

    rotate([0, 0, 90]) {
color("yellow")        technic_twist_bar(material=material, large_nozzle=large_nozzle, left=w1, center=w2, right=w3);
    }

    translate([0, block_width(ww-1), 0]) {
color("silver")        technic_twist_bar(material=material, large_nozzle=large_nozzle, left=l1, center=l2, right=l3);
    }

    rotate([0, 0, 90]) {
        translate([0, -block_width(ll-1), 0]) {
color("orange")            technic_twist_bar(material=material, large_nozzle=large_nozzle, left=w1, center=w2, right=w3);
        }
    }
}

}
