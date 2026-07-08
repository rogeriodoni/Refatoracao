# TesteComplexidadeSimples.ps1
# Teste direto da função Get-ComplexidadeArquivo

param(
    [string]$ArquivoTxt = "C:\4c\tasks\task012\sigmvcab_form_codigo_fonte.txt"
)

# Carrega apenas a função de complexidade (copia o código)
function Get-ComplexidadeArquivo {
    param([string]$CaminhoTxt)

    $tamanhoKB = [math]::Round((Get-Item $CaminhoTxt).Length / 1024, 2)
    $linhas = (Get-Content $CaminhoTxt -ReadCount 0).Count

    if ($tamanhoKB -ge 800 -or $linhas -ge 15000) {
        $numFases = [Math]::Max(3, [Math]::Ceiling($tamanhoKB / 400))

        return @{
            Classificacao = "COMPLEXO"
            TamanhoKB = $tamanhoKB
            Linhas = $linhas
            NumFases = $numFases
            Motivo = if ($tamanhoKB -ge 800) { "Tamanho" } else { "Linhas" }
        }
    }

    return @{
        Classificacao = "SIMPLES"
        TamanhoKB = $tamanhoKB
        Linhas = $linhas
    }
}

Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host "  TESTE: DETECÇÃO DE COMPLEXIDADE" -ForegroundColor Cyan
Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $ArquivoTxt)) {
    Write-Host "ERRO: Arquivo não encontrado: $ArquivoTxt" -ForegroundColor Red
    exit 1
}

Write-Host "Analisando arquivo: $(Split-Path -Leaf $ArquivoTxt)" -ForegroundColor Yellow
Write-Host "Caminho: $ArquivoTxt" -ForegroundColor Gray
Write-Host ""

$resultado = Get-ComplexidadeArquivo -CaminhoTxt $ArquivoTxt

Write-Host "========================================================================" -ForegroundColor Yellow
Write-Host "  RESULTADO" -ForegroundColor Yellow
Write-Host "========================================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "  Tamanho:        $($resultado.TamanhoKB) KB" -ForegroundColor White
Write-Host "  Linhas:         $($resultado.Linhas)" -ForegroundColor White
Write-Host "  Classificação:  $($resultado.Classificacao)" -ForegroundColor $(if ($resultado.Classificacao -eq "COMPLEXO") { "Red" } else { "Green" })

if ($resultado.Classificacao -eq "COMPLEXO") {
    Write-Host ""
    Write-Host "  Motivo:         $($resultado.Motivo)" -ForegroundColor Yellow
    Write-Host "  Fases sugeridas: $($resultado.NumFases)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "========================================================================" -ForegroundColor Magenta
    Write-Host "  ⚠️  PROCESSAMENTO MULTI-FASE SERÁ ATIVADO" -ForegroundColor Magenta
    Write-Host "========================================================================" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "  Estratégia automática:" -ForegroundColor Cyan
    Write-Host "    - Fase 1: Business Object Completo" -ForegroundColor Cyan
    Write-Host "    - Fase 2: Estrutura Base do Form" -ForegroundColor Cyan
    Write-Host "    - Fase 3: Campos e Lookups" -ForegroundColor Cyan
    Write-Host "    - Fase 4: Eventos e Consolidação" -ForegroundColor Cyan
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "========================================================================" -ForegroundColor Green
    Write-Host "  ✅ PROCESSAMENTO SIMPLES" -ForegroundColor Green
    Write-Host "========================================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Arquivo será processado em uma única passagem" -ForegroundColor Green
    Write-Host ""
}

Write-Host "Critérios de complexidade:" -ForegroundColor Gray
Write-Host "  - COMPLEXO: >= 800 KB OU >= 15.000 linhas" -ForegroundColor Gray
Write-Host "  - SIMPLES: < 800 KB E < 15.000 linhas" -ForegroundColor Gray
Write-Host ""
