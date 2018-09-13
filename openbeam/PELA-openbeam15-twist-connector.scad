

///////////// Parameters /////////////////////
$fn=90;

top_width = 15;
top_length = 15;
top_height = 1.5;

throat_length = 2.7;
throat_width = 2.7;
throat_height = 1.9;

foot_width = throat_width;
foot_length = throat_length + 2*1.6;
foot_height = 2;

//////////// Render ////////////////////////


module openbeam15() {
	openbeam15_base();
	openbeam15_neck();
	openbeam15_insert();
}


module openbeam15_base() {
	translate([0, 0, -top_height]) {
		cube([top_width, top_length, top_height]);
	}
}


module openbeam15_neck() {
	translate([(top_width - throat_width) / 2,
			(top_length - throat_length) / 2,
			0]) {
			translate([throat_width/2, throat_length/2,0]) 
				cylinder(h=throat_height, r=throat_width/2);
			cube([throat_width/2, throat_length/2, throat_height]);
			translate([throat_width/2, throat_length/2,0]) 
				cube([throat_width/2, throat_length/2, throat_height]);
	}
}


module openbeam15_insert() {
	intersection() {
		translate([top_width / 2, top_length / 2, throat_height])
			cylinder(h=throat_height, d=foot_length);
		translate([top_width/2 - throat_width/2, 0, 0])
			cube([throat_width, 1000, 1000]);
	}
}