#==============================================================================
# VerificarRemigracaoProduto.ps1
#
# PROPOSITO: conferir a re-migracao do SIGCDPRO (Erro178) nas tres frentes de
#            risco que a re-migracao carrega:
#              1) COMPLETUDE  - contagem de controles por pagina, legado x gerado
#              2) NAVEGACAO   - abas ocultas + OptionGroup de 8 botoes do legado
#              3) REGRESSAO   - regras ja consertadas a mao antes da re-migracao
#                               (Erro176 AlternarPagina; Erro167/177 Buscar)
#
# USO:
#   .\VerificarRemigracaoProduto.ps1
#   .\VerificarRemigracaoProduto.ps1 -TaskDir C:\4c\tasks\task569
#
# SAIDA: exit 0 se tudo passou, 1 se alguma frente falhou.
#==============================================================================

param(
    [string]$TaskDir = "C:\4c\tasks\task569",
    [string]$Prg     = "C:\4c\projeto\app\forms\cadastros\FormProduto.prg",
    [string]$Backup  = ""
)

$ErrorActionPreference = "Stop"
$falhas = 0

function Titulo($t) {
    Write-Host ""
    Write-Host ("=" * 78) -ForegroundColor Cyan
    Write-Host "  $t" -ForegroundColor Cyan
    Write-Host ("=" * 78) -ForegroundColor Cyan
}

if (-not (Test-Path $Prg)) { Write-Host "FormProduto.prg nao encontrado: $Prg" -ForegroundColor Red; exit 1 }
$src = Get-Content $Prg -Raw
Write-Host "Arquivo: $Prg  ($([math]::Round((Get-Item $Prg).Length/1KB)) KB, $((Get-Content $Prg).Count) linhas)"

#------------------------------------------------------------------------------
# 1) COMPLETUDE por pagina
#------------------------------------------------------------------------------
Titulo "1) COMPLETUDE - controles por pagina (legado x gerado)"

$layout = Join-Path $TaskDir "layout.json"
if (-not (Test-Path $layout)) { $layout = "C:\4c\tasks\task504\layout.json" }
$j = Get-Content $layout -Raw | ConvertFrom-Json

# metodo do .prg que preenche cada pagina do legado
$paginas = [ordered]@{
    'pgDados'        = 'ConfigurarPgDados'
    'pgCusto'        = 'ConfigurarPgpgCusto'
    'pgDadosFiscais' = 'ConfigurarPgpgDadosFiscais'
    'PgDadosFaseP'   = 'ConfigurarPgPgDadosFaseP'
    'PgDadosConsP'   = 'ConfigurarPgPgDadosConsP'
    'pgComposicao'   = 'ConfigurarPgpgComposicao'
    'pgDesigner'     = 'ConfigurarPgpgDesigner'
}

$linhas = Get-Content $Prg

foreach ($pg in $paginas.Keys) {
    $prefixo = 'SIGCDPRO.Pagina.Dados.pgframeDados.' + $pg
    # conta o legado incluindo filhos de container DENTRO da pagina (parent comeca com o prefixo),
    # mas sem as Columns de Grid, que o VFP cria sozinho
    $legado = ($j.objects | Where-Object {
        $_.parent -and $_.parent.StartsWith($prefixo) -and $_.parent -notmatch '\.Column\d+$'
    }).Count

    $metodo = $paginas[$pg]
    $ini = ($linhas | Select-String -Pattern ("PROCEDURE\s+" + $metodo + "\b") | Select-Object -First 1).LineNumber
    if (-not $ini) {
        Write-Host ("{0,-16} legado={1,4}   METODO {2} NAO EXISTE" -f $pg, $legado, $metodo) -ForegroundColor Red
        $falhas++
        continue
    }
    $fim = $linhas.Count
    for ($i = $ini; $i -lt $linhas.Count; $i++) {
        if ($linhas[$i] -match '^\s{4}ENDPROC\b') { $fim = $i + 1; break }
    }
    $gerado = (($linhas[($ini)..($fim - 1)]) | Select-String -Pattern 'AddObject\(' -AllMatches |
               ForEach-Object { $_.Matches.Count } | Measure-Object -Sum).Sum
    if (-not $gerado) { $gerado = 0 }

    $delta = $gerado - $legado
    # tolerancia: o migrado cria controles que o legado resolve na classe (labels de
    # container, por exemplo). So ACUSA quando o gerado tem MENOS que o legado.
    if ($delta -lt 0) {
        Write-Host ("{0,-16} legado={1,4}   gerado={2,4}   >>> FALTAM {3}" -f $pg, $legado, $gerado, [math]::Abs($delta)) -ForegroundColor Red
        $falhas++
    } else {
        Write-Host ("{0,-16} legado={1,4}   gerado={2,4}   OK" -f $pg, $legado, $gerado) -ForegroundColor Green
    }
}

