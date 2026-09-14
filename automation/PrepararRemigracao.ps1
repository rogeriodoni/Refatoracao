#==============================================================================
# PrepararRemigracao.ps1
#
# PROPOSITO: Prepara o ambiente para re-migração completa
#            1. Copia arquivos SCX/SCT únicos das tasks para pasta origem
#            2. Limpa tasks antigas
#            3. Limpa forms/BOs gerados
#
# USO:
#   .\PrepararRemigracao.ps1
#   .\PrepararRemigracao.ps1 -ApenasListar
#
# AUTOR: Sistema de Migracao Automatizada
# DATA: 2026-02-05
#==============================================================================

param(
    [switch]$ApenasListar,
    [switch]$ManterTasks,      # Não limpa tasks antigas
    [switch]$ManterForms       # Não limpa forms gerados
)

$ErrorActionPreference = "Stop"

$tasksPath = "C:\4c\tasks"
$origemPath = "C:\4c\origem"
$formsPath = "C:\4c\projeto\app\forms\cadastros"
$classesPath = "C:\4c\projeto\app\classes"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  PREPARAR REMIGRACAO COMPLETA" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

#------------------------------------------------------------------------------
# 1. Identifica arquivos SCX únicos nas tasks
#------------------------------------------------------------------------------

Write-Host "1. Identificando arquivos SCX unicos..." -ForegroundColor Yellow

$scxFiles = Get-ChildItem -Path $tasksPath -Recurse -Filter "*.scx" -ErrorAction SilentlyContinue

# Agrupa por nome base (para pegar apenas um de cada)
$scxUnicos = @{}
foreach ($scx in $scxFiles) {
    $baseName = $scx.BaseName.ToUpper()
    if (-not $scxUnicos.ContainsKey($baseName)) {
        $scxUnicos[$baseName] = $scx
    }
}

Write-Host "  Encontrados $($scxUnicos.Count) formularios unicos:" -ForegroundColor White

foreach ($key in $scxUnicos.Keys | Sort-Object) {
    $scx = $scxUnicos[$key]
    $sct = Join-Path $scx.DirectoryName ($scx.BaseName + ".sct")
    $temSct = Test-Path $sct
    $status = if ($temSct) { "[OK]" } else { "[SEM SCT]" }
    Write-Host "    $($scx.BaseName) $status" -ForegroundColor $(if ($temSct) { "Green" } else { "Yellow" })
}

Write-Host ""

if ($ApenasListar) {
    Write-Host "Modo -ApenasListar: nenhuma acao executada." -ForegroundColor Yellow
    exit 0
}

#------------------------------------------------------------------------------
# 2. Cria pasta origem se não existir
#------------------------------------------------------------------------------

if (-not (Test-Path $origemPath)) {
    New-Item -ItemType Directory -Path $origemPath -Force | Out-Null
    Write-Host "  Pasta origem criada: $origemPath" -ForegroundColor Green
}

#------------------------------------------------------------------------------
# 3. Copia arquivos SCX/SCT para origem
#------------------------------------------------------------------------------

Write-Host "2. Copiando arquivos para pasta origem..." -ForegroundColor Yellow

$copiados = 0
foreach ($key in $scxUnicos.Keys | Sort-Object) {
    $scx = $scxUnicos[$key]
    $sct = Join-Path $scx.DirectoryName ($scx.BaseName + ".sct")

    $destScx = Join-Path $origemPath $scx.Name
    $destSct = Join-Path $origemPath ($scx.BaseName + ".sct")

    # Copia SCX
    Copy-Item -Path $scx.FullName -Destination $destScx -Force
    Write-Host "  Copiado: $($scx.Name)" -ForegroundColor Green
    $copiados++

    # Copia SCT se existir
    if (Test-Path $sct) {
        Copy-Item -Path $sct -Destination $destSct -Force
        Write-Host "  Copiado: $($scx.BaseName).sct" -ForegroundColor Green
    }
}

Write-Host "  Total copiados: $copiados arquivos SCX" -ForegroundColor White
Write-Host ""

