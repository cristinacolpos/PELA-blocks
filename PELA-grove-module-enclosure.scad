/*
Parametric PELA Grove Module Enclosure

Designed for enclosing http://wiki.seeed.cc/Grove_System/ sensors in a block for rapid prototyping and play

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike License
https://creativecommons.org/licenses/by-sa/4.0/legalcode

Although this file is parametric and designed for use with an online customizer, it is too slow and things break in the cloud- you must download it to make changes vs the pre-generated .STL files normally found with this file.
*/

include <style.scad>
include <print-parameters.scad>
use <PELA-block.scad>
use <PELA-technic-block.scad>
use <support/support.scad>

/* [Grove Enclosure Options] */
// Length of the enclosure [blocks]
l = 4; 

// Width of the enclosure [blocks]
w = 2;

// Height of HALF the enclosure [blocks]
h = 2;

// Interior fill for layers above the bottom
solid_upper_layers = true;

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
corner_bolt_holes = false;

// Height of horizontal surface strengthening slats (appears between the bottom rings)
bottom_stiffener_height = 9.6;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;


/* [Grove Module Options] */

// Grove sensor board size
grove_width = 20;

// Room below the board
bottom_space = 2;

// Board thickness
thickness = 1.85;

// Screw mount space on edge of board
eye_radius = 2.55; 

// Slide in mounting groove depth
edge_inset = 0.6;

// USB conncector negative space width
connector_width = 9;

// USB conncector negative space height
connector_height = 5;

// USB conncector negative space length (to push some distance beyond the enclosure)
connector_length = 50;

// Additional space around the module for easly slotting the module into a surrounding case (make this bigger if the board fits too tightly)
mink = 0.25;

// Length of the negative space exclusion zone in front of the module
negative_space_height=100;

// Distance from the outside edge of the technic connector linking the top to the bottom
offset_x=3.5;

// Distance from the outside edge of the technic connector linking the top to the bottom
offset_y=3.7;

// Distance to slide the grove module forward
grove_y_shift = 0.25;

// Generate print-time support aid structures
print_supports = true;


///////////////////////////////
// DISPLAY
///////////////////////////////

rotate([0, 0, 180]) {
    bottom_piece();
    top_piece();
}


/////////////////////////////////////
// FUNCTIONS
/////////////////////////////////////

function vertical_offset(block_height=block_height)=(block_height(2*h, block_height=block_height)-grove_width)/2;


/////////////////////////////////////
// MODULES
/////////////////////////////////////

module bottom_piece() {
    difference() {
        union() {
            PELA_technic_block(l=l, w=w, h=h, knob_flexture_height=0, solid_bottom_layer=true, solid_upper_layers=true, corner_bolt_holes=corner_bolt_holes, side_holes=0, end_holes=0, block_height=block_height);

            double_end_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width, block_height=block_height);
        }

    
        union() {
            translate([(block_width(4)-grove_width)/2, shell, vertical_offset(block_height=block_height)]) {
                rotate([0, -90, 270]) {
                    grove();
                }
            }

            double_end_connector_hole_set(l=l, w=w, hole_type=2, axle_hole_radius=axle_hole_radius, block_width=block_width);

            if (corner_bolt_holes) {
                corner_corner_bolt_holes(l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius, block_height=block_height);
            }
            
            skin();
        }
    }
}


// Top piece
module top_piece() {

    translate([0, block_width(w + 0.5), 0]) {
        main_top_piece();

        if (print_supports) {
            difference() {
                union() {
                    top_supports();

                    difference() {
                        hull() {
                            top_supports();
                        }

                        translate([0, 0, support_connection_height]) {
                            cube([block_width(l), block_width(w+1), block_height(h, block_height=block_height)]);
                        }
                    }
                }

                main_top_piece_space();
            }
        }
    }
}


// Primary shape of the top piece
module main_top_piece() {
    difference() {
        union() {
            PELA_technic_block(l=l, w=w, h=h, corner_bolt_holes=corner_bolt_holes, side_holes=0, end_holes=0);
        
            translate([0, 0, block_height(1, block_height=block_height)]) {
                double_end_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width);
            }
        }
        
        union() {
            translate([(block_width(l)-grove_width)/2, 1.2, block_height(-h, block_height=block_height)+vertical_offset()]) {
                rotate([0,-90,270]) {
                    grove();
                }
            }
            
            translate([0, 0, block_height(1, block_height=block_height)]) {
                double_end_connector_hole_set(l=l, w=w, hole_type=2, axle_hole_radius=axle_hole_radius, block_width=block_width);
            }

            if (corner_bolt_holes) {
                corner_corner_bolt_holes(l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius);
            }
            
            skin(l=l, w=w, h=h);
        }
    }
}


// The negative space which supports should not enter to be too close to the top piece
module main_top_piece_space() {
    minkowski() {
        main_top_piece();

        sphere(r=support_offset_from_part, $fn=8);
    }    
}


// Supports to prevent the long overhangs from drooping
module top_supports() {
    support_side_length=4;
    height = block_height(h) - 1.95 - skin;
    h2 = 9.6;
    end_h = 4.68;
    end_x = 1;
    end_support_side_length=3;

    translate([block_width(2), block_width(0.5), 0])
        support(height=height, support_side_length=support_side_length);
    
    translate([block_width(2), block_width(1.5), 0])
        support(height=height, support_side_length=support_side_length);
    
    translate([block_width(1.5), block_width(1), 0])
        support(height=height, support_side_length=support_side_length);
    
    translate([block_width(2.5), block_width(1), 0])
        support(height=height, support_side_length=support_side_length);

    translate([block_width(1.5), block_width(1.9), 0])
        support(height=h2, support_side_length=support_side_length);

    translate([block_width(2.5), block_width(1.9), 0])
        support(height=h2, support_side_length=support_side_length);

    translate([end_x, block_width(1), 0])
        support(height=end_h, support_side_length=end_support_side_length);

    translate([block_width(l)-end_x, block_width(1), 0])
        support(height=end_h, support_side_length=end_support_side_length);
}
    

///////////////////////////////
    
// A complete Grove module negative space assembly. These are all the areas where you do _not_ want material in order to be able to place a real Grove module embedded within another part
module grove() {
    translate([0, 0, grove_y_shift]) {
        minkowski() {
            union() {
                board();
                negative_space();            
            }
            
            sphere(r=mink, $fn=8);
        }
    }
}

// Grove module main board (PCB with two screw mounts)
module board() {
    translate([0, 0, bottom_space]) {
        cube([grove_width, grove_width, thickness]);
    }

    translate([0, grove_width/2,bottom_space]) {
        eye();
    }
    
    translate([grove_width, grove_width/2, bottom_space]) {
        eye();
    }
    
    translate([(grove_width-connector_width)/2, -(connector_length-grove_width)/2, bottom_space+thickness]) {
        cube([connector_width, connector_length, connector_height]);
    }
}

// The bump on the side of a Grove module where a screw holder can be inserted. In this design, this is simply used for orienting the Grove module within another block (no screws are usually used)
module eye() {
    cylinder(r=eye_radius,h=thickness);
}

// Space for the board components and access to the Grove connector on the front of the board (no material is here)
module negative_space() {
    translate([edge_inset,edge_inset,0]) {
        cube([grove_width-2*edge_inset,grove_width-2*edge_inset,negative_space_height]);
    }
}


/////////////////////////////////
// A PELA block with a Grove-sized hole in it. This block must be sliced into top and bottom halves
// in order for you to be able to fit the Grove module inside.
////////////////////////////////
module PELA_grove() {
    difference() {
        PELA(l, w, h);

        translate([grove_width + (block_width(4)-grove_width)/2, block_width(2)-2*shell, (block_height(3)-grove_width)/2]) {
            rotate([90,0,90]) {
                grove();       
            }
        }
    }
}
