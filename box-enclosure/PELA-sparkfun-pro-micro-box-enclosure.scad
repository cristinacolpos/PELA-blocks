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
    https://www.futurice.com/
*/

include <../style.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../PELA-socket-panel.scad>
use <../knob-panel/PELA-knob-panel.scad>
use <PELA-box-enclosure.scad>


/* [Sparkfun Pro Micro Box Enclosure] */

// Printing material
material = pla; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Length of the enclosure including two for walls (PELA knob count)
l = 6;

// Width of the enclosure including two for walls (PELA knob count)
w = 4;

// Height of the enclosure including one for floor (PELA block layer count)
h = 1;

// Board length, including some extra
board_l = 33.3;

// Board width, including some extra
board_w = 18.3;

// Distance from box bottom to mount the board
board_h = 3.2;

// Thickness, including some extra for insertion
board_thickness = 1.7;

// Holes spaced along the length for techic connectors
side_holes = 0; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// A side_shell around side holes (disable for extra ventilation, enable for connector lock notches)
side_sheaths = 1; // [0:disabled, 1:enabled]

// Short end holes spaced along the width for PELA Techics connectors
end_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full length connectors]

// A side_shell around end holes  (disable for extra ventilation, enable for connector lock notches)
end_sheaths = 1; // [0:disabled, 1:enabled]

// Holes in the top deck to improve airflow and reduce weight
top_vents = false;

// Add holes in the bottom deck to improve airflow and reduce weight (only used with bottom_type==2, knob panel)
bottom_vents = false;

// Size of a hole in the top surface of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
knob_vent_radius = 0.0;

// There is usually no need or room for corner mounting M3 bolt holes
corner_bolt_holes = true;

// Bottom of enclosure
bottom_type = 2; // [0:open bottom, 1:solid bottom, 2:socket-panel bottom, 3:knob-panel bottom]

// Include the left wall
left_wall_enabled = false;

// Include the right wall
right_wall_enabled = true;

// Include the front wall
front_wall_enabled = true;

// Include the back wall
back_wall_enabled = true;

// Side snap size, block units. Wider is stronger and more stiff [mm]
flexture_width = 1;

// Width of flexture spacings from the rest of the side wall [mm]
side_snap_cut_width = 0.5;

// Depth into the side walls of the cut (block units, larger value means thicker/stiffer flexture) [mm]
side_snap_cut_depth = 0.3;

// Block with units in from board ends where the side snaps are placed [mm]
side_snap_end_inset = 1.5;

// Size of the bump which holds the board down (part of the snap inset flexture) [mm]
retainer_tab_radius = 0.5;

// Distance from the bottom for the retainer tabs [mm]
retainer_tab_height = 5;

// Size of the space for cable access on the enclosure end [mm]
connector_hole_radius = 0;

// Height of the flexture which allows the board to slide past the retainer tab (block height count) [mm]
side_fexture_cut_height = 0.93;

solid_upper_layers = true;

center_type = 0; //[0:empty, 1:solid, 2:solid with side holes, 3:solid with end holes, 4:solid with both side and end holes]


///////////////////////////////
// DISPLAY
///////////////////////////////

PELA_sparkfun_pro_micro_box_enclosure();


///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_sparkfun_pro_micro_box_enclosure(material=material, l=l, w=w, h=h, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_upper_layers=solid_upper_layers, retainer_tab_radius=retainer_tab_radius, center_type=center_type) {

    difference() {
        union() {
            PELA_box_enclosure(material=material, l=l, w=w, h=h, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_upper_layers=solid_upper_layers, center_type=center_type);

            board_insertion_space_side_shell(material=material, l=l, w=w, h=h, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness);
        }

        union() {
            board_insertion_space(material=material, l=l, w=w, h=h, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness);
            
            connector_holes(material=material);
            
            right_side_snap_cuts(material=material, side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius);

            left_side_snap_cuts(material=material, side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius);
        }
    }

    right_side_retainer_tabs(material=material, flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius);

    left_side_retainer_tabs(material=material, flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius);

    translate([0, 0, board_thickness + retainer_tab_radius + skin]) {
        right_side_retainer_tabs(material=material, flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius);
    
        left_side_retainer_tabs(material=material, flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius);
    }
}


// Two bumps on the two right side flextures to keep the board from moving upwards
module right_side_retainer_tabs(material=material, flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius) {

    side_snap_board_retainer_tab(material=material, flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius);

