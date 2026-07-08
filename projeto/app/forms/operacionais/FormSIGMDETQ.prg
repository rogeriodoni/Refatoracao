*------------------------------------------------------------------------------
* FormSIGMDETQ.prg - Form Operacional: Muda Cor/Tamanho de Etiqueta
* Herda de FormBase
* Migrado de SIGMDETQ.SCX
* Tabela: SigOpEtq / SigMvCab / SigMvHst
*------------------------------------------------------------------------------
DEFINE CLASS FormSIGMDETQ AS FormBase

    *-- Propriedades visuais identicas ao original SIGMDETQ.SCX
    this_cMensagemErro = ""
    Height      = 204
    Width       = 718
    BorderStyle = 2
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Caption     = "Muda Cor / Tamanho Etiqueta"
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGMDETQBO")

            THIS.Picture = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"

            IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
                *-- Modo teste automatizado: pular verificacoes de banco
                loc_lContinuar = .T.
            ELSE
                IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lContinuar = .T.
            ELSE
                IF gnConnHandle <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
                        "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
                loc_lContinuar = .F.
                ENDIF
                ENDIF
            ENDIF

            *-- DopCorTam obrigatorio para abertura do form (igual ao legado)
            IF loc_lContinuar
                IF (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste) AND ;
                   (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                    IF !THIS.this_oBusinessObject.CarregarParametros()
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.TornarControlesVisiveis()
                THIS.ConfigurarBINDEVENTs()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi o "frame" visual do form operacional:
    * cntSombra (cabecalho cinza) com labels de titulo.
    * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo agrupa a
    * estrutura fixa do topo (equivalente ao "frame" da tela).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .Top           = 18
                .Left          = 10
                .Width         = THIS.Width
                .Height        = 40
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .BackStyle     = 0
                .WordWrap      = .T.
                .Alignment     = 0
                .ForeColor     = RGB(0, 0, 0)
                .Caption       = "Muda Cor / Tamanho Etiqueta"
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .WordWrap  = .T.
                .Alignment = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = "Muda Cor / Tamanho Etiqueta"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Agrega botoes e campos do form OPERACIONAL.
    * Forms OPERACIONAIS nao tem PageFrame CRUD; este metodo unifica a
    * configuracao da "pagina unica" (equivalente logico da Page1 Lista)
    * para manter compatibilidade com o pipeline multi-fase.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Reinicia o fluxo do form limpando campos de entrada,
    * resetando o BO e posicionando o foco no campo inicial (Codigo de Barras).
    * Forms OPERACIONAIS nao possuem PageFrame; "alternar para pagina 1" equivale
    * a preparar o form para uma nova operacao do zero.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oErro

        TRY
            IF PEMSTATUS(THIS, "txt_4c_Barras", 5)
                THIS.txt_4c_Barras.Value = ""
                THIS.txt_4c_CorAnt.Value = ""
                THIS.txt_4c_TamAnt.Value = ""
                THIS.txt_4c_CorNew.Value = ""
                THIS.txt_4c_TamNew.Value = ""

                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.this_nCodBarras = 0
                    THIS.this_oBusinessObject.this_cCPros     = ""
                    THIS.this_oBusinessObject.this_cCorAnt    = ""
                    THIS.this_oBusinessObject.this_cTamAnt    = ""
                    THIS.this_oBusinessObject.this_cCorNew    = ""
                    THIS.this_oBusinessObject.this_cTamNew    = ""
                ENDIF

                THIS.txt_4c_Barras.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Botoes Processar e Cancelar
    * Posicoes absolutas derivadas do CommandGroup original (Left=562, Top=-2):
    *   Processar (Command2): Left=562+5=567, Top=-2+5=3
    *   Cancelar  (Command1): Left=562+80=642, Top=-2+5=3
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 567
            .Height          = 75
            .Width           = 75
            .Caption         = "\<Processar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .Themes           = .T.
            .MousePointer    = 15
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoBase + "Framework\imagens\geral_configuracao_60.jpg"
            .ToolTipText     = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
        ENDWITH

        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top             = 3
            .Left            = 642
            .Height          = 75
            .Width           = 75
            .Caption         = "\<Cancelar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .Themes           = .T.
            .MousePointer    = 15
            .Cancel          = .T.
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoBase + "Framework\imagens\cadastro_sair_60.jpg"
            .ToolTipText     = "[Esc] Encerrar"
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles de nivel raiz do form
    * cnt_4c_Sombra ja tem Visible=.T. definido em ConfigurarCabecalho
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oCtrl
        FOR EACH loc_oCtrl IN THIS.Controls
            IF VARTYPE(loc_oCtrl) = "O"
                loc_oCtrl.Visible = .T.
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Vincula eventos dos botoes principais
    * Eventos dos campos de entrada sao vinculados em fases posteriores
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
        BINDEVENT(THIS.txt_4c_Barras, "KeyPress",          THIS, "TxtBarrasKeyPress")
        BINDEVENT(THIS.txt_4c_Barras, "InteractiveChange", THIS, "TxtBarrasInteractiveChange")
        BINDEVENT(THIS.txt_4c_CorNew, "KeyPress",          THIS, "TxtCorNewKeyPress")
        BINDEVENT(THIS.txt_4c_TamNew, "KeyPress",          THIS, "TxtTamNewKeyPress")
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Encerra o formulario
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Valida campos e chama ProcessarAlteracao no BO
    * Depende de txt_4c_Barras, txt_4c_CorNew, txt_4c_TamNew (criados na Fase 4)
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_nCodBarras, loc_lContinuar, loc_oErro
        loc_lContinuar = .T.

        TRY
            loc_nCodBarras = IIF(VARTYPE(THIS.txt_4c_Barras.Value) = "C", ;
                                 VAL(THIS.txt_4c_Barras.Value), ;
                                 THIS.txt_4c_Barras.Value)

            IF EMPTY(loc_nCodBarras)
                MsgAviso("Favor Informar o C" + CHR(243) + "digo de Barras.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF

            *-- Garante barras validado no banco antes de processar
            IF loc_lContinuar AND THIS.this_oBusinessObject.this_nCodBarras != loc_nCodBarras
                IF !THIS.ValidarBarras()
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                IF !MsgConfirma("Confirma a altera" + CHR(231) + CHR(227) + "o dos Dados do Barra?", ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.this_oBusinessObject.this_cCorNew = ALLTRIM(THIS.txt_4c_CorNew.Value)
                THIS.this_oBusinessObject.this_cTamNew = ALLTRIM(THIS.txt_4c_TamNew.Value)

                IF THIS.this_oBusinessObject.ProcessarAlteracao()
                    MsgInfo("Grava" + CHR(231) + CHR(227) + "o Realizada.", "Aviso")
                    THIS.AlternarPagina(1)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnProcessarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Cria shapes, labels e textboxes do formulario.
    * Forms OPERACIONAIS nao tem PageFrame CRUD; este metodo contem a
    * configuracao de campos de dados (equivalente logico da Page2 Dados)
    * para manter compatibilidade com o pipeline multi-fase.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Shape1: caixa ao redor do campo Codigo de Barra
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top       = 85
            .Left      = 28
            .Width     = 232
            .Height    = 31
            .BackStyle = 0
            .FillStyle = 1
        ENDWITH

        *-- Shape2: caixa externa Antigo+Novo
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top       = 118
            .Left      = 28
            .Width     = 399
            .Height    = 80
            .BackStyle = 0
            .FillStyle = 1
        ENDWITH

        *-- Shape4: caixa Antigo (metade esquerda)
        THIS.AddObject("shp_4c_Shape4", "Shape")
        WITH THIS.shp_4c_Shape4
            .Top       = 118
            .Left      = 28
            .Width     = 197
            .Height    = 80
            .BackStyle = 0
            .FillStyle = 1
        ENDWITH

        *-- Shape3: linha de header Antigo/Novo
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top       = 118
            .Left      = 28
            .Width     = 399
            .Height    = 24
            .BackStyle = 0
            .FillStyle = 1
        ENDWITH

        *-- lbl_4c_Say1: "Codigo de Barra :"
        THIS.AddObject("lbl_4c_Say1", "Label")
        WITH THIS.lbl_4c_Say1
            .Top       = 92
            .Left      = 56
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "C" + CHR(243) + "digo de \<Barra :"
        ENDWITH

        *-- lbl_4c_Label1: "Antigo" - FontBold + FontSize 10 conforme original
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top      = 122
            .Left     = 94
            .Width    = 45
            .Height   = 18
            .AutoSize = .T.
            .FontBold = .T.
            .FontName = "Tahoma"
            .FontSize = 10
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Antigo"
        ENDWITH

        *-- lbl_4c_Label2: "Novo" - FontBold + FontSize 10 conforme original
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top      = 122
            .Left     = 292
            .Width    = 34
            .Height   = 18
            .AutoSize = .T.
            .FontBold = .T.
            .FontName = "Tahoma"
            .FontSize = 10
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Novo"
        ENDWITH

        *-- lbl_4c_Label3: "Cor :" (Antigo)
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 150
            .Left      = 76
            .Width     = 26
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cor :"
        ENDWITH

        *-- lbl_4c_Label4: "Tamanho :" (Antigo)
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 174
            .Left      = 49
            .Width     = 53
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tamanho :"
        ENDWITH

        *-- lbl_4c_Label5: "Cor :" (Novo)
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 150
            .Left      = 272
            .Width     = 26
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cor :"
        ENDWITH

        *-- lbl_4c_Label6: "Tamanho :" (Novo)
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top       = 174
            .Left      = 245
            .Width     = 53
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tamanho :"
        ENDWITH

        *-- txt_4c_Barras: campo Codigo de Barra (numerico 14 digitos, seleciona ao focar)
        THIS.AddObject("txt_4c_Barras", "TextBox")
        WITH THIS.txt_4c_Barras
            .Top           = 89
            .Left          = 145
            .Width         = 108
            .Height        = 21
            .Value         = ""
            .Format        = "K"
            .InputMask     = "99999999999999"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- txt_4c_CorAnt: Cor Antigo (somente leitura - When retorna .F. no original)
        THIS.AddObject("txt_4c_CorAnt", "TextBox")
        WITH THIS.txt_4c_CorAnt
            .Top           = 147
            .Left          = 108
            .Width         = 73
            .Height        = 21
            .Value         = ""
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- txt_4c_TamAnt: Tamanho Antigo (somente leitura - When retorna .F. no original)
        THIS.AddObject("txt_4c_TamAnt", "TextBox")
        WITH THIS.txt_4c_TamAnt
            .Top           = 171
            .Left          = 108
            .Width         = 73
            .Height        = 21
            .Value         = ""
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- txt_4c_CorNew: Cor Novo (lookup SigCdCor via F4/ENTER/TAB, max 3 chars)
        THIS.AddObject("txt_4c_CorNew", "TextBox")
        WITH THIS.txt_4c_CorNew
            .Top           = 147
            .Left          = 304
            .Width         = 73
            .Height        = 21
            .Value         = ""
            .MaxLength     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH

        *-- txt_4c_TamNew: Tamanho Novo (lookup SigCdTam via F4/ENTER/TAB, max 3 chars)
        THIS.AddObject("txt_4c_TamNew", "TextBox")
        WITH THIS.txt_4c_TamNew
            .Top           = 171
            .Left          = 304
            .Width         = 73
            .Height        = 21
            .Value         = ""
            .MaxLength     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ValidarBarras - Busca etiqueta no banco e preenche campos Antigo
    * Retorna .T. se barras encontrado e valido
    *==========================================================================
    PROTECTED PROCEDURE ValidarBarras()
        LOCAL loc_nCodBarras, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_nCodBarras = IIF(VARTYPE(THIS.txt_4c_Barras.Value) = "C", ;
                                 VAL(THIS.txt_4c_Barras.Value), ;
                                 THIS.txt_4c_Barras.Value)

            IF !EMPTY(loc_nCodBarras)
                IF THIS.this_oBusinessObject.BuscarPorBarras(loc_nCodBarras)
                    THIS.txt_4c_CorAnt.Value = THIS.this_oBusinessObject.this_cCorAnt
                    THIS.txt_4c_TamAnt.Value = THIS.this_oBusinessObject.this_cTamAnt
                    THIS.txt_4c_CorNew.Value = ""
                    THIS.txt_4c_TamNew.Value = ""
                    THIS.txt_4c_CorNew.SetFocus()
                    loc_lSucesso = .T.
                ELSE
                    THIS.txt_4c_Barras.SetFocus()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ValidarBarras")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TxtBarrasKeyPress - Dispara ValidarBarras em ENTER (13) e TAB (9)
    *==========================================================================
    PROCEDURE TxtBarrasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarBarras()
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtBarrasInteractiveChange - Limpa campos derivados ao editar barras
    *==========================================================================
    PROCEDURE TxtBarrasInteractiveChange()
        THIS.txt_4c_CorAnt.Value = ""
        THIS.txt_4c_TamAnt.Value = ""
        THIS.txt_4c_CorNew.Value = ""
        THIS.txt_4c_TamNew.Value = ""
        THIS.this_oBusinessObject.this_nCodBarras = 0
    ENDPROC

    *==========================================================================
    * AbrirBuscaCor - Lookup de Cores (SigCdCor) via FormBuscaAuxiliar
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaCor()
        LOCAL loc_cValor, loc_oBusca, loc_oErro

        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_CorNew.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Cores")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaCor") AND RECCOUNT("cursor_4c_BuscaCor") > 0
                        SELECT cursor_4c_BuscaCor
                        THIS.txt_4c_CorNew.Value = ALLTRIM(cursor_4c_BuscaCor.cods)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor") AND RECCOUNT("cursor_4c_BuscaCor") > 0
                        SELECT cursor_4c_BuscaCor
                        THIS.txt_4c_CorNew.Value = ALLTRIM(cursor_4c_BuscaCor.cods)
                    ELSE
                        THIS.txt_4c_CorNew.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaCor")
                    USE IN cursor_4c_BuscaCor
                ENDIF
                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaCor")
            IF USED("cursor_4c_BuscaCor")
                USE IN cursor_4c_BuscaCor
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtCorNewKeyPress - Dispara lookup de Cor em F4 (115), ENTER (13), TAB (9)
    *==========================================================================
    PROCEDURE TxtCorNewKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.AbrirBuscaCor()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaTam - Lookup de Tamanhos (SigCdTam) via FormBuscaAuxiliar
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaTam()
        LOCAL loc_cValor, loc_oBusca, loc_oErro

        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_TamNew.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTam", "cursor_4c_BuscaTam", "cods", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Tamanhos")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaTam") AND RECCOUNT("cursor_4c_BuscaTam") > 0
                        SELECT cursor_4c_BuscaTam
                        THIS.txt_4c_TamNew.Value = ALLTRIM(cursor_4c_BuscaTam.cods)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam") AND RECCOUNT("cursor_4c_BuscaTam") > 0
                        SELECT cursor_4c_BuscaTam
                        THIS.txt_4c_TamNew.Value = ALLTRIM(cursor_4c_BuscaTam.cods)
                    ELSE
                        THIS.txt_4c_TamNew.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaTam")
                    USE IN cursor_4c_BuscaTam
                ENDIF
                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaTam")
            IF USED("cursor_4c_BuscaTam")
                USE IN cursor_4c_BuscaTam
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtTamNewKeyPress - Dispara lookup de Tamanho em F4 (115), ENTER (13), TAB (9)
    *==========================================================================
    PROCEDURE TxtTamNewKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.AbrirBuscaTam()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia nova opera" + CHR(231) + CHR(227) + "o de altera" + CHR(231) + CHR(227) + "o
    * Form OPERACIONAL: "Incluir" equivale a resetar o form para nova entrada
    * de c" + CHR(243) + "digo de barras (equivalente a AlternarPagina no pipeline CRUD)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        TRY
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Executa a altera" + CHR(231) + CHR(227) + "o de Cor/Tamanho da etiqueta
    * Form OPERACIONAL: "Alterar" e' a opera" + CHR(231) + CHR(227) + "o principal (Processar)
    * Delega para BtnProcessarClick que valida campos e grava via BO
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            THIS.BtnProcessarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Consulta dados da etiqueta pelo c" + CHR(243) + "digo de barras
    * Form OPERACIONAL: "Visualizar" = buscar barcode e exibir Cor/Tam antigos
    * Delega para ValidarBarras que faz SELECT em SigOpEtq e preenche os campos
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nCodBarras, loc_oErro

        TRY
            loc_nCodBarras = IIF(VARTYPE(THIS.txt_4c_Barras.Value) = "C", ;
                                 VAL(THIS.txt_4c_Barras.Value), ;
                                 THIS.txt_4c_Barras.Value)

            IF EMPTY(loc_nCodBarras)
                MsgAviso("Favor Informar o C" + CHR(243) + "digo de Barras.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.ValidarBarras()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Encerra a opera" + CHR(231) + CHR(227) + "o e fecha o formul" + CHR(225) + "rio
    * Form OPERACIONAL: o legado SIGMDETQ n" + CHR(227) + "o possui opera" + CHR(231) + CHR(227) + "o de exclus" + CHR(227) + "o
    * (s" + CHR(243) + " alteracao via Processar). Aqui equivale ao bot" + CHR(227) + "o Cancelar do original.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro

        TRY
            THIS.BtnCancelarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores editaveis do form para o BO
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cCorNew = ALLTRIM(THIS.txt_4c_CorNew.Value)
                THIS.this_oBusinessObject.this_cTamNew = ALLTRIM(THIS.txt_4c_TamNew.Value)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para os campos do form
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.txt_4c_CorAnt.Value = THIS.this_oBusinessObject.this_cCorAnt
                THIS.txt_4c_TamAnt.Value = THIS.this_oBusinessObject.this_cTamAnt
                THIS.txt_4c_CorNew.Value = THIS.this_oBusinessObject.this_cCorNew
                THIS.txt_4c_TamNew.Value = THIS.this_oBusinessObject.this_cTamNew
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos editaveis do form
    * txt_4c_CorAnt e txt_4c_TamAnt sao sempre somente leitura (ReadOnly=.T.)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oErro
        TRY
            THIS.txt_4c_Barras.Enabled    = par_lHabilitar
            THIS.txt_4c_CorNew.Enabled    = par_lHabilitar
            THIS.txt_4c_TamNew.Enabled    = par_lHabilitar
            THIS.cmd_4c_Processar.Enabled = par_lHabilitar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos e reseta propriedades do BO
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            THIS.txt_4c_Barras.Value = ""
            THIS.txt_4c_CorAnt.Value = ""
            THIS.txt_4c_TamAnt.Value = ""
            THIS.txt_4c_CorNew.Value = ""
            THIS.txt_4c_TamNew.Value = ""
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_nCodBarras = 0
                THIS.this_oBusinessObject.this_cCPros     = ""
                THIS.this_oBusinessObject.this_cCorAnt    = ""
                THIS.this_oBusinessObject.this_cTamAnt    = ""
                THIS.this_oBusinessObject.this_cCorNew    = ""
                THIS.this_oBusinessObject.this_cTamNew    = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Form OPERACIONAL: sem lista paginada CRUD.
    * Presente por compatibilidade com o pipeline multi-fase.
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Form OPERACIONAL: botoes Processar/Cancelar
    * permanecem habilitados. Presente por compatibilidade com o pipeline.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
                THIS.cmd_4c_Processar.Enabled = .T.
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
                THIS.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Valida etiqueta pelo codigo de barras digitado
    * Equivalente semantico de "Buscar/Consultar" em forms CRUD
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_nCodBarras, loc_oErro
        TRY
            loc_nCodBarras = IIF(VARTYPE(THIS.txt_4c_Barras.Value) = "C", ;
                                 VAL(THIS.txt_4c_Barras.Value), ;
                                 THIS.txt_4c_Barras.Value)
            IF EMPTY(loc_nCodBarras)
                MsgAviso("Favor Informar o C" + CHR(243) + "digo de Barras.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.ValidarBarras()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Processa a alteracao de Cor/Tamanho
    * Alias para BtnProcessarClick (compatibilidade com pipeline multi-fase)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnProcessarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
