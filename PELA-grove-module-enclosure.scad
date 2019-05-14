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
include <material.scad>
use <PELA-block.scad>
use <PELA-technic-block.scad>
use <support/support.scad>



/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]
// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;

// Render the lower section
_show_bottom_piece = true;

// Render the upper section
_show_top_piece = true;


/* [Enclosure] */

// Length of the enclosure [blocks]
_l = 4; // [1:1:20]

// Width of the enclosure [blocks]
_w = 2; // [1:1:20]

// Height of HALF the enclosure [blocks]
_h = 2; // [1:1:20]


/* [Block Features] */

// Add interior fill for upper layers
_solid_upper_layers = true;

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
_corner_bolt_holes = false;

// Height of horizontal surface strengthening slats (appears between the bottom rings)
_bottom_stiffener_height = 9.6;

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = false;

// Presence of bottom connector sockets
_sockets = true;

// Presence of top connector knobs
_knobs = true;

// How tall are top connectors [mm]
_knob_height = 2.9; // [1.8:traditional blocks, 2.9:PELA 3D print tall]

// Basic unit vertical size of each block
_block_height = 9.6; // [8:technic, 9.6:traditional blocks]


/* [Grove Module] */

// Grove sensor board size
_grove_width = 20;

// Room below the board
_bottom_space = 2;

// Board thickness
_thickness = 1.85;

// Screw mount space on edge of board
_eye_radius = 2.55; 

// Slide in mounting groove depth
_edge_inset = 0.6;

// USB conncector negative space width
_connector_width = 9;

// USB conncector negative space height
_connector_height = 5;

// USB conncector negative space length (to push some distance beyond the enclosure)
_connector_length = 50;

// Additional space around the module for easly slotting the module into a surrounding case [mm]
_mink = 0.25; // [0:.05:1]

// Length of the negative space exclusion zone in front of the module
_negative_space_height=100;

// Distance from the outside edge of the technic connector linking the top to the bottom
_offset_x = 3.5;

// Distance from the outside edge of the technic connector linking the top to the bottom
_offset_y = 3.7;

// Distance to slide the grove module forward
_grove_y_shift = 0.25;

// Generate print-time support aid structures
_print_supports = true;


///////////////////////////////
// DISPLAY
///////////////////////////////
grove_module_enclosure(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, h=_h, knobs=_knobs, knob_height=_knob_height, knob_vent_radius=_knob_vent_radius, sockets=_sockets, corner_bolt_holes=_corner_bolt_holes, block_height=_block_height, show_bottom_piece=_show_bottom_piece, show_top_piece=_show_top_piece);


module grove_module_enclosure(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, h=undef, knobs=undef, knob_height=undef, knob_vent_radius=undef, sockets=undef, corner_bolt_holes=undef, block_height=undef, show_bottom_piece=undef, show_top_piece=undef) {

    axle_hole_radius=material_axle_hole_radius(material=material, large_nozzle=large_nozzle);

    rotate([0, 0, 180]) {
        if (show_bottom_piece) {
            bottom_piece(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, corner_bolt_holes=corner_bolt_holes, knobs=knobs, knob_height=knob_height, knob_vent_radius=knob_vent_radius, sockets=sockets, block_height=block_height, axle_hole_radius=axle_hole_radius);
        }
        
        if (show_top_piece) {
            top_piece(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, knobs=knobs, knob_height=knob_height, knob_vent_radius=knob_vent_radius, sockets=sockets, corner_bolt_holes=corner_bolt_holes, block_height=block_height, axle_hole_radius=axle_hole_radius);
        }
    }
}

/////////////////////////////////////
// FUNCTIONS
/////////////////////////////////////

function vertical_offset(block_height, h)=(block_height(2*h, block_height=block_height)-_grove_width)/2;



/////////////////////////////////////
// MODULES
/////////////////////////////////////

module bottom_piece(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, h=undef, corner_bolt_holes=undef, knobs=undef,knob_height=undef, knob_vent_radius=undef, sockets=undef, block_height=undef, axle_hole_radius=undef) {

    difference() {
        union() {
            PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, h=h, knobs=knobs, knob_height=knob_height, knob_vent_radius=knob_vent_radius, knob_flexture_height=0, sockets=sockets, top_vents=false, solid_first_layer=true, solid_upper_layers=true, corner_bolt_holes=corner_bolt_holes, side_holes=0, end_holes=0, block_height=block_height, side_sheaths=false, end_sheaths=true);

            double_end_connector_sheath_set(material=material, large_nozzle=large_nozzle, l=l, w=w, end_holes=0, peg_length=_peg_length, bearing_sheath_thickness=_bearing_sheath_thickness, block_height=block_height, skin=_skin);
        }
    
        union() {
            translate([(block_width(4)-_grove_width)/2, side_shell(large_nozzle), vertical_offset(block_height=block_height, h=h)]) {
                rotate([0, -90, 270]) {
                    grove(material=material);
                }
            }

            double_end_connector_hole_set(material=material, large_nozzle=large_nozzle, l=l, w=w, hole_type=2, axle_hole_radius=axle_hole_radius, block_height=block_height);

            if (corner_bolt_holes) {
                corner_corner_bolt_holes(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius, block_height=block_height, side_sheaths=false);
            }
            
