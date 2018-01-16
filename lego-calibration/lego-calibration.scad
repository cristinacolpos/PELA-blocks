/*
Parametric LEGO-compatible 3D Print Calibration Block

Published at
    http://www.thingiverse.com/thing:2303714
Maintained at
    https://github.com/paulirotta/parametric_lego
See also the related files
    LEGO Sign Generator - https://www.thingiverse.com/thing:2546028
    LEGO Enclosure Generator - https://www.thingiverse.com/thing:2544197


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com
*/

include <../lego-parameters.scad>
use <../technic.scad>
use <../lego.scad>

/* [LEGO Calibration Block Options, for convenience "tight" knobs are matched with equally "loose" sockets, but your best fit may not be identical. Test against real LEGO first, then 3D printed to 3D printed using a calibration block with your selected paramters] */

// Generator mode: ususally start with the calibration bar, then use others if needed
mode=1; // [1:Calibration bar, 2:Set of calibration blocks, 3:One calibration block]

// Length of each calibration block (LEGO unit count)
l = 2; 

// Width of each calibration block (LEGO unit count)
w = 2;

// Height of the block (LEGO unit count, use 1/3 for short calibration panel)
h = 2/3;

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0; // [0:disable, 1:enabled]

end_holes=0;

side_holes=0;

side_hole_sheaths=1;

top_vents = 0;

knobs = 1;

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
// LEGO Calibration Display
/////////////////////////////////////

if (mode==1) {
    lego_calibration_bar();
} else if (mode==2) {
    lego_calibration_set();
} else if (mode==3) {
    // A single calibration block
    lego_calibration_block();
} else {
    echo("<b>Unsupported: please check <i>mode</i> variable is 1-5</b>");
}


/////////////////////////////////////
// LEGO CALIBRATION BLOCK MODULES
//
// A single block or array of LEGO blocks with different parameters.
// Use these to find the ideal fit with real LEGO bricks
// for a given printer, settings and plastic combination. Pre-generated examples and numbers are as a guide only
// based on tests with a Lulzbot Taz 6 printer and give example results but may not be suitable for your setup.
/////////////////////////////////////


// A set of calibration blocks in a row with reduced inter-block spacing to print faster
module lego_calibration_bar(l=l, w=w, h=h, calibration_block_increment=calibration_block_increment, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_flexture_radius=knob_flexture_radius, bolt_holes=bolt_holes, block_height=block_height, side_lock_thickness=side_lock_thickness, knobs=knobs) {
    
    from=-4;
    to=3;
    
    // Tighter top, looser bottom
    difference() {
        union() {
            for (i = [from:to]) {
                cal = i*calibration_block_increment;
                
                translate([i*lego_width(l)-i*shell, 0, 0])
                    lego_calibration_block(l=l, w=w, h=h, top_tweak=cal, bottom_tweak=-cal, axle_hole_tweak=cal, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, ring_radius=ring_radius, knob_flexture_radius=knob_flexture_radius, skin=0, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_lock_thickness=side_lock_thickness, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);
            }
        }

        etch_all_calibration_bar_dividers(from=from, to=to, w=w);
    }
}


// A set of blocks with different tweak parameters written on the side
module lego_calibration_set(l=l, w=w, h=h,  calibration_block_increment=calibration_block_increment, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_flexture_radius=knob_flexture_radius, skin=skin, bolt_holes=bolt_holes, block_height=block_height, side_lock_thickness=side_lock_thickness, knobs=knobs) {
    
    // Tighter top, looser bottom
    for (i = [0:5]) {
        cal = i*calibration_block_increment;
        
        translate([i*lego_width(l+0.5), 0, 0])
            lego_calibration_block(l=l, w=w, h=h, top_tweak=cal, bottom_tweak=-cal, axle_hole_tweak=cal, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, ring_radius=ring_radius, knob_flexture_radius=knob_flexture_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_lock_thickness=side_lock_thickness, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);
    }
    
    // Tightest top, loosest bottom
    for (i = [6:10]) {
        cal = i*calibration_block_increment;
        
        translate([(i-5)*lego_width(l+0.5), -lego_width(w+0.5), 0])
            lego_calibration_block(l=l, w=w, h=h, top_tweak=cal, bottom_tweak=-cal, axle_hole_tweak=axle_hole_tweak, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, ring_radius=ring_radius, knob_flexture_radius=knob_flexture_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_lock_thickness=side_lock_thickness, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);
    }
    
    // Looser top, tighter bottom
    for (i = [1:5]) {
        cal = -i*calibration_block_increment;
        
        translate([i*lego_width(l+0.5), lego_width(w+0.5), 0])
            lego_calibration_block(l=l, w=w, h=h, top_tweak=cal, bottom_tweak=-cal, axle_hole_tweak=cal, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, ring_radius=ring_radius, knob_flexture_radius=knob_flexture_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_lock_thickness=side_lock_thickness, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);
    }
}


// A block with the top and bottom connector tweak parameters etched on the side
module lego_calibration_block(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, axle_hole_tweak=axle_hole_tweak, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, ring_radius=ring_radius, knob_flexture_radius=knob_flexture_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_lock_thickness=side_lock_thickness, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs) {
    
    difference() { 
        lego_technic(l=l, w=w, h=h, axle_hole_radius=axle_hole_radius+axle_hole_tweak, knob_radius=knob_radius+top_tweak, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, ring_radius=ring_radius+bottom_tweak, knob_flexture_radius=knob_flexture_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_lock_thickness=side_lock_thickness, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, block_height=block_height, knobs=knobs);

        union() {
            translate([skin+horizontal_text_margin, text_extrusion_height+skin-defeather, skin+lego_height(h)-vertical_text_margin])
                rotate([90,0,0]) 
                    lego_calibration_top_text(str(top_tweak));
            
            translate([skin+horizontal_text_margin, lego_width(w)-text_extrusion_height-skin+defeather, skin+vertical_text_margin])
                rotate([90, 0, 180])
                    lego_calibration_bottom_text(str(bottom_tweak));
        }
    }
}

// Text for the front side of calibration block prints
module lego_calibration_top_text(txt="Text") {
    
    linear_extrude(height=text_extrusion_height) {        
        if (is_true(knobs)) {    
            text(text=txt, font=font, size=font_size, halign="left", valign="top");
        }
    }
}

// Text for the back side of calibration block prints
module lego_calibration_bottom_text(txt="Text") {
    
    if (is_true(sockets)) {
        linear_extrude(height=text_extrusion_height) {
            text(text=txt, font=font, size=font_size, halign="right");
        }
    }
}

// Mark lines between each clibration bar section
module etch_all_calibration_bar_dividers(from=1, to=4) {
    for (i = [from:1:to]) {
        etch_calibration_bar_divider(i=i);
    }
}

// Mark a line between each calibration section of a calibration bar
module etch_calibration_bar_divider(i=l) {
    x = 0.5*shell + i*(lego_width(l)-shell) - ridge_width/2;

    // Front
    translate([x, 0, 0])
        cube([ridge_width, ridge_depth, lego_height()]);

    // Back
    translate([x, lego_width(w)-ridge_depth, 0])
        cube([ridge_width, ridge_depth, lego_height()]);

    // Top
    translate([x, 0, lego_height()-ridge_depth])
        cube([ridge_width, lego_width(w), ridge_depth]);

    // Bottom
    translate([x, 0, 0])
        cube([ridge_width, lego_width(w), ridge_depth]);
    
    // Block Separator
    inset=lego_width(0.5)-knob_radius;
    translate([x, inset, 0])
        cube([ridge_width, lego_width(w)-2*inset, lego_height()]);    
}