#------------------------------------------------------------------------------
# 1b) pgDados control a controle (o defeito do Erro178)
#------------------------------------------------------------------------------
Titulo "1b) pgDados - controles do legado ausentes no .prg"

$mapPath = "C:\4c\projeto\app\utils\mapeamentos\FormProduto_mapeamento.json"
$mapa = $null
if (Test-Path $mapPath) { $mapa = (Get-Content $mapPath -Raw | ConvertFrom-Json).mapeamento }

$pgDados = $j.objects | Where-Object { $_.parent -eq 'SIGCDPRO.Pagina.Dados.pgframeDados.pgDados' }
$ausentes = @()
foreach ($o in $pgDados) {
    $full = 'SIGCDPRO.Pagina.Dados.pgframeDados.pgDados.' + $o.name
    $novo = $null
    if ($mapa) { $novo = $mapa.$full }
    if (-not $novo) { $novo = $o.name }
    if ($src -notmatch ('AddObject\(\s*"' + [regex]::Escape($novo) + '"')) {
        $ausentes += [PSCustomObject]@{ Tipo = $o.baseClass; Legado = $o.name; Migrado = $novo }
    }
}
Write-Host ("legado={0}  ausentes={1}" -f $pgDados.Count, $ausentes.Count) -ForegroundColor $(if ($ausentes.Count -eq 0) { "Green" } else { "Red" })
if ($ausentes.Count -gt 0) {
    $falhas++
    $ausentes | Group-Object Tipo | Sort-Object Count -Descending | ForEach-Object {
        Write-Host ("   {0,4}  {1}" -f $_.Count, $_.Name) -ForegroundColor Yellow
    }
    Write-Host "   (primeiros 15)" -ForegroundColor DarkGray
    $ausentes | Select-Object -First 15 | ForEach-Object {
        Write-Host ("   {0,-14} {1,-22} -> {2}" -f $_.Tipo, $_.Legado, $_.Migrado) -ForegroundColor DarkGray
    }
}

#------------------------------------------------------------------------------
# 2) NAVEGACAO do legado
#------------------------------------------------------------------------------
Titulo "2) NAVEGACAO - abas ocultas + OptionGroup de 8 botoes"

$temOptionGroup = $src -match '(?i)AddObject\(\s*"[A-Za-z0-9_]*(Optiongroup1|Navegacao)[A-Za-z0-9_]*"\s*,\s*"OptionGroup"'
$temButtonCount8 = $src -match '(?i)\.ButtonCount\s*=\s*8'
# abas ocultas: .Tabs = .F. no PageFrame interno das divisoes
$temTabsFalse = $src -match '(?i)\.Tabs\s*=\s*\.F\.'
$temTabsTrue  = $src -match '(?i)\.Tabs\s*=\s*\.T\.'

foreach ($chk in @(
    @{ N = 'OptionGroup de navegacao';           V = $temOptionGroup },
    @{ N = 'ButtonCount = 8';                    V = $temButtonCount8 },
    @{ N = 'PageFrame interno com .Tabs = .F.';  V = $temTabsFalse }
)) {
    if ($chk.V) { Write-Host ("   OK    {0}" -f $chk.N) -ForegroundColor Green }
    else        { Write-Host ("   FALHA {0}" -f $chk.N) -ForegroundColor Red; $falhas++ }
}
if ($temTabsTrue) {
    Write-Host "   AVISO .Tabs = .T. ainda aparece - conferir se eh outro PageFrame" -ForegroundColor Yellow
}

#------------------------------------------------------------------------------
# 3) REGRESSAO das correcoes feitas a mao
#------------------------------------------------------------------------------
Titulo "3) REGRESSAO - regras ja consertadas antes da re-migracao"

# 3a) Erro176: AlternarPagina repoe o modo E chama AjustarBotoesPorModo
$ini = ($linhas | Select-String -Pattern 'PROCEDURE\s+AlternarPagina\b' | Select-Object -First 1).LineNumber
$okModo = $false; $okAjuste = $false
if ($ini) {
    $fim = $linhas.Count
    for ($i = $ini; $i -lt $linhas.Count; $i++) {
        if ($linhas[$i] -match '^\s{4}ENDPROC\b') { $fim = $i + 1; break }
    }
    $corpo = ($linhas[($ini)..($fim - 1)]) -join "`n"
    $okModo   = $corpo -match '(?i)this_cModoAtual\s*=\s*"LISTA"'
    $okAjuste = $corpo -match '(?i)AjustarBotoesPorModo\s*\('
}
if ($okAjuste) { Write-Host "   OK    Erro176: AlternarPagina chama AjustarBotoesPorModo" -ForegroundColor Green }
else           { Write-Host "   FALHA Erro176: AlternarPagina NAO reabilita os botoes CRUD" -ForegroundColor Red; $falhas++ }
if ($okModo)   { Write-Host "   OK    Erro176: AlternarPagina repoe this_cModoAtual = LISTA" -ForegroundColor Green }
else           { Write-Host "   FALHA Erro176: AlternarPagina NAO repoe o modo" -ForegroundColor Red; $falhas++ }

