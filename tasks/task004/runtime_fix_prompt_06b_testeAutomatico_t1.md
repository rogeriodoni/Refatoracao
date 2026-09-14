# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 56% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 421; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 551; Teste 'BtnIncluirNavegacao': pgf_4c_Paginas nao encontrado

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-04-09 12:46:52] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-09 12:46:52] [INFO] Config FPW: (nao fornecido)
[2026-04-09 12:46:52] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-09 12:46:52] [INFO] Timeout: 300 segundos
[2026-04-09 12:46:52] [INFO] Wrapper PRG criado para parametros: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_202qwqsz.prg
[2026-04-09 12:46:52] [INFO] Conteudo do wrapper:
[2026-04-09 12:46:52] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigmvccr', 'C:\4c\tasks\task004', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigmvccr', 'C:\4c\tasks\task004', 'CRUD'
QUIT

[2026-04-09 12:46:52] [INFO] Comando VFP: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_202qwqsz.prg
[2026-04-09 12:46:52] [INFO] VFP output esperado em: C:\4c\tasks\task004\vfp_output.txt
[2026-04-09 12:46:52] [INFO] Executando Visual FoxPro 9...
[2026-04-09 12:46:52] [INFO] Comando completo: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_202qwqsz.prg
[2026-04-09 12:46:52] [INFO] Executando: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_202qwqsz.prg
[2026-04-09 12:46:52] [INFO] Timeout configurado: 300 segundos
[2026-04-09 12:46:55] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-09 12:46:55] [INFO] VFP9 finalizado em 2.7802171 segundos
[2026-04-09 12:46:55] [INFO] Exit Code: 
[2026-04-09 12:46:55] [INFO] 
[2026-04-09 12:46:55] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-09 12:46:55] [INFO]   Wrapper.prg: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_202qwqsz.prg
[2026-04-09 12:46:55] [INFO] 
[2026-04-09 12:46:55] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-09 12:46:55] [INFO] * Auto-generated wrapper for parameters
[2026-04-09 12:46:55] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-09 12:46:55] [INFO] * Parameters: 'Formsigmvccr', 'C:\4c\tasks\task004', 'CRUD'
[2026-04-09 12:46:55] [INFO] 
[2026-04-09 12:46:55] [INFO] * Anti-dialog protections for unattended execution
[2026-04-09 12:46:55] [INFO] SET SAFETY OFF
[2026-04-09 12:46:55] [INFO] SET RESOURCE OFF
[2026-04-09 12:46:55] [INFO] SET TALK OFF
[2026-04-09 12:46:55] [INFO] SET NOTIFY OFF
[2026-04-09 12:46:55] [INFO] SYS(2335, 0)
[2026-04-09 12:46:55] [INFO] 
[2026-04-09 12:46:55] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigmvccr', 'C:\4c\tasks\task004', 'CRUD'
[2026-04-09 12:46:55] [INFO] QUIT
[2026-04-09 12:46:55] [INFO] 
[2026-04-09 12:46:55] [INFO] === Fim do Wrapper.prg ===
[2026-04-09 12:46:55] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigmvccr",
  "timestamp": "20260409124655",
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
      "passou": false,
      "erro": "pgf_4c_Paginas nao encontrado",
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 17 (CONTAKEYPRESS, COTACAOKEYPRESS, DTDATAKEYPRESS, FILTRODTFINALKEYPRESS, FILTRODTINICIALKEYPRESS, GRUPOKEYPRESS, JOBKEYPRESS, KEYPRESS, MOEDAKEYPRESS, OPERKEYPRESS, SCONTAKEYPRESS, SCOTACAOKEYPRESS, SGRUPOKEYPRESS, SMOEDAKEYPRESS, SOPERKEYPRESS, SVALORKEYPRESS, VALORKEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg):
*******************************************************************************
* Formsigmvccr.prg - Formulario Conta Corrente Geral
* Tabela : SigMvCcr
* Herda de: FormBase
* Fase   : 8/8 - COMPLETO (todos os metodos + integracao menu)
*******************************************************************************
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS Formsigmvccr AS FormBase

    *===========================================================================
    * PROPRIEDADES VISUAIS (PILAR 1 - UX FIDELITY)
    *===========================================================================
    Height      = 600
    Width       = 1000
    Caption     = "Conta Corrente Geral"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    BackColor   = RGB(53, 53, 53)

    *===========================================================================
    * PROPRIEDADES DA CLASSE
    *===========================================================================
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - Inicializa o formulario
    * REGRA: Apenas RETURN DODEFAULT() - NAO chamar InicializarForm() aqui!
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Formsigmvccr: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente por FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        *-- Pular SQL se estiver validando UI (sem conexao)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            loc_lSucesso = .T.
            RETURN loc_lSucesso
        ENDIF

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("sigmvccrBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigmvccrBO", "Erro")
                loc_lSucesso = .F.
            ELSE
                *-- Configurar estrutura visual
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Propagar titulo do form para label do cabecalho
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Ativar PageFrame
                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                *-- Carregar dados iniciais do periodo atual
                THIS.CarregarLista()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em InicializarForm: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas
    * Top=-29 esconde as abas; controles internos compensam +29px
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount   = 2
            .Top         = -29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = THIS.Height + 29
            .Tabs        = .F.

            .Page1.Caption   = "Lista"
            .Page2.Caption   = "Dados"
            .Page1.BackColor = RGB(240, 240, 240)
            .Page2.BackColor = RGB(240, 240, 240)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD (7),
    * filtro de periodo e grade de lancamentos (11 colunas).
    * Todos os controles com Top += 29 (compensacao PageFrame.Top=-29)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid, loc_oCnt, loc_oPer
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *--------------------------------------------------------------------
        * CONTAINER CABECALHO (titulo escuro - esquerda do topo)
        * Original: top=2 -> migrado: top = 2 + 29 = 31
        *--------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 31
            .Left          = 0
            .Width         = 453
            .Height        = 75
            .BackStyle     = 1
            .BackColor     = RGB(53, 53, 53)
            .SpecialEffect = 0
            .BorderWidth   = 0
            .Visible     = .T.
        ENDWITH
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Conta Corrente Geral"
            .Top       = 25
            .Left      = 10
            .Width     = 430
            .Height    = 25
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .FontName  = "Tahoma"
            .FontSize  = 12
            .FontBold  = .T.
        ENDWITH

        *--------------------------------------------------------------------
        * CONTAINER BOTOES CRUD - toolbar direita
        * Original: top=0 -> migrado: top = 0 + 29 = 29
        * 7 botoes: Incluir(5), Visualizar(82), Alterar(159), Excluir(236),
        *           Buscar(313), Movimento(390), Encerrar(467)
        *--------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        loc_oCnt = loc_oPagina.cnt_4c_Botoes
        WITH loc_oCnt
            .Top           = 29
            .Left          = 453
            .Width         = THIS.Width - 453
            .Height        = 75
            .BackStyle     = 1
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .BorderWidth   = 0
        ENDWITH

        *-- Incluir
        loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 2
            .Left            = 5
            .Width           = 75
            .Height          = 71
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Visualizar
        loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 2
            .Left            = 82
            .Width           = 75
            .Height          = 71
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Alterar
        loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 2
            .Left            = 159
            .Width           = 75
            .Height          = 71
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Excluir
        loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 2
            .Left            = 236
            .Width           = 75
            .Height          = 71
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Buscar
        loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 2
            .Left            = 313
            .Width           = 75
            .Height          = 71
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Movimento (Anexa - F7 no original, abre SigCdPgr/SigCdLch vinculados)
        loc_oCnt.AddObject("cmd_4c_Movimento", "CommandButton")
        WITH loc_oCnt.cmd_4c_Movimento
            .Caption         = "Movimento"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 2
            .Left            = 390
            .Width           = 75
            .Height          = 71
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Movimento, "Click", THIS, "BtnMovimentoClick")

        *-- Encerrar
        loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 2
            .Left            = 467
            .Width           = 75
            .Height          = 71
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *--------------------------------------------------------------------
        * CONTAINER FILTRO PERIODO
        * top=104 (visual 75 = fim da toolbar) + 29 = 104
        * Estrutura: cnt_4c_Filtros > cnt_4c_Periodo > labels + textboxes
        *--------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top           = 104
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 40
            .BackStyle     = 0
            .SpecialEffect = 0
            .BorderWidth   = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Filtros.AddObject("cnt_4c_Periodo", "Container")
        WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo
            .Top           = 2
            .Left          = 14
            .Width         = 271
            .Height        = 36
            .BackStyle     = 0
            .SpecialEffect = 0
            .BorderWidth   = 0
            .Visible     = .T.
        ENDWITH

        loc_oPer = loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo

        loc_oPer.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPer.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo : "
            .Top       = 10
            .Left      = 17
            .Width     = 54
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPer.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPer.txt_4c_DtInicial
            .Value     = DATE() - DAY(DATE()) + 1
            .Top       = 6
            .Left      = 73
            .Width     = 80
            .Height    = 20
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oPer.txt_4c_DtInicial, "KeyPress", THIS, "FiltroDtInicialKeyPress")

        loc_oPer.AddObject("lbl_4c_Ate", "Label")
        WITH loc_oPer.lbl_4c_Ate
            .Caption   = "at" + CHR(233)
            .Top       = 10
            .Left      = 158
            .Width     = 20
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPer.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPer.txt_4c_DtFinal
            .Value     = DATE()
            .Top       = 6
            .Left      = 184
            .Width     = 80
            .Height    = 20
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oPer.txt_4c_DtFinal, "KeyPress", THIS, "FiltroDtFinalKeyPress")

        *--------------------------------------------------------------------
        * GRADE DE LANCAMENTOS
        * Original: top=115, left=23, width=944, height=473
        * Migrado:  top=144 (115+29), left=23, width=944
        * 11 colunas em ordem visual: Data, O, Conta, Contrapartida,
        *   Historico, Debito, Credito, (interno), NF, Documento, (sim?trico)
        *--------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Dados
        loc_oGrid.Top         = 144
        loc_oGrid.Left        = 23
        loc_oGrid.Width       = 944
        loc_oGrid.Height      = 456
        loc_oGrid.ColumnCount = 11
        loc_oGrid.GridLines   = 3
        loc_oGrid.RecordMark  = .F.
        loc_oGrid.DeleteMark  = .F.
        loc_oGrid.ReadOnly    = .T.
        loc_oGrid.FontName    = "Tahoma"
        loc_oGrid.FontSize    = 8

        *-- Larguras e headers iniciais (reconfigurados em CarregarLista apos RecordSource)
        loc_oGrid.Column1.Width           = 71
        loc_oGrid.Column1.Header1.Caption = "Data"
        loc_oGrid.Column2.Width           = 20
        loc_oGrid.Column2.Header1.Caption = "O"
        loc_oGrid.Column3.Width           = 90
        loc_oGrid.Column3.Header1.Caption = "Conta"
        loc_oGrid.Column4.Width           = 90
        loc_oGrid.Column4.Header1.Caption = "Contrapartida"
        loc_oGrid.Column5.Width           = 200
        loc_oGrid.Column5.Header1.Caption = "Hist" + CHR(243) + "rico"
        loc_oGrid.Column6.Width           = 90
        loc_oGrid.Column6.Header1.Caption = "D" + CHR(233) + "bito"
        loc_oGrid.Column7.Width           = 90
        loc_oGrid.Column7.Header1.Caption = "Cr" + CHR(233) + "dito"
        loc_oGrid.Column8.Width           = 20
        loc_oGrid.Column8.Header1.Caption = ""
        loc_oGrid.Column9.Width           = 65
        loc_oGrid.Column9.Header1.Caption = "NF"
        loc_oGrid.Column10.Width          = 80
        loc_oGrid.Column10.Header1.Caption = "Documento"
        loc_oGrid.Column11.Width          = 20
        loc_oGrid.Column11.Header1.Caption = ""

        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridAfterRowColChange")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2: botoes Confirmar/Cancelar,
    * area do cabecalho (Shape1) e area de movimento esquerda (Shape3).
    * Fase 5: 50% dos campos (cabecalho + movimento esquerdo).
    * Top += 29 (compensacao PageFrame.Top=-29)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oCnt
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *--------------------------------------------------------------------
        * BOTOES ACAO (Confirmar/Cancelar - topo direito)
        * Original: top=9 -> migrado: top = 9 + 29 = 38
        *--------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
        WITH loc_oCnt
            .Top           = 38
            .Left          = 843
            .Width         = 157
            .Height        = 75
            .BackStyle     = 1
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .BorderWidth   = 0
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 2
            .Left            = 5
            .Width           = 75
            .Height          = 71
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

        loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Cancelar
            .Caption         = "Cancelar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 2
            .Left            = 77
            .Width           = 75
            .Height          = 71
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *====================================================================
        * AREA DO CABECALHO (Shape1)
        * Original: top=153, left=9, width=980, height=64
        * Migrado:  top=153+29=182
        *====================================================================
        loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPagina.shp_4c_Shape1
            .Top           = 182
            .Left          = 9
            .Width         = 980
            .Height        = 64
            .BorderStyle   = 1
            .BorderColor   = RGB(192, 192, 192)
            .BackStyle     = 0
            .SpecialEffect = 1
        ENDWITH

        *-- Label Lancamento (Say1): top=165+29=194, left=43
        loc_oPagina.AddObject("lbl_4c_Lancamento", "Label")
        WITH loc_oPagina.lbl_4c_Lancamento
            .Caption   = "Lan" + CHR(231) + "amento :"
            .Top       = 194
            .Left      = 43
            .Width     = 70
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox DATA: top=161+29=190, left=112, width=80
        loc_oPagina.AddObject("txt_4c_Data", "TextBox")
        WITH loc_oPagina.txt_4c_Data
            .Value     = {}
            .Top       = 190
            .Left      = 112
            .Width     = 80
            .Height    = 20
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Data, "KeyPress", THIS, "DtDataKeyPress")

        *-- Label Vencimento (Say10): top=165+29=194, left=234
        loc_oPagina.AddObject("lbl_4c_Vencimento", "Label")
        WITH loc_oPagina.lbl_4c_Vencimento
            .Caption   = "Vencimento :"
            .Top       = 194
            .Left      = 234
            .Width     = 65
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox VENC: top=161+29=190, left=300, width=80
        loc_oPagina.AddObject("txt_4c_Venc", "TextBox")
        WITH loc_oPagina.txt_4c_Venc
            .Value     = {}
            .Top       = 190
            .Left      = 300
            .Width     = 80
            .Height    = 20
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Label Emissao (Say15): top=165+29=194, left=435
        loc_oPagina.AddObject("lbl_4c_Emissao", "Label")
        WITH loc_oPagina.lbl_4c_Emissao
            .Caption   = "Emiss" + CHR(227) + "o :"
            .Top       = 194
            .Left      = 435
            .Width     = 50
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox DtEmis: top=161+29=190, left=484, width=80
        loc_oPagina.AddObject("txt_4c_DtEmis", "TextBox")
        WITH loc_oPagina.txt_4c_DtEmis
            .Value     = {}
            .Top       = 190
            .Left      = 484
            .Width     = 80
            .Height    = 20
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Label Nota Fiscal (Say7): top=165+29=194, left=615
        loc_oPagina.AddObject("lbl_4c_NotaFiscal", "Label")
        WITH loc_oPagina.lbl_4c_NotaFiscal
            .Caption   = "Nota Fiscal :"
            .Top       = 194
            .Left      = 615
            .Width     = 65
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox Nota: top=161+29=190, left=678, width=80
        loc_oPagina.AddObject("txt_4c_Nota", "TextBox")
        WITH loc_oPagina.txt_4c_Nota
            .Value    = ""
            .Top      = 190
            .Left     = 678
            .Width    = 80
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Label Usuario (Say6): top=165+29=194, left=818
        loc_oPagina.AddObject("lbl_4c_Usuario", "Label")
        WITH loc_oPagina.lbl_4c_Usuario
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Top       = 194
            .Left      = 818
            .Width     = 50
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox Usuario (ReadOnly): top=161+29=190, left=865, width=80
        loc_oPagina.AddObject("txt_4c_Usuario", "TextBox")
        WITH loc_oPagina.txt_4c_Usuario
            .Value    = ""
            .Top      = 190
            .Left     = 865
            .Width    = 80
            .Height   = 20
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Label Job (Say17): top=191+29=220, left=84
        loc_oPagina.AddObject("lbl_4c_Job", "Label")
        WITH loc_oPagina.lbl_4c_Job
            .Caption   = "Job :"
            .Top       = 220
            .Left      = 84
            .Width     = 30
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox Job: top=187+29=216, left=112, width=80
        loc_oPagina.AddObject("txt_4c_Job", "TextBox")
        WITH loc_oPagina.txt_4c_Job
            .Value    = ""
            .Top      = 216
            .Left     = 112
            .Width    = 80
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Job, "KeyPress", THIS, "JobKeyPress")

        *-- TextBox DJob (desc job): top=187+29=216, left=195, width=290
        loc_oPagina.AddObject("txt_4c_DJob", "TextBox")
        WITH loc_oPagina.txt_4c_DJob
            .Value    = ""
            .Top      = 216
            .Left     = 195
            .Width    = 290
            .Height   = 20
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Label Documento (Say2): top=191+29=220, left=613
        loc_oPagina.AddObject("lbl_4c_Documento", "Label")
        WITH loc_oPagina.lbl_4c_Documento
            .Caption   = "Documento :"
            .Top       = 220
            .Left      = 613
            .Width     = 60
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox DOCU: top=187+29=216, left=678, width=80
        loc_oPagina.AddObject("txt_4c_DOCU", "TextBox")
        WITH loc_oPagina.txt_4c_DOCU
            .Value    = ""
            .Top      = 216
            .Left     = 678
            .Width    = 80
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *====================================================================
        * AREA MOVIMENTO ESQUERDA (Shape3)
        * Original: top=224, left=9, width=485, height=117
        * Migrado:  top=224+29=253
        *====================================================================
        loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPagina.shp_4c_Shape3
            .Top           = 253
            .Left          = 9
            .Width         = 485
            .Height        = 117
            .BorderStyle   = 1
            .BorderColor   = RGB(192, 192, 192)
            .BackStyle     = 0
            .SpecialEffect = 1
        ENDWITH

        *-- Label Movimento esq (Say3): top=235+29=264, left=49
        loc_oPagina.AddObject("lbl_4c_Movimento", "Label")
        WITH loc_oPagina.lbl_4c_Movimento
            .Caption   = "Movimento :"
            .Top       = 264
            .Left      = 49
            .Width     = 65
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Label [D/C] esq (Say18): top=235+29=264, left=130
        loc_oPagina.AddObject("lbl_4c_DC", "Label")
        WITH loc_oPagina.lbl_4c_DC
            .Caption   = "[D/C]"
            .Top       = 264
            .Left      = 130
            .Width     = 30
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox OPER: top=231+29=260, left=112, width=15
        loc_oPagina.AddObject("txt_4c_Oper", "TextBox")
        WITH loc_oPagina.txt_4c_Oper
            .Value    = ""
            .Top      = 260
            .Left     = 112
            .Width    = 15
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Oper, "KeyPress", THIS, "OperKeyPress")

        *-- Label Grupo esq (Say4): top=261+29=290, left=72
        loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPagina.lbl_4c_Grupo
            .Caption   = "Grupo :"
            .Top       = 290
            .Left      = 72
            .Width     = 40
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox Grupo: top=257+29=286, left=112, width=80
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value    = ""
            .Top      = 286
            .Left     = 112
            .Width    = 80
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "GrupoKeyPress")

        *-- TextBox DGrupo: top=257+29=286, left=195, width=290
        loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DGrupo
            .Value    = ""
            .Top      = 286
            .Left     = 195
            .Width    = 290
            .Height   = 20
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Label Conta esq (Say5): top=287+29=316, left=72
        loc_oPagina.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oPagina.lbl_4c_Conta
            .Caption   = "Conta :"
            .Top       = 316
            .Left      = 72
            .Width     = 40
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox Conta: top=283+29=312, left=112, width=80
        loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.txt_4c_Conta
            .Value    = ""
            .Top      = 312
            .Left     = 112
            .Width    = 80
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ContaKeyPress")

        *-- TextBox DConta: top=283+29=312, left=195, width=290
        loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPagina.txt_4c_DConta
            .Value    = ""
            .Top      = 312
            .Left     = 195
            .Width    = 290
            .Height   = 20
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Label Valor esq (Say8): top=313+29=342, left=77
        loc_oPagina.AddObject("lbl_4c_Valor", "Label")
        WITH loc_oPagina.lbl_4c_Valor
            .Caption   = "Valor :"
            .Top       = 342
            .Left      = 77
            .Width     = 35
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox VALOR: top=309+29=338, left=112, width=128
        loc_oPagina.AddObject("txt_4c_Valor", "TextBox")
        WITH loc_oPagina.txt_4c_Valor
            .Value    = 0
            .Top      = 338
            .Left     = 112
            .Width    = 128
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Valor, "KeyPress", THIS, "ValorKeyPress")

        *-- TextBox MOEDA: top=309+29=338, left=243, width=31
        loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPagina.txt_4c_Moeda
            .Value    = ""
            .Top      = 338
            .Left     = 243
            .Width    = 31
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Moeda, "KeyPress", THIS, "MoedaKeyPress")

        *-- Label Cambio esq (Say_Cotacao): top=313+29=342, left=303
        loc_oPagina.AddObject("lbl_4c_Cambio", "Label")
        WITH loc_oPagina.lbl_4c_Cambio
            .Caption   = "C" + CHR(226) + "mbio :"
            .Top       = 342
            .Left      = 303
            .Width     = 45
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox COTACAO: top=309+29=338, left=349, width=108
        loc_oPagina.AddObject("txt_4c_Cotacao", "TextBox")
        WITH loc_oPagina.txt_4c_Cotacao
            .Value    = 0
            .Top      = 338
            .Left     = 349
            .Width    = 108
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Cotacao, "KeyPress", THIS, "CotacaoKeyPress")

        *-- Botao alteracotacao ($): top=309+29=338, left=461, width=24
        loc_oPagina.AddObject("cmd_4c_AlteraCotacao", "CommandButton")
        WITH loc_oPagina.cmd_4c_AlteraCotacao
            .Caption       = "$"
            .Top           = 338
            .Left          = 461
            .Width         = 24
            .Height        = 20
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Themes        = .F.
            .SpecialEffect = 0
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_AlteraCotacao, "Click", THIS, "BtnAlteraCotacaoClick")

        *====================================================================
        * AREA MOVIMENTO DIREITA - SIMETRICO (Shape2)
        * Original: top=224, left=504, width=485, height=117
        * Migrado:  top=224+29=253
        *====================================================================
        loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPagina.shp_4c_Shape2
            .Top           = 253
            .Left          = 504
            .Width         = 485
            .Height        = 117
            .BorderStyle   = 1
            .BorderColor   = RGB(192, 192, 192)
            .BackStyle     = 0
            .SpecialEffect = 1
        ENDWITH

        *-- Label Movimento dir (Say11): top=235+29=264, left=544
        loc_oPagina.AddObject("lbl_4c_MovimentoS", "Label")
        WITH loc_oPagina.lbl_4c_MovimentoS
            .Caption   = "Movimento :"
            .Top       = 264
            .Left      = 544
            .Width     = 65
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Label [D/C] dir (Say14): top=235+29=264, left=626
        loc_oPagina.AddObject("lbl_4c_DCS", "Label")
        WITH loc_oPagina.lbl_4c_DCS
            .Caption   = "[D/C]"
            .Top       = 264
            .Left      = 626
            .Width     = 30
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox SOper: top=231+29=260, left=607, width=15
        loc_oPagina.AddObject("txt_4c_SOper", "TextBox")
        WITH loc_oPagina.txt_4c_SOper
            .Value    = ""
            .Top      = 260
            .Left     = 607
            .Width    = 15
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SOper, "KeyPress", THIS, "SOperKeyPress")

        *-- Label Grupo dir (Say12): top=261+29=290, left=567
        loc_oPagina.AddObject("lbl_4c_GrupoS", "Label")
        WITH loc_oPagina.lbl_4c_GrupoS
            .Caption   = "Grupo :"
            .Top       = 290
            .Left      = 567
            .Width     = 40
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox SGrupo: top=257+29=286, left=607, width=80
        loc_oPagina.AddObject("txt_4c_SGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_SGrupo
            .Value    = ""
            .Top      = 286
            .Left     = 607
            .Width    = 80
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SGrupo, "KeyPress", THIS, "SGrupoKeyPress")

        *-- TextBox SDGrupo (desc): top=257+29=286, left=689, width=290
        loc_oPagina.AddObject("txt_4c_SDGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_SDGrupo
            .Value    = ""
            .Top      = 286
            .Left     = 689
            .Width    = 290
            .Height   = 20
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Label Conta dir (Say13): top=287+29=316, left=567
        loc_oPagina.AddObject("lbl_4c_ContaS", "Label")
        WITH loc_oPagina.lbl_4c_ContaS
            .Caption   = "Conta :"
            .Top       = 316
            .Left      = 567
            .Width     = 40
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox SConta: top=283+29=312, left=607, width=80
        loc_oPagina.AddObject("txt_4c_SConta", "TextBox")
        WITH loc_oPagina.txt_4c_SConta
            .Value    = ""
            .Top      = 312
            .Left     = 607
            .Width    = 80
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SConta, "KeyPress", THIS, "SContaKeyPress")

        *-- TextBox SDConta (desc): top=283+29=312, left=689, width=290
        loc_oPagina.AddObject("txt_4c_SDConta", "TextBox")
        WITH loc_oPagina.txt_4c_SDConta
            .Value    = ""
            .Top      = 312
            .Left     = 689
            .Width    = 290
            .Height   = 20
            .ReadOnly = .T.
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Label Valor dir (Say16): top=313+29=342, left=572
        loc_oPagina.AddObject("lbl_4c_ValorS", "Label")
        WITH loc_oPagina.lbl_4c_ValorS
            .Caption   = "Valor :"
            .Top       = 342
            .Left      = 572
            .Width     = 35
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox SValor: top=309+29=338, left=607, width=128
        loc_oPagina.AddObject("txt_4c_SValor", "TextBox")
        WITH loc_oPagina.txt_4c_SValor
            .Value    = 0
            .Top      = 338
            .Left     = 607
            .Width    = 128
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SValor, "KeyPress", THIS, "SValorKeyPress")

        *-- TextBox SMoeda: top=309+29=338, left=737, width=31
        loc_oPagina.AddObject("txt_4c_SMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_SMoeda
            .Value    = ""
            .Top      = 338
            .Left     = 737
            .Width    = 31
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SMoeda, "KeyPress", THIS, "SMoedaKeyPress")

        *-- Label Cambio dir (Say_sCotacao): top=313+29=342, left=797
        loc_oPagina.AddObject("lbl_4c_CambioS", "Label")
        WITH loc_oPagina.lbl_4c_CambioS
            .Caption   = "C" + CHR(226) + "mbio :"
            .Top       = 342
            .Left      = 797
            .Width     = 45
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox SCotacao: top=309+29=338, left=843, width=108
        loc_oPagina.AddObject("txt_4c_SCotacao", "TextBox")
        WITH loc_oPagina.txt_4c_SCotacao
            .Value    = 0
            .Top      = 338
            .Left     = 843
            .Width    = 108
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SCotacao, "KeyPress", THIS, "SCotacaoKeyPress")

        *-- Botao alterascotacao ($): top=309+29=338, left=955, width=24
        loc_oPagina.AddObject("cmd_4c_AlterasCotacao", "CommandButton")
        WITH loc_oPagina.cmd_4c_AlterasCotacao
            .Caption       = "$"
            .Top           = 338
            .Left          = 955
            .Width         = 24
            .Height        = 20
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Themes        = .F.
            .SpecialEffect = 0
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_AlterasCotacao, "Click", THIS, "BtnAlterasCotacaoClick")

        *====================================================================
        * AREA HISTORICO (Shape6)
        * Original: top=350, left=9, width=980, height=39
        * Migrado:  top=350+29=379
        *====================================================================
        loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
        WITH loc_oPagina.shp_4c_Shape6
            .Top           = 379
            .Left          = 9
            .Width         = 980
            .Height        = 39
            .BorderStyle   = 1
            .BorderColor   = RGB(192, 192, 192)
            .BackStyle     = 0
            .SpecialEffect = 1
        ENDWITH

        *-- Label Historico (Say9): top=362+29=391, left=60
        loc_oPagina.AddObject("lbl_4c_Historico", "Label")
        WITH loc_oPagina.lbl_4c_Historico
            .Caption   = "Hist" + CHR(243) + "rico :"
            .Top       = 391
            .Left      = 60
            .Width     = 55
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox Hist: top=358+29=387, left=112, width=300
        loc_oPagina.AddObject("txt_4c_Hist", "TextBox")
        WITH loc_oPagina.txt_4c_Hist
            .Value    = ""
            .Top      = 387
            .Left     = 112
            .Width    = 300
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- TextBox Hist2: top=358+29=387, left=415, width=300
        loc_oPagina.AddObject("txt_4c_Hist2", "TextBox")
        WITH loc_oPagina.txt_4c_Hist2
            .Value    = ""
            .Top      = 387
            .Left     = 415
            .Width    = 300
            .Height   = 20
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Label Lancar Contas (Say19): top=362+29=391, left=758
        loc_oPagina.AddObject("lbl_4c_LancarContas", "Label")
        WITH loc_oPagina.lbl_4c_LancarContas
            .Caption   = "Lan" + CHR(231) + "ar Contas :"
            .Top       = 391
            .Left      = 758
            .Width     = 80
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- OptionGroup Opcao_conta: top=356+29=385, left=844, width=99, height=27
        *-- ButtonCount=2: Sim(1) / Nao(2)
        loc_oPagina.AddObject("opt_4c_LancarContas", "OptionGroup")
        WITH loc_oPagina.opt_4c_LancarContas
            .Top         = 385
            .Left        = 844
            .Width       = 99
            .Height      = 27
            .ButtonCount = 2
            .Value       = 1
            .BorderStyle = 0
            .Themes      = .F.
        ENDWITH

        WITH loc_oPagina.opt_4c_LancarContas
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).Top       = 4
            .Buttons(1).Left      = 2
            .Buttons(1).Width     = 45
            .Buttons(1).Height    = 17
            .Buttons(1).AutoSize  = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes    = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).Top       = 4
            .Buttons(2).Left      = 50
            .Buttons(2).Width     = 45
            .Buttons(2).Height    = 17
            .Buttons(2).AutoSize  = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes    = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para lista (par_nPagina=1), recarrega os dados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lSucesso = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AlternarPagina: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega lancamentos no grid pelo periodo do filtro.
    * Usa BO.BuscarPorPeriodo e reconfigura ControlSource + headers apos
    * RecordSource (Problema 48: auto-bind sobrescreve ControlSource anterior).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid, loc_oPer, loc_dDtI, loc_dDtF
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            loc_oPer  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo

            *-- Ler datas do filtro com fallback para o mes atual
            loc_dDtI = loc_oPer.txt_4c_DtInicial.Value
            loc_dDtF = loc_oPer.txt_4c_DtFinal.Value

            IF VARTYPE(loc_dDtI) != "D" OR EMPTY(loc_dDtI)
                loc_dDtI = DATE() - DAY(DATE()) + 1
            ENDIF
            IF VARTYPE(loc_dDtF) != "D" OR EMPTY(loc_dDtF)
                loc_dDtF = DATE()
            ENDIF

            *-- Buscar lancamentos do periodo
            IF !THIS.this_oBusinessObject.BuscarPorPeriodo(loc_dDtI, loc_dDtF, "")
                loc_lSucesso = .F.
            ELSE
                *-- RecordSource FORA de WITH (Problema 36)
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- ControlSource APOS RecordSource (Problema 48: auto-bind reseta)
                loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.Datas"
                loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.Opers"
                loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.Contas"
                loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.Scontas"
                loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.Hists"
                loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.Valors"
                loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.Svalors"
                loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.Nopers"
                loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.Nfs"
                loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.Docus"
                loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.Sopers"

                *-- Redefinir headers APOS RecordSource (Problema 6/32: RecordSource reseta)
                loc_oGrid.Column1.Header1.Caption  = "Data"
                loc_oGrid.Column2.Header1.Caption  = "O"
                loc_oGrid.Column3.Header1.Caption  = "Conta"
                loc_oGrid.Column4.Header1.Caption  = "Contrapartida"
                loc_oGrid.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
                loc_oGrid.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
                loc_oGrid.Column7.Header1.Caption  = "Cr" + CHR(233) + "dito"
                loc_oGrid.Column8.Header1.Caption  = ""
                loc_oGrid.Column9.Header1.Caption  = "NF"
                loc_oGrid.Column10.Header1.Caption = "Documento"
                loc_oGrid.Column11.Header1.Caption = ""

                *-- Redefinir larguras apos RecordSource
                loc_oGrid.Column1.Width  = 71
                loc_oGrid.Column2.Width  = 20
                loc_oGrid.Column3.Width  = 90
                loc_oGrid.Column4.Width  = 90
                loc_oGrid.Column5.Width  = 200
                loc_oGrid.Column6.Width  = 90
                loc_oGrid.Column7.Width  = 90
                loc_oGrid.Column8.Width  = 20
                loc_oGrid.Column9.Width  = 65
                loc_oGrid.Column10.Width = 80
                loc_oGrid.Column11.Width = 20

                THIS.FormatarGridLista(loc_oGrid)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLista: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual da grade da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltroDtInicialKeyPress - ENTER/TAB na data inicial: valida e recarrega
    * REGRA: Usar KeyPress (nao Valid/LostFocus) conforme CLAUDE.md #40
    *--------------------------------------------------------------------------
    PROCEDURE FiltroDtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPer, loc_dDtI, loc_dDtF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPer = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo
            loc_dDtI = loc_oPer.txt_4c_DtInicial.Value
            loc_dDtF = loc_oPer.txt_4c_DtFinal.Value
            *-- Se inicial > final, ajusta final
            IF VARTYPE(loc_dDtI) = "D" AND VARTYPE(loc_dDtF) = "D"
                IF loc_dDtI > loc_dDtF
                    loc_oPer.txt_4c_DtFinal.Value = loc_dDtI
                ENDIF
            ENDIF
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltroDtFinalKeyPress - ENTER/TAB na data final: valida e recarrega
    * REGRA: Usar KeyPress (nao Valid/LostFocus) conforme CLAUDE.md #40
    *--------------------------------------------------------------------------
    PROCEDURE FiltroDtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPer, loc_dDtI, loc_dDtF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPer = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo
            loc_dDtI = loc_oPer.txt_4c_DtInicial.Value
            loc_dDtF = loc_oPer.txt_4c_DtFinal.Value
            *-- Se final < inicial, ajusta inicial
            IF VARTYPE(loc_dDtI) = "D" AND VARTYPE(loc_dDtF) = "D"
                IF loc_dDtF < loc_dDtI
                    loc_oPer.txt_4c_DtInicial.Value = loc_dDtF
                ENDIF
            ENDIF
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GridAfterRowColChange - Registra selecao no grid para operacoes CRUD
    * REGRA: Handler de AfterRowColChange DEVE declarar par_nColIndex (CLAUDE.md #38)
    *--------------------------------------------------------------------------
    PROCEDURE GridAfterRowColChange(par_nColIndex)
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara BO para novo registro e abre Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.pgf_4c_Paginas.Page2.txt_4c_Usuario.Value = gc_4c_UsuarioLogado
        THIS.pgf_4c_Paginas.Page2.txt_4c_Data.Value    = DATE()
        THIS.pgf_4c_Paginas.Page2.txt_4c_Venc.Value    = DATE()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado e abre Page2 somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cEmps, loc_nNopers
        loc_cEmps   = ""
        loc_nNopers = 0

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um lan" + CHR(231) + "amento na lista.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cEmps   = ALLTRIM(cursor_4c_Dados.Emps)
        loc_nNopers = cursor_4c_Dados.Nopers

        IF EMPTY(loc_cEmps) OR loc_nNopers <= 0
            MsgAviso("Registro inv" + CHR(225) + "lido.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorNopers(loc_cEmps, loc_nNopers)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o lan" + CHR(231) + "amento.", "Aviso")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado e abre Page2 para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cEmps, loc_nNopers
        loc_cEmps   = ""
        loc_nNopers = 0

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um lan" + CHR(231) + "amento na lista.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cEmps   = ALLTRIM(cursor_4c_Dados.Emps)
        loc_nNopers = cursor_4c_Dados.Nopers

        IF EMPTY(loc_cEmps) OR loc_nNopers <= 0
            MsgAviso("Registro inv" + CHR(225) + "lido.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorNopers(loc_cEmps, loc_nNopers)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o lan" + CHR(231) + "amento.", "Aviso")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e exclui lancamento selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cEmps, loc_nNopers, loc_lConfirma
        loc_cEmps   = ""
        loc_nNopers = 0
        loc_lConfirma  = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um lan" + CHR(231) + "amento para excluir.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cEmps   = ALLTRIM(cursor_4c_Dados.Emps)
        loc_nNopers = cursor_4c_Dados.Nopers

        IF EMPTY(loc_cEmps) OR loc_nNopers <= 0
            MsgAviso("Registro inv" + CHR(225) + "lido.", "Aviso")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste lan" + CHR(231) + "amento?", ;
            "Confirmar Exclus" + CHR(227) + "o")

        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorNopers(loc_cEmps, loc_nNopers)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Lan" + CHR(231) + "amento exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                THIS.CarregarLista()
            ELSE
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o lan" + CHR(231) + "amento.", "Erro")
            ENDIF
        ELSE
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o lan" + CHR(231) + "amento.", "Aviso")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega lista com periodo atual do filtro
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMovimentoClick - Abre movimentos vinculados ao lancamento (F7 original)
    * Funcionalidade completa requer formas SigCdPgr e SigCdLch (ainda nao migradas)
    *--------------------------------------------------------------------------
    PROCEDURE BtnMovimentoClick()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um lan" + CHR(231) + "amento na lista.", "Aviso")
            RETURN
        ENDIF

        MsgInfo("Funcionalidade de Movimento vinculado requer migra" + CHR(231) + CHR(227) + ;
            "o das formas SigCdPgr e SigCdLch.", "Informa" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Salva inclusao ou alteracao (Page2)
    * FormParaBO transfere campos -> BO antes de Salvar()
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Lan" + CHR(231) + "amento salvo com sucesso!", "Sucesso")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ELSE
            MsgAviso("Erro ao salvar. Verifique os dados.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Descarta alteracoes e volta para lista (Page2)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos controles de Page2 para o BO
    * Fase 5: cabecalho + movimento esquerdo.
    * Fase 6 complementa com movimento direito e historico.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            *-- Cabecalho
            loc_oBO.this_dDatas   = loc_oPg2.txt_4c_Data.Value
            loc_oBO.this_dVencs   = loc_oPg2.txt_4c_Venc.Value
            loc_oBO.this_dDtEmis  = loc_oPg2.txt_4c_DtEmis.Value
            loc_oBO.this_cNotas   = ALLTRIM(loc_oPg2.txt_4c_Nota.Value)
            loc_oBO.this_cDocus   = ALLTRIM(loc_oPg2.txt_4c_DOCU.Value)
            loc_oBO.this_cJobs    = ALLTRIM(loc_oPg2.txt_4c_Job.Value)
            loc_oBO.this_cDJobs   = ALLTRIM(loc_oPg2.txt_4c_DJob.Value)

            *-- Movimento esquerda (principal)
            loc_oBO.this_cOpers   = UPPER(ALLTRIM(loc_oPg2.txt_4c_Oper.Value))
            loc_oBO.this_cGrupos  = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
            loc_oBO.this_cDGrupos = ALLTRIM(loc_oPg2.txt_4c_DGrupo.Value)
            loc_oBO.this_cContas  = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
            loc_oBO.this_cDContas = ALLTRIM(loc_oPg2.txt_4c_DConta.Value)
            loc_oBO.this_nValors  = loc_oPg2.txt_4c_Valor.Value
            loc_oBO.this_cMoedas  = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)
            loc_oBO.this_nCotacaos = loc_oPg2.txt_4c_Cotacao.Value

            *-- Movimento direito (simetrico) - Fase 6
            IF PEMSTATUS(loc_oPg2, "txt_4c_SOper", 5)
                loc_oBO.this_cSopers   = UPPER(ALLTRIM(loc_oPg2.txt_4c_SOper.Value))
                loc_oBO.this_cSGrupos  = ALLTRIM(loc_oPg2.txt_4c_SGrupo.Value)
                loc_oBO.this_cSDGrupos = ALLTRIM(loc_oPg2.txt_4c_SDGrupo.Value)
                loc_oBO.this_cSContas  = ALLTRIM(loc_oPg2.txt_4c_SConta.Value)
                loc_oBO.this_cSDContas = ALLTRIM(loc_oPg2.txt_4c_SDConta.Value)
                loc_oBO.this_nSValors  = loc_oPg2.txt_4c_SValor.Value
                loc_oBO.this_cSMoedas  = ALLTRIM(loc_oPg2.txt_4c_SMoeda.Value)
                loc_oBO.this_nSCotacaos = loc_oPg2.txt_4c_SCotacao.Value
            ENDIF

            *-- Historico - Fase 6
            IF PEMSTATUS(loc_oPg2, "txt_4c_Hist", 5)
                loc_oBO.this_cHists  = ALLTRIM(loc_oPg2.txt_4c_Hist.Value)
                loc_oBO.this_cHist2s = ALLTRIM(loc_oPg2.txt_4c_Hist2.Value)
            ENDIF

            *-- Lancar contas (OptionGroup) - Fase 6
            IF PEMSTATUS(loc_oPg2, "opt_4c_LancarContas", 5)
                loc_oBO.this_nContaPgs = loc_oPg2.opt_4c_LancarContas.Value
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormParaBO: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere propriedades do BO para os controles de Page2
    * Fase 5: cabecalho + movimento esquerdo.
    * Fase 6 complementa com movimento direito e historico.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            *-- Cabecalho
            loc_oPg2.txt_4c_Data.Value    = loc_oBO.this_dDatas
            loc_oPg2.txt_4c_Venc.Value    = loc_oBO.this_dVencs
            loc_oPg2.txt_4c_DtEmis.Value  = loc_oBO.this_dDtEmis
            loc_oPg2.txt_4c_Nota.Value    = loc_oBO.this_cNotas
            loc_oPg2.txt_4c_DOCU.Value    = loc_oBO.this_cDocus
            loc_oPg2.txt_4c_Usuario.Value = loc_oBO.this_cUsualts
            loc_oPg2.txt_4c_Job.Value     = loc_oBO.this_cJobs
            loc_oPg2.txt_4c_DJob.Value    = loc_oBO.this_cDJobs

            *-- Movimento esquerda (principal)
            loc_oPg2.txt_4c_Oper.Value    = loc_oBO.this_cOpers
            loc_oPg2.txt_4c_Grupo.Value   = loc_oBO.this_cGrupos
            loc_oPg2.txt_4c_DGrupo.Value  = loc_oBO.this_cDGrupos
            loc_oPg2.txt_4c_Conta.Value   = loc_oBO.this_cContas
            loc_oPg2.txt_4c_DConta.Value  = loc_oBO.this_cDContas
            loc_oPg2.txt_4c_Valor.Value   = loc_oBO.this_nValors
            loc_oPg2.txt_4c_Moeda.Value   = loc_oBO.this_cMoedas
            loc_oPg2.txt_4c_Cotacao.Value = loc_oBO.this_nCotacaos

            *-- Movimento direito (simetrico) - Fase 6
            IF PEMSTATUS(loc_oPg2, "txt_4c_SOper", 5)
                loc_oPg2.txt_4c_SOper.Value    = loc_oBO.this_cSopers
                loc_oPg2.txt_4c_SGrupo.Value   = loc_oBO.this_cSGrupos
                loc_oPg2.txt_4c_SDGrupo.Value  = loc_oBO.this_cSDGrupos
                loc_oPg2.txt_4c_SConta.Value   = loc_oBO.this_cSContas
                loc_oPg2.txt_4c_SDConta.Value  = loc_oBO.this_cSDContas
                loc_oPg2.txt_4c_SValor.Value   = loc_oBO.this_nSValors
                loc_oPg2.txt_4c_SMoeda.Value   = loc_oBO.this_cSMoedas
                loc_oPg2.txt_4c_SCotacao.Value = loc_oBO.this_nSCotacaos
            ENDIF

            *-- Historico
            IF PEMSTATUS(loc_oPg2, "txt_4c_Hist", 5)
                loc_oPg2.txt_4c_Hist.Value  = loc_oBO.this_cHists
                loc_oPg2.txt_4c_Hist2.Value = loc_oBO.this_cHist2s
            ENDIF

            *-- Lancar contas (OptionGroup)
            IF PEMSTATUS(loc_oPg2, "opt_4c_LancarContas", 5)
                loc_oPg2.opt_4c_LancarContas.Value = loc_oBO.this_nContaPgs
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Itera Pages de PageFrames E Controls de Containers
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Trata PageFrame: itera Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Trata containers com filhos
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    IF loc_oObjeto.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa/inicializa todos os controles de Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Cabecalho
            loc_oPg2.txt_4c_Data.Value    = DATE()
            loc_oPg2.txt_4c_Venc.Value    = DATE()
            loc_oPg2.txt_4c_DtEmis.Value  = {}
            loc_oPg2.txt_4c_Nota.Value    = ""
            loc_oPg2.txt_4c_DOCU.Value    = ""
            loc_oPg2.txt_4c_Usuario.Value = ""
            loc_oPg2.txt_4c_Job.Value     = ""
            loc_oPg2.txt_4c_DJob.Value    = ""

            *-- Movimento esquerda
            loc_oPg2.txt_4c_Oper.Value    = ""
            loc_oPg2.txt_4c_Grupo.Value   = ""
            loc_oPg2.txt_4c_DGrupo.Value  = ""
            loc_oPg2.txt_4c_Conta.Value   = ""
            loc_oPg2.txt_4c_DConta.Value  = ""
            loc_oPg2.txt_4c_Valor.Value   = 0
            loc_oPg2.txt_4c_Moeda.Value   = ""
            loc_oPg2.txt_4c_Cotacao.Value = 0

            *-- Movimento direito (simetrico) - Fase 6
            IF PEMSTATUS(loc_oPg2, "txt_4c_SOper", 5)
                loc_oPg2.txt_4c_SOper.Value    = ""
                loc_oPg2.txt_4c_SGrupo.Value   = ""
                loc_oPg2.txt_4c_SDGrupo.Value  = ""
                loc_oPg2.txt_4c_SConta.Value   = ""
                loc_oPg2.txt_4c_SDConta.Value  = ""
                loc_oPg2.txt_4c_SValor.Value   = 0
                loc_oPg2.txt_4c_SMoeda.Value   = ""
                loc_oPg2.txt_4c_SCotacao.Value = 0
            ENDIF

            *-- Historico
            IF PEMSTATUS(loc_oPg2, "txt_4c_Hist", 5)
                loc_oPg2.txt_4c_Hist.Value  = ""
                loc_oPg2.txt_4c_Hist2.Value = ""
            ENDIF

            *-- Lancar contas: padr~ao = Sim (1)
            IF PEMSTATUS(loc_oPg2, "opt_4c_LancarContas", 5)
                loc_oPg2.opt_4c_LancarContas.Value = 1
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LimparCampos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularSValor - Recalcula o valor simetrico (SValor = Valor*Cot/SCot)
    * Executado ao sair dos campos Valor e Cotacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularSValor()
        LOCAL loc_oPg2, loc_nValor, loc_nCotacao, loc_nSCotacao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_nValor   = loc_oPg2.txt_4c_Valor.Value
            loc_nCotacao = loc_oPg2.txt_4c_Cotacao.Value

            IF PEMSTATUS(loc_oPg2, "txt_4c_SCotacao", 5) AND ;
               PEMSTATUS(loc_oPg2, "txt_4c_SValor", 5)
                loc_nSCotacao = loc_oPg2.txt_4c_SCotacao.Value
                IF loc_nSCotacao > 0
                    loc_oPg2.txt_4c_SValor.Value = loc_nValor * loc_nCotacao / loc_nSCotacao
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RecalcularSValor: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DtDataKeyPress - ENTER/TAB na data: nenhuma acao especial necessaria
    *--------------------------------------------------------------------------
    PROCEDURE DtDataKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        *-- Data validada pelo BO no Salvar; Vencimento copia data se vazio
        LOCAL loc_oPg2
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF EMPTY(loc_oPg2.txt_4c_Venc.Value)
                loc_oPg2.txt_4c_Venc.Value = loc_oPg2.txt_4c_Data.Value
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OperKeyPress - Valida D/C e preenche campo simetrico oposto
    *--------------------------------------------------------------------------
    PROCEDURE OperKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cOper
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2
            loc_cOper = UPPER(ALLTRIM(loc_oPg2.txt_4c_Oper.Value))

            IF !EMPTY(loc_cOper) AND !INLIST(loc_cOper, "D", "C")
                MsgAviso("Digite (D)" + CHR(233) + "bito ou (C)r" + CHR(233) + "dito !!!", "Aviso")
                loc_oPg2.txt_4c_Oper.Value = ""
                RETURN
            ENDIF

            *-- Preenche simetrico oposto se disponivel (Fase 6)
            IF !EMPTY(loc_cOper) AND PEMSTATUS(loc_oPg2, "txt_4c_SOper", 5)
                loc_oPg2.txt_4c_SOper.Value = IIF(loc_cOper = "D", "C", "D")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * JobKeyPress - F4/ENTER: lookup de job em conta tipo 10
    *--------------------------------------------------------------------------
    PROCEDURE JobKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_oPg2, loc_cJob
        IF par_nKeyCode = 63 OR par_nKeyCode = 13  && F4 ou ENTER
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_cJob = ALLTRIM(loc_oPg2.txt_4c_Job.Value)

            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCli", "cursor_4c_BuscaJob", "Iclis", loc_cJob, ;
                    "Buscar Job")

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Iclis", "", "Job")
                        loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaJob")
                        SELECT cursor_4c_BuscaJob
                        loc_oPg2.txt_4c_Job.Value  = ALLTRIM(cursor_4c_BuscaJob.Iclis)
                        loc_oPg2.txt_4c_DJob.Value = ALLTRIM(cursor_4c_BuscaJob.Rclis)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao buscar Job: " + loc_oErro.Message, "Erro")
            ENDTRY

            IF USED("cursor_4c_BuscaJob")
                USE IN cursor_4c_BuscaJob
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoKeyPress - F4/ENTER: lookup de grupo em SigCdGcr
    *--------------------------------------------------------------------------
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_oPg2, loc_cGrupo
        IF par_nKeyCode = 63 OR par_nKeyCode = 13  && F4 ou ENTER
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)

            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
                    "Grupo Conta Corrente")

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                        SELECT cursor_4c_BuscaGrupo
                        loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                        loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao buscar Grupo: " + loc_oErro.Message, "Erro")
            ENDTRY

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaKeyPress - F4/ENTER: lookup de conta em SigCdCli filtrado por grupo
    *--------------------------------------------------------------------------
    PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_oPg2, loc_cConta, loc_cGrupo, loc_cFiltro
        IF par_nKeyCode = 63 OR par_nKeyCode = 13  && F4 ou ENTER
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
            loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)

            loc_cFiltro = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCli", "cursor_4c_BuscaConta", "Iclis", loc_cConta, ;
                    "Conta Corrente", .F., .T., loc_cFiltro)

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Iclis", "", "Conta")
                        loc_oBusca.mAddColuna("Rclis", "", "Nome")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                        SELECT cursor_4c_BuscaConta
                        loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.Iclis)
                        loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao buscar Conta: " + loc_oErro.Message, "Erro")
            ENDTRY

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValorKeyPress - ENTER/TAB: recalcula SValor
    *--------------------------------------------------------------------------
    PROCEDURE ValorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.RecalcularSValor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MoedaKeyPress - F4/ENTER: lookup de moeda em SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE MoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_oPg2, loc_cMoeda
        IF par_nKeyCode = 63 OR par_nKeyCode = 13  && F4 ou ENTER
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cMoeda = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)

            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdMoe", "cursor_4c_BuscaMoeda", "CMoes", loc_cMoeda, ;
                    "Moedas")

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                        SELECT cursor_4c_BuscaMoeda
                        loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao buscar Moeda: " + loc_oErro.Message, "Erro")
            ENDTRY

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CotacaoKeyPress - ENTER/TAB: recalcula SValor
    *--------------------------------------------------------------------------
    PROCEDURE CotacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.RecalcularSValor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlteraCotacaoClick - Altera cotacao da moeda principal
    * Original: abre Form SigOpAlC. SigOpAlC ainda nao foi migrado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlteraCotacaoClick()
        MsgInfo("Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o:" + ;
            CHR(13) + "Requer migra" + CHR(231) + CHR(227) + "o do Form SigOpAlC.", ;
            "Informa" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * SOperKeyPress - Valida D/C simetrico e preenche Oper oposto
    *--------------------------------------------------------------------------
    PROCEDURE SOperKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cSOper
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cSOper = UPPER(ALLTRIM(loc_oPg2.txt_4c_SOper.Value))

            IF !EMPTY(loc_cSOper) AND !INLIST(loc_cSOper, "D", "C")
                MsgAviso("Digite (D)" + CHR(233) + "bito ou (C)r" + CHR(233) + "dito !!!", "Aviso")
                loc_oPg2.txt_4c_SOper.Value = ""
                RETURN
            ENDIF

            *-- Preenche Oper oposto
            IF !EMPTY(loc_cSOper)
                loc_oPg2.txt_4c_Oper.Value = IIF(loc_cSOper = "D", "C", "D")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SGrupoKeyPress - F4/ENTER: lookup de grupo simetrico em SigCdGcr
    *--------------------------------------------------------------------------
    PROCEDURE SGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_oPg2, loc_cSGrupo
        IF par_nKeyCode = 63 OR par_nKeyCode = 13  && F4 ou ENTER
            loc_oPg2    = THIS.pgf_4c_Paginas.Page2
            loc_cSGrupo = ALLTRIM(loc_oPg2.txt_4c_SGrupo.Value)

            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_BuscaSGrupo", "Codigos", loc_cSGrupo, ;
                    "Grupo Conta Corrente")

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGrupo")
                        SELECT cursor_4c_BuscaSGrupo
                        loc_oPg2.txt_4c_SGrupo.Value  = ALLTRIM(cursor_4c_BuscaSGrupo.Codigos)
                        loc_oPg2.txt_4c_SDGrupo.Value = ALLTRIM(cursor_4c_BuscaSGrupo.Descrs)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao buscar SGrupo: " + loc_oErro.Message, "Erro")
            ENDTRY

            IF USED("cursor_4c_BuscaSGrupo")
                USE IN cursor_4c_BuscaSGrupo
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SContaKeyPress - F4/ENTER: lookup de conta simetrica em SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE SContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_oPg2, loc_cSConta, loc_cSGrupo, loc_cFiltro
        IF par_nKeyCode = 63 OR par_nKeyCode = 13  && F4 ou ENTER
            loc_oPg2    = THIS.pgf_4c_Paginas.Page2
            loc_cSConta = ALLTRIM(loc_oPg2.txt_4c_SConta.Value)
            loc_cSGrupo = ALLTRIM(loc_oPg2.txt_4c_SGrupo.Value)

            loc_cFiltro = ""
            IF !EMPTY(loc_cSGrupo)
                loc_cFiltro = "grupos = " + EscaparSQL(loc_cSGrupo)
            ENDIF

            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCli", "cursor_4c_BuscaSConta", "Iclis", loc_cSConta, ;
                    "Conta Corrente", .F., .T., loc_cFiltro)

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Iclis", "", "Conta")
                        loc_oBusca.mAddColuna("Rclis", "", "Nome")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSConta")
                        SELECT cursor_4c_BuscaSConta
                        loc_oPg2.txt_4c_SConta.Value  = ALLTRIM(cursor_4c_BuscaSConta.Iclis)
                        loc_oPg2.txt_4c_SDConta.Value = ALLTRIM(cursor_4c_BuscaSConta.Rclis)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao buscar SConta: " + loc_oErro.Message, "Erro")
            ENDTRY

            IF USED("cursor_4c_BuscaSConta")
                USE IN cursor_4c_BuscaSConta
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SValorKeyPress - ENTER/TAB: quando usuario altera SValor manualmente,
    * recalcula SCotacao = (Valor * Cotacao) / SValor  (logica inversa)
    * Original: Get_SVALOR.Valid - If This.peAntvalue # This.Value And !IsEmpty(...)
    *--------------------------------------------------------------------------
    PROCEDURE SValorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.RecalcularSCotacao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularSCotacao - Calcula SCotacao = (Valor * Cotacao) / SValor
    * Executado quando usuario digita SValor manualmente.
    * Original: Get_SVALOR.Valid - .get_sCotacao.Value = (.get_Valor.Value * .get_Cotacao.Value) / This.Value
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularSCotacao()
        LOCAL loc_oPg2, loc_nValor, loc_nCotacao, loc_nSValor
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPg2, "txt_4c_SValor", 5) OR ;
           !PEMSTATUS(loc_oPg2, "txt_4c_SCotacao", 5)
            RETURN
        ENDIF

        TRY
            loc_nValor   = loc_oPg2.txt_4c_Valor.Value
            loc_nCotacao = loc_oPg2.txt_4c_Cotacao.Value
            loc_nSValor  = loc_oPg2.txt_4c_SValor.Value

            IF loc_nSValor > 0
                loc_oPg2.txt_4c_SCotacao.Value = (loc_nValor * loc_nCotacao) / loc_nSValor
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RecalcularSCotacao: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * SMoedaKeyPress - F4/ENTER: lookup de moeda simetrica em SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE SMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBusca, loc_oPg2, loc_cSMoeda
        IF par_nKeyCode = 63 OR par_nKeyCode = 13  && F4 ou ENTER
            loc_oPg2    = THIS.pgf_4c_Paginas.Page2
            loc_cSMoeda = ALLTRIM(loc_oPg2.txt_4c_SMoeda.Value)

            TRY
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdMoe", "cursor_4c_BuscaSMoeda", "CMoes", loc_cSMoeda, ;
                    "Moedas")

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSMoeda")
                        SELECT cursor_4c_BuscaSMoeda
                        loc_oPg2.txt_4c_SMoeda.Value = ALLTRIM(cursor_4c_BuscaSMoeda.CMoes)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao buscar SMoeda: " + loc_oErro.Message, "Erro")
            ENDTRY

            IF USED("cursor_4c_BuscaSMoeda")
                USE IN cursor_4c_BuscaSMoeda
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SCotacaoKeyPress - ENTER/TAB: recalcula SValor
    *--------------------------------------------------------------------------
    PROCEDURE SCotacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.RecalcularSValor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterasCotacaoClick - Altera cotacao da moeda simetrica
    * Original: abre Form SigOpAlC. SigOpAlC ainda nao foi migrado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterasCotacaoClick()
        MsgInfo("Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o:" + ;
            CHR(13) + "Requer migra" + CHR(231) + CHR(227) + "o do Form SigOpAlC.", ;
            "Informa" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos editaveis de Page2
    * par_lHabilitar: .T. = edicao, .F. = somente leitura (VISUALIZAR)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lEdit
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_lEdit = (par_lHabilitar = .T.)

        TRY
            *-- Cabecalho: Data, Venc, DtEmis, Nota, DOCU, Job, DJob sao editaveis
            *-- Get_Oper: apenas em INSERIR (nao em ALTERAR)
            loc_oPg2.txt_4c_Data.Enabled   = loc_lEdit
            loc_oPg2.txt_4c_Venc.Enabled   = loc_lEdit
            loc_oPg2.txt_4c_DtEmis.Enabled = loc_lEdit
            loc_oPg2.txt_4c_Nota.Enabled   = loc_lEdit
            loc_oPg2.txt_4c_DOCU.Enabled   = loc_lEdit
            loc_oPg2.txt_4c_Job.Enabled     = loc_lEdit
            loc_oPg2.txt_4c_DJob.Enabled    = loc_lEdit

            *-- Movimento esquerda
            *-- Get_OPER: apenas INSERIR (legado: When retorna INSERIR only)
            loc_oPg2.txt_4c_Oper.Enabled   = (loc_lEdit AND THIS.this_cModoAtual = "INCLUIR")
            loc_oPg2.txt_4c_Grupo.Enabled  = loc_lEdit
            loc_oPg2.txt_4c_DGrupo.Enabled = (loc_lEdit AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)))
            loc_oPg2.txt_4c_Conta.Enabled  = loc_lEdit
            loc_oPg2.txt_4c_DConta.Enabled = (loc_lEdit AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_Conta.Value)))
            loc_oPg2.txt_4c_Valor.Enabled  = loc_lEdit
            loc_oPg2.txt_4c_Moeda.Enabled  = (loc_lEdit AND THIS.this_cModoAtual = "INCLUIR")

            *-- Movimento direito (simetrico)
            IF PEMSTATUS(loc_oPg2, "txt_4c_SOper", 5)
                loc_oPg2.txt_4c_SOper.Enabled   = (loc_lEdit AND THIS.this_cModoAtual = "INCLUIR")
                loc_oPg2.txt_4c_SGrupo.Enabled  = loc_lEdit
                loc_oPg2.txt_4c_SDGrupo.Enabled = (loc_lEdit AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_SGrupo.Value)))
                loc_oPg2.txt_4c_SConta.Enabled  = loc_lEdit
                loc_oPg2.txt_4c_SDConta.Enabled = (loc_lEdit AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_SConta.Value)))
                loc_oPg2.txt_4c_SValor.Enabled  = loc_lEdit
                loc_oPg2.txt_4c_SMoeda.Enabled  = (loc_lEdit AND THIS.this_cModoAtual = "INCLUIR")
            ENDIF

            *-- Historico
            IF PEMSTATUS(loc_oPg2, "txt_4c_Hist", 5)
                loc_oPg2.txt_4c_Hist.Enabled  = loc_lEdit
                loc_oPg2.txt_4c_Hist2.Enabled = loc_lEdit
            ENDIF

            *-- Lancar contas (OptionGroup)
            IF PEMSTATUS(loc_oPg2, "opt_4c_LancarContas", 5)
                loc_oPg2.opt_4c_LancarContas.Enabled = loc_lEdit
            ENDIF

            *-- Botoes Cotacao ($): apenas em modo edicao
            IF PEMSTATUS(loc_oPg2, "cmd_4c_AlteraCotacao", 5)
                loc_oPg2.cmd_4c_AlteraCotacao.Enabled  = loc_lEdit
                loc_oPg2.cmd_4c_AlterasCotacao.Enabled = loc_lEdit
            ENDIF

            *-- Usuario: sempre somente leitura (legado: When = .F.)
            loc_oPg2.txt_4c_Usuario.Enabled = .F.
        CATCH TO loc_oErro
            MsgErro("Erro em HabilitarCampos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta visibilidade/habilitacao dos botoes de Page2
    * segundo o modo atual (INCLUIR / ALTERAR / VISUALIZAR)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lPodeEditar
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2
        loc_lPodeEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        TRY
            *-- Botao Confirmar (Salvar): habilitado apenas em edicao
            IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesDados", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesDados, "cmd_4c_Confirmar", 5)
                    loc_oPg2.cnt_4c_BotoesDados.cmd_4c_Confirmar.Enabled = loc_lPodeEditar
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*******************************************************************************
* sigmvccrBO.prg - Business Object para Conta Corrente Geral
* Tabela : SigMvCcr
* Herda de: BusinessBase
* PK      : Cidchaves (char 20, clustered)
* Chave negocio: Emps + Nopers
* Fase   : 2/8 - Metodos CRUD completos
*******************************************************************************

DEFINE CLASS sigmvccrBO AS BusinessBase

    *===========================================================================
    * IDENTIFICACAO DO REGISTRO
    *===========================================================================
    this_cEmps           = ""    && Empresa (C3)
    this_nNopers         = 0     && Numero da operacao (N7)
    this_cCidChaves      = ""    && Chave unica - PK (C20)

    *===========================================================================
    * DATAS
    *===========================================================================
    this_dDatas          = {}    && Data do lancamento (T NULL)
    this_dVencs          = {}    && Vencimento (T NULL)
    this_dDtEmis         = {}    && Data de emissao - coluna Dtemis (T NULL)
    this_dDatalts        = {}    && Data da alteracao (T NULL)
    this_dDatExcs        = {}    && Data da exclusao logica (T NULL)
    this_dDataConcs      = {}    && Data de conciliacao (T NULL)
    this_dDataTrans      = {}    && Data de transferencia (T NULL)

    *===========================================================================
    * OPERACAO PRINCIPAL (lado debito/credito)
    *===========================================================================
    this_cOpers          = ""    && Operacao D/C (C1)
    this_cGrupos         = ""    && Grupo conta corrente - ref SigCdGcr.Codigos (C10)
    this_cDGrupos        = ""    && Descricao do grupo (derivada via fAcessoContab) (C50)
    this_cContas         = ""    && Conta corrente (C10)
    this_cDContas        = ""    && Descricao da conta (derivada) (C50)
    this_cMoedas         = ""    && Moeda - ref SigCdMoe.CMoes (C3)
    this_nValors         = 0     && Valor do lancamento (N11,2)
    this_nCotacaos       = 0     && Cotacao / cambio (N15,7)

    *===========================================================================
    * OPERACAO SIMETRICA (contrapartida)
    *===========================================================================
    this_cSopers         = ""    && Operacao simetrica D/C (C1)
    this_cSGrupos        = ""    && Grupo simetrico - ref SigCdGcr.Codigos (C10)
    this_cSDGrupos       = ""    && Descricao grupo simetrico (derivada) (C50)
    this_cSContas        = ""    && Conta simetrica (C10)
    this_cSDContas       = ""    && Descricao conta simetrica (derivada) (C50)
    this_cSMoedas        = ""    && Moeda simetrica - ref SigCdMoe.CMoes (C3)
    this_nSValors        = 0     && Valor simetrico (N11,2)
    this_nSCotacaos      = 0     && Cotacao simetrica (N15,7)
    this_cShists         = ""    && Historico simetrico (C40) - coluna Shists

    *===========================================================================
    * HISTORICO E DOCUMENTOS
    *===========================================================================
    this_cHists          = ""    && Historico principal (C60 NULL)
    this_cHist2s         = ""    && Historico complementar (C80 NULL) - coluna Hist2s
    this_cNotas          = ""    && Nota fiscal - coluna Nfs (C10)
    this_cDocus          = ""    && Documento (C10)

    *===========================================================================
    * JOB
    *===========================================================================
    this_cJobs           = ""    && Job (conta tipo 10) - coluna Jobs (C10)
    this_cDJobs          = ""    && Descricao do job (derivada via fAcessoContas) (C50)

    *===========================================================================
    * AUDITORIA E CONTROLE
    *===========================================================================
    this_cUsualts        = ""    && Usuario da alteracao (C10)
    this_cUsuExcs        = ""    && Usuario da exclusao logica (C10)
    this_lAutos          = .F.   && Flag automatico (bit)
    this_lConcs          = .F.   && Flag conciliado (bit)
    this_cUsuConcs       = ""    && Usuario da conciliacao (C10)
    this_cAuditors       = ""    && Auditor (C10)
    this_dDtAudits       = {}    && Data de auditoria (T NULL)

    *===========================================================================
    * CAMPOS INTERNOS DO SISTEMA LEGADO
    *===========================================================================
    this_cVopers         = ""    && Operacao vinculada (C13)
    this_nNumes          = 0     && Numero vinculado - nota pagamento (N6)
    this_cDopes          = ""    && Documento de operacao (C20)
    this_cDopcs          = ""    && Documento de operacao complementar (C20)
    this_nNumcs          = 0     && Numero complementar (N6)
    this_cCotUsus        = ""    && Cotacao informada pelo usuario (C10)
    this_nContaPgs       = 0     && Lancar contas: 0=Nao, outros=Sim (N1)
    this_cGruConMoes     = ""    && Grupo+Conta+Moeda concatenados (C23)
    this_nNlancs         = 0     && Numero de lancamentos (N6)
    this_nNtrans         = 0     && Numero de transacao (N6)
    this_cLocals         = ""    && Local (C10)
    this_cContages       = ""    && Conta de agencia (C10)
    this_cContems        = ""    && Conta empresa (C10)
    this_cTipos          = ""    && Tipo (C1)
    this_cVlancs         = ""    && Valor de lancamento referencia (C10)
    this_cTitulos        = ""    && Titulo vinculado (C10)
    this_cTitBans        = ""    && Titulo bancario (C12)
    this_cGrupages       = ""    && Grupo de agencia (C10)
    this_cGrupems        = ""    && Grupo empresa (C10)
    this_cBContas        = ""    && Banco conta (C10)
    this_cBGrupos        = ""    && Banco grupo (C10)
    this_nBorderos       = 0     && Numero do border? (N6)
    this_nIntConts       = 0     && Numero de integracao (N6)
    this_nSaldos         = 0     && Saldo (N15,2)
    this_nSaldoNs        = 0     && Saldo novo (N15,2)
    this_nSaldoCs        = 0     && Saldo credito (N15,2)
    this_nValpags        = 0     && Valor pago (N11,2)
    this_nValliqs        = 0     && Valor liquido (N11,2)
    this_nValocurs       = 0     && Valor outra moeda (N11,2)
    this_nValprev        = 0     && Valor previsto (N11,2)
    this_cEmpdopncs      = ""    && Emps+Dopes+Numcs composto (C29)
    this_cEmpdopnums     = ""    && Emps+Dopes+Numes composto (C29)
    this_cPagos          = ""    && Flag pago (C1)
    this_cDopotps        = ""    && Documento operacao tipo (C23)
    this_cUsupagos       = ""    && Usuario do pagamento (C10)
    this_nTitcancs       = 0     && Titulo cancelado (N1)
    this_dDtConfs        = {}    && Data de confirmacao (T NULL)
    this_cUsuConfs       = ""    && Usuario de confirmacao (C10)
    this_nNopercancs     = 0     && Nopers cancelado (N7)
    this_cEspecienfs     = ""    && Especie da NF (C6)
    this_nImpostos       = 0     && Impostos (N11,2)
    this_nTpimpostos     = 0     && Tipo de imposto (N2)
    this_cTitPais        = ""    && Titulo pai (C10)
    this_cEmpccs         = ""    && Empresa CC (C3)
    this_nRecor          = 0     && Recorrente (N1)
    this_cCompet         = ""    && Competencia (C7)
    this_cEmpos          = ""    && Empresa operacao (C3)
    this_cOridopnums     = ""    && Documento origem (C29)
    this_cRContas        = ""    && Conta referencia (C10)
    this_cTpdocnf        = ""    && Tipo documento NF (C2)

    *===========================================================================
    * EXIBICAO SOMENTE (derivadas, sem coluna direta no banco)
    *===========================================================================
    this_cUsuarioDisplay = ""    && Usuario logado (somente leitura - get_Usuario)

    *===========================================================================
    * INIT - Configura tabela e campo chave
    *===========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = "Cidchaves"
        RETURN .T.
    ENDPROC

    *===========================================================================
    * OBTERCHAVEPRIMARIA - Retorna chave para registro de auditoria
    *===========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *===========================================================================
    * BUSCAR - Lista lancamentos filtrados (sem filtro de periodo)
    * par_cFiltro: filtro SQL adicional (ex: "Contas = '001'" - sem AND)
    * Cria cursor cursor_4c_Dados com colunas do grid
    *===========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cEmps, loc_cExtra
        loc_lSucesso = .F.

        TRY
            loc_cEmps  = go_4c_Sistema.cCodEmpresa
            loc_cExtra = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cExtra = " AND " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Cidchaves," + ;
                " a.Datas, a.Vencs, a.Dtemis," + ;
                " a.Opers, a.Grupos, a.Contas, a.Moedas, a.Valors, a.Cotacaos," + ;
                " a.Sopers, a.Sgrupos, a.Scontas, a.Smoedas, a.Svalors, a.Scotacaos," + ;
                " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                " a.Jobs, a.Tipos, a.Usualts, a.Usuexcs," + ;
                " a.Concs, a.Contapgs, a.Datexcs," + ;
                " a.Dopes, a.Dopcs, a.Numes, a.Numcs," + ;
                " a.Cotusus, a.Gruconmoes, a.Vopers, a.Vlancs" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Emps = " + EscaparSQL(loc_cEmps) + ;
                loc_cExtra + ;
                " ORDER BY a.Datas DESC, a.Nopers DESC"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lan" + CHR(231) + "amentos:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * BUSCARPORPERIODO - Lista lancamentos filtrados por intervalo de datas
    * par_dDtInicial : data inicial (inclusive)
    * par_dDtFinal   : data final   (inclusive)
    * par_cFiltroExtra: filtro SQL adicional opcional (sem AND)
    * Cria cursor cursor_4c_Dados com colunas do grid
    *===========================================================================
    FUNCTION BuscarPorPeriodo(par_dDtInicial, par_dDtFinal, par_cFiltroExtra)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        LOCAL loc_cEmps, loc_cDtI, loc_cDtF, loc_cExtra
        loc_lSucesso = .F.

        TRY
            loc_cEmps  = go_4c_Sistema.cCodEmpresa
            loc_cDtI   = FormatarDataSQL(par_dDtInicial)
            loc_cDtF   = FormatarDataSQL(par_dDtFinal)
            loc_cExtra = ""
            IF VARTYPE(par_cFiltroExtra) = "C" AND !EMPTY(par_cFiltroExtra)
                loc_cExtra = " AND " + par_cFiltroExtra
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Cidchaves," + ;
                " a.Datas, a.Vencs, a.Dtemis," + ;
                " a.Opers, a.Grupos, a.Contas, a.Moedas, a.Valors, a.Cotacaos," + ;
                " a.Sopers, a.Sgrupos, a.Scontas, a.Smoedas, a.Svalors, a.Scotacaos," + ;
                " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                " a.Jobs, a.Tipos, a.Usualts, a.Usuexcs," + ;
                " a.Concs, a.Contapgs, a.Datexcs," + ;
                " a.Dopes, a.Dopcs, a.Numes, a.Numcs," + ;
                " a.Cotusus, a.Gruconmoes, a.Vopers, a.Vlancs" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Emps = " + EscaparSQL(loc_cEmps) + ;
                "   AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF + ;
                loc_cExtra + ;
                " ORDER BY a.Datas, a.Nopers"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lan" + CHR(231) + "amentos:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BuscarPorPeriodo: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CARREGARPORCODIGO - Carrega lancamento pela PK (Cidchaves)
    * par_cCodigo: valor de Cidchaves
    *===========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Cidchaves," + ;
                " a.Datas, a.Vencs, a.Dtemis, a.Datalts, a.Datexcs, a.Dataconcs," + ;
                " a.Opers, a.Grupos, a.Contas, a.Moedas, a.Valors, a.Cotacaos," + ;
                " a.Sopers, a.Sgrupos, a.Scontas, a.Smoedas, a.Svalors, a.Scotacaos," + ;
                " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                " a.Jobs, a.Tipos, a.Vlancs," + ;
                " a.Usualts, a.Usuexcs, a.Autos, a.Concs," + ;
                " a.Usuconcs, a.Auditors, a.Dtaudits," + ;
                " a.Contapgs, a.Vopers, a.Numes, a.Dopes, a.Dopcs, a.Numcs," + ;
                " a.Cotusus, a.Gruconmoes, a.Locals, a.Contages, a.Contems," + ;
                " a.Titulos, a.Titbans, a.Grupages, a.Grupems," + ;
                " a.Bcontas, a.Bgrupos, a.Borderos, a.Intconts," + ;
                " a.Saldos, a.Saldons, a.Saldocs, a.Valpags, a.Valliqs, a.Valocurs, a.Valprev," + ;
                " a.Empdopncs, a.Empdopnums, a.Pagos, a.Dopotps, a.Usupagos," + ;
                " a.Titcancs, a.Dtconfs, a.Usuconfs, a.Nopercancs, a.Especienfs," + ;
                " a.Impostos, a.Tpimpostos, a.Titpais, a.Empccs, a.Recor," + ;
                " a.Compet, a.Empos, a.Oridopnums, a.Rcontas, a.Tpdocnf," + ;
                " a.Nlancs, a.Ntrans" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Cidchaves = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CARREGARPORNOPERS - Carrega lancamento pela chave de negocio (Emps + Nopers)
    * par_cEmps  : empresa
    * par_nNopers: numero da operacao
    *===========================================================================
    FUNCTION CarregarPorNopers(par_cEmps, par_nNopers)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Cidchaves," + ;
                " a.Datas, a.Vencs, a.Dtemis, a.Datalts, a.Datexcs, a.Dataconcs," + ;
                " a.Opers, a.Grupos, a.Contas, a.Moedas, a.Valors, a.Cotacaos," + ;
                " a.Sopers, a.Sgrupos, a.Scontas, a.Smoedas, a.Svalors, a.Scotacaos," + ;
                " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                " a.Jobs, a.Tipos, a.Vlancs," + ;
                " a.Usualts, a.Usuexcs, a.Autos, a.Concs," + ;
                " a.Usuconcs, a.Auditors, a.Dtaudits," + ;
                " a.Contapgs, a.Vopers, a.Numes, a.Dopes, a.Dopcs, a.Numcs," + ;
                " a.Cotusus, a.Gruconmoes, a.Locals, a.Contages, a.Contems," + ;
                " a.Titulos, a.Titbans, a.Grupages, a.Grupems," + ;
                " a.Bcontas, a.Bgrupos, a.Borderos, a.Intconts," + ;
                " a.Saldos, a.Saldons, a.Saldocs, a.Valpags, a.Valliqs, a.Valocurs, a.Valprev," + ;
                " a.Empdopncs, a.Empdopnums, a.Pagos, a.Dopotps, a.Usupagos," + ;
                " a.Titcancs, a.Dtconfs, a.Usuconfs, a.Nopercancs, a.Especienfs," + ;
                " a.Impostos, a.Tpimpostos, a.Titpais, a.Empccs, a.Recor," + ;
                " a.Compet, a.Empos, a.Oridopnums, a.Rcontas, a.Tpdocnf," + ;
                " a.Nlancs, a.Ntrans" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Emps = " + EscaparSQL(par_cEmps) + ;
                "   AND a.Nopers = " + FormatarNumeroSQL(par_nNopers)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorNopers: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CARREGARDOCURSOR - Transfere dados do cursor para as propriedades this_*
    * par_cAliasCursor: nome do cursor (deve estar selecionado ou existir)
    *===========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidChaves  = TratarNulo(Cidchaves,  "C")
                THIS.this_cEmps       = TratarNulo(Emps,       "C")
                THIS.this_nNopers     = TratarNulo(Nopers,     "N")
                THIS.this_dDatas      = TratarNulo(Datas,      "D")
                THIS.this_dVencs      = TratarNulo(Vencs,      "D")
                THIS.this_dDtEmis     = TratarNulo(Dtemis,     "D")
                THIS.this_cOpers      = TratarNulo(Opers,      "C")
                THIS.this_cGrupos     = TratarNulo(Grupos,     "C")
                THIS.this_cContas     = TratarNulo(Contas,     "C")
                THIS.this_cMoedas     = TratarNulo(Moedas,     "C")
                THIS.this_nValors     = TratarNulo(Valors,     "N")
                THIS.this_nCotacaos   = TratarNulo(Cotacaos,   "N")
                THIS.this_cSopers     = TratarNulo(Sopers,     "C")
                THIS.this_cSGrupos    = TratarNulo(Sgrupos,    "C")
                THIS.this_cSContas    = TratarNulo(Scontas,    "C")
                THIS.this_cSMoedas    = TratarNulo(Smoedas,    "C")
                THIS.this_nSValors    = TratarNulo(Svalors,    "N")
                THIS.this_nSCotacaos  = TratarNulo(Scotacaos,  "N")
                THIS.this_cShists     = TratarNulo(Shists,     "C")
                THIS.this_cHists      = TratarNulo(Hists,      "C")
                THIS.this_cNotas      = TratarNulo(Nfs,        "C")
                THIS.this_cDocus      = TratarNulo(Docus,      "C")
                THIS.this_cJobs       = TratarNulo(Jobs,       "C")
                THIS.this_cTipos      = TratarNulo(Tipos,      "C")
                THIS.this_cUsualts    = TratarNulo(Usualts,    "C")
                THIS.this_cUsuExcs    = TratarNulo(Usuexcs,    "C")
                THIS.this_lAutos      = (NVL(Autos,  0) = 1)
                THIS.this_lConcs      = (NVL(Concs,  0) = 1)
                THIS.this_nContaPgs   = TratarNulo(Contapgs,  "N")
                THIS.this_cVopers     = TratarNulo(Vopers,    "C")
                THIS.this_nNumes      = TratarNulo(Numes,     "N")
                THIS.this_cDopes      = TratarNulo(Dopes,     "C")
                THIS.this_cDopcs      = TratarNulo(Dopcs,     "C")
                THIS.this_nNumcs      = TratarNulo(Numcs,     "N")
                THIS.this_cCotUsus    = TratarNulo(Cotusus,   "C")
                THIS.this_cGruConMoes = TratarNulo(Gruconmoes,"C")
                THIS.this_cVlancs     = TratarNulo(Vlancs,    "C")

                *-- Campos opcionais (apenas em carregamento completo - CarregarPorCodigo)
                IF TYPE("Hist2s") != "U"
                    THIS.this_cHist2s = TratarNulo(Hist2s, "C")
                ENDIF
                IF TYPE("Datalts") != "U"
                    THIS.this_dDatalts = TratarNulo(Datalts, "D")
                ENDIF
                IF TYPE("Datexcs") != "U"
                    THIS.this_dDatExcs = TratarNulo(Datexcs, "D")
                ENDIF
                IF TYPE("Dataconcs") != "U"
                    THIS.this_dDataConcs = TratarNulo(Dataconcs, "D")
                ENDIF
                IF TYPE("Usuconcs") != "U"
                    THIS.this_cUsuConcs = TratarNulo(Usuconcs, "C")
                ENDIF
                IF TYPE("Auditors") != "U"
                    THIS.this_cAuditors = TratarNulo(Auditors, "C")
                ENDIF
                IF TYPE("Dtaudits") != "U"
                    THIS.this_dDtAudits = TratarNulo(Dtaudits, "D")
                ENDIF
                IF TYPE("Locals") != "U"
                    THIS.this_cLocals = TratarNulo(Locals, "C")
                ENDIF
                IF TYPE("Contages") != "U"
                    THIS.this_cContages = TratarNulo(Contages, "C")
                ENDIF
                IF TYPE("Contems") != "U"
                    THIS.this_cContems = TratarNulo(Contems, "C")
                ENDIF
                IF TYPE("Titulos") != "U"
                    THIS.this_cTitulos = TratarNulo(Titulos, "C")
                ENDIF
                IF TYPE("Titbans") != "U"
                    THIS.this_cTitBans = TratarNulo(Titbans, "C")
                ENDIF
                IF TYPE("Grupages") != "U"
                    THIS.this_cGrupages = TratarNulo(Grupages, "C")
                ENDIF
                IF TYPE("Grupems") != "U"
                    THIS.this_cGrupems = TratarNulo(Grupems, "C")
                ENDIF
                IF TYPE("Bcontas") != "U"
                    THIS.this_cBContas = TratarNulo(Bcontas, "C")
                ENDIF
                IF TYPE("Bgrupos") != "U"
                    THIS.this_cBGrupos = TratarNulo(Bgrupos, "C")
                ENDIF
                IF TYPE("Borderos") != "U"
                    THIS.this_nBorderos = TratarNulo(Borderos, "N")
                ENDIF
                IF TYPE("Intconts") != "U"
                    THIS.this_nIntConts = TratarNulo(Intconts, "N")
                ENDIF
                IF TYPE("Saldos") != "U"
                    THIS.this_nSaldos = TratarNulo(Saldos, "N")
                ENDIF
                IF TYPE("Saldons") != "U"
                    THIS.this_nSaldoNs = TratarNulo(Saldons, "N")
                ENDIF
                IF TYPE("Saldocs") != "U"
                    THIS.this_nSaldoCs = TratarNulo(Saldocs, "N")
                ENDIF
                IF TYPE("Valpags") != "U"
                    THIS.this_nValpags = TratarNulo(Valpags, "N")
                ENDIF
                IF TYPE("Valliqs") != "U"
                    THIS.this_nValliqs = TratarNulo(Valliqs, "N")
                ENDIF
                IF TYPE("Valocurs") != "U"
                    THIS.this_nValocurs = TratarNulo(Valocurs, "N")
                ENDIF
                IF TYPE("Valprev") != "U"
                    THIS.this_nValprev = TratarNulo(Valprev, "N")
                ENDIF
                IF TYPE("Empdopncs") != "U"
                    THIS.this_cEmpdopncs = TratarNulo(Empdopncs, "C")
                ENDIF
                IF TYPE("Empdopnums") != "U"
                    THIS.this_cEmpdopnums = TratarNulo(Empdopnums, "C")
                ENDIF
                IF TYPE("Pagos") != "U"
                    THIS.this_cPagos = TratarNulo(Pagos, "C")
                ENDIF
                IF TYPE("Dopotps") != "U"
                    THIS.this_cDopotps = TratarNulo(Dopotps, "C")
                ENDIF
                IF TYPE("Usupagos") != "U"
                    THIS.this_cUsupagos = TratarNulo(Usupagos, "C")
                ENDIF
                IF TYPE("Titcancs") != "U"
                    THIS.this_nTitcancs = TratarNulo(Titcancs, "N")
                ENDIF
                IF TYPE("Dtconfs") != "U"
                    THIS.this_dDtConfs = TratarNulo(Dtconfs, "D")
                ENDIF
                IF TYPE("Usuconfs") != "U"
                    THIS.this_cUsuConfs = TratarNulo(Usuconfs, "C")
                ENDIF
                IF TYPE("Nopercancs") != "U"
                    THIS.this_nNopercancs = TratarNulo(Nopercancs, "N")
                ENDIF
                IF TYPE("Especienfs") != "U"
                    THIS.this_cEspecienfs = TratarNulo(Especienfs, "C")
                ENDIF
                IF TYPE("Impostos") != "U"
                    THIS.this_nImpostos = TratarNulo(Impostos, "N")
                ENDIF
                IF TYPE("Tpimpostos") != "U"
                    THIS.this_nTpimpostos = TratarNulo(Tpimpostos, "N")
                ENDIF
                IF TYPE("Titpais") != "U"
                    THIS.this_cTitPais = TratarNulo(Titpais, "C")
                ENDIF
                IF TYPE("Empccs") != "U"
                    THIS.this_cEmpccs = TratarNulo(Empccs, "C")
                ENDIF
                IF TYPE("Recor") != "U"
                    THIS.this_nRecor = TratarNulo(Recor, "N")
                ENDIF
                IF TYPE("Compet") != "U"
                    THIS.this_cCompet = TratarNulo(Compet, "C")
                ENDIF
                IF TYPE("Empos") != "U"
                    THIS.this_cEmpos = TratarNulo(Empos, "C")
                ENDIF
                IF TYPE("Oridopnums") != "U"
                    THIS.this_cOridopnums = TratarNulo(Oridopnums, "C")
                ENDIF
                IF TYPE("Rcontas") != "U"
                    THIS.this_cRContas = TratarNulo(Rcontas, "C")
                ENDIF
                IF TYPE("Tpdocnf") != "U"
                    THIS.this_cTpdocnf = TratarNulo(Tpdocnf, "C")
                ENDIF
                IF TYPE("Nlancs") != "U"
                    THIS.this_nNlancs = TratarNulo(Nlancs, "N")
                ENDIF
                IF TYPE("Ntrans") != "U"
                    THIS.this_nNtrans = TratarNulo(Ntrans, "N")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarDoCursor: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * GERARNEXTNOPER - Gera o proximo numero de operacao para a empresa corrente
    * Retorna 0 em caso de erro
    *===========================================================================
    PROTECTED FUNCTION GerarNextNoper()
        LOCAL loc_cSQL, loc_nResult, loc_nProxNoper
        loc_nProxNoper = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(Nopers), 0) + 1 AS ProxNoper" + ;
                " FROM SigMvCcr" + ;
                " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxNoper")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ProxNoper") > 0
                SELECT cursor_4c_ProxNoper
                loc_nProxNoper = TratarNulo(ProxNoper, "N")
            ENDIF

            IF USED("cursor_4c_ProxNoper")
                USE IN cursor_4c_ProxNoper
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar pr" + CHR(243) + "ximo noper: " + loc_oErro.Message, "Erro")
            loc_nProxNoper = 0
        ENDTRY

        RETURN loc_nProxNoper
    ENDFUNC

    *===========================================================================
    * INSERIR - Insere novo lancamento em SigMvCcr
    * Gera automaticamente: Nopers, Cidchaves, Gruconmoes, Emps
    *===========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        LOCAL loc_nNopers, loc_cCidChaves, loc_cGruConMoes
        loc_lSucesso = .F.

        TRY
            *-- Gera proximo nopers
            loc_nNopers = THIS.GerarNextNoper()
            IF loc_nNopers <= 0
                MsgErro("Erro ao gerar n" + CHR(250) + "mero de opera" + CHR(231) + CHR(227) + "o!", "Erro")
                loc_lSucesso = .F.
            ELSE
                *-- Gera cidchaves: AAAAMMDD + 6 digitos do nopers (formato do legado)
                loc_cCidChaves = DTOS(IIF(EMPTY(THIS.this_dDatas), DATE(), THIS.this_dDatas)) + ;
                    PADL(LTRIM(STR(loc_nNopers)), 6, "0")

            *-- Gera gruconmoes (grupos+contas+moedas concatenados)
            loc_cGruConMoes = PADR(ALLTRIM(THIS.this_cGrupos), 10) + ;
                PADR(ALLTRIM(THIS.this_cContas), 10) + ;
                PADR(ALLTRIM(THIS.this_cMoedas), 3)

            *-- Atualiza propriedades geradas
            THIS.this_nNopers     = loc_nNopers
            THIS.this_cCidChaves  = loc_cCidChaves
            THIS.this_cGruConMoes = loc_cGruConMoes
            THIS.this_cEmps       = go_4c_Sistema.cCodEmpresa
            THIS.this_lAutos      = .F.
            THIS.this_cUsualts    = gc_4c_UsuarioLogado
            THIS.this_dDatalts    = DATETIME()

            loc_cSQL = "INSERT INTO SigMvCcr (" + ;
                "Emps, Nopers, Cidchaves, " + ;
                "Datas, Vencs, Dtemis, " + ;
                "Opers, Grupos, Contas, Moedas, Valors, Cotacaos, " + ;
                "Sopers, Sgrupos, Scontas, Smoedas, Svalors, Scotacaos, " + ;
                "Hists, Hist2s, Shists, Nfs, Docus, " + ;
                "Jobs, Tipos, Vlancs, " + ;
                "Usualts, Datalts, Autos, Concs, " + ;
                "Usuconcs, Auditors, " + ;
                "Contapgs, Vopers, Numes, Dopes, Dopcs, Numcs, " + ;
                "Cotusus, Gruconmoes, " + ;
                "Locals, Contages, Contems, " + ;
                "Titulos, Titbans, Grupages, Grupems, " + ;
                "Bcontas, Bgrupos, Borderos, Intconts, " + ;
                "Saldos, Saldons, Saldocs, Valpags, Valliqs, Valocurs, Valprev, " + ;
                "Empdopncs, Empdopnums, Pagos, Dopotps, Usupagos, " + ;
                "Titcancs, Usuconfs, Nopercancs, Especienfs, " + ;
                "Impostos, Tpimpostos, Titpais, Empccs, Recor, " + ;
                "Compet, Empos, Oridopnums, Rcontas, Tpdocnf, " + ;
                "Nlancs, Ntrans, Usuexcs" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cEmps) + "," + ;
                FormatarNumeroSQL(THIS.this_nNopers) + "," + ;
                EscaparSQL(loc_cCidChaves) + "," + ;
                IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + "," + ;
                IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + "," + ;
                IIF(EMPTY(THIS.this_dDtEmis), "NULL", FormatarDataSQL(THIS.this_dDtEmis)) + "," + ;
                EscaparSQL(THIS.this_cOpers) + "," + ;
                EscaparSQL(THIS.this_cGrupos) + "," + ;
                EscaparSQL(THIS.this_cContas) + "," + ;
                EscaparSQL(THIS.this_cMoedas) + "," + ;
                FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                EscaparSQL(THIS.this_cSopers) + "," + ;
                EscaparSQL(THIS.this_cSGrupos) + "," + ;
                EscaparSQL(THIS.this_cSContas) + "," + ;
                EscaparSQL(THIS.this_cSMoedas) + "," + ;
                FormatarNumeroSQL(THIS.this_nSValors) + "," + ;
                FormatarNumeroSQL(THIS.this_nSCotacaos) + "," + ;
                EscaparSQL(THIS.this_cHists) + "," + ;
                EscaparSQL(THIS.this_cHist2s) + "," + ;
                EscaparSQL(THIS.this_cShists) + "," + ;
                EscaparSQL(THIS.this_cNotas) + "," + ;
                EscaparSQL(THIS.this_cDocus) + "," + ;
                EscaparSQL(THIS.this_cJobs) + "," + ;
                EscaparSQL(THIS.this_cTipos) + "," + ;
                EscaparSQL(THIS.this_cVlancs) + "," + ;
                EscaparSQL(THIS.this_cUsualts) + "," + ;
                FormatarDataSQL(THIS.this_dDatalts) + "," + ;
                IIF(THIS.this_lAutos, "1", "0") + "," + ;
                IIF(THIS.this_lConcs, "1", "0") + "," + ;
                EscaparSQL(THIS.this_cUsuConcs) + "," + ;
                EscaparSQL(THIS.this_cAuditors) + "," + ;
                FormatarNumeroSQL(THIS.this_nContaPgs) + "," + ;
                EscaparSQL(THIS.this_cVopers) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                EscaparSQL(THIS.this_cDopes) + "," + ;
                EscaparSQL(THIS.this_cDopcs) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumcs) + "," + ;
                EscaparSQL(THIS.this_cCotUsus) + "," + ;
                EscaparSQL(loc_cGruConMoes) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cContages) + "," + ;
                EscaparSQL(THIS.this_cContems) + "," + ;
                EscaparSQL(THIS.this_cTitulos) + "," + ;
                EscaparSQL(THIS.this_cTitBans) + "," + ;
                EscaparSQL(THIS.this_cGrupages) + "," + ;
                EscaparSQL(THIS.this_cGrupems) + "," + ;
                EscaparSQL(THIS.this_cBContas) + "," + ;
                EscaparSQL(THIS.this_cBGrupos) + "," + ;
                FormatarNumeroSQL(THIS.this_nBorderos) + "," + ;
                FormatarNumeroSQL(THIS.this_nIntConts) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldos) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldoNs) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldoCs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValpags) + "," + ;
                FormatarNumeroSQL(THIS.this_nValliqs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValocurs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValprev) + "," + ;
                EscaparSQL(THIS.this_cEmpdopncs) + "," + ;
                EscaparSQL(THIS.this_cEmpdopnums) + "," + ;
                EscaparSQL(THIS.this_cPagos) + "," + ;
                EscaparSQL(THIS.this_cDopotps) + "," + ;
                EscaparSQL(THIS.this_cUsupagos) + "," + ;
                FormatarNumeroSQL(THIS.this_nTitcancs) + "," + ;
                EscaparSQL(THIS.this_cUsuConfs) + "," + ;
                FormatarNumeroSQL(THIS.this_nNopercancs) + "," + ;
                EscaparSQL(THIS.this_cEspecienfs) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpostos) + "," + ;
                FormatarNumeroSQL(THIS.this_nTpimpostos) + "," + ;
                EscaparSQL(THIS.this_cTitPais) + "," + ;
                EscaparSQL(THIS.this_cEmpccs) + "," + ;
                FormatarNumeroSQL(THIS.this_nRecor) + "," + ;
                EscaparSQL(THIS.this_cCompet) + "," + ;
                EscaparSQL(THIS.this_cEmpos) + "," + ;
                EscaparSQL(THIS.this_cOridopnums) + "," + ;
                EscaparSQL(THIS.this_cRContas) + "," + ;
                EscaparSQL(THIS.this_cTpdocnf) + "," + ;
                FormatarNumeroSQL(THIS.this_nNlancs) + "," + ;
                FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
                EscaparSQL(THIS.this_cUsuExcs) + ;
                ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * ATUALIZAR - Atualiza lancamento existente identificado por Emps + Nopers
    * Atualiza apenas os campos editaveis pelo usuario na interface
    *===========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cGruConMoes
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsualts    = gc_4c_UsuarioLogado
            THIS.this_dDatalts    = DATETIME()

            loc_cGruConMoes = PADR(ALLTRIM(THIS.this_cGrupos), 10) + ;
                PADR(ALLTRIM(THIS.this_cContas), 10) + ;
                PADR(ALLTRIM(THIS.this_cMoedas), 3)
            THIS.this_cGruConMoes = loc_cGruConMoes

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                " Datas      = " + IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + "," + ;
                " Vencs      = " + IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + "," + ;
                " Dtemis     = " + IIF(EMPTY(THIS.this_dDtEmis), "NULL", FormatarDataSQL(THIS.this_dDtEmis)) + "," + ;
                " Opers      = " + EscaparSQL(THIS.this_cOpers) + "," + ;
                " Grupos     = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                " Contas     = " + EscaparSQL(THIS.this_cContas) + "," + ;
                " Moedas     = " + EscaparSQL(THIS.this_cMoedas) + "," + ;
                " Valors     = " + FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                " Cotacaos   = " + FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                " Sopers     = " + EscaparSQL(THIS.this_cSopers) + "," + ;
                " Sgrupos    = " + EscaparSQL(THIS.this_cSGrupos) + "," + ;
                " Scontas    = " + EscaparSQL(THIS.this_cSContas) + "," + ;
                " Smoedas    = " + EscaparSQL(THIS.this_cSMoedas) + "," + ;
                " Svalors    = " + FormatarNumeroSQL(THIS.this_nSValors) + "," + ;
                " Scotacaos  = " + FormatarNumeroSQL(THIS.this_nSCotacaos) + "," + ;
                " Hists      = " + EscaparSQL(THIS.this_cHists) + "," + ;
                " Hist2s     = " + EscaparSQL(THIS.this_cHist2s) + "," + ;
                " Shists     = " + EscaparSQL(THIS.this_cShists) + "," + ;
                " Nfs        = " + EscaparSQL(THIS.this_cNotas) + "," + ;
                " Docus      = " + EscaparSQL(THIS.this_cDocus) + "," + ;
                " Jobs       = " + EscaparSQL(THIS.this_cJobs) + "," + ;
                " Usualts    = " + EscaparSQL(THIS.this_cUsualts) + "," + ;
                " Datalts    = " + FormatarDataSQL(THIS.this_dDatalts) + "," + ;
                " Contapgs   = " + FormatarNumeroSQL(THIS.this_nContaPgs) + "," + ;
                " Cotusus    = " + EscaparSQL(THIS.this_cCotUsus) + "," + ;
                " Gruconmoes = " + EscaparSQL(loc_cGruConMoes) + ;
                " WHERE Emps   = " + EscaparSQL(THIS.this_cEmps) + ;
                "   AND Nopers = " + FormatarNumeroSQL(THIS.this_nNopers)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * EXECUTAREXCLUSAO - Exclusao logica: marca Datexcs + Usuexcs (sem DELETE fisico)
    * Compativel com o legado (que usava UPDATE SigMvCcr SET DatExcs/UsuExcs)
    *===========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_dAgora
        loc_lSucesso = .F.

        TRY
            loc_dAgora = DATETIME()

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                " Datexcs = " + FormatarDataSQL(loc_dAgora) + "," + ;
                " Usuexcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE Emps   = " + EscaparSQL(THIS.this_cEmps) + ;
                "   AND Nopers = " + FormatarNumeroSQL(THIS.this_nNopers)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                THIS.this_dDatExcs = loc_dAgora
                THIS.this_cUsuExcs = gc_4c_UsuarioLogado
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

