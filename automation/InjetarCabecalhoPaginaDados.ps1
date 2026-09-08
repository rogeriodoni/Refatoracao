#==============================================================================
# InjetarCabecalhoPaginaDados.ps1
#
# PROPOSITO: injeta o cabecalho cinza (cnt_4c_Cabecalho + lbl_4c_Sombra +
#            lbl_4c_Titulo) na pagina DADOS dos forms CRUD que so o tem na
#            pagina Lista, deixando as duas paginas com a mesma faixa
#            superior (Erro152).
#
# Bloco canonico: Formcfo.prg ConfigurarPaginaDados (Top=29, Height=80,
# BackColor 100,100,100, labels Tahoma 16 bold - sombra preta em Top=15 e
# titulo branco em Top=18).
#
# O cabecalho eh injetado como PRIMEIRO AddObject da pagina, para que os
# containers de botoes (cnt_4c_Salva / cnt_4c_BotoesAcao / cnt_4c_Saida)
# criados depois fiquem POR CIMA da faixa - o mesmo arranjo do Formcfo.
#
# SEGURANCA: forms cujos CAMPOS (labels/textboxes) ficam na faixa (Top < 109)
# sao PULADOS por padrao e listados no fim; injetar sem deslocar o conteudo
# deixaria campo ilegivel sobre o cinza. Use -Listar para so ver o diagnostico.
#
# USO:
#   .\InjetarCabecalhoPaginaDados.ps1 -Listar     # diagnostico, nao altera
#   .\InjetarCabecalhoPaginaDados.ps1             # injeta nos forms seguros
#==============================================================================

param(
    [switch]$Listar,
    [string]$Pasta = 'C:\4c\projeto\app\forms\cadastros'
)

$ErrorActionPreference = 'Stop'

$LIMITE_FAIXA = 109        # 29 (Top) + 80 (Height)
$IGNORAR_COLISAO = '(?i)(cnt_4c_(Botoes|Salva|Saida|Cabecalho)|shp_4c_)'

