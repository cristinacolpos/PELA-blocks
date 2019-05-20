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


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]
// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;


/* [Intel Compute Stick Enclosure] */

// Length of the enclosed object [mm]
_l = 114.5; // [0.1:0.1:300]

// Width of the enclosed object [mm]
_w = 38.5;

// How close to the object ends should the walls be [ratio]
_l_pad = 2; // [0:tight, 1:+1 block, 2:+2 blocks]

// How close to the object sides should the walls be [ratio]
_w_pad = 2; // [0:tight, 1:+1 block, 2:+2 blocks]

// Height of the enclosed object [mm]
_h = 12.5;

// Bottom of enclosure
_bottom_type = 2; // [0:open bottom, 1:solid bottom, 2:socket panel bottom, 3:knob panel bottom]

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = true;

// Add full width through holes spaced along the length for techic connectors
_side_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around side holes (disable for extra ventilation, enable for lock notch fit)
_side_sheaths = true;

// Add full width through holes spaced along the width for techic connectors
_end_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around end holes  (disable for extra ventilation but loose lock notches)
_end_sheaths = true;

// Add interior fill for upper layers
_solid_upper_layers = true;

// Add interior fill for the base layer
_solid_first_layer = true;

// Filler for the model center space
_center_type = 4; //[0:empty, 1:solid, 2:solid with side holes, 3:solid with end holes, 4:solid with both side and end holes]

// Height of the enclosure [mm]
_h = 2; // [1:1:20]

// Use sockets for the lid base
_sockets = true;

_knob_height=2;

_bottom_vents = false;

_bottom_knobs = true;

_skip_edge_knobs = 0;

_left_wall_enabled = true;

_right_wall_enabled = true;

_front_wall_enabled = true;

_back_wall_enabled = true;

_left_wall_knobs = true;

_right_wall_knobs = true;

_front_wall_knobs = true;

_back_wall_knobs = true;




/* [Left Cut] */

// Distance of the front of left side hole [mm]
_left_cutout_y = 4; // [0:0.1:200]

// Width of the left side hole [mm]
_left_cutout_width = 0; // [0:0.1:200]

// Depth of the left side hole [mm]
_left_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the left side hole [mm]
_left_cutout_z = 4; // [0:0.1:200]

// Height of the left side hole [mm]
_left_cutout_height = 8; // [0:0.1:200]



/* [Right Cut] */

// Distance of the front of right side hole [mm]
_right_cutout_y = 4; // [0:0.1:200]

// Width of the right side hole [mm]
_right_cutout_width = 0; // [0:0.1:200]

// Depth of the right side hole [mm]
_right_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the right side hole [mm]
_right_cutout_z = 4; // [0:0.1:200]

// Height of the right side hole [mm]
_right_cutout_height = 8; // [0:0.1:200]



/* [Front Cut] */

// Distance of the left of front side hole [mm]
_front_cutout_x = 4; // [0:0.1:200]

// Width of the front side hole [mm]
_front_cutout_width = 0; // [0:0.1:200]

// Depth into the part of the front cut [mm]
_front_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the front side hole [mm]
_front_cutout_z = 4; // [0:0.1:200]

// Height of the front side hole [mm]
_front_cutout_height = 8; // [0:0.1:200]



/* [Back Cut] */

// Distance of the left of back side hole [mm]
_back_cutout_x = 4; // [0:0.1:200]

// Width of the back side hole [mm]
_back_cutout_width = 0; // [0:0.1:200]

// Depth of the back side hole [mm]
_back_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the back side hole [mm]
_back_cutout_z = 4; // [0:0.1:200]

// Height of the back side hole [mm]
_back_cutout_height = 8; // [0:0.1:200]


///////////////////////////////
// DISPLAY
///////////////////////////////

intel_compute_stick_box_enclosure(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, h=_h, bottom_type=_bottom_type, sockets=_sockets, bottom_vents=_bottom_vents, top_vents=_top_vents, side_holes=_side_holes, side_sheaths=_side_sheaths, end_holes=_end_holes, end_sheaths=_end_sheaths, skin=_skin, knob_height=_knob_height, bottom_knobs=_bottom_knobs, skip_edge_knobs=_skip_edge_knobs, left_wall_enabled=_left_wall_enabled, right_wall_enabled=_right_wall_enabled, front_wall_enabled=_front_wall_enabled, back_wall_enabled=_back_wall_enabled, left_wall_knobs=_left_wall_knobs, right_wall_knobs=_right_wall_knobs, front_wall_knobs=_front_wall_knobs, back_wall_knobs=_back_wall_knobs, solid_first_layer=_solid_first_layer, solid_upper_layers=_solid_upper_layers, ridge_z_offset=_ridge_z_offset, center_type=_center_type, block_height=_block_height, knob_vent_radius=_knob_vent_radius, left_cutout_y=_left_cutout_y, left_cutout_width=_left_cutout_width, left_cutout_depth=_left_cutout_depth, left_cutout_z=_left_cutout_z, left_cutout_height=_left_cutout_height, right_cutout_y=_right_cutout_y, right_cutout_width=_right_cutout_width, right_cutout_depth=_right_cutout_depth, right_cutout_z=_right_cutout_z, right_cutout_height=_right_cutout_height, front_cutout_x=_front_cutout_x, front_cutout_width=_front_cutout_width, front_cutout_depth=_front_cutout_depth, front_cutout_z=_front_cutout_z, front_cutout_height=_front_cutout_height, back_cutout_x=_back_cutout_x, back_cutout_width=_back_cutout_width, back_cutout_depth=_back_cutout_depth, back_cutout_z=_back_cutout_z, back_cutout_height=_back_cutout_height, corner_bolt_holes=_corner_bolt_holes, bolt_hole_radius=_bolt_hole_radius);


