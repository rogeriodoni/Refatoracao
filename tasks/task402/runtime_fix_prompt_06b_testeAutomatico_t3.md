# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 3/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-01 10:08:56] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-01 10:08:56] [INFO] Config FPW: (nao fornecido)
[2026-08-01 10:08:56] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 10:08:56] [INFO] Timeout: 300 segundos
[2026-08-01 10:08:56] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0kg2vl0j.prg
[2026-08-01 10:08:56] [INFO] Conteudo do wrapper:
[2026-08-01 10:08:56] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormEmb', 'C:\4c\tasks\task402', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormEmb', 'C:\4c\tasks\task402', 'CRUD'
QUIT

[2026-08-01 10:08:56] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0kg2vl0j.prg
[2026-08-01 10:08:56] [INFO] VFP output esperado em: C:\4c\tasks\task402\vfp_output.txt
[2026-08-01 10:08:56] [INFO] Executando Visual FoxPro 9...
[2026-08-01 10:08:56] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0kg2vl0j.prg
[2026-08-01 10:08:56] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0kg2vl0j.prg
[2026-08-01 10:08:56] [INFO] Timeout configurado: 300 segundos
[2026-08-01 10:09:44] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-01 10:09:44] [INFO] VFP9 finalizado em 48.7123862 segundos
[2026-08-01 10:09:44] [INFO] Exit Code: 
[2026-08-01 10:09:44] [INFO] 
[2026-08-01 10:09:44] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-01 10:09:44] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0kg2vl0j.prg
[2026-08-01 10:09:44] [INFO] 
[2026-08-01 10:09:44] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-01 10:09:44] [INFO] * Auto-generated wrapper for parameters
[2026-08-01 10:09:44] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 10:09:44] [INFO] * Parameters: 'FormEmb', 'C:\4c\tasks\task402', 'CRUD'
[2026-08-01 10:09:44] [INFO] 
[2026-08-01 10:09:44] [INFO] * Anti-dialog protections for unattended execution
[2026-08-01 10:09:44] [INFO] SET SAFETY OFF
[2026-08-01 10:09:44] [INFO] SET RESOURCE OFF
[2026-08-01 10:09:44] [INFO] SET TALK OFF
[2026-08-01 10:09:44] [INFO] SET NOTIFY OFF
[2026-08-01 10:09:44] [INFO] SYS(2335, 0)
[2026-08-01 10:09:44] [INFO] 
[2026-08-01 10:09:45] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormEmb', 'C:\4c\tasks\task402', 'CRUD'
[2026-08-01 10:09:45] [INFO] QUIT
[2026-08-01 10:09:45] [INFO] 
[2026-08-01 10:09:45] [INFO] === Fim do Wrapper.prg ===
[2026-08-01 10:09:45] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-01 10:12:54] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-01 10:12:54] [INFO] Config FPW: (nao fornecido)
[2026-08-01 10:12:54] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 10:12:54] [INFO] Timeout: 300 segundos
[2026-08-01 10:12:54] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rplv10jv.prg
[2026-08-01 10:12:54] [INFO] Conteudo do wrapper:
[2026-08-01 10:12:54] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormEmb', 'C:\4c\tasks\task402', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormEmb', 'C:\4c\tasks\task402', 'CRUD'
QUIT

