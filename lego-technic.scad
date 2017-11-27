/*
Parametric LEGO Block with Technic-style holes in the sides

Published at
    http://www.thingiverse.com/thing:
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
    include <lego-parameters.scad>
    use <technic.scad>
    
All modules have sensible defaults derived from <lego_parameters.scad>. 
You can ignore values you are not tampering with and only need to pass a
parameter if you are overriding.

All modules are setup for stateless functional-style reuse in other OpenSCAD files.
To this end, you can always pass in and override all parameters to create
a new effect. Doing this is not natural to OpenSCAD, so apologies for all
the boilerplate arguments which are passed in to each module or any errors
that may be hidden by the sensible default values. This is an evolving art.
*/

include <lego-parameters.scad>
use <lego.scad>

/////////////////////////////////////
// LEGO display
/////////////////////////////////////

if (mode==1) {
    // A single block
    lego_technic();
} else if (mode==2) {
    // Bock without top knobs
    lego_technic(knob_height=0, knob_bevel=0, knob_flexture_radius=0, knob_vent_radius=0);
} else if (mode==3) {
    // Block without bottom sockets
    lego_technic(sockets=0);
} else if (mode==4) {
    // Block without top knobs or bottom sockets
    lego_technic(sockets=0, knob_height=0, knob_bevel=0, knob_flexture_radius=0, knob_vent_radius=0);
} else {
    echo("<b>Unsupported: please check <i>mode</i> variable is 1-4</b>");
}


/////////////////////////////////////
// FUNCTIONS
/////////////////////////////////////

// Indicates a solid cylinder around side hole connectors
function is_side_sheaths(side_sheaths=side_sheaths, side_holes=side_holes) = is_true(side_sheaths) && is_true(side_holes);

// Indicates a solid cylinder around end hole connectors
function is_end_sheaths(end_sheaths=end_sheaths, end_holes=end_holes) = end_holes>1 && is_true(end_sheaths);


/////////////////////////////////////
// MODULES
/////////////////////////////////////

// A LEGO block with optional side and top vent holes
module lego_technic(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, axle_hole_tweak=axle_hole_tweak, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio, ring_radius=ring_radius, sockets=sockets, knobs=knobs, knob_vent_radius=knob_vent_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_lock_thickness=side_lock_thickness, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, solid_bottom_layer=solid_bottom_layer, inverted_print_rim=inverted_print_rim) {

    difference() {
        union() {
            lego(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, axle_hole_tweak=axle_hole_tweak, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio, ring_radius=ring_radius, sockets=sockets, knobs=knobs, knob_vent_radius=knob_vent_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_lock_thickness=side_lock_thickness, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, solid_bottom_layer=solid_bottom_layer, inverted_print_rim=inverted_print_rim);
            
            if (is_side_sheaths(side_sheaths=side_sheaths, side_holes=side_holes)) {
                double_side_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, peg_length=peg_length, block_width=block_width);
            }
            
            if (is_end_sheaths(end_sheaths=end_sheaths, end_holes=end_holes)) {
                double_end_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, peg_length=peg_length, block_width=block_width);
            }
        }
        
        union() {
            if (is_true(side_holes) || is_true(end_holes) || is_true(top_vents)) {
                length = is_true(top_vents) ? lego_height(h+1) : lego_height(h)-lego_width(0.5);
                
                socket_hole_set(l=l, w=w, radius=axle_hole_radius+axle_hole_tweak, length=length);
            }
            
            if (is_true(side_holes)) {
                double_side_connector_hole_set(l=l, w=w, side_holes=side_holes, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, block_width=block_width, hole_type=side_holes);
            }
            
            if (is_true(end_holes)) {
                double_end_connector_hole_set(l=l, w=w, top_tweak=top_tweak, knob_radius=knob_radius, block_width=block_width, hole_type=end_holes);
            }
            
            if (is_true(bolt_holes)) {
                corner_bolt_holes(l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius);
            }
            
            skin(l=l, w=w, h=h, skin=skin, ridge_width=ridge_width, ridge_depth=ridge_depth);
        }
    }
}


module double_side_connector_sheath_set(l=l, w=w, side_holes=side_holes, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width) {

    side_connector_sheath_set(l=l, w=w, side_holes=side_holes, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width);

    translate([lego_width(l), lego_width(w)])
        rotate([0, 0, 180])
            side_connector_sheath_set(l=l, w=w, side_holes=side_holes, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width);
}


// A row of sheaths surrounding holes along the length
module side_connector_sheath_set(l=l, w=w, side_holes=side_holes, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width) {
    
