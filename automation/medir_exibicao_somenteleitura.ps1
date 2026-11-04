<#
.SYNOPSIS
    Mede o impacto de aceitar Test-LegadoSomenteLeitura como prova alternativa
    no ramo EXIBICAO da Fase 8 do OrquestradorMigracao.
.DESCRIPTION
    O ramo EXIBICAO da Fase 8 dispensa os quatro nomes CRUD-canonicos
    (BtnCancelarClick/FormParaBO/BOParaForm/CarregarLista) quando o legado nao
    tem lista, nao tem CRUD e tem TODO campo somente-leitura. Ele consultava
    SO a Test-LegadoDialogoExibicao, que exige ReadOnly = .T. declarado no
    PROPRIO controle; a irma Test-LegadoSomenteLeitura (escrita depois, para o
    ramo VISUALIZADOR) prova o MESMO aceitando tambem "PROCEDURE When ->
    Return .f.", ComboBox Style = 2 e heranca de ReadOnly de Grid/Column.

    Este script conta, nos dumps de tasks\, quantos dumps cada predicado
    aprova e - o que de fato importa - quantos dos que entram apenas pelo
    predicado novo NAO tem lista, porque so esses mudam de ramo (os que tem
    grade continuam no ramo VISUALIZADOR, com CarregarLista obrigatorio).

    NAO faz dot-source do OrquestradorMigracao.ps1 (isso dispara migracao):
    extrai do arquivo apenas o texto das duas funcoes e carrega essa copia.

    Origem: Fase 8 de SIGOPDEN -> Formsigopden (task718, 2026-10-31).
#>
[CmdletBinding()]
param(
    [string]$Orquestrador = "",
    [string]$TasksPath    = 'C:\4c\tasks',
    [switch]$Detalhar
)

# $PSScriptRoot fica VAZIO quando o script roda por "-File" com [CmdletBinding()]
# - resolver pelo proprio caminho invocado.
if ([string]::IsNullOrWhiteSpace($Orquestrador)) {
    $raiz = Split-Path -Parent $MyInvocation.MyCommand.Path
    if ([string]::IsNullOrWhiteSpace($raiz)) { $raiz = "C:\4c\automation" }
    $Orquestrador = Join-Path $raiz "OrquestradorMigracao.ps1"
}

if (-not (Test-Path $Orquestrador)) { throw "Orquestrador nao encontrado: $Orquestrador" }

# Extrai SO as duas funcoes (contagem de chaves), para nao executar o resto.
$linhas = Get-Content $Orquestrador
$buf = New-Object System.Text.StringBuilder
$dentro = $false; $prof = 0
foreach ($l in $linhas) {
    if (-not $dentro -and $l -match '^function\s+(Test-LegadoDialogoExibicao|Test-LegadoSomenteLeitura)\b') {
        $dentro = $true; $prof = 0
    }
    if ($dentro) {
        [void]$buf.AppendLine($l)
        $prof += ([regex]::Matches($l, '\{')).Count
        $prof -= ([regex]::Matches($l, '\}')).Count
        if ($prof -eq 0 -and $l -match '\}') { $dentro = $false }
    }
}
$tmp = Join-Path $env:TEMP ("gatefns_" + [guid]::NewGuid().ToString('N') + ".ps1")
Set-Content -Path $tmp -Value $buf.ToString() -Encoding UTF8
try { . $tmp } finally { Remove-Item $tmp -ErrorAction SilentlyContinue }

$rxLista = '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)'
$tot = 0; $velho = 0; $novo = 0; $trocam = @(); $soNovoComLista = 0

foreach ($d in (Get-ChildItem $TasksPath -Recurse -Filter '*_form_codigo_fonte.txt' -ErrorAction SilentlyContinue)) {
    $t = Get-Content $d.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $t) { continue }
    $tot++
    $a = Test-LegadoDialogoExibicao -TextoDump $t
    $b = Test-LegadoSomenteLeitura  -TextoDump $t
    if ($a)        { $velho++ }
    if ($a -or $b) { $novo++ }
    if ((-not $a) -and $b) {
        $temLista = ($t -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or ($t -match $rxLista)
        if ($temLista) { $soNovoComLista++ } else { $trocam += ($d.Directory.Name + '\' + $d.Name) }
    }
}

Write-Host ""
Write-Host "[EXIBICAO-F8] dumps lidos ............... $tot"
Write-Host "[EXIBICAO-F8] predicado ANTIGO aprova ... $velho"
Write-Host "[EXIBICAO-F8] predicado NOVO   aprova ... $novo"
Write-Host "[EXIBICAO-F8] entram so pelo -or ........ $($soNovoComLista + $trocam.Count)"
Write-Host "[EXIBICAO-F8]   com lista (seguem em VISUALIZADOR, CarregarLista obrigatorio) ... $soNovoComLista"
Write-Host "[EXIBICAO-F8]   SEM lista (REALMENTE mudam de ramo) ......................... $($trocam.Count)"
if ($Detalhar -or $trocam.Count -gt 0) {
    foreach ($x in $trocam) { Write-Host "[EXIBICAO-F8]     -> $x" }
}
Write-Host ""
