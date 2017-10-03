# Generate a set of 3D-printable LEGOs to demonstrate and exercise the script
# Windows Powershell
# Part of https://github.com/paulirotta/parametric_lego


##################################
# ABS sample, calibrated on a Taz 6 printer, standard extruder
$filename="lego-abs"
$top_tweak=0.0;
$bottom_tweak=-0.0;
$l=1;
$w=1;
$h=1;

Invoke-Expression ".\lego.ps1 -l $l -w $w -h $h -top_tweak $top_tweak -bottom_tweak $bottom_tweak -filename $filename"

$l=4;
$w=2;
$h=1;

Invoke-Expression ".\lego.ps1 -l $l -w $w -h $h -top_tweak $top_tweak -bottom_tweak $bottom_tweak -filename $filename"

$l=4;
$w=4;
$h=2;

Invoke-Expression ".\lego.ps1 -l $l -w $w -h $h -top_tweak $top_tweak -bottom_tweak $bottom_tweak -filename $filename"

#Panel
$l=8;
$w=8;
$h=1;

Invoke-Expression ".\lego.ps1 -l $l -w $w -h $h -top_tweak $top_tweak -bottom_tweak $bottom_tweak -filename $filename -mode 2 -bolt_holes 1"


##################################
# PLA, calibrated on a Taz 6 printer, standard extruder
$filename="lego-pla"
$top_tweak=-0.04;
$bottom_tweak=0.04;
$l=1;
$w=1;
$h=1;

Invoke-Expression ".\lego.ps1 -l $l -w $w -h $h -top_tweak $top_tweak -bottom_tweak $bottom_tweak -filename $filename"

$l=4;
$w=2;
$h=1;

Invoke-Expression ".\lego.ps1 -l $l -w $w -h $h -top_tweak $top_tweak -bottom_tweak $bottom_tweak -filename $filename"

$l=4;
$w=4;
$h=2;

Invoke-Expression ".\lego.ps1 -l $l -w $w -h $h -top_tweak $top_tweak -bottom_tweak $bottom_tweak -filename $filename"

#Panel
$l=8;
$w=8;
$h=1;

Invoke-Expression ".\lego.ps1 -l $l -w $w -h $h -top_tweak $top_tweak -bottom_tweak $bottom_tweak -filename $filename -mode 2 -bolt_holes 1"


##################################
# NGEN, calibrated on a Taz 6 printer, standard extruder
$filename="lego-ngen"
$top_tweak=0.07;
$bottom_tweak=-0.01;
$l=1;
$w=1;
$h=1;

Invoke-Expression ".\lego.ps1 -l $l -w $w -h $h -top_tweak $top_tweak -bottom_tweak $bottom_tweak -filename $filename"

$l=4;
$w=2;
$h=1;

Invoke-Expression ".\lego.ps1 -l $l -w $w -h $h -top_tweak $top_tweak -bottom_tweak $bottom_tweak -filename $filename"

$l=4;
$w=4;
$h=2;

Invoke-Expression ".\lego.ps1 -l $l -w $w -h $h -top_tweak $top_tweak -bottom_tweak $bottom_tweak -filename $filename"

#Panel
$l=8;
$w=8;
$h=1;

Invoke-Expression ".\lego.ps1 -l $l -w $w -h $h -top_tweak $top_tweak -bottom_tweak $bottom_tweak -filename $filename -mode 2 -bolt_holes 1"


###################################
# CALIBRATION
# Any material: test the fit with real LEGO bricks to find optimal fit top_tweak and bottom_tweak calibration numbers for your printer and material
$filename="lego"
$top_tweak=0;
$bottom_tweak=-0;
$l=2;
$w=2;
$h=1;

Invoke-Expression ".\lego.ps1 -l $l -w $w -h $h -top_tweak $top_tweak -bottom_tweak $bottom_tweak -filename $filename -mode 3"
