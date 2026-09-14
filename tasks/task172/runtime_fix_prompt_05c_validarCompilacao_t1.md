# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05c_validarCompilacao
- Tentativa: 1/10
- Mensagem: C:\4c\projeto\app\classes\sigprdisBO.prg: COUNT FOR cursor_4c_Distribui.QtdDistr != 0 TO loc_nTotal IN cursor_4c_Distribui | Error in line 351: Command contains unrecognized phrase/keyword. | COUNT FOR cursor_4c_Disponivel.QtdSaldo < 0 TO loc_nNeg IN cursor_4c_Disponivel | Error in line 359: Command contains unrecognized phrase/keyword. | 

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprdis.prg):
*==============================================================================
* Formsigprdis.prg - Distribuicao de Produtos
* Migrado de: SIGPRDIS.SCX
* Herda de: FormBase
* Tipo: OPERACIONAL (frmcadastro com sub-pageframe 3 abas)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS Formsigprdis AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 621
    Width       = 996
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Estado do formulario
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - Inicializacao (FormBase.Init chama InicializarForm automaticamente)
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"

            THIS.this_oBusinessObject = CREATEOBJECT("sigprdisBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object sigprdisBO." + CHR(13) + ;
                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                         "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formulario:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - PageFrame principal externo (2 paginas: Lista/Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount       = 2
            .Top             = -29
            .Left            = 0
            .Width           = THIS.Width
            .Height          = THIS.Height + 29
            .Tabs            = .F.
            .Visible         = .T.
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(224, 224, 224)
            .Page2.BackColor = RGB(224, 224, 224)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1 com cabecalho, botoes CRUD, filtro e grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oCnt
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza escuro (cntSombra no legado)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
            .Top       = 15
            .Left      = 12
            .Width     = THIS.Width - 20
            .Height    = 40
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Botoes CRUD lado direito (Grupo_Op no legado: Left=542)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt = loc_oPagina.cnt_4c_Botoes

        loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
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

        loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
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

        loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
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

        loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
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

        *-- Container Encerrar - padrao canonico (Left=917 prevalece sobre SCX legado)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
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

        *-- Filtro de periodo (Label1.Top=89, Dt_inicial.Top=108, com compensacao +29)
        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo :"
            .Top       = 118
            .Left      = 35
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.txt_4c_DtInicial
            .Value       = DATE()
            .Top         = 137
            .Left        = 103
            .Width       = 80
            .Height      = 22
            .FontName    = "Tahoma"
            .FontSize    = 8
            .InputMask   = "99/99/9999"
            .Format      = "D"
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Separador", "Label")
        WITH loc_oPagina.lbl_4c_Separador
            .Caption   = "a"
            .Top       = 141
            .Left      = 190
            .Width     = 10
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DtFinal
            .Value       = DATE()
            .Top         = 137
            .Left        = 206
            .Width       = 80
            .Height      = 22
            .FontName    = "Tahoma"
            .FontSize    = 8
            .InputMask   = "99/99/9999"
            .Format      = "D"
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Grid principal (Grade no legado - SigPrDis via cursor_4c_Lista)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 2

        WITH loc_oPagina.grd_4c_Lista
            .Top                = 165
            .Left               = 24
            .Width              = 900
            .Height             = 420
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
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column1.Width           = 150
            .Column2.Header1.Caption = "Data"
            .Column2.Width           = 150
        ENDWITH

        *-- BINDEVENTs
        BINDEVENT(loc_oCnt.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oCnt.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oCnt.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oCnt.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.txt_4c_DtInicial, "LostFocus",     THIS, "DtInicialValid")
        BINDEVENT(loc_oPagina.txt_4c_DtFinal,   "KeyPress", THIS, "DtFinalLostFocus")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2 com botoes acao e sub-pageframe 3 abas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oCnt
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Botoes Confirmar/Cancelar (Grupo_Salva no legado: Left=842)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao

        loc_oCnt.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Salvar
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Cancelar
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

        BINDEVENT(loc_oCnt.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Sub-PageFrame 3 abas (Pageframe1 no legado: Top=6+29=35, Height=600)
        loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
        WITH loc_oPagina.pgf_4c_Dados
            .PageCount       = 3
            .Top             = 35
            .Left            = 0
            .Width           = THIS.Width
            .Height          = 600
            .Tabs            = .T.
            .Visible         = .T.
            .Page1.Caption   = "Estoques"
            .Page2.Caption   = "Distribui" + CHR(231) + CHR(227) + "o"
            .Page3.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
            .Page1.BackColor = RGB(224, 224, 224)
            .Page2.BackColor = RGB(224, 224, 224)
            .Page3.BackColor = RGB(224, 224, 224)
            .Page2.Enabled   = .F.
            .Page3.Enabled   = .F.
        ENDWITH

        THIS.ConfigurarAba1Estoques()
        THIS.ConfigurarAba2Distribuicao()
        THIS.ConfigurarAba3Operacoes()

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarAba1Estoques - Aba Estoques: grid SigCdCeg, marcar/desmarcar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAba1Estoques()
        LOCAL loc_oPage, loc_oGrid
        loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        *-- Botao Processar (top-right da aba - processar no legado: top=10, left=733)
        loc_oPage.AddObject("cmd_4c_Processar", "CommandButton")
        WITH loc_oPage.cmd_4c_Processar
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .PicturePosition = 13
            .Top             = 10
            .Left            = 733
            .Width           = 80
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

        BINDEVENT(loc_oPage.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

        *-- Label titulo da secao de estoques (Say5 no legado: top=189, left=338)
        loc_oPage.AddObject("lbl_4c_EstoquesTit", "Label")
        WITH loc_oPage.lbl_4c_EstoquesTit
            .Caption   = "Estoques para distribuir"
            .Top       = 189
            .Left      = 338
            .Width     = 200
            .Height    = 14
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontBold  = .T.
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Grid de Estoques (grdEstoque no legado: top=207, left=335, width=271, height=244)
        loc_oPage.AddObject("grd_4c_Estoque", "Grid")
        loc_oPage.grd_4c_Estoque.ColumnCount = 4

        WITH loc_oPage.grd_4c_Estoque
            .Top                = 207
            .Left               = 335
            .Width              = 271
            .Height             = 244
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
            .RowHeight          = 18
            .ScrollBars         = 2
            .GridLines          = 3
            .Visible            = .T.
            .Column1.Header1.Caption = ""
            .Column1.Width           = 25
            .Column2.Header1.Caption = "Empresa"
            .Column2.Width           = 80
            .Column3.Header1.Caption = "Grupo"
            .Column3.Width           = 80
            .Column4.Header1.Caption = "Conta"
            .Column4.Width           = 80
        ENDWITH

        *-- CheckBox em Column1 para toggle nMarca (Check1 no legado)
        loc_oGrid = loc_oPage.grd_4c_Estoque
        loc_oGrid.Column1.AddObject("chk_4c_nMarca", "CheckBox")
        WITH loc_oGrid.Column1.chk_4c_nMarca
            .Caption = ""
            .Width   = 22
            .Height  = 17
            .Left    = 2
            .Top     = 1
            .Value   = 0
            .Visible = .T.
        ENDWITH
        loc_oGrid.Column1.CurrentControl = "chk_4c_nMarca"

        *-- TextBox read-only nas colunas de dados (When=.F. no legado)
        loc_oGrid.Column2.AddObject("txt_4c_Empresa", "TextBox")
        loc_oGrid.Column2.txt_4c_Empresa.ReadOnly = .T.
        loc_oGrid.Column2.CurrentControl = "txt_4c_Empresa"

        loc_oGrid.Column3.AddObject("txt_4c_Grupo", "TextBox")
        loc_oGrid.Column3.txt_4c_Grupo.ReadOnly = .T.
        loc_oGrid.Column3.CurrentControl = "txt_4c_Grupo"

        loc_oGrid.Column4.AddObject("txt_4c_Conta", "TextBox")
        loc_oGrid.Column4.txt_4c_Conta.ReadOnly = .T.
        loc_oGrid.Column4.CurrentControl = "txt_4c_Conta"

        *-- CommandGroup Marcar/Desmarcar Todos (cmdMarcaDesmarca: top=351, left=617)
        loc_oPage.AddObject("cmg_4c_MarcaDesmarca", "CommandGroup")
        WITH loc_oPage.cmg_4c_MarcaDesmarca
            .ButtonCount         = 2
            .Top                 = 351
            .Left                = 617
            .Width               = 160
            .Height              = 100
            .Visible             = .T.
            .Buttons(1).Caption  = "Marcar" + CHR(13) + "Todos"
            .Buttons(1).Left     = 5
            .Buttons(1).Top      = 10
            .Buttons(1).Width    = 70
            .Buttons(1).Height   = 80
            .Buttons(1).FontName = "Comic Sans MS"
            .Buttons(1).FontBold = .T.
            .Buttons(1).FontSize = 8
            .Buttons(2).Caption  = "Desmarcar" + CHR(13) + "Todos"
            .Buttons(2).Left     = 82
            .Buttons(2).Top      = 10
            .Buttons(2).Width    = 70
            .Buttons(2).Height   = 80
            .Buttons(2).FontName = "Comic Sans MS"
            .Buttons(2).FontBold = .T.
            .Buttons(2).FontSize = 8
        ENDWITH

        BINDEVENT(loc_oPage.cmg_4c_MarcaDesmarca, "Click", THIS, "CmgMarcaDesmarcaClick")
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega grid com registros de SigPrDis no periodo
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid, loc_oPagina, loc_cSQL
        LOCAL loc_dDatai, loc_dDataf, loc_nRet, loc_oErro
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oPagina = THIS.pgf_4c_Paginas.Page1
                loc_oGrid   = loc_oPagina.grd_4c_Lista
                loc_dDatai  = loc_oPagina.txt_4c_DtInicial.Value
                loc_dDataf  = loc_oPagina.txt_4c_DtFinal.Value

                loc_cSQL = "SELECT DISTINCT Codigos, Datas FROM SigPrDis" + ;
                           " WHERE CAST(Datas AS DATE) BETWEEN" + ;
                           " CAST(" + FormatarDataSQL(loc_dDatai) + " AS DATE)" + ;
                           " AND CAST(" + FormatarDataSQL(loc_dDataf) + " AS DATE)"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")

                IF loc_nRet < 0
                    MsgErro("Erro ao carregar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource            = "cursor_4c_Lista"
                    loc_oGrid.Column1.ControlSource   = "cursor_4c_Lista.Codigos"
                    loc_oGrid.Column2.ControlSource   = "cursor_4c_Lista.Datas"
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Data"
                    loc_oGrid.Column1.Width           = 150
                    loc_oGrid.Column2.Width           = 150
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarEstoque - Carrega grd_4c_Estoque com SigCdCeg (estoques TpCads=3)
    *==========================================================================
    PROTECTED PROCEDURE CarregarEstoque()
        LOCAL loc_lResultado, loc_oGrid, loc_oPage, loc_cSQL, loc_nRet, loc_oErro
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                loc_oGrid = loc_oPage.grd_4c_Estoque

                IF USED("cursor_4c_Estoque")
                    USE IN cursor_4c_Estoque
                ENDIF

                loc_cSQL = "SELECT 0 AS nMarca, Cemps, CGrus, CCons" + ;
                           " FROM SigCdCeg WHERE TpCads = 3 ORDER BY Cemps"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Estoque")

                IF loc_nRet < 0
                    MsgErro("Erro ao carregar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Estoque"

                    loc_oGrid.Column1.chk_4c_nMarca.ControlSource  = "cursor_4c_Estoque.nMarca"
                    loc_oGrid.Column2.txt_4c_Empresa.ControlSource  = "cursor_4c_Estoque.Cemps"
                    loc_oGrid.Column3.txt_4c_Grupo.ControlSource    = "cursor_4c_Estoque.CGrus"
                    loc_oGrid.Column4.txt_4c_Conta.ControlSource    = "cursor_4c_Estoque.CCons"

                    loc_oGrid.Column1.Header1.Caption = ""
                    loc_oGrid.Column2.Header1.Caption = "Empresa"
                    loc_oGrid.Column3.Header1.Caption = "Grupo"
                    loc_oGrid.Column4.Header1.Caption = "Conta"

                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarEstoque:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            DO CASE
            CASE par_nPagina = 1
                THIS.CarregarLista()
            CASE par_nPagina = 2
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
                THIS.CarregarEstoque()
            ENDCASE

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DtInicialValid - Ajusta data final se data inicial for maior
    *==========================================================================
    PROCEDURE DtInicialValid()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        IF loc_oPagina.txt_4c_DtInicial.Value > loc_oPagina.txt_4c_DtFinal.Value
            loc_oPagina.txt_4c_DtFinal.Value = loc_oPagina.txt_4c_DtInicial.Value
        ENDIF
    ENDPROC

    *==========================================================================
    * DtFinalLostFocus - Ajusta data inicial e recarrega lista
    *==========================================================================
    PROCEDURE DtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        IF loc_oPagina.txt_4c_DtFinal.Value < loc_oPagina.txt_4c_DtInicial.Value
            loc_oPagina.txt_4c_DtInicial.Value = loc_oPagina.txt_4c_DtFinal.Value
        ENDIF

        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Abre Page2 para novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Abre Page2 para visualizacao do registro selecionado
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Lista
        loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre Page2 para alterar registro selecionado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Lista
        loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
            MsgAviso("Nenhum registro selecionado.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Lista
        loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da distribui" + ;
                        CHR(231) + CHR(227) + "o " + loc_cCodigo + "?", ;
                        "Confirmar Exclus" + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Distribui" + CHR(231) + CHR(227) + "o exclu" + ;
                        CHR(237) + "da com sucesso.", "")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega lista com filtro de periodo atual
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva lote (se ainda nao processado) e retorna para lista
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lOK
        loc_lOK = .F.

        IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)) ;
           AND !THIS.this_oBusinessObject.this_lEmEdicao
            *-- Lote ja foi salvo via BtnProcessarFinalClick
            loc_lOK = .T.
        ELSE
            IF THIS.this_oBusinessObject.SalvarLote()
                MsgInfo("Distribui" + CHR(231) + CHR(227) + "o salva com sucesso.", "")
                loc_lOK = .T.
            ENDIF
        ENDIF

        IF loc_lOK
            THIS.AlternarPagina(1)
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * CmgMarcaDesmarcaClick - Marca ou desmarca todos os estoques no cursor
    *==========================================================================
    PROCEDURE CmgMarcaDesmarcaClick()
        LOCAL loc_oPage, loc_nVal, loc_oErro
        loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        TRY
            loc_nVal = loc_oPage.cmg_4c_MarcaDesmarca.Value

            IF USED("cursor_4c_Estoque")
                IF loc_nVal = 1
                    REPLACE ALL nMarca WITH 1 IN cursor_4c_Estoque
                ELSE
                    REPLACE ALL nMarca WITH 0 IN cursor_4c_Estoque
                ENDIF
                loc_oPage.grd_4c_Estoque.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CmgMarcaDesmarcaClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Processa selecao de estoques e abre aba Distribuicao
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oErro

        IF !USED("cursor_4c_Estoque") OR RECCOUNT("cursor_4c_Estoque") = 0
            MsgAviso("Nenhum estoque dispon" + CHR(237) + "vel para processar.", "Processar")
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.ProcessarDistribuicao("cursor_4c_Estoque")
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.Enabled = .T.
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.Enabled = .T.
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage    = 2
                THIS.CarregarDisponivel()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em BtnProcessarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *==========================================================================
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
    * FormatarGridLista - Formata visual do grid (fonte Verdana padrao fwgrade)
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAba2Distribuicao - Aba Distribuicao: imagem, filtros e grids
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAba2Distribuicao()
        LOCAL loc_oPage, loc_oGrid
        loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        *-- Shape borda ao redor da imagem (Shape5: top=5, left=4, width=163, height=93)
        loc_oPage.AddObject("shp_4c_FigBorda", "Shape")
        WITH loc_oPage.shp_4c_FigBorda
            .Top         = 5
            .Left        = 4
            .Width       = 163
            .Height      = 93
            .BorderColor = RGB(128, 128, 128)
            .BorderWidth = 1
            .BorderStyle = 1
            .FillStyle   = 1
            .Visible     = .T.
        ENDWITH

        *-- Imagem do produto (FigJpg: top=7, left=6, width=159, height=89)
        loc_oPage.AddObject("img_4c_FigJpg", "Image")
        WITH loc_oPage.img_4c_FigJpg
            .Top     = 7
            .Left    = 6
            .Width   = 159
            .Height  = 89
            .Stretch = 2
            .Visible = .T.
        ENDWITH

        *-- Label "Grupo :" (Say9: top=59, left=174, width=38)
        loc_oPage.AddObject("lbl_4c_GrupoDist", "Label")
        WITH loc_oPage.lbl_4c_GrupoDist
            .Caption   = "Grupo :"
            .Top       = 59
            .Left      = 174
            .Width     = 38
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo grupo (get_cgrupo: top=74, left=175, width=35)
        loc_oPage.AddObject("txt_4c_CodGrupoDist", "TextBox")
        WITH loc_oPage.txt_4c_CodGrupoDist
            .Value       = ""
            .Top         = 74
            .Left        = 175
            .Width       = 35
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- TextBox descricao grupo (get_dgrupo: top=74, left=211, width=208)
        loc_oPage.AddObject("txt_4c_DscGrupoDist", "TextBox")
        WITH loc_oPage.txt_4c_DscGrupoDist
            .Value       = ""
            .Top         = 74
            .Left        = 211
            .Width       = 208
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Label "Subgrupo :" (Say11: top=100, left=174, width=55)
        loc_oPage.AddObject("lbl_4c_SgrupoDist", "Label")
        WITH loc_oPage.lbl_4c_SgrupoDist
            .Caption   = "Subgrupo :"
            .Top       = 100
            .Left      = 174
            .Width     = 55
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo subgrupo (get_csgrupo: top=115, left=175, width=52)
        loc_oPage.AddObject("txt_4c_CodSgrupoDist", "TextBox")
        WITH loc_oPage.txt_4c_CodSgrupoDist
            .Value       = ""
            .Top         = 115
            .Left        = 175
            .Width       = 52
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- TextBox descricao subgrupo (get_dsgrupo: top=115, left=228, width=236)
        loc_oPage.AddObject("txt_4c_DscSgrupoDist", "TextBox")
        WITH loc_oPage.txt_4c_DscSgrupoDist
            .Value       = ""
            .Top         = 115
            .Left        = 228
            .Width       = 236
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Botao Filtrar (Filtrar: top=73, left=424, width=40, height=40)
        loc_oPage.AddObject("cmd_4c_Filtrar", "CommandButton")
        WITH loc_oPage.cmd_4c_Filtrar
            .Caption         = "Filtrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 73
            .Left            = 424
            .Width           = 40
            .Height          = 40
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontSize        = 7
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Label "Procurar" (lbl_produto: top=100, left=4, width=43)
        loc_oPage.AddObject("lbl_4c_ProdutoProc", "Label")
        WITH loc_oPage.lbl_4c_ProdutoProc
            .Caption   = "Procurar"
            .Top       = 100
            .Left      = 4
            .Width     = 43
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox produto inicial (get_produto_inicial: top=116, left=2, width=108, height=22)
        loc_oPage.AddObject("txt_4c_ProdutoInicial", "TextBox")
        WITH loc_oPage.txt_4c_ProdutoInicial
            .Value       = ""
            .Top         = 116
            .Left        = 2
            .Width       = 108
            .Height      = 22
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Grid Disponivel (grdDisponivel: top=141, left=1, width=663, height=327, 7 colunas)
        loc_oPage.AddObject("grd_4c_Disponivel", "Grid")
        loc_oPage.grd_4c_Disponivel.ColumnCount = 7

        WITH loc_oPage.grd_4c_Disponivel
            .Top                = 141
            .Left               = 1
            .Width              = 663
            .Height             = 327
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
            .RowHeight          = 18
            .ScrollBars         = 2
            .GridLines          = 3
            .Visible            = .T.
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column1.Width           = 90
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width           = 200
            .Column3.Header1.Caption = "Cor"
            .Column3.Width           = 60
            .Column4.Header1.Caption = "Tam"
            .Column4.Width           = 40
            .Column5.Header1.Caption = "Estoque"
            .Column5.Width           = 70
            .Column6.Header1.Caption = "Saldo"
            .Column6.Width           = 70
            .Column7.Header1.Caption = "Distribu" + CHR(237) + "do"
            .Column7.Width           = 70
        ENDWITH

        *-- Controles read-only nas colunas (When=.F. no legado)
        loc_oGrid = loc_oPage.grd_4c_Disponivel

        loc_oGrid.Column1.AddObject("txt_4c_Cod01", "TextBox")
        loc_oGrid.Column1.txt_4c_Cod01.ReadOnly = .T.
        loc_oGrid.Column1.CurrentControl = "txt_4c_Cod01"

        loc_oGrid.Column2.AddObject("txt_4c_Dsc02", "TextBox")
        loc_oGrid.Column2.txt_4c_Dsc02.ReadOnly = .T.
        loc_oGrid.Column2.CurrentControl = "txt_4c_Dsc02"

        loc_oGrid.Column3.AddObject("txt_4c_Cor03", "TextBox")
        loc_oGrid.Column3.txt_4c_Cor03.ReadOnly = .T.
        loc_oGrid.Column3.CurrentControl = "txt_4c_Cor03"

        loc_oGrid.Column4.AddObject("txt_4c_Tam04", "TextBox")
        loc_oGrid.Column4.txt_4c_Tam04.ReadOnly = .T.
        loc_oGrid.Column4.CurrentControl = "txt_4c_Tam04"

        loc_oGrid.Column5.AddObject("txt_4c_Est05", "TextBox")
        loc_oGrid.Column5.txt_4c_Est05.ReadOnly = .T.
        loc_oGrid.Column5.CurrentControl = "txt_4c_Est05"

        loc_oGrid.Column6.AddObject("txt_4c_Sal06", "TextBox")
        loc_oGrid.Column6.txt_4c_Sal06.ReadOnly = .T.
        loc_oGrid.Column6.CurrentControl = "txt_4c_Sal06"

        loc_oGrid.Column7.AddObject("txt_4c_Dis07", "TextBox")
        loc_oGrid.Column7.txt_4c_Dis07.ReadOnly = .T.
        loc_oGrid.Column7.CurrentControl = "txt_4c_Dis07"

        *-- Grid Distribui (grdDistribui: top=141, left=664, width=334, height=327, 4 colunas)
        loc_oPage.AddObject("grd_4c_Distribui", "Grid")
        loc_oPage.grd_4c_Distribui.ColumnCount = 4

        WITH loc_oPage.grd_4c_Distribui
            .Top                = 141
            .Left               = 664
            .Width              = 334
            .Height             = 327
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
            .RowHeight          = 18
            .ScrollBars         = 2
            .GridLines          = 3
            .Visible            = .T.
            .Column1.Header1.Caption = "Empresa"
            .Column1.Width           = 60
            .Column2.Header1.Caption = "Saldo"
            .Column2.Width           = 70
            .Column3.Header1.Caption = "Distribu" + CHR(237) + "do"
            .Column3.Width           = 80
            .Column4.Header1.Caption = "Local"
            .Column4.Width           = 90
        ENDWITH

        *-- Col1/Col2 read-only; Col3 editavel (QtdDistr); Col4 editavel com lookup Local
        loc_oGrid = loc_oPage.grd_4c_Distribui

        loc_oGrid.Column1.AddObject("txt_4c_Emp01", "TextBox")
        loc_oGrid.Column1.txt_4c_Emp01.ReadOnly = .T.
        loc_oGrid.Column1.CurrentControl = "txt_4c_Emp01"

        loc_oGrid.Column2.AddObject("txt_4c_Sal02", "TextBox")
        loc_oGrid.Column2.txt_4c_Sal02.ReadOnly = .T.
        loc_oGrid.Column2.CurrentControl = "txt_4c_Sal02"

        loc_oGrid.Column3.AddObject("txt_4c_Dis03", "TextBox")
        loc_oGrid.Column3.CurrentControl = "txt_4c_Dis03"

        loc_oGrid.Column4.AddObject("txt_4c_Loc04", "TextBox")
        loc_oGrid.Column4.CurrentControl = "txt_4c_Loc04"

        *-- Painel de info produto (somente leitura) -- top 470-540
        *-- Row 1: Grupo / Linha (top=470-474)
        loc_oPage.AddObject("lbl_4c_GrupoInfo", "Label")
        WITH loc_oPage.lbl_4c_GrupoInfo
            .Caption   = "Grupo :"
            .Top       = 474
            .Left      = 67
            .Width     = 38
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
        ENDWITH

        loc_oPage.AddObject("txt_4c_CdGrupoInfo", "TextBox")
        WITH loc_oPage.txt_4c_CdGrupoInfo
            .Value    = ""
            .Top      = 470
            .Left     = 116
            .Width    = 65
            .Height   = 21
            .ReadOnly = .T.
        ENDWITH

        loc_oPage.AddObject("txt_4c_DsGrupoInfo", "TextBox")
        WITH loc_oPage.txt_4c_DsGrupoInfo
            .Value    = ""
            .Top      = 470
            .Left     = 182
            .Width    = 270
            .Height   = 21
            .ReadOnly = .T.
        ENDWITH

        loc_oPage.AddObject("lbl_4c_LinhaInfo", "Label")
        WITH loc_oPage.lbl_4c_LinhaInfo
            .Caption   = "Linha :"
            .Top       = 473
            .Left      = 549
            .Width     = 34
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
        ENDWITH

        loc_oPage.AddObject("txt_4c_CdLinhaInfo", "TextBox")
        WITH loc_oPage.txt_4c_CdLinhaInfo
            .Value    = ""
            .Top      = 470
            .Left     = 593
            .Width    = 80
            .Height   = 21
            .ReadOnly = .T.
        ENDWITH

        loc_oPage.AddObject("txt_4c_DsLinhaInfo", "TextBox")
        WITH loc_oPage.txt_4c_DsLinhaInfo
            .Value    = ""
            .Top      = 470
            .Left     = 674
            .Width    = 255
            .Height   = 21
            .ReadOnly = .T.
        ENDWITH

        *-- Row 2: Subgrupo / Fornecedor (top=492-497)
        loc_oPage.AddObject("lbl_4c_SgrupoInfo", "Label")
        WITH loc_oPage.lbl_4c_SgrupoInfo
            .Caption   = "Subgrupo :"
            .Top       = 497
            .Left      = 50
            .Width     = 55
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
        ENDWITH

        loc_oPage.AddObject("txt_4c_CdSgrupoInfo", "TextBox")
        WITH loc_oPage.txt_4c_CdSgrupoInfo
            .Value    = ""
            .Top      = 492
            .Left     = 116
            .Width    = 65
            .Height   = 21
            .ReadOnly = .T.
        ENDWITH

        loc_oPage.AddObject("txt_4c_DsSgrupoInfo", "TextBox")
        WITH loc_oPage.txt_4c_DsSgrupoInfo
            .Value    = ""
            .Top      = 492
            .Left     = 182
            .Width    = 270
            .Height   = 21
            .ReadOnly = .T.
        ENDWITH

        loc_oPage.AddObject("lbl_4c_FornInfo", "Label")
        WITH loc_oPage.lbl_4c_FornInfo
            .Caption   = "Fornecedor :"
            .Top       = 495
            .Left      = 519
            .Width     = 64
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
        ENDWITH

        loc_oPage.AddObject("txt_4c_CdFornInfo", "TextBox")
        WITH loc_oPage.txt_4c_CdFornInfo
            .Value    = ""
            .Top      = 492
            .Left     = 593
            .Width    = 80
            .Height   = 21
            .ReadOnly = .T.
        ENDWITH

        loc_oPage.AddObject("txt_4c_DsFornInfo", "TextBox")
        WITH loc_oPage.txt_4c_DsFornInfo
            .Value    = ""
            .Top      = 492
            .Left     = 674
            .Width    = 255
            .Height   = 21
            .ReadOnly = .T.
        ENDWITH

        *-- Row 3: Modelo / Ref.Fornecedor (top=514-517)
        loc_oPage.AddObject("lbl_4c_ModeloInfo", "Label")
        WITH loc_oPage.lbl_4c_ModeloInfo
            .Caption   = "Modelo :"
            .Top       = 517
            .Left      = 62
            .Width     = 43
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
        ENDWITH

        loc_oPage.AddObject("txt_4c_CodModeloInfo", "TextBox")
        WITH loc_oPage.txt_4c_CodModeloInfo
            .Value    = ""
            .Top      = 514
            .Left     = 116
            .Width    = 65
            .Height   = 21
            .ReadOnly = .T.
        ENDWITH

        loc_oPage.AddObject("txt_4c_DsModeloInfo", "TextBox")
        WITH loc_oPage.txt_4c_DsModeloInfo
            .Value    = ""
            .Top      = 514
            .Left     = 182
            .Width    = 270
            .Height   = 21
            .ReadOnly = .T.
        ENDWITH

        loc_oPage.AddObject("lbl_4c_RefFornInfo", "Label")
        WITH loc_oPage.lbl_4c_RefFornInfo
            .Caption   = "Ref. Fornecedor :"
            .Top       = 517
            .Left      = 495
            .Width     = 88
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
        ENDWITH

        loc_oPage.AddObject("txt_4c_RefFornInfo", "TextBox")
        WITH loc_oPage.txt_4c_RefFornInfo
            .Value    = ""
            .Top      = 514
            .Left     = 593
            .Width    = 190
            .Height   = 21
            .ReadOnly = .T.
        ENDWITH

        *-- Row 4: Grupo de Venda / Preco Venda / Peso (top=536-540)
        loc_oPage.AddObject("lbl_4c_GrVendaInfo", "Label")
        WITH loc_oPage.lbl_4c_GrVendaInfo
            .Caption   = "Grupo de Venda :"
            .Top       = 540
            .Left      = 19
            .Width     = 86
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
        ENDWITH

        loc_oPage.AddObject("txt_4c_CdGrVendaInfo", "TextBox")
        WITH loc_oPage.txt_4c_CdGrVendaInfo
            .Value    = ""
            .Top      = 537
            .Left     = 116
            .Width    = 80
            .Height   = 21
            .ReadOnly = .T.
        ENDWITH

        loc_oPage.AddObject("txt_4c_DsGrVendaInfo", "TextBox")
        WITH loc_oPage.txt_4c_DsGrVendaInfo
            .Value    = ""
            .Top      = 537
            .Left     = 197
            .Width    = 255
            .Height   = 21
            .ReadOnly = .T.
        ENDWITH

        loc_oPage.AddObject("lbl_4c_PrVendaInfo", "Label")
        WITH loc_oPage.lbl_4c_PrVendaInfo
            .Caption   = "Pre" + CHR(231) + "o Venda :"
            .Top       = 540
            .Left      = 514
            .Width     = 69
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
        ENDWITH

        loc_oPage.AddObject("txt_4c_PrVendaInfo", "TextBox")
        WITH loc_oPage.txt_4c_PrVendaInfo
            .Value    = ""
            .Top      = 536
            .Left     = 593
            .Width    = 108
            .Height   = 22
            .ReadOnly = .T.
        ENDWITH

        loc_oPage.AddObject("txt_4c_PrVendaMoeInfo", "TextBox")
        WITH loc_oPage.txt_4c_PrVendaMoeInfo
            .Value    = ""
            .Top      = 536
            .Left     = 703
            .Width    = 31
            .Height   = 22
            .ReadOnly = .T.
        ENDWITH

        loc_oPage.AddObject("lbl_4c_PesoInfo", "Label")
        WITH loc_oPage.lbl_4c_PesoInfo
            .Caption   = "Peso :"
            .Top       = 540
            .Left      = 775
            .Width     = 38
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
        ENDWITH

        loc_oPage.AddObject("txt_4c_PesoMedioInfo", "TextBox")
        WITH loc_oPage.txt_4c_PesoMedioInfo
            .Value    = ""
            .Top      = 537
            .Left     = 816
            .Width    = 75
            .Height   = 21
            .ReadOnly = .T.
        ENDWITH

        *-- BINDEVENTs
        BINDEVENT(loc_oPage.grd_4c_Disponivel, "AfterRowColChange", ;
            THIS, "GrdDisponivelAfterRowColChange")
        BINDEVENT(loc_oPage.grd_4c_Distribui.Column3.txt_4c_Dis03, ;
            "LostFocus", THIS, "DistribuidoLostFocus")
        BINDEVENT(loc_oPage.grd_4c_Distribui.Column4.txt_4c_Loc04, ;
            "Valid", THIS, "LocalDistribuidoValid")
        BINDEVENT(loc_oPage.txt_4c_CodGrupoDist,   "KeyPress", THIS, "GrupoCodDistValid")
        BINDEVENT(loc_oPage.txt_4c_DscGrupoDist,   "KeyPress", THIS, "GrupoDscDistValid")
        BINDEVENT(loc_oPage.txt_4c_CodSgrupoDist,  "KeyPress", THIS, "SgrupoCodDistValid")
        BINDEVENT(loc_oPage.txt_4c_DscSgrupoDist,  "KeyPress", THIS, "SgrupoDscDistValid")
        BINDEVENT(loc_oPage.cmd_4c_Filtrar,        "Click", THIS, "FiltrarDisponivelClick")
        BINDEVENT(loc_oPage.txt_4c_ProdutoInicial, "LostFocus", THIS, "ProdutoInicialValid")

        THIS.TornarControlesVisiveis(loc_oPage)
    ENDPROC

    *==========================================================================
    * CarregarDisponivel - Vincula grd_4c_Disponivel ao cursor_4c_Disponivel
    *==========================================================================
    PROTECTED PROCEDURE CarregarDisponivel()
        LOCAL loc_lResultado, loc_oGrid, loc_oPage, loc_oErro
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_Disponivel")
                loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
                loc_oGrid = loc_oPage.grd_4c_Disponivel

                loc_oGrid.ColumnCount = 7
                loc_oGrid.RecordSource = "cursor_4c_Disponivel"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Disponivel.Cpros"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Disponivel.Dpros"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Disponivel.CodCors"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Disponivel.CodTams"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Disponivel.Sqtds"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
                loc_oGrid.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"

                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "Cor"
                loc_oGrid.Column4.Header1.Caption = "Tam"
                loc_oGrid.Column5.Header1.Caption = "Estoque"
                loc_oGrid.Column6.Header1.Caption = "Saldo"
                loc_oGrid.Column7.Header1.Caption = "Distribu" + CHR(237) + "do"

                THIS.FormatarGridLista(loc_oGrid)
                loc_oGrid.Refresh()

                THIS.CarregarDistribui()

                loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarDisponivel:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDistribui - Vincula grd_4c_Distribui ao cursor_4c_Distribui
    *==========================================================================
    PROTECTED PROCEDURE CarregarDistribui()
        LOCAL loc_lResultado, loc_oGrid, loc_oPage, loc_oErro
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_Distribui")
                loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
                loc_oGrid = loc_oPage.grd_4c_Distribui

                loc_oGrid.ColumnCount = 4
                loc_oGrid.RecordSource = "cursor_4c_Distribui"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Distribui.Cemps"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Distribui.QtdSaldo"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Distribui.QtdDistr"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Distribui.CidChaves"

                loc_oGrid.Column1.Header1.Caption = "Empresa"
                loc_oGrid.Column2.Header1.Caption = "Saldo"
                loc_oGrid.Column3.Header1.Caption = "Distribu" + CHR(237) + "do"
                loc_oGrid.Column4.Header1.Caption = "Local"

                THIS.FormatarGridLista(loc_oGrid)
                loc_oGrid.Refresh()

                loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarDistribui:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GrdDisponivelAfterRowColChange - Filtra grd_4c_Distribui pelo produto atual
    *==========================================================================
    PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
        LOCAL loc_cCodPro, loc_oPage, loc_oErro

        TRY
            IF USED("cursor_4c_Disponivel") AND !EOF("cursor_4c_Disponivel") ;
               AND USED("cursor_4c_Distribui")
                SELECT cursor_4c_Disponivel
                loc_cCodPro = ALLTRIM(cursor_4c_Disponivel.Cpros)
                SELECT cursor_4c_Distribui
                SET FILTER TO ALLTRIM(Cpros) = loc_cCodPro
                GO TOP IN cursor_4c_Distribui
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Distribui.Refresh()
                THIS.PopularInfoProduto(loc_cCodPro)
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em GrdDisponivelAfterRowColChange:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * DistribuidoLostFocus - Recalcula saldo ao sair do campo Distribuido
    *==========================================================================
    PROCEDURE DistribuidoLostFocus()
        THIS.CalcularSaldo()
    ENDPROC

    *==========================================================================
    * CalcularSaldo - Recalcula QtdSaida e QtdSaldo no cursor_4c_Disponivel
    *==========================================================================
    PROCEDURE CalcularSaldo()
        LOCAL loc_nQtdTotal, loc_cCodPro, loc_oPage, loc_oErro

        TRY
            IF !USED("cursor_4c_Disponivel") OR !USED("cursor_4c_Distribui")
                loc_oErro = .NULL.
            ELSE
                IF !EOF("cursor_4c_Disponivel")
                    SELECT cursor_4c_Disponivel
                    loc_cCodPro = ALLTRIM(cursor_4c_Disponivel.Cpros)

                    SUM cursor_4c_Distribui.QtdDistr ;
                        FOR ALLTRIM(cursor_4c_Distribui.Cpros) = loc_cCodPro ;
                        TO loc_nQtdTotal

                    SELECT cursor_4c_Disponivel
                    REPLACE cursor_4c_Disponivel.QtdSaida WITH loc_nQtdTotal, ;
                            cursor_4c_Disponivel.QtdSaldo  WITH ;
                                cursor_4c_Disponivel.Sqtds - loc_nQtdTotal

                    IF cursor_4c_Disponivel.QtdSaldo < 0
                        MsgAviso("Saldo insuficiente para movimentar." + CHR(13) + ;
                                 "O valor excede o estoque dispon" + CHR(237) + "vel.", ;
                                 "Saldo Insuficiente")
                        SELECT cursor_4c_Distribui
                        REPLACE cursor_4c_Distribui.QtdDistr WITH 0 FOR ;
                            ALLTRIM(cursor_4c_Distribui.Cpros) = loc_cCodPro

                        SUM cursor_4c_Distribui.QtdDistr ;
                            FOR ALLTRIM(cursor_4c_Distribui.Cpros) = loc_cCodPro ;
                            TO loc_nQtdTotal

                        SELECT cursor_4c_Disponivel
                        REPLACE cursor_4c_Disponivel.QtdSaida WITH loc_nQtdTotal, ;
                                cursor_4c_Disponivel.QtdSaldo  WITH ;
                                    cursor_4c_Disponivel.Sqtds - loc_nQtdTotal
                    ENDIF

                    loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
                    loc_oPage.grd_4c_Disponivel.Refresh()
                    loc_oPage.grd_4c_Distribui.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CalcularSaldo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LocalDistribuidoValid - Lookup localizacao SigPrLcl (Column4 grdDistribui)
    *==========================================================================
    PROCEDURE LocalDistribuidoValid()
        LOCAL loc_oBusca, loc_cValor, loc_oPage, loc_oErro

        TRY
            loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_cValor = ALLTRIM(loc_oPage.grd_4c_Distribui.Column4.txt_4c_Loc04.Value)

            IF !EMPTY(loc_cValor)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigPrLcl", "cursor_4c_BuscaLocal", "Codigos", loc_cValor, ;
                    "Localiza" + CHR(231) + CHR(227) + "o")

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                        IF USED("cursor_4c_BuscaLocal")
                            REPLACE cursor_4c_Distribui.CidChaves WITH ;
                                ALLTRIM(cursor_4c_BuscaLocal.Codigos)
                        ENDIF
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
                            REPLACE cursor_4c_Distribui.CidChaves WITH ;
                                ALLTRIM(cursor_4c_BuscaLocal.Codigos)
                        ENDIF
                    ELSE
                        REPLACE cursor_4c_Distribui.CidChaves WITH ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaLocal")
                    USE IN cursor_4c_BuscaLocal
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em LocalDistribuidoValid:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrupoCodDistValid - Lookup grupo por codigo (SigCdGrp.CGrus)
    *==========================================================================
    PROCEDURE GrupoCodDistValid(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_cCod, loc_oPage, loc_oErro

        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_cCod  = ALLTRIM(loc_oPage.txt_4c_CodGrupoDist.Value)

            IF EMPTY(loc_cCod)
                loc_oPage.txt_4c_DscGrupoDist.Value = ""
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cCod, ;
                    "Grupos de Produto")

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                        IF USED("cursor_4c_BuscaGrp")
                            loc_oPage.txt_4c_CodGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                            loc_oPage.txt_4c_DscGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
                        ENDIF
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                            loc_oPage.txt_4c_CodGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                            loc_oPage.txt_4c_DscGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
                        ENDIF
                    ELSE
                        loc_oPage.txt_4c_CodGrupoDist.Value = ""
                        loc_oPage.txt_4c_DscGrupoDist.Value = ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaGrp")
                    USE IN cursor_4c_BuscaGrp
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em GrupoCodDistValid:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrupoDscDistValid - Lookup grupo por descricao (SigCdGrp.DGrus)
    *==========================================================================
    PROCEDURE GrupoDscDistValid(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_cDsc, loc_oPage, loc_oErro

        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_cDsc  = ALLTRIM(loc_oPage.txt_4c_DscGrupoDist.Value)

            IF EMPTY(loc_cDsc)
                loc_oPage.txt_4c_CodGrupoDist.Value = ""
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGrp", "cursor_4c_BuscaGrp", "DGrus", loc_cDsc, ;
                    "Grupos de Produto")

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                        IF USED("cursor_4c_BuscaGrp")
                            loc_oPage.txt_4c_CodGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                            loc_oPage.txt_4c_DscGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
                        ENDIF
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                            loc_oPage.txt_4c_CodGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                            loc_oPage.txt_4c_DscGrupoDist.Value = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
                        ENDIF
                    ELSE
                        loc_oPage.txt_4c_CodGrupoDist.Value = ""
                        loc_oPage.txt_4c_DscGrupoDist.Value = ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaGrp")
                    USE IN cursor_4c_BuscaGrp
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em GrupoDscDistValid:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * SgrupoCodDistValid - Lookup subgrupo por codigo (SigCdPsg.Codigos)
    *==========================================================================
    PROCEDURE SgrupoCodDistValid(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_cCod, loc_oPage, loc_oErro

        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_cCod  = ALLTRIM(loc_oPage.txt_4c_CodSgrupoDist.Value)

            IF EMPTY(loc_cCod)
                loc_oPage.txt_4c_DscSgrupoDist.Value = ""
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPsg", "cursor_4c_BuscaSgrp", "Codigos", loc_cCod, ;
                    "Sub-Grupos")

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                        IF USED("cursor_4c_BuscaSgrp")
                            loc_oPage.txt_4c_CodSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Codigos)
                            loc_oPage.txt_4c_DscSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Descricaos)
                        ENDIF
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSgrp")
                            loc_oPage.txt_4c_CodSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Codigos)
                            loc_oPage.txt_4c_DscSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Descricaos)
                        ENDIF
                    ELSE
                        loc_oPage.txt_4c_CodSgrupoDist.Value = ""
                        loc_oPage.txt_4c_DscSgrupoDist.Value = ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaSgrp")
                    USE IN cursor_4c_BuscaSgrp
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em SgrupoCodDistValid:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * SgrupoDscDistValid - Lookup subgrupo por descricao (SigCdPsg.Descricaos)
    *==========================================================================
    PROCEDURE SgrupoDscDistValid(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_cDsc, loc_oPage, loc_oErro

        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_cDsc  = ALLTRIM(loc_oPage.txt_4c_DscSgrupoDist.Value)

            IF EMPTY(loc_cDsc)
                loc_oPage.txt_4c_CodSgrupoDist.Value = ""
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPsg", "cursor_4c_BuscaSgrp", "Descricaos", loc_cDsc, ;
                    "Sub-Grupos")

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                        IF USED("cursor_4c_BuscaSgrp")
                            loc_oPage.txt_4c_CodSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Codigos)
                            loc_oPage.txt_4c_DscSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Descricaos)
                        ENDIF
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSgrp")
                            loc_oPage.txt_4c_CodSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Codigos)
                            loc_oPage.txt_4c_DscSgrupoDist.Value = ALLTRIM(cursor_4c_BuscaSgrp.Descricaos)
                        ENDIF
                    ELSE
                        loc_oPage.txt_4c_CodSgrupoDist.Value = ""
                        loc_oPage.txt_4c_DscSgrupoDist.Value = ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaSgrp")
                    USE IN cursor_4c_BuscaSgrp
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em SgrupoDscDistValid:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FiltrarDisponivelClick - Filtra grd_4c_Disponivel por grupo e/ou subgrupo
    *==========================================================================
    PROCEDURE FiltrarDisponivelClick()
        LOCAL loc_cCodGrp, loc_cCodSgrp, loc_oPage, loc_oErro

        TRY
            IF USED("cursor_4c_Disponivel")
                loc_oPage    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
                loc_cCodGrp  = ALLTRIM(loc_oPage.txt_4c_CodGrupoDist.Value)
                loc_cCodSgrp = ALLTRIM(loc_oPage.txt_4c_CodSgrupoDist.Value)

                SELECT cursor_4c_Disponivel

                IF EMPTY(loc_cCodGrp) AND EMPTY(loc_cCodSgrp)
                    SET FILTER TO
                ELSE
                    IF !EMPTY(loc_cCodGrp) AND EMPTY(loc_cCodSgrp)
                    SET FILTER TO ALLTRIM(Cgrus) = loc_cCodGrp
                ELSE
                    IF EMPTY(loc_cCodGrp) AND !EMPTY(loc_cCodSgrp)
                    SET FILTER TO ALLTRIM(Sgrus) = loc_cCodSgrp
                ELSE
                    SET FILTER TO ALLTRIM(Cgrus) = loc_cCodGrp ;
                                  AND ALLTRIM(Sgrus) = loc_cCodSgrp
                    ENDIF
                    ENDIF
                ENDIF

                GO TOP IN cursor_4c_Disponivel
                loc_oPage.grd_4c_Disponivel.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em FiltrarDisponivelClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ProdutoInicialValid - Navega grd_4c_Disponivel para o produto informado
    *==========================================================================
    PROCEDURE ProdutoInicialValid()
        LOCAL loc_cProd, loc_oPage, loc_oErro

        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_cProd = ALLTRIM(loc_oPage.txt_4c_ProdutoInicial.Value)

            IF !EMPTY(loc_cProd) AND USED("cursor_4c_Disponivel")
                SELECT cursor_4c_Disponivel
                GO TOP
                LOCATE FOR ALLTRIM(Cpros) >= loc_cProd
                IF !EOF("cursor_4c_Disponivel")
                    loc_oPage.grd_4c_Disponivel.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ProdutoInicialValid:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PopularInfoProduto - Preenche o painel info com dados do produto selecionado
    *==========================================================================
    PROCEDURE PopularInfoProduto(par_cCodPro)
        LOCAL loc_oPage, loc_cSQL, loc_nRet, loc_oErro

        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

            loc_oPage.txt_4c_CdGrupoInfo.Value    = ""
            loc_oPage.txt_4c_DsGrupoInfo.Value    = ""
            loc_oPage.txt_4c_CdSgrupoInfo.Value   = ""
            loc_oPage.txt_4c_DsSgrupoInfo.Value   = ""
            loc_oPage.txt_4c_CdFornInfo.Value     = ""
            loc_oPage.txt_4c_DsFornInfo.Value     = ""
            loc_oPage.txt_4c_RefFornInfo.Value    = ""
            loc_oPage.txt_4c_PrVendaInfo.Value    = ""
            loc_oPage.txt_4c_PrVendaMoeInfo.Value = ""
            loc_oPage.txt_4c_PesoMedioInfo.Value  = ""
            loc_oPage.txt_4c_CdGrVendaInfo.Value  = ""
            loc_oPage.txt_4c_DsGrVendaInfo.Value  = ""
            loc_oPage.txt_4c_CdLinhaInfo.Value    = ""
            loc_oPage.txt_4c_DsLinhaInfo.Value    = ""
            loc_oPage.txt_4c_CodModeloInfo.Value  = ""
            loc_oPage.txt_4c_DsModeloInfo.Value   = ""

            IF !EMPTY(ALLTRIM(par_cCodPro))
                loc_cSQL = "SELECT RTRIM(a.cgrus) AS cgrus, " + ;
                    "RTRIM(ISNULL(g.dgrus,'')) AS dgrus, " + ;
                    "RTRIM(a.sgrus) AS sgrus, " + ;
                    "RTRIM(ISNULL(sg.descricaos,'')) AS dsgrus, " + ;
                    "RTRIM(a.ifors) AS ifors, " + ;
                    "RTRIM(ISNULL(c.rclis,'')) AS rclis, " + ;
                    "RTRIM(a.reffs) AS reffs, " + ;
                    "a.pvens, RTRIM(a.moedas) AS moedas, a.pesoms, " + ;
                    "RTRIM(a.cvens) AS cvens, " + ;
                    "RTRIM(ISNULL(col.descs,'')) AS dcvens, " + ;
                    "RTRIM(a.linhas) AS linhas, " + ;
                    "RTRIM(ISNULL(lin.descs,'')) AS dlinhas, " + ;
                    "RTRIM(a.codfinp) AS codfinp, " + ;
                    "RTRIM(ISNULL(finp.descs,'')) AS dcodfinp " + ;
                    "FROM SigCdPro a " + ;
                    "LEFT JOIN SigCdGrp g " + ;
                    "    ON RTRIM(g.cgrus) = RTRIM(a.cgrus) " + ;
                    "LEFT JOIN SigCdPsg sg " + ;
                    "    ON sg.cgrus = RTRIM(a.cgrus) AND sg.codigos = RTRIM(a.sgrus) " + ;
                    "LEFT JOIN SIGCDCLI c " + ;
                    "    ON RTRIM(c.iclis) = RTRIM(a.ifors) " + ;
                    "LEFT JOIN SigCdCol col " + ;
                    "    ON RTRIM(col.colecoes) = RTRIM(a.cvens) " + ;
                    "LEFT JOIN SigCdLin lin " + ;
                    "    ON RTRIM(lin.linhas) = RTRIM(a.linhas) " + ;
                    "LEFT JOIN SigCdFip finp " + ;
                    "    ON RTRIM(finp.cods) = RTRIM(a.codfinp) " + ;
                    "WHERE RTRIM(a.cpros) = " + EscaparSQL(par_cCodPro)

                IF USED("cursor_4c_InfoPro")
                    USE IN cursor_4c_InfoPro
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InfoPro")

                IF loc_nRet > 0 AND USED("cursor_4c_InfoPro") ;
                   AND RECCOUNT("cursor_4c_InfoPro") > 0
                    SELECT cursor_4c_InfoPro
                    GO TOP

                    loc_oPage.txt_4c_CdGrupoInfo.Value    = ALLTRIM(cursor_4c_InfoPro.cgrus)
                    loc_oPage.txt_4c_DsGrupoInfo.Value    = ALLTRIM(cursor_4c_InfoPro.dgrus)
                    loc_oPage.txt_4c_CdSgrupoInfo.Value   = ALLTRIM(cursor_4c_InfoPro.sgrus)
                    loc_oPage.txt_4c_DsSgrupoInfo.Value   = ALLTRIM(cursor_4c_InfoPro.dsgrus)
                    loc_oPage.txt_4c_CdFornInfo.Value     = ALLTRIM(cursor_4c_InfoPro.ifors)
                    loc_oPage.txt_4c_DsFornInfo.Value     = ALLTRIM(cursor_4c_InfoPro.rclis)
                    loc_oPage.txt_4c_RefFornInfo.Value    = ALLTRIM(cursor_4c_InfoPro.reffs)
                    loc_oPage.txt_4c_PrVendaInfo.Value    = LTRIM(STR(cursor_4c_InfoPro.pvens, 12, 2))
                    loc_oPage.txt_4c_PrVendaMoeInfo.Value = ALLTRIM(cursor_4c_InfoPro.moedas)
                    loc_oPage.txt_4c_PesoMedioInfo.Value  = LTRIM(STR(cursor_4c_InfoPro.pesoms, 10, 3))
                    loc_oPage.txt_4c_CdGrVendaInfo.Value  = ALLTRIM(cursor_4c_InfoPro.cvens)
                    loc_oPage.txt_4c_DsGrVendaInfo.Value  = ALLTRIM(cursor_4c_InfoPro.dcvens)
                    loc_oPage.txt_4c_CdLinhaInfo.Value    = ALLTRIM(cursor_4c_InfoPro.linhas)
                    loc_oPage.txt_4c_DsLinhaInfo.Value    = ALLTRIM(cursor_4c_InfoPro.dlinhas)
                    loc_oPage.txt_4c_CodModeloInfo.Value  = ALLTRIM(cursor_4c_InfoPro.codfinp)
                    loc_oPage.txt_4c_DsModeloInfo.Value   = ALLTRIM(cursor_4c_InfoPro.dcodfinp)

                    USE IN cursor_4c_InfoPro
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em PopularInfoProduto:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarAba3Operacoes - Aba Operacoes: obs + processar + grids cab/itn
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAba3Operacoes()
        LOCAL loc_oPage, loc_oCnt, loc_oPgfOp, loc_oGrid
        loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3

        *-- Container de Observacao (cntOperacao: top=13, left=3, width=564, height=165)
        loc_oPage.AddObject("cnt_4c_Operacao", "Container")
        WITH loc_oPage.cnt_4c_Operacao
            .Top       = 13
            .Left      = 3
            .Width     = 564
            .Height    = 165
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oCnt = loc_oPage.cnt_4c_Operacao

        loc_oCnt.AddObject("lbl_4c_Obs", "Label")
        WITH loc_oCnt.lbl_4c_Obs
            .Caption   = "Obs:"
            .Top       = 10
            .Left      = 12
            .Width     = 35
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CodObs", "TextBox")
        WITH loc_oCnt.txt_4c_CodObs
            .Value    = ""
            .Top      = 8
            .Left     = 52
            .Width    = 27
            .Height   = 20
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("edt_4c_Obs", "EditBox")
        WITH loc_oCnt.edt_4c_Obs
            .Value     = ""
            .Top       = 8
            .Left      = 83
            .Width     = 407
            .Height    = 112
            .ScrollBars = 2
            .Visible   = .T.
        ENDWITH

        *-- Botao Processar Final (cmdProcessar: top=11, left=733, width=105, height=122)
        loc_oPage.AddObject("cmd_4c_ProcessarFinal", "CommandButton")
        WITH loc_oPage.cmd_4c_ProcessarFinal
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .PicturePosition = 13
            .Top             = 11
            .Left            = 733
            .Width           = 105
            .Height          = 122
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

        BINDEVENT(loc_oPage.cmd_4c_ProcessarFinal, "Click", THIS, "BtnProcessarFinalClick")

        *-- Sub-PageFrame Operacoes (pgOperacoes: top=191, left=1, width=997, height=377)
        loc_oPage.AddObject("pgf_4c_Operacoes", "PageFrame")
        WITH loc_oPage.pgf_4c_Operacoes
            .Top      = 191
            .Left     = 1
            .Width    = 997
            .Height   = 377
            .PageCount = 2
            .Tabs     = .T.
            .Visible  = .T.
            .Page1.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
            .Page2.Caption   = "Itens"
            .Page1.BackColor = RGB(224, 224, 224)
            .Page2.BackColor = RGB(224, 224, 224)
        ENDWITH
        loc_oPgfOp = loc_oPage.pgf_4c_Operacoes

        *-- grd_4c_CabOperas na Page1 (grdCabOperas: 8 cols, top=6, left=9, width=975, height=339)
        loc_oPgfOp.Page1.AddObject("grd_4c_CabOperas", "Grid")
        loc_oPgfOp.Page1.grd_4c_CabOperas.ColumnCount = 8

        WITH loc_oPgfOp.Page1.grd_4c_CabOperas
            .Top                = 6
            .Left               = 9
            .Width              = 975
            .Height             = 339
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
            .RowHeight          = 18
            .ScrollBars         = 3
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.
            .Column1.Header1.Caption = "Emp O"
            .Column1.Width           = 55
            .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Column2.Width           = 110
            .Column3.Header1.Caption = "C" + CHR(243) + "digo"
            .Column3.Width           = 130
            .Column4.Header1.Caption = "Emp D"
            .Column4.Width           = 55
            .Column5.Header1.Caption = "Grupo Orig"
            .Column5.Width           = 105
            .Column6.Header1.Caption = "Conta Orig"
            .Column6.Width           = 105
            .Column7.Header1.Caption = "Grupo Dest"
            .Column7.Width           = 105
            .Column8.Header1.Caption = "Conta Dest"
            .Column8.Width           = 105
        ENDWITH

        loc_oGrid = loc_oPgfOp.Page1.grd_4c_CabOperas
        loc_oGrid.Column1.AddObject("txt_4c_Col01", "TextBox")
        loc_oGrid.Column1.txt_4c_Col01.ReadOnly = .T.
        loc_oGrid.Column1.CurrentControl = "txt_4c_Col01"
        loc_oGrid.Column2.AddObject("txt_4c_Col02", "TextBox")
        loc_oGrid.Column2.txt_4c_Col02.ReadOnly = .T.
        loc_oGrid.Column2.CurrentControl = "txt_4c_Col02"
        loc_oGrid.Column3.AddObject("txt_4c_Col03", "TextBox")
        loc_oGrid.Column3.txt_4c_Col03.ReadOnly = .T.
        loc_oGrid.Column3.CurrentControl = "txt_4c_Col03"
        loc_oGrid.Column4.AddObject("txt_4c_Col04", "TextBox")
        loc_oGrid.Column4.txt_4c_Col04.ReadOnly = .T.
        loc_oGrid.Column4.CurrentControl = "txt_4c_Col04"
        loc_oGrid.Column5.AddObject("txt_4c_Col05", "TextBox")
        loc_oGrid.Column5.txt_4c_Col05.ReadOnly = .T.
        loc_oGrid.Column5.CurrentControl = "txt_4c_Col05"
        loc_oGrid.Column6.AddObject("txt_4c_Col06", "TextBox")
        loc_oGrid.Column6.txt_4c_Col06.ReadOnly = .T.
        loc_oGrid.Column6.CurrentControl = "txt_4c_Col06"
        loc_oGrid.Column7.AddObject("txt_4c_Col07", "TextBox")
        loc_oGrid.Column7.txt_4c_Col07.ReadOnly = .T.
        loc_oGrid.Column7.CurrentControl = "txt_4c_Col07"
        loc_oGrid.Column8.AddObject("txt_4c_Col08", "TextBox")
        loc_oGrid.Column8.txt_4c_Col08.ReadOnly = .T.
        loc_oGrid.Column8.CurrentControl = "txt_4c_Col08"

        *-- grd_4c_ItnOperas na Page2 (grdItnOperas: 9 cols, top=5, left=9, width=975, height=340)
        loc_oPgfOp.Page2.AddObject("grd_4c_ItnOperas", "Grid")
        loc_oPgfOp.Page2.grd_4c_ItnOperas.ColumnCount = 9

        WITH loc_oPgfOp.Page2.grd_4c_ItnOperas
            .Top                = 5
            .Left               = 9
            .Width              = 975
            .Height             = 340
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
            .RowHeight          = 18
            .ScrollBars         = 3
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.
            .Column1.Header1.Caption = "Item"
            .Column1.Width           = 50
            .Column2.Header1.Caption = "C" + CHR(243) + "digo"
            .Column2.Width           = 100
            .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.Width           = 200
            .Column4.Header1.Caption = "Uni"
            .Column4.Width           = 40
            .Column5.Header1.Caption = "Quantidade"
            .Column5.Width           = 90
            .Column6.Header1.Caption = "Unit" + CHR(225) + "rio"
            .Column6.Width           = 90
            .Column7.Header1.Caption = "Total"
            .Column7.Width           = 90
            .Column8.Header1.Caption = "Cor"
            .Column8.Width           = 60
            .Column9.Header1.Caption = "Tam"
            .Column9.Width           = 60
        ENDWITH

        loc_oGrid = loc_oPgfOp.Page2.grd_4c_ItnOperas
        loc_oGrid.Column1.AddObject("txt_4c_Itn01", "TextBox")
        loc_oGrid.Column1.txt_4c_Itn01.ReadOnly = .T.
        loc_oGrid.Column1.CurrentControl = "txt_4c_Itn01"
        loc_oGrid.Column2.AddObject("txt_4c_Itn02", "TextBox")
        loc_oGrid.Column2.txt_4c_Itn02.ReadOnly = .T.
        loc_oGrid.Column2.CurrentControl = "txt_4c_Itn02"
        loc_oGrid.Column3.AddObject("txt_4c_Itn03", "TextBox")
        loc_oGrid.Column3.txt_4c_Itn03.ReadOnly = .T.
        loc_oGrid.Column3.CurrentControl = "txt_4c_Itn03"
        loc_oGrid.Column4.AddObject("txt_4c_Itn04", "TextBox")
        loc_oGrid.Column4.txt_4c_Itn04.ReadOnly = .T.
        loc_oGrid.Column4.CurrentControl = "txt_4c_Itn04"
        loc_oGrid.Column5.AddObject("txt_4c_Itn05", "TextBox")
        loc_oGrid.Column5.txt_4c_Itn05.ReadOnly = .T.
        loc_oGrid.Column5.CurrentControl = "txt_4c_Itn05"
        loc_oGrid.Column6.AddObject("txt_4c_Itn06", "TextBox")
        loc_oGrid.Column6.txt_4c_Itn06.ReadOnly = .T.
        loc_oGrid.Column6.CurrentControl = "txt_4c_Itn06"
        loc_oGrid.Column7.AddObject("txt_4c_Itn07", "TextBox")
        loc_oGrid.Column7.txt_4c_Itn07.ReadOnly = .T.
        loc_oGrid.Column7.CurrentControl = "txt_4c_Itn07"
        loc_oGrid.Column8.AddObject("txt_4c_Itn08", "TextBox")
        loc_oGrid.Column8.txt_4c_Itn08.ReadOnly = .T.
        loc_oGrid.Column8.CurrentControl = "txt_4c_Itn08"
        loc_oGrid.Column9.AddObject("txt_4c_Itn09", "TextBox")
        loc_oGrid.Column9.txt_4c_Itn09.ReadOnly = .T.
        loc_oGrid.Column9.CurrentControl = "txt_4c_Itn09"

        BINDEVENT(loc_oPgfOp.Page2, "Activate", THIS, "PgItensActivate")

        THIS.TornarControlesVisiveis(loc_oPage)
    ENDPROC

    *==========================================================================
    * PgItensActivate - Atualiza grd_4c_ItnOperas ao ativar aba Itens
    *==========================================================================
    PROCEDURE PgItensActivate()
        LOCAL loc_oPage, loc_oErro

        TRY
            IF USED("cursor_4c_ItnOperas")
                GO TOP IN cursor_4c_ItnOperas
                loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.pgf_4c_Operacoes.Page2
                IF VARTYPE(loc_oPage) = "O" AND VARTYPE(loc_oPage.grd_4c_ItnOperas) = "O"
                    loc_oPage.grd_4c_ItnOperas.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em PgItensActivate:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarFinalClick - Valida, salva lote em sigprdis e exibe operacoes
    *==========================================================================
    PROCEDURE BtnProcessarFinalClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_Distribui") OR RECCOUNT("cursor_4c_Distribui") = 0
                MsgAviso("Nenhuma distribui" + CHR(231) + CHR(227) + "o para processar." + ;
                         CHR(13) + "Processe os estoques primeiro.", "Processar")
            ELSE
                IF THIS.this_oBusinessObject.SalvarLote()
                    MsgInfo("Distribui" + CHR(231) + CHR(227) + "o salva com sucesso!", "")
                    THIS.CarregarCabOperas()
                    THIS.CarregarItnOperas()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em BtnProcessarFinalClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarCabOperas - Carrega grd_4c_CabOperas com movimentos do lote
    *==========================================================================
    PROTECTED PROCEDURE CarregarCabOperas()
        LOCAL loc_cCodigos, loc_cSQL, loc_nRet, loc_oGrid, loc_oPage, loc_oErro
        loc_oErro = .NULL.

        TRY
            loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.pgf_4c_Operacoes.Page1
            loc_oGrid   = loc_oPage.grd_4c_CabOperas
            loc_cCodigos = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)

            IF USED("cursor_4c_CabOperas")
                USE IN cursor_4c_CabOperas
            ENDIF

            loc_cSQL = "SELECT DISTINCT RTRIM(c.emps) AS emps, RTRIM(c.opers) AS opers, " + ;
                       "RTRIM(c.dopes) AS dopes, RTRIM(c.empds) AS empds, " + ;
                       "RTRIM(c.grupoos) AS grupoos, RTRIM(c.contaos) AS contaos, " + ;
                       "RTRIM(c.grupods) AS grupods, RTRIM(c.contads) AS contads " + ;
                       "FROM SigMvCab c " + ;
                       "WHERE EXISTS (" + ;
                       " SELECT 1 FROM sigprdis d WHERE d.codigos = " + EscaparSQL(loc_cCodigos) + ;
                       " AND (RTRIM(d.empdopnums) = RTRIM(c.emps) + RTRIM(c.dopes)" + ;
                       "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(c.numes,6)),6)" + ;
                       " OR RTRIM(d.oridopnums) = RTRIM(c.emps) + RTRIM(c.dopes)" + ;
                       "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(c.numes,6)),6)))" + ;
                       " ORDER BY c.emps, c.dopes"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabOperas")

            IF loc_nRet < 0
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "cursor_4c_CabOperas"
                IF RECCOUNT("cursor_4c_CabOperas") > 0
                    loc_oGrid.Column1.txt_4c_Col01.ControlSource = "cursor_4c_CabOperas.emps"
                    loc_oGrid.Column2.txt_4c_Col02.ControlSource = "cursor_4c_CabOperas.opers"
                    loc_oGrid.Column3.txt_4c_Col03.ControlSource = "cursor_4c_CabOperas.dopes"
                    loc_oGrid.Column4.txt_4c_Col04.ControlSource = "cursor_4c_CabOperas.empds"
                    loc_oGrid.Column5.txt_4c_Col05.ControlSource = "cursor_4c_CabOperas.grupoos"
                    loc_oGrid.Column6.txt_4c_Col06.ControlSource = "cursor_4c_CabOperas.contaos"
                    loc_oGrid.Column7.txt_4c_Col07.ControlSource = "cursor_4c_CabOperas.grupods"
                    loc_oGrid.Column8.txt_4c_Col08.ControlSource = "cursor_4c_CabOperas.contads"
                ENDIF
                loc_oGrid.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarCabOperas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarItnOperas - Carrega grd_4c_ItnOperas com itens de movimentos do lote
    *==========================================================================
    PROTECTED PROCEDURE CarregarItnOperas()
        LOCAL loc_cCodigos, loc_cSQL, loc_nRet, loc_oGrid, loc_oPage, loc_oErro
        loc_oErro = .NULL.

        TRY
            loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.pgf_4c_Operacoes.Page2
            loc_oGrid   = loc_oPage.grd_4c_ItnOperas
            loc_cCodigos = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)

            IF USED("cursor_4c_ItnOperas")
                USE IN cursor_4c_ItnOperas
            ENDIF

            loc_cSQL = "SELECT h.seqs AS item, RTRIM(h.cpros) AS cpros, " + ;
                       "RTRIM(ISNULL(p.dpros,'')) AS dpros, " + ;
                       "RTRIM(h.unitmeds) AS unitmeds, h.qtds, h.units, h.totas, " + ;
                       "RTRIM(h.codcors) AS codcors, RTRIM(h.codtams) AS codtams " + ;
                       "FROM SigMvHst h " + ;
                       "LEFT JOIN SigCdPro p ON RTRIM(p.cpros) = RTRIM(h.cpros) " + ;
                       "WHERE EXISTS (" + ;
                       " SELECT 1 FROM sigprdis d WHERE d.codigos = " + EscaparSQL(loc_cCodigos) + ;
                       " AND (RTRIM(d.empdopnums) = RTRIM(h.emps) + RTRIM(h.dopes)" + ;
                       "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(h.numes,6)),6)" + ;
                       " OR RTRIM(d.oridopnums) = RTRIM(h.emps) + RTRIM(h.dopes)" + ;
                       "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(h.numes,6)),6)))" + ;
                       " ORDER BY h.seqs"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnOperas")

            IF loc_nRet < 0
                MsgErro("Erro ao carregar itens de opera" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "cursor_4c_ItnOperas"
                IF RECCOUNT("cursor_4c_ItnOperas") > 0
                    loc_oGrid.Column1.txt_4c_Itn01.ControlSource = "cursor_4c_ItnOperas.item"
                    loc_oGrid.Column2.txt_4c_Itn02.ControlSource = "cursor_4c_ItnOperas.cpros"
                    loc_oGrid.Column3.txt_4c_Itn03.ControlSource = "cursor_4c_ItnOperas.dpros"
                    loc_oGrid.Column4.txt_4c_Itn04.ControlSource = "cursor_4c_ItnOperas.unitmeds"
                    loc_oGrid.Column5.txt_4c_Itn05.ControlSource = "cursor_4c_ItnOperas.qtds"
                    loc_oGrid.Column6.txt_4c_Itn06.ControlSource = "cursor_4c_ItnOperas.units"
                    loc_oGrid.Column7.txt_4c_Itn07.ControlSource = "cursor_4c_ItnOperas.totas"
                    loc_oGrid.Column8.txt_4c_Itn08.ControlSource = "cursor_4c_ItnOperas.codcors"
                    loc_oGrid.Column9.txt_4c_Itn09.ControlSource = "cursor_4c_ItnOperas.codtams"
                ENDIF
                loc_oGrid.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarItnOperas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Lista")
            USE IN cursor_4c_Lista
        ENDIF
        IF USED("cursor_4c_Estoque")
            USE IN cursor_4c_Estoque
        ENDIF
        IF USED("cursor_4c_Disponivel")
            USE IN cursor_4c_Disponivel
        ENDIF
        IF USED("cursor_4c_Distribui")
            USE IN cursor_4c_Distribui
        ENDIF
        IF USED("cursor_4c_InfoPro")
            USE IN cursor_4c_InfoPro
        ENDIF
        IF USED("cursor_4c_CabOperas")
            USE IN cursor_4c_CabOperas
        ENDIF
        IF USED("cursor_4c_ItnOperas")
            USE IN cursor_4c_ItnOperas
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere periodo de filtro do form para o BO
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPage1, loc_oErro
        TRY
            loc_oPage1 = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPage1) = "O"
                IF VARTYPE(loc_oPage1.txt_4c_DtInicial) = "O"
                    THIS.this_oBusinessObject.this_dDatas = loc_oPage1.txt_4c_DtInicial.Value
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do BO para o form
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPage1, loc_dData, loc_oErro
        TRY
            loc_oPage1 = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPage1) = "O"
                loc_dData = THIS.this_oBusinessObject.this_dDatas
                IF !EMPTY(loc_dData)
                    IF VARTYPE(loc_oPage1.txt_4c_DtInicial) = "O"
                        loc_oPage1.txt_4c_DtInicial.Value = loc_dData
                    ENDIF
                    IF VARTYPE(loc_oPage1.txt_4c_DtFinal) = "O"
                        loc_oPage1.txt_4c_DtFinal.Value = loc_dData
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos edicao conforme modo atual
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPage2Dados, loc_oPage1Aba, loc_oGrid, loc_oErro
        TRY
            *-- Aba2 Distribuicao: filtros e grids edicao
            loc_oPage2Dados = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            IF VARTYPE(loc_oPage2Dados) = "O"
                IF VARTYPE(loc_oPage2Dados.txt_4c_CodGrupoDist)  = "O"
                    loc_oPage2Dados.txt_4c_CodGrupoDist.ReadOnly  = !par_lHabilitar
                ENDIF
                IF VARTYPE(loc_oPage2Dados.txt_4c_DscGrupoDist)  = "O"
                    loc_oPage2Dados.txt_4c_DscGrupoDist.ReadOnly  = !par_lHabilitar
                ENDIF
                IF VARTYPE(loc_oPage2Dados.txt_4c_CodSgrupoDist) = "O"
                    loc_oPage2Dados.txt_4c_CodSgrupoDist.ReadOnly = !par_lHabilitar
                ENDIF
                IF VARTYPE(loc_oPage2Dados.txt_4c_DscSgrupoDist) = "O"
                    loc_oPage2Dados.txt_4c_DscSgrupoDist.ReadOnly = !par_lHabilitar
                ENDIF
                IF VARTYPE(loc_oPage2Dados.txt_4c_ProdutoInicial) = "O"
                    loc_oPage2Dados.txt_4c_ProdutoInicial.ReadOnly = !par_lHabilitar
                ENDIF
                IF VARTYPE(loc_oPage2Dados.cmd_4c_Filtrar)        = "O"
                    loc_oPage2Dados.cmd_4c_Filtrar.Enabled         = par_lHabilitar
                ENDIF
                loc_oGrid = loc_oPage2Dados.grd_4c_Distribui
                IF VARTYPE(loc_oGrid) = "O"
                    loc_oGrid.Column3.txt_4c_Dis03.ReadOnly = !par_lHabilitar
                    loc_oGrid.Column4.txt_4c_Loc04.ReadOnly = !par_lHabilitar
                ENDIF
            ENDIF
            *-- Aba1 Estoques: processar e marca/desmarca
            loc_oPage1Aba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            IF VARTYPE(loc_oPage1Aba) = "O"
                IF VARTYPE(loc_oPage1Aba.cmd_4c_Processar)      = "O"
                    loc_oPage1Aba.cmd_4c_Processar.Enabled      = par_lHabilitar
                ENDIF
                IF VARTYPE(loc_oPage1Aba.cmg_4c_MarcaDesmarca)  = "O"
                    loc_oPage1Aba.cmg_4c_MarcaDesmarca.Enabled  = par_lHabilitar
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa filtros e painel de informacoes do produto
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPage, loc_oErro
        TRY
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            IF VARTYPE(loc_oPage) = "O"
                *-- Filtros de grupo/subgrupo e produto
                IF VARTYPE(loc_oPage.txt_4c_CodGrupoDist)  = "O"
                    loc_oPage.txt_4c_CodGrupoDist.Value  = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_DscGrupoDist)  = "O"
                    loc_oPage.txt_4c_DscGrupoDist.Value  = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_CodSgrupoDist) = "O"
                    loc_oPage.txt_4c_CodSgrupoDist.Value = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_DscSgrupoDist) = "O"
                    loc_oPage.txt_4c_DscSgrupoDist.Value = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_ProdutoInicial) = "O"
                    loc_oPage.txt_4c_ProdutoInicial.Value = ""
                ENDIF
                *-- Painel de informacoes do produto (16 campos)
                IF VARTYPE(loc_oPage.txt_4c_CdGrupoInfo)    = "O"
                    loc_oPage.txt_4c_CdGrupoInfo.Value    = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_DsGrupoInfo)    = "O"
                    loc_oPage.txt_4c_DsGrupoInfo.Value    = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_CdSgrupoInfo)   = "O"
                    loc_oPage.txt_4c_CdSgrupoInfo.Value   = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_DsSgrupoInfo)   = "O"
                    loc_oPage.txt_4c_DsSgrupoInfo.Value   = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_CdLinhaInfo)    = "O"
                    loc_oPage.txt_4c_CdLinhaInfo.Value    = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_DsLinhaInfo)    = "O"
                    loc_oPage.txt_4c_DsLinhaInfo.Value    = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_CdFornInfo)     = "O"
                    loc_oPage.txt_4c_CdFornInfo.Value     = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_DsFornInfo)     = "O"
                    loc_oPage.txt_4c_DsFornInfo.Value     = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_RefFornInfo)    = "O"
                    loc_oPage.txt_4c_RefFornInfo.Value    = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_CodModeloInfo)  = "O"
                    loc_oPage.txt_4c_CodModeloInfo.Value  = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_DsModeloInfo)   = "O"
                    loc_oPage.txt_4c_DsModeloInfo.Value   = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_CdGrVendaInfo)  = "O"
                    loc_oPage.txt_4c_CdGrVendaInfo.Value  = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_DsGrVendaInfo)  = "O"
                    loc_oPage.txt_4c_DsGrVendaInfo.Value  = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_PrVendaInfo)    = "O"
                    loc_oPage.txt_4c_PrVendaInfo.Value    = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_PrVendaMoeInfo) = "O"
                    loc_oPage.txt_4c_PrVendaMoeInfo.Value = ""
                ENDIF
                IF VARTYPE(loc_oPage.txt_4c_PesoMedioInfo)  = "O"
                    loc_oPage.txt_4c_PesoMedioInfo.Value  = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta botoes Salvar/Cancelar pelo modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lEditar, loc_oErro
        TRY
            loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
            IF VARTYPE(loc_oCnt) = "O"
                IF VARTYPE(loc_oCnt.cmd_4c_Salvar)   = "O"
                    loc_oCnt.cmd_4c_Salvar.Enabled   = loc_lEditar
                ENDIF
                IF VARTYPE(loc_oCnt.cmd_4c_Cancelar) = "O"
                    loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
                ENDIF
            ENDIF
            THIS.HabilitarCampos(loc_lEditar)
        CATCH TO loc_oErro
            MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprdisBO.prg):
