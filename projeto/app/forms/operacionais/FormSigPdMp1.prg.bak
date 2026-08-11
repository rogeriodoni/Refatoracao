*==============================================================================
* FORMSIGPDMP1.PRG
* Form OPERACIONAL: Componentes Agregados (SIGPDMP1)
* Aberto pelo FormSigPdMov passando referencia ao form pai (par_oFormPai).
* Compartilha DataSession com o form pai para acesso aos cursores xNensi
* e tmpnens. Permite visualizacao e edicao parcial dos componentes de
* uma operacao de industrializacao.
*==============================================================================

DEFINE CLASS FormSigPdMp1 AS FormBase

    *-- Propriedades visuais (exatas do original SIGPDMP1)
    Width            = 800
    Height           = 600
    Caption          = "Componentes Agregados"
    DataSession      = 2
    ShowWindow = 1
    WindowType = 1
    BorderStyle      = 2
    TitleBar         = 0
    ControlBox       = .F.
    Closable         = .F.
    MaxButton        = .F.
    MinButton        = .F.
    Movable          = .F.
    ClipControls     = .F.
    Themes           = .F.
    AutoCenter       = .T.
    Picture          = ""

    *-- Estado do form
    this_oBusinessObject  = .NULL.
    this_oFormPai         = .NULL.
    this_cEscolha         = ""
    this_nRecnoAnt        = 0
    this_lLiberaAlteracao = .F.
    this_nAntValue        = 0
    this_nTotPeso         = 0

    *-- Container cabecalho cinza (cntSombra no legado)
    ADD OBJECT cnt_4c_Sombra AS Container WITH ;
        Top = 0, Left = 0, Width = 800, Height = 80, ;
        BorderWidth = 0, BackColor = RGB(100,100,100)

    *-- Shape decorativo area botoes (Shape1 no legado)
    ADD OBJECT shp_4c_Shape1 AS Shape WITH ;
        Top = 7, Left = 694, Height = 110, Width = 90, ;
        BackStyle = 0, BorderStyle = 0, BorderColor = RGB(136,189,188)

    *-- Container dados da operacao (Opera=o no legado)
    *-- TextBoxes adicionados na Fase 5 (GetCodigo, GetEmpresa, GetOpera=o)
    ADD OBJECT cnt_4c_Operacao AS Container WITH ;
        Top = 82, Left = 38, Width = 358, Height = 40, ;
        BackStyle = 0, BorderWidth = 0, BackColor = RGB(255,255,255)

    *==========================================================================
    * Init - Compartilha datasession com o form pai e inicializa o form
    * Parametro: par_oFormPai - referencia ao form que chamou este form
    *==========================================================================
    PROCEDURE Init(par_oFormPai)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
            THIS.this_cEscolha = ALLTRIM(par_oFormPai.pcEscolha)
            *-- Compartilha datasession do form pai: acessa xNensi, tmpnens, crSigCdOpd
            THIS.DataSessionId = par_oFormPai.DataSessionId
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, inicializa cursores e configura interface
    * Chamado automaticamente por FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cCaption, loc_cTitulo
        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("SigPdMp1BO")
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            MsgErro("Erro ao criar SigPdMp1BO.", "Erro")
            RETURN loc_lSucesso
        ENDIF

        TRY
            *-- Caption dinamico: Fase Anterior somente no modo INSERIR
            loc_cCaption = "Componentes Agregados"
            IF ALLTRIM(THIS.this_cEscolha) = "INSERIR"
                loc_cCaption = loc_cCaption + " Fase Anterior"
            ENDIF
            THIS.Caption = loc_cCaption

            *-- Fundo do form (new_background.jpg)
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Titulo dinamico da coluna Industrializacao (dois niveis acima no legado)
            loc_cTitulo = ""
            IF VARTYPE(THIS.this_oFormPai) = "O"
                IF VARTYPE(THIS.this_oFormPai.ParentForm) = "O"
                    IF TYPE("THIS.this_oFormPai.ParentForm.Titulo") = "C"
                        loc_cTitulo = ALLTRIM(THIS.this_oFormPai.ParentForm.Titulo)
                    ENDIF
                ENDIF
            ENDIF

            *-- Inicializa cursor de distribuicao a partir de xNensi
            THIS.this_oBusinessObject.InicializarDistrib(loc_cTitulo)

            *-- Inicializa cursor de resumo (GROUP BY Cmats, Cunis, CuniPs sobre xNensi.Visivel)
            THIS.this_oBusinessObject.InicializarResumo()

            *-- Captura totalizadores calculados pelo BO
            THIS.this_nTotPeso  = THIS.this_oBusinessObject.this_nTotPeso
            THIS.this_nRecnoAnt = THIS.this_oBusinessObject.this_nRecnoAnt

            *-- Configura layout visual do form
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarContainerOperacao()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            *-- Torna todos os controles visiveis
            THIS.TornarControlesVisiveis(THIS)

            *-- Caption dinamico do header Industrializacao (ParentForm.ParentForm.Titulo no legado)
            IF !EMPTY(loc_cTitulo) AND VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Column1.Header1.Caption = loc_cTitulo
            ENDIF

            *-- Botao Alterar visivel somente no modo INSERIR (replica logica fChecaAcesso do legado)
            IF VARTYPE(THIS.cmd_4c_Alterar) = "O"
                THIS.cmd_4c_Alterar.Visible = INLIST(ALLTRIM(THIS.this_cEscolha), "INSERIR")
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Form OPERACIONAL nao usa PageFrame (Page1/Page2).
    * SIGPDMP1 original eh um popup modal com layout plano: cabecalho cinza,
    * container Operacao com codigo/empresa/operacao, dois grids (Grade e
    * grdResumo) e botoes Ok/Alterar diretamente no form. Sem PageFrame.
    *
    * Este metodo existe por compatibilidade com a pipeline de migracao e
    * garante propriedades essenciais do form (centralizacao, fundo, modo).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Centralizar e dimensoes (idempotente; pipeline pode rechamar)
        THIS.AutoCenter = .T.
        THIS.Width  = 800
        THIS.Height = 600

        *-- Fundo do form (padrao operacional)
        IF TYPE("gc_4c_CaminhoIcones") = "C"
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF

        *-- Caption ajustado conforme escolha (INSERIR mostra Fase Anterior)
        IF ALLTRIM(THIS.this_cEscolha) = "INSERIR"
            THIS.Caption = "Componentes Agregados Fase Anterior"
        ELSE
            THIS.Caption = "Componentes Agregados"
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Adiciona labels de titulo no cnt_4c_Sombra
    * Equivale a lblSombra e lblTitulo dentro de cntSombra no legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = THIS.Caption

        WITH THIS.cnt_4c_Sombra
            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = loc_cCaption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = loc_cCaption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = 769
                .ForeColor  = RGB(255, 255, 255)
                .Visible    = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerOperacao - Adiciona label e textboxes no cnt_4c_Operacao
    * Say1 "Operacao :" + GetEmpresa + GetOperacao + GetCodigo (todos ReadOnly)
    * Vinculados ao cursor tmpnens (DataSession compartilhada com o form pai)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerOperacao()
        WITH THIS.cnt_4c_Operacao
            .AddObject("lbl_4c_LblOperacao", "Label")
            WITH .lbl_4c_LblOperacao
                .FontSize  = 8
                .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
                .Left      = 18
                .Top       = 13
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Empresa", "TextBox")
            WITH .txt_4c_Empresa
                .Left          = 76
                .Top           = 9
                .Width         = 36
                .Height        = 23
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH
            IF USED("tmpnens")
                THIS.cnt_4c_Operacao.txt_4c_Empresa.ControlSource = "tmpnens.emps"
            ENDIF

            .AddObject("txt_4c_Operacao", "TextBox")
            WITH .txt_4c_Operacao
                .Left          = 114
                .Top           = 9
                .Width         = 156
                .Height        = 23
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH
            IF USED("tmpnens")
                THIS.cnt_4c_Operacao.txt_4c_Operacao.ControlSource = "tmpnens.dopps"
            ENDIF

            .AddObject("txt_4c_Codigo", "TextBox")
            WITH .txt_4c_Codigo
                .Left          = 272
                .Top           = 9
                .Width         = 81
                .Height        = 23
                .ReadOnly      = .T.
                .InputMask     = "9999999999"
                .Alignment     = 3
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH
            IF USED("tmpnens")
                THIS.cnt_4c_Operacao.txt_4c_Codigo.ControlSource = "tmpnens.numps"
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Setup visual da area "lista" do form OPERACIONAL
    *
    * SIGPDMP1 eh OPERACIONAL (popup modal sem PageFrame Page1/Page2). A area
    * de "lista" no template CRUD eh aqui o bloco superior do form: o grid
    * principal de componentes (Grade no legado) e os botoes de acao (Alterar/
    * OK) no topo. O bloco inferior (descricao + totais + resumo) eh agrupado
    * em ConfigurarPaginaDados().
    *
    *  - grd_4c_Dados   : grid de componentes (Grade no legado, 11 colunas)
    *  - cmd_4c_Alterar : libera edicao das colunas (botao Alterar)
    *  - cmd_4c_Ok      : persiste alteracoes e fecha (botao ok)
    *
    * O form NAO tem botoes CRUD (Incluir/Visualizar/Excluir/Buscar/Encerrar)
    * porque o legado nao tem - paridade funcional 100% com SIGPDMP1.SCX.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarGradeDistrib()
        THIS.ConfigurarBotoes()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Setup visual da area "dados/detalhes" do form
    *
    * Em forms CRUD, ConfigurarPaginaDados configura a Page2 com campos de
    * edicao. Em SIGPDMP1 (OPERACIONAL) nao ha Page2; este metodo agrupa o
    * bloco inferior do form com os campos de detalhe e o grid de totais:
    *
    *  - lbl_4c_Label2  : label "Descricao :" (Say2 no legado)
    *  - txt_4c_Descr   : campo de descricao da linha corrente do grid
    *                     principal (Get_descr no legado, vinculado a
    *                     cursor_4c_Distrib.CDescs)
    *  - txt_4c_TotPeso : total de peso da fase anterior calculado pelo BO
    *                     (getTotPeso no legado)
    *  - grd_4c_Resumo  : grid de resumo com totais agrupados por componente
    *                     (grdResumo no legado, 6 colunas, ReadOnly)
    *
    * Ordem importa: ConfigurarCamposExtras() cria os controles flutuantes
    * (labels/textboxes) que ficam visualmente sobre/abaixo do grid principal;
    * ConfigurarGradeResumo() cria o grid de totais no rodape do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarCamposExtras()
        THIS.ConfigurarGradeResumo()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL SIGPDMP1 nao possui PageFrame Page1/
    * Page2 nem alternancia entre modos LISTA/DADOS. Este metodo existe para
    * compatibilidade com a estrutura padrao da pipeline de migracao; apenas
    * garante o foco na grade principal quando chamado.
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarGradeDistrib - Grid principal (Grade) com 11 colunas
    * Cols 3 (Pesos), 5 (Qtds), 8 (Peso2s) tornam-se editaveis apos Alterar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeDistrib()
        THIS.AddObject("grd_4c_Dados", "Grid")

        WITH THIS.grd_4c_Dados
            .Top         = 125
            .Left        = 38
            .Width       = 724
            .Height      = 329
            .ColumnCount = 11
            .RecordSource = "cursor_4c_Distrib"
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .ReadOnly    = .F.
            .ScrollBars  = 2
            .GridLines   = 1
            .RowHeight   = 16
            .FontName    = "Verdana"
            .FontSize    = 8
            .Themes      = .F.

            *-- ColumnOrder replica a ordem visual do original (SCX usava ColumnOrder para rearranjar)
            *-- Visual: Industrializacao | Componente | Descricao | Cor | Tam. | Unid. | Qtde(1) | Unid.(2) | Qtde(2) | Peso Fabr. | Lote

            WITH .Column1
                .ColumnOrder   = 1
                .Width         = 83
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.Nops"
                .FontName      = "Courier New"
                .FontSize      = 9
                .InputMask     = "9999999999"
                .Alignment     = 3
                .Header1.Caption = "Industrializa" + CHR(231) + CHR(227) + "o"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column2
                .ColumnOrder   = 2
                .Width         = 100
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.CMats"
                .Header1.Caption = "Componente"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column3
                .ColumnOrder   = 10
                .Width         = 80
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.Pesos"
                .Header1.Caption = "Peso Fabr."
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column4
                .ColumnOrder   = 6
                .Width         = 31
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.CUnis"
                .Header1.Caption = "Unid."
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column5
                .ColumnOrder   = 7
                .Width         = 80
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.Qtds"
                .Header1.Caption = "Qtde (1)"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column6
                .ColumnOrder   = 3
                .Width         = 50
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.CDescs"
                .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column7
                .ColumnOrder   = 11
                .Width         = 80
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.nLotes"
                .Header1.Caption = "Lote"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column8
                .ColumnOrder   = 9
                .Width         = 70
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.Peso2s"
                .Header1.Caption = "Qtde (2)"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column9
                .ColumnOrder   = 8
                .Width         = 31
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.cUniPs"
                .Header1.Caption = "Unid."
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column10
                .ColumnOrder   = 4
                .Width         = 38
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.CodCors"
                .Header1.Caption = "Cor"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column11
                .ColumnOrder   = 5
                .Width         = 38
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Distrib.CodTams"
                .Header1.Caption = "Tam."
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 9
                .Header1.Alignment = 2
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- Redefine ControlSource apos RecordSource para neutralizar auto-bind do VFP
        THIS.grd_4c_Dados.Column1.ControlSource  = "cursor_4c_Distrib.Nops"
        THIS.grd_4c_Dados.Column2.ControlSource  = "cursor_4c_Distrib.CMats"
        THIS.grd_4c_Dados.Column3.ControlSource  = "cursor_4c_Distrib.Pesos"
        THIS.grd_4c_Dados.Column4.ControlSource  = "cursor_4c_Distrib.CUnis"
        THIS.grd_4c_Dados.Column5.ControlSource  = "cursor_4c_Distrib.Qtds"
        THIS.grd_4c_Dados.Column6.ControlSource  = "cursor_4c_Distrib.CDescs"
        THIS.grd_4c_Dados.Column7.ControlSource  = "cursor_4c_Distrib.nLotes"
        THIS.grd_4c_Dados.Column8.ControlSource  = "cursor_4c_Distrib.Peso2s"
        THIS.grd_4c_Dados.Column9.ControlSource  = "cursor_4c_Distrib.cUniPs"
        THIS.grd_4c_Dados.Column10.ControlSource = "cursor_4c_Distrib.CodCors"
        THIS.grd_4c_Dados.Column11.ControlSource = "cursor_4c_Distrib.CodTams"

        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDistribAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "GotFocus",  THIS, "GrdCol3GotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "KeyPress", THIS, "GrdCol3LostFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "GotFocus",  THIS, "GrdCol5GotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "KeyPress", THIS, "GrdCol5LostFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "GotFocus",  THIS, "GrdCol8GotFocus")
        BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "KeyPress", THIS, "GrdCol8LostFocus")
    ENDPROC

    *==========================================================================
    * ConfigurarGradeResumo - Grid de resumo com 6 colunas (grdResumo)
    * Exibe cursor_4c_Resumo: totais agrupados por componente
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGradeResumo()
        THIS.AddObject("grd_4c_Resumo", "Grid")

        WITH THIS.grd_4c_Resumo
            .Top               = 481
            .Left              = 38
            .Width             = 446
            .Height            = 114
            .ColumnCount       = 6
            .RecordSource      = "cursor_4c_Resumo"
            .RecordMark        = .F.
            .DeleteMark        = .F.
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .GridLines         = 1
            .RowHeight         = 16
            .HeaderHeight      = 16
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .FontName          = "Verdana"
            .FontSize          = 8
            .Themes            = .F.

            WITH .Column1
                .Width         = 108
                .ControlSource = "cursor_4c_Resumo.CMats"
                .Header1.Caption = "Componente"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column2
                .Width         = 80
                .ControlSource = "cursor_4c_Resumo.Qtds"
                .Header1.Caption = "Qtde (1)"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column3
                .Width         = 31
                .ControlSource = "cursor_4c_Resumo.CUnis"
                .Header1.Caption = "Unid."
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column4
                .Width         = 80
                .ControlSource = "cursor_4c_Resumo.Peso2s"
                .Header1.Caption = "Qtde (2)"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column5
                .Width         = 31
                .ControlSource = "cursor_4c_Resumo.CUniPs"
                .Header1.Caption = "Unid."
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            WITH .Column6
                .Width         = 80
                .ControlSource = "cursor_4c_Resumo.Pesos"
                .Header1.Caption = "Peso Fabr."
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- Redefine ControlSource apos RecordSource para neutralizar auto-bind do VFP
        THIS.grd_4c_Resumo.Column1.ControlSource = "cursor_4c_Resumo.CMats"
        THIS.grd_4c_Resumo.Column2.ControlSource = "cursor_4c_Resumo.Qtds"
        THIS.grd_4c_Resumo.Column3.ControlSource = "cursor_4c_Resumo.CUnis"
        THIS.grd_4c_Resumo.Column4.ControlSource = "cursor_4c_Resumo.Peso2s"
        THIS.grd_4c_Resumo.Column5.ControlSource = "cursor_4c_Resumo.CUniPs"
        THIS.grd_4c_Resumo.Column6.ControlSource = "cursor_4c_Resumo.Pesos"
    ENDPROC

    *==========================================================================
    * ConfigurarCamposExtras - Label+TextBox descricao e TextBox total peso
    * Say2 "Descricao :" + Get_descr (descricao da linha corrente do grid)
    * getTotPeso (soma PsFaseAnt calculada em InicializarDistrib)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposExtras()
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
            .Top       = 458
            .Left      = 71
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Descr", "TextBox")
        WITH THIS.txt_4c_Descr
            .Top           = 454
            .Left          = 131
            .Width         = 335
            .Height        = 23
            .ReadOnly      = .T.
            .ControlSource = "cursor_4c_Distrib.CDescs"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(240, 240, 240)
            .BorderStyle   = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_TotPeso", "TextBox")
        WITH THIS.txt_4c_TotPeso
            .Top         = 454
            .Left        = 577
            .Width       = 81
            .Height      = 23
            .ReadOnly    = .T.
            .Alignment   = 3
            .Value       = THIS.this_nTotPeso
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(240, 240, 240)
            .BorderStyle = 1
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Botoes Alterar (left=650) e OK (left=725)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH THIS.cmd_4c_Alterar
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "Alterar"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "OK"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Habilita edicao nas colunas Pesos, Qtds e Peso2s
    * BackColor 12713983 = RGB(255,255,193) pale-yellow do legado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        WITH THIS.grd_4c_Dados
            .Column3.ReadOnly  = .F.
            .Column3.BackColor = RGB(255, 255, 193)
            .Column5.ReadOnly  = .F.
            .Column5.BackColor = RGB(255, 255, 193)
            .Column8.ReadOnly  = .F.
            .Column8.BackColor = RGB(255, 255, 193)
            .Refresh()
        ENDWITH
        THIS.this_oBusinessObject.HabilitarAlteracao()
        THIS.grd_4c_Dados.Column5.SetFocus()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Reinicializa distribuicao a partir de xNensi
    *
    * SIGPDMP1 legado nao possui botao Incluir explicito; a "inclusao" ocorre
    * automaticamente no Init quando pcEscolha = "INSERIR" via reconstrucao
    * do cursor TmpDistrib percorrendo xNensi.Visivel = .F.. Este metodo
    * replica essa logica: recarrega cursor_4c_Distrib e cursor_4c_Resumo do
    * xNensi compartilhado pelo form pai e refresca grids e totalizador.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_cTitulo
        loc_cTitulo = THIS.this_oBusinessObject.this_cTitulo
        THIS.this_oBusinessObject.InicializarDistrib(loc_cTitulo)
        THIS.this_oBusinessObject.InicializarResumo()
        THIS.this_nTotPeso  = THIS.this_oBusinessObject.this_nTotPeso
        THIS.this_nRecnoAnt = THIS.this_oBusinessObject.this_nRecnoAnt
        IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
            THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        IF VARTYPE(THIS.grd_4c_Resumo) = "O"
            THIS.grd_4c_Resumo.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_Descr) = "O"
            THIS.txt_4c_Descr.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Restaura grid para modo somente-leitura
    *
    * Operacao inversa de BtnAlterarClick: ReadOnly = .T. e BackColor branco
    * nas colunas Pesos/Qtds/Peso2s, e desliga flag this_lLiberaAlteracao no
    * BO para que SalvarAlteracoes nao persista nada em xNensi.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            WITH THIS.grd_4c_Dados
                .Column3.ReadOnly  = .T.
                .Column3.BackColor = RGB(255, 255, 255)
                .Column5.ReadOnly  = .T.
                .Column5.BackColor = RGB(255, 255, 255)
                .Column8.ReadOnly  = .T.
                .Column8.BackColor = RGB(255, 255, 255)
                .Refresh()
            ENDWITH
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lLiberaAlteracao = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Descarta alteracoes feitas em cursor_4c_Distrib
    *
    * Confirma com o usuario e recarrega cursor_4c_Distrib do xNensi
    * (chamando InicializarDistrib novamente). Qualquer linha marcada como
    * modificada (Locals = 'M') eh perdida. Util quando o usuario decide
    * cancelar as alteracoes antes de pressionar OK.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cTitulo, loc_cMsg
        loc_cMsg = "Descartar todas as altera" + CHR(231) + CHR(245) + "es?"
        IF !MsgConfirma(loc_cMsg, "Confirma" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        loc_cTitulo = THIS.this_oBusinessObject.this_cTitulo
        THIS.this_oBusinessObject.InicializarDistrib(loc_cTitulo)
        THIS.this_oBusinessObject.InicializarResumo()
        THIS.this_nTotPeso = THIS.this_oBusinessObject.this_nTotPeso
        IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
            THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        IF VARTYPE(THIS.grd_4c_Resumo) = "O"
            THIS.grd_4c_Resumo.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_Descr) = "O"
            THIS.txt_4c_Descr.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnOkClick - Persiste alteracoes em xNensi e fecha o form
    *==========================================================================
    PROCEDURE BtnOkClick()
        THIS.this_oBusinessObject.SalvarAlteracoes()

        IF USED("xNensi")
            SELECT xNensi
            SET ORDER TO Editar
            IF THIS.this_nRecnoAnt > 0
                GO THIS.this_nRecnoAnt
            ENDIF
        ENDIF

        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    * GrdDistribAfterRowColChange - Atualiza campo descricao ao mudar linha/col
    *==========================================================================
    PROCEDURE GrdDistribAfterRowColChange(par_nColIndex)
        IF VARTYPE(THIS.txt_4c_Descr) = "O"
            THIS.txt_4c_Descr.Refresh()
        ENDIF
    ENDPROC

    *-- Handlers GotFocus/LostFocus para colunas editaveis (When/Valid do legado)

    PROCEDURE GrdCol3GotFocus()
        THIS.this_nAntValue = THIS.grd_4c_Dados.Column3.Text1.Value
    ENDPROC

    PROCEDURE GrdCol3LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.grd_4c_Dados.Column3.Text1.Value <> THIS.this_nAntValue
            THIS.this_oBusinessObject.MarcarModificado()
        ENDIF
    ENDPROC

    PROCEDURE GrdCol5GotFocus()
        THIS.this_nAntValue = THIS.grd_4c_Dados.Column5.Text1.Value
    ENDPROC

    PROCEDURE GrdCol5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.grd_4c_Dados.Column5.Text1.Value <> THIS.this_nAntValue
            THIS.this_oBusinessObject.MarcarModificado()
        ENDIF
    ENDPROC

    PROCEDURE GrdCol8GotFocus()
        THIS.this_nAntValue = THIS.grd_4c_Dados.Column8.Text1.Value
    ENDPROC

    PROCEDURE GrdCol8LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.grd_4c_Dados.Column8.Text1.Value <> THIS.this_nAntValue
            THIS.this_oBusinessObject.MarcarModificado()
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega cursores de distribuicao e resumo e refresca grids
    * Equivale ao bloco de carga do Init para uso apos alteracoes externas.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_cTitulo
        loc_cTitulo = THIS.this_oBusinessObject.this_cTitulo
        THIS.this_oBusinessObject.InicializarDistrib(loc_cTitulo)
        THIS.this_oBusinessObject.InicializarResumo()
        THIS.this_nTotPeso  = THIS.this_oBusinessObject.this_nTotPeso
        THIS.this_nRecnoAnt = THIS.this_oBusinessObject.this_nRecnoAnt
        IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
            THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        IF VARTYPE(THIS.grd_4c_Resumo) = "O"
            THIS.grd_4c_Resumo.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_Descr) = "O"
            THIS.txt_4c_Descr.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Sincroniza propriedades de controle do form para o BO
    * O BO gerencia cursor_4c_Distrib diretamente; apenas sincroniza estado.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_nTotPeso         = THIS.this_nTotPeso
        THIS.this_oBusinessObject.this_lLiberaAlteracao = THIS.this_lLiberaAlteracao
    ENDPROC

    *==========================================================================
    * BOParaForm - Atualiza controles do form com dados do BO
    * Refresca totalizador de peso e campo de descricao da linha corrente.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        THIS.this_nTotPeso = THIS.this_oBusinessObject.this_nTotPeso
        IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
            THIS.txt_4c_TotPeso.Value = THIS.this_nTotPeso
        ENDIF
        IF VARTYPE(THIS.txt_4c_Descr) = "O"
            THIS.txt_4c_Descr.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita edicao nas colunas do grid
    * par_lHabilitar = .T. -> colunas Pesos/Qtds/Peso2s editaveis (amarelo)
    * par_lHabilitar = .F. -> colunas somente-leitura (branco)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            WITH THIS.grd_4c_Dados
                .Column3.ReadOnly = !par_lHabilitar
                .Column5.ReadOnly = !par_lHabilitar
                .Column8.ReadOnly = !par_lHabilitar
                IF par_lHabilitar
                    .Column3.BackColor = RGB(255, 255, 193)
                    .Column5.BackColor = RGB(255, 255, 193)
                    .Column8.BackColor = RGB(255, 255, 193)
                ELSE
                    .Column3.BackColor = RGB(255, 255, 255)
                    .Column5.BackColor = RGB(255, 255, 255)
                    .Column8.BackColor = RGB(255, 255, 255)
                ENDIF
                .Refresh()
            ENDWITH
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta estado do form para o estado inicial (sem edicao)
    * Zera totalizador, desativa modo de edicao e restaura colunas ReadOnly.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        THIS.this_nTotPeso         = 0
        THIS.this_lLiberaAlteracao = .F.
        IF VARTYPE(THIS.txt_4c_TotPeso) = "O"
            THIS.txt_4c_TotPeso.Value = 0
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lLiberaAlteracao = .F.
        ENDIF
        THIS.HabilitarCampos(.F.)
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Controla visibilidade do botao Alterar conforme modo
    * Botao Alterar visivel somente no modo INSERIR (replica fChecaAcesso do legado)
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmd_4c_Alterar) = "O"
            THIS.cmd_4c_Alterar.Visible = INLIST(ALLTRIM(THIS.this_cEscolha), "INSERIR")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Persiste alteracoes e fecha (equivalente ao BtnOkClick)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnOkClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Fecha o form sem persistir alteracoes
    * Reabilita o form pai antes de encerrar.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o form sem persistir alteracoes
    * Form operacional nao possui botao Encerrar fisico; metodo existe para
    * compatibilidade com FormBase e pode ser invocado via ESC/KeyPress.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Nao aplicavel em form operacional SIGPDMP1
    * Metodo existe para compatibilidade com FormBase. Navega para o topo do
    * grid principal como comportamento neutro.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            IF USED("cursor_4c_Distrib") AND !EOF("cursor_4c_Distrib")
                SELECT cursor_4c_Distrib
                GO TOP
            ENDIF
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera BO e referencia ao form pai
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        THIS.this_oFormPai        = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
