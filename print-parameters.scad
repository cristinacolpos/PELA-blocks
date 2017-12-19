/*
Parametric LEGO Print Tuning Parameters

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

/* [3D Printing Bottom Connector Adjustments] */

// Bottom connector flexture ring size (note that some plastics are more slippery or brittle than ABS and this may negatively affect results or part lifetime, the value below is tuned for Taz 6 with 0.5 nozzle, Lulzbot Cura default and NGEN)
ring_radius=3.25 - 0.1;

// Base distance which small stiffeners protrude inwards from outside shell edges of a block to hold the knobs of any block below
outside_lock_thickness=1.44;

// Additional distance from outside lock and connector rings which small flexture-fit rims protrude inwards to grab the base of knobs for asymmetric side pressure to assist a snap fit
side_lock_thickness=0.02;



/* [3D Printing Top Connector Adjustments] */

// Size of the top connectors (note that some plastics are more slippery or brittle than ABS and this may negatively affect results or part lifetime, the value below is tuned for Taz 6 with 0.5 nozzle, Lulzbot Cura default and NGEN)
knob_radius=2.45 + 0.12;

// Height of the easy connect slope near connector top (0 to disable, a bigger value such as 0.1 may help ease a tightly tuned fit or compensate for overextrusion)
knob_bevel=0.1;



/* [3D Printing Side Connector Adjustments] */

// Technic connector hole
axle_hole_radius = 2.47;
