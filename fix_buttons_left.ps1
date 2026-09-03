Set-StrictMode -Off
# Corrige posicoes Left dos botoes CRUD dentro de containers
# Bug: Left do container (542/917) copiado para botoes filhos em vez de posicao relativa
# Correto: Incluir=5, Visualizar=80, Alterar=155, Excluir=230, Buscar=305, Encerrar=5

$cadPaths = @(
    "C:\4c\projeto\app\forms\cadastros"
)

# Mapeamento: nome do botao -> Left canonico relativo ao container
$canonico = @{
    "cmd_4c_Incluir"    = 5
    "cmd_4c_Visualizar" = 80
    "cmd_4c_Alterar"    = 155
    "cmd_4c_Excluir"    = 230
    "cmd_4c_Buscar"     = 305
    "cmd_4c_Encerrar"   = 5
}

$totalFixed = 0
$filesFixed = @()

foreach ($basePath in $cadPaths) {
    $forms = Get-ChildItem "$basePath\Form*.prg" -ErrorAction SilentlyContinue

    foreach ($file in $forms) {
        $content = Get-Content $file.FullName -Encoding UTF8
        $modified = $false
        $inBtn = ""
        $result = [System.Collections.Generic.List[string]]::new()

        foreach ($line in $content) {
            # Detecta entrada em bloco de botao especifico
            foreach ($btn in $canonico.Keys) {
                if ($line -match "WITH\s+\.$btn\b") {
                    $inBtn = $btn
                    break
                }
            }

            # Detecta saida do bloco (ENDWITH)
            if ($inBtn -and $line -match '^\s*ENDWITH\s*$') {
                $inBtn = ""
            }

            # Corrige .Left incorreto dentro de bloco de botao
            if ($inBtn -and $line -match '^\s*\.Left\s*=\s*(\d+)') {
                $currentLeft = [int]$Matches[1]
                $expectedLeft = $canonico[$inBtn]

                # Corrige apenas se o valor for errado E for grande demais (>= 400)
                # para nao alterar Left que por acaso seja o valor correto
                if ($currentLeft -ne $expectedLeft -and $currentLeft -ge 50) {
                    $padding = $line -replace '\.Left.*', ''
                    $line = $padding + ".Left            = $expectedLeft"
                    $modified = $true
                    $totalFixed++
                }
            }

            $result.Add($line)
        }

        if ($modified) {
            $result | Set-Content $file.FullName -Encoding UTF8
            $filesFixed += $file.Name
            Write-Host "  Corrigido: $($file.Name)"
        }
    }
}

Write-Host ""
Write-Host "============================================"
Write-Host "Total de correcoes: $totalFixed"
Write-Host "Arquivos corrigidos ($($filesFixed.Count)):"
$filesFixed | ForEach-Object { Write-Host "  - $_" }
