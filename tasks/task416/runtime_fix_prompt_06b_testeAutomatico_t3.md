# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 3/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnIncluirNavegacao': BtnCancelarClick nao retornou para Page1 (ActivePage=2) | Detalhes: BtnIncluirClick navegou para Page2

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[02/08/2026 06:24:17] FormFea: Erro em ConfigurarResultado:Property FONTNAME is not found.Linha: 4317
[02/08/2026 06:24:17] Erro: Connection handle is invalid.
[02/08/2026 06:24:17] Erro: Function requires row or table buffering mode.
[02/08/2026 06:24:17] FormFea: Erro em CarregarDadosAuxiliares:Connection handle is invalid.
[02/08/2026 06:24:17] FormFea: Erro em CarregarDadosAuxiliares:Connection handle is invalid.
[02/08/2026 06:24:17] FormFea: Erro em CarregarDadosAuxiliares:Connection handle is invalid.
[02/08/2026 06:24:17] FormFea: Erro em CarregarDadosAuxiliares:Connection handle is invalid.
[02/08/2026 06:24:17] Erro: Function requires row or table buffering mode.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-02 06:13:04] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-02 06:13:04] [INFO] Config FPW: (nao fornecido)
[2026-08-02 06:13:04] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-02 06:13:04] [INFO] Timeout: 300 segundos
[2026-08-02 06:13:04] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_murr1xes.prg
[2026-08-02 06:13:04] [INFO] Conteudo do wrapper:
[2026-08-02 06:13:04] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFea', 'C:\4c\tasks\task416', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFea', 'C:\4c\tasks\task416', 'CRUD'
QUIT

[2026-08-02 06:13:04] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_murr1xes.prg
[2026-08-02 06:13:04] [INFO] VFP output esperado em: C:\4c\tasks\task416\vfp_output.txt
[2026-08-02 06:13:04] [INFO] Executando Visual FoxPro 9...
[2026-08-02 06:13:04] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_murr1xes.prg
[2026-08-02 06:13:04] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_murr1xes.prg
[2026-08-02 06:13:04] [INFO] Timeout configurado: 300 segundos
[2026-08-02 06:13:57] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-02 06:13:57] [INFO] VFP9 finalizado em 53.5503573 segundos
[2026-08-02 06:13:57] [INFO] Exit Code: 
[2026-08-02 06:13:57] [INFO] 
[2026-08-02 06:13:57] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-02 06:13:57] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_murr1xes.prg
[2026-08-02 06:13:57] [INFO] 
[2026-08-02 06:13:57] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-02 06:13:57] [INFO] * Auto-generated wrapper for parameters
[2026-08-02 06:13:57] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-02 06:13:57] [INFO] * Parameters: 'FormFea', 'C:\4c\tasks\task416', 'CRUD'
[2026-08-02 06:13:57] [INFO] 
[2026-08-02 06:13:57] [INFO] * Anti-dialog protections for unattended execution
[2026-08-02 06:13:57] [INFO] SET SAFETY OFF
[2026-08-02 06:13:57] [INFO] SET RESOURCE OFF
[2026-08-02 06:13:57] [INFO] SET TALK OFF
[2026-08-02 06:13:57] [INFO] SET NOTIFY OFF
[2026-08-02 06:13:57] [INFO] SYS(2335, 0)
[2026-08-02 06:13:57] [INFO] 
[2026-08-02 06:13:57] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFea', 'C:\4c\tasks\task416', 'CRUD'
[2026-08-02 06:13:57] [INFO] QUIT
[2026-08-02 06:13:57] [INFO] 
[2026-08-02 06:13:57] [INFO] === Fim do Wrapper.prg ===
[2026-08-02 06:13:57] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-02 06:15:24] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-02 06:15:24] [INFO] Config FPW: (nao fornecido)
[2026-08-02 06:15:24] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-02 06:15:24] [INFO] Timeout: 300 segundos
[2026-08-02 06:15:24] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ktjmhvlt.prg
[2026-08-02 06:15:24] [INFO] Conteudo do wrapper:
[2026-08-02 06:15:24] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFea', 'C:\4c\tasks\task416', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFea', 'C:\4c\tasks\task416', 'CRUD'
QUIT

[2026-08-02 06:15:24] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ktjmhvlt.prg
[2026-08-02 06:15:24] [INFO] VFP output esperado em: C:\4c\tasks\task416\vfp_output.txt
[2026-08-02 06:15:24] [INFO] Executando Visual FoxPro 9...
[2026-08-02 06:15:24] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ktjmhvlt.prg
[2026-08-02 06:15:24] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ktjmhvlt.prg
[2026-08-02 06:15:24] [INFO] Timeout configurado: 300 segundos
[2026-08-02 06:16:24] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-02 06:16:24] [INFO] VFP9 finalizado em 59.5111425 segundos
[2026-08-02 06:16:24] [INFO] Exit Code: 
[2026-08-02 06:16:24] [INFO] 
[2026-08-02 06:16:24] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-02 06:16:24] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ktjmhvlt.prg
[2026-08-02 06:16:24] [INFO] 
[2026-08-02 06:16:24] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-02 06:16:24] [INFO] * Auto-generated wrapper for parameters
[2026-08-02 06:16:24] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-02 06:16:24] [INFO] * Parameters: 'FormFea', 'C:\4c\tasks\task416', 'CRUD'
[2026-08-02 06:16:24] [INFO] 
[2026-08-02 06:16:24] [INFO] * Anti-dialog protections for unattended execution
[2026-08-02 06:16:24] [INFO] SET SAFETY OFF
[2026-08-02 06:16:24] [INFO] SET RESOURCE OFF
[2026-08-02 06:16:24] [INFO] SET TALK OFF
[2026-08-02 06:16:24] [INFO] SET NOTIFY OFF
[2026-08-02 06:16:24] [INFO] SYS(2335, 0)
[2026-08-02 06:16:24] [INFO] 
[2026-08-02 06:16:24] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFea', 'C:\4c\tasks\task416', 'CRUD'
[2026-08-02 06:16:24] [INFO] QUIT
[2026-08-02 06:16:24] [INFO] 
[2026-08-02 06:16:24] [INFO] === Fim do Wrapper.prg ===
[2026-08-02 06:16:24] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-02 06:23:17] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-02 06:23:17] [INFO] Config FPW: (nao fornecido)
[2026-08-02 06:23:17] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-02 06:23:17] [INFO] Timeout: 300 segundos
[2026-08-02 06:23:17] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lap4dnfo.prg
[2026-08-02 06:23:17] [INFO] Conteudo do wrapper:
[2026-08-02 06:23:17] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFea', 'C:\4c\tasks\task416', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFea', 'C:\4c\tasks\task416', 'CRUD'
QUIT

