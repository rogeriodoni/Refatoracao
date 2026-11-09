param([string]$prg, [string]$png)
$d = "C:\4c\refatoracao\origem\correcoes\erro333_tmp"
Remove-Item "$d\calib.txt", $png -ErrorAction SilentlyContinue
Add-Type -AssemblyName System.Drawing
if (-not ("W" -as [type])) {
Add-Type @"
using System; using System.Runtime.InteropServices;
public class W { [DllImport("user32.dll")] public static extern bool PrintWindow(IntPtr h, IntPtr dc, uint f);
 [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr h, out R r);
 public struct R { public int L, T, Rt, B; } }
"@ }
$p = Start-Process "C:\Program Files (x86)\Microsoft Visual FoxPro 9\vfp9.exe" -ArgumentList "-T", "`"$prg`"" -PassThru
for ($i = 0; $i -lt 90; $i++) { Start-Sleep -Milliseconds 500; if ((Test-Path "$d\calib.txt") -and (Select-String -Path "$d\calib.txt" -Pattern "PRONTO|ERRO" -Quiet)) { break } }
Start-Sleep -Seconds 4
$p.Refresh(); $h = $p.MainWindowHandle
$r = New-Object W+R; [W]::GetWindowRect($h, [ref]$r) | Out-Null
$bmp = New-Object System.Drawing.Bitmap ($r.Rt - $r.L), ($r.B - $r.T)
$g = [System.Drawing.Graphics]::FromImage($bmp); $dc = $g.GetHdc(); [W]::PrintWindow($h, $dc, 2) | Out-Null; $g.ReleaseHdc($dc)
$bmp.Save($png, [System.Drawing.Imaging.ImageFormat]::Png); $g.Dispose(); $bmp.Dispose()
if (-not $p.HasExited) { $p.Kill() }
Get-Content "$d\calib.txt"
