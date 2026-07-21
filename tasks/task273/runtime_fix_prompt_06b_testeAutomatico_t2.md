# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-15 16:16:46] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-15 16:16:46] [INFO] Config FPW: (nao fornecido)
[2026-07-15 16:16:46] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 16:16:46] [INFO] Timeout: 300 segundos
[2026-07-15 16:16:46] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_r3bl3ksm.prg
[2026-07-15 16:16:46] [INFO] Conteudo do wrapper:
[2026-07-15 16:16:46] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrCtr', 'C:\4c\tasks\task273', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCtr', 'C:\4c\tasks\task273', 'CRUD'
QUIT

[2026-07-15 16:16:46] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_r3bl3ksm.prg
[2026-07-15 16:16:46] [INFO] VFP output esperado em: C:\4c\tasks\task273\vfp_output.txt
[2026-07-15 16:16:46] [INFO] Executando Visual FoxPro 9...
[2026-07-15 16:16:46] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_r3bl3ksm.prg
[2026-07-15 16:16:46] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_r3bl3ksm.prg
[2026-07-15 16:16:46] [INFO] Timeout configurado: 300 segundos
[2026-07-15 16:17:06] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 16:17:06] [INFO] VFP9 finalizado em 20.0618943 segundos
[2026-07-15 16:17:06] [INFO] Exit Code: 
[2026-07-15 16:17:06] [INFO] 
[2026-07-15 16:17:06] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 16:17:06] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_r3bl3ksm.prg
[2026-07-15 16:17:06] [INFO] 
[2026-07-15 16:17:06] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 16:17:06] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 16:17:06] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 16:17:06] [INFO] * Parameters: 'FormSigPrCtr', 'C:\4c\tasks\task273', 'CRUD'
[2026-07-15 16:17:06] [INFO] 
[2026-07-15 16:17:06] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 16:17:06] [INFO] SET SAFETY OFF
[2026-07-15 16:17:06] [INFO] SET RESOURCE OFF
[2026-07-15 16:17:06] [INFO] SET TALK OFF
[2026-07-15 16:17:06] [INFO] SET NOTIFY OFF
[2026-07-15 16:17:06] [INFO] SYS(2335, 0)
[2026-07-15 16:17:06] [INFO] 
[2026-07-15 16:17:06] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCtr', 'C:\4c\tasks\task273', 'CRUD'
[2026-07-15 16:17:06] [INFO] QUIT
[2026-07-15 16:17:06] [INFO] 
[2026-07-15 16:17:06] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 16:17:06] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-15 16:19:18] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-15 16:19:18] [INFO] Config FPW: (nao fornecido)
[2026-07-15 16:19:18] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 16:19:18] [INFO] Timeout: 300 segundos
[2026-07-15 16:19:18] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_upwadhle.prg
[2026-07-15 16:19:18] [INFO] Conteudo do wrapper:
[2026-07-15 16:19:18] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrCtr', 'C:\4c\tasks\task273', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCtr', 'C:\4c\tasks\task273', 'CRUD'
QUIT

[2026-07-15 16:19:18] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_upwadhle.prg
[2026-07-15 16:19:18] [INFO] VFP output esperado em: C:\4c\tasks\task273\vfp_output.txt
[2026-07-15 16:19:18] [INFO] Executando Visual FoxPro 9...
[2026-07-15 16:19:18] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_upwadhle.prg
[2026-07-15 16:19:18] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_upwadhle.prg
[2026-07-15 16:19:18] [INFO] Timeout configurado: 300 segundos
[2026-07-15 16:19:42] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 16:19:42] [INFO] VFP9 finalizado em 23.3611595 segundos
[2026-07-15 16:19:42] [INFO] Exit Code: 
[2026-07-15 16:19:42] [INFO] 
[2026-07-15 16:19:42] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 16:19:42] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_upwadhle.prg
[2026-07-15 16:19:42] [INFO] 
[2026-07-15 16:19:42] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 16:19:42] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 16:19:42] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 16:19:42] [INFO] * Parameters: 'FormSigPrCtr', 'C:\4c\tasks\task273', 'CRUD'
[2026-07-15 16:19:42] [INFO] 
[2026-07-15 16:19:42] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 16:19:42] [INFO] SET SAFETY OFF
[2026-07-15 16:19:42] [INFO] SET RESOURCE OFF
[2026-07-15 16:19:42] [INFO] SET TALK OFF
[2026-07-15 16:19:42] [INFO] SET NOTIFY OFF
[2026-07-15 16:19:42] [INFO] SYS(2335, 0)
[2026-07-15 16:19:42] [INFO] 
[2026-07-15 16:19:42] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrCtr', 'C:\4c\tasks\task273', 'CRUD'
[2026-07-15 16:19:42] [INFO] QUIT
[2026-07-15 16:19:42] [INFO] 
[2026-07-15 16:19:42] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 16:19:42] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPrCtr",
  "timestamp": "20260715161942",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": false,
      "erro": "Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)",
      "detalhes": ""
    },
    {
      "nome": "ModoIncluir",
      "passou": true,
      "erro": "",
      "detalhes": "Page2 ativada com sucesso"
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
      "detalhes": "BtnIncluirClick navegou para Page2 | BtnCancelarClick retornou para Page1"
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
      "detalhes": "AbrirLookup: 4 (ABRIRLOOKUPCONTA, ABRIRLOOKUPDCONTA, ABRIRLOOKUPGRUPO, ABRIRLOOKUPMOEDA) | KeyPress handlers: 5 (KEYPRESS, TXTCONTAKEYPRESS, TXTDCONTAKEYPRESS, TXTGRUPOKEYPRESS, TXTMOEDAKEYPRESS)"
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
    "passou": 7,
    "falhou": 2,
    "percentual": 78
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg):
*==============================================================================
* FormSigPrCtr.prg - Controle de Movimentacoes por XML
* Origem legada: SIGPRCTR.SCX (frmcadastro - CRUD com PageFrame aninhado)
* Herda de: FormBase
* Fase 3/8: Estrutura base - PageFrame, containers principais, metodos Init/Destroy
*
* Estrutura:
*   pgf_4c_Paginas (outer PF, Top=-29)
*     Page1 (Lista) : filtro datas + grade lotes + botoes CRUD
*     Page2 (Dados) : pgf_4c_Dados (inner PF)
*       pgf_4c_Dados.Page1 : campos do lote + grdEstoque + botoes operacionais
*       pgf_4c_Dados.Page2 : grdDisponivel + grdItemXml + campos detalhe produto
*==============================================================================

