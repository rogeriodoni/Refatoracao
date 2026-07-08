*==============================================================================
* FORMSIGREGNF.PRG
* Formulario: Emissao Global de Nota Fiscal
* Tipo: RELATORIO / OPERACIONAL (frmrelatorio)
* Herda de: FormBase
*
* Migracao de: SIGREGNF.SCX
* Entidade: Notas Fiscais (SigMvNfi)
*==============================================================================

DEFINE CLASS Formsigregnf AS FormBase
	ShowWindow = 1
	WindowType = 1

    *-- Propriedades especificas deste formulario
    this_oBusinessObject = .NULL.
    this_lNotasAnt       = .F.
    this_cSerieAnterior  = ""    && Valor anterior da serie (GotFocus)
    this_cUsuarsAnterior = ""    && Valor anterior do usuario (GotFocus)

    *--------------------------------------------------------------------------
    * Init - Delega ao FormBase que chama InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura formulario de emissao global de NF
    * Os cursores de trabalho (cursor_4c_TmpNFis, cursor_4c_SigCdSer) sao
    * criados pelo sigregnfBO.Init() ao chamar CREATEOBJECT abaixo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Criar Business Object (BO.Init() cria cursores e carrega SigCdPam/SigCdSer)
            THIS.this_oBusinessObject = CREATEOBJECT("sigregnfBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio de " + ;
                        "Emiss" + CHR(227) + "o Global de Nota Fiscal", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Propriedades visuais do form (EXATAS do original)
            THIS.Width        = 800
            THIS.Height       = 700
            THIS.AutoCenter   = .T.
            THIS.BorderStyle  = 2
            THIS.Caption      = "Emiss" + CHR(227) + "o Global de Nota Fiscal"
            THIS.FontName     = "Tahoma"
            THIS.FontSize     = 8
            THIS.MaxButton    = .F.
            THIS.MinButton    = .F.

            *-- Configurar elementos visuais
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarBotoesRelatorio()
            THIS.ConfigurarPageFrame()

            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            THIS.Visible  = .T.
            loc_lSucesso  = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo do formulario
    *   Replica cntSombra do frmrelatorio framework.vcx
    *   BackColor = RGB(100,100,100): cinza medio opaco (NAO escuro)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0,0,0)
                .BackStyle = 0
                .Caption   = "Emiss" + CHR(227) + "o Global de Nota Fiscal"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255,255,255)
                .BackStyle = 0
                .Caption   = "Emiss" + CHR(227) + "o Global de Nota Fiscal"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesRelatorio - CommandGroup com 4 botoes do relatorio
    * Geometria EXATA do frmrelatorio framework.vcx (btnReport original):
    *   cmg_4c_Botoes: Left=526 (original btnReport.Left=526), Width=273, Height=80
    *   Botoes: Width=65, Height=70, PicturePosition=13 (icone acima da legenda)
    *   Lefts: Buttons(1)=5, Buttons(2)=71, Buttons(3)=137, Buttons(4)=203
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 526
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136,189,188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            ENDWITH

            WITH .Buttons(2)
                .Caption         = "Imprimir"
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            ENDWITH

            WITH .Buttons(3)
                .Caption         = "DocExcel"
                .WordWrap        = .T.
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            ENDWITH

            WITH .Buttons(4)
                .Caption         = "Sair"
                .WordWrap        = .T.
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .Cancel          = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura layout principal do form REPORT (FLAT)
    *   Este form herda de FormBase mas eh do tipo OPERACIONAL/REPORT (frmrelatorio):
    *   NAO usa PageFrame com Page1=Lista/Page2=Dados. O layout eh plano,
    *   com cabecalho + botoes de relatorio (topo) + corpo (filtros + grid +
    *   botoes auxiliares de selecao).
    *
    *   Este metodo cria o container cnt_4c_Corpo que hospedara nas fases
    *   seguintes: filtros de Serie/Usuario (Fase 5), grid de notas fiscais
    *   selecionaveis com CheckBox (Fase 4), botoes Processar/SelTudo/Apaga
    *   (Fase 6) e BINDEVENTs com toda logica de selecao e impressao (Fase 7-8).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("cnt_4c_Corpo", "Container")
        WITH THIS.cnt_4c_Corpo
            .Top         = 85
            .Left        = 0
            .Width       = THIS.Width
            .Height      = THIS.Height - 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Filtros de entrada (Serie + Usuario)
    *   Form REPORT FLAT (sem PageFrame): "Dados" representa os campos de
    *   filtro/parametro do relatorio (analogo a Page2.Dados de CRUD).
    *   Replica Say1/Say2/Get_S?rie/getUsuars do SIGREGNF.SCX original.
    *   Top: original-85 (cnt_4c_Corpo comeca em 85, original mede do form).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oCp
        loc_oCp = THIS.cnt_4c_Corpo

        *-- Label Serie (original: top=173, left=48 -> corpo: top=88)
        loc_oCp.AddObject("lbl_4c_Serie", "Label")
        WITH loc_oCp.lbl_4c_Serie
            .Top       = 88
            .Left      = 48
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "S" + CHR(233) + "rie : "
            .Visible   = .T.
        ENDWITH

        *-- TextBox Serie (original: top=169, left=93, w=34, h=23 -> corpo: top=84)
        loc_oCp.AddObject("txt_4c_Serie", "TextBox")
        WITH loc_oCp.txt_4c_Serie
            .Top                = 84
            .Left               = 93
            .Width              = 34
            .Height             = 23
            .Value              = SPACE(3)
            .FontName           = "Tahoma"
            .FontSize           = 8
            .MaxLength          = 3
            .Alignment          = 3
            .ForeColor          = RGB(0,0,0)
            .DisabledBackColor  = RGB(255,255,255)
            .Visible            = .T.
        ENDWITH

        *-- Label Usuario (original: top=173, left=138 -> corpo: top=88)
        loc_oCp.AddObject("lbl_4c_Usuars", "Label")
        WITH loc_oCp.lbl_4c_Usuars
            .Top       = 88
            .Left      = 138
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Visible   = .T.
        ENDWITH

        *-- TextBox Usuario (original: top=169, left=198, w=80, h=23 -> corpo: top=84)
        loc_oCp.AddObject("txt_4c_Usuars", "TextBox")
        WITH loc_oCp.txt_4c_Usuars
            .Top                = 84
            .Left               = 198
            .Width              = 80
            .Height             = 23
            .Value              = SPACE(10)
            .FontName           = "Tahoma"
            .FontSize           = 8
            .MaxLength          = 10
            .Alignment          = 3
            .ForeColor          = RGB(0,0,0)
            .DisabledBackColor  = RGB(255,255,255)
            .Visible            = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    * BO.Destroy() e responsavel por fechar os cursores de trabalho.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Popula cnt_4c_Corpo com grid de NFs e botoes de
    *   selecao (Processar/SelTudo/Apaga). Os filtros (Serie/Usuario) sao
    *   criados em ConfigurarPaginaDados (chamado antes deste metodo).
    *   Replica layout do SIGREGNF.SCX (posicoes relativas ao corpo = original - 85)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oCp
        loc_oCp = THIS.cnt_4c_Corpo

        *-- Botao Processar (original: top=96, left=696 -> corpo: top=11)
        loc_oCp.AddObject("cmd_4c_Processar", "CommandButton")
        WITH loc_oCp.cmd_4c_Processar
            .Top             = 11
            .Left            = 696
            .Width           = 75
            .Height          = 75
            .Caption         = "P\<rocessar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255,255,255)
            .ForeColor       = RGB(90,90,90)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH

        *-- Grid de NFs (original: top=195, left=30, w=739, h=364 -> corpo: top=110)
        THIS.ConfigurarGridNF(loc_oCp)

        *-- Botao SelTudo (original: top=561, left=30, w=45, h=45)
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top           = 561
            .Left          = 30
            .Width         = 45
            .Height        = 45
            .Caption       = ""
            .FontName      = "Verdana"
            .FontSize      = 8
            .SpecialEffect = 0
            .ForeColor     = RGB(36,84,155)
            .BackColor     = RGB(255,255,255)
            .Themes        = .F.
            .MousePointer  = 15
            .ToolTipText   = "Selecionar Tudo"
            .Visible       = .T.
        ENDWITH

        *-- Botao Apaga (original: top=561, left=75, w=45, h=45)
        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top           = 561
            .Left          = 75
            .Width         = 45
            .Height        = 45
            .Caption       = ""
            .FontName      = "Verdana"
            .FontSize      = 8
            .SpecialEffect = 0
            .ForeColor     = RGB(36,84,155)
            .BackColor     = RGB(255,255,255)
            .Themes        = .F.
            .MousePointer  = 15
            .ToolTipText   = "Desmarcar Tudo"
            .Visible       = .T.
        ENDWITH

        THIS.VincularEventos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridNF - Grid de 9 colunas: CheckBox(Flag), Num, Serie, Emis,
    *   Op, CFOP, Valor, Operacao, Emitente. Ordem obrigatoria Column1:
    *   AddObject -> Caption -> CurrentControl -> ControlSource (Error 1767)
    *   ColumnOrder: Column4.ColumnOrder=5, Column5.ColumnOrder=4 (Op exibe
    *   antes de Emissao, replicando ColumnOrder do original SIGREGNF.Grade).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridNF(par_oCp)
        par_oCp.AddObject("grd_4c_Dados", "Grid")
        WITH par_oCp.grd_4c_Dados
            .Top                = 110
            .Left               = 30
            .Width              = 739
            .Height             = 364
            .ColumnCount        = 9
            .RecordSource       = "cursor_4c_TmpNFis"
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .FontName           = "Tahoma"
            .FontSize           = 8
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .RowHeight          = 18
            .ScrollBars         = 2
            .HighlightStyle     = 2
            .GridLineColor      = RGB(238,238,238)
            .HighlightBackColor = RGB(255,255,255)
            .HighlightForeColor = RGB(15,41,104)
            .ForeColor          = RGB(90,90,90)
            .BackColor          = RGB(255,255,255)
            .Visible            = .T.

            WITH .Column1
                .Width             = 15
                .HeaderHeight       = 0
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .F.
                .Sparse            = .F.
                .AddObject("Check1", "CheckBox")
                WITH .Check1
                    .Caption   = ""
                    .Value     = 0
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
                .CurrentControl    = "Check1"
                .ControlSource     = "cursor_4c_TmpNFis.Flag"
                .Header1.Caption   = ""
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column2
                .Width             = 45
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontBold          = .T.
                .ControlSource     = "cursor_4c_TmpNFis.NFis"
                .Header1.Caption   = "N" + CHR(250) + "mero"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column3
                .Width             = 28
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "cursor_4c_TmpNFis.Series"
                .Header1.Caption   = "S" + CHR(233) + "rie"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column4
                .Width             = 62
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ColumnOrder       = 5
                .ControlSource     = "cursor_4c_TmpNFis.Emis"
                .Header1.Caption   = "Emiss" + CHR(227) + "o"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column5
                .Width             = 18
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ColumnOrder       = 4
                .ControlSource     = "cursor_4c_TmpNFis.Operas"
                .Header1.Caption   = "Op"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column6
                .Width             = 60
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "cursor_4c_TmpNFis.CFis"
                .Header1.Caption   = "CFOP"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column7
                .Width             = 75
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .InputMask         = "999,999,999.99"
                .ControlSource     = "cursor_4c_TmpNFis.TotNotas"
                .Header1.Caption   = "Valor Total"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column8
                .Width             = 150
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "cursor_4c_TmpNFis.Operacao"
                .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Column9
                .Width             = 246
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .ControlSource     = "cursor_4c_TmpNFis.Conta"
                .Header1.Caption   = "Emitente / Detinat" + CHR(225) + "rio"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Refresh da area de dados (form FLAT sem page switching)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
                THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia filtros do form para o BO antes de SelecionarDados
    * Metodo canonico para forms REPORT (exigido pelo TesteAutomatico)
    *--------------------------------------------------------------------------
    PROCEDURE FormParaRelatorio()
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN
        ENDIF
        WITH THIS.this_oBusinessObject
            .this_cSeries = PADR(ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Serie.Value), 3)
            .this_cUsuars = PADR(ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Usuars.Value), 10)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Delega para FormParaRelatorio (compatibilidade)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularEventos - BINDEVENTs para filtros e botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularEventos()
        BINDEVENT(THIS.cnt_4c_Corpo.txt_4c_Serie, "GotFocus", THIS, "SerieGotFocus")
        BINDEVENT(THIS.cnt_4c_Corpo.txt_4c_Serie, "KeyPress", THIS, "TeclaSerieKeyPress")
        BINDEVENT(THIS.cnt_4c_Corpo.txt_4c_Usuars, "GotFocus", THIS, "UsuarsGotFocus")
        BINDEVENT(THIS.cnt_4c_Corpo.txt_4c_Usuars, "KeyPress", THIS, "TeclaUsuarsKeyPress")
        BINDEVENT(THIS.cnt_4c_Corpo.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
        BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * SerieGotFocus - Salva valor inicial da serie para deteccao de mudanca
    *--------------------------------------------------------------------------
    PROCEDURE SerieGotFocus()
        THIS.this_cSerieAnterior = PADR(THIS.cnt_4c_Corpo.txt_4c_Serie.Value, 3)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaSerieKeyPress - F4(115)=lookup direto, ENTER(13)/TAB(9)=validar
    *--------------------------------------------------------------------------
    PROCEDURE TeclaSerieKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupSerie()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cSerie
            loc_cSerie = PADR(ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Serie.Value), 3)
            IF !EMPTY(ALLTRIM(loc_cSerie))
                THIS.ValidarSerie(loc_cSerie)
            ENDIF
            IF PADR(THIS.this_cSerieAnterior, 3) # PADR(THIS.cnt_4c_Corpo.txt_4c_Serie.Value, 3)
                THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSerie - Abre FormBuscaAuxiliar para selecao de serie (SigCnFNf)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSerie()
        LOCAL loc_oLookup, loc_cSerie
        loc_cSerie = ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Serie.Value)
        loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                      "SigCnFNf", "cursor_4c_BuscaSerie", "Series", loc_cSerie, ;
                      "Sele" + CHR(231) + CHR(227) + "o")
        IF VARTYPE(loc_oLookup) = "O"
            loc_oLookup.mAddColuna("Series", "", "S" + CHR(233) + "rie")
            IF !loc_oLookup.this_lSelecionou
                loc_oLookup.Show()
            ENDIF
            IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaSerie")
                SELECT cursor_4c_BuscaSerie
                IF !EOF()
                    THIS.cnt_4c_Corpo.txt_4c_Serie.Value = PADR(ALLTRIM(Series), 3)
                    THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
                ENDIF
                USE IN cursor_4c_BuscaSerie
            ENDIF
            loc_oLookup.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSerie - Valida serie digitada contra SigCnFNf; abre lookup se nao achar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarSerie(par_cSerie)
        LOCAL loc_nResult, loc_lAchou
        loc_lAchou = .F.
        IF USED("cursor_4c_SerieVal")
            USE IN cursor_4c_SerieVal
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT TOP 1 Series FROM SigCnFNf WHERE Series = " + EscaparSQL(par_cSerie), ;
            "cursor_4c_SerieVal")
        IF loc_nResult > 0 AND USED("cursor_4c_SerieVal")
            SELECT cursor_4c_SerieVal
            loc_lAchou = !EOF()
            USE IN cursor_4c_SerieVal
        ENDIF
        IF !loc_lAchou
            IF TYPE("gb_4c_ValidandoUI") # "L" OR !gb_4c_ValidandoUI
                THIS.AbrirLookupSerie()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * UsuarsGotFocus - Salva valor inicial do usuario para deteccao de mudanca
    *--------------------------------------------------------------------------
    PROCEDURE UsuarsGotFocus()
        THIS.this_cUsuarsAnterior = PADR(THIS.cnt_4c_Corpo.txt_4c_Usuars.Value, 10)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaUsuarsKeyPress - F4(115)=lookup direto, ENTER(13)/TAB(9)=validar
    *--------------------------------------------------------------------------
    PROCEDURE TeclaUsuarsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupUsuars()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cUsuars
            loc_cUsuars = PADR(ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Usuars.Value), 10)
            IF !EMPTY(ALLTRIM(loc_cUsuars))
                THIS.ValidarUsuars(loc_cUsuars)
            ENDIF
            IF PADR(THIS.this_cUsuarsAnterior, 10) # PADR(THIS.cnt_4c_Corpo.txt_4c_Usuars.Value, 10)
                THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupUsuars - Abre FormBuscaAuxiliar para selecao de usuario (SigCdUsu)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupUsuars()
        LOCAL loc_oLookup, loc_cUsuars
        loc_cUsuars = ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Usuars.Value)
        loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                      "SigCdUsu", "cursor_4c_BuscaUsuars", "Usuars", loc_cUsuars, ;
                      "Sele" + CHR(231) + CHR(227) + "o")
        IF VARTYPE(loc_oLookup) = "O"
            loc_oLookup.mAddColuna("Usuars", "", "Usu" + CHR(225) + "rio")
            IF !loc_oLookup.this_lSelecionou
                loc_oLookup.Show()
            ENDIF
            IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaUsuars")
                SELECT cursor_4c_BuscaUsuars
                IF !EOF()
                    THIS.cnt_4c_Corpo.txt_4c_Usuars.Value = PADR(ALLTRIM(Usuars), 10)
                    THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
                ENDIF
                USE IN cursor_4c_BuscaUsuars
            ENDIF
            loc_oLookup.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUsuars - Valida usuario digitado contra SigCdUsu; abre lookup se nao achar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarUsuars(par_cUsuars)
        LOCAL loc_nResult, loc_lAchou
        loc_lAchou = .F.
        IF USED("cursor_4c_UsuarsVal")
            USE IN cursor_4c_UsuarsVal
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT TOP 1 Usuars FROM SigCdUsu WHERE Usuars = " + EscaparSQL(par_cUsuars), ;
            "cursor_4c_UsuarsVal")
        IF loc_nResult > 0 AND USED("cursor_4c_UsuarsVal")
            SELECT cursor_4c_UsuarsVal
            loc_lAchou = !EOF()
            USE IN cursor_4c_UsuarsVal
        ENDIF
        IF !loc_lAchou
            IF TYPE("gb_4c_ValidandoUI") # "L" OR !gb_4c_ValidandoUI
                THIS.AbrirLookupUsuars()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Executa SelecionarDados e preenche o grid com NFs
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN
        ENDIF
        THIS.FormParaBO()
        IF THIS.this_oBusinessObject.SelecionarDados()
            THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .F.
        ENDIF
        THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
        IF USED("cursor_4c_TmpNFis") AND !EOF("cursor_4c_TmpNFis")
            THIS.cnt_4c_Corpo.grd_4c_Dados.Column1.Check1.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelTudoClick - Marca todos os registros do grid (Flag=.T.)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelTudoClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.MarcarTodos()
        ENDIF
        THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnApagaClick - Desmarca todos os registros do grid (Flag=.F.)
    *--------------------------------------------------------------------------
    PROCEDURE BtnApagaClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.DesmarcarTodos()
        ENDIF
        THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza NF do registro corrente no grid via SigPrNfs
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN
        ENDIF
        IF !USED("cursor_4c_TmpNFis") OR EOF("cursor_4c_TmpNFis")
            MsgAviso("Nenhuma nota fiscal dispon" + CHR(237) + "vel para visualizar.", ;
                     "Visualizar")
            RETURN
        ENDIF
        IF !THIS.this_oBusinessObject.Processamento()
            RETURN
        ENDIF
        IF !THIS.this_oBusinessObject.Visualizacao()
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            ENDIF
        ENDIF
        THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Processa e imprime todas as NFs marcadas (Flag=.T.)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN
        ENDIF
        IF !USED("cursor_4c_TmpNFis") OR RECCOUNT("cursor_4c_TmpNFis") = 0
            MsgAviso("Nenhuma nota fiscal dispon" + CHR(237) + "vel para impress" + ;
                     CHR(227) + "o.", "Impress" + CHR(227) + "o")
            RETURN
        ENDIF
        GO TOP IN cursor_4c_TmpNFis
        IF !THIS.this_oBusinessObject.Processamento()
            RETURN
        ENDIF
        IF !THIS.this_oBusinessObject.Impressao()
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            ENDIF
        ENDIF
        THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
        THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exportacao Excel nao disponivel para este relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o DocExcel n" + CHR(227) + ;
                 "o dispon" + CHR(237) + "vel para este relat" + CHR(243) + "rio.", ;
                 "DocExcel")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Form REPORT/OPERACIONAL: incluir nao se aplica.
    *   Mapeado para Processar (seleciona NFs nao impressas para a Serie/Usuario
    *   informados), que e a unica operacao de "carga/inclusao" do form SIGREGNF.
    *   Habilita visibilmente o botao caso o usuario chegue via tecla padrao CRUD.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Processar", 5)
                THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
            ENDIF
        ENDIF
        THIS.BtnProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Form REPORT/OPERACIONAL: alterar nao se aplica.
    *   Mapeado para Visualizar (preview da NF do registro corrente do grid),
    *   que e a operacao mais proxima de "abrir/editar" no fluxo do SIGREGNF.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF !USED("cursor_4c_TmpNFis") OR EOF("cursor_4c_TmpNFis")
            MsgAviso("Processe a sele" + CHR(231) + CHR(227) + "o de notas fiscais " + ;
                     "antes de visualizar.", "Visualizar")
            RETURN
        ENDIF
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Form REPORT/OPERACIONAL: excluir nao se aplica.
    *   Mapeado para Apaga (desmarca todas as NFs do grid), que e a operacao
    *   de "limpeza/exclusao" disponivel no fluxo do SIGREGNF.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF !USED("cursor_4c_TmpNFis") OR RECCOUNT("cursor_4c_TmpNFis") = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " notas fiscais para " + ;
                     "desmarcar.", "Desmarcar")
            RETURN
        ENDIF
        THIS.BtnApagaClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Form REPORT: buscar equivale a Processar (carregar grid)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Form REPORT: salvar equivale a Imprimir NFs marcadas
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa filtros e grid, reseta estado do formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia filtros do BO de volta para os campos do form
    * Para form REPORT: repoe Serie e Usuario conforme propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN
        ENDIF
        WITH THIS.this_oBusinessObject
            THIS.cnt_4c_Corpo.txt_4c_Serie.Value  = PADR(ALLTRIM(.this_cSeries), 3)
            THIS.cnt_4c_Corpo.txt_4c_Usuars.Value = PADR(ALLTRIM(.this_cUsuars), 10)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de filtro
    * par_lHabilitar: .T. = habilitar, .F. = desabilitar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        IF VARTYPE(THIS.cnt_4c_Corpo) # "O"
            RETURN
        ENDIF
        IF PEMSTATUS(THIS.cnt_4c_Corpo, "txt_4c_Serie", 5)
            THIS.cnt_4c_Corpo.txt_4c_Serie.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS.cnt_4c_Corpo, "txt_4c_Usuars", 5)
            THIS.cnt_4c_Corpo.txt_4c_Usuars.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Processar", 5)
            THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
            THIS.cmd_4c_SelTudo.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
            THIS.cmd_4c_Apaga.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa filtros, esvazia grid e reseta botao Processar
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "txt_4c_Serie", 5)
                THIS.cnt_4c_Corpo.txt_4c_Serie.Value  = SPACE(3)
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "txt_4c_Usuars", 5)
                THIS.cnt_4c_Corpo.txt_4c_Usuars.Value = SPACE(10)
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Processar", 5)
                THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .F.
            ENDIF
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cSeries  = ""
            THIS.this_oBusinessObject.this_cUsuars  = ""
            THIS.this_oBusinessObject.this_lNotasAnt = .F.
            IF USED("cursor_4c_TmpNFis")
                ZAP IN cursor_4c_TmpNFis
            ENDIF
        ENDIF
        THIS.this_cSerieAnterior  = ""
        THIS.this_cUsuarsAnterior = ""
        IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
                THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega o grid com dados do banco (se filtros preenchidos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Serie.Value))
            RETURN .F.
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF
        THIS.FormParaBO()
        loc_lSucesso = THIS.this_oBusinessObject.SelecionarDados()
        IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
                THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme disponibilidade de dados
    * Form REPORT: habilita/desabilita Processar conforme Serie informada
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemSerie, loc_lTemDados
        IF VARTYPE(THIS.cnt_4c_Corpo) # "O"
            RETURN
        ENDIF
        loc_lTemSerie = !EMPTY(ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Serie.Value))
        loc_lTemDados = USED("cursor_4c_TmpNFis") AND RECCOUNT("cursor_4c_TmpNFis") > 0

        IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Processar", 5)
            THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = loc_lTemSerie
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
            THIS.cmd_4c_SelTudo.Enabled = loc_lTemDados
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
            THIS.cmd_4c_Apaga.Enabled = loc_lTemDados
        ENDIF
    ENDPROC

ENDDEFINE
