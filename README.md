# 3D Printable Parametric LEGO #

## LEGO- and Technics-compatible Blocks and Custom Parts ##

3D print snap-together objects in exotic materials and gemoetries. This can be used to make exotic-shapes and materials. It is also great for creating enclosures for sensors, actuators, computers and IoT devices with commercial LEGO and LEGO Technics parts. Fully parametric fine-tuning parameters and calibration allow for a perfect fit with different materials, printers, nozzle sizes and slicer settings.

These designs are not by the LEGO corporation. They are compatible with LEGO and LEGO-Technics blocks available from multiple manufacturers. They are legal to use since basic LEGO patents have expired. These designs are specially modified for easy 3D printing and offered in the spirit of open source hardware innovation. 

**[DOWNLOAD](https://github.com/LEGO-Prototypes/parametric-lego/archive/master.zip)** the latest designs and edit with [OpenSCAD](http://www.openscad.org/).

**IMPORTANT:** First calibrate the designs for your printer.

## Calibration ##

*TL;DR: Print a [Calibration Bar](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/lego-calibration/lego-calibration.stl) and update your connector fit adjustments in [`print-parameters.scad`](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/print-parameters.scad)*

Printer, slider parameters and plastic effect the precise fit of press fit connectors. It is usually necessary to slightly adjust knob and bottom ring size to achieve a good fit. Other settings are available in [`lego-parameters.scad`](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/lego-parameters.scad).

1. Print the Calibration Bar and test fit the top and bottom against real LEGO. Put the `top_tweak` and `bottom_tweak` values that you can read from the side of the bar into `print-parameters.scad`.

2. Generate a new 4x4 block in OpenSCAD using these settings and export as `.STL`.

3. Print two 4x4 blocks with your selected values and confirm a good fit to each other and real LEGO.


## LEGO-compatible Part Designs ##

[LEGO Block](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/lego4-2-1.stl) (edit `print-parameters.scad` to change the size)

[LEGO Block with Technics connectors](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/technic4-4-2.stl) (optional vents to help dissipate heat)

[LEGO Socket Panel](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/lego-socket-panel/lego-socket-panel.stl) (double-sided)

[LEGO Knob Panel](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/lego-knob-panel/lego-knob-panel.stl) (optional M3 corner mount bolt holes as with other models)

[Double-sided LEGO Knob Panel](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/lego-knob-panel/lego-double_sided-knob-panel.stl) (print with supports)

[LEGO Technic Pin](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/technic-pin.stl) (in case you run short and don't want to wait for mail order)

[LEGO Technic Axle](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/technic-axle.stl) (adjustable lenth)

[LEGO Technic Cross Axle](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/technic-cross-axle.stl) (rigid and flexible drive shafts)

[LEGO Sign](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/lego-sign/lego-sign.stl) (name your designs)

[LEGO Grove Module](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/lego-grove-module-enclosure/lego-grove-module-enclosure.stl) (use 4x M3 bolts to assemble or switch to pressure fit)

[LEGO HTC Vive Tracker Mount and Screw](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/lego-vive-tracker-mount/lego-vive-tracker-mount.stl) (for [HTC Vive](https://www.vive.com/), use a standard tripod screw if you prefer)

[LEGO Gunrail Mount](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/lego-gunrail-mount/lego-gunrail-mount.stl) (for HTC Vive Tracker Mount)

[LEGO Gunrib Mount](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/lego-gunrail-mount/lego-gunrib-mount.stl) (when there is no accessory rail)

[LEGO Endcap Enclosure](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/lego-endcap-enclosure/lego-endcap-enclosure.stl) (adjust the parameters to fit around something)

[LEGO Intel Compute Stick Enclosure](https://github.com/LEGO-Prototypes/parametric-lego/blob/master/lego-endcap-enclosure/lego-endcap-intel-compute-stick-enclosure.stl) (a computer inside your robot)

Collaboration and pull requests are welcome: https://github.com/LEGO-Prototypes/parametric-lego

## FFF Printing Tips ##

* Use a 0.4mm or smaller nozzle if possible to avoid decimation of some details (inside vertical shell bars..)
* If slicing with Simplify 3D with 0.5mm or larger nozzle, either expand the ring_thickness (and risk stiff bottom connectors) or set Advanced | External Thing Wall Type | Allow single extrusion walls
* Be aware that Cura Engine may in some cases not be able to correct OpenSCAD STL export errors. These errors should be visible in layer preview as for example extra excursions back to origin. If this happens, open and clean the STL files first (Windows 3D Builder, Meshmixer, Meshlab..).

## Resin Printing Tips ##

* If more than 2 layer tall LEGO with a relatively solid interior not allowing drainage below the knobs, check if you need to expand the airhole to allow resin to drain from the flexture chamber inside each knob
* For translucent materials, setting knob_slice_count to 0 may make the interior structure look more like a standard LEGO at the cost of a slight reduction of knob sidewall flex

## Sponsors ##

Special thanks to [Futurice](http://futurice.com) for sponsoring this design work. Futurice supports truly open innovation.

## Contact ##

paul.houghton@futurice.com ( **[Blog](https://medium.com/@paulhoughton)** - **[Twitter](https://twitter.com/mobile_rat)** )
