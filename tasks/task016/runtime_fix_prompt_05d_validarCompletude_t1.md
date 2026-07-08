# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formccr.prg] Indicador de pendencia: *== OS Pendente
[Formccr.prg] Indicador de pendencia: *-- Visibilidade de Digito e TpEmps dependente
[Formccr.prg] Indicador de pendencia: *-- Resetar estados Enabled: todos dependente
[Formccr.prg] Indicador de pendencia: * FiscalCdGruposLostFocus - Valida CdGrupos; limpa dependente
[Formccr.prg] Indicador de pendencia: *-- Limpar todos os campos dependente
[Formccr.prg] Indicador de pendencia: * AtualizarEstadoFiscal - Atualiza Enabled dos campos dependente

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formccr.prg):
*==============================================================================
* Formccr.prg - Formulario de Cadastro de Grupos de Contas Corrente
* Data: 2026-04-14
* Tabela: SigCdGcr | PK: Codigos
* Legado: SIGCDCCR.SCX (frmcadastro)
* FASE 9 - Completo (Fases 3-9 concluidas)
*   Page1 (Lista): Header, botoes CRUD, grid 5 colunas
*   Page2 (Dados): Identificacao + inner PageFrame 4 abas
*   4 abas: Geral / Cadastro / Estoque+Industria / Faturamento+Fiscal
*   Lookups: Classes(SigCdCss), Situas(SigCdCst), Moeda(SigCdMoe),
*            GrupoGeral/GrupoEst/GrupoFalha/ContaFalha/ContaPdr/Contint(SigCdGcr)
*            Fiscal CdGrupos/CdContas (9 containers: ICMS/IPI/II/ISS/IRRF/INSS/PIS/CSSL/COFINS)
*   FASE 7: BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick completos
*           HabilitarCampos completo, visibilidade TpCods/TpEmps/Digito
*   FASE 8: Menu e config integration
*   FASE 9: LostFocus/GotFocus handlers fiscais, AtualizarEstadoFiscal (When logic),
*           estados Enabled corretos para CdContas/DsContas/PctAliqs/Receitas
*==============================================================================

