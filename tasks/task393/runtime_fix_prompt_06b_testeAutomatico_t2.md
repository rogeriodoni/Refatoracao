# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[01/08/2026 01:41:35] Erro ao buscar: Connection handle is invalid.
[01/08/2026 01:41:35] Erro ao buscar: Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-01 01:38:01] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-01 01:38:01] [INFO] Config FPW: (nao fornecido)
[2026-08-01 01:38:01] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 01:38:01] [INFO] Timeout: 300 segundos
[2026-08-01 01:38:01] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_20gtbuer.prg
[2026-08-01 01:38:01] [INFO] Conteudo do wrapper:
[2026-08-01 01:38:01] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormDES', 'C:\4c\tasks\task393', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDES', 'C:\4c\tasks\task393', 'CRUD'
QUIT

[2026-08-01 01:38:01] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_20gtbuer.prg
[2026-08-01 01:38:01] [INFO] VFP output esperado em: C:\4c\tasks\task393\vfp_output.txt
[2026-08-01 01:38:01] [INFO] Executando Visual FoxPro 9...
[2026-08-01 01:38:01] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_20gtbuer.prg
[2026-08-01 01:38:01] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_20gtbuer.prg
[2026-08-01 01:38:01] [INFO] Timeout configurado: 300 segundos
[2026-08-01 01:38:47] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-01 01:38:47] [INFO] VFP9 finalizado em 46.2871415 segundos
[2026-08-01 01:38:47] [INFO] Exit Code: 
[2026-08-01 01:38:47] [INFO] 
[2026-08-01 01:38:47] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-01 01:38:47] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_20gtbuer.prg
[2026-08-01 01:38:47] [INFO] 
[2026-08-01 01:38:47] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-01 01:38:47] [INFO] * Auto-generated wrapper for parameters
[2026-08-01 01:38:47] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 01:38:47] [INFO] * Parameters: 'FormDES', 'C:\4c\tasks\task393', 'CRUD'
[2026-08-01 01:38:47] [INFO] 
[2026-08-01 01:38:47] [INFO] * Anti-dialog protections for unattended execution
[2026-08-01 01:38:47] [INFO] SET SAFETY OFF
[2026-08-01 01:38:47] [INFO] SET RESOURCE OFF
[2026-08-01 01:38:47] [INFO] SET TALK OFF
[2026-08-01 01:38:47] [INFO] SET NOTIFY OFF
[2026-08-01 01:38:47] [INFO] SYS(2335, 0)
[2026-08-01 01:38:47] [INFO] 
[2026-08-01 01:38:47] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDES', 'C:\4c\tasks\task393', 'CRUD'
[2026-08-01 01:38:47] [INFO] QUIT
[2026-08-01 01:38:47] [INFO] 
[2026-08-01 01:38:47] [INFO] === Fim do Wrapper.prg ===
[2026-08-01 01:38:47] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-01 01:40:44] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-01 01:40:44] [INFO] Config FPW: (nao fornecido)
[2026-08-01 01:40:44] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 01:40:44] [INFO] Timeout: 300 segundos
[2026-08-01 01:40:44] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_32lftds0.prg
[2026-08-01 01:40:44] [INFO] Conteudo do wrapper:
[2026-08-01 01:40:44] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormDES', 'C:\4c\tasks\task393', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDES', 'C:\4c\tasks\task393', 'CRUD'
QUIT

[2026-08-01 01:40:44] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_32lftds0.prg
[2026-08-01 01:40:44] [INFO] VFP output esperado em: C:\4c\tasks\task393\vfp_output.txt
[2026-08-01 01:40:44] [INFO] Executando Visual FoxPro 9...
[2026-08-01 01:40:44] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_32lftds0.prg
[2026-08-01 01:40:44] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_32lftds0.prg
[2026-08-01 01:40:44] [INFO] Timeout configurado: 300 segundos
[2026-08-01 01:41:35] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-01 01:41:35] [INFO] VFP9 finalizado em 51.1030013 segundos
[2026-08-01 01:41:35] [INFO] Exit Code: 
[2026-08-01 01:41:35] [INFO] 
[2026-08-01 01:41:35] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-01 01:41:35] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_32lftds0.prg
[2026-08-01 01:41:35] [INFO] 
[2026-08-01 01:41:35] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-01 01:41:35] [INFO] * Auto-generated wrapper for parameters
[2026-08-01 01:41:35] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 01:41:35] [INFO] * Parameters: 'FormDES', 'C:\4c\tasks\task393', 'CRUD'
[2026-08-01 01:41:35] [INFO] 
[2026-08-01 01:41:35] [INFO] * Anti-dialog protections for unattended execution
[2026-08-01 01:41:35] [INFO] SET SAFETY OFF
[2026-08-01 01:41:35] [INFO] SET RESOURCE OFF
[2026-08-01 01:41:35] [INFO] SET TALK OFF
[2026-08-01 01:41:35] [INFO] SET NOTIFY OFF
[2026-08-01 01:41:35] [INFO] SYS(2335, 0)
[2026-08-01 01:41:35] [INFO] 
[2026-08-01 01:41:35] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDES', 'C:\4c\tasks\task393', 'CRUD'
[2026-08-01 01:41:35] [INFO] QUIT
[2026-08-01 01:41:35] [INFO] 
[2026-08-01 01:41:35] [INFO] === Fim do Wrapper.prg ===
[2026-08-01 01:41:35] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormDES",
  "timestamp": "20260801014135",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDES.prg):
