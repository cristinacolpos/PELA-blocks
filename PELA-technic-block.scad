/*
PELA Parametric Block with LEGO-compatible technic connectors and air vents

PELA Parametric Blocks - 3D Printed LEGO-compatible parametric blocks

Published at http://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    http://futurice.com

Import this into other design files:
    include <PELA-parameters.scad>
    use <technic.scad>
    
All modules have sensible defaults derived from <PELA_parameters.scad>. 
You can ignore values you are not tampering with and only need to pass a
parameter if you are overriding.

All modules are setup for stateless functional-style reuse in other OpenSCAD files.
To this end, you can always pass in and override all parameters to create
a new effect. Doing this is not natural to OpenSCAD, so apologies for all
the boilerplate arguments which are passed in to each module or any errors
that may be hidden by the sensible default values. This is an evolving art.
*/

include <PELA-parameters.scad>
include <PELA-print-parameters.scad>
use <PELA-block.scad>

/* [PELA-compatible Options] */

/////////////////////////////////////
// PELA display
/////////////////////////////////////

PELA_technic_block();


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

// A PELA block with optional side and top vent holes
module PELA_technic_block(l=l, w=w, h=h, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, ring_thickness=ring_thickness, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, ring_radius=ring_radius, sockets=sockets, knobs=knobs, knob_vent_radius=knob_vent_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_lock_thickness=side_lock_thickness, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, solid_bottom_layer=solid_bottom_layer) {

    difference() {
        union() {
            PELA(l=l, w=w, h=h, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, ring_thickness=ring_thickness, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, ring_radius=ring_radius, sockets=sockets, knobs=knobs, knob_vent_radius=knob_vent_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_lock_thickness=side_lock_thickness, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, solid_bottom_layer=solid_bottom_layer);
            
            if (is_side_sheaths(side_sheaths=side_sheaths, side_holes=side_holes)) {
                double_side_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, peg_length=peg_length, block_width=block_width);
            }
            
            if (is_end_sheaths(end_sheaths=end_sheaths, end_holes=end_holes)) {
                double_end_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, peg_length=peg_length, block_width=block_width);
            }
        }
        
        union() {
            if (is_true(side_holes) || is_true(end_holes) || is_true(top_vents)) {
                length = is_true(top_vents) ? block_height(h+1) : block_height(h)-block_width(0.5);
                
                offset_from_bottom = large_nozzle ? knob_height : 0;
                translate([0, 0, offset_from_bottom]) {
                    socket_hole_set(l=l, w=w, radius=axle_hole_radius, length=length);
                }
                if (large_nozzle) {
                      socket_hole_set(l=l, w=w, radius=axle_hole_radius*2/3, length=length);
                }
            }
            
            if (is_true(side_holes)) {
                double_side_connector_hole_set(l=l, w=w, side_holes=side_holes, axle_hole_radius=axle_hole_radius, block_width=block_width, hole_type=side_holes);
            }
            
            if (is_true(end_holes)) {
                double_end_connector_hole_set(l=l, w=w, knob_radius=knob_radius, block_width=block_width, hole_type=end_holes);
            }
            
            if (is_true(bolt_holes)) {
                corner_bolt_holes(l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius);
            }
            
            skin(l=l, w=w, h=h, skin=skin, ridge_width=ridge_width, ridge_depth=ridge_depth);
        }
    }
}


module double_side_connector_sheath_set(l=l, w=w, side_holes=side_holes, axle_hole_radius=axle_hole_radius, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width) {

    side_connector_sheath_set(l=l, w=w, side_holes=side_holes, axle_hole_radius=axle_hole_radius, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width);

    translate([block_width(l), block_width(w)])
        rotate([0, 0, 180])
            side_connector_sheath_set(l=l, w=w, side_holes=side_holes, axle_hole_radius=axle_hole_radius, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width);
}


// A row of sheaths surrounding holes along the length
module side_connector_sheath_set(l=l, w=w, side_holes=side_holes, axle_hole_radius=axle_hole_radius, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width) {
    
    sheath_radius=bearing_sheath_thickness+axle_hole_radius;
    sheath_length = side_holes==1 || side_holes==2 ? block_width(w) : block_width();
    
