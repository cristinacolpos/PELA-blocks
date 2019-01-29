/*
PELA Slot Mount - 3D Printed LEGO-compatible PCB mount, vertical slide-in

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

include <../parameters.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../knob-mount/PELA-knob-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-twist-bar.scad>
use <../socket-panel/PELA-socket-panel.scad>
use <PELA-raspberry-pi3-technic-mount.scad>
include <PELA-technic-board-mount.scad>
include <PELA-technic-cover.scad>

/* [Raspberry Pi Technic Cover Options] */

length = 85.9; // board space length [mm]
width = 56.4; // board space width [mm]
length_tightness = 1.5; // closeness of board fit lengthwise inside a ring of blocks [blocks/blocks] (increase to make outer box slightly larger)
width_tightness = 1.5; // closeness of board fit widthwise inside a ring of blocks [blocks/blocks] (increase to make outer box slightly larger)
twist_length = 2; // How many blocks in from  length ends do the technic holes rotate 90 degrees
twist_width = 2; // How many blocks in from width ends do the technic holes rotate 90 degrees


///////////////
// Display
///////////////

technic_cover(length=length, width=width, length_tightness=length_tightness, width_tightness=width_tightness, twist_length=twist_length, twist_width=twist_width);
