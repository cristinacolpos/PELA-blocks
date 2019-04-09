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
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../PELA-knob-panel.scad>



/* [Panel Sign] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Length of the sign (PELA knob count)
l = 7;  // [1:1:20]

// Width of the sign (PELA knob count)
w = 1; // [1:1:20]

// The top line of text. Set to "" to not have any top line
line_1 = "";

// The second line of text
line_2 = "PELAblocks.org";

// true=>text is pushing outward from the PELA block, false=>etch text into the block
extrude = true;

// Presence of top connector knobs
knobs = false;

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
extrusion_height = 0.5;

// Left text margin (mm)
left_margin = 1.8;

// Top and bottom text margin (mm)
vertical_margin = 0.3;

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
corner_bolt_holes = false;

// Presence of bottom connector sockets
sockets = true;



/* [Hidden] */

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;




///////////////////////////////
// DISPLAY
///////////////////////////////

// Enable these one at a time if a dual-color print

PELA_panel_sign(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, extrude=extrude,  extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, top_vents=top_vents, corner_bolt_holes=corner_bolt_holes, sockets=sockets, knobs=knobs, block_height=block_height);



///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_panel_sign(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, line_1=undef, line_2=undef, lang=undef, extrude=undef,  extrusion_height=undef, f1=undef, f2=undef, fs1=undef, fs2=undef, left_margin=undef, vertical_margin=undef, top_vents=undef, corner_bolt_holes=undef, sockets=undef, knobs=undef, block_height=undef) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(line_1!=undef);
    assert(line_2!=undef);
    assert(lang!=undef);
    assert(extrude!=undef);
    assert(extrusion_height!=undef);
    assert(f1!=undef);
    assert(f2!=undef);
    assert(fs1!=undef);
    assert(fs2!=undef);
    assert(left_margin!=undef);
    assert(vertical_margin!=undef);
    assert(top_vents!=undef);
    assert(corner_bolt_holes!=undef);
    assert(sockets!=undef);
    assert(knobs!=undef);
    assert(block_width!=undef);

    difference() {
        union() {
            if (extrude) {
                difference() {
                    knob_panel(material=material, large_nozzle=large_nozzle, l=l, w=w, top_vents=top_vents, solid_first_layer=solid_first_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, sockets=sockets, block_height=block_height);

                    PELA_flat_sign_extruded_text(material=material, large_nozzle=large_nozzle, l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, extrude=extrude,  extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, top_vents=top_vents, side_holes=0, end_holes=0, corner_bolt_holes=corner_bolt_holes, sockets=sockets, knobs=knobs, block_height=block_height);
                }
            } else {
                difference() {
                    knob_panel(material=material, large_nozzle=large_nozzle, l=l, w=w, top_vents=top_vents, solid_first_layer=solid_first_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, sockets=sockets, block_height=block_height);
                    
                    translate([skin, 0, -extrusion_height])
                        PELA_sign_etched_text(material=material, large_nozzle=large_nozzle, l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height+skin, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, block_height=block_height);
                }
            }

            color("blue") PELA_flat_sign_extruded_text();
        }

        cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=2, block_height=block_height, knob_height=knob_height);
    }
}


// A PELA block with text on the top
module PELA_flat_sign_extruded_text(material=undef, large_nozzle=undef, l=undef, w=undef, line_1=undef, line_2=undef, lang=undef, extrude=undef,  extrusion_height=undef, f1=undef, f2=undef, fs1=undef, fs2=undef, left_margin=undef, vertical_margin=undef, top_vents=undef, side_holes=undef, side_sheaths=undef, end_holes=undef, end_sheaths=undef, corner_bolt_holes=undef, sockets=undef, knobs=undef, block_height=undef) {
    
    if (extrude) {
        translate([skin, skin, 0])
            PELA_sign_extruded_text(material=material, large_nozzle=large_nozzle, l=l, w=w, line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, block_height=block_height);
    }
}


// Two lines of text extruded out from the surface
module PELA_sign_extruded_text(material=undef, large_nozzle=undef, l=undef, w=undef, line_1=undef, line_2=undef, lang=undef, extrusion_height=undef, f1=undef, f2=undef, fs1=undef, fs2=undef, left_margin=undef, vertical_margin=undef, block_height=undef) {
    
    translate([left_margin+skin, -vertical_margin+block_width(w)-skin, panel_height(block_height=block_height)-extrusion_height]) {
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_1, lang=lang, font=f1, font_size=fs1, vertical_alignment="top", extrusion_height=extrusion_height*2);
    }

    translate([left_margin+skin, vertical_margin+skin, panel_height(block_height=block_height)-extrusion_height]) {
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_2, lang=lang, font=f2, font_size=fs2, vertical_alignment="bottom", extrusion_height=extrusion_height*2);
    }
}


// Two lines of text etched into the surface
module PELA_sign_etched_text(material=undef, large_nozzle=undef, l=undef, w=undef, h=undef, line_1=undef, line_2=undef, lang=undef,  extrusion_height=undef, f1=undef, f2=undef, fs1=undef, fs2=undef, left_margin=undef, vertical_margin=undef, block_height=undef) {
    
    translate([left_margin+skin, -vertical_margin+block_width(w)-skin, panel_height(block_height=block_height)]) {
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_1, lang=lang, extrusion_height=extrusion_height, font=f1, font_size=fs1, vertical_alignment="top");
    }
    
    translate([left_margin+skin, vertical_margin+skin, panel_height(block_height=block_height)]) {
        PELA_text(material=material, large_nozzle=large_nozzle, text=line_2, lang=lang, extrusion_height=extrusion_height, font=f2, font_size=fs2, vertical_alignment="bottom");
    }
}


// Text for the top of blocks
module PELA_text(material=undef, large_nozzle=undef, text=undef, lang=undef, extrusion_height=undef, font=undef, font_size=undef, vertical_alignment=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(text!=undef);
    assert(lang!=undef);
    assert(extrusion_height!=undef);
    assert(font!=undef);
    assert(font_size!=undef);
    assert(vertical_alignment!=undef);

   linear_extrude(height=extrusion_height) {
        text(text=text, language=lang, font=font, size=font_size, halign="left", valign=vertical_alignment);
   }
}
