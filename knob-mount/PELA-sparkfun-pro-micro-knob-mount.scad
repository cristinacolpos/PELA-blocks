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
use <../box-enclosure/PELA-box-enclosure.scad>
use <PELA-knob-mount.scad>


/* [Sparkfun Pro Micro Knob Mount] */

// Show the inside structure [mm]
cut_line = 0;

// Printing material
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the nozzle >= 0.5mm? If so, some features are larger to make printing easier (and slightly slower)
large_nozzle = true;

length = 33.3; // Board length, including some extra

width = 18.3; // Board width, including some extra

height = 3.2; // Distance from box bottom to mount the board

thickness = 1.7; // Thickness, including some extra for insertion

h = 1;

// How far below the bottom of the board surface parts protude 
undercut = 12.3;

// Step in from board space edges to support the board [mm]
innercut = 1;

bottom_type = 0; // [0:open bottom, 1:solid bottom, 2:socket-panel bottom, 3:knob-panel bottom]

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

side_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

end_holes = 0; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

side_sheaths = true;

end_sheaths = false;

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

center_type = 2; //[0:empty, 1:solid, 2:solid with side holes, 3:solid with end holes, 4:solid with both side and end holes]

board_x_offset = -1;

board_y_offset = 0;

board_z_offset = -thickness;

top_edge_height = 2;

// A number from 1 to 2. This is a ratio of 1 block width for the board surround. Smaller numbers mean less space horizontally around the board (it can eat into the surrounding wall knobs). Larger numbers may bump you up by 1 knob, resulting in a wider or longer enclosure.
length_padding = 0; // [0:tight, 1:+1 block, 2:+2 blocks]

// Board surround ratio
width_padding = 0; // [0:tight, 1:+1 block, 2:+2 blocks]

dome = true;  // Bevel the outside edges above the board space inward to make upper structures like knobs more printable


///////////////////////////////
// DISPLAY
///////////////////////////////

PELA_sparkfun_pro_micro_board_mount();



///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_sparkfun_pro_micro_board_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line,length=length, width=width, h=h, thickness=thickness, innercut=innercut, bottom_type=bottom_type, center_type=center_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, dome=dome, length_padding=length_padding, width_padding=width_padding, solid_first_layer=solid_first_layer, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers) {
    
    difference() {
        board_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line,length=length, width=width, h=h, thickness=thickness, innercut=innercut, bottom_type=bottom_type, center_type=center_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, dome=dome, length_padding=length_padding, width_padding=width_padding, solid_first_layer=solid_first_layer, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers);

        union() {
            l = fit_mm_to_blocks(i=length, tightness=length_padding);
            w = fit_mm_to_blocks(i=width, tightness=width_padding);

            bottom_connector_negative_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=1, side_holes=side_holes, end_holes=end_holes, block_width=block_width, hole_type=side_holes, corner_bolt_holes=corner_bolt_holes, sockets=sockets);

            usb_cutout(material=material, large_nozzle=large_nozzle, w=w);

            bottom_header_space(material=material, large_nozzle=large_nozzle, l=l, w=w, width=width, block_height=block_height);
        }
    }
}


module usb_cutout(material=material, large_nozzle=large_nozzle, w=undef) {
    translate([-defeather, block_width(1), block_height(0.5, block_height=block_height)]) {
        cube([block_width(2), block_width(w-2), block_height(2, block_height=block_height)]);
    }
}
