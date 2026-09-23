# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnIncluirNavegacao': Connection handle is invalid. | Detalhes: Linha: 1439, Proc: limparcampos

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-09-19 04:03:46] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-19 04:03:46] [INFO] Config FPW: (nao fornecido)
[2026-09-19 04:03:46] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-19 04:03:46] [INFO] Timeout: 300 segundos
[2026-09-19 04:03:46] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jc4p0en4.prg
[2026-09-19 04:03:46] [INFO] Conteudo do wrapper:
[2026-09-19 04:03:46] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormVEN', 'C:\4c\tasks\task557', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormVEN', 'C:\4c\tasks\task557', 'CRUD'
QUIT

[2026-09-19 04:03:46] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jc4p0en4.prg
[2026-09-19 04:03:46] [INFO] VFP output esperado em: C:\4c\tasks\task557\vfp_output.txt
[2026-09-19 04:03:46] [INFO] Executando Visual FoxPro 9...
[2026-09-19 04:03:46] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jc4p0en4.prg
[2026-09-19 04:03:46] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jc4p0en4.prg
[2026-09-19 04:03:46] [INFO] Timeout configurado: 300 segundos
[2026-09-19 04:05:44] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-19 04:05:44] [INFO] VFP9 finalizado em 118.4088144 segundos
[2026-09-19 04:05:44] [INFO] Exit Code: 
[2026-09-19 04:05:44] [INFO] 
[2026-09-19 04:05:44] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-19 04:05:44] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jc4p0en4.prg
[2026-09-19 04:05:44] [INFO] 
[2026-09-19 04:05:44] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-19 04:05:44] [INFO] * Auto-generated wrapper for parameters
[2026-09-19 04:05:44] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-19 04:05:44] [INFO] * Parameters: 'FormVEN', 'C:\4c\tasks\task557', 'CRUD'
[2026-09-19 04:05:44] [INFO] 
[2026-09-19 04:05:44] [INFO] * Anti-dialog protections for unattended execution
[2026-09-19 04:05:44] [INFO] SET SAFETY OFF
[2026-09-19 04:05:44] [INFO] SET RESOURCE OFF
[2026-09-19 04:05:44] [INFO] SET TALK OFF
[2026-09-19 04:05:44] [INFO] SET NOTIFY OFF
[2026-09-19 04:05:44] [INFO] SYS(2335, 0)
[2026-09-19 04:05:44] [INFO] 
[2026-09-19 04:05:44] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormVEN', 'C:\4c\tasks\task557', 'CRUD'
[2026-09-19 04:05:44] [INFO] QUIT
[2026-09-19 04:05:44] [INFO] 
[2026-09-19 04:05:44] [INFO] === Fim do Wrapper.prg ===
[2026-09-19 04:05:44] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormVEN",
  "timestamp": "20260919040544",
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
      "erro": "Connection handle is invalid.",
      "detalhes": "Linha: 1439, Proc: limparcampos"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormVEN.prg):
*==============================================================================
* FormVEN.prg - Formulario de Cadastro de Presenca de Vendedores
* Migrado de: SIGCDVEN.SCX (frmcadastro)
* Tabela: SigCdVen | PK: codigo
*==============================================================================