DEFINE CLASS Formccr AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = ""
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    ClipControls = .F.
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *-- Guardias LostFocus (evitar revalidacao duplicada)
    this_cUltClasses     = ""    && Ultimo classes validado (SigCdCss)
    this_cUltGrupoGeral  = ""    && Ultimo Get_grupo(Geral) validado
    this_cUltGrupoEst    = ""    && Ultimo Get_grupo(Est) validado
    this_cUltContint     = ""    && Ultimo contint validado
    this_cUltSituas      = ""    && Ultimo situas validado
    this_cUltContaFalha  = ""    && Ultimo GetContaFalha validado
    this_cUltGrupoFalha  = ""    && Ultimo GetGrupoFalha validado
    this_cUltContaPdr    = ""    && Ultimo getContaPdr validado
    this_cUltCdMoeda     = ""    && Ultimo get_cd_moeda validado
    this_oFiscalCntAtivo = .NULL.  && Container fiscal ativo (rastreado via GotFocus)

    *--------------------------------------------------------------------------
    * Init - Inicializacao do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial (chamado por FormBase.Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("ccrBO")

            IF ISNULL(THIS.this_oBusinessObject)
                MostrarErro("Erro ao criar Business Object ccrBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = ;
                    "Grupos de Contas Corrente"

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formccr:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame externo (Page1=Lista, Page2=Dados)
    * Top=-29 oculta abas, Width=1003 cobre toda a forma
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 629
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, saida, grid
    * Compensacao +29 aplicada (Top_original + 29)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho (Top=31, Width=1020, Height=80)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1020
            .Height      = 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Grupos de Contas Corrente"
            .Top       = 20
            .Left      = 20
            .Width     = 400
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Left=542, Top=29, Width=400, Height=85)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 400
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Incluir (Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Visualizar (Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 155
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 230
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Buscar (Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 305
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container saida (Left=917, Top=29, Width=90, Height=85)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container filtros (Left=5, Top=29, vazio - busca via BtnBuscarClick)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 29
            .Left        = 5
            .Width       = 530
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Grid de lista (Top=121, Left=11, Width=938, Height=470)
        *-- 5 colunas: Codigos/Descrs/Internos/TpCods/DClasses
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top               = 121
            .Left              = 11
            .Width             = 938
            .Height            = 470
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 3
            .GridLines         = 3
            .ColumnCount       = 5
            .AllowHeaderSizing = .T.
            .Visible           = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: identificacao + inner PageFrame 4 abas
    * Compensacao +29 aplicada nos Tops
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Botoes Salvar/Cancelar (Top=38, Left=819, Width=165, Height=85)
        loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
        WITH loc_oPagina.cnt_4c_BotoesDados
            .Top         = 38
            .Left        = 819
            .Width       = 165
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 7
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
            .Caption         = "Cancelar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 83
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        *-- ROW 1: Codigos | Descrs | Internos (Top=38)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_LblCodigos", "Label")
        WITH loc_oPagina.lbl_4c_LblCodigos
            .Caption   = "C" + CHR(243) + "digo :"
            .Left      = 5
            .Top       = 43
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Value         = ""
            .Left          = 57
            .Top           = 38
            .Width         = 65
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 10
            .InputMask     = "XXXXXXXXXX"
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblDescrs", "Label")
        WITH loc_oPagina.lbl_4c_LblDescrs
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Left      = 130
            .Top       = 43
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPagina.txt_4c_Descrs
            .Value         = ""
            .Left          = 198
            .Top           = 38
            .Width         = 250
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 40
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblInterno", "Label")
        WITH loc_oPagina.lbl_4c_LblInterno
            .Caption   = "Interno :"
            .Left      = 456
            .Top       = 43
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Interno", "TextBox")
        WITH loc_oPagina.txt_4c_Interno
            .Value         = ""
            .Left          = 514
            .Top           = 38
            .Width         = 100
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 2: TpCods | Digito | Classes | DClasses | ChkLimCrds | ChkLimEsts (Top=68)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_LblTpCods", "Label")
        WITH loc_oPagina.lbl_4c_LblTpCods
            .Caption   = "Tipo :"
            .Left      = 5
            .Top       = 73
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- opt_4c_TpCods: 1=Empresa, 2=C/C
        loc_oPagina.AddObject("opt_4c_TpCods", "OptionGroup")
        WITH loc_oPagina.opt_4c_TpCods
            .ButtonCount  = 2
            .Left         = 48
            .Top          = 68
            .Width        = 130
            .Height       = 24
            .BorderStyle  = 0
            .Value        = 1
            .Visible      = .T.
            .Buttons(1).Caption = "Empresa"
            .Buttons(1).Width   = 65
            .Buttons(2).Caption = "C/C"
            .Buttons(2).Width   = 55
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_TpCods, "InteractiveChange", THIS, "opt_4c_TpCods_InteractiveChange")

        *-- Digito (visivel somente quando TpCods=1)
        loc_oPagina.AddObject("lbl_4c_LblDigito", "Label")
        WITH loc_oPagina.lbl_4c_LblDigito
            .Caption   = "D" + CHR(237) + "gito :"
            .Left      = 183
            .Top       = 73
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Digito", "TextBox")
        WITH loc_oPagina.txt_4c_Digito
            .Value         = ""
            .Left          = 236
            .Top           = 68
            .Width         = 25
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        *-- Classes (lookup SigCdCss via F4/LostFocus)
        loc_oPagina.AddObject("lbl_4c_LblClasses", "Label")
        WITH loc_oPagina.lbl_4c_LblClasses
            .Caption   = "Classe :"
            .Left      = 267
            .Top       = 73
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Classes", "TextBox")
        WITH loc_oPagina.txt_4c_Classes
            .Value         = ""
            .Left          = 318
            .Top           = 68
            .Width         = 70
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Classes, "KeyPress", THIS, "txt_4c_Classes_KeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Classes, "LostFocus", THIS, "txt_4c_Classes_LostFocus")

        *-- DClasses (display-only, derivado do lookup)
        loc_oPagina.AddObject("txt_4c_DClasses", "TextBox")
        WITH loc_oPagina.txt_4c_DClasses
            .Value         = ""
            .Left          = 394
            .Top           = 68
            .Width         = 185
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- chk_4c_LimCrds - Verif. Limite Credito (chklimcrds N(1,0))
        loc_oPagina.AddObject("chk_4c_LimCrds", "CheckBox")
        WITH loc_oPagina.chk_4c_LimCrds
            .Caption   = "Verif. Limite Cr" + CHR(233) + "d."
            .Left      = 585
            .Top       = 68
            .Width     = 105
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- chk_4c_LimEsts - Verif. Limite Estoque (chklimests N(1,0))
        loc_oPagina.AddObject("chk_4c_LimEsts", "CheckBox")
        WITH loc_oPagina.chk_4c_LimEsts
            .Caption   = "Verif. Limite Est."
            .Left      = 695
            .Top       = 68
            .Width     = 115
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 2B: TpEmps (visivel somente TpCods=1) e TpCads (sempre visivel)
        *-- TpEmps: Left=353, Top=68 | TpCads: Left=5, Top=93
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_TpEmps", "Label")
        WITH loc_oPagina.lbl_4c_TpEmps
            .Caption   = "Incl. Empresa :"
            .Left      = 353
            .Top       = 73
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.  && controlado por TpCods
        ENDWITH

        loc_oPagina.AddObject("opt_4c_TpEmps", "OptionGroup")
        WITH loc_oPagina.opt_4c_TpEmps
            .ButtonCount  = 2
            .Left         = 447
            .Top          = 68
            .Width        = 98
            .Height       = 23
            .BorderStyle  = 0
            .Value        = 1
            .Visible      = .T.  && controlado por TpCods
            .Buttons(1).Caption = "Sim"
            .Buttons(1).Width   = 49
            .Buttons(2).Caption = "N" + CHR(227) + "o"
            .Buttons(2).Width   = 49
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_TpCads", "Label")
        WITH loc_oPagina.lbl_4c_TpCads
            .Caption   = "Tp.Cad. :"
            .Left      = 5
            .Top       = 98
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_TpCads", "OptionGroup")
        WITH loc_oPagina.opt_4c_TpCads
            .ButtonCount  = 2
            .Left         = 63
            .Top          = 93
            .Width        = 150
            .Height       = 23
            .BorderStyle  = 0
            .Value        = 1
            .Visible      = .T.
            .Buttons(1).Caption = "Empresa"
            .Buttons(1).Width   = 75
            .Buttons(2).Caption = "C/C"
            .Buttons(2).Width   = 75
        ENDWITH

        *----------------------------------------------------------------------
        *-- Inner PageFrame - 4 abas (Geral, Cadastro, Estoque, Faturamento)
        *-- (Top=120, Left=5, Width=985, Height=447)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("pgf_4c_AbaDados", "PageFrame")
        WITH loc_oPagina.pgf_4c_AbaDados
            .Top       = 120
            .Left      = 5
            .Width     = 985
            .Height    = 447
            .PageCount = 4
            .Tabs      = .T.
            .Visible   = .T.

            .Page1.Caption = "Geral"
            .Page2.Caption = "Cadastro"
            .Page3.Caption = "Estoque"
            .Page4.Caption = "Faturamento"
        ENDWITH

        THIS.ConfigurarAbaGeral()
        THIS.ConfigurarAbaCadastro()
        THIS.ConfigurarAbaEstoque()
        THIS.ConfigurarAbaFaturamento()

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarLabel - Helper: adiciona Label padrao ao container
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarLabel(par_oParent, par_cNome, par_cCaption, par_nLeft, par_nTop, par_nWidth)
        par_oParent.AddObject(par_cNome, "Label")
        WITH par_oParent.Controls(par_oParent.ControlCount)
            .Caption   = par_cCaption
            .Left      = par_nLeft
            .Top       = par_nTop
            .Width     = par_nWidth
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarOptSimNao - Helper: adiciona OptionGroup 2-botoes Sim/Nao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarOptSimNao(par_oParent, par_cNome, par_nLeft, par_nTop, par_nWidth, par_nDefault)
        LOCAL loc_nBtnW
        loc_nBtnW = INT(par_nWidth / 2)
        par_oParent.AddObject(par_cNome, "OptionGroup")
        WITH par_oParent.Controls(par_oParent.ControlCount)
            .ButtonCount  = 2
            .Left         = par_nLeft
            .Top          = par_nTop
            .Width        = par_nWidth
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .BorderStyle  = 0
            .BackStyle    = 0
            .Value        = par_nDefault
            .Buttons(1).Caption = "Sim"
            .Buttons(1).Width   = loc_nBtnW
            .Buttons(2).Caption = "N" + CHR(227) + "o"
            .Buttons(2).Width   = par_nWidth - loc_nBtnW
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarContainerFiscal - Helper: container com 5 campos fiscais
    * Estrutura: lbl_4c_TaxNome, txt_4c_CdGrupos, txt_4c_CdContas,
    *            txt_4c_DsContas(disabled), txt_4c_PctAliqs, txt_4c_Receitas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarContainerFiscal(par_oAba, par_cNome, par_cLabel, par_nTop)
        LOCAL loc_oCnt
        par_oAba.AddObject(par_cNome, "Container")
        loc_oCnt = par_oAba.Controls(par_oAba.ControlCount)
        WITH loc_oCnt
            .Top         = par_nTop
            .Left        = 18
            .Width       = 673
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_TaxNome", "Label")
        WITH loc_oCnt.lbl_4c_TaxNome
            .Caption   = par_cLabel
            .Left      = 10
            .Top       = 5
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CdGrupos", "TextBox")
        WITH loc_oCnt.txt_4c_CdGrupos
            .Value         = ""
            .Left          = 66
            .Top           = 2
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CdContas", "TextBox")
        WITH loc_oCnt.txt_4c_CdContas
            .Value         = ""
            .Left          = 155
            .Top           = 2
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
            .Enabled       = .F.  && When: CdGrupos nao vazio
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DsContas", "TextBox")
        WITH loc_oCnt.txt_4c_DsContas
            .Value         = ""
            .Left          = 237
            .Top           = 2
            .Width         = 290
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.  && When: CdGrupos nao vazio E CdContas vazio
        ENDWITH

        loc_oCnt.AddObject("txt_4c_PctAliqs", "TextBox")
        WITH loc_oCnt.txt_4c_PctAliqs
            .Value         = 0
            .Left          = 536
            .Top           = 2
            .Width         = 42
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.  && When: CdGrupos e CdContas nao vazios
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Receitas", "TextBox")
        WITH loc_oCnt.txt_4c_Receitas
            .Value         = ""
            .Left          = 588
            .Top           = 2
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
            .Enabled       = .F.  && When: CdGrupos, CdContas e PctAliqs nao vazios
        ENDWITH

        *-- Lookups F4 para CdGrupos e CdContas + LostFocus para validacao
        BINDEVENT(loc_oCnt.txt_4c_CdGrupos, "GotFocus",  THIS, "FiscalGotFocus")
        BINDEVENT(loc_oCnt.txt_4c_CdGrupos, "KeyPress",  THIS, "FiscalCdGruposKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_CdGrupos, "LostFocus", THIS, "FiscalCdGruposLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_CdContas, "GotFocus",  THIS, "FiscalGotFocus")
        BINDEVENT(loc_oCnt.txt_4c_CdContas, "KeyPress",  THIS, "FiscalCdContasKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_CdContas, "LostFocus", THIS, "FiscalCdContasLostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAbaGeral - Controles da Aba 1 (Geral)
    * Col.Esq: Comple/Pessoais/RefBancs/FollowUp/Fiscais/DadosCom/Respos/LimCre/Comi
    * Col.Dir: Empresa/Contabs/Caracts/Perfil/Cargos/ChkLimCr/PreCad + Coletor
    * Inferior: GrupoGeral, VrLimCre, CdMoeda, DsMoeda, RodRelCC
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAbaGeral()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1

        *== Coluna Esquerda (labels left~27-103, opts left=128) ==================
        THIS.CriarLabel(loc_oAba, "lbl_4c_GComple",   "Complemento :",                   56, 22,  74)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptComple",   128, 18, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GPessoais", "Dados Pessoais :",                 47, 48,  83)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPessoais",  128, 44, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GRefBancs", "Ref. Banc" + CHR(225) + "rias :", 51, 74,  79)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptRefBancs",  128, 70, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GFollowUp", "Follow-Up :",                     74, 101, 56)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptFollowUp",  128, 97, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GFiscais",  "Dados Fiscais :",                 57, 127, 73)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptFiscais",   128, 123, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GDadosCom", "Dados Comerciais :",              37, 153, 93)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptDadosCom",  128, 149, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GRespos", ;
            "Possui Respons" + CHR(225) + "vel :",             27, 178, 103)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptRespos",    128, 174, 97, 2)

        *-- Limite de Credito (3 botoes)
        THIS.CriarLabel(loc_oAba, "lbl_4c_GLimCre", ;
            "Limite de Cr" + CHR(233) + "dito :",              41, 202, 89)
        loc_oAba.AddObject("opt_4c_OptLimCre", "OptionGroup")
        WITH loc_oAba.opt_4c_OptLimCre
            .ButtonCount  = 3
            .Left         = 126
            .Top          = 197
            .Width        = 225
            .Height       = 25
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption = "Sim"
            .Buttons(1).Width   = 70
            .Buttons(2).Caption = "N" + CHR(227) + "o"
            .Buttons(2).Width   = 70
            .Buttons(3).Caption = "Sim-Saldo"
            .Buttons(3).Width   = 85
        ENDWITH

        THIS.CriarLabel(loc_oAba, "lbl_4c_GComi", ;
            "Comiss" + CHR(227) + "o :",                       76, 229, 54)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptComi",      128, 225, 97, 2)

        *== Coluna Direita (labels left~411-501, opts left=533) ==================
        THIS.CriarLabel(loc_oAba, "lbl_4c_GEmpresa",  "Dados da Empresa :",             436, 22,  98)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptEmpresa",   533, 18, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GContabs", ;
            "Dados Cont" + CHR(225) + "beis :",               444, 48,  90)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptContabs",   533, 44, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GCaract", ;
            "Caracter" + CHR(237) + "sticas :",               454, 74,  80)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptCaract",    533, 70, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GPerfil",   "Perfil :",                       501, 127, 33)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPerfil",    533, 123, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GCargos",   "Cargos :",                       491, 153, 43)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptCargos",    533, 149, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GChkLimCr", ;
            "Checa Limite Cr" + CHR(233) + "dito :",          427, 178, 107)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptChkLimCrG", 533, 174, 97, 2)

        *== Extrema Direita: Grupo Padrao (Coletor, 11 botoes) ==================
        THIS.CriarLabel(loc_oAba, "lbl_4c_GColetor", ;
            "Grupo Padr" + CHR(227) + "o :",                  706, 22,  75)
        loc_oAba.AddObject("opt_4c_OptColetor", "OptionGroup")
        WITH loc_oAba.opt_4c_OptColetor
            .ButtonCount  = 11
            .Left         = 780
            .Top          = 15
            .Width        = 141
            .Height       = 210
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption  = " 1"
            .Buttons(2).Caption  = " 2"
            .Buttons(3).Caption  = " 3"
            .Buttons(4).Caption  = " 4"
            .Buttons(5).Caption  = " 5"
            .Buttons(6).Caption  = " 6"
            .Buttons(7).Caption  = " 7"
            .Buttons(8).Caption  = " 8"
            .Buttons(9).Caption  = " 9"
            .Buttons(10).Caption = "10"
            .Buttons(11).Caption = "11"
        ENDWITH

        *-- Pre Cadastro
        THIS.CriarLabel(loc_oAba, "lbl_4c_GPreCad", ;
            "Pr" + CHR(233) + " Cadastro :",                  709, 229, 72)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPreCad",    780, 225, 97, 2)

        *== Secao inferior: Limite Credito Grupo/Vr/Moeda ========================
        THIS.CriarLabel(loc_oAba, "lbl_4c_GLimCrGVM", ;
            "Lim.Cr" + CHR(233) + "dito Grupo/Vr/Moeda :",   389, 204, 145)

        loc_oAba.AddObject("txt_4c_GrupoGeral", "TextBox")
        WITH loc_oAba.txt_4c_GrupoGeral
            .Value         = ""
            .Left          = 536
            .Top           = 199
            .Width         = 97
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_GrupoGeral, "KeyPress",  THIS, "txt_4c_GrupoGeral_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_GrupoGeral, "LostFocus", THIS, "txt_4c_GrupoGeral_LostFocus")

        loc_oAba.AddObject("txt_4c_VrLimCre", "TextBox")
        WITH loc_oAba.txt_4c_VrLimCre
            .Value         = 0
            .Left          = 636
            .Top           = 199
            .Width         = 110
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH

        THIS.CriarLabel(loc_oAba, "lbl_4c_GMoeda", ;
            "Moeda da Comiss" + CHR(227) + "o :",             430, 229, 107)

        loc_oAba.AddObject("txt_4c_CdMoeda", "TextBox")
        WITH loc_oAba.txt_4c_CdMoeda
            .Value         = ""
            .Left          = 536
            .Top           = 225
            .Width         = 32
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 10
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_CdMoeda, "KeyPress",  THIS, "txt_4c_CdMoeda_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_CdMoeda, "LostFocus", THIS, "txt_4c_CdMoeda_LostFocus")

        loc_oAba.AddObject("txt_4c_DsMoeda", "TextBox")
        WITH loc_oAba.txt_4c_DsMoeda
            .Value         = ""
            .Left          = 570
            .Top           = 225
            .Width         = 130
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.
        ENDWITH

        *== Rodape Relatorio Conta Corrente =====================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_GRodape", ;
            "Rod" + CHR(225) + "p" + CHR(233) + " do Relat" + CHR(243) + ;
            "rio de Conta Corrente",                          165, 263, 220)

        loc_oAba.AddObject("edt_4c_RodRelCC", "EditBox")
        WITH loc_oAba.edt_4c_RodRelCC
            .Value         = ""
            .Left          = 165
            .Top           = 280
            .Width         = 788
            .Height        = 117
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ScrollBars    = 2
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAbaCadastro - Controles da Aba 2 (Cadastro/Financeiro)
    * Col.Esq: CPFObrig/RG/CEP/CalcIMeds/ObrMails/ObrNome/ObrSit/ObrTlm/
    *          ObrCla/ObrSeg/ObrIbge/FpublSobr/NascObrig
    * Col.Dir: RestEnd/CntVinc/DupEnd/MFotos/Observacao/CpfFixo/Situacao/
    *          CaracCad/AceJob/CCustoTit/LogAlt/InfSenha
    * Financeiro: Contint/IntegCont/PadPreench/VincContas/TitBaixado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAbaCadastro()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2

        THIS.CriarLabel(loc_oAba, "lbl_4c_CadHeader", ;
            "Cadastro de Contas",                              29, 14, 120)

        *-- CPF/CNPJ Obrigatorio (4 botoes)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CCpfObrig", ;
            "CPF / CNPJ Obrigat" + CHR(243) + "rio :",        73, 32, 120)
        loc_oAba.AddObject("opt_4c_CpfObrig", "OptionGroup")
        WITH loc_oAba.opt_4c_CpfObrig
            .ButtonCount  = 4
            .Left         = 192
            .Top          = 29
            .Width        = 284
            .Height       = 23
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption = "N" + CHR(227) + "o"
            .Buttons(1).Width   = 64
            .Buttons(2).Caption = "Sim"
            .Buttons(2).Width   = 64
            .Buttons(3).Caption = "Sim-Dupla"
            .Buttons(3).Width   = 80
            .Buttons(4).Caption = "N" + CHR(227) + "o-Dupla"
            .Buttons(4).Width   = 76
        ENDWITH

        *-- RG/IE Obrigatorio
        THIS.CriarLabel(loc_oAba, "lbl_4c_CRgObrig", ;
            "RG / IE Obrigat" + CHR(243) + "rio :",           93, 53, 100)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_RgObrig",       192, 50, 115, 2)

        *-- CEP Obrigatorio (3 botoes)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CCepObrig", ;
            "CEP Obrigat" + CHR(243) + "rio :",               108, 76, 85)
        loc_oAba.AddObject("opt_4c_CepObrig", "OptionGroup")
        WITH loc_oAba.opt_4c_CepObrig
            .ButtonCount  = 3
            .Left         = 191
            .Top          = 70
            .Width        = 201
            .Height       = 25
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption = "N" + CHR(227) + "o"
            .Buttons(1).Width   = 60
            .Buttons(2).Caption = "Sim"
            .Buttons(2).Width   = 60
            .Buttons(3).Caption = "Sim-Buscar"
            .Buttons(3).Width   = 81
        ENDWITH

        *-- Calc.IMedias
        THIS.CriarLabel(loc_oAba, "lbl_4c_CCalcIMeds", ;
            "Calc. I.M" + CHR(233) + "dias :",                108, 95, 85)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_CalcIMeds",     191, 92, 97, 2)

        *-- eMail Obrigatorio
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObrMails", ;
            "e-Mail Obrigat" + CHR(243) + "rio :",             99, 120, 94)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrMails",      191, 115, 97, 2)

        *-- Nome Obrigatorio
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObrNome", ;
            "Nome Obrigat" + CHR(243) + "rio :",              100, 141, 93)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrNome",       191, 137, 97, 2)

        *-- Situacao Obrigatoria
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObrSit", ;
            "Situa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria :", 86, 164, 107)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrSit",        191, 159, 97, 2)

        *-- Telemarketing Obrigatorio
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObrTlm", ;
            "Telemarketing Obrigat" + CHR(243) + "rio :",      60, 186, 133)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrTlm",        190, 181, 97, 2)

        *-- Classificacao Obrigatoria
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObrCla", ;
            "Classifica" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria :", 66, 208, 127)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrCla",        190, 203, 97, 2)

        *-- Segmento Obrigatorio
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObrSeg", ;
            "Segmento Obrigat" + CHR(243) + "rio :",           79, 229, 114)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrSeg",        190, 224, 97, 2)

        *-- Cod IBGE Obrigatorio
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObrIbge", ;
            "Cod Ibge Obrigat" + CHR(243) + "rio :",           83, 249, 110)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrIbge",       190, 244, 97, 2)

        *-- F.Publicidade Obrigatoria
        THIS.CriarLabel(loc_oAba, "lbl_4c_CFpublSobr", ;
            "F. Publicidade Obrigat" + CHR(243) + "ria :",     46, 269, 147)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_FpublSobr",     189, 264, 97, 2)

        *-- Data Nascimento Obrigatoria
        THIS.CriarLabel(loc_oAba, "lbl_4c_CNascObrig", ;
            "Data Nascimento Obrigat" + CHR(243) + "ria :",    46, 291, 147)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_NascObrig",     189, 286, 97, 2)

        *== Coluna Direita (opts left=686-690) ===================================

        *-- Verifica Restricao Endereco (Fwoption9, top=24)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CRestEnd", ;
            "Verifica Restri" + CHR(231) + CHR(227) + "o de Endere" + CHR(231) + "o :", 533, 27, 155)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_RestEnd",       686, 24, 97, 2)

        *-- Conta Vinculada ao Grupo (Fwoption4, top=49)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CCntVinc", ;
            "Conta Vinculada ao Grupo :",                      555, 52, 133)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_CntVinc",       688, 47, 115, 2)

        *-- Verifica Duplicidade Endereco (Fwoption5, top=70)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CDupEnd", ;
            "Verifica Duplicidade de Endere" + CHR(231) + "o :", 524, 73, 164)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_DupEnd",        688, 70, 115, 2)

        *-- Mostrar Foto
        THIS.CriarLabel(loc_oAba, "lbl_4c_CMFotos",   "Mostrar Foto :",             617, 93, 71)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_MFotos",        688, 90, 115, 2)

        *-- Observacao (3 botoes, height=63)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObservacao", ;
            "Observa" + CHR(231) + CHR(227) + "o :",          621, 115, 67)
        loc_oAba.AddObject("opt_4c_Observacao", "OptionGroup")
        WITH loc_oAba.opt_4c_Observacao
            .ButtonCount  = 3
            .Left         = 689
            .Top          = 115
            .Width        = 115
            .Height       = 63
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption = "N" + CHR(227) + "o Mostrar"
            .Buttons(1).Width   = 112
            .Buttons(2).Caption = "Sempre"
            .Buttons(2).Width   = 112
            .Buttons(3).Caption = "Mostrar Bot" + CHR(227) + "o"
            .Buttons(3).Width   = 112
        ENDWITH

        *-- CPF/CNPJ Fixo (3 botoes)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CCpfFixo", ;
            "CPF / CNPJ Fixo :",                              602, 167, 86)
        loc_oAba.AddObject("opt_4c_CpfFixo", "OptionGroup")
        WITH loc_oAba.opt_4c_CpfFixo
            .ButtonCount  = 3
            .Left         = 690
            .Top          = 164
            .Width        = 167
            .Height       = 23
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption = "CPF"
            .Buttons(1).Width   = 50
            .Buttons(2).Caption = "CNPJ"
            .Buttons(2).Width   = 50
            .Buttons(3).Caption = "Ambos"
            .Buttons(3).Width   = 67
        ENDWITH

        *-- Situacao Padrao (textbox + lookup)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CSituacao", ;
            "Situa" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o :", 601, 189, 90)
        loc_oAba.AddObject("txt_4c_Situas", "TextBox")
        WITH loc_oAba.txt_4c_Situas
            .Value         = ""
            .Left          = 693
            .Top           = 185
            .Width         = 32
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 10
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_Situas, "KeyPress",  THIS, "txt_4c_Situas_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_Situas, "LostFocus", THIS, "txt_4c_Situas_LostFocus")

        *-- Caracteristica Cadastro
        THIS.CriarLabel(loc_oAba, "lbl_4c_CCaracCad", ;
            "Caracter" + CHR(237) + "stica :",                613, 212, 75)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_CaracCad",      688, 208, 115, 2)

        *-- Acesso Job
        THIS.CriarLabel(loc_oAba, "lbl_4c_CAceJob",   "Acesso Job :",               625, 233, 63)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_AceJob",        688, 229, 115, 2)

        *-- Habilita Centro de Custos Titulos
        THIS.CriarLabel(loc_oAba, "lbl_4c_CCCustoTit", ;
            "Habilita Centro de Custos nos T" + CHR(237) + "tulos :", 503, 254, 185)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_CCustoTit",     687, 249, 97, 2)

        *-- Log de Alteracoes
        THIS.CriarLabel(loc_oAba, "lbl_4c_CLogAlt", ;
            "Log de Altera" + CHR(231) + CHR(245) + "es :",  593, 276, 95)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_LogAlt",        688, 272, 115, 2)

        *-- Informar Senha na Alteracao
        THIS.CriarLabel(loc_oAba, "lbl_4c_CInfSenha", ;
            "Informar senha na Altera" + CHR(231) + CHR(227) + "o :", 541, 296, 147)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_InfSenha",      688, 292, 115, 2)

        *== Separador Financeiro ================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_CFinHeader", "Financeiro", 29, 315, 60)

        *-- Conta Corrente Interna
        THIS.CriarLabel(loc_oAba, "lbl_4c_CContint",  "Conta :",                    152, 324, 40)
        loc_oAba.AddObject("txt_4c_Contint", "TextBox")
        WITH loc_oAba.txt_4c_Contint
            .Value         = ""
            .Left          = 192
            .Top           = 321
            .Width         = 73
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_Contint, "KeyPress",  THIS, "txt_4c_Contint_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_Contint, "LostFocus", THIS, "txt_4c_Contint_LostFocus")

        *-- Integracao Contabil (3 botoes)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CIntegCont", ;
            "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil :", 86, 348, 104)
        loc_oAba.AddObject("opt_4c_IntegCont", "OptionGroup")
        WITH loc_oAba.opt_4c_IntegCont
            .ButtonCount  = 3
            .Left         = 192
            .Top          = 345
            .Width        = 316
            .Height       = 23
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption = "N" + CHR(227) + "o"
            .Buttons(1).Width   = 80
            .Buttons(2).Caption = "Sim"
            .Buttons(2).Width   = 80
            .Buttons(3).Caption = "Sem ContraPartida"
            .Buttons(3).Width   = 156
        ENDWITH

        *-- Padrao Preenchimento (4 botoes)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CPadPreench", ;
            "Padr" + CHR(227) + "o de Preenchimento :",       58, 369, 132)
        loc_oAba.AddObject("opt_4c_PadPreench", "OptionGroup")
        WITH loc_oAba.opt_4c_PadPreench
            .ButtonCount  = 4
            .Left         = 192
            .Top          = 366
            .Width        = 353
            .Height       = 23
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption = "Nenhum"
            .Buttons(1).Width   = 70
            .Buttons(2).Caption = "Pagamentos"
            .Buttons(2).Width   = 90
            .Buttons(3).Caption = "Recebimentos"
            .Buttons(3).Width   = 100
            .Buttons(4).Caption = "Ambos"
            .Buttons(4).Width   = 93
        ENDWITH

        *-- Vincula Contas no Pag/Rec
        THIS.CriarLabel(loc_oAba, "lbl_4c_CVincContas", ;
            "Vincula as Contas no Pag/Rec.:",                  38, 390, 152)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_VincContas",    192, 387, 181, 2)

        *-- Visualizar Titulos nao Baixados
        THIS.CriarLabel(loc_oAba, "lbl_4c_CTitBaixado", ;
            "Visualizar T" + CHR(237) + "tulos n" + CHR(227) + "o Baixados :", 36, 410, 154)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_TitBaixado",    192, 407, 181, 2)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAbaEstoque - Controles da Aba 3 (Estoque/Industria)
    * Estoque: LimEsto/VerEst/EstPAcab/ChkLimEst/CCusto + Saldo/Relevante/BlqConGV/Patrim/TipoInvs
    * Industria: GBals/DifPeso/Sinal/Tfalhas/GrupoEst + TrfPeso/GrupoFalha/ContaFalha
    *            UnifBal/ContaPdr/FalPers/BlqDivOp/OsAlFuns/OsPend/Compagru/ObjDupTit/GetAgrupa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAbaEstoque()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3

        THIS.CriarLabel(loc_oAba, "lbl_4c_EEstHeader", "Estoque", 21, 14, 47)

        *== Coluna Esquerda: Limite/Avalia/ProdAcabado/ChkLimEst/CCusto =========
        THIS.CriarLabel(loc_oAba, "lbl_4c_ELimEsto", ;
            "Limite de Estoque :",                             85, 35, 93)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptLimEsto",    174, 30, 92, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_EVerEst",   "Avalia Estoque :",            99, 60, 80)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptVerEst",     174, 56, 92, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_EEstPAcab", ;
            "Estoque Produto Acabado :",                       45, 84, 134)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptEstPAcab",   174, 80, 92, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_EChkLimEst", ;
            "Checa Limite de Estoque:",                        55, 109, 124)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptChkLimEst",  174, 104, 92, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_ECCusto",   "Centro de Custos :",          86, 132, 93)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptCCustoEst",  174, 128, 92, 2)

        *== Coluna Direita: Saldo/Relevante/BlqConGV/Patrim/TipoInvs ===========
        THIS.CriarLabel(loc_oAba, "lbl_4c_ESaldo", ;
            "C" + CHR(225) + "lculo de Saldo :",              386, 35, 87)
        loc_oAba.AddObject("opt_4c_OptSaldo", "OptionGroup")
        WITH loc_oAba.opt_4c_OptSaldo
            .ButtonCount  = 2
            .Left         = 469
            .Top          = 30
            .Width        = 149
            .Height       = 25
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption = "Online"
            .Buttons(1).Width   = 70
            .Buttons(2).Caption = "Background"
            .Buttons(2).Width   = 79
        ENDWITH

        THIS.CriarLabel(loc_oAba, "lbl_4c_ERelevante", ;
            "Empresa Relevante :",                            370, 60, 102)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptRelevante",  469, 56, 113, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_EBlqConGV", ;
            "Bloqueia Consulta Vendas :",                     342, 85, 132)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptBlqConGV",   469, 80, 113, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_EPatrim", ;
            "Patrimonial por Etiqueta :",                     351, 109, 123)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPatrim",     469, 104, 113, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_EInvTipo", ;
            "Invent" + CHR(225) + "rio :",                   415, 132, 55)
        loc_oAba.AddObject("opt_4c_OpTipoInvs", "OptionGroup")
        WITH loc_oAba.opt_4c_OpTipoInvs
            .ButtonCount  = 3
            .Left         = 470
            .Top          = 128
            .Width        = 371
            .Height       = 25
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption = "Pr" + CHR(243) + "prio"
            .Buttons(1).Width   = 100
            .Buttons(2).Caption = "Pr" + CHR(243) + "prio Poder 3p"
            .Buttons(2).Width   = 135
            .Buttons(3).Caption = "Nos Meios 3p"
            .Buttons(3).Width   = 136
        ENDWITH

        *== DDR/DDF (far right) =================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EDdR", ;
            "Dias Bloqueio Retroativo :",                     723, 37, 127)
        loc_oAba.AddObject("txt_4c_DdR", "TextBox")
        WITH loc_oAba.txt_4c_DdR
            .Value         = 0
            .Left          = 852
            .Top           = 33
            .Width         = 45
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH

        THIS.CriarLabel(loc_oAba, "lbl_4c_EDdF", ;
            "Dias Bloqueio Futuro :",                        742, 61, 112)
        loc_oAba.AddObject("txt_4c_DdF", "TextBox")
        WITH loc_oAba.txt_4c_DdF
            .Value         = 0
            .Left          = 852
            .Top           = 57
            .Width         = 45
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH

        *== Separador Industria ==================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EIndHeader", ;
            "Ind" + CHR(250) + "stria",                       21, 174, 54)

        *== Balanco Fabrica + DifPeso + Sinal + Tfalhas ==========================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EGBals", ;
            "Balan" + CHR(231) + "o F" + CHR(225) + "brica :", 93, 199, 84)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptGBals",      174, 194, 92, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_EDifPeso", ;
            "Diferen" + CHR(231) + "a de Peso :",            378, 199, 95)
        loc_oAba.AddObject("txt_4c_DifPeso", "TextBox")
        WITH loc_oAba.txt_4c_DifPeso
            .Value         = 0
            .Left          = 480
            .Top           = 194
            .Width         = 68
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH

        loc_oAba.AddObject("cmb_4c_Sinal", "ComboBox")
        WITH loc_oAba.cmb_4c_Sinal
            .RowSourceType = 1
            .RowSource     = "+,-,P,Q"
            .Style         = 2
            .Left          = 550
            .Top           = 194
            .Width         = 48
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = "+"
        ENDWITH

        THIS.CriarLabel(loc_oAba, "lbl_4c_ETfalhasPQ", "( P/Q )", 621, 199, 40)
        loc_oAba.AddObject("txt_4c_Tfalhas", "TextBox")
        WITH loc_oAba.txt_4c_Tfalhas
            .Value         = ""
            .Left          = 601
            .Top           = 194
            .Width         = 17
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
        ENDWITH

        *== Grupo Dif. Balanco + Transfere Peso ==================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EGrupDif", ;
            "Grupo Dif. Balan" + CHR(231) + "o :",            78, 224, 98)
        loc_oAba.AddObject("txt_4c_GrupoEst", "TextBox")
        WITH loc_oAba.txt_4c_GrupoEst
            .Value         = ""
            .Left          = 179
            .Top           = 219
            .Width         = 90
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_GrupoEst, "KeyPress",  THIS, "txt_4c_GrupoEst_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_GrupoEst, "LostFocus", THIS, "txt_4c_GrupoEst_LostFocus")

        *-- Transfere Peso (5 botoes)
        THIS.CriarLabel(loc_oAba, "lbl_4c_ETrfPeso",  "Transfere Peso :",            395, 219, 82)
        loc_oAba.AddObject("opt_4c_ChkTrfPeso", "OptionGroup")
        WITH loc_oAba.opt_4c_ChkTrfPeso
            .ButtonCount  = 5
            .Left         = 474
            .Top          = 219
            .Width        = 186
            .Height       = 95
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption = "1"
            .Buttons(2).Caption = "2"
            .Buttons(3).Caption = "3"
            .Buttons(4).Caption = "4"
            .Buttons(5).Caption = "5"
        ENDWITH

        *== Grupo/Conta Falha ====================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EGrupoFalha", ;
            "Grupo de Falha :",                              721, 199, 82)
        loc_oAba.AddObject("txt_4c_GrupoFalha", "TextBox")
        WITH loc_oAba.txt_4c_GrupoFalha
            .Value         = ""
            .Left          = 805
            .Top           = 195
            .Width         = 90
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_GrupoFalha, "KeyPress",  THIS, "txt_4c_GrupoFalha_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_GrupoFalha, "LostFocus", THIS, "txt_4c_GrupoFalha_LostFocus")

        THIS.CriarLabel(loc_oAba, "lbl_4c_EContaFalha", ;
            "Conta de Falha :",                              721, 224, 82)
        loc_oAba.AddObject("txt_4c_ContaFalha", "TextBox")
        WITH loc_oAba.txt_4c_ContaFalha
            .Value         = ""
            .Left          = 805
            .Top           = 220
            .Width         = 90
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_ContaFalha, "KeyPress",  THIS, "txt_4c_ContaFalha_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_ContaFalha, "LostFocus", THIS, "txt_4c_ContaFalha_LostFocus")

        loc_oAba.AddObject("txt_4c_DsContaFalha", "TextBox")
        WITH loc_oAba.txt_4c_DsContaFalha
            .Value         = ""
            .Left          = 897
            .Top           = 220
            .Width         = 59
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.
        ENDWITH

        *== Balanco Unificado (4 botoes) =========================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EUnifBal", ;
            "Balan" + CHR(231) + "o Unificado :",             83, 249, 93)
        loc_oAba.AddObject("opt_4c_OptUnifBal", "OptionGroup")
        WITH loc_oAba.opt_4c_OptUnifBal
            .ButtonCount  = 4
            .Left         = 174
            .Top          = 245
            .Width        = 171
            .Height       = 43
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption = "N" + CHR(227) + "o"
            .Buttons(1).Width   = 42
            .Buttons(2).Caption = "Sim"
            .Buttons(2).Width   = 42
            .Buttons(3).Caption = "Parcial"
            .Buttons(3).Width   = 43
            .Buttons(4).Caption = "Total"
            .Buttons(4).Width   = 44
        ENDWITH

        *== Conta Padrao =========================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EContaPdr", ;
            "Conta Padr" + CHR(227) + "o :",                 728, 250, 75)
        loc_oAba.AddObject("txt_4c_ContaPdr", "TextBox")
        WITH loc_oAba.txt_4c_ContaPdr
            .Value         = ""
            .Left          = 805
            .Top           = 246
            .Width         = 90
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_ContaPdr, "KeyPress",  THIS, "txt_4c_ContaPdr_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_ContaPdr, "LostFocus", THIS, "txt_4c_ContaPdr_LostFocus")

        loc_oAba.AddObject("txt_4c_DsContaPdr", "TextBox")
        WITH loc_oAba.txt_4c_DsContaPdr
            .Value         = ""
            .Left          = 896
            .Top           = 246
            .Width         = 59
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.
        ENDWITH

        *== Balanco Falhas/Perdas ================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EFalPers", ;
            "Balan" + CHR(231) + "o Falhas/Perdas :",         61, 293, 117)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptFalPers",    174, 288, 92, 2)

        *== Bloqueia Divisao OF ==================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EBlqDivOp", ;
            "Bloqueia Divis" + CHR(227) + "o de OF :",        59, 318, 118)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptBlqDivOp",   174, 314, 92, 2)

        *== Container Resumo de Composicao (Os/Alianca/Fundicao) ================
        loc_oAba.AddObject("cnt_4c_OsAlFuns", "Container")
        WITH loc_oAba.cnt_4c_OsAlFuns
            .Top         = 311
            .Left        = 324
            .Width       = 347
            .Height      = 27
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oAba.cnt_4c_OsAlFuns.AddObject("lbl_4c_ResComp", "Label")
        WITH loc_oAba.cnt_4c_OsAlFuns.lbl_4c_ResComp
            .Caption   = "Resumo de Composi" + CHR(231) + CHR(227) + "o :"
            .Left      = 30
            .Top       = 6
            .Width     = 122
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oAba.cnt_4c_OsAlFuns.AddObject("chk_4c_CheckOs", "CheckBox")
        WITH loc_oAba.cnt_4c_OsAlFuns.chk_4c_CheckOs
            .Caption   = "Os"
            .Left      = 158
            .Top       = 4
            .Width     = 31
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Value     = 0
        ENDWITH

        loc_oAba.cnt_4c_OsAlFuns.AddObject("chk_4c_CheckAlianca", "CheckBox")
        WITH loc_oAba.cnt_4c_OsAlFuns.chk_4c_CheckAlianca
            .Caption   = "Alian" + CHR(231) + "a"
            .Left      = 199
            .Top       = 4
            .Width     = 52
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Value     = 0
        ENDWITH

        loc_oAba.cnt_4c_OsAlFuns.AddObject("chk_4c_CheckFundicao", "CheckBox")
        WITH loc_oAba.cnt_4c_OsAlFuns.chk_4c_CheckFundicao
            .Caption   = "Fundi" + CHR(231) + CHR(227) + "o"
            .Left      = 266
            .Top       = 4
            .Width     = 61
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Value     = 0
        ENDWITH

        *== OS Pendente Dt.Entrega ===============================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EOsPend", ;
            "OS Pendente Dt.Entrega :",                        49, 343, 128)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_GetOsPend",     174, 338, 92, 2)

        *== Agrupa Componentes (3 botoes) ========================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_ECompagru", ;
            "Agrupa Componentes :",                           364, 341, 109)
        loc_oAba.AddObject("opt_4c_OpCompagru", "OptionGroup")
        WITH loc_oAba.opt_4c_OpCompagru
            .ButtonCount  = 3
            .Left         = 474
            .Top          = 340
            .Width        = 186
            .Height       = 21
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption = "Sim"
            .Buttons(1).Width   = 55
            .Buttons(2).Caption = "N" + CHR(227) + "o"
            .Buttons(2).Width   = 55
            .Buttons(3).Caption = "Mat. Principal"
            .Buttons(3).Width   = 76
        ENDWITH

        *== Checa Duplicidade de Titulo ==========================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EObjDupTit", ;
            "Checa Duplicidade de T" + CHR(237) + "tulo:",    41, 369, 137)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObjDupTit",     174, 364, 92, 2)

        *== Agrupamento ==========================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EAgrupa",   "Agrupamento:",               406, 369, 75)
        loc_oAba.AddObject("txt_4c_GetAgrupa", "TextBox")
        WITH loc_oAba.txt_4c_GetAgrupa
            .Value         = ""
            .Left          = 480
            .Top           = 365
            .Width         = 150
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH

        *== Controle de Lote (3 botoes) ==========================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_ECtrlLote", ;
            "Controle de Lote :",                             388, 396, 88)
        loc_oAba.AddObject("opt_4c_CtrlLotes", "OptionGroup")
        WITH loc_oAba.opt_4c_CtrlLotes
            .ButtonCount  = 3
            .Left         = 474
            .Top          = 393
            .Width        = 164
            .Height       = 21
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption = "Sim"
            .Buttons(1).Width   = 48
            .Buttons(2).Caption = "N" + CHR(227) + "o"
            .Buttons(2).Width   = 48
            .Buttons(3).Caption = "M" + CHR(250) + "ltiplos"
            .Buttons(3).Width   = 68
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAbaFaturamento - Controles da Aba 4 (Faturamento/Fiscal)
    * 9 containers fiscais: ICMS/IPI/II/ISS/IRRF/INSS/PIS/CSSL/COFINS
    * Cada container: lbl(nome), CdGrupos, CdContas, DsContas, PctAliqs, Receitas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAbaFaturamento()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page4

        *-- Headers
        THIS.CriarLabel(loc_oAba, "lbl_4c_FImposto",  "Impostos",                    22, 33, 60)
        THIS.CriarLabel(loc_oAba, "lbl_4c_FGrupo",    "Grupo",                       104, 33, 40)
        THIS.CriarLabel(loc_oAba, "lbl_4c_FConta", ;
            "Conta e Descri" + CHR(231) + CHR(227) + "o",    301, 33, 120)
        THIS.CriarLabel(loc_oAba, "lbl_4c_FAliqs", ;
            "Al" + CHR(237) + "quota",                        552, 33, 50)
        THIS.CriarLabel(loc_oAba, "lbl_4c_FReceita",  "Receita",                     623, 33, 50)

        *-- 9 containers fiscais (mesma estrutura, tops sequenciais)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_ICMS", "ICMS",   52)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_IPI",  "IPI",    78)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_II",   "II",    104)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_ISS",  "ISS",   130)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_IRRF", "IRRF",  156)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_INSS", "INSS",  182)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_PIS",  "PIS",   207)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_CSL",  "CSSL",  233)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_COF",  "COFINS",259)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega registros no grid da lista
    * Colunas: Codigos(80), Descrs(300), Internos(120), TpCods(60), DClasses(300)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Internos"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.TpCods"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.DClasses"

                loc_oGrid.Column1.Width = 80
                loc_oGrid.Column2.Width = 300
                loc_oGrid.Column3.Width = 120
                loc_oGrid.Column4.Width = 60
                loc_oGrid.Column5.Width = 300

                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "Interno"
                loc_oGrid.Column4.Header1.Caption = "Tipo"
                loc_oGrid.Column5.Header1.Caption = "Classe"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do formulario para o Business Object
    * NOTA: Controles das abas internas serao adicionados em FASE 4
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oPag2
        loc_oBO   = THIS.this_oBusinessObject
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        *-- Identificacao (Page2 direto)
        loc_oBO.this_cCodigos = ALLTRIM(loc_oPag2.txt_4c_Codigos.Value)
        loc_oBO.this_cDescrs  = ALLTRIM(loc_oPag2.txt_4c_Descrs.Value)
        loc_oBO.this_cInterno = ALLTRIM(loc_oPag2.txt_4c_Interno.Value)
        loc_oBO.this_nTpCods  = loc_oPag2.opt_4c_TpCods.Value
        loc_oBO.this_nTpEmps  = IIF(loc_oPag2.opt_4c_TpEmps.Visible, loc_oPag2.opt_4c_TpEmps.Value, 2)
        loc_oBO.this_nTpCads  = loc_oPag2.opt_4c_TpCads.Value
        loc_oBO.this_cDigito  = ALLTRIM(loc_oPag2.txt_4c_Digito.Value)
        loc_oBO.this_cClasses = ALLTRIM(loc_oPag2.txt_4c_Classes.Value)

        *-- ChkLimCrds (CheckBox 1=checked -> this_nOptChkLimCr=1/Sim, 0=this_nOptChkLimCr=2/Nao)
        loc_oBO.this_nOptChkLimCr  = IIF(loc_oPag2.chk_4c_LimCrds.Value = 1, 1, 2)
        loc_oBO.this_nOptChkLimEst = IIF(loc_oPag2.chk_4c_LimEsts.Value = 1, 1, 2)

        LOCAL loc_oG, loc_oC, loc_oE, loc_oF
        loc_oG = loc_oPag2.pgf_4c_AbaDados.Page1
        loc_oC = loc_oPag2.pgf_4c_AbaDados.Page2
        loc_oE = loc_oPag2.pgf_4c_AbaDados.Page3
        loc_oF = loc_oPag2.pgf_4c_AbaDados.Page4

        *== ABA GERAL ===========================================================
        loc_oBO.this_nOptComple    = loc_oG.opt_4c_OptComple.Value
        loc_oBO.this_nOptPessoais  = loc_oG.opt_4c_OptPessoais.Value
        loc_oBO.this_nOptRefBancs  = loc_oG.opt_4c_OptRefBancs.Value
        loc_oBO.this_nOptFollowUp  = loc_oG.opt_4c_OptFollowUp.Value
        loc_oBO.this_nOptFiscais   = loc_oG.opt_4c_OptFiscais.Value
        loc_oBO.this_nOptDadosCom  = loc_oG.opt_4c_OptDadosCom.Value
        loc_oBO.this_nOptRespos    = loc_oG.opt_4c_OptRespos.Value
        loc_oBO.this_nOptLimCre    = loc_oG.opt_4c_OptLimCre.Value
        loc_oBO.this_nOptComi      = loc_oG.opt_4c_OptComi.Value
        loc_oBO.this_nOptEmpresa   = loc_oG.opt_4c_OptEmpresa.Value
        loc_oBO.this_nOptContabs   = loc_oG.opt_4c_OptContabs.Value
        loc_oBO.this_nOptCaract    = loc_oG.opt_4c_OptCaract.Value
        loc_oBO.this_nOptPerfil    = loc_oG.opt_4c_OptPerfil.Value
        loc_oBO.this_nOptCargos    = loc_oG.opt_4c_OptCargos.Value
        loc_oBO.this_nOptChkLimCr  = loc_oG.opt_4c_OptChkLimCrG.Value
        loc_oBO.this_nOptColetor   = loc_oG.opt_4c_OptColetor.Value
        loc_oBO.this_nOptPreCad    = loc_oG.opt_4c_OptPreCad.Value
        loc_oBO.this_cGrupoGeral   = ALLTRIM(loc_oG.txt_4c_GrupoGeral.Value)
        loc_oBO.this_nVrlimc       = loc_oG.txt_4c_VrLimCre.Value
        loc_oBO.this_cCdMoeda      = ALLTRIM(loc_oG.txt_4c_CdMoeda.Value)
        loc_oBO.this_cRodRelCC     = loc_oG.edt_4c_RodRelCC.Value

        *== ABA CADASTRO =========================================================
        loc_oBO.this_nCpfObrig     = loc_oC.opt_4c_CpfObrig.Value
        loc_oBO.this_nRgObrig      = loc_oC.opt_4c_RgObrig.Value
        loc_oBO.this_nCepObrig     = loc_oC.opt_4c_CepObrig.Value
        loc_oBO.this_nCalcIMeds    = loc_oC.opt_4c_CalcIMeds.Value
        loc_oBO.this_nObrMails     = loc_oC.opt_4c_ObrMails.Value
        loc_oBO.this_nObrNome      = loc_oC.opt_4c_ObrNome.Value
        loc_oBO.this_nObrSit       = loc_oC.opt_4c_ObrSit.Value
        loc_oBO.this_nObrTlm       = loc_oC.opt_4c_ObrTlm.Value
        loc_oBO.this_nObrCla       = loc_oC.opt_4c_ObrCla.Value
        loc_oBO.this_nObrSeg       = loc_oC.opt_4c_ObrSeg.Value
        loc_oBO.this_nObrIbge      = loc_oC.opt_4c_ObrIbge.Value
        loc_oBO.this_nFpublSobr    = loc_oC.opt_4c_FpublSobr.Value
        loc_oBO.this_nNascObrig    = loc_oC.opt_4c_NascObrig.Value
        loc_oBO.this_nRestEnd      = loc_oC.opt_4c_RestEnd.Value
        loc_oBO.this_nCntVinc      = loc_oC.opt_4c_CntVinc.Value
        loc_oBO.this_nDupEnd       = loc_oC.opt_4c_DupEnd.Value
        loc_oBO.this_nMFotos       = loc_oC.opt_4c_MFotos.Value
        loc_oBO.this_nObservacao   = loc_oC.opt_4c_Observacao.Value
        loc_oBO.this_nCpfFixo      = loc_oC.opt_4c_CpfFixo.Value
        loc_oBO.this_cSituas       = ALLTRIM(loc_oC.txt_4c_Situas.Value)
        loc_oBO.this_nCaracCad     = loc_oC.opt_4c_CaracCad.Value
        loc_oBO.this_nAceJob       = loc_oC.opt_4c_AceJob.Value
        loc_oBO.this_nCCustoTit    = loc_oC.opt_4c_CCustoTit.Value
        loc_oBO.this_nLogAlt       = loc_oC.opt_4c_LogAlt.Value
        loc_oBO.this_nInfSenha     = loc_oC.opt_4c_InfSenha.Value
        loc_oBO.this_cContint      = ALLTRIM(loc_oC.txt_4c_Contint.Value)
        loc_oBO.this_nIntegCont    = loc_oC.opt_4c_IntegCont.Value
        loc_oBO.this_nPadPreench   = loc_oC.opt_4c_PadPreench.Value
        loc_oBO.this_nVincContas   = loc_oC.opt_4c_VincContas.Value
        loc_oBO.this_nTitBaixado   = loc_oC.opt_4c_TitBaixado.Value

        *== ABA ESTOQUE ===========================================================
        loc_oBO.this_nOptLimEsto   = loc_oE.opt_4c_OptLimEsto.Value
        loc_oBO.this_nOptVerEst    = loc_oE.opt_4c_OptVerEst.Value
        loc_oBO.this_nOptEstPAcab  = loc_oE.opt_4c_OptEstPAcab.Value
        loc_oBO.this_nOptChkLimEst = loc_oE.opt_4c_OptChkLimEst.Value
        loc_oBO.this_nOptCCustoEst = loc_oE.opt_4c_OptCCustoEst.Value
        loc_oBO.this_nOptSaldo     = loc_oE.opt_4c_OptSaldo.Value
        loc_oBO.this_nOptRelevante = loc_oE.opt_4c_OptRelevante.Value
        loc_oBO.this_nOptBlqConGV  = loc_oE.opt_4c_OptBlqConGV.Value
        loc_oBO.this_nOptPatrim    = loc_oE.opt_4c_OptPatrim.Value
        loc_oBO.this_nOpTipoInvs   = loc_oE.opt_4c_OpTipoInvs.Value
        loc_oBO.this_nDdR          = loc_oE.txt_4c_DdR.Value
        loc_oBO.this_nDdF          = loc_oE.txt_4c_DdF.Value
        loc_oBO.this_nOptGBals     = loc_oE.opt_4c_OptGBals.Value
        loc_oBO.this_nDifPeso      = loc_oE.txt_4c_DifPeso.Value
        loc_oBO.this_cSinal        = ALLTRIM(loc_oE.cmb_4c_Sinal.Value)
        loc_oBO.this_cTfalhas      = ALLTRIM(loc_oE.txt_4c_Tfalhas.Value)
        loc_oBO.this_cGrupoEst     = ALLTRIM(loc_oE.txt_4c_GrupoEst.Value)
        loc_oBO.this_nChkTrfPeso   = loc_oE.opt_4c_ChkTrfPeso.Value
        loc_oBO.this_cGrupoFalha   = ALLTRIM(loc_oE.txt_4c_GrupoFalha.Value)
        loc_oBO.this_cContaFalha   = ALLTRIM(loc_oE.txt_4c_ContaFalha.Value)
        loc_oBO.this_nOptUnifBal   = loc_oE.opt_4c_OptUnifBal.Value
        loc_oBO.this_cContaPdr     = ALLTRIM(loc_oE.txt_4c_ContaPdr.Value)
        loc_oBO.this_nOptFalPers   = loc_oE.opt_4c_OptFalPers.Value
        loc_oBO.this_nOptBlqDivOp  = loc_oE.opt_4c_OptBlqDivOp.Value
        loc_oBO.this_lCheck1       = (loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckOs.Value = 1)
        loc_oBO.this_lCheck2       = (loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckAlianca.Value = 1)
        loc_oBO.this_lCheck3       = (loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckFundicao.Value = 1)
        loc_oBO.this_nGetOsPend    = loc_oE.opt_4c_GetOsPend.Value
        loc_oBO.this_nOpCompagru   = loc_oE.opt_4c_OpCompagru.Value
        loc_oBO.this_nObjDupTit    = loc_oE.opt_4c_ObjDupTit.Value
        loc_oBO.this_cGetAgrupa    = ALLTRIM(loc_oE.txt_4c_GetAgrupa.Value)
        loc_oBO.this_nFwoption1Est = loc_oE.opt_4c_CtrlLotes.Value

        *== ABA FATURAMENTO =======================================================
        loc_oBO.this_cGrupoICMS    = ALLTRIM(loc_oF.cnt_4c_ICMS.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaICMS    = ALLTRIM(loc_oF.cnt_4c_ICMS.txt_4c_CdContas.Value)
        loc_oBO.this_nPctICMS      = loc_oF.cnt_4c_ICMS.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecICMS      = ALLTRIM(loc_oF.cnt_4c_ICMS.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoIPI     = ALLTRIM(loc_oF.cnt_4c_IPI.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaIPI     = ALLTRIM(loc_oF.cnt_4c_IPI.txt_4c_CdContas.Value)
        loc_oBO.this_nPctIPI       = loc_oF.cnt_4c_IPI.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecIPI       = ALLTRIM(loc_oF.cnt_4c_IPI.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoII      = ALLTRIM(loc_oF.cnt_4c_II.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaII      = ALLTRIM(loc_oF.cnt_4c_II.txt_4c_CdContas.Value)
        loc_oBO.this_nPctII        = loc_oF.cnt_4c_II.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecII        = ALLTRIM(loc_oF.cnt_4c_II.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoISS     = ALLTRIM(loc_oF.cnt_4c_ISS.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaISS     = ALLTRIM(loc_oF.cnt_4c_ISS.txt_4c_CdContas.Value)
        loc_oBO.this_nPctISS       = loc_oF.cnt_4c_ISS.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecISS       = ALLTRIM(loc_oF.cnt_4c_ISS.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoIRRF    = ALLTRIM(loc_oF.cnt_4c_IRRF.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaIRRF    = ALLTRIM(loc_oF.cnt_4c_IRRF.txt_4c_CdContas.Value)
        loc_oBO.this_nPctIRRF      = loc_oF.cnt_4c_IRRF.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecIRRF      = ALLTRIM(loc_oF.cnt_4c_IRRF.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoINSS    = ALLTRIM(loc_oF.cnt_4c_INSS.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaINSS    = ALLTRIM(loc_oF.cnt_4c_INSS.txt_4c_CdContas.Value)
        loc_oBO.this_nPctINSS      = loc_oF.cnt_4c_INSS.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecINSS      = ALLTRIM(loc_oF.cnt_4c_INSS.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoPIS     = ALLTRIM(loc_oF.cnt_4c_PIS.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaPIS     = ALLTRIM(loc_oF.cnt_4c_PIS.txt_4c_CdContas.Value)
        loc_oBO.this_nPctPIS       = loc_oF.cnt_4c_PIS.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecPIS       = ALLTRIM(loc_oF.cnt_4c_PIS.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoCSL     = ALLTRIM(loc_oF.cnt_4c_CSL.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaCSL     = ALLTRIM(loc_oF.cnt_4c_CSL.txt_4c_CdContas.Value)
        loc_oBO.this_nPctCSL       = loc_oF.cnt_4c_CSL.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecCSL       = ALLTRIM(loc_oF.cnt_4c_CSL.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoCOF     = ALLTRIM(loc_oF.cnt_4c_COF.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaCOF     = ALLTRIM(loc_oF.cnt_4c_COF.txt_4c_CdContas.Value)
        loc_oBO.this_nPctCOF       = loc_oF.cnt_4c_COF.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecCOF       = ALLTRIM(loc_oF.cnt_4c_COF.txt_4c_Receitas.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do Business Object para o formulario
    * NOTA: Controles das abas internas serao populados em FASE 4
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oPag2
        loc_oBO   = THIS.this_oBusinessObject
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        *-- Identificacao
        loc_oPag2.txt_4c_Codigos.Value  = loc_oBO.this_cCodigos
        loc_oPag2.txt_4c_Descrs.Value   = loc_oBO.this_cDescrs
        loc_oPag2.txt_4c_Interno.Value  = loc_oBO.this_cInterno
        loc_oPag2.opt_4c_TpCods.Value   = IIF(loc_oBO.this_nTpCods > 0, loc_oBO.this_nTpCods, 1)
        loc_oPag2.txt_4c_Digito.Value   = loc_oBO.this_cDigito
        loc_oPag2.txt_4c_Classes.Value  = loc_oBO.this_cClasses
        loc_oPag2.txt_4c_DClasses.Value = loc_oBO.this_cDClasses

        *-- TpEmps / TpCads
        loc_oPag2.opt_4c_TpEmps.Value = IIF(loc_oBO.this_nTpEmps > 0, loc_oBO.this_nTpEmps, 1)
        loc_oPag2.opt_4c_TpCads.Value = IIF(loc_oBO.this_nTpCads > 0, loc_oBO.this_nTpCads, 1)

        *-- Visibilidade de Digito e TpEmps dependente de TpCods=1
        loc_oPag2.txt_4c_Digito.Visible    = (loc_oBO.this_nTpCods = 1)
        loc_oPag2.lbl_4c_LblDigito.Visible = (loc_oBO.this_nTpCods = 1)
        loc_oPag2.lbl_4c_TpEmps.Visible    = (loc_oBO.this_nTpCods = 1)
        loc_oPag2.opt_4c_TpEmps.Visible    = (loc_oBO.this_nTpCods = 1)
        loc_oPag2.opt_4c_TpEmps.Enabled    = (loc_oBO.this_nTpCods = 1)

        *-- ChkLimCrds/ChkLimEsts
        loc_oPag2.chk_4c_LimCrds.Value = IIF(loc_oBO.this_nOptChkLimCr  = 1, 1, 0)
        loc_oPag2.chk_4c_LimEsts.Value = IIF(loc_oBO.this_nOptChkLimEst = 1, 1, 0)

        *-- Sincronizar guardia
        THIS.this_cUltClasses = ALLTRIM(loc_oBO.this_cClasses)

        LOCAL loc_oG, loc_oC, loc_oE, loc_oF
        loc_oG = loc_oPag2.pgf_4c_AbaDados.Page1
        loc_oC = loc_oPag2.pgf_4c_AbaDados.Page2
        loc_oE = loc_oPag2.pgf_4c_AbaDados.Page3
        loc_oF = loc_oPag2.pgf_4c_AbaDados.Page4

        *== ABA GERAL ===========================================================
        loc_oG.opt_4c_OptComple.Value    = IIF(loc_oBO.this_nOptComple  > 0, loc_oBO.this_nOptComple,  2)
        loc_oG.opt_4c_OptPessoais.Value  = IIF(loc_oBO.this_nOptPessoais > 0, loc_oBO.this_nOptPessoais, 2)
        loc_oG.opt_4c_OptRefBancs.Value  = IIF(loc_oBO.this_nOptRefBancs > 0, loc_oBO.this_nOptRefBancs, 2)
        loc_oG.opt_4c_OptFollowUp.Value  = IIF(loc_oBO.this_nOptFollowUp > 0, loc_oBO.this_nOptFollowUp, 2)
        loc_oG.opt_4c_OptFiscais.Value   = IIF(loc_oBO.this_nOptFiscais  > 0, loc_oBO.this_nOptFiscais,  2)
        loc_oG.opt_4c_OptDadosCom.Value  = IIF(loc_oBO.this_nOptDadosCom > 0, loc_oBO.this_nOptDadosCom, 2)
        loc_oG.opt_4c_OptRespos.Value    = IIF(loc_oBO.this_nOptRespos   > 0, loc_oBO.this_nOptRespos,   2)
        loc_oG.opt_4c_OptLimCre.Value    = IIF(loc_oBO.this_nOptLimCre   > 0, loc_oBO.this_nOptLimCre,   1)
        loc_oG.opt_4c_OptComi.Value      = IIF(loc_oBO.this_nOptComi     > 0, loc_oBO.this_nOptComi,     2)
        loc_oG.opt_4c_OptEmpresa.Value   = IIF(loc_oBO.this_nOptEmpresa  > 0, loc_oBO.this_nOptEmpresa,  2)
        loc_oG.opt_4c_OptContabs.Value   = IIF(loc_oBO.this_nOptContabs  > 0, loc_oBO.this_nOptContabs,  2)
        loc_oG.opt_4c_OptCaract.Value    = IIF(loc_oBO.this_nOptCaract   > 0, loc_oBO.this_nOptCaract,   2)
        loc_oG.opt_4c_OptPerfil.Value    = IIF(loc_oBO.this_nOptPerfil   > 0, loc_oBO.this_nOptPerfil,   2)
        loc_oG.opt_4c_OptCargos.Value    = IIF(loc_oBO.this_nOptCargos   > 0, loc_oBO.this_nOptCargos,   2)
        loc_oG.opt_4c_OptChkLimCrG.Value = IIF(loc_oBO.this_nOptChkLimCr > 0, loc_oBO.this_nOptChkLimCr, 2)
        loc_oG.opt_4c_OptColetor.Value   = IIF(loc_oBO.this_nOptColetor  > 0, loc_oBO.this_nOptColetor,  2)
        loc_oG.opt_4c_OptPreCad.Value    = IIF(loc_oBO.this_nOptPreCad   > 0, loc_oBO.this_nOptPreCad,   2)
        loc_oG.txt_4c_GrupoGeral.Value   = loc_oBO.this_cGrupoGeral
        loc_oG.txt_4c_VrLimCre.Value     = loc_oBO.this_nVrlimc
        loc_oG.txt_4c_CdMoeda.Value      = loc_oBO.this_cCdMoeda
        loc_oG.txt_4c_DsMoeda.Value      = loc_oBO.this_cDsMoeda
        loc_oG.edt_4c_RodRelCC.Value     = loc_oBO.this_cRodRelCC

        *== ABA CADASTRO =========================================================
        loc_oC.opt_4c_CpfObrig.Value     = IIF(loc_oBO.this_nCpfObrig   > 0, loc_oBO.this_nCpfObrig,   1)
        loc_oC.opt_4c_RgObrig.Value      = IIF(loc_oBO.this_nRgObrig    > 0, loc_oBO.this_nRgObrig,    2)
        loc_oC.opt_4c_CepObrig.Value     = IIF(loc_oBO.this_nCepObrig   > 0, loc_oBO.this_nCepObrig,   1)
        loc_oC.opt_4c_CalcIMeds.Value    = IIF(loc_oBO.this_nCalcIMeds  > 0, loc_oBO.this_nCalcIMeds,  2)
        loc_oC.opt_4c_ObrMails.Value     = IIF(loc_oBO.this_nObrMails   > 0, loc_oBO.this_nObrMails,   2)
        loc_oC.opt_4c_ObrNome.Value      = IIF(loc_oBO.this_nObrNome    > 0, loc_oBO.this_nObrNome,    2)
        loc_oC.opt_4c_ObrSit.Value       = IIF(loc_oBO.this_nObrSit     > 0, loc_oBO.this_nObrSit,     2)
        loc_oC.opt_4c_ObrTlm.Value       = IIF(loc_oBO.this_nObrTlm     > 0, loc_oBO.this_nObrTlm,     2)
        loc_oC.opt_4c_ObrCla.Value       = IIF(loc_oBO.this_nObrCla     > 0, loc_oBO.this_nObrCla,     2)
        loc_oC.opt_4c_ObrSeg.Value       = IIF(loc_oBO.this_nObrSeg     > 0, loc_oBO.this_nObrSeg,     2)
        loc_oC.opt_4c_ObrIbge.Value      = IIF(loc_oBO.this_nObrIbge    > 0, loc_oBO.this_nObrIbge,    2)
        loc_oC.opt_4c_FpublSobr.Value    = IIF(loc_oBO.this_nFpublSobr  > 0, loc_oBO.this_nFpublSobr,  2)
        loc_oC.opt_4c_NascObrig.Value    = IIF(loc_oBO.this_nNascObrig  > 0, loc_oBO.this_nNascObrig,  2)
        loc_oC.opt_4c_RestEnd.Value      = IIF(loc_oBO.this_nRestEnd    > 0, loc_oBO.this_nRestEnd,    2)
        loc_oC.opt_4c_CntVinc.Value      = IIF(loc_oBO.this_nCntVinc    > 0, loc_oBO.this_nCntVinc,    2)
        loc_oC.opt_4c_DupEnd.Value       = IIF(loc_oBO.this_nDupEnd     > 0, loc_oBO.this_nDupEnd,     2)
        loc_oC.opt_4c_MFotos.Value       = IIF(loc_oBO.this_nMFotos     > 0, loc_oBO.this_nMFotos,     2)
        loc_oC.opt_4c_Observacao.Value   = IIF(loc_oBO.this_nObservacao > 0, loc_oBO.this_nObservacao,  1)
        loc_oC.opt_4c_CpfFixo.Value      = IIF(loc_oBO.this_nCpfFixo    > 0, loc_oBO.this_nCpfFixo,    1)
        loc_oC.txt_4c_Situas.Value       = loc_oBO.this_cSituas
        loc_oC.opt_4c_CaracCad.Value     = IIF(loc_oBO.this_nCaracCad   > 0, loc_oBO.this_nCaracCad,   2)
        loc_oC.opt_4c_AceJob.Value       = IIF(loc_oBO.this_nAceJob     > 0, loc_oBO.this_nAceJob,     2)
        loc_oC.opt_4c_CCustoTit.Value    = IIF(loc_oBO.this_nCCustoTit  > 0, loc_oBO.this_nCCustoTit,  2)
        loc_oC.opt_4c_LogAlt.Value       = IIF(loc_oBO.this_nLogAlt     > 0, loc_oBO.this_nLogAlt,     2)
        loc_oC.opt_4c_InfSenha.Value     = IIF(loc_oBO.this_nInfSenha   > 0, loc_oBO.this_nInfSenha,   2)
        loc_oC.txt_4c_Contint.Value      = loc_oBO.this_cContint
        loc_oC.opt_4c_IntegCont.Value    = IIF(loc_oBO.this_nIntegCont  > 0, loc_oBO.this_nIntegCont,  1)
        loc_oC.opt_4c_PadPreench.Value   = IIF(loc_oBO.this_nPadPreench > 0, loc_oBO.this_nPadPreench,  1)
        loc_oC.opt_4c_VincContas.Value   = IIF(loc_oBO.this_nVincContas > 0, loc_oBO.this_nVincContas,  2)
        loc_oC.opt_4c_TitBaixado.Value   = IIF(loc_oBO.this_nTitBaixado > 0, loc_oBO.this_nTitBaixado,  2)

        *== ABA ESTOQUE ===========================================================
        loc_oE.opt_4c_OptLimEsto.Value   = IIF(loc_oBO.this_nOptLimEsto   > 0, loc_oBO.this_nOptLimEsto,   2)
        loc_oE.opt_4c_OptVerEst.Value    = IIF(loc_oBO.this_nOptVerEst    > 0, loc_oBO.this_nOptVerEst,    2)
        loc_oE.opt_4c_OptEstPAcab.Value  = IIF(loc_oBO.this_nOptEstPAcab  > 0, loc_oBO.this_nOptEstPAcab,  2)
        loc_oE.opt_4c_OptChkLimEst.Value = IIF(loc_oBO.this_nOptChkLimEst > 0, loc_oBO.this_nOptChkLimEst, 2)
        loc_oE.opt_4c_OptCCustoEst.Value = IIF(loc_oBO.this_nOptCCustoEst > 0, loc_oBO.this_nOptCCustoEst, 2)
        loc_oE.opt_4c_OptSaldo.Value     = IIF(loc_oBO.this_nOptSaldo     > 0, loc_oBO.this_nOptSaldo,     1)
        loc_oE.opt_4c_OptRelevante.Value = IIF(loc_oBO.this_nOptRelevante > 0, loc_oBO.this_nOptRelevante,  2)
        loc_oE.opt_4c_OptBlqConGV.Value  = IIF(loc_oBO.this_nOptBlqConGV  > 0, loc_oBO.this_nOptBlqConGV,  2)
        loc_oE.opt_4c_OptPatrim.Value    = IIF(loc_oBO.this_nOptPatrim    > 0, loc_oBO.this_nOptPatrim,    2)
        loc_oE.opt_4c_OpTipoInvs.Value   = IIF(loc_oBO.this_nOpTipoInvs   > 0, loc_oBO.this_nOpTipoInvs,   1)
        loc_oE.txt_4c_DdR.Value          = loc_oBO.this_nDdR
        loc_oE.txt_4c_DdF.Value          = loc_oBO.this_nDdF
        loc_oE.opt_4c_OptGBals.Value     = IIF(loc_oBO.this_nOptGBals    > 0, loc_oBO.this_nOptGBals,    2)
        loc_oE.txt_4c_DifPeso.Value      = loc_oBO.this_nDifPeso
        loc_oE.cmb_4c_Sinal.Value        = IIF(EMPTY(loc_oBO.this_cSinal), "+", loc_oBO.this_cSinal)
        loc_oE.txt_4c_Tfalhas.Value      = loc_oBO.this_cTfalhas
        loc_oE.txt_4c_GrupoEst.Value     = loc_oBO.this_cGrupoEst
        loc_oE.opt_4c_ChkTrfPeso.Value   = IIF(loc_oBO.this_nChkTrfPeso  > 0, loc_oBO.this_nChkTrfPeso,  1)
        loc_oE.txt_4c_GrupoFalha.Value   = loc_oBO.this_cGrupoFalha
        loc_oE.txt_4c_ContaFalha.Value   = loc_oBO.this_cContaFalha
        loc_oE.txt_4c_DsContaFalha.Value = loc_oBO.this_cDsContaFalha
        loc_oE.opt_4c_OptUnifBal.Value   = IIF(loc_oBO.this_nOptUnifBal  > 0, loc_oBO.this_nOptUnifBal,  1)
        loc_oE.txt_4c_ContaPdr.Value     = loc_oBO.this_cContaPdr
        loc_oE.txt_4c_DsContaPdr.Value   = loc_oBO.this_cDsContaPdr
        loc_oE.opt_4c_OptFalPers.Value   = IIF(loc_oBO.this_nOptFalPers  > 0, loc_oBO.this_nOptFalPers,  2)
        loc_oE.opt_4c_OptBlqDivOp.Value  = IIF(loc_oBO.this_nOptBlqDivOp > 0, loc_oBO.this_nOptBlqDivOp, 2)
        loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckOs.Value       = IIF(loc_oBO.this_lCheck1, 1, 0)
        loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckAlianca.Value  = IIF(loc_oBO.this_lCheck2, 1, 0)
        loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckFundicao.Value = IIF(loc_oBO.this_lCheck3, 1, 0)
        loc_oE.opt_4c_GetOsPend.Value    = IIF(loc_oBO.this_nGetOsPend   > 0, loc_oBO.this_nGetOsPend,   2)
        loc_oE.opt_4c_OpCompagru.Value   = IIF(loc_oBO.this_nOpCompagru  > 0, loc_oBO.this_nOpCompagru,  1)
        loc_oE.opt_4c_ObjDupTit.Value    = IIF(loc_oBO.this_nObjDupTit   > 0, loc_oBO.this_nObjDupTit,   2)
        loc_oE.txt_4c_GetAgrupa.Value    = loc_oBO.this_cGetAgrupa
        loc_oE.opt_4c_CtrlLotes.Value    = IIF(loc_oBO.this_nFwoption1Est > 0, loc_oBO.this_nFwoption1Est, 1)

        *== ABA FATURAMENTO =======================================================
        loc_oF.cnt_4c_ICMS.txt_4c_CdGrupos.Value = loc_oBO.this_cGrupoICMS
        loc_oF.cnt_4c_ICMS.txt_4c_CdContas.Value = loc_oBO.this_cContaICMS
        loc_oF.cnt_4c_ICMS.txt_4c_DsContas.Value = loc_oBO.this_cDsContaICMS
        loc_oF.cnt_4c_ICMS.txt_4c_PctAliqs.Value = loc_oBO.this_nPctICMS
        loc_oF.cnt_4c_ICMS.txt_4c_Receitas.Value = loc_oBO.this_cRecICMS

        loc_oF.cnt_4c_IPI.txt_4c_CdGrupos.Value  = loc_oBO.this_cGrupoIPI
        loc_oF.cnt_4c_IPI.txt_4c_CdContas.Value  = loc_oBO.this_cContaIPI
        loc_oF.cnt_4c_IPI.txt_4c_DsContas.Value  = loc_oBO.this_cDsContaIPI
        loc_oF.cnt_4c_IPI.txt_4c_PctAliqs.Value  = loc_oBO.this_nPctIPI
        loc_oF.cnt_4c_IPI.txt_4c_Receitas.Value  = loc_oBO.this_cRecIPI

        loc_oF.cnt_4c_II.txt_4c_CdGrupos.Value   = loc_oBO.this_cGrupoII
        loc_oF.cnt_4c_II.txt_4c_CdContas.Value   = loc_oBO.this_cContaII
        loc_oF.cnt_4c_II.txt_4c_DsContas.Value   = loc_oBO.this_cDsContaII
        loc_oF.cnt_4c_II.txt_4c_PctAliqs.Value   = loc_oBO.this_nPctII
        loc_oF.cnt_4c_II.txt_4c_Receitas.Value   = loc_oBO.this_cRecII

        loc_oF.cnt_4c_ISS.txt_4c_CdGrupos.Value  = loc_oBO.this_cGrupoISS
        loc_oF.cnt_4c_ISS.txt_4c_CdContas.Value  = loc_oBO.this_cContaISS
        loc_oF.cnt_4c_ISS.txt_4c_DsContas.Value  = loc_oBO.this_cDsContaISS
        loc_oF.cnt_4c_ISS.txt_4c_PctAliqs.Value  = loc_oBO.this_nPctISS
        loc_oF.cnt_4c_ISS.txt_4c_Receitas.Value  = loc_oBO.this_cRecISS

        loc_oF.cnt_4c_IRRF.txt_4c_CdGrupos.Value = loc_oBO.this_cGrupoIRRF
        loc_oF.cnt_4c_IRRF.txt_4c_CdContas.Value = loc_oBO.this_cContaIRRF
        loc_oF.cnt_4c_IRRF.txt_4c_DsContas.Value = loc_oBO.this_cDsContaIRRF
        loc_oF.cnt_4c_IRRF.txt_4c_PctAliqs.Value = loc_oBO.this_nPctIRRF
        loc_oF.cnt_4c_IRRF.txt_4c_Receitas.Value = loc_oBO.this_cRecIRRF

        loc_oF.cnt_4c_INSS.txt_4c_CdGrupos.Value = loc_oBO.this_cGrupoINSS
        loc_oF.cnt_4c_INSS.txt_4c_CdContas.Value = loc_oBO.this_cContaINSS
        loc_oF.cnt_4c_INSS.txt_4c_DsContas.Value = loc_oBO.this_cDsContaINSS
        loc_oF.cnt_4c_INSS.txt_4c_PctAliqs.Value = loc_oBO.this_nPctINSS
        loc_oF.cnt_4c_INSS.txt_4c_Receitas.Value = loc_oBO.this_cRecINSS

        loc_oF.cnt_4c_PIS.txt_4c_CdGrupos.Value  = loc_oBO.this_cGrupoPIS
        loc_oF.cnt_4c_PIS.txt_4c_CdContas.Value  = loc_oBO.this_cContaPIS
        loc_oF.cnt_4c_PIS.txt_4c_DsContas.Value  = loc_oBO.this_cDsContaPIS
        loc_oF.cnt_4c_PIS.txt_4c_PctAliqs.Value  = loc_oBO.this_nPctPIS
        loc_oF.cnt_4c_PIS.txt_4c_Receitas.Value  = loc_oBO.this_cRecPIS

        loc_oF.cnt_4c_CSL.txt_4c_CdGrupos.Value  = loc_oBO.this_cGrupoCSL
        loc_oF.cnt_4c_CSL.txt_4c_CdContas.Value  = loc_oBO.this_cContaCSL
        loc_oF.cnt_4c_CSL.txt_4c_DsContas.Value  = loc_oBO.this_cDsContaCSL
        loc_oF.cnt_4c_CSL.txt_4c_PctAliqs.Value  = loc_oBO.this_nPctCSL
        loc_oF.cnt_4c_CSL.txt_4c_Receitas.Value  = loc_oBO.this_cRecCSL

        loc_oF.cnt_4c_COF.txt_4c_CdGrupos.Value  = loc_oBO.this_cGrupoCOF
        loc_oF.cnt_4c_COF.txt_4c_CdContas.Value  = loc_oBO.this_cContaCOF
        loc_oF.cnt_4c_COF.txt_4c_DsContas.Value  = loc_oBO.this_cDsContaCOF
        loc_oF.cnt_4c_COF.txt_4c_PctAliqs.Value  = loc_oBO.this_nPctCOF
        loc_oF.cnt_4c_COF.txt_4c_Receitas.Value  = loc_oBO.this_cRecCOF

        *-- Atualizar estados Enabled dos campos fiscais conforme valores carregados
        THIS.AtualizarEstadoFiscalTodos(loc_oF)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        loc_oPag2.txt_4c_Codigos.Value  = ""
        loc_oPag2.txt_4c_Descrs.Value   = ""
        loc_oPag2.txt_4c_Interno.Value  = ""
        loc_oPag2.opt_4c_TpCods.Value   = 1
        loc_oPag2.opt_4c_TpEmps.Value   = 1
        loc_oPag2.opt_4c_TpCads.Value   = 1
        loc_oPag2.txt_4c_Digito.Value   = ""
        loc_oPag2.txt_4c_Classes.Value  = ""
        loc_oPag2.txt_4c_DClasses.Value = ""
        loc_oPag2.chk_4c_LimCrds.Value  = 0
        loc_oPag2.chk_4c_LimEsts.Value  = 0

        *-- Resetar visibilidade Digito e TpEmps (padrao TpCods=1 = Empresa)
        loc_oPag2.txt_4c_Digito.Visible    = .T.
        loc_oPag2.lbl_4c_LblDigito.Visible = .T.
        loc_oPag2.lbl_4c_TpEmps.Visible    = .T.
        loc_oPag2.opt_4c_TpEmps.Visible    = .T.
        loc_oPag2.opt_4c_TpEmps.Enabled    = .T.

        THIS.this_cUltClasses = ""

        LOCAL loc_oG, loc_oC, loc_oE, loc_oF
        loc_oG = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
        loc_oC = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
        loc_oE = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        loc_oF = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page4

        *== ABA GERAL ===========================================================
        loc_oG.opt_4c_OptComple.Value    = 2
        loc_oG.opt_4c_OptPessoais.Value  = 2
        loc_oG.opt_4c_OptRefBancs.Value  = 2
        loc_oG.opt_4c_OptFollowUp.Value  = 2
        loc_oG.opt_4c_OptFiscais.Value   = 2
        loc_oG.opt_4c_OptDadosCom.Value  = 2
        loc_oG.opt_4c_OptRespos.Value    = 2
        loc_oG.opt_4c_OptLimCre.Value    = 1
        loc_oG.opt_4c_OptComi.Value      = 2
        loc_oG.opt_4c_OptEmpresa.Value   = 2
        loc_oG.opt_4c_OptContabs.Value   = 2
        loc_oG.opt_4c_OptCaract.Value    = 2
        loc_oG.opt_4c_OptPerfil.Value    = 2
        loc_oG.opt_4c_OptCargos.Value    = 2
        loc_oG.opt_4c_OptChkLimCrG.Value = 2
        loc_oG.opt_4c_OptColetor.Value   = 2
        loc_oG.opt_4c_OptPreCad.Value    = 2
        loc_oG.txt_4c_GrupoGeral.Value   = ""
        loc_oG.txt_4c_VrLimCre.Value     = 0
        loc_oG.txt_4c_CdMoeda.Value      = ""
        loc_oG.txt_4c_DsMoeda.Value      = ""
        loc_oG.edt_4c_RodRelCC.Value     = ""

        *== ABA CADASTRO =========================================================
        loc_oC.opt_4c_CpfObrig.Value     = 1
        loc_oC.opt_4c_RgObrig.Value      = 2
        loc_oC.opt_4c_CepObrig.Value     = 1
        loc_oC.opt_4c_CalcIMeds.Value    = 2
        loc_oC.opt_4c_ObrMails.Value     = 2
        loc_oC.opt_4c_ObrNome.Value      = 2
        loc_oC.opt_4c_ObrSit.Value       = 2
        loc_oC.opt_4c_ObrTlm.Value       = 2
        loc_oC.opt_4c_ObrCla.Value       = 2
        loc_oC.opt_4c_ObrSeg.Value       = 2
        loc_oC.opt_4c_ObrIbge.Value      = 2
        loc_oC.opt_4c_FpublSobr.Value    = 2
        loc_oC.opt_4c_NascObrig.Value    = 2
        loc_oC.opt_4c_RestEnd.Value      = 2
        loc_oC.opt_4c_CntVinc.Value      = 2
        loc_oC.opt_4c_DupEnd.Value       = 2
        loc_oC.opt_4c_MFotos.Value       = 2
        loc_oC.opt_4c_Observacao.Value   = 1
        loc_oC.opt_4c_CpfFixo.Value      = 1
        loc_oC.txt_4c_Situas.Value       = ""
        loc_oC.opt_4c_CaracCad.Value     = 2
        loc_oC.opt_4c_AceJob.Value       = 2
        loc_oC.opt_4c_CCustoTit.Value    = 2
        loc_oC.opt_4c_LogAlt.Value       = 2
        loc_oC.opt_4c_InfSenha.Value     = 2
        loc_oC.txt_4c_Contint.Value      = ""
        loc_oC.opt_4c_IntegCont.Value    = 1
        loc_oC.opt_4c_PadPreench.Value   = 1
        loc_oC.opt_4c_VincContas.Value   = 2
        loc_oC.opt_4c_TitBaixado.Value   = 2

        *== ABA ESTOQUE ===========================================================
        loc_oE.opt_4c_OptLimEsto.Value   = 2
        loc_oE.opt_4c_OptVerEst.Value    = 2
        loc_oE.opt_4c_OptEstPAcab.Value  = 2
        loc_oE.opt_4c_OptChkLimEst.Value = 2
        loc_oE.opt_4c_OptCCustoEst.Value = 2
        loc_oE.opt_4c_OptSaldo.Value     = 1
        loc_oE.opt_4c_OptRelevante.Value = 2
        loc_oE.opt_4c_OptBlqConGV.Value  = 2
        loc_oE.opt_4c_OptPatrim.Value    = 2
        loc_oE.opt_4c_OpTipoInvs.Value   = 1
        loc_oE.txt_4c_DdR.Value          = 0
        loc_oE.txt_4c_DdF.Value          = 0
        loc_oE.opt_4c_OptGBals.Value     = 2
        loc_oE.txt_4c_DifPeso.Value      = 0
        loc_oE.cmb_4c_Sinal.Value        = "+"
        loc_oE.txt_4c_Tfalhas.Value      = ""
        loc_oE.txt_4c_GrupoEst.Value     = ""
        loc_oE.opt_4c_ChkTrfPeso.Value   = 1
        loc_oE.txt_4c_GrupoFalha.Value   = ""
        loc_oE.txt_4c_ContaFalha.Value   = ""
        loc_oE.txt_4c_DsContaFalha.Value = ""
        loc_oE.opt_4c_OptUnifBal.Value   = 1
        loc_oE.txt_4c_ContaPdr.Value     = ""
        loc_oE.txt_4c_DsContaPdr.Value   = ""
        loc_oE.opt_4c_OptFalPers.Value   = 2
        loc_oE.opt_4c_OptBlqDivOp.Value  = 2
        loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckOs.Value       = 0
        loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckAlianca.Value  = 0
        loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckFundicao.Value = 0
        loc_oE.opt_4c_GetOsPend.Value    = 2
        loc_oE.opt_4c_OpCompagru.Value   = 1
        loc_oE.opt_4c_ObjDupTit.Value    = 2
        loc_oE.txt_4c_GetAgrupa.Value    = ""
        loc_oE.opt_4c_CtrlLotes.Value    = 1

        *== ABA FATURAMENTO =======================================================
        loc_oF.cnt_4c_ICMS.txt_4c_CdGrupos.Value = ""
        loc_oF.cnt_4c_ICMS.txt_4c_CdContas.Value = ""
        loc_oF.cnt_4c_ICMS.txt_4c_DsContas.Value = ""
        loc_oF.cnt_4c_ICMS.txt_4c_PctAliqs.Value = 0
        loc_oF.cnt_4c_ICMS.txt_4c_Receitas.Value = ""

        loc_oF.cnt_4c_IPI.txt_4c_CdGrupos.Value  = ""
        loc_oF.cnt_4c_IPI.txt_4c_CdContas.Value  = ""
        loc_oF.cnt_4c_IPI.txt_4c_DsContas.Value  = ""
        loc_oF.cnt_4c_IPI.txt_4c_PctAliqs.Value  = 0
        loc_oF.cnt_4c_IPI.txt_4c_Receitas.Value  = ""

        loc_oF.cnt_4c_II.txt_4c_CdGrupos.Value   = ""
        loc_oF.cnt_4c_II.txt_4c_CdContas.Value   = ""
        loc_oF.cnt_4c_II.txt_4c_DsContas.Value   = ""
        loc_oF.cnt_4c_II.txt_4c_PctAliqs.Value   = 0
        loc_oF.cnt_4c_II.txt_4c_Receitas.Value   = ""

        loc_oF.cnt_4c_ISS.txt_4c_CdGrupos.Value  = ""
        loc_oF.cnt_4c_ISS.txt_4c_CdContas.Value  = ""
        loc_oF.cnt_4c_ISS.txt_4c_DsContas.Value  = ""
        loc_oF.cnt_4c_ISS.txt_4c_PctAliqs.Value  = 0
        loc_oF.cnt_4c_ISS.txt_4c_Receitas.Value  = ""

        loc_oF.cnt_4c_IRRF.txt_4c_CdGrupos.Value = ""
        loc_oF.cnt_4c_IRRF.txt_4c_CdContas.Value = ""
        loc_oF.cnt_4c_IRRF.txt_4c_DsContas.Value = ""
        loc_oF.cnt_4c_IRRF.txt_4c_PctAliqs.Value = 0
        loc_oF.cnt_4c_IRRF.txt_4c_Receitas.Value = ""

        loc_oF.cnt_4c_INSS.txt_4c_CdGrupos.Value = ""
        loc_oF.cnt_4c_INSS.txt_4c_CdContas.Value = ""
        loc_oF.cnt_4c_INSS.txt_4c_DsContas.Value = ""
        loc_oF.cnt_4c_INSS.txt_4c_PctAliqs.Value = 0
        loc_oF.cnt_4c_INSS.txt_4c_Receitas.Value = ""

        loc_oF.cnt_4c_PIS.txt_4c_CdGrupos.Value  = ""
        loc_oF.cnt_4c_PIS.txt_4c_CdContas.Value  = ""
        loc_oF.cnt_4c_PIS.txt_4c_DsContas.Value  = ""
        loc_oF.cnt_4c_PIS.txt_4c_PctAliqs.Value  = 0
        loc_oF.cnt_4c_PIS.txt_4c_Receitas.Value  = ""

        loc_oF.cnt_4c_CSL.txt_4c_CdGrupos.Value  = ""
        loc_oF.cnt_4c_CSL.txt_4c_CdContas.Value  = ""
        loc_oF.cnt_4c_CSL.txt_4c_DsContas.Value  = ""
        loc_oF.cnt_4c_CSL.txt_4c_PctAliqs.Value  = 0
        loc_oF.cnt_4c_CSL.txt_4c_Receitas.Value  = ""

        loc_oF.cnt_4c_COF.txt_4c_CdGrupos.Value  = ""
        loc_oF.cnt_4c_COF.txt_4c_CdContas.Value  = ""
        loc_oF.cnt_4c_COF.txt_4c_DsContas.Value  = ""
        loc_oF.cnt_4c_COF.txt_4c_PctAliqs.Value  = 0
        loc_oF.cnt_4c_COF.txt_4c_Receitas.Value  = ""

        *-- Resetar estados Enabled: todos dependentes desabilitados (CdGrupos vazio)
        THIS.AtualizarEstadoFiscalTodos(loc_oF)
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    * par_nPagina: 1=Lista, 2=Dados
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.Visible  = .T.
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.Visible   = .T.
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.Visible = .T.
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Visible   = .T.
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados.Visible = .F.
        ELSE
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.Visible  = .F.
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.Visible   = .F.
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.Visible = .F.
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Visible   = .F.
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados.Visible = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo
    * NOTA: Completar em FASE 7 para controles das abas internas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        *-- Codigo: habilitado somente no modo INCLUIR
        IF THIS.this_cModoAtual = "INCLUIR"
            loc_oPag2.txt_4c_Codigos.Enabled = .T.
        ELSE
            loc_oPag2.txt_4c_Codigos.Enabled = .F.
        ENDIF

        loc_oPag2.txt_4c_Descrs.Enabled   = par_lHabilitar
        loc_oPag2.txt_4c_Interno.Enabled  = par_lHabilitar
        loc_oPag2.opt_4c_TpCods.Enabled   = par_lHabilitar
        loc_oPag2.txt_4c_Digito.Enabled   = par_lHabilitar
        loc_oPag2.txt_4c_Classes.Enabled  = par_lHabilitar
        loc_oPag2.chk_4c_LimCrds.Enabled = par_lHabilitar
        loc_oPag2.chk_4c_LimEsts.Enabled = par_lHabilitar
        loc_oPag2.opt_4c_TpEmps.Enabled  = par_lHabilitar
        loc_oPag2.opt_4c_TpCads.Enabled  = par_lHabilitar

        *-- Abas internas: habilitar/desabilitar como grupo
        loc_oPag2.pgf_4c_AbaDados.Enabled = par_lHabilitar
    ENDPROC

    *==========================================================================
    *-- HANDLERS: Botoes da lista
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Incluir novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir registro selecionado
    * Dependencias verificadas dentro de ccrBO.ExecutarExclusao (SigMvCcr/SigCdCli/SigMvCab)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            IF MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo '" + loc_cCodigo + "'?")
                IF THIS.this_oBusinessObject.Excluir()
                    MsgSucesso("Grupo exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Busca por codigo via FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_Busca", "Codigos", "", ;
                "Buscar Grupo CCR")

            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("Internos","", "Interno")

            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                loc_cCodigo = ALLTRIM(cursor_4c_Busca.Codigos)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            loc_oBusca.Release()

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    *-- HANDLERS: Botoes da pagina de dados
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salvar registro (validacao pelo BO)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgSucesso("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar edicao e voltar para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    *-- EVENTOS: TpCods
    *==========================================================================

    *--------------------------------------------------------------------------
    * opt_4c_TpCods_InteractiveChange - Controla visibilidade de Digito
    * Legado: .Get_Digito.Visible = (CrSigCdGcr.TpCods = 1)
    *--------------------------------------------------------------------------
    PROCEDURE opt_4c_TpCods_InteractiveChange()
        LOCAL loc_lEmpresa
        loc_lEmpresa = (THIS.pgf_4c_Paginas.Page2.opt_4c_TpCods.Value = 1)

        THIS.pgf_4c_Paginas.Page2.txt_4c_Digito.Visible    = loc_lEmpresa
        THIS.pgf_4c_Paginas.Page2.lbl_4c_LblDigito.Visible = loc_lEmpresa

        IF !loc_lEmpresa
            THIS.pgf_4c_Paginas.Page2.txt_4c_Digito.Value = ""
            THIS.pgf_4c_Paginas.Page2.opt_4c_TpEmps.Value = 2
        ENDIF
        THIS.pgf_4c_Paginas.Page2.lbl_4c_TpEmps.Visible = loc_lEmpresa
        THIS.pgf_4c_Paginas.Page2.opt_4c_TpEmps.Visible = loc_lEmpresa
        THIS.pgf_4c_Paginas.Page2.opt_4c_TpEmps.Enabled = loc_lEmpresa
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: Classes (SigCdCss)
    *==========================================================================

    *--------------------------------------------------------------------------
    * txt_4c_Classes_KeyPress - F4 abre lookup de classes
    *--------------------------------------------------------------------------
    PROCEDURE txt_4c_Classes_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupClasses()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * txt_4c_Classes_LostFocus - Valida classe digitada
    *--------------------------------------------------------------------------
    PROCEDURE txt_4c_Classes_LostFocus()
        LOCAL loc_cClasses
        loc_cClasses = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Classes.Value)

        IF loc_cClasses = THIS.this_cUltClasses
            RETURN
        ENDIF

        IF EMPTY(loc_cClasses)
            THIS.pgf_4c_Paginas.Page2.txt_4c_DClasses.Value = ""
            THIS.this_cUltClasses = ""
            RETURN
        ENDIF

        THIS.ValidarClasses(loc_cClasses)
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupClasses - Abre FormBuscaAuxiliar para SigCdCss
    * Legado: fwBuscaExt em SigCdCss, campoCodigo='classes'
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupClasses()
        LOCAL loc_oBusca, loc_cValor

        TRY
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Classes.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCss", "cursor_4c_Css", "Classes", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Classe")
            loc_oBusca.mAddColuna("Classes", "", "Classe")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Css")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Classes.Value  = ALLTRIM(cursor_4c_Css.Classes)
                THIS.pgf_4c_Paginas.Page2.txt_4c_DClasses.Value = ALLTRIM(cursor_4c_Css.Descrs)
                THIS.this_cUltClasses = ALLTRIM(cursor_4c_Css.Classes)
            ENDIF

            IF USED("cursor_4c_Css")
                USE IN cursor_4c_Css
            ENDIF
            loc_oBusca.Release()

        CATCH TO loException
            MostrarErro("Erro no lookup de classes:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarClasses - Verifica classe digitada em SigCdCss (LostFocus)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarClasses(par_cClasses)
        LOCAL loc_cSQL, loc_nRes

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT Classes, Descrs FROM SigCdCss
                WHERE Classes = <<EscaparSQL(par_cClasses)>>
            ENDTEXT

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CssVerif")

            IF loc_nRes >= 0
                IF RECCOUNT("cursor_4c_CssVerif") > 0
                    THIS.pgf_4c_Paginas.Page2.txt_4c_DClasses.Value = ;
                        ALLTRIM(cursor_4c_CssVerif.Descrs)
                    THIS.this_cUltClasses = par_cClasses
                ELSE
                    *-- Codigo nao encontrado: abrir lookup
                    THIS.AbrirLookupClasses()
                ENDIF

                IF USED("cursor_4c_CssVerif")
                    USE IN cursor_4c_CssVerif
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar classe:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *-- UTILIDADES
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            IF .ColumnCount > 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: SigCdGcr - Metodos genericos compartilhados
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirLookupGcr - Abre FormBuscaAuxiliar para SigCdGcr (generico)
    * par_oTxt: TextBox do codigo | par_oTxtDesc: TextBox desc (ou .NULL.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupGcr(par_oTxt, par_oTxtDesc)
        LOCAL loc_oBusca
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_GcrLkp", "Codigos", ;
                ALLTRIM(par_oTxt.Value), ;
                "Selecionar Grupo C/C")
            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GcrLkp")
                par_oTxt.Value = ALLTRIM(cursor_4c_GcrLkp.Codigos)
                IF VARTYPE(par_oTxtDesc) = "O"
                    par_oTxtDesc.Value = ALLTRIM(cursor_4c_GcrLkp.Descrs)
                ENDIF
            ENDIF
            IF USED("cursor_4c_GcrLkp")
                USE IN cursor_4c_GcrLkp
            ENDIF
            loc_oBusca.Release()
        CATCH TO loException
            MostrarErro("Erro no lookup Grupo C/C:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGcr - Verifica codigo SigCdGcr (generico); abre lookup se n/a
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarGcr(par_cCodigo, par_oTxt, par_oTxtDesc)
        LOCAL loc_nRes
        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(par_cCodigo), ;
                "cursor_4c_GcrVerif")
            IF loc_nRes >= 0
                IF RECCOUNT("cursor_4c_GcrVerif") > 0
                    IF VARTYPE(par_oTxtDesc) = "O"
                        par_oTxtDesc.Value = ALLTRIM(cursor_4c_GcrVerif.Descrs)
                    ENDIF
                ELSE
                    THIS.AbrirLookupGcr(par_oTxt, par_oTxtDesc)
                ENDIF
                IF USED("cursor_4c_GcrVerif")
                    USE IN cursor_4c_GcrVerif
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar Grupo C/C:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: GrupoGeral (Aba Geral)
    *==========================================================================

    PROCEDURE txt_4c_GrupoGeral_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115
            THIS.AbrirLookupGrupoGeral()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_GrupoGeral_LostFocus()
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_GrupoGeral.Value)
        IF loc_cVal = THIS.this_cUltGrupoGeral
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            THIS.this_cUltGrupoGeral = ""
            RETURN
        ENDIF
        THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_GrupoGeral, .NULL.)
        THIS.this_cUltGrupoGeral = ALLTRIM(loc_oAba.txt_4c_GrupoGeral.Value)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupGrupoGeral()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
        THIS.AbrirLookupGcr(loc_oAba.txt_4c_GrupoGeral, .NULL.)
        THIS.this_cUltGrupoGeral = ALLTRIM(loc_oAba.txt_4c_GrupoGeral.Value)
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: CdMoeda (Aba Geral / SigCdMoe)
    *==========================================================================

    PROCEDURE txt_4c_CdMoeda_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115
            THIS.AbrirLookupMoeda()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_CdMoeda_LostFocus()
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_CdMoeda.Value)
        IF loc_cVal = THIS.this_cUltCdMoeda
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            loc_oAba.txt_4c_DsMoeda.Value = ""
            THIS.this_cUltCdMoeda = ""
            RETURN
        ENDIF
        THIS.ValidarMoeda(loc_cVal)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oBusca, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_MoeLkp", "cmoes", ;
                ALLTRIM(loc_oAba.txt_4c_CdMoeda.Value), ;
                "Selecionar Moeda")
            loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_MoeLkp")
                loc_oAba.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_MoeLkp.cmoes)
                loc_oAba.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_MoeLkp.dmoes)
                THIS.this_cUltCdMoeda = ALLTRIM(cursor_4c_MoeLkp.cmoes)
            ENDIF
            IF USED("cursor_4c_MoeLkp")
                USE IN cursor_4c_MoeLkp
            ENDIF
            loc_oBusca.Release()
        CATCH TO loException
            MostrarErro("Erro no lookup de Moeda:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE ValidarMoeda(par_cCodigo)
        LOCAL loc_nRes, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cCodigo), ;
                "cursor_4c_MoeVerif")
            IF loc_nRes >= 0
                IF RECCOUNT("cursor_4c_MoeVerif") > 0
                    loc_oAba.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_MoeVerif.dmoes)
                    THIS.this_cUltCdMoeda = par_cCodigo
                ELSE
                    THIS.AbrirLookupMoeda()
                ENDIF
                IF USED("cursor_4c_MoeVerif")
                    USE IN cursor_4c_MoeVerif
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar Moeda:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: Situas (Aba Cadastro / SigCdCst)
    *==========================================================================

    PROCEDURE txt_4c_Situas_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115
            THIS.AbrirLookupSituas()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_Situas_LostFocus()
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_Situas.Value)
        IF loc_cVal = THIS.this_cUltSituas
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            THIS.this_cUltSituas = ""
            RETURN
        ENDIF
        THIS.ValidarSituas(loc_cVal)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupSituas()
        LOCAL loc_oBusca, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCst", "cursor_4c_CstLkp", "codigos", ;
                ALLTRIM(loc_oAba.txt_4c_Situas.Value), ;
                "Selecionar Situa" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CstLkp")
                loc_oAba.txt_4c_Situas.Value = ALLTRIM(cursor_4c_CstLkp.codigos)
                THIS.this_cUltSituas = ALLTRIM(cursor_4c_CstLkp.codigos)
            ENDIF
            IF USED("cursor_4c_CstLkp")
                USE IN cursor_4c_CstLkp
            ENDIF
            loc_oBusca.Release()
        CATCH TO loException
            MostrarErro("Erro no lookup de Situa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE ValidarSituas(par_cCodigo)
        LOCAL loc_nRes, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT codigos FROM SigCdCst WHERE codigos = " + EscaparSQL(par_cCodigo), ;
                "cursor_4c_CstVerif")
            IF loc_nRes >= 0
                IF RECCOUNT("cursor_4c_CstVerif") > 0
                    THIS.this_cUltSituas = par_cCodigo
                ELSE
                    THIS.AbrirLookupSituas()
                ENDIF
                IF USED("cursor_4c_CstVerif")
                    USE IN cursor_4c_CstVerif
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar Situa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: Contint (Aba Cadastro)
    *==========================================================================

    PROCEDURE txt_4c_Contint_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115
            THIS.AbrirLookupContint()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_Contint_LostFocus()
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_Contint.Value)
        IF loc_cVal = THIS.this_cUltContint
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            THIS.this_cUltContint = ""
            RETURN
        ENDIF
        THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_Contint, .NULL.)
        THIS.this_cUltContint = ALLTRIM(loc_oAba.txt_4c_Contint.Value)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupContint()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
        THIS.AbrirLookupGcr(loc_oAba.txt_4c_Contint, .NULL.)
        THIS.this_cUltContint = ALLTRIM(loc_oAba.txt_4c_Contint.Value)
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: GrupoEst (Aba Estoque)
    *==========================================================================

    PROCEDURE txt_4c_GrupoEst_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115
            THIS.AbrirLookupGrupoEst()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_GrupoEst_LostFocus()
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_GrupoEst.Value)
        IF loc_cVal = THIS.this_cUltGrupoEst
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            THIS.this_cUltGrupoEst = ""
            RETURN
        ENDIF
        THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_GrupoEst, .NULL.)
        THIS.this_cUltGrupoEst = ALLTRIM(loc_oAba.txt_4c_GrupoEst.Value)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupGrupoEst()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        THIS.AbrirLookupGcr(loc_oAba.txt_4c_GrupoEst, .NULL.)
        THIS.this_cUltGrupoEst = ALLTRIM(loc_oAba.txt_4c_GrupoEst.Value)
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: GrupoFalha (Aba Estoque)
    *==========================================================================

    PROCEDURE txt_4c_GrupoFalha_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115
            THIS.AbrirLookupGrupoFalha()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_GrupoFalha_LostFocus()
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_GrupoFalha.Value)
        IF loc_cVal = THIS.this_cUltGrupoFalha
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            THIS.this_cUltGrupoFalha = ""
            RETURN
        ENDIF
        THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_GrupoFalha, .NULL.)
        THIS.this_cUltGrupoFalha = ALLTRIM(loc_oAba.txt_4c_GrupoFalha.Value)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupGrupoFalha()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        THIS.AbrirLookupGcr(loc_oAba.txt_4c_GrupoFalha, .NULL.)
        THIS.this_cUltGrupoFalha = ALLTRIM(loc_oAba.txt_4c_GrupoFalha.Value)
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: ContaFalha (Aba Estoque -> com DsContaFalha)
    *==========================================================================

    PROCEDURE txt_4c_ContaFalha_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115
            THIS.AbrirLookupContaFalha()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_ContaFalha_LostFocus()
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_ContaFalha.Value)
        IF loc_cVal = THIS.this_cUltContaFalha
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            loc_oAba.txt_4c_DsContaFalha.Value = ""
            THIS.this_cUltContaFalha = ""
            RETURN
        ENDIF
        THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_ContaFalha, loc_oAba.txt_4c_DsContaFalha)
        THIS.this_cUltContaFalha = ALLTRIM(loc_oAba.txt_4c_ContaFalha.Value)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupContaFalha()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        THIS.AbrirLookupGcr(loc_oAba.txt_4c_ContaFalha, loc_oAba.txt_4c_DsContaFalha)
        THIS.this_cUltContaFalha = ALLTRIM(loc_oAba.txt_4c_ContaFalha.Value)
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: ContaPdr (Aba Estoque -> com DsContaPdr)
    *==========================================================================

    PROCEDURE txt_4c_ContaPdr_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115
            THIS.AbrirLookupContaPdr()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_ContaPdr_LostFocus()
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_ContaPdr.Value)
        IF loc_cVal = THIS.this_cUltContaPdr
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            loc_oAba.txt_4c_DsContaPdr.Value = ""
            THIS.this_cUltContaPdr = ""
            RETURN
        ENDIF
        THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_ContaPdr, loc_oAba.txt_4c_DsContaPdr)
        THIS.this_cUltContaPdr = ALLTRIM(loc_oAba.txt_4c_ContaPdr.Value)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupContaPdr()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        THIS.AbrirLookupGcr(loc_oAba.txt_4c_ContaPdr, loc_oAba.txt_4c_DsContaPdr)
        THIS.this_cUltContaPdr = ALLTRIM(loc_oAba.txt_4c_ContaPdr.Value)
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: Containers Fiscais (CdGrupos + CdContas via F4 + LostFocus)
    *-- GotFocus rastreia container ativo em this_oFiscalCntAtivo
    *-- LostFocus usa this_oFiscalCntAtivo para saber qual container processar
    *==========================================================================

    *--------------------------------------------------------------------------
    * FiscalGotFocus - Rastreia container fiscal ativo quando campo ganha foco
    *--------------------------------------------------------------------------
    PROCEDURE FiscalGotFocus()
        LOCAL loc_oCtrl
        loc_oCtrl = _VFP.ActiveControl
        IF VARTYPE(loc_oCtrl) = "O"
            THIS.this_oFiscalCntAtivo = loc_oCtrl.Parent
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FiscalCdGruposKeyPress - Abre lookup F4 para campo CdGrupos fiscal
    *--------------------------------------------------------------------------
    PROCEDURE FiscalCdGruposKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            LOCAL loc_oCtrl
            loc_oCtrl = _VFP.ActiveControl
            IF VARTYPE(loc_oCtrl) = "O"
                THIS.AbrirLookupFiscalGrupos(loc_oCtrl.Parent)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FiscalCdGruposLostFocus - Valida CdGrupos; limpa dependentes se vazio
    * Legado: getCdGrupos.Valid - fAcessoContab / limpa getCdContas..Receitas
    *--------------------------------------------------------------------------
    PROCEDURE FiscalCdGruposLostFocus()
        LOCAL loc_oCnt, loc_cVal
        loc_oCnt = THIS.this_oFiscalCntAtivo
        IF VARTYPE(loc_oCnt) # "O"
            RETURN
        ENDIF
        IF gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(loc_oCnt.txt_4c_CdGrupos.Value)
        IF EMPTY(loc_cVal)
            *-- Limpar todos os campos dependentes quando grupo e' esvaziado
            loc_oCnt.txt_4c_CdContas.Value = ""
            loc_oCnt.txt_4c_DsContas.Value = ""
            loc_oCnt.txt_4c_PctAliqs.Value = 0
            loc_oCnt.txt_4c_Receitas.Value = ""
        ELSE
            THIS.ValidarGcr(loc_cVal, loc_oCnt.txt_4c_CdGrupos, .NULL.)
        ENDIF
        THIS.AtualizarEstadoFiscal(loc_oCnt)
    ENDPROC

    *--------------------------------------------------------------------------
    * FiscalCdContasKeyPress - Abre lookup F4 para campo CdContas fiscal
    *--------------------------------------------------------------------------
    PROCEDURE FiscalCdContasKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            LOCAL loc_oCtrl
            loc_oCtrl = _VFP.ActiveControl
            IF VARTYPE(loc_oCtrl) = "O"
                THIS.AbrirLookupFiscalContas(loc_oCtrl.Parent)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FiscalCdContasLostFocus - Valida CdContas; preenche DsContas
    * Legado: getCdContas.Valid - fAcessoContas(grupoX, [C], valor, DsContas)
    *--------------------------------------------------------------------------
    PROCEDURE FiscalCdContasLostFocus()
        LOCAL loc_oCnt, loc_cVal
        loc_oCnt = THIS.this_oFiscalCntAtivo
        IF VARTYPE(loc_oCnt) # "O"
            RETURN
        ENDIF
        IF gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(loc_oCnt.txt_4c_CdContas.Value)
        IF EMPTY(loc_cVal)
            loc_oCnt.txt_4c_DsContas.Value = ""
        ELSE
            THIS.ValidarGcr(loc_cVal, loc_oCnt.txt_4c_CdContas, loc_oCnt.txt_4c_DsContas)
        ENDIF
        THIS.AtualizarEstadoFiscal(loc_oCnt)
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupFiscalGrupos - Abre lookup para campo CdGrupos do container
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupFiscalGrupos(par_oCnt)
        THIS.AbrirLookupGcr(par_oCnt.txt_4c_CdGrupos, .NULL.)
        THIS.AtualizarEstadoFiscal(par_oCnt)
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupFiscalContas - Abre lookup para campo CdContas do container
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupFiscalContas(par_oCnt)
        THIS.AbrirLookupGcr(par_oCnt.txt_4c_CdContas, par_oCnt.txt_4c_DsContas)
        THIS.AtualizarEstadoFiscal(par_oCnt)
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoFiscal - Atualiza Enabled dos campos dependentes no container
    * Legado: When() expressions de getCdContas/getDsContas/getPctAliqs/getReceitas
    * Apenas no modo INCLUIR/ALTERAR; VISUALIZAR: todos desabilitados (via pgf_4c_AbaDados.Enabled)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoFiscal(par_oCnt)
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            LOCAL loc_lTemGrupo, loc_lTemConta, loc_lTemPct
            loc_lTemGrupo = !EMPTY(ALLTRIM(par_oCnt.txt_4c_CdGrupos.Value))
            loc_lTemConta = !EMPTY(ALLTRIM(par_oCnt.txt_4c_CdContas.Value))
            loc_lTemPct   = (par_oCnt.txt_4c_PctAliqs.Value # 0)

            par_oCnt.txt_4c_CdContas.Enabled = loc_lTemGrupo
            par_oCnt.txt_4c_DsContas.Enabled = loc_lTemGrupo AND !loc_lTemConta
            par_oCnt.txt_4c_PctAliqs.Enabled = loc_lTemGrupo AND loc_lTemConta
            par_oCnt.txt_4c_Receitas.Enabled = loc_lTemGrupo AND loc_lTemConta AND loc_lTemPct
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoFiscalTodos - Chama AtualizarEstadoFiscal para os 9 containers
    * par_oF: referencia para Page4 (aba Faturamento)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoFiscalTodos(par_oF)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_ICMS)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_IPI)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_II)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_ISS)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_IRRF)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_INSS)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_PIS)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_CSL)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_COF)
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ccrBO.prg):
*=============================================================================
* ccrBO.prg - Business Object para Grupos de Contas Corrente
* Herda de BusinessBase
* Tabela: SigCdGcr | Chave: Codigos
* Join: SigCdCss (Classes -> classes, Descrs as DClasses)
*=============================================================================