/////////////////////////////////////
// MODULES
/////////////////////////////////////

module intel_compute_stick_box_enclosure(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, h=undef, bottom_type=undef, sockets=undef, top_vents=undef, bottom_vents=undef, side_holes=undef, side_sheaths=undef, end_holes=undef, end_sheaths=undef, skin=undef, knob_height=undef, bottom_knobs=undef, skip_edge_knobs=undef, left_wall_enabled=undef, right_wall_enabled=undef, front_wall_enabled=undef, back_wall_enabled=undef, left_wall_knobs=undef, right_wall_knobs=undef, front_wall_knobs=undef, back_wall_knobs=undef, solid_first_layer=undef, solid_upper_layers=undef, ridge_z_offset=undef, center_type=undef, block_height=undef, knob_vent_radius=undef, left_cutout_y=undef, left_cutout_width=undef, left_cutout_depth=undef, left_cutout_z=undef, left_cutout_height=undef, right_cutout_y=undef, right_cutout_width=undef, right_cutout_depth=undef, right_cutout_z=undef, right_cutout_height=undef, front_cutout_x=undef, front_cutout_width=undef, front_cutout_depth=undef, front_cutout_z=undef, front_cutout_height=undef, back_cutout_x=undef, back_cutout_width=undef, back_cutout_depth=undef, back_cutout_z=undef, back_cutout_height=undef, corner_bolt_holes=undef, bolt_hole_radius=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(length!=undef);
    assert(width!=undef);
    assert(height!=undef);
    assert(l_pad!=undef);
    assert(w_pad!=undef);
    assert(bottom_type!=undef);
    assert(sockets!=undef);
    assert(knob_height!=undef);
    assert(top_vents!=undef);
    assert(bottom_vents!=undef);
    assert(side_holes!=undef);
    assert(side_sheaths!=undef);
    assert(end_holes!=undef);
    assert(end_sheaths!=undef);
    assert(skin!=undef);
    assert(bottom_knobs!=undef);
    assert(skip_edge_knobs!=undef);
    assert(left_wall_enabled!=undef);
    assert(right_wall_enabled!=undef);
    assert(front_wall_enabled!=undef);
    assert(back_wall_enabled!=undef);
    assert(left_wall_knobs!=undef);
    assert(right_wall_knobs!=undef);
    assert(front_wall_knobs!=undef);
    assert(back_wall_knobs!=undef);
    assert(solid_first_layer!=undef);
    assert(solid_upper_layers!=undef);
    assert(ridge_z_offset!=undef);
    assert(center_type!=undef);
    assert(block_height!=undef);
    assert(knob_vent_radius!=undef);
    assert(left_cutout_y!=undef);
    assert(left_cutout_width!=undef);
    assert(left_cutout_depth!=undef);
    assert(left_cutout_z!=undef);
    assert(left_cutout_height!=undef);
    assert(right_cutout_y!=undef);
    assert(right_cutout_width!=undef);
    assert(right_cutout_depth!=undef);
    assert(right_cutout_z!=undef);
    assert(right_cutout_height!=undef);
    assert(front_cutout_x!=undef);
    assert(front_cutout_width!=undef);
    assert(front_cutout_depth!=undef);
    assert(front_cutout_z!=undef);
    assert(front_cutout_height!=undef);
    assert(back_cutout_x!=undef);
    assert(back_cutout_width!=undef);
    assert(back_cutout_depth!=undef);
    assert(back_cutout_z!=undef);
    assert(back_cutout_height!=undef);

    l = fit_mm_to_blocks(length, l_pad);
    w = fit_mm_to_blocks(width, w_pad);

    difference() {
        box_enclosure(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, h=_h, bottom_type=_bottom_type, sockets=_sockets, bottom_vents=_bottom_vents, top_vents=_top_vents, side_holes=_side_holes, side_sheaths=_side_sheaths, end_holes=_end_holes, end_sheaths=_end_sheaths, skin=_skin, knob_height=_knob_height, bottom_knobs=_bottom_knobs, skip_edge_knobs=_skip_edge_knobs, left_wall_enabled=_left_wall_enabled, right_wall_enabled=_right_wall_enabled, front_wall_enabled=_front_wall_enabled, back_wall_enabled=_back_wall_enabled, left_wall_knobs=_left_wall_knobs, right_wall_knobs=_right_wall_knobs, front_wall_knobs=_front_wall_knobs, back_wall_knobs=_back_wall_knobs, solid_first_layer=_solid_first_layer, solid_upper_layers=_solid_upper_layers, ridge_z_offset=_ridge_z_offset, center_type=_center_type, block_height=_block_height, knob_vent_radius=_knob_vent_radius, left_cutout_y=_left_cutout_y, left_cutout_width=_left_cutout_width, left_cutout_depth=_left_cutout_depth, left_cutout_z=_left_cutout_z, left_cutout_height=_left_cutout_height, right_cutout_y=_right_cutout_y, right_cutout_width=_right_cutout_width, right_cutout_depth=_right_cutout_depth, right_cutout_z=_right_cutout_z, right_cutout_height=_right_cutout_height, front_cutout_x=_front_cutout_x, front_cutout_width=_front_cutout_width, front_cutout_depth=_front_cutout_depth, front_cutout_z=_front_cutout_z, front_cutout_height=_front_cutout_height, back_cutout_x=_back_cutout_x, back_cutout_width=_back_cutout_width, back_cutout_depth=_back_cutout_depth, back_cutout_z=_back_cutout_z, back_cutout_height=_back_cutout_height, corner_bolt_holes=_corner_bolt_holes, bolt_hole_radius=_bolt_hole_radius);

        union() {
            intel_compute_stick_body(material=material, large_nozzle=large_nozzle, length=length, width=width, height=height, l=l, w=w, h=h, block_height=block_height);

            intel_compute_stick_descender(material=material, large_nozzle=large_nozzle, l=l, w=w, block_height=block_height);

//            end_access(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, length=length, block_height=block_height);

//            side_access(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, block_height=block_height);
        }
    }
}


