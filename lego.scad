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

include <lego_parameters.scad>

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

// A LEGO block with optional side and top vent holes
module lego_technic(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, top_vents=top_vents, side_holes=side_holes, end_holes=end_holes, bearing_hole_radius=bearing_hole_radius, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio, ring_radius=ring_radius, ring_thickness=ring_thickness, socket_height=socket_height, knob_flexture_airhole_radius=knob_flexture_airhole_radius, skin=skin, block_shell=block_shell, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_stiffener_thickness=side_stiffener_thickness, bolt_holes=bolt_holes, ridge_width=ridge_width, ridge_depth=ridge_depth, fn=fn, airhole_fn=airhole_fn);

    difference() {
        union() {
            lego(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio, ring_radius=ring_radius, ring_thickness=ring_thickness, socket_height=socket_height, knob_flexture_airhole_radius=knob_flexture_airhole_radius, skin=skin, block_shell=block_shell, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_stiffener_thickness=side_stiffener_thickness, bolt_holes=bolt_holes, ridge_width=ridge_width, ridge_depth=ridge_depth, fn=fn, airhole_fn=airhole_fn);
            
            if (side_hole_sheaths>0 && side_holes>0) {
                side_connector_sheath_set(l=l, w=w, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak, technic_bearing_length=technic_bearing_length, block_width=block_width, skin=skin, fn=fn);
            }
        }
            
        union() {
            if (side_holes>0 || end_holes>0) {
                
            }
            
            if (side_holes>0) {
                side_connector_hole_set(l=l, w=w, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak, block_width=block_width, fn=fn);
            }
            
            if (end_holes>0) {
                end_connector_hole_set(l=l, w=w, top_tweak=top_tweak, knob_radius=knob_radius, block_width=block_width, fn=fn);
            }
            
            if (top_vents>0) {
                top_vent_set(l=l, w=w, h=h, top_tweak=top_tweak, top_vents=top_vents, fn=fn);
            }
        }
}


// A row of knob-size holes around the sides of row 1
module side_connector_sheath_set(l=l, w=w, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak, technic_bearing_length=technic_bearing_length, technic_sheath_thickness=technic_sheath_thickness, block_width=block_width, skin=skin, fn=fn) {
    
    if (l==1) {
        translate([lego_width(0.5), skin, lego_height(1)-lego_width(0.5)])
            rotate([-90, 0, 0])
                technic_bearing_sheath(length=technic_bearing_length, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak, technic_sheath_thickness=technic_sheath_thickness, fn=fn);        

        translate([lego_width(0.5), lego_width(1)-skin, lego_height(1)-lego_width(0.5)])
            rotate([90, 0, 0])
                technic_bearing_sheath(length=technic_bearing_length, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak, technic_sheath_thickness=technic_sheath_thickness, fn=fn);        
    } else {
        for (i = [1:l-1]) {
            translate([lego_width(i), skin, lego_height(1)-lego_width(0.5)])
                rotate([-90, 0, 0])
                    technic_bearing_sheath(length=technic_bearing_length, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak, technic_sheath_thickness=technic_sheath_thickness, fn=fn);

            translate([lego_width(i), lego_width(w)-skin, lego_height(1)-lego_width(0.5)])
                rotate([90, 0, 0])
                    technic_bearing_sheath(length=technic_bearing_length, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak, technic_sheath_thickness=technic_sheath_thickness, fn=fn);
        }
    }
}


// The primary hole for a Technic side connector
module technic_bearing_sheath(length=technic_bearing_length, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak, technic_sheath_thickness=technic_sheath_thickness, fn=fn) {
    
    cylinder(r=technic_sheath_thickness+bearing_hole_radius+bearing_hole_tweak, h=length, $fn=fn);
}


// A row of knob-size holes around the sides of row 1
module side_connector_hole_set(l=l, w=w, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak, block_width=block_width, fn=fn) {
    
    if (l==1) {
        translate([lego_width(0.5), 0, lego_height(1)-lego_width(0.5)])
            rotate([-90, 0, 0])
                technic_connector_hole(hole_type=side_holes, length=lego_width(w), bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak);
        
    } else {
        for (i = [1:l-1]) {
            translate([lego_width(i), 0, lego_height(1)-lego_width(0.5)])
                rotate([-90, 0, 0])
                    technic_connector_hole(hole_type=side_holes, length=lego_width(w),  bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak);
        }
    }
}

// A row of knob-size holes around the sides of row 1
module end_connector_hole_set(l=l, w=w, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak, block_width=block_width, fn=fn) {
    
