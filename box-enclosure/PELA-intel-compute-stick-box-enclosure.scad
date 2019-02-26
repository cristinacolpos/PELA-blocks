/*
Parametric PELA End Cap Enclosure For Intel Compute Stick

Create 2 symmetric end pieces which can support a solid object with PELA-compatible attachment points on top and bottom. The print can be minimized by printing only smaller end caps instead of a complele enclosure.


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Work sponsored by
    https://www.futurice.com/
*/

include <../material.scad>
include <../style.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../PELA-socket-panel.scad>
use <../PELA-knob-panel.scad>
use <PELA-box-enclosure.scad>


/* [Intel Compute Stick Enclosure] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Length of the enclosed object [mm]
length = 114.5; // [0.1:0.1:300]

// How close to the object ends should the walls be [ratio]
l_pad = 2; // [0:tight, 1:+1 block, 2:+2 blocks]

// Width of the enclosed object [mm]
width = 38.5;

// How close to the object sides should the walls be [ratio]
w_pad = 2; // [0:tight, 1:+1 block, 2:+2 blocks]

// Height of the enclosed object [mm]
height = 12.5;

// How close to the object top and bottom should the walls be [ratio]
height_tightness = 0.8;

// Bottom of enclosure
bottom_type = 2; // [0:open bottom, 1:solid bottom, 2:socket panel bottom, 3:knob panel bottom]

// Add holes in the top deck to improve airflow and reduce weight
top_vents = true;

// Add full width through holes spaced along the length for techic connectors
side_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around side holes (disable for extra ventilation, enable for lock notch fit)
side_sheaths = true;

// Add full width through holes spaced along the width for techic connectors
end_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around end holes  (disable for extra ventilation but loose lock notches)
end_sheaths = true;

// Add interior fill for upper layers
solid_upper_layers = true;

// Add interior fill for the base layer
solid_first_layer = true;

// Filler for the model center space
center_type = 4; //[0:empty, 1:solid, 2:solid with side holes, 3:solid with end holes, 4:solid with both side and end holes]

// Height of the enclosure [mm]
h = 2; // [1:1:20]



///////////////////////////////
// DISPLAY
///////////////////////////////

intel_compute_stick_box_enclosure(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, l_pad=l_pad, w_pad=w_pad, h=h, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, center_type=center_type, solid_upper_layers=solid_upper_layers, solid_first_layer=solid_first_layer);


/////////////////////////////////////
// MODULES
/////////////////////////////////////

module intel_compute_stick_box_enclosure(material=undef, large_nozzle=undef, cut_line=undef, length=length, width=width, l_pad=l_pad, w_pad=w_pad, h=undef, bottom_type=undef, top_vents=undef, side_holes=undef, side_sheaths=undef, end_holes=undef, end_sheaths=undef, center_type=undef, solid_upper_layers=undef, solid_first_layer=undef) {

    l = fit_mm_to_blocks(length, l_pad, block_width=block_width);
    w = fit_mm_to_blocks(width, w_pad, block_width=block_width);

    difference() {
        PELA_box_enclosure(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, center_type=center_type, solid_upper_layers=solid_upper_layers, solid_first_layer=solid_first_layer, block_height=block_height);

        union() {
            intel_compute_stick_body(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, block_height=block_height);

            intel_compute_stick_descender(material=material, large_nozzle=large_nozzle, l=l, w=w, block_height=block_height);

            end_access(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, length=length, block_height=block_height);

            side_access(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, block_height=block_height);
        }
    }
}


// The space into which a compute stick is lowered from the top
module intel_compute_stick_body(material=material, large_nozzle=large_nozzle, l, w, h, block_height=block_height) {
    x = (block_width(l) - length) / 2;
    y = (block_width(w, block_width) - width) / 2;
    z = block_height(h, block_height) - height;

    translate([x, y, z]) {
        cube([length, width, block_height(h, block_height)]);
    }
}


module end_access(material=material, large_nozzle=large_nozzle, l, w, h, length=length, block_height=block_height) {
    z = block_height(1, block_height=block_height);
    y = 1.82;
    left = (block_width(l) - length)/2;

    translate([-defeather, block_width(y), z]) {
        cube([block_width(l) + 2*defeather, block_width(w - 2*y), block_height(h, block_height)]);
    }

    translate([-defeather, block_width(y), -defeather]) {
        cube([left + 2*defeather, block_width(w - 2*y), block_height(h, block_height) + defeather]);
    }
}


module side_access(material=undef, large_nozzle=undef, l=undef, w=undef, h=undef, block_height=block_height) {
    z = block_height(1, block_height=block_height);

    translate([block_width(2), -defeather, z]) {
        cube([block_width(l - 4), block_width(w, block_width) + 2*defeather, block_height(h, block_height)]);
    }
    
    translate([block_width(2), -defeather, z/2]) {
        cube([block_width(4), block_width(w, block_width) + 2*defeather, block_height(h, block_height)]);
    }
    
    translate([block_width(12), -defeather, z/2]) {
        cube([block_width(2), block_width(w, block_width) + 2*defeather, block_height(h, block_height)]);
    }
}


// The open space below the stick for air ventilation
module intel_compute_stick_descender(material=undef, large_nozzle=undef, w=undef, l=undef, block_width=block_width, block_height=block_height) {

    descender_offset = 2;

    translate([block_width() + descender_offset, block_width() + descender_offset, knob_height]) {

        cube([block_width(l-2) - 2*descender_offset, block_width(w-2) - 2*descender_offset, panel_height(block_height=block_height)]);
    }
}


module intel_compute_stick_box_lid(material=material, large_nozzle=large_nozzle, cut_line=cut_line, solid_first_layer=solid_first_layer, block_width=block_width, block_height=block_height) {

    l = fit_mm_to_blocks(length, l_pad, block_width=block_width);
    w = fit_mm_to_blocks(width, w_pad, block_width=block_width);

    socket_panel(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, solid_first_layer=solid_first_layer, block_width=block_width, block_height=block_height);
}
