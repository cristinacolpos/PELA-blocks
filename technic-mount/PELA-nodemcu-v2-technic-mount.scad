/*
PELA Technic Node MCU v2 Mount - 3D Printed LEGO-compatible PCB holder

Published at https://PELAblocks.org

By Kenta Kusumoto
Email: kenta.kusumoto@futurice.com

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
use <../box-enclosure/PELA-box-enclosure.scad>
use <../knob-mount/PELA-knob-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-twist-bar.scad>
use <PELA-technic-box.scad>
use <PELA-technic-mount.scad>



/* [Node MCU v2 Technic Mount] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Select parts to render
render_modules = 2; // [0:technic mount, 1:technic cover, 2:technic mount and cover]

// Board space length [mm]
length = 48.7; // [0:1:100]

// Board space width [mm]
width = 26.2; // [0:1:100]

// Board space height [mm]
thickness = 1.8; // [0:0.1:300]

// Height of the model [blocks]
h = 1; // [1:1:20]

// USB cutout space length [mm]
usb_length = 2; // [0:1:100]

// USB cutout space width [mm]
usb_width = 2; // [0:1:100]

// USB cutout height
usb_height = 0.5; // [0:0.5:20]

// Closeness of board fit lengthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)
l_pad = 0; // [0:tight, 1:+1 block, 2:+2 blocks]

// Closeness of board fit widthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)
w_pad = 0; // [0:tight, 1:+1 block, 2:+2 blocks]

// 90 degree rotation from length ends [blocks]
twist_l = 2; // [1:18]

// 90 degree rotation from width ends [blocks]
twist_w = 1; // [1:18]

// Step in from board space edges to support the board [mm]
innercut = 1;

// Step down from board bottom to give room board components [mm]
undercut = 1.0; // [0:0.1:100]

// Presence of sockets if center is "socket panel"
center_sockets = true;

// Presence of knobs if center is "knob panel"
center_knobs = true;

// Interior fill style
center = 2; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel]]

// Text label
text = "NodeMCUv2";

// Depth of text etching into top surface
text_depth = 0.5; // [0.0:0.1:2]



/* [Technic Cover] */

// Text label
cover_text = "Cover";

// Interior fill style
cover_center = 5; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel]

// Height of the cover [blocks]
cover_h = 1; // [1:1:20]

// Presence of sockets if "cover center" is "socket panel"
cover_sockets = true;

// Presence of knobs if "cover center" is "knob panel"
cover_knobs = true;



/* [Hidden] */

// Basic unit vertical size of each block
block_height = 8; // [8:technic, 9.6:traditional blocks]



///////////////////////////////
// DISPLAY
///////////////////////////////

nodemcu_v2_technic_mount_and_cover(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, thickness=thickness, h=h, l_pad=l_pad, w_pad=w_pad, h=h, twist_l=twist_l, twist_w=twist_w, center_sockets=center_sockets, center_knobs=center_knobs, cover_sockets=cover_sockets, cover_knobs=cover_knobs, knob_vent_radius=knob_vent_radius, solid_first_layer=solid_first_layer, innercut=innercut, undercut=undercut, center=center, cover_center=cover_center, text=text, cover_text=cover_text, text_depth=text_depth, usb_length=usb_length, usb_width=usb_width, usb_height=usb_height, block_height=block_height);



///////////////////////////////////
// MODULES
///////////////////////////////////

module nodemcu_v2_technic_mount_and_cover(material=undef, large_nozzle=undef, cut_line=undef, length=undef, width=undef, thickness=undef, h=undef, l_pad=undef, w_pad=undef, h=undef, twist_l=undef, twist_w=undef, center_sockets=undef, center_knobs=undef, cover_sockets=undef, cover_knobs=undef, knob_vent_radius=undef, solid_first_layer=undef, innercut=undef, undercut=undef, center=undef, cover_center=undef, text=undef, cover_text=undef, text_depth=undef, usb_length=undef, usb_width=undef, usb_height=undef, block_height=undef) {

  l = fit_mm_to_blocks(length, l_pad);
  w = fit_mm_to_blocks(width, w_pad);

  difference() {
    technic_mount_and_cover(render_modules=render_modules, material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, thickness=thickness, h=h, l_pad=l_pad, w_pad=w_pad, twist_l=twist_l, twist_w=twist_w, center_sockets=center_sockets, center_knobs=center_knobs, cover_sockets=cover_sockets, cover_knobs=cover_knobs, knob_vent_radius=knob_vent_radius, solid_first_layer=solid_first_layer, innercut=innercut, undercut=undercut, center=center, text=text, cover_text=cover_text, text_depth=text_depth, block_height=block_height);

    cutouts(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, usb_length=usb_length, usb_width=usb_width, usb_height=usb_height, block_height=block_height);
  }
}


module cutouts(material=undef, large_nozzle=undef, l=undef, w=undef, h=undef, usb_length=undef, usb_width=undef, usb_height=undef, block_height=undef) {

  color("yellow") translate([-block_width(usb_length/2), (block_width(w-usb_width-1))/2, block_height(0.5, block_height)]) {

    cube([block_width(usb_length), block_width(usb_width), block_height(1, block_height)]);
  }
}

