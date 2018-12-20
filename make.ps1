# PELA - 3D Printed LEGO-compatible parametric blocks
#
# Generate a set of objects calibrated for your printer by changes to print-parameters.scad
# See https://PELAblocks.org for more information
#
# Part of https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks
#
# The parameters turn on generation of various features. Note that STLs are .gitignore so you can create them
# locally without impacting publishing. Published PNGs are generated in this project. They must be here because of
# how github pages markdown works). Published STLs for the website are generated in the sister project
# https://github.com/LEGO-compatible-gadgets/PELA-parametric-blocks-render to minimize your pain of large file
# gitthrashing as the project evolves. The $outdir parameter is used by this sister project when updating generated
# STLs so you can safely ignore it.

param (
    [switch]$stl = $false, # Generate models with current print calibration (.gitignore)
    [switch]$png = $false, # Generate preview images for the website
    [switch]$clean = $false, # Clean some model defects and re-save as binary STL (1/2 the size)
    [switch]$publish = $false, # Publish the result back to the github and the web when done
    [String]$outdir = "."         # In what based directory are generated STL and PNG files written
)

Function FormatElapsedTime($ts) {
    $elapsedTime = ""

    if ( $ts.Minutes -gt 0 ) {
        $elapsedTime = [String]::Format( "{0:00}m {1:00}.{2:00}s", $ts.Minutes, $ts.Seconds, $ts.Milliseconds / 10 );
    }
    else {
        $elapsedTime = [String]::Format( "{0:00}.{1:00}s", $ts.Seconds, $ts.Milliseconds / 10 );
    }

    if ($ts.Hours -eq 0 -and $ts.Minutes -eq 0 -and $ts.Seconds -eq 0) {
        $elapsedTime = [String]::Format("{0:00}ms", $ts.Milliseconds);
    }

    if ($ts.Milliseconds -eq 0) {
        $elapsedTime = [String]::Format("{0}ms", $ts.TotalMilliseconds);
    }

    return $elapsedTime
}

Function render($path, $name) {
    Write-Output ""
    $start = Get-Date
    Write-Output $start
    if ($stl) {
        Write-Output "Render $outdir\$name as STL"
        Remove-Item .\$name.stl 2> $null
        Invoke-Expression "openscad -o $name.stl $path\$name.scad"
        Write-Output "STL Render time: $elapsed for $name"
    }

    if ($clean) {
        Invoke-Expression ".\clean.ps1 $name.stl"
        Write-Output "STL Render time: $elapsed for $name"
    }

    if ($stl) {
        if ($outdir -NE ".") {
            Move-Item .\$name.stl $outdir
        }
        $elapsed = FormatElapsedTime ((Get-Date) - $start)
    }

    if ($png) {
        render-png $path $name
    }
    Write-Output ""
}

# Create a PNG from the .scad file (slow, not pretty, but no Python or POVRay needed)
Function render-png($path, $name) {
    Write-Output "Render $outdir\$name as PNG"
    $start = Get-Date
    Write-Output $start
    Remove-Item .\$name.png 2> $null
    Invoke-Expression "openscad --render -o $name.png $path\$name.scad"
    Remove-Item $outdir\images\$name.png 2> $null
    Move-Item .\$name.png $outdir\images\
    $elapsed = FormatElapsedTime ((Get-Date) - $start)
    Write-Output "PNG Render time: $elapsed for $name"
    Write-Output ""
}

Write-Output "Generating PELA Blocks"
Write-Output "======================"
Write-Output Get-Date

if ($stl) {
    Write-Output "Removing old STL files"
    $extras += " -stl"
}

if ($clean) {
    Write-Output "Cleaning STL files as they are created"
    $extras += " -clean"
}
if ($png) {
    Write-Output "Removing old PNG files"
    $extras += " -png"
}


