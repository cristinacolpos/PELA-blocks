/*
Parametric PELA End Cap Enclosure Generator

Create 2 symmetric end pieces which can support a solid object with PELA-compatible attachment points on top and bottom. The print can be minimized by printing only smaller end caps instead of a complele enclosure.


    https://www.thingiverse.com/thing:2544197
Based on
    https://www.thingiverse.com/thing:2303714



By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Work sponsored by
    http://futurice.com

Import this into other design files:
    use <anker-usb-PELA-enclosure.scad>
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>


/* [PELA Options plus Plastic and Printer Variance Adjustments] */

// Type of print to generate- 1=>left cap, 2=>right cap, 3=>both caps, 4=>preview a single object that can not be opened
mode=3;

// Length of the enclosure (PELA knob count)
//l = 23;
l = 7;

// Length of the left side of the enclosure (PELA knob count, for example l/2 or less)
l_cap = 5;

// Length of the right side of the enclosure (PELA knob count, for example l/2 or less)
r_cap = l - l_cap;

// Width of the enclosure (PELA knob count)
//w = 10;
w = 3;

// Height of the enclosure (PELA block layer count)
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

// Distance up from baselane for the hollowed space
vertical_offset = 0;

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

// Solid interior is assumed for this model before carving away from that block
solid_upper_layers=1;

// Add full width through holes spaced along the length for PELA Techics connectors
side_holes = 3;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a sheath around side holes (disable for extra ventilation, enable for connector lock notches)
side_sheaths = 1; // [0:disabled, 1:enabled]

// Add short end holes spaced along the width for PELA Techics connectors
end_holes = 3;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full length connectors]

// Add a sheath around end holes  (disable for extra ventilation, enable for connector lock notches)
end_sheaths = 1; // [0:disabled, 1:enabled]

// Add holes in the top deck to improve airflow and reduce weight
top_vents = 1; // [0:disabled, 1:enabled]

// Size of a hole in the top of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
knob_vent_radius = 0;

// There is usually no need or room for corner mounting M3 bolt holes
bolt_holes=0;

/////////////////////////////////////
// PELA End Cap Enclosure Display

if (mode==1) {
    left_cap();
} else if (mode==2) {
    right_cap();
} else if (mode==3) {
    translate([0, block_width(w+0.5)])
        left_cap();
    right_cap();
} else if (mode==4) {
    PELA_enclosure();
} else {
    echo("<b>Unsupported: please check <i>mode</i> variable is 1-3</b>");
}


///////////////////////////////////
// PELA Enclosure Modules
///////////////////////////////////

module left_cap(l_cap=l_cap, el=el, ew=ew, eh=eh, shoulder=shoulder, l=l, w=w, h=h, socket_height=socket_height, corner_radius=corner_radius, vertical_offset=vertical_offset, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths) {
    
    intersection() {
        PELA_enclosure(el=el, ew=ew, eh=eh, shoulder=shoulder, l=l, w=w, h=h, side_opening_vertical_offset=side_opening_vertical_offset, socket_height=socket_height, corner_radius=corner_radius, vertical_offset=vertical_offset, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths);
        
        cube([block_width(l_cap), block_width(w), block_height(h+1)]);
    }
}


module right_cap(r_cap=r_cap, el=el, ew=ew, eh=eh, shoulder=shoulder, l=l, w=w, h=h, corner_radius=corner_radius, vertical_offset=vertical_offset, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes) {
    
    intersection() {
        PELA_enclosure(el=el, ew=ew, eh=eh, shoulder=shoulder, l=l, w=w, h=h, side_opening_vertical_offset=side_opening_vertical_offset, socket_height=socket_height, corner_radius=corner_radius, vertical_offset=vertical_offset, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths);
        
        translate([block_width(l-r_cap), 0, 0])
            cube([block_width(r_cap), block_width(w), block_height(h+1)]);
    }
}


// A PELA block with a hole inside to contain something of the specified dimensions
module PELA_enclosure(el=el, ew=ew, eh=eh, shoulder=shoulder, l=l, w=w, h=h, side_opening_vertical_offset=side_opening_vertical_offset, socket_height=socket_height, corner_radius=corner_radius, vertical_offset=vertical_offset, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths) {
    
    difference() {        
        PELA_technic_block(l=l, w=w, h=h, socket_height=socket_height, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths);
        
        translate([0, 0, vertical_offset])
            enclosure_negative_space(l=l, w=w, h=h, el=el, ew=ew, eh=eh, shoulder=shoulder, side_opening_vertical_offset=side_opening_vertical_offset, socket_height=socket_height, corner_radius=corner_radius);
    }
}

// Where to remove material to privide access for attachments and air ventilation
module enclosure_negative_space(l=l, w=w, h=h, el=el, ew=ew, eh=eh, shoulder=shoulder, side_opening_vertical_offset=side_opening_vertical_offset, socket_height=socket_height, corner_radius=corner_radius) {

    // Add some margin around the enclosed space to give space to fit the part
    ml = el + 2*skin;
    mw = ew + 2*skin;
    mh = eh + 2*skin;    
    
    ls = ml - 2*shoulder;
    ws = mw - 2*shoulder;
    hs = mh - 2*shoulder;
    
    dl = (block_width(l)-ml)/2;
    dw = (block_width(w)-mw)/2;
    dh = socket_height+(block_height(h)-mh-socket_height)/2;
    
    // Primary enclosure hole
    translate([dl, dw, dh]) 
        cube([ml, mw, mh]);
    
    // Left end air hole
    translate([-corner_radius, dw+shoulder, dh+shoulder+side_opening_vertical_offset])
        rounded_cube(x=ls, y=ws, z=hs, corner_radius=corner_radius);
    
    // Right end air hole
    translate([corner_radius+block_width(l)-ls, dw+shoulder, dh+shoulder+side_opening_vertical_offset])
        rounded_cube(x=ls, y=ws, z=hs, corner_radius=corner_radius);
    
    // Back side air hole
    translate([dl+shoulder, -corner_radius+dw+mw, dh+shoulder+side_opening_vertical_offset])
        rounded_cube(x=ls, y=ws, z=hs, corner_radius=corner_radius);
        
    // Front side air hole
    translate([dl+shoulder, -corner_radius, dh+shoulder+side_opening_vertical_offset])
        rounded_cube(x=ls, y=ws, z=hs, corner_radius=corner_radius);
}

module rounded_cube(x=5, y=5, z=5, corner_radius=corner_radius, corner_fn=corner_fn) {
    translate([corner_radius, corner_radius, corner_radius])
        minkowski() {
            cube([x-2*corner_radius, y-2*corner_radius, z-2*corner_radius]);
            sphere(r=corner_radius, $fn=corner_fn);
        }
}