    if (l==1) {
        translate([block_width(0.5), 0, block_height(1)-block_width(0.5)])
            rotate([-90, 0, 0])
                sheath(sheath_radius=sheath_radius, sheath_length=sheath_length);    } else {
        for (i = [1:l-1]) {
            translate([block_width(i), 0, block_height(1)-block_width(0.5)])
                rotate([-90, 0, 0])
                    sheath(sheath_radius=sheath_radius, sheath_length=sheath_length);
        }
    }
}

// Two rows of end connector enclosing cylinders
module double_end_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width) {

    end_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width);

    translate([block_width(l), block_width(w)])
        rotate([0, 0, 180])
            end_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width);
}


// A row of sheaths surrounding holes along the width
module end_connector_sheath_set(l=l, w=w, axle_hole_radius=axle_hole_radius, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width) {
    
    sheath_radius=bearing_sheath_thickness+axle_hole_radius;
    sheath_length=block_width();
    
    if (w==1) {
        translate([0, block_width(0.5), block_height(1)-block_width(0.5)])
            rotate([0, 90, 0])
                sheath(sheath_radius=sheath_radius, sheath_length=peg_length);
    } else {
        for (j = [1:w-1]) {
            translate([0, block_width(j), block_height(1)-block_width(0.5)])
                rotate([0, 90, 0])
                    sheath(sheath_radius=sheath_radius, sheath_length=sheath_length);
        }
    }
}


// The solid cylinder around a bearing hole
module sheath(sheath_radius=bearing_sheath_thickness+axle_hole_radius, sheath_length=block_width(0.5)) {
    
    cylinder(r=sheath_radius, h=sheath_length);
}

// For use by extension routines
module double_end_connector_hole_set(l=l, w=w, axle_hole_radius=axle_hole_radius, block_width=block_width, hole_type=end_holes) {
 
    translate([block_width(l), 0, 0])
        rotate([0, 0, 90])
            double_side_connector_hole_set(l=w, w=l, axle_hole_radius=axle_hole_radius, block_width=block_width, hole_type=hole_type);
}

// For use by extension routines
module double_side_connector_hole_set(l=l, w=w, axle_hole_radius=axle_hole_radius, block_width=block_width, hole_type=side_holes) {
    
    side_connector_hole_set(l=l, w=w, axle_hole_radius=axle_hole_radius, block_width=block_width, hole_type=hole_type);
    
    translate([block_width(l), block_width(w)])
        rotate([0, 0, 180])
            side_connector_hole_set(l=l, w=w, axle_hole_radius=axle_hole_radius, block_width=block_width, hole_type=hole_type);
}


// A row of knob-size holes around the sides of row 1
module side_connector_hole_set(l=l, w=w, axle_hole_radius=axle_hole_radius, block_width=block_width, hole_type=side_holes) {
    
    //TODO Short holes not properly supprted
    length = side_holes==3 ? block_width() : block_width(w);

    if (l==1) {
        translate([block_width(0.5), 0, block_height()-block_width(0.5)])
            rotate([-90, 0, 0])
                axle_hole(hole_type=hole_type, length=length, axle_hole_radius=axle_hole_radius);
        
    } else {
        for (i = [1:l-1]) {
            translate([block_width(i), 0, block_height()-block_width(0.5)])
                rotate([-90, 0, 0])
                    axle_hole(hole_type=hole_type, length=length,  axle_hole_radius=axle_hole_radius);
        }
    }
}


// Hole for an axle
module rotation_hole(radius=axle_hole_radius, length=block_height()) {
    
    cylinder(r=radius, h=length);
}


// The rotation and connector hole for a technic connector
module axle_hole(hole_type=side_holes, radius=axle_hole_radius, length=counterbore_inset_depth+peg_length) {
    
    rotation_hole(radius=radius, length=length);

    if (hole_type>1) {
        counterbore_inset(counterbore_inset_depth=counterbore_inset_depth, counterbore_inset_radius=counterbore_inset_radius);

        depth=2*(block_width()-peg_length-counterbore_inset_depth);
        inset_radius=counterbore_inset_radius-bearing_sheath_thickness/2;
            
        translate([0, 0, counterbore_inset_depth+peg_length])
            counterbore_inset(counterbore_inset_depth=depth, counterbore_inset_radius=inset_radius);
    }
}


// The connector inset for a technic side connector
module counterbore_inset(counterbore_inset_depth=counterbore_inset_depth, counterbore_inset_radius=counterbore_inset_radius) {
    
    translate([0, 0, -defeather])
        cylinder(r=counterbore_inset_radius, h=counterbore_inset_depth+2*defeather);
}
