/*
PELA Parametric Flat Sign Generator

PELA Parametric Blocks - 3D Printed LEGO-compatible parametric blocks

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Import this into other design files:
    use <PELA-flat-sign.scad>
    use <../PELA-block.scad>
    use <../PELA-technic-block.scad>
*/

include <../style.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../PELA-knob-panel.scad>

/* [Panel Sign] */

// Printing material
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the nozzle >= 0.5mm? If so, some features get larger to make printing easier (and slightly slower)
large_nozzle = true;

// Length of the sign (PELA knob count)
l = 7; 

// Width of the sign (PELA knob count)
w = 1;

// The top line of text. Set to "" to not have any top line
line_1 = "";

// The second line of text
line_2 = "PELAblocks.org";

// true=>text is pushing outward from the PELA block, false=>etch text into the block
extrude = true;

// Language of the text
lang = "en";

// The font to use for text on the top line
f1 = "Liberation Sans:style=Bold Italic";

// The font to use for text on the bottom line
f2 = "Arial:style=Bold";

// The font size (points) of the top line
fs1 = 4.8;

// The font size (points) of the bottom line
fs2 = 5;

// How deeply into the PELA block to etch/extrude the text
extrusion_height = 0.8;

// Left text margin (mm)
left_margin = 1.8;

// Top and bottom text margin (mm)
vertical_margin = 0.3;

// Add full width through holes spaced along the length for PELA Techics connectors
side_holes = 3;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around Technic side holes (only used if there are side_holes, disable for extra ventilation, enable for connector lock notches)
side_sheaths = true;

// Add short end holes spaced along the width for PELA Techics connectors
end_holes = 2;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full length connectors]

// Add a wrapper around end holes  (only used if there are end_holes, disable for extra ventilation, enable for connector lock notches)
end_sheaths = true;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
corner_bolt_holes = false;

// Presence of bottom connector sockets
sockets = true;

// Presence of top connector knobs
knobs = false;



///////////////////////////////
// DISPLAY
///////////////////////////////

// Enable these one at a time if a dual-color print

color("white") PELA_flat_sign();
color("green") PELA_flat_sign_extruded_text();



///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_flat_sign(material=material, large_nozzle=large_nozzle, l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, extrude=extrude,  extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, corner_bolt_holes=corner_bolt_holes, sockets=sockets, knobs=knobs, block_height=block_height) {
    
    if (extrude) {
        difference() {
            PELA_knob_panel(material=material, large_nozzle=large_nozzle, l=l, w=w, top_vents=top_vents, solid_first_layer=solid_first_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, sockets=sockets, block_height=block_height);

            PELA_flat_sign_extruded_text(material=material, large_nozzle=large_nozzle, l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, extrude=extrude,  extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, corner_bolt_holes=corner_bolt_holes, sockets=sockets, knobs=knobs, block_height=block_height);
        }
    } else {
        difference() {
            PELA_knob_panel(material=material, large_nozzle=large_nozzle, l=l, w=w, top_vents=top_vents, solid_first_layer=solid_first_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, sockets=sockets, block_height=block_height);
            
            translate([skin, 0, -extrusion_height])
                PELA_sign_etched_text(material=material, large_nozzle=large_nozzle, l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height+skin, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, block_height=block_height);
        }
    }
}


// A PELA block with text on the top
module PELA_flat_sign_extruded_text(material=material, large_nozzle=large_nozzle, l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, extrude=extrude,  extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, corner_bolt_holes=corner_bolt_holes, sockets=sockets, knobs=knobs, block_height=block_height) {
    
    if (extrude) {
        translate([skin, skin, 0])
            PELA_sign_extruded_text(material=material, large_nozzle=large_nozzle, l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, block_height=block_height);
    }
}


// Two lines of text extruded out from the surface
module PELA_sign_extruded_text(material=material, large_nozzle=large_nozzle, l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, block_height=block_height) {
    
    translate([left_margin+skin, -vertical_margin+block_width(w)-skin, panel_height(block_height=block_height)-extrusion_height]) {
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_1, lang=lang, font=f1, font_size=fs1, vertical_alignment="top", extrusion_height=extrusion_height*2);
    }

    translate([left_margin+skin, vertical_margin+skin, panel_height(block_height=block_height)-extrusion_height]) {
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_2, lang=lang, font=f2, font_size=fs2, vertical_alignment="bottom", extrusion_height=extrusion_height*2);
    }
}


// Two lines of text etched into the surface
module PELA_sign_etched_text(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, line_1=line_1, line_2=line_2, lang=lang,  extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, block_height=block_height) {
    
    translate([left_margin+skin, -vertical_margin+block_width(w)-skin, panel_height(block_height=block_height)]) {
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_1, lang=lang, extrusion_height=extrusion_height, font=f1, font_size=fs1, vertical_alignment="top");
    }
    
    translate([left_margin+skin, vertical_margin+skin, panel_height(block_height=block_height)]) {
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_2, lang=lang, extrusion_height=extrusion_height, font=f2, font_size=fs2, vertical_alignment="baseline");
    }
}


// Text for the top of blocks
module PELA_text(material=material, large_nozzle=large_nozzle, text=line_1, lang=lang, extrusion_height=extrusion_height, font=f1, font_size=fs1, vertical_alignment="bottom") {

   linear_extrude(height=extrusion_height) {
        text(text=text, language=lang, font=font, size=font_size, halign="left", valign=vertical_alignment);
   }
}
