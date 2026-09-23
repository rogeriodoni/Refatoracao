<#
===============================================================================
 VerificarPropriedadesInexistentes.ps1

 Acusa atribuicao a propriedade que a CLASSE BASE do controle NAO TEM.

 MOTIVO (Erro170, 2026-09-23):
   `.ForeColor = RGB(255,0,0)` dentro de um `WITH <OptionGroup>` COMPILA LIMPO
   e so estoura em RUNTIME, no Init do form:
       "Erro ao inicializar Formgpr: Linha 1066 - Property FORECOLOR is not found."
   O usuario clica no menu e a tela nao abre. Medido no VFP9:
       OptionGroup  ForeColor NAO   BackColor SIM
       CommandGroup ForeColor NAO   BackColor SIM
       PageFrame    ForeColor NAO   BackColor NAO   BackStyle NAO
       Container/Label/CommandButton/OptionButton/Grid/Column/Header/Page: tem ambas
   A cor dos radios/botoes mora nos MEMBROS (Buttons(N)), nunca no grupo - que eh
   exatamente como o SCX legado declara (`Option1.ForeColor = 255,0,0`).

 A lista de propriedades validas NAO eh chutada: vem de
   automation\propriedades_baseclasses.txt, gerado pelo proprio VFP9 via
   AMEMBERS() em automation\DumpPropriedadesBaseClasses.prg.
   Sem esse arquivo o script AVISA e sai com 0 (nao inventa defeito).

 Uso:
   .\VerificarPropriedadesInexistentes.ps1                 # todo projeto\app
   .\VerificarPropriedadesInexistentes.ps1 -Caminho <.prg> # um arquivo

 Exit code: 1 se houver achado, 0 caso contrario.
===============================================================================
#>
[CmdletBinding()]
param(
    [string] $Caminho = 'C:\4c\projeto\app',
    [string] $TabelaPropriedades = (Join-Path $PSScriptRoot 'propriedades_baseclasses.txt')
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $TabelaPropriedades)) {
    Write-Host "[PROP-INEXISTENTE] tabela de propriedades ausente: $TabelaPropriedades" -ForegroundColor Yellow
    Write-Host "  Gere com: vfp9.exe automation\DumpPropriedadesBaseClasses.prg" -ForegroundColor Yellow
    Write-Host "  (sem ela o script NAO adivinha a lista - saindo sem acusar nada)" -ForegroundColor Yellow
    exit 0
}

# CLASSE -> HashSet de propriedades validas (UPPER)
$props = @{}
foreach ($linha in (Get-Content $TabelaPropriedades)) {
    if ($linha -notmatch '^([A-Z]+)\|(.*)$') { continue }
    $cls = $matches[1]; $lista = $matches[2]
    if ($lista -like '*<<ERRO*') {
        Write-Host "[PROP-INEXISTENTE] classe $cls nao pode ser dumpada - sera ignorada" -ForegroundColor Yellow
        continue
    }
    $set = New-Object 'System.Collections.Generic.HashSet[string]'
    foreach ($p in ($lista -split ',')) { if ($p) { [void]$set.Add($p.Trim()) } }
    $props[$cls] = $set
}

if ($props.Count -eq 0) {
    Write-Host "[PROP-INEXISTENTE] tabela vazia - saindo sem acusar nada" -ForegroundColor Yellow
    exit 0
}

$arquivos = @()
if (Test-Path $Caminho -PathType Leaf) {
    $arquivos = @(Get-Item $Caminho)
} else {
    $arquivos = Get-ChildItem -Path $Caminho -Filter '*.prg' -Recurse |
                Where-Object { $_.FullName -notmatch 'backup' -and $_.Name -notmatch '\.bak$' }
}

$achados = @()

