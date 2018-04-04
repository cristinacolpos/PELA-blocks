/*
Parametric PELA Print Tuning Parameters

Published at http://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    http://futurice.com

Imported automatically into other design files when you include PELA_parameters:
    include <PELA_parameters.scad>
 

INSTRUCTIONS
============
1. Test print PELA_calibration.scad

2. Choose a fit with real PELA

3. Enter those  numbers here. Most commonly you only adjust the top_tweak, bottom_tweak
   and side_connector_tweak numbers to match for your current use case and
   material/printer/slicer settings. Add comment to this file to help remember what you
   have calibrated now and in the past.

4. Print a couple of 4x4 blocks with these adjusted parameters

5. Confirm your calibration fit with real PELA and between two printed blocks.

6. All other models in this set will automatically now be adjusted to use your calibration numbers.


SUGGESTIONS
===========
- Don't waste time- use high precision, injection-moulded PELA parts when they are suitable and available.

- Layer height is not paricularly important, you can use your "standard" setting.

- If needed for a good snap fit, slow down or make similar adjustments to show fine details
  and strong inter-layer adhesion (especially with flexible materials).

- Some printing materials are slippery, not very flexible, or subject to small chips breaking off. This
  can affect the fit and part lifeime. In such cases, look at other parameters such as knob_height and
  geometric flexture adjustments to avoid making your calibration is more tight than needed for your
  application.

- Smaller nozzles give better results. The models are adjusted to work on FFF nozzles up to about 0.6mm
  diameter.
  
- Be patient. You can achieve a great fit and make many things with blocks. 
*/

/* [Main Calibration Settings] */

// Switch between flexible and rigid material geometry. Set true for Nylon, Ninjaflex, NGEN Semiflex, Ultimaker TPU95A and other flexible filaments for taller knobs and other changes to maintain a better grip when flexed
flexible_material = false; 

// Set true if nozzle is >= 0.5mm. This simplifies the bottom gemoetry to create wider walls but at the cost of loosing the alternate bottom connector socket between every 4 other sockets. If not used with a large extruder the slicer may decimate features.
large_nozzle = true;

// Generate print-time support aid structures for models which offer this. Turn this off if you will use slicer-generated print supports, but be aware that these may make the bottom connectors difficult to post process.
print_supports = true;

// Top knob size adjustment (larger is a stiffer fit, add in multiples of 0.01mm as determined from your calibration-block print)
top_tweak = -0.05; // -0.04 for ABS, 0.04 for rPET, -0.06 for Pro1, -0.05 for Polymaker PLA, -0.03 for NGEN, 0.02 for NGEN Flex, 0.09 for Ninjaflex, -0.02 for Bridge Nylon, 0.02 for Ultimaker TPU95A

// Bottom connector size adjustment (smaller is tigher, add in multiples of 0.01mm as determined from your calibration-block print)
bottom_tweak = 0.04; // -0.02 for ABS, 0.10 for rPET, 0.08 for Pro1, 0.04 for Polymaker PLA, 0.06 for NGEN, 0.02 for NGEN Flex, -0.02 for Ninjaflex, 0.15 for Bridge Nylon, 0.02 for Ultimaker TPU95A

// Side connector size adjustment (larger is a looser fit, add in multiples of 0.01mm as determined from your calibration-block print)
axle_hole_tweak = 0.06; // 0.04 for ABS, 0.04 for rPET, 0.04 for Pro1, 0.06 for Polymaker PLA, 0.04 for NGEN, 0 for NGEN Flex, 0.04 for Ninjaflex, 0.06 for Bridge Nylon, 0.04 for Ultimaker TPU95A


/* [Shell Adjustments] */

// Thickness of the solid outside surface of the block
shell = large_nozzle ? 1.2 : 1.0;

// Thickness of the solid top surface of the block
top_shell = 1.5;


/* [Top Connector Adjustments] */

// Size of the top connectors (note that some plastics are more slippery or brittle than ABS and this may negatively affect results or part lifetime, the value below is tuned for Taz 6 with 0.5 nozzle, Lulzbot Cura default and NGEN)
knob_radius = 2.45 + 0.12 + top_tweak;

// Distance below knob top surface and the internal flexture
knob_top_thickness = 0.8;

// Height of the connectors (1.8 is original LEGO standard, 2 gives a stronger hold while still maintaining compatibility, flexible materials benefit from being taller)
knob_height = flexible_material ? 9.6/3 : 2.0;

// Size of the small flexture cavity inside each knob (set to 0 for flexible materials, if the knobs delaminate and detach, or to avoid holes if the knobs are removed)
knob_flexture_radius = flexible_material ? 1.0 : 1.0;

// Height of the easy connect slope near connector top (0 to disable such as for flexible materials, a bigger value such as 0.1 may help ease a tightly tuned fit or compensate for overextrusion)
knob_bevel = flexible_material ? 0.3 : 0.1;


/* [Bottom Connector Adjustments] */

// Bottom connector flexture ring wall thickness (note that some plastics are more slippery or brittle than ABS and this may negatively affect results or part lifetime, the value below is tuned for Taz 6 with 0.5 nozzle, Lulzbot Cura default and NGEN)
ring_thickness = large_nozzle ? 1.2 : 0.8;

// Bottom connector flexture ring size (note that some plastics are more slippery or brittle than ABS and this may negatively affect results or part lifetime, the value below is tuned for Taz 6 with 0.5 nozzle, Lulzbot Cura default and NGEN)
ring_radius = 2.75 + ring_thickness + bottom_tweak;

// Bottom connector additional distance from outside lock and connector rings which small flexture-fit rims protrude inwards to grab the base of knobs for asymmetric side pressure to assist with snap fit
side_lock_thickness = flexible_material ? 0.06 : 0.02;


/* [3D Printing Side Connector Adjustments] */

// Technic connector hole
axle_hole_radius = 2.45 + axle_hole_tweak;


/* [Print Supports] */

// Difference between the top and/or bottom of a support column to make columns easier to separate in post-processing (add this to your model only where desired - it is not done for you in support/support.scad)
support_offset_from_part = 0.1;

// Thickness of each rotating layer in a twisting support
support_layer_height = 2;

// Horizontal width of each side of a support triangle
support_line_width = large_nozzle ? 0.8 : 0.5;

// Length of sides of a support equilateral triangle
support_side_length = 4;

// Degrees to rotate for strength at each successive layer
support_layer_rotation = 6; // Degrees

// Max rotation before reversing direction to keep shape basically triangular but still strong (0 to disable)
support_max_rotation = 0; // Degrees
