# Lanca um .prg no vfp9.exe e espera - receita de
# feedback_vfp9_compila_e_sai_sem_executar_nesta_sessao (Start-Process
# -PassThru + WaitForExit; chamar vfp9.exe direto pelo Bash PENDURA).
param(
    [Parameter(Mandatory=$true)][string]$Prg,
    [int]$TimeoutMs = 180000
)
$vfp = Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual FoxPro 9\VFP9.EXE'
if (-not (Test-Path $vfp)) { "VFP9=AUSENTE ($vfp)"; exit 2 }
$p = Start-Process -FilePath $vfp -ArgumentList '-T', $Prg -PassThru -WindowStyle Hidden
if (-not $p.WaitForExit($TimeoutMs)) { try { $p.Kill() } catch {}; "TIMEOUT"; exit 3 }
"exit={0}" -f $p.ExitCode
