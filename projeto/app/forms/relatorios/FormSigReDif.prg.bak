*==============================================================================
* FORMSIGREDIF.PRG
* Exibidor de Diferencas Contabeis
* Tipo: DISPLAY/REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREDIF.SCX (frmrelatorio)
*
* Recebe DataSessionId do form chamador para acessar cursores movaux e dif2.
* O BO (SigReDifBO.PrepararDados) chave para a sessao do chamador, cria crGrid
* e restaura. Init() entao junta o DataSessionId ao form para ver crGrid.
* Exibe grade de 14 colunas com diferencas e historico no rodape.
*
* FASE 3/8 - Estrutura base:
*   - Properties (dimensoes, sessao, BO)
*   - Init(par_nDataSessionId): armazena sessao, DODEFAULT(), junta sessao
*   - InicializarForm(): cria BO, cabecalho, botoes
*   - ConfigurarCabecalho(): container escuro com titulo
*   - ConfigurarBotoes(): CommandGroup 4 botoes (Visualizar, Imprimir,
*                         Documento, Encerrar)
*   - Destroy(): libera referencia ao BO
*==============================================================================

DEFINE CLASS FormSigReDif AS FormBase

    *-- Dimensoes (acomodam grade de 14 colunas + label historico no rodape)
    *   Grid: Left=72, Width=668 -> borda direita 740
    *   cmg_4c_Botoes: Left=529, Width=273 -> borda direita 802 (< 810)
    Height      = 570
    Width       = 810
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

    *-- DataSessionId do form chamador (passado em Init, propagado ao BO)
    this_nDataSessionId = 0

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio     = .NULL.
    this_cMensagemErro  = ""

    *--------------------------------------------------------------------------
    * Init - Armazena DataSessionId do chamador, delega para FormBase.Init()
    *        via DODEFAULT() (que chama THIS.InicializarForm()), e entao
    *        junta o DataSessionId ao form para que o grid veja crGrid.
    *        Equivalente a: DoDefault() + ThisForm.DataSessionId = _Acesso
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nDataSessionId)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF PCOUNT() > 0 AND VARTYPE(par_nDataSessionId) = "N" AND ;
               par_nDataSessionId > 0
                THIS.this_nDataSessionId = par_nDataSessionId
            ENDIF

            *-- Inicializacao padrao: header, botoes, layout (DODEFAULT chama
            *   FormBase.Init que por sua vez chama THIS.InicializarForm)
            loc_lSucesso = DODEFAULT()

            *-- Junta a sessao do form chamador para ver movaux/dif2/crGrid
            *   Equivalente a: ThisForm.DataSessionId = _Acesso no legado
            IF loc_lSucesso AND THIS.this_nDataSessionId > 0
                THIS.DataSessionId = THIS.this_nDataSessionId

                *-- Popula crGrid e configura RecordSource/colunas do grid
                THIS.CarregarGrade()
                IF USED("crGrid") AND RECCOUNT("crGrid") > 0
                    SELECT crGrid
                    GO TOP
                    THIS.txt_4c_Historico.Value = ALLTRIM(crGrid.Hists)
                ENDIF
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
    * InicializarForm - Cria BO, configura cabecalho e botoes de relatorio.
    *                   Chamado automaticamente por FormBase.Init() via DODEFAULT.
    *                   Nao chama PrepararDados aqui - isso ocorre na Fase 4
    *                   apos Init() juntar o DataSessionId correto.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Diferen" + CHR(231) + "as Encontradas"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SigReDifBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReDifBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Propaga DataSessionId ao BO para uso em PrepararDados (Fase 4)
                THIS.this_oRelatorio.this_nDataSessionId = THIS.this_nDataSessionId

                *-- Monta layout do form REPORT: cabecalho escuro + CommandGroup
                *   de 4 botoes. Em forms REPORT (frmrelatorio) nao ha PageFrame
                *   CRUD; ConfigurarPageFrame() orquestra os equivalentes.
                THIS.ConfigurarPageFrame()

                *-- Sincroniza labels de titulo com caption do form
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.Visible = .T.
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
    * ConfigurarPageFrame - Orquestra o layout do form REPORT.
    *   Forms REPORT (frmrelatorio) NAO tem PageFrame CRUD (Lista/Dados);
    *   o equivalente eh o cabecalho escuro + CommandGroup de botoes.
    *   Este metodo eh o ponto unico de montagem do layout, espelhando o
    *   papel de ConfigurarPageFrame() em forms CRUD.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Container escuro com titulo (equivalente ao cntSombra)
        THIS.ConfigurarCabecalho()

        *-- CommandGroup com 4 botoes de relatorio (equivalente ao BTNREPORT)
        THIS.ConfigurarBotoes()

        *-- Grid de 14 colunas com diferencas + label/textbox Historico
        THIS.ConfigurarPaginaLista()

        *-- Propriedades estruturais das colunas 1-7 (Movable, Resizable, InputMask)
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo.
    *   Equivalente ao cntSombra do frmrelatorio (framework.vcx).
    *   Largura = THIS.Width (cobre toda a faixa superior do form).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_nLarguraForm
        loc_nLarguraForm = THIS.Width
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = loc_nLarguraForm
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            *-- Sombra (deslocada 2px para efeito 3D do texto branco)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = loc_nLarguraForm
                .Height    = 30
                .Caption   = "Diferen" + CHR(231) + "as Encontradas"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco (sobre a sombra)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = loc_nLarguraForm
                .Height    = 30
                .Caption   = "Diferen" + CHR(231) + "as Encontradas"
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
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio.
    *   Geometria EXATA do framework frmrelatorio.vcx (BTNREPORT):
    *     cmg_4c_Botoes: Top=0, Left=529, Width=273, Height=80, ButtonCount=4
    *     Buttons: Left=5/71/137/203, Width=65, Height=70
    *   BINDEVENTs (Click) sao vinculados na Fase 7.
    *   Buttons(4).Cancel=.T. para fechar com ESC.
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

            *-- Visualizar: exibe relatorio em preview na tela
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
                .ToolTipText     = "Visualizar relat" + CHR(243) + "rio na tela"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Imprimir: envia relatorio com dialogo de selecao de impressora
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
                .ToolTipText     = "Imprimir com di" + CHR(225) + "logo de impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Documento: imprime direto na impressora padrao (sem dialogo)
            *   Original: BTNREPORT.DOCEXCEL -> Procedure "documento"
            *   -> REPORT FORM SigReDif To Printer NoConsole
            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Documento"
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
                .ToolTipText     = "Imprimir direto na impressora padr" + CHR(227) + "o"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Encerrar: fecha o form (Cancel=.T. ativa com ESC)
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

        *-- Vincula eventos Click dos botoes (metodos publicos do form)
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria grid de 14 colunas, label e textbox Historico
    *   Espelha Grid1 (Top=168 Left=72 W=668 H=345), Label1 e Text1 do legado.
    *   RecordSource e ControlSources sao aplicados em CarregarGrade(), apos
    *   crGrid existir (criado por PrepararDados na sessao do chamador).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top               = 168
            .Left              = 72
            .Width             = 668
            .Height            = 345
            .HeaderHeight       = 0
            .ColumnCount       = 14
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .GridLineColor     = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle    = 2
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 18
            .ScrollBars        = 3
            .ReadOnly          = .T.
            .Visible           = .T.
        ENDWITH

        *-- AfterRowColChange mostra Hists da linha selecionada (espelha Grid1.AfterRowColChange)
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GridAposLinhaColChange")

        *-- Label "Historico:" (espelha Label1 do legado)
        THIS.AddObject("lbl_4c_Historico", "Label")
        WITH THIS.lbl_4c_Historico
            .Top       = 525
            .Left      = 72
            .Width     = 58
            .Height    = 15
            .Caption   = "Hist" + CHR(243) + "rico: "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox de historico (somente leitura - espelha Text1 WHEN=.F. do legado)
        THIS.AddObject("txt_4c_Historico", "TextBox")
        WITH THIS.txt_4c_Historico
            .Top      = 521
            .Left     = 140
            .Width    = 500
            .Height   = 23
            .Value    = ""
            .ReadOnly = .T.
            .Enabled  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrade - Chama PrepararDados e configura RecordSource/colunas/headers
    *   Chamado em Init() apos juntar DataSessionId do form chamador.
    *   Necessario chamar APOS juntar a sessao para que crGrid fique visivel.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrade()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.PrepararDados()
            ENDIF

            IF USED("crGrid")
                THIS.grd_4c_Dados.RecordSource = "crGrid"
                WITH THIS.grd_4c_Dados
                    *-- ControlSources das 14 colunas (campos do cursor crGrid/movaux)
                    .Column1.ControlSource  = "crGrid.AnoFis"
                    .Column2.ControlSource  = "Substr(crGrid.Datas,1,2)+[/]+Substr(crGrid.Datas,3,2)+[/]+Substr(crGrid.Datas,5,4)"
                    .Column3.ControlSource  = "crGrid.Contas"
                    .Column4.ControlSource  = "crGrid.Debs"
                    .Column5.ControlSource  = "crGrid.Creds"
                    .Column6.ControlSource  = "crGrid.Docto"
                    .Column7.ControlSource  = "crGrid.EmpCont"
                    .Column8.ControlSource  = "crGrid.NumSeq"
                    .Column9.ControlSource  = "crGrid.Nums"
                    .Column10.ControlSource = "crGrid.Data"
                    .Column11.ControlSource = "crGrid.Valor"
                    .Column12.ControlSource = "crGrid.Cecus"
                    .Column13.ControlSource = "crGrid.Emps"
                    .Column14.ControlSource = "crGrid.Transacaos"

                    *-- Redefine headers: RecordSource reseta captions (FORMCOR licao #2)
                    .Column1.Header1.Caption  = "Ano"
                    .Column2.Header1.Caption  = "Data"
                    .Column3.Header1.Caption  = "Conta"
                    .Column4.Header1.Caption  = "D" + CHR(233) + "bito"
                    .Column5.Header1.Caption  = "Cr" + CHR(233) + "dito"
                    .Column6.Header1.Caption  = "Documento"
                    .Column7.Header1.Caption  = "Cont."
                    .Column8.Header1.Caption  = "Seq."
                    .Column9.Header1.Caption  = "Numes"
                    .Column10.Header1.Caption = "Data"
                    .Column11.Header1.Caption = "Valor"
                    .Column12.Header1.Caption = "C. Custo"
                    .Column13.Header1.Caption = "Emp."
                    .Column14.Header1.Caption = "Transa" + CHR(231) + CHR(227) + "o"

                    *-- ForeColor dos headers: cols 1-10 cinza, cols 11-14 azul (igual original)
                    .Column1.Header1.ForeColor  = RGB(90, 90, 90)
                    .Column2.Header1.ForeColor  = RGB(90, 90, 90)
                    .Column3.Header1.ForeColor  = RGB(90, 90, 90)
                    .Column4.Header1.ForeColor  = RGB(90, 90, 90)
                    .Column5.Header1.ForeColor  = RGB(90, 90, 90)
                    .Column6.Header1.ForeColor  = RGB(90, 90, 90)
                    .Column7.Header1.ForeColor  = RGB(90, 90, 90)
                    .Column8.Header1.ForeColor  = RGB(90, 90, 90)
                    .Column9.Header1.ForeColor  = RGB(90, 90, 90)
                    .Column10.Header1.ForeColor = RGB(90, 90, 90)
                    .Column11.Header1.ForeColor = RGB(36, 84, 155)
                    .Column12.Header1.ForeColor = RGB(36, 84, 155)
                    .Column13.Header1.ForeColor = RGB(36, 84, 155)
                    .Column14.Header1.ForeColor = RGB(36, 84, 155)

                    *-- FontName/FontSize/Alignment dos headers (fidelidade ao original)
                    .SetAll("FontName", "Tahoma", "Header")
                    .SetAll("FontSize", 8, "Header")
                    .Column11.Header1.FontName = "Verdana"
                    .Column12.Header1.FontName = "Verdana"
                    .Column13.Header1.FontName = "Verdana"
                    .Column14.Header1.FontName = "Verdana"
                    .SetAll("Alignment", 2, "Header")
                    .Column14.Header1.Alignment = 0

                    *-- Larguras exatas do original (total ~945px -> ScrollBars=3)
                    .Column1.Width  = 38
                    .Column2.Width  = 80
                    .Column3.Width  = 73
                    .Column4.Width  = 94
                    .Column5.Width  = 94
                    .Column6.Width  = 80
                    .Column7.Width  = 31
                    .Column8.Width  = 52
                    .Column9.Width  = 52
                    .Column10.Width = 80
                    .Column11.Width = 94
                    .Column12.Width = 66
                    .Column13.Width = 31
                    .Column14.Width = 80

                    .FontName = "Tahoma"
                    .FontSize = 8
                    .SetAll("ReadOnly", .T., "Column")
                    .Refresh()
                ENDWITH
                SELECT crGrid
                GO TOP
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro CarregarGrade")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Propriedades estruturais das 14 colunas do grid.
    *   Espelha Column1..Column14 do legado: Movable=.F., Resizable=.F.,
    *   ReadOnly=.T., InputMask/Format/Alignment/MaxLength onde definidos.
    *   Configura tambem Text1 de cada coluna (BorderStyle=0, Margin=0, cores).
    *   Chamado em ConfigurarPageFrame() apos ConfigurarPaginaLista().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        IF VARTYPE(THIS.grd_4c_Dados) != "O"
            RETURN
        ENDIF
        WITH THIS.grd_4c_Dados
            *-- Col 1: Ano fiscal (4 digitos numericos)
            WITH .Column1
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .InputMask = "9999"
            ENDWITH
            WITH .Column1.Text1
                .BorderStyle = 0
                .InputMask   = "9999"
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            *-- Col 2: Data como string DDMMYYYY; Format="R" exibe com separadores
            WITH .Column2
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .Format    = "R"
            ENDWITH
            WITH .Column2.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            *-- Col 3: Conta contabil (9 digitos) - ForeColor cinza, FontName Tahoma
            WITH .Column3
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .InputMask = "999999999"
            ENDWITH
            WITH .Column3.Text1
                .BorderStyle = 0
                .FontName    = "Tahoma"
                .InputMask   = "999999999"
                .Margin      = 0
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            *-- Col 4: Debito (string formatada - sem InputMask)
            WITH .Column4
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
            ENDWITH
            WITH .Column4.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            *-- Col 5: Credito (string formatada - sem InputMask)
            WITH .Column5
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
            ENDWITH
            WITH .Column5.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            *-- Col 6: Documento (10 digitos)
            WITH .Column6
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .InputMask = "9999999999"
            ENDWITH
            WITH .Column6.Text1
                .BorderStyle = 0
                .InputMask   = "9999999999"
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            *-- Col 7: Empresa contabilidade (sem InputMask em Text1 - identico ao original)
            WITH .Column7
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .InputMask = "999999"
            ENDWITH
            WITH .Column7.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            *-- Col 8: Seq (sequencia de lancamento - 6 digitos)
            WITH .Column8
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .InputMask = "999999"
            ENDWITH
            WITH .Column8.Text1
                .BorderStyle = 0
                .InputMask   = "999999"
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            *-- Col 9: Numes (numero de lancamento - 6 digitos)
            WITH .Column9
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
                .InputMask = "999999"
            ENDWITH
            WITH .Column9.Text1
                .BorderStyle = 0
                .InputMask   = "999999"
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            *-- Col 10: Data (campo DATE do cursor - sem InputMask)
            WITH .Column10
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
            ENDWITH
            WITH .Column10.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            *-- Col 11: Valor (string formatada - sem InputMask)
            WITH .Column11
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
            ENDWITH
            WITH .Column11.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            *-- Col 12: C. Custo - centrado, max 3 caracteres
            WITH .Column12
                .Alignment = 2
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
            ENDWITH
            WITH .Column12.Text1
                .Alignment   = 2
                .BorderStyle = 0
                .Margin      = 0
                .MaxLength   = 3
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            *-- Col 13: Emp. - max 3 caracteres
            WITH .Column13
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
            ENDWITH
            WITH .Column13.Text1
                .BorderStyle = 0
                .Margin      = 0
                .MaxLength   = 3
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            *-- Col 14: Transacao - max 10 caracteres
            WITH .Column14
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
            ENDWITH
            WITH .Column14.Text1
                .BorderStyle = 0
                .Margin      = 0
                .MaxLength   = 10
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * MAPEAMENTO EVENTOS PRINCIPAIS (form REPORT - frmrelatorio)
    *
    * Forms CRUD usam os handlers BtnIncluirClick, BtnAlterarClick,
    * BtnVisualizarClick, BtnExcluirClick. Para este form REPORT (frmrelatorio)
    * o equivalente funcional dos botoes do CommandGroup superior eh:
    *
    *   BtnIncluirClick   -> Mapeado para BtnImprimirClick   (Buttons(2))
    *   BtnAlterarClick   -> Mapeado para BtnDocumentoClick  (Buttons(3))
    *   BtnVisualizarClick -> Implementado abaixo            (Buttons(1))
    *   BtnExcluirClick   -> Mapeado para BtnEncerrarClick   (Buttons(4))
    *
    * O legado SIGREDIF (frmrelatorio) so define as 3 acoes de relatorio
    * (Preview, Print Prompt, Print) + ESC para fechar. Nao existem
    * operacoes de Insercao/Alteracao/Exclusao - forms REPORT sao read-only.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe relatorio em preview na tela
    *   Espelha Buttons(1) -> REPORT FORM SigReDif Preview NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Erro ao Visualizar")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio com dialogo de selecao de impressora
    *   Espelha Buttons(2) -> REPORT FORM SigReDif To Printer Prompt NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF !THIS.this_oRelatorio.Imprimir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Erro ao Imprimir")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Imprime relatorio direto na impressora padrao
    *   Espelha Buttons(3) -> REPORT FORM SigReDif To Printer NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF !THIS.this_oRelatorio.GerarDocumento()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Erro ao Gerar Documento")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Documento")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o form
    *   Espelha Buttons(4) Cancel=.T. / ESC
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Form REPORT nao tem PageFrame Lista/Dados como CRUD.
    *   Quando chamado, garante apresentacao do grid: recarrega dados se vazio
    *   e reposiciona o cursor crGrid no primeiro registro. Mantem assinatura
    *   compativel para chamadores genericos (par_nPagina ignorado).
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF !USED("crGrid")
            THIS.CarregarGrade()
        ENDIF
        IF USED("crGrid")
            SELECT crGrid
            GO TOP
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            IF VARTYPE(THIS.txt_4c_Historico) = "O" AND !EOF("crGrid")
                THIS.txt_4c_Historico.Value = ALLTRIM(crGrid.Hists)
                THIS.txt_4c_Historico.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GridAposLinhaColChange - Exibe Hists da linha atual em txt_4c_Historico
    *   Espelha Grid1.AfterRowColChange do legado:
    *     ThisForm.text1.Value = crGrid.Hists / ThisForm.text1.Refresh
    *   par_nColIndex: obrigatorio - BINDEVENT AfterRowColChange exige o parametro
    *--------------------------------------------------------------------------
    PROCEDURE GridAposLinhaColChange(par_nColIndex)
        IF USED("crGrid") AND !EOF("crGrid")
            THIS.txt_4c_Historico.Value = ALLTRIM(crGrid.Hists)
            THIS.txt_4c_Historico.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Propaga DataSessionId ao BO antes de imprimir/visualizar
    *   Neste form nao ha campos de filtro; o dado vem via DataSessionId passado
    *   no Init(). Garante que o BO esta sincronizado antes de cada acao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nDataSessionId = THIS.this_nDataSessionId
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Consolida estado de exibicao no BO antes de cada acao
    *   Em forms CRUD esse metodo copia inputs do usuario para o BO. Aqui
    *   (REPORT) propaga a sessao de dados e a linha corrente do grid para
    *   que Visualizar/Imprimir/GerarDocumento usem o contexto certo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        THIS.this_oRelatorio.this_nDataSessionId = THIS.this_nDataSessionId
        IF USED("crGrid") AND !EOF("crGrid")
            THIS.this_oRelatorio.CarregarDoCursor("crGrid")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Reflete dados do BO (linha corrente) nos campos de exibicao
    *   Em forms CRUD copia propriedades this_* do BO para TextBoxes editaveis.
    *   Aqui atualiza apenas o textbox de Historico, que e o unico campo
    *   reflexivo do REPORT.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF VARTYPE(THIS.txt_4c_Historico) = "O"
            THIS.txt_4c_Historico.Value = ALLTRIM(THIS.this_oRelatorio.this_cHists)
            THIS.txt_4c_Historico.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega o grid de diferencas e sincroniza o historico
    *   Em forms CRUD popula a Page1 (lista). Aqui delega para CarregarGrade
    *   (que repopula crGrid e configura colunas) e atualiza o textbox de
    *   Historico com a primeira linha. Mantem nomenclatura compativel.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = THIS.CarregarGrade()
        IF loc_lSucesso AND USED("crGrid") AND RECCOUNT("crGrid") > 0
            SELECT crGrid
            GO TOP
            IF VARTYPE(THIS.txt_4c_Historico) = "O"
                THIS.txt_4c_Historico.Value = ALLTRIM(crGrid.Hists)
                THIS.txt_4c_Historico.Refresh()
            ENDIF
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega o grid de diferencas a partir do BO
    *   Em forms CRUD abre busca/lookup. Aqui acionada via menu/teclado
    *   pelo usuario para reavaliar movaux/dif2 e refletir alteracoes.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT "salvar" significa emitir o documento final
    *   Delega para BtnImprimirClick (gera saida fisica/PDF do relatorio).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT "cancelar" equivale a encerrar a janela
    *   Delega para BtnEncerrarClick (Release do form).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa campos de exibicao e reseta a linha corrente
    *   Zera o textbox de Historico e reposiciona o cursor crGrid no inicio
    *   para apresentacao consistente apos qualquer acao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        IF VARTYPE(THIS.txt_4c_Historico) = "O"
            THIS.txt_4c_Historico.Value = ""
            THIS.txt_4c_Historico.Refresh()
        ENDIF
        IF USED("crGrid") AND RECCOUNT("crGrid") > 0
            SELECT crGrid
            GO TOP
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Form REPORT e sempre somente-leitura.
    *   txt_4c_Historico: Enabled=.F., ReadOnly=.T.
    *   grd_4c_Dados: ReadOnly=.T. em todas as colunas.
    *   par_lHabilitar ignorado (compatibilidade com FormBase).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        IF VARTYPE(THIS.txt_4c_Historico) = "O"
            THIS.txt_4c_Historico.Enabled  = .F.
            THIS.txt_4c_Historico.ReadOnly = .T.
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.ReadOnly = .T.
            THIS.grd_4c_Dados.SetAll("ReadOnly", .T., "Column")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Mantem os 4 botoes do CommandGroup sempre ativos
    *   Form REPORT nao tem modos CRUD (Lista/Edicao); todas as acoes
    *   (Visualizar/Imprimir/Documento/Encerrar) ficam permanentemente
    *   disponiveis enquanto o form esta aberto.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_nI
        IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
            RETURN
        ENDIF
        FOR loc_nI = 1 TO THIS.cmg_4c_Botoes.ButtonCount
            THIS.cmg_4c_Botoes.Buttons(loc_nI).Enabled = .T.
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO (NUNCA .Release() em objeto Custom/BO)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
