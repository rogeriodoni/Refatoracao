# Script para remover BOM UTF-8 de arquivos VFP

$arquivos = @(
    "C:\4c\projeto\app\utils\TesteAutomatico.prg",
    "C:\4c\projeto\app\utils\ValidarUIFidelity.prg",
    "C:\4c\automation\vfp_helpers\TestFormWrapper.prg",
    "C:\4c\automation\vfp_helpers\ValidarCompilacao.prg"
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