[2026-08-02 06:23:17] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lap4dnfo.prg
[2026-08-02 06:23:17] [INFO] VFP output esperado em: C:\4c\tasks\task416\vfp_output.txt
[2026-08-02 06:23:17] [INFO] Executando Visual FoxPro 9...
[2026-08-02 06:23:17] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lap4dnfo.prg
[2026-08-02 06:23:17] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lap4dnfo.prg
[2026-08-02 06:23:17] [INFO] Timeout configurado: 300 segundos
[2026-08-02 06:24:17] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-02 06:24:17] [INFO] VFP9 finalizado em 59.6798381 segundos
[2026-08-02 06:24:17] [INFO] Exit Code: 
[2026-08-02 06:24:17] [INFO] 
[2026-08-02 06:24:17] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-02 06:24:17] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lap4dnfo.prg
[2026-08-02 06:24:17] [INFO] 
[2026-08-02 06:24:17] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-02 06:24:17] [INFO] * Auto-generated wrapper for parameters
[2026-08-02 06:24:17] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-02 06:24:17] [INFO] * Parameters: 'FormFea', 'C:\4c\tasks\task416', 'CRUD'
[2026-08-02 06:24:17] [INFO] 
[2026-08-02 06:24:17] [INFO] * Anti-dialog protections for unattended execution
[2026-08-02 06:24:17] [INFO] SET SAFETY OFF
[2026-08-02 06:24:17] [INFO] SET RESOURCE OFF
[2026-08-02 06:24:17] [INFO] SET TALK OFF
[2026-08-02 06:24:17] [INFO] SET NOTIFY OFF
[2026-08-02 06:24:17] [INFO] SYS(2335, 0)
[2026-08-02 06:24:17] [INFO] 
[2026-08-02 06:24:17] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFea', 'C:\4c\tasks\task416', 'CRUD'
[2026-08-02 06:24:17] [INFO] QUIT
[2026-08-02 06:24:17] [INFO] 
[2026-08-02 06:24:17] [INFO] === Fim do Wrapper.prg ===
[2026-08-02 06:24:17] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormFea",
  "timestamp": "20260802062417",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": true,
      "erro": "",
      "detalhes": "0 registros em cursor_4c_Dados"
    },
    {
      "nome": "ModoIncluir",
      "passou": true,
      "erro": "",
      "detalhes": "Page2 ativada com sucesso"
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
      "erro": "BtnCancelarClick nao retornou para Page1 (ActivePage=2)",
      "detalhes": "BtnIncluirClick navegou para Page2"
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 6 (CONTAKEYPRESS, DCONTAKEYPRESS, DGRUPOKEYPRESS, GRDMOVCHECK1KEYPRESS, GRUPOKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFea.prg):
*==============================================================================
* FormFea.prg - Formulario Fechamento de Estoque (Balanco)
* Formulario origem: SIGCDFEA.SCX (frmcadastro)
* Tipo: OPERACIONAL via estrutura frmcadastro
* BO: FeaBO.prg (SigCdFcx)
* Criado: 2026-08-02 (Fase 5/8 - Page2 Controles Parte 1 + ProcessarBalanco)
*==============================================================================

DEFINE CLASS FormFea AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - Fidelidade UX, layout.json: 1000x718)
    *--------------------------------------------------------------------------
    Height      = 718
    Width       = 1000
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    FontName    = "Tahoma"
    FontSize    = 8

    *--------------------------------------------------------------------------
    * Business Object
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    * Estado operacional do formulario
    *--------------------------------------------------------------------------
    this_cModoAtual   = "LISTA"    && LISTA / INCLUIR / ALTERAR / VISUALIZAR
    this_cPcEscolha   = ""         && operacao corrente (INSERIR/ALTERAR/CONSULTAR/PROCURAR)
    this_lFechamento  = .T.        && registro esta aberto para processamento
    this_lAcInserir   = .F.        && acao de insercao ativa
    this_lEntraPeso   = .F.        && captura de peso via balanca
    this_lCancelar    = .F.        && operacao cancelada (Cancelar click)

    *--------------------------------------------------------------------------
    * Rastreamento de filtros (Page1) para recarregar Grade apenas se mudar
    *--------------------------------------------------------------------------
    this_cAntEmpr   = ""    && empresa anterior (detectar mudanca)
    this_dAntDtIni  = {}    && data inicial anterior
    this_dAntDtFin  = {}    && data final anterior
    this_cPEmps     = ""    && empresa ativa para filtro de balanco

    *==========================================================================
    * Init - Apenas delega ao FormBase (que chama InicializarForm automaticamente)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormFea.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("FeaBO")

            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar FeaBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ELSE
                THIS.Caption = "Balan" + CHR(231) + "o"

                THIS.this_cPEmps    = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                THIS.this_cAntEmpr  = THIS.this_cPEmps

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                THIS.CarregarLista()

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em InicializarForm:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame principal com 2 paginas
    * PageFrame.Top = -29 para ocultar abas (padrao frmcadastro)
    *==========================================================================
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
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 (filtros + grade de balanco)
    * FASE 4: cabecalho, botoes CRUD, filtro periodo, grade completa
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho escuro (cntSombra no legado)
        *-- Top=31 = 2 (original) + 29 (compensacao PageFrame.Top=-29)
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
            .Caption   = "Balan" + CHR(231) + "o"
            .Top       = 20
            .Left      = 12
            .Width     = THIS.Width
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
            .Caption   = "Balan" + CHR(231) + "o"
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container botoes de operacao (Grupo_Op no legado)
        *-- Top=29 = 0 (original) + 29 (compensacao); Width=385 acomoda 5 botoes de Width=75
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 385
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
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

        *-- Container saida/encerrar - padrao canonico (CLAUDE.md regra #10)
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

        *-- Container filtro de periodo (Cnt_periodo no legado)
        *-- Top=113 = 84 (original) + 29 (compensacao)
        loc_oPagina.AddObject("cnt_4c_Periodo", "Container")
        WITH loc_oPagina.cnt_4c_Periodo
            .Top         = 113
            .Left        = 21
            .Width       = 332
            .Height      = 59
            .BackColor   = RGB(255, 255, 255)
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- Label Empresa (Say4 no legado: top=7, left=16)
        loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Empresa
            .Caption   = "Empresa : "
            .Top       = 7
            .Left      = 16
            .Width     = 63
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Empresa (Get_cd_empresa no legado: top=4, left=79, width=35)
        *-- MaxLength=3 obrigatorio (CLAUDE.md: SigCdEmp char(3))
        loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPagina.cnt_4c_Periodo.txt_4c_Empresa
            .Value         = THIS.this_cPEmps
            .Top           = 4
            .Left          = 79
            .Width         = 35
            .Height        = 23
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_Empresa, "KeyPress", THIS, "EmpresaLostFocus")

        *-- Label Periodo (Label1 no legado: top=32, left=22)
        loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo : "
            .Top       = 32
            .Left      = 22
            .Width     = 57
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data Inicial (Dt_inicial no legado: top=29, left=79, width=80)
        loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.cnt_4c_Periodo.txt_4c_DtInicial
            .Value         = DATE()
            .Top           = 29
            .Left          = 79
            .Width         = 80
            .Height        = 23
            .Format        = "D"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")

        *-- Label separador entre datas (Say2 no legado: top=32, left=164, caption=CHR(224))
        loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Sep", "Label")
        WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Sep
            .Caption   = CHR(224)
            .Top       = 32
            .Left      = 164
            .Width     = 12
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data Final (Dt_final no legado: top=29, left=177, width=80)
        loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.cnt_4c_Periodo.txt_4c_DtFinal
            .Value         = DATE()
            .Top           = 29
            .Left          = 177
            .Width         = 80
            .Height        = 23
            .Format        = "D"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtFinal, "KeyPress", THIS, "DtFinalLostFocus")

        *-- Botao Posicao Balanco (btnPosicao no legado: top=4+29=33, left=474)
        loc_oPagina.AddObject("cmd_4c_PosicaoBal", "CommandButton")
        WITH loc_oPagina.cmd_4c_PosicaoBal
            .Caption       = "Posi" + CHR(231) + CHR(227) + "o \<Bal."
            .Top           = 33
            .Left          = 474
            .Width         = 64
            .Height        = 55
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(224, 224, 224)
            .Themes        = .F.
            .SpecialEffect = 1
            .MousePointer  = 15
            .WordWrap      = .T.
            .AutoSize      = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_PosicaoBal, "Click", THIS, "BtnPosicaoBalClick")

        *-- Grade de balanco (Grade no legado, Page1)
        *-- ColumnCount FORA do WITH (Problema 36: dentro nao cria colunas imediatamente)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 5
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 175
            .Left               = 21
            .Width              = 884
            .Height             = 540
            .FontName           = "Tahoma"
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
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GradeAfterRowColChange")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2 (edicao + resultado de balanco)
    * FASE 5: container BotoesAcao + botoes Confirmar/Cancelar + Shape +
    *         Label/TextBox Codigo + Label/TextBox Data + cmd Processar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes acao - Confirmar + Cancelar (Grupo_Salva no legado)
        *-- Top=46 = 17 (original) + 29 (compensacao)
        *-- Width=90 inicial (Cancelar oculto); 173 quando modo INSERIR com Fechamento
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 46
            .Left        = 817
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva no legado: left=5, top=5, w=75, h=75)
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
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

        *-- Botao Cancelar (Cancelar no legado: left=80, top=5; inicia oculto)
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
            .Visible         = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Shape de borda ao redor dos campos de entrada (Shape1 no legado)
        *-- Top=36 = 7 (original) + 29 (compensacao)
        loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPagina.shp_4c_Shape1
            .Top         = 36
            .Left        = 9
            .Width       = 662
            .Height      = 110
            .BorderColor = RGB(90, 90, 90)
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- Label Codigo (Label4 no legado: top=24+29=53, left=30, w=42)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 53
            .Left      = 30
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (Get_Codigo no legado: top=19+29=48, left=75, w=54)
        *-- ReadOnly=.T. por padrao; edita em modo PROCURAR via HabilitarCampos
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = 0
            .Top           = 48
            .Left          = 75
            .Width         = 54
            .Height        = 25
            .InputMask     = "999999"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label Data (Label3 no legado: top=24+29=53, left=158, w=32)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Data :"
            .Top       = 53
            .Left      = 158
            .Width     = 32
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data (Get_Data no legado: top=19+29=48, left=198, w=80)
        *-- Format="K" limpa ao digitar; FontName="Courier New" FontSize=9 (legado)
        loc_oPagina.AddObject("txt_4c_Data", "TextBox")
        WITH loc_oPagina.txt_4c_Data
            .Value         = {}
            .Top           = 48
            .Left          = 198
            .Width         = 80
            .Height        = 25
            .Format        = "K"
            .FontName      = "Courier New"
            .FontSize      = 9
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Data, "InteractiveChange", THIS, "DadosInteractiveChange")
        BINDEVENT(loc_oPagina.txt_4c_Data, "KeyPress", THIS, "DataLostFocus")

        *-- Label Grupo (Label1 no legado: top=51+29=80, left=34, w=38)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Grupo :"
            .Top       = 80
            .Left      = 34
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo do Grupo (Get_Grupo no legado: top=46+29=75, left=75, w=80)
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value         = ""
            .Top           = 75
            .Left          = 75
            .Width         = 80
            .Height        = 25
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "GrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "DblClick", THIS, "GrupoDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "InteractiveChange", THIS, "DadosInteractiveChange")

        *-- TextBox Descricao Grupo (Get_DGrupo no legado: top=46+29=75, left=157, w=290)
        loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DGrupo
            .Value         = ""
            .Top           = 75
            .Left          = 157
            .Width         = 290
            .Height        = 25
            .MaxLength     = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DGrupo, "KeyPress", THIS, "DGrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DGrupo, "DblClick", THIS, "DGrupoDblClick")
        BINDEVENT(loc_oPagina.txt_4c_DGrupo, "InteractiveChange", THIS, "DadosInteractiveChange")

        *-- Label Conta (Label2 no legado: top=78+29=107, left=34, w=38)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Conta :"
            .Top       = 107
            .Left      = 34
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo da Conta (Get_Conta no legado: top=73+29=102, left=75, w=80)
        loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.txt_4c_Conta
            .Value         = ""
            .Top           = 102
            .Left          = 75
            .Width         = 80
            .Height        = 25
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ContaKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Conta, "DblClick", THIS, "ContaDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Conta, "InteractiveChange", THIS, "DadosInteractiveChange")

        *-- TextBox Descricao Conta (Get_DConta no legado: top=73+29=102, left=157, w=290)
        loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPagina.txt_4c_DConta
            .Value         = ""
            .Top           = 102
            .Left          = 157
            .Width         = 290
            .Height        = 25
            .MaxLength     = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DConta, "KeyPress", THIS, "DContaKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DConta, "DblClick", THIS, "DContaDblClick")
        BINDEVENT(loc_oPagina.txt_4c_DConta, "InteractiveChange", THIS, "DadosInteractiveChange")

        *-- Label Lote (Label5 no legado: top=51+29=80, left=504, w=30)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Lote :"
            .Top       = 80
            .Left      = 504
            .Width     = 30
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Lote (getlote no legado: top=46+29=75, left=543, w=54)
        *-- Editavel somente quando !Fechamento (posicao sem balanco)
        loc_oPagina.AddObject("txt_4c_Lote", "TextBox")
        WITH loc_oPagina.txt_4c_Lote
            .Value         = 0
            .Top           = 75
            .Left          = 543
            .Width         = 54
            .Height        = 25
            .InputMask     = "999999"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Botao Processar (Processar no legado: top=22+29=51, left=747, w=75, h=75)
        *-- FontName="Comic Sans MS" FontBold=.T. do legado
        loc_oPagina.AddObject("cmd_4c_Processar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Processar
            .Caption         = "\<Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .PicturePosition = 13
            .Top             = 51
            .Left            = 747
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
        BINDEVENT(loc_oPagina.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

        *-- Container resultado (Resultado no legado)
        *-- INICIA OCULTO - torna-se visivel apos BtnProcessarClick executar
        *-- Top=152 = 123 (original) + 29 (compensacao)
        loc_oPagina.AddObject("cnt_4c_Resultado", "Container")
        WITH loc_oPagina.cnt_4c_Resultado
            .Top         = 152
            .Left        = 10
            .Width       = 980
            .Height      = 460
            .BackColor   = RGB(255, 255, 255)
            .BackStyle   = 1
            .Visible     = .F.
        ENDWITH

        THIS.ConfigurarResultado(loc_oPagina.cnt_4c_Resultado)

        *-- Bind Page2.Activate -> AjustarBotoesPorModo (Pagina.Dados.Activate no legado)
        BINDEVENT(loc_oPagina, "Activate", THIS, "AjustarBotoesPorModo")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Preserva containers que devem iniciar ocultos (cnt_4c_Resultado)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_nP, loc_oObjeto, loc_cNome

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                IF INLIST(loc_cNome, "CNT_4C_CABECALHO", "CNT_4C_RESULTADO", "CNT_4C_CONVERSAO")
                    THIS.TornarControlesVisiveis(loc_oObjeto)
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

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados/formulario)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.pgf_4c_Paginas.Page1.Enabled = .T.
                    THIS.CarregarLista()
                ELSE
                    THIS.pgf_4c_Paginas.Page1.Enabled = .F.
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, ;
                "FormFea.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega/recarrega grid da Page1 com dados do periodo filtrado
    * OBRIGATORIO: rebind ControlSource + Headers APOS RecordSource (Problema 2/48)
    * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid, loc_cEmp, loc_dDtI, loc_dDtF
        loc_lResultado = .F.

        TRY
            loc_cEmp = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Empresa.Value)
            loc_dDtI = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtInicial.Value
            loc_dDtF = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtFinal.Value

            THIS.this_oBusinessObject.PreencherFiltro(loc_cEmp, loc_dDtI, loc_dDtF)

            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount  = 5
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.grupos"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.contas"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.datas"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.datais"

                loc_oGrid.Column1.Width = 70
                loc_oGrid.Column2.Width = 120
                loc_oGrid.Column3.Width = 120
                loc_oGrid.Column4.Width = 200
                loc_oGrid.Column5.Width = 200

                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Grupo"
                loc_oGrid.Column3.Header1.Caption = "Conta"
                loc_oGrid.Column4.Header1.Caption = "Data Final"
                loc_oGrid.Column5.Header1.Caption = "Data Inicial"

                THIS.FormatarGridLista(loc_oGrid)

                THIS.this_cAntEmpr  = loc_cEmp
                THIS.this_dAntDtIni = loc_dDtI
                THIS.this_dAntDtFin = loc_dDtF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormFea.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        *-- Garantir cursor minimo para o grid mesmo sem conexao ao banco
        IF !USED("cursor_4c_Dados")
            CREATE CURSOR cursor_4c_Dados (Emps C(3), Codigos N(6,0), Grupos C(10), ;
                Contas C(10), Datais T, Datas T, Cpros C(14), Entradas N(11,3), ;
                Fadmins N(11,3), Freals N(11,3), Pesagems N(11,3), Saidas N(11,3), ;
                Saldos N(11,3), Usuars C(10), CidChaves C(20))
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Aplica formatacao visual ao grid de lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro ao formatar grid:" + CHR(13) + loc_oErro.Message, ;
                "FormFea.FormatarGridLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChange - Rastreia mudanca de linha no grid
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    * AfterRowColChange requer LPARAMETERS par_nColIndex (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_lTemRegistro
        loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0

        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
            .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
            .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Abre Page2 para incluir novo balanco
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_cPcEscolha  = "INSERIR"
        THIS.this_lFechamento = .T.
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual  = "INCLUIR"
        THIS.AlternarPagina(2)
        THIS.AjustarBotoesPorModo()
        THIS.HabilitarCampos()
        *-- Inicializa Data apos AjustarBotoesPorModo (evita sobrescrita por BOParaForm)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Data.Value = DATE()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Abre Page2 em modo consulta (somente leitura)
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCidChaves
        loc_cCidChaves = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
        ENDIF

        IF EMPTY(loc_cCidChaves)
            MsgAviso("Selecione um registro para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                THIS.this_cPcEscolha = "CONSULTAR"
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.AlternarPagina(2)
                THIS.AjustarBotoesPorModo()
                THIS.HabilitarCampos()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre Page2 para alterar balanco selecionado
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCidChaves
        loc_cCidChaves = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
        ENDIF

        IF EMPTY(loc_cCidChaves)
            MsgAviso("Selecione um registro para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cPcEscolha = "ALTERAR"
                THIS.this_cModoAtual = "ALTERAR"
                THIS.AlternarPagina(2)
                THIS.AjustarBotoesPorModo()
                THIS.HabilitarCampos()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui balanco selecionado com confirmacao
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCidChaves, loc_lConfirma
        loc_cCidChaves = ""
        loc_lConfirma  = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
        ENDIF

        IF EMPTY(loc_cCidChaves)
            MsgAviso("Selecione um registro para excluir.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste balan" + CHR(231) + "o?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                IF loc_lConfirma
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega lista com filtros correntes
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnPosicaoBalClick - Posiciona para incluir novo balanco (btnPosicao legado)
    * Legado: Fechamento=.F. + plAcInserir=.T. + Grupo_Op.Click(1)
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE BtnPosicaoBalClick()
        THIS.this_lFechamento = .F.
        THIS.this_lAcInserir  = .T.
        THIS.BtnIncluirClick()
    ENDPROC

    *==========================================================================
    * EmpresaLostFocus - Valida empresa e recarrega lista se empresa mudou
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE EmpresaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cEmp
        loc_cEmp = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Empresa.Value)

        IF EMPTY(loc_cEmp)
            MsgAviso("Empresa de preenchimento obrigat" + CHR(243) + "rio.")
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Empresa.SetFocus()
        ELSE
            THIS.this_cPEmps = loc_cEmp
            IF loc_cEmp <> THIS.this_cAntEmpr
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * DtInicialLostFocus - Sincroniza DtFinal se DtInicial > DtFinal; recarrega
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE DtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_dDtI, loc_dDtF, loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
        loc_dDtI = loc_oCnt.txt_4c_DtInicial.Value
        loc_dDtF = loc_oCnt.txt_4c_DtFinal.Value

        IF VARTYPE(loc_dDtI) = "D" AND VARTYPE(loc_dDtF) = "D"
            IF loc_dDtI > loc_dDtF
                loc_oCnt.txt_4c_DtFinal.Value = loc_dDtI
                loc_dDtF = loc_dDtI
            ENDIF
        ENDIF

        IF loc_dDtI <> THIS.this_dAntDtIni OR loc_dDtF <> THIS.this_dAntDtFin
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * DtFinalLostFocus - Sincroniza DtInicial se DtFinal < DtInicial; recarrega
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE DtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_dDtI, loc_dDtF, loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
        loc_dDtI = loc_oCnt.txt_4c_DtInicial.Value
        loc_dDtF = loc_oCnt.txt_4c_DtFinal.Value

        IF VARTYPE(loc_dDtI) = "D" AND VARTYPE(loc_dDtF) = "D"
            IF loc_dDtF < loc_dDtI
                loc_oCnt.txt_4c_DtInicial.Value = loc_dDtF
                loc_dDtI = loc_dDtF
            ENDIF
        ENDIF

        IF loc_dDtI <> THIS.this_dAntDtIni OR loc_dDtF <> THIS.this_dAntDtFin
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta visibilidade/estado dos botoes ao entrar Page2
    * Dispara via BINDEVENT em Page2.Activate (Pagina.Dados.Activate no legado)
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lCancelarVisivel, loc_lConsultar, loc_lSomenteVisual

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Carregar dados auxiliares de lookup (uma vez ao entrar em Page2)
            THIS.CarregarDadosAuxiliares()

            loc_lConsultar      = (THIS.this_cPcEscolha = "CONSULTAR") OR !THIS.this_lFechamento
            loc_lSomenteVisual  = (THIS.this_cPcEscolha = "CONSULTAR")
            loc_lCancelarVisivel = (THIS.this_cPcEscolha <> "CONSULTAR") AND THIS.this_lFechamento

            *-- Cancelar: visivel apenas quando pode cancelar uma edicao real
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Visible = loc_lCancelarVisivel

            *-- Confirmar.Cancel: ativado por ESC quando nao se pode confirmar
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Cancel = loc_lConsultar

            *-- Width do container: 90 so Confirmar / 173 Confirmar + Cancelar
            loc_oPagina.cnt_4c_BotoesAcao.Width = IIF(loc_lConsultar, 90, 173)

            *-- Processar: visivel somente em INSERIR
            loc_oPagina.cmd_4c_Processar.Visible = (THIS.this_cPcEscolha = "INSERIR")

            *-- txt_4c_Data: editavel em INSERIR/ALTERAR ou quando !Fechamento
            loc_oPagina.txt_4c_Data.ReadOnly = loc_lSomenteVisual AND THIS.this_lFechamento

            *-- Popula campos da BOParaForm (crSigCdFcx -> form)
            THIS.BOParaForm()

            *-- Para CONSULTAR/EXCLUIR: exibir resultado salvo
            IF INLIST(THIS.this_cPcEscolha, "CONSULTAR", "EXCLUIR")
                THIS.CarregarDados()
                loc_oPagina.cnt_4c_Resultado.Visible = .T.
            ELSE
                loc_oPagina.cnt_4c_Resultado.Visible = .F.
            ENDIF

            *-- Para INSERIR e !Fechamento (posicao): Confirmar habilitado
            IF THIS.this_cPcEscolha <> "INSERIR" OR !THIS.this_lFechamento
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormFea")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDadosAuxiliares - Carrega cursores de lookup necessarios para
    * ProcessarBalanco: TmpGccr, TmpCli, TmpPro, crSigOpOpt, LocalOpp, crSigCdOpe
    * Chamado por AjustarBotoesPorModo ao entrar em Page2
    *==========================================================================
    PROTECTED PROCEDURE CarregarDadosAuxiliares()
        LOCAL loc_cSql, loc_cEmpr
        loc_cEmpr = THIS.this_cPEmps

        TRY
            *-- crSigCdPac - parametros de conta do balanco
            IF !USED("crSigCdPac")
                loc_cSql = "SELECT TOP 1 * FROM SigCdPac WHERE Emps = " + EscaparSQL(loc_cEmpr)
                =SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPac")
            ENDIF

            *-- crSigCdPam - parametros de material do balanco
            IF !USED("crSigCdPam")
                loc_cSql = "SELECT TOP 1 * FROM SigCdPam WHERE Emps = " + EscaparSQL(loc_cEmpr)
                =SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPam")
            ENDIF

            *-- TmpGccr - grupos de balanco (SigCdGcr, filtrando GerBals=1)
            IF !USED("TmpGccr")
                loc_cSql = "SELECT Codigos, Descrs, UnifBals, GruFals FROM SigCdGcr WHERE GerBals = 1"
                IF SQLEXEC(gnConnHandle, loc_cSql, "TmpGccr") > 0
                    SELECT TmpGccr
                    INDEX ON Codigos TAG BalCodigo
                    INDEX ON Descrs  TAG BalDescrs
                    SET ORDER TO BalCodigo
                ENDIF
            ENDIF

            *-- TmpCli - contas de balanco (clientes/contas correntes)
            IF !USED("TmpCli")
                loc_cSql = "SELECT IClis, RClis, PagFals, RecFals, GruFals, Inativas, IClis AS BalCodigo, RClis AS BalNome " + ;
                           "FROM SigCdCli WHERE Emps = " + EscaparSQL(loc_cEmpr)
                IF SQLEXEC(gnConnHandle, loc_cSql, "TmpCli") > 0
                    SELECT TmpCli
                    INDEX ON BalCodigo TAG BalCodigo
                    INDEX ON BalNome   TAG BalNome
                    SET ORDER TO BalCodigo
                ENDIF
            ENDIF

            *-- TmpPro - produtos/materiais (SigCdPro)
            IF !USED("TmpPro")
                loc_cSql = "SELECT CPros, CUnis, Varias, Cgrus, MatPrincs, Custofs, MoeCusfs FROM SigCdPro"
                IF SQLEXEC(gnConnHandle, loc_cSql, "TmpPro") > 0
                    SELECT TmpPro
                    INDEX ON CPros TAG CPros
                    SET ORDER TO CPros
                ENDIF
            ENDIF

            *-- crSigOpOpt - opcoes de operacao (SigOpOpt)
            IF !USED("crSigOpOpt")
                loc_cSql = "SELECT Cods, PFalhas, TFalhas, Trabas, Prodzs, IndProds FROM SigOpOpt"
                IF SQLEXEC(gnConnHandle, loc_cSql, "crSigOpOpt") > 0
                    SELECT crSigOpOpt
                    INDEX ON Cods TAG Cods
                    SET ORDER TO Cods
                ENDIF
            ENDIF

            *-- LocalOpp - tipos de operacao de producao (SigCdOpd)
            IF !USED("LocalOpp")
                loc_cSql = "SELECT Dopps, Origems, Destinos, EstOrigs, EstDests FROM SigCdOpd"
                IF SQLEXEC(gnConnHandle, loc_cSql, "LocalOpp") > 0
                    SELECT LocalOpp
                    INDEX ON Dopps TAG Dopps
                    SET ORDER TO Dopps
                ENDIF
            ENDIF

            *-- crSigCdOpe - tipos de operacao de estoque (SigCdOpe)
            IF !USED("crSigCdOpe")
                loc_cSql = "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests, Opers FROM SigCdOpe"
                IF SQLEXEC(gnConnHandle, loc_cSql, "crSigCdOpe") > 0
                    SELECT crSigCdOpe
                    INDEX ON Dopes TAG Dopes
                    SET ORDER TO Dopes
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarDadosAuxiliares:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Preenche controles visuais a partir do BO / crSigCdFcx
    * Fase 5: Codigo e Data (Grupo/Conta/Lote em Fase 6)
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
                loc_oPagina.txt_4c_Codigo.Value = NVL(crSigCdFcx.Codigos, 0)

                IF VARTYPE(crSigCdFcx.Datas) = "T" OR VARTYPE(crSigCdFcx.Datas) = "D"
                    IF VARTYPE(crSigCdFcx.Datas) = "T"
                        loc_oPagina.txt_4c_Data.Value = TTOD(crSigCdFcx.Datas)
                    ELSE
                        loc_oPagina.txt_4c_Data.Value = crSigCdFcx.Datas
                    ENDIF
                ENDIF

                *-- Fase 6: txt_4c_Grupo, txt_4c_DGrupo, txt_4c_Conta, txt_4c_DConta, txt_4c_Lote
                IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
                    loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(NVL(crSigCdFcx.Grupos, ""))
                    =SEEK(ALLTRIM(crSigCdFcx.Grupos), "TmpGccr", "BalCodigo")
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5) AND USED("TmpGccr") AND !EOF("TmpGccr")
                        loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(TmpGccr.Descrs)
                    ENDIF
                ENDIF

                IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
                    loc_oPagina.txt_4c_Conta.Value = ALLTRIM(NVL(crSigCdFcx.Contas, ""))
                    =SEEK(ALLTRIM(crSigCdFcx.Contas), "TmpCli", "BalCodigo")
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5) AND USED("TmpCli") AND !EOF("TmpCli")
                        loc_oPagina.txt_4c_DConta.Value = ALLTRIM(TmpCli.RClis)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Le controles visuais e atualiza BO / crSigCdFcx
    * Fase 5: Data (Grupo/Conta em Fase 6)
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
                SELECT crSigCdFcx
                REPLACE crSigCdFcx.Datas WITH loc_oPagina.txt_4c_Data.Value

                IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
                    REPLACE crSigCdFcx.Grupos WITH PADR(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value), LEN(crSigCdFcx.Grupos))
                ENDIF
                IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
                    REPLACE crSigCdFcx.Contas WITH PADR(ALLTRIM(loc_oPagina.txt_4c_Conta.Value), LEN(crSigCdFcx.Contas))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme modo (legado: When())
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos()
        LOCAL loc_oPagina, loc_lEdita, loc_lProcurar
        TRY
            loc_oPagina  = THIS.pgf_4c_Paginas.Page2
            loc_lEdita   = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") OR !THIS.this_lFechamento
            loc_lProcurar = (THIS.this_cPcEscolha = "PROCURAR")

            *-- Codigo: editavel somente em PROCURAR
            loc_oPagina.txt_4c_Codigo.ReadOnly = !loc_lProcurar

            *-- Data: editavel em INSERIR/ALTERAR ou posicao
            loc_oPagina.txt_4c_Data.ReadOnly = !loc_lEdita

            *-- Fase 6: Grupo, DGrupo, Conta, DConta, Lote (guardados por PEMSTATUS)
            IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
                loc_oPagina.txt_4c_Grupo.ReadOnly = !loc_lEdita
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
                loc_oPagina.txt_4c_DGrupo.ReadOnly = !(EMPTY(loc_oPagina.txt_4c_Grupo.Value) AND loc_lEdita)
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
                loc_oPagina.txt_4c_Conta.ReadOnly = !loc_lEdita
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
                loc_oPagina.txt_4c_DConta.ReadOnly = !(EMPTY(loc_oPagina.txt_4c_Conta.Value) AND loc_lEdita)
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_Lote", 5)
                loc_oPagina.txt_4c_Lote.ReadOnly = THIS.this_lFechamento
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa campos da Page2 (Fase 5: Data; Fase 6: restantes)
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oPagina.txt_4c_Data.Value = DATE()
            IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
                loc_oPagina.txt_4c_Grupo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
                loc_oPagina.txt_4c_DGrupo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
                loc_oPagina.txt_4c_Conta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
                loc_oPagina.txt_4c_DConta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_Lote", 5)
                loc_oPagina.txt_4c_Lote.Value = 0
            ENDIF
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
            loc_oPagina.cnt_4c_Resultado.Visible = .F.
        CATCH TO loc_oErro
            MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarDados - Carrega resultado de balanco para CONSULTAR/EXCLUIR
    * Equivale a ThisForm.CarregaDados do legado (nao extraido - implementado)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDados()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("CrSigCdFea") AND !EOF("CrSigCdFea") AND ;
               USED("TmpResumo") AND RECCOUNT("TmpResumo") > 0
                *-- Dados ja carregados em TmpResumo pelo ultimo ProcessarBalanco
                loc_lResultado = .T.
            ELSE
                *-- Para CONSULTAR/EXCLUIR sem processamento anterior:
                *-- carregar do SigOpCfe (saldos salvos) vinculados ao crSigCdFcx
                IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
                    LOCAL loc_cSql
                    loc_cSql = "SELECT * FROM SigOpCfe WHERE Codigos = " + ;
                               TRANSFORM(crSigCdFcx.Codigos) + ;
                               " AND Emps = " + EscaparSQL(ALLTRIM(crSigCdFcx.Emps)) + ;
                               " ORDER BY Codigos, Cpros"
                    IF SQLEXEC(gnConnHandle, loc_cSql, "CrSaldoCarreg") > 0
                        *-- Popula TmpResumo a partir dos saldos salvos
                        IF !USED("TmpResumo")
                            CREATE CURSOR TmpResumo (Grupo C(10), Conta C(10), CMats C(14), ;
                                CUnis C(10), Saldoi N(12,3), FReal N(12,3), FAdmin N(12,3), ;
                                Saldof N(12,3), PfTrabs N(8,2), IndProd N(8,2), ;
                                PesoEnts N(12,3), PesoSais N(12,3), QtdeEnts N(12,3), ;
                                QtdeSais N(12,3), PesoFabre N(12,3), PesoFabrs N(12,3), ;
                                Pesagem N(12,3), Pesagem2 N(12,3), Pesagem3 N(12,3), ;
                                Varias N(1), Agregas N(1), Visivel L, ;
                                Flag L, Flag2 L, Flag3 L, CodCors C(4), CodTams C(4))
                            INDEX ON Grupo + Conta + CMats TAG GrConMat
                            SET ORDER TO GrConMat
                        ELSE
                            SELECT TmpResumo
                            ZAP
                            SET ORDER TO GrConMat
                        ENDIF
                        SELECT CrSaldoCarreg
                        SCAN
                            INSERT INTO TmpResumo (Grupo, Conta, CMats, Saldof) ;
                                VALUES (crSigCdFcx.Grupos, crSigCdFcx.Contas, ;
                                        CrSaldoCarreg.Cpros, CrSaldoCarreg.Pesagems)
                        ENDSCAN
                        IF USED("CrSaldoCarreg")
                            USE IN CrSaldoCarreg
                        ENDIF
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarDados:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DadosInteractiveChange - Oculta resultado e desabilita Confirmar
    * Disparado por InteractiveChange em txt_4c_Data (Fase 5) e futuramente
    * txt_4c_Grupo, txt_4c_DGrupo, txt_4c_Conta, txt_4c_DConta (Fase 6)
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE DadosInteractiveChange()
        TRY
            IF THIS.this_lFechamento
                THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
            ENDIF
            THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Visible = .F.
        CATCH TO loc_oErro
            MsgErro("Erro em DadosInteractiveChange:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * DataLostFocus - Copia data de fechamento para campo DataCc no Resultado
    * Legado: Get_Data.LostFocus - copia valor para Resultado.Cnt_Conversao.Get_DataCc
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE DataLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "cnt_4c_Conversao", 5)
                IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao, "txt_4c_DataCc", 5)
                    loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao.txt_4c_DataCc.Value = ;
                        loc_oPagina.txt_4c_Data.Value
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DataLostFocus:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Salva o balanco apos validacao
    * Legado: Salva.Click (Grupo_Salva no legado)
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lResultado, loc_oPagina, loc_cGrupo, loc_cConta, loc_dData, loc_dDataCc
        loc_lResultado = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_dData   = loc_oPagina.txt_4c_Data.Value
            loc_cGrupo  = ""
            loc_cConta  = ""
            loc_dDataCc = {}

            IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
                loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
                loc_cConta = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
            ENDIF
            IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "cnt_4c_Conversao", 5)
                IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao, "txt_4c_DataCc", 5)
                    loc_dDataCc = loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao.txt_4c_DataCc.Value
                ENDIF
            ENDIF

            IF THIS.this_lFechamento AND THIS.this_cPcEscolha = "INSERIR"
                *-- Validar Data
                IF EMPTY(loc_dData)
                    MsgAviso("A Data Deve Ser Informada...")
                    loc_oPagina.txt_4c_Data.SetFocus()
                ELSE
                    IF EMPTY(loc_cGrupo)
                    MsgAviso("O Grupo Deve Ser Informado...")
                    IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
                        loc_oPagina.txt_4c_Grupo.SetFocus()
                    ENDIF
                ELSE
                    IF EMPTY(loc_cConta)
                    MsgAviso("A Conta Deve Ser Informada...")
                    IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
                        loc_oPagina.txt_4c_Conta.SetFocus()
                    ENDIF
                ELSE
                    *-- Validar DataCc >= Data
                    IF VARTYPE(loc_dDataCc) = "D" AND !EMPTY(loc_dDataCc) AND loc_dDataCc < loc_dData
                        MsgAviso("A Data de Lan" + CHR(231) + "amento N" + CHR(227) + "o Pode Ser" + CHR(13) + ;
                                 "Menor Que a Data de Fechamento...")
                        IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "cnt_4c_Conversao", 5)
                            IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao, "txt_4c_DataCc", 5)
                                loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao.txt_4c_DataCc.SetFocus()
                            ENDIF
                        ENDIF
                    ELSE
                        IF MsgConfirma("Esta Opera" + CHR(231) + CHR(227) + "o Ir" + CHR(225) + ;
                                       " Encerrar o Balan" + CHR(231) + "o da Conta " + ;
                                       loc_cGrupo + " / " + loc_cConta + "." + CHR(13) + CHR(13) + ;
                                       "As Diferen" + CHR(231) + "as Selecionadas Na Tabela de Materiais " + ;
                                       "Ser" + CHR(227) + "o Lan" + CHR(231) + "adas Nesta Conta..." + ;
                                       CHR(13) + CHR(13) + "Deseja Prosseguir ?", ;
                                       "Aten" + CHR(231) + CHR(227) + "o!!!")
                        THIS.FormParaBO()
                        IF THIS.this_oBusinessObject.Salvar()
                            THIS.this_lFechamento = .T.
                            THIS.AlternarPagina(1)
                            loc_lResultado = .T.
                        ENDIF
                        ENDIF
                    ENDIF
                    ENDIF
                    ENDIF
                ENDIF
            ELSE
                IF THIS.this_lFechamento
                    THIS.FormParaBO()
                    IF THIS.this_oBusinessObject.Salvar()
                        THIS.this_lFechamento = .T.
                        THIS.AlternarPagina(1)
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    *-- Modo posicao (!Fechamento): apenas reverter e voltar
                    SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
                    THIS.this_lFechamento = .T.
                    THIS.AlternarPagina(1)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnConfirmarClick:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormFea")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias canonico de BtnConfirmarClick
    * O botao real e cmd_4c_Confirmar (padrao CLAUDE.md regra #10 para SAIDA).
    * Este metodo existe para atender contratos que esperam o nome "Salvar".
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        RETURN THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para Page1
    * Legado: Cancelar.Click (Grupo_Salva no legado)
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_lCancelar = .T.
            THIS.this_lFechamento = .T.
            *-- Rollback best-effort: nao bloqueia navegacao se conexao invalida
            TRY
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
            CATCH TO loc_oErroRb
                IF !("invalid" $ LOWER(loc_oErroRb.Message))
                    MsgErro("Erro no rollback:" + CHR(13) + loc_oErroRb.Message, "FormFea.BtnCancelarClick")
                ENDIF
            ENDTRY
            THIS.AlternarPagina(1)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em BtnCancelarClick:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * IncluirHistorico - Insere registro nos cursores TmpHist e TmpHistC
    * Traducao de inclui_historico (legado). Chamado em SCAN loops dentro
    * de ProcessarBalanco para cada movimento de entrada/saida.
    * PUBLIC: BINDEVENT/SCAN exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE IncluirHistorico(par_cArquivo, par_cTipoConta, par_cTipo, ;
                               par_nValor, par_nPeso, par_nPesoFabr, ;
                               par_cGrupoo, par_cContao, par_cGrupod, par_cContad)
        LOCAL loc_nEntrada, loc_nSaida, loc_nPEntrada, loc_nPSaida
        LOCAL loc_nPfEntrada, loc_nPfSaida
        LOCAL loc_cGrupo, loc_cConta, loc_cGrupo2, loc_cConta2

        STORE 0 TO loc_nEntrada, loc_nSaida, loc_nPEntrada, loc_nPSaida, loc_nPfEntrada, loc_nPfSaida

        IF par_cTipo = "E"
            loc_nEntrada   = par_nValor
            loc_nPEntrada  = par_nPeso
            loc_nPfEntrada = par_nPesoFabr
        ELSE
            loc_nSaida   = par_nValor
            loc_nPSaida  = par_nPeso
            loc_nPfSaida = par_nPesoFabr
        ENDIF

        IF par_cArquivo = "Nens"
            SELECT LocalNens
            IF par_cTipoConta = "O"
                loc_cGrupo  = LocalNens.Grupoos
                loc_cConta  = LocalNens.Contaos
                loc_cGrupo2 = LocalNens.Grupods
                loc_cConta2 = LocalNens.Contads
            ELSE
                loc_cGrupo  = LocalNens.Grupods
                loc_cConta  = LocalNens.Contads
                loc_cGrupo2 = LocalNens.Grupoos
                loc_cConta2 = LocalNens.Contaos
            ENDIF
        ELSE
            SELECT LocalEest
            loc_cGrupo  = IIF(TYPE("par_cGrupoo") = "C", par_cGrupoo, SPACE(10))
            loc_cConta  = IIF(TYPE("par_cContao") = "C", par_cContao, SPACE(10))
            loc_cGrupo2 = IIF(TYPE("par_cGrupod") = "C", par_cGrupod, SPACE(10))
            loc_cConta2 = IIF(TYPE("par_cContad") = "C", par_cContad, SPACE(10))
        ENDIF

        IF loc_nEntrada = 0 AND loc_nSaida = 0 AND loc_nPEntrada = 0 AND loc_nPSaida = 0
            RETURN
        ENDIF

        IF par_cArquivo = "Nens"
            INSERT INTO TmpHist ;
                (Grupo, Conta, CMats, TpOps, Datas, QtdeEnts, QtdeSais, Dopps, Numps, cUnis, ;
                 Grupo2, Conta2, PesoEnts, PesoSais, Nenvs, Obss, Opers, PesoFabre, PesoFabrs, cUnips, Emps, nLotes) ;
                VALUES ;
                (loc_cGrupo, loc_cConta, LocalNensI.CMats, LocalNensI.TpOps, LocalNens.Datas, ;
                 loc_nEntrada, loc_nSaida, LocalNens.Dopps, LocalNens.Numps, LocalNensI.CUnis, ;
                 loc_cGrupo2, loc_cConta2, loc_nPEntrada, loc_nPSaida, LocalNensI.Nenvs, ;
                 NVL(LocalNens.Obss, ""), par_cTipo, loc_nPfEntrada, loc_nPfSaida, ;
                 TmpPro.cUnips, LocalNens.Emps, LocalNens.nLotes)

            IF NOT SEEK(LocalNens.EmpDnPs, "TmpHistC", "EmpDnPs")
                INSERT INTO TmpHistC (EmpDnPs, Obss) ;
                    VALUES (LocalNens.EmpDnPs, TmpHist.Obss)
            ENDIF
        ELSE
            INSERT INTO TmpHist ;
                (Grupo, Conta, CMats, Datas, QtdeEnts, QtdeSais, Dopps, Numps, cUnis, ;
                 Grupo2, Conta2, PesoEnts, PesoSais, Obss, Opers, PesoFabre, PesoFabrs, cUniPs, Emps) ;
                VALUES ;
                (loc_cGrupo, loc_cConta, LocalEestI.CPros, LocalEest.Datas, ;
                 loc_nEntrada, loc_nSaida, LocalEest.Dopes, LocalEest.Numes, LocalEestI.CUnis, ;
                 loc_cGrupo2, loc_cConta2, loc_nPEntrada, loc_nPSaida, ;
                 NVL(LocalEest.Obses, ""), par_cTipo, loc_nPfEntrada, loc_nPfSaida, ;
                 TmpPro.cuniPs, LocalEest.Emps)

            IF NOT SEEK(LocalEest.Emps + LocalEest.Dopes + STR(LocalEest.Numes, 10), "TmpHistC", "EmpDnPs")
                INSERT INTO TmpHistC (EmpDnPs, Obss) ;
                    VALUES (LocalEest.Emps + LocalEest.Dopes + STR(LocalEest.Numes, 10), TmpHist.Obss)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Valida campos e executa ProcessarBalanco
    * Legado: Processar.Click (o maior metodo do formulario: ~1475 linhas)
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = THIS.ProcessarBalanco()
        CATCH TO loc_oErro
            MsgErro("Erro em BtnProcessarClick:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Proc: " + loc_oErro.Procedure, "FormFea - Processar Balan" + CHR(231) + "o")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ProcessarBalanco - Logica completa de processamento do balanco de estoque
    * Traducao do legado Processar.Click (~1475 linhas) para nova arquitetura
    *
    * Fluxo:
    *  1. Validacao de campos obrigatorios
    *  2. ZAP de cursores temporarios
    *  3. Pre-carregamento de lookups
    *  4. SQL para buscar movimentacoes (LocalNens/LocalEest/LocalPesa)
    *  5. SCAN de movimentacoes -> TmpResumo / TmpOpera / TmpConta / TmpResFas
    *  6. Calculo de saldos finais (CrUltBal / CrSaldoI)
    *  7. Calculo de cotacoes (TmpCot)
    *  8. Calcular indice de produtividade
    *  9. Se Fechamento: INSERT em CrSigCdFea
    * 10. Exibir cnt_4c_Resultado
    *==========================================================================
    PROTECTED FUNCTION ProcessarBalanco()
        LOCAL loc_oPagina, loc_cEmpr
        LOCAL loc_cGrupo, loc_cConta, loc_dData, loc_nCodigo, loc_nLote
        LOCAL loc_pDtI, loc_pDtF, loc_llFalse, loc_llTrue
        LOCAL loc_cQuery, loc_cUpdate, loc_cSql, loc_cEdn, loc_cEGE
        LOCAL loc_cMatSec, loc_nFalhaAdmitida, loc_llTipoQ, loc_llGrvPrz
        LOCAL loc_cMaterial, loc_cMatResFa, loc_cOperacao
        LOCAL loc_lOrigem, loc_lDestino, loc_lOrigemF, loc_lDestinoF
        LOCAL loc_nPesoTotal, loc_nQtde, loc_nPeso, loc_nFalha
        LOCAL loc_cCodCor, loc_cCodTam
        LOCAL loc_cGrupoD, loc_cContaD
        LOCAL loc_nNumFape, loc_nTrabalhado, loc_nTrabalhadB
        LOCAL loc_nSaldoi, loc_nPesagem
        LOCAL loc_cMoeda, loc_nCusto, loc_nCota
        LOCAL loc_dDataUBal, loc_nNdFechas, loc_nCodigosFcx
        LOCAL loc_cMatPrev, loc_cMatOuro
        LOCAL loc_loBarra

        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cEmpr   = THIS.this_cPEmps
        loc_llFalse = .F.
        loc_llTrue  = .T.

        *-- Validar modo
        IF THIS.this_cPcEscolha <> "INSERIR"
            RETURN .F.
        ENDIF

        *-- Ler valores dos campos
        loc_dData  = loc_oPagina.txt_4c_Data.Value
        loc_cGrupo = ""
        loc_cConta = ""
        loc_nLote  = 0
        loc_nCodigo = IIF(VARTYPE(loc_oPagina.txt_4c_Codigo.Value) = "N", loc_oPagina.txt_4c_Codigo.Value, 0)

        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
            loc_cConta = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Lote", 5) AND !THIS.this_lFechamento
            loc_nLote = NVL(loc_oPagina.txt_4c_Lote.Value, 0)
        ENDIF

        *-- Validar campos obrigatorios
        IF EMPTY(loc_dData)
            MsgAviso("A Data Deve Ser Informada...")
            loc_oPagina.txt_4c_Data.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(loc_cGrupo)
            MsgAviso("O Grupo Deve Ser Informado...")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
                loc_oPagina.txt_4c_Grupo.SetFocus()
            ENDIF
            RETURN .F.
        ENDIF

        IF EMPTY(loc_cConta)
            MsgAviso("A Conta Deve Ser Informada...")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
                loc_oPagina.txt_4c_Conta.SetFocus()
            ENDIF
            RETURN .F.
        ENDIF

        SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")

        *-- Ocultar resultado + resetar EntraPeso
        loc_oPagina.cnt_4c_Resultado.Visible = .F.
        THIS.this_lEntraPeso = .F.

        *-- ZAP / CREATE cursores temporarios
        IF USED("TmpCot")
            ZAP IN TmpCot
        ELSE
            CREATE CURSOR TmpCot (Cmoes C(10), Valos N(18,6))
            INDEX ON Cmoes TAG Cmoes
            SET ORDER TO Cmoes
        ENDIF

        IF USED("TmpConta")
            ZAP IN TmpConta
            SELECT TmpConta
            SET ORDER TO GrConta
        ELSE
            CREATE CURSOR TmpConta (Grupo C(10), Conta C(10), Nome C(80))
            INDEX ON Grupo + Conta TAG GrConta
            SET ORDER TO GrConta
        ENDIF

        IF USED("TmpHist")
            ZAP IN TmpHist
        ELSE
            CREATE CURSOR TmpHist (Grupo C(10), Conta C(10), CMats C(14), TpOps C(15), Datas D, ;
                                   QtdeEnts N(12,3), QtdeSais N(12,3), Dopps C(15), ;
                                   Numps N(10), cUnis C(10), Grupo2 C(10), Conta2 C(10), ;
                                   PesoEnts N(12,3), PesoSais N(12,3), Nenvs N(10), ;
                                   Obss C(100), Opers C(1), PesoFabre N(12,3), PesoFabrs N(12,3), ;
                                   cUnips C(10), Emps C(3), nLotes N(6))
        ENDIF

        IF USED("TmpHistC")
            ZAP IN TmpHistC
        ELSE
            CREATE CURSOR TmpHistC (EmpDnPs C(23), Obss C(100))
            INDEX ON EmpDnPs TAG EmpDnPs
            SET ORDER TO EmpDnPs
        ENDIF

        IF USED("TmpPrz")
            ZAP IN TmpPrz
            SELECT TmpPrz
            SET ORDER TO TmpPrz
        ELSE
            CREATE CURSOR TmpPrz (Datas D, TpOps C(15), Pesos N(12,3), Qtds N(12,3))
            INDEX ON SPACE(1) + DTOS(Datas) + TpOps TAG TmpPrz
            SET ORDER TO TmpPrz
        ENDIF

        IF USED("CrSigCdFea")
            ZAP IN CrSigCdFea
        ELSE
            CREATE CURSOR CrSigCdFea (Grupos C(10), Contas C(10), Datas D, Emps C(3), ;
                                      Falhas N(12,3), Numes N(6,0), Produzidos N(12,3), ;
                                      Tipos C(1), Trabs N(12,3), CidChaves C(36), NumBals N(6,0))
        ENDIF

        IF USED("TmpOpera")
            SELECT TmpOpera
            SET ORDER TO GrConMatTp ASCENDING
            SET KEY TO
            ZAP
        ELSE
            CREATE CURSOR TmpOpera (Grupo C(10), Conta C(10), CMats C(14), TpOps C(15), ;
                                    PesoEnts N(12,3), PesoSais N(12,3), ;
                                    QtdeEnts N(12,3), QtdeSais N(12,3), ;
                                    PesoBEnts N(12,3), PesoBSais N(12,3), ;
                                    QtdeBEnts N(12,3), QtdeBSais N(12,3), ;
                                    Varias N(1,0), Agregas N(1,0), AplicFlhs N(1,0), ;
                                    PFalha N(6,2), Falha N(12,3))
            INDEX ON Grupo + Conta + CMats + TpOps TAG GrConMatTp
            SET ORDER TO GrConMatTp
        ENDIF

        IF USED("TmpResFas")
            SELECT TmpResFas
            SET ORDER TO
            ZAP
        ELSE
            CREATE CURSOR TmpResFas (Cmats C(14), Opers C(1), Fases C(10), OpFase C(18), ;
                                     Qtds N(12,3), Pesos N(12,3), QtdPcs N(12,3))
            INDEX ON Cmats + Opers + Fases TAG Fases
            SET ORDER TO Fases
        ENDIF

        IF USED("TmpResumo")
            SELECT TmpResumo
            ZAP
            SET ORDER TO GrConMat
        ELSE
            CREATE CURSOR TmpResumo (Grupo C(10), Conta C(10), CMats C(14), CUnis C(10), ;
                                     PesoEnts N(12,3), PesoSais N(12,3), ;
                                     QtdeEnts N(12,3), QtdeSais N(12,3), ;
                                     PesoFabre N(12,3), PesoFabrs N(12,3), ;
                                     Pesagem N(12,3), Pesagem2 N(12,3), Pesagem3 N(12,3), ;
                                     Saldoi N(12,3), FReal N(12,3), FAdmin N(12,3), Saldof N(12,3), ;
                                     PfTrabs N(8,2), IndProd N(8,2), ;
                                     Varias N(1,0), Agregas N(1,0), Visivel L, ;
                                     Flag L, Flag2 L, Flag3 L, CodCors C(4), CodTams C(4))
            INDEX ON Grupo + Conta + CMats TAG GrConMat
            INDEX ON Grupo + Conta + CMats + CodCors + CodTams TAG GrConMatCS
            SET ORDER TO GrConMat
        ENDIF

        *-- Obter MatSec de crSigCdPac
        loc_cMatSec = ""
        IF USED("crSigCdPac") AND !EOF("crSigCdPac")
            loc_cMatSec = ALLTRIM(NVL(crSigCdPac.MatSec, ""))
        ELSE
            loc_cSql = "SELECT TOP 1 * FROM SigCdPac WHERE Emps = " + EscaparSQL(loc_cEmpr)
            IF SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPac") > 0 AND !EOF("crSigCdPac")
                loc_cMatSec = ALLTRIM(NVL(crSigCdPac.MatSec, ""))
            ENDIF
        ENDIF
        IF !USED("crSigCdPam")
            loc_cSql = "SELECT TOP 1 * FROM SigCdPam WHERE Emps = " + EscaparSQL(loc_cEmpr)
            =SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPam")
        ENDIF

        *-- Garantir TmpPro / crSigOpOpt / LocalOpp / crSigCdOpe carregados
        IF !USED("TmpPro")
            loc_cSql = "SELECT CPros, CUnis, Varias, Cgrus, MatPrincs, Custofs, MoeCusfs FROM SigCdPro"
            IF SQLEXEC(gnConnHandle, loc_cSql, "TmpPro") > 0
                SELECT TmpPro
                INDEX ON CPros TAG CPros
                SET ORDER TO CPros
            ENDIF
        ENDIF
        IF !USED("crSigOpOpt")
            loc_cSql = "SELECT Cods, PFalhas, TFalhas, Trabas, Prodzs, IndProds FROM SigOpOpt"
            IF SQLEXEC(gnConnHandle, loc_cSql, "crSigOpOpt") > 0
                SELECT crSigOpOpt
                INDEX ON Cods TAG Cods
                SET ORDER TO Cods
            ENDIF
        ENDIF
        IF !USED("LocalOpp")
            loc_cSql = "SELECT Dopps, Origems, Destinos, EstOrigs, EstDests FROM SigCdOpd"
            IF SQLEXEC(gnConnHandle, loc_cSql, "LocalOpp") > 0
                SELECT LocalOpp
                INDEX ON Dopps TAG Dopps
                SET ORDER TO Dopps
            ENDIF
        ENDIF
        IF !USED("crSigCdOpe")
            loc_cSql = "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests, Opers FROM SigCdOpe"
            IF SQLEXEC(gnConnHandle, loc_cSql, "crSigCdOpe") > 0
                SELECT crSigCdOpe
                INDEX ON Dopes TAG Dopes
                SET ORDER TO Dopes
            ENDIF
        ENDIF

        *-- Obter codigo do FCX corrente
        loc_nCodigosFcx = 0
        IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
            loc_nCodigosFcx = crSigCdFcx.Codigos
        ENDIF

        *-- Seek grupo em TmpGccr
        IF USED("TmpGccr")
            =SEEK(loc_cGrupo, "TmpGccr", "BalCodigo")
        ENDIF

        *-- Buscar data do ultimo balanco (crDtUBal)
        loc_cQuery = "SELECT TOP 1 Datas FROM SigCdFcx " + ;
                     "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
                     " AND Grupos = " + EscaparSQL(loc_cGrupo) + ;
                     " AND Contas = " + EscaparSQL(loc_cConta) + ;
                     " AND NOT Codigos = " + TRANSFORM(loc_nCodigosFcx) + ;
                     " ORDER BY Emps DESC, Grupos DESC, Contas DESC, Datas DESC"

        IF SQLEXEC(gnConnHandle, loc_cQuery, "crDtUBal") < 1
            MsgErro("Falha na conex" + CHR(227) + "o (crDtUBal). Reinicializar o processo.", ;
                    "FormFea - ProcessarBalan" + CHR(231) + "o")
            RETURN .F.
        ENDIF
        GO TOP IN crDtUBal

        loc_nNdFechas = 0
        IF USED("crSigCdPac") AND !EOF("crSigCdPac")
            loc_nNdFechas = NVL(crSigCdPac.ndFechas, 0)
        ENDIF

        IF EOF("crDtUBal")
            loc_dDataUBal = CTOD("")
        ELSE
            loc_dDataUBal = TTOD(crDtUBal.Datas) + loc_nNdFechas
        ENDIF

        IF !EMPTY(loc_dDataUBal) AND loc_dDataUBal > loc_dData
            MsgAviso("A Data N" + CHR(227) + "o Pode Ser Menor Que o " + CHR(218) + ;
                     "ltimo Balan" + CHR(231) + "o..." + CHR(13) + CHR(13) + ;
                     "Data do " + CHR(218) + "ltimo Balan" + CHR(231) + "o : " + DTOC(loc_dDataUBal))
            loc_oPagina.txt_4c_Data.SetFocus()
            RETURN .F.
        ENDIF

        *-- Atualizar Datais no FCX com data do ultimo balanco
        IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
            SELECT crSigCdFcx
            REPLACE crSigCdFcx.Datais WITH loc_dDataUBal
        ENDIF

        *-- Parametros de data para SQL parametrizado
        loc_pDtI = fDtoSQL(loc_dDataUBal)
        loc_pDtF = fDtoSQL(loc_dData, "23:59:59")

        *-- Dados da empresa (EmpBals)
        loc_cSql = "SELECT TOP 1 * FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmpr)
        =SQLEXEC(gnConnHandle, loc_cSql, "LocalEmp")
        LOCAL loc_cEmpBals
        loc_cEmpBals = ""
        IF USED("LocalEmp") AND !EOF("LocalEmp") AND PEMSTATUS(LocalEmp, "EmpBals", 5)
            loc_cEmpBals = ALLTRIM(NVL(LocalEmp.EmpBals, ""))
        ENDIF

        *==========================================================================
        *-- MOVIMENTACOES DE PRODUCAO (LocalNens / LocalNensI)
        *==========================================================================
        loc_cQuery = "SELECT Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, " + ;
                     "Obss, cIdChaves, EmpDnPs, nLotes " + ;
                     "FROM SigCdNec " + ;
                     "WHERE ( Emps = " + EscaparSQL(loc_cEmpr) + ;
                     IIF(!EMPTY(loc_cEmpBals), " OR Emps = " + EscaparSQL(loc_cEmpBals), "") + " )" + ;
                     " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
                     " AND ((GrupoDs = " + EscaparSQL(loc_cGrupo) + ;
                     " AND ContaDs = " + EscaparSQL(loc_cConta) + ;
                     " AND ProcdBal = ?loc_llFalse) OR (GrupoOs = " + EscaparSQL(loc_cGrupo) + ;
                     " AND ContaOs = " + EscaparSQL(loc_cConta) + ;
                     " AND ProcBals = ?loc_llFalse))" + ;
                     IIF(loc_nLote > 0, " AND nLotes = " + TRANSFORM(loc_nLote), "") + ;
                     " ORDER BY Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, cIdChaves"

        IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalNens") < 1
            MsgErro("Falha na conex" + CHR(227) + "o (LocalNens). Reinicializar.", ;
                    "FormFea - ProcessarBalan" + CHR(231) + "o")
            RETURN .F.
        ENDIF

        loc_cQuery = "SELECT b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, " + ;
                     "b.cIdChaves, b.Nops, b.Peso2s, b.CodCors, b.CodTams " + ;
                     "FROM SigCdNec a, SigCdNei b " + ;
                     "WHERE ( a.Emps = " + EscaparSQL(loc_cEmpr) + ;
                     IIF(!EMPTY(loc_cEmpBals), " OR a.Emps = " + EscaparSQL(loc_cEmpBals), "") + " )" + ;
                     " AND a.Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
                     " AND (a.GrupoDs = " + EscaparSQL(loc_cGrupo) + ;
                     " OR a.GrupoOs = " + EscaparSQL(loc_cGrupo) + ")" + ;
                     " AND (a.ContaDs = " + EscaparSQL(loc_cConta) + ;
                     " OR a.ContaOs = " + EscaparSQL(loc_cConta) + ")" + ;
                     " AND a.EmpDNPs = b.EmpDNPs AND b.Servicos = ?loc_llFalse" + ;
                     " ORDER BY b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops"

        IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalNensI") < 1
            MsgErro("Falha na conex" + CHR(227) + "o (LocalNensI). Reinicializar.", ;
                    "FormFea - ProcessarBalan" + CHR(231) + "o")
            RETURN .F.
        ENDIF
        SELECT LocalNensI
        INDEX ON EmpDNPs TAG EmpDNPs
        SET ORDER TO EmpDNPs

        *-- LocalServ (servicos por funcionario)
        loc_cQuery = "SELECT b.EmpDNPs, a.dopps, a.numps, b.CMats, p.DPros, b.CUnis, b.Nenvs, " + ;
                     "b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops, b.Peso2s, b.CodCors, b.CodTams, " + ;
                     "b.fators, a.grupoos, a.contaos, " + ;
                     "CASE WHEN a.retrabs = 0 THEN b.qtds * b.fators ELSE b.qtds * b.coefs END AS valors, a.datas " + ;
                     "FROM SigCdNec a, SigCdNei b LEFT JOIN SigCdPro p ON b.CMats = p.CPros " + ;
                     "WHERE ( a.Emps = " + EscaparSQL(loc_cEmpr) + ;
                     IIF(!EMPTY(loc_cEmpBals), " OR a.Emps = " + EscaparSQL(loc_cEmpBals), "") + " )" + ;
                     " AND a.Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
                     " AND ((a.GrupoDs = " + EscaparSQL(loc_cGrupo) + ;
                     " AND a.ContaDs = " + EscaparSQL(loc_cConta) + ;
                     " AND a.ProcdBal = ?loc_llFalse) OR (a.GrupoOs = " + EscaparSQL(loc_cGrupo) + ;
                     " AND a.ContaOs = " + EscaparSQL(loc_cConta) + ;
                     " AND a.ProcBals = ?loc_llFalse))" + ;
                     " AND a.EmpDNPs = b.EmpDNPs AND b.Servicos = ?loc_llTrue" + ;
                     IIF(loc_nLote > 0, " AND nLotes = " + TRANSFORM(loc_nLote), "") + ;
                     " ORDER BY b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops"

        IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalServ") < 1
            MsgErro("Falha na conex" + CHR(227) + "o (LocalServ). Reinicializar.", ;
                    "FormFea - ProcessarBalan" + CHR(231) + "o")
            RETURN .F.
        ENDIF
        SELECT LocalServ
        INDEX ON CMats + EmpDNPs TAG EmpDNPs
        SET ORDER TO EmpDNPs

        *-- LocalMFas (fases de producao)
        loc_cQuery = "SELECT b.EmpDNPs, b.Qtds, b.cIdChaves " + ;
                     "FROM SigCdNec a, SigPdMvf b " + ;
                     "WHERE ( a.Emps = " + EscaparSQL(loc_cEmpr) + ;
                     IIF(!EMPTY(loc_cEmpBals), " OR a.Emps = " + EscaparSQL(loc_cEmpBals), "") + " )" + ;
                     " AND a.Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
                     " AND (a.GrupoDs = " + EscaparSQL(loc_cGrupo) + ;
                     " OR a.GrupoOs = " + EscaparSQL(loc_cGrupo) + ")" + ;
                     " AND (a.ContaDs = " + EscaparSQL(loc_cConta) + ;
                     " OR a.ContaOs = " + EscaparSQL(loc_cConta) + ")" + ;
                     " AND a.EmpDNPs = b.EmpDNPs" + ;
                     " ORDER BY b.EmpDNPs, b.Qtds, b.cIdChaves"

        IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalMFas") < 1
            MsgErro("Falha na conex" + CHR(227) + "o (LocalMFas). Reinicializar.", ;
                    "FormFea - ProcessarBalan" + CHR(231) + "o")
            RETURN .F.
        ENDIF
        SELECT LocalMFas
        INDEX ON EmpDNPs TAG EmpDNPs
        SET ORDER TO EmpDNPs

        *-- Grupos de produto (LocalGru / LocalGgrp)
        loc_cSql = "SELECT Cgrus, GruEstPs, ConEstPs, nAgMts, TipoEstos, Mercs, MoeCusts FROM SigCdGrp"
        =SQLEXEC(gnConnHandle, loc_cSql, "LocalGru")
        SELECT LocalGru
        INDEX ON Cgrus TAG Cgrus

        loc_cSql = "SELECT Codigos, Aplicflhs FROM SigCdGpr"
        =SQLEXEC(gnConnHandle, loc_cSql, "LocalGgrp")
        SELECT LocalGgrp
        INDEX ON Codigos TAG Codigos

        *-- Inicializacao de flags
        loc_nFalhaAdmitida = 0
        loc_llTipoQ        = .F.
        loc_llGrvPrz       = .F.

        *==========================================================================
        *-- SCAN PRINCIPAL: Movimentacoes de Producao (LocalNens)
        *==========================================================================
        SELECT LocalNens
        loc_loBarra = CREATEOBJECT("fwprogressbar", ;
                      "Processando Mov. de Produ" + CHR(231) + CHR(227) + "o...", ;
                      RECCOUNT("LocalNens"))
        loc_loBarra.Show

        SCAN
            loc_loBarra.Update(.T.)

            loc_cEdn = LocalNens.Emps + LocalNens.Dopps + STR(LocalNens.Numps, 10)

            =SEEK(LocalNens.Dopps, "LocalOpp", "Dopps")

            loc_lOrigem   = .F.
            loc_lDestino  = .F.
            loc_cMaterial = SPACE(14)
            loc_cMatResFa = SPACE(14)

            IF USED("LocalOpp") AND !EOF("LocalOpp") AND ;
               LocalOpp.Origems = 1 AND LocalNens.GrupoOs = loc_cGrupo AND ;
               LocalNens.ContaOs = loc_cConta AND INLIST(LocalOpp.EstOrigs, 1, 2)
                loc_lOrigem = .T.
            ENDIF
            IF USED("LocalOpp") AND !EOF("LocalOpp") AND ;
               LocalOpp.Destinos = 1 AND LocalNens.GrupoDs = loc_cGrupo AND ;
               LocalNens.ContaDs = loc_cConta AND INLIST(LocalOpp.EstDests, 1, 2)
                loc_lDestino = .T.
            ENDIF

            IF !loc_lOrigem AND !loc_lDestino
                LOOP
            ENDIF

            loc_nPesoTotal = 0
            loc_llGrvPrz   = .F.

            *-- Scan interno: itens do movimento (LocalNensI)
            SELECT LocalNensI
            SEEK loc_cEdn
            SCAN WHILE EmpDNPs = loc_cEdn
                *-- Determinar material baseado em UnifBals
                IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 4
                    IF LocalNensI.Nops = 0
                        loc_cMaterial = LocalNensI.CMats
                    ELSE
                        loc_cSql = "SELECT Cpros FROM SigOpPic WHERE Nops = " + TRANSFORM(LocalNensI.Nops)
                        =SQLEXEC(gnConnHandle, loc_cSql, "TmpOpi")
                        =SEEK(TmpOpi.Cpros, "TmpPro", "CPros")
                        IF USED("crSigCdPam") AND !EOF("crSigCdPam")
                            loc_cMaterial = IIF(EMPTY(TmpPro.MatPrincs), ALLTRIM(crSigCdPam.Ouros), TmpPro.MatPrincs)
                        ELSE
                            loc_cMaterial = TmpPro.MatPrincs
                        ENDIF
                    ENDIF
                    IF LocalNensI.CMats <> loc_cMaterial
                        IF LocalNensI.CMats <> loc_cMatSec
                            LOOP
                        ELSE
                            loc_cMaterial = loc_cMatSec
                        ENDIF
                    ENDIF
                ELSE
                    IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 3
                        loc_cSql = "SELECT Cpros FROM SigOpPic WHERE Nops = " + TRANSFORM(LocalNensI.Nops)
                        =SQLEXEC(gnConnHandle, loc_cSql, "TmpOpi")
                        IF LocalNensI.Nops = 0
                            loc_cMaterial = LocalNensI.CMats
                        ELSE
                            =SEEK(TmpOpi.Cpros, "TmpPro", "CPros")
                            IF USED("crSigCdPam") AND !EOF("crSigCdPam")
                                loc_cMaterial = IIF(EMPTY(TmpPro.MatPrincs), ALLTRIM(crSigCdPam.Ouros), TmpPro.MatPrincs)
                            ELSE
                                loc_cMaterial = TmpPro.MatPrincs
                            ENDIF
                        ENDIF
                    ELSE
                        IF USED("TmpGccr") AND !EOF("TmpGccr") AND USED("crSigCdPam") AND !EOF("crSigCdPam")
                            loc_cMaterial = IIF(TmpGccr.UnifBals = 1, ALLTRIM(crSigCdPam.Ouros), LocalNensI.CMats)
                        ELSE
                            loc_cMaterial = LocalNensI.CMats
                        ENDIF
                    ENDIF
                ENDIF
                loc_cMatResFa = loc_cMaterial

                =SEEK(LocalNensI.CMats, "TmpPro", "CPros")
                =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
                =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")

                loc_cCodCor = PADR(IIF(INLIST(LocalGru.TipoEstos, 2, 4), ALLTRIM(LocalNensI.CodCors), " "), 4)
                loc_cCodTam = PADR(IIF(INLIST(LocalGru.TipoEstos, 3, 4), ALLTRIM(LocalNensI.CodTams), " "), 4)

                *-- ORIGEM
                IF loc_lOrigem
                    IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs, "TmpConta")
                        =SEEK(LocalNens.ContaOs, "TmpCli", "BalCodigo")
                        INSERT INTO TmpConta (Grupo, Conta, Nome) ;
                            VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, ;
                                    IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
                    ENDIF
                    IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs + LocalNensI.CMats + loc_cCodCor + loc_cCodTam, "TmpResumo")
                        INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                            VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, LocalNensI.CMats, ;
                                    TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
                    ENDIF
                    SELECT TmpResumo
                    IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
                        REPLACE PesoEnts  WITH PesoEnts  + LocalNensI.Pesos, ;
                                QtdeEnts  WITH QtdeEnts  + LocalNensI.Qtds, ;
                                PesoFabre WITH PesoFabre + LocalNensI.Peso2s
                        THIS.IncluirHistorico("Nens", "O", "E", LocalNensI.Qtds, LocalNensI.Pesos, LocalNensI.Peso2s)
                    ELSE
                        REPLACE PesoSais  WITH PesoSais  + LocalNensI.Pesos, ;
                                QtdeSais  WITH QtdeSais  + LocalNensI.Qtds, ;
                                PesoFabrs WITH PesoFabrs + LocalNensI.Peso2s
                        THIS.IncluirHistorico("Nens", "O", "S", LocalNensI.Qtds, LocalNensI.Pesos, LocalNensI.Peso2s)
                    ENDIF
                    IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs + LocalNensI.CMats + LocalNensI.TpOps, "TmpOpera")
                        INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                            VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, LocalNensI.CMats, ;
                                    LocalNensI.TpOps, TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
                    ENDIF
                    SELECT TmpOpera
                    IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
                        REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, ;
                                QtdeEnts WITH QtdeEnts + LocalNensI.Qtds
                    ELSE
                        REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, ;
                                QtdeSais WITH QtdeSais + LocalNensI.Qtds
                    ENDIF
                    =SEEK(TmpOpera.TpOps, "crSigOpOpt", "Cods")
                    IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND ;
                       USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;
                       crSigOpOpt.PFalhas <> 0 AND TmpPro.Varias = 1 AND ;
                       crSigOpOpt.TFalhas = "Q" AND crSigCdPam.GrTrans <> loc_cGrupo
                        loc_llTipoQ = .T.
                        IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
                            loc_nFalha = IIF(crSigOpOpt.Pfalhas > LocalNensI.Qtds, LocalNensI.Qtds, crSigOpOpt.Pfalhas)
                            REPLACE PFalha WITH loc_nFalha, Falha WITH TmpOpera.Falha + loc_nFalha IN TmpOpera
                            loc_nFalhaAdmitida = loc_nFalhaAdmitida + loc_nFalha
                        ENDIF
                    ENDIF
                    IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
                        loc_cOperacao = "E"
                        IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoDs, "TmpResFas", "Fases")
                            INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
                                VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoDs, "Entrada " + LocalNens.GrupoDs)
                        ENDIF
                    ELSE
                        loc_cOperacao = "S"
                        IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoDs, "TmpResFas", "Fases")
                            INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
                                VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoDs, "Saida   " + LocalNens.GrupoDs)
                        ENDIF
                    ENDIF
                    REPLACE Qtds  WITH TmpResFas.Qtds  + LocalNensI.Qtds, ;
                            Pesos WITH TmpResFas.Pesos + LocalNensI.Pesos IN TmpResFas
                    IF USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND crSigOpOpt.Prodzs = 1
                        SELECT TmpPrz
                        IF !SEEK(SPACE(1) + DTOS(LocalNens.Datas) + LocalNensI.TpOps)
                            APPEND BLANK
                            REPLACE Datas WITH LocalNens.Datas, TpOps WITH LocalNensI.TpOps
                        ENDIF
                        REPLACE Pesos WITH Pesos + LocalNensI.Pesos
                        loc_llGrvPrz = .T.
                    ENDIF
                ENDIF

                *-- DESTINO
                IF loc_lDestino
                    IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs, "TmpConta")
                        =SEEK(LocalNens.ContaDs, "TmpCli", "BalCodigo")
                        INSERT INTO TmpConta (Grupo, Conta, Nome) ;
                            VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, ;
                                    IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
                    ENDIF
                    IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs + LocalNensI.CMats + loc_cCodCor + loc_cCodTam, "TmpResumo")
                        INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                            VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, LocalNensI.CMats, ;
                                    TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
                    ENDIF
                    SELECT TmpResumo
                    IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
                        REPLACE PesoEnts  WITH PesoEnts  + LocalNensI.Pesos, ;
                                QtdeEnts  WITH QtdeEnts  + LocalNensI.Qtds, ;
                                PesoFabre WITH PesoFabre + LocalNensI.Peso2s
                        THIS.IncluirHistorico("Nens", "D", "E", LocalNensI.Qtds, LocalNensI.Pesos, LocalNensI.Peso2s)
                    ELSE
                        REPLACE PesoSais  WITH PesoSais  + LocalNensI.Pesos, ;
                                QtdeSais  WITH QtdeSais  + LocalNensI.Qtds, ;
                                PesoFabrs WITH PesoFabrs + LocalNensI.Peso2s
                        THIS.IncluirHistorico("Nens", "D", "S", LocalNensI.Qtds, LocalNensI.Pesos, LocalNensI.Peso2s)
                    ENDIF
                    IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs + LocalNensI.CMats + LocalNensI.TpOps, "TmpOpera")
                        INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                            VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, LocalNensI.CMats, ;
                                    LocalNensI.TpOps, TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
                    ENDIF
                    SELECT TmpOpera
                    IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
                        REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, ;
                                QtdeEnts WITH QtdeEnts + LocalNensI.Qtds
                    ELSE
                        REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, ;
                                QtdeSais WITH QtdeSais + LocalNensI.Qtds
                    ENDIF
                    =SEEK(TmpOpera.TpOps, "crSigOpOpt", "Cods")
                    IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND ;
                       USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;
                       crSigOpOpt.PFalhas <> 0 AND TmpPro.Varias = 1 AND ;
                       crSigOpOpt.TFalhas = "Q" AND crSigCdPam.GrTrans <> loc_cGrupo
                        loc_llTipoQ = .T.
                        IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
                            loc_nFalha = IIF(crSigOpOpt.Pfalhas > LocalNensI.Qtds, LocalNensI.Qtds, crSigOpOpt.Pfalhas)
                            REPLACE PFalha WITH loc_nFalha, Falha WITH TmpOpera.Falha + loc_nFalha IN TmpOpera
                            loc_nFalhaAdmitida = loc_nFalhaAdmitida + loc_nFalha
                        ENDIF
                    ENDIF
                    IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
                        loc_cOperacao = "E"
                        IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoOs, "TmpResFas", "Fases")
                            INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
                                VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoOs, "Entrada " + LocalNens.GrupoOs)
                        ENDIF
                    ELSE
                        loc_cOperacao = "S"
                        IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoOs, "TmpResFas", "Fases")
                            INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
                                VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoOs, "Saida   " + LocalNens.GrupoOs)
                        ENDIF
                    ENDIF
                    REPLACE Qtds  WITH TmpResFas.Qtds  + LocalNensI.Qtds, ;
                            Pesos WITH TmpResFas.Pesos + LocalNensI.Pesos IN TmpResFas
                ENDIF

                *-- UnifBals=3: material principal secundario
                IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 3 AND ;
                   LocalNensI.CMats <> loc_cMaterial AND ;
                   USED("crSigCdFcx") AND !EOF("crSigCdFcx") AND ;
                   LocalGru.GruEstPs <> crSigCdFcx.Grupos AND LocalGru.ConEstPs <> crSigCdFcx.Contas
                    =SEEK(loc_cMaterial, "TmpPro", "CPros")
                    =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
                    =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
                    IF loc_lOrigem
                        IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs + loc_cMaterial, "TmpResumo")
                            INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Visivel) ;
                                VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, loc_cMaterial, TmpPro.CUnis, TmpPro.Varias, .T.)
                        ENDIF
                        SELECT TmpResumo
                        IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
                            REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, QtdeEnts WITH QtdeEnts + LocalNensI.Pesos
                        ELSE
                            REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, QtdeSais WITH QtdeSais + LocalNensI.Pesos
                        ENDIF
                        IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs + loc_cMaterial + LocalNensI.TpOps, "TmpOpera")
                            INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, loc_cMaterial, ;
                                        LocalNensI.TpOps, TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
                        ENDIF
                        SELECT TmpOpera
                        IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
                            REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, QtdeEnts WITH QtdeEnts + LocalNensI.Pesos
                        ELSE
                            REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, QtdeSais WITH QtdeSais + LocalNensI.Pesos
                        ENDIF
                    ENDIF
                    IF loc_lDestino
                        IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs + loc_cMaterial, "TmpResumo")
                            INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Visivel) ;
                                VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, loc_cMaterial, TmpPro.CUnis, TmpPro.Varias, .T.)
                        ENDIF
                        SELECT TmpResumo
                        IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
                            REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, QtdeEnts WITH QtdeEnts + LocalNensI.Pesos
                        ELSE
                            REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, QtdeSais WITH QtdeSais + LocalNensI.Pesos
                        ENDIF
                        IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs + loc_cMaterial + LocalNensI.TpOps, "TmpOpera")
                            INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, loc_cMaterial, ;
                                        LocalNensI.TpOps, TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
                        ENDIF
                        SELECT TmpOpera
                        IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
                            REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, QtdeEnts WITH QtdeEnts + LocalNensI.Pesos
                        ELSE
                            REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, QtdeSais WITH QtdeSais + LocalNensI.Pesos
                        ENDIF
                    ENDIF
                ENDIF

            ENDSCAN

            *-- TmpResFas pos-scan-interno
            IF loc_lDestino AND !EMPTY(ALLTRIM(loc_cMatResFa))
                loc_cOperacao = IIF(USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1, "E", "S")
                IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoOs, "TmpResFas", "Fases")
                    INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
                        VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoOs, ;
                                IIF(loc_cOperacao = "S", "Saida   ", "Entrada ") + LocalNens.GrupoOs)
                ENDIF
            ENDIF
            IF loc_lOrigem AND !EMPTY(ALLTRIM(loc_cMatResFa))
                loc_cOperacao = IIF(USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1, "E", "S")
                IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoDs, "TmpResFas", "Fases")
                    INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
                        VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoDs, ;
                                IIF(loc_cOperacao = "S", "Saida   ", "Entrada ") + LocalNens.GrupoDs)
                ENDIF
            ENDIF

            *-- LocalMFas para este movimento
            SELECT LocalMFas
            SEEK loc_cEdn
            SCAN WHILE EmpDNPs = loc_cEdn
                REPLACE QtdPcs WITH QtdPcs + LocalMfas.Qtds IN TmpResFas
                IF loc_llGrvPrz
                    REPLACE Qtds WITH Qtds + LocalMfas.Qtds IN TmpPrz
                ENDIF
            ENDSCAN

            *-- Marcar NEC como processada no balanco (se Fechamento)
            IF THIS.this_lFechamento
                IF loc_lOrigem
                    loc_cUpdate = "UPDATE SigCdNec SET ProcBals = ?loc_llTrue, NumBals = " + ;
                                  TRANSFORM(loc_nCodigosFcx) + " WHERE CidChaves = '" + ALLTRIM(LocalNens.CidChaves) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cUpdate, "") < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdNec Orig). Reinicializar.", "FormFea")
                        SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
                        RETURN .F.
                    ENDIF
                ENDIF
                IF loc_lDestino
                    loc_cUpdate = "UPDATE SigCdNec SET ProcDBal = ?loc_llTrue, NumBalds = " + ;
                                  TRANSFORM(loc_nCodigosFcx) + " WHERE CidChaves = '" + ALLTRIM(LocalNens.CidChaves) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cUpdate, "") < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdNec Dest). Reinicializar.", "FormFea")
                        SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
                        RETURN .F.
                    ENDIF
                ENDIF
            ENDIF

        ENDSCAN
        loc_loBarra.Complete

        *==========================================================================
        *-- MOVIMENTACOES DE ESTOQUE (LocalEest / LocalEestI / LocalEsti2)
        *==========================================================================
        loc_pDtI = fDtoSQL(loc_dDataUBal)
        loc_pDtF = fDtoSQL(loc_dData, "23:59:59")

        loc_cQuery = "SELECT Datas, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Dopes, Numes, Obses, CidChaves " + ;
                     "FROM SigMvCab " + ;
                     "WHERE (Emps = " + EscaparSQL(loc_cEmpr) + " OR Empds = " + EscaparSQL(loc_cEmpr) + ")" + ;
                     " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
                     " AND ((GrupoDs = " + EscaparSQL(loc_cGrupo) + " AND ContaDs = " + EscaparSQL(loc_cConta) + ;
                     " AND ProcdBal = ?loc_llFalse) OR (GrupoOs = " + EscaparSQL(loc_cGrupo) + ;
                     " AND ContaOs = " + EscaparSQL(loc_cConta) + " AND ProcBals = ?loc_llFalse))" + ;
                     IIF(loc_nLote > 0, " AND 0=1", "") + ;
                     " ORDER BY Datas"

        IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalEest") < 1
            MsgErro("Falha na conex" + CHR(227) + "o (LocalEest). Reinicializar.", "FormFea")
            SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
            RETURN .F.
        ENDIF

        loc_cQuery = "SELECT b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds, b.Pesos, b.cItens " + ;
                     "FROM SigMvCab a, SigMvItn b " + ;
                     "WHERE (a.Emps = " + EscaparSQL(loc_cEmpr) + " OR a.Empds = " + EscaparSQL(loc_cEmpr) + ")" + ;
                     " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
                     " AND (GrupoDs = " + EscaparSQL(loc_cGrupo) + " OR GrupoOs = " + EscaparSQL(loc_cGrupo) + ")" + ;
                     " AND (ContaDs = " + EscaparSQL(loc_cConta) + " OR ContaOs = " + EscaparSQL(loc_cConta) + ")" + ;
                     " AND a.EmpDopNums = b.EmpDopNums" + ;
                     " ORDER BY b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds"

        IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalEestI") < 1
            MsgErro("Falha na conex" + CHR(227) + "o (LocalEestI). Reinicializar.", "FormFea")
            SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
            RETURN .F.
        ENDIF
        SELECT LocalEestI
        INDEX ON EmpDopNums TAG EmpDopNums
        SET ORDER TO EmpDopNums

        loc_cQuery = "SELECT b.EmpDopNums, b.CPros, b.Qtds, b.Pesos, b.CodCors, b.CodTams, b.Citens " + ;
                     "FROM SigMvCab a, SigMvIts b " + ;
                     "WHERE (a.Emps = " + EscaparSQL(loc_cEmpr) + " OR a.Empds = " + EscaparSQL(loc_cEmpr) + ")" + ;
                     " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
                     " AND (GrupoDs = " + EscaparSQL(loc_cGrupo) + " OR GrupoOs = " + EscaparSQL(loc_cGrupo) + ")" + ;
                     " AND (ContaDs = " + EscaparSQL(loc_cConta) + " OR ContaOs = " + EscaparSQL(loc_cConta) + ")" + ;
                     " AND a.EmpDopNums = b.EmpDopNums" + ;
                     " ORDER BY b.EmpDopNums, b.CPros, b.codcors, b.codtams, b.citens"

        IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalEsti2") < 1
            MsgErro("Falha na conex" + CHR(227) + "o (LocalEsti2). Reinicializar.", "FormFea")
            SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
            RETURN .F.
        ENDIF
        SELECT LocalEsti2
        INDEX ON EmpDopNums + Cpros + STR(Citens, 4) TAG EmpDopNums
        SET ORDER TO EmpDopNums

        *-- SCAN: Movimentacoes de Estoque
        SELECT LocalEest
        loc_loBarra = CREATEOBJECT("fwprogressbar", "Processando Mov. de Estoque", RECCOUNT("LocalEest"))
        loc_loBarra.Show

        SCAN
            loc_loBarra.Update(.T.)
            loc_cEdn = LocalEest.Emps + LocalEest.Dopes + STR(LocalEest.Numes, 6)

            =SEEK(LocalEest.Dopes, "crSigCdOpe", "Dopes")

            loc_lOrigem   = .F.
            loc_lDestino  = .F.
            loc_lOrigemF  = .F.
            loc_lDestinoF = .F.

            IF USED("crSigCdOpe") AND !EOF("crSigCdOpe")
                IF crSigCdOpe.Estoqs = 1 AND (crSigCdOpe.EstOrigs = 4 OR crSigCdOpe.Opers = 3) AND LocalEest.Emps = loc_cEmpr
                    IF crSigCdOpe.Origems = 1 AND LocalEest.GrupoOs = loc_cGrupo AND LocalEest.ContaOs = loc_cConta
                        loc_lOrigem = .T.
                    ELSE
                        IF crSigCdOpe.Destinos = 1 AND LocalEest.GrupoDs = loc_cGrupo AND LocalEest.ContaDs = loc_cConta
                            loc_lDestino = .T.
                        ENDIF
                    ENDIF
                ELSE
                    IF crSigCdOpe.Estoqs = 1 AND crSigCdOpe.Origems = 1 AND ;
                       LocalEest.GrupoOs = loc_cGrupo AND LocalEest.ContaOs = loc_cConta AND LocalEest.Emps = loc_cEmpr
                        IF INLIST(crSigCdOpe.EstOrigs, 1, 2)
                            loc_lOrigem = .T.
                        ENDIF
                    ENDIF
                    IF crSigCdOpe.Estoqs = 1 AND crSigCdOpe.Destinos = 1 AND ;
                       LocalEest.GrupoDs = loc_cGrupo AND LocalEest.ContaDs = loc_cConta
                        IF INLIST(crSigCdOpe.EstDests, 1, 2)
                            loc_lDestino = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lOrigem AND !loc_lDestino
                LOOP
            ENDIF

            SELECT LocalEestI
            SEEK loc_cEdn
            SCAN WHILE EmpDopNums = loc_cEdn
                =SEEK(LocalEestI.Cpros, "TmpPro", "CPros")
                =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
                =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")

                loc_cGrupoD   = SPACE(10)
                loc_cContaD   = SPACE(10)
                loc_cOperacao = " "

                IF USED("crSigCdOpe") AND !EOF("crSigCdOpe") AND crSigCdOpe.EstOrigs = 4
                    loc_lOrigem  = .F.
                    loc_lDestino = .F.
                    IF LocalEestI.Opers = "S" AND LocalEest.GrupoOs = loc_cGrupo AND LocalEest.ContaOs = loc_cConta
                        loc_lOrigem   = .T.
                        loc_cOperacao = "S"
                        loc_cGrupoD   = LocalEest.GrupoDs
                        loc_cContaD   = LocalEest.ContaDs
                    ELSE
                        IF LocalEestI.Opers = "E" AND LocalEest.GrupoDs = loc_cGrupo AND LocalEest.ContaDs = loc_cConta
                            loc_lDestino  = .T.
                            loc_cOperacao = "E"
                            loc_cGrupoD   = LocalEest.GrupoOs
                            loc_cContaD   = LocalEest.ContaOs
                        ELSE
                            LOOP
                        ENDIF
                    ENDIF
                ELSE
                    IF USED("crSigCdOpe") AND !EOF("crSigCdOpe") AND crSigCdOpe.Opers = 3
                        IF crSigCdOpe.Origems = 1
                            IF LocalEestI.Opers = "S" AND LocalEest.GrupoOs = loc_cGrupo AND LocalEest.ContaOs = loc_cConta
                                loc_lOrigem   = .T.
                                loc_lDestino  = .F.
                                loc_cOperacao = "S"
                                loc_cGrupoD   = LocalEest.GrupoOs
                                loc_cContaD   = LocalEest.ContaOs
                            ELSE
                                IF LocalEestI.Opers = "E" AND LocalEest.GrupoOs = loc_cGrupo AND LocalEest.ContaOs = loc_cConta
                                    loc_lOrigem   = .F.
                                    loc_lDestino  = .T.
                                    loc_cOperacao = "E"
                                    loc_cGrupoD   = LocalEest.GrupoOs
                                    loc_cContaD   = LocalEest.ContaOs
                                ENDIF
                            ENDIF
                        ELSE
                            IF crSigCdOpe.Destinos = 1
                                IF LocalEestI.Opers = "S" AND LocalEest.GrupoDs = loc_cGrupo AND LocalEest.ContaDs = loc_cConta
                                    loc_lOrigem   = .T.
                                    loc_cOperacao = "S"
                                    loc_cGrupoD   = LocalEest.GrupoDs
                                    loc_cContaD   = LocalEest.ContaDs
                                ELSE
                                    IF LocalEestI.Opers = "E" AND LocalEest.GrupoDs = loc_cGrupo AND LocalEest.ContaDs = loc_cConta
                                        loc_lDestino  = .T.
                                        loc_cOperacao = "E"
                                        loc_cGrupoD   = LocalEest.GrupoDs
                                        loc_cContaD   = LocalEest.ContaDs
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ELSE
                        IF USED("crSigCdOpe") AND !EOF("crSigCdOpe")
                            IF loc_lOrigem AND crSigCdOpe.EstOrigs = 1
                                loc_cOperacao = "E"
                                IF crSigCdOpe.Destinos = 1 AND crSigCdOpe.EstDests = 2
                                    loc_cGrupoD = LocalEest.GrupoDs
                                    loc_cContaD = LocalEest.ContaDs
                                ENDIF
                            ELSE
                                IF loc_lOrigem AND crSigCdOpe.EstOrigs = 2
                                    loc_cOperacao = "S"
                                    IF crSigCdOpe.Destinos = 1 AND crSigCdOpe.EstDests = 1
                                        loc_cGrupoD = LocalEest.GrupoDs
                                        loc_cContaD = LocalEest.ContaDs
                                    ENDIF
                                ELSE
                                    IF loc_lDestino AND crSigCdOpe.EstDests = 1
                                        loc_cOperacao = "E"
                                        IF crSigCdOpe.Origems = 1 AND crSigCdOpe.EstOrigs = 2
                                            loc_cGrupoD = LocalEest.GrupoOs
                                            loc_cContaD = LocalEest.ContaOs
                                        ENDIF
                                    ELSE
                                        IF loc_lDestino AND crSigCdOpe.EstDests = 2
                                            loc_cOperacao = "S"
                                            IF crSigCdOpe.Origems = 1 AND crSigCdOpe.EstOrigs = 1
                                                loc_cGrupoD = LocalEest.GrupoOs
                                                loc_cContaD = LocalEest.ContaOs
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                *-- Determinar material (UnifBals)
                IF USED("TmpGccr") AND !EOF("TmpGccr") AND INLIST(TmpGccr.UnifBals, 3, 4)
                    IF USED("crSigCdPam") AND !EOF("crSigCdPam")
                        loc_cMaterial = IIF(EMPTY(TmpPro.MatPrincs), ALLTRIM(crSigCdPam.Ouros), TmpPro.MatPrincs)
                    ELSE
                        loc_cMaterial = TmpPro.MatPrincs
                    ENDIF
                ELSE
                    IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 1 AND ;
                       USED("crSigCdPam") AND !EOF("crSigCdPam")
                        loc_cMaterial = ALLTRIM(crSigCdPam.Ouros)
                    ELSE
                        loc_cMaterial = LocalEestI.Cpros
                    ENDIF
                ENDIF
                loc_cMatResFa = loc_cMaterial

                IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 4 AND ;
                   LocalEestI.Cpros <> loc_cMaterial
                    IF LocalEestI.Cpros <> loc_cMatSec
                        LOOP
                    ELSE
                        loc_cMaterial = loc_cMatSec
                        loc_cMatResFa = loc_cMatSec
                    ENDIF
                ENDIF

                *-- Scan LocalEsti2
                SELECT LocalEsti2
                SET ORDER TO EmpDopNums
                IF SEEK(LocalEestI.EmpDopNums + LocalEestI.Cpros + STR(LocalEestI.Citens, 4))
                    SCAN WHILE EmpDopNums + Cpros + STR(Citens, 4) = ;
                               LocalEestI.EmpDopNums + LocalEestI.Cpros + STR(LocalEestI.Citens, 4)
                        loc_nQtde = LocalEsti2.Qtds
                        loc_nPeso = LocalEsti2.Pesos
                        loc_cCodCor = PADR(IIF(INLIST(LocalGru.TipoEstos, 2, 4), ALLTRIM(LocalEsti2.CodCors), " "), 4)
                        loc_cCodTam = PADR(IIF(INLIST(LocalGru.TipoEstos, 3, 4), ALLTRIM(LocalEsti2.CodTams), " "), 4)
                        IF loc_lOrigem
                            IF !SEEK(loc_cGrupo + loc_cConta, "TmpConta")
                                =SEEK(LocalEest.ContaOs, "TmpCli", "BalCodigo")
                                INSERT INTO TmpConta (Grupo, Conta, Nome) ;
                                    VALUES (loc_cGrupo, loc_cConta, IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
                            ENDIF
                            IF !SEEK(loc_cGrupo + loc_cConta + LocalEsti2.CPros + loc_cCodCor + loc_cCodTam, "TmpResumo")
                                INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                    VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, LocalEestI.CUnis, TmpPro.Varias, ;
                                            LocalGru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
                            ENDIF
                            SELECT TmpResumo
                            IF loc_cOperacao = "E"
                                REPLACE QtdeEnts  WITH QtdeEnts  + LocalEsti2.Qtds, ;
                                        PesoEnts  WITH PesoEnts  + loc_nQtde, ;
                                        PesoFabre WITH PesoFabre + loc_nQtde
                                THIS.IncluirHistorico("Eest", "O", "E", loc_nQtde, loc_nQtde, loc_nQtde, ;
                                                      loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
                            ELSE
                                REPLACE QtdeSais  WITH QtdeSais  + LocalEsti2.Qtds, ;
                                        PesoSais  WITH PesoSais  + loc_nQtde, ;
                                        PesoFabrs WITH PesoFabrs + loc_nQtde
                                THIS.IncluirHistorico("Eest", "O", "S", loc_nQtde, loc_nQtde, loc_nQtde, ;
                                                      loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
                            ENDIF
                            IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros + SPACE(15), "TmpOpera")
                                INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                    VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, SPACE(15), ;
                                            TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
                            ENDIF
                            SELECT TmpOpera
                            IF loc_cOperacao = "E"
                                REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde, PesoEnts WITH PesoEnts + loc_nQtde
                            ELSE
                                REPLACE QtdeSais WITH QtdeSais + loc_nQtde, PesoSais WITH PesoSais + loc_nQtde
                            ENDIF
                            IF loc_cOperacao = "E"
                                IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
                                    INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
                                        VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Entrada " + loc_cGrupoD)
                                ENDIF
                            ELSE
                                IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
                                    INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
                                        VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Saida   " + loc_cGrupoD)
                                ENDIF
                            ENDIF
                            REPLACE Qtds  WITH TmpResFas.Qtds  + loc_nQtde, ;
                                    Pesos WITH TmpResFas.Pesos + loc_nQtde IN TmpResFas
                        ENDIF
                        IF loc_lDestino
                            IF !SEEK(loc_cGrupo + loc_cConta, "TmpConta")
                                =SEEK(loc_cConta, "TmpCli", "BalCodigo")
                                INSERT INTO TmpConta (Grupo, Conta, Nome) ;
                                    VALUES (loc_cGrupo, loc_cConta, IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
                            ENDIF
                            IF !SEEK(loc_cGrupo + loc_cConta + LocalEsti2.CPros + loc_cCodCor + loc_cCodTam, "TmpResumo")
                                INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                    VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, TmpPro.CUnis, TmpPro.Varias, ;
                                            LocalGru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
                            ENDIF
                            SELECT TmpResumo
                            IF loc_cOperacao = "E"
                                REPLACE QtdeEnts  WITH QtdeEnts  + LocalEsti2.Qtds, ;
                                        PesoEnts  WITH PesoEnts  + loc_nQtde, ;
                                        PesoFabre WITH PesoFabre + loc_nQtde
                                THIS.IncluirHistorico("Eest", "D", "E", loc_nQtde, loc_nQtde, loc_nQtde, ;
                                                      loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
                            ELSE
                                REPLACE QtdeSais  WITH QtdeSais  + LocalEsti2.Qtds, ;
                                        PesoSais  WITH PesoSais  + loc_nQtde, ;
                                        PesoFabrs WITH PesoFabrs + loc_nQtde
                                THIS.IncluirHistorico("Eest", "D", "S", loc_nQtde, loc_nQtde, loc_nQtde, ;
                                                      loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
                            ENDIF
                            IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros + SPACE(15), "TmpOpera")
                                INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                    VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, SPACE(15), ;
                                            TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
                            ENDIF
                            SELECT TmpOpera
                            IF loc_cOperacao = "E"
                                REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde, PesoEnts WITH PesoEnts + loc_nQtde
                            ELSE
                                REPLACE QtdeSais WITH QtdeSais + loc_nQtde, PesoSais WITH PesoSais + loc_nQtde
                            ENDIF
                            IF loc_cOperacao = "E"
                                IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
                                    INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
                                        VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Entrada " + loc_cGrupoD)
                                ENDIF
                            ELSE
                                IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
                                    INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
                                        VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Saida   " + loc_cGrupoD)
                                ENDIF
                            ENDIF
                            REPLACE Qtds  WITH TmpResFas.Qtds  + loc_nQtde, ;
                                    Pesos WITH TmpResFas.Pesos + loc_nQtde IN TmpResFas
                        ENDIF
                    ENDSCAN
                ELSE
                    *-- Sem LocalEsti2: usar LocalEestI diretamente
                    loc_nQtde = LocalEestI.Qtds
                    loc_nPeso = LocalEestI.Pesos
                    IF loc_lOrigem
                        IF !SEEK(loc_cGrupo + loc_cConta, "TmpConta")
                            =SEEK(LocalEest.ContaOs, "TmpCli", "BalCodigo")
                            INSERT INTO TmpConta (Grupo, Conta, Nome) ;
                                VALUES (loc_cGrupo, loc_cConta, IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
                        ENDIF
                        IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros, "TmpResumo")
                            INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                                VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, LocalEestI.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
                        ENDIF
                        SELECT TmpResumo
                        IF loc_cOperacao = "E"
                            REPLACE QtdeEnts  WITH QtdeEnts  + LocalEestI.Qtds, ;
                                    PesoEnts  WITH PesoEnts  + loc_nQtde, ;
                                    PesoFabre WITH PesoFabre + loc_nQtde
                            THIS.IncluirHistorico("Eest", "O", "E", loc_nQtde, loc_nQtde, loc_nQtde, ;
                                                  loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
                        ELSE
                            REPLACE QtdeSais  WITH QtdeSais  + LocalEestI.Qtds, ;
                                    PesoSais  WITH PesoSais  + loc_nQtde, ;
                                    PesoFabrs WITH PesoFabrs + loc_nQtde
                            THIS.IncluirHistorico("Eest", "O", "S", loc_nQtde, loc_nQtde, loc_nQtde, ;
                                                  loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
                        ENDIF
                        IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros + SPACE(15), "TmpOpera")
                            INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, AplicFlhs) ;
                                VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, SPACE(15), LocalGgrp.AplicFlhs)
                        ENDIF
                        SELECT TmpOpera
                        IF loc_cOperacao = "E"
                            REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde, PesoEnts WITH PesoEnts + loc_nQtde
                        ELSE
                            REPLACE QtdeSais WITH QtdeSais + loc_nQtde, PesoSais WITH PesoSais + loc_nQtde
                        ENDIF
                        IF loc_cOperacao = "E"
                            IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
                                INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
                                    VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Entrada " + loc_cGrupoD)
                            ENDIF
                        ELSE
                            IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
                                INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
                                    VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Saida   " + loc_cGrupoD)
                            ENDIF
                        ENDIF
                        REPLACE Qtds  WITH TmpResFas.Qtds  + loc_nQtde, ;
                                Pesos WITH TmpResFas.Pesos + loc_nQtde IN TmpResFas
                    ENDIF
                    IF loc_lDestino
                        IF !SEEK(loc_cGrupo + loc_cConta, "TmpConta")
                            =SEEK(loc_cConta, "TmpCli", "BalCodigo")
                            INSERT INTO TmpConta (Grupo, Conta, Nome) ;
                                VALUES (loc_cGrupo, loc_cConta, IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
                        ENDIF
                        IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros, "TmpResumo")
                            INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                                VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
                        ENDIF
                        SELECT TmpResumo
                        IF loc_cOperacao = "E"
                            REPLACE QtdeEnts  WITH QtdeEnts  + LocalEestI.Qtds, ;
                                    PesoEnts  WITH PesoEnts  + loc_nQtde, ;
                                    PesoFabre WITH PesoFabre + loc_nQtde
                            THIS.IncluirHistorico("Eest", "D", "E", loc_nQtde, loc_nQtde, loc_nQtde, ;
                                                  loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
                        ELSE
                            REPLACE QtdeSais  WITH QtdeSais  + LocalEestI.Qtds, ;
                                    PesoSais  WITH PesoSais  + loc_nQtde, ;
                                    PesoFabrs WITH PesoFabrs + loc_nQtde
                            THIS.IncluirHistorico("Eest", "D", "S", loc_nQtde, loc_nQtde, loc_nQtde, ;
                                                  loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
                        ENDIF
                        IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros + SPACE(15), "TmpOpera")
                            INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, SPACE(15), ;
                                        TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
                        ENDIF
                        SELECT TmpOpera
                        IF loc_cOperacao = "E"
                            REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde, PesoEnts WITH PesoEnts + loc_nQtde
                        ELSE
                            REPLACE QtdeSais WITH QtdeSais + loc_nQtde, PesoSais WITH PesoSais + loc_nQtde
                        ENDIF
                        IF loc_cOperacao = "E"
                            IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
                                INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
                                    VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Entrada " + loc_cGrupoD)
                            ENDIF
                        ELSE
                            IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
                                INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
                                    VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Saida   " + loc_cGrupoD)
                            ENDIF
                        ENDIF
                        REPLACE Qtds  WITH TmpResFas.Qtds  + loc_nQtde, ;
                                Pesos WITH TmpResFas.Pesos + loc_nQtde IN TmpResFas
                    ENDIF
                ENDIF

                loc_lOrigemF  = IIF(!loc_lOrigemF,  loc_lOrigem,  loc_lOrigemF)
                loc_lDestinoF = IIF(!loc_lDestinoF, loc_lDestino, loc_lDestinoF)
            ENDSCAN

            *-- Marcar SigMvCab como processada
            IF THIS.this_lFechamento AND (loc_lOrigemF OR loc_lDestinoF)
                loc_cUpdate = "UPDATE SigMvCab SET " + ;
                              IIF(loc_lOrigemF, "ProcBals = ?loc_llTrue, NumBals = " + TRANSFORM(loc_nCodigosFcx) + " ", "") + ;
                              IIF(loc_lDestinoF, IIF(loc_lOrigemF, ",", "") + ;
                              "ProcDBal = ?loc_llTrue, NumBalds = " + TRANSFORM(loc_nCodigosFcx) + " ", " ") + ;
                              "WHERE CidChaves = '" + ALLTRIM(LocalEest.CidChaves) + "'"
                IF SQLEXEC(gnConnHandle, loc_cUpdate, "") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (Update SigMvCab). Reinicializar.", "FormFea")
                    SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
                    RETURN .F.
                ENDIF
            ENDIF

        ENDSCAN
        loc_loBarra.Complete()

        *==========================================================================
        *-- SALDOS DE ESTOQUE (CrSalEst / SigMvEst)
        *==========================================================================
        LOCAL loc_cGrupoFcx, loc_cContaFcx
        loc_cGrupoFcx = IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Grupos, loc_cGrupo)
        loc_cContaFcx = IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Contas, loc_cConta)
        loc_cEGE = loc_cEmpr + PADR(loc_cGrupoFcx, 10) + PADR(loc_cContaFcx, 10)

        loc_cSql = "SELECT * FROM SigMvEst WHERE EmpGruEsts = " + EscaparSQL(loc_cEGE)
        IF SQLEXEC(gnConnHandle, loc_cSql, "CrSalEst") < 1
            MsgErro("Falha na conex" + CHR(227) + "o (CrSalEst). Reinicializar.", "FormFea")
            SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
            RETURN .F.
        ENDIF

        SELECT CrSalEst
        SCAN
            =SEEK(CrSalEst.Cpros, "TmpPro", "CPros")
            =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
            =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
            loc_cCodCor = PADR(IIF(INLIST(LocalGru.TipoEstos, 2, 4), ALLTRIM(CrSalEst.CodCors), " "), 4)
            loc_cCodTam = PADR(IIF(INLIST(LocalGru.TipoEstos, 3, 4), ALLTRIM(CrSalEst.CodTams), " "), 4)
            IF !SEEK(loc_cGrupoFcx + loc_cContaFcx + CrSalEst.Cpros + loc_cCodCor + loc_cCodTam, "TmpResumo")
                INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                    VALUES (loc_cGrupoFcx, loc_cContaFcx, CrSalEst.Cpros, TmpPro.CUnis, ;
                            TmpPro.Varias, LocalGru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
            ENDIF
        ENDSCAN

        *==========================================================================
        *-- PESAGENS (LocalPesa / LocalPesaI / SigCdPsc / SigCdPsi)
        *==========================================================================
        loc_pDtI = fDtoSQL(loc_dDataUBal)
        loc_pDtF = fDtoSQL(loc_dData, "23:59:59")

        loc_cQuery = "SELECT Emps, Codigos, CidChaves FROM SigCdPsc " + ;
                     "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
                     " AND Grupos = " + EscaparSQL(loc_cGrupo) + ;
                     " AND Contas = " + EscaparSQL(loc_cConta) + ;
                     " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF AND ProcBals = ?loc_llFalse" + ;
                     " ORDER BY Emps, Codigos"

        IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalPesa") < 1
            MsgErro("Falha na conex" + CHR(227) + "o (LocalPesa). Reinicializar.", "FormFea")
            SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
            RETURN .F.
        ENDIF

        SELECT LocalPesa
        SCAN
            loc_cQuery = "SELECT CPros, Qtds, Pesos FROM SigCdPsi " + ;
                         "WHERE Emps = " + EscaparSQL(ALLTRIM(LocalPesa.Emps)) + ;
                         " AND Codigos = " + TRANSFORM(LocalPesa.Codigos) + ;
                         " ORDER BY CPros"
            IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalPesaI") < 1
                MsgErro("Falha na conex" + CHR(227) + "o (LocalPesaI). Reinicializar.", "FormFea")
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
                RETURN .F.
            ENDIF
            SELECT LocalPesaI
            SCAN
                =SEEK(LocalPesaI.CPros, "TmpPro", "CPros")
                =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
                =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
                IF !SEEK(loc_cGrupo + loc_cConta + LocalPesaI.CPros, "TmpResumo")
                    INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                        VALUES (loc_cGrupo, loc_cConta, LocalPesaI.CPros, TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
                ENDIF
                SELECT TmpResumo
                REPLACE Pesagem  WITH TmpResumo.Pesagem  + LocalPesaI.Qtds  IN TmpResumo
                REPLACE Pesagem3 WITH TmpResumo.Pesagem3 + LocalPesaI.Pesos IN TmpResumo
            ENDSCAN

            *-- UnifBals=1: agregar pesagem no ouro
            IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 1 AND ;
               USED("crSigCdPam") AND !EOF("crSigCdPam")
                loc_cMatOuro = ALLTRIM(crSigCdPam.Ouros)
                IF !EMPTY(loc_cMatOuro)
                    SELECT TmpResumo
                    SET ORDER TO
                    LOCATE FOR CMats = loc_cMatOuro
                    IF EOF()
                        APPEND BLANK
                        REPLACE CMats WITH loc_cMatOuro, Visivel WITH .T.
                    ENDIF
                    SELECT [  ] AS Agregar, SUM(Pesagem) AS Pesagem FROM TmpResumo ;
                        WHERE CMats <> loc_cMatOuro AND Varias <> 1 AND Agregas <> 1 AND Pesagem <> 0 ;
                        INTO CURSOR csTotal GROUP BY 1
                    GO TOP IN csTotal
                    REPLACE Pesagem  WITH Pesagem  + csTotal.Pesagem, ;
                            Pesagem2 WITH Pesagem2 + csTotal.Pesagem IN TmpResumo
                ENDIF
            ENDIF

            SELECT TmpResumo
            SET ORDER TO GrConMat

            IF THIS.this_lFechamento
                loc_cUpdate = "UPDATE SigCdPsc SET ProcBals = ?loc_llTrue, NumBals = " + ;
                              TRANSFORM(loc_nCodigosFcx) + ;
                              " WHERE cidchaves = '" + ALLTRIM(LocalPesa.cidchaves) + "'"
                IF SQLEXEC(gnConnHandle, loc_cUpdate, "") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdPsc). Reinicializar.", "FormFea")
                    SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
                    RETURN .F.
                ENDIF
            ENDIF
        ENDSCAN

        *==========================================================================
        *-- CALCULOS FINAIS: saldos, falhas, produtividade
        *==========================================================================
        SELECT TmpResumo
        REPLACE ALL Flag3 WITH .T.

        SELECT TmpOpera
        REPLACE ALL PesoBEnts WITH PesoEnts, PesoBSais WITH PesoSais, ;
                    QtdeBEnts WITH QtdeEnts, QtdeBSais WITH QtdeSais IN TmpOpera

        *-- UnifBals=1: unificar como ouro
        IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 1 AND ;
           USED("crSigCdPam") AND !EOF("crSigCdPam")
            loc_cMatOuro = ALLTRIM(crSigCdPam.Ouros)
            IF !EMPTY(loc_cMatOuro)
                SELECT TmpResumo
                SET ORDER TO
                LOCATE FOR CMats = loc_cMatOuro
                IF EOF()
                    APPEND BLANK
                    REPLACE CMats WITH loc_cMatOuro, Visivel WITH .T.
                ENDIF
                SELECT [  ] AS Agregar, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
                    FROM TmpResumo WHERE CMats <> loc_cMatOuro AND Varias <> 1 AND Agregas <> 1 ;
                    INTO CURSOR csTotal GROUP BY 1
                GO TOP IN csTotal
                SELECT TmpResumo
                SCAN
                    IF CMats = loc_cMatOuro
                        REPLACE PesoEnts WITH PesoEnts + csTotal.pEnts, PesoSais WITH PesoSais + csTotal.pSais, ;
                                QtdeEnts WITH QtdeEnts + csTotal.pEnts, QtdeSais WITH QtdeSais + csTotal.pSais
                    ELSE
                        IF Agregas <> 1
                            REPLACE Visivel WITH .F., Flag3 WITH .F.
                        ENDIF
                    ENDIF
                ENDSCAN
                =SEEK(loc_cMatOuro, "TmpPro", "CPros")
                =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
                =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
                SELECT Grupo, Conta, TpOps, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
                    FROM TmpOpera WHERE CMats <> loc_cMatOuro AND Varias <> 1 AND Agregas <> 1 ;
                    GROUP BY Grupo, Conta, TpOps INTO CURSOR csTotal
                SELECT csTotal
                SCAN
                    IF !SEEK(csTotal.Grupo + csTotal.Conta + loc_cMatOuro + csTotal.TpOps, "TmpOpera")
                        INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                            VALUES (csTotal.Grupo, csTotal.Conta, loc_cMatOuro, csTotal.TpOps, ;
                                    TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
                    ENDIF
                    REPLACE TmpOpera.PesoEnts WITH TmpOpera.PesoEnts + csTotal.pEnts IN TmpOpera
                    REPLACE TmpOpera.PesoSais WITH TmpOpera.PesoSais + csTotal.pSais IN TmpOpera
                    REPLACE TmpOpera.QtdeEnts WITH TmpOpera.QtdeEnts + csTotal.pEnts IN TmpOpera
                    REPLACE TmpOpera.QtdeSais WITH TmpOpera.QtdeSais + csTotal.pSais IN TmpOpera
                ENDSCAN
                SELECT Grupo, Conta, TpOps, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
                    FROM TmpOpera WHERE CMats <> loc_cMatOuro AND Varias <> 1 AND Agregas <> 1 AND AplicFlhs <> 2 ;
                    GROUP BY Grupo, Conta, TpOps INTO CURSOR csTotal
                SELECT csTotal
                SCAN
                    IF !SEEK(csTotal.Grupo + csTotal.Conta + loc_cMatOuro + csTotal.TpOps, "TmpOpera")
                        INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                            VALUES (csTotal.Grupo, csTotal.Conta, loc_cMatOuro, csTotal.TpOps, ;
                                    TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
                    ENDIF
                    REPLACE TmpOpera.PesoBEnts WITH TmpOpera.PesoBEnts + csTotal.pEnts IN TmpOpera
                    REPLACE TmpOpera.PesoBSais WITH TmpOpera.PesoBSais + csTotal.pSais IN TmpOpera
                    REPLACE TmpOpera.QtdeBEnts WITH TmpOpera.QtdeBEnts + csTotal.pEnts IN TmpOpera
                    REPLACE TmpOpera.QtdeBSais WITH TmpOpera.QtdeBSais + csTotal.pSais IN TmpOpera
                ENDSCAN
            ENDIF
        ENDIF

        *-- Saldo anterior (CrUltBal -> CrSaldoI)
        loc_cQuery = "SELECT Codigos FROM SigCdFcx " + ;
                     "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
                     " AND Grupos = " + EscaparSQL(loc_cGrupo) + ;
                     " AND Contas = " + EscaparSQL(loc_cConta) + ;
                     " AND NOT Codigos = " + TRANSFORM(loc_nCodigosFcx) + ;
                     " ORDER BY Codigos"
        IF SQLEXEC(gnConnHandle, loc_cQuery, "CrUltBal") < 1
            MsgErro("Falha na conex" + CHR(227) + "o (CrUltBal). Reinicializar.", "FormFea")
            SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
            RETURN .F.
        ENDIF
        SELECT CrUltBal
        GO BOTTOM
        IF RECCOUNT() > 0
            loc_cSql = "SELECT * FROM SigOpCfe WHERE Codigos = " + TRANSFORM(CrUltBal.Codigos) + ;
                       " AND Emps = " + EscaparSQL(loc_cEmpr) + " ORDER BY Codigos, cpros"
        ELSE
            loc_cSql = "SELECT * FROM SigOpCfe WHERE 0 = 1"
        ENDIF
        IF SQLEXEC(gnConnHandle, loc_cSql, "CrSaldoI") < 1
            MsgErro("Falha na conex" + CHR(227) + "o (CrSaldoI). Reinicializar.", "FormFea")
            SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
            RETURN .F.
        ENDIF
        SELECT CrSaldoI
        INDEX ON Cpros TAG Cpros

        loc_nTrabalhado = 0
        loc_nTrabalhadB = 0

        *-- Calcular saldos finais para cada material em TmpResumo
        SELECT TmpResumo
        loc_loBarra = CREATEOBJECT("fwprogressbar", "Preparando Resumos", RECCOUNT("TmpResumo"))
        loc_loBarra.Show
        loc_cMatPrev = SPACE(14)

        SCAN
            loc_loBarra.Update(.T.)
            STORE 0 TO loc_nSaldoi, loc_nPesagem

            =SEEK(TmpResumo.CMats, "TmpPro", "CPros")
            IF !loc_llTipoQ AND TmpResumo.CMats <> loc_cMatPrev
                loc_nFalhaAdmitida = 0
                loc_cMatPrev = TmpResumo.CMats
            ENDIF

            SELECT CrSaldoI
            =SEEK(TmpResumo.CMats)
            loc_nSaldoi = IIF(EOF("CrSaldoI"), 0, CrSaldoI.Pesagems)

            SELECT TmpOpera
            =SEEK(TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats)
            loc_nTrabalhado = 0
            loc_nTrabalhadB = 0
            SCAN WHILE CMats = TmpResumo.CMats
                =SEEK(TmpOpera.TpOps, "crSigOpOpt", "Cods")
                IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND ;
                   USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;
                   crSigOpOpt.PFalhas <> 0 AND TmpPro.Varias = 1 AND ;
                   crSigOpOpt.TFalhas <> "Q" AND TmpOpera.AplicFlhs <> 2 AND ;
                   crSigCdPam.GrTrans <> loc_cGrupo
                    loc_nFalhaAdmitida = loc_nFalhaAdmitida + ROUND(TmpOpera.QtdeBSais * crSigOpOpt.PFalhas / 100, 3)
                    REPLACE PFalha WITH crSigOpOpt.PFalhas, ;
                            Falha  WITH ROUND(TmpOpera.QtdeBSais * crSigOpOpt.PFalhas / 100, 3) IN TmpOpera
                ENDIF
                IF USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;
                   (crSigOpOpt.Trabas = 1 OR EMPTY(TmpOpera.TpOps))
                    loc_nTrabalhado = loc_nTrabalhado + TmpOpera.QtdeSais
                    loc_nTrabalhadB = loc_nTrabalhadB + TmpOpera.QtdeBSais
                ENDIF
            ENDSCAN
            IF loc_nTrabalhadB <> 0
                loc_nTrabalhado = loc_nTrabalhadB
            ENDIF

            SELECT TmpResumo
            REPLACE Saldoi  WITH loc_nSaldoi, ;
                    FReal   WITH loc_nSaldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - TmpResumo.Pesagem, ;
                    FAdmin  WITH loc_nFalhaAdmitida, ;
                    Saldof  WITH loc_nSaldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - TmpResumo.Pesagem - loc_nFalhaAdmitida, ;
                    PfTrabs WITH IIF(loc_nTrabalhado <> 0, (Saldof / loc_nTrabalhado * 100), 0)

            =SEEK(loc_cConta, "TmpCli", "BalCodigo")
            IF TmpResumo.Saldof <> 0 AND USED("TmpCli") AND !EOF("TmpCli") AND ;
               (TmpCli.PagFals = 1 OR TmpCli.RecFals = 1)
                REPLACE Flag WITH .T., Flag2 WITH .T. IN TmpResumo
                IF THIS.this_lFechamento
                    IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "cnt_4c_Conversao", 5)
                        loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao.Visible = .T.
                    ENDIF
                ENDIF
            ENDIF
        ENDSCAN

        *-- Processar registros do saldo anterior que nao estao em TmpResumo
        SELECT CrSaldoI
        loc_loBarra = CREATEOBJECT("fwprogressbar", "Preparando Resumos", RECCOUNT("CrSaldoI"))
        loc_loBarra.Show
        SCAN
            loc_loBarra.Update(.T.)
            IF CrSaldoI.Pesagems = 0
                LOOP
            ENDIF
            =SEEK(CrSaldoI.Cpros, "TmpPro", "CPros")
            =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
            =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
            loc_nSaldoi = CrSaldoI.Pesagems
            SELECT TmpResumo
            LOCATE FOR CMats = CrSaldoI.Cpros
            IF EOF()
                INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                    VALUES (loc_cGrupo, loc_cConta, CrSaldoI.Cpros, TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
                SELECT TmpResumo
                REPLACE Saldoi WITH loc_nSaldoi, FReal WITH loc_nSaldoi, ;
                        FAdmin WITH 0, Saldof WITH loc_nSaldoi, PfTrabs WITH 0
            ENDIF
        ENDSCAN

        *-- Construir tabela de cotacoes (TmpCot)
        SELECT TmpResumo
        SCAN
            =SEEK(TmpResumo.CMats, "TmpPro", "CPros")
            =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")

            loc_nCusto = 0
            loc_cMoeda = ""

            IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND crSigCdPam.AcertBals = 1
                loc_nCusto = TmpPro.Custofs
                loc_cMoeda = ALLTRIM(TmpPro.MoeCusfs)
            ELSE
                LOCAL loc_pDtHist1, loc_pDtHist2
                loc_pDtHist1 = fDtoSQL(IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData))
                loc_pDtHist2 = fDtoSQL(IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData), "23:59:59")
                loc_cQuery = "SELECT TOP 1 cIdChaves, UnitMeds FROM SigMvHst " + ;
                             "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
                             " AND Cpros = " + EscaparSQL(ALLTRIM(TmpResumo.CMats)) + ;
                             " AND Datas BETWEEN ?loc_pDtHist1 AND ?loc_pDtHist2" + ;
                             " ORDER BY cIdChaves DESC, UnitMeds ASC"
                IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalHis") > 0
                    GO TOP IN LocalHis
                    IF !EOF("LocalHis")
                        loc_nCusto = LocalHis.UnitMeds
                        loc_cMoeda = ALLTRIM(LocalGru.MoeCusts)
                    ENDIF
                ENDIF
            ENDIF

            IF EMPTY(loc_cMoeda)
                LOOP
            ENDIF

            LOCAL loc_dDataFcx
            loc_dDataFcx = IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData)
            loc_nCota = fBuscarCotacao(loc_cMoeda, loc_dDataFcx, gnConnHandle)
            IF !SEEK(loc_cMoeda, "TmpCot")
                INSERT INTO TmpCot (Cmoes, Valos) VALUES (loc_cMoeda, loc_nCota)
            ENDIF
        ENDSCAN

        *-- Adicionar cotacoes de todas as moedas (SigCdMoe)
        loc_cSql = "SELECT CMoes FROM SigCdMoe ORDER BY CMoes"
        IF SQLEXEC(gnConnHandle, loc_cSql, "LocalMoe") > 0
            SELECT LocalMoe
            SCAN
                IF !SEEK(ALLTRIM(LocalMoe.Cmoes), "TmpCot")
                    loc_nCota = fBuscarCotacao(ALLTRIM(LocalMoe.Cmoes), ;
                                               IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData), ;
                                               gnConnHandle)
                    INSERT INTO TmpCot (Cmoes, Valos) VALUES (ALLTRIM(LocalMoe.Cmoes), loc_nCota)
                ENDIF
            ENDSCAN
        ENDIF
        loc_loBarra.Complete()

        *-- Posicionar cursores
        SELECT TmpResumo
        SET ORDER TO GrConMat
        GO TOP
        SELECT TmpOpera
        SET ORDER TO GrConMatTp
        SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
        GO TOP
        SELECT TmpResFas
        SET ORDER TO Fases
        SET KEY TO TmpResumo.CMats
        GO TOP
        SELECT TmpResumo
        GO TOP

        IF EOF("TmpResumo")
            MsgAviso("Nenhuma Informa" + CHR(231) + CHR(227) + "o Foi Selecionada...")
            loc_oPagina.txt_4c_Data.SetFocus()
            RETURN .F.
        ENDIF

        *-- Calcular indice de produtividade
        SELECT a.Grupo, a.Conta, a.CMats, COUNT(a.TpOps) AS TotTpOp, ;
               SUM(c.IndProds) AS TotIndProd, d.Freal, SUM(a.QtdeSais) AS TotQtde ;
            FROM TmpOpera a, crSigOpOpt c, TmpResumo d ;
            WHERE !EMPTY(a.QtdeSais) AND a.TpOps = c.Cods AND c.IndProds > 0 AND ;
                  d.Grupo + d.Conta + d.CMats = a.Grupo + a.Conta + a.CMats ;
            GROUP BY a.Grupo, a.Conta, a.CMats, d.Freal ;
            INTO CURSOR TmpIndProd

        IF RECCOUNT("TmpIndProd") > 0
            SELECT a.Grupo, a.Conta, a.CMats, ;
                   ((a.TotQtde + a.Freal) * ((a.TotIndProd / a.TotTpOp) / 100)) AS IndProd ;
                FROM TmpIndProd a INTO CURSOR TmpIndProd
            UPDATE TmpResumo SET IndProd = TmpIndProd.IndProd ;
                WHERE TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats = ;
                      TmpIndProd.Grupo + TmpIndProd.Conta + TmpIndProd.CMats
        ENDIF

        *-- Atualizar grdMov RecordSource (controle de Fase 6)
        IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "grdMov", 5)
            loc_oPagina.cnt_4c_Resultado.grdMov.RecordSource = ""
            SELECT Dopps, 1 AS nMarcas FROM TmpHist GROUP BY Dopps INTO CURSOR CrOpp READWRITE
            WITH loc_oPagina.cnt_4c_Resultado.grdMov
                .RecordSource          = "crOpp"
                .Column1.ControlSource = "crOpp.nMarcas"
                .Column2.ControlSource = "crOpp.Dopps"
                .Column1.Width = 17
                .Column2.Width = 150
                .Refresh()
            ENDWITH
        ENDIF

        *-- Inserir no CrSigCdFea se Fechamento
        IF THIS.this_lFechamento
            loc_nNumFape = fGerUniqueKey(loc_cEmpr + "SigCdFea")
            SELECT TmpResumo
            GO TOP
            INSERT INTO CrSigCdFea (Grupos, Contas, Datas, Emps, Falhas, Numes, Produzidos, ;
                                    Tipos, Trabs, CidChaves, NumBals) ;
                VALUES (loc_cGrupo, loc_cConta, loc_dData, ;
                        IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), ALLTRIM(crSigCdFcx.Emps), loc_cEmpr), ;
                        IIF(!EOF("TmpResumo"), TmpResumo.Saldof, 0), ;
                        loc_nNumFape, 0, "F", loc_nTrabalhado, fUniqueIds(), loc_nCodigosFcx)
        ENDIF

        *-- Habilitar Confirmar
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.

        *-- Exibir resultado (Fase 6: GradeMat refresh via PEMSTATUS)
        IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "GradeMat", 5)
            loc_oPagina.cnt_4c_Resultado.GradeMat.AfterRowColChange(1)
            loc_oPagina.cnt_4c_Resultado.GradeMat.Refresh
        ENDIF

        loc_oPagina.cnt_4c_Resultado.Refresh
        loc_oPagina.cnt_4c_Resultado.Visible = .T.

        *-- Botao Pesagem: apenas com acesso PESAGEM (Fase 6 guard)
        IF THIS.this_lFechamento AND fChecaAcesso("SIGCDFEA", "PESAGEM")
            IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "Pesagem", 5)
                loc_oPagina.cnt_4c_Resultado.Pesagem.Visible = .T.
            ENDIF
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ConfigurarResultado - Popula cnt_4c_Resultado com todos os sub-controles
    * Chamado por ConfigurarPaginaDados() apos criar o container vazio.
    * ColumnCount e RecordSource ficam FORA de WITH (Problema 36 VFP9).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarResultado(par_oCnt)
        LOCAL loc_lResultado, loc_oGrd, loc_oPage
        loc_lResultado = .F.
        TRY
            *-- Shape3: barra de cabecalho periodo (top=7,left=8,w=434,h=31)
            par_oCnt.AddObject("shp_4c_Shape3", "Shape")
            WITH par_oCnt.shp_4c_Shape3
                .Top           = 7
                .Left          = 8
                .Width         = 434
                .Height        = 31
                .SpecialEffect = 1
                .BackColor     = RGB(204, 204, 204)
                .BackStyle     = 1
                .BorderStyle   = 1
                .Curvature     = 0
                .Visible       = .T.
            ENDWITH

            *-- Label18: "Periodo :" (top=15,left=19,w=45,h=15)
            par_oCnt.AddObject("lbl_4c_Label18", "Label")
            WITH par_oCnt.lbl_4c_Label18
                .Caption   = "Per" + CHR(237) + "odo :"
                .Top       = 15
                .Left      = 19
                .Width     = 45
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- Get_Datai: data inicial (top=12,left=79,w=72,h=21)
            par_oCnt.AddObject("Get_Datai", "TextBox")
            WITH par_oCnt.Get_Datai
                .Value         = DATE()
                .Top           = 12
                .Left          = 79
                .Width         = 72
                .Height        = 21
                .Format        = "K"
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(240, 240, 240)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- Label4: "e" separador (top=15,left=157,w=8)
            par_oCnt.AddObject("lbl_4c_Label4", "Label")
            WITH par_oCnt.lbl_4c_Label4
                .Caption   = CHR(233)
                .Top       = 15
                .Left      = 157
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- Get_Dataf: data final (top=12,left=170,w=72,h=21)
            par_oCnt.AddObject("Get_Dataf", "TextBox")
            WITH par_oCnt.Get_Dataf
                .Value         = DATE()
                .Top           = 12
                .Left          = 170
                .Width         = 72
                .Height        = 21
                .Format        = "K"
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(240, 240, 240)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- Shape4: area de resumo numerico (top=46,left=193,w=248,h=241)
            par_oCnt.AddObject("shp_4c_Shape4", "Shape")
            WITH par_oCnt.shp_4c_Shape4
                .Top           = 46
                .Left          = 193
                .Width         = 248
                .Height        = 241
                .SpecialEffect = 1
                .BackColor     = RGB(204, 204, 204)
                .BackStyle     = 1
                .BorderStyle   = 1
                .Curvature     = 0
                .Visible       = .T.
            ENDWITH

            *-- Label1: " Resumos " (top=49,left=205,w=60,h=15)
            par_oCnt.AddObject("lbl_4c_Label1", "Label")
            WITH par_oCnt.lbl_4c_Label1
                .Caption   = " Resumos "
                .Top       = 49
                .Left      = 205
                .Width     = 60
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- Labels dos campos numericos
            par_oCnt.AddObject("lbl_4c_Label5", "Label")
            WITH par_oCnt.lbl_4c_Label5
                .Caption   = "Saldo Inicial : "
                .Top       = 79
                .Left      = 235
                .Width     = 68
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("lbl_4c_Label6", "Label")
            WITH par_oCnt.lbl_4c_Label6
                .Caption   = "Entradas : "
                .Top       = 102
                .Left      = 248
                .Width     = 55
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("lbl_4c_Label7", "Label")
            WITH par_oCnt.lbl_4c_Label7
                .Caption   = "Total Entradas : "
                .Top       = 125
                .Left      = 221
                .Width     = 82
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("lbl_4c_Label8", "Label")
            WITH par_oCnt.lbl_4c_Label8
                .Caption   = "Total Sa" + CHR(237) + "das : "
                .Top       = 148
                .Left      = 233
                .Width     = 70
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("lbl_4c_Label9", "Label")
            WITH par_oCnt.lbl_4c_Label9
                .Caption   = "Pesagem F" + CHR(237) + "sica : "
                .Top       = 171
                .Left      = 219
                .Width     = 84
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("lbl_4c_Label10", "Label")
            WITH par_oCnt.lbl_4c_Label10
                .Caption   = "Falha Real : "
                .Top       = 194
                .Left      = 241
                .Width     = 62
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("lbl_4c_Label11", "Label")
            WITH par_oCnt.lbl_4c_Label11
                .Caption   = "Falha Admitida : "
                .Top       = 217
                .Left      = 221
                .Width     = 82
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("lbl_4c_Label12", "Label")
            WITH par_oCnt.lbl_4c_Label12
                .Caption   = "Saldo Final : "
                .Top       = 239
                .Left      = 240
                .Width     = 63
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("lbl_4c_Label2", "Label")
            WITH par_oCnt.lbl_4c_Label2
                .Caption   = "%Falha/Trab. :"
                .Top       = 262
                .Left      = 227
                .Width     = 76
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- TextBoxes de resultado (todos ReadOnly exceto Get_Pesagem)
            par_oCnt.AddObject("Get_Saldo", "TextBox")
            WITH par_oCnt.Get_Saldo
                .Value         = 0
                .Top           = 75
                .Left          = 307
                .Width         = 109
                .Height        = 21
                .InputMask     = "999,999.999"
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(240, 240, 240)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            par_oCnt.AddObject("Get_TEntradas", "TextBox")
            WITH par_oCnt.Get_TEntradas
                .Value         = 0
                .Top           = 98
                .Left          = 307
                .Width         = 109
                .Height        = 21
                .InputMask     = "999,999.999"
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(240, 240, 240)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            par_oCnt.AddObject("Get_SEntradas", "TextBox")
            WITH par_oCnt.Get_SEntradas
                .Value         = 0
                .Top           = 121
                .Left          = 307
                .Width         = 109
                .Height        = 21
                .InputMask     = "999,999.999"
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(240, 240, 240)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            par_oCnt.AddObject("Get_SSaidas", "TextBox")
            WITH par_oCnt.Get_SSaidas
                .Value         = 0
                .Top           = 144
                .Left          = 307
                .Width         = 109
                .Height        = 21
                .InputMask     = "999,999.999"
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(240, 240, 240)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            par_oCnt.AddObject("Get_Pesagem", "TextBox")
            WITH par_oCnt.Get_Pesagem
                .Value         = 0
                .Top           = 167
                .Left          = 307
                .Width         = 109
                .Height        = 21
                .InputMask     = "999,999.999"
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oCnt.Get_Pesagem, "Valid", THIS, "PesagemLostFocus")

            par_oCnt.AddObject("Get_FReal", "TextBox")
            WITH par_oCnt.Get_FReal
                .Value         = 0
                .Top           = 190
                .Left          = 307
                .Width         = 109
                .Height        = 21
                .InputMask     = "999,999.999"
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(240, 240, 240)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            par_oCnt.AddObject("Get_FAdmitida", "TextBox")
            WITH par_oCnt.Get_FAdmitida
                .Value         = 0
                .Top           = 213
                .Left          = 307
                .Width         = 109
                .Height        = 21
                .InputMask     = "999,999.999"
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(240, 240, 240)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            par_oCnt.AddObject("Get_Saldof", "TextBox")
            WITH par_oCnt.Get_Saldof
                .Value         = 0
                .Top           = 235
                .Left          = 307
                .Width         = 109
                .Height        = 21
                .InputMask     = "999,999.999"
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(240, 240, 240)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            par_oCnt.AddObject("Get_Pfalha", "TextBox")
            WITH par_oCnt.Get_Pfalha
                .Value         = 0
                .Top           = 258
                .Left          = 307
                .Width         = 109
                .Height        = 21
                .InputMask     = "999.99"
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(240, 240, 240)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- Shape5: area de impressao (top=286,left=459,w=416,h=171)
            par_oCnt.AddObject("shp_4c_Shape5", "Shape")
            WITH par_oCnt.shp_4c_Shape5
                .Top           = 286
                .Left          = 459
                .Width         = 416
                .Height        = 171
                .SpecialEffect = 1
                .BackColor     = RGB(204, 204, 204)
                .BackStyle     = 1
                .BorderStyle   = 1
                .Curvature     = 0
                .Visible       = .T.
            ENDWITH

            *-- Label15: " Impressao " (top=288,left=474,w=69,h=15)
            par_oCnt.AddObject("lbl_4c_Label15", "Label")
            WITH par_oCnt.lbl_4c_Label15
                .Caption   = " Impress" + CHR(227) + "o "
                .Top       = 288
                .Left      = 474
                .Width     = 69
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- CheckBoxes de opcoes de impressao
            par_oCnt.AddObject("Resumido", "CheckBox")
            WITH par_oCnt.Resumido
                .Caption   = "Resumido"
                .Top       = 304
                .Left      = 469
                .Width     = 64
                .Height    = 15
                .Value     = 1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("chkServ", "CheckBox")
            WITH par_oCnt.chkServ
                .Caption   = "Servi" + CHR(231) + "os"
                .Top       = 304
                .Left      = 559
                .Width     = 58
                .Height    = 15
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("porMov", "CheckBox")
            WITH par_oCnt.porMov
                .Caption   = "por Mov."
                .Top       = 304
                .Left      = 645
                .Width     = 61
                .Height    = 15
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("porenv", "CheckBox")
            WITH par_oCnt.porenv
                .Caption   = "por Env."
                .Top       = 304
                .Left      = 735
                .Width     = 59
                .Height    = 15
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("MovLote", "CheckBox")
            WITH par_oCnt.MovLote
                .Caption   = "Mov Lote"
                .Top       = 304
                .Left      = 805
                .Width     = 62
                .Height    = 15
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("Historico", "CheckBox")
            WITH par_oCnt.Historico
                .Caption   = "Hist" + CHR(243) + "rico"
                .Top       = 319
                .Left      = 469
                .Width     = 59
                .Height    = 15
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("Analitico", "CheckBox")
            WITH par_oCnt.Analitico
                .Caption   = "Anal" + CHR(237) + "tico"
                .Top       = 319
                .Left      = 559
                .Width     = 58
                .Height    = 15
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("MovAgru", "CheckBox")
            WITH par_oCnt.MovAgru
                .Caption   = "Mov Agrupa"
                .Top       = 319
                .Left      = 645
                .Width     = 76
                .Height    = 15
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            par_oCnt.AddObject("pormat", "CheckBox")
            WITH par_oCnt.pormat
                .Caption   = "por Mat"
                .Top       = 319
                .Left      = 735
                .Width     = 55
                .Height    = 15
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- op_ordem OptionGroup (top=318,left=801,w=49,h=36 - 2 botoes)
            par_oCnt.AddObject("op_ordem", "OptionGroup")
            WITH par_oCnt.op_ordem
                .Top         = 318
                .Left        = 801
                .Width       = 49
                .Height      = 36
                .Value       = 1
                .BackStyle   = 0
                .ButtonCount = 2
                WITH .Buttons(1)
                    .Caption   = "1"
                    .Top       = 2
                    .Left      = 2
                    .Width     = 45
                    .Height    = 15
                    .BackStyle = 0
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "2"
                    .Top       = 19
                    .Left      = 2
                    .Width     = 45
                    .Height    = 15
                    .BackStyle = 0
                ENDWITH
            ENDWITH

            *-- chkPerdas (top=335,left=469,w=139,h=15)
            par_oCnt.AddObject("chkPerdas", "CheckBox")
            WITH par_oCnt.chkPerdas
                .Caption   = "Demonstrativo de Perdas"
                .Top       = 335
                .Left      = 469
                .Width     = 139
                .Height    = 15
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
            BINDEVENT(par_oCnt.chkPerdas, "Click", THIS, "chkPerdasClick")

            *-- SelTudo (top=371,left=191,w=40,h=40)
            par_oCnt.AddObject("SelTudo", "CommandButton")
            WITH par_oCnt.SelTudo
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .PicturePosition = 4
                .Top             = 371
                .Left            = 191
                .Width           = 40
                .Height          = 40
                .ToolTipText     = "Selecionar Todos"
                .Themes          = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            BINDEVENT(par_oCnt.SelTudo, "Click", THIS, "BtnSelTudoClick")

            *-- apaga (top=411,left=191,w=40,h=40)
            par_oCnt.AddObject("apaga", "CommandButton")
            WITH par_oCnt.apaga
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .PicturePosition = 4
                .Top             = 411
                .Left            = 191
                .Width           = 40
                .Height          = 40
                .ToolTipText     = "Desmarcar Todos"
                .Themes          = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            BINDEVENT(par_oCnt.apaga, "Click", THIS, "BtnApagaClick")

            *-- Visualizar (top=370,left=476,w=75,h=75)
            par_oCnt.AddObject("Visualizar", "CommandButton")
            WITH par_oCnt.Visualizar
                .Caption         = "Visualizar"
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .Top             = 370
                .Left            = 476
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .Themes          = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(par_oCnt.Visualizar, "Click", THIS, "BtnVisualizarBalancoClick")

            *-- Imprimir (top=370,left=551,w=75,h=75)
            par_oCnt.AddObject("Imprimir", "CommandButton")
            WITH par_oCnt.Imprimir
                .Caption         = "Imprimir"
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .Top             = 370
                .Left            = 551
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .Themes          = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(par_oCnt.Imprimir, "Click", THIS, "BtnImprimirBalancoClick")

            *-- Pesagem (top=294,left=892,w=75,h=75) - inicia oculto
            par_oCnt.AddObject("Pesagem", "CommandButton")
            WITH par_oCnt.Pesagem
                .Caption         = "Pesagem"
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .PicturePosition = 13
                .Top             = 294
                .Left            = 892
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .Themes          = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .F.
            ENDWITH
            BINDEVENT(par_oCnt.Pesagem, "Click", THIS, "BtnPesagemClick")

            *-- Label3: "Movimentacoes" (top=352,left=652,w=76,h=15)
            par_oCnt.AddObject("lbl_4c_Label3", "Label")
            WITH par_oCnt.lbl_4c_Label3
                .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
                .Top       = 352
                .Left      = 652
                .Width     = 76
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- grdMov (top=370,left=649,w=189,h=82,2 cols)
            *-- RecordSource/ColumnCount FORA de WITH (Problema 36)
            par_oCnt.AddObject("grdMov", "Grid")
            par_oCnt.grdMov.ColumnCount  = 2
            par_oCnt.grdMov.RecordSource = ""
            WITH par_oCnt.grdMov
                .Top         = 370
                .Left        = 649
                .Width       = 189
                .Height      = 82
                .GridLines   = 1
                .HeaderHeight = 20
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Visible     = .T.
            ENDWITH
            WITH par_oCnt.grdMov.Column1
                .Header1.Caption = ""
                .Width           = 20
                .Sparse          = .F.
            ENDWITH
            par_oCnt.grdMov.Column1.AddObject("Check1", "CheckBox")
            WITH par_oCnt.grdMov.Column1.Check1
                .Caption   = ""
                .Alignment = 0
                .ReadOnly  = .F.
                .Visible   = .T.
                .Top       = 9
                .Left      = 2
                .Height    = 17
                .Width     = 17
            ENDWITH
            par_oCnt.grdMov.Column1.CurrentControl = "Check1"
            WITH par_oCnt.grdMov.Column2
                .Header1.Caption = "Tipo Opera" + CHR(231) + CHR(227) + "o"
                .Width           = 160
            ENDWITH
            BINDEVENT(par_oCnt.grdMov.Column1.Check1, "KeyPress", THIS, "GrdMovCheck1KeyPress")

            *-- Pagina pageframe interno (top=5,left=462,w=510,h=275,3 paginas)
            par_oCnt.AddObject("Pagina", "PageFrame")
            WITH par_oCnt.Pagina
                .Top       = 5
                .Left      = 462
                .Width     = 510
                .Height    = 275
                .PageCount = 3
                .Tabs      = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH
            par_oCnt.Pagina.Pages(1).Caption = "Entradas"
            par_oCnt.Pagina.Pages(2).Caption = "Sa" + CHR(237) + "das"
            par_oCnt.Pagina.Pages(3).Caption = "Resumo"

            *-- GradeEntradas (Pagina.Page1 top=7,left=10,w=484,h=207,5 cols)
            par_oCnt.Pagina.Pages(1).AddObject("GradeEntradas", "Grid")
            par_oCnt.Pagina.Pages(1).GradeEntradas.ColumnCount  = 5
            par_oCnt.Pagina.Pages(1).GradeEntradas.RecordSource = "TmpOpera"
            loc_oGrd = par_oCnt.Pagina.Pages(1).GradeEntradas
            WITH loc_oGrd
                .Top          = 7
                .Left         = 10
                .Width        = 484
                .Height       = 207
                .ReadOnly     = .T.
                .GridLines    = 1
                .HeaderHeight = 20
                .FontName     = "Tahoma"
                .FontSize     = 8
                .Visible      = .T.
            ENDWITH
            WITH loc_oGrd.Column1
                .Header1.Caption = "Tipo Opera" + CHR(231) + CHR(227) + "o"
                .ControlSource   = "TmpOpera.TpOps"
                .Width           = 120
            ENDWITH
            WITH loc_oGrd.Column2
                .Header1.Caption = "Qtde"
                .ControlSource   = "TmpOpera.QtdeEnts"
                .Width           = 80
            ENDWITH
            WITH loc_oGrd.Column3
                .Header1.Caption = "F.Adm"
                .ControlSource   = "TmpOpera.PFalha"
                .Width           = 60
            ENDWITH
            WITH loc_oGrd.Column4
                .Header1.Caption = "Falha"
                .ControlSource   = "TmpOpera.Falha"
                .Width           = 60
            ENDWITH
            WITH loc_oGrd.Column5
                .Header1.Caption = "Base Falha"
                .ControlSource   = "TmpOpera.PesoBEnts"
                .Width           = 80
            ENDWITH
            BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeEntradasAfterRowColChange")
            BINDEVENT(par_oCnt.Pagina.Pages(1), "Activate", THIS, "PaginaResultadoPage1Activate")

            *-- Get_TpOperacao em Page1 (top=220,left=10,w=484,h=23)
            par_oCnt.Pagina.Pages(1).AddObject("Get_TpOperacao", "TextBox")
            WITH par_oCnt.Pagina.Pages(1).Get_TpOperacao
                .Value         = ""
                .Top           = 220
                .Left          = 10
                .Width         = 484
                .Height        = 23
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(240, 240, 240)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- GradeSaidas (Pagina.Page2 top=7,left=10,w=484,h=207,5 cols)
            par_oCnt.Pagina.Pages(2).AddObject("GradeSaidas", "Grid")
            par_oCnt.Pagina.Pages(2).GradeSaidas.ColumnCount  = 5
            par_oCnt.Pagina.Pages(2).GradeSaidas.RecordSource = "TmpOpera"
            loc_oGrd = par_oCnt.Pagina.Pages(2).GradeSaidas
            WITH loc_oGrd
                .Top          = 7
                .Left         = 10
                .Width        = 484
                .Height       = 207
                .ReadOnly     = .T.
                .GridLines    = 1
                .HeaderHeight = 20
                .FontName     = "Tahoma"
                .FontSize     = 8
                .Visible      = .T.
            ENDWITH
            WITH loc_oGrd.Column1
                .Header1.Caption = "Tipo Opera" + CHR(231) + CHR(227) + "o"
                .ControlSource   = "TmpOpera.TpOps"
                .Width           = 120
            ENDWITH
            WITH loc_oGrd.Column2
                .Header1.Caption = "Qtde"
                .ControlSource   = "TmpOpera.QtdeSais"
                .Width           = 80
            ENDWITH
            WITH loc_oGrd.Column3
                .Header1.Caption = "F.Adm"
                .ControlSource   = "TmpOpera.PFalha"
                .Width           = 60
            ENDWITH
            WITH loc_oGrd.Column4
                .Header1.Caption = "Falha"
                .ControlSource   = "TmpOpera.Falha"
                .Width           = 60
            ENDWITH
            WITH loc_oGrd.Column5
                .Header1.Caption = "Base Falha"
                .ControlSource   = "TmpOpera.PesoBSais"
                .Width           = 80
            ENDWITH
            BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeSaidasAfterRowColChange")
            BINDEVENT(par_oCnt.Pagina.Pages(2), "Activate", THIS, "PaginaResultadoPage2Activate")

            *-- Get_TpOperacao em Page2 (top=220,left=10,w=484,h=23)
            par_oCnt.Pagina.Pages(2).AddObject("Get_TpOperacao", "TextBox")
            WITH par_oCnt.Pagina.Pages(2).Get_TpOperacao
                .Value         = ""
                .Top           = 220
                .Left          = 10
                .Width         = 484
                .Height        = 23
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(240, 240, 240)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- GradeResumo (Pagina.Page3 top=7,left=10,w=484,h=241,4 cols)
            par_oCnt.Pagina.Pages(3).AddObject("GradeResumo", "Grid")
            par_oCnt.Pagina.Pages(3).GradeResumo.ColumnCount  = 4
            par_oCnt.Pagina.Pages(3).GradeResumo.RecordSource = "TmpResFas"
            loc_oGrd = par_oCnt.Pagina.Pages(3).GradeResumo
            WITH loc_oGrd
                .Top          = 7
                .Left         = 10
                .Width        = 484
                .Height       = 241
                .ReadOnly     = .T.
                .GridLines    = 1
                .HeaderHeight = 20
                .FontName     = "Tahoma"
                .FontSize     = 8
                .Visible      = .T.
            ENDWITH
            WITH loc_oGrd.Column1
                .Header1.Caption = "Fases"
                .ControlSource   = "TmpResFas.Fases"
                .Width           = 120
            ENDWITH
            WITH loc_oGrd.Column2
                .Header1.Caption = "Qtde"
                .ControlSource   = "TmpResFas.Qtds"
                .Width           = 120
            ENDWITH
            WITH loc_oGrd.Column3
                .Header1.Caption = "Pe" + CHR(231) + "as"
                .ControlSource   = "TmpResFas.QtdPcs"
                .Width           = 120
            ENDWITH
            WITH loc_oGrd.Column4
                .Header1.Caption = "Pesos"
                .ControlSource   = "TmpResFas.Pesos"
                .Width           = 120
            ENDWITH

            *-- cnt_4c_Conversao (top=292,left=192,w=248,h=66) - inicia oculto
            par_oCnt.AddObject("cnt_4c_Conversao", "Container")
            WITH par_oCnt.cnt_4c_Conversao
                .Top         = 292
                .Left        = 192
                .Width       = 248
                .Height      = 66
                .BackColor   = RGB(240, 240, 240)
                .BackStyle   = 1
                .Visible     = .F.
            ENDWITH
            par_oCnt.cnt_4c_Conversao.AddObject("lbl_4c_TituloConv", "Label")
            WITH par_oCnt.cnt_4c_Conversao.lbl_4c_TituloConv
                .Caption   = "Convers" + CHR(227) + "o"
                .Top       = 3
                .Left      = 13
                .Width     = 62
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
            par_oCnt.cnt_4c_Conversao.AddObject("lbl_4c_DataLabel", "Label")
            WITH par_oCnt.cnt_4c_Conversao.lbl_4c_DataLabel
                .Caption   = "Data:"
                .Top       = 33
                .Left      = 4
                .Width     = 30
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
            par_oCnt.cnt_4c_Conversao.AddObject("lbl_4c_MoedaLabel", "Label")
            WITH par_oCnt.cnt_4c_Conversao.lbl_4c_MoedaLabel
                .Caption   = "Moeda:"
                .Top       = 33
                .Left      = 122
                .Width     = 40
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
            par_oCnt.cnt_4c_Conversao.AddObject("txt_4c_DataCc", "TextBox")
            WITH par_oCnt.cnt_4c_Conversao.txt_4c_DataCc
                .Value         = DATE()
                .Top           = 28
                .Left          = 36
                .Width         = 80
                .Height        = 25
                .Format        = "K"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
            par_oCnt.cnt_4c_Conversao.AddObject("txt_4c_MOEDA", "TextBox")
            WITH par_oCnt.cnt_4c_Conversao.txt_4c_MOEDA
                .Value         = ""
                .Top           = 28
                .Left          = 166
                .Width         = 31
                .Height        = 25
                .MaxLength     = 10
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(255, 255, 255)
                .BorderStyle   = 1
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oCnt.cnt_4c_Conversao.txt_4c_MOEDA, "KeyPress", THIS, "MoedaLostFocus")
            par_oCnt.cnt_4c_Conversao.AddObject("cmd_4c_Cotacao", "CommandButton")
            WITH par_oCnt.cnt_4c_Conversao.cmd_4c_Cotacao
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_26.jpg"
                .PicturePosition = 4
                .Top             = 20
                .Left            = 202
                .Width           = 40
                .Height          = 40
                .ToolTipText     = "Cota" + CHR(231) + CHR(227) + "o"
                .Themes          = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            BINDEVENT(par_oCnt.cnt_4c_Conversao.cmd_4c_Cotacao, "Click", THIS, "CotacaoClick")

            *-- GradeMat (top=46,left=6,w=178,h=409,3 cols)
            *-- RecordSource/ColumnCount FORA de WITH (Problema 36)
            par_oCnt.AddObject("GradeMat", "Grid")
            par_oCnt.GradeMat.ColumnCount  = 3
            par_oCnt.GradeMat.RecordSource = "TmpResumo"
            loc_oGrd = par_oCnt.GradeMat
            WITH loc_oGrd
                .Top          = 46
                .Left         = 6
                .Width        = 178
                .Height       = 409
                .ReadOnly     = .F.
                .GridLines    = 1
                .HeaderHeight = 20
                .FontName     = "Tahoma"
                .FontSize     = 8
                .Visible      = .T.
            ENDWITH
            WITH loc_oGrd.Column1
                .Header1.Caption = "Material"
                .ControlSource   = "TmpResumo.CMats"
                .Width           = 110
                .ReadOnly        = .T.
            ENDWITH
            WITH loc_oGrd.Column2
                .Header1.Caption = ""
                .ControlSource   = "TmpResumo.Flag3"
                .Width           = 32
                .Sparse          = .F.
            ENDWITH
            loc_oGrd.Column2.AddObject("Check1", "CheckBox")
            WITH loc_oGrd.Column2.Check1
                .Caption   = ""
                .Alignment = 0
                .ReadOnly  = .F.
                .Visible   = .T.
                .Top       = 9
                .Left      = 2
                .Height    = 17
                .Width     = 22
            ENDWITH
            loc_oGrd.Column2.CurrentControl = "Check1"
            WITH loc_oGrd.Column3
                .Header1.Caption = "I"
                .ControlSource   = "TmpResumo.Flag2"
                .Width           = 32
                .Sparse          = .F.
                .ReadOnly        = .T.
            ENDWITH
            loc_oGrd.Column3.AddObject("Check1", "CheckBox")
            WITH loc_oGrd.Column3.Check1
                .Caption   = ""
                .Alignment = 0
                .ReadOnly  = .T.
                .Visible   = .T.
                .Top       = 9
                .Left      = 2
                .Height    = 17
                .Width     = 22
            ENDWITH
            loc_oGrd.Column3.CurrentControl = "Check1"
            BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeMatAfterRowColChange")
            BINDEVENT(loc_oGrd.Column2.Check1, "InteractiveChange", THIS, "GradeMatCheck1Change")

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarResultado:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormFea")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GrupoKeyPress / GrupoDblClick / AbrirLookupGrupo
    * Lookup de Grupo de Balanco (TmpGccr pre-carregado)
    *==========================================================================
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirLookupGrupo()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE GrupoDblClick()
        THIS.AbrirLookupGrupo()
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        TRY
            IF !USED("TmpGccr")
                MsgAviso("Dados de grupo n" + CHR(227) + "o carregados.")
            ELSE
                SELECT TmpGccr
                GO TOP
                SET ORDER TO BalCodigo
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "TmpGccr"
                    loc_oBusca.mAddColuna("BalCodigo", "", "Grupo")
                    loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND !EOF("TmpGccr")
                        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
                            loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(TmpGccr.BalCodigo)
                        ENDIF
                        IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
                            loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(TmpGccr.Descrs)
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                    loc_oBusca = .NULL.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirLookupGrupo:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * DGrupoKeyPress / DGrupoDblClick / AbrirLookupDGrupo
    * Lookup de Grupo por Descricao
    *==========================================================================
    PROCEDURE DGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirLookupDGrupo()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE DGrupoDblClick()
        THIS.AbrirLookupDGrupo()
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupDGrupo()
        LOCAL loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        TRY
            IF !USED("TmpGccr")
                MsgAviso("Dados de grupo n" + CHR(227) + "o carregados.")
            ELSE
                SELECT TmpGccr
                SET ORDER TO BalDescrs
                GO TOP
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "TmpGccr"
                    loc_oBusca.mAddColuna("BalCodigo", "", "Grupo")
                    loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND !EOF("TmpGccr")
                        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
                            loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(TmpGccr.BalCodigo)
                        ENDIF
                        IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
                            loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(TmpGccr.Descrs)
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                    loc_oBusca = .NULL.
                ENDIF
                SELECT TmpGccr
                SET ORDER TO BalCodigo
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirLookupDGrupo:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ContaKeyPress / ContaDblClick / AbrirLookupConta
    * Lookup de Conta de Balanco (TmpCli pre-carregado)
    *==========================================================================
    PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirLookupConta()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE ContaDblClick()
        THIS.AbrirLookupConta()
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupConta()
        LOCAL loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        TRY
            IF !USED("TmpCli")
                MsgAviso("Dados de conta n" + CHR(227) + "o carregados.")
            ELSE
                SELECT TmpCli
                GO TOP
                SET ORDER TO BalCodigo
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "TmpCli"
                    loc_oBusca.mAddColuna("BalCodigo", "", "Conta")
                    loc_oBusca.mAddColuna("BalNome", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND !EOF("TmpCli")
                        IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
                            loc_oPagina.txt_4c_Conta.Value = ALLTRIM(TmpCli.BalCodigo)
                        ENDIF
                        IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
                            loc_oPagina.txt_4c_DConta.Value = ALLTRIM(TmpCli.BalNome)
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                    loc_oBusca = .NULL.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirLookupConta:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * DContaKeyPress / DContaDblClick / AbrirLookupDConta
    * Lookup de Conta por Nome
    *==========================================================================
    PROCEDURE DContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirLookupDConta()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE DContaDblClick()
        THIS.AbrirLookupDConta()
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupDConta()
        LOCAL loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        TRY
            IF !USED("TmpCli")
                MsgAviso("Dados de conta n" + CHR(227) + "o carregados.")
            ELSE
                SELECT TmpCli
                SET ORDER TO BalNome
                GO TOP
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "TmpCli"
                    loc_oBusca.mAddColuna("BalCodigo", "", "Conta")
                    loc_oBusca.mAddColuna("BalNome", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND !EOF("TmpCli")
                        IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
                            loc_oPagina.txt_4c_Conta.Value = ALLTRIM(TmpCli.BalCodigo)
                        ENDIF
                        IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
                            loc_oPagina.txt_4c_DConta.Value = ALLTRIM(TmpCli.BalNome)
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                    loc_oBusca = .NULL.
                ENDIF
                SELECT TmpCli
                SET ORDER TO BalCodigo
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirLookupDConta:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * MoedaLostFocus - Lookup de Moeda (SigCdMoe) ao sair do campo
    * PUBLIC: BINDEVENT em txt_4c_MOEDA.LostFocus
    *==========================================================================
    PROCEDURE MoedaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cMoeda, loc_oBusca
        TRY
            loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.cnt_4c_Conversao
            loc_cMoeda = ALLTRIM(NVL(loc_oCnt.txt_4c_MOEDA.Value, ""))

            IF EMPTY(loc_cMoeda)
                loc_oCnt.txt_4c_MOEDA.Value = ""
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
                    "crListaMoe", "CMoes", loc_cMoeda, "Sele" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lSelecionou
                        loc_oBusca.mAddColuna("CMoes", "", "Moeda")
                        loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("crListaMoe") AND !EOF("crListaMoe")
                        loc_oCnt.txt_4c_MOEDA.Value = ALLTRIM(crListaMoe.CMoes)
                    ELSE
                        loc_oCnt.txt_4c_MOEDA.Value = ""
                    ENDIF
                    IF USED("crListaMoe")
                        USE IN crListaMoe
                    ENDIF
                    loc_oBusca.Release()
                    loc_oBusca = .NULL.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MoedaLostFocus:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CotacaoClick - Abre form de cotacao de moeda
    * PUBLIC: BINDEVENT em cmd_4c_Cotacao.Click
    *==========================================================================
    PROCEDURE CotacaoClick()
        TRY
            IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
                DO FORM SigOpCot WITH THISFORM, crSigCdFcx.Datas
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CotacaoClick:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeMatAfterRowColChange - Atualiza campos de resumo ao mudar linha do GradeMat
    * Equivale ao GradeMat.AfterRowColChange do legado
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE GradeMatAfterRowColChange(par_nColIndex)
        LOCAL loc_oCnt, loc_oPage1, loc_oPage2
        TRY
            IF USED("TmpResumo") AND !EOF("TmpResumo")
                loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
                SELECT TmpResumo

                loc_oCnt.Get_Saldo.Value     = TmpResumo.Saldoi
                loc_oCnt.Get_TEntradas.Value = TmpResumo.QtdeEnts
                loc_oCnt.Get_SEntradas.Value = TmpResumo.Saldoi + TmpResumo.QtdeEnts
                loc_oCnt.Get_SSaidas.Value   = TmpResumo.QtdeSais
                loc_oCnt.Get_Pesagem.Value   = TmpResumo.Pesagem
                loc_oCnt.Get_FReal.Value     = TmpResumo.FReal
                loc_oCnt.Get_FAdmitida.Value = TmpResumo.FAdmin
                loc_oCnt.Get_Saldof.Value    = TmpResumo.Saldof
                loc_oCnt.Get_Pfalha.Value    = TmpResumo.PfTrabs

                *-- Atualizar GradeEntradas com filtro do material corrente
                IF USED("TmpOpera")
                    SELECT TmpOpera
                    SET ORDER TO GrConMatTp
                    SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
                    GO TOP
                ENDIF

                IF PEMSTATUS(loc_oCnt, "Pagina", 5)
                    loc_oPage1 = loc_oCnt.Pagina.Pages(1)
                    IF PEMSTATUS(loc_oPage1, "GradeEntradas", 5)
                        loc_oPage1.GradeEntradas.Refresh()
                        loc_oPage1.GradeEntradas.AfterRowColChange(1)
                    ENDIF
                    loc_oPage2 = loc_oCnt.Pagina.Pages(2)
                    IF PEMSTATUS(loc_oPage2, "GradeSaidas", 5)
                        loc_oPage2.GradeSaidas.Refresh()
                    ENDIF

                    *-- Atualizar GradeResumo com filtro do material corrente
                    IF USED("TmpResFas")
                        SELECT TmpResFas
                        SET KEY TO TmpResumo.CMats
                        GO TOP
                    ENDIF
                    IF PEMSTATUS(loc_oCnt.Pagina.Pages(3), "GradeResumo", 5)
                        loc_oCnt.Pagina.Pages(3).GradeResumo.Refresh()
                    ENDIF
                ENDIF

                *-- Atualizar datas do periodo no cabecalho do resultado
                IF PEMSTATUS(loc_oCnt, "Get_Datai", 5)
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo, "txt_4c_DtInicial", 5)
                        loc_oCnt.Get_Datai.Value = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtInicial.Value
                        loc_oCnt.Get_Dataf.Value = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtFinal.Value
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em GradeMatAfterRowColChange:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeEntradasAfterRowColChange - Atualiza Get_TpOperacao na Page1
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE GradeEntradasAfterRowColChange(par_nColIndex)
        LOCAL loc_oPage1
        TRY
            IF USED("TmpOpera") AND !EOF("TmpOpera")
                loc_oPage1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(1)
                IF PEMSTATUS(loc_oPage1, "Get_TpOperacao", 5)
                    loc_oPage1.Get_TpOperacao.Value = ALLTRIM(NVL(TmpOpera.TpOps, ""))
                    loc_oPage1.Get_TpOperacao.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em GradeEntradasAfterRowColChange:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeSaidasAfterRowColChange - Atualiza Get_TpOperacao na Page2
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE GradeSaidasAfterRowColChange(par_nColIndex)
        LOCAL loc_oPage2
        TRY
            IF USED("TmpOpera") AND !EOF("TmpOpera")
                loc_oPage2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(2)
                IF PEMSTATUS(loc_oPage2, "Get_TpOperacao", 5)
                    loc_oPage2.Get_TpOperacao.Value = ALLTRIM(NVL(TmpOpera.TpOps, ""))
                    loc_oPage2.Get_TpOperacao.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em GradeSaidasAfterRowColChange:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeMatCheck1Change - Valida Check1 (Flag3) ao mudar no GradeMat
    * Impedimentos: conta sem acerto (Flag2=.F.) ou saldo zero
    * PUBLIC: BINDEVENT exige metodo publico
    *==========================================================================
    PROCEDURE GradeMatCheck1Change()
        LOCAL loc_oCnt
        TRY
            IF USED("TmpResumo") AND !EOF("TmpResumo")
                loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
                IF !TmpResumo.Flag2
                    MsgAviso("Esta Conta N" + CHR(227) + "o Permite Acerto de Balan" + CHR(231) + "o...")
                    SELECT TmpResumo
                    REPLACE Flag3 WITH .F.
                    IF PEMSTATUS(loc_oCnt, "GradeMat", 5)
                        loc_oCnt.GradeMat.Refresh()
                    ENDIF
                ELSE
                    IF TmpResumo.Saldof = 0 AND TmpResumo.Flag3
                        MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Diferen" + CHR(231) + CHR(97) + "  Para Acerto...")
                        SELECT TmpResumo
                        REPLACE Flag3 WITH .F.
                        IF PEMSTATUS(loc_oCnt, "GradeMat", 5)
                            loc_oCnt.GradeMat.Refresh()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em GradeMatCheck1Change:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * chkPerdasClick - Desabilita outros checkboxes quando Perdas marcado
    * PUBLIC: BINDEVENT exige metodo publico
    *==========================================================================
    PROCEDURE chkPerdasClick()
        LOCAL loc_oCnt
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
            IF loc_oCnt.chkPerdas.Value = 1
                loc_oCnt.Resumido.Value  = 0
                loc_oCnt.Historico.Value = 0
                loc_oCnt.chkServ.Value   = 0
                loc_oCnt.Analitico.Value = 0
                loc_oCnt.porMov.Value    = 0
                loc_oCnt.MovAgru.Value   = 0
                loc_oCnt.porenv.Value    = 0
                loc_oCnt.pormat.Value    = 0
                loc_oCnt.MovLote.Value   = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em chkPerdasClick:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnPesagemClick - Ativa modo de entrada de pesagem fisica
    * PUBLIC: BINDEVENT exige metodo publico
    *==========================================================================
    PROCEDURE BtnPesagemClick()
        LOCAL loc_oCnt
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
            THIS.this_lEntraPeso = .T.
            loc_oCnt.Get_Pesagem.ReadOnly = .F.
            loc_oCnt.Get_Pesagem.SetFocus()
        CATCH TO loc_oErro
            MsgErro("Erro em BtnPesagemClick:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PesagemLostFocus - Recalcula saldos ao informar pesagem fisica
    * Disparado por Valid do Get_Pesagem (equivalente ao legado)
    * PUBLIC: BINDEVENT exige metodo publico
    *==========================================================================
    PROCEDURE PesagemLostFocus()
        LOCAL loc_oCnt, loc_nPesagem
        TRY
            THIS.this_lEntraPeso = .F.
            IF USED("TmpResumo") AND !EOF("TmpResumo")
                loc_oCnt    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
                loc_nPesagem = NVL(loc_oCnt.Get_Pesagem.Value, 0)
                SELECT TmpResumo
                REPLACE Pesagem WITH loc_nPesagem, ;
                        Saldof  WITH TmpResumo.Saldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - loc_nPesagem - TmpResumo.FAdmin, ;
                        FReal   WITH TmpResumo.Saldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - loc_nPesagem
                loc_oCnt.Get_Saldo.Value     = TmpResumo.Saldoi
                loc_oCnt.Get_TEntradas.Value = TmpResumo.QtdeEnts
                loc_oCnt.Get_SEntradas.Value = TmpResumo.Saldoi + TmpResumo.QtdeEnts
                loc_oCnt.Get_SSaidas.Value   = TmpResumo.QtdeSais
                loc_oCnt.Get_Pesagem.Value   = TmpResumo.Pesagem
                loc_oCnt.Get_FReal.Value     = TmpResumo.FReal
                loc_oCnt.Get_FAdmitida.Value = TmpResumo.FAdmin
                loc_oCnt.Get_Saldof.Value    = TmpResumo.Saldof
                loc_oCnt.Get_Pesagem.ReadOnly = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em PesagemLostFocus:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSelTudoClick - Marca todos os materiais (Flag3=.T.) no GradeMat
    * PUBLIC: BINDEVENT exige metodo publico
    *==========================================================================
    PROCEDURE BtnSelTudoClick()
        TRY
            IF USED("TmpResumo")
                SELECT TmpResumo
                REPLACE ALL Flag3 WITH .T.
                GO TOP
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado, "GradeMat", 5)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.GradeMat.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnSelTudoClick:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnApagaClick - Desmarca todos os materiais (Flag3=.F.) no GradeMat
    * PUBLIC: BINDEVENT exige metodo publico
    *==========================================================================
    PROCEDURE BtnApagaClick()
        TRY
            IF USED("TmpResumo")
                SELECT TmpResumo
                REPLACE ALL Flag3 WITH .F.
                GO TOP
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado, "GradeMat", 5)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.GradeMat.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnApagaClick:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdMovCheck1KeyPress - Alterna nMarcas com Enter/Espaco no grdMov
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE GrdMovCheck1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            IF INLIST(m.par_nKeyCode, 13, 32)
                IF USED("crOpp") AND !EOF("crOpp")
                    SELECT crOpp
                    REPLACE nMarcas WITH IIF(crOpp.nMarcas = 0, 1, 0)
                    KEYBOARD "{DNARROW}"
                    KEYBOARD "{UPARROW}"
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado, "grdMov", 5)
                        THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.grdMov.Refresh()
                    ENDIF
                ENDIF
                NODEFAULT
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em GrdMovCheck1KeyPress:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PaginaResultadoPage1Activate - Ativa aba Entradas (seta ordem TmpOpera)
    * PUBLIC: BINDEVENT em Pagina.Pages(1).Activate
    *==========================================================================
    PROCEDURE PaginaResultadoPage1Activate()
        LOCAL loc_oPage1
        TRY
            IF USED("TmpOpera") AND USED("TmpResumo") AND !EOF("TmpResumo")
                SELECT TmpOpera
                SET ORDER TO GrConMatTp
                SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
                GO TOP
                loc_oPage1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(1)
                IF PEMSTATUS(loc_oPage1, "GradeEntradas", 5)
                    loc_oPage1.GradeEntradas.Refresh()
                    loc_oPage1.GradeEntradas.AfterRowColChange(1)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em PaginaResultadoPage1Activate:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PaginaResultadoPage2Activate - Ativa aba Saidas (seta ordem TmpOpera)
    * PUBLIC: BINDEVENT em Pagina.Pages(2).Activate
    *==========================================================================
    PROCEDURE PaginaResultadoPage2Activate()
        LOCAL loc_oPage2
        TRY
            IF USED("TmpOpera") AND USED("TmpResumo") AND !EOF("TmpResumo")
                SELECT TmpOpera
                SET ORDER TO GrConMatTp
                SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
                GO TOP
                loc_oPage2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(2)
                IF PEMSTATUS(loc_oPage2, "GradeSaidas", 5)
                    loc_oPage2.GradeSaidas.Refresh()
                    loc_oPage2.GradeSaidas.AfterRowColChange(1)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em PaginaResultadoPage2Activate:" + CHR(13) + loc_oErro.Message, "FormFea")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarBalancoClick - Preview do relatorio de balanco
    * PUBLIC: BINDEVENT exige metodo publico
    *==========================================================================
    PROCEDURE BtnVisualizarBalancoClick()
        THIS.ImprimirBalanco("PREVIEW")
    ENDPROC

    *==========================================================================
    * BtnImprimirBalancoClick - Impressao do relatorio de balanco
    * PUBLIC: BINDEVENT exige metodo publico
    *==========================================================================
    PROCEDURE BtnImprimirBalancoClick()
        THIS.ImprimirBalanco("PRINTER_PROMPT")
    ENDPROC

    *==========================================================================
    * ImprimirBalanco - Executa o relatorio de Balanco de Estoque (SIGCDFEA.frx)
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    * Cria TmpCabec, chama REPORT FORM com isolamento de locale (Pattern #117)
    *==========================================================================
    PROTECTED FUNCTION ImprimirBalanco(par_cModo)
        LOCAL loc_lResultado, loc_cFRX, loc_cSubTitulo, loc_cEmpresa
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig, loc_oCnt
        loc_lResultado = .F.

        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado

            *-- Montar cursor TmpCabec para o FRX
            IF USED("TmpCabec")
                USE IN TmpCabec
            ENDIF
            CREATE CURSOR TmpCabec (Titulo C(100), SubTitulo C(254), Empresa C(80))

            loc_cSubTitulo = ""
            IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
                IF USED("TmpCli")
                    =SEEK(ALLTRIM(crSigCdFcx.Contas), "TmpCli", "BalCodigo")
                ENDIF
                loc_cSubTitulo = " Conta : " + ALLTRIM(NVL(crSigCdFcx.Grupos, "")) + ;
                                 " / " + ALLTRIM(NVL(crSigCdFcx.Contas, ""))
                IF USED("TmpCli") AND !EOF("TmpCli")
                    loc_cSubTitulo = loc_cSubTitulo + " [ " + ALLTRIM(TmpCli.RClis) + " ] "
                ENDIF
                loc_cSubTitulo = loc_cSubTitulo + CHR(13) + CHR(10) + ;
                                 "Per" + CHR(237) + "odo : " + ;
                                 NVL(DTOC(crSigCdFcx.Datais), "") + " a " + ;
                                 NVL(DTOC(crSigCdFcx.Datas), "")
            ENDIF

            loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cEmpresa, ""))
            INSERT INTO TmpCabec (Titulo, SubTitulo, Empresa) ;
                VALUES ("Balan" + CHR(231) + "o de Estoque", loc_cSubTitulo, loc_cEmpresa)

            *-- Verificar arquivo FRX
            loc_cFRX = FULLPATH(gc_4c_CaminhoReports + "SIGCDFEA.frx")
            IF !FILE(loc_cFRX)
                MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                    CHR(13) + loc_cFRX + CHR(13) + CHR(13) + ;
                    "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            ELSE
                IF !USED("TmpResumo") OR RECCOUNT("TmpResumo") = 0
                    MsgAviso("Nenhum registro encontrado para impress" + CHR(227) + "o.")
                ELSE
                    *-- Isolar locale para FRX legado (Pattern #117)
                    loc_cPointOrig    = SET("POINT")
                    loc_cSepOrig      = SET("SEPARATOR")
                    loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
                    SET POINT TO "."
                    SET SEPARATOR TO ","
                    SET REPORTBEHAVIOR 80

                    DO CASE
                        CASE par_cModo == "PREVIEW"
                            REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
                        CASE par_cModo == "PRINTER_PROMPT"
                            REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
                        CASE par_cModo == "PRINTER"
                            REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
                    ENDCASE

                    SET POINT TO (loc_cPointOrig)
                    SET SEPARATOR TO (loc_cSepOrig)
                    SET REPORTBEHAVIOR (loc_nBehaviorOrig)

                    *-- Restaurar menu apos REPORT FORM PREVIEW (Erro63)
                    TRY
                        SET SYSMENU TO DEFAULT
                        RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
                        CriarMenuPrincipal()
                    CATCH
                    ENDTRY

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ImprimirBalanco:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormFea")
        ENDTRY

        IF USED("TmpCabec")
            USE IN TmpCabec
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * Destroy - Liberacao de recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        *-- Fechar cursores temporarios locais (criados pelo processamento)
        LOCAL loc_aCursores(30), loc_i
        loc_aCursores(1)  = "TmpResumo"
        loc_aCursores(2)  = "TmpOpera"
        loc_aCursores(3)  = "TmpConta"
        loc_aCursores(4)  = "TmpGccr"
        loc_aCursores(5)  = "TmpCli"
        loc_aCursores(6)  = "TmpPro"
        loc_aCursores(7)  = "TmpCot"
        loc_aCursores(8)  = "TmpHist"
        loc_aCursores(9)  = "TmpPrz"
        loc_aCursores(10) = "TmpResFas"
        loc_aCursores(11) = "CrSigCdFea"
        loc_aCursores(12) = "cursor_4c_Dados"
        loc_aCursores(13) = "cursor_4c_BuscaGrupo"
        loc_aCursores(14) = "cursor_4c_BuscaConta"
        loc_aCursores(15) = "crSigMvCab"
        loc_aCursores(16) = "crSigMvItn"
        loc_aCursores(17) = "crSigCdFcx"
        loc_aCursores(18) = "crSigCdPac"
        loc_aCursores(19) = "crSigCdPam"
        loc_aCursores(20) = "crSigOpOpt"
        loc_aCursores(21) = "LocalOpp"
        loc_aCursores(22) = "crSigCdOpe"
        loc_aCursores(23) = "TmpGccr"
        loc_aCursores(24) = "LocalGru"
        loc_aCursores(25) = "LocalGgrp"
        loc_aCursores(26) = "CrOpp"
        loc_aCursores(27) = "LocalEmp"
        loc_aCursores(28) = "crDtUBal"
        loc_aCursores(29) = "CrUltBal"
        loc_aCursores(30) = "CrSaldoI"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\FeaBO.prg):
