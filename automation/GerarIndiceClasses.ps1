<#
.SYNOPSIS
    Gera o indice de classes para a carga sob demanda (piloto).

.DESCRIPTION
    Varre os .prg de projeto\app (classes, utils, forms\*) e grava
    projeto\app\start\indice_classes.txt com duas familias de linha:

        C|<classe>|<arquivo>      classe definida (DEFINE CLASS) no arquivo
        D|<arquivo>|<arquivo>     o 1o arquivo depende do 2o

    Dependencia = referencia LITERAL a classe definida em outro arquivo:
        DEFINE CLASS X AS <Pai>          (classe-mae)
        CREATEOBJECT("X") / NEWOBJECT("X")
        .AddObject("nome", "X")  /  ADD OBJECT nome AS X

    Classe base do VFP e classe de VCX nao entram (nao tem .prg no indice).
    CREATEOBJECT(<variavel>) NAO eh detectavel: o chamador tem de fazer
    GarantirClasse(<variavel>) antes (FormSigPrCtr, FormSigPrHpr).

    <arquivo> eh relativo a projeto\app (ex.: forms\cadastros\FormLpr.prg).
    O arquivo de saida eh ASCII - o VFP9 le com FILETOSTR/ALINES.

.PARAMETER Raiz
    Pasta projeto\app. Default: relativa a este script.

.PARAMETER Classe
    Opcional: imprime o fecho de dependencias dessa classe (diagnostico).
#>
param(
    [string]$Raiz = (Join-Path $PSScriptRoot '..\projeto\app'),
    [string]$Classe = ''
)

$ErrorActionPreference = 'Stop'
$sw   = [Diagnostics.Stopwatch]::StartNew()
$Raiz = (Resolve-Path $Raiz).Path
$enc  = [Text.Encoding]::GetEncoding(1252)

$arquivos = @()
foreach ($sub in 'classes', 'utils', 'forms\cadastros', 'forms\relatorios', 'forms\operacionais') {
    $dir = Join-Path $Raiz $sub
    if (Test-Path $dir) {
        $arquivos += Get-ChildItem -Path $dir -Filter '*.prg' -File |
                     Where-Object { $_.Extension -eq '.prg' }
    }
}

$reDefine = [regex]'(?i)^\s*DEFINE\s+CLASS\s+(\w+)\s+AS\s+(\w+)(\s+OF\s+)?'
$reRefs   = @(
    [regex]'(?i)\b(?:CREATEOBJECT|NEWOBJECT)\s*\(\s*["''\[](\w+)["''\]]',
    [regex]'(?i)\bADDOBJECT\s*\(\s*[^,]+,\s*["''\[](\w+)["''\]]',
    [regex]'(?i)^\s*ADD\s+OBJECT\s+\w+\s+AS\s+(\w+)'
)

$classeArq  = @{}          # classe (lower) -> arquivo relativo
$duplicadas = @()
$refsArq    = @{}          # arquivo -> HashSet de classes referenciadas
$nomeArq    = @{}          # nome do arquivo (lower) -> arquivo relativo
$nomesDup   = @()

