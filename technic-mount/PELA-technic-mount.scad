/*
PELA Technic Board Mount - 3D Printed LEGO-compatible PCB mount used for including printed ciruit boards in technic models

This is a library module used by other models

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

include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../knob-mount/PELA-box-enclosure.scad>
use <../technic-beam/PELA-technic-beam.scad>
use <../technic-beam/PELA-technic-twist-beam.scad>
use <../knob-mount/PELA-box-enclosure.scad>
use <PELA-technic-box.scad>


/* [Render] */

// Show the inside structure [mm]

_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
<<<<<<< HEAD
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]
=======
material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]
>>>>>>> master

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

// Select parts to render
_render_modules = 2; // [0:technic mount, 1:technic cover, 2:technic mount and cover]



/* [Board] */

// Board space length [mm]
_length = 39.5; // [0:0.1:300]

// Board space width [mm]
_width = 39.5; // [0:0.1:300]

// Board space height [mm]
_thickness = 1.8; // [0:0.1:300]



/* [Enclosure] */

// Distance from length ends of connector twist [blocks]
_twist_l = 1; // [1:18]

// Distance from width ends of connector twist [blocks]
_twist_w = 2; // [1:18]

// Closeness of board fit lengthwise [blocks]
_l_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Closeness of board fit widthwise [blocks]
_w_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Height of the enclosure [blocks]
_h = 1; // [1:1:20]

// Interior fill style
_center = 2; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel]]

// Step in from board space edges to support the board [mm]
_innercut = 1.0; // [0:0.1:100]

// Step down from board bottom to give room board components [mm]
_undercut = 1.0; // [0:0.1:100]

// Presence of sockets if center is "socket panel"
_center_sockets = true;

// Presence of knobs if center is "knob panel"
_center_knobs = true;

// Size of hole in the center of knobs if "center" or "cover center" is "knob panel"
_knob_vent_radius = 0.0; // [0.0:0.1:3.9]

// Text label
_text = "Mount";

// Depth of text etching into top surface
_text_depth = 0.5; // [0.0:0.1:2]

// Bevel the outside edges above the board space inward to make upper structures like knobs more printable
_dome = true;



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

// Depth of the depth side hole [mm]
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



/* [Cover] */

// Text label
_cover_text = "Cover";

// Interior fill style
_cover_center = 5; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel]

// Height of the cover [blocks]
_cover_h = 1; // [1:1:20]

// Presence of sockets if "cover center" is "socket panel"
_cover_sockets = true;

// Presence of knobs if "cover center" is "knob panel"
_cover_knobs = true;




/* [Hidden] */

// Basic unit vertical size of each block
_block_height = 8; // This is not adjuestable due to twist beam technic hole rotation



///////////////////////////////
// DISPLAY
///////////////////////////////

