# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnIncluirNavegacao': Function argument value, type, or count is invalid. | Detalhes: Linha: 1577, Proc: habilitarcampos

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-09-19 00:05:25] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-19 00:05:25] [INFO] Config FPW: (nao fornecido)
[2026-09-19 00:05:25] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-19 00:05:25] [INFO] Timeout: 300 segundos
[2026-09-19 00:05:25] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hjyvc1j5.prg
[2026-09-19 00:05:25] [INFO] Conteudo do wrapper:
[2026-09-19 00:05:25] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormUfs', 'C:\4c\tasks\task551', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormUfs', 'C:\4c\tasks\task551', 'CRUD'
QUIT

[2026-09-19 00:05:25] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hjyvc1j5.prg
[2026-09-19 00:05:25] [INFO] VFP output esperado em: C:\4c\tasks\task551\vfp_output.txt
[2026-09-19 00:05:25] [INFO] Executando Visual FoxPro 9...
[2026-09-19 00:05:25] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hjyvc1j5.prg
[2026-09-19 00:05:25] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hjyvc1j5.prg
[2026-09-19 00:05:25] [INFO] Timeout configurado: 300 segundos
[2026-09-19 00:07:20] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-19 00:07:20] [INFO] VFP9 finalizado em 114.6605291 segundos
[2026-09-19 00:07:20] [INFO] Exit Code: 
[2026-09-19 00:07:20] [INFO] 
[2026-09-19 00:07:20] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-19 00:07:20] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hjyvc1j5.prg
[2026-09-19 00:07:20] [INFO] 
[2026-09-19 00:07:20] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-19 00:07:20] [INFO] * Auto-generated wrapper for parameters
[2026-09-19 00:07:20] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-19 00:07:20] [INFO] * Parameters: 'FormUfs', 'C:\4c\tasks\task551', 'CRUD'
[2026-09-19 00:07:20] [INFO] 
[2026-09-19 00:07:20] [INFO] * Anti-dialog protections for unattended execution
[2026-09-19 00:07:20] [INFO] SET SAFETY OFF
[2026-09-19 00:07:20] [INFO] SET RESOURCE OFF
[2026-09-19 00:07:20] [INFO] SET TALK OFF
[2026-09-19 00:07:20] [INFO] SET NOTIFY OFF
[2026-09-19 00:07:20] [INFO] SYS(2335, 0)
[2026-09-19 00:07:20] [INFO] 
[2026-09-19 00:07:20] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormUfs', 'C:\4c\tasks\task551', 'CRUD'
[2026-09-19 00:07:20] [INFO] QUIT
[2026-09-19 00:07:20] [INFO] 
[2026-09-19 00:07:20] [INFO] === Fim do Wrapper.prg ===
[2026-09-19 00:07:20] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormUfs",
  "timestamp": "20260919000720",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": true,
      "erro": "",
      "detalhes": "0 registros em cursor_4c_Dados"
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
      "passou": false,
      "erro": "Function argument value, type, or count is invalid.",
      "detalhes": "Linha: 1577, Proc: habilitarcampos"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormUfs.prg):
*==============================================================================
* FormUfs.prg - Formulario de Cadastro de Estados
* Migrado de: SigCdUfd.SCX (frmcadastro) - Tabela SigCdUfs
*==============================================================================

