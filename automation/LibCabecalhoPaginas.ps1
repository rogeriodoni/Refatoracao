#==============================================================================
# LibCabecalhoPaginas.ps1
#
# Funcoes compartilhadas para localizar/medir a faixa cinza do cabecalho
# (CLAUDE.md #11) nas paginas dos forms CRUD. Usada por:
#   - DiagnosticoCabecalhoPaginas.ps1     (relatorio)
#   - AplicarCabecalhoComDeslocamento.ps1 (injecao + re-layout)
#
# Regras que motivaram cada funcao (todas custaram um bug):
#   - a faixa NUNCA se identifica pelo nome: 8 forms a chamam de cnt_4c_Sombra
#     e o Formpgr usa cnt_4c_Cabecalho para um container de CAMPOS;
#   - .Top aceita expressao (".Top = 75 + 29"), tem de ser avaliada;
#   - a pagina chega aos metodos por VARIAVEL, por Pages(N) ou por PARAMETRO
#     (FormCTA encadeia 17 metodos com par_oPagina);
#   - variavel reatribuida a outra coisa ("loc_oPage = par_oPage" no Formpag)
#     tem de PERDER o mapeamento, senao controles de sub-pagina viram filhos
#     da Page2.
#==============================================================================

$ALVO            = 115      # Top do primeiro controle de dados (faixa = 29..109)
$PROT_NOME       = '(?i)^cnt_4c_(Botoes\w*|Salva\w*|Saida)'
# So encolhe controle FOLHA: Container/PageFrame encolhido CORTA o conteudo
# interno (VFP faz clipping), entao para eles o form cresce.
$REDIMENSIONAVEL = '(?i)^(Grid|EditBox|Image|Shape|ListBox)$'
$ALTURA_MINIMA   = 40       # nao encolhe abaixo disso; vira aumento do form

# PageFrame) e ".Top = -3 + 29   && 26". Sem avaliar a expressao o controle
# passa despercebido e fica DEBAIXO da faixa.
$RX_TOP    = '(?i)^\s*\.Top\s*=\s*([-+\d\s]+?)\s*(&&.*)?$'
$RX_HEIGHT = '(?i)^\s*\.Height\s*=\s*([-+\d\s]+?)\s*(&&.*)?$'
# "X = THIS.pgf_4c_Paginas.Page2" e "X = THIS.pgf_4c_Paginas.Pages(2)"
$RX_ATRIB_PAGINA = '(?i)^\s*(\w+)\s*=\s*THIS\.pgf_4c_Paginas\.(?:Page(\d)\s*|Pages\(\s*(\d)\s*\)\s*)$'

function Get-PaginaAtribuida {
    param([string]$Linha)
    if ($Linha -match $RX_ATRIB_PAGINA) {
        $n = $(if ($Matches[2]) { $Matches[2] } else { $Matches[3] })
        return @($Matches[1], [int]$n)
    }
    return $null
}

# Reatribuicao que NAO eh de pagina (Formpag: "loc_oPage = par_oPage" dentro de
# CriarPaginaGeral, com o mesmo nome usado para a Page2 em outro metodo) tem de
# DESFAZER o mapeamento - senao os controles da sub-pagina viram filhos da Page2.
function Test-ReatribuicaoNaoPagina {
    param([string]$Linha)
    return ($Linha -match '(?i)^\s*(\w+)\s*=\s*\S' -and $null -eq (Get-PaginaAtribuida $Linha))
}

function Get-Numero {
    param([string]$Expr)
    $e = ($Expr -replace '\s', '')
    if ($e -notmatch '^[-+]?\d+([-+]\d+)*$') { return $null }
    $total = 0; $sinal = 1; $num = ''
    foreach ($ch in $e.ToCharArray()) {
        if ($ch -eq '+' -or $ch -eq '-') {
            if ($num -ne '') { $total += $sinal * [int]$num; $num = '' ; $sinal = $(if ($ch -eq '-') { -1 } else { 1 }) }
            else { $sinal = $(if ($ch -eq '-') { -1 } else { 1 }) }
        } else { $num += $ch }
    }
    if ($num -ne '') { $total += $sinal * [int]$num }
    return $total
}

