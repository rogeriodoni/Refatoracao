# =============================================================================
# VerificarBotaoForaDaFaixa.ps1 - Erro303 / Erro299
#
# Acha container de BOTAO cujo botao TRANSBORDA a faixa do cabecalho.
#
# Origem do defeito: o migrador transcreve FIELMENTE o Top do SCX
# (Grupo_Salva.Top + 29), mas o legado NAO tem faixa de cabecalho na pagina
# Dados - ela e decisao do projeto (regra #11, que prevalece sobre o PILAR 1).
# O valor fiel entao nao cabe dentro da faixa.
#
# PRE-FILTRO estatico: a confirmacao e por INSTANCIACAO (o parser nao resolve
# variavel de pagina reatribuida nem AddObject indireto - regras #11/#39/#44).
#
# A faixa NUNCA e identificada por NOME (8 forms chamam de cnt_4c_Sombra e o
# Formpgr usa cnt_4c_Cabecalho para um container de CAMPOS): e identificada por
# BackColor = RGB(100,100,100) + Height >= 60, como manda a regra #11.
# =============================================================================
[CmdletBinding()]
param(
    [string] $Pasta = 'C:\4c\projeto\app\forms',
    [string] $Form  = '',
    [switch] $Detalhar
)

# Avalia uma expressao de soma: "2 + 29" vale 31. Sem isso o regex captura so
# o primeiro termo e um form com ".Top = 2 + 29" (faixa correta, em 31) vira
# FALSO POSITIVO - foi o caso do FormFTF e do FormCVI.
function Get-Soma {
    param([string] $txt)
    $t = $txt.Trim()
    if ($t -notmatch '^-?\d+(\s*\+\s*-?\d+)*$') { return $null }
    $acc = 0
    foreach ($p in ($t -split '\+')) { $acc += [int]$p.Trim() }
    return $acc
}

function Get-Blocos {
    # Devolve, por metodo, os objetos criados com AddObject e as props do WITH
    param([string[]] $linhas)

    $objs = @{}      # nome -> @{ Classe; Pai; Top; Height; BackColor; Metodo; Linha }
    $metodo = ''
    $withAlvo = $null
    $withStack = New-Object System.Collections.Stack

    for ($i = 0; $i -lt $linhas.Count; $i++) {
        $l = $linhas[$i]
        $s = $l.Trim()
        if ($s -match '^\*') { continue }   # comentario

        if ($s -match '(?i)^(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+(\w+)') {
            $metodo = $Matches[3]
            $withStack.Clear()
            $withAlvo = $null
            continue
        }

        # AddObject("nome", "Classe")  -- com ou sem prefixo de container
        if ($s -match '(?i)([\w\.]*)AddObject\(\s*"(\w+)"\s*,\s*"(\w+)"\s*\)') {
            # o [\w\.]* e guloso e ENGOLE o ponto final: "loc_oPagina.cnt_X."
            # Sem o TrimEnd, (\w+)$ nao casa e o PAI fica vazio - era por isso
            # que o detector nao achava nada.
            $prefixo = $Matches[1].TrimEnd('.')
            $nome    = $Matches[2]
            $classe  = $Matches[3]
            $pai = ''
            if ($prefixo -match '(\w+)$') { $pai = $Matches[1] }
            if ($prefixo -eq '' -and $withAlvo) { $pai = $withAlvo }
            # chave METODO+NOME: Page1 e Page2 criam objetos de MESMO nome
            # (cnt_4c_Cabecalho nas duas), e chavear so pelo nome faz a segunda
            # sobrescrever a primeira.
            $objs["$metodo|$nome"] = [ordered]@{
                Nome = $nome; Classe = $classe; Pai = $pai; Metodo = $metodo
                Top = $null; Height = $null; BackColor = ''; Linha = $i + 1
            }
            continue
        }

        if ($s -match '(?i)^WITH\s+(.+)$') {
            $alvoExpr = $Matches[1].Trim()
            if ($alvoExpr -match '(\w+)$') { $withAlvo = $Matches[1] } else { $withAlvo = $null }
            $withStack.Push($withAlvo)
            continue
        }
        if ($s -match '(?i)^ENDWITH') {
            if ($withStack.Count -gt 0) { [void]$withStack.Pop() }
            $withAlvo = if ($withStack.Count -gt 0) { $withStack.Peek() } else { $null }
            continue
        }

        # propriedade dentro de WITH
        $chave = "$metodo|$withAlvo"
        if ($withAlvo -and $objs.Contains($chave)) {
            if ($s -match '(?i)^\.Top\s*=\s*(.+)$') {
                $v = Get-Soma $Matches[1]
                if ($null -ne $v) { $objs[$chave].Top = $v }
            }
            elseif ($s -match '(?i)^\.Height\s*=\s*(.+)$') {
                $v = Get-Soma $Matches[1]
                if ($null -ne $v) { $objs[$chave].Height = $v }
            }
            elseif ($s -match '(?i)^\.BackColor\s*=\s*RGB\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)') {
                $objs[$chave].BackColor = "$($Matches[1]),$($Matches[2]),$($Matches[3])"
            }
        }
        # propriedade qualificada fora de WITH: obj.Top = N
        elseif ($s -match '(?i)(\w+)\.(Top|Height)\s*=\s*(.+)$') {
            $n = "$metodo|$($Matches[1])"
            $prop = $Matches[2]
            $v = Get-Soma $Matches[3]
            if ($null -ne $v -and $objs.Contains($n) -and $null -eq $objs[$n].$prop) { $objs[$n].$prop = $v }
        }
    }
    return $objs
}

