# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: TIMEOUT: VFP9 travou durante teste de formulario (300s). Possivel erro de runtime (Property not found, dialog modal).

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-06-04 03:39:17] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-04 03:39:17] [INFO] Config FPW: (nao fornecido)
[2026-06-04 03:39:17] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-06-04 03:39:17] [INFO] Timeout: 300 segundos
[2026-06-04 03:39:17] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rfvd0pkp.prg
[2026-06-04 03:39:17] [INFO] Conteudo do wrapper:
[2026-06-04 03:39:17] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSIGREDES', 'C:\4c\tasks\task078\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGREDES', 'C:\4c\tasks\task078\logs\06_testForm.log'
QUIT

[2026-06-04 03:39:17] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rfvd0pkp.prg
[2026-06-04 03:39:17] [INFO] VFP output esperado em: C:\4c\tasks\task078\vfp_output.txt
[2026-06-04 03:39:17] [INFO] Executando Visual FoxPro 9...
[2026-06-04 03:39:17] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rfvd0pkp.prg
[2026-06-04 03:39:17] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rfvd0pkp.prg
[2026-06-04 03:39:17] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSIGREDES
Inicio: 04/06/2026 03:39:18

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
[2026-06-04 03:44:18] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 2332)...
[2026-06-04 03:44:20] [INFO] VFP9 finalizado em 302.0639516 segundos
[2026-06-04 03:44:20] [INFO] Exit Code: 4
[2026-06-04 03:44:20] [INFO] 
[2026-06-04 03:44:20] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-04 03:44:20] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rfvd0pkp.prg
[2026-06-04 03:44:20] [INFO] 
[2026-06-04 03:44:20] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-04 03:44:20] [INFO] * Auto-generated wrapper for parameters
[2026-06-04 03:44:20] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-06-04 03:44:20] [INFO] * Parameters: 'FormSIGREDES', 'C:\4c\tasks\task078\logs\06_testForm.log'
[2026-06-04 03:44:20] [INFO] 
[2026-06-04 03:44:20] [INFO] * Anti-dialog protections for unattended execution
[2026-06-04 03:44:20] [INFO] SET SAFETY OFF
[2026-06-04 03:44:20] [INFO] SET RESOURCE OFF
[2026-06-04 03:44:20] [INFO] SET TALK OFF
[2026-06-04 03:44:20] [INFO] SET NOTIFY OFF
[2026-06-04 03:44:20] [INFO] SYS(2335, 0)
[2026-06-04 03:44:20] [INFO] 
[2026-06-04 03:44:20] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSIGREDES', 'C:\4c\tasks\task078\logs\06_testForm.log'
[2026-06-04 03:44:20] [INFO] QUIT
[2026-06-04 03:44:20] [INFO] 
[2026-06-04 03:44:20] [INFO] === Fim do Wrapper.prg ===
[2026-06-04 03:44:20] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREDES.prg):
*==============================================================================
* FORMSIGREDES.PRG
* Formulario de Filtros para Relatorio de Cotas de Desconto
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREDES.SCX (frmrelatorio)
*
* Dimensoes exatas do original: Width=555, Height=499
*
* Layout: Cabecalho (cnt_4c_Cabecalho) + BotaoGroup (cmg_4c_Botoes)
*         + PageFrame (pgf_4c_Paginas, PageCount=1, Tabs=.F.)
*   Page1 (Filtros):
*     - Empresa  : txt_4c_Empresa   + txt_4c_DesEmpresa  -> SigCdEmp (cEmps/Razas)
*     - Periodo  : txt_4c_DtInicial + txt_4c_DtFinal     (datas)
*     - Grupo    : txt_4c_CGru      + txt_4c_DGru        -> SigCdGcr (codigos/descrs)
*     - Conta    : txt_4c_Vend      + txt_4c_DVend       -> SigCdCli (IClis/RClis)
*     - Categoria: txt_4c_Cate      + txt_4c_CateD       -> SigCdCol (codigos/descrs)
*     - Colecao  : txt_4c_Cole      + txt_4c_ColeD       -> SigCdPsg (codigos/descricaos)
*     - Produto  : txt_4c_Prod      + txt_4c_ProdD       -> SigCdPro (CPros/DPros)
*     - opt_4c_Tipo   : 1=Detalhado, 2=Resumido
*     - chk_4c_Desc   : somente com desconto
*     - chk_4c_Lanc   : somente lancamentos
*     - grd_4c_Forma  : formas de pagamento (cursor_4c_OpFp)
*     - cmd_4c_Marcar / cmd_4c_Desmarcar
*==============================================================================

