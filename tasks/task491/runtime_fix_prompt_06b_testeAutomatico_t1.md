# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: teste_resultado.json nao gerado (exit code 0). VFP pode ter crashado antes de escrever resultado.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-22 13:38:20] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-22 13:38:20] [INFO] Config FPW: (nao fornecido)
[2026-08-22 13:38:20] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 13:38:20] [INFO] Timeout: 300 segundos
[2026-08-22 13:38:20] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jnenz54a.prg
[2026-08-22 13:38:20] [INFO] Conteudo do wrapper:
[2026-08-22 13:38:20] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formorl', 'C:\4c\tasks\task491', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formorl', 'C:\4c\tasks\task491', 'CRUD'
QUIT

[2026-08-22 13:38:20] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jnenz54a.prg
[2026-08-22 13:38:20] [INFO] VFP output esperado em: C:\4c\tasks\task491\vfp_output.txt
[2026-08-22 13:38:20] [INFO] Executando Visual FoxPro 9...
[2026-08-22 13:38:20] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jnenz54a.prg
[2026-08-22 13:38:20] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jnenz54a.prg
[2026-08-22 13:38:20] [INFO] Timeout configurado: 300 segundos
[2026-08-22 13:38:30] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-22 13:38:30] [INFO] VFP9 finalizado em 9.58631 segundos
[2026-08-22 13:38:30] [INFO] Exit Code: 
[2026-08-22 13:38:30] [INFO] 
[2026-08-22 13:38:30] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-22 13:38:30] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jnenz54a.prg
[2026-08-22 13:38:30] [INFO] 
[2026-08-22 13:38:30] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-22 13:38:30] [INFO] * Auto-generated wrapper for parameters
[2026-08-22 13:38:30] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 13:38:30] [INFO] * Parameters: 'Formorl', 'C:\4c\tasks\task491', 'CRUD'
[2026-08-22 13:38:30] [INFO] 
[2026-08-22 13:38:30] [INFO] * Anti-dialog protections for unattended execution
[2026-08-22 13:38:30] [INFO] SET SAFETY OFF
[2026-08-22 13:38:30] [INFO] SET RESOURCE OFF
[2026-08-22 13:38:30] [INFO] SET TALK OFF
[2026-08-22 13:38:30] [INFO] SET NOTIFY OFF
[2026-08-22 13:38:30] [INFO] SYS(2335, 0)
[2026-08-22 13:38:30] [INFO] 
[2026-08-22 13:38:30] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formorl', 'C:\4c\tasks\task491', 'CRUD'
[2026-08-22 13:38:30] [INFO] QUIT
[2026-08-22 13:38:30] [INFO] 
[2026-08-22 13:38:30] [INFO] === Fim do Wrapper.prg ===
[2026-08-22 13:38:30] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\cadastros\Formorl.prg):
*==============================================================================
* Formorl.prg - Cadastro de Origem
*==============================================================================
* Migrado de: SIGCDOCS.SCX / sigcdorl
* Tabela: SigCdOrl
* Cursor: CrSigCdOrl
* Tipo: CRUD (frmcadastro)
*==============================================================================

