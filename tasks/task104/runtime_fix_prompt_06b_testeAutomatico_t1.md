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
[2026-06-05 14:33:21] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-05 14:33:21] [INFO] Config FPW: (nao fornecido)
[2026-06-05 14:33:21] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-05 14:33:21] [INFO] Timeout: 300 segundos
[2026-06-05 14:33:21] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s0ubpn4e.prg
[2026-06-05 14:33:21] [INFO] Conteudo do wrapper:
[2026-06-05 14:33:21] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGREFUN', 'C:\4c\tasks\task104', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGREFUN', 'C:\4c\tasks\task104', 'REPORT'
QUIT

[2026-06-05 14:33:21] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s0ubpn4e.prg
[2026-06-05 14:33:21] [INFO] VFP output esperado em: C:\4c\tasks\task104\vfp_output.txt
[2026-06-05 14:33:21] [INFO] Executando Visual FoxPro 9...
[2026-06-05 14:33:21] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s0ubpn4e.prg
[2026-06-05 14:33:21] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s0ubpn4e.prg
[2026-06-05 14:33:21] [INFO] Timeout configurado: 300 segundos
[2026-06-05 14:33:28] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-05 14:33:28] [INFO] VFP9 finalizado em 7.1930054 segundos
[2026-06-05 14:33:28] [INFO] Exit Code: 
[2026-06-05 14:33:28] [INFO] 
[2026-06-05 14:33:28] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-05 14:33:28] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s0ubpn4e.prg
[2026-06-05 14:33:28] [INFO] 
[2026-06-05 14:33:28] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-05 14:33:28] [INFO] * Auto-generated wrapper for parameters
[2026-06-05 14:33:28] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-05 14:33:28] [INFO] * Parameters: 'FormSIGREFUN', 'C:\4c\tasks\task104', 'REPORT'
[2026-06-05 14:33:28] [INFO] 
[2026-06-05 14:33:28] [INFO] * Anti-dialog protections for unattended execution
[2026-06-05 14:33:28] [INFO] SET SAFETY OFF
[2026-06-05 14:33:28] [INFO] SET RESOURCE OFF
[2026-06-05 14:33:28] [INFO] SET TALK OFF
[2026-06-05 14:33:28] [INFO] SET NOTIFY OFF
[2026-06-05 14:33:28] [INFO] SYS(2335, 0)
[2026-06-05 14:33:28] [INFO] 
[2026-06-05 14:33:28] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGREFUN', 'C:\4c\tasks\task104', 'REPORT'
[2026-06-05 14:33:28] [INFO] QUIT
[2026-06-05 14:33:28] [INFO] 
[2026-06-05 14:33:28] [INFO] === Fim do Wrapper.prg ===
[2026-06-05 14:33:28] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGREFUN",
  "timestamp": "20260605143328",
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 1 (KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREFUN.prg):
*==============================================================================
* FORMSIGREFUN.PRG
* Relat" + CHR(243) + "rio de Tubos Fundi" + CHR(231) + CHR(227) + "o
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREFUN.SCX (frmrelatorio)
*
* Filtros:
*   - N" + CHR(250) + ". Fundi" + CHR(231) + CHR(227) + "o inicial (GetFundi -> txt_4c_Fundi)
*   - N" + CHR(250) + ". Fundi" + CHR(231) + CHR(227) + "o final   (GetFundf -> txt_4c_Fundf)
*   - Imprimir observa" + CHR(231) + CHR(227) + "o do item (ImpObs -> chk_4c_ImpObs)
*
* FASE 3/8 - Form - Estrutura Base
*   * Propriedades visuais (Width=800, Height=300 EXATOS do original)
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho() (cabecalho escuro com titulo)
*   * ConfigurarBotoes()    (Visualizar / Imprimir / Excel / Encerrar)
*   * ConfigurarPageFrame() (PageFrame com 1 pagina - "Filtros")
* FASE 4/8 - Form - Campos Filtro e Handlers de Botoes
*   * ConfigurarCamposFiltro() (Labels, TextBoxes, CheckBox na Page1)
*   * FormParaRelatorio() / LimparCampos() / Validar()
*   * BtnVisualizarClick() / BtnImprimirClick() / BtnExcelClick() / BtnCancelarClick()
*   * BINDEVENTs dos botoes do relatorio
* FASE 5/8 - Form - Campos Principais (N/A para REPORT)
*   * Form de relatorio tem layout FLAT (1 pagina de filtros, sem Page2 CRUD)
*   * TODOS os controles (txt_4c_Fundi, txt_4c_Fundf, chk_4c_ImpObs) foram
*     adicionados integralmente na Fase 4 via ConfigurarCamposFiltro()
*   * ConfigurarPaginaDados() nao se aplica a forms frmrelatorio
*   * Form COMPLETO - sem campos adicionais a incluir
* FASE 6/8 - Form - Campos Restantes e Lookups
*   * Sem lookups (original nao tem F4/F5 nem sigacess)
*   * Correcoes de fidelidade visual (PILAR 1): ForeColor, BackStyle,
*     SpecialEffect e Alignment copiados EXATOS do codigo fonte original
* FASE 7/8 - Form - Eventos Principais
*   * BtnVisualizarClick(): preview do relatorio (ja existia da Fase 4)
*   * BtnIncluirClick():    "Gerar Relatorio" - delega para Visualizar
*                           (semantica de REPORT: incluir = produzir saida)
*   * BtnAlterarClick():    "Limpar Filtros" - reset dos campos
*                           (semantica de REPORT: alterar = nova combinacao)
*   * BtnExcluirClick():    "Encerrar" - fecha o form
*                           (semantica de REPORT: sair sem acao)
*==============================================================================

