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
[2026-08-01 02:19:13] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-01 02:19:13] [INFO] Config FPW: (nao fornecido)
[2026-08-01 02:19:13] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 02:19:13] [INFO] Timeout: 300 segundos
[2026-08-01 02:19:13] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y4olbkr0.prg
[2026-08-01 02:19:13] [INFO] Conteudo do wrapper:
[2026-08-01 02:19:13] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormDIC', 'C:\4c\tasks\task394', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDIC', 'C:\4c\tasks\task394', 'CRUD'
QUIT

[2026-08-01 02:19:13] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y4olbkr0.prg
[2026-08-01 02:19:13] [INFO] VFP output esperado em: C:\4c\tasks\task394\vfp_output.txt
[2026-08-01 02:19:13] [INFO] Executando Visual FoxPro 9...
[2026-08-01 02:19:13] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y4olbkr0.prg
[2026-08-01 02:19:13] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y4olbkr0.prg
[2026-08-01 02:19:13] [INFO] Timeout configurado: 300 segundos
[2026-08-01 02:19:59] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-01 02:19:59] [INFO] VFP9 finalizado em 46.2759616 segundos
[2026-08-01 02:19:59] [INFO] Exit Code: 
[2026-08-01 02:19:59] [INFO] 
[2026-08-01 02:19:59] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-01 02:19:59] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y4olbkr0.prg
[2026-08-01 02:19:59] [INFO] 
[2026-08-01 02:19:59] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-01 02:19:59] [INFO] * Auto-generated wrapper for parameters
[2026-08-01 02:19:59] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 02:19:59] [INFO] * Parameters: 'FormDIC', 'C:\4c\tasks\task394', 'CRUD'
[2026-08-01 02:19:59] [INFO] 
[2026-08-01 02:19:59] [INFO] * Anti-dialog protections for unattended execution
[2026-08-01 02:19:59] [INFO] SET SAFETY OFF
[2026-08-01 02:19:59] [INFO] SET RESOURCE OFF
[2026-08-01 02:19:59] [INFO] SET TALK OFF
[2026-08-01 02:19:59] [INFO] SET NOTIFY OFF
[2026-08-01 02:19:59] [INFO] SYS(2335, 0)
[2026-08-01 02:19:59] [INFO] 
[2026-08-01 02:19:59] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDIC', 'C:\4c\tasks\task394', 'CRUD'
[2026-08-01 02:19:59] [INFO] QUIT
[2026-08-01 02:19:59] [INFO] 
[2026-08-01 02:19:59] [INFO] === Fim do Wrapper.prg ===
[2026-08-01 02:19:59] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormDIC",
  "timestamp": "20260801021959",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDIC.prg):
*==============================================================================
* FormDIC.prg - Cadastro de Idioma/Dicionario
* Herda de: FormBase (app/classes/formbase.prg)
* Tabela: SigCdDic
* BO: DICBO
*
* FASE 3/8 - Estrutura base: PageFrame + Containers principais
*==============================================================================

