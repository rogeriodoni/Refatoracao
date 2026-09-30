# Replica o case 8 do OrquestradorMigracao.ps1 para task608 / FormSIGPREST e
# imprime o VEREDICTO final (metodos faltantes depois de todos os ramos de
# dispensa + exigencia de botao de acao).
#
# NAO dot-source o orquestrador (dispara migracao real) - so as definicoes de
# funcao, via AST.

$src = 'C:\4c\automation\OrquestradorMigracao.ps1'
$ast = [System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$null)
$funcs = $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)
foreach ($f in $funcs) { . ([scriptblock]::Create($f.Extent.Text)) }

$txtLegadoF8 = Get-Content 'C:\4c\tasks\task608\SIGPREST_form_codigo_fonte.txt' -Raw
$conteudo    = Get-Content 'C:\4c\projeto\app\forms\operacionais\FormSIGPREST.prg' -Raw
$FormType    = 'OPERACIONAL'

$metodosFinals    = @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
$metodosFaltantes = @($metodosFinals | Where-Object { $conteudo -notmatch $_ })
"metodosFaltantes ANTES dos ramos : $($metodosFaltantes -join ', ')"

$padroesSalvar   = @('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados')
$legadoSemSalvar = -not ($padroesSalvar | Where-Object { $txtLegadoF8 -match $_ })

$temListaLegadoF8  = ($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                     ($txtLegadoF8 -match '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)')
$temCamposLegadoF8 = ($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
$padroesCrud       = @('frmcadastro','Grupo_Op','(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)','(Incluir|Alterar|Visualizar|Excluir)\.Click')
$semCrudLegadoF8   = -not ($padroesCrud | Where-Object { $txtLegadoF8 -match $_ })

$semGradeEstrita = -not (($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(grid|pageframe|listbox)\s*$') -or
                         (Test-LegadoAddCursorLigaGrade -TextoDump $txtLegadoF8) -or
                         (Test-LegadoControlSourceLigaLista -TextoDump $txtLegadoF8))

$soOpcao         = ($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(checkbox|optiongroup|optionbutton)\s*$') -and
                   (-not ($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|spinner)\s*$'))
$criaTabelaLocal = $txtLegadoF8 -match '(?i)\bCreate\s+Table\s+[A-Za-z_]\w*\s+Free\b'
$varreDiretorio  = ($txtLegadoF8 -match '(?i)\bADir\s*\(') -and ($txtLegadoF8 -match '(?i)\bSet\s+Default\s+To\b')
$escritaSoLocal  = Test-LegadoEscritaSoEmTabelaLocalFree -TextoDump $txtLegadoF8
$temSuperficie   = ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+FormParaBO\b') -and
                   ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+BOParaForm\b') -and
                   ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+Btn\w*Click\b')

"--- provas do ramo UTILITARIO-ARQUIVO ---"
"  semCrudLegadoF8   : $semCrudLegadoF8"
"  semGradeEstrita   : $semGradeEstrita"
"  soOpcao           : $soOpcao"
"  legadoSemSalvar   : $legadoSemSalvar"
"  criaTabelaLocal   : $criaTabelaLocal"
"  varreDiretorio    : $varreDiretorio"
"  escritaSoLocal    : $escritaSoLocal"
"  temSuperficie     : $temSuperficie  (FormParaBO/BOParaForm/Btn*Click ANCORADOS)"

$legadoUtil = $semCrudLegadoF8 -and $semGradeEstrita -and $soOpcao -and $legadoSemSalvar -and
              $criaTabelaLocal -and $varreDiretorio -and $escritaSoLocal -and $temSuperficie
"  => legadoUtilitarioArquivoF8 = $legadoUtil"

if ($legadoUtil) {
    $dispensa = @("BtnCancelarClick", "CarregarLista")
    $metodosFaltantes = @($metodosFaltantes | Where-Object { $dispensa -notcontains $_ })
}
"metodosFaltantes DEPOIS dos ramos: $(if ($metodosFaltantes.Count -eq 0) { '(nenhum)' } else { $metodosFaltantes -join ', ' })"

$padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'
$temAcao = $conteudo -match $padraoAcaoGravar
"exigencia de botao de acao       : $(if ($temAcao) { 'ATENDIDA (BtnOKClick)' } else { 'FALHA' })"

""
if ($metodosFaltantes.Count -eq 0 -and $temAcao) {
    "VEREDICTO FASE 8: PASSA"
} else {
    "VEREDICTO FASE 8: REPROVA"
}
