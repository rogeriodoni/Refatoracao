# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrGlo.prg] Procedure vazia (sem codigo): ConfigurarPaginaDados

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlo.prg):
*==============================================================================
* FormSigPrGlo.prg - Processamento de O.P.
* Tipo: OPERACIONAL (layout flat, sem PageFrame de conteudo)
* Herda de: FormBase
* Legado: SigPrGlo.SCX
*
* CHAMADA:
*   DO FORM FormSigPrGlo WITH _Reserva, _Autom, _PorDestino, lcNomeFrm, pTipo
*   Ou via CreateObject("FormSigPrGlo", lReserva, lAutom, lPorDestino, pTipo)
*
* Parametros:
*   par_lReserva    - .T. = modo Reserva Automatica
*   par_lAutom      - .T. = modo automatico
*   par_lPorDestino - .T. = por destino
*   par_pTipo       - .T. = processa por tipo de geracao de OP
*==============================================================================

DEFINE CLASS FormSigPrGlo AS FormBase

    *-- Dimensoes identicas ao legado (Width=680, Height=379)
    Width        = 680
    Height       = 379
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    DataSession  = 2
    ClipControls = .F.
    Caption      = "Processamento de O.P."
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Flags de modo de operacao (recebidos via Init)
    this_lReserva         = .F.
    this_lAutomatico      = .F.
    this_lPorDestino      = .F.
    this_lGerPorTp        = .F.
    this_lAlterEmp        = .T.
    *-- Controlado apos leitura de cursor_4c_CrSigCdPam em InicializarForm
    this_lMostrarChkPedra = .F.

    *--------------------------------------------------------------------------
    * Init - recebe flags de modo, seta propriedades e delega ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_lReserva, par_lAutom, par_lPorDestino, par_pTipo)
        THIS.this_lReserva    = IIF(VARTYPE(par_lReserva)    = "L", par_lReserva,    .F.)
        THIS.this_lAutomatico = IIF(VARTYPE(par_lAutom)      = "L", par_lAutom,      .F.)
        THIS.this_lPorDestino = IIF(VARTYPE(par_lPorDestino) = "L", par_lPorDestino, .F.)
        THIS.this_lGerPorTp   = IIF(VARTYPE(par_pTipo)       = "L", par_pTipo,       .F.)
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera cursores temporarios e BO antes de fechar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_TmpOper")
            USE IN cursor_4c_TmpOper
        ENDIF
        IF USED("cursor_4c_CrTmpTpGop")
            USE IN cursor_4c_CrTmpTpGop
        ENDIF
        IF USED("cursor_4c_CrSigCdPam")
            USE IN cursor_4c_CrSigCdPam
        ENDIF
        IF USED("cursor_4c_CrSigCdPac")
            USE IN cursor_4c_CrSigCdPac
        ENDIF
        IF USED("cursor_4c_TmpCabec")
            USE IN cursor_4c_TmpCabec
        ENDIF
        IF USED("cursor_4c_TmpItens")
            USE IN cursor_4c_TmpItens
        ENDIF
        IF USED("cursor_4c_Oper")
            USE IN cursor_4c_Oper
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria BO, carrega parametros e monta estrutura visual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cCaption
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGloBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGloBO.", "Erro")
            ELSE
                *-- Repassar flags de modo ao BO
                WITH THIS.this_oBusinessObject
                    .this_lReserva    = THIS.this_lReserva
                    .this_lAutomatico = THIS.this_lAutomatico
                    .this_lPorDestino = THIS.this_lPorDestino
                    .this_lGerPorTp   = THIS.this_lGerPorTp
                    .this_lAlterEmp   = THIS.this_lAlterEmp
                ENDWITH

                *-- Carregar operacoes (obrigatorio - form nao funciona sem elas)
                IF NOT THIS.this_oBusinessObject.CarregarOperacoes()
                    MsgErro("Nenhuma Opera" + CHR(231) + CHR(227) + ;
                            "o configurada para Processamento de O.P.", "Erro")
                ELSE
                    *-- Carregar demais parametros do sistema
                    THIS.this_oBusinessObject.CarregarParametros()
                    THIS.this_oBusinessObject.CarregarPacotes()
                    THIS.this_oBusinessObject.CarregarTiposGeracao()

                    *-- Caption dinamico conforme modo de operacao
                    loc_cCaption = "Processamento de O.P."
                    IF THIS.this_lReserva
                        loc_cCaption = "Processar Reserva Autom" + CHR(225) + "tica"
                    ELSE
                        IF THIS.this_lGerPorTp
                            loc_cCaption = "Processar Ordem de Produ" + CHR(231) + ;
                                           CHR(227) + "o por Tipo"
                        ENDIF
                    ENDIF
                    THIS.Caption = loc_cCaption

                    *-- Imagem de fundo
                    THIS.ConfigurarPageFrame()

                    *-- Calcular visibilidade do chk_pedra (antes de criar controles)
                    IF USED("cursor_4c_CrSigCdPam") AND NOT EOF("cursor_4c_CrSigCdPam")
                        SELECT cursor_4c_CrSigCdPam
                        THIS.this_lMostrarChkPedra = ;
                            (NOT EMPTY(ALLTRIM(cursor_4c_CrSigCdPam.DopEmphs)) AND ;
                             NOT EMPTY(ALLTRIM(cursor_4c_CrSigCdPam.DopReqcs)) AND ;
                             NOT EMPTY(ALLTRIM(cursor_4c_CrSigCdPam.DopPedcs)) AND ;
                             NOT EMPTY(ALLTRIM(cursor_4c_CrSigCdPam.TransfRes)))
                    ENDIF

                    *-- Montar estrutura visual do form
                    THIS.ConfigurarCabecalho()
                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    THIS.ConfigurarShape()
                    THIS.ConfigurarPaginaLista()
                    THIS.TornarControlesVisiveis()
                    THIS.PopularCamposIniciais()
                    THIS.ConfigurarEventos()
                    THIS.AlternarPagina("ENTRADA")

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formul" + CHR(225) + "rio: " + ;
                    loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - aplica imagem de fundo (form plano OPERACIONAL)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImg
        loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImg)
            THIS.Picture = loc_cImg
        ENDIF
        THIS.ScrollBars = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cabecalho cinza escuro com titulo (cntSombra legado)
    * Top=0, Left=0, Width=680, Height=80
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
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0,0,0)
                .Caption       = THIS.Caption
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width
                .ForeColor     = RGB(255,255,255)
                .Caption       = THIS.Caption
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarShape - shape decorativo por tras dos botoes (Shape3 legado)
    * Top=7, Left=486, Height=110, Width=173
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShape()
        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top         = 7
            .Left        = 486
            .Height      = 110
            .Width       = 173
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(90,90,90)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - botoes Processar e Cancelar
    * Processar: Top=3, Left=528, 75x75
    * Cancelar : Top=3, Left=603, 75x75
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 528
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top             = 3
            .Left            = 603
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainers - cria containers principais vazios
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainers()
        LOCAL loc_lGlobAutos2
        loc_lGlobAutos2 = .F.
        IF USED("cursor_4c_CrSigCdPam") AND NOT EOF("cursor_4c_CrSigCdPam")
            SELECT cursor_4c_CrSigCdPam
            loc_lGlobAutos2 = (cursor_4c_CrSigCdPam.GlobAutos = 2 AND NOT THIS.this_lReserva)
        ENDIF

        *-- Container1 legado: Tipo de O.P.
        THIS.AddObject("cnt_4c_TipoOp", "Container")
        WITH THIS.cnt_4c_TipoOp
            .Top         = 164
            .Left        = 139
            .Width       = 346
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Enabled     = THIS.this_lGerPorTp
            .Visible     = .T.
        ENDWITH

        *-- Opera_ao legado: codigo + faixa i/f
        THIS.AddObject("cnt_4c_Operacao", "Container")
        WITH THIS.cnt_4c_Operacao
            .Top         = 191
            .Left        = 139
            .Width       = 350
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Conta legado: grupo/conta/descricao para filtro de movimentacao
        THIS.AddObject("cnt_4c_Conta", "Container")
        WITH THIS.cnt_4c_Conta
            .Top         = 218
            .Left        = 139
            .Width       = 553
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Responsavel legado: grupo/conta/descricao do vendedor
        THIS.AddObject("cnt_4c_Responsavel", "Container")
        WITH THIS.cnt_4c_Responsavel
            .Top         = 245
            .Left        = 139
            .Width       = 553
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Empresa legado: cd_empresa + ds_empresa + Chec_pedra
        THIS.AddObject("cnt_4c_Empresa", "Container")
        WITH THIS.cnt_4c_Empresa
            .Top         = 272
            .Left        = 138
            .Width       = 553
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Cnt_Previsao legado: data previsao entrega + data geracao
        *-- Oculto no modo Reserva (legacy: ThisForm.Cnt_Previsao.Visible = .F.)
        THIS.AddObject("cnt_4c_Previsao", "Container")
        WITH THIS.cnt_4c_Previsao
            .Top         = 309
            .Left        = 7
            .Width       = 660
            .Height      = 33
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = NOT THIS.this_lReserva
            .Visible     = .T.
        ENDWITH

        *-- Cnt_Op legado: numero da OP manual (visivel apenas em GlobAutos=2 e !Reserva)
        THIS.AddObject("cnt_4c_Op", "Container")
        WITH THIS.cnt_4c_Op
            .Top         = 313
            .Left        = 478
            .Width       = 130
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = loc_lGlobAutos2
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposForm - labels e textboxes de data diretamente no form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposForm()
        THIS.AddObject("lbl_4c_PeriodoEmissao", "Label")
        WITH THIS.lbl_4c_PeriodoEmissao
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Per" + CHR(237) + "odo de Emiss" + CHR(227) + "o :"
            .Height    = 15
            .Left      = 32
            .Top       = 115
            .Width     = 101
        ENDWITH

        THIS.AddObject("txt_4c_Dataei", "TextBox")
        WITH THIS.txt_4c_Dataei
            .Alignment     = 3
            .Value         = {}
            .Format        = "K"
            .Height        = 23
            .Left          = 142
            .Top           = 111
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.AddObject("lbl_4c_Ate1", "Label")
        WITH THIS.lbl_4c_Ate1
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "at" + CHR(233)
            .Height    = 15
            .Left      = 227
            .Top       = 115
            .Width     = 18
        ENDWITH

        THIS.AddObject("txt_4c_Dataef", "TextBox")
        WITH THIS.txt_4c_Dataef
            .Alignment     = 3
            .Value         = {}
            .Format        = "K"
            .Height        = 23
            .Left          = 255
            .Top           = 111
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.AddObject("lbl_4c_PrevEntrega", "Label")
        WITH THIS.lbl_4c_PrevEntrega
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Previs" + CHR(227) + "o de Entrega :"
            .Height    = 15
            .Left      = 27
            .Top       = 142
            .Width     = 106
        ENDWITH

        THIS.AddObject("txt_4c_Datapi", "TextBox")
        WITH THIS.txt_4c_Datapi
            .Alignment     = 3
            .Value         = {}
            .Format        = "K"
            .Height        = 23
            .Left          = 142
            .Top           = 138
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.AddObject("lbl_4c_Ate2", "Label")
        WITH THIS.lbl_4c_Ate2
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "at" + CHR(233)
            .Height    = 15
            .Left      = 227
            .Top       = 142
            .Width     = 18
        ENDWITH

        THIS.AddObject("txt_4c_Datapf", "TextBox")
        WITH THIS.txt_4c_Datapf
            .Alignment     = 3
            .Value         = {}
            .Format        = "K"
            .Height        = 23
            .Left          = 254
            .Top           = 138
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.AddObject("lbl_4c_TipoOp", "Label")
        WITH THIS.lbl_4c_TipoOp
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Tipo de O.P.:"
            .Height    = 15
            .Left      = 67
            .Top       = 169
            .Width     = 66
        ENDWITH

        THIS.AddObject("lbl_4c_Movimentacao", "Label")
        WITH THIS.lbl_4c_Movimentacao
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Height    = 15
            .Left      = 55
            .Top       = 196
            .Width     = 78
        ENDWITH

        THIS.AddObject("lbl_4c_LblConta", "Label")
        WITH THIS.lbl_4c_LblConta
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Conta :"
            .Height    = 15
            .Left      = 95
            .Top       = 223
            .Width     = 38
        ENDWITH

        THIS.AddObject("lbl_4c_Vendedor", "Label")
        WITH THIS.lbl_4c_Vendedor
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Vendedor :"
            .Height    = 15
            .Left      = 78
            .Top       = 250
            .Width     = 55
        ENDWITH

        THIS.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH THIS.lbl_4c_LblEmpresa
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Empresa :"
            .Height    = 15
            .Left      = 83
            .Top       = 277
            .Width     = 50
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerTipoOp - Get_TpGOp (Container1 legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerTipoOp()
        THIS.cnt_4c_TipoOp.AddObject("txt_4c_TpGOp", "TextBox")
        WITH THIS.cnt_4c_TipoOp.txt_4c_TpGOp
            .Left          = 3
            .Top           = 1
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .FontName      = "Courier New"
            .FontSize      = 9
            .Margin        = 2
            .SpecialEffect = 1
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerOperacao - Opera_ao legado: codigo + faixa i/f
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerOperacao()
        THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacao", "TextBox")
        WITH THIS.cnt_4c_Operacao.txt_4c_Operacao
            .Left          = 3
            .Top           = 1
            .Width         = 151
            .Height        = 23
            .MaxLength     = 20
            .FontName      = "Courier New"
            .FontSize      = 9
            .Margin        = 2
            .SpecialEffect = 1
        ENDWITH

        THIS.cnt_4c_Operacao.AddObject("lbl_4c_De", "Label")
        WITH THIS.cnt_4c_Operacao.lbl_4c_De
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "de"
            .Height    = 15
            .Left      = 180
            .Top       = 5
            .Width     = 14
        ENDWITH

        THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacaoi", "TextBox")
        WITH THIS.cnt_4c_Operacao.txt_4c_Operacaoi
            .Alignment     = 3
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999999"
            .Left          = 201
            .Top           = 1
            .Width         = 55
            .MaxLength     = 6
            .SpecialEffect = 1
            .FontName      = "Courier New"
            .FontSize      = 9
        ENDWITH

        THIS.cnt_4c_Operacao.AddObject("lbl_4c_AteOp", "Label")
        WITH THIS.cnt_4c_Operacao.lbl_4c_AteOp
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "at" + CHR(233)
            .Height    = 15
            .Left      = 262
            .Top       = 4
            .Width     = 18
        ENDWITH

        THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacaof", "TextBox")
        WITH THIS.cnt_4c_Operacao.txt_4c_Operacaof
            .Alignment     = 3
            .Value         = 0
            .Format        = "K"
            .Height        = 23
            .InputMask     = "999999"
            .Left          = 286
            .Top           = 1
            .Width         = 55
            .MaxLength     = 6
            .SpecialEffect = 1
            .FontName      = "Courier New"
            .FontSize      = 9
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerConta - Movimentacao: grupo/conta/descricao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerConta()
        THIS.cnt_4c_Conta.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.cnt_4c_Conta.txt_4c_Grupo
            .Left          = 3
            .Top           = 1
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.cnt_4c_Conta.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.cnt_4c_Conta.txt_4c_Conta
            .Left          = 86
            .Top           = 1
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.cnt_4c_Conta.AddObject("txt_4c_Dconta", "TextBox")
        WITH THIS.cnt_4c_Conta.txt_4c_Dconta
            .Left          = 170
            .Top           = 1
            .Width         = 360
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerResponsavel - Vendedor: grupo/conta/descricao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerResponsavel()
        THIS.cnt_4c_Responsavel.AddObject("txt_4c_GrupoResp", "TextBox")
        WITH THIS.cnt_4c_Responsavel.txt_4c_GrupoResp
            .Left          = 3
            .Top           = 1
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.cnt_4c_Responsavel.AddObject("txt_4c_ContaResp", "TextBox")
        WITH THIS.cnt_4c_Responsavel.txt_4c_ContaResp
            .Left          = 86
            .Top           = 1
            .Width         = 80
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.cnt_4c_Responsavel.AddObject("txt_4c_DcontaResp", "TextBox")
        WITH THIS.cnt_4c_Responsavel.txt_4c_DcontaResp
            .Left          = 170
            .Top           = 1
            .Width         = 360
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerEmpresa - cd_empresa / ds_empresa / chk pedras
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerEmpresa()
        THIS.cnt_4c_Empresa.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH THIS.cnt_4c_Empresa.txt_4c_CdEmpresa
            .Left          = 4
            .Top           = 1
            .Width         = 31
            .Height        = 23
            .InputMask     = "XXX"
            .MaxLength     = 3
            .Format        = "k"
            .BackStyle     = 1
            .BorderStyle   = 1
            .ForeColor     = RGB(0,0,0)
            .FontName      = "Courier New"
            .FontSize      = 9
            .SpecialEffect = 1
        ENDWITH

        THIS.cnt_4c_Empresa.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH THIS.cnt_4c_Empresa.txt_4c_DsEmpresa
            .Left          = 38
            .Top           = 1
            .Width         = 282
            .Height        = 23
            .MaxLength     = 40
            .Format        = "K"
            .FontName      = "Courier New"
            .FontSize      = 9
            .SpecialEffect = 1
        ENDWITH

        THIS.cnt_4c_Empresa.AddObject("chk_4c_NaoEmpPedra", "CheckBox")
        WITH THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra
            .Left      = 330
            .Top       = 5
            .Height    = 15
            .Width     = 124
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "N" + CHR(227) + "o Empenhar Pedras"
            .Value     = 0
            .ForeColor = RGB(90,90,90)
            .Visible   = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerPrevisao - data previsao entrega + data geracao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerPrevisao()
        THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblPrevisao", "Label")
        WITH THIS.cnt_4c_Previsao.lbl_4c_LblPrevisao
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Previs" + CHR(227) + "o de Entrega :"
            .Height    = 15
            .Left      = 7
            .Top       = 9
            .Width     = 106
        ENDWITH

        THIS.cnt_4c_Previsao.AddObject("txt_4c_Previsao", "TextBox")
        WITH THIS.cnt_4c_Previsao.txt_4c_Previsao
            .Alignment     = 3
            .Value         = {}
            .Format        = "K"
            .Height        = 23
            .Left          = 134
            .Top           = 5
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblGeracao", "Label")
        WITH THIS.cnt_4c_Previsao.lbl_4c_LblGeracao
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "Data de Gera" + CHR(231) + CHR(227) + "o :"
            .Height    = 15
            .Left      = 244
            .Top       = 9
            .Width     = 90
        ENDWITH

        THIS.cnt_4c_Previsao.AddObject("txt_4c_Geracao", "TextBox")
        WITH THIS.cnt_4c_Previsao.txt_4c_Geracao
            .Alignment     = 3
            .Value         = {}
            .Format        = "K"
            .Height        = 23
            .Left          = 353
            .Top           = 5
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerOp - numero da OP manual (Cnt_Op legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerOp()
        THIS.cnt_4c_Op.AddObject("lbl_4c_LblNop", "Label")
        WITH THIS.cnt_4c_Op.lbl_4c_LblNop
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .Caption   = "N" + CHR(186) + " da O.P.:"
            .Height    = 15
            .Left      = 0
            .Top       = 5
            .Width     = 58
        ENDWITH

        THIS.cnt_4c_Op.AddObject("txt_4c_Nop", "TextBox")
        WITH THIS.cnt_4c_Op.txt_4c_Nop
            .Alignment     = 3
            .Value         = 0
            .Height        = 23
            .InputMask     = "999999"
            .Left          = 71
            .Top           = 1
            .Width         = 59
            .MaxLength     = 6
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - monta a area principal (botoes + containers + campos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarContainers()
        THIS.ConfigurarCamposForm()
        THIS.ConfigurarContainerTipoOp()
        THIS.ConfigurarContainerOperacao()
        THIS.ConfigurarContainerConta()
        THIS.ConfigurarContainerResponsavel()
        THIS.ConfigurarContainerEmpresa()
        THIS.ConfigurarContainerPrevisao()
        THIS.ConfigurarContainerOp()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - stub de compatibilidade (OPERACIONAL nao tem Page2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna controles do form visiveis apos AddObject
    * Preserva Visible original de containers com visibilidade gerenciada
    * (cnt_4c_Op e cnt_4c_Previsao) mas recursa seus filhos antes do LOOP
    * para evitar ghost trails (feedback_tcv_skip_recursao.md)
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis()
        LOCAL loc_i, loc_oCtrl, loc_lSkip
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oCtrl = THIS.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) != "O"
                LOOP
            ENDIF
            loc_lSkip = INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_OP", "CNT_4C_PREVISAO")
            IF loc_lSkip
                *-- Recursar filhos ANTES do LOOP (anti-ghost para containers hidden)
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oCtrl)
                ENDIF
                LOOP
            ENDIF
            IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                loc_oCtrl.Visible = .T.
            ENDIF
            IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                THIS.TornarSubControlesVisiveis(loc_oCtrl)
            ENDIF
        ENDFOR
    ENDPROC

    PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularCamposIniciais - preenche valores iniciais apos criacao dos controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PopularCamposIniciais()
        LOCAL loc_oErro, loc_cEmp, loc_cRazas
        TRY
            *-- Empresa padrao: go_4c_Sistema.cCodEmpresa
            loc_cEmp   = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_cRazas = ""
            IF USED("cursor_4c_TmpEmpInit")
                USE IN cursor_4c_TmpEmpInit
            ENDIF
            IF SQLEXEC(gnConnHandle, ;
               "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmp), ;
               "cursor_4c_TmpEmpInit") >= 1
                IF RECCOUNT("cursor_4c_TmpEmpInit") > 0
                    SELECT cursor_4c_TmpEmpInit
                    loc_cRazas = ALLTRIM(cursor_4c_TmpEmpInit.Razas)
                ENDIF
                USE IN cursor_4c_TmpEmpInit
            ENDIF
            THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = loc_cEmp
            THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = loc_cRazas

            *-- Previsao de entrega: data atual + PrevProds dias
            IF USED("cursor_4c_CrSigCdPam") AND NOT EOF("cursor_4c_CrSigCdPam")
                SELECT cursor_4c_CrSigCdPam
                THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = DATE() + cursor_4c_CrSigCdPam.PrevProds
            ENDIF

            *-- Data de geracao: data atual (apenas se nao modo automatico)
            IF NOT THIS.this_lAutomatico
                THIS.cnt_4c_Previsao.txt_4c_Geracao.Value = DATE()
            ENDIF

            *-- Visibilidade do checkbox pedras
            THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Visible = THIS.this_lMostrarChkPedra

            *-- Pre-selecionar tipo de OP se GerPorTp e houver apenas 1 tipo disponivel
            IF THIS.this_lGerPorTp AND ;
               USED("cursor_4c_CrTmpTpGop") AND ;
               RECCOUNT("cursor_4c_CrTmpTpGop") = 1
                SELECT cursor_4c_CrTmpTpGop
                GO TOP
                THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_CrTmpTpGop.Codigos)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao popular campos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - registra handlers via BINDEVENT (metodos PUBLIC)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
        BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
        BINDEVENT(THIS.cnt_4c_TipoOp.txt_4c_TpGOp,          "KeyPress", THIS, "TxtTpGOpKeyPress")
        BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacao,      "KeyPress", THIS, "TxtOperacaoKeyPress")
        BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacaoi,     "KeyPress", THIS, "TxtOperacaoiKeyPress")
        BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Grupo,            "KeyPress", THIS, "TxtGrupoContaKeyPress")
        BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Conta,            "KeyPress", THIS, "TxtContaKeyPress")
        BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Dconta,           "KeyPress", THIS, "TxtDcontaKeyPress")
        BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp,  "KeyPress", THIS, "TxtGrupoRespKeyPress")
        BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_ContaResp,  "KeyPress", THIS, "TxtContaRespKeyPress")
        BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp, "KeyPress", THIS, "TxtDcontaRespKeyPress")
        BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa,      "KeyPress", THIS, "TxtCdEmpresaKeyPress")
        BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa,      "KeyPress", THIS, "TxtDsEmpresaKeyPress")
        BINDEVENT(THIS.cnt_4c_Op.txt_4c_Nop,                 "KeyPress", THIS, "TxtNopKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdProcessarClick - valida campos, copia ao BO e executa processamento
    *--------------------------------------------------------------------------
    PROCEDURE CmdProcessarClick()
        LOCAL loc_nGlobAutos, loc_oErro, loc_lProcessou, loc_lErroOcorreu, loc_oGl2
        loc_nGlobAutos    = 0
        loc_lProcessou    = .F.
        loc_lErroOcorreu  = .F.

        *-- Validar previsao e geracao (obrigatorias em modo normal)
        IF NOT THIS.this_lReserva
            IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Previsao.Value)
                MsgAviso("A Data de Previs" + CHR(227) + "o Deve Ser Preenchida!!!")
                THIS.cnt_4c_Previsao.txt_4c_Previsao.SetFocus
                RETURN
            ENDIF
            IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Geracao.Value)
                MsgAviso("A Data de Gera" + CHR(231) + CHR(227) + "o Deve Ser Preenchida!!!")
                THIS.cnt_4c_Previsao.txt_4c_Geracao.SetFocus
                RETURN
            ENDIF
        ENDIF

        *-- Validar numero OP manual (GlobAutos=2)
        IF USED("cursor_4c_CrSigCdPam") AND NOT EOF("cursor_4c_CrSigCdPam")
            SELECT cursor_4c_CrSigCdPam
            loc_nGlobAutos = cursor_4c_CrSigCdPam.GlobAutos
            IF loc_nGlobAutos = 2 AND NOT THIS.this_lReserva
                IF THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
                    MsgAviso("O N" + CHR(250) + "mero da OP " + CHR(233) + " Manual e Deve Ser Preenchido!!!")
                    THIS.cnt_4c_Op.txt_4c_Nop.SetFocus
                    RETURN
                ENDIF
            ENDIF
        ENDIF

        *-- Validar tipo de OP (obrigatorio no modo GerPorTp)
        IF THIS.this_lGerPorTp AND EMPTY(ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value))
            MsgAviso("O Tipo de Gera" + CHR(231) + CHR(227) + "o da OP " + CHR(233) + ;
                     " Obrigat" + CHR(243) + "rio ser Preenchido!!!")
            THIS.cnt_4c_TipoOp.txt_4c_TpGOp.SetFocus
            RETURN
        ENDIF

        *-- Copiar campos do form para o BO
        THIS.FormParaBO()

        *-- Bloquear UI durante processamento
        THIS.AlternarPagina("PROCESSANDO")

        TRY
            loc_lProcessou = THIS.this_oBusinessObject.ProcessarOP()
        CATCH TO loc_oErro
            MsgErro("Erro no processamento: " + loc_oErro.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
            loc_lErroOcorreu = .T.
        ENDTRY

        *-- Restaurar UI (sempre - inclusive em erro)
        THIS.AlternarPagina("ENTRADA")

        IF loc_lProcessou
            *-- Abrir FormSigPrGl2 para exibir/confirmar resultados
            loc_oGl2 = CREATEOBJECT("FormSigPrGl2", THIS, THIS.DataSessionId, ;
                THIS.this_lReserva, .NULL., 0, ;
                THIS.this_lAutomatico, THIS.this_oBusinessObject.this_nNumeroOP)
            IF VARTYPE(loc_oGl2) = "O"
                loc_oGl2.Show()
                loc_oGl2 = .NULL.
            ENDIF
        ELSE
            IF NOT loc_lErroOcorreu
                *-- Processamento rodou sem exception mas nao encontrou itens
                MsgAviso("Nenhum Item Selecionado Para Processar!!!")
                IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
                    THIS.txt_4c_Dataei.SetFocus
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCancelarClick - fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE CmdCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - copia todos os campos do formulario para as propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_dDataei          = THIS.txt_4c_Dataei.Value
            .this_dDataef          = THIS.txt_4c_Dataef.Value
            .this_dDatapi          = THIS.txt_4c_Datapi.Value
            .this_dDatapf          = THIS.txt_4c_Datapf.Value
            .this_cOperacao        = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
            .this_nOperacaoi       = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
            .this_nOperacaof       = THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value
            .this_cGrupoConta      = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value)
            .this_cConta           = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value)
            .this_cDConta          = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value)
            .this_cGrupoResp       = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value)
            .this_cContaResp       = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value)
            .this_cDContaResp      = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value)
            .this_cCodEmpresa      = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)
            .this_cDsEmpresa       = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value)
            .this_nNaoEmpenharPedras = THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value
            .this_cTipoGerOP       = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
            .this_dPrevisao        = THIS.cnt_4c_Previsao.txt_4c_Previsao.Value
            .this_dGeracao         = THIS.cnt_4c_Previsao.txt_4c_Geracao.Value
            .this_nNumeroOP        = THIS.cnt_4c_Op.txt_4c_Nop.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - popula os campos do formulario a partir das propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oErro
        TRY
            WITH THIS.this_oBusinessObject
                THIS.txt_4c_Dataei.Value = .this_dDataei
                THIS.txt_4c_Dataef.Value = .this_dDataef
                THIS.txt_4c_Datapi.Value = .this_dDatapi
                THIS.txt_4c_Datapf.Value = .this_dDatapf
                THIS.cnt_4c_Operacao.txt_4c_Operacao.Value      = .this_cOperacao
                THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value     = .this_nOperacaoi
                THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value     = .this_nOperacaof
                THIS.cnt_4c_Conta.txt_4c_Grupo.Value            = .this_cGrupoConta
                THIS.cnt_4c_Conta.txt_4c_Conta.Value            = .this_cConta
                THIS.cnt_4c_Conta.txt_4c_Dconta.Value           = .this_cDConta
                THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value  = .this_cGrupoResp
                THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = .this_cContaResp
                THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = .this_cDContaResp
                THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value      = .this_cCodEmpresa
                THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value      = .this_cDsEmpresa
                THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value    = .this_nNaoEmpenharPedras
                THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value           = .this_cTipoGerOP
                THIS.cnt_4c_Previsao.txt_4c_Previsao.Value      = .this_dPrevisao
                THIS.cnt_4c_Previsao.txt_4c_Geracao.Value       = .this_dGeracao
                THIS.cnt_4c_Op.txt_4c_Nop.Value                 = .this_nNumeroOP
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar campos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - alterna estado visual entre "ENTRADA" e "PROCESSANDO"
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_cModo)
        LOCAL loc_cModo, loc_lEditar
        loc_cModo  = IIF(VARTYPE(par_cModo) = "C", UPPER(ALLTRIM(par_cModo)), "ENTRADA")
        loc_lEditar = (loc_cModo = "ENTRADA")

        IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
            THIS.cmd_4c_Processar.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
            THIS.cnt_4c_TipoOp.Enabled = (loc_lEditar AND THIS.this_lGerPorTp)
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
            THIS.cnt_4c_Operacao.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Conta", 5)
            THIS.cnt_4c_Conta.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
            THIS.cnt_4c_Responsavel.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Empresa", 5)
            THIS.cnt_4c_Empresa.Enabled = (loc_lEditar AND THIS.this_lAlterEmp)
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
            THIS.cnt_4c_Previsao.Enabled = (loc_lEditar AND NOT THIS.this_lReserva)
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Op", 5)
            THIS.cnt_4c_Op.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
            THIS.txt_4c_Dataei.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Dataef", 5)
            THIS.txt_4c_Dataef.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Datapi", 5)
            THIS.txt_4c_Datapi.Enabled = loc_lEditar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Datapf", 5)
            THIS.txt_4c_Datapf.Enabled = loc_lEditar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - limpa todos os campos de filtro do formulario
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
            THIS.txt_4c_Dataei.Value = {}
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Dataef", 5)
            THIS.txt_4c_Dataef.Value = {}
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Datapi", 5)
            THIS.txt_4c_Datapi.Value = {}
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Datapf", 5)
            THIS.txt_4c_Datapf.Value = {}
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
            THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
            THIS.cnt_4c_Operacao.txt_4c_Operacao.Value  = ""
            THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
            THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Conta", 5)
            THIS.cnt_4c_Conta.txt_4c_Grupo.Value  = ""
            THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
            THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
            THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value  = ""
            THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
            THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
            THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = {}
            THIS.cnt_4c_Previsao.txt_4c_Geracao.Value  = {}
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Op", 5)
            THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtTpGOpKeyPress - lookup tipo de OP (cursor_4c_CrTmpTpGop - VFP local)
    *--------------------------------------------------------------------------
    PROCEDURE TxtTpGOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF NOT THIS.cnt_4c_TipoOp.Enabled
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
        *-- Tentar SEEK direto antes de abrir picker
        IF NOT EMPTY(loc_cVal) AND USED("cursor_4c_CrTmpTpGop")
            SELECT cursor_4c_CrTmpTpGop
            IF SEEK(loc_cVal, "cursor_4c_CrTmpTpGop", "Codigos")
                RETURN
            ENDIF
        ENDIF
        IF NOT USED("cursor_4c_CrTmpTpGop")
            MsgAviso("Tipos de O.P. n" + CHR(227) + "o carregados.")
            RETURN
        ENDIF
        IF USED("cursor_4c_TpGOp")
            USE IN cursor_4c_TpGOp
        ENDIF
        SELECT Codigos, Descs FROM cursor_4c_CrTmpTpGop INTO CURSOR cursor_4c_TpGOp READWRITE
        SELECT cursor_4c_TpGOp
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .this_cCursorDestino = "cursor_4c_TpGOp"
                .this_cTitulo        = "Tipos de Gera" + CHR(231) + CHR(227) + "o de OP"
                .this_cCampoBusca    = "Codigos"
                .this_cValorBusca    = loc_cVal
                .mAddColuna("Codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                .mAddColuna("Descs",   "                              ", "Descri" + CHR(231) + CHR(227) + "o")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_TpGOp
                    THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_TpGOp.Codigos)
                ELSE
                    THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtOperacaoKeyPress - lookup operacao (cursor_4c_TmpOper - VFP local)
    *--------------------------------------------------------------------------
    PROCEDURE TxtOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_cTpGOp, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
        *-- Vazio: limpar faixa inicial/final
        IF EMPTY(loc_cVal)
            THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
            THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
            RETURN
        ENDIF
        IF NOT USED("cursor_4c_TmpOper")
            MsgAviso("Opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o carregadas.")
            RETURN
        ENDIF
        IF USED("cursor_4c_Oper")
            USE IN cursor_4c_Oper
        ENDIF
        IF THIS.this_lGerPorTp
            loc_cTpGOp = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
            SELECT Dopes, NDopes FROM cursor_4c_TmpOper ;
                WHERE CodTgOps = m.loc_cTpGOp ;
                INTO CURSOR cursor_4c_Oper READWRITE
        ELSE
            SELECT Dopes, NDopes FROM cursor_4c_TmpOper INTO CURSOR cursor_4c_Oper READWRITE
        ENDIF
        SELECT cursor_4c_Oper
        INDEX ON Dopes TAG Dopes
        *-- Tentar SEEK direto
        IF SEEK(loc_cVal, "cursor_4c_Oper", "Dopes")
            RETURN
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .this_cCursorDestino = "cursor_4c_Oper"
                .this_cTitulo        = "Cadastro de Opera" + CHR(231) + CHR(245) + "es"
                .this_cCampoBusca    = "Dopes"
                .this_cValorBusca    = loc_cVal
                .mAddColuna("Dopes",  "", "Opera" + CHR(231) + CHR(227) + "o")
                .mAddColuna("NDopes", "XXXXXX", "C" + CHR(243) + "digo")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_Oper
                    THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_Oper.Dopes)
                ELSE
                    THIS.cnt_4c_Operacao.txt_4c_Operacao.Value  = ""
                    THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
                    THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtOperacaoiKeyPress - auto-popula faixa final quando faixa inicial preenchida
    *--------------------------------------------------------------------------
    PROCEDURE TxtOperacaoiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value > 0 AND ;
           THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
            THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGrupoContaKeyPress - lookup grupo contabil (SigCdGcr) para Movimentacao
    *--------------------------------------------------------------------------
    PROCEDURE TxtGrupoContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cVal  = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
            "cursor_4c_GrpConta", "codigos", loc_cVal, ;
            "Grupos Cont" + CHR(225) + "beis", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_GrpConta
                    THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_GrpConta.codigos)
                ELSE
                    THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtContaKeyPress - lookup conta por codigo IClis (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cVal  = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
            "cursor_4c_CliConta", "IClis", loc_cVal, ;
            "Clientes - Movimenta" + CHR(231) + CHR(227) + "o", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                .mAddColuna("RClis", "                                        ", "Nome")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_CliConta
                    THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliConta.IClis)
                    THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliConta.RClis)
                ELSE
                    THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
                    THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDcontaKeyPress - lookup conta por nome RClis (apenas quando Conta vazia)
    *--------------------------------------------------------------------------
    PROCEDURE TxtDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value))
            RETURN
        ENDIF
        loc_cVal  = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
            "cursor_4c_CliDconta", "RClis", loc_cVal, ;
            "Clientes - Movimenta" + CHR(231) + CHR(227) + "o (Nome)", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                .mAddColuna("RClis", "                                        ", "Nome")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_CliDconta
                    THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDconta.IClis)
                    THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliDconta.RClis)
                ELSE
                    THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
                    THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGrupoRespKeyPress - lookup grupo contabil (SigCdGcr) para Vendedor
    *--------------------------------------------------------------------------
    PROCEDURE TxtGrupoRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cVal  = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
            "cursor_4c_GrpResp", "codigos", loc_cVal, ;
            "Grupos - Vendedor", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_GrpResp
                    THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ALLTRIM(cursor_4c_GrpResp.codigos)
                ELSE
                    THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtContaRespKeyPress - lookup vendedor por codigo IClis (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE TxtContaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cVal  = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
            "cursor_4c_CliResp", "IClis", loc_cVal, ;
            "Clientes - Vendedor", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                .mAddColuna("RClis", "                                        ", "Nome")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_CliResp
                    THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliResp.IClis)
                    THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliResp.RClis)
                ELSE
                    THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
                    THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDcontaRespKeyPress - lookup vendedor por nome RClis (apenas quando ContaResp vazia)
    *--------------------------------------------------------------------------
    PROCEDURE TxtDcontaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value))
            RETURN
        ENDIF
        loc_cVal  = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
            "cursor_4c_CliDcontaResp", "RClis", loc_cVal, ;
            "Clientes - Vendedor (Nome)", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                .mAddColuna("RClis", "                                        ", "Nome")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_CliDcontaResp
                    THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliDcontaResp.IClis)
                    THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliDcontaResp.RClis)
                ELSE
                    THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
                    THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCdEmpresaKeyPress - lookup empresa por codigo Cemps (SigCdEmp)
    * Apenas se AlterEmp = .T.
    *--------------------------------------------------------------------------
    PROCEDURE TxtCdEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF NOT THIS.this_lAlterEmp
            RETURN
        ENDIF
        loc_cVal  = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
            "cursor_4c_Emp", "Cemps", loc_cVal, ;
            "Empresas", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
                .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_Emp
                    THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_Emp.Cemps)
                    THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_Emp.Razas)
                ELSE
                    THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
                    THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDsEmpresaKeyPress - lookup empresa por razao social Razas (SigCdEmp)
    * Apenas se AlterEmp = .T. e CdEmpresa vazio
    *--------------------------------------------------------------------------
    PROCEDURE TxtDsEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oBusca
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF NOT THIS.this_lAlterEmp
            RETURN
        ENDIF
        IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value))
            RETURN
        ENDIF
        loc_cVal  = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
            "cursor_4c_EmpDs", "Razas", loc_cVal, ;
            "Empresas (Raz" + CHR(227) + "o Social)", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            WITH loc_oBusca
                .mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
                .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
                .Show()
                IF .this_lSelecionou
                    SELECT cursor_4c_EmpDs
                    THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpDs.Cemps)
                    THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpDs.Razas)
                ELSE
                    THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
                    THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
                ENDIF
            ENDWITH
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtNopKeyPress - valida numero de OP (nao pode ja existir em SigOpPic)
    *--------------------------------------------------------------------------
    PROCEDURE TxtNopKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.VerificarNumeroOP(THIS.cnt_4c_Op.txt_4c_Nop.Value)
            MsgAviso("N" + CHR(250) + "mero de OP j" + CHR(225) + " existe. Favor Corrigir!!!")
            THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - compatibilidade FormBase (OPERACIONAL nao tem grid de lista)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.PopularCamposIniciais()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - compatibilidade FormBase
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        THIS.AlternarPagina("ENTRADA")
    ENDPROC

    *-- Stubs de compatibilidade com FormBase (OPERACIONAL nao tem CRUD)
    PROCEDURE BtnIncluirClick()
        THIS.CmdProcessarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.AlternarPagina("ENTRADA")
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        THIS.AlternarPagina("ENTRADA")
        THIS.PopularCamposIniciais()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.CmdCancelarClick()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.CmdCancelarClick()
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.LimparCampos()
        THIS.PopularCamposIniciais()
        THIS.AlternarPagina("ENTRADA")
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.CmdProcessarClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina("ENTRADA")
        THIS.LimparCampos()
        THIS.PopularCamposIniciais()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGloBO.prg):
