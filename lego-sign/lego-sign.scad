/*
Parametric LEGO End Cap Enclosure Generator

Create 2 symmetric end pieces which can support a solid object with LEGO-compatible attachment points on top and bottom. By printing only the end pieces instead of a complele enclosure, the print is minimized

Published at
    https://www.thingiverse.com/thing:2546028
Based on
    https://www.thingiverse.com/thing:2303714
Maintained at
    https://github.com/paulirotta/parametric_lego

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com

Import this into other design files:
    use <lego-sign.scad>
*/

include <../lego_parameters.scad>
use <../lego.scad>

/* [LEGO Sign Options] */

// Length of the sign (LEGO knob count)
l = 8; 

// Width of the sign (LEGO knob count)
w = 1;

// Height of the sign (LEGO brick layers)
h = 2;

// The top line of text. Set to "" to not have any top line
line_1 = "LEGO Robotics";

// The second line of text
line_2 = "Rapid Prototyping";

// 1=>text is pushing outward from the LEGO block, 0=>etch text into the block
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

// How deeply into the LEGO block to etch/extrude the text
extrusion_height = 0.5;

// Left text margin (mm)
left_margin = 3;

// Top and bottom text margin (mm)
vertical_margin = 3;



/////////////////////////////////////
// LGEO Sign Display

lego_sign();

///////////////////////////////////

// A LEGO brick with text on the side
module lego_sign(line_1=line_1, line_2=line_2, lang=lang, extrude=extrude,  extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak) {
    
    if (is_true(extrude)) {
        lego(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, layer_ridge=0);
        
        translate([lego_skin_width(skin=skin), lego_skin_width(skin=skin), 0])
            lego_sign_extruded_text(line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak);

        if (is_true(copy_to_back)) {
            translate([lego_width(l), lego_width(w)-lego_skin_width(skin=skin), 0])
                rotate([0, 0, 180])
                    lego_sign_extruded_text(line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, l=l, w=w, h=h);
        }
    } else {
        difference() {
            lego(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, layer_ridge=0);
            
            union() {
                translate([lego_skin_width(skin=skin), 0, 0])
                    lego_sign_etched_text(line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height+lego_skin_width(), f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, l=l, w=w, h=h);

                if (is_true(copy_to_back)) {
                    translate([lego_width(l)-lego_skin_width(skin=skin), lego_width(w)-lego_skin_width(skin=skin), 0])
                        rotate([0, 0, 180])
                            lego_sign_etched_text(line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height+lego_skin_width(), f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, l=l, w=w, h=h);
                }
            }
        }
    }
}


// Two lines of text extruded out from the surface
module lego_sign_extruded_text(line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, l=l, w=w, h=h) {
    
    translate([left_margin, 0, lego_height(h)-vertical_margin])
        lego_text(text=line_1, lang=lang, font=f1, font_size=fs1, vertical_alignment="top");
    translate([left_margin, 0, vertical_margin])
        lego_text(text=line_2, lang=lang, font=f2, font_size=fs2, vertical_alignment="bottom");
}


// Two lines of text etched into the surface
module lego_sign_etched_text(line_1=line_1, line_2=line_2, lang=lang,  extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, l=l, w=w, h=h) {
    
    translate([left_margin, extrusion_height, lego_height(h)-vertical_margin])
        lego_text(text=line_1, lang=lang, extrusion_height=extrusion_height, font=f1, font_size=fs1, vertical_alignment="top");
    
    translate([left_margin, extrusion_height, vertical_margin])
        lego_text(text=line_2, lang=lang, extrusion_height=extrusion_height, font=f2, font_size=fs2, vertical_alignment="baseline");
}


// Text for the side of calibration block prints
module lego_text(text=line_1, lang=lang, extrusion_height=extrusion_height, font=f1, font_size=fs1, vertical_alignment="bottom") {
    rotate([90,0,0])
        linear_extrude(height=extrusion_height)
            text(text=text, language=lang, font=font, size=font_size, halign="left", valign=vertical_alignment);
}
