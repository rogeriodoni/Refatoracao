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
[2026-07-24 21:34:35] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-24 21:34:35] [INFO] Config FPW: (nao fornecido)
[2026-07-24 21:34:35] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-24 21:34:35] [INFO] Timeout: 300 segundos
[2026-07-24 21:34:35] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2hu4cdmb.prg
[2026-07-24 21:34:35] [INFO] Conteudo do wrapper:
[2026-07-24 21:34:35] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCeg', 'C:\4c\tasks\task361', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCeg', 'C:\4c\tasks\task361', 'CRUD'
QUIT

[2026-07-24 21:34:35] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2hu4cdmb.prg
[2026-07-24 21:34:35] [INFO] VFP output esperado em: C:\4c\tasks\task361\vfp_output.txt
[2026-07-24 21:34:35] [INFO] Executando Visual FoxPro 9...
[2026-07-24 21:34:35] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2hu4cdmb.prg
[2026-07-24 21:34:35] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2hu4cdmb.prg
[2026-07-24 21:34:35] [INFO] Timeout configurado: 300 segundos
[2026-07-24 21:35:13] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-24 21:35:13] [INFO] VFP9 finalizado em 37.5263281 segundos
[2026-07-24 21:35:13] [INFO] Exit Code: 
[2026-07-24 21:35:13] [INFO] 
[2026-07-24 21:35:13] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-24 21:35:13] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2hu4cdmb.prg
[2026-07-24 21:35:13] [INFO] 
[2026-07-24 21:35:13] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-24 21:35:13] [INFO] * Auto-generated wrapper for parameters
[2026-07-24 21:35:13] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-24 21:35:13] [INFO] * Parameters: 'FormCeg', 'C:\4c\tasks\task361', 'CRUD'
[2026-07-24 21:35:13] [INFO] 
[2026-07-24 21:35:13] [INFO] * Anti-dialog protections for unattended execution
[2026-07-24 21:35:13] [INFO] SET SAFETY OFF
[2026-07-24 21:35:13] [INFO] SET RESOURCE OFF
[2026-07-24 21:35:13] [INFO] SET TALK OFF
[2026-07-24 21:35:13] [INFO] SET NOTIFY OFF
[2026-07-24 21:35:13] [INFO] SYS(2335, 0)
[2026-07-24 21:35:13] [INFO] 
[2026-07-24 21:35:13] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCeg', 'C:\4c\tasks\task361', 'CRUD'
[2026-07-24 21:35:13] [INFO] QUIT
[2026-07-24 21:35:13] [INFO] 
[2026-07-24 21:35:13] [INFO] === Fim do Wrapper.prg ===
[2026-07-24 21:35:13] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-24 21:36:25] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-24 21:36:25] [INFO] Config FPW: (nao fornecido)
[2026-07-24 21:36:25] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-24 21:36:25] [INFO] Timeout: 300 segundos
[2026-07-24 21:36:25] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qubhezkw.prg
[2026-07-24 21:36:25] [INFO] Conteudo do wrapper:
[2026-07-24 21:36:25] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCeg', 'C:\4c\tasks\task361', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCeg', 'C:\4c\tasks\task361', 'CRUD'
QUIT