[2026-08-01 10:12:54] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rplv10jv.prg
[2026-08-01 10:12:54] [INFO] VFP output esperado em: C:\4c\tasks\task402\vfp_output.txt
[2026-08-01 10:12:54] [INFO] Executando Visual FoxPro 9...
[2026-08-01 10:12:54] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rplv10jv.prg
[2026-08-01 10:12:54] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rplv10jv.prg
[2026-08-01 10:12:54] [INFO] Timeout configurado: 300 segundos
[2026-08-01 10:13:49] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-01 10:13:49] [INFO] VFP9 finalizado em 54.1435286 segundos
[2026-08-01 10:13:49] [INFO] Exit Code: 
[2026-08-01 10:13:49] [INFO] 
[2026-08-01 10:13:49] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-01 10:13:49] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rplv10jv.prg
[2026-08-01 10:13:49] [INFO] 
[2026-08-01 10:13:49] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-01 10:13:49] [INFO] * Auto-generated wrapper for parameters
[2026-08-01 10:13:49] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 10:13:49] [INFO] * Parameters: 'FormEmb', 'C:\4c\tasks\task402', 'CRUD'
[2026-08-01 10:13:49] [INFO] 
[2026-08-01 10:13:49] [INFO] * Anti-dialog protections for unattended execution
[2026-08-01 10:13:49] [INFO] SET SAFETY OFF
[2026-08-01 10:13:49] [INFO] SET RESOURCE OFF
[2026-08-01 10:13:49] [INFO] SET TALK OFF
[2026-08-01 10:13:49] [INFO] SET NOTIFY OFF
[2026-08-01 10:13:49] [INFO] SYS(2335, 0)
[2026-08-01 10:13:49] [INFO] 
[2026-08-01 10:13:49] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormEmb', 'C:\4c\tasks\task402', 'CRUD'
[2026-08-01 10:13:49] [INFO] QUIT
[2026-08-01 10:13:49] [INFO] 
[2026-08-01 10:13:49] [INFO] === Fim do Wrapper.prg ===
[2026-08-01 10:13:49] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-01 10:18:39] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-01 10:18:39] [INFO] Config FPW: (nao fornecido)
[2026-08-01 10:18:39] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 10:18:39] [INFO] Timeout: 300 segundos
[2026-08-01 10:18:39] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ot2tjq4i.prg
[2026-08-01 10:18:39] [INFO] Conteudo do wrapper:
[2026-08-01 10:18:39] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormEmb', 'C:\4c\tasks\task402', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormEmb', 'C:\4c\tasks\task402', 'CRUD'
QUIT

[2026-08-01 10:18:39] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ot2tjq4i.prg
[2026-08-01 10:18:39] [INFO] VFP output esperado em: C:\4c\tasks\task402\vfp_output.txt
[2026-08-01 10:18:39] [INFO] Executando Visual FoxPro 9...
[2026-08-01 10:18:39] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ot2tjq4i.prg
[2026-08-01 10:18:39] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ot2tjq4i.prg
[2026-08-01 10:18:39] [INFO] Timeout configurado: 300 segundos
[2026-08-01 10:19:33] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-01 10:19:33] [INFO] VFP9 finalizado em 54.101726 segundos
[2026-08-01 10:19:33] [INFO] Exit Code: 
[2026-08-01 10:19:33] [INFO] 
[2026-08-01 10:19:33] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-01 10:19:33] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ot2tjq4i.prg
[2026-08-01 10:19:33] [INFO] 
[2026-08-01 10:19:33] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-01 10:19:33] [INFO] * Auto-generated wrapper for parameters
[2026-08-01 10:19:33] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 10:19:33] [INFO] * Parameters: 'FormEmb', 'C:\4c\tasks\task402', 'CRUD'
[2026-08-01 10:19:33] [INFO] 
[2026-08-01 10:19:33] [INFO] * Anti-dialog protections for unattended execution
[2026-08-01 10:19:33] [INFO] SET SAFETY OFF
[2026-08-01 10:19:33] [INFO] SET RESOURCE OFF
[2026-08-01 10:19:33] [INFO] SET TALK OFF
[2026-08-01 10:19:33] [INFO] SET NOTIFY OFF
[2026-08-01 10:19:33] [INFO] SYS(2335, 0)
[2026-08-01 10:19:33] [INFO] 
[2026-08-01 10:19:33] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormEmb', 'C:\4c\tasks\task402', 'CRUD'
[2026-08-01 10:19:33] [INFO] QUIT
[2026-08-01 10:19:33] [INFO] 
[2026-08-01 10:19:33] [INFO] === Fim do Wrapper.prg ===
[2026-08-01 10:19:33] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormEmb",
  "timestamp": "20260801101933",
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
      "passou": true,
      "erro": "",
      "detalhes": "Modo VISUALIZAR configurado"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormEmb.prg):
*==============================================================================
* FormEmb.PRG - Fase 6/8: Campos restantes Page2 (Preco + Peso)
* Formulario de Cadastro de Embalagens (SIGCDEMB)
*
* Tabela: SigCdEmb
* Tipo: CRUD (frmcadastro)
* BO: EmbBO
*
* Campos da tabela SigCdEmb:
*   cods   char(3)       NOT NULL - PK
*   descs  char(20)      NOT NULL
*   multis numeric(5,1)  NOT NULL
*   precos numeric(11,2) NOT NULL
*   pesos  numeric(11,2) NOT NULL
*
* Grid (Page1): Cods(75px), descs(297px), Pesos(107px)
* Dados (Page2): Codigo, Descricao, Multiplicador, Preco, Peso
*==============================================================================