# Metodos que recebem a pagina como PARAMETRO (FormCTA tem 17: os cnt_4c_Pg*
# nascem em ConfigurarPg<N>(par_oPagina)). Sem mapear o parametro, os filhos
# reais da Page2 passam despercebidos.
function Get-MapaParametros {
    param($Linhas, [int]$Pagina)

    # 1) variavel -> pagina, e assinatura dos metodos com parametro
    $varPag  = @{}
    $metodos = New-Object System.Collections.ArrayList
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $l = $Linhas[$i]
        if ($null -ne ($pa = Get-PaginaAtribuida $l)) { $varPag[$pa[0]] = $pa[1] } elseif (Test-ReatribuicaoNaoPagina $l) { $varPag.Remove(($l -replace '(?i)^\s*(\w+)\s*=.*$','$1')) }
        if ($l -match '(?i)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+(\w+)\s*\(\s*(\w+)') {
            # capturar ANTES do loop: o -match de dentro sobrescreve $Matches
            $nomeMet = $Matches[3]; $parMet = $Matches[4]
            $fim = $Linhas.Count - 1
            for ($j = $i + 1; $j -lt $Linhas.Count; $j++) {
                if ($Linhas[$j] -match '(?i)^\s*(ENDPROC|ENDFUNC)\s*$') { $fim = $j; break }
            }
            [void]$metodos.Add([pscustomobject]@{ Nome = $nomeMet; Param = $parMet; Ini = $i; Fim = $fim; Pagina = 0 })
        }
    }

    # 2) ponto fixo: a pagina se propaga por cadeia de chamadas
    #    ConfigurarPaginaDados -> ConfigurarPgX(loc_oPagina) -> ConfigurarSubY(par_oPagina)
    for ($passo = 0; $passo -lt 6; $passo++) {
        $mudou = $false
        for ($i = 0; $i -lt $Linhas.Count; $i++) {
            $l = $Linhas[$i]
            $metodo = ''; $arg = ''
            if ($l -match '(?i)^\s*THIS\.(\w+)\s*\(\s*THIS\.pgf_4c_Paginas\.Page(\d)\s*\)') {
                $metodo = $Matches[1]; $pag = [int]$Matches[2]
            }
            elseif ($l -match '(?i)^\s*THIS\.(\w+)\s*\(\s*(\w+)\s*[\),]') {
                $metodo = $Matches[1]; $arg = $Matches[2]; $pag = 0
                if ($varPag.ContainsKey($arg)) { $pag = $varPag[$arg] }
                else {
                    foreach ($m in $metodos) { if ($m.Pagina -gt 0 -and $i -ge $m.Ini -and $i -le $m.Fim -and $arg -eq $m.Param) { $pag = $m.Pagina; break } }
                }
            }
            else { continue }
            if ($pag -le 0) { continue }
            foreach ($m in $metodos) {
                if ($m.Nome -ne $metodo) { continue }
                if ($m.Pagina -eq 0) { $m.Pagina = $pag; $mudou = $true }
                elseif ($m.Pagina -ne $pag) { $m.Pagina = -1 }   # chamado com 2 paginas: ambiguo
            }
        }
        if (-not $mudou) { break }
    }

    $faixas = New-Object System.Collections.ArrayList
    foreach ($m in $metodos) {
        if ($m.Pagina -eq $Pagina) { [void]$faixas.Add([pscustomobject]@{ Ini = $m.Ini; Fim = $m.Fim; Param = $m.Param }) }
    }
    return $faixas
}

