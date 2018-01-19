# PELA - 3D Printed LEGO-compatible parametric blocks
#
# Generate a set of objects calibrated by changes to print-parameters.scad
#
# Windows Powershell
# Part of https://github.com/LEGO-prototypes/PELA-parametric-blocks


Function FormatElapsedTime($ts) {
    $elapsedTime = ""

    if ( $ts.Minutes -gt 0 ) {
        $elapsedTime = [string]::Format( "{0:00}m {1:00}.{2:00}s", $ts.Minutes, $ts.Seconds, $ts.Milliseconds / 10 );
    }
    else {
        $elapsedTime = [string]::Format( "{0:00}.{1:00}s", $ts.Seconds, $ts.Milliseconds / 10 );
    }

    if ($ts.Hours -eq 0 -and $ts.Minutes -eq 0 -and $ts.Seconds -eq 0) {
        $elapsedTime = [string]::Format("{0:00}ms", $ts.Milliseconds);
    }

    if ($ts.Milliseconds -eq 0) {
        $elapsedTime = [string]::Format("{0}ms", $ts.TotalMilliseconds);
    }

    return $elapsedTime
}

Function render($name) {
    Write-Output "Render $name as STL"
    $start = Get-Date
    Invoke-Expression "openscad -o $name.stl $name.scad"
    $elapsed = FormatElapsedTime ((Get-Date) - $start)
    Write-Output "STL Render time: $elapsed for $name"
    Write-Output ""
    render-png($name)
}

Function render-png($name) {
    Write-Output "Render $name as PNG"
    $start = Get-Date
    Invoke-Expression "openscad --render -o $name.png $name.scad"
    $elapsed = FormatElapsedTime ((Get-Date) - $start)
    Write-Output "PNG Render time: $elapsed for $name"
    Write-Output ""        
}

Function ConvertTo-Jpg {
    [cmdletbinding()]
    param([Parameter(Mandatory = $true, ValueFromPipeline = $true)] $Path)

    process {
        if ($Path -is [string])
        { $Path = get-childitem $Path }

        $Path | ForEach-Object {
            $image = [System.Drawing.Image]::FromFile($($_.FullName));
            $FilePath = [IO.Path]::ChangeExtension($_.FullName, '.jpg');
            $image.Save($FilePath, [System.Drawing.Imaging.ImageFormat]::Jpeg);
            $image.Dispose();
        }
    }
}

Write-Output "Generating PELA Blocks"
Write-Output "======================"
Get-Date
Write-Output "Removing old .stl, .png and .jpg files"
Get-ChildItem * -Include *.stl -Recurse | Remove-Item
Get-ChildItem * -Include *.png -Recurse | Remove-Item
Get-ChildItem * -Include *.jpg -Recurse | Remove-Item
Write-Output ""

Invoke-Expression ".\PELA-block.ps1 4 2 1 -png"
Invoke-Expression ".\PELA-technic-block.ps1 4 4 2 -png"

render(".\PELA-technic-pin")
render(".\PELA-technic-axle")
render(".\PELA-technic-cross-axle")
render(".\calibration\PELA-calibration")
render(".\sign\PELA-sign")
render(".\motor-enclosure\PELA-motor-enclosure")
render(".\knob-panel\PELA-knob-panel")
render(".\knob-panel\PELA-double_sided-knob-panel")
render(".\socket-panel\PELA-socket-panel")
render(".\gunrail-mount\PELA-gunrail-mount")
render(".\gunrail-mount\PELA-gunrib-mount")
render(".\endcap-enclosure\PELA-endcap-enclosure")
render(".\endcap-enclosure\PELA-endcap-intel-compute-stick-enclosure")
render(".\vive-tracker-mount\PELA-vive-tracker-mount")
render(".\vive-tracker-mount\PELA-vive-tracker-screw")
render(".\grove-module-enclosure\PELA-grove-module-enclosure")

Write-Output "Converting .png files to .jpg"
Get-ChildItem *.png | ConvertTo-Jpg

Get-Date