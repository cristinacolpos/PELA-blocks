# Generate a set of 3D-printable LEGOs to demonstrate and exercise the script
# Windows Powershell
# Part of https://github.com/paulirotta/parametric_lego


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

Write-Output "Removing old .stl files"
Remove-Item "*.stl"
Remove-Item ".\lego-sign\*.stl"

Invoke-Expression ".\lego.ps1 4 2 1"
Invoke-Expression ".\lego.ps1 2 2 1"
Invoke-Expression ".\lego.ps1 2 2 1"
Invoke-Expression ".\lego.ps1 1 1 1"
Invoke-Expression ".\technic.ps1 4 4 2"

Write-Output "Render lego-sign.stl"
$start = Get-Date
openscad -o ".\lego-sign\lego-sign.stl" ".\lego-sign\lego-sign.scad"
$elapsed=FormatElapsedTime ((Get-Date) - $start)
Write-Output "Render time: $elapsed"
Write-Output ""
