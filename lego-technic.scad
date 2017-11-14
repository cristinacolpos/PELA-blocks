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
    lego_technic(knob_height=0, knob_bevel=0, knob_flexture_radius=0, knob_flexture_airhole_radius=0);
} else if (mode==3) {
    // Block without bottom sockets
    lego_technic(socket_height=0);
} else if (mode==4) {
    // Block without top knobs or bottom sockets
    lego_technic(socket_height=0, knob_height=0, knob_bevel=0, knob_flexture_radius=0, knob_flexture_airhole_radius=0);
} else {
    echo("<b>Unsupported: please check <i>mode</i> variable is 1-4</b>");
}

/////////////////////////////////////
// MODULES
/////////////////////////////////////

// A LEGO block with optional side and top vent holes
module lego_technic(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio, ring_radius=ring_radius, socket_height=socket_height, knob_flexture_airhole_radius=knob_flexture_airhole_radius, skin=skin, shell=shell, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_stiffener_thickness=side_stiffener_thickness, bolt_holes=bolt_holes, ridge_width=ridge_width, ridge_depth=ridge_depth) {

    difference() {
        union() {
            lego(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio, ring_radius=ring_radius, socket_height=socket_height, knob_flexture_airhole_radius=knob_flexture_airhole_radius, skin=skin, shell=shell, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_stiffener_thickness=side_stiffener_thickness, bolt_holes=bolt_holes, ridge_width=ridge_width, ridge_depth=ridge_depth);
            
            if (is_true(side_hole_sheaths) && is_true(side_holes)) {
                side_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, peg_length=peg_length, block_width=block_width);
            }
            
            if (is_true(end_hole_sheaths) && is_true(end_holes)) {
                end_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, peg_length=peg_length, block_width=block_width);
            }
        }
        
        union() {
            if (is_true(side_holes) || is_true(end_holes)) {
                length = is_true(top_vents) ? lego_height(h) : lego_height(h)-lego_width(0.5);
                socket_hole_set(l=l, w=w, radius=axle_hole_radius+axle_hole_tweak, length=length);
            }
            
            if (is_true(side_holes)) {
                side_connector_hole_set(l=l, w=w, side_holes=side_holes, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, block_width=block_width);
            }
            
            if (is_true(end_holes)) {
                end_connector_hole_set(l=l, w=w, top_tweak=top_tweak, knob_radius=knob_radius, block_width=block_width);
            }
            
            if (is_true(bolt_holes)) {
                corner_bolt_holes(l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius);
            }
            
            skin(l=l, w=w, h=h, skin=skin, ridge_width=ridge_width, ridge_depth=ridge_depth);
        }
    }
}


// A row of sheaths surrounding holes along the length
module side_connector_sheath_set(l=l, w=w, side_holes=side_holes, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width, sheath_length=lego_width(w)) {
    
    sheath_radius=bearing_sheath_thickness+axle_hole_radius+axle_hole_tweak;
    
    if (l==1) {
        translate([lego_width(0.5), 0, lego_height(1)-lego_width(0.5)])
            rotate([-90, 0, 0])
                technic_bearing_sheath(sheath_radius=sheath_radius, sheath_length=sheath_length);        

        translate([lego_width(0.5), lego_width(1), lego_height(1)-lego_width(0.5)])
            rotate([90, 0, 0])
                technic_bearing_sheath(sheath_radius=sheath_radius, sheath_length=sheath_length);
        
        if (side_holes==4) {
            rotate([-90, 0, 0])
                technic_bearing_sheath(sheath_radius=sheath_radius, sheath_length=lego_width(w));            
        }
    } else {
        for (i = [1:l-1]) {
            translate([lego_width(i), 0, lego_height(1)-lego_width(0.5)])
                rotate([-90, 0, 0])
                    technic_bearing_sheath(sheath_radius=sheath_radius, sheath_length=sheath_length);

            translate([lego_width(i), lego_width(w), lego_height(1)-lego_width(0.5)])
                rotate([90, 0, 0])
                    technic_bearing_sheath(sheath_radius=sheath_radius, sheath_length=sheath_length);

            if (side_holes==4) {
                translate([lego_width(i), 0, lego_height(1)-lego_width(0.5)])
                    rotate([-90, 0, 0])
                        technic_bearing_sheath(sheath_radius=sheath_radius, sheath_length=lego_width(w));
            }
        }
    }
}


// A row of sheaths surrounding holes along the width
module end_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width, sheath_length=lego_width(0.5)) {
    
    sheath_radius=bearing_sheath_thickness+axle_hole_radius+axle_hole_tweak;
    
