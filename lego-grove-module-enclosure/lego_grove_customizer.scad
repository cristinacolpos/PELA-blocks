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

/* [LEGO Connector Fit Options] */

// Top connector size tweak (0 is nominal spec for ABS. Try -0.05 for PLA, NGEN and other stiff plastic if the top connector is too tight)
top_tweak = 0; //-0.05;

// Bottom connector size tweak (0 is nominal spec for ABS, Try -0.05 for NGEN, PLA and other stiff stiff plastic if the bottom connector is too tight)
bottom_tweak = 0; //-0.05;

// Interior fill for layers above the bottom
solid_upper_layers = 1; // [0:empty, 1:solid]

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0; // [0:no holes, 1:holes]

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

// Additional space around the module for easly slotting the module into a surrounding case (make this bigger if the board fits too tightly)
mink = 0.25;

// Length of the negative space exclusion zone in front of the module
negative_space_height=100;

// For use in other code: use <grove_module.scad>
function grove_width() = grove_width;

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
        cube([grove_width,grove_width,thickness]);
    translate([grove_width/2,0,bottom_space])
        eye();
    translate([grove_width/2,grove_width,bottom_space])
        eye();            
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
module lego_grove(top_size_tweak=0,bottom_size_tweak=0) {
    difference() {
        lego(4,2,3,top_size_tweak,bottom_size_tweak);
        translate([grove_width() + (lego_width(4)-grove_width())/2,lego_width(2)-2*block_shell,(lego_height(3)-grove_width())/2])
            rotate([90,0,0]) rotate([0,0,90]) 
            grove();       
    }
}

////////////////////////////////

// Size of the cut block to separate top and top parts (any sufficiently large number)
s = 1000;

// The shape, including alignment notch, which separates the top and bottom halves of a part
module cut_block(h = 3) {
    translate([-s/2, -s/2, h/2 - s])
        cube(s,s,s);
}


/////////////////////////////////


translate([0,0,-lego_height(1.5)+knob_height/2]) 
difference() {
    lego_grove(top_tweak,bottom_tweak);
    cut_block(lego_height(3)+skin);
}


///////////////////////////////



// This piece is flipped upside down for ease of printing next to the top half pieces with support strctures turned on. Cleaning support structures from the bottom connector of LEGO would be messy and most people will print top and bottom halves at the same time.
translate([-5,0,lego_height(1.5)-knob_height/2]) 
rotate([0,180,0])
    intersection() {
        lego_grove(top_tweak,bottom_tweak);
        cut_block(lego_height(3)-skin);
    }