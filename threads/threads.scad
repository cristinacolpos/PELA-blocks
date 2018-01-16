/*
Thread library convenience wrapper for 

Published at
    http://www.thingiverse.com/thing:2303714
Maintained at
    https://github.com/paulirotta/parametric_PELA
See also the related files
    PELA Sign Generator - https://www.thingiverse.com/thing:2546028
    PELA Enclosure Generator - https://www.thingiverse.com/thing:2544197


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com

Import this into other design files to set baseline constants:
    include <threads.scad>
*/

use <Yet_another_thread_library_for_OpenSCAD/quickthread.scad>

extrusionNudge = 0.001;

us_bolt_thread();

translate([10, 0]) 
    us_nut_thread();


// The thread of a bolt (no head)
module us_bolt_thread(dInch=0.25, hInch=1, tpi=20) {
    isoThread(dInch=dInch, hInch=hInch, tpi=tpi, internal=false);
}


// Negative space, the part to cutout to make a nut
module us_nut_thread() {
    isoThread(dInch=dInch, hInch=hInch, tpi=20, internal=true);
}
