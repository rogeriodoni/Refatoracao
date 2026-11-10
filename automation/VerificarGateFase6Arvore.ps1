<#
.SYNOPSIS
    Verifica, SEM executar o OrquestradorMigracao (dot-source dele DISPARA
    migracao), qual ramo do gate da Fase 6 aceita um form OPERACIONAL - e em
    particular se o ramo ARVORE (acrescentado em 2026-11-09, task772/SIGOPNOP)
    eh o unico que aceita, confirmando que nenhum ramo anterior ja cobria o caso.

.DESCRIPTION
    Replica as condicoes do bloco "6 { ... }" de Invoke-MigracaoFase para o par
    (dump legado, form migrado) informado. Serve de prova para o relatorio da
    fase e de deteccao de regressao quando algum ramo do gate for alterado.

.PARAMETER TaskPath
    Pasta da task (onde esta <BaseName>_form_codigo_fonte.txt).

.PARAMETER BaseName
    Nome base do SCX legado (ex.: SIGOPNOP).

.PARAMETER FormFile
    Caminho do .prg migrado.

.PARAMETER FormType
    CRUD | REPORT | OPERACIONAL (default OPERACIONAL).

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File C:\4c\automation\VerificarGateFase6Arvore.ps1 `
        -TaskPath C:\4c\tasks\task772 -BaseName SIGOPNOP `
        -FormFile C:\4c\projeto\app\forms\operacionais\FormSIGOPNOP.prg
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)] [string] $TaskPath,
    [Parameter(Mandatory = $true)] [string] $BaseName,
    [Parameter(Mandatory = $true)] [string] $FormFile,
    [string] $FormType = "OPERACIONAL"
)

if (-not (Test-Path $FormFile)) { Write-Host "Form nao encontrado: $FormFile" -ForegroundColor Red; exit 2 }
$conteudo = Get-Content $FormFile -Raw

$dump = Join-Path $TaskPath "$($BaseName)_form_codigo_fonte.txt"
if (-not (Test-Path $dump)) { Write-Host "Dump nao encontrado: $dump" -ForegroundColor Red; exit 2 }
$txt = Get-Content $dump -Raw

# ---- lado MIGRADO -----------------------------------------------------------
$temPaginaDados  = ($conteudo -match "ConfigurarPaginaDados") -and ($conteudo -match "BINDEVENT")
$semPageFrame    = ($conteudo -notmatch 'AddObject\(\s*"pgf_4c_')
$temBindEvent    = ($conteudo -match "BINDEVENT")
$temMetodoLookup = ($conteudo -match "PROCEDURE\s+(AbrirLookup|AbrirBusca)\w*")
$temValidar      = ($conteudo -match "PROCEDURE\s+Validar\w+")
$temCamposFlat   = ($conteudo -match "\.ControlSource\s*=") -and $temValidar
$nCamposMigrado  = ([regex]::Matches($conteudo, 'AddObject\(\s*"[^"]+"\s*,\s*"TextBox\w*"')).Count
$temArvoreMigr   = ($conteudo -match 'AddObject\(\s*"[^"]+"\s*,\s*"OLEControl"')

# ---- lado LEGADO ------------------------------------------------------------
$padroesLookup = @(
    'fwbusca',
    'mAddColuna',
    'sigacess\s*\(',
    'Acesso(Campos|Contab|Contas|Empresa|Grupos|MovInd|MovMto|Produto|Titulo)\s*\(',
    'FormBuscaAuxiliar'
)
$legadoSemLookup = -not ($padroesLookup | Where-Object { $txt -match $_ })

