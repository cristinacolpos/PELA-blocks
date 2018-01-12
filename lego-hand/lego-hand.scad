
include <../lego-parameters.scad>
use <../lego.scad>
use <../technic.scad>


/* [Lego Hand Size] */

// Enable generation of individual parts
f1=true;
f2=true;
f3=true;
f4=true;
f5=true;
palm=true;

// Thumb
f1w = 3;
f1h = 1;
f1l1 = 6; 
f1l2 = 5; 
f1l3 = 4; 

// Pointer
f2w = 2;
f2h = 1;
f2l1 = 6; 
f2l2 = 4; 
f2l3 = 3; 

// Index
f3w = 2;
f3h = 1;
f3l1 = 6; 
f3l2 = 5; 
f3l3 = 4; 

// Ring
f4w = 2;
f4h = 1;
f4l1 = 5; 
f4l2 = 4; 
f4l3 = 3; 

// Pinky
f5w = 2;
f5h = 1;
f5l1 = 5; 
f5l2 = 4; 
f5l3 = 2; 

/* [LEGO Options] */

side_holes=1;

side_sheaths=0;

end_holes=0;

top_vents=0;

// Place holes in the corners of the panel for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0; // [0:no holes, 1:holes]

finger_joint_space = 1;
inter_finger_space = lego_width(1);

//////////////////// Main View

if (f1)
    finger1(tx=-lego_width(9), ty=-finger_joint_space - lego_width(f1w));
if (f2)
    finger2(tx=finger_joint_space, ty=0);
if (f3)
    finger3(tx=finger_joint_space, ty=inter_finger_space + lego_width(f2w));
if (f4)
    finger4(tx=finger_joint_space, ty=2*inter_finger_space + lego_width(f2w+f3w));
if (f5)
    finger5(tx=finger_joint_space, ty=3*inter_finger_space + lego_width(f2w+f3w+f4w));
if (palm)
    palm_body();

//////////////////// End Main View


module palm_body() {
    translate([-lego_width(11), 0])
        lego_technic(w=11, l=11, h=4/3, side_holes=side_holes, end_holes=end_holes, top_vents=top_vents, bolt_holes=bolt_holes);

    // TODO outer skin away
}

// Thumb
module finger1(tx=0, ty=0) {
    color("red") finger_body(w=f1w, l=f1l1, h=f1h, tx=tx, ty=ty);
    color("green") finger_body(w=f1w, l=f1l2, h=f1h, tx=tx+lego_width(f1l1) + finger_joint_space, ty=ty);
    color("blue") finger_body(w=f1w, l=f1l3, h=f1h, tx=tx+lego_width(f1l1 + f1l2) + 2*finger_joint_space, ty=ty);
}

// Pointer
module finger2(tx=0, ty=0) {
    color("red") finger_body(w=f2w, l=f2l1, h=f2h, tx=tx, ty=ty);
    color("green") finger_body(w=f2w, l=f2l2, h=f2h, tx=tx+lego_width(f2l1) + finger_joint_space, ty=ty);
    color("blue") finger_body(w=f2w, l=f2l3, h=f2h, tx=tx+lego_width(f2l1 + f2l2) + 2*finger_joint_space, ty=ty);
}

// Index
module finger3(tx=0, ty=0) {
    color("red") finger_body(w=f3w, l=f3l1, h=f3h, tx=tx, ty=ty);
    color("green") finger_body(w=f3w, l=f3l2, h=f3h, tx=tx+lego_width(f3l1) + finger_joint_space, ty=ty);
    color("blue") finger_body(w=f3w, l=f3l3, h=f3h, tx=tx+lego_width(f3l1 + f3l2) + 2*finger_joint_space, ty=ty);
}

// Ring
module finger4(tx=0, ty=0) {
    color("red") finger_body(w=f4w, l=f4l1, h=f4h, tx=tx, ty=ty);
    color("green") finger_body(w=f4w, l=f4l2, h=f4h, tx=tx+lego_width(f4l1) + finger_joint_space, ty=ty);
    color("blue") finger_body(w=f4w, l=f4l3, h=f4h, tx=tx+lego_width(f4l1 + f4l2) + 2*finger_joint_space, ty=ty);
}

// Pinky
module finger5(tx=0, ty=0) {
    color("red") finger_body(w=f5w, l=f5l1, h=f5h, tx=tx, ty=ty);
    color("green") finger_body(w=f5w, l=f5l2, h=f5h, tx=tx+lego_width(f5l1) + finger_joint_space, ty=ty);
    color("blue") finger_body(w=f5w, l=f5l3, h=f5h, tx=tx+lego_width(f5l1 + f5l2) + 2*finger_joint_space, ty=ty);
}

module finger_body(w, l, h, t) {
    translate([tx, ty, 0]) {
        finger_body_technic(w=w, l=l, h=h);

    }
}

// A block of w-l-h units, skin in place so several such blocks can be next to one another
module solid_block(w=w, l=l, h=h, skin=skin) {
    translate([skin, skin, 0])
        cube([lego_width(l)-2*skin, lego_width(w)-2*skin, lego_height(h)]);
}

module finger_body_technic(w=w, l=l, h=h) {
    lego_technic(w=w, l=l, h=h, side_holes=side_holes, end_holes=end_holes, top_vents=top_vents, bolt_holes=bolt_holes);
//    difference() {
//        body_upper_half(w=w, l=l, h=h);
//        finger_body_negative_space(w=w, l=l, h=h, side_holes=side_holes);
//    }
}

module body_upper_half(w=w, l=l, h=h, skin=skin) {
        translate([0, 0, lego_height(h/2)])
            solid_block(w=w, l=l, h=h/2, skin=skin);
}

module palm_body_upper_half(w=w, l=l, h=h) {
        translate([0, 0, lego_height(h/2)]) {
            solid_block(w=w, l=l, h=h/2, skin=0);

        }

        //TODO Remove skin
}

module finger_body_negative_space(w=w, l=l, h=h, side_holes=side_holes, top_vents=top_vents, bolt_holes=bolt_holes) {
    difference() {
        body_upper_half(w=w, l=l, h=h);
        lego_technic(w=w, l=l, h=h, side_holes=side_holes, end_holes=end_holes, top_vents=top_vents, bolt_holes=bolt_holes);
    }
}

module palm_body_negative_space(w=w, l=l, h=h, side_holes=side_holes, top_vents=top_vents, bolt_holes=bolt_holes) {
    difference() {
        palm_body_upper_half(w=w, l=l, h=h);
        lego_technic(w=w, l=l, h=h, side_holes=side_holes, end_holes=end_holes, top_vents=top_vents, bolt_holes=bolt_holes, skin=0);
    }
}
