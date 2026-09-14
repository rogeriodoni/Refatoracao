# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrEs1.prg] Indicador de pendencia: *-- Linha 8: Situacao (Say2 / Opt_Pendente
[FormSigPrEs1.prg] Indicador de pendencia: *   Original: Say2 Left=6 Top=222, Opt_Pendente
[FormSigPrEs1.prg] Indicador de pendencia: *             Value=3 (Todas), 3 options: Pendente

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.prg):
*==============================================================================
* FormSigPrEs1.prg - Posicao Por Movimentacao
* Herda de: FormBase
* Tipo: OPERACIONAL (filtro de criterios -> abre sigpres2 com resultados)
* Migracao de: SIGPRES1.SCX
*
* Pilares:
*   UX   -> pixel-perfect escalado de 823x400 para 1000x600 (ScaleX=1.215 ScaleY=1.5)
*   BD   -> SigMvCab (join SigCdOpe) - nomes exatos do schema
*   CODE -> arquitetura em camadas (FormBase / SigPrEs1BO)
*
* Fases de construcao:
*   FASE 3 (esta): Estrutura base - cabecalho, containers vazios, Destroy
*   FASE 4       : CommandGroup cmg_4c_Sair (Consultar + Encerrar)
*   FASES 5-6   : TextBoxes e controles de filtro em cnt_4c_Container1
*   FASES 7-8   : Eventos (KeyPress, LostFocus, validacoes, CmgConsultarClick)
*
* Nota sobre ConfigurarPageFrame:
*   Este eh um form OPERACIONAL de FILTRO/CONSULTA (nao CRUD).
*   Em vez de um PageFrame Page1=Lista/Page2=Dados, o layout eh
*   container-based: cabecalho no topo + container de filtros + botoes.
*   ConfigurarPageFrame() atua como orquestrador da montagem do layout
*   preservando o contrato semantico do FormBase.
*==============================================================================

