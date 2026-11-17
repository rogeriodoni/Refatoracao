$vfpExe = "C:\Program Files (x86)\Microsoft Visual FoxPro 9\VFP9.EXE"

Remove-Item "C:\4c\projeto\app\classes\SigOpPrLBO.fxp" -ErrorAction SilentlyContinue
Remove-Item "C:\4c\projeto\app\classes\SigOpPrLBO.err" -ErrorAction SilentlyContinue
Remove-Item "C:\4c\projeto\app\forms\operacionais\FormSigOpPrL.fxp" -ErrorAction SilentlyContinue
Remove-Item "C:\4c\projeto\app\forms\operacionais\FormSigOpPrL.err" -ErrorAction SilentlyContinue

$prg = @"
SET SAFETY OFF
SET RESOURCE OFF
COMPILE C:\4c\projeto\app\classes\SigOpPrLBO.prg
COMPILE C:\4c\projeto\app\forms\operacionais\FormSigOpPrL.prg
QUIT
"@
$tmpPrg = "C:\4c\compile_test_task788_fase5_run.prg"
[System.IO.File]::WriteAllText($tmpPrg, $prg, [System.Text.Encoding]::Default)

$proc = Start-Process -FilePath $vfpExe -ArgumentList "-T -C`"$tmpPrg`"" -PassThru -Wait -WindowStyle Hidden
Write-Host "Exit code: $($proc.ExitCode)"

foreach ($base in @("C:\4c\projeto\app\classes\SigOpPrLBO", "C:\4c\projeto\app\forms\operacionais\FormSigOpPrL")) {
    $fxp = "$base.fxp"
    $err = "$base.err"
    if (Test-Path $fxp) { Write-Host "OK  : $fxp gerado" } else { Write-Host "FAIL: $fxp NAO gerado" }
    if (Test-Path $err) {
        Write-Host "ERRO: $err ---"
        Get-Content $err
    }
}
