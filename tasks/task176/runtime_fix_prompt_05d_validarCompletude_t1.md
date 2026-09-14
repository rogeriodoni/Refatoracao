# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formsigprenv.prg] Indicador de pendencia: * BtnExcluirClick - Cancelar/limpar impressao pendente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprenv.prg):
*==============================================================================
* Formsigprenv.prg - Impressao de Etiquetas de Envelopes
* Form OPERACIONAL (layout flat, sem PageFrame CRUD)
* Migrado de: sigprenv.SCX
* BO: sigprenvBO.prg
* Fase 8/8: COMPLETO (FormParaBO/BOParaForm/HabilitarCampos/LimparCampos/CarregarLista/AjustarBotoesPorModo/BtnBuscarClick/BtnSalvarClick/BtnCancelarClick)
*==============================================================================

DEFINE CLASS Formsigprenv AS FormBase
    DataSession = 2
    ShowWindow = 1
    WindowType = 1

    *-- Business Object
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO e layout base
    * Chamado por FormBase.Init() via DODEFAULT()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Propriedades visuais do form (original: 800x400 flat, sem titlebar)
            THIS.Width       = 1000
            THIS.Height      = 500
            THIS.AutoCenter  = .T.
            THIS.BorderStyle = 2
            THIS.TitleBar    = 0
            THIS.ControlBox  = .F.
            THIS.MaxButton   = .F.
            THIS.MinButton   = .F.
            THIS.WindowType  = 1
            THIS.ShowTips    = .T.
            THIS.FontName    = "Tahoma"
            THIS.FontSize    = 8
            THIS.Caption     = "Impress" + CHR(227) + "o de etiquetas de envelopes"

            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("sigprenvBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Layout base
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarDados()
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar sigprenvBO.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao inicializar form")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestra layout do form OPERACIONAL (flat)
    * Form OPERACIONAL nao tem PageFrame - "PaginaLista" agrupa botoes de acao
    * (CommandGroup Imprimir/Encerrar) e "PaginaDados" agrupa campos de entrada
    * (Etiqueta Inicial/Quantidade, Tipo de Etiqueta, Impressora, Ajustes).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Form OPERACIONAL nao alterna paginas (compatibilidade FormBase)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cntSombra do original
    * Top=0, Left=0, Width=800, Height=80, BackColor=100,100,100
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
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona controles principais do form OPERACIONAL
    * Botoes Imprimir/Encerrar, campos de etiqueta, tipos e sele??o de impressora
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oErro
        TRY
            *-- CommandGroup: Imprimir + Encerrar (lado direito, topo)
            THIS.AddObject("obj_4c_BtnReport", "CommandGroup")
            WITH THIS.obj_4c_BtnReport
                .Top           = 0
                .Left          = 820
                .Width         = 171
                .Height        = 110
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .Themes        = .F.
                .ButtonCount   = 2
                .Visible       = .T.

                WITH .Buttons(1)
                    .Caption         = "\<Imprimir"
                    .Top             = 5
                    .Left            = 10
                    .Width           = 75
                    .Height          = 75
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Picture         = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
                    .PicturePosition = 13
                    .WordWrap        = .T.
                    .MousePointer    = 15
                ENDWITH

                WITH .Buttons(2)
                    .Caption         = "Encerrar"
                    .Top             = 5
                    .Left            = 86
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .Cancel          = .T.
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .PicturePosition = 13
                    .WordWrap        = .T.
                    .MousePointer    = 15
                    .ToolTipText     = "[ESC] - Sair"
                ENDWITH
            ENDWITH

            *-- Label "Impressora"
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .Top       = 167
                .Left      = 409
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Impressora "
                .Visible   = .T.
            ENDWITH

            *-- OptionGroup Impressora (ButtonCount dinamico - populado em CarregarDados)
            THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
            WITH THIS.obj_4c_Opt_Impressora
                .Top           = 180
                .Left          = 396
                .Width         = 254
                .Height        = 30
                .BackStyle     = 0
                .SpecialEffect = 1
                .Themes        = .F.
                .ButtonCount   = 1
                .Value         = 1
                .Enabled       = .F.
                .Visible       = .T.
                WITH .Buttons(1)
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = "1. Gen" + CHR(233) + "rico/Somente Texto"
                    .Height    = 17
                    .Left      = 10
                    .Top       = 10
                    .Width     = 238
                ENDWITH
            ENDWITH

            *-- Container de configuracoes da impressora (Cnt_Impressora)
            THIS.AddObject("cnt_4c__Impressora", "Container")
            WITH THIS.cnt_4c__Impressora
                .Top       = 289
                .Left      = 396
                .Width     = 254
                .Height    = 67
                .BackStyle = 0
                .Visible   = .T.

                *-- OptionGroup tipo de impressao: Allegro / Zebra ZPL / Zebra EPL
                .AddObject("obj_4c_Opcao_imp", "OptionGroup")
                WITH .obj_4c_Opcao_imp
                    .Top         = 3
                    .Left        = 3
                    .Width       = 249
                    .Height      = 22
                    .BackStyle   = 0
                    .ButtonCount = 3
                    .Value       = 1
                    .Visible     = .T.
                    WITH .Buttons(1)
                        .BackStyle = 0
                        .ForeColor = RGB(90, 90, 90)
                        .Caption   = "Allegro"
                        .Left      = 3
                        .Top       = 4
                        .Width     = 51
                    ENDWITH
                    WITH .Buttons(2)
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .BackStyle = 0
                        .ForeColor = RGB(90, 90, 90)
                        .Caption   = "Zebra ZPL"
                        .Left      = 77
                        .Top       = 4
                        .Width     = 66
                        .Themes    = .F.
                    ENDWITH
                    WITH .Buttons(3)
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .BackStyle = 0
                        .ForeColor = RGB(90, 90, 90)
                        .Caption   = "Zebra EPL"
                        .Left      = 170
                        .Top       = 4
                        .Width     = 66
                        .Themes    = .F.
                    ENDWITH
                ENDWITH

                *-- Labels dos spinners de ajuste
                .AddObject("lbl_4c_LblVertical", "Label")
                WITH .lbl_4c_LblVertical
                    .Top       = 25
                    .Left      = 12
                    .Width     = 55
                    .Height    = 13
                    .AutoSize  = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 7
                    .BackStyle = 0
                    .Caption   = "Vertical"
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_LblHorizontal", "Label")
                WITH .lbl_4c_LblHorizontal
                    .Top       = 25
                    .Left      = 72
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 7
                    .BackStyle = 0
                    .Caption   = "Horizontal"
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_LblDensidade", "Label")
                WITH .lbl_4c_LblDensidade
                    .Top       = 25
                    .Left      = 132
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 7
                    .BackStyle = 0
                    .Caption   = "Densidade"
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_LblVelocidade", "Label")
                WITH .lbl_4c_LblVelocidade
                    .Top       = 25
                    .Left      = 192
                    .AutoSize  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 7
                    .BackStyle = 0
                    .Caption   = "Velocidade"
                    .Visible   = .T.
                ENDWITH

                *-- Spinner Ajuste Vertical
                .AddObject("obj_4c_Spn_AjVerts", "Spinner")
                WITH .obj_4c_Spn_AjVerts
                    .Top               = 36
                    .Left              = 10
                    .Width             = 56
                    .Height            = 26
                    .FontName          = "Tahoma"
                    .KeyboardHighValue = 999
                    .KeyboardLowValue  = 0
                    .SpinnerHighValue  = 999
                    .SpinnerLowValue   = 0
                    .Value             = 0
                    .Visible           = .T.
                ENDWITH

                *-- Spinner Ajuste Horizontal
                .AddObject("obj_4c_Spn_AjHorzs", "Spinner")
                WITH .obj_4c_Spn_AjHorzs
                    .Top               = 36
                    .Left              = 71
                    .Width             = 56
                    .Height            = 26
                    .FontName          = "Tahoma"
                    .KeyboardHighValue = 999
                    .KeyboardLowValue  = 0
                    .SpinnerHighValue  = 999
                    .SpinnerLowValue   = 0
                    .Value             = 0
                    .Visible           = .T.
                ENDWITH

                *-- Spinner Ajuste Densidade (10..20)
                .AddObject("obj_4c_Spn_AjDenss", "Spinner")
                WITH .obj_4c_Spn_AjDenss
                    .Top               = 36
                    .Left              = 132
                    .Width             = 56
                    .Height            = 26
                    .FontName          = "Tahoma"
                    .KeyboardHighValue = 20
                    .KeyboardLowValue  = 10
                    .SpinnerHighValue  = 20
                    .SpinnerLowValue   = 10
                    .Value             = 10
                    .Visible           = .T.
                ENDWITH

                *-- Spinner Ajuste Velocidade (1..3)
                .AddObject("obj_4c_Spn_AjVelos", "Spinner")
                WITH .obj_4c_Spn_AjVelos
                    .Top               = 36
                    .Left              = 192
                    .Width             = 54
                    .Height            = 26
                    .FontName          = "Tahoma"
                    .KeyboardHighValue = 3
                    .KeyboardLowValue  = 1
                    .SpinnerHighValue  = 3
                    .SpinnerLowValue   = 1
                    .Value             = 3
                    .Visible           = .T.
                ENDWITH
            ENDWITH

            *-- BINDEVENTs de botoes e selecao de impressora
            BINDEVENT(THIS.obj_4c_BtnReport.Buttons(1), "Click", THIS, "BtnImprimeClick")
            BINDEVENT(THIS.obj_4c_BtnReport.Buttons(2), "Click", THIS, "BtnEncerrarClick")
            BINDEVENT(THIS.obj_4c_Opt_Impressora, "InteractiveChange", THIS, "OptImpressoraInteractiveChange")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao configurar layout")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona campos de entrada de dados do form
    * Form OPERACIONAL flat: agrupa campos de entrada (Etiqueta Inicial/Quantidade,
    * OptionGroup Tipo de Etiqueta). Impressora + Container de ajustes ficam em
    * ConfigurarPaginaLista (junto com botoes de acao) por serem parte do bloco
    * de configuracao de impressao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro
        TRY
            *-- Label "Etiqueta Inicial :"
            THIS.AddObject("lbl_4c_Lbl_Etq", "Label")
            WITH THIS.lbl_4c_Lbl_Etq
                .Top       = 129
                .Left      = 155
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Etiqueta Inicial :"
                .Visible   = .T.
            ENDWITH

            *-- TextBox Etiqueta Inicial (valor inicial da numeracao das etiquetas)
            THIS.AddObject("txt_4c_Etq_Ini", "TextBox")
            WITH THIS.txt_4c_Etq_Ini
                .Top                = 125
                .Left               = 237
                .Width              = 66
                .Height             = 23
                .FontName           = "Tahoma"
                .InputMask          = "99999999"
                .DisabledBackColor  = RGB(255, 255, 255)
                .Value              = 1
                .Visible            = .T.
            ENDWITH

            *-- Label "Quantidade :"
            THIS.AddObject("lbl_4c_Lbl_Qtd", "Label")
            WITH THIS.lbl_4c_Lbl_Qtd
                .Top       = 129
                .Left      = 328
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Quantidade :"
                .Visible   = .T.
            ENDWITH

            *-- TextBox Quantidade (quantas etiquetas serao impressas)
            THIS.AddObject("txt_4c_Etq_Qtd", "TextBox")
            WITH THIS.txt_4c_Etq_Qtd
                .Top       = 125
                .Left      = 397
                .Width     = 66
                .Height    = 23
                .FontName  = "Tahoma"
                .Alignment = 1
                .Format    = "K!"
                .InputMask = "99999999"
                .MaxLength = 8
                .Value     = 0
                .Visible   = .T.
            ENDWITH

            *-- Label "Tipo de etiqueta"
            THIS.AddObject("lbl_4c_Lbl_TpEti", "Label")
            WITH THIS.lbl_4c_Lbl_TpEti
                .Top       = 166
                .Left      = 150
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Tipo de etiqueta "
                .Visible   = .T.
            ENDWITH

            *-- OptionGroup Tipo de Etiqueta (ButtonCount dinamico - populado em CarregarDados)
            THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
            WITH THIS.obj_4c_Opt_Tipo
                .Top           = 179
                .Left          = 140
                .Width         = 240
                .Height        = 30
                .BackStyle     = 0
                .SpecialEffect = 1
                .Themes        = .F.
                .ButtonCount   = 1
                .Value         = 1
                .Enabled       = .F.
                .Visible       = .T.
                WITH .Buttons(1)
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Caption   = ""
                    .Height    = 22
                    .Left      = 10
                    .Top       = 10
                    .Width     = 222
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao configurar campos de dados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Popula controles dinamicos (tipos de etiqueta e impressoras)
    * Executa queries SQL e constroi buttons dos OptionGroups dinamicamente
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_oErro, loc_laPrinters(1, 2), loc_nPrinters
        LOCAL loc_nTipos, loc_nI, loc_nTop, loc_nHeight
        LOCAL loc_nBottom1, loc_nBottom2, loc_nImpres, loc_nOk, loc_nPIdx
        LOCAL loc_cCaption, loc_cTag, loc_cImpres, loc_laImpOk(1), loc_nJ

        TRY
            *-- Carregar configuracoes de SigCdPam e SigCdPac
            THIS.this_oBusinessObject.CarregarConfiguracoes()
            THIS.this_oBusinessObject.CarregarTiposEtiqueta()

            *-- Construir botoes de tipo de etiqueta
            loc_nTop    = 10
            loc_nHeight = 40

            IF THIS.this_oBusinessObject.this_lTiposOk
                loc_nTipos = THIS.this_oBusinessObject.this_nTotalTipos
                THIS.obj_4c_Opt_Tipo.ButtonCount = ;
                    MIN(loc_nTipos, MAX(THIS.this_oBusinessObject.this_nMaxTpEtis, 5))

                SELECT cursor_4c_SigCdTpe
                GO TOP
                loc_nI = 1
                SCAN WHILE loc_nI <= THIS.obj_4c_Opt_Tipo.ButtonCount
                    loc_cCaption = "\<" + CHR(96 + loc_nI) + ". " + ALLTRIM(cursor_4c_SigCdTpe.cetiquetas)
                    loc_cTag     = ALLTRIM(STR(cursor_4c_SigCdTpe.ntipos))
                    WITH THIS.obj_4c_Opt_Tipo.Buttons(loc_nI)
                        .AutoSize  = .F.
                        .Width     = 160
                        .Caption   = loc_cCaption
                        .FontSize  = 8
                        .Tag       = loc_cTag
                        .Top       = loc_nTop
                        .FontName  = "Tahoma"
                        .BackStyle = 0
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    loc_nTop    = loc_nTop + 20
                    loc_nHeight = loc_nHeight + 20
                    loc_nI      = loc_nI + 1
                ENDSCAN

                THIS.obj_4c_Opt_Tipo.Enabled = (THIS.obj_4c_Opt_Tipo.ButtonCount > 1)
                THIS.obj_4c_Opt_Tipo.Height  = loc_nHeight
                THIS.obj_4c_Opt_Tipo.Value   = 1
            ELSE
                *-- Nenhum tipo: exibir "Envelope" como padrao
                THIS.obj_4c_Opt_Tipo.ButtonCount = 1
                WITH THIS.obj_4c_Opt_Tipo.Buttons(1)
                    .AutoSize  = .F.
                    .Width     = 160
                    .Caption   = "\<1. Envelope"
                    .FontSize  = 8
                    .Tag       = ALLTRIM(STR(6))
                    .Top       = 10
                    .FontName  = "Tahoma"
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH
                THIS.obj_4c_Opt_Tipo.Enabled = .F.
                THIS.obj_4c_Opt_Tipo.Height  = 30
                THIS.obj_4c_Opt_Tipo.Value   = 1
            ENDIF

            loc_nBottom1 = THIS.obj_4c_Opt_Tipo.Top + THIS.obj_4c_Opt_Tipo.Height

            *-- Carregar impressoras acessiveis pelo usuario logado
            THIS.this_oBusinessObject.CarregarImpressoras()

            *-- Obter lista de impressoras instaladas no sistema
            loc_nPrinters = APRINTERS(loc_laPrinters)

            *-- Identificar impressoras validas (tipo 2 + instaladas no sistema)
            loc_nImpres = 0

            IF USED("cursor_4c_ImpAcessiveis") AND !EOF("cursor_4c_ImpAcessiveis")
                SELECT cursor_4c_ImpAcessiveis
                GO TOP
                SCAN FOR cursor_4c_ImpAcessiveis.ntpimpres = 2
                    loc_cImpres = cursor_4c_ImpAcessiveis.impres
                    IF loc_nPrinters > 0
                        loc_nOk = 0
                        FOR loc_nPIdx = 1 TO loc_nPrinters
                            IF UPPER(ALLTRIM(loc_laPrinters(loc_nPIdx, 1))) == ;
                               UPPER(ALLTRIM(loc_cImpres))
                                loc_nOk = loc_nPIdx
                                EXIT
                            ENDIF
                        ENDFOR
                        IF loc_nOk > 0
                            loc_nImpres = loc_nImpres + 1
                            DIMENSION loc_laImpOk(loc_nImpres)
                            loc_laImpOk(loc_nImpres) = loc_laPrinters(loc_nOk, 1)
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Construir botoes de selecao de impressora
            loc_nTop    = 10
            loc_nHeight = 15

            IF loc_nImpres > 0
                THIS.obj_4c_Opt_Impressora.ButtonCount = ;
                    MIN(loc_nImpres, MAX(THIS.this_oBusinessObject.this_nMaxImpEti, 5))

                FOR loc_nJ = 1 TO THIS.obj_4c_Opt_Impressora.ButtonCount
                    WITH THIS.obj_4c_Opt_Impressora.Buttons(loc_nJ)
                        .AutoSize  = .F.
                        .Caption   = " \<" + ALLTRIM(STR(loc_nJ)) + ". " + loc_laImpOk(loc_nJ)
                        .FontSize  = 8
                        .Tag       = UPPER(loc_laImpOk(loc_nJ))
                        .Top       = loc_nTop
                        .Width     = 160
                        .FontName  = "Tahoma"
                        .BackStyle = 0
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    loc_nTop    = loc_nTop + 20
                    loc_nHeight = loc_nHeight + 20
                ENDFOR

                THIS.obj_4c_Opt_Impressora.Enabled = (loc_nImpres > 1)
                THIS.obj_4c_Opt_Impressora.Height  = loc_nHeight
                THIS.obj_4c_Opt_Impressora.Value   = 1
            ELSE
                *-- Nenhuma impressora tipo 2: exibir "Generico/Somente Texto"
                loc_nOk = 0
                FOR loc_nPIdx = 1 TO loc_nPrinters
                    IF "GENERICO" $ UPPER(ALLTRIM(loc_laPrinters(loc_nPIdx, 1)))
                        loc_nOk = loc_nPIdx
                        EXIT
                    ENDIF
                ENDFOR

                THIS.obj_4c_Opt_Impressora.ButtonCount = 1
                WITH THIS.obj_4c_Opt_Impressora.Buttons(1)
                    .AutoSize  = .F.
                    .Caption   = " \<0. Gen" + CHR(233) + "rico/Somente Texto"
                    .Enabled   = (loc_nOk > 0)
                    .FontSize  = 8
                    .Tag       = "GEN" + CHR(201) + "RICO/SOMENTE TEXTO"
                    .Width     = 160
                    .FontName  = "Tahoma"
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH
                THIS.obj_4c_Opt_Impressora.Enabled = (loc_nOk > 0)
                THIS.obj_4c_Opt_Impressora.Height  = 35
                THIS.obj_4c_Opt_Impressora.Value   = 1
            ENDIF

            *-- Posicionar cnt_4c__Impressora logo abaixo de obj_4c_Opt_Impressora
            THIS.cnt_4c__Impressora.Top = THIS.obj_4c_Opt_Impressora.Top + ;
                                           THIS.obj_4c_Opt_Impressora.Height - 2
            loc_nBottom2 = THIS.cnt_4c__Impressora.Top + THIS.cnt_4c__Impressora.Height

            *-- Inicializar spinners e opcao de impressao com valores de SigCdPam/SigCdPac
            WITH THIS.cnt_4c__Impressora
                .obj_4c_Opcao_imp.Value   = IIF(THIS.this_oBusinessObject.this_nImpEtis <> 0, ;
                                                THIS.this_oBusinessObject.this_nImpEtis, 1)
                .obj_4c_Opcao_imp.Enabled  = .F.
                .obj_4c_Spn_AjVerts.Value  = THIS.this_oBusinessObject.this_nAjVertsPad
                .obj_4c_Spn_AjHorzs.Value  = THIS.this_oBusinessObject.this_nAjHorzsPad
                .obj_4c_Spn_AjDenss.Value  = THIS.this_oBusinessObject.this_nAjDensPad
                .obj_4c_Spn_AjVelos.Value  = THIS.this_oBusinessObject.this_nAjVelosPad
                .Visible     = .T.
            ENDWITH

            *-- Habilitar botao Imprimir somente se ha tipos e impressoras disponiveis
            THIS.obj_4c_BtnReport.Buttons(1).Enabled = ;
                (THIS.this_oBusinessObject.this_lTiposOk AND loc_nImpres > 0)

            *-- Valor inicial da etiqueta
            THIS.txt_4c_Etq_Ini.Value = 1

            *-- Ajustar altura do form para acomodar botoes dinamicos
            THIS.Height = MAX(loc_nBottom1, loc_nBottom2) + 20

            *-- Carregar configuracoes da primeira impressora selecionada
            THIS.OptImpressoraInteractiveChange()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao carregar dados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimeClick - Valida e executa a impressao de etiquetas de envelope
    * Chama SigOpEtq do Framework via proxy pnIdconn
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimeClick()
        LOCAL loc_lSucesso, loc_oErro, loc_nIni, loc_nQtd
        LOCAL loc_nTpImp, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, loc_nAjVelos
        LOCAL loc_cNomeImp, loc_nImpres, loc_oDataMgr
        loc_lSucesso = .F.

        TRY
            loc_nQtd = THIS.txt_4c_Etq_Qtd.Value

            IF loc_nQtd <= 0
                MsgAviso("A Quantidade de Etiquetas Precisa Ser Maior Que 0 (Zero)!!!")
                THIS.txt_4c_Etq_Qtd.SetFocus()
            ELSE
                IF MsgConfirma("Confirma a Impress" + CHR(227) + "o Das Etiquetas ?", "Confirmar")
                    loc_nIni = THIS.txt_4c_Etq_Ini.Value

                    IF THIS.this_oBusinessObject.PrepararCursorImpressao(loc_nIni, loc_nQtd)
                        *-- Obter configuracoes de impressao atuais
                        WITH THIS.cnt_4c__Impressora
                            loc_nTpImp   = .obj_4c_Opcao_imp.Value
                            loc_nAjVerts = .obj_4c_Spn_AjVerts.Value
                            loc_nAjHorzs = .obj_4c_Spn_AjHorzs.Value
                            loc_nAjDenss = .obj_4c_Spn_AjDenss.Value
                            loc_nAjVelos = .obj_4c_Spn_AjVelos.Value
                            .Visible     = .T.
                        ENDWITH

                        loc_nImpres  = THIS.obj_4c_Opt_Impressora.Value
                        loc_cNomeImp = THIS.obj_4c_Opt_Impressora.Buttons(loc_nImpres).Tag

                        *-- Proxy minimo para compatibilidade com SigOpEtq (espera pnIdconn)
                        loc_oDataMgr = CREATEOBJECT("Empty")
                        ADDPROPERTY(loc_oDataMgr, "pnIdconn", gnConnHandle)
                        ADDPROPERTY(loc_oDataMgr, "pnIdConn", gnConnHandle)

                        *-- Executar impressao via funcao do Framework (requer SigOpEtq.prg)
                        SigOpEtq(loc_oDataMgr, .F., .F., 6, ;
                                 loc_nTpImp, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, ;
                                 .NULL., .NULL., .NULL., loc_cNomeImp, .NULL., .NULL., loc_nAjVelos)

                        MsgInfo("Impress" + CHR(227) + "o conclu" + CHR(237) + "da com sucesso!")

                        *-- Atualizar etiqueta inicial e zerar quantidade
                        THIS.txt_4c_Etq_Ini.Value = loc_nIni + loc_nQtd
                        THIS.txt_4c_Etq_Qtd.Value = 0
                        THIS.txt_4c_Etq_Ini.Refresh()
                        THIS.txt_4c_Etq_Qtd.Refresh()

                        THIS.this_oBusinessObject.LimparCursorImpressao()
                        THIS.txt_4c_Etq_Qtd.SetFocus()
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao imprimir etiquetas")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * OptImpressoraInteractiveChange - Atualiza spinners ao trocar impressora
    *--------------------------------------------------------------------------
    PROCEDURE OptImpressoraInteractiveChange()
        LOCAL loc_oErro, loc_nImpres, loc_cNomeImp, loc_lValido
        loc_lValido = .F.

        TRY
            IF VARTYPE(THIS.obj_4c_Opt_Impressora) = "O"
                loc_nImpres = THIS.obj_4c_Opt_Impressora.Value
                IF loc_nImpres >= 1 AND loc_nImpres <= THIS.obj_4c_Opt_Impressora.ButtonCount
                    loc_cNomeImp = ALLTRIM(THIS.obj_4c_Opt_Impressora.Buttons(loc_nImpres).Tag)
                    IF !EMPTY(loc_cNomeImp)
                        THIS.this_oBusinessObject.CarregarConfigImpressora(loc_cNomeImp)
                        WITH THIS.cnt_4c__Impressora
                            .obj_4c_Opcao_imp.Value   = THIS.this_oBusinessObject.this_nTpImp
                            .obj_4c_Spn_AjVerts.Value = THIS.this_oBusinessObject.this_nAjVerts
                            .obj_4c_Spn_AjHorzs.Value = THIS.this_oBusinessObject.this_nAjHorzs
                            .obj_4c_Spn_AjDenss.Value = THIS.this_oBusinessObject.this_nAjDenss
                            .obj_4c_Spn_AjVelos.Value = THIS.this_oBusinessObject.this_nAjVelos
                            .Visible     = .T.
                        ENDWITH
                        loc_lValido = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                    "Erro ao carregar configura" + CHR(231) + CHR(245) + "es da impressora")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Iniciar nova impressao (form OPERACIONAL)
    * Mapeia para: incluir novo lote de etiquetas na fila de impressao.
    * Zera a quantidade, avanca a etiqueta inicial para o proximo bloco livre
    * e devolve o foco para o campo Quantidade.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro, loc_nProxIni

        TRY
            *-- Se ha quantidade digitada, avancar a etiqueta inicial
            IF THIS.txt_4c_Etq_Qtd.Value > 0
                loc_nProxIni = THIS.txt_4c_Etq_Ini.Value + THIS.txt_4c_Etq_Qtd.Value
                THIS.txt_4c_Etq_Ini.Value = loc_nProxIni
            ENDIF

            *-- Zerar quantidade para novo lote
            THIS.txt_4c_Etq_Qtd.Value = 0
            THIS.txt_4c_Etq_Ini.Refresh()
            THIS.txt_4c_Etq_Qtd.Refresh()

            *-- Habilitar campos de entrada
            THIS.txt_4c_Etq_Ini.Enabled = .T.
            THIS.txt_4c_Etq_Qtd.Enabled = .T.

            *-- Liberar cursor de impressao previa (se houver)
            THIS.this_oBusinessObject.LimparCursorImpressao()

            *-- Focar quantidade para digitacao
            THIS.txt_4c_Etq_Qtd.SetFocus()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao iniciar novo lote")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar parametros de impressao (form OPERACIONAL)
    * Mapeia para: habilitar edicao dos ajustes (spinners) e OptionGroup de
    * tipo de impressao para que o usuario possa modificar os valores padrao
    * carregados de SigCdPam/SigCdPac antes de imprimir.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            *-- Habilitar campos de entrada
            THIS.txt_4c_Etq_Ini.Enabled = .T.
            THIS.txt_4c_Etq_Qtd.Enabled = .T.

            *-- Habilitar OptionGroups de tipo de etiqueta e impressora
            IF THIS.obj_4c_Opt_Tipo.ButtonCount > 1
                THIS.obj_4c_Opt_Tipo.Enabled = .T.
            ENDIF
            IF THIS.obj_4c_Opt_Impressora.ButtonCount > 1
                THIS.obj_4c_Opt_Impressora.Enabled = .T.
            ENDIF

            *-- Habilitar ajustes da impressora (spinners e tipo de impressao)
            WITH THIS.cnt_4c__Impressora
                .obj_4c_Opcao_imp.Enabled  = .T.
                .obj_4c_Spn_AjVerts.Enabled = .T.
                .obj_4c_Spn_AjHorzs.Enabled = .T.
                .obj_4c_Spn_AjDenss.Enabled = .T.
                .obj_4c_Spn_AjVelos.Enabled = .T.
                .Visible     = .T.
            ENDWITH

            *-- Focar tipo de impressao para inicio da alteracao
            THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.SetFocus()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao habilitar altera" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar impressao (form OPERACIONAL)
    * Mapeia para: preparar o cursor de impressao sem enviar para a impressora
    * e apresentar ao usuario o resumo do que sera impresso (faixa de etiquetas
    * + tipo + impressora destino).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_nIni, loc_nQtd, loc_nFim
        LOCAL loc_cResumo, loc_nImpres, loc_cNomeImp, loc_cTpImp
        LOCAL loc_nTipoEtq

        TRY
            loc_nIni = THIS.txt_4c_Etq_Ini.Value
            loc_nQtd = THIS.txt_4c_Etq_Qtd.Value

            IF loc_nQtd <= 0
                MsgAviso("Informe uma quantidade maior que 0 (zero) para visualizar.")
                THIS.txt_4c_Etq_Qtd.SetFocus()
            ELSE
                *-- Preparar cursor sem imprimir (mesma logica do BtnImprime, sem SigOpEtq)
                IF THIS.this_oBusinessObject.PrepararCursorImpressao(loc_nIni, loc_nQtd)
                    loc_nFim     = loc_nIni + loc_nQtd - 1
                    loc_nImpres  = THIS.obj_4c_Opt_Impressora.Value
                    loc_cNomeImp = ALLTRIM(THIS.obj_4c_Opt_Impressora.Buttons(loc_nImpres).Tag)
                    loc_nTipoEtq = THIS.obj_4c_Opt_Tipo.Value

                    DO CASE
                        CASE THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value = 1
                            loc_cTpImp = "Allegro"
                        CASE THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value = 2
                            loc_cTpImp = "Zebra ZPL"
                        CASE THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value = 3
                            loc_cTpImp = "Zebra EPL"
                        OTHERWISE
                            loc_cTpImp = "N" + CHR(227) + "o definido"
                    ENDCASE

                    loc_cResumo = "Pr" + CHR(233) + "-visualiza" + CHR(231) + CHR(227) + "o da impress" + CHR(227) + "o" + CHR(13) + CHR(13) + ;
                                  "Etiqueta inicial : " + TRANSFORM(loc_nIni) + CHR(13) + ;
                                  "Etiqueta final   : " + TRANSFORM(loc_nFim) + CHR(13) + ;
                                  "Quantidade       : " + TRANSFORM(loc_nQtd) + CHR(13) + ;
                                  "Tipo de etiqueta : " + ALLTRIM(TRANSFORM(loc_nTipoEtq)) + CHR(13) + ;
                                  "Modo de impress" + CHR(227) + "o: " + loc_cTpImp + CHR(13) + ;
                                  "Impressora       : " + loc_cNomeImp

                    MsgInfo(loc_cResumo, "Visualiza" + CHR(231) + CHR(227) + "o")

                    *-- Liberar cursor apos preview (usuario ainda pode confirmar impressao)
                    THIS.this_oBusinessObject.LimparCursorImpressao()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao visualizar impress" + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Cancelar/limpar impressao pendente (form OPERACIONAL)
    * Mapeia para: descartar cursor de impressao ja preparado e restaurar
    * valores padrao de spinners e OptionGroups (mesmo comportamento do
    * legado quando o usuario abandona o processo).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro

        TRY
            IF MsgConfirma("Cancelar a impress" + CHR(227) + "o e limpar os valores digitados ?", ;
                           "Confirmar cancelamento")
                *-- Descartar cursor de impressao
                THIS.this_oBusinessObject.LimparCursorImpressao()

                *-- Restaurar valores padrao dos campos de entrada
                THIS.txt_4c_Etq_Ini.Value = 1
                THIS.txt_4c_Etq_Qtd.Value = 0
                THIS.txt_4c_Etq_Ini.Refresh()
                THIS.txt_4c_Etq_Qtd.Refresh()

                *-- Restaurar valores padrao dos ajustes (SigCdPam/SigCdPac)
                WITH THIS.cnt_4c__Impressora
                    .obj_4c_Spn_AjVerts.Value = THIS.this_oBusinessObject.this_nAjVertsPad
                    .obj_4c_Spn_AjHorzs.Value = THIS.this_oBusinessObject.this_nAjHorzsPad
                    .obj_4c_Spn_AjDenss.Value = THIS.this_oBusinessObject.this_nAjDensPad
                    .obj_4c_Spn_AjVelos.Value = THIS.this_oBusinessObject.this_nAjVelosPad
                    .obj_4c_Opcao_imp.Value   = IIF(THIS.this_oBusinessObject.this_nImpEtis <> 0, ;
                                                    THIS.this_oBusinessObject.this_nImpEtis, 1)
                    .Visible     = .T.
                ENDWITH

                *-- Voltar OptionGroups ao primeiro item
                IF THIS.obj_4c_Opt_Tipo.ButtonCount >= 1
                    THIS.obj_4c_Opt_Tipo.Value = 1
                ENDIF
                IF THIS.obj_4c_Opt_Impressora.ButtonCount >= 1
                    THIS.obj_4c_Opt_Impressora.Value = 1
                    THIS.OptImpressoraInteractiveChange()
                ENDIF

                *-- Devolver foco para inicio do fluxo
                THIS.txt_4c_Etq_Qtd.SetFocus()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao cancelar impress" + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do form para o Business Object
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_nTipoVal, loc_nImpVal

        THIS.this_oBusinessObject.this_nEtqIni = THIS.txt_4c_Etq_Ini.Value
        THIS.this_oBusinessObject.this_nEtqQtd = THIS.txt_4c_Etq_Qtd.Value

        loc_nTipoVal = THIS.obj_4c_Opt_Tipo.Value
        THIS.this_oBusinessObject.this_nTipoEtq = loc_nTipoVal
        IF loc_nTipoVal >= 1 AND loc_nTipoVal <= THIS.obj_4c_Opt_Tipo.ButtonCount
            THIS.this_oBusinessObject.this_cTagTipoEtq = ;
                ALLTRIM(THIS.obj_4c_Opt_Tipo.Buttons(loc_nTipoVal).Tag)
        ENDIF

        loc_nImpVal = THIS.obj_4c_Opt_Impressora.Value
        THIS.this_oBusinessObject.this_nImpressora = loc_nImpVal
        IF loc_nImpVal >= 1 AND loc_nImpVal <= THIS.obj_4c_Opt_Impressora.ButtonCount
            THIS.this_oBusinessObject.this_cNomeImpressora = ;
                ALLTRIM(THIS.obj_4c_Opt_Impressora.Buttons(loc_nImpVal).Tag)
        ENDIF

        WITH THIS.cnt_4c__Impressora
            THIS.this_oBusinessObject.this_nTpImp   = .obj_4c_Opcao_imp.Value
            THIS.this_oBusinessObject.this_nAjVerts = .obj_4c_Spn_AjVerts.Value
            THIS.this_oBusinessObject.this_nAjHorzs = .obj_4c_Spn_AjHorzs.Value
            THIS.this_oBusinessObject.this_nAjDenss = .obj_4c_Spn_AjDenss.Value
            THIS.this_oBusinessObject.this_nAjVelos = .obj_4c_Spn_AjVelos.Value
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do Business Object para o form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        THIS.txt_4c_Etq_Ini.Value = THIS.this_oBusinessObject.this_nEtqIni
        THIS.txt_4c_Etq_Qtd.Value = THIS.this_oBusinessObject.this_nEtqQtd

        IF THIS.this_oBusinessObject.this_nTipoEtq >= 1 AND ;
           THIS.this_oBusinessObject.this_nTipoEtq <= THIS.obj_4c_Opt_Tipo.ButtonCount
            THIS.obj_4c_Opt_Tipo.Value = THIS.this_oBusinessObject.this_nTipoEtq
        ENDIF

        IF THIS.this_oBusinessObject.this_nImpressora >= 1 AND ;
           THIS.this_oBusinessObject.this_nImpressora <= THIS.obj_4c_Opt_Impressora.ButtonCount
            THIS.obj_4c_Opt_Impressora.Value = THIS.this_oBusinessObject.this_nImpressora
        ENDIF

        WITH THIS.cnt_4c__Impressora
            .obj_4c_Opcao_imp.Value   = THIS.this_oBusinessObject.this_nTpImp
            .obj_4c_Spn_AjVerts.Value = THIS.this_oBusinessObject.this_nAjVerts
            .obj_4c_Spn_AjHorzs.Value = THIS.this_oBusinessObject.this_nAjHorzs
            .obj_4c_Spn_AjDenss.Value = THIS.this_oBusinessObject.this_nAjDenss
            .obj_4c_Spn_AjVelos.Value = THIS.this_oBusinessObject.this_nAjVelos
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de entrada
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        THIS.txt_4c_Etq_Ini.Enabled = par_lHabilitar
        THIS.txt_4c_Etq_Qtd.Enabled = par_lHabilitar

        IF par_lHabilitar
            THIS.obj_4c_Opt_Tipo.Enabled      = (THIS.obj_4c_Opt_Tipo.ButtonCount > 1)
            THIS.obj_4c_Opt_Impressora.Enabled = (THIS.obj_4c_Opt_Impressora.ButtonCount > 1)
        ELSE
            THIS.obj_4c_Opt_Tipo.Enabled      = .F.
            THIS.obj_4c_Opt_Impressora.Enabled = .F.
        ENDIF

        WITH THIS.cnt_4c__Impressora
            .obj_4c_Opcao_imp.Enabled   = par_lHabilitar
            .obj_4c_Spn_AjVerts.Enabled = par_lHabilitar
            .obj_4c_Spn_AjHorzs.Enabled = par_lHabilitar
            .obj_4c_Spn_AjDenss.Enabled = par_lHabilitar
            .obj_4c_Spn_AjVelos.Enabled = par_lHabilitar
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura campos ao estado inicial padrao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        THIS.txt_4c_Etq_Ini.Value = 1
        THIS.txt_4c_Etq_Qtd.Value = 0
        THIS.txt_4c_Etq_Ini.Refresh()
        THIS.txt_4c_Etq_Qtd.Refresh()

        IF THIS.obj_4c_Opt_Tipo.ButtonCount >= 1
            THIS.obj_4c_Opt_Tipo.Value = 1
        ENDIF
        IF THIS.obj_4c_Opt_Impressora.ButtonCount >= 1
            THIS.obj_4c_Opt_Impressora.Value = 1
            THIS.OptImpressoraInteractiveChange()
        ENDIF

        THIS.this_oBusinessObject.LimparCursorImpressao()
        THIS.txt_4c_Etq_Qtd.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Alias de CarregarDados para compatibilidade com FormBase
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.CarregarDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita botao Imprimir conforme disponibilidade
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lPodeImprimir
        loc_lPodeImprimir = (THIS.this_oBusinessObject.this_lTiposOk AND ;
                             THIS.this_oBusinessObject.this_lImpressorasOk)
        THIS.obj_4c_BtnReport.Buttons(1).Enabled = loc_lPodeImprimir
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega dados de tipos e impressoras do banco
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarDados()
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Alias para BtnImprimeClick (acao principal do OPERACIONAL)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimeClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela operacao em andamento e limpa os campos
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF MsgConfirma("Cancelar a impress" + CHR(227) + "o e limpar os valores digitados ?", ;
                       "Confirmar")
            THIS.LimparCampos()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos e cursores
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cursor_4c_SigCdTpe")
            USE IN cursor_4c_SigCdTpe
        ENDIF
        IF USED("cursor_4c_ImpAcessiveis")
            USE IN cursor_4c_ImpAcessiveis
        ENDIF
        IF USED("cursor_4c_ImpTemp")
            USE IN cursor_4c_ImpTemp
        ENDIF
        IF USED("cursor_4c_ConfigImp")
            USE IN cursor_4c_ConfigImp
        ENDIF
        IF USED("cursor_4c_SigCdPam")
            USE IN cursor_4c_SigCdPam
        ENDIF
        IF USED("cursor_4c_SigCdPac")
            USE IN cursor_4c_SigCdPac
        ENDIF
        IF USED("dbImpressao")
            USE IN dbImpressao
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprenvBO.prg):
*==============================================================================
* sigprenvBO.prg
* Business Object - Impressao de Etiquetas de Envelopes
* Tipo: OPERACIONAL
* Migrado de: sigprenv.SCX
*==============================================================================