# 3b) Erro167/177: Buscar nao pode abrir picker inventado
$temPicker = $src -match '(?i)PROCEDURE\s+BtnBuscarClick[\s\S]{0,4000}?CREATEOBJECT\(\s*"FormBuscaAuxiliar"'
if ($temPicker) {
    Write-Host "   AVISO Buscar abre FormBuscaAuxiliar - conferir no dump se o legado tem picker" -ForegroundColor Yellow
    Write-Host "         (no SIGCDGPD/SIGCDCTA nao tinha: era busca por exemplo - Erro167/177)" -ForegroundColor DarkGray
} else {
    Write-Host "   OK    Buscar nao usa picker inventado" -ForegroundColor Green
}

# 3c) diff de tamanho contra o backup, se informado
if ($Backup -and (Test-Path $Backup)) {
    $antes = (Get-Content $Backup).Count
    $depois = $linhas.Count
    Write-Host ("   INFO  linhas: antes={0}  depois={1}  ({2:+#;-#;0})" -f $antes, $depois, ($depois - $antes)) -ForegroundColor Cyan
}

#------------------------------------------------------------------------------
# 4) BO - a re-migracao regenera ProdutoBO.prg junto
#------------------------------------------------------------------------------
Titulo "4) BO - ProdutoBO.prg regenerado"

$boPath = "C:\4c\projeto\app\classes\ProdutoBO.prg"
if (-not (Test-Path $boPath)) {
    Write-Host "   FALHA ProdutoBO.prg nao existe" -ForegroundColor Red
    $falhas++
} else {
    $bo = Get-Content $boPath -Raw
    $boLinhas = (Get-Content $boPath).Count
    Write-Host ("   INFO  {0} linhas" -f $boLinhas) -ForegroundColor Cyan

    # 4a) property names canonicos do BusinessBase (CLAUDE.md)
    foreach ($p in @('this_cTabela', 'this_cCampoChave')) {
        if ($bo -match ('(?i)\b' + $p + '\b')) { Write-Host ("   OK    usa {0}" -f $p) -ForegroundColor Green }
        else { Write-Host ("   AVISO nao encontrei {0} - conferir naming do BusinessBase" -f $p) -ForegroundColor Yellow }
    }
    foreach ($p in @('this_cNomeTabela', 'this_cChavePrimaria')) {
        if ($bo -match ('(?i)\b' + $p + '\b')) { Write-Host ("   FALHA usa {0} (nome ERRADO)" -f $p) -ForegroundColor Red; $falhas++ }
    }

    # 4b) ExecutarExclusao PROTECTED / Excluir PUBLIC
    if ($bo -match '(?i)PROCEDURE\s+ExecutarExclusao') { Write-Host "   OK    sobrecarrega ExecutarExclusao" -ForegroundColor Green }
    else { Write-Host "   AVISO nao sobrecarrega ExecutarExclusao" -ForegroundColor Yellow }

    # 4c) regra #22: INSERT tem de cobrir as colunas NOT NULL - aqui so sinaliza
    #     que o gate do pipeline precisa ter passado (ValidadorSQLSchema)
    $insert = [regex]::Matches($bo, '(?i)INSERT\s+INTO\s+SigCdPro')
    Write-Host ("   INFO  {0} INSERT(s) em SigCdPro - o gate 05f_validarSQLSchema cobre NOT NULL (regra #22)" -f $insert.Count) -ForegroundColor Cyan

    # 4d) helpers de formatacao por TIPO (regra #5)
    foreach ($h in @('EscaparSQL', 'FormatarNumeroSQL', 'FormatarDataSQL')) {
        if ($bo -match ('(?i)\b' + $h + '\(')) { Write-Host ("   OK    usa {0}()" -f $h) -ForegroundColor Green }
        else { Write-Host ("   AVISO nao usa {0}() - conferir montagem de SQL" -f $h) -ForegroundColor Yellow }
    }
}

#------------------------------------------------------------------------------
Titulo $(if ($falhas -eq 0) { "RESULTADO: PASSOU" } else { "RESULTADO: $falhas FRENTE(S) COM FALHA" })
exit $(if ($falhas -eq 0) { 0 } else { 1 })
