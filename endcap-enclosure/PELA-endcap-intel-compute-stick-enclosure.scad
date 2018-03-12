/*
Parametric PELA End Cap Enclosure For Intel Compute Stick

Create 2 symmetric end pieces which can support a solid object with PELA-compatible attachment points on top and bottom. The print can be minimized by printing only smaller end caps instead of a complele enclosure.


    https://www.thingiverse.com/thing:2544197
Based on
    https://www.thingiverse.com/thing:2303714



By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
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
use <PELA-endcap-enclosure.scad>
use <../support/support.scad>


/* [PELA Options plus Plastic and Printer Variance Adjustments] */

// Generate print-time support aid structures
print_supports = true;

// Type of print to generate- 1=>left cap, 2=>right cap, 3=>preview a single object that can not be opened, 4>both caps
mode=3;

// Length of the enclosure (PELA knob count)
l = 15;

// Length of the left side of the enclosure (PELA knob count, for example l/2 or less)
left_cap = 6;

// Size of the left cap vertical support structure near the cut point (PELA knob count, 0 to disable)
left_cap_support_width = 0.5;

// Size of the right cap vertical support structure near the cut point (PELA knob count, 0 to disable)
right_cap_support_width = 0.5;

// Length of the right side of the enclosure (PELA knob count, for example l/2 or less)
right_cap = l - left_cap;

// Width of the enclosure (PELA knob count)
w = 6;

// Height of the enclosure (PELA block layer count)
h = 2;

// Length of the object to be enclosed (mm)
enclosed_l = 114.5;

// Width of the object to be enclosed (mm)
enclosed_w = 38.5;

// Height of the object to be enclosed (mm)
enclosed_height = 12.5;

// Distance up from baselane for the hollowed space
vertical_offset=-4;

// The size of the step which supports the enclosed part at the edges and corners in case ventilation openings would allow the enclosed part to slip out of place (mm)
shoulder = 2.5;

// Slide all side openings up (-down) 
side_opening_vertical_offset = -2.5;

// Depth which connectors may press into part bottom
socket_height=8.2;

// Rounding for side air hole corners
corner_radius=3.25;

// Number of lines to approximate a circle in corner rounding
corner_fn=64;

// Solid interior is assumed for this model before carving away from that block
solid_upper_layers=1;

// Add full width through holes spaced along the length for PELA Techics connectors
side_holes = 0;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a sheath around side holes (disable for extra ventilation, enable for connector lock notches)
side_sheaths = 0; // [0:disabled, 1:enabled]

// Add short end holes spaced along the width for PELA Techics connectors
end_holes = 0;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full length connectors]

// Add a sheath around end holes  (disable for extra ventilation, enable for connector lock notches)
end_sheaths = 0; // [0:disabled, 1:enabled]

// Add holes in the top deck to improve airflow and reduce weight
top_vents = 1; // [0:disabled, 1:enabled]

// Size of a hole in the top of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
knob_vent_radius = 0;

// There is usually no need or room for corner mounting M3 bolt holes
bolt_holes=0;


/////////////////////////////////////
// PELA End Cap Enclosure Display

if (mode==1) {
    left_endcap(enclosed_l=enclosed_l, enclosed_w=enclosed_w, enclosed_height=enclosed_height, shoulder=shoulder, l=l, w=w, h=h, left_cap=left_cap, right_cap=right_cap, left_cap_support_width=left_cap_support_width, right_cap_support_width=right_cap_support_width, socket_height=socket_height, corner_radius=corner_radius, vertical_offset=vertical_offset, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, print_supports=print_supports);
} else if (mode==2) {
    right_endcap(enclosed_l=enclosed_l, enclosed_w=enclosed_w, enclosed_height=enclosed_height, shoulder=shoulder, l=l, w=w, h=h, left_cap=left_cap, right_cap=right_cap, left_cap_support_width=left_cap_support_width, right_cap_support_width=right_cap_support_width, socket_height=socket_height, corner_radius=corner_radius, vertical_offset=vertical_offset, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, print_supports=print_supports);
} else if (mode==3) {
    translate([0, block_width(w + 0.5), 0])
        left_endcap(enclosed_l=enclosed_l, enclosed_w=enclosed_w, enclosed_height=enclosed_height, shoulder=shoulder, l=l, w=w, h=h, left_cap=left_cap, right_cap=right_cap, left_cap_support_width=left_cap_support_width, right_cap_support_width=right_cap_support_width, socket_height=socket_height, corner_radius=corner_radius, vertical_offset=vertical_offset, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, print_supports=print_supports);

    right_endcap(enclosed_l=enclosed_l, enclosed_w=enclosed_w, enclosed_height=enclosed_height, shoulder=shoulder, l=l, w=w, h=h, left_cap=left_cap, right_cap=right_cap, left_cap_support_width=left_cap_support_width, right_cap_support_width=right_cap_support_width, corner_radius=corner_radius, vertical_offset=vertical_offset, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, print_supports=print_supports);
} else if (mode==4) {
    PELA_enclosure(enclosed_l=enclosed_l, enclosed_w=enclosed_w, enclosed_height=enclosed_height, shoulder=shoulder, l=l, w=w, h=h, left_cap=left_cap, right_cap=right_cap, left_cap_support_width=left_cap_support_width, right_cap_support_width=right_cap_support_width, side_opening_vertical_offset=side_opening_vertical_offset, socket_height=socket_height, corner_radius=corner_radius, vertical_offset=vertical_offset, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths);
} else {
    echo("<b>Unsupported: please check <i>mode</i> variable is 1-4</b>");
}
