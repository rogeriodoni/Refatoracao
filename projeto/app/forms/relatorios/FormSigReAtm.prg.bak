*==============================================================================
* FORMSIGREATM.PRG
* Relatorio Analise por Tipo de Material
* Tipo: REPORT (herda FormBase, BO: SigReAtmBO herda RelatorioBase)
* Migrado de: SIGREATM.SCX (frmrelatorio)
*
* Filtros (layout flat - controles em cnt_4c_Local na Page1):
*   - Periodo (DataIni/DataFin)
*   - Tipo de O.P. (TpGOp)               -> cursor_4c_TpGOp
*   - Grupo de Balanco (Grupo/DGrupo)    -> SigCdGcr / cursor_4c_GruposBal
*   - Conta/Cliente (Conta/DConta)       -> SigCdCli / cursor_4c_Clientes
*   - Grande Grupo (Ggrp/DGGrp)         -> SigCdGpr
*   - Grupo Materia Prima (CGru/DGru)   -> SigCdGrp
*   - Subgrupo Materia Prima (CSGru/DsGru) -> SigCdPsg
*   - Modelo/Finalidade (CodFinP/DesFinP)   -> SigCdFip
*   - Acabamento (CodAcb/DAcb)          -> SigCdAca
*   - Classificacao (Class/DClass)       -> SigCdCls
*   - Dimensoes (TamPs/TamHs/TamLs)
*   - Moeda (CdMoeda/DsMoeda)           -> SigCdMoe / crSigCdMoe
*   - Envelope / N. OP
*   - Agrupamento (opt_4c_Agru: 1=Analitico 2=Modelo 3=Classif 4=Conta)
*   - Grid de Tipos de Material (cursor_4c_TiposMat) com checkbox Marca
*   - cnt_4c_Ope: grid grd_4c_Dados + cmd_4c_SelTudo + cmd_4c_Apagar
*==============================================================================