technic_mount_and_cover(render_modules=_render_modules, material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, length=_length, width=_width, thickness=_thickness, h=_h, cover_h=_cover_h, l_pad=_l_pad, w_pad=_w_pad, twist_l=_twist_l, twist_w=_twist_w, center_sockets=_center_sockets, center_knobs=_center_knobs, cover_sockets=_cover_sockets, cover_knobs=_cover_knobs, knob_vent_radius=_knob_vent_radius, solid_first_layer=_solid_first_layer, innercut=_innercut, undercut=_undercut, center=_center, cover_center=_cover_center, text=_text, cover_text=_cover_text, text_depth=_text_depth, left_cutout_y=_left_cutout_y, left_cutout_width=_left_cutout_width, left_cutout_depth=_left_cutout_depth, left_cutout_z=_left_cutout_z, left_cutout_height=_left_cutout_height, right_cutout_y=_right_cutout_y, right_cutout_width=_right_cutout_width, right_cutout_depth=_right_cutout_depth, right_cutout_z=_right_cutout_z, right_cutout_height=_right_cutout_height, front_cutout_x=_front_cutout_x, front_cutout_width=_front_cutout_width, front_cutout_depth=_front_cutout_depth, front_cutout_z=_front_cutout_z, front_cutout_height=_front_cutout_height, back_cutout_x=_back_cutout_x, back_cutout_width=_back_cutout_width, back_cutout_depth=_back_cutout_depth, back_cutout_z=_back_cutout_z, back_cutout_height=_back_cutout_height, dome=_dome);



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_mount_and_cover(render_modules=undef, material=undef, large_nozzle=undef, cut_line=undef, length=undef, width=undef, thickness=undef, h=undef, cover_h=undef, l_pad=undef, w_pad=undef, twist_l=undef, twist_w=undef, center_sockets=undef, center_knobs=undef, cover_sockets=undef, cover_knobs=undef, knob_vent_radius=undef, solid_first_layer=undef, innercut=undef, undercut=undef, center=undef, cover_center=undef, text=undef, cover_text=undef, text_depth=undef, left_cutout_y=undef, left_cutout_width=undef, left_cutout_depth=undef, left_cutout_z=undef, left_cutout_height=undef, right_cutout_y=undef, right_cutout_width=undef, right_cutout_depth=undef, right_cutout_z=undef, right_cutout_height=undef, front_cutout_x=undef, front_cutout_width=undef, front_cutout_depth=undef, front_cutout_z=undef, front_cutout_height=undef, back_cutout_x=undef, back_cutout_width=undef, back_cutout_depth=undef, back_cutout_z=undef, back_cutout_height=undef, dome=dome) {

    assert(render_modules != undef);
    assert(material != undef);
    assert(large_nozzle != undef);
    assert(cut_line != undef);
    assert(length != undef);
    assert(width != undef);
    assert(thickness != undef);
    assert(h != undef);
    assert(cover_h != undef);
    assert(render_modules != undef);
    assert(render_modules != undef);
    assert(render_modules != undef);
    assert(render_modules != undef);
    assert(render_modules != undef);
    assert(l_pad == floor(l_pad), "l_pad must be an integer");
    assert(l_pad >= 0);
    assert(l_pad <= 2);
    assert(w_pad == floor(w_pad), "w_pad must be an integer");
    assert(w_pad >= 0);
    assert(w_pad <= 2);
    assert(text != undef);
    assert(text_depth != undef);
    assert(center_sockets != undef);
    assert(cover_sockets != undef);
    assert(center_knobs != undef);
    assert(cover_knobs != undef);
    assert(knob_vent_radius != undef);
    assert(solid_first_layer != undef);
    assert(innercut != undef);
    assert(undercut != undef);
    assert(center != undef);
    assert(cover_center != undef);
    assert(text != undef);
    assert(cover_text != undef);
    assert(text_depth != undef);
    assert(left_cutout_y != undef);
    assert(left_cutout_width != undef);
    assert(left_cutout_depth != undef);
    assert(left_cutout_z != undef);
    assert(left_cutout_height != undef);
    assert(right_cutout_y != undef);
    assert(right_cutout_width != undef);
    assert(right_cutout_depth != undef);
    assert(right_cutout_z != undef);
    assert(right_cutout_height != undef);
    assert(front_cutout_x != undef);
    assert(front_cutout_width != undef);
    assert(front_cutout_depth != undef);
    assert(front_cutout_z != undef);
    assert(front_cutout_height != undef);
    assert(back_cutout_x != undef);
    assert(back_cutout_width != undef);
    assert(back_cutout_depth != undef);
    assert(back_cutout_z != undef);
    assert(back_cutout_height != undef);
    assert(dome != undef);

    l = max(fit_mm_to_blocks(length, l_pad));
    w = max(2, fit_mm_to_blocks(width, w_pad));

    if (render_modules == 1 || render_modules == 2) {
        translate([0, -block_width(w + 1), 0]) {
            technic_box(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=cover_h, twist_l=twist_l, twist_w=twist_w, sockets=cover_sockets, knobs=cover_knobs, knob_vent_radius=knob_vent_radius, solid_first_layer=solid_first_layer, center=cover_center, text=cover_text, text_depth=text_depth, block_height=block_height);
        }
    }

    if (render_modules == 0 || render_modules == 2) {
        technic_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, thickness=thickness, l=l, w=w, h=h, l_pad=l_pad, w_pad=w_pad, twist_l=twist_l, twist_w=twist_w, sockets=center_sockets, knobs=center_knobs, knob_vent_radius=knob_vent_radius, solid_first_layer=solid_first_layer, innercut=innercut, undercut=undercut, center=center, text=text, text_depth=text_depth, left_cutout_y=left_cutout_y, left_cutout_width=left_cutout_width, left_cutout_depth=left_cutout_depth, left_cutout_z=left_cutout_z, left_cutout_height=left_cutout_height, right_cutout_y=right_cutout_y, right_cutout_width=right_cutout_width, right_cutout_depth=right_cutout_depth, right_cutout_z=right_cutout_z, right_cutout_height=right_cutout_height, front_cutout_x=front_cutout_x, front_cutout_width=front_cutout_width, front_cutout_depth=front_cutout_depth, front_cutout_z=front_cutout_z, front_cutout_height=front_cutout_height, back_cutout_x=back_cutout_x, back_cutout_width=back_cutout_width, back_cutout_depth=back_cutout_depth, back_cutout_z=back_cutout_z, back_cutout_height=back_cutout_height, dome=dome);
    }
}


