#==============================================================================
# AplicarCabecalhoComDeslocamento.ps1
#
# Injeta a faixa cinza do cabecalho (CLAUDE.md #11) na pagina DADOS dos forms
# CRUD que NAO tem espaco livre no topo - os que o InjetarCabecalhoPaginaDados
# pulava por colisao. Alem de injetar, RE-LAYOUTA a pagina:
#
#   1. desloca os filhos diretos da Page2 para baixo ate o primeiro controle de
#      dados ficar em Top >= 115 (a faixa ocupa 29..109);
#   2. controles que passam a estourar o rodape e SAO redimensionaveis (Grid,
#      EditBox, Container, PageFrame, Image, Shape) tem a Height reduzida - eles
#      ficam ancorados no rodape, como no legado;
#   3. o que sobrar (TextBox/Label/Botao no rodape, que nao encolhe) vira
#      aumento da altura do Form - e a grade da Lista cresce junto, para a
#      pagina 1 nao ganhar faixa vazia embaixo.
#
# NAO desloca (ficam POR CIMA da faixa, como no Formcfo):
#   - cnt_4c_Botoes* / cnt_4c_Salva* / cnt_4c_Saida / cnt_4c_Cabecalho|Sombra
#   - CommandButton/Container com Top 20..55 e Height 60..100 (linha de botoes
#     de acao do topo: cmd_4c_Video, cmd_4c_Imprime, cmd_4c_Operacao, ...)
#
# USO:
#   .\AplicarCabecalhoComDeslocamento.ps1 -Simular     # so relata
#   .\AplicarCabecalhoComDeslocamento.ps1              # aplica (gera .bak)
#   .\AplicarCabecalhoComDeslocamento.ps1 -Forms FormMoe,FormOps
#==============================================================================

param(
    [switch]$Simular,
    [string[]]$Forms,
    [string]$Pasta = 'C:\4c\projeto\app\forms\cadastros'
)

$ErrorActionPreference = 'Stop'

#-- constantes ($ALVO, $PROT_NOME, $REDIMENSIONAVEL, $ALTURA_MINIMA) e parsers,
#-- compartilhados com o DiagnosticoCabecalhoPaginas
. (Join-Path $PSScriptRoot 'LibCabecalhoPaginas.ps1')

#---------------------------------------------------------------------- varre
$arquivos = Get-ChildItem $Pasta -Filter 'Form*.prg' -File | Where-Object { $_.Name -notlike '*.bak' } | Sort-Object Name
if ($Forms) { $arquivos = $arquivos | Where-Object { $Forms -contains $_.BaseName } }

$relatorio = New-Object System.Collections.ArrayList
$semVar    = New-Object System.Collections.ArrayList
$jaTem     = 0

