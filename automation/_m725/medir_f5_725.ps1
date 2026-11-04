$ErrorActionPreference = 'Stop'
$orq = 'C:\4c\automation\OrquestradorMigracao.ps1'
$tokens=$null;$errs=$null
$ast = [System.Management.Automation.Language.Parser]::ParseFile($orq,[ref]$tokens,[ref]$errs)
Write-Host "Parse errors: $($errs.Count)"
$fns = $ast.FindAll({param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst]},$true)
Write-Host "Funcoes: $($fns.Count)"
foreach($f in $fns){ try { Set-Item -Path "function:global:$($f.Name)" -Value $f.Body.GetScriptBlock() } catch {} }

$dump = 'C:\4c\tasks\task725\sigopdtf_form_codigo_fonte.txt'
$txt  = Get-Content $dump -Raw
$form = 'C:\4c\projeto\app\forms\operacionais\Formsigopdtf.prg'
$cont = Get-Content $form -Raw
$formClass='Formsigopdtf'; $boClass='sigopdtfBO'

# --- GATE FASE 5 ---
$temPaginaDados = ($cont -match "ConfigurarPaginaDados")
$semPageFrame   = ($cont -notmatch 'AddObject\(\s*"pgf_4c_')
$temCampos      = ($cont -match "\.ControlSource\s*=")
$temLayoutFlat  = ($semPageFrame -and $temCampos)
Write-Host "temPaginaDados=$temPaginaDados semPageFrame=$semPageFrame temCampos(ControlSource)=$temCampos temLayoutFlat=$temLayoutFlat"

$temListaEstritaF5 = ($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                     (Test-LegadoListBoxLigaLista -TextoDump $txt) -or
                     (Test-LegadoTokenGradeProprioForm -TextoDump $txt) -or
                     (Test-LegadoAddCursorLigaGrade -TextoDump $txt) -or
                     (Test-LegadoControlSourceLigaLista -TextoDump $txt)
Write-Host "  BaseClass grid|pageframe : $([bool]($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$'))"
Write-Host "  ListBoxLigaLista         : $(Test-LegadoListBoxLigaLista -TextoDump $txt)"
Write-Host "  TokenGradeProprioForm    : $(Test-LegadoTokenGradeProprioForm -TextoDump $txt)"
Write-Host "  AddCursorLigaGrade       : $(Test-LegadoAddCursorLigaGrade -TextoDump $txt)"
Write-Host "  ControlSourceLigaLista   : $(Test-LegadoControlSourceLigaLista -TextoDump $txt)"
Write-Host "temListaEstritaF5=$temListaEstritaF5"

$temCampoCapturaF5  = $txt -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|checkbox|optiongroup|optionbutton|spinner)\s*$'
$temApiNosCapturaF5 = $txt -match '(?i)(AddPictureNode|ClearNodes|NodeCargo|NodeExpanded|NodeLevel|NodeHeader|\.Nodes\.Add)'
$nCamposTbLegadoF5  = ([regex]::Matches($txt,'(?im)^\s*BaseClass:\s*textbox\s*$')).Count
$dlgExib = Test-LegadoDialogoExibicao -TextoDump $txt
$legadoCapturaF5 = (-not $temListaEstritaF5) -and (-not $temApiNosCapturaF5) -and $temCampoCapturaF5 -and (-not $dlgExib)
Write-Host "temCampoCaptura=$temCampoCapturaF5 apiNos=$temApiNosCapturaF5 nTbLegado=$nCamposTbLegadoF5 dialogoExibicao=$dlgExib legadoCapturaF5=$legadoCapturaF5"

$nCamposMigradoF5 = ([regex]::Matches($cont,'AddObject\(\s*"[^"]+"\s*,\s*"TextBox\w*"')).Count
$piso = [math]::Ceiling($nCamposTbLegadoF5/2)
$temSup = ($cont -match "InicializarForm") -and ($nCamposMigradoF5 -ge $piso)
Write-Host "nCamposMigrado=$nCamposMigradoF5 piso=$piso temSuperficieCaptura=$temSup"
$temLayoutCapturaF5 = ($legadoCapturaF5 -and $temSup)
Write-Host ">>> temLayoutCapturaF5=$temLayoutCapturaF5"

$passa = ($temPaginaDados -or $temLayoutFlat -or $temLayoutCapturaF5)
Write-Host ">>> GATE FASE 5 PASSA = $passa"

# --- GUARD NO-OP ---
Write-Host ">>> Test-LegadoSemCampoNemLista = $(Test-LegadoSemCampoNemLista -TextoDump $txt)  (false => guard FORCA retry)"
