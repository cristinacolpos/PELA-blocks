/*
PELA Blocks 3D Print Calibration Block Set

Published at http://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    http://futurice.com
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-technic-block.scad>
use <../PELA-block.scad>
use <PELA-calibration.scad>

/* [PELA Calibration Block Options, for convenience "tight" knobs are matched with equally "loose" sockets, but your best fit may not be identical. Test against real PELA first, then 3D printed to 3D printed using a calibration block with your selected paramters] */

// Length of each calibration block (PELA unit count)
l = 2; 

// Width of each calibration block (PELA unit count)
w = 2;

// Height of the block (PELA unit count, use 1/3 for short calibration panel)
h = 1;

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes = false;

end_holes = 3;

side_holes = 0;

end_sheaths = true;

side_sheaths = true;

top_vents = false;

knobs = true;

top_shell = 1;

top_tweak = 0;

bottom_tweak = 0;

axle_hole_tweak = 0;

// Font for calibration block text labels
font = "Arial";

// Text size on calibration blocks
font_size = 4;

// Depth of text labels on calibration blocks
text_extrusion_height = 0.6;

// Inset from block edge for text (vertical and horizontal)
vertical_text_margin = 0.2;

// Inset from block edge for text (vertical and horizontal)
horizontal_text_margin = 1;

// Size between calibration block test steps (0.02 or larger for a rough calibration, 0.01 to refine if already close)
calibration_block_increment = 0.02;


/////////////////////////////////////
// PELA Calibration Display
/////////////////////////////////////

PELA_calibration_set();


/////////////////////////////////////
// PELA CALIBRATION BLOCK MODULES
//
// A single block or array of PELA blocks with different parameters.
// Use these to find the ideal fit with real PELA blocks
// for a given printer, settings and plastic combination. Pre-generated examples and numbers are as a guide only
// based on tests with a Lulzbot Taz 6 printer and give example results but may not be suitable for your setup.
/////////////////////////////////////


// A set of blocks with different tweak parameters written on the side
module PELA_calibration_set(l=l, w=w, h=h,  calibration_block_increment=calibration_block_increment, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_flexture_radius=knob_flexture_radius, skin=skin, bolt_holes=bolt_holes, block_height=block_height, side_lock_thickness=side_lock_thickness, knobs=knobs) {
    
    // Tighter top, looser bottom
    for (i = [0:5]) {
        cal = i*calibration_block_increment;
        
        translate([i*block_width(l+0.5), 0, 0]) {
            PELA_calibration_block(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, axle_hole_tweak=axle_hole_tweak, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, ring_radius=ring_radius, knob_flexture_radius=knob_flexture_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_lock_thickness=side_lock_thickness, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);
        }
    }
    
    // Tightest top, loosest bottom
    for (i = [6:10]) {
        cal = i*calibration_block_increment;
        
        translate([(i-5)*block_width(l+0.5), -block_width(w+0.5), 0]) {
            PELA_calibration_block(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, axle_hole_tweak=axle_hole_tweak, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, ring_radius=ring_radius, knob_flexture_radius=knob_flexture_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_lock_thickness=side_lock_thickness, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);
        }
    }
    
    // Looser top, tighter bottom
    for (i = [1:5]) {
        cal = -i*calibration_block_increment;
        
        translate([i*block_width(l+0.5), block_width(w+0.5), 0]) {
            PELA_calibration_block(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, axle_hole_tweak=axle_hole_tweak, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, ring_radius=ring_radius, knob_flexture_radius=knob_flexture_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_lock_thickness=side_lock_thickness, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);
        }
    }
}
