/*
Parametric LEGO Block

Published at
    http://www.thingiverse.com/thing:2303714
Maintained at
    https://github.com/paulirotta/parametric_lego
See also the related files
    LEGO Sign Generator - https://www.thingiverse.com/thing:2546028
    LEGO Enclosure Generator - https://www.thingiverse.com/thing:2544197


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com

Import this into other design files:
    use <lego.scad>
*/

include <../lego-parameters.scad>
use <../lego.scad>
use <../technic.scad>

/* [LEGO Panel Options] */

// Length of the block (LEGO unit count)
l = 4; 

// Width of the block (LEGO unit count)
w = 4;

top_vents = 0;

// Interior fill for layers above the bottom
solid_bottom_layer = 0; // [0:empty, 1:solid]

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0; // [0:no holes, 1:holes]

// Size of corner holes for M3 mountings bolts
bolt_hole_radius=1.5;

// Presence of top connector knobs
knobs=1; // [0:disabled, 1:enabled]

// Height of horizontal surface strengthening slats (appears between the bottom rings)
bottom_stiffener_height=block_height/3;


/////////////////////////////////////
// LEGO panel display
/////////////////////////////////////

lego_knob_panel();

/////////////////////////////////////
// LEGO PANEL modules
/////////////////////////////////////

module lego_knob_panel(l=l, w=w, top_vents=top_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs) {
    
    defeather=0.01;
    
    translate([0, 0, lego_height(-2/3)])
        difference() {
            lego_technic(l=l, w=w, h=1, top_vents=top_vents, solid_bottom_layer=    solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, side_holes=0, end_holes=0, bottom_stiffener_height=bottom_stiffener_height);
    
            translate([-defeather, -defeather])
            cube([lego_width(l+1), lego_width(w+1), panel_height(2)]);
        }
}

