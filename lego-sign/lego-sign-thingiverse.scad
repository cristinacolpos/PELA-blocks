/*
Parametric LEGO End Cap Enclosure Generator

Create 2 symmetric end pieces which can support a solid object with LEGO-compatible attachment points on top and bottom. By printing only the end pieces instead of a complele enclosure, the print is minimized

Published at
    https://www.thingiverse.com/thing:2546028
Based on
    https://www.thingiverse.com/thing:2303714
Maintained at
    https://github.com/paulirotta/parametric_lego

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com

Import this into other design files:
    use <lego-sign.scad>
*/

/* [LEGO Sign Options] */

// The top line of text. Set to "" to not have any top line
line_1 = "LEGO Robotics";

// The second line of text
line_2 = "Rapid Prototyping";

// (1=>true, 0=>false) "true" means text is pushing outward from the LEGO block. Set "false" to etch text into the block
extrude = 0;

// Place the text on both sides (1=>true, 0=>false)
copy_to_back = 0;

// Language of the text
lang = "en";

// The font to use for text on the top line
f1 = "Liberation Sans:style=Bold Italic";

// The font to use for text on the bottom line
f2 = "Arial";

// The font size (points) of the top line
fs1 = 5.8;

// The font size (points) of the bottom line
fs2 = 5;

// How deeply into the LEGO block to etch/extrude the text
extrusion_height = 0.5;

// Left text margin (mm)
left_margin = 3;

// Top and bottom text margin (mm)
vertical_margin = 3;

// What type of object to generate: 1=>block, 2=>panel (thin, knobs only), 3=>calibration
mode=1;

// Length of the sign (LEGO knob count)
l = 8; 

// Width of the sign (LEGO knob count)
w = 1;

// Height of the sign (LEGO brick layers)
h = 2;

// Top connector size tweak => + = more tight fit, -0.04 for PLA, 0 for ABS, 0.07 for NGEN
top_tweak = 0;

// Bottom connector size tweak => + = more tight fit, 0.04 for PLA, 0 for ABS, -0.01 NGEN
bottom_tweak = 0;

// Number of facets to form a circle (big numbers are more round which affects fit, but may take a long time to render)
fn=64;

// Clearance space on the outer surface of bricks
skin = 0.1; 

// Size of the connectors
knob_radius=2.4;

// Height of the connectors including any bevel (1.8 is Lego standard, longer gives a stronger hold which helps since 3D prints are less precise)
knob_height=2.4;

// Height of the easy connect slope near connector top (0 to disable is standard a slightly faster to generate the model, a bigger value such as 0.3 may help if you adjust a tight fit but most printers' slicers will simplify away most usable bevels)
knob_bevel=0;

// Size of the small cavity inside the connectors
knob_cutout_radius=1.25;

// Distance below knob top surface and the internal cutout
knob_top_thickness=1.2;

// Height of the hole beneath each knob
knob_cutout_height=4.55;

// Size of the top hole in each knob to keep the cutout as part of the outside surface for slicer-friendliness. Use a larger number if you need to drain resin from the cutout. If h height of the block is 1, no airhole is added to the model since the cutout is open from below.
knob_cutout_airhole_radius=0.01;

// Number of side to simulate a circle in the air hole and (smaller numbers render faster and are usually sufficient)
airhole_fn=16;

// Depth which connectors may press into part bottom
socket_height=6.4;

// Bottom connector assistance ring size
ring_radius=3.25;

// Bottom connector assistance ring thickness
ring_thickness=0.8;

// Width of horizontal surface strengthening slats (usually between the bottom rings)
stiffener_width=0.8;

// Height of horizontal surface strengthening slats (usually between the bottom rings)
stiffener_height=2.4;

// Basic unit horizonal size of LEGO
block_width=8;

// Basic unit vertial size of LEGO
block_height=9.6;

// Thickness of the solid outside surface of LEGO
block_shell=1.3; // thickness

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0;


/////////////////////////////////////
// Sign Display

lego_sign();

///////////////////////////////////

// A LEGO brick with text on the side
module lego_sign(line_1=line_1, line_2=line_2, lang=lang, extrude=extrude,  extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, bolt_holes=bolt_holes, fn=fn, airhole_fn=airhole_fn) {
    if (is_true(extrude)) {
        lego(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, bolt_holes=bolt_holes, fn=fn, airhole_fn=airhole_fn);
        translate([lego_skin_width(), lego_skin_width(), lego_skin_width()])
            lego_sign_extruded_text(line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, fn=fn);

        if (is_true(copy_to_back)) {
            translate([lego_skin_width()+lego_width(l), lego_width(w), lego_skin_width()])
                rotate([0, 0, 180])
                    lego_sign_extruded_text(line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, fn=fn);
        }
    } else {
        difference() {
            lego(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, bolt_holes=bolt_holes, fn=fn, airhole_fn=airhole_fn);
            union() {
                translate([lego_skin_width(), 0, lego_skin_width()])
                    lego_sign_etched_text(line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height+lego_skin_width(), f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, fn=fn);

                if (is_true(copy_to_back)) {
                    translate([lego_skin_width()+lego_width(l), lego_skin_width()+lego_width(w), lego_skin_width()])
                        rotate([0, 0, 180])
                            lego_sign_etched_text(line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height+lego_skin_width(), f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, fn=fn);
                }
            }
        }
    }
}


