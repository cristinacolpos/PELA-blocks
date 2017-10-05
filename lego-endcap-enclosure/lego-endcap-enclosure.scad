/*
Parametric LEGO End Cap Enclosure Generator

Create 2 symmetric end pieces which can support a solid object with LEGO-compatible attachment points on top and bottom. By printing only the end pieces instead of a complele enclosure, the print is minimized

Published at
    https://www.thingiverse.com/thing:2544197
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

Work sponsored by
    http://futurice.com

Import this into other design files:
    use <anker-usb-lego-enclosure.scad>
*/

use <../lego.scad>

/* [LEGO Options plus Plastic and Printer Variance Adjustments] */

// Length of the enclosure (LEGO knob count)
//l = 23;
l = 6;

// Length of the left side of the enclosure (LEGO knob count, for example l/2 or less)
l_cap = 4;

// Length of the right side of the enclosure (LEGO knob count, for example l/2 or less)
r_cap = 2;

// Width of the enclosure (LEGO knob count)
//w = 10;
w = 3;

// Height of the enclosure (LEGO brick layer count)
//h = 4;
h = 3;

// Length of the object to be enclosed (mm)
//el = 173;
el = 8*4;

// Width of the object to be enclosed (mm)
//ew = 68;
ew = 8*1;

// Height of the object to be enclosed (mm)
//eh = 28;
eh = 8;

// Top connector size tweak => + = more tight fit, -0.04 for PLA, 0 for ABS, 0.07 for NGEN
top_tweak = 0;

// Bottom connector size tweak => + = more tight fit, 0.04 for PLA, 0 for ABS, -0.01 NGEN
bottom_tweak = 0;

// The size of the step which supports the enclosed part at the edges and corners in case ventilation openings would allow the enclosed part to slip out of place (mm)
shoulder = 3;

// Number of facets to form a circle (big numbers are more round which affects fit, but may take a long time to render)
//fn=64;
fn=16;

// Clearance space on the outer surface of bricks
skin = 0.1; 

// Size of the connectors
knob_radius=2.4;

// Height of the connectors including any bevel (1.8 is Lego standard, longer gives a stronger hold which helps since 3D prints are less precise)
knob_height=2.4;

// Height of the easy connect slope near connector top (0 to disable is standard a slightly faster to generate the model, a bigger value such as 0.3 may help if you adjust a tight fit but most printers' slicers will simplify away most usable bevels)
knob_bevel=0;

// Size of the small cavity inside the connectors
knob_cutout_radius=1.25;

// Distance below knob top surface and the internal cutout
knob_top_thickness=1.2;

// Height of the hole beneath each knob
knob_cutout_height=4.55;

// Size of the top hole in each knob to keep the cutout as part of the outside surface for slicer-friendliness. Use a larger number if you need to drain resin from the cutout. If h height of the block is 1, no airhole is added to the model since the cutout is open from below.
knob_cutout_airhole_radius=0.01;

// Number of side to simulate a circle in the air hole and (smaller numbers render faster and are usually sufficient)
airhole_fn=16;

// Depth which connectors may press into part bottom
socket_height=8.2;

// Bottom connector assistance ring size
ring_radius=3.25;

// Bottom connector assistance ring thickness
ring_thickness=0.8;

// Width of horizontal surface strengthening slats (usually between the bottom rings)
stiffener_width=0.8;

// Height of horizontal surface strengthening slats (usually between the bottom rings)
stiffener_height=2.4;

// Basic unit horizonal size of LEGO
block_width=8;

// Basic unit vertial size of LEGO
block_height=9.6;

// Thickness of the solid outside surface of LEGO
block_shell=1.3; // thickness

// LEGO panel thickness (flat back panel with screw holes in corners)
panel_thickness=3.2;

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0;




/////////////////////////////////////
// Test display
left_cap();


///////////////////////////////////

module left_cap(l_cap=l_cap, r_cap=r_cap, el=el, ew=ew, eh=eh, shoulder=shoulder, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, skin=skin, bolt_holes=bolt_holes, fn=fn, airhole_fn=airhole_fn) {
    
    difference() {
        lego_enclosure(l_cap=l_cap, r_cap=r_cap, el=el, ew=ew, eh=eh, shoulder=shoulder, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, skin=skin, bolt_holes=bolt_holes, fn=fn, airhole_fn=airhole_fn);
        
        translate([lego_width(l_cap), 0, 0])
            cube([lego_width(l-l_cap), lego_width(w), lego_height(h+1)]);
    }
}


module right_cap(l_cap=l_cap, r_cap=r_cap, el=el, ew=ew, eh=eh, shoulder=shoulder, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, skin=skin, bolt_holes=bolt_holes, fn=fn, airhole_fn=airhole_fn) {
    
    intersection() {
        lego_enclosure(l_cap=l_cap, r_cap=r_cap, el=el, ew=ew, eh=eh, shoulder=shoulder, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, skin=skin, bolt_holes=bolt_holes, fn=fn, airhole_fn=airhole_fn);
        
        translate([lego_width(r_cap), 0, 0])
            cube([lego_width(l-r_cap), lego_width(w), lego_height(h+1)]);
    }
}


// A Lego brick with a hole inside to contain something of the specified dimensions
module lego_enclosure(el=el, ew=ew, eh=eh, shoulder=shoulder, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, bolt_holes=bolt_holes, fn=fn, airhole_fn=airhole_fn) {
    
    // Add some margin around the enclosed space to give space to fit the part
    ml = l + lego_skin_width(2);
    mw = w + lego_skin_width(2);
    mh = h + lego_skin_width(2);
    
    // Inner box origin corner
    dl=(lego_width(el)-ml)/2;
    dw=(lego_width(ew)-mw)/2;
    dh=(lego_height(eh)-mh)/2;
    
    difference() {
        lego(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, skin=skin, bolt_holes=bolt_holes, fn=fn, airhole_fn=airhole_fn);
        
        translate([dl, dw, dh])
            enclosure_negative_space(ml=ml, mw=mw, mh=mh, shoulder=shoulder);
    }
}

// Where to remove material to privide access for attachments and air ventilation
module enclosure_negative_space(ml, mw, mh, shoulder=shoulder) {
    ls = ml - 2*shoulder;
    ws = mw - 2*shoulder;
    hs = mh - 2*shoulder;
    ls2 = ls+ml;
    ws2 = ws+mw;
    hs2 = hs+mh;
    
    // Primary enclosure hole
    cube([ml, mw, mh]);
    
    // Right end air hole
    translate([ml, shoulder, shoulder])
        cube([ls2, ws, hs]);
    
    // Left end air hole
    translate([-ls2, shoulder, shoulder])
        cube([ls2, ws, hs]);
    
    // Back side air hole
    translate([shoulder, w, shoulder])
        cube([ls, ws2, hs]);
        
    // Front side air hole
    translate([shoulder, -ws2, shoulder])
        cube([ls, ws2, hs]);
        
    // Top air hole
    translate([shoulder, shoulder, h])
        cube([ls, ws, hs2]);
        
    // Bottom air hole
    translate([shoulder, shoulder, -hs2])
        cube([ls, ws, hs2]);
}
