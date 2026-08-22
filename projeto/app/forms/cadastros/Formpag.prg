*==============================================================================
* Formpag.prg - Cadastro de Condicoes de Pagamento
* Entidade : pag
* Tabela   : SigOpFp (PK: fpags char(12))
* BO       : pagBO.prg
*==============================================================================

DEFINE CLASS Formpag AS FormBase

    Height      = 623
    Width       = 1000
    Caption     = "Cadastro de Condi" + CHR(231) + CHR(245) + "es de Pagamento"
    DataSession = 2
    ShowWindow = 1
    WindowType = 1

    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("pagBO")
            IF ISNULL(THIS.this_oBusinessObject) OR VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar pagBO.", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.CarregarLista()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.InicializarForm: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        LOCAL loc_oPgf
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            loc_oPgf = THIS.pgf_4c_Paginas
            WITH loc_oPgf
                .Top       = -29
                .Left      = 0
                .Width     = THIS.Width
                .Height    = THIS.Height + 29
                .Tabs      = .F.
                .PageCount = 2
                .Visible   = .T.
            ENDWITH

            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            loc_oPgf.ActivePage = 1
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.ConfigurarPageFrame: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *==========================================================================
        LOCAL loc_oPage, loc_oCnt, loc_oCntSaida, loc_oCntEsp, loc_oGrd, loc_oCol
        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Pages(1)
            loc_oPage.Caption = "Lista"

            && --- Container de botoes CRUD padrao ---
            loc_oPage.AddObject("cnt_4c_Botoes", "Container")
            loc_oCnt = loc_oPage.cnt_4c_Botoes
            WITH loc_oCnt
                .Top       = 29
                .Left      = 542
                .Width     = 370
                .Height    = 85
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
            WITH loc_oCnt.cmd_4c_Incluir
                .Caption = "Incluir"
                .Top     = 5
                .Left    = 5
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

            loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Alterar
                .Caption = "Alterar"
                .Top     = 5
                .Left    = 85
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

            loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Visualizar
                .Caption = "Visualizar"
                .Top     = 5
                .Left    = 165
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

            loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH loc_oCnt.cmd_4c_Excluir
                .Caption = "Excluir"
                .Top     = 5
                .Left    = 245
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

            loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
            WITH loc_oCnt.cmd_4c_Buscar
                .Caption = "Buscar"
                .Top     = 5
                .Left    = 325
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

            && --- Container botoes especiais ---
            loc_oPage.AddObject("cnt_4c_BotoesEspeciais", "Container")
            loc_oCntEsp = loc_oPage.cnt_4c_BotoesEspeciais
            WITH loc_oCntEsp
                .Top       = 79
                .Left      = 0
                .Width     = 780
                .Height    = 60
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oCntEsp.AddObject("cmd_4c_BtnExpXML", "CommandButton")
            WITH loc_oCntEsp.cmd_4c_BtnExpXML
                .Caption = "Exportar"
                .Top     = 5
                .Left    = 24
                .Width   = 120
                .Height  = 40
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntEsp.cmd_4c_BtnExpXML, "Click", THIS, "BtnExportarClick")

            loc_oCntEsp.AddObject("cmd_4c_BtnImpXML", "CommandButton")
            WITH loc_oCntEsp.cmd_4c_BtnImpXML
                .Caption = "Importar"
                .Top     = 5
                .Left    = 144
                .Width   = 120
                .Height  = 40
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntEsp.cmd_4c_BtnImpXML, "Click", THIS, "BtnImportarClick")

            loc_oCntEsp.AddObject("cmd_4c_CmdCopia", "CommandButton")
            WITH loc_oCntEsp.cmd_4c_CmdCopia
                .Caption = "Copiar"
                .Top     = 5
                .Left    = 264
                .Width   = 120
                .Height  = 40
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntEsp.cmd_4c_CmdCopia, "Click", THIS, "BtnCopiarClick")

            loc_oCntEsp.AddObject("cmd_4c_CmdfpMin", "CommandButton")
            WITH loc_oCntEsp.cmd_4c_CmdfpMin
                .Caption = "M" + CHR(237) + "nimo"
                .Top     = 5
                .Left    = 384
                .Width   = 120
                .Height  = 40
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntEsp.cmd_4c_CmdfpMin, "Click", THIS, "BtnMinimoClick")

            loc_oCntEsp.AddObject("cmd_4c_Cmdfpdpar", "CommandButton")
            WITH loc_oCntEsp.cmd_4c_Cmdfpdpar
                .Caption = "Desconto"
                .Top     = 5
                .Left    = 504
                .Width   = 120
                .Height  = 40
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntEsp.cmd_4c_Cmdfpdpar, "Click", THIS, "BtnDescontoClick")

            loc_oCntEsp.AddObject("cmd_4c_Bot_BIN", "CommandButton")
            WITH loc_oCntEsp.cmd_4c_Bot_BIN
                .Caption = "BIN"
                .Top     = 5
                .Left    = 624
                .Width   = 120
                .Height  = 40
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntEsp.cmd_4c_Bot_BIN, "Click", THIS, "BtnBINClick")

            && --- Container saida canonico ---
            loc_oPage.AddObject("cnt_4c_Saida", "Container")
            loc_oCntSaida = loc_oPage.cnt_4c_Saida
            WITH loc_oCntSaida
                .Top       = 29
                .Left      = 917
                .Width     = 90
                .Height    = 85
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oCntSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH loc_oCntSaida.cmd_4c_Encerrar
                .Caption = "Encerrar"
                .Top     = 5
                .Left    = 5
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            && --- Grid ---
            loc_oPage.AddObject("grd_4c_Lista", "Grid")
            loc_oGrd = loc_oPage.grd_4c_Lista
            WITH loc_oGrd
                .Top          = 130
                .Left         = 26
                .Width        = 890
                .Height       = 490
                .RecordSource = "cursor_4c_Dados"
                .ReadOnly     = .T.
                .ColumnCount  = 5
                .HeaderHeight = 22
                .RowHeight    = 18
                .GridLines    = 1
                .Visible      = .T.
            ENDWITH

            loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "digo"
            loc_oGrd.Column1.ControlSource   = "cursor_4c_Dados.fpags"
            loc_oGrd.Column1.Width           = 100

            loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            loc_oGrd.Column2.ControlSource   = "cursor_4c_Dados.descrs"
            loc_oGrd.Column2.Width           = 250

            loc_oGrd.Column3.Header1.Caption = "Moeda"
            loc_oGrd.Column3.ControlSource   = "cursor_4c_Dados.moefpgs"
            loc_oGrd.Column3.Width           = 60

            loc_oGrd.Column4.Header1.Caption = "Dias"
            loc_oGrd.Column4.ControlSource   = "cursor_4c_Dados.dias"
            loc_oGrd.Column4.Width           = 50

            loc_oGrd.Column5.Header1.Caption = "T.Venc"
            loc_oGrd.Column5.ControlSource   = "cursor_4c_Dados.tvens"
            loc_oGrd.Column5.Width           = 60

        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.ConfigurarPaginaLista: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *==========================================================================
        LOCAL loc_oPage, loc_oCntSalva, loc_oCntSaida2, loc_oPgf2
        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Pages(2)
            loc_oPage.Caption = "Dados"

            && --- Cabecalho: Descricao ---
            loc_oPage.AddObject("lbl_4c_Descrs", "Label")
            WITH loc_oPage.lbl_4c_Descrs
                .Caption  = "Descri" + CHR(231) + CHR(227) + "o :"
                .Top      = 20
                .Left     = 10
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Descrs", "TextBox")
            WITH loc_oPage.txt_4c_Descrs
                .Top       = 16
                .Left      = 112
                .Width     = 220
                .Height    = 21
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH

            && --- Cabecalho: Titulo ---
            loc_oPage.AddObject("lbl_4c_TitFPags", "Label")
            WITH loc_oPage.lbl_4c_TitFPags
                .Caption  = "T" + CHR(237) + "tulo :"
                .Top      = 20
                .Left     = 338
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_TitFPags", "TextBox")
            WITH loc_oPage.txt_4c_TitFPags
                .Top       = 16
                .Left      = 380
                .Width     = 220
                .Height    = 21
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH

            && --- Cabecalho: Forma ---
            loc_oPage.AddObject("lbl_4c_Forma", "Label")
            WITH loc_oPage.lbl_4c_Forma
                .Caption  = "Forma :"
                .Top      = 20
                .Left     = 605
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Forma", "TextBox")
            WITH loc_oPage.txt_4c_Forma
                .Top       = 16
                .Left      = 650
                .Width     = 94
                .Height    = 21
                .MaxLength = 12
                .Visible   = .T.
            ENDWITH

            && --- Cabecalho: Codigo / Nfpags / ModPagto ---
            loc_oPage.AddObject("lbl_4c_Fpags", "Label")
            WITH loc_oPage.lbl_4c_Fpags
                .Caption  = "C" + CHR(243) + "digo :"
                .Top      = 53
                .Left     = 10
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Codigo", "TextBox")
            WITH loc_oPage.txt_4c_Codigo
                .Top       = 53
                .Left      = 112
                .Width     = 94
                .Height    = 21
                .MaxLength = 12
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_Nfpags", "Label")
            WITH loc_oPage.lbl_4c_Nfpags
                .Caption  = "Nro :"
                .Top      = 53
                .Left     = 215
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Nfpag", "TextBox")
            WITH loc_oPage.txt_4c_Nfpag
                .Top       = 53
                .Left      = 248
                .Width     = 40
                .Height    = 21
                .MaxLength = 2
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_Modpagto", "Label")
            WITH loc_oPage.lbl_4c_Modpagto
                .Caption  = "Modalidade :"
                .Top      = 53
                .Left     = 300
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Modalidade", "TextBox")
            WITH loc_oPage.txt_4c_Modalidade
                .Top       = 53
                .Left      = 385
                .Width     = 232
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            && --- Cabecalho: Grupo/Conta/DConta (debito) ---
            loc_oPage.AddObject("lbl_4c_GrpDs", "Label")
            WITH loc_oPage.lbl_4c_GrpDs
                .Caption  = "Grupo Deb. :"
                .Top      = 91
                .Left     = 10
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Grupo", "TextBox")
            WITH loc_oPage.txt_4c_Grupo
                .Top       = 91
                .Left      = 90
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_CtaDs", "Label")
            WITH loc_oPage.lbl_4c_CtaDs
                .Caption  = "Conta :"
                .Top      = 91
                .Left     = 178
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Conta", "TextBox")
            WITH loc_oPage.txt_4c_Conta
                .Top       = 91
                .Left      = 220
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_4c_DctaDs", "Label")
            WITH loc_oPage.lbl_4c_DctaDs
                .Caption  = "Descr. Conta :"
                .Top      = 91
                .Left     = 305
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("txt_4c_Dconta", "TextBox")
            WITH loc_oPage.txt_4c_Dconta
                .Top       = 91
                .Left      = 390
                .Width     = 290
                .Height    = 21
                .MaxLength = 40
                .ReadOnly  = .T.
                .Visible   = .T.
            ENDWITH

            && --- OptionGroup Conta Mov ---
            loc_oPage.AddObject("obj_4c_Opt_ContaMov", "OptionGroup")
            WITH loc_oPage.obj_4c_Opt_ContaMov
                .Top         = 90
                .Left        = 479
                .Width       = 283
                .Height      = 23
                .ButtonCount = 4
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "D"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "C"
                    .Left = 71
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "T"
                    .Left = 142
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(4)
                    .Caption = "O"
                    .Left = 213
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            && --- Botoes Salvar/Cancelar ---
            loc_oPage.AddObject("cnt_4c_Salva", "Container")
            WITH loc_oPage.cnt_4c_Salva
                .Top    = 29
                .Left   = 542
                .Width  = 160
                .Height = 85
                .Visible     = .T.
            ENDWITH

            loc_oPage.cnt_4c_Salva.AddObject("cmd_4c_Salvar", "CommandButton")
            WITH loc_oPage.cnt_4c_Salva.cmd_4c_Salvar
                .Caption = "Salvar"
                .Top     = 5
                .Left    = 5
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oPage.cnt_4c_Salva.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

            loc_oPage.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH loc_oPage.cnt_4c_Salva.cmd_4c_Cancelar
                .Caption = "Encerrar"
                .Top     = 5
                .Left    = 85
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oPage.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

            && --- Container saida pagina Dados ---
            loc_oPage.AddObject("cnt_4c_Saida2", "Container")
            loc_oCntSaida2 = loc_oPage.cnt_4c_Saida2
            WITH loc_oCntSaida2
                .Top    = 29
                .Left   = 917
                .Width  = 90
                .Height = 85
            ENDWITH

            loc_oCntSaida2.AddObject("cmd_4c_Encerrar2", "CommandButton")
            WITH loc_oCntSaida2.cmd_4c_Encerrar2
                .Caption = "Encerrar"
                .Top     = 5
                .Left    = 5
                .Width   = 75
                .Height  = 75
                .Visible = .T.
            ENDWITH
            BINDEVENT(loc_oCntSaida2.cmd_4c_Encerrar2, "Click", THIS, "BtnEncerrarClick")

            && --- Inner PageFrame: pgf_4c_Dados ---
            loc_oPage.AddObject("pgf_4c_Dados", "PageFrame")
            loc_oPgf2 = loc_oPage.pgf_4c_Dados
            WITH loc_oPgf2
                .Top       = 120
                .Left      = 0
                .Width     = THIS.Width
                .Height    = THIS.Height - 120 + 29
                .Tabs      = .T.
                .PageCount = 2
                .Visible   = .T.
            ENDWITH

            loc_oPgf2.Pages(1).Caption = "Geral"
            loc_oPgf2.Pages(2).Caption = "Cart" + CHR(227) + "o/TEF"

            THIS.CriarPaginaGeral(loc_oPgf2.Pages(1))
            THIS.CriarPaginaCartaoTEF(loc_oPgf2.Pages(2))

        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.ConfigurarPaginaDados: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CriarPaginaGeral(par_oPage)
    *==========================================================================
        LOCAL loc_oPage
        loc_oPage = par_oPage
        TRY
            && --- Linha 1: Entrada, Dias, Parcelas, Tipo Uso ---
            loc_oPage.AddObject("lbl_g_Entrada", "Label")
            WITH loc_oPage.lbl_g_Entrada
                .Caption  = "Entrada :"
                .Top      = 8
                .Left     = 93
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Entrada", "TextBox")
            WITH loc_oPage.txt_4c_Entrada
                .Top       = 4
                .Left      = 144
                .Width     = 31
                .Height    = 21
                .MaxLength = 3
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_InterDias", "Label")
            WITH loc_oPage.lbl_g_InterDias
                .Caption  = "Intervalo de Dias :"
                .Top      = 34
                .Left     = 49
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Dias", "TextBox")
            WITH loc_oPage.txt_4c_Dias
                .Top       = 30
                .Left      = 144
                .Width     = 31
                .Height    = 21
                .MaxLength = 3
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Parcelas", "Label")
            WITH loc_oPage.lbl_g_Parcelas
                .Caption  = "N" + CHR(250) + "mero de Parcelas :"
                .Top      = 59
                .Left     = 36
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Parcelas", "TextBox")
            WITH loc_oPage.txt_4c_Parcelas
                .Top       = 55
                .Left      = 144
                .Width     = 31
                .Height    = 21
                .MaxLength = 2
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_TipoUso", "Label")
            WITH loc_oPage.lbl_g_TipoUso
                .Caption  = "Tipo de Uso :"
                .Top      = 84
                .Left     = 75
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c___formas", "TextBox")
            WITH loc_oPage.txt_4c__formas
                .Top       = 80
                .Left      = 144
                .Width     = 94
                .Height    = 21
                .MaxLength = 12
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_g_TipoUsoH", "Label")
            WITH loc_oPage.lbl_g_TipoUsoH
                .Caption  = "[P/R/A/S/I]"
                .Top      = 84
                .Left     = 244
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            && --- Situacao ---
            loc_oPage.AddObject("lbl_g_Situa", "Label")
            WITH loc_oPage.lbl_g_Situa
                .Caption  = "Situa" + CHR(231) + CHR(227) + "o :"
                .Top      = 84
                .Left     = 640
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c__Situa", "TextBox")
            WITH loc_oPage.txt_4c__Situa
                .Top       = 80
                .Left      = 700
                .Width     = 31
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_VencDesc", "Label")
            WITH loc_oPage.lbl_g_VencDesc
                .Caption  = "Tipo Vencimento :"
                .Top      = 109
                .Left     = 53
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c__dvenc", "TextBox")
            WITH loc_oPage.txt_4c__dvenc
                .Top       = 105
                .Left      = 177
                .Width     = 127
                .Height    = 23
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_VENC", "TextBox")
            WITH loc_oPage.txt_4c_VENC
                .Top       = 105
                .Left      = 144
                .Width     = 31
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Info", "Label")
            WITH loc_oPage.lbl_g_Info
                .Caption  = "Info. Complementar :"
                .Top      = 134
                .Left     = 35
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c__dinfo", "TextBox")
            WITH loc_oPage.txt_4c__dinfo
                .Top       = 130
                .Left      = 177
                .Width     = 127
                .Height    = 23
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_INFO", "TextBox")
            WITH loc_oPage.txt_4c_INFO
                .Top       = 130
                .Left      = 144
                .Width     = 31
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_DadObrig", "Label")
            WITH loc_oPage.lbl_g_DadObrig
                .Caption  = "Dados Obrigat" + CHR(243) + "rios :"
                .Top      = 159
                .Left     = 39
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_ChqObrig", "TextBox")
            WITH loc_oPage.txt_4c_ChqObrig
                .Top       = 155
                .Left      = 144
                .Width     = 31
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_g_DadObrigH", "Label")
            WITH loc_oPage.lbl_g_DadObrigH
                .Caption  = "[S/N]"
                .Top      = 159
                .Left     = 181
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_EmpLanc", "Label")
            WITH loc_oPage.lbl_g_EmpLanc
                .Caption  = "Somente p/ Empresa :"
                .Top      = 184
                .Left     = 32
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_EmpLanc", "TextBox")
            WITH loc_oPage.txt_4c_EmpLanc
                .Top       = 180
                .Left      = 144
                .Width     = 31
                .Height    = 23
                .MaxLength = 3
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_GrupoEmp", "Label")
            WITH loc_oPage.lbl_g_GrupoEmp
                .Caption  = "Grupo Empresarial :"
                .Top      = 210
                .Left     = 44
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_GrupoEmp", "TextBox")
            WITH loc_oPage.txt_4c_GrupoEmp
                .Top       = 206
                .Left      = 144
                .Width     = 115
                .Height    = 23
                .MaxLength = 15
                .Visible   = .T.
            ENDWITH

            && --- Mascara / Valor ---
            loc_oPage.AddObject("lbl_g_Mascara", "Label")
            WITH loc_oPage.lbl_g_Mascara
                .Caption  = "M" + CHR(225) + "scara :"
                .Top      = 236
                .Left     = 91
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Picture", "TextBox")
            WITH loc_oPage.txt_4c_Picture
                .Top       = 232
                .Left      = 144
                .Width     = 150
                .Height    = 21
                .MaxLength = 20
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Valor", "Label")
            WITH loc_oPage.lbl_g_Valor
                .Caption  = "Valor :"
                .Top      = 261
                .Left     = 107
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Valor", "TextBox")
            WITH loc_oPage.txt_4c_Valor
                .Top       = 257
                .Left      = 144
                .Width     = 95
                .Height    = 23
                .MaxLength = 11
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Desconto", "Label")
            WITH loc_oPage.lbl_g_Desconto
                .Caption  = "Desconto Venda :"
                .Top      = 286
                .Left     = 53
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Desconto", "TextBox")
            WITH loc_oPage.txt_4c_Desconto
                .Top       = 282
                .Left      = 144
                .Width     = 71
                .Height    = 23
                .MaxLength = 5
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_g_DescontoH", "Label")
            WITH loc_oPage.lbl_g_DescontoH
                .Caption  = "[%]"
                .Top      = 286
                .Left     = 221
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Comissao", "Label")
            WITH loc_oPage.lbl_g_Comissao
                .Caption  = "Comiss" + CHR(227) + "o :"
                .Top      = 311
                .Left     = 86
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Comissao", "TextBox")
            WITH loc_oPage.txt_4c_Comissao
                .Top       = 307
                .Left      = 144
                .Width     = 71
                .Height    = 23
                .MaxLength = 5
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_g_ComissaoH", "Label")
            WITH loc_oPage.lbl_g_ComissaoH
                .Caption  = "[%]"
                .Top      = 311
                .Left     = 221
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Encargos", "Label")
            WITH loc_oPage.lbl_g_Encargos
                .Caption  = "Enc. Financeiros :"
                .Top      = 336
                .Left     = 53
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Encargos", "TextBox")
            WITH loc_oPage.txt_4c_Encargos
                .Top       = 332
                .Left      = 144
                .Width     = 71
                .Height    = 23
                .MaxLength = 5
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_g_EncargosH", "Label")
            WITH loc_oPage.lbl_g_EncargosH
                .Caption  = "[%]"
                .Top      = 336
                .Left     = 221
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_PVaria", "Label")
            WITH loc_oPage.lbl_g_PVaria
                .Caption  = "Varia" + CHR(231) + CHR(227) + "o :"
                .Top      = 361
                .Left     = 90
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_PVaria", "TextBox")
            WITH loc_oPage.txt_4c_PVaria
                .Top       = 357
                .Left      = 144
                .Width     = 71
                .Height    = 23
                .MaxLength = 5
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_g_PVariaH", "Label")
            WITH loc_oPage.lbl_g_PVariaH
                .Caption  = "[%]"
                .Top      = 361
                .Left     = 221
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Indice", "Label")
            WITH loc_oPage.lbl_g_Indice
                .Caption  = "Indice Cota" + CHR(231) + CHR(227) + "o :"
                .Top      = 386
                .Left     = 59
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Indice", "TextBox")
            WITH loc_oPage.txt_4c_Indice
                .Top       = 382
                .Left      = 144
                .Width     = 71
                .Height    = 23
                .MaxLength = 6
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_TaxJuros", "Label")
            WITH loc_oPage.lbl_g_TaxJuros
                .Caption  = "Taxa de Juros :"
                .Top      = 411
                .Left     = 63
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_TaxJuros", "TextBox")
            WITH loc_oPage.txt_4c_TaxJuros
                .Top       = 407
                .Left      = 144
                .Width     = 71
                .Height    = 23
                .MaxLength = 8
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_g_TaxJurosH", "Label")
            WITH loc_oPage.lbl_g_TaxJurosH
                .Caption  = "[% dia]"
                .Top      = 411
                .Left     = 221
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_TolFecCx", "Label")
            WITH loc_oPage.lbl_g_TolFecCx
                .Caption  = "Toler" + CHR(226) + "ncia Fec. Caixa :"
                .Top      = 436
                .Left     = 28
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_TolFecCx", "TextBox")
            WITH loc_oPage.txt_4c_TolFecCx
                .Top       = 432
                .Left      = 144
                .Width     = 71
                .Height    = 23
                .MaxLength = 5
                .Visible   = .T.
            ENDWITH

            && --- Banco / Agencia / NConta ---
            loc_oPage.AddObject("lbl_g_Banco", "Label")
            WITH loc_oPage.lbl_g_Banco
                .Caption  = "Banco"
                .Top      = 182
                .Left     = 765
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Bancos", "TextBox")
            WITH loc_oPage.txt_4c_Bancos
                .Top       = 197
                .Left      = 765
                .Width     = 31
                .Height    = 23
                .MaxLength = 3
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Agencia", "Label")
            WITH loc_oPage.lbl_g_Agencia
                .Caption  = "Ag" + CHR(234) + "ncia"
                .Top      = 182
                .Left     = 810
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Agencias", "TextBox")
            WITH loc_oPage.txt_4c_Agencias
                .Top       = 197
                .Left      = 810
                .Width     = 38
                .Height    = 21
                .MaxLength = 4
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_NConta", "Label")
            WITH loc_oPage.lbl_g_NConta
                .Caption  = "Conta"
                .Top      = 182
                .Left     = 861
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_NContas", "TextBox")
            WITH loc_oPage.txt_4c_NContas
                .Top       = 197
                .Left      = 861
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            && --- Especie NF ---
            loc_oPage.AddObject("lbl_g_EspecieNfs", "Label")
            WITH loc_oPage.lbl_g_EspecieNfs
                .Caption = "Esp" + CHR(233) + "cie :"
                .Top     = 396
                .Left    = 715
                .Width   = 45
                .Visible = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_EspecieNfs", "TextBox")
            WITH loc_oPage.txt_4c_EspecieNfs
                .Top       = 393
                .Left      = 765
                .Width     = 52
                .Height    = 21
                .MaxLength = 6
                .Visible   = .T.
            ENDWITH

            && --- OptionGroups coluna direita (479) ---
            loc_oPage.AddObject("lbl_g_ValPend", "Label")
            WITH loc_oPage.lbl_g_ValPend
                .Caption  = "Valor Pendente :"
                .Top      = 8
                .Left     = 393
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Op_valpend", "OptionGroup")
            WITH loc_oPage.obj_4c_Op_valpend
                .Top         = 4
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_BxComis", "Label")
            WITH loc_oPage.lbl_g_BxComis
                .Caption  = "Credita Comiss" + CHR(227) + "o :"
                .Top      = 34
                .Left     = 383
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Op_BxComis", "OptionGroup")
            WITH loc_oPage.obj_4c_Op_BxComis
                .Top         = 30
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Emichqs", "Label")
            WITH loc_oPage.lbl_g_Emichqs
                .Caption  = "Emite Cheque :"
                .Top      = 59
                .Left     = 400
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Op_Emichqs", "OptionGroup")
            WITH loc_oPage.obj_4c_Op_Emichqs
                .Top         = 55
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_ImpChqs", "Label")
            WITH loc_oPage.lbl_g_ImpChqs
                .Caption  = "Imprime Cheque :"
                .Top      = 84
                .Left     = 388
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Op_ImpChqs", "OptionGroup")
            WITH loc_oPage.obj_4c_Op_ImpChqs
                .Top         = 80
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_OptFechm", "Label")
            WITH loc_oPage.lbl_g_OptFechm
                .Caption  = "Total Fechamento :"
                .Top      = 109
                .Left     = 380
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_OptFechm", "OptionGroup")
            WITH loc_oPage.obj_4c_OptFechm
                .Top         = 105
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg7", "Label")
            WITH loc_oPage.lbl_g_Optg7
                .Caption  = "M" + CHR(234) + "s Fechado :"
                .Top      = 134
                .Left     = 403
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup7", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup7
                .Top         = 130
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg10", "Label")
            WITH loc_oPage.lbl_g_Optg10
                .Caption  = "Agente Cobrador :"
                .Top      = 159
                .Left     = 383
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup10", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup10
                .Top         = 155
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Trocos", "Label")
            WITH loc_oPage.lbl_g_Trocos
                .Caption  = "Troco :"
                .Top      = 184
                .Left     = 439
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_OptTrocos", "OptionGroup")
            WITH loc_oPage.obj_4c_OptTrocos
                .Top         = 180
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg5", "Label")
            WITH loc_oPage.lbl_g_Optg5
                .Caption  = "Baixa Comiss" + CHR(227) + "o no Chq :"
                .Top      = 209
                .Left     = 355
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup5", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup5
                .Top         = 205
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg2", "Label")
            WITH loc_oPage.lbl_g_Optg2
                .Caption  = "Baixa Valor :"
                .Top      = 234
                .Left     = 413
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup2", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup2
                .Top         = 230
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg8", "Label")
            WITH loc_oPage.lbl_g_Optg8
                .Caption  = "Acumula :"
                .Top      = 259
                .Left     = 426
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup8", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup8
                .Top         = 255
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg3", "Label")
            WITH loc_oPage.lbl_g_Optg3
                .Caption  = "Itens Obrigat" + CHR(243) + "rios :"
                .Top      = 284
                .Left     = 367
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup3", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup3
                .Top         = 280
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg4", "Label")
            WITH loc_oPage.lbl_g_Optg4
                .Caption  = "Aprova" + CHR(231) + CHR(227) + "o :"
                .Top      = 309
                .Left     = 414
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup4", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup4
                .Top         = 305
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg12", "Label")
            WITH loc_oPage.lbl_g_Optg12
                .Caption  = "Detalha Fec. Caixa :"
                .Top      = 334
                .Left     = 375
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup12", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup12
                .Top         = 330
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_ImpBols", "Label")
            WITH loc_oPage.lbl_g_ImpBols
                .Caption  = "Imprime Boleto Banc" + CHR(225) + "rio :"
                .Top      = 360
                .Left     = 351
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_OptImpBols", "OptionGroup")
            WITH loc_oPage.obj_4c_OptImpBols
                .Top         = 356
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_ImpDups", "Label")
            WITH loc_oPage.lbl_g_ImpDups
                .Caption  = "Imprime Duplicata :"
                .Top      = 385
                .Left     = 381
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_OptImpDups", "OptionGroup")
            WITH loc_oPage.obj_4c_OptImpDups
                .Top         = 381
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg13", "Label")
            WITH loc_oPage.lbl_g_Optg13
                .Caption  = "Bloqueia Tab.Desconto :"
                .Top      = 411
                .Left     = 356
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup13", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup13
                .Top         = 407
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Liscongv", "Label")
            WITH loc_oPage.lbl_g_Liscongv
                .Caption  = "Exibe na Consulta Global :"
                .Top      = 437
                .Left     = 348
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Opt_Liscongv", "OptionGroup")
            WITH loc_oPage.obj_4c_Opt_Liscongv
                .Top         = 433
                .Left        = 479
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            && --- Coluna 765 - Calculos ---
            loc_oPage.AddObject("lbl_g_CalcVenc", "Label")
            WITH loc_oPage.lbl_g_CalcVenc
                .Caption = "Calcula Vencimento :"
                .Top     = 8
                .Left    = 661
                .Width   = 101
                .Visible = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Fwoption1", "OptionGroup")
            WITH loc_oPage.obj_4c_Fwoption1
                .Top         = 4
                .Left        = 765
                .Width       = 230
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 115
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_CopChq", "Label")
            WITH loc_oPage.lbl_g_CopChq
                .Caption  = "C" + CHR(243) + "pia de Cheque :"
                .Top      = 34
                .Left     = 671
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup11", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup11
                .Top         = 30
                .Left        = 765
                .Width       = 230
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 115
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_LeitChq", "Label")
            WITH loc_oPage.lbl_g_LeitChq
                .Caption = "Leitura de Cheque :"
                .Top     = 59
                .Left    = 665
                .Width   = 97
                .Height  = 15
                .Visible = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_OptTpLeituras", "OptionGroup")
            WITH loc_oPage.obj_4c_OptTpLeituras
                .Top         = 55
                .Left        = 765
                .Width       = 230
                .Height      = 23
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "1"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "2"
                    .Left = 77
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "3"
                    .Left = 154
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_OpcaoSNA", "Label")
            WITH loc_oPage.lbl_g_OpcaoSNA
                .Caption  = "Op" + CHR(231) + CHR(227) + "o :"
                .Top      = 84
                .Left     = 722
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_OpcaoSNA", "OptionGroup")
            WITH loc_oPage.obj_4c_OpcaoSNA
                .Top         = 80
                .Left        = 765
                .Width       = 230
                .Height      = 23
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 77
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "A"
                    .Left = 154
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Autentica", "Label")
            WITH loc_oPage.lbl_g_Autentica
                .Caption  = "Autentica" + CHR(231) + CHR(227) + "o :"
                .Top      = 109
                .Left     = 690
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup6", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup6
                .Top         = 105
                .Left        = 765
                .Width       = 230
                .Height      = 23
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 77
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "A"
                    .Left = 154
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Observa", "Label")
            WITH loc_oPage.lbl_g_Observa
                .Caption  = "Observa" + CHR(231) + CHR(227) + "o :"
                .Top      = 134
                .Left     = 695
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_OptObserva", "OptionGroup")
            WITH loc_oPage.obj_4c_OptObserva
                .Top         = 130
                .Left        = 765
                .Width       = 230
                .Height      = 23
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 77
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "A"
                    .Left = 154
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_emichqs2", "Label")
            WITH loc_oPage.lbl_g_emichqs2
                .Caption  = "Emiss" + CHR(227) + "o de Cheques :"
                .Top      = 201
                .Left     = 655
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup1", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup1
                .Top         = 155
                .Left        = 765
                .Width       = 230
                .Height      = 23
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "1"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "2"
                    .Left = 77
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "3"
                    .Left = 154
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_ImpCpChqs", "Label")
            WITH loc_oPage.lbl_g_ImpCpChqs
                .Caption  = "Imp. Cert. Cr" + CHR(233) + "dito :"
                .Top      = 159
                .Left     = 665
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg14", "Label")
            WITH loc_oPage.lbl_g_Optg14
                .Caption  = "Contabiliza Comiss" + CHR(227) + "o :"
                .Top      = 235
                .Left     = 653
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup14", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup14
                .Top         = 231
                .Left        = 765
                .Width       = 230
                .Height      = 63
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "1"
                    .Left = 0
                    .Top = 0
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "2"
                    .Left = 0
                    .Top = 21
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "3"
                    .Left = 0
                    .Top = 42
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg15", "Label")
            WITH loc_oPage.lbl_g_Optg15
                .Caption  = "Checa Lim. Cr" + CHR(233) + "dito da Conta :"
                .Top      = 299
                .Left     = 616
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup15", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup15
                .Top         = 296
                .Left        = 765
                .Width       = 92
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 47
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg17", "Label")
            WITH loc_oPage.lbl_g_Optg17
                .Caption  = "Bloquia Uso B" + CHR(244) + "nus :"
                .Top      = 324
                .Left     = 666
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup17", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup17
                .Top         = 321
                .Left        = 765
                .Width       = 92
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 47
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_g_Optg16", "Label")
            WITH loc_oPage.lbl_g_Optg16
                .Caption  = "Bloqueia Altera" + CHR(231) + CHR(227) + "o no Vcto :"
                .Top      = 349
                .Left     = 625
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup16", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup16
                .Top         = 346
                .Left        = 765
                .Width       = 230
                .Height      = 45
                .ButtonCount = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "1"
                    .Left = 0
                    .Top = 0
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "2"
                    .Left = 0
                    .Top = 15
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(3)
                    .Caption = "3"
                    .Left = 0
                    .Top = 30
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.CriarPaginaGeral: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CriarPaginaCartaoTEF(par_oPage)
    *==========================================================================
        LOCAL loc_oPage
        loc_oPage = par_oPage
        TRY
            && --- Texto Financiamento (EditBox) ---
            loc_oPage.AddObject("lbl_t_TxtFinanc", "Label")
            WITH loc_oPage.lbl_t_TxtFinanc
                .Caption  = "Texto Financiamento"
                .Top      = 5
                .Left     = 520
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_EdtTxtFinanc", "EditBox")
            WITH loc_oPage.obj_4c_EdtTxtFinanc
                .Top     = 19
                .Left    = 520
                .Width   = 467
                .Height  = 142
                .Visible = .T.
            ENDWITH

            && --- Grupo/Conta credito cartao ---
            loc_oPage.AddObject("lbl_t_Grupo2", "Label")
            WITH loc_oPage.lbl_t_Grupo2
                .Caption  = "Grupo Cr" + CHR(233) + "d. :"
                .Top      = 175
                .Left     = 520
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Grupo2", "TextBox")
            WITH loc_oPage.txt_4c_Grupo2
                .Top       = 172
                .Left      = 590
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Contao", "Label")
            WITH loc_oPage.lbl_t_Contao
                .Caption  = "Conta :"
                .Top      = 175
                .Left     = 680
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Contao", "TextBox")
            WITH loc_oPage.txt_4c_Contao
                .Top       = 172
                .Left      = 720
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Dcontao", "Label")
            WITH loc_oPage.lbl_t_Dcontao
                .Caption  = "Descr. :"
                .Top      = 175
                .Left     = 810
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Dcontao", "TextBox")
            WITH loc_oPage.txt_4c_Dcontao
                .Top       = 172
                .Left      = 850
                .Width     = 130
                .Height    = 21
                .MaxLength = 40
                .ReadOnly  = .T.
                .Visible   = .T.
            ENDWITH

            && --- Grupo/Conta taxa cartao ---
            loc_oPage.AddObject("lbl_t_GrTxCart", "Label")
            WITH loc_oPage.lbl_t_GrTxCart
                .Caption  = "Gr.Taxa Cart" + CHR(227) + "o :"
                .Top      = 200
                .Left     = 520
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_GrTxCart", "TextBox")
            WITH loc_oPage.txt_4c_GrTxCart
                .Top       = 197
                .Left      = 610
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_CnTxCart", "Label")
            WITH loc_oPage.lbl_t_CnTxCart
                .Caption  = "Conta :"
                .Top      = 200
                .Left     = 700
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_CnTxCart", "TextBox")
            WITH loc_oPage.txt_4c_CnTxCart
                .Top       = 197
                .Left      = 740
                .Width     = 80
                .Height    = 21
                .MaxLength = 10
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_DCnTxCart", "Label")
            WITH loc_oPage.lbl_t_DCnTxCart
                .Caption  = "Descr. :"
                .Top      = 200
                .Left     = 830
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_DCnTxCart", "TextBox")
            WITH loc_oPage.txt_4c_DCnTxCart
                .Top       = 197
                .Left      = 870
                .Width     = 110
                .Height    = 21
                .MaxLength = 40
                .ReadOnly  = .T.
                .Visible   = .T.
            ENDWITH

            && --- Descricao Cartao ---
            loc_oPage.AddObject("lbl_t_Dcarts", "Label")
            WITH loc_oPage.lbl_t_Dcarts
                .Caption  = "Descri" + CHR(231) + CHR(227) + "o Cart" + CHR(227) + "o :"
                .Top      = 93
                .Left     = 74
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c__dcarts", "TextBox")
            WITH loc_oPage.txt_4c__dcarts
                .Top       = 90
                .Left      = 175
                .Width     = 200
                .Height    = 21
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH

            && --- Carauts ---
            loc_oPage.AddObject("lbl_t_Carauts", "Label")
            WITH loc_oPage.lbl_t_Carauts
                .Caption  = "[1]Lojista / [2]Administradora / [E]scolher"
                .Top      = 198
                .Left     = 198
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c__carauts", "TextBox")
            WITH loc_oPage.txt_4c__carauts
                .Top       = 195
                .Left      = 144
                .Width     = 50
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH

            && --- Maquina Automatica ---
            loc_oPage.AddObject("lbl_t_Autotef", "Label")
            WITH loc_oPage.lbl_t_Autotef
                .Caption  = "M" + CHR(225) + "quina Autom" + CHR(225) + "tica :"
                .Top      = 121
                .Left     = 59
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            && --- Intervalo de Parcelas ---
            loc_oPage.AddObject("lbl_t_ParIni", "Label")
            WITH loc_oPage.lbl_t_ParIni
                .Caption  = "Intervalo de Parcelas de :"
                .Top      = 121
                .Left     = 257
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_ParIni", "TextBox")
            WITH loc_oPage.txt_4c_ParIni
                .Top       = 118
                .Left      = 390
                .Width     = 30
                .Height    = 21
                .MaxLength = 2
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_t_A", "Label")
            WITH loc_oPage.lbl_t_A
                .Caption  = CHR(224)
                .Top      = 121
                .Left     = 426
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_ParFin", "TextBox")
            WITH loc_oPage.txt_4c_ParFin
                .Top       = 118
                .Left      = 435
                .Width     = 30
                .Height    = 21
                .MaxLength = 2
                .Visible   = .T.
            ENDWITH

            && --- Bandeira ---
            loc_oPage.AddObject("lbl_t_Band", "Label")
            WITH loc_oPage.lbl_t_Band
                .Caption  = "Bandeira :"
                .Top      = 146
                .Left     = 332
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Band", "TextBox")
            WITH loc_oPage.txt_4c_Band
                .Top       = 143
                .Left      = 390
                .Width     = 100
                .Height    = 21
                .MaxLength = 20
                .Visible   = .T.
            ENDWITH

            && --- Taxa Cartao ---
            loc_oPage.AddObject("lbl_t_Taxa", "Label")
            WITH loc_oPage.lbl_t_Taxa
                .Caption  = "Taxa Cart" + CHR(227) + "o :"
                .Top      = 146
                .Left     = 96
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Taxa", "TextBox")
            WITH loc_oPage.txt_4c_Taxa
                .Top       = 143
                .Left      = 163
                .Width     = 60
                .Height    = 21
                .MaxLength = 5
                .Visible   = .T.
            ENDWITH

            && --- Prazo Para Pagamento ---
            loc_oPage.AddObject("lbl_t_Prazo", "Label")
            WITH loc_oPage.lbl_t_Prazo
                .Caption  = "Prazo Para Pagamento :"
                .Top      = 172
                .Left     = 47
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Prazo", "TextBox")
            WITH loc_oPage.txt_4c_Prazo
                .Top       = 169
                .Left      = 163
                .Width     = 50
                .Height    = 21
                .MaxLength = 3
                .Visible   = .T.
            ENDWITH

            && --- Valor Minimo Parcela ---
            loc_oPage.AddObject("lbl_t_VlrMinPar", "Label")
            WITH loc_oPage.lbl_t_VlrMinPar
                .Caption  = "Vlr. M" + CHR(237) + "n. Parcela :"
                .Top      = 220
                .Left     = 50
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_VlrMinPar", "TextBox")
            WITH loc_oPage.txt_4c_VlrMinPar
                .Top       = 217
                .Left      = 163
                .Width     = 80
                .Height    = 21
                .MaxLength = 11
                .Visible   = .T.
            ENDWITH

            && --- DigCartao, Garantia, Saque, CDC, Hists ---
            loc_oPage.AddObject("lbl_t_DigCartao", "Label")
            WITH loc_oPage.lbl_t_DigCartao
                .Caption  = "Dig. Cart" + CHR(227) + "o :"
                .Top      = 250
                .Left     = 50
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_DigCartao", "TextBox")
            WITH loc_oPage.txt_4c_DigCartao
                .Top       = 247
                .Left      = 115
                .Width     = 31
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_t_DigCartH", "Label")
            WITH loc_oPage.lbl_t_DigCartH
                .Caption  = "[S/N]"
                .Top      = 250
                .Left     = 151
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Garantia", "Label")
            WITH loc_oPage.lbl_t_Garantia
                .Caption  = "Garantia :"
                .Top      = 276
                .Left     = 50
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Garantia", "TextBox")
            WITH loc_oPage.txt_4c_Garantia
                .Top       = 273
                .Left      = 115
                .Width     = 50
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_t_GarH", "Label")
            WITH loc_oPage.lbl_t_GarH
                .Caption  = "[S/N]"
                .Top      = 276
                .Left     = 171
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Saque", "Label")
            WITH loc_oPage.lbl_t_Saque
                .Caption  = "Saque :"
                .Top      = 302
                .Left     = 50
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Saque", "TextBox")
            WITH loc_oPage.txt_4c_Saque
                .Top       = 299
                .Left      = 115
                .Width     = 31
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_t_SaqH", "Label")
            WITH loc_oPage.lbl_t_SaqH
                .Caption  = "[S/N]"
                .Top      = 302
                .Left     = 151
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_CDC", "Label")
            WITH loc_oPage.lbl_t_CDC
                .Caption  = "CDC :"
                .Top      = 328
                .Left     = 50
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_CDC", "TextBox")
            WITH loc_oPage.txt_4c_CDC
                .Top       = 325
                .Left      = 115
                .Width     = 31
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("lbl_t_CDCH", "Label")
            WITH loc_oPage.lbl_t_CDCH
                .Caption  = "[S/N]"
                .Top      = 328
                .Left     = 151
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Hists", "Label")
            WITH loc_oPage.lbl_t_Hists
                .Caption  = "Hist" + CHR(243) + "rico :"
                .Top      = 355
                .Left     = 50
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Hists", "TextBox")
            WITH loc_oPage.txt_4c_Hists
                .Top       = 352
                .Left      = 115
                .Width     = 200
                .Height    = 21
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH

            && --- Adquirente, Finalz, Dfinalz ---
            loc_oPage.AddObject("lbl_t_Adquire", "Label")
            WITH loc_oPage.lbl_t_Adquire
                .Caption  = "Adquirente :"
                .Top      = 365
                .Left     = 598
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Adquire", "TextBox")
            WITH loc_oPage.txt_4c_Adquire
                .Top       = 362
                .Left      = 670
                .Width     = 80
                .Height    = 21
                .MaxLength = 8
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Finalz", "Label")
            WITH loc_oPage.lbl_t_Finalz
                .Caption  = "Finalizadora Cupom Fiscal :"
                .Top      = 290
                .Left     = 529
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Finalz", "TextBox")
            WITH loc_oPage.txt_4c_Finalz
                .Top       = 287
                .Left      = 670
                .Width     = 24
                .Height    = 21
                .MaxLength = 1
                .Visible   = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Dfinalz", "TextBox")
            WITH loc_oPage.txt_4c_Dfinalz
                .Top       = 287
                .Left      = 696
                .Width     = 100
                .Height    = 21
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Cupom", "Label")
            WITH loc_oPage.lbl_t_Cupom
                .Caption  = "Cupom :"
                .Top      = 340
                .Left     = 529
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Cupom", "TextBox")
            WITH loc_oPage.txt_4c_Cupom
                .Top       = 337
                .Left      = 590
                .Width     = 60
                .Height    = 21
                .MaxLength = 20
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Estab", "Label")
            WITH loc_oPage.lbl_t_Estab
                .Caption  = "C" + CHR(243) + "digo do Estabelecimento :"
                .Top      = 342
                .Left     = 522
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Estab", "TextBox")
            WITH loc_oPage.txt_4c_Estab
                .Top       = 355
                .Left      = 650
                .Width     = 60
                .Height    = 21
                .MaxLength = 8
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Item", "Label")
            WITH loc_oPage.lbl_t_Item
                .Caption  = "Item :"
                .Top      = 380
                .Left     = 529
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("txt_4c_Item", "TextBox")
            WITH loc_oPage.txt_4c_Item
                .Top       = 377
                .Left      = 590
                .Width     = 80
                .Height    = 21
                .MaxLength = 11
                .Visible   = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_Financ", "Label")
            WITH loc_oPage.lbl_t_Financ
                .Caption  = "Financiamento :"
                .Top      = 355
                .Left     = 87
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH

            loc_oPage.AddObject("lbl_t_TipoCartao", "Label")
            WITH loc_oPage.lbl_t_TipoCartao
                .Caption = "[C]r" + CHR(233) + "dito / [D]" + CHR(233) + "bito / [F]ininvest / [P]Cons.CDC Deb / [O]Cons CDC Cred"
                .Top     = 218
                .Left    = 198
                .Width   = 199
                .Height  = 24
                .Visible = .T.
            ENDWITH

            && OptionGroups TEF
            loc_oPage.AddObject("lbl_t_Optg2pg2", "Label")
            WITH loc_oPage.lbl_t_Optg2pg2
                .Caption  = "Local de Pesquisa do Cheque :"
                .Top      = 315
                .Left     = 512
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup2_p2", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup2_p2
                .Top         = 386
                .Left        = 670
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_t_CompVinc", "Label")
            WITH loc_oPage.lbl_t_CompVinc
                .Caption  = "Comprovante Vinculado :"
                .Top      = 240
                .Left     = 538
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup1_p2", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup1_p2
                .Top         = 237
                .Left        = 670
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            && --- Espelhos P2 de Page1 (somente exibicao, Enabled=.F.) ---
            loc_oPage.AddObject("lbl_t_Optg12_p2", "Label")
            WITH loc_oPage.lbl_t_Optg12_p2
                .Caption  = "Det. Fec. Cx :"
                .Top      = 407
                .Left     = 30
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup12_p2", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup12_p2
                .Top         = 403
                .Left        = 170
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Enabled     = .F.
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_t_Optg4_p2", "Label")
            WITH loc_oPage.lbl_t_Optg4_p2
                .Caption  = "Aprova" + CHR(231) + CHR(227) + "o :"
                .Top      = 415
                .Left     = 615
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup4_p2", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup4_p2
                .Top         = 411
                .Left        = 670
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Enabled     = .F.
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

            loc_oPage.AddObject("lbl_t_Optg3_p2", "Label")
            WITH loc_oPage.lbl_t_Optg3_p2
                .Caption  = "Itens Obrig. :"
                .Top      = 439
                .Left     = 615
                .AutoSize = .T.
                .Visible  = .T.
            ENDWITH
            loc_oPage.AddObject("obj_4c_Optiongroup3_p2", "OptionGroup")
            WITH loc_oPage.obj_4c_Optiongroup3_p2
                .Top         = 435
                .Left        = 670
                .Width       = 97
                .Height      = 23
                .ButtonCount = 2
                .Enabled     = .F.
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption = "S"
                    .Left = 0
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption = "N"
                    .Left = 50
                    .Top = 2
                    .AutoSize = .T.
                    .ForeColor = RGB(0,0,0)
                    .Themes = .F.
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.CriarPaginaCartaoTEF: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oConteiner)
    *==========================================================================
        LOCAL loc_nI, loc_oCtrl
        TRY
            FOR loc_nI = 1 TO par_oConteiner.ControlCount
                loc_oCtrl = par_oConteiner.Controls(loc_nI)
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    IF !INLIST(LOWER(loc_oCtrl.Name), "cnt_4c_botoes", "cnt_4c_salva")
                        loc_oCtrl.Visible = .T.
                    ENDIF
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    IF loc_oCtrl.Visible AND !INLIST(LOWER(loc_oCtrl.Name), "cnt_4c_botoes", "cnt_4c_salva")
                        THIS.TornarControlesVisiveis(loc_oCtrl)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro("Erro em TornarControlesVisiveis: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
    *==========================================================================
        LOCAL loc_oPgf1, loc_oPage2, loc_oPgf2, loc_oP1, loc_oP2
        TRY
            loc_oPage2 = THIS.pgf_4c_Paginas.Pages(2)
            loc_oPgf2  = loc_oPage2.pgf_4c_Dados
            loc_oP1    = loc_oPgf2.Pages(1)
            loc_oP2    = loc_oPgf2.Pages(2)

            WITH THIS.this_oBusinessObject
                && Cabecalho
                .this_cFpags     = ALLTRIM(loc_oPage2.txt_4c_Codigo.Value)
                .this_cDescrs    = ALLTRIM(loc_oPage2.txt_4c_Descrs.Value)
                .this_cTitfpags  = ALLTRIM(loc_oPage2.txt_4c_TitFPags.Value)
                .this_cFormas    = ALLTRIM(loc_oPage2.txt_4c_Forma.Value)
                .this_cNfpags    = VAL(ALLTRIM(loc_oPage2.txt_4c_Nfpag.Value))
                .this_cModpagto  = ALLTRIM(loc_oPage2.txt_4c_Modalidade.Value)
                .this_cGrupods   = ALLTRIM(loc_oPage2.txt_4c_Grupo.Value)
                .this_cContads   = ALLTRIM(loc_oPage2.txt_4c_Conta.Value)
                .this_cDcontads  = ALLTRIM(loc_oPage2.txt_4c_Dconta.Value)
                .this_nOrides    = loc_oPage2.obj_4c_Opt_ContaMov.Value - 1

                && Pagina Geral
                .this_nEntradas  = ALLTRIM(loc_oP1.txt_4c_Entrada.Value)
                .this_nDias      = ALLTRIM(loc_oP1.txt_4c_Dias.Value)
                .this_nFparcs    = ALLTRIM(loc_oP1.txt_4c_Parcelas.Value)
                .this_cMoefpgs   = ALLTRIM(loc_oP1.txt_4c___formas.Value)
                .this_cSituas    = ALLTRIM(loc_oP1.txt_4c__Situa.Value)
                .this_cTvens     = ALLTRIM(loc_oP1.txt_4c_VENC.Value)
                .this_cInfos     = ALLTRIM(loc_oP1.txt_4c_INFO.Value)
                .this_cColdados  = ALLTRIM(loc_oP1.txt_4c_ChqObrig.Value)
                .this_cEmps      = ALLTRIM(loc_oP1.txt_4c_EmpLanc.Value)
                .this_cGrupoemp  = ALLTRIM(loc_oP1.txt_4c_GrupoEmp.Value)
                .this_cCpictures = ALLTRIM(loc_oP1.txt_4c_Picture.Value)
                .this_nVlrfpgs   = ALLTRIM(loc_oP1.txt_4c_Valor.Value)
                .this_nDescs     = ALLTRIM(loc_oP1.txt_4c_Desconto.Value)
                .this_nFpcomiss  = ALLTRIM(loc_oP1.txt_4c_Comissao.Value)
                .this_nEncargos  = ALLTRIM(loc_oP1.txt_4c_Encargos.Value)
                .this_nPvarias   = ALLTRIM(loc_oP1.txt_4c_PVaria.Value)
                .this_nIndices   = ALLTRIM(loc_oP1.txt_4c_Indice.Value)
                .this_nTaxjuros  = ALLTRIM(loc_oP1.txt_4c_TaxJuros.Value)
                .this_nTolfcxs   = ALLTRIM(loc_oP1.txt_4c_TolFecCx.Value)
                .this_cBancos    = ALLTRIM(loc_oP1.txt_4c_Bancos.Value)
                .this_cAgencias  = ALLTRIM(loc_oP1.txt_4c_Agencias.Value)
                .this_cNcontas   = ALLTRIM(loc_oP1.txt_4c_NContas.Value)
                .this_cEspecies  = ALLTRIM(loc_oP1.txt_4c_EspecieNfs.Value)
                .this_nValpends  = loc_oP1.obj_4c_Op_valpend.Value - 1
                .this_nBxcomis   = loc_oP1.obj_4c_Op_BxComis.Value - 1
                .this_nEmichqs   = loc_oP1.obj_4c_Op_Emichqs.Value - 1
                .this_nImpchqs   = loc_oP1.obj_4c_Op_ImpChqs.Value - 1
                .this_nImpbols   = loc_oP1.obj_4c_OptImpBols.Value - 1
                .this_nImpdups   = loc_oP1.obj_4c_OptImpDups.Value - 1
                .this_nBlqtabds  = loc_oP1.obj_4c_Optiongroup13.Value - 1
                .this_nLiscongv  = loc_oP1.obj_4c_Opt_Liscongv.Value - 1
                .this_nMesfec    = loc_oP1.obj_4c_Optiongroup7.Value - 1
                .this_nAgcobs    = loc_oP1.obj_4c_Optiongroup10.Value - 1
                .this_nTrocos    = loc_oP1.obj_4c_OptTrocos.Value - 1
                .this_nBxcomchqs = loc_oP1.obj_4c_Optiongroup5.Value - 1
                .this_nBaixas    = loc_oP1.obj_4c_Optiongroup2.Value - 1
                .this_nAcumulas  = loc_oP1.obj_4c_Optiongroup8.Value - 1
                .this_nItemobrigs = loc_oP1.obj_4c_Optiongroup3.Value - 1
                .this_nAprovas   = loc_oP1.obj_4c_Optiongroup4.Value - 1
                .this_nDetFecCxs = loc_oP1.obj_4c_Optiongroup12.Value - 1
                .this_nOptcredcta = loc_oP1.obj_4c_Fwoption1.Value - 1
                .this_nTpcheques = loc_oP1.obj_4c_Optiongroup11.Value - 1
                .this_nTpvencs   = loc_oP1.obj_4c_OptTpLeituras.Value - 1
                .this_nOpcsnas   = loc_oP1.obj_4c_OpcaoSNA.Value - 1
                .this_nAutenticas = loc_oP1.obj_4c_Optiongroup6.Value - 1
                .this_nObs       = loc_oP1.obj_4c_OptObserva.Value - 1
                .this_nGavetas   = loc_oP1.obj_4c_Optiongroup1.Value - 1
                .this_nRelmetvend = loc_oP1.obj_4c_Optiongroup14.Value - 1
                .this_nChklimcre = loc_oP1.obj_4c_Optiongroup15.Value - 1
                .this_nRelsomsub = loc_oP1.obj_4c_Optiongroup17.Value - 1
                .this_nBlqvctopar = loc_oP1.obj_4c_Optiongroup16.Value - 1
                .this_nImpbols   = loc_oP1.obj_4c_OptFechm.Value - 1

                && Pagina Cartao/TEF
                .this_cMfinancs  = loc_oP2.obj_4c_EdtTxtFinanc.Value
                .this_cGrupoos   = ALLTRIM(loc_oP2.txt_4c_Grupo2.Value)
                .this_cContaos   = ALLTRIM(loc_oP2.txt_4c_Contao.Value)
                .this_cDcontaos  = ALLTRIM(loc_oP2.txt_4c_Dcontao.Value)
                .this_cGrupobs   = ALLTRIM(loc_oP2.txt_4c_GrTxCart.Value)
                .this_cContabs   = ALLTRIM(loc_oP2.txt_4c_CnTxCart.Value)
                .this_cDcarts    = ALLTRIM(loc_oP2.txt_4c__dcarts.Value)
                .this_cCarauts   = ALLTRIM(loc_oP2.txt_4c__carauts.Value)
                .this_cParcini   = ALLTRIM(loc_oP2.txt_4c_ParIni.Value)
                .this_cParcfin   = ALLTRIM(loc_oP2.txt_4c_ParFin.Value)
                .this_cBandeira  = ALLTRIM(loc_oP2.txt_4c_Band.Value)
                .this_nTaxjuros  = ALLTRIM(loc_oP2.txt_4c_Taxa.Value)
                .this_nPrazos    = ALLTRIM(loc_oP2.txt_4c_Prazo.Value)
                .this_nVlrminpar = ALLTRIM(loc_oP2.txt_4c_VlrMinPar.Value)
                .this_cCitems    = ALLTRIM(loc_oP2.txt_4c_DigCartao.Value)
                .this_cGarantias = ALLTRIM(loc_oP2.txt_4c_Garantia.Value)
                .this_cLsaque    = ALLTRIM(loc_oP2.txt_4c_Saque.Value)
                .this_cTcdc      = ALLTRIM(loc_oP2.txt_4c_CDC.Value)
                .this_cHists     = ALLTRIM(loc_oP2.txt_4c_Hists.Value)
                .this_cAdquirente = ALLTRIM(loc_oP2.txt_4c_Adquire.Value)
                .this_cOperacaoss = ALLTRIM(loc_oP2.txt_4c_Finalz.Value)
                .this_cOperacaoes = ALLTRIM(loc_oP2.txt_4c_Dfinalz.Value)
                .this_cCcupomnvs = ALLTRIM(loc_oP2.txt_4c_Cupom.Value)
                .this_cCodestabs = ALLTRIM(loc_oP2.txt_4c_Estab.Value)
                .this_cCitems    = ALLTRIM(loc_oP2.txt_4c_Item.Value)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.FormParaBO: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *==========================================================================
        LOCAL loc_oPage2, loc_oPgf2, loc_oP1, loc_oP2
        TRY
            loc_oPage2 = THIS.pgf_4c_Paginas.Pages(2)
            loc_oPgf2  = loc_oPage2.pgf_4c_Dados
            loc_oP1    = loc_oPgf2.Pages(1)
            loc_oP2    = loc_oPgf2.Pages(2)

            WITH THIS.this_oBusinessObject
                && Cabecalho
                loc_oPage2.txt_4c_Codigo.Value    = .this_cFpags
                loc_oPage2.txt_4c_Descrs.Value    = .this_cDescrs
                loc_oPage2.txt_4c_TitFPags.Value  = .this_cTitfpags
                loc_oPage2.txt_4c_Forma.Value     = .this_cFormas
                loc_oPage2.txt_4c_Nfpag.Value     = ALLTRIM(STR(.this_nNfpags))
                loc_oPage2.txt_4c_Modalidade.Value = .this_cModpagto
                loc_oPage2.txt_4c_Grupo.Value     = .this_cGrupods
                loc_oPage2.txt_4c_Conta.Value     = .this_cContads
                loc_oPage2.txt_4c_Dconta.Value    = .this_cDcontads
                loc_oPage2.obj_4c_Opt_ContaMov.Value = .this_nOrides + 1

                && Pagina Geral
                loc_oP1.txt_4c_Entrada.Value    = ALLTRIM(STR(.this_nEntradas))
                loc_oP1.txt_4c_Dias.Value       = ALLTRIM(STR(.this_nDias))
                loc_oP1.txt_4c_Parcelas.Value   = ALLTRIM(STR(.this_nFparcs))
                loc_oP1.txt_4c___formas.Value   = .this_cMoefpgs
                loc_oP1.txt_4c__Situa.Value     = .this_cSituas
                loc_oP1.txt_4c_VENC.Value       = .this_cTvens
                loc_oP1.txt_4c_INFO.Value       = .this_cInfos
                loc_oP1.txt_4c_ChqObrig.Value   = .this_cColdados
                loc_oP1.txt_4c_EmpLanc.Value    = .this_cEmps
                loc_oP1.txt_4c_GrupoEmp.Value   = .this_cGrupoemp
                loc_oP1.txt_4c_Picture.Value    = .this_cCpictures
                loc_oP1.txt_4c_Valor.Value      = ALLTRIM(STR(.this_nVlrfpgs, 14, 2))
                loc_oP1.txt_4c_Desconto.Value   = ALLTRIM(STR(.this_nDescs, 8, 2))
                loc_oP1.txt_4c_Comissao.Value   = ALLTRIM(STR(.this_nFpcomiss, 8, 2))
                loc_oP1.txt_4c_Encargos.Value   = ALLTRIM(STR(.this_nEncargos, 8, 2))
                loc_oP1.txt_4c_PVaria.Value     = ALLTRIM(STR(.this_nPvarias, 8, 2))
                loc_oP1.txt_4c_Indice.Value     = ALLTRIM(STR(.this_nIndices, 9, 3))
                loc_oP1.txt_4c_TaxJuros.Value   = ALLTRIM(STR(.this_nTaxjuros, 12, 4))
                loc_oP1.txt_4c_TolFecCx.Value   = ALLTRIM(STR(.this_nTolfcxs, 8, 2))
                loc_oP1.txt_4c_Bancos.Value     = .this_cBancos
                loc_oP1.txt_4c_Agencias.Value   = .this_cAgencias
                loc_oP1.txt_4c_NContas.Value    = .this_cNcontas
                loc_oP1.txt_4c_EspecieNfs.Value = .this_cEspecies
                loc_oP1.obj_4c_Op_valpend.Value = IIF(.this_nValpends = 0, 2, .this_nValpends + 1)
                loc_oP1.obj_4c_Op_BxComis.Value = IIF(.this_nBxcomis = 0, 2, .this_nBxcomis + 1)
                loc_oP1.obj_4c_Op_Emichqs.Value = IIF(.this_nEmichqs = 0, 2, .this_nEmichqs + 1)
                loc_oP1.obj_4c_Op_ImpChqs.Value = IIF(.this_nImpchqs = 0, 2, .this_nImpchqs + 1)
                loc_oP1.obj_4c_OptImpBols.Value = IIF(.this_nImpbols = 0, 2, .this_nImpbols + 1)
                loc_oP1.obj_4c_OptImpDups.Value = IIF(.this_nImpdups = 0, 2, .this_nImpdups + 1)
                loc_oP1.obj_4c_Optiongroup13.Value = IIF(.this_nBlqtabds = 0, 2, .this_nBlqtabds + 1)
                loc_oP1.obj_4c_Opt_Liscongv.Value = IIF(.this_nLiscongv = 0, 2, .this_nLiscongv + 1)
                loc_oP1.obj_4c_OptFechm.Value   = IIF(.this_nMesfec = 0, 2, .this_nMesfec + 1)
                loc_oP1.obj_4c_Optiongroup7.Value = IIF(.this_nMesfec = 0, 2, .this_nMesfec + 1)
                loc_oP1.obj_4c_Optiongroup10.Value = IIF(.this_nAgcobs = 0, 2, .this_nAgcobs + 1)
                loc_oP1.obj_4c_OptTrocos.Value  = IIF(.this_nTrocos = 0, 2, .this_nTrocos + 1)
                loc_oP1.obj_4c_Optiongroup5.Value = IIF(.this_nBxcomchqs = 0, 2, .this_nBxcomchqs + 1)
                loc_oP1.obj_4c_Optiongroup2.Value = IIF(.this_nBaixas = 0, 2, .this_nBaixas + 1)
                loc_oP1.obj_4c_Optiongroup8.Value = IIF(.this_nAcumulas = 0, 2, .this_nAcumulas + 1)
                loc_oP1.obj_4c_Optiongroup3.Value = IIF(.this_nItemobrigs = 0, 2, .this_nItemobrigs + 1)
                loc_oP1.obj_4c_Optiongroup4.Value = IIF(.this_nAprovas = 0, 2, .this_nAprovas + 1)
                loc_oP1.obj_4c_Optiongroup12.Value = IIF(.this_nDetFecCxs = 0, 2, .this_nDetFecCxs + 1)
                loc_oP1.obj_4c_Fwoption1.Value  = IIF(.this_nOptcredcta = 0, 2, .this_nOptcredcta + 1)
                loc_oP1.obj_4c_Optiongroup11.Value = IIF(.this_nTpcheques = 0, 2, .this_nTpcheques + 1)
                loc_oP1.obj_4c_OptTpLeituras.Value = IIF(.this_nTpvencs = 0, 2, .this_nTpvencs + 1)
                loc_oP1.obj_4c_OpcaoSNA.Value   = IIF(.this_nOpcsnas = 0, 2, .this_nOpcsnas + 1)
                loc_oP1.obj_4c_Optiongroup6.Value = IIF(.this_nAutenticas = 0, 2, .this_nAutenticas + 1)
                loc_oP1.obj_4c_OptObserva.Value = IIF(.this_nObs = 0, 2, .this_nObs + 1)
                loc_oP1.obj_4c_Optiongroup1.Value = IIF(.this_nGavetas = 0, 2, .this_nGavetas + 1)
                loc_oP1.obj_4c_Optiongroup14.Value = IIF(.this_nRelmetvend = 0, 2, .this_nRelmetvend + 1)
                loc_oP1.obj_4c_Optiongroup15.Value = IIF(.this_nChklimcre = 0, 2, .this_nChklimcre + 1)
                loc_oP1.obj_4c_Optiongroup17.Value = IIF(.this_nRelsomsub = 0, 2, .this_nRelsomsub + 1)
                loc_oP1.obj_4c_Optiongroup16.Value = IIF(.this_nBlqvctopar = 0, 2, .this_nBlqvctopar + 1)

                && Pagina Cartao/TEF
                loc_oP2.obj_4c_EdtTxtFinanc.Value = .this_cMfinancs
                loc_oP2.txt_4c_Grupo2.Value     = .this_cGrupoos
                loc_oP2.txt_4c_Contao.Value     = .this_cContaos
                loc_oP2.txt_4c_Dcontao.Value    = .this_cDcontaos
                loc_oP2.txt_4c_GrTxCart.Value   = .this_cGrupobs
                loc_oP2.txt_4c_CnTxCart.Value   = .this_cContabs
                loc_oP2.txt_4c__dcarts.Value    = .this_cDcarts
                loc_oP2.txt_4c__carauts.Value   = .this_cCarauts
                loc_oP2.txt_4c_ParIni.Value     = .this_cParcini
                loc_oP2.txt_4c_ParFin.Value     = .this_cParcfin
                loc_oP2.txt_4c_Band.Value       = .this_cBandeira
                loc_oP2.txt_4c_Taxa.Value       = ALLTRIM(STR(.this_nTaxjuros, 8, 2))
                loc_oP2.txt_4c_Prazo.Value      = ALLTRIM(STR(.this_nPrazos))
                loc_oP2.txt_4c_VlrMinPar.Value  = ALLTRIM(STR(.this_nVlrminpar, 14, 2))
                loc_oP2.txt_4c_DigCartao.Value  = .this_cCitems
                loc_oP2.txt_4c_Garantia.Value   = .this_cGarantias
                loc_oP2.txt_4c_Saque.Value      = .this_cLsaque
                loc_oP2.txt_4c_CDC.Value        = .this_cTcdc
                loc_oP2.txt_4c_Hists.Value      = .this_cHists
                loc_oP2.txt_4c_Adquire.Value    = .this_cAdquirente
                loc_oP2.txt_4c_Finalz.Value     = .this_cOperacaoss
                loc_oP2.txt_4c_Dfinalz.Value    = .this_cOperacaoes
                loc_oP2.txt_4c_Cupom.Value      = .this_cCcupomnvs
                loc_oP2.txt_4c_Estab.Value      = .this_cCodestabs
                loc_oP2.txt_4c_Item.Value       = .this_cCitems
                && Espelhos P2 (somente exibicao, refletem P1)
                loc_oP2.obj_4c_Optiongroup12_p2.Value = IIF(.this_nDetFecCxs = 0, 2, .this_nDetFecCxs + 1)
                loc_oP2.obj_4c_Optiongroup4_p2.Value  = IIF(.this_nAprovas = 0, 2, .this_nAprovas + 1)
                loc_oP2.obj_4c_Optiongroup3_p2.Value  = IIF(.this_nItemobrigs = 0, 2, .this_nItemobrigs + 1)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BOParaForm: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
    *==========================================================================
        LOCAL loc_oPage2, loc_oPgf2, loc_oP1, loc_oP2
        TRY
            loc_oPage2 = THIS.pgf_4c_Paginas.Pages(2)
            loc_oPgf2  = loc_oPage2.pgf_4c_Dados
            loc_oP1    = loc_oPgf2.Pages(1)
            loc_oP2    = loc_oPgf2.Pages(2)

            && Cabecalho
            loc_oPage2.txt_4c_Codigo.Value    = ""
            loc_oPage2.txt_4c_Descrs.Value    = ""
            loc_oPage2.txt_4c_TitFPags.Value  = ""
            loc_oPage2.txt_4c_Forma.Value     = ""
            loc_oPage2.txt_4c_Nfpag.Value     = ""
            loc_oPage2.txt_4c_Modalidade.Value = ""
            loc_oPage2.txt_4c_Grupo.Value     = ""
            loc_oPage2.txt_4c_Conta.Value     = ""
            loc_oPage2.txt_4c_Dconta.Value    = ""
            loc_oPage2.obj_4c_Opt_ContaMov.Value = 1

            && Pagina Geral
            loc_oP1.txt_4c_Entrada.Value   = ""
            loc_oP1.txt_4c_Dias.Value      = ""
            loc_oP1.txt_4c_Parcelas.Value  = ""
            loc_oP1.txt_4c___formas.Value  = ""
            loc_oP1.txt_4c__Situa.Value    = ""
            loc_oP1.txt_4c_VENC.Value      = ""
            loc_oP1.txt_4c_INFO.Value      = ""
            loc_oP1.txt_4c_ChqObrig.Value  = ""
            loc_oP1.txt_4c_EmpLanc.Value   = ""
            loc_oP1.txt_4c_GrupoEmp.Value  = ""
            loc_oP1.txt_4c_Picture.Value   = ""
            loc_oP1.txt_4c_Valor.Value     = ""
            loc_oP1.txt_4c_Desconto.Value  = ""
            loc_oP1.txt_4c_Comissao.Value  = ""
            loc_oP1.txt_4c_Encargos.Value  = ""
            loc_oP1.txt_4c_PVaria.Value    = ""
            loc_oP1.txt_4c_Indice.Value    = ""
            loc_oP1.txt_4c_TaxJuros.Value  = ""
            loc_oP1.txt_4c_TolFecCx.Value  = ""
            loc_oP1.txt_4c_Bancos.Value    = ""
            loc_oP1.txt_4c_Agencias.Value  = ""
            loc_oP1.txt_4c_NContas.Value   = ""
            loc_oP1.txt_4c_EspecieNfs.Value = ""
            loc_oP1.obj_4c_Op_valpend.Value    = 1
            loc_oP1.obj_4c_Op_BxComis.Value    = 1
            loc_oP1.obj_4c_Op_Emichqs.Value    = 1
            loc_oP1.obj_4c_Op_ImpChqs.Value    = 1
            loc_oP1.obj_4c_OptImpBols.Value    = 1
            loc_oP1.obj_4c_OptImpDups.Value    = 1
            loc_oP1.obj_4c_Optiongroup13.Value = 1
            loc_oP1.obj_4c_Opt_Liscongv.Value  = 1
            loc_oP1.obj_4c_OptFechm.Value      = 1
            loc_oP1.obj_4c_Optiongroup7.Value  = 1
            loc_oP1.obj_4c_Optiongroup10.Value = 1
            loc_oP1.obj_4c_OptTrocos.Value     = 1
            loc_oP1.obj_4c_Optiongroup5.Value  = 1
            loc_oP1.obj_4c_Optiongroup2.Value  = 1
            loc_oP1.obj_4c_Optiongroup8.Value  = 1
            loc_oP1.obj_4c_Optiongroup3.Value  = 1
            loc_oP1.obj_4c_Optiongroup4.Value  = 1
            loc_oP1.obj_4c_Optiongroup12.Value = 1
            loc_oP1.obj_4c_Fwoption1.Value     = 1
            loc_oP1.obj_4c_Optiongroup11.Value = 1
            loc_oP1.obj_4c_OptTpLeituras.Value = 1
            loc_oP1.obj_4c_OpcaoSNA.Value      = 1
            loc_oP1.obj_4c_Optiongroup6.Value  = 1
            loc_oP1.obj_4c_OptObserva.Value    = 1
            loc_oP1.obj_4c_Optiongroup1.Value  = 1
            loc_oP1.obj_4c_Optiongroup14.Value = 1
            loc_oP1.obj_4c_Optiongroup15.Value = 1
            loc_oP1.obj_4c_Optiongroup17.Value = 1
            loc_oP1.obj_4c_Optiongroup16.Value = 1

            && Pagina Cartao/TEF
            loc_oP2.obj_4c_EdtTxtFinanc.Value = ""
            loc_oP2.txt_4c_Grupo2.Value    = ""
            loc_oP2.txt_4c_Contao.Value    = ""
            loc_oP2.txt_4c_Dcontao.Value   = ""
            loc_oP2.txt_4c_GrTxCart.Value  = ""
            loc_oP2.txt_4c_CnTxCart.Value  = ""
            loc_oP2.txt_4c__dcarts.Value   = ""
            loc_oP2.txt_4c__carauts.Value  = ""
            loc_oP2.txt_4c_ParIni.Value    = ""
            loc_oP2.txt_4c_ParFin.Value    = ""
            loc_oP2.txt_4c_Band.Value      = ""
            loc_oP2.txt_4c_Taxa.Value      = ""
            loc_oP2.txt_4c_Prazo.Value     = ""
            loc_oP2.txt_4c_VlrMinPar.Value = ""
            loc_oP2.txt_4c_DigCartao.Value = ""
            loc_oP2.txt_4c_Garantia.Value  = ""
            loc_oP2.txt_4c_Saque.Value     = ""
            loc_oP2.txt_4c_CDC.Value       = ""
            loc_oP2.txt_4c_Hists.Value     = ""
            loc_oP2.txt_4c_Adquire.Value   = ""
            loc_oP2.txt_4c_Finalz.Value    = ""
            loc_oP2.txt_4c_Dfinalz.Value   = ""
            loc_oP2.txt_4c_Cupom.Value     = ""
            loc_oP2.txt_4c_Estab.Value     = ""
            loc_oP2.txt_4c_Item.Value      = ""
            && Espelhos P2
            loc_oP2.obj_4c_Optiongroup12_p2.Value = 1
            loc_oP2.obj_4c_Optiongroup4_p2.Value  = 1
            loc_oP2.obj_4c_Optiongroup3_p2.Value  = 1
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.LimparCampos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    *==========================================================================
        LOCAL loc_oPage2, loc_oPgf2, loc_oP1, loc_oP2, loc_lReadOnly
        TRY
            loc_lReadOnly = !par_lHabilitar
            loc_oPage2 = THIS.pgf_4c_Paginas.Pages(2)
            loc_oPgf2  = loc_oPage2.pgf_4c_Dados
            loc_oP1    = loc_oPgf2.Pages(1)
            loc_oP2    = loc_oPgf2.Pages(2)

            && Cabecalho
            loc_oPage2.txt_4c_Codigo.ReadOnly    = loc_lReadOnly
            loc_oPage2.txt_4c_Descrs.ReadOnly    = loc_lReadOnly
            loc_oPage2.txt_4c_TitFPags.ReadOnly  = loc_lReadOnly
            loc_oPage2.txt_4c_Forma.ReadOnly     = loc_lReadOnly
            loc_oPage2.txt_4c_Nfpag.ReadOnly     = loc_lReadOnly
            loc_oPage2.txt_4c_Modalidade.ReadOnly = loc_lReadOnly
            loc_oPage2.txt_4c_Grupo.ReadOnly     = loc_lReadOnly
            loc_oPage2.txt_4c_Conta.ReadOnly     = loc_lReadOnly
            loc_oPage2.obj_4c_Opt_ContaMov.Enabled = par_lHabilitar

            && Pagina Geral
            loc_oP1.txt_4c_Entrada.ReadOnly   = loc_lReadOnly
            loc_oP1.txt_4c_Dias.ReadOnly      = loc_lReadOnly
            loc_oP1.txt_4c_Parcelas.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c___formas.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c__Situa.ReadOnly    = loc_lReadOnly
            loc_oP1.txt_4c_VENC.ReadOnly      = loc_lReadOnly
            loc_oP1.txt_4c_INFO.ReadOnly      = loc_lReadOnly
            loc_oP1.txt_4c_ChqObrig.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_EmpLanc.ReadOnly   = loc_lReadOnly
            loc_oP1.txt_4c_GrupoEmp.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_Picture.ReadOnly   = loc_lReadOnly
            loc_oP1.txt_4c_Valor.ReadOnly     = loc_lReadOnly
            loc_oP1.txt_4c_Desconto.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_Comissao.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_Encargos.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_PVaria.ReadOnly    = loc_lReadOnly
            loc_oP1.txt_4c_Indice.ReadOnly    = loc_lReadOnly
            loc_oP1.txt_4c_TaxJuros.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_TolFecCx.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_Bancos.ReadOnly    = loc_lReadOnly
            loc_oP1.txt_4c_Agencias.ReadOnly  = loc_lReadOnly
            loc_oP1.txt_4c_NContas.ReadOnly   = loc_lReadOnly
            loc_oP1.txt_4c_EspecieNfs.ReadOnly = loc_lReadOnly
            loc_oP1.obj_4c_Op_valpend.Enabled    = par_lHabilitar
            loc_oP1.obj_4c_Op_BxComis.Enabled    = par_lHabilitar
            loc_oP1.obj_4c_Op_Emichqs.Enabled    = par_lHabilitar
            loc_oP1.obj_4c_Op_ImpChqs.Enabled    = par_lHabilitar
            loc_oP1.obj_4c_OptImpBols.Enabled    = par_lHabilitar
            loc_oP1.obj_4c_OptImpDups.Enabled    = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup13.Enabled = par_lHabilitar
            loc_oP1.obj_4c_Opt_Liscongv.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_OptFechm.Enabled      = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup7.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup10.Enabled = par_lHabilitar
            loc_oP1.obj_4c_OptTrocos.Enabled     = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup5.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup2.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup8.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup3.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup4.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup12.Enabled = par_lHabilitar
            loc_oP1.obj_4c_Fwoption1.Enabled     = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup11.Enabled = par_lHabilitar
            loc_oP1.obj_4c_OptTpLeituras.Enabled = par_lHabilitar
            loc_oP1.obj_4c_OpcaoSNA.Enabled      = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup6.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_OptObserva.Enabled    = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup1.Enabled  = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup14.Enabled = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup15.Enabled = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup17.Enabled = par_lHabilitar
            loc_oP1.obj_4c_Optiongroup16.Enabled = par_lHabilitar

            && Pagina Cartao/TEF
            loc_oP2.obj_4c_EdtTxtFinanc.ReadOnly = loc_lReadOnly
            loc_oP2.txt_4c_Grupo2.ReadOnly   = loc_lReadOnly
            loc_oP2.txt_4c_Contao.ReadOnly   = loc_lReadOnly
            loc_oP2.txt_4c_GrTxCart.ReadOnly = loc_lReadOnly
            loc_oP2.txt_4c_CnTxCart.ReadOnly = loc_lReadOnly
            loc_oP2.txt_4c__dcarts.ReadOnly  = loc_lReadOnly
            loc_oP2.txt_4c__carauts.ReadOnly = loc_lReadOnly
            loc_oP2.txt_4c_ParIni.ReadOnly   = loc_lReadOnly
            loc_oP2.txt_4c_ParFin.ReadOnly   = loc_lReadOnly
            loc_oP2.txt_4c_Band.ReadOnly     = loc_lReadOnly
            loc_oP2.txt_4c_Taxa.ReadOnly     = loc_lReadOnly
            loc_oP2.txt_4c_Prazo.ReadOnly    = loc_lReadOnly
            loc_oP2.txt_4c_VlrMinPar.ReadOnly = loc_lReadOnly
            loc_oP2.txt_4c_DigCartao.ReadOnly = loc_lReadOnly
            loc_oP2.txt_4c_Garantia.ReadOnly = loc_lReadOnly
            loc_oP2.txt_4c_Saque.ReadOnly    = loc_lReadOnly
            loc_oP2.txt_4c_CDC.ReadOnly      = loc_lReadOnly
            loc_oP2.txt_4c_Hists.ReadOnly    = loc_lReadOnly
            loc_oP2.txt_4c_Adquire.ReadOnly  = loc_lReadOnly
            loc_oP2.txt_4c_Finalz.ReadOnly   = loc_lReadOnly
            loc_oP2.txt_4c_Dfinalz.ReadOnly  = loc_lReadOnly
            loc_oP2.txt_4c_Cupom.ReadOnly    = loc_lReadOnly
            loc_oP2.txt_4c_Estab.ReadOnly    = loc_lReadOnly
            loc_oP2.txt_4c_Item.ReadOnly     = loc_lReadOnly
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.HabilitarCampos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
    *==========================================================================
        LOCAL loc_oPage1, loc_oPage2, loc_lEdicao
        TRY
            loc_oPage1 = THIS.pgf_4c_Paginas.Pages(1)
            loc_oPage2 = THIS.pgf_4c_Paginas.Pages(2)
            loc_lEdicao = (par_cModo = "INCLUIR" OR par_cModo = "ALTERAR")

            DO CASE
            CASE par_cModo = "LISTA"
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                loc_oPage2.cnt_4c_Salva.Visible = .F.
            CASE par_cModo = "INCLUIR" OR par_cModo = "ALTERAR"
                THIS.pgf_4c_Paginas.ActivePage = 2
                loc_oPage2.cnt_4c_Salva.Visible = .T.
            CASE par_cModo = "VISUALIZAR"
                THIS.pgf_4c_Paginas.ActivePage = 2
                loc_oPage2.cnt_4c_Salva.Visible = .F.
            ENDCASE

            THIS.HabilitarCampos(loc_lEdicao)
            THIS.this_cModoAtual = par_cModo
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                IF USED("cursor_4c_Dados")
                    THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.RecordSource = "cursor_4c_Dados"
                    THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.fpags"
                    THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.descrs"
                    THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.moefpgs"
                    THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.dias"
                    THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column5.ControlSource = "cursor_4c_Dados.tvens"
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.CarregarLista: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnIncluirClick()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.LimparCampos()
            THIS.this_oBusinessObject.this_lNovoRegistro = .T.
            THIS.AjustarBotoesPorModo("INCLUIR")
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnIncluirClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para visualizar.", "Aviso")
            ELSE
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.fpags)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.BOParaForm()
                    THIS.AjustarBotoesPorModo("VISUALIZAR")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnVisualizarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para alterar.", "Aviso")
            ELSE
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.fpags)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.BOParaForm()
                    THIS.AjustarBotoesPorModo("ALTERAR")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnAlterarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para excluir.", "Aviso")
            ELSE
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.fpags)
                IF MsgConfirma("Deseja excluir a condi" + CHR(231) + CHR(227) + "o '" + loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir(loc_cCodigo)
                        THIS.CarregarLista()
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnExcluirClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_oBusca, loc_cCodigo, loc_cSQL
        loc_lResultado = .F.

        TRY
            && Pattern A: SQL no caller
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

            loc_cSQL = "SELECT fpags, descrs FROM SigOpFp ORDER BY fpags"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Busca") < 0
                SET NULL ON
                CREATE CURSOR cursor_4c_Busca (fpags C(12), descrs C(30))
                SET NULL OFF
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                loc_oBusca.DefinirCursor("cursor_4c_Busca", "fpags", "descrs", "Busca de Condi" + CHR(231) + CHR(245) + "es de Pagamento")
                loc_oBusca.Mostrar()

                loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                IF !EMPTY(loc_cCodigo)
                    THIS.this_oBusinessObject.Buscar("fpags = '" + loc_cCodigo + "'")
                    IF USED("cursor_4c_Dados")
                        THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.RecordSource = "cursor_4c_Dados"
                        THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.fpags"
                        THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.descrs"
                        THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.moefpgs"
                        THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.dias"
                        THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column5.ControlSource = "cursor_4c_Dados.tvens"
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnBuscarClick: " + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSalvarClick()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.this_lNovoRegistro
                loc_lResultado = THIS.this_oBusinessObject.Inserir()
            ELSE
                loc_lResultado = THIS.this_oBusinessObject.Atualizar()
            ENDIF

            IF loc_lResultado
                THIS.CarregarLista()
                THIS.AjustarBotoesPorModo("LISTA")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnSalvarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick()
    *==========================================================================
        TRY
            THIS.AjustarBotoesPorModo("LISTA")
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnCancelarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *==========================================================================
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnEncerrarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExportarClick()
    *==========================================================================
        TRY
            MsgAviso("Funcionalidade de exportar XML n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Aviso")
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnExportarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnImportarClick()
    *==========================================================================
        TRY
            MsgAviso("Funcionalidade de importar XML n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Aviso")
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnImportarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCopiarClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_cCodOrigem, loc_cCodDestino, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro de origem para copiar.", "Aviso")
            ELSE
                loc_cCodOrigem  = ALLTRIM(cursor_4c_Dados.fpags)
                loc_cCodDestino = INPUTBOX("Digite o c" + CHR(243) + "digo da nova condi" + CHR(231) + CHR(227) + "o:", "Copiar Condi" + CHR(231) + CHR(227) + "o", "")

                IF !EMPTY(ALLTRIM(loc_cCodDestino))
                    loc_cCodDestino = ALLTRIM(loc_cCodDestino)

                    && Verificar se destino ja existe
                    loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpFp WHERE fpags = " + EscaparSQL(loc_cCodDestino)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerDest") >= 0
                        IF cursor_4c_VerDest.qtd > 0
                            MsgAviso("C" + CHR(243) + "digo '" + loc_cCodDestino + "' j" + CHR(225) + " existe.")
                            IF USED("cursor_4c_VerDest")
                                USE IN cursor_4c_VerDest
                            ENDIF
                        ELSE
                            IF USED("cursor_4c_VerDest")
                                USE IN cursor_4c_VerDest
                            ENDIF

                            && Copiar registro
                            loc_cSQL = "INSERT INTO SigOpFp SELECT " + ;
                                       EscaparSQL(loc_cCodDestino) + ", descrs, titfpags, formas, moefpgs, " + ;
                                       "infos, situas, codfpags, nfpags, modpagto, grupods, contads, dcontads, " + ;
                                       "orides, grupoos, contaos, dcontaos, grupobs, contabs, grupots, contats, " + ;
                                       "bancos, agencias, ncontas, tvens, carauts, coldados, hists, ccupomnvs, " + ;
                                       "operautos, operacaoss, operacaoes, cpictures, garantias, lcartao, lsaque, " + ;
                                       "opers, parcs, autotef, tcdc, pcheque, dadchqs, codestabs, citems, dcarts, " + ;
                                       "adquirente, emps, parcfin, parcini, bandeira, cdcashback, especies, grupoemp, " + ;
                                       "mfinancs, datatrans, aprovas, itemobrigs, bxcomis, cpags, desc2s, descs, dias, " + ;
                                       "emichqs, encargos, entradas, fparcs, fpcomiss, impbols, prazos, trocos, " + ;
                                       "valpends, impnotas, impdups, obs, tphists, ncodfinzs, impchqs, emivales, " + ;
                                       "gavetas, tpcheques, baixas, bxcomchqs, autenticas, mesfec, acvchqs, acumulas, " + ;
                                       "promos, agcobs, tolfcxs, tpvencs, pvarias, indices, libcsens, impcpchqs, " + ;
                                       "blqtabds, chkbins, chkfidels, nfinancs, opcsnas, vlrfpgs, liscongv, cnidtefs, " + ;
                                       "detfecCxs, taxjuros, ndtcomis, chkcpf, libctablq, nsu, chklimcre, relsomsub, " + ;
                                       "chkvalgar, chknccmov, arredonda, chkcachbk, chkuticach, autoriza, blqvctopar, " + ;
                                       "vlrminpar, vlrlimfpgs, optcredcta, relmetvend " + ;
                                       "FROM SigOpFp WHERE fpags = " + EscaparSQL(loc_cCodOrigem)

                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResult >= 0
                                THIS.CarregarLista()
                                MsgInfo("Condi" + CHR(231) + CHR(227) + "o '" + loc_cCodOrigem + "' copiada para '" + loc_cCodDestino + "'.", "Sucesso")
                                loc_lResultado = .T.
                            ELSE
                                MsgErro("Erro ao copiar: " + CapturarErroSQL(), "Erro SQL")
                            ENDIF
                        ENDIF
                    ELSE
                        MsgErro("Erro ao verificar destino: " + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnCopiarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnMinimoClick()
    *==========================================================================
        TRY
            MsgAviso("Funcionalidade de configurar m" + CHR(237) + "nimo n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Aviso")
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnMinimoClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnDescontoClick()
    *==========================================================================
        TRY
            MsgAviso("Funcionalidade de desconto n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Aviso")
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnDescontoClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBINClick()
    *==========================================================================
        TRY
            MsgAviso("Funcionalidade BIN n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Aviso")
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.BtnBINClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            IF USED("cursor_4c_VerDest")
                USE IN cursor_4c_VerDest
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpag.Destroy: " + loc_oErro.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
