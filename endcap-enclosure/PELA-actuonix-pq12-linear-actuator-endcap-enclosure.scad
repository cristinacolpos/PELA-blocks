/*
Parametric PELA End Cap Enclosure For Actuonix PQ12 Linear Servo

The left and right caps slip around the actuator.


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Work sponsored by
    http://futurice.com
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <PELA-endcap-enclosure.scad>
use <../support/support.scad>


/* [PELA Options plus Plastic and Printer Variance Adjustments] */

// Type of print to generate- 1=>left cap, 2=>right cap, 3=>preview a single object that can not be opened, 4>both caps
mode = 3;

// Length of the enclosure (PELA knob count)
l = 5;

// Length of the left side of the enclosure (PELA knob count, for example l/2 or less)
left_cap = 2;

// Size of the left cap vertical support structure near the cut point (PELA knob count, 0 to disable)
left_cap_support_width = 0.5;

// Size of the right cap vertical support structure near the cut point (PELA knob count, 0 to disable)
right_cap_support_width = 0.5;

// Length of the right side of the enclosure (PELA knob count, for example l/2 or less)
right_cap = l - left_cap;

// Width of the enclosure (PELA knob count)
w = 3;

// Height of the enclosure (PELA block layer count)
h = 2 + 1/3;

// Length of the object to be enclosed (mm)
enclosed_l = 36.9;

// Width of the object to be enclosed (mm)
enclosed_w = 21.6;

// Height of the object to be enclosed (mm)
enclosed_height = 15.15;

// Distance up from baselane for the hollowed space
vertical_offset = 0;

// The size of the step which supports the enclosed part at the edges and corners in case ventilation openings would allow the enclosed part to slip out of place (mm)
shoulder = 100;

// Slide all side openings up (-down) 
side_opening_vertical_offset = 0;

// Rounding for side air hole corners
corner_radius = 3.25;

// Number of lines to approximate a circle in corner rounding
corner_fn = 32;

// Solid interior is assumed for this model before carving away from that block
solid_upper_layers = true;

// Add full width through holes spaced along the length for PELA Techics connectors
side_holes = 1;

// Add a sheath around side holes (disable for extra ventilation, enable for connector lock notches)
side_sheaths = false;

// Add short end holes spaced along the width for PELA Techics connectors
end_holes = 1;

// Add a sheath around end holes  (disable for extra ventilation, enable for connector lock notches)
end_sheaths = false;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = true;

// Size of a hole in the top of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
knob_vent_radius = 0;

// There is usually no need or room for corner mounting M3 bolt holes
bolt_holes = false;

// Cut an opening in the front for access and ventilation
front_side_airhole = false;

// Cut an opening in the back for access and ventilation
back_side_airhole = false;

// Cut an opening in the left for access and ventilation
left_end_airhole = true;

// Cut an opening in the right for access and ventilation
right_end_airhole = false;


/////////////////////////////////////
// PELA End Cap Enclosure Display

if (mode==1) {
    left_endcap_with_supports(enclosed_l=enclosed_l, enclosed_w=enclosed_w, enclosed_height=enclosed_height, shoulder=shoulder, l=l, w=w, h=h, left_cap=left_cap, right_cap=right_cap, left_cap_support_width=left_cap_support_width, right_cap_support_width=right_cap_support_width, corner_radius=corner_radius, vertical_offset=vertical_offset, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, print_supports=print_supports, solid_upper_layers=solid_upper_layers, support_offset_from_part=support_offset_from_part);
} else if (mode==2) {
    right_endcap_with_supports(enclosed_l=enclosed_l, enclosed_w=enclosed_w, enclosed_height=enclosed_height, shoulder=shoulder, l=l, w=w, h=h, left_cap=left_cap, right_cap=right_cap, left_cap_support_width=left_cap_support_width, right_cap_support_width=right_cap_support_width, corner_radius=corner_radius, vertical_offset=vertical_offset, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, print_supports=print_supports, solid_upper_layers=solid_upper_layers, support_offset_from_part=support_offset_from_part);
} else if (mode==3) {
    translate([0, block_width(w + 0.5), 0])
        left_endcap_with_supports(enclosed_l=enclosed_l, enclosed_w=enclosed_w, enclosed_height=enclosed_height, shoulder=shoulder, l=l, w=w, h=h, left_cap=left_cap, right_cap=right_cap, left_cap_support_width=left_cap_support_width, right_cap_support_width=right_cap_support_width, corner_radius=corner_radius, vertical_offset=vertical_offset, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, print_supports=print_supports, solid_upper_layers=solid_upper_layers, support_offset_from_part=support_offset_from_part);

    right_endcap_with_supports(enclosed_l=enclosed_l, enclosed_w=enclosed_w, enclosed_height=enclosed_height, shoulder=shoulder, l=l, w=w, h=h, left_cap=left_cap, right_cap=right_cap, left_cap_support_width=left_cap_support_width, right_cap_support_width=right_cap_support_width, corner_radius=corner_radius, vertical_offset=vertical_offset, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, print_supports=print_supports, solid_upper_layers=solid_upper_layers, support_offset_from_part=support_offset_from_part);
} else if (mode==4) {
    endcap_enclosure(enclosed_l=enclosed_l, enclosed_w=enclosed_w, enclosed_height=enclosed_height, shoulder=shoulder, l=l, w=w, h=h, left_cap=left_cap, right_cap=right_cap, left_cap_support_width=left_cap_support_width, right_cap_support_width=right_cap_support_width, side_opening_vertical_offset=side_opening_vertical_offset, corner_radius=corner_radius, vertical_offset=vertical_offset, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, solid_upper_layers=solid_upper_layers);
} else {
    echo("<b>Unsupported: please check <i>mode</i> variable is 1-4</b>");
}