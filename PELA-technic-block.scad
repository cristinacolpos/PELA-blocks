/*
PELA Parametric Block with LEGO-compatible technic connectors and air vents

PELA Parametric Blocks - 3D Printed LEGO-compatible parametric blocks

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Import this into other design files:
    include <style.scad>
    use <technic.scad>
    
All modules have sensible defaults derived from <style.scad>. 
You can ignore values you are not tampering with and only need to pass a
parameter if you are overriding.

All modules are setup for stateless functional-style reuse in other OpenSCAD files.
To this end, you can always pass in and override all parameters to create
a new effect. Doing this is not natural to OpenSCAD, so apologies for all
the boilerplate arguments which are passed in to each module or any errors
that may be hidden by the sensible default values. This is an evolving art.
*/

include <style.scad>
include <print-parameters.scad>
use <PELA-block.scad>



/* [Technic Block] */

// Printing material
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Length [blocks]
l = 4;

// Width [blocks]
w = 4;

// Height [blocks]
h = 2;


/* [Block Features] */

// Presence of bottom connector sockets
sockets = true;

// Presence of top connector knobs
knobs = true;

// How tall are top connectors [mm]
knob_height = 2.9; // [1.8:traditional blocks, 2.9:PELA improved 3D print fit]

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
corner_bolt_holes = false;

// Size of corner holes for M3 mountings bolts
bolt_hole_radius = 1.6;

// Add interior fill for upper layers
solid_upper_layers = false;

// Add interior fill for upper layers
// Add interior fill for the base layer
solid_first_layer = false;


/* [Technic Features] */

// Add full width through holes spaced along the length for PELA Techics connectors
side_holes = 2; // [0:disabled, 1:short air vents, 2:full width connectors, 3:short connectors]

// Add a wrapper around technic side holes (only used if there are side_holes, disable for extra ventilation, enable for connector lock notches)
side_sheaths = true;

// Add short end holes spaced along the width for PELA Techics connectors
end_holes = 3; // [0:disabled, 1:short air vents, 2:full width connectors, 3:short connectors]

// Add a wrapper around end holes  (only used if there are end_holes, disable for extra ventilation, enable for connector lock notches)
end_sheaths = true;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

// Size of a hole in the top of each knob. 0 to disable or use for air circulation/aesthetics/drain resin from the cutout, but larger holes change flexture such that knobs may not hold as well.
knob_vent_radius = 0.0;



/////////////////////////////////////
// DISPLAY
/////////////////////////////////////

PELA_technic_block();


/////////////////////////////////////
// FUNCTIONS
/////////////////////////////////////

// Indicates a solid cylinder around side hole connectors
function is_side_sheaths(side_sheaths=side_sheaths, side_holes=side_holes) = side_sheaths && side_holes > 1;

// Indicates a solid cylinder around end hole connectors
function is_end_sheaths(end_sheaths=end_sheaths, end_holes=end_holes) = end_holes > 1 && end_sheaths;




///////////////////////////////////
// MODULES
///////////////////////////////////

module PELA_technic_block(material=material, l=l, w=w, h=h, knob_height=knob_height, knob_flexture_height=knob_flexture_height, sockets=sockets, knobs=knobs, knob_vent_radius=knob_vent_radius, skin=skin, side_shell=side_shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, ridge_z_offset=ridge_z_offset, solid_upper_layers=solid_upper_layers, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, solid_first_layer=solid_first_layer, block_height=block_height, material=material, large_nozzle=large_nozzle,  bottom_tweak=undef, top_tweak=undef, axle_hole_tweak=undef) {

