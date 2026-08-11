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
[2026-08-05 18:07:09] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-05 18:07:09] [INFO] Config FPW: (nao fornecido)
[2026-08-05 18:07:09] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-05 18:07:09] [INFO] Timeout: 300 segundos
[2026-08-05 18:07:09] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_bcsh3zpu.prg
[2026-08-05 18:07:09] [INFO] Conteudo do wrapper:
[2026-08-05 18:07:09] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFNF', 'C:\4c\tasks\task419', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFNF', 'C:\4c\tasks\task419', 'CRUD'
QUIT

[2026-08-05 18:07:09] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_bcsh3zpu.prg
[2026-08-05 18:07:09] [INFO] VFP output esperado em: C:\4c\tasks\task419\vfp_output.txt
[2026-08-05 18:07:09] [INFO] Executando Visual FoxPro 9...
[2026-08-05 18:07:09] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_bcsh3zpu.prg
[2026-08-05 18:07:09] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_bcsh3zpu.prg
[2026-08-05 18:07:09] [INFO] Timeout configurado: 300 segundos
[2026-08-05 18:08:04] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-05 18:08:04] [INFO] VFP9 finalizado em 55.4734486 segundos
[2026-08-05 18:08:04] [INFO] Exit Code: 
[2026-08-05 18:08:04] [INFO] 
[2026-08-05 18:08:04] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-05 18:08:04] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_bcsh3zpu.prg
[2026-08-05 18:08:04] [INFO] 
[2026-08-05 18:08:04] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-05 18:08:04] [INFO] * Auto-generated wrapper for parameters
[2026-08-05 18:08:04] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-05 18:08:04] [INFO] * Parameters: 'FormFNF', 'C:\4c\tasks\task419', 'CRUD'
[2026-08-05 18:08:04] [INFO] 
[2026-08-05 18:08:04] [INFO] * Anti-dialog protections for unattended execution
[2026-08-05 18:08:04] [INFO] SET SAFETY OFF
[2026-08-05 18:08:04] [INFO] SET RESOURCE OFF
[2026-08-05 18:08:04] [INFO] SET TALK OFF
[2026-08-05 18:08:04] [INFO] SET NOTIFY OFF
[2026-08-05 18:08:04] [INFO] SYS(2335, 0)
[2026-08-05 18:08:04] [INFO] 
[2026-08-05 18:08:04] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFNF', 'C:\4c\tasks\task419', 'CRUD'
[2026-08-05 18:08:04] [INFO] QUIT
[2026-08-05 18:08:04] [INFO] 
[2026-08-05 18:08:04] [INFO] === Fim do Wrapper.prg ===
[2026-08-05 18:08:04] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormFNF",
  "timestamp": "20260805180804",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFNF.prg):
*==============================================================================
* FormFNF.prg - Formulario de Cadastro de Finalizadoras nao Fiscal
* Migrado de: SIGCDFNF.SCX (frmcadastro)
* Tabela: SIGFINTB | PK: cidchaves
* Colunas grid: imps(Impressora), ordems(Ordem), descrs(Descricao), nfixos(Fixo)
*==============================================================================