foreach ($f in $arquivos) {
    $rel = $f.FullName.Substring($Raiz.Length).TrimStart('\')
    $chaveNome = $f.Name.ToLower()
    if ($nomeArq.ContainsKey($chaveNome)) { $nomesDup += "$rel = $($nomeArq[$chaveNome])" }
    else { $nomeArq[$chaveNome] = $rel }

    $refs = New-Object 'System.Collections.Generic.HashSet[string]'
    foreach ($linha in [IO.File]::ReadAllLines($f.FullName, $enc)) {
        $t = $linha.TrimStart()
        if ($t.StartsWith('*') -or $t.StartsWith('&&') -or $t -match '^(?i)NOTE\s') { continue }
        $i = $t.IndexOf('&&')
        if ($i -ge 0) { $t = $t.Substring(0, $i) }

        $m = $reDefine.Match($t)
        if ($m.Success) {
            $c = $m.Groups[1].Value.ToLower()
            if ($classeArq.ContainsKey($c)) { $duplicadas += "$c : $($classeArq[$c]) | $rel" }
            else { $classeArq[$c] = $rel }
            if (-not $m.Groups[3].Success) { [void]$refs.Add($m.Groups[2].Value.ToLower()) }
        }
        foreach ($re in $reRefs) {
            foreach ($r in $re.Matches($t)) { [void]$refs.Add($r.Groups[1].Value.ToLower()) }
        }
    }
    $refsArq[$rel] = $refs
}

# Resolve classes -> arquivos (so o que esta no indice; o resto eh base VFP/VCX)
$depArq = @{}
$naoResolvidas = @{}
foreach ($rel in $refsArq.Keys) {
    $deps = New-Object 'System.Collections.Generic.HashSet[string]'
    foreach ($c in $refsArq[$rel]) {
        if ($classeArq.ContainsKey($c)) {
            $alvo = $classeArq[$c]
            if ($alvo -ne $rel) { [void]$deps.Add($alvo) }
        } else {
            $naoResolvidas[$c] = 1 + [int]$naoResolvidas[$c]
        }
    }
    $depArq[$rel] = $deps
}

$saida = New-Object System.Collections.Generic.List[string]
$saida.Add("* Indice de classes - gerado por automation\GerarIndiceClasses.ps1 em $(Get-Date -Format 's')")
$saida.Add('* NAO editar a mao. Regerar apos migrar/renomear form ou BO.')
foreach ($c in ($classeArq.Keys | Sort-Object)) { $saida.Add("C|$c|$($classeArq[$c])") }
foreach ($rel in ($depArq.Keys | Sort-Object)) {
    foreach ($d in ($depArq[$rel] | Sort-Object)) { $saida.Add("D|$rel|$d") }
}
$destino = Join-Path $Raiz 'start\indice_classes.txt'
[IO.File]::WriteAllLines($destino, $saida, [Text.Encoding]::ASCII)

function Get-Fecho([string]$arq) {
    $visto = New-Object 'System.Collections.Generic.HashSet[string]'
    $pilha = New-Object System.Collections.Stack
    $pilha.Push($arq)
    while ($pilha.Count) {
        $a = $pilha.Pop()
        if ($visto.Add($a)) { foreach ($d in $depArq[$a]) { $pilha.Push($d) } }
    }
    return $visto
}

$sw.Stop()
"Arquivos varridos : $($arquivos.Count)"
"Classes indexadas : $($classeArq.Count)"
"Dependencias      : $(($depArq.Values | ForEach-Object { $_.Count } | Measure-Object -Sum).Sum)"
"Tempo             : $([math]::Round($sw.Elapsed.TotalSeconds,1)) s"
"Saida             : $destino"
if ($duplicadas.Count) { "`nClasse definida em 2+ arquivos ($($duplicadas.Count)) - vale a 1a:"; $duplicadas | ForEach-Object { "  $_" } }
if ($nomesDup.Count)   { "`nNome de arquivo repetido em pastas diferentes ($($nomesDup.Count)):"; $nomesDup | ForEach-Object { "  $_" } }

# Fecho de cada form: quantos arquivos abrir cada tela puxa
$fechos = foreach ($rel in $depArq.Keys | Where-Object { $_ -like 'forms\*' }) {
    [pscustomobject]@{ Arquivo = $rel; Total = (Get-Fecho $rel).Count }
}
$st = $fechos | Measure-Object Total -Average -Maximum
"`nFecho por form: media $([math]::Round($st.Average,1)) arquivos, maximo $($st.Maximum)"
$fechos | Sort-Object Total -Descending | Select-Object -First 5 | ForEach-Object { "  $($_.Total)  $($_.Arquivo)" }

if ($Classe) {
    $c = $Classe.ToLower()
    if (-not $classeArq.ContainsKey($c)) { "`nClasse '$Classe' nao esta no indice." }
    else {
        "`nFecho de $Classe ($($classeArq[$c])):"
        Get-Fecho $classeArq[$c] | Sort-Object | ForEach-Object { "  $_" }
    }
}
