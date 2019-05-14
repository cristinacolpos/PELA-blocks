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
use <../technic-beam/PELA-technic-beam.scad>
use <../technic-beam/PELA-technic-twist-beam.scad>
use <../technic-mount/PELA-technic-box.scad>
use <PELA-panel-sign.scad>


/* [Render] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;



/* [Panel Sign] */

// Length of the sign (PELA knob count)
l = 4;  // [1:1:20]

// Width of the sign (PELA knob count)
w = 4; // [1:1:20]

// Distance from length ends of connector twist [blocks]
twist_l = 1; // [1:18]

// Distance from width ends of connector twist [blocks]
twist_w = 2; // [1:18]

// Height of the enclosure [blocks]
h = 1; // [1:1:20]

// Interior fill style
center = 2; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel]

// The first line of text
edge_text = "Hki";

// The first line of text
line_1 = "Jee!";

// The second line of text
line_2 = "001";
 
// Depth of text etching into top surface
text_depth = 1; // [0.0:0.1:2]

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

PELA_technic_sign(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, edge_text=edge_text, line_1=line_1, line_2=line_2, lang=lang, text_depth=text_depth, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, top_vents=top_vents, corner_bolt_holes=corner_bolt_holes, sockets=sockets, knobs=knobs, block_height=block_height);



///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_technic_sign(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, line_1=undef, line_2=undef, lang=undef, edge_text=undef,  text_depth=undef, f1=undef, f2=undef, fs1=undef, fs2=undef, left_margin=undef, vertical_margin=undef, top_vents=undef, corner_bolt_holes=undef, sockets=undef, knobs=undef, block_height=undef) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(edge_text!=undef);
    assert(line_1!=undef);
    assert(line_2!=undef);
    assert(lang!=undef);
    assert(text_depth!=undef);
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
            difference() {
                technic_box(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, twist_l=twist_l, twist_w=twist_w, sockets=sockets, knobs=knobs, knob_vent_radius=knob_vent_radius, solid_first_layer=solid_first_layer, center=center, text=edge_text, text_depth=text_depth, block_height=block_height);
                
                translate([3, 4, block_height(h-0.5, block_height)-text_depth])
                    PELA_sign_etched_text(material=material, large_nozzle=large_nozzle, l=l, w=2, line_1=line_1, line_2=line_2, lang=lang, text_depth=text_depth+skin, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, block_height=block_height);
            }

            PELA_flat_sign_extruded_text();
        }

        cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=h, block_height=block_height, knob_height=knob_height);
    }
}
