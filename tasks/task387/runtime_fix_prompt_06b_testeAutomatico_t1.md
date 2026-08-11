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
[2026-07-31 17:35:11] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-31 17:35:11] [INFO] Config FPW: (nao fornecido)
[2026-07-31 17:35:11] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-31 17:35:11] [INFO] Timeout: 300 segundos
[2026-07-31 17:35:11] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_k55dl23f.prg
[2026-07-31 17:35:11] [INFO] Conteudo do wrapper:
[2026-07-31 17:35:11] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCst', 'C:\4c\tasks\task387', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCst', 'C:\4c\tasks\task387', 'CRUD'
QUIT

[2026-07-31 17:35:11] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_k55dl23f.prg
[2026-07-31 17:35:11] [INFO] VFP output esperado em: C:\4c\tasks\task387\vfp_output.txt
[2026-07-31 17:35:11] [INFO] Executando Visual FoxPro 9...
[2026-07-31 17:35:11] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_k55dl23f.prg
[2026-07-31 17:35:11] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_k55dl23f.prg
[2026-07-31 17:35:11] [INFO] Timeout configurado: 300 segundos
[2026-07-31 17:35:57] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-31 17:35:57] [INFO] VFP9 finalizado em 45.5154874 segundos
[2026-07-31 17:35:57] [INFO] Exit Code: 
[2026-07-31 17:35:57] [INFO] 
[2026-07-31 17:35:57] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-31 17:35:57] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_k55dl23f.prg
[2026-07-31 17:35:57] [INFO] 
[2026-07-31 17:35:57] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-31 17:35:57] [INFO] * Auto-generated wrapper for parameters
[2026-07-31 17:35:57] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-31 17:35:57] [INFO] * Parameters: 'FormCst', 'C:\4c\tasks\task387', 'CRUD'
[2026-07-31 17:35:57] [INFO] 
[2026-07-31 17:35:57] [INFO] * Anti-dialog protections for unattended execution
[2026-07-31 17:35:57] [INFO] SET SAFETY OFF
[2026-07-31 17:35:57] [INFO] SET RESOURCE OFF
[2026-07-31 17:35:57] [INFO] SET TALK OFF
[2026-07-31 17:35:57] [INFO] SET NOTIFY OFF
[2026-07-31 17:35:57] [INFO] SYS(2335, 0)
[2026-07-31 17:35:57] [INFO] 
[2026-07-31 17:35:57] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCst', 'C:\4c\tasks\task387', 'CRUD'
[2026-07-31 17:35:57] [INFO] QUIT
[2026-07-31 17:35:57] [INFO] 
[2026-07-31 17:35:57] [INFO] === Fim do Wrapper.prg ===
[2026-07-31 17:35:57] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormCst",
  "timestamp": "20260731173557",
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
      "detalhes": "AbrirLookup: 2 (ABRIRLOOKUPMOEDACODIGO, ABRIRLOOKUPMOEDADESCRICAO) | KeyPress handlers: 1 (KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCst.prg):
*==============================================================================
* FormCst.prg - Formulario de Cadastro de Constantes
* Migrado de: SigCdCst.SCX (frmcadastro)
* Tabela: SigCdCnt | Cursor grid: crSigCdCnt
*==============================================================================

