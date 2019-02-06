/*
Parametric PELA End Cap Enclosure For Intel Compute Stick

Create 2 symmetric end pieces which can support a solid object with PELA-compatible attachment points on top and bottom. The print can be minimized by printing only smaller end caps instead of a complele enclosure.


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Work sponsored by
    https://www.futurice.com/
*/

include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../PELA-socket-panel.scad>
use <PELA-box-enclosure.scad>
use <PELA-intel-compute-stick-box-enclosure.scad>



/* [Intel Compute Stick Enclosure Lid] */

// Show the inside structure [mm]
cut_line = 0;

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Basic unit vertical size of each block
block_height = 8; // [8:technic, 9.6:traditional blocks]

// Add interior fill for the base layer
solid_first_layer = false;



///////////////////////////////
// DISPLAY
///////////////////////////////

intel_compute_stick_box_lid(material=material, large_nozzle=large_nozzle, cut_line=cut_line, solid_first_layer=solid_first_layer, block_height=block_height);
