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

include <../PELA-print-parameters.scad>
include <../PELA-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <PELA-board-mount.scad>

////////////////////
// Parameters
////////////////////

length = 85;
width = 56;
thickness = 1.6;
h = 1 + 1/3;
undercut = 2.3; // How far below the bottom of the board surface parts protude (not indlucing big things like an SD card holder)
innercut = 0.8; // How far in from the outside edges the board support can extend without hitting board bottom surface parts
hold_d = 2.4;
bottom_type = 0;
top_vents = false;
side_holes = 2;
end_holes = 2;
side_sheaths = true;
end_sheaths = true;
left_wall_enabled = true;
right_wall_enabled = true;
front_wall_enabled = true;
back_wall_enabled = true;
drop_bottom = false;
knobs_on_top = true;
left_wall_knobs = true;
right_wall_knobs = false;
front_wall_knobs = false;
back_wall_knobs = true;

board_x_offset = 1.9;
board_y_offset = -3;
board_z_offset = -0.2;
sd_card_cutout_width = block_width(3);
sd_card_cutout_depth = 3.8;
sd_card_cutout_offset = -block_width(1/2);
top_edge_height = 2;

///////////
// Display
///////////



difference() {
    pcb_holder(length=length, width=width, h=h, thickness=thickness, undercut=undercut, innercut=innercut, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, drop_bottom=drop_bottom, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs);
    
    union() {
#        pcb_space_skinned(length=length, width=width, h=h, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset);
        sd_card_cutout();
    }
}


module sd_card_cutout() {
    w = fit_mm_to_pela_blocks(width);

    translate([-0.1, sd_card_cutout_offset + (block_width(w)-sd_card_cutout_width)/2, block_height(h)-sd_card_cutout_depth]) {
        cube([block_width(2), sd_card_cutout_width, block_height(2)]);
    }
}


module pi_case_sides() {
    l = fit_mm_to_pela_blocks(length);
    w = fit_mm_to_pela_blocks(width);

    difference() {
        translate([0, 0, block_height(h)]) {
            PELA_box_enclosure(l=l, w=w, h=top_edge_height, bottom_type=0, top_vents=false, side_holes=0, end_holes=0, left_wall_enabled=true, right_wall_enabled=false, front_wall_enabled=false, back_wall_enabled=true, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, drop_bottom=drop_bottom, solid_upper_layers=solid_upper_layers);
        }

#        pcb_space_skinned(length=length, width=width, h=h, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset);
    }
}