code
cls

#$rozdil=Compare-Object -ReferenceObject (Get-Content C:\Users\lukas\OneDrive\Documents\GitHub\AVAS\app_porovnani\test\app_default.json) -DifferenceObject (Get-Content C:\Users\lukas\OneDrive\Documents\GitHub\AVAS\app_porovnani\test\app.json)



$objFile1 = Get-Content “C:\Users\lukas\OneDrive\Documents\GitHub\AVAS\app_porovnani\test2\app_default.txt”
$objFile2 = Get-Content “C:\Users\lukas\OneDrive\Documents\GitHub\AVAS\app_porovnani\test2\app.txt”

$objFile3 = $objFile1 | %{$i = 1} { new-object psobject -prop @{LineNum=$i;Text=$_}; $i++}
$objFile4 = $objFile2 | %{$i = 1} { new-object psobject -prop @{LineNum=$i;Text=$_}; $i++}

$objDiff1 = Compare-Object -ReferenceObject $objFile1 -DifferenceObject $objFile2
$objNotInFile1 = @()
$objNotInFile2 = @()
$objDiff1 | foreach {
if ($_.SideIndicator -eq “=>”) {$objNotInFile1 += $_}
if ($_.SideIndicator -eq “< =") {$objNotInFile2 += $_}
}
$objDiff2 = Compare-Object -ReferenceObject $objFile3 -DifferenceObject $objFile4 -IncludeEqual -Property Text,LineNum | sort-object -Property LineNum

$lngCounterNotInFile1 = 0
$lngCounterNotInFile2 = 0
$lngMaxCharacters = 60
foreach ($objDifference in $objDiff2) {
$blnIsDifference = $false
if ($objDifference.SideIndicator -eq “=>”) {
if ($objNotInFile1[$lngCounterNotInFile1].InputObject -eq $objDifference.Text){
“{0}[{1}]`t{2}” -f $objDifference.SideIndicator, $objDifference.LineNum, $objDifference.Text | Write-Host -BackgroundColor yellow -ForegroundColor black
if ($lngCounterNotInFile1 -lt $objNotInFile1.count) {$lngCounterNotInFile1 ++}
$blnIsDifference = $true
}
}elseif ($objDifference.SideIndicator -eq “< =") {
if ($objNotInFile2[$lngCounterNotInFile2].InputObject -eq $objDifference.Text){
“{0}[{1}]`t{2}” -f $objDifference.SideIndicator, $objDifference.LineNum, $objDifference.Text | Write-Host -BackgroundColor yellow -ForegroundColor black
if ($lngCounterNotInFile2 -lt $objNotInFile2.count) {$lngCounterNotInFile2 ++}
$blnIsDifference = $true
}
}
if ($blnIsDifference -eq $false) {
$strLine = $objDifference.Text
$strLine = “$strLine”.replace(“`t”,” “)
if (“$strLine”.length -gt $lngMaxCharacters){$strLine = “$strLine”.substring(0,$lngMaxCharacters-3)+”…”}
“[{0}]`t{1}” -f $objDifference.LineNum, $strLine | Write-Output
}
}