DEFINE CLASS FormSigPrEs1 AS FormBase

    *-- Propriedades visuais (PILAR 1 - escalado de 823x400 para 1000x600)
    Width       = 1000
    Height      = 600
    Caption     = "Posi" + CHR(231) + CHR(227) + "o Por Movimenta" + CHR(231) + CHR(227) + "o"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Business Object e modo operacional
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "FILTRO"

    *==========================================================================
    * Init - Delega para FormBase que chama InicializarForm
    * FormBase.Init() seta SET DATE TO BRITISH + SET CENTURY ON (DataSession=2)
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Constroi BO, configura cabecalho e containers base
    * Chamado automaticamente por FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            THIS.ConfigurarCabecalho()
            RETURN .T.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrEs1BO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Carregar GrPadVens e parametros de SigCdPam
                IF gnConnHandle > 0
                    THIS.this_oBusinessObject.CarregarParametros()
                ENDIF

                *-- Pre-popular defaults do BO (equivale ao Init() original)
                THIS.this_oBusinessObject.this_cCdEmpresa = go_4c_Sistema.cCodEmpresa
                THIS.this_oBusinessObject.this_dDtInicial = DATE()
                THIS.this_oBusinessObject.this_dDtFinal   = DATE()
                THIS.this_oBusinessObject.this_nOptPendente = 3

                *-- Orquestrador de montagem do layout (cabecalho + filtros + botoes)
                THIS.ConfigurarPageFrame()

                *-- Tornar todos os controles visiveis
                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPrEs1BO", ;
                        "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Orquestrador de montagem do layout
    * Form OPERACIONAL nao usa PageFrame Page1/Page2 - usa layout container-based:
    *   1) cnt_4c_Sombra (cabecalho cinza no topo)
    *   2) cnt_4c_Container1 (filtros - preenchido na Fase 5-6)
    *   3) cmg_4c_Sair (CommandGroup Consultar+Encerrar)
    * Mantido este nome para compatibilidade com o contrato do FormBase e para
    * refletir o papel de "montador da regiao central" do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura a area principal de trabalho do form
    * OPERACIONAL. Como este form nao usa PageFrame CRUD Page1=Lista/Page2=Dados,
    * este metodo agrega a construcao do container de filtros e os botoes de
    * acao (Consultar + Encerrar), que juntos compoem a "pagina" ativa do form.
    * Nome preservado para compatibilidade com o contrato do FormBase.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarContainerFiltros()
        THIS.ConfigurarBotoes()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna o modo operacional do form
    * Em forms OPERACIONAIS nao existem paginas CRUD (LISTA/DADOS), mas o
    * form mantem um modo logico (FILTRO/RESULTADO) que controla se aceita
    * nova consulta ou esta aguardando retorno de sigpres2. Chamado pelo fluxo
    * de CmgConsultarClick para bloquear reentrancia enquanto o form de
    * resultados esta aberto e para restaurar o estado no retorno.
    * par_cModo: "FILTRO" (aceita entrada) ou "RESULTADO" (bloqueado)
    *==========================================================================
    PROCEDURE AlternarPagina(par_cModo)
        IF PCOUNT() >= 1 AND VARTYPE(par_cModo) = "C" AND !EMPTY(par_cModo)
            THIS.this_cModoAtual = UPPER(ALLTRIM(par_cModo))
        ENDIF

        DO CASE
            CASE THIS.this_cModoAtual == "RESULTADO"
                THIS.Enabled = .F.
            OTHERWISE
                THIS.this_cModoAtual = "FILTRO"
                THIS.Enabled = .T.
                IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
                    IF PEMSTATUS(THIS.cnt_4c_Container1, "txt_4c__nm_operacao", 5)
                        THIS.cnt_4c_Container1.txt_4c__nm_operacao.SetFocus
                    ENDIF
                ENDIF
        ENDCASE
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Cria background e cabecalho cinza superior (cnt_4c_Sombra)
    * Equivale ao cntSombra do legado (Top=0, Left=-12, Width=840, Height=80)
    * Novo: Top=0, Left=0, Width=1000, Height=80
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = "Posi" + CHR(231) + CHR(227) + ;
                       "o Por Movimenta" + CHR(231) + CHR(227) + "o"

        *-- Imagem de fundo (forms OPERACIONAIS usam new_background.jpg)
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0

            *-- Sombra (legado: lblSombra ForeColor=0,0,0 offset +1px)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Caption   = loc_cCaption
            ENDWITH

            *-- Titulo branco (legado: lblTitulo ForeColor=255,255,255)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Caption   = loc_cCaption
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerFiltros - Container dos campos de filtro (Fase 5-6)
    * Equivale ao Container1 do legado (Top=84, Left=84, Width=618, Height=249)
    * Novo escalado: Top=85, Left=0, Width=820, Height=480
    * Conteudo (TextBoxes, Labels, OptionGroups, CheckBox) preenchido na Fase 5-6
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerFiltros()
        THIS.AddObject("cnt_4c_Container1", "Container")
        WITH THIS.cnt_4c_Container1
            .Top         = 85
            .Left        = 0
            .Width       = 820
            .Height      = 490
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarPaginaDados2()
        THIS.ConfigurarLookups()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Adiciona a primeira metade dos controles de filtro
    * ao cnt_4c_Container1: empresa (linha 1), periodo (linha 2),
    * movimentacao/numero/op/status (linha 3), grupo (linha 4), conta/cpf (linha 5).
    * Os controles restantes (responsavel, moeda, situacao, impressao) serao
    * adicionados na Fase 6 por ConfigurarPaginaDados2().
    *
    * Escala original->novo: Container1 618x249 -> 820x490
    *   ScaleX = 820/618 = 1.327  |  ScaleY = 490/249 = 1.968
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1

        *-- -----------------------------------------------------------------------
        *-- LINHA 1: Empresa (y_orig=10-14)
        *-- -----------------------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_empresa
            .Top       = 26
            .Left      = 59
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Empresa :"
        ENDWITH

        loc_oCnt.AddObject("txt_4c__cd_empresa", "TextBox")
        WITH loc_oCnt.txt_4c__cd_empresa
            .Top           = 20
            .Left          = 133
            .Width         = 41
            .Height        = 23
            .Value         = go_4c_Sistema.cCodEmpresa
            .Format        = "K!"
            .MaxLength     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__ds_empresa", "TextBox")
        WITH loc_oCnt.txt_4c__ds_empresa
            .Top           = 20
            .Left          = 178
            .Width         = 386
            .Height        = 23
            .Value         = ""
            .Format        = "K!"
            .MaxLength     = 40
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_ChkEmpD", "CheckBox")
        WITH loc_oCnt.chk_4c_ChkEmpD
            .Top       = 28
            .Left      = 579
            .Width     = 130
            .Height    = 15
            .Value     = 0
            .Caption   = "Empresa Destino"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- -----------------------------------------------------------------------
        *-- LINHA 2: Periodo (y_orig=36-41)
        *-- -----------------------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_periodo
            .Top       = 81
            .Left      = 66
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Per" + CHR(237) + "odo :"
        ENDWITH

        loc_oCnt.AddObject("txt_4c__dt_inicial", "TextBox")
        WITH loc_oCnt.txt_4c__dt_inicial
            .Top           = 73
            .Left          = 133
            .Width         = 106
            .Height        = 23
            .Value         = DATE()
            .Format        = "K"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_periodo_a
            .Top       = 81
            .Left      = 243
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = CHR(224)
        ENDWITH

        loc_oCnt.AddObject("txt_4c__dt_final", "TextBox")
        WITH loc_oCnt.txt_4c__dt_final
            .Top           = 73
            .Left          = 256
            .Width         = 106
            .Height        = 23
            .Value         = DATE()
            .Format        = "K"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
        ENDWITH

        *-- OptionGroup: tipo de periodo (Lancamento / Prazo Entrega)
        loc_oCnt.AddObject("obj_4c_Opt_nr_periodo", "OptionGroup")
        WITH loc_oCnt.obj_4c_Opt_nr_periodo
            .Top           = 71
            .Left          = 362
            .Width         = 246
            .Height        = 25
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .ButtonCount   = 2

            WITH .Buttons(1)
                .Caption   = "Lan" + CHR(231) + "amento"
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 101
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Prazo Entrega"
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .FontName  = "Tahoma"
                .Height    = 15
                .Left      = 125
                .Top       = 5
                .Width     = 116
            ENDWITH

            .Value = 1
        ENDWITH

        *-- -----------------------------------------------------------------------
        *-- LINHA 3: Movimentacao / Numero / OP / Status (y_orig=63-67)
        *-- -----------------------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top       = 132
            .Left      = 23
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
        ENDWITH

        loc_oCnt.AddObject("txt_4c__nm_operacao", "TextBox")
        WITH loc_oCnt.txt_4c__nm_operacao
            .Top           = 124
            .Left          = 133
            .Width         = 199
            .Height        = 23
            .Value         = ""
            .Format        = "K!"
            .MaxLength     = 20
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Numero", "TextBox")
        WITH loc_oCnt.txt_4c_Numero
            .Top           = 124
            .Left          = 334
            .Width         = 73
            .Height        = 23
            .Value         = 0
            .Alignment     = 3
            .Format        = "K"
            .InputMask     = "999999"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oCnt.lbl_4c_Label12
            .Top       = 132
            .Left      = 422
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "OP :"
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Op", "TextBox")
        WITH loc_oCnt.txt_4c_Op
            .Top           = 124
            .Left          = 462
            .Width         = 73
            .Height        = 23
            .Value         = 0
            .Alignment     = 3
            .Format        = "K"
            .InputMask     = "999999"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oCnt.lbl_4c_Label8
            .Top       = 132
            .Left      = 544
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Status :"
        ENDWITH

        loc_oCnt.AddObject("txt_4c_PStatus", "TextBox")
        WITH loc_oCnt.txt_4c_PStatus
            .Top           = 124
            .Left          = 605
            .Width         = 23
            .Height        = 23
            .Value         = ""
            .InputMask     = "A"
            .Margin        = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
        ENDWITH

        *-- -----------------------------------------------------------------------
        *-- LINHA 4: Grupo (y_orig=89-93)
        *-- -----------------------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oCnt.lbl_4c_Label6
            .Top       = 183
            .Left      = 76
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo :"
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oCnt.txt_4c_Grupo
            .Top           = 175
            .Left          = 133
            .Width         = 106
            .Height        = 23
            .Value         = SPACE(10)
            .Format        = "K"
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
        ENDWITH

        loc_oCnt.AddObject("txt_4c__Dgrupo", "TextBox")
        WITH loc_oCnt.txt_4c__Dgrupo
            .Top           = 175
            .Left          = 243
            .Width         = 385
            .Height        = 23
            .Value         = SPACE(20)
            .Format        = "K"
            .MaxLength     = 20
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
        ENDWITH

        *-- -----------------------------------------------------------------------
        *-- LINHA 5: Conta / CPF / Dconta (y_orig=115-119)
        *-- -----------------------------------------------------------------------
        loc_oCnt.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCnt.lbl_4c_Label4
            .Top       = 234
            .Left      = 76
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Conta :"
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oCnt.txt_4c_Conta
            .Top           = 226
            .Left          = 133
            .Width         = 106
            .Height        = 23
            .Value         = SPACE(10)
            .Format        = "K"
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 9
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Cpf", "TextBox")
        WITH loc_oCnt.txt_4c_Cpf
            .Top           = 226
            .Left          = 243
            .Width         = 194
            .Height        = 23
            .Value         = ""
            .InputMask     = "XXXXXXXXXXXXXXXXXXXX"
            .MaxLength     = 20
            .Margin        = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oCnt.txt_4c_Dconta
            .Top           = 226
            .Left          = 441
            .Width         = 372
            .Height        = 23
            .Value         = SPACE(40)
            .Format        = "K"
            .MaxLength     = 40
            .SpecialEffect = 1
            .FontName      = "Courier New"
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - CommandGroup com botoes Consultar e Encerrar
    * Equivale ao "sair" commandgroup do legado
    * (Top=-2, Left=665, Width=161, Height=85 -> novo: Top=0, Left=820, Width=180)
    * Command1 (legado: "consulta") -> Buttons(1) Consultar
    * Command2 (legado: "sair")     -> Buttons(2) Encerrar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Sair", "CommandGroup")
        WITH THIS.cmg_4c_Sair
            .Top           = 0
            .Left          = 820
            .Width         = 180
            .Height        = 85
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Themes        = .F.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
                .Caption         = "Consultar"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .MousePointer    = 15
                .SpecialEffect   = 0
                .PicturePosition = 13
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 85
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .Caption         = "Encerrar"
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .MousePointer    = 15
                .SpecialEffect   = 0
                .PicturePosition = 13
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Sair.Buttons(1), "Click", THIS, "CmgConsultarClick")
        BINDEVENT(THIS.cmg_4c_Sair.Buttons(2), "Click", THIS, "CmgEncerrarClick")
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * AddObject() cria controles com Visible=.F. por padrao
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        IF VARTYPE(par_oContainer) # "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
                   loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * CmgConsultarClick - Valida filtros, executa query e abre sigpres2
    * Equivale ao PROCEDURE consulta.Click do legado (83 linhas)
    * Validacoes: empresa obrigatoria, operacao obrigatoria, periodo valido
    * Query: SigMvCab JOIN SigCdOpe com filtros dinamicos
    * Resultado: DO FORM sigpres2 WITH loc_cNmO, THIS.DataSessionId, THIS
    *==========================================================================
    PROCEDURE CmgConsultarClick()
        LOCAL loc_nNrP, loc_cNmO, loc_cEst, loc_cCon, loc_nPen
        LOCAL loc_cVen, loc_cEmp, loc_cSta, loc_nEmpD
        LOCAL loc_cNOp, loc_cNum, loc_cWhere, loc_cQuery
        LOCAL loc_dDtInicial, loc_dDtFinal, loc_cDtI, loc_cDtF
        LOCAL loc_oErro

        *-- Validar empresa (obrigatoria)
        IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c__cd_empresa.Value))
            MsgAviso("Empresa Inv" + CHR(225) + "lida!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Container1.txt_4c__cd_empresa.SetFocus
            RETURN
        ENDIF

        *-- Validar opera??o (obrigatoria)
        IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c__nm_operacao.Value))
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Container1.txt_4c__nm_operacao.SetFocus
            RETURN
        ENDIF

        *-- Validar per?odo (data final >= data inicial)
        IF THIS.cnt_4c_Container1.txt_4c__dt_final.Value < ;
           THIS.cnt_4c_Container1.txt_4c__dt_inicial.Value
            MsgAviso("Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! " + ;
                     "Data Final Menor do Que a Inicial!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Container1.txt_4c__dt_inicial.SetFocus
            RETURN
        ENDIF

        *-- Capturar valores dos filtros
        loc_nNrP  = THIS.cnt_4c_Container1.obj_4c_Opt_nr_periodo.Value
        loc_cNmO  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c__nm_operacao.Value)
        loc_cEst  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Grupo.Value)
        loc_cCon  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Conta.Value)
        loc_nPen  = THIS.cnt_4c_Container1.obj_4c_Opt_Pendente.Value
        loc_cVen  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c__resps.Value)
        loc_cEmp  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c__cd_empresa.Value)
        loc_cSta  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_PStatus.Value)
        loc_nEmpD = THIS.cnt_4c_Container1.chk_4c_ChkEmpD.Value
        loc_cNOp  = IIF(THIS.cnt_4c_Container1.txt_4c_Op.Value = 0, "", TRANSFORM(THIS.cnt_4c_Container1.txt_4c_Op.Value))
        loc_cNum  = IIF(THIS.cnt_4c_Container1.txt_4c_Numero.Value = 0, "", TRANSFORM(THIS.cnt_4c_Container1.txt_4c_Numero.Value))

        *-- Datas formatadas para SQL Server BETWEEN
        loc_dDtInicial = THIS.cnt_4c_Container1.txt_4c__dt_inicial.Value
        loc_dDtFinal   = THIS.cnt_4c_Container1.txt_4c__dt_final.Value
        loc_cDtI = "'" + STR(YEAR(loc_dDtInicial), 4) + "-" + ;
                   PADL(STR(MONTH(loc_dDtInicial), 2), 2, "0") + "-" + ;
                   PADL(STR(DAY(loc_dDtInicial), 2), 2, "0") + "'"
        loc_cDtF = "'" + STR(YEAR(loc_dDtFinal), 4) + "-" + ;
                   PADL(STR(MONTH(loc_dDtFinal), 2), 2, "0") + "-" + ;
                   PADL(STR(DAY(loc_dDtFinal), 2), 2, "0") + " 23:59:59'"

        *-- Montar WHERE dinamico (cada parte termina com " AND " para encadear)
        loc_cWhere = IIF(EMPTY(loc_cNmO), "", "a.Dopes = " + EscaparSQL(loc_cNmO) + " AND ") + ;
                     IIF(loc_nNrP = 1, "a.Datas ", "a.PrazoEnts ") + ;
                     "BETWEEN " + loc_cDtI + " AND " + loc_cDtF + " AND " + ;
                     IIF(EMPTY(loc_cEst), "", "(a.GrupoOs = " + EscaparSQL(loc_cEst) + ;
                         " OR a.GrupoDs = " + EscaparSQL(loc_cEst) + ") AND ") + ;
                     IIF(EMPTY(loc_cCon), "", "(a.ContaOs = " + EscaparSQL(loc_cCon) + ;
                         " OR a.ContaDs = " + EscaparSQL(loc_cCon) + ") AND ") + ;
                     IIF(EMPTY(loc_cNOp), "", "a.Nops = " + loc_cNOp + " AND ") + ;
                     IIF(EMPTY(loc_cNum), "", "a.Numes = " + loc_cNum + " AND ") + ;
                     IIF(EMPTY(loc_cVen), "", "a.Vends = " + EscaparSQL(loc_cVen) + " AND ") + ;
                     IIF(loc_nPen = 1, "a.ChkSubn = 0 AND ", ;
                         IIF(loc_nPen = 2, "a.ChkSubn = 1 AND ", "")) + ;
                     IIF(EMPTY(loc_cSta), "", "a.pStatus = " + EscaparSQL(loc_cSta) + " AND ")

        *-- Montar query principal (empresa obrigatoria + filtro empresa destino opcional)
        loc_cQuery = "SELECT a.* " + ;
                     "FROM SigMvCab a, SigCdOpe b " + ;
                     "WHERE (a.Emps = " + EscaparSQL(loc_cEmp) + ;
                     IIF(loc_nEmpD = 0, "", " OR a.Empds = " + EscaparSQL(loc_cEmp)) + ;
                     ") AND " + ;
                     loc_cWhere + ;
                     "a.Dopes = b.Dopes"

        TRY
            *-- Fechar cursor anterior se existir
            IF USED("cursor_4c_MovTemp")
                USE IN cursor_4c_MovTemp
            ENDIF

            *-- Executar query no SQL Server
            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_MovTemp") < 1
                MsgErro("Falha na conex" + CHR(227) + "o (cursor_4c_MovTemp)", "Erro")
                RETURN
            ENDIF

            SELECT cursor_4c_MovTemp
            INDEX ON EmpDopNums TAG EmpDopNums

            *-- Converter PrazoEnts NULL em data vazia (equivale ao UPDATE legado)
            REPLACE ALL PrazoEnts WITH {} FOR ISNULL(PrazoEnts)

            GO TOP IN cursor_4c_MovTemp

            IF RECCOUNT("cursor_4c_MovTemp") > 0
                *-- Desabilitar form enquanto sigpres2 esta aberto (modo RESULTADO)
                THIS.AlternarPagina("RESULTADO")
                DO FORM sigpres2 WITH loc_cNmO, THIS.DataSessionId, THIS
                *-- Restaurar modo FILTRO ao retornar do sigpres2
                THIS.AlternarPagina("FILTRO")
            ELSE
                MsgAviso("Nenhum Registro Selecionado!!!", ;
                         "Informa" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            THIS.AlternarPagina("FILTRO")
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em Consultar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmgEncerrarClick - Fecha o formulario
    * Equivale ao PROCEDURE sair.Click do legado (1 linha: ThisForm.Release)
    *==========================================================================
    PROCEDURE CmgEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Executa consulta e abre SIGPRES2 com resultados
    *
    * Contexto OPERACIONAL: SIGPRES1 eh um form de FILTRO/CONSULTA (nao CRUD).
    * O legado original tem UNICO botao funcional "sair" (que na verdade dispara
    * a consulta). No sistema novo, esse fluxo eh capturado em CmgConsultarClick.
    *
    * Semantica "Visualizar" = ver os movimentos filtrados = disparar a consulta
    * SigMvCab->SigCdOpe e abrir o form de resultados SIGPRES2. Por isso este
    * metodo delega para CmgConsultarClick(), que:
    *   1) Valida empresa/operacao/periodo (campos obrigatorios)
    *   2) Monta WHERE dinamico com todos os filtros do form
    *   3) SQLEXEC em cursor_4c_MovTemp + INDEX ON EmpDopNums
    *   4) Alterna form para modo RESULTADO (desabilita filtros)
    *   5) DO FORM sigpres2 (viewer dos resultados)
    *   6) Retorna para modo FILTRO ao fechar SIGPRES2
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.CmgConsultarClick()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Executa consulta (acao principal do form OPERACIONAL)
    *
    * Contexto OPERACIONAL: SIGPRES1 nao possui CRUD proprio - eh um form de
    * FILTRO/CONSULTA que exibe movimentos existentes em SigMvCab. A inclusao
    * de novos movimentos ocorre em forms de digitacao especializados (nao
    * neste form).
    *
    * Para preservar contrato do FormBase e compatibilidade com a integracao
    * de menu/validadores, delega para CmgConsultarClick() que eh a UNICA
    * acao funcional real do form (equivale ao "sair" do legado que sempre
    * dispara a consulta).
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.CmgConsultarClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Executa consulta (acao principal do form OPERACIONAL)
    *
    * Contexto OPERACIONAL: SIGPRES1 nao possui CRUD proprio. Alteracao de
    * movimentos ocorre em forms de digitacao apos abrir SIGPRES2 (viewer)
    * via double-click no registro desejado.
    *
    * Delega para CmgConsultarClick() para preservar contrato de eventos
    * principais esperado pelo FormBase.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.CmgConsultarClick()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Executa consulta (acao principal do form OPERACIONAL)
    *
    * Contexto OPERACIONAL: SIGPRES1 nao possui CRUD proprio. Exclusao de
    * movimentos ocorre em forms de manutencao especializados apos localizar
    * o registro atraves da consulta.
    *
    * Delega para CmgConsultarClick() para preservar contrato de eventos
    * principais esperado pelo FormBase.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.CmgConsultarClick()
    ENDPROC

    *==========================================================================
    * Destroy - Libera BO e fecha cursores abertos pelo form
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_MovTemp")
            USE IN cursor_4c_MovTemp
        ENDIF
        IF USED("cursor_4c_Param")
            USE IN cursor_4c_Param
        ENDIF
        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
        IF USED("cursor_4c_BuscaResp")
            USE IN cursor_4c_BuscaResp
        ENDIF
        IF USED("cursor_4c_BuscaCliente")
            USE IN cursor_4c_BuscaCliente
        ENDIF
        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        IF USED("cursor_4c_CpfTemp")
            USE IN cursor_4c_CpfTemp
        ENDIF

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados2 - Adiciona a segunda metade dos controles de filtro:
    * Responsavel (linha 6), Moeda/Cotacao (linha 7), Situacao (linha 8),
    * Impressao (linha 9).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados2()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1

        *-- Linha 6: Responsavel (Say5 / get_resps / get_dresps)
        *   Original: Say5 Left=6 Top=192, get_resps Left=80 Top=190 Width=60 H=13
        *             get_dresps Left=146 Top=190 Width=200 H=13
        *   Escalado ScaleX=1.327 ScaleY=1.968
        loc_oCnt.AddObject("lbl_4c_Lbl_responsavel", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_responsavel
            .Caption   = "Respons" + CHR(225) + "vel"
            .Top       = 378
            .Left      = 8
            .Width     = 90
            .Height    = 18
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontSize  = 9
            .BackStyle = 0
        ENDWITH

        loc_oCnt.AddObject("txt_4c__resps", "TextBox")
        WITH loc_oCnt.txt_4c__resps
            .Value    = ""
            .Top      = 374
            .Left     = 106
            .Width    = 80
            .Height   = 22
            .FontSize = 9
        ENDWITH

        loc_oCnt.AddObject("txt_4c__dresps", "TextBox")
        WITH loc_oCnt.txt_4c__dresps
            .Value    = ""
            .Top      = 374
            .Left     = 192
            .Width    = 265
            .Height   = 22
            .ReadOnly = .T.
            .FontSize = 9
            .BackColor = RGB(240,240,240)
        ENDWITH

        *-- Linha 7: Moeda / Cotacao
        *   Original: lbl_moeda Left=6 Top=207, get_cd_moeda Left=80 Top=205 Width=40 H=13
        *             get_ds_moeda Left=125 Top=205 Width=160 H=13
        *             OptCotacao Left=290 Top=205 W=130 H=16 (Option1/Option2)
        *             Say3 Left=285 Top=207 (label "Cotacao")
        loc_oCnt.AddObject("lbl_4c_Lbl_moeda", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_moeda
            .Caption   = "Moeda"
            .Top       = 404
            .Left      = 8
            .Width     = 90
            .Height    = 18
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontSize  = 9
            .BackStyle = 0
        ENDWITH

        loc_oCnt.AddObject("txt_4c_cd_moeda", "TextBox")
        WITH loc_oCnt.txt_4c_cd_moeda
            .Value    = ""
            .Top      = 400
            .Left     = 106
            .Width    = 53
            .Height   = 22
            .FontSize = 9
        ENDWITH

        loc_oCnt.AddObject("txt_4c_ds_moeda", "TextBox")
        WITH loc_oCnt.txt_4c_ds_moeda
            .Value    = ""
            .Top      = 400
            .Left     = 165
            .Width    = 212
            .Height   = 22
            .ReadOnly = .T.
            .FontSize = 9
            .BackColor = RGB(240,240,240)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Lbl_cotacao", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_cotacao
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
            .Top       = 404
            .Left      = 385
            .Width     = 70
            .Height    = 18
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontSize  = 9
            .BackStyle = 0
        ENDWITH

        loc_oCnt.AddObject("obj_4c_OptCotacao", "OptionGroup")
        WITH loc_oCnt.obj_4c_OptCotacao
            .Top        = 400
            .Left       = 458
            .Width      = 200
            .Height     = 22
            .ButtonCount = 2
            .BorderStyle = 0
            .BackStyle   = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Fechamento"
                .Left      = 0
                .Top       = 2
                .Width     = 95
                .Height    = 18
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Left      = 98
                .Top       = 2
                .Width     = 100
                .Height    = 18
                .BackStyle = 0
                .FontSize  = 9
            ENDWITH
        ENDWITH

        *-- Linha 8: Situacao (Say2 / Opt_Pendente)
        *   Original: Say2 Left=6 Top=222, Opt_Pendente Left=80 Top=220 W=170 H=16
        *             Value=3 (Todas), 3 options: Pendente/Quitado/Todas
        loc_oCnt.AddObject("lbl_4c_Lbl_situacao", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_situacao
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o"
            .Top       = 432
            .Left      = 8
            .Width     = 90
            .Height    = 18
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontSize  = 9
            .BackStyle = 0
        ENDWITH

        loc_oCnt.AddObject("obj_4c_Opt_Pendente", "OptionGroup")
        WITH loc_oCnt.obj_4c_Opt_Pendente
            .Top         = 428
            .Left        = 106
            .Width       = 225
            .Height      = 22
            .ButtonCount = 3
            .BorderStyle = 0
            .BackStyle   = 0
            .Value       = THIS.this_oBusinessObject.this_nOptPendente
            WITH .Buttons(1)
                .Caption   = "Pendente"
                .Left      = 0
                .Top       = 2
                .Width     = 72
                .Height    = 18
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Quitado"
                .Left      = 75
                .Top       = 2
                .Width     = 70
                .Height    = 18
                .BackStyle = 0
                .FontSize  = 9
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Todas"
                .Left      = 148
                .Top       = 2
                .Width     = 75
                .Height    = 18
                .BackStyle = 0
                .FontSize  = 9
            ENDWITH
        ENDWITH

        *-- Linha 9: Impressao (Say7 / opt_impressao)
        *   Original: Say7 Left=6 Top=237, opt_impressao Left=80 Top=235 W=230 H=16
        *             Value=1 (Por Vendedor), 3 options: Por Vendedor/Por Cliente/Ambos
        loc_oCnt.AddObject("lbl_4c_Lbl_impressao", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_impressao
            .Caption   = "Impress" + CHR(227) + "o"
            .Top       = 460
            .Left      = 8
            .Width     = 90
            .Height    = 18
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontSize  = 9
            .BackStyle = 0
        ENDWITH

        loc_oCnt.AddObject("obj_4c_Opt_impressao", "OptionGroup")
        WITH loc_oCnt.obj_4c_Opt_impressao
            .Top         = 456
            .Left        = 106
            .Width       = 305
            .Height      = 22
            .ButtonCount = 3
            .BorderStyle = 0
            .BackStyle   = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Por Vendedor"
                .Left      = 0
                .Top       = 2
                .Width     = 98
                .Height    = 18
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Por Cliente"
                .Left      = 101
                .Top       = 2
                .Width     = 98
                .Height    = 18
                .BackStyle = 0
                .FontSize  = 9
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Ambos"
                .Left      = 202
                .Top       = 2
                .Width     = 100
                .Height    = 18
                .BackStyle = 0
                .FontSize  = 9
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarLookups - Registra BINDEVENTs de KeyPress em todos os campos
    * que precisam de lookup ou navegacao por teclado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarLookups()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1

        BINDEVENT(loc_oCnt.txt_4c__cd_empresa,  "KeyPress", THIS, "TxtCdEmpresaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c__ds_empresa,  "KeyPress", THIS, "TxtDsEmpresaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c__nm_operacao, "KeyPress", THIS, "TxtNmOperacaoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Grupo,        "KeyPress", THIS, "TxtGrupoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c__Dgrupo,      "KeyPress", THIS, "TxtDGrupoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Conta,        "KeyPress", THIS, "TxtContaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Dconta,       "KeyPress", THIS, "TxtDContaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Cpf,          "KeyPress", THIS, "TxtCpfKeyPress")
        BINDEVENT(loc_oCnt.txt_4c__resps,       "KeyPress", THIS, "TxtRespsKeyPress")
        BINDEVENT(loc_oCnt.txt_4c__dresps,      "KeyPress", THIS, "TxtDRespsKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_cd_moeda,     "KeyPress", THIS, "TxtCdMoedaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_ds_moeda,     "KeyPress", THIS, "TxtDsMoedaKeyPress")
    ENDPROC

    *==========================================================================
    * KeyPress handlers - publicos (BINDEVENT requer metodos publicos)
    *==========================================================================

    PROCEDURE TxtCdEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            LOCAL loc_oCnt, loc_oBO, loc_cCod
            loc_oCnt = THIS.cnt_4c_Container1
            loc_oBO  = THIS.this_oBusinessObject
            loc_cCod = ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value)
            IF EMPTY(loc_cCod)
                THIS.AbrirLookupEmpresa()
            ELSE
                IF loc_oBO.BuscarEmpresaPorCodigo(loc_cCod)
                    loc_oCnt.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.razas)
                    USE IN cursor_4c_BuscaEmp
                ELSE
                    loc_oCnt.txt_4c__cd_empresa.Value = ""
                    loc_oCnt.txt_4c__ds_empresa.Value = ""
                    THIS.AbrirLookupEmpresa()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDsEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TxtNmOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            LOCAL loc_oCnt, loc_oBO, loc_cNome
            loc_oCnt  = THIS.cnt_4c_Container1
            loc_oBO   = THIS.this_oBusinessObject
            loc_cNome = ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value)
            IF EMPTY(loc_cNome)
                THIS.AbrirLookupOperacao()
            ELSE
                IF !loc_oBO.BuscarOperacaoPorNome(loc_cNome)
                    loc_oCnt.txt_4c__nm_operacao.Value = ""
                    THIS.AbrirLookupOperacao()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            *-- Grupo so ativo quando Numero = 0 (When: Return Empty(Get_Numero.Value))
            LOCAL loc_oCnt
            loc_oCnt = THIS.cnt_4c_Container1
            IF loc_oCnt.txt_4c_Numero.Value <> 0
                RETURN
            ENDIF
            LOCAL loc_oBO, loc_cCod
            loc_oBO  = THIS.this_oBusinessObject
            loc_cCod = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
            IF EMPTY(loc_cCod)
                THIS.AbrirLookupGrupo()
            ELSE
                IF loc_oBO.BuscarGrupoPorCodigo(loc_cCod)
                    loc_oCnt.txt_4c__Dgrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
                    USE IN cursor_4c_BuscaGrupo
                ELSE
                    loc_oCnt.txt_4c_Grupo.Value   = ""
                    loc_oCnt.txt_4c__Dgrupo.Value = ""
                    THIS.AbrirLookupGrupo()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            *-- DGrupo so ativo quando Grupo esta vazio (When: Return Empty(Get_Grupo.Value))
            LOCAL loc_oCnt
            loc_oCnt = THIS.cnt_4c_Container1
            IF loc_oCnt.txt_4c_Numero.Value <> 0
                RETURN
            ENDIF
            IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
                RETURN
            ENDIF
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            *-- Conta so ativa quando Numero = 0 (When: Return Empty(Get_Numero.Value))
            LOCAL loc_oCnt
            loc_oCnt = THIS.cnt_4c_Container1
            IF loc_oCnt.txt_4c_Numero.Value <> 0
                RETURN
            ENDIF
            LOCAL loc_oBO, loc_cCod, loc_cGrupo
            loc_oBO   = THIS.this_oBusinessObject
            loc_cCod   = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
            loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
            IF EMPTY(loc_cCod)
                THIS.AbrirLookupConta()
            ELSE
                IF loc_oBO.BuscarContaPorCodigo(loc_cGrupo, loc_cCod)
                    loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
                    USE IN cursor_4c_BuscaConta
                    THIS.PreencherCpfPorConta()
                ELSE
                    loc_oCnt.txt_4c_Conta.Value  = ""
                    loc_oCnt.txt_4c_Dconta.Value = ""
                    loc_oCnt.txt_4c_Cpf.Value    = ""
                    THIS.AbrirLookupConta()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            *-- DConta so ativa quando Conta esta vazia e Numero=0
            LOCAL loc_oCnt
            loc_oCnt = THIS.cnt_4c_Container1
            IF loc_oCnt.txt_4c_Numero.Value <> 0
                RETURN
            ENDIF
            IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
                RETURN
            ENDIF
            THIS.AbrirLookupConta()
        ENDIF
    ENDPROC

    PROCEDURE TxtCpfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            *-- CPF so ativo quando Conta E Numero estao vazios
            *   (When: Return Empty(Get_Conta.Value) And Empty(Get_Numero.Value))
            LOCAL loc_oCnt
            loc_oCnt = THIS.cnt_4c_Container1
            IF loc_oCnt.txt_4c_Numero.Value <> 0
                RETURN
            ENDIF
            IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))
                RETURN
            ENDIF
            LOCAL loc_oBO, loc_cCpf
            loc_oBO  = THIS.this_oBusinessObject
            loc_cCpf = ALLTRIM(loc_oCnt.txt_4c_Cpf.Value)
            IF EMPTY(loc_cCpf)
                RETURN
            ENDIF
            loc_cCpf = STRTRAN(STRTRAN(STRTRAN(loc_cCpf, ".", ""), "-", ""), "/", "")
            IF LEN(loc_cCpf) = 11
                loc_cCpf = LEFT(loc_cCpf, 3) + "." + SUBSTR(loc_cCpf, 4, 3) + "." + ;
                           SUBSTR(loc_cCpf, 7, 3) + "-" + RIGHT(loc_cCpf, 2)
            ENDIF
            IF loc_oBO.BuscarClientePorCpf(loc_cCpf)
                loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCliente.iclis)
                loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCliente.rclis)
                loc_oCnt.txt_4c_Cpf.Value    = loc_cCpf
                USE IN cursor_4c_BuscaCliente
            ELSE
                loc_oCnt.txt_4c_Cpf.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtRespsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            *-- Resps so ativo quando Numero = 0 (When: Return Empty(Get_Numero.Value))
            LOCAL loc_oCnt
            loc_oCnt = THIS.cnt_4c_Container1
            IF loc_oCnt.txt_4c_Numero.Value <> 0
                RETURN
            ENDIF
            LOCAL loc_oBO, loc_cCod
            loc_oBO  = THIS.this_oBusinessObject
            loc_cCod = ALLTRIM(loc_oCnt.txt_4c__resps.Value)
            IF EMPTY(loc_cCod)
                THIS.AbrirLookupResps()
            ELSE
                IF loc_oBO.BuscarResponsavelPorCodigo(loc_cCod)
                    loc_oCnt.txt_4c__dresps.Value = ALLTRIM(cursor_4c_BuscaResp.rclis)
                    USE IN cursor_4c_BuscaResp
                ELSE
                    loc_oCnt.txt_4c__resps.Value  = ""
                    loc_oCnt.txt_4c__dresps.Value = ""
                    THIS.AbrirLookupResps()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDRespsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            *-- DResps so ativo quando resps esta vazio e Numero=0
            LOCAL loc_oCnt
            loc_oCnt = THIS.cnt_4c_Container1
            IF loc_oCnt.txt_4c_Numero.Value <> 0
                RETURN
            ENDIF
            IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c__resps.Value))
                RETURN
            ENDIF
            THIS.AbrirLookupResps()
        ENDIF
    ENDPROC

    PROCEDURE TxtCdMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            LOCAL loc_oCnt, loc_oBO, loc_cCod
            loc_oCnt = THIS.cnt_4c_Container1
            loc_oBO  = THIS.this_oBusinessObject
            loc_cCod = ALLTRIM(loc_oCnt.txt_4c_cd_moeda.Value)
            IF EMPTY(loc_cCod)
                THIS.AbrirLookupMoeda()
            ELSE
                IF loc_oBO.BuscarMoedaPorCodigo(loc_cCod)
                    loc_oCnt.txt_4c_ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                    USE IN cursor_4c_BuscaMoeda
                ELSE
                    loc_oCnt.txt_4c_cd_moeda.Value = ""
                    loc_oCnt.txt_4c_ds_moeda.Value = ""
                    THIS.AbrirLookupMoeda()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDsMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            *-- DsMoeda so ativa quando CdMoeda esta vazio
            LOCAL loc_oCnt
            loc_oCnt = THIS.cnt_4c_Container1
            IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_cd_moeda.Value))
                RETURN
            ENDIF
            THIS.AbrirLookupMoeda()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookup - Metodos de abertura do picker FormBuscaAuxiliar
    *==========================================================================

    PROTECTED PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oFrm, loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1
        loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "sigcdemp", ;
                       "cursor_4c_BuscaEmp", "cemps", ;
                       ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value), ;
                       "Empresa")
        IF VARTYPE(loc_oFrm) = "O"
            loc_oFrm.mAddColuna("cemps", "C" + CHR(243) + "digo", 80)
            loc_oFrm.mAddColuna("razas", "Raz" + CHR(227) + "o Social", 280)
            loc_oFrm.Show()
            IF THIS.this_lSelecionou
                loc_oCnt.txt_4c__cd_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.cemps)
                loc_oCnt.txt_4c__ds_empresa.Value = ALLTRIM(cursor_4c_BuscaEmp.razas)
                USE IN cursor_4c_BuscaEmp
            ENDIF
            loc_oFrm.Release()
            loc_oFrm = .NULL.
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupOperacao()
        LOCAL loc_oFrm, loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1
        loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOpe", ;
                       "cursor_4c_BuscaOpe", "Dopes", ;
                       ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value), ;
                       "Opera" + CHR(231) + CHR(227) + "o")
        IF VARTYPE(loc_oFrm) = "O"
            loc_oFrm.mAddColuna("Dopes", "Opera" + CHR(231) + CHR(227) + "o", 300)
            loc_oFrm.Show()
            IF THIS.this_lSelecionou
                loc_oCnt.txt_4c__nm_operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                USE IN cursor_4c_BuscaOpe
            ENDIF
            loc_oFrm.Release()
            loc_oFrm = .NULL.
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oFrm, loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1
        loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
                       "cursor_4c_BuscaGrupo", "codigos", ;
                       ALLTRIM(loc_oCnt.txt_4c_Grupo.Value), ;
                       "Grupo")
        IF VARTYPE(loc_oFrm) = "O"
            loc_oFrm.mAddColuna("codigos", "C" + CHR(243) + "digo", 80)
            loc_oFrm.mAddColuna("descrs",  "Descri" + CHR(231) + CHR(227) + "o", 280)
            loc_oFrm.Show()
            IF THIS.this_lSelecionou
                loc_oCnt.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
                loc_oCnt.txt_4c__Dgrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
                USE IN cursor_4c_BuscaGrupo
            ENDIF
            loc_oFrm.Release()
            loc_oFrm = .NULL.
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupConta()
        LOCAL loc_oFrm, loc_oCnt, loc_cGrupo
        loc_oCnt   = THIS.cnt_4c_Container1
        loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
        loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                       IIF(EMPTY(loc_cGrupo), "SigCdCli", ;
                           "SigCdCli WHERE grupos = " + EscaparSQL(loc_cGrupo)), ;
                       "cursor_4c_BuscaConta", "iclis", ;
                       ALLTRIM(loc_oCnt.txt_4c_Conta.Value), ;
                       "Conta")
        IF VARTYPE(loc_oFrm) = "O"
            loc_oFrm.mAddColuna("iclis", "C" + CHR(243) + "digo", 80)
            loc_oFrm.mAddColuna("rclis", "Nome", 280)
            loc_oFrm.Show()
            IF THIS.this_lSelecionou
                loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.iclis)
                loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
                USE IN cursor_4c_BuscaConta
                THIS.PreencherCpfPorConta()
            ENDIF
            loc_oFrm.Release()
            loc_oFrm = .NULL.
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupResps()
        LOCAL loc_oFrm, loc_oCnt, loc_cGrpVens
        loc_oCnt    = THIS.cnt_4c_Container1
        loc_cGrpVens = THIS.this_oBusinessObject.this_cGrPadVens
        loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                       IIF(EMPTY(loc_cGrpVens), "SigCdCli", ;
                           "SigCdCli WHERE grupos = " + EscaparSQL(loc_cGrpVens)), ;
                       "cursor_4c_BuscaResp", "iclis", ;
                       ALLTRIM(loc_oCnt.txt_4c__resps.Value), ;
                       "Respons" + CHR(225) + "vel")
        IF VARTYPE(loc_oFrm) = "O"
            loc_oFrm.mAddColuna("iclis", "C" + CHR(243) + "digo", 80)
            loc_oFrm.mAddColuna("rclis", "Nome", 280)
            loc_oFrm.Show()
            IF THIS.this_lSelecionou
                loc_oCnt.txt_4c__resps.Value  = ALLTRIM(cursor_4c_BuscaResp.iclis)
                loc_oCnt.txt_4c__dresps.Value = ALLTRIM(cursor_4c_BuscaResp.rclis)
                USE IN cursor_4c_BuscaResp
            ENDIF
            loc_oFrm.Release()
            loc_oFrm = .NULL.
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oFrm, loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1
        loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
                       "cursor_4c_BuscaMoeda", "cmoes", ;
                       ALLTRIM(loc_oCnt.txt_4c_cd_moeda.Value), ;
                       "Moeda")
        IF VARTYPE(loc_oFrm) = "O"
            loc_oFrm.mAddColuna("cmoes", "C" + CHR(243) + "digo", 80)
            loc_oFrm.mAddColuna("dmoes", "Descri" + CHR(231) + CHR(227) + "o", 200)
            loc_oFrm.Show()
            IF THIS.this_lSelecionou
                loc_oCnt.txt_4c_cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                loc_oCnt.txt_4c_ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                USE IN cursor_4c_BuscaMoeda
            ENDIF
            loc_oFrm.Release()
            loc_oFrm = .NULL.
        ENDIF
    ENDPROC

    *==========================================================================
    * PreencherCpfPorConta - Consulta SigCdCli para popular campo CPF
    * apos selecionar uma conta.
    *==========================================================================
    PROTECTED PROCEDURE PreencherCpfPorConta()
        LOCAL loc_oCnt, loc_cConta, loc_cSQL, loc_nRes, loc_cCpf
        loc_oCnt   = THIS.cnt_4c_Container1
        loc_cConta = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
        IF EMPTY(loc_cConta)
            RETURN
        ENDIF
        loc_cSQL = "SELECT cpfs FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cConta)
        TRY
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpfTemp")
            IF loc_nRes > 0 AND !EMPTY(cursor_4c_CpfTemp.cpfs)
                loc_cCpf = ALLTRIM(cursor_4c_CpfTemp.cpfs)
                loc_oCnt.txt_4c_Cpf.Value = loc_cCpf
            ELSE
                loc_oCnt.txt_4c_Cpf.Value = ""
            ENDIF
            IF USED("cursor_4c_CpfTemp")
                USE IN cursor_4c_CpfTemp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar CPF")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Executa consulta (acao de busca do form OPERACIONAL)
    * Delega para CmgConsultarClick() - acao principal do form
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CmgConsultarClick()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * Delega para CmgEncerrarClick()
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmgEncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Executa consulta (sem CRUD em form OPERACIONAL)
    * SIGPRES1 eh form de consulta apenas. Acao "Salvar" = disparar consulta.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.CmgConsultarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Limpa todos os campos de filtro (sem CRUD)
    * Em form OPERACIONAL, cancelar = limpar filtros
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    * FormParaBO - Copia valores dos controles do form para o Business Object
    * Todos os campos de filtro do cnt_4c_Container1 -> propriedades do BO
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oCnt, loc_oBO
        loc_oCnt = THIS.cnt_4c_Container1
        loc_oBO  = THIS.this_oBusinessObject

        IF VARTYPE(loc_oCnt) # "O" OR VARTYPE(loc_oBO) # "O"
            RETURN
        ENDIF

        loc_oBO.this_cCdEmpresa    = ALLTRIM(loc_oCnt.txt_4c__cd_empresa.Value)
        loc_oBO.this_cDsEmpresa    = ALLTRIM(loc_oCnt.txt_4c__ds_empresa.Value)
        loc_oBO.this_dDtInicial    = loc_oCnt.txt_4c__dt_inicial.Value
        loc_oBO.this_dDtFinal      = loc_oCnt.txt_4c__dt_final.Value
        loc_oBO.this_nNrPeriodo    = loc_oCnt.obj_4c_Opt_nr_periodo.Value
        loc_oBO.this_cNmOperacao   = ALLTRIM(loc_oCnt.txt_4c__nm_operacao.Value)
        loc_oBO.this_nNumero       = loc_oCnt.txt_4c_Numero.Value
        loc_oBO.this_nOp           = loc_oCnt.txt_4c_Op.Value
        loc_oBO.this_cPStatus      = ALLTRIM(loc_oCnt.txt_4c_PStatus.Value)
        loc_oBO.this_cGrupo        = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
        loc_oBO.this_cDGrupo       = ALLTRIM(loc_oCnt.txt_4c__Dgrupo.Value)
        loc_oBO.this_cConta        = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
        loc_oBO.this_cDConta       = ALLTRIM(loc_oCnt.txt_4c_Dconta.Value)
        loc_oBO.this_cCpf          = ALLTRIM(loc_oCnt.txt_4c_Cpf.Value)
        loc_oBO.this_cResps        = ALLTRIM(loc_oCnt.txt_4c__resps.Value)
        loc_oBO.this_cDResps       = ALLTRIM(loc_oCnt.txt_4c__dresps.Value)
        loc_oBO.this_cCdMoeda      = ALLTRIM(loc_oCnt.txt_4c_cd_moeda.Value)
        loc_oBO.this_cDsMoeda      = ALLTRIM(loc_oCnt.txt_4c_ds_moeda.Value)
        loc_oBO.this_nChkEmpD      = loc_oCnt.chk_4c_ChkEmpD.Value
        loc_oBO.this_nOptCotacao   = loc_oCnt.obj_4c_OptCotacao.Value
        loc_oBO.this_nOptPendente  = loc_oCnt.obj_4c_Opt_Pendente.Value
        loc_oBO.this_nOptImpressao = loc_oCnt.obj_4c_Opt_impressao.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Copia propriedades do BO de volta para os controles do form
    * Inverso de FormParaBO()
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oCnt, loc_oBO
        loc_oCnt = THIS.cnt_4c_Container1
        loc_oBO  = THIS.this_oBusinessObject

        IF VARTYPE(loc_oCnt) # "O" OR VARTYPE(loc_oBO) # "O"
            RETURN
        ENDIF

        loc_oCnt.txt_4c__cd_empresa.Value      = loc_oBO.this_cCdEmpresa
        loc_oCnt.txt_4c__ds_empresa.Value      = loc_oBO.this_cDsEmpresa
        loc_oCnt.txt_4c__dt_inicial.Value      = loc_oBO.this_dDtInicial
        loc_oCnt.txt_4c__dt_final.Value        = loc_oBO.this_dDtFinal
        loc_oCnt.obj_4c_Opt_nr_periodo.Value   = loc_oBO.this_nNrPeriodo
        loc_oCnt.txt_4c__nm_operacao.Value     = loc_oBO.this_cNmOperacao
        loc_oCnt.txt_4c_Numero.Value           = loc_oBO.this_nNumero
        loc_oCnt.txt_4c_Op.Value               = loc_oBO.this_nOp
        loc_oCnt.txt_4c_PStatus.Value          = loc_oBO.this_cPStatus
        loc_oCnt.txt_4c_Grupo.Value            = loc_oBO.this_cGrupo
        loc_oCnt.txt_4c__Dgrupo.Value          = loc_oBO.this_cDGrupo
        loc_oCnt.txt_4c_Conta.Value            = loc_oBO.this_cConta
        loc_oCnt.txt_4c_Dconta.Value           = loc_oBO.this_cDConta
        loc_oCnt.txt_4c_Cpf.Value              = loc_oBO.this_cCpf
        loc_oCnt.txt_4c__resps.Value           = loc_oBO.this_cResps
        loc_oCnt.txt_4c__dresps.Value          = loc_oBO.this_cDResps
        loc_oCnt.txt_4c_cd_moeda.Value         = loc_oBO.this_cCdMoeda
        loc_oCnt.txt_4c_ds_moeda.Value         = loc_oBO.this_cDsMoeda
        loc_oCnt.chk_4c_ChkEmpD.Value         = loc_oBO.this_nChkEmpD
        loc_oCnt.obj_4c_OptCotacao.Value       = loc_oBO.this_nOptCotacao
        loc_oCnt.obj_4c_Opt_Pendente.Value     = loc_oBO.this_nOptPendente
        loc_oCnt.obj_4c_Opt_impressao.Value    = loc_oBO.this_nOptImpressao
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Controla habilitacao dos controles
    * Form OPERACIONAL: todos os campos de filtro habilitados quando par_lHabilitar=.T.
    * (bloqueados durante modo RESULTADO enquanto SIGPRES2 esta aberto)
    * par_lHabilitar: .T. = habilitar (default), .F. = desabilitar
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oCnt, loc_lHab
        loc_lHab = IIF(PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        loc_oCnt = THIS.cnt_4c_Container1

        IF VARTYPE(loc_oCnt) # "O"
            RETURN
        ENDIF

        loc_oCnt.txt_4c__cd_empresa.Enabled     = loc_lHab
        loc_oCnt.txt_4c__ds_empresa.Enabled     = loc_lHab
        loc_oCnt.txt_4c__dt_inicial.Enabled     = loc_lHab
        loc_oCnt.txt_4c__dt_final.Enabled       = loc_lHab
        loc_oCnt.txt_4c__nm_operacao.Enabled    = loc_lHab
        loc_oCnt.txt_4c_Numero.Enabled          = loc_lHab
        loc_oCnt.txt_4c_Op.Enabled              = loc_lHab
        loc_oCnt.txt_4c_PStatus.Enabled         = loc_lHab
        loc_oCnt.txt_4c_Grupo.Enabled           = loc_lHab
        loc_oCnt.txt_4c__Dgrupo.Enabled         = loc_lHab
        loc_oCnt.txt_4c_Conta.Enabled           = loc_lHab
        loc_oCnt.txt_4c_Dconta.Enabled          = loc_lHab
        loc_oCnt.txt_4c_Cpf.Enabled             = loc_lHab
        loc_oCnt.txt_4c__resps.Enabled          = loc_lHab
        loc_oCnt.txt_4c__dresps.Enabled         = loc_lHab
        loc_oCnt.txt_4c_cd_moeda.Enabled        = loc_lHab
        loc_oCnt.chk_4c_ChkEmpD.Enabled        = loc_lHab
        loc_oCnt.obj_4c_Opt_nr_periodo.Enabled  = loc_lHab
        loc_oCnt.obj_4c_OptCotacao.Enabled      = loc_lHab
        loc_oCnt.obj_4c_Opt_Pendente.Enabled    = loc_lHab
        loc_oCnt.obj_4c_Opt_impressao.Enabled   = loc_lHab

        IF PEMSTATUS(THIS, "cmg_4c_Sair", 5)
            THIS.cmg_4c_Sair.Buttons(1).Enabled = loc_lHab
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Restaura todos os campos de filtro aos valores default
    * Equivale ao trecho de inicializacao do Init() do legado (zeros e espacos)
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1

        IF VARTYPE(loc_oCnt) # "O"
            RETURN
        ENDIF

        loc_oCnt.txt_4c__cd_empresa.Value      = go_4c_Sistema.cCodEmpresa
        loc_oCnt.txt_4c__ds_empresa.Value      = ""
        loc_oCnt.txt_4c__nm_operacao.Value     = ""
        loc_oCnt.txt_4c__dt_inicial.Value      = DATE()
        loc_oCnt.txt_4c__dt_final.Value        = DATE()
        loc_oCnt.txt_4c_Numero.Value           = 0
        loc_oCnt.txt_4c_Op.Value               = 0
        loc_oCnt.txt_4c_PStatus.Value          = ""
        loc_oCnt.txt_4c_Grupo.Value            = SPACE(10)
        loc_oCnt.txt_4c__Dgrupo.Value          = SPACE(20)
        loc_oCnt.txt_4c_Conta.Value            = SPACE(10)
        loc_oCnt.txt_4c_Dconta.Value           = SPACE(40)
        loc_oCnt.txt_4c_Cpf.Value              = ""
        loc_oCnt.txt_4c__resps.Value           = ""
        loc_oCnt.txt_4c__dresps.Value          = ""
        loc_oCnt.txt_4c_cd_moeda.Value         = ""
        loc_oCnt.txt_4c_ds_moeda.Value         = ""
        loc_oCnt.chk_4c_ChkEmpD.Value         = 0
        loc_oCnt.obj_4c_Opt_nr_periodo.Value   = 1
        loc_oCnt.obj_4c_OptCotacao.Value       = 1
        loc_oCnt.obj_4c_Opt_Pendente.Value     = 3
        loc_oCnt.obj_4c_Opt_impressao.Value    = 1

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cCdEmpresa   = go_4c_Sistema.cCodEmpresa
            THIS.this_oBusinessObject.this_dDtInicial   = DATE()
            THIS.this_oBusinessObject.this_dDtFinal     = DATE()
            THIS.this_oBusinessObject.this_nOptPendente = 3
        ENDIF

        loc_oCnt.txt_4c__nm_operacao.SetFocus
    ENDPROC

    *==========================================================================
    * CarregarLista - Satisfaz contrato do FormBase sem execucao de SQL
    * SIGPRES1 eh form de filtro/criterios (sem grade de registros propria).
    * Os resultados sao exibidos em SIGPRES2 aberto por CmgConsultarClick.
    * Retorna .T. para indicar sucesso ao FormBase.
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo operacional
    * "FILTRO"    -> tudo habilitado (forma padrao de uso)
    * "RESULTADO" -> campos e botao Consultar desabilitados (SIGPRES2 aberto)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lFiltro
        loc_lFiltro = (THIS.this_cModoAtual == "FILTRO")

        THIS.HabilitarCampos(loc_lFiltro)
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrEs1BO.prg):
*==============================================================================
* SigPrEs1BO.prg - Business Object: Posicao Por Movimentacao
* Herda de: BusinessBase
* Tipo: OPERACIONAL (filtro/consulta - sem CRUD direto)
* Tabela principal: SigMvCab
*==============================================================================