DEFINE CLASS Formorl AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Origem"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - Delegado ao FormBase (que chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MostrarErro(loException, "Formorl.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("orlBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao instanciar orlBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF !THIS.CarregarLista()
                        *-- Falha ao carregar nao impede abertura do form
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formorl.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption = "Lista"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption = "Dados"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD e Grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (cntSombra no legado)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 2
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 12
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
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
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container botoes CRUD (Grupo_Op no legado) - lado direito
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 0
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
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
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
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
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
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
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
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
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
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
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
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

        *-- Container saida - padrao canonico (Left=917, Width=90)
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
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Grid de listagem (grade no legado - CrSigCdOrl com cods/descs)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 2

        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 12
            .Width              = 900
            .Height             = 490
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

            WITH .Column1
                .Width              = 90
                .Alignment          = 0
                .Header1.Caption    = "C" + CHR(243) + "digo"
            ENDWITH

            WITH .Column2
                .Width              = 337
                .Alignment          = 0
                .Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH
        ENDWITH

        *-- BINDEVENT para botoes CRUD (metodos devem ser PUBLIC)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2 com container de botoes de acao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes de acao (Grupo_Salva no legado)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
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
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
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
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
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

        *-- Label Codigo (Say1 no legado: top=124, left=215 -> +29 compensacao = 153)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 153
            .Left      = 215
            .Width     = 48
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (Get_codigo no legado: top=121, left=263, w=72, h=23 -> +29 = 150)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value     = ""
            .Top       = 150
            .Left      = 263
            .Width     = 72
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 5
            .Visible   = .T.
        ENDWITH

        *-- Label Descricao (Say2 no legado: top=149, left=202 -> +29 = 178)
        loc_oPagina.AddObject("lbl_4c_Desc", "Label")
        WITH loc_oPagina.lbl_4c_Desc
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 178
            .Left      = 202
            .Width     = 61
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (Get_desc no legado: top=146, left=263, w=240, h=23 -> +29 = 175)
        loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oPagina.txt_4c_Desc
            .Value     = ""
            .Top       = 175
            .Left      = 263
            .Width     = 240
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 50
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENT para botoes de Page2
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
                    loc_oGrid.Column1.Width = 90
                    loc_oGrid.Column2.Width = 337
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formorl.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formorl.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do Grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Abre Page2 em modo INCLUIR
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            *-- Legado: INSERIR -> foco no codigo
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigo", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formorl.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo VISUALIZAR
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Visualizar")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                ELSE
                    MsgErro("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formorl.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Alterar")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                    *-- Legado: ALTERAR -> foco na descricao (codigo bloqueado)
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Desc", 5)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Desc.SetFocus()
                    ENDIF
                ELSE
                    MsgErro("Registro n" + CHR(227) + "o encontrado.", "Alterar")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formorl.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirmado
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Excluir")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
                loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro " + ;
                    CHR(34) + loc_cCodigo + CHR(34) + "?", "Excluir")
                IF loc_lConfirmado
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                            THIS.CarregarLista()
                        ELSE
                            MsgErro("Erro ao excluir o registro.", "Excluir")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formorl.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Filtra lista pelo codigo ou descricao informados
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cFiltro = INPUTBOX("Informe o c" + CHR(243) + "digo ou descri" + ;
                CHR(231) + CHR(227) + "o para busca:", "Buscar", "")
            IF !EMPTY(ALLTRIM(loc_cFiltro))
                IF THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
                    LOCAL loc_oGrid
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
                    loc_oGrid.Column1.Width = 90
                    loc_oGrid.Column2.Width = 337
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ELSE
                    MsgAviso("Nenhum registro encontrado para o filtro informado.", "Buscar")
                ENDIF
            ELSE
                THIS.CarregarLista()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formorl.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva o registro (Inserir ou Atualizar)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        TRY
            IF !THIS.ValidarCampos()
                *-- Validacao falhou, mensagem ja exibida em ValidarCampos
            ELSE
                THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Registro salvo com sucesso!", "Salvar")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AlternarPagina(1)
                ELSE
                    MsgErro("Erro ao salvar o registro.", "Salvar")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formorl.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do Form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        THIS.this_oBusinessObject.this_cCodigo   = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Desc.Value)
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para o Form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oPagina.txt_4c_Codigo.Value = THIS.this_oBusinessObject.this_cCodigo
        loc_oPagina.txt_4c_Desc.Value   = THIS.this_oBusinessObject.this_cDescricao
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores dos campos de Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Desc", 5)
            loc_oPagina.txt_4c_Desc.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de Page2
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lCodigo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        *-- Codigo so habilitado no modo INCLUIR (nao se pode alterar PK)
        loc_lCodigo = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.Enabled = loc_lCodigo
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Desc", 5)
            loc_oPagina.txt_4c_Desc.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarCampos - Valida campos obrigatorios antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarCampos()
        LOCAL loc_oPagina, loc_lValido
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lValido = .T.

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Codigo.Value))
                MsgAviso("C" + CHR(243) + "digo " + CHR(233) + " obrigat" + CHR(243) + "rio!", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_Codigo.SetFocus()
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lModoVisualizar
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_lModoVisualizar = (THIS.this_cModoAtual = "VISUALIZAR")

        IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = !loc_lModoVisualizar
        ENDIF
        IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Percorre Pages de PageFrames e Controls de Containers
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
    * Destroy - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loException
            *-- Ignorar erros no Destroy para nao bloquear finalizacao
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\orlBO.prg):
*====================================================================
* orlBO.prg
*
* Business Object para Cadastro de Origem
* Tabela: sigcdorl
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS orlBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela sigcdorl)
    this_cCodigo    = ""    && cods char(10) - codigo de origem (chave de negocio)
    this_cCodChaves = ""    && cidchaves char(20) - PK tecnica gerada por fUniqueIds()
    this_cDescricao = ""    && descs char(40)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "sigcdorl"
            THIS.this_cCampoChave = "cods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "orlBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = TratarNulo(cods,      "C")
                THIS.this_cCodChaves = TratarNulo(cidchaves, "C")
                THIS.this_cDescricao = TratarNulo(descs,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "orlBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Buscar - SELECT de registros (suporta filtro parcial por cods/descs)
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT cods, cidchaves, descs" + ;
                       " FROM sigcdorl"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                    " WHERE cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cods"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult < 0
                MostrarErro("Erro ao buscar origens:" + CHR(13) + CapturarErroSQL(), "orlBO.Buscar")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "orlBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo de negocio (cods)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cods, cidchaves, descs" + ;
                       " FROM sigcdorl" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult < 0
                MostrarErro("Erro ao carregar origem:" + CHR(13) + CapturarErroSQL(), "orlBO.CarregarPorCodigo")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "orlBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * VerificarCodigoDuplicado - Verifica se cods ja existe (apenas no INSERT)
    *====================================================================
    FUNCTION VerificarCodigoDuplicado()
        LOCAL loc_lDuplicado, loc_cSQL, loc_nResult
        loc_lDuplicado = .F.

        TRY
            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM sigcdorl" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Chk") > 0
                SELECT cursor_4c_Chk
                loc_lDuplicado = (cursor_4c_Chk.qtd > 0)
            ENDIF

            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "orlBO.VerificarCodigoDuplicado")
        ENDTRY

        RETURN loc_lDuplicado
    ENDFUNC

    *====================================================================
    * Inserir - INSERT de um novo registro em sigcdorl
    * Gera cidchaves via fUniqueIds()
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF THIS.VerificarCodigoDuplicado()
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                loc_lSucesso = .F.
            ELSE
                THIS.this_cCodChaves = fUniqueIds()

                loc_cSQL = "INSERT INTO sigcdorl" + ;
                           " (cods, cidchaves, descs)" + ;
                           " VALUES (" + ;
                           EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cCodChaves)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MostrarErro("Erro ao inserir origem:" + CHR(13) + CapturarErroSQL(), "orlBO.Inserir")
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "orlBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE do registro em sigcdorl (identifica por cods)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdorl SET" + ;
                       " descs = " + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MostrarErro("Erro ao atualizar origem:" + CHR(13) + CapturarErroSQL(), "orlBO.Atualizar")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "orlBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE do registro em sigcdorl
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM sigcdorl" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MostrarErro("Erro ao excluir origem:" + CHR(13) + CapturarErroSQL(), "orlBO.ExecutarExclusao")
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "orlBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Destroy - Libera cursores
    *====================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_Chk")
            USE IN cursor_4c_Chk
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

