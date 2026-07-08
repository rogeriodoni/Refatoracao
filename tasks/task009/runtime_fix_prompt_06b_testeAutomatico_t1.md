# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 421; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 551

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-04-11 04:48:37] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-11 04:48:37] [INFO] Config FPW: (nao fornecido)
[2026-04-11 04:48:37] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-11 04:48:37] [INFO] Timeout: 300 segundos
[2026-04-11 04:48:37] [INFO] Wrapper PRG criado para parametros: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_zm4adaou.prg
[2026-04-11 04:48:37] [INFO] Conteudo do wrapper:
[2026-04-11 04:48:37] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigmvccr', 'C:\4c\tasks\task009', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigmvccr', 'C:\4c\tasks\task009', 'CRUD'
QUIT

[2026-04-11 04:48:37] [INFO] Comando VFP: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_zm4adaou.prg
[2026-04-11 04:48:37] [INFO] VFP output esperado em: C:\4c\tasks\task009\vfp_output.txt
[2026-04-11 04:48:37] [INFO] Executando Visual FoxPro 9...
[2026-04-11 04:48:37] [INFO] Comando completo: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_zm4adaou.prg
[2026-04-11 04:48:37] [INFO] Executando: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_zm4adaou.prg
[2026-04-11 04:48:37] [INFO] Timeout configurado: 300 segundos
[2026-04-11 04:48:38] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-11 04:48:38] [INFO] VFP9 finalizado em 1.4414127 segundos
[2026-04-11 04:48:38] [INFO] Exit Code: 
[2026-04-11 04:48:38] [INFO] 
[2026-04-11 04:48:38] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-11 04:48:38] [INFO]   Wrapper.prg: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_zm4adaou.prg
[2026-04-11 04:48:38] [INFO] 
[2026-04-11 04:48:38] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-11 04:48:38] [INFO] * Auto-generated wrapper for parameters
[2026-04-11 04:48:38] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-11 04:48:38] [INFO] * Parameters: 'Formsigmvccr', 'C:\4c\tasks\task009', 'CRUD'
[2026-04-11 04:48:38] [INFO] 
[2026-04-11 04:48:38] [INFO] * Anti-dialog protections for unattended execution
[2026-04-11 04:48:38] [INFO] SET SAFETY OFF
[2026-04-11 04:48:38] [INFO] SET RESOURCE OFF
[2026-04-11 04:48:39] [INFO] SET TALK OFF
[2026-04-11 04:48:39] [INFO] SET NOTIFY OFF
[2026-04-11 04:48:39] [INFO] SYS(2335, 0)
[2026-04-11 04:48:39] [INFO] 
[2026-04-11 04:48:39] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigmvccr', 'C:\4c\tasks\task009', 'CRUD'
[2026-04-11 04:48:39] [INFO] QUIT
[2026-04-11 04:48:39] [INFO] 
[2026-04-11 04:48:39] [INFO] === Fim do Wrapper.prg ===
[2026-04-11 04:48:39] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigmvccr",
  "timestamp": "20260411044838",
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
      "passou": false,
      "erro": "Property ALTERNARPAGINA is not found.",
      "detalhes": "Linha: 421"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 551"
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
      "detalhes": "AbrirLookup: 7 (ABRIRLOOKUPCONTA, ABRIRLOOKUPGRUPO, ABRIRLOOKUPJOB, ABRIRLOOKUPMOEDA, ABRIRLOOKUPSCONTA, ABRIRLOOKUPSGRUPO, ABRIRLOOKUPSMOEDA) | KeyPress handlers: 12 (CONTAKEYPRESS, DTFINALKEYPRESS, DTINICIALKEYPRESS, GRUPOKEYPRESS, JOBKEYPRESS, KEYPRESS, MOEDAKEYPRESS, OPERKEYPRESS, SCONTAKEYPRESS, SGRUPOKEYPRESS, SMOEDAKEYPRESS, VALORKEYPRESS)"
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
    "passou": 7,
    "falhou": 2,
    "percentual": 78
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg):
*==============================================================================
* Formsigmvccr.prg - Formulario de Conta Corrente Geral
* Data: 2026-04-11
* Tabela: SigMvCcr | PK: cidchaves
* Legado: SIGMVCCR.SCX (frmcadastro)
*
* FASE 8/8 - Formulario completo com grid, lookups, validacoes e todos os campos
*==============================================================================

