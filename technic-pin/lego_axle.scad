/*
Parametric LEGO Technic-compatible Pin

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

include <../lego-parameters.scad>
use <../lego-technic.scad>
use <../lego.scad>

/* [LEGO Technic-compatible Pin Options] */

// What type of Pin or similar object to generate
mode=2; // [1:pin, 2:axle]

// An axle which fits loosely in a technic bearing hole
axle_radius = 2.35;

// Size of the hollow inside of an axle
axle_center_radius=2*axle_radius/3;

// Size of the hollow inside of an axle
pin_center_radius=3*axle_radius/4;

// Size of the connector lock-in bump at the ends of a Pin
pin_tip_length = 0.8;

// Width of the flexture slots in a pin
slot_thickness = 0.85;

defeather=0.01;

counterbore_holder_radius = counterbore_inset_radius - skin;

counterbore_holder_height = counterbore_inset_depth * 2;

///////////////

if (mode == 1) {
    axle();
} else if (mode == 2) {
    pin();
} else {
    echo("<b>Unsupported mode: please check <i>mode</i> variable is 1-2</b>");
}
    
//////////////////


module axle(axle_radius=axle_radius, axle_center_radius=axle_center_radius, length=15) {

    difference() {
        cylinder(r=axle_radius, h=length);
        translate([0, 0, -defeather])
            cylinder(r=axle_center_radius, h=length+2*defeather);
    }
}


module pin(axle_radius=axle_radius, pin_center_radius=pin_center_radius, peg_length=peg_length, pin_tip_length=pin_tip_length, counterbore_holder_height=counterbore_holder_height) {

    length=(peg_length+pin_tip_length)*2 + counterbore_holder_height;

    slot_length=length/2;

    difference() {
        union() {
            cylinder(r=axle_radius, h=length);
            
            translate([0, 0, peg_length+pin_tip_length])
                cylinder(r=counterbore_holder_radius, h=counterbore_holder_height);
            
            tip(axle_radius=axle_radius, pin_tip_length=pin_tip_length);
            
            translate([0, 0, length-pin_tip_length])
                tip(axle_radius=axle_radius, pin_tip_length=pin_tip_length);
        }
        
        union() {
            translate([0, 0, -defeather])
                cylinder(r=pin_center_radius, h=length+2*defeather);

            translate([0, 0, slot_thickness])
                rounded_slot(thickness=slot_thickness, slot_length=slot_length);
            
            translate([0, 0, length-slot_thickness])
                rounded_slot(thickness=slot_thickness, slot_length=slot_length);
            
            translate([0, 0, length/2])
                rotate([0, 0, 90])
                rounded_slot(thickness=slot_thickness, slot_length=slot_length);
        }
    }
}


// An end ridge to allow a Pin to lock in to a Technic-compatible block
module tip(axle_radius=axle_radius, pin_tip_length=pin_tip_length) {
    rounded_disc(radius=axle_radius+pin_tip_length, thickness=pin_tip_length);
}


// A disc with rounded outer edge
module rounded_disc(radius=10, thickness=1) {
    translate([0, 0, thickness/2])
        minkowski() {
            cylinder(r=radius-thickness, h=defeather);
        
            sphere(r=thickness/2, $fn=16);
        }
}

module rounded_slot(thickness=2, slot_length=10) {
    width = 20;
    
    hull() {
        translate([-width/2, 0, slot_length/2 - thickness])
            rotate([0, 90, 0])
                cylinder(r=thickness/2, h=width, $fn=16);
            
        translate([-width/2, 0, -slot_length/2 + thickness])
            rotate([0, 90, 0])
                cylinder(r=thickness/2, h=width, $fn=16);
    }
}
