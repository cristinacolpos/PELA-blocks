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

Imported automatically into other design files when you include lego_parameters:
    include <lego_parameters.scad>
 

INSTRUCTIONS
============
1. Test print lego_calibration.scad

2. Choose a fit with real LEGO

3. Enter those  numbers here. Most commonly you only adjust the top_tweak, bottom_tweak
   and side_connector_tweak numbers to match for your current use case and
   material/printer/slicer settings. Add comment to this file to help remember what you
   have calibrated now and in the past.

4. Print a couple of 4x4 blocks with these adjusted parameters

5. Confirm your calibration fit with real LEGO and between two printed blocks.

6. All other models in this set will automatically now be adjusted to use your calibration numbers.


SUGGESTIONS
===========
- Don't waste time- use high precision, injection-moulded LEGO parts when they are suitable and available.

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


/* [3D Printing Filament Adjustments] */

// Switch between flexible and rigid material geometry
flexible_material = false;

// Adjust gemoetry to aid the slicer when the minimum trace with is a problem (nozzle is > 0.5mm). Without this, some trace lines may too thin to reproduce reliably, for example in high speed or flexible material processing.
large_nozzle = true;

// Thickness of the solid outside surface of the block
shell=large_nozzle ? 1.2 : 1.0;

// Thickness of the solid top surface of the block
top_shell=1.4;

// Distance below knob top surface and the internal flexture
knob_top_thickness=0.8;


/* [3D Printing Top Connector Adjustments] */

// Top knob size adjustment (larger is a stiffer fit, add in multiples of 0.01mm as determined from your calibration-block print)
top_tweak = 0;

// Size of the top connectors (note that some plastics are more slippery or brittle than ABS and this may negatively affect results or part lifetime, the value below is tuned for Taz 6 with 0.5 nozzle, Lulzbot Cura default and NGEN)
knob_radius=2.45 + 0.11 + top_tweak;

// Height of the connectors (1.8 is Lego standard, 2 may give a stronger hold while still maintaining compatibility)
knob_height=flexible_material ? 9.6/3 : 1.8;

// Size of the small flexture cavity inside each knob (default is 1.4, set to 0 for flexible materials)
knob_flexture_radius=flexible_material ? 0.0 : 1.4;

// Height of the easy connect slope near connector top (0 to disable such as for flexible materials, a bigger value such as 0.1 may help ease a tightly tuned fit or compensate for overextrusion)
knob_bevel=flexible_material ? 0.3 : 0.0;


/* [3D Printing Bottom Connector Adjustments] */

// Bottom connector size adjustment (larger is a stiffer fit, add in multiples of 0.01mm as determined from your calibration-block print)
bottom_tweak = 0;

// Bottom connector flexture ring size (note that some plastics are more slippery or brittle than ABS and this may negatively affect results or part lifetime, the value below is tuned for Taz 6 with 0.5 nozzle, Lulzbot Cura default and NGEN)
ring_radius=3.35 + bottom_tweak;

// Bottom connector flexture ring size (note that some plastics are more slippery or brittle than ABS and this may negatively affect results or part lifetime, the value below is tuned for Taz 6 with 0.5 nozzle, Lulzbot Cura default and NGEN)
ring_thickness=0.6;

// Base distance which small stiffeners protrude inwards from outside shell edges of a block to hold the knobs of any block below
outside_lock_thickness=1.44 + bottom_tweak;

// Additional distance from outside lock and connector rings which small flexture-fit rims protrude inwards to grab the base of knobs for asymmetric side pressure to assist a snap fit
side_lock_thickness=0.02;


/* [3D Printing Side Connector Adjustments] */

// Side connector size adjustment (larger is a looser fit, add in multiples of 0.01mm as determined from your calibration-block print)
axle_hole_tweak = 0;

// Technic connector hole
axle_hole_radius = 2.45 + 0.02 + axle_hole_tweak;
