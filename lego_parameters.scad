/*
Parametric LEGO Block Parameters

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

Import this into other design files to set baseline constants:
    include <lego_parameters.scad>
*/

/* [LEGO Options] */

// What type of object to generate: 1=>block, 2=>block without top knobs, 3=>block without bottom connector, 4=> block with increased bottom airflow
mode=1;

// Length of the block (LEGO knob count)
l = 3; 

// Width of the block (LEGO knob count)
w = 3;

// Height of the block (LEGO brick layer count)
h = 1;

// Top connector size tweak => + = more tight fit, -0.04 for PLA, 0 for ABS, 0.07 for NGEN
top_tweak = 0.06;

// Bottom connector size tweak => + = more tight fit, 0.04 for PLA, 0 for ABS, -0.01 NGEN
bottom_tweak = -0.03;

// Number of facets to form a circle (big numbers are more round which affects fit, but may take a long time to render)
fn=64;

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0;

// Clearance space on the outer surface of bricks
skin = 0; 

// Height and depth of a line etched in the side of multi-layer block sets (0 to disable)
layer_ridge = 0.1;

// Depth of a line etched in the side of multi-layer block sets
layer_ridge_depth = 0.3;

// Size of the connectors
knob_radius=2.4;

// Height of the connectors including any bevel (1.8 is Lego standard, longer gives a stronger hold which helps since 3D prints are less precise)
knob_height=2.4;

// Height of the easy connect slope near connector top (0 to disable is standard a slightly faster to generate the model, a bigger value such as 0.3 may help if you adjust a tight fit but most printers' slicers will simplify away most usable bevels)
knob_bevel=0.4;

// Size of the small flexture cavity inside each connector
knob_cutout_radius=1.25;

// Distance below knob top surface and the internal cutout
knob_top_thickness=1;

// Height of the hole beneath each knob
knob_cutout_height=4.55;

// Size of a hole in the top of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
knob_cutout_airhole_radius=0;

// Number of side to simulate a circle in the air hole and (smaller numbers render faster and are usually sufficient)
airhole_fn=16;

// Number of flexture cuts across the top of the knob
knob_slice_count=4;

// Width of flexture cuts accross the top of the knob
knob_slice_width=0.15;

// Depth which connectors may press into part bottom
socket_height=8.2;

// Bottom connector assistance ring size
ring_radius=3.25;

// Bottom connector assistance ring thickness
ring_thickness=0.6;

// Width of horizontal surface strengthening slats (usually between the bottom rings)
stiffener_width=0.6;

// Height of horizontal surface strengthening slats (appears between the bottom rings and usually half of socket_height)
stiffener_height=2.4;

// Distance from inside walls which small stiffeners protrude inwards
side_stiffener_thickness=0.2;

// Basic unit horizonal size of LEGO
block_width=8;

// Basic unit vertial size of LEGO
block_height=9.6;

// Thickness of the solid outside surface of LEGO
block_shell=1.3; // thickness
