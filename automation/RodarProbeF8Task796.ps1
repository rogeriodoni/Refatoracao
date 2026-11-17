# RodarProbeF8Task796.ps1
#
# Lanca automation\ProbeF8MemoTask796.prg no vfp9.exe e EXIGE o arquivo de
# saida - exit code e .FXP nao provam execucao (ver a licao
# "vfp9 compila e sai sem executar"). Faz antes um smoke test de 4 linhas.
#
# Uso: powershell -ExecutionPolicy Bypass -File automation\RodarProbeF8Task796.ps1
param(
    [string]$Probe     = 'C:\4c\automation\ProbeF8MemoTask796.prg',
    [string]$Saida     = 'C:\4c\automation\probe_f8_memo_task796.txt',
    [string]$TmpDir    = 'C:\4c\automation\tmp796\f8',
    [int]   $TimeoutMs = 180000
)
$ErrorActionPreference = 'Stop'
if (-not (Test-Path $TmpDir)) { New-Item -ItemType Directory -Path $TmpDir -Force | Out-Null }
$vfp = Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual FoxPro 9\vfp9.exe'

# --- smoke test: prova que o vfp9 desta sessao EXECUTA o corpo do .prg -------
$sPrg = Join-Path $TmpDir 'SmokeF8.prg'
$sOut = Join-Path $TmpDir 'smoke_f8.txt'
$sSrc = "SET SAFETY OFF" + [char]13 + [char]10 +
        "SET RESOURCE OFF" + [char]13 + [char]10 +
        "STRTOFILE(`"VIVO`", `"$sOut`")" + [char]13 + [char]10 + "QUIT"
[IO.File]::WriteAllText($sPrg, $sSrc, (New-Object Text.UTF8Encoding $false))
Remove-Item $sOut -Force -ErrorAction SilentlyContinue
$sp = Start-Process -FilePath $vfp -ArgumentList '-T',$sPrg -PassThru
$null = $sp.WaitForExit(60000)
if (-not $sp.HasExited) { $sp.Kill() }
if (-not (Test-Path $sOut)) { "SMOKE=FALHOU - o vfp9 nao executa nesta sessao; NADA foi provado"; exit 2 }
"SMOKE=OK"

# --- probe real -------------------------------------------------------------
# .FXP velho roda p-code antigo: apagar as duas grafias
foreach ($g in @('fxp','FXP')) {
    $f = [IO.Path]::ChangeExtension($Probe, $g)
    if (Test-Path $f) { Remove-Item $f -Force }
}
Remove-Item $Saida -Force -ErrorAction SilentlyContinue
$p = Start-Process -FilePath $vfp -ArgumentList '-T',$Probe -PassThru
$null = $p.WaitForExit($TimeoutMs)
if (-not $p.HasExited) { $p.Kill(); 'TIMEOUT' }
if (-not (Test-Path $Saida)) { "SAIDA AUSENTE - o probe NAO executou, nada foi provado"; exit 2 }
Get-Content $Saida