DEFINE CLASS Formsigmvccr AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 600
    Width        = 1000
    Caption      = "Conta Corrente Geral"
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""    && OBRIGATORIO - nao herdado de FormBase

    *--------------------------------------------------------------------------
    * Init - Inicializacao do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigmvccrBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar sigmvccrBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                *-- Cursor placeholder para grid (evita erros antes do primeiro load)
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (cidchaves C(20), nopers N(10,0), opers C(1), ;
                         datas T, contas C(10), scontas C(10), ;
                         hists C(50), hist2s C(50), valors N(15,2), ;
                         svalors N(15,2), nfs C(15), docus C(20), ;
                         grupos C(10), sgrupos C(10), moedas C(3), ;
                         smoedas C(3), concs L, emps C(3), ;
                         vencs T, cotacaos N(15,7), scotacaos N(15,7), ;
                         contapgs N(1,0), jobs C(10), dtemis T, ;
                         sopers C(1), tipos C(1))
                    SET NULL OFF
                ENDIF

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Data inicial = hoje
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_inicial.Value = DATE()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_final.Value   = DATE()

                IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formsigmvccr:" + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                        loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria e configura PageFrame principal
    * Legado: Pagina.Width=1003, Top=-29 para ocultar abas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 600
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption  = "Lista"
            .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption  = "Dados"
            .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (lista com grid e filtros)
    * Compensacao +29 aplicada a todos os controles
    * Grid: Top=115+29=144, Left=23, Width=944, Height=473
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrade
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho (cntSombra: Top=1+29=30)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = -1
            .Width       = 1100
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Conta Corrente Geral"
            .Top       = 20
            .Left      = 20
            .Width     = 400
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Botoes CRUD (Grupo_op: Left=467, Top=-1+29=28)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        = 467
            .Width       = 385
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 155
            .Top             = 5
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 230
            .Top             = 5
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 305
            .Top             = 5
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Botao Sair (Grupo_Saida: Left=917, Top=-1+29=28)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 28
            .Left        = 917
            .Width       = 85
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Botao Movimento/Anexa (Anexa: Left=847, Top=4+29=33)
        loc_oPagina.AddObject("shp_4c_ShpAnexa", "Shape")
        WITH loc_oPagina.shp_4c_ShpAnexa
            .Top         = 36
            .Left        = 760
            .Width       = 55
            .Height      = 6
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .F.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_Anexa", "CommandButton")
        WITH loc_oPagina.cmd_4c_Anexa
            .Caption         = "Movimento"
            .Top             = 33
            .Left            = 847
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_60.jpg"
            .PicturePosition = 13
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .ToolTipText     = "[F7] Documento"
            .Themes          = .F.
            .Visible         = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Anexa, "Click", THIS, "BtnAnexaClick")

        *-- Filtro de periodo (cntFiltros: Top=83+29=112, Left=5, Width=642, Height=29)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 112
            .Left        = 5
            .Width       = 642
            .Height      = 29
            .BackStyle   = 0
            .BorderWidth = 0
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Sub-container Cnt_periodo (Top=-3 relativo ao cntFiltros, Left=14)
        loc_oPagina.cnt_4c_Filtros.AddObject("cnt_4c_Periodo", "Container")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo
            .Top         = -3
            .Left        = 14
            .Width       = 271
            .Height      = 36
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.lbl_4c_LblPeriodo
            .Caption   = "Per" + CHR(237) + "odo : "
            .Left      = 17
            .Top       = 10
            .Width     = 54
            .Height    = 15
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("txt_4c_Dt_inicial", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_inicial
            .Value         = DATE()
            .Left          = 73
            .Top           = 6
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "E"
            .InputMask     = "99/99/9999"
            .SpecialEffect = 1
            .Alignment     = 3
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_inicial, "KeyPress", THIS, "DtInicialKeyPress")

        loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("lbl_4c_LblAte", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.lbl_4c_LblAte
            .Caption   = "at" + CHR(233)
            .Left      = 158
            .Top       = 10
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("txt_4c_Dt_final", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_final
            .Value         = DATE()
            .Left          = 184
            .Top           = 6
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "E"
            .InputMask     = "99/99/9999"
            .SpecialEffect = 1
            .Alignment     = 3
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_final, "KeyPress", THIS, "DtFinalKeyPress")

        *-- Grid de lista (Grade: Top=115+29=144, Left=23, Width=944, Height=473)
        *-- Colunas em ORDEM VISUAL (sem ColumnOrder):
        *-- 1=Data(78) 2=O(17) 3=Conta(83) 4=Contra(83) 5=Hist(280)
        *-- 6=Debito(80) 7=" "(28) 8=Credito(80) 9="  "(28) 10=NF(78) 11=Doc(78)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrade = loc_oPagina.grd_4c_Lista

        loc_oGrade.Top               = 144
        loc_oGrade.Left              = 23
        loc_oGrade.Width             = 944
        loc_oGrade.Height            = 473
        loc_oGrade.FontName          = "Verdana"
        loc_oGrade.FontSize          = 8
        loc_oGrade.ReadOnly          = .T.
        loc_oGrade.DeleteMark        = .F.
        loc_oGrade.RecordMark        = .F.
        loc_oGrade.ScrollBars        = 3
        loc_oGrade.GridLines         = 3
        loc_oGrade.GridLineColor     = RGB(238, 238, 238)
        loc_oGrade.AllowHeaderSizing = .T.
        loc_oGrade.Visible           = .T.
        loc_oGrade.ColumnCount       = 11

        *-- Column1: Data (Width=78, Alignment=2)
        WITH loc_oGrade.Column1
            .Width     = 78
            .Alignment = 2
            .FontName  = "Verdana"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = "Data"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Column2: O - Oper (Width=17, Alignment=2)
        WITH loc_oGrade.Column2
            .Width     = 17
            .Alignment = 2
            .FontName  = "Verdana"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = "O"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Column3: Conta (Width=83)
        WITH loc_oGrade.Column3
            .Width     = 83
            .FontName  = "Verdana"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = "Conta"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Column4: Contrapartida (Width=83)
        WITH loc_oGrade.Column4
            .Width     = 83
            .FontName  = "Verdana"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = "Contrapartida"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Column5: Historico (Width=280, FontSize=7)
        WITH loc_oGrade.Column5
            .Width     = 280
            .FontName  = "Verdana"
            .FontSize  = 7
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = "Hist" + CHR(243) + "rico"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Column6: Debito (Width=80, InputMask)
        WITH loc_oGrade.Column6
            .Width     = 80
            .FontName  = "Verdana"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .InputMask = "999,999,999.99"
            .Header1.Caption   = "D" + CHR(233) + "bito"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Column7: Moedas (Width=28, header="")
        WITH loc_oGrade.Column7
            .Width     = 28
            .FontName  = "Verdana"
            .FontSize  = 7
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = ""
            .Header1.FontName  = "Tahoma"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Column8: Credito (Width=80, InputMask)
        WITH loc_oGrade.Column8
            .Width     = 80
            .FontName  = "Verdana"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .InputMask = "999,999,999.99"
            .Header1.Caption   = "Cr" + CHR(233) + "dito"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Column9: SMoedas (Width=28, header="")
        WITH loc_oGrade.Column9
            .Width     = 28
            .FontName  = "Verdana"
            .FontSize  = 7
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = ""
            .Header1.FontName  = "Tahoma"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Column10: NF (Width=78)
        WITH loc_oGrade.Column10
            .Width     = 78
            .FontName  = "Verdana"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = "NF"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Column11: Documento (Width=78)
        WITH loc_oGrade.Column11
            .Width     = 78
            .FontName  = "Verdana"
            .FontSize  = 8
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .Header1.Caption   = "Documento"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(90, 90, 90)
        ENDWITH

        BINDEVENT(loc_oGrade, "AfterRowColChange", THIS, "GradeAfterRowColChange")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (edicao de movimentos)
    * Compensacao +29 em TODOS os controles (Top_original + 29)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Botoes Salvar/Cancelar (Grupo_Salva: Left=842, Top=-4+29=25)
        loc_oPagina.AddObject("cnt_4c_Salvar", "Container")
        WITH loc_oPagina.cnt_4c_Salvar
            .Top         = 25
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oPagina.cnt_4c_Salvar.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salvar.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 6
            .Top             = 5
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Salvar.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_Salvar.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salvar.cmd_4c_Cancelar
            .Caption         = "Cancelar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 81
            .Top             = 5
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Salvar.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Shapes divisores visuais (+29 em todos os Tops)
        *-- Shape1: Top=153+29=182, secao superior (datas/nf/doc)
        loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPagina.shp_4c_Shape1
            .Top         = 182
            .Left        = 9
            .Width       = 980
            .Height      = 64
            .BackStyle   = 0
            .Curvature   = 0
            .BorderColor = RGB(90, 90, 90)
        ENDWITH

        *-- Shape3: Top=224+29=253, secao debito (esquerda)
        loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPagina.shp_4c_Shape3
            .Top         = 253
            .Left        = 9
            .Width       = 485
            .Height      = 117
            .BackStyle   = 0
            .Curvature   = 0
            .BorderColor = RGB(90, 90, 90)
        ENDWITH

        *-- Shape2: Top=224+29=253, secao credito (direita)
        loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPagina.shp_4c_Shape2
            .Top         = 253
            .Left        = 504
            .Width       = 485
            .Height      = 117
            .BackStyle   = 0
            .Curvature   = 0
            .BorderColor = RGB(90, 90, 90)
        ENDWITH

        *-- Shape6: Top=350+29=379, secao historico
        loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
        WITH loc_oPagina.shp_4c_Shape6
            .Top         = 379
            .Left        = 9
            .Width       = 980
            .Height      = 39
            .BackStyle   = 0
            .Curvature   = 0
            .BorderColor = RGB(90, 90, 90)
        ENDWITH

        *======================================================================
        * SECAO SUPERIOR: Datas, NF, Documento, Nota, Usuario, Job
        * Shape1 cobre Top=182, Height=64 (182..246)
        *======================================================================

        *-- Label "Lancamento :" (Say1: Left=43, Top=165+29=194)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label1", "Lan" + CHR(231) + "amento :", 43, 194)
        *-- txt_4c_Fweditdata_DATA (Top=161+29=190, Left=112, Width=80)
        loc_oPagina.AddObject("txt_4c_Fweditdata_DATA", "TextBox")
        WITH loc_oPagina.txt_4c_Fweditdata_DATA
            .Value         = DATE()
            .Left          = 112
            .Top           = 190
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "E"
            .InputMask     = "99/99/9999"
            .SpecialEffect = 1
            .Alignment     = 3
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- Label "Vencimento :" (Say10: Left=234, Top=165+29=194)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label10", "Vencimento :", 234, 194)
        *-- txt_4c_Fweditdata_VENC (Top=161+29=190, Left=300, Width=80)
        loc_oPagina.AddObject("txt_4c_Fweditdata_VENC", "TextBox")
        WITH loc_oPagina.txt_4c_Fweditdata_VENC
            .Value         = {}
            .Left          = 300
            .Top           = 190
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "E"
            .InputMask     = "99/99/9999"
            .SpecialEffect = 1
            .Alignment     = 3
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- Label "Emissao :" (Say15: Left=435, Top=194)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label15", "Emiss" + CHR(227) + "o :", 435, 194)
        *-- txt_4c_DtEmis (Top=161+29=190, Left=484, Width=80)
        loc_oPagina.AddObject("txt_4c_DtEmis", "TextBox")
        WITH loc_oPagina.txt_4c_DtEmis
            .Value         = {}
            .Left          = 484
            .Top           = 190
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "E"
            .InputMask     = "99/99/9999"
            .SpecialEffect = 1
            .Alignment     = 3
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- Label "Nota Fiscal :" (Say7: Left=615, Top=194)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label7", "Nota Fiscal :", 615, 194)
        *-- txt_4c_Nota (Top=161+29=190, Left=678, Width=80)
        loc_oPagina.AddObject("txt_4c_Nota", "TextBox")
        WITH loc_oPagina.txt_4c_Nota
            .Value         = ""
            .Left          = 678
            .Top           = 190
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 15
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- Label "Usuario :" (Say6: Left=818, Top=194)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label6", "Usu" + CHR(225) + "rio :", 818, 194)
        *-- txt_4c__Usuario (Top=161+29=190, Left=865, Width=80 - readonly)
        loc_oPagina.AddObject("txt_4c__Usuario", "TextBox")
        WITH loc_oPagina.txt_4c__Usuario
            .Value         = ""
            .Left          = 865
            .Top           = 190
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- Label "Job :" (Say17: Left=84, Top=191+29=220)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label17", "Job :", 84, 220)
        *-- txt_4c_Job (Top=187+29=216, Left=112, Width=80 - F4 lookup)
        loc_oPagina.AddObject("txt_4c_Job", "TextBox")
        WITH loc_oPagina.txt_4c_Job
            .Value         = ""
            .Left          = 112
            .Top           = 216
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Job, "KeyPress", THIS, "JobKeyPress")

        *-- txt_4c_DJob (Top=187+29=216, Left=195, Width=290 - desc job readonly)
        loc_oPagina.AddObject("txt_4c_DJob", "TextBox")
        WITH loc_oPagina.txt_4c_DJob
            .Value         = ""
            .Left          = 195
            .Top           = 216
            .Width         = 290
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 50
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- Label "Documento :" (Say2: Left=613, Top=191+29=220)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label2", "Documento :", 613, 220)
        *-- txt_4c_DOCU (Top=187+29=216, Left=678, Width=80)
        loc_oPagina.AddObject("txt_4c_DOCU", "TextBox")
        WITH loc_oPagina.txt_4c_DOCU
            .Value         = ""
            .Left          = 678
            .Top           = 216
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 20
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *======================================================================
        * SECAO DEBITO (esquerda): Oper, Grupo, Conta, Valor, Moeda, Cotacao
        * Shape3 cobre Top=253, Left=9, Width=485
        *======================================================================

        *-- Label "Movimento :" (Say3: Left=49, Top=235+29=264)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label3", "Movimento :", 49, 264)
        *-- Label "[D/C]" (Say18: Left=130, Top=264)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label18", "[D/C]", 130, 264)

        *-- txt_4c_OPER (Top=231+29=260, Left=112, Width=15)
        loc_oPagina.AddObject("txt_4c_OPER", "TextBox")
        WITH loc_oPagina.txt_4c_OPER
            .Value         = ""
            .Left          = 112
            .Top           = 260
            .Width         = 15
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_OPER, "KeyPress", THIS, "OperKeyPress")

        *-- Label "Grupo :" (Say4: Left=72, Top=261+29=290)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label4", "Grupo :", 72, 290)
        *-- txt_4c_Grupo (Top=257+29=286, Left=112, Width=80 - F4)
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value         = ""
            .Left          = 112
            .Top           = 286
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "GrupoKeyPress")

        *-- txt_4c_Dgrupo (Top=257+29=286, Left=195, Width=290 - desc grupo readonly)
        loc_oPagina.AddObject("txt_4c_Dgrupo", "TextBox")
        WITH loc_oPagina.txt_4c_Dgrupo
            .Value         = ""
            .Left          = 195
            .Top           = 286
            .Width         = 290
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 50
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- Label "Conta :" (Say5: Left=72, Top=287+29=316)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label5", "Conta :", 72, 316)
        *-- txt_4c_Conta (Top=283+29=312, Left=112, Width=80 - F4)
        loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.txt_4c_Conta
            .Value         = ""
            .Left          = 112
            .Top           = 312
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ContaKeyPress")

        *-- txt_4c_Dconta (Top=283+29=312, Left=195, Width=290 - desc conta)
        loc_oPagina.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oPagina.txt_4c_Dconta
            .Value         = ""
            .Left          = 195
            .Top           = 312
            .Width         = 290
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 50
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- Label "Valor :" (Say8: Left=77, Top=313+29=342)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label8", "Valor :", 77, 342)
        *-- txt_4c_VALOR (Top=309+29=338, Left=112, Width=128)
        loc_oPagina.AddObject("txt_4c_VALOR", "TextBox")
        WITH loc_oPagina.txt_4c_VALOR
            .Value         = 0
            .Left          = 112
            .Top           = 338
            .Width         = 128
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999,999,999.99"
            .SpecialEffect = 1
            .Alignment     = 3
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_VALOR, "KeyPress", THIS, "ValorKeyPress")

        *-- txt_4c_MOEDA (Top=309+29=338, Left=243, Width=31 - F4)
        loc_oPagina.AddObject("txt_4c_MOEDA", "TextBox")
        WITH loc_oPagina.txt_4c_MOEDA
            .Value         = ""
            .Left          = 243
            .Top           = 338
            .Width         = 31
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_MOEDA, "KeyPress", THIS, "MoedaKeyPress")

        *-- Label "Cambio :" (Say_Cotacao: Left=303, Top=313+29=342)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c__Cotacao", "C" + CHR(226) + "mbio :", 303, 342)
        *-- txt_4c_COTACAO (Top=309+29=338, Left=349, Width=108)
        loc_oPagina.AddObject("txt_4c_COTACAO", "TextBox")
        WITH loc_oPagina.txt_4c_COTACAO
            .Value         = 1
            .Left          = 349
            .Top           = 338
            .Width         = 108
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99,999.9999999"
            .SpecialEffect = 1
            .Alignment     = 3
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- cmd_4c_Alteracotacao (Top=309+29=338, Left=461, Width=24, Height=23)
        loc_oPagina.AddObject("cmd_4c_Alteracotacao", "CommandButton")
        WITH loc_oPagina.cmd_4c_Alteracotacao
            .Caption       = "$"
            .Top           = 338
            .Left          = 461
            .Width         = 24
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 12
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .TabStop       = .F.
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Alteracotacao, "Click", THIS, "BtnAlteracotacaoClick")

        *======================================================================
        * SECAO CREDITO (direita): SOper, SGrupo, SConta, SValor, SMoeda, SCotacao
        * Shape2 cobre Top=253, Left=504, Width=485
        *======================================================================

        *-- Label "Movimento :" (Say11: Left=544, Top=235+29=264)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label11", "Movimento :", 544, 264)
        *-- Label "[D/C]" (Say14: Left=626, Top=264)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label14", "[D/C]", 626, 264)

        *-- txt_4c_SOPER (Top=231+29=260, Left=607, Width=15)
        loc_oPagina.AddObject("txt_4c_SOPER", "TextBox")
        WITH loc_oPagina.txt_4c_SOPER
            .Value         = ""
            .Left          = 607
            .Top           = 260
            .Width         = 15
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 1
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- Label "Grupo :" (Say12: Left=567, Top=261+29=290)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label12", "Grupo :", 567, 290)
        *-- txt_4c_SGRUPO (Top=257+29=286, Left=607, Width=80 - F4)
        loc_oPagina.AddObject("txt_4c_SGRUPO", "TextBox")
        WITH loc_oPagina.txt_4c_SGRUPO
            .Value         = ""
            .Left          = 607
            .Top           = 286
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SGRUPO, "KeyPress", THIS, "SGrupoKeyPress")

        *-- txt_4c_Sdgrupo (Top=257+29=286, Left=689, Width=290 - readonly)
        loc_oPagina.AddObject("txt_4c_Sdgrupo", "TextBox")
        WITH loc_oPagina.txt_4c_Sdgrupo
            .Value         = ""
            .Left          = 689
            .Top           = 286
            .Width         = 290
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 50
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- Label "Conta :" (Say13: Left=567, Top=287+29=316)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label13", "Conta :", 567, 316)
        *-- txt_4c_SCONTA (Top=283+29=312, Left=607, Width=80 - F4)
        loc_oPagina.AddObject("txt_4c_SCONTA", "TextBox")
        WITH loc_oPagina.txt_4c_SCONTA
            .Value         = ""
            .Left          = 607
            .Top           = 312
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SCONTA, "KeyPress", THIS, "SContaKeyPress")

        *-- txt_4c_SDCONTA (Top=283+29=312, Left=689, Width=290 - desc sconta)
        loc_oPagina.AddObject("txt_4c_SDCONTA", "TextBox")
        WITH loc_oPagina.txt_4c_SDCONTA
            .Value         = ""
            .Left          = 689
            .Top           = 312
            .Width         = 290
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 50
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- Label "Valor :" (Say16: Left=572, Top=313+29=342)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label16", "Valor :", 572, 342)
        *-- txt_4c_SVALOR (Top=309+29=338, Left=607, Width=128)
        loc_oPagina.AddObject("txt_4c_SVALOR", "TextBox")
        WITH loc_oPagina.txt_4c_SVALOR
            .Value         = 0
            .Left          = 607
            .Top           = 338
            .Width         = 128
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999,999,999.99"
            .SpecialEffect = 1
            .Alignment     = 3
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- txt_4c_Smoeda (Top=309+29=338, Left=737, Width=31 - F4)
        loc_oPagina.AddObject("txt_4c_Smoeda", "TextBox")
        WITH loc_oPagina.txt_4c_Smoeda
            .Value         = ""
            .Left          = 737
            .Top           = 338
            .Width         = 31
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Smoeda, "KeyPress", THIS, "SMoedaKeyPress")

        *-- Label "Cambio :" (Say_sCotacao: Left=797, Top=313+29=342)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c__sCotacao", "C" + CHR(226) + "mbio :", 797, 342)
        *-- txt_4c_SCOTACAO (Top=309+29=338, Left=843, Width=108)
        loc_oPagina.AddObject("txt_4c_SCOTACAO", "TextBox")
        WITH loc_oPagina.txt_4c_SCOTACAO
            .Value         = 1
            .Left          = 843
            .Top           = 338
            .Width         = 108
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99,999.9999999"
            .SpecialEffect = 1
            .Alignment     = 3
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- cmd_4c_Alterascotacao (Top=309+29=338, Left=955, Width=24, Height=23)
        loc_oPagina.AddObject("cmd_4c_Alterascotacao", "CommandButton")
        WITH loc_oPagina.cmd_4c_Alterascotacao
            .Caption       = "$"
            .Top           = 338
            .Left          = 955
            .Width         = 24
            .Height        = 23
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 12
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .TabStop       = .F.
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Alterascotacao, "Click", THIS, "BtnAlterascotacaoClick")

        *======================================================================
        * SECAO HISTORICO: Hist, Hist2, Opcao_conta
        * Shape6 cobre Top=379, Left=9, Width=980, Height=39
        *======================================================================

        *-- Label "Historico :" (Say9: Left=60, Top=362+29=391)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label9", "Hist" + CHR(243) + "rico :", 60, 391)
        *-- txt_4c_HIST (Top=358+29=387, Left=112, Width=300)
        loc_oPagina.AddObject("txt_4c_HIST", "TextBox")
        WITH loc_oPagina.txt_4c_HIST
            .Value         = ""
            .Left          = 112
            .Top           = 387
            .Width         = 300
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 50
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- txt_4c_Hist2 (Top=358+29=387, Left=415, Width=300)
        loc_oPagina.AddObject("txt_4c_Hist2", "TextBox")
        WITH loc_oPagina.txt_4c_Hist2
            .Value         = ""
            .Left          = 415
            .Top           = 387
            .Width         = 300
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 50
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
        ENDWITH

        *-- Label "Lancar Contas :" (Say19: Left=758, Top=362+29=391)
        THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label19", "Lan" + CHR(231) + "ar Contas :", 758, 391)
        *-- OptionGroup Opcao_conta (Top=356+29=385, Left=844, Width=99, Height=27)
        loc_oPagina.AddObject("obj_4c_Opcao_conta", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opcao_conta
            .Top         = 385
            .Left        = 844
            .Width       = 99
            .Height      = 27
            .AutoSize    = .T.
            .BorderStyle = 0
            .ButtonCount = 2
            .Value       = 2

            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 5
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).Width     = 40
            .Buttons(1).Height    = 17
            .Buttons(1).BackStyle = 0
            .Buttons(1).FontName  = "Tahoma"
            .Buttons(1).FontSize  = 8
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.

            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Left      = 57
            .Buttons(2).Top       = 6
            .Buttons(2).AutoSize  = .T.
            .Buttons(2).BackStyle = 0
            .Buttons(2).FontName  = "Tahoma"
            .Buttons(2).FontSize  = 8
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * AddLabelP2 - Helper para adicionar label em Page2 (evita repeticao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AddLabelP2(par_oPagina, par_cNome, par_cCaption, par_nLeft, par_nTop)
        par_oPagina.AddObject(par_cNome, "Label")
        WITH par_oPagina.&par_cNome
            .Caption   = par_cCaption
            .Left      = par_nLeft
            .Top       = par_nTop
            .AutoSize  = .T.
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega grid com dados do periodo filtrado
    * Legado: SqlDados() - WHERE Datas BETWEEN dtI AND dtF
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_dDtI, loc_dDtF, loc_oGrade
        loc_lResultado = .F.

        TRY
            loc_dDtI = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_inicial.Value
            loc_dDtF = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_final.Value

            IF EMPTY(loc_dDtI)
                loc_dDtI = DATE()
            ENDIF
            IF EMPTY(loc_dDtF)
                loc_dDtF = DATE()
            ENDIF

            THIS.this_oBusinessObject.this_dDtInicial = loc_dDtI
            THIS.this_oBusinessObject.this_dDtFinal   = loc_dDtF

            loc_oGrade = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
            loc_oGrade.RecordSource = ""

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .T.
                loc_oGrade.RecordSource = "cursor_4c_Dados"

                *-- Definir ControlSources APOS RecordSource (CRITICO!)
                loc_oGrade.Column1.ControlSource  = "cursor_4c_Dados.datas"
                loc_oGrade.Column2.ControlSource  = "cursor_4c_Dados.opers"
                loc_oGrade.Column3.ControlSource  = "cursor_4c_Dados.contas"
                loc_oGrade.Column4.ControlSource  = "cursor_4c_Dados.scontas"
                loc_oGrade.Column5.ControlSource  = "cursor_4c_Dados.hists"
                loc_oGrade.Column6.ControlSource  = "cursor_4c_Dados.valors"
                loc_oGrade.Column7.ControlSource  = "cursor_4c_Dados.moedas"
                loc_oGrade.Column8.ControlSource  = "cursor_4c_Dados.svalors"
                loc_oGrade.Column9.ControlSource  = "cursor_4c_Dados.smoedas"
                loc_oGrade.Column10.ControlSource = "cursor_4c_Dados.nfs"
                loc_oGrade.Column11.ControlSource = "cursor_4c_Dados.docus"

                *-- Redefinir Header1.Caption APOS RecordSource (OBRIGATORIO - Problema 32)
                loc_oGrade.Column1.Header1.Caption  = "Data"
                loc_oGrade.Column2.Header1.Caption  = "O"
                loc_oGrade.Column3.Header1.Caption  = "Conta"
                loc_oGrade.Column4.Header1.Caption  = "Contrapartida"
                loc_oGrade.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
                loc_oGrade.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
                loc_oGrade.Column7.Header1.Caption  = ""
                loc_oGrade.Column8.Header1.Caption  = "Cr" + CHR(233) + "dito"
                loc_oGrade.Column9.Header1.Caption  = ""
                loc_oGrade.Column10.Header1.Caption = "NF"
                loc_oGrade.Column11.Header1.Caption = "Documento"

                *-- DynamicForeColor: azul para registros conciliados
                LOCAL loc_cExprFore
                loc_cExprFore = "IIF(cursor_4c_Dados.concs, RGB(0,0,255), RGB(0,0,0))"
                loc_oGrade.Column1.DynamicForeColor  = loc_cExprFore
                loc_oGrade.Column2.DynamicForeColor  = loc_cExprFore
                loc_oGrade.Column3.DynamicForeColor  = loc_cExprFore
                loc_oGrade.Column4.DynamicForeColor  = loc_cExprFore
                loc_oGrade.Column5.DynamicForeColor  = loc_cExprFore
                loc_oGrade.Column6.DynamicForeColor  = loc_cExprFore
                loc_oGrade.Column7.DynamicForeColor  = loc_cExprFore
                loc_oGrade.Column8.DynamicForeColor  = loc_cExprFore
                loc_oGrade.Column9.DynamicForeColor  = loc_cExprFore
                loc_oGrade.Column10.DynamicForeColor = loc_cExprFore
                loc_oGrade.Column11.DynamicForeColor = loc_cExprFore

                IF RECCOUNT("cursor_4c_Dados") > 0
                    GO TOP IN cursor_4c_Dados
                ENDIF

                THIS.FormatarGridLista(loc_oGrade)
                loc_oGrade.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do Form para o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            .this_dDatas    = NVL(loc_oPagina.txt_4c_Fweditdata_DATA.Value, DATE())
            .this_dVencs    = NVL(loc_oPagina.txt_4c_Fweditdata_VENC.Value, {})
            .this_dDtEmiss  = NVL(loc_oPagina.txt_4c_DtEmis.Value, {})
            .this_cNotas    = ALLTRIM(loc_oPagina.txt_4c_Nota.Value)
            .this_cDocus    = ALLTRIM(loc_oPagina.txt_4c_DOCU.Value)
            .this_cJobs     = ALLTRIM(loc_oPagina.txt_4c_Job.Value)
            .this_cDJobs    = ALLTRIM(loc_oPagina.txt_4c_DJob.Value)
            .this_cOpers    = UPPER(ALLTRIM(loc_oPagina.txt_4c_OPER.Value))
            .this_cGrupos   = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
            .this_cDGrupos  = ALLTRIM(loc_oPagina.txt_4c_Dgrupo.Value)
            .this_cContas   = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
            .this_cDContas  = ALLTRIM(loc_oPagina.txt_4c_Dconta.Value)
            .this_nValors   = NVL(loc_oPagina.txt_4c_VALOR.Value, 0)
            .this_cMoedas   = UPPER(ALLTRIM(loc_oPagina.txt_4c_MOEDA.Value))
            .this_nCotacaos = NVL(loc_oPagina.txt_4c_COTACAO.Value, 1)
            .this_cSopers   = UPPER(ALLTRIM(loc_oPagina.txt_4c_SOPER.Value))
            .this_cSgrupos  = ALLTRIM(loc_oPagina.txt_4c_SGRUPO.Value)
            .this_cDSgrupos = ALLTRIM(loc_oPagina.txt_4c_Sdgrupo.Value)
            .this_cScontas  = ALLTRIM(loc_oPagina.txt_4c_SCONTA.Value)
            .this_cDScontas = ALLTRIM(loc_oPagina.txt_4c_SDCONTA.Value)
            .this_nSvalors  = NVL(loc_oPagina.txt_4c_SVALOR.Value, 0)
            .this_cSmoedas  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Smoeda.Value))
            .this_nScotacaos = NVL(loc_oPagina.txt_4c_SCOTACAO.Value, 1)
            .this_cHists    = ALLTRIM(loc_oPagina.txt_4c_HIST.Value)
            .this_cHist2s   = ALLTRIM(loc_oPagina.txt_4c_Hist2.Value)
            .this_nContapgs = loc_oPagina.obj_4c_Opcao_conta.Value
            .this_cEmps     = go_4c_Sistema.cCodEmpresa
            .this_cUsuario  = gc_4c_UsuarioLogado
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do Business Object para o Form
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            loc_oPagina.txt_4c_Fweditdata_DATA.Value = NVL(.this_dDatas, DATE())
            loc_oPagina.txt_4c_Fweditdata_VENC.Value = NVL(.this_dVencs, {})
            loc_oPagina.txt_4c_DtEmis.Value          = NVL(.this_dDtEmiss, {})
            loc_oPagina.txt_4c_Nota.Value             = .this_cNotas
            loc_oPagina.txt_4c_DOCU.Value             = .this_cDocus
            loc_oPagina.txt_4c_Job.Value              = .this_cJobs
            loc_oPagina.txt_4c_DJob.Value             = .this_cDJobs
            loc_oPagina.txt_4c__Usuario.Value         = .this_cUsuario
            loc_oPagina.txt_4c_OPER.Value             = .this_cOpers
            loc_oPagina.txt_4c_Grupo.Value            = .this_cGrupos
            loc_oPagina.txt_4c_Dgrupo.Value           = .this_cDGrupos
            loc_oPagina.txt_4c_Conta.Value            = .this_cContas
            loc_oPagina.txt_4c_Dconta.Value           = .this_cDContas
            loc_oPagina.txt_4c_VALOR.Value            = .this_nValors
            loc_oPagina.txt_4c_MOEDA.Value            = .this_cMoedas
            loc_oPagina.txt_4c_COTACAO.Value          = .this_nCotacaos
            loc_oPagina.txt_4c_SOPER.Value            = .this_cSopers
            loc_oPagina.txt_4c_SGRUPO.Value           = .this_cSgrupos
            loc_oPagina.txt_4c_Sdgrupo.Value          = .this_cDSgrupos
            loc_oPagina.txt_4c_SCONTA.Value           = .this_cScontas
            loc_oPagina.txt_4c_SDCONTA.Value          = .this_cDScontas
            loc_oPagina.txt_4c_SVALOR.Value           = .this_nSvalors
            loc_oPagina.txt_4c_Smoeda.Value           = .this_cSmoedas
            loc_oPagina.txt_4c_SCOTACAO.Value         = .this_nScotacaos
            loc_oPagina.txt_4c_HIST.Value             = .this_cHists
            loc_oPagina.txt_4c_Hist2.Value            = .this_cHist2s
            IF !EMPTY(.this_nContapgs)
                loc_oPagina.obj_4c_Opcao_conta.Value = IIF(.this_nContapgs = 1, 1, 2)
            ENDIF
        ENDWITH

        THIS.AtualizarVisibilidadeCotacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do formulario Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Fweditdata_DATA.Value = DATE()
        loc_oPagina.txt_4c_Fweditdata_VENC.Value = {}
        loc_oPagina.txt_4c_DtEmis.Value          = {}
        loc_oPagina.txt_4c_Nota.Value             = ""
        loc_oPagina.txt_4c_DOCU.Value             = ""
        loc_oPagina.txt_4c_Job.Value              = ""
        loc_oPagina.txt_4c_DJob.Value             = ""
        loc_oPagina.txt_4c__Usuario.Value         = gc_4c_UsuarioLogado
        loc_oPagina.txt_4c_OPER.Value             = "D"
        loc_oPagina.txt_4c_Grupo.Value            = ""
        loc_oPagina.txt_4c_Dgrupo.Value           = ""
        loc_oPagina.txt_4c_Conta.Value            = ""
        loc_oPagina.txt_4c_Dconta.Value           = ""
        loc_oPagina.txt_4c_VALOR.Value            = 0
        loc_oPagina.txt_4c_MOEDA.Value            = ""
        loc_oPagina.txt_4c_COTACAO.Value          = 1
        loc_oPagina.txt_4c_SOPER.Value            = "C"
        loc_oPagina.txt_4c_SGRUPO.Value           = ""
        loc_oPagina.txt_4c_Sdgrupo.Value          = ""
        loc_oPagina.txt_4c_SCONTA.Value           = ""
        loc_oPagina.txt_4c_SDCONTA.Value          = ""
        loc_oPagina.txt_4c_SVALOR.Value           = 0
        loc_oPagina.txt_4c_Smoeda.Value           = ""
        loc_oPagina.txt_4c_SCOTACAO.Value         = 1
        loc_oPagina.txt_4c_HIST.Value             = ""
        loc_oPagina.txt_4c_Hist2.Value            = ""
        loc_oPagina.obj_4c_Opcao_conta.Value      = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos de edicao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Fweditdata_DATA.ReadOnly = !par_lHabilitar
        loc_oPagina.txt_4c_Fweditdata_VENC.ReadOnly = !par_lHabilitar
        loc_oPagina.txt_4c_DtEmis.ReadOnly          = !par_lHabilitar
        loc_oPagina.txt_4c_Nota.ReadOnly             = !par_lHabilitar
        loc_oPagina.txt_4c_DOCU.ReadOnly             = !par_lHabilitar
        loc_oPagina.txt_4c_Job.ReadOnly              = !par_lHabilitar
        loc_oPagina.txt_4c_OPER.ReadOnly             = !par_lHabilitar
        loc_oPagina.txt_4c_Grupo.ReadOnly            = !par_lHabilitar
        loc_oPagina.txt_4c_Conta.ReadOnly            = !par_lHabilitar
        loc_oPagina.txt_4c_VALOR.ReadOnly            = !par_lHabilitar
        loc_oPagina.txt_4c_MOEDA.ReadOnly            = !par_lHabilitar
        loc_oPagina.txt_4c_SGRUPO.ReadOnly           = !par_lHabilitar
        loc_oPagina.txt_4c_SCONTA.ReadOnly           = !par_lHabilitar
        loc_oPagina.txt_4c_SVALOR.ReadOnly           = !par_lHabilitar
        loc_oPagina.txt_4c_Smoeda.ReadOnly           = !par_lHabilitar
        loc_oPagina.txt_4c_HIST.ReadOnly             = !par_lHabilitar
        loc_oPagina.txt_4c_Hist2.ReadOnly            = !par_lHabilitar
        loc_oPagina.obj_4c_Opcao_conta.Enabled       = par_lHabilitar

        *-- Botoes Salvar/Cancelar
        loc_oPagina.cnt_4c_Salvar.cmd_4c_Salvar.Visible  = par_lHabilitar
        loc_oPagina.cnt_4c_Salvar.cmd_4c_Cancelar.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarVisibilidadeCotacao - Controla visibilidade dos campos de cotacao
    * Legado: Verifica crSigCdMoe.Cotas para mostrar/ocultar cotacao
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarVisibilidadeCotacao()
        LOCAL loc_cMoeda, loc_lCotas, loc_cSQL, loc_nRes
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_cMoeda = UPPER(ALLTRIM(loc_oPagina.txt_4c_MOEDA.Value))
        loc_lCotas = .F.

        IF !EMPTY(loc_cMoeda) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            loc_cSQL = "SELECT TOP 1 cotas FROM SigCdMoe WHERE Cmoes = " + EscaparSQL(loc_cMoeda)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moe") >= 0
                IF RECCOUNT("cursor_4c_Moe") > 0
                    SELECT cursor_4c_Moe
                    loc_lCotas = NVL(cursor_4c_Moe.cotas, .F.)
                ENDIF
                IF USED("cursor_4c_Moe")
                    USE IN cursor_4c_Moe
                ENDIF
            ENDIF
        ENDIF

        loc_oPagina.txt_4c_COTACAO.Visible         = loc_lCotas
        loc_oPagina.lbl_4c__Cotacao.Visible        = loc_lCotas
        loc_oPagina.cmd_4c_Alteracotacao.Visible   = loc_lCotas AND THIS.this_cModoAtual = "ALTERAR"
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN
        ENDIF
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        IF par_nPagina = 1
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DE BOTOES
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Incluir novo movimento
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Fweditdata_DATA.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar movimento selecionado (Consultar no legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCidchaves

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar movimento selecionado
    * Legado: verifica bloqueio de periodo, conciliacao e auditoria
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCidchaves

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados

        *-- Verificar se movimento esta conciliado
        IF cursor_4c_Dados.concs
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Conciliada !")
            RETURN
        ENDIF

        loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
            *-- Verificar se e automatico
            IF THIS.this_oBusinessObject.this_lAutos
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica !")
                RETURN
            ENDIF

            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AtualizarVisibilidadeCotacao()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Fweditdata_DATA.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir movimento selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCidchaves

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados

        IF cursor_4c_Dados.concs
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Conciliada !")
            RETURN
        ENDIF

        loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.this_lAutos
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !! Movimenta" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica !")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma exclus" + CHR(227) + "o do movimento selecionado?")
            IF THIS.this_oBusinessObject.Excluir()
                MsgSucesso("Movimento exclu" + CHR(237) + "do com sucesso!")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega lista (equivalente ao Procurar do legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salvar movimento (Inserir ou Alterar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cOper, loc_cGrupo, loc_cConta, loc_cMoeda
        LOCAL loc_cSGrupo, loc_cSConta, loc_cSMoeda, loc_nValor, loc_nSValor
        LOCAL loc_dData

        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Validacao: Data
        loc_dData = loc_oPagina.txt_4c_Fweditdata_DATA.Value
        IF EMPTY(loc_dData)
            MsgAviso("Data Inv" + CHR(225) + "lida")
            loc_oPagina.txt_4c_Fweditdata_DATA.SetFocus()
            RETURN
        ENDIF

        *-- Validacao: Vencimento (quando Lancar Contas = Sim)
        IF loc_oPagina.obj_4c_Opcao_conta.Value = 1
            IF EMPTY(loc_oPagina.txt_4c_Fweditdata_VENC.Value)
                MsgAviso("Vencimento Inv" + CHR(225) + "lido")
                loc_oPagina.txt_4c_Fweditdata_VENC.SetFocus()
                RETURN
            ENDIF
            IF loc_oPagina.txt_4c_Fweditdata_VENC.Value < loc_dData
                MsgAviso("Vencimento N" + CHR(227) + "o Pode Ser Menor Que a Data de Lan" + CHR(231) + "amento!")
                loc_oPagina.txt_4c_Fweditdata_VENC.SetFocus()
                RETURN
            ENDIF
        ENDIF

        *-- Validacao: Operacao D ou C
        loc_cOper = UPPER(ALLTRIM(loc_oPagina.txt_4c_OPER.Value))
        IF !INLIST(loc_cOper, "D", "C")
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida! Digite D ou C.")
            loc_oPagina.txt_4c_OPER.SetFocus()
            RETURN
        ENDIF

        *-- Validacao: Grupo D
        loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        IF EMPTY(loc_cGrupo)
            MsgAviso("Grupo Inv" + CHR(225) + "lido")
            loc_oPagina.txt_4c_Grupo.SetFocus()
            RETURN
        ENDIF

        *-- Validacao: Conta D
        loc_cConta = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
        IF EMPTY(loc_cConta)
            MsgAviso("Conta Inv" + CHR(225) + "lida")
            loc_oPagina.txt_4c_Conta.SetFocus()
            RETURN
        ENDIF

        *-- Validacao: Moeda D
        loc_cMoeda = UPPER(ALLTRIM(loc_oPagina.txt_4c_MOEDA.Value))
        IF EMPTY(loc_cMoeda)
            MsgAviso("Moeda Inv" + CHR(225) + "lida")
            loc_oPagina.txt_4c_MOEDA.SetFocus()
            RETURN
        ENDIF

        *-- Validacao: Valor D
        loc_nValor = NVL(loc_oPagina.txt_4c_VALOR.Value, -1)
        IF loc_nValor < 0
            MsgAviso("Valor Inv" + CHR(225) + "lido")
            loc_oPagina.txt_4c_VALOR.SetFocus()
            RETURN
        ENDIF

        *-- Validacao: SGrupo C
        loc_cSGrupo = ALLTRIM(loc_oPagina.txt_4c_SGRUPO.Value)
        IF EMPTY(loc_cSGrupo)
            MsgAviso("Grupo (Cr" + CHR(233) + "dito) Inv" + CHR(225) + "lido")
            loc_oPagina.txt_4c_SGRUPO.SetFocus()
            RETURN
        ENDIF

        *-- Validacao: SConta C
        loc_cSConta = ALLTRIM(loc_oPagina.txt_4c_SCONTA.Value)
        IF EMPTY(loc_cSConta)
            MsgAviso("Conta (Cr" + CHR(233) + "dito) Inv" + CHR(225) + "lida")
            loc_oPagina.txt_4c_SCONTA.SetFocus()
            RETURN
        ENDIF

        *-- Validacao: SMoeda C
        loc_cSMoeda = UPPER(ALLTRIM(loc_oPagina.txt_4c_Smoeda.Value))
        IF EMPTY(loc_cSMoeda)
            MsgAviso("Moeda (Cr" + CHR(233) + "dito) Inv" + CHR(225) + "lida")
            loc_oPagina.txt_4c_Smoeda.SetFocus()
            RETURN
        ENDIF

        *-- Validacao: SValor C
        loc_nSValor = NVL(loc_oPagina.txt_4c_SVALOR.Value, -1)
        IF loc_nSValor < 0
            MsgAviso("Valor (Cr" + CHR(233) + "dito) Inv" + CHR(225) + "lido")
            loc_oPagina.txt_4c_SVALOR.SetFocus()
            RETURN
        ENDIF

        *-- Validacao: mesma moeda deve ter mesma cotacao
        IF loc_cMoeda == loc_cSMoeda
            IF NVL(loc_oPagina.txt_4c_COTACAO.Value, 1) != NVL(loc_oPagina.txt_4c_SCOTACAO.Value, 1)
                MsgAviso("Cota" + CHR(231) + CHR(227) + "o Inconsistente!")
                loc_oPagina.txt_4c_MOEDA.SetFocus()
                RETURN
            ENDIF
        ENDIF

        *-- Validacao: lancamento inconsistente (D e C iguais)
        IF loc_cGrupo + loc_cConta + loc_cMoeda == loc_cSGrupo + loc_cSConta + loc_cSMoeda
            MsgAviso("Lan" + CHR(231) + "amento Inconsistente! D" + CHR(233) + "bito = Cr" + CHR(233) + "dito")
            loc_oPagina.txt_4c_MOEDA.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgSucesso("Movimento salvo com sucesso!")
            THIS.AlternarPagina(1)
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar edicao e voltar para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()    && OBRIGATORIO: recarrega dados + formatacao (Problema 2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAnexaClick - Abrir documento vinculado (F7 no legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAnexaClick()
        *-- Legado abre SigCdPgr, SigMvExp ou SigCdLch dependendo do registro
        *-- Implementacao simplificada: informar usuario
        MsgInfo("Funcionalidade de documento vinculado n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlteracotacaoClick - Habilitar edicao de cotacao D
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlteracotacaoClick()
        THIS.pgf_4c_Paginas.Page2.txt_4c_COTACAO.ReadOnly = .F.
        THIS.pgf_4c_Paginas.Page2.txt_4c_COTACAO.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterascotacaoClick - Habilitar edicao de cotacao C
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterascotacaoClick()
        THIS.pgf_4c_Paginas.Page2.txt_4c_SCOTACAO.ReadOnly = .F.
        THIS.pgf_4c_Paginas.Page2.txt_4c_SCOTACAO.SetFocus()
    ENDPROC

    *==========================================================================
    * HANDLERS DE FILTRO DE DATA
    *==========================================================================

    *--------------------------------------------------------------------------
    * DtInicialKeyPress - ENTER/TAB em Dt_inicial ajusta Dt_final se necessario
    *--------------------------------------------------------------------------
    PROCEDURE DtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPeriodo
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo
            IF !EMPTY(loc_oPeriodo.txt_4c_Dt_inicial.Value)
                IF loc_oPeriodo.txt_4c_Dt_inicial.Value > loc_oPeriodo.txt_4c_Dt_final.Value
                    loc_oPeriodo.txt_4c_Dt_final.Value = loc_oPeriodo.txt_4c_Dt_inicial.Value
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DtFinalKeyPress - ENTER/TAB em Dt_final recarrega lista
    *--------------------------------------------------------------------------
    PROCEDURE DtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPeriodo
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo
            IF !EMPTY(loc_oPeriodo.txt_4c_Dt_final.Value)
                IF loc_oPeriodo.txt_4c_Dt_final.Value < loc_oPeriodo.txt_4c_Dt_inicial.Value
                    loc_oPeriodo.txt_4c_Dt_inicial.Value = loc_oPeriodo.txt_4c_Dt_final.Value
                ENDIF
            ENDIF
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLA - CAMPO OPER
    *==========================================================================

    *--------------------------------------------------------------------------
    * OperKeyPress - Valida OPER (D ou C) e seta SOPER automaticamente
    *--------------------------------------------------------------------------
    PROCEDURE OperKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cOper

        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cOper   = UPPER(ALLTRIM(loc_oPagina.txt_4c_OPER.Value))

            IF !EMPTY(loc_cOper) AND !INLIST(loc_cOper, "D", "C")
                MsgAviso("Digite (D)" + CHR(233) + "bito ou (C)r" + CHR(233) + "dito !!!")
                loc_oPagina.txt_4c_OPER.SetFocus()
            ELSE
                IF loc_cOper = "D"
                    loc_oPagina.txt_4c_SOPER.Value = "C"
                ELSE
                    IF loc_cOper = "C"
                        loc_oPagina.txt_4c_SOPER.Value = "D"
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLA - VALOR
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValorKeyPress - Recalcula SValor quando sair do campo Valor
    *--------------------------------------------------------------------------
    PROCEDURE ValorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_nValor, loc_nCot, loc_nSCot

        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_nValor  = NVL(loc_oPagina.txt_4c_VALOR.Value, 0)

            IF loc_nValor < 0
                MsgAviso("Valor Inv" + CHR(225) + "lido...")
                loc_oPagina.txt_4c_VALOR.SetFocus()
            ELSE
                loc_nCot  = NVL(loc_oPagina.txt_4c_COTACAO.Value, 1)
                loc_nSCot = NVL(loc_oPagina.txt_4c_SCOTACAO.Value, 1)
                IF loc_nSCot > 0
                    loc_oPagina.txt_4c_SVALOR.Value = loc_nValor * loc_nCot / loc_nSCot
                ELSE
                    loc_oPagina.txt_4c_SVALOR.Value = loc_nValor
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DE LOOKUP - GRUPO (D)
    *==========================================================================

    *--------------------------------------------------------------------------
    * GrupoKeyPress - F4 abre lookup, ENTER/TAB valida grupo existente
    *--------------------------------------------------------------------------
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115    && F4
            THIS.AbrirLookupGrupo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarGrupo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - Lookup de Grupo de Conta Corrente (SigCdGcr)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
                         "cursor_4c_BuscaGcr", "Codigos", ;
                         ALLTRIM(loc_oPagina.txt_4c_Grupo.Value), ;
                         "Buscar Grupo")
            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                SELECT cursor_4c_BuscaGcr
                loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
                loc_oPagina.txt_4c_Dgrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
            ENDIF

            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro("Erro no lookup de Grupo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Valida grupo digitado e busca descricao
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo()
        LOCAL loc_oPagina, loc_cGrupo, loc_cSQL
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        IF EMPTY(loc_cGrupo)
            loc_oPagina.txt_4c_Dgrupo.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Codigos, Descrs, Classes FROM SigCdGcr" + ;
                       " WHERE Codigos = " + EscaparSQL(loc_cGrupo)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gcr") >= 0
                IF RECCOUNT("cursor_4c_Gcr") > 0
                    SELECT cursor_4c_Gcr
                    loc_oPagina.txt_4c_Dgrupo.Value = ALLTRIM(cursor_4c_Gcr.Descrs)
                    IF EMPTY(cursor_4c_Gcr.Classes)
                        MsgAviso("Imposs" + CHR(237) + "vel Realizar Lan" + CHR(231) + "amento Neste Grupo!!!" + CHR(13) + ;
                                 "A Classe do Grupo N" + CHR(227) + "o Foi Informada!!!")
                    ENDIF
                ELSE
                    MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cGrupo)
                    loc_oPagina.txt_4c_Grupo.Value  = ""
                    loc_oPagina.txt_4c_Dgrupo.Value = ""
                    loc_oPagina.txt_4c_Grupo.SetFocus()
                ENDIF
                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar Grupo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE LOOKUP - CONTA (D)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ContaKeyPress - F4 abre lookup, ENTER/TAB valida conta
    *--------------------------------------------------------------------------
    PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115    && F4
            THIS.AbrirLookupConta()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarConta()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConta - Lookup de Conta (SigCdCli - Iclis/Rclis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupConta()
        LOCAL loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
                         "cursor_4c_BuscaCli", "Iclis", ;
                         ALLTRIM(loc_oPagina.txt_4c_Conta.Value), ;
                         "Buscar Conta")
            loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                SELECT cursor_4c_BuscaCli
                loc_oPagina.txt_4c_Conta.Value   = ALLTRIM(cursor_4c_BuscaCli.Iclis)
                loc_oPagina.txt_4c_Dconta.Value  = ALLTRIM(cursor_4c_BuscaCli.Rclis)
            ENDIF

            IF USED("cursor_4c_BuscaCli")
                USE IN cursor_4c_BuscaCli
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro("Erro no lookup de Conta: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConta - Valida conta digitada e busca descricao
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConta()
        LOCAL loc_oPagina, loc_cConta, loc_cSQL
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)

        IF EMPTY(loc_cConta)
            loc_oPagina.txt_4c_Dconta.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli") >= 0
                IF RECCOUNT("cursor_4c_Cli") > 0
                    SELECT cursor_4c_Cli
                    loc_oPagina.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_Cli.Rclis)
                ELSE
                    MsgAviso("Conta n" + CHR(227) + "o encontrada: " + loc_cConta)
                    loc_oPagina.txt_4c_Conta.Value  = ""
                    loc_oPagina.txt_4c_Dconta.Value = ""
                    loc_oPagina.txt_4c_Conta.SetFocus()
                ENDIF
                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar Conta: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE LOOKUP - MOEDA (D)
    *==========================================================================

    *--------------------------------------------------------------------------
    * MoedaKeyPress - F4 abre lookup de moeda
    *--------------------------------------------------------------------------
    PROCEDURE MoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115    && F4
            THIS.AbrirLookupMoeda()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.AtualizarVisibilidadeCotacao()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoeda - Lookup de Moeda (SigCdMoe - Cmoes/Dmoes)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
                         "cursor_4c_BuscaMoe", "Cmoes", ;
                         UPPER(ALLTRIM(loc_oPagina.txt_4c_MOEDA.Value)), ;
                         "Buscar Moeda")
            loc_oBusca.mAddColuna("Cmoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                SELECT cursor_4c_BuscaMoe
                loc_oPagina.txt_4c_MOEDA.Value = UPPER(ALLTRIM(cursor_4c_BuscaMoe.Cmoes))
                THIS.AtualizarVisibilidadeCotacao()
            ENDIF

            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro("Erro no lookup de Moeda: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE LOOKUP - GRUPO CREDITO (S)
    *==========================================================================

    *--------------------------------------------------------------------------
    * SGrupoKeyPress - F4 abre lookup de Grupo credito
    *--------------------------------------------------------------------------
    PROCEDURE SGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115    && F4
            THIS.AbrirLookupSGrupo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarSGrupo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSGrupo - Lookup de SGrupo (SigCdGcr)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSGrupo()
        LOCAL loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
                         "cursor_4c_BuscaGcr2", "Codigos", ;
                         ALLTRIM(loc_oPagina.txt_4c_SGRUPO.Value), ;
                         "Buscar Grupo (Cr" + CHR(233) + "dito)")
            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr2")
                SELECT cursor_4c_BuscaGcr2
                loc_oPagina.txt_4c_SGRUPO.Value  = ALLTRIM(cursor_4c_BuscaGcr2.Codigos)
                loc_oPagina.txt_4c_Sdgrupo.Value = ALLTRIM(cursor_4c_BuscaGcr2.Descrs)
            ENDIF

            IF USED("cursor_4c_BuscaGcr2")
                USE IN cursor_4c_BuscaGcr2
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro("Erro no lookup de SGrupo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSGrupo - Valida SGrupo digitado e busca descricao
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSGrupo()
        LOCAL loc_oPagina, loc_cSGrupo, loc_cSQL
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cSGrupo = ALLTRIM(loc_oPagina.txt_4c_SGRUPO.Value)

        IF EMPTY(loc_cSGrupo)
            loc_oPagina.txt_4c_Sdgrupo.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cSGrupo)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrS") >= 0
                IF RECCOUNT("cursor_4c_GcrS") > 0
                    SELECT cursor_4c_GcrS
                    loc_oPagina.txt_4c_Sdgrupo.Value = ALLTRIM(cursor_4c_GcrS.Descrs)
                ELSE
                    MsgAviso("Grupo (Cr" + CHR(233) + "dito) n" + CHR(227) + "o encontrado: " + loc_cSGrupo)
                    loc_oPagina.txt_4c_SGRUPO.Value  = ""
                    loc_oPagina.txt_4c_Sdgrupo.Value = ""
                    loc_oPagina.txt_4c_SGRUPO.SetFocus()
                ENDIF
                IF USED("cursor_4c_GcrS")
                    USE IN cursor_4c_GcrS
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar SGrupo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE LOOKUP - CONTA CREDITO (S)
    *==========================================================================

    *--------------------------------------------------------------------------
    * SContaKeyPress - F4 abre lookup de Conta credito
    *--------------------------------------------------------------------------
    PROCEDURE SContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115    && F4
            THIS.AbrirLookupSConta()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarSConta()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSConta - Lookup de SConta (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSConta()
        LOCAL loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
                         "cursor_4c_BuscaCli2", "Iclis", ;
                         ALLTRIM(loc_oPagina.txt_4c_SCONTA.Value), ;
                         "Buscar Conta (Cr" + CHR(233) + "dito)")
            loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli2")
                SELECT cursor_4c_BuscaCli2
                loc_oPagina.txt_4c_SCONTA.Value  = ALLTRIM(cursor_4c_BuscaCli2.Iclis)
                loc_oPagina.txt_4c_SDCONTA.Value = ALLTRIM(cursor_4c_BuscaCli2.Rclis)
            ENDIF

            IF USED("cursor_4c_BuscaCli2")
                USE IN cursor_4c_BuscaCli2
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro("Erro no lookup de SConta: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSConta - Valida SConta digitada e busca descricao
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSConta()
        LOCAL loc_oPagina, loc_cSConta, loc_cSQL
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cSConta = ALLTRIM(loc_oPagina.txt_4c_SCONTA.Value)

        IF EMPTY(loc_cSConta)
            loc_oPagina.txt_4c_SDCONTA.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cSConta)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliS") >= 0
                IF RECCOUNT("cursor_4c_CliS") > 0
                    SELECT cursor_4c_CliS
                    loc_oPagina.txt_4c_SDCONTA.Value = ALLTRIM(cursor_4c_CliS.Rclis)
                ELSE
                    MsgAviso("Conta (Cr" + CHR(233) + "dito) n" + CHR(227) + "o encontrada: " + loc_cSConta)
                    loc_oPagina.txt_4c_SCONTA.Value  = ""
                    loc_oPagina.txt_4c_SDCONTA.Value = ""
                    loc_oPagina.txt_4c_SCONTA.SetFocus()
                ENDIF
                IF USED("cursor_4c_CliS")
                    USE IN cursor_4c_CliS
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar SConta: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE LOOKUP - MOEDA CREDITO (S)
    *==========================================================================

    *--------------------------------------------------------------------------
    * SMoedaKeyPress - F4 abre lookup de Moeda credito
    *--------------------------------------------------------------------------
    PROCEDURE SMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115    && F4
            THIS.AbrirLookupSMoeda()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.AtualizarVisibilidadeSCotacao()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSMoeda - Lookup de SMoeda (SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSMoeda()
        LOCAL loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
                         "cursor_4c_BuscaMoe2", "Cmoes", ;
                         UPPER(ALLTRIM(loc_oPagina.txt_4c_Smoeda.Value)), ;
                         "Buscar Moeda (Cr" + CHR(233) + "dito)")
            loc_oBusca.mAddColuna("Cmoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe2")
                SELECT cursor_4c_BuscaMoe2
                loc_oPagina.txt_4c_Smoeda.Value = UPPER(ALLTRIM(cursor_4c_BuscaMoe2.Cmoes))
                THIS.AtualizarVisibilidadeSCotacao()
            ENDIF

            IF USED("cursor_4c_BuscaMoe2")
                USE IN cursor_4c_BuscaMoe2
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro("Erro no lookup de SMoeda: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarVisibilidadeSCotacao - Controla visibilidade dos campos de cotacao C
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarVisibilidadeSCotacao()
        LOCAL loc_cSMoeda, loc_lCotas, loc_cSQL
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_cSMoeda = UPPER(ALLTRIM(loc_oPagina.txt_4c_Smoeda.Value))
        loc_lCotas  = .F.

        IF !EMPTY(loc_cSMoeda) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            loc_cSQL = "SELECT TOP 1 cotas FROM SigCdMoe WHERE Cmoes = " + EscaparSQL(loc_cSMoeda)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeS") >= 0
                IF RECCOUNT("cursor_4c_MoeS") > 0
                    SELECT cursor_4c_MoeS
                    loc_lCotas = NVL(cursor_4c_MoeS.cotas, .F.)
                ENDIF
                IF USED("cursor_4c_MoeS")
                    USE IN cursor_4c_MoeS
                ENDIF
            ENDIF
        ENDIF

        loc_oPagina.txt_4c_SCOTACAO.Visible       = loc_lCotas
        loc_oPagina.lbl_4c__sCotacao.Visible      = loc_lCotas
        loc_oPagina.cmd_4c_Alterascotacao.Visible = loc_lCotas AND THIS.this_cModoAtual = "ALTERAR"
    ENDPROC

    *==========================================================================
    * HANDLERS DE LOOKUP - JOB
    *==========================================================================

    *--------------------------------------------------------------------------
    * JobKeyPress - F4 abre lookup de Job (SigCdCli tipo 10)
    *--------------------------------------------------------------------------
    PROCEDURE JobKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115    && F4
            THIS.AbrirLookupJob()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarJob()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupJob - Lookup de Job (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupJob()
        LOCAL loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
                         "cursor_4c_BuscaJob", "Iclis", ;
                         ALLTRIM(loc_oPagina.txt_4c_Job.Value), ;
                         "Buscar Job")
            loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaJob")
                SELECT cursor_4c_BuscaJob
                loc_oPagina.txt_4c_Job.Value  = ALLTRIM(cursor_4c_BuscaJob.Iclis)
                loc_oPagina.txt_4c_DJob.Value = ALLTRIM(cursor_4c_BuscaJob.Rclis)
            ENDIF

            IF USED("cursor_4c_BuscaJob")
                USE IN cursor_4c_BuscaJob
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro("Erro no lookup de Job: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarJob - Valida Job digitado e busca descricao
    *--------------------------------------------------------------------------
    PROCEDURE ValidarJob()
        LOCAL loc_oPagina, loc_cJob, loc_cSQL
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cJob    = ALLTRIM(loc_oPagina.txt_4c_Job.Value)

        IF EMPTY(loc_cJob)
            loc_oPagina.txt_4c_DJob.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cJob)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Job") >= 0
                IF RECCOUNT("cursor_4c_Job") > 0
                    SELECT cursor_4c_Job
                    loc_oPagina.txt_4c_DJob.Value = ALLTRIM(cursor_4c_Job.Rclis)
                ELSE
                    MsgAviso("Job n" + CHR(227) + "o encontrado: " + loc_cJob)
                    loc_oPagina.txt_4c_Job.Value  = ""
                    loc_oPagina.txt_4c_DJob.Value = ""
                    loc_oPagina.txt_4c_Job.SetFocus()
                ENDIF
                IF USED("cursor_4c_Job")
                    USE IN cursor_4c_Job
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar Job: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * EVENTO DE GRID
    *==========================================================================

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - Controla visibilidade do botao Anexa
    * Legado: verifica SigCdPgr, SigMvCab, SigCqChm, fChecaAcesso
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_lMostraAnexa, loc_cEmpr, loc_cDope, loc_nNume
        LOCAL loc_cSQL, loc_nRes
        LOCAL loc_oPagina

        loc_lMostraAnexa = .F.
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        TRY
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                *-- A visibilidade do Anexa depende de tabelas de outros modulos
                *-- Simplificado: sempre ocultar (sem acesso a SigCdPgr/SigMvCab/SigCqChm)
                loc_lMostraAnexa = .F.
            ENDIF
        CATCH TO loc_oErro
            *-- Nao mostrar erro em AfterRowColChange (pode disparar frequentemente)
            loc_lMostraAnexa = .F.
        ENDTRY

        loc_oPagina.cmd_4c_Anexa.Visible    = loc_lMostraAnexa
        loc_oPagina.shp_4c_ShpAnexa.Visible = loc_lMostraAnexa
    ENDPROC

    *==========================================================================
    * UTILITARIOS
    *==========================================================================

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta visibilidade dos botoes conforme o modo atual
    * Modos: LISTA, INCLUIR, ALTERAR, VISUALIZAR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lEditar
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        *-- Botoes da Page1
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .T.
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = .T.
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = .T.
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
        loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = .T.

        *-- Botoes da Page2 (Salvar visivel apenas em edicao)
        loc_oPg2.cnt_4c_Salvar.cmd_4c_Salvar.Visible  = loc_lEditar
        loc_oPg2.cnt_4c_Salvar.cmd_4c_Cancelar.Visible = .T.

        *-- Botoes de cotacao visiveis apenas em modo ALTERAR
        THIS.AtualizarVisibilidadeCotacao()
        THIS.AtualizarVisibilidadeSCotacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF

        par_oGrid.FontName = "Verdana"
        par_oGrid.FontSize = 8
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles do container visiveis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL i, loc_oControl

        IF VARTYPE(par_oContainer) # "O"
            RETURN
        ENDIF

        FOR i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(i)
            *-- Pular containers com nome especifico que devem permanecer ocultos
            IF PEMSTATUS(loc_oControl, "Name", 5) AND ;
               !INLIST(loc_oControl.Name, "cmd_4c_Anexa", "shp_4c_ShpAnexa", ;
                       "txt_4c_COTACAO", "lbl_4c__Cotacao", "cmd_4c_Alteracotacao", ;
                       "txt_4c_SCOTACAO", "lbl_4c__sCotacao", "cmd_4c_Alterascotacao", ;
                       "cnt_4c_Cabecalho", "cnt_4c_Filtros")
                loc_oControl.Visible = .T.
            ENDIF

            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza ao fechar formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*==============================================================================
* sigmvccrBO.prg - Business Object para Movimentos de Conta Corrente Geral
*
* Tabela principal : SigMvCcr
* Chave primaria   : Emps + Nopers (composta)
* Herda de         : BusinessBase
*
* FASE 1/8 - Declaracoes de propriedades e Init()
* Fases seguintes adicionarao: CarregarDoCursor, Inserir, Atualizar,
*   ExecutarExclusao, Buscar, CarregarPorCodigo
*==============================================================================

DEFINE CLASS sigmvccrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao da tabela (nomes CORRETOS do BusinessBase)
    *--------------------------------------------------------------------------
    this_cTabela      = "SigMvCcr"
    this_cCampoChave  = "Nopers"

    *--------------------------------------------------------------------------
    * Chave primaria composta: Emps + Nopers
    *--------------------------------------------------------------------------
    this_cEmps        = ""    && C(3)  - Empresa (parte 1 da PK)
    this_nNopers      = 0     && N     - Numero da Operacao (parte 2 da PK)

    *--------------------------------------------------------------------------
    * Operacao e vinculo com outros documentos
    *--------------------------------------------------------------------------
    this_cOpers       = ""    && C(1)  - Tipo: D=Debito / C=Credito
    this_cSopers      = ""    && C(1)  - Contra-operacao: C/D (espelho)
    this_cDopes       = ""    && C     - Tipo documento debito vinculado
    this_nNumes       = 0     && N     - Numero documento debito vinculado
    this_cDopcs       = ""    && C     - Tipo documento credito vinculado
    this_nNumcs       = 0     && N     - Numero documento credito vinculado
    this_cVOpers      = ""    && C     - Vinculo de operacao externa

    *--------------------------------------------------------------------------
    * Datas
    *--------------------------------------------------------------------------
    this_dDatas       = {}    && T     - Data do lancamento
    this_dVencs       = {}    && T     - Data de vencimento
    this_dDtEmiss     = {}    && T     - Data de emissao
    this_dDatAlts     = {}    && T     - Data de alteracao
    this_dDatExcs     = {}    && T     - Data de exclusao

    *--------------------------------------------------------------------------
    * Lado Debito
    *--------------------------------------------------------------------------
    this_cGrupos      = ""    && C     - Grupo debito
    this_cContas      = ""    && C     - Conta debito
    this_cMoedas      = ""    && C     - Moeda debito
    this_nCotacaos    = 0     && N     - Cotacao debito
    this_nValors      = 0     && N     - Valor debito

    *--------------------------------------------------------------------------
    * Lado Credito (S = S-side / contra-partida)
    *--------------------------------------------------------------------------
    this_cSgrupos     = ""    && C     - Grupo credito
    this_cScontas     = ""    && C     - Conta credito
    this_cSmoedas     = ""    && C     - Moeda credito
    this_nScotacaos   = 0     && N     - Cotacao credito
    this_nSvalors     = 0     && N     - Valor credito

    *--------------------------------------------------------------------------
    * Historico e documentacao
    *--------------------------------------------------------------------------
    this_cHists       = ""    && C     - Historico linha 1
    this_cHist2s      = ""    && C     - Historico linha 2
    this_cNotas       = ""    && C     - Numero da nota fiscal
    this_cDocus       = ""    && C     - Numero do documento

    *--------------------------------------------------------------------------
    * Job / Centro de custo
    *--------------------------------------------------------------------------
    this_cJobs        = ""    && C     - Codigo do job (conta tipo 10)

    *--------------------------------------------------------------------------
    * Campos de controle interno
    *--------------------------------------------------------------------------
    this_lAutos       = .F.   && L     - Flag auto-lancamento
    this_cGruconmoes  = ""    && C     - Concatenacao Grupo+Conta+Moeda
    this_cCidchaves   = ""    && C     - Chave unica do registro (gerada por fGerUniqueKey)
    this_cCotUsus     = ""    && C     - Cotacao definida manualmente pelo usuario
    this_nContapgs    = 0     && N     - Opcao Lancar Contas (0=Nao)
    this_nConcs       = 0     && N     - Flag conciliado

    *--------------------------------------------------------------------------
    * Auditoria
    *--------------------------------------------------------------------------
    this_cUsualts     = ""    && C     - Usuario que fez a ultima alteracao
    this_cUsuExcs     = ""    && C     - Usuario que fez a exclusao

    *--------------------------------------------------------------------------
    * Propriedades de exibicao (lookup - nao armazenadas na tabela SigMvCcr)
    *--------------------------------------------------------------------------
    this_cDGrupos     = ""    && C     - Descricao do grupo debito (SigCdGcr)
    this_cDContas     = ""    && C     - Descricao da conta debito
    this_cDSgrupos    = ""    && C     - Descricao do grupo credito (SigCdGcr)
    this_cDScontas    = ""    && C     - Descricao da conta credito
    this_cUsuario     = ""    && C     - Nome/login do usuario logado (exibicao)
    this_cDJobs       = ""    && C     - Descricao do job (conta tipo 10)

    *--------------------------------------------------------------------------
    * Propriedades de filtro para Buscar() - periodo
    *--------------------------------------------------------------------------
    this_dDtInicial   = {}    && D     - Data inicial para filtro de periodo
    this_dDtFinal     = {}    && D     - Data final para filtro de periodo

    *==========================================================================
    * METODOS
    *==========================================================================

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista movimentos de conta corrente filtrados por periodo e WHERE
    * par_cFiltro: clausula WHERE adicional (ex: "a.Datas BETWEEN '...' AND '...'")
    *              Se vazio, usa this_dDtInicial e this_dDtFinal como filtro
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere
        LOCAL loc_cDtI, loc_cDtF
        loc_lResultado = .F.

        IF VARTYPE(par_cFiltro) != "C"
            par_cFiltro = ""
        ENDIF

        TRY
            IF !EMPTY(par_cFiltro)
                loc_cWhere = " WHERE " + par_cFiltro
            ELSE
                *-- Usar datas do BO como filtro
                IF !EMPTY(THIS.this_dDtInicial) AND !EMPTY(THIS.this_dDtFinal)
                    loc_cDtI = FormatarDataSQL(THIS.this_dDtInicial)
                    loc_cDtF = FormatarDataSQL(THIS.this_dDtFinal)
                ELSE
                    *-- Padrao: mes atual
                    loc_cDtI = FormatarDataSQL(DATE() - DAY(DATE()) + 1)
                    loc_cDtF = FormatarDataSQL(DATE())
                ENDIF
                loc_cWhere = " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                             " AND a.Opers = 'D'" + ;
                             " AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.nopers, a.opers, a.datas," + ;
                       " a.contas, a.scontas, a.hists, a.hist2s," + ;
                       " a.valors, a.svalors, a.nfs, a.docus," + ;
                       " a.grupos, a.sgrupos, a.moedas, a.smoedas," + ;
                       " a.concs, a.emps, a.vencs, a.cotacaos," + ;
                       " a.scotacaos, a.contapgs, a.jobs, a.dtemis," + ;
                       " a.sopers, a.tipos" + ;
                       " FROM SigMvCcr a" + loc_cWhere + ;
                       " ORDER BY a.datas, a.nopers"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar movimentos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (chave primaria)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.emps, a.nopers, a.opers, a.sopers," + ;
                       " a.dopes, a.numes, a.dopcs, a.numcs, a.vopers," + ;
                       " a.datas, a.vencs, a.dtemis, a.datalts, a.datexcs," + ;
                       " a.grupos, a.contas, a.moedas, a.cotacaos, a.valors," + ;
                       " a.sgrupos, a.scontas, a.smoedas, a.scotacaos, a.svalors," + ;
                       " a.hists, a.hist2s, a.nfs, a.docus, a.jobs," + ;
                       " a.autos, a.gruconmoes, a.cotusus, a.contapgs, a.concs," + ;
                       " a.usualts, a.usuexcs" + ;
                       " FROM SigMvCcr a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidchaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Transfere dados do cursor para propriedades do BO
    * OBRIGATORIO: SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves   = ALLTRIM(TratarNulo(cidchaves,   "C"))
            THIS.this_cEmps        = ALLTRIM(TratarNulo(emps,        "C"))
            THIS.this_nNopers      = TratarNulo(nopers,      "N")
            THIS.this_cOpers       = ALLTRIM(TratarNulo(opers,       "C"))
            THIS.this_cSopers      = ALLTRIM(TratarNulo(sopers,      "C"))
            THIS.this_cDopes       = ALLTRIM(TratarNulo(dopes,       "C"))
            THIS.this_nNumes       = TratarNulo(numes,       "N")
            THIS.this_cDopcs       = ALLTRIM(TratarNulo(dopcs,       "C"))
            THIS.this_nNumcs       = TratarNulo(numcs,       "N")
            THIS.this_cVOpers      = ALLTRIM(TratarNulo(vopers,      "C"))
            THIS.this_dDatas       = TratarNulo(datas,       "D")
            THIS.this_dVencs       = TratarNulo(vencs,       "D")
            THIS.this_dDtEmiss     = TratarNulo(dtemis,      "D")
            THIS.this_dDatAlts     = TratarNulo(datalts,     "D")
            THIS.this_dDatExcs     = TratarNulo(datexcs,     "D")
            THIS.this_cGrupos      = ALLTRIM(TratarNulo(grupos,      "C"))
            THIS.this_cContas      = ALLTRIM(TratarNulo(contas,      "C"))
            THIS.this_cMoedas      = ALLTRIM(TratarNulo(moedas,      "C"))
            THIS.this_nCotacaos    = TratarNulo(cotacaos,    "N")
            THIS.this_nValors      = TratarNulo(valors,      "N")
            THIS.this_cSgrupos     = ALLTRIM(TratarNulo(sgrupos,     "C"))
            THIS.this_cScontas     = ALLTRIM(TratarNulo(scontas,     "C"))
            THIS.this_cSmoedas     = ALLTRIM(TratarNulo(smoedas,     "C"))
            THIS.this_nScotacaos   = TratarNulo(scotacaos,   "N")
            THIS.this_nSvalors     = TratarNulo(svalors,     "N")
            THIS.this_cHists       = ALLTRIM(TratarNulo(hists,       "C"))
            THIS.this_cHist2s      = ALLTRIM(TratarNulo(hist2s,      "C"))
            THIS.this_cNotas       = ALLTRIM(TratarNulo(nfs,         "C"))
            THIS.this_cDocus       = ALLTRIM(TratarNulo(docus,       "C"))
            THIS.this_cJobs        = ALLTRIM(TratarNulo(jobs,        "C"))
            THIS.this_lAutos       = (TratarNulo(autos,      "N") = 1)
            THIS.this_cGruconmoes  = ALLTRIM(TratarNulo(gruconmoes,  "C"))
            THIS.this_cCotUsus     = ALLTRIM(TratarNulo(cotusus,     "C"))
            THIS.this_nContapgs    = TratarNulo(contapgs,    "N")
            THIS.this_nConcs       = TratarNulo(concs,       "N")
            THIS.this_cUsualts     = ALLTRIM(TratarNulo(usualts,     "C"))
            THIS.this_cUsuExcs     = ALLTRIM(TratarNulo(usuexcs,     "C"))
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo movimento de conta corrente
    * Gera nopers sequencial e cidchaves = DTOS(datas)+PADL(nopers,12,'0')
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nNopers, loc_cCidchaves
        LOCAL loc_cDtDados, loc_cDtVencs, loc_cDtEmis, loc_nRes
        loc_lResultado = .F.

        *-- Validacoes fora do TRY
        IF EMPTY(THIS.this_cGrupos) OR EMPTY(THIS.this_cContas)
            MsgErro("Grupo e Conta (D" + CHR(233) + "bito) s" + CHR(227) + "o obrigat" + ;
                    CHR(243) + "rios.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cSgrupos) OR EMPTY(THIS.this_cScontas)
            MsgErro("Grupo e Conta (Cr" + CHR(233) + "dito) s" + CHR(227) + "o obrigat" + ;
                    CHR(243) + "rios.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cOpers)
            MsgErro("O tipo de opera" + CHR(231) + CHR(227) + "o (D/C) " + CHR(233) + ;
                    " obrigat" + CHR(243) + "rio.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Gerar proximo nopers para a empresa
            loc_cSQL = "SELECT ISNULL(MAX(nopers), 0) + 1 AS proxNopers" + ;
                       " FROM SigMvCcr WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NextNoper") >= 0
                SELECT cursor_4c_NextNoper
                loc_nNopers = cursor_4c_NextNoper.proxNopers
                IF USED("cursor_4c_NextNoper")
                    USE IN cursor_4c_NextNoper
                ENDIF

                *-- Gerar cidchaves: DTOS(datas) + PADL(nopers,12,'0')
                loc_cDtDados = DTOS(IIF(EMPTY(THIS.this_dDatas), DATE(), THIS.this_dDatas))
                loc_cCidchaves = loc_cDtDados + PADL(TRANSFORM(loc_nNopers), 12, "0")
                THIS.this_cCidchaves = loc_cCidchaves
                THIS.this_nNopers    = loc_nNopers

                *-- Formatar datas para SQL
                loc_cDtDados = FormatarDataSQL(THIS.this_dDatas)
                loc_cDtVencs = FormatarDataSQL(THIS.this_dVencs)
                loc_cDtEmis  = FormatarDataSQL(THIS.this_dDtEmiss)

                *-- gruconmoes = grupos + contas + moedas
                THIS.this_cGruconmoes = ALLTRIM(THIS.this_cGrupos) + ;
                                        ALLTRIM(THIS.this_cContas) + ;
                                        ALLTRIM(THIS.this_cMoedas)

                *-- Montar INSERT com todos os campos NOT NULL da tabela
                loc_cSQL = "INSERT INTO SigMvCcr" + ;
                    " (cidchaves, emps, nopers, opers, sopers," + ;
                    " datas, vencs, dtemis," + ;
                    " grupos, contas, moedas, cotacaos, valors," + ;
                    " sgrupos, scontas, smoedas, scotacaos, svalors," + ;
                    " hists, hist2s, nfs, docus, jobs," + ;
                    " contapgs, concs, autos, usualts, usuexcs," + ;
                    " gruconmoes, cotusus, tipos, shists," + ;
                    " dopes, numes, dopcs, numcs, vopers," + ;
                    " contages, contems, saldocs, saldons, saldos," + ;
                    " valliqs, valocurs, valpags, vlancs," + ;
                    " bcontas, bgrupos, borderos, intconts, nlancs, ntrans," + ;
                    " usuconcs, auditors, valprev," + ;
                    " empdopncs, empdopnums, dopotps," + ;
                    " pagos, usupagos, titcancs, usuconfs," + ;
                    " nopercancs, especienfs, impostos, tpimpostos, titpais," + ;
                    " empccs, locals, titbans, titulos, grupages, grupems)" + ;
                    " VALUES (" + ;
                    EscaparSQL(loc_cCidchaves) + "," + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa) + "," + ;
                    FormatarNumeroSQL(loc_nNopers) + "," + ;
                    EscaparSQL(THIS.this_cOpers) + "," + ;
                    EscaparSQL(THIS.this_cSopers) + "," + ;
                    loc_cDtDados + "," + loc_cDtVencs + "," + loc_cDtEmis + "," + ;
                    EscaparSQL(THIS.this_cGrupos) + "," + ;
                    EscaparSQL(THIS.this_cContas) + "," + ;
                    EscaparSQL(THIS.this_cMoedas) + "," + ;
                    FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                    FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                    EscaparSQL(THIS.this_cSgrupos) + "," + ;
                    EscaparSQL(THIS.this_cScontas) + "," + ;
                    EscaparSQL(THIS.this_cSmoedas) + "," + ;
                    FormatarNumeroSQL(THIS.this_nScotacaos) + "," + ;
                    FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                    EscaparSQL(THIS.this_cHists) + "," + ;
                    EscaparSQL(THIS.this_cHist2s) + "," + ;
                    EscaparSQL(THIS.this_cNotas) + "," + ;
                    EscaparSQL(THIS.this_cDocus) + "," + ;
                    EscaparSQL(THIS.this_cJobs) + "," + ;
                    FormatarNumeroSQL(THIS.this_nContapgs) + "," + ;
                    FormatarNumeroSQL(THIS.this_nConcs) + "," + ;
                    IIF(THIS.this_lAutos, "1", "0") + "," + ;
                    EscaparSQL(gc_4c_UsuarioLogado) + ",''" + "," + ;
                    EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                    EscaparSQL(THIS.this_cCotUsus) + ",''" + "," + ;
                    "''" + "," + ;
                    EscaparSQL(THIS.this_cDopes) + "," + ;
                    FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                    EscaparSQL(THIS.this_cDopcs) + "," + ;
                    FormatarNumeroSQL(THIS.this_nNumcs) + "," + ;
                    EscaparSQL(THIS.this_cVOpers) + "," + ;
                    "'','',0,0,0," + ;
                    "0,0,0,''" + "," + ;
                    "'','',0,0,0,0," + ;
                    "'','',0," + ;
                    "'','',''" + "," + ;
                    "'','',0,''," + ;
                    "0,'',0,0,''" + "," + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa) + ",'','','','','')"

                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRes >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir movimento: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao gerar n" + CHR(250) + "mero de opera" + CHR(231) + CHR(227) + "o: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza movimento de conta corrente existente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        LOCAL loc_cDtDados, loc_cDtVencs, loc_cDtEmis
        loc_lResultado = .F.

        *-- Validacoes fora do TRY
        IF EMPTY(THIS.this_cCidchaves)
            MsgErro("Chave do registro n" + CHR(227) + "o informada para atualiza" + ;
                    CHR(231) + CHR(227) + "o.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cGrupos) OR EMPTY(THIS.this_cContas)
            MsgErro("Grupo e Conta (D" + CHR(233) + "bito) s" + CHR(227) + "o obrigat" + ;
                    CHR(243) + "rios.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Formatar datas para SQL
            loc_cDtDados = FormatarDataSQL(THIS.this_dDatas)
            loc_cDtVencs = FormatarDataSQL(THIS.this_dVencs)
            loc_cDtEmis  = FormatarDataSQL(THIS.this_dDtEmiss)

            *-- Recalcular gruconmoes
            THIS.this_cGruconmoes = ALLTRIM(THIS.this_cGrupos) + ;
                                    ALLTRIM(THIS.this_cContas) + ;
                                    ALLTRIM(THIS.this_cMoedas)

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                " opers       = " + EscaparSQL(THIS.this_cOpers) + "," + ;
                " sopers      = " + EscaparSQL(THIS.this_cSopers) + "," + ;
                " datas       = " + loc_cDtDados + "," + ;
                " vencs       = " + loc_cDtVencs + "," + ;
                " dtemis      = " + loc_cDtEmis + "," + ;
                " grupos      = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                " contas      = " + EscaparSQL(THIS.this_cContas) + "," + ;
                " moedas      = " + EscaparSQL(THIS.this_cMoedas) + "," + ;
                " cotacaos    = " + FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                " valors      = " + FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                " sgrupos     = " + EscaparSQL(THIS.this_cSgrupos) + "," + ;
                " scontas     = " + EscaparSQL(THIS.this_cScontas) + "," + ;
                " smoedas     = " + EscaparSQL(THIS.this_cSmoedas) + "," + ;
                " scotacaos   = " + FormatarNumeroSQL(THIS.this_nScotacaos) + "," + ;
                " svalors     = " + FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                " hists       = " + EscaparSQL(THIS.this_cHists) + "," + ;
                " hist2s      = " + EscaparSQL(THIS.this_cHist2s) + "," + ;
                " nfs         = " + EscaparSQL(THIS.this_cNotas) + "," + ;
                " docus       = " + EscaparSQL(THIS.this_cDocus) + "," + ;
                " jobs        = " + EscaparSQL(THIS.this_cJobs) + "," + ;
                " contapgs    = " + FormatarNumeroSQL(THIS.this_nContapgs) + "," + ;
                " cotusus     = " + EscaparSQL(THIS.this_cCotUsus) + "," + ;
                " gruconmoes  = " + EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                " dopes       = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                " numes       = " + FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                " dopcs       = " + EscaparSQL(THIS.this_cDopcs) + "," + ;
                " numcs       = " + FormatarNumeroSQL(THIS.this_nNumcs) + "," + ;
                " vopers      = " + EscaparSQL(THIS.this_cVOpers) + "," + ;
                " datalts     = GETDATE()," + ;
                " usualts     = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRes >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar movimento: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui movimento: marca DatExcs e deleta o registro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        TRY
            *-- Primeiro: marcar data/usuario de exclusao (soft delete marker)
            loc_cSQL = "UPDATE SigMvCcr" + ;
                       " SET datexcs = GETDATE()," + ;
                       " usuexcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRes < 0
                MsgErro("Erro ao marcar exclus" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Segundo: deletar o registro definitivamente
                loc_cSQL = "DELETE FROM SigMvCcr" + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRes >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir movimento: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