    difference() {
        union() {
            PELA_block(material=material, l=l, w=w, h=h, knob_height=knob_height, knob_flexture_height=knob_flexture_height, sockets=sockets, knobs=knobs, knob_vent_radius=knob_vent_radius, skin=skin, side_shell=side_shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, ridge_z_offset=ridge_z_offset, solid_upper_layers=solid_upper_layers, solid_first_layer=solid_first_layer, block_height=block_height, material=material, large_nozzle=large_nozzle, bottom_tweak=bottom_tweak, top_tweak=top_tweak);
            
            for (i = [0:h-1]) {
                translate([0, 0, block_height(i, block_height=block_height)]) {
                    if (is_side_sheaths(side_sheaths=side_sheaths, side_holes=side_holes)) {
                        double_side_connector_sheath_set(material=material, l=l, w=w, peg_length=peg_length, block_width=block_width, block_height=block_height);
                    }
                    
                    if (is_end_sheaths(end_sheaths=end_sheaths, end_holes=end_holes)) {
                        double_end_connector_sheath_set(material=material, l=l, w=w, peg_length=peg_length, block_width=block_width, block_height=block_height);
                    }
                }
            }
        }
        
        union() {
            if (side_holes || end_holes || top_vents) {
                length = knob_height + skin;
                alternate_length = top_vents ? block_height(h+0.1, block_height=block_height) + defeather : block_height(h-0.5, block_height=block_height);

                double_socket_hole_set(material=material, l=l, w=w, sockets=sockets, length=length, alternate_length=alternate_length, bevel_socket=true, large_nozzle=large_nozzle, material=material);
            }

            ahr = override_axle_hole_radius(material, axle_hole_tweak);

            bottom_connector_negative_space(material=material, l=l, w=w, h=h, side_holes=side_holes, end_holes=end_holes, block_width=block_width, block_height=block_height, hole_type=side_holes, block_width=block_width, corner_bolt_holes=corner_bolt_holes, sockets=sockets, skin=skin, block_height=block_height, axle_hole_radius=ahr);
            
            skin(material=material, l=l, w=w, h=h, skin=skin, ridge_width=ridge_width, ridge_depth=ridge_depth, block_height=block_height);
        }
    }
}


// Holes cut into the sides for the block on layer 1 to allow technic pins and axles to be inserted
module bottom_connector_negative_space(material=material, l=l, w=w, h=h, side_holes=side_holes, end_holes=end_holes, block_width=block_width, hole_type=side_holes, block_width=block_width, block_height=block_height, corner_bolt_holes=corner_bolt_holes, sockets=sockets, skin=skin, block_height=block_height, axle_hole_radius=undef) {
    
    for (i = [1:h]) {
        translate([0, 0, block_height(i-1)]) {
            if (side_holes > 0) {
                double_side_connector_hole_set(material=material, l=l, w=w, hole_type=side_holes, block_width=block_width, block_height=block_height, axle_hole_radius=axle_hole_radius);
            }
            
            if (end_holes > 0) {
                double_end_connector_hole_set(material=material, l=l, w=w, hole_type=end_holes, block_width=block_width, axle_hole_radius=axle_hole_radius);
            }
        }
    }
    
    if (corner_bolt_holes) {
        corner_corner_bolt_holes(material=material, l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius, block_height=block_height);
    }
}


module double_side_connector_sheath_set(material=material, l=l, w=w, side_holes=side_holes, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width, skin=skin, block_height=block_height) {

    side_connector_sheath_set(material=material, l=l, w=w, side_holes=side_holes, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width, skin=skin, block_height=block_height);

    translate([block_width(l), block_width(w)]) {
        rotate([0, 0, 180]) {
            side_connector_sheath_set(material=material, l=l, w=w, side_holes=side_holes, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width, skin=skin, block_height=block_height);
        }
    }
}


// A row of sheaths surrounding holes along the length
module side_connector_sheath_set(material=material, l=l, w=w, side_holes=side_holes, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width, skin=skin, block_height=block_height, axle_hole_tweak=undef) {
    
    sheath_radius = bearing_sheath_thickness + override_axle_hole_radius(material, axle_hole_tweak);

    sheath_length = side_holes==1 || side_holes==2 ? block_width(w) : block_width();
    
    if (l==1) {
        translate([block_width(0.5), 0, block_height(1, block_height=block_height)-block_width(0.5)]) {
            rotate([-90, 0, 0]) {
                sheath(material=material, sheath_radius=sheath_radius, sheath_length=sheath_length, skin=skin);
            }
        }
    } else {
        for (i = [1:l-1]) {
            translate([block_width(i), 0, block_height(1, block_height=block_height)-block_width(0.5)]) {
                rotate([-90, 0, 0]) {
                    sheath(material=material, sheath_radius=sheath_radius, sheath_length=sheath_length, skin=skin);
                }
            }
        }
    }
}


// Two rows of end connector enclosing cylinders
module double_end_connector_sheath_set(material=material, l=l, w=w, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width, skin=skin, block_height=block_height, axle_hole_tweak=undef) {

    end_connector_sheath_set(material=material, l=l, w=w, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width, skin=skin, block_height=block_height, axle_hole_tweak=axle_hole_tweak);

    translate([block_width(l), block_width(w)]) {
        rotate([0, 0, 180]) {
            end_connector_sheath_set(material=material, l=l, w=w, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width, skin=skin, block_height=block_height, axle_hole_tweak=axle_hole_tweak);
        }
    }
}