DEFINE CLASS SigPrEs1BO AS BusinessBase

    *--------------------------------------------------------------------------
    * Filtros de periodo
    *--------------------------------------------------------------------------
    this_dDtInicial    = {}
    this_dDtFinal      = {}
    this_nNrPeriodo    = 1        && 1=Lancamento, 2=Prazo Entrega

    *--------------------------------------------------------------------------
    * Filtro Movimentacao / Operacao
    *--------------------------------------------------------------------------
    this_cNmOperacao   = ""       && C(20) - Nome da movimentacao (SigCdOpe.Dopes)

    *--------------------------------------------------------------------------
    * Filtros Numero / OP
    *--------------------------------------------------------------------------
    this_nNumero       = 0        && N(6,0) - Numero do lancamento (SigMvCab.numes)
    this_nOp           = 0        && N(6,0) - Numero da OP (SigMvCab.nops)

    *--------------------------------------------------------------------------
    * Filtro Status
    *--------------------------------------------------------------------------
    this_cPStatus      = ""       && C(1) - Status (SigMvCab.pstatus)

    *--------------------------------------------------------------------------
    * Filtro Grupo Contabil (SigCdGcr - origem/destino)
    *--------------------------------------------------------------------------
    this_cGrupo        = ""       && C(10) - Codigo do grupo (grupoos/grupods)
    this_cDGrupo       = ""       && C(40) - Descricao do grupo (descrs)

    *--------------------------------------------------------------------------
    * Filtro Conta / CPF/CNPJ (SigCdCli)
    *--------------------------------------------------------------------------
    this_cConta        = ""       && C(10) - Codigo da conta (contaos/contads)
    this_cDConta       = ""       && C(50) - Descricao da conta (rclis)
    this_cCpf          = ""       && C(20) - CPF/CNPJ (SigCdCli.cpfs)

    *--------------------------------------------------------------------------
    * Filtro Moeda (SigCdMoe - exibido em sigpres2, nao filtra SQL principal)
    *--------------------------------------------------------------------------
    this_cCdMoeda      = ""       && C(3)  - Codigo da moeda (cmoes)
    this_cDsMoeda      = ""       && C(15) - Descricao da moeda (dmoes)

    *--------------------------------------------------------------------------
    * Filtro Responsavel / Vendedor (SigCdCli com grupo = GrPadVens)
    *--------------------------------------------------------------------------
    this_cResps        = ""       && C(10) - Codigo do responsavel (vends)
    this_cDResps       = ""       && C(50) - Descricao do responsavel (rclis)

    *--------------------------------------------------------------------------
    * Filtro Empresa (sigcdemp)
    *--------------------------------------------------------------------------
    this_cCdEmpresa    = ""       && C(3)  - Codigo da empresa (emps)
    this_cDsEmpresa    = ""       && C(40) - Descricao da empresa (razas)
    this_nChkEmpD      = 0        && N(1)  - 0=nao filtrar Empds, 1=incluir Empds

    *--------------------------------------------------------------------------
    * OptionGroups - passados a sigpres2 para controle de exibicao/impressao
    *--------------------------------------------------------------------------
    this_nOptCotacao   = 1        && 1=Fechamento, 2=Movimentacao
    this_nOptImpressao = 1        && 1=Por Vendedor, 2=Por Movimentacao
    this_nOptPendente  = 3        && 1=Pendentes, 2=Baixadas, 3=Todas

    *--------------------------------------------------------------------------
    * Parametro operacional carregado de SigCdPam
    *--------------------------------------------------------------------------
    this_cGrPadVens    = ""       && C(10) - Grupo padrao de vendedores (grpadvens)

    *==========================================================================
    * Init - Inicializa o BO configurando tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna identificador para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nNumero)
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega GrPadVens e demais config de SigCdPam
    * Deve ser chamado no Init() do Form apos criar o BO
    * Retorna .T. se carregou com sucesso
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 grpadvens FROM SigCdPam"

            IF USED("cursor_4c_Param")
                USE IN cursor_4c_Param
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param") > 0
                IF !EOF("cursor_4c_Param")
                    SELECT cursor_4c_Param
                    THIS.this_cGrPadVens = NVL(grpadvens, "")
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_Param")
                USE IN cursor_4c_Param
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar par" + CHR(226) + "metros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarFiltros - Valida campos obrigatorios antes da consulta
    * Retorna: "" se valido, mensagem de erro se invalido
    *==========================================================================
    PROCEDURE ValidarFiltros()
        LOCAL loc_cMensagem
        loc_cMensagem = ""

        IF EMPTY(THIS.this_cCdEmpresa)
            RETURN "Empresa Inv" + CHR(225) + "lida!!!"
        ENDIF

        IF EMPTY(THIS.this_cNmOperacao)
            RETURN "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!"
        ENDIF

        IF !EMPTY(THIS.this_dDtFinal) AND !EMPTY(THIS.this_dDtInicial)
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                RETURN "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! " + ;
                       "Data Final Menor do Que a Inicial!!!"
            ENDIF
        ENDIF

        RETURN loc_cMensagem
    ENDPROC

    *==========================================================================
    * ExecutarConsulta - Monta e executa consulta principal em SigMvCab
    * Popula cursor_4c_MovTemp com resultados indexados por EmpDopNums
    * Requer: this_cCdEmpresa, this_dDtInicial, this_dDtFinal validados
    * Retorna: .T. se consulta gerou ao menos 1 registro
    *==========================================================================
    PROCEDURE ExecutarConsulta()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_cDtI, loc_cDtF, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cDtI = "'" + DTOC(THIS.this_dDtInicial, 1) + "'"
            loc_cDtF = "'" + DTOC(THIS.this_dDtFinal, 1) + " 23:59:59'"

            loc_cWhere = IIF(EMPTY(THIS.this_cNmOperacao), "", ;
                             "a.dopes = " + EscaparSQL(THIS.this_cNmOperacao) + " And ") + ;
                         IIF(THIS.this_nNrPeriodo = 1, "a.datas ", "a.prazoents ") + ;
                             "Between " + loc_cDtI + " And " + loc_cDtF + " And " + ;
                         IIF(EMPTY(THIS.this_cGrupo), "", ;
                             "(a.grupoos = " + EscaparSQL(THIS.this_cGrupo) + ;
                             " Or a.grupods = " + EscaparSQL(THIS.this_cGrupo) + ") And ") + ;
                         IIF(EMPTY(THIS.this_cConta), "", ;
                             "(a.contaos = " + EscaparSQL(THIS.this_cConta) + ;
                             " Or a.contads = " + EscaparSQL(THIS.this_cConta) + ") And ") + ;
                         IIF(THIS.this_nOp = 0, "", ;
                             "a.nops = " + TRANSFORM(THIS.this_nOp) + " And ") + ;
                         IIF(THIS.this_nNumero = 0, "", ;
                             "a.numes = " + TRANSFORM(THIS.this_nNumero) + " And ") + ;
                         IIF(EMPTY(THIS.this_cResps), "", ;
                             "a.vends = " + EscaparSQL(THIS.this_cResps) + " And ") + ;
                         IIF(THIS.this_nOptPendente = 1, "a.chksubn = 0 And ", ;
                             IIF(THIS.this_nOptPendente = 2, "a.chksubn = 1 And ", "")) + ;
                         IIF(EMPTY(THIS.this_cPStatus), "", ;
                             "a.pstatus = " + EscaparSQL(THIS.this_cPStatus) + " And ")

            loc_cSQL = "SELECT a.* " + ;
                       "FROM SigMvCab a, SigCdOpe b " + ;
                       "WHERE (a.emps = " + EscaparSQL(THIS.this_cCdEmpresa) + ;
                           IIF(THIS.this_nChkEmpD = 0, "", ;
                               " Or a.empds = " + EscaparSQL(THIS.this_cCdEmpresa)) + ;
                           ") And " + ;
                       loc_cWhere + ;
                       "a.dopes = b.Dopes"

            IF USED("cursor_4c_MovTemp")
                USE IN cursor_4c_MovTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MovTemp") > 0
                SELECT cursor_4c_MovTemp
                IF !EOF("cursor_4c_MovTemp")
                    INDEX ON empdopnums TAG empdopnums
                    UPDATE cursor_4c_MovTemp ;
                        SET prazoents = IIF(ISNULL(prazoents), {}, prazoents)
                    GO TOP IN cursor_4c_MovTemp
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao executar consulta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarGrupoPorCodigo - Lookup SigCdGcr por codigo (equivale fAcessoContab C)
    * Popula cursor_4c_BuscaGrupo com codigos, descrs
    * Retorna .T. se encontrou exatamente 1 registro
    *==========================================================================
    PROCEDURE BuscarGrupoPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
                       "WHERE RTRIM(codigos) = RTRIM(" + EscaparSQL(par_cCodigo) + ")"

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaGrupo")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarGrupoPorDescricao - Lookup SigCdGcr por descricao (fAcessoContab D)
    * Popula cursor_4c_BuscaGrupo com codigos, descrs
    * Retorna .T. se encontrou exatamente 1 match (auto-preenche sem picker)
    *==========================================================================
    PROCEDURE BuscarGrupoPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
                       "WHERE RTRIM(descrs) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       " ORDER BY descrs"

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo") > 0
                SELECT cursor_4c_BuscaGrupo
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaGrupo")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarMoedaPorCodigo - Lookup SigCdMoe por cmoes
    * Popula cursor_4c_BuscaMoeda com cmoes, dmoes
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarMoedaPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                       "WHERE RTRIM(cmoes) = RTRIM(" + EscaparSQL(par_cCodigo) + ")"

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaMoeda")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarMoedaPorDescricao - Lookup SigCdMoe por dmoes
    * Popula cursor_4c_BuscaMoeda com cmoes, dmoes
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarMoedaPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                       "WHERE RTRIM(dmoes) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       " ORDER BY dmoes"

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda") > 0
                SELECT cursor_4c_BuscaMoeda
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaMoeda")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarContaPorCodigo - Lookup SigCdCli por iclis com filtro de grupo
    * Equivale a fAcessoContas(usu, grupo, 'C', ...)
    * Popula cursor_4c_BuscaConta com iclis, rclis
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarContaPorCodigo(par_cGrupo, par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(par_cGrupo), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(par_cGrupo) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(iclis) = RTRIM(" + EscaparSQL(par_cCodigo) + ")" + ;
                       loc_cFiltroGrupo

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaConta")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar conta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarContaPorDescricao - Lookup SigCdCli por rclis com filtro de grupo
    * Equivale a fAcessoContas(usu, grupo, 'D', ...)
    * Popula cursor_4c_BuscaConta com iclis, rclis
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarContaPorDescricao(par_cGrupo, par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(par_cGrupo), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(par_cGrupo) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(rclis) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       loc_cFiltroGrupo + ;
                       " ORDER BY rclis"

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta") > 0
                SELECT cursor_4c_BuscaConta
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaConta")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar conta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarResponsavelPorCodigo - Lookup vendedor/resp por iclis
    * Usa this_cGrPadVens como filtro de grupo (SigCdCli.grupos)
    * Equivale a fAcessoContas(usu, GrPadVens, 'C', ...)
    * Popula cursor_4c_BuscaResp com iclis, rclis
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarResponsavelPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(THIS.this_cGrPadVens), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(THIS.this_cGrPadVens) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(iclis) = RTRIM(" + EscaparSQL(par_cCodigo) + ")" + ;
                       loc_cFiltroGrupo

            IF USED("cursor_4c_BuscaResp")
                USE IN cursor_4c_BuscaResp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaResp") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaResp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar respons" + CHR(225) + "vel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarResponsavelPorDescricao - Lookup vendedor/resp por rclis
    * Usa this_cGrPadVens como filtro de grupo
    * Equivale a fAcessoContas(usu, GrPadVens, 'D', ...)
    * Popula cursor_4c_BuscaResp com iclis, rclis
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarResponsavelPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(THIS.this_cGrPadVens), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(THIS.this_cGrPadVens) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(rclis) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       loc_cFiltroGrupo + ;
                       " ORDER BY rclis"

            IF USED("cursor_4c_BuscaResp")
                USE IN cursor_4c_BuscaResp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaResp") > 0
                SELECT cursor_4c_BuscaResp
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaResp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar respons" + CHR(225) + "vel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarClientePorCpf - Lookup SigCdCli por cpfs (CPF/CNPJ)
    * Popula cursor_4c_BuscaCliente com iclis, rclis, cpfs
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarClientePorCpf(par_cCpf)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT iclis, rclis, cpfs FROM SIGCDCLI " + ;
                       "WHERE RTRIM(cpfs) = " + EscaparSQL(PADR(ALLTRIM(par_cCpf), 20))

            IF USED("cursor_4c_BuscaCliente")
                USE IN cursor_4c_BuscaCliente
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCliente") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaCliente")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar cliente por CPF")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarOperacaoPorNome - Valida existencia da operacao em SigCdOpe
    * Equivale a fAcessoMovmto - verifica que Dopes existe
    * Popula cursor_4c_BuscaOpe com Dopes
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarOperacaoPorNome(par_cNome)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes FROM SigCdOpe " + ;
                       "WHERE RTRIM(Dopes) = RTRIM(" + EscaparSQL(par_cNome) + ")"

            IF USED("cursor_4c_BuscaOpe")
                USE IN cursor_4c_BuscaOpe
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaOpe")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar opera" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarEmpresaPorCodigo - Lookup sigcdemp por cemps
    * Equivale a fAcessoEmpresa modo C
    * Popula cursor_4c_BuscaEmp com cemps, razas
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarEmpresaPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cemps, razas FROM sigcdemp " + ;
                       "WHERE RTRIM(cemps) = RTRIM(" + EscaparSQL(par_cCodigo) + ")"

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaEmp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar empresa")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia registro atual de cursor SigMvCab para propriedades
    * Usado quando form carrega movimentacao selecionada (double-click no grid de sigpres2)
    * par_cAliasCursor: nome do cursor com dados de SigMvCab (a.* da ExecutarConsulta)
    * Retorna .T. se mapeou com sucesso
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED(par_cAliasCursor)
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)

            IF EOF() OR BOF()
                loc_lSucesso = .F.
            ENDIF

            IF TYPE(par_cAliasCursor + ".emps") != "U"
                THIS.this_cCdEmpresa = NVL(emps, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".dopes") != "U"
                THIS.this_cNmOperacao = NVL(dopes, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".datas") != "U"
                THIS.this_dDtInicial = IIF(ISNULL(datas), {}, datas)
                THIS.this_dDtFinal   = IIF(ISNULL(datas), {}, datas)
            ENDIF
            IF TYPE(par_cAliasCursor + ".numes") != "U"
                THIS.this_nNumero = NVL(numes, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".nops") != "U"
                THIS.this_nOp = NVL(nops, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".pstatus") != "U"
                THIS.this_cPStatus = NVL(pstatus, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".grupoos") != "U"
                THIS.this_cGrupo = NVL(grupoos, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".contaos") != "U"
                THIS.this_cConta = NVL(contaos, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".vends") != "U"
                THIS.this_cResps = NVL(vends, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".chksubn") != "U"
                IF VARTYPE(chksubn) = "N"
                    THIS.this_nOptPendente = IIF(NVL(chksubn, 0) = 1, 2, 1)
                ELSE
                    THIS.this_nOptPendente = IIF(NVL(chksubn, .F.), 2, 1)
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar do cursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Nao suportado
    * SigPrEs1 eh form OPERACIONAL de consulta/relatorio (Posicao Por Movimentacao).
    * Os registros de SigMvCab sao criados/mantidos pelos forms de movimentacao
    * (sigcdmov e derivados). Este BO apenas consulta - retorna .F. explicitamente
    * para impedir uso indevido em vez de gravar dados inconsistentes.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        MsgAviso("Este relat" + CHR(243) + "rio de posi" + CHR(231) + CHR(227) + "o eh somente leitura. " + ;
                "Use os formul" + CHR(225) + "rios de movimenta" + CHR(231) + CHR(227) + "o para incluir registros.", ;
                "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Atualizar - Nao suportado
    * Ver comentario em Inserir(). Consultas/relatorios nao atualizam SigMvCab.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        MsgAviso("Este relat" + CHR(243) + "rio de posi" + CHR(231) + CHR(227) + "o eh somente leitura. " + ;
                "Use os formul" + CHR(225) + "rios de movimenta" + CHR(231) + CHR(227) + "o para alterar registros.", ;
                "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
        RETURN .F.
    ENDPROC

    *==========================================================================
    * BuscarEmpresaPorDescricao - Lookup sigcdemp por razas
    * Equivale a fAcessoEmpresa modo D
    * Popula cursor_4c_BuscaEmp com cemps, razas
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarEmpresaPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cemps, razas FROM sigcdemp " + ;
                       "WHERE RTRIM(razas) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       " ORDER BY razas"

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp") > 0
                SELECT cursor_4c_BuscaEmp
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaEmp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar empresa")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