*==============================================================================
* FeaBO.prg - Business Object: Fechamento de Estoque (Balanco)
* Tabela principal: SigCdFcx
* Formulario origem: SIGCDFEA.SCX (frmcadastro)
* Criado: 2026-08-02
*
* Schema SigCdFcx:
*   emps char(3), codigos numeric(6,0), grupos char(10), contas char(10),
*   datais datetime, datas datetime, cpros char(14), entradas numeric(11,3),
*   fadmins numeric(11,3), freals numeric(11,3), pesagems numeric(11,3),
*   saidas numeric(11,3), saldos numeric(11,3), usuars char(10),
*   cidchaves char(20) PK
*==============================================================================

DEFINE CLASS FeaBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdFcx (schema exato)
    *--------------------------------------------------------------------------
    this_cEmps      = ""   && emps char(3) - empresa
    this_nCodigos   = 0    && codigos numeric(6,0) - codigo negocio
    this_cGrupos    = ""   && grupos char(10)
    this_cContas    = ""   && contas char(10)
    this_dDatais    = {}   && datais datetime - data inicial
    this_dDatas     = {}   && datas datetime - data final
    this_cCpros     = ""   && cpros char(14) - codigo produto
    this_nEntradas  = 0    && entradas numeric(11,3)
    this_nFadmins   = 0    && fadmins numeric(11,3) - falha admitida
    this_nFreals    = 0    && freals numeric(11,3) - falha real
    this_nPesagems  = 0    && pesagems numeric(11,3)
    this_nSaidas    = 0    && saidas numeric(11,3)
    this_nSaldos    = 0    && saldos numeric(11,3)
    this_cUsuars    = ""   && usuars char(10)
    this_cCidChaves = ""   && cidchaves char(20) - PK

    *--------------------------------------------------------------------------
    * Propriedades de descricao (lookup - nao armazenadas na tabela)
    *--------------------------------------------------------------------------
    this_cDGrupos   = ""   && descricao do grupo (TmpGccr.Descrs)
    this_cDContas   = ""   && descricao da conta (TmpCli.RClis)

    *--------------------------------------------------------------------------
    * Propriedades de filtro de periodo (Page1/Lista)
    *--------------------------------------------------------------------------
    this_cEmpFiltro  = ""  && empresa do filtro (Get_cd_empresa)
    this_dDtInicial  = {}  && data inicial do filtro
    this_dDtFinal    = {}  && data final do filtro

    *--------------------------------------------------------------------------
    * Propriedades de estado do processo
    *--------------------------------------------------------------------------
    this_nLote      = 0    && lote de processamento (getlote - numeric 6)
    this_lFechamento = .T. && registro esta aberto para processamento
    this_lAcInserir  = .F. && acao de insercao ativa
    this_lEntraPeso  = .F. && entrada de peso via balanca

    *--------------------------------------------------------------------------
    * Propriedades de resultado (populadas apos ProcessarBalanco via TmpResumo)
    *--------------------------------------------------------------------------
    this_nSaldoi    = 0    && saldo inicial (TmpResumo.Saldoi)
    this_nQtdeEnts  = 0    && quantidade de entradas (TmpResumo.QtdeEnts)
    this_nSEntradas = 0    && saldo + entradas (calculado: Saldoi + QtdeEnts)
    this_nQtdeSais  = 0    && quantidade de saidas (TmpResumo.QtdeSais)
    this_nPesagem   = 0    && pesagem fisica (TmpResumo.Pesagem)
    this_nFReal     = 0    && falha real (TmpResumo.FReal)
    this_nFAdmin    = 0    && falha admitida (TmpResumo.FAdmin)
    this_nSaldof    = 0    && saldo final (TmpResumo.Saldof)
    this_nPfTrabs   = 0    && percentual falha/trabalhado (TmpResumo.PfTrabs)

    *--------------------------------------------------------------------------
    * Propriedades de filtros de impressao (checkboxes/opcoes do Resultado)
    *--------------------------------------------------------------------------
    this_lPerdas    = .F.  && demonstrativo de perdas (chkPerdas)
    this_lHistorico = .F.  && historico (Historico)
    this_lResumido  = .T.  && resumido - default ativo (Resumido)
    this_lAnalitico = .F.  && analitico (Analitico)
    this_lServicos  = .F.  && servicos (chkServ)
    this_lPorMov    = .F.  && por movimentacao (porMov)
    this_lPorEnv    = .F.  && por envio (porenv)
    this_lPorMat    = .F.  && por material (pormat)
    this_lMovAgru   = .F.  && movimentacao agrupada (MovAgru)
    this_lMovLote   = .F.  && movimentacao por lote (MovLote)
    this_nOrdem     = 1    && opcao de ordem do relatorio (op_ordem)

    *--------------------------------------------------------------------------
    * Propriedades de conversao de moeda (Cnt_Conversao)
    *--------------------------------------------------------------------------
    this_cMoeda     = ""   && codigo da moeda (Get_MOEDA / SigCdMoe.CMoes)
    this_dDataCc    = {}   && data de conversao (Get_DataCc)

    *--------------------------------------------------------------------------
    * Propriedades de tipo de operacao selecionada (AfterRowColChange GradeMat)
    *--------------------------------------------------------------------------
    this_cTpOperacao = ""  && tipo de operacao do grid (TmpOpera.TpOps)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFcx"
            THIS.this_cCampoChave = "CidChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SigCdFcx filtrados por empresa e periodo
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cDtF
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Codigos, a.Grupos, a.Contas," + ;
                       " a.Datais, a.Datas, a.Cpros, a.Entradas," + ;
                       " a.Fadmins, a.Freals, a.Pesagems, a.Saidas," + ;
                       " a.Saldos, a.Usuars, a.CidChaves" + ;
                       " FROM SigCdFcx a" + ;
                       " WHERE a.Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmpFiltro))

            IF VARTYPE(THIS.this_dDtInicial) = "D" AND !EMPTY(THIS.this_dDtInicial)
                loc_cSQL = loc_cSQL + " AND a.Datas >= " + FormatarDataSQL(THIS.this_dDtInicial)
            ENDIF

            IF VARTYPE(THIS.this_dDtFinal) = "D" AND !EMPTY(THIS.this_dDtFinal)
                loc_cDtF = FormatarDataSQL(THIS.this_dDtFinal)
                loc_cDtF = LEFT(loc_cDtF, LEN(loc_cDtF) - 1) + " 23:59:59'"
                loc_cSQL = loc_cSQL + " AND a.Datas <= " + loc_cDtF
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Grupos, a.Contas, a.Datas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao listar Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por CidChaves (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Codigos, a.Grupos, a.Contas," + ;
                       " a.Datais, a.Datas, a.Cpros, a.Entradas," + ;
                       " a.Fadmins, a.Freals, a.Pesagems, a.Saidas," + ;
                       " a.Saldos, a.Usuars, a.CidChaves" + ;
                       " FROM SigCdFcx a" + ;
                       " WHERE a.CidChaves = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps      = TratarNulo(Emps,      "C")
                THIS.this_nCodigos   = TratarNulo(Codigos,   "N")
                THIS.this_cGrupos    = TratarNulo(Grupos,    "C")
                THIS.this_cContas    = TratarNulo(Contas,    "C")
                THIS.this_dDatais    = IIF(ISNULL(Datais),   {}, TTOD(Datais))
                THIS.this_dDatas     = IIF(ISNULL(Datas),    {}, TTOD(Datas))
                THIS.this_cCpros     = TratarNulo(Cpros,     "C")
                THIS.this_nEntradas  = TratarNulo(Entradas,  "N")
                THIS.this_nFadmins   = TratarNulo(Fadmins,   "N")
                THIS.this_nFreals    = TratarNulo(Freals,    "N")
                THIS.this_nPesagems  = TratarNulo(Pesagems,  "N")
                THIS.this_nSaidas    = TratarNulo(Saidas,    "N")
                THIS.this_nSaldos    = TratarNulo(Saldos,    "N")
                THIS.this_cUsuars    = TratarNulo(Usuars,    "C")
                THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigCdFcx (chamado pelo Salvar do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            *-- Gerar chave primaria unica via SQL Server
            SQLEXEC(gnConnHandle, "SELECT REPLACE(CAST(NEWID() AS VARCHAR(36)),'-','') AS chave", "cursor_4c_ChaveNova")
            IF USED("cursor_4c_ChaveNova") AND RECCOUNT("cursor_4c_ChaveNova") > 0
                SELECT cursor_4c_ChaveNova
                THIS.this_cCidChaves = LEFT(ALLTRIM(chave), 20)
                USE IN cursor_4c_ChaveNova
            ELSE
                IF USED("cursor_4c_ChaveNova")
                    USE IN cursor_4c_ChaveNova
                ENDIF
                THIS.this_cCidChaves = LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa) + "FCX" + TRANSFORM(SECONDS()), 20)
            ENDIF

            THIS.this_cEmps   = LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "INSERT INTO SigCdFcx" + ;
                       " (Emps, Codigos, Grupos, Contas, Datais, Datas," + ;
                       "  Cpros, Entradas, Fadmins, Freals, Pesagems," + ;
                       "  Saidas, Saldos, Usuars, CidChaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cContas, 10)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatais) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEntradas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFadmins) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFreals) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesagems) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSaidas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSaldos) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCidChaves, 20)) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdFcx (chamado pelo Salvar do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "UPDATE SigCdFcx SET" + ;
                       " Grupos   = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
                       " Contas   = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
                       " Datais   = " + FormatarDataSQL(THIS.this_dDatais) + "," + ;
                       " Datas    = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " Cpros    = " + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + "," + ;
                       " Entradas = " + FormatarNumeroSQL(THIS.this_nEntradas) + "," + ;
                       " Fadmins  = " + FormatarNumeroSQL(THIS.this_nFadmins) + "," + ;
                       " Freals   = " + FormatarNumeroSQL(THIS.this_nFreals) + "," + ;
                       " Pesagems = " + FormatarNumeroSQL(THIS.this_nPesagems) + "," + ;
                       " Saidas   = " + FormatarNumeroSQL(THIS.this_nSaidas) + "," + ;
                       " Saldos   = " + FormatarNumeroSQL(THIS.this_nSaldos) + "," + ;
                       " Usuars   = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ;
                       " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdFcx e movimentos relacionados
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cEdns
        loc_lResultado = .F.

        TRY
            *-- Chave composta usada em SigMvCab/SigMvItn
            loc_cEdns = LEFT(ALLTRIM(THIS.this_cEmps), 3) + PADL(TRANSFORM(THIS.this_nCodigos), 6, "0")

            *-- Excluir itens de movimentos (SigMvItn)
            loc_cSQL    = "DELETE FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_cEdns)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Excluir cabecalho de movimentos (SigMvCab)
                loc_cSQL    = "DELETE FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEdns)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    *-- Excluir registro principal (SigCdFcx)
                    loc_cSQL    = "DELETE FROM SigCdFcx WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResult >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao excluir Fechamento de Estoque (SigCdFcx):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir cabecalho de movimentos (SigMvCab):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir itens de movimentos (SigMvItn):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * PreencherFiltro - Define parametros de filtro empresa + periodo
    *--------------------------------------------------------------------------
    PROCEDURE PreencherFiltro(par_cEmp, par_dDtI, par_dDtF)
        THIS.this_cEmpFiltro = ALLTRIM(par_cEmp)
        THIS.this_dDtInicial = par_dDtI
        THIS.this_dDtFinal   = par_dDtF
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Carrega cursor de grupos de conta corrente para lookup
    *--------------------------------------------------------------------------
    FUNCTION BuscarGrupos(par_cValor)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT g.Codigos, g.Descrs FROM SigCdGcr g"

            IF VARTYPE(par_cValor) = "C" AND !EMPTY(ALLTRIM(par_cValor))
                loc_cSQL = loc_cSQL + " WHERE g.Codigos LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY g.Descrs"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaGrupo")
                TABLEREVERT(.T., "cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
            loc_lResultado = (loc_nResult >= 0)
            IF !loc_lResultado
                MsgErro("Erro ao buscar grupos de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarContas - Carrega cursor de contas/clientes para lookup (SigCdCli)
    *--------------------------------------------------------------------------
    FUNCTION BuscarContas(par_cGrupo, par_cValor)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT c.Iclis, c.RClis, c.Inativas FROM SigCdCli c ORDER BY c.RClis"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaConta")
                TABLEREVERT(.T., "cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
            loc_lResultado = (loc_nResult >= 0)
            IF !loc_lResultado
                MsgErro("Erro ao buscar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

