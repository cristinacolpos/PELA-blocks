/*
PELA Blocks 3D Print Calibration Block Set

A single block or array of PELA blocks with different parameters.
Use these to find the ideal fit with real PELA blocks
for a given printer, settings and plastic combination. Pre-generated examples and numbers are as a guide only
based on tests with a Lulzbot Taz 6 printer and give example results but may not be suitable for your setup.

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/
*/

include <../style.scad>
include <../print-parameters.scad>
use <../PELA-technic-block.scad>
use <../PELA-block.scad>
include <PELA-calibration.scad>


/* [PELA Calibration Set Options */

end_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

side_holes = 0; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]




///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_calibration_set(l=l, w=w, h=h,  calibration_block_increment=calibration_block_increment, knob_height=knob_height, knob_flexture_height=knob_flexture_height, skin=skin, corner_bolt_holes=corner_bolt_holes, block_height=block_height, knobs=knobs) {
    
    // Tighter top, looser bottom
    for (i = [0:5]) {
        cal = i*calibration_block_increment;
        
        translate([i*block_width(l+0.5), 0, 0]) {
            PELA_calibration_block(l=l, w=w, h=h, top_tweak=cal, bottom_tweak=cal, axle_hole_tweak=cal, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, skin=skin, side_shell=side_shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);
        }
    }
    
    // Tightest top, loosest bottom
    for (i = [6:10]) {
        cal = i*calibration_block_increment;
        
        translate([(i-5)*block_width(l+0.5), -block_width(w+0.5), 0]) {
            PELA_calibration_block(l=l, w=w, h=h, top_tweak=cal, bottom_tweak=cal, axle_hole_tweak=cal, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, skin=skin, side_shell=side_shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);
        }
    }
    
    // Looser top, tighter bottom
    for (i = [1:5]) {
        cal = -i*calibration_block_increment;
        
        translate([i*block_width(l+0.5), block_width(w+0.5), 0]) {
            PELA_calibration_block(l=l, w=w, h=h, top_tweak=cal, bottom_tweak=cal, axle_hole_tweak=cal, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, skin=skin, side_shell=side_shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);
        }
    }
}