// Two lines of text extruded out from the surface
module lego_sign_extruded_text(line_1=line_1, line_2=line_2, lang=lang, extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, fn=fn) {
    translate([left_margin, 0, lego_height(h)-vertical_margin])
        lego_text(text=line_1, lang=lang, font=f1, font_size=fs1, vertical_alignment="top");
    translate([left_margin, 0, vertical_margin])
        lego_text(text=line_2, lang=lang, font=f2, font_size=fs2, vertical_alignment="bottom");
}


// Two lines of text etched into the surface
module lego_sign_etched_text(line_1=line_1, line_2=line_2, lang=lang,  extrusion_height=extrusion_height, f1=f1, f2=f2, fs1=fs1, fs2=fs2, left_margin=left_margin, vertical_margin=vertical_margin, l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, fn=fn) {
    translate([left_margin, extrusion_height, lego_height(h)-vertical_margin])
        lego_text(text=line_1, lang=lang, extrusion_height=extrusion_height, font=f1, font_size=fs1, vertical_alignment="top");
    translate([left_margin, extrusion_height, vertical_margin])
        lego_text(text=line_2, lang=lang, extrusion_height=extrusion_height, font=f2, font_size=fs2, vertical_alignment="baseline");
}


// Text for the side of calibration block prints
module lego_text(text=line_1, lang=lang, extrusion_height=extrusion_height, font=f1, font_size=fs1, vertical_alignment="bottom") {
    rotate([90,0,0])
        linear_extrude(height=extrusion_height)
            text(text=text, language=lang, font=font, size=font_size, halign="left", valign=vertical_alignment);
}



/////////////////////////////////////
// FUNCTIONS
/////////////////////////////////////

// Function for access to horizontal size from other modules
function lego_width(i=1, block_width=block_width) = i*block_width;

// Function for access to vertical size from other modules
function lego_height(h=1, block_height=block_height) = h*block_height;

// Function for access to outside shell size from other modules
function lego_shell_width() = block_shell;

// Function for access to clearance space from other modules
function lego_skin_width(i=1, skin=skin) = i*skin;

// Function for access to socket height from other modules
function lego_socket_height() = socket_height;

// Function to convert online Customizer-and-command-line-friendly integers into booleans
function is_true(t) = t != 0;

/////////////////////////////////////
// MODULES
/////////////////////////////////////

// A complete LEGO block, standard size, specify number of layers in L W and H
module lego(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, bolt_holes=bolt_holes, fn=fn, airhole_fn=airhole_fn) {
    
    difference() {
        union() {
            block_shell(l=l, w=w, h=h, fn=fn);
            difference() {
                block_set(l=l, w=w, h=h, top_tweak=top_tweak, fn=fn);
                socket_set(l=l, w=w, bottom_tweak=bottom_tweak, fn=fn);
            }
        }
        union() {
            skin(l=l, w=w, h=h, skin=skin);
            knob_cutout_set(l=l, w=w, h=h, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, fn=fn, airhole_fn=airhole_fn);
            if (is_true(bolt_holes)) {
                corner_bolt_holes(l=l, w=w, h=h, top_tweak=top_tweak, fn=fn);
            }
        }
    }
}


// Several blocks in a grid, one knob per block
module block_set(l=l, w=w, h=h, top_tweak=top_tweak, fn=fn) {
    for (i = [0:1:l-1]) {
        for (j = [0:1:w-1]) {
            translate([lego_width(i), lego_width(j), 0])
                block(h=h, top_tweak=top_tweak, knob_height=knob_height, fn=fn);
        }
    }
}


// The rectangular part of the the lego plus the knob
module block(h=h, top_tweak=top_tweak, knob_height=knob_height, fn=fn) {
    cube([lego_width(), lego_width(), lego_height(h)]);
    translate([lego_width(0.5), lego_width(0.5), lego_height(h)])
        knob(top_tweak=top_tweak, knob_bevel=knob_bevel, fn=fn);
}


