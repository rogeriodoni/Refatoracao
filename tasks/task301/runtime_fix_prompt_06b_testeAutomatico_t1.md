# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[17/07/2026 07:16:53] Erro: Unknown member THIS_OBUSINESSOBJECT. LN=66 PROC=inicializarform


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-17 07:16:31] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-17 07:16:31] [INFO] Config FPW: (nao fornecido)
[2026-07-17 07:16:31] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 07:16:31] [INFO] Timeout: 300 segundos
[2026-07-17 07:16:31] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_10hyg3v5.prg
[2026-07-17 07:16:31] [INFO] Conteudo do wrapper:
[2026-07-17 07:16:31] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRIFF', 'C:\4c\tasks\task301', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRIFF', 'C:\4c\tasks\task301', 'OPERACIONAL'
QUIT

[2026-07-17 07:16:31] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_10hyg3v5.prg
[2026-07-17 07:16:31] [INFO] VFP output esperado em: C:\4c\tasks\task301\vfp_output.txt
[2026-07-17 07:16:31] [INFO] Executando Visual FoxPro 9...
[2026-07-17 07:16:31] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_10hyg3v5.prg
[2026-07-17 07:16:31] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_10hyg3v5.prg
[2026-07-17 07:16:31] [INFO] Timeout configurado: 300 segundos
[2026-07-17 07:16:53] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-17 07:16:53] [INFO] VFP9 finalizado em 22.5792339 segundos
[2026-07-17 07:16:53] [INFO] Exit Code: 
[2026-07-17 07:16:53] [INFO] 
[2026-07-17 07:16:53] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-17 07:16:53] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_10hyg3v5.prg
[2026-07-17 07:16:53] [INFO] 
[2026-07-17 07:16:53] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-17 07:16:53] [INFO] * Auto-generated wrapper for parameters
[2026-07-17 07:16:53] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-17 07:16:53] [INFO] * Parameters: 'FormSIGPRIFF', 'C:\4c\tasks\task301', 'OPERACIONAL'
[2026-07-17 07:16:53] [INFO] 
[2026-07-17 07:16:53] [INFO] * Anti-dialog protections for unattended execution
[2026-07-17 07:16:53] [INFO] SET SAFETY OFF
[2026-07-17 07:16:53] [INFO] SET RESOURCE OFF
[2026-07-17 07:16:53] [INFO] SET TALK OFF
[2026-07-17 07:16:53] [INFO] SET NOTIFY OFF
[2026-07-17 07:16:53] [INFO] SYS(2335, 0)
[2026-07-17 07:16:53] [INFO] 
[2026-07-17 07:16:53] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRIFF', 'C:\4c\tasks\task301', 'OPERACIONAL'
[2026-07-17 07:16:53] [INFO] QUIT
[2026-07-17 07:16:53] [INFO] 
[2026-07-17 07:16:53] [INFO] === Fim do Wrapper.prg ===
[2026-07-17 07:16:53] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGPRIFF",
  "timestamp": "20260717071653",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": false,
      "erro": "CREATEOBJECT retornou valor nao-objeto",
      "detalhes": ""
    }
  ],
  "resumo": {
    "total": 1,
    "passou": 0,
    "falhou": 1,
    "percentual": 0
  }
}



## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRIFF.prg):
*==============================================================================
* FormSIGPRIFF.prg - Dialogo generico de entrada (InputBox)
* Migrado de SIGPRIFF.SCX
* Exibe TextBox (texto/numero/data) ou ComboBox (tipo "M" = multipla escolha)
*
* Uso canonico:
*   loForm = CREATEOBJECT("FormSIGPRIFF", cCab, cTipo, cTitulo, nMax, nMin, cDado)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()              && bloqueia ate THIS.Hide()
*       lcResposta = loForm.ObterResposta()
*   ENDIF
*
* par_cTipo = "M"  -> ComboBox; par_cCabecalho = "Opcao1;Opcao2;Opcao3;"
*             outro -> TextBox; par_cDado = "D" (data), "V" (valor), "" (texto)
*
* Resposta do ComboBox: 1o caractere da opcao selecionada (ex: "S", "N")
* Resposta do TextBox : valor digitado convertido para string
*==============================================================================
DEFINE CLASS FormSIGPRIFF AS FormBase
	ShowWindow = 1

    this_cClasseBO  = "SIGPRIFFBO"

    *-- Dimensoes identicas ao form1 original (Width=409, Height=50)
    Width           = 409
    Height          = 50
    AutoCenter      = .T.
    KeyPreview      = .T.
    WindowType      = 1
    TitleBar        = 1
    ControlBox      = .T.
    MaxButton       = .F.
    MinButton       = .F.
    Closable        = .F.

    *-- Parametros recebidos via Init(), armazenados antes de DODEFAULT()
    this_cCabecalho = ""
    this_cTipo      = ""
    this_cTitulo    = ""
    this_nMaximo    = 0
    this_nMinimo    = 0
    this_cDado      = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cCabecalho, par_cTipo, par_cTitulo, ;
                   par_nMaximo, par_nMinimo, par_cDado)
    *--------------------------------------------------------------------------
        THIS.this_cCabecalho = IIF(VARTYPE(par_cCabecalho) = "C", par_cCabecalho, "")
        THIS.this_cTipo      = IIF(VARTYPE(par_cTipo)      = "C", par_cTipo,      "")
        THIS.this_cTitulo    = IIF(VARTYPE(par_cTitulo)    = "C", par_cTitulo,    "")
        THIS.this_nMaximo    = IIF(VARTYPE(par_nMaximo)    = "N", par_nMaximo,    0)
        THIS.this_nMinimo    = IIF(VARTYPE(par_nMinimo)    = "N", par_nMinimo,    0)
        THIS.this_cDado      = IIF(VARTYPE(par_cDado)      = "C", par_cDado,      "")
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject.ConfigurarDialogo( ;
                THIS.this_cCabecalho, THIS.this_cTipo, THIS.this_cTitulo, ;
                THIS.this_nMaximo, THIS.this_nMinimo, THIS.this_cDado)

            THIS.Caption = THIS.this_cTitulo

            THIS.ConfigurarPageFrame()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura o layout principal do form
    * Form original (SIGPRIFF.SCX) eh dialogo flat (Width=409, Height=50) sem
    * PageFrame - contem apenas TextBox OU ComboBox conforme par_cTipo.
    * Portanto delega direto para ConfigurarControles (sem PageFrame/Pages).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarControles()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - SIGPRIFF eh dialogo InputBox de linha unica.
    * Nao possui PageFrame/Page1/Grid/botoes CRUD - delega para ConfigurarControles.
    * Metodo mantido para conformidade com o contrato do pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarControles()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - SIGPRIFF eh dialogo InputBox de linha unica.
    * Nao possui Page2/Dados nem campos adicionais - toda a UI esta em
    * ConfigurarControles (TextBox ou ComboBox conforme par_cTipo).
    * Metodo mantido para conformidade com o contrato do pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - SIGPRIFF nao possui abas (form flat de linha unica).
    * Metodo mantido para conformidade com o contrato do pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarControles()
    *--------------------------------------------------------------------------
        IF THIS.this_cTipo = "M"
            THIS.ConfigurarComboBox()
        ELSE
            THIS.ConfigurarTextBox()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarComboBox - Cria ComboBox e popula com opcoes de par_cCabecalho
    * Formato esperado: "Opcao1;Opcao2;Opcao3;" (com ";" final para cada item)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarComboBox()
        LOCAL loc_cCab, loc_nRep, loc_i, loc_nPos1, loc_nPos2, loc_cOpcao

        THIS.AddObject("cbo_4c_Opcoes", "ComboBox")
        WITH THIS.cbo_4c_Opcoes
            .Top               = 12
            .Left              = 12
            .Width             = 390
            .Height            = 24
            .Style             = 2
            .ReadOnly          = .F.
            .BackColor         = RGB(255, 255, 255)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 0)
            .RowSourceType     = 0
            .Visible           = .T.
        ENDWITH

        loc_cCab = THIS.this_oBusinessObject.this_cCabecalho
        loc_nRep = OCCURS(";", loc_cCab)

        IF loc_nRep = 0
            IF !EMPTY(loc_cCab)
                THIS.cbo_4c_Opcoes.AddItem(loc_cCab)
            ENDIF
        ELSE
            *-- Extrai cada item entre delimitadores ";" (replica logica do legado)
            FOR loc_i = 1 TO loc_nRep
                loc_nPos1  = IIF(loc_i = 1, 1, AT(";", loc_cCab, loc_i - 1) + 1)
                loc_nPos2  = AT(";", loc_cCab, loc_i)
                loc_cOpcao = SUBSTR(loc_cCab, loc_nPos1, ;
                             loc_nPos2 - IIF(loc_i = 1, 0, AT(";", loc_cCab, loc_i - 1)) - 1)
                IF !EMPTY(loc_cOpcao)
                    THIS.cbo_4c_Opcoes.AddItem(loc_cOpcao)
                ENDIF
            ENDFOR
        ENDIF

        IF THIS.cbo_4c_Opcoes.ListCount > 0
            THIS.cbo_4c_Opcoes.ListIndex = 1
        ENDIF

        BINDEVENT(THIS.cbo_4c_Opcoes, "KeyPress", THIS, "CboOpcoesKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarTextBox - Cria TextBox com tipo/mascara conforme par_cDado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarTextBox()
        THIS.AddObject("txt_4c_Texto", "TextBox")
        WITH THIS.txt_4c_Texto
            .Top           = 12
            .Left          = 12
            .Width         = 389
            .Height        = 25
            .Alignment     = 3
            .SelectOnEntry = .T.
            .Visible       = .T.
        ENDWITH

        IF THIS.this_cDado = "D"
            THIS.txt_4c_Texto.Value = CTOD("")
        ELSE
            IF THIS.this_cDado = "V"
            THIS.txt_4c_Texto.Value     = 0
            THIS.txt_4c_Texto.InputMask = "999,999.99"
        ELSE
            THIS.txt_4c_Texto.Value     = ""
            THIS.txt_4c_Texto.MaxLength = THIS.this_oBusinessObject.ObterMaxLength()
            ENDIF
        ENDIF

        BINDEVENT(THIS.txt_4c_Texto, "KeyPress", THIS, "TxtTextoKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterResposta()
    *--------------------------------------------------------------------------
        RETURN THIS.this_oBusinessObject.this_cResposta
    ENDFUNC

    *-- Form captura ESC antes dos controles (KeyPreview = .T.)
    PROCEDURE KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 27
            THIS.this_oBusinessObject.this_cResposta = ""
            THIS.Hide()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE TxtTextoKeyPress
    *--------------------------------------------------------------------------
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode # 13
            RETURN
        ENDIF

        THIS.this_oBusinessObject.CapturarRespostaTexto(THIS.txt_4c_Texto.Value)

        IF THIS.this_oBusinessObject.Inserir()
            THIS.Hide()
        ELSE
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CboOpcoesKeyPress
    *--------------------------------------------------------------------------
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode # 13
            RETURN
        ENDIF
        THIS.this_oBusinessObject.CapturarRespostaCombo(THIS.cbo_4c_Opcoes.Value)
        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Confirmar entrada do dialogo (semantica de "OK/Submit")
    * SIGPRIFF eh InputBox flat (Width=409, Height=50) sem botoes CRUD no SCX
    * original - o legado usa apenas ENTER (KeyCode=13) para submeter.
    * Aqui mapeamos a semantica CRUD "Incluir" para "confirmar resposta e fechar",
    * espelhando TxtTextoKeyPress/CboOpcoesKeyPress quando par_nKeyCode=13.
    * Metodo exposto para permitir acionamento programatico do fluxo de submit
    * (ex: testes automatizados, integracao com barra de ferramentas externa).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lContinuar
        loc_lContinuar = .T.

        IF THIS.this_cTipo = "M"
            THIS.this_oBusinessObject.CapturarRespostaCombo(THIS.cbo_4c_Opcoes.Value)
            IF !THIS.this_oBusinessObject.Inserir()
                loc_lContinuar = .F.
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro)
                ENDIF
            ENDIF
        ELSE
            THIS.this_oBusinessObject.CapturarRespostaTexto(THIS.txt_4c_Texto.Value)
            IF !THIS.this_oBusinessObject.Inserir()
                loc_lContinuar = .F.
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro)
                ENDIF
            ENDIF
        ENDIF

        IF loc_lContinuar
            THIS.Hide()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - No dialogo InputBox nao existe distincao entre "novo"
    * e "alterar valor" - o campo eh single-shot. Reaproveita o fluxo de submit
    * (BtnIncluirClick), mantendo compatibilidade com o contrato CRUD do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnIncluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Semantica "visualizar" em dialogo InputBox = trazer
    * foco de volta ao controle de entrada (usuario ver/revisar o valor atual).
    * NAO fecha o dialogo (visualizacao eh nao-destrutiva).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF THIS.this_cTipo = "M"
            IF THIS.cbo_4c_Opcoes.ListCount > 0 AND THIS.cbo_4c_Opcoes.ListIndex = 0
                THIS.cbo_4c_Opcoes.ListIndex = 1
            ENDIF
            THIS.cbo_4c_Opcoes.SetFocus()
        ELSE
            THIS.txt_4c_Texto.SelStart = 0
            THIS.txt_4c_Texto.SelLength = LEN(TRANSFORM(THIS.txt_4c_Texto.Value))
            THIS.txt_4c_Texto.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Semantica "excluir/cancelar" em dialogo InputBox = limpar
    * resposta e fechar (espelha o comportamento do ESC no KeyPress do form).
    * Equivalente a cancelar a interacao sem submeter valor.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.this_oBusinessObject.this_cResposta = ""
        IF THIS.this_cTipo = "M"
            IF THIS.cbo_4c_Opcoes.ListCount > 0
                THIS.cbo_4c_Opcoes.ListIndex = 0
            ENDIF
        ELSE
            IF THIS.this_cDado = "D"
                THIS.txt_4c_Texto.Value = CTOD("")
            ELSE
                IF THIS.this_cDado = "V"
                THIS.txt_4c_Texto.Value = 0
            ELSE
                THIS.txt_4c_Texto.Value = ""
                ENDIF
            ENDIF
        ENDIF
        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Semantica "buscar" em InputBox = trazer foco ao controle
    * de entrada para o usuario localizar/rever o valor.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o dialogo sem capturar resposta (equivale ESC).
    * Limpa this_cResposta e fecha o dialogo.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.this_oBusinessObject.this_cResposta = ""
        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Semantica "salvar" em InputBox = confirmar e submeter.
    * Delega para BtnIncluirClick que ja faz validacao + captura + fechamento.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnIncluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Semantica "cancelar" em InputBox = descartar entrada.
    * Limpa resposta e fecha sem validar (equivale a BtnExcluirClick/ESC).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnExcluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Popula BO com o valor atual do controle de entrada.
    * Replica o fluxo de captura usado em TxtTextoKeyPress/CboOpcoesKeyPress.
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        IF THIS.this_cTipo = "M"
            IF PEMSTATUS(THIS, "cbo_4c_Opcoes", 5)
                THIS.this_oBusinessObject.CapturarRespostaCombo(THIS.cbo_4c_Opcoes.Value)
            ENDIF
        ELSE
            IF PEMSTATUS(THIS, "txt_4c_Texto", 5)
                THIS.this_oBusinessObject.CapturarRespostaTexto(THIS.txt_4c_Texto.Value)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Propaga this_cResposta do BO de volta ao controle de entrada.
    * Usado para restaurar estado quando o form e reapresentado com valor previo.
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_cResposta
        loc_cResposta = THIS.this_oBusinessObject.this_cResposta

        IF THIS.this_cTipo = "M"
            IF PEMSTATUS(THIS, "cbo_4c_Opcoes", 5)
                IF !EMPTY(loc_cResposta) AND THIS.cbo_4c_Opcoes.ListCount > 0
                    LOCAL loc_i
                    FOR loc_i = 1 TO THIS.cbo_4c_Opcoes.ListCount
                        IF LEFT(THIS.cbo_4c_Opcoes.List(loc_i), 1) = loc_cResposta
                            THIS.cbo_4c_Opcoes.ListIndex = loc_i
                            EXIT
                        ENDIF
                    ENDFOR
                ENDIF
            ENDIF
        ELSE
            IF PEMSTATUS(THIS, "txt_4c_Texto", 5)
                IF THIS.this_cDado = "D"
                    IF !EMPTY(loc_cResposta)
                        THIS.txt_4c_Texto.Value = CTOD(loc_cResposta)
                    ELSE
                        THIS.txt_4c_Texto.Value = CTOD("")
                    ENDIF
                ELSE
                    IF THIS.this_cDado = "V"
                    IF !EMPTY(loc_cResposta)
                        THIS.txt_4c_Texto.Value = VAL(loc_cResposta)
                    ELSE
                        THIS.txt_4c_Texto.Value = 0
                    ENDIF
                ELSE
                    THIS.txt_4c_Texto.Value = loc_cResposta
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita o controle de entrada.
    * SIGPRIFF e um dialogo de captura unica: controle sempre habilitado
    * enquanto o dialogo estiver aberto (sem distincao de modos CRUD).
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        IF THIS.this_cTipo = "M"
            IF PEMSTATUS(THIS, "cbo_4c_Opcoes", 5)
                THIS.cbo_4c_Opcoes.Enabled = par_lHabilitar
            ENDIF
        ELSE
            IF PEMSTATUS(THIS, "txt_4c_Texto", 5)
                THIS.txt_4c_Texto.Enabled = par_lHabilitar
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera o controle de entrada e a resposta no BO.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        THIS.this_oBusinessObject.this_cResposta = ""

        IF THIS.this_cTipo = "M"
            IF PEMSTATUS(THIS, "cbo_4c_Opcoes", 5)
                IF THIS.cbo_4c_Opcoes.ListCount > 0
                    THIS.cbo_4c_Opcoes.ListIndex = 1
                ENDIF
            ENDIF
        ELSE
            IF PEMSTATUS(THIS, "txt_4c_Texto", 5)
                IF THIS.this_cDado = "D"
                    THIS.txt_4c_Texto.Value = CTOD("")
                ELSE
                    IF THIS.this_cDado = "V"
                    THIS.txt_4c_Texto.Value = 0
                ELSE
                    THIS.txt_4c_Texto.Value = ""
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - SIGPRIFF e dialogo InputBox sem lista de registros.
    * Metodo mantido para conformidade com o contrato do pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - SIGPRIFF nao possui modos CRUD (INCLUIR/ALTERAR/
    * VISUALIZAR). Metodo mantido para conformidade com o contrato do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRIFFBO.prg):