DEFINE CLASS FormSIGREFUN AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=300)
    Height      = 300
    Width       = 800
    DataSession = 1
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
    *   2. Cria SIGREFUNBO
    *   3. Monta cabecalho escuro + botoes + PageFrame vazio de filtros
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o tubos fundi" + CHR(231) + CHR(227) + "o"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGREFUNBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGREFUNBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente a cntSombra)
                THIS.ConfigurarCabecalho()

                *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com pagina de filtros
                THIS.ConfigurarPageFrame()

                *-- Campos de filtro (Labels, TextBoxes, CheckBox)
                THIS.ConfigurarCamposFiltro()
                THIS.LimparCampos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Vincular botoes a handlers (metodos PUBLIC obrigatorio)
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnCancelarClick")

                THIS.Visible   = .T.
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

            *-- Sombra (deslocada 2px para efeito 3D do texto branco)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Rela" + CHR(231) + CHR(227) + "o tubos fundi" + CHR(231) + CHR(227) + "o"
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
                .Caption   = "Rela" + CHR(231) + CHR(227) + "o tubos fundi" + CHR(231) + CHR(227) + "o"
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
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio (btnReport)
    *   Original: btnReport.Left=525, Top=3
    *   Geometria EXATA do framework frmrelatorio.vcx:
    *     cmg_4c_Botoes: Top=0, Left=529, Width=273, Height=80, ButtonCount=4
    *     Buttons Left: (1)=5, (2)=71, (3)=137, (4)=203 (inc=66)
    *   BINDEVENTs Click vinculados em InicializarForm() apos ConfigurarCamposFiltro().
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

            *-- Excel (exportar dados)
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

            *-- Encerrar (fechar form - Cancel=.T. captura ESC)
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
    * ConfigurarPageFrame - PageFrame com 1 pagina para os campos de filtro
    *   O form original SIGREFUN e FLAT, mas no novo padrao os campos sao
    *   agrupados em um PageFrame de 1 pagina para consistencia visual.
    *   Campos de filtro (TextBoxes, Labels, CheckBox) adicionados em ConfigurarCamposFiltro().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form
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

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Troca a pagina ativa do PageFrame de filtros
    *   Em REPORT forms ha apenas Page1 (Filtros). par_nPagina invalido (NULL,
    *   nao-numerico, fora do range 1..PageCount) cai em Page1.
    *   Mantida como API publica de navegacao (paridade com FormBase CRUD).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_nTotal
        loc_nTotal  = THIS.pgf_4c_Paginas.PageCount
        loc_nPagina = par_nPagina
        IF VARTYPE(loc_nPagina) != "N" OR loc_nPagina < 1 OR loc_nPagina > loc_nTotal
            loc_nPagina = 1
        ENDIF
        THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Em REPORT forms, a unica pagina hospeda os
    *   campos de filtro do relatorio (equivalente conceitual da Page1=Lista
    *   em forms CRUD). Delega para ConfigurarCamposFiltro() e ativa Page1.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCamposFiltro()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposFiltro - Adiciona controles de filtro na Page1
    *   Layout original: Label2 top=147, GetFundi/f top=144, ImpObs top=172
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposFiltro()
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page1

        *-- Label "N? Fundi??o : " (Label2: top=147, left=264, width=78)
        loc_oPag1.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag1.lbl_4c_Label2
            .Top       = 147
            .Left      = 264
            .Width     = 78
            .Height    = 17
            .Caption   = "N" + CHR(186) + ". Fundi" + CHR(231) + CHR(227) + "o : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox N? Fundi??o inicial (GetFundi: top=144->59, left=343, width=52)
        loc_oPag1.AddObject("txt_4c_Fundi", "TextBox")
        WITH loc_oPag1.txt_4c_Fundi
            .Top           = 59
            .Left          = 343
            .Width         = 52
            .Height        = 23
            .Value         = 0
            .InputMask     = "999999"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Label "?" separador de range (Label1: top=148, left=404, width=9)
        loc_oPag1.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag1.lbl_4c_Label1
            .Top       = 148
            .Left      = 404
            .Width     = 9
            .Height    = 17
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox N? Fundi??o final (GetFundf: top=144->59, left=420, width=52)
        loc_oPag1.AddObject("txt_4c_Fundf", "TextBox")
        WITH loc_oPag1.txt_4c_Fundf
            .Top           = 59
            .Left          = 420
            .Width         = 52
            .Height        = 23
            .Value         = 0
            .InputMask     = "999999"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- CheckBox "Imprimir observa??o do item" (ImpObs: top=172, left=343)
        loc_oPag1.AddObject("chk_4c_ImpObs", "CheckBox")
        WITH loc_oPag1.chk_4c_ImpObs
            .Top       = 172
            .Left      = 343
            .Width     = 153
            .Height    = 15
            .Caption   = "Imprimir observa" + CHR(231) + CHR(227) + "o do item"
            .Value     = 0
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos filtros do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_nFundI  = loc_oPag1.txt_4c_Fundi.Value
            .this_nFundF  = loc_oPag1.txt_4c_Fundf.Value
            .this_lImpObs = (loc_oPag1.chk_4c_ImpObs.Value = 1)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa os campos de filtro para valores padrao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page1
        loc_oPag1.txt_4c_Fundi.Value  = 0
        loc_oPag1.txt_4c_Fundf.Value  = 0
        loc_oPag1.chk_4c_ImpObs.Value = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * Validar - Valida filtros obrigatorios antes de executar o relatorio
    *   Original: Empty(getFundi) Or Empty(getFundf) -> aviso + SetFocus
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPag1.txt_4c_Fundi.Value) OR EMPTY(loc_oPag1.txt_4c_Fundf.Value)
            MsgAviso("N" + CHR(250) + ". de fundi" + CHR(231) + CHR(227) + "o " + ;
                     CHR(233) + " obrigat" + CHR(243) + "rio.", "Aviso")
            loc_oPag1.txt_4c_Fundi.SetFocus()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio na tela (Buttons(1))
    *   Valida filtros, transfere para o BO e gera o preview do REPORT FORM.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !THIS.Validar()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - "Gerar Relatorio" no contexto REPORT
    *   Em forms CRUD esse evento abre a Page2 para inclusao de novo registro.
    *   Em forms REPORT a acao equivalente eh produzir uma nova saida do
    *   relatorio: valida filtros, monta SQL e exibe preview. Replica a
    *   logica do Click original do botao OK (comportamento.json):
    *     If Empty(getFundi) Or Empty(getFundf) -> aviso + SetFocus + Return
    *     Else -> executa relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPag1.txt_4c_Fundi.Value) OR EMPTY(loc_oPag1.txt_4c_Fundf.Value)
            MsgAviso("N" + CHR(250) + ". de fundi" + CHR(231) + CHR(227) + "o " + ;
                     CHR(233) + " obrigat" + CHR(243) + "rio.", "Aviso")
            loc_oPag1.txt_4c_Fundi.SetFocus()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - "Limpar Filtros" no contexto REPORT
    *   Em forms CRUD esse evento abre Page2 com registro selecionado para
    *   edicao. Em REPORT a acao equivalente eh resetar os filtros para que
    *   o usuario altere o intervalo de fundicao e a opcao de observacao.
    *   Limpa os campos via LimparCampos() e devolve foco a fundicao inicial.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPag1
        THIS.LimparCampos()
        loc_oPag1 = THIS.pgf_4c_Paginas.Page1
        loc_oPag1.txt_4c_Fundi.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - "Encerrar" no contexto REPORT
    *   Em forms CRUD esse evento confirma e remove o registro selecionado.
    *   Em REPORT nao ha registro a remover, entao a semantica equivalente eh
    *   "abandonar o relatorio" - fecha o formulario (mesmo efeito do botao
    *   Encerrar Buttons(4) e da tecla ESC).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Enviar relatorio para impressora com dialogo (Buttons(2))
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF !THIS.Validar()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Excel (nao disponivel no relatorio original) (Buttons(3))
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        MsgInfo("Exporta" + CHR(231) + CHR(227) + "o para Excel n" + CHR(227) + ;
                "o implementada para este relat" + CHR(243) + "rio.", "Excel")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fechar o formulario de relatorio (Buttons(4) / ESC)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Buscar (no contexto REPORT = Visualizar o relatorio)
    *   Form REPORT nao tem grid de lista; buscar equivale a gerar o preview.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o formulario de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Nao aplicavel a formulario de relatorio
    *   Semantica equivalente: confirmar acao = executar relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias de FormParaRelatorio() para API compativel com FormBase
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere propriedades do BO de volta para os controles do form
    *   Em REPORT forms os filtros sao carregados das propriedades do BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag1
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        loc_oPag1 = THIS.pgf_4c_Paginas.Page1
        loc_oPag1.txt_4c_Fundi.Value  = THIS.this_oRelatorio.this_nFundI
        loc_oPag1.txt_4c_Fundf.Value  = THIS.this_oRelatorio.this_nFundF
        loc_oPag1.chk_4c_ImpObs.Value = IIF(THIS.this_oRelatorio.this_lImpObs, 1, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Garante que campos de filtro ficam habilitados
    *   Em REPORT os campos de filtro ficam sempre disponiveis ao usuario.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag1
        loc_oPag1 = THIS.pgf_4c_Paginas.Page1
        loc_oPag1.txt_4c_Fundi.Enabled  = .T.
        loc_oPag1.txt_4c_Fundf.Enabled  = .T.
        loc_oPag1.chk_4c_ImpObs.Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel a formulario de relatorio (stub)
    *   Forms REPORT nao tem grid de lista de registros.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita todos os botoes do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO ao destruir o form
    *   NAO usar .Release() em objeto Custom/BO - apenas .NULL.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGREFUNBO.prg):