foreach ($arq in $arquivos) {
    $bytes  = [System.IO.File]::ReadAllBytes($arq.FullName)
    $temBom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB)
    $txt    = [System.IO.File]::ReadAllText($arq.FullName)
    $linhas = New-Object System.Collections.Generic.List[string]
    $linhas.AddRange([string[]]($txt -split "`r?`n"))

    if (Test-PaginaTemFaixa $linhas 2) { $jaTem++; continue }

    $lim = Get-LimitesMetodo $linhas '(?i)^\s*(PROTECTED\s+)?(PROCEDURE|FUNCTION)\s+ConfigurarPagina(Dados|2)\b'
    $ini = $lim[0]; $fim = $lim[1]
    if ($ini -lt 0 -or $fim -lt 0) { [void]$semVar.Add("$($arq.BaseName) (sem metodo ConfigurarPaginaDados)"); continue }

    # como o metodo se refere a Page2: (a) variavel local atribuida - inclusive
    # via Pages(2); (b) PARAMETRO do metodo (ConfigurarPaginaDados(par_oPagina));
    # (c) nada disso -> usa a expressao completa
    $var = ''; $linhaVar = -1
    for ($i = $ini; $i -le $fim; $i++) {
        $pa = Get-PaginaAtribuida $linhas[$i]
        if ($null -ne $pa -and $pa[1] -eq 2) { $var = $pa[0]; $linhaVar = $i; break }
    }
    if ($var -eq '') {
        foreach ($fx in (Get-MapaParametros $linhas 2)) {
            if ($fx.Ini -eq $ini) { $var = $fx.Param; $linhaVar = $ini; break }
        }
    }
    if ($var -eq '') {
        if ((($linhas[$ini..$fim] -join "`n")) -match '(?i)THIS\.pgf_4c_Paginas\.(Page2|Pages\(\s*2\s*\))') {
            $var = 'THIS.pgf_4c_Paginas.Page2'; $linhaVar = $ini
        }
    }
    if ($var -eq '') { [void]$semVar.Add("$($arq.BaseName) (nao localizei a referencia a Page2)"); continue }

    $filhos = Get-FilhosDiretos $linhas 2

    # nome da faixa: cnt_4c_Cabecalho ja existe em alguns forms como container de
    # CAMPOS (Formpgr) - reusar o nome estoura "object already exists" no VFP
    $nomeFaixa = 'cnt_4c_Cabecalho'
    if (@($filhos | Where-Object { $_.Nome -eq 'cnt_4c_Cabecalho' }).Count -gt 0) { $nomeFaixa = 'cnt_4c_FaixaTitulo' }

    # altura do form (DEFINE CLASS)
    $alturaForm = 0; $linhaAlturaForm = -1
    for ($i = 0; $i -lt [Math]::Min(80, $linhas.Count); $i++) {
        if ($linhas[$i] -match '(?i)^\s*Height\s*=\s*(\d+)') { $alturaForm = [int]$Matches[1]; $linhaAlturaForm = $i; break }
    }
    if ($alturaForm -eq 0) { [void]$semVar.Add("$($arq.BaseName) (sem Height no DEFINE CLASS)"); continue }

    $moveis    = @($filhos | Where-Object { -not (Test-Protegido $_) })
    $baseDelta = @($moveis | Where-Object { $_.Top -ge 20 })
    $delta     = 0
    if ($baseDelta.Count -gt 0) { $delta = [Math]::Max(0, $ALVO - (($baseDelta | Measure-Object Top -Minimum).Minimum)) }

    # controle grande que continua sobre a area da faixa depois do deslocamento
    # (ex.: PageFrame interno com Top=-29 cobrindo a pagina toda) - a faixa
    # ficaria ESCONDIDA atras dele; esses forms exigem decisao manual.
    $cobrem = @($moveis | Where-Object { ($_.Top + $delta) -lt 109 -and $_.Altura -gt 20 })
    if ($cobrem.Count -gt 0) {
        [void]$semVar.Add(("{0} (faixa ficaria coberta por {1})" -f $arq.BaseName,
            (($cobrem | ForEach-Object { "{0} Top={1} H={2}" -f $_.Nome, $_.Top, $_.Altura }) -join ', ')))
        continue
    }

    # passo 1: quanto o form precisa crescer (rodape que nao encolhe)
    $limite = $alturaForm + 29
    $cresce = 0
    if ($delta -gt 0) { foreach ($c in $moveis) {
        $novoBot = $c.Top + $delta + $c.Altura
        if ($novoBot -le $limite) { continue }
        $podeEncolher = ($c.Tipo -match $REDIMENSIONAVEL -and $c.LinhaAltura -ge 0 -and ($limite - ($c.Top + $delta)) -ge $ALTURA_MINIMA)
        if (-not $podeEncolher) { $cresce = [Math]::Max($cresce, $novoBot - $limite) }
    } }
    $limiteFinal = $limite + $cresce

    # passo 2: encolher o que ainda estoura
    $encolhidos = New-Object System.Collections.ArrayList
    if ($delta -gt 0) { foreach ($c in $moveis) {
        $novoBot = $c.Top + $delta + $c.Altura
        if ($novoBot -le $limiteFinal) { continue }
        $novaAlt = $limiteFinal - ($c.Top + $delta)
        if ($c.Tipo -match $REDIMENSIONAVEL -and $c.LinhaAltura -ge 0 -and $novaAlt -ge $ALTURA_MINIMA) {
            [void]$encolhidos.Add([pscustomobject]@{ C = $c; Nova = $novaAlt })
        }
    } }

    [void]$relatorio.Add([pscustomobject]@{
        Form = $arq.BaseName; Delta = $delta; Cresce = $cresce; Altura = $alturaForm
        Encolhidos = $encolhidos.Count; Moveis = $moveis.Count; Faixa = $nomeFaixa
        Detalhe = (($encolhidos | ForEach-Object { "{0} {1}->{2}" -f $_.C.Nome, $_.C.Altura, $_.Nova }) -join '  ')
    })

    if ($Simular) { continue }

    #-------------------------------------------------------------- aplica
    Copy-Item $arq.FullName ($arq.FullName + '.bak') -Force

    foreach ($e in $encolhidos) { Set-ValorLinha $linhas $e.C.LinhaAltura 'Height' $e.Nova }
    if ($delta -gt 0) {
        foreach ($c in $moveis) { Set-ValorLinha $linhas $c.LinhaTop 'Top' ($c.Top + $delta) }
    }

    if ($cresce -gt 0) {
        # 1) altura do Form
        $linhas[$linhaAlturaForm] = $linhas[$linhaAlturaForm] -replace '(?i)^(\s*Height\s*=\s*)\d+', "`${1}$($alturaForm + $cresce)"

        # 2) PageFrame com altura LITERAL (os dinamicos usam THIS.Height + 29)
        for ($i = 0; $i -lt $linhas.Count; $i++) {
            if ($linhas[$i] -match '(?i)^\s*\.Height\s*=\s*(\d+)\s*$') {
                $valor = [int]$Matches[1]
                $ctx = ($linhas[[Math]::Max(0, $i - 12)..$i] -join "`n")
                if ($ctx -match '(?i)WITH\s+THIS\.pgf_4c_Paginas\s*$|AddObject\s*\(\s*"pgf_4c_Paginas"') {
                    $linhas[$i] = $linhas[$i] -replace '(?i)^(\s*\.Height\s*=\s*)\d+', "`${1}$($valor + $cresce)"
                    break
                }
            }
        }

        # 3) grade da pagina Lista cresce junto (senao sobra faixa vazia embaixo)
        $fl = Get-FilhosDiretos $linhas 1
        $grade = $fl | Where-Object { $_.Tipo -match '(?i)^Grid$' -and $_.LinhaAltura -ge 0 } |
                 Sort-Object { $_.Top + $_.Altura } -Descending | Select-Object -First 1
        if ($grade -and ($grade.Top + $grade.Altura) -ge ($alturaForm + 29 - 90)) {
            Set-ValorLinha $linhas $grade.LinhaAltura 'Height' ($grade.Altura + $cresce)
        }
    }

    # insere a faixa como PRIMEIRO AddObject da pagina: antes do primeiro
    # AddObject do metodo (assim os containers de botao desenham por cima)
    $ponto = $linhaVar; $indent = ''
    $rxAdd = "(?i)^(\s*)$([regex]::Escape($var))\.AddObject\s*\("
    for ($i = $linhaVar; $i -le $fim; $i++) {
        if ($linhas[$i] -match $rxAdd) { $ponto = $i - 1; $indent = $Matches[1]; break }
    }
    if ($indent -eq '') {
        # metodo sem AddObject proprio (delega a submetodos): apos o Picture ou
        # apos a linha da variavel/assinatura
        for ($i = $linhaVar; $i -le [Math]::Min($linhaVar + 8, $fim); $i++) {
            if ($linhas[$i] -match "(?i)^\s*$([regex]::Escape($var))\.Picture\s*=") { $ponto = $i; break }
        }
        $indent = ([regex]::Match($linhas[$linhaVar], '^\s*')).Value
        if ($linhaVar -eq $ini) { $indent = $indent + '    ' }
    }
    $bloco  = Get-BlocoCabecalho -Var $var -Indent $indent -Nome $nomeFaixa
    $linhas.InsertRange($ponto + 1, [string[]]@($bloco))
    $linhas.Insert($ponto + 1, "")

    $sw = New-Object System.IO.StreamWriter($arq.FullName, $false, (New-Object System.Text.UTF8Encoding($temBom)))
    $sw.NewLine = "`r`n"
    foreach ($l in $linhas) { $sw.WriteLine($l) }
    $sw.Close()
}

Write-Host ""
Write-Host ("ja tinham a faixa na Page2: {0}" -f $jaTem) -ForegroundColor Gray
Write-Host ("{0}: {1}" -f $(if ($Simular) { 'SERIAM tratados' } else { 'TRATADOS' }), $relatorio.Count) -ForegroundColor Green
Write-Host ""
foreach ($r in $relatorio) {
    $cor = if ($r.Cresce -gt 0) { 'Yellow' } else { 'Gray' }
    $marca = if ($r.Faixa -ne 'cnt_4c_Cabecalho') { " [faixa=$($r.Faixa)]" } else { '' }
    Write-Host ("  {0,-18} delta={1,-4} form {2}->{3,-5} encolhidos={4,-3} {5}{6}" -f $r.Form, $r.Delta, $r.Altura, ($r.Altura + $r.Cresce), $r.Encolhidos, $r.Detalhe, $marca) -ForegroundColor $cor
}
if ($semVar.Count -gt 0) {
    Write-Host ""
    Write-Host "--- NAO TRATADOS (exigem analise manual):" -ForegroundColor Red
    foreach ($s in $semVar) { Write-Host "  $s" }
}
