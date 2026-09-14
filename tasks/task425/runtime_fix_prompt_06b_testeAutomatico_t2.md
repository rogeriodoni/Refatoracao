# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-06 00:21:32] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-06 00:21:32] [INFO] Config FPW: (nao fornecido)
[2026-08-06 00:21:32] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 00:21:32] [INFO] Timeout: 300 segundos
[2026-08-06 00:21:32] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tcercg4q.prg
[2026-08-06 00:21:32] [INFO] Conteudo do wrapper:
[2026-08-06 00:21:32] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFpg', 'C:\4c\tasks\task425', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpg', 'C:\4c\tasks\task425', 'CRUD'
QUIT

[2026-08-06 00:21:32] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tcercg4q.prg
[2026-08-06 00:21:32] [INFO] VFP output esperado em: C:\4c\tasks\task425\vfp_output.txt
[2026-08-06 00:21:32] [INFO] Executando Visual FoxPro 9...
[2026-08-06 00:21:32] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tcercg4q.prg
[2026-08-06 00:21:32] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tcercg4q.prg
[2026-08-06 00:21:32] [INFO] Timeout configurado: 300 segundos
[2026-08-06 00:22:30] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-06 00:22:30] [INFO] VFP9 finalizado em 58.1745435 segundos
[2026-08-06 00:22:30] [INFO] Exit Code: 
[2026-08-06 00:22:30] [INFO] 
[2026-08-06 00:22:30] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-06 00:22:30] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_tcercg4q.prg
[2026-08-06 00:22:30] [INFO] 
[2026-08-06 00:22:30] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-06 00:22:30] [INFO] * Auto-generated wrapper for parameters
[2026-08-06 00:22:30] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 00:22:30] [INFO] * Parameters: 'FormFpg', 'C:\4c\tasks\task425', 'CRUD'
[2026-08-06 00:22:30] [INFO] 
[2026-08-06 00:22:30] [INFO] * Anti-dialog protections for unattended execution
[2026-08-06 00:22:30] [INFO] SET SAFETY OFF
[2026-08-06 00:22:30] [INFO] SET RESOURCE OFF
[2026-08-06 00:22:30] [INFO] SET TALK OFF
[2026-08-06 00:22:30] [INFO] SET NOTIFY OFF
[2026-08-06 00:22:30] [INFO] SYS(2335, 0)
[2026-08-06 00:22:30] [INFO] 
[2026-08-06 00:22:30] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpg', 'C:\4c\tasks\task425', 'CRUD'
[2026-08-06 00:22:30] [INFO] QUIT
[2026-08-06 00:22:30] [INFO] 
[2026-08-06 00:22:30] [INFO] === Fim do Wrapper.prg ===
[2026-08-06 00:22:30] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-06 00:24:38] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-06 00:24:38] [INFO] Config FPW: (nao fornecido)
[2026-08-06 00:24:38] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 00:24:38] [INFO] Timeout: 300 segundos
[2026-08-06 00:24:38] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xibyo0gm.prg
[2026-08-06 00:24:38] [INFO] Conteudo do wrapper:
[2026-08-06 00:24:38] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFpg', 'C:\4c\tasks\task425', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpg', 'C:\4c\tasks\task425', 'CRUD'
QUIT

