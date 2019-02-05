/*
PELA technic angle - 3D Printed LEGO-compatible 30 degree bend

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

include <../print-parameters.scad>
include <../style.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <PELA-technic-bar.scad>



/* [Technic Angle Connector] */

// Show the inside structure [mm]
cut_line = 0;

// Printing material
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the nozzle >= 0.5mm? If so, some features are larger to make printing easier (and slightly slower)
large_nozzle = true;

// Angle between the top and bottom parts of the connector [degrees]
angle = 30;

// Length of the connector [blocks]
l = 7;



///////////////////////////////
// DISPLAY
///////////////////////////////

technic_angle_connector();



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_angle_connector(material=material, large_nozzle=large_nozzle, cut_line=cut_line,angle=angle, l=l) {
    assert(angle >= 0, "Angle connector must be 0-180 degrees")
    assert(angle <= 180, "Angle connector must be 0-180 degrees")

    difference() {
        union() {
            translate([0, 0, block_height(1)]) {
                rotate([angle, 0, 0]) {
                    translate([0, block_width(0.5), 0]) {
                        technic_bar(l=l);
                    }
                }
            }

            translate([0, block_width(0.5), 0]) {
                    technic_bar(l=l);
            }

            increment = 5;
            for (theta = [0 : increment : angle]) {
                pie_slice(material=material, large_nozzle=large_nozzle, theta=theta, increment=increment, l=l);
            }
        }

        translate([block_width(-0.5, block_width=block_width), -sin(angle)*block_width(1, block_width=block_width), 0]) {
           cut_space(material=material, large_nozzle=large_nozzle, w=l, l=l, cut_line=cut_line, h=3, block_width=block_width, block_height=block_height, knob_height=knob_height);
        }
    }
}



// theta-degree spacer between the two segments
module pie_slice(material=material, large_nozzle=large_nozzle, theta=0, increment=5, l=l) {
    translate([0, 0, block_width(1)]) {
        rotate([theta, 0 , 0]) {
            difference() {
                hull() {
                    technic_bar_slice(material=material, large_nozzle=large_nozzle, l=l);

                    rotate([increment, 0, 0]) {
                        technic_bar_slice(material=material, large_nozzle=large_nozzle, l=l);
                    }
                }

                for (n = [0:1:l-1]) {
                    translate([block_width(n), 0, 0]) {
                        hull() {
                            translate([0, 0, -defeather]) {
                                technic_bar_slice_negative(material=material, large_nozzle=large_nozzle, l=0);
                            }

                            rotate([increment, 0, 0]) {
                                translate([0, 0, defeather]) {
                                    technic_bar_slice_negative(material=material, large_nozzle=large_nozzle, l=0);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}