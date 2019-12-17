/*
PELA Jetson Nano Technic Mount - 3D Printed LEGO-compatible PCB mount with the board held in place by technic beams

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
use <../peg/PELA-technic-peg.scad>
use <../technic-beam/PELA-technic-beam.scad>
use <../technic-beam/PELA-technic-twist-beam.scad>
use <PELA-technic-box.scad>
use <PELA-technic-mount.scad>
use <PELA-jetson-nano-technic-mount.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Jetson Nano] */

// Board space length [mm]
_length = 101;

// Board space width [mm]
_width = 80.5;

// Board space thickness [mm]
_thickness = 0;


/* [Enclosure] */

// Height of the enclosure [blocks]
_h = 3; // [1:1:20]

// Closeness of board fit lengthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)
_l_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Closeness of board fit widthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)
_w_pad = 0; // [0:tight, 1:+1 block, 2:+2 blocks]

// 90 degree rotation from length ends [blocks]
_twist_l = 5; // [1:18]

// 90 degree rotation from width ends [blocks]
_twist_w = 4; // [1:18]

// Step in from board space edges to support the board [mm]
_innercut = 2;

// Step down from board bottom to give room board components [mm]
_undercut = 0; // [0:0.1:100]

// Interior fill style
_center = 5; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]

// Text label
_text = "Jetson Nano";


/* [Enclosure Left Cut] */

// Distance from the front of left side hole [mm]
_left_enclosure_cutout_y = 20; // [0:0.1:200]

// Width of the left side hole [mm]
_left_enclosure_cutout_width = 48; // [0:0.1:200]

// Depth of the left side hole [mm]
_left_enclosure_cutout_depth = 240; // [0:0.1:200]

// Distance from bottom of the left side hole [mm]
_left_enclosure_cutout_z = 8; // [0:0.1:200]

// Height of the left side hole [mm]
_left_enclosure_cutout_height = 32; // [0:0.1:200]



/* [Enclosure Right Cut] */

// Distance from the front of right side hole [mm]
_right_enclosure_cutout_y = 28; // [0:0.1:200]

// Width of the right side hole [mm]
_right_enclosure_cutout_width = 0; // [0:0.1:200]

// Depth of the right side hole [mm]
_right_enclosure_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the right side hole [mm]
_right_enclosure_cutout_z = 8; // [0:0.1:200]

// Height of the right side hole [mm]
_right_enclosure_cutout_height = 24; // [0:0.1:200]



/* [Enclosure Front Cut] */

// Distance from the left of front side hole [mm]
_front_enclosure_cutout_x = 20; // [0:0.1:200]

// Width of the front side hole [mm]
_front_enclosure_cutout_width = 76; // [0:0.1:200]

// Depth into the part of the front cut [mm]
_front_enclosure_cutout_depth = 20; // [0:0.1:200]

// Distance from bottom of the front side hole [mm]
_front_enclosure_cutout_z = 8; // [0:0.1:200]

// Height of the front side hole [mm]
_front_enclosure_cutout_height = 32; // [0:0.1:200]



/* [Enclosure Back Cut] */

// Distance from the left of back side hole [mm]
_back_enclosure_cutout_x = 36; // [0:0.1:200]

// Width of the back side hole [mm]
_back_enclosure_cutout_width = 0; // [0:0.1:200]

// Depth of the back side hole [mm]
_back_enclosure_cutout_depth = 16; // [0:0.1:200]

// Distance from bottom of the back side hole [mm]
_back_enclosure_cutout_z = 6; // [0:0.1:200]

// Height of the back side hole [mm]
_back_enclosure_cutout_height = 37; // [0:0.1:200]


/* [Advanced] */

// Depth of text etching into top surface
_text_depth = 0.8; // [0.0:0.1:2]

/// Bevel the outside edges above the board space inward to make upper structures like knobs more printable
_dome = true;

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid [mm]
_horizontal_skin = 0.1; // [0:0.02:0.5]

// Vertical clearance space between two parts to be placed next to one another on a 8mm grid [mm]
_vertical_skin = 0.1; // [0:0.02:0.5]

// How tall are top connectors [mm]
_knob_height = 2.9; // [0:disabled, 1.8:traditional, 2.9:PELA 3D print tall]

// Size of hole in the center of knobs if "center" or "cover center" is "knob panel"
_knob_vent_radius = 0.0; // [0.0:0.1:3.9]

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = false;

// Add two hard points to mount wifi antennas on the back wall
_antenna_mounts = true;

// Make space for the heatsink fan
_heatsink_fan_cutout = true;


/* [Hidden] */

// Text label
_cover_text = "Jetson  Nano";

// Interior fill style
_cover_center = 5; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]

// Height of the cover [blocks]
_cover_h = 1; // [1:1:20]