*==============================================================================
* SigPrGloBO.prg - Business Object para Processamento de O.P.
* Form OPERACIONAL: processa SigMvCab e gera entradas em SigTempd/SigOpPic
*==============================================================================

DEFINE CLASS SigPrGloBO AS BusinessBase

    *-- Tabela alvo de persistencia (Ordem de Producao gerada)
    this_cTabela      = "SigOpPic"
    this_cCampoChave  = "Cidchaves"

    *--------------------------------------------------------------------------
    * Propriedades de SigOpPic (registro individual da OP para CRUD)
    *--------------------------------------------------------------------------
    this_cCidChaves = ""
    this_cEmps      = ""
    this_cDopes     = ""
    this_cDopps     = ""
    this_nNumes     = 0
    this_nNumps     = 0
    this_nNops      = 0
    this_cCpros     = ""
    this_cDpros     = ""
    this_nQtds      = 0
    this_dDataes    = {}
    this_dDataps    = {}
    this_dDataTrans = {}
    this_dDtGeras   = {}
    this_dDtFunds   = {}
    this_cLocals    = ""
    this_nNtrans    = 0
    this_cEmpDs     = ""
    this_nSeqDivs   = 0
    this_cCodCors   = ""
    this_cCodTams   = ""
    this_lDivs      = .F.
    this_lImprs     = .F.
    this_lIimprs    = .F.
    this_cUsuars    = ""
    this_nNopMaes   = 0
    this_nPesos     = 0
    this_nCodBarras = 0
    this_nQtdCpnts  = 0
    this_nQtdTubos  = 0
    this_cMoedas    = ""
    this_nUnits     = 0
    this_nNfunds    = 0
    this_cEmpDnps   = ""
    this_cEmpDopnops = ""
    this_cEmpDopnums = ""
    this_cNotas     = ""
    this_cCodTgOps  = ""
    this_nCitens    = 0
    this_cObss      = ""

    *--------------------------------------------------------------------------
    * Parametros de filtro - Periodo de Emissao
    *--------------------------------------------------------------------------
    this_dDataei   = {}
    this_dDataef   = {}

    *-- Periodo de Previsao de Entrega
    this_dDatapi   = {}
    this_dDatapf   = {}

    *-- Previsao de Entrega e Data de Geracao (Cnt_Previsao)
    this_dPrevisao = {}
    this_dGeracao  = {}

    *--------------------------------------------------------------------------
    * Parametros de filtro - Operacao
    *--------------------------------------------------------------------------
    this_cOperacao   = ""
    this_nOperacaoi  = 0
    this_nOperacaof  = 0

    *--------------------------------------------------------------------------
    * Parametros de filtro - Conta (cliente)
    *--------------------------------------------------------------------------
    this_cGrupoConta = ""
    this_cConta      = ""
    this_cDConta     = ""

    *--------------------------------------------------------------------------
    * Parametros de filtro - Responsavel/Vendedor
    *--------------------------------------------------------------------------
    this_cGrupoResp  = ""
    this_cContaResp  = ""
    this_cDContaResp = ""

    *--------------------------------------------------------------------------
    * Parametros de filtro - Empresa
    *--------------------------------------------------------------------------
    this_cCodEmpresa = ""
    this_cDsEmpresa  = ""

    *-- Checkbox "Nao Empenhar Pedras" (0=empenhar, 1=nao empenhar)
    this_nNaoEmpenharPedras = 0

    *--------------------------------------------------------------------------
    * Parametros de filtro - Numero da OP e Tipo de Geracao
    *--------------------------------------------------------------------------
    this_nNumeroOP  = 0
    this_cTipoGerOP = ""

    *--------------------------------------------------------------------------
    * Propriedades de modo de execucao (mapeadas das custom props do form)
    *--------------------------------------------------------------------------
    this_lReserva    = .F.
    this_lAutomatico = .F.
    this_lPorDestino = .F.
    this_lGerPorTp   = .F.
    this_lAlterEmp   = .T.

    *--------------------------------------------------------------------------
    * Cursores internos de trabalho (nomes para reuso entre metodos)
    *--------------------------------------------------------------------------
    this_cCursorOper    = "cursor_4c_TmpOper"
    this_cCursorTiposGO = "cursor_4c_CrTmpTpGop"
    this_cCursorParam   = "cursor_4c_CrSigCdPam"
    this_cCursorCabec   = "cursor_4c_TmpCabec"
    this_cCursorItens   = "cursor_4c_TmpItens"

    *==========================================================================
    * Init - configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpPic"
            THIS.this_cCampoChave = "Cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna Cidchaves (PK de SigOpPic) para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *==========================================================================
    * MontarCidChaves - Gera Cidchaves = Emps + Dopes + Numps (padrao SigOpPic)
    *==========================================================================
    PROTECTED PROCEDURE MontarCidChaves()
        LOCAL loc_cResultado
        loc_cResultado = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                         PADR(ALLTRIM(THIS.this_cDopes), 6) + ;
                         PADL(ALLTRIM(TRANSFORM(THIS.this_nNumps)), 10, "0")
        RETURN LEFT(loc_cResultado, 20)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor de SigOpPic
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(Cidchaves, "C")
                THIS.this_cEmps       = TratarNulo(Emps, "C")
                THIS.this_cDopes      = TratarNulo(Dopes, "C")
                THIS.this_cDopps      = TratarNulo(Dopps, "C")
                THIS.this_nNumes      = TratarNulo(Numes, "N")
                THIS.this_nNumps      = TratarNulo(Numps, "N")
                THIS.this_nNops       = TratarNulo(Nops, "N")
                THIS.this_cCpros      = TratarNulo(Cpros, "C")
                THIS.this_cDpros      = TratarNulo(Dpros, "C")
                THIS.this_nQtds       = TratarNulo(Qtds, "N")
                THIS.this_dDataes     = TratarNulo(Dataes, "D")
                THIS.this_dDataps     = TratarNulo(Dataps, "D")
                THIS.this_dDataTrans  = TratarNulo(DataTrans, "D")
                THIS.this_dDtGeras    = TratarNulo(DtGeras, "D")
                THIS.this_dDtFunds    = TratarNulo(DtFunds, "D")
                THIS.this_cLocals     = TratarNulo(Locals, "C")
                THIS.this_nNtrans     = TratarNulo(Ntrans, "N")
                THIS.this_cEmpDs      = TratarNulo(Empds, "C")
                THIS.this_nSeqDivs    = TratarNulo(SeqDivs, "N")
                THIS.this_cCodCors    = TratarNulo(CodCors, "C")
                THIS.this_cCodTams    = TratarNulo(CodTams, "C")
                IF VARTYPE(Divs) = "L"
                    THIS.this_lDivs = NVL(Divs, .F.)
                ELSE
                    IF VARTYPE(Divs) = "L"
                        THIS.this_lDivs = Divs
                    ELSE
                        THIS.this_lDivs = (NVL(Divs, 0) = 1)
                    ENDIF
                ENDIF
                IF VARTYPE(Imprs) = "L"
                    THIS.this_lImprs = NVL(Imprs, .F.)
                ELSE
                    IF VARTYPE(Imprs) = "L"
                        THIS.this_lImprs = Imprs
                    ELSE
                        THIS.this_lImprs = (NVL(Imprs, 0) = 1)
                    ENDIF
                ENDIF
                IF VARTYPE(Iimprs) = "L"
                    THIS.this_lIimprs = NVL(Iimprs, .F.)
                ELSE
                    IF VARTYPE(Iimprs) = "L"
                        THIS.this_lIimprs = Iimprs
                    ELSE
                        THIS.this_lIimprs = (NVL(Iimprs, 0) = 1)
                    ENDIF
                ENDIF
                THIS.this_cUsuars     = TratarNulo(Usuars, "C")
                THIS.this_nNopMaes    = TratarNulo(NopMaes, "N")
                THIS.this_nPesos      = TratarNulo(Pesos, "N")
                THIS.this_nCodBarras  = TratarNulo(CodBarras, "N")
                THIS.this_nQtdCpnts   = TratarNulo(QtdCpnts, "N")
                THIS.this_nQtdTubos   = TratarNulo(QtdTubos, "N")
                THIS.this_cMoedas     = TratarNulo(Moedas, "C")
                THIS.this_nUnits      = TratarNulo(Units, "N")
                THIS.this_nNfunds     = TratarNulo(Nfunds, "N")
                THIS.this_cEmpDnps    = TratarNulo(Empdnps, "C")
                THIS.this_cEmpDopnops = TratarNulo(Empdopnops, "C")
                THIS.this_cEmpDopnums = TratarNulo(Empdopnums, "C")
                THIS.this_cNotas      = TratarNulo(Notas, "C")
                THIS.this_cCodTgOps   = TratarNulo(CodTgOps, "C")
                THIS.this_nCitens     = TratarNulo(Citens, "N")
                IF TYPE(par_cAliasCursor + ".Obss") <> "U"
                    THIS.this_cObss = TratarNulo(Obss, "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere um registro na tabela SigOpPic
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRes
        loc_lSucesso = .F.
        TRY
            *-- Auto-preenchimento de campos derivados
            IF EMPTY(THIS.this_cEmps)
                THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF
            IF EMPTY(THIS.this_cUsuars)
                THIS.this_cUsuars = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")
            ENDIF
            IF EMPTY(THIS.this_dDtGeras)
                THIS.this_dDtGeras = DATE()
            ENDIF
            IF EMPTY(THIS.this_cEmpDs)
                THIS.this_cEmpDs = THIS.this_cEmps
            ENDIF
            IF EMPTY(THIS.this_cLocals)
                THIS.this_cLocals = ""
            ENDIF
            IF EMPTY(THIS.this_cDopps)
                THIS.this_cDopps = THIS.this_cDopes
            ENDIF
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = THIS.MontarCidChaves()
            ENDIF
            IF EMPTY(THIS.this_cEmpDopnums)
                THIS.this_cEmpDopnums = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                                        PADR(ALLTRIM(THIS.this_cDopes), 20) + ;
                                        PADL(ALLTRIM(TRANSFORM(THIS.this_nNumes)), 6, "0")
            ENDIF
            IF EMPTY(THIS.this_cEmpDnps)
                THIS.this_cEmpDnps = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                                     PADR(ALLTRIM(THIS.this_cDopps), 20) + ;
                                     PADL(ALLTRIM(TRANSFORM(THIS.this_nNumps)), 10, "0")
            ENDIF
            IF EMPTY(THIS.this_cEmpDopnops)
                THIS.this_cEmpDopnops = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                                        PADR(ALLTRIM(THIS.this_cDopes), 20) + ;
                                        PADL(ALLTRIM(TRANSFORM(THIS.this_nNops)), 10, "0")
            ENDIF

            loc_cSQL = "INSERT INTO SigOpPic " + ;
                "(Cidchaves, Emps, Dopes, Dopps, Numes, Numps, Nops, Cpros, Dpros, Qtds, " + ;
                "Dataes, Dataps, DataTrans, DtGeras, DtFunds, Locals, Ntrans, Empds, SeqDivs, " + ;
                "CodCors, CodTams, Divs, Imprs, Iimprs, Usuars, NopMaes, Pesos, CodBarras, " + ;
                "QtdCpnts, QtdTubos, Moedas, Units, Nfunds, Empdnps, Empdopnops, " + ;
                "Empdopnums, Notas, CodTgOps, Citens, Obss) VALUES ("
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(THIS.this_cEmps) + ", " + ;
                EscaparSQL(THIS.this_cDopes) + ", " + ;
                EscaparSQL(THIS.this_cDopps) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumps, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNops, 0) + ", " + ;
                EscaparSQL(THIS.this_cCpros) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtds, 3) + ", "
            loc_cSQL = loc_cSQL + ;
                FormatarDataSQL(THIS.this_dDataes) + ", " + ;
                FormatarDataSQL(THIS.this_dDataps) + ", " + ;
                FormatarDataSQL(THIS.this_dDataTrans) + ", " + ;
                FormatarDataSQL(THIS.this_dDtGeras) + ", " + ;
                FormatarDataSQL(THIS.this_dDtFunds) + ", " + ;
                EscaparSQL(THIS.this_cLocals) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNtrans, 0) + ", " + ;
                EscaparSQL(THIS.this_cEmpDs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSeqDivs, 0) + ", "
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCodCors) + ", " + ;
                EscaparSQL(THIS.this_cCodTams) + ", " + ;
                IIF(THIS.this_lDivs, "1", "0") + ", " + ;
                IIF(THIS.this_lImprs, "1", "0") + ", " + ;
                IIF(THIS.this_lIimprs, "1", "0") + ", " + ;
                EscaparSQL(THIS.this_cUsuars) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNopMaes, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPesos, 3) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCodBarras, 0) + ", "
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nQtdCpnts, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtdTubos, 3) + ", " + ;
                EscaparSQL(THIS.this_cMoedas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nUnits, 6) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNfunds, 0) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDnps, 33)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopnops, 33)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopnums, 29)) + ", " + ;
                EscaparSQL(THIS.this_cNotas) + ", " + ;
                EscaparSQL(THIS.this_cCodTgOps) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCitens, 0) + ", " + ;
                EscaparSQL(THIS.this_cObss) + ")"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRes >= 0
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("INSERT")
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir Ordem de Produ" + CHR(231) + CHR(227) + "o em SigOpPic."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Inserir OP")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente em SigOpPic (pela PK Cidchaves)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRes
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cMensagemErro = "Chave (Cidchaves) obrigat" + CHR(243) + "ria para atualizar."
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "UPDATE SigOpPic SET " + ;
                    "Emps = "      + EscaparSQL(THIS.this_cEmps)  + ", " + ;
                    "Dopes = "     + EscaparSQL(THIS.this_cDopes) + ", " + ;
                    "Dopps = "     + EscaparSQL(THIS.this_cDopps) + ", " + ;
                    "Numes = "     + FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                    "Numps = "     + FormatarNumeroSQL(THIS.this_nNumps, 0) + ", " + ;
                    "Nops = "      + FormatarNumeroSQL(THIS.this_nNops, 0) + ", " + ;
                    "Cpros = "     + EscaparSQL(THIS.this_cCpros) + ", " + ;
                    "Dpros = "     + EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ", " + ;
                    "Qtds = "      + FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                    "Dataes = "    + FormatarDataSQL(THIS.this_dDataes) + ", " + ;
                    "Dataps = "    + FormatarDataSQL(THIS.this_dDataps) + ", " + ;
                    "DataTrans = " + FormatarDataSQL(THIS.this_dDataTrans) + ", " + ;
                    "DtGeras = "   + FormatarDataSQL(THIS.this_dDtGeras) + ", " + ;
                    "DtFunds = "   + FormatarDataSQL(THIS.this_dDtFunds) + ", " + ;
                    "Locals = "    + EscaparSQL(THIS.this_cLocals) + ", " + ;
                    "Ntrans = "    + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ", " + ;
                    "Empds = "     + EscaparSQL(THIS.this_cEmpDs) + ", " + ;
                    "SeqDivs = "   + FormatarNumeroSQL(THIS.this_nSeqDivs, 0) + ", " + ;
                    "CodCors = "   + EscaparSQL(THIS.this_cCodCors) + ", " + ;
                    "CodTams = "   + EscaparSQL(THIS.this_cCodTams) + ", " + ;
                    "Divs = "      + IIF(THIS.this_lDivs, "1", "0") + ", " + ;
                    "Imprs = "     + IIF(THIS.this_lImprs, "1", "0") + ", " + ;
                    "Iimprs = "    + IIF(THIS.this_lIimprs, "1", "0") + ", " + ;
                    "Usuars = "    + EscaparSQL(THIS.this_cUsuars) + ", " + ;
                    "NopMaes = "   + FormatarNumeroSQL(THIS.this_nNopMaes, 0) + ", " + ;
                    "Pesos = "     + FormatarNumeroSQL(THIS.this_nPesos, 3) + ", " + ;
                    "CodBarras = " + FormatarNumeroSQL(THIS.this_nCodBarras, 0) + ", " + ;
                    "QtdCpnts = "  + FormatarNumeroSQL(THIS.this_nQtdCpnts, 0) + ", " + ;
                    "QtdTubos = "  + FormatarNumeroSQL(THIS.this_nQtdTubos, 3) + ", " + ;
                    "Moedas = "    + EscaparSQL(THIS.this_cMoedas) + ", " + ;
                    "Units = "     + FormatarNumeroSQL(THIS.this_nUnits, 6) + ", " + ;
                    "Nfunds = "    + FormatarNumeroSQL(THIS.this_nNfunds, 0) + ", " + ;
                    "Notas = "     + EscaparSQL(THIS.this_cNotas) + ", " + ;
                    "CodTgOps = "  + EscaparSQL(THIS.this_cCodTgOps) + ", " + ;
                    "Citens = "    + FormatarNumeroSQL(THIS.this_nCitens, 0) + ", " + ;
                    "Obss = "      + EscaparSQL(THIS.this_cObss) + " " + ;
                    "WHERE Cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRes >= 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("UPDATE")
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar Ordem de Produ" + CHR(231) + CHR(227) + "o em SigOpPic."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Atualizar OP")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Remove registro de SigOpPic pela PK Cidchaves
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRes
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cMensagemErro = "Chave (Cidchaves) obrigat" + CHR(243) + "ria para excluir."
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "DELETE FROM SigOpPic WHERE Cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRes >= 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("DELETE")
                ELSE
                    THIS.this_cMensagemErro = "Falha ao excluir Ordem de Produ" + CHR(231) + CHR(227) + "o em SigOpPic."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Excluir OP")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorChave - Carrega um registro de SigOpPic pela PK Cidchaves
    *==========================================================================
    PROCEDURE CarregarPorChave(par_cCidChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = "cursor_4c_CarregaOp"
        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF
            loc_cSQL = "SELECT * FROM SigOpPic WHERE Cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) < 1
                THIS.this_cMensagemErro = "Falha ao carregar registro de SigOpPic."
            ELSE
                IF RECCOUNT(loc_cCursor) > 0
                    loc_lSucesso = THIS.CarregarDoCursor(loc_cCursor)
                ELSE
                    THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado em SigOpPic."
                ENDIF
                USE IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Carregar OP")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarOperacoes - Carrega cursor de operacoes validas (cursor_4c_TmpOper)
    * Retorna .T. se encontrou ao menos uma operacao configurada
    *==========================================================================
    PROCEDURE CarregarOperacoes()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOper)
                USE IN (THIS.this_cCursorOper)
            ENDIF

            loc_cSQL = "SELECT ISNULL(b.OpeGops, ' ') AS OpeGops, " + ;
                       "ISNULL(b.CodTgOps, ' ') AS CodTgOps, " + ;
                       "a.Dopes, a.NDopes, a.Globalizas, a.Reservas, a.Opers, " + ;
                       "0 AS Acesso, b.chkObs, c.carcompos " + ;
                       "FROM SigCdOpe a " + ;
                       "LEFT JOIN SigOpCdd b ON b.dopes = a.dopes " + ;
                       "LEFT JOIN SigOpCdc c ON a.dopes = c.dopes " + ;
                       "WHERE a.Globalizas IN (1, 2)"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOper) < 1
                MsgErro("Falha ao carregar Opera" + CHR(231) + CHR(245) + "es.", "Erro")
            ELSE
                SELECT (THIS.this_cCursorOper)
                INDEX ON Dopes TAG Dopes
                GO TOP
                IF EOF()
                    MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Configurada Para Processar Ordem de Produ" + CHR(231) + CHR(227) + "o!!!")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarTiposGeracao - Carrega cursor de tipos de geracao de OP
    * Resultado em cursor_4c_CrTmpTpGop
    *==========================================================================
    PROCEDURE CarregarTiposGeracao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorTiposGO)
                USE IN (THIS.this_cCursorTiposGO)
            ENDIF
            IF USED("cursor_4c_TmpTpGop_raw")
                USE IN cursor_4c_TmpTpGop_raw
            ENDIF

            loc_cSQL = "SELECT 1 AS Acesso, * FROM SigInTgo"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpTpGop_raw") < 1
                MsgErro("Falha ao carregar Tipos de Gera" + CHR(231) + CHR(227) + "o.", "Erro")
            ELSE
                SELECT * FROM cursor_4c_TmpTpGop_raw ;
                    WHERE Acesso = 1 ;
                    INTO CURSOR (THIS.this_cCursorTiposGO) READWRITE
                USE IN cursor_4c_TmpTpGop_raw

                SELECT (THIS.this_cCursorTiposGO)
                INDEX ON Codigos TAG Codigos
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega parametros do sistema de SigCdPam
    * Resultado em cursor_4c_CrSigCdPam
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_cCampos
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorParam)
                USE IN (THIS.this_cCursorParam)
            ENDIF

            loc_cCampos = "DopEmphs, DopReqcs, DopPedcs, DopComps, TransfRes, GrPadClis, " + ;
                          "DoppPads, DopTrfCps, GrPadVens, PrevProds, GrupoEsts, ContaEsts, " + ;
                          "GruReservs, ConReservs, AgrupEmph, DoppServs, mascnums, GruEstps, " + ;
                          "ConEstps, transfencs, Ouros, GruConfs, ConConfs, " + ;
                          "GlobAutos, DopEntAus, TpOpEntAus, AutComps"

            loc_cSQL = "SELECT TOP 1 " + loc_cCampos + " FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorParam) < 1
                MsgErro("Falha ao carregar Par" + CHR(226) + "metros (SigCdPam).", "Erro")
            ELSE
                IF RECCOUNT(THIS.this_cCursorParam) = 0
                    MsgErro("Par" + CHR(226) + "metros do sistema n" + CHR(227) + "o configurados (SigCdPam vazio).", "Erro")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPacotes - Carrega SigCdPac (configuracoes de pacote)
    * Resultado em cursor_4c_CrSigCdPac
    *==========================================================================
    PROCEDURE CarregarPacotes()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_CrSigCdPac")
                USE IN cursor_4c_CrSigCdPac
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CrSigCdPac") < 1
                MsgErro("Falha ao carregar SigCdPac.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida parametros obrigatorios antes do processamento
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.
        TRY
            IF !THIS.this_lReserva
                IF EMPTY(THIS.this_dPrevisao)
                    MsgAviso("A Data de Previs" + CHR(227) + "o Deve Ser Preenchida!!!")
                    loc_lValido = .F.
                ENDIF
                IF loc_lValido AND !THIS.this_lAutomatico AND EMPTY(THIS.this_dGeracao)
                    MsgAviso("A Data de Gera" + CHR(231) + CHR(227) + "o Deve Ser Preenchida!!!")
                    loc_lValido = .F.
                ENDIF
            ENDIF
            IF loc_lValido AND !EMPTY(THIS.this_dDataef)
                IF !EMPTY(THIS.this_dDataei) AND THIS.this_dDataef < THIS.this_dDataei
                    MsgAviso("A Data Final de Emiss" + CHR(227) + "o Deve Ser Maior Que a Inicial!!!")
                    loc_lValido = .F.
                ENDIF
            ENDIF
            IF loc_lValido AND !EMPTY(THIS.this_dDatapf)
                IF !EMPTY(THIS.this_dDatapi) AND THIS.this_dDatapf < THIS.this_dDatapi
                    MsgAviso("A Data Final de Previs" + CHR(227) + "o de Entrega Deve Ser Maior Que a Inicial!!!")
                    loc_lValido = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarNumeroOP - Verifica se numero de OP ja existe em SigOpPic
    * Retorna .T. se o numero JA existe (impede uso)
    *==========================================================================
    PROCEDURE VerificarNumeroOP(par_nNumeroOP)
        LOCAL loc_lExiste, loc_cSQL
        loc_lExiste = .F.
        TRY
            IF par_nNumeroOP > 0
                loc_cSQL = "SELECT Numps FROM SigOpPic WHERE Numps = " + FormatarNumeroSQL(par_nNumeroOP, 0)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpi") >= 1
                    loc_lExiste = (RECCOUNT("cursor_4c_TmpOpi") > 0)
                ENDIF
                IF USED("cursor_4c_TmpOpi")
                    USE IN cursor_4c_TmpOpi
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * ProcessarOP - Processa ordens de producao conforme parametros configurados
    * Popula cursor_4c_TmpCabec e cursor_4c_TmpItens para FormSigPrGl2
    * Retorna .T. se encontrou registros para processar
    *==========================================================================
    PROCEDURE ProcessarOP()
        LOCAL loc_lSucesso, loc_lAbort, loc_cSQL
        LOCAL loc_cConde, loc_cCondp, loc_cDopp, loc_cLcEmp, loc_cTpGOp
        LOCAL loc_cOperacao, loc_nOperacaoi, loc_nOperacaof
        LOCAL loc_cGrupo, loc_cConta, loc_cGrupoV, loc_cContaV
        LOCAL loc_nTPeso, loc_lProcessa, loc_nSaldo, loc_nPeso, loc_nQtdTb
        LOCAL loc_cGrupoG, loc_cContaG, loc_cGrupoD, loc_cContaD
        LOCAL loc_cEdn, loc_cDConta
        LOCAL loc_oProg
        LOCAL loc_nOpZers, loc_nEntPes
        LOCAL loc_cDopes, loc_nGlobalizas, loc_cOpers, loc_cOpeGops, loc_nCarCompos
        LOCAL loc_cCodTgOps
        LOCAL loc_nGruDests, loc_nConDests
        LOCAL loc_xBaixa, loc_pItn
        LOCAL loc_lBrk1, loc_lBrk2, loc_lBrk3

        loc_lSucesso = .F.
        loc_lAbort   = .F.
        TRY
            *-- Verificar pre-requisitos
            IF !USED(THIS.this_cCursorOper)
                MsgErro("Opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o carregadas. Execute CarregarOperacoes() antes.", "Erro")
                loc_lAbort = .T.
            ENDIF
            IF !loc_lAbort AND !USED(THIS.this_cCursorParam)
                MsgErro("Par" + CHR(226) + "metros n" + CHR(227) + "o carregados. Execute CarregarParametros() antes.", "Erro")
                loc_lAbort = .T.
            ENDIF

            IF !loc_lAbort
                *-- Fechar cursores de saida anteriores
                IF USED(THIS.this_cCursorCabec)
                    USE IN (THIS.this_cCursorCabec)
                ENDIF
                IF USED(THIS.this_cCursorItens)
                    USE IN (THIS.this_cCursorItens)
                ENDIF
                IF USED("cursor_4c_DbParam")
                    USE IN cursor_4c_DbParam
                ENDIF
                IF USED("cursor_4c_SelPedra")
                    USE IN cursor_4c_SelPedra
                ENDIF
                IF USED("cursor_4c_Produtos")
                    USE IN cursor_4c_Produtos
                ENDIF

                *-- Copiar parametros para variaveis locais
                loc_cOperacao  = ALLTRIM(THIS.this_cOperacao)
                loc_nOperacaoi = THIS.this_nOperacaoi
                loc_nOperacaof = THIS.this_nOperacaof
                loc_cGrupo     = ALLTRIM(THIS.this_cGrupoConta)
                loc_cConta     = ALLTRIM(THIS.this_cConta)
                loc_cGrupoV    = ALLTRIM(THIS.this_cGrupoResp)
                loc_cContaV    = ALLTRIM(THIS.this_cContaResp)
                loc_cTpGOp     = ALLTRIM(THIS.this_cTipoGerOP)
                loc_cLcEmp     = IIF(EMPTY(THIS.this_cCodEmpresa), go_4c_Sistema.cCodEmpresa, ALLTRIM(THIS.this_cCodEmpresa))

                *-- Carregar SigCdOpd para a operacao padrao (DoppPads de SigCdPam)
                SELECT (THIS.this_cCursorParam)
                loc_cDopp = ALLTRIM(NVL(DoppPads, ""))
                IF USED("cursor_4c_CrSigCdOpd")
                    USE IN cursor_4c_CrSigCdOpd
                ENDIF
                loc_cSQL = "SELECT GruDests, ConDests FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cDopp)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CrSigCdOpd") < 1
                    MsgErro("Falha ao carregar SigCdOpd.", "Erro")
                    loc_lAbort = .T.
                ENDIF
            ENDIF

            IF !loc_lAbort
                *-- Construir condicao de data de emissao
                IF EMPTY(THIS.this_dDataef)
                    loc_cConde = ""
                ELSE
                    IF !EMPTY(THIS.this_dDataei)
                        loc_cConde = "Datas >= " + FormatarDataSQL(THIS.this_dDataei) + ;
                                     " AND Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDataef) + ") AND "
                    ELSE
                        loc_cConde = "Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDataef) + ") AND "
                    ENDIF
                ENDIF

                *-- Construir condicao de data de previsao de entrega
                IF EMPTY(THIS.this_dDatapi)
                    IF EMPTY(THIS.this_dDatapf)
                        loc_cCondp = ""
                    ELSE
                        loc_cCondp = "PrazoEnts < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDatapf) + ") AND "
                    ENDIF
                ELSE
                    IF EMPTY(THIS.this_dDatapf)
                        loc_cCondp = "PrazoEnts >= " + FormatarDataSQL(THIS.this_dDatapi) + " AND "
                    ELSE
                        loc_cCondp = "PrazoEnts >= " + FormatarDataSQL(THIS.this_dDatapi) + ;
                                     " AND PrazoEnts < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDatapf) + ") AND "
                    ENDIF
                ENDIF

                *-- Preparar DbParam (configuracoes de tipo de geracao)
                loc_nOpZers = 0
                loc_nEntPes = 0
                IF THIS.this_lGerPorTp AND USED(THIS.this_cCursorTiposGO)
                    IF SEEK(loc_cTpGOp, THIS.this_cCursorTiposGO, "Codigos")
                        SELECT (THIS.this_cCursorTiposGO)
                        loc_nOpZers = NVL(OpZers, 0)
                        loc_nEntPes = NVL(EntPes, 0)
                    ENDIF
                ELSE
                    IF USED("cursor_4c_CrSigCdPac")
                        SELECT cursor_4c_CrSigCdPac
                        GO TOP
                        IF !EOF()
                            loc_nOpZers = NVL(OpZers, 0)
                        ENDIF
                    ENDIF
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_DbParam (CodTgOps C(10) NULL, OpZers N(1) NULL, EntPes N(1) NULL)
                INSERT INTO cursor_4c_DbParam (CodTgOps, OpZers, EntPes) VALUES (loc_cTpGOp, loc_nOpZers, loc_nEntPes)
                SET NULL OFF

                *-- Criar cursor de selecao de pedras
                SET NULL ON
                CREATE CURSOR cursor_4c_SelPedra (Cpros C(14) NULL, Dpros C(40) NULL, Cunis C(3) NULL, Qtds N(12,3) NULL, Cpro2s C(14) NULL)
                SET NULL OFF

                *-- Criar cursor de produtos sem qtd de componentes
                CREATE CURSOR cursor_4c_Produtos (Cpros C(14), Dpros C(40), cmats C(14))
                INDEX ON Cpros TAG Cpros

                *-- Criar cursor de cabecalhos
                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorCabec) ;
                    (Flag L NULL, Emps C(3) NULL, Dopes C(20) NULL, Numes N(6) NULL, ;
                     Grupo C(10) NULL, Conta C(10) NULL, Datas D NULL, Entregas D NULL, ;
                     Grupov C(10) NULL, Contav C(10) NULL, Obs M NULL, Peso N(12,2) NULL, ;
                     GrupoDs C(10) NULL, ContaDs C(10) NULL, DConta C(40) NULL, ;
                     Notas C(6) NULL, Jobs C(10) NULL)
                SET NULL OFF
                INDEX ON DTOS(Entregas) + Emps + Dopes + STR(Numes, 6) TAG Entrega
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG Empdopnum
                SET ORDER TO TAG Empdopnum

                *-- Criar cursor de itens
                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorItens) ;
                    (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6) NULL, CPros C(14) NULL, ;
                     Qtds N(12,3) NULL, Saldo N(12,3) NULL, Peso N(9,3) NULL, Obs M NULL, ;
                     Linhas C(10) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                     Citens N(10) NULL, Notas C(6) NULL, dpros C(40) NULL, Reffs C(40) NULL)
                SET NULL OFF
                INDEX ON Linhas + Cpros TAG LinPro
                INDEX ON Cpros TAG Cpros
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG Empdopnum
                SET ORDER TO TAG Empdopnum

                *-- Loop principal: percorre cada operacao
                SELECT (THIS.this_cCursorOper)
                SET ORDER TO TAG Dopes
                IF !EMPTY(loc_cOperacao)
                    SET KEY TO loc_cOperacao
                ENDIF

                loc_lBrk1 = .F.
                SCAN WHILE !loc_lBrk1

                    loc_cDopes      = ALLTRIM(Dopes)
                    loc_nGlobalizas = NVL(Globalizas, 0)
                    loc_cOpers      = ALLTRIM(NVL(Opers, ""))
                    loc_cOpeGops    = ALLTRIM(NVL(OpeGops, ""))
                    loc_nCarCompos  = NVL(carcompos, 0)
                    loc_cCodTgOps   = ALLTRIM(NVL(CodTgOps, ""))

                    *-- Filtrar por tipo de geracao se GerPorTp
                    IF THIS.this_lGerPorTp AND loc_cCodTgOps <> loc_cTpGOp
                        LOOP
                    ENDIF

                    *-- Construir SQL para buscar movimentos desta operacao
                    loc_cSQL = "SELECT Emps, Dopes, Numes, Datas, PrazoEnts, GrupoOs, ContaOs, " + ;
                               "GrupoDs, ContaDs, GrVends, Vends, Obses, rNops, Notas, Jobs, Dpros " + ;
                               "FROM SigMvCab " + ;
                               "WHERE " + loc_cConde + loc_cCondp + ;
                               "Emps = " + EscaparSQL(loc_cLcEmp) + ;
                               " AND Dopes = " + EscaparSQL(loc_cDopes)

                    IF !EMPTY(loc_cGrupo)
                        IF loc_nGlobalizas = 1
                            loc_cSQL = loc_cSQL + " AND GrupoOs = " + EscaparSQL(loc_cGrupo)
                        ENDIF
                        IF loc_nGlobalizas = 2
                            loc_cSQL = loc_cSQL + " AND GrupoDs = " + EscaparSQL(loc_cGrupo)
                        ENDIF
                    ENDIF
                    IF !EMPTY(loc_cConta)
                        IF loc_nGlobalizas = 1
                            loc_cSQL = loc_cSQL + " AND ContaOs = " + EscaparSQL(loc_cConta)
                        ENDIF
                        IF loc_nGlobalizas = 2
                            loc_cSQL = loc_cSQL + " AND ContaDs = " + EscaparSQL(loc_cConta)
                        ENDIF
                    ENDIF
                    IF !EMPTY(loc_cGrupoV)
                        loc_cSQL = loc_cSQL + " AND GrVends = " + EscaparSQL(loc_cGrupoV)
                    ENDIF
                    IF !EMPTY(loc_cContaV)
                        loc_cSQL = loc_cSQL + " AND Vends = " + EscaparSQL(loc_cContaV)
                    ENDIF
                    loc_cSQL = loc_cSQL + " AND Nops = 0"

                    IF USED("cursor_4c_TempEest")
                        USE IN cursor_4c_TempEest
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempEest") < 1
                        MsgErro("Falha na Conex" + CHR(227) + "o (TempEest - Dopes=" + loc_cDopes + ")", "Erro")
                        loc_lBrk1 = .T.
                        EXIT
                    ENDIF

                    loc_oProg = CREATEOBJECT("fwprogressbar", ;
                        "Processando Opera" + CHR(231) + CHR(227) + "o " + loc_cDopes + "...", ;
                        RECCOUNT("cursor_4c_TempEest"))
                    loc_oProg.Show()

                    SELECT cursor_4c_TempEest
                    loc_lBrk2 = .F.
                    SCAN WHILE !loc_lBrk2
                        loc_oProg.Update(.T.)

                        *-- Filtro por faixa de numero de movimentacao
                        IF !EMPTY(loc_cOperacao)
                            IF loc_nOperacaoi > 0 AND loc_nOperacaof > 0
                                IF !BETWEEN(cursor_4c_TempEest.Numes, loc_nOperacaoi, loc_nOperacaof)
                                    LOOP
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Ignorar se Reserva e ja tem OP gerada
                        IF THIS.this_lReserva AND NVL(cursor_4c_TempEest.rNops, 0) > 0
                            LOOP
                        ENDIF

                        *-- Determinar grupo/conta pela Globalizas
                        IF loc_nGlobalizas = 1
                            loc_cGrupoG = ALLTRIM(NVL(cursor_4c_TempEest.GrupoOs, ""))
                            loc_cContaG = ALLTRIM(NVL(cursor_4c_TempEest.ContaOs, ""))
                        ELSE
                            loc_cGrupoG = ALLTRIM(NVL(cursor_4c_TempEest.GrupoDs, ""))
                            loc_cContaG = ALLTRIM(NVL(cursor_4c_TempEest.ContaDs, ""))
                        ENDIF

                        loc_nTPeso    = 0
                        loc_lProcessa = .F.
                        loc_cEdn      = ALLTRIM(cursor_4c_TempEest.Emps) + ;
                                        ALLTRIM(cursor_4c_TempEest.Dopes) + ;
                                        STR(cursor_4c_TempEest.Numes, 6)

                        *-- Buscar itens da movimentacao (SigMvItn)
                        IF USED("cursor_4c_TempEestI")
                            USE IN cursor_4c_TempEestI
                        ENDIF
                        loc_cSQL = "SELECT CPros, CItens, Qtds, QtBaixas, QtProds, Pesos, " + ;
                                   "Emps, Dopes, Numes, Obs, Notas, Dpros, Opers, Citem2 " + ;
                                   "FROM SigMvItn " + ;
                                   "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempEestI") < 1
                            MsgErro("Falha na Conex" + CHR(227) + "o (TempEestI - Mov=" + loc_cEdn + ")", "Erro")
                            loc_lBrk2 = .T.
                            EXIT
                        ENDIF

                        SELECT cursor_4c_TempEestI
                        loc_lBrk3 = .F.
                        SCAN WHILE !loc_lBrk3
                            *-- Filtro por OpeGops se Opers = 3
                            IF loc_cOpers = "3" AND !EMPTY(loc_cOpeGops) AND ;
                               ALLTRIM(NVL(cursor_4c_TempEestI.Opers, "")) <> loc_cOpeGops
                                LOOP
                            ENDIF

                            *-- Filtro por composicao
                            IF loc_nCarCompos = 5 AND NVL(cursor_4c_TempEestI.Citem2, 0) <> 0
                                LOOP
                            ENDIF

                            *-- Buscar dados do produto (SigCdPro)
                            IF USED("cursor_4c_crSigCdPro")
                                USE IN cursor_4c_crSigCdPro
                            ENDIF
                            loc_cSQL = "SELECT Pesoms, Linhas, QtdCpnts, DPros, Reffs, Cgrus " + ;
                                       "FROM SigCdPro WHERE CPros = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_TempEestI.CPros))
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_crSigCdPro") < 1
                                MsgErro("Falha ao carregar SigCdPro (" + ALLTRIM(cursor_4c_TempEestI.CPros) + ")", "Erro")
                                loc_lBrk3 = .T.
                                EXIT
                            ENDIF
                            SELECT cursor_4c_crSigCdPro
                            GO TOP

                            *-- Buscar grupo do produto (SigCdGrp)
                            IF USED("cursor_4c_crSigCdGrp")
                                USE IN cursor_4c_crSigCdGrp
                            ENDIF
                            loc_cSQL = "SELECT GeraTubs FROM SigCdGrp WHERE CGrus = " + ;
                                       EscaparSQL(ALLTRIM(NVL(cursor_4c_crSigCdPro.CGrus, "")))
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_crSigCdGrp") < 1
                                MsgErro("Falha ao carregar SigCdGrp.", "Erro")
                                loc_lBrk3 = .T.
                                EXIT
                            ENDIF
                            SELECT cursor_4c_crSigCdGrp
                            GO TOP

                            *-- Buscar tamanhos do item (SigMvIts)
                            loc_pItn = NVL(cursor_4c_TempEestI.CItens, 0)
                            IF USED("cursor_4c_TempEsti2")
                                USE IN cursor_4c_TempEsti2
                            ENDIF
                            loc_cSQL = "SELECT * FROM SigMvIts " + ;
                                       "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                                       " AND CItens = " + FormatarNumeroSQL(loc_pItn, 0)
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempEsti2") < 1
                                MsgErro("Falha na Conex" + CHR(227) + "o (TempEsti2)", "Erro")
                                loc_lBrk3 = .T.
                                EXIT
                            ENDIF
                            SELECT cursor_4c_TempEsti2
                            GO TOP

                            IF EOF("cursor_4c_TempEsti2")
                                *-- Sem tamanhos: usar quantidade do item principal
                                SELECT cursor_4c_TempEestI
                                loc_xBaixa = IIF(NVL(QtBaixas, 0) > 0 AND NVL(QtBaixas, 0) >= NVL(QtProds, 0), ;
                                                 NVL(QtBaixas, 0) - NVL(QtProds, 0), 0) + NVL(QtProds, 0)
                                loc_nSaldo = NVL(Qtds, 0) - loc_xBaixa
                                loc_nPeso  = IIF(EMPTY(NVL(Pesos, 0)), NVL(cursor_4c_crSigCdPro.Pesoms, 0), NVL(Pesos, 0))
                                IF loc_nSaldo <> 0
                                    SELECT (THIS.this_cCursorItens)
                                    INSERT INTO (THIS.this_cCursorItens) ;
                                        (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, ;
                                         Linhas, Citens, Notas, dpros, Reffs) ;
                                        VALUES (cursor_4c_TempEestI.Emps, cursor_4c_TempEestI.Dopes, ;
                                                cursor_4c_TempEestI.Numes, cursor_4c_TempEestI.CPros, ;
                                                cursor_4c_TempEestI.Qtds, loc_nSaldo, ;
                                                cursor_4c_TempEestI.Obs, loc_nPeso, ;
                                                cursor_4c_crSigCdPro.Linhas, ;
                                                cursor_4c_TempEestI.Citens, ;
                                                cursor_4c_TempEest.Notas, ;
                                                cursor_4c_TempEest.Dpros, ;
                                                cursor_4c_crSigCdPro.Reffs)
                                    loc_nTPeso    = loc_nTPeso + (loc_nPeso * loc_nSaldo)
                                    loc_lProcessa = .T.

                                    *-- Verificar qtd componentes do produto (GeraTubs)
                                    SELECT cursor_4c_crSigCdGrp
                                    GO TOP
                                    IF !EOF() AND NVL(GeraTubs, 0) = 2
                                        IF USED("cursor_4c_SigPrMtz")
                                            USE IN cursor_4c_SigPrMtz
                                        ENDIF
                                        loc_cSQL = "SELECT SUM(qtds) AS total FROM SigPrMtz " + ;
                                                   "WHERE Cpros = " + EscaparSQL(ALLTRIM(cursor_4c_TempEestI.CPros))
                                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrMtz") >= 1
                                            SELECT cursor_4c_SigPrMtz
                                            loc_nQtdTb = NVL(total, 0)
                                            USE IN cursor_4c_SigPrMtz
                                        ELSE
                                            loc_nQtdTb = 0
                                        ENDIF
                                    ELSE
                                        loc_nQtdTb = NVL(cursor_4c_crSigCdPro.QtdCpnts, 0)
                                    ENDIF

                                    IF loc_nQtdTb = 0
                                        IF !SEEK(ALLTRIM(cursor_4c_TempEestI.CPros), "cursor_4c_Produtos", "Cpros")
                                            SELECT cursor_4c_Produtos
                                            INSERT INTO cursor_4c_Produtos (Cpros, DPros) ;
                                                VALUES (ALLTRIM(cursor_4c_TempEestI.CPros), ;
                                                        ALLTRIM(NVL(cursor_4c_crSigCdPro.Dpros, "")))
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ELSE
                                *-- Com tamanhos: usar cada registro de SigMvIts
                                SELECT cursor_4c_TempEsti2
                                SCAN
                                    loc_xBaixa = IIF(NVL(cursor_4c_TempEsti2.QtBaixas, 0) > 0 AND ;
                                                     NVL(cursor_4c_TempEsti2.QtBaixas, 0) >= NVL(cursor_4c_TempEsti2.QtProds, 0), ;
                                                     NVL(cursor_4c_TempEsti2.QtBaixas, 0) - NVL(cursor_4c_TempEsti2.QtProds, 0), 0) + ;
                                                 NVL(cursor_4c_TempEsti2.QtProds, 0)
                                    loc_nSaldo = NVL(cursor_4c_TempEsti2.Qtds, 0) - loc_xBaixa
                                    loc_nPeso  = IIF(EMPTY(NVL(cursor_4c_TempEsti2.Pesos, 0)), ;
                                                     NVL(cursor_4c_crSigCdPro.Pesoms, 0), ;
                                                     NVL(cursor_4c_TempEsti2.Pesos, 0))
                                    IF loc_nSaldo <> 0
                                        SELECT (THIS.this_cCursorItens)
                                        INSERT INTO (THIS.this_cCursorItens) ;
                                            (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, ;
                                             Linhas, CodCors, CodTams, Citens, Notas, dpros, Reffs) ;
                                            VALUES (cursor_4c_TempEsti2.Emps, cursor_4c_TempEsti2.Dopes, ;
                                                    cursor_4c_TempEsti2.Numes, cursor_4c_TempEsti2.CPros, ;
                                                    cursor_4c_TempEsti2.Qtds, loc_nSaldo, ;
                                                    cursor_4c_TempEestI.Obs, loc_nPeso, ;
                                                    cursor_4c_crSigCdPro.Linhas, ;
                                                    cursor_4c_TempEsti2.CodCors, ;
                                                    cursor_4c_TempEsti2.CodTams, ;
                                                    cursor_4c_TempEsti2.CItens, ;
                                                    cursor_4c_TempEest.Notas, ;
                                                    cursor_4c_TempEest.Dpros, ;
                                                    cursor_4c_crSigCdPro.Reffs)
                                        loc_nTPeso    = loc_nTPeso + (loc_nPeso * loc_nSaldo)
                                        loc_lProcessa = .T.

                                        *-- Verificar qtd componentes (GeraTubs)
                                        SELECT cursor_4c_crSigCdGrp
                                        GO TOP
                                        IF !EOF() AND NVL(GeraTubs, 0) = 2
                                            IF USED("cursor_4c_SigPrMtz")
                                                USE IN cursor_4c_SigPrMtz
                                            ENDIF
                                            loc_cSQL = "SELECT SUM(qtds) AS total FROM SigPrMtz " + ;
                                                       "WHERE Cpros = " + EscaparSQL(ALLTRIM(cursor_4c_TempEsti2.CPros))
                                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrMtz") >= 1
                                                SELECT cursor_4c_SigPrMtz
                                                loc_nQtdTb = NVL(total, 0)
                                                USE IN cursor_4c_SigPrMtz
                                            ELSE
                                                loc_nQtdTb = 0
                                            ENDIF
                                        ELSE
                                            loc_nQtdTb = NVL(cursor_4c_crSigCdPro.QtdCpnts, 0)
                                        ENDIF

                                        IF loc_nQtdTb = 0
                                            IF !SEEK(ALLTRIM(cursor_4c_TempEsti2.CPros), "cursor_4c_Produtos", "Cpros")
                                                SELECT cursor_4c_Produtos
                                                INSERT INTO cursor_4c_Produtos (Cpros, DPros) ;
                                                    VALUES (ALLTRIM(cursor_4c_TempEsti2.CPros), ;
                                                            ALLTRIM(NVL(cursor_4c_crSigCdPro.Dpros, "")))
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDSCAN
                            ENDIF

                            *-- Reposicionar em TempEestI para continuar o SCAN
                            SELECT cursor_4c_TempEestI
                        ENDSCAN

                        IF loc_lBrk3
                            loc_lBrk2 = .T.
                            EXIT
                        ENDIF

                        *-- Se encontrou itens para processar, inserir cabecalho
                        IF loc_lProcessa
                            *-- Determinar grupo/conta de destino (da SigCdOpd)
                            SELECT cursor_4c_CrSigCdOpd
                            GO TOP
                            IF !EOF()
                                loc_cGrupoD = ALLTRIM(IIF(EMPTY(NVL(GruDests, "")), ;
                                                          ALLTRIM(NVL(cursor_4c_TempEest.GrupoDs, "")), ;
                                                          NVL(GruDests, "")))
                                loc_cContaD = ALLTRIM(IIF(EMPTY(NVL(ConDests, "")), ;
                                                          ALLTRIM(NVL(cursor_4c_TempEest.ContaDs, "")), ;
                                                          NVL(ConDests, "")))
                            ELSE
                                loc_cGrupoD = ALLTRIM(NVL(cursor_4c_TempEest.GrupoDs, ""))
                                loc_cContaD = ALLTRIM(NVL(cursor_4c_TempEest.ContaDs, ""))
                            ENDIF

                            *-- Buscar nome do cliente (DConta) em SigCdCli
                            IF USED("cursor_4c_LocalCli")
                                USE IN cursor_4c_LocalCli
                            ENDIF
                            loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cContaG)
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli") < 1
                                MsgErro("Falha na Conex" + CHR(227) + "o (SigCdCli - Conta=" + loc_cContaG + ")", "Erro")
                                loc_lBrk2 = .T.
                                EXIT
                            ENDIF
                            SELECT cursor_4c_LocalCli
                            GO TOP
                            loc_cDConta = IIF(!EOF(), ALLTRIM(NVL(RClis, "")), "")
                            USE IN cursor_4c_LocalCli

                            SELECT (THIS.this_cCursorCabec)
                            INSERT INTO (THIS.this_cCursorCabec) ;
                                (Flag, Emps, Dopes, Numes, Grupo, Conta, Grupov, Contav, ;
                                 Datas, Entregas, Peso, Obs, GrupoDs, ContaDs, DConta, Notas, Jobs) ;
                                VALUES (.T., cursor_4c_TempEest.Emps, cursor_4c_TempEest.Dopes, ;
                                        cursor_4c_TempEest.Numes, loc_cGrupoG, loc_cContaG, ;
                                        ALLTRIM(NVL(cursor_4c_TempEest.GrVends, "")), ;
                                        ALLTRIM(NVL(cursor_4c_TempEest.Vends, "")), ;
                                        cursor_4c_TempEest.Datas, cursor_4c_TempEest.PrazoEnts, ;
                                        loc_nTPeso, ALLTRIM(NVL(cursor_4c_TempEest.Obses, "")), ;
                                        loc_cGrupoD, loc_cContaD, loc_cDConta, ;
                                        ALLTRIM(NVL(cursor_4c_TempEest.Notas, "")), ;
                                        ALLTRIM(NVL(cursor_4c_TempEest.Jobs, "")))

                            *-- Reposicionar em TempEest para continuar o SCAN
                            SELECT cursor_4c_TempEest
                        ENDIF
                    ENDSCAN

                    IF loc_lBrk2
                        loc_lBrk1 = .T.
                        EXIT
                    ENDIF

                    loc_oProg.Complete(.T.)

                    *-- Reposicionar em TmpOper para continuar o SCAN
                    SELECT (THIS.this_cCursorOper)
                ENDSCAN

                *-- Restaurar SET KEY e SET ORDER
                SELECT (THIS.this_cCursorOper)
                SET KEY TO
                SET ORDER TO

                IF !loc_lBrk1
                    *-- Posicionar cursores de saida no inicio
                    IF USED(THIS.this_cCursorCabec)
                        GO TOP IN (THIS.this_cCursorCabec)
                    ENDIF
                    IF USED(THIS.this_cCursorItens)
                        GO TOP IN (THIS.this_cCursorItens)
                    ENDIF

                    *-- Verificar se encontrou registros
                    loc_lSucesso = USED(THIS.this_cCursorItens) AND USED(THIS.this_cCursorCabec) AND ;
                                   !EOF(THIS.this_cCursorCabec) AND !EOF(THIS.this_cCursorItens)

                    IF !loc_lSucesso
                        MsgAviso("Nenhum Item Selecionado Para Processar!!!")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " Linha=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc=" + loc_oErro.Procedure, "Erro ao ProcessarOP")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

