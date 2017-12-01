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
    include <lego-parameters.scad>
    use <lego.scad>

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

/////////////////////////////////////
// LEGO display
/////////////////////////////////////

if (mode==1) {
    // A single block
    lego();
} else if (mode==2) {
    // Bock without top knobs
    lego(knob_height=0, knob_bevel=0, knob_flexture_radius=0, knob_vent_radius=0);
} else if (mode==3) {
    // Block without bottom sockets
    lego(sockets=0);
} else if (mode==4) {
    // Block without top knobs or bottom sockets
    lego(sockets=0, knob_height=0, knob_bevel=0, knob_flexture_radius=0, knob_vent_radius=0);
} else {
    echo("<b>Unsupported: please check <i>mode</i> variable is 1-4</b>");
}

/////////////////////////////////////
// FUNCTIONS
/////////////////////////////////////

// Horizontal size
function lego_width(i=1, block_width=block_width) = i*block_width;

// Vertical size
function lego_height(h=1, block_height=block_height) = h*block_height;

// Convert online Customizer-and-command-line-friendly integers into booleans
function is_true(t) = t != 0;

// Test if this is a corner block
function is_corner(x, y, l=l, w=w) = (x==0 || x==l-1) && (y==0 || y==w-1);

// Thickness of a flat panel
function panel_height(block_height=block_height) = block_height/3;

/////////////////////////////////////
// MODULES
/////////////////////////////////////



// A LEGO block
module lego(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, axle_hole_tweak=axle_hole_tweak, axle_hole_radius=axle_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, ring_radius=ring_radius, sockets=sockets, knobs=knobs, knob_vent_radius=knob_vent_radius, skin=skin, shell=shell, top_shell=top_shell, panel=false, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_lock_thickness=side_lock_thickness, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers, solid_bottom_layer=solid_bottom_layer, inverted_print_rim=inverted_print_rim) {
    
    difference() {
        union() {
            outer_shell(l=l, w=w, h=h, shell=shell, top_shell=top_shell);

            if (is_true(knobs)) {
                top_knob_set(l=l, w=w, h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_bevel=knob_bevel, bolt_holes=bolt_holes);
            }

            bottom_stiffener_bar_set(l=l, w=w, start_l=1, end_l=l-1, start_w=1, end_w=w-1, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height);
            
            if (is_true(sockets)) {
               side_lock_set(l=l, w=w, bottom_tweak=bottom_tweak, outside_lock_thickness=outside_lock_thickness, side_lock_thickness=side_lock_thickness);

               socket_set(l=l, w=w, ring_radius=ring_radius, sockets=sockets, bottom_tweak=bottom_tweak, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_lock_thickness=side_lock_thickness, skin=skin);
            }
    
            if (is_true(bolt_holes)) {
                corner_bolt_hole_supports(l=l, w=w, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height);
            }

            if (is_true(solid_bottom_layer)) {
                fill_bottom_layer(l=l, w=w);
            }
            
            if (h>1) {
                if (is_true(solid_upper_layers)) {
                    fill_upper_layers(l=l, w=w, h=h);
                } else {
                    translate([0, 0, lego_height(h-1)])
                        bottom_stiffener_bar_set(l=l, w=w, start_l=1, end_l=l-1, start_w=1, end_w=w-1, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height);
                }
            }
            
            if (is_true(knobs) && is_true(inverted_print_rim)) {
                upside_down_print_rim(l=l, w=w, h=h, knob_height=knob_height, skin=skin);
            }
        }

        union() {
            skin(l=l, w=w, h=h, skin=skin, ridge_width=ridge_width, ridge_depth=ridge_depth);
            
            if (is_true(knobs)) {
                knob_flexture_set(l=l, w=w, h=h, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_vent_radius=knob_vent_radius, bolt_holes=bolt_holes);
            }
                
            length = is_true(end_holes) || is_true(side_holes) ? lego_height(h)-lego_width(0.5) : lego_height(h)-top_shell;
            
            if (is_true(sockets)) {
                translate([0, 0, -0.01])
                    socket_hole_set(l=l, w=w, radius=axle_hole_radius+axle_hole_tweak, length=length);
            }
            
            if (is_true(bolt_holes)) {
                corner_bolt_holes(l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius);
            }
        }
    }
    
    %translate([0, 0, -lego_height(h)])
        difference() {
            top_knob_set(l=l, w=w, h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_bevel=knob_bevel, bolt_holes=bolt_holes);
            
            knob_flexture_set(l=l, w=w, h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_vent_radius=knob_vent_radius, bolt_holes=bolt_holes);
        }
}


// Make the bottom layer be solid filled instead of mostly open space
module fill_bottom_layer(l=l, w=w) {
    cube([lego_width(l), lego_width(w), lego_height()]);
}


// Make layers above the bottom layer be solid filled instead of mostly open space
module fill_upper_layers(l=l, w=w, h=h) {
    translate([0, 0, lego_height()])
        cube([lego_width(l), lego_width(w), lego_height(h-1)]);
}


// Several blocks in a grid, one knob per block
module top_knob_set(l=l, w=w, h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_bevel=knob_bevel, bolt_holes=bolt_holes) {
    
