*==============================================================================
* FormFpN.prg
* Form: Condicoes de Pagamento por Operacao (SIGCDTBD)
* OPERACIONAL - Dialog popup aberto por form pai passando (oFormPai, cDopes)
* Tabela: SigCdFpN
* Herda de: FormBase
*
* Uso: CREATEOBJECT("FormFpN", oFormPai, cDopes)
*   oFormPai : referencia ao form que abre este dialog (sera desabilitado)
*   cDopes   : codigo da operacao (FK SigCdOpe.Dopes)
*==============================================================================

DEFINE CLASS FormFpN AS FormBase

    Width        = 800
    Height       = 400
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Movable      = .F.
    BorderStyle  = 2
    ClipControls = .F.
    ShowTips     = .T.
    DataSession  = 2

    *-- Referencia ao form pai (Enabled=.F. ao abrir, .T. ao fechar)
    this_oParentForm = .NULL.

    *-- Codigo da operacao que esta sendo editada
    this_cDopes = ""

    *==========================================================================
    * Init - Recebe referencia ao form pai e codigo da operacao
    * Desabilita o form pai antes de abrir (comportamento modal original)
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_oParentForm, par_cDopes

        LOCAL loc_oErro
        TRY
            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm = par_oParentForm
                par_oParentForm.Enabled = .F.
            ENDIF

            THIS.this_cDopes = ALLTRIM(IIF(VARTYPE(par_cDopes) = "C", par_cDopes, ""))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.Init")
        ENDTRY

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria estrutura visual e carrega dados
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.this_oBusinessObject = CREATEOBJECT("FpNBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.Caption = "Tabelas de Desconto"

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()

                BINDEVENT(THIS.cmd_4c_Inserir,   "Click", THIS, "CmdInserirClick")
                BINDEVENT(THIS.cmd_4c_Excluir,   "Click", THIS, "CmdExcluirClick")
                BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "CmdConfirmarClick")
                BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")

                THIS.pgf_4c_Principal.Visible    = .T.
                THIS.pgf_4c_Principal.ActivePage = 1

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarDados()
                ENDIF

                THIS.TornarControlesVisiveis(THIS)
                THIS.Visible  = .T.
                loc_lSucesso  = .T.
            ELSE
                MsgErro("Falha ao criar FpNBO.", "Erro em FormFpN.InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container header cinza com labels de titulo
    * Original: cntSombra Top=0, Left=-1, Width=800, Height=80, BackColor=100,100,100
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
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
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width - 20
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width - 20
                .ForeColor     = RGB(255, 255, 255)
                .ToolTipText   = "T" + CHR(237) + "tulo"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Cria botoes de acao sobrepostos ao cabecalho
    * Original: cmdInserir(500,4), cmdExcluir(575,4), cmdSair/Confirmar(650,4),
    *           Cancela(725,4) - todos Width=75, Height=75 (fwbtng padrao)
    * Ordem do Original (esquerda->direita): Inserir, Excluir, Confirmar, Cancelar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cmd_4c_Inserir", "CommandButton")
            WITH THIS.cmd_4c_Inserir
                .Top             = 4
                .Left            = 500
                .Width           = 75
                .Height          = 75
                .Caption         = "Inserir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .ToolTipText     = "Inserir nova condi" + CHR(231) + CHR(227) + "o de pagamento"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
                .Enabled         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH THIS.cmd_4c_Excluir
                .Top             = 4
                .Left = 230
                .Width           = 75
                .Height          = 75
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .ToolTipText     = "Excluir condi" + CHR(231) + CHR(227) + "o selecionada"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
                .Enabled         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH THIS.cmd_4c_Confirmar
                .Top             = 4
                .Left            = 650
                .Width           = 75
                .Height          = 75
                .Caption         = "Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .ToolTipText     = "Confirmar e gravar as condi" + CHR(231) + CHR(245) + "es"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
                .Enabled         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH THIS.cmd_4c_Cancelar
                .Top             = 4
                .Left            = 725
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .ToolTipText     = "Cancelar sem gravar e fechar"
                .Cancel          = .T.
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
                .Enabled         = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - PageFrame de 1 pagina ocupando area abaixo do header
    * Original nao tem PageFrame (grid solto na form);
    * usamos PageFrame de 1 pagina para satisfazer contrato FormBase e
    * hospedar grd_4c_GradeOpe na Fase 4.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("pgf_4c_Principal", "PageFrame")
            WITH THIS.pgf_4c_Principal
                .Top         = 80
                .Left        = 0
                .Width       = THIS.Width
                .Height      = THIS.Height - 80
                .PageCount   = 1
                .Tabs        = .F.
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            WITH THIS.pgf_4c_Principal.Page1
                .Caption = "Condi" + CHR(231) + CHR(245) + "es"
                .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 com grid de condicoes de pagamento
    * Original: GradeOpe Top=115, Left=236, Width=313, Height=274 (relativo ao form)
    * Relativo a Page1 (PageFrame Top=80): Top = 115-80 = 35
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Principal.Page1

            loc_oPagina.AddObject("grd_4c_GradeOpe", "Grid")
            loc_oGrid = loc_oPagina.grd_4c_GradeOpe

            WITH loc_oGrid
                .Top           = 35
                .Left          = 236
                .Width         = 313
                .Height        = 274
                .ColumnCount   = 2
                .DeleteMark    = .F.
                .RecordMark    = .F.
                .GridLines     = 1
                .GridLineColor = RGB(238, 238, 238)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .RowHeight     = 16
                .ScrollBars    = 2
                .Visible       = .T.
            ENDWITH

            WITH loc_oGrid.Column1
                .Width     = 80
                .Movable   = .F.
                .Resizable = .F.
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Condi" + CHR(231) + CHR(227) + "o"
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(90, 90, 90)
                    .BackColor   = RGB(255, 255, 255)
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .MaxLength   = 12
                ENDWITH
            ENDWITH

            WITH loc_oGrid.Column2
                .Width     = 200
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .FontSize  = 8
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ForeColor   = RGB(90, 90, 90)
                    .BackColor   = RGB(255, 255, 255)
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .ReadOnly    = .T.
                ENDWITH
            ENDWITH

            *-- BINDEVENT KeyPress na Column1.Text1 para lookup/validacao de Fpags
            BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress", THIS, "ValidarFpagsTxt")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarDados - Carrega registros do BO e vincula grid ao cursor
    * Deve ser chamado APOS ConfigurarPaginaLista (grid ja existe)
    * RecordSource/ControlSource definidos aqui pois BO recria o cursor
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oGrid, loc_cCursor, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND NOT EMPTY(THIS.this_cDopes)
                loc_lSucesso = THIS.this_oBusinessObject.CarregarRegistros(THIS.this_cDopes)
                loc_cCursor  = THIS.this_oBusinessObject.this_cCursorOpe

                IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                    IF VARTYPE(THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe) = "O"
                        loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe

                        *-- Pinar ColumnCount ANTES de RecordSource (evita auto-expand)
                        loc_oGrid.ColumnCount  = 2
                        loc_oGrid.RecordSource = loc_cCursor

                        loc_oGrid.Column1.ControlSource = loc_cCursor + ".Fpags"
                        loc_oGrid.Column2.ControlSource = loc_cCursor + ".Descrs"

                        *-- Reaplicar cabecalhos apos ControlSource (VFP reseta captions)
                        loc_oGrid.Column1.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                        THIS.FormatarGridLista(loc_oGrid)
                        loc_oGrid.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.CarregarDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Aplica formatacao visual padrao ao grid
    * Original: GradeOpe FontName=Tahoma, FontSize=8, ForeColor=90,90,90
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
            .SetAll("ForeColor", RGB(90, 90, 90),   "Column")
            .SetAll("BackColor", RGB(255, 255, 255), "Column")
            .HighlightStyle      = 2
            .HighlightBackColor  = RGB(255, 255, 255)
            .HighlightForeColor  = RGB(15, 41, 104)
            .GridLineColor       = RGB(238, 238, 238)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Nao aplicavel (form OPERACIONAL sem Page2)
    * O form SIGCDTBD original tem apenas grid + botoes, sem pagina de dados
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Itera Controls e Pages de PageFrames aninhados
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_nP
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * AlternarPagina - Stub de compatibilidade (form tem apenas 1 pagina)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Principal) = "O"
            THIS.pgf_4c_Principal.ActivePage = 1
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdInserirClick - Insere linha em branco no grid para nova condicao
    * Original: Insert Into xOpe (fpags) Values (Space(12)) + SetFocus Column1
    *==========================================================================
    PROCEDURE CmdInserirClick()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF THIS.this_oBusinessObject.InserirLinhaVazia()
                IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                    loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe
                    IF VARTYPE(loc_oGrid) = "O"
                        SELECT (THIS.this_oBusinessObject.this_cCursorOpe)
                        GO BOTTOM
                        loc_oGrid.Refresh()
                        loc_oGrid.Column1.SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.CmdInserirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdExcluirClick - Exclui linha corrente do grid
    * Original: Delete + Skip + Go Bott (se Eof) + GradeOpe.SetFocus
    *==========================================================================
    PROCEDURE CmdExcluirClick()
        LOCAL loc_oErro
        TRY
            IF THIS.this_oBusinessObject.ExcluirLinhaAtual()
                IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                    THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.CmdExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdConfirmarClick - Salva condicoes e fecha o dialog
    * Original: valida duplicatas -> se duplicata Return .F. (NAO fecha)
    *           -> DELETE SigCdFpN -> INSERT novos -> Release
    *==========================================================================
    PROCEDURE CmdConfirmarClick()
        LOCAL loc_lPodeFechar, loc_oErro
        loc_lPodeFechar = .T.
        TRY
            IF THIS.this_oBusinessObject.this_lGravaDados
                IF !THIS.this_oBusinessObject.Salvar(THIS.this_cDopes)
                    loc_lPodeFechar = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.CmdConfirmarClick")
            loc_lPodeFechar = .F.
        ENDTRY
        IF loc_lPodeFechar
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdCancelarClick - Fecha sem salvar (Destroy reabilita o form pai)
    * Original: parentform.enabled = .T. + Release
    *==========================================================================
    PROCEDURE CmdCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ValidarFpagsTxt - KeyPress handler do Column1.Text1 (lookup de condicao)
    * Dispara em ENTER(13), TAB(9), F4(115)
    * Valida codigo no SQL Server; abre picker se nao encontrado ou F4 direto
    *==========================================================================
    PROCEDURE ValidarFpagsTxt(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oGrid, loc_cFpags

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        IF VARTYPE(THIS.pgf_4c_Principal) != "O"
            RETURN
        ENDIF
        loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe
        IF VARTYPE(loc_oGrid) != "O"
            RETURN
        ENDIF

        loc_cFpags = ALLTRIM(NVL(loc_oGrid.Column1.Text1.Value, ""))

        IF par_nKeyCode = 115 OR EMPTY(loc_cFpags)
            THIS.AbrirLookupFpags()
        ELSE
            IF THIS.this_oBusinessObject.ValidarLookupFpags(loc_cFpags)
                SELECT (THIS.this_oBusinessObject.this_cCursorOpe)
                REPLACE Descrs WITH ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
                THIS.this_oBusinessObject.this_lGravaDados = .T.
                loc_oGrid.Refresh()
            ELSE
                THIS.AbrirLookupFpags()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupFpags - Abre picker FormBuscaAuxiliar para SigOpFp
    * Original: fwBuscaExt em Column1.Text1.Valid
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupFpags()
        LOCAL loc_oBusca, loc_oGrid, loc_cValAtual, loc_oErro
        TRY
            loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe
            loc_cValAtual = ""
            IF VARTYPE(loc_oGrid) = "O"
                loc_cValAtual = ALLTRIM(NVL(loc_oGrid.Column1.Text1.Value, ""))
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, ;
                "SigOpFp", ;
                "cursor_4c_FpNLkpPicker", ;
                "Fpags", ;
                loc_cValAtual, ;
                "Sele" + CHR(231) + CHR(227) + "o de Condi" + CHR(231) + CHR(227) + "o", ;
                .F., ;
                .T., ;
                "")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Fpags",  "", "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_FpNLkpPicker")
                    SELECT cursor_4c_FpNLkpPicker
                    LOCAL loc_cFpagsEscolhido, loc_cDescrsEscolhido
                    loc_cFpagsEscolhido  = ALLTRIM(Fpags)
                    loc_cDescrsEscolhido = ALLTRIM(descrs)

                    SELECT (THIS.this_oBusinessObject.this_cCursorOpe)
                    REPLACE Fpags  WITH loc_cFpagsEscolhido
                    REPLACE Descrs WITH loc_cDescrsEscolhido
                    THIS.this_oBusinessObject.this_lGravaDados = .T.

                    IF VARTYPE(loc_oGrid) = "O"
                        loc_oGrid.Refresh()
                    ENDIF
                ENDIF

                IF USED("cursor_4c_FpNLkpPicker")
                    USE IN cursor_4c_FpNLkpPicker
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_FpNLkpPicker")
                USE IN cursor_4c_FpNLkpPicker
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.AbrirLookupFpags")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Alias CRUD do CmdInserirClick (padrao esperado pelo pipeline)
    * Form OPERACIONAL: reusa a rotina real de insercao de linha vazia no grid
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.CmdInserirClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alias CRUD; neste form OPERACIONAL a alteracao ocorre
    * diretamente na Column1 do grid (lookup Fpags). Foca a celula editavel
    * do registro corrente para permitir digitacao imediata.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oGrid, loc_cCursor, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe
                IF VARTYPE(loc_oGrid) = "O"
                    loc_cCursor = THIS.this_oBusinessObject.this_cCursorOpe
                    IF USED(loc_cCursor)
                        SELECT (loc_cCursor)
                        IF RECCOUNT() > 0 AND !EOF()
                            loc_oGrid.Refresh()
                            loc_oGrid.Column1.SetFocus()
                        ELSE
                            MsgAviso("Nenhuma condi" + CHR(231) + CHR(227) + ;
                                "o de pagamento para alterar.", "Aviso")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Alias CRUD; foca o grid em modo leitura (sem editar)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oGrid, loc_cCursor, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_GradeOpe
                IF VARTYPE(loc_oGrid) = "O"
                    loc_cCursor = THIS.this_oBusinessObject.this_cCursorOpe
                    IF USED(loc_cCursor)
                        SELECT (loc_cCursor)
                        IF RECCOUNT() > 0
                            GO TOP
                            loc_oGrid.Refresh()
                            loc_oGrid.SetFocus()
                        ELSE
                            MsgAviso("Nenhuma condi" + CHR(231) + CHR(227) + ;
                                "o de pagamento cadastrada.", "Aviso")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Alias CRUD do CmdExcluirClick com confirmacao do usuario
    * Reusa a rotina real de exclusao de linha do grid
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da condi" + ;
                CHR(231) + CHR(227) + "o de pagamento selecionada?", ;
                "Confirma" + CHR(231) + CHR(227) + "o")
                THIS.CmdExcluirClick()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega dados do servidor (buscar atualizado)
    * OPERACIONAL: nao ha filtro de pesquisa; recarrega registros da operacao
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            IF NOT EMPTY(THIS.this_cDopes)
                THIS.CarregarDados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormFpN.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha dialog sem salvar (alias de CmdCancelarClick)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdCancelarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva e fecha dialog (alias de CmdConfirmarClick)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.CmdConfirmarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela sem salvar (alias de CmdCancelarClick)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.CmdCancelarClick()
    ENDPROC

    *==========================================================================
    * CarregarLista - Alias de CarregarDados para compatibilidade com pipeline
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * FormParaBO - Nao aplicavel: form OPERACIONAL gerencia cursor diretamente
    * Retorna .T. para nao bloquear fluxos que chamem este metodo via heranca
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Nao aplicavel: form OPERACIONAL gerencia cursor diretamente
    * Retorna .T. para nao bloquear fluxos que chamem este metodo via heranca
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Nao aplicavel: form OPERACIONAL sem modo INCLUIR/ALTERAR
    * Stub de compatibilidade com FormBase
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    *==========================================================================
    * LimparCampos - Nao aplicavel: form OPERACIONAL sem campos de Page2
    * Stub de compatibilidade com FormBase
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        RETURN
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Nao aplicavel: form OPERACIONAL sem modo CRUD
    * Stub de compatibilidade com FormBase
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
        RETURN
    ENDPROC

    *==========================================================================
    * Destroy - Reabilita form pai e libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.this_oParentForm     = .NULL.
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