# Filhos DIRETOS de uma pagina, varrendo o ARQUIVO INTEIRO: ha forms (Formpgr,
# FormCTA, Formsigpdmp6...) que criam parte dos controles da Page2 em metodos
# separados. Olhar so o ConfigurarPaginaDados deixaria controle sob a faixa.
function Get-FilhosDiretos {
    param($Linhas, [int]$Pagina)

    $res    = New-Object System.Collections.ArrayList
    $varPag = @{}
    $faixasParam = Get-MapaParametros $Linhas $Pagina
    $obj    = ''; $tipo = ''; $dir = $false
    $top    = $null; $alt = $null; $lTop = -1; $lAlt = -1

    # guarda tambem quem ficou sem .Top no WITH: pode estar configurado por
    # alias mais adiante (ver 2a passada). Os que continuarem sem Top caem fora.
    $guarda = {
        if ($dir -and $obj -ne '') {
            [void]$res.Add([pscustomobject]@{ Nome = $obj; Tipo = $tipo; Top = $(if ($null -ne $top) { $top } else { 0 }); LinhaTop = $lTop
                Altura = $(if ($null -ne $alt) { $alt } else { 0 }); LinhaAltura = $lAlt })
        }
    }

    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $l = $Linhas[$i]

        if ($null -ne ($pa = Get-PaginaAtribuida $l)) { $varPag[$pa[0]] = $pa[1]; continue } elseif (Test-ReatribuicaoNaoPagina $l) { $varPag.Remove(($l -replace '(?i)^\s*(\w+)\s*=.*$','$1')) }

        $novo = $null
        if ($l -match "(?i)^\s*THIS\.pgf_4c_Paginas\.Page$Pagina\.AddObject\s*\(\s*`"(\w+)`"\s*,\s*`"(\w+)`"") {
            $novo = @($Matches[1], $Matches[2], $true)
        }
        elseif ($l -match '(?i)^\s*(\w+)\.AddObject\s*\(\s*"(\w+)"\s*,\s*"(\w+)"') {
            $pai = $Matches[1]
            $ehPagina = ($varPag.ContainsKey($pai) -and $varPag[$pai] -eq $Pagina)
            if (-not $ehPagina) {
                foreach ($fx in $faixasParam) {
                    if ($i -ge $fx.Ini -and $i -le $fx.Fim -and $pai -eq $fx.Param) { $ehPagina = $true; break }
                }
            }
            $novo = @($Matches[2], $Matches[3], $ehPagina)
        }
        elseif ($l -match '(?i)^\s*[\w\.]*\.?AddObject\s*\(') {
            $novo = @('', '', $false)
        }

        if ($null -ne $novo) {
            & $guarda
            $obj = $novo[0]; $tipo = $novo[1]; $dir = [bool]$novo[2]
            $top = $null; $alt = $null; $lTop = -1; $lAlt = -1
            continue
        }

        if ($dir -and $obj -ne '') {
            if ($null -eq $top -and $l -match $RX_TOP) {
                $v = Get-Numero $Matches[1]
                if ($null -ne $v) { $top = $v; $lTop = $i }
            }
            if ($null -eq $alt -and $l -match $RX_HEIGHT) {
                $v = Get-Numero $Matches[1]
                if ($null -ne $v) { $alt = $v; $lAlt = $i }
            }
        }
    }
    & $guarda

    # Parte dos forms configura o controle por ALIAS, fora do WITH:
    #   loc_oGrid = loc_oPagina.grd_4c_Dados
    #   loc_oGrid.Top    = 156
    #   loc_oGrid.Height = 385
    # Sem isso a grade da Lista some do mapa e nao acompanha o Form.Height.
    $porNome = @{}
    foreach ($c in $res) { $porNome[$c.Nome] = $c }
    $alias = @{}
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        $l = $Linhas[$i]
        if ($l -match '(?i)^\s*(\w+)\s*=\s*(\w+)\.(\w+)\s*$') {
            $a = $Matches[1]; $pai = $Matches[2]; $filho = $Matches[3]
            if ($varPag.ContainsKey($pai) -and $varPag[$pai] -eq $Pagina -and $porNome.ContainsKey($filho)) { $alias[$a] = $filho }
            else { $alias.Remove($a) }
            continue
        }
        if ($l -match '(?i)^\s*(\w+)\.(Top|Height)\s*=\s*([-+\d\s]+?)\s*(&&.*)?$') {
            $a = $Matches[1]; $prop = $Matches[2]; $v = Get-Numero $Matches[3]
            if ($null -eq $v -or -not $alias.ContainsKey($a)) { continue }
            $c = $porNome[$alias[$a]]
            if ($prop -match '(?i)Top' -and $c.LinhaTop -lt 0) { $c.Top = $v; $c.LinhaTop = $i }
            if ($prop -match '(?i)Height' -and $c.LinhaAltura -lt 0) { $c.Altura = $v; $c.LinhaAltura = $i }
        }
    }

    return @($res | Where-Object { $_.LinhaTop -ge 0 })
}

# Deteccao da faixa: COR + ALTURA, NUNCA por nome (8 forms a chamam de
# cnt_4c_Sombra e o Formpgr usa cnt_4c_Cabecalho para um container de CAMPOS).
# Usa Get-FilhosDiretos, que ja resolve variavel, Pages(N) e pagina recebida
# por PARAMETRO - o FormEmn cria a faixa em ConfigurarPaginaDados(par_oPagina).
function Test-PaginaTemFaixa {
    param($Linhas, [int]$Pagina)
    foreach ($c in (Get-FilhosDiretos $Linhas $Pagina)) {
        if ($c.Tipo -notmatch '(?i)^Container$' -or $c.Altura -lt 60) { continue }
        $de  = [Math]::Max(0, $c.LinhaTop - 4)
        $ate = [Math]::Min($Linhas.Count - 1, $c.LinhaTop + 14)
        for ($i = $de; $i -le $ate; $i++) {
            if ($Linhas[$i] -match '(?i)^\s*\.BackColor\s*=\s*RGB\(\s*100\s*,\s*100\s*,\s*100\s*\)') { return $true }
        }
    }
    return $false
}

