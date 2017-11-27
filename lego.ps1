# Generate a 3D-printable LEGO using command line parameters
# Windows Powershell
# Part of https://github.com/paulirotta/parametric_lego

param (
	[Int]$l = 1,
	[Int]$w = 1,
	[Int]$h = 1,
	[Float]$top_tweak = 0.0,
	[Float]$bottom_tweak = 0.0,
	[Float]$knob_height = 1.8,
	[Float]$knob_cutout_height = 4.55,
	[Float]$knob_cutout_radius = 1.25,
	[Float]$knob_cutout_airhole_radius = 0.01,
    [Float]$panel_thickness = 3.2,
    [Float]$skin = 0.1,
    [Int]$mode = 1,
    [Int]$bolt_holes = 0,
	[Int]$fn = 64,
	[Int]$airhole_fn = 16,
    [String]$filename = "lego"
)

Function FormatElapsedTime($ts) 
{
    $elapsedTime = ""

    if ( $ts.Minutes -gt 0 )
    {
        $elapsedTime = [string]::Format( "{0:00}m {1:00}.{2:00}s", $ts.Minutes, $ts.Seconds, $ts.Milliseconds / 10 );
    }
    else
    {
        $elapsedTime = [string]::Format( "{0:00}.{1:00}s", $ts.Seconds, $ts.Milliseconds / 10 );
    }

    if ($ts.Hours -eq 0 -and $ts.Minutes -eq 0 -and $ts.Seconds -eq 0)
    {
        $elapsedTime = [string]::Format("{0:00}ms", $ts.Milliseconds);
    }

    if ($ts.Milliseconds -eq 0)
    {
        $elapsedTime = [string]::Format("{0}ms", $ts.TotalMilliseconds);
    }

    return $elapsedTime
}

If ($mode -eq 2) {
    $filename = $filename+"-panel"
} ElseIf ($mode -eq 3) {
    $filename = $filename+"-calibration"
}

$filename = $filename+$l+"x"+$w+"x"+$h+"t"+$top_tweak+"b"+$bottom_tweak+".stl"

$start = Get-Date

$param = "`"l=$l; w=$w; h=$h; top_tweak=$top_tweak; bottom_tweak=$bottom_tweak; knob_height=$knob_height; knob_cutout_height=$knob_cutout_height; knob_cutout_radius=$knob_cutout_radius; knob_cutout_airhole_radius=$knob_cutout_airhole_radius; fn=$fn; airhole_fn=$airhole_fn; panel_thickness=$panel_thickness; skin=$skin; bolt_holes=$bolt_holes; mode=$mode;`""

echo "Render $filename $param"

openscad -o $filename -D $param lego.scad

$elapsed=FormatElapsedTime ((Get-Date) - $start)
echo "Render time: $elapsed"
echo ""
