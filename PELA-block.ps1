# Generate a 3D-printable PELA using command line parameters
#
# PELA Parametric Blocks - 3D Printed LEGO-compatible parametric blocks
# Published at http://PELAblocks.org
# Part of https://github.com/LEGO-Prototypes/PELA-parametric-blocks

param (
    [Int]$l = 4,
    [Int]$w = 2,
    [Int]$h = 1,
    [String]$filename = "PELA-block-",
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

# Not working, problems with ""*` string parameter passing
Function show-png($name) {
    Write-Output "Show $name as PNG"
    $start = Get-Date
    $expression = "openscad loadstl.scad --render -o $name.png --D ``filename=`"$name.stl`";``"
    Write-Output $expression
    # The goal: openscad loadstl.scad --render -o PELA-block-1-1-1.png --D 'filename=\"PELA-block-1-1-1.stl\";'
    Invoke-Expression $expression
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
    Invoke-Expression "meshlabserver.exe -i $name -s clean.mlx -o $name"    
    # Invoke-Expression "meshlabserver.exe -i $name -o $name"    
}

$imagename = $filename + $l + "-" + $w + "-" + $h + ".png"

$fullname = $filename + $l + "-" + $w + "-" + $h + ".stl"

$start = Get-Date

$param = "`"l=$l; w=$w; h=$h;`""

Write-Output "Render $fullname"

openscad -o $fullname -D $param PELA-block.scad

shrink-mesh($fullname)

if ($png) {
    # Write-Output "Show $imagename"
    openscad --render -o $imagename -D $param PELA-block.scad
    # show-png($filename)
}

$elapsed = FormatElapsedTime ((Get-Date) - $start)
Write-Output "Render time: $elapsed"
Write-Output ""
