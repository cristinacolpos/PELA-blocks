/*
PELA Board Holder - 3D Printed LEGO-compatible PCB mount

Published at https://driftcar.PELAblocks.org

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

////////////////////
// Parameters
////////////////////

length = 85;
width = 56;
thickness = 1.6;
h = 1;
undercut = 2.3; // How far below the bottom of the board surface parts protude (not indlucing big things like an SD card holder)
innercut = 0.8; // How far in from the outside edges the board support can extend without hitting board bottom surface parts
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
left_wall_knobs = true;
right_wall_knobs = true;
front_wall_knobs = true;
back_wall_knobs = true;
pcb_skin = 0.1;

board_x_offset = 1.9;
board_y_offset = -3;
board_z_offset = -0.2;


///////////
// Display
///////////

difference() {
    pcb_holder(length=length, width=width, h=h, thickness=thickness, undercut=undercut, innercut=innercut, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, drop_bottom=drop_bottom, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs);

#    pcb_space_skinned(length=length, width=width, h=h, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset);
}    


// Find the dimensions of the optimum holder based on board length or width
function fit_mm_to_pela_blocks(i) = ceil((i+block_width)/block_width);


module pcb_space(length=length, width=width, h=h, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset) {

    l = fit_mm_to_pela_blocks(length);
    w = fit_mm_to_pela_blocks(width);
    x_inset = (block_width(l) - length)/2;
    y_inset = (block_width(w) - width)/2;

    translate([x_inset + board_x_offset, y_inset + board_y_offset, block_height(h)+board_z_offset]) {
        cube([length, width, thickness]);
    }

    // Undercut space for board bottom
    xu_inset = x_inset + innercut;
    yu_inset = y_inset + innercut;
    translate([xu_inset + board_x_offset, yu_inset + board_y_offset, block_height(h)+board_z_offset-undercut]) {
        cube([length - 2*innercut, width - 2*innercut, undercut]);
    }
}


module pcb_space_skinned(pcb_skin=pcb_skin, length=length, h=h, width=width, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset) {

    minkowski() {
        pcb_space(length=length, width=width, h=h, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset);

        sphere(r=pcb_skin, $fn=16);
    }
}


module pcb_holder(length=length, width=width, thickness=thickness, h=h, undercut=undercut, innercut=innercut, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, drop_bottom=drop_bottom, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs) {

    l = fit_mm_to_pela_blocks(length);
    w = fit_mm_to_pela_blocks(width);
    echo("l", l);
    echo("w", w);

    PELA_box_enclosure(l=l, w=w, h=h, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, drop_bottom=drop_bottom, solid_upper_layers=solid_upper_layers, shell=shell);
}
