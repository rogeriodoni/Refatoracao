# Script para remover BOM UTF-8 de arquivos VFP

# Raiz do repo = pai de automation\ (era C:\4c\ fixo ate 2026-10-06; o repo vive em C:\4c\refatoracao)
$RaizRepo4c = Split-Path -Parent $PSScriptRoot

$arquivos = @(
    "$($RaizRepo4c)\projeto\app\utils\TesteAutomatico.prg",
    "$($RaizRepo4c)\projeto\app\utils\ValidarUIFidelity.prg",
    "$($RaizRepo4c)\automation\vfp_helpers\TestFormWrapper.prg",
    "$($RaizRepo4c)\automation\vfp_helpers\ValidarCompilacao.prg"
)

foreach ($arquivo in $arquivos) {
    if (Test-Path $arquivo) {
        $bytes = [System.IO.File]::ReadAllBytes($arquivo)

        # Verifica BOM UTF-8 (EF BB BF)
        if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
            # Remove BOM
            $bytes = $bytes[3..($bytes.Length-1)]
            [System.IO.File]::WriteAllBytes($arquivo, $bytes)
            Write-Host "BOM REMOVIDO: $arquivo" -ForegroundColor Green
        } else {
            Write-Host "Sem BOM: $arquivo" -ForegroundColor Gray
        }
    } else {
        Write-Host "Nao encontrado: $arquivo" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Concluido!" -ForegroundColor Cyan
