$dump = "C:\4c\tasks\task755\SigOpJob_form_codigo_fonte.txt"
$form = "C:\4c\projeto\app\forms\operacionais\FormSigOpJob.prg"
$txt  = Get-Content $dump -Raw
$cont = Get-Content $form -Raw
$linhas = $txt -split "`r?`n"

# --- Test-LegadoPaginadoSemPaginaDados ---
$pgfs = @{}; $objAtual = ""
foreach ($l in $linhas) {
    if ($l -match '^\s*Objeto:\s*(\S+)\s*$') { $objAtual = $matches[1] }
    elseif ($l -match '^\s*BaseClass:\s*pageframe\s*$') { if ($objAtual) { $pgfs[$objAtual.ToUpper()] = $true } }
}
$paginas = @{}
foreach ($l in $linhas) {
    if ($l -match '^\s*Parent:\s*(\S+)\s*$') {
        $segs = $matches[1] -split '\.'
        for ($i = 0; $i -lt $segs.Count - 1; $i++) {
            if ($pgfs.ContainsKey($segs[$i].ToUpper())) { $paginas[$segs[$i+1].ToUpper()] = $true }
        }
    }
}
$temDadosLista = $false
foreach ($p in $paginas.Keys) { if ($p -match 'DADO' -or $p -match 'LISTA') { $temDadosLista = $true } }
$legadoPagSemDados = ($pgfs.Count -ge 1) -and ($paginas.Count -ge 1) -and (-not $temDadosLista)

# --- Get-ContagemCamposLegadoForaDeGrade ---
$n = 0; $parentAtual = ""
foreach ($l in $linhas) {
    if ($l -match '^\s*Objeto:\s*(\S+)\s*$') { $parentAtual = "" }
    elseif ($l -match '^\s*Parent:\s*(\S+)\s*$') { $parentAtual = $matches[1] }
    elseif ($l -match '^\s*BaseClass:\s*textbox\s*$') { if ($parentAtual -notmatch '(?i)\.Column\d+$') { $n++ } }
}

$nMigrado = ([regex]::Matches($cont, 'AddObject\(\s*"[^"]+"\s*,\s*"TextBox\w*"')).Count
$piso = [math]::Ceiling($n / 2)

Write-Host "PageFrames legado : $($pgfs.Keys -join ', ')"
Write-Host "Pages legado      : $($paginas.Keys -join ', ')"
Write-Host "legadoPagSemDados : $legadoPagSemDados"
Write-Host "nCamposPagLegado  : $n"
Write-Host "piso (ceil n/2)   : $piso"
Write-Host "nCamposMigrado    : $nMigrado"
$rxPgf = 'AddObject\(\s*"pgf_4c_'
$temPgf = $cont -match $rxPgf
$temInit = $cont -match 'InicializarForm'
Write-Host "temPgf migrado    : $temPgf"
Write-Host "temInicializarForm: $temInit"
$gate = $legadoPagSemDados -and $temPgf -and $temInit -and ($n -ge 1) -and ($nMigrado -ge $piso)
Write-Host "GATE PASSA        : $gate"
