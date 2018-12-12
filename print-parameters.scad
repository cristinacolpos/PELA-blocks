/*
Parametric PELA Print Tuning Parameters

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Imported automatically into other design files when you include PELA_parameters:
    include <PELA_parameters.scad>
 

INSTRUCTIONS
============
1. Set 'flexible_material' and 'large_nozzle' below according to your printer.

2. Open 'PELA_calibration.scad' to generate and print the calibration .STL (In OpenSCAD press F6, then 'export').

3. Test fit the (a) top knobs, (b) bottom sockets, (c) technic holes on the side. These 3 numbers are your 'calibration'. Most slicer settings will not change the calibration for a given material, but use common sense and re-calibrate if needed.

4. Enter those numbers in this file.

5. Print a couple of 4x4 blocks with these adjusted parameters

6. Confirm your calibration fit with real PELA and between two printed blocks. All models will now adjust to this settings..


SUGGESTIONS
===========
- Don't waste time- use LEGO and LEGO technics to assemble what you need with a minimum of printed parts. Print the part yourself when you need something special (shape, function, material..).

- Make sure 'flexible_material' and 'large_nozzle' are set before you print the calibration block. These affect the size of flextures. All other numbers in this file are then set based on preference for a good fit of the calibration block to LEGO and other PELA pieces.

- Layer height is not important to PELA except for readable text on the sides of block

- Print PELA upright, or at up to 45 degrees tilt if needed. Avoid autogenerated supports inside the PELA block unless they are dissolvable.

- Printing fast is generally not a problem. PELA parts do need good inter-layer adhesion, so consider reducing the fan speed if this is a problem.

- Turn down the bed heater on low temperature materials like PLA to avoid "elephant foot" expansion of the bottom edges. Turn on 'brim, outside only' if you need more adhesion.

- Most printing materials are slippery. For this reason leave the top knobs at their default "taller than LEGO" setting to better grip. The downside is you can't push tall PELA knobs into a thin LEGO panel. You can adjust this in PELA-parmaeters.scad or in other cases disable knobs and focus on technic connections.

- Choose more flexible materials that are "tough" rather than stiff. TPU95 and Nylon are ideal and virtually indistructable. Brittle materials will not have as good a fit and may chip or crack. If you prefer PLA, you should try different brands- they vary considerably. Polymaker and Ultimaker PLA flex nicely.

- Smaller 0.4mm nozzles give better results. If 'large_nozzle' (>= 0.5mm) is true, the models will adjust the bottom socket geometry to make some of the inner structures thicker. If this is set wrong, then thin walls with a large nozzle may be eliminated by your slicer.

- See 'SLICER-RECOMMENDATIONS.md' for more tips and settings that have worked for us on specific materials.
*/

/* [Main Calibration Settings] */

// Switch between flexible and rigid material geometry. Set 'true' for Nylon, TPU (TPU95, Ninjaflex/TPU85), NGEN Semiflex and other flexible filaments. Subtle adjustments to part internal geometry will take advantage of this in flextures.
flexible_material = false;

// Set true if nozzle is >= 0.5mm. This simplifies the bottom gemoetry to create wider walls but at the cost of loosing the alternate bottom connector socket between every 4 other sockets. If not used with a large extruder the slicer may decimate features.
large_nozzle = true;

// Top knob size adjustment (larger is a stiffer fit, add in multiples of 0.01mm as determined from your calibration-block print)
top_tweak = -0.03; // -0.04 for ABS, 0.04 for rPET, -0.06 for Pro1, -0.08 for Polymaker Polylite PLA, -0.03 for NGEN, 0.02 for NGEN Flex, 0.09 for Ninjaflex, -0.02 for Bridge Nylon, 0.02 for Ultimaker TPU95A, 0.0 Biofila Silk

// Bottom connector size adjustment (smaller is tigher, add in multiples of 0.01mm as determined from your calibration-block print)
bottom_tweak = 0.08; // -0.02 for ABS, 0.10 for rPET, 0.08 for Pro1, 0.04 for Polymaker Polylite PLA, 0.08 for NGEN, 0.02 for NGEN Flex, -0.02 for Ninjaflex, 0.15 for Bridge Nylon, 0.04 for Ultimaker TPU95A, 0.0 Biofila Silk

// Side connector size adjustment (larger is a looser fit, add in multiples of 0.01mm as determined from your calibration-block print)
axle_hole_tweak = 0.05; // 0.05 for ABS, 0.04 for rPET, 0.04 for Pro1, 0.06 for Polymaker Polylite PLA, 0.05 for NGEN, 0 for NGEN Flex, 0.04 for Ninjaflex, 0.06 for Bridge Nylon, -0.06 for Ultimaker TPU95A, -0.04 Biofila Silk

// Generate print-time support aid structures for models which offer this. Turn this off if you will use slicer-generated print supports, but be aware that these may make the bottom connectors difficult to post process.
print_supports = true;

// In some models, the user will load two STL files into the slicer for a dual-material printer, one for each material/color. If "false" then the user wants a simplified, single material model
two_color_print = true;

// Add a text label to models which support that. The two_color_print setting will also affect if these is raised or colored text
text_labels = true;