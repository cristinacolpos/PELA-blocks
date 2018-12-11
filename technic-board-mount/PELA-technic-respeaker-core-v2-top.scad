/*
PELA Technic Seeed Respeaker Core v2 Mount - 3D Printed LEGO-compatible PCB mount

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

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../board-mount/PELA-board-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <PELA-technic-respeaker-core-v2-mount.scad>

/* [Model Options] */

two_color_print = false;    // Optional local model override of PELA_print_parameters.scad

width = 88;
thickness = 1.9;
innercut = 0.5; // How far in from the outside edges the board support can extend without hitting board bottom surface parts

side_length = 8; // blocks

// Mounting hole centers
side = (width/2) / sin(60);
top = side + side*sin(30);
mount_d = 5.5;
mount_h = block_height(3) - 2;

// Origin for the board model and board mounting holes
outer_width = 2*block_width(side_length + 0.25)*sin(30);
board_spacing = (side + sin(30)*side - outer_width)/2;
ox = board_spacing*cos(30);
oy = board_spacing*sin(30);

// Orange
x1 = width - 46 - 29.1;
y1 = top - 20.8;

// Yellow
x2 = x1;
y2 = top - 20.8 - 5.5 - 47.9 - 5.1;

// Pink
 x3 = width - 29.1;
y3 = top - 20.8 - 5.5;

// Grey
x4 = width - 29.1;
y4 = y3 - 47.9;

// Base
base_thickness = 2;


///////////////
// Display
///////////////
respeaker_core_v2_technic_top(two_color_print=two_color_print);
