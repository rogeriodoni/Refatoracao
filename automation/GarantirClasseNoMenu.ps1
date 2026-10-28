<#
.SYNOPSIS
    Insere GarantirClasse("X") antes de cada CREATEOBJECT("X") do menu.prg que
    ainda nao tem (carga sob demanda). Idempotente.

.DESCRIPTION
    So mexe em classe que esta no indice (start\indice_classes.txt) - classe
    base do VFP ou de VCX nao precisa. Linha comentada e linha precedida de
    GarantirClasse ficam como estao. Mantem a indentacao, CRLF e Windows-1252.

    Regera o indice ANTES (GerarIndiceClasses.ps1): tela que acabou de chegar
    por git pull ainda nao esta no indice e seria pulada. -SemRegerar pula
    esse passo (o Orquestrador ja regerou logo antes).

    -Verificar: so lista o que falta e sai com 1 se houver pendencia.

    Uso tipico depois de um git pull:
        .\automation\GarantirClasseNoMenu.ps1
#>
param(
    [string]$Menu   = (Join-Path $PSScriptRoot '..\projeto\app\menu\menu.prg'),
    [string]$Indice = (Join-Path $PSScriptRoot '..\projeto\app\start\indice_classes.txt'),
    [switch]$Verificar,
    [switch]$SemRegerar
)

if (-not $SemRegerar) {
    & (Join-Path $PSScriptRoot 'GerarIndiceClasses.ps1') | Select-Object -First 4
}

$enc = [Text.Encoding]::GetEncoding(1252)
$idx = @{}
Get-Content $Indice | Where-Object { $_ -like 'C|*' } | ForEach-Object { $idx[$_.Split('|')[1]] = 1 }

$l   = [IO.File]::ReadAllText((Resolve-Path $Menu), $enc) -split "`r`n"
$re  = [regex]'(?i)\bCREATEOBJECT\s*\(\s*"(\w+)"'
$out = New-Object System.Collections.Generic.List[string]
$faltando = @()
for ($i = 0; $i -lt $l.Count; $i++) {
    $t = $l[$i].TrimStart()
    $m = $re.Match($l[$i])
    if ($m.Success -and -not $t.StartsWith('*') -and $idx.ContainsKey($m.Groups[1].Value.ToLower()) -and
        -not ($i -gt 0 -and $l[$i - 1] -match 'GarantirClasse')) {
        $faltando += "$($i + 1): $($m.Groups[1].Value)"
        $out.Add($l[$i].Substring(0, $l[$i].Length - $t.Length) + 'GarantirClasse("' + $m.Groups[1].Value + '")')
    }
    $out.Add($l[$i])
}

if ($Verificar) {
    if ($faltando.Count) { "CREATEOBJECT sem GarantirClasse no menu.prg ($($faltando.Count)):"; $faltando; exit 1 }
    "menu.prg: todo CREATEOBJECT de classe do indice tem GarantirClasse"; exit 0
}
if ($faltando.Count) {
    [IO.File]::WriteAllText((Resolve-Path $Menu), ($out -join "`r`n"), $enc)
    "GarantirClasse inserido em $($faltando.Count) ponto(s) do menu.prg:"; $faltando
} else {
    "menu.prg: nada a inserir"
}
