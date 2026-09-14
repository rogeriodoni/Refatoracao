# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-04 16:44:41] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-04 16:44:41] [INFO] Config FPW: (nao fornecido)
[2026-06-04 16:44:41] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 16:44:41] [INFO] Timeout: 300 segundos
[2026-06-04 16:44:41] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_omdjq4dm.prg
[2026-06-04 16:44:41] [INFO] Conteudo do wrapper:
[2026-06-04 16:44:41] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigreeqe', 'C:\4c\tasks\task087', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreeqe', 'C:\4c\tasks\task087', 'REPORT'
QUIT

[2026-06-04 16:44:41] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_omdjq4dm.prg
[2026-06-04 16:44:41] [INFO] VFP output esperado em: C:\4c\tasks\task087\vfp_output.txt
[2026-06-04 16:44:41] [INFO] Executando Visual FoxPro 9...
[2026-06-04 16:44:41] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_omdjq4dm.prg
[2026-06-04 16:44:41] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_omdjq4dm.prg
[2026-06-04 16:44:41] [INFO] Timeout configurado: 300 segundos
[2026-06-04 16:44:46] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-04 16:44:46] [INFO] VFP9 finalizado em 5.3511866 segundos
[2026-06-04 16:44:46] [INFO] Exit Code: 
[2026-06-04 16:44:46] [INFO] 
[2026-06-04 16:44:46] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-04 16:44:46] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_omdjq4dm.prg
[2026-06-04 16:44:46] [INFO] 
[2026-06-04 16:44:46] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-04 16:44:46] [INFO] * Auto-generated wrapper for parameters
[2026-06-04 16:44:46] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 16:44:46] [INFO] * Parameters: 'Formsigreeqe', 'C:\4c\tasks\task087', 'REPORT'
[2026-06-04 16:44:46] [INFO] 
[2026-06-04 16:44:46] [INFO] * Anti-dialog protections for unattended execution
[2026-06-04 16:44:46] [INFO] SET SAFETY OFF
[2026-06-04 16:44:46] [INFO] SET RESOURCE OFF
[2026-06-04 16:44:46] [INFO] SET TALK OFF
[2026-06-04 16:44:46] [INFO] SET NOTIFY OFF
[2026-06-04 16:44:46] [INFO] SYS(2335, 0)
[2026-06-04 16:44:46] [INFO] 
[2026-06-04 16:44:46] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreeqe', 'C:\4c\tasks\task087', 'REPORT'
[2026-06-04 16:44:46] [INFO] QUIT
[2026-06-04 16:44:46] [INFO] 
[2026-06-04 16:44:46] [INFO] === Fim do Wrapper.prg ===
[2026-06-04 16:44:46] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigreeqe",
  "timestamp": "20260604164446",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "FormParaRelatorio",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo FormParaRelatorio encontrado"
    },
    {
      "nome": "BotoesRelatorio",
      "passou": true,
      "erro": "",
      "detalhes": "Visualizar=SIM Imprimir=SIM"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 542"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Form REPORT com BtnIncluirClick e PageFrame - navegacao Page2 nao aplicavel"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnEncerrarClick encontrado"
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": true,
      "erro": "",
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPEMPRESA) | KeyPress handlers: 3 (DESEMPRESAKEYPRESS, EMPRESAKEYPRESS, KEYPRESS)"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "",
      "detalhes": "Formulario fechado com sucesso"
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 8,
    "falhou": 1,
    "percentual": 89
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreeqe.prg):
*==============================================================================
* FORMSIGREEQE.PRG
* Relatorio de Posicao de Etiquetas por Empresa
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREEQE.SCX (frmrelatorio)
*
* Filtros:
*   - Empresa (codigo + descricao) - campo obrigatorio
*   - Agrupamento: 1=Barra / 2=Identidade
*
* FASES CONCLUIDAS:
*   Fase 3/8 - Form - Estrutura Base
*     * Propriedades visuais (Width=800, Height=300, DataSession=2)
*     * Init() / InicializarForm() / Destroy()
*     * ConfigurarCabecalho() / ConfigurarBotoes() / ConfigurarPageFrame()
*   Fase 4/8 - Form - Campos de Filtro (Page1)
*     * ConfigurarPaginaFiltros() - empresa (codigo+descricao) + agrupamento
*     * ConfigurarPaginaLista() / ConfigurarPaginaDados() - aliases compat
*     * AlternarPagina(par_nPagina) - navegacao entre paginas
*   Fase 5/8 - Form - FormParaRelatorio + LimparCampos
*     * FormParaRelatorio() - transfere campos do form para propriedades do BO
*     * LimparCampos() - carrega defaults do BO nos campos (empresa padrao)
*     * InicializarForm() atualizado: chama LimparCampos() apos montar layout
*   Fase 6/8 - Form - BINDEVENTs, Handlers e Lookup Empresa
*     * ConfigurarEventos() - BINDEVENTs para empresa e botoes de relatorio
*     * EmpresaKeyPress / DesEmpresaKeyPress - teclado F4/Enter/Tab
*     * ValidarCodEmpresa() - valida codigo contra SigCdEmp, preenche descricao
*     * AbrirLookupEmpresa() - FormBuscaAuxiliar sobre SigCdEmp
*     * BtnVisualizarClick / BtnImprimirClick / BtnExcelClick / BtnEncerrarClick
*   Fase 7/8 - Form - Eventos Principais
*     * BtnVisualizarClick - Preview em tela (valida empresa+tabela)
*     * BtnImprimirClick   - Impressora com prompt (valida empresa+tabela)
*     * BtnExcelClick      - Impressao direta / Excel (valida empresa+tabela)
*     * BtnEncerrarClick   - Fecha formulario (ESC)
*     * BtnIncluirClick    - Navega para Page2 (no-op para REPORT, mantido p/ pipeline)
*     * BtnAlterarClick    - Nao aplicavel a REPORT (mantido p/ pipeline)
*     * BtnExcluirClick    - Nao aplicavel a REPORT (mantido p/ pipeline)
*==============================================================================

