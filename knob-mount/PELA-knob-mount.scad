/*
PELA Board Holder - 3D Printed LEGO-compatible PCB mount

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

////////////////////
// Parameters
////////////////////


/* [Render] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;



/* [Board] */

// PCB length [mm]
length = 30; // [0.1:0.1:300]

// PCB width [mm]
width = 20; // [0.1:0.1:300]

// PCB thickness [mm]
thickness = 1.8; // [0.1:0.1:300]



/* [Enclosure] */

// A number from 1 to 2. This is a ratio of 1 block width for the board surround. Smaller numbers mean less space horizontally around the board (it can eat into the surrounding wall knobs). Larger numbers may bump you up by 1 knob, resulting in a wider or longer enclosure.
l_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Board surround ratio
w_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Enclosure height
h = 1; // [1:1:20]

// Create the left wall
left_wall_enabled = true;

// Shoud there be knobs on top of the left wall
left_wall_knobs = true;

// Create the right wall
right_wall_enabled = true;

// Shoud there be knobs on top of the right wall
right_wall_knobs = true;

// Create the front wall
front_wall_enabled = true;

// Shoud there be knobs on top of the front wall
front_wall_knobs = true;

// Create the back wall
back_wall_enabled = true;

// Shoud there be knobs on top of the back wall
back_wall_knobs = true;



/* [Enclosure Features] */

// Filler for the model center space
center_type = 4; //[0:empty, 1:solid, 2:solid with side holes, 3:solid with end holes, 4:solid with both side and end holes]

// Presence of bottom connector sockets
sockets = true;

// How far below the bottom of the board to carve empty space 
undercut = 7; // [0:0.1:20]

// How far in from the outside edges the board support can extend without hitting board bottom surface parts
innercut = 0.8;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

// Add full width through holes spaced along the length for techic connectors
side_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add full width through holes spaced along the width for techic connectors
end_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around side holes (disable for extra ventilation, enable for lock notch fit)
side_sheaths = true;

// Add a wrapper around end holes  (disable for extra ventilation but loose lock notches)
end_sheaths = true;

// Additional space added in every direction around the printed circuit board
pcb_skin = 0.1; // [0:0.01:1]

// Add interior fill for the base layer
solid_first_layer = false;

// Add interior fill for the upper layers
solid_upper_layers = true;

// Shift the PCB board relative to the enclosure on the X axis [mm]
board_x_offset = 0; // [-8:0.1:8]

// Shift the PCB board relative to the enclosure on the X axis [mm]
board_y_offset = 0; // [-8:0.1:8]

// Bevel the outside edges above the board space inward to make upper structures like knobs more printable
dome = true;

// Number of knobs at the edge of a bottom panel to omit (this will leave space for example for a nearby top wall or technic connectors)
skip_edge_knobs = 1;



/* [Bottom Features] */


// Bottom of enclosure
bottom_type = 1; // [1:solid bottom, 2:socket panel bottom, 3:knob panel bottom]

// Enable knobs in the bottom (if knob panel bottom)
bottom_knobs = true;

// Add holes in the bottom deck to improve airflow and reduce weight (only used with bottom_type == 3, knob panel)
bottom_vents = true;




/* [Left Cut] */

// Distance from the front of left side hole [mm]
left_cutout_y = 4; // [0:0.1:200]

// Width of the left side hole [mm]
left_cutout_width = 0; // [0:0.1:200]

// Depth of the left side hole [mm]
left_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the left side hole [mm]
left_cutout_z = 4; // [0:0.1:200]

// Height of the left side hole [mm]
left_cutout_height = 8; // [0:0.1:200]



/* [Right Cut] */

// Distance from the front of right side hole [mm]
right_cutout_y = 4; // [0:0.1:200]

// Width of the right side hole [mm]
right_cutout_width = 0; // [0:0.1:200]

// Depth of the right side hole [mm]
right_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the right side hole [mm]
right_cutout_z = 4; // [0:0.1:200]

// Height of the right side hole [mm]
right_cutout_height = 8; // [0:0.1:200]



/* [Front Cut] */

// Distance from the left of front side hole [mm]
front_cutout_x = 4; // [0:0.1:200]

// Width of the front side hole [mm]
front_cutout_width = 0; // [0:0.1:200]

// Depth into the part of the front cut [mm]
front_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the front side hole [mm]
front_cutout_z = 4; // [0:0.1:200]

// Height of the front side hole [mm]
front_cutout_height = 8; // [0:0.1:200]



/* [Back Cut] */

// Distance from the left of back side hole [mm]
back_cutout_x = 4; // [0:0.1:200]

// Width of the back side hole [mm]
back_cutout_width = 0; // [0:0.1:200]

// Depth of the back side hole [mm]
back_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the back side hole [mm]
back_cutout_z = 4; // [0:0.1:200]

// Height of the back side hole [mm]
back_cutout_height = 8; // [0:0.1:200]



///////////////////////////////
// DISPLAY
///////////////////////////////

knob_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, h=h, thickness=thickness, innercut=innercut, undercut=undercut, center_type=center_type, bottom_type=bottom_type, sockets=sockets, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, board_x_offset=board_x_offset, board_y_offset=board_y_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, dome=dome, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, l_pad=l_pad, w_pad=w_pad, block_height=block_height);



///////////////////////////////////
// MODULES
///////////////////////////////////

