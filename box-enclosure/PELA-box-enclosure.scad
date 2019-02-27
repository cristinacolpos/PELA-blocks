/*
Parametric PELA Box Enclosure Generator

Create a bottom and 4 walls of a rectangle for enclosing objects


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Import this into other design files:
    use <anker-usb-PELA-enclosure.scad>
*/

include <../style.scad>
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../PELA-socket-panel.scad>
use <../PELA-knob-panel.scad>


/* [PELA Box Enclosure] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Length of the enclosure including two for walls [blocks]
l = 6; // [1:1:20]

// Width of the enclosure including two for walls [blocks]
w = 4; // [1:1:20]

// Height of the enclosure [mm]
h = 2; // [1:1:20]

// Presence of bottom connector sockets
sockets = true;

// Add full width through holes spaced along the length for techic connectors
side_holes = 2;  // [0:disabled, 1:short air vents, 2:full width connectors, 3:short connectors]

// Add a wrapper around side holes (disable for extra ventilation, enable for lock notch fit)
side_sheaths = true;

// Add short end holes spaced along the width for techic connectors
end_holes = 3;  // [0:disabled, 1:short air vents, 2:full length connectors, 3:short connectors]

// Add a wrapper around end holes  (disable for extra ventilation but loose lock notches)
end_sheaths = true;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

// Add holes in the bottom deck to improve airflow and reduce weight (only used with bottom_type == 3, knob panel)
bottom_vents = true;

// Size of a hole in the top of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
knob_vent_radius = 0.0; // [0.0:0.1:3.9]

// There is usually no need or room for corner mounting M3 bolt holes
corner_bolt_holes = true;

// Bottom of enclosure
bottom_type = 3; // [0:open bottom, 1:solid bottom, 2:socket panel bottom, 3:knob panel bottom]

// Create the left wall
left_wall_enabled = true;

// Shoud there be knobs on top of the left wall
left_wall_knobs = true;

// Create the right wall
right_wall_enabled = true;

// Shoud there be knobs on top of the right wall
right_wall_knobs = true;

// Create the front wall
front_wall_enabled = true;

// Shoud there be knobs on top of the front wall
front_wall_knobs = true;

// Create the back wall
back_wall_enabled = true;

// Shoud there be knobs on top of the back wall
back_wall_knobs = true;

// Add interior fill for upper layers
solid_upper_layers = true;

// Add interior fill for the base layer
solid_first_layer = false;

// Filler for the model center space
center_type = 0; //[0:empty, 1:solid, 2:solid with side holes, 3:solid with end holes, 4:solid with both side and end holes]

// Number of knobs at the edge of a bottom panel to omit (this will leave space for example for a nearby top wall or technic connectors)
skip_edge_knobs = 1;

// Basic unit vertical size of each block
block_height = 9.6; // [8:technic, 9.6:traditional blocks]



///////////////////////////////
// DISPLAY
///////////////////////////////

box_enclosure(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, bottom_type=bottom_type, sockets=sockets, bottom_vents=bottom_vents, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, skip_edge_knobs=skip_edge_knobs, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, ridge_z_offset=ridge_z_offset, center_type=center_type, block_height=block_height, knob_vent_radius=knob_vent_radius);



///////////////////////////////////
// MODULES
///////////////////////////////////

module box_enclosure(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, h=undef, bottom_type=undef, sockets=undef, top_vents=undef, bottom_vents=bottom_vents, side_holes=undef, side_sheaths=undef, end_holes=undef, end_sheaths=undef, skin=undef, skip_edge_knobs=undef, left_wall_enabled=undef, right_wall_enabled=undef, front_wall_enabled=undef, back_wall_enabled=undef, left_wall_knobs=undef, right_wall_knobs=undef, front_wall_knobs=undef, back_wall_knobs=undef, solid_first_layer=undef, solid_upper_layers=undef, ridge_z_offset=undef, center_type=undef, block_height=undef, knob_vent_radius=undef) {

    difference() {
        box_enclosure_positive_space(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, bottom_type=bottom_type, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, skip_edge_knobs=skip_edge_knobs, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, ridge_z_offset=ridge_z_offset, center_type=center_type, block_height=block_height, knob_vent_radius=knob_vent_radius);

        union() {    
            bottom_connector_negative_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, side_holes=side_holes, end_holes=end_holes, block_width=block_width, hole_type=3, corner_bolt_holes=false, sockets=sockets, block_height=block_height);

            edge_connector_negative_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, bottom_type=bottom_type, side_holes=side_holes, end_holes=end_holes, hole_type=side_holes, corner_bolt_holes=corner_bolt_holes, block_height=block_height);

            cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=h, block_width=block_width, block_height=block_height, knob_height=knob_height);
        }
    }
}


module box_enclosure_positive_space(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, bottom_type=bottom_type, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, skip_edge_knobs=skip_edge_knobs, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, ridge_z_offset=ridge_z_offset, center_type=center_type, block_height=block_height, knob_vent_radius=knob_vent_radius) {

    walls(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, bottom_type=bottom_type, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, ridge_z_offset=ridge_z_offset, center_type=center_type, block_height=block_height, knob_vent_radius=knob_vent_radius);

    enclosure_bottom(material=material, large_nozzle=large_nozzle, l=l, w=w, bottom_type=bottom_type, sockets=sockets, bottom_vents=bottom_vents, skin=skin, skip_edge_knobs=skip_edge_knobs, solid_first_layer=solid_first_layer, block_height=block_height, knob_vent_radius=knob_vent_radius);

    box_center(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, center_type=center_type, side_holes=side_holes, end_holes=end_holes, block_height=block_height);
}


module walls(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, bottom_type=bottom_type, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, ridge_z_offset=ridge_z_offset, center_type=center_type, block_height=block_height, knob_vent_radius=knob_vent_radius) {

    difference() {
        union() {
            if (left_wall_enabled) {
                left_wall(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=left_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height, knob_vent_radius=knob_vent_radius);
            }

            if (right_wall_enabled) {
                right_wall(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=right_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height, knob_vent_radius=knob_vent_radius);
            }

            if (front_wall_enabled) {
                front_wall(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=front_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height, knob_vent_radius=knob_vent_radius);
            }

            if (back_wall_enabled) {
                back_wall(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=back_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height, knob_vent_radius=knob_vent_radius);
            }
        }

        hull() {
            bottom_negative_space(material=material, large_nozzle=large_nozzle, l=l, w=w, sockets=sockets, bottom_type=bottom_type, skin=0, solid_first_layer=solid_first_layer, block_height=block_height);
        }
    }
}


// Left side of the box with corner cuts
module left_wall(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=left_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height, knob_vent_radius=knob_vent_radius) {

    difference() {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, l=1, w=w, h=h, sockets=sockets, top_vents=top_vents, side_holes=0, side_sheaths=0, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, knobs=knobs, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=knobs, ridge_z_offset=ridge_z_offset, block_height=block_height, knob_vent_radius=knob_vent_radius);

        union() {
            if (front_wall_enabled) {
                corner_cut(material=material, large_nozzle=large_nozzle, angle=-45, h=h, block_height=block_height);
            }

            if (back_wall_enabled) {
                translate([0, block_width(w, block_width), 0]) {
                    corner_cut(material=material, large_nozzle=large_nozzle, angle=-45, h=h, block_height=block_height);
                }
            }
        }
    }
}


// A slice removed so that two wall fit together as a single whole
module corner_cut(material=material, large_nozzle=large_nozzle, angle, h=h, block_height=block_height) {
    translate([0, 0, -defeather]) {
        rotate([0, 0, angle]) {
            cube([block_width(2), block_width(2), block_height(h, block_height) + defeather]);
        }
    }
}


// Mirror image of the left side
module right_wall(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=right_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height, knob_vent_radius=knob_vent_radius) {

    translate([block_width(l), block_width(w, block_width), 0]) {
        rotate([0, 0, 180]) {
            left_wall(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=back_wall_enabled, back_wall_enabled=front_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=knobs, ridge_z_offset=ridge_z_offset, block_height=block_height, knob_vent_radius=knob_vent_radius);
        }
    }
}


// Front side of the box with corner cuts
module front_wall(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=front_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height, knob_vent_radius=knob_vent_radius) {

    difference() {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, l=l, w=1, h=h, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=0, end_sheaths=0, skin=skin, knobs=knobs, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=knobs, ridge_z_offset=ridge_z_offset, block_height=block_height, knob_vent_radius=knob_vent_radius);

        union() {
            if (left_wall_enabled) {
                corner_cut(material=material, large_nozzle=large_nozzle, angle=45, h=h, block_height=block_height);
            }

            if (right_wall_enabled) {
                translate([block_width(l), 0, 0]) {
                    corner_cut(material=material, large_nozzle=large_nozzle, angle=45, h=h, block_height=block_height);
                }
            }
        }
    }
}


// Mirror image of the front wall
module back_wall(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=back_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height, knob_vent_radius=knob_vent_radius) {

    translate([block_width(l), block_width(w, block_width), 0]) {
        rotate([0, 0, 180]) {
            front_wall(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, sockets=sockets, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=right_wall_enabled, right_wall_enabled=left_wall_enabled, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, knobs=knobs, ridge_z_offset=ridge_z_offset, block_height=block_height, knob_vent_radius=knob_vent_radius);
        }
    }
}


// Cutout for the box bottom
module bottom_negative_space(material=material, large_nozzle=large_nozzle, l=l, w=w, sockets=sockets, bottom_type=bottom_type, skin=skin, solid_first_layer=solid_first_layer, block_height=block_height) {
    
    if (bottom_type > 0) {
        enclosure_bottom(material=material, large_nozzle=large_nozzle, l=l, w=w, sockets=sockets, bottom_type=1, skin=skin, solid_first_layer=solid_first_layer, block_height=block_height);
    }
}


// Space for the edge connectors
module edge_connector_negative_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, sockets=sockets, bottom_type=bottom_type, side_holes=side_holes, end_holes=end_holes, block_width=block_width, hole_type=side_holes, block_width=block_width, corner_bolt_holes=corner_bolt_holes, block_height=block_height) {

    if (bottom_type > 0) {
        bottom_connector_negative_space(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, side_holes=side_holes, end_holes=end_holes, hole_type=side_holes, corner_bolt_holes=corner_bolt_holes, sockets=sockets, block_height=block_height);
    }
}


// The optional bottom layer of the box
module enclosure_bottom(material=material, large_nozzle=large_nozzle, l=l, w=w, bottom_type=bottom_type, sockets=sockets, bottom_vents=bottom_vents, skin=skin, skip_edge_knobs=skip_edge_knobs, solid_first_layer=solid_first_layer, block_height=block_height, knob_vent_radius=knob_vent_radius) {

    if (bottom_type == 1) {
        translate([block_width(1, block_width)-skin, block_width(1, block_width)-skin, 0]) {
            cube([block_width(l-2)+2*skin, block_width(w-2, block_width)+2*skin, panel_height(block_height=block_height)]);
        }
    } else if (bottom_type == 2) {
        socket_panel(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, sockets=sockets, solid_first_layer=solid_first_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, skin=0, block_height=block_height);
    } else if (bottom_type == 3) {
        knob_panel(material=material, large_nozzle=large_nozzle, l=l, w=w, top_vents=bottom_vents, solid_first_layer=solid_first_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, sockets=sockets, skin=skin, skip_edge_knobs=skip_edge_knobs, block_height=block_height, knob_vent_radius=knob_vent_radius);
   }
}


// The middle "cheese" from which enclosure supports are cut
module box_center(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, center_type=center_type, side_holes=side_holes, end_holes=end_holes, block_height=block_height) {
    if (center_type > 0 && l > 2 && w > 2) {
        l2 = block_width(l-2) + 2*skin;
        w2 = block_width(w-2) + 2*skin;

        translate([block_width(1) - skin, block_width(1) - skin, panel_height(block_height=block_height)]) {
            cube([l2, w2, block_height(h, block_height) - panel_height(block_height=block_height)]);
        }
    }
}
