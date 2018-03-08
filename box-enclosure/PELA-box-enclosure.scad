/*
Parametric PELA Box Enclosure Generator

Create a bottom and 4 walls of a rectangle for enclosing objects


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    http://futurice.com

Import this into other design files:
    use <anker-usb-PELA-enclosure.scad>
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../socket-panel/PELA-socket-panel.scad>
use <../knob-panel/PELA-knob-panel.scad>


/* [PELA Box Option] */

// Length of the enclosure including two for walls (PELA knob count)
l = 11;

// Width of the enclosure including two for walls (PELA knob count)
w = 11;

// Height of the enclosure including one for floor (PELA block layer count)
h = 1;

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

// Add holes in the bottom deck to improve airflow and reduce weight (only used with bottom_type==2, knob panel)
bottom_vents = 1; // [0:disabled, 1:enabled]

// Size of a hole in the top of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
knob_vent_radius = 0;

// There is usually no need or room for corner mounting M3 bolt holes
bolt_holes = 0;

// Bottom of enclosure
bottom_type = 0; // [0:open bottom, 1:solid bottom, 2:socket-panel bottom, 3:knob-panel bottom]

// Height of the bottom to the enclosure (by default this is shorter then a normal panel so there is room on the enclosure sides for technic holes)
bottom_height = 2.5;

 knob_flexture_radius= 0;
skin=0.1;

/////////////////////////////////////
// PELA Box Enclosure Display

PELA_box_enclosure();


///////////////////////////////////
// Modules
///////////////////////////////////

module PELA_box_enclosure(l=l, w=w, h=h, bottom_type=bottom_type, bottom_height=bottom_height, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin) {

    difference() {
        union() {
            left_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin);

            right_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin);

            front_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin);

            back_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin);
        }
        bottom_negative_space(l=l, w=w, bottom_type=bottom_type, bottom_height=bottom_height);
    }
    enclosure_bottom(l=l, w=w, bottom_type=bottom_type, bottom_height=bottom_height, skin=skin);
}


module left_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin) {

    difference() {
        PELA_technic_block(l=1, w=w, h=h, top_vents=top_vents, side_holes=0, side_sheaths=0, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin,, knob_flexture_radius= knob_flexture_radius);

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


module right_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin) {

    translate([block_width(l), block_width(w), 0])
        rotate([0, 0, 180])
            left_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin);
}


module front_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin) {

    difference() {
        PELA_technic_block(l=l, w=1, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=0, end_sheaths=0, skin=skin, knob_flexture_radius= knob_flexture_radius);

        union() {
            corner_cut(angle=45, h=h+1);

            translate([block_width(l), 0, 0])
                corner_cut(angle=45, h=h+1);
        }
    }
}


module back_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin) {

    translate([block_width(l), block_width(w), 0])
        rotate([0, 0, 180])
            front_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin);
}


module bottom_negative_space(l=l, w=w, bottom_type=bottom_type, bottom_height=bottom_height) {
    if (bottom_type > 0) {
        enclosure_bottom(l=l, w=w, bottom_type=1, bottom_height=bottom_height, skin=0);
    }
}


module enclosure_bottom(l=l, w=w, bottom_type=bottom_type, bottom_height=bottom_height, skin=skin) {
    translate([skin, skin, 0]) {
        if (bottom_type==1) {
            cube([block_width(l)-2*skin, block_width(w)-2*skin, bottom_height]);
        } else if (bottom_type==2) {
            PELA_socket_panel_one_sided(l=l, w=w, panel_height=bottom_height, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, skin=skin);        
        } else if (bottom_type==3) {
            PELA_knob_panel(l=l, w=w, pane_height=bottom_height, top_vents=bottom_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, sockets=sockets, skin=skin);
        }
    }
}