DEFINE CLASS sigprenvBO AS BusinessBase

    *-- Campos de entrada do usuario
    this_nEtqIni           = 1     && Etiqueta Inicial
    this_nEtqQtd           = 0     && Quantidade de etiquetas

    *-- Selecao de tipo de etiqueta (Opt_Tipo)
    this_nTipoEtq          = 1     && Value do OptionGroup de tipo
    this_cTagTipoEtq       = ""    && Tag da opcao selecionada (nTipos como string)

    *-- Selecao de impressora (Opt_Impressora)
    this_nImpressora       = 1     && Value do OptionGroup de impressora
    this_cNomeImpressora   = ""    && Tag/nome da impressora selecionada

    *-- Configuracoes de impressao (Cnt_Impressora)
    this_nTpImp            = 1     && Tipo: 1=Allegro, 2=Zebra ZPL, 3=Zebra EPL
    this_nAjVerts          = 0     && Ajuste Vertical (Spn_AjVerts)
    this_nAjHorzs          = 0     && Ajuste Horizontal (Spn_AjHorzs)
    this_nAjDenss          = 10    && Ajuste Densidade (Spn_AjDenss)
    this_nAjVelos          = 3     && Ajuste Velocidade (spn_AjVelos)

    *-- Flags de estado
    this_lImpressorasOk    = .F.   && .T. se ha impressoras disponiveis
    this_lTiposOk          = .F.   && .T. se ha tipos de etiqueta configurados
    this_nTotalTipos       = 0     && Total de tipos de etiqueta disponiveis
    this_nTotalImpressoras = 0     && Total de impressoras disponiveis

    *-- Configuracoes lidas de SigCdPam/SigCdPac
    this_nMaxTpEtis        = 5     && Maximo de tipos de etiqueta (SigCdPam.nMaxTpEtis)
    this_nMaxImpEti        = 5     && Maximo de impressoras para etiqueta (SigCdPam.nMaxImpEti)
    this_nImpEtis          = 1     && Tipo de impressao padrao (SigCdPam.ImpEtis)
    this_nAjVertsPad       = 0     && Ajuste vertical padrao (SigCdPam.AjVerts)
    this_nAjHorzsPad       = 0     && Ajuste horizontal padrao (SigCdPam.AjHorzs)
    this_nAjDensPad        = 10    && Ajuste densidade padrao (SigCdPac.AjDens)
    this_nAjVelosPad       = 1     && Ajuste velocidade padrao (SigCdPac.AjVelos)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO; form operacional sem tabela/chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem chave primaria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia configuracoes de SigCdPam para propriedades
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nMaxTpEtis  = NVL(nmaxtpetis, 5)
            THIS.this_nMaxImpEti  = NVL(nmaximpeti, 5)
            THIS.this_nImpEtis    = NVL(impetis, 1)
            THIS.this_nAjVertsPad = NVL(ajverts, 0)
            THIS.this_nAjHorzsPad = NVL(ajhorzs, 0)
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel para form OPERACIONAL sem tabela principal
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form OPERACIONAL sem tabela principal
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConfiguracoes - Le SigCdPam e SigCdPac, popula propriedades this_
    * Retorna .T. se sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarConfiguracoes()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigCdPam")
                USE IN cursor_4c_SigCdPam
            ENDIF

            loc_cSQL = "SELECT TOP 1 nmaxtpetis, nmaximpeti, impetis, ajverts, ajhorzs, " + ;
                       "tpetipads, tpcbars FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam") > 0
                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    SELECT cursor_4c_SigCdPam
                    THIS.this_nMaxTpEtis  = NVL(nmaxtpetis, 5)
                    THIS.this_nMaxImpEti  = NVL(nmaximpeti, 5)
                    THIS.this_nImpEtis    = NVL(impetis, 1)
                    THIS.this_nAjVertsPad = NVL(ajverts, 0)
                    THIS.this_nAjHorzsPad = NVL(ajhorzs, 0)
                ENDIF
            ENDIF

            IF USED("cursor_4c_SigCdPac")
                USE IN cursor_4c_SigCdPac
            ENDIF

            loc_cSQL = "SELECT TOP 1 ajdens, ajvelos FROM SigCdPac"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac") > 0
                IF USED("cursor_4c_SigCdPac") AND !EOF("cursor_4c_SigCdPac")
                    SELECT cursor_4c_SigCdPac
                    THIS.this_nAjDensPad  = IIF(NVL(ajdens, 0) < 10, 10, NVL(ajdens, 0))
                    THIS.this_nAjVelosPad = IIF(NVL(ajvelos, 0) = 0, 1, NVL(ajvelos, 0))
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar configura" + CHR(231) + CHR(245) + "es")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarTiposEtiqueta - Carrega tipos de etiqueta (ntipos=6, nsituas=1)
    * Cria cursor_4c_SigCdTpe ordenado por cordems
    * Retorna .T. se sucesso (mesmo sem registros)
    *--------------------------------------------------------------------------
    FUNCTION CarregarTiposEtiqueta()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigCdTpe")
                USE IN cursor_4c_SigCdTpe
            ENDIF

            loc_cSQL = "SELECT cetiquetas, ntipos, nsituas, cordems " + ;
                       "FROM SigCdTpe " + ;
                       "WHERE ntipos = 6 AND nsituas = 1 " + ;
                       "ORDER BY cordems"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdTpe") > 0
                SELECT cursor_4c_SigCdTpe
                THIS.this_lTiposOk     = !EOF()
                THIS.this_nTotalTipos  = _TALLY
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar tipos de etiqueta")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Carrega impressoras acessiveis pelo usuario logado
    * Cria cursor_4c_ImpAcessiveis com colunas impres, ntpimpres
    * Retorna .T. se sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarImpressoras()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))

            IF USED("cursor_4c_ImpAcessiveis")
                USE IN cursor_4c_ImpAcessiveis
            ENDIF
            IF USED("cursor_4c_ImpTemp")
                USE IN cursor_4c_ImpTemp
            ENDIF

            loc_cSQL = "SELECT DISTINCT b.impres, b.ntpimpres " + ;
                       "FROM SIGSYIMP a " + ;
                       "INNER JOIN SIGCDMP b ON a.cimps = b.impres " + ;
                       "WHERE a.usuacess = " + loc_cUsuario + ;
                       " UNION " + ;
                       "SELECT DISTINCT c.impres, c.ntpimpres " + ;
                       "FROM sigcdacg a " + ;
                       "INNER JOIN SIGSYIMP b ON a.grupos = b.gracess " + ;
                       "INNER JOIN SIGCDMP c ON b.cimps = c.impres " + ;
                       "WHERE a.usuarios = " + loc_cUsuario

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
                IF USED("cursor_4c_ImpTemp") AND !EOF("cursor_4c_ImpTemp")
                    SELECT impres, ntpimpres FROM cursor_4c_ImpTemp ;
                        INTO CURSOR cursor_4c_ImpAcessiveis READWRITE
                    SELECT cursor_4c_ImpAcessiveis
                    IF USED("cursor_4c_ImpTemp")
                        USE IN cursor_4c_ImpTemp
                    ENDIF
                    THIS.this_lImpressorasOk     = !EOF()
                    THIS.this_nTotalImpressoras  = _TALLY
                ELSE
                    THIS.this_lImpressorasOk    = .F.
                    THIS.this_nTotalImpressoras = 0
                    IF USED("cursor_4c_ImpTemp")
                        USE IN cursor_4c_ImpTemp
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar impressoras")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConfigImpressora - Carrega ajustes de uma impressora especifica
    * Substitui fCarregarImps do Framework legado
    * Popula this_nTpImp, this_nAjVerts, this_nAjHorzs, this_nAjDenss, this_nAjVelos
    * Retorna .T. se sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarConfigImpressora(par_cNomeImpressora)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cNome
        loc_lSucesso = .F.
        TRY
            loc_cNome = EscaparSQL(UPPER(ALLTRIM(par_cNomeImpressora)))

            IF USED("cursor_4c_ConfigImp")
                USE IN cursor_4c_ConfigImp
            ENDIF

            loc_cSQL = "SELECT TOP 1 impetis, ajverts, ajhorzs, ajdens, ajvelos " + ;
                       "FROM SIGCDMP " + ;
                       "WHERE UPPER(RTRIM(impres)) = " + loc_cNome

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConfigImp") > 0
                IF USED("cursor_4c_ConfigImp") AND !EOF("cursor_4c_ConfigImp")
                    SELECT cursor_4c_ConfigImp
                    THIS.this_nTpImp   = NVL(impetis, THIS.this_nImpEtis)
                    THIS.this_nAjVerts = NVL(ajverts, THIS.this_nAjVertsPad)
                    THIS.this_nAjHorzs = NVL(ajhorzs, THIS.this_nAjHorzsPad)
                    THIS.this_nAjDenss = IIF(NVL(ajdens, 0) < 10, 10, NVL(ajdens, 0))
                    THIS.this_nAjVelos = IIF(NVL(ajvelos, 0) = 0, 1, NVL(ajvelos, 0))
                ELSE
                    *-- Impressora sem config especifica: usar valores padrao
                    THIS.this_nTpImp   = THIS.this_nImpEtis
                    THIS.this_nAjVerts = THIS.this_nAjVertsPad
                    THIS.this_nAjHorzs = THIS.this_nAjHorzsPad
                    THIS.this_nAjDenss = THIS.this_nAjDensPad
                    THIS.this_nAjVelos = THIS.this_nAjVelosPad
                ENDIF
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar config da impressora")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararCursorImpressao - Cria/limpa dbImpressao e insere registros
    * par_nIni - numero inicial da etiqueta
    * par_nQtd - quantidade de etiquetas
    * Retorna .T. se sucesso; cursor dbImpressao fica disponivel para SigOpEtq
    *--------------------------------------------------------------------------
    FUNCTION PrepararCursorImpressao(par_nIni, par_nQtd)
        LOCAL loc_lSucesso, loc_oErro, loc_nI, loc_nFim, loc_cCpro
        loc_lSucesso = .F.
        TRY
            IF par_nQtd <= 0
                MsgAviso("A Quantidade de Etiquetas Precisa Ser Maior Que 0 (Zero)!!!")
            ELSE
                IF USED("dbImpressao")
                    SELECT dbImpressao
                    ZAP
                ELSE
                    SET NULL ON
                    CREATE CURSOR dbImpressao ;
                        (Cpros C(10), DPros C(40) NULL, Qtds N(10,3), ;
                         QtdeEtiq N(10,3), Pedido C(30) NULL, Obs C(10) NULL)
                    SET NULL OFF
                    INDEX ON Cpros TAG Cpros
                    SET ORDER TO
                ENDIF

                loc_nFim = par_nIni + par_nQtd - 1
                FOR loc_nI = par_nIni TO loc_nFim
                    loc_cCpro = PADL(ALLTRIM(STR(loc_nI, 8)), 8, "0")
                    INSERT INTO dbImpressao (Cpros, Qtds, Pedido, QtdeEtiq) ;
                        VALUES (loc_cCpro, 1, "", 1)
                ENDFOR

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preparar cursor de impress" + CHR(227) + "o")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCursorImpressao - Limpa dbImpressao apos impressao concluida
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursorImpressao()
        IF USED("dbImpressao")
            SELECT dbImpressao
            ZAP
        ENDIF
    ENDPROC

ENDDEFINE

