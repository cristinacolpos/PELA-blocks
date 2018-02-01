/*
PELA Robot Hand

Print Support

Published at http://robothand.PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com

Import this into other design files:
    use <support/support.scad>
*/

include <../PELA-print-parameters.scad>

////////////////////////////
// Test print
//
support(height=10);


// One side of one layer of a support triangle
module support_line(support_side_length=support_side_length, support_layer_height=support_layer_height, support_line_width=support_line_width) {
    hull() {
        cylinder(d=support_line_width, h=support_layer_height, $fn=16);

        translate([0, support_side_length, 0])
            cylinder(d=support_line_width, h=support_layer_height, $fn=16);
    }
}

// One layer of a support made up of three lines
module support_triangle(support_side_length=support_side_length, support_layer_height=support_layer_height, support_line_width=support_line_width, angle=0) {
    support_side_length = support_side_length-support_line_width;
    translate([support_side_length/2*sin(30+angle), -support_side_length/2*cos(30+angle), -support_layer_height]) {
        rotate([0, 0, angle]) {
            support_line(support_side_length=support_side_length, support_layer_height=support_layer_height, support_line_width=support_line_width);
            rotate([0, 0, 60])
                support_line(support_side_length=support_side_length, support_layer_height=support_layer_height, support_line_width=support_line_width);

                translate([0, support_side_length, 0])
                rotate([0, 0, 120])
                    support_line(support_side_length=support_side_length, support_layer_height=support_layer_height, support_line_width=support_line_width);
        }
    }
}


// A twisted triangular column to aid in additive manufacturing print-time strength
module support(support_side_length=support_side_length, support_layer_height=support_layer_height, support_line_width=support_line_width, height) {
    layer_count = ceil(height/support_layer_height);

    translate([0, 0, height]) {
        intersection() {
            union() {
                for (i = [0:1:layer_count]) {
                    translate([0, 0, -i*support_layer_height])
                        support_triangle(support_side_length=support_side_length, support_layer_height=support_layer_height, support_line_width=support_line_width, angle=i*support_layer_rotation);
                }
            }

            translate([-support_side_length, -support_side_length, -height])
                cube([2*support_side_length, 2*support_side_length, height]);
        }
    }
}