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
    lego(knob_height=0, knob_bevel=0, knob_flexture_radius=0, knob_flexture_airhole_radius=0);
} else if (mode==3) {
    // Block without bottom sockets
    lego(socket_height=0);
} else if (mode==4) {
    // Block without top knobs or bottom sockets
    lego(socket_height=0, knob_height=0, knob_bevel=0, knob_flexture_radius=0, knob_flexture_airhole_radius=0);
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

/////////////////////////////////////
// MODULES
/////////////////////////////////////



// A LEGO block
module lego(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio, ring_radius=ring_radius, socket_height=socket_height, knob_flexture_airhole_radius=knob_flexture_airhole_radius, skin=skin, block_shell=block_shell, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_stiffener_thickness=side_stiffener_thickness, bolt_holes=bolt_holes, bolt_hole_radius=bolt_hole_radius, ridge_width=ridge_width, ridge_depth=ridge_depth, solid_upper_layers=solid_upper_layers) {
    
    difference() {
        union() {
            block_shell(l=l, w=w, h=h, block_shell=block_shell);

            top_knob_set(l=l, w=w, h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_bevel=knob_bevel, bolt_holes=bolt_holes);
                
            bar_set(l=l, w=w, h=h, ring_radius=ring_radius, socket_height=socket_height, bottom_tweak=bottom_tweak, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, skin=skin);
                
            socket_set(l=l, w=w, ring_radius=ring_radius, socket_height=socket_height, bottom_tweak=bottom_tweak, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_stiffener_thickness=side_stiffener_thickness, skin=skin);
            
            if (is_true(bolt_holes)) {
                corner_bolt_hole_supports(l=l, w=w, h=h);
            }
            
            if (h>1 && is_true(solid_upper_layers)) {
                fill_upper_layers(l=l, w=w, h=h);
            }
        }

        union() {
            skin(l=l, w=w, h=h, skin=skin, ridge_width=ridge_width, ridge_depth=ridge_depth);
            
            knob_flexture_set(l=l, w=w, h=h, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_flexture_airhole_radius=knob_flexture_airhole_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio, bolt_holes=bolt_holes);
                
            socket_hole_set(l=l, w=w, ring_radius=ring_radius, socket_height=socket_height, bottom_tweak=bottom_tweak, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_stiffener_thickness=side_stiffener_thickness, skin=skin);
            
            if (is_true(bolt_holes)) {
                corner_bolt_holes(l=l, w=w, h=h, bolt_hole_radius=bolt_hole_radius);
            }
        }
    }
}

module fill_upper_layers(l=l, w=w, h=h) {
    translate([0, 0, lego_height()])
        cube([lego_width(l), lego_width(w), lego_height(h-1)]);
}

// Additional holes in the top surface and opiontally also in top knobs
module top_vent_set(l=l, w=w, h=h, top_tweak=top_tweak, knob_radius=knob_radius, top_vents=top_vents) {
    //TODO XXXXXXXXXXXXXXXXXXXXXX
    
    
}

module top_vent() {
    // TODO XXXXXXXXXXXXXXXX
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
module top_knob(h=h, top_tweak=top_tweak, knob_height=knob_height, knob_bevel=knob_bevel, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width) {
    
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
module knob_flexture_set(l=l, w=w, h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_flexture_airhole_radius=knob_flexture_airhole_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio, bolt_holes=bolt_holes) {

    for (i = [0:l-1]) {
        for (j = [0:w-1]) {
            if (!is_true(bolt_holes) || !is_corner(x=i, y=j, l=l, w=w)) {
                translate([lego_width(i+0.5), lego_width(j+0.5), lego_height(h)])
                    knob_flexture(h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_flexture_airhole_radius=knob_flexture_airhole_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio);
            }
        }
    }
}


// The negative space flexture inside a knob
module knob_flexture(h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_flexture_airhole_radius=knob_flexture_airhole_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio) {

   translate([0, 0, knob_height-knob_top_thickness-knob_flexture_height])
        cylinder(r=knob_flexture_radius, h=knob_flexture_height);
    
    if (knob_flexture_airhole_radius>0) {
        translate([0, 0, knob_height-knob_top_thickness])
            cylinder(r=knob_flexture_airhole_radius, h=knob_height+0.1);
    }
    
    if (knob_slice_count > 0) {
        angle_delta=360/knob_slice_count;
        for (i = [1:knob_slice_count]) {
            angle = (i-1)*angle_delta + 360/(2*knob_slice_count);
            
            rotate([0,0,angle])
                translate([0, -knob_slice_width/2, 0])
                    cube([(knob_radius+top_tweak)*knob_slice_length_ratio, knob_slice_width, knob_height-knob_top_thickness]);
        }
    }
}


// That solid outer skin of a block set
module block_shell(l=l, w=w, h=h, block_shell=block_shell) {
    cube([block_shell, lego_width(w), lego_height(h)]);
    translate([lego_width(l)-block_shell, 0, 0]) 
        cube([block_shell, lego_width(w), lego_height(h)]);
    
    cube([lego_width(l), block_shell, lego_height(h)]);
    translate([0, lego_width(w)-block_shell, 0])
        cube([lego_width(l), block_shell, lego_height(h)]);
    
    translate([0, 0, lego_height(h)-block_shell])
        cube([lego_width(l), lego_width(w), block_shell]);
}


// Bottom connector rings positive space for multiple blocks
module bar_set(l=l, w=w, ring_radius=ring_radius, socket_height=socket_height, bottom_tweak=bottom_tweak, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, skin=skin) {
    
    if (socket_height > 0) {
        bottom_stiffener_bar_set(start_l=1, end_l=l-1, start_w=1, end_w=w-1, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, skin=skin);
                    
        side_stiffener_bar_set(l=l, w=w, h=h, bock_shell=block_shell, side_stiffener_width=side_stiffener_width, side_stiffener_thickness=side_stiffener_thickness);
    }
}


// Bottom connector rings positive space for multiple blocks
module socket_set(l=l, w=w, ring_radius=ring_radius, socket_height=socket_height, bottom_tweak=bottom_tweak, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, skin=skin) {
    
    if (socket_height > 0 && l>1 && w>1) {
        for (i = [1:l-1]) {
            for (j = [1:w-1]) {
                translate([lego_width(i), lego_width(j), 0])
                    socket_ring(ring_radius=ring_radius, bottom_tweak=bottom_tweak);
            }
        }
    }
}


// Bottom connector- negative flexture space inside bottom rings for multiple blocks
module socket_hole_set(l=l, w=w, ring_radius=ring_radius, socket_height=socket_height, bottom_tweak=bottom_tweak, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, skin=skin) {
    
    if (socket_height > 0) {
        if (l>1 && w>1) {
            for (i = [1:l-1]) {
                for (j = [1:w-1]) {
                    translate([lego_width(i), lego_width(j), 0])
                        socket_ring_inner_cylinder(ring_radius=ring_radius, socket_height=socket_height, bottom_tweak=bottom_tweak);
                }
            }
        }
    }
}


// The circular bottom insert for attaching knobs
module socket_ring(ring_radius=ring_radius, bottom_tweak=bottom_tweak) {
    cylinder(r=ring_radius+bottom_tweak, h=socket_height);
}


// The negative space inside the circular bottom insert for attaching knobs
module socket_ring_inner_cylinder(ring_radius=ring_radius, socket_height=socket_height, bottom_tweak=bottom_tweak) {

    rotation_hole(hole_type=1, length=socket_flexture_height, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak);
}


// Bars layed below (or above) a horizontal surface to make it stronger
module bottom_stiffener_bar_set(l=l, w=w, start_l=1, end_l=l-1, start_w=1, end_w=w-1, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, skin=skin) {
    
    translate([0, 0, socket_height-bottom_stiffener_height])
        stiffener_bar_set(l=l, w=w, start_l=start_l, end_l=end_l, start_w=start_w, end_w=end_w, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, skin=skin);
}


// Bars layed below (or above) a horizontal surface to make it stronger. Usually these are on the bottom, between the connecting rings
module stiffener_bar_set(l=l, w=w, start_l=1, end_l=l-1, start_w=1, end_w=w-1, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, skin=skin) {
    
    for (i = [start_l:end_l]) {
        offset = i==0 ? bottom_stiffener_width/2+skin : (i==l ? -bottom_stiffener_width/2-skin : 0);
        
        cut_width = (i==0 || i==l) ? 0 : bottom_stiffener_width/2;
        
        translate([lego_width(i)+offset-bottom_stiffener_width/2, 0, 0])
            difference() {
                cube([bottom_stiffener_width, lego_width(w), bottom_stiffener_height]);
                
                translate([bottom_stiffener_width/4, 0, 0])
                    cube([bottom_stiffener_width/2, lego_width(w), bottom_stiffener_height]);
            }
    }
    
    for (j = [start_w:end_w]) {
        offset = j==0 ? bottom_stiffener_width/2+skin : (j==w ? -bottom_stiffener_width/2-skin : 0);

        cut_width = (j==0 || j==w) ? 0 : bottom_stiffener_width/2;

        translate([0, lego_width(j)+offset-bottom_stiffener_width/2, 0])
            difference() {
                cube([lego_width(l), bottom_stiffener_width, bottom_stiffener_height]);
                
                translate([0, bottom_stiffener_width/4, 0])
                    cube([lego_width(l), bottom_stiffener_width/2, bottom_stiffener_height]);
            }
    }    
}


// Bars layed below (or above) a horizontal surface to make it stronger. Usually these are on the bottom, between the connecting rings
module side_stiffener_bar_set(l=l, w=w, h=h, bock_shell=block_shell, side_stiffener_width=side_stiffener_width, side_stiffener_thickness=side_stiffener_thickness) {
    
    if (l>1) {
        for (i = [1:l]) {
            // Front vertical stiffeners
            translate([lego_width(i-0.5)-side_stiffener_width/2, 0, 0])
                cube([side_stiffener_width, block_shell+side_stiffener_thickness, lego_height(h)]);

            // Back vertical stiffeners
            translate([lego_width(i-0.5)-side_stiffener_width/2, lego_width(w)-side_stiffener_thickness-block_shell, 0])
                cube([side_stiffener_width, block_shell+side_stiffener_thickness, lego_height(h)]);
        }
    }

    if (w>1) {
        for (j = [1:w]) {
            // Left vertical stiffeners
            translate([0, lego_width(j-0.5)-side_stiffener_width/2, 0])
                cube([block_shell+side_stiffener_thickness, side_stiffener_width, lego_height(h)]);
            
            // Right vertical stiffeners
            translate([lego_width(l)-side_stiffener_thickness-block_shell, lego_width(j-0.5)-side_stiffener_width/2, 0])
                cube([block_shell+side_stiffener_thickness, side_stiffener_width, lego_height(h)]);
        }
    }    
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


// Hole for a bearing
module rotation_hole(length=block_width, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak) {
    
    cylinder(r=bearing_hole_radius+bearing_hole_tweak, h=length);
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
module corner_bolt_hole_supports(l=l, w=w, h=h) {
    bolt_hole_support(x=1, y=1, h=h);
    bolt_hole_support(x=1, y=w, h=h);
    bolt_hole_support(x=l, y=1, h=h);
    bolt_hole_support(x=l, y=w, h=h);
}


module bolt_hole_support(x=1, y=1, h=h) {
    depth = block_shell+bottom_stiffener_height;
    
    translate([lego_width(x-1), lego_width(y-1), lego_height(h)-depth])
        cube([lego_width(), lego_width(), depth]);
}