#------------------------------------------------------------------------------
# 4. Limpa tasks antigas (opcional)
#------------------------------------------------------------------------------

if (-not $ManterTasks) {
    Write-Host "3. Limpando tasks antigas..." -ForegroundColor Yellow

    $taskFolders = Get-ChildItem -Path $tasksPath -Directory -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -match '^task\d+$' }

    foreach ($folder in $taskFolders) {
        Remove-Item -Path $folder.FullName -Recurse -Force
        Write-Host "  Removida: $($folder.Name)" -ForegroundColor Gray
    }

    Write-Host "  Tasks antigas removidas: $($taskFolders.Count)" -ForegroundColor White
}
else {
    Write-Host "3. Mantendo tasks antigas (flag -ManterTasks)" -ForegroundColor Yellow
}

Write-Host ""

#------------------------------------------------------------------------------
# 5. Limpa forms gerados (opcional)
#------------------------------------------------------------------------------

if (-not $ManterForms) {
    Write-Host "4. Limpando forms e BOs gerados..." -ForegroundColor Yellow

    # Forms a manter (base do framework)
    $formsBase = @("FormBase.prg")

    # BOs a manter (base do framework)
    $bosBase = @("BusinessBase.prg", "DataAccess.prg", "FormBase.prg", "GridBase.prg",
                 "FormBuscaAuxiliar.prg", "FormErro.prg", "TextBoxGridLookup.prg")

    # Remove forms gerados
    $formsRemovidos = 0
    $formFiles = Get-ChildItem -Path $formsPath -Filter "*.prg" -ErrorAction SilentlyContinue
    foreach ($file in $formFiles) {
        if ($file.Name -notin $formsBase -and $file.Name -notlike "Test*.prg" -and $file.Name -notlike "Runner*.prg") {
            Remove-Item -Path $file.FullName -Force
            Write-Host "  Removido: forms\$($file.Name)" -ForegroundColor Gray
            $formsRemovidos++
        }
    }

    # Remove BOs gerados (arquivos que terminam com BO.prg)
    $bosRemovidos = 0
    $boFiles = Get-ChildItem -Path $classesPath -Filter "*BO.prg" -ErrorAction SilentlyContinue
    foreach ($file in $boFiles) {
        if ($file.Name -notin $bosBase) {
            Remove-Item -Path $file.FullName -Force
            Write-Host "  Removido: classes\$($file.Name)" -ForegroundColor Gray
            $bosRemovidos++
        }
    }

    Write-Host "  Forms removidos: $formsRemovidos" -ForegroundColor White
    Write-Host "  BOs removidos: $bosRemovidos" -ForegroundColor White
}
else {
    Write-Host "4. Mantendo forms gerados (flag -ManterForms)" -ForegroundColor Yellow
}

Write-Host ""

#------------------------------------------------------------------------------
# 6. Limpa FXP
#------------------------------------------------------------------------------

Write-Host "5. Limpando arquivos .FXP..." -ForegroundColor Yellow
$fxpCount = (Get-ChildItem -Path "C:\4c\projeto\app" -Recurse -Filter "*.fxp" -ErrorAction SilentlyContinue).Count
Get-ChildItem -Path "C:\4c\projeto\app" -Recurse -Filter "*.fxp" -ErrorAction SilentlyContinue | Remove-Item -Force
Get-ChildItem -Path "C:\4c\projeto\app" -Recurse -Filter "*.FXP" -ErrorAction SilentlyContinue | Remove-Item -Force
Write-Host "  FXP limpos: $fxpCount arquivos" -ForegroundColor White
Write-Host ""

#------------------------------------------------------------------------------
# Resumo
#------------------------------------------------------------------------------

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  RESUMO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Arquivos SCX copiados para origem: $copiados" -ForegroundColor Green
Write-Host "  Pasta origem: $origemPath" -ForegroundColor White
Write-Host ""
Write-Host "PROXIMO PASSO:" -ForegroundColor Yellow
Write-Host "  Execute: .\OrquestradorMigracao.ps1 -ProcessAll" -ForegroundColor White
Write-Host ""
Write-Host "Concluido!" -ForegroundColor Green