DEFINE CLASS FormCst AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: valores EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Constantes"
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
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("CstBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar CstBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormCst.InicializarForm")
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
            MostrarErro("Erro ao inicializar FormCst:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormCst.InicializarForm")
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
    * ConfigurarPaginaLista - Configura Page1: Cabecalho, Botoes CRUD e Grid
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Container Cabecalho (cntSombra do legado)
            *-- Top=31: compensa PageFrame.Top=-29
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 31
                .Left        = -1
                .Width       = THIS.Width + 8
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Top       = 15
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 40
                    .Caption   = THIS.Caption
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
                    .Top       = 18
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 46
                    .Caption   = THIS.Caption
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(255, 255, 255)
                    .BackStyle = 0
                    .AutoSize  = .F.
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *-- Container Botoes CRUD (Grupo_op do legado)
            *-- Left=543 (do original), Top=29 (0+29 compensacao)
            loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPagina.cnt_4c_Botoes
                .Top       = 29
                .Left      =  542
                .Width     = 385
                .Height    = 85
                .BackStyle = 1
                .BackColor = RGB(53, 53, 53)
                .BorderWidth = 0
                .Visible   = .T.

                .AddObject("cmd_4c_Incluir", "CommandButton")
                WITH .cmd_4c_Incluir
                    .Caption         = "Incluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
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
                ENDWITH
            ENDWITH

            *-- Container Saida (padrao canonico: Left=917, Width=90)
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
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                ENDWITH
            ENDWITH

            *-- Grid de Lista (Grade do legado)
            *-- Top=150: original top=121 + compensacao PageFrame (+29)
            *-- ColumnCount setado FORA do WITH (regra critica #36)
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            loc_oPagina.grd_4c_Lista.ColumnCount = 4

            WITH loc_oPagina.grd_4c_Lista
                .Top                = 150
                .Left               = 12
                .Width              = 890
                .Height             = 460
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

            *-- BINDEVENT para botoes CRUD (metodos PUBLIC obrigatorios)
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar Page1:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormCst.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2: Botoes de Acao + campos Parte 1
    * FASE 5/8: cnt_4c_BotoesAcao (Salvar+Cancelar), Label1+txt_4c_Codigo,
    *           Label2+txt_4c_Descricao, Label3+txt_4c_Constante
    * Top += 29 em todos os controles (compensacao PageFrame.Top=-29)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Container Botoes de Acao (Grupo_Salva do legado)
            *-- Original: Left=820, Top=8 -> Migrado: Top=37 (8+29)
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .Top         = 37
                .Left        = 820
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Salvar", "CommandButton")
                WITH .cmd_4c_Salvar
                    .Caption         = "Salvar"
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
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
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
                ENDWITH
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

            *-- Label1 + txt_4c_Codigo (Get_Codigo do legado)
            *-- Original: Label1.Top=126, Get_Codigo.Top=122 -> Migrado: +29
            loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
            WITH loc_oPagina.lbl_4c_Codigo
                .Caption   = "C" + CHR(243) + "digo : "
                .Top       = 155
                .Left      = 281
                .Width     = 45
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
            WITH loc_oPagina.txt_4c_Codigo
                .Value         = ""
                .Top           = 151
                .Left          = 330
                .Width         = 34
                .Height        = 23
                .InputMask     = "!!!"
                .MaxLength     = 3
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .TabIndex      = 2
                .Visible       = .T.
            ENDWITH

            *-- Label2 + txt_4c_Descricao (Get_Descricao do legado)
            *-- Original: Label2.Top=152, Get_Descricao.Top=148 -> Migrado: +29
            loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
            WITH loc_oPagina.lbl_4c_Descricao
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
                .Top       = 181
                .Left      = 268
                .Width     = 58
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
            WITH loc_oPagina.txt_4c_Descricao
                .Value         = ""
                .Top           = 177
                .Left          = 330
                .Width         = 290
                .Height        = 23
                .MaxLength     = 40
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .TabIndex      = 4
                .Visible       = .T.
            ENDWITH

            *-- Label3 + txt_4c_Constante (Get_Constante do legado)
            *-- Original: Label3.Top=178, Get_Constante.Top=174 -> Migrado: +29
            loc_oPagina.AddObject("lbl_4c_Constante", "Label")
            WITH loc_oPagina.lbl_4c_Constante
                .Caption   = "Valor da Constante : "
                .Top       = 207
                .Left      = 222
                .Width     = 104
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Constante", "TextBox")
            WITH loc_oPagina.txt_4c_Constante
                .Value         = 0
                .Top           = 203
                .Left          = 330
                .Width         = 150
                .Height        = 23
                .InputMask     = "9,999,999.999999"
                .Alignment     = 3
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .TabIndex      = 6
                .Visible       = .T.
            ENDWITH

            *-- Label4 + txt_4c_CodMoeda (get_cd_moeda) + txt_4c_DescMoeda (get_ds_moeda)
            *-- Original: Label4.Top=204, get_cd_moeda.Top=200, get_ds_moeda.Top=200 -> Migrado: +29
            loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
            WITH loc_oPagina.lbl_4c_Moeda
                .Caption   = "Moeda : "
                .Top       = 233
                .Left      = 282
                .Width     = 44
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_CodMoeda", "TextBox")
            WITH loc_oPagina.txt_4c_CodMoeda
                .Value         = ""
                .Top           = 229
                .Left          = 330
                .Width         = 32
                .Height        = 23
                .InputMask     = "!!!"
                .MaxLength     = 3
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .TabIndex      = 8
                .Visible       = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_DescMoeda", "TextBox")
            WITH loc_oPagina.txt_4c_DescMoeda
                .Value         = ""
                .Top           = 229
                .Left          = 365
                .Width         = 115
                .Height        = 23
                .SpecialEffect = 1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .TabIndex      = 9
                .Visible       = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.txt_4c_CodMoeda,  "KeyPress", THIS, "CodMoedaLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_DescMoeda, "KeyPress", THIS, "DescMoedaLostFocus")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar Page2:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormCst.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no Grid da Page1
    * REGRA: RecordSource setado APOS Buscar(); Headers redefinidos apos RecordSource
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oErro, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    *-- RecordSource FORA do WITH (regra critica #36/#48)
                    loc_oGrid.RecordSource = "crSigCdCnt"

                    *-- ControlSource e Headers APOS RecordSource (regra #32)
                    WITH loc_oGrid
                        .Column1.ControlSource   = "crSigCdCnt.codigos"
                        .Column1.Width           = 60
                        .Column1.Header1.Caption = "C" + CHR(243) + "digo"
                        .Column1.Alignment       = 0

                        .Column2.ControlSource   = "crSigCdCnt.descricaos"
                        .Column2.Width           = 267
                        .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        .Column2.Alignment       = 0

                        .Column3.ControlSource   = "crSigCdCnt.consts"
                        .Column3.Width           = 177
                        .Column3.Header1.Caption = "Valor"
                        .Column3.Alignment       = 1

                        .Column4.ControlSource   = "crSigCdCnt.moedas"
                        .Column4.Width           = 42
                        .Column4.Header1.Caption = "Moeda"
                        .Column4.Alignment       = 0
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar lista:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormCst.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Se voltar para Page1, recarrega a lista automaticamente
    *===========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN loc_lResultado
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
        ENDIF

        loc_lResultado = .T.

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("crSigCdCnt")
                USE IN crSigCdCnt
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao destruir FormCst:" + CHR(13) + ;
                loc_oErro.Message, ;
                "FormCst.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Deve iterar Pages E Controls para PageFrames
    * SEMPRE chamar COM parametro: THIS.TornarControlesVisiveis(loc_oPagina)
    *===========================================================================
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

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    * SEMPRE chamar APOS carregar dados: THIS.FormatarGridLista(loc_oGrid)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos campos do Form para o BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
        THIS.this_oBusinessObject.this_nConstante = loc_oPagina.txt_4c_Constante.Value
        THIS.this_oBusinessObject.this_cMoeda     = ALLTRIM(loc_oPagina.txt_4c_CodMoeda.Value)
        THIS.this_oBusinessObject.this_cDescMoeda = ALLTRIM(loc_oPagina.txt_4c_DescMoeda.Value)
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do BO para os campos do Form
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        loc_oPagina.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
        loc_oPagina.txt_4c_Constante.Value = THIS.this_oBusinessObject.this_nConstante
        loc_oPagina.txt_4c_CodMoeda.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cMoeda)
        loc_oPagina.txt_4c_DescMoeda.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescMoeda)
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value    = ""
        loc_oPagina.txt_4c_Descricao.Value = ""
        loc_oPagina.txt_4c_Constante.Value = 0
        loc_oPagina.txt_4c_CodMoeda.Value  = ""
        loc_oPagina.txt_4c_DescMoeda.Value = ""
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme modo atual
    * Codigo: habilitado SOMENTE no INCLUIR (PK nao editavel em UPDATE)
    * DescMoeda: habilitada apenas quando CodMoeda esta vazio (busca por descricao)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lCodEnabled
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_lCodEnabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")

        loc_oPagina.txt_4c_Codigo.Enabled    = loc_lCodEnabled
        loc_oPagina.txt_4c_Descricao.Enabled = par_lHabilitar
        loc_oPagina.txt_4c_Constante.Enabled = par_lHabilitar
        loc_oPagina.txt_4c_CodMoeda.Enabled  = par_lHabilitar
        loc_oPagina.txt_4c_DescMoeda.Enabled = par_lHabilitar AND ;
            EMPTY(ALLTRIM(loc_oPagina.txt_4c_CodMoeda.Value))
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes de acao conforme modo
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        DO CASE
        CASE THIS.this_cModoAtual = "VISUALIZAR"
            loc_oCnt.cmd_4c_Salvar.Enabled   = .F.
            loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
        OTHERWISE
            loc_oCnt.cmd_4c_Salvar.Enabled   = .T.
            loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
        ENDCASE
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara formulario para inclusao de nova constante
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre registro selecionado em modo somente-leitura
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo

        IF !USED("crSigCdCnt") OR EOF("crSigCdCnt")
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        SELECT crSigCdCnt
        loc_cCodigo = ALLTRIM(crSigCdCnt.codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre registro selecionado para edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo

        IF !USED("crSigCdCnt") OR EOF("crSigCdCnt")
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        SELECT crSigCdCnt
        loc_cCodigo = ALLTRIM(crSigCdCnt.codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o registro selecionado apos confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma, loc_lExcluido

        IF !USED("crSigCdCnt") OR EOF("crSigCdCnt")
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        SELECT crSigCdCnt
        loc_cCodigo = ALLTRIM(crSigCdCnt.codigos)

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Deseja excluir a constante [" + loc_cCodigo + ;
            "] - " + ALLTRIM(THIS.this_oBusinessObject.this_cDescricao) + "?", ;
            "Confirmar Exclus" + CHR(227) + "o")

        IF loc_lConfirma
            loc_lExcluido = THIS.this_oBusinessObject.Excluir()
            IF loc_lExcluido
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Filtra lista de constantes por codigo ou descricao
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cBusca, loc_cFiltro, loc_oGrid, loc_lResultado

        loc_cBusca = ALLTRIM(INPUTBOX("Pesquisar por c" + CHR(243) + ;
            "digo ou descri" + CHR(231) + CHR(227) + "o:", ;
            "Buscar Constantes", ""))

        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

        IF EMPTY(loc_cBusca)
            loc_lResultado = THIS.this_oBusinessObject.Buscar("")
        ELSE
            loc_cFiltro = "a.codigos LIKE " + EscaparSQL("%" + loc_cBusca + "%")
            loc_lResultado = THIS.this_oBusinessObject.Buscar(loc_cFiltro)
        ENDIF

        IF loc_lResultado
            loc_oGrid.RecordSource = "crSigCdCnt"
            WITH loc_oGrid
                .Column1.ControlSource   = "crSigCdCnt.codigos"
                .Column1.Width           = 60
                .Column1.Header1.Caption = "C" + CHR(243) + "digo"
                .Column2.ControlSource   = "crSigCdCnt.descricaos"
                .Column2.Width           = 267
                .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                .Column3.ControlSource   = "crSigCdCnt.consts"
                .Column3.Width           = 177
                .Column3.Header1.Caption = "Valor"
                .Column4.ControlSource   = "crSigCdCnt.moedas"
                .Column4.Width           = 42
                .Column4.Header1.Caption = "Moeda"
            ENDWITH
            THIS.FormatarGridLista(loc_oGrid)
            loc_oGrid.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Salva os dados (Inserir ou Atualizar)
    * Validacoes obrigatorias FORA do TRY (regra critica #16)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSalvo

        IF THIS.this_cModoAtual = "INCLUIR" AND ;
                EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value))
            MsgAviso("C" + CHR(243) + "digo " + CHR(233) + " obrigat" + CHR(243) + "rio!")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CodMoeda.Value))
            MsgAviso("Moeda " + CHR(233) + " obrigat" + CHR(243) + "ria!")
            THIS.pgf_4c_Paginas.Page2.txt_4c_CodMoeda.SetFocus
            RETURN
        ENDIF

        THIS.FormParaBO()

        loc_lSalvo = THIS.this_oBusinessObject.Salvar()

        IF loc_lSalvo
            MsgInfo("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para a lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * CodMoedaLostFocus - Handler LostFocus de txt_4c_CodMoeda
    * Busca descricao da moeda pelo codigo digitado
    *===========================================================================
    PROCEDURE CodMoedaLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cCodigo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CodMoeda.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPagina.txt_4c_DescMoeda.Value   = ""
            loc_oPagina.txt_4c_DescMoeda.Enabled = .T.
            RETURN
        ENDIF

        THIS.AbrirLookupMoedaCodigo(loc_cCodigo)
    ENDPROC

    *===========================================================================
    * DescMoedaLostFocus - Handler LostFocus de txt_4c_DescMoeda
    * Busca moeda pela descricao digitada
    *===========================================================================
    PROCEDURE DescMoedaLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cDescricao
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c_DescMoeda.Value)

        IF EMPTY(loc_cDescricao)
            RETURN
        ENDIF

        THIS.AbrirLookupMoedaDescricao(loc_cDescricao)
    ENDPROC

    *===========================================================================
    * AbrirLookupMoedaCodigo - Picker de Moeda por codigo (cmoes)
    * Tabela: SigCdMoe | Pesquisa: cmoes | Preenche: CodMoeda + DescMoeda
    *===========================================================================
    PROCEDURE AbrirLookupMoedaCodigo(par_cValor)
        LOCAL loc_oBusca, loc_oPagina, loc_lResultado, loc_oErro
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_lResultado = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", ;
                "cursor_4c_BuscaMoe", ;
                "cmoes", ;
                par_cValor, ;
                "Buscar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "", "Moeda")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    loc_oPagina.txt_4c_CodMoeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
                    loc_oPagina.txt_4c_DescMoeda.Value   = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
                    loc_oPagina.txt_4c_DescMoeda.Enabled = .F.
                    loc_lResultado = .T.
                ELSE
                    loc_oPagina.txt_4c_CodMoeda.Value    = ""
                    loc_oPagina.txt_4c_DescMoeda.Value   = ""
                    loc_oPagina.txt_4c_DescMoeda.Enabled = .T.
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar moeda:" + CHR(13) + ;
                loc_oErro.Message, "FormCst.AbrirLookupMoedaCodigo")
        ENDTRY

        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AbrirLookupMoedaDescricao - Picker de Moeda por descricao (dmoes)
    * Tabela: SigCdMoe | Pesquisa: dmoes | Preenche: CodMoeda + DescMoeda
    *===========================================================================
    PROCEDURE AbrirLookupMoedaDescricao(par_cValor)
        LOCAL loc_oBusca, loc_oPagina, loc_lResultado, loc_oErro
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_lResultado = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", ;
                "cursor_4c_BuscaMoeDesc", ;
                "dmoes", ;
                par_cValor, ;
                "Buscar Moeda por Descri" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cmoes", "", "Moeda")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeDesc")
                    SELECT cursor_4c_BuscaMoeDesc
                    loc_oPagina.txt_4c_CodMoeda.Value    = ALLTRIM(cursor_4c_BuscaMoeDesc.cmoes)
                    loc_oPagina.txt_4c_DescMoeda.Value   = ALLTRIM(cursor_4c_BuscaMoeDesc.dmoes)
                    loc_oPagina.txt_4c_DescMoeda.Enabled = .F.
                    loc_lResultado = .T.
                ELSE
                    loc_oPagina.txt_4c_CodMoeda.Value  = ""
                    loc_oPagina.txt_4c_DescMoeda.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar moeda por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message, "FormCst.AbrirLookupMoedaDescricao")
        ENDTRY

        IF USED("cursor_4c_BuscaMoeDesc")
            USE IN cursor_4c_BuscaMoeDesc
        ENDIF

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\CstBO.prg):
*==============================================================================
* CstBO.prg - Business Object para Constantes
* Tabela: SigCdCnt
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS CstBO AS BusinessBase

    *-- Propriedades da tabela SigCdCnt
    this_cCodigo    = ""    && Codigos     C(3)  - PK
    this_cDescricao = ""    && Descricaos  C(40)
    this_nConstante = 0     && Consts      N(13,6) - Valor da Constante
    this_cMoeda     = ""    && Moedas      C(3)  - FK SigCdMoe.Cmoes

    *-- Propriedade auxiliar de exibicao (nao persistida em SigCdCnt)
    this_cDescMoeda = ""    && SigCdMoe.Dmoes C(15) - Descricao da Moeda

    *--------------------------------------------------------------------------
    * Init - Inicializa BO configurando tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCnt"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "CstBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = TratarNulo(codigos,    "C")
                THIS.this_cDescricao = TratarNulo(descricaos, "C")
                THIS.this_nConstante = TratarNulo(consts,     "N")
                THIS.this_cMoeda     = TratarNulo(moedas,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CstBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo da Constante j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cMoeda)
            MsgAviso("Moeda n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoExistente - Verifica se codigos ja existe no banco
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nTotal FROM SigCdCnt" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")

            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (NVL(cursor_4c_ChkCod.nTotal, 0) > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CstBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCnt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCnt (codigos, descricaos, consts, moedas)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<FormatarNumeroSQL(THIS.this_nConstante, 6)>>,
                    <<EscaparSQL(THIS.this_cMoeda)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CstBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCnt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCnt
                SET descricaos = <<EscaparSQL(THIS.this_cDescricao)>>,
                    consts     = <<FormatarNumeroSQL(THIS.this_nConstante, 6)>>,
                    moedas     = <<EscaparSQL(THIS.this_cMoeda)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CstBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCnt
    * Valida uso em SigOpTdt (6 campos de constante) antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            *-- Verificar se constante esta sendo usada em operacoes (SigOpTdt)
            loc_cSQL = "SELECT COUNT(*) AS nTotal FROM SigOpTdt" + ;
                " WHERE (const1t1s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const1t2s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const2t1s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const2t2s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const3t1s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const3t2s = " + EscaparSQL(THIS.this_cCodigo) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCnt")

            IF loc_nResultado < 0
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ChkCnt")
                    SELECT cursor_4c_ChkCnt
                    loc_nUso = NVL(cursor_4c_ChkCnt.nTotal, 0)
                    USE IN cursor_4c_ChkCnt
                ENDIF

                IF loc_nUso > 0
                    MsgAviso("Constante sendo utilizada em Opera" + CHR(231) + CHR(245) + "es!")
                ELSE
                    loc_cSQL = "DELETE FROM SigCdCnt WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CstBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor crSigCdCnt com codigos, descricaos, consts, moedas
    * (cursor nomeado igual ao legado para compatibilidade com grid)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("crSigCdCnt")
                    SET NULL ON
                    CREATE CURSOR crSigCdCnt (codigos C(3), descricaos C(40), consts N(13,6), moedas C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.codigos, a.descricaos, a.consts, a.moedas" + ;
                    " FROM SigCdCnt a"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.codigos"

                IF USED("crSigCdCnt")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT crSigCdCnt
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar constantes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCnt")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar constantes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CstBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    * Tambem carrega descricao da moeda via JOIN com SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.codigos, a.descricaos, a.consts, a.moedas," + ;
                " b.dmoes AS descmoes" + ;
                " FROM SigCdCnt a" + ;
                " LEFT JOIN SigCdMoe b ON b.cmoes = a.moedas" + ;
                " WHERE a.codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    SELECT cursor_4c_Carrega
                    THIS.this_cCodigo    = TratarNulo(codigos,    "C")
                    THIS.this_cDescricao = TratarNulo(descricaos, "C")
                    THIS.this_nConstante = TratarNulo(consts,     "N")
                    THIS.this_cMoeda     = TratarNulo(moedas,     "C")
                    THIS.this_cDescMoeda = TratarNulo(descmoes,   "C")
                    THIS.this_lNovoRegistro = .F.
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Constante n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CstBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescMoeda - Carrega descricao da moeda pelo codigo
    * Usado apos lookup de moeda para atualizar campo de exibicao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescMoeda(par_cCodigoMoeda)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cCodigoMoeda)
                THIS.this_cDescMoeda = ""
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.dmoes FROM SigCdMoe a" + ;
                    " WHERE a.cmoes = " + EscaparSQL(par_cCodigoMoeda)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moe")

                IF loc_nResultado >= 0
                    IF RECCOUNT("cursor_4c_Moe") > 0
                        SELECT cursor_4c_Moe
                        THIS.this_cDescMoeda = TratarNulo(dmoes, "C")
                    ELSE
                        THIS.this_cDescMoeda = ""
                    ENDIF

                    IF USED("cursor_4c_Moe")
                        USE IN cursor_4c_Moe
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao carregar moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o da moeda:" + CHR(13) + loException.Message, "CstBO.CarregarDescMoeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