*==============================================================================
* FormDES.prg - Cadastro de Cotas de Desconto por Periodo
* Tabela : sigcddes | PK: codigo | Tipo: CRUD (frmcadastro)
* Fase 8/8 - FORM: Eventos Auxiliares e Consolidacao Final
* Metodos completos: Init/InicializarForm/ConfigurarPageFrame/ConfigurarPaginaLista/
*   ConfigurarPaginaDados/CarregarLista/AlternarPagina/FormParaBO/BOParaForm/
*   HabilitarCampos/LimparCampos/AjustarBotoesPorModo/TornarControlesVisiveis/
*   FormatarGridLista/ValidarEmps/RecalcularPdes/ImportaPlan/BtnEncerrarClick/
*   BtnIncluirClick/BtnVisualizarClick/BtnAlterarClick/BtnExcluirClick/
*   BtnBuscarClick/BtnBtncarregarClick/BtnConfirmarClick/BtnCancelarClick
*==============================================================================

DEFINE CLASS FormDES AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Cotas de Desconto por per" + CHR(237) + "odo"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cFiltroEmps     = ""    && Filtro de empresa para o grid

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loException
            MsgErro("Erro em FormDES.Init:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("DESBO")

            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar DESBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaDados()

                IF TYPE("gb_4c_ValidandoUI") <> "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormDES.InicializarForm:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: Cabecalho + Botoes CRUD + Grid
    * Legado: cntSombra.Top=1, Grupo_op.Left=538 Width=389, Grade.Top=131 Left=12
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza escuro (cntSombra do legado)
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
            .Caption   = THIS.Caption
            .Top       = 15
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
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (Grupo_op do legado - Left=538, Width=389)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 389
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Visualizar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Alterar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Excluir
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Buscar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Container Encerrar - padrao canonico (PREVALECE sobre PILAR 1)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao especial Carrega Cotas (legado: btncarregar, top=4+29=33, left=467)
        *-- Inicia oculto (Visible=.F.) conforme legado
        loc_oPagina.AddObject("cmd_4c_Btncarregar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Btncarregar
            .Caption         = "Carrega Cotas"
            .PicturePosition = 13
            .Top             = 33
            .Left            = 467
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .F.    && Inicia oculto conforme legado
        ENDWITH

        *-- Grid de lista (legado: grade.Top=131 left=12, compensado +29)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 160
            .Left               = 12
            .Width              = 890
            .Height             = 460
            .ColumnCount        = 6
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

        *-- Larguras das colunas (captions definidos em CarregarLista apos RecordSource)
        loc_oPagina.grd_4c_Lista.Column1.Width = 100
        loc_oPagina.grd_4c_Lista.Column2.Width = 75
        loc_oPagina.grd_4c_Lista.Column3.Width = 75
        loc_oPagina.grd_4c_Lista.Column4.Width = 75
        loc_oPagina.grd_4c_Lista.Column5.Width = 100
        loc_oPagina.grd_4c_Lista.Column6.Width = 100

        *-- BINDEVENTs - metodos PUBLIC para funcionar com BINDEVENT
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.cmd_4c_Btncarregar,               "Click", THIS, "BtnBtncarregarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: Botoes + Todos os Campos
    * Legado: Grupo_Salva.Left=819, Top=9+29=38
    * Campos: Codigo, Emps, Dtini, Dtfin, Valmeta, Valcota, Valdes, Pdes
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Salvar/Cancelar (Grupo_Salva do legado - Left=819, Top=38)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 38
            .Left        = 819
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salvar)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Cancelar
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- PARTE 1: Campos Codigo, Empresa, Dt Inicio, Dt Final
        *-- Posicoes do legado (layout.json) + compensacao PageFrame +29

        *-- Label Codigo (Say7: top=126+29=155, left=445, caption="Codigo :")
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 155
            .Left      = 445
            .Width     = 80
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (getcodigo: top=121+29=150, left=492, width=80)
        *-- Sempre somente leitura (When=.F. no legado, auto-gerado pelo sistema)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value       = ""
            .Top         = 150
            .Left        = 492
            .Width       = 80
            .Height      = 24
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Enabled     = .F.
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

        *-- Label Empresa (Say1: top=153+29=182, left=437, caption="Empresa : ")
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Empresa :"
            .Top       = 182
            .Left      = 437
            .Width     = 80
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Empresa (getEmps: top=148+29=177, left=492, width=33)
        *-- Editavel apenas no modo INCLUIR (When=INLIST(pcEscolha,'INSERIR'))
        *-- MaxLength=3 pois SigCdEmp.Cemps = char(3)
        loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPagina.txt_4c_Emps
            .Value       = ""
            .Top         = 177
            .Left        = 492
            .Width       = 33
            .Height      = 24
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .MaxLength   = 3
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH

        *-- Label Data Inicial (Say5: top=180+29=209, left=425, caption="Data Inicial : ")
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Data Inicial :"
            .Top       = 209
            .Left      = 425
            .Width     = 92
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data Inicial (getDtini: top=175+29=204, left=492, width=80)
        *-- Editavel apenas no modo INCLUIR
        loc_oPagina.AddObject("txt_4c_Dtini", "TextBox")
        WITH loc_oPagina.txt_4c_Dtini
            .Value       = {}
            .Top         = 204
            .Left        = 492
            .Width       = 80
            .Height      = 24
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .InputMask   = "99/99/9999"
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH

        *-- Label Data Final (Say6: top=207+29=236, left=430, caption="Data Final : ")
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Data Final :"
            .Top       = 236
            .Left      = 430
            .Width     = 87
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data Final (GetDtfin: top=202+29=231, left=492, width=80)
        *-- Editavel apenas no modo INCLUIR
        loc_oPagina.AddObject("txt_4c_Dtfin", "TextBox")
        WITH loc_oPagina.txt_4c_Dtfin
            .Value       = {}
            .Top         = 231
            .Left        = 492
            .Width       = 80
            .Height      = 24
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .InputMask   = "99/99/9999"
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH

        *-- PARTE 2: Campos de valores monetarios e percentual

        *-- Label Meta de Vendas (Say3: top=234+29=263, left=401)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Meta de Vendas :"
            .Top       = 263
            .Left      = 401
            .Width     = 110
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Meta de Vendas (GetValmeta: top=229+29=258, left=492, width=126)
        *-- Editavel em INCLUIR e ALTERAR
        loc_oPagina.AddObject("txt_4c_Valmeta", "TextBox")
        WITH loc_oPagina.txt_4c_Valmeta
            .Value         = 0
            .Top           = 258
            .Left          = 492
            .Width         = 126
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .InputMask     = "99,999,999.99"
            .Alignment     = 3
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label Cota Desconto $ (Say2: top=261+29=290, left=398)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Cota Desconto $ :"
            .Top       = 290
            .Left      = 398
            .Width     = 113
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Cota Desconto $ (getvalcota: top=256+29=285, left=492, width=126)
        *-- Editavel em INCLUIR e ALTERAR
        loc_oPagina.AddObject("txt_4c_Valcota", "TextBox")
        WITH loc_oPagina.txt_4c_Valcota
            .Value         = 0
            .Top           = 285
            .Left          = 492
            .Width         = 126
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .InputMask     = "99,999,999.99"
            .Alignment     = 3
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label Desconto Aplicado $ (Say8: top=288+29=317, left=381)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Desconto Aplicado $ :"
            .Top       = 317
            .Left      = 381
            .Width     = 130
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Desconto Aplicado $ (getvaldes: top=283+29=312, left=492, width=126)
        *-- Sempre somente leitura (registrado pelo sistema quando descontos sao aplicados)
        loc_oPagina.AddObject("txt_4c_Valdes", "TextBox")
        WITH loc_oPagina.txt_4c_Valdes
            .Value         = 0
            .Top           = 312
            .Left          = 492
            .Width         = 126
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .InputMask     = "99,999,999.99"
            .Alignment     = 3
            .SpecialEffect = 1
            .Enabled       = .F.
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label Cota Desconto % (Say4: top=315+29=344, left=393)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Cota Desconto % :"
            .Top       = 344
            .Left      = 393
            .Width     = 116
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Cota Desconto % (getpdes: top=310+29=339, left=492, width=126)
        *-- Sempre somente leitura (calculado: valcota/valmeta*100)
        loc_oPagina.AddObject("txt_4c_Pdes", "TextBox")
        WITH loc_oPagina.txt_4c_Pdes
            .Value         = 0
            .Top           = 339
            .Left          = 492
            .Width         = 126
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .InputMask     = "999.99"
            .Alignment     = 3
            .SpecialEffect = 1
            .Enabled       = .F.
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- BINDEVENTs dos botoes de Page2
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- BINDEVENT Empresa: validar ao perder foco
        BINDEVENT(loc_oPagina.txt_4c_Emps, "KeyPress", THIS, "ValidarEmps")

        *-- BINDEVENT Valmeta/Valcota: recalcular % ao sair do campo
        *-- Legado: GetValmeta.Valid e getvalcota.Valid atualizam getpdes
        BINDEVENT(loc_oPagina.txt_4c_Valmeta, "LostFocus", THIS, "RecalcularPdes")
        BINDEVENT(loc_oPagina.txt_4c_Valcota, "LostFocus", THIS, "RecalcularPdes")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ValidarEmps - Valida codigo de empresa ao sair do campo
    * Substitui fAcessoEmpresa() (nao portada) - verifica se Cemps existe em SigCdEmp
    *==========================================================================
    PROCEDURE ValidarEmps(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cEmps, loc_cSQL, loc_nRes, loc_lResultado
        loc_lResultado = .F.

        IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
            RETURN
        ENDIF

        loc_oPg2  = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
            RETURN
        ENDIF

        loc_cEmps = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)

        IF EMPTY(loc_cEmps)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp" + ;
                       " WHERE Cemps = " + EscaparSQL(loc_cEmps)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaEmp")

            IF loc_nRes > 0 AND USED("cursor_4c_ValidaEmp")
                IF RECCOUNT("cursor_4c_ValidaEmp") = 0
                    MsgAviso("Empresa '" + loc_cEmps + "' n" + CHR(227) + "o encontrada.", "")
                    loc_oPg2.txt_4c_Emps.Value = ""
                    loc_oPg2.txt_4c_Emps.SetFocus()
                ENDIF
                USE IN cursor_4c_ValidaEmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ValidarEmps:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_ValidaEmp")
                USE IN cursor_4c_ValidaEmp
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega cursor cursor_4c_Lista e vincula ao Grid
    * DESBO.Buscar() retorna: codigo, emps, dtini, dtfin, valmeta, valcota,
    *   valdes, usualts, dtalts
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroEmps)
                loc_lResultado = .F.
            ELSE
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 6
                    loc_oGrid.RecordSource = "cursor_4c_Lista"

                    *-- ControlSources APOS RecordSource (previne auto-bind sobrescrever)
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Lista.codigo"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Lista.emps"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Lista.dtini"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Lista.dtfin"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Lista.valmeta"
                    loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.valdes"

                    *-- Captions APOS ControlSource (RecordSource reseta os captions)
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Empresa"
                    loc_oGrid.Column3.Header1.Caption = "Dt Inicio"
                    loc_oGrid.Column4.Header1.Caption = "Dt final"
                    loc_oGrid.Column5.Header1.Caption = "Vr Meta"
                    loc_oGrid.Column6.Header1.Caption = "Vr Desconto"

                    THIS.FormatarGridLista(loc_oGrid)
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarLista:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro em AlternarPagina:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * EXCECAO: cmd_4c_Btncarregar inicia oculto (Visible=.F. conforme legado)
    * EXCECAO: cnt_4c_Cabecalho gerencia propria visibilidade (nao deve ser forcado)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP, loc_cNome

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                *-- Pular controles que devem iniciar ocultos ou gerenciam propria visibilidade
                *-- Recursao antes do LOOP para que filhos ainda sejam processados
                IF INLIST(loc_cNome, "CMD_4C_BTNCARREGAR", "CNT_4C_CABECALHO")
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
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
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fechar formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Incluir novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Emps", 5)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Lista
        loc_cCodigo = ALLTRIM(cursor_4c_Lista.codigo)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alterar registro selecionado
    * Legado: emps/dtini/dtfin nao editaveis apos criacao (When=INSERIR only)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Lista
        loc_cCodigo = ALLTRIM(cursor_4c_Lista.codigo)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Valmeta", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Valmeta.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Excluir registro selecionado
    * Regra de negocio (DESBO): exclusao bloqueada se valdes > 0 (cota usada)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma
        loc_cCodigo = ""
        loc_lConfirma = .F.

        IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Lista
        loc_cCodigo = ALLTRIM(cursor_4c_Lista.codigo)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?" + ;
                CHR(13) + "C" + CHR(243) + "digo: " + loc_cCodigo, ;
                "Excluir")

            IF loc_lConfirma
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Filtrar grid por empresa
    * Legado: LocateCursor por emps - equivalente: recarregar filtrado
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cEmps
        loc_cEmps = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", "", ;
                "Buscar Empresa")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "d")
                loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    loc_cEmps = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF

            THIS.this_cFiltroEmps = loc_cEmps
            THIS.CarregarLista()
        CATCH TO loException
            MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBtncarregarClick - Importar planilha Excel de cotas
    *==========================================================================
    PROCEDURE BtnBtncarregarClick()
        LOCAL loc_lResultado
        loc_lResultado = THIS.ImportaPlan()

        IF loc_lResultado
            MsgInfo("Planilha importada com sucesso.", "")
            THIS.CarregarLista()
        ELSE
            MsgAviso("A Planilha n" + CHR(227) + "o foi importada.", "Aviso")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Salvar registro (chama Inserir ou Atualizar via BO)
    * Legado: fSalvar em Salva.Click - valida campos, faz INSERT/UPDATE e volta lista
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        TRY
            IF THIS.this_cModoAtual = "VISUALIZAR"
                THIS.AlternarPagina(1)
                THIS.this_cModoAtual = "LISTA"
            ELSE
                IF THIS.FormParaBO()
                    IF THIS.this_oBusinessObject.Salvar()
                        MsgInfo("Registro salvo com sucesso!", "")
                        THIS.this_cModoAtual = "LISTA"
                        THIS.AlternarPagina(1)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnConfirmarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancelar edicao e voltar para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loException
            MsgErro("Erro em BtnCancelarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita Confirmar conforme modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lVisualizar
        loc_lVisualizar = (THIS.this_cModoAtual = "VISUALIZAR")

        IF !PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Salva", 5)
            RETURN
        ENDIF

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = !loc_lVisualizar
        ENDIF

        IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
            loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme modo
    * Legado: getEmps/getDtini/GetDtfin.When = INLIST(pcEscolha,'INSERIR')
    *         getpdes/getvaldes/getcodigo.When = .F. (sempre somente leitura)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lModoIncluir

        IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
            RETURN
        ENDIF

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_lModoIncluir = (THIS.this_cModoAtual = "INCLUIR")

        *-- Codigo: sempre somente leitura (auto-gerado pelo sistema)
        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
            loc_oPg2.txt_4c_Codigo.Enabled = .F.
        ENDIF

        *-- Empresa, Dt Inicio, Dt Final: editavel SOMENTE no modo INCLUIR
        IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
            loc_oPg2.txt_4c_Emps.Enabled = (par_lHabilitar AND loc_lModoIncluir)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
            loc_oPg2.txt_4c_Dtini.Enabled = (par_lHabilitar AND loc_lModoIncluir)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
            loc_oPg2.txt_4c_Dtfin.Enabled = (par_lHabilitar AND loc_lModoIncluir)
        ENDIF

        *-- Valmeta e Valcota: editavel em INCLUIR e ALTERAR
        IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
            loc_oPg2.txt_4c_Valmeta.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
            loc_oPg2.txt_4c_Valcota.Enabled = par_lHabilitar
        ENDIF

        *-- Pdes e Valdes: sempre somente leitura (calculados/registrados pelo sistema)
        IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
            loc_oPg2.txt_4c_Pdes.Enabled = .F.
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Valdes", 5)
            loc_oPg2.txt_4c_Valdes.Enabled = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2

        IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
            RETURN
        ENDIF

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
            loc_oPg2.txt_4c_Codigo.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
            loc_oPg2.txt_4c_Emps.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
            loc_oPg2.txt_4c_Dtini.Value   = {}
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
            loc_oPg2.txt_4c_Dtfin.Value   = {}
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
            loc_oPg2.txt_4c_Valmeta.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
            loc_oPg2.txt_4c_Valcota.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Valdes", 5)
            loc_oPg2.txt_4c_Valdes.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
            loc_oPg2.txt_4c_Pdes.Value    = 0
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos do form para o BO
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_oPg2, loc_lResultado
        loc_lResultado = .F.

        IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
            RETURN .F.
        ENDIF

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
                THIS.this_oBusinessObject.this_cEmps    = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
                THIS.this_oBusinessObject.this_dDtini   = loc_oPg2.txt_4c_Dtini.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
                THIS.this_oBusinessObject.this_dDtfin   = loc_oPg2.txt_4c_Dtfin.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
                THIS.this_oBusinessObject.this_nValmeta = loc_oPg2.txt_4c_Valmeta.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
                THIS.this_oBusinessObject.this_nValcota = loc_oPg2.txt_4c_Valcota.Value
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro em FormParaBO:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para os campos do form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_nValmeta, loc_nValcota

        IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
            RETURN
        ENDIF

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
                loc_oPg2.txt_4c_Codigo.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
                loc_oPg2.txt_4c_Emps.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
                loc_oPg2.txt_4c_Dtini.Value   = THIS.this_oBusinessObject.this_dDtini
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
                loc_oPg2.txt_4c_Dtfin.Value   = THIS.this_oBusinessObject.this_dDtfin
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
                loc_oPg2.txt_4c_Valmeta.Value = THIS.this_oBusinessObject.this_nValmeta
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
                loc_oPg2.txt_4c_Valcota.Value = THIS.this_oBusinessObject.this_nValcota
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valdes", 5)
                loc_oPg2.txt_4c_Valdes.Value  = THIS.this_oBusinessObject.this_nValdes
            ENDIF

            *-- Calcular e exibir percentual de desconto
            loc_nValmeta = THIS.this_oBusinessObject.this_nValmeta
            loc_nValcota = THIS.this_oBusinessObject.this_nValcota
            IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
                loc_oPg2.txt_4c_Pdes.Value = IIF(loc_nValmeta = 0, 0.00, ;
                    loc_nValcota / loc_nValmeta * 100)
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BOParaForm:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * RecalcularPdes - Recalcula percentual de desconto ao mudar valmeta/valcota
    * Legado: getpdes.Value = IIF(valmeta=0, 0.00, valcota/valmeta*100)
    * Chamado via BINDEVENT InteractiveChange de txt_4c_Valmeta e txt_4c_Valcota
    *==========================================================================
    PROCEDURE RecalcularPdes()
        LOCAL loc_oPg2, loc_nValmeta, loc_nValcota
        loc_nValmeta = 0
        loc_nValcota = 0

        IF !PEMSTATUS(THIS.pgf_4c_Paginas, "Page2", 5)
            RETURN
        ENDIF

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Valmeta", 5)
                loc_nValmeta = loc_oPg2.txt_4c_Valmeta.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Valcota", 5)
                loc_nValcota = loc_oPg2.txt_4c_Valcota.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Pdes", 5)
                loc_oPg2.txt_4c_Pdes.Value = IIF(loc_nValmeta = 0, 0.00, ;
                    loc_nValcota / loc_nValmeta * 100)
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RecalcularPdes:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ImportaPlan - Importa planilha Excel com cotas de desconto
    * Legado: usa ImpExcelDriver (funcao do framework Fortyus)
    * Layout planilha: col1=empresa(N), col2=periodo YYMM(C), col3=cota(N)
    *==========================================================================
    PROTECTED FUNCTION ImportaPlan()
        LOCAL loc_lcArq, loc_lResultado, loc_lcEmp
        LOCAL loc_lcMes, loc_lnCota, loc_lcField
        LOCAL loc_lcAno, loc_lcMesNum, loc_ldIni, loc_ldFin
        loc_lResultado = .F.

        *-- GETFILE fora do TRY (dialogo nativo, sem risco de excecao VFP)
        loc_lcArq = GETFILE("xls*")

        IF EMPTY(loc_lcArq)
            RETURN .F.
        ENDIF

        TRY
            IF !ImpExcelDriver(loc_lcArq, "Cota Desconto")
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a planilha." + CHR(13) + ;
                    "Verifique se o arquivo e a aba 'Cota Desconto' est" + CHR(227) + "o corretos.", "Aviso")
                loc_lResultado = .F.
            ELSE
                IF !USED("xlResults")
                MsgAviso("Planilha vazia ou formato inv" + CHR(225) + "lido.", "Aviso")
                loc_lResultado = .F.
            ELSE
                SELECT xlResults
                GO TOP

                SCAN
                    *-- Coluna 1: empresa (numerico)
                    loc_lcField = FIELD(1)
                    loc_lcEmp = ALLTRIM(STR(IIF(INLIST(VARTYPE(&loc_lcField), "N"), &loc_lcField, 0)))

                    *-- Coluna 2: periodo YYMM (caracter, ex: "2601" = jan/2026)
                    loc_lcField = FIELD(2)
                    loc_lcMes = PADL(ALLTRIM(IIF(INLIST(VARTYPE(&loc_lcField), "C", "M"), &loc_lcField, "")), 6, "0")

                    *-- Coluna 3: valor da cota
                    loc_lcField = FIELD(3)
                    loc_lnCota = IIF(INLIST(VARTYPE(&loc_lcField), "N"), &loc_lcField, 0)

                    IF !EMPTY(loc_lcEmp) AND LEN(ALLTRIM(loc_lcMes)) >= 4
                        *-- Extrair ano (2 digitos) e mes dos 4 ultimos chars apos padding
                        loc_lcAno    = SUBSTR(loc_lcMes, 3, 2)
                        loc_lcMesNum = RIGHT(loc_lcMes, 2)

                        loc_ldIni = DATE(2000 + VAL(loc_lcAno), VAL(loc_lcMesNum), 1)
                        loc_ldFin = GOMONTH(loc_ldIni, 1) - 1

                        THIS.this_oBusinessObject.NovoRegistro()
                        THIS.this_oBusinessObject.this_cEmps    = loc_lcEmp
                        THIS.this_oBusinessObject.this_dDtini   = loc_ldIni
                        THIS.this_oBusinessObject.this_dDtfin   = loc_ldFin
                        THIS.this_oBusinessObject.this_nValmeta = 0
                        THIS.this_oBusinessObject.this_nValcota = loc_lnCota
                        THIS.this_oBusinessObject.Salvar()
                    ENDIF
                ENDSCAN

                IF USED("xlResults")
                    USE IN xlResults
                ENDIF

                loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ImportaPlan:" + CHR(13) + loException.Message, "Erro")
            IF USED("xlResults")
                USE IN xlResults
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\DESBO.prg):
*==============================================================================
* DESBO.prg - Business Object para Cadastro de Cotas de Desconto por Periodo
* Tabela : sigcddes
* Herda de: BusinessBase
* Fase 1 : Propriedades e Init
*==============================================================================

