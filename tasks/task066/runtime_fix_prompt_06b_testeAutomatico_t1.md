# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[05/18/26 02:04:28 PM] sigrecrfBO.Init: Connection handle is invalid.
[05/18/26 02:04:28 PM] Erro: Erro ao criar sigrecrfBOVARTYPE retornou: L


### LOG DA ETAPA (06b_testeAutomatico):
[2026-05-18 14:04:25] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-18 14:04:25] [INFO] Config FPW: (nao fornecido)
[2026-05-18 14:04:25] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-18 14:04:25] [INFO] Timeout: 300 segundos
[2026-05-18 14:04:25] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_5szx3mlk.prg
[2026-05-18 14:04:25] [INFO] Conteudo do wrapper:
[2026-05-18 14:04:25] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigrecrf', 'C:\4c\tasks\task066', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecrf', 'C:\4c\tasks\task066', 'REPORT'
QUIT

[2026-05-18 14:04:25] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_5szx3mlk.prg
[2026-05-18 14:04:25] [INFO] VFP output esperado em: C:\4c\tasks\task066\vfp_output.txt
[2026-05-18 14:04:25] [INFO] Executando Visual FoxPro 9...
[2026-05-18 14:04:25] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_5szx3mlk.prg
[2026-05-18 14:04:25] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_5szx3mlk.prg
[2026-05-18 14:04:25] [INFO] Timeout configurado: 300 segundos
[2026-05-18 14:04:28] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-18 14:04:28] [INFO] VFP9 finalizado em 3.3101669 segundos
[2026-05-18 14:04:28] [INFO] Exit Code: 
[2026-05-18 14:04:28] [INFO] 
[2026-05-18 14:04:28] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-18 14:04:28] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_5szx3mlk.prg
[2026-05-18 14:04:28] [INFO] 
[2026-05-18 14:04:28] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-18 14:04:28] [INFO] * Auto-generated wrapper for parameters
[2026-05-18 14:04:28] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-18 14:04:28] [INFO] * Parameters: 'Formsigrecrf', 'C:\4c\tasks\task066', 'REPORT'
[2026-05-18 14:04:28] [INFO] 
[2026-05-18 14:04:28] [INFO] * Anti-dialog protections for unattended execution
[2026-05-18 14:04:28] [INFO] SET SAFETY OFF
[2026-05-18 14:04:28] [INFO] SET RESOURCE OFF
[2026-05-18 14:04:28] [INFO] SET TALK OFF
[2026-05-18 14:04:28] [INFO] SET NOTIFY OFF
[2026-05-18 14:04:28] [INFO] SYS(2335, 0)
[2026-05-18 14:04:28] [INFO] 
[2026-05-18 14:04:28] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecrf', 'C:\4c\tasks\task066', 'REPORT'
[2026-05-18 14:04:28] [INFO] QUIT
[2026-05-18 14:04:28] [INFO] 
[2026-05-18 14:04:28] [INFO] === Fim do Wrapper.prg ===
[2026-05-18 14:04:28] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigrecrf",
  "timestamp": "20260518140428",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": false,
      "erro": "CREATEOBJECT retornou valor nao-objeto",
      "detalhes": ""
    }
  ],
  "resumo": {
    "total": 1,
    "passou": 0,
    "falhou": 1,
    "percentual": 0
  }
}



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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecrf.prg):
*==============================================================================
* FORMSIGRECRF.PRG
* Rela" + CHR(231) + CHR(227) + "o de Contagem por Refer" + CHR(234) + "ncia
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: sigrecrf.SCX (frmrelatorio - classe SIGRECNT)
*
* FASE 3/8 - Form - Estrutura Base
*   * Propriedades visuais do form (Width=800, Height=330)
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho()  (cabecalho escuro com titulo)
*   * ConfigurarBotoes()     (cmg_4c_Botoes: Visualizar/Imprimir/Excel/Encerrar)
*   * ConfigurarPageFrame()  (PageFrame com 1 pagina - "Filtros")
* FASE 4/8 - Form - Filtros na Page1 (equivalente da fase CRUD "Grid + Botoes")
*   * ConfigurarPaginaLista() (todos os controles de filtro do SIGRECNT)
*       Em forms CRUD esta fase adiciona o grid e botoes na Page1 (Lista).
*       Forms REPORT NAO tem grid CRUD nem botoes Incluir/Alterar/Excluir.
*       O equivalente eh a pagina unica de filtros - mantido nome padrao
*       (ConfigurarPaginaLista) para compatibilidade com pipeline multi-fase.
*   * AlternarPagina()        (stub - form REPORT tem pagina unica)
*   * Inicializacao txt_4c_Datas.Value = DATE() no InicializarForm
* FASE 5/8 - Form - Campos principais parte 1
*   * Linha 2: Vendedor (txt_4c_Conta + txt_4c_DConta)
*   * Linha 3: Grupo Estoque (txt_4c_Cd_GrEstoque + txt_4c_Ds_GrEstoque)
* FASE 6/8 - Form - Campos restantes e lookups
*   * Linha 4: Conta Estoque (txt_4c_Cd_Estoque + txt_4c_Ds_Estoque)
*   * Linha 5: Produto (txt_4c__Produto + txt_4c__descricao)
*   * Linha 6: Localizacoes (obj_4c_OptLocal)
*   * ConfigurarPaginaDados() - todos os BINDEVENTs de teclado e lookup
*   * Todos os handlers: Vendedor, GrEstoque, Estoque, Produto
* FASE 7/8 - Form - Eventos principais
*   * BtnVisualizarClick() - preview em tela (REPORT FORM ... PREVIEW)
*   * BtnImprimirClick()   - impressora com dialogo (REPORT FORM ... TO PRINT PROMPT)
*   * BtnExcelClick()      - exportar para Excel (RelatorioBase.GerarExcel)
*   * BtnEncerrarClick()   - fechar formulario
* FASE 8/8 - Form - Eventos auxiliares e consolidacao final
*   * CarregarLista()      - stub compatibilidade pipeline (REPORT sem grid CRUD)
*   * HabilitarCampos()    - habilita/desabilita todos os filtros do form
*   * AjustarBotoesPorModo() - stub compatibilidade pipeline (REPORT sem modos CRUD)
*   * FormParaBO()         - wrapper de compatibilidade -> delega FormParaRelatorio()
*   * BOParaForm()         - carrega propriedades do BO de volta nos controles
*   * BtnBuscarClick()     - REPORT: dispara Visualizar (preview)
*   * BtnSalvarClick()     - REPORT: dispara Imprimir (imprime sem dialogo)
*   * BtnCancelarClick()   - REPORT: limpa todos os filtros (LimparCampos)
*==============================================================================

