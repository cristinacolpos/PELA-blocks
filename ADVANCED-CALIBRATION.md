# PELA Blocks
## Advanced Calibration

## Backing Up Your Calibration Files

If you later update the PELA-blocks project to a newer version, you risk overwirting and loosing your calibration customizations. The simplest solution is to create a backup copy those settings.

1. `cd PELA-Blocks`
1. `cp parameters.scad ../PELA-parameters-backup.scad`
1. `cp print-parameters.scad ../PELA-print-parameters-backup.scad`

## Calibration Block Set (optional)

![PELA Calibration Set](calibration/PELA-calibration-set.png)

[3D PELA Calibration Block Set](https://github.com/LEGO-Prototypes/PELA-parametric-blocks/blob/master/calibration/PELA-calibration-set.stl)

These individual blocks provide technic hole size calibration and can be used more flexibly. The technic holes vary in size. Enter the desired number as `axle_hole_tweak` in [`print-parameters.scad`](print-parameters.scad)

## Other Parameters (optional)

Other parametric model parameters affecting all designs are available in [`parameters.scad`](parameters.scad). The effect of each setting is documented, or you can test the effect by changing the number and observing the result.

## CAD File Organization

All models include `print-parameters.scad` and `parameters.scad` directly. Most also include `block.scad` and `technic-block.scad`. When you make changes to these files and save to disk, the preview imnage will update automatically. Press `F6` for a more accurate rendering.

OpenSCAD modules accept parameters which you can change to get various effects and shapes. Default values are set in the files. Call the module with only the parameters you are setting away from the default.

OpenSCAD treats a variable values passed in from the command line is a constant. This constant value overrides the defaults in the file. You can find examples of this in `block.scad`.
