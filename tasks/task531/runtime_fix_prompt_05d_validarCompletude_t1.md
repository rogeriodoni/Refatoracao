# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormTbO.prg] Indicador de pendencia: * (sempre mostra a grade de selecao, independente
[FormTbO.prg] Indicador de pendencia: * exibia essa lista de forma independente

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTbO.prg):
*==============================================================================
* FormTbO.prg - Formulario de Cadastro de Tabelas de Desconto por Operacao
* Tabela: SigOpTdo (vinculo Operacao x Tabela de Desconto SigOpTdz)
* Legado: SIGCDTBV.SCX
*
* FASE 8/8 (FINAL): Form completo. CRUD por vinculo individual (cidchaves):
* Incluir/Visualizar/Alterar/Excluir (Fase 7), Buscar (filtra lista por
* Operacao), Encerrar (fecha form), Salvar/Cancelar (Page2). O legado gravava
* em lote (LocalTabdO -> CrSigOpTdo) ao fechar o form filho; aqui cada
* vinculo e gravado individualmente via BusinessBase.Salvar(), com a mesma
* validacao de duplicidade de Tabds por Dopes aplicada no momento do Salvar
* (TbOBO.ExisteVinculoDuplicado).
*==============================================================================

DEFINE CLASS FormTbO AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 600
    Width        = 1000
    Caption      = "Tabelas de Desconto por Opera" + CHR(231) + CHR(245) + "es"
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    ForeColor    = RGB(90, 90, 90)

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro    = ""

    *-- Guarda ultimo valor de Tabds validado (evita reabrir lookup repetidamente
    *-- a cada LostFocus quando o valor nao mudou - ver Problema 45 do guia)
    this_cUltimoTabdsValidado = ""

    *-- Filtro de Operacao (Dopes) aplicado a lista via BtnBuscarClick.
    *-- Vazio = lista TODOS os vinculos (comportamento padrao de CarregarLista)
    this_cFiltroDopesAtual = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("TbOBO")

            IF ISNULL(THIS.this_oBusinessObject)
                MostrarErro("Erro ao criar Business Object TbOBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                THIS.CarregarLista()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
            MostrarErro("Erro ao inicializar FormTbO:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura PageFrame principal
    * PageFrame.Top = -29 (oculta abas) -> compensar +29px nos controles internos
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
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Grid de vinculos Operacao x Tabela de Desconto + botoes CRUD
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oBotoes, loc_oSaida
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de cabecalho (cntSombra: Top=2 -> 31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1003
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD
        *-- Padrao Framework: grupo_op Left=542, Top=0 -> 29, Width=390, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPagina.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container de saida (padrao canonico CLAUDE.md regra #10 - PREVALECE sobre legado)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPagina.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista: vinculos Operacao (dopes) x Tabela de Desconto (tabds/descrs)
        *-- cidchaves (PK) permanece no cursor mas nao e exibido em coluna (equivalente
        *-- ao GUID gerado por fUniqueIds() no legado - sem significado para o usuario)
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oPagina.grd_4c_Dados.RecordSource = ""
        loc_oPagina.grd_4c_Dados.ColumnCount  = 3

        WITH loc_oPagina.grd_4c_Dados
            .Top                     = 117
            .Left                    = 12
            .Width                   = 890
            .Height                  = 480
            .FontName                = "Verdana"
            .FontSize                = 8
            .ForeColor               = RGB(90, 90, 90)
            .BackColor               = RGB(255, 255, 255)
            .GridLineColor           = RGB(238, 238, 238)
            .HighlightBackColor      = RGB(255, 255, 255)
            .HighlightForeColor      = RGB(15, 41, 104)
            .HighlightStyle          = 2
            .DeleteMark              = .F.
            .RecordMark              = .F.
            .RowHeight               = 16
            .ScrollBars              = 2
            .GridLines               = 3
            .ReadOnly                = .T.
            .Visible                 = .T.
            .Column1.Width           = 150
            .Column2.Width           = 150
            .Column3.Width           = 588
            .Column1.ReadOnly        = .T.
            .Column2.ReadOnly        = .T.
            .Column3.ReadOnly        = .T.
            .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(245) + "o"
            .Column2.Header1.Caption = "Tab.Desconto"
            .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega TODOS os vinculos Operacao x Tabela de Desconto
    * no Grid da Page1 (equivalente a busca geral, sem filtro de Dopes)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid

        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

                IF !THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroDopesAtual)
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid.RecordSource = ""
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.dopes"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.tabds"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"

                    *-- RecordSource reseta Width/Header/ReadOnly - reconfigurar SEMPRE
                    loc_oGrid.Column1.Width           = 150
                    loc_oGrid.Column2.Width           = 150
                    loc_oGrid.Column3.Width           = 588
                    loc_oGrid.Column1.ReadOnly        = .T.
                    loc_oGrid.Column2.ReadOnly        = .T.
                    loc_oGrid.Column3.ReadOnly        = .T.
                    loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(245) + "o"
                    loc_oGrid.Column2.Header1.Caption = "Tab.Desconto"
                    loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                    THIS.FormatarGridLista(loc_oGrid)

                    loc_oGrid.Refresh()

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista de tabelas de desconto:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Campos completos: txt_4c_Dopes (Operacao, read-only), txt_4c_Tabds
    * (Tabela de Desconto, editavel, com lookup F4/DblClick completo em
    * SigOpTdz) e txt_4c_Descrs (Descricao, read-only, derivado do JOIN).
    * Container cnt_4c_BotoesAcao com botoes Confirmar/Cancelar (BINDEVENT para
    * BtnSalvarClick/BtnCancelarClick, cuja logica e implementada na fase de
    * Eventos - mesmo padrao usado nos botoes CRUD de ConfigurarPaginaLista).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = THIS.Caption
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container de botoes Confirmar/Cancelar
        *-- Padrao Framework: grupo_salva Left=834, Top=4 -> 33, Width=160, Height=85
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 834
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        * CAMPO 1: Operacao (dopes) - FASE 5/8 (parte 1 de 2)
        * O legado nao tem um controle proprio para este campo: a operacao vem
        * do form pai (crSigCdOpe.Dopes, injetado no Init(poForm,...) da SIGCDTBV)
        * e e apenas exibida no Caption. No novo sistema, cada vinculo SigOpTdo
        * tem seu proprio "dopes" (this_cDopes do TbOBO), entao o campo aparece
        * aqui como somente-leitura para dar visibilidade ao usuario durante
        * Incluir/Alterar/Visualizar.
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Operacao", "Label")
        WITH loc_oPagina.lbl_4c_Operacao
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o : "
            .Top       = 160
            .Left      = 40
            .Width     = 90
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dopes", "TextBox")
        WITH loc_oPagina.txt_4c_Dopes
            .Value         = ""
            .Top           = 156
            .Left          = 135
            .Width         = 150
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 20
            .ReadOnly      = .T.
            .BackColor     = RGB(212, 208, 200)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * CAMPO 2: Tabela de Desconto (tabds) - FASE 5/8 (parte 2 de 2)
        * Equivale a GradeSubN.Column1.Text1 do legado (celula editavel da grade,
        * com lookup fwBuscaExt em SigOpTdz.Codigos - lookup sera vinculado na
        * Fase 7/8). Aqui apenas o TextBox editavel.
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_TabelaDesconto", "Label")
        WITH loc_oPagina.lbl_4c_TabelaDesconto
            .Caption   = "Tab. Desconto : "
            .Top       = 191
            .Left      = 40
            .Width     = 90
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tabds", "TextBox")
        WITH loc_oPagina.txt_4c_Tabds
            .Value         = ""
            .Top           = 187
            .Left          = 135
            .Width         = 80
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Lookup (F4/DblClick) + validacao ao sair do campo (LostFocus)
        *-- Espelha GradeSubN.Column1.Text1.Valid do legado (fwBuscaExt em SigOpTdz)
        BINDEVENT(loc_oPagina.txt_4c_Tabds, "KeyPress",  THIS, "TabdsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Tabds, "DblClick",  THIS, "TabdsLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Tabds, "KeyPress", THIS, "ValidarTabds")

        *----------------------------------------------------------------------
        * CAMPO 3: Descricao (descrs) - FASE 6/8
        * Campo derivado do JOIN com SigOpTdz (somente exibicao). E preenchido
        * automaticamente ao validar/selecionar a Tabela de Desconto (txt_4c_Tabds)
        * e NAO e persistido diretamente em SigOpTdo (equivalente ao
        * "Replace Descrs With CrListaRemota.Descrs in LocalTabdO" do legado, que
        * so atualizava a coluna auxiliar de exibicao da grade).
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
            .Top       = 222
            .Left      = 40
            .Width     = 90
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPagina.txt_4c_Descrs
            .Value         = ""
            .Top           = 218
            .Left          = 135
            .Width         = 250
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 30
            .ReadOnly      = .T.
            .BackColor     = RGB(212, 208, 200)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do Form para o BO antes de salvar
    * this_cDescrs e mantido em sincronia apenas para exibicao/consistencia -
    * NAO e persistido em SigOpTdo (coluna pertence a SigOpTdz, via JOIN).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cDopes  = ALLTRIM(loc_oPagina.txt_4c_Dopes.Value)
        THIS.this_oBusinessObject.this_cTabds  = ALLTRIM(loc_oPagina.txt_4c_Tabds.Value)
        THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do BO para o Form apos carregar registro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Dopes.Value  = THIS.this_oBusinessObject.this_cDopes
        loc_oPagina.txt_4c_Tabds.Value  = THIS.this_oBusinessObject.this_cTabds
        loc_oPagina.txt_4c_Descrs.Value = THIS.this_oBusinessObject.this_cDescrs

        *-- Evita reabertura do lookup no LostFocus se o usuario apenas navegar
        *-- pelos campos sem alterar o valor ja carregado
        THIS.this_cUltimoTabdsValidado = ALLTRIM(THIS.this_oBusinessObject.this_cTabds)
    ENDPROC

    *--------------------------------------------------------------------------
    * TabdsLookupKeyPress - Abre lookup de Tabela de Desconto ao pressionar F4
    * (PUBLIC - metodos chamados via BINDEVENT NAO podem ser PROTECTED)
    *--------------------------------------------------------------------------
    PROCEDURE TabdsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupTabelaDesconto()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TabdsLookupDblClick - Abre lookup de Tabela de Desconto no duplo clique
    *--------------------------------------------------------------------------
    PROCEDURE TabdsLookupDblClick()
        THIS.AbrirLookupTabelaDesconto()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTabds - Equivalente ao PROCEDURE Valid do GradeSubN.Column1.Text1
    * legado: ao sair do campo, tenta localizar o codigo exato em SigOpTdz;
    * se nao encontrar, abre a grade de selecao (fwBuscaExt). Guarda o ultimo
    * valor validado para nao reabrir o lookup repetidamente (Problema 45).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTabds()
        LOCAL loc_oPagina, loc_cTabds
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cTabds  = ALLTRIM(loc_oPagina.txt_4c_Tabds.Value)

        IF EMPTY(loc_cTabds)
            loc_oPagina.txt_4c_Descrs.Value = ""
            THIS.this_cUltimoTabdsValidado  = ""
            RETURN
        ENDIF

        IF loc_cTabds == THIS.this_cUltimoTabdsValidado
            RETURN
        ENDIF
        THIS.this_cUltimoTabdsValidado = loc_cTabds

        THIS.BuscarTabelaDesconto(loc_cTabds, .T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupTabelaDesconto - Abre a busca de Tabela de Desconto via F4/DblClick
    * (sempre mostra a grade de selecao, independente de match exato)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupTabelaDesconto()
        IF !THIS.pgf_4c_Paginas.Page2.txt_4c_Tabds.Enabled
            RETURN
        ENDIF

        THIS.BuscarTabelaDesconto(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Tabds.Value), .F.)
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTabelaDesconto - Implementacao COMPLETA do lookup em SigOpTdz
    * (tabela de tabelas de desconto), espelhando fwBuscaExt do legado:
    *   CreateObject('fwBuscaExt', pnIdconn, 'SigOpTdz', 'CrListaRemota',
    *                 'Codigos', This.Value, 'Tabelas de Desconto', .t., 'Codigos')
    *
    * par_cValorDigitado : valor atual do campo txt_4c_Tabds
    * par_lBuscaExata     : .T. quando chamado pelo LostFocus/Valid (so mostra a
    *                       grade se NAO achar exato); .F. quando chamado por
    *                       F4/DblClick (sempre mostra a grade para selecao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarTabelaDesconto(par_cValorDigitado, par_lBuscaExata)
        LOCAL loc_oPagina, loc_oBusca, loc_cCodigo, loc_cDescricao
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo    = ""
        loc_cDescricao = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigOpTdz", "cursor_4c_BuscaTabds", "Codigos", ;
                par_cValorDigitado, "Tabelas de Desconto")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lAchouRegistro AND par_lBuscaExata
                    *-- Encontrou codigo exato (equivalente a "Not xBrox.plAchouRegistro"
                    *-- ser falso no legado) - usa direto, sem exibir grade
                    IF USED("cursor_4c_BuscaTabds")
                        loc_cCodigo    = ALLTRIM(cursor_4c_BuscaTabds.Codigos)
                        loc_cDescricao = ALLTRIM(cursor_4c_BuscaTabds.Descrs)
                    ENDIF
                ELSE
                    *-- Nao achou exato OU chamada via F4/DblClick - mostra grade
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTabds")
                        loc_cCodigo    = ALLTRIM(cursor_4c_BuscaTabds.Codigos)
                        loc_cDescricao = ALLTRIM(cursor_4c_BuscaTabds.Descrs)
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar tabela de desconto:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaTabds")
            USE IN cursor_4c_BuscaTabds
        ENDIF

        IF !EMPTY(loc_cCodigo)
            loc_oPagina.txt_4c_Tabds.Value  = loc_cCodigo
            loc_oPagina.txt_4c_Descrs.Value = loc_cDescricao
            THIS.this_oBusinessObject.this_cTabds  = loc_cCodigo
            THIS.this_oBusinessObject.this_cDescrs = loc_cDescricao
            THIS.this_cUltimoTabdsValidado = loc_cCodigo
        ELSE
            *-- Usuario cancelou a selecao ou nao ha registro correspondente
            loc_oPagina.txt_4c_Descrs.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara form para inclusao de novo vinculo
    * Operacao x Tabela de Desconto (equivalente ao cmdInserir do legado, que
    * fazia "Insert Into LocalTabdO (Dopes, CidChaves) Values (crSigCdOpe.Dopes,
    * fUniqueIds())" e focava a celula da grade). Aqui a Operacao (dopes) e
    * digitada pelo usuario (nao ha mais form pai informando-a via parametro).
    * (PUBLIC - chamado via BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Dopes.SetFocus()
            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro ao incluir vinculo:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Abre o vinculo selecionado na grade em modo
    * somente-leitura (a chave real e cidchaves, oculta na grade - equivale ao
    * GUID gerado por fUniqueIds() no legado, sem significado para o usuario).
    * (PUBLIC - chamado via BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCidChaves, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao visualizar v" + CHR(237) + "nculo:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Abre o vinculo selecionado na grade para edicao da
    * Tabela de Desconto (equivalente a editar a celula GradeSubN.Column1 do
    * legado). Operacao (dopes) permanece fixa - so pode ser definida na
    * inclusao (nao faz sentido "mover" um vinculo ja existente de operacao).
    * (PUBLIC - chamado via BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCidChaves, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Tabds.SetFocus()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alterar v" + CHR(237) + "nculo:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui o vinculo selecionado apos confirmacao
    * (equivalente ao cmdExcluir do legado: "Delete" na LocalTabdO + Skip).
    * MsgConfirma() retorna LOGICAL (.T./.F.) - CLAUDE.md regra #7.
    * (PUBLIC - chamado via BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCidChaves, loc_cDopes, loc_cTabds, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
        loc_cDopes     = ALLTRIM(cursor_4c_Dados.dopes)
        loc_cTabds     = ALLTRIM(cursor_4c_Dados.tabds)

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
            RETURN .F.
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do v" + CHR(237) + "nculo " + ;
                loc_cDopes + " / " + loc_cTabds + "?", "Excluir")
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("V" + CHR(237) + "nculo exclu" + CHR(237) + "do com sucesso!")
                THIS.CarregarLista()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir v" + CHR(237) + "nculo:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Filtra a lista de vinculos por Operacao. O legado nao
    * exibia essa lista de forma independente (SIGCDTBV era aberto pelo form
    * pai ja com a Operacao/crSigCdOpe.Dopes definida via Init(poForm,...));
    * no novo sistema o form e autonomo, entao o botao canonico "Buscar"
    * assume o papel de filtrar a grade por Operacao via lookup em SigCdOpe.
    * (PUBLIC - chamado via BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cDopes, loc_lResultado
        loc_lResultado = .F.
        loc_cDopes = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpe", "cursor_4c_BuscaOpe", "dopes", "", ;
                "Filtrar por Opera" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                    loc_cDopes = ALLTRIM(cursor_4c_BuscaOpe.dopes)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao filtrar por opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF

        IF !EMPTY(loc_cDopes)
            THIS.this_cFiltroDopesAtual = loc_cDopes
            THIS.CarregarLista()
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (equivalente ao cmdSair.Click do
    * legado, sem a logica de gravacao em lote da LocalTabdO -> CrSigOpTdo,
    * pois aqui cada vinculo ja e gravado individualmente em BtnSalvarClick)
    * (PUBLIC - chamado via BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirma inclusao/alteracao do vinculo Operacao x
    * Tabela de Desconto. Validacoes OBRIGATORIAMENTE fora do TRY (RETURN
    * dentro de TRY/CATCH e proibido). Reproduz a validacao de duplicidade de
    * Tabds por Dopes do cmdSair.Click legado (aqui aplicada por registro, no
    * momento do Salvar, via TbOBO.ExisteVinculoDuplicado).
    * (PUBLIC - chamado via BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cDopes, loc_cTabds, loc_cCidChavesAtual, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_cDopes = ALLTRIM(loc_oPg2.txt_4c_Dopes.Value)
        loc_cTabds = ALLTRIM(loc_oPg2.txt_4c_Tabds.Value)

        IF EMPTY(loc_cDopes)
            MsgAviso("Informe a Opera" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Dopes.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(loc_cTabds)
            MsgAviso("Informe a Tabela de Desconto.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Tabds.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descrs.Value))
            MsgAviso("Tabela de Desconto " + loc_cTabds + " n" + CHR(227) + "o encontrada.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Tabds.SetFocus()
            RETURN .F.
        ENDIF

        loc_cCidChavesAtual = IIF(THIS.this_cModoAtual = "ALTERAR", THIS.this_oBusinessObject.this_cCidChaves, "")

        IF THIS.this_oBusinessObject.ExisteVinculoDuplicado(loc_cDopes, loc_cTabds, loc_cCidChavesAtual)
            MsgAviso("Tabela de Desconto " + loc_cTabds + " j" + CHR(225) + " vinculada " + ;
                CHR(224) + " Opera" + CHR(231) + CHR(227) + "o " + loc_cDopes + ".", "Duplicidade")
            loc_oPg2.txt_4c_Tabds.SetFocus()
            RETURN .F.
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("V" + CHR(237) + "nculo salvo com sucesso!")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ELSE
                MostrarErro(THIS.this_oBusinessObject.ObterMensagemErro(), "Erro ao Salvar")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar v" + CHR(237) + "nculo:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela inclusao/alteracao e retorna para a lista
    * (PUBLIC - chamado via BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_oBusinessObject.CancelarEdicao()
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loException
            MostrarErro("Erro ao cancelar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Dopes.Value  = ""
            loc_oPg2.txt_4c_Tabds.Value  = ""
            loc_oPg2.txt_4c_Descrs.Value = ""

            THIS.this_cUltimoTabdsValidado = ""
        CATCH TO loException
            MostrarErro("Erro ao limpar campos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos da Page2 conforme o modo
    * Dopes (Operacao): editavel SOMENTE em INCLUIR (nao faz sentido reatribuir
    * a operacao de um vinculo ja gravado). Tabds (Tabela de Desconto): editavel
    * em INCLUIR e ALTERAR. Descrs: sempre somente-leitura (derivado do JOIN).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lDopesHabilitar
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_lDopesHabilitar = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")

            loc_oPg2.txt_4c_Dopes.ReadOnly = !loc_lDopesHabilitar
            loc_oPg2.txt_4c_Dopes.BackColor = IIF(loc_lDopesHabilitar, RGB(255, 255, 255), RGB(212, 208, 200))

            loc_oPg2.txt_4c_Tabds.ReadOnly = !par_lHabilitar
            loc_oPg2.txt_4c_Tabds.BackColor = IIF(par_lHabilitar, RGB(255, 255, 255), RGB(212, 208, 200))

            *-- Descrs permanece sempre somente-leitura (derivado do JOIN)
            loc_oPg2.txt_4c_Descrs.ReadOnly  = .T.
            loc_oPg2.txt_4c_Descrs.BackColor = RGB(212, 208, 200)
        CATCH TO loException
            MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme o modo
    * (PUBLIC - segue mesmo padrao dos demais Btn*Click chamados via BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao
        loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        TRY
            loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loException
            MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * (necessario pois AddObject() cria controles com Visible=.F. por padrao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Trata PageFrame - itera Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Trata containers com ControlCount
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos (cursores e Business Object)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
        CATCH TO loException
            *-- Ignorar erros na destruicao
        ENDTRY

        IF !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\TbOBO.prg):
*============================================================================
* TbOBO.prg - Business Object: Tabelas de Desconto por Operacao
* Migrado de: SIGCDTBV.SCX (SigCdTbO)
* Tabela principal   : SigOpTdo   (chave: cidchaves)
* Tabela relacionada : SigOpTdz   (tabelas de desconto - lookup/join, chave: codigos)
* Tabela pai         : SigCdOpe   (operacao, chave: dopes) - informada pelo form chamador
*============================================================================
DEFINE CLASS TbOBO AS BusinessBase

    *-- Propriedades: SigOpTdo
    this_cCidChaves = ""   && cidchaves   C(20) - Chave Primaria
    this_cDopes     = ""   && dopes       C(20) - FK SigCdOpe.Dopes (operacao pai)
    this_cTabds     = ""   && tabds       C(10) - FK SigOpTdz.Codigos (tabela de desconto)

    *-- Propriedade auxiliar: SigOpTdz (somente exibicao via JOIN, nao persistida em SigOpTdo)
    this_cDescrs    = ""   && descrs      C(30) - Descricao da tabela de desconto (JOIN SigOpTdz)

    *-- Nome do cursor local de detalhe (grid editavel de tabelas de desconto da operacao)
    this_cCursorDetalhe = "cursor_4c_TbODetalhe"

    *-- Flags de controle de alteracao (equivalentes a lHouveIns/lHouveExcl do legado)
    this_lHouveInsercao = .F.
    this_lHouveExclusao = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpTdo"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Reseta propriedades para um novo registro (chamado por
    * BusinessBase.NovoRegistro()). CRITICO: sem isso, this_cCidChaves de um
    * registro anteriormente carregado (Visualizar/Alterar/Excluir) permanece
    * preenchido e Inserir() reaproveitaria essa PK antiga em vez de gerar uma
    * nova via fUniqueIds().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves = ""
        THIS.this_cDopes     = ""
        THIS.this_cTabds     = ""
        THIS.this_cDescrs    = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT das tabelas de desconto vinculadas a operacao (JOIN SigOpTdz)
    * par_cDopes: codigo da operacao (SigCdOpe.Dopes). Se vazio, retorna TODOS os
    *             vinculos de todas as operacoes (equivalente a listagem geral).
    * Espelha exatamente a query original:
    *   Select a.*,b.Descrs From SigOpTdo a, SigOpTdz b
    *     Where a.Dopes = '<dopes>' And a.Tabds = b.Codigos
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cDopes)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.dopes, a.tabds, b.descrs" + ;
                       " FROM SigOpTdo a" + ;
                       " INNER JOIN SigOpTdz b ON a.tabds = b.codigos"

            IF VARTYPE(par_cDopes) = "C" AND !EMPTY(par_cDopes)
                loc_cSQL = loc_cSQL + ;
                    " WHERE a.dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.tabds"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - SELECT registro por chave primaria (cidchaves) + JOIN descrs
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.dopes, a.tabds, b.descrs" + ;
                       " FROM SigOpTdo a" + ;
                       " INNER JOIN SigOpTdz b ON a.tabds = b.codigos" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = ALLTRIM(TratarNulo(cidchaves, "C"))
                THIS.this_cDopes     = ALLTRIM(TratarNulo(dopes, "C"))
                THIS.this_cTabds     = ALLTRIM(TratarNulo(tabds, "C"))
                *-- descrs so existe quando o SELECT fez JOIN com SigOpTdz (Buscar/CarregarPorCodigo)
                IF TYPE("descrs") = "C"
                    THIS.this_cDescrs = ALLTRIM(TratarNulo(descrs, "C"))
                ELSE
                    THIS.this_cDescrs = ""
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigOpTdo (todas colunas NOT NULL preenchidas)
    * Gera cidchaves automaticamente (equivalente a fUniqueIds() do legado) se
    * ainda nao tiver sido atribuido.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpTdo" + ;
                       " (cidchaves, dopes, tabds)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       EscaparSQL(THIS.this_cTabds) + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                THIS.this_lHouveInsercao = .T.
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigOpTdo (dopes/tabds) WHERE cidchaves = chave
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpTdo SET" + ;
                       " dopes = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                       " tabds = " + EscaparSQL(THIS.this_cTabds) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigOpTdo WHERE cidchaves = chave
    * (Chamado PUBLICAMENTE via THIS.Excluir(), nunca direto - CLAUDE.md regra BO)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpTdo WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Del")
                TABLEREVERT(.T., "cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                THIS.this_lHouveExclusao = .T.
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteVinculoDuplicado - Verifica se a Tabela de Desconto ja esta
    * vinculada a esta Operacao em OUTRO registro. Equivale a validacao de
    * duplicidade de Tabds por Dopes do cmdSair.Click do legado (que escaneava
    * toda a LocalTabdO em memoria antes de gravar em lote); aqui e aplicada no
    * momento do Salvar de cada vinculo individual (par_cCidChavesAtual exclui
    * o proprio registro em edicao, para nao se autoacusar de duplicidade).
    *--------------------------------------------------------------------------
    FUNCTION ExisteVinculoDuplicado(par_cDopes, par_cTabds, par_cCidChavesAtual)
        LOCAL loc_lExiste, loc_cSQL, loc_nResultado
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigOpTdo" + ;
                       " WHERE dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
                       " AND tabds = " + EscaparSQL(ALLTRIM(par_cTabds))

            IF VARTYPE(par_cCidChavesAtual) = "C" AND !EMPTY(par_cCidChavesAtual)
                loc_cSQL = loc_cSQL + " AND cidchaves <> " + EscaparSQL(ALLTRIM(par_cCidChavesAtual))
            ENDIF

            IF USED("cursor_4c_DupVinc")
                USE IN cursor_4c_DupVinc
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupVinc")
            IF loc_nResultado >= 0
                loc_lExiste = (RECCOUNT("cursor_4c_DupVinc") > 0)
            ELSE
                MsgErro("Erro ao verificar duplicidade do v" + CHR(237) + "nculo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DupVinc")
                USE IN cursor_4c_DupVinc
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.ExisteVinculoDuplicado:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarTabelaDescontoDuplicada - Verifica se ha Tabds repetido para a mesma
    * operacao (equivalente ao "Select Tabds,sum(1) as TT ... GROUP by 1 ... TT>1"
    * do cmdSair.Click do legado)
    *--------------------------------------------------------------------------
    FUNCTION ValidarTabelaDescontoDuplicada(par_cDopes)
        LOCAL loc_lDuplicado, loc_cSQL, loc_nResultado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT tabds, COUNT(*) AS Total FROM SigOpTdo" + ;
                       " WHERE dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
                       " GROUP BY tabds HAVING COUNT(*) > 1"

            IF USED("cursor_4c_DupChk")
                TABLEREVERT(.T., "cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChk")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_DupChk") > 0
                    loc_lDuplicado = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao verificar duplicidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TbOBO.ValidarTabelaDescontoDuplicada:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDFUNC

ENDDEFINE

