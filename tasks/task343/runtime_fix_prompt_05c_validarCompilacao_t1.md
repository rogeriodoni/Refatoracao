# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05c_validarCompilacao
- Tentativa: 1/10
- Mensagem: C:\4c\projeto\app\classes\ACJBO.prg: loc_cMensagem = "O Usu" + CHR(225) + "rio """ +  ALLTRIM(cursor_4c_DuplAcJ.Usuars) +  """ est" + CHR(225) + " duplicado na grade!!!" | Error in line 403: Syntax error. | 

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormACJ.prg):
*==============================================================================
* FormACJ.prg - Cadastro de Acessos de JOB
* Legado: SIGCDACJ (frmcadastro)
* Tabela: SigCdAcJ | Lista JOBs: SigCdCli (filtro SigCdGcr.Coletors=10)
*==============================================================================

DEFINE CLASS FormACJ AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Acessos de JOB"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - Inicializa o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("ACJBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio ACJBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormACJ:" + CHR(13) + loc_oErro.Message, "Erro")
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

            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(217, 217, 217)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(217, 217, 217)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
        THIS.pgf_4c_Paginas.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista de JOBs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (fundo escuro com titulo)
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
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (lado direito, Top compensado +29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de saida (padrao canonico - prevalece sobre legado)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de JOBs (cursor criado por CarregarLista/Buscar)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top         = 117
        loc_oGrid.Left        = 26
        loc_oGrid.Width       = 890
        loc_oGrid.Height      = 498
        loc_oGrid.ColumnCount = 6

        WITH loc_oGrid
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

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Cabecalho JOB + Grade Acessos)
    * Fase 5: cabecalho info + botoes acao
    * Fase 6: grid de usuarios + botoes linha (btnInserir/btnExcluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de botoes Confirmar/Cancelar (Top=4+29=33)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Container de saida (padrao canonico)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- CheckBox chkInativos: top=27+29=56, left=307 (acima da linha principal)
        loc_oPagina.AddObject("chk_4c_ChkInativos", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkInativos
            .Caption   = "Inativo"
            .Value     = 0
            .Top       = 56
            .Left      = 307
            .Width     = 80
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Linha 1: Grupo | Criacao do JOB | Criado em
        *-- Label Say1 "Grupo :" top=49+29=78, left=267
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Grupo :"
            .Top       = 78
            .Left      = 267
            .Width     = 40
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox getGrupos: top=45+29=74, left=307, width=80
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value    = ""
            .Top      = 74
            .Left     = 307
            .Width    = 80
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        *-- Label Say4 "Criacao do JOB :" top=49+29=78, left=410
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Cria" + CHR(231) + CHR(227) + "o do JOB :"
            .Top       = 78
            .Left      = 410
            .Width     = 84
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox getUsuars (criador): top=45+29=74, left=494, width=92, height=23
        loc_oPagina.AddObject("txt_4c_Usuars", "TextBox")
        WITH loc_oPagina.txt_4c_Usuars
            .Value    = ""
            .Top      = 74
            .Left     = 494
            .Width    = 92
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        *-- Label Say5 "Criado em :" top=49+29=78, left=611
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Criado em :"
            .Top       = 78
            .Left      = 611
            .Width     = 58
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox getDataIncs: top=45+29=74, left=670, width=80
        loc_oPagina.AddObject("txt_4c_DataIncs", "TextBox")
        WITH loc_oPagina.txt_4c_DataIncs
            .Value    = ""
            .Top      = 74
            .Left     = 670
            .Width    = 80
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        *-- Linha 2: JOB codigo | JOB descricao abreviada
        *-- Label Say2 "JOB :" top=75+29=104, left=277
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "JOB :"
            .Top       = 104
            .Left      = 277
            .Width     = 30
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox getIClis: top=71+29=100, left=307, width=80
        loc_oPagina.AddObject("txt_4c_IClis", "TextBox")
        WITH loc_oPagina.txt_4c_IClis
            .Value    = ""
            .Top      = 100
            .Left     = 307
            .Width    = 80
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        *-- TextBox getRClis (descritivo abreviado): top=71+29=100, left=390, width=360
        loc_oPagina.AddObject("txt_4c_RClis", "TextBox")
        WITH loc_oPagina.txt_4c_RClis
            .Value    = ""
            .Top      = 100
            .Left     = 390
            .Width    = 360
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        *-- Linha 3: Descritivo completo
        *-- Label Say3 "Descritivo :" top=101+29=130, left=249
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Descritivo :"
            .Top       = 130
            .Left      = 249
            .Width     = 58
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox getRazaos: top=97+29=126, left=307, width=443, height=23
        loc_oPagina.AddObject("txt_4c_Razaos", "TextBox")
        WITH loc_oPagina.txt_4c_Razaos
            .Value    = ""
            .Top      = 126
            .Left     = 307
            .Width    = 443
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        *-- Label Say6 "Lista de Usuarios..." top=154+29=183, left=308
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Lista de Usu" + CHR(225) + "rios Que Ter" + CHR(227) + "o Acesso a Esse JOB:"
            .Top       = 183
            .Left      = 308
            .Width     = 340
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Criar cursor placeholder para o grid de usuarios
        IF !USED("cursor_4c_AcJ")
            SET NULL ON
            CREATE CURSOR cursor_4c_AcJ (pkChaves C(20), JOBs C(20), Usuars C(20), NComps C(30))
            SET NULL OFF
        ENDIF

        *-- Grid de usuarios com acesso ao JOB
        *-- Legado: grdUsuarios top=170, left=307, width=343, height=418 (+29 compensacao)
        LOCAL loc_oGrdUsu
        loc_oPagina.AddObject("grd_4c_Usuarios", "Grid")
        loc_oGrdUsu = loc_oPagina.grd_4c_Usuarios
        loc_oGrdUsu.Top         = 199
        loc_oGrdUsu.Left        = 307
        loc_oGrdUsu.Width       = 343
        loc_oGrdUsu.Height      = 418
        loc_oGrdUsu.ColumnCount = 2

        WITH loc_oGrdUsu
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

        loc_oGrdUsu.ColumnCount = 3
        loc_oGrdUsu.RecordSource = "cursor_4c_AcJ"
        WITH loc_oGrdUsu
            .Column1.ControlSource   = "cursor_4c_AcJ.Usuars"
            .Column1.Width           = 120
            .Column1.Header1.Caption = "Usu" + CHR(225) + "rio"

            .Column2.ControlSource   = "cursor_4c_AcJ.NComps"
            .Column2.Width           = 200
            .Column2.Header1.Caption = "Nome"
        ENDWITH

        BINDEVENT(loc_oGrdUsu.Column1.Text1, "When",  THIS, "GrdUsuariosColumn1When")
        BINDEVENT(loc_oGrdUsu.Column1.Text1, "Valid",  THIS, "GrdUsuariosColumn1Valid")
        BINDEVENT(loc_oGrdUsu.Column2.Text1, "When",  THIS, "GrdUsuariosColumn2When")
        BINDEVENT(loc_oGrdUsu.Column2.Text1, "Valid",  THIS, "GrdUsuariosColumn2Valid")

        *-- Botao Inserir linha no grid (legado: btnInserir top=170, left=654, +29)
        loc_oPagina.AddObject("cmd_4c_InserirUsuario", "CommandButton")
        WITH loc_oPagina.cmd_4c_InserirUsuario
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 199
            .Left            = 654
            .Width           = 42
            .Height          = 42
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Inserir usu" + CHR(225) + "rio"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_InserirUsuario, "Click", THIS, "BtnInserirUsuarioClick")

        *-- Botao Excluir linha no grid (legado: btnExcluir top=212, left=654, +29)
        loc_oPagina.AddObject("cmd_4c_ExcluirUsuario", "CommandButton")
        WITH loc_oPagina.cmd_4c_ExcluirUsuario
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .Top             = 241
            .Left            = 654
            .Width           = 42
            .Height          = 42
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Excluir usu" + CHR(225) + "rio"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_ExcluirUsuario, "Click", THIS, "BtnExcluirUsuarioClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega lista de JOBs na Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lSucesso = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- RecordSource e ColumnCount FORA de WITH (Problema 36)
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "cursor_4c_GradeJOB"
                loc_oGrid.ColumnCount  = 6

                WITH loc_oGrid
                    .Column1.ControlSource  = "cursor_4c_GradeJOB.IClis"
                    .Column1.Width          = 80
                    .Column1.Header1.Caption = "JOB"

                    .Column2.ControlSource  = "cursor_4c_GradeJOB.RClis"
                    .Column2.Width          = 80
                    .Column2.Header1.Caption = "C" + CHR(243) + "d. Abrev."

                    .Column3.ControlSource  = "cursor_4c_GradeJOB.Razaos"
                    .Column3.Width          = 420
                    .Column3.Header1.Caption = "Descritivo"

                    .Column4.ControlSource  = "cursor_4c_GradeJOB.Grupos"
                    .Column4.Width          = 80
                    .Column4.Header1.Caption = "Grupo"

                    .Column5.ControlSource  = "cursor_4c_GradeJOB.DataIncs"
                    .Column5.Width          = 80
                    .Column5.Header1.Caption = "Cria" + CHR(231) + CHR(227) + "o"

                    .Column6.ControlSource  = "cursor_4c_GradeJOB.Inativas"
                    .Column6.Width          = 60
                    .Column6.Header1.Caption = "Inativo"

                    .Refresh()
                ENDWITH

                THIS.FormatarGridLista(loc_oGrid)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
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
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        IF USED("cursor_4c_GradeJOB")
            USE IN cursor_4c_GradeJOB
        ENDIF
        IF USED("cursor_4c_AcJ")
            USE IN cursor_4c_AcJ
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Filtra a lista de JOBs pelo texto digitado
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cFiltro, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaJOB", "IClis", "", ;
                "Buscar JOB")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("IClis",   "", "JOB")
                loc_oBusca.mAddColuna("RClis",   "", "C" + CHR(243) + "d. Abrev.")
                loc_oBusca.mAddColuna("Razaos",  "", "Descritivo")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaJOB")
                    loc_cFiltro = ALLTRIM(cursor_4c_BuscaJOB.IClis)
                    IF USED("cursor_4c_BuscaJOB")
                        USE IN cursor_4c_BuscaJOB
                    ENDIF
                    IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                        loc_lSucesso = .F.
                    ELSE
                        LOCAL loc_oGrid
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                        loc_oGrid.ColumnCount = 3
                        loc_oGrid.RecordSource = "cursor_4c_GradeJOB"
                        loc_oGrid.ColumnCount  = 6
                        WITH loc_oGrid
                            .Column1.ControlSource   = "cursor_4c_GradeJOB.IClis"
                            .Column1.Header1.Caption = "JOB"
                            .Column2.ControlSource   = "cursor_4c_GradeJOB.RClis"
                            .Column2.Header1.Caption = "C" + CHR(243) + "d. Abrev."
                            .Column3.ControlSource   = "cursor_4c_GradeJOB.Razaos"
                            .Column3.Header1.Caption = "Descritivo"
                            .Column4.ControlSource   = "cursor_4c_GradeJOB.Grupos"
                            .Column4.Header1.Caption = "Grupo"
                            .Column5.ControlSource   = "cursor_4c_GradeJOB.DataIncs"
                            .Column5.Header1.Caption = "Cria" + CHR(231) + CHR(227) + "o"
                            .Column6.ControlSource   = "cursor_4c_GradeJOB.Inativas"
                            .Column6.Header1.Caption = "Inativo"
                            .Refresh()
                        ENDWITH
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    IF USED("cursor_4c_BuscaJOB")
                        USE IN cursor_4c_BuscaJOB
                    ENDIF
                    loc_lSucesso = THIS.CarregarLista()
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar JOB:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza acessos do JOB selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lSucesso, loc_cIClis
        loc_lSucesso = .F.

        IF !USED("cursor_4c_GradeJOB") OR RECCOUNT("cursor_4c_GradeJOB") = 0
            MsgAviso("Nenhum JOB selecionado.", "")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_GradeJOB
            IF EOF("cursor_4c_GradeJOB")
                MsgAviso("Nenhum JOB selecionado.", "")
            ELSE
                THIS.this_oBusinessObject.CarregarJobDoCursor("cursor_4c_GradeJOB")
                loc_cIClis = ALLTRIM(THIS.this_oBusinessObject.this_cIClis)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.this_oBusinessObject.CarregarAcessos(loc_cIClis)
                THIS.AlternarPagina(2)
                THIS.BOParaForm()
                THIS.AjustarBotoesPorModo()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao visualizar JOB:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Altera acessos do JOB selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lSucesso, loc_cIClis
        loc_lSucesso = .F.

        IF !USED("cursor_4c_GradeJOB") OR RECCOUNT("cursor_4c_GradeJOB") = 0
            MsgAviso("Nenhum JOB selecionado.", "")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_GradeJOB
            IF EOF("cursor_4c_GradeJOB")
                MsgAviso("Nenhum JOB selecionado.", "")
            ELSE
                THIS.this_oBusinessObject.CarregarJobDoCursor("cursor_4c_GradeJOB")
                loc_cIClis = ALLTRIM(THIS.this_oBusinessObject.this_cIClis)
                THIS.this_cModoAtual = "ALTERAR"
                THIS.this_oBusinessObject.CarregarAcessos(loc_cIClis)
                THIS.AlternarPagina(2)
                THIS.BOParaForm()
                THIS.AjustarBotoesPorModo()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao alterar JOB:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Gerencia acessos do JOB selecionado partindo de lista vazia
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED("cursor_4c_GradeJOB") OR RECCOUNT("cursor_4c_GradeJOB") = 0
            MsgAviso("Selecione um JOB na lista.", "")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_GradeJOB
        IF EOF("cursor_4c_GradeJOB")
            MsgAviso("Selecione um JOB na lista.", "")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_oBusinessObject.CarregarJobDoCursor("cursor_4c_GradeJOB")
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.BOParaForm()

            IF USED("cursor_4c_AcJ")
                USE IN cursor_4c_AcJ
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_AcJ (pkChaves C(20), JOBs C(20), Usuars C(20), NComps C(30))
            SET NULL OFF

            THIS.AlternarPagina(2)
            THIS.CarregarGridUsuarios()
            THIS.AjustarBotoesPorModo()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao incluir:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Remove todos os acessos do JOB selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lSucesso, loc_cIClis, loc_lConfirmado
        loc_lSucesso   = .F.
        loc_lConfirmado = .F.

        IF !USED("cursor_4c_GradeJOB") OR RECCOUNT("cursor_4c_GradeJOB") = 0
            MsgAviso("Nenhum JOB selecionado.", "")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_GradeJOB
            IF EOF("cursor_4c_GradeJOB")
                MsgAviso("Nenhum JOB selecionado.", "")
            ELSE
                loc_cIClis = ALLTRIM(cursor_4c_GradeJOB.IClis)
                loc_lConfirmado = MsgConfirma("Excluir todos os acessos do JOB [" + ;
                    loc_cIClis + "]?" + CHR(13) + "Esta opera" + CHR(231) + CHR(227) + ;
                    "o n" + CHR(227) + "o pode ser desfeita.", ;
                    "Confirmar Exclus" + CHR(227) + "o")

                IF loc_lConfirmado
                    IF THIS.this_oBusinessObject.ExcluirAcessos(loc_cIClis)
                        MsgInfo("Acessos do JOB [" + loc_cIClis + "] exclu" + CHR(237) + ;
                            "dos com sucesso.", "Sucesso")
                        THIS.CarregarLista()
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir acessos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Preenche campos do cabecalho (Page2) a partir do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO, loc_cData
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            loc_cData = IIF(EMPTY(loc_oBO.this_dDataIncs), "", DTOC(loc_oBO.this_dDataIncs))

            loc_oPg2.txt_4c_Grupo.Value          = ALLTRIM(loc_oBO.this_cGrupos)
            loc_oPg2.txt_4c_IClis.Value          = ALLTRIM(loc_oBO.this_cIClis)
            loc_oPg2.txt_4c_RClis.Value          = ALLTRIM(loc_oBO.this_cRClis)
            loc_oPg2.txt_4c_Razaos.Value         = ALLTRIM(loc_oBO.this_cRazaos)
            loc_oPg2.txt_4c_Usuars.Value         = ALLTRIM(loc_oBO.this_cUsuarsCriador)
            loc_oPg2.txt_4c_DataIncs.Value       = loc_cData
            loc_oPg2.chk_4c_ChkInativos.Value    = loc_oBO.this_lInativas
            THIS.CarregarGridUsuarios()
        CATCH TO loc_oErro
            MsgErro("Erro ao exibir dados do JOB:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza campos do form de volta para o BO
    * Cabecalho e somente-leitura; apenas IClis e Grupos sao sincronizados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            loc_oBO.this_cIClis  = ALLTRIM(loc_oPg2.txt_4c_IClis.Value)
            loc_oBO.this_cGrupos = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
            loc_oBO.this_cRClis  = ALLTRIM(loc_oPg2.txt_4c_RClis.Value)
            loc_oBO.this_cRazaos = ALLTRIM(loc_oPg2.txt_4c_Razaos.Value)
        CATCH TO loc_oErro
            MsgErro("Erro ao sincronizar dados:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita controles de edicao da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Botoes de linha do grid (Inserir/Excluir usuario)
            IF VARTYPE(loc_oPg2.cmd_4c_InserirUsuario) = "O"
            ENDIF
            IF VARTYPE(loc_oPg2.cmd_4c_ExcluirUsuario) = "O"
            ENDIF
            *-- Botao Confirmar
            IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
                IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar) = "O"
                    loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao ajustar estado dos controles:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes da Page2 conforme modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lEditando
        loc_lEditando = INLIST(THIS.this_cModoAtual, "ALTERAR", "INCLUIR")
        THIS.HabilitarCampos(loc_lEditando)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos do cabecalho na Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Grupo.Value         = ""
            loc_oPg2.txt_4c_IClis.Value         = ""
            loc_oPg2.txt_4c_RClis.Value         = ""
            loc_oPg2.txt_4c_Razaos.Value        = ""
            loc_oPg2.txt_4c_Usuars.Value        = ""
            loc_oPg2.txt_4c_DataIncs.Value      = ""
            loc_oPg2.chk_4c_ChkInativos.Value   = 0
        CATCH TO loc_oErro
            MsgErro("Erro ao limpar campos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida e salva os acessos do JOB (botao Confirmar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_cIClis, loc_cMsgDup
        loc_lSucesso = .F.

        loc_cIClis = ALLTRIM(THIS.this_oBusinessObject.this_cIClis)
        IF EMPTY(loc_cIClis)
            MsgAviso("Nenhum JOB selecionado para salvar.", "")
            RETURN .F.
        ENDIF

        loc_cMsgDup = THIS.this_oBusinessObject.ValidarUnicidadeUsuario()
        IF !EMPTY(loc_cMsgDup)
            MsgAviso(loc_cMsgDup, "Aten" + CHR(231) + CHR(227) + "o!!!")
            RETURN .F.
        ENDIF

        THIS.FormParaBO()
        TRY
            IF THIS.this_oBusinessObject.SalvarAcessos(loc_cIClis)
                MsgInfo("Acessos do JOB [" + loc_cIClis + "] salvos com sucesso.", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF USED("cursor_4c_AcJ")
            USE IN cursor_4c_AcJ
        ENDIF
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGridUsuarios - Vincula cursor_4c_AcJ ao grd_4c_Usuarios
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGridUsuarios()
        LOCAL loc_oGrid, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios

            IF !USED("cursor_4c_AcJ")
                SET NULL ON
                CREATE CURSOR cursor_4c_AcJ (pkChaves C(20), JOBs C(20), Usuars C(20), NComps C(30))
                SET NULL OFF
            ENDIF

            loc_oGrid.ColumnCount = 3
            loc_oGrid.RecordSource = "cursor_4c_AcJ"
            WITH loc_oGrid
                .Column1.ControlSource   = "cursor_4c_AcJ.Usuars"
                .Column1.Width           = 120
                .Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
                .Column2.ControlSource   = "cursor_4c_AcJ.NComps"
                .Column2.Width           = 200
                .Column2.Header1.Caption = "Nome"
            ENDWITH

            loc_oGrid.Refresh()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar grid de usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirUsuarioClick - Adiciona linha em branco no grid de usuarios
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirUsuarioClick()
        IF THIS.this_cModoAtual != "ALTERAR"
            RETURN
        ENDIF

        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_AcJ")
                SET NULL ON
                CREATE CURSOR cursor_4c_AcJ (pkChaves C(20), JOBs C(20), Usuars C(20), NComps C(30))
                SET NULL OFF
            ENDIF

            SELECT cursor_4c_AcJ
            GO TOP IN cursor_4c_AcJ
            LOCATE FOR EMPTY(ALLTRIM(Usuars)) AND !DELETED()
            IF EOF("cursor_4c_AcJ")
                APPEND BLANK IN cursor_4c_AcJ
            ENDIF

            THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
            THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Column1.SetFocus()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirUsuarioClick - Remove linha atual do grid de usuarios
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirUsuarioClick()
        IF THIS.this_cModoAtual != "ALTERAR"
            RETURN
        ENDIF

        LOCAL loc_lSucesso, loc_nRec
        loc_lSucesso = .F.

        IF !USED("cursor_4c_AcJ") OR EOF("cursor_4c_AcJ")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_AcJ
            IF !EOF("cursor_4c_AcJ")
                loc_nRec = RECNO("cursor_4c_AcJ")
                DELETE IN cursor_4c_AcJ
                GO TOP IN cursor_4c_AcJ
                IF m.loc_nRec <= RECCOUNT("cursor_4c_AcJ")
                    GO m.loc_nRec IN cursor_4c_AcJ
                ENDIF
            ENDIF

            THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
            THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Column1.SetFocus()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdUsuariosColumn1When - Controla editabilidade da coluna Usuarios
    *--------------------------------------------------------------------------
    PROCEDURE GrdUsuariosColumn1When()
        RETURN (THIS.this_cModoAtual = "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdUsuariosColumn1Valid - Lookup de usuario pela coluna Usuarios (SigCdUsu)
    *--------------------------------------------------------------------------
    PROCEDURE GrdUsuariosColumn1Valid()
        LOCAL loc_oBusca, loc_cUsuario, loc_lResultado
        loc_lResultado = .T.

        IF !USED("cursor_4c_AcJ") OR THIS.this_cModoAtual != "ALTERAR"
            RETURN .T.
        ENDIF

        TRY
            SELECT cursor_4c_AcJ
            loc_cUsuario = ALLTRIM(cursor_4c_AcJ.Usuars)

            IF !EMPTY(loc_cUsuario)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", loc_cUsuario, ;
                    "Sele" + CHR(231) + CHR(227) + "o")

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lAchouRegistro
                        IF USED("cursor_4c_BuscaUsu")
                            REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
                            REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
                        ENDIF
                    ELSE
                        loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
                        loc_oBusca.mAddColuna("NComps",   "", "Nome")
                        loc_oBusca.Show()

                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                            REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
                            REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
                        ELSE
                            REPLACE Usuars WITH "" IN cursor_4c_AcJ
                            REPLACE NComps WITH "" IN cursor_4c_AcJ
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_BuscaUsu")
                        USE IN cursor_4c_BuscaUsu
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                REPLACE NComps WITH "" IN cursor_4c_AcJ
            ENDIF

            THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
        CATCH TO loc_oErro
            MsgErro("Erro ao validar usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdUsuariosColumn2When - Controla editabilidade da coluna Nome
    * Editavel apenas em ALTERAR + quando Usuars da linha esta vazio
    *--------------------------------------------------------------------------
    PROCEDURE GrdUsuariosColumn2When()
        IF THIS.this_cModoAtual != "ALTERAR"
            RETURN .F.
        ENDIF
        IF !USED("cursor_4c_AcJ") OR EOF("cursor_4c_AcJ")
            RETURN .F.
        ENDIF
        SELECT cursor_4c_AcJ
        RETURN EMPTY(ALLTRIM(cursor_4c_AcJ.Usuars))
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdUsuariosColumn2Valid - Lookup de usuario pelo Nome na coluna NComps
    *--------------------------------------------------------------------------
    PROCEDURE GrdUsuariosColumn2Valid()
        LOCAL loc_oBusca, loc_cNome, loc_lResultado
        loc_lResultado = .T.

        IF !USED("cursor_4c_AcJ") OR THIS.this_cModoAtual != "ALTERAR"
            RETURN .T.
        ENDIF

        TRY
            SELECT cursor_4c_AcJ
            loc_cNome = ALLTRIM(cursor_4c_AcJ.NComps)

            IF !EMPTY(loc_cNome)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdUsu", "cursor_4c_BuscaUsu", "NComps", loc_cNome, ;
                    "Sele" + CHR(231) + CHR(227) + "o")

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lAchouRegistro
                        IF USED("cursor_4c_BuscaUsu")
                            REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
                            REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
                        ENDIF
                    ELSE
                        loc_oBusca.mAddColuna("NComps",   "", "Nome")
                        loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
                        loc_oBusca.Show()

                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                            REPLACE NComps WITH ALLTRIM(cursor_4c_BuscaUsu.NComps)   IN cursor_4c_AcJ
                            REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.Usuarios) IN cursor_4c_AcJ
                        ELSE
                            REPLACE NComps WITH "" IN cursor_4c_AcJ
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_BuscaUsu")
                        USE IN cursor_4c_BuscaUsu
                    ENDIF
                    loc_oBusca.Release()
                ENDIF

                THIS.pgf_4c_Paginas.Page2.grd_4c_Usuarios.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar nome:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_GradeJOB")
            USE IN cursor_4c_GradeJOB
        ENDIF
        IF USED("cursor_4c_AcJ")
            USE IN cursor_4c_AcJ
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ACJBO.prg):
*==============================================================================
* ACJBO.prg - Business Object para Acessos de JOB
* Tabela principal: SigCdAcJ | PK: pkChaves
* Lista de JOBs: SigCdCli (filtro SigCdGcr.Coletors=10)
*==============================================================================

DEFINE CLASS ACJBO AS BusinessBase

    *-- Propriedades do JOB selecionado (display - SigCdCli via crGradeJOB)
    this_cGrupos        = ""    && Grupos    CHAR  - Grupo do JOB
    this_cIClis         = ""    && IClis     CHAR  - C" + CHR(243) + "digo do JOB (PK em SigCdCli)
    this_cRClis         = ""    && RClis     CHAR  - C" + CHR(243) + "digo abreviado
    this_cRazaos        = ""    && Razaos    CHAR  - Descritivo do JOB
    this_cUsuarsCriador = ""    && Usuars    CHAR  - Usu" + CHR(225) + "rio que criou o JOB
    this_dDataIncs      = {}    && DataIncs  DATE  - Data de inclus" + CHR(227) + "o
    this_lInativas      = .F.   && Inativas  NUM   - Inativo (0=N, 1=S)

    *-- Propriedades de controle de acesso (SigCdAcJ)
    this_cPkChaves      = ""    && pkChaves  CHAR  - Chave prim" + CHR(225) + "ria (gerada por fUniqueIds)
    this_cJOBs          = ""    && JOBs      CHAR  - FK para IClis do JOB
    this_cUsuars        = ""    && Usuars    CHAR  - Login do usu" + CHR(225) + "rio com acesso
    this_cNComps        = ""    && NComps    CHAR  - Nome completo (JOIN SigCdUsu.NComps)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdAcJ"
        THIS.this_cCampoChave = "pkChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves = TratarNulo(pkChaves, "C")
                THIS.this_cJOBs     = TratarNulo(JOBs,     "C")
                THIS.this_cUsuars   = TratarNulo(Usuars,   "C")
                THIS.this_cNComps   = TratarNulo(NComps,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarJobDoCursor - Carrega dados do JOB selecionado (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarJobDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cGrupos        = TratarNulo(Grupos,   "C")
                THIS.this_cIClis         = TratarNulo(IClis,    "C")
                THIS.this_cRClis         = TratarNulo(RClis,    "C")
                THIS.this_cRazaos        = TratarNulo(Razaos,   "C")
                THIS.this_cUsuarsCriador = TratarNulo(Usuars,   "C")
                THIS.this_dDataIncs      = TratarNulo(DataIncs, "D")
                THIS.this_lInativas      = (TratarNulo(Inativas, "N") = 1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar JOB do cursor:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de JOBs (SigCdCli filtrado por Coletors=10)
    * Cursor destino: cursor_4c_GradeJOB
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Grupos, a.IClis, a.RClis, a.Razaos," + ;
                       " a.Inativas, a.Usuars, a.DataIncs" + ;
                       " FROM SigCdGcr b, SigCdCli a" + ;
                       " WHERE b.Coletors = 10" + ;
                       " AND b.Codigos = a.Grupos"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND (a.IClis LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                           " OR a.Razaos LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.IClis"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GradeJOB")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar JOBs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar JOBs:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAcessos - Carrega usu" + CHR(225) + "rios com acesso ao JOB
    * Cursor destino: cursor_4c_AcJ
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAcessos(par_cIClis)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cIClis))
                MsgAviso("C" + CHR(243) + "digo do JOB n" + CHR(227) + "o informado.")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "SELECT a.pkChaves, a.JOBs, a.Usuars, b.NComps" + ;
                       " FROM SigCdAcJ a" + ;
                       " LEFT JOIN SigCdUsu b ON a.Usuars = b.Usuarios" + ;
                       " WHERE a.JOBs = " + EscaparSQL(ALLTRIM(par_cIClis)) + ;
                       " ORDER BY a.Usuars"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcJ")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAcessos - Salva lista de usu" + CHR(225) + "rios com acesso ao JOB
    * Estrat" + CHR(233) + "gia: DELETE todos os existentes + INSERT dos atuais
    * Par" + CHR(226) + "metro: par_cIClis - c" + CHR(243) + "digo do JOB
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAcessos(par_cIClis)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cPkChaves
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cIClis))
                MsgAviso("C" + CHR(243) + "digo do JOB n" + CHR(227) + "o informado.")
                loc_lSucesso = .F.
            ENDIF

            *-- 1. Deletar todos os acessos antigos para este JOB
            loc_cSQL = "DELETE FROM SigCdAcJ WHERE JOBs = " + EscaparSQL(ALLTRIM(par_cIClis))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir acessos antigos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Inserir registros atuais do cursor (somente com Usuars preenchido e nao deletados)
            IF USED("cursor_4c_AcJ") AND RECCOUNT("cursor_4c_AcJ") > 0
                SELECT cursor_4c_AcJ
                GO TOP
                DO WHILE !EOF("cursor_4c_AcJ")
                    IF !DELETED() AND !EMPTY(ALLTRIM(cursor_4c_AcJ.Usuars))
                        loc_cPkChaves = ALLTRIM(cursor_4c_AcJ.pkChaves)
                        IF EMPTY(loc_cPkChaves)
                            loc_cPkChaves = SYS(2015) + SYS(2015)
                        ENDIF

                        loc_cSQL = "INSERT INTO SigCdAcJ (pkChaves, JOBs, Usuars)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cIClis)) + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_AcJ.Usuars)) + ;
                                   ")"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir acesso para usu" + CHR(225) + "rio " + ;
                                   ALLTRIM(cursor_4c_AcJ.Usuars) + ":" + CHR(13) + ;
                                   CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                    SKIP IN cursor_4c_AcJ
                ENDDO
            ENDIF

            THIS.RegistrarAuditoria("UPDATE")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirAcessos - Remove todos os acessos de um JOB
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirAcessos(par_cIClis)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cIClis))
                MsgAviso("C" + CHR(243) + "digo do JOB n" + CHR(227) + "o informado.")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigCdAcJ WHERE JOBs = " + EscaparSQL(ALLTRIM(par_cIClis))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir acessos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Inserir registro individual (chamado pelo BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = SYS(2015) + SYS(2015)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdAcJ (pkChaves, JOBs, Usuars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cPkChaves) + ", " + ;
                       EscaparSQL(THIS.this_cJOBs) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualizar registro individual (chamado pelo BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdAcJ SET" + ;
                       " JOBs = " + EscaparSQL(THIS.this_cJOBs) + "," + ;
                       " Usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
                       " WHERE pkChaves = " + EscaparSQL(THIS.this_cPkChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro individual (chamado pelo BusinessBase.Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdAcJ WHERE pkChaves = " + EscaparSQL(THIS.this_cPkChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega acesso pela chave prim" + CHR(225) + "ria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cPkChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.pkChaves, a.JOBs, a.Usuars, b.NComps" + ;
                       " FROM SigCdAcJ a" + ;
                       " LEFT JOIN SigCdUsu b ON a.Usuars = b.Usuarios" + ;
                       " WHERE a.pkChaves = " + EscaparSQL(ALLTRIM(par_cPkChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUnicidadeUsuario - Verifica usu" + CHR(225) + "rios duplicados no cursor local
    * Retorna "" se OK, ou mensagem de erro se houver duplicata
    *--------------------------------------------------------------------------
    PROCEDURE ValidarUnicidadeUsuario()
        LOCAL loc_cMensagem, loc_lSucesso
        loc_cMensagem = ""
        loc_lSucesso  = .F.

        TRY
            IF !USED("cursor_4c_AcJ")
                loc_lSucesso = ""
            ENDIF

            SELECT SUM(1) AS Soma, Usuars ;
              FROM cursor_4c_AcJ ;
             WHERE !DELETED() AND !EMPTY(ALLTRIM(Usuars)) ;
             GROUP BY Usuars ;
              INTO CURSOR cursor_4c_DuplAcJ

            GO TOP IN cursor_4c_DuplAcJ
            SELECT cursor_4c_DuplAcJ
            LOCATE FOR cursor_4c_DuplAcJ.Soma > 1
            IF !EOF("cursor_4c_DuplAcJ")
                loc_cMensagem = "O Usu" + CHR(225) + "rio """ + ;
                               ALLTRIM(cursor_4c_DuplAcJ.Usuars) + ;
                               """ est" + CHR(225) + " duplicado na grade!!!"
            ENDIF

            IF USED("cursor_4c_DuplAcJ")
                USE IN cursor_4c_DuplAcJ
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar unicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cMensagem
    ENDPROC

ENDDEFINE

