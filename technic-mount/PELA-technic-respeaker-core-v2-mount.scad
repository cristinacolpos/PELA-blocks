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

include <../style.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../knob-mount/PELA-knob-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-twist-bar.scad>
use <../knob-panel/PELA-knob-panel.scad>



/* [Respeaker Core v2 Technic Mount] */

// Printing material
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Prepare the model to print in two colors
two_color_print = true;

// Can change according to preference
center_support_spokes = !two_color_print;

width = 88;

thickness = 1.9;

// Step in from board space edges to support the board [mm]
innercut = 0.5;

side_length = 8; // Blocks

// Mounting hole centers
side = (width/2) / sin(60);

top = side + side*sin(30);

mount_d = 5.5;

mount_h = block_height(3) - 2;

mount_pin_d = 2.7;

center_height = 4;

spoke_width=6;

// Origin for the board model and board mounting holes
outer_width = 2*block_width(side_length + 0.25)*sin(30);

board_spacing = (side + sin(30)*side - outer_width)/2;

ox = board_spacing*cos(30);

oy = board_spacing*sin(30);

center_y = block_width(side_length)/2 - block_width(0.5);

center_x = block_width(side_length - 0.5)*cos(30) - block_width(0.5)*cos(30);

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

// Base
base_thickness = 2;



///////////////////////////////
// DISPLAY
///////////////////////////////

rotate([180, 0, 0]) {
    respeaker_core_v2_technic_mount();
}
// respeaker_core_v2_technic_top();



///////////////////////////////////
// MODULES
///////////////////////////////////

module respeaker_core_v2_technic_top(material=material, two_color_print=two_color_print) { 
    difference() {
        union() {
            respeaker_core_v2_technic_top_edge(material=material);
            respeaker_core_v2_technic_top_center(material=material);
        }
        union() {
            clear_ring(material=material, two_color_print=two_color_print);
            switch_access(material=material);
        }        
    }

    if (!two_color_print) {
        board_mounts_top(material=material);
    }
}


module board_mounts_top(material=material) {
    translate([ox, oy, -thickness - 0.1]) { 
        board_mounts(material=material, h=6, rot=180, pin=false);
    }
}


module clear_ring(material=material, two_color_print=two_color_print) {
    r1 = side*.87;
    r2 = r1 - 8;

    translate([center_x, center_y, -8]) {
        difference() {
            cylinder(r=r1, h=center_height, $fn=256);

            union() {
                cylinder(r=r2, h=center_height, $fn=256);
                center_spokes(material=material);
            }
        }
    }

    if (two_color_print) {
    #    board_mounts_top(material=material);
    }
}


module center_spokes(material=material) {
    if (center_support_spokes) {
        for (i=[0:30:180]) {
            rotate([0, 0, 15+i]) {
                translate([-side, -spoke_width/2, 0]) {
                cube([width*1.1, spoke_width, center_height]);
                }
            }
        }
    }
}


module switch_access(material=material) {
    translate([center_x - side + 29.85, center_y, -10]) {
        cylinder(r=4, h=15);
    }
}


module respeaker_board(material=material, width=width, side=side, thickness=thickness) {
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


module respeaker_base(material=material) {
    m = 1.035;
    translate([2.7, 2.2, block_height(3) - base_thickness]) {
        respeaker_board(material=material, width=width*m, side=side*m, thickness=base_thickness);
    }

    translate([block_width(11), block_width(1), block_height(3)]) {
        rotate([0, 180, 0]) {
            PELA_knob_panel(material=material, l=10, w=5, top_vents=false, solid_first_layer=true, corner_bolt_holes=false, knobs=true, sockets=false);
        }
    }
}


module respeaker_core_v2_technic_mount(material=material) {
    translate([ox, oy]) { 
        translate([0, 0, block_height(3) - mount_h - thickness]) {
//           % color("gold") respeaker_board();    
        }
        board_mounts(material=material);
    }

    color("silver") respeaker_base(material=material);

