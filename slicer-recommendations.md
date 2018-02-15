# PELA Blocks
## Slicer Recommmendations

Our experience with different materials are recommended below. Unless otherwise noted, prints are on a Lulzbot Taz 6, 0.5mm extruder, using LulzBot Cura. Flexible printers use an 0.6mm extruder.

Avoid "brim" and "support" options if possible as they can be difficult to clean from inside the model. Most models are designed to not require supports. Some models offer a switch for optional, minimal supports in key areas. Consider dissovable supports in other cases.

# Innofil rPET

Made from recycled plastic bottles. Note that the overextrusion and other settings adjusted for translucenty and minimum "hop and hunt" on these models are matched to the tweak numbers.

## `PELA_print_parameters.scad`

`large_nozzle = true;` (if nozzle >= 0.5mm)

`flexible_filament = false;`

`top_tweak = 0.04;`

`bottom_tweak = 0.10;`

`axle_hole_tweak = 0.04;`

## Slicer Settings

`Layer Height: 0.25`     (for transparency- taller is fine and prints faster)

`Print Temp: 245C`

`Build Plate: 85C`

`Flow: 105%`

`Fan: 30%`

`Retraction: 8.5mm`

`Retraction Speed: 25mm/s`

`Speed: 80mm/s`

`Bottom Speed: 40mm/s`

`Support: None`   (see 'PEL-print-parameters.scad' where support can be added to some models)

`Adhesion: Skirt`

`Infill: 20%`   (minimal effect, most models this can be 50% without taking more time)

`Wall Line Count: 1`

`Fill Gaps Between Walls: Nowhere`

Optional Finish: Lightly sand the outer surface and spray with a clear polimer.

# Colorfabb NGEN

## `PELA_print_parameters.scad`

`large_nozzle = true;` (if nozzle >= 0.5mm)

`flexible_filament = false;`

`top_tweak = 0.01;`

`bottom_tweak = 0.05;`

`axle_hole_tweak = 0.04;`

## Slicer Settings

`Layer Height: 0.3`   (or smaller for aesthetics and when there is side text in the model)

`Print Temp: 255C`

`Initial Print Temp: 250C`

`Build Plate: 85C`

`Flow: 95%`

`Fan: 50%`

`Enable Coasting: true`

`Speed: 60mm/s`

`Wall Speed: 30mm/s`

`Support: None`

`Adhesion: Skirt`

`Infill: 20%`   (minimal effect, most models this can be 50% without taking more time)

`Wall Line Count: 1`

`Fill Gabs Between Walls: Nowhere`

Works well despite a slightly slippery surface finish. As with other PET/co-copolymer filaments, unless you seek transparency then do not overextude. Consider more fan if layer adhesion is sufficent (knobs are particularly sensitive to delamination). Lower or disable the fan for better layer adhesion.

# Colorfabb NGEN Flex

Basically the same settings as NGEN. Better results due to the extra flexibility.

`large_nozzle = true;` (if nozzle >= 0.5mm. Usually you use a large nozzle for flex because the print speeds are low)

`flexible_filament = true;`   (this results in longer top knobs help it maintain grip while flexing)

`Fan: 50%`  (or less for better inter-layer adhesion)

# ColorFabb HT

Generally avoid. It is quite stiff and has slippery finish. It takes a long time to clean this sticky stuff from your printer.

# NinjaTek NinjaFlex

Works well. Gluestick acts as a release agent that protects the PEI print surface from damage, or better use plain glass with gluestick.

`large_nozzle = true;` (if nozzle >= 0.5mm. Usually you use a large nozzle for flex because the print speeds are low)

`flexible_filament = true;`   (this results in longer top knobs help it maintain grip while flexing)

# PLA

PLA is OK if you don't have other choices. It is stiff and chips easily so part fit and lifetime are worse than other materials.

Minimize or avoid bed heating as it can elephant foot the lower socket connectors.

# ABS

LEGO is made from ABS. It has many nice properties and works well, however large parts may lift or delaminate due to thermal expansion. Use it if you know and like ABS.

`Adhesion: Brim`   (check the slicer's preview image. If the brim pollutes the inside of the bottom connectors that creates difficult post-processing. Consider alaternatives like a PEI sheet or `Adhesion: Brim` instead)
