 $a    = '<style>'
    $a    = $a + 'BODY{background-color:peachpuff;}'
    $a    = $a + 'TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}'
    $a    = $a + 'TH{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:thistle}'
    $a    = $a + 'TD{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:PaleGoldenrod}'
    $a    = $a + '</style>'

    
    $tisk=$tisk+'<p>'
    $tisk=$tisk+'<h4>'
    $tisk=$tisk+'Nazev PC'
    $tisk = $json.ComputerName
     $tisk=$tisk+'</h4>'
    $tisk=$tisk+'</p>'
    $tisk=$tisk+'<p>'
    $tisk=$tisk+'<h4> Operacni system</h4>'
    $tisk = $tisk + $json.OS
    $tisk=$tisk+'<h4>OS build</h4>'
    $tisk = $tisk + $json.os_build
    $tisk=$tisk+'</p>'
    $tisk=$tisk+'<h4>Appdiff</h4>'
    $tisk=$tisk+$vysledek


    
        
    $final|
    ConvertTo-Html -Head $a -Body "<H2>Výsledek AVAS $(Get-Date)</H2> $tisk" | 
    Out-File -FilePath $env:HOMEDRIVE\SICZ\Testtisk.html
    Start-Process -FilePath chrome -ArgumentList $env:HOMEDRIVE\SICZ\Testtisk.html
  