    translate([block_width(l - flexture_width - 2*side_snap_end_inset), 0, 0]) {
        side_snap_board_retainer_tab(material=material, flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius);
    }        
}


// Two bumps on the left side to hold the board down
module left_side_retainer_tabs(material=material, flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius) {

    translate([block_width(l), block_width(w), 0]) {
        rotate([0, 0, 180]) {
            right_side_retainer_tabs(material=material, flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius);
        }
    }
}


// A bump sticking inward from the side flexture- keeps the board down
module side_snap_board_retainer_tab(material=material, flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius) {

    translate([block_width(side_snap_end_inset) + side_snap_cut_width, block_width(0.5) + 3, retainer_tab_height]) {
        rotate([0, 90, 0]) {
            cylinder(r=retainer_tab_radius, h=block_width(flexture_width) - 2*side_snap_cut_width);
        }
    }
}


// Access points in the back panel for parts of the board which have wires attached
module connector_holes(material=material, block_height=block_height) {
    translate([0, block_width(w/2), block_height(h/2, block_height=block_height)]) {
        rotate([0, 90, 0]) {
            cylinder(r=connector_hole_radius, h=block_width(l));
        }
    }
}


// The shape of the board (excluding top and bottom coponents and connectors) which is being enclosed
module board(material=material, l=l, w=w, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness) {
    x = (block_width(l) - board_l)/2;
    y = (block_width(w) - board_w)/2;

    translate([x, y, board_h]) {
        cube([board_l, board_w, board_thickness]);
    } 
}


// The space needed to drop the board in from above (may cut into the side walls)
module board_insertion_space(material=material, l=l, w=w, h=h, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness, block_height=block_height) {

    hull() {
        board(material=material, l=l, w=w, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness);

        translate([0, 0, block_height(h, block_height=block_height) - board_h - board_thickness]) {
            board(material=material, l=l, w=w, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness);
        }
    }
}


// A solid layer around the space removed to allow dropping the board in from above
module board_insertion_space_side_shell(material=material, l=l, w=w, h=h, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness, block_height=block_height) {

    board_insertion_space(material=material, l=l, w=w, h=h, board_l=board_l, board_w=board_w + 2*side_shell, board_h=board_h, board_thickness=board_thickness, block_height=block_height);
}


// Four vertical cuts into the side for two flexture to move with the board retaining tab
module right_side_snap_cuts(material=material, side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius, block_height=block_height) {

    side_snap_board_holder_cut(material=material, side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius, block_height=block_height);

    translate([block_width(l - 2*side_snap_end_inset - flexture_width), 0, 0]) {

        side_snap_board_holder_cut(material=material, flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius, block_height=block_height);
    }
}


// Four vertical cuts into the left side
module left_side_snap_cuts(material=material, side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius, block_height=block_height) {

    translate([block_width(l), block_width(w), 0]) {
        rotate([0, 0, 180]) {
            right_side_snap_cuts(material=material, side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius, block_height=block_height);
        }
    }
}

// Two vertical cuts in the side to hold a single board retaining tab
module side_snap_board_holder_cut(material=material, flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius, block_height=block_height) {

    cut_height = block_height(side_fexture_cut_height, block_height=block_height) - panel_height(block_height=block_height);

    translate([block_width(side_snap_end_inset), block_width(0.5), panel_height(block_height=block_height)]) {        
        side_snap_cut(material=material, side_snap_cut_width=side_snap_cut_width, cut_height=cut_height);

        translate([block_width(flexture_width) - side_snap_cut_width, 0, 0]) {
            side_snap_cut(material=material, side_snap_cut_width=side_snap_cut_width, cut_height=cut_height, block_height=block_height);
        }

        translate([0, block_width(0.5 - side_snap_cut_depth) - retainer_tab_radius, 0]) {
            side_snap_back_cut(material=material, flexture_width=flexture_width, retainer_tab_radius=retainer_tab_radius, cut_height=cut_height, block_height=block_height);
        }
    }
}


// A vertical slice to allow the flexture to move inward as the board is inserted past the retaining tab
module side_snap_cut(material=material, side_snap_cut_width=side_snap_cut_width, cut_height) {

    cube([side_snap_cut_width, block_width(1), cut_height]);
}


// A vertical slice to allow the flexture to move inward as the board is inserted past the retaining tab
module side_snap_back_cut(material=material, flexture_width=flexture_width, retainer_tab_radius=retainer_tab_radius, cut_height) {

    cube([block_width(flexture_width), retainer_tab_radius, cut_height]);
}
