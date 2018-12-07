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
include <PELA-technic-board-mount.scad>

/* [Technic Pin Array Options] */

width = 88;
thickness = 1.9;
innercut = 0.5; // How far in from the outside edges the board support can extend without hitting board bottom surface parts

side_length = 8; // blocks

// Mounting hole centers
side = (width/2) / sin(60);
top = side + side*sin(30);

// Origin for the board mounting holes
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

///////////////
// Display
///////////////
respeaker_core_v2_technic_mount();

module respeaker_board() {
    cube([width, side, thickness]);

    rotate([0, 0, -30]) {
        cube([side, width, thickness]);
    }
    
    translate([width, 0, 0]) {
        rotate([0, 0, 120]) {
            cube([width, side, thickness]);            
        }
    }
}


module respeaker_core_v2_technic_mount() {
    translate([ox, oy]) { 
        color("silver") translate([0, 0, -thickness]) {
            respeaker_board();    
        }
        board_mounts();
    }

    rotate([0, 0, -30]) {
        // Side 1
        color("red") {
            technic_bar(l=side_length, h=4);
        }
        
        translate([block_width(side_length - 1), 0, 0]) {
            rotate([0, 0, 60]) {
                // Side 2
                color("green") {
                    technic_bar(l=3);
                    translate([0, 0, block_height(1)]) {
                        technic_bar(l=side_length, h=3);
                    }
                }
                
                translate([block_width(side_length - 1), 0, 0]) {
                    rotate([0, 0, 60]) {
                        // Side 3
                        color("blue") {
                            translate([0, 0, block_height(3)]) {
                                technic_bar(l=side_length);
                            }
                        }
                        
                        translate([block_width(side_length - 1), 0, 0]) {
                            rotate([0, 0, 60]) {
                                // Side 4
                                color("yellow") {
                                    technic_bar(l=4);
                                    translate([0, 0, block_height()]) {
                                        technic_bar(l=side_length, h=3);
                                    }
                                }
                                
                                translate([block_width(side_length - 1), 0, 0]) {
                                    rotate([0, 0, 60]) {
                                        // Side 5
                                        color("white") {
                                            technic_bar(l=side_length, h=4);
                                        }
                                        
                                        translate([block_width(side_length - 1), 0, 0]) {
                                            rotate([0, 0, 60]) {
                                                // Side 6
                                                translate([0, 0, block_height()])
                                                color("black") {
                                                    technic_bar(l=side_length, h=3);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

module board_mounts() {
    color("orange") board_mount(x1, y1);
    color("yellow") board_mount(x2, y2);
    color("pink") board_mount(x3, y3);
    color("grey") board_mount(x4, y4);
}

module board_mount(x, y) {
    translate([x, y, 0]) {
        cylinder(d=5.5, h=block_height(4));
    }
}