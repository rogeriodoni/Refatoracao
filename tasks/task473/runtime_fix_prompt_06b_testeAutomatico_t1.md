# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 429; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-21 18:17:39] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-21 18:17:39] [INFO] Config FPW: (nao fornecido)
[2026-08-21 18:17:39] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-21 18:17:39] [INFO] Timeout: 300 segundos
[2026-08-21 18:17:39] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kv2ugctv.prg
[2026-08-21 18:17:39] [INFO] Conteudo do wrapper:
[2026-08-21 18:17:39] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormMun', 'C:\4c\tasks\task473', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMun', 'C:\4c\tasks\task473', 'CRUD'
QUIT

[2026-08-21 18:17:39] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kv2ugctv.prg
[2026-08-21 18:17:39] [INFO] VFP output esperado em: C:\4c\tasks\task473\vfp_output.txt
[2026-08-21 18:17:39] [INFO] Executando Visual FoxPro 9...
[2026-08-21 18:17:39] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kv2ugctv.prg
[2026-08-21 18:17:39] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kv2ugctv.prg
[2026-08-21 18:17:39] [INFO] Timeout configurado: 300 segundos
[2026-08-21 18:18:55] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-21 18:18:55] [INFO] VFP9 finalizado em 76.3793214 segundos
[2026-08-21 18:18:55] [INFO] Exit Code: 
[2026-08-21 18:18:55] [INFO] 
[2026-08-21 18:18:55] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-21 18:18:55] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kv2ugctv.prg
[2026-08-21 18:18:55] [INFO] 
[2026-08-21 18:18:55] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-21 18:18:55] [INFO] * Auto-generated wrapper for parameters
[2026-08-21 18:18:55] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-21 18:18:55] [INFO] * Parameters: 'FormMun', 'C:\4c\tasks\task473', 'CRUD'
[2026-08-21 18:18:55] [INFO] 
[2026-08-21 18:18:55] [INFO] * Anti-dialog protections for unattended execution
[2026-08-21 18:18:55] [INFO] SET SAFETY OFF
[2026-08-21 18:18:55] [INFO] SET RESOURCE OFF
[2026-08-21 18:18:55] [INFO] SET TALK OFF
[2026-08-21 18:18:55] [INFO] SET NOTIFY OFF
[2026-08-21 18:18:55] [INFO] SYS(2335, 0)
[2026-08-21 18:18:55] [INFO] 
[2026-08-21 18:18:55] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormMun', 'C:\4c\tasks\task473', 'CRUD'
[2026-08-21 18:18:55] [INFO] QUIT
[2026-08-21 18:18:55] [INFO] 
[2026-08-21 18:18:55] [INFO] === Fim do Wrapper.prg ===
[2026-08-21 18:18:55] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormMun",
  "timestamp": "20260821181855",
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
      "detalhes": "Linha: 429"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 559"
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 1 (KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMun.prg):
*==============================================================================
* FormMun.prg - Formulario de Cadastro de Municipios
* Migrado de: SigCdMun.SCX (frmcadastro)
* Tabela: SigCdMun
* Chave: cidchaves char(20) / negocio: codigos char(7)
*==============================================================================