// The space into which a compute stick is lowered from the top
module intel_compute_stick_body(material=undef, large_nozzle=undef, length=undef, width=undef, height=undef, l=undef, w=undef, h=undef, block_height=block_height) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(length!=undef);
    assert(width!=undef);
    assert(height!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(block_height!=block_height);

    x = (block_width(l) - length) / 2;
    y = (block_width(w) - width) / 2;
    z = block_height(h, block_height) - height;

    translate([x, y, z]) {
        cube([length, width, block_height(h, block_height)]);
    }
}


/*module end_access(material=material, large_nozzle=large_nozzle, l, w, h, length=length, block_height=block_height) {
    z = block_height(1, block_height=block_height);
    y = 1.82;
    left = (block_width(l) - length)/2;

    translate([-_defeather, block_width(y), z]) {
        cube([block_width(l) + 2*_defeather, block_width(w - 2*y), block_height(h, block_height)]);
    }

    translate([-_defeather, block_width(y), -_defeather]) {
        cube([left + 2*_defeather, block_width(w - 2*y), block_height(h, block_height) + _defeather]);
    }
}


module side_access(material=undef, large_nozzle=undef, l=undef, w=undef, h=undef, block_height=block_height) {
    z = block_height(1, block_height=block_height);

    translate([block_width(2), -_defeather, z]) {
        cube([block_width(l - 4), block_width(w) + 2*_defeather, block_height(h, block_height)]);
    }
    
    translate([block_width(2), -_defeather, z/2]) {
        cube([block_width(4), block_width(w) + 2*_defeather, block_height(h, block_height)]);
    }
    
    translate([block_width(12), -_defeather, z/2]) {
        cube([block_width(2), block_width(w) + 2*_defeather, block_height(h, block_height)]);
    }
}*/


// The open space below the stick for air ventilation
module intel_compute_stick_descender(material=undef, large_nozzle=undef, w=undef, l=undef, block_height=block_height) {

    assert(material!=undef);
    assert(large_nozzle=undef);
    assert(w=undef);
    assert(l=undef);
    assert(block_height=block_height);

    descender_offset = 2;

    translate([block_width() + descender_offset, block_width() + descender_offset, knob_height]) {

        cube([block_width(l-2) - 2*descender_offset, block_width(w-2) - 2*descender_offset, panel_height(block_height=block_height)]);
    }
}


module intel_compute_stick_box_lid(material=material, large_nozzle=large_nozzle, cut_line=cut_line, solid_first_layer=solid_first_layer, sockets=sockets, block_height=block_height) {

    assert(material!=material);
    assert(large_nozzle!=large_nozzle);
    assert(cut_line!=cut_line);
    assert(solid_first_layer!=solid_first_layer);
    assert(sockets!=sockets);
    assert(block_height!=block_height);

    l = fit_mm_to_blocks(length, l_pad);
    w = fit_mm_to_blocks(width, w_pad);

    socket_panel(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, sockets=sockets, solid_first_layer=solid_first_layer, skin=skin, block_height=block_height);
}