DEFINE CLASS FormEmb AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY - Width/Height do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Embalagens"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmb.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Ajuste datasession: DataSession=2 reseta SET DATE/CENTURY (regra #9.4)
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.this_oBusinessObject = CREATEOBJECT("EmbBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar EmbBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.CarregarLista()

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmb.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1: cabecalho + botoes CRUD + grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho cinza (Top = 2 + 29 = 31, compensacao PageFrame.Top=-29)
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
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

        *-- Container botoes CRUD (canonico: Top=29, Left=542, Width=390)
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar
        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar
        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir
        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar
        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Left=917, Width=90)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid lista embalagens (Top = 88 + 29 = 117, compensacao PageFrame.Top=-29)
        *-- Colunas do legado: Cods(75), descs(297), Pesos(107)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 3
        WITH loc_oGrid
            .Top                = 117
            .Left               = 26
            .Width              = 880
            .Height             = 498
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .GridLines          = 3
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .RowHeight          = 16
            .ScrollBars         = 2
            .ReadOnly           = .T.
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2: cabecalho + botoes acao + campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oCab, loc_oBotoesAcao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container cabecalho cinza (Top = 2 + 29 = 31, compensacao PageFrame.Top=-29)
        loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg2.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
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

        *-- Container botoes Confirmar/Cancelar (Top = 4 + 29 = 33, canonico: Left=842, Width=160)
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oBotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Confirmar
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Cancelar
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label + TextBox: Codigo (getcods top=128+29=157, Say1 top=132+29=161)
        loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPg2.lbl_4c_Codigo
            .AutoSize  = .F.
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 161
            .Left      = 347
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPg2.txt_4c_Codigo
            .Value         = ""
            .Top           = 157
            .Left          = 392
            .Width         = 35
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .InputMask     = "!!!"
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox: Descricao (Getdescs top=155+29=184, Say2 top=159+29=188)
        loc_oPg2.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPg2.lbl_4c_Descricao
            .AutoSize  = .F.
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 188
            .Left      = 334
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPg2.txt_4c_Descricao
            .Value         = ""
            .Top           = 184
            .Left          = 392
            .Width         = 152
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 20
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox: Multiplicador (Getmultis top=182+29=211, Say3 top=186+29=215)
        loc_oPg2.AddObject("lbl_4c_Multiplicador", "Label")
        WITH loc_oPg2.lbl_4c_Multiplicador
            .AutoSize  = .F.
            .Caption   = "Multiplicador :"
            .Top       = 215
            .Left      = 321
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Multis", "TextBox")
        WITH loc_oPg2.txt_4c_Multis
            .Value         = 0
            .Top           = 211
            .Left          = 392
            .Width         = 67
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99999.9"
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox: Preco (GetPreco top=209+29=238, Say4 top=213+29=242)
        loc_oPg2.AddObject("lbl_4c_Preco", "Label")
        WITH loc_oPg2.lbl_4c_Preco
            .AutoSize  = .F.
            .Caption   = "Pre" + CHR(231) + "o :"
            .Top       = 242
            .Left      = 353
            .Width     = 36
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Preco", "TextBox")
        WITH loc_oPg2.txt_4c_Preco
            .Value         = 0
            .Top           = 238
            .Left          = 392
            .Width         = 132
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999,999,999.99"
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox: Peso (GetPeso top=236+29=265, Say5 top=240+29=269)
        loc_oPg2.AddObject("lbl_4c_Peso", "Label")
        WITH loc_oPg2.lbl_4c_Peso
            .AutoSize  = .F.
            .Caption   = "Peso :"
            .Top       = 269
            .Left      = 357
            .Width     = 32
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Peso", "TextBox")
        WITH loc_oPg2.txt_4c_Peso
            .Value         = 0
            .Top           = 265
            .Left          = 392
            .Width         = 132
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "9,999,999.999"
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no grid da Page1
    * Grid: cods(75), descs(297), pesos(107) ? conforme legado SIGCDEMB
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid, loc_lCursorOk
        loc_lResultado = .F.
        loc_lCursorOk  = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (cods C(3), descs C(20), multis N(5,1), precos N(11,2), pesos N(11,2))
                loc_lCursorOk = .T.
            ELSE
                loc_lCursorOk = THIS.this_oBusinessObject.Buscar("")
            ENDIF

            IF loc_lCursorOk
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- RecordSource e ColumnCount FORA de WITH (Problema 36)
                loc_oGrid.ColumnCount  = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.ColumnCount  = 3

                *-- ControlSource APOS RecordSource (Problema 48)
                *-- Header1.Caption RECONFIGURADO apos RecordSource (Problema 6/32)
                WITH loc_oGrid
                    .Column1.ControlSource   = "cursor_4c_Dados.cods"
                    .Column1.Width           = 75
                    .Column1.Header1.Caption = "C" + CHR(243) + "digo"

                    .Column2.ControlSource   = "cursor_4c_Dados.descs"
                    .Column2.Width           = 297
                    .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                    .Column3.ControlSource   = "cursor_4c_Dados.pesos"
                    .Column3.Width           = 107
                    .Column3.Header1.Caption = "Peso"
                ENDWITH

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmb.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.CarregarLista()
        ENDIF

        loc_lResultado = .T.

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
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
    * FormatarGridLista - Formata visual do grid de lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do Form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
        THIS.this_oBusinessObject.this_nMultis    = loc_oPg2.txt_4c_Multis.Value
        THIS.this_oBusinessObject.this_nPrecos    = loc_oPg2.txt_4c_Preco.Value
        THIS.this_oBusinessObject.this_nPesos     = loc_oPg2.txt_4c_Peso.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
        loc_oPg2.txt_4c_Multis.Value    = THIS.this_oBusinessObject.this_nMultis
        loc_oPg2.txt_4c_Preco.Value     = THIS.this_oBusinessObject.this_nPrecos
        loc_oPg2.txt_4c_Peso.Value      = THIS.this_oBusinessObject.this_nPesos
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value    = ""
        loc_oPg2.txt_4c_Descricao.Value = ""
        loc_oPg2.txt_4c_Multis.Value    = 0
        loc_oPg2.txt_4c_Preco.Value     = 0
        loc_oPg2.txt_4c_Peso.Value      = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme o modo
    * Codigo editavel apenas em INCLUIR (getcods When retorna .F. em ALTERAR/VISUALIZAR)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lEhIncluir
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_lEhIncluir = (THIS.this_cModoAtual == "INCLUIR")

        loc_oPg2.txt_4c_Codigo.Enabled    = par_lHabilitar AND loc_lEhIncluir
        loc_oPg2.txt_4c_Descricao.Enabled = par_lHabilitar
        loc_oPg2.txt_4c_Multis.Enabled    = par_lHabilitar
        loc_oPg2.txt_4c_Preco.Enabled     = par_lHabilitar
        loc_oPg2.txt_4c_Peso.Enabled      = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes Confirmar/Cancelar por modo
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEditando
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara form para inclusao de novo registro
    * Legado: Replace Multis with 1, navega para Dados, foco em Codigo
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"

        *-- Legado SIGCDEMB.Click INSERIR: Replace Multis with 1
        THIS.pgf_4c_Paginas.Page2.txt_4c_Multis.Value = 1

        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para alteracao
    * Legado: navega para Dados, foco em Descricao (Codigo read-only)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
        ELSE
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro!", "Alterar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro para visualizacao (somente leitura)
    * Legado: CONSULTAR navega para Dados, foco no botao Salva
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
        ELSE
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro!", "Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_cCodigo  = ""
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da embalagem '" + ;
                loc_cCodigo + "'?", "Excluir")
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Embalagem exclu" + CHR(237) + "da com sucesso!", "Excluir")
                    THIS.CarregarLista()
                    loc_lResultado = .T.
                ELSE
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir a embalagem!", "Excluir")
                ENDIF
            ELSE
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro!", "Excluir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmb.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre FormBuscaAuxiliar para buscar embalagem
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmb", "cursor_4c_Busca", "cods", "", ;
            "Buscar Embalagem")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("pesos", "", "Peso")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                SELECT cursor_4c_Busca
                loc_cCodigo = ALLTRIM(cursor_4c_Busca.cods)

                IF USED("cursor_4c_Dados") AND !EMPTY(loc_cCodigo)
                    SELECT cursor_4c_Dados
                    LOCATE FOR ALLTRIM(cods) == loc_cCodigo
                ENDIF
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida e salva o registro (Confirmar)
    * Legado: valida Codigo vazio + duplicata em INCLUIR, depois salva e volta
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oPg2, loc_cCodigo, loc_nChk
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)

        *-- Validacao 1: Codigo obrigatorio (Problema 16 - fora do TRY)
        IF EMPTY(loc_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!", "Validar")
            loc_oPg2.txt_4c_Codigo.SetFocus()
            RETURN
        ENDIF

        *-- Validacao 2: Descricao obrigatoria
        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descricao.Value))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                "o pode ficar em branco!", "Validar")
            loc_oPg2.txt_4c_Descricao.SetFocus()
            RETURN
        ENDIF

        *-- Validacao 3: Codigo ja cadastrado em INCLUIR (legado: ChkRegister)
        IF THIS.this_cModoAtual == "INCLUIR"
            loc_nChk = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS Total FROM SigCdEmb WHERE cods = " + ;
                EscaparSQL(loc_cCodigo), "cursor_4c_ChkEmb")
            IF loc_nChk > 0 AND USED("cursor_4c_ChkEmb") AND cursor_4c_ChkEmb.Total > 0
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!", "Validar")
                loc_oPg2.txt_4c_Codigo.SetFocus()
                IF USED("cursor_4c_ChkEmb")
                    USE IN cursor_4c_ChkEmb
                ENDIF
                RETURN
            ENDIF
            IF USED("cursor_4c_ChkEmb")
                USE IN cursor_4c_ChkEmb
            ENDIF
        ENDIF

        THIS.FormParaBO()

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Embalagem salva com sucesso!", "Salvar")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel salvar a embalagem!", "Salvar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmb.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\EmbBO.prg):
*==============================================================================
* EmbBO.prg - Business Object para Embalagens
* Tabela: SigCdEmb
* Herda de: BusinessBase
*
* Campos (schema.sql):
*   cods   char(3)        NOT NULL  - PK
*   descs  char(20)       NOT NULL
*   multis numeric(5,1)  NOT NULL
*   precos numeric(11,2) NOT NULL
*   pesos  numeric(11,2) NOT NULL
*==============================================================================

