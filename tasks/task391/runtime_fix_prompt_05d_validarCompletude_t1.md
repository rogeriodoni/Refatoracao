# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormCVI.prg] Procedure vazia (sem codigo): GradeAfterRowColChange

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCVI.prg):
* FormCVI.prg - Cadastro de Comiss" + CHR(245) + "es de Vendedores Individuais
* Migrado de: SIGCDCVI.SCX
* Herda de FormBase

DEFINE CLASS FormCVI AS FormBase
    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Cadastro de Comiss" + CHR(245) + ;
                "es de Vendedores Individuais"

            THIS.this_oBusinessObject = CREATEOBJECT("CVIBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar CVIBO", "InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar FormCVI:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(100, 100, 100)
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(100, 100, 100)
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista com Grid e botoes CRUD)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 2 + 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .AutoSize  = .F.
            .Caption   = "Cadastro de Comiss" + CHR(245) + "es de Vendedores Individuais"
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 30
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .AutoSize  = .F.
            .Caption   = "Cadastro de Comiss" + CHR(245) + "es de Vendedores Individuais"
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 30
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op no legado: Left=313, Top=-1)
        *-- Posicao canonica no novo sistema: Left=542
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 0 + 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (inserir.Left=36 no legado -> canonico Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
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

        *-- Botao Visualizar (consultar.Left=111 -> canonico Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
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

        *-- Botao Alterar (alterar.Left=186 -> canonico Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
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

        *-- Botao Excluir (excluir.Left=261 -> canonico Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
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

        *-- Botao Buscar (procurar.Left=336 -> canonico Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
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

        *-- Container Saida - padrao canonico (grupo_saida.Left=719 no legado)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
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

        *-- Container Filtro periodo (cntFiltro no legado: Top=120, Left=12)
        loc_oPagina.AddObject("cnt_4c_Filtro", "Container")
        WITH loc_oPagina.cnt_4c_Filtro
            .Top           = 120 + 29
            .Left          = 12
            .Width         = 162
            .Height        = 29
            .BackColor     = RGB(255, 255, 255)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Filtro.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.cnt_4c_Filtro.lbl_4c_Periodo
            .AutoSize  = .T.
            .Caption   = "\<Per" + CHR(237) + "odo :"
            .Left      = 23
            .Top       = 7
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Filtro.AddObject("txt_4c_Mess", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtro.txt_4c_Mess
            .Top       = 3
            .Left      = 71
            .Width     = 24
            .Height    = 23
            .InputMask = "99"
            .MaxLength = 2
            .Value     = PADL(ALLTRIM(SUBSTR(DTOS(DATE()), 5, 2)), 2, "0")
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Filtro.AddObject("lbl_4c_BarraFiltro", "Label")
        WITH loc_oPagina.cnt_4c_Filtro.lbl_4c_BarraFiltro
            .AutoSize  = .F.
            .Caption   = "/"
            .Left      = 100
            .Top       = 7
            .Width     = 10
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Filtro.AddObject("txt_4c_Anos", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtro.txt_4c_Anos
            .Top       = 3
            .Left      = 108
            .Width     = 38
            .Height    = 23
            .InputMask = "9999"
            .MaxLength = 4
            .Value     = PADL(ALLTRIM(SUBSTR(DTOS(DATE()), 1, 4)), 4, "0")
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Botao Copia de Periodo (cmdCopia: Top=92+29=121, Left=347)
        loc_oPagina.AddObject("cmd_4c_Copia", "CommandButton")
        WITH loc_oPagina.cmd_4c_Copia
            .Caption         = "\<C" + CHR(243) + "pia"
            .Picture         = gc_4c_CaminhoIcones + "geral_copiar_32.jpg"
            .PicturePosition = 1
            .Top             = 92 + 29
            .Left            = 347
            .Width           = 105
            .Height          = 45
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH

        *-- Legenda de cores por tipo de comissao (Indivs)
        *-- Shape + Label: Individual (branco), Responsavel (azul), Setor (amarelo)
        loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPagina.shp_4c_Shape3
            .Top           = 102 + 29
            .Left          = 532
            .Height        = 14
            .Width         = 14
            .BackStyle     = 1
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LegIndividual", "Label")
        WITH loc_oPagina.lbl_4c_LegIndividual
            .AutoSize  = .T.
            .Caption   = "Individual"
            .Left      = 549
            .Top       = 101 + 29
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPagina.shp_4c_Shape1
            .Top           = 120 + 29
            .Left          = 532
            .Height        = 14
            .Width         = 14
            .BackStyle     = 1
            .SpecialEffect = 0
            .BackColor     = RGB(184, 213, 241)
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LegResponsavel", "Label")
        WITH loc_oPagina.lbl_4c_LegResponsavel
            .AutoSize  = .T.
            .Caption   = "Respons" + CHR(225) + "vel"
            .Left      = 549
            .Top       = 119 + 29
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPagina.shp_4c_Shape2
            .Top           = 138 + 29
            .Left          = 532
            .Height        = 14
            .Width         = 14
            .BackStyle     = 1
            .SpecialEffect = 0
            .BackColor     = RGB(247, 244, 166)
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LegSetor", "Label")
        WITH loc_oPagina.lbl_4c_LegSetor
            .AutoSize  = .T.
            .Caption   = "Setor"
            .Left      = 549
            .Top       = 137 + 29
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container de Copia de Periodo (cntCopia: Top=262+29=291, Visible=.F.)
        loc_oPagina.AddObject("cnt_4c_Copia", "Container")
        WITH loc_oPagina.cnt_4c_Copia
            .Top           = 262 + 29
            .Left          = 226
            .Width         = 348
            .Height        = 87
            .BackColor     = RGB(255, 255, 255)
            .BorderWidth   = 1
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_TituloCopia", "Label")
        WITH loc_oPagina.cnt_4c_Copia.lbl_4c_TituloCopia
            .AutoSize  = .T.
            .Caption   = "C" + CHR(243) + "pia de Per" + CHR(237) + "odo"
            .Left      = 8
            .Top       = 6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_LblOrigem", "Label")
        WITH loc_oPagina.cnt_4c_Copia.lbl_4c_LblOrigem
            .AutoSize  = .F.
            .Caption   = "Per" + CHR(237) + "odo de Origem :"
            .Left      = 28
            .Top       = 32
            .Width     = 97
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_BarraOrigem", "Label")
        WITH loc_oPagina.cnt_4c_Copia.lbl_4c_BarraOrigem
            .AutoSize  = .T.
            .Caption   = "/"
            .Left      = 157
            .Top       = 32
            .Width     = 8
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_OMess", "TextBox")
        WITH loc_oPagina.cnt_4c_Copia.txt_4c_OMess
            .Top       = 29
            .Left      = 128
            .Width     = 24
            .InputMask = "99"
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_OAnos", "TextBox")
        WITH loc_oPagina.cnt_4c_Copia.txt_4c_OAnos
            .Top       = 29
            .Left      = 166
            .Width     = 38
            .InputMask = "9999"
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_LblDestino", "Label")
        WITH loc_oPagina.cnt_4c_Copia.lbl_4c_LblDestino
            .AutoSize  = .F.
            .Caption   = "Per" + CHR(237) + "odo de Destino :"
            .Left      = 26
            .Top       = 57
            .Width     = 99
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_BarraDestino", "Label")
        WITH loc_oPagina.cnt_4c_Copia.lbl_4c_BarraDestino
            .AutoSize  = .T.
            .Caption   = "/"
            .Left      = 157
            .Top       = 56
            .Width     = 8
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_DMess", "TextBox")
        WITH loc_oPagina.cnt_4c_Copia.txt_4c_DMess
            .Top       = 53
            .Left      = 128
            .Width     = 24
            .InputMask = "99"
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_DAnos", "TextBox")
        WITH loc_oPagina.cnt_4c_Copia.txt_4c_DAnos
            .Top       = 53
            .Left      = 166
            .Width     = 38
            .InputMask = "9999"
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_CopiaOk", "CommandButton")
        WITH loc_oPagina.cnt_4c_Copia.cmd_4c_CopiaOk
            .Caption         = "\<Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "geral_escudo_ok_32.jpg"
            .PicturePosition = 1
            .Top             = 13
            .Left            = 217
            .Width           = 64
            .Height          = 55
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_CopiaCancel", "CommandButton")
        WITH loc_oPagina.cnt_4c_Copia.cmd_4c_CopiaCancel
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
            .PicturePosition = 1
            .Top             = 13
            .Left            = 281
            .Width           = 64
            .Height          = 55
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH

        *-- Grid da lista (grade no legado: Top=155, Left=12, Height=439)
        *-- Compensacao PageFrame: Top = 155 + 29 = 184
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 155 + 29
            .Left               = 12
            .Width              = 910
            .Height             = 439
            .ColumnCount        = 8
            .FontName           = "Tahoma"
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
            .ScrollBars         = 3
            .GridLines          = 3
            .Visible            = .T.
        ENDWITH

        *-- BINDEVENTs dos botoes CRUD
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,   "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,"Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,   "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,    "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.cmd_4c_Copia,                    "Click", THIS, "BtnCopiaClick")
        BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CopiaOk,    "Click", THIS, "BtnCopiaOkClick")
        BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CopiaCancel,"Click", THIS, "BtnCopiaCancelarClick")

        *-- BINDEVENTs dos campos de filtro
        BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_Mess, "KeyPress", THIS, "FiltroLostFocus")
        BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_Anos, "KeyPress", THIS, "FiltroLostFocus")

        *-- BINDEVENT do grid
        BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GradeAfterRowColChange")

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- Restaurar container de copia como oculto apos TornarControlesVisiveis
        loc_oPagina.cnt_4c_Copia.Visible = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Botoes Acao (Grupo_Salva no legado)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 4 + 29
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
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

        *-- CAMPOS PARTE 1/2 (Fase 5): Usuario, Periodo, Tipo, Setor (labels + textboxes)
        *-- Compensacao PageFrame: Top = Top_original + 29

        *-- Label: Usuario (Label1 no legado: Left=197, Top=157, ForeColor=36,84,155, Verdana 8)
        loc_oPagina.AddObject("lbl_4c_Usuars", "Label")
        WITH loc_oPagina.lbl_4c_Usuars
            .AutoSize  = .T.
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Left      = 197
            .Top       = 157 + 29
            .Width     = 54
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox: getUsuars (Left=251, Top=154, Width=80; lookup SigCdUsu)
        loc_oPagina.AddObject("txt_4c_Usuars", "TextBox")
        WITH loc_oPagina.txt_4c_Usuars
            .Left      = 251
            .Top       = 154 + 29
            .Width     = 80
            .Height    = 21
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Periodo (Label9 no legado: Left=197, Top=182, Verdana 8, ForeColor=36,84,155)
        loc_oPagina.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oPagina.lbl_4c_LblPeriodo
            .AutoSize  = .T.
            .Caption   = "Per" + CHR(237) + "odo :"
            .Left      = 197
            .Top       = 182 + 29
            .Width     = 54
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox: getMess (Left=251, Top=179, Width=24, InputMask="99")
        loc_oPagina.AddObject("txt_4c_Mess", "TextBox")
        WITH loc_oPagina.txt_4c_Mess
            .Left      = 251
            .Top       = 179 + 29
            .Width     = 24
            .Height    = 21
            .InputMask = "99"
            .MaxLength = 2
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: barra separadora de periodo (Label10: Left=282, Top=182)
        loc_oPagina.AddObject("lbl_4c_BarraPer", "Label")
        WITH loc_oPagina.lbl_4c_BarraPer
            .AutoSize  = .T.
            .Caption   = "/"
            .Left      = 282
            .Top       = 182 + 29
            .Width     = 7
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox: getAnos (Left=293, Top=179, Width=38, InputMask="9999")
        loc_oPagina.AddObject("txt_4c_Anos", "TextBox")
        WITH loc_oPagina.txt_4c_Anos
            .Left      = 293
            .Top       = 179 + 29
            .Width     = 38
            .Height    = 21
            .InputMask = "9999"
            .MaxLength = 4
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Tipo (Label2 no legado: Left=216, Top=207, Width=35, Verdana 8)
        loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPagina.lbl_4c_Tipo
            .AutoSize  = .T.
            .Caption   = "Tipo :"
            .Left      = 216
            .Top       = 207 + 29
            .Width     = 35
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox: getIndivs (Left=251, Top=204, Width=17, InputMask="!" -> I/R/S)
        loc_oPagina.AddObject("txt_4c_Indivs", "TextBox")
        WITH loc_oPagina.txt_4c_Indivs
            .Left      = 251
            .Top       = 204 + 29
            .Width     = 17
            .Height    = 21
            .InputMask = "!"
            .MaxLength = 1
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: ajuda tipo vendedor (Label7: Left=274, Top=207, Width=231)
        loc_oPagina.AddObject("lbl_4c_AjudaTipo", "Label")
        WITH loc_oPagina.lbl_4c_AjudaTipo
            .AutoSize  = .T.
            .Caption   = "( I )ndividual, ( R )Respons" + CHR(225) + "vel, ( S )etor"
            .Left      = 274
            .Top       = 207 + 29
            .Width     = 231
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Setor (Label3 no legado: Left=209, Top=232, Width=42, Verdana 8)
        loc_oPagina.AddObject("lbl_4c_LblSetor", "Label")
        WITH loc_oPagina.lbl_4c_LblSetor
            .AutoSize  = .T.
            .Caption   = "Setor :"
            .Left      = 209
            .Top       = 232 + 29
            .Width     = 42
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox: getSetors (Left=251, Top=229, Width=80; lookup SigCdSet)
        loc_oPagina.AddObject("txt_4c_Setors", "TextBox")
        WITH loc_oPagina.txt_4c_Setors
            .Left      = 251
            .Top       = 229 + 29
            .Width     = 80
            .Height    = 21
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Responsavel (Label4 no legado: Left=168, Top=257, Width=83, Verdana 8)
        loc_oPagina.AddObject("lbl_4c_LblResponsavel", "Label")
        WITH loc_oPagina.lbl_4c_LblResponsavel
            .AutoSize  = .T.
            .Caption   = "Respons" + CHR(225) + "vel :"
            .Left      = 168
            .Top       = 257 + 29
            .Width     = 83
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox: getSupervs (Left=251, Top=254, Width=80; lookup responsaveis em SigCcCmV/SigCdUsu)
        loc_oPagina.AddObject("txt_4c_Supervs", "TextBox")
        WITH loc_oPagina.txt_4c_Supervs
            .Left      = 251
            .Top       = 254 + 29
            .Width     = 80
            .Height    = 21
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Adicional (Label5 no legado: Left=189, Top=282, Width=62, Verdana 8)
        loc_oPagina.AddObject("lbl_4c_LblAdicional", "Label")
        WITH loc_oPagina.lbl_4c_LblAdicional
            .AutoSize  = .T.
            .Caption   = "Adicional :"
            .Left      = 189
            .Top       = 282 + 29
            .Width     = 62
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox: getAdics (Left=251, Top=279, Width=52)
        loc_oPagina.AddObject("txt_4c_Adics", "TextBox")
        WITH loc_oPagina.txt_4c_Adics
            .Left      = 251
            .Top       = 279 + 29
            .Width     = 52
            .Height    = 21
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: % apos Adicional (Label8 no legado: Left=308, Top=282, Width=14, Verdana 8)
        loc_oPagina.AddObject("lbl_4c_LblPctAdic", "Label")
        WITH loc_oPagina.lbl_4c_LblPctAdic
            .AutoSize  = .T.
            .Caption   = "%"
            .Left      = 308
            .Top       = 282 + 29
            .Width     = 14
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label: Minimo (Label6 no legado: Left=200, Top=307, Width=51, Verdana 8)
        loc_oPagina.AddObject("lbl_4c_LblMinimo", "Label")
        WITH loc_oPagina.lbl_4c_LblMinimo
            .AutoSize  = .T.
            .Caption   = "M" + CHR(237) + "nimo :"
            .Left      = 200
            .Top       = 307 + 29
            .Width     = 51
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox: getMinimos (Left=251, Top=304, Width=101)
        loc_oPagina.AddObject("txt_4c_Minimos", "TextBox")
        WITH loc_oPagina.txt_4c_Minimos
            .Left      = 251
            .Top       = 304 + 29
            .Width     = 101
            .Height    = 21
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label: Experiencia (Label11 no legado: Left=174, Top=332, Width=77, Verdana 8)
        loc_oPagina.AddObject("lbl_4c_LblExperiencia", "Label")
        WITH loc_oPagina.lbl_4c_LblExperiencia
            .AutoSize  = .T.
            .Caption   = "Experi" + CHR(234) + "ncia :"
            .Left      = 174
            .Top       = 332 + 29
            .Width     = 77
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox: getMinExps (Left=251, Top=329, Width=101)
        loc_oPagina.AddObject("txt_4c_MinExps", "TextBox")
        WITH loc_oPagina.txt_4c_MinExps
            .Left      = 251
            .Top       = 329 + 29
            .Width     = 101
            .Height    = 21
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs dos campos com lookup (F4 e DblClick)
        BINDEVENT(loc_oPagina.txt_4c_Usuars,  "KeyPress", THIS, "UsuarsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Usuars,  "DblClick", THIS, "UsuarsLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Setors,  "KeyPress", THIS, "SetorsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Setors,  "DblClick", THIS, "SetorsLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Supervs, "KeyPress", THIS, "SupervsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Supervs, "DblClick", THIS, "SupervsLookupDblClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no Grid da Page1 com filtro de periodo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oErro, loc_cMess, loc_cAnos
        LOCAL loc_cFiltro, loc_oGrid, loc_oPagina
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oPagina = THIS.pgf_4c_Paginas.Page1
                loc_oGrid   = loc_oPagina.grd_4c_Lista

                *-- Ler filtro de periodo do container cnt_4c_Filtro
                IF VARTYPE(loc_oPagina.cnt_4c_Filtro) = "O"
                    loc_cMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_Mess.Value), 2, "0")
                    loc_cAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_Anos.Value), 4, "0")
                ELSE
                    loc_cMess = PADL(ALLTRIM(SUBSTR(DTOS(DATE()), 5, 2)), 2, "0")
                    loc_cAnos = PADL(ALLTRIM(SUBSTR(DTOS(DATE()), 1, 4)), 4, "0")
                ENDIF

                *-- Construir filtro WHERE
                IF loc_cMess = "00" OR EMPTY(loc_cMess)
                    loc_cFiltro = "Anos = '" + loc_cAnos + "'"
                ELSE
                    IF loc_cAnos = "0000" OR EMPTY(loc_cAnos)
                        loc_cFiltro = "Mess = '" + loc_cMess + "'"
                    ELSE
                        loc_cFiltro = "Mess = '" + loc_cMess + "' AND Anos = '" + loc_cAnos + "'"
                    ENDIF
                ENDIF

                IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    *-- Vincular grid ao cursor (RecordSource e ControlSource FORA do WITH)
                    loc_oGrid.RecordSource = "crSigCcCmV"
                    loc_oGrid.ColumnCount  = 8

                    loc_oGrid.Column1.ControlSource = "crSigCcCmV.Usuars"
                    loc_oGrid.Column2.ControlSource = "crSigCcCmV.Mess"
                    loc_oGrid.Column3.ControlSource = "crSigCcCmV.Anos"
                    loc_oGrid.Column4.ControlSource = "crSigCcCmV.Indivs"
                    loc_oGrid.Column5.ControlSource = "crSigCcCmV.Setors"
                    loc_oGrid.Column6.ControlSource = "crSigCcCmV.Supervs"
                    loc_oGrid.Column7.ControlSource = "crSigCcCmV.Adics"
                    loc_oGrid.Column8.ControlSource = "crSigCcCmV.Minimos"

                    *-- Larguras das colunas
                    loc_oGrid.Column1.Width = 120
                    loc_oGrid.Column2.Width = 40
                    loc_oGrid.Column3.Width = 50
                    loc_oGrid.Column4.Width = 40
                    loc_oGrid.Column5.Width = 110
                    loc_oGrid.Column6.Width = 120
                    loc_oGrid.Column7.Width = 70
                    loc_oGrid.Column8.Width = 100

                    *-- Headers (obrigatorio reconfigurar apos RecordSource)
                    loc_oGrid.Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
                    loc_oGrid.Column2.Header1.Caption = "Ms"
                    loc_oGrid.Column3.Header1.Caption = "Ano"
                    loc_oGrid.Column4.Header1.Caption = "Tipo"
                    loc_oGrid.Column5.Header1.Caption = "Setor"
                    loc_oGrid.Column6.Header1.Caption = "Respons" + CHR(225) + "vel"
                    loc_oGrid.Column7.Header1.Caption = "Adicional"
                    loc_oGrid.Column8.Header1.Caption = "M" + CHR(237) + "nimo"

                    *-- Alinhamentos
                    loc_oGrid.Column1.Alignment = 0
                    loc_oGrid.Column2.Alignment = 2
                    loc_oGrid.Column3.Alignment = 2
                    loc_oGrid.Column4.Alignment = 2
                    loc_oGrid.Column5.Alignment = 0
                    loc_oGrid.Column6.Alignment = 0
                    loc_oGrid.Column7.Alignment = 1
                    loc_oGrid.Column8.Alignment = 1

                    THIS.FormatarGridLista(loc_oGrid)
                    *-- DynamicBackColor: I=branco, R=azul claro, S=amarelo (igual ao original)
                    loc_oGrid.SetAll("DynamicBackColor", ;
                        "IIF(crSigCcCmV.Indivs='S',RGB(247,244,166)," + ;
                        "IIF(crSigCcCmV.Indivs='R',RGB(184,213,241),RGB(255,255,255)))", ;
                        "Column")
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
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
    * BtnIncluirClick - Incluir novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave
        loc_cChave = ""

        IF !USED("crSigCcCmV") OR EOF("crSigCcCmV")
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN
        ENDIF

        SELECT crSigCcCmV
        loc_cChave = ALLTRIM(crSigCcCmV.cIdChaves)

        IF EMPTY(loc_cChave)
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave
        loc_cChave = ""

        IF !USED("crSigCcCmV") OR EOF("crSigCcCmV")
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN
        ENDIF

        SELECT crSigCcCmV
        loc_cChave = ALLTRIM(crSigCcCmV.cIdChaves)

        IF EMPTY(loc_cChave)
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave, loc_lConfirmou
        loc_cChave    = ""
        loc_lConfirmou = .F.

        IF !USED("crSigCcCmV") OR EOF("crSigCcCmV")
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN
        ENDIF

        SELECT crSigCcCmV
        loc_cChave = ALLTRIM(crSigCcCmV.cIdChaves)

        IF EMPTY(loc_cChave)
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN
        ENDIF

        loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
        IF !loc_lConfirmou
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarregar lista com filtro atual
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.FiltroLostFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva o registro atual
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        IF THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BtnCancelarClick()
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.ValidarDados()
            RETURN
        ENDIF

        TRY
            IF THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Registro salvo com sucesso!")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AlternarPagina(1)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela e volta para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCopiaClick - Mostra/oculta painel de copia de periodo
    *--------------------------------------------------------------------------
    PROCEDURE BtnCopiaClick()
        LOCAL loc_oPagina, loc_oCopia
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_oCopia  = loc_oPagina.cnt_4c_Copia

        *-- Desabilitar controles da lista ao abrir painel de copia
        loc_oPagina.grd_4c_Lista.Enabled         = .F.
        loc_oPagina.cnt_4c_Saida.Enabled         = .F.
        loc_oPagina.cnt_4c_Botoes.Enabled        = .F.
        loc_oPagina.cmd_4c_Copia.Enabled         = .F.
        THIS.pgf_4c_Paginas.Page2.Enabled        = .F.

        *-- Prefill com o periodo do filtro atual
        WITH loc_oCopia
            .txt_4c_OMess.Value = loc_oPagina.cnt_4c_Filtro.txt_4c_Mess.Value
            .txt_4c_OAnos.Value = loc_oPagina.cnt_4c_Filtro.txt_4c_Anos.Value
            .txt_4c_DMess.Value = ""
            .txt_4c_DAnos.Value = ""
            .Visible = .T.
        ENDWITH

        loc_oCopia.txt_4c_OMess.SetFocus
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCopiaCancelarClick - Cancela copia de periodo e restaura controles
    *--------------------------------------------------------------------------
    PROCEDURE BtnCopiaCancelarClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.cnt_4c_Copia.Visible         = .F.
        loc_oPagina.grd_4c_Lista.Enabled         = .T.
        loc_oPagina.cnt_4c_Saida.Enabled         = .T.
        loc_oPagina.cnt_4c_Botoes.Enabled        = .T.
        loc_oPagina.cmd_4c_Copia.Enabled         = .T.
        THIS.pgf_4c_Paginas.Page2.Enabled        = .T.

        THIS.Refresh()
        loc_oPagina.grd_4c_Lista.SetFocus
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCopiaOkClick - Executa copia de periodo via BO.CopiarPeriodo()
    *--------------------------------------------------------------------------
    PROCEDURE BtnCopiaOkClick()
        LOCAL loc_oPagina, loc_oCopia
        LOCAL loc_cOMess, loc_cOAnos, loc_cDMess, loc_cDAnos
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_oCopia  = loc_oPagina.cnt_4c_Copia

        loc_cOMess = PADL(ALLTRIM(loc_oCopia.txt_4c_OMess.Value), 2, "0")
        loc_cOAnos = PADL(ALLTRIM(loc_oCopia.txt_4c_OAnos.Value), 4, "0")
        loc_cDMess = PADL(ALLTRIM(loc_oCopia.txt_4c_DMess.Value), 2, "0")
        loc_cDAnos = PADL(ALLTRIM(loc_oCopia.txt_4c_DAnos.Value), 4, "0")

        IF EMPTY(loc_cOMess) OR loc_cOMess = "00"
            MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
                "s de Refer" + CHR(234) + "ncia da Origem!", "C" + CHR(243) + "pia")
            loc_oCopia.txt_4c_OMess.SetFocus
            RETURN
        ENDIF

        IF !BETWEEN(VAL(loc_cOMess), 1, 12)
            MsgAviso("M" + CHR(234) + "s de Origem inv" + CHR(225) + "lido (01-12).", "C" + CHR(243) + "pia")
            loc_oCopia.txt_4c_OMess.SetFocus
            RETURN
        ENDIF

        IF EMPTY(loc_cOAnos) OR loc_cOAnos = "0000"
            MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Refer" + CHR(234) + ;
                "ncia da Origem!", "C" + CHR(243) + "pia")
            loc_oCopia.txt_4c_OAnos.SetFocus
            RETURN
        ENDIF

        IF EMPTY(loc_cDMess) OR loc_cDMess = "00"
            MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
                "s de Refer" + CHR(234) + "ncia do Destino!", "C" + CHR(243) + "pia")
            loc_oCopia.txt_4c_DMess.SetFocus
            RETURN
        ENDIF

        IF !BETWEEN(VAL(loc_cDMess), 1, 12)
            MsgAviso("M" + CHR(234) + "s de Destino inv" + CHR(225) + "lido (01-12).", "C" + CHR(243) + "pia")
            loc_oCopia.txt_4c_DMess.SetFocus
            RETURN
        ENDIF

        IF EMPTY(loc_cDAnos) OR loc_cDAnos = "0000"
            MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Refer" + CHR(234) + ;
                "ncia do Destino!", "C" + CHR(243) + "pia")
            loc_oCopia.txt_4c_DAnos.SetFocus
            RETURN
        ENDIF

        IF loc_cOMess = loc_cDMess AND loc_cOAnos = loc_cDAnos
            MsgAviso("Per" + CHR(237) + "odo de origem e destino s" + CHR(227) + "o iguais.", "C" + CHR(243) + "pia")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a c" + CHR(243) + "pia do per" + CHR(237) + "odo " + ;
                loc_cOMess + "/" + loc_cOAnos + " para " + loc_cDMess + "/" + loc_cDAnos + "?", ;
                "C" + CHR(243) + "pia de Per" + CHR(237) + "odo")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CopiarPeriodo(loc_cOMess, loc_cOAnos, loc_cDMess, loc_cDAnos)
            MsgInfo("C" + CHR(243) + "pia realizada com sucesso!")
            THIS.BtnCopiaCancelarClick()
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltroLostFocus - Chamado quando campo de filtro perde foco; recarrega lista
    *--------------------------------------------------------------------------
    PROCEDURE FiltroLostFocus()
        LOCAL loc_oPagina, loc_cMess, loc_cAnos
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Padl nos campos de filtro
        loc_cMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_Mess.Value), 2, "0")
        loc_cAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_Anos.Value), 4, "0")

        loc_oPagina.cnt_4c_Filtro.txt_4c_Mess.Value = loc_cMess
        loc_oPagina.cnt_4c_Filtro.txt_4c_Anos.Value = loc_cAnos

        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - Handler do grid apos mudanca de linha/coluna
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        *-- Apenas garante que o cursor esta posicionado corretamente
        *-- (Sem acao adicional necessaria aqui)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do Form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lResultado, loc_oErro, loc_oPg2
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            THIS.this_oBusinessObject.this_cUsuars  = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)
            THIS.this_oBusinessObject.this_cMess    = PADL(ALLTRIM(loc_oPg2.txt_4c_Mess.Value), 2, "0")
            THIS.this_oBusinessObject.this_cAnos    = PADL(ALLTRIM(loc_oPg2.txt_4c_Anos.Value), 4, "0")
            THIS.this_oBusinessObject.this_cIndivs  = UPPER(ALLTRIM(loc_oPg2.txt_4c_Indivs.Value))
            THIS.this_oBusinessObject.this_cSetors  = ALLTRIM(loc_oPg2.txt_4c_Setors.Value)
            THIS.this_oBusinessObject.this_cSupervs = ALLTRIM(loc_oPg2.txt_4c_Supervs.Value)
            THIS.this_oBusinessObject.this_nAdics   = loc_oPg2.txt_4c_Adics.Value
            THIS.this_oBusinessObject.this_nMinimos = loc_oPg2.txt_4c_Minimos.Value
            THIS.this_oBusinessObject.this_nMinExps = loc_oPg2.txt_4c_MinExps.Value

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do BO para o Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lResultado, loc_oErro, loc_oPg2
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oPg2.txt_4c_Usuars.Value  = THIS.this_oBusinessObject.this_cUsuars
            loc_oPg2.txt_4c_Mess.Value    = THIS.this_oBusinessObject.this_cMess
            loc_oPg2.txt_4c_Anos.Value    = THIS.this_oBusinessObject.this_cAnos
            loc_oPg2.txt_4c_Indivs.Value  = THIS.this_oBusinessObject.this_cIndivs
            loc_oPg2.txt_4c_Setors.Value  = THIS.this_oBusinessObject.this_cSetors
            loc_oPg2.txt_4c_Supervs.Value = THIS.this_oBusinessObject.this_cSupervs
            loc_oPg2.txt_4c_Adics.Value   = TRANSFORM(THIS.this_oBusinessObject.this_nAdics)
            loc_oPg2.txt_4c_Minimos.Value = TRANSFORM(THIS.this_oBusinessObject.this_nMinimos)
            loc_oPg2.txt_4c_MinExps.Value = TRANSFORM(THIS.this_oBusinessObject.this_nMinExps)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro, loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oPg2.txt_4c_Usuars.Value  = ""
            loc_oPg2.txt_4c_Mess.Value    = ""
            loc_oPg2.txt_4c_Anos.Value    = ""
            loc_oPg2.txt_4c_Indivs.Value  = ""
            loc_oPg2.txt_4c_Setors.Value  = ""
            loc_oPg2.txt_4c_Supervs.Value = ""
            loc_oPg2.txt_4c_Adics.Value   = ""
            loc_oPg2.txt_4c_Minimos.Value = ""
            loc_oPg2.txt_4c_MinExps.Value = ""
        CATCH TO loc_oErro
            MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oErro, loc_oPg2, loc_lHab
        loc_lHab = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oPg2.txt_4c_Usuars.ReadOnly  = !loc_lHab
            loc_oPg2.txt_4c_Mess.ReadOnly    = !loc_lHab
            loc_oPg2.txt_4c_Anos.ReadOnly    = !loc_lHab
            loc_oPg2.txt_4c_Indivs.ReadOnly  = !loc_lHab
            loc_oPg2.txt_4c_Setors.ReadOnly  = !loc_lHab
            loc_oPg2.txt_4c_Supervs.ReadOnly = !loc_lHab
            loc_oPg2.txt_4c_Adics.ReadOnly   = !loc_lHab
            loc_oPg2.txt_4c_Minimos.ReadOnly = !loc_lHab
            loc_oPg2.txt_4c_MinExps.ReadOnly = !loc_lHab

            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHab
        CATCH TO loc_oErro
            MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oErro, loc_oPg1, loc_oPg2, loc_lEditando
        TRY
            loc_oPg1     = THIS.pgf_4c_Paginas.Page1
            loc_oPg2     = THIS.pgf_4c_Paginas.Page2
            loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
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
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("crSigCcCmV")
            USE IN crSigCcCmV
        ENDIF
        IF USED("cursor_4c_BuscaSup")
            USE IN cursor_4c_BuscaSup
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * UsuarsLookupKeyPress - Handler KeyPress para txt_4c_Usuars (F4 = abre lookup)
    *--------------------------------------------------------------------------
    PROCEDURE UsuarsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4 no VFP9
            THIS.AbrirLookupUsuars()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * UsuarsLookupDblClick - Handler DblClick para txt_4c_Usuars
    *--------------------------------------------------------------------------
    PROCEDURE UsuarsLookupDblClick()
        THIS.AbrirLookupUsuars()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupUsuars - Lookup em SigCdUsu (Usuarios / Nome Completo)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupUsuars()
        LOCAL loc_oPg2, loc_lReadOnly, loc_oBusca, loc_oErro
        loc_oBusca   = .NULL.
        loc_lReadOnly = .F.

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF VARTYPE(loc_oPg2.txt_4c_Usuars) = "O"
            loc_lReadOnly = loc_oPg2.txt_4c_Usuars.ReadOnly
        ENDIF
        IF loc_lReadOnly
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", ;
                loc_oPg2.txt_4c_Usuars.Value, ;
                "Usu" + CHR(225) + "rios")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Usuarios", "XXXXXXXXXX", "Usu" + CHR(225) + "rio")
                loc_oBusca.mAddColuna("NComps",   "X(40)",     "Nome Completo")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou
                    loc_oPg2.txt_4c_Usuars.Value = ALLTRIM(loc_oBusca.this_cValorSelecionado)
                    THIS.PreencherUltimoPeriodoUsuario(ALLTRIM(loc_oBusca.this_cValorSelecionado))
                ENDIF
                IF USED("cursor_4c_BuscaUsu")
                    USE IN cursor_4c_BuscaUsu
                ENDIF
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir lookup de Usu" + CHR(225) + "rio:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_BuscaUsu")
                USE IN cursor_4c_BuscaUsu
            ENDIF
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PreencherUltimoPeriodoUsuario - Preenche campos com ultimo periodo do usuario
    * Chamado apos selecao no lookup de usuario, quando outros campos estao vazios
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PreencherUltimoPeriodoUsuario(par_cUsuario)
        LOCAL loc_lProceder, loc_oErro, loc_oPg2
        LOCAL loc_cSQL, loc_nRet, loc_dBase, loc_dProx
        LOCAL loc_cMess, loc_cAnos

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- So preenche se os demais campos estiverem vazios
        loc_lProceder = EMPTY(ALLTRIM(loc_oPg2.txt_4c_Mess.Value)) AND ;
                        EMPTY(ALLTRIM(loc_oPg2.txt_4c_Anos.Value)) AND ;
                        EMPTY(ALLTRIM(loc_oPg2.txt_4c_Indivs.Value))

        IF !loc_lProceder
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Mess, Anos, Indivs, Setors, Supervs, Adics, Minimos " + ;
                       "FROM SigCcCmV " + ;
                       "WHERE Usuars = " + EscaparSQL(par_cUsuario) + " " + ;
                       "ORDER BY Anos DESC, Mess DESC"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltPer")

            IF loc_nRet > 0 AND USED("cursor_4c_UltPer") AND !EOF("cursor_4c_UltPer")
                *-- Calcular proximo periodo via GOMONTH
                loc_cMess = PADL(ALLTRIM(cursor_4c_UltPer.Mess), 2, "0")
                loc_cAnos = PADL(ALLTRIM(cursor_4c_UltPer.Anos), 4, "0")
                loc_dBase = DATE(VAL(loc_cAnos), VAL(loc_cMess), 1)
                loc_dProx = GOMONTH(loc_dBase, 1)

                loc_oPg2.txt_4c_Mess.Value    = PADL(LTRIM(STR(MONTH(loc_dProx))), 2, "0")
                loc_oPg2.txt_4c_Anos.Value    = LTRIM(STR(YEAR(loc_dProx)))
                loc_oPg2.txt_4c_Indivs.Value  = ALLTRIM(cursor_4c_UltPer.Indivs)
                loc_oPg2.txt_4c_Setors.Value  = ALLTRIM(cursor_4c_UltPer.Setors)
                loc_oPg2.txt_4c_Supervs.Value = ALLTRIM(cursor_4c_UltPer.Supervs)
                loc_oPg2.txt_4c_Adics.Value   = TRANSFORM(cursor_4c_UltPer.Adics)
                loc_oPg2.txt_4c_Minimos.Value = TRANSFORM(cursor_4c_UltPer.Minimos)

                IF USED("cursor_4c_UltPer")
                    USE IN cursor_4c_UltPer
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao preencher per" + CHR(237) + "odo do usu" + CHR(225) + "rio:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_UltPer")
                USE IN cursor_4c_UltPer
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * SetorsLookupKeyPress - Handler KeyPress para txt_4c_Setors (F4 = abre lookup)
    *--------------------------------------------------------------------------
    PROCEDURE SetorsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4 no VFP9
            THIS.AbrirLookupSetors()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SetorsLookupDblClick - Handler DblClick para txt_4c_Setors
    *--------------------------------------------------------------------------
    PROCEDURE SetorsLookupDblClick()
        THIS.AbrirLookupSetors()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSetors - Lookup em SigCdSet (Setores / Descricao)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSetors()
        LOCAL loc_oPg2, loc_lReadOnly, loc_oBusca, loc_oErro
        loc_oBusca   = .NULL.
        loc_lReadOnly = .F.

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF VARTYPE(loc_oPg2.txt_4c_Setors) = "O"
            loc_lReadOnly = loc_oPg2.txt_4c_Setors.ReadOnly
        ENDIF
        IF loc_lReadOnly
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdSet", "cursor_4c_BuscaSet", "Setores", ;
                loc_oPg2.txt_4c_Setors.Value, ;
                "Setores")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Setores", "XXXXXXXXXX", "Setor")
                loc_oBusca.mAddColuna("Descrs",  "X(40)",     "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou
                    loc_oPg2.txt_4c_Setors.Value = ALLTRIM(loc_oBusca.this_cValorSelecionado)
                ENDIF
                IF USED("cursor_4c_BuscaSet")
                    USE IN cursor_4c_BuscaSet
                ENDIF
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir lookup de Setor:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_BuscaSet")
                USE IN cursor_4c_BuscaSet
            ENDIF
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * SupervsLookupKeyPress - Handler KeyPress para txt_4c_Supervs (F4 = abre lookup)
    *--------------------------------------------------------------------------
    PROCEDURE SupervsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4 no VFP9
            THIS.AbrirLookupSupervs()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SupervsLookupDblClick - Handler DblClick para txt_4c_Supervs
    *--------------------------------------------------------------------------
    PROCEDURE SupervsLookupDblClick()
        THIS.AbrirLookupSupervs()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSupervs - Lookup dinamico de responsaveis em SigCcCmV/SigCdUsu
    * Busca DISTINCT usuarios com Indivs='R' e Supervs/Setors em branco
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSupervs()
        LOCAL loc_oPg2, loc_lReadOnly, loc_oBusca, loc_oErro, loc_nRet, loc_cSQL
        loc_oBusca   = .NULL.
        loc_lReadOnly = .F.

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF VARTYPE(loc_oPg2.txt_4c_Supervs) = "O"
            loc_lReadOnly = loc_oPg2.txt_4c_Supervs.ReadOnly
        ENDIF
        IF loc_lReadOnly
            RETURN
        ENDIF

        TRY
            *-- Montar cursor dinamico de responsaveis (Indivs='R', sem Supervs/Setors proprios)
            loc_cSQL = "SELECT DISTINCT a.Usuars, b.NComps " + ;
                       "FROM SigCcCmV a " + ;
                       "INNER JOIN SigCdUsu b ON a.Usuars = b.Usuarios " + ;
                       "WHERE a.Indivs = 'R' " + ;
                       "AND RTRIM(a.Supervs) = '' " + ;
                       "AND RTRIM(a.Setors) = '' " + ;
                       "ORDER BY a.Usuars"

            IF USED("cursor_4c_BuscaSup")
                USE IN cursor_4c_BuscaSup
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaSup")

            IF loc_nRet <= 0 OR !USED("cursor_4c_BuscaSup")
                MsgAviso("Nenhum respons" + CHR(225) + "vel encontrado.", "Respons" + CHR(225) + "vel")
                RETURN
            ENDIF

            *-- FormBuscaAuxiliar MODO 2: sem params Init, cursor pre-existente
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaSup"
                loc_oBusca.mAddColuna("Usuars", "XXXXXXXXXX", "Usu" + CHR(225) + "rio")
                loc_oBusca.mAddColuna("NComps", "X(40)",     "Nome Completo")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou
                    loc_oPg2.txt_4c_Supervs.Value = ALLTRIM(loc_oBusca.this_cValorSelecionado)
                ENDIF
                IF USED("cursor_4c_BuscaSup")
                    USE IN cursor_4c_BuscaSup
                ENDIF
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir lookup de Respons" + CHR(225) + "vel:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_BuscaSup")
                USE IN cursor_4c_BuscaSup
            ENDIF
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\CVIBO.prg):
*====================================================================
* CVIBO.prg
*
* Business Object para Comissoes de Vendedores Individuais
* Tabela principal: SigCcCmV (cIdChaves PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CVIBO AS BusinessBase

	*-- Propriedades da entidade (SigCcCmV)
	this_cCidChaves  = ""    && cIdChaves char(20)    - PK (UUID via fUniqueIds)
	this_cUsuars     = ""    && Usuars char(10)        - usuario (FK SigCdUsu.Usuarios)
	this_cMess       = ""    && Mess char(2)           - mes de referencia (MM)
	this_cAnos       = ""    && Anos char(4)           - ano de referencia (YYYY)
	this_cIndivs     = ""    && Indivs char(1)         - tipo: I=Individual R=Responsavel S=Setor
	this_cSetors     = ""    && Setors char(10)        - setor (FK SigCdSet.Setores)
	this_cSupervs    = ""    && Supervs char(10)       - responsavel (FK SigCcCmV.Usuars onde Indivs=R)
	this_nAdics      = 0     && Adics numeric(5,2)     - percentual adicional
	this_nMinimos    = 0     && Minimos numeric(11,2)  - valor minimo
	this_nMinExps    = 0     && MinExps numeric(11,2)  - experiencia minima

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCcCmV"
		THIS.this_cCampoChave = "cIdChaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna PK para auditoria
	*====================================================================
	PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidChaves
	ENDPROC

	*====================================================================
	* Buscar - SELECT com filtro WHERE opcional
	* par_cFiltro: clausula WHERE sem a palavra WHERE (ex: "Mess='01' AND Anos='2026'")
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "SELECT cIdChaves, Usuars, Mess, Anos, Indivs," + ;
				" Setors, Supervs, Adics, Minimos, MinExps" + ;
				" FROM SigCcCmV"
			IF TYPE("par_cFiltro") = "C" AND !EMPTY(par_cFiltro)
				loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
			ENDIF
			loc_cSQL = loc_cSQL + " ORDER BY Anos, Mess, Usuars"

			IF USED("crSigCcCmV")
				USE IN crSigCcCmV
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmV")
			IF loc_nResult > 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega BO pelo cIdChaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cChave)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "SELECT cIdChaves, Usuars, Mess, Anos, Indivs," + ;
				" Setors, Supervs, Adics, Minimos, MinExps" + ;
				" FROM SigCcCmV WHERE cIdChaves = " + EscaparSQL(par_cChave)

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Popula propriedades do BO a partir de cursor
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAlias)
		LOCAL loc_lResultado
		loc_lResultado = .F.
		IF USED(par_cAlias)
			SELECT (par_cAlias)
			THIS.this_cCidChaves = TratarNulo(cIdChaves, "C")
			THIS.this_cUsuars    = TratarNulo(Usuars,    "C")
			THIS.this_cMess      = TratarNulo(Mess,      "C")
			THIS.this_cAnos      = TratarNulo(Anos,      "C")
			THIS.this_cIndivs    = TratarNulo(Indivs,    "C")
			THIS.this_cSetors    = TratarNulo(Setors,    "C")
			THIS.this_cSupervs   = TratarNulo(Supervs,   "C")
			THIS.this_nAdics     = TratarNulo(Adics,     "N")
			THIS.this_nMinimos   = TratarNulo(Minimos,   "N")
			THIS.this_nMinExps   = TratarNulo(MinExps,   "N")
			loc_lResultado = .T.
		ENDIF
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ValidarDados - Valida campos obrigatorios e regras de negocio
	*====================================================================
	PROCEDURE ValidarDados()
		LOCAL loc_lValido, loc_cSQLComI, loc_nResComI
		LOCAL loc_cSQLSupv, loc_nResSupv
		loc_lValido = .T.

		IF EMPTY(ALLTRIM(THIS.this_cUsuars))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Usu" + CHR(225) + "rio!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cMess))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o M" + CHR(234) + "s de Refer" + ;
				CHR(234) + "ncia!!!", "Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND !(INT(VAL(THIS.this_cMess)) > 0)
			MsgAviso("M" + CHR(234) + "s de Refer" + CHR(234) + "ncia Inv" + CHR(225) + "lido!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cAnos))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Ano de Refer" + CHR(234) + "ncia!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND !BETWEEN(INT(VAL(THIS.this_cAnos)), 1, 9999)
			MsgAviso("Ano de Refer" + CHR(234) + "ncia Inv" + CHR(225) + "lido!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cIndivs))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Status de Tipo de Vendedor!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND !INLIST(ALLTRIM(THIS.this_cIndivs), "I", "R", "S")
			MsgAviso("Observe a Informa" + CHR(231) + CHR(227) + "o na Tela ao Lado do Tipo de Vendedor!!!" + CHR(13) + ;
				"Voc" + CHR(234) + " Est" + CHR(225) + " Tentando Usar Um Tipo de Vendedor Que N" + CHR(227) + "o Existe!!!", ;
				"Aten" + CHR(231) + CHR(227) + "o!!!")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_nMinimos = 0
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Valor M" + CHR(237) + "nimo!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "I" AND THIS.this_nAdics <> 0
			MsgAviso("O Vendedor N" + CHR(227) + "o Pode Ser Individual e Receber Adicional!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "S" AND THIS.this_nAdics <> 0
			MsgAviso("O Vendedor N" + CHR(227) + "o Pode Ser de Setor e Receber Adicional!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "R" AND !EMPTY(ALLTRIM(THIS.this_cSupervs))
			MsgAviso("O Respons" + CHR(225) + "vel N" + CHR(227) + "o Pode Ter Um Respons" + CHR(225) + "vel Cadastrado!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "R" AND ;
			EMPTY(ALLTRIM(THIS.this_cSetors)) AND THIS.this_nAdics = 0
			MsgAviso("O Vendedor Respons" + CHR(225) + "vel Tem Que Ter Um Adicional Cadastrado!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		*-- Verificar se usuario ja cadastrado no periodo em SigCcCmI (Vendedor por Cargo)
		IF loc_lValido
			loc_cSQLComI = "SELECT Usuars, Mess, Anos, cIdChaves FROM SigCcCmI" + ;
				" WHERE Usuars = " + EscaparSQL(ALLTRIM(THIS.this_cUsuars))

			IF USED("cursor_4c_ComI")
				USE IN cursor_4c_ComI
			ENDIF

			loc_nResComI = SQLEXEC(gnConnHandle, loc_cSQLComI, "cursor_4c_ComI")
			IF loc_nResComI > 0
				SELECT cursor_4c_ComI
				SCAN
					IF ALLTRIM(cursor_4c_ComI.Mess) = ALLTRIM(THIS.this_cMess) AND ;
					   ALLTRIM(cursor_4c_ComI.Anos) = ALLTRIM(THIS.this_cAnos)
						MsgAviso("Usu" + CHR(225) + "rio J" + CHR(225) + " Cadastrado No Per" + ;
							CHR(237) + "odo Como Vendedor Por Cargo!!!", ;
							"Valida" + CHR(231) + CHR(227) + "o")
						loc_lValido = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF
			IF USED("cursor_4c_ComI")
				USE IN cursor_4c_ComI
			ENDIF
		ENDIF

		*-- Verificar se supervisor ja tem vinculo no mesmo periodo (se tem setor definido)
		IF loc_lValido AND !EMPTY(ALLTRIM(THIS.this_cSetors))
			loc_cSQLSupv = "SELECT Usuars FROM SigCcCmV" + ;
				" WHERE Supervs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuars), 10)) + ;
				" AND Mess = " + EscaparSQL(ALLTRIM(THIS.this_cMess)) + ;
				" AND Anos = " + EscaparSQL(ALLTRIM(THIS.this_cAnos)) + ;
				" AND cIdChaves <> " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			IF USED("cursor_4c_Supv")
				USE IN cursor_4c_Supv
			ENDIF

			loc_nResSupv = SQLEXEC(gnConnHandle, loc_cSQLSupv, "cursor_4c_Supv")
			IF loc_nResSupv > 0 AND RECCOUNT("cursor_4c_Supv") > 0
				SELECT cursor_4c_Supv
				GO TOP
				IF !EOF("cursor_4c_Supv")
					MsgAviso("Usu" + CHR(225) + "rio Cadastrado Como Vendedor Respons" + CHR(225) + "vel!!!", ;
						"Valida" + CHR(231) + CHR(227) + "o")
					loc_lValido = .F.
				ENDIF
			ENDIF
			IF USED("cursor_4c_Supv")
				USE IN cursor_4c_Supv
			ENDIF
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* Inserir - INSERT em SigCcCmV (PROTECTED - chamado pelo BusinessBase)
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
				THIS.this_cCidChaves = fUniqueIds()
			ENDIF

			loc_cSQL = "INSERT INTO SigCcCmV" + ;
				" (cIdChaves, Usuars, Mess, Anos, Indivs, Setors, Supervs, Adics, Minimos, MinExps)" + ;
				" VALUES (" + ;
				EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
				EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuars), 10)) + ", " + ;
				EscaparSQL(ALLTRIM(THIS.this_cMess)) + ", " + ;
				EscaparSQL(ALLTRIM(THIS.this_cAnos)) + ", " + ;
				EscaparSQL(ALLTRIM(THIS.this_cIndivs)) + ", " + ;
				EscaparSQL(PADR(ALLTRIM(THIS.this_cSetors), 10)) + ", " + ;
				EscaparSQL(PADR(ALLTRIM(THIS.this_cSupervs), 10)) + ", " + ;
				FormatarNumeroSQL(THIS.this_nAdics) + ", " + ;
				FormatarNumeroSQL(THIS.this_nMinimos) + ", " + ;
				FormatarNumeroSQL(THIS.this_nMinExps) + ")"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE em SigCcCmV (PROTECTED - chamado pelo BusinessBase)
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "UPDATE SigCcCmV SET" + ;
				" Usuars = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuars), 10)) + "," + ;
				" Mess = " + EscaparSQL(ALLTRIM(THIS.this_cMess)) + "," + ;
				" Anos = " + EscaparSQL(ALLTRIM(THIS.this_cAnos)) + "," + ;
				" Indivs = " + EscaparSQL(ALLTRIM(THIS.this_cIndivs)) + "," + ;
				" Setors = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cSetors), 10)) + "," + ;
				" Supervs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cSupervs), 10)) + "," + ;
				" Adics = " + FormatarNumeroSQL(THIS.this_nAdics) + "," + ;
				" Minimos = " + FormatarNumeroSQL(THIS.this_nMinimos) + "," + ;
				" MinExps = " + FormatarNumeroSQL(THIS.this_nMinExps) + ;
				" WHERE cIdChaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE em SigCcCmV (PROTECTED - chamado pelo BusinessBase)
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "DELETE FROM SigCcCmV WHERE cIdChaves = " + ;
				EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CopiarPeriodo - Copia comissoes de um periodo de origem para destino
	* par_cOMess/par_cOAnos: periodo de origem (MM/YYYY)
	* par_cDMess/par_cDAnos: periodo de destino (MM/YYYY)
	* Retorna .T. se ao menos um registro foi gerado com sucesso
	*====================================================================
	PROCEDURE CopiarPeriodo(par_cOMess, par_cOAnos, par_cDMess, par_cDAnos)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		LOCAL loc_llIns, loc_llOks, loc_lcMsg, loc_llPular
		LOCAL loc_nConnFP2, loc_oProg
		LOCAL loc_cSQLFop, loc_nResFop
		LOCAL loc_cSQLBusca, loc_nResBusca
		LOCAL loc_cNovaChave, loc_cSQLIns, loc_nResIns
		LOCAL loc_cUsar, loc_cIndv, loc_cSet, loc_cSup
		LOCAL loc_nAdi, loc_nMin, loc_nMinEx

		loc_lResultado = .F.
		loc_llIns      = .F.
		loc_llOks      = .T.
		loc_lcMsg      = ""
		loc_llPular    = .F.
		loc_nConnFP2   = 0
		loc_oProg      = .NULL.

		TRY
			*-- Buscar todos os registros do periodo de origem
			loc_cSQL = "SELECT * FROM SigCcCmV" + ;
				" WHERE Mess = " + EscaparSQL(par_cOMess) + ;
				" AND Anos = " + EscaparSQL(par_cOAnos) + ;
				" ORDER BY Usuars"

			IF USED("crOrigem")
				USE IN crOrigem
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crOrigem")
			IF loc_nResult < 1
				MsgErro("Erro ao buscar per" + CHR(237) + "odo de origem:" + CHR(13) + ;
					CapturarErroSQL(), "Erro SQL")
			ELSE
				SELECT crOrigem
				GO TOP
				IF EOF("crOrigem")
					MsgAviso("Nenhum Vendedor Est" + CHR(225) + " Cadastrado no Per" + CHR(237) + ;
						"odo de Origem Informado!!!", "Aten" + CHR(231) + CHR(227) + "o")
				ELSE
					*-- Tentar conexao secundaria para folha de pagamento
					loc_nConnFP2 = SQLCONNECT("SigCcCMV_FOPAGV")

					*-- Criar barra de progresso
					loc_oProg = CREATEOBJECT("fwprogressbar", ;
						"Processando Vendedores...", RECCOUNT("crOrigem") + 1)
					IF VARTYPE(loc_oProg) = "O"
						loc_oProg.Show()
					ENDIF

					SELECT crOrigem
					SCAN
						*-- Capturar valores do registro atual antes de mudar area de trabalho
						loc_cUsar  = ALLTRIM(crOrigem.Usuars)
						loc_cIndv  = ALLTRIM(crOrigem.Indivs)
						loc_cSet   = ALLTRIM(crOrigem.Setors)
						loc_cSup   = ALLTRIM(crOrigem.Supervs)
						loc_nAdi   = crOrigem.Adics
						loc_nMin   = crOrigem.Minimos
						loc_nMinEx = crOrigem.MinExps
						loc_llPular = .F.

						IF VARTYPE(loc_oProg) = "O"
							loc_oProg.Update(.T.)
							IF PEMSTATUS(loc_oProg, "SubTitulo", 5)
								loc_oProg.SubTitulo.Caption = "Processando o Vendedor : " + loc_cUsar
							ENDIF
						ENDIF

						*-- Verificar atividade na folha de pagamento (se conexao disponivel)
						IF loc_nConnFP2 > 0
							loc_cSQLFop = "SELECT Funcs, Conds FROM FopCff" + ;
								" WHERE Funcs = " + EscaparSQL(loc_cUsar) + ;
								" ORDER BY Funcs"

							IF USED("crFopCff")
								USE IN crFopCff
							ENDIF

							loc_nResFop = SQLEXEC(loc_nConnFP2, loc_cSQLFop, "crFopCff")
							IF loc_nResFop > 0
								SELECT crFopCff
								GO TOP
								IF EOF("crFopCff") OR INLIST(ALLTRIM(crFopCff.Conds), "D", "Q")
									loc_lcMsg = loc_lcMsg + loc_cUsar + ;
										IIF(!EOF("crFopCff"), "(" + ALLTRIM(crFopCff.Conds) + "); ", "; ")
									loc_llPular = .T.
								ENDIF
							ENDIF
							IF USED("crFopCff")
								USE IN crFopCff
							ENDIF
						ENDIF

						IF !loc_llPular
							*-- Verificar se ja existe no periodo de destino
							loc_cSQLBusca = "SELECT cIdChaves FROM SigCcCmV" + ;
								" WHERE Usuars = " + EscaparSQL(loc_cUsar) + ;
								" AND Indivs = " + EscaparSQL(loc_cIndv) + ;
								" AND Setors = " + EscaparSQL(loc_cSet) + ;
								" AND Mess = " + EscaparSQL(par_cDMess) + ;
								" AND Anos = " + EscaparSQL(par_cDAnos)

							IF USED("crBusca")
								USE IN crBusca
							ENDIF

							loc_nResBusca = SQLEXEC(gnConnHandle, loc_cSQLBusca, "crBusca")
							IF loc_nResBusca > 0
								SELECT crBusca
								GO TOP
								IF EOF("crBusca")
									*-- Inserir novo registro no periodo de destino
									loc_cNovaChave = fUniqueIds()
									loc_cSQLIns = "INSERT INTO SigCcCmV" + ;
										" (cIdChaves, Usuars, Mess, Anos, Indivs," + ;
										" Setors, Supervs, Adics, Minimos, MinExps)" + ;
										" VALUES (" + ;
										EscaparSQL(loc_cNovaChave) + ", " + ;
										EscaparSQL(loc_cUsar) + ", " + ;
										EscaparSQL(par_cDMess) + ", " + ;
										EscaparSQL(par_cDAnos) + ", " + ;
										EscaparSQL(loc_cIndv) + ", " + ;
										EscaparSQL(loc_cSet) + ", " + ;
										EscaparSQL(loc_cSup) + ", " + ;
										FormatarNumeroSQL(loc_nAdi) + ", " + ;
										FormatarNumeroSQL(loc_nMin) + ", " + ;
										FormatarNumeroSQL(loc_nMinEx) + ")"

									loc_nResIns = SQLEXEC(gnConnHandle, loc_cSQLIns)
									IF loc_nResIns > 0
										loc_llIns = .T.
									ELSE
										MsgErro("Falha ao inserir vendedor " + loc_cUsar + ":" + ;
											CHR(13) + CapturarErroSQL(), "Erro SQL")
										loc_llOks = .F.
									ENDIF
								ENDIF
							ENDIF
							IF USED("crBusca")
								USE IN crBusca
							ENDIF
						ENDIF

						IF !loc_llOks
							EXIT
						ENDIF
					ENDSCAN

					IF VARTYPE(loc_oProg) = "O"
						loc_oProg.Update(.T.)
						IF PEMSTATUS(loc_oProg, "SubTitulo", 5)
							loc_oProg.SubTitulo.Caption = "Atualizando Os Registros"
						ENDIF
					ENDIF

					IF loc_llIns
						IF loc_llOks
							IF !EMPTY(loc_lcMsg)
								MsgAviso("N" + CHR(227) + "o Gerados: " + loc_lcMsg, ;
									"C" + CHR(243) + "pia Parcialmente Conclu" + CHR(237) + "da")
							ELSE
								MsgInfo("Os Registros Foram Gerados Com Sucesso!!!", ;
									"C" + CHR(243) + "pia Conclu" + CHR(237) + "da")
							ENDIF
							loc_lResultado = .T.
						ELSE
							MsgErro("Houve Uma Falha na Grava" + CHR(231) + CHR(227) + ;
								"o e Os Registros N" + CHR(195) + "O Foram Gerados!!!", "Erro!!!")
						ENDIF
					ELSE
						MsgAviso("Nenhum Registro Foi Gerado!!!", ;
							"C" + CHR(243) + "pia Conclu" + CHR(237) + "da Sem Sucesso")
					ENDIF

					IF VARTYPE(loc_oProg) = "O"
						loc_oProg.Complete()
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em CopiarPeriodo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		*-- Limpeza de cursores e conexao secundaria (FORA do TRY)
		IF USED("crOrigem")
			USE IN crOrigem
		ENDIF
		IF USED("crFopCff")
			USE IN crFopCff
		ENDIF
		IF USED("crBusca")
			USE IN crBusca
		ENDIF
		IF loc_nConnFP2 > 0
			SQLDISCONNECT(loc_nConnFP2)
		ENDIF

		RETURN loc_lResultado
	ENDPROC

ENDDEFINE