    rotate([0, 0, -30]) {
        // Side 1
        color("red") {
            technic_bar(material=material, l=side_length, h=3);
        }
        
        translate([block_width(side_length - 1), 0, 0]) {
            rotate([0, 0, 60]) {
                // Side 2
                color("green") {
                    technic_bar(material=material, l=3);
                    translate([block_width(7), 0, 0]) {
                        technic_bar(material=material, l=1);
                    }

                    translate([0, 0, block_height(1)]) {
                        technic_bar(material=material, l=side_length, h=2);
                    }
                }
                
                translate([block_width(side_length - 1), 0, 0]) {
                    rotate([0, 0, 60]) {
                        // Side 3
                        color("blue") {
                            translate([0, 0, block_height(2)]) {
                                technic_bar(material=material, l=side_length);
                            }
                        }
                        
                        translate([block_width(side_length - 1), 0, 0]) {
                            rotate([0, 0, 60]) {
                                // Side 4
                                color("yellow") {
                                    technic_bar(material=material, l=4);
                                    translate([0, 0, block_height()]) {
                                        technic_bar(material=material, l=side_length, h=2);
                                    }
                                }
                                
                                translate([block_width(side_length - 1), 0, 0]) {
                                    rotate([0, 0, 60]) {
                                        // Side 5
                                        color("white") {
                                            technic_bar(material=material, l=side_length, h=3);
                                        }
                                        
                                        translate([block_width(side_length - 1), 0, 0]) {
                                            rotate([0, 0, 60]) {
                                                // Side 6
                                                translate([0, 0, block_height()])
                                                color("orange") {
                                                    technic_bar(material=material, l=side_length, h=2);
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


module board_mounts(material=material, rot=0, h=mount_h, pin=true) {
        color("orange") board_mount(material=material, x1, y1, h=h, rot=rot, pin=pin);
        color("yellow") board_mount(material=material, x2, y2, h=h, rot=rot, pin=pin);
        color("pink") board_mount(material=material, x3, y3, h=h, rot=rot, pin=pin);
        color("grey") board_mount(material=material, x4, y4, h=h, rot=rot, pin=pin);
}


module board_mount(material=material, x, y, h, rot, pin) {
    d_multiplier = 1.5;
    d2 = d_multiplier*mount_d;
    h2 = min(h, d2);

    translate([x, y, block_height(3) - mount_h]) {
        rotate([rot, 0, 0]) {
            cylinder(d1=mount_d, d2=d2, h=h2);
            translate([0, 0, h2]) {
                cylinder(d=d2, h=h-h2);
            }
            if (pin) {
                rotate([180, 0, 0]){
                    cylinder(d=mount_pin_d, h=thickness - 0.1);
                }
            }
        }
    }
}


module respeaker_core_v2_technic_top_edge(material=material, side_holes=2) {

    translate([0, 0, block_height(-1)]) rotate([0, 0, -30]) {
        // Side 1
        color("red") {
            translate([block_width(2), 0, 0]) {
                technic_bar(material=material, l=4, side_holes=side_holes);
            }
        }
        
        translate([block_width(side_length - 1), 0, 0]) {
            rotate([0, 0, 60]) {
                // Side 2
                color("green") {
                    translate([block_width(2), 0, 0]) {
                        technic_bar(material=material, l=1, side_holes=side_holes);
                    }
                }
                
                translate([block_width(side_length - 1), 0, 0]) {
                    rotate([0, 0, 60]) {
                        // Side 3
                        
                        translate([block_width(side_length - 1), 0, 0]) {
                            rotate([0, 0, 60]) {
                                // Side 4
                                color("yellow") {
                                    translate([block_width(2), 0, 0]) {
                                        technic_bar(material=material, l=2, side_holes=side_holes);
                                    }
                                }
                                
                                translate([block_width(side_length - 1), 0, 0]) {
                                    rotate([0, 0, 60]) {
                                        // Side 5
                                        color("white") {
                                            translate([block_width(2), 0, 0]) {
                                                technic_bar(material=material, l=4, side_holes=side_holes);
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


module respeaker_core_v2_technic_top_center(material=material) {
    top_thickness = 0.5;
    difference() {
        union() {
            translate([0, 0, block_height(-1)]) rotate([0, 0, -30]) hull() {
                // Side 1
                color("red") {
                    technic_bar(material=material, l=8, h=top_thickness);
                }
                
                translate([block_width(side_length - 1), 0, 0]) {
                    rotate([0, 0, 60]) {
                        // Side 2
                        color("green") {
                            technic_bar(material=material, l=8, h=top_thickness);
                        }
                        
                        translate([block_width(side_length - 1), 0, 0]) {
                            rotate([0, 0, 60]) {
                                // Side 3
                                color("blue") {
                                    technic_bar(material=material, l=8, h=top_thickness);
                                }
                                
                                translate([block_width(side_length - 1), 0, 0]) {
                                    rotate([0, 0, 60]) {
                                        // Side 4
                                        color("yellow") {
                                            technic_bar(material=material, l=8, h=top_thickness);
                                        }
                                        
                                        translate([block_width(side_length - 1), 0, 0]) {
                                            rotate([0, 0, 60]) {
                                                // Side 5
                                                color("white") {
                                                    technic_bar(material=material, l=8, h=top_thickness);
                                                }
                                                
                                                translate([block_width(side_length - 1), 0, 0]) {
                                                    rotate([0, 0, 60]) {
                                                        // Side 6
                                                        color("orange") {
                                                            technic_bar(material=material, l=8, h=top_thickness);
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

        translate([0, 0, -1]) {
            respeaker_core_v2_technic_top_edge(material=material, side_holes=0);
        }
    }
}

