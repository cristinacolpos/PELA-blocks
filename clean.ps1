# PELA - 3D Printed LEGO-compatible parametric blocks
#
# Clean the STL models to remove any artifacts and re-save in binary format
# This operation is not needed if 'make.ps1 -clean' flag is run. If you did not
# do this, for example because of high RAM requirements of cleaning, you can use
# this script separately and possibly on a different computer.
#
# See http://PELAblocks.org for more information
# 
# Part of https://github.com/LEGO-prototypes/PELA-parametric-blocks

shrink-mesh($name)

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

Write-Output "Cleaning all STL files"
Get-ChildItem * -Include *.stl -Recurse -Exclude stltools | ForEach-Object ($_) {shrink-mesh($_.FullName)}
