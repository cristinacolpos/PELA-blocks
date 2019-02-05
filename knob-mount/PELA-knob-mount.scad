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

include <../print-parameters.scad>
include <../style.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../box-enclosure/PELA-box-enclosure.scad>

////////////////////
// Parameters
////////////////////

/* [Knob Mount] */

// Show the inside structure [mm]
cut_line = 0;

// Printing material
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the nozzle >= 0.5mm? If so, some features are larger to make printing easier (and slightly slower)
large_nozzle = true;

length = 30;

width = 20;

thickness = 1.7;

h = 1;

// How far below the bottom of the board surface parts protude 
undercut = 50;

// How far in from the outside edges the board support can extend without hitting board bottom surface parts
innercut = 0.8;

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

left_wall_knobs = true;

right_wall_knobs = true;

front_wall_knobs = true;

back_wall_knobs = true;

pcb_skin = 0.1;

// Add interior fill for the base layer
solid_first_layer = true;

solid_upper_layers = true;

center_type = 4; //[0:empty, 1:solid, 2:solid with side holes, 3:solid with end holes, 4:solid with both side and end holes]

board_x_offset = 0;

board_y_offset = 0;

board_z_offset = -thickness;

// A number from 1 to 2. This is a ratio of 1 block width for the board surround. Smaller numbers mean less space horizontally around the board (it can eat into the surrounding wall knobs). Larger numbers may bump you up by 1 knob, resulting in a wider or longer enclosure.
length_padding = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Board surround ratio
width_padding = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

dome = true;  // Bevel the outside edges above the board space inward to make upper structures like knobs more printable


/* [Hidden] */

bottom_type = 0; // [0:open bottom, 1:solid bottom, 2:socket-panel bottom, 3:knob-panel bottom]


///////////////////////////////
// DISPLAY
///////////////////////////////

board_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, h=h, thickness=thickness, undercut=undercut, innercut=innercut, center_type=center_type, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, dome=dome, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, length_padding=length_padding, width_padding=width_padding, block_height=block_height);



///////////////////////////////////
// MODULES
///////////////////////////////////

module board_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, h=h, thickness=thickness, undercut=undercut, innercut=innercut, center_type=center_type, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, dome=dome, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, length_padding=length_padding, width_padding=width_padding, block_height=block_height) {

    l = fit_mm_to_blocks(length, tightness=length_padding);
    w = fit_mm_to_blocks(width, tightness=width_padding);
    echo("board mount l", l);
    echo("board mount w", w);

    difference() {
        pcb_holder(material=material, large_nozzle=large_nozzle, length=length, width=width, l=l, w=w, h=h, thickness=thickness, undercut=undercut, innercut=innercut, center_type=center_type, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, block_height=block_height);

        z1 = block_height(h, block_height=block_height)+board_z_offset;
        z2 = board_z_offset;

        union() {
            pcb_space_skinned(material=material, large_nozzle=large_nozzle, z=z1, length=length, width=width, l=l, w=w, h=h, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, dome=dome, block_height=block_height);

            if (bottom_type == 0) {
                pcb_space_skinned(material=material, large_nozzle=large_nozzle, z=z2, length=length, width=width, l=l, w=w, h=h, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, dome=dome, block_height=block_height);
            }
        }
    }    
}


// Cutout for the board
module pcb_space(material=material, large_nozzle=large_nozzle, z, length=length, width=width, l, w, h=h, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, dome=dome, block_height=block_height) {

    x_inset = (block_width(l) - length)/2;
    y_inset = (block_width(w) - width)/2;

    translate([x_inset + board_x_offset, y_inset + board_y_offset, z]) {
        if (dome) {
            hull() {
                cube([length, width, thickness]);

                i = block_width(0.5);
                translate([i, i, 0]) {
                    cube([length-2*i, width-2*i, 1.5*i]);
                }
            }
        } else {
            cube([length, width, thickness]);
        }
    }

    // Undercut space for board bottom
    xu_inset = x_inset + innercut;
    yu_inset = y_inset + innercut;

    u = center_type > 0 ? min(undercut, block_height(0.5, block_height=block_height) - thickness) : undercut;
    translate([xu_inset + board_x_offset, yu_inset + board_y_offset, block_height(h, block_height=block_height)+board_z_offset-u]) {
        cube([length - 2*innercut, width - 2*innercut, u]);
    }
}


module pcb_space_skinned(material=material, large_nozzle=large_nozzle, z, pcb_skin=pcb_skin, length=length, l, w, h=h, width=width, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, dome=dome, block_height=block_height) {

    minkowski() {
        pcb_space(material=material, large_nozzle=large_nozzle, z=z, length=length, width=width, l=l, w=w, h=h, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, block_height=block_height);

        sphere(r=pcb_skin, $fn=16);
    }
}


module pcb_holder(material=material, large_nozzle=large_nozzle, length=length, width=width, thickness=thickness, l, w, h=h, undercut=undercut, innercut=innercut, center_type=center_type, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, block_height=block_height) {

    PELA_box_enclosure(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, bottom_type=bottom_type, center_type=center_type, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, side_shell=side_shell, ridge_z_offset=ridge_z_offset, block_height=block_height);
}


// Optional inside cuts downward to allow headers on the board bottom not to rub on the insides of the enclosure. Used only by some models.
module bottom_header_space(material=material, large_nozzle=large_nozzle, l, w, width=width, block_height=block_height) {
    down_cut_width = max(width, block_width(w-2));
    w2 = (block_width(w) - down_cut_width) / 2;

    translate([block_width(1.5), w2, 0]) {
        cube([block_width(l-3), down_cut_width, block_height(2, block_height=block_height)]);
    }
}
