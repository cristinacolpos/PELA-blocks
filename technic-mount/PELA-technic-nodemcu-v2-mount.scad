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



/* [Node MCU v2 Technic Mount] */

// Show the inside structure [mm]
cut_line = 0;

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

length = 48.7;

width = 26.2;

thickness = 1.8;

board_length = 48.8;

board_width = 26.5;

board_height = 2 + block_height();

header_length = 38.4;

header_height = 2.8 + block_height();

usb_width = 15;

usb_length = 40;

usb_height = block_height() + 4.8;


///////////////////////////////
// DISPLAY
///////////////////////////////

board_mount(material=material, large_nozzle=large_nozzle, length=length, length_padding=length_padding, width=width, width_padding=width_padding);



///////////////////////////////////
// MODULES
///////////////////////////////////

module board_mount(material=material, large_nozzle=large_nozzle, length=length, length_padding=length_padding, width=width, width_padding=width_padding) {

  l = fit_mm_to_blocks(length, length_padding);
  w = fit_mm_to_blocks(width, width_padding);

  difference() {
    union() {
      translate([block_width(0.5)-skin, block_width(0.5)-skin, 0]) {

        color("red") cube([block_width(l-2)+2*skin, block_width(w-2)+2*skin, block_height()*2]);
      }

      color("gray", 0.3) union() {
        technic_bar_frame(material=material, large_nozzle=large_nozzle, l=l, w=w);

        translate([0, 0, block_height()]) {
          technic_bar_frame(material=material, large_nozzle=large_nozzle, l=l, w=w);
        }
      }
    }
    translate([
      block_width(0.5) + (block_width(7) - board_length) / 2,
      block_width(0.5) + (block_width(4) - board_width) / 2,
      block_height()
    ]) {
      board(material=material, large_nozzle=large_nozzle, length=length);
    }
  }
}

module technic_bar_frame(material=material, large_nozzle=large_nozzle, l=undef, w=undef) {
    union() {
      technic_bar(material=material, large_nozzle=large_nozzle, l=l);

      rotate([0, 0, 90]) {
        technic_bar(material=material, large_nozzle=large_nozzle, l=w);
      }
      
      translate([0, block_width(w-1), 0]) {
        technic_bar(material=material, large_nozzle=large_nozzle, l=l, h=1);
      }

      rotate([0, 0, 90]) {
        translate([0, -block_width(l-1), 0]) {
          technic_bar(material=material, large_nozzle=large_nozzle, l=w);
        }
      }
    }
}


module board(material=material, large_nozzle=large_nozzle, length=length, board_length=board_length, board_width=board_width, board_height=board_height) {
  union() {
    cube([board_length, board_width, board_height]);

    color("green") translate([(board_length-header_length)/2, 0, -header_height]) cube([header_length, board_width, header_height]);

    // usb
    color("red") translate([-usb_length/2, (board_width-usb_width)/2, -2.8]) cube([usb_length, usb_width, usb_height]);
  }
}

