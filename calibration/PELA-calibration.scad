/*
PELA Blocks 3D Print Calibration Bar

Published at http://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    http://futurice.com
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-technic-block.scad>
use <../PELA-block.scad>

/* [PELA Calibration Block Options, for convenience "tight" knobs are matched with equally "loose" sockets, but your best fit may not be identical. Test against real PELA first, then 3D printed to 3D printed using a calibration block with your selected paramters] */

// Length of each calibration block (PELA unit count)
l = 2; 

// Width of each calibration block (PELA unit count)
w = 2;

// Height of the block (PELA unit count, use 1/3 for short calibration panel)
h = 1;

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes = false;

end_holes = 0;

side_holes = 2;

side_sheaths = true;

top_vents = false;

knobs = 1;

top_shell = 1;

top_tweak = 0;

bottom_tweak = 0;

axle_hole_tweak = 0;

// Font for calibration block text labels
font = "Arial";

// Text size on calibration blocks
font_size = 4;

// Depth of text labels on calibration blocks
text_extrusion_height = 0.6;

// Inset from block edge for text (vertical and horizontal)
vertical_text_margin = 0.2;

// Inset from block edge for text (vertical and horizontal)
horizontal_text_margin = 1;

// Size between calibration block test steps (0.02 or larger for a rough calibration, 0.01 to refine if already close)
calibration_block_increment = 0.02;


/////////////////////////////////////
// PELA Calibration Display
/////////////////////////////////////

PELA_calibration_bar();

/////////////////////////////////////
// PELA CALIBRATION BLOCK MODULES
//
// A single block or array of PELA blocks with different parameters.
// Use these to find the ideal fit with real PELA blocks
// for a given printer, settings and plastic combination. Pre-generated examples and numbers are as a guide only
// based on tests with a Lulzbot Taz 6 printer and give example results but may not be suitable for your setup.
/////////////////////////////////////


// A set of calibration blocks in a row with reduced inter-block spacing to print faster
module PELA_calibration_bar(l=l, w=w, h=h, calibration_block_increment=calibration_block_increment, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_flexture_radius=knob_flexture_radius, bolt_holes=bolt_holes, block_height=block_height, knobs=knobs) {
    
    from=-4;
    to=4;
    
    // Tighter top, looser bottom
    for (i = [from:to]) {
        cal = i*calibration_block_increment;
        
        translate([i*block_width(l)-i*shell, 100*cal, 0])
            PELA_calibration_block(l=l, w=w, h=h, top_tweak=cal, bottom_tweak=cal, axle_hole_tweak=cal, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, ring_radius=ring_radius, knob_flexture_radius=knob_flexture_radius, skin=0, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);
    }
}


// A block with the top and bottom connector tweak parameters etched on the side
module PELA_calibration_block(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, axle_hole_tweak=axle_hole_tweak, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, ring_radius=ring_radius, knob_flexture_radius=knob_flexture_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs) {
    
    difference() { 
        PELA_technic_block(l=l, w=w, h=h, axle_hole_radius=axle_hole_radius+axle_hole_tweak, knob_radius=knob_radius+top_tweak, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, ring_radius=ring_radius+bottom_tweak, knob_flexture_radius=knob_flexture_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);

        union() {
            translate([skin+horizontal_text_margin, text_extrusion_height+skin-defeather, skin+block_height(h)-vertical_text_margin])
                rotate([90,0,0]) 
                    PELA_calibration_top_text(str(top_tweak));
            
            translate([skin+horizontal_text_margin, block_width(w)-text_extrusion_height-skin+defeather, skin+vertical_text_margin])
                rotate([90, 0, 180])
                    PELA_calibration_bottom_text(str(bottom_tweak));
        }
    }
}

// Text for the front side of calibration block prints
module PELA_calibration_top_text(txt="Text") {
    
    linear_extrude(height=text_extrusion_height) {        
        if (knobs) {    
            text(text=txt, font=font, size=font_size, halign="left", valign="top");
        }
    }
}

// Text for the back side of calibration block prints
module PELA_calibration_bottom_text(txt="Text") {
    
    if (sockets) {
        linear_extrude(height=text_extrusion_height) {
            text(text=txt, font=font, size=font_size, halign="right");
        }
    }
}


