*==============================================================================
* FORMSIGREAIV.PRG
* An[a]lise Entre Invent[a]rios - Formul[a]rio de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREAIV.SCX (frmrelatorio)
*
* Filtros:
*   - Empresa     : C[o]digo (txt_4c_Empresa) + Descri[c][a]o (txt_4c_Dempresa)
*   - 1[o] Invent[a]rio : C[o]digo num[e]rico (txt_4c_Inv1) + Descri[c][a]o (lbl_4c_Label2)
*   - 2[o] Invent[a]rio : C[o]digo num[e]rico (txt_4c_Inv2) + Descri[c][a]o (lbl_4c_Label5)
*   - Tipo        : 1=Anal[i]tico / 2=Sint[e]tico (obj_4c_OptTipo)
*
* fAcessoEmpresa (legado) -> substituido por ValidarEmpresa/AbrirBuscaEmpresa via SQL
* fwBuscaExt(SigCdBal)   -> substituido por FormBuscaAuxiliar
*==============================================================================

DEFINE CLASS FormSigReAiv AS FormBase

    *-- Dimens[o]es exatas do original: Width=800, Height=190
    Height      = 190
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- BO de relat[o]rio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual do formul[a]rio de relat[o]rio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Analise Entre Invent" + CHR(225) + "rios"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SigReAivBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReAivBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.LimparCampos()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com t[i]tulo do relat[o]rio
    *   Largura total (Width) para cobrir toda a faixa superior.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Analise Entre Invent" + CHR(225) + "rios"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Analise Entre Invent" + CHR(225) + "rios"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 bot[o]es de relat[o]rio
    *   Geometria EXATA do framework frmrelatorio:
    *     Top=0, Left=529, Width=273, Height=80, ButtonCount=4
    *   Bot[o]es: Visualizar(1)/Imprimir(2)/Excel(3)/Encerrar(4)
    *   Lefts: 5 / 71 / 137 / 203 (incrementos de 66)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .WordWrap        = .T.
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 p[a]gina (Filtros)
    *   Posicionado abaixo do cabe[c]alho (Top=85) at[e] o fim do form.
    *   Height = Form.Height - 85 = 190 - 85 = 105
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
    * ConfigurarPaginaLista - Bloco Empresa + 1[o] Invent[a]rio na Page1
    *
    * Forms REPORT (frmrelatorio) t[e]m layout FLAT: s[o] Page1 (Filtros).
    * Os filtros s[a]o separados em dois m[e]todos para manter o contrato
    * esperado pelo pipeline (ConfigurarPaginaLista + ConfigurarPaginaDados).
    *
    * Posi[c][o]es relativas ao PageFrame.Top=85:
    *   Get_Empresa (Top=87)  -> Page1.Top = 87-85 = 2
    *   Say3        (Top=90)  -> Page1.Top = 90-85 = 5
    *   Get_Inv1    (Top=112) -> Page1.Top = 112-85 = 27
    *   Say1        (Top=115) -> Page1.Top = 115-85 = 30
    *   Say2        (Top=115) -> Page1.Top = 30 (label descri[c][a]o Inv1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Empresa :" (Say3: Left=110)
        loc_oPg.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg.lbl_4c_Label3
            .Top       = 5
            .Left      = 110
            .AutoSize  = .T.
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- C[o]digo da empresa (Get_Empresa: Top=87, Left=167, Width=33)
        loc_oPg.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPg.txt_4c_Empresa
            .Top         = 2
            .Left        = 167
            .Width       = 33
            .Height      = 23
            .MaxLength   = 2
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Descri[c][a]o da empresa (Get_Dempresa: Top=87, Left=201, Width=205)
        *   When original: Return(Empty(Get_Empresa.Value)) -> ReadOnly quando empresa vazia
        loc_oPg.AddObject("txt_4c_Dempresa", "TextBox")
        WITH loc_oPg.txt_4c_Dempresa
            .Top         = 2
            .Left        = 201
            .Width       = 205
            .Height      = 23
            .MaxLength   = 30
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

        *-- Label "1[o] Invent[a]rio :" (Say1: Left=87)
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .Top       = 30
            .Left      = 87
            .AutoSize  = .T.
            .Caption   = "1" + CHR(186) + " Invent" + CHR(225) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- C[o]digo do 1[o] Invent[a]rio (Get_Inv1: Top=112, Left=167, Width=87)
        loc_oPg.AddObject("txt_4c_Inv1", "TextBox")
        WITH loc_oPg.txt_4c_Inv1
            .Top         = 27
            .Left        = 167
            .Width       = 87
            .Height      = 23
            .Value       = 0
            .Format      = ""
            .InputMask   = "999999999"
            .Alignment   = 3
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Descri[c][a]o do 1[o] Invent[a]rio (Say2: Top=115, Left=260)
        *   Preenchida ap[o]s sele[c][a]o: Grupos + " - " + Contas
        loc_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg.lbl_4c_Label2
            .Top       = 30
            .Left      = 260
            .Width     = 200
            .Height    = 17
            .Caption   = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- KeyPress: F4(115)=lookup direto, ENTER(13)/TAB(9)=validar, ESC(27)=limpar
        BINDEVENT(loc_oPg.txt_4c_Empresa, "KeyPress", THIS, "TeclaEmpresa")
        BINDEVENT(loc_oPg.txt_4c_Inv1,    "KeyPress", THIS, "TeclaInv1")

        *-- DblClick: abre lookup diretamente
        BINDEVENT(loc_oPg.txt_4c_Empresa, "DblClick", THIS, "AbrirBuscaEmpresa")
        BINDEVENT(loc_oPg.txt_4c_Inv1,    "DblClick", THIS, "AbrirBuscaInv1")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Bloco 2[o] Invent[a]rio + Tipo na Page1
    *
    * Posi[c][o]es relativas ao PageFrame.Top=85:
    *   Get_Inv2 (Top=137) -> Page1.Top = 137-85 = 52
    *   Say4     (Top=140) -> Page1.Top = 140-85 = 55
    *   Say5     (Top=140) -> Page1.Top = 55 (label descri[c][a]o Inv2)
    *   OptTipo  (Top=162) -> Page1.Top = 162-85 = 77
    *   Say6     (Top=166) -> Page1.Top = 166-85 = 81
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "2[o] Invent[a]rio :" (Say4: Left=87)
        loc_oPg.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg.lbl_4c_Label4
            .Top       = 55
            .Left      = 87
            .AutoSize  = .T.
            .Caption   = "2" + CHR(186) + " Invent" + CHR(225) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- C[o]digo do 2[o] Invent[a]rio (Get_Inv2: Top=137, Left=167, Width=87)
        loc_oPg.AddObject("txt_4c_Inv2", "TextBox")
        WITH loc_oPg.txt_4c_Inv2
            .Top         = 52
            .Left        = 167
            .Width       = 87
            .Height      = 23
            .Value       = 0
            .Format      = "R"
            .InputMask   = "9999999999"
            .Alignment   = 3
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Descri[c][a]o do 2[o] Invent[a]rio (Say5: Top=140, Left=259)
        *   Preenchida ap[o]s sele[c][a]o: Grupos + " - " + Contas
        loc_oPg.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg.lbl_4c_Label5
            .Top       = 55
            .Left      = 259
            .Width     = 200
            .Height    = 17
            .Caption   = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Tipo :" (Say6: Left=131)
        loc_oPg.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg.lbl_4c_Label6
            .Top       = 81
            .Left      = 131
            .AutoSize  = .T.
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Tipo (OptTipo: Top=162, Left=167, Width=158, Height=24, ButtonCount=2)
        loc_oPg.AddObject("obj_4c_OptTipo", "OptionGroup")
        WITH loc_oPg.obj_4c_OptTipo
            .Top           = 77
            .Left          = 167
            .Width         = 158
            .Height        = 24
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Visible       = .T.
            WITH .Buttons(1)
                .Top       = 0
                .Left      = 0
                .Width     = 79
                .Height    = 21
                .Caption   = "Anal" + CHR(237) + "tico"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Value     = 1
                .Visible   = .T.
            ENDWITH
            WITH .Buttons(2)
                .Top       = 0
                .Left      = 80
                .Width     = 79
                .Height    = 21
                .Caption   = "Sint" + CHR(233) + "tico"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- KeyPress: F4(115)=lookup direto, ENTER(13)/TAB(9)=validar, ESC(27)=limpar
        BINDEVENT(loc_oPg.txt_4c_Inv2, "KeyPress", THIS, "TeclaInv2")

        *-- DblClick: abre lookup diretamente
        BINDEVENT(loc_oPg.txt_4c_Inv2, "DblClick", THIS, "AbrirBuscaInv2")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura todos os filtros para valores padr[a]o (vazios)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_Empresa.Value   = ""
            loc_oPg.txt_4c_Dempresa.Value  = ""
            loc_oPg.txt_4c_Inv1.Value      = 0
            loc_oPg.lbl_4c_Label2.Caption  = ""
            loc_oPg.txt_4c_Inv2.Value      = 0
            loc_oPg.lbl_4c_Label5.Caption  = ""
            loc_oPg.obj_4c_OptTipo.Value   = 1
            THIS.AtualizarEstadoCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cEmpresa  = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
            .this_cDempresa = ALLTRIM(loc_oPg.txt_4c_Dempresa.Value)
            .this_nInv1     = loc_oPg.txt_4c_Inv1.Value
            .this_nInv2     = loc_oPg.txt_4c_Inv2.Value
            .this_nTipo     = loc_oPg.obj_4c_OptTipo.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCampos - Aplica regra de habilita[c][a]o dos campos
    *   Get_Dempresa.When = Empty(Get_Empresa.Value)
    *   -> txt_4c_Dempresa ReadOnly quando empresa vazia
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPg, "txt_4c_Dempresa", 5)
                loc_oPg.txt_4c_Dempresa.ReadOnly = EMPTY(ALLTRIM(loc_oPg.txt_4c_Empresa.Value))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa p[a]gina no PageFrame (form REPORT: s[o] Page1)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
            IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                loc_nPagina = 1
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Empresa", 5)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO (PUBLIC - contrato BINDEVENT)
    * F4=115, ENTER=13, TAB=9, ESC=27
    *==========================================================================

    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value  = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_Dempresa.Value = ""
            THIS.AtualizarEstadoCampos()
        ENDIF
    ENDPROC

    PROCEDURE TeclaInv1(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaInv1()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarInv1()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_Inv1.Value    = 0
            THIS.pgf_4c_Paginas.Page1.lbl_4c_Label2.Caption = ""
        ENDIF
    ENDPROC

    PROCEDURE TeclaInv2(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaInv2()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarInv2()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_Inv2.Value    = 0
            THIS.pgf_4c_Paginas.Page1.lbl_4c_Label5.Caption = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDA[C][A]O (ENTER/TAB em campo de c[o]digo)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Busca empresa pelo c[o]digo digitado (SigCdEmP.Emps)
    *   Replica Get_Empresa.Valid do original: fAcessoEmpresa modo 'C'
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarEmpresa()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
        IF EMPTY(loc_cCodigo)
            loc_oPg.txt_4c_Dempresa.Value = ""
            THIS.AtualizarEstadoCampos()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Emps, NComps FROM SigCdEmP WHERE Emps = " + EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal
            IF !EOF()
                loc_oPg.txt_4c_Empresa.Value  = ALLTRIM(Emps)
                loc_oPg.txt_4c_Dempresa.Value = ALLTRIM(NComps)
            ELSE
                THIS.AbrirBuscaEmpresa()
            ENDIF
            USE IN cursor_4c_EmpVal
        ELSE
            THIS.AbrirBuscaEmpresa()
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarInv1 - Busca 1[o] invent[a]rio pelo c[o]digo digitado (SigCdBal.Codigos)
    *   Replica Get_Inv1.Valid do original: fwBuscaExt por Codigos filtrado por Emps
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarInv1()
        LOCAL loc_oPg, loc_nCodigo, loc_cSQL, loc_nResult
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_nCodigo = loc_oPg.txt_4c_Inv1.Value
        IF loc_nCodigo = 0
            loc_oPg.lbl_4c_Label2.Caption = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT Codigos, Grupos, Contas FROM SigCdBal " + ;
                   "WHERE Emps = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Empresa.Value)) + ;
                   " AND Codigos = " + ALLTRIM(STR(loc_nCodigo))
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Inv1Val")
        IF loc_nResult > 0
            SELECT cursor_4c_Inv1Val
            IF !EOF()
                loc_oPg.txt_4c_Inv1.Value    = Codigos
                loc_oPg.lbl_4c_Label2.Caption = ALLTRIM(Grupos) + " - " + ALLTRIM(Contas)
            ELSE
                THIS.AbrirBuscaInv1()
            ENDIF
            USE IN cursor_4c_Inv1Val
        ELSE
            THIS.AbrirBuscaInv1()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarInv2 - Busca 2[o] invent[a]rio pelo c[o]digo digitado (SigCdBal.Codigos)
    *   Replica Get_Inv2.Valid do original: fwBuscaExt por Codigos filtrado por Emps
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarInv2()
        LOCAL loc_oPg, loc_nCodigo, loc_cSQL, loc_nResult
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_nCodigo = loc_oPg.txt_4c_Inv2.Value
        IF loc_nCodigo = 0
            loc_oPg.lbl_4c_Label5.Caption = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT Codigos, Grupos, Contas FROM SigCdBal " + ;
                   "WHERE Emps = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Empresa.Value)) + ;
                   " AND Codigos = " + ALLTRIM(STR(loc_nCodigo))
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Inv2Val")
        IF loc_nResult > 0
            SELECT cursor_4c_Inv2Val
            IF !EOF()
                loc_oPg.txt_4c_Inv2.Value    = Codigos
                loc_oPg.lbl_4c_Label5.Caption = ALLTRIM(Grupos) + " - " + ALLTRIM(Contas)
            ELSE
                THIS.AbrirBuscaInv2()
            ENDIF
            USE IN cursor_4c_Inv2Val
        ELSE
            THIS.AbrirBuscaInv2()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS FormBuscaAuxiliar (PUBLIC - contrato BINDEVENT DblClick)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - Lookup de empresa pelo c[o]digo (SigCdEmP.Emps)
    *   Replica Get_Empresa.Valid do original: fAcessoEmpresa modo 'C'
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmP", "cursor_4c_BuscaEmp", "Emps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.Emps)
                loc_oPg.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_BuscaEmp.NComps)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Emps", "XX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("NComps", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPg.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.Emps)
                        loc_oPg.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_BuscaEmp.NComps)
                    ELSE
                        loc_oPg.txt_4c_Empresa.Value  = ""
                        loc_oPg.txt_4c_Dempresa.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaInv1 - Lookup do 1[o] Invent[a]rio (SigCdBal.Codigos)
    *   Replica Get_Inv1.Valid do original: fwBuscaExt por Codigos filtrado por Emps
    *   Colunas exibidas: Codigos(9999999999), Grupos, Contas
    *   Descri[c][a]o ap[o]s sele[c][a]o: lbl_4c_Label2.Caption = Grupos + " - " + Contas
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaInv1()
        LOCAL loc_nValor, loc_oBusca, loc_oPg, loc_cWhere, loc_cCodStr
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_nValor  = loc_oPg.txt_4c_Inv1.Value
        loc_cCodStr = IIF(loc_nValor = 0, "", ALLTRIM(STR(loc_nValor)))
        loc_cWhere  = "Emps = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Empresa.Value))
        loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdBal", "cursor_4c_BuscaBal1", "Codigos", loc_cCodStr, ;
            "Invent" + CHR(225) + "rios", ;
            .F., .T., loc_cWhere)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Inv1.Value    = cursor_4c_BuscaBal1.Codigos
                loc_oPg.lbl_4c_Label2.Caption = ALLTRIM(cursor_4c_BuscaBal1.Grupos) + ;
                                                " - " + ALLTRIM(cursor_4c_BuscaBal1.Contas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "9999999999", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Grupos", "", "Grupo")
                    loc_oBusca.mAddColuna("Contas", "", "Conta")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaBal1")
                        loc_oPg.txt_4c_Inv1.Value    = cursor_4c_BuscaBal1.Codigos
                        loc_oPg.lbl_4c_Label2.Caption = ALLTRIM(cursor_4c_BuscaBal1.Grupos) + ;
                                                        " - " + ALLTRIM(cursor_4c_BuscaBal1.Contas)
                    ELSE
                        loc_oPg.txt_4c_Inv1.Value    = 0
                        loc_oPg.lbl_4c_Label2.Caption = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaBal1")
            USE IN cursor_4c_BuscaBal1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaInv2 - Lookup do 2[o] Invent[a]rio (SigCdBal.Codigos)
    *   Replica Get_Inv2.Valid do original: fwBuscaExt por Codigos filtrado por Emps
    *   Colunas exibidas: Codigos(9999999999), Grupos, Contas
    *   Descri[c][a]o ap[o]s sele[c][a]o: lbl_4c_Label5.Caption = Grupos + " - " + Contas
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaInv2()
        LOCAL loc_nValor, loc_oBusca, loc_oPg, loc_cWhere, loc_cCodStr
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_nValor  = loc_oPg.txt_4c_Inv2.Value
        loc_cCodStr = IIF(loc_nValor = 0, "", ALLTRIM(STR(loc_nValor)))
        loc_cWhere  = "Emps = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Empresa.Value))
        loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdBal", "cursor_4c_BuscaBal2", "Codigos", loc_cCodStr, ;
            "Invent" + CHR(225) + "rios", ;
            .F., .T., loc_cWhere)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Inv2.Value    = cursor_4c_BuscaBal2.Codigos
                loc_oPg.lbl_4c_Label5.Caption = ALLTRIM(cursor_4c_BuscaBal2.Grupos) + ;
                                                " - " + ALLTRIM(cursor_4c_BuscaBal2.Contas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "9999999999", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Grupos", "", "Grupo")
                    loc_oBusca.mAddColuna("Contas", "", "Conta")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaBal2")
                        loc_oPg.txt_4c_Inv2.Value    = cursor_4c_BuscaBal2.Codigos
                        loc_oPg.lbl_4c_Label5.Caption = ALLTRIM(cursor_4c_BuscaBal2.Grupos) + ;
                                                        " - " + ALLTRIM(cursor_4c_BuscaBal2.Contas)
                    ELSE
                        loc_oPg.txt_4c_Inv2.Value    = 0
                        loc_oPg.lbl_4c_Label5.Caption = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaBal2")
            USE IN cursor_4c_BuscaBal2
        ENDIF
    ENDPROC

    *==========================================================================
    * A[C][O]ES DOS BOT[O]ES DO RELAT[O]RIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica campos obrigat[o]rios antes de gerar relat[o]rio
    *   Valida[c][o]es na ordem: empresa -> Inv1 -> Inv2 -> Inv1 != Inv2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_oPg, loc_lValido
        loc_lValido = .F.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Empresa.Value))
                MsgInfo("Informe a empresa.", "Filtro Obrigat" + CHR(243) + "rio")
            ELSE
                IF loc_oPg.txt_4c_Inv1.Value = 0
                MsgInfo("Informe o 1" + CHR(186) + " Invent" + CHR(225) + "rio.", ;
                    "Filtro Obrigat" + CHR(243) + "rio")
            ELSE
                IF loc_oPg.txt_4c_Inv2.Value = 0
                MsgInfo("Informe o 2" + CHR(186) + " Invent" + CHR(225) + "rio.", ;
                    "Filtro Obrigat" + CHR(243) + "rio")
            ELSE
                IF loc_oPg.txt_4c_Inv1.Value = loc_oPg.txt_4c_Inv2.Value
                MsgInfo("Invent" + CHR(225) + "rio 2 deve ser diferente do 1" + CHR(186) + ".", ;
                    "Filtro Inv" + CHR(225) + "lido")
            ELSE
                loc_lValido = .T.
                ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
                ELSE
                    THIS.this_oRelatorio.RegistrarAuditoria("VISUALIZAR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnImprimirClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
                ELSE
                    THIS.this_oRelatorio.RegistrarAuditoria("IMPRIMIR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcelClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF PEMSTATUS(THIS.this_oRelatorio, "ExportarExcel", 5)
                    IF !THIS.this_oRelatorio.ExportarExcel()
                        MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
                    ELSE
                        THIS.this_oRelatorio.RegistrarAuditoria("EXCEL")
                    ENDIF
                ELSE
                    MsgInfo("Exporta" + CHR(231) + CHR(227) + "o para Excel n" + CHR(227) + ;
                        "o implementada para este relat" + CHR(243) + "rio.", ;
                        "Recurso n" + CHR(227) + "o dispon" + CHR(237) + "vel")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT (aliases para compatibilidade com pipeline)
    *==========================================================================

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgInfo("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
            CHR(237) + "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        TRY
            THIS.LimparCampos()
            IF VARTYPE(THIS.pgf_4c_Paginas.Page1) = "O"
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Empresa", 5)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPg.txt_4c_Empresa.Value  = NVL(.this_cEmpresa, "")
                loc_oPg.txt_4c_Dempresa.Value = NVL(.this_cDempresa, "")
                loc_oPg.txt_4c_Inv1.Value     = NVL(.this_nInv1, 0)
                loc_oPg.txt_4c_Inv2.Value     = NVL(.this_nInv2, 0)
                loc_oPg.obj_4c_OptTipo.Value  = NVL(.this_nTipo, 1)
            ENDWITH
            THIS.AtualizarEstadoCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O"
                IF PEMSTATUS(loc_oPg, "txt_4c_Empresa", 5)
                    loc_oPg.txt_4c_Empresa.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Inv1", 5)
                    loc_oPg.txt_4c_Inv1.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Inv2", 5)
                    loc_oPg.txt_4c_Inv2.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "obj_4c_OptTipo", 5)
                    loc_oPg.obj_4c_OptTipo.Enabled = loc_lHab
                ENDIF
            ENDIF
            IF loc_lHab
                THIS.AtualizarEstadoCampos()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera refer[e]ncia ao BO
    *   RelatorioBase herda de Custom (sem Release()) - usar .NULL. para liberar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
