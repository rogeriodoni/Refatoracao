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
[2026-08-22 16:08:24] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-22 16:08:24] [INFO] Config FPW: (nao fornecido)
[2026-08-22 16:08:24] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 16:08:24] [INFO] Timeout: 300 segundos
[2026-08-22 16:08:24] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0y4qxnf4.prg
[2026-08-22 16:08:24] [INFO] Conteudo do wrapper:
[2026-08-22 16:08:24] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formpaf', 'C:\4c\tasks\task493', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formpaf', 'C:\4c\tasks\task493', 'CRUD'
QUIT

[2026-08-22 16:08:24] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0y4qxnf4.prg
[2026-08-22 16:08:24] [INFO] VFP output esperado em: C:\4c\tasks\task493\vfp_output.txt
[2026-08-22 16:08:24] [INFO] Executando Visual FoxPro 9...
[2026-08-22 16:08:24] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0y4qxnf4.prg
[2026-08-22 16:08:24] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0y4qxnf4.prg
[2026-08-22 16:08:24] [INFO] Timeout configurado: 300 segundos
[2026-08-22 16:09:52] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-22 16:09:52] [INFO] VFP9 finalizado em 87.9445808 segundos
[2026-08-22 16:09:52] [INFO] Exit Code: 
[2026-08-22 16:09:52] [INFO] 
[2026-08-22 16:09:52] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-22 16:09:52] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0y4qxnf4.prg
[2026-08-22 16:09:52] [INFO] 
[2026-08-22 16:09:52] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-22 16:09:52] [INFO] * Auto-generated wrapper for parameters
[2026-08-22 16:09:52] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 16:09:52] [INFO] * Parameters: 'Formpaf', 'C:\4c\tasks\task493', 'CRUD'
[2026-08-22 16:09:52] [INFO] 
[2026-08-22 16:09:52] [INFO] * Anti-dialog protections for unattended execution
[2026-08-22 16:09:52] [INFO] SET SAFETY OFF
[2026-08-22 16:09:52] [INFO] SET RESOURCE OFF
[2026-08-22 16:09:52] [INFO] SET TALK OFF
[2026-08-22 16:09:52] [INFO] SET NOTIFY OFF
[2026-08-22 16:09:52] [INFO] SYS(2335, 0)
[2026-08-22 16:09:52] [INFO] 
[2026-08-22 16:09:52] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formpaf', 'C:\4c\tasks\task493', 'CRUD'
[2026-08-22 16:09:52] [INFO] QUIT
[2026-08-22 16:09:52] [INFO] 
[2026-08-22 16:09:52] [INFO] === Fim do Wrapper.prg ===
[2026-08-22 16:09:52] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-22 16:12:56] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-22 16:12:56] [INFO] Config FPW: (nao fornecido)
[2026-08-22 16:12:56] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 16:12:56] [INFO] Timeout: 300 segundos
[2026-08-22 16:12:56] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ezqgsufs.prg
[2026-08-22 16:12:56] [INFO] Conteudo do wrapper:
[2026-08-22 16:12:56] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formpaf', 'C:\4c\tasks\task493', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formpaf', 'C:\4c\tasks\task493', 'CRUD'
QUIT

[2026-08-22 16:12:56] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ezqgsufs.prg
[2026-08-22 16:12:56] [INFO] VFP output esperado em: C:\4c\tasks\task493\vfp_output.txt
[2026-08-22 16:12:56] [INFO] Executando Visual FoxPro 9...
[2026-08-22 16:12:56] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ezqgsufs.prg
[2026-08-22 16:12:56] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ezqgsufs.prg
[2026-08-22 16:12:56] [INFO] Timeout configurado: 300 segundos
[2026-08-22 16:13:40] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-22 16:13:40] [INFO] VFP9 finalizado em 43.9054239 segundos
[2026-08-22 16:13:40] [INFO] Exit Code: 
[2026-08-22 16:13:40] [INFO] 
[2026-08-22 16:13:40] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-22 16:13:40] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ezqgsufs.prg
[2026-08-22 16:13:40] [INFO] 
[2026-08-22 16:13:40] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-22 16:13:40] [INFO] * Auto-generated wrapper for parameters
[2026-08-22 16:13:40] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 16:13:40] [INFO] * Parameters: 'Formpaf', 'C:\4c\tasks\task493', 'CRUD'
[2026-08-22 16:13:40] [INFO] 
[2026-08-22 16:13:40] [INFO] * Anti-dialog protections for unattended execution
[2026-08-22 16:13:40] [INFO] SET SAFETY OFF
[2026-08-22 16:13:40] [INFO] SET RESOURCE OFF
[2026-08-22 16:13:40] [INFO] SET TALK OFF
[2026-08-22 16:13:40] [INFO] SET NOTIFY OFF
[2026-08-22 16:13:40] [INFO] SYS(2335, 0)
[2026-08-22 16:13:40] [INFO] 
[2026-08-22 16:13:40] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formpaf', 'C:\4c\tasks\task493', 'CRUD'
[2026-08-22 16:13:40] [INFO] QUIT
[2026-08-22 16:13:40] [INFO] 
[2026-08-22 16:13:40] [INFO] === Fim do Wrapper.prg ===
[2026-08-22 16:13:40] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\cadastros\Formpaf.prg):
*==============================================================================
* Formpaf.prg - Formulario de Configuracao PAF-ECF
* Migrado de: SIGCDPAF.SCX (frmcadastro)
* PAF-ECF: Programa Aplicativo Fiscal - Emissor de Cupom Fiscal
* Apenas ALTERAR e suportado (insercao/exclusao gerenciadas automaticamente)
* Grid: DopePafEcfs (Funcao), Cx (N do caixa), TrNf (Finalizadora Nao Fiscal)
*==============================================================================

