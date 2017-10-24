/*
Parametric LEGO Calibration Block

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

include <../lego_parameters.scad>
use <../lego.scad>

/* [LEGO Calibration Block Options, for convenience "tight" knobs are matched with equally "loose" sockets, but your best fit may not be identical. Test against real LEGO first, then 3D printed to 3D printed using a calibration block with your selected top_tweak and bottom_tweak adjustments] */

// Generator mode: 1=>Full set of calibration bocks (more flexible than clibration bars but takes longer to print), 2=>Tight knob calibration bar, 3=>Tighter knob calibration bar, 4=>Loose knob calibration bar (usually not needed), 5=>A single calibration block with top_tweak and bottom_tweak as specified below
mode=3;

// Length of the block (LEGO knob count)
l = 2; 

// Width of the block (LEGO knob count)
w = 2;

// Top connector size tweak => + = more tight fit, -0.04 for PLA, 0 for ABS, 0.07 for NGEN (NOTE: used only if mode=1, single block)
top_tweak = 0.04;

// Bottom connector size tweak => + = more tight fit, 0.04 for PLA, 0 for ABS, -0.01 NGEN (NOTE: used only if mode=1, single block)
bottom_tweak = -0.04;

// Font for calibration block text labels
font = "Arial";

// Text size on calibration blocks
font_size = 4.5;

// Depth of text labels on calibration blocks
text_extrusion_height = 0.6;

// Inset from block edge for text (vertical and horizontal)
text_margin = 1;

// Size between calibration block tweak test steps
calibration_block_increment = 0.01;


/////////////////////////////////////
// LEGO Calibration Display
/////////////////////////////////////

if (mode==1) {
    // A set of blocks for testing which tweak parameters to use on your printer and plastic
    lego_calibration_set();
} else if (mode==2) {
    // A calibration block
    tight_lego_calibration_bar();
} else if (mode==3) {
    // A calibration block
    tighter_lego_calibration_bar();
} else if (mode==4) {
    // A calibration block
    loose_lego_calibration_bar();
} else if (mode==5) {
    // A single calibration block
    lego_calibration_block();
} else {
    echo("<b>Unsupported: please check <i>mode</i> variable is 1-5</b>");
}


/////////////////////////////////////
// LEGO CALIBRATION BLOCK MODULES
//
// A single block or array of LEGO blocks with different tweak parameters.
// Use these to find the ideal fit with real LEGO bricks
// for a given printer, settings and plastic combination. Pre-generated examples and numbers are as a guide only
// based on tests with a Lulzbot Taz 6 printer and give example results but may not be suitable for your setup.
/////////////////////////////////////

// A set of blocks with different tweak parameters written on the side
module lego_calibration_set(l=l, w=w, calibration_block_increment=calibration_block_increment, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, skin=skin, fn=fn, airhole_fn=airhole_fn) {
    
    // Tighter top, looser bottom
    for (i = [0:5]) {
        translate([i*lego_width(l+0.5), 0, 0])
            lego_calibration_block(l=l, w=w, top_tweak=i*calibration_block_increment, bottom_tweak=-i*calibration_block_increment, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, skin=skin, fn=fn, airhole_fn=airhole_fn);
    }
    
    // Tightest top, loosest bottom
    for (i = [6:10]) {
        translate([(i-5)*lego_width(l+0.5), -lego_width(w+0.5), 0])
            lego_calibration_block(l=l, w=w, top_tweak=i*calibration_block_increment, bottom_tweak=-i*calibration_block_increment, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, skin=skin, fn=fn, airhole_fn=airhole_fn);
    }
    
    // Looser top, tighter bottom
    for (i = [1:5]) {
        translate([i*lego_width(l+0.5), 0, 0])
            lego_calibration_block(l=l, w=w, top_tweak=-i*calibration_block_increment, bottom_tweak=i*calibration_block_increment, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, skin=skin, fn=fn, airhole_fn=airhole_fn);
    }
}

// A set of calibration blocks without skin or inter-block spacing to print faster
module tight_lego_calibration_bar(l=l, w=w, calibration_block_increment=calibration_block_increment, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, fn=fn, airhole_fn=airhole_fn) {
    
