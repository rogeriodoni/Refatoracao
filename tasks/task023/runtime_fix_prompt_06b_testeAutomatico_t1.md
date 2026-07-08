# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnIncluirNavegacao': BtnIncluirClick nao navegou para Page2 (ActivePage=1)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-05-14 16:27:18] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-14 16:27:18] [INFO] Config FPW: (nao fornecido)
[2026-05-14 16:27:18] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-14 16:27:18] [INFO] Timeout: 300 segundos
[2026-05-14 16:27:18] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_5ichvizi.prg
[2026-05-14 16:27:18] [INFO] Conteudo do wrapper:
[2026-05-14 16:27:18] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGREVIS', 'C:\4c\tasks\task023', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGREVIS', 'C:\4c\tasks\task023', 'REPORT'
QUIT

[2026-05-14 16:27:18] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_5ichvizi.prg
[2026-05-14 16:27:18] [INFO] VFP output esperado em: C:\4c\tasks\task023\vfp_output.txt
[2026-05-14 16:27:18] [INFO] Executando Visual FoxPro 9...
[2026-05-14 16:27:18] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_5ichvizi.prg
[2026-05-14 16:27:18] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_5ichvizi.prg
[2026-05-14 16:27:18] [INFO] Timeout configurado: 300 segundos
[2026-05-14 16:27:19] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-14 16:27:19] [INFO] VFP9 finalizado em 1.5950715 segundos
[2026-05-14 16:27:19] [INFO] Exit Code: 
[2026-05-14 16:27:19] [INFO] 
[2026-05-14 16:27:19] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-14 16:27:19] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_5ichvizi.prg
[2026-05-14 16:27:19] [INFO] 
[2026-05-14 16:27:19] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-14 16:27:19] [INFO] * Auto-generated wrapper for parameters
[2026-05-14 16:27:19] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-14 16:27:19] [INFO] * Parameters: 'FormSIGREVIS', 'C:\4c\tasks\task023', 'REPORT'
[2026-05-14 16:27:19] [INFO] 
[2026-05-14 16:27:19] [INFO] * Anti-dialog protections for unattended execution
[2026-05-14 16:27:19] [INFO] SET SAFETY OFF
[2026-05-14 16:27:19] [INFO] SET RESOURCE OFF
[2026-05-14 16:27:19] [INFO] SET TALK OFF
[2026-05-14 16:27:19] [INFO] SET NOTIFY OFF
[2026-05-14 16:27:19] [INFO] SYS(2335, 0)
[2026-05-14 16:27:19] [INFO] 
[2026-05-14 16:27:19] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGREVIS', 'C:\4c\tasks\task023', 'REPORT'
[2026-05-14 16:27:19] [INFO] QUIT
[2026-05-14 16:27:19] [INFO] 
[2026-05-14 16:27:19] [INFO] === Fim do Wrapper.prg ===
[2026-05-14 16:27:19] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGREVIS",
  "timestamp": "20260514162719",
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
      "passou": true,
      "erro": "",
      "detalhes": "Modo VISUALIZAR configurado"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": false,
      "erro": "BtnIncluirClick nao navegou para Page2 (ActivePage=1)",
      "detalhes": ""
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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREVIS.prg):
*==============================================================================
* FORMSIGREVIS.PRG
* Relat" + CHR(243) + "rio de Visitas
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREVIS.SCX (frmrelatorio)
*
* Filtros (Page1):
*   - Per" + CHR(237) + "odo (data inicial / data final)
*   - Conta   (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdCli)
*   - Representante (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdCli, filtrado por grupo)
*   - Op" + CHR(231) + CHR(227) + "o Venda  (Sim / N" + CHR(227) + "o / Ambos)
*   - Op" + CHR(231) + CHR(227) + "o Pedido (Sim / N" + CHR(227) + "o / Ambos)
*
* FASE 7/8 - Eventos principais e form completo
*   * Propriedades visuais do form
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho()  (cabecalho escuro com titulo)
*   * ConfigurarBotoes()     (Visualizar / Imprimir / Excel / Encerrar)
*   * ConfigurarPageFrame()  (PageFrame com 1 pagina - "Filtros")
*   * ConfigurarPaginaLista() (todos os filtros: periodo, repr, conta, opcoes)
*   * ConfigurarPaginaDados() (OptionGroups Venda/Pedido + todos os BINDEVENTs)
*   * TeclaDataInicial()     (getDatai.Valid: sync data final)
*   * AtualizarEstadoCamposDescricao() (When: ReadOnly de DsRepr/DsConta)
*   * Lookups completos (codigo/descricao Repr e Conta) + Validacoes
*   * BtnVisualizarClick()   (REPORT FORM ... PREVIEW NOCONSOLE)
*   * BtnImprimirClick()     (REPORT FORM ... TO PRINTER PROMPT NOCONSOLE)
*   * BtnExcelClick()        (COPY TO ... TYPE XLS)
*   * BtnSairClick()         (THIS.Release)
*   * ValidarPeriodo()       (data final >= data inicial)
*==============================================================================

