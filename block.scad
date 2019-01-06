/*
Base PELA Parametric Block

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
    include <parameters.scad>
    use <block.scad>

All modules have sensible defaults derived from <PELA_parameters.scad>. 
You can ignore values you are not tampering with and only need to pass a
parameter if you are overriding.

All modules are setup for stateless functional-style reuse in other OpenSCAD files.
To this end, you can always pass in and override all parameters to create
a new effect. Doing this is not natural to OpenSCAD, so apologies for all
the boilerplate arguments which are passed in to each module or any errors
that may be hidden by the sensible default values. This is an evolving art.
*/

include <parameters.scad>
include <print-parameters.scad>



/* [PELA Block Dimensions] */

// Length of the block (PELA unit count)
l = 4; 

// Width of the block (PELA unit count)
w = 2;

// Height of the block (PELA unit count)
h = 2;

solid_bottom_layer = false;

sockets = true;

knob_height = 1.8;


/////////////////////////////////////
// PELA display
/////////////////////////////////////

PELA_block();


/////////////////////////////////////
// MODULES
/////////////////////////////////////


// A PELA block
module PELA_block(l=l, w=w, h=h, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, sockets=sockets, knobs=knobs, knob_vent_radius=knob_vent_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, ridge_z_offset=ridge_z_offset, solid_upper_layers=solid_upper_layers, solid_bottom_layer=solid_bottom_layer, block_height=block_height, flexible_material=flexible_material, large_nozzle=large_nozzle, bottom_centers_are_sockets=bottom_centers_are_sockets, bottom_tweak=bottom_tweak, top_tweak=top_tweak, axle_hole_tweak=axle_hole_tweak, socket_insert_bevel=socket_insert_bevel) {
    
    difference() {
        union() {
            outer_shell(l=l, w=w, h=h, shell=shell, top_shell=top_shell, block_height=block_height);

            if (knobs) {
                top_knob_set(l=l, w=w, h=h, knob_radius=knob_radius, knob_height=knob_height, bolt_holes=bolt_holes, block_height=block_height, flexible_material=flexible_material);
            }

            bar_h = h > 1 ? 1 : h;

            if (h >= block_height(2/3, block_height=block_height)) {
                translate([0, 0, block_height(h-1, block_height=block_height)])
                    bottom_stiffener_bar_set(l=l, w=w, h=bar_h, start_l=1, end_l=l-1, start_w=1, end_w=w-1, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height);
            }

            if (sockets) {
                length = block_height(min(1, h), block_height=block_height);
                
                socket_set(l=l, w=w, length=length, sockets=sockets, block_height=block_height, flexible_material=flexible_material, large_nozzle=large_nozzle, bottom_tweak=bottom_tweak);

                translate([block_width(-0.5), block_width(-0.5)])
                    intersection() {
                        cube([block_width(l+1), block_width(w+1), length]);

                        socket_set(l=l+1, w=w+1, length=length, sockets=sockets, block_height=block_height, flexible_material=flexible_material, large_nozzle=large_nozzle, bottom_tweak=bottom_tweak);
                    }
            }

            if (bolt_holes) {
                corner_bolt_hole_supports(l=l, w=w, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height);
            }

            if (solid_bottom_layer || !sockets) {
                fill_bottom_layer(l=l, w=w, h=h, sockets=sockets, knob_height=knob_height, block_height=block_height);
            } else if (h>1) {
                bottom_stiffener_bar_set(l=l, w=w, h=bar_h, start_l=1, end_l=l-1, start_w=1, end_w=w-1, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height);
            }
            
            if (h>1 && solid_upper_layers) {
                fill_upper_layers(l=l, w=w, h=h, block_height=block_height);
            }
        }

        union() {
            skin(l=l, w=w, h=h, skin=skin, ridge_width=ridge_width, ridge_depth=ridge_depth, ridge_z_offset=ridge_z_offset,block_height=block_height);
            
            if (knobs) {
                knob_flexture_set(l=l, w=w, h=h, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_vent_radius=knob_vent_radius, bolt_holes=bolt_holes, block_height=block_height, flexible_material=flexible_material);
            }
                
            length = block_height(h)-top_shell;

            double_socket_hole_set(l=l, w=w, sockets=sockets, length=length, alternate_length=length, bevel_socket=true, flexible_material=flexible_material, socket_insert_bevel=socket_insert_bevel, large_nozzle=large_nozzle, bottom_tweak=bottom_tweak, bottom_centers_are_sockets=bottom_centers_are_sockets);
            
            if (bolt_holes) {
                corner_bolt_holes(l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius, block_height=block_height);
            }
        }
    }
}