    if (l==1) {
        translate([0, lego_width(0.5), lego_height(1)-lego_width(0.5)])
            rotate([-90, 0, 0])
                technic_bearing_sheath(sheath_radius=sheath_radius, sheath_length=peg_length);
        
        translate([lego_width(l), lego_width(0.5), lego_height(1)-lego_width(0.5)])
            rotate([90, 0, 0])
                technic_bearing_sheath(sheath_radius=sheath_radius, sheath_length=sheath_length);
    } else {
        for (j = [1:w-1]) {
            translate([0, lego_width(j), lego_height(1)-lego_width(0.5)])
                rotate([0, 90, 0])
                    technic_bearing_sheath(sheath_radius=sheath_radius, sheath_length=sheath_length);

            translate([lego_width(l), lego_width(j), lego_height(1)-lego_width(0.5)])
                rotate([0, -90, 0])
                    technic_bearing_sheath(sheath_radius=sheath_radius, sheath_length=sheath_length);
        }
    }
}


// The solid shell around a bearing hole
module technic_bearing_sheath(sheath_radius=bearing_sheath_thickness+axle_hole_radius+axle_hole_tweak, sheath_length=lego_width(0.5)) {
    
    cylinder(r=sheath_radius, h=sheath_length);
}


// A row of knob-size holes around the sides of row 1
module side_connector_hole_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, block_width=block_width) {
    
    if (l==1) {
        translate([lego_width(0.5), 0, lego_height(1)-lego_width(0.5)])
            rotate([-90, 0, 0])
                axle_hole(hole_type=side_holes, length=lego_width(w), axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak);
        
    } else {
        for (i = [1:l-1]) {
            translate([lego_width(i), 0, lego_height(1)-lego_width(0.5)])
                rotate([-90, 0, 0])
                    axle_hole(hole_type=side_holes, length=lego_width(w),  axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak);
        }
    }
}


// A row of knob-size holes around the sides of row 1
module end_connector_hole_set(l=l, w=w, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak, block_width=block_width) {
    
    hole_depth= end_holes==1 ? shell : lego_width(1);
    
    if (w==1) {
        if (l>1) {
            translate([0, lego_width(0.5), lego_height(1)-lego_width(0.5)])
                rotate([0, 90, 0])
                    axle_hole(hole_type=end_holes, length=hole_depth, axle_hole_tweak=axle_hole_tweak, axle_hole_radius=axle_hole_radius);
        }
    } else {
        for (i = [1:w-1]) {
            translate([0, lego_width(i), lego_height(1)-lego_width(0.5)]) {
                rotate([0, 90, 0])
                    axle_hole(hole_type=end_holes, length=hole_depth, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak);
                
                translate([lego_width(l), 0, 0])
                    rotate([0, -90, 0])
                        axle_hole(hole_type=end_holes, length=hole_depth, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak);
            }
        }
    }
}


// The rotation and connector hole for a Technic connector
module axle_hole(hole_type=side_holes, length=block_width, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak) {
    
    rotation_hole(length=length, axle_hole_radius=axle_hole_radius, axle_hole_tweak=axle_hole_tweak);

    if (hole_type>1) {
        counterbore_inset(counterbore_inset_depth=counterbore_inset_depth, counterbore_inset_radius=counterbore_inset_radius, axle_hole_tweak=axle_hole_tweak);
        
        translate([0, 0, length-counterbore_inset_depth])
            counterbore_inset(counterbore_inset_depth=counterbore_inset_depth, counterbore_inset_radius=counterbore_inset_radius, axle_hole_tweak=axle_hole_tweak);
    
        if (hole_type>2) {
            depth=lego_width()-peg_length-counterbore_inset_depth;
            
            translate([0, 0, counterbore_inset_depth+peg_length])
                counterbore_inset(counterbore_inset_depth=depth, counterbore_inset_radius=counterbore_inset_radius-bearing_sheath_thickness/2, axle_hole_tweak=axle_hole_tweak);

            translate([0, 0, length-counterbore_inset_depth-peg_length])
                rotate([180, 0, 0])
                    counterbore_inset(counterbore_inset_depth=depth, counterbore_inset_radius=counterbore_inset_radius-bearing_sheath_thickness/2, axle_hole_tweak=axle_hole_tweak);
        }
    }
}


// The connector inset for a Technic side connector
module counterbore_inset(counterbore_inset_depth=counterbore_inset_depth, counterbore_inset_radius=counterbore_inset_radius, axle_hole_tweak=axle_hole_tweak) {
    
    cylinder(r=counterbore_inset_radius+axle_hole_tweak, h=counterbore_inset_depth);
}

