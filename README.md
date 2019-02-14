# PELA Blocks

## LEGO-compatible Parametric 3D Printed Blocks

PELA blocks are designed for easy 3D printing, strength, and rapid customization using free software. One time calibration gives perfect snap-together objects in exotic materials and geometries to help you explore your ideas and build with exotic materials and any motors and electronics you like. Example enclosures with many options for custom sensors, actuators, computers and IoT devices are included, or create your own.

These designs are not by the LEGO corporation. LEGO-compatible blocks are available from multiple manufacturers. Associated basic block patents expired long ago. Press-fit blocks existed before LEGO and we continue that tradition of adapt, evolve and improve as we provide these open source designs for 3D printing.

The name PELA comes from the Finnish "pelataan" meaning "let's play".

## Open source design, Powered By Futurice

[![Futurice](images/futurice-logo.jpg)](https://futurice.com)

These open source designs are brought to you by [Futurice](https://futurice.com) and contributions from the community. Come work with the best.

## Customizer

The software needed is also free and open source, [OpenSCAD](http://www.openscad.org/). Newer "development snapshot" versions of [OpenSCAD](http://www.openscad.org/) make tailoring designs very easy. Enable `Edit | Preferences | Features | Customizer` and set `Edit | Preferences | Advanced | Turn off rendering at _1000000_` since some PELA models are quite large.

![OpenSCAD Customizer with PELA Technic Block](images/pela-customizer.jpg)


## Download

**The STL files shown are not calibrated for your printer.** To get a good snap fit with your 3D printer and different material, you need to fine tune the size of knobs, sockets and technic holes. Some starting values are 

1. **[DOWNLOAD](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/archive/master.zip)** the latest designs, or `git clone git@github.com:LEGO-Prototypes/PELA-parametric-blocks.git --recurse-submodules`, then `git lfs install` in each git module
1. **[Calibrate](#calibrate)** the PELA Block models for your material and printer

See [Advanced Setup](ADVANCED-SETUP.md) for additional tricks.

See the [Slicer Recommendations](SLICER.md) for information about different printing materials we have tested.

## Calibrate

**TL;DR** *: To get a nice snap fit for your printer, slicer settings and material, print a calibration bar and test fit commercial bricks to the top knobs, bottom sockets and side technic holes. Update the best `top_tweak` and `bottom_tweak` into [`material.scad`](material.scad). Now open any model in OpenSCAD, press `F6` to generate the model then `F7` to export an STL.*

[![PELA Example fit of a calibration block](images/PELA-calibration-test-fit-with-LEGO.jpg)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master//PELA-calibration.stl)

There are several possible calibration bars. Most users will want the one linked below unless they are printing with flexible filament.

Test fit the top, bottom and sides to get something which is tight but not too tight. Then update your settings in  [`material.scad`](https://github.com/PELA-Prototypes/parametric-PELA/blob/master/material.scad) then one time calibration is complete.

___

[![PELA Calibration Bar, Normal Filament](/PELA-calibration.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/PELA-calibration.stl)

[PELA Calibration Bar, Normal Filament](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/PELA-calibration.stl) PELA Calibration Bar for standard filament (non-flexible).

### Calibration Instructions

Your printer, slicer settings, and plastic effect the precise fit. To correct for this, we adjust the models slightly for your printing process. Calibration is a one time process for each material. It is as simple as fitting two blocks together and editing a text file, [`material.scad`](material.scad) to indicate which test block fits best.

Before you print the calibration bar, be sure to set the `flexible_material` and `large_nozzle` settings in [`material.scad`](https://github.com/PELA-Prototypes/parametric-PELA/blob/master/material.scad).

After you print the clibration bar, you update three settings to get a tight fit: `top_tweak`, `bottom_tweak` and `axle_hole_tweak`. These can be read from the side of the calibration bar.

1. Print the Calibration Bar and test fit the top knobs and bottom sockets against commercial LEGO. Put the `top_tweak` (on the side, near the top) and `bottom_tweak` (on the side, near the bottom) values that you can read from the side of the bar into `material.scad`.
1. Use OpenSCAD to generate a new 2x2x1 `PELA Block` in OpenSCAD using these new settings, press `F6` to render, and `Export` as `.STL`.
1. Confirm a good fit with both commercial blocks and other PELA Blocks.
1. If you find you also need to adjust the technic connector hole size, print the Calibration Block Set. `axle_hole_tweak` numbers change along with `top_tweak` numbers.
1. Repeat this process as needed when you change material, nozzle size or and slicer settings which affect geometry.

## Advanced Calibration

An alternative set of individual calibration blocks are available, and if you have an unusual material there are other numbers you can tune such as various part thicknesses. See [Advanced Calibration](ADVANCED-CALIBRATION)

## PELA-compatible Part Designs

Edit `material.scad` and `style.scad` to adapt these models before printing them. **The example models below are not yet calibrated for your slicer and printer. Calibrate and then make the tuned model from the .scad file.**

[![PELA Block](/PELA-block.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/PELA-block.stl)

[PELA Block](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/PELA-block.stl)

___

[![PELA Technic Block](/PELA-technic-block.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/PELA-technic-block.stl) An old style simple block. All models derive from this.

[PELA Block with technic connectors](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/PELA-technic-block.stl) A blending of traditional and technic features which extends the basic block. All other models are extensions and vaiants from this.

___

[![PELA Technic Bar](/technic-bar/PELA-technic-bar.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-bar/PELA-technic-bar.stl)

[PELA Technic Bar](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-bar/PELA-technic-bar.stl) A minimalist technic bar.

___

[![PELA Technic Bar](/technic-bar/PELA-technic-twist-bar.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-bar/PELA-technic-twist-bar.stl)

[PELA Technic Bar](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-bar/PELA-technic-twist-bar.stl) A technic bar with a center section of holes rotated 90 degrees.

___

[![PELA Technic Corner](/technic-bar/PELA-technic-corner.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-bar/PELA-technic-corner.stl)

[PELA Technic Corner](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-bar/PELA-technic-corner.stl) Two bars joined at an angle.

___

[![PELA Technic Angle Connector](/technic-bar/PELA-technic-angle-connector.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-bar/PELA-technic-angle-connector.stl)

[PELA Technic Angle Connector](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-bar/PELA-technic-angle-connector.stl) Two technic bar connected vertically at an angle.

___

[![PELA Technic Axle](/axle/PELA-technic-axle.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/axle/PELA-technic-axle.stl)

[PELA Technic Axle](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/axle/PELA-technic-axle.stl) Rigid and flexible material shafts of adjustable length for attaching to other 3D printed designs such as wheels which you want to rotate freely.

___

[![PELA Technic Cross Axle](/axle/PELA-technic-cross-axle.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/axle/PELA-technic-cross-axle.stl)

[PELA Technic Cross Axle](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/axle/PELA-technic-cross-axle.stl) Rigid and flexible material torque drive shafts for adjustable length for attaching to other 3D printed designs.

___

[![PELA Socket Panel](/PELA-socket-panel.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/PELA-socket-panel.stl)

[PELA Socket Panel](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/PELA-socket-panel.stl) Insert knobs from both the top and bottom. Zoom in to see the subtle flexure ridges for enhanced "snap" fit.

___

[![PELA Knob Panel](/PELA-knob-panel.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/PELA-knob-panel.stl)

[PELA Knob Panel](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/PELA-knob-panel.stl) Optional corner holes for M3 bolts can be enabled

___

[![PELA Technic Pin](/pin/PELA-technic-pin.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/pin/PELA-technic-pin.stl)

[PELA Technic Pin](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/pin/PELA-technic-pin.stl) This is difficult to print with some material, but useful you run short and don't want to wait for mail order. It works best with slightly flexible materials.

___

[![PELA Technic Pin Array](/pin/PELA-technic-pin-array.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/pin/PELA-technic-pin-array.stl)

[PELA Technic Pin Array](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/pin/PELA-technic-pin-array.stl) A set of technic pins for multi-point connection.

___

[![PELA Raspberry Pi 3B Technic Mount](/technic-mount/PELA-raspberry-pi3-technic-mount.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-mount/PELA-raspberry-pi3-technic-mount.stl)

[PELA Raspberry Pi 3B Technic Mount](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-mount/PELA-raspberry-pi3-technic-mount.stl) A Raspberry Pi 2/3 holder.

___

[![PELA Raspberry Pi 3B Technic Cover](/technic-mount/PELA-raspberry-pi3-technic-cover.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-mount/PELA-raspberry-pi3-technic-cover.stl)

[PELA Raspberry Pi 3B Technic Cover](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-mount/PELA-raspberry-pi3-technic-cover.stl) A Raspberry Pi 2/3 holder top cover.

___

[![PELA Raspberry Pi Camera Technic Mount](/technic-mount/PELA-raspberry-pi3-camera-technic-mount.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-mount/PELA-raspberry-pi3-camera-technic-mount.stl)

[PELA Raspberry Pi Camera Technic Mount](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-mount/PELA-raspberry-pi3-camera-technic-mount.stl) A Raspberry Pi 3 camera holder.

___

[![PELA Technic PIR Motion Sensor Mount](/technic-mount/PELA-pir-technic-mount.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-mount/PELA-pir-technic-mount.stl)

[PELA PIR Motion Sensor Technic Mount](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-mount/PELA-pir-technic-mount.stl) A pulsed infra-red motion sensor holder.

___

[![PELA Technic NodeMCU v2 Mount](/technic-mount/PELA-nodemcu-v2-technic-mount.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-mount/PELA-nodemcu-v2-technic-knob-mount.stl)

[PELA Technic NodeMCU v2 Mount](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-mount/PELA-nodemcu-v2-technic-mount.stl) A technic mount for NodeMCU v2.

___

[![PELA Technic Seeed Respeaker Core v2 Mount](/technic-mount/PELA-respeaker-core-v2-mount.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-mount/PELA-respeaker-core-v2-mount.stl)

[PELA Technic Seeed Respeaker Core v2 Mount](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/technic-mount/PELA-respeaker-core-v2-mount.stl) A technic mount for the Respeaker Core v2 microphone array.

___

[![PELA Sign](/sign/PELA-vertical-sign.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/sign/PELA-vertical-sign.stl)

[PELA Sign](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/sign/PELA-vertical-sign.stl) Change the text to label your designs. Options include front and back text with either etched for raised text.

___

[![PELA Panel Sign](/sign/PELA-panel-sign.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/sign/PELA-panel-sign.stl)

[PELA Panel Sign](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/sign/PELA-panel-sign.stl) Change the text to label your design either edtched for raised text.

___

[![PELA Box Enclosure](/box-enclosure/PELA-box-enclosure.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/enclosure/PELA-box-enclosure.stl)

[PELA Box Enclosure](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/box-enclosure/PELA-box-enclosure.stl) A generic enclosure for mounting boards inside protective side walls.
___

[![PELA STMF4 Discovery Box Enclosure](/box-enclosure/PELA-stmf4discovery-box-enclosure.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/box-enclosure/PELA-stmf4discovery-box-enclosure.stl)

[PELA STMF4 Discovery Box Enclosure](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/box-enclosure/box-enclosure/PELA-stmf4discovery-box-enclosure.stl) Enclosure for the [STMF4 Discovery](http://www.st.com/en/evaluation-tools/stm32f4discovery.html) board.

___

[![PELA Intel Compute Stick Box Enclosure](/box-enclosure/PELA-intel-compute-stick-box-enclosure.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/box-enclosure/PELA-intel-compute-stick-box-enclosure.stl)

[PELA Intel Compute Stick Box Enclosure](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/box-enclosure/PELA-intel-compute-stick-box-enclosure.stl) Enclosure for the [Intel Compute Stick](https://www.intel.com/content/www/us/en/products/boards-kits/compute-stick.html)

___

[![PELA Intel Compute Stick Box Lid](/box-enclosure/PELA-intel-compute-stick-box-lid.png)](https://github.com/LEGO-compatible-gadgets/box-enclosure/PELA-parametric-blocks/blob/master/PELA-intel-compute-stick-box-lid.stl)

[PELA Intel Compute Stick Box Lid](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/box-enclosure/PELA-intel-compute-stick-box-lid.stl) Enclosure cover. You may prefer a knobbed or flat panel, but ensure proper ventilation.

___

[![PELA Grove Module](/PELA-grove-module-enclosure.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/PELA-grove-module-enclosure.stl)

[PELA Grove Module](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/PELA-grove-module-enclosure.stl) Attach a SEEED Grove module to your build such as a plug-in electronic sensors (ultrasound, touch..) with a 4 wire plug in connector. Snap your design together without soldering.

___

[![PELA Servo Motor Enclosure](/motor-enclosure/PELA-servo-motor-enclosure.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/motor-enclosure/PELA-servo-motor-enclosure.stl)

[PELA Servo Motor Enclosure](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/motor-enclosure/PELA-servo-motor-enclosure.stl) Add a round servo motor holder for 1:10 electric cars

___

[![PELA N20 Gearmotor Enclosure](/PELA-n20-gearmotor-enclosure.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/motor-enclosure/PELA-n20-gearmotor-enclosure.stl)

[PELA N20 Gearmotor Enclosure](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/motor-enclosure/PELA-n20-gearmotor-enclosure.stl) Add a commonly available small gear motor to your design. Adjust the model parameters to fit other motor sizes.

___

[![PELA HTC Vive Tracker Mount](/vive-tracker/PELA-vive-tracker-mount.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/vive-tracker/PELA-vive-tracker-mount.stl)

[PELA HTC Vive Tracker Mount](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/vive-tracker/PELA-vive-tracker-mount.stl) [HTC Vive Tracker](https://www.vive.com/) attachment to your designs becomes easy to remove.

___

[![PELA Camera Mount Screw](/vive-tracker/PELA-camera-mount-screw.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/vive-tracker/PELA-camera-mount-screw.stl)

[PELA Camera Mount Screw](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/vive-tracker/PELA-camera-mount-screw.stl) You can use this quarter inch standard camera mount screw for flush mounting the HTC Vive to the Vive Tracker Mount. The printed version works better than you might expect.

___

[![PELA Strap Mount](/PELA-strap-mount.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/PELA-strap-mount.stl)

[PELA Strap Mount](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/PELA-strap-mount.stl) For attaching using strap or similar straps through the bottom slot. For example use this with velcro straps to mount Vive trackers on your shoes..

___

[![PELA PCA9685 16 Channel Servo Board Mount](/knob-mount/PELA-pca9685-servo-knob-mount.png)](https://github.com/LEGO-compatible-gadgets/knob-mount/PELA-parametric-blocks/blob/master/PELA-pca9685-servo-knob-mount.stl)

[PELA PCA9685 16 Channel Servo Board Mount](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/knob-mount/PELA-pca9685-servo-knob-mount.stl) For holding a servo board within a PELA block with connectors exposed at one end. We use these with 1:10 RC drift cars and Rasperry Pi for a [PELA drift car](https://driftcar.pelablocks.org/) in the [Markku Invitational](https://markku.ai/) contest based on [Donkeycar](http://www.donkeycar.com/).

___

[![PELA Knob Mount](/knob-mount/PELA-knob-mount.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/knob-mount/PELA-knob-mount.stl)

[PELA Knob Board Mount](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/knob-mount/PELA-nodemcu-32s-knob-mount.stl) For holding relatively flat objects like a microcontroller within a PELA block that has knobs on top

___

[![PELA NodeMCU-32s Board Mount](/knob-mount/PELA-nodemcu-32s-knob-mount.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/knob-mount/PELA-nodemcu-32s-knob-mount.stl)

[PELA NodeMCU-32s Board Mount](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/knob-mount/PELA-nodemcu-32s-knob-mount.stl) For holding an NodeMCU-32s microcontroller board within a PELA block

___

[![PELA NodeMCU v2 Board Mount](/knob-mount/PELA-nodemcu-v2-knob-mount.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/knob-mount/PELA-nodemcu-v2-knob-mount.stl)

[PELA NodeMCU v2 Board Mount](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/knob-mount/PELA-nodemcu-v2-knob-mount.stl) For holding an NodeMCU v2 microcontroller board within a PELA block

___

[![PELA Arduino Mega Board Mount](/knob-mount/PELA-arduino-mega-knob-mount.png)](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/knob-mount/PELA-arduino-mega-knob-mount.stl)

[PELA Arduino Mega Board Mount](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks/blob/master/knob-mount/PELA-aruino-mega-knob-mount.stl) For holding an Arduino Mega within a PELA block

## FFF Printing Tips

* Use a 0.4mm or smaller nozzle if possible to avoid decimation of some socket details
* If slicing with Simplify 3D with 0.5mm or larger nozzle, you may want to set Simplify 3D to `Advanced | External Thing Wall Type | Allow single extrusion walls`
* Be aware that slicers may in some cases not be able to correct OpenSCAD STL export errors. These errors should be visible in layer preview as for example extra excursions back to origin. If this happens, open and clean the STL files first with for example Microsoft 3D Builder, Meshmixer or MeshLab. MeshLab command line examples can be found in `build.ps1`.
* Best results are achieved with durable materials that are not too stiff (PET, co-polymers like NGEN, semi-flexible and "engineering" materials instead of PLA and  carbon filled).
* Best results are achieved with smaller nozzle diameters. Adjust slicer settings for precision over speed. Layer height is not particularly important on most models.
* Think carefully before using very slippery materials such as Nylon.
* "standard" and "fast" print setting layer lines are helpful for extra connector grip provided the resulting print geometry is sufficiently accurate.
* A print "brim" the appears inside the model may negatively affect the bottom connector fit
* Leaving the blocks on a heated bed may negatively affect the bottom connector fit

## Resin Printing Tips

* If more than 2 layer tall PELA with a relatively solid interior not allowing drainage below the knobs, check if you need to expand the airhole to allow resin to drain from the flexure chamber inside each knob
* For translucent materials, setting knob_slice_count to 0 may make the interior structure look more like a standard PELA at the cost of a slight reduction of knob sidewall flex

## License

[![License: CC BY-SA 4.0](https://licensebuttons.net/l/by-sa/3.0/88x31.png)](https://creativecommons.org/licenses/by-sa/4.0/)

These designs are by PELA project contributors, not by the LEGO corporation. They are compatible with LEGO and similar blocks available from multiple manufacturers and online projects. The associated patents have expired. These designs are not identical to LEGO; they have been specially modified for easy 3D printing and offered in the spirit of open source collaborative innovation.

If what you want is available as injection molded plastic, buy it for the higher quality and durability. These model are helpful when you want something customized, a special color, an unusual material, and for replacement parts when you just can't wait.

## Projects Using PELA Blocks

PELA has been used to create a self-driving car: [![3D Printed LEGO-compatible Parametric 1:10 Scale RC Drift Car Based On PELA Blocks](https://driftcar.pelablocks.org/images/pela-drift-car.jpg)](https://driftcar.pelablocks.org)

PELA is also used to create robot parts: [![3D Printed LEGO-compatible Parametric Robot Hand](http://robothand.pelablocks.org/PELA-robot-hand.png)](https://robothand.pelablocks.org)

The generated 3D models displayed here are hosted in a separate GitHub project to minimize the size of pulling changes in this repo: [PELA-parametric-blocks](https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks)

## Alternative 3D Block Designs

If you don't find what you need, consider adding it, contact us or check out the many other excellent design available.

[Yeggi search for LEGO](http://www.yeggi.com/q/lego/)

[Thingiverse Parametric LEGO Group](https://www.thingiverse.com/groups/parametric-lego) are alternate source of these and other block designs.

## Contact

New models, collaboration and pull requests are welcome. You have the tools- now create something cool and share with the world : https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks

paul.houghton@futurice.com ( **[Blog](https://medium.com/@paulhoughton)** - **[Twitter](https://twitter.com/mobile_rat)**)

If you like what you see, please tweet and let others know!

[![Twitter link](images/share-twitter-button.jpg)](https://twitter.com/intent/tweet?screen_name=mobile_rat&hashtags=PELAblocks&related=mobile_rat&text=Engineering-grade%203D%20printed%20LEGO%20prototypes&tw_p=tweetbutton&url=http%3A%2F%2Fpelablocks.org)
