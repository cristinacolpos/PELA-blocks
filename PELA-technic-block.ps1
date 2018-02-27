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
    [switch]$clean = $false
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

# Shrinking to save space and fix some OpenSCAD export artifacts is done in
# several discrete steps to minimize memory stress with large models
Function shrink-mesh($name) {
    Write-Output "Shrink Mesh $name"
    Invoke-Expression "meshlabserver.exe -i $name -s clean1.mlx -o $name"
    Invoke-Expression "meshlabserver.exe -i $name -s clean2.mlx -o $name"
    Invoke-Expression "meshlabserver.exe -i $name -s clean3.mlx -o $name"
    Invoke-Expression "meshlabserver.exe -i $name -s clean4.mlx -o $name"
    Invoke-Expression "meshlabserver.exe -i $name -s clean5.mlx -o $name"
    Invoke-Expression "meshlabserver.exe -i $name -s clean6.mlx -o $name"
}

$imagename = $filename + $l + "-" + $w + "-" + $h + ".png"

$fullname = $filename + $l + "-" + $w + "-" + $h + ".stl"

$start = Get-Date

$param = "`"l=$l; w=$w; h=$h;`""

if ($stl) {
    Write-Output "Render $fullname as STL"
    openscad --o $fullname -D $param PELA-technic-block.scad
    Write-Output ""
}

if ($clean) {
    Write-Output "Clean $fullname"
    shrink-mesh($fullname)
    Write-Output ""
}

if ($png) {
    Write-Output "Render $imagename as PNG"
    openscad --render -o $imagename --D $param PELA-technic-block.scad
    Write-Output ""
}

$elapsed = FormatElapsedTime ((Get-Date) - $start)
Write-Output "Total time for $fullname : $elapsed"
Write-Output ""
