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

include <../style.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../knob-mount/PELA-knob-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-twist-bar.scad>
use <../PELA-socket-panel.scad>
use <PELA-raspberry-pi3-technic-mount.scad>
include <PELA-technic-board-mount.scad>
include <PELA-technic-cover.scad>

/* [Raspberry Pi Technic Cover] */

// Printing material
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the nozzle >= 0.5mm? If so, some features get larger to make printing easier (and slightly slower)
large_nozzle = true;

length = 85.9; // Board space length [mm]

width = 56.4; // Board space width [mm]

length_padding = 1; // [0:tight, 1:+1 block, 2:+2 blocks] // Closeness of board fit lengthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)

width_padding = 1; // [0:tight, 1:+1 block, 2:+2 blocks] // Closeness of board fit widthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)

twist_length = 2; // How many blocks in from  length ends do the technic holes rotate 90 degrees

twist_width = 2; // How many blocks in from width ends do the technic holes rotate 90 degrees


///////////////
// DISPLAY
///////////////

technic_cover(material=material, large_nozzle=large_nozzle, length=length, width=width, length_padding=length_padding, width_padding=width_padding, twist_length=twist_length, twist_width=twist_width);
