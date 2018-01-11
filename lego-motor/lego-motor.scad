
include <../lego-parameters.scad>
use <../lego.scad>
use <../technic.scad>

/* [LEGO Connector Fit Options] */

// Interior fill for layers above the bottom
solid_upper_layers = 1; // [0:empty, 1:solid]

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0; // [0:no holes, 1:holes]

bottom_stiffener_height=9.6;


/* [Motor Enclosure Size] */
// Length of the motor enclosure (LEGO unit count)
l = 4; 

// Width of the motor enclosure (LEGO unit count)
w = 2;

// Height of the bottom part of the motor enclosure (LEGO unit count, the top part is always 1/3)
h = 4/3;


/* [Motor Options] */
// Diameter of the rounded part of the motor body (if no rounding, set length as appropriate and this to 1/2 the motor width)
motor_radius=6.1;

// Shaft-axis ditance of the rounded part of the motor body (motor_width may reduce this)
motor_round_length=15.5;

// Shaft-axis distance of the square part of the motor body (motor_width may reduce this)
motor_square_length=9.5;

// Width of the motor slot body (may reduce rounding, add 0.2 for space to insert the motor)
motor_width=10+2*skin;

// Radius of the motor shaft cutout slot
motor_shaft_radius=1.9;

// Distance the motor shaft extends from the motor body
motor_shaft_length=9.4;

// Radius of motor end cutout slot for electrical connectors
electric_radius=1.9;

// Additional depth to the electrical cutout
electric_vertical_displacement=-3;

// Distance the electrical connector cutout extends from the body
electric_length=20;

side_holes=1;

side_sheaths=0;

end_holes=0;

top_vents=1;

//knob_vent_radius=1.5;

////////////////////


lego_motor_bottom();
lego_motor_top();

module lego_motor_bottom() {
    difference() {
        lego_technic(l, w, h, knob_flexture_radius=0, solid_upper_layers=1, top_vents=0, knob_vent_radius=0);
        
        union() {
            translate([(lego_width(l)-motor_round_length-motor_square_length)/2, (lego_width(w)-motor_width)/2, lego_height(h)-motor_radius-lego_width(0.5)]) {
                motor_slot();
                shaft_slot();
                electric_slot();
            }
        
            if (is_true(side_holes)) {
                translate([0, 0, lego_height(h-1)])
                    side_connector_hole_set();
            }
        }
    }
}


module lego_motor_top() {
        translate([0, lego_width(w + 0.5), lego_height(-1/3)])
            difference() {
                lego_technic(l=l, w=w, h=1, side_holes=0);
    
                union() {
                    cube([lego_width(l), lego_width(w), lego_height(1/3)]);
            
                    translate([(lego_width(l)-motor_round_length-motor_square_length)/2, (lego_width(w)-motor_radius*2)/2, lego_height(2/3)-motor_radius-lego_width(0.5)])
                        motor();
                }
            }
}

module motor() {
    intersection() {
        union() {
            translate([0, motor_radius, motor_radius])
                rotate([0, 90, 0])
                    cylinder(r=motor_radius, h=motor_round_length);
    
            translate([motor_round_length,0,0])
                cube([motor_square_length, motor_radius*2, motor_radius*2]);
        }
        
        translate([0, (2*motor_radius-motor_width)/2], 0)
            cube([motor_round_length+motor_square_length, motor_width, motor_radius*2]);
    }    
    
    motor_shaft();
}


module motor_shaft() {
    translate([0, motor_radius, motor_radius])
        rotate([0, 90, 0])
            cylinder(r=motor_shaft_radius, h=motor_round_length+motor_square_length+motor_shaft_length);
}

module electric_cutout() {
    translate([0, motor_radius, motor_radius+electric_vertical_displacement])
        rotate([0, -90, 0])
            cylinder(r=electric_radius, h=electric_length);    
}

module motor_slot() {
    translate([0, -(2*motor_radius-motor_width)/2, 0])
        motor();

    translate([0, 0, motor_radius])
        cube([motor_square_length+motor_round_length, motor_width, motor_radius]);    
}

module shaft_slot() {
    hull() {
        translate([0, -(2*motor_radius-motor_width)/2, 0])
            motor_shaft();

        translate([0, -(2*motor_radius-motor_width)/2, lego_height()])
            motor_shaft();
    }    
}

module electric_slot() {
    hull() {
        translate([0, -(2*motor_radius-motor_width)/2, 0])
            electric_cutout();

        translate([0, -(2*motor_radius-motor_width)/2, lego_height()])
            electric_cutout();
    }    
}
