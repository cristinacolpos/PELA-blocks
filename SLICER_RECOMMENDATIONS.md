# PELA Blocks
## Slicer Recommmendations

Our experience with different materials are recommended below. Unless otherwise noted, prints are on a Lulzbot Taz 6, 0.5mm extruder, using LulzBot Cura. Flexible printers use an 0.6mm extruder.

Avoid "brim" and "support" options if possible as they can be difficult to clean from inside the model. Most models are designed to not require supports. Some models offer a switch for optional, minimal supports in key areas. Consider dissovable supports in other cases.

# Innofil rPET

Made from recycled plastic bottles. Note that the overextrusion and other settings adjusted for translucenty and minimum "hop and hunt" on these models are matched to the tweak numbers.

## `PELA_print_parameters.scad`
`large_nozzle = true;`
`flexible_filament = false;`
`top_tweak = 0.04;`
`bottom_tweak = 0.12;`
`axle_hole_tweak = 0.04;`

## Slicer Settings
Layer Height: 0.25
Print Temp: 245C
Initial Print Temp: 245C
Build Plate: 85C
Flow: 105%
Fan: 10%
Retraction: 8.5mm
Retraction Speed: 25mm/s
Speed: 80mm/s
Bottom Speed: 40mm/s
Support: No
Adhesion: Skirt
Infill: 0%
Wall Line Count: 1
Top Layers: 4
Bottom Layers: 4
Fill Gabs Between Walls: Nowhere
Z Seam Alignment: Random
Extensive Stitching: True

Optional Finish: Lightly sand the outer surface and spray with a clear polimer.

# Colorfabb NGEN

Default settings similar to the above. As with other PET/co-copolymer filaments, unless you seek transparency then do not overextude and consider 50% fan if layer adhesion is sufficent (knobs are particularly sensitive to delamination). Lower or disable the fan for better layer adhesion. Works well, slightly slippery surface is not ideal.

# Colorfabb NGEN Flex

Basically the same settings as NGEN. Better results due to the extra flexibility. Fan off for better inter-layer adhesion.

# ColorFabb HT

Generally avoid as it can be rather stiff and slippery finish. May work with appropriate settings

# NinjaTek NinjaFlex

Works well. Gluestick acts as a release agent that protects the PEI print surface from damage, or better use plain glass with gluestick.

# PLA

Generally avoid PLA if you have other choices. The stiffness and easy chipping mean part fit well and lifetime are less than other materials.

Minimize bed heating as it may alter the lower socket connector geometry.

