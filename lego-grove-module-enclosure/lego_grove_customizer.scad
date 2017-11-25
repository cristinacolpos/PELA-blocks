/*
Parametric LEGO Grove Module Enclosure
From http://www.thingiverse.com/thing:2298129
Maintained at https://github.com/paulirotta/lego_grove/
Designed for use with http://wiki.seeed.cc/Grove_System/

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike License
https://creativecommons.org/licenses/by-sa/4.0/legalcode

Although this file is parametric and designed for use with an online customizer, it is too slow and things break in the cloud- you must download it to make changes vs the pre-generated .STL files normally found with this file.
*/

include <../lego-parameters.scad>
use <../lego.scad>
use <../lego-technic.scad>

/* [LEGO Connector Fit Options] */

// Interior fill for layers above the bottom
solid_upper_layers = 1; // [0:empty, 1:solid]

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0; // [0:no holes, 1:holes]

side_holes=0;

end_holes=0;

end_hole_sheaths = 1;

bottom_stiffener_height=9.6;

top_vents(1);

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

connector_width=9;

connector_height=7.2;

connector_length=50;

// Additional space around the module for easly slotting the module into a surrounding case (make this bigger if the board fits too tightly)
mink = 0.25;

// Length of the negative space exclusion zone in front of the module
negative_space_height=100;



///////////////////////////////

bottom_piece();
top_piece();

// Bottom piece
module bottom_piece() {
difference() {
    lego_technic(4,2,1.5);
    
    translate([(lego_width(4)-grove_width)/2, shell, (lego_height(3)-grove_width)/2])
        rotate([0,-90,270])
            grove();
};
}


// Optional top piece
module top_piece() {
translate([0, lego_width(2.5), 0])
    difference() {
        lego_technic(4,2,1.5);
        
        translate([(lego_width(4)-grove_width)/2,1.2,-lego_height(1.5)+(lego_height(3)-grove_width)/2])
            rotate([0,-90,270])
                grove();
};
}    
    

///////////////////////////////
    
// A complete Grove module negative space assembly. These are all the areas where you do _not_ want material in order to be able to place a real Grove module embedded within another part
module grove() {
    minkowski() {
        union() {
            board();
            negative_space();            
        }
        
        sphere(r=mink);
    }
}

// Grove module main board (PCB with two screw mounts)
module board() {
    translate([0,0,bottom_space])
        cube([grove_width, grove_width, thickness]);

    translate([0, grove_width/2,bottom_space])
        eye();
    
    translate([grove_width, grove_width/2,bottom_space])
        eye();
    
    translate([(grove_width-connector_width)/2, -(connector_length-grove_width)/2, 0])
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

// A 4-2-3 LEGO block with a Grove-sized hole in it. This block must be sliced into top and bottom halves (.scad files elsewhere) in order for you to be able to fit the Grove module inside.
module lego_grove() {
    difference() {
        lego(4,2,1.5);
        translate([grove_width + (lego_width(4)-grove_width)/2,lego_width(2)-2*shell,(lego_height(3)-grove_width)/2])
            rotate([90,0,0]) rotate([0,0,90]) 
            grove();       
    }
}


