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

include <../print-parameters.scad>
include <../style.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../PELA-socket-panel.scad>
use <../knob-panel/PELA-knob-panel.scad>
use <PELA-box-enclosure.scad>


/* [Intel Compute Stick Enclosure] */

// Printing material
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Length of the enclosed object [mm]
length = 114.5;

// How close to the object ends should the walls be [ratio]
length_padding = 2; // [0:tight, 1:+1 block, 2:+2 blocks]

// Width of the enclosed object [mm]
width = 38.5;

// How close to the object sides should the walls be [ratio]
width_padding = 2; // [0:tight, 1:+1 block, 2:+2 blocks]

// Height of the enclosed object [mm]
height = 12.5;

// How close to the object top and bottom should the walls be [ratio]
height_tightness = 0.8;

bottom_type = 2; // [0:open bottom, 1:solid bottom, 2:socket-panel bottom, 3:knob-panel bottom]

// Add holes in the top deck to improve airflow and reduce weight
top_vents = true;

side_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

side_sheaths = true;

end_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

end_sheaths = true;

solid_upper_layers = true;

// Should the middle of the box be a solid block or empty. Other designs will typically then cut from this solid block to support something inside the enclosure.
center_type = 4; //[0:empty, 1:solid, 2:solid with side holes, 3:solid with end holes, 4:solid with both side and end holes]



///////////////////////////////
// DISPLAY
///////////////////////////////

intel_compute_stick_box_enclosure();


/////////////////////////////////////
// MODULES
/////////////////////////////////////

module intel_compute_stick_box_enclosure(material=material) {
    l = fit_mm_to_blocks(length, length_padding);
    w = fit_mm_to_blocks(width, width_padding);
    h = 2;

    difference() {
        PELA_box_enclosure(material=material, l=l, w=w, h=h, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, center_type=center_type, solid_upper_layers=solid_upper_layers);

        union() {
            intel_compute_stick_body(material=material, l=l, w=w, h=h, block_height=block_height);
            intel_compute_stick_descender(material=material, block_height=block_height);
            end_access(material=material, l=l, w=w, h=h, length=length, block_height=block_height);
            side_access(material=material, l=l, w=w, h=h, block_height=block_height);
        }
    }
}


// The space into which a compute stick is lowered from the top
module intel_compute_stick_body(material=material, l, w, h=h, block_height=block_height) {
    x = (block_width(l) - length) / 2;
    y = (block_width(w) - width) / 2;
    z = block_height(h, block_height=block_height) - height;

    translate([x, y, z]) {
        cube([length, width, block_height(h, block_height=block_height)]);
    }
}


module end_access(material=material, l, w, h, length=length, block_height=block_height) {
    z = block_height(1, block_height=block_height);
    y = 1.82;
    left = (block_width(l) - length)/2;

    translate([0, block_width(y), z]) {
        cube([block_width(l), block_width(w - 2*y), block_height(h, block_height=block_height)]);
    }

    translate([0, block_width(y), 0]) {
        cube([left, block_width(w - 2*y), block_height(h, block_height=block_height)]);
    }
}


module side_access(material=material, l, w, h, block_height=block_height) {
    z = block_height(1, block_height=block_height);

    translate([block_width(2), 0, z]) {
        cube([block_width(l - 4), block_width(w), block_height(h, block_height=block_height)]);
    }
    
    translate([block_width(2), 0, z/2]) {
        cube([block_width(4), block_width(w), block_height(h, block_height=block_height)]);
    }
    
    translate([block_width(12), 0, z/2]) {
        cube([block_width(2), block_width(w), block_height(h, block_height=block_height)]);
    }
}


// The open space below the stick for air ventilation
module intel_compute_stick_descender(material=material, block_height=block_height) {
    descender_offset = 2;

    translate([block_width() + descender_offset, block_width() + descender_offset, panel_height(block_height=block_height)]) {
        cube([length - 2*descender_offset, width - 2*descender_offset, block_height(h, block_height=block_height)]);
    }
}


module intel_compute_stick_box_lid(material=material, block_height=block_height) {
    l=fit_mm_to_blocks(length, length_padding);
    w=fit_mm_to_blocks(width, width_padding);

    socket_panel(l=l, w=w, corner_bolt_holes=corner_bolt_holes, block_height=block_height);
}
