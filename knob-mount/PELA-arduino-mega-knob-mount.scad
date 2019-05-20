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

include <../material.scad>
include <../style.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../knob-mount/PELA-box-enclosure.scad>
use <PELA-knob-mount.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]
// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Board] */

// Length of the enclosed object [mm]
_length = 101.6; // [0.1:0.1:300]

// Width of the enclosed object [mm]
_width = 53.4; // [0.1:0.1:300]

// Thickness of the enclosed object [mm]
_thickness = 1.8; // [0.1:0.1:300]



/* [Enclosure] */

// A number from 1 to 2. This is a ratio of 1 block width for the board surround. Smaller numbers mean less space horizontally around the board (it can eat into the surrounding wall knobs). Larger numbers may bump you up by 1 knob, resulting in a wider or longer enclosure.
_l_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Board surround ratio
_w_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Enclosure height
_h = 1; // [1:1:20]

// Create the left wall
_left_wall_enabled = true;

// Shoud there be knobs on top of the left wall
_left_wall_knobs = false;

// Create the right wall
_right_wall_enabled = true;

// Shoud there be knobs on top of the right wall
_right_wall_knobs = true;

// Create the front wall
_front_wall_enabled = true;

// Shoud there be knobs on top of the front wall
_front_wall_knobs = true;

// Create the back wall
_back_wall_enabled = true;

// Shoud there be knobs on top of the back wall
_back_wall_knobs = true;



/* [Enclosure Features] */

// Filler for the model center space
_center_type = 4; //[0:empty, 1:solid, 2:solid with side holes, 3:solid with end holes, 4:solid with both side and end holes]

// Presence of bottom connector sockets
_sockets = true;

// How far below the bottom of the board to carve empty space 
_undercut = 7; // [0:0.1:20]

// How far in from the outside edges the board support can extend without hitting board bottom surface parts
_innercut = 0.8;

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = false;

// Add full width through holes spaced along the length for techic connectors
_side_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add full width through holes spaced along the width for techic connectors
_end_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around side holes (disable for extra ventilation, enable for lock notch fit)
_side_sheaths = true;

// Add a wrapper around end holes  (disable for extra ventilation but loose lock notches)
_end_sheaths = true;

// Additional space added in every direction around the printed circuit board
_pcb_skin = 0.1; // [0:0.01:1]

// Add interior fill for the base layer
_solid_first_layer = false;

// Add interior fill for the upper layers
_solid_upper_layers = true;

// Shift the PCB board relative to the enclosure on the X axis [mm]
_board_x_offset = 0; // [-8:0.1:8]

// Shift the PCB board relative to the enclosure on the X axis [mm]
_board_y_offset = 0; // [-8:0.1:8]

// Bevel the outside edges above the board space inward to make upper structures like knobs more printable
_dome = true;

// Number of knobs at the edge of a bottom panel to omit (this will leave space for example for a nearby top wall or technic connectors)
_skip_edge_knobs = 1;



/* [Bottom Features] */


// Bottom of enclosure
_bottom_type = 1; // [1:solid bottom, 2:socket panel bottom, 3:knob panel bottom]

// Enable knobs in the bottom (if knob panel bottom)
_bottom_knobs = true;

// Add holes in the bottom deck to improve airflow and reduce weight (only used with bottom_type == 3, knob panel)
_bottom_vents = true;




/* [Left Cut] */

// Distance of the front of left side hole [mm]
_left_cutout_y = 4; // [0:0.1:200]

// Width of the left side hole [mm]
_left_cutout_width = 0; // [0:0.1:200]

// Depth of the left side hole [mm]
_left_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the left side hole [mm]
_left_cutout_z = 4; // [0:0.1:200]

// Height of the left side hole [mm]
_left_cutout_height = 8; // [0:0.1:200]



/* [Right Cut] */

// Distance of the front of right side hole [mm]
_right_cutout_y = 4; // [0:0.1:200]

// Width of the right side hole [mm]
_right_cutout_width = 0; // [0:0.1:200]

// Depth of the right side hole [mm]
_right_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the right side hole [mm]
_right_cutout_z = 4; // [0:0.1:200]

// Height of the right side hole [mm]
_right_cutout_height = 8; // [0:0.1:200]



/* [Front Cut] */

// Distance of the left of front side hole [mm]
_front_cutout_x = 4; // [0:0.1:200]

// Width of the front side hole [mm]
_front_cutout_width = 0; // [0:0.1:200]

// Depth into the part of the front cut [mm]
_front_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the front side hole [mm]
_front_cutout_z = 4; // [0:0.1:200]

// Height of the front side hole [mm]
_front_cutout_height = 8; // [0:0.1:200]



/* [Back Cut] */

// Distance of the left of back side hole [mm]
_back_cutout_x = 4; // [0:0.1:200]

// Width of the back side hole [mm]
_back_cutout_width = 0; // [0:0.1:200]

// Depth of the back side hole [mm]
_back_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the back side hole [mm]
_back_cutout_z = 4; // [0:0.1:200]

// Height of the back side hole [mm]
_back_cutout_height = 8; // [0:0.1:200]



///////////////////////////////
// DISPLAY
///////////////////////////////

knob_mount(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, length=_length, width=_width, h=_h, thickness=_thickness, innercut=_innercut, undercut=_undercut, center_type=_center_type, bottom_type=_bottom_type, sockets=_sockets, top_vents=_top_vents, side_holes=_side_holes, end_holes=_end_holes, side_sheaths=_side_sheaths, end_sheaths=_end_sheaths, left_wall_enabled=_left_wall_enabled, right_wall_enabled=_right_wall_enabled, front_wall_enabled=_front_wall_enabled, back_wall_enabled=_back_wall_enabled, board_x_offset=_board_x_offset, board_y_offset=_board_y_offset, left_wall_knobs=_left_wall_knobs, right_wall_knobs=_right_wall_knobs, front_wall_knobs=_front_wall_knobs, back_wall_knobs=_back_wall_knobs, dome=_dome, solid_first_layer=_solid_first_layer, solid_upper_layers=_solid_upper_layers, l_pad=_l_pad, w_pad=_w_pad, block_height=_block_height);
