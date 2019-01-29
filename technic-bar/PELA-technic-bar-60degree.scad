/*
PELA technic angle - 3D Printed LEGO-compatible 60 degree bend

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    https://www.futurice.com

All modules are setup for stateless functional-style reuse in other OpenSCAD files.
To this end, you can always pass in and override all parameters to create
a new effect. Doing this is not natural to OpenSCAD, so apologies for all
the boilerplate arguments which are passed in to each module or any errors
that may be hidden by the sensible default values. This is an evolving art.
*/

include <../print-parameters.scad>
include <../parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <PELA-technic-bar-30degree.scad>

/* [Technic Pin Array Options] */

angle = 60;
l = 1;



///////////////////////////////
// Display
///////////////////////////////

mount_30degree(angle=angle, l=l);
