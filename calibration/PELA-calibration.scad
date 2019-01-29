/*
PELA Blocks 3D Print Calibration Bar

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

include <../parameters.scad>
include <../print-parameters.scad>
use <../PELA-technic-block.scad>
use <../PELA-block.scad>

/* [PELA Calibration Block Options, for convenience "tight" knobs are matched with equally "loose" sockets, but your best fit may not be identical. Test against real PELA first, then 3D printed to 3D printed using a calibration block with your selected paramters] */

// Length of each calibration block (PELA unit count)
l = 2; 

// Width of each calibration block (PELA unit count)
w = 2;

// Height of the block (PELA unit count, use 1/3 for short calibration panel)
h = 1;

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
corner_bolt_holes = false;

end_holes = 0;

side_holes = 2;

side_sheaths = true;

end_sheaths = true;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

knobs = true;

top_shell = 1;

top_tweak = 0;

bottom_tweak = 0;

axle_hole_tweak = 0;

// Font for calibration block text labels
font = "Arial";

// Text size on calibration blocks
font_size = 4.8;

// Text size on calibration blocks
font_size2 = 4.2;

// Depth of text labels on calibration blocks
text_extrusion_height = 0.4;

// Inset from block edge for text (vertical and horizontal)
vertical_text_margin = 0.2;

// Inset from block edge for text (vertical and horizontal)
horizontal_text_margin = 1;

// Size between calibration block test steps (0.02 or larger for a rough calibration, 0.01 to refine if already close)
calibration_block_increment = 0.02;

block_height = 9.6;

flexible_material = false;

large_nozzle = false;



///////////////////////////////////
// Modules
///////////////////////////////////

module PELA_calibration_bar(l=l, w=w, h=h, calibration_block_increment=calibration_block_increment, knob_height=knob_height, knob_flexture_height=knob_flexture_height, corner_bolt_holes=corner_bolt_holes, block_height=block_height, knobs=knobs, flexible_material=flexible_material, large_nozzle=large_nozzle) {
    
    from=-4;
    to=4;
    
    // Tighter top, looser bottom
    for (i = [from:to]) {
        cal = i*calibration_block_increment;
        
        translate([i*block_width(l)-i*shell, 100*cal, 0])
            PELA_calibration_block(l=l, w=w, h=h, top_tweak=cal, bottom_tweak=cal, axle_hole_tweak=cal, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, skin=0, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs, flexible_material=flexible_material, large_nozzle=large_nozzle);
    }
}


// A block with the top and bottom connector tweak parameters etched on the side
module PELA_calibration_block(l=l, w=w, h=h, top_tweak, bottom_tweak, axle_hole_tweak, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs, block_height=block_height, flexible_material=flexible_material, large_nozzle=large_nozzle) {
    
    difference() { 
        PELA_technic_block(l=l, w=w, h=h, axle_hole_radius=axle_hole_radius+axle_hole_tweak, knob_height=knob_height, knob_flexture_height=knob_flexture_height, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs, block_height=block_height, flexible_material=flexible_material, large_nozzle=large_nozzle, bottom_tweak=bottom_tweak, top_tweak=top_tweak, axle_hole_tweak=axle_hole_tweak);

        union() {
            translate([skin+horizontal_text_margin, text_extrusion_height+skin-defeather, skin+block_height(h, block_height=block_height)-vertical_text_margin]) {
                rotate([90 ,0, 0]) {
                    calibration_text(txt=str(top_tweak), halign="left", valign="top");

                    lower_label(flexible_material=flexible_material);
                }
            }
            
            translate([block_width(w)-skin-horizontal_text_margin, block_width(w)-text_extrusion_height-skin+defeather, skin+vertical_text_margin]) {
                rotate([90, 0, 180]) {
                    calibration_text(txt=str(bottom_tweak), halign="left", valign="bottom");

                    upper_label(large_nozzle=large_nozzle);
                }
            }
        }
    }
}


// Is this calibration block for flexible (TPU..) or normal (PLA..) plastic?
module lower_label(flexible_material=flexible_material) {
    txt = flexible_material ? "Flex" : "Norm";
    translate([0, -5, 0]) {
        calibration_text(txt=txt, halign="left", valign="top", font_size=font_size2);
    }
}


// Is this calibration block for a large extruder (no thin walls because 0.5mm nozzle or larger) or small (< 0.5mm)? You can use the "large" setting with any extruder, but the parts are slightly heavier and the alternate line holes are not suitable for knob attachment because they must be smaller to leave room for thicker walls
module upper_label(large_nozzle=large_nozzle) {
    txt = large_nozzle ? "Thick" : "Thin";

    translate([0, 5, 0]) {
        calibration_text(txt=txt, halign="left", valign="bottom", font_size=font_size2);
    }
}


// Text for the front side of calibration block prints
module calibration_text(txt="Text", halign="left", valign="top", font_size=font_size) {
    
    linear_extrude(height=text_extrusion_height) {        
        text(text=txt, font=font, size=font_size, halign=halign, valign=valign);
    }
}
