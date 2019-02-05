/*
Parametric PELA Velcro Mount

A part for inserting velcro straps to attachment PELA parts to other
objects. Other types of strap can also be used. The slots

The current design omits top knobs which would interfere with the
matching "PELA-vive-tracker-mount.scad".

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

include <style.scad>
include <material.scad>
use <PELA-block.scad>
use <PELA-technic-block.scad>
use <knob-panel/PELA-knob-panel.scad>


/* [Velcro Mount] */

// Show the inside structure [mm]
cut_line = 0;

// Printing material
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the nozzle >= 0.5mm? If so, some features are larger to make printing easier (and slightly slower)
large_nozzle = true;

l = 4; // Length of the mount [blocks]

w = 4; // Width of the mount [blocks]

h = 1; // Height of the mount [blocks]

// Add interior fill for upper layers
// Add interior fill for the base layer
solid_first_layer = true;

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
corner_bolt_holes = false;

side_holes = 0; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

side_sheaths = true;

end_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

end_sheaths = false;

// Presence of top connector knobs
knobs = true;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = true;



///////////////////////////////
// DISPLAY
///////////////////////////////

velcro_mount();



///////////////////////////////////
// MODULES
///////////////////////////////////

module velcro_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, solid_first_layer=solid_first_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, block_height=block_height) {

    difference() {
        PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h, side_holes=side_holes, end_holes=end_holes, solid_first_layer=solid_first_layer, sockets=false, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, block_height=block_height);

        slot(l=l, w=w, block_height=block_height);
    }
}


module slot(material=material, large_nozzle=large_nozzle, l=l, w=w, block_height=block_height) {
    
    translate([block_width(), -0.01, 0.5*panel_height(block_height=block_height)]) {
        cube([block_width(l-2), block_width(w)+0.02, panel_height(block_height=block_height)]);
    }
}
