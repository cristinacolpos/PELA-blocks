# Generate a 3D-printable LEGO using command line parameters
# Windows Powershell
# Part of https://github.com/paulirotta/parametric_lego

$top_tweak = 0.0
$bottom_tweak = 0.0
$copy_to_back = 0
$extrude = 0
$bolt_holes = 0

Function generate-sign($filename) {
    $filename = $filename+"t"+$top_tweak+"b"+$bottom_tweak+".stl"

    $param = "`"top_tweak=$top_tweak; bottom_tweak=$bottom_tweak; extrude=$extrude; copy_to_back=$copy_to_back; bolt_holes=$bolt_holes; `""

    echo "Render $filename $param"

    openscad -o $filename -D $param lego-sign-thingiverse.scad

    echo "Rendered"
    echo ""    
}


generate-sign("lego-sign-abs-");


###### PLA
$top_tweak = -0.04
$bottom_tweak = 0.04

generate-sign("lego-sign-pla-");


###### NGEN
$top_tweak = 0.07
$bottom_tweak = -0.01

generate-sign("lego-sign-ngen-");

$copy_to_back = 1
$extrude = 1
$bolt_holes = 1

generate-sign("lego-sign-ngen-alt-");