DEFINE CLASS FormMun AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    *-- Original: Height=600, Width=1000 (frmcadastro padrao)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Municipios"
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
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("MunBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar MunBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormMun.InicializarForm")
            ELSE
                *-- Caption com acentuacao correta (nunca acentos literais em .PRG)
                THIS.Caption = "Cadastro de C" + CHR(243) + "digo de Munic" + CHR(237) + "pios"

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
            MostrarErro("Erro ao inicializar FormMun:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormMun.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 esconde abas; todos os controles dentro compensam +29 no Top
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

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD e Grid
    * Original: cntSombra.Top=1, Grupo_op.Top=-1 (Left=538), Grade.Top=88
    * Compensacao PageFrame (+29): Top original + 29
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Original: cntSombra.Top=1, Left=-1, Width=1008, Height=80
        *-- Com compensacao +29: Top=30
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
            .Caption   = ""
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
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
            .Caption   = ""
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

        *-- Container botoes CRUD (Grupo_op no legado)
        *-- Original: Grupo_op.Top=-1, Left=538, Width=389, Height=85
        *-- Com compensacao +29: Top=28
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
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
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
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

        *-- Botao Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
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

        *-- Botao Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
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

        *-- Botao Excluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
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

        *-- Botao Buscar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
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

        *-- Grid principal (Grade no legado: Grade.Top=88 + compensacao +29 = 117)
        *-- Colunas: Codigos (60px), Descs (290px) - do Init original
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
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

        *-- ColumnCount fora do WITH (Problema 36: evitar "Unknown member COLUMN1")
        loc_oPagina.grd_4c_Lista.ColumnCount = 2
        WITH loc_oPagina.grd_4c_Lista.Column1
            .Width           = 60
            .Alignment       = 0
            .Header1.Caption = "C" + CHR(243) + "digo"
        ENDWITH
        WITH loc_oPagina.grd_4c_Lista.Column2
            .Width           = 290
            .Alignment       = 0
            .Header1.Caption = "Munic" + CHR(237) + "pio"
        ENDWITH

        *-- Container Saida - PADRAO CANONICO (prevalece sobre PILAR 1)
        *-- Original: Grupo_Saida.Top=-1, Left=918. Canonico: Left=917, Width=90
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
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
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

        *-- BINDEVENTs dos botoes CRUD e Encerrar (PUBLIC - obrigatorio para BINDEVENT)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2: container de acoes e campos
    * Original: Grupo_Salva.Top=9, Left=817. Com compensacao +29: Top=38
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar (Grupo_Salva no legado)
        *-- Original: Grupo_Salva.Top=9, Left=817, Width=160, Height=85
        *-- Com compensacao +29: Top=38
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 38
            .Left        = 817
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salvar)
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
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

        *-- Botao Cancelar
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
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

        *-- BINDEVENTs dos botoes de Page2 (PUBLIC - obrigatorio para BINDEVENT)
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- ====== CAMPOS DA PAGE2 - PARTE 1/2 ======
        *-- Coordenadas originais do SCX + compensacao PageFrame (+29 no Top)

        *-- lbl_4c_Label2: "Codigo :" - Original: Top=133, Left=302, Width=42, Height=15
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 162
            .Left      = 302
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Codigos (get_Codigos): Original: Top=129, Left=347, Width=60, Height=25
        *-- InputMask="9999999": codigos e campo numerico-string (somente digitos)
        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Value         = ""
            .Top           = 158
            .Left          = 347
            .Width         = 60
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "9999999"
            .MaxLength     = 7
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label5 (Say5): "Cod. da UF no IBGE :" - Original: Top=133, Left=504
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "C" + CHR(243) + "d. da UF no IBGE :"
            .Top       = 162
            .Left      = 504
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_UFIBGES (getUFIBGES): Original: Top=128, Left=613, Width=24, Height=25
        *-- Lookup: SigCdUfs tabela, campo UFIBGEs (equivalente ao Valid/fwBuscaExt original)
        loc_oPagina.AddObject("txt_4c_UFIBGES", "TextBox")
        WITH loc_oPagina.txt_4c_UFIBGES
            .Value         = 0
            .Top           = 157
            .Left          = 613
            .Width         = 24
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99"
            .MaxLength     = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label1: "Descricao :" - Original: Top=160, Left=289, Width=55, Height=15
        *-- Com compensacao +29: Top=189
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 189
            .Left      = 289
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Descs (get_Descs): Original: Top=157, Left=347, Width=290, Height=23
        *-- Format="K!" (K=seleciona tudo ao entrar, !=uppercase). MaxLength=40
        *-- When original: InList(pcEscolha,'INSERIR','ALTERAR','PROCURAR') -> HabilitarCampos gerencia
        loc_oPagina.AddObject("txt_4c_Descs", "TextBox")
        WITH loc_oPagina.txt_4c_Descs
            .Value         = ""
            .Top           = 186
            .Left          = 347
            .Width         = 290
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 40
            .SpecialEffect = 1
            .Format        = "K!"
            .Visible       = .T.
        ENDWITH

        *-- BINDEVENT: ValidarUFIBGES equivale ao Valid/fwBuscaExt original (SigCdUfs.UFIBGEs)
        BINDEVENT(loc_oPagina.txt_4c_UFIBGES, "KeyPress", THIS, "ValidarUFIBGES")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1 via MunBO.Buscar()
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            loc_lResultado = .T.
        ELSE
            TRY
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lResultado = .F.
                ELSE
                    *-- Problema 36: RecordSource e ColumnCount FORA de WITH
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"

                    *-- Problema 32: redefinir cabecalhos apos RecordSource (auto-bind reseta)
                    loc_oGrid.Column1.Width           = 60
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Width           = 290
                    loc_oGrid.Column2.Header1.Caption = "Munic" + CHR(237) + "pio"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            CATCH TO loException
                MsgErro(loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                    "Procedure: " + loException.Procedure, ;
                    "FormMun.CarregarLista")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
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
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara inclusao de novo municipio
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe municipio selecionado em modo somente leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um munic" + CHR(237) + "pio na lista.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ELSE
            MsgAviso("Erro ao carregar o munic" + CHR(237) + "pio selecionado.", "")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre municipio selecionado para edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um munic" + CHR(237) + "pio na lista.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ELSE
            MsgAviso("Erro ao carregar o munic" + CHR(237) + "pio selecionado.", "")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui municipio selecionado apos confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirmado

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um munic" + CHR(237) + "pio na lista.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

        loc_lConfirmado = MsgConfirma("Deseja excluir o munic" + CHR(237) + ;
            "pio '" + loc_cCodigo + "'?", ;
            "Confirmar Exclus" + CHR(227) + "o")

        IF loc_lConfirmado
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Munic" + CHR(237) + "pio exclu" + CHR(237) + ;
                        "do com sucesso!", "")
                    THIS.CarregarLista()
                ENDIF
            ELSE
                MsgAviso("Erro ao carregar o munic" + CHR(237) + ;
                    "pio para exclus" + CHR(227) + "o.", "")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre lookup para localizar municipio na lista
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMun", "cursor_4c_BuscaMun", "codigos", "", ;
                "Buscar Munic" + CHR(237) + "pio")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs",   "", "Munic" + CHR(237) + "pio")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMun")
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaMun.codigos)
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormMun.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaMun")
            USE IN cursor_4c_BuscaMun
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva o municipio (Confirmar na Page2)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes obrigatorias antes do TRY (RETURN nao permitido dentro de TRY)
        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Codigos.Value))
                MsgAviso("C" + CHR(243) + "digo do Munic" + CHR(237) + ;
                    "pio obrigat" + CHR(243) + "rio!", "")
                loc_oPagina.txt_4c_Codigos.SetFocus()
                RETURN
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descs", 5)
            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Descs.Value))
                MsgAviso("Nome do Munic" + CHR(237) + "pio obrigat" + CHR(243) + "rio!", "")
                loc_oPagina.txt_4c_Descs.SetFocus()
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.ValidarDuplicidade()
            MsgAviso("C" + CHR(243) + "digo " + ;
                ALLTRIM(THIS.this_oBusinessObject.this_cCodigos) + ;
                " j" + CHR(225) + " cadastrado!", "")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
                loc_oPagina.txt_4c_Codigos.SetFocus()
            ENDIF
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Munic" + CHR(237) + "pio salvo com sucesso!", "")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos de entrada da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_oPagina.txt_4c_Codigos.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descs", 5)
            loc_oPagina.txt_4c_Descs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_UFIBGES", 5)
            loc_oPagina.txt_4c_UFIBGES.Value = 0
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de entrada da Page2
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lHabilitar
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_lHabilitar = (par_lHabilitar = .T.)

        *-- Codigo editavel somente em modo INCLUIR (PK nao pode ser alterada)
        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_oPagina.txt_4c_Codigos.Enabled = (loc_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descs", 5)
            loc_oPagina.txt_4c_Descs.Enabled = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_UFIBGES", 5)
            loc_oPagina.txt_4c_UFIBGES.Enabled = loc_lHabilitar
        ENDIF

        *-- Botao Confirmar habilitado somente quando campos editaveis
        IF PEMSTATUS(loc_oPagina, "cnt_4c_Salva", 5)
            IF PEMSTATUS(loc_oPagina.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
                loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lHabilitar
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do BO para os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            loc_oPagina.txt_4c_Codigos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descs", 5)
            loc_oPagina.txt_4c_Descs.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_UFIBGES", 5)
            loc_oPagina.txt_4c_UFIBGES.Value = THIS.this_oBusinessObject.this_nUFIBGES
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere dados dos campos da Page2 para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
            THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descs", 5)
            THIS.this_oBusinessObject.this_cDescs = ALLTRIM(loc_oPagina.txt_4c_Descs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_UFIBGES", 5)
            THIS.this_oBusinessObject.this_nUFIBGES = loc_oPagina.txt_4c_UFIBGES.Value
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarUFIBGES - Lookup SigCdUfs ao sair do campo (equivale ao Valid original)
    * Original: fwBuscaExt SigCdUfs / UFIBGEs / crListaRemota
    *==========================================================================
    PROCEDURE ValidarUFIBGES
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPagina, loc_nResult, loc_cSQL, loc_oBusca
        loc_oPagina  = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_UFIBGES", 5)
            RETURN
        ENDIF

        IF loc_oPagina.txt_4c_UFIBGES.Value = 0
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT UFIBGEs, Estados, Descrs FROM SigCdUfs ORDER BY UFIBGEs"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUF")

            IF loc_nResult > 0 AND USED("cursor_4c_BuscaUF") AND RECCOUNT("cursor_4c_BuscaUF") > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaUF"
                    loc_oBusca.this_cTitulo        = "Selecionar UF no IBGE"
                    loc_oBusca.mAddColuna("UFIBGEs", "", "C" + CHR(243) + "d. IBGE")
                    loc_oBusca.mAddColuna("Estados", "", "UF")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUF")
                        SELECT cursor_4c_BuscaUF
                        loc_oPagina.txt_4c_UFIBGES.Value = cursor_4c_BuscaUF.UFIBGEs
                    ELSE
                        loc_oPagina.txt_4c_UFIBGES.Value = 0
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                MsgAviso("C" + CHR(243) + "d. UF IBGE n" + CHR(227) + "o encontrado.", "")
                loc_oPagina.txt_4c_UFIBGES.Value = 0
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                "Procedure: " + loException.Procedure, ;
                "FormMun.ValidarUFIBGES")
        ENDTRY

        IF USED("cursor_4c_BuscaUF")
            USE IN cursor_4c_BuscaUF
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme o modo atual
    * LISTA: botoes CRUD ativos; INCLUIR/ALTERAR: Confirmar+Cancelar ativos;
    * VISUALIZAR: apenas Cancelar ativo (Confirmar desabilitado)
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lLista, loc_lEdita, loc_lVisualiza
        loc_oPg1       = THIS.pgf_4c_Paginas.Page1
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2
        loc_lLista     = (THIS.this_cModoAtual = "LISTA")
        loc_lEdita     = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        loc_lVisualiza = (THIS.this_cModoAtual = "VISUALIZAR")

        *-- Page1: botoes CRUD habilitados apenas em modo LISTA
        IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
            WITH loc_oPg1.cnt_4c_Botoes
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir",    5)
                    .cmd_4c_Incluir.Enabled    = loc_lLista
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
                    .cmd_4c_Visualizar.Enabled = loc_lLista
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar",    5)
                    .cmd_4c_Alterar.Enabled    = loc_lLista
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir",    5)
                    .cmd_4c_Excluir.Enabled    = loc_lLista
                ENDIF
                IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar",     5)
                    .cmd_4c_Buscar.Enabled     = loc_lLista
                ENDIF
                .Visible     = .T.
            ENDWITH
        ENDIF

        *-- Page2: Confirmar habilitado so em INCLUIR/ALTERAR; Cancelar sempre ativo em Page2
        IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdita
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
                loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = (loc_lEdita OR loc_lVisualiza)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        IF USED("cursor_4c_DupMun")
            USE IN cursor_4c_DupMun
        ENDIF

        IF USED("cursor_4c_BuscaUF")
            USE IN cursor_4c_BuscaUF
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\MunBO.prg):
*==============================================================================
* MunBO.prg - Business Object para Cadastro de Municípios
* Tabela: SigCdMun
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS MunBO AS BusinessBase

    *-- Propriedades da tabela SigCdMun
    this_cCidChaves = ""     && cidchaves char(20) - chave interna PK do banco
    this_cCodigos   = ""     && codigos char(7) - código do município (negócio)
    this_cDescs     = ""     && descs char(40) - nome do município
    this_nUFIBGES   = 0      && ufibges numeric(2,0) - código da UF no IBGE

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMun"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave interna para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cCodigos   = TratarNulo(codigos,   "C")
            THIS.this_cDescs     = TratarNulo(descs,     "C")
            THIS.this_nUFIBGES   = TratarNulo(ufibges,   "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT todos os municípios (PUBLIC - chamado pelo Form)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descs, ufibges, cidchaves" + ;
                       " FROM SigCdMun" + ;
                       " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar municípios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega município por código de negócio (codigos)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descs, ufibges, cidchaves" + ;
                       " FROM SigCdMun" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdMun (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = SYS(2015) + SYS(2015)
                THIS.this_cCidChaves = LEFT(THIS.this_cCidChaves, 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdMun (codigos, descs, ufibges, cidchaves) VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescs))   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nUFIBGES)   + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir município:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdMun (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMun SET" + ;
                       " descs = "   + EscaparSQL(ALLTRIM(THIS.this_cDescs))   + "," + ;
                       " ufibges = " + FormatarNumeroSQL(THIS.this_nUFIBGES)   + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar município:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdMun (PROTECTED - chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdMun" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir município:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDuplicidade - Verifica se código já cadastrado
    * Para INSERT: verifica se codigos existe
    * Para UPDATE: verifica se outro registro tem o mesmo codigos
    *--------------------------------------------------------------------------
    FUNCTION ValidarDuplicidade()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        *-- codigos nao pode ser alterado no UPDATE, entao duplicidade so eh possivel em INSERT
        IF !THIS.this_lNovoRegistro
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT codigos FROM SigCdMun" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DupMun")
                TABLEREVERT(.T., "cursor_4c_DupMun")
                USE IN cursor_4c_DupMun
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupMun")

            IF loc_nResult >= 0
                loc_lResultado = (RECCOUNT("cursor_4c_DupMun") > 0)
            ENDIF

            IF USED("cursor_4c_DupMun")
                USE IN cursor_4c_DupMun
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MunBO.ValidarDuplicidade")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

