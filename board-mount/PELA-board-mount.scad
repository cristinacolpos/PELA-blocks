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

////////////////////
// Parameters
////////////////////

length = 85;
width = 56;
thickness = 1.6;
l = fit_mm_to_pela_blocks(85);
w = fit_mm_to_pela_blocks(56);
h = 1;
undercut = 2.3; // How far below the bottom of the board surface parts protude (not indlucing big things like an SD card holder)
innercut = 0.8; // How far in from the outside edges the board support can extend without hitting board bottom surface parts
bottom_type = 2;
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
front_wall_knobs = false;
back_wall_knobs = true;
pcb_skin = 0.1;
solid_bottom_layer = true;
solid_upper_layers = true;

board_x_offset = 0;
board_y_offset = 0;
board_z_offset = -0.2;

dome = true;  // Bevel the outside edges above the board space inward to make upper structures like knobs more printable

///////////
// Display
///////////

board_mount();

///////////////


// Find the dimensions of the optimum holder based on board length or width
function fit_mm_to_pela_blocks(i) = ceil((i+(block_width()))/block_width());


module board_mount(length=length, width=width, h=h, thickness=thickness, undercut=undercut, innercut=innercut, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, drop_bottom=drop_bottom, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, dome=dome, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers) {

    l = fit_mm_to_pela_blocks(length);
    w = fit_mm_to_pela_blocks(width);

    difference() {
        pcb_holder(length=length, width=width, l=l, w=w, h=h, thickness=thickness, undercut=undercut, innercut=innercut, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, drop_bottom=drop_bottom, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers);

#        pcb_space_skinned(length=length, width=width, l=l, w=w, h=h, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, dome=dome);
    }    
}


// Cutout for the board
module pcb_space(length=length, width=width, l, w, h=h, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, dome=dome) {

    x_inset = (block_width(l) - length)/2;
    y_inset = (block_width(w) - width)/2;

    translate([x_inset + board_x_offset, y_inset + board_y_offset, block_height(h)+board_z_offset]) {
        if (dome) {
            hull() {
                cube([length, width, thickness]);

                i = block_width(0.5);
                translate([i, i, 0]) {
                    cube([length-2*i, width-2*i, i]);
                }
            }
        } else {
            cube([length, width, thickness]);
        }
    }

    // Undercut space for board bottom
    xu_inset = x_inset + innercut;
    yu_inset = y_inset + innercut;
    translate([xu_inset + board_x_offset, yu_inset + board_y_offset, block_height(h)+board_z_offset-undercut]) {
        cube([length - 2*innercut, width - 2*innercut, undercut]);
    }
}


module pcb_space_skinned(pcb_skin=pcb_skin, length=length, l, w, h=h, width=width, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset) {

    minkowski() {
        pcb_space(length=length, width=width, l=l, w=w, h=h, thickness=thickness, undercut=undercut, innercut=innercut, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset);

        sphere(r=pcb_skin, $fn=16);
    }
}


module pcb_holder(length=length, width=width, thickness=thickness, l, w, h=h, undercut=undercut, innercut=innercut, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, drop_bottom=drop_bottom, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers) {

    echo("l", l);
    echo("w", w);
    echo("front_wall_enabled", front_wall_enabled);

    PELA_box_enclosure(l=l, w=w, h=h, bottom_type=bottom_type, panel_height=panel_height, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, knob_flexture_radius=knob_flexture_radius, drop_bottom=drop_bottom, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, ridge_z_offset=ridge_z_offset);
}