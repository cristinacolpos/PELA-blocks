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
    http://futurice.com

Import this into other design files:
    use <anker-usb-PELA-enclosure.scad>
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../socket-panel/PELA-socket-panel.scad>
use <../knob-panel/PELA-knob-panel.scad>


/* [PELA Box Option] */

// Length of the enclosure including two for walls (PELA knob count)
l = 8;

// Width of the enclosure including two for walls (PELA knob count)
w = 4;

// Height of the enclosure not including the possible drop_bottom floor (PELA block layer count)
h = 2;

// Presence of bottom connector sockets
sockets = true;

// Add full width through holes spaced along the length for PELA Techics connectors
side_holes = 3;  // [0:disabled, 1:short air vents, 2:full width connectors, 3:short connectors]

// Add a sheath around side holes (disable for extra ventilation, enable for connector lock notches)
side_sheaths = true;

// Add short end holes spaced along the width for PELA Techics connectors
end_holes = 0;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full length connectors]

// Add a sheath around end holes  (disable for extra ventilation, enable for connector lock notches)
end_sheaths = true;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

// Add holes in the bottom deck to improve airflow and reduce weight (only used with bottom_type==3, knob panel)
bottom_vents = true;

// Size of a hole in the top of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
knob_vent_radius = 0;

// There is usually no need or room for corner mounting M3 bolt holes
bolt_holes = true;

// Bottom of enclosure
bottom_type = 2; // [0:open bottom, 1:solid bottom, 2:socket-panel bottom, 3:knob-panel bottom]

// Height of the bottom to the enclosure (by default this is shorter then a normal panel so there is room on the enclosure sides for technic holes)
bottom_height = 2.5;

// Size of the small flexture cavity inside each knob (set to 0 for flexible materials, if the knobs delaminate and detach, or to avoid holes if the knobs are removed)
knob_flexture_radius = 0;

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

// Interior fill for layers above the bottom
solid_upper_layers = true;

// Interior fill for layers above the bottom
solid_bottom_layer = false;

// Bottom of the enclosure is a panel below the edges of the wall (if true, box is 1/3 of a block taller)
drop_bottom = false;

// Number of knobs at the edge to not add to the top panel (leave space for example for a nearby top wall or technic connectors)
skip_edge_knobs = 1;


///////////////////////////////////
// PELA Box Enclosure Display
///////////////////////////////////
PELA_box_enclosure();


///////////////////////////////////
// Modules
///////////////////////////////////

module PELA_box_enclosure(l=l, w=w, h=h, bottom_type=bottom_type, panel_height=panel_height, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, knob_flexture_radius=knob_flexture_radius, drop_bottom=drop_bottom, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, ridge_z_offset=ridge_z_offset) {

    difference() {
        union() {
            bottom_z = drop_bottom  ? -panel_height : 0;

            difference() {
                union() {
                    rz = ridge_z_offset + bottom_z;

                    if (left_wall_enabled) {
                        left_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=left_wall_knobs, knob_flexture_radius=knob_flexture_radius, ridge_z_offset=rz);
                    }

                    if (right_wall_enabled) {
                        right_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=right_wall_knobs, knob_flexture_radius=knob_flexture_radius, ridge_z_offset=rz);
                    }

                    if (front_wall_enabled) {
                        front_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=front_wall_knobs, knob_flexture_radius=knob_flexture_radius, ridge_z_offset=rz);
                    }

                    if (back_wall_enabled) {
                        back_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=back_wall_knobs, knob_flexture_radius=knob_flexture_radius, ridge_z_offset=rz);
                    }
                }

                if (!drop_bottom && bottom_type > 0) {
                    bottom_negative_space(l=l, w=w, bottom_type=1, panel_height=panel_height, skin=0, solid_bottom_layer=solid_bottom_layer);
                }
            }

            translate([0, 0, bottom_z]) {
                enclosure_bottom(l=l, w=w, bottom_type=bottom_type, panel_height=panel_height, skin=skin, solid_bottom_layer=solid_bottom_layer);
            }
        }

        edge_connector_negative_space(l=l, w=w, bottom_type=bottom_type, panel_height=panel_height, side_holes=side_holes, end_holes=end_holes, axle_hole_radius=axle_hole_radius, hole_type=side_holes, knob_radius=knob_radius, bolt_holes=bolt_holes);
    }
}


// Left side of the box with corner cuts
module left_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=left_wall_knobs, knob_flexture_radius=knob_flexture_radius, ridge_z_offset=ridge_z_offset) {

