# 3D Printable Parametric PELA #

## PELA- and Technics-compatible Blocks and Custom Parts ##

3D print snap-together objects in exotic materials and gemoetries. This can be used to make exotic-shapes and materials. It is also great for creating enclosures for sensors, actuators, computers and IoT devices with commercial PELA and PELA Technics parts. Fully parametric fine-tuning parameters and calibration allow for a perfect fit with different materials, printers, nozzle sizes and slicer settings.

These designs are not by the LEGO corporation. They are compatible with LEGO and LEGO-Technics as are blocks available from multiple manufacturers. These design are legal to use because the associated patents have expired. These designs are not identical to LEGO. They are specially modified for easy 3D printing and offered in the spirit of open source hardware innovation. If what you want is available as injection moulded ABS plastic, buy it for the high quality and durability. These model are helpful if you want something customized and special, or in an unusual material or for a quick replacement part.

**[DOWNLOAD](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/archive/master.zip)** the latest designs and edit with [OpenSCAD](http://www.openscad.org/).

**IMPORTANT:** First calibrate the PELA Blocks for your printer to achieve a nice snap fit.

## Calibration ##

![PELA Calibration Bar](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/calibration/PELA-calibration.png)

*TL;DR: Print a [PELA Calibration Bar](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/calibration/PELA-calibration.stl), test fit with LEGO, read the best fit numbers from the side of the block and add these to [`print-parameters.scad`](https://github.com/PELA-Prototypes/parametric-PELA/blob/master/print-parameters.scad). Open any model in OpenSCAD, press F6, and export as STL*

Printer, slider parameters and plastic effect the precise fit of press fit connectors. It is usually necessary to slightly adjust knob and bottom ring size to achieve a good fit by editing [`PELA-print-parameters.scad`](https://github.com/PELA-Prototypes/parametric-PELA/blob/master/PELA-print-parameters.scad). The most common settings are `top_tweak` and `bottom_tweak` which can be read from the side of the clibration block. Other model settings affecting all designs are available in [`PELA-parameters.scad`](https://github.com/PELA-Prototypes/parametric-PELA/blob/master/PELA-parameters.scad).

Best results are achieved with durable materials that are not too stiff (PET, co-oplimers like NGEN, semi-flexible and "engineering" materials).

Best results are achieved with smaller nozzle diameters. Adjust slicer settings for precision over speed. Layer height is not particularly important on most models.

Be sure to set the `flexible_material` and `large_nozzle` settings in [`PELA-print-parameters.scad`](https://github.com/PELA-Prototypes/parametric-PELA/blob/master/PELA-print-parameters.scad) to adjust the models for easier printing and a better fit.

1. Print the Calibration Bar and test fit the top and bottom against real PELA. Put the `top_tweak` and `bottom_tweak` values that you can read from the side of the bar into `print-parameters.scad`.

2. Generate a new 4x4 [PELA Block](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/PELA-block-4-2-1.stl) in OpenSCAD using these settings, press F6 to render, and export as `.STL`.

3. Print two 4x4 blocks with your selected values and confirm a good fit to each other and real PELA.


## PELA-compatible Part Designs ##

Edit `PELA-print-parameters.scad` and `PELA-parameters.scad` to adapt these models before printing them. The example renders are for a Taz 6, 0.5mm nozzle, NGEN rigid filament, LulzBot Cura standard slicer settings.

![PELA Block](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/PELA-block-4-2-1.png)

[PELA Block](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/PELA-block-4-2-1.stl) 

![PELA Block with Technics connectors](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/PELA-technic-block-4-4-2.png)

[PELA Block with Technics connectors](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/PELA-technic-block-4-4-2.stl) (optional vents to help dissipate heat)

![PELA Socket Panel](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/socket-panel/PELA-socket-panel.png)

[PELA Socket Panel](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/socket-panel/PELA-socket-panel.stl) (double-sided)

![PELA Knob Panel](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/knob-panel/PELA-knob-panel.png)

[PELA Knob Panel](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/knob-panel/PELA-knob-panel.stl) (optional M3 corner mount bolt holes as with other models)

![Double-sided PELA Knob Panel](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/knob-panel/PELA-double-sided-knob-panel.png)

[Double-sided PELA Knob Panel](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/knob-panel/PELA-double-sided-knob-panel.stl)

![PELA Technic Pin](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/PELA-technic-pin.png)

[PELA Technic Pin](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/PELA-technic-pin.stl) (in case you run short and don't want to wait for mail order)

![PELA Technic Axle](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/PELA-technic-axle.png)

[PELA Technic Axle](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/PELA-technic-axle.stl) (adjustable lenth)

![PELA Technic Cross Axle](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/PELA-technic-cross-axle.png)

[PELA Technic Cross Axle](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/PELA-technic-cross-axle.stl) (rigid and flexible drive shafts)

![PELA Sign](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/sign/PELA-sign.png)

[PELA Sign](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/sign/PELA-sign.stl) (label your designs)

![PELA Grove Module](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/grove-module-enclosure/PELA-grove-module-enclosure.png)

[PELA Grove Module](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/grove-module-enclosure/PELA-grove-module-enclosure.stl) (use 4x M3 bolts to assemble or switch to pressure fit)

![PELA HTC Vive Tracker Mount and Screw](https://github.com/PELA-Prototypes/parametric-PELA/blob/master/vive-tracker-mount/PELA-vive-tracker-mount.png)

[PELA HTC Vive Tracker Mount and Screw](https://github.com/PELA-Prototypes/parametric-PELA/blob/master/vive-tracker-mount/PELA-vive-tracker-mount.stl) (for [HTC Vive](https://www.vive.com/), use a standard tripod screw if you prefer)

![PELA Gunrail Mount](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/gunrail-mount/PELA-gunrail-mount.png)

[PELA Gunrail Mount](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/gunrail-mount/PELA-gunrail-mount.stl) (for placing HTC Vive Tracker or other sensors on a real gun)

![PELA Gunrib Mount](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/gunrail-mount/PELA-gunrib-mount.png)

[PELA Gunrib Mount](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/gunrail-mount/PELA-gunrib-mount.stl) (alternative attachment when there is no accessory rail on the gun)

![PELA Endcap Enclosure](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/endcap-enclosure/PELA-endcap-enclosure.png)

[PELA Endcap Enclosure](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/endcap-enclosure/PELA-endcap-enclosure.stl) (adjust the parameters to fit around something)

![PELA Intel Compute Stick Enclosure](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/endcap-enclosure/PELA-endcap-intel-compute-stick-enclosure.png)

[PELA Intel Compute Stick Enclosure](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/endcap-enclosure/PELA-endcap-intel-compute-stick-enclosure.stl) (a computer inside your robot)


Collaboration and pull requests are welcome: https://github.com/LEGO-Prototypes/PELA-parametric-blocks


## FFF Printing Tips ##

* Use a 0.4mm or smaller nozzle if possible to avoid decimation of some details (inside vertical shell bars..)
* If slicing with Simplify 3D with 0.5mm or larger nozzle, either expand the ring_thickness (and risk stiff bottom connectors) or set Advanced | External Thing Wall Type | Allow single extrusion walls
* Be aware that Cura Engine may in some cases not be able to correct OpenSCAD STL export errors. These errors should be visible in layer preview as for example extra excursions back to origin. If this happens, open and clean the STL files first (Windows 3D Builder, Meshmixer, Meshlab..).

## Resin Printing Tips ##

* If more than 2 layer tall PELA with a relatively solid interior not allowing drainage below the knobs, check if you need to expand the airhole to allow resin to drain from the flexture chamber inside each knob
* For translucent materials, setting knob_slice_count to 0 may make the interior structure look more like a standard PELA at the cost of a slight reduction of knob sidewall flex

## Sponsor ##

Special thanks to [Futurice](http://futurice.com) for sponsoring this design work. Futurice supports truly open innovation.

## License ##

Creative Commons Attribution ShareAlike NonCommercial License
https://creativecommons.org/licenses/by-sa/4.0/legalcode

## Contact ##

paul.houghton@futurice.com ( **[Blog](https://medium.com/@paulhoughton)** - **[Twitter](https://twitter.com/mobile_rat)** )
