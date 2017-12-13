/*
Thread library convenience wrapper for 

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
    include <threads.scad>
*/

use <Yet_another_thread_library_for_OpenSCAD/quickthread.scad>

extrusionNudge = 0.001;

us_bolt_thread();


// The thread of a bolt (no head)
module us_bolt_thread(dInch=0.25, hInch=1, tpi=20) {
    isoThread(dInch=dInch, hInch=hInch, tpi=tpi, internal=false, $fn=60);
}


// Negative space, the part to cutout to make a nut
module internal_thread() {
    isoThread(d=42,h=30+2*extrusionNudge,pitch=3,angle=40,internal=true,$fn=60);
}
