/*
Parametric LEGO Technic-compatible cross-shaped rotational drive Axle

Published at
    http://www.thingiverse.com/thing:XXXX
Maintained at
    https://github.com/paulirotta/parametric_lego
See also the related files
    LEGO Sign Generator - https://www.thingiverse.com/thing:2546028
    LEGO Enclosure Generator - https://www.thingiverse.com/thing:2544197


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com
*/

include <lego-parameters.scad>
use <lego.scad>
use <technic-axle.scad>

/* [LEGO Technic-compatible Pin Options] */

// Axle length
axle_length = lego_width(3);

// Outside radius of an axle which fits loosely in a technic bearing hole
axle_radius = 2.2;

// Cross axle inside rounding radius
axle_rounding=0.63;

// Size of the hollow inside an axle
axle_center_radius=2*axle_radius/3;

defeather=0.01;

///////////////

cross_axle();
    
//////////////////


// A rotation axle with a "+" cross section
module cross_axle(axle_rounding=axle_rounding, axle_radius=axle_radius, axle_length=axle_length) {

    rotate([90, 45, 0])
        difference() {
            axle(axle_radius=axle_radius, axle_center_radius=0, length=axle_length);        
            axle_cross_negative_space(axle_rounding=axle_rounding, axle_radius=axle_radius, axle_length=axle_length);
        }
}


// That which is cut away four times from a solid to create a cross axle
module axle_cross_negative_space(axle_rounding=axle_rounding, axle_radius=axle_radius, axle_length=axle_length) {
    
    for (rot=[0:90:270]) {
        rotate([0, 0, rot])
            hull() {
                translate([axle_rounding*2, axle_rounding*2, -defeather]) {
                    cylinder(r=axle_rounding, h=axle_length+2*defeather);

                    translate([axle_radius, 0, 0])
                        cylinder(r=axle_rounding, h=axle_length+2*defeather);

                    translate([0, axle_radius, 0])
                        cylinder(r=axle_rounding, h=axle_length+2*defeather);
                }
            }
    }
}
