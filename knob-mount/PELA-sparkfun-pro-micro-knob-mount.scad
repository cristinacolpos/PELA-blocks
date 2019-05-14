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
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../knob-mount/PELA-box-enclosure.scad>
use <PELA-knob-mount.scad>


/* [Sparkfun Pro Micro Knob Mount] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Board space length [mm]
length = 33.3; // [0.1:0.1:300]

// Board pace width [mm]
width = 18.3; // [0.1:0.1:300]

// Distance from bottom [mm]
height = 3.2; // [0.1:0.1:300]

// Board thickness [mm]
thickness = 1.7; // [0.1:0.1:300]

// Enclosure height
h = 1; // [1:1:20]

// How far below the bottom of the board to carve empty space
undercut = 1; // [0:0.1:32]

// Step in from board space edges to support the board [mm]
innercut = 1;

// Bottom of enclosure
bottom_type = 1; // [1:solid bottom, 2:socket panel bottom, 3:knob panel bottom]

// Presence of bottom connector sockets
sockets = true;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

side_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

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

PELA_sparkfun_pro_micro_knob_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, h=h, thickness=thickness, innercut=innercut, undercut=undercut, center_type=center_type, bottom_type=bottom_type, sockets=sockets, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, board_x_offset=board_x_offset, board_y_offset=board_y_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, dome=dome, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, l_pad=l_pad, w_pad=w_pad, block_height=block_height);



///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_sparkfun_pro_micro_knob_mount(material=undef, large_nozzle=undef, cut_line=undef, length=undef, width=undef, h=undef, thickness=undef, innercut=undef, undercut=undef, center_type=undef, bottom_type=undef, sockets=undef, top_vents=undef, side_holes=undef, end_holes=undef, side_sheaths=undef, end_sheaths=undef, left_wall_enabled=undef, right_wall_enabled=undef, front_wall_enabled=undef, back_wall_enabled=undef, board_x_offset=undef, board_y_offset=undef, left_wall_knobs=undef, right_wall_knobs=undef, front_wall_knobs=undef, back_wall_knobs=undef, dome=undef, solid_first_layer=undef, solid_upper_layers=undef, l_pad=undef, w_pad=undef, block_height=undef) {
    
    difference() {
        knob_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, h=h, thickness=thickness, innercut=innercut, undercut=undercut, center_type=center_type, bottom_type=bottom_type, sockets=sockets, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, board_x_offset=board_x_offset, board_y_offset=board_y_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, dome=dome, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, l_pad=l_pad, w_pad=w_pad, block_height=block_height);

        union() {
            l = fit_mm_to_blocks(length, l_pad);
            w = fit_mm_to_blocks(width, w_pad);

            axle_hole_radius = material_axle_hole_radius(material=material, large_nozzle=large_nozzle);
            bottom_connector_negative_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, side_holes=side_holes, end_holes=end_holes, block_height=block_height, hole_type=side_holes, corner_bolt_holes=corner_bolt_holes, sockets=sockets, skin=skin, block_height=block_height, axle_hole_radius=axle_hole_radius);

            usb_cutout(material=material, large_nozzle=large_nozzle, w=w);

            bottom_header_space(material=material, large_nozzle=large_nozzle, l=l, w=w, width=width, block_height=block_height);
        }
    }
}


module usb_cutout(material=undef, large_nozzle=undef, w=undef) {

    translate([-_defeather, block_width(1), block_height(0.5, block_height=block_height)]) {
        cube([block_width(2), block_width(w-2), block_height(2, block_height=block_height)]);
    }
}
