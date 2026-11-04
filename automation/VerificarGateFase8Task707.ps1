# VerificarGateFase8Task707.ps1
#
# Mede, SEM executar o orquestrador, o que a Fase 8 de SIGOPCOR -> FormSIGOPCOR
# de fato cobra e por qual ramo:
#   1) o OrquestradorMigracao.ps1 continua sintaticamente valido;
#   2) quais ramos de excecao reprovam/aprovam este legado;
#   3) se o botao de ACAO do legado (SIGOPCOR.Sair.Ok, Caption "\<Confirmar")
#      foi reconhecido por Test-AcaoDoLegadoTemHandler, que e o que dispensa o
#      nome canonico Btn(Salvar|Confirmar|Gravar|...)Click;
#   4) quais dos quatro nomes finais ainda faltam no .prg.
#
# AST-only de proposito: dot-source do orquestrador DISPARA uma migracao real
# (feedback_dot_source_orquestrador_dispara_migracao).

$src = 'C:\4c\automation\OrquestradorMigracao.ps1'
$erros = $null
[System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$erros) | Out-Null
if ($erros -and $erros.Count -gt 0) {
    "SINTAXE=FALHA ({0} erro(s))" -f $erros.Count
    exit 1
}
"SINTAXE=OK"

$ast = [System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

$dump = 'C:\4c\tasks\task707\SIGOPCOR_form_codigo_fonte.txt'
$prg  = 'C:\4c\projeto\app\forms\operacionais\FormSIGOPCOR.prg'
$txt      = Get-Content $dump -Raw
$conteudo = Get-Content $prg  -Raw

$padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'

$temLista = ($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
            ($txt -match '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)')
$temCampos = ($txt -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
$semCrud   = -not (@('frmcadastro','Grupo_Op','(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)','(Incluir|Alterar|Visualizar|Excluir)\.Click') | Where-Object { $txt -match $_ })
$semSalvar = -not (@('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados') | Where-Object { $txt -match $_ })
$nBotoes   = Get-ContagemBotoesLegado -TextoDump $txt
$cliqueSoFecha = Test-LegadoCliqueSoFecha -TextoDump $txt
$soLeitura     = Test-LegadoSomenteLeitura -TextoDump $txt
$semGrade = -not (($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                  (Test-LegadoListBoxLigaLista -TextoDump $txt) -or
                  ($txt -match '(?i)(pColuna|\bGrade\b|\bgrd)') -or
                  (Test-LegadoAddCursorLigaGrade     -TextoDump $txt) -or
                  (Test-LegadoControlSourceLigaLista -TextoDump $txt))

"--- LEGADO (SIGOPCOR) ---"
"nomesBotoesLegado    = {0}" -f ((Get-NomesBotoesLegado -TextoDump $txt) -join ' | ')
"nBotoesLegado        = {0}" -f $nBotoes
"cliqueSoFecha        = {0}" -f $(if ($null -eq $cliqueSoFecha) { '<nulo>' } else { $cliqueSoFecha })
"temCamposLegado      = {0}" -f $temCampos
"temLista (largo)     = {0}" -f $temLista
"somenteLeitura       = {0}" -f $soLeitura
"semCrudLegado        = {0}" -f $semCrud
"legadoSemSalvar      = {0}" -f $semSalvar
"semGrade (estreito)  = {0}" -f $semGrade
""
"--- BOTAO DE ACAO (dispensa o nome canonico de gravar) ---"
"padraoAcaoGravar no migrado = {0}" -f ($conteudo -match $padraoAcaoGravar)
"AcaoDoLegadoTemHandler      = {0}" -f (Test-AcaoDoLegadoTemHandler -TextoDump $txt -ConteudoForm $conteudo)
""
"--- NOMES FINAIS DA FASE 8 ---"
foreach ($m in @("BtnCancelarClick","FormParaBO","BOParaForm","CarregarLista")) {
    "{0,-18} presente={1}" -f $m, ($conteudo -match $m)
}
""
"--- DECLARACAO REAL (nao so citacao em comentario) ---"
foreach ($m in @("FormParaBO","BOParaForm","LimparCampos","CarregarLista","BtnCancelarClick","BtnConfirmarClick","BtnEncerrarClick")) {
    $decl = $conteudo -match ('(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+' + $m + '\b')
    "{0,-18} declarado={1}" -f $m, $decl
}
""
$faltantes = @(@("BtnCancelarClick","FormParaBO","BOParaForm","CarregarLista") | Where-Object { $conteudo -notmatch $_ })
"faltantes                  = [{0}]" -f ($faltantes -join ', ')
"VEREDITO FASE 8            = {0}" -f $(if ($faltantes.Count -eq 0) { 'PASSA' } else { 'REPROVA' })