DEFINE CLASS Formsigrecrf AS FormBase

    *-- Dimensoes e aparencia (Width=800 exato do original, Height expandido para header+filtros)
    Height      = 330
    Width       = 800
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
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption / Picture (fundo)
    *   2. Cria sigrecrfBO e valida GrPadVens (pula em modo UI)
    *   3. Monta cabecalho escuro + botoes do relatorio + PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
                           "Refer" + CHR(234) + "ncia"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("sigrecrfBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecrfBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Validar GrPadVens carregado pelo BO (pula em modo UI sem conexao SQL)
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF EMPTY(THIS.this_oRelatorio.this_cGrPadVens)
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente a cntSombra)
                THIS.ConfigurarCabecalho()

                *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com pagina de filtros
                THIS.ConfigurarPageFrame()

                *-- Vincular eventos BINDEVENT dos campos de filtro
                THIS.ConfigurarPaginaDados()

                *-- Visibilidade opcoes OptLocal por permissao de acesso
                THIS.ConfigurarPermissoesOptLocal()

                *-- Inicializar filtros com valores padrao (data = hoje)
                THIS.LimparCampos()

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
    *   Largura = Width do form (cobre toda a faixa superior).
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

            *-- Sombra deslocada 2px para efeito 3D do texto branco
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
                             "Refer" + CHR(234) + "ncia"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco (sobre a sombra)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
                             "Refer" + CHR(234) + "ncia"
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
    * ConfigurarBotoes - CommandGroup com botoes de relatorio (btnReport area)
    *   Original: btnReport.Top=0, Left=528, ButtonCount=4
    *   Botoes: Visualizar(6), Imprimir(72), DocExcel(138), Sair(204) - W=65
    *   Eventos Click vinculados em ConfigurarPaginaDados (Fase 7/8).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            *-- Visualizar (preview em tela)
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

            *-- Imprimir (impressora com dialogo)
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

            *-- Excel (documento)
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

            *-- Encerrar (fechar form - Cancel=.T. dispara no ESC)
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
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros")
    *   Form REPORT FLAT: controles de filtro sao adicionados em Page1
    *   nas fases seguintes (4-6). Posicionado logo abaixo do cabecalho.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        *-- Configurar Page1 (FORA de qualquer WITH - usar referencia direta)
        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        *-- Adicionar controles de filtro na Page1
        THIS.ConfigurarPaginaLista()

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona todos os controles de filtro na Page1
    *   FORM REPORT: a "Page1" eh a unica pagina e contem todos os filtros.
    *   Nome do metodo mantem padrao "ConfigurarPaginaLista" para compatibilidade
    *   com o pipeline multi-fase (validador da Fase 4 exige este nome). Em forms
    *   CRUD esta seria a pagina de Lista; aqui eh a pagina de Filtros do REPORT.
    *
    *   Migrado do layout flat do SIGRECNT (form de 800x269).
    *   Posicoes top = original - 85 (PageFrame.Top=85).
    *   Linha 1: Data (txt_4c_Datas) + Codigo referencia (txt_4c_Codigo)
    *   Linha 2: Vendedor - codigo (txt_4c_Conta) + descricao (txt_4c_DConta)
    *   Linha 3: Grupo Estoque - cod (txt_4c_Cd_GrEstoque) + ds (txt_4c_Ds_GrEstoque)
    *   Linha 4: Conta Estoque - cod (txt_4c_Cd_Estoque) + ds (txt_4c_Ds_Estoque)
    *   Linha 5: Produto - cod (txt_4c__Produto) + ds (txt_4c__descricao)
    *   Linha 6: Localizacoes label + obj_4c_OptLocal (OptionGroup 4 botoes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *--------------------------------------------------------------------
        *-- Linha 1: Data e Codigo de referencia
        *   Original: Label1.top=99 GetDatas.top=95 Label3.top=98 GetCods.top=94
        *--------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Top       = 14
            .Left      = 220
            .Width     = 32
            .Height    = 15
            .Caption   = "Data :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Datas", "TextBox")
        WITH loc_oPagina.txt_4c_Datas
            .Top           = 10
            .Left          = 256
            .Width         = 80
            .Height        = 24
            .Value         = {}
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Top       = 13
            .Left      = 387
            .Width     = 42
            .Height    = 15
            .Caption   = "C" + CHR(243) + "digo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Top           = 9
            .Left          = 432
            .Width         = 54
            .Height        = 24
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *--------------------------------------------------------------------
        *-- Linha 2: Vendedor - codigo + descricao
        *   Original: Label2.top=126 getConta.top=121 getDConta.top=121
        *   getDConta.When = "Return Empty(ThisForm.getConta.Value)"
        *   -> habilitado apenas quando getConta estiver vazio
        *--------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Top       = 41
            .Left      = 197
            .Width     = 55
            .Height    = 15
            .Caption   = "Vendedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.txt_4c_Conta
            .Top           = 36
            .Left          = 256
            .Width         = 80
            .Height        = 24
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Margin        = 3
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPagina.txt_4c_DConta
            .Top           = 36
            .Left          = 338
            .Width         = 290
            .Height        = 24
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Margin        = 3
            .Visible       = .T.
        ENDWITH

        *--------------------------------------------------------------------
        *-- Linha 3: Grupo de Estoque - codigo + descricao
        *   Original: Say1.top=152 Get_Cd_GrEstoque.top=148 Get_Ds_GrEstoque.top=148
        *   Say1 mapeado como lbl_4c_Label_GrEstoque (evita conflito com Label1)
        *--------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label_GrEstoque", "Label")
        WITH loc_oPagina.lbl_4c_Label_GrEstoque
            .Top       = 67
            .Left      = 172
            .Width     = 80
            .Height    = 15
            .Caption   = "Grupo Estoque :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cd_GrEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_Cd_GrEstoque
            .Top           = 63
            .Left          = 256
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Format        = "K"
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ds_GrEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_Ds_GrEstoque
            .Top           = 63
            .Left          = 338
            .Width         = 290
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Format        = "K"
            .MaxLength     = 20
            .Visible       = .T.
        ENDWITH

        *--------------------------------------------------------------------
        *-- Linha 4: Conta de Estoque - codigo + descricao
        *   Original: lbl_estoque.top=178 Get_Cd_Estoque.top=174 Get_Ds_Estoque.top=174
        *   Get_Ds_Estoque.When habilitado apenas quando Get_Cd_Estoque estiver vazio
        *--------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Lbl_estoque", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_estoque
            .Top       = 93
            .Left      = 172
            .Width     = 80
            .Height    = 15
            .Caption   = "Conta Estoque :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cd_Estoque", "TextBox")
        WITH loc_oPagina.txt_4c_Cd_Estoque
            .Top           = 89
            .Left          = 256
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Format        = "K"
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ds_Estoque", "TextBox")
        WITH loc_oPagina.txt_4c_Ds_Estoque
            .Top           = 89
            .Left          = 338
            .Width         = 290
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Format        = "K"
            .MaxLength     = 40
            .Visible       = .T.
        ENDWITH

        *--------------------------------------------------------------------
        *-- Linha 5: Produto - codigo + descricao
        *   Original: lbl_codigo.top=204 get_Produto.top=200 get_descricao.top=200
        *   Nomes com duplo underscore conforme mapeamento.json
        *--------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Lbl_codigo", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_codigo
            .Top       = 119
            .Left      = 205
            .Width     = 47
            .Height    = 15
            .Caption   = "Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c__Produto", "TextBox")
        WITH loc_oPagina.txt_4c__Produto
            .Top           = 115
            .Left          = 256
            .Width         = 108
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Format        = "K!"
            .MaxLength     = 14
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c__descricao", "TextBox")
        WITH loc_oPagina.txt_4c__descricao
            .Top           = 115
            .Left          = 367
            .Width         = 261
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Format        = "K!"
            .MaxLength     = 40
            .Visible       = .T.
        ENDWITH

        *--------------------------------------------------------------------
        *-- Linha 6: Localizacoes - label + OptionGroup 4 opcoes
        *   Original: Label4.top=228 OptLocal.top=223 Width=347 Height=26
        *   btnReport.Click verifica Value <> 4 para exigir data
        *   Opcao 4 = relatorio sem exigencia de data
        *--------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Top       = 143
            .Left      = 184
            .Width     = 68
            .Height    = 15
            .Caption   = "Localiza" + CHR(231) + CHR(245) + "es :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_OptLocal", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptLocal
            .Top         = 138
            .Left        = 252
            .Width       = 347
            .Height      = 26
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            .Value       = 4

            WITH .Buttons(1)
                .Caption   = "Todas"
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
                .Left      = 5
                .Top       = 5
                .Width     = 47
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Somente Lidos"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
                .Left      = 74
                .Top       = 6
                .Width     = 87
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "N" + CHR(227) + "o Lidos"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
                .Left      = 191
                .Top       = 6
                .Width     = 64
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(4)
                .Caption   = "Diferen" + CHR(231) + "as"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .T.
                .Left      = 273
                .Top       = 5
                .Width     = 69
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navegacao de paginas (form REPORT tem pagina unica)
    *   Mantido para compatibilidade com pipeline multi-fase.
    *   Para forms REPORT o PageFrame permanece sempre em ActivePage=1.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Vincula eventos BINDEVENT dos controles de filtro
    *   FORM REPORT sem Page2: todos os controles ja estao em Page1 (Fase 4).
    *   Esta fase conecta os controles existentes aos handlers de evento.
    *   Chamado por InicializarForm apos ConfigurarPageFrame.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Vendedor: codigo e descricao (com controle de acesso via SigCdAcJ)
        BINDEVENT(loc_oPagina.txt_4c_Conta,        "DblClick", THIS, "AbrirBuscaVendedor")
        BINDEVENT(loc_oPagina.txt_4c_Conta,        "KeyPress", THIS, "TeclaVendedor")
        BINDEVENT(loc_oPagina.txt_4c_DConta,       "DblClick", THIS, "AbrirBuscaVendedor")
        BINDEVENT(loc_oPagina.txt_4c_DConta,       "KeyPress", THIS, "TeclaDescVendedor")

        *-- Grupo Estoque: codigo e descricao (SigCdGcr)
        BINDEVENT(loc_oPagina.txt_4c_Cd_GrEstoque, "DblClick", THIS, "AbrirBuscaGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_Cd_GrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_Ds_GrEstoque, "DblClick", THIS, "AbrirBuscaGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_Ds_GrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")

        *-- Conta Estoque: codigo e descricao (SigCdCli filtrado por GrEstoque)
        BINDEVENT(loc_oPagina.txt_4c_Cd_Estoque,   "DblClick", THIS, "AbrirBuscaEstoque")
        BINDEVENT(loc_oPagina.txt_4c_Cd_Estoque,   "KeyPress", THIS, "TeclaCdEstoque")
        BINDEVENT(loc_oPagina.txt_4c_Ds_Estoque,   "DblClick", THIS, "AbrirBuscaEstoque")
        BINDEVENT(loc_oPagina.txt_4c_Ds_Estoque,   "KeyPress", THIS, "TeclaDsEstoque")

        *-- Produto: codigo e descricao (SigCdPro)
        BINDEVENT(loc_oPagina.txt_4c__Produto,     "DblClick", THIS, "AbrirBuscaProduto")
        BINDEVENT(loc_oPagina.txt_4c__Produto,     "KeyPress", THIS, "TeclaProduto")
        BINDEVENT(loc_oPagina.txt_4c__descricao,   "DblClick", THIS, "AbrirBuscaProduto")
        BINDEVENT(loc_oPagina.txt_4c__descricao,   "KeyPress", THIS, "TeclaDescProduto")

        *-- Botoes do relatorio (Visualizar/Imprimir/Excel/Encerrar)
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa todos os filtros com valores padrao
    *   Data = hoje, demais em branco, OptLocal = 1 (Todos).
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_oPagina.txt_4c_Datas.Value         = DATE()
        loc_oPagina.txt_4c_Codigo.Value        = ""
        loc_oPagina.txt_4c_Conta.Value         = ""
        loc_oPagina.txt_4c_DConta.Value        = ""
        loc_oPagina.txt_4c_Cd_GrEstoque.Value  = ""
        loc_oPagina.txt_4c_Ds_GrEstoque.Value  = ""
        loc_oPagina.txt_4c_Cd_Estoque.Value    = ""
        loc_oPagina.txt_4c_Ds_Estoque.Value    = ""
        loc_oPagina.txt_4c__Produto.Value      = ""
        loc_oPagina.txt_4c__descricao.Value    = ""
        loc_oPagina.obj_4c_OptLocal.Value      = 4
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos filtros do form para o BO
    *   Chamado em BtnVisualizarClick, BtnImprimirClick e BtnExcelClick.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dData        = loc_oPagina.txt_4c_Datas.Value
            .this_cCods        = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
            .this_cConta       = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
            .this_cDConta      = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
            .this_cCdGrEstoque = ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value)
            .this_cDsGrEstoque = ALLTRIM(loc_oPagina.txt_4c_Ds_GrEstoque.Value)
            .this_cCdEstoque   = ALLTRIM(loc_oPagina.txt_4c_Cd_Estoque.Value)
            .this_cDsEstoque   = ALLTRIM(loc_oPagina.txt_4c_Ds_Estoque.Value)
            .this_cProduto     = ALLTRIM(loc_oPagina.txt_4c__Produto.Value)
            .this_cDsProduto   = ALLTRIM(loc_oPagina.txt_4c__descricao.Value)
            .this_nOptLocal    = loc_oPagina.obj_4c_OptLocal.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDataParaRelatorio - Verifica se a data foi informada
    *   Equivalente ao "If (This.Value <> 4) If Empty(getDatas.Value)" do legado.
    *   Retorna .T. se data valida, .F. se vazia (posiciona foco na data).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDataParaRelatorio()
        LOCAL loc_oPagina, loc_nOptLocal
        loc_oPagina   = THIS.pgf_4c_Paginas.Page1
        loc_nOptLocal = 0
        IF VARTYPE(loc_oPagina.obj_4c_OptLocal) = "O"
            loc_nOptLocal = loc_oPagina.obj_4c_OptLocal.Value
        ENDIF
        IF loc_nOptLocal <> 4 AND EMPTY(loc_oPagina.txt_4c_Datas.Value)
            MsgAviso("Data inv" + CHR(225) + "lida!", "Aviso")
            loc_oPagina.txt_4c_Datas.SetFocus()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em tela (preview)
    *   Botao 1 do cmg_4c_Botoes.
    *   Equivalente a: REPORT FORM SigReCrf PREVIEW NOCONSOLE
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !THIS.ValidarDataParaRelatorio()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            LOCAL loc_cMsg
            loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMsg)
                MsgErro(loc_cMsg, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio com dialogo de impressora
    *   Botao 2 do cmg_4c_Botoes.
    *   Equivalente a: REPORT FORM SigReCrf TO PRINT PROMPT NOCONSOLE
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF !THIS.ValidarDataParaRelatorio()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            LOCAL loc_cMsg
            loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMsg)
                MsgErro(loc_cMsg, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta relatorio para Excel
    *   Botao 3 do cmg_4c_Botoes.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        IF !THIS.ValidarDataParaRelatorio()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.GerarExcel()
            LOCAL loc_cMsg
            loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMsg)
                MsgErro(loc_cMsg, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario de relatorio
    *   Botao 4 (Cancel=.T.) do cmg_4c_Botoes. Sem validacao de data.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    *  EVENTOS CRUD-NAMED (mapeados ao contexto de REPORT form)
    *  Em forms REPORT (frmrelatorio) os eventos Incluir/Alterar/Excluir
    *  nao tem o sentido CRUD tradicional. Sao remapeados para operacoes
    *  uteis no fluxo de filtros do relatorio.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT forms, "Incluir" mapeia para "Novo
    * Relatorio": limpa todos os filtros (LimparCampos restaura defaults com
    * txt_4c_Datas=DATE() e obj_4c_OptLocal=4 "Todos") e devolve foco ao
    * primeiro filtro de data, permitindo o usuario iniciar uma nova consulta
    * do zero sem precisar reabrir o formulario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPagina
        THIS.LimparCampos()
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPagina) = "O" AND VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
            loc_oPagina.txt_4c_Datas.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em REPORT forms, "Alterar" mapeia para "Alterar
    * Filtros": preserva os valores atuais dos filtros (NAO chama LimparCampos)
    * e devolve o foco ao primeiro filtro de data, permitindo refinar a
    * consulta antes de re-Visualizar/Imprimir. Ressincroniza tambem a
    * visibilidade do OptLocal com o ComboBox/Datas para manter UI consistente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPagina) != "O"
            RETURN
        ENDIF
        IF VARTYPE(loc_oPagina.obj_4c_OptLocal) = "O"
            loc_oPagina.obj_4c_OptLocal.Visible = .T.
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
            loc_oPagina.txt_4c_Datas.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em REPORT forms, "Excluir" mapeia para "Limpar
    * Filtros" / "Descartar parametros": pede confirmacao e, se confirmado,
    * zera todos os filtros via LimparCampos() (restaura txt_4c_Datas=DATE() e
    * obj_4c_OptLocal=4) e devolve foco ao primeiro filtro de data. Util
    * quando o usuario quer abandonar uma combinacao de filtros e recomecar
    * do zero sem fechar o form.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oPagina, loc_cMsg
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPagina) != "O"
            RETURN
        ENDIF
        loc_cMsg = "Deseja limpar os filtros e recome" + CHR(231) + "ar?"
        IF !MsgConfirma(loc_cMsg, "Limpar Filtros")
            RETURN
        ENDIF
        THIS.LimparCampos()
        IF VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
            loc_oPagina.txt_4c_Datas.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO + VALIDACAO + LOOKUP - Vendedor (getConta/getDConta)
    *==========================================================================

    *--------------------------------------------------------------------------
    * TeclaVendedor - Handler KeyPress de txt_4c_Conta (codigo do vendedor)
    *   ENTER(13) / TAB(9): valida codigo digitado | F4(115): abre busca direta
    *--------------------------------------------------------------------------
    PROCEDURE TeclaVendedor(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaVendedor()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarVendedor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDescVendedor - Handler KeyPress de txt_4c_DConta (nome do vendedor)
    *   getDConta.When legado: habilitado apenas quando getConta eh vazio.
    *   ENTER(13) / TAB(9) / F4(115): abre busca de vendedor por nome.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDescVendedor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarDescVendedor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarVendedor - Limpa descricao se codigo vazio; abre busca caso contrario
    *   Equivalente ao getConta.Valid do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarVendedor()
        LOCAL loc_cValor, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c_DConta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaVendedor()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDescVendedor - Limpa codigo se descricao vazia; abre busca contrario
    *   Equivalente ao getDConta.Valid do legado (busca reversa por rclis).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDescVendedor()
        LOCAL loc_cValor, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Conta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaVendedor()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaVendedor - Lista vendedores com controle de acesso (SigCdAcJ)
    *   Equivalente ao getConta.Valid / getDConta.Valid do legado.
    *   Filtra SigCdCli pelo GrPadVens e jobs acessiveis ao usuario logado.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaVendedor()
        LOCAL loc_cGrPadVens, loc_cSQL, loc_nResult, loc_oLookup, loc_oPagina
        loc_oPagina    = THIS.pgf_4c_Paginas.Page1
        loc_cGrPadVens = ""
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            loc_cGrPadVens = ALLTRIM(THIS.this_oRelatorio.this_cGrPadVens)
        ENDIF

        loc_cSQL = "SELECT a.iclis AS Cods, a.rclis AS Descs " + ;
                   "FROM SigCdCli a " + ;
                   "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
                   "AND (b.Coletors <> 10 " + ;
                   "OR (b.Coletors = 10 " + ;
                   "AND a.IClis NOT IN (" + ;
                   "SELECT DISTINCT c.Jobs FROM SigCdAcJ c " + ;
                   "WHERE c.Jobs NOT IN (" + ;
                   "SELECT DISTINCT d.Jobs FROM SigCdAcJ d " + ;
                   "WHERE d.Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + "))))"
        IF !EMPTY(loc_cGrPadVens)
            loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrPadVens)
        ENDIF
        loc_cSQL = loc_cSQL + " AND a.Inativas <> 2" + ;
                   " AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                   " ORDER BY a.rclis"

        IF USED("cursor_4c_BuscaVend")
            USE IN SELECT("cursor_4c_BuscaVend")
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaVend")
        IF loc_nResult > 0
            IF RECCOUNT("cursor_4c_BuscaVend") > 0
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oLookup) = "O"
                    loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaVend"
                    loc_oLookup.DefinirCursor("cursor_4c_BuscaVend", "Cods", "Descs", ;
                        "Sele" + CHR(231) + CHR(227) + "o de Vendedor")
                    IF loc_oLookup.Mostrar()
                        loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                        loc_oPagina.txt_4c_DConta.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
                    ENDIF
                ENDIF
            ELSE
                MsgAviso("Nenhum vendedor encontrado.", "Aviso")
            ENDIF
            IF USED("cursor_4c_BuscaVend")
                USE IN SELECT("cursor_4c_BuscaVend")
            ENDIF
        ELSE
            MsgErro("Erro ao buscar vendedores.", "Erro")
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO + VALIDACAO + LOOKUP - Grupo de Estoque
    *==========================================================================

    *--------------------------------------------------------------------------
    * TeclaCdGrEstoque - Handler KeyPress de txt_4c_Cd_GrEstoque (cod grupo)
    *   ENTER(13) / TAB(9): valida codigo | F4(115): abre busca direta
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsGrEstoque - Handler KeyPress de txt_4c_Ds_GrEstoque (desc grupo)
    *   Get_Ds_GrEstoque.When legado: habilitado apenas quando codigo vazio.
    *   ENTER(13) / TAB(9) / F4(115): abre busca de grupo por descricao.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value))
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarDsGrEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdGrEstoque - Valida codigo do grupo de estoque em SigCdGcr
    *   Equivalente ao Get_Cd_GrEstoque.Valid (fAcessoContab 'C') do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdGrEstoque()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value)
        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Ds_GrEstoque.Value = ""
            loc_oPagina.txt_4c_Cd_Estoque.Value   = ""
            loc_oPagina.txt_4c_Ds_Estoque.Value   = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 b.Codigos, b.Descrs " + ;
                   "FROM SigCdCli a " + ;
                   "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
                   "WHERE a.Grupos = " + EscaparSQL(loc_cValor)
        IF USED("cursor_4c_GrEstVal")
            USE IN SELECT("cursor_4c_GrEstVal")
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrEstVal")
        IF loc_nResult > 0 AND !EOF("cursor_4c_GrEstVal")
            SELECT cursor_4c_GrEstVal
            loc_oPagina.txt_4c_Cd_GrEstoque.Value = ALLTRIM(cursor_4c_GrEstVal.Codigos)
            loc_oPagina.txt_4c_Ds_GrEstoque.Value = ALLTRIM(cursor_4c_GrEstVal.Descrs)
        ELSE
            MsgAviso("Grupo de estoque n" + CHR(227) + "o encontrado.", "Aviso")
            loc_oPagina.txt_4c_Cd_GrEstoque.Value = ""
            loc_oPagina.txt_4c_Ds_GrEstoque.Value = ""
            loc_oPagina.txt_4c_Cd_Estoque.Value   = ""
            loc_oPagina.txt_4c_Ds_Estoque.Value   = ""
            THIS.AbrirBuscaGrEstoque()
        ENDIF
        IF USED("cursor_4c_GrEstVal")
            USE IN SELECT("cursor_4c_GrEstVal")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsGrEstoque - Valida descricao (busca reversa); abre lookup
    *   Equivalente ao Get_Ds_GrEstoque.Valid (fAcessoContab 'D') do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsGrEstoque()
        LOCAL loc_cValor, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Ds_GrEstoque.Value)
        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Cd_GrEstoque.Value = ""
            loc_oPagina.txt_4c_Cd_Estoque.Value   = ""
            loc_oPagina.txt_4c_Ds_Estoque.Value   = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaGrEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrEstoque - Lista grupos de estoque/contab (SigCdGcr)
    *   Equivalente ao fAcessoContab do legado para selecao de grupo.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrEstoque()
        LOCAL loc_cSQL, loc_nResult, loc_oLookup, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_BuscaGrEst")
            USE IN SELECT("cursor_4c_BuscaGrEst")
        ENDIF
        loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrEst")
        IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaGrEst") > 0
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaGrEst"
                loc_oLookup.DefinirCursor("cursor_4c_BuscaGrEst", "Codigos", "Descrs", ;
                    "Grupo de Estoque")
                IF loc_oLookup.Mostrar()
                    loc_oPagina.txt_4c_Cd_GrEstoque.Value = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                    loc_oPagina.txt_4c_Ds_GrEstoque.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
                    loc_oPagina.txt_4c_Cd_Estoque.Value   = ""
                    loc_oPagina.txt_4c_Ds_Estoque.Value   = ""
                ENDIF
            ENDIF
        ELSE
            MsgAviso("Nenhum grupo de estoque encontrado.", "Aviso")
        ENDIF
        IF USED("cursor_4c_BuscaGrEst")
            USE IN SELECT("cursor_4c_BuscaGrEst")
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO + VALIDACAO + LOOKUP - Conta de Estoque
    *==========================================================================

    *--------------------------------------------------------------------------
    * TeclaCdEstoque - Handler KeyPress de txt_4c_Cd_Estoque (cod conta)
    *   Bloqueia entrada se GrEstoque nao informado (equivalente ao When legado).
    *   ENTER(13) / TAB(9): valida codigo | F4(115): abre busca direta
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value))
            MsgAviso("Informe o Grupo de Estoque antes.", "Aviso")
            loc_oPagina.txt_4c_Cd_Estoque.Value = ""
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsEstoque - Handler KeyPress de txt_4c_Ds_Estoque (desc conta)
    *   Get_Ds_Estoque.When legado: habilitado apenas quando codigo vazio.
    *   ENTER(13) / TAB(9) / F4(115): abre busca de conta por descricao.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsEstoque(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cd_Estoque.Value))
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value))
            MsgAviso("Informe o Grupo de Estoque antes.", "Aviso")
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarDsEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdEstoque - Valida codigo da conta de estoque (SigCdCli)
    *   Equivalente ao Get_Cd_Estoque.Valid (fAcessoContas 'C') do legado.
    *   Filtra SigCdCli pelo grupo de estoque selecionado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdEstoque()
        LOCAL loc_cValor, loc_cGrupo, loc_cSQL, loc_nResult, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Cd_Estoque.Value)
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value)
        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Ds_Estoque.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 a.IClis, a.RClis " + ;
                   "FROM SigCdCli a " + ;
                   "WHERE a.IClis = " + EscaparSQL(loc_cValor)
        IF !EMPTY(loc_cGrupo)
            loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
        ENDIF
        IF USED("cursor_4c_EstVal")
            USE IN SELECT("cursor_4c_EstVal")
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstVal")
        IF loc_nResult > 0 AND !EOF("cursor_4c_EstVal")
            SELECT cursor_4c_EstVal
            loc_oPagina.txt_4c_Cd_Estoque.Value = ALLTRIM(cursor_4c_EstVal.IClis)
            loc_oPagina.txt_4c_Ds_Estoque.Value = ALLTRIM(cursor_4c_EstVal.RClis)
        ELSE
            MsgAviso("Conta de estoque n" + CHR(227) + "o encontrada.", "Aviso")
            loc_oPagina.txt_4c_Cd_Estoque.Value = ""
            loc_oPagina.txt_4c_Ds_Estoque.Value = ""
            THIS.AbrirBuscaEstoque()
        ENDIF
        IF USED("cursor_4c_EstVal")
            USE IN SELECT("cursor_4c_EstVal")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsEstoque - Valida descricao da conta; abre busca reversa
    *   Equivalente ao Get_Ds_Estoque.Valid (fAcessoContas 'D') do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsEstoque()
        LOCAL loc_cValor, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Ds_Estoque.Value)
        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Cd_Estoque.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEstoque - Lista contas de estoque (SigCdCli) filtradas por grupo
    *   Equivalente ao fAcessoContas do legado para selecao de conta de estoque.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEstoque()
        LOCAL loc_cGrupo, loc_cSQL, loc_nResult, loc_oLookup, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value)
        IF USED("cursor_4c_BuscaEst")
            USE IN SELECT("cursor_4c_BuscaEst")
        ENDIF
        loc_cSQL = "SELECT a.IClis AS Cods, a.RClis AS Descs " + ;
                   "FROM SigCdCli a " + ;
                   "WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
        IF !EMPTY(loc_cGrupo)
            loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
        ENDIF
        loc_cSQL = loc_cSQL + " ORDER BY a.RClis"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEst")
        IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaEst") > 0
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaEst"
                loc_oLookup.DefinirCursor("cursor_4c_BuscaEst", "Cods", "Descs", ;
                    "Conta de Estoque")
                IF loc_oLookup.Mostrar()
                    loc_oPagina.txt_4c_Cd_Estoque.Value = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                    loc_oPagina.txt_4c_Ds_Estoque.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
                ENDIF
            ENDIF
        ELSE
            MsgAviso("Nenhuma conta de estoque encontrada.", "Aviso")
        ENDIF
        IF USED("cursor_4c_BuscaEst")
            USE IN SELECT("cursor_4c_BuscaEst")
        ENDIF
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO + VALIDACAO + LOOKUP - Produto (get_Produto/get_descricao)
    *==========================================================================

    *--------------------------------------------------------------------------
    * TeclaProduto - Handler KeyPress de txt_4c__Produto (codigo do produto)
    *   ENTER(13) / TAB(9): valida codigo digitado | F4(115): abre busca direta
    *--------------------------------------------------------------------------
    PROCEDURE TeclaProduto(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaProduto()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarProduto()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDescProduto - Handler KeyPress de txt_4c__descricao (desc produto)
    *   get_descricao.When legado: habilitado apenas quando codigo vazio.
    *   ENTER(13) / TAB(9) / F4(115): abre busca de produto por descricao.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDescProduto(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c__Produto.Value))
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarDescProduto()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarProduto - Valida codigo do produto (SigCdPro.cpros)
    *   Equivalente ao get_Produto.Valid (fwBuscaExt SigCdPro cpros) do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarProduto()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__Produto.Value)
        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c__descricao.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 cpros, dpros FROM SigCdPro " + ;
                   "WHERE cpros = " + EscaparSQL(loc_cValor)
        IF USED("cursor_4c_ProdVal")
            USE IN SELECT("cursor_4c_ProdVal")
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdVal")
        IF loc_nResult > 0 AND !EOF("cursor_4c_ProdVal")
            SELECT cursor_4c_ProdVal
            loc_oPagina.txt_4c__Produto.Value   = ALLTRIM(cursor_4c_ProdVal.cpros)
            loc_oPagina.txt_4c__descricao.Value = ALLTRIM(cursor_4c_ProdVal.dpros)
        ELSE
            MsgAviso("Produto n" + CHR(227) + "o encontrado.", "Aviso")
            loc_oPagina.txt_4c__Produto.Value   = ""
            loc_oPagina.txt_4c__descricao.Value = ""
            THIS.AbrirBuscaProduto()
        ENDIF
        IF USED("cursor_4c_ProdVal")
            USE IN SELECT("cursor_4c_ProdVal")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDescProduto - Valida descricao (busca reversa em SigCdPro.dpros)
    *   Equivalente ao get_descricao.Valid (fwBuscaExt SigCdPro DPros) do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDescProduto()
        LOCAL loc_cValor, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__descricao.Value)
        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c__Produto.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaProduto()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaProduto - Lista produtos (SigCdPro) por codigo ou descricao
    *   Equivalente ao fwBuscaExt SigCdPro do legado para selecao de produto.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaProduto()
        LOCAL loc_cSQL, loc_nResult, loc_oLookup, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_BuscaProd")
            USE IN SELECT("cursor_4c_BuscaProd")
        ENDIF
        loc_cSQL    = "SELECT cpros, dpros FROM SigCdPro ORDER BY dpros"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProd")
        IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaProd") > 0
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaProd"
                loc_oLookup.DefinirCursor("cursor_4c_BuscaProd", "cpros", "dpros", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Produto")
                IF loc_oLookup.Mostrar()
                    loc_oPagina.txt_4c__Produto.Value   = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                    loc_oPagina.txt_4c__descricao.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
                ENDIF
            ENDIF
        ELSE
            MsgAviso("Nenhum produto encontrado.", "Aviso")
        ENDIF
        IF USED("cursor_4c_BuscaProd")
            USE IN SELECT("cursor_4c_BuscaProd")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPermissoesOptLocal - Controla visibilidade das opcoes do OptLocal
    *   No original: se usuario NAO tem acesso DIFERENCA e nao e '4CONTROL',
    *   esconde opcoes 1,2,3 (mostra apenas "Diferencas"). Caso contrario, todas.
    *   Na nova arquitetura sem fChecaAcesso, default = mostrar todas as opcoes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPermissoesOptLocal()
        LOCAL loc_oPagina, loc_lMostrarTodas, loc_cUsuario
        loc_oPagina      = THIS.pgf_4c_Paginas.Page1
        loc_lMostrarTodas = .T.
        loc_cUsuario     = ""
        IF TYPE("gc_4c_UsuarioLogado") = "C"
            loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
        ENDIF

        *-- Verificar flag de restricao no BO (set durante Init do BO)
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF PEMSTATUS(THIS.this_oRelatorio, "this_lAcessoSomentesDif", 5)
                IF THIS.this_oRelatorio.this_lAcessoSomentesDif AND ;
                   UPPER(loc_cUsuario) <> "4CONTROL"
                    loc_lMostrarTodas = .F.
                ENDIF
            ENDIF
        ENDIF

        WITH loc_oPagina.obj_4c_OptLocal
            .Buttons(1).Visible = loc_lMostrarTodas
            .Buttons(2).Visible = loc_lMostrarTodas
            .Buttons(3).Visible = loc_lMostrarTodas
            .Buttons(4).Visible = .T.
            IF !loc_lMostrarTodas
                .Value = 4
            ENDIF
        ENDWITH
    ENDPROC


    *==========================================================================
    *  FASE 8/8 - METODOS AUXILIARES E COMPATIBILIDADE COM PIPELINE MULTI-FASE
    *  Em forms REPORT (frmrelatorio) nao existem modos CRUD nem grid de lista.
    *  Os metodos abaixo existem para satisfazer o contrato do pipeline multi-fase
    *  e para fornecer comportamentos uteis mapeados ao contexto do relatorio.
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarLista - Compatibilidade com pipeline CRUD (REPORT: sem lista)
    *   Em forms REPORT nao ha grid de lista para recarregar. Retorna .T.
    *   para indicar sucesso ao pipeline que chama este metodo apos Incluir.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita todos os campos de filtro
    *   par_lHabilitar: .T. = habilitar todos, .F. = desabilitar todos.
    *   Sem par_lHabilitar (ou tipo invalido) assume .T. (habilitar).
    *   Em forms REPORT o padrao eh sempre habilitado (sem modo VISUALIZAR).
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab, loc_oPagina
        loc_lHab    = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPagina) != "O"
            RETURN
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
            loc_oPagina.txt_4c_Datas.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_Codigo) = "O"
            loc_oPagina.txt_4c_Codigo.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_Conta) = "O"
            loc_oPagina.txt_4c_Conta.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_DConta) = "O"
            loc_oPagina.txt_4c_DConta.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_Cd_GrEstoque) = "O"
            loc_oPagina.txt_4c_Cd_GrEstoque.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_Ds_GrEstoque) = "O"
            loc_oPagina.txt_4c_Ds_GrEstoque.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_Cd_Estoque) = "O"
            loc_oPagina.txt_4c_Cd_Estoque.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c_Ds_Estoque) = "O"
            loc_oPagina.txt_4c_Ds_Estoque.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c__Produto) = "O"
            loc_oPagina.txt_4c__Produto.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(loc_oPagina.txt_4c__descricao) = "O"
            loc_oPagina.txt_4c__descricao.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(loc_oPagina.obj_4c_OptLocal) = "O"
            loc_oPagina.obj_4c_OptLocal.Enabled = loc_lHab
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Compatibilidade com pipeline CRUD
    *   Em forms REPORT nao ha modos CRUD. Os 4 botoes do cmg_4c_Botoes ficam
    *   sempre habilitados (Visualizar/Imprimir/Excel/Encerrar).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Compatibilidade com pipeline CRUD
    *   Delega para FormParaRelatorio() que copia valores dos filtros do form
    *   para as propriedades this_* do sigrecrfBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega propriedades do BO de relatorio de volta ao form
    *   Restaura os campos de filtro com os valores que estao no BO.
    *   Util apos uma operacao que atualizou o BO externamente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPagina) != "O"
            RETURN
        ENDIF
        WITH THIS.this_oRelatorio
            IF VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
                loc_oPagina.txt_4c_Datas.Value = IIF(EMPTY(.this_dData), DATE(), .this_dData)
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_Codigo) = "O"
                loc_oPagina.txt_4c_Codigo.Value = .this_cCods
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_Conta) = "O"
                loc_oPagina.txt_4c_Conta.Value = .this_cConta
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_DConta) = "O"
                loc_oPagina.txt_4c_DConta.Value = .this_cDConta
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_Cd_GrEstoque) = "O"
                loc_oPagina.txt_4c_Cd_GrEstoque.Value = .this_cCdGrEstoque
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_Ds_GrEstoque) = "O"
                loc_oPagina.txt_4c_Ds_GrEstoque.Value = .this_cDsGrEstoque
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_Cd_Estoque) = "O"
                loc_oPagina.txt_4c_Cd_Estoque.Value = .this_cCdEstoque
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c_Ds_Estoque) = "O"
                loc_oPagina.txt_4c_Ds_Estoque.Value = .this_cDsEstoque
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c__Produto) = "O"
                loc_oPagina.txt_4c__Produto.Value = .this_cProduto
            ENDIF
            IF VARTYPE(loc_oPagina.txt_4c__descricao) = "O"
                loc_oPagina.txt_4c__descricao.Value = .this_cDsProduto
            ENDIF
            IF VARTYPE(loc_oPagina.obj_4c_OptLocal) = "O"
                loc_oPagina.obj_4c_OptLocal.Value = .this_nOptLocal
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT forms, "Buscar" = Visualizar (preview em tela)
    *   Valida data (exceto OptLocal=4), copia filtros para BO e exibe relatorio.
    *   Equivalente semantico ao "Buscar" em forms CRUD que carrega a lista.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT forms, "Salvar" = Imprimir (direto na impressora)
    *   Valida data, copia filtros para BO e imprime sem dialogo de impressora.
    *   Equivalente semantico ao "Salvar" de forms CRUD (persistir resultado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        IF !THIS.ValidarDataParaRelatorio()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            LOCAL loc_cMsg
            loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMsg)
                MsgErro(loc_cMsg, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT forms, "Cancelar" = Limpar filtros
    *   Restaura todos os campos de filtro para seus valores padrao (LimparCampos)
    *   e posiciona foco no campo de data para nova consulta.
    *   Equivalente semantico ao "Cancelar" de forms CRUD (descartar edicao).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oPagina
        THIS.LimparCampos()
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPagina) = "O"
            IF VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
                loc_oPagina.txt_4c_Datas.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecrfBO.prg):
