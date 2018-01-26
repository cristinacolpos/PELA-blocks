# PELA - 3D Printed LEGO-compatible parametric blocks
#
# Generate a set of objects calibrated for your printer by changes to PELA-print-parameters.scad
# See http://PELAblocks.org for more information
# 
# Part of https://github.com/LEGO-prototypes/PELA-parametric-blocks

param (
    [switch]$publish = $false
)

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
    shrink-mesh($name)
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

Function show-png($name) {
    Write-Output "Show $name as PNG"
    $start = Get-Date
    $param = "`"filename=$name.stl;`""
    Invoke-Expression "openscad --render -o $name.png loadstl.scad  --D $param"
    $elapsed = FormatElapsedTime ((Get-Date) - $start)
    Write-Output "PNG Render time: $elapsed for $name"
    Write-Output ""        
}

Function shrink-mesh($name) {
    Write-Output "Shrink Mesh $name.stl"
    Invoke-Expression "meshlabserver.exe -i $name.stl -s clean.mlx -o $name.stl"    
    # Invoke-Expression "meshlabserver.exe -i $name.stl -o $name.stl"    
}

Write-Output "Generating PELA Blocks"
Write-Output "======================"
Get-Date
Write-Output "Removing old STL and PNG files"
Get-ChildItem * -Include *.stl -Recurse | Remove-Item
Get-ChildItem * -Include *.png -Recurse | Remove-Item
Write-Output ""

Invoke-Expression ".\PELA-block.ps1 4 2 1 -png"
Invoke-Expression ".\PELA-technic-block.ps1 4 4 2 -png"

render(".\PELA-technic-pin")
render(".\PELA-technic-axle")
render(".\PELA-technic-cross-axle")
render(".\calibration\PELA-calibration")
render(".\calibration\PELA-calibration-set")
render(".\sign\PELA-sign")
render(".\sign\PELA-panel-sign")
render(".\motor-enclosure\PELA-motor-enclosure")
render(".\knob-panel\PELA-knob-panel")
render(".\knob-panel\PELA-double-sided-knob-panel")
render(".\socket-panel\PELA-socket-panel")
render(".\gunrail-mount\PELA-gunrail-mount")
render(".\gunrail-mount\PELA-gunrib-mount")
render(".\endcap-enclosure\PELA-endcap-enclosure")
render(".\endcap-enclosure\PELA-endcap-intel-compute-stick-enclosure")
render(".\vive-tracker-mount\PELA-vive-tracker-mount")
render(".\vive-tracker-mount\PELA-vive-tracker-screw")
render(".\grove-module-enclosure\PELA-grove-module-enclosure")

Get-Date

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
