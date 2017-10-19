/*
Parametric LEGO Block

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

Import this into other design files:
    use <lego.scad>
*/

include <../lego_parameters.scad>
use <../lego.scad>

/* [LEGO Panel Options] */

// LEGO panel thickness (flat back panel with screw holes in corners)
panel_thickness=3.2;


/////////////////////////////////////
// LEGO panel display
/////////////////////////////////////

// A thin panel of knobs with a flat back and mounting screw holes in the corners, suitable for organizing projects
lego_knob_panel(); 

/////////////////////////////////////
// LEGO PANEL modules
/////////////////////////////////////

//
module lego_knob_panel(l=l, w=w, top_tweak=top_tweak, panel_thickness=panel_thickness, bolt_holes=bolt_holes, skin=skin, fn=fn) {
    
    cut_line=lego_height()-panel_thickness;
    if (is_true(bolt_holes)) {
        difference() {
            lego_knob_panel_no_holes(l=l, w=w, top_tweak=top_tweak, cut_line=cut_line, skin=skin, fn=fn);
            translate([0, 0, cut_line-0.1])
                corner_bolt_holes(l=l, w=w, top_tweak=top_tweak, fn=fn);
        }
    } else {
        lego_knob_panel_no_holes(l=l, w=w, top_tweak=top_tweak, cut_line=cut_line, fn=fn);    
    }
}

module lego_knob_panel_no_holes(l=l, w=w, top_tweak=top_tweak, cut_line=cut_line, skin=skin, fn=fn) {
    intersection() {
        lego(l=l, w=w, h=1, top_tweak=top_tweak, bottom_tweak=bottom_tweak, skin=skin, fn=fn);
        translate([0, 0, cut_line])
            cube([lego_width(l), lego_width(w), 2*lego_height()]);
    }    
}