// The cylinder on top of a lego block
module knob(top_tweak=top_tweak, knob_bevel=knob_bevel, fn=fn) {
    cylinder(r=knob_radius+top_tweak, h=knob_height-knob_bevel, $fn=fn);
    if (knob_bevel > 0) {
        // This path is a bit slower, but does the same thing as the bath below for the most common case of knob_bevel==0
        translate([0, 0, knob_height-knob_bevel])
            intersection() {
                cylinder(r=knob_radius+top_tweak,h=knob_bevel, $fn=fn);
                cylinder(r1=knob_radius+top_tweak,r2=0,h=knob_radius+top_tweak, $fn=fn);
            }
    }
}

// An array of empty cylinders to fit inside a knob_set()
module knob_cutout_set(l=l, w=w, h=h, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, fn=fn, airhole_fn=airhole_fn) {

    airhole = h>1;
    for (i = [0:1:l-1]) {
        for (j = [0:1:w-1]) {
            translate([lego_width(i+0.5), lego_width(j+0.5), lego_height(h)])
                knob_cutout(airhole, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, fn=fn, airhole_fn=airhole_fn);
        }
    }
}


// The empty cylinder inside a knob
module knob_cutout(airhole=false, knob_height=knob_height, knob_cutout_height=knob_cutout_height, knob_cutout_radius=knob_cutout_radius, knob_cutout_airhole_radius=knob_cutout_airhole_radius, fn=fn, airhole_fn=airhole_fn) {

    translate([0, 0, knob_height-knob_top_thickness-knob_cutout_height])
        cylinder(r=knob_cutout_radius, h=knob_cutout_height, $fn=airhole_fn);
    if (airhole) {
        cylinder(r=knob_cutout_airhole_radius, h=knob_height+0.1, $fn=airhole_fn);
    }
}


// That solid outer skin of a block set
module block_shell(l=l, w=w, h=h) {
    cube([block_shell, lego_width(w), lego_height(h)]);
    translate([lego_width(l)-block_shell, 0, 0]) 
        cube([block_shell, lego_width(w), lego_height(h)]);
    
    cube([lego_width(l), block_shell, lego_height(h)]);
    translate([0, lego_width(w)-block_shell, 0])
        cube([lego_width(l), block_shell, lego_height(h)]);
    
    translate([0, 0, lego_height(h)-block_shell])
        cube([lego_width(l), lego_width(w), block_shell]);
}


// Bottom connector- negative space for multiple blocks
module socket_set(l=l, w=w, bottom_tweak=bottom_tweak, fn=fn) {
    difference() {
        cube([lego_width(l), lego_width(w), socket_height]);
        difference() {
            union() {
                bottom_stiffener_set(l=l, w=w);
                for (i = [0:1:l]) {
                    for (j = [0:1:w]) {
                        translate([lego_width(i), lego_width(j), 0])
                            socket_ring(bottom_tweak, fn);
                    }
                }
            }
            union() {
                for (i = [0:1:l]) {
                    for (j = [0:1:w]) {
                        translate([lego_width(i), lego_width(j), 0])
                            socket_ring_inner_cylinder(bottom_tweak=bottom_tweak, fn=fn);
                    }
                }
            }
        }
    }
}


// The circular bottom insert for attaching knobs
module socket_ring(bottom_tweak=bottom_tweak, fn=fn) {
    cylinder(r=ring_radius+bottom_tweak, h=socket_height, $fn=fn);
}


// The negative space inside the circular bottom insert for attaching knobs
module socket_ring_inner_cylinder(bottom_tweak=bottom_tweak, fn=fn) {
    cylinder(r=ring_radius+bottom_tweak-ring_thickness, h=socket_height, $fn=fn);
}


// Bars layed below (or above) a horizontal surface to make it stronger
module bottom_stiffener_set(l=l, w=w) {
    translate([0, 0, socket_height-stiffener_height])
        stiffener_set(l=l, w=w);
}


// Bars layed below (or above) a horizontal surface to make it stronger. Usually these are on the bottom, between the connecting rings
module stiffener_set(l=l, w=w) {
    for (i = [0:1:l-1]) {
        translate([lego_width(i)-stiffener_width/2, 0, 0])
            cube([stiffener_width, lego_width(w), stiffener_height]);
    }
    for (j = [0:1:w-1]) {
        translate([0, lego_width(j)-stiffener_width/2, 0])
            cube([lego_width(l), stiffener_width, stiffener_height]);
    }    
}


// The thin negative space surrounding a LEGO block so that two blocks can fit next to each other easily in a tight grid
module skin(l=l, w=w, h=h, skin=skin) {
    difference() {
        cube([lego_width(l), lego_width(w), lego_height(h)]);
        translate([lego_skin_width(), lego_skin_width(), 0])
            cube([lego_width(l)-lego_skin_width(i=2, skin=skin), lego_width(w)-lego_skin_width(i=2, skin=skin), lego_height(h)]);
    }
}