    // Tighter top, looser bottom
    difference() {
        union() {
            for (i = [0:5]) {
                translate([i*lego_width(l), 0, 0])
                    lego_calibration_block(l=l, w=w, top_tweak=i*calibration_block_increment, bottom_tweak=-i*calibration_block_increment, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, skin=0, fn=fn, airhole_fn=airhole_fn);
            }
        }

        etch_all_calibration_bar_dividers(length=12);
    }
}

// A set of calibration blocks without skin or inter-block spacing to print faster
module tighter_lego_calibration_bar(l=l, w=w, calibration_block_increment=calibration_block_increment, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, fn=fn, airhole_fn=airhole_fn) {
    
    // Tightest top, loosest bottom
    difference() {
        union() {
            for (i = [6:10]) {
                translate([(i-6)*lego_width(l), 0, 0])
                    lego_calibration_block(l=l, w=w, top_tweak=i*calibration_block_increment, bottom_tweak=-i*calibration_block_increment, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, skin=0, fn=fn, airhole_fn=airhole_fn);
            }
        }
        etch_all_calibration_bar_dividers(length=10);
    }
}

// A set of calibration blocks without skin or inter-block spacing to print faster
module loose_lego_calibration_bar(l=l, w=w, calibration_block_increment=calibration_block_increment, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, fn=fn, airhole_fn=airhole_fn) {
    
    // Looser top, tighter bottom
    difference() {
        union() {
            for (i = [1:5]) {
                translate([(i-1)*lego_width(l), lego_width(w+0.5), 0])
                    lego_calibration_block(l=l, w=w, top_tweak=-i*calibration_block_increment, bottom_tweak=i*calibration_block_increment, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, skin=0, fn=fn, airhole_fn=airhole_fn);
            }
        }

        etch_all_calibration_bar_dividers(length=10);
    }
}

// A block with the top and bottom connector tweak parameters etched on the side
module lego_calibration_block(l=l, w=w, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, skin=skin, fn=fn, airhole_fn=airhole_fn) {
    
    difference() {
        lego(l=l, w=w, h=1, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, skin=skin, fn=fn, airhole_fn=airhole_fn);

        union() {
            translate([lego_skin_width(skin=skin)+text_margin, text_extrusion_height+lego_skin_width(skin=skin)-0.01, lego_skin_width(skin=skin)+lego_height()-text_margin])
                rotate([90,0,0]) 
                    lego_calibration_top_text(str(top_tweak));
            
            translate([lego_skin_width(skin=skin)+text_margin, lego_width(w)-text_extrusion_height-lego_skin_width(skin=skin)+0.01, lego_skin_width(skin=skin)+text_margin])
                rotate([90, 0, 180])
                    lego_calibration_bottom_text(str(bottom_tweak));
        }
    }
}

// Text for the front side of calibration block prints
module lego_calibration_top_text(txt="Text") {
    linear_extrude(height=text_extrusion_height) {
    text(text=txt, font=font, size=font_size, halign="left", valign="top");
     }
}

// Text for the back side of calibration block prints
module lego_calibration_bottom_text(txt="Text") {
    linear_extrude(height=text_extrusion_height) {
       text(text=txt, font=font, size=font_size, halign="right");
     }
}

// Mark lines between each clibration bar section
module etch_all_calibration_bar_dividers(length=4) {
    for (i = [l:l:length-1]) {
        etch_calibration_bar_divider(i=i);
    }
}

// Mark a line between each calibration section of a calibration bar
module etch_calibration_bar_divider(i=l) {
    x = lego_width(i)-layer_ridge/2;

    // Front
    translate([x, 0, 0])
        cube([layer_ridge, layer_ridge_depth, lego_height()]);

    // Back
    translate([x, lego_width(w)-layer_ridge_depth, 0])
        cube([layer_ridge, layer_ridge_depth, lego_height()]);

    // Top
    translate([x, 0, lego_height()-layer_ridge_depth])
        cube([layer_ridge, lego_width(w), layer_ridge_depth]);

    // Bottom
    translate([x, 0, 0])
        cube([layer_ridge, lego_width(w), layer_ridge_depth]);
    
    // Block Separator
    inset=lego_width(0.5)-knob_radius;
    translate([x, inset, 0])
        cube([layer_ridge, lego_width(w)-2*inset, lego_height()]);    
}

