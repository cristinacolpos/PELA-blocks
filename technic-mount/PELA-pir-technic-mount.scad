/*
PELA PIR (pulsed infra-red) Technic Mount - 3D Printed LEGO-compatible PCB mount with the board held in place by technic bars

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

include <../parameters.scad>
include <../print-parameters.scad>
use <../block.scad>
use <../technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../knob-mount/PELA-knob-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-twist-bar.scad>
include <PELA-technic-board-mount.scad>

/* [Technic Pin Array Options] */

length = 39.5; // board space length [mm]
width = 39.5; // board space width [mm]
length_tightness = 1; // closeness of board fit lengthwise inside a ring of blocks [blocks/blocks] (increase to make outer box slightly larger)
width_tightness = 1; // closeness of board fit widthwise inside a ring of blocks [blocks/blocks] (increase to make outer box slightly larger)
twist_length = 2; // 90 degree rotation from length ends [blocks]
twist_width = 2; // 90 degree rotation from width ends [blocks]
thickness = 1.8; // board space thickness [mm]
undercut = 2.3; // Extrude down below board center to make space for components and cooling [mm]
innercut = 2; // Step in from board space edges to support the board [mm]

///////////////
// Display
///////////////
pi_camera_technic_mount();


module pi_camera_technic_mount(length=length, width=width, length_tightness=length_tightness, width_tightness=width_tightness, twist_length=twist_length, twist_width=twist_width, thickness=thickness, undercut=undercut, innercut=innercut) {

    technic_board_mount(length=length, width=width, length_tightness=length_tightness, width_tightness=width_tightness, twist_length=twist_length, twist_width=twist_width, thickness=thickness, undercut=undercut, innercut=innercut);
}