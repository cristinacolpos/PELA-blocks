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

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../socket-panel/PELA-socket-panel.scad>
use <../knob-panel/PELA-knob-panel.scad>
use <PELA-box-enclosure.scad>


/* [PELA Box Option] */

// Length of the enclosure including two for walls (PELA knob count)
length = 114.5;

length_tightness = 2;

// Width of the enclosure including two for walls (PELA knob count)
width = 38.5;

width_tightness = 2;

height = 12.5;

height_tightness = 0.8;

bottom_type = 2;

drop_bottom = false;

top_vents = true;

side_holes = 2;

side_sheaths = true;

end_holes = 3;

end_sheaths = true;

solid_upper_layers = true;

// Should the middle of the box be a solid block or empty. Other designs will typically then cut from this solid block to support something inside the enclosure.
center_type = 4; //[0:empty, 1:solid, 2:solid with side holes, 3:solid with end holes, 4:solid with both side and end holes]

// Display 
intel_compute_stick_box_enclosure();


module intel_compute_stick_box_enclosure() {
    l=fit_mm_to_pela_blocks(length, length_tightness);
    w=fit_mm_to_pela_blocks(width, width_tightness);
    h=2;

    difference() {
        PELA_box_enclosure(l=l, w=w, h=h, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, center_type=center_type, solid_upper_layers=solid_upper_layers);

        union() {
            intel_compute_stick_body(l=l, w=w, h=h);
            intel_compute_stick_descender();
#            end_access(l=l, w=w, h=h, length=length);
#            side_access(l=l, w=w, h=h);
        }
    }
}


// The space into which a compute stick is lowered from the top
module intel_compute_stick_body() {
    x = (block_width(l) - length) / 2;
    y = (block_width(w) - width) / 2;
    z = block_height(h) - height;

    translate([x, y, z]) {
        cube([length, width, block_height(h)]);
    }
}


module end_access(l, w, h, length=length) {
    z = block_height(1);
    y = 1.82;
    left = (block_width(l) - length)/2;

    translate([0, block_width(y), z]) {
        cube([left, block_width(w - 2*y), block_height(h)]);
    }

    translate([0, block_width(y), 0]) {
        cube([block_width(1), block_width(w - 2*y), block_height(h)]);
    }
}


module side_access(l, w, h) {
    z = block_height(1);

    translate([block_width(2), 0, z]) {
        cube([block_width(l - 4), block_width(w), block_height(h)]);
    }
    
    translate([block_width(2), 0, z/2]) {
        cube([block_width(4), block_width(w), block_height(h)]);
    }
    
    translate([block_width(12), 0, z/2]) {
        cube([block_width(2), block_width(w), block_height(h)]);
    }
}


// The open space below the stick for air ventilation
module intel_compute_stick_descender() {
    descender_offset = 2;

    dh = block_height(h);

    translate([block_width() + descender_offset, block_width() + descender_offset, panel_height()]) {
        cube([length - 2*descender_offset, width - 2*descender_offset, block_height(h)]);
    }
}


module intel_compute_stick_box_lid() {
    l=fit_mm_to_pela_blocks(length, length_tightness);
    w=fit_mm_to_pela_blocks(width, width_tightness);

    PELA_knob_panel(l=l, w=w, bolt_holes=bolt_holes, knobs=false, top_vents=false);
}