function Get-BlocoCabecalho {
    param([string]$Var, [string]$Indent)
    $l = @()
    $l += "$Indent*-- Cabecalho cinza (identico ao da pagina Lista) - Erro152"
    $l += "$Indent$Var.AddObject(`"cnt_4c_Cabecalho`", `"Container`")"
    $l += "$Indent" + "WITH $Var.cnt_4c_Cabecalho"
    $l += "$Indent    .Top           = 29"
    $l += "$Indent    .Left          = 0"
    $l += "$Indent    .Width         = THIS.Width"
    $l += "$Indent    .Height        = 80"
    $l += "$Indent    .BackColor     = RGB(100, 100, 100)"
    $l += "$Indent    .BorderWidth   = 0"
    $l += "$Indent    .SpecialEffect = 0"
    $l += "$Indent    .Visible       = .T."
    $l += ""
    $l += "$Indent    .AddObject(`"lbl_4c_Sombra`", `"Label`")"
    $l += "$Indent    WITH .lbl_4c_Sombra"
    $l += "$Indent        .Caption   = THIS.Caption"
    $l += "$Indent        .Top       = 15"
    $l += "$Indent        .Left      = 10"
    $l += "$Indent        .Width     = THIS.Width"
    $l += "$Indent        .Height    = 40"
    $l += "$Indent        .FontName  = `"Tahoma`""
    $l += "$Indent        .FontSize  = 16"
    $l += "$Indent        .FontBold  = .T."
    $l += "$Indent        .ForeColor = RGB(0, 0, 0)"
    $l += "$Indent        .BackStyle = 0"
    $l += "$Indent        .AutoSize  = .F."
    $l += "$Indent        .Visible   = .T."
    $l += "$Indent    ENDWITH"
    $l += ""
    $l += "$Indent    .AddObject(`"lbl_4c_Titulo`", `"Label`")"
    $l += "$Indent    WITH .lbl_4c_Titulo"
    $l += "$Indent        .Caption   = THIS.Caption"
    $l += "$Indent        .Top       = 18"
    $l += "$Indent        .Left      = 10"
    $l += "$Indent        .Width     = THIS.Width"
    $l += "$Indent        .Height    = 46"
    $l += "$Indent        .FontName  = `"Tahoma`""
    $l += "$Indent        .FontSize  = 16"
    $l += "$Indent        .FontBold  = .T."
    $l += "$Indent        .ForeColor = RGB(255, 255, 255)"
    $l += "$Indent        .BackStyle = 0"
    $l += "$Indent        .AutoSize  = .F."
    $l += "$Indent        .Visible   = .T."
    $l += "$Indent    ENDWITH"
    $l += "$Indent" + "ENDWITH"
    $l += ""
    return $l
}

$injetados = @(); $pulados = @(); $semMetodo = @(); $jaTem = 0

foreach ($arq in (Get-ChildItem $Pasta -Filter 'Form*.prg' -File | Where-Object { $_.Name -notlike '*.bak' } | Sort-Object Name)) {
    $txt = [System.IO.File]::ReadAllText($arq.FullName)
    if (([regex]::Matches($txt, 'AddObject\s*\(\s*"cnt_4c_Cabecalho"')).Count -ge 2) { $jaTem++; continue }

    $bytes  = [System.IO.File]::ReadAllBytes($arq.FullName)
    $temBom = ($bytes[0] -eq 0xEF)
    $linhas = [System.Collections.Generic.List[string]]::new()
    $linhas.AddRange([string[]]($txt -split "`r?`n"))

    # delimita o metodo da pagina de dados
    $ini = -1; $fim = -1
    for ($i = 0; $i -lt $linhas.Count; $i++) {
        if ($linhas[$i] -match '(?i)^\s*(PROTECTED\s+)?(PROCEDURE|FUNCTION)\s+ConfigurarPagina(Dados|2)\b') { $ini = $i; continue }
        if ($ini -ge 0 -and $linhas[$i] -match '(?i)^\s*(ENDPROC|ENDFUNC)\s*$') { $fim = $i; break }
    }
    if ($ini -lt 0) { $semMetodo += $arq.Name; continue }

    # variavel local da pagina: <var> = THIS.pgf_4c_Paginas.Page2
    $var = ''; $linhaVar = -1
    for ($i = $ini; $i -le $fim; $i++) {
        if ($linhas[$i] -match '(?i)^\s*(\w+)\s*=\s*THIS\.pgf_4c_Paginas\.Page2\s*$') { $var = $Matches[1]; $linhaVar = $i; break }
    }
    if ($var -eq '') { $semMetodo += ($arq.Name + " (sem variavel da Page2)"); continue }

    # colisoes: controle DIRETO na pagina com Top < 109 que nao seja container de botao
    $colide = @(); $obj = ''; $direto = $false
    for ($i = $ini; $i -le $fim; $i++) {
        $l = $linhas[$i]
        if ($l -match "(?i)$([regex]::Escape($var))\.AddObject\s*\(\s*`"(\w+)`"") { $obj = $Matches[1]; $direto = $true; continue }
        elseif ($l -match '(?i)\w+\.AddObject\s*\(\s*"(\w+)"') { $obj = ''; $direto = $false; continue }
        if ($direto -and $obj -ne '' -and $l -match '(?i)^\s*\.Top\s*=\s*(\d+)') {
            if ([int]$Matches[1] -lt $LIMITE_FAIXA -and $obj -notmatch $IGNORAR_COLISAO) { $colide += ("{0}(Top={1})" -f $obj, $Matches[1]) }
            $obj = ''
        }
    }
    if ($colide.Count -gt 0) { $pulados += ("{0,-24} {1}" -f $arq.Name, ($colide -join ' ')); continue }

    if ($Listar) { $injetados += $arq.Name; continue }

    # ponto de insercao: apos a linha do Picture da pagina, senao apos a atribuicao da variavel
    $ponto = $linhaVar
    for ($i = $linhaVar; $i -le [Math]::Min($linhaVar + 6, $fim); $i++) {
        if ($linhas[$i] -match "(?i)^\s*$([regex]::Escape($var))\.Picture\s*=") { $ponto = $i; break }
    }
    $indent = ([regex]::Match($linhas[$linhaVar], '^\s*')).Value
    $bloco  = Get-BlocoCabecalho -Var $var -Indent $indent
    $linhas.InsertRange($ponto + 1, [string[]]("" + ""))
    $linhas.InsertRange($ponto + 1, [string[]]$bloco)

    [System.IO.File]::WriteAllLines($arq.FullName, $linhas.ToArray(), (New-Object System.Text.UTF8Encoding($temBom)))
    $injetados += $arq.Name
}

Write-Host ""
Write-Host "ja tinham cabecalho nas 2 paginas: $jaTem" -ForegroundColor Gray
Write-Host ("{0}: {1}" -f $(if ($Listar) { "seriam injetados" } else { "INJETADOS" }), $injetados.Count) -ForegroundColor Green
Write-Host "pulados (campo sob a faixa):       $($pulados.Count)" -ForegroundColor Yellow
Write-Host "sem metodo de pagina de dados:     $($semMetodo.Count)" -ForegroundColor Gray
if ($pulados.Count -gt 0) {
    Write-Host ""
    Write-Host "--- PULADOS (exigem deslocar o conteudo antes de receber a faixa):" -ForegroundColor Yellow
    $pulados | ForEach-Object { Write-Host "  $_" }
}
if ($semMetodo.Count -gt 0) {
    Write-Host ""
    Write-Host "--- SEM METODO:" -ForegroundColor Gray
    $semMetodo | ForEach-Object { Write-Host "  $_" }
}
