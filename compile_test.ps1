$vfpExe = "C:\Program Files (x86)\Microsoft Visual FoxPro 9\VFP9.EXE"
$prg = @"
SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\sigopindBO.prg ADDITIVE
COMPILE C:\4c\projeto\app\forms\operacionais\Formsigopind.prg
IF _VFP.ActiveForm IS NULL
    WAIT WINDOW "Compiled OK" TIMEOUT 2
ENDIF
QUIT
"@
$tmpPrg = "C:\4c\compile_test_run.prg"
[System.IO.File]::WriteAllText($tmpPrg, $prg, [System.Text.Encoding]::Default)

$proc = Start-Process -FilePath $vfpExe -ArgumentList "-C`"$tmpPrg`"" -PassThru -Wait -WindowStyle Hidden
Write-Host "Exit code: $($proc.ExitCode)"