foreach ($f in $arquivos) {
    $linhas = Get-Content $f.FullName

    # mapa nome do objeto -> classe base, a partir de AddObject("nome", "Classe").
    # Nome reaproveitado para classes diferentes vira <<AMBIGUO>> e NAO eh checado
    # (mesmo risco de colisao de nome da regra #11 do CLAUDE.md).
    $map = @{}
    foreach ($l in $linhas) {
        if ($l -match '(?i)AddObject\s*\(\s*"([^"]+)"\s*,\s*"([^"]+)"') {
            $n = $matches[1]; $c = $matches[2].ToUpper()
            if ($map.ContainsKey($n) -and $map[$n] -ne $c) { $map[$n] = '<<AMBIGUO>>' } else { $map[$n] = $c }
        }
    }
    if ($map.Count -eq 0) { continue }

    # pilha de WITH: cada nivel guarda a classe resolvida (ou $null quando nao da para saber)
    $stack = New-Object System.Collections.ArrayList

    for ($i = 0; $i -lt $linhas.Count; $i++) {
        $t = $linhas[$i].Trim()
        if ($t -eq '' -or $t.StartsWith('*') -or $t.StartsWith('&&')) { continue }

        if ($t -match '(?i)^WITH\s+(.+?)(\s*&&.*)?$') {
            $expr = $matches[1].Trim()
            $cls  = $null
            # membro interno de grupo: .Buttons(N) -> nao da para saber se eh Option ou Command
            if ($expr -notmatch '(?i)\.(Buttons|Pages|Columns|Controls|Objects)\s*\(' -and
                $expr -match '([A-Za-z0-9_]+)\s*$') {
                $ultimo = $matches[1]
                if ($map.ContainsKey($ultimo) -and $map[$ultimo] -ne '<<AMBIGUO>>') { $cls = $map[$ultimo] }
            }
            [void]$stack.Add($cls)
            continue
        }

        if ($t -match '(?i)^ENDWITH\b') {
            if ($stack.Count -gt 0) { $stack.RemoveAt($stack.Count - 1) }
            continue
        }

        $cls = if ($stack.Count -gt 0) { $stack[$stack.Count - 1] } else { $null }

        # atribuicao dentro de WITH:  .Prop = ...
        if ($cls -and $t -match '^\.([A-Za-z_][A-Za-z0-9_]*)\s*=[^=]') {
            $prop = $matches[1].ToUpper()
            if ($props.ContainsKey($cls) -and -not $props[$cls].Contains($prop)) {
                $achados += [pscustomobject]@{
                    Arquivo = $f.FullName; Linha = $i + 1; Classe = $cls; Prop = $prop; Texto = $t
                }
            }
            continue
        }

        # atribuicao direta:  obj.Prop = ...
        if ($t -match '^([A-Za-z_][A-Za-z0-9_]*)\.([A-Za-z_][A-Za-z0-9_]*)\s*=[^=]') {
            $obj = $matches[1]; $prop = $matches[2].ToUpper()
            if ($map.ContainsKey($obj) -and $map[$obj] -ne '<<AMBIGUO>>') {
                $c2 = $map[$obj]
                if ($props.ContainsKey($c2) -and -not $props[$c2].Contains($prop)) {
                    $achados += [pscustomobject]@{
                        Arquivo = $f.FullName; Linha = $i + 1; Classe = $c2; Prop = $prop; Texto = $t
                    }
                }
            }
        }
    }
}

if ($achados.Count -eq 0) {
    Write-Host "[PROP-INEXISTENTE] OK - nenhuma atribuicao a propriedade inexistente" -ForegroundColor Green
    exit 0
}

Write-Host "[PROP-INEXISTENTE] $($achados.Count) atribuicao(oes) a propriedade que a classe NAO TEM:" -ForegroundColor Red
foreach ($a in $achados) {
    Write-Host ("  {0}:{1}  [{2}] nao tem .{3}   ->  {4}" -f `
        (Split-Path $a.Arquivo -Leaf), $a.Linha, $a.Classe, $a.Prop, $a.Texto) -ForegroundColor Red
}
Write-Host ""
Write-Host "Isto COMPILA LIMPO e estoura em RUNTIME no Init do form - a tela nao abre." -ForegroundColor Red
Write-Host "Para cor de grupo (OptionGroup/CommandGroup), a propriedade mora nos MEMBROS:" -ForegroundColor Yellow
Write-Host "  WITH .Buttons(1) / WITH .Buttons(2) - como o SCX legado declara (Option1.ForeColor)." -ForegroundColor Yellow
exit 1
