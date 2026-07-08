*==============================================================================
* Formsigrecsm.prg
* Formulario de Relatorio de Comissao por Condicao de Pagamento
*
* Migrado de: SIGRECSM.SCX (frmrelatorio)
* Layout   : FLAT - controles direto no form, sem PageFrame
* Herda de : FormBase
*
* Filtros  : periodo, empresa, grupo (SigCdCrg), conta/vendedor (SigCdCli),
*            moeda (SigCdMoe), opcao de relatorio (4), checkbox comissao zerada
* Relatorios: SigReCs1 (nOpt=3), SigReCs2 (nOpt=1,2,4)
*==============================================================================

DEFINE CLASS Formsigrecsm AS FormBase

    *-- Propriedades visuais
    this_cMensagemErro = ""
    Height      = 300
    Width       = 800
    AutoCenter  = .T.
    BorderStyle = 2
    Caption     = " Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                  "o por Condi" + CHR(231) + CHR(227) + "o de Pagamento "
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    WindowType  = 1
    BackColor   = RGB(192, 192, 192)
    ShowWindow  = 1

    *-- BO de relatorio
    this_oRelatorio = .NULL.

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook chamado por FormBase.Init()
    * Cria BO, configura cabecalho, botoes, campos e BINDEVENTs
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle < 0
                    MsgErro("Erro de conex" + CHR(227) + "o com banco de dados.", "Erro")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF

            IF loc_lSucesso
                THIS.this_oRelatorio = CREATEOBJECT("sigrecsmBO")

                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarBotoes()
                THIS.ConfigurarCampos()
                THIS.ConfigurarBINDEVENTs()

                THIS.InicializarValoresPadrao()
                THIS.AtualizarEstados()

                THIS.Visible = .T.

                IF TYPE("THIS.txt_4c__dt_inicial") = "O"
                    THIS.txt_4c__dt_inicial.SetFocus()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar formul" + CHR(225) + "rio:" + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - REPORT form usa layout FLAT (sem PageFrame)
    * Mantido como no-op para compatibilidade com a validacao multi-fase
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - REPORT form usa layout FLAT (sem Page Lista)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - REPORT form nao possui PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - REPORT form usa ConfigurarCampos como ponto unico
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 25
            .Left      = 20
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 30
            .Caption   = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                         "o por Condi" + CHR(231) + CHR(227) + "o de Pagamento"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible = .T.
        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes (Visualizar/Imprimir/Excel/Encerrar)
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
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")

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
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")

        WITH THIS.cmg_4c_Botoes.Buttons(3)
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
            .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")

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
            .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Todos os campos de filtro direto no form (layout FLAT)
    * Posicoes mapeadas pixel-perfect do SIGRECSM.SCX original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()

        *-- === PERIODO top=96/101 ===
        THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH THIS.lbl_4c_Lbl_periodo
            .Top       = 101
            .Left      = 169
            .AutoSize  = .T.
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__dt_inicial", "TextBox")
        WITH THIS.txt_4c__dt_inicial
            .Top           = 96
            .Left          = 218
            .Width         = 79
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH THIS.lbl_4c_Lbl_periodo_a
            .Top       = 103
            .Left      = 301
            .AutoSize  = .T.
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__dt_final", "TextBox")
        WITH THIS.txt_4c__dt_final
            .Top           = 96
            .Left          = 312
            .Width         = 79
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        *-- === EMPRESA top=124/129 ===
        THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH THIS.lbl_4c_Lbl_empresa
            .Top       = 129
            .Left      = 164
            .AutoSize  = .T.
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__empresa", "TextBox")
        WITH THIS.txt_4c__empresa
            .Top           = 124
            .Left          = 218
            .Width         = 31
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K!"
            .MaxLength     = 3
            .Alignment     = 0
            .SpecialEffect = 0
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c__empresa_desc", "TextBox")
        WITH THIS.txt_4c__empresa_desc
            .Top           = 124
            .Left          = 251
            .Width         = 290
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .MaxLength     = 40
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- === GRUPO (SigCdCrg) top=152/157 ===
        THIS.AddObject("lbl_4c_Lbl_grupo", "Label")
        WITH THIS.lbl_4c_Lbl_grupo
            .Top       = 157
            .Left      = 176
            .AutoSize  = .T.
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
        WITH THIS.txt_4c__Cd_GrEstoque
            .Top           = 152
            .Left          = 218
            .Width         = 79
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K!"
            .MaxLength     = 10
            .SpecialEffect = 0
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
        WITH THIS.txt_4c__Ds_GrEstoque
            .Top           = 152
            .Left          = 299
            .Width         = 150
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .MaxLength     = 20
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- === CONTA / VENDEDOR (SigCdCli) top=180/185 ===
        THIS.AddObject("lbl_4c_Lbl_estoque", "Label")
        WITH THIS.lbl_4c_Lbl_estoque
            .Top       = 185
            .Left      = 176
            .AutoSize  = .T.
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c__cd_estoque", "TextBox")
        WITH THIS.txt_4c__cd_estoque
            .Top           = 180
            .Left          = 218
            .Width         = 79
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K!"
            .MaxLength     = 10
            .SpecialEffect = 0
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c__ds_estoque", "TextBox")
        WITH THIS.txt_4c__ds_estoque
            .Top           = 180
            .Left          = 299
            .Width         = 290
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .MaxLength     = 40
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- === MOEDA (SigCdMoe) top=208/213 ===
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top       = 213
            .Left      = 173
            .AutoSize  = .T.
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Cmoeda", "TextBox")
        WITH THIS.txt_4c_Cmoeda
            .Top           = 208
            .Left          = 218
            .Width         = 31
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K!"
            .MaxLength     = 3
            .Alignment     = 0
            .SpecialEffect = 0
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Dmoeda", "TextBox")
        WITH THIS.txt_4c_Dmoeda
            .Top           = 208
            .Left          = 251
            .Width         = 115
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Format        = "K"
            .MaxLength     = 15
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- === TIPO / OPCAO RELATORIO top=239/240 ===
        THIS.AddObject("lbl_4c_Lbl_tipo", "Label")
        WITH THIS.lbl_4c_Lbl_tipo
            .Top       = 239
            .Left      = 182
            .AutoSize  = .T.
            .Caption   = " Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_OptRel", "OptionGroup")
        WITH THIS.obj_4c_OptRel
            .Top         = 240
            .Left        = 217
            .Width       = 463
            .Height      = 17
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            .Option1.Caption   = "Si\<nt" + CHR(233) + "tico"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 1
            .Option1.Left      = 1
            .Option1.Width     = 59
            .Option1.Height    = 15
            .Option1.AutoSize  = .T.

            .Option2.Caption   = "\<Anal" + CHR(237) + "tico"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 1
            .Option2.Left      = 80
            .Option2.Width     = 58
            .Option2.Height    = 15
            .Option2.AutoSize  = .T.

            .Option3.Caption   = "Condi" + CHR(231) + CHR(227) + "o de Pagamento"
            .Option3.FontName  = "Tahoma"
            .Option3.FontSize  = 8
            .Option3.BackStyle = 0
            .Option3.ForeColor = RGB(90, 90, 90)
            .Option3.Top       = 1
            .Option3.Left      = 162
            .Option3.Width     = 134
            .Option3.Height    = 15
            .Option3.AutoSize  = .T.

            .Option4.Caption   = "Comiss" + CHR(227) + "o dividida"
            .Option4.FontName  = "Tahoma"
            .Option4.FontSize  = 8
            .Option4.BackStyle = 0
            .Option4.ForeColor = RGB(90, 90, 90)
            .Option4.Top       = 1
            .Option4.Left      = 334
            .Option4.Width     = 131
            .Option4.Height    = 17
            .Option4.AutoSize  = .T.

            .Visible = .T.
        ENDWITH

        *-- === NAO INCLUIR COMISSAO ZERADA top=258 ===
        THIS.AddObject("chk_4c_FwChkComissao", "CheckBox")
        WITH THIS.chk_4c_FwChkComissao
            .Top           = 258
            .Left          = 218
            .AutoSize      = .T.
            .Alignment     = 0
            .Caption       = "N" + CHR(227) + "o incluir comiss" + CHR(227) + "o zerada"
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBINDEVENTs - F4=lookup, ENTER/TAB=validar, DblClick=lookup
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        BINDEVENT(THIS.txt_4c__empresa,       "KeyPress", THIS, "TeclaLookupEmpresaCod")
        BINDEVENT(THIS.txt_4c__empresa_desc,  "KeyPress", THIS, "TeclaLookupEmpresaDesc")
        BINDEVENT(THIS.txt_4c__empresa,       "DblClick", THIS, "AbrirBuscaEmpresaCod")
        BINDEVENT(THIS.txt_4c__empresa_desc,  "DblClick", THIS, "AbrirBuscaEmpresaDesc")

        BINDEVENT(THIS.txt_4c__Cd_GrEstoque,  "KeyPress", THIS, "TeclaLookupGrupoCod")
        BINDEVENT(THIS.txt_4c__Ds_GrEstoque,  "KeyPress", THIS, "TeclaLookupGrupoDesc")
        BINDEVENT(THIS.txt_4c__Cd_GrEstoque,  "DblClick", THIS, "AbrirBuscaGrupoCod")
        BINDEVENT(THIS.txt_4c__Ds_GrEstoque,  "DblClick", THIS, "AbrirBuscaGrupoDesc")

        BINDEVENT(THIS.txt_4c__cd_estoque,    "KeyPress", THIS, "TeclaLookupContaCod")
        BINDEVENT(THIS.txt_4c__ds_estoque,    "KeyPress", THIS, "TeclaLookupContaDesc")
        BINDEVENT(THIS.txt_4c__cd_estoque,    "DblClick", THIS, "AbrirBuscaContaCod")
        BINDEVENT(THIS.txt_4c__ds_estoque,    "DblClick", THIS, "AbrirBuscaContaDesc")

        BINDEVENT(THIS.txt_4c_Cmoeda,         "KeyPress", THIS, "TeclaLookupMoedaCod")
        BINDEVENT(THIS.txt_4c_Dmoeda,         "KeyPress", THIS, "TeclaLookupMoedaDesc")
        BINDEVENT(THIS.txt_4c_Cmoeda,         "DblClick", THIS, "AbrirBuscaMoedaCod")
        BINDEVENT(THIS.txt_4c_Dmoeda,         "DblClick", THIS, "AbrirBuscaMoedaDesc")
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarValoresPadrao - Define valores iniciais dos filtros
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarValoresPadrao()
        LOCAL loc_nResult, loc_cSQL

        THIS.txt_4c__dt_inicial.Value = DATE()
        THIS.txt_4c__dt_final.Value   = DATE()

        *-- Empresa padrao: go_4c_Sistema.cCodEmpresa
        IF TYPE("go_4c_Sistema") = "O" AND !EMPTY(go_4c_Sistema.cCodEmpresa)
            THIS.txt_4c__empresa.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    THIS.ValidarEmpresaCod()
                ENDIF
            ENDIF
        ENDIF

        *-- Moeda padrao: SigCdPam.MoedaPs
        IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL    = "SELECT MoedaPs FROM SigCdPam"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CsmPam")
                IF loc_nResult > 0
                    SELECT cursor_4c_CsmPam
                    IF !EOF() AND !EMPTY(cursor_4c_CsmPam.MoedaPs)
                        THIS.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_CsmPam.MoedaPs)
                        IF USED("cursor_4c_CsmPam")
                            USE IN cursor_4c_CsmPam
                        ENDIF
                        THIS.ValidarMoedaCod()
                    ELSE
                        IF USED("cursor_4c_CsmPam")
                            USE IN cursor_4c_CsmPam
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ESTADO DOS CONTROLES (cascata grupo -> conta)
    *==========================================================================

    PROTECTED PROCEDURE AtualizarEstados()
        THIS.AtualizarEstadoEmpresaDesc()
        THIS.AtualizarEstadoGrupoDesc()
        THIS.AtualizarEstadoContaCd()
        THIS.AtualizarEstadoContaDesc()
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    PROTECTED PROCEDURE AtualizarEstadoEmpresaDesc()
        IF EMPTY(ALLTRIM(THIS.txt_4c__empresa.Value))
            THIS.txt_4c__empresa_desc.ReadOnly  = .F.
            THIS.txt_4c__empresa_desc.BackColor = RGB(255, 255, 255)
        ELSE
            THIS.txt_4c__empresa_desc.ReadOnly  = .T.
            THIS.txt_4c__empresa_desc.BackColor = RGB(240, 240, 240)
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AtualizarEstadoGrupoDesc()
        IF EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value))
            THIS.txt_4c__Ds_GrEstoque.ReadOnly  = .F.
            THIS.txt_4c__Ds_GrEstoque.BackColor = RGB(255, 255, 255)
        ELSE
            THIS.txt_4c__Ds_GrEstoque.ReadOnly  = .T.
            THIS.txt_4c__Ds_GrEstoque.BackColor = RGB(240, 240, 240)
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AtualizarEstadoContaCd()
        IF EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value))
            THIS.txt_4c__cd_estoque.ReadOnly  = .T.
            THIS.txt_4c__cd_estoque.BackColor = RGB(240, 240, 240)
        ELSE
            THIS.txt_4c__cd_estoque.ReadOnly  = .F.
            THIS.txt_4c__cd_estoque.BackColor = RGB(255, 255, 255)
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AtualizarEstadoContaDesc()
        IF EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)) OR ;
           !EMPTY(ALLTRIM(THIS.txt_4c__cd_estoque.Value))
            THIS.txt_4c__ds_estoque.ReadOnly  = .T.
            THIS.txt_4c__ds_estoque.BackColor = RGB(240, 240, 240)
        ELSE
            THIS.txt_4c__ds_estoque.ReadOnly  = .F.
            THIS.txt_4c__ds_estoque.BackColor = RGB(255, 255, 255)
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AtualizarEstadoMoedaDesc()
        IF EMPTY(ALLTRIM(THIS.txt_4c_Cmoeda.Value))
            THIS.txt_4c_Dmoeda.ReadOnly  = .F.
            THIS.txt_4c_Dmoeda.BackColor = RGB(255, 255, 255)
        ELSE
            THIS.txt_4c_Dmoeda.ReadOnly  = .T.
            THIS.txt_4c_Dmoeda.BackColor = RGB(240, 240, 240)
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA pelo codigo (SigCdEmp.Cemps)
    *==========================================================================

    PROCEDURE TeclaLookupEmpresaCod(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresaCod()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresaCod()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaEmpresaCod()
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c__empresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__empresa.Value      = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                THIS.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        THIS.txt_4c__empresa.Value      = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        THIS.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        THIS.AtualizarEstadoEmpresaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarEmpresaCod()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c__empresa.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__empresa_desc.Value = ""
            THIS.AtualizarEstadoEmpresaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal
            IF !EOF()
                THIS.txt_4c__empresa_desc.Value = ALLTRIM(Razas)
            ELSE
                THIS.txt_4c__empresa_desc.Value = ""
                THIS.AbrirBuscaEmpresaCod()
            ENDIF
        ELSE
            THIS.txt_4c__empresa_desc.Value = ""
            THIS.AbrirBuscaEmpresaCod()
        ENDIF
        IF USED("cursor_4c_EmpVal")
            USE IN cursor_4c_EmpVal
        ENDIF
        THIS.AtualizarEstadoEmpresaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA pela descricao (SigCdEmp.Razas)
    *==========================================================================

    PROCEDURE TeclaLookupEmpresaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.txt_4c__empresa_desc.ReadOnly
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresaDesc()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresaDesc()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaEmpresaDesc()
        IF THIS.txt_4c__empresa_desc.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c__empresa_desc.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmpD", "Razas", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                THIS.txt_4c__empresa.Value      = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpD")
                        THIS.txt_4c__empresa_desc.Value = ALLTRIM(cursor_4c_BuscaEmpD.Razas)
                        THIS.txt_4c__empresa.Value      = ALLTRIM(cursor_4c_BuscaEmpD.Cemps)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmpD")
            USE IN cursor_4c_BuscaEmpD
        ENDIF
        THIS.AtualizarEstadoEmpresaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarEmpresaDesc()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c__empresa_desc.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__empresa.Value = ""
            THIS.AtualizarEstadoEmpresaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpDescVal
            IF !EOF()
                THIS.txt_4c__empresa.Value      = ALLTRIM(Cemps)
                THIS.txt_4c__empresa_desc.Value = ALLTRIM(Razas)
            ELSE
                THIS.AbrirBuscaEmpresaDesc()
            ENDIF
        ELSE
            THIS.AbrirBuscaEmpresaDesc()
        ENDIF
        IF USED("cursor_4c_EmpDescVal")
            USE IN cursor_4c_EmpDescVal
        ENDIF
        THIS.AtualizarEstadoEmpresaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - GRUPO pelo codigo (SigCdCrg.ccargs)
    *==========================================================================

    PROCEDURE TeclaLookupGrupoCod(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoCod()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupoCod()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaGrupoCod()
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCrg", "cursor_4c_BuscaGrp", "ccargs", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrp.ccargs)
                THIS.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrp.dcargs)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("ccargs", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dcargs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                        THIS.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrp.ccargs)
                        THIS.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrp.dcargs)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGrp")
            USE IN cursor_4c_BuscaGrp
        ENDIF
        THIS.AtualizarEstadoGrupoDesc()
        THIS.AtualizarEstadoContaCd()
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarGrupoCod()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__Ds_GrEstoque.Value = ""
            THIS.txt_4c__cd_estoque.Value   = ""
            THIS.txt_4c__ds_estoque.Value   = ""
            THIS.AtualizarEstadoGrupoDesc()
            THIS.AtualizarEstadoContaCd()
            THIS.AtualizarEstadoContaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT ccargs, dcargs FROM SigCdCrg WHERE ccargs = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GrpVal
            IF !EOF()
                THIS.txt_4c__Ds_GrEstoque.Value = ALLTRIM(dcargs)
            ELSE
                THIS.txt_4c__Ds_GrEstoque.Value = ""
                THIS.AbrirBuscaGrupoCod()
            ENDIF
        ELSE
            THIS.txt_4c__Ds_GrEstoque.Value = ""
            THIS.AbrirBuscaGrupoCod()
        ENDIF
        IF USED("cursor_4c_GrpVal")
            USE IN cursor_4c_GrpVal
        ENDIF
        THIS.AtualizarEstadoGrupoDesc()
        THIS.AtualizarEstadoContaCd()
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - GRUPO pela descricao (SigCdCrg.dcargs)
    *==========================================================================

    PROCEDURE TeclaLookupGrupoDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.txt_4c__Ds_GrEstoque.ReadOnly
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoDesc()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupoDesc()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaGrupoDesc()
        IF THIS.txt_4c__Ds_GrEstoque.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c__Ds_GrEstoque.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCrg", "cursor_4c_BuscaGrpD", "dcargs", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrpD.ccargs)
                THIS.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrpD.dcargs)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dcargs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("ccargs", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpD")
                        THIS.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrpD.ccargs)
                        THIS.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrpD.dcargs)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGrpD")
            USE IN cursor_4c_BuscaGrpD
        ENDIF
        THIS.AtualizarEstadoGrupoDesc()
        THIS.AtualizarEstadoContaCd()
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarGrupoDesc()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c__Ds_GrEstoque.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__Cd_GrEstoque.Value = ""
            THIS.txt_4c__cd_estoque.Value   = ""
            THIS.txt_4c__ds_estoque.Value   = ""
            THIS.AtualizarEstadoGrupoDesc()
            THIS.AtualizarEstadoContaCd()
            THIS.AtualizarEstadoContaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT ccargs, dcargs FROM SigCdCrg WHERE dcargs LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GrpDescVal
            IF !EOF()
                THIS.txt_4c__Cd_GrEstoque.Value = ALLTRIM(ccargs)
                THIS.txt_4c__Ds_GrEstoque.Value = ALLTRIM(dcargs)
            ELSE
                THIS.AbrirBuscaGrupoDesc()
            ENDIF
        ELSE
            THIS.AbrirBuscaGrupoDesc()
        ENDIF
        IF USED("cursor_4c_GrpDescVal")
            USE IN cursor_4c_GrpDescVal
        ENDIF
        THIS.AtualizarEstadoGrupoDesc()
        THIS.AtualizarEstadoContaCd()
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - CONTA/VENDEDOR pelo codigo (SigCdCli.iclis)
    *==========================================================================

    PROCEDURE TeclaLookupContaCod(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.txt_4c__cd_estoque.ReadOnly
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaContaCod()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarContaCod()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaContaCod()
        IF THIS.txt_4c__cd_estoque.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca, loc_cWhere
        loc_cValor  = ALLTRIM(THIS.txt_4c__cd_estoque.Value)
        loc_cWhere  = IIF(EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)), ;
                          "", ;
                          "ccargs = " + EscaparSQL(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)))
        loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaCli", "iclis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta/Vendedor", ;
            .F., .T., loc_cWhere)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__cd_estoque.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
                THIS.txt_4c__ds_estoque.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                        THIS.txt_4c__cd_estoque.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
                        THIS.txt_4c__ds_estoque.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaCli")
            USE IN cursor_4c_BuscaCli
        ENDIF
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarContaCod()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c__cd_estoque.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__ds_estoque.Value = ""
            THIS.AtualizarEstadoContaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliVal")
        IF loc_nResult > 0
            SELECT cursor_4c_CliVal
            IF !EOF()
                THIS.txt_4c__ds_estoque.Value = ALLTRIM(rclis)
            ELSE
                THIS.txt_4c__ds_estoque.Value = ""
                THIS.AbrirBuscaContaCod()
            ENDIF
        ELSE
            THIS.txt_4c__ds_estoque.Value = ""
            THIS.AbrirBuscaContaCod()
        ENDIF
        IF USED("cursor_4c_CliVal")
            USE IN cursor_4c_CliVal
        ENDIF
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - CONTA/VENDEDOR pela descricao (SigCdCli.rclis)
    *==========================================================================

    PROCEDURE TeclaLookupContaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.txt_4c__ds_estoque.ReadOnly
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaContaDesc()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarContaDesc()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaContaDesc()
        IF THIS.txt_4c__ds_estoque.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca, loc_cWhere
        loc_cValor  = ALLTRIM(THIS.txt_4c__ds_estoque.Value)
        loc_cWhere  = IIF(EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)), ;
                          "", ;
                          "ccargs = " + EscaparSQL(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)))
        loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaCliD", "rclis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta/Vendedor", ;
            .F., .T., loc_cWhere)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c__cd_estoque.Value = ALLTRIM(cursor_4c_BuscaCliD.iclis)
                THIS.txt_4c__ds_estoque.Value = ALLTRIM(cursor_4c_BuscaCliD.rclis)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("rclis", "", "Nome")
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCliD")
                        THIS.txt_4c__cd_estoque.Value = ALLTRIM(cursor_4c_BuscaCliD.iclis)
                        THIS.txt_4c__ds_estoque.Value = ALLTRIM(cursor_4c_BuscaCliD.rclis)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaCliD")
            USE IN cursor_4c_BuscaCliD
        ENDIF
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarContaDesc()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c__ds_estoque.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c__cd_estoque.Value = ""
            THIS.AtualizarEstadoContaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT iclis, rclis FROM SigCdCli WHERE rclis LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_CliDescVal
            IF !EOF()
                THIS.txt_4c__cd_estoque.Value = ALLTRIM(iclis)
                THIS.txt_4c__ds_estoque.Value = ALLTRIM(rclis)
            ELSE
                THIS.AbrirBuscaContaDesc()
            ENDIF
        ELSE
            THIS.AbrirBuscaContaDesc()
        ENDIF
        IF USED("cursor_4c_CliDescVal")
            USE IN cursor_4c_CliDescVal
        ENDIF
        THIS.AtualizarEstadoContaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA pelo codigo (SigCdMoe.CMoes)
    *==========================================================================

    PROCEDURE TeclaLookupMoedaCod(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoedaCod()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedaCod()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaMoedaCod()
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c_Cmoeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                THIS.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        THIS.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                        THIS.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarMoedaCod()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c_Cmoeda.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_Dmoeda.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeVal
            IF !EOF()
                THIS.txt_4c_Dmoeda.Value = ALLTRIM(DMoes)
            ELSE
                THIS.txt_4c_Dmoeda.Value = ""
                THIS.AbrirBuscaMoedaCod()
            ENDIF
        ELSE
            THIS.txt_4c_Dmoeda.Value = ""
            THIS.AbrirBuscaMoedaCod()
        ENDIF
        IF USED("cursor_4c_MoeVal")
            USE IN cursor_4c_MoeVal
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA pela descricao (SigCdMoe.DMoes)
    *==========================================================================

    PROCEDURE TeclaLookupMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.txt_4c_Dmoeda.ReadOnly
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoedaDesc()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedaDesc()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaMoedaDesc()
        IF THIS.txt_4c_Dmoeda.ReadOnly
            RETURN
        ENDIF
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c_Dmoeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeD", "DMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                THIS.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeD")
                        THIS.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.CMoes)
                        THIS.txt_4c_Dmoeda.Value = ALLTRIM(cursor_4c_BuscaMoeD.DMoes)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMoeD")
            USE IN cursor_4c_BuscaMoeD
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    PROTECTED PROCEDURE ValidarMoedaDesc()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c_Dmoeda.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_Cmoeda.Value = ""
            THIS.AtualizarEstadoMoedaDesc()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE DMoes LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeDescVal")
        IF loc_nResult > 0
            SELECT cursor_4c_MoeDescVal
            IF !EOF()
                THIS.txt_4c_Cmoeda.Value = ALLTRIM(CMoes)
                THIS.txt_4c_Dmoeda.Value = ALLTRIM(DMoes)
            ELSE
                THIS.AbrirBuscaMoedaDesc()
            ENDIF
        ELSE
            THIS.AbrirBuscaMoedaDesc()
        ENDIF
        IF USED("cursor_4c_MoeDescVal")
            USE IN cursor_4c_MoeDescVal
        ENDIF
        THIS.AtualizarEstadoMoedaDesc()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        THIS.this_oRelatorio.this_dDtInicial   = THIS.txt_4c__dt_inicial.Value
        THIS.this_oRelatorio.this_dDtFinal     = THIS.txt_4c__dt_final.Value
        THIS.this_oRelatorio.this_cCemps       = ALLTRIM(THIS.txt_4c__empresa.Value)
        THIS.this_oRelatorio.this_cRazas       = ALLTRIM(THIS.txt_4c__empresa_desc.Value)
        THIS.this_oRelatorio.this_cCdGrEstoque = ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)
        THIS.this_oRelatorio.this_cDsGrEstoque = ALLTRIM(THIS.txt_4c__Ds_GrEstoque.Value)
        THIS.this_oRelatorio.this_cCdEstoque   = ALLTRIM(THIS.txt_4c__cd_estoque.Value)
        THIS.this_oRelatorio.this_cDsEstoque   = ALLTRIM(THIS.txt_4c__ds_estoque.Value)
        THIS.this_oRelatorio.this_cCmoes       = ALLTRIM(THIS.txt_4c_Cmoeda.Value)
        THIS.this_oRelatorio.this_cDmoes       = ALLTRIM(THIS.txt_4c_Dmoeda.Value)
        THIS.this_oRelatorio.this_nOptRel      = THIS.obj_4c_OptRel.Value
        THIS.this_oRelatorio.this_lChkComissao = (THIS.chk_4c_FwChkComissao.Value = 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos obrigatorios antes de gerar o relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.txt_4c__dt_inicial.Value)
            MsgAviso("Data inicial " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                     "Comiss" + CHR(227) + "o")
            THIS.txt_4c__dt_inicial.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.txt_4c__dt_final.Value)
            MsgAviso("Data final " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                     "Comiss" + CHR(227) + "o")
            THIS.txt_4c__dt_final.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.txt_4c__dt_inicial.Value > THIS.txt_4c__dt_final.Value
            MsgAviso("Data inicial n" + CHR(227) + "o pode ser maior que a data final.", ;
                     "Comiss" + CHR(227) + "o")
            THIS.txt_4c__dt_inicial.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.txt_4c_Cmoeda.Value))
            MsgAviso("Moeda " + CHR(233) + " obrigat" + CHR(243) + "ria para convers" + ;
                     CHR(227) + "o de valores.", "Comiss" + CHR(227) + "o")
            THIS.txt_4c_Cmoeda.SetFocus()
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF THIS.ValidarFiltros()
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Visualizar()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Impressao com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF THIS.ValidarFiltros()
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Imprimir()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta cursor tempo para planilha XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo, loc_oErro
        loc_cArquivo = ""

        TRY
            IF THIS.ValidarFiltros()
                THIS.FormParaRelatorio()
                IF THIS.this_oRelatorio.PrepararDados()
                    IF USED("tempo") AND RECCOUNT("tempo") > 0
                        loc_cArquivo = ADDBS(SYS(2023)) + "Comissao_" + DTOS(DATE()) + ;
                                       "_" + STRTRAN(TIME(), ":", "") + ".xls"
                        SELECT tempo
                        COPY TO (loc_cArquivo) TYPE XLS

                        IF FILE(loc_cArquivo)
                            DECLARE INTEGER ShellExecute IN shell32.dll ;
                                INTEGER hndWin, STRING cAction, ;
                                STRING cFileName, STRING cParams, ;
                                STRING cDir, INTEGER nShowWin
                            ShellExecute(0, "open", loc_cArquivo, "", "", 1)
                        ELSE
                            MsgErro("Erro ao gerar arquivo Excel.", "Comiss" + CHR(227) + "o")
                        ENDIF
                    ELSE
                        MsgAviso("Nenhum dado para exportar.", "Comiss" + CHR(227) + "o")
                    ENDIF
                ELSE
                    MsgErro("Erro ao preparar dados: " + THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Comiss" + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrecsm.BtnExcelClick")
        ENDTRY

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Redefine todos os filtros para os valores padrao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.txt_4c__dt_inicial.Value    = DATE()
        THIS.txt_4c__dt_final.Value      = DATE()
        THIS.txt_4c__empresa.Value       = ""
        THIS.txt_4c__empresa_desc.Value  = ""
        THIS.txt_4c__Cd_GrEstoque.Value  = ""
        THIS.txt_4c__Ds_GrEstoque.Value  = ""
        THIS.txt_4c__cd_estoque.Value    = ""
        THIS.txt_4c__ds_estoque.Value    = ""
        THIS.txt_4c_Cmoeda.Value         = ""
        THIS.txt_4c_Dmoeda.Value         = ""
        THIS.obj_4c_OptRel.Value         = 1
        THIS.chk_4c_FwChkComissao.Value  = 0
        THIS.AtualizarEstados()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Em REPORT: todos os filtros ficam editaveis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos()
        THIS.txt_4c__dt_inicial.ReadOnly = .F.
        THIS.txt_4c__dt_final.ReadOnly   = .F.
        THIS.txt_4c__empresa.ReadOnly    = .F.
        THIS.txt_4c_Cmoeda.ReadOnly      = .F.
        THIS.txt_4c__Cd_GrEstoque.ReadOnly = .F.
        THIS.AtualizarEstados()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em REPORT: nao ha grid de lista; retorna .T. por contrato
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT: botoes permanecem sempre no mesmo estado
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Delega a FormParaRelatorio (contrato FormBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega propriedades do BO de volta para os controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.txt_4c__dt_inicial.Value    = THIS.this_oRelatorio.this_dDtInicial
            THIS.txt_4c__dt_final.Value      = THIS.this_oRelatorio.this_dDtFinal
            THIS.txt_4c__empresa.Value       = THIS.this_oRelatorio.this_cCemps
            THIS.txt_4c__empresa_desc.Value  = THIS.this_oRelatorio.this_cRazas
            THIS.txt_4c__Cd_GrEstoque.Value  = THIS.this_oRelatorio.this_cCdGrEstoque
            THIS.txt_4c__Ds_GrEstoque.Value  = THIS.this_oRelatorio.this_cDsGrEstoque
            THIS.txt_4c__cd_estoque.Value    = THIS.this_oRelatorio.this_cCdEstoque
            THIS.txt_4c__ds_estoque.Value    = THIS.this_oRelatorio.this_cDsEstoque
            THIS.txt_4c_Cmoeda.Value         = THIS.this_oRelatorio.this_cCmoes
            THIS.txt_4c_Dmoeda.Value         = THIS.this_oRelatorio.this_cDmoes
            THIS.obj_4c_OptRel.Value         = THIS.this_oRelatorio.this_nOptRel
            THIS.chk_4c_FwChkComissao.Value  = IIF(THIS.this_oRelatorio.this_lChkComissao, 1, 0)
            THIS.AtualizarEstados()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT: limpa filtros para nova consulta
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.LimparCampos()
        THIS.AtualizarEstados()
        THIS.Refresh()
        IF TYPE("THIS.txt_4c__dt_inicial") = "O"
            THIS.txt_4c__dt_inicial.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT: executa preview com filtros atuais
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        IF THIS.ValidarFiltros()
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Visualizar()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em REPORT: foca o primeiro filtro para reedicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.AtualizarEstados()
        THIS.Refresh()
        IF TYPE("THIS.txt_4c__dt_inicial") = "O"
            THIS.txt_4c__dt_inicial.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em REPORT: descarta cursores de dados gerados
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF USED("tempo")
            USE IN tempo
        ENDIF
        IF USED("tempo2")
            USE IN tempo2
        ENDIF
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_cMensagemErro = ""
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT: nao se aplica
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        MsgAviso("Este relat" + CHR(243) + "rio n" + CHR(227) + "o possui " + ;
                 "opera" + CHR(231) + CHR(227) + "o de salvamento." + CHR(13) + ;
                 "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
                 "Comiss" + CHR(227) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT: fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o BO de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