// Include quarter-round corner hold-downs in the cover
_cover_corner_tabs = false;


///////////////////////////////
// DISPLAY
///////////////////////////////

jetson_nano_technic_mount(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, length=_length, width=_width, thickness=_thickness, h=_h, cover_h=_cover_h, l_pad=_l_pad, w_pad=_w_pad, twist_l=_twist_l, twist_w=_twist_w, knob_height=_knob_height, knob_vent_radius=_knob_vent_radius, top_vents=_top_vents, innercut=_innercut, undercut=_undercut, center=_center, cover_center=_cover_center, text=_text, cover_text=_cover_text, text_depth=_text_depth, left_enclosure_cutout_y=_left_enclosure_cutout_y, left_enclosure_cutout_width=_left_enclosure_cutout_width, left_enclosure_cutout_depth=_left_enclosure_cutout_depth, left_enclosure_cutout_z=_left_enclosure_cutout_z, left_enclosure_cutout_height=_left_enclosure_cutout_height, right_enclosure_cutout_y=_right_enclosure_cutout_y, right_enclosure_cutout_width=_right_enclosure_cutout_width, right_enclosure_cutout_depth=_right_enclosure_cutout_depth, right_enclosure_cutout_z=_right_enclosure_cutout_z, right_enclosure_cutout_height=_right_enclosure_cutout_height, front_enclosure_cutout_x=_front_enclosure_cutout_x, front_enclosure_cutout_width=_front_enclosure_cutout_width, front_enclosure_cutout_depth=_front_enclosure_cutout_depth, front_enclosure_cutout_z=_front_enclosure_cutout_z, front_enclosure_cutout_height=_front_enclosure_cutout_height, back_enclosure_cutout_x=_back_enclosure_cutout_x, back_enclosure_cutout_width=_back_enclosure_cutout_width, back_enclosure_cutout_depth=_back_enclosure_cutout_depth, back_enclosure_cutout_z=_back_enclosure_cutout_z, back_enclosure_cutout_height=_back_enclosure_cutout_height, dome=_dome, horizontal_skin=_horizontal_skin, vertical_skin=_vertical_skin, cover_corner_tabs=_cover_corner_tabs, antenna_mounts=_antenna_mounts, heatsink_fan_cutout=_heatsink_fan_cutout);