*==============================================================================
* SIGREFUNBO.PRG
* Business Object para Relatorio de Tubos Fundicao
*
* Herda de: RelatorioBase
* Entidade: SIGREFUN (Relacao de tubos fundicao)
* Tabelas principais: SigCdFun, SigCdFud, SigCdCor
*==============================================================================

DEFINE CLASS SIGREFUNBO AS RelatorioBase

    *-- Propriedades base (override)
    this_cTabela        = "SigCdFun"
    this_cCampoChave    = "Codigos"
    this_cMensagemErro  = ""

    *-- Filtros do relatorio (mapeados dos controles do form)
    this_nFundI         = 0     && GetFundi - No. Fundicao inicio (InputMask "999999")
    this_nFundF         = 0     && GetFundf - No. Fundicao fim   (InputMask "999999")
    this_lImpObs        = .F.   && ImpObs - Imprimir observacao do item

    *-- Controle interno do relatorio
    this_cNomeRelatorio   = "SIGREFUN"
    this_cCursorDados     = "cursor_4c_Dados"
    this_cTituloRelatorio = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de tubos fundicao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
            THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o tubos fundi" + CHR(231) + CHR(227) + "o"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros obrigatorios antes de processar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_nFundI) OR EMPTY(THIS.this_nFundF)
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero de fundi" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Busca e monta dados do relatorio de tubos fundicao
    * Logica original: SigReFun.processamento
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpresa, loc_cTitulo2, loc_nCod, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Cursor de cabecalho para o relatorio
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho (NomeEmpresa C(80), Titulo C(200), ;
                                        Titulo2 C(200), Figura C(10), ImpObs L)

            *-- Nome da empresa a partir do objeto sistema
            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

            loc_cTitulo2 = "Fundi" + CHR(231) + CHR(227) + "o - " + ;
                           ALLTRIM(STR(THIS.this_nFundI, 6)) + " at" + CHR(233) + " " + ;
                           ALLTRIM(STR(THIS.this_nFundF, 6))

            SELECT csCabecalho
            INSERT INTO csCabecalho (NomeEmpresa, Titulo, Titulo2, ImpObs) ;
                VALUES (loc_cEmpresa, THIS.this_cTituloRelatorio, loc_cTitulo2, THIS.this_lImpObs)

            *-- Cursor de trabalho para montagem do relatorio
            IF USED("Relatorio")
                USE IN Relatorio
            ENDIF
            CREATE CURSOR Relatorio (Codigos N(6), Tubos N(2), bCeras N(12,2), Bases N(12,2), ;
                                      Ceras N(12,2), Metals N(12,2), CodCors C(4), ;
                                      Obss M, Datas D, ObsG M, Qtdos N(10,3), MetalNvs N(12,3))
            INDEX ON STR(Codigos, 6) + STR(Tubos, 2) TAG Tubos
            INDEX ON STR(Codigos, 6) + CodCors + STR(Tubos, 2) TAG Impressao

            *-- Query principal: SigCdFun x SigCdFud x SigCdCor
            loc_cSQL = "SELECT b.*, a.Obss AS ObsG, a.Datas, c.Pesos " + ;
                       "FROM SigCdFun a, SigCdFud b, SigCdCor c " + ;
                       "WHERE a.Codigos BETWEEN " + FormatarNumeroSQL(THIS.this_nFundI) + ;
                       " AND " + FormatarNumeroSQL(THIS.this_nFundF) + ;
                       " AND a.Codigos = b.Codigos" + ;
                       " AND b.Nops = 0 AND b.NNumes = 0 AND b.CodCors = c.Cods" + ;
                       " ORDER BY a.Codigos, b.Tubos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crDados")

            IF loc_nResult >= 1
                *-- Query secundaria: QtdOs agregado por OS (Nops > 0)
                loc_cSQL = "SELECT b.Codigos, b.Tubos, SUM(b.QtdOs) AS QtdOs " + ;
                           "FROM SigCdFun a, SigCdFud b " + ;
                           "WHERE a.Codigos BETWEEN " + FormatarNumeroSQL(THIS.this_nFundI) + ;
                           " AND " + FormatarNumeroSQL(THIS.this_nFundF) + ;
                           " AND a.Codigos = b.Codigos AND b.Nops > 0 " + ;
                           "GROUP BY b.Codigos, b.Tubos"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTubos")

                IF loc_nResult >= 1
                    *-- Cursor intermediario com transformacoes de tipo
                    SELECT crDados.Codigos, crDados.Tubos, crDados.NNumes, crDados.Nops, ;
                           crDados.Qtds, crDados.QtdOs, crDados.BCeras, crDados.Bases, ;
                           crDados.CodCors, crDados.Metals, crDados.MetalNvs, ;
                           NVL(crDados.Obss, SPACE(100)) AS Obss, ;
                           crDados.TempMets, crDados.TempAmbs, crDados.TempTubs, crDados.TempAgus, ;
                           NVL(crDados.ObsG, SPACE(100)) AS ObsG, ;
                           TTOD(NVL(crDados.Datas, CTOT(""))) AS Datas, ;
                           crDados.Pesos ;
                           FROM crDados ;
                           INTO CURSOR Selecao READWRITE

                    *-- Montar cursor Relatorio via SCAN (logica original preservada)
                    SELECT Selecao
                    GO TOP
                    SCAN
                        loc_nCod = Codigos

                        SELECT Relatorio
                        APPEND BLANK
                        REPLACE Codigos WITH loc_nCod, ;
                                Tubos   WITH 99, ;
                                CodCors WITH "ZZZZ", ;
                                ObsG    WITH Selecao.ObsG

                        SELECT Selecao
                        SCAN WHILE Codigos = loc_nCod
                            SCATTER MEMVAR MEMO
                            m.Ceras = m.bCeras - m.Bases

                            SELECT Relatorio
                            APPEND BLANK
                            GATHER MEMVAR MEMO
                        ENDSCAN
                        SKIP -1
                    ENDSCAN

                    *-- Preencher QtdOs das OS nos registros correspondentes
                    SELECT crTubos
                    SCAN
                        IF SEEK(STR(crTubos.Codigos, 6) + STR(crTubos.Tubos, 2), "Relatorio", "Tubos")
                            REPLACE Relatorio.QtdOs WITH crTubos.QtdOs IN Relatorio
                        ENDIF
                    ENDSCAN

                    SELECT Relatorio
                    GO TOP

                    IF USED("crDados")
                        USE IN crDados
                    ENDIF
                    IF USED("crTubos")
                        USE IN crTubos
                    ENDIF
                    IF USED("Selecao")
                        USE IN Selecao
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao buscar totais de tubos"
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar dados de fundi" + CHR(231) + CHR(227) + "o"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
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
                REPORT FORM (THIS.this_cNomeRelatorio) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cNomeRelatorio) TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirSilencioso - Imprime relatorio sem dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirSilencioso()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cNomeRelatorio) TO PRINT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel para relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores do relatorio ao destruir o objeto
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        IF USED("Relatorio")
            USE IN Relatorio
        ENDIF
        IF USED("crDados")
            USE IN crDados
        ENDIF
        IF USED("crTubos")
            USE IN crTubos
        ENDIF
        IF USED("Selecao")
            USE IN Selecao
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