    difference() {
        PELA_technic_block(l=1, w=w, h=h, top_vents=top_vents, side_holes=0, side_sheaths=0, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, knobs=knobs, knob_flexture_radius= knob_flexture_radius, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=knobs, knob_flexture_radius=knob_flexture_radius, ridge_z_offset=ridge_z_offset);

        union() {
            if (front_wall_enabled) {
                corner_cut(angle=-45, h=h);
            }

            if (back_wall_enabled) {
                translate([0, block_width(w), 0]) {
                    corner_cut(angle=-45, h=h);
                }
            }
        }
    }
}


// A slice removed so that two wall fit together as a single whole
module corner_cut(angle, h=h) {
    translate([0, 0, -defeather]) {
        rotate([0, 0, angle]) {
            cube([block_width(2), block_width(2), block_height(h)]);
        }
    }
}


// Mirror image of the left side
module right_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=right_wall_knobs, knob_flexture_radius=knob_flexture_radius, ridge_z_offset=ridge_z_offset) {

    translate([block_width(l), block_width(w), 0]) {
        rotate([0, 0, 180]) {
            left_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=back_wall_enabled, back_wall_enabled=front_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=knobs, knob_flexture_radius=knob_flexture_radius, ridge_z_offset=ridge_z_offset);
        }
    }
}


// Front side of the box with corner cuts
module front_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=front_wall_knobs, knob_flexture_radius=knob_flexture_radius, ridge_z_offset=ridge_z_offset) {

    difference() {
        PELA_technic_block(l=l, w=1, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=0, end_sheaths=0, skin=skin, knobs=knobs, knob_flexture_radius=knob_flexture_radius, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=knobs, ridge_z_offset=ridge_z_offset);

        union() {
            if (left_wall_enabled) {
                corner_cut(angle=45, h=h);
            }

            if (right_wall_enabled) {
                translate([block_width(l), 0, 0]) {
                    corner_cut(angle=45, h=h);
                }
            }
        }
    }
}


// Mirror image of the front wall
module back_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=back_wall_knobs, knob_flexture_radius=knob_flexture_radius, ridge_z_offset=ridge_z_offset) {

    translate([block_width(l), block_width(w), 0]) {
        rotate([0, 0, 180]) {
            front_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=right_wall_enabled, right_wall_enabled=left_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=knobs, knob_flexture_radius=knob_flexture_radius, ridge_z_offset=ridge_z_offset);
        }
    }
}


// Cutout for the box bottom
module bottom_negative_space(l=l, w=w, bottom_type=bottom_type, bottom_height=bottom_height, skin=skin, solid_bottom_layer=solid_bottom_layer) {
    
    if (bottom_type > 0) {
        enclosure_bottom(l=l, w=w, bottom_type=1, panel_height=bottom_height, skin=skin, solid_bottom_layer=solid_bottom_layer);
    }
}


// Space for the edge connectors
module edge_connector_negative_space(l=l, w=w, bottom_type=bottom_type, side_holes=side_holes, end_holes=end_holes, axle_hole_radius=axle_hole_radius, block_width=block_width, hole_type=side_holes, knob_radius=knob_radius, block_width=block_width, bolt_holes=bolt_holes) {

    if (bottom_type > 0) {
        bottom_connector_negative_space(l=l, w=w, side_holes=side_holes, end_holes=end_holes, axle_hole_radius=axle_hole_radius, hole_type=side_holes, knob_radius=knob_radius, bolt_holes=bolt_holes);
    }
}


// The optional bottom layer of the box
module enclosure_bottom(l=l, w=w, bottom_type=bottom_type, bottom_height=bottom_height, skin=skin, skip_edge_knobs=skip_edge_knobs, solid_bottom_layer=solid_bottom_layer) {

    if (bottom_type==1) {
        translate([skin, skin, 0]) {
            cube([block_width(l)-2*skin, block_width(w)-2*skin, bottom_height]);
        }
    } else if (bottom_type==2) {
        PELA_socket_panel_one_sided(l=l, w=w, panel_height=bottom_height, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, skin=skin);        
    } else if (bottom_type==3) {
        // bottom_height is ignored- must adapt to be taller if tall knob_height (which is default)
        PELA_knob_panel(l=l, w=w, top_vents=bottom_vents, solid_bottom_layer=solid_bottom_layer, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, sockets=sockets, skin=skin, skip_edge_knobs=skip_edge_knobs);
    }
}