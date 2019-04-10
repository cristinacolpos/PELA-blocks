/*
PELA HTC Vive Tracker Mount Screw

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Import this into other design files:
    use <PELA-block.scad>
*/

include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../threads/threads.scad>



/* [Camera Mount Screw] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Screwhole border
thumbscrew_head_diameter=11; // [0:0.1:30]

// Thumbscrew cut for finger tension [mm]
cut = 0.8; // [0:0.1:4]

// Thumbscrew pitch [turns per inch]
tpi = 20; // [1:1:60]

// Thumbscrew head height [mm]
head_thickness = 1.9; // [0:0.1:8]

// Thumscrew diameter of shaft [inches]
diameter_in = 0.25; // [0:0.05:4]

// Thumbscrew total height [inches]
height_in = 0.25; // [0:0.05:4]



///////////////////////////////
// DISPLAY
///////////////////////////////

thumbscrew(material=material, large_nozzle=large_nozzle, cut_line=cut_line, thumbscrew_head_diameter=thumbscrew_head_diameter, cut=cut, tpi=tpi, head_thickness=head_thickness, diameter_in=diameter_in, height_in=height_in);



///////////////////////////////////
// MODULES
///////////////////////////////////

module thumbscrew(material=material, large_nozzle=large_nozzle, cut_line=cut_line,thumbscrew_head_diameter=thumbscrew_head_diameter, cut=cut, tpi=tpi, head_thickness=head_thickness, diameter_in=diameter_in, height_in=height_in) {

    difference() {
        union() {
            translate([0, 0, head_thickness]) {
                us_bolt_thread(dInch=diameter_in, hInch
            =height_in
            , tpi=tpi);
            }

            thumbscrew_head(material=material, large_nozzle=large_nozzle, head_thickness=head_thickness);
        }

        translate([-thumbscrew_head_diameter/2, -thumbscrew_head_diameter/2, 0]) {
            cut_space(material=material, large_nozzle=large_nozzle, l=2, cut_line=cut_line, h=2, block_height=block_height, knob_height=knob_height);
        }
    }
}


module thumbscrew_head(material=material, large_nozzle=large_nozzle, head_thickness=head_thickness) {

    cylinder(d=thumbscrew_head_diameter/2, h=head_thickness);

    difference() {
        difference() {
            cylinder(d=thumbscrew_head_diameter-0.2, h=head_thickness);
            translate([-cut/2, 0, 0]) {
                cube([cut, thumbscrew_head_diameter, cut]);
            }            
        }

        union() {
            for (i = [30:30:360]) {
                rotate([0, 0, i]) {
                    translate([-cut/2, 0, -_defeather]) {
                        cube([cut, thumbscrew_head_diameter, cut]);
                    }
                }
            }
        }
    }
}