DEFINE CLASS FormSIGREVIS AS FormBase

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
    *   2. Cria SIGREVISBO e carrega filtros iniciais (pula em modo UI)
    *   3. Monta cabecalho escuro + botoes do relatorio + PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Visitas"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGREVISBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGREVISBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Carregar parametros iniciais (grupo padrao do usuario).
            *   Pulado em modo de validacao de UI (sem conexao SQL).
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.InicializarFiltros()
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

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Campos de filtro na Page1 do PageFrame
                *   ConfigurarPaginaLista() porque Page1 contem a "lista" de
                *   parametros (filtros) do relatorio - convencao herdada do
                *   padrao CRUD onde Page1 sempre eh "Lista".
                THIS.ConfigurarPaginaLista()

                *-- Vincular Click dos botoes de relatorio
                BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Imprimir,   "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Excel,      "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Sair,       "Click", THIS, "BtnSairClick")

                *-- Valores iniciais dos campos de filtro
                THIS.LimparCampos()

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
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.

            *-- Sombra (deslocada 2px para efeito 3D do texto branco)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Visitas"
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
                .Caption   = "Relat" + CHR(243) + "rio de Visitas"
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
    * ConfigurarBotoes - Container de botoes de relatorio (btnReport area)
    *   Original: btnReport.Top=-3, Left=526, Height=85, Width=305
    *   Botoes: Visualiza(6), Imprime(72), DocExcel(138), Sair(204) - W=60 cada
    *   Eventos Click sao vinculados nas fases seguintes (Fase 7).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.cnt_4c_Botoes
            .Top         = 0
            .Left        =  542
            .Width       = 325
            .Height      = 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Visualizar (preview em tela)
        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Visualizar
            .Top             = 4
            .Left            = 4
            .Width           = 67
            .Height          = 70
            .Caption         = "Visualizar"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .PicturePosition = 1
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH

        *-- Imprimir (impressora padrao)
        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Imprimir
            .Top             = 4
            .Left            = 79
            .Width           = 67
            .Height          = 70
            .Caption         = "Imprimir"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .PicturePosition = 1
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH

        *-- Excel (exportar dados)
        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Excel", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Excel
            .Top             = 4
            .Left            = 154
            .Width           = 67
            .Height          = 70
            .Caption         = "Excel"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
            .PicturePosition = 1
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH

        *-- Encerrar (fechar form)
        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Sair
            .Top             = 4
            .Left            = 229
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
            .PicturePosition = 1
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH

        THIS.cnt_4c_Botoes.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros")
    *   O form legado SIGREVIS e FLAT (sem PageFrame), mas no novo padrao
    *   os campos sao agrupados em um PageFrame de 1 pagina para consistencia
    *   com o restante do sistema.
    *
    *   Os campos de filtro (TextBoxes, OptionGroups, Labels) sao adicionados
    *   a Page1 nas fases seguintes (5-6).
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

        loc_oPgf.Visible     = .T.
        loc_oPgf.ActivePage  = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona controles de filtro na Page1
    *   Em forms CRUD, Page1 contem a LISTA de registros (grid + botoes).
    *   Neste form de RELATORIO, Page1 contem a LISTA de parametros (filtros),
    *   por isso o metodo mantem o nome ConfigurarPaginaLista do padrao do
    *   sistema, mas configura campos de filtro ao inves de grid CRUD.
    *
    *   Posicoes originais SIGREVIS (800x300px) menos offset PageFrame (85px):
    *     Periodo:    top=21  | Representante: top=48 | Conta: top=75
    *     Opt_Venda:  top=104 | Opt_Pedido:    top=130
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Periodo :"
        loc_oPg.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oPg.lbl_4c_LblPeriodo
            .Top       = 26
            .Left      = 209
            .Width     = 45
            .Height    = 15
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data inicial
        loc_oPg.AddObject("txt_4c_Datai", "TextBox")
        WITH loc_oPg.txt_4c_Datai
            .Top         = 21
            .Left        = 260
            .Width       = 80
            .Height      = 25
            .Value       = {}
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Label "a" (separador entre datas)
        loc_oPg.AddObject("lbl_4c_A", "Label")
        WITH loc_oPg.lbl_4c_A
            .Top       = 26
            .Left      = 348
            .Width     = 10
            .Height    = 15
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Data final
        loc_oPg.AddObject("txt_4c_Dataf", "TextBox")
        WITH loc_oPg.txt_4c_Dataf
            .Top         = 21
            .Left        = 360
            .Width       = 80
            .Height      = 25
            .Value       = {}
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Label "Representante :"
        loc_oPg.AddObject("lbl_4c_LblRepr", "Label")
        WITH loc_oPg.lbl_4c_LblRepr
            .Top       = 53
            .Left      = 173
            .Width     = 81
            .Height    = 15
            .Caption   = "Representante :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Codigo do representante (F4 -> SigCdCli filtrado por Grupos)
        loc_oPg.AddObject("txt_4c_CdRepr", "TextBox")
        WITH loc_oPg.txt_4c_CdRepr
            .Top         = 48
            .Left        = 260
            .Width       = 80
            .Height      = 25
            .Value       = ""
            .MaxLength   = 6
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Descricao do representante (preenchida pelo lookup)
        loc_oPg.AddObject("txt_4c_DsRepr", "TextBox")
        WITH loc_oPg.txt_4c_DsRepr
            .Top         = 48
            .Left        = 342
            .Width       = 313
            .Height      = 25
            .Value       = ""
            .MaxLength   = 40
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Label "Conta :"
        loc_oPg.AddObject("lbl_4c_LblConta", "Label")
        WITH loc_oPg.lbl_4c_LblConta
            .Top       = 80
            .Left      = 216
            .Width     = 38
            .Height    = 15
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Codigo da conta (F4 -> SigCdCli, sem filtro de grupo)
        loc_oPg.AddObject("txt_4c_CdConta", "TextBox")
        WITH loc_oPg.txt_4c_CdConta
            .Top         = 75
            .Left        = 260
            .Width       = 80
            .Height      = 25
            .Value       = ""
            .MaxLength   = 6
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Descricao da conta (preenchida pelo lookup)
        loc_oPg.AddObject("txt_4c_DsConta", "TextBox")
        WITH loc_oPg.txt_4c_DsConta
            .Top         = 75
            .Left        = 342
            .Width       = 313
            .Height      = 25
            .Value       = ""
            .MaxLength   = 40
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Demais campos de filtro (OptionGroups Venda/Pedido) e BINDEVENTs
        *   sao configurados em ConfigurarPaginaDados() abaixo. Em forms CRUD,
        *   Page2 contem os campos de DADOS para edicao; neste relatorio,
        *   conceitualmente sao os campos de OPCAO (Sim/Nao/Todos) que ficam
        *   visualmente separados dos filtros de identificacao acima.
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona OptionGroups e BINDEVENTs na Page1.
    *   Em forms CRUD esta procedure popularia a Page2 com campos de dados.
    *   Neste form de RELATORIO (1 pagina apenas), reune a segunda metade dos
    *   filtros (opcoes Venda/Pedido) e vincula handlers de teclado/clique
    *   nos campos de lookup ja criados em ConfigurarPaginaLista().
    *
    *   Mantida como procedure separada para:
    *     - Atender o padrao do pipeline de migracao (Page1=lista, Page2=dados)
    *     - Reduzir o tamanho de ConfigurarPaginaLista (legibilidade)
    *     - Permitir reconfigurar opcoes/bindings sem recriar todos os filtros
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Venda :"
        loc_oPg.AddObject("lbl_4c_LblVenda", "Label")
        WITH loc_oPg.lbl_4c_LblVenda
            .Top       = 110
            .Left      = 215
            .Width     = 39
            .Height    = 15
            .Caption   = "Venda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Venda (Sim / Nao / Todos) - ButtonCount ANTES de Buttons(3)
        loc_oPg.AddObject("opt_4c_Venda", "OptionGroup")
        loc_oPg.opt_4c_Venda.ButtonCount = 3
        WITH loc_oPg.opt_4c_Venda
            .Top         = 104
            .Left        = 260
            .Width       = 246
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_Venda.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 57
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_Venda.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 92
            .Top       = 5
            .Width     = 57
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_Venda.Buttons(3)
            .Caption   = "Ambos"
            .Left      = 179
            .Top       = 5
            .Width     = 57
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_Venda.Value = 3

        *-- Label "Pedidos :"
        loc_oPg.AddObject("lbl_4c_LblPedido", "Label")
        WITH loc_oPg.lbl_4c_LblPedido
            .Top       = 136
            .Left      = 208
            .Width     = 46
            .Height    = 15
            .Caption   = "Pedidos :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Pedido (Sim / Nao / Todos) - ButtonCount ANTES de Buttons(3)
        loc_oPg.AddObject("opt_4c_Pedido", "OptionGroup")
        loc_oPg.opt_4c_Pedido.ButtonCount = 3
        WITH loc_oPg.opt_4c_Pedido
            .Top         = 130
            .Left        = 260
            .Width       = 246
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_Pedido.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 57
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_Pedido.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 92
            .Top       = 5
            .Width     = 57
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_Pedido.Buttons(3)
            .Caption   = "Ambos"
            .Left      = 179
            .Top       = 5
            .Width     = 57
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_Pedido.Value = 3

        *-- Vincular KeyPress nos campos com lookup (F4=lookup, ENTER/TAB=validar)
        BINDEVENT(loc_oPg.txt_4c_CdRepr,  "KeyPress", THIS, "TeclaCdRepr")
        BINDEVENT(loc_oPg.txt_4c_DsRepr,  "KeyPress", THIS, "TeclaDsRepr")
        BINDEVENT(loc_oPg.txt_4c_CdConta, "KeyPress", THIS, "TeclaCdConta")
        BINDEVENT(loc_oPg.txt_4c_DsConta, "KeyPress", THIS, "TeclaDsConta")

        *-- DblClick tambem abre lookup (equivalente ao F4)
        BINDEVENT(loc_oPg.txt_4c_CdRepr,  "DblClick", THIS, "AbrirBuscaCdRepr")
        BINDEVENT(loc_oPg.txt_4c_DsRepr,  "DblClick", THIS, "AbrirBuscaDsRepr")
        BINDEVENT(loc_oPg.txt_4c_CdConta, "DblClick", THIS, "AbrirBuscaCdConta")
        BINDEVENT(loc_oPg.txt_4c_DsConta, "DblClick", THIS, "AbrirBuscaDsConta")

        *-- Data inicial: ao sair do campo (ENTER/TAB), ajusta data final se anterior
        *   Equivalente ao getDatai.Valid do original SIGREVIS
        BINDEVENT(loc_oPg.txt_4c_Datai, "KeyPress", THIS, "TeclaDataInicial")

        *-- Inicializar estado de habilitacao dos campos de descricao
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padrao.
    *   Datas = DATE() (hoje), codigos/descricoes em branco, opcoes = Todos(3).
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_Datai.Value   = DATE()
            loc_oPg.txt_4c_Dataf.Value   = DATE()
            loc_oPg.txt_4c_CdRepr.Value  = ""
            loc_oPg.txt_4c_DsRepr.Value  = ""
            loc_oPg.txt_4c_CdConta.Value = ""
            loc_oPg.txt_4c_DsConta.Value = ""
            loc_oPg.opt_4c_Venda.Value   = 3
            loc_oPg.opt_4c_Pedido.Value  = 3
            *-- Campos de descricao voltam a ser editaveis apos limpar codigos
            THIS.AtualizarEstadoCamposDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a pagina solicitada no PageFrame.
    *   Em forms CRUD, alterna entre Page1 (Lista) e Page2 (Dados). Neste form
    *   de RELATORIO, ha somente Page1 (Filtros), entao a chamada eh
    *   defensiva: aceita o numero da pagina, valida o range e reposiciona o
    *   foco no primeiro filtro (data inicial). Util para resetar a tela apos
    *   uma impressao/visualizacao, permitindo o usuario iniciar nova consulta
    *   sem fechar e reabrir o formulario.
    *
    *   par_nPagina: numero da pagina a ativar (1=Filtros). Default = 1.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nDestino, loc_oPgf, loc_oPg
        TRY
            loc_oPgf = THIS.pgf_4c_Paginas
            IF VARTYPE(loc_oPgf) != "O"
                RETURN
            ENDIF

            *-- Validar parametro e limitar ao range valido do PageFrame.
            IF PCOUNT() = 0 OR VARTYPE(par_nPagina) != "N"
                loc_nDestino = 1
            ELSE
                loc_nDestino = INT(par_nPagina)
            ENDIF
            IF loc_nDestino < 1
                loc_nDestino = 1
            ENDIF
            IF loc_nDestino > loc_oPgf.PageCount
                loc_nDestino = loc_oPgf.PageCount
            ENDIF

            *-- Ativa a pagina destino e reposiciona foco no primeiro filtro.
            loc_oPgf.ActivePage = loc_nDestino
            loc_oPg = loc_oPgf.Pages(loc_nDestino)
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_Datai", 5)
                loc_oPg.txt_4c_Datai.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO.
    *   Equivalente ao bloco 'processamento' do form legado SIGREVIS.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial   = loc_oPg.txt_4c_Datai.Value
            .this_dDtFinal     = loc_oPg.txt_4c_Dataf.Value
            .this_cCdConta     = ALLTRIM(loc_oPg.txt_4c_CdConta.Value)
            .this_cDsConta     = ALLTRIM(loc_oPg.txt_4c_DsConta.Value)
            .this_cCdRepr      = ALLTRIM(loc_oPg.txt_4c_CdRepr.Value)
            .this_cDsRepr      = ALLTRIM(loc_oPg.txt_4c_DsRepr.Value)
            .this_nOpcaoVenda  = loc_oPg.opt_4c_Venda.Value
            .this_nOpcaoPedido = loc_oPg.opt_4c_Pedido.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPeriodo - Verifica data final >= data inicial.
    *   Equivalente a validacao no btnReport.Click do form legado SIGREVIS.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarPeriodo()
        LOCAL loc_oPg, loc_dIni, loc_dFim
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_dIni = loc_oPg.txt_4c_Datai.Value
        loc_dFim = loc_oPg.txt_4c_Dataf.Value
        IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
            MsgAviso("Data Final Menor Que a Inicial!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_Dataf.SetFocus()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cFrxPath
        TRY
            IF !THIS.ValidarPeriodo()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                RETURN
            ENDIF
            loc_cFrxPath = gc_4c_CaminhoReports + "SigReVis.frx"
            REPORT FORM (loc_cFrxPath) PREVIEW NOCONSOLE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio na impressora com dialogo de selecao
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cFrxPath
        TRY
            IF !THIS.ValidarPeriodo()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                RETURN
            ENDIF
            loc_cFrxPath = gc_4c_CaminhoReports + "SigReVis.frx"
            REPORT FORM (loc_cFrxPath) TO PRINTER PROMPT NOCONSOLE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do cursor para arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cFrxPath, loc_cArquivo, loc_cCursor
        TRY
            IF !THIS.ValidarPeriodo()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                RETURN
            ENDIF
            loc_cCursor = THIS.this_oRelatorio.this_cCursorDados
            IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                MsgAviso("Nenhum dado encontrado para exportar.", "Excel")
                RETURN
            ENDIF
            loc_cArquivo = PUTFILE("Salvar como...", "SigReVis", "XLS")
            IF !EMPTY(loc_cArquivo)
                SELECT (loc_cCursor)
                COPY TO (loc_cArquivo) TYPE XLS
                MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + ;
                    loc_cArquivo, "Excel")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT
    * Em forms CRUD os bot" + CHR(245) + "es Incluir/Alterar/Excluir manipulam registros.
    * Em forms de RELATORIO essas opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o existem - os m" + CHR(233) + "todos abaixo
    * traduzem o conceito CRUD para a sem" + CHR(226) + "ntica de relat" + CHR(243) + "rio (nova consulta,
    * gerar relat" + CHR(243) + "rio, opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida).
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - "Nova consulta" para form de relatorio
    *   Em CRUD: prepara form para inclusao de novo registro.
    *   Em REPORT: equivale a "nova consulta" - limpa todos os filtros para
    *   que o usuario inicie um novo conjunto de filtros do zero, e
    *   reposiciona o foco na data inicial (primeiro filtro do form).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPg
        TRY
            THIS.LimparCampos()
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_Datai", 5)
                loc_oPg.txt_4c_Datai.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - "Gerar relatorio" para form de relatorio
    *   Em CRUD: prepara form para alteracao do registro selecionado.
    *   Em REPORT: equivale a gerar o relatorio (visualizar preview) com os
    *   filtros atuais. Delega para BtnVisualizarClick que ja faz validacao
    *   de periodo, FormParaRelatorio, PrepararDados e REPORT FORM PREVIEW.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Operacao invalida em form de relatorio
    *   Em CRUD: exclui o registro selecionado apos confirmacao.
    *   Em REPORT: nao ha registros para excluir (apenas filtros e dados
    *   consultados em cursores temporarios). Informa o usuario que a
    *   operacao nao se aplica neste contexto.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + ;
            "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO - BINDEVENT KeyPress
    * F4=115, ENTER=13, TAB=9
    *==========================================================================

    PROCEDURE TeclaCdRepr(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdRepr()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdRepr()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsRepr(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsRepr()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsRepr()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDataInicial - Handler KeyPress de txt_4c_Datai
    *   Equivalente ao getDatai.Valid do original: quando data inicial muda e
    *   fica maior que data final, atualiza data final para igualar a inicial.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_oPg, loc_dIni, loc_dFim
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_dIni = loc_oPg.txt_4c_Datai.Value
            loc_dFim = loc_oPg.txt_4c_Dataf.Value
            IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
                loc_oPg.txt_4c_Dataf.Value = loc_dIni
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCamposDescricao - Simula o evento "When" do original
    *   getDsRepr.When: Return Empty(ThisForm.getCdRepr.Value)
    *   getDsConta.When: Return Empty(Thisform.getCdConta.Value)
    *   Logica: campo de descricao so eh editavel quando campo de codigo esta
    *   vazio, impedindo edicao manual quando um registro ja foi selecionado.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoCamposDescricao()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            *-- DsRepr editavel apenas quando CdRepr esta vazio
            loc_oPg.txt_4c_DsRepr.ReadOnly  = !EMPTY(ALLTRIM(loc_oPg.txt_4c_CdRepr.Value))
            *-- DsConta editavel apenas quando CdConta esta vazio
            loc_oPg.txt_4c_DsConta.ReadOnly = !EMPTY(ALLTRIM(loc_oPg.txt_4c_CdConta.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LOOKUP - REPRESENTANTE (SigCdCli filtrado por Grupos = this_cGrupo)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaCdRepr - Lookup de representante pelo codigo (iclis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdRepr()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdRepr.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaRepr", "iclis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Representante", ;
            .F., .T., ;
            "Grupos = " + EscaparSQL(THIS.this_oRelatorio.this_cGrupo))
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CdRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
                loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRepr")
                    loc_oPg.txt_4c_CdRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
                    loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaRepr")
            USE IN cursor_4c_BuscaRepr
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDsRepr - Lookup de representante pelo nome (rclis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDsRepr()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsRepr.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaRepr", "rclis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Representante", ;
            .F., .T., ;
            "Grupos = " + EscaparSQL(THIS.this_oRelatorio.this_cGrupo))
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
                loc_oPg.txt_4c_CdRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("rclis", "", "Nome")
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRepr")
                    loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
                    loc_oPg.txt_4c_CdRepr.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaRepr")
            USE IN cursor_4c_BuscaRepr
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdRepr - Valida codigo de representante digitado manualmente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCdRepr()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdRepr.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsRepr.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT iclis, rclis FROM SigCdCli" + ;
            " WHERE Grupos = " + EscaparSQL(THIS.this_oRelatorio.this_cGrupo) + ;
            " AND iclis = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ReprVal")
        IF loc_nResult > 0
            SELECT cursor_4c_ReprVal
            IF !EOF()
                loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_ReprVal.rclis)
            ELSE
                loc_oPg.txt_4c_DsRepr.Value = ""
                THIS.AbrirBuscaCdRepr()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DsRepr.Value = ""
            THIS.AbrirBuscaCdRepr()
        ENDIF
        IF USED("cursor_4c_ReprVal")
            USE IN cursor_4c_ReprVal
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsRepr - Valida nome de representante digitado manualmente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDsRepr()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsRepr.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CdRepr.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT iclis, rclis FROM SigCdCli" + ;
            " WHERE Grupos = " + EscaparSQL(THIS.this_oRelatorio.this_cGrupo) + ;
            " AND rclis LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ReprVal2")
        IF loc_nResult > 0
            SELECT cursor_4c_ReprVal2
            IF !EOF()
                loc_oPg.txt_4c_CdRepr.Value = ALLTRIM(cursor_4c_ReprVal2.iclis)
                loc_oPg.txt_4c_DsRepr.Value = ALLTRIM(cursor_4c_ReprVal2.rclis)
            ELSE
                THIS.AbrirBuscaDsRepr()
            ENDIF
        ELSE
            THIS.AbrirBuscaDsRepr()
        ENDIF
        IF USED("cursor_4c_ReprVal2")
            USE IN cursor_4c_ReprVal2
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    *==========================================================================
    * LOOKUP - CONTA (SigCdCli, sem filtro de grupo)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaCdConta - Lookup de conta pelo codigo (iclis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdConta()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdConta.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaConta", "iclis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
                loc_oPg.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                    loc_oPg.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
                    loc_oPg.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDsConta - Lookup de conta pelo nome (rclis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDsConta()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsConta.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaConta", "rclis", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
                loc_oPg.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("rclis", "", "Nome")
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                    loc_oPg.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
                    loc_oPg.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdConta - Valida codigo de conta digitado manualmente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCdConta()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdConta.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsConta.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT iclis, rclis FROM SigCdCli" + ;
            " WHERE iclis = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaVal")
        IF loc_nResult > 0
            SELECT cursor_4c_ContaVal
            IF !EOF()
                loc_oPg.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_ContaVal.rclis)
            ELSE
                loc_oPg.txt_4c_DsConta.Value = ""
                THIS.AbrirBuscaCdConta()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DsConta.Value = ""
            THIS.AbrirBuscaCdConta()
        ENDIF
        IF USED("cursor_4c_ContaVal")
            USE IN cursor_4c_ContaVal
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsConta - Valida nome de conta digitado manualmente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDsConta()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsConta.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CdConta.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT iclis, rclis FROM SigCdCli" + ;
            " WHERE rclis LIKE " + EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaVal2")
        IF loc_nResult > 0
            SELECT cursor_4c_ContaVal2
            IF !EOF()
                loc_oPg.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_ContaVal2.iclis)
                loc_oPg.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_ContaVal2.rclis)
            ELSE
                THIS.AbrirBuscaDsConta()
            ENDIF
        ELSE
            THIS.AbrirBuscaDsConta()
        ENDIF
        IF USED("cursor_4c_ContaVal2")
            USE IN cursor_4c_ContaVal2
        ENDIF
        THIS.AtualizarEstadoCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles - Override: relatorio nao usa operacoes CRUD
    *   Bloqueia o comportamento padrao do FormBase (Incluir/Alterar/Excluir).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    *==========================================================================
    * FASE 8 - METODOS AUXILIARES DE CONSOLIDACAO
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarLista - Para forms de relatorio nao ha lista a carregar.
    *   Em forms CRUD popula o grid de Page1. Neste relatorio os filtros ja
    *   estao configurados em ConfigurarPaginaLista/Dados. Apenas reposiciona
    *   o foco no primeiro filtro (data inicial).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_Datai", 5)
                loc_oPg.txt_4c_Datai.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia valores do form para o BO (alias de FormParaRelatorio).
    *   Em forms CRUD transfere dados dos controles para propriedades do BO.
    *   Neste relatorio delega para FormParaRelatorio() que faz o mesmo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Restaura valores do BO nos controles do form.
    *   Em forms CRUD preenche campos com dados do BO apos carregar registro.
    *   Neste relatorio repoe os filtros a partir das propriedades do BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPg.txt_4c_Datai.Value   = .this_dDtInicial
                loc_oPg.txt_4c_Dataf.Value   = .this_dDtFinal
                loc_oPg.txt_4c_CdConta.Value = .this_cCdConta
                loc_oPg.txt_4c_DsConta.Value = .this_cDsConta
                loc_oPg.txt_4c_CdRepr.Value  = .this_cCdRepr
                loc_oPg.txt_4c_DsRepr.Value  = .this_cDsRepr
                loc_oPg.opt_4c_Venda.Value   = .this_nOpcaoVenda
                loc_oPg.opt_4c_Pedido.Value  = .this_nOpcaoPedido
            ENDWITH
            THIS.AtualizarEstadoCamposDescricao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de filtro.
    *   Em forms CRUD controla edicao dos campos por modo (INCLUIR/ALTERAR).
    *   Neste relatorio todos os filtros sao sempre editaveis; campos de
    *   descricao obedecem a logica do campo de codigo (When event).
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab
        TRY
            IF PCOUNT() = 0
                loc_lHab = .T.
            ELSE
                loc_lHab = par_lHabilitar
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_Datai.Enabled   = loc_lHab
            loc_oPg.txt_4c_Dataf.Enabled   = loc_lHab
            loc_oPg.txt_4c_CdRepr.Enabled  = loc_lHab
            loc_oPg.txt_4c_CdConta.Enabled = loc_lHab
            loc_oPg.opt_4c_Venda.Enabled   = loc_lHab
            loc_oPg.opt_4c_Pedido.Enabled  = loc_lHab
            IF loc_lHab
                THIS.AtualizarEstadoCamposDescricao()
            ELSE
                loc_oPg.txt_4c_DsRepr.Enabled  = .F.
                loc_oPg.txt_4c_DsConta.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme o modo atual.
    *   Em forms CRUD habilita/desabilita botoes Incluir/Alterar/Excluir/Salvar.
    *   Neste relatorio os botoes estao sempre habilitados (sem modo de edicao).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        TRY
            IF VARTYPE(THIS.cnt_4c_Botoes) = "O"
                THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .T.
                THIS.cnt_4c_Botoes.cmd_4c_Imprimir.Enabled   = .T.
                THIS.cnt_4c_Botoes.cmd_4c_Excel.Enabled      = .T.
                THIS.cnt_4c_Botoes.cmd_4c_Sair.Enabled       = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - "Buscar/Consultar" para form de relatorio
    *   Em CRUD: exibe registro selecionado no grid em modo leitura.
    *   Em REPORT: equivale a visualizar o relatorio com os filtros atuais.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (alias de BtnSairClick).
    *   Compatibilidade com pipeline que espera BtnEncerrarClick em forms.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Operacao de impressao para form de relatorio
    *   Em CRUD: salva registro no banco. Em REPORT: gera saida impressa.
    *   Delega para BtnImprimirClick com dialogo de selecao de impressora.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - "Nova consulta" para form de relatorio
    *   Em CRUD: descarta alteracoes e retorna para lista.
    *   Em REPORT: limpa todos os filtros e reposiciona foco na data inicial.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oPg
        TRY
            THIS.LimparCampos()
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_Datai", 5)
                loc_oPg.txt_4c_Datai.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO (NUNCA chamar .Release em Custom)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGREVISBO.prg):