[2026-08-06 00:24:38] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xibyo0gm.prg
[2026-08-06 00:24:38] [INFO] VFP output esperado em: C:\4c\tasks\task425\vfp_output.txt
[2026-08-06 00:24:38] [INFO] Executando Visual FoxPro 9...
[2026-08-06 00:24:38] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xibyo0gm.prg
[2026-08-06 00:24:38] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xibyo0gm.prg
[2026-08-06 00:24:38] [INFO] Timeout configurado: 300 segundos
[2026-08-06 00:25:42] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-06 00:25:42] [INFO] VFP9 finalizado em 63.9241936 segundos
[2026-08-06 00:25:42] [INFO] Exit Code: 
[2026-08-06 00:25:42] [INFO] 
[2026-08-06 00:25:42] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-06 00:25:42] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xibyo0gm.prg
[2026-08-06 00:25:42] [INFO] 
[2026-08-06 00:25:42] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-06 00:25:42] [INFO] * Auto-generated wrapper for parameters
[2026-08-06 00:25:42] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 00:25:42] [INFO] * Parameters: 'FormFpg', 'C:\4c\tasks\task425', 'CRUD'
[2026-08-06 00:25:42] [INFO] 
[2026-08-06 00:25:42] [INFO] * Anti-dialog protections for unattended execution
[2026-08-06 00:25:42] [INFO] SET SAFETY OFF
[2026-08-06 00:25:42] [INFO] SET RESOURCE OFF
[2026-08-06 00:25:42] [INFO] SET TALK OFF
[2026-08-06 00:25:42] [INFO] SET NOTIFY OFF
[2026-08-06 00:25:42] [INFO] SYS(2335, 0)
[2026-08-06 00:25:42] [INFO] 
[2026-08-06 00:25:42] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFpg', 'C:\4c\tasks\task425', 'CRUD'
[2026-08-06 00:25:42] [INFO] QUIT
[2026-08-06 00:25:42] [INFO] 
[2026-08-06 00:25:42] [INFO] === Fim do Wrapper.prg ===
[2026-08-06 00:25:42] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormFpg",
  "timestamp": "20260806002542",
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 2 (CDGRUPOKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpg.prg):
*==============================================================================
* FormFpg.prg - Formulario de Cadastro Financeiro de Pagamentos
* Migrado de: SigCdFpg.SCX (frmcadastro)
* Tabela principal: SigCdPag (grupos, descrs, relprevs)
* Lookup: SigCdGcr (Codigos, Descrs)
*==============================================================================

