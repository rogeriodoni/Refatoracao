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
[2026-07-31 21:19:01] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-31 21:19:01] [INFO] Config FPW: (nao fornecido)
[2026-07-31 21:19:01] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-31 21:19:01] [INFO] Timeout: 300 segundos
[2026-07-31 21:19:01] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s4byh11n.prg
[2026-07-31 21:19:01] [INFO] Conteudo do wrapper:
[2026-07-31 21:19:01] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCtg', 'C:\4c\tasks\task389', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCtg', 'C:\4c\tasks\task389', 'CRUD'
QUIT

[2026-07-31 21:19:01] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s4byh11n.prg
[2026-07-31 21:19:01] [INFO] VFP output esperado em: C:\4c\tasks\task389\vfp_output.txt
[2026-07-31 21:19:01] [INFO] Executando Visual FoxPro 9...
[2026-07-31 21:19:01] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s4byh11n.prg
[2026-07-31 21:19:01] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s4byh11n.prg
[2026-07-31 21:19:01] [INFO] Timeout configurado: 300 segundos
[2026-07-31 21:19:46] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-31 21:19:46] [INFO] VFP9 finalizado em 44.7054026 segundos
[2026-07-31 21:19:46] [INFO] Exit Code: 
[2026-07-31 21:19:46] [INFO] 
[2026-07-31 21:19:46] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-31 21:19:46] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s4byh11n.prg
[2026-07-31 21:19:46] [INFO] 
[2026-07-31 21:19:46] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-31 21:19:46] [INFO] * Auto-generated wrapper for parameters
[2026-07-31 21:19:46] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-31 21:19:46] [INFO] * Parameters: 'FormCtg', 'C:\4c\tasks\task389', 'CRUD'
[2026-07-31 21:19:46] [INFO] 
[2026-07-31 21:19:46] [INFO] * Anti-dialog protections for unattended execution
[2026-07-31 21:19:46] [INFO] SET SAFETY OFF
[2026-07-31 21:19:46] [INFO] SET RESOURCE OFF
[2026-07-31 21:19:46] [INFO] SET TALK OFF
[2026-07-31 21:19:46] [INFO] SET NOTIFY OFF
[2026-07-31 21:19:46] [INFO] SYS(2335, 0)
[2026-07-31 21:19:46] [INFO] 
[2026-07-31 21:19:46] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCtg', 'C:\4c\tasks\task389', 'CRUD'
[2026-07-31 21:19:46] [INFO] QUIT
[2026-07-31 21:19:46] [INFO] 
[2026-07-31 21:19:46] [INFO] === Fim do Wrapper.prg ===
[2026-07-31 21:19:46] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormCtg",
  "timestamp": "20260731211946",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCtg.prg):
*==============================================================================
* FormCtg.prg - Formulario de Cadastro de Categorias
* Migrado de: SigCdCtg.SCX (frmcadastro)
* FASE 7/8: Eventos principais (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick)
*==============================================================================

