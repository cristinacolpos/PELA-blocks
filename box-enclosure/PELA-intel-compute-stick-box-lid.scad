/*
Parametric PELA End Cap Enclosure For Intel Compute Stick

Create 2 symmetric end pieces which can support a solid object with PELA-compatible attachment points on top and bottom. The print can be minimized by printing only smaller end caps instead of a complele enclosure.


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Work sponsored by
    https://www.futurice.com/
*/

include <../parameters.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../socket-panel/PELA-socket-panel.scad>
use <PELA-box-enclosure.scad>
use <PELA-intel-compute-stick-box-enclosure.scad>


///////////////////////////////
// DISPLAY
///////////////////////////////

intel_compute_stick_box_lid();