# VerificarGateFase8Task702.ps1
#
# Prova, SEM executar o orquestrador, que a Fase 8 de SIGOPCKS -> Formsigopcks
# passa pelo motivo ESTRUTURAL certo e nao por acaso:
#   1) o OrquestradorMigracao.ps1 continua sintaticamente valido;
#   2) os ramos de excecao ANTERIORES reprovam este legado (ou seja, quem
#      dispensa os nomes canonicos eh mesmo o ramo ENTRADA-SEM-BOTAO);
#   3) as provas do ramo ENTRADA-SEM-BOTAO valem para este dump/migrado - e
#      pelo caminho LostFocus/Valid, nao pelo KeyPress (o SCX confirma a tela
#      no Valid de SIGOPCKS.senha, igual ao SIGPRSCN/task673);
#   4) os quatro nomes canonicos nao aparecem no .prg NEM EM COMENTARIO - o
#      gate casa substring no arquivo inteiro, entao cita-los daria falso-pass
#      e o ramo nunca seria exercitado (por isso o cabecalho do form os grafa
#      com o miolo elidido).
#
# AST-only de proposito: dot-source do orquestrador DISPARA uma migracao real.

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

$txt      = Get-Content 'C:\4c\tasks\task702\sigopcks_form_codigo_fonte.txt' -Raw
$conteudo = Get-Content 'C:\4c\projeto\app\forms\operacionais\Formsigopcks.prg' -Raw

$padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'

# ---- superficie do LEGADO -------------------------------------------------
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

"--- LEGADO (SIGOPCKS) ---"
"nBotoesLegado        = {0}" -f $nBotoes
"cliqueSoFecha        = {0}" -f $(if ($null -eq $cliqueSoFecha) { '<nulo>' } else { $cliqueSoFecha })
"temCamposLegado      = {0}" -f $temCampos
"somenteLeitura       = {0}" -f $soLeitura
"semCrudLegado        = {0}" -f $semCrud
"legadoSemSalvar      = {0}" -f $semSalvar
"semGrade (estreito)  = {0}" -f $semGrade
""

# ---- (2) os ramos anteriores reprovam? ------------------------------------
"--- RAMOS ANTERIORES (todos devem reprovar) ---"
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
"leitor-baixa   (exige persistencia)       = {0}" -f (-not (Test-LegadoEscritaSoEmCursorLocal -TextoDump $txt))
"retorno-ao-pai (exige ParentForm)         = {0}" -f (Test-LegadoRetornoAoPai -TextoDump $txt)
"acaoComHandler (exige botao com verbo)    = {0}" -f (Test-AcaoDoLegadoTemHandler -TextoDump $txt -ConteudoForm $conteudo)
""

# ---- (3) o ramo ENTRADA-SEM-BOTAO -----------------------------------------
$temCampoMigrado = $conteudo -match 'AddObject\(\s*"(txt_4c_|cbo_4c_|edt_4c_|spn_4c_)[^"]*"\s*,\s*"(TextBox|ComboBox|EditBox|Spinner)"'
$confirmacao     = Test-ConfirmacaoDialogoSemBotao -TextoDump $txt -ConteudoForm $conteudo
$temSuperficieEntrada = $temCampoMigrado -and $confirmacao

$ramoEntrada = (Test-LegadoSemBotaoAlgum -TextoDump $txt) -and $semCrud -and $semSalvar -and
               $semGrade -and $temCampos -and (-not $soLeitura) -and $temSuperficieEntrada

"--- RAMO ENTRADA-SEM-BOTAO ---"
"Test-LegadoSemBotaoAlgum        = {0}" -f (Test-LegadoSemBotaoAlgum -TextoDump $txt)
"campo de entrada no migrado     = {0}" -f $temCampoMigrado
"Test-ConfirmacaoDialogoSemBotao = {0}" -f $confirmacao
"RAMO_ENTRADA_SEM_BOTAO          = {0}" -f $ramoEntrada
""

# ---- (4) veredito do gate -------------------------------------------------
$metodosFinals = @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
$faltantes = @($metodosFinals | Where-Object { $conteudo -notmatch $_ })
if ($conteudo -notmatch $padraoAcaoGravar) { $faltantes += 'BtnSalvarClick (ou BtnConfirmarClick/...)' }

"--- VEREDITO ---"
"faltantes ANTES do ramo  = {0}" -f $(if ($faltantes.Count -eq 0) { '<nenhum>' } else { $faltantes -join ', ' })
if ($ramoEntrada) { $faltantes = @() }
"faltantes DEPOIS do ramo = {0}" -f $(if ($faltantes.Count -eq 0) { '<nenhum>' } else { $faltantes -join ', ' })
"GATE_FASE8 = {0}" -f $(if ($faltantes.Count -eq 0) { 'PASSA' } else { 'REPROVA' })

# ---- (5) anti falso-pass: os nomes canonicos nao podem estar no .prg ------
""
"--- ANTI FALSO-PASS (nenhum pode aparecer, nem em comentario) ---"
foreach ($n in $metodosFinals) {
    "{0,-18} presente = {1}" -f $n, ($conteudo -match $n)
}

if (-not $ramoEntrada) { exit 1 }
exit 0
