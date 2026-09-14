Add-Type -AssemblyName System.Drawing

$bmp = New-Object System.Drawing.Bitmap(200, 50)
$graphics = [System.Drawing.Graphics]::FromImage($bmp)
$graphics.Clear([System.Drawing.Color]::White)

$font = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::DarkBlue)

$graphics.DrawString("EMPRESA TESTE", $font, $brush, 20, 12)

$graphics.Dispose()
$bmp.Save("C:\4c\icons\logo.bmp", [System.Drawing.Imaging.ImageFormat]::Bmp)
$bmp.Dispose()

Write-Host "Logo criado: C:\4c\icons\logo.bmp"