// A row of sheaths surrounding holes along the width
module end_connector_sheath_set(material=material, l=l, w=w, peg_length=peg_length, bearing_sheath_thickness=bearing_sheath_thickness, block_width=block_width, skin=skin, block_height=block_height, axle_hole_tweak=undef) {
    
    sheath_radius = bearing_sheath_thickness + override_axle_hole_radius(material, axle_hole_tweak);

    sheath_length = block_width(1, block_width=block_width);
    
    if (w==1) {
        translate([0, block_width(0.5), block_height(1)-block_width(0.5, block_width=block_width)]) {
            rotate([0, 90, 0]) {
                sheath(material=material, sheath_radius=sheath_radius, sheath_length=peg_length, skin=skin);
            }
        }
    } else {
        for (j = [1:w-1]) {
            translate([0, block_width(j), block_height(1, block_height=block_height)-block_width(0.5, block_width=block_width)]) {
                rotate([0, 90, 0]) {
                    sheath(material=material, sheath_radius=sheath_radius, sheath_length=sheath_length, skin=skin);
                }
            }
        }
    }
}


// The solid cylinder around a bearing hole
module sheath(material=material, sheath_radius=undef, sheath_length=block_width(0.5), skin=skin) {

    translate([0, 0, skin]) {  
        cylinder(r=sheath_radius, h=sheath_length - 2*skin);
    }
}


// For use by extension routines
module double_end_connector_hole_set(material=material, l=l, w=w, hole_type=end_holes, block_width=block_width, axle_hole_radius=undef) {
 
    translate([block_width(l), 0, 0]) {
        rotate([0, 0, 90]) {
            double_side_connector_hole_set(material=material, l=w, w=l, hole_type=hole_type, block_width=block_width, block_height=block_height, axle_hole_radius=axle_hole_radius);
        }
    }
}


// For use by extension routines
module double_side_connector_hole_set(material=material, l=l, w=w, hole_type=side_holes, block_width=block_width, block_height=block_height, axle_hole_radius=undef) {
    
    side_connector_hole_set(material=material, l=l, w=w, block_width=block_width, hole_type=hole_type, block_height=block_height, axle_hole_radius=axle_hole_radius);
    
    translate([block_width(l), block_width(w)]) {
        rotate([0, 0, 180]) {
            side_connector_hole_set(material=material, l=l, w=w, block_width=block_width, hole_type=hole_type, block_height=block_height, axle_hole_radius=axle_hole_radius);
        }
    }
}


// A row of knob-size holes around the sides of row 1
module side_connector_hole_set(material=material, l=l, w=w, block_width=block_width, hole_type=side_holes, block_height=block_height, axle_hole_radius=undef) {
    
    length = (hole_type==1 || hole_type==3) ? block_width() : block_width(w);

    if (l==1) {
        translate([block_width(0.5), 0, block_height(1, block_height=block_height)-block_width(0.5)]) {
            rotate([-90, 0, 0]) {
                axle_hole(material=material, hole_type=hole_type, radius=axle_hole_radius, length=counterbore_inset_depth+peg_length);
            }
        }        
    } else {
        for (i = [1:l-1]) {
            translate([block_width(i), 0, block_height(1, block_height=block_height)-block_width(0.5)]) {
                rotate([-90, 0, 0]) {
                    axle_hole(material=material, hole_type=hole_type, radius=axle_hole_radius, length=counterbore_inset_depth+peg_length);
                }
            }
        }
    }
}


// Hole for an axle
module rotation_hole(material=material, radius=undef, length=block_height()) {
    
    cylinder(r=radius, h=length, $fn=axle_hole_fn);
}


// The rotation and connector hole for a technic connector
module axle_hole(material=material, hole_type=side_holes, radius=undef, length=counterbore_inset_depth+peg_length) {
    
    rotation_hole(material=material, radius=radius, length=length);

    if (hole_type>1) {
        counterbore_inset(material=material, counterbore_inset_depth=counterbore_inset_depth, counterbore_inset_radius=counterbore_inset_radius);

        depth=2*(block_width()-peg_length-counterbore_inset_depth);
        inset_radius=counterbore_inset_radius-bearing_sheath_thickness/2;
            
        translate([0, 0, counterbore_inset_depth+peg_length]) {
            counterbore_inset(material=material, counterbore_inset_depth=depth, counterbore_inset_radius=inset_radius);
        }
    }
}


// The connector inset for a technic side connector
module counterbore_inset(material=material, counterbore_inset_depth=counterbore_inset_depth, counterbore_inset_radius=counterbore_inset_radius) {
    
    translate([0, 0, -defeather]) {
        cylinder(r=counterbore_inset_radius, h=counterbore_inset_depth+2*defeather);
    }
}
