# =============================================================================
# VerificarMetodoProtegidoChamadoDeFora.ps1 - Auditoria do Erro199 (regra #51)
#
# Acusa form que chama de FORA um metodo PROTECTED/HIDDEN do BO:
#     THIS.this_oBusinessObject.ValidarDados()   && compila limpo; ao gravar:
#     "Property VALIDARDADOS is not found."
#
# Medido no VFP9: o PROTECTED vale para a cadeia INTEIRA - declarado na
# BusinessBase, prevalece sobre o override sem modificador do BO; declarado no
# BO, bloqueia igual. Por isso a checagem sobe a heranca (DEFINE CLASS X AS Y)
# ate a raiz, e nao olha so o arquivo do BO.
#
# Variavel -> classe vem de <var> = CREATEOBJECT("<Classe>") no proprio form.
# BO criado por nome em variavel (CREATEOBJECT(loc_cClasse)) nao eh resolvido.
#
# Uso:  powershell -ExecutionPolicy Bypass -File automation\VerificarMetodoProtegidoChamadoDeFora.ps1
# Exit: 0 sem pendencia, 1 com pendencia.
# Origem: Erro199 (2026-10-12) - 48 sites em 29 forms. Skill: secao 246.
# =============================================================================
param()

$RaizRepo4c = Split-Path -Parent $PSScriptRoot
$app = Join-Path $RaizRepo4c 'projeto\app'

$classes = @{}
foreach ($arq in Get-ChildItem (Join-Path $app 'classes'), (Join-Path $app 'forms') -Recurse -Filter *.prg) {
    $txt = Get-Content $arq.FullName -Raw
    foreach ($m in [regex]::Matches($txt, '(?ims)^\s*DEFINE\s+CLASS\s+(\w+)\s+AS\s+(\w+)(.*?)^\s*ENDDEFINE')) {
        $nome = $m.Groups[1].Value.ToLower()
        $pai  = $m.Groups[2].Value.ToLower()
        $prot = @([regex]::Matches($m.Groups[3].Value, '(?im)^\s*(?:PROTECTED|HIDDEN)\s+(?:PROCEDURE|FUNCTION)\s+(\w+)') |
                  ForEach-Object { $_.Groups[1].Value.ToLower() })
        $classes[$nome] = @{ pai = $pai; prot = $prot; arquivo = $arq.FullName }
    }
}

function Get-ClasseQueProtege([string]$Classe, [string]$Metodo) {
    $c = $Classe; $n = 0
    while ($c -and $classes.ContainsKey($c) -and $n -lt 15) {
        if ($classes[$c].prot -contains $Metodo) { return $c }
        $c = $classes[$c].pai; $n++
    }
    return $null
}

$achados = @()
foreach ($arq in Get-ChildItem (Join-Path $app 'forms') -Recurse -Filter *.prg) {
    $linhas = Get-Content $arq.FullName
    $mapa = @{}
    foreach ($l in $linhas) {
        if ($l -match '^\s*(\*|&&)') { continue }
        foreach ($m in [regex]::Matches($l, '(?i)([A-Za-z0-9_\.]+)\s*=\s*CREATEOBJECT\(\s*["'']([A-Za-z0-9_]+)["'']')) {
            $cls = $m.Groups[2].Value.ToLower()
            if ($classes.ContainsKey($cls) -and $classes[$cls].arquivo -match '(?i)\\classes\\') {
                $mapa[($m.Groups[1].Value -replace '^(?i)THIS(FORM)?\.', '').ToLower()] = $cls
            }
        }
    }
    if ($mapa.Count -eq 0) { continue }
    for ($i = 0; $i -lt $linhas.Count; $i++) {
        if ($linhas[$i] -match '^\s*(\*|&&)') { continue }
        foreach ($m in [regex]::Matches($linhas[$i], '(?i)(?:THIS(?:FORM)?\.)?([A-Za-z0-9_]+)\.([A-Za-z0-9_]+)\s*\(')) {
            $var = $m.Groups[1].Value.ToLower()
            $met = $m.Groups[2].Value.ToLower()
            if (-not $mapa.ContainsKey($var)) { continue }
            $quem = Get-ClasseQueProtege $mapa[$var] $met
            if ($quem) {
                $achados += [PSCustomObject]@{
                    Site = "$($arq.Name):$($i + 1)"; Chamada = "$var.$met()"; ClasseBO = $mapa[$var]; ProtegidoEm = $quem
                }
            }
        }
    }
}

if ($achados.Count -eq 0) {
    Write-Host "OK - nenhum form chama metodo PROTECTED de BO." -ForegroundColor Green
    exit 0
}
$achados | Sort-Object Site | Format-Table -AutoSize | Out-String -Width 220 | Write-Host
Write-Host "ERRO=$($achados.Count) em $(@($achados | ForEach-Object { ($_.Site -split ':')[0] } | Sort-Object -Unique).Count) forms" -ForegroundColor Red
Write-Host "Conserto: tirar PROTECTED da declaracao (no BO e, se for o caso, na BusinessBase); ExecutarExclusao -> Excluir()." -ForegroundColor Yellow
exit 1