module jetson_nano_technic_mount(material, large_nozzle, cut_line, length, width, thickness, h, cover_h, l_pad, w_pad, twist_l, twist_w, knob_height, knob_vent_radius, top_vents, innercut, undercut, center, cover_center, text, cover_text, text_depth, left_enclosure_cutout_y, left_enclosure_cutout_width, left_enclosure_cutout_depth, left_enclosure_cutout_z, left_enclosure_cutout_height, right_enclosure_cutout_y, right_enclosure_cutout_width, right_enclosure_cutout_depth, right_enclosure_cutout_z, right_enclosure_cutout_height, front_enclosure_cutout_x, front_enclosure_cutout_width, front_enclosure_cutout_depth, front_enclosure_cutout_z, front_enclosure_cutout_height, back_enclosure_cutout_x, back_enclosure_cutout_width, back_enclosure_cutout_depth, back_enclosure_cutout_z, back_enclosure_cutout_height, dome, horizontal_skin, vertical_skin, cover_corner_tabs, antenna_mounts, heatsink_fan_cutout) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(length!=undef);
    assert(width!=undef);
    assert(thickness!=undef);
    assert(h!=undef);
    assert(cover_h!=undef);
    assert(l_pad!=undef);
    assert(w_pad!=undef);
    assert(twist_l!=undef);
    assert(twist_w!=undef);
    assert(knob_height!=undef);
    assert(knob_vent_radius!=undef);
    assert(top_vents!=undef);
    assert(innercut!=undef);
    assert(undercut!=undef);
    assert(center!=undef);
    assert(cover_center!=undef);
    assert(text!=undef);
    assert(cover_text!=undef);
    assert(text_depth!=undef);
    assert(left_enclosure_cutout_y!=undef);
    assert(left_enclosure_cutout_width!=undef);
    assert(left_enclosure_cutout_depth!=undef);
    assert(left_enclosure_cutout_z!=undef);
    assert(left_enclosure_cutout_height!=undef);
    assert(right_enclosure_cutout_y!=undef);
    assert(right_enclosure_cutout_width!=undef);
    assert(right_enclosure_cutout_depth!=undef);
    assert(right_enclosure_cutout_z!=undef);
    assert(right_enclosure_cutout_height!=undef);
    assert(front_enclosure_cutout_x!=undef);
    assert(front_enclosure_cutout_width!=undef);
    assert(front_enclosure_cutout_depth!=undef);
    assert(front_enclosure_cutout_z!=undef);
    assert(front_enclosure_cutout_height!=undef);
    assert(back_enclosure_cutout_x!=undef);
    assert(back_enclosure_cutout_width!=undef);
    assert(back_enclosure_cutout_depth!=undef);
    assert(back_enclosure_cutout_z!=undef);
    assert(back_enclosure_cutout_height!=undef);
    assert(dome!=undef);
    assert(horizontal_skin!=undef);
    assert(vertical_skin!=undef);
    assert(cover_corner_tabs!=undef);
    assert(antenna_mounts!=undef);
    assert(heatsink_fan_cutout!=undef);

    l = fit_mm_to_blocks(length, l_pad);
    w = fit_mm_to_blocks(width, w_pad);    

    difference() {
        union() {
            translate([block_width(l-1), block_width(w-1), 0])
                rotate([0,0,180])
                    technic_mount_and_cover(render_modules=0, material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, thickness=thickness, h=h, cover_h=cover_h, l_pad=l_pad, w_pad=w_pad, twist_l=twist_l, twist_w=twist_w, knob_height=knob_height, knob_vent_radius=knob_vent_radius, top_vents=top_vents, innercut=innercut, undercut=undercut, center=center, cover_center=cover_center, text=text, cover_text=cover_text, text_depth=text_depth, left_enclosure_cutout_y=left_enclosure_cutout_y, left_enclosure_cutout_width=left_enclosure_cutout_width, left_enclosure_cutout_depth=left_enclosure_cutout_depth, left_enclosure_cutout_z=left_enclosure_cutout_z, left_enclosure_cutout_height=left_enclosure_cutout_height, right_enclosure_cutout_y=right_enclosure_cutout_y, right_enclosure_cutout_width=right_enclosure_cutout_width, right_enclosure_cutout_depth=right_enclosure_cutout_depth, right_enclosure_cutout_z=right_enclosure_cutout_z, right_enclosure_cutout_height=right_enclosure_cutout_height, front_enclosure_cutout_x=front_enclosure_cutout_x, front_enclosure_cutout_width=front_enclosure_cutout_width, front_enclosure_cutout_depth=front_enclosure_cutout_depth, front_enclosure_cutout_z=front_enclosure_cutout_z, front_enclosure_cutout_height=front_enclosure_cutout_height, back_enclosure_cutout_x=back_enclosure_cutout_x, back_enclosure_cutout_width=back_enclosure_cutout_width, back_enclosure_cutout_depth=back_enclosure_cutout_depth, back_enclosure_cutout_z=back_enclosure_cutout_z, back_enclosure_cutout_height=back_enclosure_cutout_height, dome=dome, horizontal_skin=horizontal_skin, vertical_skin=vertical_skin, cover_corner_tabs=_cover_corner_tabs);

            if (antenna_mounts) {
                antenna_mount_solids(horizontal_skin);
            }
            
            if (heatsink_fan_cutout) {
                heatsink_fan_cutout_brim(horizontal_skin);
            }
        }

        union() {
            if (antenna_mounts) {
                antenna_holes();
            }
            
            if (heatsink_fan_cutout) {
                heatsink_fan_hole(horizontal_skin);
            }
        }
    }
}


module antenna_mount_solids(horizontal_skin) {
    translate([block_width(0), block_width(10.5), block_width(0.6)]) 
        antenna_mount_solid(horizontal_skin);

    translate([block_width(11.75), block_width(-0.5), block_width(0.6)]) 
        antenna_mount_solid(horizontal_skin);

    translate([block_width(11.75), block_width(10.5), block_width(0.6)])
        antenna_mount_solid(horizontal_skin);
}


module antenna_holes() {
    translate([block_width(0.75), block_width(9.5), block_width(0.6)]) 
        antenna_mount_hole();

    translate([block_width(13.25), block_width(1.5), block_width(0.6)])
        rotate([0,0,180])
            antenna_mount_hole();

    translate([block_width(12.25), block_width(9.5), block_width(0.6)]) 
        antenna_mount_hole();
}


fan_size = 5.5;


module heatsink_fan_hole(horizontal_skin) {
    color("black") translate([block_width(4.5), block_width(0.5)-horizontal_skin, 0])
        cube([block_width(fan_size), block_width(fan_size), block_width(1)]);
}


module heatsink_fan_cutout_brim(horizontal_skin) {
    cover_wall_height = 1+panel_height(block_width());
    edge_thickness = 1.4;
    
    color("black") translate([block_width(4.5)-edge_thickness, block_width(0.5)-horizontal_skin, 0])
        cube([block_width(fan_size)+2*edge_thickness, block_width(fan_size)+edge_thickness, cover_wall_height]);    
}
