# Generate a set of 3D-printable LEGOs to demonstrate and exercise the script
# Windows Powershell
# Part of https://github.com/paulirotta/parametric_lego


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
    Write-Output "Render $name"
    $start = Get-Date
    Invoke-Expression "openscad -o $name.stl $name.scad"
    $elapsed = FormatElapsedTime ((Get-Date) - $start)
    Write-Output "Render time: $elapsed for $name"
    Write-Output ""        
}

Write-Output "Generating LEGOs"
Write-Output "================"
Get-Date
Write-Output "Removing old .stl files"
Get-ChildItem * -Include *.stl -Recurse | Remove-Item
Write-Output ""

render(".\technic-pin")
render(".\technic-axle")
render(".\technic-cross-axle")
render(".\lego-calibration\lego-calibration")
render(".\lego-hand\lego-hand")

Invoke-Expression ".\lego.ps1 1 1 1"
Invoke-Expression ".\lego.ps1 2 2 1"
Invoke-Expression ".\lego.ps1 2 2 2"
Invoke-Expression ".\lego.ps1 4 2 1"
Invoke-Expression ".\technic.ps1 4 4 2"

render(".\lego-sign\lego-sign")
render(".\lego-motor\lego-motor")
render(".\lego-knob-panel\lego-knob-panel")
render(".\lego-knob-panel\lego-double_sided-knob-panel")
render(".\lego-socket-panel\lego-socket-panel")
render(".\lego-gunrail-mount\lego-gunrail-mount")
render(".\lego-gunrail-mount\lego-gunrib-mount")
render(".\lego-endcap-enclosure\lego-endcap-enclosure")
render(".\lego-endcap-enclosure\lego-endcap-intel-compute-stick-enclosure")
render(".\lego-vive-tracker-mount\lego-vive-tracker-mount")
render(".\lego-vive-tracker-mount\lego-vive-tracker-screw")
render(".\lego-grove-module-enclosure\lego-grove-module-enclosure")

Get-Date