            skin(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, block_height=block_height, skin=_skin, ridge_width=_ridge_width, ridge_depth=_ridge_depth);
        }
    }
}


// Top piece
module top_piece(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, h=undef, corner_bolt_holes=undef, knobs=undef, knob_height=undef, knob_vent_radius=undef, sockets=undef, block_height=undef, axle_hole_radius=undef) {

    translate([0, block_width(w + 0.5), 0]) {
        main_top_piece(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, corner_bolt_holes=corner_bolt_holes, knobs=knobs, knob_height=knob_height, knob_vent_radius=knob_vent_radius, sockets=sockets, block_height=block_height, axle_hole_radius=axle_hole_radius);

        if (_print_supports) {
            difference() {
                union() {
                    top_supports(l=l, h=h, block_height=block_height);

                    difference() {
                        hull() {
                            top_supports(l=l, h=h, block_height=block_height);
                        }

                        translate([0, 0, _support_connection_height]) {
                            cube([block_width(l), block_width(w+1), block_height(h, block_height)]);
                        }
                    }
                }

                main_top_piece_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, corner_bolt_holes=corner_bolt_holes, knobs=knobs, knob_height=knob_height, knob_vent_radius=knob_vent_radius, sockets=sockets, axle_hole_radius=axle_hole_radius, block_height=block_height);
            }
        }
    }
}


// Primary shape of the top piece
module main_top_piece(material=undef, large_nozzle=undef, l=undef, w=undef, h=undef, corner_bolt_holes=undef, knobs=undef, knob_height=undef, knob_vent_radius=undef, sockets=undef, block_height=undef, axle_hole_radius=undef) {

    difference() {
        union() {
            PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, h=h, knobs=knobs, knob_height=knob_height, knob_vent_radius=knob_vent_radius, sockets=sockets, top_vents=false, corner_bolt_holes=corner_bolt_holes, side_holes=0, end_holes=0, block_height=block_height, side_sheaths=false, end_sheaths=true);
        
            translate([0, 0, block_height(1, block_height=block_height)]) {
                double_end_connector_sheath_set(material=material, large_nozzle=large_nozzle, l=l, w=w, end_holes=0, peg_length=_peg_length, bearing_sheath_thickness=_bearing_sheath_thickness, skin=_skin, block_height=block_height);
            }
        }
        
        union() {
            translate([(block_width(l)-_grove_width)/2, 1.2, block_height(-h, block_height=block_height)+vertical_offset(block_height=block_height, h=h)]) {
                rotate([0,-90,270]) {
                    grove(material=material);
                }
            }
            
            translate([0, 0, block_height(1, block_height=block_height)]) {
                double_end_connector_hole_set(material=material, large_nozzle=large_nozzle, l=l, w=w, hole_type=2, axle_hole_radius=axle_hole_radius, block_height=block_height);
            }

            if (corner_bolt_holes) {
                corner_corner_bolt_holes(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius);
            }
            
            skin(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, skin=_skin, ridge_width=_ridge_width, ridge_depth=_ridge_depth, block_height=block_height);
        }
    }
}


// The negative space which supports should not enter to be too close to the top piece
module main_top_piece_space(material=undef, large_nozzle=undef, l=undef, w=undef, h=undef, knobs=undef, knob_height=undef, knob_vent_radius=undef, sockets=undef, axle_hole_radius=undef, corner_bolt_holes=undef, block_height=undef) {
    
    minkowski() {
        main_top_piece(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, knobs=knobs, knob_height=knob_height, knob_vent_radius=knob_vent_radius, sockets=sockets, axle_hole_radius=axle_hole_radius, corner_bolt_holes=corner_bolt_holes, block_height=block_height);

        sphere(r=_support_offset_from_part, $fn=8);
    }    
}


// Supports to prevent the long overhangs from drooping
module top_supports(l=undef, h=undef, block_height=undef) {
    
    assert(l!=undef);
    assert(h!=undef);
    assert(block_height!=undef);
    
    support_side_length=4;
    height = block_height(h, block_height) - 1.95 - _skin;
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
module grove(material=undef) {

    translate([0, 0, _grove_y_shift]) {
        minkowski() {
            union() {
                board();
                negative_space();            
            }
            
            sphere(r=_mink, $fn=8);
        }
    }
}

// Grove module main board (PCB with two screw mounts)
module board() {
    
    translate([0, 0, _bottom_space]) {
        cube([_grove_width, _grove_width, _thickness]);
    }

    translate([0, _grove_width/2, _bottom_space]) {
        eye();
    }
    
    translate([_grove_width, _grove_width/2, _bottom_space]) {
        eye();
    }
    
    translate([(_grove_width-_connector_width)/2, -(_connector_length-_grove_width)/2, _bottom_space+_thickness]) {
        cube([_connector_width, _connector_length, _connector_height]);
    }
}

// The bump on the side of a Grove module where a screw holder can be inserted. In this design, this is simply used for orienting the Grove module within another block (no screws are usually used)
module eye() {
    cylinder(r=_eye_radius, h=_thickness);
}

// Space for the board components and access to the Grove connector on the front of the board (no material is here)
module negative_space() {

    translate([_edge_inset, _edge_inset, 0]) {
        cube([_grove_width-2*_edge_inset, _grove_width-2*_edge_inset, _negative_space_height]);
    }
}