DEFINE CLASS FormSigPrCtr AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity; original: 1200x620)
    Height      = 620
    Width       = 1200
    Caption     = "Controle de Movimenta" + CHR(231) + CHR(245) + "es por XML"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    BackColor   = RGB(100, 100, 100)
    KeyPreview  = .T.

    *-- Propriedades internas
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"    && LISTA / INCLUIR / ALTERAR / VISUALIZAR
    this_cMensagemErro   = ""

    *-- Filtros de data para CarregarLista (populados nos controles da Fase 4)
    this_dDataInicial    = {}
    this_dDataFinal      = {}

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase que chama InicializarForm
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.Init:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO e monta estrutura visual
    * Chamado por FormBase.Init() via DODEFAULT()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrCtrBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigPrCtrBO", "Erro")
            ELSE
                THIS.this_dDataInicial = DATE()
                THIS.this_dDataFinal   = DATE()

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Propaga Caption para labels do cabecalho
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Cabecalho", 5)
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)
                        THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    ENDIF
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
                        THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    ENDIF
                ENDIF

                THIS.CarregarLista()

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                SET DATE TO BRITISH
                SET CENTURY ON

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.InicializarForm:" + CHR(13) + loc_oErro.Message + ;
                    " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame externo com 2 paginas
    * Top=-29 oculta as abas; Pages compensam +29 em seus controles diretos
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
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Containers da Page1 (Lista)
    * cnt_4c_Cabecalho : barra cinza escura com titulo
    * cnt_4c_Botoes    : container CRUD - botoes adicionados na Fase 4
    * cnt_4c_Saida     : container canonico com cmd_4c_Encerrar
    * Grid e filtros de data sao adicionados na Fase 4
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (cntSombra do legado: Top=2+29=31)
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
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_Op: Left escalonado para 1200px)
        *-- Original Grupo_Op.Left = 542 em form 1000px; adaptado: 742 em 1200px
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- 5 botoes CRUD dentro de cnt_4c_Botoes
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption = "Incluir"
            .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 5
            .Width = 75
            .Height = 75
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(90,90,90)
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .FontItalic = .T.
            .Themes = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap = .T.
            .AutoSize = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption = "Visualizar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 80
            .Width = 75
            .Height = 75
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(90,90,90)
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .FontItalic = .T.
            .Themes = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap = .T.
            .AutoSize = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption = "Alterar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 155
            .Width = 75
            .Height = 75
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(90,90,90)
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .FontItalic = .T.
            .Themes = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap = .T.
            .AutoSize = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption = "Excluir"
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 230
            .Width = 75
            .Height = 75
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(90,90,90)
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .FontItalic = .T.
            .Themes = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap = .T.
            .AutoSize = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption = "Buscar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 305
            .Width = 75
            .Height = 75
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(90,90,90)
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .FontItalic = .T.
            .Themes = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap = .T.
            .AutoSize = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de saida canonico: Left = THIS.Width - 83 = 1117
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
            .Top = 5
            .Left = 5
            .Width = 75
            .Height = 75
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(90,90,90)
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .FontItalic = .T.
            .Themes = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap = .T.
            .AutoSize = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Filtros de data (original: Dt_inicial top=102, left=495; Dt_final top=102, left=598)
        *-- Compensacao PageFrame +29: top=131
        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Caption  = "\<Per" + CHR(237) + "odo :"
            .Top = 135
            .Left = 440
            .Width = 52
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.txt_4c_DtInicial
            .Value  = DATE()
            .Format = "D"
            .Top = 131
            .Left = 495
            .Width = 80
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")

        loc_oPagina.AddObject("lbl_4c_Sep", "Label")
        WITH loc_oPagina.lbl_4c_Sep
            .Caption  = "-"
            .Top = 135
            .Left = 578
            .Width = 15
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DtFinal
            .Value  = DATE()
            .Format = "D"
            .Top = 131
            .Left = 598
            .Width = 80
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "DtFinalLostFocus")

        *-- Grid de lista de lotes - abaixo dos filtros de data
        *-- ColumnCount ANTES do WITH para que Column1..N existam no bloco
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oPagina.grd_4c_Dados.Top         = 155
        loc_oPagina.grd_4c_Dados.Left        = 12
        loc_oPagina.grd_4c_Dados.Width       = 1100
        loc_oPagina.grd_4c_Dados.Height      = 430
        loc_oPagina.grd_4c_Dados.ColumnCount = 6
        WITH loc_oPagina.grd_4c_Dados
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
            .Column1.Width = 80
            .Column2.Width = 90
            .Column3.Width = 90
            .Column4.Width = 320
            .Column5.Width = 120
            .Column6.Width = 120
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Containers da Page2 (Dados)
    * cnt_4c_BotoesAcao : Confirmar / Cancelar
    * pgf_4c_Dados      : PageFrame interno (original: Pageframe1 top=3, left=-1)
    *   Page1: campos lote + grdEstoque + OptionGroups (Fases 5-6)
    *   Page2: grdDisponivel + grdItemXml + campos produto (Fase 7)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar (canonico: Top=4+29=33, Left=1042)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 1042
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption = "Confirmar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 5
            .Width = 75
            .Height = 75
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(90,90,90)
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .FontItalic = .T.
            .Themes = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap = .T.
            .AutoSize = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption = "Encerrar"
            .Picture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 80
            .Width = 75
            .Height = 75
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(90,90,90)
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .FontItalic = .T.
            .Themes = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap = .T.
            .AutoSize = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- PageFrame interno (Pageframe1 do legado: top=3+29=32, left=-1)
        loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
        WITH loc_oPagina.pgf_4c_Dados
            .PageCount = 2
            .Top       = 32
            .Left      = -1
            .Width     = THIS.Width + 1
            .Height    = 617
            .Tabs      = .F.
        ENDWITH

        loc_oPagina.pgf_4c_Dados.Page1.Caption   = "Lote"
        loc_oPagina.pgf_4c_Dados.Page1.BackColor = RGB(255, 255, 255)

        loc_oPagina.pgf_4c_Dados.Page2.Caption   = "Itens"
        loc_oPagina.pgf_4c_Dados.Page2.BackColor = RGB(255, 255, 255)

        THIS.ConfigurarPaginaDadosLote()
        THIS.ConfigurarPaginaDadosDetalhe()
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDadosLote - Controles do pgf_4c_Dados.Page1 (Lote)
    * Campos do lote: Grupo, Conta, Dconta, Cpf, Moeda, Arquivo
    * OptionGroups: opt_4c_Custo (2 botoes), opt_4c_Fil (3 botoes)
    * Botoes: cmd_4c_Processar, cmd_4c_BotConsulta, cmd_4c_BtnCadastros,
    *         cmd_4c_Command12, cmd_4c_CmdOperacao (CommandGroup)
    * Grid: grd_4c_Estoque (5 colunas: Empresa, Movimentacao, Numero, Grupo, Conta)
    * Offset +29 em Top para compensar aba oculta do inner PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDadosLote()
        LOCAL loc_oPg2P1
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        *-- Label: Fornecedores (Say4: top=69+29=98)
        loc_oPg2P1.AddObject("lbl_4c_Forn", "Label")
        WITH loc_oPg2P1.lbl_4c_Forn
            .Caption   = "Fornecedores :"
            .AutoSize  = .T.
            .Top = 98
            .Left = 228
            .Height = 15
            .FontName  = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- TextBox: Get_Grupo / txt_4c_Grupo (top=66+29=95)
        loc_oPg2P1.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPg2P1.txt_4c_Grupo
            .Value = ""
            .MaxLength = 10
            .Format = "K"
            .Top = 95
            .Left = 307
            .Width = 85
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2P1.txt_4c_Grupo, "KeyPress", THIS, "TxtGrupoLostFocus")
        BINDEVENT(loc_oPg2P1.txt_4c_Grupo, "KeyPress",  THIS, "TxtGrupoKeyPress")
        BINDEVENT(loc_oPg2P1.txt_4c_Grupo, "DblClick",  THIS, "TxtGrupoDblClick")

        *-- TextBox: Get_Conta / txt_4c_Conta (top=66+29=95, left=394)
        loc_oPg2P1.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPg2P1.txt_4c_Conta
            .Value = ""
            .MaxLength = 10
            .Format = "K"
            .Top = 95
            .Left = 394
            .Width = 85
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2P1.txt_4c_Conta, "KeyPress", THIS, "TxtContaLostFocus")
        BINDEVENT(loc_oPg2P1.txt_4c_Conta, "KeyPress",  THIS, "TxtContaKeyPress")
        BINDEVENT(loc_oPg2P1.txt_4c_Conta, "DblClick",  THIS, "TxtContaDblClick")

        *-- TextBox: Get_Dconta / txt_4c_Dconta (top=89+29=118)
        loc_oPg2P1.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oPg2P1.txt_4c_Dconta
            .Value = ""
            .MaxLength = 40
            .Format = "K"
            .Top = 118
            .Left = 307
            .Width = 357
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2P1.txt_4c_Dconta, "KeyPress", THIS, "TxtDcontaLostFocus")
        BINDEVENT(loc_oPg2P1.txt_4c_Dconta, "KeyPress",  THIS, "TxtDcontaKeyPress")
        BINDEVENT(loc_oPg2P1.txt_4c_Dconta, "DblClick",  THIS, "TxtDcontaDblClick")

        *-- TextBox: Get_cpf / txt_4c_Cpf - CNPJ/CPF do fornecedor (top=66+29=95, left=481)
        loc_oPg2P1.AddObject("txt_4c_Cpf", "TextBox")
        WITH loc_oPg2P1.txt_4c_Cpf
            .Value = ""
            .MaxLength = 20
            .InputMask = "XXXXXXXXXXXXXXXXXXXX"
            .Top = 95
            .Left = 481
            .Width = 146
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2P1.txt_4c_Cpf, "KeyPress", THIS, "TxtCpfLostFocus")

        *-- Label: Precificacao (Say1: top=114+29=143)
        loc_oPg2P1.AddObject("lbl_4c_Precif", "Label")
        WITH loc_oPg2P1.lbl_4c_Precif
            .Caption   = "Precifica" + CHR(231) + CHR(227) + "o :"
            .AutoSize  = .T.
            .Top = 143
            .Left = 237
            .Height = 15
            .FontName  = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- OptionGroup: Opt_Custo / opt_4c_Custo (top=113+29=142)
        *-- ButtonCount ANTES do WITH; .Value de Buttons(N) OMITIDO (regra anti-todos-marcados)
        loc_oPg2P1.AddObject("opt_4c_Custo", "OptionGroup")
        loc_oPg2P1.opt_4c_Custo.ButtonCount = 2
        loc_oPg2P1.opt_4c_Custo.Top         = 142
        loc_oPg2P1.opt_4c_Custo.Left        = 303
        loc_oPg2P1.opt_4c_Custo.Width       = 255
        loc_oPg2P1.opt_4c_Custo.Height      = 17
        WITH loc_oPg2P1.opt_4c_Custo
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible = .T.
            WITH .Buttons(1)
                .Caption   = "Custo Total"
                .BackStyle = 0
                .AutoSize  = .T.
                .Top = 1
                .Left = 5
                .Height = 15
                .Width = 73
                .ForeColor = RGB(90, 90, 90)
                .Themes = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Custo pela Composi" + CHR(231) + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .AutoSize = .T.
                .Top = 1
                .Left = 98
                .Height = 15
                .Width = 129
                .ForeColor = RGB(90, 90, 90)
                .Themes = .F.
            ENDWITH
            .Value = 1
        ENDWITH
        BINDEVENT(loc_oPg2P1.opt_4c_Custo, "InteractiveChange", THIS, "OptCustoInteractiveChange")

        *-- Label: Moeda (Say3: top=137+29=166)
        loc_oPg2P1.AddObject("lbl_4c_LoteMoeda", "Label")
        WITH loc_oPg2P1.lbl_4c_LoteMoeda
            .Caption   = "Moeda :"
            .AutoSize  = .T.
            .Top = 166
            .Left = 262
            .Height = 15
            .FontName  = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- TextBox: Get_Moeda / txt_4c_Moeda (top=134+29=163)
        loc_oPg2P1.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPg2P1.txt_4c_Moeda
            .Value = ""
            .MaxLength = 10
            .Format = "K"
            .Top = 163
            .Left = 307
            .Width = 85
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2P1.txt_4c_Moeda, "KeyPress", THIS, "TxtMoedaLostFocus")
        BINDEVENT(loc_oPg2P1.txt_4c_Moeda, "KeyPress",  THIS, "TxtMoedaKeyPress")
        BINDEVENT(loc_oPg2P1.txt_4c_Moeda, "DblClick",  THIS, "TxtMoedaDblClick")

        *-- Label: Diretorio (Say2: top=160+29=189)
        loc_oPg2P1.AddObject("lbl_4c_Dir", "Label")
        WITH loc_oPg2P1.lbl_4c_Dir
            .Caption   = "Diret" + CHR(243) + "rio :"
            .AutoSize  = .T.
            .Top = 189
            .Left = 253
            .Height = 15
            .FontName  = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- TextBox: Get_Arquivo / txt_4c_Arquivo - ReadOnly, preenchido por Command12
        loc_oPg2P1.AddObject("txt_4c_Arquivo", "TextBox")
        WITH loc_oPg2P1.txt_4c_Arquivo
            .Value = ""
            .MaxLength = 200
            .Top = 186
            .Left = 307
            .Width = 357
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .ReadOnly = .T.
            .Visible = .T.
        ENDWITH

        *-- Button: Command12 / cmd_4c_Command12 - file picker (top=157+29=186)
        loc_oPg2P1.AddObject("cmd_4c_Command12", "CommandButton")
        WITH loc_oPg2P1.cmd_4c_Command12
            .Caption = "..."
            .Top = 186
            .Left = 667
            .Width = 20
            .Height = 20
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 0
            .MousePointer = 15
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2P1.cmd_4c_Command12, "Click", THIS, "CmdCommand12Click")

        *-- Label: Carregar produtos... (Label1: top=184+29=213)
        loc_oPg2P1.AddObject("lbl_4c_CarregarXml", "Label")
        WITH loc_oPg2P1.lbl_4c_CarregarXml
            .Caption   = "Carregar produtos que constam nos XML" + CHR(39) + "s :"
            .FontBold  = .T.
            .AutoSize  = .T.
            .Top = 213
            .Left = 55
            .Width = 246
            .Height = 15
            .FontName  = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH

        *-- OptionGroup: Opt_Fil / opt_4c_Fil (top=179+29=208)
        loc_oPg2P1.AddObject("opt_4c_Fil", "OptionGroup")
        loc_oPg2P1.opt_4c_Fil.ButtonCount = 3
        loc_oPg2P1.opt_4c_Fil.Top         = 208
        loc_oPg2P1.opt_4c_Fil.Left        = 303
        loc_oPg2P1.opt_4c_Fil.Width       = 192
        loc_oPg2P1.opt_4c_Fil.Height      = 24
        WITH loc_oPg2P1.opt_4c_Fil
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible = .T.
            WITH .Buttons(1)
                .Caption   = "Somente"
                .BackStyle = 0
                .AutoSize  = .T.
                .Top = 5
                .Left = 5
                .Height = 15
                .Width = 60
                .ForeColor = RGB(90, 90, 90)
                .Themes = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .AutoSize = .T.
                .Top = 5
                .Left = 84
                .Height = 15
                .Width = 37
                .ForeColor = RGB(90, 90, 90)
                .Themes = .F.
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Ambos"
                .FontName  = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .AutoSize = .T.
                .Top = 5
                .Left = 132
                .Height = 15
                .Width = 50
                .ForeColor = RGB(90, 90, 90)
                .Themes = .F.
            ENDWITH
            .Value = 1
        ENDWITH
        BINDEVENT(loc_oPg2P1.opt_4c_Fil, "InteractiveChange", THIS, "OptFilInteractiveChange")

        *-- Label: Movimentacoes (Say5: top=204+29=233)
        loc_oPg2P1.AddObject("lbl_4c_Movs", "Label")
        WITH loc_oPg2P1.lbl_4c_Movs
            .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es :"
            .FontBold  = .T.
            .AutoSize = .T.
            .Top = 233
            .Left = 203
            .Height = 15
            .FontName  = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- Grid: grdEstoque / grd_4c_Estoque (top=206+29=235)
        *-- ColumnCount OBRIGATORIAMENTE antes do WITH
        loc_oPg2P1.AddObject("grd_4c_Estoque", "Grid")
        loc_oPg2P1.grd_4c_Estoque.Top         = 235
        loc_oPg2P1.grd_4c_Estoque.Left        = 307
        loc_oPg2P1.grd_4c_Estoque.Width       = 545
        loc_oPg2P1.grd_4c_Estoque.Height      = 340
        loc_oPg2P1.grd_4c_Estoque.ColumnCount = 5
        WITH loc_oPg2P1.grd_4c_Estoque
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(237, 242, 243)
            .GridLineColor     = RGB(238, 238, 238)
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 16
            .ScrollBars        = 2
            .Visible           = .T.
            .Column1.Width = 70
            .Column1.Header1.Caption = "Empresa"
            .Column2.Width = 200
            .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Column3.Width = 80
            .Column3.Header1.Caption = "Numero"
            .Column4.Width = 80
            .Column4.Header1.Caption = "Grupo"
            .Column5.Width = 80
            .Column5.Header1.Caption = "Conta"
            .Column4.ReadOnly = .T.
            .Column5.ReadOnly = .T.
        ENDWITH

        *-- Button: Bot_Consulta / cmd_4c_BotConsulta (top=70+29=99, left=667)
        loc_oPg2P1.AddObject("cmd_4c_BotConsulta", "CommandButton")
        WITH loc_oPg2P1.cmd_4c_BotConsulta
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "geral_calendario_26.jpg"
            .Top = 99
            .Left = 667
            .Width = 40
            .Height = 40
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(90,90,90)
            .SpecialEffect = 0
            .Themes = .F.
            .ToolTipText = "<F5> Faz a Consulta Gen" + CHR(233) + "rica de Vendas desta Conta..."
            .MousePointer = 15
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2P1.cmd_4c_BotConsulta, "Click", THIS, "CmdBotConsultaClick")

        *-- Button: btnCadastros / cmd_4c_BtnCadastros (top=70+29=99, left=708)
        loc_oPg2P1.AddObject("cmd_4c_BtnCadastros", "CommandButton")
        WITH loc_oPg2P1.cmd_4c_BtnCadastros
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "geral_pastas_28.jpg"
            .Top = 99
            .Left = 708
            .Width = 40
            .Height = 40
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(90,90,90)
            .SpecialEffect = 0
            .Themes = .F.
            .ToolTipText = "<F3> Acessa o Cadastro Desta Conta"
            .MousePointer = 15
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2P1.cmd_4c_BtnCadastros, "Click", THIS, "CmdBtnCadastrosClick")

        *-- CommandGroup: cmdOperacao / cmd_4c_CmdOperacao (top=334+29=363)
        loc_oPg2P1.AddObject("cmd_4c_CmdOperacao", "CommandGroup")
        loc_oPg2P1.cmd_4c_CmdOperacao.ButtonCount = 1
        loc_oPg2P1.cmd_4c_CmdOperacao.Top         = 363
        loc_oPg2P1.cmd_4c_CmdOperacao.Left        = 857
        loc_oPg2P1.cmd_4c_CmdOperacao.Width       = 85
        loc_oPg2P1.cmd_4c_CmdOperacao.Height      = 85
        WITH loc_oPg2P1.cmd_4c_CmdOperacao
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes = .F.
            .Visible = .T.
            WITH .Buttons(1)
                .Top = 5
                .Left = 5
                .Height = 75
                .Width = 75
                .FontBold = .T.
                .FontItalic = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
                .Caption         = "Movimento"
                .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o"
                .PicturePosition = 13
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes = .F.
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPg2P1.cmd_4c_CmdOperacao, "Click", THIS, "CmdOperacaoClick")

        *-- Button: processar / cmd_4c_Processar (top=7+29=36, left=962)
        loc_oPg2P1.AddObject("cmd_4c_Processar", "CommandButton")
        WITH loc_oPg2P1.cmd_4c_Processar
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .PicturePosition = 13
            .Top = 36
            .Left = 962
            .Width = 75
            .Height = 75
            .BackColor = RGB(255,255,255)
            .ForeColor = RGB(90,90,90)
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .FontItalic = .T.
            .Themes = .F.
            .SpecialEffect = 0
            .MousePointer = 15
            .WordWrap = .T.
            .AutoSize = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2P1.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.AlternarPagina: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * DtInicialLostFocus - Ajusta DtFinal se necessario e recarrega lista
    *--------------------------------------------------------------------------
    PROCEDURE DtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        IF PEMSTATUS(loc_oPg1, "txt_4c_DtFinal", 5)
            IF loc_oPg1.txt_4c_DtInicial.Value > loc_oPg1.txt_4c_DtFinal.Value
                loc_oPg1.txt_4c_DtFinal.Value = loc_oPg1.txt_4c_DtInicial.Value
            ENDIF
        ENDIF

        THIS.this_dDataInicial = loc_oPg1.txt_4c_DtInicial.Value
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * DtFinalLostFocus - Ajusta DtInicial se necessario e recarrega lista
    *--------------------------------------------------------------------------
    PROCEDURE DtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        IF PEMSTATUS(loc_oPg1, "txt_4c_DtInicial", 5)
            IF loc_oPg1.txt_4c_DtFinal.Value < loc_oPg1.txt_4c_DtInicial.Value
                loc_oPg1.txt_4c_DtInicial.Value = loc_oPg1.txt_4c_DtFinal.Value
            ENDIF
        ENDIF

        THIS.this_dDataFinal = loc_oPg1.txt_4c_DtFinal.Value
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara form para incluir novo lote
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega lote selecionado em modo leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
           RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um lote na lista.", "Aviso")
            RETURN
        ENDIF

        LOCAL loc_cCodigos
        loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega lote selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
           RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um lote na lista.", "Aviso")
            RETURN
        ENDIF

        LOCAL loc_cCodigos
        loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui lote selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
           RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um lote na lista.", "Aviso")
            RETURN
        ENDIF

        LOCAL loc_cCodigos
        loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)

        IF !MsgConfirma("Confirma exclus" + CHR(227) + "o do lote " + ;
                        ALLTRIM(loc_cCodigos) + "?", ;
                        "Confirmar Exclus" + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Lote exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega lista com filtros de data atuais
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        IF PEMSTATUS(loc_oPg1, "txt_4c_DtInicial", 5)
            THIS.this_dDataInicial = loc_oPg1.txt_4c_DtInicial.Value
        ENDIF

        IF PEMSTATUS(loc_oPg1, "txt_4c_DtFinal", 5)
            THIS.this_dDataFinal = loc_oPg1.txt_4c_DtFinal.Value
        ENDIF

        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Grava o lote: monta cursor_4c_Linhas a partir do JOIN
    * de cursor_4c_Movimentos x cursor_4c_Distribui, entao chama Salvar()
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cConta, loc_cArquivo, loc_cMoeda, loc_nOpc
        LOCAL loc_oPg2P1, loc_nQtdOs, loc_lSalvoOK, loc_oErro
        loc_cConta   = ""
        loc_cArquivo = ""
        loc_cMoeda   = ""
        loc_nOpc     = 0
        loc_lSalvoOK = .F.
        loc_oPg2P1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
            loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
            loc_cArquivo = ALLTRIM(loc_oPg2P1.txt_4c_Arquivo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
            loc_cMoeda = ALLTRIM(loc_oPg2P1.txt_4c_Moeda.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "obj_4c_Opt_Custo", 5)
            loc_nOpc = loc_oPg2P1.obj_4c_Opt_Custo.Value
        ENDIF

        IF EMPTY(loc_cConta)
            MsgAviso("Informe o fornecedor antes de salvar.", ;
                     "Campo Obrigat" + CHR(243) + "rio")
            RETURN
        ENDIF

        IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " movimentos para gravar.", "Aviso")
            RETURN
        ENDIF

        IF !USED("cursor_4c_Distribui") OR RECCOUNT("cursor_4c_Distribui") = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " distribui" + CHR(231) + CHR(227) + ;
                     "o para gravar.", "Aviso")
            RETURN
        ENDIF

        TRY
            *-- Monta cursor_4c_Linhas: JOIN movimentos x distribui onde qtd > 0 e saldo > 0
            IF USED("cursor_4c_TmpJoin")
                USE IN cursor_4c_TmpJoin
            ENDIF

            SELECT a.Cpros, a.Qtds, a.OriDopNums, a.CidChaves, b.Qtds AS QtdXml ;
                FROM cursor_4c_Movimentos a ;
                JOIN cursor_4c_Distribui b ON ALLTRIM(a.Cpros) = ALLTRIM(b.Cpros) ;
                INTO CURSOR cursor_4c_TmpJoin READWRITE

            IF USED("cursor_4c_Linhas")
                ZAP IN cursor_4c_Linhas
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_Linhas ;
                    (Cpros    C(14), CodCors C(4),   CodTams  C(4),  ;
                     OriDopNums C(29), Qtds N(12,2), QtdOs    N(12,2), ;
                     Contas   C(10),  Arquivo C(200), Moedas  C(3),   ;
                     Precific N(12,2), FkChaves C(20))
                SET NULL OFF
            ENDIF

            IF USED("cursor_4c_TmpJoin") AND RECCOUNT("cursor_4c_TmpJoin") > 0
                SELECT cursor_4c_TmpJoin
                GO TOP
                SCAN
                    loc_nQtdOs = IIF(cursor_4c_TmpJoin.QtdXml > cursor_4c_TmpJoin.Qtds, ;
                                     cursor_4c_TmpJoin.Qtds, cursor_4c_TmpJoin.QtdXml)
                    INSERT INTO cursor_4c_Linhas ;
                        (Cpros, CodCors, CodTams, OriDopNums, Qtds, QtdOs, ;
                         Contas, Arquivo, Moedas, Precific, FkChaves) ;
                        VALUES ;
                        (cursor_4c_TmpJoin.Cpros, "", "", cursor_4c_TmpJoin.OriDopNums, ;
                         cursor_4c_TmpJoin.Qtds, loc_nQtdOs, ;
                         loc_cConta, loc_cArquivo, loc_cMoeda, loc_nOpc, ;
                         cursor_4c_TmpJoin.CidChaves)
                    SELECT cursor_4c_TmpJoin
                ENDSCAN
            ENDIF

            IF USED("cursor_4c_TmpJoin")
                USE IN cursor_4c_TmpJoin
            ENDIF

            IF !USED("cursor_4c_Linhas") OR RECCOUNT("cursor_4c_Linhas") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " linhas v" + CHR(225) + ;
                         "lidas para gravar (verifique saldo e distribui" + CHR(231) + CHR(227) + "o).", ;
                         "Aviso")
            ELSE
                THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Lote gravado com sucesso!", "Sucesso")
                    loc_lSalvoOK = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.BtnSalvarClick:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY

        IF loc_lSalvoOK
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos campos da Page2 para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2P1
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
            THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(loc_oPg2P1.txt_4c_Grupo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
            THIS.this_oBusinessObject.this_cContas = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
            THIS.this_oBusinessObject.this_cDconta = ALLTRIM(loc_oPg2P1.txt_4c_Dconta.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
            THIS.this_oBusinessObject.this_cArquivo = ALLTRIM(loc_oPg2P1.txt_4c_Arquivo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
            THIS.this_oBusinessObject.this_cMoedas = ALLTRIM(loc_oPg2P1.txt_4c_Moeda.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
            THIS.this_oBusinessObject.this_cCpf = ALLTRIM(loc_oPg2P1.txt_4c_Cpf.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "opt_4c_Custo", 5)
            THIS.this_oBusinessObject.this_nPrecific = loc_oPg2P1.opt_4c_Custo.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2P1
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
            loc_oPg2P1.txt_4c_Grupo.Value = THIS.this_oBusinessObject.this_cGrupo
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
            loc_oPg2P1.txt_4c_Conta.Value = THIS.this_oBusinessObject.this_cContas
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
            loc_oPg2P1.txt_4c_Dconta.Value = THIS.this_oBusinessObject.this_cDconta
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
            loc_oPg2P1.txt_4c_Arquivo.Value = THIS.this_oBusinessObject.this_cArquivo
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
            loc_oPg2P1.txt_4c_Moeda.Value = THIS.this_oBusinessObject.this_cMoedas
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
            loc_oPg2P1.txt_4c_Cpf.Value = THIS.this_oBusinessObject.this_cCpf
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "opt_4c_Custo", 5)
            loc_oPg2P1.opt_4c_Custo.Value = THIS.this_oBusinessObject.this_nPrecific
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos editaveis da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2P1
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
            loc_oPg2P1.txt_4c_Grupo.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
            loc_oPg2P1.txt_4c_Conta.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
            loc_oPg2P1.txt_4c_Dconta.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
            loc_oPg2P1.txt_4c_Arquivo.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
            loc_oPg2P1.txt_4c_Moeda.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
            loc_oPg2P1.txt_4c_Cpf.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "opt_4c_Custo", 5)
            loc_oPg2P1.opt_4c_Custo.Value = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos editaveis da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2P1, loc_oCntAcao
        loc_oPg2P1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_oCntAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
            loc_oPg2P1.txt_4c_Grupo.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
            loc_oPg2P1.txt_4c_Conta.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
            loc_oPg2P1.txt_4c_Dconta.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
            loc_oPg2P1.txt_4c_Arquivo.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
            loc_oPg2P1.txt_4c_Moeda.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
            loc_oPg2P1.txt_4c_Cpf.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "opt_4c_Custo", 5)
            loc_oPg2P1.opt_4c_Custo.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "cmd_4c_Processar", 5)
            loc_oPg2P1.cmd_4c_Processar.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oCntAcao, "cmd_4c_Confirmar", 5)
            loc_oCntAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD conforme modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lLista, loc_lEdita
        loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
        loc_lLista = (THIS.this_cModoAtual = "LISTA")
        loc_lEdita = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oCnt, "cmd_4c_Incluir", 5)
            loc_oCnt.cmd_4c_Incluir.Enabled = loc_lLista
        ENDIF
        IF PEMSTATUS(loc_oCnt, "cmd_4c_Visualizar", 5)
            loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lLista
        ENDIF
        IF PEMSTATUS(loc_oCnt, "cmd_4c_Alterar", 5)
            loc_oCnt.cmd_4c_Alterar.Enabled = loc_lLista
        ENDIF
        IF PEMSTATUS(loc_oCnt, "cmd_4c_Excluir", 5)
            loc_oCnt.cmd_4c_Excluir.Enabled = loc_lLista
        ENDIF
        IF PEMSTATUS(loc_oCnt, "cmd_4c_Buscar", 5)
            loc_oCnt.cmd_4c_Buscar.Enabled = loc_lLista
        ENDIF

        LOCAL loc_oCntAcao
        loc_oCntAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
        IF PEMSTATUS(loc_oCntAcao, "cmd_4c_Confirmar", 5)
            loc_oCntAcao.cmd_4c_Confirmar.Enabled = loc_lEdita
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca lotes do banco e popula grd_4c_Dados
    * Propaga datas de this_dDataInicial/this_dDataFinal para o BO
    * grd_4c_Dados e controles de filtro sao criados na Fase 4;
    *   este metodo le os controles se existirem, graciosamente ignora se nao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oPg1, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oPg1 = THIS.pgf_4c_Paginas.Page1

                *-- Propagar filtros de data a partir dos controles (Fase 4 cria os controles)
                IF PEMSTATUS(loc_oPg1, "txt_4c_DtInicial", 5)
                    THIS.this_oBusinessObject.this_dDataInicial = loc_oPg1.txt_4c_DtInicial.Value
                ELSE
                    THIS.this_oBusinessObject.this_dDataInicial = THIS.this_dDataInicial
                ENDIF

                IF PEMSTATUS(loc_oPg1, "txt_4c_DtFinal", 5)
                    THIS.this_oBusinessObject.this_dDataFinal = loc_oPg1.txt_4c_DtFinal.Value
                ELSE
                    THIS.this_oBusinessObject.this_dDataFinal = THIS.this_dDataFinal
                ENDIF

                IF THIS.this_oBusinessObject.Buscar("")
                    *-- Popula grid quando existir (criado na Fase 4)
                    IF PEMSTATUS(loc_oPg1, "grd_4c_Dados", 5)
                        loc_oGrid = loc_oPg1.grd_4c_Dados
                        loc_oGrid.ColumnCount = 6
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Datas"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Contas"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Rclis"
                        loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Usuars"
                        loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.OriDopNums"
                        loc_oGrid.Column1.Header1.Caption = "Numero"
                        loc_oGrid.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column3.Header1.Caption = "Conta"
                        loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column5.Header1.Caption = "Grupo"
                        loc_oGrid.Column6.Header1.Caption = "Empresa"

                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
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
    * OptCustoInteractiveChange - Persiste opcao de precificacao no BO
    *--------------------------------------------------------------------------
    PROCEDURE OptCustoInteractiveChange()
        LOCAL loc_oPg2P1
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF PEMSTATUS(loc_oPg2P1, "opt_4c_Custo", 5)
            THIS.this_oBusinessObject.this_nPrecific = loc_oPg2P1.opt_4c_Custo.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OptFilInteractiveChange - Reaplicar filtro opt_4c_Fil ao cursor_4c_Movimentos
    *--------------------------------------------------------------------------
    PROCEDURE OptFilInteractiveChange()
        LOCAL loc_oPg2P1, loc_nTipo, loc_oErro
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_nTipo  = 3
        IF PEMSTATUS(loc_oPg2P1, "opt_4c_Fil", 5)
            loc_nTipo = loc_oPg2P1.opt_4c_Fil.Value
        ENDIF

        TRY
            IF loc_nTipo != 3 AND USED("cursor_4c_Distribui") AND ;
               RECCOUNT("cursor_4c_Distribui") > 0 AND ;
               USED("cursor_4c_Movimentos") AND RECCOUNT("cursor_4c_Movimentos") > 0
                IF USED("cursor_4c_MovFiltro")
                    USE IN cursor_4c_MovFiltro
                ENDIF
                IF loc_nTipo = 1
                    SELECT * FROM cursor_4c_Movimentos ;
                        WHERE Cpros IN (SELECT Cpros FROM cursor_4c_Distribui) ;
                        INTO CURSOR cursor_4c_MovFiltro READWRITE
                ELSE
                    SELECT * FROM cursor_4c_Movimentos ;
                        WHERE Cpros NOT IN (SELECT Cpros FROM cursor_4c_Distribui) ;
                        INTO CURSOR cursor_4c_MovFiltro READWRITE
                ENDIF
                SELECT cursor_4c_Movimentos
                ZAP
                IF USED("cursor_4c_MovFiltro") AND RECCOUNT("cursor_4c_MovFiltro") > 0
                    APPEND FROM DBF("cursor_4c_MovFiltro")
                ENDIF
                IF USED("cursor_4c_MovFiltro")
                    USE IN cursor_4c_MovFiltro
                ENDIF
                IF USED("cursor_4c_Movimentos")
                    GO TOP IN cursor_4c_Movimentos
                ENDIF
            ENDIF
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2, "grd_4c_Disponivel", 5)
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Disponivel.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.OptFilInteractiveChange:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual da grade de lotes (Page1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Percorre recursivamente e seta Visible=.T.
    * Inclui tratamento especial para PageFrames aninhados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO", "IMG_4C_FIGJPG")
                        IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                            THIS.TornarControlesVisiveis(loc_oObjeto)
                        ENDIF
                        LOOP
                    ENDIF
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
    * TxtGrupoKeyPress - F4 abre lookup de Grupo
    *--------------------------------------------------------------------------
    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGrupoDblClick - DblClick abre lookup de Grupo
    *--------------------------------------------------------------------------
    PROCEDURE TxtGrupoDblClick()
        THIS.AbrirLookupGrupo()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - Picker SigCdGrp (cgrus/dgrus)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oPg2P1, loc_cGrupo, loc_oBusca, loc_oErro
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
            RETURN
        ENDIF
        loc_cGrupo = ALLTRIM(loc_oPg2P1.txt_4c_Grupo.Value)
        TRY
            IF USED("cursor_4c_BuscaGrp")
                USE IN cursor_4c_BuscaGrp
            ENDIF
            =SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", "cursor_4c_BuscaGrp")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
                "cursor_4c_BuscaGrp", "cgrus", loc_cGrupo, "Grupo", .T., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaGrp")
                        USE IN cursor_4c_BuscaGrp
                    ENDIF
                    =SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", "cursor_4c_BuscaGrp")
                    loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                    loc_oPg2P1.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
                    THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
                ENDIF
                IF USED("cursor_4c_BuscaGrp")
                    USE IN cursor_4c_BuscaGrp
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.AbrirLookupGrupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtContaKeyPress - F4 abre lookup de Conta (Fornecedor por codigo)
    *--------------------------------------------------------------------------
    PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtContaDblClick - DblClick abre lookup de Conta (Fornecedor)
    *--------------------------------------------------------------------------
    PROCEDURE TxtContaDblClick()
        THIS.AbrirLookupConta()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConta - Picker SigCdCli por Iclis; preenche Conta/Dconta/Cpf
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupConta()
        LOCAL loc_oPg2P1, loc_cConta, loc_oBusca, loc_oErro
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
            RETURN
        ENDIF
        loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
        TRY
            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF
            =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaCli")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
                "cursor_4c_BuscaCli", "Iclis", loc_cConta, "Fornecedor", .T., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaCli")
                        USE IN cursor_4c_BuscaCli
                    ENDIF
                    =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaCli")
                    loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
                    loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                    loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
                    IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
                        loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
                    ENDIF
                    IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
                        loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
                    ENDIF
                    THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
                ENDIF
                IF USED("cursor_4c_BuscaCli")
                    USE IN cursor_4c_BuscaCli
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.AbrirLookupConta:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDcontaKeyPress - F4 abre lookup de Dconta (nome Fornecedor)
    *--------------------------------------------------------------------------
    PROCEDURE TxtDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupDconta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDcontaDblClick - DblClick abre lookup de Dconta
    *--------------------------------------------------------------------------
    PROCEDURE TxtDcontaDblClick()
        THIS.AbrirLookupDconta()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDconta - Picker SigCdCli por Rclis; preenche Conta/Dconta/Cpf
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDconta()
        LOCAL loc_oPg2P1, loc_cDconta, loc_oBusca, loc_oErro
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
            RETURN
        ENDIF
        loc_cDconta = ALLTRIM(loc_oPg2P1.txt_4c_Dconta.Value)
        TRY
            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF
            =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaCli")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
                "cursor_4c_BuscaCli", "Rclis", loc_cDconta, "Fornecedor", .T., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaCli")
                        USE IN cursor_4c_BuscaCli
                    ENDIF
                    =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaCli")
                    loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
                    loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                    IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
                        loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
                    ENDIF
                    loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
                    IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
                        loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
                    ENDIF
                    THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
                ENDIF
                IF USED("cursor_4c_BuscaCli")
                    USE IN cursor_4c_BuscaCli
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.AbrirLookupDconta:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMoedaKeyPress - F4 abre lookup de Moeda
    *--------------------------------------------------------------------------
    PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMoedaDblClick - DblClick abre lookup de Moeda
    *--------------------------------------------------------------------------
    PROCEDURE TxtMoedaDblClick()
        THIS.AbrirLookupMoeda()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoeda - Picker SigCdMoe (CMoes/DMoes)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oPg2P1, loc_cMoeda, loc_oBusca, loc_oErro
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
            RETURN
        ENDIF
        loc_cMoeda = ALLTRIM(loc_oPg2P1.txt_4c_Moeda.Value)
        TRY
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
            =SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_BuscaMoe")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
                "cursor_4c_BuscaMoe", "CMoes", loc_cMoeda, "Moeda", .T., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaMoe")
                        USE IN cursor_4c_BuscaMoe
                    ENDIF
                    =SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_BuscaMoe")
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                    loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                ENDIF
                IF USED("cursor_4c_BuscaMoe")
                    USE IN cursor_4c_BuscaMoe
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.AbrirLookupMoeda:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
            loc_oPg2P1.txt_4c_Moeda.Refresh
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGrupoLostFocus - Persiste valor do Grupo no BO
    *--------------------------------------------------------------------------
    PROCEDURE TxtGrupoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2P1
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
            THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(loc_oPg2P1.txt_4c_Grupo.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtContaLostFocus - Lookup SigCdCli por Iclis; preenche Dconta, Cpf e grade
    *--------------------------------------------------------------------------
    PROCEDURE TxtContaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2P1, loc_cConta, loc_oBusca, loc_cSQL, loc_nResult, loc_oErro
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
            RETURN
        ENDIF

        loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)

        IF EMPTY(loc_cConta)
            IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
                loc_oPg2P1.txt_4c_Dconta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
                loc_oPg2P1.txt_4c_Cpf.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF
            loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
                       " WHERE LTRIM(RTRIM(Iclis)) = " + EscaparSQL(loc_cConta) + ;
                       " ORDER BY Iclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")

            IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
               RECCOUNT("cursor_4c_BuscaCli") > 0
                loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
                IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
                    loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
                ENDIF
                IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
                    loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
                ENDIF
                IF USED("cursor_4c_BuscaCli")
                    USE IN cursor_4c_BuscaCli
                ENDIF
                THIS.CarregarMovimentosPendentes(loc_cConta, .T.)
            ELSE
                IF USED("cursor_4c_BuscaCli")
                    USE IN cursor_4c_BuscaCli
                ENDIF
                *-- Nao encontrado exato: abre picker
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
                    "cursor_4c_BuscaCli", "Iclis", loc_cConta, "Fornecedor", .T., .T., "")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lSelecionou
                        IF USED("cursor_4c_BuscaCli")
                            USE IN cursor_4c_BuscaCli
                        ENDIF
                        loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
                                   " WHERE CAST(Iclis AS VARCHAR(20)) LIKE " + ;
                                   EscaparSQL(loc_cConta + "%") + " ORDER BY Iclis"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli") < 1 OR ;
                           !USED("cursor_4c_BuscaCli") OR RECCOUNT("cursor_4c_BuscaCli") = 0
                            IF USED("cursor_4c_BuscaCli")
                                USE IN cursor_4c_BuscaCli
                            ENDIF
                            =SQLEXEC(gnConnHandle, ;
                                "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", ;
                                "cursor_4c_BuscaCli")
                        ENDIF
                        loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
                        loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                        loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
                        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
                            loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
                        ENDIF
                        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
                            loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
                        ENDIF
                        THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
                    ELSE
                        loc_oPg2P1.txt_4c_Conta.Value = ""
                        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
                            loc_oPg2P1.txt_4c_Dconta.Value = ""
                        ENDIF
                        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
                            loc_oPg2P1.txt_4c_Cpf.Value = ""
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_BuscaCli")
                        USE IN cursor_4c_BuscaCli
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.TxtContaLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
            loc_oPg2P1.txt_4c_Conta.Refresh
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
            loc_oPg2P1.txt_4c_Dconta.Refresh
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDcontaLostFocus - Lookup SigCdCli por Rclis; preenche Conta e Cpf
    *--------------------------------------------------------------------------
    PROCEDURE TxtDcontaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2P1, loc_cDconta, loc_oBusca, loc_cSQL, loc_nResult, loc_oErro
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
            RETURN
        ENDIF

        loc_cDconta = ALLTRIM(loc_oPg2P1.txt_4c_Dconta.Value)

        IF EMPTY(loc_cDconta)
            IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
                loc_oPg2P1.txt_4c_Conta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
                loc_oPg2P1.txt_4c_Cpf.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF
            loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
                       " WHERE Rclis LIKE " + EscaparSQL(loc_cDconta + "%") + ;
                       " ORDER BY Rclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")

            IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
               RECCOUNT("cursor_4c_BuscaCli") = 1
                IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
                    loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
                ENDIF
                loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
                IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
                    loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
                ENDIF
                IF USED("cursor_4c_BuscaCli")
                    USE IN cursor_4c_BuscaCli
                ENDIF
                IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
                    THIS.CarregarMovimentosPendentes(ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value), .T.)
                ENDIF
            ELSE
                *-- Multiplos ou nenhum: abre picker
                IF !USED("cursor_4c_BuscaCli") OR RECCOUNT("cursor_4c_BuscaCli") = 0
                    IF USED("cursor_4c_BuscaCli")
                        USE IN cursor_4c_BuscaCli
                    ENDIF
                    =SQLEXEC(gnConnHandle, ;
                        "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", ;
                        "cursor_4c_BuscaCli")
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
                    "cursor_4c_BuscaCli", "Rclis", loc_cDconta, "Fornecedor", .T., .T., "")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lSelecionou
                        IF USED("cursor_4c_BuscaCli")
                            USE IN cursor_4c_BuscaCli
                        ENDIF
                        =SQLEXEC(gnConnHandle, ;
                            "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", ;
                            "cursor_4c_BuscaCli")
                        loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
                        loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
                            loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
                        ENDIF
                        loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
                        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
                            loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
                        ENDIF
                        THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
                    ELSE
                        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
                            loc_oPg2P1.txt_4c_Conta.Value = ""
                        ENDIF
                        loc_oPg2P1.txt_4c_Dconta.Value = ""
                        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
                            loc_oPg2P1.txt_4c_Cpf.Value = ""
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_BuscaCli")
                        USE IN cursor_4c_BuscaCli
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.TxtDcontaLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
            loc_oPg2P1.txt_4c_Dconta.Refresh
        ENDIF
        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
            loc_oPg2P1.txt_4c_Conta.Refresh
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCpfLostFocus - Lookup SigCdCli por Cpfs (CNPJ/CPF); preenche Conta e Dconta
    *--------------------------------------------------------------------------
    PROCEDURE TxtCpfLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2P1, loc_cCpf, loc_cCpfLimpo, loc_cSQL, loc_nResult, loc_oErro
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
            RETURN
        ENDIF

        loc_cCpf = ALLTRIM(loc_oPg2P1.txt_4c_Cpf.Value)
        IF EMPTY(loc_cCpf)
            RETURN
        ENDIF

        loc_cCpfLimpo = STRTRAN(STRTRAN(STRTRAN(loc_cCpf, ".", ""), "-", ""), "/", "")

        TRY
            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF
            loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
                       " WHERE LTRIM(RTRIM(Cpfs)) = " + EscaparSQL(loc_cCpfLimpo) + ;
                       " ORDER BY Iclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")

            IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
               RECCOUNT("cursor_4c_BuscaCli") > 0
                IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
                    loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
                ENDIF
                IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
                    loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
                ENDIF
                loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
                IF USED("cursor_4c_BuscaCli")
                    USE IN cursor_4c_BuscaCli
                ENDIF
                IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
                    THIS.CarregarMovimentosPendentes(ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value), .T.)
                ENDIF
            ELSE
                IF USED("cursor_4c_BuscaCli")
                    USE IN cursor_4c_BuscaCli
                ENDIF
                MsgAviso("CPF/CNPJ n" + CHR(227) + "o encontrado no cadastro.", "Aviso")
                loc_oPg2P1.txt_4c_Cpf.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.TxtCpfLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMoedaLostFocus - Lookup SigCdMoe por CMoes; preenche ou limpa campo
    *--------------------------------------------------------------------------
    PROCEDURE TxtMoedaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2P1, loc_cMoeda, loc_oBusca, loc_cSQL, loc_nResult, loc_oErro
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
            RETURN
        ENDIF

        loc_cMoeda = ALLTRIM(loc_oPg2P1.txt_4c_Moeda.Value)

        IF EMPTY(loc_cMoeda)
            loc_oPg2P1.txt_4c_Moeda.Value = ""
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
            loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe" + ;
                       " WHERE LTRIM(RTRIM(CMoes)) = " + EscaparSQL(loc_cMoeda) + ;
                       " ORDER BY CMoes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe")

            IF loc_nResult >= 0 AND USED("cursor_4c_BuscaMoe") AND ;
               RECCOUNT("cursor_4c_BuscaMoe") > 0
                loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                IF USED("cursor_4c_BuscaMoe")
                    USE IN cursor_4c_BuscaMoe
                ENDIF
            ELSE
                IF USED("cursor_4c_BuscaMoe")
                    USE IN cursor_4c_BuscaMoe
                ENDIF
                loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe" + ;
                           " WHERE CAST(CMoes AS VARCHAR(10)) LIKE " + ;
                           EscaparSQL(loc_cMoeda + "%") + " ORDER BY CMoes"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe") < 1 OR ;
                   !USED("cursor_4c_BuscaMoe") OR RECCOUNT("cursor_4c_BuscaMoe") = 0
                    IF USED("cursor_4c_BuscaMoe")
                        USE IN cursor_4c_BuscaMoe
                    ENDIF
                    =SQLEXEC(gnConnHandle, ;
                        "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", ;
                        "cursor_4c_BuscaMoe")
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
                    "cursor_4c_BuscaMoe", "CMoes", loc_cMoeda, "Moeda", .T., .T., "")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lSelecionou
                        IF USED("cursor_4c_BuscaMoe")
                            USE IN cursor_4c_BuscaMoe
                        ENDIF
                        =SQLEXEC(gnConnHandle, ;
                            "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", ;
                            "cursor_4c_BuscaMoe")
                        loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                    ELSE
                        loc_oPg2P1.txt_4c_Moeda.Value = ""
                    ENDIF
                    IF USED("cursor_4c_BuscaMoe")
                        USE IN cursor_4c_BuscaMoe
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.TxtMoedaLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
            loc_oPg2P1.txt_4c_Moeda.Refresh
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCommand12Click - Abre dialogo de selecao de arquivo XML
    *--------------------------------------------------------------------------
    PROCEDURE CmdCommand12Click()
        LOCAL loc_oPg2P1, loc_cArquivo
        loc_oPg2P1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cArquivo = GETFILE("XML", "Selecionar arquivo XML", "Selecionar")

        IF !EMPTY(loc_cArquivo) AND PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
            loc_oPg2P1.txt_4c_Arquivo.Value = loc_cArquivo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdBotConsultaClick - Abre consulta generica de vendas para a conta
    *--------------------------------------------------------------------------
    PROCEDURE CmdBotConsultaClick()
        LOCAL loc_oPg2P1, loc_cConta, loc_oErro
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
            RETURN
        ENDIF

        loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)

        IF EMPTY(loc_cConta)
            MsgAviso("Informe a conta antes de acessar a consulta.", "Aviso")
            RETURN
        ENDIF

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            TRY
                DO FORM FormSigOpCgv WITH THIS, loc_cConta
            CATCH TO loc_oErro
                MsgErro("Erro ao abrir consulta gen" + CHR(233) + "rica: " + ;
                        loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdBtnCadastrosClick - Abre cadastro do fornecedor
    *--------------------------------------------------------------------------
    PROCEDURE CmdBtnCadastrosClick()
        LOCAL loc_oPg2P1, loc_cConta, loc_oErro
        loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
            RETURN
        ENDIF

        loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)

        IF EMPTY(loc_cConta)
            MsgAviso("Informe a conta antes de acessar o cadastro.", "Dados Incompletos")
            RETURN
        ENDIF

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "VISUALIZAR")
            TRY
                DO FORM FormSigCdCli WITH loc_cConta
            CATCH TO loc_oErro
                MsgErro("Erro ao abrir cadastro: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdOperacaoClick - Abre movimentacao para o registro selecionado no grdEstoque
    *--------------------------------------------------------------------------
    PROCEDURE CmdOperacaoClick()
        LOCAL loc_cDopes, loc_cNumes, loc_cEmps, loc_cSQL, loc_nResult, loc_oErro

        IF !USED("cursor_4c_Pendentes") OR EOF("cursor_4c_Pendentes") OR ;
           RECCOUNT("cursor_4c_Pendentes") = 0
            MsgAviso("Selecione uma movimenta" + CHR(231) + CHR(227) + "o na grade.", "Aviso")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Pendentes
            loc_cEmps  = ALLTRIM(cursor_4c_Pendentes.Emps)
            loc_cDopes = ALLTRIM(cursor_4c_Pendentes.Dopes)
            loc_cNumes = ALLTRIM(cursor_4c_Pendentes.Numes)

            IF EMPTY(loc_cEmps) OR EMPTY(loc_cDopes) OR EMPTY(loc_cNumes)
                MsgAviso("Selecione um registro v" + CHR(225) + "lido na grade.", "Aviso")
                RETURN
            ENDIF

            loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE LTRIM(RTRIM(Dopes)) = " + ;
                       EscaparSQL(loc_cDopes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")

            IF loc_nResult >= 0 AND USED("cursor_4c_TmpOpe") AND ;
               RECCOUNT("cursor_4c_TmpOpe") > 0
                IF USED("cursor_4c_TmpOpe")
                    USE IN cursor_4c_TmpOpe
                ENDIF
                DO FORM FormSigMvExp WITH loc_cDopes, "C", loc_cNumes, loc_cEmps, .T.
            ELSE
                IF USED("cursor_4c_TmpOpe")
                    USE IN cursor_4c_TmpOpe
                ENDIF
                loc_cSQL = "SELECT Dopps FROM SigCdOpd WHERE LTRIM(RTRIM(Dopps)) = " + ;
                           EscaparSQL(loc_cDopes)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpd")
                IF loc_nResult >= 0 AND USED("cursor_4c_TmpOpd") AND ;
                   RECCOUNT("cursor_4c_TmpOpd") > 0
                    IF USED("cursor_4c_TmpOpd")
                        USE IN cursor_4c_TmpOpd
                    ENDIF
                    DO FORM FormSigMvExp WITH loc_cDopes, "C", loc_cNumes, loc_cEmps, .T.
                ELSE
                    IF USED("cursor_4c_TmpOpd")
                        USE IN cursor_4c_TmpOpd
                    ENDIF
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                             "o encontrada no cadastro.", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.CmdOperacaoClick:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdProcessarClick - Processa arquivo XML: parse, busca estoque, filtra e
    *   muda para Page2 do inner PageFrame para exibir resultados
    *--------------------------------------------------------------------------
    PROCEDURE CmdProcessarClick()
        LOCAL loc_oPg2P1, loc_oPgDados, loc_cArquivo, loc_cConta, loc_cCpf
        LOCAL loc_cCpfLimpo, loc_cStr, loc_cChaveNFe, loc_cCNPJXML, loc_cMsg
        LOCAL loc_cSQL, loc_nResult, loc_cListaOriDopNums, loc_nTipo, loc_oErro

        loc_oPg2P1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados

        IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
            RETURN
        ENDIF

        loc_cArquivo = ALLTRIM(loc_oPg2P1.txt_4c_Arquivo.Value)
        loc_cConta   = IIF(PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5), ;
                           ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value), "")
        loc_cCpf     = IIF(PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf",   5), ;
                           ALLTRIM(loc_oPg2P1.txt_4c_Cpf.Value),   "")

        IF EMPTY(loc_cArquivo)
            MsgAviso("Nenhum diret" + CHR(243) + "rio foi informado.", "Aviso")
            RETURN
        ENDIF

        IF EMPTY(loc_cConta)
            MsgAviso("Nenhum fornecedor foi informado.", "Aviso")
            RETURN
        ENDIF

        IF EMPTY(loc_cCpf)
            MsgAviso("CNPJ/CPF do fornecedor n" + CHR(227) + "o informado.", "Aviso")
            RETURN
        ENDIF

        IF !FILE(loc_cArquivo)
            MsgAviso("Arquivo n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cArquivo, "Aviso")
            RETURN
        ENDIF

        LOCAL loc_lAbortou
        loc_lAbortou = .F.

        TRY
            *-- Compara CNPJ do XML com CNPJ do fornecedor
            loc_cCpfLimpo  = STRTRAN(STRTRAN(STRTRAN(loc_cCpf, ".", ""), "-", ""), "/", "")
            loc_cStr       = UPPER(FILETOSTR(loc_cArquivo))
            loc_cChaveNFe  = ALLTRIM(STREXTRACT(loc_cStr, "<CHNFE>", "</CHNFE>"))
            IF !EMPTY(loc_cChaveNFe)
                loc_cCNPJXML = SUBSTR(loc_cChaveNFe, 7, 14)
                IF loc_cCNPJXML != loc_cCpfLimpo
                    loc_cMsg = "Fornecedor com CPF/CNPJ diferente do XML." + CHR(13) + ;
                               "XML      : " + loc_cCNPJXML + CHR(13) + ;
                               "Cadastro : " + loc_cCpfLimpo + CHR(13) + ;
                               "Deseja continuar?"
                    IF !MsgConfirma(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lAbortou = .T.
                    ENDIF
                ENDIF
            ENDIF

            *-- Passo 1: parse XML -> cursor_4c_Itens
            IF !loc_lAbortou
                IF !THIS.ProcessarArquivoXML(loc_cArquivo)
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            *-- Passo 2: lookup produtos em SigCdPro -> cursor_4c_Distribui
            IF !loc_lAbortou
                THIS.CarregarItensXML()
            ENDIF

            *-- Passo 3: monta lista de OriDopNums das movimentacoes para IN clause
            IF !loc_lAbortou
                loc_cListaOriDopNums = ""
                IF USED("cursor_4c_Pendentes") AND RECCOUNT("cursor_4c_Pendentes") > 0
                    SELECT cursor_4c_Pendentes
                    GO TOP
                    SCAN
                        loc_cListaOriDopNums = loc_cListaOriDopNums + ;
                            IIF(EMPTY(loc_cListaOriDopNums), "", ",") + ;
                            EscaparSQL(ALLTRIM(cursor_4c_Pendentes.OriDopNums))
                    ENDSCAN
                ENDIF
            ENDIF

            *-- Passo 4: busca estoque de distribuicao via SigMvItn
            *-- SQLEXEC em cursor temporario para nao destruir colunas de grd_4c_Disponivel
            IF !loc_lAbortou AND !EMPTY(loc_cListaOriDopNums)
                loc_cSQL = "SELECT a.Cpros, f.Dpros, a.Units," + ;
                           " SUM(a.Qtds) AS Qtds, SUM(a.QtBaixas) AS QtBaixas," + ;
                           " SUM(a.QtReservas) AS QtReservas," + ;
                           " (SUM(a.Qtds) - SUM(a.QtBaixas) - SUM(a.QtReservas)) AS Saldo," + ;
                           " a.EmpDopNums AS OriDopNums, f.Cgrus, f.Sgrus," + ;
                           " a.CidChaves, a.Moedas" + ;
                           " FROM SigMvItn a" + ;
                           " JOIN SigMvCab c ON a.EmpDopNums = c.EmpDopNums" + ;
                           " JOIN SigCdOpe d ON c.Dopes = d.Dopes" + ;
                           " JOIN SigOpCdd e ON d.Dopes = e.Dopes" + ;
                           " JOIN SigCdPro f ON a.Cpros = f.Cpros" + ;
                           " WHERE e.Distribui = 3" + ;
                           " AND c.GrupoOs <> SPACE(10) AND c.ContaOs <> SPACE(10)" + ;
                           " AND a.CItem2 = 0 AND a.Qtds <> a.QtBaixas" + ;
                           " AND a.EmpDopNums IN (" + loc_cListaOriDopNums + ")" + ;
                           " GROUP BY a.Cpros, f.Dpros, f.Cgrus, f.Sgrus," + ;
                           "   a.EmpDopNums, a.Units, a.CidChaves, a.Moedas"
                IF USED("cursor_4c_MovTmp")
                    USE IN cursor_4c_MovTmp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MovTmp")
                IF loc_nResult < 0
                    MsgErro("Erro ao buscar movimentos: " + CapturarErroSQL(), "Erro SQL")
                    loc_lAbortou = .T.
                ELSE
                    IF USED("cursor_4c_Movimentos")
                        SELECT cursor_4c_Movimentos
                        ZAP
                        APPEND FROM DBF("cursor_4c_MovTmp")
                    ELSE
                        SELECT * FROM cursor_4c_MovTmp INTO CURSOR cursor_4c_Movimentos READWRITE
                    ENDIF
                    IF USED("cursor_4c_MovTmp")
                        USE IN cursor_4c_MovTmp
                    ENDIF
                    GO TOP IN cursor_4c_Movimentos
                ENDIF
            ENDIF

            IF !loc_lAbortou AND EMPTY(loc_cListaOriDopNums)
                loc_cListaOriDopNums = ""  && keep var in scope
                IF !USED("cursor_4c_Movimentos")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Movimentos ;
                        ( Cpros C(14), Dpros C(30), Units N(12,4), ;
                          Qtds N(12,2), QtBaixas N(12,2), QtReservas N(12,2), Saldo N(12,2), ;
                          OriDopNums C(29), Cgrus C(10), Sgrus C(10), ;
                          CidChaves C(20), Moedas C(3) )
                    SET NULL OFF
                ELSE
                    ZAP IN cursor_4c_Movimentos
                ENDIF
            ENDIF

            *-- Passo 5: aplica filtro Opt_Fil
            loc_nTipo = 3
            IF PEMSTATUS(loc_oPg2P1, "opt_4c_Fil", 5)
                loc_nTipo = loc_oPg2P1.opt_4c_Fil.Value
            ENDIF

            IF loc_nTipo != 3 AND USED("cursor_4c_Distribui") AND ;
               RECCOUNT("cursor_4c_Distribui") > 0 AND ;
               USED("cursor_4c_Movimentos") AND RECCOUNT("cursor_4c_Movimentos") > 0
                IF USED("cursor_4c_MovFiltro")
                    USE IN cursor_4c_MovFiltro
                ENDIF
                IF loc_nTipo = 1
                    SELECT * FROM cursor_4c_Movimentos ;
                        WHERE Cpros IN (SELECT Cpros FROM cursor_4c_Distribui) ;
                        INTO CURSOR cursor_4c_MovFiltro READWRITE
                ELSE
                    SELECT * FROM cursor_4c_Movimentos ;
                        WHERE Cpros NOT IN (SELECT Cpros FROM cursor_4c_Distribui) ;
                        INTO CURSOR cursor_4c_MovFiltro READWRITE
                ENDIF
                IF USED("cursor_4c_Movimentos")
                    USE IN cursor_4c_Movimentos
                ENDIF
                IF USED("cursor_4c_MovFiltro")
                    SELECT * FROM cursor_4c_MovFiltro ;
                        INTO CURSOR cursor_4c_Movimentos READWRITE
                    USE IN cursor_4c_MovFiltro
                    GO TOP IN cursor_4c_Movimentos
                ENDIF
            ENDIF

            *-- Passo 6: vincula grids de Page2 e muda para ela
            IF USED("cursor_4c_Movimentos") AND PEMSTATUS(loc_oPgDados.Page2, "grd_4c_Disponivel", 5)
                loc_oPgDados.Page2.grd_4c_Disponivel.RecordSourceType = 1
                loc_oPgDados.Page2.grd_4c_Disponivel.ColumnCount = 7
                loc_oPgDados.Page2.grd_4c_Disponivel.RecordSource = "cursor_4c_Movimentos"
                WITH loc_oPgDados.Page2.grd_4c_Disponivel
                    .Column1.ControlSource = "cursor_4c_Movimentos.Cpros"
                    .Column2.ControlSource = "cursor_4c_Movimentos.Dpros"
                    .Column3.ControlSource = "cursor_4c_Movimentos.Units"
                    .Column4.ControlSource = "cursor_4c_Movimentos.Qtds"
                    .Column5.ControlSource = "cursor_4c_Movimentos.QtBaixas"
                    .Column6.ControlSource = "cursor_4c_Movimentos.QtReservas"
                    .Column7.ControlSource = "cursor_4c_Movimentos.Saldo"
                ENDWITH
            ENDIF
            IF USED("cursor_4c_Distribui") AND PEMSTATUS(loc_oPgDados.Page2, "grd_4c_ItemXml", 5)
                loc_oPgDados.Page2.grd_4c_ItemXml.RecordSourceType = 1
                loc_oPgDados.Page2.grd_4c_ItemXml.ColumnCount = 4
                loc_oPgDados.Page2.grd_4c_ItemXml.RecordSource = "cursor_4c_Distribui"
                WITH loc_oPgDados.Page2.grd_4c_ItemXml
                    .Column1.ControlSource = "cursor_4c_Distribui.Cpros"
                    .Column2.ControlSource = "cursor_4c_Distribui.Dpros"
                    .Column3.ControlSource = "cursor_4c_Distribui.Qtds"
                    .Column4.ControlSource = "cursor_4c_Distribui.Total"
                ENDWITH
            ENDIF
            IF PEMSTATUS(loc_oPgDados.Page2, "txt_4c_Sistema", 5)
                loc_oPgDados.Page2.txt_4c_Sistema.Value = "Sistema"
            ENDIF
            IF PEMSTATUS(loc_oPgDados.Page2, "txt_4c_Arquivo", 5)
                loc_oPgDados.Page2.txt_4c_Arquivo.Value = "Arquivo"
            ENDIF
            IF PEMSTATUS(loc_oPgDados, "ActivePage", 5)
                loc_oPgDados.ActivePage = 2
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.CmdProcessarClick:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarArquivoXML - Carrega NFe XML e extrai itens para cursor_4c_Itens
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarArquivoXML(par_cArquivo)
        LOCAL loc_lResultado, loc_oXML, loc_nItems, loc_i, loc_oNode, loc_oErro
        loc_lResultado = .F.

        IF EMPTY(par_cArquivo) OR !FILE(par_cArquivo)
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Itens ;
                ( codigo C(15), Descr C(60), quant C(15), valor_uni C(15), ;
                  valor_tot C(15), unid C(5), cfop C(4), ncm C(8), ;
                  desconto C(15), frete C(15) )
            SET NULL OFF

            loc_oXML = CREATEOBJECT("MSXML2.DOMDocument")
            IF VARTYPE(loc_oXML) != "O"
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel criar objeto MSXML2.DOMDocument.", "Erro COM")
            ELSE
                loc_oXML.async = .F.
                WAIT WINDOW "Carregando: " + JUSTFNAME(par_cArquivo) NOWAIT

                IF !loc_oXML.Load(par_cArquivo)
                    MsgErro(JUSTFNAME(par_cArquivo) + " est" + CHR(225) + ;
                            " corrompido.", "Erro XML")
                    WAIT CLEAR
                ELSE
                    IF UPPER(loc_oXML.documentElement.baseName) != "NFEPROC"
                    MsgErro(JUSTFNAME(par_cArquivo) + " n" + CHR(227) + "o " + ;
                            CHR(233) + " uma NF-e com autoriza" + CHR(231) + ;
                            CHR(227) + "o!", "Formato Inv" + CHR(225) + "lido")
                    WAIT CLEAR
                ELSE
                    loc_nItems = loc_oXML.SelectNodes("//nfeProc/NFe/infNFe/det").Length
                    FOR loc_i = 0 TO loc_nItems - 1
                        loc_oNode = loc_oXML.SelectNodes("//nfeProc/NFe/infNFe/det").Item(loc_i)
                        APPEND BLANK IN cursor_4c_Itens
                        REPLACE codigo    WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/cProd")), 15) ;
                                IN cursor_4c_Itens
                        REPLACE Descr     WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/xProd")), 60) ;
                                IN cursor_4c_Itens
                        REPLACE quant     WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/qCom")),  15) ;
                                IN cursor_4c_Itens
                        REPLACE valor_uni WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vUnCom")),15) ;
                                IN cursor_4c_Itens
                        REPLACE valor_tot WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vProd")), 15) ;
                                IN cursor_4c_Itens
                        REPLACE unid      WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/uCom")),   5) ;
                                IN cursor_4c_Itens
                        REPLACE cfop      WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/CFOP")),   4) ;
                                IN cursor_4c_Itens
                        REPLACE ncm       WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/NCM")),    8) ;
                                IN cursor_4c_Itens
                        IF loc_oNode.SelectNodes("prod/vDesc").Length > 0
                            REPLACE desconto WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vDesc")), 15) ;
                                    IN cursor_4c_Itens
                        ENDIF
                        IF loc_oNode.SelectNodes("prod/vFrete").Length > 0
                            REPLACE frete WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vFrete")), 15) ;
                                    IN cursor_4c_Itens
                        ENDIF
                        SELECT cursor_4c_Itens
                    ENDFOR

                    WAIT CLEAR
                    GO TOP IN cursor_4c_Itens
                    loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro("Erro em FormSigPrCtr.ProcessarArquivoXML:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItensXML - Lookup de cada item do XML em SigCdPro (por Reffs,
    *   Cpros, Dpros, DPro2s); constroi cursor_4c_Distribui com produtos encontrados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarItensXML()
        LOCAL loc_cCodigo, loc_nQtd, loc_nVal, loc_nTot, loc_cSQL, loc_nResult, loc_oErro

        IF USED("cursor_4c_Distribui")
            USE IN cursor_4c_Distribui
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Distribui ;
            ( Cpros C(14), Dpros C(30), Qtds N(12,2), Units N(12,4), Total N(14,2) )
        SET NULL OFF

        IF !USED("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Itens
            GO TOP

            SCAN
                loc_cCodigo = ALLTRIM(cursor_4c_Itens.codigo)
                loc_nQtd    = VAL(ALLTRIM(cursor_4c_Itens.quant))
                loc_nVal    = VAL(ALLTRIM(cursor_4c_Itens.valor_uni))
                loc_nTot    = VAL(ALLTRIM(cursor_4c_Itens.valor_tot))

                IF !EMPTY(loc_cCodigo)
                    IF USED("cursor_4c_ProdImport")
                        USE IN cursor_4c_ProdImport
                    ENDIF

                    loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
                               " WHERE Reffs = " + EscaparSQL(loc_cCodigo)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")

                    IF loc_nResult < 0 OR !USED("cursor_4c_ProdImport") OR ;
                       RECCOUNT("cursor_4c_ProdImport") = 0
                        IF USED("cursor_4c_ProdImport")
                            USE IN cursor_4c_ProdImport
                        ENDIF
                        loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
                                   " WHERE Cpros = " + EscaparSQL(loc_cCodigo)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
                    ENDIF

                    IF loc_nResult < 0 OR !USED("cursor_4c_ProdImport") OR ;
                       RECCOUNT("cursor_4c_ProdImport") = 0
                        IF USED("cursor_4c_ProdImport")
                            USE IN cursor_4c_ProdImport
                        ENDIF
                        loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
                                   " WHERE Dpros = " + EscaparSQL(loc_cCodigo)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
                    ENDIF

                    IF loc_nResult < 0 OR !USED("cursor_4c_ProdImport") OR ;
                       RECCOUNT("cursor_4c_ProdImport") = 0
                        IF USED("cursor_4c_ProdImport")
                            USE IN cursor_4c_ProdImport
                        ENDIF
                        loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
                                   " WHERE DPro2s = " + EscaparSQL(loc_cCodigo)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
                    ENDIF

                    IF USED("cursor_4c_ProdImport") AND RECCOUNT("cursor_4c_ProdImport") > 0
                        SELECT cursor_4c_Distribui
                        APPEND BLANK
                        REPLACE Cpros WITH LEFT(ALLTRIM(cursor_4c_ProdImport.Cpros), 14), ;
                                Dpros WITH LEFT(ALLTRIM(cursor_4c_ProdImport.Dpros), 30), ;
                                Qtds  WITH loc_nQtd, ;
                                Units WITH loc_nVal, ;
                                Total WITH loc_nTot
                    ENDIF

                    IF USED("cursor_4c_ProdImport")
                        USE IN cursor_4c_ProdImport
                    ENDIF
                ENDIF

                SELECT cursor_4c_Itens
            ENDSCAN

            IF USED("cursor_4c_Distribui")
                GO TOP IN cursor_4c_Distribui
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.CarregarItensXML:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    *   Chama BO e vincula grd_4c_Estoque com dados de movimentacao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarMovimentosPendentes(par_cConta, par_lFiltrar)
        LOCAL loc_oPg2P1, loc_oGrid, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF THIS.this_oBusinessObject.BuscarMovimentosPendentes(par_cConta, par_lFiltrar)
                loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                IF PEMSTATUS(loc_oPg2P1, "grd_4c_Estoque", 5)
                    loc_oGrid = loc_oPg2P1.grd_4c_Estoque
                    loc_oGrid.ColumnCount = 5
                    loc_oGrid.RecordSource = "cursor_4c_Pendentes"
                    WITH loc_oGrid
                        .Column1.ControlSource = "cursor_4c_Pendentes.Emps"
                        .Column2.ControlSource = "cursor_4c_Pendentes.Dopes"
                        .Column3.ControlSource = "cursor_4c_Pendentes.Numes"
                        .Column4.ControlSource = "cursor_4c_Pendentes.Grupos"
                        .Column5.ControlSource = "cursor_4c_Pendentes.Contas"
                    ENDWITH
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.CarregarMovimentosPendentes:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterNodeValue - Retorna o texto de um no XML filho de par_oParent
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterNodeValue(par_oParent, par_cXPath)
        LOCAL loc_oNode, loc_cResult, loc_oErro
        loc_cResult = ""

        TRY
            IF VARTYPE(par_oParent) = "O" AND !ISNULL(par_oParent)
                loc_oNode = par_oParent.SelectSingleNode(par_cXPath)
                IF VARTYPE(loc_oNode) = "O" AND !ISNULL(loc_oNode)
                    loc_cResult = NVL(loc_oNode.Text, "")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao ler n" + CHR(243) + "XML '" + par_cXPath + ;
                    "': " + loc_oErro.Message, "Erro XML")
            loc_cResult = ""
        ENDTRY

        RETURN loc_cResult
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDadosDetalhe - Controles do pgf_4c_Dados.Page2 (Detalhe)
    * grdDisponivel (7 colunas), grdItemXml (4 colunas), campos produto
    * Offset +29 em Top para compensar tab oculta do inner PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDadosDetalhe()
        LOCAL loc_oPg2P2
        loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        *-- Shape5: borda ao redor da imagem (top=1+29=30)
        loc_oPg2P2.AddObject("shp_4c_Shape5", "Shape")
        WITH loc_oPg2P2.shp_4c_Shape5
            .Top = 30
            .Left = 424
            .Height = 113
            .Width = 282
            .BackStyle = 0
            .BorderStyle = 1
            .BorderWidth = 2
            .SpecialEffect = 0
            .Visible = .T.
        ENDWITH

        *-- Imagem produto FigJpg / img_4c_FigJpg (top=3+29=32)
        loc_oPg2P2.AddObject("img_4c_FigJpg", "Image")
        WITH loc_oPg2P2.img_4c_FigJpg
            .Stretch = 1
            .Top = 32
            .Left = 426
            .Width = 278
            .Height = 109
            .Visible = .F.
        ENDWITH
        BINDEVENT(loc_oPg2P2.img_4c_FigJpg, "DblClick", THIS, "ImgFigJpgDblClick")

        *-- Textboxes de cabecalho Sistema/Arquivo (top=113+29=142)
        loc_oPg2P2.AddObject("txt_4c_Sistema", "TextBox")
        WITH loc_oPg2P2.txt_4c_Sistema
            .FontBold = .T.
            .Alignment = 2
            .Top = 142
            .Left = 8
            .Width = 684
            .Height = 20
            .BackColor = RGB(128, 255, 255)
            .BackStyle = 1
            .ReadOnly = .T.
            .BorderStyle = 0
            .Value = "Sistema"
            .Visible = .T.
        ENDWITH

        loc_oPg2P2.AddObject("txt_4c_Arquivo", "TextBox")
        WITH loc_oPg2P2.txt_4c_Arquivo
            .FontBold = .T.
            .Alignment = 2
            .Top = 142
            .Left = 691
            .Width = 495
            .Height = 20
            .BackColor = RGB(255, 255, 128)
            .BackStyle = 1
            .ReadOnly = .T.
            .BorderStyle = 0
            .Value = "Arquivo"
            .Visible = .T.
        ENDWITH

        *-- Label procurar produto (top=74+29=103)
        loc_oPg2P2.AddObject("lbl_4c_Lbl_produto", "Label")
        WITH loc_oPg2P2.lbl_4c_Lbl_produto
            .Caption   = "Procurar Produto :"
            .AutoSize  = .T.
            .Top = 103
            .Left = 8
            .Height = 15
            .FontName  = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- TextBox busca produto / txt_4c__produto_inicial (top=90+29=119)
        loc_oPg2P2.AddObject("txt_4c__produto_inicial", "TextBox")
        WITH loc_oPg2P2.txt_4c__produto_inicial
            .Value = ""
            .MaxLength = 14
            .Format = "K!"
            .Top = 119
            .Left = 8
            .Width = 108
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2P2.txt_4c__produto_inicial, "KeyPress", THIS, "TxtProdutoInicialLostFocus")

        *-- Grid disponivel / grd_4c_Disponivel (7 colunas, top=134+29=163)
        loc_oPg2P2.AddObject("grd_4c_Disponivel", "Grid")
        loc_oPg2P2.grd_4c_Disponivel.ColumnCount = 7
        loc_oPg2P2.grd_4c_Disponivel.Top         = 163
        loc_oPg2P2.grd_4c_Disponivel.Left        = 8
        loc_oPg2P2.grd_4c_Disponivel.Width       = 684
        loc_oPg2P2.grd_4c_Disponivel.Height      = 344
        WITH loc_oPg2P2.grd_4c_Disponivel
            .FontName  = "Tahoma"
            .FontSize = 8
            .ReadOnly  = .T.
            .RecordMark = .F.
            .RowHeight = 17
            .Panel = 1
            .BackColor = RGB(237, 242, 243)
            .GridLineColor = RGB(238, 238, 238)
            .AllowHeaderSizing = .F.
            .AllowRowSizing = .F.
            .ScrollBars = 2
            .Visible = .T.

            WITH .Column1
                .Width = 100
                .Movable = .F.
                .Resizable = .F.
                .ReadOnly = .T.
                .ForeColor = RGB(0, 0, 255)
                .BackColor = RGB(237, 242, 243)
                .MousePointer = 15
                .FontBold = .T.
                .FontUnderline = .T.
                .Header1.Caption = "C" + CHR(243) + "digo"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Column2
                .Width = 235
                .Movable = .F.
                .Resizable = .F.
                .ReadOnly = .T.
                .BackColor = RGB(237, 242, 243)
                .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Column3
                .Width = 70
                .Movable = .F.
                .Resizable = .F.
                .ReadOnly = .T.
                .BackColor = RGB(237, 242, 243)
                .Header1.Caption = "Valor"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Column4
                .Width = 63
                .Movable = .F.
                .Resizable = .F.
                .ReadOnly = .T.
                .BackColor = RGB(237, 242, 243)
                .FontBold = .T.
                .Header1.Caption = "Quantidade"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Column5
                .Width = 63
                .Movable = .F.
                .Resizable = .F.
                .ReadOnly = .T.
                .BackColor = RGB(237, 242, 243)
                .FontBold = .T.
                .Header1.Caption = "Baixado"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Column6
                .Width = 63
                .Movable = .F.
                .Resizable = .F.
                .ReadOnly = .T.
                .BackColor = RGB(237, 242, 243)
                .FontBold = .T.
                .Header1.Caption = "Reservado"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Column7
                .Width = 63
                .Movable = .F.
                .Resizable = .F.
                .ReadOnly = .T.
                .BackColor = RGB(237, 242, 243)
                .FontBold = .T.
                .Header1.Caption = "Saldo"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "AfterRowColChange", THIS, "GrdDisponivelAfterRowColChange")
        BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "DblClick", THIS, "GrdDisponivelDblClick")

        *-- Grid XML / grd_4c_ItemXml (4 colunas, top=134+29=163)
        loc_oPg2P2.AddObject("grd_4c_ItemXml", "Grid")
        loc_oPg2P2.grd_4c_ItemXml.ColumnCount = 4
        loc_oPg2P2.grd_4c_ItemXml.Top         = 163
        loc_oPg2P2.grd_4c_ItemXml.Left        = 693
        loc_oPg2P2.grd_4c_ItemXml.Width       = 493
        loc_oPg2P2.grd_4c_ItemXml.Height      = 344
        WITH loc_oPg2P2.grd_4c_ItemXml
            .FontName  = "Tahoma"
            .FontSize = 8
            .RecordMark = .F.
            .Panel = 1
            .BackColor = RGB(237, 242, 243)
            .GridLineColor = RGB(238, 238, 238)
            .AllowHeaderSizing = .F.
            .AllowRowSizing = .F.
            .RowHeight = 17
            .Visible = .T.

            WITH .Column1
                .Width = 100
                .Movable = .F.
                .Resizable = .F.
                .ReadOnly = .T.
                .Enabled = .F.
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(237, 242, 243)
                .Header1.Caption = "C" + CHR(243) + "digo"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Column2
                .Width = 235
                .Movable = .F.
                .Resizable = .F.
                .ReadOnly = .T.
                .Enabled = .F.
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(237, 242, 243)
                .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Column3
                .Width = 63
                .Movable = .F.
                .Resizable = .F.
                .InputMask = "999999"
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(237, 242, 243)
                .Header1.Caption = "Quantidade"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Column4
                .Width = 70
                .Movable = .F.
                .Resizable = .F.
                .ReadOnly = .T.
                .Enabled = .F.
                .ForeColor = RGB(0, 0, 0)
                .BackColor = RGB(237, 242, 243)
                .Header1.Caption = "Valor"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Botao excluir Grade Sistema / cmd_4c_BtnExcluirSis (top=479+29=508)
        loc_oPg2P2.AddObject("cmd_4c_BtnExcluirSis", "CommandButton")
        WITH loc_oPg2P2.cmd_4c_BtnExcluirSis
            .Caption = ""
            .Themes = .F.
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Top = 508
            .Left = 663
            .Width = 40
            .Height = 37
            .ForeColor = RGB(255, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .ToolTipText = "Excluir Linha da Grade Sistema"
            .SpecialEffect = 0
            .TabStop = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2P2.cmd_4c_BtnExcluirSis, "Click", THIS, "BtnExcluirSisClick")

        *-- Botao excluir Grade Arquivo / cmd_4c_BtnExcluirArq (top=479+29=508)
        loc_oPg2P2.AddObject("cmd_4c_BtnExcluirArq", "CommandButton")
        WITH loc_oPg2P2.cmd_4c_BtnExcluirArq
            .Caption = ""
            .Themes = .F.
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Top = 508
            .Left = 1146
            .Width = 40
            .Height = 37
            .ForeColor = RGB(255, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .ToolTipText = "Excluir Linha da Grade Arquivo"
            .SpecialEffect = 0
            .TabStop = .F.
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPg2P2.cmd_4c_BtnExcluirArq, "Click", THIS, "BtnExcluirArqClick")

        *-- Label: Movimentacao (Say3, top=483+29=512)
        loc_oPg2P2.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg2P2.lbl_4c_Label3
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .AutoSize  = .T.
            .Top = 512
            .Left = 40
            .Height = 15
            .FontName  = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- getEmps (top=480+29=509)
        loc_oPg2P2.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPg2P2.txt_4c_Emps
            .Value = ""
            .Format = "K!"
            .ReadOnly = .T.
            .Top = 509
            .Left = 122
            .Width = 65
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
        ENDWITH

        *-- getDopes (top=480+29=509)
        loc_oPg2P2.AddObject("txt_4c_Dopes", "TextBox")
        WITH loc_oPg2P2.txt_4c_Dopes
            .Value = ""
            .MaxLength = 20
            .Format = "K!"
            .ReadOnly = .T.
            .Top = 509
            .Left = 188
            .Width = 205
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- getNumes (top=480+29=509)
        loc_oPg2P2.AddObject("txt_4c_Numes", "TextBox")
        WITH loc_oPg2P2.txt_4c_Numes
            .Value = ""
            .Format = "K!"
            .ReadOnly = .T.
            .Top = 509
            .Left = 393
            .Width = 65
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
        ENDWITH

        *-- getcIdChaves (top=480+29=509)
        loc_oPg2P2.AddObject("txt_4c_CIdChaves", "TextBox")
        WITH loc_oPg2P2.txt_4c_CIdChaves
            .Value = ""
            .MaxLength = 20
            .Format = "K!"
            .ReadOnly = .T.
            .Top = 509
            .Left = 459
            .Width = 173
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- Label: Ref. Fornecedor (top=505+29=534)
        loc_oPg2P2.AddObject("lbl_4c_Lbl_ref_fornecedor", "Label")
        WITH loc_oPg2P2.lbl_4c_Lbl_ref_fornecedor
            .Caption   = "Ref. Fornecedor :"
            .AutoSize  = .T.
            .Top = 534
            .Left = 30
            .Height = 15
            .FontName  = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- get_ref_fornecedor (top=502+29=531)
        loc_oPg2P2.AddObject("txt_4c__ref_fornecedor", "TextBox")
        WITH loc_oPg2P2.txt_4c__ref_fornecedor
            .Value = ""
            .MaxLength = 20
            .Format = "K!"
            .ReadOnly = .T.
            .Top = 531
            .Left = 122
            .Width = 190
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
        ENDWITH

        *-- Label: Custo (Say5, top=527+29=556)
        loc_oPg2P2.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg2P2.lbl_4c_Label5
            .Caption   = "Custo :"
            .AutoSize  = .T.
            .Top = 556
            .Left = 81
            .Height = 15
            .FontName  = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- get_precoMov (top=524+29=553)
        loc_oPg2P2.AddObject("txt_4c__precoMov", "TextBox")
        WITH loc_oPg2P2.txt_4c__precoMov
            .Value = 0
            .InputMask = "99,999.99999"
            .ReadOnly = .T.
            .Top = 553
            .Left = 122
            .Width = 108
            .Height = 21
            .Alignment = 3
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
        ENDWITH

        *-- Label: Preco Venda (top=549+29=578)
        loc_oPg2P2.AddObject("lbl_4c_Lbl_pr_venda", "Label")
        WITH loc_oPg2P2.lbl_4c_Lbl_pr_venda
            .Caption   = "Pre" + CHR(231) + "o Venda :"
            .AutoSize  = .T.
            .Top = 578
            .Left = 49
            .Height = 15
            .FontName  = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- get_pr_venda (top=546+29=575)
        loc_oPg2P2.AddObject("txt_4c__pr_venda", "TextBox")
        WITH loc_oPg2P2.txt_4c__pr_venda
            .Value = 0
            .InputMask = "99,999.99999"
            .ReadOnly = .T.
            .Top = 575
            .Left = 122
            .Width = 108
            .Height = 21
            .Alignment = 3
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
        ENDWITH

        *-- get_pr_venda_moeda (top=546+29=575)
        loc_oPg2P2.AddObject("txt_4c__pr_venda_moeda", "TextBox")
        WITH loc_oPg2P2.txt_4c__pr_venda_moeda
            .Value = ""
            .MaxLength = 3
            .Format = "K!"
            .ReadOnly = .T.
            .Top = 575
            .Left = 231
            .Width = 31
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
        ENDWITH

        *-- Label: Peso (Say1, top=550+29=579)
        loc_oPg2P2.AddObject("lbl_4c_Peso", "Label")
        WITH loc_oPg2P2.lbl_4c_Peso
            .Caption   = "Peso :"
            .AutoSize  = .T.
            .Top = 579
            .Left = 348
            .Height = 15
            .FontName  = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- get_peso_medio (top=547+29=576)
        loc_oPg2P2.AddObject("txt_4c__peso_medio", "TextBox")
        WITH loc_oPg2P2.txt_4c__peso_medio
            .Value = 0
            .InputMask = "99,999.999"
            .ReadOnly = .T.
            .Top = 576
            .Left = 383
            .Width = 75
            .Height = 21
            .Alignment = 3
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
        ENDWITH

        *-- Label: Preco Custo (Say2, top=571+29=600)
        loc_oPg2P2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg2P2.lbl_4c_Label2
            .Caption   = "Pre" + CHR(231) + "o Custo :"
            .AutoSize  = .T.
            .Top = 600
            .Left = 51
            .Height = 15
            .FontName  = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- get_custofs (top=568+29=597)
        loc_oPg2P2.AddObject("txt_4c__custofs", "TextBox")
        WITH loc_oPg2P2.txt_4c__custofs
            .Value = 0
            .InputMask = "99,999.99999"
            .ReadOnly = .T.
            .Top = 597
            .Left = 122
            .Width = 108
            .Height = 21
            .Alignment = 3
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
        ENDWITH

        *-- get_moecusfs (top=568+29=597)
        loc_oPg2P2.AddObject("txt_4c__moecusfs", "TextBox")
        WITH loc_oPg2P2.txt_4c__moecusfs
            .Value = ""
            .MaxLength = 3
            .Format = "K!"
            .ReadOnly = .T.
            .Top = 597
            .Left = 231
            .Width = 31
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
            .BackColor = RGB(255, 255, 255)
            .BackStyle = 1
        ENDWITH

        BINDEVENT(loc_oPg2P2, "Activate", THIS, "PgfDadosPage2Activate")
    ENDPROC

    *--------------------------------------------------------------------------
    * PgfDadosPage2Activate - Refresca grids ao ativar Page2 de detalhe
    *--------------------------------------------------------------------------
    PROCEDURE PgfDadosPage2Activate()
        LOCAL loc_oPg2P2, loc_oErro
        TRY
            loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
                loc_oPg2P2.grd_4c_Disponivel.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPg2P2, "grd_4c_ItemXml", 5)
                loc_oPg2P2.grd_4c_ItemXml.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.PgfDadosPage2Activate:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDisponivelAfterRowColChange - Ao mover linha em grd_4c_Disponivel:
    *   busca detalhes SigCdPro e popula campos inferiores + FigJpg
    *--------------------------------------------------------------------------
    PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg2P2, loc_cCpros, loc_cSQL, loc_nResult, loc_cArqTemp
        LOCAL loc_cFigJpgs, loc_cFoto, loc_lTemFig
        LOCAL loc_cMoeDetqs, loc_cMoeVenda, loc_nCotAlvo, loc_nCotVenda, loc_nValVenda
        LOCAL loc_lAbortou, loc_oErro
        loc_lAbortou = .F.

        TRY
            IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
                loc_lAbortou = .T.
            ENDIF

            IF !loc_lAbortou
                loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
                loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
                IF EMPTY(loc_cCpros)
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortou
                loc_cSQL = "SELECT a.cpros, a.reffs, a.pesoms, a.moecusfs, a.custofs," + ;
                           " a.pcuss, a.pvens, a.moevs, a.FigJpgs" + ;
                           " FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
                IF USED("cursor_4c_TmpPro")
                    USE IN cursor_4c_TmpPro
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
                IF loc_nResult < 0 OR !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortou
                SELECT cursor_4c_TmpPro
                GO TOP

                *-- Campos detalhe produto
                loc_oPg2P2.txt_4c__ref_fornecedor.Value = ALLTRIM(NVL(cursor_4c_TmpPro.reffs, ""))
                loc_oPg2P2.txt_4c__peso_medio.Value     = NVL(cursor_4c_TmpPro.pesoms, 0)
                loc_oPg2P2.txt_4c__moecusfs.Value       = ALLTRIM(NVL(cursor_4c_TmpPro.moecusfs, ""))
                loc_oPg2P2.txt_4c__custofs.Value        = NVL(cursor_4c_TmpPro.custofs, 0)
                loc_oPg2P2.txt_4c__precoMov.Value       = NVL(cursor_4c_TmpPro.pcuss, 0)
                loc_oPg2P2.txt_4c_CIdChaves.Value       = ALLTRIM(NVL(cursor_4c_Movimentos.CidChaves, ""))
                loc_oPg2P2.txt_4c_Emps.Value            = SUBSTR(cursor_4c_Movimentos.OriDopNums, 1, 3)
                loc_oPg2P2.txt_4c_Dopes.Value           = SUBSTR(cursor_4c_Movimentos.OriDopNums, 4, 20)
                loc_oPg2P2.txt_4c_Numes.Value           = ALLTRIM(RIGHT(cursor_4c_Movimentos.OriDopNums, 6))

                *-- Preco de venda: converte para moeda padrao se configurada
                loc_cMoeDetqs = ""
                IF USED("cursor_4c_TmpPam")
                    USE IN cursor_4c_TmpPam
                ENDIF
                IF SQLEXEC(gnConnHandle, "SELECT TOP 1 moedetqs FROM SigCdPam", "cursor_4c_TmpPam") > 0 ;
                   AND USED("cursor_4c_TmpPam") AND RECCOUNT("cursor_4c_TmpPam") > 0
                    loc_cMoeDetqs = ALLTRIM(NVL(cursor_4c_TmpPam.moedetqs, ""))
                    USE IN cursor_4c_TmpPam
                ENDIF

                IF EMPTY(loc_cMoeDetqs)
                    loc_oPg2P2.txt_4c__pr_venda.Value       = NVL(cursor_4c_TmpPro.pvens, 0)
                    loc_oPg2P2.txt_4c__pr_venda_moeda.Value = ALLTRIM(NVL(cursor_4c_TmpPro.moevs, ""))
                ELSE
                    loc_nCotAlvo  = 1
                    loc_nCotVenda = 1
                    IF USED("cursor_4c_TmpCot")
                        USE IN cursor_4c_TmpCot
                    ENDIF
                    IF SQLEXEC(gnConnHandle, "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + ;
                               EscaparSQL(loc_cMoeDetqs) + " ORDER BY datas DESC", ;
                               "cursor_4c_TmpCot") > 0 ;
                       AND USED("cursor_4c_TmpCot") AND RECCOUNT("cursor_4c_TmpCot") > 0
                        loc_nCotAlvo = NVL(cursor_4c_TmpCot.valos, 1)
                        USE IN cursor_4c_TmpCot
                    ENDIF
                    loc_cMoeVenda = ALLTRIM(NVL(cursor_4c_TmpPro.moevs, ""))
                    IF !EMPTY(loc_cMoeVenda)
                        IF USED("cursor_4c_TmpCot")
                            USE IN cursor_4c_TmpCot
                        ENDIF
                        IF SQLEXEC(gnConnHandle, "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + ;
                                   EscaparSQL(loc_cMoeVenda) + " ORDER BY datas DESC", ;
                                   "cursor_4c_TmpCot") > 0 ;
                           AND USED("cursor_4c_TmpCot") AND RECCOUNT("cursor_4c_TmpCot") > 0
                            loc_nCotVenda = NVL(cursor_4c_TmpCot.valos, 1)
                            USE IN cursor_4c_TmpCot
                        ENDIF
                    ENDIF
                    loc_nValVenda = ROUND(NVL(cursor_4c_TmpPro.pvens, 0) * loc_nCotVenda / ;
                                         IIF(loc_nCotAlvo = 0, 1, loc_nCotAlvo), 2)
                    loc_oPg2P2.txt_4c__pr_venda.Value       = loc_nValVenda
                    loc_oPg2P2.txt_4c__pr_venda_moeda.Value = loc_cMoeDetqs
                ENDIF

                *-- FigJpg: imagem do produto (base64 em SigCdPro.FigJpgs)
                loc_cFigJpgs = NVL(cursor_4c_TmpPro.FigJpgs, "")
                loc_lTemFig  = !EMPTY(loc_cFigJpgs) AND !ISNULL(cursor_4c_TmpPro.FigJpgs)
                loc_oPg2P2.img_4c_FigJpg.Visible = .F.
                loc_oPg2P2.img_4c_FigJpg.Picture = ""
                IF loc_lTemFig
                    loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
                    loc_cFoto = STRCONV(;
                        STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
                            "data:image/png;base64,", ""), ;
                            "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,", ""), 14)
                    STRTOFILE(loc_cFoto, loc_cArqTemp)
                    CLEAR RESOURCES
                    loc_oPg2P2.img_4c_FigJpg.Picture = loc_cArqTemp
                    loc_oPg2P2.img_4c_FigJpg.Visible = .T.
                ENDIF

                IF USED("cursor_4c_TmpPro")
                    USE IN cursor_4c_TmpPro
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.GrdDisponivelAfterRowColChange:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirSisClick - Delete linha corrente de cursor_4c_Movimentos
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirSisClick()
        LOCAL loc_oPg2P2, loc_oErro
        TRY
            IF USED("cursor_4c_Movimentos") AND !EOF("cursor_4c_Movimentos")
                SELECT cursor_4c_Movimentos
                DELETE
                IF !EOF("cursor_4c_Movimentos")
                    SKIP
                    SKIP -1
                ENDIF
                GO TOP IN cursor_4c_Movimentos
            ENDIF
            loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
                loc_oPg2P2.grd_4c_Disponivel.SetFocus()
                loc_oPg2P2.grd_4c_Disponivel.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.BtnExcluirSisClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirArqClick - Delete linha corrente de cursor_4c_Distribui
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirArqClick()
        LOCAL loc_oPg2P2, loc_oErro
        TRY
            IF USED("cursor_4c_Distribui") AND !EOF("cursor_4c_Distribui")
                SELECT cursor_4c_Distribui
                DELETE
                IF !EOF("cursor_4c_Distribui")
                    SKIP
                    SKIP -1
                ENDIF
                GO TOP IN cursor_4c_Distribui
            ENDIF
            loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            IF PEMSTATUS(loc_oPg2P2, "grd_4c_ItemXml", 5)
                loc_oPg2P2.grd_4c_ItemXml.SetFocus()
                loc_oPg2P2.grd_4c_ItemXml.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.BtnExcluirArqClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtProdutoInicialLostFocus - Localiza produto em cursor_4c_Movimentos
    *--------------------------------------------------------------------------
    PROCEDURE TxtProdutoInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2P2, loc_cValor, loc_nRecno, loc_oErro
        TRY
            loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            IF PEMSTATUS(loc_oPg2P2, "txt_4c__produto_inicial", 5)
                loc_cValor = ALLTRIM(loc_oPg2P2.txt_4c__produto_inicial.Value)
                IF !EMPTY(loc_cValor) AND USED("cursor_4c_Movimentos")
                    SELECT cursor_4c_Movimentos
                    loc_nRecno = RECNO()
                    GO TOP
                    LOCATE FOR ALLTRIM(cursor_4c_Movimentos.Cpros) = loc_cValor
                    IF EOF()
                        GO loc_nRecno
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.TxtProdutoInicialLostFocus:" + CHR(13) + ;
                    loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ImgFigJpgDblClick - Abre zoom da foto do produto (SigOpZom)
    *--------------------------------------------------------------------------
    PROCEDURE ImgFigJpgDblClick()
        LOCAL loc_oPg2P2, loc_cCpros, loc_cSQL, loc_nResult
        LOCAL loc_cFigJpgs, loc_cArqTemp, loc_cFoto, loc_cCaption, loc_oErro
        TRY
            IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
                RETURN
            ENDIF
            loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
            IF EMPTY(loc_cCpros)
                RETURN
            ENDIF
            loc_cSQL = "SELECT a.cpros, a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + ;
                       EscaparSQL(loc_cCpros)
            IF USED("cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
            IF loc_nResult < 0 OR !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
                RETURN
            ENDIF
            SELECT cursor_4c_TmpPro
            GO TOP
            loc_cFigJpgs = NVL(cursor_4c_TmpPro.FigJpgs, "")
            IF USED("cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF
            IF !EMPTY(loc_cFigJpgs) AND !ISNULL(loc_cFigJpgs)
                loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
                loc_cFoto = STRCONV(;
                    STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                STRTOFILE(loc_cFoto, loc_cArqTemp)
                IF FILE(loc_cArqTemp)
                    loc_cCaption = "Produto : " + loc_cCpros + " - " + ;
                                   ALLTRIM(NVL(cursor_4c_Movimentos.Dpros, ""))
                    IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") OR ;
                       FILE(gc_4c_CaminhoForms + "FormSigOpZom.prg")
                        DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") ;
                            WITH loc_cArqTemp, loc_cCaption, " "
                    ELSE
                        DECLARE INTEGER ShellExecute IN shell32.dll ;
                            INTEGER hWnd, STRING lpOperation, STRING lpFile, ;
                            STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
                        ShellExecute(0, "open", loc_cArqTemp, "", "", 1)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.ImgFigJpgDblClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDisponivelDblClick - Duplo clique em Col01 abre pesquisa global produto
    *--------------------------------------------------------------------------
    PROCEDURE GrdDisponivelDblClick()
        LOCAL loc_oPg2P2, loc_cCpros, loc_oErro
        TRY
            loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
                IF loc_oPg2P2.grd_4c_Disponivel.ActiveColumn # 1
                    RETURN
                ENDIF
            ENDIF
            IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
                RETURN
            ENDIF
            loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
            IF EMPTY(loc_cCpros)
                RETURN
            ENDIF
            IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpCgp.prg") OR ;
               FILE(gc_4c_CaminhoForms + "FormSigOpCgp.prg")
                DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpCgp.prg")
            ELSE
                MsgInfo("Produto: " + loc_cCpros + CHR(13) + ;
                        ALLTRIM(NVL(cursor_4c_Movimentos.Dpros, "")), "Produto")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.GrdDisponivelDblClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e fecha cursores
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF USED("cursor_4c_Movimentos")
                USE IN cursor_4c_Movimentos
            ENDIF

            IF USED("cursor_4c_Pendentes")
                USE IN cursor_4c_Pendentes
            ENDIF

            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF

            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            IF USED("cursor_4c_Distribui")
                USE IN cursor_4c_Distribui
            ENDIF

            IF USED("cursor_4c_TmpJoin")
                USE IN cursor_4c_TmpJoin
            ENDIF

            IF USED("cursor_4c_MovTmp")
                USE IN cursor_4c_MovTmp
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormSigPrCtr.Destroy:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCtrBO.prg):
*==============================================================================
* SigPrCtrBO.prg - Business Object para Controle de Movimentacoes por XML
* Tabela: SigPrCtr
* Herda de: BusinessBase
*
* Descricao: Gerencia lotes de distribuicao de produtos via XML.
*   Cada "Codigos" representa um lote que agrupa N linhas em SigPrCtr
*   (uma por produto distribuido). A exclusao/atualizacao opera por Codigos
*   (DELETE WHERE Codigos = ?), nao por PkChave.
*==============================================================================

DEFINE CLASS SigPrCtrBO AS BusinessBase

    *-- Chave primaria real da tabela (unica por linha)
    this_cPkChave    = ""  && char(20) - PRIMARY KEY
    *-- Chave de lote: identifica o conjunto de linhas do processamento
    this_cCodigos    = ""  && char(10) - identificador do lote
    *-- Campos do produto na linha
    this_cCodCors    = ""  && char(4)  - codigo da cor
    this_cCodTams    = ""  && char(4)  - codigo do tamanho
    this_cCpros      = ""  && char(14) - codigo do produto
    *-- Quantidades
    this_nQtds       = 0   && numeric(10,2) - quantidade XML
    this_nQtdOs      = 0   && numeric(10,2) - quantidade OS/distribuida
    *-- Referencia de origem
    this_cOriDopNums = ""  && char(29) - EmpDopNums da movimentacao de origem
    this_cFkChaves   = ""  && char(20) - cidchaves do item de movimentacao
    *-- Dados do fornecedor/conta
    this_cContas     = ""  && char(10) - codigo da conta/fornecedor
    *-- Opcoes de processamento
    this_nPrecific   = 0   && numeric(1,0) - tipo de precificacao (Opt_Custo)
    this_cMoedas     = ""  && char(3)  - codigo da moeda
    this_cArquivo    = ""  && char(200) - caminho do arquivo XML
    *-- Auditoria
    this_dDatas      = {}  && datetime - data/hora do processamento
    this_dDtAlts     = {}  && datetime - data/hora da ultima alteracao
    this_cUsuars     = ""  && char(10) - usuario que criou
    this_cUsualts    = ""  && char(10) - usuario da ultima alteracao

    *-- Campos operacionais do formulario (nao persistidos diretamente)
    this_cGrupo      = ""  && grupo contabil (Get_Grupo - GrPadFors de SigCdPam)
    this_cDconta     = ""  && descricao da conta (Get_Dconta)
    this_cCpf        = ""  && CPF/CNPJ do fornecedor (Get_cpf)

    *-- Filtro de data para a lista principal
    this_dDataInicial = {}
    this_dDataFinal   = {}

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela      = "SigPrCtr"
            THIS.this_cCampoChave  = "PkChave"
            THIS.this_dDataInicial = DATE()
            THIS.this_dDataFinal   = DATE()
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao inicializar SigPrCtrBO: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de lote para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Grava novo lote (delega para SalvarLote)
    *   Form deve popular cursor_4c_Linhas antes de chamar BusinessBase.Salvar()
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        RETURN THIS.SalvarLote("", .T.)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza lote existente (delega para SalvarLote)
    *   Form deve popular cursor_4c_Linhas antes de chamar BusinessBase.Salvar()
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        RETURN THIS.SalvarLote(THIS.this_cCodigos, .F.)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Seleciona lotes distintos de SigPrCtr filtrados por data
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cDataIni, loc_cDataFin, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cDataIni = FormatarDataSQL(THIS.this_dDataInicial)
            loc_cDataFin = FormatarDataSQL(THIS.this_dDataFinal)

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT DISTINCT a.Codigos, MAX(a.Datas) AS Datas," + ;
                       " a.OriDopNums, a.Usuars, a.Contas, b.Rclis" + ;
                       " FROM SigPrCtr a" + ;
                       " JOIN SigCdCli b ON b.Iclis = a.Contas" + ;
                       " WHERE a.Datas BETWEEN " + loc_cDataIni + ;
                       " AND " + loc_cDataFin + ;
                       " GROUP BY a.Codigos, a.OriDopNums, a.Usuars, a.Contas, b.Rclis"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " HAVING " + par_cFiltro
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar lotes: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega primeira linha de um lote pelo Codigos
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT * FROM SigPrCtr WHERE Codigos = " + EscaparSQL(par_cCodigos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                IF THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChave    = TratarNulo(PkChave,    "C")
                THIS.this_cCodigos    = TratarNulo(Codigos,    "C")
                THIS.this_cCodCors    = TratarNulo(CodCors,    "C")
                THIS.this_cCodTams    = TratarNulo(CodTams,    "C")
                THIS.this_cCpros      = TratarNulo(Cpros,      "C")
                THIS.this_nQtds       = TratarNulo(Qtds,       "N")
                THIS.this_nQtdOs      = TratarNulo(QtdOs,      "N")
                THIS.this_cOriDopNums = TratarNulo(OriDopNums, "C")
                THIS.this_cFkChaves   = TratarNulo(FkChaves,   "C")
                THIS.this_cContas     = TratarNulo(Contas,     "C")
                THIS.this_nPrecific   = TratarNulo(Precific,   "N")
                THIS.this_cMoedas     = TratarNulo(Moedas,     "C")
                THIS.this_cArquivo    = TratarNulo(Arquivo,    "C")
                THIS.this_dDatas      = TratarNulo(Datas,      "T")
                THIS.this_dDtAlts     = TratarNulo(DtAlts,     "T")
                THIS.this_cUsuars     = TratarNulo(Usuars,     "C")
                THIS.this_cUsualts    = TratarNulo(UsuAlts,    "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.CarregarDoCursor: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarMovimentosDistribuiveis - Produtos do lote para grdDisponivel (Page2)
    *--------------------------------------------------------------------------
    FUNCTION BuscarMovimentosDistribuiveis(par_cCodigos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Movimentos")
                USE IN cursor_4c_Movimentos
            ENDIF

            loc_cSQL = "SELECT a.Cpros, f.Dpros, a.Units," + ;
                       " SUM(a.Qtds) AS Qtds, SUM(a.QtBaixas) AS QtBaixas," + ;
                       " SUM(a.QtReservas) AS QtReservas," + ;
                       " (SUM(a.Qtds) - SUM(a.QtBaixas) - SUM(a.QtReservas)) AS Saldo," + ;
                       " SUM(g.QtdOs) AS QtdOs," + ;
                       " a.EmpDopNums AS OriDopNums, f.Cgrus, f.Sgrus," + ;
                       " a.CidChaves, a.Moedas" + ;
                       " FROM SigMvItn a" + ;
                       " JOIN SigMvCab c ON a.EmpDopNums = c.EmpDopNums" + ;
                       " JOIN SigCdOpe d ON c.Dopes = d.Dopes" + ;
                       " JOIN SigOpCdd e ON d.Dopes = e.Dopes" + ;
                       " JOIN SigCdPro f ON a.Cpros = f.Cpros" + ;
                       " JOIN SigPrCtr g ON a.EmpDopNums = g.OriDopNums" + ;
                       "   AND a.Cpros = g.Cpros AND g.FkChaves = a.CidChaves" + ;
                       " WHERE e.Distribui = 3" + ;
                       " AND c.GrupoDs <> SPACE(10)" + ;
                       " AND c.ContaDs <> SPACE(10)" + ;
                       " AND a.Qtds <> a.QtBaixas" + ;
                       " AND a.CItem2 = 0" + ;
                       " AND g.Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " GROUP BY a.Cpros, f.Dpros, f.Cgrus, f.Sgrus," + ;
                       "   a.EmpDopNums, a.Units, a.CidChaves, a.Moedas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Movimentos")
                TABLEREVERT(.T., "cursor_4c_Movimentos")
                USE IN cursor_4c_Movimentos
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Movimentos")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Movimentos")
                    GO TOP IN cursor_4c_Movimentos
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar movimentos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.BuscarMovimentosDistribuiveis: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    *   Retorna movimentacoes distribuiveis para grdEstoque (Page1)
    *   par_cConta   : filtra por fornecedor (vazio = todos)
    *   par_lFiltrar : .T. aplica filtro de conta
    *--------------------------------------------------------------------------
    FUNCTION BuscarMovimentosPendentes(par_cConta, par_lFiltrar)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cFiltro
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Pendentes")
                USE IN cursor_4c_Pendentes
            ENDIF

            loc_cFiltro = ""
            IF par_lFiltrar AND !EMPTY(ALLTRIM(par_cConta))
                loc_cFiltro = " AND a.ContaOs = " + EscaparSQL(par_cConta)
            ENDIF

            loc_cSQL = "SELECT 0 AS nMarca, a.Emps, a.Dopes, a.Numes," + ;
                       " a.EmpDopNums AS OriDopNums," + ;
                       " a.GrupoOs AS Grupos, a.ContaOs AS Contas" + ;
                       " FROM SigMvCab a" + ;
                       " JOIN SigCdOpe b ON a.Dopes = b.Dopes" + ;
                       " JOIN SigOpCdd c ON b.Dopes = c.Dopes" + ;
                       " WHERE c.Distribui = 3" + ;
                       " AND a.ChkSubn = 0" + ;
                       " AND a.GrupoOs <> SPACE(10)" + ;
                       " AND a.ContaOs <> SPACE(10)" + ;
                       loc_cFiltro

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Pendentes")
                TABLEREVERT(.T., "cursor_4c_Pendentes")
                USE IN cursor_4c_Pendentes
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pendentes")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Pendentes")
                    GO TOP IN cursor_4c_Pendentes
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar pendentes: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.BuscarMovimentosPendentes: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarLote - Persiste linhas de cursor_4c_Linhas no banco.
    *   Modo INSERIR (par_lNovoLote=.T.): gera novo Codigos, insere linhas
    *   Modo ALTERAR (par_lNovoLote=.F.): deleta lote antigo, insere novas linhas
    *
    *   cursor_4c_Linhas deve conter os campos:
    *     Cpros(C14), CodCors(C4), CodTams(C4), OriDopNums(C29),
    *     Qtds(N), QtdOs(N), Contas(C10), Arquivo(C200),
    *     Moedas(C3), Precific(N), FkChaves(C20)
    *--------------------------------------------------------------------------
    FUNCTION SalvarLote(par_cCodigos, par_lNovoLote)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cCodigos, loc_lScanOK
        loc_lResultado = .F.
        loc_cCodigos   = ""

        IF !USED("cursor_4c_Linhas") OR RECCOUNT("cursor_4c_Linhas") = 0
            MsgErro("Nenhuma linha para gravar no lote.", "Aviso")
            RETURN loc_lResultado
        ENDIF

        TRY
            loc_lResultado = .T.

            *-- Modo ALTERAR: exclui linhas do lote anterior antes de reinserir
            IF !par_lNovoLote AND !EMPTY(ALLTRIM(par_cCodigos))
                loc_cSQL   = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(par_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir lote anterior: " + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            *-- Modo INSERIR: gera novo Codigos sequencial
            IF loc_lResultado AND par_lNovoLote
                loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Codigos)) AS INT)), 0) + 1" + ;
                           " AS ProxCod FROM SigPrCtr"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_MaxCod")
                    TABLEREVERT(.T., "cursor_4c_MaxCod")
                    USE IN cursor_4c_MaxCod
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxCod")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_MaxCod") > 0
                    SELECT cursor_4c_MaxCod
                    loc_cCodigos = PADL(ALLTRIM(TRANSFORM(cursor_4c_MaxCod.ProxCod)), 10)
                    USE IN cursor_4c_MaxCod
                ELSE
                    MsgErro("Erro ao gerar codigo de lote: " + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            IF loc_lResultado AND !par_lNovoLote
                loc_cCodigos = par_cCodigos
            ENDIF

            *-- Insere cada linha do cursor no banco
            IF loc_lResultado
                SELECT cursor_4c_Linhas
                GO TOP
                loc_lScanOK = .T.
                SCAN WHILE loc_lScanOK
                    loc_cSQL = "INSERT INTO SigPrCtr" + ;
                               " (PkChave, Codigos, Cpros, CodCors, CodTams," + ;
                               "  OriDopNums, Qtds, QtdOs, Contas, Arquivo," + ;
                               "  Moedas, Precific, FkChaves, Datas, Usuars)" + ;
                               " VALUES (" + ;
                               " NEWID()," + ;
                               EscaparSQL(loc_cCodigos) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Cpros), 14)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.CodCors), 4)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.CodTams), 4)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.OriDopNums), 29)) + "," + ;
                               FormatarNumeroSQL(cursor_4c_Linhas.Qtds) + "," + ;
                               FormatarNumeroSQL(cursor_4c_Linhas.QtdOs) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Contas), 10)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Arquivo), 200)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Moedas), 3)) + "," + ;
                               FormatarNumeroSQL(cursor_4c_Linhas.Precific) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.FkChaves), 20)) + "," + ;
                               "GETDATE()," + ;
                               EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro("Erro ao inserir linha do lote: " + CapturarErroSQL(), "Erro SQL")
                        loc_lScanOK = .F.
                        EXIT
                    ENDIF

                    *-- Acumula reserva em SigMvItn (espelha logica legada Salva.Click)
                    IF !EMPTY(ALLTRIM(cursor_4c_Linhas.FkChaves)) AND cursor_4c_Linhas.QtdOs > 0
                        loc_cSQL = "UPDATE SigMvItn SET QtReservas = (QtReservas + " + ;
                                   FormatarNumeroSQL(cursor_4c_Linhas.QtdOs) + ")" + ;
                                   " WHERE CidChaves = " + ;
                                   EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.FkChaves), 20))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResult < 0
                            MsgErro("Erro ao atualizar reserva em SigMvItn: " + CapturarErroSQL(), "Erro SQL")
                            loc_lScanOK = .F.
                            EXIT
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_Linhas
                ENDSCAN

                loc_lResultado = loc_lScanOK
            ENDIF

            IF loc_lResultado
                THIS.this_cCodigos = loc_cCodigos
                THIS.RegistrarAuditoria(IIF(par_lNovoLote, "INSERT", "UPDATE"))
            ENDIF

        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.SalvarLote: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui todas as linhas do lote e restaura QtReservas.
    *   Chamado internamente por BusinessBase.Excluir()
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_lScanOK
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                MsgErro("Codigo do lote nao informado para exclusao.", "Aviso")
            ELSE
                *-- Carrega linhas para restaurar QtReservas em SigMvItn
                loc_cSQL = "SELECT FkChaves, QtdOs FROM SigPrCtr" + ;
                           " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ExclLote")
                    TABLEREVERT(.T., "cursor_4c_ExclLote")
                    USE IN cursor_4c_ExclLote
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExclLote")

                IF loc_nResult < 0
                    MsgErro("Erro ao carregar lote para exclusao: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    loc_lScanOK = .T.
                    IF USED("cursor_4c_ExclLote") AND RECCOUNT("cursor_4c_ExclLote") > 0
                        SELECT cursor_4c_ExclLote
                        GO TOP
                        SCAN WHILE loc_lScanOK
                            loc_cSQL = "UPDATE SigMvItn SET QtReservas =" + ;
                                       " CASE WHEN (QtReservas - " + ;
                                       FormatarNumeroSQL(cursor_4c_ExclLote.QtdOs) + ;
                                       ") < 0 THEN 0" + ;
                                       " ELSE (QtReservas - " + ;
                                       FormatarNumeroSQL(cursor_4c_ExclLote.QtdOs) + ")" + ;
                                       " END" + ;
                                       " WHERE CidChaves = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_ExclLote.FkChaves))

                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResult < 0
                                MsgErro("Erro ao restaurar QtReservas: " + CapturarErroSQL(), "Erro SQL")
                                loc_lScanOK = .F.
                                EXIT
                            ENDIF
                            SELECT cursor_4c_ExclLote
                        ENDSCAN
                        USE IN cursor_4c_ExclLote
                    ENDIF

                    IF loc_lScanOK
                        loc_cSQL = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResult < 0
                            MsgErro("Erro ao excluir lote: " + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            THIS.RegistrarAuditoria("DELETE")
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