DEFINE CLASS FormFpg AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: exatas do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro Financeiro de Pagamentos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Estado do formulario
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - REGRA CRITICA: apenas RETURN DODEFAULT()
    * FormBase.Init() chama InicializarForm() - NAO duplicar a chamada!
    * DataSession=2 -> FormBase.Init() tambem aplica SET DATE TO BRITISH +
    *                  SET CENTURY ON para corrigir exibicao de datas.
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente por FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("FpgBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar FpgBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormFpg.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormFpg:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormFpg.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Pagina.Top = -28 nesta form (conforme SCX original: linha 118)
    * Compensacao: +28 em todos os controles dentro das Pages
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -28
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 28
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

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1: cabecalho + botoes CRUD + grid
    * Legado: cntSombra, Grupo_op (5 botoes), Grupo_Saida, Grade
    * Compensacao +28 (Pagina.Top=-28)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Framework: Top=2; com compensacao +28 = 30
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
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
            .Caption   = THIS.Caption
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

        *-- Container Botoes CRUD (Grupo_op no legado)
        *-- Legado: Top=-1, Left=538; com compensacao: Top=28(-1+28+1~), Left=542 (canonico)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Container Saida - PADRAO CANONICO per CLAUDE.md regra #10
        *-- Grupo_Saida no legado. Canonico: Left=917, Top=28, Width=90, Height=85
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 28
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botoes CRUD dentro de cnt_4c_Botoes
        *-- Legado: Inserir.Left=5, Consultar.Left=80, Alterar.Left=155, Excluir.Left=230, procurar.Left=305
        *-- Top=5 em todos (Grupo_op.Top=-1+button.Top=5 -> absoluto=4+28=32; canonico top dentro container=5)
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

        *-- Botao Encerrar - PADRAO CANONICO per CLAUDE.md regra #10
        *-- Grupo_Saida.SAIR no legado: Top=5, Left=5; canonico Width=75, Height=75, Caption="Encerrar"
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

        *-- Grid de Lista (Grade no legado)
        *-- Legado: bindado a SigCdPag via AddCursor; pColuna define 'grupos' header="Grupos" width=80
        *-- Top: framework Grade Top=93; com compensacao +28 = 121. Left=12, Width=940, Height=470
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 121
            .Left               = 12
            .Width              = 940
            .Height             = 470
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .Visible            = .T.
        ENDWITH

        *-- BINDEVENTs: handlers devem ser PUBLIC (nao PROTECTED) para BINDEVENT funcionar
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2: botoes Salvar/Cancelar + campos
    * Campos (TextBox, OptionGroup) adicionados nas Fases seguintes
    * Compensacao +28 (Pagina.Top=-28)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Salvar/Cancelar (Grupo_Salva no legado)
        *-- Legado: Grupo_Salva.Salva.Top=5, Left=5, Cancelar.Left=80; canonico Left=842, Top=32
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 32
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

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

        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Label titulo do cadastro (lbl_cadastro no legado)
        *-- Legado: Top=163, compensacao +28 = 191; Left=255; FontBold=.T.; BackStyle=0
        loc_oPagina.AddObject("lbl_4c_Lbl_cadastro", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_cadastro
            .Caption    = "Cadastro de Contas a Pagar"
            .Top        = 191
            .Left       = 255
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .T.
            .Visible    = .T.
        ENDWITH

        *-- Label "Grupo :" (lbl_grupo no legado)
        *-- Legado: Top=186+28=214, Left=207, Width=38
        loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_grupo
            .Caption   = "Grupo :"
            .Top       = 214
            .Left      = 207
            .Width     = 38
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo do grupo (get_cd_grupo no legado)
        *-- Legado: Top=181+28=209, Left=254, Width=79, Height=23, MaxLength=10
        *-- When: pcEscolha $ 'INSERIR/PROCURAR' -> habilitado so em INCLUIR (grupos=PK)
        *-- Valid (fAcessoContab 'C'): valida codigo em SigCdGcr, preenche descricao
        loc_oPagina.AddObject("txt_4c__cd_grupo", "TextBox")
        WITH loc_oPagina.txt_4c__cd_grupo
            .Value     = ""
            .MaxLength = 10
            .Top       = 209
            .Left      = 254
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox descricao do grupo (get_ds_grupo no legado)
        *-- Legado: Top=181+28=209, Left=335, Width=150, Height=23, MaxLength=20
        *-- When: INSERIR/ALTERAR AND IsEmpty(cd_grupo) -> editavel quando codigo vazio
        *-- Valid (fAcessoContab 'D'): lookup por descricao em SigCdGcr, preenche cd_grupo
        loc_oPagina.AddObject("txt_4c__ds_grupo", "TextBox")
        WITH loc_oPagina.txt_4c__ds_grupo
            .Value     = ""
            .MaxLength = 20
            .Top       = 209
            .Left      = 335
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Tipo :" (Say11 no legado)
        *-- Legado: Top=211+28=239, Left=216, Width=29, Height=15
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "Tipo :"
            .Top       = 239
            .Left      = 216
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup "Real/Previsto" (op_con no legado)
        *-- Legado: Top=206+28=234, Left=254, Width=113, Height=25, Value=1 (Real)
        *-- relprevs: 1=Real, 2=Previsto; When: INSERIR/ALTERAR
        loc_oPagina.AddObject("opt_4c_Op_con", "OptionGroup")
        WITH loc_oPagina.opt_4c_Op_con
            .ButtonCount   = 2
            .Value         = 1
            .Top           = 234
            .Left          = 254
            .Width         = 118
            .Height        = 25
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        WITH loc_oPagina.opt_4c_Op_con.Buttons(1)
            .Caption   = "Real"
            .Left      = 5
            .Top       = 5
            .Width     = 40
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        WITH loc_oPagina.opt_4c_Op_con.Buttons(2)
            .Caption   = "Previsto"
            .Left      = 51
            .Top       = 5
            .Width     = 57
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- BINDEVENTs para lookup SigCdGcr (substitui fAcessoContab do legado)
        *-- F4(115)/Enter(13)/DblClick em cd_grupo: abre FormBuscaAuxiliar
        *-- LostFocus em cd_grupo: valida codigo, preenche descricao
        *-- LostFocus em ds_grupo: valida descricao, preenche codigo
        BINDEVENT(loc_oPagina.txt_4c__cd_grupo, "KeyPress",  THIS, "CdGrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c__cd_grupo, "DblClick",  THIS, "CdGrupoDblClick")
        BINDEVENT(loc_oPagina.txt_4c__cd_grupo, "KeyPress", THIS, "ValidarCdGrupo")
        BINDEVENT(loc_oPagina.txt_4c__ds_grupo, "KeyPress", THIS, "ValidarDsGrupo")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1
    * Chama FpgBO.Buscar() e vincula cursor_4c_Dados ao grd_4c_Lista
    * REGRA (Problema 36): RecordSource e ColumnCount FORA do WITH
    * REGRA (Problema 32): redefinir Headers APOS RecordSource
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- Problema 36: RecordSource e ColumnCount fora do WITH
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 3

                    *-- Problema 32: ControlSource e Headers APOS RecordSource (auto-bind reseta)
                    WITH loc_oGrid
                        .Column1.ControlSource   = "cursor_4c_Dados.grupos"
                        .Column1.Width           = 80
                        .Column1.Alignment       = 0
                        .Column1.Header1.Caption = "Grupo"

                        .Column2.ControlSource   = "cursor_4c_Dados.descrs"
                        .Column2.Width           = 560
                        .Column2.Alignment       = 0
                        .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                        .Column3.ControlSource   = "cursor_4c_Dados.relprevs"
                        .Column3.Width           = 80
                        .Column3.Alignment       = 2
                        .Column3.Header1.Caption = "Tipo"
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                ENDIF
                THIS.AjustarBotoesPorModo()
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
                "FormFpg.CarregarLista")
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

        CATCH TO loException
            MostrarErro("Erro ao alternar pagina:" + CHR(13) + loException.Message, ;
                "FormFpg.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
    * Legado: pcEscolha='INSERIR' -> SetFocus em get_cd_grupo
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.AjustarBotoesPorModo()
        CATCH TO loException
            MostrarErro("Erro ao incluir:" + CHR(13) + loException.Message, ;
                "FormFpg.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro selecionado e navega para Page2 (somente leitura)
    * Legado: pcEscolha='CONSULTAR' -> SetFocus em Grupo_Salva.Salva
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cGrupos
        loc_cGrupos = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro na lista!")
            ELSE
                SELECT cursor_4c_Dados
                loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                    THIS.AjustarBotoesPorModo()
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao visualizar:" + CHR(13) + loException.Message, ;
                "FormFpg.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado e navega para Page2 (editavel)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cGrupos
        loc_cGrupos = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro na lista!")
            ELSE
                SELECT cursor_4c_Dados
                loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AlternarPagina(2)
                    THIS.AjustarBotoesPorModo()
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alterar:" + CHR(13) + loException.Message, ;
                "FormFpg.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Confirma e exclui registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cGrupos
        loc_cGrupos = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro na lista!")
            ELSE
                SELECT cursor_4c_Dados
                loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)

                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do grupo '" + ;
                    loc_cGrupos + "'?", "Confirmar Exclus" + CHR(227) + "o")

                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Grupo exclu" + CHR(237) + "do com sucesso!")
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;
                "FormFpg.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar para filtrar lista (procurar no legado)
    * Legado: pcEscolha='PROCURAR' -> SetFocus em get_cd_grupo (modo busca)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cGrupos, loc_lSelecionou
        loc_cGrupos   = ""
        loc_lSelecionou = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPag", "cursor_4c_BuscaFpg", "grupos", "", ;
                "Buscar Grupo de Pagamento")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("grupos", "", "Grupo")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
                    SELECT cursor_4c_BuscaFpg
                    loc_cGrupos   = ALLTRIM(cursor_4c_BuscaFpg.grupos)
                    loc_lSelecionou = .T.
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaFpg")
                USE IN cursor_4c_BuscaFpg
            ENDIF

            IF loc_lSelecionou
                THIS.this_oBusinessObject.Buscar("grupos = " + EscaparSQL(loc_cGrupos))
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, ;
                "FormFpg.BtnBuscarClick")
            IF USED("cursor_4c_BuscaFpg")
                USE IN cursor_4c_BuscaFpg
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loException
            *-- Ignorar erros ao encerrar
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Transfere dados do Form para BO e salva
    * Legado: valida campo Grupos vazio em INSERIR, depois DoDefault -> mAtivapagina1
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cGrupos
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c__cd_grupo.Value)

        *-- Validacao pre-TRY (legado: "Grupo nao pode ficar em branco!")
        IF THIS.this_cModoAtual = "INCLUIR" AND EMPTY(loc_cGrupos)
            MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!")
            IF VARTYPE(loc_oPagina.txt_4c__cd_grupo) = "O"
                loc_oPagina.txt_4c__cd_grupo.SetFocus()
            ENDIF
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, ;
                "FormFpg.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para lista
    * Legado: Grupo_Salva.Cancelar.Click -> dodefault() -> mAtivapagina1
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.AlternarPagina(1)
        CATCH TO loException
            MostrarErro("Erro ao cancelar:" + CHR(13) + loException.Message, ;
                "FormFpg.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    * Implementacao base: controla botoes de Page1. Estendido em fases seguintes.
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Confirmar desabilitado em VISUALIZAR
            IF VARTYPE(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
                loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
            ENDIF

            *-- grupos = PK: editavel somente em INCLUIR (legado: When='INSERIR/PROCURAR')
            IF VARTYPE(loc_oPagina.txt_4c__cd_grupo) = "O"
                loc_oPagina.txt_4c__cd_grupo.ReadOnly = !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
            ENDIF

            *-- descricao: editavel em INCLUIR/ALTERAR (legado: When='INSERIR/ALTERAR')
            IF VARTYPE(loc_oPagina.txt_4c__ds_grupo) = "O"
                loc_oPagina.txt_4c__ds_grupo.ReadOnly = !par_lHabilitar
            ENDIF

            *-- tipo Real/Previsto: habilitado em INCLUIR/ALTERAR (legado: When='INSERIR/ALTERAR')
            IF VARTYPE(loc_oPagina.opt_4c_Op_con) = "O"
                loc_oPagina.opt_4c_Op_con.Enabled = par_lHabilitar
            ENDIF

        CATCH TO loException
            *-- Ignorar erros de controles ainda nao disponiveis
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa campos da Page2 e reseta propriedades do BO
    * Implementacao base limpa o BO. Estendida em fases seguintes com controles.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        TRY
            THIS.this_oBusinessObject.this_cGrupos   = ""
            THIS.this_oBusinessObject.this_cDescrs   = ""
            THIS.this_oBusinessObject.this_nRelprevs = 0

            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPagina = THIS.pgf_4c_Paginas.Page2
                IF VARTYPE(loc_oPagina.txt_4c__cd_grupo) = "O"
                    loc_oPagina.txt_4c__cd_grupo.Value = ""
                ENDIF
                IF VARTYPE(loc_oPagina.txt_4c__ds_grupo) = "O"
                    loc_oPagina.txt_4c__ds_grupo.Value = ""
                ENDIF
                IF VARTYPE(loc_oPagina.opt_4c_Op_con) = "O"
                    loc_oPagina.opt_4c_Op_con.Value = 1
                ENDIF
            ENDIF
        CATCH TO loException
            *-- Ignorar erros durante limpeza
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere dados dos controles da Page2 para o BO
    * Implementacao base. Estendida em fases seguintes quando controles forem adicionados.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Business Object n" + CHR(227) + "o inicializado", ;
                    "FormFpg.FormParaBO")
            ELSE
                loc_oPagina = THIS.pgf_4c_Paginas.Page2
                THIS.this_oBusinessObject.this_cGrupos   = ALLTRIM(loc_oPagina.txt_4c__cd_grupo.Value)
                THIS.this_oBusinessObject.this_cDescrs   = ALLTRIM(loc_oPagina.txt_4c__ds_grupo.Value)
                THIS.this_oBusinessObject.this_nRelprevs = loc_oPagina.opt_4c_Op_con.Value
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em FormParaBO:" + CHR(13) + loException.Message, ;
                "FormFpg.FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do BO para os controles da Page2
    * Implementacao base. Estendida em fases seguintes quando controles forem adicionados.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_nRelprevs
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Business Object n" + CHR(227) + "o inicializado", ;
                    "FormFpg.BOParaForm")
            ELSE
                loc_oPagina   = THIS.pgf_4c_Paginas.Page2
                loc_nRelprevs = THIS.this_oBusinessObject.this_nRelprevs

                loc_oPagina.txt_4c__cd_grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
                loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
                loc_oPagina.opt_4c_Op_con.Value    = IIF(loc_nRelprevs >= 1 AND loc_nRelprevs <= 2, loc_nRelprevs, 1)
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em BOParaForm:" + CHR(13) + loException.Message, ;
                "FormFpg.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * REGRA: chamar SEMPRE com parametro (nao sem parametro)
    *==========================================================================
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

    *==========================================================================
    * FormatarGridLista - Aplica formatacao visual padrao ao grid
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes de Page1 conforme selecao
    * e ajusta foco em Page2 conforme this_cModoAtual
    * Legado: Click handler usava pcEscolha para SetFocus em INSERIR vs CONSULTAR
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lTemRegistro

        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page1
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
                !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0

            *-- Botoes que requerem selecao: Visualizar, Alterar, Excluir
            IF VARTYPE(loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar) = "O"
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
            ENDIF
            IF VARTYPE(loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar) = "O"
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
            ENDIF
            IF VARTYPE(loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir) = "O"
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
            ENDIF

            *-- Confirmar desabilitado em VISUALIZAR
            IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
            ENDIF

            *-- Foco em Page2 conforme modo (legado: INSERIR/PROCURAR -> cd_grupo; CONSULTAR -> Salva)
            IF THIS.pgf_4c_Paginas.ActivePage = 2
                DO CASE
                    CASE THIS.this_cModoAtual = "INCLUIR"
                        IF VARTYPE(loc_oPg2.txt_4c__cd_grupo) = "O"
                            loc_oPg2.txt_4c__cd_grupo.SetFocus()
                        ENDIF
                    CASE THIS.this_cModoAtual = "ALTERAR"
                        IF VARTYPE(loc_oPg2.txt_4c__ds_grupo) = "O"
                            loc_oPg2.txt_4c__ds_grupo.SetFocus()
                        ENDIF
                    CASE THIS.this_cModoAtual = "VISUALIZAR"
                        IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar) = "O"
                            loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.SetFocus()
                        ENDIF
                ENDCASE
            ENDIF

        CATCH TO loException
            *-- Ignorar erros ao ajustar botoes (form pode estar em transicao)
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
        CATCH TO loException
            *-- Ignorar erros no Destroy para nao bloquear fechamento
        ENDTRY

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * HANDLERS DE LOOKUP - Grupo Conta Corrente (SigCdGcr)
    * Substitui fAcessoContab(Usuar,'C',valor,...) / fAcessoContab(Usuar,'D',...)
    * Campos em SigCdGcr: Codigos (PK), Descrs (descricao)
    *==========================================================================

    PROCEDURE CdGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoGcr()
        ENDIF
    ENDPROC

    PROCEDURE CdGrupoDblClick()
        THIS.AbrirLookupGrupoGcr()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdGrupo - LostFocus de txt_4c__cd_grupo
    * Valida codigo em SigCdGcr e preenche descricao (equivale fAcessoContab 'C')
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdGrupo
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cCodigo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c__cd_grupo.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPagina.txt_4c__ds_grupo.Value = ""
            RETURN
        ENDIF

        THIS.this_oBusinessObject.BuscarGrupoGcr(loc_cCodigo, "C", "cursor_4c_GcrVal")

        IF USED("cursor_4c_GcrVal") AND RECCOUNT("cursor_4c_GcrVal") > 0
            SELECT cursor_4c_GcrVal
            loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_GcrVal.descrs)
        ENDIF

        IF USED("cursor_4c_GcrVal")
            USE IN cursor_4c_GcrVal
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsGrupo - LostFocus de txt_4c__ds_grupo
    * Valida descricao em SigCdGcr e preenche codigo (equivale fAcessoContab 'D')
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsGrupo
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cDescricao
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c__ds_grupo.Value)

        IF EMPTY(loc_cDescricao)
            loc_oPagina.txt_4c__cd_grupo.Value = ""
            RETURN
        ENDIF

        THIS.this_oBusinessObject.BuscarGrupoGcr(loc_cDescricao, "D", "cursor_4c_GcrDVal")

        IF USED("cursor_4c_GcrDVal") AND RECCOUNT("cursor_4c_GcrDVal") > 0
            SELECT cursor_4c_GcrDVal
            IF RECCOUNT("cursor_4c_GcrDVal") = 1
                loc_oPagina.txt_4c__cd_grupo.Value = ALLTRIM(cursor_4c_GcrDVal.grupos)
                loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_GcrDVal.descrs)
            ELSE
                THIS.AbrirLookupGrupoGcr()
            ENDIF
        ENDIF

        IF USED("cursor_4c_GcrDVal")
            USE IN cursor_4c_GcrDVal
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupoGcr - Abre FormBuscaAuxiliar para SigCdGcr
    * Preenche txt_4c__cd_grupo e txt_4c__ds_grupo com selecao do usuario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupGrupoGcr()
        LOCAL loc_oBusca, loc_oPagina, loc_cCodigo
        loc_oBusca  = .NULL.
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c__cd_grupo.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "Grupos", ;
                loc_cCodigo, "Grupo de Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    loc_oPagina.txt_4c__cd_grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.Grupos)
                    loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir lookup Grupo GCR:" + CHR(13) + loException.Message, ;
                "FormFpg.AbrirLookupGrupoGcr")
        ENDTRY

        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\FpgBO.prg):
