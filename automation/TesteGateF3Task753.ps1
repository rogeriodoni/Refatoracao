#Requires -Version 5.1
<#
    Extrai o corpo REAL do "case 3" de OrquestradorMigracao.ps1 (o gate da
    Fase 3) e o executa standalone contra o FormSigOpIpB.prg recem-gerado.
    Prova o codigo que roda de verdade, em vez de reimplementar a logica.
    NUNCA dot-source o orquestrador (isso dispararia uma migracao).

    DOIS cuidados que a primeira versao deste harness errou:
      1) o scriptblock tem de ser DOT-SOURCED (". $sb"), nunca invocado com
         "& $sb" - com "&" ele roda em escopo FILHO, o "$validado = $true" do
         gate morre la dentro e TODO caso sai .F.;
      2) a funcao de teste nao pode escrever no pipeline (Write-Output), senao
         as mensagens entram no valor de retorno e o booleano se perde.
#>

$ErrorActionPreference = 'Stop'

function Out-Linha { param([string]$t) [Console]::Out.WriteLine($t) }

$orq    = 'C:\4c\automation\OrquestradorMigracao.ps1'
$linhas = [System.IO.File]::ReadAllLines($orq)

$ini = $null
for ($i = 0; $i -lt $linhas.Count; $i++) {
    if ($linhas[$i] -match '^\s{8}3 \{\s*$') { $ini = $i; break }
}
if ($null -eq $ini) { throw 'Nao encontrei o inicio do case 3' }

$prof = 0
$fim  = $null
for ($i = $ini; $i -lt $linhas.Count; $i++) {
    $prof += ([regex]::Matches($linhas[$i], '\{')).Count
    $prof -= ([regex]::Matches($linhas[$i], '\}')).Count
    if ($prof -le 0 -and $i -gt $ini) { $fim = $i; break }
}
if ($null -eq $fim) { throw 'Nao encontrei o fim do case 3' }

$corpo = ($linhas[($ini + 1)..($fim - 1)]) -join "`r`n"
$sb    = [scriptblock]::Create($corpo)
Out-Linha "Corpo do case 3 extraido: linhas $($ini + 2)..$fim  ($($fim - $ini - 1) linhas)"
Out-Linha ''

# Controle de sanidade do EXTRATOR: o corpo tem de conter as ancoras do gate
foreach ($anc in @('temEstruturaPaginada', 'temEstruturaFlat', 'legadoSemPageFrame', 'validado = $true')) {
    if ($corpo -notlike "*$anc*") { throw "Extrator suspeito: ancora '$anc' ausente no corpo" }
}
Out-Linha 'Extrator conferido: as 4 ancoras do gate estao no corpo extraido.'
Out-Linha ''

$falhas = 0

function Test-Caso {
    param(
        [string]$Nome, [string]$formFile, [string]$FormType, [string]$TaskPath,
        [string]$BaseName, [string]$formClass, [string]$boClass,
        [scriptblock]$Gate, [bool]$Esperado
    )

    $validado = $false
    $msgs = . $Gate *>&1 | ForEach-Object { "$_" }   # DOT-SOURCE: escopo atual

    $ok = ($validado -eq $Esperado)
    Out-Linha ("[{0}] {1,-50} validado={2,-5} esperado={3}" -f `
               $(if ($ok) { 'OK   ' } else { 'FALHA' }), $Nome, $validado, $Esperado)
    foreach ($m in $msgs) { if ($m -match '\S') { Out-Linha ('         | ' + $m.Trim()) } }

    if (-not $ok) { $script:falhas++ }
}

$formReal = 'C:\4c\projeto\app\forms\operacionais\FormSigOpIpB.prg'
$taskReal = 'C:\4c\tasks\task753'
$tmp      = 'C:\4c\automation\_gateF3_tmp'
if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force }
New-Item -ItemType Directory -Path $tmp | Out-Null

# Variante flat: mesmo form, sem o nome ConfigurarPageFrame - forca o gate a
# decidir pelo ramo FLAT (dump + container) em vez do ramo paginado.
$flatSemPgf = Join-Path $tmp 'FormFlatSemPgf.prg'
[System.IO.File]::WriteAllText($flatSemPgf,
    ([System.IO.File]::ReadAllText($formReal) -replace 'ConfigurarPageFrame', 'MontarSuperficie'))

# Variante casca: sem InicializarForm e sem container
[System.IO.File]::WriteAllText((Join-Path $tmp 'FormCasca.prg'),
    "DEFINE CLASS FormSigOpIpB AS FormBase`r`n    Height = 222`r`nENDDEFINE`r`n")

# Variante que INVENTOU uma superficie de paginas (o gate tem de reprovar)
[System.IO.File]::WriteAllText((Join-Path $tmp 'FormComPgf.prg'),
    ([System.IO.File]::ReadAllText($flatSemPgf) -replace 'AddObject\("cnt_4c_Sombra"', 'AddObject("pgf_4c_Paginas"'))

$taskVazia = Join-Path $tmp 'taskSemDump'
New-Item -ItemType Directory -Path $taskVazia | Out-Null

Out-Linha '--- POSITIVOS ---'
Test-Caso -Nome 'REAL FormSigOpIpB (OPERACIONAL)' -formFile $formReal `
    -FormType 'OPERACIONAL' -TaskPath $taskReal -BaseName 'SigOpIpB' `
    -formClass 'FormSigOpIpB' -boClass 'SigOpIpBBO' -Gate $sb -Esperado $true

Test-Caso -Nome 'ramo FLAT (dump presente, sem ConfigPageFrame)' -formFile $flatSemPgf `
    -FormType 'OPERACIONAL' -TaskPath $taskReal -BaseName 'SigOpIpB' `
    -formClass 'FormSigOpIpB' -boClass 'SigOpIpBBO' -Gate $sb -Esperado $true

Out-Linha ''
Out-Linha '--- NEGATIVOS (o gate TEM de reprovar) ---'
Test-Caso -Nome 'form inexistente' -formFile (Join-Path $tmp 'NaoExiste.prg') `
    -FormType 'OPERACIONAL' -TaskPath $taskReal -BaseName 'SigOpIpB' `
    -formClass 'FormSigOpIpB' -boClass 'SigOpIpBBO' -Gate $sb -Esperado $false

Test-Caso -Nome 'form casca (sem InicializarForm)' -formFile (Join-Path $tmp 'FormCasca.prg') `
    -FormType 'OPERACIONAL' -TaskPath $taskReal -BaseName 'SigOpIpB' `
    -formClass 'FormSigOpIpB' -boClass 'SigOpIpBBO' -Gate $sb -Esperado $false

Test-Caso -Nome 'fail-closed: dump ausente + sem ConfigPageFrame' -formFile $flatSemPgf `
    -FormType 'OPERACIONAL' -TaskPath $taskVazia -BaseName 'SigOpIpB' `
    -formClass 'FormSigOpIpB' -boClass 'SigOpIpBBO' -Gate $sb -Esperado $false

Test-Caso -Nome 'inventou superficie de paginas' -formFile (Join-Path $tmp 'FormComPgf.prg') `
    -FormType 'OPERACIONAL' -TaskPath $taskReal -BaseName 'SigOpIpB' `
    -formClass 'FormSigOpIpB' -boClass 'SigOpIpBBO' -Gate $sb -Esperado $false

Remove-Item $tmp -Recurse -Force
Out-Linha ''
if ($falhas -eq 0) { Out-Linha 'RESULTADO: TODOS OS 6 CASOS OK' }
else { Out-Linha "RESULTADO: $falhas CASO(S) COM FALHA" }
exit $falhas