// Mounting holes
module corner_bolt_holes(l=l, w=w, h=h, top_tweak=top_tweak, fn=fn) {
    bolt_hole(l=1, w=1, h=h, top_tweak=top_tweak, fn=fn);
    bolt_hole(l=1, w=w, h=h, top_tweak=top_tweak, fn=fn);
    bolt_hole(l=l, w=1, h=h, top_tweak=top_tweak, fn=fn);
    bolt_hole(l=l, w=w, h=h, top_tweak=top_tweak, fn=fn);
}


/////////////////////////////////////
// LEGO CALIBRATION BLOCKS
//
// An array of LEGO blocks with different tweak parameters. Use these to find the ideal fit with real LEGO bricks
// for a given printer, settings and plastic combination. Pre-generated examples and numbers are as a guide only
// based on tests with a Lulzbot Taz 6 printer and give example results but may not be suitable for your setup.
/////////////////////////////////////

// A set of blocks with different tweak parameters written on the side
module lego_calibration_set(l=l, w=w, skin=skin, fn=fn) {
    for (i = [0:5]) {
        translate([i*lego_width(l+0.5), 0, 0])
            lego_calibration_block(l=l, w=w, top_tweak=i*calibration_block_increment, bottom_tweak=-i*calibration_block_increment, skin=skin, fn=fn);
    }
    
    for (i = [6:10]) {
        translate([(i-5)*lego_width(l+0.5), -lego_width(w+0.5), 0])
            lego_calibration_block(l=l, w=w, top_tweak=i*calibration_block_increment, bottom_tweak=-i*calibration_block_increment, skin=skin, fn=fn);
    }
    
    for (i = [1:5]) {
        translate([i*lego_width(l+0.5), lego_width(w+0.5), 0])
            lego_calibration_block(l=l, w=w, top_tweak=-i*calibration_block_increment, bottom_tweak=i*calibration_block_increment, skin=skin, fn=fn);
    }
}

// A block with the tweak parameters written on the side
module lego_calibration_block(l=l, w=w, top_tweak=top_tweak, bottom_tweak=bottom_tweak, skin=skin, fn=fn) {
    difference() {
        lego(l=l, w=w, h=1, top_tweak=top_tweak, bottom_tweak=bottom_tweak, fn=fn);

        union() {
            translate([text_extrusion_height, lego_skin_width()+lego_width(w)-text_margin, lego_skin_width()+lego_height()-text_margin])
                rotate([90,0,-90]) 
                    lego_calibration_top_text(str("^", top_tweak));
            
            translate([lego_skin_width()+text_margin, lego_width(w)-text_extrusion_height, lego_skin_width()+text_margin])
                rotate([90, 0, 180])
                    lego_calibration_bottom_text(str(bottom_tweak, "v"));
        }
    }
}

// Text for the left side of calibration block prints
module lego_calibration_top_text(txt="Text") {
    linear_extrude(height=text_extrusion_height) {
    text(text=txt, font=font, size=font_size, halign="left", valign="top");
     }
}

// Text for the back side of calibration block prints
module lego_calibration_bottom_text(txt="Text") {
    linear_extrude(height=text_extrusion_height) {
       text(text=txt, font=font, size=font_size, halign="right");
     }
}


/////////////////////////////////////
// LEGO PANEL
//
// LEGO knobs on a thin, flat-back panel with holes for mounting screws
// in the corners
/////////////////////////////////////

module lego_panel(l=l, w=w, top_tweak=top_tweak, panel_thickness=panel_thickness, bolt_holes=bolt_holes, skin=skin, fn=fn) {
    cut_line=lego_height()-panel_thickness;
    if (is_true(bolt_holes)) {
        difference() {
            lego_panel_no_holes(l=l, w=w, top_tweak=top_tweak, cut_line=cut_line, skin=skin, fn=fn);
            translate([0, 0, cut_line-0.1])
                corner_bolt_holes(l=l, w=w, top_tweak=top_tweak, fn=fn);
        }
    } else {
        lego_panel_no_holes(l=l, w=w, top_tweak=top_tweak, cut_line=cut_line, fn=fn);    
    }
}

module lego_panel_no_holes(l=l, w=w, top_tweak=top_tweak, cut_line=cut_line, skin=skin, fn=fn) {
    intersection() {
        lego(l=l, w=w, h=1, top_tweak=top_tweak, bottom_tweak=bottom_tweak, skin=skin, fn=fn);
        translate([0, 0, cut_line])
            cube([lego_width(l), lego_width(w), 2*lego_height()]);
    }    
}

// A hole for a mounting bolt in the corners of a panel or block
module bolt_hole(l=l, w=w, h=h, top_tweak=top_tweak, fn=fn) {
    translate([lego_width(l-0.5), lego_width(w-0.5), 0])
        cylinder(r=knob_radius+top_tweak+0.001, h=lego_height(h+1), $fn=fn);
}

