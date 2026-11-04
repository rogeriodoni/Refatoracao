# =============================================================================
# CorrigirBotaoForaDaFaixa.ps1 - Erro303, GRUPO B
#
# Desloca o CONTAINER de botoes para que o botao mais alto dele fique 3px
# abaixo do topo da faixa do cabecalho:
#
#     novoTop = faixa.Top + 3 - min(btn.Top do container)
#
# Mexe SO no .Top do container - uma linha por container. Nao toca no .Top dos
# botoes, o que preserva arranjo relativo (o FormCNF tem botao em Top=17).
#
# Com botao de Height=75 numa faixa de Height=80, o resultado e 3px de folga
# acima e 2px abaixo - o botao fica INTEIRO dentro da faixa.
#
# NAO trata o sub-grupo B1 (faixa em Top=2): la o defeito e a FAIXA estar alta
# demais (Erro296), os containers ja estao certos, e mexer neles esconderia o
# defeito real. B1 e tratado a parte.
#
# Por padrao roda em simulacao. -Aplicar grava.
# =============================================================================
[CmdletBinding()]
param(
    [string] $Csv      = 'C:\4c\automation\_botao_fora_da_faixa.csv',
    [string] $Pasta    = 'C:\4c\projeto\app\forms',
    [switch] $Aplicar
)

# Avalia expressao de soma: ".Top = 8 + 29" vale 37. SEM isto o regex le so o
# primeiro termo, o calculo sai errado E a gravacao DESTROI a expressao
# (".Top = 8 + 29" virou ".Top = 27 + 29" = 56, pior que o original). Aconteceu
# no FormMtt - por isso o corretor tambem RECUSA gravar sobre expressao.
function Get-Soma {
    param([string] $txt)
    $t = ($txt -replace '&&.*$', '').Trim()
    if ($t -notmatch '^-?\d+(\s*\+\s*-?\d+)*$') { return $null }
    $acc = 0
    foreach ($p in ($t -split '\+')) { $acc += [int]$p.Trim() }
    return $acc
}

# ---- parser: devolve, por metodo, objeto -> props + LINHA do .Top -----------
function Get-ObjsComLinha {
    param([string[]] $linhas)
    $objs = @{}
    $metodo = ''
    $withAlvo = $null
    $withStack = New-Object System.Collections.Stack

    for ($i = 0; $i -lt $linhas.Count; $i++) {
        $s = $linhas[$i].Trim()
        if ($s -match '^\*') { continue }

        if ($s -match '(?i)^(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+(\w+)') {
            $metodo = $Matches[3]; $withStack.Clear(); $withAlvo = $null; continue
        }
        if ($s -match '(?i)([\w\.]*)AddObject\(\s*"(\w+)"\s*,\s*"(\w+)"\s*\)') {
            $prefixo = $Matches[1].TrimEnd('.')
            $nome = $Matches[2]; $classe = $Matches[3]
            $pai = ''
            if ($prefixo -match '(\w+)$') { $pai = $Matches[1] }
            if ($prefixo -eq '' -and $withAlvo) { $pai = $withAlvo }
            $objs["$metodo|$nome"] = [ordered]@{
                Nome=$nome; Classe=$classe; Pai=$pai; Metodo=$metodo
                Top=$null; Height=$null; BackColor=''; LinhaTop=-1
            }
            continue
        }
        if ($s -match '(?i)^WITH\s+(.+)$') {
            $e = $Matches[1].Trim()
            $withAlvo = if ($e -match '(\w+)$') { $Matches[1] } else { $null }
            $withStack.Push($withAlvo); continue
        }
        if ($s -match '(?i)^ENDWITH') {
            if ($withStack.Count -gt 0) { [void]$withStack.Pop() }
            $withAlvo = if ($withStack.Count -gt 0) { $withStack.Peek() } else { $null }
            continue
        }

        $chave = "$metodo|$withAlvo"
        if ($withAlvo -and $objs.Contains($chave)) {
            if ($s -match '(?i)^\.Top\s*=\s*(.+)$') {
                $v = Get-Soma $Matches[1]
                if ($null -ne $v -and $null -eq $objs[$chave].Top) {
                    $objs[$chave].Top = $v
                    $objs[$chave].LinhaTop = $i
                }
            }
            elseif ($s -match '(?i)^\.Height\s*=\s*(.+)$') {
                $v = Get-Soma $Matches[1]
                if ($null -ne $v) { $objs[$chave].Height = $v }
            }
            elseif ($s -match '(?i)^\.BackColor\s*=\s*RGB\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)') {
                $objs[$chave].BackColor = "$($Matches[1]),$($Matches[2]),$($Matches[3])"
            }
        }
        elseif ($s -match '(?i)(\w+)\.Top\s*=\s*(.+)$') {
            $k = "$metodo|$($Matches[1])"
            $v = Get-Soma $Matches[2]
            if ($null -ne $v -and $objs.Contains($k) -and $null -eq $objs[$k].Top) {
                $objs[$k].Top = $v; $objs[$k].LinhaTop = $i
            }
        }
    }
    return $objs
}

$alvos = Import-Csv $Csv |
         Where-Object { [int]$_.Transbordo -gt 4 -and $_.Faixa -notmatch '\s2\.\.' }
$formsAlvo = $alvos | Group-Object Form

Write-Host ""
Write-Host "=============================================================="
Write-Host " CORRIGIR BOTAO FORA DA FAIXA - GRUPO B2    $(if($Aplicar){'[APLICANDO]'}else{'[SIMULACAO]'})"
Write-Host "=============================================================="
Write-Host " forms alvo: $($formsAlvo.Count)   sites: $($alvos.Count)"
Write-Host ""

