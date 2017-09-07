$SCCMcomputers | Export-Csv $sccmexport -Delimiter "," -NoTypeInformation
$eWPTcomputers | Export-Csv $ewptexport -Delimiter "," -NoTypeInformation
Compare-Object -ReferenceObject $SCCMcomputers -DifferenceObject $eWPTcomputers | ?{$_.sideIndicator -eq "=>"} |select inputobject | Export-Csv $inEWPT -NoTypeInformation
Compare-Object -ReferenceObject $SCCMcomputers -DifferenceObject $eWPTcomputers | ?{$_.sideIndicator -eq "=="} |select inputobject | Export-Csv $inBoth -NoTypeInformation
Compare-Object -ReferenceObject $SCCMcomputers -DifferenceObject $eWPTcomputers | ?{$_.sideIndicator -eq "<="} |select inputobject | Export-Csv $inSCCM -NoTypeInformation