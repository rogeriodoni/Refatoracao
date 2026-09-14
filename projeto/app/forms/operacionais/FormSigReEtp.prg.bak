*===============================================================================
* FormSigReEtp.prg - Impressao de Etiquetas de Operacoes
* Migrado de SIGREETP.SCX (form OPERACIONAL)
* Recebe par_cDopes (codigo da operacao) via Init().
*===============================================================================
DEFINE CLASS FormSigReEtp AS FormBase

    DataSession = 2
    ShowWindow = 1
    Width       = 466
    Height      = 340
    AutoCenter  = .T.
    TitleBar    = 0
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    WindowType  = 1
    Themes      = .F.
    BorderStyle = 2

    this_oBusinessObject = .NULL.
    this_cDopes          = ""

    *---------------------------------------------------------------------------
    PROCEDURE Init(par_cDopes)
    *---------------------------------------------------------------------------
        IF VARTYPE(par_cDopes) = "C"
            THIS.this_cDopes = PADR(par_cDopes, 20)
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigReEtpBO")
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.CarregarConfiguracoes()
                THIS.AlternarPagina(1)
            ENDIF

            THIS.TornarControlesVisiveis(THIS)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ConfigurarPageFrame - Layout-level do form (OPERACIONAL nao tem PageFrame)
    *
    * SIGREETP eh um dialog OPERACIONAL pequeno (466x340) que imprime etiquetas
    * de operacao. O original NAO possui PageFrame; os controles ficam direto
    * no Form. Este metodo aplica a configuracao visual base (header escuro
    * cntSombra + shapes de agrupamento) que em forms CRUD seria delegada ao
    * PageFrame.Page1/Page2.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *---------------------------------------------------------------------------
        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        THIS.Caption = "Impress" + CHR(227) + "o de Etiquetas de Opera" + CHR(231) + CHR(245) + "es"

        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0,0,0)
            .WordWrap  = .T.
            .Caption   = "Cadastro de Testes"
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255,255,255)
            .WordWrap  = .T.
            .Caption   = "Cadastro de Testes"
        ENDWITH

        THIS.AddObject("shp_4c_ShpNotas", "Shape")
        WITH THIS.shp_4c_ShpNotas
            .Top           = 92
            .Left          = 26
            .Height        = 67
            .Width         = 271
            .BackStyle     = 0
            .Curvature     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90,90,90)
        ENDWITH

        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 174
            .Left          = 301
            .Height        = 96
            .Width         = 138
            .BackStyle     = 0
            .Curvature     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90,90,90)
        ENDWITH
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *---------------------------------------------------------------------------
        LOCAL loc_i, loc_oControl, loc_p

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_p = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *---------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria spinners de ajuste e o CommandGroup do dialog
    *
    * Form OPERACIONAL sem PageFrame: este metodo cria os controles de ajuste
    * (Densidade/Horizontal/Vertical) e o CommandGroup (Imprimir/Encerrar).
    * Os controles de selecao (Quantidade, Tipo, Impressora) ficam em
    * ConfigurarPaginaDados(), chamado sequencialmente em InicializarForm().
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *---------------------------------------------------------------------------
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Densidade :"
                .Left      = 320
                .Top       = 186
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("obj_4c_SpnDensidade", "Spinner")
            WITH THIS.obj_4c_SpnDensidade
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Height            = 26
                .KeyboardHighValue = 20
                .KeyboardLowValue  = 10
                .Left              = 381
                .SpinnerHighValue  = 20
                .SpinnerLowValue   = 0
                .Top               = 181
                .Width             = 56
                .ForeColor         = RGB(0,0,0)
                .Value             = 20
            ENDWITH

            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Horizontal :"
                .Left      = 322
                .Top       = 214
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("obj_4c_SpnHorizontal", "Spinner")
            WITH THIS.obj_4c_SpnHorizontal
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Height            = 26
                .KeyboardHighValue = 999
                .KeyboardLowValue  = 0
                .Left              = 381
                .SpinnerHighValue  = 999
                .SpinnerLowValue   = 0
                .Top               = 209
                .Width             = 56
                .ForeColor         = RGB(0,0,0)
                .Value             = 0
            ENDWITH

            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Vertical :"
                .Left      = 335
                .Top       = 242
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("obj_4c_SpnVertical", "Spinner")
            WITH THIS.obj_4c_SpnVertical
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Height            = 26
                .KeyboardHighValue = 999
                .KeyboardLowValue  = 0
                .Left              = 381
                .SpinnerHighValue  = 999
                .SpinnerLowValue   = 0
                .Top               = 237
                .Width             = 56
                .ForeColor         = RGB(0,0,0)
                .Value             = 0
            ENDWITH

            THIS.AddObject("obj_4c_CmdBtnForm", "CommandGroup")
            WITH THIS.obj_4c_CmdBtnForm
                .AutoSize      = .F.
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 1
                .Height        = 85
                .Left          = 311
                .SpecialEffect = 1
                .Top           = -2
                .Width         = 160
                .BorderColor   = RGB(136,189,188)
                .Themes        = .F.
            ENDWITH

            WITH THIS.obj_4c_CmdBtnForm.Buttons(1)
                .Top        = 5
                .Left       = 5
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .Caption    = "\<Imprimir"
                .ForeColor  = RGB(90,90,90)
                .BackColor  = RGB(255,255,255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
            ENDWITH

            WITH THIS.obj_4c_CmdBtnForm.Buttons(2)
                .Top        = 5
                .Left       = 80
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90,90,90)
                .BackColor  = RGB(255,255,255)
                .Themes     = .F.
                .Cancel     = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            ENDWITH

            BINDEVENT(THIS.obj_4c_CmdBtnForm.Buttons(1), "Click", THIS, "BtnImprimirClick")
            BINDEVENT(THIS.obj_4c_CmdBtnForm.Buttons(2), "Click", THIS, "BtnEncerrarClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *---------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria os controles de selecao do dialog
    *
    * Cria todos os controles de entrada de dados do dialog de impressao:
    *   - Quantidade (label + textbox)
    *   - Tipo de etiqueta (label + combobox)
    *   - Selecione Impressora (label + optiongroup com botao padrao)
    * Os controles de ajuste (Densidade/Horizontal/Vertical) ficam em
    * ConfigurarPaginaLista(). Sem lookups - form OPERACIONAL sem F4/F5.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *---------------------------------------------------------------------------
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Quantidade :"
                .Left      = 44
                .Top       = 103
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("txt_4c_Qtde", "TextBox")
            WITH THIS.txt_4c_Qtde
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 3
                .Value     = 1
                .Height    = 25
                .InputMask = "9999"
                .Left      = 111
                .Top       = 99
                .Width     = 38
                .ForeColor = RGB(0,0,0)
            ENDWITH

            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Tipo :"
                .Left      = 41
                .Top       = 132
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("cbo_4c_CmbTipos", "ComboBox")
            WITH THIS.cbo_4c_CmbTipos
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Height    = 25
                .Left      = 72
                .Style     = 2
                .Top       = 128
                .Width     = 220
                .ForeColor = RGB(0,0,0)
            ENDWITH

            THIS.AddObject("lbl_4c_LblImpressora", "Label")
            WITH THIS.lbl_4c_LblImpressora
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = " Selecione Impressora"
                .Height    = 15
                .Left      = 27
                .Top       = 161
                .Width     = 107
                .ForeColor = RGB(90,90,90)
            ENDWITH

            THIS.AddObject("obj_4c_OptImpressora", "OptionGroup")
            WITH THIS.obj_4c_OptImpressora
                .AutoSize      = .F.
                .ButtonCount   = 1
                .BackStyle     = 0
                .Value         = 1
                .Height        = 156
                .Left          = 27
                .SpecialEffect = 1
                .Top           = 174
                .Width         = 276
                .BorderColor   = RGB(90,90,90)
            ENDWITH

            WITH THIS.obj_4c_OptImpressora.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "\<1. Gen" + CHR(233) + "rico/Somente Texto"
                .Value     = 1
                .Height    = 17
                .Left      = 4
                .Style     = 0
                .Top       = 10
                .Width     = 262
                .ForeColor = RGB(90,90,90)
            ENDWITH

            BINDEVENT(THIS.obj_4c_OptImpressora, "InteractiveChange", THIS, "OptImpressoraInteractiveChange")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarConfiguracoes()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nImpres, loc_nI, loc_nMaxBtn
        LOCAL loc_nTop, loc_nHeight, loc_cNomeImp

        loc_lSucesso = .F.

        TRY
            IF !THIS.this_oBusinessObject.CarregarDados(THIS.this_cDopes)
                MsgErro("Falha ao carregar configura" + CHR(231) + CHR(227) + "o.", "Erro")
            ELSE
                THIS.obj_4c_SpnVertical.Value   = THIS.this_oBusinessObject.this_nAjVerts
                THIS.obj_4c_SpnHorizontal.Value = THIS.this_oBusinessObject.this_nAjHorzs

                loc_nImpres = THIS.this_oBusinessObject.CarregarImpressoras()

                IF USED("cursor_4c_Impressoras") AND loc_nImpres > 0
                    loc_nMaxBtn = MAX(THIS.this_oBusinessObject.this_nMaxImpEti, 7)
                    loc_nMaxBtn = MIN(loc_nImpres, loc_nMaxBtn)
                    loc_nMaxBtn = MAX(loc_nMaxBtn, 1)

                    THIS.obj_4c_OptImpressora.ButtonCount = loc_nMaxBtn

                    loc_nTop    = 10
                    loc_nHeight = 15

                    SELECT cursor_4c_Impressoras
                    GOTO TOP
                    FOR loc_nI = 1 TO loc_nMaxBtn
                        IF !EOF("cursor_4c_Impressoras")
                            loc_cNomeImp = ALLTRIM(NVL(cursor_4c_Impressoras.NomeImp, ""))
                            WITH THIS.obj_4c_OptImpressora.Buttons(loc_nI)
                                .AutoSize  = .F.
                                .Caption   = " \<" + TRANSFORM(loc_nI) + ". " + loc_cNomeImp
                                .FontSize  = 8
                                .FontName  = "Tahoma"
                                .BackStyle = 0
                                .ForeColor = RGB(90,90,90)
                                .Tag       = UPPER(loc_cNomeImp)
                                .Top       = loc_nTop
                                .Width     = 180
                                .Height    = 17
                            ENDWITH
                            SKIP IN cursor_4c_Impressoras
                            loc_nTop    = loc_nTop + 20
                            loc_nHeight = loc_nHeight + 20
                        ENDIF
                    ENDFOR

                    THIS.obj_4c_OptImpressora.Height  = loc_nHeight
                    THIS.obj_4c_OptImpressora.Enabled = (loc_nImpres > 1)

                    IF USED("cursor_4c_Impressoras")
                        USE IN cursor_4c_Impressoras
                    ENDIF
                ELSE
                    THIS.obj_4c_OptImpressora.ButtonCount = 1
                    WITH THIS.obj_4c_OptImpressora.Buttons(1)
                        .Caption   = " \<0. Gen" + CHR(233) + "rico/Somente Texto"
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .BackStyle = 0
                        .ForeColor = RGB(90,90,90)
                        .Tag       = "GEN" + CHR(201) + "RICO/SOMENTE TEXTO"
                        .Top       = 10
                        .Width     = 180
                        .Height    = 17
                    ENDWITH
                    THIS.obj_4c_OptImpressora.Height  = 35
                    THIS.obj_4c_OptImpressora.Enabled = .F.
                ENDIF

                THIS.cbo_4c_CmbTipos.Clear()
                THIS.cbo_4c_CmbTipos.AddItem("4 Colunas Vertical Simples")
                THIS.cbo_4c_CmbTipos.AddItem("4 Colunas Vertical Dupla  ")
                THIS.cbo_4c_CmbTipos.AddItem("2 Colunas Horizontal      ")
                THIS.cbo_4c_CmbTipos.ListIndex = 1

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
    *---------------------------------------------------------------------------
        LOCAL loc_oBO, loc_lImprimiu, loc_oErro

        loc_oBO       = THIS.this_oBusinessObject
        loc_lImprimiu = .F.

        TRY
            loc_oBO.this_nQtd = INT(THIS.txt_4c_Qtde.Value)
            loc_oBO.this_nDen = INT(THIS.obj_4c_SpnDensidade.Value)
            loc_oBO.this_nHor = INT(THIS.obj_4c_SpnHorizontal.Value)
            loc_oBO.this_nVer = INT(THIS.obj_4c_SpnVertical.Value)
            loc_oBO.this_cImp = UPPER(ALLTRIM(THIS.obj_4c_OptImpressora.Buttons(THIS.obj_4c_OptImpressora.Value).Tag))
            loc_oBO.this_cTip = PADL(THIS.cbo_4c_CmbTipos.ListIndex, 2, "0")

            loc_lImprimiu = loc_oBO.Imprimir(THIS.this_cDopes)
            IF loc_lImprimiu
                loc_oBO.Inserir()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnIncluirClick - Nova impressao: dispara o fluxo de impressao do dialog
    *
    * Em forms OPERACIONAIS de impressao, "incluir" significa gerar uma nova
    * sequencia de etiquetas - delega para o fluxo principal de impressao.
    *---------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnAlterarClick - Permite ajustar parametros de impressao
    *
    * Recarrega os ajustes padrao da impressora selecionada e devolve o foco
    * ao campo Quantidade para o usuario revisar/alterar a configuracao.
    *---------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) = "O"
            THIS.obj_4c_SpnVertical.Value   = loc_oBO.this_nAjVerts
            THIS.obj_4c_SpnHorizontal.Value = loc_oBO.this_nAjHorzs
        ENDIF

        IF VARTYPE(THIS.txt_4c_Qtde) = "O" AND PEMSTATUS(THIS.txt_4c_Qtde, "SetFocus", 5)
            THIS.txt_4c_Qtde.SetFocus()
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnVisualizarClick - Recarrega configuracoes para revisao
    *
    * Dialog de impressao via Set Device To Printer nao suporta preview de
    * tela. Recarrega parametros de SigCdPam e a contagem de impressoras
    * disponiveis para que o usuario revise o setup atual antes de imprimir.
    *---------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !EMPTY(THIS.this_cDopes)
            THIS.CarregarConfiguracoes()
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnExcluirClick - Cancela o dialog sem imprimir
    *
    * Em dialog OPERACIONAL de impressao, "excluir" significa abandonar a
    * configuracao corrente sem gerar etiquetas (equivalente a Encerrar).
    *---------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.Release()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
    *---------------------------------------------------------------------------
        THIS.Release()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE OptImpressoraInteractiveChange()
    *---------------------------------------------------------------------------
        THIS.obj_4c_SpnVertical.Value   = THIS.this_oBusinessObject.this_nAjVerts
        THIS.obj_4c_SpnHorizontal.Value = THIS.this_oBusinessObject.this_nAjHorzs
    ENDPROC

    *---------------------------------------------------------------------------
    * AlternarPagina - Sincroniza estado dos controles para o dialog de impressao
    *
    * Form OPERACIONAL: NAO possui PageFrame com Page1=Lista/Page2=Dados, entao
    * este metodo eh repurposed para garantir foco/estado consistentes apos
    * carregar configuracoes ou trocar de impressora (par_nPagina = 1).
    *---------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oBO, loc_nQtdImp

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        DO CASE
            CASE par_nPagina = 1
                IF VARTYPE(THIS.obj_4c_OptImpressora) = "O"
                    loc_nQtdImp = THIS.obj_4c_OptImpressora.ButtonCount
                    THIS.obj_4c_OptImpressora.Enabled = (loc_nQtdImp > 1)
                ENDIF

                IF VARTYPE(THIS.obj_4c_SpnVertical) = "O" AND VARTYPE(THIS.obj_4c_SpnHorizontal) = "O"
                    THIS.obj_4c_SpnVertical.Value   = loc_oBO.this_nAjVerts
                    THIS.obj_4c_SpnHorizontal.Value = loc_oBO.this_nAjHorzs
                ENDIF

                IF VARTYPE(THIS.txt_4c_Qtde) = "O" AND PEMSTATUS(THIS.txt_4c_Qtde, "SetFocus", 5)
                    THIS.txt_4c_Qtde.SetFocus()
                ENDIF
        ENDCASE
    ENDPROC

    *---------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos controles para o Business Object
    *---------------------------------------------------------------------------
    PROCEDURE FormParaBO()
    *---------------------------------------------------------------------------
        LOCAL loc_oBO, loc_oErro

        loc_oBO = THIS.this_oBusinessObject

        TRY
            loc_oBO.this_nQtd = INT(THIS.txt_4c_Qtde.Value)
            loc_oBO.this_nDen = INT(THIS.obj_4c_SpnDensidade.Value)
            loc_oBO.this_nHor = INT(THIS.obj_4c_SpnHorizontal.Value)
            loc_oBO.this_nVer = INT(THIS.obj_4c_SpnVertical.Value)
            loc_oBO.this_cTip = PADL(THIS.cbo_4c_CmbTipos.ListIndex, 2, "0")

            IF THIS.obj_4c_OptImpressora.ButtonCount >= THIS.obj_4c_OptImpressora.Value AND ;
               THIS.obj_4c_OptImpressora.Value >= 1
                loc_oBO.this_cImp = UPPER(ALLTRIM(THIS.obj_4c_OptImpressora.Buttons(THIS.obj_4c_OptImpressora.Value).Tag))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *---------------------------------------------------------------------------
    * BOParaForm - Transfere propriedades do Business Object para os controles
    *---------------------------------------------------------------------------
    PROCEDURE BOParaForm()
    *---------------------------------------------------------------------------
        LOCAL loc_oBO, loc_nTip, loc_oErro

        loc_oBO = THIS.this_oBusinessObject

        TRY
            THIS.txt_4c_Qtde.Value          = loc_oBO.this_nQtd
            THIS.obj_4c_SpnDensidade.Value  = loc_oBO.this_nDen
            THIS.obj_4c_SpnHorizontal.Value = loc_oBO.this_nHor
            THIS.obj_4c_SpnVertical.Value   = loc_oBO.this_nVer

            loc_nTip = VAL(ALLTRIM(loc_oBO.this_cTip))
            IF loc_nTip >= 1 AND loc_nTip <= THIS.cbo_4c_CmbTipos.ListCount
                THIS.cbo_4c_CmbTipos.ListIndex = loc_nTip
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *---------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os controles de entrada do dialog
    *---------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
    *---------------------------------------------------------------------------
        LOCAL loc_lHabilitar

        loc_lHabilitar = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)

        THIS.txt_4c_Qtde.Enabled          = loc_lHabilitar
        THIS.cbo_4c_CmbTipos.Enabled      = loc_lHabilitar
        THIS.obj_4c_SpnDensidade.Enabled  = loc_lHabilitar
        THIS.obj_4c_SpnHorizontal.Enabled = loc_lHabilitar
        THIS.obj_4c_SpnVertical.Enabled   = loc_lHabilitar

        IF VARTYPE(THIS.obj_4c_OptImpressora) = "O"
            THIS.obj_4c_OptImpressora.Enabled = loc_lHabilitar AND ;
                                                (THIS.obj_4c_OptImpressora.ButtonCount > 1)
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    * LimparCampos - Restaura os controles para os valores iniciais
    *---------------------------------------------------------------------------
    PROCEDURE LimparCampos()
    *---------------------------------------------------------------------------
        THIS.txt_4c_Qtde.Value           = 1
        THIS.obj_4c_SpnDensidade.Value   = 20
        THIS.obj_4c_SpnHorizontal.Value  = 0
        THIS.obj_4c_SpnVertical.Value    = 0
        THIS.cbo_4c_CmbTipos.ListIndex   = 1
        THIS.obj_4c_OptImpressora.Value  = 1
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarLista - Em form OPERACIONAL: recarrega configuracoes de impressao
    *---------------------------------------------------------------------------
    PROCEDURE CarregarLista()
    *---------------------------------------------------------------------------
        IF !EMPTY(ALLTRIM(THIS.this_cDopes))
            THIS.CarregarConfiguracoes()
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    * AjustarBotoesPorModo - Gerencia estado dos botoes do dialog
    *
    * Form OPERACIONAL: habilita Imprimir apenas quando ha impressoras disponiveis.
    * Encerrar permanece sempre habilitado.
    *---------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
    *---------------------------------------------------------------------------
        LOCAL loc_lTemImpressora

        loc_lTemImpressora = .F.
        IF VARTYPE(THIS.obj_4c_OptImpressora) = "O"
            loc_lTemImpressora = (THIS.obj_4c_OptImpressora.ButtonCount >= 1)
        ENDIF

        IF VARTYPE(THIS.obj_4c_CmdBtnForm) = "O"
            THIS.obj_4c_CmdBtnForm.Buttons(1).Enabled = loc_lTemImpressora
            THIS.obj_4c_CmdBtnForm.Buttons(2).Enabled = .T.
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega configuracoes de impressao (busca parametros)
    *---------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
    *---------------------------------------------------------------------------
        IF !EMPTY(ALLTRIM(THIS.this_cDopes))
            THIS.CarregarConfiguracoes()
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnSalvarClick - Em form OPERACIONAL de impressao: confirma e imprime
    *---------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
    *---------------------------------------------------------------------------
        THIS.BtnImprimirClick()
    ENDPROC

    *---------------------------------------------------------------------------
    * BtnCancelarClick - Cancela o dialog sem imprimir
    *---------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
    *---------------------------------------------------------------------------
        THIS.Release()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE Destroy()
    *---------------------------------------------------------------------------
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
