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

include <../style.scad>
include <../print-parameters.scad>
use <../PELA-technic-block.scad>
use <../PELA-block.scad>



/* [PELA Calibration Block] */

// Is the nozzle >= 0.5mm? If so, some features are larger to make printing easier (and slightly slower)
large_nozzle = true;

// Generate a calibration bar (vs a set of individual calibration blocks)
calibration_bar = true;

// Number of calibration blocks in the bar
bar_length = 9;

// Length of each calibration block [blocks]
l = 2; 

// Width of each calibration block [blocks]
w = 2;

// Height of the block (PELA unit count, use 1/3 for short calibration panel)
h = 1;

side_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

side_sheaths = true;

// Depth of text labels on calibration blocks
text_extrusion_height = 0.4;

// Inset from block edge for text (vertical and horizontal)
vertical_text_margin = 0.2;

// Inset from block edge for text (vertical and horizontal)
horizontal_text_margin = 1;

// Size between calibration block test steps (0.02 or larger for a rough calibration, 0.01 to refine if already close)
calibration_block_increment = 0.02;

// Height of traditional connectors [mm] (taller gives a stronger hold especially for flexible materials, too tall can cause problems when connecting to thin panels)
knob_height = 2.9; // [1.8:traditional blocks, 2.9:PELA 3D print fit]

// Basic unit vertical size of each block
block_height = 9.6; // [8:technic, 9.6:traditional blocks]



/* [Hidden] */

knobs = true;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

end_holes = 0; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Font for calibration block text labels
font = "Arial";

// Text size on calibration blocks
font_size = 4.8 - (block_height < 9.6 ? 1.4 : 0);

// Text size on calibration blocks
font_size2 = 4.2 - (block_height < 9.6 ? 1.4 : 0);

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
corner_bolt_holes = false;


///////////////////////////////
// DISPLAY
///////////////////////////////

if (calibration_bar) {
    PELA_calibration_bar(large_nozzle=large_nozzle, bar_length=bar_length, l=l, w=w, h=h, calibration_block_increment=calibration_block_increment, knob_height=knob_height, knob_flexture_height=knob_flexture_height, corner_bolt_holes=corner_bolt_holes, block_height=block_height, knobs=knobs);
} else {
    PELA_calibration_set(l=l, w=w, h=h, side_holes=end_holes, end_holes=side_holes, calibration_block_increment=calibration_block_increment, knob_height=knob_height, knob_flexture_height=knob_flexture_height, skin=skin, corner_bolt_holes=false, block_height=block_height, knobs=knobs);
}


///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_calibration_bar(large_nozzle=large_nozzle, bar_length=bar_length, l=l, w=w, h=h, calibration_block_increment=calibration_block_increment, knob_height=knob_height, knob_flexture_height=knob_flexture_height, corner_bolt_holes=corner_bolt_holes, block_height=block_height, knobs=knobs) {

    assert(bar_length > 1, "Bar length must be at least 2");

    from = -floor((bar_length - 1)/2);
    to = ceil((bar_length - 1)/2);
    
    // Tighter top, looser bottom
    for (i = [from:to]) {
        cal = i*calibration_block_increment;
        
        translate([i*block_width(l), 2*i, 0]) {

            PELA_calibration_block(material=0, large_nozzle=large_nozzle, l=l, w=w, h=h, top_tweak=cal, bottom_tweak=cal, axle_hole_tweak=cal, knob_height=knob_height, knob_flexture_height=knob_flexture_height, skin=skin, side_shell=side_shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);
        }
    }
}


// A block with the top and bottom connector tweak parameters etched on the side
module PELA_calibration_block(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, top_tweak=undef, bottom_tweak=undef, axle_hole_tweak=undef, knob_height=knob_height, knob_flexture_height=knob_flexture_height, skin=skin, side_shell=side_shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs, block_height=block_height) {
    
    difference() { 
        PELA_technic_block(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, knob_height=knob_height, knob_flexture_height=knob_flexture_height, skin=skin, side_shell=side_shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs, block_height=block_height, bottom_tweak=bottom_tweak, top_tweak=top_tweak, axle_hole_tweak=axle_hole_tweak);

        union() {
            translate([skin+horizontal_text_margin, text_extrusion_height+skin-defeather, skin+block_height(h, block_height=block_height)-vertical_text_margin]) {
                rotate([90 ,0, 0]) {
                    calibration_text(txt=str(top_tweak), halign="left", valign="top");

                    lower_label(material=material);
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
module lower_label(material=material) {

    txt = material_name(material);
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


module PELA_calibration_set(l=l, w=w, h=h, side_hole=side_holes, end_holes=end_holes, calibration_block_increment=calibration_block_increment, knob_height=knob_height, knob_flexture_height=knob_flexture_height, skin=skin, corner_bolt_holes=corner_bolt_holes, block_height=block_height, knobs=knobs) {
    
    // Tighter top, looser bottom
    for (i = [0:5]) {
        cal = i*calibration_block_increment;
        
        translate([i*block_width(l+0.5), 0, 0]) {
            PELA_calibration_block(large_nozzle=large_nozzle, l=l, w=w, h=h, top_tweak=cal, bottom_tweak=cal, axle_hole_tweak=cal, knob_height=knob_height, knob_flexture_height=knob_flexture_height, skin=skin, side_shell=side_shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);
        }
    }
    
    // Tightest top, loosest bottom
    for (i = [6:10]) {
        cal = i*calibration_block_increment;
        
        translate([(i-5)*block_width(l+0.5), -block_width(w+0.5), 0]) {

            PELA_calibration_block(large_nozzle=large_nozzle, l=l, w=w, h=h, top_tweak=cal, bottom_tweak=cal, axle_hole_tweak=cal, knob_height=knob_height, knob_flexture_height=knob_flexture_height, skin=skin, side_shell=side_shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);
        }
    }
    
    // Looser top, tighter bottom
    for (i = [1:5]) {
        cal = -i*calibration_block_increment;
        
        translate([i*block_width(l+0.5), block_width(w+0.5), 0]) {
            PELA_calibration_block(large_nozzle=large_nozzle, l=l, w=w, h=h, top_tweak=cal, bottom_tweak=cal, axle_hole_tweak=cal, knob_height=knob_height, knob_flexture_height=knob_flexture_height, skin=skin, side_shell=side_shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);
        }
    }
}