    if (w==1) {
        if (l>1) {
            translate([0, lego_width(0.5), lego_height(1)-lego_width(0.5)])
                rotate([0, 90, 0])
                    technic_connector_hole(hole_type=end_holes, length=block_shell, bearing_hole_tweak=bearing_hole_tweak, bearing_hole_radius=bearing_hole_radius);
        }
    } else {
        for (i = [1:w-1]) {
            translate([0, lego_width(i), lego_height(1)-lego_width(0.5)]) {
                rotate([0, 90, 0])
                    technic_connector_hole(hole_type=end_holes, length=lego_width(1), bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak);
                
                translate([lego_width(l), 0, 0])
                    rotate([0, -90, 0])
                        technic_connector_hole(hole_type=end_holes, length=lego_width(1), bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak);
            }
        }
    }
}


// The primary hole for a Technic side connector
module technic_connector_hole(hole_type=side_holes, length=block_width, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak, fn=fn) {
    
    bearing_hole(length=length, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak, fn=fn);

    if (hole_type>1) {
        bearing_inset(bearing_inset_depth=bearing_inset_depth, bearing_inset_radius=bearing_inset_radius, bearing_hole_tweak=bearing_hole_tweak, fn=fn);
        
        translate([0, 0, length-bearing_inset_depth])
            bearing_inset(bearing_inset_depth=bearing_inset_depth, bearing_inset_radius=bearing_inset_radius, bearing_hole_tweak=bearing_hole_tweak, fn=fn);
    
        if (hole_type>2) {
            translate([0, 0, technic_bearing_length])
                bearing_inset(bearing_inset_depth=bearing_inset_depth+bearing_inset_depth_clearance, bearing_inset_radius=bearing_inset_radius, bearing_hole_tweak=bearing_hole_tweak, fn=fn);

            translate([0, 0, length-bearing_inset_depth-bearing_inset_depth_clearance-technic_bearing_length])
                bearing_inset(bearing_inset_depth=bearing_inset_depth+bearing_inset_depth_clearance, bearing_inset_radius=bearing_inset_radius, bearing_hole_tweak=bearing_hole_tweak, fn=fn);
        }
    }
}


// The primary hole for a Technic side connector
module bearing_hole(length=block_width, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak, fn=fn) {
    
    cylinder(r=bearing_hole_radius+bearing_hole_tweak, h=length, $fn=fn);
}

// The connector inset for a Technic side connector
module bearing_inset(bearing_inset_depth=bearing_inset_depth,bearing_inset_radius=bearing_inset_radius, bearing_hole_tweak=bearing_hole_tweak, fn=fn) {
    
    cylinder(r=bearing_inset_radius+bearing_hole_tweak, h=bearing_inset_depth, $fn=fn);
}

// Additional holes in the top surface and opiontally also in top knobs
module top_vent_set(lw=l, w=w, h=h, top_tweak=top_tweak, knob_radius=knob_radius, top_vents=top_vents, fn=fn) {
    //TODO XXXXXXXXXXXXXXXXXXXXXX
    
    
}

module top_vent() {
    // TODO XXXXXXXXXXXXXXXX
}

// A LEGO block
module lego(l=l, w=w, h=h, top_tweak=top_tweak, bottom_tweak=bottom_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio, ring_radius=ring_radius, ring_thickness=ring_thickness, socket_height=socket_height, knob_flexture_airhole_radius=knob_flexture_airhole_radius, skin=skin, block_shell=block_shell, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_stiffener_thickness=side_stiffener_thickness, bolt_holes=bolt_holes, ridge_width=ridge_width, ridge_depth=ridge_depth, fn=fn, airhole_fn=airhole_fn) {
    
    difference() {
        union() {
            block_shell(l=l, w=w, h=h, fn=fn, block_shell=block_shell);

            block_set(l=l, w=w, h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_bevel=knob_bevel, fn=fn);
                
            socket_set(l=l, w=w, ring_radius=ring_radius, ring_thickness=ring_thickness, socket_height=socket_height, bottom_tweak=bottom_tweak, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_stiffener_thickness=side_stiffener_thickness, skin=skin, fn=fn);
        }

        union() {
            skin(l=l, w=w, h=h, skin=skin, ridge_width=ridge_width, ridge_depth=ridge_depth);
            
            knob_flexture_set(l=l, w=w, h=h, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_flexture_airhole_radius=knob_flexture_airhole_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio, fn=fn, airhole_fn=airhole_fn);
                
            socket_hole_set(l=l, w=w, ring_radius=ring_radius, ring_thickness=ring_thickness, socket_height=socket_height, bottom_tweak=bottom_tweak, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, side_stiffener_thickness=side_stiffener_thickness, skin=skin, fn=fn);

            
            if (is_true(bolt_holes)) {
                corner_bolt_holes(l=l, w=w, h=h, top_tweak=top_tweak, fn=fn);
            }
        }
    }
}


