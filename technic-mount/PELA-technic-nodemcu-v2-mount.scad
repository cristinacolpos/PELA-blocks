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
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../knob-mount/PELA-knob-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-twist-bar.scad>



/* [Node MCU v2 Technic Mount] */

// Printing material
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

length = 48.7;

width = 26.2;

thickness = 1.8;



///////////////////////////////
// DISPLAY
///////////////////////////////

board_mount();



///////////////////////////////////
// MODULES
///////////////////////////////////

module board_mount(material=material) {
  l = fit_mm_to_blocks(length, length_padding);
  w = fit_mm_to_blocks(width, width_padding);

  difference() {
    union() {
      translate([block_width(0.5)-skin, block_width(0.5)-skin, 0]) {
        color("red") cube([block_width(l-2)+2*skin, block_width(w-2)+2*skin, block_height()*2]);
      }
      color("gray", 0.3) union() {
        technic_bar_frame(material=material, l, w);
        translate([0, 0, block_height()]) technic_bar_frame(l, w);
      }
    }
    translate([
      block_width(0.5) + (block_width(7) - board_length) / 2,
      block_width(0.5) + (block_width(4) - board_width) / 2,
      block_height()
    ]) board();
  }
}

module technic_bar_frame(material=material, l, w) {
    union() {
      technic_bar(material=material, l=l);
      rotate([0, 0, 90]) technic_bar(material=material, l=w);
      translate([0, block_width(w-1), 0]) technic_bar(material=material, l=l);
      rotate([0, 0, 90]) translate([0, -block_width(l-1), 0]) technic_bar(material=material, l=w);
    }
}


board_length = 48.8;
board_width = 26.5;
board_height = 2 + block_height();
header_length = 38.4;
header_height = 2.8 + block_height();
usb_width = 15;
usb_length = 40;
usb_height = block_height() + 2.8 + 2;


module board(material=material) {
  union() {
    cube([board_length, board_width, board_height]);
    color("green") translate([(board_length-header_length)/2, 0, -header_height]) cube([header_length, board_width, header_height]);
    // usb
    color("red") translate([-usb_length/2, (board_width-usb_width)/2, -2.8]) cube([usb_length, usb_width, usb_height]);
  }
}

