# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 412; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-01 19:35:46] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-01 19:35:46] [INFO] Config FPW: (nao fornecido)
[2026-08-01 19:35:46] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 19:35:46] [INFO] Timeout: 300 segundos
[2026-08-01 19:35:46] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uzwrzg4q.prg
[2026-08-01 19:35:46] [INFO] Conteudo do wrapper:
[2026-08-01 19:35:46] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormEsp', 'C:\4c\tasks\task408', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormEsp', 'C:\4c\tasks\task408', 'CRUD'
QUIT

[2026-08-01 19:35:46] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uzwrzg4q.prg
[2026-08-01 19:35:46] [INFO] VFP output esperado em: C:\4c\tasks\task408\vfp_output.txt
[2026-08-01 19:35:46] [INFO] Executando Visual FoxPro 9...
[2026-08-01 19:35:46] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uzwrzg4q.prg
[2026-08-01 19:35:46] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uzwrzg4q.prg
[2026-08-01 19:35:46] [INFO] Timeout configurado: 300 segundos
[2026-08-01 19:36:37] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-01 19:36:37] [INFO] VFP9 finalizado em 50.8858762 segundos
[2026-08-01 19:36:37] [INFO] Exit Code: 
[2026-08-01 19:36:37] [INFO] 
[2026-08-01 19:36:37] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-01 19:36:37] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uzwrzg4q.prg
[2026-08-01 19:36:37] [INFO] 
[2026-08-01 19:36:37] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-01 19:36:37] [INFO] * Auto-generated wrapper for parameters
[2026-08-01 19:36:37] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 19:36:37] [INFO] * Parameters: 'FormEsp', 'C:\4c\tasks\task408', 'CRUD'
[2026-08-01 19:36:37] [INFO] 
[2026-08-01 19:36:37] [INFO] * Anti-dialog protections for unattended execution
[2026-08-01 19:36:37] [INFO] SET SAFETY OFF
[2026-08-01 19:36:37] [INFO] SET RESOURCE OFF
[2026-08-01 19:36:37] [INFO] SET TALK OFF
[2026-08-01 19:36:37] [INFO] SET NOTIFY OFF
[2026-08-01 19:36:37] [INFO] SYS(2335, 0)
[2026-08-01 19:36:37] [INFO] 
[2026-08-01 19:36:37] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormEsp', 'C:\4c\tasks\task408', 'CRUD'
[2026-08-01 19:36:37] [INFO] QUIT
[2026-08-01 19:36:37] [INFO] 
[2026-08-01 19:36:37] [INFO] === Fim do Wrapper.prg ===
[2026-08-01 19:36:37] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormEsp",
  "timestamp": "20260801193637",
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
    "passou": 6,
    "falhou": 3,
    "percentual": 67
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormEsp.prg):
*==============================================================================
* FormEsp.prg - Formulario de Cadastro de Especies
* Migrado de: SigCdEsp.SCX (frmcadastro)
* Tabela: SigCdEsp
* FASE 8/8 - COMPLETO
*==============================================================================