$semGridLegado   = -not ($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$')
$temOleLegado    = $txt -match '(?im)^\s*BaseClass:\s*olecontrol\s*$'
$temApiNos       = $txt -match '(?i)(AddPictureNode|ClearNodes|NodeCargo|NodeExpanded|NodeLevel|NodeHeader|\.Nodes\.Add)'
$semControlSrc   = -not ($txt -match '(?i)ControlSource')
$nCamposLegado   = ([regex]::Matches($txt, '(?im)^\s*BaseClass:\s*textbox\s*$')).Count
$temCamposLegado = $txt -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$'
$temListaLegado  = ($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                   ($txt -match '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)')

$legadoArvoreSemBind = $semGridLegado -and $temOleLegado -and $temApiNos -and
                       $semControlSrc -and ($nCamposLegado -ge 1)

# ---- ramos ------------------------------------------------------------------
$temLayoutFlat   = ($FormType -eq "OPERACIONAL" -and $semPageFrame -and $temBindEvent -and
                    ($temMetodoLookup -or ($legadoSemLookup -and $temCamposFlat)))
$temLayoutArvore = ($FormType -eq "OPERACIONAL" -and $semPageFrame -and $temBindEvent -and
                    $legadoArvoreSemBind -and $legadoSemLookup -and
                    $temArvoreMigr -and ($nCamposLegado -ge 1) -and ($nCamposMigrado -ge $nCamposLegado) -and
                    ($temMetodoLookup -or $temValidar))

Write-Host "=== GATE FASE 6 - $BaseName -> $(Split-Path $FormFile -Leaf) ($FormType) ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "LADO LEGADO (dump $(Split-Path $dump -Leaf)):"
Write-Host ("  sem Grid/PageFrame .......... {0}" -f $semGridLegado)
Write-Host ("  olecontrol presente ......... {0}" -f $temOleLegado)
Write-Host ("  API de nos (arvore) ......... {0}" -f $temApiNos)
Write-Host ("  ZERO ControlSource .......... {0}" -f $semControlSrc)
Write-Host ("  campos (BaseClass textbox) .. {0}" -f $nCamposLegado)
Write-Host ("  tem campos de entrada ....... {0}" -f $temCamposLegado)
Write-Host ("  tem superficie de lista ..... {0}" -f $temListaLegado)
Write-Host ("  SEM lookup algum ............ {0}" -f $legadoSemLookup)
Write-Host ""
Write-Host "LADO MIGRADO:"
Write-Host ("  sem PageFrame ............... {0}" -f $semPageFrame)
Write-Host ("  BINDEVENT ................... {0}" -f $temBindEvent)
Write-Host ("  OLEControl (arvore) ......... {0}" -f $temArvoreMigr)
Write-Host ("  TextBox criados ............. {0} (piso = {1})" -f $nCamposMigrado, $nCamposLegado)
Write-Host ("  PROCEDURE Validar* .......... {0}" -f $temValidar)
Write-Host ("  PROCEDURE AbrirLookup/Busca*  {0}" -f $temMetodoLookup)
Write-Host ("  .ControlSource = (ramo FLAT)   {0}" -f ($conteudo -match "\.ControlSource\s*="))
Write-Host ""
Write-Host "RAMOS:"
Write-Host ("  PAGINADO .................... {0}" -f $temPaginaDados)
Write-Host ("  FLAT ........................ {0}" -f $temLayoutFlat)
Write-Host ("  ARVORE (novo) ............... {0}" -f $temLayoutArvore)
Write-Host ""

if ($temLayoutArvore -and -not ($temPaginaDados -or $temLayoutFlat)) {
    Write-Host "RESULTADO: APROVADO pelo ramo ARVORE - e por mais nenhum (nenhum ramo anterior cobria o caso)." -ForegroundColor Green
    exit 0
}
if ($temPaginaDados -or $temLayoutFlat) {
    Write-Host "RESULTADO: aprovado por ramo ANTERIOR (PAGINADO/FLAT) - o ramo ARVORE nao era necessario aqui." -ForegroundColor Yellow
    exit 0
}
Write-Host "RESULTADO: REPROVADO - nenhum dos ramos verificados aceita este par." -ForegroundColor Red
exit 1
