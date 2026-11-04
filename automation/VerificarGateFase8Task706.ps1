# VerificarGateFase8Task706.ps1
#
# Mede, SEM executar o orquestrador, o que a Fase 8 de SIGOPCOP -> FormSigOpCop
# de fato cobra e por qual ramo:
#   1) o OrquestradorMigracao.ps1 continua sintaticamente valido;
#   2) quais ramos de excecao reprovam/aprovam este legado;
#   3) se o botao de ACAO do legado ("\<Copiar" / CmdCopia) foi reconhecido
#      por Test-AcaoDoLegadoTemHandler, que e o que dispensa o nome canonico
#      Btn(Salvar|Confirmar|Gravar|...)Click;
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

$dump = 'C:\4c\tasks\task706\SigOpCop_form_codigo_fonte.txt'
$prg  = 'C:\4c\projeto\app\forms\operacionais\FormSigOpCop.prg'
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

"--- LEGADO (SIGOPCOP) ---"
"nomesBotoesLegado    = {0}" -f ((Get-NomesBotoesLegado -TextoDump $txt) -join ' | ')
"nBotoesLegado        = {0}" -f $nBotoes
"cliqueSoFecha        = {0}" -f $(if ($null -eq $cliqueSoFecha) { '<nulo>' } else { $cliqueSoFecha })
"temCamposLegado      = {0}" -f $temCampos
"temLista (largo)     = {0}" -f $temLista
"somenteLeitura       = {0}" -f $soLeitura
"semCrudLegado        = {0}" -f $semCrud
"legadoSemSalvar      = {0}" -f $semSalvar
"semGrade (estreito)  = {0}" -f $semGrade
"escritaSoCursorLocal = {0}" -f (Test-LegadoEscritaSoEmCursorLocal -TextoDump $txt)
""
"--- RAMOS DE EXCECAO ---"
"despachante    (exige -not temCampos)     = {0}" -f (-not $temCampos)
"exibicao       (exige soLeitura)          = {0}" -f ((-not $temLista) -and $semCrud -and $soLeitura)
"visualizador   (exige soLeitura)          = {0}" -f ($semCrud -and $semSalvar -and $soLeitura)
"calculadora    (exige nBotoes==1)         = {0}" -f ($nBotoes -eq 1)
"protocolo      (exige nBotoes==1 + DLL)   = {0}" -f (($nBotoes -eq 1) -and ($txt -match '(?i)DECLARE.*DLL'))
"grafico        (exige OleBoundControl)    = {0}" -f ($txt -match '(?im)^\s*BaseClass:\s*oleboundcontrol\s*$')
"fluxo-unico    (exige lista real)         = {0}" -f $temLista
"linha-imediata (exige grade)              = {0}" -f $temLista
"filtro-despacho(exige Do Form)            = {0}" -f ($txt -match '(?i)\bDo\s+Form\b')
"util-arquivo   (exige Create Table Free)  = {0}" -f ($txt -match '(?i)Create\s+Table[^\r\n]*Free')
"entrada-s/botao(exige ZERO botao)         = {0}" -f (Test-LegadoSemBotaoAlgum -TextoDump $txt)
"retorno-ao-pai (exige ParentForm+cursor)  = {0}" -f (Test-LegadoRetornoAoPai -TextoDump $txt)
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
"--- 14o RAMO: COPIADOR-FILHO ---"
$copiadorHelper = Test-LegadoCopiadorFilho -TextoDump $txt
"Test-LegadoCopiadorFilho    = {0}" -f $copiadorHelper

$temSuperficieCopiador = ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+FormParaBO\b') -and
                         ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+BOParaForm\b') -and
                         (Test-AcaoDoLegadoTemHandler -TextoDump $txt -ConteudoForm $conteudo)
"temSuperficieCopiadorF8     = {0}" -f $temSuperficieCopiador

$predicado = $copiadorHelper -and $temSuperficieCopiador -and
             $semCrud -and $semSalvar -and $semGrade -and $temCampos -and
             (-not $soLeitura) -and
             (-not ($txt -match '(?im)^\s*Do\s+Form\s+\w+')) -and
             (-not ($txt -match '(?im)^\s*BaseClass:\s*pageframe\s*$'))
"legadoCopiadorFilhoF8       = {0}" -f $predicado

$faltantes = @(@("BtnCancelarClick","FormParaBO","BOParaForm","CarregarLista") | Where-Object { $conteudo -notmatch $_ })
"faltantes ANTES da dispensa = [{0}]" -f ($faltantes -join ', ')
if ($predicado) {
    $faltantes = @($faltantes | Where-Object { @("BtnCancelarClick","CarregarLista") -notcontains $_ })
}
"faltantes DEPOIS           = [{0}]" -f ($faltantes -join ', ')
"VEREDITO FASE 8            = {0}" -f $(if ($faltantes.Count -eq 0) { 'PASSA' } else { 'REPROVA' })
