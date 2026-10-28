<#
.SYNOPSIS
    Driver da validacao da carga sob demanda: instancia cada tela do menu no
    VFP9 headless e reinicia o VFP quando uma tela trava (dialogo modal no Init).

.EXAMPLE
    .\ValidarCargaTelas.ps1 -Modo sobdemanda
    .\ValidarCargaTelas.ps1 -Modo completo
    .\ValidarCargaTelas.ps1 -Comparar
#>
param(
    [ValidateSet('sobdemanda', 'completo')][string]$Modo = 'sobdemanda',
    [int]$TimeoutTela = 60,
    [int]$TimeoutAmbiente = 420,
    [switch]$Comparar
)

$dir  = $PSScriptRoot
$vfp  = 'C:\Program Files (x86)\Microsoft Visual FoxPro 9\vfp9.exe'
$menu = Join-Path $dir '..\..\projeto\app\menu\menu.prg'
$idxF = Join-Path $dir '..\..\projeto\app\start\indice_classes.txt'

function Ler-Resultados([string]$m) {
    $r = [ordered]@{}
    $f = Join-Path $dir "log_$m.txt"
    if (-not (Test-Path $f)) { return $r }
    foreach ($l in Get-Content $f) {
        $p = $l.Split('|')
        if ($p[0] -eq 'FIM')    { $r[$p[2]] = [pscustomobject]@{ Tipo = $p[3]; Tempo = $p[4]; Erro = ($p[5..($p.Count-1)] -join '|') } }
        if ($p[0] -eq 'TRAVOU') { $r[$p[2]] = [pscustomobject]@{ Tipo = 'TRAVOU'; Tempo = ''; Erro = '' } }
    }
    return $r
}

function Ler-Arvores([string]$m) {
    $a = @{}; $atual = $null
    foreach ($l in Get-Content (Join-Path $dir "arvore_$m.txt")) {
        if ($l.StartsWith('#')) { $atual = $l.Substring(1); $a[$atual] = New-Object System.Collections.Generic.List[string] }
        elseif ($atual) { $a[$atual].Add($l) }
    }
    return $a
}

if ($Comparar) {
    $rs = Ler-Resultados 'sobdemanda'; $rc = Ler-Resultados 'completo'
    $as = Ler-Arvores 'sobdemanda';    $ac = Ler-Arvores 'completo'
    $iguais = 0; $dif = @()
    foreach ($c in $rc.Keys) {
        if (-not $rs.Contains($c)) { $dif += "$c : so no modo completo"; continue }
        $s = $rs[$c]; $k = $rc[$c]
        $arvS = if ($as.ContainsKey($c)) { $as[$c] -join "`n" } else { '' }
        $arvC = if ($ac.ContainsKey($c)) { $ac[$c] -join "`n" } else { '' }
        # Mensagens trazem o horario ([28/10/2026 16:34:07], "T10 16:36:01") - ignorar
        $reHora = '\[\d{2}/\d{2}/\d{4} [\d:]+( [AP]M)?\]|\d{2}:\d{2}:\d{2}'
        $msgs = ($s.Tipo -eq $k.Tipo) -and (($s.Erro -replace $reHora, '') -eq ($k.Erro -replace $reHora, ''))
        if ($msgs -and $arvS -eq $arvC) { $iguais++ }
        else {
            $dif += "$c : completo=[$($k.Tipo)] $($k.Erro)"
            $dif += "$(' ' * $c.Length) : sobdem.=[$($s.Tipo)] $($s.Erro)"
            if ($arvS -ne $arvC) { $dif += "$(' ' * $c.Length)   arvore: completo $($ac[$c].Count) linhas, sob demanda $($as[$c].Count) linhas" }
        }
    }
    "Telas comparadas: $($rc.Count) | identicas: $iguais | diferentes: $($rc.Count - $iguais)"
    $dif
    "`nResumo por resultado (sob demanda):"
    $rs.Values | Group-Object Tipo | ForEach-Object { "  $($_.Name): $($_.Count)" }
    return
}

# Lista das classes que o menu cria (literais que estao no indice), na ordem do menu
$lista = Join-Path $dir 'lista_forms_menu.txt'
if (-not (Test-Path $lista)) {
    $idx = @{}
    Get-Content $idxF | Where-Object { $_ -like 'C|*' } | ForEach-Object { $idx[$_.Split('|')[1]] = 1 }
    $vistos = New-Object System.Collections.Generic.List[string]
    foreach ($m in [regex]::Matches((Get-Content $menu -Raw), '(?im)^(?!\s*\*).*?\bCREATEOBJECT\s*\(\s*"(\w+)"')) {
        $c = $m.Groups[1].Value
        if ($idx.ContainsKey($c.ToLower()) -and -not ($vistos | Where-Object { $_ -ieq $c })) { $vistos.Add($c) }
    }
    [IO.File]::WriteAllLines($lista, $vistos, [Text.Encoding]::ASCII)
}
$total = (Get-Content $lista).Count

$log = Join-Path $dir "log_$Modo.txt"
Remove-Item $log, (Join-Path $dir "arvore_$Modo.txt") -ErrorAction SilentlyContinue
$inicio = 1
$sw = [Diagnostics.Stopwatch]::StartNew()
while ($inicio -le $total) {
    $entrada = Join-Path $dir "_entrada_$Modo.prg"
    @(
        'SET SAFETY OFF', 'SET RESOURCE OFF', 'SYS(2335,0)',
        "SET PROCEDURE TO `"$dir\ValidarCargaTelas.prg`" ADDITIVE",
        "ValidarCargaTelas(`"$Modo`", $inicio)", 'QUIT'
    ) | Set-Content $entrada -Encoding ASCII
    $p = Start-Process $vfp -ArgumentList "-T `"$($entrada -replace '\.prg$','')`"" -PassThru
    $ultimaLinha = ''; $desde = Get-Date; $ambiente = $true
    while (-not $p.HasExited) {
        Start-Sleep -Seconds 2
        $u = if (Test-Path $log) { Get-Content $log -Tail 1 } else { '' }
        if ($u -ne $ultimaLinha) { $ultimaLinha = $u; $desde = Get-Date; if ($u -like 'INICIO*') { $ambiente = $false } }
        $lim = if ($ambiente) { $TimeoutAmbiente } else { $TimeoutTela }
        if (((Get-Date) - $desde).TotalSeconds -gt $lim) { $p.Kill(); Start-Sleep -Seconds 1; break }
    }
    $linhas = if (Test-Path $log) { Get-Content $log } else { @() }
    if ($linhas | Where-Object { $_ -like 'CONCLUIDO*' } | Select-Object -Last 1) {
        if (($linhas | Select-Object -Last 1) -like 'CONCLUIDO*') { break }
    }
    $u = $linhas | Where-Object { $_ -like 'INICIO|*' -or $_ -like 'FIM|*' } | Select-Object -Last 1
    if (-not $u) { "Ambiente nao carregou em $TimeoutAmbiente s - abortado"; break }
    $p2 = $u.Split('|'); $n = [int]$p2[1]
    if ($p2[0] -eq 'INICIO') { Add-Content $log "TRAVOU|$n|$($p2[2])" -Encoding ASCII }
    $inicio = $n + 1
}
Remove-Item (Join-Path $dir "_entrada_$Modo.*") -ErrorAction SilentlyContinue
"Modo $Modo concluido em $([math]::Round($sw.Elapsed.TotalMinutes,1)) min"
$r = Ler-Resultados $Modo
$r.Values | Group-Object Tipo | ForEach-Object { "  $($_.Name): $($_.Count)" }