DEFINE CLASS FormSigReAtm AS FormBase

    *-- Dimensoes EXATAS do original SIGREATM.SCX
    Height      = 550
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta toda a estrutura do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "An" + CHR(225) + "lise por Tipo de Material"
            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SigReAtmBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReAtmBO" + CHR(13) + ;
                    "VARTYPE: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.InicializarDados()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Erro ao inicializar dados")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarMensagem()
                THIS.ConfigurarBINDEVENTs()
                THIS.AlternarPagina(1)
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.LimparCampos()
                ENDIF
                THIS.Visible   = .T.
                loc_lSucesso   = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSigReAtm:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro cinza medio com titulo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 17
            .Left      = 12
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 30
            .Caption   = "An" + CHR(225) + "lise por Tipo de Material"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 20
            .Left      = 10
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 30
            .Caption   = "An" + CHR(225) + "lise por Tipo de Material"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup btnReport: 4 botoes Visualizar/Imprimir
    *   /DocExcel/Encerrar. Posicao EXATA do original (Left=527).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 527
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Caption         = "Visualizar"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .Visible         = .T.
        ENDWITH
        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Caption         = "Imprimir"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .Visible         = .T.
        ENDWITH
        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "Doc Excel"
            .WordWrap        = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "geral_excel_26.jpg"
            .Visible         = .T.
        ENDWITH
        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Encerrar"
            .WordWrap        = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame 1 pagina abaixo do cabecalho (Top=85)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas
        loc_oPgf.PageCount = 1
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.
        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Entry point canonico para a unica Page do form de
    *   relatorio. Em frmrelatorio NAO existe Page1=Lista + Page2=Dados (padrao
    *   CRUD). A "lista" aqui sao os filtros + grid de tipos de material que o
    *   usuario seleciona antes de gerar o relatorio. Garante a Picture de
    *   fundo (regra #88/#90) e delega para ConfigurarFiltros, que monta:
    *     - cnt_4c_Local : container com TODOS os filtros (datas/codigos/opcoes)
    *     - cnt_4c_Ope   : container com grd_4c_Dados (tipos de material) e
    *                      cmd_4c_SelTudo / cmd_4c_Apagar
    *   Botoes "CRUD" deste form sao os 4 do CommandGroup cmg_4c_Botoes
    *   (Visualizar/Imprimir/DocExcel/Encerrar), criados em ConfigurarBotoes()
    *   fora do PageFrame conforme padrao frmrelatorio do framework.vcx.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF TYPE("gc_4c_CaminhoIcones") = "U"
            gc_4c_CaminhoIcones = ""
        ENDIF
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria container pai cnt_4c_Local e a PRIMEIRA
    *   METADE dos campos de filtro do relatorio (Periodo, TpGOp, Grupo de
    *   Balanco, Conta/Cliente, Grande Grupo, Grupo Mat. Prima, Subgrupo
    *   Mat. Prima). Em forms REPORT (layout flat) este metodo eh o
    *   equivalente conceitual da Page2 de forms CRUD: monta a area de
    *   captura de parametros sobre a Page1. A segunda metade dos filtros
    *   + o grid de tipos de material eh adicionada por ConfigurarFiltros.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg, loc_oCnt
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.AddObject("cnt_4c_Local", "Container")
        WITH loc_oPg.cnt_4c_Local
            .Top         = 0
            .Left        = 0
            .Width       = 800
            .Height      = 465
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oCnt = loc_oPg.cnt_4c_Local

        *-- Periodo -----------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oCnt.lbl_4c_Periodo
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Per" + CHR(237) + "odo :"
            .Left      = 83
            .Top       = 39
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DataIni", "TextBox")
        WITH loc_oCnt.txt_4c_DataIni
            .Height        = 23
            .Left          = 132
            .Top           = 35
            .Width         = 80
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Ate", "Label")
        WITH loc_oCnt.lbl_4c_Ate
            .AutoSize  = .T.
            .FontSize  = 8
            .Caption   = " at" + CHR(233) + " "
            .Left      = 216
            .Top       = 39
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DataFin", "TextBox")
        WITH loc_oCnt.txt_4c_DataFin
            .Height        = 23
            .Left          = 240
            .Top           = 35
            .Width         = 80
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        *-- Tipo de O.P. ------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_TpGOp", "Label")
        WITH loc_oCnt.lbl_4c_TpGOp
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Tipo de O.P.:"
            .Left      = 62
            .Top       = 63
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_TpGOp", "TextBox")
        WITH loc_oCnt.txt_4c_TpGOp
            .Height        = 23
            .Left          = 132
            .Top           = 59
            .Width         = 80
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Grupo de Balanco --------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oCnt.lbl_4c_Grupo
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Grupo :"
            .Left      = 90
            .Top       = 87
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oCnt.txt_4c_Grupo
            .Height        = 23
            .Left          = 132
            .Top           = 83
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oCnt.txt_4c_DGrupo
            .Height        = 23
            .Left          = 213
            .Top           = 83
            .Width         = 280
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Conta/Cliente -----------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oCnt.lbl_4c_Conta
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Conta :"
            .Left      = 90
            .Top       = 111
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oCnt.txt_4c_Conta
            .Height        = 23
            .Left          = 132
            .Top           = 107
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oCnt.txt_4c_DConta
            .Height        = 23
            .Left          = 213
            .Top           = 107
            .Width         = 280
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Grande Grupo de Produto -------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Ggrp", "Label")
        WITH loc_oCnt.lbl_4c_Ggrp
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Grande Grupo :"
            .Height    = 15
            .Left      = 52
            .Top       = 135
            .Width     = 76
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Ggrp", "TextBox")
        WITH loc_oCnt.txt_4c_Ggrp
            .Height        = 23
            .Left          = 132
            .Top           = 131
            .Width         = 31
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DGGrp", "TextBox")
        WITH loc_oCnt.txt_4c_DGGrp
            .Height        = 23
            .Left          = 164
            .Top           = 131
            .Width         = 158
            .MaxLength     = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Enabled       = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Grupo de Materia Prima --------------------------------------------
        loc_oCnt.AddObject("lbl_4c_CGru", "Label")
        WITH loc_oCnt.lbl_4c_CGru
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Grupo Mat. Prima :"
            .Height    = 15
            .Left      = 36
            .Top       = 159
            .Width     = 92
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CGru", "TextBox")
        WITH loc_oCnt.txt_4c_CGru
            .Height        = 23
            .Left          = 132
            .Top           = 155
            .Width         = 31
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DGru", "TextBox")
        WITH loc_oCnt.txt_4c_DGru
            .Height        = 23
            .Left          = 164
            .Top           = 155
            .Width         = 158
            .MaxLength     = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Subgrupo de Materia Prima -----------------------------------------
        loc_oCnt.AddObject("lbl_4c_CSGru", "Label")
        WITH loc_oCnt.lbl_4c_CSGru
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Subgrupo Mat. Prima:"
            .Height    = 15
            .Left      = 22
            .Top       = 183
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CSGru", "TextBox")
        WITH loc_oCnt.txt_4c_CSGru
            .Height        = 23
            .Left          = 132
            .Top           = 179
            .Width         = 52
            .MaxLength     = 6
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DsGru", "TextBox")
        WITH loc_oCnt.txt_4c_DsGru
            .Height        = 23
            .Left          = 185
            .Top           = 179
            .Width         = 150
            .MaxLength     = 20
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltros - Adiciona a SEGUNDA METADE dos filtros (Modelo,
    *   Acabamento, Classificacao, Dimensoes, Moeda, Envelope, OP, Agrupamento)
    *   e cria cnt_4c_Ope com o grid de tipos de material (cursor_4c_TiposMat).
    *   Chamado por ConfigurarPaginaLista APOS ConfigurarPaginaDados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
        LOCAL loc_oCnt, loc_oOpe, loc_oGrd
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local

        *-- Modelo/Finalidade de Produto --------------------------------------
        loc_oCnt.AddObject("lbl_4c_Modelo", "Label")
        WITH loc_oCnt.lbl_4c_Modelo
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Caption   = "Modelo :"
            .Height    = 15
            .Left      = 24
            .Top       = 207
            .Width     = 104
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CodFinP", "TextBox")
        WITH loc_oCnt.txt_4c_CodFinP
            .Height        = 23
            .Left          = 132
            .Top           = 203
            .Width         = 31
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DesFinP", "TextBox")
        WITH loc_oCnt.txt_4c_DesFinP
            .Height        = 23
            .Left          = 164
            .Top           = 203
            .Width         = 150
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Acabamento --------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Acab", "Label")
        WITH loc_oCnt.lbl_4c_Acab
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Caption   = "Acabamento :"
            .Height    = 15
            .Left      = 24
            .Top       = 231
            .Width     = 104
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CodAcb", "TextBox")
        WITH loc_oCnt.txt_4c_CodAcb
            .Height        = 23
            .Left          = 132
            .Top           = 227
            .Width         = 31
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DAcb", "TextBox")
        WITH loc_oCnt.txt_4c_DAcb
            .Height        = 23
            .Left          = 164
            .Top           = 227
            .Width         = 150
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Classificacao -----------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Class", "Label")
        WITH loc_oCnt.lbl_4c_Class
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
            .Height    = 15
            .Left      = 24
            .Top       = 255
            .Width     = 104
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Class", "TextBox")
        WITH loc_oCnt.txt_4c_Class
            .Height        = 23
            .Left          = 132
            .Top           = 251
            .Width         = 31
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DClass", "TextBox")
        WITH loc_oCnt.txt_4c_DClass
            .Height        = 23
            .Left          = 164
            .Top           = 251
            .Width         = 150
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Dimensoes ---------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Dimen", "Label")
        WITH loc_oCnt.lbl_4c_Dimen
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Dimens" + CHR(227) + "o :"
            .Height    = 15
            .Left      = 73
            .Top       = 279
            .Width     = 55
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_TamPs", "TextBox")
        WITH loc_oCnt.txt_4c_TamPs
            .Height        = 23
            .Left          = 132
            .Top           = 275
            .Width         = 58
            .InputMask     = "999.99"
            .MaxLength     = 6
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_P", "Label")
        WITH loc_oCnt.lbl_4c_P
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "p"
            .Height    = 15
            .Left      = 192
            .Top       = 279
            .Width     = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_TamHs", "TextBox")
        WITH loc_oCnt.txt_4c_TamHs
            .Height        = 23
            .Left          = 219
            .Top           = 275
            .Width         = 58
            .InputMask     = "999.99"
            .MaxLength     = 6
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_A", "Label")
        WITH loc_oCnt.lbl_4c_A
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "a"
            .Height    = 15
            .Left      = 280
            .Top       = 279
            .Width     = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_TamLs", "TextBox")
        WITH loc_oCnt.txt_4c_TamLs
            .Height        = 23
            .Left          = 307
            .Top           = 275
            .Width         = 58
            .InputMask     = "999.99"
            .MaxLength     = 6
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_C", "Label")
        WITH loc_oCnt.lbl_4c_C
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "c"
            .Height    = 15
            .Left      = 367
            .Top       = 279
            .Width     = 7
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Moeda de Conversao ------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oCnt.lbl_4c_Moeda
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Moeda :"
            .Left      = 87
            .Top       = 303
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CdMoeda", "TextBox")
        WITH loc_oCnt.txt_4c_CdMoeda
            .Height        = 23
            .Left          = 132
            .Top           = 299
            .Width         = 31
            .MaxLength     = 3
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DsMoeda", "TextBox")
        WITH loc_oCnt.txt_4c_DsMoeda
            .Height        = 23
            .Left          = 164
            .Top           = 299
            .Width         = 202
            .MaxLength     = 15
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Envelope e N. OP --------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Envelope", "Label")
        WITH loc_oCnt.lbl_4c_Envelope
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Envelope :"
            .Left      = 75
            .Top       = 327
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Envelope", "TextBox")
        WITH loc_oCnt.txt_4c_Envelope
            .Height        = 23
            .Left          = 132
            .Top           = 323
            .Width         = 80
            .MaxLength     = 10
            .InputMask     = "9999999999"
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Nop", "Label")
        WITH loc_oCnt.lbl_4c_Nop
            .AutoSize  = .T.
            .FontSize  = 8
            .Caption   = "O.P. :"
            .Left      = 220
            .Top       = 327
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Nop", "TextBox")
        WITH loc_oCnt.txt_4c_Nop
            .Height        = 23
            .Left          = 255
            .Top           = 323
            .Width         = 58
            .MaxLength     = 6
            .InputMask     = "999999"
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Agrupamento (OptionGroup) -----------------------------------------
        loc_oCnt.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oCnt.lbl_4c_Tipo
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Tipo :"
            .Left      = 99
            .Top       = 354
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("opt_4c_Agru", "OptionGroup")
        WITH loc_oCnt.opt_4c_Agru
            .Top         = 348
            .Left        = 126
            .Width       = 300
            .Height      = 28
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 4
            .Visible     = .T.
        ENDWITH
        WITH loc_oCnt.opt_4c_Agru.Buttons(1)
            .Caption   = "Anal" + CHR(237) + "tico"
            .Left      = 5
            .Top       = 6
            .Width     = 58
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Comic Sans MS"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oCnt.opt_4c_Agru.Buttons(2)
            .Caption   = "Modelo"
            .Left      = 78
            .Top       = 6
            .Width     = 55
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Comic Sans MS"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oCnt.opt_4c_Agru.Buttons(3)
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o"
            .WordWrap        = .T.
            .Left      = 143
            .Top       = 6
            .Width     = 79
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oCnt.opt_4c_Agru.Buttons(4)
            .Caption   = "Conta"
            .WordWrap        = .T.
            .Left      = 242
            .Top       = 6
            .Width     = 47
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Checkboxes (ocultos - original Visible=.F.) -----------------------
        loc_oCnt.AddObject("chk_4c_Destino", "CheckBox")
        WITH loc_oCnt.chk_4c_Destino
            .Top       = 377
            .Left      = 136
            .Height    = 15
            .Width     = 118
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Analisar pelo Destino"
            .Value     = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_Produtos", "CheckBox")
        WITH loc_oCnt.chk_4c_Produtos
            .Top       = 396
            .Left      = 153
            .Height    = 15
            .Width     = 123
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Imprimir Produtos"
            .Value     = 0
            .Enabled   = .F.
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .F.
        ENDWITH

        *-- Container do Grid de Tipos de Material ----------------------------
        *-- Original: cntOpe Top=235, Left=440 -> Page: 235-85=150
        loc_oCnt.AddObject("cnt_4c_Ope", "Container")
        WITH loc_oCnt.cnt_4c_Ope
            .Top         = 150
            .Left        = 440
            .Width       = 350
            .Height      = 265
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oOpe = loc_oCnt.cnt_4c_Ope

        loc_oOpe.AddObject("lbl_4c_TipoMat", "Label")
        WITH loc_oOpe.lbl_4c_TipoMat
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .Caption   = "Tipo de material"
            .Height    = 16
            .Left      = 7
            .Top       = 1
            .Width     = 100
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oOpe.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH loc_oOpe.cmd_4c_SelTudo
            .Top         = 87
            .Left        = 306
            .Height      = 40
            .Width       = 40
            .FontName    = "Verdana"
            .FontSize    = 8
            .WordWrap    = .T.
            .Caption     = ""
            .TabStop     = .F.
            .ToolTipText = "Marca todos"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Visible     = .T.
        ENDWITH

        loc_oOpe.AddObject("cmd_4c_Apagar", "CommandButton")
        WITH loc_oOpe.cmd_4c_Apagar
            .Top         = 127
            .Left        = 306
            .Height      = 40
            .Width       = 40
            .FontBold    = .F.
            .FontItalic  = .F.
            .FontName    = "Verdana"
            .FontSize    = 8
            .WordWrap    = .T.
            .Caption     = ""
            .TabStop     = .F.
            .ToolTipText = "Desmarca todos"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Visible     = .T.
        ENDWITH

        IF !USED("cursor_4c_TiposMat")
            CREATE CURSOR cursor_4c_TiposMat (Marca n(1), Cods c(14), Descs c(40))
        ENDIF

        loc_oOpe.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oOpe.grd_4c_Dados
            .ColumnCount    = 2
            .AllowRowSizing = .F.
            .DeleteMark     = .F.
            .GridLines      = 3
            .HeaderHeight   = 0
            .Height         = 240
            .Left           = 5
            .Panel          = 1
            .RecordMark     = .F.
            .RecordSource   = "cursor_4c_TiposMat"
            .RowHeight      = 18
            .ScrollBars     = 2
            .TabStop        = .F.
            .Top            = 17
            .Width          = 300
            .GridLineColor  = RGB(238, 238, 238)
            .FontName       = "Tahoma"
            .Visible        = .T.
        ENDWITH
        loc_oGrd = loc_oOpe.grd_4c_Dados

        WITH loc_oGrd.Column1
            .Width         = 15
            .Sparse        = .F.
            .Alignment     = 0
            .Enabled       = .T.
            .ReadOnly      = .F.
            .FontName      = "Tahoma"
        ENDWITH
        loc_oGrd.Column1.AddObject("chk_4c_Marca", "CheckBox")
        WITH loc_oGrd.Column1.chk_4c_Marca
            .Caption       = ""
            .Alignment     = 0
            .BackStyle     = 0
            .Enabled       = .T.
        ENDWITH
        loc_oGrd.Column1.CurrentControl  = "chk_4c_Marca"
        loc_oGrd.Column1.ControlSource   = "cursor_4c_TiposMat.Marca"

        WITH loc_oGrd.Column2
            .Width         = 220
            .ControlSource = "cursor_4c_TiposMat.Descs"
            .ReadOnly      = .T.
            .Enabled       = .T.
            .FontName      = "Tahoma"
        ENDWITH
        loc_oGrd.Column2.Header1.Caption = "Descrs"
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarMensagem - Cria container "Aguarde!!!" (oculto inicialmente)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarMensagem()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_oCnt.AddObject("cnt_4c_Mensagem", "Container")
        WITH loc_oCnt.cnt_4c_Mensagem
            .Top         = 420
            .Left        = 130
            .Width       = 400
            .Height      = 40
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .F.
        ENDWITH
        loc_oCnt.cnt_4c_Mensagem.AddObject("lbl_4c_LblMensagem", "Label")
        WITH loc_oCnt.cnt_4c_Mensagem.lbl_4c_LblMensagem
            .Top       = 10
            .Left      = 10
            .Width     = 380
            .Height    = 22
            .Caption   = "Aguarde!!!"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Alignment = 2
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBINDEVENTs - Conecta eventos dos controles aos handlers
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        LOCAL loc_oCnt, loc_oOpe
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_oOpe = loc_oCnt.cnt_4c_Ope

        BINDEVENT(THIS.cmg_4c_Botoes,       "Click",    THIS, "CmgBotoesClick")
        BINDEVENT(loc_oCnt.txt_4c_DataIni,  "KeyPress", THIS, "TxtDataIniKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DataFin,  "KeyPress", THIS, "TxtDataFinKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_TpGOp,    "KeyPress", THIS, "TxtTpGOpKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Grupo,    "KeyPress", THIS, "TxtGrupoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DGrupo,   "KeyPress", THIS, "TxtDGrupoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Conta,    "KeyPress", THIS, "TxtContaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DConta,   "KeyPress", THIS, "TxtDContaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Ggrp,     "KeyPress", THIS, "TxtGgrpKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_CGru,     "KeyPress", THIS, "TxtCGruKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DGru,     "KeyPress", THIS, "TxtDGruKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_CSGru,    "KeyPress", THIS, "TxtCSGruKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DsGru,    "KeyPress", THIS, "TxtDsGruKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_CodFinP,  "KeyPress", THIS, "TxtCodFinPKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DesFinP,  "KeyPress", THIS, "TxtDesFinPKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_CodAcb,   "KeyPress", THIS, "TxtCodAcbKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DAcb,     "KeyPress", THIS, "TxtDAcbKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Class,    "KeyPress", THIS, "TxtClassKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DClass,   "KeyPress", THIS, "TxtDClassKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_CdMoeda,  "KeyPress", THIS, "TxtCdMoedaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DsMoeda,  "KeyPress", THIS, "TxtDsMoedaKeyPress")
        BINDEVENT(loc_oOpe.cmd_4c_Apagar,   "Click",    THIS, "CntOpeApagaClick")
        BINDEVENT(loc_oOpe.cmd_4c_SelTudo,  "Click",    THIS, "CntOpeSelTudoClick")

        *-- DblClick: atalho alternativo ao F4 para todos os campos com lookup
        BINDEVENT(loc_oCnt.txt_4c_TpGOp,    "DblClick", THIS, "TxtTpGOpDblClick")
        BINDEVENT(loc_oCnt.txt_4c_Grupo,    "DblClick", THIS, "TxtGrupoDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DGrupo,   "DblClick", THIS, "TxtDGrupoDblClick")
        BINDEVENT(loc_oCnt.txt_4c_Conta,    "DblClick", THIS, "TxtContaDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DConta,   "DblClick", THIS, "TxtDContaDblClick")
        BINDEVENT(loc_oCnt.txt_4c_Ggrp,     "DblClick", THIS, "TxtGgrpDblClick")
        BINDEVENT(loc_oCnt.txt_4c_CGru,     "DblClick", THIS, "TxtCGruDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DGru,     "DblClick", THIS, "TxtDGruDblClick")
        BINDEVENT(loc_oCnt.txt_4c_CSGru,    "DblClick", THIS, "TxtCSGruDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DsGru,    "DblClick", THIS, "TxtDsGruDblClick")
        BINDEVENT(loc_oCnt.txt_4c_CodFinP,  "DblClick", THIS, "TxtCodFinPDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DesFinP,  "DblClick", THIS, "TxtDesFinPDblClick")
        BINDEVENT(loc_oCnt.txt_4c_CodAcb,   "DblClick", THIS, "TxtCodAcbDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DAcb,     "DblClick", THIS, "TxtDAcbDblClick")
        BINDEVENT(loc_oCnt.txt_4c_Class,    "DblClick", THIS, "TxtClassDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DClass,   "DblClick", THIS, "TxtDClassDblClick")
        BINDEVENT(loc_oCnt.txt_4c_CdMoeda,  "DblClick", THIS, "TxtCdMoedaDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DsMoeda,  "DblClick", THIS, "TxtDsMoedaDblClick")

        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa/zera todos os campos de filtro
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_oCnt.txt_4c_DataIni.Value  = DATE()
        loc_oCnt.txt_4c_DataFin.Value  = DATE()
        loc_oCnt.txt_4c_Grupo.Value    = ""
        loc_oCnt.txt_4c_DGrupo.Value   = ""
        loc_oCnt.txt_4c_Conta.Value    = ""
        loc_oCnt.txt_4c_DConta.Value   = ""
        loc_oCnt.txt_4c_Ggrp.Value     = ""
        loc_oCnt.txt_4c_DGGrp.Value    = ""
        loc_oCnt.txt_4c_CGru.Value     = ""
        loc_oCnt.txt_4c_DGru.Value     = ""
        loc_oCnt.txt_4c_CSGru.Value    = ""
        loc_oCnt.txt_4c_DsGru.Value    = ""
        loc_oCnt.txt_4c_CodFinP.Value  = ""
        loc_oCnt.txt_4c_DesFinP.Value  = ""
        loc_oCnt.txt_4c_CodAcb.Value   = ""
        loc_oCnt.txt_4c_DAcb.Value     = ""
        loc_oCnt.txt_4c_Class.Value    = ""
        loc_oCnt.txt_4c_DClass.Value   = ""
        loc_oCnt.txt_4c_TamPs.Value    = 0
        loc_oCnt.txt_4c_TamHs.Value    = 0
        loc_oCnt.txt_4c_TamLs.Value    = 0
        loc_oCnt.txt_4c_CdMoeda.Value  = ""
        loc_oCnt.txt_4c_DsMoeda.Value  = ""
        loc_oCnt.txt_4c_Envelope.Value = 0
        loc_oCnt.txt_4c_Nop.Value      = 0
        loc_oCnt.opt_4c_Agru.Value     = 4
        loc_oCnt.chk_4c_Destino.Value  = 0
        loc_oCnt.chk_4c_Produtos.Value = 0
        *-- Auto-preencher TpGOp se apenas um valor permitido
        IF USED("cursor_4c_TpGOp")
            SELECT cursor_4c_TpGOp
            GO TOP
            IF RECCOUNT("cursor_4c_TpGOp") = 1 AND !EOF("cursor_4c_TpGOp")
                loc_oCnt.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_TpGOp.Codigos)
            ELSE
                loc_oCnt.txt_4c_TpGOp.Value = ""
            ENDIF
        ELSE
            loc_oCnt.txt_4c_TpGOp.Value = ""
        ENDIF
        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarCamposDescricao - Habilita/desabilita campos conforme When original
    *   - DGrupo: habilitado so quando Grupo vazio (busca reversa por nome)
    *   - Conta/DConta: habilitados so quando Grupo preenchido
    *   - DGru: habilitado so quando CGru vazio
    *   - DsGru: habilitado so quando CSGru vazio
    *   - DesFinP/DAcb/DClass/DsMoeda: habilitados so quando codigo vazio
    *   - DGGrp: sempre desabilitado (When = .F.)
    *   - TpGOp: habilitado so quando ha mais de 1 tipo de OP disponivel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarCamposDescricao()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_oCnt.txt_4c_DGrupo.Enabled  = EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
        loc_oCnt.txt_4c_Conta.Enabled   = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
        loc_oCnt.txt_4c_DConta.Enabled  = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)) AND ;
                                           EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
        loc_oCnt.txt_4c_DGru.Enabled    = EMPTY(ALLTRIM(loc_oCnt.txt_4c_CGru.Value))
        loc_oCnt.txt_4c_DsGru.Enabled   = EMPTY(ALLTRIM(loc_oCnt.txt_4c_CSGru.Value))
        loc_oCnt.txt_4c_DesFinP.Enabled = EMPTY(ALLTRIM(loc_oCnt.txt_4c_CodFinP.Value))
        loc_oCnt.txt_4c_DAcb.Enabled    = EMPTY(ALLTRIM(loc_oCnt.txt_4c_CodAcb.Value))
        loc_oCnt.txt_4c_DClass.Enabled  = EMPTY(ALLTRIM(loc_oCnt.txt_4c_Class.Value))
        loc_oCnt.txt_4c_DsMoeda.Enabled = EMPTY(ALLTRIM(loc_oCnt.txt_4c_CdMoeda.Value))
        loc_oCnt.txt_4c_DGGrp.Enabled   = .F.
        IF USED("cursor_4c_TpGOp")
            loc_oCnt.txt_4c_TpGOp.Enabled = RECCOUNT("cursor_4c_TpGOp") > 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND VARTYPE(par_nPagina) = "N" AND ;
           par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere todos os filtros do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        WITH THIS.this_oRelatorio
            .this_dDatai    = loc_oCnt.txt_4c_DataIni.Value
            .this_dDataf    = loc_oCnt.txt_4c_DataFin.Value
            .this_cTpGOp    = ALLTRIM(loc_oCnt.txt_4c_TpGOp.Value)
            .this_cGrupo    = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
            .this_cDGrupo   = ALLTRIM(loc_oCnt.txt_4c_DGrupo.Value)
            .this_cConta    = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
            .this_cDConta   = ALLTRIM(loc_oCnt.txt_4c_DConta.Value)
            .this_cGgrp     = ALLTRIM(loc_oCnt.txt_4c_Ggrp.Value)
            .this_cDGGrp    = ALLTRIM(loc_oCnt.txt_4c_DGGrp.Value)
            .this_cCGru     = ALLTRIM(loc_oCnt.txt_4c_CGru.Value)
            .this_cDGru     = ALLTRIM(loc_oCnt.txt_4c_DGru.Value)
            .this_cCSGru    = ALLTRIM(loc_oCnt.txt_4c_CSGru.Value)
            .this_cDsGru    = ALLTRIM(loc_oCnt.txt_4c_DsGru.Value)
            .this_cCodFinP  = ALLTRIM(loc_oCnt.txt_4c_CodFinP.Value)
            .this_cDesFinP  = ALLTRIM(loc_oCnt.txt_4c_DesFinP.Value)
            .this_cCodAcb   = ALLTRIM(loc_oCnt.txt_4c_CodAcb.Value)
            .this_cDAcb     = ALLTRIM(loc_oCnt.txt_4c_DAcb.Value)
            .this_cClass    = ALLTRIM(loc_oCnt.txt_4c_Class.Value)
            .this_cDClass   = ALLTRIM(loc_oCnt.txt_4c_DClass.Value)
            .this_nTamPs    = loc_oCnt.txt_4c_TamPs.Value
            .this_nTamHs    = loc_oCnt.txt_4c_TamHs.Value
            .this_nTamLs    = loc_oCnt.txt_4c_TamLs.Value
            .this_cCdMoeda  = ALLTRIM(loc_oCnt.txt_4c_CdMoeda.Value)
            .this_cDsMoeda  = ALLTRIM(loc_oCnt.txt_4c_DsMoeda.Value)
            .this_nEnvelope = loc_oCnt.txt_4c_Envelope.Value
            .this_nNop      = loc_oCnt.txt_4c_Nop.Value
            .this_nAgru     = loc_oCnt.opt_4c_Agru.Value
            .this_lDestino  = loc_oCnt.chk_4c_Destino.Value
            .this_lProdutos = loc_oCnt.chk_4c_Produtos.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oCnt
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        WITH THIS.this_oRelatorio
            loc_oCnt.txt_4c_DataIni.Value  = IIF(EMPTY(.this_dDatai),   DATE(), .this_dDatai)
            loc_oCnt.txt_4c_DataFin.Value  = IIF(EMPTY(.this_dDataf),   DATE(), .this_dDataf)
            loc_oCnt.txt_4c_TpGOp.Value    = NVL(.this_cTpGOp,   "")
            loc_oCnt.txt_4c_Grupo.Value    = NVL(.this_cGrupo,   "")
            loc_oCnt.txt_4c_DGrupo.Value   = NVL(.this_cDGrupo,  "")
            loc_oCnt.txt_4c_Conta.Value    = NVL(.this_cConta,   "")
            loc_oCnt.txt_4c_DConta.Value   = NVL(.this_cDConta,  "")
            loc_oCnt.txt_4c_Ggrp.Value     = NVL(.this_cGgrp,    "")
            loc_oCnt.txt_4c_DGGrp.Value    = NVL(.this_cDGGrp,   "")
            loc_oCnt.txt_4c_CGru.Value     = NVL(.this_cCGru,    "")
            loc_oCnt.txt_4c_DGru.Value     = NVL(.this_cDGru,    "")
            loc_oCnt.txt_4c_CSGru.Value    = NVL(.this_cCSGru,   "")
            loc_oCnt.txt_4c_DsGru.Value    = NVL(.this_cDsGru,   "")
            loc_oCnt.txt_4c_CodFinP.Value  = NVL(.this_cCodFinP, "")
            loc_oCnt.txt_4c_DesFinP.Value  = NVL(.this_cDesFinP, "")
            loc_oCnt.txt_4c_CodAcb.Value   = NVL(.this_cCodAcb,  "")
            loc_oCnt.txt_4c_DAcb.Value     = NVL(.this_cDAcb,    "")
            loc_oCnt.txt_4c_Class.Value    = NVL(.this_cClass,   "")
            loc_oCnt.txt_4c_DClass.Value   = NVL(.this_cDClass,  "")
            loc_oCnt.txt_4c_TamPs.Value    = NVL(.this_nTamPs,   0)
            loc_oCnt.txt_4c_TamHs.Value    = NVL(.this_nTamHs,   0)
            loc_oCnt.txt_4c_TamLs.Value    = NVL(.this_nTamLs,   0)
            loc_oCnt.txt_4c_CdMoeda.Value  = NVL(.this_cCdMoeda, "")
            loc_oCnt.txt_4c_DsMoeda.Value  = NVL(.this_cDsMoeda, "")
            loc_oCnt.txt_4c_Envelope.Value = NVL(.this_nEnvelope, 0)
            loc_oCnt.txt_4c_Nop.Value      = NVL(.this_nNop,     0)
            loc_oCnt.opt_4c_Agru.Value     = NVL(.this_nAgru,    4)
            loc_oCnt.chk_4c_Destino.Value  = IIF(.this_lDestino,  1, 0)
            loc_oCnt.chk_4c_Produtos.Value = IIF(.this_lProdutos, 1, 0)
        ENDWITH
        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.AlternarPagina(1)
        THIS.OcultarAguarde()
        THIS.AjustarCamposDescricao()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgBotoesClick - Valida moeda (obrigatoria para Visualizar/Imprimir/Excel)
    *   e despacha para o handler correspondente
    *--------------------------------------------------------------------------
    PROCEDURE CmgBotoesClick()
        LOCAL loc_nBotao, loc_oCnt
        loc_nBotao = THIS.cmg_4c_Botoes.Value
        loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF loc_nBotao <> 4
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_CdMoeda.Value))
                MsgInfo("Moeda de convers" + CHR(227) + "o " + ;
                    CHR(233) + " obrigat" + CHR(243) + "ria.")
                loc_oCnt.txt_4c_CdMoeda.SetFocus()
                RETURN
            ENDIF
        ENDIF
        DO CASE
        CASE loc_nBotao = 1
            THIS.BtnVisualizarClick()
        CASE loc_nBotao = 2
            THIS.BtnImprimirClick()
        CASE loc_nBotao = 3
            THIS.BtnExcelClick()
        CASE loc_nBotao = 4
            THIS.BtnEncerrarClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        THIS.MostrarAguarde()
        THIS.this_oRelatorio.Visualizar()
        THIS.OcultarAguarde()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        THIS.MostrarAguarde()
        THIS.this_oRelatorio.Imprimir()
        THIS.OcultarAguarde()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        THIS.FormParaRelatorio()
        THIS.MostrarAguarde()
        THIS.this_oRelatorio.Visualizar()
        THIS.OcultarAguarde()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF VARTYPE(loc_oCnt) = "O" AND VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
            loc_oCnt.txt_4c_DataIni.SetFocus()
        ENDIF
        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE MostrarAguarde()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF VARTYPE(loc_oCnt.cnt_4c_Mensagem) = "O"
            loc_oCnt.cnt_4c_Mensagem.Visible = .T.
            loc_oCnt.cnt_4c_Mensagem.Refresh()
            THIS.Refresh()
            DOEVENTS
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE OcultarAguarde()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF VARTYPE(loc_oCnt.cnt_4c_Mensagem) = "O"
            loc_oCnt.cnt_4c_Mensagem.Visible = .F.
        ENDIF
    ENDPROC

    *-- KeyPress: datas (sem lookup) -----------------------------------------
    PROCEDURE TxtDataIniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DataFin.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE TxtDataFinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_TpGOp.SetFocus()
        ENDIF
    ENDPROC

    *-- KeyPress: Tipo de O.P. -----------------------------------------------
    PROCEDURE TxtTpGOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaTpGOp()
        ENDIF
    ENDPROC

    *-- KeyPress: Grupo de Balanco -------------------------------------------
    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
                loc_oCnt.txt_4c_Grupo.Value  = ""
                loc_oCnt.txt_4c_DGrupo.Value = ""
            ELSE
                THIS.AbrirBuscaGrupo("C")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    PROCEDURE TxtDGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_DGrupo.Value))
                loc_oCnt.txt_4c_Grupo.Value  = ""
                loc_oCnt.txt_4c_DGrupo.Value = ""
            ELSE
                THIS.AbrirBuscaGrupo("D")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    *-- KeyPress: Conta/Cliente ----------------------------------------------
    PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
                loc_oCnt.txt_4c_Conta.Value  = ""
                loc_oCnt.txt_4c_DConta.Value = ""
            ELSE
                THIS.AbrirBuscaConta("C")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_DConta.Value))
                loc_oCnt.txt_4c_Conta.Value  = ""
                loc_oCnt.txt_4c_DConta.Value = ""
            ELSE
                THIS.AbrirBuscaConta("D")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    *-- KeyPress: Grande Grupo -----------------------------------------------
    PROCEDURE TxtGgrpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_Ggrp.Value))
                loc_oCnt.txt_4c_Ggrp.Value  = ""
                loc_oCnt.txt_4c_DGGrp.Value = ""
            ELSE
                THIS.AbrirBuscaGgrp()
            ENDIF
        ENDIF
    ENDPROC

    *-- KeyPress: Grupo de Materia Prima -------------------------------------
    PROCEDURE TxtCGruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_CGru.Value))
                loc_oCnt.txt_4c_CGru.Value = ""
                loc_oCnt.txt_4c_DGru.Value = ""
            ELSE
                THIS.AbrirBuscaCGru("C")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    PROCEDURE TxtDGruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_DGru.Value))
                loc_oCnt.txt_4c_CGru.Value = ""
                loc_oCnt.txt_4c_DGru.Value = ""
            ELSE
                THIS.AbrirBuscaCGru("D")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    *-- KeyPress: Subgrupo de Materia Prima ----------------------------------
    PROCEDURE TxtCSGruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_CSGru.Value))
                loc_oCnt.txt_4c_CSGru.Value = ""
                loc_oCnt.txt_4c_DsGru.Value = ""
            ELSE
                THIS.AbrirBuscaCSGru("C")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    PROCEDURE TxtDsGruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_DsGru.Value))
                loc_oCnt.txt_4c_CSGru.Value = ""
                loc_oCnt.txt_4c_DsGru.Value = ""
            ELSE
                THIS.AbrirBuscaCSGru("D")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    *-- KeyPress: Modelo (Finalidade de Produto) -----------------------------
    PROCEDURE TxtCodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_CodFinP.Value))
                loc_oCnt.txt_4c_CodFinP.Value = ""
                loc_oCnt.txt_4c_DesFinP.Value = ""
            ELSE
                THIS.AbrirBuscaCodFinP("C")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    PROCEDURE TxtDesFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_DesFinP.Value))
                loc_oCnt.txt_4c_CodFinP.Value = ""
                loc_oCnt.txt_4c_DesFinP.Value = ""
            ELSE
                THIS.AbrirBuscaCodFinP("D")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    *-- KeyPress: Acabamento -------------------------------------------------
    PROCEDURE TxtCodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_CodAcb.Value))
                loc_oCnt.txt_4c_CodAcb.Value = ""
                loc_oCnt.txt_4c_DAcb.Value   = ""
            ELSE
                THIS.AbrirBuscaAcab("C")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    PROCEDURE TxtDAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_DAcb.Value))
                loc_oCnt.txt_4c_CodAcb.Value = ""
                loc_oCnt.txt_4c_DAcb.Value   = ""
            ELSE
                THIS.AbrirBuscaAcab("D")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    *-- KeyPress: Classificacao ----------------------------------------------
    PROCEDURE TxtClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_Class.Value))
                loc_oCnt.txt_4c_Class.Value  = ""
                loc_oCnt.txt_4c_DClass.Value = ""
            ELSE
                THIS.AbrirBuscaClass("C")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    PROCEDURE TxtDClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_DClass.Value))
                loc_oCnt.txt_4c_Class.Value  = ""
                loc_oCnt.txt_4c_DClass.Value = ""
            ELSE
                THIS.AbrirBuscaClass("D")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    *-- KeyPress: Moeda -------------------------------------------------------
    PROCEDURE TxtCdMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_CdMoeda.Value))
                loc_oCnt.txt_4c_CdMoeda.Value = ""
                loc_oCnt.txt_4c_DsMoeda.Value = ""
            ELSE
                THIS.AbrirBuscaMoeda("C")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    PROCEDURE TxtDsMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_DsMoeda.Value))
                loc_oCnt.txt_4c_CdMoeda.Value = ""
                loc_oCnt.txt_4c_DsMoeda.Value = ""
            ELSE
                THIS.AbrirBuscaMoeda("D")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    *-- Grid container: botoes Marca/Desmarca --------------------------------
    PROCEDURE CntOpeApagaClick()
        IF USED("cursor_4c_TiposMat")
            SELECT cursor_4c_TiposMat
            REPLACE ALL Marca WITH 0
            GO TOP
        ENDIF
        THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.cnt_4c_Ope.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE CntOpeSelTudoClick()
        IF USED("cursor_4c_TiposMat")
            SELECT cursor_4c_TiposMat
            REPLACE ALL Marca WITH 1
            GO TOP
        ENDIF
        THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.cnt_4c_Ope.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaTpGOp - Lookup Tipo de Geracao de OP
    *   Primeiro SEEK em cursor_4c_TpGOp (pre-filtrado por fChecaAcesso).
    *   Se nao encontrado, abre FormBuscaAuxiliar em SigInTgo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaTpGOp()
        LOCAL loc_oBusca, loc_oCnt, loc_cValor
        loc_oCnt  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_TpGOp.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        IF USED("cursor_4c_TpGOp") AND SEEK(loc_cValor, "cursor_4c_TpGOp", "Codigos")
            loc_oCnt.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_TpGOp.Codigos)
            RETURN
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigInTgo", "cursor_4c_BuscaTpGOp", "Codigos", ;
            loc_cValor, ;
            "Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P.")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaTpGOp")
                SELECT cursor_4c_BuscaTpGOp
                IF !EOF()
                    loc_oCnt.txt_4c_TpGOp.Value = ALLTRIM(Codigos)
                ENDIF
                USE IN cursor_4c_BuscaTpGOp
            ENDIF
        ELSE
            loc_oCnt.txt_4c_TpGOp.Value = ""
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupo - Lookup Grupo de Balanco (SigCdGcr)
    *   SEEK em cursor_4c_GruposBal; se nao encontrado, FormBuscaAuxiliar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaGrupo(par_cTipoBusca)
        LOCAL loc_oBusca, loc_oCnt, loc_cValorInicial, loc_cCampo
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_cTipoBusca = "C"
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
            loc_cCampo        = "Codigos"
            IF USED("cursor_4c_GruposBal") AND !EMPTY(loc_cValorInicial)
                SELECT cursor_4c_GruposBal
                SET ORDER TO TAG BalCodigo
                IF SEEK(loc_cValorInicial)
                    loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GruposBal.Codigos)
                    loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GruposBal.Descrs)
                    THIS.AjustarCamposDescricao()
                    RETURN
                ENDIF
            ENDIF
        ELSE
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_DGrupo.Value)
            loc_cCampo        = "Descrs"
            IF USED("cursor_4c_GruposBal") AND !EMPTY(loc_cValorInicial)
                SELECT cursor_4c_GruposBal
                SET ORDER TO TAG BalDescrs
                IF SEEK(loc_cValorInicial)
                    loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GruposBal.Codigos)
                    loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GruposBal.Descrs)
                    THIS.AjustarCamposDescricao()
                    RETURN
                ENDIF
            ENDIF
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGrupo", loc_cCampo, ;
            loc_cValorInicial, ;
            "Grupo de Balan" + CHR(231) + "o")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaGrupo")
                SELECT cursor_4c_BuscaGrupo
                IF !EOF()
                    loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(Codigos)
                    loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(Descrs)
                ENDIF
                USE IN cursor_4c_BuscaGrupo
            ENDIF
        ELSE
            loc_oCnt.txt_4c_Grupo.Value  = ""
            loc_oCnt.txt_4c_DGrupo.Value = ""
        ENDIF
        loc_oBusca.Release()
        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaConta - Lookup Conta/Cliente (SigCdCli)
    *   SEEK em cursor_4c_Clientes; se nao encontrado, FormBuscaAuxiliar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaConta(par_cTipoBusca)
        LOCAL loc_oBusca, loc_oCnt, loc_cValorInicial, loc_cCampo
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_cTipoBusca = "C"
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
            loc_cCampo        = "IClis"
            IF USED("cursor_4c_Clientes") AND !EMPTY(loc_cValorInicial)
                SELECT cursor_4c_Clientes
                SET ORDER TO TAG BalCodigo
                IF SEEK(loc_cValorInicial)
                    loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_Clientes.IClis)
                    loc_oCnt.txt_4c_DConta.Value = ALLTRIM(cursor_4c_Clientes.RClis)
                    THIS.AjustarCamposDescricao()
                    RETURN
                ENDIF
            ENDIF
        ELSE
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_DConta.Value)
            loc_cCampo        = "RClis"
            IF USED("cursor_4c_Clientes") AND !EMPTY(loc_cValorInicial)
                SELECT cursor_4c_Clientes
                SET ORDER TO TAG BalNome
                IF SEEK(loc_cValorInicial)
                    loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_Clientes.IClis)
                    loc_oCnt.txt_4c_DConta.Value = ALLTRIM(cursor_4c_Clientes.RClis)
                    THIS.AjustarCamposDescricao()
                    RETURN
                ENDIF
            ENDIF
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaConta", loc_cCampo, ;
            loc_cValorInicial, ;
            "Conta / Cliente")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaConta")
                SELECT cursor_4c_BuscaConta
                IF !EOF()
                    loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(IClis)
                    loc_oCnt.txt_4c_DConta.Value = ALLTRIM(RClis)
                ENDIF
                USE IN cursor_4c_BuscaConta
            ENDIF
        ELSE
            loc_oCnt.txt_4c_Conta.Value  = ""
            loc_oCnt.txt_4c_DConta.Value = ""
        ENDIF
        loc_oBusca.Release()
        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGgrp - Lookup Grande Grupo de Produto (SigCdGpr)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaGgrp()
        LOCAL loc_oBusca, loc_oCnt, loc_cValorInicial
        loc_oCnt          = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_Ggrp.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGpr", "cursor_4c_BuscaGgrp", "Codigos", ;
            loc_cValorInicial, ;
            "Grande Grupo de Produto")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaGgrp")
                SELECT cursor_4c_BuscaGgrp
                IF !EOF()
                    loc_oCnt.txt_4c_Ggrp.Value  = ALLTRIM(Codigos)
                    loc_oCnt.txt_4c_DGGrp.Value = ALLTRIM(Descs)
                ENDIF
                USE IN cursor_4c_BuscaGgrp
            ENDIF
        ELSE
            loc_oCnt.txt_4c_Ggrp.Value  = ""
            loc_oCnt.txt_4c_DGGrp.Value = ""
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCGru - Lookup Grupo de Materia Prima (SigCdGrp)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaCGru(par_cTipoBusca)
        LOCAL loc_oBusca, loc_oCnt, loc_cValorInicial, loc_cCampo
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_cTipoBusca = "C"
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_CGru.Value)
            loc_cCampo        = "CGrus"
        ELSE
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_DGru.Value)
            loc_cCampo        = "DGrus"
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_BuscaCGru", loc_cCampo, ;
            loc_cValorInicial, ;
            "Grupo de Mat. Prima")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaCGru")
                SELECT cursor_4c_BuscaCGru
                IF !EOF()
                    loc_oCnt.txt_4c_CGru.Value = ALLTRIM(CGrus)
                    loc_oCnt.txt_4c_DGru.Value = ALLTRIM(DGrus)
                ENDIF
                USE IN cursor_4c_BuscaCGru
            ENDIF
        ELSE
            loc_oCnt.txt_4c_CGru.Value = ""
            loc_oCnt.txt_4c_DGru.Value = ""
        ENDIF
        loc_oBusca.Release()
        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCSGru - Lookup Subgrupo de Materia Prima (SigCdPsg)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaCSGru(par_cTipoBusca)
        LOCAL loc_oBusca, loc_oCnt, loc_cValorInicial, loc_cCampo
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_cTipoBusca = "C"
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_CSGru.Value)
            loc_cCampo        = "Codigos"
        ELSE
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_DsGru.Value)
            loc_cCampo        = "Descricaos"
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPsg", "cursor_4c_BuscaCSGru", loc_cCampo, ;
            loc_cValorInicial, ;
            "Subgrupo de Mat. Prima")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaCSGru")
                SELECT cursor_4c_BuscaCSGru
                IF !EOF()
                    loc_oCnt.txt_4c_CSGru.Value = ALLTRIM(Codigos)
                    loc_oCnt.txt_4c_DsGru.Value = ALLTRIM(Descricaos)
                ENDIF
                USE IN cursor_4c_BuscaCSGru
            ENDIF
        ELSE
            loc_oCnt.txt_4c_CSGru.Value = ""
            loc_oCnt.txt_4c_DsGru.Value = ""
        ENDIF
        loc_oBusca.Release()
        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCodFinP - Lookup Modelo/Finalidade de Produto (SigCdFip)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaCodFinP(par_cTipoBusca)
        LOCAL loc_oBusca, loc_oCnt, loc_cValorInicial, loc_cCampo
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_cTipoBusca = "C"
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_CodFinP.Value)
            loc_cCampo        = "Cods"
        ELSE
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_DesFinP.Value)
            loc_cCampo        = "Descs"
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdFip", "cursor_4c_BuscaCodFinP", loc_cCampo, ;
            loc_cValorInicial, ;
            "Modelo")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaCodFinP")
                SELECT cursor_4c_BuscaCodFinP
                IF !EOF()
                    loc_oCnt.txt_4c_CodFinP.Value = ALLTRIM(Cods)
                    loc_oCnt.txt_4c_DesFinP.Value = ALLTRIM(Descs)
                ENDIF
                USE IN cursor_4c_BuscaCodFinP
            ENDIF
        ELSE
            loc_oCnt.txt_4c_CodFinP.Value = ""
            loc_oCnt.txt_4c_DesFinP.Value = ""
        ENDIF
        loc_oBusca.Release()
        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaAcab - Lookup Acabamento (SigCdAca)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaAcab(par_cTipoBusca)
        LOCAL loc_oBusca, loc_oCnt, loc_cValorInicial, loc_cCampo
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_cTipoBusca = "C"
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_CodAcb.Value)
            loc_cCampo        = "Cods"
        ELSE
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_DAcb.Value)
            loc_cCampo        = "Descrs"
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdAca", "cursor_4c_BuscaAcab", loc_cCampo, ;
            loc_cValorInicial, ;
            "Acabamento")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaAcab")
                SELECT cursor_4c_BuscaAcab
                IF !EOF()
                    loc_oCnt.txt_4c_CodAcb.Value = ALLTRIM(Cods)
                    loc_oCnt.txt_4c_DAcb.Value   = ALLTRIM(Descrs)
                ENDIF
                USE IN cursor_4c_BuscaAcab
            ENDIF
        ELSE
            loc_oCnt.txt_4c_CodAcb.Value = ""
            loc_oCnt.txt_4c_DAcb.Value   = ""
        ENDIF
        loc_oBusca.Release()
        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaClass - Lookup Classificacao (SigCdCls)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaClass(par_cTipoBusca)
        LOCAL loc_oBusca, loc_oCnt, loc_cValorInicial, loc_cCampo
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_cTipoBusca = "C"
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_Class.Value)
            loc_cCampo        = "Cods"
        ELSE
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_DClass.Value)
            loc_cCampo        = "Descrs"
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCls", "cursor_4c_BuscaClass", loc_cCampo, ;
            loc_cValorInicial, ;
            "Classifica" + CHR(231) + CHR(227) + "o")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaClass")
                SELECT cursor_4c_BuscaClass
                IF !EOF()
                    loc_oCnt.txt_4c_Class.Value  = ALLTRIM(Cods)
                    loc_oCnt.txt_4c_DClass.Value = ALLTRIM(Descrs)
                ENDIF
                USE IN cursor_4c_BuscaClass
            ENDIF
        ELSE
            loc_oCnt.txt_4c_Class.Value  = ""
            loc_oCnt.txt_4c_DClass.Value = ""
        ENDIF
        loc_oBusca.Release()
        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoeda - Lookup Moeda de Conversao (SigCdMoe)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaMoeda(par_cTipoBusca)
        LOCAL loc_oBusca, loc_oCnt, loc_cValorInicial, loc_cCampo
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF par_cTipoBusca = "C"
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_CdMoeda.Value)
            loc_cCampo        = "CMoes"
        ELSE
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_DsMoeda.Value)
            loc_cCampo        = "DMoes"
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeda", loc_cCampo, ;
            loc_cValorInicial, ;
            "Moeda")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()
        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaMoeda")
                SELECT cursor_4c_BuscaMoeda
                IF !EOF()
                    loc_oCnt.txt_4c_CdMoeda.Value = ALLTRIM(CMoes)
                    loc_oCnt.txt_4c_DsMoeda.Value = ALLTRIM(DMoes)
                ENDIF
                USE IN cursor_4c_BuscaMoeda
            ENDIF
        ELSE
            loc_oCnt.txt_4c_CdMoeda.Value = ""
            loc_oCnt.txt_4c_DsMoeda.Value = ""
        ENDIF
        loc_oBusca.Release()
        THIS.AjustarCamposDescricao()
    ENDPROC

    *-- DblClick handlers: abrem lookup direto sem precisar pressionar F4 ------

    PROCEDURE TxtTpGOpDblClick()
        THIS.AbrirBuscaTpGOp()
    ENDPROC

    PROCEDURE TxtGrupoDblClick()
        THIS.AbrirBuscaGrupo("C")
        THIS.AjustarCamposDescricao()
    ENDPROC

    PROCEDURE TxtDGrupoDblClick()
        THIS.AbrirBuscaGrupo("D")
        THIS.AjustarCamposDescricao()
    ENDPROC

    PROCEDURE TxtContaDblClick()
        THIS.AbrirBuscaConta("C")
        THIS.AjustarCamposDescricao()
    ENDPROC

    PROCEDURE TxtDContaDblClick()
        THIS.AbrirBuscaConta("D")
        THIS.AjustarCamposDescricao()
    ENDPROC

    PROCEDURE TxtGgrpDblClick()
        THIS.AbrirBuscaGgrp()
    ENDPROC

    PROCEDURE TxtCGruDblClick()
        THIS.AbrirBuscaCGru("C")
        THIS.AjustarCamposDescricao()
    ENDPROC

    PROCEDURE TxtDGruDblClick()
        THIS.AbrirBuscaCGru("D")
        THIS.AjustarCamposDescricao()
    ENDPROC

    PROCEDURE TxtCSGruDblClick()
        THIS.AbrirBuscaCSGru("C")
        THIS.AjustarCamposDescricao()
    ENDPROC

    PROCEDURE TxtDsGruDblClick()
        THIS.AbrirBuscaCSGru("D")
        THIS.AjustarCamposDescricao()
    ENDPROC

    PROCEDURE TxtCodFinPDblClick()
        THIS.AbrirBuscaCodFinP("C")
        THIS.AjustarCamposDescricao()
    ENDPROC

    PROCEDURE TxtDesFinPDblClick()
        THIS.AbrirBuscaCodFinP("D")
        THIS.AjustarCamposDescricao()
    ENDPROC

    PROCEDURE TxtCodAcbDblClick()
        THIS.AbrirBuscaAcab("C")
        THIS.AjustarCamposDescricao()
    ENDPROC

    PROCEDURE TxtDAcbDblClick()
        THIS.AbrirBuscaAcab("D")
        THIS.AjustarCamposDescricao()
    ENDPROC

    PROCEDURE TxtClassDblClick()
        THIS.AbrirBuscaClass("C")
        THIS.AjustarCamposDescricao()
    ENDPROC

    PROCEDURE TxtDClassDblClick()
        THIS.AbrirBuscaClass("D")
        THIS.AjustarCamposDescricao()
    ENDPROC

    PROCEDURE TxtCdMoedaDblClick()
        THIS.AbrirBuscaMoeda("C")
        THIS.AjustarCamposDescricao()
    ENDPROC

    PROCEDURE TxtDsMoedaDblClick()
        THIS.AbrirBuscaMoeda("D")
        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita todos os campos de filtro.
    *   Respeita regras condicionais do When original (ex: DConta so quando
    *   Grupo preenchido, DGru so quando CGru vazio, etc.)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oCnt, loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        loc_oCnt.txt_4c_DataIni.Enabled  = loc_lHab
        loc_oCnt.txt_4c_DataFin.Enabled  = loc_lHab
        loc_oCnt.txt_4c_Grupo.Enabled    = loc_lHab
        loc_oCnt.txt_4c_DGrupo.Enabled   = loc_lHab AND ;
            EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
        loc_oCnt.txt_4c_Conta.Enabled    = loc_lHab AND ;
            !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
        loc_oCnt.txt_4c_DConta.Enabled   = loc_lHab AND ;
            !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)) AND ;
            EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
        loc_oCnt.txt_4c_Ggrp.Enabled     = loc_lHab
        loc_oCnt.txt_4c_DGGrp.Enabled    = .F.
        loc_oCnt.txt_4c_CGru.Enabled     = loc_lHab
        loc_oCnt.txt_4c_DGru.Enabled     = loc_lHab AND ;
            EMPTY(ALLTRIM(loc_oCnt.txt_4c_CGru.Value))
        loc_oCnt.txt_4c_CSGru.Enabled    = loc_lHab
        loc_oCnt.txt_4c_DsGru.Enabled    = loc_lHab AND ;
            EMPTY(ALLTRIM(loc_oCnt.txt_4c_CSGru.Value))
        loc_oCnt.txt_4c_CodFinP.Enabled  = loc_lHab
        loc_oCnt.txt_4c_DesFinP.Enabled  = loc_lHab AND ;
            EMPTY(ALLTRIM(loc_oCnt.txt_4c_CodFinP.Value))
        loc_oCnt.txt_4c_CodAcb.Enabled   = loc_lHab
        loc_oCnt.txt_4c_DAcb.Enabled     = loc_lHab AND ;
            EMPTY(ALLTRIM(loc_oCnt.txt_4c_CodAcb.Value))
        loc_oCnt.txt_4c_Class.Enabled    = loc_lHab
        loc_oCnt.txt_4c_DClass.Enabled   = loc_lHab AND ;
            EMPTY(ALLTRIM(loc_oCnt.txt_4c_Class.Value))
        loc_oCnt.txt_4c_TamPs.Enabled    = loc_lHab
        loc_oCnt.txt_4c_TamHs.Enabled    = loc_lHab
        loc_oCnt.txt_4c_TamLs.Enabled    = loc_lHab
        loc_oCnt.txt_4c_CdMoeda.Enabled  = loc_lHab
        loc_oCnt.txt_4c_DsMoeda.Enabled  = loc_lHab AND ;
            EMPTY(ALLTRIM(loc_oCnt.txt_4c_CdMoeda.Value))
        loc_oCnt.txt_4c_Envelope.Enabled = loc_lHab
        loc_oCnt.txt_4c_Nop.Enabled      = loc_lHab
        loc_oCnt.opt_4c_Agru.Enabled     = loc_lHab
        IF USED("cursor_4c_TpGOp")
            loc_oCnt.txt_4c_TpGOp.Enabled = loc_lHab AND ;
                RECCOUNT("cursor_4c_TpGOp") > 1
        ELSE
            loc_oCnt.txt_4c_TpGOp.Enabled = loc_lHab
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Garante que todos os 4 botoes do CommandGroup
    *   estejam habilitados. Em form REPORT nao ha modos CRUD; os botoes
    *   Visualizar/Imprimir/DocExcel/Encerrar estao sempre disponiveis.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Reaplica regras condicionais de habilitacao dos campos
    *   e posiciona o foco no primeiro campo de filtro (DataIni). Em form
    *   REPORT equivale a "reconfigurar estado dos filtros".
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.AjustarCamposDescricao()
        THIS.AjustarBotoesPorModo()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF VARTYPE(loc_oCnt) = "O" AND VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
            loc_oCnt.txt_4c_DataIni.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
