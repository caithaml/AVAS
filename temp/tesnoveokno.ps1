using assembly PresentationFramework

$outer = New-Object System.Windows.Window
$button = New-Object System.Windows.Controls.Button
$outer.Content = $button

$button.Content = 'Name'
$button.Add_Click( {
    param (
        $sender,
        $eventArgs
    )

    $inner.ShowDialog()
} )

$inner = New-Object System.Windows.Window
$inner.Content = 'New'

$outer.ShowDialog()