$arquivos = Get-ChildItem -Path $Pasta -Filter 'Form*.prg' -Recurse -File |
            Where-Object { $_.Name -notlike '*.bak*' }
if ($Form) { $arquivos = $arquivos | Where-Object { $_.BaseName -ieq $Form } }

$achados = New-Object System.Collections.ArrayList
$semFaixa = 0
$total = 0

foreach ($arq in $arquivos) {
    $total++
    $linhas = [System.IO.File]::ReadAllLines($arq.FullName)
    $objs = Get-Blocos -linhas $linhas

    # agrupar por metodo: cada pagina e configurada num metodo proprio
    $metodos = $objs.Values | ForEach-Object { $_.Metodo } | Sort-Object -Unique
    foreach ($m in $metodos) {
        $doMetodo = $objs.Values | Where-Object { $_.Metodo -eq $m }

        # faixa: Container com BackColor 100,100,100 e Height >= 60 (regra #11)
        $faixa = $doMetodo | Where-Object {
            $_.Classe -ieq 'Container' -and $_.BackColor -eq '100,100,100' -and
            $null -ne $_.Height -and $_.Height -ge 60 -and $null -ne $_.Top
        } | Select-Object -First 1
        if (-not $faixa) { continue }
        $faixaFim = $faixa.Top + $faixa.Height

        # containers que tem CommandButton filho
        $conts = $doMetodo | Where-Object { $_.Classe -ieq 'Container' -and $null -ne $_.Top -and $_.Nome -ne $faixa.Nome }
        foreach ($c in $conts) {
            $btns = $doMetodo | Where-Object {
                $_.Classe -ieq 'CommandButton' -and $_.Pai -eq $c.Nome -and
                $null -ne $_.Top -and $null -ne $_.Height
            }
            if (-not $btns) { continue }
            foreach ($b in $btns) {
                $fim = $c.Top + $b.Top + $b.Height
                $ini = $c.Top + $b.Top
                # So interessa botao que PERTENCE a barra do topo, isto e, que
                # INTERSECTA a faixa. Sem isso, container que vive ao lado da
                # grade (cnt_4c_InsFtc, Top=282) aparece com "transbordo" de
                # 200+px - falso positivo, nao e barra de cabecalho nenhuma.
                if ($ini -ge $faixaFim -or $fim -le $faixa.Top) { continue }

                # Transbordo dos DOIS lados. Medir so por baixo deixava passar
                # o caso GRAVE: cnt_4c_Botoes com Top = 0 poe os botoes CRUD em
                # -24 na tela, decapitados (Formorl/FormCsi, Erro303).
                $tBaixo = [Math]::Max($fim - $faixaFim, 0)
                $tCima  = [Math]::Max($faixa.Top - $ini, 0)
                if ($tBaixo -eq 0 -and $tCima -eq 0) { continue }

                [void]$achados.Add([pscustomobject]@{
                    Form        = $arq.BaseName
                    Pasta       = $arq.Directory.Name
                    Metodo      = $m
                    Faixa       = "$($faixa.Nome) $($faixa.Top)..$faixaFim"
                    Container   = "$($c.Nome) Top=$($c.Top)"
                    Botao       = "$($b.Nome) Top=$($b.Top) H=$($b.Height)"
                    BotaoIni    = $ini
                    BotaoFim    = $fim
                    Transbordo  = $tBaixo
                    AcimaDoTopo = $tCima
                    FolgaTopo   = $ini - $faixa.Top
                })
            }
        }
    }
}

$porForm = $achados | Group-Object Form
Write-Host ""
Write-Host "=============================================================="
Write-Host " BOTAO FORA DA FAIXA DO CABECALHO  (pre-filtro estatico)"
Write-Host "=============================================================="
Write-Host " forms varridos            : $total"
Write-Host " forms CANDIDATOS          : $($porForm.Count)"
Write-Host " sites (botao x faixa)     : $($achados.Count)"
Write-Host ""

if ($achados.Count -gt 0) {
    Write-Host " --- por tamanho do transbordo ---"
    $achados | Group-Object Transbordo | Sort-Object { [int]$_.Name } |
        ForEach-Object { "   transbordo {0,3}px : {1,4} sites" -f $_.Name, $_.Count }
    Write-Host ""
    Write-Host " --- forms (transbordo maximo) ---"
    $porForm | ForEach-Object {
        [pscustomobject]@{
            Form  = $_.Name
            Pasta = $_.Group[0].Pasta
            Sites = $_.Count
            MaxTransbordo = ($_.Group | Measure-Object Transbordo -Maximum).Maximum
        }
    } | Sort-Object MaxTransbordo -Descending | Format-Table -AutoSize | Out-String -Width 200 | Write-Host
}

if ($Detalhar) {
    $achados | Sort-Object Form, Metodo | Format-Table Form, Metodo, Faixa, Container, Botao, Transbordo, FolgaTopo -AutoSize |
        Out-String -Width 250 | Write-Host
}

$achados | Export-Csv 'C:\4c\automation\_botao_fora_da_faixa.csv' -NoTypeInformation -Encoding UTF8
Write-Host " csv: C:\4c\automation\_botao_fora_da_faixa.csv"
