# Parametric LEGO #

### 3D Printable LEGO shapes with fine-tuning parameters for a perfect fit with different materials, printers and nozzle sizes ###

Print out snap-together cases and objects by starting from a proper LEGO part. Making LEGO-compatibible boxes and enclosures is one of the motivations for this project. See for example https://github.com/paulirotta/lego_grove

### Calibration ###

Printer, print settings and plastic effect the precise fit of LEGO. Thus it is usually necessary to slightly adjust knob and bottom ring size to achieve a good fit. Other settings are availble but usually do not need adjustment.

1. First print the two calibration bars or (slower to print but more flexible to test with) a set of 2x2 calibration blocks
2. Test fit top and bottom against real LEGO, write down the top_tweak and bottom_tweak values (knob and ring size adjustments, respectively). Keep in mind that too tight may be a problem for print lifetime or mating and separating large surfaces.
3. Print two 2x4 blocks with your selected values
4. Verify the blocks fit top and bottom to each other and real LEGO.

### FFF Printing Tips ###

* Use a 0.4mm or smaller nozzle if possible to avoid decimation of some details (inside vertical shell bars..)
* If slicing with Simplify 3D with 0.5mm or larger nozzle, either expand the ring_thickness (and risk stiff bottom connectors) or set Advanced | External Thing Wall Type | Allow single extrusion walls
* Be aware that Cura Engine may in some cases not be able to correct OpenSCAD STL export errors. These errors should be visible in layer preview as for example extra excursions back to origin. If this happens, open and clean the STL files first (Windows 3D Builder, Meshmixer, Meshlab..).

### Resin Printing Tips ###

* If more than 2 layer tall LEGO with a relatively solid interior not allowing drainage below the knobs, check if you need to expand the airhole to allow resin to drain from the flexture chamber inside each knob
* For translucent materials, setting knob_slice_count to 0 may make the interior structure look more like a standard LEGO at the cost of a slight reduction of knob sidewall flex

### Who do I talk to? ###

* paulirotta@gmail.com
* https://twitter.com/mobile_rat
* https://medium.com/@paulhoughton
* https://github.com/paulirotta/parametric_lego/
