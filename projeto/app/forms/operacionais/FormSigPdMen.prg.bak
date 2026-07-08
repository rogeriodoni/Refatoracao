*==============================================================================
* FormSigPdMen.prg - Mensagens de Produto
* Tabela: SigCdMsg
* Baseado em: SIGPDMEN.SCX
* Tipo: OPERACIONAL (dialog modal simples, sem PageFrame)
*==============================================================================

DEFINE CLASS FormSigPdMen AS FormBase

    *-- Parametros de entrada
    this_cCidChave = ""
    this_cDescr1   = ""
    this_cDescr2   = ""
    this_lUsaDescr = .F.

    *-- Propriedades visuais (override FormBase)
    Width      = 800
    Height     = 270
    AutoCenter = .T.
    TitleBar   = 0
    ShowWindow = 1
    ControlBox = .F.
    MaxButton  = .F.
    MinButton  = .F.
    WindowType = 1
    Themes     = .F.
    Caption    = "Mensagens"

    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cCidChave, par_cDescr1, par_cDescr2)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChave = IIF(VARTYPE(par_cCidChave) = "C", ALLTRIM(par_cCidChave), "")
            THIS.this_cDescr1   = IIF(VARTYPE(par_cDescr1) = "C", par_cDescr1, "")
            THIS.this_cDescr2   = IIF(VARTYPE(par_cDescr2) = "C", par_cDescr2, "")
            THIS.this_lUsaDescr = (VARTYPE(par_cDescr1) = "C")

            THIS.this_oBusinessObject = CREATEOBJECT("SigPdMenBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lSucesso = DODEFAULT()
            ELSE
                MsgErro("Erro ao criar Business Object de Mensagens.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarShape()
            THIS.ConfigurarLabel2()
            THIS.ConfigurarContainer()
            THIS.ConfigurarBotaoOk()

            THIS.TornarControlesVisiveis(THIS)

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.CarregarMensagem()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Form OPERACIONAL plano (sem PageFrame):
    * aplica propriedades de form (BackColor, fontes, ShowTips) equivalentes
    * ao container raiz do dialog do legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.BackColor  = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *--------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Cadastro de Testes"
            .Height    = 40
            .Left      = 10
            .Top       = 18
            .Width     = 769
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Cadastro de Testes"
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = 769
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShape()
    *--------------------------------------------------------------------------
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 691
            .Height      = 110
            .Width       = 90
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLabel2()
    *--------------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "[ Texto ]"
            .Height    = 15
            .Left      = 376
            .Top       = 90
            .Width     = 51
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainer()
    *--------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Container1", "Container")
        WITH THIS.cnt_4c_Container1
            .Top           = 108
            .Left          = 123
            .Width         = 554
            .Height        = 150
            .SpecialEffect = 1
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Container1.AddObject("obj_4c_GetMemo", "EditBox")
        WITH THIS.cnt_4c_Container1.obj_4c_GetMemo
            .BorderStyle = 0
            .Height      = 140
            .Left        = 6
            .ReadOnly    = .T.
            .ScrollBars  = 0
            .Top         = 5
            .Width       = 541
            .BackColor   = RGB(212, 208, 200)
            .Visible     = .F.
        ENDWITH

        THIS.cnt_4c_Container1.AddObject("lbl_4c_Gettexto", "Label")
        WITH THIS.cnt_4c_Container1.lbl_4c_Gettexto
            .WordWrap  = .T.
            .Alignment = 2
            .Caption   = ""
            .Height    = 123
            .Left      = 8
            .Top       = 8
            .Width     = 520
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoOk()
    *--------------------------------------------------------------------------
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top           = 3
            .Left          = 725
            .Width         = 75
            .Height        = 75
            .Caption       = "OK"
            .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName      = "Tahoma"
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect = 0
            .MousePointer  = 15
            .WordWrap      = .T.
            .PicturePosition = 13
            .Visible       = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarMensagem()
    *--------------------------------------------------------------------------
        LOCAL loc_cCaption, loc_cCaptionA, loc_cCaptionB

        IF EMPTY(THIS.this_cCidChave)
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.BuscarMensagem(THIS.this_cCidChave)
            RETURN
        ENDIF

        loc_cCaptionA = IIF(THIS.this_lUsaDescr, ;
                            THIS.this_cDescr1, ;
                            THIS.this_oBusinessObject.this_cLinha1s)
        loc_cCaptionB = IIF(THIS.this_lUsaDescr, ;
                            THIS.this_cDescr2, ;
                            THIS.this_oBusinessObject.this_cLinha2s)

        loc_cCaption = "Mensagem da Empresa: " + ;
                       THIS.this_oBusinessObject.this_cEmps + ;
                       " para o Produto : " + ;
                       THIS.this_oBusinessObject.this_cCpros

        THIS.Caption = loc_cCaption
        THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = loc_cCaption
        THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = loc_cCaption

        *-- BO usa ALLTRIM ao carregar: "I " -> "I", "B " -> "B", "BI" permanece
        LOCAL loc_cEstilos
        loc_cEstilos = ALLTRIM(THIS.this_oBusinessObject.this_cEstilos)

        IF THIS.this_lUsaDescr
            THIS.cnt_4c_Container1.lbl_4c_Gettexto.Visible = .F.
            WITH THIS.cnt_4c_Container1.obj_4c_GetMemo
                .Visible    = .T.
                .Value      = ALLTRIM(loc_cCaptionA + loc_cCaptionB)
                .FontName   = ALLTRIM(THIS.this_oBusinessObject.this_cFontes)
                .FontSize   = THIS.this_oBusinessObject.this_nTamanhos
                .ForeColor  = THIS.this_oBusinessObject.this_nCors
                .FontBold   = .F.
                .FontItalic = .F.
                IF INLIST(loc_cEstilos, "I", "BI")
                    .FontItalic = .T.
                ENDIF
                IF INLIST(loc_cEstilos, "B", "BI")
                    .FontBold = .T.
                ENDIF
            ENDWITH
            THIS.cmd_4c_Ok.SetFocus()
        ELSE
            WITH THIS.cnt_4c_Container1.lbl_4c_Gettexto
                .Caption    = ALLTRIM(loc_cCaptionA + loc_cCaptionB)
                .FontName   = ALLTRIM(THIS.this_oBusinessObject.this_cFontes)
                .FontSize   = THIS.this_oBusinessObject.this_nTamanhos
                .ForeColor  = THIS.this_oBusinessObject.this_nCors
                .FontBold   = .F.
                .FontItalic = .F.
                IF INLIST(loc_cEstilos, "I", "BI")
                    .FontItalic = .T.
                ENDIF
                IF INLIST(loc_cEstilos, "B", "BI")
                    .FontBold = .T.
                ENDIF
            ENDWITH
        ENDIF

        THIS.cnt_4c_Container1.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdOkClick - Handler do botao OK
    * Fecha o form se pressionado via mouse; exibe aviso se via ENTER
    *--------------------------------------------------------------------------
    PROCEDURE CmdOkClick()
        IF LASTKEY() # 13
            THIS.Release()
        ELSE
            MsgInfo("Click No Bot" + CHR(227) + "o Ok Para Sair", "")
            CLEAR TYPEAHEAD
            KEYBOARD CHR(27)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *--------------------------------------------------------------------------
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                *-- Controles ocultos por design: CarregarMensagem decide visibilidade
                IF INLIST(UPPER(loc_oObjeto.Name), "OBJ_4C_GETMEMO", "CNT_4C_SOMBRA")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adaptador para forms OPERACIONAIS planos
    *
    * SIGPDMEN eh um dialog modal de exibicao de mensagem (sem PageFrame e
    * sem Page1/Lista). Nao ha grade nem botoes CRUD ??? a "lista" equivale
    * ao conteudo da mensagem renderizado dentro de cnt_4c_Container1.
    *
    * Este metodo expoe a assinatura usada por callers genericos para
    * "recarregar a lista": forca a re-carga da mensagem corrente a partir
    * do banco (SigCdMsg) atraves do BO ja instanciado, mantendo coerencia
    * com a UI original do SCX legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        IF EMPTY(THIS.this_cCidChave)
            RETURN
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") == "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        THIS.CarregarMensagem()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adaptador para forms OPERACIONAIS planos
    *
    * SIGPDMEN eh um dialog modal de exibicao de mensagem (sem PageFrame e
    * sem Page2/Dados). Nao ha campos editaveis nem botoes Salvar/Cancelar.
    *
    * Este metodo expoe a assinatura usada por callers genericos que esperam
    * a interface FormBase (ConfigurarPaginaDados). Para este form, toda a
    * configuracao de controles ja foi feita em ConfigurarContainer(),
    * ConfigurarBotaoOk() e ConfigurarCabecalho(), invocados por InicializarForm().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
            THIS.cnt_4c_Container1.Visible = .T.
            THIS.cnt_4c_Container1.Refresh()
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
            THIS.cmd_4c_Ok.Visible = .T.
            THIS.cmd_4c_Ok.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Adaptador para forms OPERACIONAIS planos
    *
    * Forms OPERACIONAIS planos nao tem PageFrame para alternar entre
    * Page1 (Lista) e Page2 (Dados). SIGPDMEN exibe somente o painel de
    * mensagem e o botao OK.
    *
    * Este metodo expoe a assinatura usada por callers genericos:
    *   - par_nPagina = 1 (Lista)  -> garante container visivel e refresh
    *   - par_nPagina = 2 (Dados) -> idem (mesma area visual)
    * O foco eh sempre devolvido ao botao OK (unico controle interativo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
            THIS.cnt_4c_Container1.Visible = .T.
            THIS.cnt_4c_Container1.Refresh()
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Ok", 5) AND THIS.cmd_4c_Ok.Visible
            THIS.cmd_4c_Ok.SetFocus()
        ENDIF

        RETURN loc_nPagina
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick / BtnAlterarClick / BtnVisualizarClick / BtnExcluirClick
    *
    * SIGPDMEN eh um dialog de exibicao de mensagem (read-only, sem CRUD).
    * Estes metodos existem para satisfazer a interface FormBase; o form
    * nao expoe botoes CRUD nem suporta operacoes de escrita no banco.
    * FormBase pode acionar estes handlers via teclas F2-F5 herdadas; o
    * comportamento correto neste contexto eh fechar o dialog (acao
    * equivalente ao botao OK, unico controle interativo disponivel).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick / BtnEncerrarClick
    *
    * Adapters para interface FormBase: SIGPDMEN eh dialog somente-leitura.
    * Qualquer acao de "fechar" equivale a clicar OK.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick / BtnCancelarClick
    *
    * SIGPDMEN nao tem campos editaveis nem botoes Salvar/Cancelar.
    * Fechar o dialog e a unica acao valida.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega mensagem do banco e atualiza exibicao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF TYPE("gb_4c_ValidandoUI") == "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF
        IF !EMPTY(THIS.this_cCidChave) AND VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.CarregarMensagem()
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - SIGPDMEN e somente-leitura; CidChave ja esta no BO via Init
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza exibicao a partir do BO carregado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        THIS.CarregarMensagem()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Dialog somente-leitura; nenhum campo e editavel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
            THIS.cmd_4c_Ok.Enabled = loc_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa exibicao do painel de mensagem
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
            IF PEMSTATUS(THIS.cnt_4c_Container1, "lbl_4c_Gettexto", 5)
                THIS.cnt_4c_Container1.lbl_4c_Gettexto.Caption = ""
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Container1, "obj_4c_GetMemo", 5)
                THIS.cnt_4c_Container1.obj_4c_GetMemo.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Dialog sem botoes CRUD; nada a ajustar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
            THIS.cmd_4c_Ok.Visible = .T.
            THIS.cmd_4c_Ok.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE
