/*
PELA Board Holder - 3D Printed LEGO-compatible Arduino Mega board mount

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

include <../print-parameters.scad>
include <../style.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <PELA-knob-mount.scad>

////////////////////
// Parameters
////////////////////

// Length of the enclosed object [mm]
length = 101.6;

// Width of the enclosed object [mm]
width = 53.4;

// Thickness of the enclosed object [mm]
thickness = 1.8;

h = 1;

// How far in from the outside edges the board support can extend without hitting board bottom surface parts
innercut = 1;

bottom_type = 2; // [0:open bottom, 1:solid bottom, 2:socket-panel bottom, 3:knob-panel bottom]

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

side_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

end_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

side_sheaths = true;

end_sheaths = true;

left_wall_enabled = true;

right_wall_enabled = true;

front_wall_enabled = true;

back_wall_enabled = true;

knobs_on_top = true;

left_wall_knobs = false;

right_wall_knobs = true;

front_wall_knobs = true;

back_wall_knobs = true;

solid_upper_layers = false;

// Add interior fill for the base layer
solid_first_layer = true;

center_type = 4; //[0:empty, 1:solid, 2:solid with side holes, 3:solid with end holes, 4:solid with both side and end holes]

board_x_offset = -2;

board_y_offset = 0;

board_z_offset = -thickness;

sd_card_cutout_width = block_width(3);

sd_card_cutout_depth = 3.8;

sd_card_cutout_offset = -block_width(1/2);

top_edge_height = 2;

// A number from 1 to 2. This is a ratio of 1 block width for the board surround. Smaller numbers mean less space horizontally around the board (it can eat into the surrounding wall knobs). Larger numbers may bump you up by 1 knob, resulting in a wider or longer enclosure.
length_tightness = 1.0;

// Board surround ratio
width_tightness = 1.5;

dome = true;  // Bevel the outside edges above the board space inward to make upper structures like knobs more printable

block_height = 9.6;


///////////////////////////////
// DISPLAY
///////////////////////////////

arduino_mega_board_mount();



///////////////////////////////////
// MODULES
///////////////////////////////////

module arduino_mega_board_mount(length=length, width=width, h=h, thickness=thickness, innercut=innercut, bottom_type=bottom_type, center_type=center_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, dome=dome, length_tightness=length_tightness, width_tightness=width_tightness, solid_first_layer=solid_first_layer, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, block_height=block_height) {
    
    difference() {
        board_mount(length=length, width=width, h=h, thickness=thickness, innercut=innercut, bottom_type=bottom_type, center_type=center_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, dome=dome, length_tightness=length_tightness, width_tightness=width_tightness, solid_first_layer=solid_first_layer, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, block_height=block_height);

        l = fit_mm_to_pela_blocks(i=length, tightness=length_tightness);
        w = fit_mm_to_pela_blocks(i=width, tightness=width_tightness);

        bottom_connector_negative_space(l=l, w=w, h=1, side_holes=side_holes, end_holes=end_holes, axle_hole_radius=axle_hole_radius, block_width=block_width, hole_type=side_holes, corner_bolt_holes=corner_bolt_holes, sockets=sockets, block_height=block_height);
    }
}
