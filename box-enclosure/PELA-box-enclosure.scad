/*
Parametric PELA Box Enclosure Generator

Create a bottom and 4 walls of a rectangle for enclosing objects


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Work sponsored by
    http://futurice.com

Import this into other design files:
    use <anker-usb-PELA-enclosure.scad>
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../support/support.scad>


/* [PELA Box Option] */

// Length of the enclosure including two for walls (PELA knob count)
l = 6;

// Width of the enclosure including two for walls (PELA knob count)
w = 4;

// Height of the enclosure including one for floor (PELA block layer count)
h = 3;

// Add full width through holes spaced along the length for PELA Techics connectors
side_holes = 2;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a sheath around side holes (disable for extra ventilation, enable for connector lock notches)
side_sheaths = 1; // [0:disabled, 1:enabled]

// Add short end holes spaced along the width for PELA Techics connectors
end_holes = 2;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full length connectors]

// Add a sheath around end holes  (disable for extra ventilation, enable for connector lock notches)
end_sheaths = 1; // [0:disabled, 1:enabled]

// Add holes in the top deck to improve airflow and reduce weight
top_vents = 0; // [0:disabled, 1:enabled]

// Size of a hole in the top of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
knob_vent_radius = 0;

// There is usually no need or room for corner mounting M3 bolt holes
bolt_holes=0;

/////////////////////////////////////
// PELA Box Enclosure Display

PELA_box_enclosure();


///////////////////////////////////
// Modules
///////////////////////////////////

module PELA_box_enclosure(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths) {

    left_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths);

    right_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths);

    front_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths);

    back_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths);
}


module left_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths) {

    difference() {
        PELA_technic_block(l=1, w=w, h=h, top_vents=top_vents, side_holes=0, side_sheaths=0, end_holes=end_holes, end_sheaths=end_sheaths);

        union() {
            corner_cut(angle=-45, h=h+1);

            translate([0, block_width(w), 0])
                corner_cut(angle=-45, h=h+1);
        }
    }
}


module corner_cut(angle, h=h) {
    translate([0, 0, -defeather])
        rotate([0, 0, angle])
            cube([block_width(2), block_width(2), block_height(h)]);
}


module right_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths) {

    translate([block_width(l), block_width(w), 0])
        rotate([0, 0, 180])
            left_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths);
}


module front_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths) {

    difference() {
        PELA_technic_block(l=l, w=1, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=0, end_sheaths=0);

        union() {
            corner_cut(angle=45, h=h+1);

            translate([block_width(l), 0, 0])
                corner_cut(angle=45, h=h+1);
        }
    }
}


module back_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths) {

    translate([block_width(l), block_width(w), 0])
        rotate([0, 0, 180])
            front_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths);
}
