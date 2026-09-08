#==============================================================================
# DiagnosticoCabecalhoPaginas.ps1
#
# Diz, por form CRUD, se cada pagina tem a faixa cinza do cabecalho.
# O container tem nome variavel entre os forms (cnt_4c_Cabecalho OU
# cnt_4c_Sombra), entao a deteccao eh por BackColor RGB(100,100,100) e nao
# por nome - foi o que evitou (tarde demais) injetar faixa duplicada em
# FormFte/FormUfs/Formpgr, que ja tinham a delas com o outro nome.
#
# Considera "cabecalho" o container com BackColor 100,100,100 e Height >= 60
# (os containers de botoes tambem usam esse BackColor, mas sao baixos ou tem
# nome de botao).
#==============================================================================
param([switch]$SoFaltantes)
$ErrorActionPreference = 'Stop'

$IGN_NOME = '(?i)(Botoes|Salva|Saida|Botao|Cmd)'
$semDados = @(); $ok = @(); $faltam = @()

foreach ($arq in (Get-ChildItem 'C:\4c\projeto\app\forms\cadastros' -Filter 'Form*.prg' -File | Where-Object { $_.Name -notlike '*.bak' } | Sort-Object Name)) {
    $linhas = [System.IO.File]::ReadAllLines($arq.FullName)

    $pagDe = @{}          # objeto -> pagina (1/2/0) em que foi criado
    $ehCab = @{}          # objeto -> tem faixa cinza alta
    $varPag = @{}         # variavel -> pagina
    $obj = ''; $altura = 0; $temCor = $false

    for ($i = 0; $i -lt $linhas.Count; $i++) {
        $l = $linhas[$i]
        if ($l -match '(?i)^\s*(\w+)\s*=\s*THIS\.pgf_4c_Paginas\.Page(\d)') { $varPag[$Matches[1]] = [int]$Matches[2]; continue }
        if ($l -match '(?i)(\w+)\.AddObject\s*\(\s*"(\w+)"\s*,\s*"Container"\s*\)') {
            $pai = $Matches[1]; $novo = $Matches[2]
            if ($obj -ne '' -and $temCor -and $altura -ge 60) { $ehCab[$obj] = $true }
            $obj = $novo; $altura = 0; $temCor = $false
            if ($varPag.ContainsKey($pai)) { $pagDe[$obj] = $varPag[$pai] }
            elseif ($pai -match '(?i)Page(\d)') { $pagDe[$obj] = [int]$Matches[1] }
            else { $pagDe[$obj] = 0 }
            continue
        }
        if ($l -match '(?i)THIS\.pgf_4c_Paginas\.Page(\d)\.AddObject\s*\(\s*"(\w+)"\s*,\s*"Container"') {
            if ($obj -ne '' -and $temCor -and $altura -ge 60) { $ehCab[$obj] = $true }
            $obj = $Matches[2]; $pagDe[$obj] = [int]$Matches[1]; $altura = 0; $temCor = $false
            continue
        }
        if ($obj -ne '') {
            if ($l -match '(?i)^\s*\.BackColor\s*=\s*RGB\(\s*100\s*,\s*100\s*,\s*100\s*\)') { $temCor = $true }
            if ($l -match '(?i)^\s*\.Height\s*=\s*(\d+)') { if ($altura -eq 0) { $altura = [int]$Matches[1] } }
        }
    }
    if ($obj -ne '' -and $temCor -and $altura -ge 60) { $ehCab[$obj] = $true }

    $p1 = @($ehCab.Keys | Where-Object { $pagDe[$_] -eq 1 -and $_ -notmatch $IGN_NOME })
    $p2 = @($ehCab.Keys | Where-Object { $pagDe[$_] -eq 2 -and $_ -notmatch $IGN_NOME })

    if ($p2.Count -ge 1) { $ok += ("{0,-24} Page1={1} Page2={2}" -f $arq.Name, ($p1 -join ','), ($p2 -join ',')) }
    else { $faltam += ("{0,-24} Page1={1} Page2=(nenhum)" -f $arq.Name, $(if ($p1.Count) { $p1 -join ',' } else { '(nenhum)' })) }
}

Write-Host "Page2 COM faixa:  $($ok.Count)" -ForegroundColor Green
Write-Host "Page2 SEM faixa:  $($faltam.Count)" -ForegroundColor Yellow
if (-not $SoFaltantes) { $ok | ForEach-Object { Write-Host "  $_" } }
Write-Host ""
Write-Host "--- FALTANDO:" -ForegroundColor Yellow
$faltam | ForEach-Object { Write-Host "  $_" }