module technic_mount(material=undef, large_nozzle=undef, cut_line=undef, length=undef, width=undef, thickness=undef, l=undef, w=undef, h=undef, l_pad=undef, w_pad=undef, twist_l=undef, twist_w=undef, sockets=undef, knobs=undef, knob_vent_radius=undef, solid_first_layer=undef, innercut=undef, undercut=undef, center=undef, text=undef, text_depth=undef, left_cutout_y=undef, left_cutout_width=undef, left_cutout_depth=undef, left_cutout_z=undef, left_cutout_height=undef, right_cutout_y=undef, right_cutout_width=undef, right_cutout_depth=undef, right_cutout_z=undef, right_cutout_height=undef, front_cutout_x=undef, front_cutout_width=undef, front_cutout_depth=undef, front_cutout_z=undef, front_cutout_height=undef, back_cutout_x=undef, back_cutout_width=undef, back_cutout_depth=undef, back_cutout_z=undef, back_cutout_height=undef, dome=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(length!=undef);
    assert(width!=undef);
    assert(thickness!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(l_pad!=undef);
    assert(w_pad!=undef);
    assert(twist_l!=undef);
    assert(twist_w!=undef);
    assert(sockets!=undef);
    assert(knobs!=undef);
    assert(knob_vent_radius!=undef);
    assert(solid_first_layer!=undef);
    assert(innercut!=undef);
    assert(undercut!=undef);
    assert(center!=undef);
    assert(text!=undef);
    assert(text_depth!=undef);
    assert(left_cutout_y!=undef);
    assert(left_cutout_width!=undef);
    assert(left_cutout_depth!=undef);
    assert(left_cutout_z!=undef);
    assert(left_cutout_height!=undef);
    assert(right_cutout_y!=undef);
    assert(right_cutout_width!=undef);
    assert(right_cutout_depth!=undef);
    assert(right_cutout_z!=undef);
    assert(right_cutout_height!=undef);
    assert(front_cutout_x!=undef);
    assert(front_cutout_width!=undef);
    assert(front_cutout_depth!=undef);
    assert(front_cutout_z!=undef);
    assert(front_cutout_height!=undef);
    assert(back_cutout_x!=undef);
    assert(back_cutout_width!=undef);
    assert(back_cutout_depth!=undef);
    assert(back_cutout_z!=undef);
    assert(back_cutout_height!=undef);
    assert(dome!=undef);

    difference() {
        echo("l", l);
        echo("w", l);

        technic_box(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, twist_l=twist_l, twist_w=twist_w, sockets=sockets, knobs=knobs, knob_vent_radius=knob_vent_radius, solid_first_layer=solid_first_layer, center=center, text=text, text_depth=text_depth, block_height=block_height);
        
        union() {
            if (thickness > 0) {
                color("green") main_board(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, length=length, width=width, thickness=thickness, dome=dome);
            }

            translate([innercut, innercut, 0]) {            
                main_board_back(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, length=length, width=width, thickness=thickness, innercut=innercut, undercut=undercut);
            }

            wall_cutouts(l=l, w=w, left_cutout_y=left_cutout_y, left_cutout_width=left_cutout_width, left_cutout_depth=left_cutout_depth, left_cutout_z=left_cutout_z, left_cutout_height=left_cutout_height, right_cutout_y=right_cutout_y, right_cutout_width=right_cutout_width, right_cutout_depth=right_cutout_depth, right_cutout_z=right_cutout_z, right_cutout_height=right_cutout_height, front_cutout_x=front_cutout_x, front_cutout_width=front_cutout_width, front_cutout_depth=front_cutout_depth, front_cutout_z=front_cutout_z, front_cutout_height=front_cutout_height, back_cutout_x=back_cutout_x, back_cutout_width=back_cutout_width, back_cutout_depth=back_cutout_depth, back_cutout_z=back_cutout_z, back_cutout_height=back_cutout_height);

            translate([block_width(-0.5), block_width(-0.5), 0]) {
                
                cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, cut_line=cut_line, block_height=block_height, knob_height=knob_height);
            }
        }
    }

    if (thickness > 0) {
        % color("green", 0.2) difference() {
            main_board(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, length=length, width=width, thickness=thickness, dome=dome);
        }

        translate([block_width(-0.5), block_width(-0.5), 0]) {
                
            cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, cut_line=cut_line, block_height=block_height, knob_height=knob_height);
        }
    }
}


module main_board(material=undef, large_nozzle=undef, l=undef, w=undef, h=undef, length=undef, width=undef, thickness=undef, dome=undef) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(length!=undef);
    assert(width!=undef);
    assert(thickness!=undef);
    assert(dome!=undef);

    l2 = block_width(l-1);
    w2 = block_width(w-1);
    hl = l2/2 - length/2;
    hw = w2/2 - width/2;

    translate([hl, hw, block_height(h, block_height) - thickness]) {
        dome(dome=dome, length=length, width=width, thickness=thickness+_defeather);
    }
}


module main_board_back(material=undef, large_nozzle=undef, l=undef, w=undef, h=undef, length=undef, width=undef, thickness=undef, innercut=undef, undercut=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(length!=undef);
    assert(width!=undef);
    assert(thickness!=undef);
    assert(innercut!=undef);
    assert(undercut!=undef);

    l2 = block_width(l-1);
    w2 = block_width(w-1);
    hl = l2/2 - length/2 - innercut;
    hw = w2/2 - width/2 - innercut;

    translate([hl+innercut, hw+innercut, block_height(h, block_height) - thickness - undercut]) {
        
        cube ([length-2*innercut, width-2*innercut, undercut + 2*_defeather]);
    }
}
