/*
PELA Parametric Knob Panel

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Import this into other design files:
    use <PELA-block.scad>
*/

include <material.scad>
include <style.scad>
use <PELA-block.scad>
use <PELA-technic-block.scad>



/* [Knob Panel] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Length of the block [blocks]
l = 8; // [1:1:20]

// Width of the block [blocks]
w = 8; // [1:1:20]

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
corner_bolt_holes = true;

// Size of corner holes for M3 mountings bolts
bolt_hole_radius = 1.6; // [0.0:0.1:3.0]

// Presence of top connector knobs (vs flat)
knobs = true;

// Height of traditional connectors [mm] (taller gives a stronger hold)
knob_height = 2.9; // [1.8:traditional blocks, 2.9:PELA 3D print tall]

// Size of a hole in the top of each knob. Set 0 to disable for best flexture or enable for air circulation/aesthetics/drain resin
knob_vent_radius = 0.0; // [0.0:0.1:3.9]

// Presence of bottom socket connectors (vs flat)
sockets = true;

// Height of horizontal surface strengthening slats (appears between the bottom rings)
bottom_stiffener_height = 0.0;

// How many outside rows and columns on all edges to omit before adding knobs
skip_edge_knobs = 0;

// Basic unit vertical size of each block
block_height = 8; // [8:technic, 9.6:traditional blocks]

// Horizontal clearance space removed from the outer horizontal surface to allow two parts to be placed next to one another on a 8mm grid
skin = 0.1;


///////////////////////////////
// DISPLAY
///////////////////////////////

knob_panel(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, top_vents=top_vents, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, knob_height=knob_height, sockets=sockets, skip_edge_knobs=skip_edge_knobs, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height, knob_vent_radius=knob_vent_radius, skin=skin);




///////////////////////////////////
// MODULES
///////////////////////////////////

module knob_panel(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, top_vents=undef, corner_bolt_holes=undef, bolt_hole_radius=undef, knobs=undef, knob_height=undef, sockets=undef, skip_edge_knobs=undef, bottom_stiffener_height=undef, block_height=undef, knob_vent_radius=undef, knob_height=_knob_height, skin=_skin) {

    hr=panel_height_ratio(block_height=block_height);

    if (skip_edge_knobs > 0) {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=hr, top_vents=top_vents, solid_first_layer=false, solid_upper_layers=false, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, side_holes=0, side_sheaths=false, end_holes=0, end_sheaths=false, knob_height=knob_height,  bottom_stiffener_height=bottom_stiffener_height, knobs=false, sockets=sockets, block_height=block_height, knob_vent_radius=knob_vent_radius, skin=skin);

        echo("knob l", l);
        echo("knob w", w);
        if (l>2 && w>2) {
            translate([block_width(skip_edge_knobs), block_width(skip_edge_knobs), 0]) {
                
                top_knob_set(material=material, large_nozzle=large_nozzle, l=l-2*skip_edge_knobs, w=w-2*skip_edge_knobs, h=hr, corner_bolt_holes=false, block_height=block_height);
            }
        }
    } else {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=hr, top_vents=top_vents, solid_first_layer=false, solid_upper_layers=false, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, side_holes=0,  side_sheaths=0, end_holes=0, end_sheaths=0, bottom_stiffener_height=bottom_stiffener_height, knobs=knobs, knob_height=knob_height, sockets=sockets, block_height=block_height, knob_vent_radius=knob_vent_radius, skin=skin);
    }
}