module knob_mount(material=undef, large_nozzle=undef, cut_line=undef, length=undef, width=undef, h=undef, thickness=undef, innercut=undef, undercut=undef, center_type=undef, bottom_type=undef, sockets=undef, top_vents=undef, side_holes=undef, end_holes=undef, side_sheaths=undef, end_sheaths=undef, left_wall_enabled=undef, right_wall_enabled=undef, front_wall_enabled=undef, back_wall_enabled=undef, board_x_offset=undef, board_y_offset=undef, left_wall_knobs=undef, right_wall_knobs=undef, front_wall_knobs=undef, back_wall_knobs=undef, dome=undef, solid_first_layer=undef, solid_upper_layers=undef, l_pad=undef, w_pad=undef, block_height=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(length!=undef);
    assert(width!=undef);
    assert(h!=undef);
    assert(thickness!=undef);
    assert(innercut!=undef);
    assert(undercut!=undef);
    assert(center_type!=undef);
    assert(bottom_type!=undef);
    assert(bottom_type!=0);
    assert(sockets!=undef);
    assert(top_vents!=undef);
    assert(side_holes!=undef);
    assert(end_holes!=undef);
    assert(side_sheaths!=undef);
    assert(end_sheaths!=undef);
    assert(left_wall_enabled!=undef);
    assert(right_wall_enabled!=undef);
    assert(front_wall_enabled!=undef);
    assert(back_wall_enabled!=undef);
    assert(board_x_offset!=undef);
    assert(board_y_offset!=undef);
    assert(left_wall_knobs!=undef);
    assert(right_wall_knobs!=undef);
    assert(front_wall_knobs!=undef);
    assert(back_wall_knobs!=undef);
    assert(dome!=undef);
    assert(solid_first_layer!=undef);
    assert(solid_upper_layers!=undef);
    assert(l_pad!=undef);
    assert(w_pad!=undef);
    assert(block_height!=undef);

    l = fit_mm_to_blocks(length, l_pad);
    w = fit_mm_to_blocks(width, w_pad);
    echo("board mount l", l);
    echo("board mount w", w);

    difference() {
        box_enclosure(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, bottom_type=bottom_type, sockets=sockets, bottom_vents=bottom_vents, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, bottom_knobs=bottom_knobs, skip_edge_knobs=skip_edge_knobs, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, ridge_z_offset=ridge_z_offset, center_type=center_type, block_height=block_height, knob_vent_radius=knob_vent_radius, left_cutout_y=left_cutout_y, left_cutout_width=left_cutout_width, left_cutout_depth=left_cutout_depth, left_cutout_z=left_cutout_z, left_cutout_height=left_cutout_height, right_cutout_y=right_cutout_y, right_cutout_width=right_cutout_width, right_cutout_depth=right_cutout_depth, right_cutout_z=right_cutout_z, right_cutout_height=right_cutout_height, front_cutout_x=front_cutout_x, front_cutout_width=front_cutout_width, front_cutout_depth=front_cutout_depth, front_cutout_z=front_cutout_z, front_cutout_height=front_cutout_height, back_cutout_x=back_cutout_x, back_cutout_width=back_cutout_width, back_cutout_depth=back_cutout_depth, back_cutout_z=back_cutout_z, back_cutout_height=back_cutout_height);

        z = block_height(h, block_height) - thickness;

        pcb_space_skinned(material=material, large_nozzle=large_nozzle, z=z, length=length, width=width, thickness=thickness, l=l, w=w, h=h, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, dome=dome, block_height=block_height);
    }
}


// Cutout for the board
module pcb_space(material=material, large_nozzle=large_nozzle, z=undef, length=length, width=width, l=undef, w=undef, h=h, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, dome=dome, block_height=block_height) {

    x_inset = (block_width(l) - length)/2;
    y_inset = (block_width(w) - width)/2;

    translate([x_inset + board_x_offset, y_inset + board_y_offset, z]) {
        dome(dome=dome, length=length, width=width, thickness=thickness);
    }

    // Undercut space for board bottom
    xu_inset = x_inset + innercut;
    yu_inset = y_inset + innercut;

    if (undercut > 0) {
        translate([xu_inset + board_x_offset, yu_inset + board_y_offset, block_height(h, block_height) - thickness - undercut]) {
            cube([length - 2*innercut, width - 2*innercut, undercut]);
        }
    }
}


module pcb_space_skinned(material=material, large_nozzle=large_nozzle, z=undef, pcb_skin=pcb_skin, length=length, width=width, thickness=thickness, l=undef, w=undef, h=h, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, dome=dome, block_height=block_height) {

    assert(l != undef);
    assert(w != undef);
    assert(z != undef);

    minkowski() {
        pcb_space(material=material, large_nozzle=large_nozzle, z=z, length=length, width=width, l=l, w=w, h=h, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, block_height=block_height);

        sphere(r=pcb_skin, $fn=16);
    }
}


// Optional inside cuts downward to allow headers on the board bottom not to rub on the insides of the enclosure. Used only by some models.
module bottom_header_space(material=material, large_nozzle=large_nozzle, l, w, width=width, block_height=block_height) {

    down_cut_width = max(width, block_width(w-2));
    w2 = (block_width(w) - down_cut_width) / 2;

    translate([block_width(1.5), w2, 0]) {
        cube([block_width(l-3), down_cut_width, block_height(2, block_height=block_height)]);
    }
}
