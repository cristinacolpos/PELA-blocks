/*
PELA Blocks 3D Print Calibration Beam

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

include <style.scad>
include <material.scad>
use <PELA-technic-block.scad>
use <PELA-block.scad>



/* [Render] */

// Printing material. Set to label your calibration blocks and indicate if the material is flexible. Print to measure the best fit for knobs, sockets and axle holes and put those measures in "material.scad"
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Does that material have a Shore A durometer less than 90? (TPU etc need some flexure geometry modifications for a better knob and socket fit)
flexible_material = false;



/* [Calibration] */

// Generate a calibration beam (vs a set of individual calibration blocks)
calibration_beam = true;

// Number of blocks in the calibration beam
beam_length = 9; // [1:1:20]

// Length of each calibration block [blocks]
l = 2; // [1:1:20]

// Width of each calibration block [blocks]
w = 2; // [1:1:20]

// Height of the block (PELA unit count, use 1/3 for short calibration panel)
h = 1; // [1:1:20]

// Height of traditional connectors [mm] (taller gives a stronger hold)
knob_height = 2.9; // [1.8:traditional blocks, 2.9:PELA 3D print tall]

// Size of a hole in the top of each knob. Set 0 to disable for best flexture or enable for air circulation/aesthetics/drain resin
knob_vent_radius = 0.0; // [0.0:0.1:4]

// Basic unit vertical size of each block
block_height = 9.6; // [8:technic, 9.6:traditional blocks]

// Middle value of the calibration increment range
calibration_center = 0.0;

// Size between calibration block test steps (0.04 if you need a wider size range, 0.02 for finer adjustment close to nomanal values)
calibration_increment = 0.04;



/* [Hidden] */

// Depth of text labels on calibration blocks
text_extrusion_height = 0.4;

// Inset from block edge for text (vertical and horizontal)
vertical_text_margin = 3.8;

// Inset from block edge for text (vertical and horizontal)
horizontal_text_margin = 1;

side_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Font for calibration block text labels
font = "Arial";

// Text size on calibration blocks
font_size = 4.8 - (block_height < 9.6 ? 1.5 : 0);

// Text size on calibration blocks
font_size2 = 3.8 - (block_height < 9.6 ? 0.5 : 0);


///////////////////////////////
// DISPLAY
///////////////////////////////

if (calibration_beam) {
    PELA_calibration_beam(material=material, large_nozzle=large_nozzle, beam_length=beam_length, l=l, w=w, h=h, calibration_increment=calibration_increment, knob_height=knob_height, block_height=block_height);
} else {
    PELA_calibration_set(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, side_holes=end_holes, calibration_increment=calibration_increment, knob_height=knob_height, block_height=block_height);
}


///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_calibration_beam(material=undef, large_nozzle=undef, beam_length=undef, l=undef, w=undef, h=undef, calibration_increment=undef, knob_height=undef, block_height=undef) {

    assert(beam_length > 1, "Beam length must be at least 2");

    from = -floor((beam_length - 1)/2);
    to = ceil((beam_length - 1)/2);
    
    // Tighter top, looser bottom
    for (i = [from:to]) {
        cal = i*calibration_increment;
        
        translate([i*(block_width(l)-side_shell(large_nozzle)), 2*i, 0]) {

            PELA_calibration_block(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, top_tweak=cal, bottom_tweak=cal, axle_hole_tweak=cal, knob_height=knob_height, side_holes=side_holes, block_height=block_height);
        }
    }
}


// A block with the top and bottom connector tweak parameters etched on the side
module PELA_calibration_block(material=undef, large_nozzle=undef, l=undef, w=undef, h=undef, top_tweak=undef, bottom_tweak=undef, axle_hole_tweak=undef, knob_height=knob_height, side_holes=undef, block_height=undef) {
    
    difference() { 
        PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, h=h, sockets=true, knobs=true, knob_height=knob_height, knob_vent_radius=knob_vent_radius, corner_bolt_holes=false, side_holes=side_holes, side_sheaths=true, end_holes=0, end_sheaths=false, top_vents=false, block_height=block_height, bottom_tweak=bottom_tweak, top_tweak=top_tweak, axle_hole_tweak=axle_hole_tweak);

        union() {
            translate([_skin+horizontal_text_margin, _skin+text_extrusion_height, _skin+block_height(h, block_height)-vertical_text_margin]) {

                rotate([90 ,0, 0]) {
                    translate([0, -0.5, 0]) {
                        calibration_text(txt=material_name(material), halign="left", 
                        valign="bottom", font_size=font_size2);
                    }

                    translate([0, -0.8, 0]) {
                        calibration_text(txt=str(top_tweak), halign="left", valign="top", font_size=font_size);
                    }
                }
            }
            
            translate([block_width(w)-_skin-horizontal_text_margin, block_width(w)-text_extrusion_height-_skin, _skin+vertical_text_margin]) {
                
                rotate([90, 0, 180]) {
                    translate([0, 0.5, 0]) {
                        calibration_text(txt=str(bottom_tweak), halign="left", valign="bottom", font_size=font_size);
                    }

                    translate([0, 0, 0]) {
                        calibration_text(txt=material_name(material), halign="left", valign="top", font_size=font_size2);
                    }
                }
            }
        }
    }
}


// Text for the front side of calibration block prints
module calibration_text(txt="Text", halign="left", valign="top", font_size=font_size) {
    
    linear_extrude(height=text_extrusion_height*2) {        
        text(text=txt, font=font, size=font_size, halign=halign, valign=valign);
    }
}


module PELA_calibration_set(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, side_holes=side_holes, calibration_increment=calibration_increment, knob_height=knob_height, block_height=block_height) {
    
    // Tighter top, looser bottom
    for (i = [0:5]) {
        cal = i*calibration_increment;
        
        translate([i*block_width(l+0.5), 0, 0]) {
            PELA_calibration_block(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, top_tweak=cal, bottom_tweak=cal, axle_hole_tweak=cal, knob_height=knob_height, side_holes=side_holes, block_height=block_height);
        }
    }
    
    // Tightest top, loosest bottom
    for (i = [6:10]) {
        cal = i*calibration_increment;
        
        translate([(i-5)*block_width(l+0.5), -block_width(w+0.5), 0]) {

            PELA_calibration_block(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, top_tweak=cal, bottom_tweak=cal, axle_hole_tweak=cal, knob_height=knob_height, side_holes=side_holes, block_height=block_height);
        }
    }
    
    // Looser top, tighter bottom
    for (i = [1:5]) {
        cal = -i*calibration_increment;
        
        translate([i*block_width(l+0.5), block_width(w+0.5), 0]) {
            PELA_calibration_block(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, top_tweak=cal, bottom_tweak=cal, axle_hole_tweak=cal, knob_height=knob_height, side_holes=side_holes, block_height=block_height);
        }
    }
}
