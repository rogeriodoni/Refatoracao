# VerificarGateFase8Task646.ps1
#
# Prova, SEM executar o orquestrador, que a Fase 8 de SIGOPBIN -> FormSIGOPBIN
# passa pelo motivo ESTRUTURAL certo e nao por acaso:
#   1) o OrquestradorMigracao.ps1 continua sintaticamente valido;
#   2) os 11 ramos de excecao ANTERIORES todos reprovam este legado (isto eh,
#      o ramo novo era de fato necessario);
#   3) as provas do ramo ENTRADA-SEM-BOTAO valem para este dump/migrado;
#   4) o unico bloqueio que restava (PROCEDURE Btn(Salvar|Confirmar|...)Click)
#      eh dispensado por esse ramo - e nao por ter sido inventado um botao.
#
# AST-only de proposito: dot-source do orquestrador DISPARA uma migracao real
# (move .SCX de origem\ e sobrescreve BO existente).

$src = 'C:\4c\automation\OrquestradorMigracao.ps1'
$erros = $null
[System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$erros) | Out-Null
if ($erros -and $erros.Count -gt 0) {
    "SINTAXE=FALHA ({0} erro(s))" -f $erros.Count
    $erros | Select-Object -First 5 | ForEach-Object { "  L{0}: {1}" -f $_.Extent.StartLineNumber, $_.Message }
    exit 1
}
"SINTAXE=OK"

$ast = [System.Management.Automation.Language.Parser]::ParseFile($src, [ref]$null, [ref]$null)
foreach ($f in $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)) {
    . ([scriptblock]::Create($f.Extent.Text))
}

$txt      = Get-Content 'C:\4c\tasks\task646\SIGOPBIN_form_codigo_fonte.txt' -Raw
$conteudo = Get-Content 'C:\4c\projeto\app\forms\operacionais\FormSIGOPBIN.prg' -Raw

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

"--- LEGADO (SIGOPBIN) ---"
"nBotoesLegado        = {0}" -f $nBotoes
"cliqueSoFecha        = {0}" -f $(if ($null -eq $cliqueSoFecha) { '<nulo>' } else { $cliqueSoFecha })
"temCamposLegado      = {0}" -f $temCampos
"somenteLeitura       = {0}" -f $soLeitura
"semCrudLegado        = {0}" -f $semCrud
"legadoSemSalvar      = {0}" -f $semSalvar
"semGrade (estreito)  = {0}" -f $semGrade
""

# ---- (2) os 11 ramos anteriores reprovam? ---------------------------------
"--- RAMOS ANTERIORES (todos devem reprovar) ---"
"despachante    (exige -not temCampos)     = {0}" -f (-not $temCampos)
"exibicao       (exige soLeitura)          = {0}" -f ((-not $temLista) -and $semCrud -and $soLeitura)
"visualizador   (exige soLeitura)          = {0}" -f ($semCrud -and $semSalvar -and $soLeitura)
"calculadora    (exige nBotoes==1)         = {0}" -f ($nBotoes -eq 1)
"protocolo      (exige nBotoes==1 + DLL)   = {0}" -f (($nBotoes -eq 1) -and ($txt -match '(?i)DECLARE.*DLL'))
"grafico        (exige OleBoundControl)    = {0}" -f ($txt -match '(?im)^\s*BaseClass:\s*oleboundcontrol\s*$')
"fluxo-unico    (exige lista real)         = {0}" -f $temLista
"linha-imediata (exige grade)              = {0}" -f $temLista
"leitor-baixa   (exige persistencia)       = {0}" -f (-not (Test-LegadoEscritaSoEmCursorLocal -TextoDump $txt))
"acaoComHandler (exige botao com verbo)    = {0}" -f (Test-AcaoDoLegadoTemHandler -TextoDump $txt -ConteudoForm $conteudo)
""

# ---- (3) o ramo novo ------------------------------------------------------
$temSuperficieEntrada = ($conteudo -match 'AddObject\(\s*"(txt_4c_|cbo_4c_|edt_4c_|spn_4c_)[^"]*"\s*,\s*"(TextBox|ComboBox|EditBox|Spinner)"') -and
                        ($conteudo -match 'BINDEVENT\([^)]*,\s*"KeyPress"') -and
                        ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+\w*KeyPress\b')

$ramoEntrada = (Test-LegadoSemBotaoAlgum -TextoDump $txt) -and $semCrud -and $semSalvar -and
               $semGrade -and $temCampos -and (-not $soLeitura) -and $temSuperficieEntrada

"--- RAMO ENTRADA-SEM-BOTAO ---"
"Test-LegadoSemBotaoAlgum   = {0}" -f (Test-LegadoSemBotaoAlgum -TextoDump $txt)
"temSuperficieEntrada       = {0}" -f $temSuperficieEntrada
"  campo de entrada         = {0}" -f ($conteudo -match 'AddObject\(\s*"(txt_4c_|cbo_4c_|edt_4c_|spn_4c_)[^"]*"\s*,\s*"(TextBox|ComboBox|EditBox|Spinner)"')
"  BINDEVENT KeyPress       = {0}" -f ($conteudo -match 'BINDEVENT\([^)]*,\s*"KeyPress"')
"  handler KeyPress         = {0}" -f ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+\w*KeyPress\b')
"RAMO_ENTRADA_SEM_BOTAO     = {0}" -f $ramoEntrada
""

# ---- (4) veredito do gate -------------------------------------------------
$metodosFinals = @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
$faltantes = @($metodosFinals | Where-Object { $conteudo -notmatch $_ })
if ($conteudo -notmatch $padraoAcaoGravar) { $faltantes += 'BtnSalvarClick (ou BtnConfirmarClick/...)' }

"--- VEREDITO ---"
"faltantes ANTES do ramo = {0}" -f $(if ($faltantes.Count -eq 0) { '<nenhum>' } else { $faltantes -join ', ' })
if ($ramoEntrada) { $faltantes = @() }
"faltantes DEPOIS do ramo = {0}" -f $(if ($faltantes.Count -eq 0) { '<nenhum>' } else { $faltantes -join ', ' })
"GATE_FASE8 = {0}" -f $(if ($faltantes.Count -eq 0) { 'PASSA' } else { 'REPROVA' })

# ---- hooks implementados DE VERDADE (nao so citados em comentario) -------
""
"--- hooks reais no .prg (declaracao, nao prosa de comentario) ---"
"FormParaBO declarado  = {0}" -f ($conteudo -match '(?m)^\s*PROTECTED\s+(PROCEDURE|FUNCTION)\s+FormParaBO\b')
"BOParaForm declarado  = {0}" -f ($conteudo -match '(?m)^\s*PROTECTED\s+(PROCEDURE|FUNCTION)\s+BOParaForm\b')
