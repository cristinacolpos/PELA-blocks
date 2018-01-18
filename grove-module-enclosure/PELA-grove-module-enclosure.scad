/*
Parametric PELA Grove Module Enclosure
From http://www.thingiverse.com/thing:2298129
Maintained at https://github.com/paulirotta/PELA_grove/
Designed for use with http://wiki.seeed.cc/Grove_System/

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike License
https://creativecommons.org/licenses/by-sa/4.0/legalcode

Although this file is parametric and designed for use with an online customizer, it is too slow and things break in the cloud- you must download it to make changes vs the pre-generated .STL files normally found with this file.
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>

/* [Grove Enclosure Options] */
// Length of the enclosure (PELA unit count)
l = 4; 

// Width of the enclosure (PELA unit count)
w = 2;

// Height of HALF the enclosure (PELA unit count)
h = 1.5;


// Interior fill for layers above the bottom
solid_upper_layers = 1; // [0:empty, 1:solid]

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes = 1; // [0:no holes, 1:holes]

side_holes = 0;

end_holes = 0;

end_hole_sheaths = 1;

bottom_stiffener_height = 9.6;

top_vents = 0;

/* [Grove Module Options] */

// Grove sensor board size
grove_width = 20;

// Room below the board
bottom_space = 2.2;

// Board thickness
thickness = 1.8;

// Screw mount space on edge of board
eye_radius = 2.5; 

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

// Distance from the outside edge of the Technics connector linking the top to the bottom
offset_x=3.5;

// Distance from the outside edge of the Technics connector linking the top to the bottom
offset_y=3.7;

// Distance to slide the grove module forward
grove_y_shift = 0.25;

///////////////////////////////

bottom_piece();

top_piece();

function vertical_offset()=(block_height(2*h)-grove_width)/2;

/////////////////////////////////////
// MODULES
/////////////////////////////////////

// Bottom piece
module bottom_piece() {
    difference() {
        union() {
            PELA_technic_block(l=l, w=w, knob_flexture_height=0, bolt_holes=bolt_holes, side_holes=side_holes, end_holes=end_holes);
            
            height=block_height(0.33333333);
            translate([0, 0, height])
                cube([block_width(l), block_width(w), block_height(h)-height]);
        }
    
        union() {
            translate([(block_width(4)-grove_width)/2, shell, vertical_offset()])
                rotate([0,-90,270])
                    grove();

/*            
#            translate([offset_x, block_width(2)-offset_y, block_height(h)])
                rotate([180, 0, 0])
                    axle_hole(hole_type=2, length=counterbore_inset_depth+peg_length);
            
#            translate([block_width(l)-offset_x, block_width(2)-offset_y, block_height(h)])
                rotate([180, 0, 0])
                    axle_hole(hole_type=2, length=counterbore_inset_depth+peg_length);
*/            
            if (is_true(bolt_holes)) {
                corner_bolt_holes(l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius);
            }
            
            skin();
        }
    }
}


// Top piece
module top_piece() {

translate([0, block_width(w + 0.5), 0])
    difference() {
        union() {
            PELA_technic_block(l=l, w=w, socket_height=1.8, bolt_holes=bolt_holes, side_holes=side_holes, end_holes=end_holes);
        
            translate([0, 0, block_height(0.5)])
                double_end_connector_sheath_set();
        }
        
        union() {
            translate([(block_width(l)-grove_width)/2, 1.2, block_height(-h)+vertical_offset()])
                rotate([0,-90,270])
                    grove();
            
            translate([0, 0, block_height(0.5)])
                double_end_connector_hole_set(hole_type=2);
            
/*                        
#            translate([offset_x, block_width(2)-offset_y, 0])
                axle_hole(hole_type=2, length=counterbore_inset_depth+peg_length);
            
#            translate([block_width(l)-offset_x, block_width(2)-offset_y, 0])
                axle_hole(hole_type=2, length=counterbore_inset_depth+peg_length);
*/
            if (is_true(bolt_holes)) {
                corner_bolt_holes(l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius);
            }
            
            skin();
        }
};
}    
    

///////////////////////////////
    
// A complete Grove module negative space assembly. These are all the areas where you do _not_ want material in order to be able to place a real Grove module embedded within another part
module grove() {
    translate([0, 0, grove_y_shift])
    minkowski() {
        union() {
            board();
            negative_space();            
        }
        
        sphere(r=mink, $fn=8);
    }
}

// Grove module main board (PCB with two screw mounts)
module board() {
    translate([0,0,bottom_space])
        cube([grove_width, grove_width, thickness]);

    translate([0, grove_width/2,bottom_space])
        eye();
    
    translate([grove_width, grove_width/2, bottom_space])
        eye();
    
    translate([(grove_width-connector_width)/2, -(connector_length-grove_width)/2, bottom_space+thickness])
        cube([connector_width, connector_length, connector_height]);
}

// The bump on the side of a Grove module where a screw holder can be inserted. In this design, this is simply used for orienting the Grove module within another block (no screws are usually used)
module eye() {
    cylinder(r=eye_radius,h=thickness);
}

// Space for the board components and access to the Grove connector on the front of the board (no material is here)
module negative_space() {
    translate([edge_inset,edge_inset,0])
        cube([grove_width-2*edge_inset,grove_width-2*edge_inset,negative_space_height]);
}


/////////////////////////////////

// A 4-2-3 PELA block with a Grove-sized hole in it. This block must be sliced into top and bottom halves (.scad files elsewhere) in order for you to be able to fit the Grove module inside.
module PELA_grove() {
    difference() {
        PELA(4,2,1.5);
        translate([grove_width + (block_width(4)-grove_width)/2, block_width(2)-2*shell, (block_height(3)-grove_width)/2])
            rotate([90,0,90])
            grove();       
    }
}


