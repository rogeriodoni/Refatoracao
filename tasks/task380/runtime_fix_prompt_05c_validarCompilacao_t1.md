# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05c_validarCompilacao
- Tentativa: 1/10
- Mensagem: C:\4c\projeto\app\classes\COMBO.prg: SCAN NOT DELETED() | Error in line 303: Command contains unrecognized phrase/keyword. | SCAN NOT DELETED() | Error in line 331: Command contains unrecognized phrase/keyword. | SCAN NOT DELETED() | Error in line 362: Command contains unrecognized phrase/keyword. | 

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCOM.prg):
*==============================================================================
* FormCOM.prg - Cadastro de Comissoes
* Migrado de: SIGCDCOM.SCX (Framework Fortyus)
* Tabelas: SigCmCab (cabecalho) + SigCmItn (itens PRO/VEN/MET)
* Arquitetura: FormBase (UI) -> COMBO (BO) -> DataAccess (SQL Server)
* Fase 3/8: Estrutura base do Form (PageFrame + Containers)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS FormCOM AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - UX Fidelity)
    * Caption sem acento aqui; InicializarForm usa CHR(245) para "Comissoes"
    *--------------------------------------------------------------------------
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Comissoes"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *--------------------------------------------------------------------------
    * Propriedades de controle
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cUltimaEmpresa  = ""
    this_cUltimaMoeda    = ""
    this_nColPrevProd    = 0
    this_nColPrevVend    = 0
    this_nColPrevMeta    = 0

    *==========================================================================
    * Init - Inicializa o formulario (FormBase.Init chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente por FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
                MostrarErro("Sem conex" + CHR(227) + "o com o banco de dados.", "FormCOM.InicializarForm")
            ELSE
                THIS.this_oBusinessObject = CREATEOBJECT("COMBO")

                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    MostrarErro("Erro ao criar COMBO.", "FormCOM.InicializarForm")
                ELSE
                    *-- Carregar grupos padrao de vendedores/responsaveis (fConfigGeral)
                    IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                        THIS.this_oBusinessObject.CarregarConfigGeral()
                    ENDIF

                    *-- Configurar estrutura visual
                    THIS.ConfigurarPageFrame()

                    *-- Atualizar Caption com acento (CHR(245) = o-tilde)
                    THIS.Caption = "Cadastro de Comiss" + CHR(245) + "es"
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                    *-- Inicializar cursores de itens vazios
                    THIS.this_oBusinessObject.InicializarCursores()

                    THIS.pgf_4c_Paginas.ActivePage = 1
                    THIS.this_cModoAtual = "LISTA"

                    IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                        THIS.CarregarLista()
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar FormCOM:" + CHR(13) + loc_oErro.Message, "FormCOM.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria o PageFrame principal com 2 paginas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")

            THIS.pgf_4c_Paginas.Top       = -29
            THIS.pgf_4c_Paginas.Left      = 0
            THIS.pgf_4c_Paginas.Width     = 1000
            THIS.pgf_4c_Paginas.Height    = 629
            THIS.pgf_4c_Paginas.PageCount = 2
            THIS.pgf_4c_Paginas.Tabs      = .F.
            THIS.pgf_4c_Paginas.Visible   = .T.

            WITH THIS.pgf_4c_Paginas
                .Page1.Caption = "Lista"
                .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.Caption = "Dados"
                .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            ENDWITH

            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar PageFrame:" + CHR(13) + loc_oErro.Message, "FormCOM.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 com cabecalho, botoes CRUD e grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Cabecalho cinza com titulo
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 30
                .Left        = 0
                .Width       = 1000
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Caption   = "Cadastro de Comissoes"
                    .Top       = 15
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 40
                    .AutoSize  = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Caption   = "Cadastro de Comissoes"
                    .Top       = 18
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 46
                    .AutoSize  = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(255, 255, 255)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *-- Container botoes CRUD (Grupo_Op.Left=543,Top=-1,Width=385 ? compensado)
            loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPagina.cnt_4c_Botoes
                .Top         = 28
                .Left        = 542
                .Width       = 390
                .Height      = 85
                .BackStyle   = 1
                .BackColor   = RGB(53, 53, 53)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Incluir", "CommandButton")
                WITH .cmd_4c_Incluir
                    .Caption         = "Incluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Visualizar", "CommandButton")
                WITH .cmd_4c_Visualizar
                    .Caption         = "Visualizar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Alterar", "CommandButton")
                WITH .cmd_4c_Alterar
                    .Caption         = "Alterar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Excluir", "CommandButton")
                WITH .cmd_4c_Excluir
                    .Caption         = "Excluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Buscar", "CommandButton")
                WITH .cmd_4c_Buscar
                    .Caption         = "Buscar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

            *-- Container saida canonico (CLAUDE.md regra #10)
            loc_oPagina.AddObject("cnt_4c_Saida", "Container")
            WITH loc_oPagina.cnt_4c_Saida
                .Top         = 29
                .Left        = 917
                .Width       = 90
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Encerrar", "CommandButton")
                WITH .cmd_4c_Encerrar
                    .Caption         = "Encerrar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            = 917
                    .Width           = 90
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            *-- Botao Copiar da lista (original btnCopiar.Top=4, Left=467 + compensacao +29)
            loc_oPagina.AddObject("cmd_4c_Copiar", "CommandButton")
            WITH loc_oPagina.cmd_4c_Copiar
                .Caption         = "Copiar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 33
                .Left            = 467
                .Width           = 75
                .Height          = 75
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.cmd_4c_Copiar, "Click", THIS, "BtnCopiarClick")

            *-- Grid de lista de comissoes (SigCmCab)
            *-- RecordSource e ColumnCount ANTES do WITH para garantir criacao das colunas
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            loc_oGrid               = loc_oPagina.grd_4c_Lista
            loc_oGrid.RecordSource  = ""
            loc_oGrid.ColumnCount   = 5

            WITH loc_oGrid
                .Top                = 117
                .Left               = 0
                .Width              = 916
                .Height             = 510
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
                .RowHeight          = 16
                .ScrollBars         = 2
                .GridLines          = 3
                .Visible            = .T.
            ENDWITH

            WITH loc_oGrid.Column1
                .Width           = 290
                .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH
            WITH loc_oGrid.Column2
                .Width           = 40
                .Header1.Caption = "Emp"
            ENDWITH
            WITH loc_oGrid.Column3
                .Width           = 80
                .Header1.Caption = "In" + CHR(237) + "cio"
            ENDWITH
            WITH loc_oGrid.Column4
                .Width           = 80
                .Header1.Caption = "Fim"
            ENDWITH
            WITH loc_oGrid.Column5
                .Width           = 120
                .Header1.Caption = "Meta Empresa"
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar Page1:" + CHR(13) + loc_oErro.Message, "FormCOM.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2 (campos + 3 grades de itens)
    * Fase 5: Botoes acao + campos de cabecalho + secao Comissao Dividida
    * Fase 6: Grades de Vendedores, Produtos e Metas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oGridV, loc_oGridP, loc_oGridM
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *------------------------------------------------------------------
            * Container botoes de acao Confirmar/Cancelar
            * Legado: Grupo_Salva.Left=842, Top=4+29=33, Width=160, Height=85
            *------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .Top         = 33
                .Left        = 842
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Confirmar", "CommandButton")
                WITH .cmd_4c_Confirmar
                    .Caption         = "Confirmar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            = 5
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Cancelar", "CommandButton")
                WITH .cmd_4c_Cancelar
                    .Caption         = "Encerrar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            = 80
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Comic Sans MS"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

            *------------------------------------------------------------------
            * Linha 1: Descricao (Say7 + getCods)
            * Say7: top=16+29=45, left=72 | getCods: top=12+29=41, left=140, w=323
            *------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPagina.lbl_4c_Label7
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                .Top       = 45
                .Left      = 72
                .Width     = 66
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
            WITH loc_oPagina.txt_4c_Descricao
                .Value     = ""
                .Top       = 41
                .Left      = 140
                .Width     = 323
                .Height    = 23
                .MaxLength = 40
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Linha 2: Empresa (lbl_empresa + getEmpresa + getDEmpresa)
            * lbl_empresa: top=42+29=71, left=78, w=61
            * getEmpresa:  top=38+29=67, left=140, w=31
            * getDEmpresa: top=38+29=67, left=173, w=290
            *------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
            WITH loc_oPagina.lbl_4c_Empresa
                .Caption   = "Empresa :"
                .Top       = 71
                .Left      = 78
                .Width     = 61
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
            WITH loc_oPagina.txt_4c_Empresa
                .Value     = ""
                .Top       = 67
                .Left      = 140
                .Width     = 31
                .Height    = 23
                .MaxLength = 3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_DEmpresa", "TextBox")
            WITH loc_oPagina.txt_4c_DEmpresa
                .Value     = ""
                .Top       = 67
                .Left      = 173
                .Width     = 290
                .Height    = 23
                .ReadOnly  = .T.
                .BackColor = RGB(230, 230, 230)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "ValidarEmpresa")

            *------------------------------------------------------------------
            * Linha 3: Periodo (Say2 + getDtInicial + Say3 + getDtFinal)
            * Say2: top=68+29=97, left=85, w=54
            * getDtInicial: top=64+29=93, left=140, w=80
            * Say3 (ate): top=68+29=97, left=222, w=20
            * getDtFinal: top=64+29=93, left=251, w=80
            *------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPagina.lbl_4c_Label2
                .Caption   = "Per" + CHR(237) + "odo :"
                .Top       = 97
                .Left      = 85
                .Width     = 54
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_DtInicio", "TextBox")
            WITH loc_oPagina.txt_4c_DtInicio
                .Value     = {}
                .Top       = 93
                .Left      = 140
                .Width     = 80
                .Height    = 23
                .InputMask = "99/99/9999"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPagina.lbl_4c_Label3
                .Caption   = "at" + CHR(233)
                .Top       = 97
                .Left      = 222
                .Width     = 20
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_DtFim", "TextBox")
            WITH loc_oPagina.txt_4c_DtFim
                .Value     = {}
                .Top       = 93
                .Left      = 251
                .Width     = 80
                .Height    = 23
                .InputMask = "99/99/9999"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Linha 4: Meta Empresa (Say10 + getMetaEmps)
            * Say10: top=94+29=123, left=47, w=92
            * getMetaEmps: top=90+29=119, left=140, w=108
            *------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label10", "Label")
            WITH loc_oPagina.lbl_4c_Label10
                .Caption   = "Meta Empresa :"
                .Top       = 123
                .Left      = 47
                .Width     = 92
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_MetaEmps", "TextBox")
            WITH loc_oPagina.txt_4c_MetaEmps
                .Value     = 0
                .Top       = 119
                .Left      = 140
                .Width     = 108
                .Height    = 23
                .Format    = "NZ"
                .InputMask = "999,999.99"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.txt_4c_MetaEmps, "LostFocus", THIS, "MetaEmpsChanged")

            *------------------------------------------------------------------
            * Linha 4 (cont.): Moeda (lbl_moeda + getmoeda + getdmoeda)
            * lbl_moeda: top=93+29=122, left=266, w=52, h=15
            * getmoeda: top=89+29=118, left=316, w=31
            * getdmoeda: top=89+29=118, left=348, w=115
            *------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
            WITH loc_oPagina.lbl_4c_Moeda
                .Caption   = "Moeda : "
                .Top       = 122
                .Left      = 266
                .Width     = 52
                .Height    = 15
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
            WITH loc_oPagina.txt_4c_Moeda
                .Value     = ""
                .Top       = 118
                .Left      = 316
                .Width     = 31
                .Height    = 23
                .MaxLength = 3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_DMoeda", "TextBox")
            WITH loc_oPagina.txt_4c_DMoeda
                .Value     = ""
                .Top       = 118
                .Left      = 348
                .Width     = 115
                .Height    = 23
                .ReadOnly  = .T.
                .BackColor = RGB(230, 230, 230)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoeda")

            *------------------------------------------------------------------
            * Bloco visual "Comissao Dividida" (Shape3 + Say1)
            * Shape3: top=12+29=41, left=475, w=170, h=98
            * Say1: top=20+29=49, left=498
            *------------------------------------------------------------------
            loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
            WITH loc_oPagina.shp_4c_Shape3
                .Top     = 41
                .Left    = 475
                .Width   = 170
                .Height  = 98
                .Visible = .T.
            ENDWITH

            loc_oPagina.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPagina.lbl_4c_Label1
                .Caption   = "Comiss" + CHR(227) + "o Dividida "
                .Top       = 49
                .Left      = 498
                .Width     = 130
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Vendedor 1: Say4 + getPctVd1 + Say5 (%)
            * Say4: top=47+29=76, left=485, w=77
            * getPctVd1: top=43+29=72, left=564, w=52
            * Say5: top=47+29=76, left=619, w=14
            *------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPagina.lbl_4c_Label4
                .Caption   = "Vendedor 1 :"
                .Top       = 76
                .Left      = 485
                .Width     = 77
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_PctVd1", "TextBox")
            WITH loc_oPagina.txt_4c_PctVd1
                .Value     = 100
                .Top       = 72
                .Left      = 564
                .Width     = 52
                .Height    = 23
                .Format    = "NZ"
                .InputMask = "999.99"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPagina.lbl_4c_Label5
                .Caption   = "%"
                .Top       = 76
                .Left      = 619
                .Width     = 14
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.txt_4c_PctVd1, "LostFocus", THIS, "PctVd1Changed")

            *------------------------------------------------------------------
            * Vendedor 2: Say6 + getPctVd2 + Say8 (%)
            * Say6: top=73+29=102, left=485, w=77
            * getPctVd2: top=69+29=98, left=564, w=52
            * Say8: top=73+29=102, left=619, w=14
            *------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPagina.lbl_4c_Label6
                .Caption   = "Vendedor 2 :"
                .Top       = 102
                .Left      = 485
                .Width     = 77
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_PctVd2", "TextBox")
            WITH loc_oPagina.txt_4c_PctVd2
                .Value     = 0
                .Top       = 98
                .Left      = 564
                .Width     = 52
                .Height    = 23
                .Format    = "NZ"
                .InputMask = "999.99"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("lbl_4c_Label8", "Label")
            WITH loc_oPagina.lbl_4c_Label8
                .Caption   = "%"
                .Top       = 102
                .Left      = 619
                .Width     = 14
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.txt_4c_PctVd2, "LostFocus", THIS, "PctVd2Changed")

            *------------------------------------------------------------------
            * Separador horizontal (Shape1: top=120+29=149, left=18, w=793, h=0)
            *------------------------------------------------------------------
            loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oPagina.shp_4c_Shape1
                .Top           = 149
                .Left          = 18
                .Width         = 793
                .Height        = 0
                .BackStyle     = 0
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            *------------------------------------------------------------------
            * Secao Vendedores
            * Say11: top=125+29=154, left=7
            * grdVendedoras: top=142+29=171, left=7, w=624, h=224
            * btnExcV: top=326+29=355, left=633
            *------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label11", "Label")
            WITH loc_oPagina.lbl_4c_Label11
                .Caption   = "Vendedores"
                .Top       = 154
                .Left      = 7
                .Width     = 100
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Verdana"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("grd_4c_Vendedores", "Grid")
            loc_oGridV              = loc_oPagina.grd_4c_Vendedores
            loc_oGridV.RecordSource = ""
            loc_oGridV.ColumnCount  = 6

            WITH loc_oGridV
                .Top               = 171
                .Left              = 7
                .Width             = 624
                .Height            = 224
                .HeaderHeight      = 17
                .RowHeight         = 17
                .FontName          = "Arial"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .ScrollBars        = 2
                .Visible           = .T.
            ENDWITH

            WITH loc_oGridV.Column1
                .ControlSource   = "crGrdItV.CodVens"
                .Width           = 80
                .Header1.Caption = "Vendedor"
            ENDWITH
            WITH loc_oGridV.Column2
                .ControlSource   = "crGrdItV.VMetas"
                .Width           = 115
                .Header1.Caption = "Meta no Per" + CHR(237) + "odo"
            ENDWITH
            WITH loc_oGridV.Column3
                .ControlSource   = "crGrdItV.SalBases"
                .Width           = 115
                .Header1.Caption = "Sal" + CHR(225) + "rio Base"
            ENDWITH
            WITH loc_oGridV.Column4
                .ControlSource   = "crGrdItV.CodResps"
                .Width           = 80
                .Header1.Caption = "Respons" + CHR(225) + "vel"
            ENDWITH
            WITH loc_oGridV.Column5
                .ControlSource   = "crGrdItV.RPctFixs"
                .Width           = 82
                .Header1.Caption = "% Respons" + CHR(225) + "vel"
            ENDWITH
            WITH loc_oGridV.Column6
                .ControlSource   = "crGrdItV.VMetItns"
                .Width           = 115
                .Header1.Caption = "Meta por itens"
            ENDWITH

            loc_oGridV.RecordSource = "crGrdItV"

            *-- Re-atribuir Column6 apos RecordSource (auto-bind usa campo 6=fkChaves, nao VMetItns)
            loc_oGridV.Column6.ControlSource   = "crGrdItV.VMetItns"
            loc_oGridV.Column6.Header1.Caption = "Meta por itens"
            BINDEVENT(loc_oGridV, "AfterRowColChange", THIS, "GrdVendedoresAfterRowColChange")

            loc_oPagina.AddObject("cmd_4c_BtnExcV", "CommandButton")
            WITH loc_oPagina.cmd_4c_BtnExcV
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Top             = 355
                .Left            = 633
                .Width           = 26
                .Height          = 26
                .ToolTipText     = "Excluir Linha da Grade"
                .Themes          = .T.
                .Visible         = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.cmd_4c_BtnExcV, "Click", THIS, "GrdVendExcluirClick")

            *------------------------------------------------------------------
            * Secao Produtos
            * Say9: top=125+29=154, left=679
            * grdProdutos: top=142+29=171, left=679, w=260, h=445
            * btnExcP: top=547+29=576, left=940
            *------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oPagina.lbl_4c_Label9
                .Caption   = "Produtos"
                .Top       = 154
                .Left      = 679
                .Width     = 80
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Verdana"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("grd_4c_Produtos", "Grid")
            loc_oGridP              = loc_oPagina.grd_4c_Produtos
            loc_oGridP.RecordSource = ""
            loc_oGridP.ColumnCount  = 4

            WITH loc_oGridP
                .Top               = 171
                .Left              = 679
                .Width             = 260
                .Height            = 445
                .HeaderHeight      = 17
                .RowHeight         = 17
                .FontName          = "Arial"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .ScrollBars        = 2
                .Visible           = .T.
            ENDWITH

            WITH loc_oGridP.Column1
                .ControlSource   = "crGrdItP.Mercs"
                .Width           = 45
                .Header1.Caption = "G.Grupo"
            ENDWITH
            WITH loc_oGridP.Column2
                .ControlSource   = "crGrdItP.CGrus"
                .Width           = 45
                .Header1.Caption = "Grupo"
            ENDWITH
            WITH loc_oGridP.Column3
                .ControlSource   = "crGrdItP.SGrus"
                .Width           = 55
                .Header1.Caption = "Subgrupo"
            ENDWITH
            WITH loc_oGridP.Column4
                .ControlSource   = "crGrdItP.PPctFixs"
                .Width           = 80
                .Header1.Caption = "% Fixo"
            ENDWITH

            loc_oGridP.RecordSource = "crGrdItP"

            BINDEVENT(loc_oGridP, "AfterRowColChange", THIS, "GrdProdutosAfterRowColChange")

            loc_oPagina.AddObject("cmd_4c_BtnExcP", "CommandButton")
            WITH loc_oPagina.cmd_4c_BtnExcP
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Top             = 576
                .Left            = 940
                .Width           = 26
                .Height          = 26
                .ToolTipText     = "Excluir Linha da Grade"
                .Themes          = .T.
                .Visible         = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.cmd_4c_BtnExcP, "Click", THIS, "GrdProdExcluirClick")

            *------------------------------------------------------------------
            * Secao Faixas de Remuneracao (Metas)
            * Say12: top=380+29=409, left=7
            * grdMetas: top=397+29=426, left=7, w=507, h=190
            * btnExcM: top=547+29=576, left=516
            *------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Label12", "Label")
            WITH loc_oPagina.lbl_4c_Label12
                .Caption   = "Faixas de Remunera" + CHR(231) + CHR(227) + "o dos Vendedores"
                .Top       = 409
                .Left      = 7
                .Width     = 310
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Verdana"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("grd_4c_Metas", "Grid")
            loc_oGridM              = loc_oPagina.grd_4c_Metas
            loc_oGridM.RecordSource = ""
            loc_oGridM.ColumnCount  = 5

            WITH loc_oGridM
                .Top               = 426
                .Left              = 7
                .Width             = 507
                .Height            = 190
                .HeaderHeight      = 17
                .RowHeight         = 17
                .FontName          = "Arial"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .ScrollBars        = 2
                .Visible           = .T.
            ENDWITH

            WITH loc_oGridM.Column1
                .ControlSource   = "crGrdItM.CodFaixas"
                .Width           = 32
                .Header1.Caption = ""
            ENDWITH
            WITH loc_oGridM.Column2
                .ControlSource   = "crGrdItM.FxaInis"
                .Width           = 130
                .Header1.Caption = "Faixa Inicial"
            ENDWITH
            WITH loc_oGridM.Column3
                .ControlSource   = "crGrdItM.FxaFims"
                .Width           = 130
                .Header1.Caption = "Faixa Final"
            ENDWITH
            WITH loc_oGridM.Column4
                .ControlSource   = "crGrdItM.PctFaixas"
                .Width           = 90
                .Header1.Caption = "% Comiss" + CHR(227) + "o"
            ENDWITH
            WITH loc_oGridM.Column5
                .ControlSource   = "crGrdItM.Bonus"
                .Width           = 90
                .Header1.Caption = "% B" + CHR(244) + "nus x Meta"
            ENDWITH

            loc_oGridM.RecordSource = "crGrdItM"

            BINDEVENT(loc_oGridM, "AfterRowColChange", THIS, "GrdMetasAfterRowColChange")

            loc_oPagina.AddObject("cmd_4c_BtnExcM", "CommandButton")
            WITH loc_oPagina.cmd_4c_BtnExcM
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Top             = 576
                .Left            = 516
                .Width           = 26
                .Height          = 26
                .ToolTipText     = "Excluir Linha da Grade"
                .Themes          = .T.
                .Visible         = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.cmd_4c_BtnExcM, "Click", THIS, "GrdMetaExcluirClick")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar Page2:" + CHR(13) + loc_oErro.Message, "FormCOM.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Implementacao obrigatoria no form (nao esta no FormBase)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

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

                *-- Trata containers com ControlCount (recursao)
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "FormCOM.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega registros de SigCmCab no grid da Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid.ColumnCount = 5
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- Re-atribuir ControlSource apos RecordSource (auto-bind reseta)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Emps"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtInis"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtFims"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.MetaEmps"

                *-- Reconfigurar cabecalhos apos RecordSource (Problemas 6 e 32)
                loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column2.Header1.Caption = "Emp"
                loc_oGrid.Column3.Header1.Caption = "In" + CHR(237) + "cio"
                loc_oGrid.Column4.Header1.Caption = "Fim"
                loc_oGrid.Column5.Header1.Caption = "Meta Empresa"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "FormCOM.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Abre Page2 para inclusao de novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_oBusinessObject.InicializarCursores()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        CATCH TO loc_oErro
            MostrarErro("Erro ao incluir:" + CHR(13) + loc_oErro.Message, "FormCOM.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Abre Page2 para visualizacao somente leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Visualizar")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.pkchaves)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao visualizar:" + CHR(13) + loc_oErro.Message, "FormCOM.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre Page2 para edicao do registro selecionado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Alterar")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.pkchaves)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Alterar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao alterar:" + CHR(13) + loc_oErro.Message, "FormCOM.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui o registro selecionado apos confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cPkChaves, loc_lConfirma
        loc_cCodigo   = ""
        loc_cPkChaves = ""
        loc_lConfirma = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Excluir")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo   = ALLTRIM(cursor_4c_Dados.Cods)
                loc_cPkChaves = ALLTRIM(cursor_4c_Dados.pkchaves)

                loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da comiss" + CHR(227) + "o '" + loc_cCodigo + "'?", "Excluir")
                IF loc_lConfirma
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChaves)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "FormCOM.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Vai para Page2 em modo BUSCAR para pesquisa por codigo
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.this_cModoAtual = "BUSCAR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "FormCOM.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnCopiarClick - Copia o registro selecionado (original btnCopiar via SigOpCpr)
    * O formulario de copia (SigOpCpr) e acionado via modulo operacional separado;
    * enquanto nao migrado, reposiciona o cursor apos qualquer operacao externa.
    *==========================================================================
    PROCEDURE BtnCopiarClick()
        LOCAL loc_cCod
        loc_cCod = ""

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCod = ALLTRIM(cursor_4c_Dados.Cods)

                IF !EMPTY(loc_cCod)
                    THIS.LockScreen = .T.
                    THIS.CarregarLista()
                    IF USED("cursor_4c_Dados") AND !EMPTY(loc_cCod)
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(Cods) = loc_cCod
                    ENDIF
                    THIS.LockScreen = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao copiar registro:" + CHR(13) + loc_oErro.Message, "FormCOM.BtnCopiarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida e salva o registro (Confirmar)
    * Em modo BUSCAR, filtra a lista e retorna para Page1
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_oPg2, loc_oGrid, loc_cFiltro
        loc_lSucesso = .F.
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2

        *-- Modo BUSCAR: pesquisa por descricao e retorna para Page1
        IF THIS.this_cModoAtual = "BUSCAR"
            loc_cFiltro = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
            TRY
                IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 5
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Emps"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtInis"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtFims"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.MetaEmps"
                    loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column2.Header1.Caption = "Emp"
                    loc_oGrid.Column3.Header1.Caption = "In" + CHR(237) + "cio"
                    loc_oGrid.Column4.Header1.Caption = "Fim"
                    loc_oGrid.Column5.Header1.Caption = "Meta Empresa"
                    THIS.FormatarGridLista(loc_oGrid)
                    THIS.pgf_4c_Paginas.ActivePage = 1
                    THIS.this_cModoAtual = "LISTA"
                ENDIF
            CATCH TO loc_oErro
                MostrarErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "FormCOM.BtnSalvarClick")
            ENDTRY
            RETURN
        ENDIF

        *-- Validacoes para INCLUIR e ALTERAR (fora do TRY - CLAUDE.md regra #1)
        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descricao.Value))
            MsgAviso("A Descri" + CHR(231) + CHR(227) + "o Necessita Ser Preenchida!!!", "")
            loc_oPg2.txt_4c_Descricao.SetFocus
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Empresa.Value))
            MsgAviso("A Empresa Necessita Ser Preenchida!!!", "")
            loc_oPg2.txt_4c_Empresa.SetFocus
            RETURN
        ENDIF

        IF EMPTY(loc_oPg2.txt_4c_DtInicio.Value)
            MsgAviso("A Data Inicial Necessita Ser Preenchida!!!", "")
            loc_oPg2.txt_4c_DtInicio.SetFocus
            RETURN
        ENDIF

        IF EMPTY(loc_oPg2.txt_4c_DtFim.Value)
            MsgAviso("A Data Final Necessita Ser Preenchida!!!", "")
            loc_oPg2.txt_4c_DtFim.SetFocus
            RETURN
        ENDIF

        IF loc_oPg2.txt_4c_DtFim.Value < loc_oPg2.txt_4c_DtInicio.Value
            MsgAviso("A Data Final Precisa Ser Maior Que a Inicial!!!", "")
            loc_oPg2.txt_4c_DtFim.SetFocus
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!")
                THIS.AlternarPagina(1)
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "FormCOM.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.AlternarPagina(1)
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MostrarErro("Erro ao cancelar:" + CHR(13) + loc_oErro.Message, "FormCOM.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos do form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
        THIS.this_oBusinessObject.this_cEmps      = ALLTRIM(loc_oPg2.txt_4c_Empresa.Value)
        THIS.this_oBusinessObject.this_cDEmps     = ALLTRIM(loc_oPg2.txt_4c_DEmpresa.Value)
        THIS.this_oBusinessObject.this_dDtInicio  = loc_oPg2.txt_4c_DtInicio.Value
        THIS.this_oBusinessObject.this_dDtFim     = loc_oPg2.txt_4c_DtFim.Value
        THIS.this_oBusinessObject.this_nMetaEmps  = loc_oPg2.txt_4c_MetaEmps.Value
        THIS.this_oBusinessObject.this_nPctVd1    = loc_oPg2.txt_4c_PctVd1.Value
        THIS.this_oBusinessObject.this_nPctVd2    = loc_oPg2.txt_4c_PctVd2.Value
        THIS.this_oBusinessObject.this_cMoedas    = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)
        THIS.this_oBusinessObject.this_cDMoedas   = ALLTRIM(loc_oPg2.txt_4c_DMoeda.Value)
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para os campos do form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cDescricao
        loc_oPg2.txt_4c_Empresa.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
        loc_oPg2.txt_4c_DEmpresa.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cDEmps)
        loc_oPg2.txt_4c_DtInicio.Value  = THIS.this_oBusinessObject.this_dDtInicio
        loc_oPg2.txt_4c_DtFim.Value     = THIS.this_oBusinessObject.this_dDtFim
        loc_oPg2.txt_4c_MetaEmps.Value  = THIS.this_oBusinessObject.this_nMetaEmps
        loc_oPg2.txt_4c_PctVd1.Value    = THIS.this_oBusinessObject.this_nPctVd1
        loc_oPg2.txt_4c_PctVd2.Value    = THIS.this_oBusinessObject.this_nPctVd2
        loc_oPg2.txt_4c_Moeda.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cMoedas)
        loc_oPg2.txt_4c_DMoeda.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cDMoedas)

        *-- Atualizar grades apos carregar itens
        IF PEMSTATUS(loc_oPg2, "grd_4c_Vendedores", 5)
            IF USED("crGrdItV")
                loc_oPg2.grd_4c_Vendedores.RecordSource = "crGrdItV"
                loc_oPg2.grd_4c_Vendedores.Refresh()
            ENDIF
        ENDIF
        IF PEMSTATUS(loc_oPg2, "grd_4c_Produtos", 5)
            IF USED("crGrdItP")
                loc_oPg2.grd_4c_Produtos.RecordSource = "crGrdItP"
                loc_oPg2.grd_4c_Produtos.Refresh()
            ENDIF
        ENDIF
        IF PEMSTATUS(loc_oPg2, "grd_4c_Metas", 5)
            IF USED("crGrdItM")
                loc_oPg2.grd_4c_Metas.RecordSource = "crGrdItM"
                loc_oPg2.grd_4c_Metas.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2 e inicializa cursores
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Descricao.Value = ""
        loc_oPg2.txt_4c_Empresa.Value   = ""
        loc_oPg2.txt_4c_DEmpresa.Value  = ""
        loc_oPg2.txt_4c_DtInicio.Value  = {}
        loc_oPg2.txt_4c_DtFim.Value     = {}
        loc_oPg2.txt_4c_MetaEmps.Value  = 0
        loc_oPg2.txt_4c_PctVd1.Value    = 100
        loc_oPg2.txt_4c_PctVd2.Value    = 0
        loc_oPg2.txt_4c_Moeda.Value     = ""
        loc_oPg2.txt_4c_DMoeda.Value    = ""

        THIS.this_cUltimaEmpresa = ""
        THIS.this_cUltimaMoeda   = ""

        THIS.this_oBusinessObject.InicializarCursores()

        IF PEMSTATUS(loc_oPg2, "grd_4c_Vendedores", 5)
            loc_oPg2.grd_4c_Vendedores.Refresh()
        ENDIF
        IF PEMSTATUS(loc_oPg2, "grd_4c_Produtos", 5)
            loc_oPg2.grd_4c_Produtos.Refresh()
        ENDIF
        IF PEMSTATUS(loc_oPg2, "grd_4c_Metas", 5)
            loc_oPg2.grd_4c_Metas.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lHab
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_lHab = (par_lHabilitar = .T.)

        *-- getCods: editavel apenas em INCLUIR e BUSCAR (Cods eh a descricao/chave de busca)
        loc_oPg2.txt_4c_Descricao.ReadOnly = !(loc_lHab AND INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR"))
        loc_oPg2.txt_4c_Empresa.ReadOnly   = !loc_lHab
        loc_oPg2.txt_4c_DtInicio.ReadOnly  = !loc_lHab
        loc_oPg2.txt_4c_DtFim.ReadOnly     = !loc_lHab
        loc_oPg2.txt_4c_MetaEmps.ReadOnly  = !loc_lHab
        loc_oPg2.txt_4c_PctVd1.ReadOnly    = !loc_lHab
        loc_oPg2.txt_4c_PctVd2.ReadOnly    = !loc_lHab
        loc_oPg2.txt_4c_Moeda.ReadOnly     = !loc_lHab
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta disponibilidade dos botoes de acao (Page2)
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF THIS.this_cModoAtual = "VISUALIZAR"
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ELSE
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarEmpresa - LostFocus de txt_4c_Empresa: lookup em SigCdEmp
    * Substitui fAcessoEmpresa() do legado (nao portada)
    *==========================================================================
    PROCEDURE ValidarEmpresa()
        LOCAL loc_oPg2, loc_cEmps, loc_oBusca
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cEmps = ALLTRIM(loc_oPg2.txt_4c_Empresa.Value)

        IF loc_cEmps = THIS.this_cUltimaEmpresa
            RETURN
        ENDIF
        THIS.this_cUltimaEmpresa = loc_cEmps

        IF EMPTY(loc_cEmps)
            loc_oPg2.txt_4c_DEmpresa.Value = ""
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cEmps, "Empresa")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaEmp")
                        loc_oPg2.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        loc_oPg2.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                        THIS.this_cUltimaEmpresa = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPg2.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        loc_oPg2.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                        THIS.this_cUltimaEmpresa = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                    ELSE
                        loc_oPg2.txt_4c_Empresa.Value  = ""
                        loc_oPg2.txt_4c_DEmpresa.Value = ""
                        THIS.this_cUltimaEmpresa = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar empresa:" + CHR(13) + loc_oErro.Message, "FormCOM.ValidarEmpresa")
        ENDTRY

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarMoeda - LostFocus de txt_4c_Moeda: lookup em SigCdMoe
    * Original usava fwBuscaExt em getmoeda.Valid
    *==========================================================================
    PROCEDURE ValidarMoeda()
        LOCAL loc_oPg2, loc_cMoe, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cMoe = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)

        IF loc_cMoe = THIS.this_cUltimaMoeda
            RETURN
        ENDIF
        THIS.this_cUltimaMoeda = loc_cMoe

        IF EMPTY(loc_cMoe)
            loc_oPg2.txt_4c_DMoeda.Value = ""
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cMoe, "Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaMoe")
                        loc_oPg2.txt_4c_Moeda.Value  = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                        loc_oPg2.txt_4c_DMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
                        THIS.this_cUltimaMoeda = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        loc_oPg2.txt_4c_Moeda.Value  = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                        loc_oPg2.txt_4c_DMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
                        THIS.this_cUltimaMoeda = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                    ELSE
                        loc_oPg2.txt_4c_Moeda.Value  = ""
                        loc_oPg2.txt_4c_DMoeda.Value = ""
                        THIS.this_cUltimaMoeda = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar moeda:" + CHR(13) + loc_oErro.Message, "FormCOM.ValidarMoeda")
        ENDTRY

        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
    ENDPROC

    *==========================================================================
    * PctVd1Changed - LostFocus de txt_4c_PctVd1: auto-completa PctVd2
    * Original: getPctVd1.Valid -> PctVd2 = 100 - PctVd1
    *==========================================================================
    PROCEDURE PctVd1Changed()
        LOCAL loc_oPg2, loc_nVal
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_nVal = ABS(loc_oPg2.txt_4c_PctVd1.Value)
        loc_oPg2.txt_4c_PctVd1.Value = loc_nVal
        IF EMPTY(loc_nVal)
            loc_oPg2.txt_4c_PctVd2.Value = 100
        ELSE
            loc_oPg2.txt_4c_PctVd2.Value = 100 - loc_nVal
        ENDIF
    ENDPROC

    *==========================================================================
    * PctVd2Changed - LostFocus de txt_4c_PctVd2: auto-completa PctVd1
    * Original: getPctVd2.Valid -> PctVd1 = 100 - PctVd2
    *==========================================================================
    PROCEDURE PctVd2Changed()
        LOCAL loc_oPg2, loc_nVal
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_nVal = ABS(loc_oPg2.txt_4c_PctVd2.Value)
        loc_oPg2.txt_4c_PctVd2.Value = loc_nVal
        IF EMPTY(loc_nVal)
            loc_oPg2.txt_4c_PctVd1.Value = 100
        ELSE
            loc_oPg2.txt_4c_PctVd1.Value = 100 - loc_nVal
        ENDIF
    ENDPROC

    *==========================================================================
    * MetaEmpsChanged - LostFocus de txt_4c_MetaEmps: garante valor absoluto
    * Original: getMetaEmps.Valid -> This.Value = Abs(This.Value)
    *==========================================================================
    PROCEDURE MetaEmpsChanged()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oPg2.txt_4c_MetaEmps.Value = ABS(loc_oPg2.txt_4c_MetaEmps.Value)
    ENDPROC

    *==========================================================================
    * GrdVendExcluirClick - Exclui linha corrente do grid de Vendedores
    * Original: btnExcV.Click -> marca como deletado no crGrdItV
    *==========================================================================
    PROCEDURE GrdVendExcluirClick()
        TRY
            IF USED("crGrdItV") AND !EOF("crGrdItV") AND RECCOUNT("crGrdItV") > 0
                SELECT crGrdItV
                DELETE
                THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao excluir vendedor:" + CHR(13) + loc_oErro.Message, "FormCOM.GrdVendExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdProdExcluirClick - Exclui linha corrente do grid de Produtos
    * Original: btnExcP.Click -> marca como deletado no crGrdItP
    *==========================================================================
    PROCEDURE GrdProdExcluirClick()
        TRY
            IF USED("crGrdItP") AND !EOF("crGrdItP") AND RECCOUNT("crGrdItP") > 0
                SELECT crGrdItP
                DELETE
                THIS.pgf_4c_Paginas.Page2.grd_4c_Produtos.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao excluir produto:" + CHR(13) + loc_oErro.Message, "FormCOM.GrdProdExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdMetaExcluirClick - Exclui linha corrente do grid de Metas
    * Original: btnExcM.Click -> marca como deletado no crGrdItM
    *==========================================================================
    PROCEDURE GrdMetaExcluirClick()
        TRY
            IF USED("crGrdItM") AND !EOF("crGrdItM") AND RECCOUNT("crGrdItM") > 0
                SELECT crGrdItM
                DELETE
                THIS.pgf_4c_Paginas.Page2.grd_4c_Metas.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao excluir meta:" + CHR(13) + loc_oErro.Message, "FormCOM.GrdMetaExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdProdutosAfterRowColChange - Handler BINDEVENT AfterRowColChange grd Produtos
    *==========================================================================
    PROCEDURE GrdProdutosAfterRowColChange(par_nColIndex)
        LOCAL loc_nPrev
        loc_nPrev = THIS.this_nColPrevProd
        THIS.this_nColPrevProd = par_nColIndex
        TRY
            DO CASE
                CASE loc_nPrev = 1
                    THIS.AbrirLookupMercsProd()
                CASE loc_nPrev = 2
                    THIS.AbrirLookupCGrusProd()
                CASE loc_nPrev = 3
                    THIS.AbrirLookupSGrusProd()
                CASE loc_nPrev = 4 AND par_nColIndex = 1
                    THIS.AutoAddLinhaGrdProd()
            ENDCASE
        CATCH TO loc_oErro
            MostrarErro("Erro no grid Produtos:" + CHR(13) + loc_oErro.Message, "FormCOM.GrdProdutosAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupMercsProd - Lookup de Grande Grupo (Mercadorias) no grid Produtos
    *==========================================================================
    PROCEDURE AbrirLookupMercsProd()
        LOCAL loc_oBusca, loc_cMercsAnterior, loc_cMercs
        IF !USED("crGrdItP") OR EOF("crGrdItP")
            RETURN
        ENDIF
        loc_cMercsAnterior = ALLTRIM(crGrdItP.Mercs)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGpr", "cursor_4c_BuscaMercs", "Codigos", ;
            loc_cMercsAnterior, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grande Grupo")
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Codigos", "@!", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descs", "!", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMercs")
                loc_cMercs = ALLTRIM(cursor_4c_BuscaMercs.Codigos)
                SELECT crGrdItP
                IF loc_cMercs <> loc_cMercsAnterior
                    REPLACE crGrdItP.Mercs WITH loc_cMercs
                    REPLACE crGrdItP.CGrus WITH ""
                    REPLACE crGrdItP.SGrus WITH ""
                ELSE
                    REPLACE crGrdItP.Mercs WITH loc_cMercs
                ENDIF
                THIS.pgf_4c_Paginas.Page2.grd_4c_Produtos.Refresh()
            ENDIF
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupCGrusProd - Lookup de Grupo de Produto no grid Produtos
    *==========================================================================
    PROCEDURE AbrirLookupCGrusProd()
        LOCAL loc_oBusca, loc_cFiltro, loc_cMercs
        IF !USED("crGrdItP") OR EOF("crGrdItP")
            RETURN
        ENDIF
        loc_cMercs  = ALLTRIM(crGrdItP.Mercs)
        loc_cFiltro = ""
        IF !EMPTY(loc_cMercs)
            loc_cFiltro = "Mercs = '" + STRTRAN(loc_cMercs, "'", "''") + "'"
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_BuscaCGrus", "CGrus", ;
            ALLTRIM(crGrdItP.CGrus), ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo de Produto", ;
            .F., .T., loc_cFiltro)
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("CGrus",  "@!",  "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("DGrus",  "!",   "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("Mercs",  "@!",  "Grande Grupo")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCGrus")
                SELECT crGrdItP
                REPLACE crGrdItP.CGrus WITH ALLTRIM(cursor_4c_BuscaCGrus.CGrus)
                REPLACE crGrdItP.SGrus WITH ""
                THIS.pgf_4c_Paginas.Page2.grd_4c_Produtos.Refresh()
            ENDIF
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupSGrusProd - Lookup de SubGrupo no grid Produtos
    *==========================================================================
    PROCEDURE AbrirLookupSGrusProd()
        LOCAL loc_oBusca, loc_cFiltro, loc_cCGrus
        IF !USED("crGrdItP") OR EOF("crGrdItP")
            RETURN
        ENDIF
        loc_cCGrus  = ALLTRIM(crGrdItP.CGrus)
        loc_cFiltro = ""
        IF !EMPTY(loc_cCGrus)
            loc_cFiltro = "CGrus = '" + STRTRAN(loc_cCGrus, "'", "''") + "'"
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPsg", "cursor_4c_BuscaSGrus", "Codigos", ;
            ALLTRIM(crGrdItP.SGrus), ;
            "Sele" + CHR(231) + CHR(227) + "o de SubGrupo", ;
            .F., .T., loc_cFiltro)
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Codigos",    "@!", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descricaos", "!",  "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("CGrus",      "@!", "Grupo")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGrus")
                SELECT crGrdItP
                REPLACE crGrdItP.SGrus WITH ALLTRIM(cursor_4c_BuscaSGrus.Codigos)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Produtos.Refresh()
            ENDIF
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *==========================================================================
    * AutoAddLinhaGrdProd - Insere nova linha vazia no grid Produtos se necessario
    *==========================================================================
    PROCEDURE AutoAddLinhaGrdProd()
        LOCAL loc_lTemDados, loc_lTemVazia, loc_cPkCab
        IF !USED("crGrdItP") OR EMPTY(THIS.this_oBusinessObject.this_cCodigo)
            RETURN
        ENDIF
        loc_lTemDados = .F.
        loc_lTemVazia = .F.
        loc_cPkCab    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        SELECT crGrdItP
        GO TOP
        DO WHILE !EOF("crGrdItP")
            IF !DELETED()
                IF EMPTY(ALLTRIM(crGrdItP.Mercs))
                    loc_lTemVazia = .T.
                ELSE
                    loc_lTemDados = .T.
                ENDIF
            ENDIF
            SKIP
        ENDDO
        IF loc_lTemDados AND !loc_lTemVazia
            SELECT crGrdItP
            INSERT INTO crGrdItP (Tipos, pkChaves, fkChaves, Mercs, CGrus, SGrus, PPctFixs) ;
                VALUES ("PRO", LEFT(SYS(2015)+SYS(2015),20), loc_cPkCab, "", "", "", 0)
            THIS.pgf_4c_Paginas.Page2.grd_4c_Produtos.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdVendedoresAfterRowColChange - Handler BINDEVENT AfterRowColChange grd Vendedores
    *==========================================================================
    PROCEDURE GrdVendedoresAfterRowColChange(par_nColIndex)
        LOCAL loc_nPrev
        loc_nPrev = THIS.this_nColPrevVend
        THIS.this_nColPrevVend = par_nColIndex
        TRY
            DO CASE
                CASE loc_nPrev = 1
                    THIS.AbrirLookupCodVens()
                CASE loc_nPrev = 2
                    IF USED("crGrdItV") AND !EOF("crGrdItV")
                        SELECT crGrdItV
                        REPLACE crGrdItV.VMetas WITH ABS(crGrdItV.VMetas)
                        THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
                    ENDIF
                CASE loc_nPrev = 3
                    IF USED("crGrdItV") AND !EOF("crGrdItV")
                        SELECT crGrdItV
                        REPLACE crGrdItV.SalBases WITH ABS(crGrdItV.SalBases)
                        THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
                    ENDIF
                CASE loc_nPrev = 4
                    THIS.AbrirLookupCodResps()
                CASE (loc_nPrev = 5 OR loc_nPrev = 6) AND par_nColIndex = 1
                    THIS.AutoAddLinhaGrdVend()
            ENDCASE
        CATCH TO loc_oErro
            MostrarErro("Erro no grid Vendedores:" + CHR(13) + loc_oErro.Message, "FormCOM.GrdVendedoresAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupCodVens - Lookup de Vendedor no grid Vendedores
    *==========================================================================
    PROCEDURE AbrirLookupCodVens()
        LOCAL loc_oBusca, loc_cFiltro, loc_cGrpV, loc_cGrpR
        IF !USED("crGrdItV") OR EOF("crGrdItV")
            RETURN
        ENDIF
        loc_cGrpV   = ALLTRIM(THIS.this_oBusinessObject.this_cGrPadVens)
        loc_cGrpR   = ALLTRIM(THIS.this_oBusinessObject.this_cGrPadRess)
        loc_cFiltro = ""
        IF !EMPTY(loc_cGrpV) OR !EMPTY(loc_cGrpR)
            loc_cFiltro = "Grupos IN ('" + STRTRAN(loc_cGrpV,"'","''") + "','" + STRTRAN(loc_cGrpR,"'","''") + "')"
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaVens", "IClis", ;
            ALLTRIM(crGrdItV.CodVens), ;
            "Sele" + CHR(231) + CHR(227) + "o de Vendedor", ;
            .F., .T., loc_cFiltro)
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("IClis",  "@!", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("RCLis",  "!",  "Nome")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVens")
                SELECT crGrdItV
                REPLACE crGrdItV.CodVens WITH ALLTRIM(cursor_4c_BuscaVens.IClis)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
            ENDIF
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupCodResps - Lookup de Responsavel no grid Vendedores
    *==========================================================================
    PROCEDURE AbrirLookupCodResps()
        LOCAL loc_oBusca, loc_cFiltro, loc_cGrpV, loc_cGrpR
        IF !USED("crGrdItV") OR EOF("crGrdItV")
            RETURN
        ENDIF
        loc_cGrpV   = ALLTRIM(THIS.this_oBusinessObject.this_cGrPadVens)
        loc_cGrpR   = ALLTRIM(THIS.this_oBusinessObject.this_cGrPadRess)
        loc_cFiltro = ""
        IF !EMPTY(loc_cGrpV) OR !EMPTY(loc_cGrpR)
            loc_cFiltro = "Grupos IN ('" + STRTRAN(loc_cGrpV,"'","''") + "','" + STRTRAN(loc_cGrpR,"'","''") + "')"
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaResps", "IClis", ;
            ALLTRIM(crGrdItV.CodResps), ;
            "Sele" + CHR(231) + CHR(227) + "o de Respons" + CHR(225) + "veis", ;
            .F., .T., loc_cFiltro)
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("IClis",  "@!", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("RCLis",  "!",  "Nome")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaResps")
                SELECT crGrdItV
                REPLACE crGrdItV.CodResps WITH ALLTRIM(cursor_4c_BuscaResps.IClis)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
            ENDIF
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *==========================================================================
    * AutoAddLinhaGrdVend - Insere nova linha vazia no grid Vendedores se necessario
    *==========================================================================
    PROCEDURE AutoAddLinhaGrdVend()
        LOCAL loc_lTemDados, loc_lTemVazia, loc_cPkCab
        IF !USED("crGrdItV") OR EMPTY(THIS.this_oBusinessObject.this_cCodigo)
            RETURN
        ENDIF
        loc_lTemDados = .F.
        loc_lTemVazia = .F.
        loc_cPkCab    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        SELECT crGrdItV
        GO TOP
        DO WHILE !EOF("crGrdItV")
            IF !DELETED()
                IF EMPTY(ALLTRIM(crGrdItV.CodVens))
                    loc_lTemVazia = .T.
                ELSE
                    loc_lTemDados = .T.
                ENDIF
            ENDIF
            SKIP
        ENDDO
        IF loc_lTemDados AND !loc_lTemVazia
            SELECT crGrdItV
            INSERT INTO crGrdItV (Tipos, pkChaves, fkChaves, CodVens, VMetas, SalBases, CodResps, RPctFixs, VMetItns) ;
                VALUES ("VEN", LEFT(SYS(2015)+SYS(2015),20), loc_cPkCab, "", 0, 0, "", 0, 0)
            THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdMetasAfterRowColChange - Handler BINDEVENT AfterRowColChange grd Metas
    *==========================================================================
    PROCEDURE GrdMetasAfterRowColChange(par_nColIndex)
        LOCAL loc_nPrev
        loc_nPrev = THIS.this_nColPrevMeta
        THIS.this_nColPrevMeta = par_nColIndex
        TRY
            DO CASE
                CASE loc_nPrev = 2
                    IF USED("crGrdItM") AND !EOF("crGrdItM")
                        SELECT crGrdItM
                        REPLACE crGrdItM.FxaInis WITH ABS(crGrdItM.FxaInis)
                        THIS.pgf_4c_Paginas.Page2.grd_4c_Metas.Refresh()
                    ENDIF
                CASE loc_nPrev = 3
                    THIS.ValidarFxaFims()
                CASE (loc_nPrev = 4 OR loc_nPrev = 5) AND par_nColIndex = 1
                    THIS.AutoAddLinhaGrdMeta()
            ENDCASE
        CATCH TO loc_oErro
            MostrarErro("Erro no grid Metas:" + CHR(13) + loc_oErro.Message, "FormCOM.GrdMetasAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarFxaFims - Valida que FxaFims > FxaInis no grid Metas
    *==========================================================================
    PROCEDURE ValidarFxaFims()
        IF !USED("crGrdItM") OR EOF("crGrdItM")
            RETURN
        ENDIF
        SELECT crGrdItM
        IF crGrdItM.FxaFims <= crGrdItM.FxaInis AND crGrdItM.FxaFims <> 0
            MsgAviso("Faixa Final deve ser maior que Faixa Inicial.", "Comiss" + CHR(245) + "es")
            REPLACE crGrdItM.FxaFims WITH 0
            THIS.pgf_4c_Paginas.Page2.grd_4c_Metas.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * AutoAddLinhaGrdMeta - Insere nova linha no grid Metas com renumeracao
    *==========================================================================
    PROCEDURE AutoAddLinhaGrdMeta()
        LOCAL loc_lTemDados, loc_lTemVazia, loc_cPkCab
        LOCAL loc_nProxFaixa, loc_nUltFxaFims, loc_nCodFaixa
        IF !USED("crGrdItM") OR EMPTY(THIS.this_oBusinessObject.this_cCodigo)
            RETURN
        ENDIF
        loc_lTemDados  = .F.
        loc_lTemVazia  = .F.
        loc_cPkCab     = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        loc_nProxFaixa = 0
        loc_nUltFxaFims= 0
        loc_nCodFaixa  = 0
        SELECT crGrdItM
        GO TOP
        DO WHILE !EOF("crGrdItM")
            IF !DELETED()
                IF crGrdItM.FxaInis = 0 AND crGrdItM.FxaFims = 0
                    loc_lTemVazia = .T.
                ELSE
                    loc_lTemDados   = .T.
                    IF crGrdItM.FxaFims > loc_nUltFxaFims
                        loc_nUltFxaFims = crGrdItM.FxaFims
                    ENDIF
                    IF crGrdItM.CodFaixas > loc_nCodFaixa
                        loc_nCodFaixa = crGrdItM.CodFaixas
                    ENDIF
                ENDIF
            ENDIF
            SKIP
        ENDDO
        IF loc_lTemDados AND !loc_lTemVazia
            loc_nProxFaixa = loc_nUltFxaFims
            INSERT INTO crGrdItM (Tipos, pkChaves, fkChaves, CodFaixas, FxaInis, FxaFims, Bonus) ;
                VALUES ("MET", LEFT(SYS(2015)+SYS(2015),20), loc_cPkCab, loc_nCodFaixa + 1, loc_nProxFaixa, 0, 0)
            THIS.pgf_4c_Paginas.Page2.grd_4c_Metas.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.FecharCursores()
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\COMBO.prg):
*==============================================================================
* COMBO.prg - Business Object para Cadastro de Comissoes
* Tabela principal: SigCmCab (cabecalho)
* Tabela detalhe:   SigCmItn (itens: PRO=Produtos, VEN=Vendedores, MET=Metas)
* Fase 1: Propriedades e Init()
*==============================================================================

DEFINE CLASS COMBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - SigCmCab (cabecalho)
    *--------------------------------------------------------------------------
    this_cCodigo    = ""    && pkchaves char(20) - PK (GUID)
    this_cDescricao = ""    && cods     char(40) - Descricao da comissao
    this_cEmps      = ""    && emps     char(3)  - Codigo empresa
    this_dDtInicio  = {}    && dtinis   datetime - Data inicio vigencia
    this_dDtFim     = {}    && dtfims   datetime - Data fim vigencia
    this_nMetaEmps  = 0     && metaemps numeric(15,2) - Meta da empresa
    this_nPctVd1    = 0     && pctvd1   numeric(5,2)  - % vendedor 1
    this_nPctVd2    = 0     && pctvd2   numeric(5,2)  - % vendedor 2
    this_cMoedas    = ""    && moedas   char(3)  - Codigo moeda
    this_cCodGerente = ""   && CodGerente char(10) - Codigo gerente

    *--------------------------------------------------------------------------
    * Propriedades auxiliares de descricao (lookup display)
    *--------------------------------------------------------------------------
    this_cDEmps      = ""   && Descricao da empresa (SigCdEmp.Razas)
    this_cDMoedas    = ""   && Descricao da moeda   (SigCdMoe.DMoes)
    this_cGrPadVens  = ""   && Grupo padrao vendedores (config geral)
    this_cGrPadRess  = ""   && Grupo padrao responsaveis (config geral)
    this_cGrPadGers  = ""   && Grupo padrao gerentes (config geral)

    *--------------------------------------------------------------------------
    * Propriedade herdada obrigatoria
    *--------------------------------------------------------------------------
    this_cTabela     = ""
    this_cCampoChave = ""

    *==========================================================================
    * Init - Inicializa o BO configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCmCab"
            THIS.this_cCampoChave = "pkchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro COMBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * Buscar - Lista registros de SigCmCab com filtro opcional por descricao
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE a.cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = "SELECT a.pkchaves, a.cods, a.emps, a.dtinis, a.dtfims," + ;
                       " a.metaemps, a.pctvd1, a.pctvd2, a.moedas, a.CodGerente," + ;
                       " ISNULL(b.Razas, '') AS Razas" + ;
                       " FROM sigcmcab a" + ;
                       " LEFT JOIN SigCdEmp b ON b.Cemps = a.cemps" + ;
                       loc_cWhere + ;
                       " ORDER BY a.cods"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                IF RECCOUNT("cursor_4c_Dados") > 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar comiss" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo pkchaves e itens dos cursores
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cCodigo) <> "C" OR EMPTY(ALLTRIM(par_cCodigo))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT a.pkchaves, a.cods, a.emps, a.dtinis, a.dtfims," + ;
                       " a.metaemps, a.pctvd1, a.pctvd2, a.moedas, a.CodGerente," + ;
                       " ISNULL(b.Razas, '') AS Razas, ISNULL(c.DMoes, '') AS DMoes" + ;
                       " FROM sigcmcab a" + ;
                       " LEFT JOIN SigCdEmp b ON b.Cemps = a.cemps" + ;
                       " LEFT JOIN SigCdMoe c ON c.CMoes = a.moedas" + ;
                       " WHERE a.pkchaves = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                GO TOP IN cursor_4c_Carrega
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                    THIS.CarregarItens(par_cCodigo)
                ENDIF
            ELSE
                IF loc_nResult <= 0
                    MsgErro("Erro ao carregar comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(pkchaves,   "C")
            THIS.this_cDescricao = TratarNulo(cods,       "C")
            THIS.this_cEmps      = TratarNulo(emps,       "C")
            THIS.this_dDtInicio  = TratarNulo(dtinis,     "D")
            THIS.this_dDtFim     = TratarNulo(dtfims,     "D")
            THIS.this_nMetaEmps  = TratarNulo(metaemps,   "N")
            THIS.this_nPctVd1    = TratarNulo(pctvd1,     "N")
            THIS.this_nPctVd2    = TratarNulo(pctvd2,     "N")
            THIS.this_cMoedas    = TratarNulo(moedas,     "C")
            THIS.this_cCodGerente = TratarNulo(CodGerente, "C")
            IF TYPE(par_cAliasCursor + ".Razas") = "C"
                THIS.this_cDEmps   = TratarNulo(Razas,  "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DMoes") = "C"
                THIS.this_cDMoedas = TratarNulo(DMoes,  "C")
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarItens - Carrega cursores crGrdItP, crGrdItV, crGrdItM do banco
    *==========================================================================
    PROCEDURE CarregarItens(par_cFkChaves)
        LOCAL loc_cSQL, loc_nResult

        TRY
            *-- Cursor de Produtos (PRO)
            IF USED("crGrdItP")
                ZAP IN crGrdItP
            ELSE
                SET NULL ON
                CREATE CURSOR crGrdItP (Mercs C(3), CGrus C(3), SGrus C(6), ;
                    PPctFixs N(6,2), fkChaves C(20), pkChaves C(20), Tipos C(3))
                SET NULL OFF
            ENDIF

            loc_cSQL = "SELECT mercs, cgrus, sgrus, ppctfixs, fkchaves, pkchaves, tipos" + ;
                       " FROM sigcmitn WHERE fkchaves = " + EscaparSQL(par_cFkChaves) + ;
                       " AND tipos = 'PRO'"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ItP")
                TABLEREVERT(.T., "cursor_4c_ItP")
                USE IN cursor_4c_ItP
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItP")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ItP") > 0
                SELECT crGrdItP
                APPEND FROM DBF("cursor_4c_ItP")
                GO TOP IN crGrdItP
            ENDIF
            IF USED("cursor_4c_ItP")
                USE IN cursor_4c_ItP
            ENDIF

            *-- Cursor de Vendedores (VEN)
            IF USED("crGrdItV")
                ZAP IN crGrdItV
            ELSE
                SET NULL ON
                CREATE CURSOR crGrdItV (CodVens C(10), VMetas N(16,2), SalBases N(16,2), ;
                    CodResps C(10), RPctFixs N(6,2), fkChaves C(20), pkChaves C(20), ;
                    Tipos C(3), VMetItns N(6))
                SET NULL OFF
            ENDIF

            loc_cSQL = "SELECT codvens, vmetas, salbases, codresps, rpctfixs, fkchaves, pkchaves, tipos, vmetitns" + ;
                       " FROM sigcmitn WHERE fkchaves = " + EscaparSQL(par_cFkChaves) + ;
                       " AND tipos = 'VEN'"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ItV")
                TABLEREVERT(.T., "cursor_4c_ItV")
                USE IN cursor_4c_ItV
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItV")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ItV") > 0
                SELECT crGrdItV
                APPEND FROM DBF("cursor_4c_ItV")
                GO TOP IN crGrdItV
            ENDIF
            IF USED("cursor_4c_ItV")
                USE IN cursor_4c_ItV
            ENDIF

            *-- Cursor de Metas (MET)
            IF USED("crGrdItM")
                ZAP IN crGrdItM
            ELSE
                SET NULL ON
                CREATE CURSOR crGrdItM (CodFaixas N(2), FxaInis N(16,2), FxaFims N(16,2), ;
                    PctFaixas N(16,2), Bonus N(16,2), fkChaves C(20), pkChaves C(20), Tipos C(3))
                SET NULL OFF
            ENDIF

            loc_cSQL = "SELECT codfaixas, fxainis, fxafims, pctfaixas, bonus, fkchaves, pkchaves, tipos" + ;
                       " FROM sigcmitn WHERE fkchaves = " + EscaparSQL(par_cFkChaves) + ;
                       " AND tipos = 'MET' ORDER BY codfaixas"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ItM")
                TABLEREVERT(.T., "cursor_4c_ItM")
                USE IN cursor_4c_ItM
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItM")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ItM") > 0
                SELECT crGrdItM
                APPEND FROM DBF("cursor_4c_ItM")
                GO TOP IN crGrdItM
            ENDIF
            IF USED("cursor_4c_ItM")
                USE IN cursor_4c_ItM
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.CarregarItens: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * SalvarItens - Grava cursores crGrdItP/crGrdItV/crGrdItM em SigCmItn
    *==========================================================================
    PROTECTED PROCEDURE SalvarItens(par_cFkChaves)
        LOCAL loc_cSQL, loc_nResult, loc_cPk

        *-- Apaga itens anteriores
        loc_cSQL = "DELETE FROM sigcmitn WHERE fkchaves = " + EscaparSQL(par_cFkChaves)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
        IF loc_nResult < 0
            MsgErro("Erro ao limpar itens: " + CapturarErroSQL(), "Erro SQL")
            RETURN
        ENDIF

        *-- Salva Produtos (PRO)
        IF USED("crGrdItP")
            SELECT crGrdItP
            GO TOP IN crGrdItP
            SCAN NOT DELETED()
                IF !EMPTY(ALLTRIM(crGrdItP.Mercs)) OR !EMPTY(ALLTRIM(crGrdItP.CGrus))
                    loc_cPk = crGrdItP.pkChaves
                    IF EMPTY(ALLTRIM(loc_cPk))
                        loc_cPk = fUniqueIds()
                    ENDIF
                    loc_cSQL = "INSERT INTO sigcmitn" + ;
                               " (pkchaves, fkchaves, tipos, mercs, cgrus, sgrus, ppctfixs," + ;
                               "  codvens, vmetas, salbases, codresps, rpctfixs, vmetitns," + ;
                               "  codfaixas, fxainis, fxafims, pctfaixas, bonus, formas, CodRepr)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cPk) + ", " + ;
                               EscaparSQL(par_cFkChaves) + ", " + ;
                               "'PRO', " + ;
                               EscaparSQL(ALLTRIM(crGrdItP.Mercs)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrdItP.CGrus)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrdItP.SGrus)) + ", " + ;
                               FormatarNumeroSQL(crGrdItP.PPctFixs) + ", " + ;
                               "'', 0, 0, '', 0, 0, NULL, 0, 0, 0, 0, '', '')"
                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF
            ENDSCAN
        ENDIF

        *-- Salva Vendedores (VEN)
        IF USED("crGrdItV")
            SELECT crGrdItV
            GO TOP IN crGrdItV
            SCAN NOT DELETED()
                IF !EMPTY(ALLTRIM(crGrdItV.CodVens))
                    loc_cPk = crGrdItV.pkChaves
                    IF EMPTY(ALLTRIM(loc_cPk))
                        loc_cPk = fUniqueIds()
                    ENDIF
                    loc_cSQL = "INSERT INTO sigcmitn" + ;
                               " (pkchaves, fkchaves, tipos, mercs, cgrus, sgrus, ppctfixs," + ;
                               "  codvens, vmetas, salbases, codresps, rpctfixs, vmetitns," + ;
                               "  codfaixas, fxainis, fxafims, pctfaixas, bonus, formas, CodRepr)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cPk) + ", " + ;
                               EscaparSQL(par_cFkChaves) + ", " + ;
                               "'VEN', " + ;
                               "'', '', '', 0, " + ;
                               EscaparSQL(ALLTRIM(crGrdItV.CodVens)) + ", " + ;
                               FormatarNumeroSQL(crGrdItV.VMetas) + ", " + ;
                               FormatarNumeroSQL(crGrdItV.SalBases) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrdItV.CodResps)) + ", " + ;
                               FormatarNumeroSQL(crGrdItV.RPctFixs) + ", " + ;
                               FormatarNumeroSQL(crGrdItV.VMetItns) + ", " + ;
                               "NULL, 0, 0, 0, 0, '', '')"
                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF
            ENDSCAN
        ENDIF

        *-- Salva Metas (MET)
        IF USED("crGrdItM")
            SELECT crGrdItM
            GO TOP IN crGrdItM
            SCAN NOT DELETED()
                IF crGrdItM.FxaInis + crGrdItM.FxaFims > 0
                    loc_cPk = crGrdItM.pkChaves
                    IF EMPTY(ALLTRIM(loc_cPk))
                        loc_cPk = fUniqueIds()
                    ENDIF
                    loc_cSQL = "INSERT INTO sigcmitn" + ;
                               " (pkchaves, fkchaves, tipos, mercs, cgrus, sgrus, ppctfixs," + ;
                               "  codvens, vmetas, salbases, codresps, rpctfixs, vmetitns," + ;
                               "  codfaixas, fxainis, fxafims, pctfaixas, bonus, formas, CodRepr)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cPk) + ", " + ;
                               EscaparSQL(par_cFkChaves) + ", " + ;
                               "'MET', " + ;
                               "'', '', '', 0, '', 0, 0, '', 0, 0, " + ;
                               FormatarNumeroSQL(crGrdItM.CodFaixas) + ", " + ;
                               FormatarNumeroSQL(crGrdItM.FxaInis) + ", " + ;
                               FormatarNumeroSQL(crGrdItM.FxaFims) + ", " + ;
                               FormatarNumeroSQL(crGrdItM.PctFaixas) + ", " + ;
                               FormatarNumeroSQL(crGrdItM.Bonus) + ", " + ;
                               "'', '')"
                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF
            ENDSCAN
        ENDIF
    ENDPROC

    *==========================================================================
    * Inserir - INSERT em SigCmCab e itens em SigCmItn
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cPk
        loc_lResultado = .F.

        TRY
            loc_cPk = fUniqueIds()
            THIS.this_cCodigo = loc_cPk

            loc_cSQL = "INSERT INTO sigcmcab" + ;
                       " (pkchaves, cods, emps, dtinis, dtfims, metaemps," + ;
                       "  pctvd1, pctvd2, moedas, CodGerente, usuars, usualts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cPk) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtInicio) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtFim) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nMetaEmps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPctVd1) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPctVd2) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cMoedas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodGerente)) + ", " + ;
                       EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ", " + ;
                       EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.SalvarItens(loc_cPk)
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigCmCab + re-insere itens em SigCmItn
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE sigcmcab SET" + ;
                       " cods = " + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                       " emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                       " dtinis = " + FormatarDataSQL(THIS.this_dDtInicio) + ", " + ;
                       " dtfims = " + FormatarDataSQL(THIS.this_dDtFim) + ", " + ;
                       " metaemps = " + FormatarNumeroSQL(THIS.this_nMetaEmps) + ", " + ;
                       " pctvd1 = " + FormatarNumeroSQL(THIS.this_nPctVd1) + ", " + ;
                       " pctvd2 = " + FormatarNumeroSQL(THIS.this_nPctVd2) + ", " + ;
                       " moedas = " + EscaparSQL(ALLTRIM(THIS.this_cMoedas)) + ", " + ;
                       " CodGerente = " + EscaparSQL(ALLTRIM(THIS.this_cCodGerente)) + ", " + ;
                       " usualts = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                       " WHERE pkchaves = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.SalvarItens(THIS.this_cCodigo)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE em SigCmCab e SigCmItn
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM sigcmitn WHERE fkchaves = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao excluir itens: " + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM sigcmcab WHERE pkchaves = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * InicializarCursores - Cria cursores vazios para as grades de itens
    *==========================================================================
    PROCEDURE InicializarCursores()
        TRY
            IF !USED("crGrdItP")
                SET NULL ON
                CREATE CURSOR crGrdItP (Mercs C(3), CGrus C(3), SGrus C(6), ;
                    PPctFixs N(6,2), fkChaves C(20), pkChaves C(20), Tipos C(3))
                SET NULL OFF
            ELSE
                ZAP IN crGrdItP
            ENDIF

            IF !USED("crGrdItV")
                SET NULL ON
                CREATE CURSOR crGrdItV (CodVens C(10), VMetas N(16,2), SalBases N(16,2), ;
                    CodResps C(10), RPctFixs N(6,2), fkChaves C(20), pkChaves C(20), ;
                    Tipos C(3), VMetItns N(6))
                SET NULL OFF
            ELSE
                ZAP IN crGrdItV
            ENDIF

            IF !USED("crGrdItM")
                SET NULL ON
                CREATE CURSOR crGrdItM (CodFaixas N(2), FxaInis N(16,2), FxaFims N(16,2), ;
                    PctFaixas N(16,2), Bonus N(16,2), fkChaves C(20), pkChaves C(20), Tipos C(3))
                SET NULL OFF
            ELSE
                ZAP IN crGrdItM
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.InicializarCursores: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FecharCursores - Fecha cursores de itens ao destruir o BO
    *==========================================================================
    PROCEDURE FecharCursores()
        IF USED("crGrdItP")
            USE IN crGrdItP
        ENDIF
        IF USED("crGrdItV")
            USE IN crGrdItV
        ENDIF
        IF USED("crGrdItM")
            USE IN crGrdItM
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarConfigGeral - Carrega grupos padrao de vendedores/responsaveis
    *==========================================================================
    PROCEDURE CarregarConfigGeral()
        LOCAL loc_cSQL, loc_nResult

        TRY
            loc_cSQL = "SELECT TOP 1 GrPadVens, GrPadRess, GrPadGers" + ;
                       " FROM SigCdCfg WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
            IF USED("cursor_4c_Cfg")
                USE IN cursor_4c_Cfg
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cfg")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Cfg") > 0
                GO TOP IN cursor_4c_Cfg
                THIS.this_cGrPadVens = ALLTRIM(cursor_4c_Cfg.GrPadVens)
                THIS.this_cGrPadRess = ALLTRIM(cursor_4c_Cfg.GrPadRess)
                THIS.this_cGrPadGers = ALLTRIM(cursor_4c_Cfg.GrPadGers)
            ENDIF
            IF USED("cursor_4c_Cfg")
                USE IN cursor_4c_Cfg
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em COMBO.CarregarConfigGeral: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