*==============================================================================
* SIGRECRFBO.PRG
* Business Object para Relatorio de Contagem por Referencia
*
* Herda de: RelatorioBase
* Form: Formsigrecrf.prg
* Relatorio original: sigrecrf.SCX / SigReCrf.FRX
*==============================================================================

DEFINE CLASS sigrecrfBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigReCrf"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario
    this_dData              = {}
    this_cConta             = ""
    this_cDConta            = ""
    this_cCods              = ""
    this_cProduto           = ""
    this_cDsProduto         = ""
    this_cCdGrEstoque       = ""
    this_cDsGrEstoque       = ""
    this_cCdEstoque         = ""
    this_cDsEstoque         = ""
    this_nOptLocal          = 4

    *-- Estado / controle
    this_cGrPadVens         = ""
    this_lAcessoSomentesDif = .F.

    *-- Cursor principal gerado por PrepararDados
    this_cCursorDados       = "crRel"

    *--------------------------------------------------------------------------
    * Init - Carrega GrPadVens de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cTabela          = ""
        THIS.this_cCampoChave      = ""
        THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o de Contagem por Referencia"
        THIS.this_nOptLocal        = 4

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 GrPadVens FROM SigCdPam", ;
                "cursor_4c_SigrecrfPam")

            IF loc_nResult > 0
                SELECT cursor_4c_SigrecrfPam
                IF !EOF()
                    THIS.this_cGrPadVens = ALLTRIM(GrPadVens)
                ENDIF
                USE IN cursor_4c_SigrecrfPam
            ENDIF

            IF EMPTY(THIS.this_cGrPadVens)
                THIS.this_cMensagemErro = "O Grupo Padr" + CHR(227) + "o de Vendedores n" + ;
                    CHR(227) + "o est" + CHR(225) + " configurado nos par" + CHR(226) + ;
                    "metros do sistema. Configure antes de prosseguir."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrfBO.Init")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF !loc_lSucesso
            RETURN .F.
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa queries e monta cursor crRel para REPORT FORM
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult, loc_oErro
        LOCAL loc_cEmpresa, loc_cVends, loc_cCods, loc_cPro, loc_cGrupo, loc_cConta, loc_nLocal
        LOCAL loc_cNomeEmpresa, loc_cTitulo2

        loc_lSucesso = .F.

        TRY
            loc_cVends   = ALLTRIM(THIS.this_cConta)
            loc_nLocal   = THIS.this_nOptLocal
            loc_cCods    = ALLTRIM(THIS.this_cCods)
            loc_cPro     = ALLTRIM(THIS.this_cProduto)
            loc_cGrupo   = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cConta   = ALLTRIM(THIS.this_cCdEstoque)
            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

            *-- Limpar cursores de execucao anterior
            IF USED("csRel")
                USE IN csRel
            ENDIF
            IF USED("crRel")
                USE IN crRel
            ENDIF
            IF USED("crTmpCrf")
                USE IN crTmpCrf
            ENDIF
            IF USED("crSigCdCrf")
                USE IN crSigCdCrf
            ENDIF
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            IF USED("csTotLocal")
                USE IN csTotLocal
            ENDIF

            *-- Validar data (obrigatoria exceto para Diferencas - OptLocal=4)
            IF loc_nLocal <> 4 AND EMPTY(THIS.this_dData)
                THIS.this_cMensagemErro = "Data inv" + CHR(225) + "lida!"
            ELSE

            *-- Montar cabecalho do relatorio
            CREATE CURSOR csCabecalho (NomeEmpresa C(80), Titulo C(200), Titulo2 C(200), Figura C(10))

            loc_cNomeEmpresa = loc_cEmpresa
            loc_cTitulo2     = ""

            IF !EMPTY(go_4c_Sistema.cEmpresa)
                loc_cNomeEmpresa = loc_cEmpresa + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)
            ENDIF

            IF !EMPTY(loc_cVends)
                loc_cTitulo2 = "Vendedor - " + loc_cVends + " " + ALLTRIM(THIS.this_cDConta)
            ENDIF

            INSERT INTO csCabecalho (NomeEmpresa, Titulo, Titulo2) ;
                VALUES (loc_cNomeEmpresa, THIS.this_cTituloRelatorio, loc_cTitulo2)

            *--------------------------------------------------------------
            *-- QUERY 1: Contagens - sigcdcrf JOIN sigcdcri
            *--------------------------------------------------------------
            loc_cWhere = "a.Emps = " + EscaparSQL(loc_cEmpresa)

            IF !EMPTY(THIS.this_dData)
                loc_cWhere = loc_cWhere + ;
                    " And CAST(a.Datas AS DATE) = " + FormatarDataSQL(THIS.this_dData)
            ENDIF
            IF !EMPTY(loc_cCods)
                loc_cWhere = loc_cWhere + " And A.Cods = " + EscaparSQL(loc_cCods)
            ENDIF
            IF !EMPTY(loc_cVends)
                loc_cWhere = loc_cWhere + " And A.Vends = " + EscaparSQL(loc_cVends)
            ENDIF
            IF !EMPTY(loc_cPro)
                loc_cWhere = loc_cWhere + " And b.cpros = " + EscaparSQL(loc_cPro)
            ENDIF
            IF !EMPTY(loc_cGrupo)
                loc_cWhere = loc_cWhere + " And b.grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(loc_cConta)
                loc_cWhere = loc_cWhere + " And b.estos = " + EscaparSQL(loc_cConta)
            ENDIF

            loc_cSQL = "Select a.cods, a.datas, a.vends, a.emps, " + ;
                       "b.cpros, b.grupos, b.estos, b.qtds, b.estoque " + ;
                       "from sigcdcrf a " + ;
                       "join sigcdcri b on a.cods = b.cods " + ;
                       "Where " + loc_cWhere

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCrf")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Tabelas de Contagem por Refer" + CHR(234) + ;
                    "ncia (sigcdcrf/sigcdcri) n" + CHR(227) + "o encontradas ou falha de conex" + ;
                    CHR(227) + "o."
            ELSE

                IF RECCOUNT("crSigCdCrf") = 0
                    THIS.this_cMensagemErro = "Nenhum registro encontrado para os filtros informados."
                ELSE

                    SELECT crSigCdCrf
                    INDEX ON Emps + Grupos + Estos + Cpros TAG Produto
                    GO TOP

                    *--------------------------------------------------------------
                    *-- QUERY 2: Estoque - SigMvEst JOIN SigCdpro/SigCdCli/SigCtCtg
                    *--------------------------------------------------------------
                    loc_cWhere = "a.emps = " + EscaparSQL(loc_cEmpresa)
                    IF !EMPTY(loc_cPro)
                        loc_cWhere = loc_cWhere + " And a.cpros = " + EscaparSQL(loc_cPro)
                    ENDIF
                    IF !EMPTY(loc_cGrupo)
                        loc_cWhere = loc_cWhere + " And a.grupos = " + EscaparSQL(loc_cGrupo)
                    ENDIF
                    IF !EMPTY(loc_cConta)
                        loc_cWhere = loc_cWhere + " And a.estos = " + EscaparSQL(loc_cConta)
                    ENDIF

                    loc_cSQL = "Select a.Emps, a.Grupos, a.Estos, a.cpros, " + ;
                               "sum(sqtds) as qtde, convert(numeric(5,0),0) as QtdCtg, b.dpros as Descr " + ;
                               "From SigMvEst a " + ;
                               "Join SigCdpro b on a.CPros = b.Cpros " + ;
                               "Join SigCdCli c on a.Estos = c.Iclis " + ;
                               "join SigCtCtg d on a.empgruests = d.empresa + d.grupos + d.contas " + ;
                               "Where " + loc_cWhere + ;
                               " And b.cunis = 'UN'" + ;
                               " group by a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros" + ;
                               " Having sum(sqtds) <> 0" + ;
                               " order by a.Emps, a.Grupos, a.Estos, a.cpros"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpCrf")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha ao buscar estoque (crTmpCrf)"
                    ELSE

                        *-- Remover de crTmpCrf itens ausentes em crSigCdCrf
                        SELECT crTmpCrf
                        GO TOP
                        SCAN
                            IF !SEEK(crTmpCrf.Emps + crTmpCrf.Grupos + crTmpCrf.Estos + crTmpCrf.Cpros, ;
                                     "crSigCdCrf", "Produto")
                                DELETE
                            ENDIF
                            SELECT crTmpCrf
                        ENDSCAN

                        *-- Agregar crTmpCrf por produto
                        SELECT crTmpCrf
                        SELECT Emps, grupos, estos, cpros, Sum(Qtde) As Qtds ;
                            From crTmpCrf ;
                            Where NOT DELETED() ;
                            Group By Emps, grupos, estos, cpros ;
                            Into Cursor csTotLocal READWRITE

                        IF RECCOUNT("csTotLocal") = 0
                            THIS.this_cMensagemErro = "Nenhum item de estoque encontrado para os filtros."
                        ELSE

                            SELECT csTotLocal
                            INDEX ON Emps + Grupos + Estos + Cpros TAG Produtos
                            GO TOP

                            *--------------------------------------------------------------
                            *-- Aplicar filtro Localizacoes (OptLocal 1=Todas 2=Lidos 3=NaoLidos 4=Diferencas)
                            *--------------------------------------------------------------
                            DO CASE
                            CASE loc_nLocal = 1
                                SELECT DISTINCT a.DataS, ;
                                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                                    From crTmpCrf b ;
                                    FULL OUTER JOIN crSigCdCrf a ;
                                    On a.emps = b.emps And a.grupos = b.grupos ;
                                    And a.estos = b.estos And a.cpros = b.cpros ;
                                    Into Cursor csRel READWRITE

                            CASE loc_nLocal = 2
                                SELECT DISTINCT a.DataS, ;
                                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                                    From crSigCdCrf a ;
                                    LEFT JOIN crTmpCrf b ;
                                    On a.emps = b.emps And a.grupos = b.grupos ;
                                    And a.estos = b.estos And a.cpros = b.cpros ;
                                    Where NVL(a.Qtds,0) <> 0 ;
                                    Into Cursor csRel READWRITE

                            CASE loc_nLocal = 3
                                SELECT DISTINCT a.DataS, ;
                                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                                    From crTmpCrf b ;
                                    LEFT JOIN crSigCdCrf a ;
                                    On a.emps = b.emps And a.grupos = b.grupos ;
                                    And a.estos = b.estos And a.cpros = b.cpros ;
                                    Where NVL(a.Qtds,0) = 0 ;
                                    Into Cursor csRel READWRITE

                            CASE loc_nLocal = 4
                                SELECT a.DataS, ;
                                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                                    From crTmpCrf b ;
                                    LEFT JOIN crSigCdCrf a ;
                                    On a.emps = b.emps And a.grupos = b.grupos ;
                                    And a.estos = b.estos And a.cpros = b.cpros ;
                                    Where NVL(a.Qtds,0) <> NVL(b.Qtde,0) ;
                                    Into Cursor csRel READWRITE
                            ENDCASE

                            *-- Agregacao final -> crRel (cursor do REPORT FORM)
                            SELECT DataS, Emps, grupos, estos, cpros, Vends, empsest, Descr, ;
                                Sum(Qtds) As Qtds, Sum(Qtde) As Qtde ;
                                From csRel ;
                                Group By DataS, Emps, grupos, estos, cpros, Vends, empsest, Descr ;
                                Into Cursor crRel READWRITE

                            SELECT crRel
                            INDEX ON Vends + Emps + grupos + estos + cpros TAG Locals
                            GO TOP

                            *-- Limpar cursores intermediarios
                            IF USED("csRel")
                                USE IN csRel
                            ENDIF
                            IF USED("csTotLocal")
                                USE IN csTotLocal
                            ENDIF
                            IF USED("crTmpCrf")
                                USE IN crTmpCrf
                            ENDIF
                            IF USED("crSigCdCrf")
                                USE IN crSigCdCrf
                            ENDIF

                            loc_lSucesso = .T.

                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta relatorio para planilha Excel via REPORT FORM XML
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = SYS(5) + CURDIR() + "SigReCrf_" + ;
                               STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO FILE &loc_cArquivo NOPREVIEW NOCONSOLE ASCII
                IF FILE(loc_cArquivo)
                    MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GerarExcel")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarVendedores - Busca lista de vendedores para lookup no form
    * Popula cursor_4c_SigrecrfVends com iclis, rclis, grupos, situas, Cpfs
    * Filtra por GrPadVens, Emps, acesso do usuario (SigCdAcJ)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarVendedores()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigrecrfVends")
                USE IN cursor_4c_SigrecrfVends
            ENDIF

            loc_cSQL = "Select a.iclis, a.rclis, a.grupos, a.situas, a.Cpfs " + ;
                       "From SigCdCli a " + ;
                       "Inner Join SigCdGcr b On a.Grupos = b.Codigos " + ;
                       "And (b.Coletors <> 10 Or (b.Coletors = 10 " + ;
                       "And a.IClis Not In (" + ;
                       "Select Distinct c.Jobs From SigCdAcJ c " + ;
                       "Where c.Jobs Not In (" + ;
                       "Select Distinct d.Jobs From SigCdAcJ d " + ;
                       "Where d.Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                       ")))) " + ;
                       "And a.grupos = " + EscaparSQL(THIS.this_cGrPadVens) + ;
                       " And a.Inativas <> 2" + ;
                       " And a.Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrfVends")
            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar vendedores"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BuscarVendedores")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProduto - Busca produto em SigCdPro para lookup no form
    * par_cFiltro: valor digitado
    * par_cTipo:   "C"=por codigo (cpros), "N"=por descricao (dpros)
    * Popula cursor_4c_SigrecrfPro com cpros, dpros
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProduto(par_cFiltro, par_cTipo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cCampo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigrecrfPro")
                USE IN cursor_4c_SigrecrfPro
            ENDIF

            IF ALLTRIM(par_cTipo) = "C"
                loc_cCampo = "cpros"
            ELSE
                loc_cCampo = "dpros"
            ENDIF

            loc_cSQL = "Select cpros, dpros " + ;
                       "From SigCdPro " + ;
                       "Where " + loc_cCampo + " LIKE " + ;
                       EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                       " Order By dpros"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrfPro")
            IF loc_nResult > 0
                SELECT cursor_4c_SigrecrfPro
                GO TOP
                loc_lSucesso = !EOF()
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar produto"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BuscarProduto")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros default a partir de um cursor de
    * parametros (ex: SigCdPam). Para o relatorio de Contagem por Referencia,
    * o unico parametro persistido eh GrPadVens, usado no lookup de vendedor.
    * Retorna .T. se carregou com sucesso, .F. caso contrario.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + CHR(227) + ;
                                       "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            GO TOP
            IF !EOF()
                IF TYPE("&par_cAliasCursor..GrPadVens") = "C"
                    THIS.this_cGrPadVens = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".GrPadVens"), ""))
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel em BO de relatorio. O relatorio de
    * Contagem por Referencia eh apenas leitura: consulta SigCdCrf/SigCdCrI/
    * SigMvEst e gera preview via REPORT FORM. Retorna .F. para satisfazer
    * contrato de BO e sinalizar que operacao nao se aplica.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Refer" + CHR(234) + "ncia (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel em BO de relatorio. Vide observacao
    * em Inserir(). Retorna .F. e seta this_cMensagemErro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Refer" + CHR(234) + "ncia (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do relatorio (composto por
    * data, empresa, vendedor e filtro de localizacao) para fins de auditoria.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "RELCRF|" + ;
                     IIF(EMPTY(THIS.this_dData), "        ", DTOS(THIS.this_dData)) + "|" + ;
                     ALLTRIM(go_4c_Sistema.cCodEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cConta) + "|" + ;
                     ALLTRIM(THIS.this_cCods) + "|" + ;
                     ALLTRIM(THIS.this_cProduto) + "|" + ;
                     ALLTRIM(THIS.this_cCdGrEstoque) + "|" + ;
                     ALLTRIM(THIS.this_cCdEstoque) + "|" + ;
                     TRANSFORM(THIS.this_nOptLocal)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crRel")
            USE IN crRel
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        IF USED("cursor_4c_SigrecrfVends")
            USE IN cursor_4c_SigrecrfVends
        ENDIF
        IF USED("cursor_4c_SigrecrfPro")
            USE IN cursor_4c_SigrecrfPro
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

