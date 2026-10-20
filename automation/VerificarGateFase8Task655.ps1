# VerificarGateFase8Task655.ps1
#
# Reproduz o case 8 do OrquestradorMigracao.ps1 SEM executar a migracao, para
# SIGOPCCJ -> FormSigOpCcj (task655, "Procura de Contas por Conjuge"), e mostra
# predicado por predicado:
#   1) quais dos 4 nomes CRUD-canonicos faltam (com o -match solto do gate E
#      com definicao ANCORADA, criterio mais duro);
#   2) que NENHUM dos 12 ramos de excecao existentes alcanca este layout;
#   3) que o bloqueio restante eh so a dupla BtnCancelarClick/CarregarLista -
#      a exigencia de BOTAO DE ACAO ja esta satisfeita (BtnConfirmarClick).
#
# AST-only de proposito: dot-source do orquestrador DISPARA uma migracao real.
$src = 'C:\4c\automation\OrquestradorMigracao.ps1'
$e = $null
[System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$e) | Out-Null
if ($e -and $e.Count -gt 0) { "SINTAXE=FALHA"; $e[0]; exit 1 }
"SINTAXE=OK"
$ast = [System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

$txtLegadoF8 = Get-Content 'C:\4c\tasks\task655\SigOpCcj_form_codigo_fonte.txt' -Raw
$conteudo    = Get-Content 'C:\4c\projeto\app\forms\operacionais\FormSigOpCcj.prg' -Raw
$padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'

# ---- (1) os 4 nomes canonicos
$metodosFinals = @("BtnCancelarClick","FormParaBO","BOParaForm","CarregarLista")
$faltantes     = @($metodosFinals | Where-Object { $conteudo -notmatch $_ })
"faltantes(-match solto, como o gate) = [{0}]" -f ($faltantes -join ', ')
foreach ($m in $metodosFinals) {
    $anc = $conteudo -match ('(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+' + $m + '\b')
    "  {0,-18} definicao ancorada = {1}" -f $m, $anc
}

# ---- (2) predicados compartilhados
$padroesSalvarLegado = @('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados')
$legadoSemSalvar = -not ($padroesSalvarLegado | Where-Object { $txtLegadoF8 -match $_ })

$temListaLegadoF8 = ($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                    ($txtLegadoF8 -match '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)')
$temCamposLegadoF8 = ($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
$padroesCrudLegadoF8 = @('frmcadastro','Grupo_Op','(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)','(Incluir|Alterar|Visualizar|Excluir)\.Click')
$semCrudLegadoF8 = -not ($padroesCrudLegadoF8 | Where-Object { $txtLegadoF8 -match $_ })
$nPcEscolhaTotalF8 = ([regex]::Matches($txtLegadoF8, '(?i)pcEscolha')).Count

$semGradeEstritaF8 = -not (($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                           (Test-LegadoListBoxLigaLista -TextoDump $txtLegadoF8) -or
                           ($txtLegadoF8 -match '(?i)(pColuna|\bGrade\b|\bgrd)') -or
                           (Test-LegadoAddCursorLigaGrade -TextoDump $txtLegadoF8) -or
                           (Test-LegadoControlSourceLigaLista -TextoDump $txtLegadoF8))
$semPageFrameLegadoF8 = -not ($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*pageframe\s*$')
$temDllExternaF8      = $txtLegadoF8 -match '(?im)^\s*DECLARE\s+.*\bIN\s+"[^"]+\.(DLL|OCX|EXE)"'
$temDoFormF8          = $txtLegadoF8 -match '(?im)^\s*Do\s+Form\s+\w+'
$temOleF8             = $txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(olecontrol|oleboundcontrol)\s*$'
$nBotoesF8            = Get-ContagemBotoesLegado  -TextoDump $txtLegadoF8
$cliqueSoFechaF8      = Test-LegadoCliqueSoFecha  -TextoDump $txtLegadoF8
$somenteLeituraF8     = Test-LegadoSomenteLeitura -TextoDump $txtLegadoF8
$escritaSoCursorF8    = Test-LegadoEscritaSoEmCursorLocal -TextoDump $txtLegadoF8

"legadoSemSalvar          = $legadoSemSalvar"
"temListaLegado (largo)   = $temListaLegadoF8"
"semGradeEstrita          = $semGradeEstritaF8"
"temCamposLegado          = $temCamposLegadoF8"
"semCrudLegado            = $semCrudLegadoF8   (pcEscolha ocorrencias = $nPcEscolhaTotalF8)"
"semPageFrameLegado       = $semPageFrameLegadoF8"
"temDllExterna            = $temDllExternaF8"
"temDoForm (filtro-desp.) = $temDoFormF8"
"temOleControl            = $temOleF8"
"nBotoesLegado            = $nBotoesF8"
"cliqueSoFecha            = $cliqueSoFechaF8"
"somenteLeitura           = $somenteLeituraF8"
"escritaSoEmCursorLocal   = $escritaSoCursorF8"

# ---- (3) a assinatura do layout "retorno-ao-pai"
$nAtribParentF8 = ([regex]::Matches($txtLegadoF8, '(?i)ThisForm\s*\.\s*ParentForm\s*\.')).Count
$temReleaseF8   = $txtLegadoF8 -match '(?i)ThisForm\s*\.\s*Release'
"atribuicoes ThisForm.ParentForm.* = $nAtribParentF8"
"ThisForm.Release presente         = $temReleaseF8"

# ---- (4) bloco do BOTAO DE ACAO
$temAcaoCanonicaF8 = $conteudo -match $padraoAcaoGravar
"botao de acao canonico no migrado = $temAcaoCanonicaF8"

# ---- (5) veredito
$bloqueiaAcao = (-not $temAcaoCanonicaF8)
if ($faltantes.Count -eq 0 -and -not $bloqueiaAcao) { "`nVEREDITO FASE 8 (sem ramos) = PASSA" } else { "`nVEREDITO FASE 8 (sem ramos) = REPROVA -> faltantes=[$($faltantes -join ', ')] bloqueiaAcao=$bloqueiaAcao" }

# ---- (6) o ramo RETORNO-AO-PAI (13o), que foi acrescentado para este layout
$semGradeGraficoF8 = $semGradeEstritaF8
$temSuperficieRetornoF8 = ($conteudo -match $padraoAcaoGravar) -and
                          ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+FormParaBO\b') -and
                          ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+BOParaForm\b')
$retornoAoPaiHelperF8 = Test-LegadoRetornoAoPai -TextoDump $txtLegadoF8
$legadoRetornoAoPaiF8 = ($semCrudLegadoF8 -and $legadoSemSalvar -and
                         $semGradeGraficoF8 -and $temCamposLegadoF8 -and
                         (-not $somenteLeituraF8) -and $escritaSoCursorF8 -and
                         (-not $temDoFormF8) -and $semPageFrameLegadoF8 -and
                         $retornoAoPaiHelperF8 -and $temSuperficieRetornoF8)
"`n--- ramo RETORNO-AO-PAI ---"
"Test-LegadoRetornoAoPai (helper)  = $retornoAoPaiHelperF8"
"temSuperficieRetornoF8 (migrado)  = $temSuperficieRetornoF8"
"legadoRetornoAoPaiF8              = $legadoRetornoAoPaiF8"
if ($legadoRetornoAoPaiF8) {
    $dispensa = @("BtnCancelarClick","CarregarLista")
    $faltantes = @($faltantes | Where-Object { $dispensa -notcontains $_ })
    "pos-dispensa faltantes            = [{0}]" -f ($faltantes -join ', ')
}
if ($faltantes.Count -eq 0 -and -not $bloqueiaAcao) { "`nVEREDITO FASE 8 (com o ramo) = PASSA" } else { "`nVEREDITO FASE 8 (com o ramo) = REPROVA" }