*==============================================================================
* sigprdisBO.prg - Business Object para Distribuicao de Produtos
* Data: 2026-07-02
* Tabela: sigprdis | PK: cidchaves | Chave negocio: codigos (lote)
*
* ATENCAO: Esta tabela opera em modo LOTE (batch):
* - Um lote (codigos) possui N linhas (uma por empresa/produto/cor/tamanho)
* - cidchaves = chave unica por linha (gerada via fUniqueIds)
* - codigos   = identificador do lote de distribuicao
* - Excluir() apaga TODAS as linhas do lote (WHERE codigos = ...)
* - Inserir() insere MULTIPLAS linhas por lote
*==============================================================================

DEFINE CLASS sigprdisBO AS BusinessBase

    *-- Campos da tabela sigprdis
    this_cCidChaves  = ""   && cidchaves  CHAR(20)    - Chave unica por linha (PK)
    this_cCodigos    = ""   && codigos    CHAR(10)    - Codigo do lote de distribuicao
    this_cCpros      = ""   && cpros      CHAR(14)    - Codigo do produto
    this_cCodCors    = ""   && codcors    CHAR(4)     - Codigo da cor
    this_cCodTams    = ""   && codtams    CHAR(4)     - Codigo do tamanho
    this_dDatas      = {}   && datas      DATETIME    - Data da distribuicao
    this_dDtAlts     = {}   && dtalts     DATETIME    - Data da ultima alteracao
    this_cEmpDopNums = ""   && empdopnums CHAR(29)    - Numero do pedido destino
    this_cEmpDs      = ""   && empds      CHAR(3)     - Empresa destino
    this_cEmpGruEsts = ""   && empgruests CHAR(23)    - Empresa/Grupo/Estoque marcado
    this_cLocals     = ""   && locals     CHAR(10)    - Localizacao de destino
    this_nQtdOs      = 0    && qtdos      NUMERIC(10,2) - Quantidade original em estoque
    this_nQtds       = 0    && qtds       NUMERIC(10,2) - Quantidade distribuida
    this_cUsualts    = ""   && usualts    CHAR(10)    - Usuario da ultima alteracao
    this_cUsuars     = ""   && usuars     CHAR(10)    - Usuario criador
    this_cOriDopNums = ""   && oridopnums CHAR(29)    - Numero do pedido origem

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigprdis"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cCodigos    = TratarNulo(codigos,    "C")
                THIS.this_cCpros      = TratarNulo(cpros,      "C")
                THIS.this_cCodCors    = TratarNulo(codcors,    "C")
                THIS.this_cCodTams    = TratarNulo(codtams,    "C")
                THIS.this_dDatas      = NVL(datas,      {})
                THIS.this_dDtAlts     = NVL(dtalts,     {})
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_cEmpDs      = TratarNulo(empds,      "C")
                THIS.this_cEmpGruEsts = TratarNulo(empgruests, "C")
                THIS.this_cLocals     = TratarNulo(locals,     "C")
                THIS.this_nQtdOs      = TratarNulo(qtdos,      "N")
                THIS.this_nQtds       = TratarNulo(qtds,       "N")
                THIS.this_cUsualts    = TratarNulo(usualts,    "C")
                THIS.this_cUsuars     = TratarNulo(usuars,     "C")
                THIS.this_cOriDopNums = TratarNulo(oridopnums, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista lotes de distribuicao (suporta filtro WHERE opcional)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cSQL = "SELECT DISTINCT codigos, datas FROM sigprdis"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY datas DESC, codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar lotes: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorData - Carrega lotes filtrados por intervalo de data/hora
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorData(par_dDataIni, par_dDataFim)
        LOCAL loc_cSQL, loc_cDataIni, loc_cDataFim, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_dDataIni) != "T" OR EMPTY(par_dDataIni)
                par_dDataIni = CTOT(DTOC(DATE()) + " 00:00:00")
            ENDIF
            IF VARTYPE(par_dDataFim) != "T" OR EMPTY(par_dDataFim)
                par_dDataFim = CTOT(DTOC(DATE()) + " 23:59:59")
            ENDIF

            loc_cDataIni = FormatarDataSQL(par_dDataIni)
            loc_cDataFim = FormatarDataSQL(par_dDataFim)

            loc_cSQL = "SELECT DISTINCT codigos, datas FROM sigprdis" + ;
                       " WHERE datas BETWEEN " + loc_cDataIni + " AND " + loc_cDataFim + ;
                       " ORDER BY datas DESC, codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar por data: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega primeiro item de um lote (para edicao)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT * FROM sigprdis WHERE codigos = " + EscaparSQL(par_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                GO TOP IN cursor_4c_Carrega
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar lote: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItensPorCodigos - Carrega todos os itens de um lote em cursor
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItensPorCodigos(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT * FROM sigprdis WHERE codigos = " + EscaparSQL(par_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensPrdis")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar itens do lote: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere uma linha de distribuicao no banco de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO sigprdis (" + ;
                       "cidchaves, codigos, cpros, codcors, codtams, datas, dtalts," + ;
                       " empdopnums, empds, empgruests, locals, qtdos, qtds," + ;
                       " usualts, usuars, oridopnums" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)    + ", " + ;
                       EscaparSQL(THIS.this_cCodigos)      + ", " + ;
                       EscaparSQL(THIS.this_cCpros)        + ", " + ;
                       EscaparSQL(THIS.this_cCodCors)      + ", " + ;
                       EscaparSQL(THIS.this_cCodTams)      + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas)   + ", " + ;
                       FormatarDataSQL(THIS.this_dDtAlts)  + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNums)   + ", " + ;
                       EscaparSQL(THIS.this_cEmpDs)        + ", " + ;
                       EscaparSQL(THIS.this_cEmpGruEsts)   + ", " + ;
                       EscaparSQL(THIS.this_cLocals)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds)  + ", " + ;
                       EscaparSQL(THIS.this_cUsualts)      + ", " + ;
                       EscaparSQL(THIS.this_cUsuars)       + ", " + ;
                       EscaparSQL(THIS.this_cOriDopNums)   + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir distribui" + CHR(231) + CHR(227) + "o: " + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza uma linha de distribuicao no banco de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE sigprdis SET" + ;
                       " codigos    = " + EscaparSQL(THIS.this_cCodigos)      + "," + ;
                       " cpros      = " + EscaparSQL(THIS.this_cCpros)        + "," + ;
                       " codcors    = " + EscaparSQL(THIS.this_cCodCors)      + "," + ;
                       " codtams    = " + EscaparSQL(THIS.this_cCodTams)      + "," + ;
                       " datas      = " + FormatarDataSQL(THIS.this_dDatas)   + "," + ;
                       " dtalts     = " + FormatarDataSQL(THIS.this_dDtAlts)  + "," + ;
                       " empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)   + "," + ;
                       " empds      = " + EscaparSQL(THIS.this_cEmpDs)        + "," + ;
                       " empgruests = " + EscaparSQL(THIS.this_cEmpGruEsts)   + "," + ;
                       " locals     = " + EscaparSQL(THIS.this_cLocals)       + "," + ;
                       " qtdos      = " + FormatarNumeroSQL(THIS.this_nQtdOs) + "," + ;
                       " qtds       = " + FormatarNumeroSQL(THIS.this_nQtds)  + "," + ;
                       " usualts    = " + EscaparSQL(THIS.this_cUsualts)      + "," + ;
                       " usuars     = " + EscaparSQL(THIS.this_cUsuars)       + "," + ;
                       " oridopnums = " + EscaparSQL(THIS.this_cOriDopNums)   + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar distribui" + CHR(231) + CHR(227) + "o: " + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui todos os itens de um lote (WHERE codigos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM sigprdis WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir lote: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Salvar - Sobrescreve BusinessBase.Salvar() para delegar ao SalvarLote()
    *--------------------------------------------------------------------------
    PROCEDURE Salvar()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !THIS.this_lEmEdicao
            THIS.this_cMensagemErro = "N" + CHR(227) + "o est" + CHR(225) + ;
                                      " em modo de edi" + CHR(231) + CHR(227) + "o"
        ELSE
            loc_lResultado = THIS.SalvarLote()
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarLote - Insere multiplas linhas de distribui" + CHR(231) + CHR(227) + "o em lote
    * Usa cursor_4c_Distribui e cursor_4c_Disponivel (devem existir no ambiente)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarLote()
        LOCAL loc_cCodigos, loc_nTotal, loc_nNeg, loc_lOK, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Distribui")
                MsgErro("Cursor de distribui" + CHR(231) + CHR(227) + ;
                        "o n" + CHR(227) + "o encontrado.", "Erro")
            ELSE
                *-- Contar registros com quantidade a distribuir
                COUNT FOR cursor_4c_Distribui.QtdDistr != 0 TO loc_nTotal IN cursor_4c_Distribui

                IF loc_nTotal = 0
                    MsgAviso("Nenhum produto foi informado para distribuir.", "Aviso")
                ELSE
                    *-- Verificar saldo negativo
                    loc_nNeg = 0
                    IF USED("cursor_4c_Disponivel")
                        COUNT FOR cursor_4c_Disponivel.QtdSaldo < 0 TO loc_nNeg IN cursor_4c_Disponivel
                    ENDIF

                    IF loc_nNeg > 0
                        MsgAviso("Existem produtos distribu" + CHR(237) + "dos com saldo negativo." + ;
                                 CHR(13) + "Favor checar antes de processar.", "Saldo Negativo")
                    ELSE
                        *-- Gerar codigo do lote (novo ou reutilizar existente para alteracao)
                        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                            loc_cCodigos = ALLTRIM(STR(fGerUniqueKey("sigprdis"), 10))
                        ELSE
                            loc_cCodigos = ALLTRIM(THIS.this_cCodigos)
                            THIS.ExecutarExclusao()
                        ENDIF

                        *-- Inserir cada linha com QtdDistr != 0
                        loc_lOK = .T.
                        SELECT cursor_4c_Distribui
                        GO TOP IN cursor_4c_Distribui

                        DO WHILE !EOF("cursor_4c_Distribui") AND loc_lOK
                            IF cursor_4c_Distribui.QtdDistr != 0
                                THIS.this_cCidChaves  = fUniqueIds()
                                THIS.this_cCodigos    = loc_cCodigos
                                THIS.this_cCpros      = ALLTRIM(cursor_4c_Distribui.Cpros)
                                THIS.this_cCodCors    = ALLTRIM(cursor_4c_Distribui.CodCors)
                                THIS.this_cCodTams    = ALLTRIM(cursor_4c_Distribui.CodTams)
                                THIS.this_dDatas      = DATETIME()
                                THIS.this_dDtAlts     = DATETIME()
                                THIS.this_cEmpDs      = ALLTRIM(cursor_4c_Distribui.Cemps)
                                THIS.this_cEmpGruEsts = ALLTRIM(cursor_4c_Distribui.empgruests)
                                THIS.this_cLocals     = ALLTRIM(cursor_4c_Distribui.CidChaves)
                                THIS.this_nQtdOs      = cursor_4c_Distribui.QtdSaldo
                                THIS.this_nQtds       = cursor_4c_Distribui.QtdDistr
                                THIS.this_cUsualts    = gc_4c_UsuarioLogado
                                THIS.this_cUsuars     = gc_4c_UsuarioLogado
                                THIS.this_cEmpDopNums = ""
                                THIS.this_cOriDopNums = ""
                                IF !THIS.Inserir()
                                    loc_lOK = .F.
                                ENDIF
                            ENDIF
                            IF loc_lOK
                                SKIP IN cursor_4c_Distribui
                            ENDIF
                        ENDDO

                        IF loc_lOK
                            THIS.this_cCodigos      = loc_cCodigos
                            THIS.this_lNovoRegistro = .F.
                            THIS.this_lEmEdicao     = .F.
                            loc_lResultado          = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarDistribuicao - Cria cursor_4c_Disponivel e cursor_4c_Distribui
    * par_cAlias = alias do cursor de estoques selecionados (cursor_4c_Estoque)
    *              Campos: nMarca (N), Cemps (C3), CGrus (C10), CCons (C10)
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarDistribuicao(par_cAlias)
        LOCAL loc_cIN, loc_cSQL, loc_nRet, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cAlias) != "C" OR !USED(par_cAlias)
                MsgErro("Alias inv" + CHR(225) + "lido para processar distribui" + ;
                        CHR(231) + CHR(227) + "o.", "Erro")
            ELSE
                *-- Montar IN clause com os estoques marcados
                SELECT (par_cAlias)
                GO TOP
                loc_cIN = ""
                SCAN
                    IF nMarca = 1
                        IF !EMPTY(loc_cIN)
                            loc_cIN = loc_cIN + ","
                        ENDIF
                        loc_cIN = loc_cIN + "'" + ALLTRIM(Cemps) + "|" + ;
                                  ALLTRIM(CGrus) + "|" + ALLTRIM(CCons) + "'"
                    ENDIF
                ENDSCAN

                IF EMPTY(loc_cIN)
                    MsgAviso("Nenhum estoque selecionado para processar.", "Processar")
                ELSE
                    *-- cursor_4c_Disponivel: estoque agregado por produto/cor/tamanho
                    loc_cSQL = "SELECT RTRIM(m.cpros) AS Cpros, " + ;
                               "RTRIM(ISNULL(p.dpros,'')) AS Dpros, " + ;
                               "RTRIM(m.codcors) AS CodCors, " + ;
                               "RTRIM(m.codtams) AS CodTams, " + ;
                               "SUM(m.sqtds) AS Sqtds, " + ;
                               "CAST(0 AS NUMERIC(11,3)) AS QtdSaida, " + ;
                               "SUM(m.sqtds) AS QtdSaldo, " + ;
                               "RTRIM(ISNULL(p.cgrus,'')) AS Cgrus, " + ;
                               "RTRIM(ISNULL(p.sgrus,'')) AS Sgrus " + ;
                               "FROM SigMvEst m " + ;
                               "JOIN SigCdPro p ON RTRIM(p.cpros) = RTRIM(m.cpros) " + ;
                               "WHERE m.tipoestos = 3 " + ;
                               "AND (RTRIM(m.emps) + '|' + RTRIM(m.grupos) + '|' + RTRIM(m.estos))" + ;
                               " IN (" + loc_cIN + ") " + ;
                               "GROUP BY m.cpros, p.dpros, m.codcors, m.codtams, p.cgrus, p.sgrus " + ;
                               "ORDER BY m.cpros, m.codcors, m.codtams"

                    IF USED("cursor_4c_Disponivel")
                        USE IN cursor_4c_Disponivel
                    ENDIF

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Disponivel")

                    IF loc_nRet < 0
                        MsgErro("Erro ao carregar estoque dispon" + CHR(237) + "vel:" + ;
                                CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        *-- cursor_4c_Distribui: uma linha por empresa x produto/cor/tamanho
                        loc_cSQL = "SELECT RTRIM(m.emps) AS Cemps, " + ;
                                   "RTRIM(m.grupos) AS CGrus, " + ;
                                   "RTRIM(m.estos) AS CCons, " + ;
                                   "RTRIM(m.cpros) AS Cpros, " + ;
                                   "RTRIM(m.codcors) AS CodCors, " + ;
                                   "RTRIM(m.codtams) AS CodTams, " + ;
                                   "m.sqtds AS QtdSaldo, " + ;
                                   "CAST(0 AS NUMERIC(11,3)) AS QtdDistr, " + ;
                                   "RTRIM(m.empgruests) AS empgruests, " + ;
                                   "REPLICATE(' ', 20) AS CidChaves " + ;
                                   "FROM SigMvEst m " + ;
                                   "WHERE m.tipoestos = 3 " + ;
                                   "AND (RTRIM(m.emps) + '|' + RTRIM(m.grupos) + '|' + RTRIM(m.estos))" + ;
                                   " IN (" + loc_cIN + ") " + ;
                                   "ORDER BY m.cpros, m.codcors, m.codtams, m.emps"

                        IF USED("cursor_4c_Distribui")
                            USE IN cursor_4c_Distribui
                        ENDIF

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Distribui")

                        IF loc_nRet < 0
                            MsgErro("Erro ao montar distribui" + CHR(231) + CHR(227) + "o:" + ;
                                    CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