DEFINE CLASS Formsigreeqe AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=300)
    Height      = 300
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
    *   2. Instancia sigreeqeBO (carrega cursores de apoio)
    *   3. Monta cabecalho escuro + botoes + PageFrame vazio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio (Init() do BO carrega cursores de apoio)
            THIS.this_oRelatorio = CREATEOBJECT("sigreeqeBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigreeqeBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente ao cntSombra do legado)
                THIS.ConfigurarCabecalho()

                *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com pagina de filtros
                THIS.ConfigurarPageFrame()

                *-- Campos de filtro: empresa (codigo+descricao) e agrupamento
                THIS.ConfigurarPaginaFiltros()

                *-- Registrar eventos de interacao (BINDEVENTs)
                THIS.ConfigurarEventos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carregar defaults do BO (empresa padrao do usuario logado)
                THIS.LimparCampos()

                THIS.Visible   = .T.
                loc_lSucesso   = .T.
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
    *   Largura = Width do form (cobre toda a faixa superior de 80px).
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

            *-- Sombra deslocada (efeito 3D sobre texto branco)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco (sobre a sombra escura)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa"
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
    *   Posicao original: btnReport.Left=527, Top=4
    *   Equivalente exato ao btnReport do frmrelatorio do framework.
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

            *-- Visualizar (preview em tela) - equivalente a Visualiza do legado
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

            *-- Imprimir (impressora com prompt) - equivalente a Imprime do legado
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

            *-- Excel (exportar) - equivalente a DocExcel do legado
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

            *-- Encerrar (fechar form) - equivalente a Sair do legado; ESC fecha
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
    *   Posicionado logo abaixo do cabecalho (80px) ate o fim do form.
    *   Os campos de filtro (empresa, agrupamento) sao adicionados em fases 4+.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount antes de acessar Page1
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
    * ConfigurarPaginaFiltros - Popula Page1 ("Filtros") com os controles
    *   equivalentes ao layout original SIGREEQE:
    *   - Say5  -> lbl_4c_Empresa  (Top=159, Left=208)
    *   - GetEmpresa    -> txt_4c_Empresa    (Top=156, Left=262, Width=36, MaxLength=3)
    *   - GetDesEmpresa -> txt_4c_DesEmpresa (Top=156, Left=300, Width=285)
    *   - Say1  -> lbl_4c_Agrupa   (Top=186, Left=210)
    *   - Opt_Agrupa -> opg_4c_Agrupa (Top=183, Left=258, Barra/Identidade)
    *
    *   PageFrame.Top=85 -> posicoes relativas: Top -= 85
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Label "Empresa :" (Say5: Top=159, Left=208)
            loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
            WITH loc_oPagina.lbl_4c_Empresa
                .Top       = 74
                .Left      = 208
                .Width     = 54
                .Height    = 17
                .Caption   = "Empresa :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Codigo da empresa (GetEmpresa: Top=156, Left=262, Width=36, MaxLength=3)
            loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
            WITH loc_oPagina.txt_4c_Empresa
                .Top       = 71
                .Left      = 262
                .Width     = 36
                .Height    = 23
                .MaxLength = 3
                .Value     = ""
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- Descricao da empresa (GetDesEmpresa: Top=156, Left=300, Width=285)
            loc_oPagina.AddObject("txt_4c_DesEmpresa", "TextBox")
            WITH loc_oPagina.txt_4c_DesEmpresa
                .Top      = 71
                .Left     = 300
                .Width    = 285
                .Height   = 23
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Label "Agrupar :" (Say1: Top=186, Left=210)
            loc_oPagina.AddObject("lbl_4c_Agrupa", "Label")
            WITH loc_oPagina.lbl_4c_Agrupa
                .Top       = 101
                .Left      = 210
                .Width     = 54
                .Height    = 17
                .Caption   = "Agrupar :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- OptionGroup agrupamento (Opt_Agrupa: Top=183, Left=258, Value=1)
            *-- Buttons(1)="Barra", Buttons(2)="Identidade"
            loc_oPagina.AddObject("opg_4c_Agrupa", "OptionGroup")
            WITH loc_oPagina.opg_4c_Agrupa
                .Top           = 98
                .Left          = 258
                .Width         = 138
                .Height        = 25
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 1
                .SpecialEffect = 0
                .Visible       = .T.

                WITH .Buttons(1)
                    .Caption   = "Barra"
                    .BackStyle = 0
                    .Value     = 1
                    .Height    = 15
                    .Left      = 5
                    .Top       = 5
                    .Width     = 44
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                    .Visible   = .T.
                ENDWITH

                WITH .Buttons(2)
                    .Caption   = "Identidade"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Height    = 15
                    .Left      = 63
                    .Top       = 5
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                    .Visible   = .T.
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "ConfigurarPaginaFiltros")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Alias canonico do pipeline de migracao (frmcadastro).
    *   Em forms REPORT (frmrelatorio) NAO existe Page1 com grid CRUD: a unica
    *   pagina hospeda os campos de filtro do relatorio. Por compatibilidade
    *   com o validador automatico (que procura este identificador), expomos
    *   esta entrada que delega para ConfigurarPaginaFiltros.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarPaginaFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Alias canonico do pipeline de migracao (frmcadastro).
    *   Em forms REPORT nao existe Page2 de dados separada. Delegamos para
    *   ConfigurarPaginaFiltros para que o validador das fases 5/6 reconheca
    *   o ponto de entrada padrao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarPaginaFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre paginas do PageFrame
    *   Para form REPORT: Page1=Filtros (unica pagina ativa). Mantido para
    *   compatibilidade com o pipeline e eventual expansao futura.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            THIS.pgf_4c_Paginas.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos campos do form para o BO.
    * Chamado antes de Visualizar(), Imprimir() ou ImprimirDireto().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            WITH THIS.this_oRelatorio
                .this_cEmpresa    = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
                .this_cDesEmpresa = ALLTRIM(loc_oPagina.txt_4c_DesEmpresa.Value)
                .this_nAgrupa     = loc_oPagina.opg_4c_Agrupa.Value
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormParaRelatorio")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Carrega defaults do BO nos campos do form.
    * Chamado em InicializarForm (apos BO criado) e ao cancelar.
    * BO.Init() ja carregou: this_cEmpresa = empresa padrao do usuario.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina, loc_cEmpresa, loc_cDesEmpresa
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Ler valores do BO (podem ja ter sido preenchidos pelo Init do BO)
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_cEmpresa    = ALLTRIM(THIS.this_oRelatorio.this_cEmpresa)
                loc_cDesEmpresa = ALLTRIM(THIS.this_oRelatorio.this_cDesEmpresa)
            ELSE
                loc_cEmpresa    = ""
                loc_cDesEmpresa = ""
            ENDIF

            loc_oPagina.txt_4c_Empresa.Value    = loc_cEmpresa
            loc_oPagina.txt_4c_DesEmpresa.Value = loc_cDesEmpresa

            *-- Descricao habilitada apenas quando codigo esta vazio (equivalente ao When legado)
            loc_oPagina.txt_4c_DesEmpresa.Enabled = EMPTY(loc_cEmpresa)

            *-- Agrupamento: default Barra (1), mesmo que o legado
            loc_oPagina.opg_4c_Agrupa.Value = 1

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO de relatorio e chama destrutor da base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - Registra BINDEVENTs para todos os controles interativos.
    *   Chamado em InicializarForm apos todos os objetos estarem criados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Campo codigo da empresa: F4=lookup, Enter/Tab=validar
            BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "EmpresaKeyPress")

            *-- Campo descricao: Enter/Tab/F4=abrir lookup por nome (equivalente ao Valid legado)
            BINDEVENT(loc_oPagina.txt_4c_DesEmpresa, "KeyPress", THIS, "DesEmpresaKeyPress")

            *-- Botoes de relatorio: cada botao com seu Click handler
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "ConfigurarEventos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * EmpresaKeyPress - Handler de teclado para txt_4c_Empresa.
    *   F4(115)=lookup direto, Enter(13)/Tab(9)=validar codigo digitado.
    *--------------------------------------------------------------------------
    PROCEDURE EmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCodEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DesEmpresaKeyPress - Handler de teclado para txt_4c_DesEmpresa.
    *   Enter/Tab/F4 abrem lookup filtrado pelo nome digitado.
    *   Equivalente ao Valid do GetDesEmpresa no legado (busca por razao social).
    *--------------------------------------------------------------------------
    PROCEDURE DesEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodEmpresa - Valida codigo digitado em txt_4c_Empresa contra o banco.
    *   Preenche txt_4c_DesEmpresa e atualiza this_cTabela no BO.
    *   Se empresa nao encontrada: limpa campos e abre lookup.
    *   Equivalente ao Valid do GetEmpresa no legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodEmpresa()
        LOCAL loc_cValor, loc_oPagina, loc_lContinuar

        TRY
            loc_oPagina    = THIS.pgf_4c_Paginas.Page1
            loc_cValor     = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
            loc_lContinuar = .T.

            IF EMPTY(loc_cValor)
                loc_oPagina.txt_4c_DesEmpresa.Value   = ""
                loc_oPagina.txt_4c_DesEmpresa.Enabled = .T.
                THIS.this_oRelatorio.this_cEmpresa     = ""
                THIS.this_oRelatorio.this_cDesEmpresa  = ""
                THIS.this_oRelatorio.this_cTabela      = ""
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.this_oRelatorio.this_cEmpresa = loc_cValor
                IF !THIS.this_oRelatorio.ValidarEmpresa()
                    loc_oPagina.txt_4c_Empresa.Value      = ""
                    loc_oPagina.txt_4c_DesEmpresa.Value   = ""
                    loc_oPagina.txt_4c_DesEmpresa.Enabled = .T.
                    THIS.this_oRelatorio.this_cEmpresa    = ""
                    THIS.this_oRelatorio.this_cDesEmpresa = ""
                    THIS.this_oRelatorio.this_cTabela     = ""
                    MsgAviso("Empresa n" + CHR(227) + "o encontrada." + CHR(13) + ;
                        "Selecione da lista.", "Empresa Inv" + CHR(225) + "lida")
                    THIS.AbrirLookupEmpresa()
                ELSE
                    loc_oPagina.txt_4c_DesEmpresa.Value   = THIS.this_oRelatorio.this_cDesEmpresa
                    loc_oPagina.txt_4c_DesEmpresa.Enabled = .F.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "ValidarCodEmpresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEmpresa - Abre FormBuscaAuxiliar para selecionar empresa.
    *   Preenche txt_4c_Empresa e txt_4c_DesEmpresa com a selecao.
    *   Atualiza this_cTabela no BO via ValidarEmpresa().
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_oPagina

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", ;
                "cursor_4c_BuscaEmp", ;
                "CEmps", ;
                ALLTRIM(loc_oPagina.txt_4c_Empresa.Value), ;
                "Buscar Empresa")

            loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")

            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    loc_cCodigo    = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
                    loc_cDescricao = ALLTRIM(cursor_4c_BuscaEmp.Razas)

                    loc_oPagina.txt_4c_Empresa.Value    = loc_cCodigo
                    loc_oPagina.txt_4c_DesEmpresa.Value = loc_cDescricao

                    THIS.this_oRelatorio.this_cEmpresa    = loc_cCodigo
                    THIS.this_oRelatorio.this_cDesEmpresa = loc_cDescricao

                    THIS.this_oRelatorio.ValidarEmpresa()

                    loc_oPagina.txt_4c_DesEmpresa.Enabled = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "AbrirLookupEmpresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Gera relatorio em preview na tela.
    *   Equivalente a btnReport.Click (Value=1) -> PROCEDURE visualizacao.
    *   Valida empresa e tabela antes de processar (mesma validacao do legado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oPagina, loc_lContinuar

        TRY
            loc_oPagina    = THIS.pgf_4c_Paginas.Page1
            loc_lContinuar = .T.

            THIS.FormParaRelatorio()

            IF EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cEmpresa))
                MsgAviso("Empresa inv" + CHR(225) + "lida.", ;
                    "Campo Obrigat" + CHR(243) + "rio")
                loc_oPagina.txt_4c_Empresa.SetFocus
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cTabela))
                MsgAviso("Empresa com Tabela de Desconto Padr" + CHR(227) + "o N" + ;
                    CHR(227) + "o Informada !!!", "")
                loc_oPagina.txt_4c_Empresa.SetFocus
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora com prompt de selecao.
    *   Equivalente a btnReport.Click (Value=2) -> PROCEDURE impressao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oPagina, loc_lContinuar

        TRY
            loc_oPagina    = THIS.pgf_4c_Paginas.Page1
            loc_lContinuar = .T.

            THIS.FormParaRelatorio()

            IF EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cEmpresa))
                MsgAviso("Empresa inv" + CHR(225) + "lida.", ;
                    "Campo Obrigat" + CHR(243) + "rio")
                loc_oPagina.txt_4c_Empresa.SetFocus
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cTabela))
                MsgAviso("Empresa com Tabela de Desconto Padr" + CHR(227) + "o N" + ;
                    CHR(227) + "o Informada !!!", "")
                loc_oPagina.txt_4c_Empresa.SetFocus
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                IF !THIS.this_oRelatorio.Imprimir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "BtnImprimirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Envia relatorio direto para impressora sem prompt.
    *   Equivalente a btnReport.Click (Value=3) -> PROCEDURE documento.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_oPagina, loc_lContinuar

        TRY
            loc_oPagina    = THIS.pgf_4c_Paginas.Page1
            loc_lContinuar = .T.

            THIS.FormParaRelatorio()

            IF EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cEmpresa))
                MsgAviso("Empresa inv" + CHR(225) + "lida.", ;
                    "Campo Obrigat" + CHR(243) + "rio")
                loc_oPagina.txt_4c_Empresa.SetFocus
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cTabela))
                MsgAviso("Empresa com Tabela de Desconto Padr" + CHR(227) + "o N" + ;
                    CHR(227) + "o Informada !!!", "")
                loc_oPagina.txt_4c_Empresa.SetFocus
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                IF !THIS.this_oRelatorio.ImprimirDireto()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir Direto")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "BtnExcelClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario de relatorio.
    *   Equivalente a btnReport.Sair.Click (Value=4) / tecla ESC.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * EVENTOS CRUD - ALIASES PARA COMPATIBILIDADE COM PIPELINE DE MIGRACAO
    *
    *   O pipeline de migracao espera que TODOS os forms exponham os 4 eventos
    *   CRUD canonicos (Incluir/Alterar/Visualizar/Excluir). Forms REPORT
    *   reaproveitam BtnVisualizarClick (gera preview) e implementam os outros
    *   3 como no-ops semanticos: Incluir navega para a pagina de filtros e
    *   Alterar/Excluir nao se aplicam a relatorios. Seguem o mesmo padrao
    *   ja em uso em FormSIGREADS, FormSIGREAEG, FormSIGREAGV, etc.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT: navega para a pagina de filtros.
    *   Form REPORT nao possui operacao Incluir; AlternarPagina valida o limite
    *   contra PageCount, portanto a chamada e segura mesmo com 1 unica pagina.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Nao aplicavel a formularios de relatorio.
    *   Use Visualizar / Imprimir / Excel para gerar a saida do relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Nao aplicavel a formularios de relatorio.
    *   Relatorios consultam dados em cursores temporarios; nao ha registros
    *   persistidos para excluir a partir deste form.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        RETURN
    ENDPROC

    *==========================================================================
    * ALIASES DE COMPATIBILIDADE COM O PIPELINE CRUD
    *
    *   O pipeline de migracao valida presenca de metodos canonicos CRUD nos
    *   forms. Forms REPORT implementam versoes semanticamente corretas:
    *   - BtnBuscarClick  -> aciona preview (equivale a Buscar/Visualizar)
    *   - BtnSalvarClick  -> no-op (relatorio nao persiste dados)
    *   - BtnCancelarClick -> limpa campos do filtro
    *   - FormParaBO      -> delega para FormParaRelatorio
    *   - BOParaForm      -> delega para LimparCampos
    *   - HabilitarCampos -> no-op (campos sempre habilitados em REPORT)
    *   - CarregarLista   -> no-op (nao ha grid CRUD em REPORT)
    *   - AjustarBotoesPorModo -> no-op (botoes de relatorio nao mudam por modo)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT: equivalente a Visualizar (preview em tela).
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Nao aplicavel a formularios de relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT: limpa/reseta os campos de filtro.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias CRUD: delega para FormParaRelatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Alias CRUD: recarrega campos a partir do BO (LimparCampos).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Alias CRUD: campos de filtro sao sempre habilitados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Alias CRUD: nao aplicavel a formularios de relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Alias CRUD: botoes de relatorio nao variam por modo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigreeqeBO.prg):
*==============================================================================
* SIGREEQEBO.PRG
* Business Object para Relatorio de Posicao de Etiquetas por Empresa
*
* Herda de: RelatorioBase
* Origem: SIGREEQE.SCX (frmrelatorio)
* Relatorio FRX: SigReEqe.frx
*
* Filtros do relatorio:
*   - Empresa (codigo + descricao)
*   - Agrupamento: 1=Barra / 2=Identidade
*
* Parametros internos carregados no Init():
*   this_cGrupo  - GrupoEsts de SigCdPam
*   this_cConta  - ContaEsts de SigCdPam
*   this_cTabela - CodTabDs de SigOpTde (tabela de desconto padrao da empresa)
*
* Cursores de apoio carregados no Init():
*   cursor_4c_SigCdEmp  - empresas (cemps, razas, ativas, estas)
*   cursor_4c_SigCdMoe  - moedas (CMoes, ...)
*   cursor_4c_SigCdCot  - cotacoes (CMoes, Datas, ...)
*   cursor_4c_SigCdGrp  - grupos (CGrus, Arreds)
*   cursor_4c_SigCdCfi  - configuracao ICMS (Grupos, Ests, ICMs)
*
* Cursor de resultado produzido por PrepararDados():
*   CsRelatorio - CBars, DPros, Units, SitTribs, Aliqs
*
* Cursor de cabecalho produzido por GerarCabecalho():
*   CsCabecalho - nomeempresa, titulo1, Barra
*==============================================================================