DEFINE CLASS EmbBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento 1:1 com colunas SigCdEmb)
    this_cCodigo    = ""  && cods char(3) - PK
    this_cDescricao = ""  && descs char(20)
    this_nMultis    = 0   && multis numeric(5,1)
    this_nPrecos    = 0   && precos numeric(11,2)
    this_nPesos     = 0   && pesos numeric(11,2)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdEmb"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna lista de embalagens (PUBLIC)
    * par_cFiltro: filtro opcional aplicado ao WHERE
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, multis, precos, pesos" + ;
                       " FROM SigCdEmb"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cods"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar embalagens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em EmbBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega embalagem pelo codigo (PUBLIC)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, multis, precos, pesos" + ;
                       " FROM SigCdEmb" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em EmbBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO (PUBLIC)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cods,   "C")
            THIS.this_cDescricao = TratarNulo(descs,  "C")
            THIS.this_nMultis    = TratarNulo(multis, "N")
            THIS.this_nPrecos    = TratarNulo(precos, "N")
            THIS.this_nPesos     = TratarNulo(pesos,  "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (PUBLIC)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdEmb (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdEmb (cods, descs, multis, precos, pesos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nMultis) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrecos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesos) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir embalagem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em EmbBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdEmb (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdEmb SET" + ;
                       " descs = "  + EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       " multis = " + FormatarNumeroSQL(THIS.this_nMultis) + ", " + ;
                       " precos = " + FormatarNumeroSQL(THIS.this_nPrecos) + ", " + ;
                       " pesos = "  + FormatarNumeroSQL(THIS.this_nPesos) + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar embalagem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em EmbBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdEmb (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdEmb WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir embalagem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em EmbBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