module double_socket_hole_set(l=l, w=w, sockets=sockets, alternate_length, length, bevel_socket=true, flexible_material=flexible_material, socket_insert_bevel=socket_insert_bevel, large_nozzle=large_nozzle, bottom_tweak=bottom_tweak, bottom_centers_are_sockets=bottom_centers_are_sockets) {

    if (sockets) {
        rr = ring_radius(large_nozzle=large_nozzle, bottom_tweak=bottom_tweak);
        rt = ring_thickness(large_nozzle=large_nozzle);

        alternating_radius = bottom_centers_are_sockets ? rr-rt : 2/3*(rr-rt);
        alternating_fn = bottom_centers_are_sockets ? ring_fn : axle_hole_fn;

        translate([block_width(), block_width(), -defeather]) {
            socket_hole_set(l=l-1, w=w-1, radius=alternating_radius, length=alternate_length+2*defeather, bevel_socket=bevel_socket, ring_fn=alternating_fn, flexible_material=flexible_material, socket_insert_bevel=socket_insert_bevel);
        }

        translate([block_width(0.5), block_width(0.5), -defeather]) {
            socket_hole_set(l=l, w=w, radius=rr-rt, length=length+2*defeather, bevel_socket=bevel_socket, ring_fn=ring_fn, flexible_material=flexible_material, socket_insert_bevel=socket_insert_bevel);
        }
    }
}


// Show a shadow representing the knobs of a block below
module shadow_knob_set(l=l, w=w, h=h, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_vent_radius=knob_vent_radius, bolt_holes=bolt_holes) {
    
    translate([0, 0, -block_height(h, block_height=block_height)]) {
        difference() {
            top_knob_set(l=l, w=w, h=h, knob_radius=knob_radius, knob_height=knob_height, bolt_holes=bolt_holes, block_height=block_height, flexible_material=flexible_material);
            
            knob_flexture_set(l=l, w=w, h=h, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_vent_radius=knob_vent_radius, bolt_holes=bolt_holes, flexible_material=flexible_material);
        }
    }
}


// Make the bottom layer be solid instead of mostly open space
module fill_bottom_layer(l=l, w=w, h=h, sockets=sockets, knob_height=knob_height, block_height=block_height) {

    offset = sockets ? knob_height + skin : 0;
    fill_height = max(0, block_height(h, block_height=block_height) - offset);

    translate([0, 0, offset]) {
        cube([block_width(l), block_width(w), fill_height]);
    }
}


// Make layers above the bottom layer be solid instead of mostly open space
module fill_upper_layers(l=l, w=w, h=h, block_height=block_height) {

    translate([0, 0, block_height(1, block_height=block_height)]) {
        cube([block_width(l), block_width(w), block_height(h-1, block_height=block_height)]);
    }
}


// Several blocks in a grid, one knob per block
module top_knob_set(l=l, w=w, h=h, knob_radius=knob_radius, knob_height=knob_height, bolt_holes=bolt_holes, block_height=block_height, flexible_material=flexible_material) {
    
    for (i = [0:1:l-1]) {
        for (j = [0:1:w-1]) {
            if (!(bolt_holes && is_corner(x=i, y=j, l=l, w=w))) {
                translate([block_width(i), block_width(j), 0]) {
                    top_knob(h=h, knob_radius=knob_radius, knob_height=knob_height, block_height=block_height, flexible_material=flexible_material);
                }
            }
        }
    }
}


// The connector cylinder
module top_knob(h=h, knob_height=knob_height, block_height=block_height, flexible_material=flexible_material) {
    
    translate([block_width(0.5), block_width(0.5), block_height(h, block_height=block_height)]) {
        knob(knob_radius=knob_radius, knob_height=knob_height, flexible_material=flexible_material);
    }
}


// The cylinder on top of a PELA block
module knob(knob_radius=knob_radius, knob_height=knob_height, flexible_material=flexible_material) {
    
    bevel = knob_bevel(flexible_material=flexible_material);

    cylinder(r=knob_radius, h=knob_height-bevel);

    if (bevel > 0) {
        translate([0, 0, knob_height-bevel]) {
            intersection() {
                cylinder(r=knob_radius, h=bevel);
                cylinder(r1=knob_radius, r2=0, h=1.5*(knob_radius));
            }
        }
    }
}

// An array of empty cylinders to fit inside a knob_set()
module knob_flexture_set(l=l, w=w, h=h, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_vent_radius=knob_vent_radius, bolt_holes=bolt_holes, block_height=block_height, flexible_material=flexible_material) {