DEFINE CLASS FormFNF AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Finalizadoras nao Fiscal"
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

    *===========================================================================
    * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Finalizadoras n" + CHR(227) + "o Fiscal"

            THIS.this_oBusinessObject = CREATEOBJECT("FNFBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar FNFBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormFNF.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormFNF:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormFNF.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *===========================================================================
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

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Page1: Cabecalho, Botoes CRUD (5+Encerrar), Grid
    * Layout: cabecalho Top=30, botoes Top=29, grid Top=117 (framework canonico)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho (cntSombra legado): Top=30 (1+29 compensacao PageFrame)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
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
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
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
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_Op legado): Top=29 (0+29), Left=542
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir: Left=5
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- Botao Visualizar: Left=80
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- Botao Alterar: Left=155
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- Botao Excluir: Left=230
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- Botao Buscar: Left=305
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- Container Encerrar (padrao canonico CLAUDE.md #10): Left=917, Width=90
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- Grid lista (Grupo_Grade legado): Top=117 (88+29), Left=26, Width=890
        *-- RecordSource e ColumnCount FORA do WITH (Problema #36)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 4

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
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        *-- Column1: imps (Impressora, 160px)
        WITH loc_oGrid.Column1
            .Width           = 160
            .ReadOnly        = .T.
            .Header1.Caption = "Impressora"
        ENDWITH

        *-- Column2: ordems (Ordem, 80px) alinhado a direita (numerico)
        WITH loc_oGrid.Column2
            .Width           = 80
            .ReadOnly        = .T.
            .Alignment       = 2
            .Header1.Caption = "Ordem"
        ENDWITH

        *-- Column3: descrs (Descricao, 337px)
        WITH loc_oGrid.Column3
            .Width           = 337
            .ReadOnly        = .T.
            .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- Column4: nfixos (Fixo, 50px) - CheckBox visual para campo 0/1
        WITH loc_oGrid.Column4
            .Width           = 50
            .ReadOnly        = .T.
            .Sparse          = .F.
            .Header1.Caption = "Fixo"
        ENDWITH
        loc_oGrid.Column4.AddObject("Check1", "CheckBox")
        WITH loc_oGrid.Column4.Check1
            .Alignment = 0
            .ReadOnly  = .T.
            .Visible   = .T.
            .Top       = 9
            .Left      = 2
            .Height    = 17
            .Width     = 22
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2: botoes acao + todos os campos do legado
    * Coords = original + 29 (compensacao PageFrame.Top=-29)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes acao (Grupo_Salva legado): Top=33 (4+29), Left=842
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva legado): Left=5, Top=5
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- Botao Cancelar: Left=88, Top=5
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 88
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- Say6 (Impressora): Top=162 (133+29), Left=123 ForeColor=RGB(36,84,155)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Impressora : "
            .Top       = 162
            .Left      = 123
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Cmb_Imp (Impressora): Top=158 (129+29), Left=203, Width=105, Height=24
        *-- RowSourceType=0 populado com AddItem (lista fixa do legado)
        loc_oPagina.AddObject("cbo_4c_Imps", "ComboBox")
        WITH loc_oPagina.cbo_4c_Imps
            .Top           = 158
            .Left          = 203
            .Width         = 105
            .Height        = 24
            .RowSourceType = 0
            .RowSource     = ""
            .Style         = 0
            .Value         = ""
            .FontName      = "Verdana"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        *-- Itens identicos ao legado (Init: .AddItem, sem espacos extras)
        loc_oPagina.cbo_4c_Imps.AddItem("DATAREGIS")
        loc_oPagina.cbo_4c_Imps.AddItem("SWEDA")
        loc_oPagina.cbo_4c_Imps.AddItem("BEMATECH")
        loc_oPagina.cbo_4c_Imps.AddItem("BEMA8501")
        loc_oPagina.cbo_4c_Imps.AddItem("NDATAREGIS")
        loc_oPagina.cbo_4c_Imps.AddItem("EPSON")
        loc_oPagina.cbo_4c_Imps.AddItem("DARUMA")
        loc_oPagina.cbo_4c_Imps.AddItem("NSWEDA")
        loc_oPagina.cbo_4c_Imps.AddItem("Em Branco")
        BINDEVENT(loc_oPagina.cbo_4c_Imps, "InteractiveChange", THIS, "ImpInteractiveChange")

        *-- Say1 (Ordem): Top=187 (158+29), Left=150
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Ordem : "
            .Top       = 187
            .Left      = 150
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_ordem (Ordem): Top=184 (155+29), Left=203, Width=24, InputMask="99"
        loc_oPagina.AddObject("txt_4c_Ordem", "TextBox")
        WITH loc_oPagina.txt_4c_Ordem
            .Top       = 184
            .Left      = 203
            .Width     = 24
            .Height    = 22
            .Value     = 0
            .InputMask = "99"
            .FontName  = "Verdana"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Say4 (Cod.Operacao): Top=212 (183+29), Left=107
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Cod.Opera" + CHR(231) + CHR(227) + "o : "
            .Top       = 212
            .Left      = 107
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_Opernf (Cod.Operacao): Top=209 (180+29), Left=203, Width=24, MaxLength=2
        loc_oPagina.AddObject("txt_4c_Opernf", "TextBox")
        WITH loc_oPagina.txt_4c_Opernf
            .Top       = 209
            .Left      = 203
            .Width     = 24
            .Height    = 22
            .Value     = ""
            .MaxLength = 2
            .FontName  = "Verdana"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Say5 (Cod.Abertura): Top=212 (183+29), Left=254
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Cod.Abertura : "
            .Top       = 212
            .Left      = 254
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- fwget1 (Cod.Abertura): Top=209 (180+29), Left=346, Width=24, MaxLength=2
        *-- When event do legado: habilitado APENAS para SWEDA/NSWEDA
        loc_oPagina.AddObject("txt_4c_Fwget1", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget1
            .Top       = 209
            .Left      = 346
            .Width     = 24
            .Height    = 22
            .Value     = ""
            .MaxLength = 2
            .ReadOnly  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Say2 (Descricao): Top=237 (208+29), Left=133
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
            .Top       = 237
            .Left      = 133
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Get_descr (Descricao): Top=234 (205+29), Left=203, Width=360
        loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPagina.txt_4c_Descr
            .Top       = 234
            .Left      = 203
            .Width     = 360
            .Height    = 22
            .Value     = ""
            .FontName  = "Verdana"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Say3 (Fixo): Top=265 (236+29), Left=166
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Fixo : "
            .Top       = 265
            .Left      = 166
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Opc_fixo (OptionGroup Fixo): Top=260 (231+29), Left=199
        *-- ButtonCount=2: Buttons(1)=Sim, Buttons(2)=Nao; Value=2=Nao (default)
        loc_oPagina.AddObject("opt_4c_Opc_fixo", "OptionGroup")
        WITH loc_oPagina.opt_4c_Opc_fixo
            .ButtonCount = 2
            .Top         = 260
            .Left        = 199
            .Width       = 100
            .Height      = 26
            .Value       = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Opc_fixo.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Opc_fixo.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 47
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Popula cursor via FNFBO.Buscar() e vincula ao Grid
    * Reconfigura Headers APOS RecordSource (Problema #2 FORMCOR_LICOES)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- RecordSource FORA de WITH; ControlSource APOS RecordSource (Prob #36/#48)
                loc_oGrid.ColumnCount = 4
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.imps"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.ordems"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.nfixos"

                *-- Redefinir Headers APOS RecordSource (resets ao auto-bind)
                loc_oGrid.Column1.Header1.Caption = "Impressora"
                loc_oGrid.Column2.Header1.Caption = "Ordem"
                loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column4.Header1.Caption = "Fixo"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista (fonte uniforme)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * ImpInteractiveChange - Atualiza ReadOnly de Cod.Abertura (fwget1)
    * Legado: fwget1.When = InList(crSigFiNtb.imps,'SWEDA','NSWEDA')
    * Campo habilitado APENAS quando impressora for SWEDA ou NSWEDA
    *===========================================================================
    PROCEDURE ImpInteractiveChange()
        LOCAL loc_cImps, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cImps   = ""

        IF PEMSTATUS(loc_oPagina, "cbo_4c_Imps", 5)
            loc_cImps = ALLTRIM(NVL(loc_oPagina.cbo_4c_Imps.Value, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Fwget1", 5)
            IF INLIST(loc_cImps, "SWEDA", "NSWEDA")
                loc_oPagina.txt_4c_Fwget1.ReadOnly = .F.
            ELSE
                loc_oPagina.txt_4c_Fwget1.ReadOnly = .T.
                loc_oPagina.txt_4c_Fwget1.Value    = ""
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega dados do grid
    *===========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
                THIS.AjustarBotoesPorModo()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara form para inclusao de novo registro
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cImps, loc_nOrdems
        loc_cImps   = ""
        loc_nOrdems = 0

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cImps   = ALLTRIM(cursor_4c_Dados.imps)
            loc_nOrdems = cursor_4c_Dados.ordems
        ENDIF

        IF EMPTY(loc_cImps)
            MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cImps, loc_nOrdems)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MostrarErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", ;
                        "FormFNF.BtnVisualizarClick")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cImps, loc_nOrdems
        loc_cImps   = ""
        loc_nOrdems = 0

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cImps   = ALLTRIM(cursor_4c_Dados.imps)
            loc_nOrdems = cursor_4c_Dados.ordems
        ENDIF

        IF EMPTY(loc_cImps)
            MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cImps, loc_nOrdems)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MostrarErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", ;
                        "FormFNF.BtnAlterarClick")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    * Legado valida se ordems esta em uso em SigCdOpe.trnfis (feito no BO)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cImps, loc_nOrdems, loc_lConfirma
        loc_cImps   = ""
        loc_nOrdems = 0
        loc_lConfirma  = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cImps   = ALLTRIM(cursor_4c_Dados.imps)
            loc_nOrdems = cursor_4c_Dados.ordems
        ENDIF

        IF EMPTY(loc_cImps)
            MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", ;
                                    "Confirmar Exclus" + CHR(227) + "o")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cImps, loc_nOrdems)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                THIS.CarregarLista()
            ENDIF
        ELSE
            MostrarErro("Erro ao carregar registro para exclus" + CHR(227) + "o.", ;
                        "FormFNF.BtnExcluirClick")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Recarrega lista completa (busca simples)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Salva o registro (Confirmar na Page2)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Sucesso")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos campos do Form para o BO
    * Usa PEMSTATUS para acesso defensivo (campos adicionados na Fase 5)
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "cbo_4c_Imps", 5)
            THIS.this_oBusinessObject.this_cImps = ALLTRIM(NVL(loc_oPagina.cbo_4c_Imps.Value, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Ordem", 5)
            THIS.this_oBusinessObject.this_nOrdems = NVL(loc_oPagina.txt_4c_Ordem.Value, 0)
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Opernf", 5)
            THIS.this_oBusinessObject.this_cOpernf = ALLTRIM(NVL(loc_oPagina.txt_4c_Opernf.Value, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Fwget1", 5)
            THIS.this_oBusinessObject.this_cOpernf2 = ALLTRIM(NVL(loc_oPagina.txt_4c_Fwget1.Value, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descr", 5)
            THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(NVL(loc_oPagina.txt_4c_Descr.Value, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "opt_4c_Opc_fixo", 5)
            *-- Database: 1=Sim, 0=Nao (o Value=2 do OptionGroup nao se mapeia para 2 no BD)
            THIS.this_oBusinessObject.this_nNfixos = IIF(loc_oPagina.opt_4c_Opc_fixo.Value = 1, 1, 0)
        ENDIF
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do BO para os campos do Form
    * Usa PEMSTATUS para acesso defensivo (campos adicionados na Fase 5)
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "cbo_4c_Imps", 5)
            loc_oPagina.cbo_4c_Imps.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cImps, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Ordem", 5)
            loc_oPagina.txt_4c_Ordem.Value = NVL(THIS.this_oBusinessObject.this_nOrdems, 0)
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Opernf", 5)
            loc_oPagina.txt_4c_Opernf.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cOpernf, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Fwget1", 5)
            loc_oPagina.txt_4c_Fwget1.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cOpernf2, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descr", 5)
            loc_oPagina.txt_4c_Descr.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDescrs, ""))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "opt_4c_Opc_fixo", 5)
            loc_oPagina.opt_4c_Opc_fixo.Value = IIF(THIS.this_oBusinessObject.this_nNfixos = 1, 1, 2)
        ENDIF

        *-- Atualizar estado Cod.Abertura baseado na impressora carregada
        THIS.ImpInteractiveChange()
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos da Page2 (para modo INCLUIR)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "cbo_4c_Imps", 5)
            loc_oPagina.cbo_4c_Imps.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Ordem", 5)
            loc_oPagina.txt_4c_Ordem.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Opernf", 5)
            loc_oPagina.txt_4c_Opernf.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Fwget1", 5)
            loc_oPagina.txt_4c_Fwget1.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descr", 5)
            loc_oPagina.txt_4c_Descr.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Opc_fixo", 5)
            loc_oPagina.opt_4c_Opc_fixo.Value = 2
        ENDIF
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lEnabled
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lEnabled = (par_lHabilitar = .T.)

        IF PEMSTATUS(loc_oPagina, "cbo_4c_Imps", 5)
            loc_oPagina.cbo_4c_Imps.Enabled = loc_lEnabled
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Ordem", 5)
            loc_oPagina.txt_4c_Ordem.Enabled  = loc_lEnabled
            loc_oPagina.txt_4c_Ordem.ReadOnly = !loc_lEnabled
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Opernf", 5)
            loc_oPagina.txt_4c_Opernf.Enabled  = loc_lEnabled
            loc_oPagina.txt_4c_Opernf.ReadOnly = !loc_lEnabled
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Fwget1", 5)
            IF loc_lEnabled
                *-- Habilitar respeitando regra When do legado (SWEDA/NSWEDA)
                THIS.ImpInteractiveChange()
            ELSE
                loc_oPagina.txt_4c_Fwget1.ReadOnly = .T.
            ENDIF
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descr", 5)
            loc_oPagina.txt_4c_Descr.Enabled  = loc_lEnabled
            loc_oPagina.txt_4c_Descr.ReadOnly = !loc_lEnabled
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_Opc_fixo", 5)
            loc_oPagina.opt_4c_Opc_fixo.Enabled = loc_lEnabled
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    * Botoes CRUD de Page1 ativos apenas no modo LISTA
    * Confirmar ativo em INCLUIR/ALTERAR; Cancelar sempre ativo em Page2
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lNaLista, loc_lPodeConfirmar
        loc_lNaLista     = (THIS.this_cModoAtual = "LISTA")
        loc_lPodeConfirmar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        TRY
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
                    .cmd_4c_Incluir.Enabled    = loc_lNaLista
                    .cmd_4c_Visualizar.Enabled = loc_lNaLista
                    .cmd_4c_Alterar.Enabled    = loc_lNaLista
                    .cmd_4c_Excluir.Enabled    = loc_lNaLista
                    .cmd_4c_Buscar.Enabled     = loc_lNaLista
                    .Visible     = .T.
                ENDWITH
            ENDIF

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lPodeConfirmar
                THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Percorre Pages de PageFrames e Controls de Containers
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nP, loc_oObjeto
        loc_nP = 0

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

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\FNFBO.prg):
*==============================================================================
* FNFBO.prg - Business Object para Finalizadoras n" + CHR(227) + "o Fiscal
* Tabela: SIGFINTB
* PK: cidchaves (char 20 - gerado via NEWID SQL Server)
*==============================================================================
DEFINE CLASS FNFBO AS BusinessBase

    *-- Propriedades herdadas (sobrescrever em Init)
    this_cTabela      = "SIGFINTB"
    this_cCampoChave  = "cidchaves"

    *-- Campos de SIGFINTB
    this_cCidChaves   = ""   && char(20) PK
    this_cImps        = ""   && char(20) Impressora
    this_nOrdems      = 0    && numeric(2,0) Ordem
    this_cOpernf      = ""   && char(2) Cod.Opera" + CHR(231) + CHR(227) + "o NF
    this_cOpernf2     = ""   && char(2) Cod.Abertura (s" + CHR(243) + " SWEDA/NSWEDA)
    this_cDescrs      = ""   && char(50) Descri" + CHR(231) + CHR(227) + "o
    this_nNfixos         = 0    && numeric(1,0) Fixo: 1=Sim 0=N" + CHR(227) + "o
    this_cImpsOriginal   = ""   && imps carregado do BD (antes de edicao)
    this_nOrdemsOriginal = 0    && ordems carregado do BD (antes de edicao)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGFINTB"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista finalizadoras n" + CHR(227) + "o fiscais
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.imps, a.ordems, a.descrs, a.nfixos" + ;
                       " FROM SIGFINTB a" + ;
                       " ORDER BY a.imps, a.ordems"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar finalizadoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar finalizadoras:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega finalizadora por Impressora+Ordem (chave natural)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cImps, par_nOrdems)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.imps, a.ordems, a.opernf, a.opernf2," + ;
                       " a.descrs, a.nfixos" + ;
                       " FROM SIGFINTB a" + ;
                       " WHERE a.imps = " + EscaparSQL(par_cImps) + ;
                       " AND a.ordems = " + FormatarNumeroSQL(par_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves      = TratarNulo(cidchaves, "C")
            THIS.this_cImps           = TratarNulo(imps,      "C")
            THIS.this_nOrdems         = TratarNulo(ordems,    "N")
            THIS.this_cImpsOriginal   = THIS.this_cImps
            THIS.this_nOrdemsOriginal = THIS.this_nOrdems
            THIS.this_cOpernf         = TratarNulo(opernf,    "C")
            THIS.this_cOpernf2        = TratarNulo(opernf2,   "C")
            THIS.this_cDescrs         = TratarNulo(descrs,    "C")
            THIS.this_nNfixos         = TratarNulo(nfixos,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUnicidade - Verifica se Impressora+Ordem j" + CHR(225) + " existe
    * Retorna .T. se combinacao esta disponivel (sem duplicata)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarUnicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDisponivel
        loc_lDisponivel = .T.

        *-- Se editando sem alterar chave composta, nao ha conflito de unicidade
        IF !THIS.this_lNovoRegistro AND ;
           ALLTRIM(THIS.this_cImps) = ALLTRIM(THIS.this_cImpsOriginal) AND ;
           THIS.this_nOrdems = THIS.this_nOrdemsOriginal
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "SELECT COUNT(*) AS cnt FROM SIGFINTB" + ;
                       " WHERE imps = " + EscaparSQL(THIS.this_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Unic")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Unic") > 0
                SELECT cursor_4c_Unic
                IF cursor_4c_Unic.cnt > 0
                    MsgAviso("Impressora / Ordem j" + CHR(225) + " cadastrada!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lDisponivel = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Unic")
                USE IN cursor_4c_Unic
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Unic")
                USE IN cursor_4c_Unic
            ENDIF
            loc_lDisponivel = .F.
        ENDTRY

        RETURN loc_lDisponivel
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SIGFINTB
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        *-- Validar duplicidade Impressora+Ordem ANTES do TRY
        IF !THIS.ValidarUnicidade()
            RETURN .F.
        ENDIF

        TRY
            *-- Gerar chave unica via NEWID do SQL Server
            THIS.this_cCidChaves = ""
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
                SELECT cursor_4c_Uuid
                THIS.this_cCidChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
            ENDIF
            IF USED("cursor_4c_Uuid")
                USE IN cursor_4c_Uuid
            ENDIF

            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "INSERT INTO SIGFINTB" + ;
                           " (cidchaves, imps, ordems, opernf, opernf2, descrs, nfixos)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                           EscaparSQL(THIS.this_cImps) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                           EscaparSQL(THIS.this_cOpernf) + ", " + ;
                           EscaparSQL(THIS.this_cOpernf2) + ", " + ;
                           EscaparSQL(THIS.this_cDescrs) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nNfixos) + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir finalizadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SIGFINTB
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        *-- Validar duplicidade Impressora+Ordem (excluindo registro atual) ANTES do TRY
        IF !THIS.ValidarUnicidade()
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SIGFINTB SET" + ;
                       " imps = " + EscaparSQL(THIS.this_cImps) + ", " + ;
                       " ordems = " + FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                       " opernf = " + EscaparSQL(THIS.this_cOpernf) + ", " + ;
                       " opernf2 = " + EscaparSQL(THIS.this_cOpernf2) + ", " + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       " nfixos = " + FormatarNumeroSQL(THIS.this_nNfixos) + ;
                       " WHERE imps = " + EscaparSQL(THIS.this_cImpsOriginal) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdemsOriginal)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar finalizadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE da finalizadora por chave natural imps+ordems
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGFINTB" + ;
                       " WHERE imps = " + EscaparSQL(THIS.this_cImpsOriginal) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdemsOriginal)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir finalizadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