DEFINE CLASS FormCtg AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Categorias"
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
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar!
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
            THIS.this_oBusinessObject = CREATEOBJECT("CtgBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar CtgBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormCtg.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormCtg:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormCtg.InicializarForm")
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
    * ConfigurarPaginaLista - Configura Page1 com containers base
    * Fase 3: cnt_4c_Cabecalho (completo), cnt_4c_Botoes e cnt_4c_Saida (vazios)
    * Fase 4 adiciona: grd_4c_Lista + botoes CRUD no cnt_4c_Botoes/cnt_4c_Saida
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho cinza (cntSombra no legado)
        *-- Original: Top=1. Com compensacao PageFrame.Top=-29: Top = 1+29 = 30 => usar 31 (padrao)
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

        *-- Container Botoes CRUD - Canonico Left=542, Top=29
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
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

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
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

        *-- Botao Encerrar (padrao canonico)
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

        *-- Grid de listagem (Grade no legado: colunas Cods=80px, Descs=150px)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 12
            .Width              = 890
            .Height             = 488
            .ColumnCount        = 2
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

        *-- BINDEVENTs dos botoes da Page1
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2: botoes + campos da Page2
    * Grupo_Salva original: Left=817, Top=11 -> com +29: Top=40
    * Say1 (Codigo): Top=141, Left=335 -> com +29: Top=170
    * getCods: Top=137, Left=382, Width=60 -> com +29: Top=166
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container BotoesAcao - Grupo_Salva no legado (Left=817, Top=11+29=40)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 40
            .Left        = 817
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva no legado: Left=5, Top=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
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

        *-- Botao Cancelar (Cancelar no legado: Left=80, Top=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
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

        *-- Label Codigo (Say1 no legado: Top=141, Left=335, ForeColor=90,90,90)
        *-- Com compensacao +29: Top=170
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 170
            .Left      = 335
            .Width     = 55
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

        *-- TextBox Codigo (getCods no legado: Top=137, Left=382, Width=60, Height=24)
        *-- Com compensacao +29: Top=166
        *-- Format="K!" = uppercase; campo Cods char(3)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 166
            .Left          = 382
            .Width         = 60
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .InputMask     = "!!!"
            .MaxLength     = 3
            .Visible       = .T.
        ENDWITH

        *-- Label Descricao (Say2 no legado: Top=167, Left=322, ForeColor=90,90,90)
        *-- Com compensacao +29: Top=196
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 196
            .Left      = 322
            .Width     = 60
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

        *-- TextBox Descricao (getDescs no legado: Top=163, Left=382, Width=300, Height=24)
        *-- Com compensacao +29: Top=192; Format="K!" = uppercase
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Top           = 192
            .Left          = 382
            .Width         = 300
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .MaxLength     = 50
            .Visible       = .T.
        ENDWITH

        *-- BINDEVENTs dos botoes da Page2
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no cursor via BO e configura grid
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lSucesso = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"

                loc_oGrid.Column1.Width = 80
                loc_oGrid.Column2.Width = 380

                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                THIS.FormatarGridLista(loc_oGrid)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista de categorias:" + CHR(13) + ;
                loException.Message, "FormCtg.CarregarLista")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
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
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
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
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                loException.Message, "FormCtg.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara form para incluir novo registro
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega registro selecionado para visualizacao
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para visualizar.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
            THIS.AjustarBotoesPorModo()
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para alterar.", "Alterar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.AjustarBotoesPorModo()
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Alterar")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para excluir.", "Excluir")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da categoria " + ;
            ALLTRIM(loc_cCodigo) + "?", "Excluir")

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Categoria exclu" + CHR(237) + "da com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre busca de categorias via FormBuscaAuxiliar
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCtg", "cursor_4c_BuscaCtg", "cods", loc_cCodigo, ;
                "Buscar Categoria")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCtg")
                    SELECT cursor_4c_BuscaCtg
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaCtg.cods)
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(cods) == loc_cCodigo
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormCtg.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaCtg")
            USE IN cursor_4c_BuscaCtg
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida e salva o registro (Confirmar)
    * Logica do legado: Grupo_Salva.Salva.Click
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cCodigo, loc_cDescricao, loc_nResult
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        *-- Validar Codigo (obrigatorio)
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
                loc_oPagina.txt_4c_Codigo.SetFocus()
            ENDIF
            RETURN
        ENDIF

        *-- Validar Descricao (obrigatorio)
        loc_cDescricao = ""
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
            loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
        ENDIF

        IF EMPTY(loc_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
                loc_oPagina.txt_4c_Descricao.SetFocus()
            ENDIF
            RETURN
        ENDIF

        *-- INCLUIR: verificar se codigo ja existe (logica do legado)
        IF THIS.this_cModoAtual = "INCLUIR"
            TRY
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Cods FROM SigCdCtg WHERE Cods = " + EscaparSQL(loc_cCodigo), ;
                    "cursor_4c_CtgDupChk")
                IF loc_nResult > 0 AND USED("cursor_4c_CtgDupChk")
                    IF RECCOUNT("cursor_4c_CtgDupChk") > 0
                        MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!!!", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        IF USED("cursor_4c_CtgDupChk")
                            USE IN cursor_4c_CtgDupChk
                        ENDIF
                        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
                            loc_oPagina.txt_4c_Codigo.SetFocus()
                        ENDIF
                        RETURN
                    ENDIF
                ENDIF
                IF USED("cursor_4c_CtgDupChk")
                    USE IN cursor_4c_CtgDupChk
                ENDIF
            CATCH TO loException
                MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, ;
                    "FormCtg.BtnSalvarClick")
                IF USED("cursor_4c_CtgDupChk")
                    USE IN cursor_4c_CtgDupChk
                ENDIF
                RETURN
            ENDTRY
        ENDIF

        THIS.FormParaBO()

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Categoria salva com sucesso!", "Sucesso")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar categoria:" + CHR(13) + loException.Message, ;
                "FormCtg.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela e volta para lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao na Page2
    * getCods.When = INSERIR only -> txt_4c_Codigo so editavel em INCLUIR
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Codigo: apenas editavel em INCLUIR (legado: When = InList(pcEscolha, INSERIR, PROCURAR))
        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.Enabled = par_lHabilitar AND ;
                (THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        *-- Descricao: editavel em INCLUIR e ALTERAR
        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
            loc_oPagina.txt_4c_Descricao.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa valores dos campos de edicao na Page2
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
            loc_oPagina.txt_4c_Descricao.Value = ""
        ENDIF
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do BO para os campos do Form
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
            loc_oPagina.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
        ENDIF
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere dados dos campos do Form para o BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
            THIS.this_oBusinessObject.this_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
            THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
    * Legado: INSERIR/PROCURAR->foco em getCods, ALTERAR->foco em getDescs,
    *         VISUALIZAR->Confirmar disabled + foco em Cancelar
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEmEdicao
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_lEmEdicao  = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        *-- Habilitar/desabilitar Confirmar conforme modo
        IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEmEdicao
            ENDIF
        ENDIF

        *-- SetFocus conforme modo (replica logica legado: Click do Grupo_Op)
        DO CASE
            CASE THIS.this_cModoAtual = "INCLUIR"
                IF PEMSTATUS(loc_oPagina, "txt_4c_Codigo", 5)
                    IF loc_oPagina.txt_4c_Codigo.Enabled
                        loc_oPagina.txt_4c_Codigo.SetFocus()
                    ENDIF
                ENDIF

            CASE THIS.this_cModoAtual = "ALTERAR"
                IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
                    IF loc_oPagina.txt_4c_Descricao.Enabled
                        loc_oPagina.txt_4c_Descricao.SetFocus()
                    ENDIF
                ENDIF

            OTHERWISE
                IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
                    IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
                    ENDIF
                ENDIF
        ENDCASE
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_BuscaCtg")
            USE IN cursor_4c_BuscaCtg
        ENDIF

        IF USED("cursor_4c_CtgDupChk")
            USE IN cursor_4c_CtgDupChk
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\CtgBO.prg):
*====================================================================
* CtgBO.prg
*
* Business Object para Categorias
* Tabela principal: SigCdCtg (cods PK, descs descricao)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CtgBO AS BusinessBase

	*-- Propriedades da entidade (SigCdCtg)
	this_cCods      = ""   && cods char(6)       - codigo da categoria (PK)
	this_cDescs     = ""   && descs char(40)     - descricao da categoria

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdCtg"
		THIS.this_cCampoChave = "cods"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCods)
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
				THIS.this_cCods      = TratarNulo(cods,      "C")
				THIS.this_cDescs     = TratarNulo(descs,     "C")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CtgBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		LOCAL loc_lValido
		loc_lValido = .T.

		IF EMPTY(ALLTRIM(THIS.this_cCods))
			MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_lNovoRegistro
			IF THIS.VerificarCodigoExistente(THIS.this_cCods)
				MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
				loc_lValido = .F.
			ENDIF
		ENDIF

		IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescs))
			MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!")
			loc_lValido = .F.
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* VerificarCodigoExistente - Verifica se cods ja existe na tabela
	*====================================================================
	PROCEDURE VerificarCodigoExistente(par_cCods)
		LOCAL loc_cSQL, loc_nResultado, loc_lExiste
		loc_lExiste = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCtg" + ;
				" WHERE cods = " + EscaparSQL(par_cCods)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
			IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
				SELECT cursor_4c_ChkCod
				loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
				USE IN cursor_4c_ChkCod
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CtgBO.VerificarCodigoExistente")
		ENDTRY

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdCtg
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigCdCtg (cods, descs)
				VALUES (
					<<EscaparSQL(THIS.this_cCods)>>,
					<<EscaparSQL(THIS.this_cDescs)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CtgBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdCtg
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdCtg
				SET descs = <<EscaparSQL(THIS.this_cDescs)>>
				WHERE cods = <<EscaparSQL(THIS.this_cCods)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CtgBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro da tabela SigCdCtg
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdCtg WHERE cods = " + EscaparSQL(THIS.this_cCods)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao excluir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CtgBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados com cods, descs
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (cods C(6), descs C(40))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT cods, descs FROM SigCdCtg"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY cods"

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
						GO TOP IN cursor_4c_Dados
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao buscar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ELSE
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
					IF loc_nResultado >= 0
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao buscar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CtgBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo codigo de negocio (cods)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCods)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cods, descs FROM SigCdCtg" + ;
				" WHERE cods = " + EscaparSQL(par_cCods)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Categoria n" + CHR(227) + "o encontrada!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CtgBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