    for (i = [0:l-1]) {
        for (j = [0:w-1]) {
            if (!bolt_holes || !is_corner(x=i, y=j, l=l, w=w)) {
                translate([block_width(i+0.5), block_width(j+0.5), block_height(h, block_height=block_height)]) {
                    knob_flexture(knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_vent_radius=knob_vent_radius, flexible_material=flexible_material);
                }
            }
        }
    }
}


// The negative space flexture inside a single knob
module knob_flexture(knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_vent_radius=knob_vent_radius, flexible_material=flexible_material) {

   translate([0, 0, knob_height-knob_top_thickness-knob_flexture_height]) {
        cylinder(r=knob_flexture_radius(flexible_material=flexible_material), h=knob_flexture_height);
   }
    
    if (knob_vent_radius > 0) {
        translate([0, 0, knob_height-knob_top_thickness]) {
            cylinder(r=knob_vent_radius, h=knob_height+defeather);
        }
    }
}


// That solid outer skin of a block set
module outer_shell(l=l, w=w, h=h, shell=shell, top_shell=top_shell, block_height=block_height) {
    
    difference() {
        cube([block_width(l), block_width(w), block_height(h, block_height=block_height)]);
        
        translate([shell, shell, -top_shell]) {
            cube([block_width(l)-2*shell, block_width(w)-2*shell, block_height(h, block_height=block_height)]);
        }
    }
}

// A solid block, no knobs or connectors. This is provided as a convenience for constructive solid geometry designs based on this block
module skinned_block(l=l, w=w, h=h, skin=skin, ridge_width=ridge_width, ridge_depth=ridge_depth, block_height=block_height) {
    difference() {
        hull() {
            outer_shell(l=l, w=w, h=h, shell=1, top_shell=1);
        }

        skin(l=l, w=w, h=h, skin=skin, ridge_width=ridge_width, ridge_depth=ridge_depth, block_height=block_height);
    }
}

// Bars layed below a horizontal surface to make it stronger
module bottom_stiffener_bar_set(l=l, w=w, h=h, start_l=1, end_l=l-1, start_w=1, end_w=w-1, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height) {
    
    cut_width = bottom_stiffener_width/6;
    translate([0, 0, block_height(h, block_height=block_height)-bottom_stiffener_height]) {
        if (end_l >= start_l) {
            for (i = [start_l:end_l]) {            
                translate([block_width(i)-(bottom_stiffener_width)/2, 0, 0]) {
                    difference() {
                        cube([bottom_stiffener_width, block_width(w), bottom_stiffener_height]);
                    
                        translate([(bottom_stiffener_width-cut_width)/2, 0, -defeather]) {
                            cube([cut_width, block_width(w), bottom_stiffener_height+defeather]);
                        }
                    }
                }
            }
        }
        
        if (end_w >= start_w) {
            for (j = [start_w:end_w]) {
                translate([0, block_width(j)-(bottom_stiffener_width)/2, 0]) {
                    difference() {
                        cube([block_width(l), bottom_stiffener_width, bottom_stiffener_height]);
                    
                        translate([0, (bottom_stiffener_width-cut_width)/2, -defeather])
                            cube([block_width(l), cut_width, bottom_stiffener_height+defeather]);
                    }
                }
            }
        }
    }
}


// Bottom connector rings positive space for multiple blocks
module socket_set(l=l, w=w, length=block_height(), sockets=sockets, flexible_material=flexible_material, bottom_tweak=bottom_tweak) {
    
    if (sockets && (l>1 && w>1)) {
        for (i = [1:l-1]) {
            for (j = [1:w-1]) {
                translate([block_width(i), block_width(j), 0]) {
                    socket_ring(length=length, large_nozzle=large_nozzle, flexible_material=flexible_material, bottom_tweak=bottom_tweak);
                }
            }
        }
    }
}


// The circular bottom insert for attaching knobs
module socket_ring(length=block_height(1, block_height=block_height), large_nozzle=large_nozzle, flexible_material=flexible_material, bottom_tweak=bottom_tweak) {
    
    rotate([0, 0, 180/ring_fn]) {
        cylinder(r=ring_radius(large_nozzle=large_nozzle, bottom_tweak=bottom_tweak), h=length, $fn=ring_fn);
    }
}


// Bottom connector- negative flexture space inside bottom rings for multiple blocks
module socket_hole_set(l=l, w=w, radius=ring_radius()-ring_thickness(large_nozzle=large_nozzle), length=block_height(1, block_height=block_height), bevel_socket=false, ring_fn=ring_fn, flexible_material=flexible_material, socket_insert_bevel=socket_insert_bevel) {
    
