/*
PELA Blocks 3D Print Calibration Block Set

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-technic-block.scad>
use <../PELA-block.scad>
include <PELA-calibration-set.scad>


/* [PELA Calibration Set Options] */

flexible_material = false;

large_nozzle = true;


/////////////////////////////////////
// PELA Calibration Set Display
/////////////////////////////////////

PELA_calibration_set(flexible_material=flexible_material, large_nozzle=large_nozzle);