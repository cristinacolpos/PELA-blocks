spacing = 8;
t = 2;
cut = 0.001;
margin = 8;
$fn=128;
div_width = 0.2;
div_length = margin*2 + spacing - 2*div_width;
nominal_hole_r = 2.75;
label = "PELAblock.org Lasercutter Calibration";
line_thickness = 0.001;
kerf_d = 0.1; // Focused laser cut spot diameter 

module lasercutter_calibration_bar_cuts(nominal_hole_r=nominal_hole_r) {

    color("red") {
        knob_cuts(nominal_hole_r=nominal_hole_r);
        border();
    }
}


module lasercutter_calibration_bar_labels(label=label) {

    top_label(label=label);
    dividers();
    labels();
}

module top_label(label=label) {
    translate([-3, 18]) {
        label(i=0, j=label);
    }
}


module knob_cuts(nominal_hole_r=nominal_hole_r) {
    translate([margin*2 + spacing*9, margin]) {
        for (i=[-0.1:0.02:0.12]) {
            for (j=[0:1]) {
                translate([i*100*spacing, j*spacing]) {
                    circle_cut(r=nominal_hole_r + i);
                    translate([spacing, 0]) {
                        circle_cut(r=nominal_hole_r + i);
                    }
                }
            }
        }
    }
}


module border() {
    corner();
    translate([margin*2 + spacing*21, margin*2+spacing]) rotate([0, 0, 180]) corner();
}


module corner() {
    edge(length=margin*2 + spacing*21);
    edge(length=24, rot=90);
}


module edge(length=8, rot=0) {
    rotate([0, 0, rot]) {
        square(size = [length, cut]);
    }
}


module dividers() {
    for (i=[0:9]) {
        divider(i=i);
    }
} 


module divider(i=0) {
    translate([margin + -0.5*spacing + (2*(i+1))*spacing - div_width/2, div_width/2]) {
        square(size = [div_width, div_length]);
    }
}


module labels() {
    for (i=[0:10]) {
        j = str((i - 5)*0.02);
        label(i=i, j=j);
    }
} 


module label(i=0, j="Err") {
    translate([-12 + margin + -0.5*spacing + (2*(i+1))*spacing - div_width/2, 2 + div_width/2]) {
        text(j, size=3);
    }
}


module circle_cut(r=3) {
    for (i=[0:360/$fn:360]) {
        x1 = r*sin(i);
        y1 = r*cos(i);
        x1b = x1 + cut*sin(i);
        y1b = y1 + cut*cos(i);
        theta = i+360/$fn;
        x2 = r*sin(theta);
        y2 = r*cos(theta);
        x2b = x2 + cut*sin(theta);
        y2b = y2 + cut*cos(theta);

        polygon([[x1, y1], [x1b, y1b], [x2b, y2b], [x2, y2]]);
    }
}