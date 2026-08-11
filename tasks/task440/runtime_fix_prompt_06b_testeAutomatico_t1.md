# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: TIMEOUT: VFP9 travou durante teste automatico (300s). Possivel erro de runtime (Property not found, dialog modal).

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-07 23:02:28] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-07 23:02:28] [INFO] Config FPW: (nao fornecido)
[2026-08-07 23:02:28] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-07 23:02:28] [INFO] Timeout: 300 segundos
[2026-08-07 23:02:28] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qxm43o0n.prg
[2026-08-07 23:02:28] [INFO] Conteudo do wrapper:
[2026-08-07 23:02:28] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formgpr', 'C:\4c\tasks\task440', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formgpr', 'C:\4c\tasks\task440', 'CRUD'
QUIT

[2026-08-07 23:02:28] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qxm43o0n.prg
[2026-08-07 23:02:28] [INFO] VFP output esperado em: C:\4c\tasks\task440\vfp_output.txt
[2026-08-07 23:02:28] [INFO] Executando Visual FoxPro 9...
[2026-08-07 23:02:28] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qxm43o0n.prg
[2026-08-07 23:02:28] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qxm43o0n.prg
[2026-08-07 23:02:28] [INFO] Timeout configurado: 300 segundos
[2026-08-07 23:07:28] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 11428)...
[2026-08-07 23:07:30] [INFO] VFP9 finalizado em 302.0516124 segundos
[2026-08-07 23:07:30] [INFO] Exit Code: 4
[2026-08-07 23:07:30] [INFO] 
[2026-08-07 23:07:30] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-07 23:07:30] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qxm43o0n.prg
[2026-08-07 23:07:30] [INFO] 
[2026-08-07 23:07:30] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-07 23:07:30] [INFO] * Auto-generated wrapper for parameters
[2026-08-07 23:07:30] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-07 23:07:30] [INFO] * Parameters: 'Formgpr', 'C:\4c\tasks\task440', 'CRUD'
[2026-08-07 23:07:30] [INFO] 
[2026-08-07 23:07:30] [INFO] * Anti-dialog protections for unattended execution
[2026-08-07 23:07:30] [INFO] SET SAFETY OFF
[2026-08-07 23:07:30] [INFO] SET RESOURCE OFF
[2026-08-07 23:07:30] [INFO] SET TALK OFF
[2026-08-07 23:07:30] [INFO] SET NOTIFY OFF
[2026-08-07 23:07:30] [INFO] SYS(2335, 0)
[2026-08-07 23:07:30] [INFO] 
[2026-08-07 23:07:30] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formgpr', 'C:\4c\tasks\task440', 'CRUD'
[2026-08-07 23:07:30] [INFO] QUIT
[2026-08-07 23:07:30] [INFO] 
[2026-08-07 23:07:30] [INFO] === Fim do Wrapper.prg ===
[2026-08-07 23:07:30] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\cadastros\Formgpr.prg):
*==============================================================================
* Formgpr.prg - Formulario de Cadastro de Grande Grupo
* Tabela: SigCdGpr (codigos, descs, linhas + propriedades de produto)
* Herdado de: FormBase (arquitetura em camadas - PILAR 3)
* FASE 4/8: Grid e Botoes CRUD (Page1 completa + botoes Page2)
*==============================================================================
DEFINE CLASS Formgpr AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity: Width=1000, Height=600 do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Grande Grupo"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Business Object e modo de operacao
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - DODEFAULT() ja chama InicializarForm() via FormBase.Init()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao completa do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("gprBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar gprBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Falha ao carregar nao impede abertura do formulario
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formgpr:" + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                        loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * PageFrame.Top = -29 (canonico) para esconder abas
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
    * ConfigurarPaginaLista - Page1: cabecalho, container botoes e saida
    * Todos os Top compensados +29 (PageFrame.Top=-29)
    * Original: cntSombra.Top=1, Grupo_op.Top=0, Grupo_Saida.Left=918
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho escuro (cntSombra: Top=1+29=30, Width=1008 do original)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = 0
            .Width       = 1008
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Cadastro de Grande Grupo"
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Grande Grupo"
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_op: Left=512, Top=0+29=29, Width=414, Height=85)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 414
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

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
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

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
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

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
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

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
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

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
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container saida canonico (CLAUDE.md #10: Left=917, Width=90, Height=85)
        *-- Grupo_Saida.Left=918 no original -> usar 917 canonico
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
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista (Grade legado: top=121+29=150, left=12, width=939, height=470)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 150
            .Left               = 12
            .Width              = 939
            .Height             = 470
            .ColumnCount        = 3
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
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH
        loc_oPagina.grd_4c_Lista.Column1.Width = 79
        loc_oPagina.grd_4c_Lista.Column2.Width = 290
        loc_oPagina.grd_4c_Lista.Column3.Width = 80

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: botoes + primeira metade dos campos
    * Grupo_Salva: Left=816, Top=9+29=38, Width=165, Height=85
    * Fase 5/8: txt_4c_Codigos ate opt_4c_AlteEtiq (Top original 85-225)
    * Todos os Top compensados +29 (PageFrame.Top=-29)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container salvar/cancelar (Grupo_Salva: Left=816, Top=9+29=38)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 38
            .Left        = 816
            .Width       = 165
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *======================================================================
        * FAIXA 1: Codigo e Descricao (original Top=85/90, compensado 114/119)
        *======================================================================

        *-- txt_4c_Codigos (getCodigos: top=85+29=114, left=294, width=30)
        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Value         = ""
            .Top           = 114
            .Left          = 294
            .Width         = 30
            .Height        = 25
            .MaxLength     = 3
            .InputMask     = "XXX"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Codigo (Say1: top=90+29=119, left=248)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 119
            .Left      = 248
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Descricao (getDescs: top=85+29=114, left=405, width=290)
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Top           = 114
            .Left          = 405
            .Width         = 290
            .Height        = 25
            .MaxLength     = 40
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Descricao (Say2: top=90+29=119, left=345)
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 119
            .Left      = 345
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * FAIXA 2: Produto Padrao de Conserto (original Top=113/117, comp 142/146)
        * Lookup em SigCdPro (CPros/DPros)
        *======================================================================

        *-- txt_4c_CodConPads (getCodConPads: top=113+29=142, left=294, width=108)
        loc_oPagina.AddObject("txt_4c_CodConPads", "TextBox")
        WITH loc_oPagina.txt_4c_CodConPads
            .Value         = ""
            .Top           = 142
            .Left          = 294
            .Width         = 108
            .Height        = 25
            .MaxLength     = 14
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CodConPads, "KeyPress", THIS, "AbrirLookupCodConPads")

        *-- lbl_4c_CodConPads (Say3: top=117+29=146, left=144)
        loc_oPagina.AddObject("lbl_4c_CodConPads", "Label")
        WITH loc_oPagina.lbl_4c_CodConPads
            .Caption   = "Produto Padr" + CHR(227) + "o de Conserto :"
            .Top       = 146
            .Left      = 144
            .Width     = 146
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_DCodConPads (getDCodConPads: top=113+29=142, left=405, width=290)
        loc_oPagina.AddObject("txt_4c_DCodConPads", "TextBox")
        WITH loc_oPagina.txt_4c_DCodConPads
            .Value         = ""
            .Top           = 142
            .Left          = 405
            .Width         = 290
            .Height        = 25
            .MaxLength     = 40
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DCodConPads, "KeyPress", THIS, "AbrirLookupDCodConPads")

        *======================================================================
        * FAIXA 3: Linha Padrao de Cadastro (original Top=141/144, comp 170/173)
        * Lookup em SigCdLin (Linhas/Descs)
        *======================================================================

        *-- txt_4c_Lin (GetLin: top=141+29=170, left=294, width=108, height=23)
        loc_oPagina.AddObject("txt_4c_Lin", "TextBox")
        WITH loc_oPagina.txt_4c_Lin
            .Value         = ""
            .Top           = 170
            .Left          = 294
            .Width         = 108
            .Height        = 23
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Lin, "KeyPress", THIS, "AbrirLookupLin")

        *-- lbl_4c_Lin (Say16: top=144+29=173, left=157)
        loc_oPagina.AddObject("lbl_4c_Lin", "Label")
        WITH loc_oPagina.lbl_4c_Lin
            .Caption   = "Linha Padr" + CHR(227) + "o de Cadastro :"
            .Top       = 173
            .Left      = 157
            .Width     = 133
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_DLin (GetDLin: top=141+29=170, left=405, width=290, height=23)
        loc_oPagina.AddObject("txt_4c_DLin", "TextBox")
        WITH loc_oPagina.txt_4c_DLin
            .Value         = ""
            .Top           = 170
            .Left          = 405
            .Width         = 290
            .Height        = 23
            .MaxLength     = 40
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DLin, "KeyPress", THIS, "AbrirLookupDLin")

        *======================================================================
        * FAIXA 4: Digito CodAut + Prioridade (original Top=167/172, comp 196/201)
        *======================================================================

        *-- txt_4c_CodAut (Get_CodAut: top=167+29=196, left=294, width=18)
        loc_oPagina.AddObject("txt_4c_CodAut", "TextBox")
        WITH loc_oPagina.txt_4c_CodAut
            .Value         = ""
            .Top           = 196
            .Left          = 294
            .Width         = 18
            .Height        = 25
            .MaxLength     = 1
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_CodAut (Say6: top=172+29=201, left=105)
        loc_oPagina.AddObject("lbl_4c_CodAut", "Label")
        WITH loc_oPagina.lbl_4c_CodAut
            .Caption   = "D" + CHR(237) + "gito do Produto C" + CHR(243) + "digo Autom" + CHR(225) + "tico :"
            .Top       = 201
            .Left      = 105
            .Width     = 185
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Prioridade (Get_prioridade: top=167+29=196, left=522, width=17)
        loc_oPagina.AddObject("txt_4c_Prioridade", "TextBox")
        WITH loc_oPagina.txt_4c_Prioridade
            .Value         = 0
            .Top           = 196
            .Left          = 522
            .Width         = 17
            .Height        = 25
            .MaxLength     = 1
            .InputMask     = "9"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Prioridade (Say11: top=172+29=201, left=330)
        loc_oPagina.AddObject("lbl_4c_Prioridade", "Label")
        WITH loc_oPagina.lbl_4c_Prioridade
            .Caption   = "Prioridade de Rec" + CHR(225) + "lculo de Saldo (0/1) :"
            .Top       = 201
            .Left      = 330
            .Width     = 191
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * FAIXA 5: Bloquear Etiqueta Individual (original Top=194/199, comp 223/228)
        * opt_4c_BlqEtq -> this_nBarrefs (0=Sim, 1=Nao; default Nao=Value 2)
        *======================================================================

        *-- opt_4c_BlqEtq (Get_BlqEtq: top=194+29=223, left=289, width=92)
        loc_oPagina.AddObject("opt_4c_BlqEtq", "OptionGroup")
        WITH loc_oPagina.opt_4c_BlqEtq
            .ButtonCount = 2
            .Value       = 2
            .Top         = 223
            .Left        = 289
            .Width       = 94
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_BlqEtq.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 34
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_BlqEtq.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 50
            .Top       = 5
            .Width     = 34
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- lbl_4c_BlqEtq (Say10: top=199+29=228, left=98)
        loc_oPagina.AddObject("lbl_4c_BlqEtq", "Label")
        WITH loc_oPagina.lbl_4c_BlqEtq
            .Caption   = "Bloquear Altera" + CHR(231) + CHR(227) + "o Etiqueta Individual :"
            .Top       = 228
            .Left      = 98
            .Width     = 192
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * FAIXA 6: Permite Alterar Dados da Etiqueta (original Top=220/225, comp 249/254)
        * opt_4c_AlteEtiq -> this_nAltetiqs (0=Sim, 1=Nao; default Nao=Value 2)
        *======================================================================

        *-- opt_4c_AlteEtiq (fwoption4: top=220+29=249, left=288, width=92)
        loc_oPagina.AddObject("opt_4c_AlteEtiq", "OptionGroup")
        WITH loc_oPagina.opt_4c_AlteEtiq
            .ButtonCount = 2
            .Value       = 2
            .Top         = 249
            .Left        = 288
            .Width       = 94
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_AlteEtiq.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 34
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH
        WITH loc_oPagina.opt_4c_AlteEtiq.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 50
            .Top       = 5
            .Width     = 34
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- lbl_4c_AlteEtiq (Say13: top=225+29=254, left=118)
        loc_oPagina.AddObject("lbl_4c_AlteEtiq", "Label")
        WITH loc_oPagina.lbl_4c_AlteEtiq
            .Caption   = "Permite Alterar Dados da Etiqueta :"
            .Top       = 254
            .Left      = 118
            .Width     = 172
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * FAIXA 7: Ind" + CHR(250) + "stria / Material Principal
        * (Shape2 separador top=250+29=279; Label1 top=256+29=285; Get_MatPrincs top=268+29=297)
        *======================================================================

        *-- shp_4c_Separador (Shape2: top=250+29=279, left=9, height=1, width=980)
        loc_oPagina.AddObject("shp_4c_Separador", "Shape")
        WITH loc_oPagina.shp_4c_Separador
            .Top         = 279
            .Left        = 9
            .Height      = 1
            .Width       = 980
            .BackStyle   = 0
            .BorderColor = RGB(180, 180, 180)
            .Visible     = .T.
        ENDWITH

        *-- lbl_4c_Industria (Label1: top=256+29=285, left=101, width=54, bold)
        loc_oPagina.AddObject("lbl_4c_Industria", "Label")
        WITH loc_oPagina.lbl_4c_Industria
            .Caption   = "Ind" + CHR(250) + "stria"
            .Top       = 285
            .Left      = 101
            .Width     = 54
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_MatPrincs (Get_MatPrincs: top=268+29=297, left=294, width=108, MaxLength=14)
        loc_oPagina.AddObject("txt_4c_MatPrincs", "TextBox")
        WITH loc_oPagina.txt_4c_MatPrincs
            .Value         = ""
            .Top           = 297
            .Left          = 294
            .Width         = 108
            .Height        = 25
            .MaxLength     = 14
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_MatPrincs, "InteractiveChange", THIS, "AbrirLookupMatPrincs")
        BINDEVENT(loc_oPagina.txt_4c_MatPrincs, "KeyPress",          THIS, "AbrirLookupMatPrincs")

        *-- lbl_4c_MatPrincs (Say4: top=272+29=301, left=201, width=89)
        loc_oPagina.AddObject("lbl_4c_MatPrincs", "Label")
        WITH loc_oPagina.lbl_4c_MatPrincs
            .Caption   = "Material Principal :"
            .Top       = 301
            .Left      = 201
            .Width     = 89
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * FAIXA 8: Controla por Qtde (Cpq)
        * Opc_Cpq: top=291+29=320, left=289; Sim(legado Value=0)=ativo, N" + CHR(227) + "o(legado Value=1); default Value=2
        * -> this_nCpqtds: opt.Value=1 -> 0, opt.Value=2 -> 1
        *======================================================================

        *-- opt_4c_Cpq (Opc_Cpq: top=291+29=320, left=289)
        loc_oPagina.AddObject("opt_4c_Cpq", "OptionGroup")
        WITH loc_oPagina.opt_4c_Cpq
            .Value       = 2
            .Top         = 320
            .Left        = 289
            .Width       = 100
            .Height      = 20
            .ButtonCount = 2
            .BackStyle   = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption = "Sim"
                .Width   = 46
                .Height  = 20
            ENDWITH
            WITH .Buttons(2)
                .Caption = "N" + CHR(227) + "o"
                .Width   = 46
                .Height  = 20
                .Left    = 49
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        ENDWITH

        *-- lbl_4c_Cpq (Say5: top=296+29=325, left=190, width=100)
        loc_oPagina.AddObject("lbl_4c_Cpq", "Label")
        WITH loc_oPagina.lbl_4c_Cpq
            .Caption   = "Controla por Qtde. :"
            .Top       = 325
            .Left      = 190
            .Width     = 100
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * FAIXA 9: Aplica Falha Admitida (FalhaAdm) - INVERTIDO vs demais!
        * Opc_FalhaAdm: top=313+29=342, left=289; Sim=AplicFlhs 1, N" + CHR(227) + "o=AplicFlhs 0; default Value=1
        * -> this_nAplicflhs: opt.Value=1 -> 1, opt.Value=2 -> 0
        *======================================================================

        *-- opt_4c_FalhaAdm (Opc_FalhaAdm: top=313+29=342, left=289, default=1)
        loc_oPagina.AddObject("opt_4c_FalhaAdm", "OptionGroup")
        WITH loc_oPagina.opt_4c_FalhaAdm
            .Value       = 1
            .Top         = 342
            .Left        = 289
            .Width       = 100
            .Height      = 20
            .ButtonCount = 2
            .BackStyle   = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption = "Sim"
                .Width   = 46
                .Height  = 20
            ENDWITH
            WITH .Buttons(2)
                .Caption = "N" + CHR(227) + "o"
                .Width   = 46
                .Height  = 20
                .Left    = 49
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        ENDWITH

        *-- lbl_4c_FalhaAdm (Say7: top=318+29=347, left=180, width=110)
        loc_oPagina.AddObject("lbl_4c_FalhaAdm", "Label")
        WITH loc_oPagina.lbl_4c_FalhaAdm
            .Caption   = "Aplica Falha Admitida :"
            .Top       = 347
            .Left      = 180
            .Width     = 110
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * FAIXA 10: OF Obrigat" + CHR(243) + "rio na Pesagem (PesEnvs)
        * fwoption1: top=334+29=363, left=289; Sim(legado Value=0), N" + CHR(227) + "o(legado Value=1); default Value=2
        * -> this_nPesenvs: opt.Value=1 -> 0, opt.Value=2 -> 1
        *======================================================================

        *-- opt_4c_PesEnvs (fwoption1: top=334+29=363, left=289)
        loc_oPagina.AddObject("opt_4c_PesEnvs", "OptionGroup")
        WITH loc_oPagina.opt_4c_PesEnvs
            .Value       = 2
            .Top         = 363
            .Left        = 289
            .Width       = 100
            .Height      = 20
            .ButtonCount = 2
            .BackStyle   = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption = "Sim"
                .Width   = 46
                .Height  = 20
            ENDWITH
            WITH .Buttons(2)
                .Caption = "N" + CHR(227) + "o"
                .Width   = 46
                .Height  = 20
                .Left    = 49
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        ENDWITH

        *-- lbl_4c_PesEnvs (Say8: top=339+29=368, left=149, width=141)
        loc_oPagina.AddObject("lbl_4c_PesEnvs", "Label")
        WITH loc_oPagina.lbl_4c_PesEnvs
            .Caption   = "OF Obrigat" + CHR(243) + "rio na Pesagem :"
            .Top       = 368
            .Left      = 149
            .Width     = 141
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *======================================================================
        * CAMPOS "SEM USO" - criados com Visible=.F. (compatibilidade de schema)
        * fwoption2 (Fchcxs): top=529+29=558, left=527
        * fwoption3 (nChkObjs): top=553+29=582, left=491
        * Say9: top=533+29=562, left=475
        * Say12: top=558+29=587, left=435
        *======================================================================

        *-- opt_4c_SemUso2 (fwoption2 / Fchcxs - sem uso)
        loc_oPagina.AddObject("opt_4c_SemUso2", "OptionGroup")
        WITH loc_oPagina.opt_4c_SemUso2
            .Value       = 2
            .Top         = 558
            .Left        = 527
            .Width       = 100
            .Height      = 20
            .ButtonCount = 2
            .BackStyle   = 0
            .Visible     = .F.
            .ForeColor   = RGB(255, 0, 0)
            WITH .Buttons(1)
                .Caption = "Sim"
                .Width   = 46
                .Height  = 20
            ENDWITH
            WITH .Buttons(2)
                .Caption = "N" + CHR(227) + "o"
                .Width   = 46
                .Height  = 20
                .Left    = 49
            ENDWITH
        ENDWITH

        *-- opt_4c_SemUso3 (fwoption3 / nChkObjs - sem uso)
        loc_oPagina.AddObject("opt_4c_SemUso3", "OptionGroup")
        WITH loc_oPagina.opt_4c_SemUso3
            .Value       = 2
            .Top         = 582
            .Left        = 491
            .Width       = 100
            .Height      = 20
            .ButtonCount = 2
            .BackStyle   = 0
            .Visible     = .F.
            .ForeColor   = RGB(255, 0, 0)
            WITH .Buttons(1)
                .Caption = "Sim"
                .Width   = 46
                .Height  = 20
            ENDWITH
            WITH .Buttons(2)
                .Caption = "N" + CHR(227) + "o"
                .Width   = 46
                .Height  = 20
                .Left    = 49
            ENDWITH
        ENDWITH

        *-- lbl_4c_SemUso9 (Say9 "sem uso": top=533+29=562, left=475)
        loc_oPagina.AddObject("lbl_4c_SemUso9", "Label")
        WITH loc_oPagina.lbl_4c_SemUso9
            .Caption   = "sem uso :"
            .Top       = 562
            .Left      = 475
            .Width     = 50
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- lbl_4c_SemUso12 (Say12 "sem uso :": top=558+29=587, left=435)
        loc_oPagina.AddObject("lbl_4c_SemUso12", "Label")
        WITH loc_oPagina.lbl_4c_SemUso12
            .Caption   = "sem uso :"
            .Top       = 587
            .Left      = 435
            .Width     = 50
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- BINDEVENT: Prioridade -> ValidarPrioridade (LostFocus)
        BINDEVENT(loc_oPagina.txt_4c_Prioridade, "KeyPress", THIS, "ValidarPrioridade")

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- Reesconder campos "sem uso" (TornarControlesVisiveis forcou Visible=.T.)
        loc_oPagina.opt_4c_SemUso2.Visible  = .F.
        loc_oPagina.opt_4c_SemUso3.Visible  = .F.
        loc_oPagina.lbl_4c_SemUso9.Visible  = .F.
        loc_oPagina.lbl_4c_SemUso12.Visible = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no grid da Page1
    * Grid e conexao do RecordSource serao configurados na Fase 4
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            loc_lResultado = .T.
        ELSE
            TRY
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_lResultado = THIS.this_oBusinessObject.Buscar("")
                    IF loc_lResultado AND USED("cursor_4c_Dados")
                        loc_oGrid.ColumnCount = 3
                        loc_oGrid.RecordSource          = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.linhas"
                        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column3.Header1.Caption = "Linhas"
                        THIS.FormatarGridLista(loc_oGrid)
                        loc_oGrid.Refresh()
                    ENDIF
                ENDIF
            CATCH TO loException
                MostrarErro("Erro ao carregar lista:" + CHR(13) + ;
                            "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                            loException.Message, "Formgpr.CarregarLista")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF
            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro ao alternar pagina:" + CHR(13) + ;
                        loException.Message, "Formgpr.AlternarPagina")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Itera Pages de PageFrames e Controls de Containers
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCodConPads - Lookup Produto Padrao de Conserto (por codigo)
    * Original: getCodConPads Valid -> fwBuscaExt em SigCdPro (CPros/DPros)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCodConPads(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cValor, loc_oBusca, loc_cCodigo, loc_cDesc

        IF PCOUNT() >= 1 AND TYPE("par_nKeyCode") = "N"
            IF !INLIST(par_nKeyCode, 13, 9, 115)
                RETURN
            ENDIF
        ENDIF

        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_CodConPads.Value)

        IF EMPTY(loc_cValor)
            loc_oPg2.txt_4c_DCodConPads.Value = ""
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProd", "CPros", loc_cValor, ;
                "Produto Padr" + CHR(227) + "o de Conserto")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
                    SELECT cursor_4c_BuscaProd
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaProd.CPros)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaProd.DPros)
                    loc_oPg2.txt_4c_CodConPads.Value  = loc_cCodigo
                    loc_oPg2.txt_4c_DCodConPads.Value = loc_cDesc
                ELSE
                    IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
                    loc_oPg2.txt_4c_CodConPads.Value  = ""
                    loc_oPg2.txt_4c_DCodConPads.Value = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro no lookup produto:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupCodConPads")
        ENDTRY

        IF USED("cursor_4c_BuscaProd")
            USE IN cursor_4c_BuscaProd
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDCodConPads - Lookup Produto Padrao de Conserto (por descricao)
    * Original: getDCodConPads Valid -> fwBuscaExt em SigCdPro (DPros/CPros)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDCodConPads(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cValor, loc_oBusca, loc_cCodigo, loc_cDesc

        IF PCOUNT() >= 1 AND TYPE("par_nKeyCode") = "N"
            IF !INLIST(par_nKeyCode, 13, 9, 115)
                RETURN
            ENDIF
        ENDIF

        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_DCodConPads.Value)

        IF EMPTY(loc_cValor)
            loc_oPg2.txt_4c_CodConPads.Value = ""
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProd", "DPros", loc_cValor, ;
                "Produto Padr" + CHR(227) + "o de Conserto")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
                    SELECT cursor_4c_BuscaProd
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaProd.CPros)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaProd.DPros)
                    loc_oPg2.txt_4c_CodConPads.Value  = loc_cCodigo
                    loc_oPg2.txt_4c_DCodConPads.Value = loc_cDesc
                ELSE
                    IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
                    loc_oPg2.txt_4c_CodConPads.Value  = ""
                    loc_oPg2.txt_4c_DCodConPads.Value = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro no lookup produto:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupDCodConPads")
        ENDTRY

        IF USED("cursor_4c_BuscaProd")
            USE IN cursor_4c_BuscaProd
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupLin - Lookup Linha Padrao de Cadastro (por codigo)
    * Original: GetLin Valid -> fwBuscaExt em SigCdLin (Linhas/Descs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupLin(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cValor, loc_oBusca, loc_cCod, loc_cDesc

        IF PCOUNT() >= 1 AND TYPE("par_nKeyCode") = "N"
            IF !INLIST(par_nKeyCode, 13, 9, 115)
                RETURN
            ENDIF
        ENDIF

        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Lin.Value)

        IF EMPTY(loc_cValor)
            loc_oPg2.txt_4c_DLin.Value = ""
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdLin", "cursor_4c_BuscaLin", "Linhas", loc_cValor, ;
                "Linha Padr" + CHR(227) + "o de Cadastro")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
                    SELECT cursor_4c_BuscaLin
                    loc_cCod  = ALLTRIM(cursor_4c_BuscaLin.Linhas)
                    loc_cDesc = ALLTRIM(cursor_4c_BuscaLin.Descs)
                    loc_oPg2.txt_4c_Lin.Value  = loc_cCod
                    loc_oPg2.txt_4c_DLin.Value = loc_cDesc
                ELSE
                    IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
                    loc_oPg2.txt_4c_Lin.Value  = ""
                    loc_oPg2.txt_4c_DLin.Value = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro no lookup linha:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupLin")
        ENDTRY

        IF USED("cursor_4c_BuscaLin")
            USE IN cursor_4c_BuscaLin
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDLin - Lookup Linha Padrao de Cadastro (por descricao)
    * Original: GetDLin Valid -> fwBuscaExt em SigCdLin (Descs/Linhas)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDLin(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cValor, loc_oBusca, loc_cCod, loc_cDesc

        IF PCOUNT() >= 1 AND TYPE("par_nKeyCode") = "N"
            IF !INLIST(par_nKeyCode, 13, 9, 115)
                RETURN
            ENDIF
        ENDIF

        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_DLin.Value)

        IF EMPTY(loc_cValor)
            loc_oPg2.txt_4c_Lin.Value = ""
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdLin", "cursor_4c_BuscaLin", "Descs", loc_cValor, ;
                "Linha Padr" + CHR(227) + "o de Cadastro")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
                    SELECT cursor_4c_BuscaLin
                    loc_cCod  = ALLTRIM(cursor_4c_BuscaLin.Linhas)
                    loc_cDesc = ALLTRIM(cursor_4c_BuscaLin.Descs)
                    loc_oPg2.txt_4c_Lin.Value  = loc_cCod
                    loc_oPg2.txt_4c_DLin.Value = loc_cDesc
                ELSE
                    IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
                    loc_oPg2.txt_4c_Lin.Value  = ""
                    loc_oPg2.txt_4c_DLin.Value = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro no lookup linha:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupDLin")
        ENDTRY

        IF USED("cursor_4c_BuscaLin")
            USE IN cursor_4c_BuscaLin
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMatPrincs - Lookup para Material Principal (SigCdPro)
    * Acionado por InteractiveChange e KeyPress de txt_4c_MatPrincs
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMatPrincs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cValAtual, loc_oBusca, loc_cCod, loc_cDesc
        LOCAL loc_nVarias, loc_nRetSql, loc_cSql

        IF PCOUNT() >= 1 AND TYPE("par_nKeyCode") = "N"
            IF !INLIST(par_nKeyCode, 13, 9, 115)
                RETURN
            ENDIF
        ENDIF

        TRY
            loc_oPg2      = THIS.pgf_4c_Paginas.Page2
            loc_cValAtual = ALLTRIM(loc_oPg2.txt_4c_MatPrincs.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaMatPrincs", "CPros", loc_cValAtual, ;
                "Selecionar Material Principal")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatPrincs")
                    SELECT cursor_4c_BuscaMatPrincs
                    loc_cCod = ALLTRIM(cursor_4c_BuscaMatPrincs.CPros)

                    *-- Verificar Varias (produto deve ter peso variavel = 1)
                    loc_nVarias = 0
                    IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                        loc_cSql = "SELECT Varias FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCod)
                        loc_nRetSql = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_VariasPro")
                        IF loc_nRetSql > 0 AND USED("cursor_4c_VariasPro") AND !EOF("cursor_4c_VariasPro")
                            loc_nVarias = cursor_4c_VariasPro.Varias
                        ENDIF
                        IF USED("cursor_4c_VariasPro")
                            USE IN cursor_4c_VariasPro
                        ENDIF
                    ENDIF

                    IF loc_nVarias <> 1
                        MsgAviso("Este Produto n" + CHR(227) + "o est" + CHR(225) + ;
                                 " Configurado para Peso Vari" + CHR(225) + "vel!!!", ;
                                 "Selecionar Material Principal")
                        loc_oPg2.txt_4c_MatPrincs.Value = ""
                    ELSE
                        loc_oPg2.txt_4c_MatPrincs.Value = loc_cCod
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
                    loc_oPg2.txt_4c_MatPrincs.Value = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro no lookup material principal:" + CHR(13) + loException.Message, ;
                    "Formgpr.AbrirLookupMatPrincs")
        ENDTRY

        IF USED("cursor_4c_BuscaMatPrincs")
            USE IN cursor_4c_BuscaMatPrincs
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPrioridade - Valida valor digitado em txt_4c_Prioridade (0 ou 1)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarPrioridade(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_nVal

        IF PCOUNT() >= 1 AND TYPE("par_nKeyCode") = "N"
            IF !INLIST(par_nKeyCode, 13, 9, 115)
                RETURN
            ENDIF
        ENDIF

        TRY
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2
            loc_nVal  = loc_oPg2.txt_4c_Prioridade.Value
            IF !INLIST(loc_nVal, 0, 1)
                MsgAviso("Prioridade Inv" + CHR(225) + "lida!!!" + CHR(13) + ;
                         "Informe 0 ou 1.", "Prioridade")
                loc_oPg2.txt_4c_Prioridade.Value = 0
                loc_oPg2.txt_4c_Prioridade.SetFocus()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar prioridade:" + CHR(13) + loException.Message, ;
                    "Formgpr.ValidarPrioridade")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos controles para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lResultado, loc_oPg2, loc_oBO
        loc_lResultado = .F.
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oBO  = THIS.this_oBusinessObject

            loc_oBO.this_cCodigos    = ALLTRIM(loc_oPg2.txt_4c_Codigos.Value)
            loc_oBO.this_cDescs      = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
            loc_oBO.this_cCodConPads = ALLTRIM(loc_oPg2.txt_4c_CodConPads.Value)
            loc_oBO.this_cMatPrincs  = ALLTRIM(loc_oPg2.txt_4c_MatPrincs.Value)
            loc_oBO.this_cDigauts    = ALLTRIM(loc_oPg2.txt_4c_CodAut.Value)
            loc_oBO.this_cLinhas     = ALLTRIM(loc_oPg2.txt_4c_Lin.Value)
            loc_oBO.this_nPriors     = loc_oPg2.txt_4c_Prioridade.Value

            *-- OptionGroups: opt.Value=1=Sim, opt.Value=2=Nao
            *-- Bloquear Etiqueta Individual: Sim=0, Nao=1
            loc_oBO.this_nBarrefs    = IIF(loc_oPg2.opt_4c_BlqEtq.Value = 1, 0, 1)
            *-- Permite Alterar Dados da Etiqueta: Sim=0, Nao=1
            loc_oBO.this_nAltetiqs   = IIF(loc_oPg2.opt_4c_AlteEtiq.Value = 1, 0, 1)
            *-- Controla por Qtde: Sim=0, Nao=1
            loc_oBO.this_nCpqtds    = IIF(loc_oPg2.opt_4c_Cpq.Value = 1, 0, 1)
            *-- Aplica Falha Admitida: INVERTIDO - Sim=1, Nao=0
            loc_oBO.this_nAplicflhs  = IIF(loc_oPg2.opt_4c_FalhaAdm.Value = 1, 1, 0)
            *-- OF Obrigatorio na Pesagem: Sim=0, Nao=1
            loc_oBO.this_nPesenvs   = IIF(loc_oPg2.opt_4c_PesEnvs.Value = 1, 0, 1)

            *-- Campos IDs e sem uso (mantidos com valores padrao / sem edicao direta)
            *-- this_nIds, this_nNchkobjs, this_nFchcxs, this_nAltetiqs, this_nProdecomm
            *-- Esses campos nao tem controles visiveis de edicao, sao mantidos pelo BO

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao transferir form para BO:" + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                    loException.Message, "Formgpr.FormParaBO")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para os controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lResultado, loc_oPg2, loc_oBO, loc_cSql, loc_nRet
        loc_lResultado = .F.
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oBO  = THIS.this_oBusinessObject

            loc_oPg2.txt_4c_Codigos.Value    = ALLTRIM(loc_oBO.this_cCodigos)
            loc_oPg2.txt_4c_Descricao.Value  = ALLTRIM(loc_oBO.this_cDescs)
            loc_oPg2.txt_4c_CodConPads.Value = ALLTRIM(loc_oBO.this_cCodConPads)
            loc_oPg2.txt_4c_MatPrincs.Value  = ALLTRIM(loc_oBO.this_cMatPrincs)
            loc_oPg2.txt_4c_CodAut.Value     = ALLTRIM(loc_oBO.this_cDigauts)
            loc_oPg2.txt_4c_Lin.Value        = ALLTRIM(loc_oBO.this_cLinhas)
            loc_oPg2.txt_4c_Prioridade.Value = loc_oBO.this_nPriors

            *-- Buscar descricao do CodConPads (DPros de SigCdPro)
            loc_oPg2.txt_4c_DCodConPads.Value = ""
            IF !EMPTY(loc_oBO.this_cCodConPads) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSql = "SELECT DPros FROM SigCdPro WHERE CPros = " + ;
                            EscaparSQL(ALLTRIM(loc_oBO.this_cCodConPads))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_DescPro")
                IF loc_nRet > 0 AND USED("cursor_4c_DescPro") AND !EOF("cursor_4c_DescPro")
                    loc_oPg2.txt_4c_DCodConPads.Value = ALLTRIM(cursor_4c_DescPro.DPros)
                ENDIF
                IF USED("cursor_4c_DescPro")
                    USE IN cursor_4c_DescPro
                ENDIF
            ENDIF

            *-- Buscar descricao da Linha (Descs de SigCdLin)
            loc_oPg2.txt_4c_DLin.Value = ""
            IF !EMPTY(loc_oBO.this_cLinhas) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSql = "SELECT Descs FROM SigCdLin WHERE Linhas = " + ;
                            EscaparSQL(ALLTRIM(loc_oBO.this_cLinhas))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_DescLin")
                IF loc_nRet > 0 AND USED("cursor_4c_DescLin") AND !EOF("cursor_4c_DescLin")
                    loc_oPg2.txt_4c_DLin.Value = ALLTRIM(cursor_4c_DescLin.Descs)
                ENDIF
                IF USED("cursor_4c_DescLin")
                    USE IN cursor_4c_DescLin
                ENDIF
            ENDIF

            *-- OptionGroups (Value=1=Sim, Value=2=Nao)
            *-- Bloquear Etiqueta Individual: DB 0=Sim, DB 1=Nao
            loc_oPg2.opt_4c_BlqEtq.Value    = IIF(loc_oBO.this_nBarrefs = 0, 1, 2)
            *-- Permite Alterar Dados da Etiqueta: DB 0=Sim, DB 1=Nao
            loc_oPg2.opt_4c_AlteEtiq.Value  = IIF(loc_oBO.this_nAltetiqs = 0, 1, 2)
            *-- Controla por Qtde: DB 0=Sim, DB 1=Nao
            loc_oPg2.opt_4c_Cpq.Value       = IIF(loc_oBO.this_nCpqtds = 0, 1, 2)
            *-- Aplica Falha Admitida: INVERTIDO - DB 1=Sim, DB 0=Nao
            loc_oPg2.opt_4c_FalhaAdm.Value  = IIF(loc_oBO.this_nAplicflhs = 1, 1, 2)
            *-- OF Obrigatorio na Pesagem: DB 0=Sim, DB 1=Nao
            loc_oPg2.opt_4c_PesEnvs.Value   = IIF(loc_oBO.this_nPesenvs = 0, 1, 2)

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao transferir BO para form:" + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                    loException.Message, "Formgpr.BOParaForm")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os controles de edicao da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oPg2.txt_4c_Codigos.Value    = ""
            loc_oPg2.txt_4c_Descricao.Value  = ""
            loc_oPg2.txt_4c_CodConPads.Value = ""
            loc_oPg2.txt_4c_DCodConPads.Value = ""
            loc_oPg2.txt_4c_Lin.Value        = ""
            loc_oPg2.txt_4c_DLin.Value       = ""
            loc_oPg2.txt_4c_CodAut.Value     = ""
            loc_oPg2.txt_4c_MatPrincs.Value  = ""
            loc_oPg2.txt_4c_Prioridade.Value = 0

            loc_oPg2.opt_4c_BlqEtq.Value    = 2
            loc_oPg2.opt_4c_AlteEtiq.Value  = 2
            loc_oPg2.opt_4c_Cpq.Value       = 2
            loc_oPg2.opt_4c_FalhaAdm.Value  = 1
            loc_oPg2.opt_4c_PesEnvs.Value   = 2

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao limpar campos:" + CHR(13) + loException.Message, "Formgpr.LimparCampos")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles de edicao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            *-- Codigo so editavel em modo INCLUIR
            loc_oPg2.txt_4c_Codigos.ReadOnly    = !par_lHabilitar OR !THIS.this_oBusinessObject.this_lNovoRegistro
            loc_oPg2.txt_4c_Descricao.ReadOnly  = !par_lHabilitar
            loc_oPg2.txt_4c_CodConPads.ReadOnly = !par_lHabilitar
            loc_oPg2.txt_4c_Lin.ReadOnly        = !par_lHabilitar
            loc_oPg2.txt_4c_CodAut.ReadOnly     = !par_lHabilitar
            loc_oPg2.txt_4c_MatPrincs.ReadOnly  = !par_lHabilitar
            loc_oPg2.txt_4c_Prioridade.ReadOnly = !par_lHabilitar

            *-- Campos descricao (lookup) sempre ReadOnly
            loc_oPg2.txt_4c_DCodConPads.ReadOnly = .T.
            loc_oPg2.txt_4c_DLin.ReadOnly        = .T.

            *-- OptionGroups
            loc_oPg2.opt_4c_BlqEtq.Enabled    = par_lHabilitar
            loc_oPg2.opt_4c_AlteEtiq.Enabled  = par_lHabilitar
            loc_oPg2.opt_4c_Cpq.Enabled       = par_lHabilitar
            loc_oPg2.opt_4c_FalhaAdm.Enabled  = par_lHabilitar
            loc_oPg2.opt_4c_PesEnvs.Enabled   = par_lHabilitar

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, "Formgpr.HabilitarCampos")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes Confirmar/Cancelar (Page2)
    * NORMAL = visualizacao: Confirmar desabilitado, Cancelar habilitado
    * EDICAO = inclusao/alteracao: ambos habilitados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_lResultado, loc_oCnt
        loc_lResultado = .F.
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva

            DO CASE
            CASE par_cModo = "NORMAL"
                loc_oCnt.cmd_4c_Confirmar.Enabled = .F.
                loc_oCnt.cmd_4c_Cancelar.Enabled  = .T.
            CASE par_cModo = "EDICAO"
                loc_oCnt.cmd_4c_Confirmar.Enabled = .T.
                loc_oCnt.cmd_4c_Cancelar.Enabled  = .T.
            ENDCASE

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao ajustar botoes:" + CHR(13) + loException.Message, "Formgpr.AjustarBotoesPorModo")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Aplica formatacao visual ao grid da Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            WITH par_oGrid
                .GridLines       = 1
                .GridLineWidth   = 1
                .GridLineColor   = RGB(200, 200, 200)
                .HeaderHeight    = 22
                .RowHeight       = 20
                .AllowCellSelection = .F.
                .DeleteMark      = .F.
                .RecordMark      = .F.
                .ReadOnly        = .T.

                WITH .Column1
                    .Width   = 60
                    .Alignment = 2
                    .Header1.FontBold = .T.
                ENDWITH
                WITH .Column2
                    .Width   = 300
                    .Header1.FontBold = .T.
                ENDWITH
                WITH .Column3
                    .Width   = 200
                    .Header1.FontBold = .T.
                ENDWITH
            ENDWITH
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao formatar grid:" + CHR(13) + loException.Message, "Formgpr.FormatarGridLista")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inicia inclusao de novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo("EDICAO")
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao incluir:" + CHR(13) + loException.Message, "Formgpr.BtnIncluirClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Inicia alteracao do registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para alterar.", "Alterar")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo("EDICAO")
                    THIS.AlternarPagina(2)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao alterar:" + CHR(13) + loException.Message, "Formgpr.BtnAlterarClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para visualizar.", "Visualizar")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo("NORMAL")
                    THIS.AlternarPagina(2)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao visualizar:" + CHR(13) + loException.Message, "Formgpr.BtnVisualizarClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui o registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_cCodigo, loc_lConfirma
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro para excluir.", "Excluir")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo  = ALLTRIM(cursor_4c_Dados.codigos)
                loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do grande grupo '" + ;
                                            loc_cCodigo + "'?", "Excluir")
                IF loc_lConfirma
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Grande grupo exclu" + CHR(237) + "do com sucesso.", "Excluir")
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir:" + CHR(13) + loException.Message, "Formgpr.BtnExcluirClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre busca e navega ao registro localizado
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.
        TRY
            loc_cCodigo = ""
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
            ENDIF

            LOCAL loc_oBusca
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", "cursor_4c_BuscaGpr", "codigos", loc_cCodigo, ;
                "Buscar Grande Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGpr")
                    SELECT cursor_4c_BuscaGpr
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaGpr.codigos)
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        THIS.BOParaForm()
                        THIS.this_cModoAtual = "VISUALIZAR"
                        THIS.HabilitarCampos(.F.)
                        THIS.AjustarBotoesPorModo("NORMAL")
                        THIS.AlternarPagina(2)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao buscar:" + CHR(13) + loException.Message, "Formgpr.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaGpr")
            USE IN cursor_4c_BuscaGpr
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva o registro (inserir ou atualizar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oBO
        loc_lResultado = .F.
        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF !THIS.FormParaBO()
                loc_lResultado = .F.
            ELSE
                loc_lResultado = loc_oBO.Salvar()

                IF loc_lResultado
                    MsgInfo("Grande grupo salvo com sucesso.", "Salvar")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo("NORMAL")
                    THIS.AlternarPagina(1)
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar:" + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                    loException.Message, "Formgpr.BtnSalvarClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela a edicao atual e volta para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.LimparCampos()
            THIS.this_cModoAtual = "LISTA"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo("NORMAL")
            THIS.AlternarPagina(1)
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao cancelar:" + CHR(13) + loException.Message, "Formgpr.BtnCancelarClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\gprBO.prg):
*==============================================================================
* gprBO.prg
*
* Business Object para Grande Grupo de Produto (SigCdGpr)
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS gprBO AS BusinessBase

    *-- Propriedades da tabela SigCdGpr
    this_cCodigos     = ""    && codigos    char(3)      PK
    this_cDescs       = ""    && descs      char(40)
    this_cCodConPads  = ""    && codconpads char(14)     Produto Padrao de Conserto
    this_cMatPrincs   = ""    && matprincs  char(14)     Material Principal
    this_nCpqtds      = 0     && cpqtds     numeric(1,0) Controla por Qtde
    this_cDigauts     = ""    && digauts    char(1)      Digito Codigo Automatico
    this_nIds         = 0     && ids        numeric(10,0)
    this_nAplicflhs   = 0     && aplicflhs  numeric(1,0) Aplica Falha Admitida
    this_nBarrefs     = 0     && barrefs    numeric(1,0) Bloquear Alteracao Etiqueta Individual
    this_nDigbars     = 0     && digbars    numeric(1,0)
    this_nPesenvs     = 0     && pesenvs    numeric(1,0) OF Obrigatorio na Pesagem
    this_cLinhas      = ""    && linhas     char(10)     Linha Padrao de Cadastro
    this_nFchcxs      = 0     && fchcxs     numeric(1,0)
    this_nPriors      = 0     && priors     numeric(1,0) Prioridade Recalculo Saldo
    this_nAltetiqs    = 0     && altetiqs   numeric(1,0) Permite Alterar Dados Etiqueta
    this_nNchkobjs    = 0     && nchkobjs   numeric(1,0)
    this_nProdecomm   = 0     && prodecomm  numeric(1,0)

    *-- Campos de exibicao (nao persistidos na tabela)
    this_cDescConPads = ""    && Descricao do Produto Padrao de Conserto (SigCdPro.DPros)
    this_cDescLin     = ""    && Descricao da Linha Padrao (SigCdLin.Descs)

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdGpr"
            THIS.this_cCampoChave = "codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "gprBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigos)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !INLIST(THIS.this_nPriors, 0, 1)
            MsgAviso("Prioridade Inv" + CHR(225) + "lida!!! Use 0 ou 1.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se codigos ja existe em SigCdGpr
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdGpr" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "gprBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos     = TratarNulo(codigos,    "C")
                THIS.this_cDescs       = TratarNulo(descs,      "C")
                THIS.this_cCodConPads  = TratarNulo(CodConPads, "C")
                THIS.this_cMatPrincs   = TratarNulo(Matprincs,  "C")
                THIS.this_nCpqtds      = TratarNulo(cpqtds,     "N")
                THIS.this_cDigauts     = TratarNulo(digauts,    "C")
                THIS.this_nIds         = TratarNulo(ids,        "N")
                THIS.this_nAplicflhs   = TratarNulo(AplicFlhs,  "N")
                THIS.this_nBarrefs     = TratarNulo(Barrefs,    "N")
                THIS.this_nDigbars     = TratarNulo(digbars,    "N")
                THIS.this_nPesenvs     = TratarNulo(PesEnvs,    "N")
                THIS.this_cLinhas      = TratarNulo(linhas,     "C")
                THIS.this_nFchcxs      = TratarNulo(Fchcxs,     "N")
                THIS.this_nPriors      = TratarNulo(priors,     "N")
                THIS.this_nAltetiqs    = TratarNulo(AltEtiqs,   "N")
                THIS.this_nNchkobjs    = TratarNulo(nChkObjs,   "N")
                THIS.this_nProdecomm   = TratarNulo(prodecomm,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "gprBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigCdGpr
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdGpr (codigos, descs, CodConPads, Matprincs,
                    cpqtds, digauts, AplicFlhs, Barrefs, PesEnvs,
                    linhas, priors, AltEtiqs, nChkObjs, Fchcxs, digbars, prodecomm)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cDescs)>>,
                    <<EscaparSQL(THIS.this_cCodConPads)>>,
                    <<EscaparSQL(THIS.this_cMatPrincs)>>,
                    <<FormatarNumeroSQL(THIS.this_nCpqtds, 0)>>,
                    <<EscaparSQL(THIS.this_cDigauts)>>,
                    <<FormatarNumeroSQL(THIS.this_nAplicflhs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nBarrefs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPesenvs, 0)>>,
                    <<EscaparSQL(THIS.this_cLinhas)>>,
                    <<FormatarNumeroSQL(THIS.this_nPriors, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAltetiqs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNchkobjs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFchcxs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nDigbars, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nProdecomm, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "gprBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdGpr
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdGpr
                SET descs      = <<EscaparSQL(THIS.this_cDescs)>>,
                    CodConPads = <<EscaparSQL(THIS.this_cCodConPads)>>,
                    Matprincs  = <<EscaparSQL(THIS.this_cMatPrincs)>>,
                    cpqtds     = <<FormatarNumeroSQL(THIS.this_nCpqtds, 0)>>,
                    digauts    = <<EscaparSQL(THIS.this_cDigauts)>>,
                    AplicFlhs  = <<FormatarNumeroSQL(THIS.this_nAplicflhs, 0)>>,
                    Barrefs    = <<FormatarNumeroSQL(THIS.this_nBarrefs, 0)>>,
                    PesEnvs    = <<FormatarNumeroSQL(THIS.this_nPesenvs, 0)>>,
                    linhas     = <<EscaparSQL(THIS.this_cLinhas)>>,
                    priors     = <<FormatarNumeroSQL(THIS.this_nPriors, 0)>>,
                    AltEtiqs   = <<FormatarNumeroSQL(THIS.this_nAltetiqs, 0)>>,
                    nChkObjs   = <<FormatarNumeroSQL(THIS.this_nNchkobjs, 0)>>,
                    Fchcxs     = <<FormatarNumeroSQL(THIS.this_nFchcxs, 0)>>,
                    digbars    = <<FormatarNumeroSQL(THIS.this_nDigbars, 0)>>,
                    prodecomm  = <<FormatarNumeroSQL(THIS.this_nProdecomm, 0)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "gprBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdGpr
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGpr WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "gprBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descs, linhas (colunas do grid)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(3), descs C(40), linhas C(10))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.codigos, a.descs, a.linhas FROM SigCdGpr a"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.codigos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grandes grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grandes grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "gprBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.codigos, a.descs, a.CodConPads, a.Matprincs," + ;
                " a.cpqtds, a.digauts, a.ids, a.AplicFlhs, a.Barrefs," + ;
                " a.digbars, a.PesEnvs, a.linhas, a.Fchcxs, a.priors," + ;
                " a.AltEtiqs, a.nChkObjs, a.prodecomm" + ;
                " FROM SigCdGpr a WHERE a.codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Grande Grupo n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "gprBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