[2026-07-24 21:36:25] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qubhezkw.prg
[2026-07-24 21:36:25] [INFO] VFP output esperado em: C:\4c\tasks\task361\vfp_output.txt
[2026-07-24 21:36:25] [INFO] Executando Visual FoxPro 9...
[2026-07-24 21:36:25] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qubhezkw.prg
[2026-07-24 21:36:25] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qubhezkw.prg
[2026-07-24 21:36:25] [INFO] Timeout configurado: 300 segundos
[2026-07-24 21:37:08] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-24 21:37:08] [INFO] VFP9 finalizado em 43.0486207 segundos
[2026-07-24 21:37:08] [INFO] Exit Code: 
[2026-07-24 21:37:08] [INFO] 
[2026-07-24 21:37:08] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-24 21:37:08] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qubhezkw.prg
[2026-07-24 21:37:08] [INFO] 
[2026-07-24 21:37:08] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-24 21:37:08] [INFO] * Auto-generated wrapper for parameters
[2026-07-24 21:37:08] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-24 21:37:08] [INFO] * Parameters: 'FormCeg', 'C:\4c\tasks\task361', 'CRUD'
[2026-07-24 21:37:08] [INFO] 
[2026-07-24 21:37:08] [INFO] * Anti-dialog protections for unattended execution
[2026-07-24 21:37:08] [INFO] SET SAFETY OFF
[2026-07-24 21:37:08] [INFO] SET RESOURCE OFF
[2026-07-24 21:37:08] [INFO] SET TALK OFF
[2026-07-24 21:37:08] [INFO] SET NOTIFY OFF
[2026-07-24 21:37:08] [INFO] SYS(2335, 0)
[2026-07-24 21:37:08] [INFO] 
[2026-07-24 21:37:08] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCeg', 'C:\4c\tasks\task361', 'CRUD'
[2026-07-24 21:37:08] [INFO] QUIT
[2026-07-24 21:37:08] [INFO] 
[2026-07-24 21:37:08] [INFO] === Fim do Wrapper.prg ===
[2026-07-24 21:37:08] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormCeg",
  "timestamp": "20260724213708",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCeg.prg):
*==============================================================================
* FormCeg.PRG - Completo (Fases 1-8)
* Formulario de Cadastro de Prioridade de Estoque p/Globalizacao
*
* Tabela: SigCdCeg (cidchaves PK)
* Tipo: CRUD (frmcadastro)
* BO: CegBO
*==============================================================================