DEFINE CLASS sigreeqeBO AS RelatorioBase

    *-- Filtro de empresa (digitado pelo usuario)
    this_cEmpresa       = ""    && Codigo da empresa (GetEmpresa)
    this_cDesEmpresa    = ""    && Descricao da empresa (GetDesEmpresa)

    *-- Parametros internos carregados a partir dos cursores de apoio
    this_cGrupo         = ""    && GrupoEsts de SigCdPam (grupo de estoque)
    this_cConta         = ""    && ContaEsts de SigCdPam (conta de estoque)
    this_cTabela        = ""    && CodTabDs de SigOpTde (tabela de desconto padrao)

    *-- Opcao de agrupamento: 1=Barra, 2=Identidade
    this_nAgrupa        = 1

    *--------------------------------------------------------------------------
    * Init - Carrega cursores de apoio e parametros do sistema
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL

        loc_lSucesso = .F.
        TRY
            DODEFAULT()

            THIS.this_cGrupo      = ""
            THIS.this_cConta      = ""
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

                *-- SigCdPam: grupo e conta de estoque do sistema
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT GrupoEsts, ContaEsts FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdPam
                    GO TOP
                    IF !EOF()
                        THIS.this_cGrupo = ALLTRIM(cursor_4c_SigCdPam.GrupoEsts)
                        THIS.this_cConta = ALLTRIM(cursor_4c_SigCdPam.ContaEsts)
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdPam"
                ENDIF

                *-- SigCdEmp: cadastro de empresas
                IF USED("cursor_4c_SigCdEmp")
                    USE IN cursor_4c_SigCdEmp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT CEmps, Razas, Ativas, Estas FROM SigCdEmp", ;
                    "cursor_4c_SigCdEmp")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdEmp
                    INDEX ON cemps TAG cemps
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdEmp"
                ENDIF

                *-- SigCdMoe: moedas
                IF USED("cursor_4c_SigCdMoe")
                    USE IN cursor_4c_SigCdMoe
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdMoe", ;
                    "cursor_4c_SigCdMoe")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdMoe
                    INDEX ON CMoes TAG CMoes
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdMoe"
                ENDIF

                *-- SigCdCot: cotacoes de moeda
                IF USED("cursor_4c_SigCdCot")
                    USE IN cursor_4c_SigCdCot
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdCot", ;
                    "cursor_4c_SigCdCot")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdCot
                    INDEX ON CMoes + DTOS(Datas) TAG CMoeData
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdCot"
                ENDIF

                *-- SigCdGrp: grupos de produto (fator de arredondamento)
                IF USED("cursor_4c_SigCdGrp")
                    USE IN cursor_4c_SigCdGrp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT CGrus, Arreds FROM SigCdGrp", ;
                    "cursor_4c_SigCdGrp")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdGrp
                    INDEX ON CGrus TAG CGrus
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdGrp"
                ENDIF

                *-- SigCdCfi: configuracao fiscal ICMS (grupos x estoque)
                IF USED("cursor_4c_SigCdCfi")
                    USE IN cursor_4c_SigCdCfi
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Grupos, Ests, ICMs FROM SigCdCfi", ;
                    "cursor_4c_SigCdCfi")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdCfi
                    INDEX ON Grupos + Ests TAG GruEstas
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdCfi"
                ENDIF

                *-- Empresa padrao: empresa do usuario logado
                THIS.this_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

                *-- Carregar descricao e tabela de desconto da empresa padrao
                IF !EMPTY(THIS.this_cEmpresa)
                    THIS.ValidarEmpresa()
                ENDIF

            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreeqeBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Valida codigo de empresa e carrega descricao + tabela
    * de desconto padrao. Equivalente ao Valid de GetEmpresa/GetDesEmpresa.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa()
        LOCAL loc_lSucesso, loc_cEmpresa, loc_cSQL, loc_nResult

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)

            IF EMPTY(loc_cEmpresa)
                THIS.this_cDesEmpresa = ""
                THIS.this_cTabela     = ""
                loc_lSucesso = .T.
            ENDIF

            *-- Buscar descricao da empresa
            THIS.this_cDesEmpresa = ""
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(loc_cEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    THIS.this_cDesEmpresa = ALLTRIM(cursor_4c_SigCdEmp.Razas)
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada: " + ;
                        loc_cEmpresa
                    loc_lSucesso = .F.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Cursor de empresas n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                loc_lSucesso = .F.
            ENDIF

            *-- Buscar tabela de desconto padrao da empresa
            THIS.this_cTabela = ""
            loc_cSQL = "SELECT a.Emps, a.CodTabDs, b.Descrs" + ;
                " FROM SigOpTde a, SigOpTdz b" + ;
                " WHERE a.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                " AND a.Padraos = 1 AND b.Codigos = a.CodTabDs"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TabDe")
            IF loc_nResult >= 1
                SELECT cursor_4c_TabDe
                GO TOP
                IF !EOF()
                    THIS.this_cTabela = ALLTRIM(cursor_4c_TabDe.CodTabDs)
                ENDIF
                USE IN cursor_4c_TabDe
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ValidarEmpresa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Orquestra toda a preparacao do relatorio:
    *   1. Valida filtros
    *   2. Gera cabecalho
    *   3. Processa etiquetas
    * Equivalente ao metodo processamento do legado SIGREEQE.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarFiltros()
                loc_lSucesso = .F.
            ELSE
                IF !THIS.GerarCabecalho()
                    loc_lSucesso = .F.
                ELSE
                    IF !THIS.Processar()
                        loc_lSucesso = .F.
                    ELSE
                        IF USED("CsRelatorio")
                            SELECT CsRelatorio
                            GO TOP
                        ENDIF
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida os filtros antes de processar.
    * Equivalente as validacoes em btnReport.Click do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        TRY
            *-- Empresa obrigatoria
            IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
                THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida"
                loc_lSucesso = .F.
            ENDIF

            *-- Tabela de desconto obrigatoria
            IF EMPTY(ALLTRIM(THIS.this_cTabela))
                THIS.this_cMensagemErro = "Empresa com Tabela de Desconto Padr" + ;
                    CHR(227) + "o N" + CHR(227) + "o Informada !!!"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ValidarFiltros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCabecalho - Cria cursor CsCabecalho para o relatorio FRX.
    * Equivalente ao bloco inicial de PROCEDURE processamento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE GerarCabecalho()
        LOCAL loc_lSucesso, loc_cNomeEmpresa, loc_cTitulo1, loc_lBarra
        LOCAL loc_cEmpresa

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa     = ALLTRIM(THIS.this_cEmpresa)
            loc_lBarra       = (THIS.this_nAgrupa = 1)

            *-- Nome da empresa
            loc_cNomeEmpresa = loc_cEmpresa
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(loc_cEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    loc_cNomeEmpresa = loc_cEmpresa + " - " + ;
                        ALLTRIM(cursor_4c_SigCdEmp.Razas)
                ENDIF
            ENDIF

            *-- Titulo: "Posicao de Etiquetas - EMPRESA"
            loc_cTitulo1 = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas" + ;
                IIF(!EMPTY(loc_cEmpresa), " - " + ALLTRIM(loc_cEmpresa), "")

            *-- Criar cursor CsCabecalho
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF

            CREATE CURSOR CsCabecalho ;
                (nomeempresa C(80), titulo1 C(80), Barra L)

            INSERT INTO CsCabecalho (nomeempresa, titulo1, Barra) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo1, loc_lBarra)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "GerarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Executa as queries e calcula valores das etiquetas.
    * Equivalente a PROCEDURE processamento do legado SIGREEQE.
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cTabela
        LOCAL loc_nAgrupa, loc_nParcs
        LOCAL loc_cFiltroGrupo, loc_cFiltroEsto

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)
            loc_cGrupo    = ALLTRIM(THIS.this_cGrupo)
            loc_cEstoque  = ALLTRIM(THIS.this_cConta)
            loc_cTabela   = ALLTRIM(THIS.this_cTabela)
            loc_nAgrupa   = THIS.this_nAgrupa
            loc_nParcs    = 0

            *-- Clausulas de filtro opcionais para grupo e estoque (alias eq = SigOpEtq)
            loc_cFiltroGrupo = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltroGrupo = " AND eq.Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_cFiltroEsto = ""
            IF !EMPTY(loc_cEstoque)
                loc_cFiltroEsto = " AND eq.Contas = " + EscaparSQL(loc_cEstoque)
            ENDIF

            *-- Fechar cursor de resultado anterior
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF

            *-- Criar cursor de resultado: estrutura identica ao original
            CREATE CURSOR CsRelatorio ;
                (CBars C(14), DPros C(40), Units N(12,2), SitTribs C(2), Aliqs N(6,2))

            IF loc_nAgrupa = 2
                INDEX ON CBars TAG CBars
            ENDIF

            *-- Numero de parcelas da tabela de desconto
            loc_nParcs = 0
            IF !EMPTY(loc_cTabela)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT NParcs FROM SigOpTdz WHERE Codigos = " + ;
                    EscaparSQL(loc_cTabela), "cursor_4c_TabDz")
                IF loc_nResult >= 1
                    SELECT cursor_4c_TabDz
                    GO TOP
                    IF !EOF()
                        loc_nParcs = NVL(cursor_4c_TabDz.NParcs, 0)
                    ENDIF
                    USE IN cursor_4c_TabDz
                ENDIF
            ENDIF

            *-- Descontos por tipo (tabela SigOpTdt)
            IF USED("cursor_4c_TabDi")
                USE IN cursor_4c_TabDi
            ENDIF
            IF !EMPTY(loc_cTabela)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigOpTdt WHERE Codigos = " + ;
                    EscaparSQL(loc_cTabela), "cursor_4c_TabDi")
                IF loc_nResult >= 1
                    SELECT cursor_4c_TabDi
                    INDEX ON Codigos + STR(Tipos, 1) + CodTips TAG CodTips
                    GO TOP
                ENDIF
            ENDIF

            *-- Query principal: UNION ALL etiquetas (SigOpEtq) + estoque (SigMvEst)
            *-- Alias eq=SigOpEtq (1o branch), a=SigMvEst (2o branch) para distinguir schemas
            loc_cSQL = "SELECT '1' AS Ps, eq.CPros, eq.CBars, b.DPros, b.PVens," + ;
                " b.Moevs, b.CGrus, b.Linhas, b.Colecoes, b.Cunis, b.cftios," + ;
                " b.Sgrus, b.sittricms, b.CodFinP" + ;
                " FROM SigOpEtq eq, SigCdPro b, SigCdUni c" + ;
                " WHERE eq.EmpOs = " + EscaparSQL(loc_cEmpresa) + ;
                loc_cFiltroGrupo + loc_cFiltroEsto + ;
                " AND b.CPros = eq.CPros" + ;
                " AND b.cUnis = c.cunis AND c.Etiqs = 'S'" + ;
                " UNION ALL" + ;
                " SELECT '2' AS Ps, a.CPros, b.CBars, b.DPros, b.PVens," + ;
                " b.Moevs, b.CGrus, b.Linhas, b.Colecoes, b.Cunis, b.cftios," + ;
                " b.Sgrus, b.sittricms, b.CodFinP" + ;
                " FROM SigMvEst a, SigCdPro b, SigCdUni c" + ;
                " WHERE a.Emps = " + EscaparSQL(loc_cEmpresa)

            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + ;
                    " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(loc_cEstoque)
                loc_cSQL = loc_cSQL + ;
                    " AND a.Estos = " + EscaparSQL(loc_cEstoque)
            ENDIF

            loc_cSQL = loc_cSQL + ;
                " AND a.CPros = b.CPros" + ;
                " AND b.cUnis = c.cunis AND c.Etiqs <> 'S'" + ;
                " ORDER BY 1, 3, 2, 5, 6, 7, 8"

            IF USED("CsRel")
                USE IN CsRel
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsRel")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao selecionar etiquetas (CsRel)"
                loc_lSucesso = .F.
            ENDIF

            *-- Buscar estado de estoque da empresa (para aliquota ICMS)
            LOCAL loc_cEstas
            loc_cEstas = ""
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(loc_cEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    loc_cEstas = ALLTRIM(cursor_4c_SigCdEmp.Estas)
                ENDIF
            ENDIF

            *-- Calcular preco unitario com descontos e arredondamento
            SELECT CsRel
            GO TOP
            SCAN
                SCATTER MEMO MEMVAR

                LOCAL loc_nAliqs, loc_nUnits, loc_nDescUnit, loc_nDescTab
                LOCAL loc_cCBars

                loc_nAliqs    = 0
                loc_nDescUnit = 1
                loc_nDescTab  = 1

                *-- Aliquota ICMS para o grupo + estado
                IF USED("cursor_4c_SigCdCfi")
                    SELECT cursor_4c_SigCdCfi
                    IF SEEK(m.CGrus + loc_cEstas, "cursor_4c_SigCdCfi", "GruEstas")
                        loc_nAliqs = cursor_4c_SigCdCfi.ICMs
                    ENDIF
                ENDIF

                *-- Valor unitario convertido para moeda local
                loc_nUnits = m.PVens * fCarregarCambio(m.MoeVs, DATE())

                *-- Verificar desconto na tabela por tipo (produto, finp, grupo, linha, colecao, moeda, uni, cftio, sgru)
                IF USED("cursor_4c_TabDi")
                    IF SEEK(loc_cTabela + "4" + PADR(m.CPros, 14), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "9" + PADR(m.CodFinP, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "1" + PADR(m.CGrus, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "2" + PADR(m.Linhas, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "3" + PADR(m.Colecoes, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "5" + PADR(m.Moevs, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "6" + PADR(m.Cunis, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "7" + PADR(m.Cftios, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "8" + PADR(m.Sgrus, 10), "cursor_4c_TabDi", "CodTips")
                        loc_nDescUnit = loc_nDescUnit - (cursor_4c_TabDi.Descos / 100)
                        loc_nDescTab  = IIF(cursor_4c_TabDi.TExclus = "S", 1, loc_nDescTab)
                    ENDIF
                ENDIF

                *-- Calcular preco final (com parcelas ou sem)
                IF loc_nParcs = 0
                    m.Units = ROUND(loc_nUnits * loc_nDescTab * loc_nDescUnit / 1, 2)
                ELSE
                    LOCAL loc_nPrecoParc
                    loc_nPrecoParc = CEILING(((loc_nUnits * loc_nDescTab * loc_nDescUnit) / 1) / loc_nParcs)
                    m.Units = loc_nPrecoParc * loc_nParcs
                ENDIF

                *-- Arredondamento pelo fator do grupo
                IF USED("cursor_4c_SigCdGrp")
                    SELECT cursor_4c_SigCdGrp
                    IF SEEK(m.CGrus, "cursor_4c_SigCdGrp", "CGrus") AND ;
                            cursor_4c_SigCdGrp.Arreds <> 0
                        LOCAL loc_nFatArred, loc_nSoma
                        loc_nFatArred = cursor_4c_SigCdGrp.Arreds
                        loc_nSoma     = loc_nFatArred
                        DO WHILE loc_nSoma < m.Units
                            loc_nSoma = loc_nSoma + loc_nFatArred
                        ENDDO
                        m.Units = loc_nSoma
                    ENDIF
                ENDIF

                *-- Situacao tributaria e codigo de barras (string)
                m.SitTribs = IIF(EMPTY(m.SitTricms), "00", m.SitTricms)
                loc_cCBars = STR(m.CBars, 14)

                *-- Inserir no cursor de resultado
                IF loc_nAgrupa = 2
                    *-- Identidade: deduplicar por codigo de barras, manter maior preco
                    SELECT CsRelatorio
                    IF !SEEK(loc_cCBars, "CsRelatorio", "CBars")
                        INSERT INTO CsRelatorio (CBars, DPros, Units, SitTribs, Aliqs) ;
                            VALUES (loc_cCBars, m.DPros, m.Units, m.SitTribs, loc_nAliqs)
                    ELSE
                        IF m.Units > CsRelatorio.Units
                            GATHER MEMVAR FIELDS Units
                        ENDIF
                    ENDIF
                ELSE
                    *-- Barra: inserir todos os registros
                    SELECT CsRelatorio
                    INSERT INTO CsRelatorio (CBars, DPros, Units, SitTribs, Aliqs) ;
                        VALUES (loc_cCBars, m.DPros, m.Units, m.SitTribs, loc_nAliqs)
                ENDIF

                SELECT CsRel

            ENDSCAN

            IF USED("CsRel")
                USE IN CsRel
            ENDIF

            SELECT CsRelatorio
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Processar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela.
    * Equivalente a PROCEDURE visualizacao do legado.
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEqe"
                REPORT FORM &loc_cRelPath PREVIEW NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora com prompt.
    * Equivalente a PROCEDURE impressao do legado.
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEqe"
                REPORT FORM &loc_cRelPath TO PRINTER PROMPT NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDireto - Prepara dados e envia para impressora sem prompt.
    * Equivalente a PROCEDURE documento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDireto()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEqe"
                REPORT FORM &loc_cRelPath TO PRINTER NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ImprimirDireto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a Relatorios.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresIntermedios - Fecha todos os cursores temporarios
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursoresIntermedios()
        LOCAL loc_aCursores[8], loc_i

        loc_aCursores[1] = "CsRel"
        loc_aCursores[2] = "CsRelatorio"
        loc_aCursores[3] = "CsCabecalho"
        loc_aCursores[4] = "cursor_4c_TabDi"
        loc_aCursores[5] = "cursor_4c_TabDz"
        loc_aCursores[6] = "cursor_4c_SigCdPam"
        loc_aCursores[7] = "cursor_4c_TabDe"
        loc_aCursores[8] = "cursor_4c_EmpVal"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        NEXT
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera todos os cursores
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursoresIntermedios()

        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        IF USED("cursor_4c_SigCdMoe")
            USE IN cursor_4c_SigCdMoe
        ENDIF
        IF USED("cursor_4c_SigCdCot")
            USE IN cursor_4c_SigCdCot
        ENDIF
        IF USED("cursor_4c_SigCdGrp")
            USE IN cursor_4c_SigCdGrp
        ENDIF
        IF USED("cursor_4c_SigCdCfi")
            USE IN cursor_4c_SigCdCfi
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