# Fica POR CIMA da faixa (nao desloca): containers de botao do framework e a
# barra de acao do topo (botoes/navegacao com Top 20..55 e altura de botao).
function Test-Protegido {
    param($C)
    if ($C.Nome -match $PROT_NOME) { return $true }
    if ($C.Tipo -match '(?i)^(CommandButton|Container|OptionGroup)$' -and $C.Top -ge 20 -and $C.Top -le 55 -and $C.Altura -ge 60 -and $C.Altura -le 100) { return $true }
    return $false
}

function Get-LimitesMetodo {
    param($Linhas, [string]$Padrao)
    $ini = -1; $fim = -1
    for ($i = 0; $i -lt $Linhas.Count; $i++) {
        if ($Linhas[$i] -match $Padrao) { $ini = $i; continue }
        if ($ini -ge 0 -and $Linhas[$i] -match '(?i)^\s*(ENDPROC|ENDFUNC)\s*$') { $fim = $i; break }
    }
    return @($ini, $fim)
}

function Get-BlocoCabecalho {
    param([string]$Var, [string]$Indent, [string]$Nome = 'cnt_4c_Cabecalho')
    $l = New-Object System.Collections.ArrayList
    [void]$l.Add("$Indent*-- Cabecalho cinza (identico ao da pagina Lista) - CLAUDE.md #11 / Erro152")
    [void]$l.Add("$Indent$Var.AddObject(""$Nome"", ""Container"")")
    [void]$l.Add("${Indent}WITH $Var.$Nome")
    [void]$l.Add("$Indent    .Top           = 29")
    [void]$l.Add("$Indent    .Left          = 0")
    [void]$l.Add("$Indent    .Width         = THIS.Width")
    [void]$l.Add("$Indent    .Height        = 80")
    [void]$l.Add("$Indent    .BackColor     = RGB(100, 100, 100)")
    [void]$l.Add("$Indent    .BorderWidth   = 0")
    [void]$l.Add("$Indent    .SpecialEffect = 0")
    [void]$l.Add("$Indent    .Visible       = .T.")
    [void]$l.Add("")
    foreach ($cfg in @(@('lbl_4c_Sombra', 15, 40, 'RGB(0, 0, 0)'), @('lbl_4c_Titulo', 18, 46, 'RGB(255, 255, 255)'))) {
        [void]$l.Add("$Indent    .AddObject(""$($cfg[0])"", ""Label"")")
        [void]$l.Add("$Indent    WITH .$($cfg[0])")
        [void]$l.Add("$Indent        .Caption   = THIS.Caption")
        [void]$l.Add("$Indent        .Top       = $($cfg[1])")
        [void]$l.Add("$Indent        .Left      = 10")
        [void]$l.Add("$Indent        .Width     = THIS.Width")
        [void]$l.Add("$Indent        .Height    = $($cfg[2])")
        [void]$l.Add("$Indent        .FontName  = ""Tahoma""")
        [void]$l.Add("$Indent        .FontSize  = 16")
        [void]$l.Add("$Indent        .FontBold  = .T.")
        [void]$l.Add("$Indent        .ForeColor = $($cfg[3])")
        [void]$l.Add("$Indent        .BackStyle = 0")
        [void]$l.Add("$Indent        .AutoSize  = .F.")
        [void]$l.Add("$Indent        .Visible   = .T.")
        [void]$l.Add("$Indent    ENDWITH")
        [void]$l.Add("")
    }
    [void]$l.Add("${Indent}ENDWITH")
    [void]$l.Add("")
    return $l
}

function Set-ValorLinha {
    param($Linhas, [int]$Idx, [string]$Prop, [int]$Valor)
    # normaliza expressoes ("75 + 29") para o valor final, preservando o comentario
    $Linhas[$Idx] = $Linhas[$Idx] -replace "(?i)^(\s*\.$Prop\s*=\s*)[-+\d\s]+?(\s*&&.*)?$", "`${1}$Valor`${2}"
}