DEFINE CLASS FormDIC AS FormBase

    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Idioma"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    BackColor   = RGB(100, 100, 100)
    FontName    = "Tahoma"
    FontSize    = 8

    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("DICBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar DICBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

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
            .Visible   = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(100, 100, 100)
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(100, 100, 100)
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (cntSombra no legado: Top=1, compensacao +29 = 30)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 11
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

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
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
        ENDWITH

        *-- Container botoes CRUD (Grupo_op no legado: Top=-1, compensacao +29 = 28 -> canonico 29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption         = "Incluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH .cmd_4c_Visualizar
                .Caption         = "Visualizar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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

            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Caption         = "Alterar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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

            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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

            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Caption         = "Buscar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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
        ENDWITH

        *-- Container saida - padrao canonico (PREVALECE sobre PILAR 1)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 917
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Grid de listagem (grade no legado: Top=88, compensacao +29 = 117)
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oPagina.grd_4c_Dados
            .Top                = 117
            .Left               = 0
            .Width              = 910
            .Height             = 455
            .ColumnCount        = 3
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

        *-- BINDEVENT: vincular botoes
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes acao (Grupo_Salva: Top=4+29=33, Left=842, Width=160)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
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
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH .cmd_4c_Cancelar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
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
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Idioma (Say1 + GetIdioma)
        *-- Legado: Say1.Top=144->173, Say1.Left=63 | GetIdioma.Top=139->168, Left=116, Width=87
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Idioma :"
            .Top       = 173
            .Left      = 63
            .Width     = 51
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Idioma", "TextBox")
        WITH loc_oPagina.txt_4c_Idioma
            .Value       = ""
            .Top         = 168
            .Left        = 116
            .Width       = 87
            .Height      = 24
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .MaxLength   = 20
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH

        *-- Expressao (Say2 + GetExpressao)
        *-- Legado: Say2.Top=183->212, Say2.Left=42 | GetExpressao.Top=179->208, Left=116, Width=525
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Express" + CHR(227) + "o :"
            .Top       = 212
            .Left      = 42
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Expressao", "TextBox")
        WITH loc_oPagina.txt_4c_Expressao
            .Value       = ""
            .Top         = 208
            .Left        = 116
            .Width       = 525
            .Height      = 24
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .MaxLength   = 200
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH

        *-- Traducao (Say3 + GetTraducao)
        *-- Legado: Say3.Top=226->255, Say3.Left=49 | GetTraducao.Top=222->251, Left=117, Width=525
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Tradu" + CHR(231) + CHR(227) + "o :"
            .Top       = 255
            .Left      = 49
            .Width     = 64
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Traducao", "TextBox")
        WITH loc_oPagina.txt_4c_Traducao
            .Value       = ""
            .Top         = 251
            .Left        = 117
            .Width       = 525
            .Height      = 24
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .MaxLength   = 60
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 3

                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Idioma"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Expressao"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Traducao"

                    loc_oGrid.Column1.Width = 70
                    loc_oGrid.Column2.Width = 280
                    loc_oGrid.Column3.Width = 280

                    loc_oGrid.Column1.Header1.Caption = "Idioma"
                    loc_oGrid.Column2.Header1.Caption = "Express" + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Tradu" + CHR(231) + CHR(227) + "o"

                    loc_oGrid.Refresh()
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
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
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Idioma", 5)
            loc_oPagina.txt_4c_Idioma.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
            loc_oPagina.txt_4c_Expressao.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Traducao", 5)
            loc_oPagina.txt_4c_Traducao.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    *-- HabilitarCampos: replica comportamento dos When events do legado:
    *-- GetIdioma.When:    .T. apenas em INCLUIR
    *-- GetExpressao.When: .T. em INCLUIR e BUSCAR
    *-- GetTraducao.When:  .T. em INCLUIR e ALTERAR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lIdioma, loc_lExpressao, loc_lTraducao
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        DO CASE
            CASE THIS.this_cModoAtual = "INCLUIR"
                loc_lIdioma    = .T.
                loc_lExpressao = .T.
                loc_lTraducao  = .T.
            CASE THIS.this_cModoAtual = "ALTERAR"
                loc_lIdioma    = .F.
                loc_lExpressao = .F.
                loc_lTraducao  = .T.
            CASE THIS.this_cModoAtual = "BUSCAR"
                loc_lIdioma    = .F.
                loc_lExpressao = .T.
                loc_lTraducao  = .F.
            OTHERWISE
                loc_lIdioma    = .F.
                loc_lExpressao = .F.
                loc_lTraducao  = .F.
        ENDCASE

        IF PEMSTATUS(loc_oPagina, "txt_4c_Idioma", 5)
            loc_oPagina.txt_4c_Idioma.Enabled = loc_lIdioma AND par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
            loc_oPagina.txt_4c_Expressao.Enabled = loc_lExpressao AND par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Traducao", 5)
            loc_oPagina.txt_4c_Traducao.Enabled = loc_lTraducao AND par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lConfirmar
        loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
        loc_lConfirmar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")

        IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
            loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lConfirmar
        ENDIF
        IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
            loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Idioma", 5)
            loc_oPagina.txt_4c_Idioma.Value = ALLTRIM(THIS.this_oBusinessObject.this_cIdioma)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
            loc_oPagina.txt_4c_Expressao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cExpressao)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Traducao", 5)
            loc_oPagina.txt_4c_Traducao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cTraducao)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Idioma", 5)
            THIS.this_oBusinessObject.this_cIdioma = ALLTRIM(loc_oPagina.txt_4c_Idioma.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
            THIS.this_oBusinessObject.this_cExpressao = ALLTRIM(loc_oPagina.txt_4c_Expressao.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Traducao", 5)
            THIS.this_oBusinessObject.this_cTraducao = ALLTRIM(loc_oPagina.txt_4c_Traducao.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cIdioma, loc_cExpressao, loc_cTraducao
        LOCAL loc_cSQL, loc_nResult
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_cIdioma    = ""
        loc_cExpressao = ""
        loc_cTraducao  = ""

        *-- Em modo BUSCAR: localiza registro pela expressao e retorna para lista
        IF THIS.this_cModoAtual = "BUSCAR"
            IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
                loc_cExpressao = ALLTRIM(loc_oPagina.txt_4c_Expressao.Value)
            ENDIF
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            IF !EMPTY(loc_cExpressao) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(cursor_4c_Dados.Expressao) = loc_cExpressao
                IF !EOF("cursor_4c_Dados")
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
            RETURN
        ENDIF

        *-- Obter valores para validacao
        IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
            loc_cExpressao = ALLTRIM(loc_oPagina.txt_4c_Expressao.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Idioma", 5)
            loc_cIdioma = ALLTRIM(loc_oPagina.txt_4c_Idioma.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Traducao", 5)
            loc_cTraducao = ALLTRIM(loc_oPagina.txt_4c_Traducao.Value)
        ENDIF

        *-- Validacoes obrigatorias (INCLUIR e ALTERAR)
        IF EMPTY(loc_cExpressao)
            MsgAviso("Express" + CHR(227) + "o Inv" + CHR(225) + "lida !!", "Salvar")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
                loc_oPagina.txt_4c_Expressao.SetFocus()
            ENDIF
            RETURN
        ENDIF
        IF EMPTY(loc_cIdioma)
            MsgAviso("Idioma Inv" + CHR(225) + "lido !!", "Salvar")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Idioma", 5)
                loc_oPagina.txt_4c_Idioma.SetFocus()
            ENDIF
            RETURN
        ENDIF
        IF EMPTY(loc_cTraducao)
            MsgAviso("Tradu" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!", "Salvar")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Traducao", 5)
                loc_oPagina.txt_4c_Traducao.SetFocus()
            ENDIF
            RETURN
        ENDIF

        *-- Em modo INCLUIR: verificar duplicidade por Expressao + Idioma
        IF THIS.this_cModoAtual = "INCLUIR"
            loc_cSQL = "SELECT 1 AS chk FROM SigCdDic WHERE Expressao = " + EscaparSQL(loc_cExpressao) + ;
                       " AND Idioma = " + EscaparSQL(loc_cIdioma)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck")
            IF USED("cursor_4c_DupCheck")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_DupCheck") > 0
                    USE IN cursor_4c_DupCheck
                    MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado !!", "Salvar")
                    IF PEMSTATUS(loc_oPagina, "txt_4c_Expressao", 5)
                        loc_oPagina.txt_4c_Expressao.SetFocus()
                    ENDIF
                    RETURN
                ENDIF
                USE IN cursor_4c_DupCheck
            ENDIF
        ENDIF

        *-- Transferir Form -> BO e salvar
        THIS.FormParaBO()
        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Salvar")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cExpressao, loc_cIdioma

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista!", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cExpressao = ALLTRIM(cursor_4c_Dados.Expressao)
        loc_cIdioma    = ALLTRIM(cursor_4c_Dados.Idioma)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cExpressao, loc_cIdioma)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cExpressao, loc_cIdioma

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista!", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cExpressao = ALLTRIM(cursor_4c_Dados.Expressao)
        loc_cIdioma    = ALLTRIM(cursor_4c_Dados.Idioma)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cExpressao, loc_cIdioma)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cExpressao, loc_cIdioma

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista!", "Excluir")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cExpressao = ALLTRIM(cursor_4c_Dados.Expressao)
        loc_cIdioma    = ALLTRIM(cursor_4c_Dados.Idioma)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cExpressao, loc_cIdioma)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "BUSCAR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

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
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\DICBO.prg):
*==============================================================================
* DICBO.prg - Business Object para Dicionario de Idiomas
* Tabela: SigCdDic
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS DICBO AS BusinessBase

    *-- Campos da tabela SigCdDic
    this_dDatas     = {}    && datas datetime NULL
    this_cExpressao = ""    && expressao char(60) NOT NULL
    this_cIdioma    = ""    && idioma char(10) NOT NULL
    this_cTraducao  = ""    && traducao char(60) NOT NULL
    this_cUsuars    = ""    && usuars char(10) NOT NULL

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdDic"
            THIS.this_cCampoChave = "Expressao"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cExpressao) + "|" + ALLTRIM(THIS.this_cIdioma)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros do dicionario filtrados por par_cFiltro
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            IF EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT Idioma, Expressao, Traducao" + ;
                    " FROM SigCdDic" + ;
                    " ORDER BY Expressao, Idioma"
            ELSE
                loc_cSQL = "SELECT Idioma, Expressao, Traducao" + ;
                    " FROM SigCdDic" + ;
                    " WHERE Expressao LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    "    OR Idioma LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    " ORDER BY Expressao, Idioma"
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave composta Expressao + Idioma
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cExpressao, par_cIdioma)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT datas, expressao, idioma, traducao, usuars" + ;
                " FROM SigCdDic" + ;
                " WHERE Expressao = " + EscaparSQL(par_cExpressao) + ;
                "   AND Idioma    = " + EscaparSQL(par_cIdioma)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
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
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_dDatas     = TratarNulo(datas,      "D")
            THIS.this_cExpressao = TratarNulo(expressao,  "C")
            THIS.this_cIdioma    = TratarNulo(idioma,     "C")
            THIS.this_cTraducao  = TratarNulo(traducao,   "C")
            THIS.this_cUsuars    = TratarNulo(usuars,     "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de inserir/atualizar
    *--------------------------------------------------------------------------
    FUNCTION ValidarDados()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF EMPTY(ALLTRIM(THIS.this_cExpressao))
            MsgAviso("Express" + CHR(227) + "o Inv" + CHR(225) + "lida !!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cIdioma))
            MsgAviso("Idioma Inv" + CHR(225) + "lido !!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cTraducao))
            MsgAviso("Tradu" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se Expressao+Idioma ja existe (apenas no INSERT)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDic" + ;
                " WHERE Expressao = " + EscaparSQL(THIS.this_cExpressao) + ;
                "   AND Idioma    = " + EscaparSQL(THIS.this_cIdioma)

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (cursor_4c_Dup.Total > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdDic
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            IF THIS.VerificarDuplicidade()
                MsgAviso(CHR(67) + CHR(243) + "digo j" + CHR(225) + " Cadastrado !!", "Duplicado")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "INSERT INTO SigCdDic" + ;
                    " (datas, expressao, idioma, traducao, usuars)" + ;
                    " VALUES (" + ;
                    "GETDATE(), " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cExpressao), 60)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cIdioma), 10)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cTraducao), 60)) + ", " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuars), 10)) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdDic
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "UPDATE SigCdDic SET" + ;
                " traducao = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTraducao), 60)) + "," + ;
                " usuars   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuars), 10)) + ;
                " WHERE Expressao = " + EscaparSQL(THIS.this_cExpressao) + ;
                "   AND Idioma    = " + EscaparSQL(THIS.this_cIdioma)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdDic
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdDic" + ;
                " WHERE Expressao = " + EscaparSQL(THIS.this_cExpressao) + ;
                "   AND Idioma    = " + EscaparSQL(THIS.this_cIdioma)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

