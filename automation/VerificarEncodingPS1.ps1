# VerificarEncodingPS1.ps1 - Falha se algum .ps1 em automation/ tiver nao-ASCII sem BOM UTF-8
# Motivo: PowerShell 5.1 pt-BR le .ps1 sem BOM como CP1252; byte 0x94 (UTF-8 de chars como └─)
# vira aspa curva e o parser quebra silenciosamente. Ver memory/feedback_ps1_utf8_bom.md.

param([string]$Pasta = "C:\4c\automation")

$problemas = @()
$corrigidos = @()

Get-ChildItem -Path $Pasta -Filter "*.ps1" -File | ForEach-Object {
    $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
    if ($bytes.Length -lt 3) { return }

    $temBom = ($bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
    $temNaoAscii = $false
    foreach ($b in $bytes) {
        if ($b -gt 0x7F) { $temNaoAscii = $true; break }
    }

    if ($temNaoAscii -and -not $temBom) {
        # Tenta validar parse. Se falhar, aplica BOM automaticamente.
        $errs = $null; $tokens = $null
        [System.Management.Automation.Language.Parser]::ParseFile($_.FullName, [ref]$tokens, [ref]$errs) | Out-Null
        if ($errs.Count -gt 0) {
            try {
                $conteudo = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
                [System.IO.File]::WriteAllText($_.FullName, $conteudo, (New-Object System.Text.UTF8Encoding $true))
                $corrigidos += $_.Name
            }
            catch {
                $problemas += "$($_.Name): falha ao aplicar BOM - $($_.Exception.Message)"
            }
        }
    }
}

if ($corrigidos.Count -gt 0) {
    Write-Host "[EncodingCheck] BOM UTF-8 aplicado automaticamente em:" -ForegroundColor Yellow
    $corrigidos | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }
}

if ($problemas.Count -gt 0) {
    Write-Host "[EncodingCheck] ERROS:" -ForegroundColor Red
    $problemas | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
    throw "Falha na verificacao de encoding PS1. Pipeline abortado."
}

Write-Host "[EncodingCheck] OK - todos os .ps1 com nao-ASCII possuem BOM UTF-8" -ForegroundColor Green
