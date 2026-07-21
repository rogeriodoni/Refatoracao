# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 56% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 412; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542; Teste 'BtnIncluirNavegacao': BtnIncluirClick nao navegou para Page2 (ActivePage=1)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[21/07/2026 09:51:57 AM] Atenção: Selecione uma empresa na lista.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-21 09:51:20] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-21 09:51:20] [INFO] Config FPW: (nao fornecido)
[2026-07-21 09:51:20] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 09:51:20] [INFO] Timeout: 300 segundos
[2026-07-21 09:51:20] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xyboy1gl.prg
[2026-07-21 09:51:20] [INFO] Conteudo do wrapper:
[2026-07-21 09:51:20] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormACE', 'C:\4c\tasks\task341', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormACE', 'C:\4c\tasks\task341', 'CRUD'
QUIT

[2026-07-21 09:51:20] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xyboy1gl.prg
[2026-07-21 09:51:20] [INFO] VFP output esperado em: C:\4c\tasks\task341\vfp_output.txt
[2026-07-21 09:51:20] [INFO] Executando Visual FoxPro 9...
[2026-07-21 09:51:20] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xyboy1gl.prg
[2026-07-21 09:51:20] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xyboy1gl.prg
[2026-07-21 09:51:20] [INFO] Timeout configurado: 300 segundos
[2026-07-21 09:51:58] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-21 09:51:58] [INFO] VFP9 finalizado em 37.1482197 segundos
[2026-07-21 09:51:58] [INFO] Exit Code: 
[2026-07-21 09:51:58] [INFO] 
[2026-07-21 09:51:58] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-21 09:51:58] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xyboy1gl.prg
[2026-07-21 09:51:58] [INFO] 
[2026-07-21 09:51:58] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-21 09:51:58] [INFO] * Auto-generated wrapper for parameters
[2026-07-21 09:51:58] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 09:51:58] [INFO] * Parameters: 'FormACE', 'C:\4c\tasks\task341', 'CRUD'
[2026-07-21 09:51:58] [INFO] 
[2026-07-21 09:51:58] [INFO] * Anti-dialog protections for unattended execution
[2026-07-21 09:51:58] [INFO] SET SAFETY OFF
[2026-07-21 09:51:58] [INFO] SET RESOURCE OFF
[2026-07-21 09:51:58] [INFO] SET TALK OFF
[2026-07-21 09:51:58] [INFO] SET NOTIFY OFF
[2026-07-21 09:51:58] [INFO] SYS(2335, 0)
[2026-07-21 09:51:58] [INFO] 
[2026-07-21 09:51:58] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormACE', 'C:\4c\tasks\task341', 'CRUD'
[2026-07-21 09:51:58] [INFO] QUIT
[2026-07-21 09:51:58] [INFO] 
[2026-07-21 09:51:58] [INFO] === Fim do Wrapper.prg ===
[2026-07-21 09:51:58] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormACE",
  "timestamp": "20260721095157",
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
      "passou": false,
      "erro": "Property ALTERNARPAGINA is not found.",
      "detalhes": "Linha: 412"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 542"
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
    "passou": 5,
    "falhou": 4,
    "percentual": 56
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormACE.prg):
*==============================================================================
* FormACE.PRG - Fase 8/8: Consolidacao Final
* Formulario de Acesso de Empresas (SIGCDACE / SIGCDEMP)
*
* Tabelas: SigCdEmp (lista), SigCdAcE (acessos), SigCdUsu (usuarios)
* Tipo: CRUD (frmcadastro)
* BO: ACEBO
*
* Logica especial: Page2 nao tem campos CRUD tradicionais.
* Usa dois ListBoxes (disponiveis/com acesso) + 4 botoes de transferencia.
*==============================================================================