    for (i = [0:1:l-1]) {
        for (j = [0:1:w-1]) {
            if (!is_true(bolt_holes) || !is_corner(x=i, y=j, l=l, w=w)) {
                translate([lego_width(i), lego_width(j), 0])
                    top_knob(h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_bevel=knob_bevel);
                ;
            }
        }
    }
}


// The connector cylinder
module top_knob(h=h, top_tweak=top_tweak, knob_height=knob_height, knob_bevel=knob_bevel) {
    
    translate([lego_width(0.5), lego_width(0.5), lego_height(h)])
        knob(top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_bevel=knob_bevel);
}


// The cylinder on top of a lego block
module knob(top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_bevel=knob_bevel) {
    
    cylinder(r=knob_radius+top_tweak, h=knob_height-knob_bevel);

    if (knob_bevel > 0) {
        translate([0, 0, knob_height-knob_bevel])
            intersection() {
                cylinder(r=knob_radius+top_tweak,h=knob_bevel);
                cylinder(r1=knob_radius+top_tweak,r2=0,h=1.5*(knob_radius+top_tweak));
            }
    }
}

// An array of empty cylinders to fit inside a knob_set()
module knob_flexture_set(l=l, w=w, h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_vent_radius=knob_vent_radius, bolt_holes=bolt_holes) {

    for (i = [0:l-1]) {
        for (j = [0:w-1]) {
            if (!is_true(bolt_holes) || !is_corner(x=i, y=j, l=l, w=w)) {
                translate([lego_width(i+0.5), lego_width(j+0.5), lego_height(h)])
                    knob_flexture(h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_vent_radius=knob_vent_radius);
            }
        }
    }
}


// The negative space flexture inside a knob
module knob_flexture(h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_vent_radius=knob_vent_radius) {

   translate([0, 0, knob_height-knob_top_thickness-knob_flexture_height])
        cylinder(r=knob_flexture_radius, h=knob_flexture_height);
    
    if (knob_vent_radius>0) {
        translate([0, 0, knob_height-knob_top_thickness])
            cylinder(r=knob_vent_radius, h=knob_height+0.1);
    }
}


// That solid outer skin of a block set
module outer_shell(l=l, w=w, h=h, shell=shell, top_shell=top_shell) {
    
    difference() {
        cube([lego_width(l), lego_width(w), lego_height(h)]);
        
        translate([shell, shell, -top_shell])
            cube([lego_width(l)-2*shell, lego_width(w)-2*shell, lego_height(h)]);
    }
}


// Bars layed below (or above) a horizontal surface to make it stronger
module bottom_stiffener_bar_set(l=l, w=w, start_l=1, end_l=l-1, start_w=1, end_w=w-1, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height) {
    
    translate([0, 0, lego_height()-bottom_stiffener_height])
        stiffener_bar_set(l=l, w=w, start_l=start_l, end_l=end_l, start_w=start_w, end_w=end_w, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height);
}


// Bars layed below (or above) a horizontal surface to make it stronger. Usually these are on the bottom, between the connecting rings
module stiffener_bar_set(l=l, w=w, start_l=1, end_l=l-1, start_w=1, end_w=w-1, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height) {
    
    if (end_l >= start_l) {
    for (i = [start_l:end_l]) {
        if (side_holes!=1) {
            y = (side_holes==1 || side_holes==2) ? lego_width() : 0;
        
            cut_width = (i==0 || i==l) ? 0 : bottom_stiffener_width/2;
        
            translate([lego_width(i)-bottom_stiffener_width/2, y, 0])
                difference() {
                    cube([bottom_stiffener_width, lego_width(w) - 2*y, bottom_stiffener_height]);
                
                    translate([bottom_stiffener_width/4, 0, 0])
                        cube([cut_width, lego_width(w) - 2*y, bottom_stiffener_height]);
                }
        }
    }
    }
    
    if (end_w >= start_w) {
    for (j = [start_w:end_w]) {
        x = is_true(end_holes) ? lego_width() : 0;
    
        cut_width = (j==0 || j==w) ? 0 : bottom_stiffener_width/2;

        translate([x, lego_width(j)-bottom_stiffener_width/2, 0])
            difference() {
                cube([lego_width(l) - 2*x, bottom_stiffener_width, bottom_stiffener_height]);
                
                translate([0, bottom_stiffener_width/4, 0])
                    cube([lego_width(l) - 2*x, cut_width, bottom_stiffener_height]);
            }
    }
    }
}


// Bars layed below (or above) a horizontal surface to make it stronger. Usually these are on the bottom, between the connecting rings
module side_lock_set(l=l, w=w, bottom_tweak=bottom_tweak, outside_lock_thickness=outside_lock_thickness, side_lock_thickness=side_lock_thickness) {
    
    height=knob_height-knob_top_thickness;
    s = bottom_tweak+outside_lock_thickness+side_lock_thickness;

    difference() {
        cube([lego_width(l), lego_width(w), height]);
        translate([s, s, -0.1])
            cube([lego_width(l)-2*s, lego_width(w)-2*s, height+0.2]);
    }
}


