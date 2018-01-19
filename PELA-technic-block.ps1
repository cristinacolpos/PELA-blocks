# Generate a 3D-printable PELA using command line parameters
# Windows Powershell
# Part of https://github.com/paulirotta/parametric_PELA

param (
    [Int]$l = 4,
    [Int]$w = 2,
    [Int]$h = 1,
    [String]$filename = "PELA-technic-block",
    [switch]$png = $false
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

$imagename = $filename + $l + "-" + $w + "-" + $h + ".png"

$filename = $filename + $l + "-" + $w + "-" + $h + ".stl"

$start = Get-Date

$param = "`"l=$l; w=$w; h=$h;`""

Write-Output "Render $filename"

openscad --o $filename.stl -D $param PELA-technic-block.scad

if ($png) {
    Write-Output "Render $imagename"
    openscad --render -o $imagename --D $param PELA-technic-block.scad
}

$elapsed = FormatElapsedTime ((Get-Date) - $start)
Write-Output "Render time: $elapsed"
Write-Output ""