    if (sockets && l>0 && w>0) {
        for (i = [0:l-1]) {
            for (j = [0:w-1]) {
                translate([block_width(i), block_width(j), 0]) {
                    socket_hole(radius=radius, length=length, bevel_socket=bevel_socket, ring_fn=ring_fn, block_height=block_height, flexible_material=flexible_material, socket_insert_bevel=socket_insert_bevel);
                }
            }
        }
    }
}


// Hole with side grip ridge flexture to grab any knob on a block inserted from below
module socket_hole(radius=ring_radius()-ring_thickness(), length=block_height(1, block_height=block_height), bevel_socket=false, ring_fn=ring_fn, flexible_material=flexible_material, socket_insert_bevel=socket_insert_bevel) {

    h2 = official_knob_height/2;
    bevel_h = bevel_socket ? socket_insert_bevel : 0;

    rotate([0, 0, 180/ring_fn]) {
        cylinder(r=radius, h=bevel_h + defeather, $fn=ring_fn);

        translate([0, 0, bevel_h - defeather]) {
            cylinder(r=radius - side_lock_thickness(flexible_material=flexible_material), h=h2 + 2*defeather + socket_insert_bevel, $fn=ring_fn);
        }

        translate([0, 0, h2 + socket_insert_bevel]) {
            cylinder(r=radius, h=length - h2 - socket_insert_bevel + 2*defeather, $fn=ring_fn);
        }
    }
}


// The thin negative space surrounding a PELA block so that two blocks can fit next to each other easily in a tight grid
module skin(l=l, w=w, h=h, skin=skin, ridge_width=ridge_width, ridge_depth=ridge_depth, ridge_z_offset=ridge_z_offset, block_height=block_height) {

    if (skin>0) {
        // Front skin
        cube([block_width(l), skin, block_height(h, block_height=block_height)]);

        // Back skin
        translate([0, block_width(w)-skin, 0]) {
            cube([block_width(l), skin, block_height(h, block_height=block_height)]);
        }

        // Left skin
        cube([skin, block_width(w), block_height(h, block_height=block_height)]);
        
        // Right skin
        translate([block_width(l)-skin, 0, 0]) {
            cube([skin, block_width(w), block_height(h, block_height=block_height)]);
        }
    }
    
    if (ridge_width>0 && ridge_depth>0 && h>1) {
        for (i = [block_height(1, block_height=block_height):block_height():block_height(h, block_height=block_height)]) {
            // Front layer ridge
            translate([0, 0, i]) {
                cube([block_width(l), ridge_depth, ridge_width]);
            }
                
            // Back layer ridge
            translate([0, block_width(w)-skin-ridge_depth, i]) {
                cube([block_width(l), ridge_depth, ridge_width]);
            }

            // Left layer ridge
            translate([skin, 0, i]) {
                cube([ridge_depth, block_width(w), ridge_width]);
            }

            // Right layer ridge
            translate([block_width(l) - skin - ridge_depth, 0, i]) {
                cube([ridge_depth, block_width(w), ridge_width]);
            }
        }
    }
}


// Mounting hole support blocks
module corner_bolt_holes(l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius, block_height=block_height) {
    bolt_hole(x=1, y=1, r=bolt_hole_radius, h=h, block_height=block_height);
    bolt_hole(x=1, y=w, r=bolt_hole_radius, h=h, block_height=block_height);
    bolt_hole(x=l, y=1, r=bolt_hole_radius, h=h, block_height=block_height);
    bolt_hole(x=l, y=w, r=bolt_hole_radius, h=h, block_height=block_height);
}


// A hole for a mounting bolt in the corners of a panel or block
module bolt_hole(x=1, y=1, r=bolt_hole_radius, h=h, block_height=block_height) {
    translate([block_width(x-0.5), block_width(y-0.5), 0])
        cylinder(r=r, h=block_height(h, block_height=block_height) + skin);
}
    

// Mounting hole support blocks
module corner_bolt_hole_supports(l=l, w=w, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height) {
    bolt_hole_support(x=1, y=1, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height);
    bolt_hole_support(x=1, y=w, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height);
    bolt_hole_support(x=l, y=1, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height);
    bolt_hole_support(x=l, y=w, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height);
}


// A solid block under the bolt hole to give extra support to the bolt head
module bolt_hole_support(x=1, y=1, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height, block_height=block_height) {
    
    depth = top_shell+bottom_stiffener_height;
    
    translate([block_width(x-1), block_width(y-1), block_height(h, block_height=block_height)-depth]) {
        cube([block_width(), block_width(), depth]);
    }
}