// Bottom connector rings positive space for multiple blocks
module socket_set(l=l, w=w, ring_radius=ring_radius, sockets=sockets, bottom_tweak=bottom_tweak, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, skin=skin) {
    
    if (l>1 && w>1) {
        for (i = [1:l-1]) {
            for (j = [1:w-1]) {
                translate([lego_width(i), lego_width(j), 0])
                    socket_ring(ring_radius=ring_radius, sockets=sockets, bottom_tweak=bottom_tweak);
            }
        }
    }
}


// The circular bottom insert for attaching knobs
module socket_ring(ring_radius=ring_radius, sockets=sockets, bottom_tweak=bottom_tweak) {
    
    cylinder(r=ring_radius+bottom_tweak, h=block_height);
    
    if (side_lock_thickness>0) {
        cylinder(r=ring_radius+bottom_tweak+side_lock_thickness, h=knob_height-knob_top_thickness);
    }
}


// Bottom connector- negative flexture space inside bottom rings for multiple blocks
module socket_hole_set(l=l, w=w, radius=axle_hole_radius+axle_hole_tweak, length=block_height) {
    
    if (is_true(sockets)) {
        if (l>1 && w>1) {
            for (i = [1:l-1]) {
                for (j = [1:w-1]) {
                    translate([lego_width(i), lego_width(j), 0])
                        rotation_hole(radius=radius, length=length);
                }
            }
        }
    }
}


// Hole for an axle
module rotation_hole(radius=axle_hole_radius+axle_hole_tweak, length=block_width) {
    
    cylinder(r=radius, h=length);
}


// The thin negative space surrounding a LEGO block so that two blocks can fit next to each other easily in a tight grid
module skin(l=l, w=w, h=h, skin=skin, ridge_width=ridge_width, ridge_depth=ridge_depth) {
    // Front skin
    cube([lego_width(l), skin, lego_height(h)]);

    // Back skin
    translate([0, lego_width(w)-skin, 0])
        cube([lego_width(l), skin, lego_height(h)]);

    // Left skin
    cube([skin, lego_width(w), lego_height(h)]);
    
    // Right skin
    translate([lego_width(l)-skin, 0, 0])
        cube([skin, lego_width(w), lego_height(h)]);
    
    if (ridge_width>0 && h>1) {
        for (i = [1:h-1]) {
            // Front layer ridge
            translate([0, 0, lego_height(i)])
                cube([lego_width(l), ridge_depth, ridge_width]);
                
            // Back layer ridge
            translate([0, lego_width(w)-skin-ridge_depth, lego_height(i)])
                cube([lego_width(l), ridge_depth, ridge_width]);

            // Left layer ridge
            translate([skin, 0, lego_height(i)])
                cube([ridge_depth, lego_width(w), ridge_width]);

            // Right layer ridge
            translate([lego_width(l) - skin - ridge_depth, 0, lego_height(i)])
                cube([ridge_depth, lego_width(w), ridge_width]);
        }
    }
}


// Mounting hole support blocks
module corner_bolt_holes(l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius) {
    bolt_hole(x=1, y=1, r=bolt_hole_radius, h=h);
    bolt_hole(x=1, y=w, r=bolt_hole_radius, h=h);
    bolt_hole(x=l, y=1, r=bolt_hole_radius, h=h);
    bolt_hole(x=l, y=w, r=bolt_hole_radius, h=h);
}


// A hole for a mounting bolt in the corners of a panel or block
module bolt_hole(x=1, y=1, r=bolt_hole_radius, h=h) {
    translate([lego_width(x-0.5), lego_width(y-0.5), 0])
        cylinder(r=r, h=lego_height(h));
}
    

// Mounting hole support blocks
module corner_bolt_hole_supports(l=l, w=w, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height) {
    bolt_hole_support(x=1, y=1, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height);
    bolt_hole_support(x=1, y=w, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height);
    bolt_hole_support(x=l, y=1, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height);
    bolt_hole_support(x=l, y=w, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height);
}


// A solid block under the bolt hole to give extra support to the bolt head
module bolt_hole_support(x=1, y=1, h=h, top_shell=top_shell, bottom_stiffener_height=bottom_stiffener_height) {
    
    depth = top_shell+bottom_stiffener_height;
    
    translate([lego_width(x-1), lego_width(y-1), lego_height(h)-depth])
        cube([lego_width(), lego_width(), depth]);
}


// A rectangle which can be broken or cut away; used to help keep edges tidy if printing upside down
module upside_down_print_rim(l=l, w=w, h=h, knob_height=knob_height, skin=skin) {
    rim_width=0.8;
    defeather=0.01;
    
    length=lego_width(l)+2*rim_width-2*skin;
    width=lego_width(w)+2*rim_width-2*skin;
    height=lego_height(h);
    
    translate([skin-rim_width, skin-rim_width, height])
        difference() {
            cube([length, width, knob_height]);
            
            translate([rim_width, rim_width, -defeather])
                cube([length-2*rim_width, width-2*rim_width, knob_height+2*defeather]);
        }
}
