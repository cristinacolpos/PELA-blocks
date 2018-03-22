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
use <PELA-box-enclosure.scad>


/* [PELA Box Option] */

// Length of the enclosure including two for walls (PELA knob count)
l = 14;

// Width of the enclosure including two for walls (PELA knob count)
w = 10;

// Height of the enclosure including one for floor (PELA block layer count)
h = 3;

// Board length, including some extra
board_l = 97.3;

// Board width, including some extra
board_w = 66.3;

// Distance from box bottom to mount the board
board_h = 12;

// Thickness, including some extra for insertion
board_thickness = 1.8;

// Add full width through holes spaced along the length for PELA Techics connectors
side_holes = 2;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a sheath around side holes (disable for extra ventilation, enable for connector lock notches)
side_sheaths = 1; // [0:disabled, 1:enabled]

// Add short end holes spaced along the width for PELA Techics connectors
end_holes = 0;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full length connectors]

// Add a sheath around end holes  (disable for extra ventilation, enable for connector lock notches)
end_sheaths = 1; // [0:disabled, 1:enabled]

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

// Add holes in the bottom deck to improve airflow and reduce weight (only used with bottom_type==2, knob panel)
bottom_vents = false;

// Size of a hole in the top surface of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
knob_vent_radius = 0;

// There is usually no need or room for corner mounting M3 bolt holes
bolt_holes = false;

// Bottom of enclosure
bottom_type = 3; // [0:open bottom, 1:solid bottom, 2:socket-panel bottom, 3:knob-panel bottom]

// Height of the bottom to the enclosure (by default this is shorter then a normal panel so there is room on the enclosure sides for technic holes)
bottom_height = 2.5;

// Size of the small flexture cavity inside each knob (set to 0 for flexible materials, if the knobs delaminate and detach, or to avoid holes if the knobs are removed)
knob_flexture_radius = 0;

// Create the left wall
left_wall_enabled = false;

// Create the right wall
right_wall_enabled = true;

// Create the front wall
front_wall_enabled = true;

// Create the back wall
back_wall_enabled = true;

/////////////////////////////////////
// PELA Box Enclosure Display

PELA_stmf4discovery_box_enclosure();


///////////////////////////////////
// Modules
///////////////////////////////////


module PELA_stmf4discovery_box_enclosure(l=l, w=w, h=h, bottom_type=bottom_type, bottom_height=bottom_height, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled) {

    difference() {
        union() {
            PELA_box_enclosure(l=l, w=w, h=h, bottom_type=bottom_type, bottom_height=bottom_height, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled);

//            board_insertion_space_shell(l=l, w=w, h=h, bottom_height=bottom_height, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness);
        }

        union() {
            board_insertion_space(l=l, w=w, h=h, bottom_height=bottom_height, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness);
            bottom_connector_negative_space(l=l, w=w, side_holes=side_holes, end_holes=end_holes, axle_hole_radius=axle_hole_radius, block_width=block_width, hole_type=side_holes, knob_radius=knob_radius, block_width=block_width, bolt_holes=bolt_holes);
        }
    }
}


// The shape of the board (excluding top and bottom coponents and connectors) which is being enclosed
module board(l=l, w=w, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness) {
    x = (block_width(l) - board_l)/2;
    y = (block_width(w) - board_w)/2;
    translate([x, y, board_h]) {
        cube([board_l, board_w, board_thickness]);
    } 
}


// The space needed to drop the board in from above (may cut into the side walls)
module board_insertion_space(l=l, w=w, h=h, bottom_height=bottom_height, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness) {
    hull() {
        board(l=l, w=w, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness);

        translate([0, 0, block_height(h)]) {
            board(l=l, w=w, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness);
        }
    }

    translate([block_width(1)-skin, block_width(1)-skin, bottom_height]) {
        cube([block_width(l-2)+2*skin, block_width(w-2)+2*skin, block_height(h)]);
    }
}


// A solid layer around the space removed to allow dropping the board in from above
module board_insertion_space_shell(l=l, w=w, h=h, bottom_height=bottom_height, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness) {
    intersection() {
        minkowski() {
            board_insertion_space(l=l, w=w, h=h, bottom_height=bottom_height, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness);

            dx_left = 0;
            dx_right = 0;
            dy_front = shell;
            dy_back = shell;
            x_thickness = max(shell, dx_left+dx_right);
            y_thickness = max(shell, dy_front+dy_back);

            translate([-dx_left, -dy_front, 0]) {
                cube([x_thickness, y_thickness, shell]);
            }
        }

        cube([block_width(l), block_width(w), block_height(h)]);
    }
}