DEFINE CLASS FormACE AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Acesso de Empresas"
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
            MsgErro(loc_oErro.Message, "FormACE.Init")
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
            THIS.this_oBusinessObject = CREATEOBJECT("ACEBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar ACEBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.InicializarForm")
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

        *-- Grid de lista de empresas (Top = 88 + 29 = 117, compensacao PageFrame.Top=-29)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 2
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
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2: cabecalho + empresa + botoes acao
    * Fase 5/8: cnt_4c_Cabecalho, cmd Confirmar/Cancelar, campos empresa
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

        *-- Container botoes Confirmar/Cancelar (Top = 4 + 29 = 33)
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

        *-- Label "Empresa" (Say22 original: top=30, left=231 -> compensacao +29 = top=59)
        loc_oPg2.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPg2.lbl_4c_Empresa
            .AutoSize  = .F.
            .Caption   = "Empresa"
            .Top       = 59
            .Left      = 231
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo empresa (Get_Empresa original: top=49, left=231, width=31 -> top=78)
        loc_oPg2.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPg2.txt_4c_Empresa
            .Value     = ""
            .Top       = 78
            .Left      = 231
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_Empresa, "KeyPress", THIS, "ValidarEmpresa")

        *-- TextBox descricao empresa (Get_DEmpresa original: top=49, left=264, width=290 -> top=78)
        loc_oPg2.AddObject("txt_4c_DEmpresa", "TextBox")
        WITH loc_oPg2.txt_4c_DEmpresa
            .Value     = ""
            .Top       = 78
            .Left      = 264
            .Width     = 290
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ForeColor = RGB(0, 0, 0)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- ListBox usuarios disponiveis (Usuario original: top=96, left=231, width=135, height=429 -> top=125)
        loc_oPg2.AddObject("lst_4c_Usuario", "ListBox")
        WITH loc_oPg2.lst_4c_Usuario
            .Top         = 125
            .Left        = 231
            .Width       = 135
            .Height      = 429
            .FontName    = "Courier New"
            .FontSize    = 9
            .MultiSelect = .T.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.lst_4c_Usuario, "DblClick", THIS, "UsuarioDblClick")

        *-- ListBox usuarios com acesso (Usuemp original: top=96, left=418, width=135, height=429 -> top=125)
        loc_oPg2.AddObject("lst_4c_Usuemp", "ListBox")
        WITH loc_oPg2.lst_4c_Usuemp
            .Top         = 125
            .Left        = 418
            .Width       = 135
            .Height      = 429
            .FontName    = "Courier New"
            .FontSize    = 9
            .MultiSelect = .T.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.lst_4c_Usuemp, "DblClick", THIS, "UsueEmpDblClick")

        *-- Botao Add um item (cmdAdd original: top=203, left=370, 45x45 -> top=232)
        loc_oPg2.AddObject("cmd_4c_CmdAdd", "CommandButton")
        WITH loc_oPg2.cmd_4c_CmdAdd
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "Cadastro_Seta_Direita_20.jpg"
            .PicturePosition = 13
            .Top             = 232
            .Left            = 370
            .Width           = 45
            .Height          = 45
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(0, 0, 128)
            .FontBold        = .T.
            .FontName        = "Small Fonts"
            .FontSize        = 7
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ToolTipText     = "Selecionar Um Item"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_CmdAdd, "Click", THIS, "CmdAddClick")

        *-- Botao Add todos (cmdAddAll original: top=293, left=370, 45x45 -> top=322)
        loc_oPg2.AddObject("cmd_4c_CmdAddAll", "CommandButton")
        WITH loc_oPg2.cmd_4c_CmdAddAll
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_seta_dir_60.jpg"
            .PicturePosition = 13
            .Top             = 322
            .Left            = 370
            .Width           = 45
            .Height          = 45
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(0, 0, 128)
            .FontBold        = .T.
            .FontName        = "Small Fonts"
            .FontSize        = 7
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ToolTipText     = "Selecionar Todos os Itens"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_CmdAddAll, "Click", THIS, "CmdAddAllClick")

        *-- Botao Remove um item (cmdRemove original: top=248, left=370, 45x45 -> top=277)
        loc_oPg2.AddObject("cmd_4c_CmdRemove", "CommandButton")
        WITH loc_oPg2.cmd_4c_CmdRemove
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "Cadastro_Seta_Esquerda_20.jpg"
            .PicturePosition = 13
            .Top             = 277
            .Left            = 370
            .Width           = 45
            .Height          = 45
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(0, 0, 128)
            .FontBold        = .T.
            .FontName        = "Small Fonts"
            .FontSize        = 7
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ToolTipText     = "Remover um Item"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_CmdRemove, "Click", THIS, "CmdRemoveClick")

        *-- Botao Remove todos (cmdRemoveAll original: top=338, left=370, 45x45 -> top=367)
        loc_oPg2.AddObject("cmd_4c_CmdRemoveAll", "CommandButton")
        WITH loc_oPg2.cmd_4c_CmdRemoveAll
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            .PicturePosition = 13
            .Top             = 367
            .Left            = 370
            .Width           = 45
            .Height          = 45
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(0, 0, 128)
            .FontBold        = .T.
            .FontName        = "Small Fonts"
            .FontSize        = 7
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ToolTipText     = "Remover todos os Itens"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.cmd_4c_CmdRemoveAll, "Click", THIS, "CmdRemoveAllClick")

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega lista de empresas e configura grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource          = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cemps"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Razas"

                    loc_oGrid.Column1.Width         = 80
                    loc_oGrid.Column2.Width         = 795

                    loc_oGrid.Column1.ReadOnly      = .T.
                    loc_oGrid.Column2.ReadOnly      = .T.

                    loc_oGrid.Column1.Header1.Caption = "Empresa"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Lista (1) e Dados (2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
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
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Configura acessos para a empresa selecionada no grid
    * No legado INSERIR usa a empresa corrente do grid (Get_Empresa.When=.F. em INSERIR)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_cEmpresa
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione uma empresa na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cEmpresa = ALLTRIM(cursor_4c_Dados.Cemps)

                THIS.this_oBusinessObject.NovoRegistro()
                THIS.this_oBusinessObject.this_cEmpresa          = loc_cEmpresa
                THIS.this_oBusinessObject.this_cDescricaoEmpresa = ALLTRIM(cursor_4c_Dados.Razas)
                THIS.this_cModoAtual = "INCLUIR"
                THIS.LimparCampos()
                THIS.HabilitarCampos(.T.)
                THIS.BOParaForm()
                THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega empresa selecionada em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cEmpresa
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione uma empresa na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cEmpresa = ALLTRIM(cursor_4c_Dados.Cemps)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpresa)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega empresa selecionada para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cEmpresa
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione uma empresa na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cEmpresa = ALLTRIM(cursor_4c_Dados.Cemps)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpresa)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui todos os acessos da empresa selecionada
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cEmpresa, loc_cDescricao
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione uma empresa na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cEmpresa   = ALLTRIM(cursor_4c_Dados.Cemps)
                loc_cDescricao = ALLTRIM(cursor_4c_Dados.Razas)

                IF MsgConfirma("Confirma exclus" + CHR(227) + "o dos acessos da empresa " + ;
                        CHR(13) + loc_cEmpresa + " - " + loc_cDescricao + "?", ;
                        "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpresa)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Acessos exclu" + CHR(237) + "dos com sucesso!", "Sucesso")
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar empresa
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cFiltro, loc_oGrid
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", "", "Buscar Empresa")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Cemps", "", "Empresa")
                loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    loc_cFiltro = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                    loc_oGrid   = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(Cemps) = loc_cFiltro
                        loc_oGrid.Refresh()
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
        CATCH TO loc_oErro
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
            MsgErro(loc_oErro.Message, "FormACE.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirmar: salva acessos da empresa no banco
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oPg2, loc_nI, loc_cEmpresa, loc_cUsuario
        loc_lResultado = .F.

        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_cEmpresa = ALLTRIM(loc_oPg2.txt_4c_Empresa.Value)

        IF EMPTY(loc_cEmpresa)
            MsgAviso("Informe o c" + CHR(243) + "digo da empresa.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_oBusinessObject.this_cEmpresa          = loc_cEmpresa
            THIS.this_oBusinessObject.this_cDescricaoEmpresa = ALLTRIM(loc_oPg2.txt_4c_DEmpresa.Value)

            THIS.this_oBusinessObject.PrepararCursorAcesso()

            IF PEMSTATUS(loc_oPg2, "lst_4c_Usuemp", 5)
                FOR loc_nI = 1 TO loc_oPg2.lst_4c_Usuemp.ListCount
                    loc_cUsuario = ALLTRIM(loc_oPg2.lst_4c_Usuemp.List(loc_nI))
                    IF !EMPTY(loc_cUsuario)
                        INSERT INTO cursor_4c_UsuariosAcesso (Usuarios) VALUES (loc_cUsuario)
                    ENDIF
                ENDFOR
            ENDIF

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Acessos salvos com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Preenche campos do form com dados do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_cEmpresa
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cEmpresa = ALLTRIM(THIS.this_oBusinessObject.this_cEmpresa)

            loc_oPg2.txt_4c_Empresa.Value  = loc_cEmpresa
            loc_oPg2.txt_4c_DEmpresa.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricaoEmpresa)

            IF PEMSTATUS(loc_oPg2, "lst_4c_Usuario", 5)
                loc_oPg2.lst_4c_Usuario.Clear()
                *-- Usuarios disponiveis so carregam em modo edicao (INSERIR/ALTERAR no legado)
                IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                    IF THIS.this_oBusinessObject.BuscarUsuariosDisponiveis(loc_cEmpresa)
                        IF USED("cursor_4c_UsuariosDispon") AND RECCOUNT("cursor_4c_UsuariosDispon") > 0
                            SELECT cursor_4c_UsuariosDispon
                            GO TOP
                            SCAN
                                loc_oPg2.lst_4c_Usuario.AddItem(ALLTRIM(cursor_4c_UsuariosDispon.Usuarios))
                            ENDSCAN
                        ENDIF
                        IF USED("cursor_4c_UsuariosDispon")
                            USE IN cursor_4c_UsuariosDispon
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF PEMSTATUS(loc_oPg2, "lst_4c_Usuemp", 5)
                loc_oPg2.lst_4c_Usuemp.Clear()
                IF THIS.this_oBusinessObject.BuscarUsuariosComAcesso(loc_cEmpresa)
                    IF USED("cursor_4c_UsuariosAcesso") AND RECCOUNT("cursor_4c_UsuariosAcesso") > 0
                        SELECT cursor_4c_UsuariosAcesso
                        GO TOP
                        SCAN
                            loc_oPg2.lst_4c_Usuemp.AddItem(ALLTRIM(cursor_4c_UsuariosAcesso.Usuarios))
                        ENDSCAN
                    ENDIF
                    IF USED("cursor_4c_UsuariosAcesso")
                        USE IN cursor_4c_UsuariosAcesso
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Empresa.Value  = ""
            loc_oPg2.txt_4c_DEmpresa.Value = ""

            IF PEMSTATUS(loc_oPg2, "lst_4c_Usuario", 5)
                loc_oPg2.lst_4c_Usuario.Clear()
            ENDIF
            IF PEMSTATUS(loc_oPg2, "lst_4c_Usuemp", 5)
                loc_oPg2.lst_4c_Usuemp.Clear()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo atual
    * Legado: Get_Empresa.When = (pcEscolha='PROCURAR') -> so editavel em BUSCAR/VISUALIZAR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lModoConsulta
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Empresa editavel SOMENTE em VISUALIZAR (PROCURAR no legado), nao em INCLUIR/ALTERAR
            loc_lModoConsulta = (THIS.this_cModoAtual = "VISUALIZAR")

            loc_oPg2.txt_4c_Empresa.ReadOnly  = !loc_lModoConsulta
            loc_oPg2.txt_4c_DEmpresa.ReadOnly = .T.

            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
            *-- Botoes de transferencia sao icone-only: nao desabilitar (ficam retangulo vazio)
            *-- O modo e verificado diretamente nos handlers CmdAddClick etc.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Handler LostFocus de txt_4c_Empresa
    * Busca descricao no SQL Server; se nao achar, abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cEmpresa, loc_cSQL, loc_nResult
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cEmpresa = ALLTRIM(loc_oPg2.txt_4c_Empresa.Value)

            IF EMPTY(loc_cEmpresa)
                loc_oPg2.txt_4c_DEmpresa.Value = ""
            ELSE
                loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                              EscaparSQL(PADR(loc_cEmpresa, 3))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaEmp")

                IF loc_nResult > 0 AND USED("cursor_4c_ValidaEmp") AND RECCOUNT("cursor_4c_ValidaEmp") > 0
                    SELECT cursor_4c_ValidaEmp
                    loc_oPg2.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_ValidaEmp.Razas)
                ELSE
                    loc_oPg2.txt_4c_DEmpresa.Value = ""
                    THIS.AbrirBuscaEmpresa()
                ENDIF

                IF USED("cursor_4c_ValidaEmp")
                    USE IN cursor_4c_ValidaEmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.ValidarEmpresa")
            IF USED("cursor_4c_ValidaEmp")
                USE IN cursor_4c_ValidaEmp
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - Abre FormBuscaAuxiliar para selecionar empresa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oBusca, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmpresa", "Cemps", "", "Buscar Empresa")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Cemps", "", "Empresa")
                loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
                    SELECT cursor_4c_BuscaEmpresa
                    loc_oPg2.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
                    loc_oPg2.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaEmpresa")
                USE IN cursor_4c_BuscaEmpresa
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.AbrirBuscaEmpresa")
            IF USED("cursor_4c_BuscaEmpresa")
                USE IN cursor_4c_BuscaEmpresa
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdAddClick - Move usuario selecionado de lst_4c_Usuario para lst_4c_Usuemp
    *--------------------------------------------------------------------------
    PROCEDURE CmdAddClick()
        LOCAL loc_oPg2, loc_cUsuario, loc_nIdx
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            IF PEMSTATUS(loc_oPg2, "lst_4c_Usuario", 5) AND PEMSTATUS(loc_oPg2, "lst_4c_Usuemp", 5)
                loc_nIdx = loc_oPg2.lst_4c_Usuario.ListIndex
                IF loc_nIdx >= 1 AND loc_oPg2.lst_4c_Usuario.Selected(loc_nIdx)
                    loc_cUsuario = ALLTRIM(loc_oPg2.lst_4c_Usuario.List(loc_nIdx))
                    loc_oPg2.lst_4c_Usuario.RemoveItem(loc_nIdx)
                    loc_oPg2.lst_4c_Usuemp.AddItem(loc_cUsuario)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.CmdAddClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdAddAllClick - Move todos de lst_4c_Usuario para lst_4c_Usuemp
    *--------------------------------------------------------------------------
    PROCEDURE CmdAddAllClick()
        LOCAL loc_oPg2, loc_nI, loc_nTotal
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            IF PEMSTATUS(loc_oPg2, "lst_4c_Usuario", 5) AND PEMSTATUS(loc_oPg2, "lst_4c_Usuemp", 5)
                THIS.LockScreen = .T.
                loc_nTotal = loc_oPg2.lst_4c_Usuario.ListCount
                FOR loc_nI = 1 TO loc_nTotal
                    loc_oPg2.lst_4c_Usuemp.AddItem(ALLTRIM(loc_oPg2.lst_4c_Usuario.List(loc_nI)))
                ENDFOR
                loc_oPg2.lst_4c_Usuario.Clear()
                THIS.LockScreen = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "FormACE.CmdAddAllClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdRemoveClick - Move usuario selecionado de lst_4c_Usuemp para lst_4c_Usuario
    *--------------------------------------------------------------------------
    PROCEDURE CmdRemoveClick()
        LOCAL loc_oPg2, loc_cUsuario, loc_nIdx
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            IF PEMSTATUS(loc_oPg2, "lst_4c_Usuemp", 5) AND PEMSTATUS(loc_oPg2, "lst_4c_Usuario", 5)
                loc_nIdx = loc_oPg2.lst_4c_Usuemp.ListIndex
                IF loc_nIdx >= 1 AND loc_oPg2.lst_4c_Usuemp.Selected(loc_nIdx)
                    loc_cUsuario = ALLTRIM(loc_oPg2.lst_4c_Usuemp.List(loc_nIdx))
                    loc_oPg2.lst_4c_Usuemp.RemoveItem(loc_nIdx)
                    loc_oPg2.lst_4c_Usuario.AddItem(loc_cUsuario)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.CmdRemoveClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdRemoveAllClick - Move todos de lst_4c_Usuemp para lst_4c_Usuario
    *--------------------------------------------------------------------------
    PROCEDURE CmdRemoveAllClick()
        LOCAL loc_oPg2, loc_nI, loc_nTotal
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            IF PEMSTATUS(loc_oPg2, "lst_4c_Usuemp", 5) AND PEMSTATUS(loc_oPg2, "lst_4c_Usuario", 5)
                THIS.LockScreen = .T.
                loc_nTotal = loc_oPg2.lst_4c_Usuemp.ListCount
                FOR loc_nI = 1 TO loc_nTotal
                    loc_oPg2.lst_4c_Usuario.AddItem(ALLTRIM(loc_oPg2.lst_4c_Usuemp.List(loc_nI)))
                ENDFOR
                loc_oPg2.lst_4c_Usuemp.Clear()
                THIS.LockScreen = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "FormACE.CmdRemoveAllClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * UsuarioDblClick - DblClick em lst_4c_Usuario: delega para CmdAddClick
    *--------------------------------------------------------------------------
    PROCEDURE UsuarioDblClick()
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            THIS.CmdAddClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * UsueEmpDblClick - DblClick em lst_4c_Usuemp: delega para CmdRemoveClick
    *--------------------------------------------------------------------------
    PROCEDURE UsueEmpDblClick()
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            THIS.CmdRemoveClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            THIS.this_oBusinessObject.this_cEmpresa          = ALLTRIM(loc_oPg2.txt_4c_Empresa.Value)
            THIS.this_oBusinessObject.this_cDescricaoEmpresa = ALLTRIM(loc_oPg2.txt_4c_DEmpresa.Value)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD conforme modo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoes, loc_lTemSelecao
        loc_oBotoes   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
        loc_lTemSelecao = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0

        TRY
            WITH loc_oBotoes
                .cmd_4c_Incluir.Enabled    = .T.
                .cmd_4c_Visualizar.Enabled = loc_lTemSelecao
                .cmd_4c_Alterar.Enabled    = loc_lTemSelecao
                .cmd_4c_Excluir.Enabled    = loc_lTemSelecao
                .cmd_4c_Buscar.Enabled     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormACE.AjustarBotoesPorModo")
        ENDTRY
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
            MsgErro(loc_oErro.Message, "FormACE.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ACEBO.prg):
*==============================================================================
* ACEBO.PRG
* Business Object para Acesso de Empresas (SIGCDACE)
*
* Tabela Principal : SigCdEmp  - Lista de empresas (Cemps, Razas)
* Tabela de Acesso : SigCdAcE  - Mapeamento empresa-usuario
*                                (emps char(3), usuarios char(10), pkchaves char(13))
* Tabela de Usuarios: SigCdUsu - Cadastro de usuarios (usuarios char(10))
*
* Logica: Gerencia quais usuarios tem acesso a cada empresa.
*         Inserir/Atualizar = DELETE + re-INSERT em SigCdAcE por empresa.
*         Excluir           = DELETE todos os acessos da empresa em SigCdAcE.
*         Buscar            = SELECT de empresas em SigCdEmp (exibicao no grid).
*==============================================================================

DEFINE CLASS ACEBO AS BusinessBase

    *-- Propriedades da empresa (SigCdEmp)
    this_cEmpresa            = ""   && Cemps/emps CHAR(3)  - Codigo da empresa (PK)
    this_cDescricaoEmpresa   = ""   && Razas       CHAR(40) - Descricao da empresa

    *-- Nome do cursor que o Form preenche com os usuarios com acesso antes de Salvar()
    this_cCursorUsuariosAcesso = "cursor_4c_UsuariosAcesso"

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdEmp"
        THIS.this_cCampoChave = "Cemps"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpresa
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados da empresa de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmpresa          = TratarNulo(Cemps, "C")
                THIS.this_cDescricaoEmpresa = TratarNulo(Razas, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa propriedades de dados
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cEmpresa          = ""
        THIS.this_cDescricaoEmpresa = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo da empresa obrigat" + CHR(243) + "rio"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista empresas no grid (SELECT de SigCdEmp)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp" + ;
                           " WHERE Cemps LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY Cemps"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega dados de uma empresa pelo codigo Cemps
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cEmpresa) != "C" OR EMPTY(ALLTRIM(par_cEmpresa))
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo da empresa n" + CHR(227) + "o informado"
                loc_lResultado = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(ALLTRIM(par_cEmpresa))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada: " + ALLTRIM(par_cEmpresa)
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUsuariosDisponiveis - Usuarios sem acesso a esta empresa
    * Retorna cursor_4c_UsuariosDispon (campo: Usuarios)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUsuariosDisponiveis(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_UsuariosDispon")
                USE IN cursor_4c_UsuariosDispon
            ENDIF

            loc_cSQL = "SELECT DISTINCT Usuarios FROM SigCdUsu" + ;
                       " WHERE NOT cativos = 'N'" + ;
                       " AND Usuarios NOT IN" + ;
                       " (SELECT Usuarios FROM SigCdAcE WHERE emps = " + ;
                       EscaparSQL(ALLTRIM(par_cEmpresa)) + ")" + ;
                       " ORDER BY Usuarios"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosDispon")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUsuariosComAcesso - Usuarios com acesso a esta empresa
    * Retorna cursor_4c_UsuariosAcesso (campo: Usuarios)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUsuariosComAcesso(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_UsuariosAcesso")
                USE IN cursor_4c_UsuariosAcesso
            ENDIF

            loc_cSQL = "SELECT DISTINCT Usuarios FROM SigCdAcE" + ;
                       " WHERE emps = " + EscaparSQL(ALLTRIM(par_cEmpresa)) + ;
                       " ORDER BY Usuarios"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosAcesso")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursorAcesso - Cria cursor vazio para o Form preencher com usuarios
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursorAcesso()
        TRY
            IF USED("cursor_4c_UsuariosAcesso")
                USE IN cursor_4c_UsuariosAcesso
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_UsuariosAcesso (Usuarios C(10))
            SET NULL OFF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT: DELETE acessos antigos + INSERT novos (PROTECTED)
    * O Form preenche cursor_4c_UsuariosAcesso antes de chamar Salvar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nI
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdAcE WHERE emps = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcE")
            IF USED("cursor_4c_DelAcE")
                USE IN cursor_4c_DelAcE
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar acessos antigos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_UsuariosAcesso") AND RECCOUNT("cursor_4c_UsuariosAcesso") > 0
                    loc_nI = 0
                    SELECT cursor_4c_UsuariosAcesso
                    GO TOP
                    SCAN
                        loc_nI = loc_nI + 1
                        loc_cSQL = "INSERT INTO SigCdAcE (usuarios, emps, pkchaves) VALUES (" + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_UsuariosAcesso.Usuarios)) + ", " + ;
                                   EscaparSQL(ALLTRIM(THIS.this_cEmpresa)) + ", " + ;
                                   EscaparSQL(LEFT(SYS(2015) + SYS(2015), 13)) + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcE")
                        IF USED("cursor_4c_InsAcE")
                            USE IN cursor_4c_InsAcE
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                            EXIT
                        ENDIF
                    ENDSCAN
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE: mesma logica do Inserir (DELETE + re-INSERT) (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nI
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdAcE WHERE emps = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcE")
            IF USED("cursor_4c_DelAcE")
                USE IN cursor_4c_DelAcE
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_UsuariosAcesso") AND RECCOUNT("cursor_4c_UsuariosAcesso") > 0
                    loc_nI = 0
                    SELECT cursor_4c_UsuariosAcesso
                    GO TOP
                    SCAN
                        loc_nI = loc_nI + 1
                        loc_cSQL = "INSERT INTO SigCdAcE (usuarios, emps, pkchaves) VALUES (" + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_UsuariosAcesso.Usuarios)) + ", " + ;
                                   EscaparSQL(ALLTRIM(THIS.this_cEmpresa)) + ", " + ;
                                   EscaparSQL(LEFT(SYS(2015) + SYS(2015), 13)) + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcE")
                        IF USED("cursor_4c_InsAcE")
                            USE IN cursor_4c_InsAcE
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                            EXIT
                        ENDIF
                    ENDSCAN
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove todos os acessos da empresa (PROTECTED)
    * Nao deleta a empresa em si (SigCdEmp), apenas os registros em SigCdAcE
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
                MsgErro("Empresa n" + CHR(227) + "o selecionada para exclus" + CHR(227) + "o", "Erro")
            ELSE
                loc_cSQL = "DELETE FROM SigCdAcE WHERE emps = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelExcl")
                IF USED("cursor_4c_DelExcl")
                    USE IN cursor_4c_DelExcl
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