DEFINE CLASS ccrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Identificacao principal
    *--------------------------------------------------------------------------
    this_cCodigos     = ""           && Codigos    - PK (C)
    this_cDescrs      = ""           && Descrs     - Descricao (C)
    this_cInterno     = ""           && Interno    - Codigo interno (C)
    this_cDigito      = ""           && Digito     - Digito verificador (C, visivel se TpCods=1)
    this_cClasses     = ""           && Classes    - FK SigCdCss.classes (C)
    this_cDClasses    = ""           && DClasses   - Alias de SigCdCss.Descrs (nao salvo no BD)
    this_nTpCods      = 1            && TpCods     - Tipo: 1=Empresa, 2=C/C (N)
    this_nTpEmps      = 1            && TpEmps     - Tipo empresa: 1=Empresa, 2=C/C (N, visivel se TpCods=1)
    this_nTpCads      = 1            && TpCads     - Tipo cadastro (N)

    *--------------------------------------------------------------------------
    * Campo de configuracao codificada - 40 posicoes
    *--------------------------------------------------------------------------
    this_cCfgCdGcr    = ""           && CfgCdGcr  - Configuracoes codificadas (C,40)

    *--------------------------------------------------------------------------
    * Configuracoes decodificadas de CfgCdGcr - Aba Geral
    * (1=Sim, 2=Nao para OptionGroups com 2 botoes)
    *--------------------------------------------------------------------------
    this_nOptComple   = 2            && Opt_Comple   - Complemento
    this_nOptPessoais = 2            && Opt_Pessoais - Dados Pessoais
    this_nOptRefBancs = 2            && Opt_RefBancs - Ref. Bancarias
    this_nOptFollowUp = 2            && Opt_FollowUp - Follow-Up
    this_nOptFiscais  = 2            && Opt_Fiscais  - Dados Fiscais
    this_nOptContabs  = 2            && Opt_Contabs  - Dados Contabeis
    this_nOptEmpresa  = 2            && Opt_Empresa  - Dados da Empresa
    this_nOptCaract   = 2            && Opt_Caracteris - Caracteristicas
    this_nOptPerfil   = 2            && fwoption2    - Perfil
    this_nOptCargos   = 2            && Opt_Cargo    - Cargos
    this_nOptRespos   = 2            && Opt_Respos   - Possui Responsavel
    this_nOptLimCre   = 1            && Opt_LimCre   - Limite Credito (1=Sim, 2=Nao, 3=Sim-Saldo)
    this_nOptComi     = 2            && Opt_Comi     - Comissao
    this_nOptDadosCom = 2            && Opt_DadosCom - Dados Comerciais
    this_nOptChkLimCr = 2            && opt_ChkLimCr - Checa Limite Credito
    this_nOptColetor  = 2            && Opt_Coletor  - Grupo Padrao (11 opcoes)
    this_nOptPreCad   = 2            && optPreCad    - Pre Cadastro

    *--------------------------------------------------------------------------
    * Campos Geral - diretos
    *--------------------------------------------------------------------------
    this_cGrupoGeral  = ""           && Get_grupo (Geral) - Grupo contabilidade (C)
    this_nVrlimc      = 0            && Get_vrlimc  - Valor Limite Credito (N)
    this_cCdMoeda     = ""           && get_cd_moeda - Codigo Moeda Comissao (C)
    this_cDsMoeda     = ""           && get_ds_moeda - Descricao Moeda (nao salvo, derivado de lookup)
    this_nMolimc      = 0            && get_molimc  - Moeda Limite Credito (N)
    this_cRodRelCC    = ""           && getRodRelCC - Rodape Relatorio Conta Corrente (M)

    *--------------------------------------------------------------------------
    * Configuracoes decodificadas de CfgCdGcr - Aba Cadastro/Financeiro
    *--------------------------------------------------------------------------
    this_nObrMails    = 2            && getObrMails  - E-mail Obrigatorio
    this_nObrNome     = 2            && getObrNome   - Nome Obrigatorio
    this_nVincPgRcs   = 2            && optVincPgRcs - Vincula Conta PG/RC
    this_nObrSit      = 2            && getObrSit    - Situacao Obrigatoria
    this_nObrTlm      = 2            && getObrTlm    - Telemarketing Obrigatorio
    this_nObrCla      = 2            && getObrCla    - Classificacao Obrigatoria
    this_nObrSeg      = 2            && getObrSeg    - Segmento Obrigatorio
    this_nObrIbge     = 2            && getObrIbge   - Cod IBGE Obrigatorio
    this_nFpublSobr   = 2            && Optfpublsobr - F.Publicidade Obrigatoria
    this_nNascObrig   = 2            && Fwoption8    - Data Nascimento Obrigatoria
    this_nCpfObrig    = 1            && Opt_CPFObrig - CPF/CNPJ Obrigatorio (1=Nao, 2=Sim, 3=SIM-Dupla, 4=Nao-Dupla)
    this_nCepObrig    = 1            && Opt_CEPObrig - CEP Obrigatorio (1=Nao, 2=Sim, 3=Sim-buscar)
    this_nRgObrig     = 2            && fwoption2    - RG/IE Obrigatorio
    this_nMFotos      = 2            && Opt_MFotos   - Mostrar Foto
    this_nObservacao  = 1            && fwoption1(Cad) - Observacao (1=Nao Mostrar, 2=Sempre, 3=Mostrar Botao)
    this_nCpfFixo     = 1            && optCpffixo   - CPF/CNPJ Fixo (1=CPF, 2=CNPJ, 3=Ambos)
    this_nCaracCad    = 2            && optCarac     - Caracteristica (Cadastro)
    this_nAceJob      = 2            && optAceJob    - Acesso Job
    this_nCCustoTit   = 2            && Opt_CCusto   - Habilita Centro de Custos nos Titulos
    this_nLogAlt      = 2            && Fwoption6    - Log de Alteracoes
    this_nInfSenha    = 2            && Fwoption7    - Informar Senha na Alteracao
    this_nCntVinc     = 2            && Fwoption4    - Conta Vinculada ao Grupo
    this_nDupEnd      = 2            && Fwoption5    - Verifica Duplicidade de Endereco
    this_nRestEnd     = 2            && Fwoption9(Cad) - Verifica Restricao de Endereco
    this_nIntegCont   = 1            && Opt_Integ    - Integracao Contabil (1=Nao, 2=Sim, 3=SemContraPartida)
    this_nPadPreench  = 1            && Fwoption3    - Padrao de Preenchimento (1=Nenhum, 2=Pagamentos, 3=Recebimentos, 4=Ambos)
    this_nVincContas  = 2            && optVincPgRcs - Vincula as Contas no Pag/Rec
    this_nTitBaixado  = 2            && OptTitBaixado - Visualizar Titulos nao Baixados
    this_nCalcIMeds   = 2            && optCalcIMeds - Calc. I.Medias
    this_nSitPdrIdx   = 1            && getSituas    - Situacao Padrao (indice)

    *--------------------------------------------------------------------------
    * Campos Cadastro - diretos
    *--------------------------------------------------------------------------
    this_cContint     = ""           && Getcontint - Conta Corrente Interna (C)
    this_cSituas      = ""           && getSituas  - Codigo Situacao Padrao (C)

    *--------------------------------------------------------------------------
    * Campos Estoque / Industria - opcoes
    *--------------------------------------------------------------------------
    this_nOptLimEsto  = 2            && Opt_LimEsto  - Limite de Estoque
    this_nOptVerEst   = 2            && Opt_VerEst   - Avalia Estoque
    this_nOptEstPAcab = 2            && Opt_EstPAcab - Estoque Produto Acabado
    this_nOptChkLimEst= 2            && opt_ChkLimest - Checa Limite de Estoque
    this_nOptCCustoEst= 2            && Opt_CCusto(Est) - Centro de Custos
    this_nOptSaldo    = 1            && Opt_Saldo    - Calculo de Saldo (1=Online, 2=Background)
    this_nOptRelevante= 2            && Opt_Relevante - Empresa Relevante
    this_nOptBlqConGV = 2            && Opt_BlqConGV - Bloqueia Consulta Vendas
    this_nOptPatrim   = 2            && Opt_Patrim   - Patrimonial por Etiqueta
    this_nOpTipoInvs  = 1            && OpTipoInvs   - Inventario (1=Proprio, 2=ProprioPoder3p, 3=NosMeio3p)
    this_nOptGBals    = 2            && Opt_GBals    - Balanco Fabrica (1=Sim, 2=Nao)
    this_nOptUnifBal  = 1            && Opt_UnifBal  - Balanco Unificado
    this_nOptFalPers  = 2            && Opt_FalPers  - Balanco Falhas/Perdas
    this_nOptBlqDivOp = 2            && Opt_BlqDivOp - Bloqueia Divisao de OF
    this_nGetOsPend   = 2            && Get_OsPend   - OS Pendente Dt.Entrega
    this_nObjDupTit   = 2            && ObjDupTit    - Checa Duplicidade de Titulo
    this_nOpCompagru  = 1            && op_compagru  - Agrupa Componentes (1=Sim, 2=Nao, 3=MaterialPrincipal)
    this_nFwoption1Est= 1            && Fwoption1(Est) - Controle de Lote (1=Sim, 2=Nao, 3=Multiplos)

    *--------------------------------------------------------------------------
    * Campos Estoque / Industria - diretos
    *--------------------------------------------------------------------------
    this_nDdR         = 0            && get_ddr      - Dias Bloqueio Retroativo (N)
    this_nDdF         = 0            && get_ddf      - Dias Bloqueio Futuro (N)
    this_cGrupoEst    = ""           && Get_grupo(Est) - Grupo Dif. Balanco (C)
    this_nDifPeso     = 0            && Get_DifPeso  - Diferenca de Peso (N)
    this_cSinal       = ""           && Get_Sinal    - Sinal combo (+/-/P/Q) (C)
    this_cTfalhas     = ""           && Get_tfalhas  - Tipo Falhas (P ou Q) (C)
    this_nChkTrfPeso  = 1            && Chk_TrfPeso  - Transfere Peso (5 opcoes)
    this_cGetAgrupa   = ""           && Get_Agrupa   - Agrupamento (C)
    this_cGrupoFalha  = ""           && GetGrupoFalha - Grupo de Falha (C)
    this_cContaFalha  = ""           && GetContaFalha - Conta de Falha (C)
    this_cDsContaFalha= ""           && getDsContas(Est) - Descricao Conta Falha (nao salvo)
    this_cContaPdr    = ""           && getContaPdr  - Conta Padrao (C)
    this_cDsContaPdr  = ""           && getDsContaPdr - Descricao Conta Padrao (nao salvo)

    *-- Resumo de Composicao (Container1 com 3 checkboxes)
    this_lCheck1      = .F.          && Check1 - Os
    this_lCheck2      = .F.          && Check2 - Alianca
    this_lCheck3      = .F.          && Check3 - Fundicao

    *--------------------------------------------------------------------------
    * Campos fiscais codificados - CfgFisXXs
    * Cada campo fiscal armazena: Grupo + Conta + Aliquota + Receita (encoded)
    *--------------------------------------------------------------------------

    *-- ICMS (CfgFisICs)
    this_cGrupoICMS   = ""           && getCdGrupos - Grupo ICMS
    this_cContaICMS   = ""           && getCdContas - Conta ICMS
    this_cDsContaICMS = ""           && getDsContas - Descricao Conta ICMS (nao salvo)
    this_nPctICMS     = 0            && getPctAliqs - Aliquota ICMS (N)
    this_cRecICMS     = ""           && getReceitas - Receita ICMS (C)

    *-- IPI (CfgFisIPs)
    this_cGrupoIPI    = ""
    this_cContaIPI    = ""
    this_cDsContaIPI  = ""
    this_nPctIPI      = 0
    this_cRecIPI      = ""

    *-- II (CfgFisIIs)
    this_cGrupoII     = ""
    this_cContaII     = ""
    this_cDsContaII   = ""
    this_nPctII       = 0
    this_cRecII       = ""

    *-- ISS (CfgFisISs)
    this_cGrupoISS    = ""
    this_cContaISS    = ""
    this_cDsContaISS  = ""
    this_nPctISS      = 0
    this_cRecISS      = ""

    *-- IRRF (CfgFisIRs)
    this_cGrupoIRRF   = ""
    this_cContaIRRF   = ""
    this_cDsContaIRRF = ""
    this_nPctIRRF     = 0
    this_cRecIRRF     = ""

    *-- INSS (CfgFisINs)
    this_cGrupoINSS   = ""
    this_cContaINSS   = ""
    this_cDsContaINSS = ""
    this_nPctINSS     = 0
    this_cRecINSS     = ""

    *-- PIS (CfgFisPIs)
    this_cGrupoPIS    = ""
    this_cContaPIS    = ""
    this_cDsContaPIS  = ""
    this_nPctPIS      = 0
    this_cRecPIS      = ""

    *-- CSSL (CfgFisCSs)
    this_cGrupoCSL    = ""
    this_cContaCSL    = ""
    this_cDsContaCSL  = ""
    this_nPctCSL      = 0
    this_cRecCSL      = ""

    *-- COFINS (CfgFisCOs)
    this_cGrupoCOF    = ""
    this_cContaCOF    = ""
    this_cDsContaCOF  = ""
    this_nPctCOF      = 0
    this_cRecCOF      = ""

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        DODEFAULT()
        THIS.this_cTabela     = "SigCdGcr"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
    *-- Retorna o valor da chave primaria para o sistema de auditoria
        RETURN THIS.this_cCodigos
    ENDPROC

    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
    *==========================================================================
    *-- Busca registros para a grade da lista (Codigos, Descrs, Internos, TpCods, DClasses)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (Codigos C(10), Descrs C(40), Internos C(20), TpCods N(1,0), DClasses C(40))
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.Codigos, a.Descrs, a.Internos, a.TpCods, b.Descrs AS DClasses" + ;
                           " FROM SigCdGcr a" + ;
                           " LEFT JOIN SigCdCss b ON a.Classes = b.Classes"
                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF
                loc_cSQL = loc_cSQL + " ORDER BY a.Codigos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos CCR:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos CCR:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "ccrBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
    *==========================================================================
    *-- Carrega todos os campos de SigCdGcr + DClasses do JOIN para o BO
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.*, b.Descrs AS DClasses" + ;
                       " FROM SigCdGcr a" + ;
                       " LEFT JOIN SigCdCss b ON a.Classes = b.Classes" + ;
                       " WHERE a.codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Grupo de Conta Corrente n" + CHR(227) + "o encontrado!")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar grupo CCR:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "ccrBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
    *-- Mapeia todos os campos do cursor para propriedades do BO
        LOCAL loc_lSucesso, loc_cOsalfuns, loc_nSinal
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Identificacao
                THIS.this_cCodigos  = TratarNulo(Codigos,  "C")
                THIS.this_cDescrs   = TratarNulo(Descrs,   "C")
                THIS.this_cInterno  = TratarNulo(Internos, "C")
                THIS.this_cDigito   = TratarNulo(DgCods,   "C")
                THIS.this_cClasses  = TratarNulo(Classes,  "C")
                THIS.this_cDClasses = TratarNulo(DClasses, "C")
                THIS.this_nTpCods   = TratarNulo(TpCods,   "N")
                THIS.this_nTpEmps   = TratarNulo(TpEmps,   "N")
                THIS.this_nTpCads   = TratarNulo(TpCads,   "N")
                THIS.this_cCfgCdGcr = TratarNulo(CfgCdGcr, "C")

                *-- Opcoes Aba Geral (colunas individuais em SigCdGcr)
                THIS.this_nOptGBals    = TratarNulo(GerBals,   "N")
                THIS.this_nOptCargos   = TratarNulo(Cargos,    "N")
                THIS.this_nOptColetor  = TratarNulo(Coletors,  "N")
                THIS.this_nOptComi     = TratarNulo(Comis,     "N")
                THIS.this_nOptDadosCom = TratarNulo(DadComs,   "N")
                THIS.this_nOptFiscais  = TratarNulo(Fiscais,   "N")
                THIS.this_nOptFollowUp = TratarNulo(FollowUps, "N")
                THIS.this_nOptLimCre   = TratarNulo(LimCres,   "N")
                THIS.this_nOptPessoais = TratarNulo(Pessoais,  "N")
                THIS.this_nOptRefBancs = TratarNulo(RefBancs,  "N")
                THIS.this_nOptRespos   = TratarNulo(Respos,    "N")
                THIS.this_nOptComple   = TratarNulo(Complems,  "N")
                THIS.this_nOptContabs  = TratarNulo(Contabs,   "N")
                THIS.this_nOptEmpresa  = TratarNulo(Empresas,  "N")
                THIS.this_nOptCaract   = TratarNulo(Caracteris,"N")
                THIS.this_nOptChkLimCr = TratarNulo(ChkLimCrds,"N")
                THIS.this_nOptPreCad   = TratarNulo(PreCad,    "N")

                *-- Campos diretos Aba Geral
                THIS.this_cGrupoGeral  = TratarNulo(GruFals,   "C")  && grufals -> Get_grupo Geral
                THIS.this_cContint     = TratarNulo(ContConts, "C")  && Conta Corrente Interna
                THIS.this_nVrlimc      = TratarNulo(VrLimCre,  "N")
                THIS.this_cCdMoeda     = TratarNulo(ComMordas, "C")  && Moeda Comissao
                THIS.this_cRodRelCC    = IIF(ISNULL(RodRelCC), '', RodRelCC)

                *-- Decodificar CfgCdGcr para campos Cadastro sem coluna propria
                THIS.DecodificarCfgCdGcr()

                *-- Sobrepor com colunas individuais Cadastro/Financeiro (mais confiaveis)
                THIS.this_nFpublSobr   = TratarNulo(FpublSobr, "N")
                THIS.this_nNascObrig   = TratarNulo(DtNascObr, "N")
                THIS.this_nCpfObrig    = TratarNulo(CpfObrigs, "N")
                THIS.this_nCepObrig    = TratarNulo(CepObris,  "N")
                THIS.this_nRgObrig     = TratarNulo(RgObrigs,  "N")
                THIS.this_nMFotos      = TratarNulo(MFotos,    "N")
                THIS.this_nObservacao  = TratarNulo(Observas,  "N")
                THIS.this_nCaracCad    = TratarNulo(InfCads,   "N")
                THIS.this_nCCustoTit   = TratarNulo(CcustoTit, "N")
                THIS.this_nLogAlt      = TratarNulo(LogAlt,    "N")
                THIS.this_nInfSenha    = TratarNulo(InfSenha,  "N")
                THIS.this_nCntVinc     = TratarNulo(CtVinculas,"N")
                THIS.this_nDupEnd      = TratarNulo(ChkEndDs,  "N")
                THIS.this_nRestEnd     = TratarNulo(ChkEndRs,  "N")
                THIS.this_nIntegCont   = TratarNulo(IntConts,  "N")
                THIS.this_nPadPreench  = TratarNulo(PadPgRecs, "N")
                THIS.this_nTitBaixado  = TratarNulo(TitBaixado,"N")
                THIS.this_nCalcIMeds   = TratarNulo(CalcIMeds, "N")
                THIS.this_cSituas      = ""  && Carregado via lookup na UI

                *-- Opcoes Estoque/Industria
                THIS.this_nOptLimEsto  = TratarNulo(LimEstoqs, "N")
                THIS.this_nOptVerEst   = TratarNulo(VerEsts,   "N")
                THIS.this_nOptEstPAcab = TratarNulo(Estoques,  "N")
                THIS.this_nOptChkLimEst= TratarNulo(ChkLimEsts,"N")
                THIS.this_nOptCCustoEst= TratarNulo(CCustos,   "N")
                THIS.this_nOptSaldo    = TratarNulo(CalcSalds, "N")
                THIS.this_nOptRelevante= TratarNulo(EmpreLevs, "N")
                THIS.this_nOptBlqConGV = TratarNulo(BlqConGVs, "N")
                THIS.this_nOptPatrim   = TratarNulo(PatriEtqs, "N")
                THIS.this_nOpTipoInvs  = TratarNulo(TipoInvs,  "N")
                THIS.this_nOptUnifBal  = TratarNulo(UnifBals,  "N")
                THIS.this_nOptFalPers  = TratarNulo(BalFalPers,"N")
                THIS.this_nOptBlqDivOp = TratarNulo(BlqDivOps, "N")
                THIS.this_nGetOsPend   = TratarNulo(OsPends,   "N")
                THIS.this_nObjDupTit   = TratarNulo(ChkTits,   "N")
                THIS.this_nOpCompagru  = TratarNulo(CompaGrus, "N")
                THIS.this_nFwoption1Est= TratarNulo(CtrlLotes, "N")

                *-- Campos diretos Estoque
                THIS.this_nDdR         = TratarNulo(DdRetros,  "N")
                THIS.this_nDdF         = TratarNulo(DdFutus,   "N")
                THIS.this_cGrupoEst    = TratarNulo(GrupoLms,  "C")  && grupolms -> Grupo Dif. Balanco
                THIS.this_nDifPeso     = TratarNulo(DifPesAgs, "N")
                THIS.this_cTfalhas     = TratarNulo(Pqs,       "C")
                THIS.this_nChkTrfPeso  = TratarNulo(TrfPesas,  "N")
                THIS.this_cGetAgrupa   = TratarNulo(Agrupas,   "C")
                THIS.this_cGrupoFalha  = TratarNulo(GrupoFalha,"C")
                THIS.this_cContaFalha  = TratarNulo(ContaFalha,"C")
                THIS.this_cContaPdr    = TratarNulo(ContaPdr,  "C")

                *-- Sinal: numeric(1,0) -> char (+/-/P/Q)
                loc_nSinal = TratarNulo(Sinals, "N")
                THIS.this_cSinal = IIF(loc_nSinal=2, '-', IIF(loc_nSinal=3, 'P', IIF(loc_nSinal=4, 'Q', '+')))

                *-- Checkboxes Os/Alianca/Fundicao (osalfuns C(3): '1'=marcado, '0'=desmarcado)
                loc_cOsalfuns = PADR(TratarNulo(OsAlFuns, "C"), 3)
                THIS.this_lCheck1 = (SUBSTR(loc_cOsalfuns, 1, 1) = '1')
                THIS.this_lCheck2 = (SUBSTR(loc_cOsalfuns, 2, 1) = '1')
                THIS.this_lCheck3 = (SUBSTR(loc_cOsalfuns, 3, 1) = '1')

                *-- Campos Faturamento/Fiscal (decodificar CfgFis* - 50 chars cada)
                THIS.DecodificarFiscal("IC", TratarNulo(CfgFisICs, "C"))
                THIS.DecodificarFiscal("IP", TratarNulo(CfgFisIPs, "C"))
                THIS.DecodificarFiscal("II", TratarNulo(CfgFisIIs, "C"))
                THIS.DecodificarFiscal("IS", TratarNulo(CfgFisISs, "C"))
                THIS.DecodificarFiscal("IR", TratarNulo(CfgFisIRs, "C"))
                THIS.DecodificarFiscal("IN", TratarNulo(CfgFisINs, "C"))
                THIS.DecodificarFiscal("PI", TratarNulo(CfgFisPIs, "C"))
                THIS.DecodificarFiscal("CS", TratarNulo(CfgFisCSs, "C"))
                THIS.DecodificarFiscal("CO", TratarNulo(CfgFisCOs, "C"))

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "ccrBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
    *==========================================================================
    *-- Valida campos obrigatorios antes de salvar
        LOCAL loc_lValido, loc_cSQL, loc_nResultado
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescrs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        *-- Verificar duplicidade de codigo em novo registro
        IF loc_lValido AND THIS.this_lNovoRegistro
            TRY
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdGcr WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_ChkDup
                    IF qtd > 0
                        MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                        loc_lValido = .F.
                    ENDIF
                    USE IN cursor_4c_ChkDup
                ENDIF
            CATCH TO loException
                MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "ccrBO.ValidarDados")
                loc_lValido = .F.
            ENDTRY
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
    *-- INSERT INTO SigCdGcr com todos os campos obrigatorios
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL, loc_cCols, loc_cVals
        LOCAL loc_nSinal_n, loc_cOsalfuns
        loc_lSucesso = .F.

        TRY
            *-- Codificar CfgCdGcr antes de salvar
            THIS.CodificarCfgCdGcr()

            *-- Calcular valores especiais
            loc_nSinal_n  = IIF(THIS.this_cSinal='+', 1, IIF(THIS.this_cSinal='-', 2, IIF(THIS.this_cSinal='P', 3, IIF(THIS.this_cSinal='Q', 4, 1))))
            loc_cOsalfuns = IIF(THIS.this_lCheck1,'1','0') + IIF(THIS.this_lCheck2,'1','0') + IIF(THIS.this_lCheck3,'1','0')

            *-- Montar lista de colunas
            loc_cCols = "codigos, descrs, internos, dgcods, classes, tpcods, tpemps, tpcads"
            loc_cCols = loc_cCols + ", gerbals, cargos, cepobris, coletors, comis, cpfobrigs, dadcoms"
            loc_cCols = loc_cCols + ", fiscais, followups, limcres, pessoais, refbancs, respos"
            loc_cCols = loc_cCols + ", mfotos, grufals, contconts, intconts, contabs, empresas, estoques"
            loc_cCols = loc_cCols + ", calcsalds, unifbals, complems, emprelevs, balfalpers"
            loc_cCols = loc_cCols + ", limestoqs, blqdivops, ccustos, ddfutus, ddretros, verests, blqcongvs"
            loc_cCols = loc_cCols + ", tipoinvs, caracteris, observas, chklimcrds, chklimests, infcads"
            loc_cCols = loc_cCols + ", osalfuns, patrietqs, rgobrigs, calcimeds"
            loc_cCols = loc_cCols + ", ddsems, hordd, tpprecos, commordas, chktits, ospends"
            loc_cCols = loc_cCols + ", compagrus, trfpesas, difpesags, fichatecs, pqs, sinals"
            loc_cCols = loc_cCols + ", grupolms, agrupas, rodrelcc, padpgrecs, chkendds, chkendrs, ctrlotes"
            loc_cCols = loc_cCols + ", cfgcdgcr"
            loc_cCols = loc_cCols + ", cfgfiscos, cfgfiscss, cfgfisics, cfgfisiis, cfgfisins"
            loc_cCols = loc_cCols + ", cfgfisips, cfgfisirs, cfgfisiss, cfgfispis"
            loc_cCols = loc_cCols + ", titbaixado, molimcre, vrlimcre"
            loc_cCols = loc_cCols + ", ccustotit, logalt, fpublsobr, infsenha, precad, dtnascobr"
            loc_cCols = loc_cCols + ", grupofalha, contafalha, ctvinculas, contapdr"
            loc_cCols = loc_cCols + ", desccalcimeds, descsit, descfpubls, desctlm, desccla, descseg"
            loc_cCols = loc_cCols + ", bairroobr, cidasobr, ctainatv, endobr, invisivel, nascobr, numobr"
            loc_cCols = loc_cCols + ", paisesobr, sexobr, tel1obr, tel2obr, defhideshow, dtespobr, Obrtelefone"

            *-- Montar lista de valores (mesma ordem das colunas)
            loc_cVals = EscaparSQL(THIS.this_cCodigos)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cDescrs)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cInterno)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cDigito)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cClasses)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nTpCods, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nTpEmps, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nTpCads, 0)
            *-- Opcoes Geral
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptGBals, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptCargos, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nCepObrig, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptColetor, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptComi, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nCpfObrig, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptDadosCom, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptFiscais, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptFollowUp, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptLimCre, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptPessoais, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptRefBancs, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptRespos, 0)
            *-- Campos diretos e opcoes mistas
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nMFotos, 0)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cGrupoGeral)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cContint)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nIntegCont, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptContabs, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptEmpresa, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptEstPAcab, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptSaldo, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptUnifBal, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptComple, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptRelevante, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptFalPers, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptLimEsto, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptBlqDivOp, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptCCustoEst, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nDdF, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nDdR, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptVerEst, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptBlqConGV, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOpTipoInvs, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptCaract, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nObservacao, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptChkLimCr, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptChkLimEst, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nCaracCad, 0)
            loc_cVals = loc_cVals + ", " + EscaparSQL(loc_cOsalfuns)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptPatrim, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nRgObrig, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nCalcIMeds, 0)
            *-- Colunas sem controle no formulario atual
            loc_cVals = loc_cVals + ", 0"  && ddsems
            loc_cVals = loc_cVals + ", 0"  && hordd
            loc_cVals = loc_cVals + ", 0"  && tpprecos
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cCdMoeda)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nObjDupTit, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nGetOsPend, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOpCompagru, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nChkTrfPeso, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nDifPeso, 3)
            loc_cVals = loc_cVals + ", 0"  && fichatecs
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cTfalhas)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(loc_nSinal_n, 0)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cGrupoEst)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cGetAgrupa)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cRodRelCC)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nPadPreench, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nDupEnd, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nRestEnd, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nFwoption1Est, 0)
            loc_cVals = loc_cVals + ", " + EscaparSQL(PADR(THIS.this_cCfgCdGcr, 40))
            *-- CfgFis* (Fiscal - 9 tipos)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("CO"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("CS"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("IC"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("II"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("IN"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("IP"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("IR"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("IS"))
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.CodificarFiscal("PI"))
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nTitBaixado, 0)
            loc_cVals = loc_cVals + ", '   '"  && molimcre C(3) - this_nMolimc e N; incompatibilidade de tipo da fase 1
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nVrlimc, 2)
            *-- Colunas com DEFAULT mas que devem ser salvas explicitamente
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nCCustoTit, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nLogAlt, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nFpublSobr, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nInfSenha, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nOptPreCad, 0)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nNascObrig, 0)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cGrupoFalha)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cContaFalha)
            loc_cVals = loc_cVals + ", " + FormatarNumeroSQL(THIS.this_nCntVinc, 0)
            loc_cVals = loc_cVals + ", " + EscaparSQL(THIS.this_cContaPdr)
            *-- Campos de descricao (calculados/display - salvar vazios)
            loc_cVals = loc_cVals + ", '', '', '', '', '', ''"
            *-- Colunas mais recentes sem controle no formulario (default 0)
            loc_cVals = loc_cVals + ", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0"

            loc_cSQL = "INSERT INTO SigCdGcr (" + loc_cCols + ") VALUES (" + loc_cVals + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir grupo CCR:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "ccrBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
    *-- UPDATE SigCdGcr com todos os campos (exceto PK)
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL, loc_cSet
        LOCAL loc_nSinal_n, loc_cOsalfuns
        loc_lSucesso = .F.

        TRY
            *-- Codificar CfgCdGcr antes de salvar
            THIS.CodificarCfgCdGcr()

            *-- Calcular valores especiais
            loc_nSinal_n  = IIF(THIS.this_cSinal='+', 1, IIF(THIS.this_cSinal='-', 2, IIF(THIS.this_cSinal='P', 3, IIF(THIS.this_cSinal='Q', 4, 1))))
            loc_cOsalfuns = IIF(THIS.this_lCheck1,'1','0') + IIF(THIS.this_lCheck2,'1','0') + IIF(THIS.this_lCheck3,'1','0')

            *-- Montar clausula SET
            loc_cSet = " descrs     = " + EscaparSQL(THIS.this_cDescrs)
            loc_cSet = loc_cSet + ", internos   = " + EscaparSQL(THIS.this_cInterno)
            loc_cSet = loc_cSet + ", dgcods     = " + EscaparSQL(THIS.this_cDigito)
            loc_cSet = loc_cSet + ", classes    = " + EscaparSQL(THIS.this_cClasses)
            loc_cSet = loc_cSet + ", tpcods     = " + FormatarNumeroSQL(THIS.this_nTpCods, 0)
            loc_cSet = loc_cSet + ", tpemps     = " + FormatarNumeroSQL(THIS.this_nTpEmps, 0)
            loc_cSet = loc_cSet + ", tpcads     = " + FormatarNumeroSQL(THIS.this_nTpCads, 0)
            *-- Opcoes Geral
            loc_cSet = loc_cSet + ", gerbals    = " + FormatarNumeroSQL(THIS.this_nOptGBals, 0)
            loc_cSet = loc_cSet + ", cargos     = " + FormatarNumeroSQL(THIS.this_nOptCargos, 0)
            loc_cSet = loc_cSet + ", cepobris   = " + FormatarNumeroSQL(THIS.this_nCepObrig, 0)
            loc_cSet = loc_cSet + ", coletors   = " + FormatarNumeroSQL(THIS.this_nOptColetor, 0)
            loc_cSet = loc_cSet + ", comis      = " + FormatarNumeroSQL(THIS.this_nOptComi, 0)
            loc_cSet = loc_cSet + ", cpfobrigs  = " + FormatarNumeroSQL(THIS.this_nCpfObrig, 0)
            loc_cSet = loc_cSet + ", dadcoms    = " + FormatarNumeroSQL(THIS.this_nOptDadosCom, 0)
            loc_cSet = loc_cSet + ", fiscais    = " + FormatarNumeroSQL(THIS.this_nOptFiscais, 0)
            loc_cSet = loc_cSet + ", followups  = " + FormatarNumeroSQL(THIS.this_nOptFollowUp, 0)
            loc_cSet = loc_cSet + ", limcres    = " + FormatarNumeroSQL(THIS.this_nOptLimCre, 0)
            loc_cSet = loc_cSet + ", pessoais   = " + FormatarNumeroSQL(THIS.this_nOptPessoais, 0)
            loc_cSet = loc_cSet + ", refbancs   = " + FormatarNumeroSQL(THIS.this_nOptRefBancs, 0)
            loc_cSet = loc_cSet + ", respos     = " + FormatarNumeroSQL(THIS.this_nOptRespos, 0)
            loc_cSet = loc_cSet + ", complems   = " + FormatarNumeroSQL(THIS.this_nOptComple, 0)
            loc_cSet = loc_cSet + ", contabs    = " + FormatarNumeroSQL(THIS.this_nOptContabs, 0)
            loc_cSet = loc_cSet + ", empresas   = " + FormatarNumeroSQL(THIS.this_nOptEmpresa, 0)
            loc_cSet = loc_cSet + ", caracteris = " + FormatarNumeroSQL(THIS.this_nOptCaract, 0)
            loc_cSet = loc_cSet + ", chklimcrds = " + FormatarNumeroSQL(THIS.this_nOptChkLimCr, 0)
            loc_cSet = loc_cSet + ", precad     = " + FormatarNumeroSQL(THIS.this_nOptPreCad, 0)
            *-- Campos diretos Geral
            loc_cSet = loc_cSet + ", mfotos     = " + FormatarNumeroSQL(THIS.this_nMFotos, 0)
            loc_cSet = loc_cSet + ", grufals    = " + EscaparSQL(THIS.this_cGrupoGeral)
            loc_cSet = loc_cSet + ", contconts  = " + EscaparSQL(THIS.this_cContint)
            loc_cSet = loc_cSet + ", intconts   = " + FormatarNumeroSQL(THIS.this_nIntegCont, 0)
            loc_cSet = loc_cSet + ", vrlimcre   = " + FormatarNumeroSQL(THIS.this_nVrlimc, 2)
            loc_cSet = loc_cSet + ", commordas  = " + EscaparSQL(THIS.this_cCdMoeda)
            loc_cSet = loc_cSet + ", rodrelcc   = " + EscaparSQL(THIS.this_cRodRelCC)
            *-- Cadastro/Financeiro diretos
            loc_cSet = loc_cSet + ", observas   = " + FormatarNumeroSQL(THIS.this_nObservacao, 0)
            loc_cSet = loc_cSet + ", rgobrigs   = " + FormatarNumeroSQL(THIS.this_nRgObrig, 0)
            loc_cSet = loc_cSet + ", ccustotit  = " + FormatarNumeroSQL(THIS.this_nCCustoTit, 0)
            loc_cSet = loc_cSet + ", logalt     = " + FormatarNumeroSQL(THIS.this_nLogAlt, 0)
            loc_cSet = loc_cSet + ", fpublsobr  = " + FormatarNumeroSQL(THIS.this_nFpublSobr, 0)
            loc_cSet = loc_cSet + ", infsenha   = " + FormatarNumeroSQL(THIS.this_nInfSenha, 0)
            loc_cSet = loc_cSet + ", dtnascobr  = " + FormatarNumeroSQL(THIS.this_nNascObrig, 0)
            loc_cSet = loc_cSet + ", ctvinculas = " + FormatarNumeroSQL(THIS.this_nCntVinc, 0)
            loc_cSet = loc_cSet + ", chkendds   = " + FormatarNumeroSQL(THIS.this_nDupEnd, 0)
            loc_cSet = loc_cSet + ", chkendrs   = " + FormatarNumeroSQL(THIS.this_nRestEnd, 0)
            loc_cSet = loc_cSet + ", padpgrecs  = " + FormatarNumeroSQL(THIS.this_nPadPreench, 0)
            loc_cSet = loc_cSet + ", titbaixado = " + FormatarNumeroSQL(THIS.this_nTitBaixado, 0)
            loc_cSet = loc_cSet + ", calcimeds  = " + FormatarNumeroSQL(THIS.this_nCalcIMeds, 0)
            loc_cSet = loc_cSet + ", infcads    = " + FormatarNumeroSQL(THIS.this_nCaracCad, 0)
            *-- Estoque opcoes
            loc_cSet = loc_cSet + ", estoques   = " + FormatarNumeroSQL(THIS.this_nOptEstPAcab, 0)
            loc_cSet = loc_cSet + ", calcsalds  = " + FormatarNumeroSQL(THIS.this_nOptSaldo, 0)
            loc_cSet = loc_cSet + ", unifbals   = " + FormatarNumeroSQL(THIS.this_nOptUnifBal, 0)
            loc_cSet = loc_cSet + ", emprelevs  = " + FormatarNumeroSQL(THIS.this_nOptRelevante, 0)
            loc_cSet = loc_cSet + ", balfalpers = " + FormatarNumeroSQL(THIS.this_nOptFalPers, 0)
            loc_cSet = loc_cSet + ", limestoqs  = " + FormatarNumeroSQL(THIS.this_nOptLimEsto, 0)
            loc_cSet = loc_cSet + ", blqdivops  = " + FormatarNumeroSQL(THIS.this_nOptBlqDivOp, 0)
            loc_cSet = loc_cSet + ", ccustos    = " + FormatarNumeroSQL(THIS.this_nOptCCustoEst, 0)
            loc_cSet = loc_cSet + ", ddfutus    = " + FormatarNumeroSQL(THIS.this_nDdF, 0)
            loc_cSet = loc_cSet + ", ddretros   = " + FormatarNumeroSQL(THIS.this_nDdR, 0)
            loc_cSet = loc_cSet + ", verests    = " + FormatarNumeroSQL(THIS.this_nOptVerEst, 0)
            loc_cSet = loc_cSet + ", blqcongvs  = " + FormatarNumeroSQL(THIS.this_nOptBlqConGV, 0)
            loc_cSet = loc_cSet + ", tipoinvs   = " + FormatarNumeroSQL(THIS.this_nOpTipoInvs, 0)
            loc_cSet = loc_cSet + ", chklimests = " + FormatarNumeroSQL(THIS.this_nOptChkLimEst, 0)
            loc_cSet = loc_cSet + ", patrietqs  = " + FormatarNumeroSQL(THIS.this_nOptPatrim, 0)
            loc_cSet = loc_cSet + ", ospends    = " + FormatarNumeroSQL(THIS.this_nGetOsPend, 0)
            loc_cSet = loc_cSet + ", chktits    = " + FormatarNumeroSQL(THIS.this_nObjDupTit, 0)
            loc_cSet = loc_cSet + ", compagrus  = " + FormatarNumeroSQL(THIS.this_nOpCompagru, 0)
            loc_cSet = loc_cSet + ", ctrlotes   = " + FormatarNumeroSQL(THIS.this_nFwoption1Est, 0)
            *-- Estoque diretos
            loc_cSet = loc_cSet + ", grupolms   = " + EscaparSQL(THIS.this_cGrupoEst)
            loc_cSet = loc_cSet + ", difpesags  = " + FormatarNumeroSQL(THIS.this_nDifPeso, 3)
            loc_cSet = loc_cSet + ", pqs        = " + EscaparSQL(THIS.this_cTfalhas)
            loc_cSet = loc_cSet + ", sinals     = " + FormatarNumeroSQL(loc_nSinal_n, 0)
            loc_cSet = loc_cSet + ", trfpesas   = " + FormatarNumeroSQL(THIS.this_nChkTrfPeso, 0)
            loc_cSet = loc_cSet + ", agrupas    = " + EscaparSQL(THIS.this_cGetAgrupa)
            loc_cSet = loc_cSet + ", grupofalha = " + EscaparSQL(THIS.this_cGrupoFalha)
            loc_cSet = loc_cSet + ", contafalha = " + EscaparSQL(THIS.this_cContaFalha)
            loc_cSet = loc_cSet + ", contapdr   = " + EscaparSQL(THIS.this_cContaPdr)
            loc_cSet = loc_cSet + ", osalfuns   = " + EscaparSQL(loc_cOsalfuns)
            *-- CfgCdGcr + CfgFis*
            loc_cSet = loc_cSet + ", cfgcdgcr   = " + EscaparSQL(PADR(THIS.this_cCfgCdGcr, 40))
            loc_cSet = loc_cSet + ", cfgfiscos  = " + EscaparSQL(THIS.CodificarFiscal("CO"))
            loc_cSet = loc_cSet + ", cfgfiscss  = " + EscaparSQL(THIS.CodificarFiscal("CS"))
            loc_cSet = loc_cSet + ", cfgfisics  = " + EscaparSQL(THIS.CodificarFiscal("IC"))
            loc_cSet = loc_cSet + ", cfgfisiis  = " + EscaparSQL(THIS.CodificarFiscal("II"))
            loc_cSet = loc_cSet + ", cfgfisins  = " + EscaparSQL(THIS.CodificarFiscal("IN"))
            loc_cSet = loc_cSet + ", cfgfisips  = " + EscaparSQL(THIS.CodificarFiscal("IP"))
            loc_cSet = loc_cSet + ", cfgfisirs  = " + EscaparSQL(THIS.CodificarFiscal("IR"))
            loc_cSet = loc_cSet + ", cfgfisiss  = " + EscaparSQL(THIS.CodificarFiscal("IS"))
            loc_cSet = loc_cSet + ", cfgfispis  = " + EscaparSQL(THIS.CodificarFiscal("PI"))

            loc_cSQL = "UPDATE SigCdGcr SET" + loc_cSet + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar grupo CCR:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "ccrBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
    *-- Verifica dependencias e exclui registro de SigCdGcr
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL, loc_cCodigo, loc_lDependencias
        loc_lSucesso    = .F.
        loc_lDependencias = .F.

        TRY
            loc_cCodigo = THIS.this_cCodigos

            *-- Verificar dependencias em SigMvCcr
            IF !loc_lDependencias
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigMvCcr WHERE Grupos = " + EscaparSQL(loc_cCodigo)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDep") >= 0
                    SELECT cursor_4c_ChkDep
                    loc_lDependencias = (qtd > 0)
                    USE IN cursor_4c_ChkDep
                ENDIF
            ENDIF

            *-- Verificar dependencias em SigCdCli
            IF !loc_lDependencias
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCli WHERE Grupos = " + EscaparSQL(loc_cCodigo)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDep") >= 0
                    SELECT cursor_4c_ChkDep
                    loc_lDependencias = (qtd > 0)
                    USE IN cursor_4c_ChkDep
                ENDIF
            ENDIF

            *-- Verificar dependencias em SigMvCab
            IF !loc_lDependencias
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigMvCab WHERE Grupos = " + EscaparSQL(loc_cCodigo)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDep") >= 0
                    SELECT cursor_4c_ChkDep
                    loc_lDependencias = (qtd > 0)
                    USE IN cursor_4c_ChkDep
                ENDIF
            ENDIF

            IF loc_lDependencias
                MsgAviso("Aten" + CHR(231) + CHR(227) + "o!!! Existem L" + CHR(97) + "n" + CHR(231) + "amentos Efetuados Neste Grupo!!!")
            ELSE
                loc_cSQL = "DELETE FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir grupo CCR:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "ccrBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE DecodificarCfgCdGcr()
    *==========================================================================
    *-- Decodifica o campo CfgCdGcr (40 posicoes) para propriedades individuais
    *-- Cada posicao armazena 1 digito: valor do OptionGroup (1, 2, 3, etc.)
    *-- Posicoes conhecidas (legado): 1=ObrMails, 2=ObrNome, 3=VincPgRcs, 4=ObrSit,
    *-- 5=ObrTlm, 6=ObrCla, 7=ObrSeg, 8=ObrIbge, 9=CpfFixo, 10=CaracCad,
    *-- 11=AceJob, 12=VincContas
        LOCAL loc_cCfg, loc_nVal
        loc_cCfg = PADR(THIS.this_cCfgCdGcr, 40)

        *-- Posicao 1: E-mail Obrigatorio
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 1, 1)))
        THIS.this_nObrMails  = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 2: Nome Obrigatorio
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 2, 1)))
        THIS.this_nObrNome   = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 3: Vincula Conta PG/RC
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 3, 1)))
        THIS.this_nVincPgRcs = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 4: Situacao Obrigatoria
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 4, 1)))
        THIS.this_nObrSit    = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 5: Telemarketing Obrigatorio
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 5, 1)))
        THIS.this_nObrTlm    = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 6: Classificacao Obrigatoria
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 6, 1)))
        THIS.this_nObrCla    = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 7: Segmento Obrigatorio
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 7, 1)))
        THIS.this_nObrSeg    = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 8: Cod IBGE Obrigatorio
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 8, 1)))
        THIS.this_nObrIbge   = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 9: CPF/CNPJ Fixo (1=CPF, 2=CNPJ, 3=Ambos)
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 9, 1)))
        THIS.this_nCpfFixo   = IIF(loc_nVal < 1, 1, loc_nVal)

        *-- Posicao 10: Caracteristica no Cadastro
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 10, 1)))
        THIS.this_nCaracCad  = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 11: Acesso Job
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 11, 1)))
        THIS.this_nAceJob    = IIF(loc_nVal < 1, 2, loc_nVal)

        *-- Posicao 12: Vincula Contas no Pag/Rec
        loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 12, 1)))
        THIS.this_nVincContas= IIF(loc_nVal < 1, 2, loc_nVal)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CodificarCfgCdGcr()
    *==========================================================================
    *-- Codifica propriedades individuais no campo CfgCdGcr (40 posicoes)
        LOCAL loc_cResult
        loc_cResult = REPLICATE('0', 40)

        loc_cResult = STUFF(loc_cResult, 1,  1, STR(THIS.this_nObrMails,  1))
        loc_cResult = STUFF(loc_cResult, 2,  1, STR(THIS.this_nObrNome,   1))
        loc_cResult = STUFF(loc_cResult, 3,  1, STR(THIS.this_nVincPgRcs, 1))
        loc_cResult = STUFF(loc_cResult, 4,  1, STR(THIS.this_nObrSit,    1))
        loc_cResult = STUFF(loc_cResult, 5,  1, STR(THIS.this_nObrTlm,    1))
        loc_cResult = STUFF(loc_cResult, 6,  1, STR(THIS.this_nObrCla,    1))
        loc_cResult = STUFF(loc_cResult, 7,  1, STR(THIS.this_nObrSeg,    1))
        loc_cResult = STUFF(loc_cResult, 8,  1, STR(THIS.this_nObrIbge,   1))
        loc_cResult = STUFF(loc_cResult, 9,  1, STR(THIS.this_nCpfFixo,   1))
        loc_cResult = STUFF(loc_cResult, 10, 1, STR(THIS.this_nCaracCad,  1))
        loc_cResult = STUFF(loc_cResult, 11, 1, STR(THIS.this_nAceJob,    1))
        loc_cResult = STUFF(loc_cResult, 12, 1, STR(THIS.this_nVincContas,1))

        THIS.this_cCfgCdGcr = loc_cResult
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE DecodificarFiscal(par_cTipo, par_cEncoded)
    *==========================================================================
    *-- Decodifica campo CfgFis* (50 chars) para propriedades do tipo fiscal
    *-- Formato: Grupo(10) + Conta(10) + Pct(8,4 decimais) + Receita(10) + padding(12)
        LOCAL loc_cEncoded, loc_cGrupo, loc_cConta, loc_nPct, loc_cReceita
        loc_cEncoded = PADR(IIF(ISNULL(par_cEncoded), '', par_cEncoded), 50)
        loc_cGrupo   = ALLTRIM(SUBSTR(loc_cEncoded, 1,  10))
        loc_cConta   = ALLTRIM(SUBSTR(loc_cEncoded, 11, 10))
        loc_nPct     = VAL(ALLTRIM(SUBSTR(loc_cEncoded, 21, 8)))
        loc_cReceita = ALLTRIM(SUBSTR(loc_cEncoded, 29, 10))

        DO CASE
        CASE par_cTipo = "IC"
            THIS.this_cGrupoICMS = loc_cGrupo
            THIS.this_cContaICMS = loc_cConta
            THIS.this_nPctICMS   = loc_nPct
            THIS.this_cRecICMS   = loc_cReceita
        CASE par_cTipo = "IP"
            THIS.this_cGrupoIPI  = loc_cGrupo
            THIS.this_cContaIPI  = loc_cConta
            THIS.this_nPctIPI    = loc_nPct
            THIS.this_cRecIPI    = loc_cReceita
        CASE par_cTipo = "II"
            THIS.this_cGrupoII   = loc_cGrupo
            THIS.this_cContaII   = loc_cConta
            THIS.this_nPctII     = loc_nPct
            THIS.this_cRecII     = loc_cReceita
        CASE par_cTipo = "IS"
            THIS.this_cGrupoISS  = loc_cGrupo
            THIS.this_cContaISS  = loc_cConta
            THIS.this_nPctISS    = loc_nPct
            THIS.this_cRecISS    = loc_cReceita
        CASE par_cTipo = "IR"
            THIS.this_cGrupoIRRF = loc_cGrupo
            THIS.this_cContaIRRF = loc_cConta
            THIS.this_nPctIRRF   = loc_nPct
            THIS.this_cRecIRRF   = loc_cReceita
        CASE par_cTipo = "IN"
            THIS.this_cGrupoINSS = loc_cGrupo
            THIS.this_cContaINSS = loc_cConta
            THIS.this_nPctINSS   = loc_nPct
            THIS.this_cRecINSS   = loc_cReceita
        CASE par_cTipo = "PI"
            THIS.this_cGrupoPIS  = loc_cGrupo
            THIS.this_cContaPIS  = loc_cConta
            THIS.this_nPctPIS    = loc_nPct
            THIS.this_cRecPIS    = loc_cReceita
        CASE par_cTipo = "CS"
            THIS.this_cGrupoCSL  = loc_cGrupo
            THIS.this_cContaCSL  = loc_cConta
            THIS.this_nPctCSL    = loc_nPct
            THIS.this_cRecCSL    = loc_cReceita
        CASE par_cTipo = "CO"
            THIS.this_cGrupoCOF  = loc_cGrupo
            THIS.this_cContaCOF  = loc_cConta
            THIS.this_nPctCOF    = loc_nPct
            THIS.this_cRecCOF    = loc_cReceita
        ENDCASE
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CodificarFiscal(par_cTipo)
    *==========================================================================
    *-- Codifica propriedades do tipo fiscal em string de 50 chars
    *-- Formato: Grupo(10) + Conta(10) + Pct(8,4 decimais) + Receita(10) + padding(12)
        LOCAL loc_cGrupo, loc_cConta, loc_nPct, loc_cReceita, loc_cResult
        loc_cGrupo   = ""
        loc_cConta   = ""
        loc_nPct     = 0
        loc_cReceita = ""

        DO CASE
        CASE par_cTipo = "IC"
            loc_cGrupo   = THIS.this_cGrupoICMS
            loc_cConta   = THIS.this_cContaICMS
            loc_nPct     = THIS.this_nPctICMS
            loc_cReceita = THIS.this_cRecICMS
        CASE par_cTipo = "IP"
            loc_cGrupo   = THIS.this_cGrupoIPI
            loc_cConta   = THIS.this_cContaIPI
            loc_nPct     = THIS.this_nPctIPI
            loc_cReceita = THIS.this_cRecIPI
        CASE par_cTipo = "II"
            loc_cGrupo   = THIS.this_cGrupoII
            loc_cConta   = THIS.this_cContaII
            loc_nPct     = THIS.this_nPctII
            loc_cReceita = THIS.this_cRecII
        CASE par_cTipo = "IS"
            loc_cGrupo   = THIS.this_cGrupoISS
            loc_cConta   = THIS.this_cContaISS
            loc_nPct     = THIS.this_nPctISS
            loc_cReceita = THIS.this_cRecISS
        CASE par_cTipo = "IR"
            loc_cGrupo   = THIS.this_cGrupoIRRF
            loc_cConta   = THIS.this_cContaIRRF
            loc_nPct     = THIS.this_nPctIRRF
            loc_cReceita = THIS.this_cRecIRRF
        CASE par_cTipo = "IN"
            loc_cGrupo   = THIS.this_cGrupoINSS
            loc_cConta   = THIS.this_cContaINSS
            loc_nPct     = THIS.this_nPctINSS
            loc_cReceita = THIS.this_cRecINSS
        CASE par_cTipo = "PI"
            loc_cGrupo   = THIS.this_cGrupoPIS
            loc_cConta   = THIS.this_cContaPIS
            loc_nPct     = THIS.this_nPctPIS
            loc_cReceita = THIS.this_cRecPIS
        CASE par_cTipo = "CS"
            loc_cGrupo   = THIS.this_cGrupoCSL
            loc_cConta   = THIS.this_cContaCSL
            loc_nPct     = THIS.this_nPctCSL
            loc_cReceita = THIS.this_cRecCSL
        CASE par_cTipo = "CO"
            loc_cGrupo   = THIS.this_cGrupoCOF
            loc_cConta   = THIS.this_cContaCOF
            loc_nPct     = THIS.this_nPctCOF
            loc_cReceita = THIS.this_cRecCOF
        OTHERWISE
            RETURN SPACE(50)
        ENDCASE

        *-- Montar string de 50 chars: Grupo(10)+Conta(10)+Pct(8)+Receita(10)+padding(12)
        loc_cResult = PADR(loc_cGrupo,   10) + ;
                      PADR(loc_cConta,   10) + ;
                      STR(loc_nPct,   8, 4)  + ;
                      PADR(loc_cReceita, 10) + ;
                      SPACE(12)

        RETURN PADR(loc_cResult, 50)
    ENDPROC

ENDDEFINE