DEFINE CLASS FormVEN AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Presenca de Vendedores"
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

    *-- Guardas anti-retrigger para validacoes LostFocus (Problema 45)
    this_cUltimoEmpsValidado     = ""
    this_cUltimoVensValidado     = ""
    this_cUltimoDVensValidado    = ""
    this_cUltimaSituacaoValidada = ""

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
            THIS.Caption = "Cadastro de Presen" + CHR(231) + "a de Vendedores"

            THIS.this_oBusinessObject = CREATEOBJECT("VENBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar VENBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormVEN.InicializarForm")
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
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormVEN:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormVEN.InicializarForm")
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
    * ConfigurarPaginaLista - Estrutura completa da Page1 (Lista)
    * Cabecalho canonico (1o AddObject) + botoes CRUD (Grupo_op) +
    * cnt_4c_Saida/Encerrar (padrao canonico, regra #10) + Grid de listagem
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado) - Top=2+29=31
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

        *-- Container Botoes CRUD (Grupo_op no legado)
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

        *-- Botao Incluir (Left=5)
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

        *-- Botao Visualizar (Left=80)
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

        *-- Botao Alterar (Left=155)
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

        *-- Botao Excluir (Left=230)
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

        *-- Botao Buscar (Left=305)
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

        *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, regra #10)
        *-- Legado: Grupo_Saida.Left=919, Top=-1. Canonico: Left=917, Top=29, Width=90
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

        *-- Grid de listagem de vendedores
        *-- Original: Grade.Top=131, Left=29, Width=940, Height=456
        *-- Canonico framework: Top=160 (131+29 compensacao), Left=26, Width=880, Height=456
        *-- (Width=880 para nao sobrepor cnt_4c_Saida em Left=917; Height preservada do legado)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 11
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 160
            .Left               = 26
            .Width              = 880
            .Height             = 456
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
    * ConfigurarPaginaDados - Estrutura completa da Page2 (Dados)
    * Cabecalho canonico (1o AddObject) + container de botoes Confirmar/Cancelar
    * + todos os campos de dados do vendedor + lookups/validacoes via BINDEVENT
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista) - regra #11
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
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
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

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
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

        *-- Container BotoesAcao (Grupo_Salva no legado)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 0
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Grupo_Salva.Salva no legado)
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

        *-- Botao Cancelar (Grupo_Salva.Cancelar no legado)
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

        *-- Codigo: Say7.Top=124+29=153, getcodigo.Top=121+29=150 (legado: When retorna .F. - nunca recebe foco)
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "C" + CHR(243) + "digo : "
            .Top       = 153
            .Left      = 325
            .Width     = 47
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 150
            .Left          = 372
            .Width         = 160
            .Height        = 24
            .MaxLength     = 20
            .Enabled       = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Loja/Empresa: Say1.Top=151+29=180, getEmps.Top=148+29=177 (editavel so em INCLUIR)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Cod Loja : "
            .Top       = 180
            .Left      = 316
            .Width     = 56
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPagina.txt_4c_Emps
            .Value         = ""
            .Top           = 177
            .Left          = 372
            .Width         = 33
            .Height        = 24
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        *-- Lookup/validacao: LostFocus busca UF em SigcdEmp + fAcessoEmpresa (regra #27, VerificarAcessoEmpresa)
        BINDEVENT(loc_oPagina.txt_4c_Emps, "KeyPress", THIS, "ValidarEmpsDados")

        *-- Empresa Registro: Say12.Top=152+29=181, GetEmpReg.Top=148+29=177 (readonly, preenchido via pegaempreg)
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "Empresa Registro :"
            .Top       = 181
            .Left      = 590
            .Width     = 95
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_EmpReg", "TextBox")
        WITH loc_oPagina.txt_4c_EmpReg
            .Value         = ""
            .Top           = 177
            .Left          = 685
            .Width         = 33
            .Height        = 24
            .MaxLength     = 3
            .Enabled       = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Estado: Say3.Top=178+29=207, GetUfs.Top=175+29=204 (readonly, preenchido via lookup de Emps)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Estado : "
            .Top       = 207
            .Left      = 325
            .Width     = 47
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ufs", "TextBox")
        WITH loc_oPagina.txt_4c_Ufs
            .Value         = ""
            .Top           = 204
            .Left          = 372
            .Width         = 33
            .Height        = 24
            .MaxLength     = 2
            .Enabled       = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Grupo Vendedor: Say8.Top=205+29=234, getGrupo.Top=202+29=231 (readonly, legado: When retorna .F.)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Grupo Vendedor :"
            .Top       = 234
            .Left      = 280
            .Width     = 92
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value         = ""
            .Top           = 231
            .Left          = 372
            .Width         = 94
            .Height        = 24
            .MaxLength     = 10
            .Enabled       = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Cod Vendedor: Say2.Top=232+29=261, GetVens.Top=229+29=258 (editavel so em INCLUIR) + GetdVens (descricao, readonly)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Cod Vendedor :"
            .Top       = 261
            .Left      = 290
            .Width     = 82
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Vens", "TextBox")
        WITH loc_oPagina.txt_4c_Vens
            .Value         = ""
            .Top           = 258
            .Left          = 372
            .Width         = 94
            .Height        = 24
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DVens", "TextBox")
        WITH loc_oPagina.txt_4c_DVens
            .Value         = ""
            .Top           = 258
            .Left          = 468
            .Width         = 250
            .Height        = 24
            .MaxLength     = 50
            .Enabled       = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        *-- Lookup/validacao: fAcessoContas 'C'/'D' (portada em utils\functions.prg) + pegaempreg (so no Cod Vendedor)
        BINDEVENT(loc_oPagina.txt_4c_Vens,  "KeyPress", THIS, "ValidarVensDados")
        BINDEVENT(loc_oPagina.txt_4c_DVens, "KeyPress", THIS, "ValidarDVensDados")

        *-- Data Inicial: Say5.Top=259+29=288, getDtini.Top=256+29=285 (editavel em INCLUIR/ALTERAR)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Data Inicial :"
            .Top       = 288
            .Left      = 305
            .Width     = 67
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dtini", "TextBox")
        WITH loc_oPagina.txt_4c_Dtini
            .Value         = {}
            .Top           = 285
            .Left          = 372
            .Width         = 94
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Data Final: Say6.Top=286+29=315, GetDtfin.Top=283+29=312 (editavel em INCLUIR/ALTERAR)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Data Final :"
            .Top       = 315
            .Left      = 310
            .Width     = 62
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dtfin", "TextBox")
        WITH loc_oPagina.txt_4c_Dtfin
            .Value         = {}
            .Top           = 312
            .Left          = 372
            .Width         = 94
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Situacao: Say4.Top=313+29=342, CmbSituas.Top=310+29=339 (RowSource EXATO do legado)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o : "
            .Top       = 342
            .Left      = 317
            .Width     = 55
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("cbo_4c_CmbSituas", "ComboBox")
        WITH loc_oPagina.cbo_4c_CmbSituas
            .RowSourceType = 1
            .RowSource     = "ATIVO,AFASTADO POR ACIDENTE,AFASTADO POR DOENCA,AFASTADO POR MATERNIDADE,DEMITIDO,FERIAS,TREINAMENTO,FOLGA"
            .Value         = ""
            .Top           = 339
            .Left          = 372
            .Width         = 160
            .Height        = 24
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        *-- Validacao: FOLGA exige fChecaAcesso ou usuario/vendedor na mesma empresa (transcrito do legado)
        BINDEVENT(loc_oPagina.cbo_4c_CmbSituas, "KeyPress", THIS, "ValidarSituacao")

        *-- Cargo: Say9.Top=340+29=369, cmbCargo.Top=337+29=366 (RowSource EXATO do legado)
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "Cargo : "
            .Top       = 369
            .Left      = 329
            .Width     = 43
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("cbo_4c_CmbCargo", "ComboBox")
        WITH loc_oPagina.cbo_4c_CmbCargo
            .RowSourceType = 1
            .RowSource     = "GERENTE,VENDEDOR"
            .Value         = ""
            .Top           = 366
            .Left          = 372
            .Width         = 160
            .Height        = 24
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Comissao %: Say10.Top=369+29=398, getpdes.Top=364+29=393 (InputMask EXATO do legado)
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "Comiss" + CHR(227) + "o % : "
            .Top       = 398
            .Left      = 299
            .Width     = 73
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Comis", "TextBox")
        WITH loc_oPagina.txt_4c_Comis
            .Value         = 0
            .Top           = 393
            .Left          = 372
            .Width         = 94
            .Height        = 24
            .InputMask     = "999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Subsidio %: Say11.Top=396+29=425, getSubsidio.Top=391+29=420 (InputMask EXATO do legado)
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "Subs" + CHR(237) + "dio % : "
            .Top       = 425
            .Left      = 305
            .Width     = 67
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Subsidio", "TextBox")
        WITH loc_oPagina.txt_4c_Subsidio
            .Value         = 0
            .Top           = 420
            .Left          = 372
            .Width         = 94
            .Height        = 24
            .InputMask     = "999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Meta %: Say13.Top=423+29=452, getpmeta.Top=418+29=447 (InputMask EXATO do legado)
        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "Meta % : "
            .Top       = 452
            .Left      = 320
            .Width     = 52
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Pmeta", "TextBox")
        WITH loc_oPagina.txt_4c_Pmeta
            .Value         = 0
            .Top           = 447
            .Left          = 372
            .Width         = 94
            .Height        = 24
            .InputMask     = "999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega cursor_4c_Dados via VENBO.Buscar() e configura o Grid
    * Colunas espelham o legado (Init: AddCursor + pColuna x11)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- PROBLEMA 48: ColumnCount/RecordSource ANTES de ControlSource (FORA do WITH - Problema 36)
                loc_oGrid.ColumnCount  = 11
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
                loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codvens"
                loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.nome"
                loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.emps"
                loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.empreg"
                loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.gruvens"
                loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.dtini"
                loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.dtfin"
                loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.situas"
                loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.cargo"
                loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.usualts"
                loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.dtalts"

                *-- Larguras EXATAS do legado (Init: pColuna(...,largura,...))
                loc_oGrid.Column1.Width  = 75
                loc_oGrid.Column2.Width  = 150
                loc_oGrid.Column3.Width  = 75
                loc_oGrid.Column4.Width  = 75
                loc_oGrid.Column5.Width  = 75
                loc_oGrid.Column6.Width  = 75
                loc_oGrid.Column7.Width  = 75
                loc_oGrid.Column8.Width  = 75
                loc_oGrid.Column9.Width  = 75
                loc_oGrid.Column10.Width = 75
                loc_oGrid.Column11.Width = 75

                *-- PROBLEMA 2/32/40: Headers APOS RecordSource, captions EXATOS do legado
                loc_oGrid.Column1.Header1.Caption  = "Vendedor"
                loc_oGrid.Column2.Header1.Caption  = "Nome"
                loc_oGrid.Column3.Header1.Caption  = "Empresa"
                loc_oGrid.Column4.Header1.Caption  = "Emp Reg"
                loc_oGrid.Column5.Header1.Caption  = "Grupo"
                loc_oGrid.Column6.Header1.Caption  = "Dt In" + CHR(237) + "cio"
                loc_oGrid.Column7.Header1.Caption  = "Dt Final"
                loc_oGrid.Column8.Header1.Caption  = "Situa" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column9.Header1.Caption  = "Cargo"
                loc_oGrid.Column10.Header1.Caption = "Usu" + CHR(225) + "rio"
                loc_oGrid.Column11.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormVEN.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
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
                "FormVEN.AlternarPagina")
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
                "FormVEN.FormatarGridLista")
        ENDTRY
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
    * BtnIncluirClick - Abre Page2 para incluir novo registro
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
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
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre Page2 para alterar registro selecionado
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
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
    * BtnExcluirClick - Exclui registro selecionado com confirmacao
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para excluir.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do vendedor [" + loc_cCodigo + "]?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre picker para localizar registro na lista
    * Apos selecao, posiciona o cursor no registro encontrado
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdVen", "cursor_4c_BuscaVen", "codigo", "", ;
                "Buscar Vendedor")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigo",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("codvens", "", "Vendedor")
                loc_oBusca.mAddColuna("situas",  "", "Situa" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVen")
                    SELECT cursor_4c_BuscaVen
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaVen.codigo)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaVen")
                USE IN cursor_4c_BuscaVen
            ENDIF

            IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(codigo) == loc_cCodigo
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormVEN.BtnBuscarClick")
            IF USED("cursor_4c_BuscaVen")
                USE IN cursor_4c_BuscaVen
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao da Page2
    *
    * Campos SEMPRE readonly no legado (When retorna .F. / preenchidos por lookup):
    *   txt_4c_Codigo, txt_4c_Ufs, txt_4c_Grupo, txt_4c_EmpReg
    * txt_4c_DVens: editavel apenas quando txt_4c_Vens esta vazio (legado:
    *   When = Empty(Parent.GetVens.Value)) - permite busca por descricao
    * Campos editaveis SOMENTE em modo INCLUIR (When = INLIST(pcEscolha,'INSERIR')):
    *   txt_4c_Emps, txt_4c_Vens
    * Campos editaveis em INCLUIR e ALTERAR:
    *   txt_4c_Dtini, txt_4c_Dtfin, cbo_4c_CmbSituas, cbo_4c_CmbCargo,
    *   txt_4c_Comis, txt_4c_Subsidio, txt_4c_Pmeta
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Emps", 5)
            loc_oPagina.txt_4c_Emps.Enabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Vens", 5)
            loc_oPagina.txt_4c_Vens.Enabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_DVens", 5)
            loc_oPagina.txt_4c_DVens.Enabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR") ;
                AND EMPTY(ALLTRIM(loc_oPagina.txt_4c_Vens.Value))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Dtini", 5)
            loc_oPagina.txt_4c_Dtini.Enabled = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Dtfin", 5)
            loc_oPagina.txt_4c_Dtfin.Enabled = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        ENDIF

        IF PEMSTATUS(loc_oPagina, "cbo_4c_CmbSituas", 5)
            loc_oPagina.cbo_4c_CmbSituas.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPagina, "cbo_4c_CmbCargo", 5)
            loc_oPagina.cbo_4c_CmbCargo.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Comis", 5)
            loc_oPagina.txt_4c_Comis.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Subsidio", 5)
            loc_oPagina.txt_4c_Subsidio.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Pmeta", 5)
            loc_oPagina.txt_4c_Pmeta.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
    * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEditando
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
            ENDIF
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos campos da Page2 para o BusinessObject
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina, loc_oBO
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oBO     = THIS.this_oBusinessObject

        loc_oBO.this_cEmps     = ALLTRIM(loc_oPagina.txt_4c_Emps.Value)
        loc_oBO.this_cUfs      = ALLTRIM(loc_oPagina.txt_4c_Ufs.Value)
        loc_oBO.this_cGrupo    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        loc_oBO.this_cCodVens  = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)
        loc_oBO.this_dDtIni    = loc_oPagina.txt_4c_Dtini.Value
        loc_oBO.this_dDtFin    = loc_oPagina.txt_4c_Dtfin.Value
        loc_oBO.this_cSituas   = ALLTRIM(loc_oPagina.cbo_4c_CmbSituas.Value)
        loc_oBO.this_cCargo    = ALLTRIM(loc_oPagina.cbo_4c_CmbCargo.Value)
        loc_oBO.this_nComis    = loc_oPagina.txt_4c_Comis.Value
        loc_oBO.this_nSubsidio = loc_oPagina.txt_4c_Subsidio.Value
        loc_oBO.this_nPmeta    = loc_oPagina.txt_4c_Pmeta.Value
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do BusinessObject para os campos da Page2
    * Reconstroi a descricao do vendedor (SigCdCli.Rclis) e a empresa de
    * registro (THIS.PegaEmpReg), equivalentes ao CrTmpCli/pegaempreg do legado
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_oBO
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oBO     = THIS.this_oBusinessObject

        loc_oPagina.txt_4c_Codigo.Value    = loc_oBO.this_cCodigo
        loc_oPagina.txt_4c_Emps.Value      = loc_oBO.this_cEmps
        loc_oPagina.txt_4c_Ufs.Value       = loc_oBO.this_cUfs
        loc_oPagina.txt_4c_Grupo.Value     = loc_oBO.this_cGrupo
        loc_oPagina.txt_4c_Vens.Value      = loc_oBO.this_cCodVens
        loc_oPagina.txt_4c_Dtini.Value     = loc_oBO.this_dDtIni
        loc_oPagina.txt_4c_Dtfin.Value     = loc_oBO.this_dDtFin
        loc_oPagina.cbo_4c_CmbSituas.Value = loc_oBO.this_cSituas
        loc_oPagina.cbo_4c_CmbCargo.Value  = loc_oBO.this_cCargo
        loc_oPagina.txt_4c_Comis.Value     = loc_oBO.this_nComis
        loc_oPagina.txt_4c_Subsidio.Value  = loc_oBO.this_nSubsidio
        loc_oPagina.txt_4c_Pmeta.Value     = loc_oBO.this_nPmeta

        THIS.this_cUltimoEmpsValidado     = ALLTRIM(loc_oBO.this_cEmps)
        THIS.this_cUltimoVensValidado     = ALLTRIM(loc_oBO.this_cCodVens)
        THIS.this_cUltimaSituacaoValidada = ALLTRIM(loc_oBO.this_cSituas)

        *-- Descricao do vendedor (CrTmpCli.Rclis no legado: Grupo_op.Click)
        loc_oPagina.txt_4c_DVens.Value = ""
        IF !EMPTY(ALLTRIM(loc_oBO.this_cCodVens))
            IF USED("cursor_4c_DescVen")
                USE IN cursor_4c_DescVen
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_oBO.this_cCodVens) + ;
                    " AND Grupos = " + EscaparSQL(loc_oBO.this_cGrupo), "cursor_4c_DescVen") >= 1
                IF RECCOUNT("cursor_4c_DescVen") > 0
                    loc_oPagina.txt_4c_DVens.Value = TratarNulo(cursor_4c_DescVen.Rclis, "")
                ENDIF
            ENDIF
            IF USED("cursor_4c_DescVen")
                USE IN cursor_4c_DescVen
            ENDIF
        ENDIF
        THIS.this_cUltimoDVensValidado = ALLTRIM(loc_oPagina.txt_4c_DVens.Value)

        THIS.PegaEmpReg()
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa campos da Page2 para novo registro (modo INCLUIR)
    * Preenche txt_4c_Grupo com o grupo padrao (SigCdPam.GrPadVens), igual ao
    * legado (Init/Grupo_op.Click: thisform.pagina.dados.getGrupo.value = crSigCdPam.GrPadVens)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value    = ""
        loc_oPagina.txt_4c_Emps.Value      = ""
        loc_oPagina.txt_4c_EmpReg.Value    = ""
        loc_oPagina.txt_4c_Ufs.Value       = ""
        loc_oPagina.txt_4c_Grupo.Value     = ""
        loc_oPagina.txt_4c_Vens.Value      = ""
        loc_oPagina.txt_4c_DVens.Value     = ""
        loc_oPagina.txt_4c_Dtini.Value     = {}
        loc_oPagina.txt_4c_Dtfin.Value     = {}
        loc_oPagina.cbo_4c_CmbSituas.Value = ""
        loc_oPagina.cbo_4c_CmbCargo.Value  = ""
        loc_oPagina.txt_4c_Comis.Value     = 0
        loc_oPagina.txt_4c_Subsidio.Value  = 0
        loc_oPagina.txt_4c_Pmeta.Value     = 0

        THIS.this_cUltimoEmpsValidado     = ""
        THIS.this_cUltimoVensValidado     = ""
        THIS.this_cUltimoDVensValidado    = ""
        THIS.this_cUltimaSituacaoValidada = ""

        IF USED("cursor_4c_ParamGrupo")
            USE IN cursor_4c_ParamGrupo
        ENDIF
        IF SQLEXEC(gnConnHandle, "SELECT GrPadVens FROM SigCdPam", "cursor_4c_ParamGrupo") >= 1
            IF RECCOUNT("cursor_4c_ParamGrupo") > 0
                loc_oPagina.txt_4c_Grupo.Value = TratarNulo(cursor_4c_ParamGrupo.GrPadVens, "")
            ENDIF
        ENDIF
        IF USED("cursor_4c_ParamGrupo")
            USE IN cursor_4c_ParamGrupo
        ENDIF
    ENDPROC

    *===========================================================================
    * PegaEmpReg - Apresenta a empresa de registro do vendedor (SigCdCli)
    * Transcrito de PROCEDURE pegaempreg do legado
    *===========================================================================
    PROTECTED PROCEDURE PegaEmpReg()
        LOCAL loc_oPagina, loc_cGrupo, loc_cVens
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        loc_cVens   = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)

        IF EMPTY(loc_cGrupo) OR EMPTY(loc_cVens)
            loc_oPagina.txt_4c_EmpReg.Value = ""
        ELSE
            IF USED("cursor_4c_AuxCli")
                USE IN cursor_4c_AuxCli
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT emps FROM SigCdCli WHERE grupos = " + EscaparSQL(loc_cGrupo) + ;
                    " AND iclis = " + EscaparSQL(loc_cVens), "cursor_4c_AuxCli") >= 1
                IF RECCOUNT("cursor_4c_AuxCli") > 0
                    loc_oPagina.txt_4c_EmpReg.Value = TratarNulo(cursor_4c_AuxCli.emps, "")
                ELSE
                    loc_oPagina.txt_4c_EmpReg.Value = ""
                ENDIF
            ENDIF
            IF USED("cursor_4c_AuxCli")
                USE IN cursor_4c_AuxCli
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarEmpsDados - LostFocus de txt_4c_Emps (Page2)
    * Legado: LostFocus busca UF em SigcdEmp; Valid chama fAcessoEmpresa
    * (nao portada - regra #27 - substituida por VerificarAcessoEmpresa, que
    * so faz o CHECK de acesso, sem popular textbox)
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE ValidarEmpsDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cEmp
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cEmp    = ALLTRIM(loc_oPagina.txt_4c_Emps.Value)

        IF loc_cEmp == THIS.this_cUltimoEmpsValidado
            RETURN
        ENDIF
        THIS.this_cUltimoEmpsValidado = loc_cEmp

        IF EMPTY(loc_cEmp)
            loc_oPagina.txt_4c_Ufs.Value = ""
            RETURN
        ENDIF

        IF USED("cursor_4c_LocalEmp")
            USE IN cursor_4c_LocalEmp
        ENDIF
        IF SQLEXEC(gnConnHandle, "SELECT * FROM SigcdEmp WHERE cemps = " + EscaparSQL(loc_cEmp), "cursor_4c_LocalEmp") < 1
            MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o com Servidor de Banco de Dados.", "Erro")
        ELSE
            IF RECCOUNT("cursor_4c_LocalEmp") > 0
                loc_oPagina.txt_4c_Ufs.Value = TratarNulo(cursor_4c_LocalEmp.estas, "")
            ELSE
                loc_oPagina.txt_4c_Ufs.Value = ""
            ENDIF
        ENDIF
        IF USED("cursor_4c_LocalEmp")
            USE IN cursor_4c_LocalEmp
        ENDIF

        IF !VerificarAcessoEmpresa(gc_4c_UsuarioLogado, loc_cEmp)
            MsgErro("Empresa Inv" + CHR(225) + "lida !!", "Erro")
            loc_oPagina.txt_4c_Emps.Value = ""
            loc_oPagina.txt_4c_Ufs.Value  = ""
            THIS.this_cUltimoEmpsValidado = ""
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarVensDados - LostFocus de txt_4c_Vens (Page2)
    * Legado: Valid chama fAcessoContas(Usuar,Grupo,'C',Value,This,getDVENS) e,
    * se autorizado, thisform.pegaempreg() (portado em utils\functions.prg)
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE ValidarVensDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cVens, loc_cGrupo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cVens   = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)

        IF loc_cVens == THIS.this_cUltimoVensValidado
            RETURN
        ENDIF
        THIS.this_cUltimoVensValidado = loc_cVens

        loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        IF EMPTY(loc_cVens)
            loc_oPagina.txt_4c_DVens.Value = ""
            THIS.this_cUltimoDVensValidado = ""
        ELSE
            IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cVens, loc_oPagina.txt_4c_Vens, loc_oPagina.txt_4c_DVens)
                MsgErro("Acesso Negado !!", "Erro")
                loc_oPagina.txt_4c_Vens.Value  = ""
                loc_oPagina.txt_4c_DVens.Value = ""
                THIS.this_cUltimoVensValidado  = ""
                THIS.this_cUltimoDVensValidado = ""
            ELSE
                THIS.this_cUltimoDVensValidado = ALLTRIM(loc_oPagina.txt_4c_DVens.Value)
                THIS.PegaEmpReg()
            ENDIF
        ENDIF

        loc_oPagina.txt_4c_DVens.Enabled = loc_oPagina.txt_4c_Vens.Enabled AND EMPTY(ALLTRIM(loc_oPagina.txt_4c_Vens.Value))
    ENDPROC

    *===========================================================================
    * ValidarDVensDados - LostFocus de txt_4c_DVens (Page2)
    * Legado: Valid chama fAcessoContas(Usuar,Grupo,'D',Value,getVens,This)
    * (busca por descricao, portado em utils\functions.prg)
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE ValidarDVensDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cDVens, loc_cGrupo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cDVens  = ALLTRIM(loc_oPagina.txt_4c_DVens.Value)

        IF loc_cDVens == THIS.this_cUltimoDVensValidado
            RETURN
        ENDIF
        THIS.this_cUltimoDVensValidado = loc_cDVens

        loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        IF EMPTY(loc_cDVens)
            loc_oPagina.txt_4c_Vens.Value = ""
            THIS.this_cUltimoVensValidado = ""
        ELSE
            IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_cDVens, loc_oPagina.txt_4c_Vens, loc_oPagina.txt_4c_DVens)
                MsgErro("Acesso Negado !!", "Erro")
                loc_oPagina.txt_4c_Vens.Value  = ""
                loc_oPagina.txt_4c_DVens.Value = ""
                THIS.this_cUltimoVensValidado  = ""
                THIS.this_cUltimoDVensValidado = ""
            ELSE
                THIS.this_cUltimoVensValidado = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)
                THIS.PegaEmpReg()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarSituacao - LostFocus de cbo_4c_CmbSituas (Page2)
    * Legado: so permite gravar situacao FOLGA quem tem acesso (fChecaAcesso)
    * ou se usuario logado eh da mesma empresa do vendedor (SigCdCli)
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE ValidarSituacao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cSituacao, loc_cCodVens, loc_cSQL
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_cSituacao = ALLTRIM(loc_oPagina.cbo_4c_CmbSituas.Value)

        IF loc_cSituacao == THIS.this_cUltimaSituacaoValidada
            RETURN
        ENDIF
        THIS.this_cUltimaSituacaoValidada = loc_cSituacao

        IF loc_cSituacao != "FOLGA"
            RETURN
        ENDIF

        IF fChecaAcesso("SIGCDVEN", "FOLGA")
            RETURN
        ENDIF

        loc_cCodVens = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)
        loc_cSQL = "SELECT emps FROM SigCdCli WHERE iclis = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
            " AND emps IN (SELECT emps FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCodVens) + ")"

        IF USED("cursor_4c_ChecaFolga")
            USE IN cursor_4c_ChecaFolga
        ENDIF

        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChecaFolga") < 1 OR RECCOUNT("cursor_4c_ChecaFolga") = 0
            MsgErro("Acesso Negado para definir situa" + CHR(231) + CHR(227) + "o FOLGA!", "Erro")
            loc_oPagina.cbo_4c_CmbSituas.Value = ""
            THIS.this_cUltimaSituacaoValidada  = ""
        ENDIF

        IF USED("cursor_4c_ChecaFolga")
            USE IN cursor_4c_ChecaFolga
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida e grava o registro (Confirmar)
    * Validacoes e verificacao de sobreposicao de periodo transcritas
    * LITERALMENTE do legado (Pagina.Dados.Grupo_Salva.Salva.Click) - regra #17
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cCheCod, loc_cDatI, loc_cDatF, loc_cQuery
        LOCAL loc_cCodVens, loc_cSituas, loc_dDtIni, loc_dDtFin, loc_cEmps
        LOCAL loc_cAnoMes, loc_cCodigoGerado, loc_lProsseguir
        loc_oPagina     = THIS.pgf_4c_Paginas.Page2
        loc_lProsseguir = .T.

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_cEmps    = ALLTRIM(loc_oPagina.txt_4c_Emps.Value)
            loc_cCodVens = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)
            loc_dDtIni   = loc_oPagina.txt_4c_Dtini.Value
            loc_dDtFin   = loc_oPagina.txt_4c_Dtfin.Value
            loc_cSituas  = ALLTRIM(loc_oPagina.cbo_4c_CmbSituas.Value)

            IF EMPTY(loc_cEmps)
                MsgErro("Empresa n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
                loc_oPagina.txt_4c_Emps.SetFocus
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND EMPTY(loc_cCodVens)
                MsgErro("Vendedor n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
                loc_oPagina.txt_4c_Emps.SetFocus
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND EMPTY(loc_dDtIni)
                MsgErro("Data Inicial n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
                loc_oPagina.txt_4c_Dtini.SetFocus
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND loc_cSituas != "ATIVO" AND EMPTY(loc_dDtFin)
                MsgErro("Data final n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
                loc_oPagina.txt_4c_Dtfin.SetFocus
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND EMPTY(loc_cSituas)
                MsgErro("Situa" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
                loc_oPagina.cbo_4c_CmbSituas.SetFocus
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !EMPTY(loc_dDtFin) AND loc_dDtIni > loc_dDtFin
                MsgErro("As datas est" + CHR(227) + "o incompat" + CHR(237) + "veis!", "Confirmar")
                loc_oPagina.txt_4c_Dtini.SetFocus
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                *-- Verifica sobreposicao de periodo para o mesmo vendedor (transcrito do legado)
                loc_cCheCod = ""
                IF THIS.this_cModoAtual = "ALTERAR"
                    loc_cCheCod = " AND codigo <> " + EscaparSQL(THIS.this_oBusinessObject.this_cCodigo)
                ENDIF

                loc_cDatI = SUBSTR(DTOS(loc_dDtIni), 1, 4) + "-" + SUBSTR(DTOS(loc_dDtIni), 5, 2) + "-" + SUBSTR(DTOS(loc_dDtIni), 7, 2)
                IF !EMPTY(loc_dDtFin)
                    loc_cDatF = SUBSTR(DTOS(loc_dDtFin), 1, 4) + "-" + SUBSTR(DTOS(loc_dDtFin), 5, 2) + "-" + SUBSTR(DTOS(loc_dDtFin), 7, 2)
                ELSE
                    loc_cDatF = loc_cDatI
                ENDIF

                IF loc_cSituas != "ATIVO"
                    loc_cQuery = "SELECT * FROM SigCdVen WHERE codvens = " + EscaparSQL(loc_cCodVens) + ;
                        " AND situas <> 'ATIVO'" + ;
                        " AND (" + EscaparSQL(loc_cDatI) + " BETWEEN LEFT(CONVERT(VARCHAR, dtini, 120), 10) AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                        " OR " + EscaparSQL(loc_cDatF) + " BETWEEN LEFT(CONVERT(VARCHAR, dtini, 120), 10) AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                        " OR LEFT(CONVERT(VARCHAR, dtini, 120), 10) BETWEEN " + EscaparSQL(loc_cDatI) + " AND " + EscaparSQL(loc_cDatF) + ;
                        " OR LEFT(CONVERT(VARCHAR, dtfin, 120), 10) BETWEEN " + EscaparSQL(loc_cDatI) + " AND " + EscaparSQL(loc_cDatF) + ")" + ;
                        loc_cCheCod
                ELSE
                    loc_cQuery = "SELECT * FROM SigCdVen WHERE codvens = " + EscaparSQL(loc_cCodVens) + ;
                        " AND situas = 'ATIVO'" + ;
                        " AND (" + EscaparSQL(loc_cDatI) + " BETWEEN LEFT(CONVERT(VARCHAR, dtini, 120), 10) AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                        " OR " + EscaparSQL(loc_cDatF) + " BETWEEN LEFT(CONVERT(VARCHAR, dtini, 120), 10) AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                        " OR LEFT(CONVERT(VARCHAR, dtini, 120), 10) BETWEEN " + EscaparSQL(loc_cDatI) + " AND " + EscaparSQL(loc_cDatF) + ;
                        " OR LEFT(CONVERT(VARCHAR, dtfin, 120), 10) BETWEEN " + EscaparSQL(loc_cDatI) + " AND " + EscaparSQL(loc_cDatF) + ;
                        " OR dtfin IS NULL)" + ;
                        loc_cCheCod
                ENDIF

                IF USED("cursor_4c_CheckPeriodo")
                    USE IN cursor_4c_CheckPeriodo
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_CheckPeriodo") < 1
                    MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o com Servidor de Banco de Dados.", "Erro")
                    loc_lProsseguir = .F.
                ELSE
                    IF RECCOUNT("cursor_4c_CheckPeriodo") > 0
                        MsgErro("Esse intervalo j" + CHR(225) + " est" + CHR(225) + " cadastrado para esse vendedor!", "Confirmar")
                        loc_oPagina.txt_4c_Dtini.SetFocus
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_CheckPeriodo")
                    USE IN cursor_4c_CheckPeriodo
                ENDIF
            ENDIF
        ENDIF

        IF loc_lProsseguir
            THIS.FormParaBO()

            IF THIS.this_cModoAtual = "INCLUIR"
                loc_cAnoMes = SUBSTR(ALLTRIM(STR(YEAR(DATE()))), 3) + PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")
                loc_cCodigoGerado = ALLTRIM(THIS.this_oBusinessObject.this_cCodVens) + loc_cAnoMes + ;
                    PADL(ALLTRIM(STR(fGerUniqueKey(ALLTRIM(THIS.this_oBusinessObject.this_cCodVens) + loc_cAnoMes))), 5, "0")
                THIS.this_oBusinessObject.this_cCodigo = loc_cCodigoGerado
            ENDIF

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Confirmar")
                THIS.AlternarPagina(1)
            ELSE
                IF !THIS.this_oBusinessObject.this_lErroExibido
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para a lista (Cancelar)
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos do formulario
    *===========================================================================
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

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\VENBO.prg):
*====================================================================
* VENBO.prg
*
* Business Object para Vendedores
* Tabela principal: SigCdVen (codigo PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS VENBO AS BusinessBase

	*-- Propriedades da entidade (SigCdVen)
	this_cCodigo    = ""   && codigo char(20)      - PK (codigo do vendedor)
	this_cEmps      = ""   && emps char(3)         - codigo da empresa/loja
	this_cGrupo     = ""   && gruvens char(10)     - grupo do vendedor
	this_cCodVens   = ""   && codvens char(10)     - codigo do vendedor (cliente)
	this_cNomeVen   = ""   && nomeven varchar(255) - nome do vendedor
	this_cUfs       = ""   && ufs char(2)          - estado
	this_dDtIni     = {}   && dtini datetime       - data inicial (NULL)
	this_dDtFin     = {}   && dtfin datetime       - data final (NULL)
	this_cSituas    = ""   && situas char(30)      - situacao
	this_cCargo     = ""   && cargo char(15)       - cargo
	this_nComis     = 0    && comis numeric(7,4)   - comissao %
	this_nSubsidio  = 0    && subsidio numeric(7,4) - subsidio %
	this_nPmeta     = 0    && pmeta numeric(7,4)   - meta %
	this_cFolga     = ""   && folga char(1)        - folga (S/N) - NOT NULL, sem campo na tela
	this_dDtAlts    = {}   && dtalts datetime      - data da ultima alteracao (NULL)
	this_cUsuAlts   = ""   && usualts char(10)     - usuario da ultima alteracao

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdVen"
			THIS.this_cCampoChave = "codigo"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "VENBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCodigo)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCodigo   = TratarNulo(codigo,   "")
				THIS.this_cEmps     = TratarNulo(emps,     "")
				THIS.this_cGrupo    = TratarNulo(gruvens,  "")
				THIS.this_cCodVens  = TratarNulo(codvens,  "")
				THIS.this_cNomeVen  = TratarNulo(nomeven,  "")
				THIS.this_cUfs      = TratarNulo(ufs,      "")
				THIS.this_dDtIni    = TratarNulo(dtini,    {})
				THIS.this_dDtFin    = TratarNulo(dtfin,    {})
				THIS.this_cSituas   = TratarNulo(situas,   "")
				THIS.this_cCargo    = TratarNulo(cargo,    "")
				THIS.this_nComis    = TratarNulo(comis,    0)
				THIS.this_nSubsidio = TratarNulo(subsidio, 0)
				THIS.this_nPmeta    = TratarNulo(pmeta,    0)
				THIS.this_cFolga    = TratarNulo(folga,    "")
				THIS.this_dDtAlts   = TratarNulo(dtalts,   {})
				THIS.this_cUsuAlts  = TratarNulo(usualts,  "")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "VENBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdVen
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigCdVen (codigo, emps, gruvens, codvens, nomeven, ufs,
					dtini, dtfin, situas, cargo, comis, subsidio, pmeta, folga,
					dtalts, usualts)
				VALUES (
					<<EscaparSQL(THIS.this_cCodigo)>>,
					<<EscaparSQL(THIS.this_cEmps)>>,
					<<EscaparSQL(THIS.this_cGrupo)>>,
					<<EscaparSQL(THIS.this_cCodVens)>>,
					<<EscaparSQL(THIS.this_cNomeVen)>>,
					<<EscaparSQL(THIS.this_cUfs)>>,
					<<FormatarDataSQL(THIS.this_dDtIni)>>,
					<<FormatarDataSQL(THIS.this_dDtFin)>>,
					<<EscaparSQL(THIS.this_cSituas)>>,
					<<EscaparSQL(THIS.this_cCargo)>>,
					<<FormatarNumeroSQL(THIS.this_nComis, 4)>>,
					<<FormatarNumeroSQL(THIS.this_nSubsidio, 4)>>,
					<<FormatarNumeroSQL(THIS.this_nPmeta, 4)>>,
					<<EscaparSQL(THIS.this_cFolga)>>,
					GETDATE(),
					<<EscaparSQL(gc_4c_UsuarioLogado)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "VENBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdVen
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdVen
				SET emps     = <<EscaparSQL(THIS.this_cEmps)>>,
					gruvens  = <<EscaparSQL(THIS.this_cGrupo)>>,
					codvens  = <<EscaparSQL(THIS.this_cCodVens)>>,
					nomeven  = <<EscaparSQL(THIS.this_cNomeVen)>>,
					ufs      = <<EscaparSQL(THIS.this_cUfs)>>,
					dtini    = <<FormatarDataSQL(THIS.this_dDtIni)>>,
					dtfin    = <<FormatarDataSQL(THIS.this_dDtFin)>>,
					situas   = <<EscaparSQL(THIS.this_cSituas)>>,
					cargo    = <<EscaparSQL(THIS.this_cCargo)>>,
					comis    = <<FormatarNumeroSQL(THIS.this_nComis, 4)>>,
					subsidio = <<FormatarNumeroSQL(THIS.this_nSubsidio, 4)>>,
					pmeta    = <<FormatarNumeroSQL(THIS.this_nPmeta, 4)>>,
					dtalts   = GETDATE(),
					usualts  = <<EscaparSQL(gc_4c_UsuarioLogado)>>
				WHERE codigo = <<EscaparSQL(THIS.this_cCodigo)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "VENBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro da tabela SigCdVen
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdVen WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao excluir vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "VENBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados espelhando as colunas do Grade legado
	* (Init: AddCursor lcQrycdVen + pColuna x11):
	* codigo, codvens, nome (SigCdUsu.ncomps), emps, empreg (SigCdCli.emps),
	* gruvens, dtini, dtfin, situas, cargo, usualts, dtalts
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (codigo C(20), codvens C(10), ;
						nome C(30), emps C(3), empreg C(3), gruvens C(10), ;
						dtini T, dtfin T, situas C(30), cargo C(15), ;
						usualts C(10), dtalts T)
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT a.codigo, a.codvens, ISNULL(b.ncomps,'') AS nome," + ;
					" a.emps, c.emps AS empreg, a.gruvens, a.dtini, a.dtfin," + ;
					" a.situas, a.cargo, a.usualts, a.dtalts" + ;
					" FROM SigCdVen a" + ;
					" LEFT JOIN SigCdUsu b ON a.codvens = b.usuarios" + ;
					" LEFT JOIN SigCdCli c ON a.gruvens = c.grupos AND a.codvens = c.iclis"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY a.codigo"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MostrarErro("Erro ao buscar vendedores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "VENBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (codigo)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigo, emps, gruvens, codvens, nomeven, ufs," + ;
				" dtini, dtfin, situas, cargo, comis, subsidio, pmeta, folga," + ;
				" dtalts, usualts" + ;
				" FROM SigCdVen WHERE codigo = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Vendedor n" + CHR(227) + "o encontrado!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "VENBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

