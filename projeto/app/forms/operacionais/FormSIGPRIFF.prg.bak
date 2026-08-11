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

    Caption         = "Form1"

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
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRIFFBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.ConfigurarDialogo( ;
                    THIS.this_cCabecalho, THIS.this_cTipo, THIS.this_cTitulo, ;
                    THIS.this_nMaximo, THIS.this_nMinimo, THIS.this_cDado)

                THIS.Caption = THIS.this_cTitulo

                THIS.ConfigurarPageFrame()

                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar SIGPRIFFBO", "Erro")
            ENDIF
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
    PROCEDURE AlternarPagina(par_nPagina)
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