*==============================================================================
* SIGREVISBO.PRG
* Business Object para Relatorio de Visitas (SIGREVIS)
* Herda de RelatorioBase
*
* Tabela principal: SigCdVis
* Relatorio FRX: SigReVis.frx
*
* Filtros:
*   - Periodo (data inicial / data final)
*   - Conta   (codigo + descricao - campo iclis/rclis de SigCdCli)
*   - Representante (codigo + descricao - campo iclis/rclis de SigCdCli,
*                    filtrado por Grupos = this_cGrupo)
*   - Opcao Venda  (1=Sim / 2=Nao / 3=Ambos)
*   - Opcao Pedido (1=Sim / 2=Nao / 3=Ambos)
*==============================================================================

DEFINE CLASS SIGREVISBO AS RelatorioBase

    *-- Filtro: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro: conta (iclis / rclis de SigCdCli)
    this_cCdConta       = ""
    this_cDsConta       = ""

    *-- Filtro: representante (iclis / rclis de SigCdCli, filtrado por Grupos)
    this_cCdRepr        = ""
    this_cDsRepr        = ""

    *-- Filtro: opcoes (1=Sim, 2=Nao, 3=Ambos - espelha Value do OptionGroup original)
    this_nOpcaoVenda    = 3
    this_nOpcaoPedido   = 3

    *-- Grupo padrao do usuario logado (GrPadVens de SigCdPam)
    *   Corresponde a propriedade custom 'antgru' do form legado SIGREVIS
    this_cGrupo         = ""

    *-- .T. quando o representante foi bloqueado automaticamente no Init
    *   (usuario sem permissao ALTCONTA em SIGCDVIS via fChecaAcesso)
    this_lReprBloqueado = .F.

    *-- Nome do cursor de saida populado por PrepararDados()
    this_cCursorDados   = "crSigCdVis"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de visitas
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdVis"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Carrega parametros iniciais e grupo padrao do usuario.
    * Chamado pelo form em InicializarForm().
    * Equivalente ao bloco de Init() do form legado SIGREVIS que carrega
    * GrPadVens de SigCdPam e verifica permissao ALTCONTA via fChecaAcesso.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Buscar grupo padrao do usuario (GrPadVens de SigCdPam)
            loc_cSQL = "SELECT GrPadVens FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar par" + CHR(226) + ;
                    "metros do sistema (SigCdPam)"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Pam
            THIS.this_cGrupo = ALLTRIM(GrPadVens)
            USE IN cursor_4c_Pam

            *-- Sistema novo: acesso irrestrito a conta/representante para todos os usuarios
            THIS.this_lReprBloqueado = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor crSigCdVis com dados de visitas conforme
    * filtros definidos nas propriedades this_*.
    * Equivalente ao metodo 'processamento' do form legado SIGREVIS.
    * Tambem cria cursor CsCabecalho para cabecalho do relatorio FRX.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_dDtI, loc_dDtF, loc_cDtFSQL
        LOCAL loc_cEmpresa, loc_cTitulo, loc_cPeriodo
        loc_lSucesso = .F.
        TRY
            *-- Normalizar datas: sem data = faixa maxima historica
            loc_dDtI = IIF(EMPTY(THIS.this_dDtInicial), {^1900-01-01}, THIS.this_dDtInicial)
            loc_dDtF = IIF(EMPTY(THIS.this_dDtFinal),   {^2099-12-31}, THIS.this_dDtFinal)

            *-- Data final com 23:59:59 para cobrir dia inteiro (campo DATETIME)
            loc_cDtFSQL = "'" + ;
                PADL(YEAR(loc_dDtF),  4, "0") + "-" + ;
                PADL(MONTH(loc_dDtF), 2, "0") + "-" + ;
                PADL(DAY(loc_dDtF),   2, "0") + " 23:59:59'"

            *-- Clausula WHERE adicional com filtros opcionais
            loc_cWhere = ""

            *-- Filtro conta (iclis de SigCdCli)
            IF !EMPTY(ALLTRIM(THIS.this_cCdConta))
                loc_cWhere = loc_cWhere + ;
                    " AND a.iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdConta))
            ENDIF

            *-- Filtro representante (Contas de SigCdVis = iclis de SigCdCli)
            IF !EMPTY(ALLTRIM(THIS.this_cCdRepr))
                loc_cWhere = loc_cWhere + ;
                    " AND a.Contas = " + EscaparSQL(ALLTRIM(THIS.this_cCdRepr))
            ENDIF

            *-- Fechar cursor anterior se existir
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            *-- Query principal: SigCdVis com JOIN duplo em SigCdCli
            *-- b = conta do cliente (a.iclis), c = representante (a.Contas)
            loc_cSQL = "SELECT a.*," + ;
                " b.rclis AS descri," + ;
                " c.rclis AS repr," + ;
                " CASE WHEN a.vendas=1 THEN 'Sim'" + ;
                "      ELSE 'N" + CHR(227) + "o' END AS descvendas," + ;
                " CASE WHEN a.pedidos=1 THEN 'Sim'" + ;
                "      ELSE 'N" + CHR(227) + "o' END AS descpedidos" + ;
                " FROM SigCdVis a" + ;
                " INNER JOIN SigCdCli b ON a.iclis = b.iclis" + ;
                " INNER JOIN SigCdCli c ON a.Contas = c.iclis" + ;
                " WHERE a.Grupos = " + EscaparSQL(THIS.this_cGrupo) + ;
                " AND a.Datas BETWEEN " + FormatarDataSQL(loc_dDtI) + ;
                " AND " + loc_cDtFSQL + ;
                loc_cWhere + ;
                " ORDER BY a.Contas"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar dados de visitas"
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor de cabecalho para o relatorio (CsCabecalho)
            loc_cEmpresa = ""
            loc_cSQL = "SELECT Razas FROM SigCdEmp"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpCab") > 0
                SELECT cursor_4c_EmpCab
                IF !EOF()
                    loc_cEmpresa = ALLTRIM(cursor_4c_EmpCab.Razas)
                ENDIF
                USE IN cursor_4c_EmpCab
            ENDIF

            loc_cTitulo  = "Relat" + CHR(243) + "rio de Visitas"
            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(loc_dDtI) + ;
                " " + CHR(150) + " " + DTOC(loc_dDtF)

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
            INSERT INTO CsCabecalho (cb_empresa, cb_titulo, cb_periodo) ;
                VALUES (loc_cEmpresa, loc_cTitulo, loc_cPeriodo)

            SELECT (THIS.this_cCursorDados)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Restaura filtros a partir de um cursor de configuracao
    * salva (filtros usados anteriormente pelo usuario).
    *
    * Espera um cursor com os campos opcionais:
    *   dt_inicial, dt_final  (data)
    *   cd_conta,   ds_conta  (char)
    *   cd_repr,    ds_repr   (char)
    *   opc_venda,  opc_pedido (numerico 1/2/3)
    *
    * Cada campo eh aplicado somente se existir no cursor (uso de TYPE() para
    * verificar presenca). Util para "ultimo filtro usado" sem quebrar quando
    * o esquema do cursor evoluir.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + TRANSFORM(par_cAliasCursor)
                loc_lSucesso = .F.
            ENDIF

            loc_cAlias = ALLTRIM(par_cAliasCursor)
            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de filtros vazio"
                loc_lSucesso = .F.
            ENDIF

            *-- Periodo
            IF TYPE(loc_cAlias + ".dt_inicial") = "D"
                THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".dt_inicial")
            ENDIF
            IF TYPE(loc_cAlias + ".dt_final") = "D"
                THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".dt_final")
            ENDIF

            *-- Conta
            IF TYPE(loc_cAlias + ".cd_conta") = "C"
                THIS.this_cCdConta = ALLTRIM(EVALUATE(loc_cAlias + ".cd_conta"))
            ENDIF
            IF TYPE(loc_cAlias + ".ds_conta") = "C"
                THIS.this_cDsConta = ALLTRIM(EVALUATE(loc_cAlias + ".ds_conta"))
            ENDIF

            *-- Representante
            IF TYPE(loc_cAlias + ".cd_repr") = "C"
                THIS.this_cCdRepr = ALLTRIM(EVALUATE(loc_cAlias + ".cd_repr"))
            ENDIF
            IF TYPE(loc_cAlias + ".ds_repr") = "C"
                THIS.this_cDsRepr = ALLTRIM(EVALUATE(loc_cAlias + ".ds_repr"))
            ENDIF

            *-- Opcoes Venda/Pedido (manter dentro de 1..3, default 3=Ambos)
            IF TYPE(loc_cAlias + ".opc_venda") = "N"
                THIS.this_nOpcaoVenda = IIF(BETWEEN(EVALUATE(loc_cAlias + ".opc_venda"), 1, 3), ;
                    EVALUATE(loc_cAlias + ".opc_venda"), 3)
            ENDIF
            IF TYPE(loc_cAlias + ".opc_pedido") = "N"
                THIS.this_nOpcaoPedido = IIF(BETWEEN(EVALUATE(loc_cAlias + ".opc_pedido"), 1, 3), ;
                    EVALUATE(loc_cAlias + ".opc_pedido"), 3)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorios nao persistem dados.
    *
    * Override defensivo: caso o BO seja usado por engano como CRUD, retorna
    * erro explicito ao inves de corromper o banco com INSERT vazio.
    * Equivale a recusa do form legado SIGREVIS, que nao tinha botao "Incluir".
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios de visitas n" + CHR(227) + "o gravam registros." + CHR(13) + ;
            "Use PrepararDados() seguido de Imprimir()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorios nao persistem dados.
    *
    * Override defensivo: simetrico a Inserir(). Reports nao modificam SigCdVis;
    * apenas extraem dados via SELECT em PrepararDados().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios de visitas n" + CHR(227) + "o alteram registros." + CHR(13) + ;
            "Use PrepararDados() seguido de Imprimir()."
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
    * Destroy - Fecha cursores abertos por InicializarFiltros e PrepararDados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        IF USED("cursor_4c_EmpCab")
            USE IN cursor_4c_EmpCab
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

