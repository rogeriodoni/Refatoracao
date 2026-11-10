$ErrorActionPreference = 'Stop'
$enc = [System.Text.Encoding]::GetEncoding(28591)   # latin-1: preserva byte a byte
$prg = 'C:\4c\projeto\app\forms\operacionais\FormSigOpIbo.prg'
$tmp = 'C:\4c\automation\_tmp746'

function Read-Blk([string]$nome) {
    $t = [System.IO.File]::ReadAllText((Join-Path $tmp $nome), $enc)
    # normaliza para CRLF (os blocos de staging podem vir em LF)
    $t = $t -replace "`r`n", "`n"
    return ($t -replace "`n", "`r`n")
}

$txt = [System.IO.File]::ReadAllText($prg, $enc)
$orig = $txt

# ---- 1. HEADER: substitui o bloco "FICA PARA AS FASES 6 A 8" -------------
$linhas = $txt -split "`r`n", 0
$iIni = -1; $iFim = -1
for ($i = 0; $i -lt $linhas.Count; $i++) {
    if ($linhas[$i] -like '* --- O QUE FICA PARA AS FASES 6 A 8 *') { $iIni = $i }
    if ($linhas[$i] -like '* --- DECISOES DE MIGRACAO DESTA FASE *') { $iFim = $i }
}
if ($iIni -lt 0 -or $iFim -lt 0 -or $iFim -le $iIni) { throw "ancoras de header nao localizadas (ini=$iIni fim=$iFim)" }

$novoHeader = (Read-Blk 'blk_header.txt').TrimEnd("`r","`n")
$pre  = $linhas[0..($iIni-1)]
$pos  = $linhas[$iFim..($linhas.Count-1)]
$txt  = (($pre -join "`r`n") + "`r`n" + $novoHeader + "`r`n" + ($pos -join "`r`n"))
Write-Host ("[1] header: substituidas linhas {0}..{1}" -f ($iIni+1), $iFim)

# ---- 2. InicializarForm: novo bloco de passos ----------------------------
$ancIni = "            IF THIS.CarregarImpressoras()"
$ancFim = "                loc_lSucesso = .T.`r`n            ENDIF`r`n"
$p1 = $txt.IndexOf($ancIni)
if ($p1 -lt 0) { throw "ancora InicializarForm/IF nao localizada" }
$p2 = $txt.IndexOf($ancFim, $p1)
if ($p2 -lt 0) { throw "ancora InicializarForm/ENDIF nao localizada" }
$p2 = $p2 + $ancFim.Length
$novoInit = Read-Blk 'blk_init.txt'
if (-not $novoInit.EndsWith("`r`n")) { $novoInit = $novoInit + "`r`n" }
$txt = $txt.Substring(0, $p1) + $novoInit + $txt.Substring($p2)
Write-Host ("[2] InicializarForm: bloco de passos trocado ({0} chars -> {1})" -f ($p2-$p1), $novoInit.Length)

# ---- 3. ConfigurarEventos: docblock + corpo ------------------------------
$linhas = $txt -split "`r`n", 0
$jIni = -1; $jFim = -1
for ($i = 0; $i -lt $linhas.Count; $i++) {
    if ($linhas[$i] -match '^\s*\*\s*ConfigurarEventos - Liga os eventos') {
        # recua ate a linha de abertura do docblock
        $k = $i
        while ($k -gt 0 -and $linhas[$k-1] -notmatch '^\s*\*-{10,}') { $k-- }
        $jIni = $k - 1
    }
    if ($jIni -ge 0 -and $jFim -lt 0 -and $i -gt $jIni -and $linhas[$i] -match '^\s*ENDPROC\s*$') { $jFim = $i }
}
if ($jIni -lt 0 -or $jFim -lt 0) { throw "ancoras de ConfigurarEventos nao localizadas (ini=$jIni fim=$jFim)" }
$novoEv = (Read-Blk 'blk_eventos.txt').TrimEnd("`r","`n")
$pre = $linhas[0..($jIni-1)]
$pos = $linhas[($jFim+1)..($linhas.Count-1)]
$txt = (($pre -join "`r`n") + "`r`n" + $novoEv + "`r`n" + ($pos -join "`r`n"))
Write-Host ("[3] ConfigurarEventos: substituidas linhas {0}..{1}" -f ($jIni+1), ($jFim+1))

# ---- 4. Novos metodos: ANTES do docblock de AplicarEstadoBotoes ----------
$linhas = $txt -split "`r`n", 0
$kIns = -1
for ($i = 0; $i -lt $linhas.Count; $i++) {
    if ($linhas[$i] -match '^\s*\*\s*AplicarEstadoBotoes - Transcreve o bloco final') {
        $k = $i
        while ($k -gt 0 -and $linhas[$k-1] -notmatch '^\s*\*-{10,}') { $k-- }
        $kIns = $k - 1
        break
    }
}
if ($kIns -lt 0) { throw "ancora AplicarEstadoBotoes nao localizada" }
$novoMet = (Read-Blk 'blk_metodos.txt').TrimEnd("`r","`n")
$pre = $linhas[0..($kIns-1)]
$pos = $linhas[$kIns..($linhas.Count-1)]
$txt = (($pre -join "`r`n") + "`r`n" + $novoMet + "`r`n" + ($pos -join "`r`n"))
Write-Host ("[4] metodos novos inseridos antes da linha {0}" -f ($kIns+1))

# ---- 5. TornarControlesVisiveis: atualiza o paragrafo da lista de excecao -
$velho = "    * A lista de excecao cresce nas proximas fases: Opt_Impressora e Lbl_Erro`r`n" +
         "    * tambem nascem Visible = .F. no SCX, e a visibilidade de chkCarne/chkObss/`r`n" +
         "    * chkAgrupa depende do tipo de boleto."
$novo  = "    * A lista de excecao esta COMPLETA desde a Fase 3 e cobre os tres controles`r`n" +
         "    * que o legado mantem permanentemente ocultos: cnt_4c_Container1,`r`n" +
         "    * obj_4c_Opt_Impressora e lbl_4c_Lbl_Erro. Os tres checkboxes de opcao NAO`r`n" +
         "    * entram nela: a visibilidade deles nao eh fixa - depende do tipo de boleto -`r`n" +
         "    * e por isso eh resolvida DEPOIS deste metodo, em AplicarVisibilidadeOpcoes."
if (-not $txt.Contains($velho)) { throw "ancora do paragrafo de TornarControlesVisiveis nao localizada" }
$txt = $txt.Replace($velho, $novo)
Write-Host "[5] TornarControlesVisiveis: paragrafo da lista de excecao atualizado"

if ($txt -eq $orig) { throw "nada mudou" }
[System.IO.File]::WriteAllText($prg, $txt, $enc)
Write-Host "OK gravado"
