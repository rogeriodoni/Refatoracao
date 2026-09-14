#==============================================================================
# CorrigirOrdemFuncoes.ps1
# PROPOSITO: Corrigir ordem de definição de funções no OrquestradorMigracao.ps1
#==============================================================================

$arquivo = "C:\4c\automation\OrquestradorMigracao.ps1"
$backup = "C:\4c\automation\OrquestradorMigracao.ps1.backup_antes_correcao_ordem"

Write-Host "Corrigindo ordem de funcoes..." -ForegroundColor Cyan

# Backup
if (-not (Test-Path $backup)) {
    Copy-Item $arquivo $backup
    Write-Host "  Backup criado: $backup" -ForegroundColor Green
}

# Ler conteudo
$lines = Get-Content $arquivo

# Encontrar linhas chave
$lineGetNextTaskNumber = -1
$lineGetNextOriginalFile = -1
$lineUsaGetNextOriginalFile = -1

for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match '^function Get-NextTaskNumber') {
        $lineGetNextTaskNumber = $i
    }
    if ($lines[$i] -match '^function Get-NextOriginalFile') {
        $lineGetNextOriginalFile = $i
    }
    if ($lines[$i] -match 'Get-NextOriginalFile\s*#.*ja existente' -or
        $lines[$i] -match '\$proximoArquivo = Get-NextOriginalFile') {
        if ($lineUsaGetNextOriginalFile -eq -1) {
            $lineUsaGetNextOriginalFile = $i
        }
    }
}

Write-Host "  Get-NextTaskNumber na linha: $lineGetNextTaskNumber" -ForegroundColor White
Write-Host "  Get-NextOriginalFile definida na linha: $lineGetNextOriginalFile" -ForegroundColor White
Write-Host "  Get-NextOriginalFile usada na linha: $lineUsaGetNextOriginalFile" -ForegroundColor White

if ($lineUsaGetNextOriginalFile -lt $lineGetNextOriginalFile) {
    Write-Host ""
    Write-Host "  PROBLEMA CONFIRMADO: Funcao usada ANTES de ser definida!" -ForegroundColor Red
    Write-Host "  Movendo definicao de Get-NextOriginalFile para depois de Get-NextTaskNumber..." -ForegroundColor Yellow

    # Extrair linhas da função Get-NextOriginalFile (até próximo 'function' ou fim do bloco)
    $startFunc = $lineGetNextOriginalFile
    $endFunc = $startFunc + 1

    # Encontrar fim da função (próxima linha com '}' sozinho ou próxima 'function')
    for ($i = $startFunc + 1; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match '^}$' -and $lines[$i-1] -notmatch '^\s*if|^\s*try|^\s*catch|^\s*WITH') {
            $endFunc = $i
            break
        }
        if ($lines[$i] -match '^function ' -and $i -ne $startFunc) {
            $endFunc = $i - 1
            break
        }
    }

    Write-Host "  Funcao Get-NextOriginalFile: linhas $startFunc a $endFunc" -ForegroundColor White

    # Extrair definição completa
    $funcLines = $lines[$startFunc..$endFunc]

    # Remover do local original
    $newLines = @()
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($i -lt $startFunc -or $i -gt $endFunc) {
            $newLines += $lines[$i]
        }
    }

    # Inserir APÓS Get-NextTaskNumber (encontrar novo índice após remoção)
    $lineGetNextTaskNumberNew = -1
    for ($i = 0; $i -lt $newLines.Count; $i++) {
        if ($newLines[$i] -match '^function Get-NextTaskNumber') {
            $lineGetNextTaskNumberNew = $i
            break
        }
    }

    # Encontrar fim de Get-NextTaskNumber
    $insertAfter = $lineGetNextTaskNumberNew + 1
    for ($i = $lineGetNextTaskNumberNew + 1; $i -lt $newLines.Count; $i++) {
        if ($newLines[$i] -match '^}$') {
            $insertAfter = $i + 1
            break
        }
    }

    Write-Host "  Inserindo apos linha $insertAfter" -ForegroundColor White

    # Montar arquivo final
    $finalLines = @()
    $finalLines += $newLines[0..($insertAfter-1)]
    $finalLines += ""
    $finalLines += $funcLines
    $finalLines += ""
    if ($insertAfter -lt $newLines.Count) {
        $finalLines += $newLines[$insertAfter..($newLines.Count-1)]
    }

    # Gravar
    $finalLines | Out-File -FilePath $arquivo -Encoding UTF8

    Write-Host ""
    Write-Host "CORRECAO APLICADA!" -ForegroundColor Green
    Write-Host "  Get-NextOriginalFile movida para logo apos Get-NextTaskNumber" -ForegroundColor Green
    Write-Host "  Agora pode ser usada no codigo de roteamento" -ForegroundColor Green
}
else {
    Write-Host ""
    Write-Host "  Ordem JA ESTA CORRETA" -ForegroundColor Green
}

Write-Host ""
