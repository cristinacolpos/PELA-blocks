/*
PELA Parametric Flat Sign Generator

PELA Parametric Blocks - 3D Printed LEGO-compatible parametric blocks

Published at http://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com

Import this into other design files:
    use <PELA-flat-sign.scad>
    use <../PELA-block.scad>
    use <../PELA-technic-block.scad>
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../knob-panel/PELA-knob-panel.scad>

/* [PELA Sign Options] */

// Length of the sign (PELA knob count)
l = 8; 

// Width of the sign (PELA knob count)
w = 2;

// Height of the sign (PELA block layers)
h = 1/3;

// The top line of text. Set to "" to not have any top line
line_1 = "PELAblocks.org";

// The second line of text
line_2 = "Rapid Prototyping";

// 1=>text is pushing outward from the PELA block, 0=>etch text into the block
extrude = 0;

// Language of the text
lang = "en";

// The font to use for text on the top line
f1 = "Liberation Sans:style=Bold Italic";

// The font to use for text on the bottom line
f2 = "Arial";

// The font size (points) of the top line
fs1 = 4.8;

// The font size (points) of the bottom line
fs2 = 4.5;

// How deeply into the PELA block to etch/extrude the text
extrusion_height = 0.5;

// Left text margin (mm)
left_margin = 6.5;

// Top and bottom text margin (mm)
vertical_margin = 1.8;

// Add full width through holes spaced along the length for PELA Techics connectors
side_holes = 3;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a sheath around Technic side holes (only used if there are side_holes, disable for extra ventilation, enable for connector lock notches)
side_sheaths = 1; // [0:disabled, 1:enabled]

// Add short end holes spaced along the width for PELA Techics connectors
end_holes = 2;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full length connectors]

// Add a sheath around end holes  (only used if there are end_holes, disable for extra ventilation, enable for connector lock notches)
end_sheaths = 1; // [0:disabled, 1:enabled]

// Add holes in the top deck to improve airflow and reduce weight
top_vents = 0; // [0:disabled, 1:enabled]

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
bolt_holes=1; // [0:no holes, 1:holes]

// Presence of bottom connector sockets
sockets = 1; // [0:no sockets, 1:sockets]

// Presence of top connector knobs
knobs = 0; // [0:disabled, 1:enabled]

/////////////////////////////////////
// PELA Flat Sign Display

PELA_flat_sign();

///////////////////////////////////

// A PELA block with text on the top
module PELA_flat_sign(l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, extrude=extrude,  extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, bolt_holes=bolt_holes, sockets=sockets, knobs=knobs) {
    
    if (is_true(extrude)) {
        PELA_knob_panel(l=l, w=w, top_vents=top_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, sockets=sockets);
        
        translate([skin, skin, 0])
            PELA_sign_extruded_text(l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin);
    } else {
        difference() {
            PELA_knob_panel(l=l, w=w, top_vents=top_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, sockets=sockets);
            
            translate([skin, 0, -extrusion_height])
                PELA_sign_etched_text(l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height+skin, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin);
        }
    }
}


// Two lines of text extruded out from the surface
module PELA_sign_extruded_text(l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin) {
    
    translate([left_margin+skin, -vertical_margin+block_width(w)-skin, block_height(h)])
        PELA_text(text=line_1, lang=lang, font=f1, font_size=fs1, vertical_alignment="top");
    translate([left_margin+skin, vertical_margin+skin, block_height(h)])
        PELA_text(text=line_2, lang=lang, font=f2, font_size=fs2, vertical_alignment="bottom");
}


// Two lines of text etched into the surface
module PELA_sign_etched_text(l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang,  extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin) {
    
    translate([left_margin+skin, -vertical_margin+block_width(w)-skin, block_height(h)])
        PELA_text(text=line_1, lang=lang, extrusion_height=extrusion_height, font=f1, font_size=fs1, vertical_alignment="top");
    
    translate([left_margin+skin, vertical_margin+skin, block_height(h)])
        PELA_text(text=line_2, lang=lang, extrusion_height=extrusion_height, font=f2, font_size=fs2, vertical_alignment="baseline");
}


// Text for the top of blocks
module PELA_text(text=line_1, lang=lang, extrusion_height=extrusion_height, font=f1, font_size=fs1, vertical_alignment="bottom") {

   linear_extrude(height=extrusion_height)
        text(text=text, language=lang, font=font, size=font_size, halign="left", valign=vertical_alignment);
}
