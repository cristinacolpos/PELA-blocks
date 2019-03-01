/*
PELA Board Holder - 3D Printed LEGO-compatible Node MCU 32s (ESP32) board mount

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

include <../material.scad>
include <../style.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <PELA-knob-mount.scad>

////////////////////
// Parameters
////////////////////

/* [Node MCU 32s Knob Mount] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

length = 28.7; // [0.1:0.1:300]

width = 10.6; // [0.1:0.1:300]

thickness = 1.7; // [0.1:0.1:300]

h = 1;

// How far below the bottom of the board to carve empty space 
undercut = 2.3; // [0:0.1:32]

// Step in from board space edges to support the board [mm]
innercut = 1;

// Bottom of enclosure
bottom_type = 0; // [0:open bottom, 1:solid bottom, 2:socket panel bottom, 3:knob panel bottom]

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

// Add full width through holes spaced along the width for techic connectors
side_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add full width through holes spaced along the length for techic connectors
end_holes = 0; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around side holes (disable for extra ventilation, enable for lock notch fit)
side_sheaths = true;

// Add a wrapper around end holes  (disable for extra ventilation but loose lock notches)
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

// Filler for the model center space
center_type = 2; //[0:empty, 1:solid, 2:solid with side holes, 3:solid with end holes, 4:solid with both side and end holes]

// Shift the PCB board relative to the enclosure on the X axis [mm]
board_x_offset = -1; // [-8:0.1:8]

// Shift the PCB board relative to the enclosure on the Y axis [mm]
board_y_offset = 0; // [-8:0.1:8]

top_edge_height = 2;

// A number from 1 to 2. This is a ratio of 1 block width for the board surround. Smaller numbers mean less space horizontally around the board (it can eat into the surrounding wall knobs). Larger numbers may bump you up by 1 knob, resulting in a wider or longer enclosure.
l_pad = 0; // [0:tight, 1:+1 block, 2:+2 blocks]

// Board surround ratio
w_pad = 0; // [0:tight, 1:+1 block, 2:+2 blocks]

// Bevel the outside edges above the board space inward to make upper structures like knobs more printable
dome = true;



///////////////////////////////
// DISPLAY
///////////////////////////////

nodemcu_32s_knob_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, h=h, thickness=thickness, undercut=undercut, innercut=innercut, bottom_type=bottom_type, center_type=center_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, board_x_offset=board_x_offset, board_y_offset=board_y_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, dome=dome, l_pad=l_pad, w_pad=w_pad, solid_first_layer=solid_first_layer, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers);


///////////////////////////////////
// MODULES
///////////////////////////////////

module nodemcu_32s_knob_mount(material=undef, large_nozzle=undef, cut_line=undef, length=undef, width=undef, h=undef, thickness=undef, undercut=undef, innercut=undef, bottom_type=undef, center_type=undef, top_vents=undef, side_holes=undef, end_holes=undef, side_sheaths=undef, end_sheaths=undef, left_wall_enabled=undef, right_wall_enabled=undef, front_wall_enabled=undef, back_wall_enabled=undef, board_x_offset=undef, board_y_offset=undef, left_wall_knobs=undef, right_wall_knobs=undef, front_wall_knobs=undef, back_wall_knobs=undef, dome=undef, l_pad=undef, w_pad=undef, solid_first_layer=undef, solid_first_layer=undef, solid_upper_layers=undef) {
    
    difference() {
        knob_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, h=h, thickness=thickness, undercut=undercut, innercut=innercut, bottom_type=bottom_type, center_type=center_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, board_x_offset=board_x_offset, board_y_offset=board_y_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, dome=dome, l_pad=l_pad, w_pad=w_pad, solid_first_layer=solid_first_layer, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers);

        union() {
            l = fit_mm_to_blocks(length, l_pad);
            w = fit_mm_to_blocks(width, w_pad);

            bottom_connector_negative_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=1, side_holes=side_holes, end_holes=end_holes, hole_type=side_holes, corner_bolt_holes=corner_bolt_holes, sockets=sockets);

            bottom_header_space(material=material, large_nozzle=large_nozzle, l=l, w=w, width=width, block_height=block_height);
        }
    }
}
