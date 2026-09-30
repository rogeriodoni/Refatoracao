# =============================================================================
# SweepGateFase8Grafico.ps1
#
# Mede o BLAST RADIUS das duas mudancas feitas no gate da Fase 8 em 2026-09-29:
#   (a) Test-LegadoSomenteLeitura passou a aceitar ComboBox Style = 2 como
#       campo nao-digitavel (3a forma canonica, medida no VFP9);
#   (b) novo ramo de excecao $legadoGraficoF8.
#
# Varre TODOS os dumps de tasks\ e informa, por dump:
#   - SomenteLeitura ANTES x DEPOIS da mudanca (a)
#   - se o lado LEGADO do ramo GRAFICO casa
#
# Nao executa o orquestrador: extrai as funcoes via AST (dot-source dispararia
# uma migracao real).
# =============================================================================
param(
    [string]$Orquestrador = "C:\4c\automation\OrquestradorMigracao.ps1",
    [string]$TasksDir     = "C:\4c\tasks"
)

$ErrorActionPreference = "Stop"

$errs = $null; $toks = $null
$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$toks, [ref]$errs)
if ($errs.Count -gt 0) { Write-Host "ERRO de parse"; exit 1 }

$funcs = $ast.FindAll({ $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true)
foreach ($nome in @('Test-LegadoSomenteLeitura','Test-LegadoAddCursorLigaGrade','Test-LegadoControlSourceLigaLista')) {
    $f = $funcs | Where-Object { $_.Name -eq $nome } | Select-Object -First 1
    if ($f) { . ([scriptblock]::Create($f.Extent.Text)) }
}

# Versao ANTIGA de Test-LegadoSomenteLeitura (sem o ramo Style = 2), para medir
# quantos dumps MUDARAM de veredito. Reproduz so as duas primeiras passadas +
# o veredito, que eh o suficiente: o ramo Style = 2 so acrescenta marcacoes.
function Test-SomenteLeituraAntigo {
    param([string]$TextoDump)
    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }
    $linhas = $TextoDump -split "`r?`n"
    $campos = @{}; $objAtual = ""; $paiAtual = ""
    foreach ($linha in $linhas) {
        if ($linha -match '^\s*Objeto:') {
            $objAtual = ""; $paiAtual = ""
            if ($linha -match '^\s*Objeto:\s*(\S+)\s*$') { $objAtual = $matches[1] }
        } elseif ($linha -match '^\s*Parent:\s*(\S+)\s*$') {
            $paiAtual = $matches[1]
        } elseif ($linha -match '^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$') {
            if ($objAtual) {
                $c = if ($paiAtual -and $paiAtual -ne '(raiz)') { "$paiAtual.$objAtual" } else { $objAtual }
                $campos[$c.ToUpper()] = $false
            }
        }
    }
    if ($campos.Count -eq 0) { return $false }
    $sl = @{}; $objProp = ""
    foreach ($linha in $linhas) {
        if ($linha -match '^\*\s*PROPRIEDADES DE:') {
            $objProp = ""
            if ($linha -match '^\*\s*PROPRIEDADES DE:\s*(\S+)\s*$') { $objProp = $matches[1].ToUpper() }
        } elseif ($objProp -and $linha -match '^\s*ReadOnly\s*=\s*\.T\.\s*$') {
            $sl[$objProp] = $true
        } elseif ($objProp -and $linha -match '^\s*([\w\.]+)\.ReadOnly\s*=\s*\.T\.\s*$') {
            $sl["$objProp.$($matches[1].ToUpper())"] = $true
        }
    }
    $objMet = ""; $emWhen = $false; $corpo = @()
    foreach ($linha in $linhas) {
        if ($linha -match '^\*\s*OBJETO:\s*(\S+)\s*$') { $objMet = $matches[1].ToUpper(); continue }
        if (-not $emWhen) {
            if ($linha -match '^\s*PROCEDURE\s+When\s*$') { $emWhen = $true; $corpo = @() }
            continue
        }
        if ($linha -match '^\s*ENDPROC\s*$') {
            $emWhen = $false
            $uteis = @($corpo | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' -and $_ -notmatch '^\*' -and $_ -notmatch '^&&' })
            if ($objMet -and $uteis.Count -eq 1 -and $uteis[0] -match '(?i)^Return\s*\(?\s*\.F\.\s*\)?\s*$') { $sl[$objMet] = $true }
        } else { $corpo += $linha }
    }
    foreach ($caminho in @($campos.Keys)) {
        if ($sl[$caminho]) { continue }
        $herdou = $false; $partes = $caminho -split '\.'
        for ($i = $partes.Count - 2; $i -ge 0; $i--) {
            if ($sl[(($partes[0..$i]) -join '.')]) { $herdou = $true; break }
        }
        if (-not $herdou) { return $false }
    }
    return $true
}

$dumps = Get-ChildItem -Path $TasksDir -Recurse -Filter "*_form_codigo_fonte.txt" -ErrorAction SilentlyContinue
Write-Host "Dumps encontrados: $($dumps.Count)" -ForegroundColor Cyan
Write-Host ""

$mudouSL  = @()
$grafLeg  = @()
$padroesSalvar = @('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados')
$padroesCrud   = @('frmcadastro','Grupo_Op','(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)','(Incluir|Alterar|Visualizar|Excluir)\.Click')

foreach ($d in $dumps) {
    $txt = Get-Content $d.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $txt) { continue }

    $antes  = Test-SomenteLeituraAntigo -TextoDump $txt
    $depois = Test-LegadoSomenteLeitura -TextoDump $txt
    if ($antes -ne $depois) { $mudouSL += "$($d.Directory.Name)/$($d.Name)  ($antes -> $depois)" }

    # Lado LEGADO do ramo GRAFICO (as 5 provas que vem do dump)
    $semCrud   = -not ($padroesCrud   | Where-Object { $txt -match $_ })
    $semSalvar = -not ($padroesSalvar | Where-Object { $txt -match $_ })
    $semGrade  = -not (($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe|listbox)\s*$') -or
                       ($txt -match '(?i)(pColuna|\bGrade\b|\bgrd)') -or
                       (Test-LegadoAddCursorLigaGrade     -TextoDump $txt) -or
                       (Test-LegadoControlSourceLigaLista -TextoDump $txt))
    $temOle    = $txt -match '(?im)^\s*BaseClass:\s*oleboundcontrol\s*$'

    if ($semCrud -and $semSalvar -and $semGrade -and $temOle -and $depois) {
        $grafLeg += "$($d.Directory.Name)/$($d.Name)"
    }
}

Write-Host "=== (a) Test-LegadoSomenteLeitura mudou de veredito em: $($mudouSL.Count) dump(s) ===" -ForegroundColor White
$mudouSL | ForEach-Object { Write-Host "  $_" -ForegroundColor Yellow }
Write-Host ""
Write-Host "=== (b) lado LEGADO do ramo GRAFICO casa em: $($grafLeg.Count) dump(s) ===" -ForegroundColor White
$grafLeg | ForEach-Object { Write-Host "  $_" -ForegroundColor Yellow }