DEFINE CLASS Formpaf AS FormBase

    Height      = 600
    Width       = 1000
    Caption     = "PAF-ECF"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    * Sincroniza SigCdPaf com operacoes PAF antes de carregar lista
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Configura" + CHR(231) + CHR(227) + "o PAF-ECF"
            THIS.this_oBusinessObject = CREATEOBJECT("pafBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar pafBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formpaf.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = ;
                    "Configura" + CHR(231) + CHR(227) + "o PAF-ECF"
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = ;
                    "Configura" + CHR(231) + CHR(227) + "o PAF-ECF"
                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    *-- Sincroniza SigCdPaf com operacoes PAF ativas (equiv. Init() legado)
                    THIS.this_oBusinessObject.SincronizarDados()
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar Formpaf:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Formpaf.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *===========================================================================
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
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Page1 com Grid e botoes (Visualizar, Alterar, Buscar)
    * Sem Incluir/Excluir: registros PAF gerenciados automaticamente (plAcInserir=.F.)
    * Grid colunas: DopePafEcfs (Funcao), Cx (N do caixa), TrNf (Finalizadora)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho (cntSombra no legado: Top=1, com compensacao +29: Top=31)
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
            .Caption   = "Configura" + CHR(231) + CHR(227) + "o PAF-ECF"
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
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
            .Caption   = "Configura" + CHR(231) + CHR(227) + "o PAF-ECF"
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Botoes CRUD (Grupo_op legado: Left=312, Top=-1; canonico com +29: Top=29)
        *-- Apenas Visualizar/Alterar/Buscar (sem Incluir/Excluir per plAcInserir=.F)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 315
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Visualizar (Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Buscar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
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
            .FontName        = "Tahoma"
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
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem PAF-ECF
        *-- Colunas decodificadas: DopePafEcfs/Cx/TrNf (populadas por pafBO.Buscar)
        *-- ColumnCount FORA do WITH (Problema 36)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 3
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 880
            .Height             = 498
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
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnAlterarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2 com campos PAF-ECF editaveis
    * Campos: Descricao (readonly), Inativa (checkbox), TipoDoc (optiongroup 5 opcoes)
    *         NroCaixa (txt 3 digitos), CupomNfis (txt lookup SigFiNtb)
    * Top compensation: legado Top + 29 (PageFrame.Top=-29)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Botoes de acao (Grupo_Salva legado: Left=819, Top=9; +29: Top=33)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva no legado)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (volta para lista)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        * DESCRICAO (Get_desc: Top=172+29=201, Left=268, Width=150, Height=23)
        * Say1: Top=176+29=205, Left=191, Width=78 - SOMENTE LEITURA (DopePafEcfs)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
            .Top       = 205
            .Left      = 191
            .Width     = 78
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Top           = 201
            .Left          = 268
            .Width         = 150
            .Height        = 23
            .FontName      = "Courier New"
            .FontSize      = 8
            .MaxLength     = 50
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * INATIVA (Chk_Inativar: Top=176+29=205, Left=443, Width=74, Height=15)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("chk_4c_Inativar", "CheckBox")
        WITH loc_oPagina.chk_4c_Inativar
            .Caption   = "INATIVA"
            .Top       = 205
            .Left      = 443
            .Width     = 74
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .T.
            .Value     = 0
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * LABEL DOCUMENTO (Say2: Top=220+29=249, Left=189)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Documento", "Label")
        WITH loc_oPagina.lbl_4c_Documento
            .Caption   = "Documento :"
            .Top       = 249
            .Left      = 189
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TIPO DOCUMENTO (op_doc: Top=220+29=249, Left=263, Width=140, Height=63)
        * 5 botoes: CF(1), CNF(2), DAV RG(3), DAV A4(4), PRE VENDA(5)
        * ButtonCount ANTES do WITH para criar os botoes (analogo ao ColumnCount do Grid)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("opt_4c_TipoDoc", "OptionGroup")
        loc_oPagina.opt_4c_TipoDoc.ButtonCount = 5
        WITH loc_oPagina.opt_4c_TipoDoc
            .Top         = 249
            .Left        = 263
            .Width       = 140
            .Height      = 63
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Enabled     = .F.
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "CF"
                .Top       = 2
                .Left      = 5
                .Width     = 34
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "CNF"
                .Top       = 2
                .Left      = 74
                .Width     = 42
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "DAV RG"
                .Top       = 19
                .Left      = 5
                .Width     = 64
                .Height    = 17
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH .Buttons(4)
                .Caption   = "DAV A4"
                .Top       = 19
                .Left      = 74
                .Width     = 61
                .Height    = 17
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH .Buttons(5)
                .Caption   = "PRE VENDA"
                .Top       = 38
                .Left      = 5
                .Width     = 88
                .Height    = 17
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDWITH

        *----------------------------------------------------------------------
        * LABEL NR CAIXA (Say29: Top=292+29=321, Left=135)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_NroCaixa", "Label")
        WITH loc_oPagina.lbl_4c_NroCaixa
            .Caption   = "N" + CHR(186) + " do Caixa - NSEQ. :"
            .Top       = 321
            .Left      = 135
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * NR CAIXA (Get_ncaixa: Top=289+29=318, Left=268, Width=31, Height=21)
        * Valid: se preenchido, obrigatorio 3 digitos
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_NroCaixa", "TextBox")
        WITH loc_oPagina.txt_4c_NroCaixa
            .Value         = ""
            .Top           = 318
            .Left          = 268
            .Width         = 31
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_NroCaixa, "KeyPress", THIS, "ValidarNroCaixa")

        *----------------------------------------------------------------------
        * LABEL FINALIZADORA NAO FISCAL (Say18: Top=319+29=348, Left=125)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_FinalizNaoFiscal", "Label")
        WITH loc_oPagina.lbl_4c_FinalizNaoFiscal
            .Caption   = "Finalizadora N" + CHR(227) + "o Fiscal :"
            .Top       = 348
            .Left      = 125
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * CUPOM NAO FISCAL (Get_cupomnfis: Top=316+29=345, Left=268, Width=24, Height=21)
        * Lookup em SigFiNtb.ordems (F4/F5 ou LostFocus)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_CupomNfis", "TextBox")
        WITH loc_oPagina.txt_4c_CupomNfis
            .Value         = ""
            .Top           = 345
            .Left          = 268
            .Width         = 24
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CupomNfis, "KeyPress", THIS, "ValidarCupomNfis")
        BINDEVENT(loc_oPagina.txt_4c_CupomNfis, "KeyPress", THIS, "TeclaLookupCupomNfis")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Popula grid com cursor_4c_Dados (colunas decodificadas)
    * Ordem legado: pColuna('DopePafEcfs',200), pColuna('CX',90), pColuna('TRNF',161)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount  = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- ControlSource APOS RecordSource (Problema 48)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.DopePafEcfs"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Cx"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TrNf"

                loc_oGrid.Column1.Width = 200
                loc_oGrid.Column2.Width = 90
                loc_oGrid.Column3.Width = 161

                *-- Headers APOS RecordSource (Problema 2/32)
                loc_oGrid.Column1.Header1.Caption = "Fun" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column2.Header1.Caption = "N" + CHR(186) + " do caixa"
                loc_oGrid.Column3.Header1.Caption = "Finalizadora N" + CHR(227) + "o Fiscal"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Formpaf.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, ;
                "Formpaf.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loc_oErro
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loc_oErro.Message, ;
                "Formpaf.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cDopes
        loc_cDopes = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cDopes = ALLTRIM(cursor_4c_Dados.Dopes)
        ENDIF

        IF EMPTY(loc_cDopes)
            MsgAviso("Selecione um registro para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre Page2 em modo edicao com validacao MD5 previa
    * REGRA PAF: Valida integridade MD5 antes de abrir edicao (legado: Grupo_op.Click)
    * Se MD5 invalido: exibe aviso e permanece em Page1
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cDopes, loc_cDopesDecod
        loc_cDopes      = ""
        loc_cDopesDecod = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cDopes      = ALLTRIM(cursor_4c_Dados.Dopes)
            loc_cDopesDecod = ALLTRIM(cursor_4c_Dados.DopePafEcfs)
        ENDIF

        IF EMPTY(loc_cDopes)
            MsgAviso("Selecione um registro para alterar.")
        ELSE
            IF !THIS.this_oBusinessObject.ValidarIntegridade(loc_cDopesDecod)
                MsgErro("Par" + CHR(226) + "metros de Fun" + CHR(231) + CHR(227) + "o Incorreto. " + ;
                        "Os Dados Foram alterados!!!" + CHR(13) + ;
                        "Favor Sair da Tela de Fun" + CHR(231) + CHR(227) + "o e Entrar Novamente.", " ")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Inclusao nao suportada: registros PAF-ECF gerenciados automaticamente
    * O sistema sincroniza SigCdPaf com SigOpCdd no Init (plAcInserir=.F. no legado)
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        MsgInfo("Inclus" + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel." + CHR(13) + ;
                "Os registros PAF-ECF s" + CHR(227) + "o gerenciados automaticamente" + CHR(13) + ;
                "com base nas opera" + CHR(231) + CHR(245) + "es cadastradas.")
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclusao nao suportada: registros PAF-ECF gerenciados automaticamente
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        MsgInfo("Exclus" + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel." + CHR(13) + ;
                "Os registros PAF-ECF s" + CHR(227) + "o gerenciados automaticamente" + CHR(13) + ;
                "com base nas opera" + CHR(231) + CHR(245) + "es cadastradas.")
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre picker na lista PAF-ECF (colunas decodificadas)
    * Usa cursor_4c_Dados existente (ja decodificado por Buscar)
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca

        TRY
            IF !USED("cursor_4c_Dados")
                THIS.CarregarLista()
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Dados"
                loc_oBusca.this_cTitulo        = "Buscar PAF-ECF"
                loc_oBusca.mAddColuna("DopePafEcfs", "", "Fun" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("Cx",          "", "N" + CHR(186) + " do caixa")
                loc_oBusca.mAddColuna("TrNf",        "", "Finalizadora N" + CHR(227) + "o Fiscal")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Dados")
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "Formpaf.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirma e salva (apenas ALTERAR e suportado)
    * Transfere form -> BO -> BO.Salvar() -> volta para Page1
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        IF THIS.this_cModoAtual != "ALTERAR"
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere dados do form para o BO antes de salvar
    * Campos editaveis: nOpDoc, lInativa, cNcaixa, cCupomNfis
    * cDopePafEcfs (readonly) ja esta no BO de CarregarPorCodigo - nao transfere
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_nOpDoc     = loc_oPagina.opt_4c_TipoDoc.Value
        THIS.this_oBusinessObject.this_lInativa   = (loc_oPagina.chk_4c_Inativar.Value = 1)
        THIS.this_oBusinessObject.this_cNcaixa    = ALLTRIM(loc_oPagina.txt_4c_NroCaixa.Value)
        THIS.this_oBusinessObject.this_cCupomNfis = ALLTRIM(loc_oPagina.txt_4c_CupomNfis.Value)
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do BO para o form apos CarregarPorCodigo
    * opt_4c_TipoDoc.Value = 1-5 (CF/CNF/DAV RG/DAV A4/PRE VENDA); 0 = default CF
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_nOpDoc
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_nOpDoc  = THIS.this_oBusinessObject.this_nOpDoc

        loc_oPagina.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cDopePafEcfs
        loc_oPagina.chk_4c_Inativar.Value  = IIF(THIS.this_oBusinessObject.this_lInativa, 1, 0)
        loc_oPagina.txt_4c_NroCaixa.Value  = THIS.this_oBusinessObject.this_cNcaixa
        loc_oPagina.txt_4c_CupomNfis.Value = THIS.this_oBusinessObject.this_cCupomNfis

        IF loc_nOpDoc >= 1 AND loc_nOpDoc <= 5
            loc_oPagina.opt_4c_TipoDoc.Value = loc_nOpDoc
        ELSE
            loc_oPagina.opt_4c_TipoDoc.Value = 1
        ENDIF
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos editaveis de Page2
    * txt_4c_Descricao sempre ReadOnly (exibe DopePafEcfs decodificado)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "chk_4c_Inativar", 5)
            loc_oPagina.chk_4c_Inativar.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_TipoDoc", 5)
            loc_oPagina.opt_4c_TipoDoc.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_NroCaixa", 5)
            loc_oPagina.txt_4c_NroCaixa.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CupomNfis", 5)
            loc_oPagina.txt_4c_CupomNfis.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa valores dos campos editaveis de Page2
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
            loc_oPagina.txt_4c_Descricao.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "chk_4c_Inativar", 5)
            loc_oPagina.chk_4c_Inativar.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_TipoDoc", 5)
            loc_oPagina.opt_4c_TipoDoc.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_NroCaixa", 5)
            loc_oPagina.txt_4c_NroCaixa.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CupomNfis", 5)
            loc_oPagina.txt_4c_CupomNfis.Value = ""
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita Confirmar apenas em ALTERAR
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEditando
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = (THIS.this_cModoAtual = "ALTERAR")

        IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
            ENDIF
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarNroCaixa - Valida Nr Caixa ao sair do campo (Get_ncaixa.Valid do legado)
    * Obrigatorio 3 digitos quando preenchido
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE ValidarNroCaixa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_NroCaixa", 5)
            loc_cValor = ALLTRIM(loc_oPagina.txt_4c_NroCaixa.Value)
            IF !EMPTY(loc_cValor) AND LEN(loc_cValor) < 3
                MsgAviso("Obrigatorio Preenchimento de 3 digitos")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * TeclaLookupCupomNfis - Abre lookup SigFiNtb com F4(115) ou F5(116)
    * PUBLIC: BINDEVENT exige metodo publico com parametros do evento KeyPress
    *===========================================================================
    PROCEDURE TeclaLookupCupomNfis(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCupomNfis()
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarCupomNfis - Valida Finalizadora Nao Fiscal ao sair do campo
    * Busca SigFiNtb por ordems; se nao encontrar abre picker
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE ValidarCupomNfis(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cValor, loc_nOrdem, loc_cSQL, loc_nResult
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_CupomNfis", 5)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(loc_oPagina.txt_4c_CupomNfis.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_nOrdem  = VAL(loc_cValor)
        loc_cSQL    = "SELECT ordems, descrs FROM SigFiNtb ORDER BY ordems"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NtbVal")

        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_NtbVal") > 0
            SELECT cursor_4c_NtbVal
            LOCATE FOR cursor_4c_NtbVal.ordems = loc_nOrdem
            IF FOUND()
                loc_oPagina.txt_4c_CupomNfis.Value = ALLTRIM(STR(cursor_4c_NtbVal.ordems, 2))
                IF USED("cursor_4c_NtbVal")
                    USE IN cursor_4c_NtbVal
                ENDIF
            ELSE
                IF USED("cursor_4c_NtbVal")
                    USE IN cursor_4c_NtbVal
                ENDIF
                THIS.AbrirBuscaCupomNfis()
            ENDIF
        ELSE
            IF USED("cursor_4c_NtbVal")
                USE IN cursor_4c_NtbVal
            ENDIF
            THIS.AbrirBuscaCupomNfis()
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirBuscaCupomNfis - Abre FormBuscaAuxiliar para selecionar SigFiNtb.ordems
    * Equivale ao fwBuscaExt do legado: Get_cupomnfis.Valid
    * Colunas: ordems/descrs/Imps/OpeRnf (mesmas do legado mAddColuna)
    *===========================================================================
    PROCEDURE AbrirBuscaCupomNfis()
        LOCAL loc_oPagina, loc_cSQL, loc_nResult, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cSQL    = "SELECT ordems, descrs, Imps, OpeRnf FROM SigFiNtb ORDER BY ordems"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NtbBusca")

            IF loc_nResult >= 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_NtbBusca"
                    loc_oBusca.this_cTitulo        = "Sele" + CHR(231) + CHR(227) + "o"
                    loc_oBusca.mAddColuna("ordems", "xxxxx",               "Ordem")
                    loc_oBusca.mAddColuna("descrs", "xxxxxxxxxXxxxxxxxxxx", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Imps",   "",                    "Impressora")
                    loc_oBusca.mAddColuna("OpeRnf", "xxxxxx",              "Codigo")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_NtbBusca")
                        SELECT cursor_4c_NtbBusca
                        IF PEMSTATUS(loc_oPagina, "txt_4c_CupomNfis", 5)
                            loc_oPagina.txt_4c_CupomNfis.Value = ALLTRIM(STR(cursor_4c_NtbBusca.ordems, 2))
                        ENDIF
                    ELSE
                        *-- ESC: limpa o campo (legado: this.value = '0')
                        IF PEMSTATUS(loc_oPagina, "txt_4c_CupomNfis", 5)
                            loc_oPagina.txt_4c_CupomNfis.Value = "0"
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                MsgErro("Erro ao carregar SigFiNtb: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpaf.AbrirBuscaCupomNfis: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_NtbBusca")
            USE IN cursor_4c_NtbBusca
        ENDIF
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *===========================================================================
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

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_NtbVal")
            USE IN cursor_4c_NtbVal
        ENDIF

        IF USED("cursor_4c_NtbBusca")
            USE IN cursor_4c_NtbBusca
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\pafBO.prg):
*==============================================================================
* pafBO.prg - Business Object para Configuracao PAF-ECF
* Tabela principal: SigCdPaf
* Chave primaria: Dopes char(20) - armazenado CODIFICADO no banco
*
* PAF-ECF = Programa Aplicativo Fiscal - Emissor de Cupom Fiscal
* Convencao de nomes do legado (invertida, mas preservada aqui):
*   fCriptografar(encoded) = decoded/legivel (para exibicao)
*   fDecriptografar(decoded) = encoded (para armazenamento no banco)
* Apenas ALTERAR e suportado via UI; insercao/exclusao e automatica (SincronizarDados)
*==============================================================================

DEFINE CLASS pafBO AS BusinessBase

    *-- Chave primaria (armazenada CODIFICADA no banco em SigCdPaf.Dopes)
    this_cDopes         = ""    && char(20)  Dopes      - Dopes codificado (PK no banco)

    *-- Campos de SigCdPaf (todos armazenados codificados no banco)
    this_cInativas      = ""    && char(1)   Inativas   - Flag inativo codificado
    this_cDocs          = ""    && char(1)   Docs       - Tipo documento codificado
    this_cMd5s          = ""    && char(32)  cMd5s      - Hash MD5 de integridade
    this_cCnCaixas      = ""    && char(3)   cnCaixas   - NSEQ caixa codificado
    this_cTrNfis        = ""    && char(2)   TrNfis     - Finalizadora nao fiscal codificada

    *-- Versoes DECODIFICADAS para exibicao no form e uso nas queries FK
    this_cDopePafEcfs   = ""    && Dopes decodificado - exibido como "Funcao" no grid
    this_cCx            = ""    && cnCaixas decodificado - exibido como "N do caixa"
    this_cTrNf          = ""    && TrNfis decodificado - exibido como "Finalizadora Nao Fiscal"

    *-- Valores para os campos editaveis do formulario (ja decodificados)
    this_nOpDoc         = 0     && Valor OptionGroup op_doc (1-5 decodificado)
    this_lInativa       = .F.   && Flag inativo (checkbox Chk_Inativar)
    this_cNcaixa        = ""    && Numero do caixa decodificado (campo Get_ncaixa)
    this_cCupomNfis     = ""    && Finalizadora nao fiscal decodificada (campo Get_cupomnfis)

    *-- Dados da operacao em SigCdOpe (para sincronizacao)
    this_nCupFis        = 0     && numeric(1,0) CupFis     - Tipo cupom fiscal
    this_nNFiscals      = 0     && numeric(1,0) nFiscals   - Nao fiscal
    this_nAgrupas       = 0     && numeric(1,0) Agrupas    - Agrupa
    this_nDocus         = 0     && numeric(1,0) Docus      - Tipo documento operacao
    this_nTrNfisOpe     = 0     && numeric(2,0) TrNfis     - Finalizadora em SigCdOpe
    this_nOpeInatvs     = 0     && numeric(1,0) OpeInatvs  - Flag inativo em SigOpCdc
    this_nCnCaixasOpe   = 0     && numeric(3,0) cnCaixas   - Numero caixa em SigOpCdc
    this_cSeries        = ""    && Series da operacao em SigCdOpe (usado para CNF)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPaf"
        THIS.this_cCampoChave = "Dopes"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Carrega todos os registros PAF para o grid
    * Popula cursor_4c_Dados com Dopes/cnCaixas/TrNfis DECODIFICADOS nas colunas alias
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes, Inativas, Docs, cMd5s, cnCaixas, TrNfis," + ;
                       " Dopes AS DopePafEcfs, cnCaixas AS Cx, TrNfis AS TrNf" + ;
                       " FROM SigCdPaf"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                    SELECT cursor_4c_Dados
                    SCAN
                        REPLACE cursor_4c_Dados.DopePafEcfs WITH THIS.Cript(ALLTRIM(cursor_4c_Dados.Dopes)), ;
                                cursor_4c_Dados.Cx WITH THIS.Cript(ALLTRIM(cursor_4c_Dados.cnCaixas)), ;
                                cursor_4c_Dados.TrNf WITH THIS.Cript(ALLTRIM(cursor_4c_Dados.TrNfis))
                    ENDSCAN
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar configura" + CHR(231) + CHR(245) + "es PAF-ECF: " + ;
                        CapturarErroSQL(), "Erro SQL")
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados ( ;
                        Dopes       C(20), ;
                        Inativas    C(1), ;
                        Docs        C(1), ;
                        cMd5s       C(32), ;
                        cnCaixas    C(3), ;
                        TrNfis      C(2), ;
                        DopePafEcfs C(50), ;
                        Cx          C(3), ;
                        TrNf        C(2))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.Buscar: " + loc_oErro.Message, "Erro")
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados ( ;
                    Dopes       C(20), ;
                    Inativas    C(1), ;
                    Docs        C(1), ;
                    cMd5s       C(32), ;
                    cnCaixas    C(3), ;
                    TrNfis      C(2), ;
                    DopePafEcfs C(50), ;
                    Cx          C(3), ;
                    TrNf        C(2))
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo Dopes codificado (valor bruto do banco)
    * par_cDopes: valor de cursor_4c_Dados.Dopes (codificado, como armazenado em SigCdPaf)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cDopes)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes, Inativas, Docs, cMd5s, cnCaixas, TrNfis" + ;
                       " FROM SigCdPaf" + ;
                       " WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                IF THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Registro PAF-ECF n" + CHR(227) + "o encontrado: " + ;
                        ALLTRIM(par_cDopes), "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    * Armazena valores CODIFICADOS (brutos do banco) E DECODIFICADOS (para o form)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            *-- Valores codificados (brutos do banco)
            THIS.this_cDopes      = TratarNulo(Dopes,    "C")
            THIS.this_cInativas   = TratarNulo(Inativas, "C")
            THIS.this_cDocs       = TratarNulo(Docs,     "C")
            THIS.this_cMd5s       = TratarNulo(cMd5s,   "C")
            THIS.this_cCnCaixas   = TratarNulo(cnCaixas, "C")
            THIS.this_cTrNfis     = TratarNulo(TrNfis,   "C")
            *-- Valores decodificados para exibicao no form
            THIS.this_cDopePafEcfs = THIS.Cript(ALLTRIM(THIS.this_cDopes))
            THIS.this_cCx          = THIS.Cript(ALLTRIM(THIS.this_cCnCaixas))
            THIS.this_cTrNf        = THIS.Cript(ALLTRIM(THIS.this_cTrNfis))
            THIS.this_nOpDoc       = VAL(THIS.Cript(ALLTRIM(THIS.this_cDocs)))
            THIS.this_lInativa     = (VAL(THIS.Cript(ALLTRIM(THIS.this_cInativas))) = 1)
            THIS.this_cNcaixa      = THIS.Cript(ALLTRIM(THIS.this_cCnCaixas))
            THIS.this_cCupomNfis   = THIS.Cript(ALLTRIM(THIS.this_cTrNfis))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Salva as alteracoes do PAF-ECF no banco de dados
    * Equivale ao Salva.Click do legado: atualiza SigCdPaf, SigCdOpe e SigOpCdc
    * Requer this_cDopes (codificado), this_cDopePafEcfs (decodificado),
    *         this_nOpDoc, this_lInativa, this_cNcaixa, this_cCupomNfis
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cDopPaf, loc_cDoc, loc_cInt
        LOCAL loc_cCaixa, loc_cTrfNf
        LOCAL loc_cInativaEnc, loc_cDocEnc, loc_cCaixaEnc, loc_cTrfNfEnc
        LOCAL loc_cMd5, loc_cUpdate, loc_nResult, loc_lSucesso, loc_lOk
        loc_lSucesso = .F.

        *-- Validacao antes do TRY (RETURN permitido aqui)
        IF !INLIST(IIF(THIS.this_lInativa, "1", "0"), "0", "1")
            MsgErro("Configura" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
                    "Acerte a Op" + CHR(231) + CHR(227) + "o Inativar!!!", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            loc_cDopPaf = ALLTRIM(THIS.this_cDopePafEcfs)  && decodificado = chave nas FK tables
            loc_cDoc    = ALLTRIM(STR(THIS.this_nOpDoc, 1))
            loc_cInt    = IIF(THIS.this_lInativa, "1", "0")
            loc_cCaixa  = ALLTRIM(THIS.this_cNcaixa)
            loc_cTrfNf  = ALLTRIM(THIS.this_cCupomNfis)

            *-- Codifica valores para armazenamento no banco
            loc_cInativaEnc = THIS.Dcript(loc_cInt)
            loc_cDocEnc     = THIS.Dcript(loc_cDoc)
            loc_cCaixaEnc   = THIS.Dcript(loc_cCaixa)
            loc_cTrfNfEnc   = THIS.Dcript(loc_cTrfNf)

            *-- Calcula hash MD5 dos valores a serem armazenados
            loc_cMd5 = THIS.ComputarMD5PafEcf(ALLTRIM(THIS.this_cDopes), ;
                           loc_cInativaEnc, loc_cDocEnc, loc_cCaixaEnc, loc_cTrfNfEnc, ;
                           loc_cDopPaf, loc_cCaixa, loc_cTrfNf)

            *-- Atualiza SigCdPaf com valores codificados + MD5
            loc_cUpdate = "UPDATE SigCdPaf SET" + ;
                          " Inativas = " + EscaparSQL(loc_cInativaEnc) + "," + ;
                          " Docs = " + EscaparSQL(loc_cDocEnc) + "," + ;
                          " cMd5s = " + EscaparSQL(loc_cMd5) + "," + ;
                          " cnCaixas = " + EscaparSQL(loc_cCaixaEnc) + "," + ;
                          " TrNfis = " + EscaparSQL(loc_cTrfNfEnc) + ;
                          " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_UpdPaf")
                TABLEREVERT(.T., "cursor_4c_UpdPaf")
                USE IN cursor_4c_UpdPaf
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cUpdate, "cursor_4c_UpdPaf")
            IF USED("cursor_4c_UpdPaf")
                USE IN cursor_4c_UpdPaf
            ENDIF

            IF loc_nResult >= 0
                *-- Atualiza tabelas FK conforme tipo de documento
                loc_lOk = THIS.AtualizarTabelasFK(loc_cDopPaf, loc_cDoc, loc_cInt, loc_cCaixa, loc_cTrfNf)
                IF loc_lOk
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao atualizar SigCdPaf: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.Atualizar: " + loc_oErro.Message + ;
                    " (Linha " + TRANSFORM(loc_oErro.LineNo) + ")", "Erro PAF-ECF")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarTabelasFK - Atualiza SigCdOpe e SigOpCdc conforme tipo documento
    * par_cDopPaf : Dopes DECODIFICADO (plain text - chave em SigCdOpe/SigOpCdc)
    * par_cDoc    : '1'=CF, '2'=CNF, '3'=DAV RG, '4'=DAV A4, '5'=PRE VENDA, '6'=Nao Fiscal
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AtualizarTabelasFK(par_cDopPaf, par_cDoc, par_cInt, par_cCaixa, par_cTrfNf)
        LOCAL loc_cUpdate1, loc_cUpdate2, loc_nRes1, loc_nRes2
        LOCAL loc_cSeries, loc_lSucesso, loc_lTipoValido
        loc_lSucesso  = .F.
        loc_lTipoValido = .T.

        TRY
            loc_cUpdate1 = ""
            loc_cUpdate2 = ""
            loc_cSeries  = ""

            DO CASE
                CASE par_cDoc = "1"
                    *-- CF - Cupom Fiscal
                    loc_cUpdate1 = "UPDATE SigCdOpe SET CupFis = 1, estoqs = 1, docus = 2" + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)
                    loc_cUpdate2 = "UPDATE SigOpCdc SET verests = 1, opeinatvs = " + par_cInt + ;
                                   ", cncaixas = " + EscaparSQL(par_cCaixa) + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)

                CASE par_cDoc = "2"
                    *-- CNF - Cupom Nao Fiscal: obtem ou cria serie PED
                    loc_cSeries  = THIS.BuscarOuCriarSerie(par_cDopPaf)
                    loc_cUpdate1 = "UPDATE SigCdOpe SET CupFis=3, estoqs=2, docus=2, TipoNfs=1," + ;
                                   " Series=" + EscaparSQL(loc_cSeries) + "," + ;
                                   " TrNfis=" + FormatarNumeroSQL(VAL(par_cTrfNf)) + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)
                    loc_cUpdate2 = "UPDATE SigOpCdc SET verests = 2, opeinatvs = " + par_cInt + ;
                                   ", cncaixas = " + EscaparSQL(par_cCaixa) + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)

                CASE par_cDoc = "3"
                    *-- DAV RG
                    loc_cUpdate1 = "UPDATE SigCdOpe SET CupFis = 2, estoqs = 2, Docus = 3" + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)
                    loc_cUpdate2 = "UPDATE SigOpCdc SET verests = 3, opeinatvs = " + par_cInt + ;
                                   ", cncaixas = " + EscaparSQL(par_cCaixa) + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)

                CASE par_cDoc = "4"
                    *-- DAV A4
                    loc_cUpdate1 = "UPDATE SigCdOpe SET CupFis = 2, estoqs = 2, Docus = 2" + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)
                    loc_cUpdate2 = "UPDATE SigOpCdc SET verests = 2, opeinatvs = " + par_cInt + ;
                                   ", cncaixas = " + EscaparSQL(par_cCaixa) + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)

                CASE par_cDoc = "5"
                    *-- PRE VENDA
                    loc_cUpdate1 = "UPDATE SigCdOpe SET CupFis = 2, estoqs = 1, nfiscals = 2," + ;
                                   " Agrupas = 1, Docus = 2 WHERE Dopes = " + EscaparSQL(par_cDopPaf)
                    loc_cUpdate2 = "UPDATE SigOpCdc SET verests = 1, opeinatvs = " + par_cInt + ;
                                   ", cncaixas = " + EscaparSQL(par_cCaixa) + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)

                CASE par_cDoc = "6"
                    *-- Nao Fiscal
                    loc_cUpdate1 = "UPDATE SigCdOpe SET CupFis = 2, estoqs = 1, nfiscals = 2," + ;
                                   " Agrupas = 2, Docus = 2 WHERE Dopes = " + EscaparSQL(par_cDopPaf)
                    loc_cUpdate2 = "UPDATE SigOpCdc SET verests = 1, opeinatvs = " + par_cInt + ;
                                   ", cncaixas = " + EscaparSQL(par_cCaixa) + ;
                                   " WHERE Dopes = " + EscaparSQL(par_cDopPaf)

                OTHERWISE
                    MsgErro("Configura" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + ;
                            "lida de Documento!!! Tipo: " + par_cDoc, ;
                            "Valida" + CHR(231) + CHR(227) + "o")
                    loc_lTipoValido = .F.
            ENDCASE

            IF loc_lTipoValido AND !EMPTY(ALLTRIM(loc_cUpdate1))
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_FkA")
                    TABLEREVERT(.T., "cursor_4c_FkA")
                    USE IN cursor_4c_FkA
                ENDIF

                loc_nRes1 = SQLEXEC(gnConnHandle, loc_cUpdate1, "cursor_4c_FkA")
                IF USED("cursor_4c_FkA")
                    USE IN cursor_4c_FkA
                ENDIF
                IF loc_nRes1 >= 0
                    *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                    IF USED("cursor_4c_FkB")
                        TABLEREVERT(.T., "cursor_4c_FkB")
                        USE IN cursor_4c_FkB
                    ENDIF

                    loc_nRes2 = SQLEXEC(gnConnHandle, loc_cUpdate2, "cursor_4c_FkB")
                    IF USED("cursor_4c_FkB")
                        USE IN cursor_4c_FkB
                    ENDIF
                    IF loc_nRes2 >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao atualizar SigOpCdc: " + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    MsgErro("Erro ao atualizar SigCdOpe: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.AtualizarTabelasFK: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarOuCriarSerie - Obtem serie da operacao ou cria serie PED para CNF
    * Retorna o codigo da serie (ex: "PED")
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarOuCriarSerie(par_cDopPaf)
        LOCAL loc_cSQL, loc_nResult, loc_cSeries, loc_nQtd
        loc_cSeries = ""

        TRY
            *-- Tenta obter a serie existente em SigCdOpe
            loc_cSQL = "SELECT Series FROM SigCdOpe WHERE Dopes = " + EscaparSQL(par_cDopPaf)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_OpeS")
                TABLEREVERT(.T., "cursor_4c_OpeS")
                USE IN cursor_4c_OpeS
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeS")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_OpeS") > 0
                SELECT cursor_4c_OpeS
                loc_cSeries = ALLTRIM(cursor_4c_OpeS.Series)
            ENDIF
            IF USED("cursor_4c_OpeS")
                USE IN cursor_4c_OpeS
            ENDIF

            IF EMPTY(ALLTRIM(loc_cSeries))
                loc_cSeries = "PED"
                *-- Verifica se serie PED ja existe em SIGCDSER
                loc_cSQL = "SELECT COUNT(*) AS Qtd FROM SIGCDSER WHERE EmpCods = " + ;
                           EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa) + loc_cSeries)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_SerieEx")
                    TABLEREVERT(.T., "cursor_4c_SerieEx")
                    USE IN cursor_4c_SerieEx
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SerieEx")
                loc_nQtd = 0
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_SerieEx") > 0
                    SELECT cursor_4c_SerieEx
                    loc_nQtd = cursor_4c_SerieEx.Qtd
                ENDIF
                IF USED("cursor_4c_SerieEx")
                    USE IN cursor_4c_SerieEx
                ENDIF

                IF loc_nQtd = 0
                    *-- Cria nova serie PED
                    loc_cSQL = "INSERT INTO SIGCDSER" + ;
                               " (Emps, Cods, Descs, cTipoNfs, ImpNfs, TipoNfs, EmpCods)" + ;
                               " VALUES (" + ;
                               EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + "," + ;
                               EscaparSQL(loc_cSeries) + "," + ;
                               EscaparSQL(loc_cSeries) + ",'ECF',2,1," + ;
                               EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa) + loc_cSeries) + ")"
                    *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                    IF USED("cursor_4c_InsS")
                        TABLEREVERT(.T., "cursor_4c_InsS")
                        USE IN cursor_4c_InsS
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsS")
                    IF USED("cursor_4c_InsS")
                        USE IN cursor_4c_InsS
                    ENDIF
                    IF loc_nResult < 0
                        MsgErro("Erro ao criar s" + CHR(233) + "rie PED: " + ;
                                CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.BuscarOuCriarSerie: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cSeries
    ENDFUNC

    *--------------------------------------------------------------------------
    * SincronizarDados - Sincroniza SigCdPaf com operacoes PAF da empresa
    * Equivale ao Init() do legado:
    *   1. Insere em SigCdPaf as ops que faltam (pafEcfs=1 em SigOpCdd)
    *   2. Remove de SigCdPaf as ops que nao existem mais em SigOpCdd
    *   3. Valida integridade MD5 e redefine registros corrompidos
    * Deve ser chamado ao abrir o formulario (antes de Buscar)
    *--------------------------------------------------------------------------
    FUNCTION SincronizarDados()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_lFaseOk
        LOCAL loc_cDoc, loc_cDopes, loc_cDopesDecod
        LOCAL loc_cInativaEnc, loc_cDocEnc, loc_cCaixaEnc, loc_cTrfNfEnc, loc_cMd5
        loc_lSucesso = .F.
        loc_lFaseOk  = .T.

        TRY
            *-- FASE 1: Carrega operacoes PAF ativas (SigOpCdd + SigOpCdc + SigCdOpe)
            loc_cSQL = "SELECT a.Dopes, b.OpeInatvs, b.cnCaixas," + ;
                       " c.CupFis, c.nFiscals, c.Agrupas, c.Docus, c.TrNfis" + ;
                       " FROM SigOpCdd a" + ;
                       " INNER JOIN SigOpCdc b ON b.dopes = a.Dopes" + ;
                       " INNER JOIN SigCdOpe c ON c.Dopes = a.Dopes" + ;
                       " WHERE a.pafEcfs = 1"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_LocalOpe2")
                TABLEREVERT(.T., "cursor_4c_LocalOpe2")
                USE IN cursor_4c_LocalOpe2
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe2")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es PAF: " + ;
                        CapturarErroSQL(), "Erro SQL")
                loc_lFaseOk = .F.
            ENDIF

            *-- FASE 2: Carrega registros PAF existentes para comparacao
            IF loc_lFaseOk
                loc_cSQL = "SELECT Dopes, Inativas, Docs, cMd5s, cnCaixas, TrNfis FROM SigCdPaf"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_PafExist")
                    TABLEREVERT(.T., "cursor_4c_PafExist")
                    USE IN cursor_4c_PafExist
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PafExist")
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar SigCdPaf: " + CapturarErroSQL(), "Erro SQL")
                    loc_lFaseOk = .F.
                ENDIF
            ENDIF

            *-- FASE 3: Insere operacoes faltantes em SigCdPaf
            IF loc_lFaseOk AND USED("cursor_4c_LocalOpe2") AND ;
               RECCOUNT("cursor_4c_LocalOpe2") > 0
                SELECT cursor_4c_LocalOpe2
                GO TOP
                SCAN
                    loc_cDopes = ALLTRIM(cursor_4c_LocalOpe2.Dopes)  && plain text
                    IF !THIS.ExisteDopesNoPaf(loc_cDopes)
                        MsgAviso("Aten" + CHR(231) + CHR(227) + "o!!! Opera" + ;
                                 CHR(231) + CHR(227) + "o: " + loc_cDopes + ;
                                 " Esta Inconsistente. O sistema ir" + CHR(225) + ;
                                 " assumir as Configura" + CHR(231) + CHR(245) + ;
                                 "es Padr" + CHR(245) + "es!!!!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")

                        loc_cDoc = "0"
                        DO CASE
                            CASE cursor_4c_LocalOpe2.CupFis = 1
                                loc_cDoc = "1"
                            CASE cursor_4c_LocalOpe2.CupFis = 3
                                loc_cDoc = "2"
                            CASE cursor_4c_LocalOpe2.CupFis = 2 AND cursor_4c_LocalOpe2.Docus = 3
                                loc_cDoc = "3"
                            CASE cursor_4c_LocalOpe2.CupFis = 2 AND cursor_4c_LocalOpe2.Docus = 2
                                loc_cDoc = "4"
                        ENDCASE

                        loc_cInativaEnc = THIS.Dcript(ALLTRIM(STR(cursor_4c_LocalOpe2.OpeInatvs, 1)))
                        loc_cDocEnc     = THIS.Dcript(loc_cDoc)
                        loc_cCaixaEnc   = THIS.Dcript(PADL(ALLTRIM(STR(cursor_4c_LocalOpe2.cnCaixas, 3)), 3, "0"))
                        loc_cTrfNfEnc   = THIS.Dcript(PADL(ALLTRIM(STR(cursor_4c_LocalOpe2.TrNfis, 2)), 2, "0"))

                        loc_cSQL = "INSERT INTO SigCdPaf" + ;
                                   " (Dopes, Inativas, Docs, cMd5s, cnCaixas, TrNfis)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.Dcript(loc_cDopes)) + "," + ;
                                   EscaparSQL(loc_cInativaEnc) + "," + ;
                                   EscaparSQL(loc_cDocEnc) + ",''," + ;
                                   EscaparSQL(loc_cCaixaEnc) + "," + ;
                                   EscaparSQL(loc_cTrfNfEnc) + ")"
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_InsP")
                            TABLEREVERT(.T., "cursor_4c_InsP")
                            USE IN cursor_4c_InsP
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsP")
                        IF USED("cursor_4c_InsP")
                            USE IN cursor_4c_InsP
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir PAF para " + loc_cDopes + ": " + ;
                                    CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- FASE 4: Remove registros PAF orfaos (sem operacao em SigOpCdd)
            IF loc_lFaseOk AND USED("cursor_4c_PafExist") AND ;
               RECCOUNT("cursor_4c_PafExist") > 0
                SELECT cursor_4c_PafExist
                GO TOP
                SCAN
                    *-- Decodifica o Dopes codificado do banco para comparar com SigOpCdd (plain)
                    loc_cDopesDecod = THIS.Cript(ALLTRIM(cursor_4c_PafExist.Dopes))
                    IF !THIS.ExisteDopesNaOperacao(loc_cDopesDecod)
                        loc_cSQL = "DELETE FROM SigCdPaf WHERE Dopes = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_PafExist.Dopes))
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_DelP")
                            TABLEREVERT(.T., "cursor_4c_DelP")
                            USE IN cursor_4c_DelP
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelP")
                        IF USED("cursor_4c_DelP")
                            USE IN cursor_4c_DelP
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao remover PAF orf" + CHR(227) + "o " + ;
                                    loc_cDopesDecod + ": " + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- FASE 5: Valida integridade MD5; redefine registros corrompidos
            IF loc_lFaseOk
                IF USED("cursor_4c_PafExist")
                    USE IN cursor_4c_PafExist
                ENDIF
                loc_cSQL = "SELECT Dopes, Inativas, Docs, cMd5s, cnCaixas, TrNfis FROM SigCdPaf"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PafExist")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_PafExist") > 0
                    SELECT cursor_4c_PafExist
                    GO TOP
                    SCAN
                        loc_cDopesDecod = THIS.Cript(ALLTRIM(cursor_4c_PafExist.Dopes))
                        IF !THIS.ValidarIntegridade(loc_cDopesDecod) AND ;
                           THIS.ExisteDopesNaOperacao(loc_cDopesDecod)
                            MsgAviso("Aten" + CHR(231) + CHR(227) + "o!!! Opera" + ;
                                     CHR(231) + CHR(227) + "o: " + loc_cDopesDecod + ;
                                     " Esta Inconsistente. O sistema ir" + CHR(225) + ;
                                     " assumir as Configura" + CHR(231) + CHR(245) + ;
                                     "es Padr" + CHR(245) + "es!!!!", ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                            THIS.RedefinirPadroesOperacao(loc_cDopesDecod)
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDIF

            IF loc_lFaseOk
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.SincronizarDados: " + loc_oErro.Message + ;
                    " (Linha " + TRANSFORM(loc_oErro.LineNo) + ")", "Erro PAF-ECF")
        ENDTRY

        IF USED("cursor_4c_LocalOpe2")
            USE IN cursor_4c_LocalOpe2
        ENDIF
        IF USED("cursor_4c_PafExist")
            USE IN cursor_4c_PafExist
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarIntegridade - Valida hash MD5 de um registro PAF
    * par_cDopesDecod: Dopes DECODIFICADO (plain text, como exibido no grid)
    *--------------------------------------------------------------------------
    FUNCTION ValidarIntegridade(par_cDopesDecod)
        LOCAL loc_cSQL, loc_nResult, loc_cMd5Calc, loc_cMd5Armazd, loc_lValido
        loc_lValido = .F.

        TRY
            *-- Codifica para localizar o registro no banco
            loc_cSQL = "SELECT * FROM SigCdPaf WHERE Dopes = " + ;
                       EscaparSQL(THIS.Dcript(ALLTRIM(par_cDopesDecod)))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Md5Val")
                TABLEREVERT(.T., "cursor_4c_Md5Val")
                USE IN cursor_4c_Md5Val
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Md5Val")
            IF loc_nResult < 0 OR RECCOUNT("cursor_4c_Md5Val") = 0
                MsgErro("Favor Reinicializar o Processo!!! " + ;
                        "Falha na Conex" + CHR(227) + "o (Md5Val)", "Erro!!!")
            ELSE
                loc_cMd5Calc   = THIS.GerarMD5("cursor_4c_Md5Val", "cMd5s")
                SELECT cursor_4c_Md5Val
                loc_cMd5Armazd = ALLTRIM(cursor_4c_Md5Val.cMd5s)
                loc_lValido    = (loc_cMd5Armazd == loc_cMd5Calc)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.ValidarIntegridade: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Md5Val")
            USE IN cursor_4c_Md5Val
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ComputarMD5PafEcf - Cria cursor temporario e calcula MD5 para o PAF-ECF
    * Espelha a estrutura de CrSigCdPaf usada em fGerarMD52016 no legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ComputarMD5PafEcf(par_cDopes, par_cInativas, par_cDocs, ;
                                          par_cCnCaixas, par_cTrNfis, ;
                                          par_cDopePafEcfs, par_cCx, par_cTrNf)
        LOCAL loc_cMd5
        loc_cMd5 = ""

        TRY
            IF USED("cursor_4c_Md5Tmp")
                USE IN cursor_4c_Md5Tmp
            ENDIF

            CREATE CURSOR cursor_4c_Md5Tmp ( ;
                Dopes       C(20), ;
                Inativas    C(1), ;
                Docs        C(1), ;
                cMd5s       C(32), ;
                cnCaixas    C(3), ;
                TrNfis      C(2), ;
                DopePafEcfs C(50), ;
                Cx          C(3), ;
                TrNf        C(2))

            INSERT INTO cursor_4c_Md5Tmp VALUES ( ;
                par_cDopes, par_cInativas, par_cDocs, ;
                "", par_cCnCaixas, par_cTrNfis, ;
                par_cDopePafEcfs, par_cCx, par_cTrNf)

            loc_cMd5 = THIS.GerarMD5("cursor_4c_Md5Tmp", "cMd5s,DopePafEcfs,Cx,TrNf")
        CATCH TO loc_oErro
            MsgErro("Erro ao computar MD5 PAF-ECF: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Md5Tmp")
            USE IN cursor_4c_Md5Tmp
        ENDIF

        RETURN loc_cMd5
    ENDFUNC

    *--------------------------------------------------------------------------
    * RedefinirPadroesOperacao - Redefine SigCdPaf com valores padrao de SigCdOpe
    * Chamado quando MD5 invalido mas operacao ainda existe em SigOpCdd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION RedefinirPadroesOperacao(par_cDopesDecod)
        LOCAL loc_cSQL, loc_nResult, loc_cDoc, loc_cMd5, loc_lSucesso
        LOCAL loc_cInativaEnc, loc_cDocEnc, loc_cCaixaEnc, loc_cTrfNfEnc, loc_cDopesEnc
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Dopes, b.OpeInatvs, b.cnCaixas," + ;
                       " c.CupFis, c.nFiscals, c.Agrupas, c.Docus, c.TrNfis" + ;
                       " FROM SigOpCdd a" + ;
                       " INNER JOIN SigOpCdc b ON b.dopes = a.Dopes" + ;
                       " INNER JOIN SigCdOpe c ON c.Dopes = a.Dopes" + ;
                       " WHERE a.pafEcfs = 1 AND a.Dopes = " + EscaparSQL(par_cDopesDecod)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_OpeRed")
                TABLEREVERT(.T., "cursor_4c_OpeRed")
                USE IN cursor_4c_OpeRed
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeRed")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_OpeRed") > 0
                SELECT cursor_4c_OpeRed
                loc_cDoc = "0"
                DO CASE
                    CASE cursor_4c_OpeRed.CupFis = 1
                        loc_cDoc = "1"
                    CASE cursor_4c_OpeRed.CupFis = 3
                        loc_cDoc = "2"
                    CASE cursor_4c_OpeRed.CupFis = 2 AND cursor_4c_OpeRed.Docus = 3
                        loc_cDoc = "3"
                    CASE cursor_4c_OpeRed.CupFis = 2 AND cursor_4c_OpeRed.Docus = 2
                        loc_cDoc = "4"
                ENDCASE

                loc_cDopesEnc   = THIS.Dcript(par_cDopesDecod)
                loc_cInativaEnc = THIS.Dcript(ALLTRIM(STR(cursor_4c_OpeRed.OpeInatvs, 1)))
                loc_cDocEnc     = THIS.Dcript(loc_cDoc)
                loc_cCaixaEnc   = THIS.Dcript(PADL(ALLTRIM(STR(cursor_4c_OpeRed.cnCaixas, 3)), 3, "0"))
                loc_cTrfNfEnc   = THIS.Dcript(PADL(ALLTRIM(STR(cursor_4c_OpeRed.TrNfis, 2)), 2, "0"))

                loc_cMd5 = THIS.ComputarMD5PafEcf( ;
                               loc_cDopesEnc, loc_cInativaEnc, loc_cDocEnc, ;
                               loc_cCaixaEnc, loc_cTrfNfEnc, ;
                               par_cDopesDecod, ;
                               THIS.Cript(loc_cCaixaEnc), THIS.Cript(loc_cTrfNfEnc))

                loc_cSQL = "UPDATE SigCdPaf SET" + ;
                           " Inativas = " + EscaparSQL(loc_cInativaEnc) + "," + ;
                           " Docs = " + EscaparSQL(loc_cDocEnc) + "," + ;
                           " cMd5s = " + EscaparSQL(loc_cMd5) + "," + ;
                           " cnCaixas = " + EscaparSQL(loc_cCaixaEnc) + "," + ;
                           " TrNfis = " + EscaparSQL(loc_cTrfNfEnc) + ;
                           " WHERE Dopes = " + EscaparSQL(loc_cDopesEnc)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_UpdRed")
                    TABLEREVERT(.T., "cursor_4c_UpdRed")
                    USE IN cursor_4c_UpdRed
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdRed")
                IF USED("cursor_4c_UpdRed")
                    USE IN cursor_4c_UpdRed
                ENDIF
                IF loc_nResult >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao redefinir SigCdPaf para " + par_cDopesDecod + ": " + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.RedefinirPadroesOperacao: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_OpeRed")
            USE IN cursor_4c_OpeRed
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteDopesNoPaf - Verifica se um Dopes (plain text) tem registro em SigCdPaf
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExisteDopesNoPaf(par_cDopesPlain)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.

        TRY
            *-- SigCdPaf.Dopes e codificado; codificamos o plain para buscar
            loc_cSQL = "SELECT COUNT(*) AS Qtd FROM SigCdPaf WHERE Dopes = " + ;
                       EscaparSQL(THIS.Dcript(ALLTRIM(par_cDopesPlain)))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ExPaf")
                TABLEREVERT(.T., "cursor_4c_ExPaf")
                USE IN cursor_4c_ExPaf
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExPaf")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ExPaf") > 0
                SELECT cursor_4c_ExPaf
                loc_lExiste = (cursor_4c_ExPaf.Qtd > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.ExisteDopesNoPaf: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ExPaf")
            USE IN cursor_4c_ExPaf
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteDopesNaOperacao - Verifica se um Dopes decodificado existe em SigOpCdd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExisteDopesNaOperacao(par_cDopesPlain)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.

        TRY
            *-- SigOpCdd.Dopes e plain text
            loc_cSQL = "SELECT COUNT(*) AS Qtd FROM SigOpCdd WHERE pafEcfs = 1 AND Dopes = " + ;
                       EscaparSQL(ALLTRIM(par_cDopesPlain))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ExOpe")
                TABLEREVERT(.T., "cursor_4c_ExOpe")
                USE IN cursor_4c_ExOpe
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExOpe")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ExOpe") > 0
                SELECT cursor_4c_ExOpe
                loc_lExiste = (cursor_4c_ExOpe.Qtd > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pafBO.ExisteDopesNaOperacao: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ExOpe")
            USE IN cursor_4c_ExOpe
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * Cript - Wrapper para fCriptografar (decodifica valor do banco para exibicao)
    * ATENCAO: a funcao legada chama-se fCriptografar mas DECODIFICA para exibir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Cript(par_cValor)
        LOCAL loc_cResultado
        loc_cResultado = ALLTRIM(par_cValor)

        TRY
            loc_cResultado = fCriptografar(ALLTRIM(par_cValor))
        CATCH TO loc_oErro
            MsgErro("fCriptografar n" + CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Verifique se o Framework Fortyus est" + CHR(225) + ;
                    " carregado (sigfuncs.prg).", "Erro PAF-ECF")
        ENDTRY

        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Dcript - Wrapper para fDecriptografar (codifica valor para armazenamento)
    * ATENCAO: a funcao legada chama-se fDecriptografar mas CODIFICA para gravar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Dcript(par_cValor)
        LOCAL loc_cResultado
        loc_cResultado = ALLTRIM(par_cValor)

        TRY
            loc_cResultado = fDecriptografar(ALLTRIM(par_cValor))
        CATCH TO loc_oErro
            MsgErro("fDecriptografar n" + CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Verifique se o Framework Fortyus est" + CHR(225) + ;
                    " carregado (sigfuncs.prg).", "Erro PAF-ECF")
        ENDTRY

        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarMD5 - Wrapper para fGerarMD52016
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarMD5(par_cCursor, par_cCampos)
        LOCAL loc_cResultado
        loc_cResultado = ""

        TRY
            loc_cResultado = fGerarMD52016(par_cCursor, par_cCampos)
        CATCH TO loc_oErro
            MsgErro("fGerarMD52016 n" + CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Verifique se o Framework Fortyus est" + CHR(225) + " carregado.", ;
                    "Erro PAF-ECF")
        ENDTRY

        RETURN loc_cResultado
    ENDFUNC

ENDDEFINE

