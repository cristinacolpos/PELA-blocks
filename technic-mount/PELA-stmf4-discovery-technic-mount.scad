/*
STMF4 Discovery Mount - 3D Printed LEGO-compatible mount for a printed cricuit board

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
use <PELA-technic-mount.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100] 

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex, 10:Polycarbonite]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

// Select parts to render
_render_modules = 2; // [0:mount, 1:cover, 2:mount and cover]


/* [Board] */

// Board space length [mm]
_length = 97.7; // [0:1:300] 

// Board space width [mm]
_width = 66.3; // [0:1:300]

// Board space thickness [mm]
_thickness = 1.8; // [0:0.1:8]


/* [Enclosure] */

_l_pad = 0; // [0:tight, 1:+1 block, 2:+2 blocks] // Closeness of board fit lengthwise inside a ring of blocks [ratio - increase to make outer box slightly larger]

_w_pad = 0; // [0:tight, 1:+1 block, 2:+2 blocks] // Closeness of board fit widthwise inside a ring of blocks [ratio - increase to make outer box slightly larger]

// Height of the enclosure [blocks]
_h = 2; // [1:20]

// How many blocks in from length ends do the technic holes rotate 90 degrees [blocks]
_twist_l = 3; // [1:18]

// How many blocks in from width ends do the technic holes rotate 90 degrees [blocks]
_twist_w = 5; // [1:18]

// Step in from board space edges to support the board [mm]
_innercut = 1.2;

// Step down from board bottom to give room board components [mm]
_undercut = 20.0; // [0:0.1:100]

// Interior fill style
_center = 2; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]]

// Text label
_text = "STMF4 Discovery";



/* [Enclosure Left Cut] */

// Distance from the front of left side hole [mm]
_left_enclosure_cutout_y = 28; // [0:0.1:200]

// Width of the left side hole [mm]
_left_enclosure_cutout_width = 16; // [0:0.1:200]

// Depth of the left side hole [mm]
_left_enclosure_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the left side hole [mm]
_left_enclosure_cutout_z = 8; // [0:0.1:200]

// Height of the left side hole [mm]
_left_enclosure_cutout_height = 10; // [0:0.1:200]



/* [Enclosure Right Cut] */

// Distance from the front of right side hole [mm]
_right_enclosure_cutout_y = 32; // [0:0.1:200]

// Width of the right side hole [mm]
_right_enclosure_cutout_width = 16; // [0:0.1:200]

// Depth of the right side hole [mm]
_right_enclosure_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the right side hole [mm]
_right_enclosure_cutout_z = 8; // [0:0.1:200]

// Height of the right side hole [mm]
_right_enclosure_cutout_height = 10; // [0:0.1:200]



/* [Enclosure Front Cut] */

// Distance from the left of front side hole [mm]
_front_enclosure_cutout_x = 4; // [0:0.1:200]

// Width of the front side hole [mm]
_front_enclosure_cutout_width = 0; // [0:0.1:200]

// Depth into the part of the front cut [mm]
_front_enclosure_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the front side hole [mm]
_front_enclosure_cutout_z = 4; // [0:0.1:200]

// Height of the front side hole [mm]
_front_enclosure_cutout_height = 8; // [0:0.1:200]



/* [Enclosure Back Cut] */

// Distance from the left of back side hole [mm]
_back_enclosure_cutout_x = 4; // [0:0.1:200]

// Width of the back side hole [mm]
_back_enclosure_cutout_width = 0; // [0:0.1:200]

// Depth of the back side hole [mm]
_back_enclosure_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the back side hole [mm]
_back_enclosure_cutout_z = 4; // [0:0.1:200]

// Height of the back side hole [mm]
_back_enclosure_cutout_height = 8; // [0:0.1:200]



/* [Cover] */

// Text label
_cover_text = "STMF4 Discovery";

// Interior fill style
_cover_center = 0; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel, 7:flat planel]

// Height of the cover [blocks]
_cover_h = 2; // [1:1:20]

// Include quarter-round corner hold-downs in the cover
_cover_corner_tabs = true;


/* [Advanced] */

// Depth of text etching into top surface
_text_depth = 0.5; // [0.0:0.1:2]

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

// Bevel the outside edges above the board space inward to make upper structures like knobs more printable
_dome = false;



///////////////////////////////
// DISPLAY
///////////////////////////////

difference() {
    technic_mount_and_cover(render_modules=_render_modules, material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, length=_length, width=_width, thickness=_thickness, h=_h, cover_h=_cover_h, l_pad=_l_pad, w_pad=_w_pad, twist_l=_twist_l, twist_w=_twist_w, knob_vent_radius=_knob_vent_radius, innercut=_innercut, undercut=_undercut, center=_center, cover_center=_cover_center, text=_text, cover_text=_cover_text, text_depth=_text_depth, left_enclosure_cutout_y=_left_enclosure_cutout_y, left_enclosure_cutout_width=_left_enclosure_cutout_width, left_enclosure_cutout_depth=_left_enclosure_cutout_depth, left_enclosure_cutout_z=_left_enclosure_cutout_z, left_enclosure_cutout_height=_left_enclosure_cutout_height, right_enclosure_cutout_y=_right_enclosure_cutout_y, right_enclosure_cutout_width=_right_enclosure_cutout_width, right_enclosure_cutout_depth=_right_enclosure_cutout_depth, right_enclosure_cutout_z=_right_enclosure_cutout_z, right_enclosure_cutout_height=_right_enclosure_cutout_height, front_enclosure_cutout_x=_front_enclosure_cutout_x, front_enclosure_cutout_width=_front_enclosure_cutout_width, front_enclosure_cutout_depth=_front_enclosure_cutout_depth, front_enclosure_cutout_z=_front_enclosure_cutout_z, front_enclosure_cutout_height=_front_enclosure_cutout_height, back_enclosure_cutout_x=_back_enclosure_cutout_x, back_enclosure_cutout_width=_back_enclosure_cutout_width, back_enclosure_cutout_depth=_back_enclosure_cutout_depth, back_enclosure_cutout_z=_back_enclosure_cutout_z, back_enclosure_cutout_height=_back_enclosure_cutout_height, dome=_dome, horizontal_skin=_horizontal_skin, vertical_skin=_vertical_skin, knob_height=_knob_height, top_vents=_top_vents, cover_corner_tabs=_cover_corner_tabs);
    
    union() {
        translate([block_width(-1), block_width(-8), block_width(1)])
            cube([block_width(2), block_width(3), block_width(2)]);
        
        translate([block_width(2), block_width(-6), -_skin])
            cube([block_width(20), block_width(2), block_width(3)]);
        
        translate([block_width(2), block_width(-8), block_width(1)])
            cube([block_width(20), block_width(3), block_width(2)]);
    }
}
