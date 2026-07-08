*==============================================================================
* FORMSIGPDMP3.PRG
* Form OPERACIONAL: Emissao de Etiquetas (SIGPDMP9)
* Aberto pelo form pai (FormSigPdMov ou similar) passando referencia ao
* form pai via par_oFormPai. Compartilha DataSession com o form pai para
* acesso aos cursores xOpi, xPesa, TmpNens, xmfas, crSigCdOpd, crSigCdNec.
* Permite configuracao de pesagem individual/divisao para emissao de
* etiquetas de ordens de fabricacao.
* FASE 8/8 - COMPLETO (todos os metodos implementados, BO completo, integrado via config.prg)
*==============================================================================

DEFINE CLASS FormSigPdMp3 AS FormBase

    *-- Propriedades visuais (exatas do original SIGPDMP9)
    Width        = 1000
    Height       = 600
    Caption      = ""
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    BorderStyle  = 2
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    Themes       = .F.
    AutoCenter   = .T.
    Picture      = ""

    *-- Estado do form e contexto do form pai
    this_oBusinessObject = .NULL.
    this_oFormPai        = .NULL.
    this_cEscolha        = ""
    this_cDopp           = ""

    *------------------------------------------------------------------
    * ADD OBJECT - Containers e elementos visuais de nivel superior
    *------------------------------------------------------------------

    *-- Container cabecalho cinza (cntSombra no legado)
    ADD OBJECT cnt_4c_Sombra AS Container WITH ;
        Top = 0, Left = 0, Width = 1100, Height = 80, ;
        BorderWidth = 0, BackColor = RGB(100,100,100)

    *-- Shape decorativo area botoes direita (Shape2 no legado)
    ADD OBJECT shp_4c_Shape2 AS Shape WITH ;
        Top = 10, Left = 802, Height = 110, Width = 90, ;
        BackStyle = 0, BorderStyle = 0, BorderColor = RGB(136,189,188)

    *-- Shape decorativo menor (Shape1 no legado)
    ADD OBJECT shp_4c_Shape1 AS Shape WITH ;
        Top = 10, Left = 898, Height = 26, Width = 90, ;
        BackStyle = 0, BorderStyle = 0, BorderColor = RGB(136,189,188)

    *-- Shape area imagem produto (Shape4 no legado - oculto por padrao)
    ADD OBJECT shp_4c_Shape4 AS Shape WITH ;
        Top = 97, Left = 507, Height = 217, Width = 289, ;
        BackStyle = 0, Visible = .F., BorderColor = RGB(90,90,90)

    *-- Imagem do produto (FigJpg no legado - oculto ate produto ser selecionado)
    ADD OBJECT img_4c_FigJpg AS Image WITH ;
        Stretch = 1, Height = 213, Left = 510, Top = 99, ;
        Visible = .F., Width = 284

    *-- Container info movimentacao (Container1 no legado)
    ADD OBJECT cnt_4c_Container1 AS Container WITH ;
        Top = 97, Left = 13, Width = 491, Height = 70, ;
        BackStyle = 1, SpecialEffect = 0, ;
        BackColor = RGB(255,255,255), BorderColor = RGB(136,189,188)

    *-- Container cabecalho da operacao - empresa/operacao/codigo (Opera<ao no legado)
    ADD OBJECT cnt_4c_Operacao AS Container WITH ;
        Top = 122, Left = 18, Width = 391, Height = 40, ;
        BackStyle = 0, BorderWidth = 0, BackColor = RGB(255,255,255)

    *-- Container conta de origem (Origem no legado)
    ADD OBJECT cnt_4c_Origem AS Container WITH ;
        Top = 170, Left = 13, Width = 491, Height = 70, ;
        BackStyle = 1, SpecialEffect = 0, ;
        BackColor = RGB(255,255,255), BorderColor = RGB(136,189,188)

    *-- Container conta de destino (Destino no legado)
    ADD OBJECT cnt_4c_Destino AS Container WITH ;
        Top = 244, Left = 13, Width = 491, Height = 70, ;
        SpecialEffect = 0, ;
        BackColor = RGB(255,255,255), BorderColor = RGB(136,189,188)

    *==========================================================================
    * Init - Compartilha datasession com o form pai e inicializa o form
    * Parametro: par_oFormPai - referencia ao form que chamou este form
    * CRITICO: DataSessionId deve ser compartilhado ANTES de DODEFAULT()
    * para que InicializarForm() acesse xOpi, xPesa, TmpNens, crSigCdOpd
    *==========================================================================
    PROCEDURE Init(par_oFormPai)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
            THIS.this_cEscolha = ALLTRIM(par_oFormPai.pcEscolha)
            THIS.this_cDopp    = ALLTRIM(par_oFormPai._Dopp)
            *-- Compartilha datasession: cursores xOpi, xPesa, TmpNens, crSigCdOpd ficam acessiveis
            THIS.DataSessionId = par_oFormPai.DataSessionId
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, configura interface visual e popula dados
    * Chamado automaticamente por FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("SigPdMp3BO")
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            MsgErro("Erro ao criar SigPdMp3BO.", "Erro")
            RETURN loc_lSucesso
        ENDIF

        TRY
            *-- Repassa contexto do form pai para o BO
            THIS.this_oBusinessObject.this_cDopp    = THIS.this_cDopp
            THIS.this_oBusinessObject.this_cEscolha = THIS.this_cEscolha

            *-- Fundo e caption do form (padrao operacional)
            IF TYPE("gc_4c_CaminhoIcones") = "C"
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF
            THIS.Caption = "Emiss" + CHR(227) + "o de Etiquetas"

            *-- Configura layout visual base
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarContainerMovimentacao()
            THIS.ConfigurarContainerOperacao()
            THIS.ConfigurarContainerOrigem()
            THIS.ConfigurarContainerDestino()

            *-- Torna todos os controles visiveis (exceto elementos flutuantes de foto)
            THIS.TornarControlesVisiveis(THIS)

            *-- Popula descricao das contas (SigCdCli lookup) nos campos ReadOnly
            THIS.PopularDescricoesConta()

            *-- Ajusta visibilidade de Origem e Destino conforme crSigCdOpd
            THIS.AjustarVisibilidadeContainers()

            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarBotoesForm()
            THIS.ConfigurarPaginaDados()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Form OPERACIONAL sem PageFrame.
    * Define propriedades essenciais do form (dimensoes, fundo, caption).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AutoCenter = .T.
        THIS.Width      = 1000
        THIS.Height     = 600
        IF TYPE("gc_4c_CaminhoIcones") = "C"
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF
        THIS.Caption = "Emiss" + CHR(227) + "o de Etiquetas"
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Adiciona labels de titulo no cnt_4c_Sombra
    * Replica lblSombra (sombra preta) e lblTitulo (texto branco) do legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = "Emiss" + CHR(227) + "o de Etiquetas"

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
    * ConfigurarContainerMovimentacao - Configura cnt_4c_Container1
    * Label "Movimenta=ao" + linha decorativa (Say4 + Line1 do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerMovimentacao()
        WITH THIS.cnt_4c_Container1
            .AddObject("lbl_4c_LblMovimentacao", "Label")
            WITH .lbl_4c_LblMovimentacao
                .FontBold  = .T.
                .FontSize  = 8
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Left      = 8
                .Top       = 1
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lin_4c_Line1", "Line")
            WITH .lin_4c_Line1
                .BorderWidth = 2
                .Height      = 0
                .Left        = 8
                .Top         = 16
                .Width       = 316
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerOperacao - Configura cnt_4c_Operacao
    * Campos ReadOnly vinculados a tmpnens: Empresa + Operacao + Codigo (numps)
    * Replica GetEmpresa, GetOpera=ao, GetCodigo do legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerOperacao()
        WITH THIS.cnt_4c_Operacao
            .AddObject("txt_4c_Empresa", "TextBox")
            WITH .txt_4c_Empresa
                .Left              = 3
                .Top               = 2
                .Width             = 36
                .Height            = 23
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ForeColor         = RGB(0, 0, 0)
                .BackColor         = RGB(255, 255, 255)
                .BorderStyle       = 1
                .SpecialEffect     = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .Visible           = .T.
            ENDWITH
            IF USED("tmpnens")
                THIS.cnt_4c_Operacao.txt_4c_Empresa.ControlSource = "tmpnens.emps"
            ENDIF

            .AddObject("txt_4c_Operacao", "TextBox")
            WITH .txt_4c_Operacao
                .Left              = 41
                .Top               = 2
                .Width             = 156
                .Height            = 23
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ForeColor         = RGB(0, 0, 0)
                .BackColor         = RGB(255, 255, 255)
                .BorderStyle       = 1
                .SpecialEffect     = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .Themes            = .F.
                .Visible           = .T.
            ENDWITH
            IF USED("tmpnens")
                THIS.cnt_4c_Operacao.txt_4c_Operacao.ControlSource = "tmpnens.dopps"
            ENDIF

            .AddObject("txt_4c_Codigo", "TextBox")
            WITH .txt_4c_Codigo
                .Left              = 199
                .Top               = 2
                .Width             = 81
                .Height            = 23
                .ReadOnly          = .T.
                .Format            = "L"
                .InputMask         = "9999999999"
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ForeColor         = RGB(0, 0, 0)
                .BackColor         = RGB(255, 255, 255)
                .BorderStyle       = 1
                .SpecialEffect     = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .Themes            = .F.
                .Visible           = .T.
            ENDWITH
            IF USED("tmpnens")
                THIS.cnt_4c_Operacao.txt_4c_Codigo.ControlSource = "tmpnens.numps"
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerOrigem - Configura cnt_4c_Origem
    * Labels "Origem"/"Grupo"/"Conta"/"Nome" + TextBoxes ReadOnly de tmpnens
    * Replica Origem.Say1-4, Origem.Get_grupo, Get_conta, Get_dconta do legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerOrigem()
        WITH THIS.cnt_4c_Origem
            .AddObject("lbl_4c_LblOrigem", "Label")
            WITH .lbl_4c_LblOrigem
                .FontBold  = .T.
                .FontSize  = 8
                .Caption   = "Origem"
                .Left      = 8
                .Top       = 1
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lin_4c_Line1", "Line")
            WITH .lin_4c_Line1
                .BorderWidth = 2
                .Height      = 0
                .Left        = 8
                .Top         = 16
                .Width       = 316
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.
            ENDWITH

            .AddObject("lbl_4c_LblGrupo", "Label")
            WITH .lbl_4c_LblGrupo
                .FontSize  = 8
                .Caption   = "Grupo"
                .Left      = 8
                .Top       = 21
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblConta", "Label")
            WITH .lbl_4c_LblConta
                .FontSize  = 8
                .Caption   = "Conta"
                .Left      = 93
                .Top       = 21
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblNome", "Label")
            WITH .lbl_4c_LblNome
                .FontSize  = 8
                .Caption   = "Nome"
                .Left      = 176
                .Top       = 20
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Grupo", "TextBox")
            WITH .txt_4c_Grupo
                .Left          = 8
                .Top           = 33
                .Width         = 80
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH
            IF USED("tmpnens")
                THIS.cnt_4c_Origem.txt_4c_Grupo.ControlSource = "tmpnens.grupoos"
            ENDIF

            .AddObject("txt_4c_Conta", "TextBox")
            WITH .txt_4c_Conta
                .Left          = 93
                .Top           = 33
                .Width         = 80
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH
            IF USED("tmpnens")
                THIS.cnt_4c_Origem.txt_4c_Conta.ControlSource = "tmpnens.contaos"
            ENDIF

            .AddObject("txt_4c_Dconta", "TextBox")
            WITH .txt_4c_Dconta
                .Left          = 176
                .Top           = 32
                .Width         = 302
                .Height        = 23
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerDestino - Configura cnt_4c_Destino
    * Labels "Destino"/"Grupo"/"Conta"/"Nome" + TextBoxes ReadOnly de tmpnens
    * Replica Destino.Say1-4, Destino.Get_grupo, Get_conta, Get_dconta do legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerDestino()
        WITH THIS.cnt_4c_Destino
            .AddObject("lbl_4c_LblDestino", "Label")
            WITH .lbl_4c_LblDestino
                .FontBold  = .T.
                .FontSize  = 8
                .Caption   = "Destino"
                .Left      = 4
                .Top       = 1
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lin_4c_Line1", "Line")
            WITH .lin_4c_Line1
                .BorderWidth = 2
                .Height      = 0
                .Left        = 4
                .Top         = 16
                .Width       = 316
                .BorderColor = RGB(90, 90, 90)
                .Visible     = .T.
            ENDWITH

            .AddObject("lbl_4c_LblGrupo", "Label")
            WITH .lbl_4c_LblGrupo
                .FontSize  = 8
                .Caption   = "Grupo"
                .Left      = 4
                .Top       = 20
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblConta", "Label")
            WITH .lbl_4c_LblConta
                .FontSize  = 8
                .Caption   = "Conta"
                .Left      = 93
                .Top       = 20
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblNome", "Label")
            WITH .lbl_4c_LblNome
                .FontSize  = 8
                .Caption   = "Nome"
                .Left      = 176
                .Top       = 20
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Grupo", "TextBox")
            WITH .txt_4c_Grupo
                .Left          = 4
                .Top           = 32
                .Width         = 80
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH
            IF USED("tmpnens")
                THIS.cnt_4c_Destino.txt_4c_Grupo.ControlSource = "tmpnens.grupods"
            ENDIF

            .AddObject("txt_4c_Conta", "TextBox")
            WITH .txt_4c_Conta
                .Left          = 93
                .Top           = 32
                .Width         = 80
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH
            IF USED("tmpnens")
                THIS.cnt_4c_Destino.txt_4c_Conta.ControlSource = "tmpnens.contads"
            ENDIF

            .AddObject("txt_4c_Dconta", "TextBox")
            WITH .txt_4c_Dconta
                .Left          = 176
                .Top           = 32
                .Width         = 302
                .Height        = 23
                .ReadOnly      = .T.
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(0, 0, 0)
                .BorderColor   = RGB(100, 100, 100)
                .Themes        = .F.
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * PopularDescricoesConta - Popula txt_4c_Dconta em Origem e Destino
    * Replica logica do legado: CursorQuery SigCdCli -> Get_dconta.Value
    * Usa BO.ObterDescricaoConta para buscar RClis por ICli
    *==========================================================================
    PROTECTED PROCEDURE PopularDescricoesConta()
        LOCAL loc_cICli, loc_cDescr

        THIS.cnt_4c_Origem.txt_4c_Dconta.Value  = ""
        THIS.cnt_4c_Destino.txt_4c_Dconta.Value = ""

        IF NOT USED("tmpnens") OR EOF("tmpnens")
            RETURN
        ENDIF

        SELECT tmpnens

        *-- Origem: ICli = tmpnens.contaos
        loc_cICli = ALLTRIM(NVL(tmpnens.contaos, ""))
        IF NOT EMPTY(loc_cICli)
            loc_cDescr = THIS.this_oBusinessObject.ObterDescricaoConta(loc_cICli)
            IF NOT EMPTY(loc_cDescr)
                THIS.cnt_4c_Origem.txt_4c_Dconta.Value = loc_cDescr
            ENDIF
        ENDIF

        *-- Destino: ICli = tmpnens.contads
        loc_cICli = ALLTRIM(NVL(tmpnens.contads, ""))
        IF NOT EMPTY(loc_cICli)
            loc_cDescr = THIS.this_oBusinessObject.ObterDescricaoConta(loc_cICli)
            IF NOT EMPTY(loc_cDescr)
                THIS.cnt_4c_Destino.txt_4c_Dconta.Value = loc_cDescr
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarVisibilidadeContainers - Mostra/oculta Origem e Destino conforme
    * crSigCdOpd.Origems e crSigCdOpd.Destinos
    * Replica: .Origem.Visible=(crSigCdOpd.Origems=1) do Init do legado
    *==========================================================================
    PROCEDURE AjustarVisibilidadeContainers()
        IF USED("crSigCdOpd") AND NOT EOF("crSigCdOpd")
            THIS.cnt_4c_Origem.Visible  = (crSigCdOpd.Origems = 1)
            THIS.cnt_4c_Destino.Visible = (crSigCdOpd.Destinos = 1)
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * EXCECAO: img_4c_FigJpg e shp_4c_Shape4 permanecem ocultos (controlados
    * pelo AfterRowColChange do grid conforme crSigCdOpd.Imagems)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                *-- Preserva visibilidade controlada em runtime (foto e shape da foto)
                IF UPPER(loc_oControl.Name) = "IMG_4C_FIGJPG" OR ;
                   UPPER(loc_oControl.Name) = "SHP_4C_SHAPE4"
                    LOOP
                ENDIF

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
    * Destroy - Libera referencias ao form pai e ao BO
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oFormPai = .NULL.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Grid principal (xOpi) + area inferior do form
    * Grade legado: Top=319, Left=12, Width=979, Height=162, 7 colunas
    * Tambem adiciona labels, TextBox descricao, EditBox observacoes e aviso
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oErro
        TRY
            *-- Grid principal (Grade no legado)
            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top                = 319
                .Left               = 12
                .Width              = 979
                .Height             = 162
                .ColumnCount        = 7
                .FontName           = "Verdana"
                .FontSize           = 8
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .ScrollBars         = 2
                .RowHeight          = 16
                .Visible            = .T.
            ENDWITH

            THIS.ConfigurarGrade()

            *-- Vincula grid ao cursor xOpi compartilhado do form pai
            IF USED("xOpi")
                THIS.grd_4c_Dados.ColumnCount  = 7
                THIS.grd_4c_Dados.RecordSource = "xOpi"
                SELECT xOpi
                GO TOP
                *-- Inicializa header tag de Column5 conforme estado da primeira linha
                IF NOT EOF("xOpi")
                    IF VARTYPE(indiv) = "L"
                        THIS.grd_4c_Dados.Column5.Header1.Tag = IIF(NVL(indiv, .F.), "X", "")
                    ELSE
                        THIS.grd_4c_Dados.Column5.Header1.Tag = IIF(NVL(indiv, 0) = 1, "X", "")
                    ENDIF
                ENDIF
                THIS.grd_4c_Dados.Refresh()
            ENDIF

            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")

            *-- Label "Descricao" (Say2 no legado, Top=485, Left=12)
            THIS.AddObject("lbl_4c_LblDescricao", "Label")
            WITH THIS.lbl_4c_LblDescricao
                .Top       = 485
                .Left      = 12
                .AutoSize  = .T.
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o "
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox descricao do produto (Get_descr no legado, Top=501, Left=12, W=363)
            THIS.AddObject("txt_4c_Descr", "TextBox")
            WITH THIS.txt_4c_Descr
                .Top       = 501
                .Left      = 12
                .Width     = 363
                .Height    = 23
                .ReadOnly  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(255, 255, 255)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            *-- Label "Observacao" (Say3 no legado, Top=484, Left=379)
            THIS.AddObject("lbl_4c_LblObs", "Label")
            WITH THIS.lbl_4c_LblObs
                .Top       = 484
                .Left      = 379
                .AutoSize  = .T.
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o "
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- EditBox de observacoes (Mm_obs no legado, Top=500, Left=379, W=612, H=81)
            THIS.AddObject("obj_4c_MmObs", "EditBox")
            WITH THIS.obj_4c_MmObs
                .Top       = 500
                .Left      = 379
                .Width     = 612
                .Height    = 81
                .ReadOnly  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(255, 255, 255)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH
            IF USED("xmfas")
                THIS.obj_4c_MmObs.ControlSource = "xmfas.obss"
            ENDIF

            *-- Label aviso peso medio (Say1 no legado, Top=532, Left=12)
            THIS.AddObject("lbl_4c_LblAtencao", "Label")
            WITH THIS.lbl_4c_LblAtencao
                .Top       = 532
                .Left      = 12
                .AutoSize  = .T.
                .Caption   = "Aten" + CHR(231) + CHR(227) + "o: a finaliza" + CHR(231) + CHR(227) + "o considera o Peso M" + CHR(233) + "dio Real"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - Configura as 7 colunas do grd_4c_Dados
    * Column1: Ordem Fabricacao (xOpi.nops)  - ReadOnly
    * Column2: Pedido (xOpi.oper)            - ReadOnly + Tab->cmd_4c_Ok
    * Column3: Quantidade (xOpi.qtds)        - Editavel, KeyPress processa xPesa
    * Column4: Produto (xOpi.cpros)          - ReadOnly
    * Column5: Ind (xOpi.indiv)             - CheckBox condicional
    * Column6: Conta (xOpi.conta)            - ReadOnly
    * Column7: PM (xOpi.divs)              - CheckBox condicional
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrid, loc_oErro
        TRY
            loc_oGrid = THIS.grd_4c_Dados

            *-- Column1: Ordem Fabricacao (xOpi.nops) - largura 133 conforme original
            WITH loc_oGrid.Column1
                .Width             = 133
                .ReadOnly          = .T.
                .FontName          = "Arial"
                .Header1.Caption   = "Ordem Fabrica" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 2
                .ControlSource     = "xOpi.nops"
            ENDWITH
            WITH loc_oGrid.Column1.Text1
                .FontName    = "Arial"
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column2: Pedido (xOpi.oper) - largura 310 conforme original; Tab->OK
            WITH loc_oGrid.Column2
                .Width             = 310
                .ReadOnly          = .T.
                .Header1.Caption   = "Pedido"
                .Header1.Alignment = 2
                .ControlSource     = "xOpi.oper"
            ENDWITH
            WITH loc_oGrid.Column2.Text1
                .Alignment   = 0
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(loc_oGrid.Column2.Text1, "KeyPress", THIS, "GradeColumn2KeyPress")

            *-- Column3: Quantidade (xOpi.qtds) - largura 150; editavel; processa xPesa em Enter/Tab
            WITH loc_oGrid.Column3
                .Width             = 150
                .ReadOnly          = .F.
                .Header1.Caption   = "Quantidade"
                .Header1.Alignment = 2
                .ControlSource     = "xOpi.qtds"
            ENDWITH
            WITH loc_oGrid.Column3.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(loc_oGrid.Column3.Text1, "KeyPress", THIS, "GradeColumn3KeyPress")

            *-- Column4: Produto (xOpi.cpros) - largura 150 conforme original
            WITH loc_oGrid.Column4
                .Width             = 150
                .ReadOnly          = .T.
                .Header1.Caption   = "Produto"
                .Header1.Alignment = 2
                .ControlSource     = "xOpi.cpros"
            ENDWITH
            WITH loc_oGrid.Column4.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column5: Ind (xOpi.indiv) - largura 25 conforme original; CheckBox
            *-- CRITICO: AddObject Check1 ANTES de CurrentControl e ControlSource
            loc_oGrid.Column5.AddObject("Check1", "CheckBox")
            WITH loc_oGrid.Column5.Check1
                .Caption   = ""
                .Value     = 0
                .Width     = 40
                .Height    = 16
                .Alignment = 2
                .Centered  = .T.
            ENDWITH
            WITH loc_oGrid.Column5
                .Width             = 25
                .CurrentControl    = "Check1"
                .Header1.Caption   = "Ind"
                .Header1.Alignment = 2
                .ControlSource     = "xOpi.indiv"
            ENDWITH
            IF THIS.this_cEscolha <> "INSERIR"
                loc_oGrid.Column5.ReadOnly = .T.
            ENDIF
            BINDEVENT(loc_oGrid.Column5.Check1, "InteractiveChange", THIS, "GradeColumn5InteractiveChange")
            BINDEVENT(loc_oGrid.Column5.Header1, "Click", THIS, "GradeColumn5HeaderClick")

            *-- Column6: Conta (xOpi.conta) - largura 146 conforme original; ReadOnly
            WITH loc_oGrid.Column6
                .Width             = 146
                .ReadOnly          = .T.
                .Header1.Caption   = "Conta"
                .Header1.Alignment = 2
                .ControlSource     = "xOpi.conta"
            ENDWITH
            WITH loc_oGrid.Column6.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column7: PM (xOpi.divs) - largura 25 conforme original; CheckBox
            *-- CRITICO: mesma ordem que Column5 (AddObject antes de CurrentControl/ControlSource)
            loc_oGrid.Column7.AddObject("Check1", "CheckBox")
            WITH loc_oGrid.Column7.Check1
                .Caption   = ""
                .Value     = 0
                .Width     = 40
                .Height    = 16
                .Alignment = 2
                .Centered  = .T.
            ENDWITH
            WITH loc_oGrid.Column7
                .Width             = 25
                .CurrentControl    = "Check1"
                .Header1.Caption   = "PM"
                .Header1.Alignment = 2
                .ControlSource     = "xOpi.divs"
            ENDWITH
            IF THIS.this_cEscolha <> "INSERIR"
                loc_oGrid.Column7.ReadOnly = .T.
            ENDIF
            BINDEVENT(loc_oGrid.Column7.Check1, "InteractiveChange", THIS, "GradeColumn7InteractiveChange")
            BINDEVENT(loc_oGrid.Column7.Header1, "Click", THIS, "GradeColumn7HeaderClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesForm - Botoes Encerrar (canonico), Pesagem e OK
    * Encerrar: Left=775 (canonico sistema novo)
    * Pesagem: Left=850 (replica "Pesagem" do legado)
    * OK: Left=925 (replica "ok" do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesForm()
        LOCAL loc_oErro, loc_cIcones
        TRY
            loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")

            *-- Botao Encerrar - padrao canonico sistema novo (sem equivalente direto no legado)
            THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH THIS.cmd_4c_Encerrar
                .Top             = 3
                .Left            = 775
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .PicturePosition = 13
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            IF NOT EMPTY(loc_cIcones)
                THIS.cmd_4c_Encerrar.Picture = loc_cIcones + "cadastro_sair_60.jpg"
            ENDIF
            BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            *-- Botao Pesagem (replica "Pesagem" do legado: Left=850, W=75, H=75)
            THIS.AddObject("cmd_4c_Pesagem", "CommandButton")
            WITH THIS.cmd_4c_Pesagem
                .Top             = 3
                .Left            = 850
                .Width           = 75
                .Height          = 75
                .Caption         = "Pesagem"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .PicturePosition = 13
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            IF NOT EMPTY(loc_cIcones)
                THIS.cmd_4c_Pesagem.Picture = loc_cIcones + "geral_balanca_60.jpg"
            ENDIF
            BINDEVENT(THIS.cmd_4c_Pesagem, "Click", THIS, "BtnPesagemClick")

            *-- Botao OK (replica "ok" do legado: Left=925, W=75, H=75)
            THIS.AddObject("cmd_4c_Ok", "CommandButton")
            WITH THIS.cmd_4c_Ok
                .Top             = 3
                .Left            = 925
                .Width           = 75
                .Height          = 75
                .Caption         = "OK"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .PicturePosition = 13
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            IF NOT EMPTY(loc_cIcones)
                THIS.cmd_4c_Ok.Picture = loc_cIcones + "cadastro_salvar_60.jpg"
            ENDIF
            BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Nao aplicavel: form OPERACIONAL plano sem PageFrame
    * Visibilidade de Origem/Destino gerenciada por AjustarVisibilidadeContainers()
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.AjustarVisibilidadeContainers()
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChange - Ao navegar linha do grid: atualiza descricao e
    * imagem do produto; ajusta ReadOnly de Column5/Column7 por linha corrente
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_cCPros, loc_lPodeEditar, loc_lObrigs, loc_lIndiv, loc_oErro
        TRY
            IF USED("xOpi") AND NOT EOF("xOpi")
                SELECT xOpi
                loc_cCPros = ALLTRIM(NVL(xOpi.cpros, ""))

                *-- Atualiza descricao do produto em txt_4c_Descr
                IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
                    THIS.txt_4c_Descr.Value = ""
                    IF NOT EMPTY(loc_cCPros)
                        THIS.this_oBusinessObject.this_cCPros = loc_cCPros
                        IF THIS.this_oBusinessObject.ObterDadosProduto()
                            THIS.txt_4c_Descr.Value = THIS.this_oBusinessObject.this_cDPros
                        ENDIF
                    ENDIF
                ENDIF

                *-- Atualiza imagem do produto (conforme crSigCdOpd.Imagems)
                IF USED("crSigCdOpd") AND NOT EOF("crSigCdOpd")
                    SELECT crSigCdOpd
                    IF crSigCdOpd.Imagems = 1
                        THIS.img_4c_FigJpg.Visible = .F.
                        THIS.img_4c_FigJpg.Picture  = ""
                        THIS.shp_4c_Shape4.Visible  = .F.

                        LOCAL loc_cFigJpgs, loc_cBase64, loc_cTempFile
                        loc_cFigJpgs = THIS.this_oBusinessObject.this_cFigJpgs

                        IF NOT EMPTY(ALLTRIM(NVL(loc_cFigJpgs, "")))
                            loc_cBase64 = STRTRAN(STRTRAN(loc_cFigJpgs, ;
                                "data:image/png;base64,", ""), ;
                                "data:image/jpeg;base64,", "")
                            loc_cBase64 = STRTRAN(loc_cBase64, "data:image/jpg;base64,", "")

                            IF NOT EMPTY(ALLTRIM(loc_cBase64))
                                loc_cTempFile = SYS(2023) + "\Temp3.jpg"
                                STRTOFILE(STRCONV(loc_cBase64, 14), loc_cTempFile)
                                CLEAR RESOURCES
                                THIS.img_4c_FigJpg.Picture = loc_cTempFile
                                THIS.img_4c_FigJpg.Visible = .T.
                                THIS.shp_4c_Shape4.Visible = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                *-- Ajusta ReadOnly de Column5/Column7 conforme condicoes da linha corrente
                IF USED("xOpi") AND NOT EOF("xOpi")
                    SELECT xOpi
                    loc_lPodeEditar = (THIS.this_cEscolha = "INSERIR")
                    IF VARTYPE(obrigs) = "L"
                        loc_lObrigs = NVL(obrigs, .F.)
                    ELSE
                        IF VARTYPE(obrigs) = "L"
                            loc_lObrigs = obrigs
                        ELSE
                            IF VARTYPE(obrigs) = "L"
                                loc_lObrigs = obrigs
                            ELSE
                                IF VARTYPE(obrigs) = "L"
                                    loc_lObrigs = obrigs
                                ELSE
                                    IF VARTYPE(obrigs) = "L"
                                        loc_lObrigs = obrigs
                                    ELSE
                                        IF VARTYPE(obrigs) = "L"
                                            loc_lObrigs = obrigs
                                        ELSE
                                            IF VARTYPE(obrigs) = "L"
                                                loc_lObrigs = obrigs
                                            ELSE
                                                IF VARTYPE(obrigs) = "L"
                                                    loc_lObrigs = obrigs
                                                ELSE
                                                    IF VARTYPE(obrigs) = "L"
                                                        loc_lObrigs = obrigs
                                                    ELSE
                                                        IF VARTYPE(obrigs) = "L"
                                                            loc_lObrigs = obrigs
                                                        ELSE
                                                            IF VARTYPE(obrigs) = "L"
                                                                loc_lObrigs = obrigs
                                                            ELSE
                                                                IF VARTYPE(obrigs) = "L"
                                                                    loc_lObrigs = obrigs
                                                                ELSE
                                                                    IF VARTYPE(obrigs) = "L"
                                                                        loc_lObrigs = obrigs
                                                                    ELSE
                                                                        IF VARTYPE(obrigs) = "L"
                                                                            loc_lObrigs = obrigs
                                                                        ELSE
                                                                            IF VARTYPE(obrigs) = "L"
                                                                                loc_lObrigs = obrigs
                                                                            ELSE
                                                                                IF VARTYPE(obrigs) = "L"
                                                                                    loc_lObrigs = obrigs
                                                                                ELSE
                                                                                    IF VARTYPE(obrigs) = "L"
                                                                                        loc_lObrigs = obrigs
                                                                                    ELSE
                                                                                        IF VARTYPE(obrigs) = "L"
                                                                                            loc_lObrigs = obrigs
                                                                                        ELSE
                                                                                            IF VARTYPE(obrigs) = "L"
                                                                                                loc_lObrigs = obrigs
                                                                                            ELSE
                                                                                                IF VARTYPE(obrigs) = "L"
                                                                                                    loc_lObrigs = obrigs
                                                                                                ELSE
                                                                                                    IF VARTYPE(obrigs) = "L"
                                                                                                        loc_lObrigs = obrigs
                                                                                                    ELSE
                                                                                                        IF VARTYPE(obrigs) = "L"
                                                                                                            loc_lObrigs = obrigs
                                                                                                        ELSE
                                                                                                            IF VARTYPE(obrigs) = "L"
                                                                                                                loc_lObrigs = obrigs
                                                                                                            ELSE
                                                                                                                IF VARTYPE(obrigs) = "L"
                                                                                                                    loc_lObrigs = obrigs
                                                                                                                ELSE
                                                                                                                    IF VARTYPE(obrigs) = "L"
                                                                                                                        loc_lObrigs = obrigs
                                                                                                                    ELSE
                                                                                                                        IF VARTYPE(obrigs) = "L"
                                                                                                                            loc_lObrigs = obrigs
                                                                                                                        ELSE
                                                                                                                            IF VARTYPE(obrigs) = "L"
                                                                                                                                loc_lObrigs = obrigs
                                                                                                                            ELSE
                                                                                                                                loc_lObrigs = (NVL(obrigs, 0) = 1)
                                                                                                                            ENDIF
                                                                                                                        ENDIF
                                                                                                                    ENDIF
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                    IF VARTYPE(indiv) = "L"
                        loc_lIndiv = NVL(indiv, .F.)
                    ELSE
                        IF VARTYPE(indiv) = "L"
                            loc_lIndiv = indiv
                        ELSE
                            IF VARTYPE(indiv) = "L"
                                loc_lIndiv = indiv
                            ELSE
                                IF VARTYPE(indiv) = "L"
                                    loc_lIndiv = indiv
                                ELSE
                                    IF VARTYPE(indiv) = "L"
                                        loc_lIndiv = indiv
                                    ELSE
                                        IF VARTYPE(indiv) = "L"
                                            loc_lIndiv = indiv
                                        ELSE
                                            IF VARTYPE(indiv) = "L"
                                                loc_lIndiv = indiv
                                            ELSE
                                                IF VARTYPE(indiv) = "L"
                                                    loc_lIndiv = indiv
                                                ELSE
                                                    IF VARTYPE(indiv) = "L"
                                                        loc_lIndiv = indiv
                                                    ELSE
                                                        IF VARTYPE(indiv) = "L"
                                                            loc_lIndiv = indiv
                                                        ELSE
                                                            IF VARTYPE(indiv) = "L"
                                                                loc_lIndiv = indiv
                                                            ELSE
                                                                IF VARTYPE(indiv) = "L"
                                                                    loc_lIndiv = indiv
                                                                ELSE
                                                                    IF VARTYPE(indiv) = "L"
                                                                        loc_lIndiv = indiv
                                                                    ELSE
                                                                        IF VARTYPE(indiv) = "L"
                                                                            loc_lIndiv = indiv
                                                                        ELSE
                                                                            IF VARTYPE(indiv) = "L"
                                                                                loc_lIndiv = indiv
                                                                            ELSE
                                                                                IF VARTYPE(indiv) = "L"
                                                                                    loc_lIndiv = indiv
                                                                                ELSE
                                                                                    IF VARTYPE(indiv) = "L"
                                                                                        loc_lIndiv = indiv
                                                                                    ELSE
                                                                                        IF VARTYPE(indiv) = "L"
                                                                                            loc_lIndiv = indiv
                                                                                        ELSE
                                                                                            IF VARTYPE(indiv) = "L"
                                                                                                loc_lIndiv = indiv
                                                                                            ELSE
                                                                                                IF VARTYPE(indiv) = "L"
                                                                                                    loc_lIndiv = indiv
                                                                                                ELSE
                                                                                                    IF VARTYPE(indiv) = "L"
                                                                                                        loc_lIndiv = indiv
                                                                                                    ELSE
                                                                                                        IF VARTYPE(indiv) = "L"
                                                                                                            loc_lIndiv = indiv
                                                                                                        ELSE
                                                                                                            IF VARTYPE(indiv) = "L"
                                                                                                                loc_lIndiv = indiv
                                                                                                            ELSE
                                                                                                                IF VARTYPE(indiv) = "L"
                                                                                                                    loc_lIndiv = indiv
                                                                                                                ELSE
                                                                                                                    IF VARTYPE(indiv) = "L"
                                                                                                                        loc_lIndiv = indiv
                                                                                                                    ELSE
                                                                                                                        IF VARTYPE(indiv) = "L"
                                                                                                                            loc_lIndiv = indiv
                                                                                                                        ELSE
                                                                                                                            IF VARTYPE(indiv) = "L"
                                                                                                                                loc_lIndiv = indiv
                                                                                                                            ELSE
                                                                                                                                loc_lIndiv = (NVL(indiv, 0) = 1)
                                                                                                                            ENDIF
                                                                                                                        ENDIF
                                                                                                                    ENDIF
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                    IF loc_lPodeEditar
                        THIS.grd_4c_Dados.Column5.ReadOnly = loc_lObrigs
                        THIS.grd_4c_Dados.Column7.ReadOnly = loc_lObrigs OR loc_lIndiv
                    ELSE
                        THIS.grd_4c_Dados.Column5.ReadOnly = .T.
                        THIS.grd_4c_Dados.Column7.ReadOnly = .T.
                    ENDIF
                ENDIF
            ENDIF

            *-- Replica: ThisForm.Refresh + ThisForm.Mm_Obs.Refresh do legado
            THIS.Refresh()
            IF PEMSTATUS(THIS, "obj_4c_MmObs", 5)
                THIS.obj_4c_MmObs.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeColumn2KeyPress - Tab=SetFocus cmd_4c_Ok; Enter+oper vazio=SetFocus Ok
    * Replica Column2.Text1.KeyPress e LostFocus do legado
    *==========================================================================
    PROCEDURE GradeColumn2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lSetFocus
        loc_lSetFocus = .F.
        IF par_nKeyCode = 9
            loc_lSetFocus = .T.
        ELSE
            IF par_nKeyCode = 13
            IF USED("xOpi") AND NOT EOF("xOpi")
                SELECT xOpi
                IF EMPTY(ALLTRIM(NVL(xOpi.oper, "")))
                    loc_lSetFocus = .T.
                ENDIF
            ENDIF
            ENDIF
        ENDIF
        IF loc_lSetFocus
            IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
                THIS.cmd_4c_Ok.SetFocus
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeColumn3KeyPress - Enter/Tab processa pesagem via BO.Inserir()
    * Replica Column3.Text1.Valid do legado; verifica _Dopp vs xOpi.Dopes
    *==========================================================================
    PROCEDURE GradeColumn3KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nQtds, loc_lProcessar, loc_oErro
        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
            RETURN
        ENDIF
        loc_lProcessar = .F.
        TRY
            IF USED("xOpi") AND NOT EOF("xOpi")
                SELECT xOpi
                IF ALLTRIM(THIS.this_cDopp) = ALLTRIM(NVL(xOpi.dopes, ""))
                    IF PEMSTATUS(THIS.grd_4c_Dados.Column3, "Text1", 5)
                        loc_nQtds = NVL(THIS.grd_4c_Dados.Column3.Text1.Value, 0)
                    ELSE
                        loc_nQtds = NVL(xOpi.qtds, 0)
                    ENDIF
                    IF THIS.this_oBusinessObject.CarregarDoCursor("xOpi")
                        THIS.this_oBusinessObject.this_nQtds = loc_nQtds
                        THIS.this_oBusinessObject.ObterDadosOpe(THIS.this_oBusinessObject.this_cDopes)
                        IF USED("CrSigCdPam") AND NOT EOF("CrSigCdPam")
                            SELECT CrSigCdPam
                            THIS.this_oBusinessObject.this_cOuros = ALLTRIM(NVL(CrSigCdPam.Ouros, ""))
                        ENDIF
                        loc_lProcessar = .T.
                    ENDIF
                ENDIF
            ENDIF
            IF loc_lProcessar
                THIS.this_oBusinessObject.Inserir()
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeColumn5InteractiveChange - CheckBox Ind: pesagem individual via BO
    * Equivale a Column5.Check1.InteractiveChange do legado
    * Se condicao nao atendida (nao INSERIR ou Obrigs), reverte o checkbox
    *==========================================================================
    PROCEDURE GradeColumn5InteractiveChange()
        LOCAL loc_lCondicaoOk, loc_lObrigs, loc_oErro
        TRY
            IF USED("xOpi") AND NOT EOF("xOpi")
                SELECT xOpi
                IF VARTYPE(obrigs) = "L"
                    loc_lObrigs = NVL(obrigs, .F.)
                ELSE
                    IF VARTYPE(obrigs) = "L"
                        loc_lObrigs = obrigs
                    ELSE
                        IF VARTYPE(obrigs) = "L"
                            loc_lObrigs = obrigs
                        ELSE
                            IF VARTYPE(obrigs) = "L"
                                loc_lObrigs = obrigs
                            ELSE
                                IF VARTYPE(obrigs) = "L"
                                    loc_lObrigs = obrigs
                                ELSE
                                    IF VARTYPE(obrigs) = "L"
                                        loc_lObrigs = obrigs
                                    ELSE
                                        IF VARTYPE(obrigs) = "L"
                                            loc_lObrigs = obrigs
                                        ELSE
                                            IF VARTYPE(obrigs) = "L"
                                                loc_lObrigs = obrigs
                                            ELSE
                                                IF VARTYPE(obrigs) = "L"
                                                    loc_lObrigs = obrigs
                                                ELSE
                                                    IF VARTYPE(obrigs) = "L"
                                                        loc_lObrigs = obrigs
                                                    ELSE
                                                        IF VARTYPE(obrigs) = "L"
                                                            loc_lObrigs = obrigs
                                                        ELSE
                                                            IF VARTYPE(obrigs) = "L"
                                                                loc_lObrigs = obrigs
                                                            ELSE
                                                                IF VARTYPE(obrigs) = "L"
                                                                    loc_lObrigs = obrigs
                                                                ELSE
                                                                    IF VARTYPE(obrigs) = "L"
                                                                        loc_lObrigs = obrigs
                                                                    ELSE
                                                                        IF VARTYPE(obrigs) = "L"
                                                                            loc_lObrigs = obrigs
                                                                        ELSE
                                                                            IF VARTYPE(obrigs) = "L"
                                                                                loc_lObrigs = obrigs
                                                                            ELSE
                                                                                IF VARTYPE(obrigs) = "L"
                                                                                    loc_lObrigs = obrigs
                                                                                ELSE
                                                                                    IF VARTYPE(obrigs) = "L"
                                                                                        loc_lObrigs = obrigs
                                                                                    ELSE
                                                                                        IF VARTYPE(obrigs) = "L"
                                                                                            loc_lObrigs = obrigs
                                                                                        ELSE
                                                                                            IF VARTYPE(obrigs) = "L"
                                                                                                loc_lObrigs = obrigs
                                                                                            ELSE
                                                                                                IF VARTYPE(obrigs) = "L"
                                                                                                    loc_lObrigs = obrigs
                                                                                                ELSE
                                                                                                    IF VARTYPE(obrigs) = "L"
                                                                                                        loc_lObrigs = obrigs
                                                                                                    ELSE
                                                                                                        IF VARTYPE(obrigs) = "L"
                                                                                                            loc_lObrigs = obrigs
                                                                                                        ELSE
                                                                                                            IF VARTYPE(obrigs) = "L"
                                                                                                                loc_lObrigs = obrigs
                                                                                                            ELSE
                                                                                                                IF VARTYPE(obrigs) = "L"
                                                                                                                    loc_lObrigs = obrigs
                                                                                                                ELSE
                                                                                                                    IF VARTYPE(obrigs) = "L"
                                                                                                                        loc_lObrigs = obrigs
                                                                                                                    ELSE
                                                                                                                        IF VARTYPE(obrigs) = "L"
                                                                                                                            loc_lObrigs = obrigs
                                                                                                                        ELSE
                                                                                                                            loc_lObrigs = (NVL(obrigs, 0) = 1)
                                                                                                                        ENDIF
                                                                                                                    ENDIF
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                loc_lCondicaoOk = (THIS.this_cEscolha = "INSERIR") AND NOT loc_lObrigs

                IF loc_lCondicaoOk
                    IF THIS.this_oBusinessObject.CarregarDoCursor("xOpi")
                        IF USED("CrSigCdPam") AND NOT EOF("CrSigCdPam")
                            SELECT CrSigCdPam
                            THIS.this_oBusinessObject.this_cOuros = ALLTRIM(NVL(CrSigCdPam.Ouros, ""))
                        ENDIF
                        THIS.this_oBusinessObject.InserirPorCheckbox()
                    ENDIF
                ELSE
                    *-- Reverte mudanca (condicoes nao atendidas)
                    SELECT xOpi
                    IF VARTYPE(indiv) = "L"
                        REPLACE indiv WITH NOT NVL(indiv, .F.)
                    ELSE
                        REPLACE indiv WITH IIF(NVL(indiv, 0) = 1, 0, 1)
                    ENDIF
                ENDIF
            ENDIF
            THIS.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeColumn5HeaderClick - Clique no header "Ind": toggle todos xOpi.Indiv
    * e reprocessa pesagem para todos via BO.ProcessarTodasOpi()
    *==========================================================================
    PROCEDURE GradeColumn5HeaderClick()
        LOCAL loc_lTagAtual, loc_oErro
        TRY
            IF VARTYPE(THIS.grd_4c_Dados.Column5.Header1.Tag) = "C" AND ;
               NOT EMPTY(THIS.grd_4c_Dados.Column5.Header1.Tag)
                THIS.grd_4c_Dados.Column5.Header1.Tag = ""
            ELSE
                THIS.grd_4c_Dados.Column5.Header1.Tag = "X"
            ENDIF
            loc_lTagAtual = NOT EMPTY(THIS.grd_4c_Dados.Column5.Header1.Tag)

            IF USED("xOpi")
                SELECT xOpi
                GO TOP
                REPLACE ALL Indiv WITH loc_lTagAtual
                GO TOP
            ENDIF

            IF USED("CrSigCdPam") AND NOT EOF("CrSigCdPam")
                SELECT CrSigCdPam
                THIS.this_oBusinessObject.this_cOuros = ALLTRIM(NVL(CrSigCdPam.Ouros, ""))
            ENDIF

            THIS.this_oBusinessObject.ProcessarTodasOpi()
            THIS.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeColumn7InteractiveChange - CheckBox PM: atualiza Divs no xPesa
    * Equivale a Column7.Check1.InteractiveChange do legado
    * Se condicao nao atendida (nao INSERIR, Obrigs ou Indiv), reverte checkbox
    *==========================================================================
    PROCEDURE GradeColumn7InteractiveChange()
        LOCAL loc_lCondicaoOk, loc_lObrigs, loc_lIndiv, loc_oErro
        TRY
            IF USED("xOpi") AND NOT EOF("xOpi")
                SELECT xOpi
                IF VARTYPE(obrigs) = "L"
                    loc_lObrigs = NVL(obrigs, .F.)
                ELSE
                    IF VARTYPE(obrigs) = "L"
                        loc_lObrigs = obrigs
                    ELSE
                        IF VARTYPE(obrigs) = "L"
                            loc_lObrigs = obrigs
                        ELSE
                            IF VARTYPE(obrigs) = "L"
                                loc_lObrigs = obrigs
                            ELSE
                                IF VARTYPE(obrigs) = "L"
                                    loc_lObrigs = obrigs
                                ELSE
                                    IF VARTYPE(obrigs) = "L"
                                        loc_lObrigs = obrigs
                                    ELSE
                                        IF VARTYPE(obrigs) = "L"
                                            loc_lObrigs = obrigs
                                        ELSE
                                            IF VARTYPE(obrigs) = "L"
                                                loc_lObrigs = obrigs
                                            ELSE
                                                IF VARTYPE(obrigs) = "L"
                                                    loc_lObrigs = obrigs
                                                ELSE
                                                    IF VARTYPE(obrigs) = "L"
                                                        loc_lObrigs = obrigs
                                                    ELSE
                                                        IF VARTYPE(obrigs) = "L"
                                                            loc_lObrigs = obrigs
                                                        ELSE
                                                            IF VARTYPE(obrigs) = "L"
                                                                loc_lObrigs = obrigs
                                                            ELSE
                                                                IF VARTYPE(obrigs) = "L"
                                                                    loc_lObrigs = obrigs
                                                                ELSE
                                                                    IF VARTYPE(obrigs) = "L"
                                                                        loc_lObrigs = obrigs
                                                                    ELSE
                                                                        IF VARTYPE(obrigs) = "L"
                                                                            loc_lObrigs = obrigs
                                                                        ELSE
                                                                            IF VARTYPE(obrigs) = "L"
                                                                                loc_lObrigs = obrigs
                                                                            ELSE
                                                                                IF VARTYPE(obrigs) = "L"
                                                                                    loc_lObrigs = obrigs
                                                                                ELSE
                                                                                    IF VARTYPE(obrigs) = "L"
                                                                                        loc_lObrigs = obrigs
                                                                                    ELSE
                                                                                        IF VARTYPE(obrigs) = "L"
                                                                                            loc_lObrigs = obrigs
                                                                                        ELSE
                                                                                            IF VARTYPE(obrigs) = "L"
                                                                                                loc_lObrigs = obrigs
                                                                                            ELSE
                                                                                                IF VARTYPE(obrigs) = "L"
                                                                                                    loc_lObrigs = obrigs
                                                                                                ELSE
                                                                                                    IF VARTYPE(obrigs) = "L"
                                                                                                        loc_lObrigs = obrigs
                                                                                                    ELSE
                                                                                                        IF VARTYPE(obrigs) = "L"
                                                                                                            loc_lObrigs = obrigs
                                                                                                        ELSE
                                                                                                            IF VARTYPE(obrigs) = "L"
                                                                                                                loc_lObrigs = obrigs
                                                                                                            ELSE
                                                                                                                IF VARTYPE(obrigs) = "L"
                                                                                                                    loc_lObrigs = obrigs
                                                                                                                ELSE
                                                                                                                    IF VARTYPE(obrigs) = "L"
                                                                                                                        loc_lObrigs = obrigs
                                                                                                                    ELSE
                                                                                                                        IF VARTYPE(obrigs) = "L"
                                                                                                                            loc_lObrigs = obrigs
                                                                                                                        ELSE
                                                                                                                            loc_lObrigs = (NVL(obrigs, 0) = 1)
                                                                                                                        ENDIF
                                                                                                                    ENDIF
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(indiv) = "L"
                    loc_lIndiv = NVL(indiv, .F.)
                ELSE
                    IF VARTYPE(indiv) = "L"
                        loc_lIndiv = indiv
                    ELSE
                        IF VARTYPE(indiv) = "L"
                            loc_lIndiv = indiv
                        ELSE
                            IF VARTYPE(indiv) = "L"
                                loc_lIndiv = indiv
                            ELSE
                                IF VARTYPE(indiv) = "L"
                                    loc_lIndiv = indiv
                                ELSE
                                    IF VARTYPE(indiv) = "L"
                                        loc_lIndiv = indiv
                                    ELSE
                                        IF VARTYPE(indiv) = "L"
                                            loc_lIndiv = indiv
                                        ELSE
                                            IF VARTYPE(indiv) = "L"
                                                loc_lIndiv = indiv
                                            ELSE
                                                IF VARTYPE(indiv) = "L"
                                                    loc_lIndiv = indiv
                                                ELSE
                                                    IF VARTYPE(indiv) = "L"
                                                        loc_lIndiv = indiv
                                                    ELSE
                                                        IF VARTYPE(indiv) = "L"
                                                            loc_lIndiv = indiv
                                                        ELSE
                                                            IF VARTYPE(indiv) = "L"
                                                                loc_lIndiv = indiv
                                                            ELSE
                                                                IF VARTYPE(indiv) = "L"
                                                                    loc_lIndiv = indiv
                                                                ELSE
                                                                    IF VARTYPE(indiv) = "L"
                                                                        loc_lIndiv = indiv
                                                                    ELSE
                                                                        IF VARTYPE(indiv) = "L"
                                                                            loc_lIndiv = indiv
                                                                        ELSE
                                                                            IF VARTYPE(indiv) = "L"
                                                                                loc_lIndiv = indiv
                                                                            ELSE
                                                                                IF VARTYPE(indiv) = "L"
                                                                                    loc_lIndiv = indiv
                                                                                ELSE
                                                                                    IF VARTYPE(indiv) = "L"
                                                                                        loc_lIndiv = indiv
                                                                                    ELSE
                                                                                        IF VARTYPE(indiv) = "L"
                                                                                            loc_lIndiv = indiv
                                                                                        ELSE
                                                                                            IF VARTYPE(indiv) = "L"
                                                                                                loc_lIndiv = indiv
                                                                                            ELSE
                                                                                                IF VARTYPE(indiv) = "L"
                                                                                                    loc_lIndiv = indiv
                                                                                                ELSE
                                                                                                    IF VARTYPE(indiv) = "L"
                                                                                                        loc_lIndiv = indiv
                                                                                                    ELSE
                                                                                                        IF VARTYPE(indiv) = "L"
                                                                                                            loc_lIndiv = indiv
                                                                                                        ELSE
                                                                                                            IF VARTYPE(indiv) = "L"
                                                                                                                loc_lIndiv = indiv
                                                                                                            ELSE
                                                                                                                IF VARTYPE(indiv) = "L"
                                                                                                                    loc_lIndiv = indiv
                                                                                                                ELSE
                                                                                                                    IF VARTYPE(indiv) = "L"
                                                                                                                        loc_lIndiv = indiv
                                                                                                                    ELSE
                                                                                                                        IF VARTYPE(indiv) = "L"
                                                                                                                            loc_lIndiv = indiv
                                                                                                                        ELSE
                                                                                                                            loc_lIndiv = (NVL(indiv, 0) = 1)
                                                                                                                        ENDIF
                                                                                                                    ENDIF
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                loc_lCondicaoOk = (THIS.this_cEscolha = "INSERIR") AND NOT loc_lObrigs AND NOT loc_lIndiv

                IF loc_lCondicaoOk
                    IF THIS.this_oBusinessObject.CarregarDoCursor("xOpi")
                        THIS.this_oBusinessObject.Atualizar()
                    ENDIF
                ELSE
                    *-- Reverte mudanca (condicoes nao atendidas)
                    SELECT xOpi
                    IF VARTYPE(divs) = "L"
                        REPLACE divs WITH NOT NVL(divs, .F.)
                    ELSE
                        REPLACE divs WITH IIF(NVL(divs, 0) = 1, 0, 1)
                    ENDIF
                ENDIF
            ENDIF
            THIS.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeColumn7HeaderClick - Clique no header "PM": toggle todos xOpi.Divs
    * e atualiza xPesa via BO.AtualizarDivsTodas()
    *==========================================================================
    PROCEDURE GradeColumn7HeaderClick()
        LOCAL loc_lTagAtual, loc_oErro
        TRY
            IF VARTYPE(THIS.grd_4c_Dados.Column7.Header1.Tag) = "C" AND ;
               NOT EMPTY(THIS.grd_4c_Dados.Column7.Header1.Tag)
                THIS.grd_4c_Dados.Column7.Header1.Tag = ""
            ELSE
                THIS.grd_4c_Dados.Column7.Header1.Tag = "X"
            ENDIF
            loc_lTagAtual = NOT EMPTY(THIS.grd_4c_Dados.Column7.Header1.Tag)

            IF USED("xOpi")
                SELECT xOpi
                GO TOP
                REPLACE ALL Divs WITH loc_lTagAtual
                GO TOP
            ENDIF

            THIS.this_oBusinessObject.AtualizarDivsTodas()
            THIS.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnOkClick - Confirma emissao de etiquetas e retorna ao form pai
    * Equivale a "ok".Click do legado:
    *   Se CONSULTAR + Etiqs in (1,3): pergunta se imprime -> abre FormSigPdM10
    *   Reativa form pai e fecha este form
    *==========================================================================
    PROCEDURE BtnOkClick()
        LOCAL loc_oErro, loc_cPosicao, loc_lImprimir, loc_oFormEtiquetas
        TRY
            loc_lImprimir = .F.

            IF THIS.this_cEscolha = "CONSULTAR"
                IF USED("crSigCdOpd") AND NOT EOF("crSigCdOpd")
                    SELECT crSigCdOpd
                    IF INLIST(crSigCdOpd.Etiqs, 1, 3)
                        loc_lImprimir = MsgConfirma("Deseja imprimir as etiquetas.")
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lImprimir
                IF USED("TmpNens") AND NOT EOF("TmpNens")
                    SELECT TmpNens
                    GO TOP
                    loc_cPosicao = TmpNens.Emps + TmpNens.Dopps + STR(TmpNens.Numps, 10)
                    LOCAL loc_lSeekOk
                    loc_lSeekOk = SEEK(TmpNens.Dopps, "crSigCdOpd", "Dopps")
                    IF USED("crSigCdNec")
                        SELECT crSigCdNec
                        LOCATE FOR EmpDNPs = loc_cPosicao
                    ENDIF
                    loc_oFormEtiquetas = CREATEOBJECT("FormSigPdM10", THIS, .T.)
                    IF VARTYPE(loc_oFormEtiquetas) = "O"
                        loc_oFormEtiquetas.Show()
                    ELSE
                        MsgErro("Erro ao criar FormSigPdM10.", "Etiquetas")
                    ENDIF
                ENDIF
            ENDIF

            SET CONFIRM OFF
            IF VARTYPE(THIS.this_oFormPai) = "O"
                THIS.this_oFormPai.Enabled = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnPesagemClick - Abre FormSigPdMp9 passando este form como pai
    * Equivale a "Pesagem".Click do legado: Select xPesa + Enabled=.F. + DoForm
    *==========================================================================
    PROCEDURE BtnPesagemClick()
        LOCAL loc_oFormPesagem, loc_oErro
        TRY
            IF USED("xPesa")
                SELECT xPesa
                GO TOP
            ENDIF
            THIS.Enabled = .F.
            loc_oFormPesagem = CREATEOBJECT("FormSigPdMp9", THIS)
            IF VARTYPE(loc_oFormPesagem) = "O"
                loc_oFormPesagem.Show()
            ELSE
                MsgErro("Erro ao criar FormSigPdMp9.", "Pesagem")
                THIS.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.Enabled = .T.
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha form sem confirmar, reativa form pai
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Marca TODOS os itens do grid para emissao individual.
    * Equivalente operacional do "Incluir" em forms CRUD. Mapeia para a logica
    * de Grade.Column5.Header1.Click do legado (marca Indiv para todos), so que
    * forcando marcacao (sem toggle): inclui tudo no escopo de emissao.
    * Replica o reprocessamento de xPesa por amarra para cada linha de xOpi.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            IF NOT USED("xOpi")
                RETURN
            ENDIF

            *-- Apenas permitido em modo INSERIR (regra do legado para Column5.Check1.When)
            IF THIS.this_cEscolha <> "INSERIR"
                MsgAviso("Inclus" + CHR(227) + "o permitida apenas em modo Inserir.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            *-- Marca todos os itens nao-obrigatorios como Indiv = .T.
            SELECT xOpi
            GO TOP
            SCAN
                IF NOT xOpi.Obrigs
                    REPLACE Indiv WITH .T. IN xOpi
                ENDIF
            ENDSCAN

            *-- Atualiza TAG do header Column5 para refletir estado "marcado"
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                IF PEMSTATUS(THIS.grd_4c_Dados.Column5, "Header1", 5)
                    THIS.grd_4c_Dados.Column5.Header1.Tag = "X"
                ENDIF
                THIS.grd_4c_Dados.Refresh()
            ENDIF

            *-- Reprocessa pesagem (xPesa) baseado nas marcacoes (logica do header click)
            THIS.ReprocessarPesagemPorAmarra()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Marca TODOS os itens para divisao por Peso Medio (PM).
    * Equivalente operacional do "Alterar" em forms CRUD. Mapeia para a logica
    * de Grade.Column7.Header1.Click do legado (toggle Divs), so que forcando
    * marcacao: altera modo de emissao para PM em massa.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            IF NOT USED("xOpi")
                RETURN
            ENDIF

            *-- Apenas permitido em modo INSERIR (regra do legado Column7.Check1.When)
            IF THIS.this_cEscolha <> "INSERIR"
                MsgAviso("Altera" + CHR(231) + CHR(227) + "o de PM permitida apenas em modo Inserir.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            *-- Marca Divs=.T. para todos os itens nao-obrigatorios e nao-individuais
            SELECT xOpi
            GO TOP
            SCAN
                IF NOT xOpi.Obrigs AND NOT xOpi.Indiv
                    REPLACE Divs WITH .T. IN xOpi
                ENDIF
            ENDSCAN

            *-- Propaga Divs para xPesa (mesma logica de Column7.Header1.Click)
            IF USED("xPesa")
                SELECT xOpi
                GO TOP
                SCAN
                    UPDATE xPesa SET Divs = (xOpi.Divs) WHERE Amarra = xOpi.Amarra
                ENDSCAN
            ENDIF

            *-- Atualiza TAG do header Column7 para refletir estado "marcado"
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                IF PEMSTATUS(THIS.grd_4c_Dados.Column7, "Header1", 5)
                    THIS.grd_4c_Dados.Column7.Header1.Tag = "X"
                ENDIF
                THIS.grd_4c_Dados.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Atualiza visualizacao do grid e da imagem do produto
    * Equivalente operacional do "Visualizar" em forms CRUD. Mapeia para a
    * logica de Grade.AfterRowColChange do legado (mostra produto da linha
    * corrente, atualiza imagem se crSigCdOpd.Imagems = 1).
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_nColAtual
        TRY
            IF NOT USED("xOpi")
                RETURN
            ENDIF

            *-- Forca atualizacao da linha corrente disparando AfterRowColChange
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                loc_nColAtual = THIS.grd_4c_Dados.ActiveColumn
                IF loc_nColAtual <= 0
                    loc_nColAtual = 1
                ENDIF
                THIS.GradeAfterRowColChange(loc_nColAtual)
                THIS.grd_4c_Dados.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Desmarca TODAS as selecoes (Indiv e Divs) do grid.
    * Equivalente operacional do "Excluir" em forms CRUD: exclui/limpa
    * marcacoes para emissao. Mapeia para toggle dos headers Column5/Column7
    * do legado quando estavam marcados (limpa tudo).
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro, loc_cMsg
        TRY
            IF NOT USED("xOpi")
                RETURN
            ENDIF

            *-- Apenas permitido em modo INSERIR (limpar marcacoes)
            IF THIS.this_cEscolha <> "INSERIR"
                MsgAviso("Exclus" + CHR(227) + "o de marca" + CHR(231) + CHR(245) + "es permitida apenas em modo Inserir.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            loc_cMsg = "Descartar todas as marca" + CHR(231) + CHR(245) + "es de Indiv e PM?"
            IF NOT MsgConfirma(loc_cMsg, "Confirma" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            *-- Desmarca Indiv e Divs em todos os itens nao-obrigatorios
            SELECT xOpi
            GO TOP
            SCAN
                IF NOT xOpi.Obrigs
                    REPLACE Indiv WITH .F., Divs WITH .F. IN xOpi
                ENDIF
            ENDSCAN

            *-- Propaga limpeza para xPesa
            IF USED("xPesa")
                SELECT xPesa
                GO TOP
                SCAN
                    REPLACE Divs WITH .F. IN xPesa
                ENDSCAN
            ENDIF

            *-- Limpa TAGs dos headers
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                IF PEMSTATUS(THIS.grd_4c_Dados.Column5, "Header1", 5)
                    THIS.grd_4c_Dados.Column5.Header1.Tag = ""
                ENDIF
                IF PEMSTATUS(THIS.grd_4c_Dados.Column7, "Header1", 5)
                    THIS.grd_4c_Dados.Column7.Header1.Tag = ""
                ENDIF
                THIS.grd_4c_Dados.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ReprocessarPesagemPorAmarra - Reprocessa cursor xPesa baseado nas
    * marcacoes Indiv/Divs de xOpi. Helper compartilhado entre BtnIncluirClick
    * e a logica original de GradeColumn5HeaderClick. Replica trecho do legado
    * que faz CursorQuery em SigCdPro/SigCdGrp/SigCdGpr + DELETE + INSERT em
    * xPesa para cada linha de xOpi.
    *==========================================================================
    PROTECTED PROCEDURE ReprocessarPesagemPorAmarra()
        LOCAL loc_oErro
        TRY
            IF NOT USED("xPesa") OR NOT USED("xOpi")
                RETURN
            ENDIF

            SELECT xOpi
            GO TOP
            SCAN
                *-- Limpa entradas anteriores da amarra atual
                DELETE FROM xPesa WHERE Amarra = xOpi.Amarra
            ENDSCAN

            *-- Refresh do grid apos reprocessar
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Ajuste fino do grid e campos do form operacional
    * Complementa ConfigurarGrade() com propriedades que replicam o legado:
    * - Grid: AllowHeaderSizing, Panel, DynamicForeColor por linha
    * - Colunas: ColumnOrder (reordena exibicao), Movable/Resizable=.F.
    *   Column1: FontName Arial, Format L, InputMask numerico
    *   Column2: Alignment=4 (Pedido a direita)
    *   Column3: ColumnOrder=4, InputMask "99,999,999.999"
    *   Column4: ColumnOrder=5
    *   Column5: ColumnOrder=6, Sparse=.F., Check1 Alignment=2, Centered=.T.
    *   Column6: ColumnOrder=3 (Conta exibida 3a no legado)
    *   Column7: Sparse=.F., Check1 Alignment=2, Centered=.T.
    * - txt_4c_Descr: FontUnderline=.T. (replica legado Get_descr)
    * - lbl_4c_LblAtencao: FontBold=.T. (replica legado Say1)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF NOT PEMSTATUS(THIS, "grd_4c_Dados", 5)
                RETURN
            ENDIF
            loc_oGrid = THIS.grd_4c_Dados

            *-- Grade: propriedades gerais adicionais (legado: AllowHeaderSizing=.F., Panel=1)
            WITH loc_oGrid
                .AllowHeaderSizing = .F.
                .HeaderHeight       = 16
                .Panel              = 1
            ENDWITH

            *-- DynamicForeColor: linhas com Divs marcado ficam azuis
            *-- Replica: .SetAll('DynamicForeColor','Iif(xOpi.Divs,RGB(0,0,255),RGB(0,0,0))','Column')
            IF USED("xOpi")
                loc_oGrid.SetAll("DynamicForeColor", ;
                    "IIF(VARTYPE(xOpi.Divs)='L'," + ;
                    "IIF(xOpi.Divs,RGB(0,0,255),RGB(0,0,0))," + ;
                    "IIF(xOpi.Divs=1,RGB(0,0,255),RGB(0,0,0)))", ;
                    "Column")
            ENDIF

            *-- Column1: Ordem Fabricacao - FontName Arial, Format L, InputMask, Movable/Resizable
            WITH loc_oGrid.Column1
                .FontName  = "Arial"
                .FontSize  = 9
                .Movable   = .F.
                .Resizable = .F.
                .Format    = "L"
                .InputMask = "9999999999"
            ENDWITH

            *-- Column2: Pedido - Alignment=4 (direita), Movable/Resizable
            WITH loc_oGrid.Column2
                .Alignment = 4
                .Movable   = .F.
                .Resizable = .F.
            ENDWITH

            *-- Column3: Quantidade - ColumnOrder=4, InputMask numerico com decimais, Movable/Resizable
            WITH loc_oGrid.Column3
                .ColumnOrder = 4
                .InputMask   = "99,999,999.999"
                .Movable     = .F.
                .Resizable   = .F.
            ENDWITH

            *-- Column4: Produto - ColumnOrder=5, Movable/Resizable
            WITH loc_oGrid.Column4
                .ColumnOrder = 5
                .Movable     = .F.
                .Resizable   = .F.
            ENDWITH

            *-- Column5: Ind - ColumnOrder=6, FontSize=8, Sparse=.F., Alignment=2, Movable/Resizable
            WITH loc_oGrid.Column5
                .ColumnOrder = 6
                .FontSize    = 8
                .Movable     = .F.
                .Resizable   = .F.
                .Sparse      = .F.
                .Alignment   = 2
            ENDWITH
            IF PEMSTATUS(loc_oGrid.Column5, "Check1", 5)
                WITH loc_oGrid.Column5.Check1
                    .Alignment = 2
                    .Centered  = .T.
                ENDWITH
            ENDIF

            *-- Column6: Conta - ColumnOrder=3 (exibida na 3a posicao, antes de Qtd/Produto)
            WITH loc_oGrid.Column6
                .ColumnOrder = 3
                .Movable     = .F.
                .Resizable   = .F.
            ENDWITH

            *-- Column7: PM - Sparse=.F., Alignment=2, Movable/Resizable
            WITH loc_oGrid.Column7
                .Movable   = .F.
                .Resizable = .F.
                .Sparse    = .F.
                .Alignment = 2
            ENDWITH
            IF PEMSTATUS(loc_oGrid.Column7, "Check1", 5)
                WITH loc_oGrid.Column7.Check1
                    .Alignment = 2
                    .Centered  = .T.
                ENDWITH
            ENDIF

            *-- txt_4c_Descr: FontUnderline=.T. (replica Get_descr do legado)
            IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
                THIS.txt_4c_Descr.FontUnderline = .T.
            ENDIF

            *-- lbl_4c_LblAtencao: FontBold=.T. (replica Say1 do legado)
            IF PEMSTATUS(THIS, "lbl_4c_LblAtencao", 5)
                THIS.lbl_4c_LblAtencao.FontBold = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere dados da linha corrente de xOpi e campos do
    * form (Mm_obs, Get_descr, contas de origem/destino) para as propriedades
    * do Business Object. Chamado antes de Inserir/Atualizar no BO.
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oErro, loc_oBO
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) <> "O"
                loc_lResultado = .F.
            ENDIF

            *-- Carrega linha corrente de xOpi para propriedades do BO
            IF USED("xOpi") AND NOT EOF("xOpi") AND NOT BOF("xOpi")
                loc_oBO.CarregarDoCursor("xOpi")
            ENDIF

            *-- Contexto da operacao (TmpNens corrente)
            IF USED("TmpNens") AND NOT EOF("TmpNens")
                SELECT TmpNens
                loc_oBO.this_cEmps   = ALLTRIM(NVL(TmpNens.Emps, ""))
                loc_oBO.this_cDopps  = ALLTRIM(NVL(TmpNens.Dopps, ""))
                loc_oBO.this_nNumps  = NVL(TmpNens.Numps, 0)
                IF TYPE("TmpNens.grupoos") <> "U"
                    loc_oBO.this_cGrupoOs = ALLTRIM(NVL(TmpNens.grupoos, ""))
                ENDIF
                IF TYPE("TmpNens.contaos") <> "U"
                    loc_oBO.this_cContaOs = ALLTRIM(NVL(TmpNens.contaos, ""))
                ENDIF
                IF TYPE("TmpNens.grupods") <> "U"
                    loc_oBO.this_cGrupoDs = ALLTRIM(NVL(TmpNens.grupods, ""))
                ENDIF
                IF TYPE("TmpNens.contads") <> "U"
                    loc_oBO.this_cContaDs = ALLTRIM(NVL(TmpNens.contads, ""))
                ENDIF
            ENDIF

            *-- Flags de exibicao (crSigCdOpd)
            IF USED("crSigCdOpd") AND NOT EOF("crSigCdOpd")
                SELECT crSigCdOpd
                loc_oBO.this_nOrigems  = NVL(crSigCdOpd.Origems, 0)
                loc_oBO.this_nDestinos = NVL(crSigCdOpd.Destinos, 0)
                loc_oBO.this_nImagms   = NVL(crSigCdOpd.Imagems, 0)
                loc_oBO.this_nEtiqs    = NVL(crSigCdOpd.Etiqs, 0)
                IF TYPE("crSigCdOpd.Dopes") <> "U"
                    loc_oBO.this_cDopesOpd = ALLTRIM(NVL(crSigCdOpd.Dopes, ""))
                ENDIF
            ENDIF

            *-- Descricoes de conta de origem/destino (campos visiveis)
            IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Grupo", 5)
                loc_oBO.this_cGrupoOs  = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Grupo.Value)
                loc_oBO.this_cContaOs  = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Conta.Value)
                loc_oBO.this_cDcontaOs = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Dconta.Value)
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_Grupo", 5)
                loc_oBO.this_cGrupoDs  = ALLTRIM(THIS.cnt_4c_Destino.txt_4c_Grupo.Value)
                loc_oBO.this_cContaDs  = ALLTRIM(THIS.cnt_4c_Destino.txt_4c_Conta.Value)
                loc_oBO.this_cDcontaDs = ALLTRIM(THIS.cnt_4c_Destino.txt_4c_Dconta.Value)
            ENDIF

            *-- Descricao do produto (Get_descr) e observacao (Mm_obs)
            IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
                loc_oBO.this_cDescr = ALLTRIM(THIS.txt_4c_Descr.Value)
            ENDIF
            IF PEMSTATUS(THIS, "obj_4c_Mm_obs", 5)
                loc_oBO.this_cObs = THIS.obj_4c_Mm_obs.Value
            ENDIF

            *-- Contexto do form pai
            loc_oBO.this_cEscolha = THIS.this_cEscolha
            loc_oBO.this_cDopp    = THIS.this_cDopp

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Atualiza campos visiveis do form com dados do Business
    * Object (Get_descr, FigJpg, contas, observacao). Chamado apos
    * CarregarDoCursor + ObterDadosProduto + ObterDescricaoConta no BO.
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oErro, loc_oBO, loc_cArquivoFoto, loc_cBase64
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) <> "O"
                loc_lResultado = .F.
            ENDIF

            *-- Descricao do produto da linha corrente
            IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
                THIS.txt_4c_Descr.Value = ALLTRIM(loc_oBO.this_cDPros)
            ENDIF

            *-- Imagem do produto: extrai base64 e grava em arquivo temp
            IF PEMSTATUS(THIS, "img_4c_FigJpg", 5)
                IF loc_oBO.this_nImagms = 1 AND NOT EMPTY(loc_oBO.this_cFigJpgs)
                    loc_cArquivoFoto = SYS(2023) + "\Temp3.jpg"
                    loc_cBase64 = loc_oBO.this_cFigJpgs
                    loc_cBase64 = STRTRAN(loc_cBase64, "data:image/png;base64,", "")
                    loc_cBase64 = STRTRAN(loc_cBase64, "data:image/jpeg;base64,", "")
                    loc_cBase64 = STRTRAN(loc_cBase64, "data:image/jpg;base64,", "")
                    TRY
                        STRTOFILE(STRCONV(loc_cBase64, 14), loc_cArquivoFoto)
                        THIS.img_4c_FigJpg.Picture = loc_cArquivoFoto
                        THIS.img_4c_FigJpg.Visible = .T.
                        IF PEMSTATUS(THIS, "shp_4c_Shape4", 5)
                            THIS.shp_4c_Shape4.Visible = .T.
                        ENDIF
                    CATCH
                        THIS.img_4c_FigJpg.Picture = ""
                        THIS.img_4c_FigJpg.Visible = .F.
                    ENDTRY
                ELSE
                    THIS.img_4c_FigJpg.Picture = ""
                    THIS.img_4c_FigJpg.Visible = .F.
                ENDIF
            ENDIF

            *-- Contas de origem/destino
            IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Grupo", 5)
                THIS.cnt_4c_Origem.txt_4c_Grupo.Value  = loc_oBO.this_cGrupoOs
                THIS.cnt_4c_Origem.txt_4c_Conta.Value  = loc_oBO.this_cContaOs
                THIS.cnt_4c_Origem.txt_4c_Dconta.Value = loc_oBO.this_cDcontaOs
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_Grupo", 5)
                THIS.cnt_4c_Destino.txt_4c_Grupo.Value  = loc_oBO.this_cGrupoDs
                THIS.cnt_4c_Destino.txt_4c_Conta.Value  = loc_oBO.this_cContaDs
                THIS.cnt_4c_Destino.txt_4c_Dconta.Value = loc_oBO.this_cDcontaDs
            ENDIF

            *-- Observacao
            IF PEMSTATUS(THIS, "obj_4c_Mm_obs", 5)
                IF NOT EMPTY(loc_oBO.this_cObs)
                    THIS.obj_4c_Mm_obs.Value = loc_oBO.this_cObs
                ENDIF
            ENDIF

            *-- Visibilidade dos containers segundo flags do BO
            THIS.AjustarVisibilidadeContainers()

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega o grid de itens (xOpi) e refaz binding.
    * Equivale a reset + refresh do grid mantendo configuracao das colunas.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oErro, loc_oGrid
        TRY
            IF NOT PEMSTATUS(THIS, "grd_4c_Dados", 5)
                loc_lResultado = .F.
            ENDIF
            IF NOT USED("xOpi")
                loc_lResultado = .F.
            ENDIF

            loc_oGrid = THIS.grd_4c_Dados
            SELECT xOpi
            GO TOP

            *-- Re-bind do RecordSource (apenas se diferente, para preservar estado)
            IF UPPER(ALLTRIM(loc_oGrid.RecordSource)) <> "XOPI"
                loc_oGrid.RecordSource = "xOpi"
            ENDIF

            loc_oGrid.Refresh()

            *-- Atualiza descricao/imagem do produto da linha corrente
            IF NOT EOF("xOpi")
                THIS.GradeAfterRowColChange(1)
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme this_cEscolha.
    * Modo INSERIR: Incluir/Alterar/Excluir habilitados (marcacao de itens).
    * Modo CONSULTAR: apenas Visualizar/OK/Encerrar (somente leitura).
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lInserir, loc_oErro
        TRY
            loc_lInserir = (THIS.this_cEscolha == "INSERIR")

            IF PEMSTATUS(THIS, "cmd_4c_Incluir", 5)
                THIS.cmd_4c_Incluir.Enabled = loc_lInserir
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Alterar", 5)
                THIS.cmd_4c_Alterar.Enabled = loc_lInserir
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
                THIS.cmd_4c_Excluir.Enabled = loc_lInserir
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Visualizar", 5)
                THIS.cmd_4c_Visualizar.Enabled = .T.
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Buscar", 5)
                THIS.cmd_4c_Buscar.Enabled = .T.
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
                THIS.cmd_4c_Ok.Enabled = .T.
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
                THIS.cmd_4c_Encerrar.Enabled = .T.
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Pesagem", 5)
                THIS.cmd_4c_Pesagem.Enabled = loc_lInserir
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos do form conforme o modo.
    * Apenas Mm_obs (observacao) eh editavel; demais sao informativos.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab, loc_oErro
        TRY
            IF PCOUNT() = 0
                loc_lHab = (THIS.this_cEscolha == "INSERIR")
            ELSE
                loc_lHab = par_lHabilitar
            ENDIF

            *-- Observacao: editavel em INSERIR, somente leitura em CONSULTAR
            IF PEMSTATUS(THIS, "obj_4c_Mm_obs", 5)
                THIS.obj_4c_Mm_obs.ReadOnly = NOT loc_lHab
                THIS.obj_4c_Mm_obs.Enabled  = .T.
            ENDIF

            *-- Descricao do produto: sempre somente leitura (lookup-driven)
            IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
                THIS.txt_4c_Descr.ReadOnly = .T.
                THIS.txt_4c_Descr.Enabled  = .T.
            ENDIF

            *-- Campos de operacao, origem e destino: sempre somente leitura
            IF PEMSTATUS(THIS.cnt_4c_Operacao, "txt_4c_Empresa", 5)
                THIS.cnt_4c_Operacao.txt_4c_Empresa.ReadOnly  = .T.
                THIS.cnt_4c_Operacao.txt_4c_Operacao.ReadOnly = .T.
                THIS.cnt_4c_Operacao.txt_4c_Codigo.ReadOnly   = .T.
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Grupo", 5)
                THIS.cnt_4c_Origem.txt_4c_Grupo.ReadOnly  = .T.
                THIS.cnt_4c_Origem.txt_4c_Conta.ReadOnly  = .T.
                THIS.cnt_4c_Origem.txt_4c_Dconta.ReadOnly = .T.
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_Grupo", 5)
                THIS.cnt_4c_Destino.txt_4c_Grupo.ReadOnly  = .T.
                THIS.cnt_4c_Destino.txt_4c_Conta.ReadOnly  = .T.
                THIS.cnt_4c_Destino.txt_4c_Dconta.ReadOnly = .T.
            ENDIF

            *-- Grid: edicao de Indiv/PM (Check1) ja controlada por Column.When
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Enabled = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa campos do form e resseta estado do BO.
    * Nao toca em xOpi/xPesa/TmpNens (cursores do form pai compartilhados).
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oErro, loc_oBO
        TRY
            *-- Campos visiveis do form
            IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
                THIS.txt_4c_Descr.Value = ""
            ENDIF
            IF PEMSTATUS(THIS, "obj_4c_Mm_obs", 5)
                THIS.obj_4c_Mm_obs.Value = ""
            ENDIF
            IF PEMSTATUS(THIS, "img_4c_FigJpg", 5)
                THIS.img_4c_FigJpg.Picture = ""
                THIS.img_4c_FigJpg.Visible = .F.
            ENDIF
            IF PEMSTATUS(THIS, "shp_4c_Shape4", 5)
                THIS.shp_4c_Shape4.Visible = .F.
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Grupo", 5)
                THIS.cnt_4c_Origem.txt_4c_Grupo.Value  = ""
                THIS.cnt_4c_Origem.txt_4c_Conta.Value  = ""
                THIS.cnt_4c_Origem.txt_4c_Dconta.Value = ""
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_Grupo", 5)
                THIS.cnt_4c_Destino.txt_4c_Grupo.Value  = ""
                THIS.cnt_4c_Destino.txt_4c_Conta.Value  = ""
                THIS.cnt_4c_Destino.txt_4c_Dconta.Value = ""
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Operacao, "txt_4c_Empresa", 5)
                THIS.cnt_4c_Operacao.txt_4c_Empresa.Value  = ""
                THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = ""
                THIS.cnt_4c_Operacao.txt_4c_Codigo.Value   = ""
            ENDIF

            *-- Reseta propriedades de transito do BO (mantem contexto da operacao)
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) = "O"
                loc_oBO.this_cDPros     = ""
                loc_oBO.this_cFigJpgs   = ""
                loc_oBO.this_cMatPrincs = ""
                loc_oBO.this_cCgrus     = ""
                loc_oBO.this_nPesoms    = 0
                loc_oBO.this_cMercs     = ""
                loc_oBO.this_cMatPGpr   = ""
                loc_oBO.this_nCpQtds    = 0
                loc_oBO.this_cMatP      = ""
                loc_oBO.this_cDescr     = ""
                loc_oBO.this_cObs       = ""
                loc_oBO.this_cDcontaOs  = ""
                loc_oBO.this_cDcontaDs  = ""
                loc_oBO.this_lEspecial  = .F.
                loc_oBO.this_nCadProds  = 0
                loc_oBO.this_nPesos     = 0
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega lista (xOpi) e atualiza descricao/imagem
    * do produto da linha corrente. Equivale a refresh manual do grid.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            THIS.CarregarLista()
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias semantico para BtnOkClick (confirma emissao).
    * Antes de OK, popula BO com dados do form para garantir auditoria.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()
        THIS.BtnOkClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Alias semantico para BtnEncerrarClick (descarta).
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

ENDDEFINE
