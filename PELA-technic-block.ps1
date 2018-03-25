# Generate a 3D-printable PELA using command line parameters
#
# PELA Parametric Blocks - 3D Printed LEGO-compatible parametric blocks
# Published at http://PELAblocks.org
# Part of https://github.com/LEGO-Prototypes/PELA-parametric-blocks

param (
    [Int]$l = 4,
    [Int]$w = 2,
    [Int]$h = 1,
    [String]$filename = "PELA-technic-block-",
    [switch]$stl = $false,
    [switch]$png = $false,
    [switch]$clean = $false,
    [String]$outdir = "."
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

$fullname = $outdir + "\" + $filename + $l + "-" + $w + "-" + $h + ".stl"

$start = Get-Date

$param = "`"l=$l; w=$w; h=$h;`""

if ($stl) {
    Write-Output "Render $fullname as STL"
    openscad -o $fullname PELA-technic-block.scad -D $param
    Write-Output ""
}

if ($clean) {
    Invoke-Expression "clean\clean.ps1 $name.stl"
}

if ($png) {
    Write-Output "Render $imagename as PNG"
    openscad --render -o $imagename PELA-technic-block.scad -D $param
    Write-Output ""
}

$elapsed = FormatElapsedTime ((Get-Date) - $start)
Write-Output "Total time for $fullname : $elapsed"
Write-Output ""
