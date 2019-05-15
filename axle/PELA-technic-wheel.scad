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
use <PELA-technic-cross-axle.scad>
use <PELA-technic-hub.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:0.5:5]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Technic Wheel] */

// The cylinder surrounding the axle hole [mm]
_wheel_diameter = 55; // [0.2:0.1:200]

// The cylinder surrounding the axle hole [mm]
_wheel_width = 48; // [0.2:0.1:200]

// The cylinder surrounding the axle hole [mm]
_wheel_thickness = 5; // [0.2:0.1:200]

// The cylinder surrounding the axle hole [mm]
_spoke_twist = 90; // [0:1:360]


/* [Technic Hub] */

// Axle length [blocks]
_l = 3; // [1:1:20]

// The cylinder surrounding the axle hole [mm]
_hub_radius = 4; // [0.2:0.1:3.9]

// Outside radius of an axle which fits loosely in a technic bearing hole [mm]
_axle_radius = 2.2; // [0.1:1:20]

// Size of the axle solid center before rounding [mm]
_center_radius = 0.73; // [0.1:0.01:4]

// Cross axle inside rounding radius [mm]
_axle_rounding = 0.63; // [0.2:0.01:4.0]



///////////////////////////////
// DISPLAY
///////////////////////////////

wheel_and_hub(material=_material, large_nozzle=_large_nozzle, l=_l, hub_radius=_hub_radius, axle_rounding=_axle_rounding, axle_radius=_axle_radius, center_radius=_center_radius, spoke_twist=_spoke_twist, wheel_diameter=_wheel_diameter, wheel_width=_wheel_width, wheel_thickness=_wheel_thickness);
  


/////////////////////////////////////
// MODULES
/////////////////////////////////////

module wheel_and_hub(material, large_nozzle, l, hub_radius, axle_rounding=_axle_rounding, axle_radius, center_radius, spoke_twist, wheel_diameter, wheel_width, wheel_thickness) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(hub_radius!=undef);
    assert(axle_radius!=undef);
    assert(center_radius!=undef);
    assert(wheel_diameter!=undef);
    assert(wheel_width!=undef);
    assert(wheel_thickness!=undef);

    hub_width=4;

    difference() {
        wheel(spoke_twist=spoke_twist, wheel_diameter=wheel_diameter, wheel_width=wheel_width, wheel_thickness=wheel_thickness, hub_width=hub_width, hub_l=l);

        hull() {
            hub(material=_material, large_nozzle=_large_nozzle, l=_l, hub_radius=_hub_radius, axle_rounding=_axle_rounding, axle_radius=_axle_radius, center_radius=_center_radius);
        }
    }

    hub(material=_material, large_nozzle=_large_nozzle, l=_l, hub_radius=_hub_radius, axle_rounding=_axle_rounding, axle_radius=_axle_radius, center_radius=_center_radius);
}


module wheel(spoke_twist=spoke_twist, wheel_diameter, wheel_width, wheel_thickness, hub_width, hub_l) {

    assert(wheel_diameter!=undef);
    assert(wheel_width!=undef);
    assert(wheel_thickness!=undef);
    assert(hub_width!=undef);
    assert(hub_l!=undef);

    spoke_diameter = wheel_diameter-wheel_thickness;
    spoke_width = 2;

    difference() {
        cylinder(d=wheel_diameter, h=wheel_width, $fn=256);

        translate([0, 0, -_skin]) {
            cylinder(d=wheel_diameter-wheel_thickness, h=wheel_width+2*_skin);
        }
    }

    spoke_count=5;

    spoke_set(spoke_count, spoke_twist=spoke_twist, spoke_diameter=spoke_diameter, spoke_width=spoke_width, wheel_width=wheel_width, hub_width=hub_width, hub_l=hub_l);
}


module spoke_set(spoke_count, spoke_twist, spoke_diameter, spoke_width, wheel_width, hub_width, hub_l) {

    count = 512;
    increment = 360/spoke_count;

    for (spoke_angle=[0:increment:360-increment]) {
        spoke(count=count, spoke_angle=spoke_angle, spoke_twist=spoke_twist, spoke_diameter=spoke_diameter, spoke_width=spoke_width, wheel_width=wheel_width, hub_width=hub_width, hub_l=hub_l);
    }
}


module spoke(count, spoke_angle, spoke_twist, spoke_diameter, spoke_width, wheel_width, hub_width, hub_l) {

    assert(count!=undef);
    assert(spoke_angle!=undef);
    assert(spoke_twist!=undef);
    assert(spoke_diameter!=undef);
    assert(spoke_width!=undef);
    assert(wheel_width!=undef);
    assert(hub_width!=undef);
    assert(hub_l!=undef);

    diameter_increment = spoke_diameter/(2*count);
    spoke_increment = spoke_twist/count;

    for (i=[0:count-1]) {
        angle = spoke_angle + spoke_increment*i;
        x = diameter_increment*i;
        rotate([0, 0, angle]) {
            translate([x, 0 , 0]) {
                cube([diameter_increment, spoke_width, wheel_width]);
            }
        }
    }
}