DEFINE CLASS DESBO AS BusinessBase

    *-- Propriedades da tabela sigcddes
    this_cCodigo   = ""    && codigo   char(10) PK (auto-gerado no Inserir)
    this_cEmps     = ""    && emps     char(3)
    this_dDtini    = {}    && dtini    datetime
    this_dDtfin    = {}    && dtfin    datetime
    this_nValmeta  = 0     && valmeta  numeric(11,2)
    this_nValcota  = 0     && valcota  numeric(11,2) cota desconto R$
    this_nValcotac = 0     && valcotac numeric(11,2) cota (outra moeda)
    this_nValdes   = 0     && valdes   numeric(11,2) desconto aplicado R$ (readonly)
    this_cUsualts  = ""    && usualts  char(10)
    this_dDtalts   = {}    && dtalts   datetime

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigcddes"
        THIS.this_cCampoChave = "codigo"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo   = TratarNulo(codigo,   "C")
            THIS.this_cEmps     = TratarNulo(emps,     "C")
            THIS.this_dDtini    = TratarNulo(dtini,    "T")
            THIS.this_dDtfin    = TratarNulo(dtfin,    "T")
            THIS.this_nValmeta  = TratarNulo(valmeta,  "N")
            THIS.this_nValcota  = TratarNulo(valcota,  "N")
            THIS.this_nValcotac = TratarNulo(valcotac, "N")
            THIS.this_nValdes   = TratarNulo(valdes,   "N")
            THIS.this_cUsualts  = TratarNulo(usualts,  "C")
            THIS.this_dDtalts   = TratarNulo(dtalts,   "T")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria para auditoria
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * GerarCodigo - Gera codigo unico: emps(3) + YYMM(4) + seq(3) = 10 chars
    *==========================================================================
    PROTECTED FUNCTION GerarCodigo()
        LOCAL loc_cPrefixo, loc_cSQL, loc_nSeq, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_cPrefixo = ALLTRIM(THIS.this_cEmps) + ;
                SUBSTR(ALLTRIM(STR(YEAR(DATE()))), 3) + ;
                PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")

            loc_cSQL = "SELECT COUNT(*) AS cnt FROM sigcddes WHERE codigo LIKE '" + ;
                loc_cPrefixo + "%'"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GerarCod") > 0
                SELECT cursor_4c_GerarCod
                loc_nSeq = cursor_4c_GerarCod.cnt + 1
                loc_cCodigo = loc_cPrefixo + PADL(ALLTRIM(STR(loc_nSeq)), 3, "0")
            ENDIF

            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao gerar c" + CHR(243) + "digo")
            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        ENDTRY

        RETURN loc_cCodigo
    ENDFUNC

    *==========================================================================
    * ValidarSobreposicaoPeriodo - Verifica sobreposicao de periodo por empresa
    * par_cCodigoExcluir: codigo a excluir da verificacao (para Atualizar)
    *==========================================================================
    PROTECTED FUNCTION ValidarSobreposicaoPeriodo(par_cEmps, par_dIni, par_dFin, par_cCodigoExcluir)
        LOCAL loc_cSQL, loc_cFiltroExcluir, loc_lSobrepoe
        loc_lSobrepoe = .F.

        TRY
            loc_cFiltroExcluir = ""
            IF !EMPTY(ALLTRIM(par_cCodigoExcluir))
                loc_cFiltroExcluir = " AND codigo <> " + EscaparSQL(par_cCodigoExcluir)
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS cnt FROM sigcddes" + ;
                " WHERE emps = " + EscaparSQL(par_cEmps) + ;
                " AND CONVERT(DATE, dtini) <= CONVERT(DATE, " + FormatarDataSQL(par_dFin) + ")" + ;
                " AND CONVERT(DATE, dtfin) >= CONVERT(DATE, " + FormatarDataSQL(par_dIni) + ")" + ;
                loc_cFiltroExcluir

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Sobrepoe") > 0
                SELECT cursor_4c_Sobrepoe
                loc_lSobrepoe = (cursor_4c_Sobrepoe.cnt > 0)
            ENDIF

            IF USED("cursor_4c_Sobrepoe")
                USE IN cursor_4c_Sobrepoe
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao validar per" + CHR(237) + "odo")
            IF USED("cursor_4c_Sobrepoe")
                USE IN cursor_4c_Sobrepoe
            ENDIF
        ENDTRY

        RETURN loc_lSobrepoe
    ENDFUNC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios e regras de negocio
    * par_lNovoRegistro: .T. = Inserir, .F. = Atualizar
    *==========================================================================
    PROTECTED FUNCTION ValidarDados(par_lNovoRegistro)
        IF EMPTY(ALLTRIM(THIS.this_cEmps))
            MsgAviso("Empresa n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDtini)
            MsgAviso("Data Inicial n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDtfin)
            MsgAviso("Data final n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF THIS.this_dDtini > THIS.this_dDtfin
            MsgAviso("As datas est" + CHR(227) + "o incompat" + CHR(237) + "veis!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        LOCAL loc_cCodigoExcluir
        loc_cCodigoExcluir = IIF(par_lNovoRegistro, "", THIS.this_cCodigo)

        IF THIS.ValidarSobreposicaoPeriodo(THIS.this_cEmps, THIS.this_dDtini, THIS.this_dDtfin, loc_cCodigoExcluir)
            MsgAviso("Esse intervalo j" + CHR(225) + " est" + CHR(225) + " cadastrado para essa empresa!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT em sigcddes
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCodigo
        loc_lSucesso = .F.

        IF !THIS.ValidarDados(.T.)
            RETURN .F.
        ENDIF

        TRY
            loc_cCodigo = THIS.GerarCodigo()
            IF EMPTY(loc_cCodigo)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar c" + CHR(243) + "digo.", "Erro")
            ELSE
                THIS.this_cCodigo  = loc_cCodigo
                THIS.this_cUsualts = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

                loc_cSQL = "INSERT INTO sigcddes" + ;
                    " (codigo, emps, dtini, dtfin, valmeta, valcota, valcotac, valdes, usualts, dtalts)" + ;
                    " VALUES (" + ;
                    EscaparSQL(THIS.this_cCodigo)          + ", " + ;
                    EscaparSQL(THIS.this_cEmps)            + ", " + ;
                    FormatarDataSQL(THIS.this_dDtini)      + ", " + ;
                    FormatarDataSQL(THIS.this_dDtfin)      + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValmeta)  + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValcota)  + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValcotac) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValdes)   + ", " + ;
                    EscaparSQL(THIS.this_cUsualts)         + ", " + ;
                    "GETDATE())"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE em sigcddes
    * Nota: emps/dtini/dtfin NAO editaveis apos criacao (When=INSERIR only)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF !THIS.ValidarDados(.F.)
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cUsualts = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "UPDATE sigcddes SET" + ;
                " valmeta  = " + FormatarNumeroSQL(THIS.this_nValmeta)  + "," + ;
                " valcota  = " + FormatarNumeroSQL(THIS.this_nValcota)  + "," + ;
                " valcotac = " + FormatarNumeroSQL(THIS.this_nValcotac) + "," + ;
                " usualts  = " + EscaparSQL(THIS.this_cUsualts) + "," + ;
                " dtalts   = GETDATE()" + ;
                " WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE de sigcddes (chamado por BusinessBase.Excluir)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF THIS.this_nValdes > 0
            MsgAviso("Exclus" + CHR(227) + "o n" + CHR(227) + "o permitida. Cota j" + CHR(225) + " utilizada!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM sigcddes WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao excluir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT para grid (cursor crSigCdDes)
    * par_cFiltro: codigo de empresa para filtrar (vazio = todos)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE emps = " + EscaparSQL(ALLTRIM(par_cFiltro))
            ENDIF

            loc_cSQL = "SELECT codigo, emps, dtini, dtfin, valmeta, valcota, valdes, usualts, dtalts" + ;
                " FROM sigcddes" + loc_cWhere + ;
                " ORDER BY emps, dtini"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista") >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - SELECT por chave primaria
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigo, emps, dtini, dtfin, valmeta, valcota, valcotac, valdes, usualts, dtalts" + ;
                " FROM sigcddes WHERE codigo = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado.", "")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao carregar")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

