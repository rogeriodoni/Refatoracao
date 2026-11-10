# MedirImpactoExtensaoEhFilho.ps1
#
# Mede o impacto de acrescentar "Set DataSession to <param>.DataSessionId"
# como terceira prova de "dialogo FILHO" em Test-LegadoCopiadorFilho (usada
# pelos ramos COPIADOR-FILHO e IMPRESSAO-FILHO da Fase 8), comparando o
# veredito do bloco `case 8` ANTES e DEPOIS da extensao, para todo par
# dump+form migrado que usa esse idioma no legado.
#
# AST-only: dot-source do orquestrador DISPARA uma migracao real.

$ErrorActionPreference = 'Stop'
$Orquestrador = 'C:\4c\automation\OrquestradorMigracao.ps1'
$LinhaInicio = 10542
$LinhaFim    = 12891

$ast = [System.Management.Automation.Language.Parser]::ParseFile($Orquestrador, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

$linhas = Get-Content $Orquestrador
$bloco  = $linhas[($LinhaInicio - 1)..($LinhaFim - 1)]
$corpo  = ($bloco[1..($bloco.Count - 2)] -join "`r`n")

# Casos: (TaskPath, BaseName, FormFile)
$casos = @(
    @{T='task089'; B='SigReEqT'; F='projeto\app\forms\relatorios\FormSigReEqT.prg'},
    @{T='task139'; B='SigPdM14'; F='projeto\app\forms\operacionais\FormSigPdM14.prg'},
    @{T='task149'; B='SigPdMp8'; F='projeto\app\forms\operacionais\FormSigPdMp8.prg'},
    @{T='task585'; B='SigPrCar'; F='projeto\app\forms\operacionais\FormSigPrCar.prg'},
    @{T='task676'; B='SigPrSer'; F='projeto\app\forms\operacionais\FormSigPrSer.prg'},
    @{T='task681'; B='SigPrTar'; F='projeto\app\forms\operacionais\FormSigPrTar.prg'},
    @{T='task648'; B='SIGOPBOL'; F='projeto\app\forms\operacionais\FormSIGOPBOL.prg'},
    @{T='task742'; B='sigopfis'; F='projeto\app\forms\operacionais\Formsigopfis.prg'},
    @{T='task746'; B='SigOpIbo'; F='projeto\app\forms\operacionais\FormSigOpIbo.prg'}
)

function Invoke-Case8 {
    param($TaskPath, $BaseName, $FormFile, $FormType = 'OPERACIONAL')
    $formClass = "Form$BaseName"
    $boClass   = "${BaseName}BO"
    $validado = $false
    . ([scriptblock]::Create($corpo))
    [PSCustomObject]@{
        BaseName  = $BaseName
        Validado  = $validado
        Faltantes = ($metodosFaltantes -join ',')
        CopiadorFilho = (Get-Variable -Name legadoCopiadorFilhoF8 -ValueOnly -ErrorAction SilentlyContinue)
        ImpressaoFilho = (Get-Variable -Name legadoImpressaoFilhoF8 -ValueOnly -ErrorAction SilentlyContinue)
    }
}

"=== ANTES (Test-LegadoCopiadorFilho original) ==="
$antes = foreach ($c in $casos) {
    $TaskPath = Join-Path 'C:\4c' $c.T
    $formFile = Join-Path 'C:\4c' $c.F
    if (-not (Test-Path $formFile)) { continue }
    Invoke-Case8 -TaskPath $TaskPath -BaseName $c.B -FormFile $formFile
}
$antes | Format-Table -AutoSize | Out-String | Write-Output

# --- patch: redefine Test-LegadoCopiadorFilho com a 3a prova ---
function Test-LegadoCopiadorFilho {
    param([string]$TextoDump, [switch]$SemPersistencia)
    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }
    $vivas = ($TextoDump -split "`r?`n") | Where-Object { $_.Trim() -ne '' -and $_.Trim() -notmatch '^\*' -and $_.Trim() -notmatch '^&&' }
    $txtVivo = ($vivas -join "`n")
    if ([string]::IsNullOrWhiteSpace($txtVivo)) { return $false }

    $ehFilho = $false
    foreach ($m in [regex]::Matches($txtVivo, '(?im)^\s*(?:LParameters|Parameters)\b([^\r\n]*)$')) {
        foreach ($bruto in ($m.Groups[1].Value -split ',')) {
            $nome = $bruto.Trim()
            if ($nome -notmatch '^[A-Za-z_]\w*$') { continue }
            $esc = [regex]::Escape($nome)
            if (($txtVivo -match "(?im)^\s*ThisForm\s*\.\s*ParentForm\s*=\s*$esc\s*$") -or
                ($txtVivo -match "(?im)^\s*ThisForm\s*\.\s*DataSessionId\s*=\s*$esc\s*\.\s*DataSessionId\s*$") -or
                ($txtVivo -match "(?im)^\s*Set\s+DataSession\s+to\s+$esc\s*\.\s*DataSessionId\s*$")) {
                $ehFilho = $true
                break
            }
        }
        if ($ehFilho) { break }
    }
    if (-not $ehFilho) { return $false }

    if ((Get-ContagemBotoesLegado -TextoDump $TextoDump) -ne 2) { return $false }

    $temBotaoQueSoFecha = $false
    $blocos = [regex]::Matches($TextoDump, '(?ims)^PROCEDURE[^\S\r\n]+[\w\.]*Click[^\S\r\n]*\r?$(.*?)^ENDPROC[^\S\r\n]*\r?$')
    foreach ($bloco in $blocos) {
        $linhas2 = ($bloco.Groups[1].Value -split "`r?`n") | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' -and $_ -notmatch '^\*' -and $_ -notmatch '^&&' }
        if ($linhas2.Count -eq 0) { continue }
        $soFecha = $true
        foreach ($linha in $linhas2) {
            if ($linha -notmatch '(?i)^(=?\s*(ThisForm|Thisform|Form)\s*\.\s*Release\s*\(?\s*\)?|Release\s+Windows?\b|Release\s+ThisForm\b)') {
                $soFecha = $false
                break
            }
        }
        if ($soFecha) { $temBotaoQueSoFecha = $true; break }
    }
    if (-not $temBotaoQueSoFecha) { return $false }

    $persiste = ($txtVivo -match '(?i)\.\s*UpDate\s*\(') -or ($txtVivo -match '(?i)\bTableUpdate\s*\(') -or ($txtVivo -match '(?i)\.\s*Commit\s*\(')

    if ($SemPersistencia) {
        if ($persiste) { return $false }
        $escreveLinha = ($txtVivo -match '(?im)^\s*Insert\s+Into\s+[A-Za-z_]\w*') -or ($txtVivo -match '(?im)^\s*Append\s+(Blank|From)\b') -or ($txtVivo -match '(?i)\bReplace\b[^\r\n]*\bWith\b')
        if (-not $escreveLinha) { return $false }
        return $true
    }

    if (-not $persiste) { return $false }
    return $true
}

"=== DEPOIS (com 'Set DataSession to X.DataSessionId') ==="
$depois = foreach ($c in $casos) {
    $TaskPath = Join-Path 'C:\4c' $c.T
    $formFile = Join-Path 'C:\4c' $c.F
    if (-not (Test-Path $formFile)) { continue }
    Invoke-Case8 -TaskPath $TaskPath -BaseName $c.B -FormFile $formFile
}
$depois | Format-Table -AutoSize | Out-String | Write-Output

"=== DIFF (Validado) ==="
for ($i = 0; $i -lt $antes.Count; $i++) {
    if ($antes[$i].Validado -ne $depois[$i].Validado) {
        "{0}: ANTES={1} DEPOIS={2}" -f $antes[$i].BaseName, $antes[$i].Validado, $depois[$i].Validado
    }
}
"(sem diferenca acima = nenhuma mudanca de veredito)"