    sheath_radius=bearing_sheath_thickness+axle_hole_radius+axle_hole_tweak;
    sheath_length = side_holes==1 || side_holes==2 ? lego_width(w) : lego_width();
    
    if (l==1) {
        translate([lego_width(0.5), 0, lego_height(1)-lego_width(0.5)])
            rotate([-90, 0, 0])
                sheath(sheath_radius=sheath_radius, sheath_length=sheath_length);    } else {
        for (i = [1:l-1]) {
            translate([lego_width(i), 0, lego_height(1)-lego_width(0.5)])
                rotate([-90, 0, 0])
                    sheath(sheath_radius=sheath_radius, sheath_length=sheath_length);
        }
    }
}


module double_end_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width) {

    end_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width);

    translate([lego_width(l), lego_width(w)])
        rotate([0, 0, 180])
            end_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width);
}


// A row of sheaths surrounding holes along the width
module end_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width) {
    
    sheath_radius=bearing_sheath_thickness+axle_hole_radius+axle_hole_tweak;
    sheath_length=lego_width();
    
    if (l==1) {
        translate([0, lego_width(0.5), lego_height(1)-lego_width(0.5)])
            rotate([-90, 0, 0])
                sheath(sheath_radius=sheath_radius, sheath_length=peg_length);
    } else {
        for (j = [1:w-1]) {
            translate([0, lego_width(j), lego_height(1)-lego_width(0.5)])
                rotate([0, 90, 0])
                    sheath(sheath_radius=sheath_radius, sheath_length=sheath_length);
        }
    }
}


// The solid cylinder around a bearing hole
module sheath(sheath_radius=bearing_sheath_thickness+axle_hole_radius+axle_hole_tweak, sheath_length=lego_width(0.5)) {
    
    cylinder(r=sheath_radius, h=sheath_length);
}

module double_end_connector_hole_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, block_width=block_width, hole_type=end_holes) {
 
    translate([lego_width(l), 0, 0])
        rotate([0, 0, 90])
            double_side_connector_hole_set(l=w, w=l, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, block_width=block_width, hole_type=hole_type);
}

module double_side_connector_hole_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, block_width=block_width, hole_type=side_holes) {
    
    side_connector_hole_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, block_width=block_width, hole_type=hole_type);
    
    translate([lego_width(l), lego_width(w)])
        rotate([0, 0, 180])
            side_connector_hole_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, block_width=block_width, hole_type=hole_type);
}


// A row of knob-size holes around the sides of row 1
module side_connector_hole_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, block_width=block_width, hole_type=side_holes) {
    
    //TODO Short holes not properly supprted
    length = side_holes==3 ? lego_width() : lego_width(w);

    if (l==1) {
        translate([lego_width(0.5), 0, lego_height()-lego_width(0.5)])
            rotate([-90, 0, 0])
                axle_hole(hole_type=hole_type, length=length, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak);
        
    } else {
        for (i = [1:l-1]) {
            translate([lego_width(i), 0, lego_height()-lego_width(0.5)])
                rotate([-90, 0, 0])
                    axle_hole(hole_type=hole_type, length=length,  axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak);
        }
    }
}


//TODO Pass all variables in as arguments
// The rotation and connector hole for a Technic connector
module axle_hole(hole_type=side_holes, radius=axle_hole_radius+axle_hole_tweak, length=counterbore_inset_depth+peg_length) {
    
    rotation_hole(radius=radius, length=length);

    if (hole_type>1) {
        counterbore_inset(counterbore_inset_depth=counterbore_inset_depth, counterbore_inset_radius=counterbore_inset_radius, axle_hole_tweak=axle_hole_tweak);

        depth=2*(lego_width()-peg_length-counterbore_inset_depth);
        inset_radius=counterbore_inset_radius-bearing_sheath_thickness/2;
            
        translate([0, 0, counterbore_inset_depth+peg_length])
            counterbore_inset(counterbore_inset_depth=depth, counterbore_inset_radius=inset_radius, axle_hole_tweak=axle_hole_tweak);
    }
}


// The connector inset for a Technic side connector
module counterbore_inset(counterbore_inset_depth=counterbore_inset_depth, counterbore_inset_radius=counterbore_inset_radius, axle_hole_tweak=axle_hole_tweak) {
    
    tweak=0.01;
    translate([0, 0, -tweak])
        cylinder(r=counterbore_inset_radius+axle_hole_tweak, h=counterbore_inset_depth+tweak);
}