$nCont = 0; $nForm = 0; $naoAplicados = New-Object System.Collections.ArrayList

foreach ($g in $formsAlvo) {
    $arq = Get-ChildItem -Path $Pasta -Filter "$($g.Name).prg" -Recurse -File |
           Where-Object { $_.Name -notlike '*.bak*' } | Select-Object -First 1
    if (-not $arq) { [void]$naoAplicados.Add("$($g.Name): arquivo nao encontrado"); continue }

    $linhas = [System.IO.File]::ReadAllLines($arq.FullName)
    $objs = Get-ObjsComLinha -linhas $linhas
    $mudou = $false

    # containers distintos citados no CSV para este form
    $chaves = $g.Group | ForEach-Object { "$($_.Metodo)|$(($_.Container -split ' ')[0])" } | Sort-Object -Unique

    foreach ($ch in $chaves) {
        if (-not $objs.Contains($ch)) { [void]$naoAplicados.Add("$($g.Name): $ch nao reencontrado no parse"); continue }
        $cont = $objs[$ch]
        $metodo = $cont.Metodo

        # faixa do MESMO metodo (BackColor 100,100,100 + Height >= 60)
        $faixa = $objs.Values | Where-Object {
            $_.Metodo -eq $metodo -and $_.Classe -ieq 'Container' -and
            $_.BackColor -eq '100,100,100' -and $null -ne $_.Height -and $_.Height -ge 60 -and $null -ne $_.Top
        } | Select-Object -First 1
        if (-not $faixa) { [void]$naoAplicados.Add("$($g.Name): faixa nao achada em $metodo"); continue }

        # menor btn.Top dentre os botoes DESTE container
        $btns = $objs.Values | Where-Object {
            $_.Metodo -eq $metodo -and $_.Classe -ieq 'CommandButton' -and $_.Pai -eq $cont.Nome -and $null -ne $_.Top
        }
        if (-not $btns) { [void]$naoAplicados.Add("$($g.Name): sem botoes em $($cont.Nome)"); continue }
        # Os objetos do parser sao HASHTABLE: "Measure-Object Top" nao enxerga
        # chave de hashtable (so propriedade de PSObject) e devolve NULO sem
        # erro util. Projetar o valor ANTES de medir.
        $minBtn = ($btns | ForEach-Object { $_.Top } | Measure-Object -Minimum).Minimum
        $maxFim = ($btns | ForEach-Object { $_.Top + $_.Height } | Measure-Object -Maximum).Maximum
        if ($null -eq $minBtn) {
            [void]$naoAplicados.Add("$($g.Name)/$($cont.Nome): nao consegui medir o Top dos botoes"); continue
        }

        $novoTop = $faixa.Top + 3 - $minBtn

        # o conjunto de botoes cabe na faixa?
        if (($novoTop + $maxFim) -gt ($faixa.Top + $faixa.Height)) {
            [void]$naoAplicados.Add("$($g.Name)/$($cont.Nome): conjunto de botoes NAO cabe na faixa (altura $maxFim vs faixa $($faixa.Height)) - revisar a mao")
            continue
        }
        if ($cont.LinhaTop -lt 0) { [void]$naoAplicados.Add("$($g.Name): linha do .Top de $($cont.Nome) nao localizada"); continue }
        if ($novoTop -eq $cont.Top) { continue }

        $orig = $linhas[$cont.LinhaTop]
        # RECUSA gravar sobre expressao (".Top = 8 + 29"): o replace trocaria so
        # o primeiro termo e o resultado sairia somado ao resto (Erro303).
        if (($orig -replace '&&.*$','') -match '(?i)\.Top\s*=\s*-?\d+\s*\+') {
            [void]$naoAplicados.Add("$($g.Name)/$($cont.Nome): .Top e EXPRESSAO na linha $($cont.LinhaTop+1) - corrigir a mao"); continue
        }
        if ($orig -notmatch '(?i)(\s*\.?\w*\.?Top\s*=\s*)(-?\d+)') {
            [void]$naoAplicados.Add("$($g.Name): linha $($cont.LinhaTop+1) nao casa o padrao de Top"); continue
        }
        $nova = $orig -replace '(?i)^(\s*\.Top\s*=\s*)(-?\d+)', "`${1}$novoTop"
        if ($nova -eq $orig) {
            [void]$naoAplicados.Add("$($g.Name): substituicao nao alterou a linha $($cont.LinhaTop+1)"); continue
        }

        Write-Host ("   {0,-18} {1,-22} {2,-24} Top {3,3} -> {4,3}   (faixa {5}..{6}, btn min {7})" -f `
            $g.Name, $metodo, $cont.Nome, $cont.Top, $novoTop, $faixa.Top, ($faixa.Top+$faixa.Height), $minBtn)

        $linhas[$cont.LinhaTop] = $nova
        $nCont++; $mudou = $true
    }

    if ($mudou) {
        $nForm++
        if ($Aplicar) {
            $sw = New-Object System.IO.StreamWriter($arq.FullName, $false, (New-Object System.Text.UTF8Encoding($false)))
            foreach ($l in $linhas) { $sw.Write($l); $sw.Write("`r`n") }
            $sw.Close()
        }
    }
}

Write-Host ""
Write-Host " containers ajustados : $nCont"
Write-Host " forms alterados      : $nForm"
if ($naoAplicados.Count -gt 0) {
    Write-Host ""
    Write-Host " NAO APLICADOS ($($naoAplicados.Count)) - revisar a mao:"
    $naoAplicados | ForEach-Object { Write-Host "   $_" }
}
if (-not $Aplicar) { Write-Host ""; Write-Host " (simulacao - use -Aplicar para gravar)" }