*====================================================================
* FpgBO.prg
*
* Business Object para Cadastro Financeiro de Pagamentos
* Tabela: SigCdPag
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS FpgBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdPag)
    this_cGrupos   = ""    && grupos char(10) - PK
    this_cDescrs   = ""    && descrs char(30)
    this_nRelprevs = 0     && relprevs numeric(1,0) - 1=Real, 2=Previsto

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPag"
            THIS.this_cCampoChave = "grupos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "FpgBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cGrupos   = TratarNulo(grupos,   "C")
                THIS.this_cDescrs   = TratarNulo(descrs,   "C")
                THIS.this_nRelprevs = TratarNulo(relprevs, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "FpgBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cGrupos)
            MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarGrupoExistente(THIS.this_cGrupos)
                MsgAviso("Grupo j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarGrupoExistente - Verifica se grupos ja existe no banco
    *====================================================================
    PROCEDURE VerificarGrupoExistente(par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPag" + ;
                " WHERE grupos = " + EscaparSQL(par_cGrupos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkGrp")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkGrp")
                SELECT cursor_4c_ChkGrp
                loc_lExiste = (cursor_4c_ChkGrp.qtd > 0)
                USE IN cursor_4c_ChkGrp
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar grupo:" + CHR(13) + loException.Message, "FpgBO.VerificarGrupoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdPag
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdPag (grupos, descrs, relprevs)
                VALUES (
                    <<EscaparSQL(THIS.this_cGrupos)>>,
                    <<EscaparSQL(THIS.this_cDescrs)>>,
                    <<FormatarNumeroSQL(THIS.this_nRelprevs, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "FpgBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdPag
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdPag
                SET descrs   = <<EscaparSQL(THIS.this_cDescrs)>>,
                    relprevs = <<FormatarNumeroSQL(THIS.this_nRelprevs, 0)>>
                WHERE grupos = <<EscaparSQL(THIS.this_cGrupos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "FpgBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdPag
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPag WHERE grupos = " + EscaparSQL(THIS.this_cGrupos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "FpgBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com grupos, descrs, relprevs
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (grupos C(10), descrs C(30), relprevs N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT grupos, descrs, relprevs FROM SigCdPag"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY grupos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FpgBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (grupos)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT grupos, descrs, relprevs FROM SigCdPag" + ;
                " WHERE grupos = " + EscaparSQL(par_cGrupos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Grupo de pagamento n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "FpgBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarGrupoGcr - Busca grupo de conta corrente em SigCdGcr
    * Usado pelo Form para validar/lookup do campo grupos via fAcessoContab
    * Substitui fAcessoContab(Usuar,'C',codigo,...) e
    *          fAcessoContab(Usuar,'D',descricao,...)
    *====================================================================
    PROCEDURE BuscarGrupoGcr(par_cValor, par_cModo, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCursorDest
        loc_lSucesso = .F.
        loc_cCursorDest = IIF(VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino), ;
            par_cCursorDestino, "cursor_4c_BuscaGcr")

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lSucesso = .T.
            ELSE
                DO CASE
                    CASE UPPER(ALLTRIM(par_cModo)) = "C"
                        loc_cSQL = "SELECT grupos, descrs FROM SigCdGcr" + ;
                            " WHERE grupos = " + EscaparSQL(par_cValor)
                    CASE UPPER(ALLTRIM(par_cModo)) = "D"
                        loc_cSQL = "SELECT grupos, descrs FROM SigCdGcr" + ;
                            " WHERE UPPER(RTRIM(descrs)) LIKE UPPER(" + EscaparSQL(par_cValor + "%") + ")"
                    OTHERWISE
                        loc_cSQL = "SELECT grupos, descrs FROM SigCdGcr ORDER BY grupos"
                ENDCASE

                IF USED(loc_cCursorDest)
                    USE IN (loc_cCursorDest)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorDest)
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar grupo conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar grupo GCR:" + CHR(13) + loException.Message, "FpgBO.BuscarGrupoGcr")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