*==============================================================================
* SIGPRIFFBO.prg - Business Object para FormSIGPRIFF
* Dialogo generico de entrada (InputBox) com TextBox ou ComboBox
* Migrado de SIGPRIFF.SCX (form1 - dialogo utilitario sem tabela)
*==============================================================================
DEFINE CLASS SIGPRIFFBO AS BusinessBase

    *-- Parametros do dialogo
    this_cCabecalho = ""
    this_cTipo      = ""
    this_cTitulo    = ""
    this_nMaximo    = 0
    this_nMinimo    = 0
    this_cDado      = ""

    *-- Resposta do usuario
    this_cResposta  = ""

    *-- Sem tabela no banco (dialogo utilitario)
    this_cTabela     = ""
    this_cCampoChave = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cCabecalho = ""
        THIS.this_cTipo      = ""
        THIS.this_cTitulo    = ""
        THIS.this_nMaximo    = 0
        THIS.this_nMinimo    = 0
        THIS.this_cDado      = ""
        THIS.this_cResposta  = ""

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarDialogo(par_cCabecalho, par_cTipo, par_cTitulo, ;
                                 par_nMaximo, par_nMinimo, par_cDado)
    *--------------------------------------------------------------------------
        THIS.this_cCabecalho = IIF(VARTYPE(par_cCabecalho) = "C", par_cCabecalho, "")
        THIS.this_cTipo      = IIF(VARTYPE(par_cTipo)      = "C", par_cTipo,      "")
        THIS.this_cTitulo    = IIF(VARTYPE(par_cTitulo)    = "C", par_cTitulo,    "")
        THIS.this_nMaximo    = IIF(VARTYPE(par_nMaximo)    = "N", par_nMaximo,    0)
        THIS.this_nMinimo    = IIF(VARTYPE(par_nMinimo)    = "N", par_nMinimo,    0)
        THIS.this_cDado      = IIF(VARTYPE(par_cDado)      = "C", par_cDado,      "")
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterOpcoes()
    *--------------------------------------------------------------------------
        LOCAL loc_aOpcoes[1], loc_nRep, loc_i, loc_cCab
        loc_cCab  = THIS.this_cCabecalho
        loc_nRep  = OCCURS(";", loc_cCab)

        IF loc_nRep = 0
            DIMENSION loc_aOpcoes[1]
            loc_aOpcoes[1] = loc_cCab
            RETURN loc_aOpcoes
        ENDIF

        DIMENSION loc_aOpcoes[loc_nRep]
        FOR loc_i = 1 TO loc_nRep
            loc_aOpcoes[loc_i] = SUBSTR(loc_cCab, ;
                IIF(loc_i = 1, 1, AT(";", loc_cCab, loc_i - 1) + 1), ;
                AT(";", loc_cCab, loc_i) - IIF(loc_i = 1, 0, AT(";", loc_cCab, loc_i - 1)) - 1)
        ENDFOR

        RETURN loc_aOpcoes
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION ObterMaxLength()
    *--------------------------------------------------------------------------
        IF THIS.this_nMaximo < THIS.this_nMinimo
            RETURN THIS.this_nMinimo
        ENDIF
        RETURN THIS.this_nMaximo
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cResposta
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *--------------------------------------------------------------------------
        LOCAL loc_lValido, loc_nValor
        loc_lValido = .T.
        THIS.this_cMensagemErro = ""

        IF THIS.this_cTipo # "M"
            IF THIS.this_cDado = "V"
                loc_nValor = VAL(TRANSFORM(THIS.this_cResposta))
                IF THIS.this_nMinimo > 0 AND loc_nValor < THIS.this_nMinimo
                    THIS.this_cMensagemErro = "Valor deve ser maior ou igual a " + TRANSFORM(THIS.this_nMinimo)
                    loc_lValido = .F.
                ENDIF
                IF loc_lValido AND THIS.this_nMaximo > 0 AND loc_nValor > THIS.this_nMaximo
                    THIS.this_cMensagemErro = "Valor deve ser menor ou igual a " + TRANSFORM(THIS.this_nMaximo)
                    loc_lValido = .F.
                ENDIF
            ELSE
                IF THIS.this_cDado # "D"
                IF THIS.this_nMinimo > 0 AND LEN(ALLTRIM(THIS.this_cResposta)) < THIS.this_nMinimo
                    THIS.this_cMensagemErro = "Informe ao menos " + TRANSFORM(THIS.this_nMinimo) + " caracteres."
                    loc_lValido = .F.
                ENDIF
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        *-- Dialogo utilitario sem tabela - sem mapeamento de cursor
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
    *--------------------------------------------------------------------------
        *-- Dialogo utilitario sem persistencia em banco - apenas valida resposta
        IF !THIS.ValidarDados()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
    *--------------------------------------------------------------------------
        *-- Dialogo utilitario sem persistencia em banco - apenas valida resposta
        IF !THIS.ValidarDados()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CapturarRespostaTexto(par_cValor)
    *--------------------------------------------------------------------------
        IF VARTYPE(par_cValor) = "C"
            THIS.this_cResposta = par_cValor
        ELSE
            IF VARTYPE(par_cValor) = "N"
            THIS.this_cResposta = TRANSFORM(par_cValor)
        ELSE
            IF VARTYPE(par_cValor) = "D"
            THIS.this_cResposta = DTOC(par_cValor)
        ELSE
            THIS.this_cResposta = ""
            ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CapturarRespostaCombo(par_cValor)
    *--------------------------------------------------------------------------
        THIS.this_cResposta = IIF(VARTYPE(par_cValor) = "C" AND !EMPTY(par_cValor), ;
                                  SUBSTR(par_cValor, 1, 1), "")
    ENDPROC

ENDDEFINE