DEFINE CLASS FormEsp AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: exatas do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Especies"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Cadastro de Esp" + CHR(233) + "cies"
            THIS.this_oBusinessObject = CREATEOBJECT("EspBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar EspBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormEsp.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible  = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar FormEsp:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormEsp.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 esconde abas; controles compensam +29 no Top
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_nFormWidth, loc_nFormHeight
        loc_nFormWidth  = THIS.Width
        loc_nFormHeight = THIS.Height
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = loc_nFormWidth
            .Height    = loc_nFormHeight + 29
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 com containers base
    * Legado: cntSombra.Top=1, Grupo_op.Top=-1, Grupo_Saida.Top=-1 (Left=918)
    * Compensacao PageFrame: +29 em todos os Tops
    * Canonical Saida: Left=917 (CLAUDE.md regra #10 prevalece sobre legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid, loc_nFormWidth
        loc_oPagina    = THIS.pgf_4c_Paginas.Page1
        loc_nFormWidth = THIS.Width

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado: Top=1, Left=-1, Width=1008, Height=80)
        *-- Compensado: Top=1+29=30. Width=THIS.Width (canonical: nao subtrair por cnt_4c_Saida)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = -1
            .Width       = loc_nFormWidth
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

        *-- Container Botoes CRUD (Grupo_op no legado: Left=543, Top=-1, Width=385, Height=85)
        *-- Compensado: Top=-1+29=28
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        =  542
            .Width       = 385
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

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10 prevalece sobre legado)
        *-- Legado: Grupo_Saida.Left=918, Top=-1. Canonico: Left=917, Top=29, Width=90
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

        *-- Grid de listagem (Grade no legado: Top=121, Left=12, Width=971, Height=470)
        *-- Compensado: Top=121+29=150. Width ajustado para nao sobrepor cnt_4c_Saida (Left=917)
        *-- Colunas: Especies (150) e Descs (290) conforme layout original
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top         = 150
        loc_oGrid.Left        = 12
        loc_oGrid.Width       = 900
        loc_oGrid.Height      = 470
        loc_oGrid.ColumnCount = 2
        WITH loc_oGrid
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2: botoes + campos (Fases 5-6)
    * Legado: Grupo_Salva.Left=836, Top=-6, Width=161, Height=85
    * Compensacao PageFrame: +29 em todos os Tops
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container BotoesAcao (Grupo_Salva: Left=836, Top=-6; compensado: Top=23)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 23
            .Left        = 836
            .Width       = 161
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva: Left=5, Top=5)
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
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Cancelar: Left=81, Top=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 81
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label Codigo (Say1: Top=136, Left=278, Width=42, Height=15; compensado Top=165)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 165
            .Left      = 278
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

        *-- TextBox Codigo (getCodigo: Top=133, Left=323, Width=52; compensado Top=162)
        *-- Format=K! (uppercase+select), MaxLength=6, SpecialEffect=1 (flat border)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 162
            .Left          = 323
            .Width         = 52
            .Height        = 23
            .MaxLength     = 6
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label Descricao (Say2: Top=162, Left=265, Width=55, Height=15; compensado Top=191)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 191
            .Left      = 265
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (getDescs: Top=158, Left=323, Width=290, Height=25; compensado Top=187)
        *-- Format=K! (uppercase+select), MaxLength=40, SpecialEffect=1
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Top           = 187
            .Left          = 323
            .Width         = 290
            .Height        = 25
            .MaxLength     = 40
            .Format        = "K!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label Integracao Contabil (Say3: Top=190, Left=216, Width=104, Height=15; compensado Top=219)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil :"
            .Top       = 219
            .Left      = 216
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Provs (optProvs: Top=185, Left=319; compensado Top=214)
        *-- ControlSource=crSigCdEsp.Provs; Option1=Com Provisao(Left=5), Option2=Sem Provisao(Left=110)
        loc_oPagina.AddObject("opt_4c_OptProvs", "OptionGroup")
        WITH loc_oPagina.opt_4c_OptProvs
            .ButtonCount = 2
            .Top         = 214
            .Left        = 319
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Enabled     = .F.
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Com Provis" + CHR(227) + "o"
                .Left      = 5
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Sem Provis" + CHR(227) + "o"
                .Left      = 110
                .Top       = 5
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Label Obrigatorio Dados Bancarios (Say4: Top=214, Left=175, Width=145, Height=15; compensado Top=243)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Obrigat" + CHR(243) + "rio Dados Banc" + CHR(225) + "rios :"
            .Top       = 243
            .Left      = 175
            .Width     = 145
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Obrigs (OptObrigs: Top=209, Left=319; compensado Top=238)
        *-- ControlSource=crSigCdEsp.Obrigs; Option1=Sim(Left=5), Option2=Nao(Left=58)
        loc_oPagina.AddObject("opt_4c_OptObrigs", "OptionGroup")
        WITH loc_oPagina.opt_4c_OptObrigs
            .ButtonCount = 2
            .Top         = 238
            .Left        = 319
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Enabled     = .F.
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 58
                .Top       = 5
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no grid via BO.Buscar()
    * Cursor: cursor_4c_Dados (criado pelo BO)
    * Colunas: especies (150px), descs (290px) conforme layout original
    *==========================================================================
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
                    loc_oGrid.ColumnCount           = 2
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.especies"
                    loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.descs"
                    loc_oGrid.Column1.Width            = 150
                    loc_oGrid.Column2.Width            = 290
                    loc_oGrid.Column1.Header1.Caption  = "Esp" + CHR(233) + "cie"
                    loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
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
            MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara Page2 para inclusao de novo registro
    * Legado: pcEscolha=[INSERIR], foca getCodigo
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em BtnIncluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo leitura
    * Legado: pcEscolha=[CONSULTAR], foca Grupo_Salva.Salva
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado para visualizar.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.especies)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ELSE
                MsgAviso("Registro n" + CHR(227) + "o encontrado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnVisualizarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    * Legado: pcEscolha=[ALTERAR], foca getDescs
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado para alterar.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.especies)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ELSE
                MsgAviso("Registro n" + CHR(227) + "o encontrado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnAlterarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Confirma e exclui registro selecionado
    * Legado: pcEscolha=[EXCLUIR], verifica uso em SigMvCcr e SigCdOpe antes de excluir
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_cCodigo

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado para excluir.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.especies)

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da esp" + CHR(233) + ;
                        "cie '" + loc_cCodigo + "'?", ;
                        "Confirmar Exclus" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_lResultado = .F.

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                    loc_lResultado = .T.
                ENDIF
            ELSE
                MsgAviso("Registro n" + CHR(227) + "o encontrado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnExcluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega lista com todos os registros
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida e salva o registro (Confirmar na Page2)
    * Legado: ChkRegister([SigCdEsp]) apos validar Especies, Descs, Provs
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        THIS.FormParaBO()

        IF !THIS.this_oBusinessObject.Validar()
            RETURN .F.
        ENDIF

        IF THIS.this_cModoAtual = "INCLUIR"
            IF THIS.this_oBusinessObject.VerificarDuplicidade()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela operacao e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos do Form para o BO
    * Legado: ChkRegister le do cursor crSigCdEsp via ControlSource
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
                THIS.this_oBusinessObject.this_cEspecies = ;
                    ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
            ENDIF

            IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
                THIS.this_oBusinessObject.this_cDescs = ;
                    ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
            ENDIF

            IF PEMSTATUS(loc_oPagina, "opt_4c_OptProvs", 5)
                THIS.this_oBusinessObject.this_nProvs = ;
                    loc_oPagina.opt_4c_OptProvs.Value
            ENDIF

            IF PEMSTATUS(loc_oPagina, "opt_4c_OptObrigs", 5)
                THIS.this_oBusinessObject.this_nObrigs = ;
                    loc_oPagina.opt_4c_OptObrigs.Value
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para os campos do Form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
                loc_oPagina.txt_4c_Codigo.Value = ;
                    ALLTRIM(THIS.this_oBusinessObject.this_cEspecies)
            ENDIF

            IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
                loc_oPagina.txt_4c_Descricao.Value = ;
                    ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
            ENDIF

            IF PEMSTATUS(loc_oPagina, "opt_4c_OptProvs", 5)
                loc_oPagina.opt_4c_OptProvs.Value = ;
                    THIS.this_oBusinessObject.this_nProvs
            ENDIF

            IF PEMSTATUS(loc_oPagina, "opt_4c_OptObrigs", 5)
                loc_oPagina.opt_4c_OptObrigs.Value = ;
                    THIS.this_oBusinessObject.this_nObrigs
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores dos campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
                loc_oPagina.txt_4c_Codigo.Value = ""
            ENDIF

            IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
                loc_oPagina.txt_4c_Descricao.Value = ""
            ENDIF

            IF PEMSTATUS(loc_oPagina, "opt_4c_OptProvs", 5)
                loc_oPagina.opt_4c_OptProvs.Value = 1
            ENDIF

            IF PEMSTATUS(loc_oPagina, "opt_4c_OptObrigs", 5)
                loc_oPagina.opt_4c_OptObrigs.Value = 1
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos da Page2
    * Legado: When events por modo (INSERIR/ALTERAR/CONSULTAR)
    * getCodigo: habilitado em INCLUIR; getDescs/optProvs/optObrigs: INCLUIR e ALTERAR
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lHabCodigo, loc_lHabDados
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_lHabCodigo = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
        loc_lHabDados  = par_lHabilitar AND ;
                         (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")

        TRY
            IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
                loc_oPagina.txt_4c_Codigo.Enabled = loc_lHabCodigo
            ENDIF

            IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
                loc_oPagina.txt_4c_Descricao.Enabled = loc_lHabDados
            ENDIF

            IF PEMSTATUS(loc_oPagina, "opt_4c_OptProvs", 5)
                loc_oPagina.opt_4c_OptProvs.Enabled = loc_lHabDados
            ENDIF

            IF PEMSTATUS(loc_oPagina, "opt_4c_OptObrigs", 5)
                loc_oPagina.opt_4c_OptObrigs.Enabled = loc_lHabDados
            ENDIF

            IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
                IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                    loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHabDados
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
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
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Itera Pages de PageFrames e Controls de Containers
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
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme o modo atual
    * Page1: Alterar/Excluir/Visualizar habilitados somente se houver registro
    * Page2: Confirmar habilitado somente em INCLUIR ou ALTERAR
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina1, loc_oPagina2, loc_lTemRegistro
        loc_oPagina1    = THIS.pgf_4c_Paginas.Page1
        loc_oPagina2    = THIS.pgf_4c_Paginas.Page2
        loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
                           !EOF("cursor_4c_Dados") AND ;
                           RECCOUNT("cursor_4c_Dados") > 0

        TRY
            IF PEMSTATUS(loc_oPagina1, "cnt_4c_Botoes", 5)
                IF PEMSTATUS(loc_oPagina1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
                    loc_oPagina1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
                ENDIF
                IF PEMSTATUS(loc_oPagina1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                    loc_oPagina1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
                ENDIF
                IF PEMSTATUS(loc_oPagina1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
                    loc_oPagina1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
                ENDIF
            ENDIF

            IF PEMSTATUS(loc_oPagina2, "cnt_4c_BotoesAcao", 5)
                IF PEMSTATUS(loc_oPagina2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                    loc_oPagina2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
                        INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\EspBO.prg):
*==============================================================================
* EspBO.prg - Business Object para Cadastro de Especies
* Tabela: SigCdEsp
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS EspBO AS BusinessBase

    *-- Propriedades de configuracao da tabela
    this_cTabela      = "SigCdEsp"
    this_cCampoChave  = "especies"

    *-- Propriedades de dados (mapeiam colunas de SigCdEsp)
    this_cEspecies    = ""    && char(6) - PK
    this_cDescs       = ""    && char(40)
    this_nProvs       = 1     && numeric(1,0) - 1=Com Provisao, 2=Sem Provisao
    this_nObrigs      = 1     && numeric(1,0) - 1=Sim, 2=Nao

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdEsp"
        THIS.this_cCampoChave = "especies"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEspecies
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEspecies = TratarNulo(especies, "C")
            THIS.this_cDescs    = TratarNulo(descs,    "C")
            THIS.this_nProvs    = TratarNulo(provs,    "N")
            THIS.this_nObrigs   = TratarNulo(obrigs,   "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de registros em cursor_4c_Dados
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT especies, descs, provs, obrigs" + ;
                       " FROM SigCdEsp" + ;
                       " ORDER BY especies"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT especies, descs, provs, obrigs" + ;
                           " FROM SigCdEsp" + ;
                           " WHERE especies LIKE " + EscaparSQL(par_cFiltro + "%") + ;
                           " ORDER BY especies"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar esp" + CHR(233) + "cies:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo da especie
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT especies, descs, provs, obrigs" + ;
                       " FROM SigCdEsp" + ;
                       " WHERE especies = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdEsp (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdEsp (especies, descs, provs, obrigs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cEspecies) + ", " + ;
                       EscaparSQL(THIS.this_cDescs)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nProvs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nObrigs) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir esp" + CHR(233) + "cie:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdEsp (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdEsp SET" + ;
                       " descs  = " + EscaparSQL(THIS.this_cDescs)          + ", " + ;
                       " provs  = " + FormatarNumeroSQL(THIS.this_nProvs)   + ", " + ;
                       " obrigs = " + FormatarNumeroSQL(THIS.this_nObrigs)  + ;
                       " WHERE especies = " + EscaparSQL(THIS.this_cEspecies)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar esp" + CHR(233) + "cie:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdEsp (PROTECTED - chamado por Excluir)
    * Valida uso em SigMvCcr (EspecieNfs) e SigCdOpe (Especies) antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Verificar uso em SigMvCcr
            loc_cSQL = "SELECT TOP 1 cIdChaves FROM SigMvCcr" + ;
                       " WHERE EspecieNfs = " + EscaparSQL(THIS.this_cEspecies)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkMvCcr")
                TABLEREVERT(.T., "cursor_4c_ChkMvCcr")
                USE IN cursor_4c_ChkMvCcr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCcr")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkMvCcr") > 0
                MsgAviso("A Esp" + CHR(233) + "cie Est" + CHR(225) + " Em Uso Nos T" + ;
                         CHR(237) + "tulos e N" + CHR(227) + "o Pode Ser Exclu" + ;
                         CHR(237) + "da!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Verificar uso em SigCdOpe
                loc_cSQL = "SELECT TOP 1 Dopes FROM SigCdOpe" + ;
                           " WHERE Especies = " + EscaparSQL(THIS.this_cEspecies)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ChkOpe")
                    TABLEREVERT(.T., "cursor_4c_ChkOpe")
                    USE IN cursor_4c_ChkOpe
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpe")

                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkOpe") > 0
                    SELECT cursor_4c_ChkOpe
                    GO TOP
                    MsgAviso("A Esp" + CHR(233) + "cie Est" + CHR(225) + " Em Uso Na Opera" + ;
                             CHR(231) + CHR(227) + "o " + CHR(34) + ;
                             ALLTRIM(cursor_4c_ChkOpe.Dopes) + CHR(34) + ;
                             " e N" + CHR(227) + "o Pode Ser Exclu" + CHR(237) + "da!!!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    *-- Sem dependencias - executar exclusao
                    loc_cSQL = "DELETE FROM SigCdEsp" + ;
                               " WHERE especies = " + EscaparSQL(THIS.this_cEspecies)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado > 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao excluir esp" + CHR(233) + "cie:" + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF

                IF USED("cursor_4c_ChkOpe")
                    USE IN cursor_4c_ChkOpe
                ENDIF
            ENDIF

            IF USED("cursor_4c_ChkMvCcr")
                USE IN cursor_4c_ChkMvCcr
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Validar - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    FUNCTION Validar()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF EMPTY(ALLTRIM(THIS.this_cEspecies))
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cDescs))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND THIS.this_nProvs = 0
            MsgAviso("Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + ;
                     "bil Inv" + CHR(225) + "lida!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se codigo ja existe (para INSERT)
    *--------------------------------------------------------------------------
    FUNCTION VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 especies FROM SigCdEsp" + ;
                       " WHERE especies = " + EscaparSQL(THIS.this_cEspecies)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkDup")
                TABLEREVERT(.T., "cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkDup") > 0
                loc_lExiste = .T.
                MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

            IF USED("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarDuplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE

