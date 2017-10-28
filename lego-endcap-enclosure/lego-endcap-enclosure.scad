/*
Parametric LEGO End Cap Enclosure Generator

Create 2 symmetric end pieces which can support a solid object with LEGO-compatible attachment points on top and bottom. The print can be minimized by printing only smaller end caps instead of a complele enclosure.

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

include <../lego_parameters.scad>
use <../lego.scad>


/* [LEGO Options plus Plastic and Printer Variance Adjustments] */

// Type of print to generate- 1=>left cap, 2=>right cap, 3=>both caps, 4=>preview a single object that can not be opened
mode=1;

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
el = 8*5.5;

// Width of the object to be enclosed (mm)
//ew = 68;
ew = 8*2.5;

// Height of the object to be enclosed (mm)
//eh = 28;
eh = 15;

// The size of the step which supports the enclosed part at the edges and corners in case ventilation openings would allow the enclosed part to slip out of place (mm)
shoulder = 2;

// Slide all side openings up (-down) 
side_opening_vertical_offset = -2;

// Depth which connectors may press into part bottom
socket_height=8.2;

// Rounding for side air hole corners
corner_radius=3.25;

// Number of lines to approximate a circle in corner rounding
corner_fn=64;

/////////////////////////////////////
// LEGO End Cap Enclosure Display

if (mode==1) {
    left_cap();
} else if (mode==2) {
    right_cap();
} else if (mode==3) {
    lego_enclosure();
} else {
    echo("<b>Unsupported: please check <i>mode</i> variable is 1-3</b>");
}


///////////////////////////////////
// LEGO Enclosure Modules
///////////////////////////////////

module left_cap(l_cap=l_cap, r_cap=r_cap, el=el, ew=ew, eh=eh, shoulder=shoulder, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, socket_height=socket_height, corner_radius=corner_radius) {
    
    difference() {
        lego_enclosure(l_cap=l_cap, r_cap=r_cap, el=el, ew=ew, eh=eh, shoulder=shoulder, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, side_opening_vertical_offset=side_opening_vertical_offset, socket_height=socket_height, corner_radius=corner_radius);
        
        translate([lego_width(l_cap), 0, 0])
            cube([lego_width(l-l_cap), lego_width(w), lego_height(h+1)]);
    }
}


module right_cap(l_cap=l_cap, r_cap=r_cap, el=el, ew=ew, eh=eh, shoulder=shoulder, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, corner_radius=corner_radius) {
    
    intersection() {
        lego_enclosure(l_cap=l_cap, r_cap=r_cap, el=el, ew=ew, eh=eh, shoulder=shoulder, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, side_opening_vertical_offset=side_opening_vertical_offset, socket_height=socket_height, corner_radius=corner_radius);
        
        translate([lego_width(r_cap), 0, 0])
            cube([lego_width(l-r_cap), lego_width(w), lego_height(h+1)]);
    }
}


// A Lego brick with a hole inside to contain something of the specified dimensions
module lego_enclosure(el=el, ew=ew, eh=eh, shoulder=shoulder, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, side_opening_vertical_offset=side_opening_vertical_offset, socket_height=socket_height, corner_radius=corner_radius) {
    
    difference() {
        vented_lego(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, socket_height=socket_height);
        
        enclosure_negative_space(l=l, w=w, h=h, el=el, ew=ew, eh=eh, shoulder=shoulder, side_opening_vertical_offset=side_opening_vertical_offset, socket_height=socket_height, corner_radius=corner_radius);
    }
}

// Where to remove material to privide access for attachments and air ventilation
module enclosure_negative_space(l=l, w=w, h=h, el=el, ew=ew, eh=eh, shoulder=shoulder, side_opening_vertical_offset=side_opening_vertical_offset, socket_height=socket_height, corner_radius=corner_radius) {

    // Add some margin around the enclosed space to give space to fit the part
    ml = el + lego_skin_width(2);
    mw = ew + lego_skin_width(2);
    mh = eh + lego_skin_width(2);    
    
    ls = ml - 2*shoulder;
    ws = mw - 2*shoulder;
    hs = mh - 2*shoulder;
    
    dl = (lego_width(l)-ml)/2;
    dw = (lego_width(w)-mw)/2;
    dh = socket_height+(lego_height(h)-mh-socket_height)/2;
    
    // Primary enclosure hole
    translate([dl, dw, dh]) 
        cube([ml, mw, mh]);
    
    // Left end air hole
    translate([-corner_radius, dw+shoulder, dh+shoulder+side_opening_vertical_offset])
        rounded_cube(x=ls, y=ws, z=hs, corner_radius=corner_radius, fn=fn);
    
    // Right end air hole
    translate([corner_radius+lego_width(l)-ls, dw+shoulder, dh+shoulder+side_opening_vertical_offset])
        rounded_cube(x=ls, y=ws, z=hs, corner_radius=corner_radius, fn=fn);
    
    // Back side air hole
    translate([dl+shoulder, -corner_radius+dw+mw, dh+shoulder+side_opening_vertical_offset])
        rounded_cube(x=ls, y=ws, z=hs, corner_radius=corner_radius, fn=fn);
        
    // Front side air hole
    translate([dl+shoulder, -corner_radius, dh+shoulder+side_opening_vertical_offset])
        rounded_cube(x=ls, y=ws, z=hs, corner_radius=corner_radius, fn=fn);
}

module rounded_cube(x=5, y=5, z=5, corner_radius=corner_radius, corner_fn=corner_fn) {
    translate([corner_radius, corner_radius, corner_radius])
        minkowski() {
            cube([x-2*corner_radius, y-2*corner_radius, z-2*corner_radius]);
            sphere(r=corner_radius, $fn=fn);
        }
}
