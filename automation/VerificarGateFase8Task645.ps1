# VerificarGateFase8Task645.ps1
#
# Prova, SEM executar o orquestrador, que a Fase 8 de SIGOPBCB -> FormSigOpBcb
# passa pelo motivo ESTRUTURAL certo e nao por acaso:
#   1) o OrquestradorMigracao.ps1 continua sintaticamente valido;
#   2) as SEIS provas do ramo LEITOR-BAIXA valem para este dump/migrado;
#   3) dos quatro nomes que o gate cobra, tres estao no .prg e o quarto
#      (carga da LISTA) esta AUSENTE de verdade - inclusive da prosa dos
#      comentarios, senao a checagem por substring do gate seria satisfeita
#      sem metodo nenhum e o ramo nunca seria avaliado.
#
# AST-only de proposito: dot-source do orquestrador DISPARA uma migracao real
# (move .SCX de origem\ e sobrescreve BO existente).

# 1) Checagem de SINTAXE do orquestrador (parser, sem executar nada).
$src = 'C:\4c\automation\OrquestradorMigracao.ps1'
$erros = $null
[System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$erros) | Out-Null
if ($erros -and $erros.Count -gt 0) {
    "SINTAXE=FALHA ({0} erro(s))" -f $erros.Count
    $erros | Select-Object -First 5 | ForEach-Object { "  L{0}: {1}" -f $_.Extent.StartLineNumber, $_.Message }
    exit 1
}
"SINTAXE=OK"

# 2) Reproduz o predicado do ramo LEITOR-BAIXA com os helpers reais (AST-only).
$ast   = [System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$null)
$funcs = $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)
foreach ($f in $funcs) { . ([scriptblock]::Create($f.Extent.Text)) }

$txt      = Get-Content 'C:\4c\tasks\task645\SigOpBcb_form_codigo_fonte.txt' -Raw
$conteudo = Get-Content 'C:\4c\projeto\app\forms\operacionais\FormSigOpBcb.prg' -Raw

$padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'

$semCrud = -not (@('frmcadastro','Grupo_Op','(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)','(Incluir|Alterar|Visualizar|Excluir)\.Click') | Where-Object { $txt -match $_ })
$semSalvar = -not (@('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados') | Where-Object { $txt -match $_ })
$temCampos = ($txt -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
$semGrade = -not (($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                  (Test-LegadoListBoxLigaLista -TextoDump $txt) -or
                  ($txt -match '(?i)(pColuna|\bGrade\b|\bgrd)') -or
                  (Test-LegadoAddCursorLigaGrade     -TextoDump $txt) -or
                  (Test-LegadoControlSourceLigaLista -TextoDump $txt))

$temSuperficie = ($conteudo -match $padraoAcaoGravar) -and
                 ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+FormParaBO\b') -and
                 ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+BOParaForm\b')

"prova 1 semCrudLegado        = {0}" -f $semCrud
"prova 2 legadoSemSalvar      = {0}" -f $semSalvar
"prova 3 semGrade (estreito)  = {0}" -f $semGrade
"prova 4 temCampos e digitavel= {0}" -f ($temCampos -and -not (Test-LegadoSomenteLeitura -TextoDump $txt))
"prova 5 persiste em tabela   = {0}" -f (-not (Test-LegadoEscritaSoEmCursorLocal -TextoDump $txt))
"prova 6 superficie no migrado= {0}" -f $temSuperficie
""
"RAMO_LEITOR_BAIXA = {0}" -f ($semCrud -and $semSalvar -and $semGrade -and $temCampos -and
                              (-not (Test-LegadoSomenteLeitura -TextoDump $txt)) -and
                              (-not (Test-LegadoEscritaSoEmCursorLocal -TextoDump $txt)) -and
                              $temSuperficie)
""
"Nomes exigidos pelo gate (substring crua no .prg):"
foreach ($m in @('BtnCancelarClick','FormParaBO','BOParaForm','CarregarLista')) {
    "  {0,-18} = {1}" -f $m, ($conteudo -match $m)
}
