/*
Parametric PELA LEGO-compatible technic cross-shaped rotational drive Axle

PELA Parametric Blocks - 3D Printed LEGO-compatible parametric blocks

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
include <../print-parameters.scad>
use <../PELA-block.scad>
use <PELA-technic-axle.scad>

/* [Technic Cross Axle] */

// Printing material
material = pla; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Axle length [blocks]
l = 3;

// Outside radius of an axle which fits loosely in a technic bearing hole [mm]
axle_radius = 2.2;

// Size of the axle solid center before rounding [mm]
center_radius = (1/3)*axle_radius;

// Cross axle inside rounding radius [mm]
axle_rounding = 0.63;



///////////////////////////////
// DISPLAY
///////////////////////////////


cross_axle();
    




/////////////////////////////////////
// MODULES
/////////////////////////////////////

module cross_axle(material=material, l=l, axle_rounding=axle_rounding, axle_radius=axle_radius, center_radius=center_radius) {

    axle_length = block_width(l);

    rotate([90, 45, 0]) {
        difference() {
            axle(material=material, l=l, axle_radius=axle_radius, center_radius=0);
            
            axle_cross_negative_space(material=material, axle_length=axle_length, axle_rounding=axle_rounding, axle_radius=axle_radius);
        }
    }
}


// That which is cut away four times from a solid to create a cross axle
module axle_cross_negative_space(material=material, axle_length, axle_rounding=axle_rounding, axle_radius=axle_radius) {
    
    for (rot=[0:90:270]) {
        rotate([0, 0, rot]) {
            hull() {
                translate([axle_rounding*2, axle_rounding*2, -defeather]) {
                    cylinder(r=axle_rounding, h=axle_length+2*defeather);

                    translate([axle_radius, 0, 0]) {
                        cylinder(r=axle_rounding, h=axle_length+2*defeather);
                    }

                    translate([0, axle_radius, 0]) {
                        cylinder(r=axle_rounding, h=axle_length+2*defeather);
                    }
                }
            }
        }
    }
}