// Several blocks in a grid, one knob per block
module block_set(l=l, w=w, h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_bevel=knob_bevel, fn=fn) {
    for (i = [0:1:l-1]) {
        for (j = [0:1:w-1]) {
            translate([lego_width(i), lego_width(j), 0])
                top_knob(h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_bevel=knob_bevel, fn=fn);
        }
    }
}


// The rectangular part of the the lego plus the knob
module top_knob(h=h, top_tweak=top_tweak, knob_height=knob_height, knob_bevel=knob_bevel, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, fn=fn) {
    
    //cube([lego_width(), lego_width(), lego_height(h)]);
    translate([lego_width(0.5), lego_width(0.5), lego_height(h)])
        knob(top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_bevel=knob_bevel, fn=fn);
}


// The cylinder on top of a lego block
module knob(top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_bevel=knob_bevel, fn=fn) {
    
    cylinder(r=knob_radius+top_tweak, h=knob_height-knob_bevel, $fn=fn);
    if (knob_bevel > 0) {
        // This path is a bit slower, but does the same thing as the bath below for the most common case of knob_bevel==0
        translate([0, 0, knob_height-knob_bevel])
            intersection() {
                cylinder(r=knob_radius+top_tweak,h=knob_bevel, $fn=fn);
                cylinder(r1=knob_radius+top_tweak,r2=0,h=1.5*(knob_radius+top_tweak), $fn=fn);
            }
    }
}

// An array of empty cylinders to fit inside a knob_set()
module knob_flexture_set(l=l, w=w, h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_flexture_airhole_radius=knob_flexture_airhole_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio, fn=fn, airhole_fn=airhole_fn) {

    for (i = [0:l-1]) {
        for (j = [0:w-1]) {
            translate([lego_width(i+0.5), lego_width(j+0.5), lego_height(h)])
                knob_flexture(h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_flexture_airhole_radius=knob_flexture_airhole_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio, fn=fn, airhole_fn=airhole_fn);
        }
    }
}


// The empty cylinder inside a knob
module knob_flexture(h=h, top_tweak=top_tweak, knob_radius=knob_radius, knob_height=knob_height, knob_flexture_height=knob_flexture_height, knob_flexture_radius=knob_flexture_radius, knob_flexture_airhole_radius=knob_flexture_airhole_radius, knob_slice_count=knob_slice_count, knob_slice_width=knob_slice_width, knob_slice_length_ratio=knob_slice_length_ratio, fn=fn, airhole_fn=airhole_fn) {