DEFINE CLASS FormUfs AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Estados"
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
            THIS.this_oBusinessObject = CREATEOBJECT("UfsBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar UfsBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormUfs.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF PEMSTATUS(THIS, "CarregarLista", 5)
                        THIS.CarregarLista()
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormUfs:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormUfs.InicializarForm")
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
    * ConfigurarPaginaLista - Estrutura base de Page1 (Lista)
    * Cabecalho (faixa cinza - CLAUDE.md regra #11) + container de botoes CRUD
    * vazio (botoes e grid entram na Fase 4)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
        *-- Original: Top=1. Com compensacao +29: Top=31
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

        *-- Container Botoes CRUD (Grupo_op no legado: Left=538, Top=0, Width=389, Height=85)
        *-- Canonico: Left=542, Top=29 (0+29 compensacao), Width=390, Height=85
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

        *-- Botao Incluir (legado: Inserir.Left=5)
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

        *-- Botao Visualizar (legado: Consultar.Left=81)
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

        *-- Botao Alterar (legado: Alterar.Left=157)
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

        *-- Botao Excluir (legado: Excluir.Left=233)
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

        *-- Botao Buscar (legado: Procurar.Left=309)
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

        *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, CLAUDE.md regra #10)
        *-- Legado: Grupo_Saida.Left=918, Top=0. Canonico: Left=917, Top=29, Width=90
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

        *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
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

        *-- Grid de listagem de estados
        *-- Legado (PROCEDURE Init): Estados/UF(40), descrs/Nome(250), aicms/Ali(237)q. ICMS(80),
        *-- bicms/B.ICMS Redu(80), areduzidas/Ali(237)q. Redu(80), AliqSbs/Aliq.Sub.Trib(80)
        *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 6
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 880
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
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no grid da Page1
    * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
    * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
    *===========================================================================
    PROCEDURE CarregarLista(par_cFiltro)
        LOCAL loc_lResultado, loc_oGrid, loc_cFiltro
        loc_lResultado = .F.
        loc_cFiltro = IIF(VARTYPE(par_cFiltro) = "C", par_cFiltro, "")

        TRY
            IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
                loc_oGrid.ColumnCount = 6
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.estados"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.aicms"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.bicms"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.areduzidas"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.aliqsbs"

                loc_oGrid.Column1.Width = 40
                loc_oGrid.Column2.Width = 250
                loc_oGrid.Column3.Width = 80
                loc_oGrid.Column4.Width = 80
                loc_oGrid.Column5.Width = 80
                loc_oGrid.Column6.Width = 80

                *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
                loc_oGrid.Column1.Header1.Caption = "UF"
                loc_oGrid.Column2.Header1.Caption = "Nome"
                loc_oGrid.Column3.Header1.Caption = "Al" + CHR(237) + "q. ICMS"
                loc_oGrid.Column4.Header1.Caption = "B.ICMS Redu"
                loc_oGrid.Column5.Header1.Caption = "Al" + CHR(237) + "q. Redu"
                loc_oGrid.Column6.Header1.Caption = "Aliq.Sub.Trib"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormUfs.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
                "FormUfs.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega a lista
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
                "FormUfs.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
    * Cabecalho (faixa cinza nas DUAS paginas - CLAUDE.md regra #11) + container
    * de botoes de acao vazio (Confirmar/Cancelar e campos entram nas Fases 4-6)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista) - PRIMEIRO AddObject da pagina
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
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

        *-- Container BotoesAcao (Grupo_Salva legado: Left=819, Top=9, Width=160, Height=85)
        *-- Com compensacao PageFrame +29: Top=33 (4+29), Left=842
        *-- Botoes internos (Confirmar/Cancelar) entram na Fase 4
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Shape2 (linha divisoria acima dos checkboxes fiscais) - legado Top=228
        loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPagina.shp_4c_Shape2
            .Top           = 257
            .Left          = 9
            .Width         = 980
            .Height        = 1
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say1 "U.F. :" (legado Top=116/Left=256) + getEstado (legado Top=111/Left=289, PK)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "U.F. : "
            .Top       = 145
            .Left      = 256
            .Width     = 33
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Estado", "TextBox")
        WITH loc_oPagina.txt_4c_Estado
            .Value         = ""
            .Top           = 140
            .Left          = 289
            .Width         = 24
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "A"
            .InputMask     = "!!"
            .MaxLength     = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Get_Descr (legado Top=111/Left=315) - sem label dedicado no legado
        loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPagina.txt_4c_Descr
            .Value         = ""
            .Top           = 140
            .Left          = 315
            .Width         = 276
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = ""
            .MaxLength     = 40
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say2 "Aliquota de ICMS :" (legado Top=143/Left=195) + getAicms (legado Top=138/Left=289)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Al" + CHR(237) + "quota de ICMS : "
            .Top       = 172
            .Left      = 195
            .Width     = 94
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Aicms", "TextBox")
        WITH loc_oPagina.txt_4c_Aicms
            .Value         = 0
            .Top           = 167
            .Left          = 289
            .Width         = 45
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99.99"
            .MaxLength     = 5
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say3 "Base de ICMS Reduzida :" (legado Top=143/Left=354) + getBicms (legado Top=138/Left=489)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Base de ICMS Reduzida : "
            .Top       = 172
            .Left      = 354
            .Width     = 125
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Bicms", "TextBox")
        WITH loc_oPagina.txt_4c_Bicms
            .Value         = 0
            .Top           = 167
            .Left          = 489
            .Width         = 45
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99.99"
            .MaxLength     = 5
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say4 "Aliquota Reduzida :" (legado Top=170/Left=381) + getAreduzida (legado Top=165/Left=489)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Al" + CHR(237) + "quota Reduzida : "
            .Top       = 199
            .Left      = 381
            .Width     = 98
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Areduzida", "TextBox")
        WITH loc_oPagina.txt_4c_Areduzida
            .Value         = 0
            .Top           = 194
            .Left          = 489
            .Width         = 45
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99.99"
            .MaxLength     = 5
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say7 "Aliquota Local SubstituicaoTributaria :" (legado Top=170/Left=104, sem espaco entre
        *-- "cao" e "Tributaria" - typo original preservado) + Get_AliqSB (legado Top=165/Left=289)
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Al" + CHR(237) + "quota Local Substitui" + CHR(231) + CHR(227) + "oTribut" + CHR(225) + "ria : "
            .Top       = 199
            .Left      = 104
            .Width     = 185
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_AliqSB", "TextBox")
        WITH loc_oPagina.txt_4c_AliqSB
            .Value         = 0
            .Top           = 194
            .Left          = 289
            .Width         = 45
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99.99"
            .MaxLength     = 5
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say6 "IPI :" (legado Top=143/Left=643) + cmbIpi (legado Top=138/Left=675)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "IPI : "
            .Top       = 172
            .Left      = 643
            .Width     = 26
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- cmbIpi - itens replicados do legado (Pagina.Dados.Activate: Tributado/Isento/Outros)
        loc_oPagina.AddObject("cbo_4c_CmbIpi", "ComboBox")
        WITH loc_oPagina.cbo_4c_CmbIpi
            .Top           = 167
            .Left          = 675
            .Width         = 91
            .Height        = 25
            .FontName      = "Verdana"
            .FontSize      = 8
            .Style         = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        loc_oPagina.cbo_4c_CmbIpi.AddItem("\<" + PADR("Tributado", 9))
        loc_oPagina.cbo_4c_CmbIpi.AddItem("\<" + PADR("Isento", 9))
        loc_oPagina.cbo_4c_CmbIpi.AddItem("\<" + PADR("Outros", 9))
        loc_oPagina.cbo_4c_CmbIpi.Value = "\<" + PADR("Tributado", 9)

        *-- Say5 "Cod. IBGE :" (legado Top=116/Left=611) + getUFIBGES (legado Top=111/Left=675)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "C" + CHR(243) + "d. IBGE :"
            .Top       = 145
            .Left      = 611
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_UFIBGES", "TextBox")
        WITH loc_oPagina.txt_4c_UFIBGES
            .Value         = 0
            .Top           = 140
            .Left          = 675
            .Width         = 24
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99"
            .MaxLength     = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- fwcheckbox6 "CAT 52 :" (legado Top=169/Left=615, Alignment=1 legitimo: legenda a esquerda do box)
        loc_oPagina.AddObject("chk_4c_Fwcheckbox6", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox6
            .Caption   = "CAT 52 :"
            .Value     = 0
            .Top       = 198
            .Left      = 615
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Fwcheckbox9 "GNRE :" (legado Top=186/Left=625, Alignment=1 legitimo: legenda a esquerda do box)
        loc_oPagina.AddObject("chk_4c_Fwcheckbox9", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox9
            .Caption   = "GNRE :"
            .Value     = 0
            .Top       = 215
            .Left      = 625
            .Width     = 52
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say8 "LayOut NFCe :" (legado Top=197/Left=213) + layoutnf (legado Top=192/Left=289)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "LayOut NFCe : "
            .Top       = 226
            .Left      = 213
            .Width     = 76
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Layoutnf", "TextBox")
        WITH loc_oPagina.txt_4c_Layoutnf
            .Value         = ""
            .Top           = 221
            .Left          = 289
            .Width         = 89
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = ""
            .MaxLength     = 20
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- chkGer50 "Tipo 50 - Nota Fiscal (Modelos 1, 1A, 4, 6, 21, 22)" (legado Top=252/Left=21)
        loc_oPagina.AddObject("chk_4c_ChkGer50", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer50
            .Caption   = "Tipo 50 - Nota Fiscal (Modelos 1, 1A, 4, 6, 21, 22)"
            .Value     = 0
            .Top       = 281
            .Left      = 21
            .Width     = 258
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.chk_4c_ChkGer50, "Valid", THIS, "ValidarChkGer50")

        *-- chkGer51 "Tipo 51 - Nota Fiscal de IPI (Modelo 1 e 1A)" (legado Top=270/Left=21)
        loc_oPagina.AddObject("chk_4c_ChkGer51", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer51
            .Caption   = "Tipo 51 - Nota Fiscal de IPI (Modelo 1 e 1A)"
            .Value     = 0
            .Top       = 299
            .Left      = 21
            .Width     = 226
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- chkGer53 "Tipo 53 - Registro de Substituicao Tributaria" (legado Top=288/Left=21)
        loc_oPagina.AddObject("chk_4c_ChkGer53", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer53
            .Caption   = "Tipo 53 - Registro de Substitui" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria"
            .Value     = 0
            .Top       = 317
            .Left      = 21
            .Width     = 228
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- chkGer54 "Tipo 54 - Registro de Produtos das Notas Fiscais" (legado Top=305/Left=21)
        loc_oPagina.AddObject("chk_4c_ChkGer54", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer54
            .Caption   = "Tipo 54 - Registro de Produtos das Notas Fiscais"
            .Value     = 0
            .Top       = 334
            .Left      = 21
            .Width     = 249
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- chkGer60 "Tipo 60 - Notas Emitidas Por EFC / PDV" (legado Top=322/Left=21)
        loc_oPagina.AddObject("chk_4c_ChkGer60", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer60
            .Caption   = "Tipo 60 - Notas Emitidas Por EFC / PDV"
            .Value     = 0
            .Top       = 351
            .Left      = 21
            .Width     = 203
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.chk_4c_ChkGer60, "Valid", THIS, "ValidarChkGer60")

        *-- chkGer60I "Tipo 60 - ( I ) Itens dos Cupons" (legado Top=340/Left=21)
        loc_oPagina.AddObject("chk_4c_ChkGer60I", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer60I
            .Caption   = "Tipo 60 - ( I ) " + CHR(205) + "tens dos Cupons"
            .Value     = 0
            .Top       = 369
            .Left      = 21
            .Width     = 168
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- chkGer75 "Tipo 75 - Produtos" (legado Top=252/Left=688)
        loc_oPagina.AddObject("chk_4c_ChkGer75", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer75
            .Caption   = "Tipo 75 - Produtos"
            .Value     = 0
            .Top       = 281
            .Left      = 688
            .Width     = 106
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- chkGer60D "Tipo 60 - (D) Resumo Diario dos Cupons" (legado Top=252/Left=354)
        loc_oPagina.AddObject("chk_4c_ChkGer60D", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer60D
            .Caption   = "Tipo 60 - (D) Resumo Di" + CHR(225) + "rio dos Cupons"
            .Value     = 0
            .Top       = 281
            .Left      = 354
            .Width     = 208
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- chkGer60R "Tipo 60 - (R) Resumo Mensal dos Cupons" (legado Top=270/Left=354)
        loc_oPagina.AddObject("chk_4c_ChkGer60R", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer60R
            .Caption   = "Tipo 60 - (R) Resumo Mensal dos Cupons"
            .Value     = 0
            .Top       = 299
            .Left      = 354
            .Width     = 214
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- chkGer60P "Tipo 60 - (P) Condicoes de Pagamento" (legado Top=288/Left=354)
        loc_oPagina.AddObject("chk_4c_ChkGer60P", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer60P
            .Caption   = "Tipo 60 - (P) Condi" + CHR(231) + CHR(245) + "es de Pagamento"
            .Value     = 0
            .Top       = 317
            .Left      = 354
            .Width     = 201
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- chkGer61 "Tipo 61 - Nota Fiscal (Modelos 14, 15, 16, 13, 2, 4)" (legado Top=305/Left=354)
        loc_oPagina.AddObject("chk_4c_ChkGer61", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer61
            .Caption   = "Tipo 61 - Nota Fiscal (Modelos 14, 15, 16, 13, 2, 4)"
            .Value     = 0
            .Top       = 334
            .Left      = 354
            .Width     = 263
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- chkGer70 "Tipo 70 - Notas e Conhecimentos de Transportes" (legado Top=322/Left=354)
        loc_oPagina.AddObject("chk_4c_ChkGer70", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer70
            .Caption   = "Tipo 70 - Notas e Conhecimentos de Transportes"
            .Value     = 0
            .Top       = 351
            .Left      = 354
            .Width     = 252
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- chkGer74 "Tipo 74 - Inventario" (legado Top=340/Left=354)
        loc_oPagina.AddObject("chk_4c_ChkGer74", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer74
            .Caption   = "Tipo 74 - Invent" + CHR(225) + "rio"
            .Value     = 0
            .Top       = 369
            .Left      = 354
            .Width     = 113
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- fwcheckbox5 "Usar barrar no NCM" (legado Top=252/Left=817)
        loc_oPagina.AddObject("chk_4c_Fwcheckbox5", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox5
            .Caption   = "Usar barrar no NCM"
            .Value     = 0
            .Top       = 281
            .Left      = 817
            .Width     = 113
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- fwcheckbox1 "Tipo 77 - Objetos Para Transportadora" (legado Top=270/Left=688)
        loc_oPagina.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox1
            .Caption   = "Tipo 77 - Objetos Para Transportadora"
            .Value     = 0
            .Top       = 299
            .Left      = 688
            .Width     = 204
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- fwcheckbox3 "Tipo 88 - Apuracao de ICMS - GIM para PB" (legado Top=288/Left=688)
        *-- Legado When: Return(This.Parent.getEstado.Value = [PB]) -> habilitado somente para UF=PB
        loc_oPagina.AddObject("chk_4c_Fwcheckbox3", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox3
            .Caption   = "Tipo 88 - Apura" + CHR(231) + CHR(227) + "o de ICMS - GIM para PB"
            .Value     = 0
            .Top       = 317
            .Left      = 688
            .Width     = 221
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- fwcheckbox8 "Tipo 88 - MS" (legado Top=305/Left=688)
        *-- Legado When: Return(This.Parent.getEstado.Value = [MS]) -> habilitado somente para UF=MS
        loc_oPagina.AddObject("chk_4c_Fwcheckbox8", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox8
            .Caption   = "Tipo 88 - MS"
            .Value     = 0
            .Top       = 334
            .Left      = 688
            .Width     = 77
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- fwcheckbox7 "Usar Codigo de Identidade dos Produtos" (legado Top=340/Left=688)
        loc_oPagina.AddObject("chk_4c_Fwcheckbox7", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox7
            .Caption   = "Usar C" + CHR(243) + "digo de Identidade dos Produtos"
            .Value     = 0
            .Top       = 369
            .Left      = 688
            .Width     = 212
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- fwcheckbox2 "Tipos (16, 17, 18 e 19) - Selos Para Sefaz" (legado Top=322/Left=688)
        loc_oPagina.AddObject("chk_4c_Fwcheckbox2", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox2
            .Caption   = "Tipos (16, 17, 18 e 19) - Selos Para Sefaz"
            .Value     = 0
            .Top       = 351
            .Left      = 688
            .Width     = 218
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- fwcheckbox4 "sem uso" (legado Top=553/Left=467, Visible=.F., ForeColor vermelho, FontName Verdana)
        loc_oPagina.AddObject("chk_4c_Fwcheckbox4", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox4
            .Caption   = "sem uso"
            .Value     = 0
            .Top       = 582
            .Left      = 467
            .Width     = 67
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .Visible   = .F.
        ENDWITH

        *-- lbl_4c_Label9 "Geracao de Arquivos Sintegra" (legado "sayl?", Top=231/Left=17, Visible=.F., Bold)
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos Sintegra"
            .Top       = 260
            .Left      = 17
            .Width     = 170
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Alignment = 0
            .Visible   = .F.
        ENDWITH

        *-- Container BotoesAcao: botoes Confirmar/Cancelar (padrao canonico framework_frmcadastro_layout.md)
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

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ValidarChkGer50 - Valid de chkGer50 (legado PROCEDURE Valid)
    * chkGer54 so fica habilitado (e marcado) quando chkGer50 esta marcado
    *===========================================================================
    PROCEDURE ValidarChkGer50()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF loc_oPagina.chk_4c_ChkGer50.Value = 0
            loc_oPagina.chk_4c_ChkGer54.Value   = 0
            loc_oPagina.chk_4c_ChkGer54.Enabled = .F.
        ELSE
            loc_oPagina.chk_4c_ChkGer54.Enabled = .T.
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarChkGer60 - Valid de chkGer60 (legado PROCEDURE Valid)
    * chkGer60I/chkGer60D/chkGer60R/chkGer60P so ficam habilitados (e marcados)
    * quando chkGer60 esta marcado
    *===========================================================================
    PROCEDURE ValidarChkGer60()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF loc_oPagina.chk_4c_ChkGer60.Value = 0
            loc_oPagina.chk_4c_ChkGer60I.Value   = 0
            loc_oPagina.chk_4c_ChkGer60D.Value   = 0
            loc_oPagina.chk_4c_ChkGer60R.Value   = 0
            loc_oPagina.chk_4c_ChkGer60P.Value   = 0

            loc_oPagina.chk_4c_ChkGer60I.Enabled = .F.
            loc_oPagina.chk_4c_ChkGer60D.Enabled = .F.
            loc_oPagina.chk_4c_ChkGer60R.Enabled = .F.
            loc_oPagina.chk_4c_ChkGer60P.Enabled = .F.
        ELSE
            loc_oPagina.chk_4c_ChkGer60I.Enabled = .T.
            loc_oPagina.chk_4c_ChkGer60D.Enabled = .T.
            loc_oPagina.chk_4c_ChkGer60R.Enabled = .T.
            loc_oPagina.chk_4c_ChkGer60P.Enabled = .T.
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Abre Page2 para incluir novo estado
    * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3)
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
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cEstado
        loc_cEstado = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cEstado = ALLTRIM(cursor_4c_Dados.estados)
        ENDIF

        IF EMPTY(loc_cEstado)
            MsgAviso("Selecione um estado para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEstado)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre Page2 para alterar o estado selecionado
    * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cEstado
        loc_cEstado = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cEstado = ALLTRIM(cursor_4c_Dados.estados)
        ENDIF

        IF EMPTY(loc_cEstado)
            MsgAviso("Selecione um estado para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEstado)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o estado selecionado com confirmacao
    * Transcrito do legado (Salva.Click ramo EXCLUIR): bloqueia exclusao se a UF
    * estiver em uso em SigCdCli/SigCdCee/SigCdCll (verificado no UfsBO)
    * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cEstado
        loc_cEstado = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cEstado = ALLTRIM(cursor_4c_Dados.estados)
        ENDIF

        IF EMPTY(loc_cEstado)
            MsgAviso("Selecione um estado para excluir.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEstado)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do estado [" + loc_cEstado + "]?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Estado exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ELSE
                        IF !THIS.this_oBusinessObject.this_lErroExibido
                            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Confirmar")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere dados do Form para o BO antes de salvar
    * Todas as propriedades this_* de UfsBO.prg mapeadas nos campos de Page2
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina, loc_cIpiSel
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cEstados    = UPPER(ALLTRIM(loc_oPagina.txt_4c_Estado.Value))
        THIS.this_oBusinessObject.this_cDescrs     = ALLTRIM(loc_oPagina.txt_4c_Descr.Value)
        THIS.this_oBusinessObject.this_nAicms      = loc_oPagina.txt_4c_Aicms.Value
        THIS.this_oBusinessObject.this_nBicms      = loc_oPagina.txt_4c_Bicms.Value
        THIS.this_oBusinessObject.this_nAreduzidas = loc_oPagina.txt_4c_Areduzida.Value
        THIS.this_oBusinessObject.this_nAliqsbs    = loc_oPagina.txt_4c_AliqSB.Value
        THIS.this_oBusinessObject.this_nUFIBGEs    = loc_oPagina.txt_4c_UFIBGES.Value
        THIS.this_oBusinessObject.this_cLayoutnf   = ALLTRIM(loc_oPagina.txt_4c_Layoutnf.Value)

        *-- cmbIpi: itens "\<Tributado "/"\<Isento   "/"\<Outros   " -> codigo T/I/O (this_cIpis)
        loc_cIpiSel = UPPER(ALLTRIM(STRTRAN(loc_oPagina.cbo_4c_CmbIpi.Value, "\<", "")))
        DO CASE
            CASE loc_cIpiSel = "ISENTO"
                THIS.this_oBusinessObject.this_cIpis = "I"
            CASE loc_cIpiSel = "OUTROS"
                THIS.this_oBusinessObject.this_cIpis = "O"
            OTHERWISE
                THIS.this_oBusinessObject.this_cIpis = "T"
        ENDCASE

        THIS.this_oBusinessObject.this_nGer50      = IIF(loc_oPagina.chk_4c_ChkGer50.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGer51      = IIF(loc_oPagina.chk_4c_ChkGer51.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGer53      = IIF(loc_oPagina.chk_4c_ChkGer53.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGer54      = IIF(loc_oPagina.chk_4c_ChkGer54.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGer60      = IIF(loc_oPagina.chk_4c_ChkGer60.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGer60I     = IIF(loc_oPagina.chk_4c_ChkGer60I.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGer60D     = IIF(loc_oPagina.chk_4c_ChkGer60D.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGer60R     = IIF(loc_oPagina.chk_4c_ChkGer60R.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGer60P     = IIF(loc_oPagina.chk_4c_ChkGer60P.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGer61      = IIF(loc_oPagina.chk_4c_ChkGer61.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGer70      = IIF(loc_oPagina.chk_4c_ChkGer70.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGer74      = IIF(loc_oPagina.chk_4c_ChkGer74.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGer75      = IIF(loc_oPagina.chk_4c_ChkGer75.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGer77      = IIF(loc_oPagina.chk_4c_Fwcheckbox1.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGerSefaz   = IIF(loc_oPagina.chk_4c_Fwcheckbox2.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGer88      = IIF(loc_oPagina.chk_4c_Fwcheckbox3.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nNgersufr1s = IIF(loc_oPagina.chk_4c_Fwcheckbox4.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGerncm     = IIF(loc_oPagina.chk_4c_Fwcheckbox5.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nNcotepe52s = IIF(loc_oPagina.chk_4c_Fwcheckbox6.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nCodidents  = IIF(loc_oPagina.chk_4c_Fwcheckbox7.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nGer88ms    = IIF(loc_oPagina.chk_4c_Fwcheckbox8.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nChkgnre    = IIF(loc_oPagina.chk_4c_Fwcheckbox9.Value = 1, 1, 0)
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do BO para o Form apos carregar registro
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_cIpiTexto
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Estado.Value    = THIS.this_oBusinessObject.this_cEstados
        loc_oPagina.txt_4c_Descr.Value     = THIS.this_oBusinessObject.this_cDescrs
        loc_oPagina.txt_4c_Aicms.Value     = THIS.this_oBusinessObject.this_nAicms
        loc_oPagina.txt_4c_Bicms.Value     = THIS.this_oBusinessObject.this_nBicms
        loc_oPagina.txt_4c_Areduzida.Value = THIS.this_oBusinessObject.this_nAreduzidas
        loc_oPagina.txt_4c_AliqSB.Value    = THIS.this_oBusinessObject.this_nAliqsbs
        loc_oPagina.txt_4c_UFIBGES.Value   = THIS.this_oBusinessObject.this_nUFIBGEs
        loc_oPagina.txt_4c_Layoutnf.Value  = THIS.this_oBusinessObject.this_cLayoutnf

        DO CASE
            CASE THIS.this_oBusinessObject.this_cIpis = "I"
                loc_cIpiTexto = "Isento"
            CASE THIS.this_oBusinessObject.this_cIpis = "O"
                loc_cIpiTexto = "Outros"
            OTHERWISE
                loc_cIpiTexto = "Tributado"
        ENDCASE
        loc_oPagina.cbo_4c_CmbIpi.Value = "\<" + PADR(loc_cIpiTexto, 9)

        loc_oPagina.chk_4c_ChkGer50.Value    = (THIS.this_oBusinessObject.this_nGer50 .Value    = IIF(THIS.this_oBusinessObject.this_nGer50 = 1, 1, 0))
        loc_oPagina.chk_4c_ChkGer51.Value    = (THIS.this_oBusinessObject.this_nGer51 .Value    = IIF(THIS.this_oBusinessObject.this_nGer51 = 1, 1, 0))
        loc_oPagina.chk_4c_ChkGer53.Value    = (THIS.this_oBusinessObject.this_nGer53 .Value    = IIF(THIS.this_oBusinessObject.this_nGer53 = 1, 1, 0))
        loc_oPagina.chk_4c_ChkGer54.Value    = (THIS.this_oBusinessObject.this_nGer54 .Value    = IIF(THIS.this_oBusinessObject.this_nGer54 = 1, 1, 0))
        loc_oPagina.chk_4c_ChkGer60.Value    = (THIS.this_oBusinessObject.this_nGer60 .Value    = IIF(THIS.this_oBusinessObject.this_nGer60 = 1, 1, 0))
        loc_oPagina.chk_4c_ChkGer60I.Value   = (THIS.this_oBusinessObject.this_nGer60I .Value   = IIF(THIS.this_oBusinessObject.this_nGer60I = 1, 1, 0))
        loc_oPagina.chk_4c_ChkGer60D.Value   = (THIS.this_oBusinessObject.this_nGer60D .Value   = IIF(THIS.this_oBusinessObject.this_nGer60D = 1, 1, 0))
        loc_oPagina.chk_4c_ChkGer60R.Value   = (THIS.this_oBusinessObject.this_nGer60R .Value   = IIF(THIS.this_oBusinessObject.this_nGer60R = 1, 1, 0))
        loc_oPagina.chk_4c_ChkGer60P.Value   = (THIS.this_oBusinessObject.this_nGer60P .Value   = IIF(THIS.this_oBusinessObject.this_nGer60P = 1, 1, 0))
        loc_oPagina.chk_4c_ChkGer61.Value    = (THIS.this_oBusinessObject.this_nGer61 .Value    = IIF(THIS.this_oBusinessObject.this_nGer61 = 1, 1, 0))
        loc_oPagina.chk_4c_ChkGer70.Value    = (THIS.this_oBusinessObject.this_nGer70 .Value    = IIF(THIS.this_oBusinessObject.this_nGer70 = 1, 1, 0))
        loc_oPagina.chk_4c_ChkGer74.Value    = (THIS.this_oBusinessObject.this_nGer74 .Value    = IIF(THIS.this_oBusinessObject.this_nGer74 = 1, 1, 0))
        loc_oPagina.chk_4c_ChkGer75.Value    = (THIS.this_oBusinessObject.this_nGer75 .Value    = IIF(THIS.this_oBusinessObject.this_nGer75 = 1, 1, 0))
        loc_oPagina.chk_4c_Fwcheckbox1.Value = (THIS.this_oBusinessObject.this_nGer77 .Value = IIF(THIS.this_oBusinessObject.this_nGer77 = 1, 1, 0))
        loc_oPagina.chk_4c_Fwcheckbox2.Value = (THIS.this_oBusinessObject.this_nGerSefaz .Value = IIF(THIS.this_oBusinessObject.this_nGerSefaz = 1, 1, 0))
        loc_oPagina.chk_4c_Fwcheckbox3.Value = (THIS.this_oBusinessObject.this_nGer88 .Value = IIF(THIS.this_oBusinessObject.this_nGer88 = 1, 1, 0))
        loc_oPagina.chk_4c_Fwcheckbox4.Value = (THIS.this_oBusinessObject.this_nNgersufr1s .Value = IIF(THIS.this_oBusinessObject.this_nNgersufr1s = 1, 1, 0))
        loc_oPagina.chk_4c_Fwcheckbox5.Value = (THIS.this_oBusinessObject.this_nGerncm .Value = IIF(THIS.this_oBusinessObject.this_nGerncm = 1, 1, 0))
        loc_oPagina.chk_4c_Fwcheckbox6.Value = (THIS.this_oBusinessObject.this_nNcotepe52s .Value = IIF(THIS.this_oBusinessObject.this_nNcotepe52s = 1, 1, 0))
        loc_oPagina.chk_4c_Fwcheckbox7.Value = (THIS.this_oBusinessObject.this_nCodidents .Value = IIF(THIS.this_oBusinessObject.this_nCodidents = 1, 1, 0))
        loc_oPagina.chk_4c_Fwcheckbox8.Value = (THIS.this_oBusinessObject.this_nGer88ms .Value = IIF(THIS.this_oBusinessObject.this_nGer88ms = 1, 1, 0))
        loc_oPagina.chk_4c_Fwcheckbox9.Value = (THIS.this_oBusinessObject.this_nChkgnre .Value = IIF(THIS.this_oBusinessObject.this_nChkgnre = 1, 1, 0))
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao da Page2
    * UF (chave primaria) fica somente leitura fora do modo INCLUIR.
    * chkGer54/chkGer60I/D/R/P seguem o Enabled dos respectivos "pais"
    * (chkGer50/chkGer60 - mesma regra do Valid legado em ValidarChkGer50/60)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lPKReadOnly
        loc_oPagina     = THIS.pgf_4c_Paginas.Page2
        loc_lPKReadOnly = (THIS.this_cModoAtual != "INCLUIR")

        loc_oPagina.txt_4c_Estado.Enabled    = par_lHabilitar AND !loc_lPKReadOnly
        loc_oPagina.txt_4c_Descr.Enabled     = par_lHabilitar
        loc_oPagina.txt_4c_Aicms.Enabled     = par_lHabilitar
        loc_oPagina.txt_4c_Bicms.Enabled     = par_lHabilitar
        loc_oPagina.txt_4c_Areduzida.Enabled = par_lHabilitar
        loc_oPagina.txt_4c_AliqSB.Enabled    = par_lHabilitar
        loc_oPagina.txt_4c_UFIBGES.Enabled   = par_lHabilitar
        loc_oPagina.txt_4c_Layoutnf.Enabled  = par_lHabilitar
        loc_oPagina.cbo_4c_CmbIpi.Enabled    = par_lHabilitar

        loc_oPagina.chk_4c_ChkGer50.Enabled    = par_lHabilitar
        loc_oPagina.chk_4c_ChkGer51.Enabled    = par_lHabilitar
        loc_oPagina.chk_4c_ChkGer53.Enabled    = par_lHabilitar
        loc_oPagina.chk_4c_ChkGer54.Enabled    = par_lHabilitar AND loc_oPagina.chk_4c_ChkGer50.Value
        loc_oPagina.chk_4c_ChkGer60.Enabled    = par_lHabilitar
        loc_oPagina.chk_4c_ChkGer60I.Enabled   = par_lHabilitar AND loc_oPagina.chk_4c_ChkGer60.Value
        loc_oPagina.chk_4c_ChkGer60D.Enabled   = par_lHabilitar AND loc_oPagina.chk_4c_ChkGer60.Value
        loc_oPagina.chk_4c_ChkGer60R.Enabled   = par_lHabilitar AND loc_oPagina.chk_4c_ChkGer60.Value
        loc_oPagina.chk_4c_ChkGer60P.Enabled   = par_lHabilitar AND loc_oPagina.chk_4c_ChkGer60.Value
        loc_oPagina.chk_4c_ChkGer61.Enabled    = par_lHabilitar
        loc_oPagina.chk_4c_ChkGer70.Enabled    = par_lHabilitar
        loc_oPagina.chk_4c_ChkGer74.Enabled    = par_lHabilitar
        loc_oPagina.chk_4c_ChkGer75.Enabled    = par_lHabilitar
        loc_oPagina.chk_4c_Fwcheckbox1.Enabled = par_lHabilitar
        loc_oPagina.chk_4c_Fwcheckbox2.Enabled = par_lHabilitar
        loc_oPagina.chk_4c_Fwcheckbox3.Enabled = par_lHabilitar
        loc_oPagina.chk_4c_Fwcheckbox4.Enabled = par_lHabilitar
        loc_oPagina.chk_4c_Fwcheckbox5.Enabled = par_lHabilitar
        loc_oPagina.chk_4c_Fwcheckbox6.Enabled = par_lHabilitar
        loc_oPagina.chk_4c_Fwcheckbox7.Enabled = par_lHabilitar
        loc_oPagina.chk_4c_Fwcheckbox8.Enabled = par_lHabilitar
        loc_oPagina.chk_4c_Fwcheckbox9.Enabled = par_lHabilitar
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos da Page2 para novo registro
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Estado.Value    = ""
        loc_oPagina.txt_4c_Descr.Value     = ""
        loc_oPagina.txt_4c_Aicms.Value     = 0
        loc_oPagina.txt_4c_Bicms.Value     = 0
        loc_oPagina.txt_4c_Areduzida.Value = 0
        loc_oPagina.txt_4c_AliqSB.Value    = 0
        loc_oPagina.txt_4c_UFIBGES.Value   = 0
        loc_oPagina.txt_4c_Layoutnf.Value  = ""
        loc_oPagina.cbo_4c_CmbIpi.Value    = "\<" + PADR("Tributado", 9)

        loc_oPagina.chk_4c_ChkGer50.Value    = 0
        loc_oPagina.chk_4c_ChkGer51.Value    = 0
        loc_oPagina.chk_4c_ChkGer53.Value    = 0
        loc_oPagina.chk_4c_ChkGer54.Value    = 0
        loc_oPagina.chk_4c_ChkGer60.Value    = 0
        loc_oPagina.chk_4c_ChkGer60I.Value   = 0
        loc_oPagina.chk_4c_ChkGer60D.Value   = 0
        loc_oPagina.chk_4c_ChkGer60R.Value   = 0
        loc_oPagina.chk_4c_ChkGer60P.Value   = 0
        loc_oPagina.chk_4c_ChkGer61.Value    = 0
        loc_oPagina.chk_4c_ChkGer70.Value    = 0
        loc_oPagina.chk_4c_ChkGer74.Value    = 0
        loc_oPagina.chk_4c_ChkGer75.Value    = 0
        loc_oPagina.chk_4c_Fwcheckbox1.Value = 0
        loc_oPagina.chk_4c_Fwcheckbox2.Value = 0
        loc_oPagina.chk_4c_Fwcheckbox3.Value = 0
        loc_oPagina.chk_4c_Fwcheckbox4.Value = 0
        loc_oPagina.chk_4c_Fwcheckbox5.Value = 0
        loc_oPagina.chk_4c_Fwcheckbox6.Value = 0
        loc_oPagina.chk_4c_Fwcheckbox7.Value = 0
        loc_oPagina.chk_4c_Fwcheckbox8.Value = 0
        loc_oPagina.chk_4c_Fwcheckbox9.Value = 0
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
    * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
    * PUBLIC: chamado diretamente pelo harness de teste (TesteAutomatico.prg)
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEditando
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar um estado na lista
    * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUfs", "cursor_4c_BuscaUfLista", "estados", "", "Buscar Estado")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Estados", "", "U" + "F")
                    loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUfLista")
                    SELECT cursor_4c_BuscaUfLista
                    loc_cCodigo = ALLTRIM(Estados)
                    THIS.CarregarLista("estados = " + EscaparSQL(loc_cCodigo))
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FormUfs.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaUfLista")
            USE IN cursor_4c_BuscaUfLista
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida e grava o registro (Confirmar)
    * Validacoes FORA do TRY (transcrito do legado SIGCDUFD.Click - Event Click 38
    * linhas em comportamento.json: "U.F. Invalido." se vazio; "U.F. Ja Cadastrado."
    * se duplicado em modo INCLUIR - mesma checagem de UfsBO.ValidarDados, repetida
    * aqui apenas para reproduzir o SetFocus() do legado). Salvar() sem parametro
    * (CLAUDE.md); falha ja e reportada pelo BusinessBase (regra #20) - so avisa
    * se nao exibido.
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cEstado
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cEstado = UPPER(ALLTRIM(loc_oPg2.txt_4c_Estado.Value))

        IF EMPTY(loc_cEstado)
            MsgAviso("U.F. Inv" + CHR(225) + "lido.")
            loc_oPg2.txt_4c_Estado.SetFocus()
            RETURN
        ENDIF

        IF THIS.this_cModoAtual = "INCLUIR" AND THIS.this_oBusinessObject.VerificarCodigoExistente(loc_cEstado)
            MsgAviso("U.F. J" + CHR(225) + " Cadastrado.")
            loc_oPg2.txt_4c_Estado.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Confirmar")
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        ELSE
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e volta para a lista (recarregada)
    * Transcrito do legado (Cancela.Click): =DoDefault() If ThisForm.plCancelar
    * ThisForm.mAtivapagina1 Endif
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Percorre Controls() e Pages() (para PageFrames aninhados)
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
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\UfsBO.prg):
*====================================================================
* UfsBO.prg
*
* Business Object para Ufs (Cadastro de Estados)
* Tabela: SigCdUfs (PK: estados)
*====================================================================

DEFINE CLASS UfsBO AS BusinessBase

	*-- Propriedades da entidade (colunas de SigCdUfs - docs/schema.sql)
	this_cEstados                   = ""   && char(2)  - PK
	this_cDescrs                    = ""   && char(40)
	this_nAicms                     = 0    && numeric(9,2)
	this_nBicms                     = 0    && numeric(9,2)
	this_nAreduzidas                = 0    && numeric(9,2)
	this_cIpis                      = ""   && char(1)
	this_nGer60D                    = 0    && numeric(1,0)
	this_nGer60I                    = 0    && numeric(1,0)
	this_nGer60R                    = 0    && numeric(1,0)
	this_nGer74                     = 0    && numeric(1,0)
	this_nGer75                     = 0    && numeric(1,0)
	this_nGer77                     = 0    && numeric(1,0)
	this_nGerSefaz                  = 0    && numeric(1,0)
	this_nGer50                     = 0    && numeric(1,0)
	this_nGer51                     = 0    && numeric(1,0)
	this_nGer54                     = 0    && numeric(1,0)
	this_nGer60                     = 0    && numeric(1,0)
	this_nGer61                     = 0    && numeric(1,0)
	this_nGer70                     = 0    && numeric(1,0)
	this_nGer88                     = 0    && numeric(1,0)
	this_nAliqsbs                   = 0    && numeric(9,2)
	this_nGer53                     = 0    && numeric(1,0)
	this_nNgersufr1s                = 0    && int
	this_nGerncm                    = 0    && numeric(1,0)
	this_nCodidents                 = 0    && numeric(1,0)
	this_nGer60P                    = 0    && numeric(1,0)
	this_nNcotepe52s                = 0    && int
	this_nGer88ms                   = 0    && numeric(1,0)
	this_nUFIBGEs                   = 0    && numeric(2,0)
	this_cLayoutnf                  = ""   && char(20)
	this_nChkgnre                   = 0    && numeric(1,0)
	this_cChaveConsultaHomologacao  = ""   && char(80)
	this_cChaveConsultaProducao     = ""   && char(80)
	this_cHomologacao               = ""   && char(80)
	this_cProducao                  = ""   && char(80)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela = "SigCdUfs"
			THIS.this_cCampoChave = "estados"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "UfsBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cEstados)
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
				THIS.this_cEstados                  = TratarNulo(estados,                   "C")
				THIS.this_cDescrs                   = TratarNulo(descrs,                    "C")
				THIS.this_nAicms                    = TratarNulo(aicms,                      "N")
				THIS.this_nBicms                    = TratarNulo(bicms,                      "N")
				THIS.this_nAreduzidas                = TratarNulo(areduzidas,                "N")
				THIS.this_cIpis                     = TratarNulo(ipis,                       "C")
				THIS.this_nGer60D                   = TratarNulo(ger60d,                     "N")
				THIS.this_nGer60I                   = TratarNulo(ger60i,                     "N")
				THIS.this_nGer60R                   = TratarNulo(ger60r,                     "N")
				THIS.this_nGer74                    = TratarNulo(ger74,                      "N")
				THIS.this_nGer75                    = TratarNulo(ger75,                      "N")
				THIS.this_nGer77                    = TratarNulo(ger77,                      "N")
				THIS.this_nGerSefaz                 = TratarNulo(gersefaz,                   "N")
				THIS.this_nGer50                    = TratarNulo(ger50,                      "N")
				THIS.this_nGer51                    = TratarNulo(ger51,                      "N")
				THIS.this_nGer54                    = TratarNulo(ger54,                      "N")
				THIS.this_nGer60                    = TratarNulo(ger60,                      "N")
				THIS.this_nGer61                    = TratarNulo(ger61,                      "N")
				THIS.this_nGer70                    = TratarNulo(ger70,                      "N")
				THIS.this_nGer88                    = TratarNulo(ger88,                      "N")
				THIS.this_nAliqsbs                  = TratarNulo(aliqsbs,                    "N")
				THIS.this_nGer53                    = TratarNulo(ger53,                      "N")
				THIS.this_nNgersufr1s                = TratarNulo(ngersufr1s,                "N")
				THIS.this_nGerncm                   = TratarNulo(gerncm,                     "N")
				THIS.this_nCodidents                = TratarNulo(codidents,                  "N")
				THIS.this_nGer60P                   = TratarNulo(ger60p,                     "N")
				THIS.this_nNcotepe52s                = TratarNulo(ncotepe52s,                "N")
				THIS.this_nGer88ms                  = TratarNulo(ger88ms,                    "N")
				THIS.this_nUFIBGEs                  = TratarNulo(UFIBGEs,                    "N")
				THIS.this_cLayoutnf                 = TratarNulo(layoutnf,                   "C")
				THIS.this_nChkgnre                  = TratarNulo(chkgnre,                    "N")
				THIS.this_cChaveConsultaHomologacao = TratarNulo(ChaveConsultaHomologacao,    "C")
				THIS.this_cChaveConsultaProducao    = TratarNulo(ChaveConsultaProducao,       "C")
				THIS.this_cHomologacao              = TratarNulo(Homologacao,                 "C")
				THIS.this_cProducao                 = TratarNulo(Producao,                    "C")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "UfsBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	* Transcrito do legado: getEstado nao pode ficar vazio; UF duplicada
	* so eh bloqueada na INCLUSAO (Salva.Click, SigCdUfs_form_codigo_fonte.txt)
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		LOCAL loc_lValido
		loc_lValido = .T.

		IF EMPTY(THIS.this_cEstados)
			THIS.this_cMensagemErro = "U.F. Inv" + CHR(225) + "lido."
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_lNovoRegistro
			IF THIS.VerificarCodigoExistente(THIS.this_cEstados)
				THIS.this_cMensagemErro = "U.F. J" + CHR(225) + " Cadastrado."
				loc_lValido = .F.
			ENDIF
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* VerificarCodigoExistente - Verifica se estados ja existe no banco
	*====================================================================
	PROCEDURE VerificarCodigoExistente(par_cEstados)
		LOCAL loc_cSQL, loc_nResultado, loc_lExiste
		loc_lExiste = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdUfs" + ;
				" WHERE estados = " + EscaparSQL(par_cEstados)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
			IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
				SELECT cursor_4c_ChkCod
				loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
				USE IN cursor_4c_ChkCod
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao verificar U.F.:" + CHR(13) + loException.Message, "UfsBO.VerificarCodigoExistente")
		ENDTRY

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdUfs
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigCdUfs (
					estados, descrs, aicms, bicms, areduzidas, ipis,
					ger60d, ger60i, ger60r, ger74, ger75, ger77, gersefaz,
					ger50, ger51, ger54, ger60, ger61, ger70, ger88,
					aliqsbs, ger53, ngersufr1s, gerncm, codidents, ger60p,
					ncotepe52s, ger88ms, UFIBGEs, layoutnf, chkgnre,
					ChaveConsultaHomologacao, ChaveConsultaProducao, Homologacao, Producao
				)
				VALUES (
					<<EscaparSQL(THIS.this_cEstados)>>,
					<<EscaparSQL(THIS.this_cDescrs)>>,
					<<FormatarNumeroSQL(THIS.this_nAicms, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nBicms, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nAreduzidas, 2)>>,
					<<EscaparSQL(THIS.this_cIpis)>>,
					<<FormatarNumeroSQL(THIS.this_nGer60D, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer60I, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer60R, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer74, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer75, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer77, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGerSefaz, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer50, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer51, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer54, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer60, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer61, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer70, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer88, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nAliqsbs, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nGer53, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNgersufr1s, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGerncm, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nCodidents, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer60P, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNcotepe52s, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer88ms, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nUFIBGEs, 0)>>,
					<<EscaparSQL(THIS.this_cLayoutnf)>>,
					<<FormatarNumeroSQL(THIS.this_nChkgnre, 0)>>,
					<<EscaparSQL(THIS.this_cChaveConsultaHomologacao)>>,
					<<EscaparSQL(THIS.this_cChaveConsultaProducao)>>,
					<<EscaparSQL(THIS.this_cHomologacao)>>,
					<<EscaparSQL(THIS.this_cProducao)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "UfsBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdUfs
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdUfs
				SET descrs      = <<EscaparSQL(THIS.this_cDescrs)>>,
					aicms       = <<FormatarNumeroSQL(THIS.this_nAicms, 2)>>,
					bicms       = <<FormatarNumeroSQL(THIS.this_nBicms, 2)>>,
					areduzidas  = <<FormatarNumeroSQL(THIS.this_nAreduzidas, 2)>>,
					ipis        = <<EscaparSQL(THIS.this_cIpis)>>,
					ger60d      = <<FormatarNumeroSQL(THIS.this_nGer60D, 0)>>,
					ger60i      = <<FormatarNumeroSQL(THIS.this_nGer60I, 0)>>,
					ger60r      = <<FormatarNumeroSQL(THIS.this_nGer60R, 0)>>,
					ger74       = <<FormatarNumeroSQL(THIS.this_nGer74, 0)>>,
					ger75       = <<FormatarNumeroSQL(THIS.this_nGer75, 0)>>,
					ger77       = <<FormatarNumeroSQL(THIS.this_nGer77, 0)>>,
					gersefaz    = <<FormatarNumeroSQL(THIS.this_nGerSefaz, 0)>>,
					ger50       = <<FormatarNumeroSQL(THIS.this_nGer50, 0)>>,
					ger51       = <<FormatarNumeroSQL(THIS.this_nGer51, 0)>>,
					ger54       = <<FormatarNumeroSQL(THIS.this_nGer54, 0)>>,
					ger60       = <<FormatarNumeroSQL(THIS.this_nGer60, 0)>>,
					ger61       = <<FormatarNumeroSQL(THIS.this_nGer61, 0)>>,
					ger70       = <<FormatarNumeroSQL(THIS.this_nGer70, 0)>>,
					ger88       = <<FormatarNumeroSQL(THIS.this_nGer88, 0)>>,
					aliqsbs     = <<FormatarNumeroSQL(THIS.this_nAliqsbs, 2)>>,
					ger53       = <<FormatarNumeroSQL(THIS.this_nGer53, 0)>>,
					ngersufr1s  = <<FormatarNumeroSQL(THIS.this_nNgersufr1s, 0)>>,
					gerncm      = <<FormatarNumeroSQL(THIS.this_nGerncm, 0)>>,
					codidents   = <<FormatarNumeroSQL(THIS.this_nCodidents, 0)>>,
					ger60p      = <<FormatarNumeroSQL(THIS.this_nGer60P, 0)>>,
					ncotepe52s  = <<FormatarNumeroSQL(THIS.this_nNcotepe52s, 0)>>,
					ger88ms     = <<FormatarNumeroSQL(THIS.this_nGer88ms, 0)>>,
					UFIBGEs     = <<FormatarNumeroSQL(THIS.this_nUFIBGEs, 0)>>,
					layoutnf    = <<EscaparSQL(THIS.this_cLayoutnf)>>,
					chkgnre     = <<FormatarNumeroSQL(THIS.this_nChkgnre, 0)>>,
					ChaveConsultaHomologacao = <<EscaparSQL(THIS.this_cChaveConsultaHomologacao)>>,
					ChaveConsultaProducao    = <<EscaparSQL(THIS.this_cChaveConsultaProducao)>>,
					Homologacao = <<EscaparSQL(THIS.this_cHomologacao)>>,
					Producao    = <<EscaparSQL(THIS.this_cProducao)>>
				WHERE estados = <<EscaparSQL(THIS.this_cEstados)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "UfsBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro da tabela SigCdUfs
	* Transcrito do legado (Salva.Click, ramo EXCLUIR): bloqueia exclusao
	* se a UF estiver em uso em SigCdCli.estas, SigCdCee.estas ou SigCdCll.estas
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
		loc_lSucesso = .F.
		loc_nUso     = 0

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT CASE WHEN
					EXISTS (SELECT 1 FROM SigCdCli WHERE estas = <<EscaparSQL(THIS.this_cEstados)>>) OR
					EXISTS (SELECT 1 FROM SigCdCee WHERE estas = <<EscaparSQL(THIS.this_cEstados)>>) OR
					EXISTS (SELECT 1 FROM SigCdCll WHERE estas = <<EscaparSQL(THIS.this_cEstados)>>)
				THEN 1 ELSE 0 END AS nUso
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkUfs")

			IF loc_nResultado < 0
				MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED("cursor_4c_ChkUfs")
					SELECT cursor_4c_ChkUfs
					loc_nUso = NVL(cursor_4c_ChkUfs.nUso, 0)
					USE IN cursor_4c_ChkUfs
				ENDIF

				IF loc_nUso > 0
					THIS.this_cMensagemErro = "Estado n" + CHR(227) + "o pode ser exclu" + CHR(237) + ;
						"do pois est" + CHR(225) + " sendo usado em Clientes!"
				ELSE
					loc_cSQL = "DELETE FROM SigCdUfs WHERE estados = " + EscaparSQL(THIS.this_cEstados)
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("DELETE")
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao excluir estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "UfsBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados com as colunas da grade do legado
	* (Estados, descrs, aicms, bicms, areduzidas, AliqSbs - PROCEDURE Init)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (estados C(2), descrs C(40), aicms N(9,2), bicms N(9,2), areduzidas N(9,2), aliqsbs N(9,2))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT estados, descrs, aicms, bicms, areduzidas, aliqsbs FROM SigCdUfs"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY estados"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MostrarErro("Erro ao buscar estados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "UfsBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (estados)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cEstados)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT estados, descrs, aicms, bicms, areduzidas, ipis,
					ger60d, ger60i, ger60r, ger74, ger75, ger77, gersefaz,
					ger50, ger51, ger54, ger60, ger61, ger70, ger88,
					aliqsbs, ger53, ngersufr1s, gerncm, codidents, ger60p,
					ncotepe52s, ger88ms, UFIBGEs, layoutnf, chkgnre,
					ChaveConsultaHomologacao, ChaveConsultaProducao, Homologacao, Producao
				FROM SigCdUfs
				WHERE estados = <<EscaparSQL(par_cEstados)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Estado n" + CHR(227) + "o encontrado!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "UfsBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

