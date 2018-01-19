/*
Parametric PELA End Cap Enclosure Generator

Create 2 symmetric end pieces which can support a solid object with PELA-compatible attachment points on top and bottom. By printing only the end pieces instead of a complele enclosure, the print is minimized

Published at
    https://www.thingiverse.com/thing:2546028
Based on
    https://www.thingiverse.com/thing:2303714
Maintained at
    https://github.com/paulirotta/parametric_PELA

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com

Import this into other design files:
    use <PELA-sign.scad>
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>

/* [PELA Sign Options] */

// Length of the sign (PELA knob count)
l = 8; 

// Width of the sign (PELA knob count)
w = 1;

// Height of the sign (PELA brick layers)
h = 2;

// The top line of text. Set to "" to not have any top line
line_1 = "PELA Blocks";

// The second line of text
line_2 = "Rapid Prototyping";

// 1=>text is pushing outward from the PELA block, 0=>etch text into the block
extrude = 1;

// Place the text on both sides (1=>true, 0=>false)
copy_to_back = 1;

// Language of the text
lang = "en";

// The font to use for text on the top line
f1 = "Liberation Sans:style=Bold Italic";

// The font to use for text on the bottom line
f2 = "Arial";

// The font size (points) of the top line
fs1 = 5.8;

// The font size (points) of the bottom line
fs2 = 5;

// How deeply into the PELA block to etch/extrude the text
extrusion_height = 0.5;

// Left text margin (mm)
left_margin = 3;

// Top and bottom text margin (mm)
vertical_margin = 3;

// Width of a line etched in the side of multi-layer block sets (0 to disable, 0.15 on other types of blocks)
ridge_width = 0;

// Depth of a line etched in the side of multi-layer block sets (unused if ridge_width=0)
ridge_depth = 0.3;



/////////////////////////////////////
// LGEO Sign Display

PELA_sign();

///////////////////////////////////

// A PELA brick with text on the side
module PELA_sign(l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang, extrude=extrude,  extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin) {
    
    if (is_true(extrude)) {
        PELA_technic_block(l=l, w=w, h=h, ridge_width=ridge_width, ridge_depth=ridge_depth);
        
        translate([skin, skin, 0])
            PELA_sign_extruded_text(l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin);

        if (is_true(copy_to_back)) {
            translate([block_width(l), block_width(w)-skin, 0])
                rotate([0, 0, 180])
                    PELA_sign_extruded_text(l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin);
        }
    } else {
        difference() {
            PELA_technic_block(l=l, w=w, h=h, ridge_width=ridge_width, ridge_depth=ridge_depth);
            
            union() {
                translate([skin, 0, 0])
                    PELA_sign_etched_text(l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height+skin, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin);

                if (is_true(copy_to_back)) {
                    translate([block_width(l)-skin, block_width(w)-skin, 0])
                        rotate([0, 0, 180])
                            PELA_sign_etched_text(l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height+skin, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin);
                }
            }
        }
    }
}


// Two lines of text extruded out from the surface
module PELA_sign_extruded_text(l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin) {
    
    translate([left_margin, 0, block_height(h)-vertical_margin])
        PELA_text(text=line_1, lang=lang, font=f1, font_size=fs1, vertical_alignment="top");
    translate([left_margin, 0, vertical_margin])
        PELA_text(text=line_2, lang=lang, font=f2, font_size=fs2, vertical_alignment="bottom");
}


// Two lines of text etched into the surface
module PELA_sign_etched_text(l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang,  extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin) {
    
    translate([left_margin, extrusion_height, block_height(h)-vertical_margin])
        PELA_text(text=line_1, lang=lang, extrusion_height=extrusion_height, font=f1, font_size=fs1, vertical_alignment="top");
    
    translate([left_margin, extrusion_height, vertical_margin])
        PELA_text(text=line_2, lang=lang, extrusion_height=extrusion_height, font=f2, font_size=fs2, vertical_alignment="baseline");
}


// Text for the side of calibration block prints
module PELA_text(text=line_1, lang=lang, extrusion_height=extrusion_height, font=f1, font_size=fs1, vertical_alignment="bottom") {
    rotate([90,0,0])
        linear_extrude(height=extrusion_height)
            text(text=text, language=lang, font=font, size=font_size, halign="left", valign=vertical_alignment);
}