if ($stl -OR $png -OR $clean) {
    if ($png) {
        Remove-Item $outdir\images\PELA-block-4-2-1.png 2> $null
        Remove-Item $outdir\images\PELA-technic-block-4-4-2.png 2> $null
    }

    Invoke-Expression ".\block.ps1 -l 4 -w 2 -h 1 $extras"
    Invoke-Expression ".\technic-block.ps1 -l 4 -w 4 -h 2 $extras"

    if ($stl) {
        Move-Item .\PELA-technic-block-4-4-2.stl $outdir
        Move-Item .\PELA-block-4-2-1.stl $outdir
    }

    if ($png) {
        Move-Item .\PELA-block-4-2-1.png $outdir\images\
        Move-Item .\PELA-technic-block-4-4-2.png $outdir\images\
    }
}

render ".\knob-mount\" "PELA-raspberry-pi3-knob-mount"
render ".\knob-mount\" "PELA-pca9685-servo-knob-mount"
render ".\knob-mount\" "PELA-nodemcu-32s-knob-mount"
render ".\knob-mount\" "PELA-nodemcu-v2-knob-mount"
render ".\knob-mount\" "PELA-arduino-mega-knob-mount"
render ".\pin\" "PELA-technic-pin"
render ".\pin\" "PELA-technic-pin-array"
render ".\axle\" "PELA-technic-axle"
render ".\axle\" "PELA-technic-cross-axle"
render ".\openbeam\" "PELA-openbeam15-twist-connector"
render ".\calibration\" "PELA-calibration-flex-thick"
render ".\calibration\" "PELA-calibration-flex-thin"
render ".\calibration\" "PELA-calibration-norm-thick"
render ".\calibration\" "PELA-calibration-norm-thin"
render ".\calibration\" "PELA-calibration-set-flex-thick"
render ".\calibration\" "PELA-calibration-set-flex-thin"
render ".\calibration\" "PELA-calibration-set-norm-thick"
render ".\calibration\" "PELA-calibration-set-norm-thin"
render ".\sign\" "PELA-sign"
render ".\sign\" "PELA-panel-sign"
render ".\box-enclosure\" "PELA-stmf4discovery-box-enclosure"
render ".\box-enclosure\" "PELA-sparkfun-pro-micro-box-enclosure"
render ".\box-enclosure\" "PELA-intel-compute-stick-box-enclosure"
render ".\box-enclosure\" "PELA-intel-compute-stick-box-lid"
render ".\motor-enclosure\" "PELA-n20-gearmotor-enclosure"
render ".\technic-bar\" "PELA-technic-bar"
render ".\technic-bar\" "PELA-technic-bar-30degree"
render ".\technic-bar\" "PELA-technic-bar-45degree"
render ".\technic-bar\" "PELA-technic-bar-60degree"
render ".\technic-bar\" "PELA-technic-bar-90degree"
render ".\technic-bar\" "PELA-technic-bar-120degree"
render ".\technic-mount\" "PELA-technic-pi3b-mount"
render ".\technic-mount\" "PELA-technic-pi3b-cover"
render ".\technic-mount\" "PELA-technic-pi3b-corner"
render ".\technic-mount\" "PELA-technic-nodemcu-v2-knob-mount"
render ".\technic-mount\" "PELA-technic-pi-camera-mount"
render ".\technic-mount\" "PELA-technic-respeaker-core-v2-mount"
render ".\technic-mount\" "PELA-technic-respeaker-core-v2-top"
render ".\technic-mount\" "PELA-technic-respeaker-core-v2-clear-ring"
render ".\knob-panel\" "PELA-knob-panel"
render ".\knob-panel\" "PELA-double-sided-knob-panel"
render ".\socket-panel\" "PELA-socket-panel"
render ".\velcro-mount\" "PELA-velcro-mount"
render ".\velcro-mount\" "PELA-vive-velcro-mount"
render ".\vive-tracker-mount\" "PELA-vive-tracker-mount"
render ".\vive-tracker-mount\" "PELA-vive-tracker-screw"
render ".\grove-module-enclosure\" "PELA-grove-module-enclosure"

Write-Output Get-Date

if ($publish) {
    Write-Output "Publishing PELA Blocks"
    Write-Output "======================"
    git status
    git add *.scad
    git add *.png
    git add *.stl
    git commit -m "Publish"
    git push
    git status
}
