/*
PELA Board Holder - 3D Printed LEGO-compatible PCB mount
For PCA9685 16 Channel 12 bit servo driver board, https://www.amazon.de/gp/product/B07CRDCP8V/ref=oh_aui_detailpage_o01_s00

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

length = 63;
width = 25;
thickness = 1.6;
h = 1;
undercut = 2.3; // How far below the bottom of the board surface parts protude (not indlucing big things like an SD card holder)
innercut = 0.8; // How far in from the outside edges the board support can extend without hitting board bottom surface parts
hold_d = 2.4;
bottom_type = 0;
top_vents = false;
side_holes = 0;
end_holes = 0;
side_sheaths = false;
end_sheaths = false;
left_wall_enabled = true;
right_wall_enabled = true;
front_wall_enabled = true;
back_wall_enabled = true;
drop_bottom = false;
knobs_on_top = true;
left_wall_knobs = false;
right_wall_knobs = true;
front_wall_knobs = true;
back_wall_knobs = true;
solid_upper_layers = false;
solid_bottom_layer = false;

board_x_offset = 0;
board_y_offset = 0;
board_z_offset = -thickness;
sd_card_cutout_width = block_width(3);
sd_card_cutout_depth = 3.8;
sd_card_cutout_offset = -block_width(1/2);
top_edge_height = 2;

dome = true;

///////////
// Display
///////////
pca9685_servo_board_mount();


module pca9685_servo_board_mount(length=length, width=width, h=h, thickness=thickness, undercut=undercut, innercut=innercut, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, drop_bottom=drop_bottom, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, dome=dome) {
    
    board_mount(length=length, width=width, h=h, thickness=thickness, undercut=undercut, innercut=innercut, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, side_sheaths=side_sheaths, end_sheaths=end_sheaths, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, drop_bottom=drop_bottom, board_x_offset=board_x_offset, board_y_offset=board_y_offset, board_z_offset=board_z_offset, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, dome=dome);
}