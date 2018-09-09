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
x_offset = 1.9;
y_offset = -3;
board_z_offset = -0.2;
sd_card_cutout_width = 16;
sd_card_cutout_depth = panel_height(2);


///////////
// Display
///////////

difference() {
    pcb_holder();
    union() {
        pcb_space();
        sd_card_cutout();
    }
}    


// Find the dimensions of the optimum holder based on board length or width
function fit_mm_to_pela_blocks(i) = ceil((i+block_width)/block_width);


module pcb_space() {
    l = fit_mm_to_pela_blocks(length);
    w = fit_mm_to_pela_blocks(width);
    x_inset = (block_width(l) - length)/2;
    y_inset = (block_width(w) - width)/2;
    translate([x_inset + x_offset, y_inset + y_offset, block_height()+board_z_offset]) {
        cube([length, width, thickness]);
    }

    // Undercut space for board bottom
    xu_inset = x_inset + innercut;
    yu_inset = y_inset + innercut;
    translate([xu_inset + x_offset, yu_inset + y_offset, block_height()+board_z_offset-undercut]) {
        #cube([length - 2*innercut, width - 2*innercut, undercut]);
    }
}


module pcb_space_skinned() {
    minkowski() {
        pcb_holder();
        sphere(r=0.1, $fn=8);
    }
}


module pcb_holder() {
    l = fit_mm_to_pela_blocks(length);
    w = fit_mm_to_pela_blocks(width);
    h = 1;
    left_wall_knobs = knobs_on_top;
    right_wall_knobs = false;
    front_wall_knobs = false;
    back_wall_knobs = knobs_on_top;

    PELA_box_enclosure(l=l, w=w, h=h, bottom_type=bottom_type, panel_height=panel_height, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, drop_bottom=drop_bottom, solid_upper_layers=solid_upper_layers, shell=shell);
}


module sd_card_cutout() {
    w = fit_mm_to_pela_blocks(width);
    translate([-0.1, (block_width(w)-sd_card_cutout_width)/2, block_height()-sd_card_cutout_depth]) {
        cube([block_width(2), sd_card_cutout_width, block_height(2)]);
    }
}