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

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../board-mount/PELA-board-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>

/* [Technic Node MCU v2 Options] */

length = 48.7;
width = 26.2;
thickness = 1.8;
undercut = 2.3; // How far below the bottom of the board surface parts protude (not indlucing big things like an SD card holder)
innercut = 2; // How far in from the outside edges the board support can extend without hitting board bottom surface parts
base_thickness = block_height(); // The thickness of the base below an array of half-pins
slot_depth = 2;
end_lock_d = 1.2;
array_spacing = block_width();
length_tightness = 2;
width_tightness = 2;
angle = 45;

///////////////
// Display
///////////////
board_mount();

module board_mount() {
  l = fit_mm_to_pela_blocks(length, length_tightness);
  w = fit_mm_to_pela_blocks(width, width_tightness);

  difference() {
    union() {
      translate([block_width(0.5)-skin, block_width(0.5)-skin, 0]) {
        color("red") cube([block_width(l-2)+2*skin, block_width(w-2)+2*skin, block_height()*2]);
      }
      color("gray", 0.3) union() {
        technic_bar_frame(l, w);
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

module technic_bar_frame(l, w) {
    union() {
      technic_bar(l=l);
      rotate([0, 0, 90]) technic_bar(l=w);
      translate([0, block_width(w-1), 0]) technic_bar(l=l);
      rotate([0, 0, 90]) translate([0, -block_width(l-1), 0]) technic_bar(l=w);
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


module board() {
  union() {
    cube([board_length, board_width, board_height]);
    color("green") translate([(board_length-header_length)/2, 0, -header_height]) cube([header_length, board_width, header_height]);
    // usb
    color("red") translate([-usb_length/2, (board_width-usb_width)/2, -2.8]) cube([usb_length, usb_width, usb_height]);
  }
}