DEFINE CLASS FormCeg AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Prioridade de Estoque p/Globaliza" + CHR(231) + CHR(227) + "o"
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
    this_cCidchavesAtual = ""

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.Init")
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
            THIS.this_oBusinessObject = CREATEOBJECT("CegBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar CegBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.InicializarForm")
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
            .PageCount       = 2
            .Top             = -29
            .Left            = 0
            .Width           = THIS.Width
            .Height          = THIS.Height + 29
            .Tabs            = .F.
            .Visible         = .T.
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
    * ConfigurarPaginaLista - Configura Page1: cabecalho + botoes + grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho cinza (Top = 2 + 29 = 31)
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

        *-- Container botoes CRUD - canonico: Top=29 (0+29), Left=542, Width=390, Height=85
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

        *-- Container Saida - canonico: Top=29 (0+29), Left=917, Width=90, Height=85
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

        *-- Grid de lista - Top=117 (88+29), Left=26, Width=890, Height=498
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista
        loc_oGrid.ColumnCount = 5
        WITH loc_oGrid
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 498
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
        ENDWITH
        loc_oGrid.Column1.Width           = 70
        loc_oGrid.Column2.Width           = 120
        loc_oGrid.Column3.Width           = 120
        loc_oGrid.Column4.Width           = 60
        loc_oGrid.Column5.Width           = 490
        loc_oGrid.Column1.Header1.Caption = "Prioridade"
        loc_oGrid.Column2.Header1.Caption = "Grupo"
        loc_oGrid.Column3.Header1.Caption = "Conta"
        loc_oGrid.Column4.Header1.Caption = "Empresa"
        loc_oGrid.Column5.Header1.Caption = "Nome Empresa"
        loc_oGrid.Column1.Alignment       = 2
        loc_oGrid.Column4.Alignment       = 2

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2: cabecalho + botoes acao
    * Campos de dados (txt_4c_*) adicionados na Fase 5
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oCab, loc_oBotoesAcao

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container cabecalho cinza (Top = 2 + 29 = 31)
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

        *-- Container botoes Confirmar/Cancelar - canonico: Top=33 (4+29), Left=842, Width=160, Height=85
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

        *-- Botao Confirmar (Salvar)
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

        *-- Botao Cancelar
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

        *-- Label e TextBox: Grupo (Say1 / Get_Grupo no legado - Top=192+29=221)
        loc_oPg2.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPg2.lbl_4c_Grupo
            .AutoSize  = .F.
            .Caption   = "Grupo :"
            .Top       = 221
            .Left      = 139
            .Width     = 44
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPg2.txt_4c_Grupo
            .Value     = ""
            .Top       = 219
            .Left      = 183
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .MaxLength = 15
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
        BINDEVENT(loc_oPg2.txt_4c_Grupo, "KeyPress",  THIS, "TeclaGrupo")

        *-- Label e TextBox: Conta (Say3 / get_Conta no legado - Top=224+29=253)
        loc_oPg2.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oPg2.lbl_4c_Conta
            .AutoSize  = .F.
            .Caption   = "Conta :"
            .Top       = 253
            .Left      = 139
            .Width     = 44
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPg2.txt_4c_Conta
            .Value     = ""
            .Top       = 250
            .Left      = 183
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .MaxLength = 15
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")
        BINDEVENT(loc_oPg2.txt_4c_Conta, "KeyPress",  THIS, "TeclaConta")

        *-- Label e TextBox: Prioridade (Say2 / Get_codigo no legado - Top=252+29=281)
        loc_oPg2.AddObject("lbl_4c_Priors", "Label")
        WITH loc_oPg2.lbl_4c_Priors
            .AutoSize  = .F.
            .Caption   = "Prioridade :"
            .Top       = 281
            .Left      = 120
            .Width     = 63
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Priors", "TextBox")
        WITH loc_oPg2.txt_4c_Priors
            .Value     = 0
            .Top       = 279
            .Left      = 183
            .Width     = 24
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .InputMask = "99"
            .MaxLength = 2
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        *-- Label e TextBox: Empresa (Say22/Get_Emps no legado - Top=281+29=310 / 277+29=306)
        loc_oPg2.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPg2.lbl_4c_Empresa
            .AutoSize  = .F.
            .Caption   = "Empresa :"
            .Top       = 310
            .Left      = 127
            .Width     = 56
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPg2.txt_4c_Emps
            .Value             = ""
            .Top               = 306
            .Left              = 183
            .Width             = 31
            .Height            = 23
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .MaxLength         = 3
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 255)
            .Enabled           = .T.
            .Visible           = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_Emps, "KeyPress", THIS, "ValidarEmps")
        BINDEVENT(loc_oPg2.txt_4c_Emps, "KeyPress",  THIS, "TeclaEmps")

        *-- TextBox: Nome da empresa (Get_DEmps no legado - Top=277+29=306, Left=215)
        *-- Editavel em INCLUIR/ALTERAR quando Emps estiver vazio (busca por nome)
        loc_oPg2.AddObject("txt_4c_DEmps", "TextBox")
        WITH loc_oPg2.txt_4c_DEmps
            .Value     = ""
            .Top       = 306
            .Left      = 215
            .Width     = 290
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .MaxLength = 40
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_DEmps, "KeyPress", THIS, "ValidarDEmps")
        BINDEVENT(loc_oPg2.txt_4c_DEmps, "KeyPress",  THIS, "TeclaDEmps")

        *-- Label: Tipo (Say4 no legado - Top=309+29=338)
        loc_oPg2.AddObject("lbl_4c_TpCad", "Label")
        WITH loc_oPg2.lbl_4c_TpCad
            .AutoSize  = .F.
            .Caption   = "Tipo :"
            .Top       = 338
            .Left      = 148
            .Width     = 35
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup: Tipo de cadastro (Opc_TpCad no legado - Top=305+29=334)
        *-- Value=2 default (Globalizacao selecionado)
        loc_oPg2.AddObject("opt_4c_TpCad", "OptionGroup")
        WITH loc_oPg2.opt_4c_TpCad
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Top         = 334
            .Left        = 177
            .Width       = 322
            .Height      = 28
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "\<Pedido Autom" + CHR(225) + "tico"
                .Left      = 5
                .Top       = 5
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<Globaliza" + CHR(231) + CHR(227) + "o"
                .Left      = 134
                .Top       = 5
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Distribui" + CHR(231) + CHR(227) + "o"
                .Left      = 233
                .Top       = 5
                .Height    = 15
                .Width     = 73
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no grid de Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                CREATE CURSOR cursor_4c_Dados (cidchaves C(20), priors N(2,0), grupos C(10), contas C(10), emps C(3), Razas C(40))
                loc_lResultado = .T.
            ELSE
                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object n" + CHR(227) + "o inicializado", "FormCeg.CarregarLista")
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                *-- Desconectar RecordSource antes do SQLEXEC para preservar colunas do grid
                loc_oGrid.RecordSource = ""
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid.ColumnCount = 5
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    *-- Redefinir ControlSource APOS RecordSource (VFP auto-bind ignora definicoes anteriores)
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.priors"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.grupos"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.contas"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.emps"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Razas"
                    *-- Redefinir cabecalhos apos RecordSource (VFP reseta headers)
                    loc_oGrid.Column1.Header1.Caption = "Prioridade"
                    loc_oGrid.Column2.Header1.Caption = "Grupo"
                    loc_oGrid.Column3.Header1.Caption = "Conta"
                    loc_oGrid.Column4.Header1.Caption = "Empresa"
                    loc_oGrid.Column5.Header1.Caption = "Nome Empresa"
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre Page1 (lista) e Page2 (dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara novo registro e navega para Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cCidchavesAtual = ""
            THIS.this_cModoAtual      = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.BtnIncluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lResultado, loc_cCidchaves
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado para visualizar.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
                IF EMPTY(loc_cCidchaves)
                    MsgAviso("Nenhum registro selecionado para visualizar.", "Aviso")
                ELSE
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                    THIS.this_cCidchavesAtual = loc_cCidchaves
                    THIS.this_cModoAtual      = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                    loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lResultado, loc_cCidchaves
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado para alterar.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
                IF EMPTY(loc_cCidchaves)
                    MsgAviso("Nenhum registro selecionado para alterar.", "Aviso")
                ELSE
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cCidchavesAtual = loc_cCidchaves
                    THIS.this_cModoAtual      = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AlternarPagina(2)
                    loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e exclui registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_cCidchaves, loc_lConfirma
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado para excluir.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
                IF EMPTY(loc_cCidchaves)
                    MsgAviso("Nenhum registro selecionado para excluir.", "Aviso")
                ELSE
                    loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", ;
                                                "Confirmar Exclus" + CHR(227) + "o")
                    IF loc_lConfirma
                        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                            IF THIS.this_oBusinessObject.Excluir()
                                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                                THIS.CarregarLista()
                                loc_lResultado = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Filtra lista por grupo
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lResultado, loc_cFiltro, loc_oGrid
        loc_lResultado = .F.

        TRY
            loc_cFiltro = INPUTBOX("Filtrar por Grupo (vazio = todos):", ;
                                   "Buscar Prioridades", "")
            IF TYPE("loc_cFiltro") = "C"
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                *-- Desconectar RecordSource antes do SQLEXEC
                loc_oGrid.RecordSource = ""
                IF THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
                    loc_oGrid.ColumnCount = 5
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    *-- Redefinir ControlSource APOS RecordSource (VFP auto-bind ignora definicoes anteriores)
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.priors"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.grupos"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.contas"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.emps"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Razas"
                    loc_oGrid.Column1.Header1.Caption = "Prioridade"
                    loc_oGrid.Column2.Header1.Caption = "Grupo"
                    loc_oGrid.Column3.Header1.Caption = "Conta"
                    loc_oGrid.Column4.Header1.Caption = "Empresa"
                    loc_oGrid.Column5.Header1.Caption = "Nome Empresa"
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.BtnBuscarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida, transfere Form->BO e salva registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oPg2, loc_cGrupo, loc_cConta, loc_nTpCads
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Ler valores do form (com guards para controles de fases posteriores)
        loc_cGrupo  = ""
        loc_cConta  = ""
        loc_nTpCads = THIS.this_oBusinessObject.this_nTpCads
        IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
            loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
            loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "opt_4c_TpCad", 5)
            loc_nTpCads = loc_oPg2.opt_4c_TpCad.Value
        ENDIF

        *-- Validacoes FORA do TRY (regra critica: RETURN fora de TRY)
        IF EMPTY(loc_cGrupo)
            MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", "Campo Obrigat" + CHR(243) + "rio")
            RETURN .F.
        ENDIF
        IF loc_nTpCads > 2 AND EMPTY(loc_cConta)
            MsgAviso("Conta n" + CHR(227) + "o pode ficar em branco para este tipo!", "Campo Obrigat" + CHR(243) + "rio")
            RETURN .F.
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Sucesso")
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Descarta alteracoes e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do formulario para o Business Object
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oCtrl
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Grupo
                IF VARTYPE(loc_oCtrl) = "O"
                    THIS.this_oBusinessObject.this_cGrupos = ALLTRIM(loc_oCtrl.Value)
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Conta
                IF VARTYPE(loc_oCtrl) = "O"
                    THIS.this_oBusinessObject.this_cContas = ALLTRIM(loc_oCtrl.Value)
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Priors", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Priors
                IF VARTYPE(loc_oCtrl) = "O"
                    THIS.this_oBusinessObject.this_nPriors = loc_oCtrl.Value
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Emps
                IF VARTYPE(loc_oCtrl) = "O"
                    THIS.this_oBusinessObject.this_cEmps = ALLTRIM(loc_oCtrl.Value)
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_TpCad", 5)
                loc_oCtrl = loc_oPg2.opt_4c_TpCad
                IF VARTYPE(loc_oCtrl) = "O"
                    THIS.this_oBusinessObject.this_nTpCads = loc_oCtrl.Value
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do Business Object para o formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oCtrl
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Grupo
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Conta
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Value = ALLTRIM(THIS.this_oBusinessObject.this_cContas)
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Priors", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Priors
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Value = THIS.this_oBusinessObject.this_nPriors
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Emps
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Value = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DEmps", 5)
                loc_oCtrl = loc_oPg2.txt_4c_DEmps
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDEmps)
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_TpCad", 5)
                loc_oCtrl = loc_oPg2.opt_4c_TpCad
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Value = THIS.this_oBusinessObject.this_nTpCads
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos de Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2, loc_oCtrl
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Grupo
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Value = ""
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Conta
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Value = ""
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Priors", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Priors
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Value = 0
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Emps
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Value = ""
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DEmps", 5)
                loc_oCtrl = loc_oPg2.txt_4c_DEmps
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Value = ""
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_TpCad", 5)
                loc_oCtrl = loc_oPg2.opt_4c_TpCad
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Value = 1
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos editaveis de Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_oCtrl, loc_lGrupoEditavel
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            *-- Grupo e Conta: editaveis apenas em INCLUIR (PK composta)
            loc_lGrupoEditavel = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")

            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Grupo
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Enabled = loc_lGrupoEditavel
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Conta
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Enabled = loc_lGrupoEditavel
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Priors", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Priors
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Enabled = par_lHabilitar
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5)
                loc_oCtrl = loc_oPg2.txt_4c_Emps
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Enabled = par_lHabilitar
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DEmps", 5)
                loc_oCtrl = loc_oPg2.txt_4c_DEmps
                IF VARTYPE(loc_oCtrl) = "O"
                    *-- DEmps editavel em INCLUIR/ALTERAR quando Emps estiver vazio (busca por nome)
                    IF PEMSTATUS(loc_oPg2, "txt_4c_Emps", 5) AND VARTYPE(loc_oPg2.txt_4c_Emps) = "O"
                        loc_oCtrl.Enabled = par_lHabilitar AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_Emps.Value))
                    ELSE
                        loc_oCtrl.Enabled = par_lHabilitar
                    ENDIF
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_TpCad", 5)
                loc_oCtrl = loc_oPg2.opt_4c_TpCad
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Enabled = par_lHabilitar
                ENDIF
            ENDIF
            *-- Botao Confirmar: habilitado em INCLUIR/ALTERAR; desabilitado em VISUALIZAR
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oCtrl = loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar
                IF VARTYPE(loc_oCtrl) = "O"
                    loc_oCtrl.Enabled = par_lHabilitar
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    * ValidarGrupo - LostFocus handler para txt_4c_Grupo
    * Lookup em SigCdGcr (Grupos de Conta Corrente)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_oPg2
        TRY
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
            IF !EMPTY(loc_cGrupo)
                THIS.AbrirBuscaGrupo(loc_cGrupo)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.ValidarGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaGrupo - KeyPress handler para txt_4c_Grupo (F4 abre lookup)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaGrupo(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupo - Abre FormBuscaAuxiliar para SigCdGcr
    * Campos: Codigos (PK) / Descrs (descricao do grupo)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrupo(par_cValor)
        LOCAL loc_oBusca, loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", par_cValor, ;
                "Grupos de Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGrupo")
                        loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                        loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.AbrirBuscaGrupo")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConta - LostFocus handler para txt_4c_Conta
    * Lookup em SigCdCli (clientes - contas correntes via fAcessoContas)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cConta, loc_cGrupo, loc_oPg2
        TRY
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
            loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
            IF !EMPTY(loc_cConta)
                THIS.AbrirBuscaConta(loc_cGrupo, loc_cConta)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.ValidarConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaConta - KeyPress handler para txt_4c_Conta (F4 abre lookup)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            LOCAL loc_oPg2
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            THIS.AbrirBuscaConta(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value), ;
                                 ALLTRIM(loc_oPg2.txt_4c_Conta.Value))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaConta - Abre FormBuscaAuxiliar para SigCdCli (contas correntes)
    * Campos: Iclis (PK conta) / Rclis (razao social)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaConta(par_cGrupo, par_cValor)
        LOCAL loc_oBusca, loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaConta", "Iclis", par_cValor, ;
                "Clientes / Contas")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaConta")
                        loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Iclis",  "", "Conta")
                    loc_oBusca.mAddColuna("Rclis",  "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                        loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.AbrirBuscaConta")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmps - LostFocus handler para txt_4c_Emps
    * Lookup em SigCdEmp por codigo (Cemps) - preenche tambem txt_4c_DEmps
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmps(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cEmps, loc_oPg2
        TRY
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2
            loc_cEmps = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
            IF !EMPTY(loc_cEmps)
                THIS.AbrirBuscaEmps(loc_cEmps)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.ValidarEmps")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmps - KeyPress handler para txt_4c_Emps (F4 abre lookup)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmps(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaEmps(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.Value))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmps - Abre FormBuscaAuxiliar para SigCdEmp por codigo (Cemps)
    * Preenche txt_4c_Emps (codigo) e txt_4c_DEmps (razao social/Razas)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEmps(par_cValor)
        LOCAL loc_oBusca, loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", par_cValor, ;
                "Empresas")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaEmp")
                        loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.AbrirBuscaEmps")
        ENDTRY

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDEmps - LostFocus handler para txt_4c_DEmps
    * Busca empresa por nome (Razas) - preenche tambem txt_4c_Emps
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDEmps(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDEmps, loc_oPg2
        TRY
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cDEmps = ALLTRIM(loc_oPg2.txt_4c_DEmps.Value)
            IF !EMPTY(loc_cDEmps)
                THIS.AbrirBuscaDEmps(loc_cDEmps)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.ValidarDEmps")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDEmps - KeyPress handler para txt_4c_DEmps (F4 abre lookup)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDEmps(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaDEmps(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DEmps.Value))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDEmps - Abre FormBuscaAuxiliar para SigCdEmp por nome (Razas)
    * Preenche txt_4c_DEmps (nome) e txt_4c_Emps (codigo/Cemps)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDEmps(par_cValor)
        LOCAL loc_oBusca, loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaDEmp", "Razas", par_cValor, ;
                "Empresas")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaDEmp")
                        loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaDEmp.Cemps)
                        loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaDEmp.Razas)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDEmp")
                        loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaDEmp.Cemps)
                        loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaDEmp.Razas)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.AbrirBuscaDEmps")
        ENDTRY

        IF USED("cursor_4c_BuscaDEmp")
            USE IN cursor_4c_BuscaDEmp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD da Page1 por modo
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoes, loc_lTemRegistro
        TRY
            loc_oBotoes    = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")

            IF PEMSTATUS(loc_oBotoes, "cmd_4c_Visualizar", 5)
                loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
            ENDIF
            IF PEMSTATUS(loc_oBotoes, "cmd_4c_Alterar", 5)
                loc_oBotoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
            ENDIF
            IF PEMSTATUS(loc_oBotoes, "cmd_4c_Excluir", 5)
                loc_oBotoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Aplica formatacao visual ao grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormCeg.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\CegBO.prg):