DEFINE CLASS FormSIGREDES AS FormBase

    *-- Dimensoes exatas do original (Width=555, Height=499)
    Height      = 499
    Width       = 555
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que aplica SET DATE BRITISH/CENTURY ON
    *   e chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta estrutura visual do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Cotas de Desconto"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGREDESBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGREDESBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Inicializar filtros do BO (periodo, empresa, formas de pagamento)
                THIS.this_oRelatorio.InicializarFiltros()

                *-- Estrutura visual
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarFiltros()

                *-- Vincular eventos Click dos botoes do relatorio
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                *-- Vincular eventos Click dos botoes de marca/desmarca do grid
                BINDEVENT(THIS.pgf_4c_Paginas.Page1.cmd_4c_Marcar,    "Click", THIS, "MarcarClick")
                BINDEVENT(THIS.pgf_4c_Paginas.Page1.cmd_4c_Desmarcar, "Click", THIS, "DesmarcarClick")

                *-- Vincular eventos de teclado e duplo-clique dos campos de filtro
                THIS.VincularEventosFiltros()

                *-- Carregar valores iniciais do BO nos controles
                THIS.CarregarFiltrosNaUI()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Cotas de Desconto"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Cotas de Desconto"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Geometria adaptada para Width=555 (Left=283, Width=272)
    *   Botoes: Visualizar/Imprimir/Excel/Encerrar (Left=5/71/137/203)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 283
            .Width         = 272
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Excel"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Exportar para Excel"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame de 1 pagina (Filtros)
    *   Top=85, cobrindo o restante do form (Height=499-85=414)
    *   Tabs=.F. (sem abas visiveis, formulario aparece plano)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount ANTES de acessar Page1
        loc_oPgf.PageCount = 1

        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Wrapper de compatibilidade do pipeline de migracao
    *   FormSIGREDES eh REPORT (frmrelatorio): Page1 contem os FILTROS do
    *   relatorio (datas, codigos, opcoes) e a grade grd_4c_Forma de formas
    *   de pagamento. Todo o layout e configurado em ConfigurarFiltros().
    *   Esta procedure existe para satisfazer a fase 4 do pipeline (que assume
    *   forms CRUD com Page1=Lista) sem duplicar codigo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - RELATORIO: sem Page2 de dados CRUD.
    *   FormSIGREDES tem layout FLAT (PageCount=1). Todos os campos de filtro
    *   (Empresa, Periodo, Grupo, Conta, Categoria, Colecao, Produto, Tipo,
    *   Checkboxes, Grid de Formas de Pagamento) foram adicionados em
    *   ConfigurarFiltros() chamado de ConfigurarPaginaLista(). Este metodo
    *   garante visibilidade da unica page e existe para compatibilidade com
    *   o pipeline de migracao multi-fase (Fase 5 - campos Page2 Parte 1).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.pgf_4c_Paginas.Visible    = .T.
        THIS.pgf_4c_Paginas.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltros - Adiciona todos os controles de filtro na Page1
    *   Posicoes ajustadas: Top_novo = Top_original - 85
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- === LINHA EMPRESA (Top_orig=86/89) ===

        *-- Label "Empresa :"
        loc_oPg.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPg.lbl_4c_Empresa
            .Top       = 4
            .Left      = 69
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo da Empresa (SigCdEmp.cEmps, MaxLength=3)
        loc_oPg.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPg.txt_4c_Empresa
            .Top           = 1
            .Left          = 123
            .Width         = 31
            .Height        = 21
            .MaxLength     = 3
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Descricao da Empresa (SigCdEmp.Razas, ReadOnly)
        loc_oPg.AddObject("txt_4c_DesEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_DesEmpresa
            .Top           = 1
            .Left          = 156
            .Width         = 353
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackColor     = RGB(240, 240, 240)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- === LINHA PERIODO (Top_orig=111/114/115) ===

        *-- Label "Periodo :"
        loc_oPg.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPg.lbl_4c_Periodo
            .Top       = 29
            .Left      = 74
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Data Inicial
        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Top           = 26
            .Left          = 123
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .Value         = {}
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Separador "a" entre datas
        loc_oPg.AddObject("lbl_4c_Sep", "Label")
        WITH loc_oPg.lbl_4c_Sep
            .Top       = 30
            .Left      = 207
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Data Final
        loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg.txt_4c_DtFinal
            .Top           = 26
            .Left          = 220
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .Value         = {}
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- === LINHA GRUPO (Top_orig=136/138) ===

        *-- Label "Grupo :"
        loc_oPg.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPg.lbl_4c_Grupo
            .Top       = 53
            .Left      = 81
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo do Grupo (SigCdGcr.codigos, MaxLength=10)
        loc_oPg.AddObject("txt_4c_CGru", "TextBox")
        WITH loc_oPg.txt_4c_CGru
            .Top           = 51
            .Left          = 123
            .Width         = 80
            .Height        = 21
            .MaxLength     = 10
            .Value         = ""
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Descricao do Grupo (SigCdGcr.descrs, ReadOnly)
        loc_oPg.AddObject("txt_4c_DGru", "TextBox")
        WITH loc_oPg.txt_4c_DGru
            .Top           = 51
            .Left          = 205
            .Width         = 304
            .Height        = 21
            .MaxLength     = 20
            .Value         = ""
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackColor     = RGB(240, 240, 240)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- === LINHA CONTA/VENDEDOR (Top_orig=159/162) ===

        *-- Label "Conta :"
        loc_oPg.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oPg.lbl_4c_Conta
            .Top       = 77
            .Left      = 81
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo do Vendedor/Conta (SigCdCli.IClis, MaxLength=10)
        loc_oPg.AddObject("txt_4c_Vend", "TextBox")
        WITH loc_oPg.txt_4c_Vend
            .Top           = 74
            .Left          = 123
            .Width         = 80
            .Height        = 21
            .MaxLength     = 10
            .Value         = ""
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Descricao do Vendedor/Conta (SigCdCli.RClis, ReadOnly)
        loc_oPg.AddObject("txt_4c_DVend", "TextBox")
        WITH loc_oPg.txt_4c_DVend
            .Top           = 74
            .Left          = 205
            .Width         = 304
            .Height        = 21
            .MaxLength     = 40
            .Value         = ""
            .Format        = "K"
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackColor     = RGB(240, 240, 240)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- === LINHA CATEGORIA (Top_orig=182/185) ===

        *-- Label "Categoria :"
        loc_oPg.AddObject("lbl_4c_Categ", "Label")
        WITH loc_oPg.lbl_4c_Categ
            .Top       = 100
            .Left      = 63
            .Caption   = "Categoria :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo da Categoria (SigCdCol.codigos, MaxLength=10)
        loc_oPg.AddObject("txt_4c_Cate", "TextBox")
        WITH loc_oPg.txt_4c_Cate
            .Top           = 97
            .Left          = 123
            .Width         = 108
            .Height        = 23
            .MaxLength     = 10
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Descricao da Categoria (SigCdCol.descrs, ReadOnly)
        loc_oPg.AddObject("txt_4c_CateD", "TextBox")
        WITH loc_oPg.txt_4c_CateD
            .Top           = 97
            .Left          = 233
            .Width         = 276
            .Height        = 23
            .MaxLength     = 40
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackColor     = RGB(240, 240, 240)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- === LINHA COLECAO (Top_orig=207/210) ===

        *-- Label "Colecao :" (Cole + CHR(231) + CHR(227) + "o :")
        loc_oPg.AddObject("lbl_4c_Colecao", "Label")
        WITH loc_oPg.lbl_4c_Colecao
            .Top       = 125
            .Left      = 69
            .Caption   = "Cole" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo da Colecao (SigCdPsg.codigos, MaxLength=10)
        loc_oPg.AddObject("txt_4c_Cole", "TextBox")
        WITH loc_oPg.txt_4c_Cole
            .Top           = 122
            .Left          = 123
            .Width         = 108
            .Height        = 23
            .MaxLength     = 10
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Descricao da Colecao (SigCdPsg.descricaos, ReadOnly)
        loc_oPg.AddObject("txt_4c_ColeD", "TextBox")
        WITH loc_oPg.txt_4c_ColeD
            .Top           = 122
            .Left          = 233
            .Width         = 276
            .Height        = 23
            .MaxLength     = 40
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackColor     = RGB(240, 240, 240)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- === LINHA PRODUTO (Top_orig=232/235) ===

        *-- Label "Produto :"
        loc_oPg.AddObject("lbl_4c_Produto", "Label")
        WITH loc_oPg.lbl_4c_Produto
            .Top       = 150
            .Left      = 72
            .Caption   = "Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo do Produto (SigCdPro.CPros, MaxLength=14)
        loc_oPg.AddObject("txt_4c_Prod", "TextBox")
        WITH loc_oPg.txt_4c_Prod
            .Top           = 147
            .Left          = 123
            .Width         = 108
            .Height        = 23
            .MaxLength     = 14
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Descricao do Produto (SigCdPro.DPros, ReadOnly)
        loc_oPg.AddObject("txt_4c_ProdD", "TextBox")
        WITH loc_oPg.txt_4c_ProdD
            .Top           = 147
            .Left          = 233
            .Width         = 276
            .Height        = 23
            .MaxLength     = 40
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 9
            .BackColor     = RGB(240, 240, 240)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- === TIPO DE VISAO (Top_orig=261/266) ===

        *-- Label "Tipo :"
        loc_oPg.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPg.lbl_4c_Tipo
            .Top       = 181
            .Left      = 90
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup tipo de visao (1=Detalhado, 2=Resumido)
        loc_oPg.AddObject("opt_4c_Tipo", "OptionGroup")
        WITH loc_oPg.opt_4c_Tipo
            .Top         = 176
            .Left        = 115
            .Width       = 137
            .Height      = 47
            .ButtonCount = 2
            .Value       = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Vis" + CHR(227) + "o detalhada"
                .Value     = 1
                .Height    = 15
                .Left      = 7
                .Top       = 5
                .Width     = 94
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Vis" + CHR(227) + "o Resumida"
                .Height    = 15
                .Left      = 7
                .Top       = 26
                .Width     = 92
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- === CHECKBOXES (Top_orig=264) ===

        *-- CheckBox "Com desconto"
        loc_oPg.AddObject("chk_4c_Desc", "CheckBox")
        WITH loc_oPg.chk_4c_Desc
            .Top       = 179
            .Left      = 280
            .Height    = 15
            .Width     = 86
            .Caption   = "Com desconto"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- CheckBox "Lancamento"
        loc_oPg.AddObject("chk_4c_Lanc", "CheckBox")
        WITH loc_oPg.chk_4c_Lanc
            .Top       = 179
            .Left      = 385
            .Height    = 15
            .Width     = 76
            .Caption   = "Lan" + CHR(231) + "amento"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- === GRID FORMAS DE PAGAMENTO (Top_orig=306) ===

        *-- Label "Forma de Pagamento :"
        loc_oPg.AddObject("lbl_4c_FormasPgto", "Label")
        WITH loc_oPg.lbl_4c_FormasPgto
            .Top       = 221
            .Left      = 8
            .Caption   = "Forma de Pagamento :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Grid de Formas de Pagamento (RecordSource = cursor_4c_OpFp)
        loc_oPg.AddObject("grd_4c_Forma", "Grid")
        loc_oPg.grd_4c_Forma.ColumnCount = 3
        loc_oPg.grd_4c_Forma.RecordSource = "cursor_4c_OpFp"
        loc_oPg.grd_4c_Forma.ColumnCount  = 2
        WITH loc_oPg.grd_4c_Forma
            .Top           = 221
            .Left          = 122
            .Width         = 228
            .Height        = 181
            .FontName      = "Tahoma"
            .AllowRowSizing = .F.
            .DeleteMark    = .F.
            .GridLines     = 3
            .GridLineColor = RGB(238, 238, 238)
            .HeaderHeight  = 18
            .RowHeight     = 18
            .ScrollBars    = 2
            .RecordMark    = .F.
            .Themes        = .F.

            .Visible       = .T.

            WITH .Column1
                .Width           = 15
                .Alignment       = 0
                .Sparse          = .F.
                .ReadOnly        = .F.
                .Header1.Caption = ""
                .AddObject("chk_4c_Marca", "CheckBox")
                WITH .chk_4c_Marca
                    .Alignment = 0
                    .Caption   = ""
                    .Height    = 17
                    .Visible   = .T.
                ENDWITH
                .CurrentControl = "chk_4c_Marca"
                .ControlSource  = "cursor_4c_OpFp.nMarca"
            ENDWITH

            WITH .Column2
                .Width         = 210
                .ControlSource = "cursor_4c_OpFp.fpags"
                .ReadOnly      = .T.
                .Header1.Caption = "Descrs"
                .AddObject("txt_4c_FpNome", "TextBox")
                WITH .txt_4c_FpNome
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                    .Visible     = .T.
                ENDWITH
                .CurrentControl = "txt_4c_FpNome"
            ENDWITH
        ENDWITH

        *-- === BOTOES MARCAR / DESMARCAR (Top_orig=348/392) ===

        *-- Botao Marcar/Selecionar (Command2 do legado - geral_marcar_26.jpg)
        loc_oPg.AddObject("cmd_4c_Marcar", "CommandButton")
        WITH loc_oPg.cmd_4c_Marcar
            .Top          = 263
            .Left         = 355
            .Height       = 45
            .Width        = 45
            .Caption      = ""
            .ToolTipText  = "Selecionar"
            .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .FontName     = "Verdana"
            .FontSize     = 8
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .TabStop      = .F.
            .Themes       = .F.
            .Visible      = .T.
        ENDWITH

        *-- Botao Desmarcar (Command1 do legado - cadastro_excluir_26.jpg)
        loc_oPg.AddObject("cmd_4c_Desmarcar", "CommandButton")
        WITH loc_oPg.cmd_4c_Desmarcar
            .Top          = 307
            .Left         = 355
            .Height       = 45
            .Width        = 45
            .Caption      = ""
            .ToolTipText  = "Desmarcar"
            .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .FontName     = "Verdana"
            .FontSize     = 8
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .TabStop      = .F.
            .Themes       = .F.
            .Visible      = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * VincularEventosFiltros - BINDEVENTs para campos de filtro com lookup
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularEventosFiltros()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Empresa
        BINDEVENT(loc_oPg.txt_4c_Empresa,    "KeyPress", THIS, "TeclaEmpresa")
        BINDEVENT(loc_oPg.txt_4c_Empresa,    "DblClick", THIS, "AbrirBuscaEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DesEmpresa, "KeyPress", THIS, "TeclaDesEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DesEmpresa, "DblClick", THIS, "AbrirBuscaDesEmpresa")

        *-- Grupo
        BINDEVENT(loc_oPg.txt_4c_CGru, "KeyPress", THIS, "TeclaCGru")
        BINDEVENT(loc_oPg.txt_4c_CGru, "DblClick", THIS, "AbrirBuscaCGru")
        BINDEVENT(loc_oPg.txt_4c_DGru, "KeyPress", THIS, "TeclaDGru")
        BINDEVENT(loc_oPg.txt_4c_DGru, "DblClick", THIS, "AbrirBuscaDGru")

        *-- Conta/Vendedor
        BINDEVENT(loc_oPg.txt_4c_Vend,  "KeyPress", THIS, "TeclaVend")
        BINDEVENT(loc_oPg.txt_4c_Vend,  "DblClick", THIS, "AbrirBuscaVend")
        BINDEVENT(loc_oPg.txt_4c_DVend, "KeyPress", THIS, "TeclaDVend")
        BINDEVENT(loc_oPg.txt_4c_DVend, "DblClick", THIS, "AbrirBuscaDVend")

        *-- Categoria
        BINDEVENT(loc_oPg.txt_4c_Cate,  "KeyPress", THIS, "TeclaCate")
        BINDEVENT(loc_oPg.txt_4c_Cate,  "DblClick", THIS, "AbrirBuscaCate")
        BINDEVENT(loc_oPg.txt_4c_CateD, "KeyPress", THIS, "TeclaCateD")
        BINDEVENT(loc_oPg.txt_4c_CateD, "DblClick", THIS, "AbrirBuscaCateD")

        *-- Colecao
        BINDEVENT(loc_oPg.txt_4c_Cole,  "KeyPress", THIS, "TeclaCole")
        BINDEVENT(loc_oPg.txt_4c_Cole,  "DblClick", THIS, "AbrirBuscaCole")
        BINDEVENT(loc_oPg.txt_4c_ColeD, "KeyPress", THIS, "TeclaColeD")
        BINDEVENT(loc_oPg.txt_4c_ColeD, "DblClick", THIS, "AbrirBuscaColeD")

        *-- Produto
        BINDEVENT(loc_oPg.txt_4c_Prod,  "KeyPress", THIS, "TeclaProd")
        BINDEVENT(loc_oPg.txt_4c_Prod,  "DblClick", THIS, "AbrirBuscaProd")
        BINDEVENT(loc_oPg.txt_4c_ProdD, "KeyPress", THIS, "TeclaProdD")
        BINDEVENT(loc_oPg.txt_4c_ProdD, "DblClick", THIS, "AbrirBuscaProdD")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFiltrosNaUI - Popula controles a partir dos valores iniciais do BO
    *   Chamado apos InicializarFiltros() para sincronizar UI com estado do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarFiltrosNaUI()
        LOCAL loc_oPg, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(.this_cEmpresa)
                loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(.this_cDesEmpresa)
                loc_oPg.txt_4c_DtInicial.Value  = .this_dDtInicial
                loc_oPg.txt_4c_DtFinal.Value    = .this_dDtFinal
                loc_oPg.txt_4c_CGru.Value       = ALLTRIM(.this_cCGru)
                loc_oPg.txt_4c_DGru.Value       = ALLTRIM(.this_cDGru)
                loc_oPg.txt_4c_Vend.Value       = ALLTRIM(.this_cVend)
                loc_oPg.txt_4c_DVend.Value      = ALLTRIM(.this_cDVend)
                loc_oPg.txt_4c_Cate.Value       = ALLTRIM(.this_cCate)
                loc_oPg.txt_4c_CateD.Value      = ALLTRIM(.this_cCateD)
                loc_oPg.txt_4c_Cole.Value       = ALLTRIM(.this_cCole)
                loc_oPg.txt_4c_ColeD.Value      = ALLTRIM(.this_cColeD)
                loc_oPg.txt_4c_Prod.Value       = ALLTRIM(.this_cProd)
                loc_oPg.txt_4c_ProdD.Value      = ALLTRIM(.this_cProdD)
                loc_oPg.opt_4c_Tipo.Value       = .this_nOpcao
                loc_oPg.chk_4c_Desc.Value       = .this_nDesc
                loc_oPg.chk_4c_Lanc.Value       = .this_nLanc
            ENDWITH

            *-- Se empresa ainda sem descricao, buscar descricao
            IF EMPTY(ALLTRIM(loc_oPg.txt_4c_DesEmpresa.Value)) AND ;
               !EMPTY(ALLTRIM(loc_oPg.txt_4c_Empresa.Value))
                THIS.ValidarEmpresa()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cEmpresa    = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
            .this_cDesEmpresa = ALLTRIM(loc_oPg.txt_4c_DesEmpresa.Value)
            .this_dDtInicial  = IIF(VARTYPE(loc_oPg.txt_4c_DtInicial.Value) = "D", ;
                                    loc_oPg.txt_4c_DtInicial.Value, DATE())
            .this_dDtFinal    = IIF(VARTYPE(loc_oPg.txt_4c_DtFinal.Value) = "D", ;
                                    loc_oPg.txt_4c_DtFinal.Value, DATE())
            .this_cCGru       = ALLTRIM(loc_oPg.txt_4c_CGru.Value)
            .this_cDGru       = ALLTRIM(loc_oPg.txt_4c_DGru.Value)
            .this_cVend       = ALLTRIM(loc_oPg.txt_4c_Vend.Value)
            .this_cDVend      = ALLTRIM(loc_oPg.txt_4c_DVend.Value)
            .this_cCate       = ALLTRIM(loc_oPg.txt_4c_Cate.Value)
            .this_cCateD      = ALLTRIM(loc_oPg.txt_4c_CateD.Value)
            .this_cCole       = ALLTRIM(loc_oPg.txt_4c_Cole.Value)
            .this_cColeD      = ALLTRIM(loc_oPg.txt_4c_ColeD.Value)
            .this_cProd       = ALLTRIM(loc_oPg.txt_4c_Prod.Value)
            .this_cProdD      = ALLTRIM(loc_oPg.txt_4c_ProdD.Value)
            .this_nOpcao      = loc_oPg.opt_4c_Tipo.Value
            .this_nDesc       = loc_oPg.chk_4c_Desc.Value
            .this_nLanc       = loc_oPg.chk_4c_Lanc.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padrao (vazios)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_Empresa.Value    = go_4c_Sistema.cCodEmpresa
            loc_oPg.txt_4c_DesEmpresa.Value = ""
            loc_oPg.txt_4c_DtInicial.Value  = THIS.this_oRelatorio.this_dDtInicial
            loc_oPg.txt_4c_DtFinal.Value    = THIS.this_oRelatorio.this_dDtFinal
            loc_oPg.txt_4c_CGru.Value       = ""
            loc_oPg.txt_4c_DGru.Value       = ""
            loc_oPg.txt_4c_Vend.Value       = ""
            loc_oPg.txt_4c_DVend.Value      = ""
            loc_oPg.txt_4c_Cate.Value       = ""
            loc_oPg.txt_4c_CateD.Value      = ""
            loc_oPg.txt_4c_Cole.Value       = ""
            loc_oPg.txt_4c_ColeD.Value      = ""
            loc_oPg.txt_4c_Prod.Value       = ""
            loc_oPg.txt_4c_ProdD.Value      = ""
            loc_oPg.opt_4c_Tipo.Value       = 1
            loc_oPg.chk_4c_Desc.Value       = 0
            loc_oPg.chk_4c_Lanc.Value       = 0
            THIS.ValidarEmpresa()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ACOES DOS BOTOES DO RELATORIO
    *==========================================================================

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            IF THIS.this_oRelatorio.Visualizar()
                THIS.this_oRelatorio.RegistrarAuditoria("VISUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnImprimirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            IF THIS.this_oRelatorio.Imprimir()
                THIS.this_oRelatorio.RegistrarAuditoria("IMPRIMIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcelClick()
        LOCAL loc_lSucesso, loc_cArq
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            IF THIS.this_oRelatorio.PrepararDados()
                loc_cArq = SYS(2023) + "\sigredes_" + ;
                    STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                IF USED("csRelatorio")
                    SELECT csRelatorio
                    GO TOP
                    COPY TO (loc_cArq) TYPE XLS
                    IF FILE(loc_cArq)
                        DECLARE INTEGER ShellExecute IN SHELL32.DLL ;
                            INTEGER hWnd, STRING lpOperation, ;
                            STRING lpFile, STRING lpParameters, ;
                            STRING lpDirectory, INTEGER nShowCmd
                        ShellExecute(0, "open", loc_cArq, "", "", 1)
                    ENDIF
                    THIS.this_oRelatorio.RegistrarAuditoria("EXCEL")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarClick - Marca todas as formas de pagamento no grid
    *--------------------------------------------------------------------------
    PROCEDURE MarcarClick()
        TRY
            IF USED("cursor_4c_OpFp")
                SELECT cursor_4c_OpFp
                GO TOP
                SCAN
                    REPLACE nMarca WITH 1
                ENDSCAN
                GO TOP
                THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarClick - Desmarca todas as formas de pagamento no grid
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarClick()
        TRY
            IF USED("cursor_4c_OpFp")
                SELECT cursor_4c_OpFp
                GO TOP
                SCAN
                    REPLACE nMarca WITH 0
                ENDSCAN
                GO TOP
                THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO (PUBLIC - contrato BINDEVENT)
    * F4=115, ENTER=13, TAB=9, ESC=27
    *==========================================================================

    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value    = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_DesEmpresa.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE TeclaDesEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDesEmpresa()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value    = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_DesEmpresa.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE TeclaCGru(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCGru()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCGru()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_CGru.Value = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_DGru.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE TeclaDGru(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDGru()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_CGru.Value = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_DGru.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE TeclaVend(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaVend()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarVend()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_Vend.Value  = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_DVend.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE TeclaDVend(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDVend()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_Vend.Value  = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_DVend.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE TeclaCate(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCate()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCate()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_Cate.Value  = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_CateD.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE TeclaCateD(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCateD()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_Cate.Value  = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_CateD.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE TeclaCole(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCole()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCole()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_Cole.Value  = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_ColeD.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE TeclaColeD(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaColeD()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_Cole.Value  = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_ColeD.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE TeclaProd(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaProd()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarProd()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_Prod.Value  = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_ProdD.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE TeclaProdD(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaProdD()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_Prod.Value  = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_ProdD.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDACAO (ENTER/TAB em campo de codigo)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Busca empresa pelo codigo (SigCdEmp.cEmps)
    *   Replica getEmpresa.Valid do original: fAcessoEmpresa modo 'C'
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarEmpresa()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
        IF EMPTY(loc_cCodigo)
            loc_oPg.txt_4c_DesEmpresa.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 Emps, Razas FROM SigCdEmp WHERE Emps = " + ;
                   EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal
            IF !EOF()
                loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(Emps)
                loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(Razas)
            ELSE
                THIS.AbrirBuscaEmpresa()
            ENDIF
            USE IN cursor_4c_EmpVal
        ELSE
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCGru - Busca grupo pelo codigo (SigCdGcr.codigos)
    *   Replica getCGru.Valid do original: fAcessoContab modo 'C'
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCGru()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_CGru.Value)
        IF EMPTY(loc_cCodigo)
            loc_oPg.txt_4c_DGru.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                   EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GruVal
            IF !EOF()
                loc_oPg.txt_4c_CGru.Value = ALLTRIM(codigos)
                loc_oPg.txt_4c_DGru.Value = ALLTRIM(descrs)
            ELSE
                THIS.AbrirBuscaCGru()
            ENDIF
            USE IN cursor_4c_GruVal
        ELSE
            THIS.AbrirBuscaCGru()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarVend - Busca vendedor/conta pelo codigo (SigCdCli.IClis)
    *   Replica get_vend.Valid do original: fAcessoContas modo 'C'
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarVend()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Vend.Value)
        IF EMPTY(loc_cCodigo)
            loc_oPg.txt_4c_DVend.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                   EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VendVal")
        IF loc_nResult > 0
            SELECT cursor_4c_VendVal
            IF !EOF()
                loc_oPg.txt_4c_Vend.Value  = ALLTRIM(IClis)
                loc_oPg.txt_4c_DVend.Value = ALLTRIM(RClis)
            ELSE
                THIS.AbrirBuscaVend()
            ENDIF
            USE IN cursor_4c_VendVal
        ELSE
            THIS.AbrirBuscaVend()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCate - Busca categoria pelo codigo (SigCdCol.codigos)
    *   Replica getCate.Valid do original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCate()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Cate.Value)
        IF EMPTY(loc_cCodigo)
            loc_oPg.txt_4c_CateD.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT codigos, descrs FROM SigCdCol WHERE codigos = " + ;
                   EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CateVal")
        IF loc_nResult > 0
            SELECT cursor_4c_CateVal
            IF !EOF()
                loc_oPg.txt_4c_Cate.Value  = ALLTRIM(codigos)
                loc_oPg.txt_4c_CateD.Value = ALLTRIM(descrs)
            ELSE
                THIS.AbrirBuscaCate()
            ENDIF
            USE IN cursor_4c_CateVal
        ELSE
            THIS.AbrirBuscaCate()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCole - Busca colecao pelo codigo (SigCdPsg.codigos)
    *   Replica GetCole.Valid do original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCole()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Cole.Value)
        IF EMPTY(loc_cCodigo)
            loc_oPg.txt_4c_ColeD.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT codigos, descricaos FROM SigCdPsg WHERE codigos = " + ;
                   EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ColeVal")
        IF loc_nResult > 0
            SELECT cursor_4c_ColeVal
            IF !EOF()
                loc_oPg.txt_4c_Cole.Value  = ALLTRIM(codigos)
                loc_oPg.txt_4c_ColeD.Value = ALLTRIM(descricaos)
            ELSE
                THIS.AbrirBuscaCole()
            ENDIF
            USE IN cursor_4c_ColeVal
        ELSE
            THIS.AbrirBuscaCole()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarProd - Busca produto pelo codigo (SigCdPro.CPros)
    *   Replica getProd.Valid do original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarProd()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Prod.Value)
        IF EMPTY(loc_cCodigo)
            loc_oPg.txt_4c_ProdD.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + ;
                   EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdVal")
        IF loc_nResult > 0
            SELECT cursor_4c_ProdVal
            IF !EOF()
                loc_oPg.txt_4c_Prod.Value  = ALLTRIM(CPros)
                loc_oPg.txt_4c_ProdD.Value = ALLTRIM(DPros)
            ELSE
                THIS.AbrirBuscaProd()
            ENDIF
            USE IN cursor_4c_ProdVal
        ELSE
            THIS.AbrirBuscaProd()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS FormBuscaAuxiliar (PUBLIC - contrato BINDEVENT DblClick)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - Lookup de empresa pelo codigo (SigCdEmp.cEmps)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "cEmps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmp.cEmps)
                loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cEmps", "XXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmp.cEmps)
                        loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ELSE
                        loc_oPg.txt_4c_Empresa.Value    = ""
                        loc_oPg.txt_4c_DesEmpresa.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDesEmpresa - Lookup de empresa pelo nome (SigCdEmp.Razas)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDesEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DesEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Razas", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmp.cEmps)
                loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("cEmps", "XXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_BuscaEmp.cEmps)
                        loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ELSE
                        loc_oPg.txt_4c_Empresa.Value    = ""
                        loc_oPg.txt_4c_DesEmpresa.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCGru - Lookup de grupo pelo codigo (SigCdGcr.codigos)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCGru()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CGru.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGru", "codigos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CGru.Value = ALLTRIM(cursor_4c_BuscaGru.codigos)
                loc_oPg.txt_4c_DGru.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
                        loc_oPg.txt_4c_CGru.Value = ALLTRIM(cursor_4c_BuscaGru.codigos)
                        loc_oPg.txt_4c_DGru.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
                    ELSE
                        loc_oPg.txt_4c_CGru.Value = ""
                        loc_oPg.txt_4c_DGru.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGru")
            USE IN cursor_4c_BuscaGru
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDGru - Lookup de grupo pela descricao (SigCdGcr.descrs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDGru()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DGru.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGru", "descrs", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CGru.Value = ALLTRIM(cursor_4c_BuscaGru.codigos)
                loc_oPg.txt_4c_DGru.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
                        loc_oPg.txt_4c_CGru.Value = ALLTRIM(cursor_4c_BuscaGru.codigos)
                        loc_oPg.txt_4c_DGru.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
                    ELSE
                        loc_oPg.txt_4c_CGru.Value = ""
                        loc_oPg.txt_4c_DGru.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGru")
            USE IN cursor_4c_BuscaGru
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaVend - Lookup de vendedor/conta pelo codigo (SigCdCli.IClis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaVend()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Vend.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaVend", "IClis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Vend.Value  = ALLTRIM(cursor_4c_BuscaVend.IClis)
                loc_oPg.txt_4c_DVend.Value = ALLTRIM(cursor_4c_BuscaVend.RClis)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("RClis", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVend")
                        loc_oPg.txt_4c_Vend.Value  = ALLTRIM(cursor_4c_BuscaVend.IClis)
                        loc_oPg.txt_4c_DVend.Value = ALLTRIM(cursor_4c_BuscaVend.RClis)
                    ELSE
                        loc_oPg.txt_4c_Vend.Value  = ""
                        loc_oPg.txt_4c_DVend.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaVend")
            USE IN cursor_4c_BuscaVend
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDVend - Lookup de vendedor/conta pelo nome (SigCdCli.RClis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDVend()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DVend.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaVend", "RClis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Vend.Value  = ALLTRIM(cursor_4c_BuscaVend.IClis)
                loc_oPg.txt_4c_DVend.Value = ALLTRIM(cursor_4c_BuscaVend.RClis)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("RClis", "", "Nome")
                    loc_oBusca.mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVend")
                        loc_oPg.txt_4c_Vend.Value  = ALLTRIM(cursor_4c_BuscaVend.IClis)
                        loc_oPg.txt_4c_DVend.Value = ALLTRIM(cursor_4c_BuscaVend.RClis)
                    ELSE
                        loc_oPg.txt_4c_Vend.Value  = ""
                        loc_oPg.txt_4c_DVend.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaVend")
            USE IN cursor_4c_BuscaVend
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCate - Lookup de categoria pelo codigo (SigCdCol.codigos)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCate()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Cate.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCol", "cursor_4c_BuscaCate", "codigos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Categoria", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Cate.Value  = ALLTRIM(cursor_4c_BuscaCate.codigos)
                loc_oPg.txt_4c_CateD.Value = ALLTRIM(cursor_4c_BuscaCate.descrs)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCate")
                        loc_oPg.txt_4c_Cate.Value  = ALLTRIM(cursor_4c_BuscaCate.codigos)
                        loc_oPg.txt_4c_CateD.Value = ALLTRIM(cursor_4c_BuscaCate.descrs)
                    ELSE
                        loc_oPg.txt_4c_Cate.Value  = ""
                        loc_oPg.txt_4c_CateD.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaCate")
            USE IN cursor_4c_BuscaCate
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCateD - Lookup de categoria pela descricao (SigCdCol.descrs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCateD()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CateD.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCol", "cursor_4c_BuscaCate", "descrs", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Categoria", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Cate.Value  = ALLTRIM(cursor_4c_BuscaCate.codigos)
                loc_oPg.txt_4c_CateD.Value = ALLTRIM(cursor_4c_BuscaCate.descrs)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCate")
                        loc_oPg.txt_4c_Cate.Value  = ALLTRIM(cursor_4c_BuscaCate.codigos)
                        loc_oPg.txt_4c_CateD.Value = ALLTRIM(cursor_4c_BuscaCate.descrs)
                    ELSE
                        loc_oPg.txt_4c_Cate.Value  = ""
                        loc_oPg.txt_4c_CateD.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaCate")
            USE IN cursor_4c_BuscaCate
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCole - Lookup de colecao pelo codigo (SigCdPsg.codigos)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCole()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Cole.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPsg", "cursor_4c_BuscaCole", "codigos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Cole" + CHR(231) + CHR(227) + "o", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Cole.Value  = ALLTRIM(cursor_4c_BuscaCole.codigos)
                loc_oPg.txt_4c_ColeD.Value = ALLTRIM(cursor_4c_BuscaCole.descricaos)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCole")
                        loc_oPg.txt_4c_Cole.Value  = ALLTRIM(cursor_4c_BuscaCole.codigos)
                        loc_oPg.txt_4c_ColeD.Value = ALLTRIM(cursor_4c_BuscaCole.descricaos)
                    ELSE
                        loc_oPg.txt_4c_Cole.Value  = ""
                        loc_oPg.txt_4c_ColeD.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaCole")
            USE IN cursor_4c_BuscaCole
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaColeD - Lookup de colecao pela descricao (SigCdPsg.descricaos)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaColeD()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_ColeD.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPsg", "cursor_4c_BuscaCole", "descricaos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Cole" + CHR(231) + CHR(227) + "o", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Cole.Value  = ALLTRIM(cursor_4c_BuscaCole.codigos)
                loc_oPg.txt_4c_ColeD.Value = ALLTRIM(cursor_4c_BuscaCole.descricaos)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCole")
                        loc_oPg.txt_4c_Cole.Value  = ALLTRIM(cursor_4c_BuscaCole.codigos)
                        loc_oPg.txt_4c_ColeD.Value = ALLTRIM(cursor_4c_BuscaCole.descricaos)
                    ELSE
                        loc_oPg.txt_4c_Cole.Value  = ""
                        loc_oPg.txt_4c_ColeD.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaCole")
            USE IN cursor_4c_BuscaCole
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaProd - Lookup de produto pelo codigo (SigCdPro.CPros)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaProd()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Prod.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaProd", "CPros", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Produto", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Prod.Value  = ALLTRIM(cursor_4c_BuscaProd.CPros)
                loc_oPg.txt_4c_ProdD.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CPros", "XXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
                        loc_oPg.txt_4c_Prod.Value  = ALLTRIM(cursor_4c_BuscaProd.CPros)
                        loc_oPg.txt_4c_ProdD.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
                    ELSE
                        loc_oPg.txt_4c_Prod.Value  = ""
                        loc_oPg.txt_4c_ProdD.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaProd")
            USE IN cursor_4c_BuscaProd
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaProdD - Lookup de produto pela descricao (SigCdPro.DPros)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaProdD()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_ProdD.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaProd", "DPros", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Produto", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Prod.Value  = ALLTRIM(cursor_4c_BuscaProd.CPros)
                loc_oPg.txt_4c_ProdD.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CPros", "XXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
                        loc_oPg.txt_4c_Prod.Value  = ALLTRIM(cursor_4c_BuscaProd.CPros)
                        loc_oPg.txt_4c_ProdD.Value = ALLTRIM(cursor_4c_BuscaProd.DPros)
                    ELSE
                        loc_oPg.txt_4c_Prod.Value  = ""
                        loc_oPg.txt_4c_ProdD.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaProd")
            USE IN cursor_4c_BuscaProd
        ENDIF
    ENDPROC

    *==========================================================================
    * ALIASES CRUD -> REPORT (compatibilidade com pipeline de migracao)
    *==========================================================================

    *--------------------------------------------------------------------------
    * Wrappers CRUD de compatibilidade do pipeline (FormSIGREDES eh REPORT).
    * O form expoe 4 botoes de relatorio (Visualizar/Imprimir/Excel/Sair) via
    * cmg_4c_Botoes; esses handlers existem apenas para que validadores
    * generic-CRUD encontrem os nomes esperados.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        MsgInfo("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
            CHR(237) + "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgInfo("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
            CHR(237) + "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia valores do BO para os controles do formulario.
    *   Em FormSIGREDES (REPORT), delega para CarregarFiltrosNaUI().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        THIS.CarregarFiltrosNaUI()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos editaveis.
    *   Em FormSIGREDES (REPORT), todos os campos de filtro sao sempre editaveis.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_Empresa.ReadOnly   = .F.
            loc_oPg.txt_4c_DtInicial.ReadOnly = .F.
            loc_oPg.txt_4c_DtFinal.ReadOnly   = .F.
            loc_oPg.txt_4c_CGru.ReadOnly      = .F.
            loc_oPg.txt_4c_Vend.ReadOnly      = .F.
            loc_oPg.txt_4c_Cate.ReadOnly      = .F.
            loc_oPg.txt_4c_Cole.ReadOnly      = .F.
            loc_oPg.txt_4c_Prod.ReadOnly      = .F.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em FormSIGREDES (REPORT), recarrega o cursor de formas
    *   de pagamento no grid quando necessario.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF USED("cursor_4c_OpFp")
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.ColumnCount = 2
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.RecordSource = "cursor_4c_OpFp"
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Column1.ControlSource = "cursor_4c_OpFp.nMarca"
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Column2.ControlSource = "cursor_4c_OpFp.fpags"
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Refresh()
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em FormSIGREDES (REPORT), os botoes de relatorio
    *   (Visualizar/Imprimir/Excel/Encerrar) ficam sempre habilitados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Em FormSIGREDES (REPORT) so existe a Page1 (Filtros),
    *   logo qualquer valor de par_nPagina mapeia para Page1. O metodo permanece
    *   compativel com a interface CRUD usada pelo FormBase/pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        TRY
            THIS.pgf_4c_Paginas.ActivePage = 1
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos do BO e cursores temporarios
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(5), loc_nI
        loc_aCursores(1) = "cursor_4c_BuscaEmp"
        loc_aCursores(2) = "cursor_4c_BuscaGru"
        loc_aCursores(3) = "cursor_4c_BuscaVend"
        loc_aCursores(4) = "cursor_4c_BuscaCate"
        loc_aCursores(5) = "cursor_4c_BuscaCole"
        FOR loc_nI = 1 TO 5
            IF USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR
        IF USED("cursor_4c_BuscaProd")
            USE IN cursor_4c_BuscaProd
        ENDIF
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGREDESBO.prg):
*==============================================================================
* SIGREDESBO.PRG
* Business Object para Relatorio de Cotas de Desconto (SIGREDES)
* Herda de RelatorioBase
*
* Tabelas principais: SigMvCab, SigMvItn, SigMvItd, sigcddes
* Relatorios FRX: SigReDes.frx (Detalhado), SigReDe1.frx (Resumido)
*
* Filtros:
*   - Empresa    (codigo + descricao)
*   - Periodo    (data inicial / data final)
*   - Grupo      (codigo + descricao - campo Grupos de SigCdCli)
*   - Vendedor   (codigo + descricao - campo Vends/IClis de SigMvCab/SigCdCli)
*   - Categoria  (codigo + descricao - campo colecoes de SigcdPro / SigCdCol)
*   - Colecao    (codigo + descricao - campo sgrus de SigcdPro / SigCdPsg)
*   - Produto    (codigo + descricao - campo CPros de SigCdPro)
*   - Com desconto (0=todos, 1=somente com desconto)
*   - Lancamento   (0=todos, 1=somente lancamentos novos)
*   - Tipo visao   (1=Detalhado, 2=Resumido)
*==============================================================================

DEFINE CLASS SIGREDESBO AS RelatorioBase

    *-- Filtro: empresa
    this_cEmpresa       = ""
    this_cDesEmpresa    = ""

    *-- Filtro: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro: grupo (campo Grupos de SigCdCli)
    this_cCGru          = ""
    this_cDGru          = ""

    *-- Filtro: vendedor (campo Vends de SigMvCab / IClis de SigCdCli)
    this_cVend          = ""
    this_cDVend         = ""

    *-- Filtro: categoria (campo colecoes de SigcdPro; lookup SigCdCol: colecoes/descs)
    this_cCate          = ""
    this_cCateD         = ""

    *-- Filtro: colecao (campo sgrus de SigcdPro; lookup SigCdPsg: codigos/descricaos)
    this_cCole          = ""
    this_cColeD         = ""

    *-- Filtro: produto (campo CPros de SigCdPro; lookup SigCdPro: CPros/DPros)
    this_cProd          = ""
    this_cProdD         = ""

    *-- Tipo de visao: 1=Detalhado (SigReDes.frx), 2=Resumido (SigReDe1.frx)
    this_nOpcao         = 1

    *-- Filtro com desconto: 0=todos, 1=somente itens com desconto (chaitd preenchido)
    this_nDesc          = 0

    *-- Filtro lancamento: 0=todos, 1=somente lancamentos (dtincs do produto < 61 dias)
    this_nLanc          = 0

    *-- Cursores gerenciados pelo BO
    this_cCursorDados      = "cursor_4c_Dados"
    this_cCursorRelatorio  = "cursor_4c_Relatorio"
    this_cCursorOpFp       = "cursor_4c_OpFp"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de Cotas de Desconto
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Inicializa filtros com valores padrao e carrega
    * formas de pagamento disponiveis em cursor_4c_OpFp (ReadWrite para que o
    * grid do form permita marcar/desmarcar via CheckBox).
    * Equivalente ao bloco de Init() do form legado SIGREDES.
    * Chamado pelo form em InicializarForm().
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_dPrimeiro, loc_dUltimo
        loc_lSucesso = .F.
        TRY
            *-- Primeiro e ultimo dia do mes corrente
            loc_dPrimeiro = DATE() - DAY(DATE()) + 1
            loc_dUltimo   = GOMONTH(loc_dPrimeiro, 1) - 1

            THIS.this_dDtInicial  = loc_dPrimeiro
            THIS.this_dDtFinal    = loc_dUltimo
            THIS.this_cEmpresa    = go_4c_Sistema.cCodEmpresa
            THIS.this_cDesEmpresa = ""
            THIS.this_cVend       = ""
            THIS.this_cDVend      = ""
            THIS.this_cCGru       = ""
            THIS.this_cDGru       = ""
            THIS.this_cCate       = ""
            THIS.this_cCateD      = ""
            THIS.this_cCole       = ""
            THIS.this_cColeD      = ""
            THIS.this_cProd       = ""
            THIS.this_cProdD      = ""
            THIS.this_nOpcao      = 1
            THIS.this_nDesc       = 0
            THIS.this_nLanc       = 0

            *-- Carregar formas de pagamento disponiveis (SigOpFp)
            *-- Cursor precisa ser ReadWrite: usuario marca/desmarca via grid
            IF USED(THIS.this_cCursorOpFp)
                USE IN (THIS.this_cCursorOpFp)
            ENDIF
            IF USED("cursor_4c_OpFp_tmp")
                USE IN cursor_4c_OpFp_tmp
            ENDIF

            loc_cSQL = "SELECT CAST(0 AS INT) AS nMarca, fpags FROM SigOpFp ORDER BY fpags"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpFp_tmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar formas de pagamento (SigOpFp)"
            ELSE
                SELECT * FROM cursor_4c_OpFp_tmp INTO CURSOR (THIS.this_cCursorOpFp) READWRITE
                USE IN cursor_4c_OpFp_tmp
                SELECT (THIS.this_cCursorOpFp)
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio de Cotas de Desconto
    * Equivalente ao procedimento "processamento" do legado SIGREDES.SCX
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lContinuar
        LOCAL loc_lcGru, loc_lcVend, loc_lcEmp, loc_lcCole, loc_lcCate, loc_lcProd
        LOCAL loc_cheVen, loc_cheCole, loc_cheCate, loc_cheProd, loc_cheFP
        LOCAL loc_lcQuery, loc_nResult
        LOCAL loc_lcCbEmp, loc_lcCbTitulo, loc_lcCbPeriodo
        LOCAL loc_lcChaAnt, loc_ldDatM, loc_ldDatP, loc_lnValRel, loc_lnAlt
        LOCAL loc_lcPdes, loc_lcVdes, loc_lnOpt, loc_lnDesc, loc_lnLanc
        LOCAL loc_cOpFpAlias, loc_nVdestot
        LOCAL loc_aCursFech(11), loc_nFech
        PRIVATE pDtI, pDtF, pDtH

        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            *-- Extrair valores dos filtros do BO
            loc_lcGru  = ALLTRIM(THIS.this_cCGru)
            loc_lcVend = ALLTRIM(THIS.this_cVend)
            loc_lcEmp  = ALLTRIM(THIS.this_cEmpresa)
            loc_lcCole = ALLTRIM(THIS.this_cCole)
            loc_lcCate = ALLTRIM(THIS.this_cCate)
            loc_lcProd = ALLTRIM(THIS.this_cProd)
            loc_lnOpt  = THIS.this_nOpcao
            loc_lnDesc = THIS.this_nDesc
            loc_lnLanc = THIS.this_nLanc

            *-- Parametros de data para SQLEXEC binding (?pDtI / ?pDtF / ?pDtH)
            pDtI = DTOT(THIS.this_dDtInicial)
            pDtF = DTOT(THIS.this_dDtFinal) + 86399
            pDtH = DTOT(DATE()) + 86399

            *-- Filtro vendedor
            IF EMPTY(loc_lcVend)
                loc_cheVen = ""
            ELSE
                loc_cheVen = " and a.vends = '" + loc_lcVend + "' "
            ENDIF

            *-- Filtro colecao
            IF EMPTY(loc_lcCole)
                loc_cheCole = ""
            ELSE
                loc_cheCole = " and p.sgrus = '" + loc_lcCole + "' "
            ENDIF

            *-- Filtro categoria
            IF EMPTY(loc_lcCate)
                loc_cheCate = ""
            ELSE
                loc_cheCate = " and p.colecoes = '" + loc_lcCate + "' "
            ENDIF

            *-- Filtro produto
            IF EMPTY(loc_lcProd)
                loc_cheProd = ""
            ELSE
                loc_cheProd = " and b.cpros = '" + loc_lcProd + "' "
            ENDIF

            *-- Filtro formas de pagamento (marcadas no grid)
            loc_cheFP      = ""
            loc_cOpFpAlias = THIS.this_cCursorOpFp
            IF USED(loc_cOpFpAlias)
                SELECT nMarca, fpags FROM (loc_cOpFpAlias) WHERE nMarca = 1 ;
                    INTO CURSOR cursor_4c_FpSel
                GO TOP
                IF !EOF()
                    loc_cheFP = " and e.fpags in ('"
                    SCAN
                        loc_cheFP = loc_cheFP + ALLTRIM(fpags) + "','"
                    ENDSCAN
                    loc_cheFP = LEFT(loc_cheFP, LEN(loc_cheFP) - 2) + ") "
                ENDIF
                IF USED("cursor_4c_FpSel")
                    USE IN cursor_4c_FpSel
                ENDIF
            ENDIF

            *-- Titulo para cabecalho do relatorio
            loc_lcCbEmp = "VENDAS"
            IF !EMPTY(loc_lcGru)
                loc_lcCbEmp = loc_lcCbEmp + " (" + ALLTRIM(loc_lcGru) + ")"
            ENDIF

            *-- Fechar cursores de execucao anterior
            loc_aCursFech(1)  = "csDados"
            loc_aCursFech(2)  = "csDados1"
            loc_aCursFech(3)  = "csDados_tmp"
            loc_aCursFech(4)  = "csRelatorio"
            loc_aCursFech(5)  = "csTmpRel"
            loc_aCursFech(6)  = "csCabecalho"
            loc_aCursFech(7)  = "crProd"
            loc_aCursFech(8)  = "crMvPar"
            loc_aCursFech(9)  = "crAux"
            loc_aCursFech(10) = "crAux1"
            loc_aCursFech(11) = "crAux2"
            FOR loc_nFech = 1 TO 11
                IF USED(loc_aCursFech(loc_nFech))
                    USE IN (loc_aCursFech(loc_nFech))
                ENDIF
            ENDFOR
            IF USED("cursor_4c_FpSel")
                USE IN cursor_4c_FpSel
            ENDIF

            *-- Query principal: cabecalho x itens x descontos (SQL Server)
            loc_lcQuery = ;
                "Select a.datars, a.Emps, a.Dopes, a.Numes, " + ;
                "b.CPros, b.dpros, b.qtds, b.units, b.unitorigs, b.totas, b.opers, " + ;
                "c.rclis as repre, " + ;
                "case when co.descricaos is null then 'sem subgrupo' " + ;
                "  else co.descricaos end as colecao, " + ;
                "case when ca.descs is null then 'sem categoria' " + ;
                "  else ca.descs end as categoria, " + ;
                "a.empdopnums, a.cidchaves as chaCab, b.cidchaves as chaItn, " + ;
                "d.cidchaves as chaItd, SPACE(50) as formasP, '1' as imprime, " + ;
                "' ' as lancamento, d.ddesc, d.pdes, d.vdes, d.tpdesc, " + ;
                "d.codigo, e.valcota, round(unitorigs*qtds,2) as ValR, " + ;
                "CAST(0.00 as numeric(11,4)) as DescT, " + ;
                "CAST(0.00 as numeric(11,2)) as Realizado, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes01, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes01, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes02, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes02, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes03, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes03, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes04, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes04, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes05, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes05, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes06, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes06, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes07, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes07, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes08, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes08, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes09, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes09, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes10, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes10, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes11, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes11, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes12, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes12, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes13, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes13, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes14, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes14, " + ;
                "CAST(0.00 as numeric(11,4)) as vdestot " + ;
                "From SigMvCab a with(nolock) " + ;
                "left join SigCdCli c with(nolock) on c.IClis = a.Vends " + ;
                ", SigMvItn b with(nolock) " + ;
                "left join SigMvItd d with(nolock) " + ;
                "  on b.empdopnums = d.empdopnums " + ;
                "  and b.cpros = d.Cpros and b.citens = d.citens " + ;
                "left join sigcddes e with(nolock) on d.codigo = e.codigo, " + ;
                "SigCdOpe g with(nolock), " + ;
                "SigCdTom h with(nolock), SigcdPro p with(nolock) " + ;
                "left join SigCdPsg co with(nolock) " + ;
                "  on co.cgrus = p.cgrus and co.codigos = p.sgrus " + ;
                "left join SigCdCtg ca with(nolock) on ca.cods = p.categoria " + ;
                "Where a.datars BetWeen ?pDtI And ?pDtF And " + ;
                IIF(EMPTY(loc_lcGru), "", "c.Grupos = '" + loc_lcGru + "' And ") + ;
                IIF(EMPTY(loc_lcEmp), "", "a.Emps = '"   + loc_lcEmp + "' And ") + ;
                "b.cpros = p.cpros And " + ;
                "a.EmpDopNums = b.EmpDopNums and " + ;
                "a.dopes = g.dopes and " + ;
                "g.tipoops = h.codigos and " + ;
                "h.gergdmis = 1 and " + ;
                "g.tipoops <> 5 " + ;
                loc_cheCole + loc_cheCate + loc_cheVen + loc_cheProd + ;
                "order by a.cidchaves, b.cidchaves, d.cidchaves"

            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDados_tmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (csDados)"
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                SELECT * FROM csDados_tmp INTO CURSOR csDados READWRITE
                USE IN csDados_tmp
                SELECT csDados
                GO TOP

                *-- Query secundaria: cotas sigcddes nao cobertas pela query principal
                loc_lcQuery = "SELECT * FROM sigcddes WITH(NOLOCK)" + ;
                    " WHERE dtini >= ?pDtI And dtfin <= ?pDtF" + ;
                    IIF(EMPTY(loc_lcEmp), "", " and Emps = '" + loc_lcEmp + "'")
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDados1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (csDados1)"
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Append de cotas sem venda no periodo
                SELECT * FROM csDados1 ;
                    WHERE emps NOT IN (SELECT emps FROM csDados) ;
                    INTO CURSOR csDados1
                SELECT csDados1
                GO TOP
                SCAN
                    SELECT csDados
                    APPEND BLANK
                    REPLACE emps    WITH csDados1.emps
                    REPLACE valcota WITH csDados1.valcota
                    REPLACE imprime WITH "1"
                ENDSCAN
                IF USED("csDados1")
                    USE IN csDados1
                ENDIF

                *-- Marcar linhas duplicadas e sinalizar lancamentos
                loc_lcChaAnt = "xxxxxxx"
                SELECT csDados
                GO TOP
                SCAN
                    IF ISNULL(csDados.chaitd) OR EMPTY(csDados.chaitd)
                        REPLACE chaitd WITH SPACE(20) IN csDados
                        REPLACE ddesc  WITH ""         IN csDados
                        REPLACE pdes   WITH 0.00       IN csDados
                        REPLACE vdes   WITH 0.00       IN csDados
                    ENDIF
                    IF csDados.chacab + csDados.chaitn + csDados.chaitd = loc_lcChaAnt
                        REPLACE imprime WITH "" IN csDados
                    ENDIF
                    loc_lcChaAnt = csDados.chacab + csDados.chaitn + csDados.chaitd

                    *-- Lancamento: produto lancado ha menos de 61 dias da data da venda
                    loc_lcQuery = "SELECT dtincs FROM sigcdpro WITH(NOLOCK) WHERE cpros = " + ;
                                  EscaparSQL(ALLTRIM(csDados.cpros))
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "crProd") >= 1
                        SELECT crProd
                        IF !EOF() AND !ISNULL(crProd.dtincs)
                            loc_ldDatM = TTOD(csDados.datars)
                            loc_ldDatP = TTOD(crProd.dtincs)
                            IF loc_ldDatM - loc_ldDatP < 61
                                REPLACE lancamento WITH "1" IN csDados
                            ENDIF
                        ENDIF
                        USE IN crProd
                    ENDIF
                    SELECT csDados
                ENDSCAN

                *-- Filtrar somente itens com desconto (chaitd preenchido)
                IF loc_lnDesc = 1
                    SELECT csDados
                    DELETE ALL FOR chaitd = SPACE(20)
                ENDIF

                *-- Filtrar somente produtos lancamento
                IF loc_lnLanc = 1
                    SELECT csDados
                    DELETE ALL FOR lancamento <> "1"
                ENDIF

                *-- Formas de pagamento de cada operacao
                SELECT csDados
                GO TOP
                SCAN
                    loc_lcQuery = "SELECT fpags FROM sigmvpar WITH(NOLOCK)" + ;
                        " WHERE empdopnums = " + ;
                        EscaparSQL(ALLTRIM(csDados.empdopnums)) + ;
                        " GROUP BY fpags"
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "crMvPar") >= 1
                        SELECT crMvPar
                        GO TOP
                        SCAN
                            REPLACE formasP WITH ALLTRIM(csDados.formasP) + ;
                                " " + ALLTRIM(crMvPar.fpags) IN csDados
                        ENDSCAN
                        USE IN crMvPar
                    ENDIF
                    SELECT csDados
                ENDSCAN

                *-- Cursor de trabalho: apenas registros a imprimir
                SELECT * FROM csDados WHERE imprime = "1" INTO CURSOR csRelatorio READWRITE

                *-- Preencher colunas de desconto (pdes01-pdes14) por tipo
                SELECT csRelatorio
                GO TOP
                SCAN
                    SELECT csDados
                    GO TOP
                    SCAN FOR csDados.chacab + csDados.chaitn + csDados.chaitd = ;
                             csRelatorio.chacab + csRelatorio.chaitn + csRelatorio.chaitd ;
                             AND NVL(csDados.tpdesc, 0) > 0
                        loc_lcPdes = "pDes" + PADL(ALLTRIM(STR(NVL(csDados.tpdesc, 1))), 2, "0")
                        loc_lcVdes = "vDes" + PADL(ALLTRIM(STR(NVL(csDados.tpdesc, 1))), 2, "0")
                        REPLACE &loc_lcPdes WITH csDados.pdes IN csRelatorio
                        REPLACE &loc_lcVdes WITH csDados.vdes IN csRelatorio
                    ENDSCAN
                    SELECT csRelatorio
                    loc_lnAlt = csRelatorio.pdes01 + csRelatorio.pdes02 + ;
                                csRelatorio.pdes03 + csRelatorio.pdes04 + ;
                                csRelatorio.pdes05 + csRelatorio.pdes06 + ;
                                csRelatorio.pdes07 + csRelatorio.pdes08 + ;
                                csRelatorio.pdes09 + csRelatorio.pdes10 + ;
                                csRelatorio.pdes11 + csRelatorio.pdes12 + ;
                                csRelatorio.pdes13 + csRelatorio.pdes14
                    REPLACE desct WITH IIF(csRelatorio.ValR = 0, 0, ;
                        ROUND((csRelatorio.ValR - csRelatorio.totas) / ;
                              NVL(csRelatorio.ValR, 1) * 100, 2)) ;
                        IN csRelatorio
                    loc_lnValRel = csRelatorio.vdes03 + csRelatorio.vdes04 + ;
                                   csRelatorio.vdes05 + csRelatorio.vdes06 + ;
                                   csRelatorio.vdes07 + csRelatorio.vdes08 + ;
                                   csRelatorio.vdes09 + csRelatorio.vdes10 + ;
                                   csRelatorio.vdes12 + csRelatorio.vdes13
                    REPLACE realizado WITH loc_lnValRel IN csRelatorio
                    loc_nVdestot = csRelatorio.vdes01 + csRelatorio.vdes02 + ;
                                   csRelatorio.vdes03 + csRelatorio.vdes04 + ;
                                   csRelatorio.vdes05 + csRelatorio.vdes06 + ;
                                   csRelatorio.vdes07 + csRelatorio.vdes08 + ;
                                   csRelatorio.vdes09 + csRelatorio.vdes10 + ;
                                   csRelatorio.vdes11 + csRelatorio.vdes12 + ;
                                   csRelatorio.vdes13 + csRelatorio.vdes14
                    REPLACE vdestot WITH loc_nVdestot IN csRelatorio
                ENDSCAN

                *-- Agrupa em csTmpRel
                IF loc_lnOpt = 1
                    *-- Detalhado: agrupa colapsando chaitd duplicados
                    SELECT datars, emps, dopes, numes, cpros, dpros, qtds, units, ;
                           unitorigs, totas, opers, repre, colecao, categoria, ;
                           empdopnums, chacab, chaitn, ;
                           MAX(chaitd) AS chaitd, formasp, imprime, lancamento, ;
                           MAX(ddesc) AS ddesc, SUM(pdes) AS pdes, SUM(vdes) AS vdes, ;
                           MAX(tpdesc) AS tpdesc, codigo, valcota, valr, desct, ;
                           realizado, ;
                           SUM(pdes01) AS pdes01, SUM(vdes01) AS vdes01, ;
                           SUM(pdes02) AS pdes02, SUM(vdes02) AS vdes02, ;
                           SUM(pdes03) AS pdes03, SUM(vdes03) AS vdes03, ;
                           SUM(pdes04) AS pdes04, SUM(vdes04) AS vdes04, ;
                           SUM(pdes05) AS pdes05, SUM(vdes05) AS vdes05, ;
                           SUM(pdes06) AS pdes06, SUM(vdes06) AS vdes06, ;
                           SUM(pdes07) AS pdes07, SUM(vdes07) AS vdes07, ;
                           SUM(pdes08) AS pdes08, SUM(vdes08) AS vdes08, ;
                           SUM(pdes09) AS pdes09, SUM(vdes09) AS vdes09, ;
                           SUM(pdes10) AS pdes10, SUM(vdes10) AS vdes10, ;
                           SUM(pdes11) AS pdes11, SUM(vdes11) AS vdes11, ;
                           SUM(pdes12) AS pdes12, SUM(vdes12) AS vdes12, ;
                           SUM(pdes13) AS pdes13, SUM(vdes13) AS vdes13, ;
                           SUM(pdes14) AS pdes14, SUM(vdes14) AS vdes14, ;
                           SUM(vdestot) AS vdestot ;
                           FROM csRelatorio ;
                           GROUP BY datars, emps, dopes, numes, cpros, dpros, qtds, ;
                                    units, unitorigs, totas, opers, repre, colecao, ;
                                    categoria, empdopnums, chacab, chaitn, formasp, ;
                                    imprime, lancamento, codigo, valcota, valr, ;
                                    desct, realizado ;
                           INTO CURSOR csTmpRel READWRITE
                ELSE
                    *-- Resumido: inclui chaitd no agrupamento
                    SELECT datars, emps, dopes, numes, cpros, dpros, qtds, units, ;
                           unitorigs, totas, opers, repre, colecao, categoria, ;
                           empdopnums, chacab, chaitn, chaitd, formasp, imprime, ;
                           lancamento, MAX(ddesc) AS ddesc, SUM(pdes) AS pdes, ;
                           SUM(vdes) AS vdes, MAX(tpdesc) AS tpdesc, codigo, ;
                           valcota, valr, desct, realizado, ;
                           SUM(pdes01) AS pdes01, SUM(vdes01) AS vdes01, ;
                           SUM(pdes02) AS pdes02, SUM(vdes02) AS vdes02, ;
                           SUM(pdes03) AS pdes03, SUM(vdes03) AS vdes03, ;
                           SUM(pdes04) AS pdes04, SUM(vdes04) AS vdes04, ;
                           SUM(pdes05) AS pdes05, SUM(vdes05) AS vdes05, ;
                           SUM(pdes06) AS pdes06, SUM(vdes06) AS vdes06, ;
                           SUM(pdes07) AS pdes07, SUM(vdes07) AS vdes07, ;
                           SUM(pdes08) AS pdes08, SUM(vdes08) AS vdes08, ;
                           SUM(pdes09) AS pdes09, SUM(vdes09) AS vdes09, ;
                           SUM(pdes10) AS pdes10, SUM(vdes10) AS vdes10, ;
                           SUM(pdes11) AS pdes11, SUM(vdes11) AS vdes11, ;
                           SUM(pdes12) AS pdes12, SUM(vdes12) AS vdes12, ;
                           SUM(pdes13) AS pdes13, SUM(vdes13) AS vdes13, ;
                           SUM(pdes14) AS pdes14, SUM(vdes14) AS vdes14, ;
                           SUM(vdestot) AS vdestot ;
                           FROM csRelatorio ;
                           GROUP BY datars, emps, dopes, numes, cpros, dpros, qtds, ;
                                    units, unitorigs, totas, opers, repre, colecao, ;
                                    categoria, empdopnums, chacab, chaitn, chaitd, ;
                                    formasp, imprime, lancamento, codigo, valcota, ;
                                    valr, desct, realizado ;
                           INTO CURSOR csTmpRel READWRITE
                ENDIF

                *-- Reconstruir csRelatorio a partir de csTmpRel
                ZAP IN csRelatorio
                SELECT * FROM csTmpRel INTO CURSOR csRelatorio READWRITE
                IF USED("csTmpRel")
                    USE IN csTmpRel
                ENDIF
                SELECT csRelatorio
                GO TOP

                *-- Visao Resumida: calculos de totais por empresa e vendedor
                IF loc_lnOpt <> 1
                    SELECT emps, SPACE(20) AS repre, MAX(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "1" AS tipo ;
                           FROM csRelatorio GROUP BY emps, codigo INTO CURSOR crAux2
                    SELECT emps, SPACE(20) AS repre, SUM(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "1" AS tipo ;
                           FROM crAux2 GROUP BY emps INTO CURSOR crAux2

                    SELECT emps, repre, MAX(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "2" AS tipo ;
                           FROM csRelatorio GROUP BY emps, repre, codigo ;
                           INTO CURSOR crAux1
                    SELECT emps, repre, MAX(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "2" AS tipo ;
                           FROM crAux1 GROUP BY emps, repre ;
                           INTO CURSOR crAux1 READWRITE
                    SELECT crAux1
                    DELETE ALL FOR EMPTY(repre)

                    SELECT * FROM crAux2 UNION (SELECT * FROM crAux1) INTO CURSOR crAux
                    SELECT emps, repre, valcota, ;
                           realizado AS realizadoV, ;
                           ROUND(realizado / NVL(valcota, 1) * 100, 2) AS realizadoP, ;
                           valcota - realizado AS saldoV, ;
                           ROUND((valcota - realizado) / NVL(valcota, 1) * 100, 2) AS saldoP, ;
                           tipo ;
                           FROM crAux INTO CURSOR csRelatorio ORDER BY 1
                    loc_lcCbTitulo = "Relatorio de cotas de Desconto - Resumido"
                ELSE
                    loc_lcCbTitulo = "Relatorio de cotas de Desconto - Detalhado"
                ENDIF

                *-- Cursor de cabecalho para o relatorio
                loc_lcCbPeriodo = "Per" + CHR(237) + "odo : " + ;
                    DTOC(THIS.this_dDtInicial) + " 00:00:00 - " + ;
                    DTOC(THIS.this_dDtFinal)   + " 23:59:59 "
                CREATE CURSOR csCabecalho (empresa c(240), titulo c(240), periodo c(80))
                INSERT INTO csCabecalho (empresa, titulo, periodo) ;
                    VALUES (loc_lcCbEmp, loc_lcCbTitulo, loc_lcCbPeriodo)

                SELECT csRelatorio
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Processa e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFRX
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOpcao = 1
                    loc_cFRX = gc_4c_CaminhoReports + "SigReDes"
                ELSE
                    loc_cFRX = gc_4c_CaminhoReports + "SigReDe1"
                ENDIF
                SELECT csRelatorio
                GO TOP
                REPORT FORM (loc_cFRX) PREVIEW
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Processa e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFRX
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOpcao = 1
                    loc_cFRX = gc_4c_CaminhoReports + "SigReDes"
                ELSE
                    loc_cFRX = gc_4c_CaminhoReports + "SigReDe1"
                ENDIF
                SELECT csRelatorio
                GO TOP
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtro a partir de um cursor
    * (snapshot de filtros - usado para reaproveitar filtros entre execucoes)
    * Equivalente a CarregarDoCursor de BOs CRUD, adaptado para relatorio.
    * par_cAliasCursor : nome do cursor com campos identicos as propriedades
    *                    de filtro do BO (cEmpresa, dDtInicial, etc.)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_aFields(1), loc_nFlds, loc_nI, loc_cFld
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF() OR BOF()
                THIS.this_cMensagemErro = "Cursor de filtros vazio"
                loc_lSucesso = .F.
            ENDIF

            *-- Mapear apenas os campos efetivamente presentes no cursor
            loc_nFlds = AFIELDS(loc_aFields, loc_cAlias)
            FOR loc_nI = 1 TO loc_nFlds
                loc_cFld = UPPER(ALLTRIM(loc_aFields(loc_nI, 1)))
                DO CASE
                    CASE loc_cFld == "CEMPRESA"
                        THIS.this_cEmpresa    = TratarNulo(EVALUATE(loc_cAlias + ".cEmpresa"),    "C")
                    CASE loc_cFld == "CDESEMPRESA"
                        THIS.this_cDesEmpresa = TratarNulo(EVALUATE(loc_cAlias + ".cDesEmpresa"), "C")
                    CASE loc_cFld == "DDTINICIAL"
                        THIS.this_dDtInicial  = TratarNulo(EVALUATE(loc_cAlias + ".dDtInicial"),  "D")
                    CASE loc_cFld == "DDTFINAL"
                        THIS.this_dDtFinal    = TratarNulo(EVALUATE(loc_cAlias + ".dDtFinal"),    "D")
                    CASE loc_cFld == "CCGRU"
                        THIS.this_cCGru       = TratarNulo(EVALUATE(loc_cAlias + ".cCGru"),       "C")
                    CASE loc_cFld == "CDGRU"
                        THIS.this_cDGru       = TratarNulo(EVALUATE(loc_cAlias + ".cDGru"),       "C")
                    CASE loc_cFld == "CVEND"
                        THIS.this_cVend       = TratarNulo(EVALUATE(loc_cAlias + ".cVend"),       "C")
                    CASE loc_cFld == "CDVEND"
                        THIS.this_cDVend      = TratarNulo(EVALUATE(loc_cAlias + ".cDVend"),      "C")
                    CASE loc_cFld == "CCATE"
                        THIS.this_cCate       = TratarNulo(EVALUATE(loc_cAlias + ".cCate"),       "C")
                    CASE loc_cFld == "CCATED"
                        THIS.this_cCateD      = TratarNulo(EVALUATE(loc_cAlias + ".cCateD"),      "C")
                    CASE loc_cFld == "CCOLE"
                        THIS.this_cCole       = TratarNulo(EVALUATE(loc_cAlias + ".cCole"),       "C")
                    CASE loc_cFld == "CCOLED"
                        THIS.this_cColeD      = TratarNulo(EVALUATE(loc_cAlias + ".cColeD"),      "C")
                    CASE loc_cFld == "CPROD"
                        THIS.this_cProd       = TratarNulo(EVALUATE(loc_cAlias + ".cProd"),       "C")
                    CASE loc_cFld == "CPRODD"
                        THIS.this_cProdD      = TratarNulo(EVALUATE(loc_cAlias + ".cProdD"),      "C")
                    CASE loc_cFld == "NOPCAO"
                        THIS.this_nOpcao      = TratarNulo(EVALUATE(loc_cAlias + ".nOpcao"),      "N")
                    CASE loc_cFld == "NDESC"
                        THIS.this_nDesc       = TratarNulo(EVALUATE(loc_cAlias + ".nDesc"),       "N")
                    CASE loc_cFld == "NLANC"
                        THIS.this_nLanc       = TratarNulo(EVALUATE(loc_cAlias + ".nLanc"),       "N")
                ENDCASE
            ENDFOR

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Relatorio nao suporta operacoes de insercao de dados
    * Mantido por contrato com BusinessBase mas registra auditoria da execucao
    * do relatorio (que e a unica operacao "de escrita" relevante para reports)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Reports nao inserem registros de negocio. A unica acao registrada
            *-- e a auditoria da execucao do relatorio em si.
            THIS.RegistrarAuditoria("EXECUCAO_RELATORIO")
            THIS.this_cMensagemErro = "Relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o suporta opera" + CHR(231) + CHR(245) + "es de inser" + ;
                CHR(231) + CHR(227) + "o"
            loc_lSucesso = .F.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Relatorio nao suporta operacoes de atualizacao de dados
    * Mantido por contrato com BusinessBase. Reports sao read-only.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = "Relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o suporta opera" + CHR(231) + CHR(245) + "es de atualiza" + ;
                CHR(231) + CHR(227) + "o"
            loc_lSucesso = .F.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    * Operacao tipica: "EXECUCAO_RELATORIO"
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_cDetalhe, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF TYPE("gnConnHandle") <> "N" OR gnConnHandle < 1
                loc_lSucesso = .F.
            ENDIF

            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
            loc_cDetalhe = "SIGREDES " + ALLTRIM(par_cOperacao) + ;
                " | Per" + CHR(237) + "odo " + DTOC(THIS.this_dDtInicial) + ;
                " - " + DTOC(THIS.this_dDtFinal) + ;
                " | Empresa " + ALLTRIM(THIS.this_cEmpresa) + ;
                " | Vend " + ALLTRIM(THIS.this_cVend) + ;
                " | Visao " + IIF(THIS.this_nOpcao = 1, "Detalhada", "Resumida")

            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora, DadosNovos) " + ;
                "VALUES (" + EscaparSQL("SIGREDES") + ", " + ;
                EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
                EscaparSQL("SIGREDES") + ", " + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                FormatarDataSQL(DATETIME()) + ", " + ;
                EscaparSQL(loc_cDetalhe) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha todos os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(15), loc_nI
        loc_aCursores(1)  = THIS.this_cCursorDados
        loc_aCursores(2)  = THIS.this_cCursorRelatorio
        loc_aCursores(3)  = THIS.this_cCursorOpFp
        loc_aCursores(4)  = "cursor_4c_OpFp_tmp"
        loc_aCursores(5)  = "csDados1"
        loc_aCursores(6)  = "csTmpRel"
        loc_aCursores(7)  = "csRelatorio"
        loc_aCursores(8)  = "crAux"
        loc_aCursores(9)  = "crAux1"
        loc_aCursores(10) = "crAux2"
        loc_aCursores(11) = "crProd"
        loc_aCursores(12) = "crMvPar"
        loc_aCursores(13) = "csCabecalho"
        loc_aCursores(14) = "cursor_4c_EmpCab"
        loc_aCursores(15) = "csDados"

        FOR loc_nI = 1 TO 15
            IF !EMPTY(loc_aCursores(loc_nI)) AND USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