    translate([0, 0, knob_height-knob_top_thickness-knob_flexture_height])
        cylinder(r=knob_flexture_radius, h=knob_flexture_height, $fn=airhole_fn);
    if (knob_flexture_airhole_radius>0.01 || (knob_flexture_airhole_radius>0 && h>1)) {
        translate([0, 0, knob_height-knob_top_thickness])
            cylinder(r=knob_flexture_airhole_radius, h=knob_height+0.1, $fn=airhole_fn);
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
module socket_set(l=l, w=w, ring_radius=ring_radius, ring_thickness=ring_thickness, socket_height=socket_height, bottom_tweak=bottom_tweak, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, skin=skin, fn=fn) {
    
    if (socket_height > 0) {
        bottom_stiffener_bar_set(l=l, w=w, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, skin=skin);
                    
        side_stiffener_bar_set(l=l, w=w, bock_shell=block_shell, side_stiffener_width=side_stiffener_width, side_stiffener_thickness=side_stiffener_thickness);
                    
        if (l>1 && w>1) {
            for (i = [1:l-1]) {
                for (j = [1:w-1]) {
                    translate([lego_width(i), lego_width(j), 0])
                        socket_ring(ring_radius=ring_radius, bottom_tweak=bottom_tweak, fn=fn);
                }
            }
        }
    }
}


// Bottom connector- negative flexture space inside bottom rings for multiple blocks
module socket_hole_set(l=l, w=w, ring_radius=ring_radius, ring_thickness=ring_thickness, socket_height=socket_height, bottom_tweak=bottom_tweak, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, skin=skin, fn=fn) {
    
    if (socket_height > 0) {
        if (l>1 && w>1) {
            for (i = [1:l-1]) {
                for (j = [1:w-1]) {
                    translate([lego_width(i), lego_width(j), 0])
                        socket_ring_inner_cylinder(ring_radius=ring_radius, ring_thickness=ring_thickness, socket_height=socket_height, bottom_tweak=bottom_tweak, fn=fn);
                }
            }
        }
    }
}


// The circular bottom insert for attaching knobs
module socket_ring(ring_radius=ring_radius, bottom_tweak=bottom_tweak, fn=fn) {
    cylinder(r=ring_radius+bottom_tweak, h=socket_height, $fn=fn);
}


// The negative space inside the circular bottom insert for attaching knobs
module socket_ring_inner_cylinder(ring_radius=ring_radius, ring_thickness=ring_thickness, socket_height=socket_height, bottom_tweak=bottom_tweak, fn=fn) {

    technic_connector_hole(hole_type=1, length=socket_height, bearing_hole_radius=bearing_hole_radius, bearing_hole_tweak=bearing_hole_tweak, fn=fn);
}


// Bars layed below (or above) a horizontal surface to make it stronger
module bottom_stiffener_bar_set(start_l=1, end_l=l-1, start_w=1, end_w=w-1, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, skin=skin) {
    
    translate([0, 0, socket_height-bottom_stiffener_height])
        stiffener_bar_set(start_l=start_l, end_l=end_l, start_w=start_w, end_w=end_w, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, skin=skin);
}


// Bars layed below (or above) a horizontal surface to make it stronger. Usually these are on the bottom, between the connecting rings
module stiffener_bar_set(start_l=1, end_l=l-1, start_w=1, end_w=w-1, bottom_stiffener_width=bottom_stiffener_width, bottom_stiffener_height=bottom_stiffener_height, skin=skin) {
    
    for (i = [start_l:end_l]) {
        offset = i==0 ? bottom_stiffener_width/2+lego_skin_width(skin=skin) : (i==l ? -bottom_stiffener_width/2-lego_skin_width(skin=skin) : 0);
        translate([lego_width(i)+offset-bottom_stiffener_width/2, 0, 0])
            cube([bottom_stiffener_width, lego_width(w), bottom_stiffener_height]);
    }
    
    for (j = [start_w:end_w]) {
        offset = j==0 ? bottom_stiffener_width/2+lego_skin_width(skin=skin) : (j==w ? -bottom_stiffener_width/2-lego_skin_width(skin=skin) : 0);
translate([0, lego_width(j)+offset-bottom_stiffener_width/2, 0])
            cube([lego_width(l), bottom_stiffener_width, bottom_stiffener_height]);
    }    
}


// Bars layed below (or above) a horizontal surface to make it stronger. Usually these are on the bottom, between the connecting rings
module side_stiffener_bar_set(l=l, w=w, bock_shell=block_shell, side_stiffener_width=side_stiffener_width, side_stiffener_thickness=side_stiffener_thickness) {
    
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
    cube([lego_width(l), lego_skin_width(skin=skin), lego_height(h)]);

    // Back skin
    translate([0, lego_width(w) - lego_skin_width(skin=skin), 0])
        cube([lego_width(l), lego_skin_width(skin=skin), lego_height(h)]);

    // Left skin
    cube([lego_skin_width(skin=skin), lego_width(w), lego_height(h)]);
    
    // Right skin
    translate([lego_width(l)-lego_skin_width(skin=skin), 0, 0])
        cube([lego_skin_width(skin=skin), lego_width(w), lego_height(h)]);
    
    if (ridge_width>0 && h>1) {
        for (i = [1:h-1]) {
            // Front layer ridge
            translate([0, 0, lego_height(i)])
                cube([lego_width(l), ridge_depth, ridge_width]);
                
            // Back layer ridge
            translate([0, lego_width(w) - lego_skin_width(skin=skin) - ridge_depth, lego_height(i)])
                cube([lego_width(l), ridge_depth, ridge_width]);

            // Left layer ridge
            translate([lego_skin_width(skin=skin), 0, lego_height(i)])
                cube([ridge_depth, lego_width(w), ridge_width]);

            // Right layer ridge
            translate([lego_width(l) - lego_skin_width(skin=skin) - ridge_depth, 0, lego_height(i)])
                cube([ridge_depth, lego_width(w), ridge_width]);
        }
    }
}


// Mounting holes
module corner_bolt_holes(l=l, w=w, h=h, top_tweak=top_tweak, fn=fn) {
    bolt_hole(l=1, w=1, h=h, top_tweak=top_tweak, fn=fn);
    bolt_hole(l=1, w=w, h=h, top_tweak=top_tweak, fn=fn);
    bolt_hole(l=l, w=1, h=h, top_tweak=top_tweak, fn=fn);
    bolt_hole(l=l, w=w, h=h, top_tweak=top_tweak, fn=fn);
}


// A hole for a mounting bolt in the corners of a panel or block
module bolt_hole(l=l, w=w, h=h, top_tweak=top_tweak, fn=fn) {
    translate([lego_width(l-0.5), lego_width(w-0.5), 0])
        cylinder(r=bearing_hole_radius, h=lego_height(h+1), $fn=fn);
}