*====================================================================
* CegBO.prg
*
* Business Object para Prioridade de Estoque p/Globaliza??o
* Tabela principal: SigCdCeg (cidchaves PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CegBO AS BusinessBase

	*-- Propriedades da entidade (SigCdCeg)
	this_cCidchaves   = ""   && cidchaves char(?)      - PK (gerado por fUniqueIds)
	this_cGrupos      = ""   && grupos char(?)         - Grupo (FK SigCdGcr.Codigos)
	this_cContas      = ""   && contas char(?)         - Conta (via fAcessoContas)
	this_cEmps        = ""   && Cemps char(3)           - Empresa (FK SigCdEmp.CEmps)
	this_nPriors      = 0    && priors numeric(2,0)    - Prioridade (InputMask "99")
	this_nTpCads      = 0    && TpCads numeric(1,0)    - Tipo (OptionGroup 3 opcoes)

	*-- Propriedade auxiliar de exibicao (NAO persiste no banco)
	this_cDEmps       = ""   && descricao da empresa (SigCdEmp.Razas - display only)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdCeg"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de registros no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.cidchaves, a.priors, a.grupos, a.contas, a.emps," + ;
			           " ISNULL(b.Razas, '') AS Razas" + ;
			           " FROM SIGCDCEG a" + ;
			           " LEFT JOIN SigCdEmp b ON RTRIM(b.Cemps) = RTRIM(a.cemps)"

			IF !EMPTY(par_cFiltro)
				loc_cSQL = loc_cSQL + " WHERE RTRIM(a.grupos) LIKE " + ;
				           EscaparSQL(ALLTRIM(par_cFiltro) + "%")
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY a.grupos, a.contas, a.priors"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar prioridades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar prioridades:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pela chave primaria
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.cidchaves, a.contas, a.grupos, a.priors," + ;
			           " a.emps, a.tpcads," + ;
			           " ISNULL(b.Razas, '') AS Razas" + ;
			           " FROM SIGCDCEG a" + ;
			           " LEFT JOIN SigCdEmp b ON RTRIM(b.Cemps) = RTRIM(a.cemps)" + ;
			           " WHERE RTRIM(a.cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
			THIS.this_cContas    = TratarNulo(contas, "C")
			THIS.this_cGrupos    = TratarNulo(grupos, "C")
			THIS.this_nPriors    = TratarNulo(priors, "N")
			THIS.this_cEmps      = TratarNulo(emps, "C")
			THIS.this_nTpCads    = TratarNulo(tpcads, "N")
			THIS.this_cDEmps     = TratarNulo(Razas, "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Verifica se grupos+contas ja existem (INSERT)
	*====================================================================
	PROCEDURE VerificarDuplicidade()
		LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
		loc_lDuplicado = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS Total FROM SIGCDCEG" + ;
			           " WHERE RTRIM(grupos) = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ;
			           " AND RTRIM(contas) = " + EscaparSQL(ALLTRIM(THIS.this_cContas))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplic")
			IF loc_nResultado >= 0 AND !EOF("cursor_4c_Duplic")
				loc_lDuplicado = (cursor_4c_Duplic.Total > 0)
			ENDIF

			IF USED("cursor_4c_Duplic")
				USE IN cursor_4c_Duplic
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Duplic")
				USE IN cursor_4c_Duplic
			ENDIF
		ENDTRY

		RETURN loc_lDuplicado
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDCEG
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)

			loc_cSQL = "INSERT INTO SIGCDCEG" + ;
			           " (cidchaves, contas, grupos, priors, emps, tpcads)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCidchaves) + "," + ;
			           EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
			           EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPriors) + "," + ;
			           EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTpCads) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir prioridade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDCEG
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDCEG SET" + ;
			           " contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
			           " grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
			           " priors = " + FormatarNumeroSQL(THIS.this_nPriors) + "," + ;
			           " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
			           " tpcads = " + FormatarNumeroSQL(THIS.this_nTpCads) + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar prioridade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE na tabela SIGCDCEG
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SIGCDCEG" + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir prioridade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

