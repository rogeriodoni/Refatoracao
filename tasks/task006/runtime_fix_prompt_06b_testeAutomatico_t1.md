# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[09/04/2026 09:38:44 PM] Erro: Erro ao inicializar Formsigmvccr:Linha: 415Property GRIDCOLOR is not found.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-04-09 21:38:43] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-09 21:38:43] [INFO] Config FPW: (nao fornecido)
[2026-04-09 21:38:43] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-09 21:38:43] [INFO] Timeout: 300 segundos
[2026-04-09 21:38:43] [INFO] Wrapper PRG criado para parametros: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_mrtc1pib.prg
[2026-04-09 21:38:43] [INFO] Conteudo do wrapper:
[2026-04-09 21:38:43] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigmvccr', 'C:\4c\tasks\task006', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigmvccr', 'C:\4c\tasks\task006', 'CRUD'
QUIT

[2026-04-09 21:38:43] [INFO] Comando VFP: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_mrtc1pib.prg
[2026-04-09 21:38:43] [INFO] VFP output esperado em: C:\4c\tasks\task006\vfp_output.txt
[2026-04-09 21:38:43] [INFO] Executando Visual FoxPro 9...
[2026-04-09 21:38:43] [INFO] Comando completo: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_mrtc1pib.prg
[2026-04-09 21:38:43] [INFO] Executando: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_mrtc1pib.prg
[2026-04-09 21:38:43] [INFO] Timeout configurado: 300 segundos
[2026-04-09 21:38:44] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-09 21:38:44] [INFO] VFP9 finalizado em 1.3311162 segundos
[2026-04-09 21:38:44] [INFO] Exit Code: 
[2026-04-09 21:38:44] [INFO] 
[2026-04-09 21:38:44] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-09 21:38:44] [INFO]   Wrapper.prg: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_mrtc1pib.prg
[2026-04-09 21:38:44] [INFO] 
[2026-04-09 21:38:44] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-09 21:38:44] [INFO] * Auto-generated wrapper for parameters
[2026-04-09 21:38:44] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-09 21:38:44] [INFO] * Parameters: 'Formsigmvccr', 'C:\4c\tasks\task006', 'CRUD'
[2026-04-09 21:38:44] [INFO] 
[2026-04-09 21:38:44] [INFO] * Anti-dialog protections for unattended execution
[2026-04-09 21:38:44] [INFO] SET SAFETY OFF
[2026-04-09 21:38:44] [INFO] SET RESOURCE OFF
[2026-04-09 21:38:44] [INFO] SET TALK OFF
[2026-04-09 21:38:45] [INFO] SET NOTIFY OFF
[2026-04-09 21:38:45] [INFO] SYS(2335, 0)
[2026-04-09 21:38:45] [INFO] 
[2026-04-09 21:38:45] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigmvccr', 'C:\4c\tasks\task006', 'CRUD'
[2026-04-09 21:38:45] [INFO] QUIT
[2026-04-09 21:38:45] [INFO] 
[2026-04-09 21:38:45] [INFO] === Fim do Wrapper.prg ===
[2026-04-09 21:38:45] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigmvccr",
  "timestamp": "20260409213844",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": false,
      "erro": "CREATEOBJECT retornou valor nao-objeto",
      "detalhes": ""
    }
  ],
  "resumo": {
    "total": 1,
    "passou": 0,
    "falhou": 1,
    "percentual": 0
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
* Tabela: SigMvCcr | PK: Emps + Nopers
* Legado: SIGMVCCR (frmcadastro)
* Fase 7/8: Form - Eventos Principais (CRUD completo)
*==============================================================================

DEFINE CLASS Formsigmvccr AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Conta Corrente Geral"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    ClipControls = .F.
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades do formulario
    this_oBusinessObject  = .NULL.
    this_cMensagemErro    = ""       && OBRIGATORIO - nao herdado de FormBase
    this_cModoAtual       = "LISTA"  && LISTA | INCLUIR | ALTERAR | VISUALIZAR

    *-- Propriedades de filtro de periodo
    this_dDtInicial       = {}
    this_dDtFinal         = {}

    *--------------------------------------------------------------------------
    * Init - Inicializacao do formulario
    * DODEFAULT() ja chama InicializarForm() pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MsgErro("Erro ao inicializar Formsigmvccr:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial do formulario
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar instancia do Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("sigmvccrBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object sigmvccrBO", "Erro Cr" + CHR(237) + "tico")
                loc_lSucesso = .F.
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Propagar titulo para o label do cabecalho
                IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo") = "O"
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                ENDIF

                *-- Inicializar datas de filtro com periodo padrao (mes corrente)
                THIS.this_dDtInicial = DATE() - DAY(DATE()) + 1
                THIS.this_dDtFinal   = DATE()
                IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial") = "O"
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial.Value = THIS.this_dDtInicial
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtFinal.Value   = THIS.this_dDtFinal
                ENDIF

                *-- Pula CarregarLista() se validando UI (sem conexao SQL)
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Falha ao carregar nao impede abertura
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao inicializar Formsigmvccr:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura o PageFrame principal
    * PageFrame.Top=-29 oculta abas; controles compensam +29 no Top
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

            *-- Page1 - Lista (grade de lancamentos)
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            *-- Page2 - Dados (edicao de lancamento)
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Compensacao PageFrame.Top=-29: controles de topo recebem Top += 29
    * Contem: Cabecalho, Botoes CRUD, Filtro de Periodo, Grid de Lancamentos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho escuro (Top_original=0 -> 29 com compensacao)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 29
            .Left          = 0
            .Width         = 1003
            .Height        = 85
            .BackStyle     = 1
            .BackColor     = RGB(53, 53, 53)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label titulo no cabecalho escuro
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 30
            .Left      = 10
            .Width     = 280
            .Height    = 20
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (sobreposto ao cabecalho, lado direito)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top           = 29
            .Left          = 390
            .Width         = 613
            .Height        = 85
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .SpecialEffect = 0
            .Visible       = .T.
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
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 83
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 161
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 239
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 317
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Botao Movimento (Anexa - abre detalhe de lancamentos relacionados)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Movimento", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Movimento
            .Caption         = "Movimento"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 395
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Movimento, "Click", THIS, "BtnMovimentoClick")

        *-- Botao Encerrar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 533
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container filtros de periodo (abaixo do cabecalho - Top = 29 + 85 = 114)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top           = 114
            .Left          = 5
            .Width         = 310
            .Height        = 36
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label "Periodo :"
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo : "
            .Top       = 10
            .Left      = 5
            .Width     = 60
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox data inicial
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtInicial
            .Top       = 6
            .Left      = 67
            .Width     = 80
            .Height    = 20
            .Value     = DATE()
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtInicial, "LostFocus", THIS, "DtInicialLostFocus")

        *-- Label "ate"
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_Ate", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_Ate
            .Caption   = "at" + CHR(233)
            .Top       = 10
            .Left      = 153
            .Width     = 25
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox data final
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtFinal
            .Top       = 6
            .Left      = 182
            .Width     = 80
            .Height    = 20
            .Value     = DATE()
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtFinal, "LostFocus", THIS, "DtFinalLostFocus")

        *-- Cursor placeholder para o Grid (SET NULL ON para aceitar NULLs do SQL Server)
        SET NULL ON
        CREATE CURSOR cursor_4c_Dados ( ;
            Emps    C(3),  Nopers N(9,0), Datas  T,      Opers   C(1), ;
            Contas  C(10), Scontas C(10), Hists  C(40),  Valors  N(14,2), ;
            Svalors N(14,2), Nfs C(15),   Docus  C(20), ;
            Grupos  C(10), Sgrupos C(10), Moedas C(3),   Smoedas C(3), ;
            Hist2s  C(40), Shists  C(40))
        SET NULL OFF

        *-- Grid de lista de lancamentos (Top = 114 + 36 = 150)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista

        *-- CRITICO: RecordSource e ColumnCount FORA do WITH para criar colunas imediatamente
        loc_oGrid.RecordSource = "cursor_4c_Dados"
        loc_oGrid.ColumnCount  = 9

        *-- OBRIGATORIO: ControlSources IMEDIATAMENTE APOS RecordSource/ColumnCount (antes do WITH)
        *-- Evita auto-bind por ordem de campos do cursor
        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Datas"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Opers"
        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Contas"
        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Scontas"
        loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Hists"
        loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Valors"
        loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.Svalors"
        loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.Nfs"
        loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.Docus"

        WITH loc_oGrid
            .Top           = 150
            .Left          = 0
            .Width         = 1003
            .Height        = 448
            .GridLines     = 3
            .GridLineWidth = 1
            .GridColor     = RGB(200, 200, 200)
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .Scrollbars    = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Larguras das colunas
        loc_oGrid.Column1.Width = 80
        loc_oGrid.Column2.Width = 20
        loc_oGrid.Column3.Width = 100
        loc_oGrid.Column4.Width = 100
        loc_oGrid.Column5.Width = 250
        loc_oGrid.Column6.Width = 90
        loc_oGrid.Column7.Width = 90
        loc_oGrid.Column8.Width = 65
        loc_oGrid.Column9.Width = 100

        *-- OBRIGATORIO: Headers APOS RecordSource
        loc_oGrid.Column1.Header1.Caption = "Data"
        loc_oGrid.Column2.Header1.Caption = "O"
        loc_oGrid.Column3.Header1.Caption = "Conta"
        loc_oGrid.Column4.Header1.Caption = "Contrapartida"
        loc_oGrid.Column5.Header1.Caption = "Hist" + CHR(243) + "rico"
        loc_oGrid.Column6.Header1.Caption = "D" + CHR(233) + "bito"
        loc_oGrid.Column7.Header1.Caption = "Cr" + CHR(233) + "dito"
        loc_oGrid.Column8.Header1.Caption = "NF"
        loc_oGrid.Column9.Header1.Caption = "Documento"

        *-- Alinhamento de valores numericos
        loc_oGrid.Column6.Alignment = 1
        loc_oGrid.Column7.Alignment = 1

        THIS.FormatarGridLista(loc_oGrid)
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Fase 5: Todos os campos, shapes, labels, lookups e validacoes
    * Posicoes do layout.json usadas diretamente (PageFrame.Top=-29 identico ao legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *======================================================================
        *-- CONTAINER DE BOTOES (Confirmar/Cancelar) - Top=29 => screen y=0
        *======================================================================
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top           = 29
            .Left          = 0
            .Width         = 1003
            .Height        = 85
            .BackStyle     = 1
            .BackColor     = RGB(53, 53, 53)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 850
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Cancelar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 928
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *======================================================================
        *-- SHAPES (bordas visuais de agrupamento)
        *-- Posicoes do layout.json; PageFrame.Top=-29 identico ao legado
        *======================================================================

        *-- Shape1: secao dados do lancamento (datas, NF, usuario)
        loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPagina.shp_4c_Shape1
            .Top           = 153
            .Left          = 9
            .Width         = 980
            .Height        = 64
            .BackStyle     = 0
            .BorderStyle   = 1
            .BorderWidth   = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Shape3: secao movimento debito (lado esquerdo)
        loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPagina.shp_4c_Shape3
            .Top           = 224
            .Left          = 9
            .Width         = 485
            .Height        = 117
            .BackStyle     = 0
            .BorderStyle   = 1
            .BorderWidth   = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Shape2: secao movimento credito (lado direito)
        loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPagina.shp_4c_Shape2
            .Top           = 224
            .Left          = 504
            .Width         = 485
            .Height        = 117
            .BackStyle     = 0
            .BorderStyle   = 1
            .BorderWidth   = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Shape6: secao historico + opcao_conta
        loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
        WITH loc_oPagina.shp_4c_Shape6
            .Top           = 350
            .Left          = 9
            .Width         = 980
            .Height        = 39
            .BackStyle     = 0
            .BorderStyle   = 1
            .BorderWidth   = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *======================================================================
        *-- LABELS (Say objects)
        *-- Secao lancamento (Shape1: top=153..217)
        *======================================================================
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say1", ;
            "Lan" + CHR(231) + "amento :", 165, 43, 80, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say10", ;
            "Vencimento :", 165, 234, 80, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say15", ;
            "Emiss" + CHR(227) + "o :", 165, 435, 70, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say7", ;
            "Nota Fiscal :", 165, 615, 80, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say6", ;
            "Usu" + CHR(225) + "rio :", 165, 818, 60, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say17", ;
            "Job :", 191, 84, 30, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say2", ;
            "Documento :", 191, 613, 75, 15)

        *-- Secao debito (Shape3: top=224..341)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say3", ;
            "Movimento :", 235, 49, 75, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say18", ;
            "[D/C]", 235, 130, 35, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say4", ;
            "Grupo :", 261, 72, 45, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say5", ;
            "Conta :", 287, 72, 45, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say8", ;
            "Valor :", 313, 77, 40, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_SayCotacao", ;
            "C" + CHR(226) + "mbio :", 313, 303, 50, 15)

        *-- Secao credito (Shape2: top=224..341)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say11", ;
            "Movimento :", 235, 544, 75, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say14", ;
            "[D/C]", 235, 626, 35, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say12", ;
            "Grupo :", 261, 567, 45, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say13", ;
            "Conta :", 287, 567, 45, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say16", ;
            "Valor :", 313, 572, 40, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_SaysCotacao", ;
            "C" + CHR(226) + "mbio :", 313, 797, 50, 15)

        *-- Secao historico (Shape6: top=350..389)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say9", ;
            "Hist" + CHR(243) + "rico :", 362, 60, 55, 15)
        THIS.AdicionarLabel(loc_oPagina, "lbl_4c_Say19", ;
            "Lan" + CHR(231) + "ar Contas :", 362, 758, 85, 15)

        *======================================================================
        *-- SECAO LANCAMENTO: datas, NF, usuario, job, documento
        *======================================================================

        *-- Data do lancamento (fweditdata_DATA)
        loc_oPagina.AddObject("txt_4c_Fweditdata_DATA", "TextBox")
        WITH loc_oPagina.txt_4c_Fweditdata_DATA
            .Top       = 161
            .Left      = 112
            .Width     = 80
            .Height    = 21
            .Value     = DATE()
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Vencimento (fweditdata_VENC)
        loc_oPagina.AddObject("txt_4c_Fweditdata_VENC", "TextBox")
        WITH loc_oPagina.txt_4c_Fweditdata_VENC
            .Top       = 161
            .Left      = 300
            .Width     = 80
            .Height    = 21
            .Value     = DATE()
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Emissao (getDtEmis)
        loc_oPagina.AddObject("txt_4c_DtEmis", "TextBox")
        WITH loc_oPagina.txt_4c_DtEmis
            .Top       = 161
            .Left      = 484
            .Width     = 80
            .Height    = 21
            .Value     = DATE()
            .Format    = "D"
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Nota Fiscal (Get_Nota)
        loc_oPagina.AddObject("txt_4c_Nota", "TextBox")
        WITH loc_oPagina.txt_4c_Nota
            .Top      = 161
            .Left     = 678
            .Width    = 80
            .Height   = 21
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Usuario (get_Usuario) - somente leitura
        loc_oPagina.AddObject("txt_4c__Usuario", "TextBox")
        WITH loc_oPagina.txt_4c__Usuario
            .Top      = 161
            .Left     = 865
            .Width    = 80
            .Height   = 21
            .Value    = gc_4c_UsuarioLogado
            .ReadOnly = .T.
            .BackColor = RGB(240, 240, 240)
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Job (getJob)
        loc_oPagina.AddObject("txt_4c_Job", "TextBox")
        WITH loc_oPagina.txt_4c_Job
            .Top      = 187
            .Left     = 112
            .Width    = 80
            .Height   = 21
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Job, "KeyPress", THIS, "OprKeyPressJob")

        *-- Descricao do Job (getDJob) - somente leitura
        loc_oPagina.AddObject("txt_4c_DJob", "TextBox")
        WITH loc_oPagina.txt_4c_DJob
            .Top      = 187
            .Left     = 195
            .Width    = 290
            .Height   = 21
            .Value    = ""
            .ReadOnly = .T.
            .BackColor = RGB(240, 240, 240)
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Documento (Get_DOCU)
        loc_oPagina.AddObject("txt_4c_DOCU", "TextBox")
        WITH loc_oPagina.txt_4c_DOCU
            .Top      = 187
            .Left     = 678
            .Width    = 80
            .Height   = 21
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *======================================================================
        *-- SECAO DEBITO (lado esquerdo - Shape3)
        *======================================================================

        *-- Operacao D/C debito (Get_OPER) - 1 char
        loc_oPagina.AddObject("txt_4c_OPER", "TextBox")
        WITH loc_oPagina.txt_4c_OPER
            .Top       = 231
            .Left      = 112
            .Width     = 25
            .Height    = 21
            .Value     = "D"
            .InputMask = "!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_OPER, "KeyPress", THIS, "OprKeyPressOper")

        *-- Grupo debito - codigo (Get_grupo)
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Top      = 257
            .Left     = 112
            .Width    = 80
            .Height   = 21
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "OprKeyPressGrupo")

        *-- Grupo debito - descricao (Get_dgrupo) - somente leitura
        loc_oPagina.AddObject("txt_4c_Dgrupo", "TextBox")
        WITH loc_oPagina.txt_4c_Dgrupo
            .Top      = 257
            .Left     = 195
            .Width    = 290
            .Height   = 21
            .Value    = ""
            .ReadOnly = .T.
            .BackColor = RGB(240, 240, 240)
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Conta debito - codigo (Get_conta)
        loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.txt_4c_Conta
            .Top      = 283
            .Left     = 112
            .Width    = 80
            .Height   = 21
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "OprKeyPressConta")

        *-- Conta debito - descricao (Get_dconta) - somente leitura
        loc_oPagina.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oPagina.txt_4c_Dconta
            .Top      = 283
            .Left     = 195
            .Width    = 290
            .Height   = 21
            .Value    = ""
            .ReadOnly = .T.
            .BackColor = RGB(240, 240, 240)
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Valor debito (Get_VALOR)
        loc_oPagina.AddObject("txt_4c_VALOR", "TextBox")
        WITH loc_oPagina.txt_4c_VALOR
            .Top       = 309
            .Left      = 112
            .Width     = 128
            .Height    = 21
            .Value     = 0
            .Format    = "N"
            .InputMask = "999999999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_VALOR, "KeyPress", THIS, "OprKeyPressValor")

        *-- Moeda debito (Get_MOEDA)
        loc_oPagina.AddObject("txt_4c_MOEDA", "TextBox")
        WITH loc_oPagina.txt_4c_MOEDA
            .Top      = 309
            .Left     = 243
            .Width    = 31
            .Height   = 21
            .Value    = "R"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_MOEDA, "KeyPress", THIS, "OprKeyPressMoeda")

        *-- Cotacao debito (Get_COTACAO)
        loc_oPagina.AddObject("txt_4c_COTACAO", "TextBox")
        WITH loc_oPagina.txt_4c_COTACAO
            .Top       = 309
            .Left      = 349
            .Width     = 108
            .Height    = 21
            .Value     = 1
            .Format    = "N"
            .InputMask = "9999999.9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_COTACAO, "KeyPress", THIS, "OprKeyPressCotacao")

        *-- Botao alterar cotacao debito ($)
        loc_oPagina.AddObject("cmd_4c_Alteracotacao", "CommandButton")
        WITH loc_oPagina.cmd_4c_Alteracotacao
            .Caption       = "$"
            .Top           = 309
            .Left          = 461
            .Width         = 24
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Alteracotacao, "Click", THIS, "BtnAlteracotacaoClick")

        *======================================================================
        *-- SECAO CREDITO (lado direito - Shape2) - contrapartida
        *======================================================================

        *-- Operacao D/C credito (Get_SOPER) - somente leitura (auto-calculado)
        loc_oPagina.AddObject("txt_4c_SOPER", "TextBox")
        WITH loc_oPagina.txt_4c_SOPER
            .Top      = 231
            .Left     = 607
            .Width    = 25
            .Height   = 21
            .Value    = "C"
            .ReadOnly = .T.
            .BackColor = RGB(240, 240, 240)
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Grupo credito - codigo (Get_SGRUPO)
        loc_oPagina.AddObject("txt_4c_SGRUPO", "TextBox")
        WITH loc_oPagina.txt_4c_SGRUPO
            .Top      = 257
            .Left     = 607
            .Width    = 80
            .Height   = 21
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SGRUPO, "KeyPress", THIS, "OprKeyPressSGrupo")

        *-- Grupo credito - descricao (Get_sdgrupo) - somente leitura
        loc_oPagina.AddObject("txt_4c_Sdgrupo", "TextBox")
        WITH loc_oPagina.txt_4c_Sdgrupo
            .Top      = 257
            .Left     = 689
            .Width    = 290
            .Height   = 21
            .Value    = ""
            .ReadOnly = .T.
            .BackColor = RGB(240, 240, 240)
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Conta credito - codigo (Get_SCONTA)
        loc_oPagina.AddObject("txt_4c_SCONTA", "TextBox")
        WITH loc_oPagina.txt_4c_SCONTA
            .Top      = 283
            .Left     = 607
            .Width    = 80
            .Height   = 21
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SCONTA, "KeyPress", THIS, "OprKeyPressSConta")

        *-- Conta credito - descricao (Get_SDCONTA) - somente leitura
        loc_oPagina.AddObject("txt_4c_Sdconta", "TextBox")
        WITH loc_oPagina.txt_4c_Sdconta
            .Top      = 283
            .Left     = 689
            .Width    = 290
            .Height   = 21
            .Value    = ""
            .ReadOnly = .T.
            .BackColor = RGB(240, 240, 240)
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Valor credito (Get_SVALOR)
        loc_oPagina.AddObject("txt_4c_SVALOR", "TextBox")
        WITH loc_oPagina.txt_4c_SVALOR
            .Top       = 309
            .Left      = 607
            .Width     = 128
            .Height    = 21
            .Value     = 0
            .Format    = "N"
            .InputMask = "999999999.99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SVALOR, "KeyPress", THIS, "OprKeyPressSValor")

        *-- Moeda credito (Get_smoeda)
        loc_oPagina.AddObject("txt_4c_Smoeda", "TextBox")
        WITH loc_oPagina.txt_4c_Smoeda
            .Top      = 309
            .Left     = 737
            .Width    = 31
            .Height   = 21
            .Value    = "R"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Smoeda, "KeyPress", THIS, "OprKeyPressSMoeda")

        *-- Cotacao credito (Get_SCOTACAO)
        loc_oPagina.AddObject("txt_4c_SCOTACAO", "TextBox")
        WITH loc_oPagina.txt_4c_SCOTACAO
            .Top       = 309
            .Left      = 843
            .Width     = 108
            .Height    = 21
            .Value     = 1
            .Format    = "N"
            .InputMask = "9999999.9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_SCOTACAO, "KeyPress", THIS, "OprKeyPressSCotacao")

        *-- Botao alterar cotacao credito ($)
        loc_oPagina.AddObject("cmd_4c_Alterascotacao", "CommandButton")
        WITH loc_oPagina.cmd_4c_Alterascotacao
            .Caption       = "$"
            .Top           = 309
            .Left          = 955
            .Width         = 24
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Alterascotacao, "Click", THIS, "BtnAlterascotacaoClick")

        *======================================================================
        *-- SECAO HISTORICO (Shape6)
        *======================================================================

        *-- Historico principal (Get_HIST)
        loc_oPagina.AddObject("txt_4c_HIST", "TextBox")
        WITH loc_oPagina.txt_4c_HIST
            .Top      = 358
            .Left     = 112
            .Width    = 300
            .Height   = 21
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Historico complementar (Get_Hist2)
        loc_oPagina.AddObject("txt_4c_Hist2", "TextBox")
        WITH loc_oPagina.txt_4c_Hist2
            .Top      = 358
            .Left     = 415
            .Width    = 300
            .Height   = 21
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *======================================================================
        *-- OPCAO CONTA (OptionGroup: Lancamento conta Sim/Nao)
        *======================================================================
        loc_oPagina.AddObject("obj_4c_Opcao_conta", "OptionGroup")
        loc_oPagina.obj_4c_Opcao_conta.ButtonCount = 2

        WITH loc_oPagina.obj_4c_Opcao_conta
            .Top       = 356
            .Left      = 844
            .Width     = 99
            .Height    = 27
            .Value     = 1
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        WITH loc_oPagina.obj_4c_Opcao_conta.Buttons(1)
            .Caption   = "Sim"
            .Top       = 3
            .Left      = 2
            .Width     = 47
            .Height    = 21
            .AutoSize  = .F.
            .Themes    = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        WITH loc_oPagina.obj_4c_Opcao_conta.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Top       = 3
            .Left      = 51
            .Width     = 47
            .Height    = 21
            .AutoSize  = .F.
            .Themes    = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarLabel - Helper para criar labels na pagina
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AdicionarLabel(par_oPagina, par_cNome, par_cCaption, ;
        par_nTop, par_nLeft, par_nWidth, par_nHeight)

        par_oPagina.AddObject(par_cNome, "Label")
        WITH par_oPagina.Controls(par_oPagina.ControlCount)
            .Caption   = par_cCaption
            .Top       = par_nTop
            .Left      = par_nLeft
            .Width     = par_nWidth
            .Height    = par_nHeight
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados na grade da Page1
    * Usa cursor temporario + ZAP + APPEND para preservar colunas do Grid
    * (Problema #34: SQLEXEC direto destroi cursor e colunas do Grid)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_cFiltro, loc_cDtI, loc_cDtF, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                *-- Ler datas do filtro da Page1
                IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial") = "O"
                    THIS.this_dDtInicial = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial.Value
                    THIS.this_dDtFinal   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtFinal.Value
                ENDIF

                *-- Montar filtro de periodo
                loc_cFiltro = ""
                IF !EMPTY(THIS.this_dDtInicial) AND !EMPTY(THIS.this_dDtFinal)
                    loc_cDtI = "'" + DTOS(THIS.this_dDtInicial) + "'"
                    loc_cDtF = "'" + DTOS(THIS.this_dDtFinal) + " 23:59:59'"
                    loc_cFiltro = " AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF
                ENDIF

                *-- Montar SELECT (colunas identicas ao CREATE CURSOR placeholder)
                loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Opers," + ;
                    " a.Contas, a.Scontas, a.Hists, a.Valors, a.Svalors," + ;
                    " a.Nfs, a.Docus, a.Grupos, a.Sgrupos, a.Moedas," + ;
                    " a.Smoedas, a.Hist2s, a.Shists" + ;
                    " FROM SigMvCcr a" + ;
                    " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                    loc_cFiltro + ;
                    " ORDER BY a.Datas DESC, a.Nopers DESC"

                *-- SQLEXEC em cursor TEMPORARIO para preservar colunas do Grid
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_Dados
                    ZAP
                    IF RECCOUNT("cursor_4c_DadosTemp") > 0
                        APPEND FROM DBF("cursor_4c_DadosTemp")
                    ENDIF
                    IF USED("cursor_4c_DadosTemp")
                        USE IN cursor_4c_DadosTemp
                    ENDIF
                    GO TOP IN cursor_4c_Dados

                    *-- Obter referencia ao grid e reconfigurar Headers
                    IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Lista") = "O"
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        *-- Reconfigurar ControlSources (OBRIGATORIO apos carregar)
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Datas"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Opers"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Contas"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Scontas"
                        loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Hists"
                        loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Valors"
                        loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.Svalors"
                        loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.Nfs"
                        loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.Docus"

                        *-- Reconfigurar Headers (OBRIGATORIO apos RecordSource/ControlSource)
                        loc_oGrid.Column1.Header1.Caption = "Data"
                        loc_oGrid.Column2.Header1.Caption = "O"
                        loc_oGrid.Column3.Header1.Caption = "Conta"
                        loc_oGrid.Column4.Header1.Caption = "Contrapartida"
                        loc_oGrid.Column5.Header1.Caption = "Hist" + CHR(243) + "rico"
                        loc_oGrid.Column6.Header1.Caption = "D" + CHR(233) + "bito"
                        loc_oGrid.Column7.Header1.Caption = "Cr" + CHR(233) + "dito"
                        loc_oGrid.Column8.Header1.Caption = "NF"
                        loc_oGrid.Column9.Header1.Caption = "Documento"

                        loc_oGrid.Refresh()
                    ENDIF

                    loc_lResultado = .T.
                ELSE
                    IF USED("cursor_4c_DadosTemp")
                        USE IN cursor_4c_DadosTemp
                    ENDIF
                    MsgErro("Erro ao buscar lan" + CHR(231) + "amentos:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF
            MsgErro("Erro em CarregarLista: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
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
            MsgErro("Erro em AlternarPagina: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * DtInicialLostFocus - Reage a saida do campo data inicial
    * Garante que DtFinal >= DtInicial e recarrega a lista
    *--------------------------------------------------------------------------
    PROCEDURE DtInicialLostFocus()
        LOCAL loc_dDtInicial, loc_dDtFinal, loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros

        IF TYPE("loc_oCnt.txt_4c_DtInicial") != "O"
            RETURN
        ENDIF

        loc_dDtInicial = loc_oCnt.txt_4c_DtInicial.Value
        loc_dDtFinal   = loc_oCnt.txt_4c_DtFinal.Value

        IF VARTYPE(loc_dDtInicial) = "D" AND VARTYPE(loc_dDtFinal) = "D"
            IF loc_dDtInicial > loc_dDtFinal
                loc_oCnt.txt_4c_DtFinal.Value = loc_dDtInicial
            ENDIF
        ENDIF

        THIS.this_dDtInicial = loc_oCnt.txt_4c_DtInicial.Value
        THIS.this_dDtFinal   = loc_oCnt.txt_4c_DtFinal.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * DtFinalLostFocus - Reage a saida do campo data final
    * Garante que DtInicial <= DtFinal e recarrega a lista
    *--------------------------------------------------------------------------
    PROCEDURE DtFinalLostFocus()
        LOCAL loc_dDtInicial, loc_dDtFinal, loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros

        IF TYPE("loc_oCnt.txt_4c_DtFinal") != "O"
            RETURN
        ENDIF

        loc_dDtInicial = loc_oCnt.txt_4c_DtInicial.Value
        loc_dDtFinal   = loc_oCnt.txt_4c_DtFinal.Value

        IF VARTYPE(loc_dDtInicial) = "D" AND VARTYPE(loc_dDtFinal) = "D"
            IF loc_dDtFinal < loc_dDtInicial
                loc_oCnt.txt_4c_DtInicial.Value = loc_dDtFinal
            ENDIF
        ENDIF

        THIS.this_dDtInicial = loc_oCnt.txt_4c_DtInicial.Value
        THIS.this_dDtFinal   = loc_oCnt.txt_4c_DtFinal.Value
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Novo lancamento
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar lancamento selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nNopers

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_nNopers = cursor_4c_Dados.Nopers

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNopers)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ELSE
            MsgAviso("Erro ao carregar o registro selecionado.", "Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar lancamento selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nNopers

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_nNopers = cursor_4c_Dados.Nopers

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNopers)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ELSE
            MsgAviso("Erro ao carregar o registro selecionado.", "Alterar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir lancamento selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nNopers, loc_lConfirma

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_nNopers = cursor_4c_Dados.Nopers

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste lan" + CHR(231) + "amento?", ;
            "Excluir Lan" + CHR(231) + "amento")
        IF loc_lConfirma
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNopers)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgSucesso("Lan" + CHR(231) + "amento exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ELSE
                MsgAviso("Erro ao carregar o registro para exclus" + CHR(227) + "o.", "Excluir")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega a lista aplicando o filtro de periodo
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMovimentoClick - Abre detalhes do lancamento selecionado (Anexa)
    * No legado: abre SigCdPgr ou SigCdLch com base no tipo do documento
    *--------------------------------------------------------------------------
    PROCEDURE BtnMovimentoClick()
        LOCAL loc_nNopers, loc_cDope

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado para visualizar o movimento.", "Movimento")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_nNopers = cursor_4c_Dados.Nopers

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNopers)
            loc_cDope = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)

            IF EMPTY(loc_cDope)
                *-- Sem documento de origem: exibir apenas o lancamento atual
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AlternarPagina(2)
            ELSE
                *-- Lancamento tem documento de origem (programacao/pagamento)
                *-- Abrir visualizacao do lancamento na Page2
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AlternarPagina(2)
            ENDIF
        ELSE
            MsgAviso("Erro ao carregar o registro selecionado.", "Movimento")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva o lancamento (Inserir ou Atualizar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lValido, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes obrigatorias ANTES do TRY
        IF TYPE("loc_oPg2.txt_4c_Fweditdata_DATA") = "O"
            IF EMPTY(loc_oPg2.txt_4c_Fweditdata_DATA.Value)
                MsgAviso("Data do lan" + CHR(231) + "amento " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Salvar")
                RETURN
            ENDIF
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Grupo") = "O"
            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value))
                MsgAviso("Grupo (d" + CHR(233) + "bito) " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Salvar")
                RETURN
            ENDIF
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Conta") = "O"
            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Conta.Value))
                MsgAviso("Conta (d" + CHR(233) + "bito) " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Salvar")
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgSucesso("Lan" + CHR(231) + "amento salvo com sucesso!")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * OprKeyPressOper - KeyPress em Get_OPER: valida D/C e atualiza SOPER
    *--------------------------------------------------------------------------
    PROCEDURE OprKeyPressOper(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_oPg2
        *-- Aguarda Enter (13) ou Tab (9) para validar
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF TYPE("loc_oPg2.txt_4c_OPER") = "O"
                loc_cValor = UPPER(ALLTRIM(loc_oPg2.txt_4c_OPER.Value))
                IF !INLIST(loc_cValor, "D", "C")
                    MsgAviso("Digite (D)" + CHR(233) + "bito ou (C)r" + CHR(233) + ;
                        "dito !!!", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oPg2.txt_4c_OPER.Value = "D"
                    NODEFAULT
                ELSE
                    loc_oPg2.txt_4c_OPER.Value = loc_cValor
                    *-- SOPER e automaticamente o inverso de OPER
                    IF TYPE("loc_oPg2.txt_4c_SOPER") = "O"
                        loc_oPg2.txt_4c_SOPER.Value = IIF(loc_cValor = "D", "C", "D")
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OprKeyPressValor - KeyPress em Get_VALOR: calcula SVALOR apos saida
    *--------------------------------------------------------------------------
    PROCEDURE OprKeyPressValor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nValor, loc_nCot, loc_nSCot, loc_oPg2
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF TYPE("loc_oPg2.txt_4c_VALOR") = "O"
                loc_nValor = loc_oPg2.txt_4c_VALOR.Value
                IF loc_nValor < 0
                    MsgAviso("Valor inv" + CHR(225) + "lido...", "Valor")
                    loc_oPg2.txt_4c_VALOR.Value = 0
                    NODEFAULT
                ELSE
                    *-- Auto-calcula SVALOR: VALOR * COTACAO / SCOTACAO
                    IF TYPE("loc_oPg2.txt_4c_COTACAO") = "O" AND ;
                        TYPE("loc_oPg2.txt_4c_SCOTACAO") = "O" AND ;
                        TYPE("loc_oPg2.txt_4c_SVALOR") = "O"

                        loc_nCot  = loc_oPg2.txt_4c_COTACAO.Value
                        loc_nSCot = loc_oPg2.txt_4c_SCOTACAO.Value
                        IF loc_nSCot != 0
                            loc_oPg2.txt_4c_SVALOR.Value = loc_nValor * loc_nCot / loc_nSCot
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OprKeyPressCotacao - KeyPress em Get_COTACAO: recalcula SVALOR
    *--------------------------------------------------------------------------
    PROCEDURE OprKeyPressCotacao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_nValor, loc_nCot, loc_nSCot
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF TYPE("loc_oPg2.txt_4c_VALOR") = "O" AND ;
                TYPE("loc_oPg2.txt_4c_COTACAO") = "O" AND ;
                TYPE("loc_oPg2.txt_4c_SCOTACAO") = "O" AND ;
                TYPE("loc_oPg2.txt_4c_SVALOR") = "O"

                loc_nValor = loc_oPg2.txt_4c_VALOR.Value
                loc_nCot   = loc_oPg2.txt_4c_COTACAO.Value
                loc_nSCot  = loc_oPg2.txt_4c_SCOTACAO.Value
                IF loc_nSCot != 0
                    loc_oPg2.txt_4c_SVALOR.Value = loc_nValor * loc_nCot / loc_nSCot
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OprKeyPressSValor - KeyPress em Get_SVALOR: recalcula SCOTACAO
    *--------------------------------------------------------------------------
    PROCEDURE OprKeyPressSValor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_nValor, loc_nCot, loc_nSValor
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF TYPE("loc_oPg2.txt_4c_VALOR") = "O" AND ;
                TYPE("loc_oPg2.txt_4c_COTACAO") = "O" AND ;
                TYPE("loc_oPg2.txt_4c_SCOTACAO") = "O" AND ;
                TYPE("loc_oPg2.txt_4c_SVALOR") = "O"

                loc_nValor  = loc_oPg2.txt_4c_VALOR.Value
                loc_nCot    = loc_oPg2.txt_4c_COTACAO.Value
                loc_nSValor = loc_oPg2.txt_4c_SVALOR.Value
                IF loc_nSValor != 0
                    loc_oPg2.txt_4c_SCOTACAO.Value = (loc_nValor * loc_nCot) / loc_nSValor
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OprKeyPressSCotacao - KeyPress em Get_SCOTACAO: recalcula SVALOR
    *--------------------------------------------------------------------------
    PROCEDURE OprKeyPressSCotacao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_nValor, loc_nCot, loc_nSCot
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            IF TYPE("loc_oPg2.txt_4c_VALOR") = "O" AND ;
                TYPE("loc_oPg2.txt_4c_COTACAO") = "O" AND ;
                TYPE("loc_oPg2.txt_4c_SCOTACAO") = "O" AND ;
                TYPE("loc_oPg2.txt_4c_SVALOR") = "O"

                loc_nValor = loc_oPg2.txt_4c_VALOR.Value
                loc_nCot   = loc_oPg2.txt_4c_COTACAO.Value
                loc_nSCot  = loc_oPg2.txt_4c_SCOTACAO.Value
                IF loc_nSCot != 0
                    loc_oPg2.txt_4c_SVALOR.Value = loc_nValor * loc_nCot / loc_nSCot
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OprKeyPressGrupo - KeyPress em Get_grupo: F4=lookup, Enter/Tab=valida
    *--------------------------------------------------------------------------
    PROCEDURE OprKeyPressGrupo(par_nKeyCode, par_nShiftAltCtrl)
        *-- F4 = 115
        IF par_nKeyCode = 115
            NODEFAULT
            THIS.AbrirLookupGrupo(.F.)
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupo(.F.)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OprKeyPressConta - KeyPress em Get_conta: F4=lookup, Enter/Tab=valida
    *--------------------------------------------------------------------------
    PROCEDURE OprKeyPressConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            NODEFAULT
            THIS.AbrirLookupConta(.F.)
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarConta(.F.)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OprKeyPressSGrupo - KeyPress em Get_SGRUPO: F4=lookup, Enter/Tab=valida
    *--------------------------------------------------------------------------
    PROCEDURE OprKeyPressSGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            NODEFAULT
            THIS.AbrirLookupGrupo(.T.)
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupo(.T.)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OprKeyPressSConta - KeyPress em Get_SCONTA: F4=lookup, Enter/Tab=valida
    *--------------------------------------------------------------------------
    PROCEDURE OprKeyPressSConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            NODEFAULT
            THIS.AbrirLookupConta(.T.)
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarConta(.T.)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OprKeyPressJob - KeyPress em getJob: Enter/Tab busca descricao
    *--------------------------------------------------------------------------
    PROCEDURE OprKeyPressJob(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.BuscarDescricaoJob()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - Lookup de grupos de conta corrente (SigCdGcr)
    * par_lSide: .F.=debito, .T.=credito
    * Usa FormBuscaAuxiliar MODO 1 (com gnConnHandle + tabela no Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupGrupo(par_lSide)
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_oPg2, loc_cFiltroEmps
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cFiltroEmps = "Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

        *-- MODO 1: Init faz SELECT * FROM SigCdGcr com filtro de empresa
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", "", ;
            "Busca de Grupos - Conta Corrente", .F., .F., loc_cFiltroEmps)

        IF VARTYPE(loc_oBusca) = "O"
            *-- mAddColuna(campo, mascara, titulo) - 3 params, todos strings
            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)

                IF !par_lSide
                    IF TYPE("loc_oPg2.txt_4c_Grupo") = "O"
                        loc_oPg2.txt_4c_Grupo.Value = loc_cCodigo
                    ENDIF
                    IF TYPE("loc_oPg2.txt_4c_Dgrupo") = "O"
                        loc_oPg2.txt_4c_Dgrupo.Value = loc_cDescricao
                    ENDIF
                ELSE
                    IF TYPE("loc_oPg2.txt_4c_SGRUPO") = "O"
                        loc_oPg2.txt_4c_SGRUPO.Value = loc_cCodigo
                    ENDIF
                    IF TYPE("loc_oPg2.txt_4c_Sdgrupo") = "O"
                        loc_oPg2.txt_4c_Sdgrupo.Value = loc_cDescricao
                    ENDIF
                ENDIF
            ENDIF

            loc_oBusca.Release()
            loc_oBusca = .NULL.
        ENDIF

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Valida grupo digitado e busca descricao (SigCdGcr)
    * par_lSide: .F.=debito, .T.=credito
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarGrupo(par_lSide)
        LOCAL loc_cCodigo, loc_nResultado, loc_oPg2
        LOCAL loc_oCod, loc_oDesc
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !par_lSide
            IF TYPE("loc_oPg2.txt_4c_Grupo") != "O"
                RETURN
            ENDIF
            loc_oCod  = loc_oPg2.txt_4c_Grupo
            loc_oDesc = loc_oPg2.txt_4c_Dgrupo
        ELSE
            IF TYPE("loc_oPg2.txt_4c_SGRUPO") != "O"
                RETURN
            ENDIF
            loc_oCod  = loc_oPg2.txt_4c_SGRUPO
            loc_oDesc = loc_oPg2.txt_4c_Sdgrupo
        ENDIF

        loc_cCodigo = ALLTRIM(loc_oCod.Value)

        IF EMPTY(loc_cCodigo)
            IF VARTYPE(loc_oDesc) = "O"
                loc_oDesc.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs FROM SigCdGcr" + ;
                " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND Codigos = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_BuscaGrupo")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
                IF VARTYPE(loc_oDesc) = "O"
                    loc_oDesc.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
                ENDIF
            ELSE
                MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCodigo, ;
                    "Grupo")
                loc_oCod.Value = ""
                IF VARTYPE(loc_oDesc) = "O"
                    loc_oDesc.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
            MsgErro("Erro ao validar grupo: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConta - Lookup de contas correntes filtradas por grupo
    * par_lSide: .F.=debito, .T.=credito
    * Tabela: SigMvSlc (contas vinculadas ao grupo selecionado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupConta(par_lSide)
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_cGrupo, loc_oPg2
        LOCAL loc_cTxtGrupo, loc_cTxtCod, loc_cTxtDesc, loc_cSQL, loc_nResultado
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !par_lSide
            loc_cTxtGrupo = "txt_4c_Grupo"
            loc_cTxtCod   = "txt_4c_Conta"
            loc_cTxtDesc  = "txt_4c_Dconta"
        ELSE
            loc_cTxtGrupo = "txt_4c_SGRUPO"
            loc_cTxtCod   = "txt_4c_SCONTA"
            loc_cTxtDesc  = "txt_4c_Sdconta"
        ENDIF

        IF TYPE("loc_oPg2." + loc_cTxtGrupo) = "O"
            loc_cGrupo = ALLTRIM(loc_oPg2.Controls(loc_cTxtGrupo).Value)
        ELSE
            loc_cGrupo = ""
        ENDIF

        *-- MODO 2: Pre-popular cursor via SQLEXEC (query com JOIN)
        loc_cSQL = "SELECT DISTINCT s.Contas, c.Descrs" + ;
            " FROM SigMvSlc s" + ;
            " LEFT JOIN SigCdCcr c ON c.Contas = s.Contas" + ;
            "  AND c.Emps = s.Emps" + ;
            " WHERE s.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
        IF !EMPTY(loc_cGrupo)
            loc_cSQL = loc_cSQL + ;
                " AND s.Grupos = " + EscaparSQL(loc_cGrupo)
        ENDIF
        loc_cSQL = loc_cSQL + " ORDER BY s.Contas"

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

        IF loc_nResultado < 0 OR !USED("cursor_4c_BuscaConta") OR RECCOUNT("cursor_4c_BuscaConta") = 0
            MsgAviso("Nenhuma conta encontrada para o grupo selecionado.", "Busca de Contas")
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
            RETURN
        ENDIF

        *-- Cria FormBuscaAuxiliar sem params (MODO 2: cursor ja populado)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"

            *-- mAddColuna(campo, mascara, titulo) - 3 strings
            loc_oBusca.mAddColuna("Contas", "", "Conta")
            loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")

            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                loc_cCodigo    = ALLTRIM(cursor_4c_BuscaConta.Contas)
                loc_cDescricao = ALLTRIM(cursor_4c_BuscaConta.Descrs)

                IF TYPE("loc_oPg2." + loc_cTxtCod) = "O"
                    loc_oPg2.Controls(loc_cTxtCod).Value  = loc_cCodigo
                    loc_oPg2.Controls(loc_cTxtDesc).Value = loc_cDescricao
                ENDIF
            ENDIF

            loc_oBusca.Release()
            loc_oBusca = .NULL.
        ENDIF

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConta - Valida conta digitada e busca descricao
    * par_lSide: .F.=debito, .T.=credito
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarConta(par_lSide)
        LOCAL loc_cCodigo, loc_nResultado, loc_oPg2
        LOCAL loc_oCod, loc_oDesc
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !par_lSide
            IF TYPE("loc_oPg2.txt_4c_Conta") != "O"
                RETURN
            ENDIF
            loc_oCod  = loc_oPg2.txt_4c_Conta
            loc_oDesc = loc_oPg2.txt_4c_Dconta
        ELSE
            IF TYPE("loc_oPg2.txt_4c_SCONTA") != "O"
                RETURN
            ENDIF
            loc_oCod  = loc_oPg2.txt_4c_SCONTA
            loc_oDesc = loc_oPg2.txt_4c_Sdconta
        ENDIF

        loc_cCodigo = ALLTRIM(loc_oCod.Value)

        IF EMPTY(loc_cCodigo)
            IF VARTYPE(loc_oDesc) = "O"
                loc_oDesc.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Contas, Descrs FROM SigCdCcr" + ;
                " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND Contas = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_BuscaConta")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
                IF VARTYPE(loc_oDesc) = "O"
                    loc_oDesc.Value = ALLTRIM(cursor_4c_BuscaConta.Descrs)
                ENDIF
            ELSE
                MsgAviso("Conta n" + CHR(227) + "o encontrada: " + loc_cCodigo, ;
                    "Conta")
                loc_oCod.Value = ""
                IF VARTYPE(loc_oDesc) = "O"
                    loc_oDesc.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
            MsgErro("Erro ao validar conta: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoJob - Busca descricao do Job (SigCdJob ou similar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarDescricaoJob()
        LOCAL loc_cCodigo, loc_nResultado, loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF TYPE("loc_oPg2.txt_4c_Job") != "O"
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Job.Value)

        IF EMPTY(loc_cCodigo)
            IF TYPE("loc_oPg2.txt_4c_DJob") = "O"
                loc_oPg2.txt_4c_DJob.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Jobs, Descrs FROM SigCdJob" + ;
                " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND Jobs = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_BuscaJob")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BuscaJob") > 0
                IF TYPE("loc_oPg2.txt_4c_DJob") = "O"
                    loc_oPg2.txt_4c_DJob.Value = ALLTRIM(cursor_4c_BuscaJob.Descrs)
                ENDIF
            ELSE
                IF TYPE("loc_oPg2.txt_4c_DJob") = "O"
                    loc_oPg2.txt_4c_DJob.Value = ""
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaJob")
                USE IN cursor_4c_BuscaJob
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_BuscaJob")
                USE IN cursor_4c_BuscaJob
            ENDIF
            MsgErro("Erro ao buscar job: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * OprKeyPressMoeda - KeyPress em Get_MOEDA: F4=lookup, Enter/Tab=valida
    *--------------------------------------------------------------------------
    PROCEDURE OprKeyPressMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            NODEFAULT
            THIS.AbrirLookupMoeda(.F.)
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeda(.F.)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OprKeyPressSMoeda - KeyPress em Get_smoeda: F4=lookup, Enter/Tab=valida
    *--------------------------------------------------------------------------
    PROCEDURE OprKeyPressSMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            NODEFAULT
            THIS.AbrirLookupMoeda(.T.)
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeda(.T.)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoeda - Lookup de moedas (SigCdMoe) via FormBuscaAuxiliar
    * par_lSide: .F.=debito, .T.=credito
    * No legado: fwBuscaSel com crSigCdMoe, campo CMoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupMoeda(par_lSide)
        LOCAL loc_oBusca, loc_cCodigo, loc_oPg2
        LOCAL loc_cTxtMoeda, loc_cTxtCotacao, loc_cValAtual
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !par_lSide
            loc_cTxtMoeda   = "txt_4c_MOEDA"
            loc_cTxtCotacao = "txt_4c_COTACAO"
        ELSE
            loc_cTxtMoeda   = "txt_4c_Smoeda"
            loc_cTxtCotacao = "txt_4c_SCOTACAO"
        ENDIF

        IF TYPE("loc_oPg2." + loc_cTxtMoeda) = "O"
            loc_cValAtual = ALLTRIM(loc_oPg2.Controls(loc_cTxtMoeda).Value)
        ELSE
            loc_cValAtual = ""
        ENDIF

        *-- MODO 1: FormBuscaAuxiliar busca em SigCdMoe
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeda", "CMoes", loc_cValAtual, ;
            "Moedas")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "d")
            loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                loc_cCodigo = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)

                IF TYPE("loc_oPg2." + loc_cTxtMoeda) = "O"
                    loc_oPg2.Controls(loc_cTxtMoeda).Value = loc_cCodigo
                ENDIF

                *-- Ao selecionar moeda, buscar cotacao atual
                THIS.AtualizarCotacaoParaMoeda(loc_cCodigo, loc_cTxtCotacao, par_lSide)
            ENDIF

            loc_oBusca.Release()
            loc_oBusca = .NULL.
        ENDIF

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoeda - Valida moeda digitada; se nao encontrar abre lookup
    * par_lSide: .F.=debito, .T.=credito
    * No legado: busca em crSigCdMoe por CMoes; se nao achar abre fwBuscaSel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarMoeda(par_lSide)
        LOCAL loc_cCodigo, loc_nResultado, loc_oPg2
        LOCAL loc_cTxtMoeda, loc_cTxtCotacao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !par_lSide
            loc_cTxtMoeda   = "txt_4c_MOEDA"
            loc_cTxtCotacao = "txt_4c_COTACAO"
        ELSE
            loc_cTxtMoeda   = "txt_4c_Smoeda"
            loc_cTxtCotacao = "txt_4c_SCOTACAO"
        ENDIF

        IF TYPE("loc_oPg2." + loc_cTxtMoeda) != "O"
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(loc_oPg2.Controls(loc_cTxtMoeda).Value)

        IF EMPTY(loc_cCodigo)
            RETURN
        ENDIF

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
                EscaparSQL(loc_cCodigo), ;
                "cursor_4c_ValMoeda")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValMoeda") > 0
                *-- Moeda valida: forcar codigo correto (maiusculo conforme banco)
                loc_oPg2.Controls(loc_cTxtMoeda).Value = ALLTRIM(cursor_4c_ValMoeda.CMoes)
                IF USED("cursor_4c_ValMoeda")
                    USE IN cursor_4c_ValMoeda
                ENDIF
                *-- Atualizar cotacao para a nova moeda
                THIS.AtualizarCotacaoParaMoeda(loc_cCodigo, loc_cTxtCotacao, par_lSide)
            ELSE
                *-- Moeda nao encontrada: abrir lookup para selecao
                IF USED("cursor_4c_ValMoeda")
                    USE IN cursor_4c_ValMoeda
                ENDIF
                THIS.AbrirLookupMoeda(par_lSide)
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_ValMoeda")
                USE IN cursor_4c_ValMoeda
            ENDIF
            MsgErro("Erro ao validar moeda: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCotacaoParaMoeda - Busca cotacao atual de uma moeda (SigCdCot)
    * e atualiza o campo de cotacao correspondente.
    * No legado: Select crSigCdCot / Set Order to Cotacaos Descending / Skip -1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarCotacaoParaMoeda(par_cMoeda, par_cTxtCotacao, par_lSide)
        LOCAL loc_nResultado, loc_nCotacao, loc_oPg2
        LOCAL loc_nValor, loc_nOutraCotacao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(par_cMoeda) OR par_cMoeda = "R"
            *-- Real: cotacao = 1 (moeda padrao)
            IF TYPE("loc_oPg2." + par_cTxtCotacao) = "O"
                loc_oPg2.Controls(par_cTxtCotacao).Value = 1
            ENDIF
            *-- Recalcular SVALOR
            THIS.RecalcularSValor()
            RETURN
        ENDIF

        TRY
            *-- Buscar cotacao mais recente em SigCdCot
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cotacaos FROM SigCdCot" + ;
                " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND Moedas = " + EscaparSQL(par_cMoeda) + ;
                " ORDER BY Datas DESC, Cotacaos DESC", ;
                "cursor_4c_Cotacao")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Cotacao") > 0
                loc_nCotacao = cursor_4c_Cotacao.Cotacaos
                IF TYPE("loc_oPg2." + par_cTxtCotacao) = "O"
                    loc_oPg2.Controls(par_cTxtCotacao).Value = loc_nCotacao
                ENDIF
            ENDIF

            IF USED("cursor_4c_Cotacao")
                USE IN cursor_4c_Cotacao
            ENDIF

            *-- Recalcular SVALOR apos mudanca de cotacao
            THIS.RecalcularSValor()

        CATCH TO loException
            IF USED("cursor_4c_Cotacao")
                USE IN cursor_4c_Cotacao
            ENDIF
            MsgErro("Erro ao buscar cota" + CHR(231) + CHR(227) + "o: " + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularSValor - Recalcula SVALOR = VALOR * COTACAO / SCOTACAO
    * Chamado apos mudanca de moeda ou cotacao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularSValor()
        LOCAL loc_oPg2, loc_nValor, loc_nCot, loc_nSCot
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF TYPE("loc_oPg2.txt_4c_VALOR") = "O" AND ;
            TYPE("loc_oPg2.txt_4c_COTACAO") = "O" AND ;
            TYPE("loc_oPg2.txt_4c_SCOTACAO") = "O" AND ;
            TYPE("loc_oPg2.txt_4c_SVALOR") = "O"

            loc_nValor = loc_oPg2.txt_4c_VALOR.Value
            loc_nCot   = loc_oPg2.txt_4c_COTACAO.Value
            loc_nSCot  = loc_oPg2.txt_4c_SCOTACAO.Value
            IF loc_nSCot != 0
                loc_oPg2.txt_4c_SVALOR.Value = loc_nValor * loc_nCot / loc_nSCot
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlteracotacaoClick - Habilita cotacao debito para edicao manual
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlteracotacaoClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF TYPE("loc_oPg2.txt_4c_COTACAO") = "O"
            loc_oPg2.txt_4c_COTACAO.ReadOnly = .F.
            loc_oPg2.txt_4c_COTACAO.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterascotacaoClick - Habilita cotacao credito para edicao manual
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterascotacaoClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF TYPE("loc_oPg2.txt_4c_SCOTACAO") = "O"
            loc_oPg2.txt_4c_SCOTACAO.ReadOnly = .F.
            loc_oPg2.txt_4c_SCOTACAO.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lHab
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_lHab = (par_lHabilitar = .T.)

        *-- Botao Salvar: habilitado apenas no modo INCLUIR ou ALTERAR
        IF TYPE("loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar") = "O"
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lHab
        ENDIF

        *-- Campos de data e dados do lancamento
        IF TYPE("loc_oPg2.txt_4c_Fweditdata_DATA") = "O"
            loc_oPg2.txt_4c_Fweditdata_DATA.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Fweditdata_VENC") = "O"
            loc_oPg2.txt_4c_Fweditdata_VENC.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_DtEmis") = "O"
            loc_oPg2.txt_4c_DtEmis.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Nota") = "O"
            loc_oPg2.txt_4c_Nota.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_DOCU") = "O"
            loc_oPg2.txt_4c_DOCU.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_OPER") = "O"
            loc_oPg2.txt_4c_OPER.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Grupo") = "O"
            loc_oPg2.txt_4c_Grupo.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Conta") = "O"
            loc_oPg2.txt_4c_Conta.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_MOEDA") = "O"
            loc_oPg2.txt_4c_MOEDA.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_VALOR") = "O"
            loc_oPg2.txt_4c_VALOR.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_COTACAO") = "O"
            loc_oPg2.txt_4c_COTACAO.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_SGRUPO") = "O"
            loc_oPg2.txt_4c_SGRUPO.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_SCONTA") = "O"
            loc_oPg2.txt_4c_SCONTA.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Smoeda") = "O"
            loc_oPg2.txt_4c_Smoeda.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_SVALOR") = "O"
            loc_oPg2.txt_4c_SVALOR.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_SCOTACAO") = "O"
            loc_oPg2.txt_4c_SCOTACAO.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_HIST") = "O"
            loc_oPg2.txt_4c_HIST.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Hist2") = "O"
            loc_oPg2.txt_4c_Hist2.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Job") = "O"
            loc_oPg2.txt_4c_Job.Enabled = loc_lHab
        ENDIF
        IF TYPE("loc_oPg2.obj_4c_Opcao_conta") = "O"
            loc_oPg2.obj_4c_Opcao_conta.Enabled = loc_lHab
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa campos da Page2 para novo registro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF TYPE("loc_oPg2.txt_4c_Fweditdata_DATA") = "O"
            loc_oPg2.txt_4c_Fweditdata_DATA.Value = DATE()
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Fweditdata_VENC") = "O"
            loc_oPg2.txt_4c_Fweditdata_VENC.Value = DATE()
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_DtEmis") = "O"
            loc_oPg2.txt_4c_DtEmis.Value = DATE()
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Nota") = "O"
            loc_oPg2.txt_4c_Nota.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_DOCU") = "O"
            loc_oPg2.txt_4c_DOCU.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_OPER") = "O"
            loc_oPg2.txt_4c_OPER.Value = "D"
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Grupo") = "O"
            loc_oPg2.txt_4c_Grupo.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Dgrupo") = "O"
            loc_oPg2.txt_4c_Dgrupo.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Conta") = "O"
            loc_oPg2.txt_4c_Conta.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Dconta") = "O"
            loc_oPg2.txt_4c_Dconta.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_MOEDA") = "O"
            loc_oPg2.txt_4c_MOEDA.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_VALOR") = "O"
            loc_oPg2.txt_4c_VALOR.Value = 0
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_COTACAO") = "O"
            loc_oPg2.txt_4c_COTACAO.Value = 1
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_SOPER") = "O"
            loc_oPg2.txt_4c_SOPER.Value = "C"
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_SGRUPO") = "O"
            loc_oPg2.txt_4c_SGRUPO.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Sdgrupo") = "O"
            loc_oPg2.txt_4c_Sdgrupo.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_SCONTA") = "O"
            loc_oPg2.txt_4c_SCONTA.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Sdconta") = "O"
            loc_oPg2.txt_4c_Sdconta.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Smoeda") = "O"
            loc_oPg2.txt_4c_Smoeda.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_SVALOR") = "O"
            loc_oPg2.txt_4c_SVALOR.Value = 0
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_SCOTACAO") = "O"
            loc_oPg2.txt_4c_SCOTACAO.Value = 1
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_HIST") = "O"
            loc_oPg2.txt_4c_HIST.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Hist2") = "O"
            loc_oPg2.txt_4c_Hist2.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Job") = "O"
            loc_oPg2.txt_4c_Job.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_DJob") = "O"
            loc_oPg2.txt_4c_DJob.Value = ""
        ENDIF
        IF TYPE("loc_oPg2.txt_4c__Usuario") = "O"
            loc_oPg2.txt_4c__Usuario.Value = gc_4c_UsuarioLogado
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere campos da Page2 para o Business Object
    * Usa TYPE() para seguranca: campos serao adicionados na Fase 5
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF TYPE("loc_oPg2.txt_4c_Fweditdata_DATA") = "O"
            THIS.this_oBusinessObject.this_dDatas = loc_oPg2.txt_4c_Fweditdata_DATA.Value
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Fweditdata_VENC") = "O"
            THIS.this_oBusinessObject.this_dVencs = loc_oPg2.txt_4c_Fweditdata_VENC.Value
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_DtEmis") = "O"
            THIS.this_oBusinessObject.this_dDtemis = loc_oPg2.txt_4c_DtEmis.Value
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Nota") = "O"
            THIS.this_oBusinessObject.this_cNfs = ALLTRIM(loc_oPg2.txt_4c_Nota.Value)
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_DOCU") = "O"
            THIS.this_oBusinessObject.this_cDocus = ALLTRIM(loc_oPg2.txt_4c_DOCU.Value)
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_OPER") = "O"
            THIS.this_oBusinessObject.this_cOpers = ALLTRIM(loc_oPg2.txt_4c_OPER.Value)
            THIS.this_oBusinessObject.this_cSOpers = IIF(ALLTRIM(loc_oPg2.txt_4c_OPER.Value) = "D", "C", "D")
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Grupo") = "O"
            THIS.this_oBusinessObject.this_cGrupos = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Conta") = "O"
            THIS.this_oBusinessObject.this_cContas = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_MOEDA") = "O"
            THIS.this_oBusinessObject.this_cMoedas = ALLTRIM(loc_oPg2.txt_4c_MOEDA.Value)
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_VALOR") = "O"
            THIS.this_oBusinessObject.this_nValors = loc_oPg2.txt_4c_VALOR.Value
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_COTACAO") = "O"
            THIS.this_oBusinessObject.this_nCotacaos = loc_oPg2.txt_4c_COTACAO.Value
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_SGRUPO") = "O"
            THIS.this_oBusinessObject.this_cSGrupos = ALLTRIM(loc_oPg2.txt_4c_SGRUPO.Value)
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_SCONTA") = "O"
            THIS.this_oBusinessObject.this_cSContas = ALLTRIM(loc_oPg2.txt_4c_SCONTA.Value)
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Smoeda") = "O"
            THIS.this_oBusinessObject.this_cSMoedas = ALLTRIM(loc_oPg2.txt_4c_Smoeda.Value)
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_SVALOR") = "O"
            THIS.this_oBusinessObject.this_nSValors = loc_oPg2.txt_4c_SVALOR.Value
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_SCOTACAO") = "O"
            THIS.this_oBusinessObject.this_nSCotacaos = loc_oPg2.txt_4c_SCOTACAO.Value
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_HIST") = "O"
            THIS.this_oBusinessObject.this_cHists = ALLTRIM(loc_oPg2.txt_4c_HIST.Value)
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Hist2") = "O"
            THIS.this_oBusinessObject.this_cHist2s = ALLTRIM(loc_oPg2.txt_4c_Hist2.Value)
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Job") = "O"
            THIS.this_oBusinessObject.this_cJobs = ALLTRIM(loc_oPg2.txt_4c_Job.Value)
        ENDIF
        IF TYPE("loc_oPg2.obj_4c_Opcao_conta") = "O"
            THIS.this_oBusinessObject.this_nContaPgs = loc_oPg2.obj_4c_Opcao_conta.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere propriedades do BO para os campos da Page2
    * Tambem busca descricoes de grupos, contas e job do banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_cGrupo, loc_cConta, loc_cSGrupo, loc_cSConta, loc_cJob
        LOCAL loc_nResultado
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Campos de data
        IF TYPE("loc_oPg2.txt_4c_Fweditdata_DATA") = "O"
            loc_oPg2.txt_4c_Fweditdata_DATA.Value = THIS.this_oBusinessObject.this_dDatas
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Fweditdata_VENC") = "O"
            loc_oPg2.txt_4c_Fweditdata_VENC.Value = THIS.this_oBusinessObject.this_dVencs
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_DtEmis") = "O"
            loc_oPg2.txt_4c_DtEmis.Value = THIS.this_oBusinessObject.this_dDtemis
        ENDIF

        *-- Campos de identificacao
        IF TYPE("loc_oPg2.txt_4c_Nota") = "O"
            loc_oPg2.txt_4c_Nota.Value = THIS.this_oBusinessObject.this_cNfs
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_DOCU") = "O"
            loc_oPg2.txt_4c_DOCU.Value = THIS.this_oBusinessObject.this_cDocus
        ENDIF
        IF TYPE("loc_oPg2.txt_4c__Usuario") = "O"
            loc_oPg2.txt_4c__Usuario.Value = THIS.this_oBusinessObject.this_cUsualts
        ENDIF

        *-- Job + descricao
        loc_cJob = ALLTRIM(THIS.this_oBusinessObject.this_cJobs)
        IF TYPE("loc_oPg2.txt_4c_Job") = "O"
            loc_oPg2.txt_4c_Job.Value = loc_cJob
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_DJob") = "O"
            loc_oPg2.txt_4c_DJob.Value = ""
            IF !EMPTY(loc_cJob)
                TRY
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT Jobs, Descrs FROM SigCdJob" + ;
                        " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                        " AND Jobs = " + EscaparSQL(loc_cJob), ;
                        "cursor_4c_BoJob")
                    IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BoJob") > 0
                        loc_oPg2.txt_4c_DJob.Value = ALLTRIM(cursor_4c_BoJob.Descrs)
                    ENDIF
                    IF USED("cursor_4c_BoJob")
                        USE IN cursor_4c_BoJob
                    ENDIF
                CATCH TO loException
                    IF USED("cursor_4c_BoJob")
                        USE IN cursor_4c_BoJob
                    ENDIF
                    MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o do Job: " + ;
                        loException.Message, "Erro")
                ENDTRY
            ENDIF
        ENDIF

        *-- Movimento debito
        IF TYPE("loc_oPg2.txt_4c_OPER") = "O"
            loc_oPg2.txt_4c_OPER.Value = THIS.this_oBusinessObject.this_cOpers
        ENDIF

        *-- Grupo debito + descricao
        loc_cGrupo = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
        IF TYPE("loc_oPg2.txt_4c_Grupo") = "O"
            loc_oPg2.txt_4c_Grupo.Value = loc_cGrupo
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Dgrupo") = "O"
            loc_oPg2.txt_4c_Dgrupo.Value = ""
            IF !EMPTY(loc_cGrupo)
                TRY
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT Codigos, Descrs FROM SigCdGcr" + ;
                        " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                        " AND Codigos = " + EscaparSQL(loc_cGrupo), ;
                        "cursor_4c_BoGrupo")
                    IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BoGrupo") > 0
                        loc_oPg2.txt_4c_Dgrupo.Value = ALLTRIM(cursor_4c_BoGrupo.Descrs)
                    ENDIF
                    IF USED("cursor_4c_BoGrupo")
                        USE IN cursor_4c_BoGrupo
                    ENDIF
                CATCH TO loException
                    IF USED("cursor_4c_BoGrupo")
                        USE IN cursor_4c_BoGrupo
                    ENDIF
                    MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o do Grupo: " + ;
                        loException.Message, "Erro")
                ENDTRY
            ENDIF
        ENDIF

        *-- Conta debito + descricao
        loc_cConta = ALLTRIM(THIS.this_oBusinessObject.this_cContas)
        IF TYPE("loc_oPg2.txt_4c_Conta") = "O"
            loc_oPg2.txt_4c_Conta.Value = loc_cConta
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Dconta") = "O"
            loc_oPg2.txt_4c_Dconta.Value = ""
            IF !EMPTY(loc_cConta)
                TRY
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT Contas, Descrs FROM SigCdCcr" + ;
                        " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                        " AND Contas = " + EscaparSQL(loc_cConta), ;
                        "cursor_4c_BoConta")
                    IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BoConta") > 0
                        loc_oPg2.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BoConta.Descrs)
                    ENDIF
                    IF USED("cursor_4c_BoConta")
                        USE IN cursor_4c_BoConta
                    ENDIF
                CATCH TO loException
                    IF USED("cursor_4c_BoConta")
                        USE IN cursor_4c_BoConta
                    ENDIF
                    MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o da Conta: " + ;
                        loException.Message, "Erro")
                ENDTRY
            ENDIF
        ENDIF

        *-- Moeda e valores debito
        IF TYPE("loc_oPg2.txt_4c_MOEDA") = "O"
            loc_oPg2.txt_4c_MOEDA.Value = THIS.this_oBusinessObject.this_cMoedas
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_VALOR") = "O"
            loc_oPg2.txt_4c_VALOR.Value = THIS.this_oBusinessObject.this_nValors
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_COTACAO") = "O"
            loc_oPg2.txt_4c_COTACAO.Value = THIS.this_oBusinessObject.this_nCotacaos
        ENDIF

        *-- Movimento credito (SOPER auto-calculado)
        IF TYPE("loc_oPg2.txt_4c_SOPER") = "O"
            loc_oPg2.txt_4c_SOPER.Value = THIS.this_oBusinessObject.this_cSOpers
        ENDIF

        *-- Grupo credito + descricao
        loc_cSGrupo = ALLTRIM(THIS.this_oBusinessObject.this_cSGrupos)
        IF TYPE("loc_oPg2.txt_4c_SGRUPO") = "O"
            loc_oPg2.txt_4c_SGRUPO.Value = loc_cSGrupo
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Sdgrupo") = "O"
            loc_oPg2.txt_4c_Sdgrupo.Value = ""
            IF !EMPTY(loc_cSGrupo)
                TRY
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT Codigos, Descrs FROM SigCdGcr" + ;
                        " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                        " AND Codigos = " + EscaparSQL(loc_cSGrupo), ;
                        "cursor_4c_BoSGrupo")
                    IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BoSGrupo") > 0
                        loc_oPg2.txt_4c_Sdgrupo.Value = ALLTRIM(cursor_4c_BoSGrupo.Descrs)
                    ENDIF
                    IF USED("cursor_4c_BoSGrupo")
                        USE IN cursor_4c_BoSGrupo
                    ENDIF
                CATCH TO loException
                    IF USED("cursor_4c_BoSGrupo")
                        USE IN cursor_4c_BoSGrupo
                    ENDIF
                    MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o do Grupo Credito: " + ;
                        loException.Message, "Erro")
                ENDTRY
            ENDIF
        ENDIF

        *-- Conta credito + descricao
        loc_cSConta = ALLTRIM(THIS.this_oBusinessObject.this_cSContas)
        IF TYPE("loc_oPg2.txt_4c_SCONTA") = "O"
            loc_oPg2.txt_4c_SCONTA.Value = loc_cSConta
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Sdconta") = "O"
            loc_oPg2.txt_4c_Sdconta.Value = ""
            IF !EMPTY(loc_cSConta)
                TRY
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT Contas, Descrs FROM SigCdCcr" + ;
                        " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                        " AND Contas = " + EscaparSQL(loc_cSConta), ;
                        "cursor_4c_BoSConta")
                    IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_BoSConta") > 0
                        loc_oPg2.txt_4c_Sdconta.Value = ALLTRIM(cursor_4c_BoSConta.Descrs)
                    ENDIF
                    IF USED("cursor_4c_BoSConta")
                        USE IN cursor_4c_BoSConta
                    ENDIF
                CATCH TO loException
                    IF USED("cursor_4c_BoSConta")
                        USE IN cursor_4c_BoSConta
                    ENDIF
                    MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o da Conta Credito: " + ;
                        loException.Message, "Erro")
                ENDTRY
            ENDIF
        ENDIF

        *-- Moeda e valores credito
        IF TYPE("loc_oPg2.txt_4c_Smoeda") = "O"
            loc_oPg2.txt_4c_Smoeda.Value = THIS.this_oBusinessObject.this_cSMoedas
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_SVALOR") = "O"
            loc_oPg2.txt_4c_SVALOR.Value = THIS.this_oBusinessObject.this_nSValors
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_SCOTACAO") = "O"
            loc_oPg2.txt_4c_SCOTACAO.Value = THIS.this_oBusinessObject.this_nSCotacaos
        ENDIF

        *-- Historico
        IF TYPE("loc_oPg2.txt_4c_HIST") = "O"
            loc_oPg2.txt_4c_HIST.Value = THIS.this_oBusinessObject.this_cHists
        ENDIF
        IF TYPE("loc_oPg2.txt_4c_Hist2") = "O"
            loc_oPg2.txt_4c_Hist2.Value = THIS.this_oBusinessObject.this_cHist2s
        ENDIF

        *-- Opcao conta
        IF TYPE("loc_oPg2.obj_4c_Opcao_conta") = "O"
            LOCAL loc_nOpc
            loc_nOpc = THIS.this_oBusinessObject.this_nContaPgs
            loc_oPg2.obj_4c_Opcao_conta.Value = IIF(loc_nOpc >= 1 AND loc_nOpc <= 2, ;
                loc_nOpc, 1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * OBRIGATORIO: AddObject cria controles com Visible=.F.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Trata PageFrame - itera Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Trata containers com ControlCount
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
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
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_DadosTemp")
            USE IN cursor_4c_DadosTemp
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*==============================================================================
* sigmvccrBO.prg - Business Object para Conta Corrente Geral
* Tabela: SigMvCcr
* Fase 1/8: Propriedades e Init()
*==============================================================================

DEFINE CLASS sigmvccrBO AS BusinessBase

    *-- Chave primaria composta: Emps + Nopers (cidchaves = chave unica gerada)
    this_cEmps        = ""    && Empresa (3)
    this_nNopers      = 0     && Numero da operacao (PK numerico)
    this_cCidChaves   = ""    && Chave unica gerada (cidchaves C20)

    *-- Datas
    this_dDatas       = {}    && Data do lancamento
    this_dVencs       = {}    && Vencimento
    this_dDtemis      = {}    && Data de emissao (dtemis)
    this_dDatAlts     = {}    && Data de alteracao (datalts)
    this_dDatExcs     = {}    && Data de exclusao (datexcs)
    this_dDatatrans   = {}    && Data de transacao

    *-- Movimento debito (lado esquerdo - Get_grupo/Get_conta)
    this_cOpers       = ""    && Operacao D/C (opers)
    this_cGrupos      = ""    && Grupo conta corrente debito (grupos)
    this_cContas      = ""    && Conta corrente debito (contas)
    this_cMoedas      = ""    && Moeda (moedas)
    this_nCotacaos    = 0     && Cotacao (cotacaos)
    this_nValors      = 0     && Valor (valors)
    this_cCotUsus     = ""    && Cotacao usurio - alteracao manual (cotusus)

    *-- Movimento credito/contrapartida (lado direito - Get_sgrupo/Get_sconta)
    this_cSOpers      = ""    && Operacao contrapartida D/C (sopers)
    this_cSGrupos     = ""    && Grupo conta corrente credito (sgrupos)
    this_cSContas     = ""    && Conta corrente credito (scontas)
    this_cSMoedas     = ""    && Moeda contrapartida (smoedas)
    this_nSCotacaos   = 0     && Cotacao contrapartida (scotacaos)
    this_nSValors     = 0     && Valor contrapartida (svalors)

    *-- Identificacao do lancamento
    this_cNfs         = ""    && Nota fiscal (nfs)
    this_cDocus       = ""    && Documento (docus)
    this_cHists       = ""    && Historico (hists)
    this_cHist2s      = ""    && Historico complementar (hist2s)
    this_cShists      = ""    && Historico contrapartida (shists)
    this_cUsualts     = ""    && Usuario do lancamento (usualts)
    this_cUsuExcs     = ""    && Usuario de exclusao (usuexcs)
    this_nContaPgs    = 0     && Tipo conta pagamento - opcao_conta (contapgs)

    *-- Job (centro de custo)
    this_cJobs        = ""    && Codigo do job (jobs)

    *-- Controle interno e auditoria
    this_lAutos       = .F.   && Flag de processamento automatico (autos)
    this_cGruConMoes  = ""    && Chave composta grupos+contas+moedas (gruconmoes)
    this_nNumes       = 0     && Numero (numes)
    this_cDopcs       = ""    && Documento contrapartida (dopcs)
    this_nNumcs       = 0     && Numero contrapartida (numcs)
    this_cVOpers      = ""    && Codigo operacao com empresa (vopers)
    this_cDopes       = ""    && Codigo do tipo de operacao (dopes)
    this_nNtrans      = 0     && Numero de transacao (ntrans)
    this_nNlancs      = 0     && Numero de lancamento (nlancs)

    *-- Conciliacao
    this_nConcs       = 0     && Flag conciliado (concs)
    this_dDataConcs   = {}    && Data de conciliacao (dataconcs)
    this_cUsuConcs    = ""    && Usuario conciliacao (usuconcs)

    *-- Saldos calculados (somente leitura na grade)
    this_nSaldos      = 0     && Saldo (saldos)
    this_nValLiqs     = 0     && Valor liquido (valliqs)
    this_nValPags     = 0     && Valor pago (valpags)
    this_nValPrev     = 0     && Valor previsto (valprev)
    this_nValOcurs    = 0     && Valor em outra moeda (valocurs)

    *-- Campos adicionais da tabela
    this_cTipos       = ""    && Tipo (tipos)
    this_cTitulos     = ""    && Titulo (titulos)
    this_cTitBans     = ""    && Titulo bancario (titbans)
    this_cLocals      = ""    && Local (locals)
    this_cGrupAges    = ""    && Grupo agencia (grupages)
    this_cGrupEms     = ""    && Grupo empresa (grupems)
    this_cContAges    = ""    && Conta agencia (contages)
    this_cContEms     = ""    && Conta empresa (contems)
    this_cBContas     = ""    && B contas (bcontas)
    this_cBGrupos     = ""    && B grupos (bgrupos)
    this_cBorderos    = ""    && Borderdo (borderos)
    this_nIntConts    = 0     && Integracao contabil (intconts)
    this_cAuditors    = ""    && Auditor (auditors)
    this_dDtAudits    = {}    && Data auditoria (dtaudits)
    this_cEmpDopNcs   = ""    && Empresa+doc+nc (empdopncs)
    this_nEmpDopNums  = 0     && Empresa+doc+num (empdopnums)
    this_nPagos       = 0     && Pago flag (pagos)
    this_cDopotps     = ""    && Tipo pagamento (dopotps)
    this_cUsuPagos    = ""    && Usuario pagamento (usupagos)
    this_cTitCancs    = ""    && Titulo cancelado (titcancs)
    this_dDtConfs     = {}    && Data confirmacao (dtconfs)
    this_cUsuConfs    = ""    && Usuario confirmacao (usuconfs)
    this_nNOperCancs  = 0     && Numero operacao cancelada (nopercancs)
    this_cEspecieNfs  = ""    && Especie nota fiscal (especienfs)
    this_nImpostos    = 0     && Impostos (impostos)
    this_cTpImpostos  = ""    && Tipo impostos (tpimpostos)
    this_cTitPais     = ""    && Titulo pais (titpais)
    this_cEmpCcs      = ""    && Empresa conta corrente (empccs)
    this_nRecor       = 0     && Recorrencia (recor)
    this_cCompet      = ""    && Competencia (compet)
    this_cEmpos       = ""    && Empresa origem (empos)
    this_nOriDopNums  = 0     && Origem documento num (oridopnums)
    this_cRContas     = ""    && Rota contas (rcontas)
    this_cTpDocNf     = ""    && Tipo documento NF (tpdocnf)
    this_nSaldocs     = 0     && Saldo documentos (saldocs)
    this_nSaldons     = 0     && Saldo notas (saldons)
    this_nVlancs      = 0     && Valor lancamentos (vlancs)

    *===========================================================================
    PROCEDURE Init()
    *===========================================================================
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = "Nopers"
        RETURN .T.
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
    *===========================================================================
    * Retorna identificador para auditoria (empresa + numero operacao)
        RETURN ALLTRIM(THIS.this_cEmps) + "-" + TRANSFORM(THIS.this_nNopers)
    ENDPROC

    *===========================================================================
    PROCEDURE Buscar(par_cFiltro)
    *===========================================================================
    *-- Busca lancamentos por empresa e filtro adicional (ex: periodo de datas)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Opers, a.Grupos, a.Contas," + ;
                " a.Moedas, a.Cotacaos, a.Valors, a.Hists, a.Hist2s, a.Shists," + ;
                " a.Nfs, a.Docus, a.Sgrupos, a.Scontas, a.Smoedas, a.Scotacaos," + ;
                " a.Svalors, a.Sopers, a.Vencs, a.Dtemis, a.Usualts, a.Jobs," + ;
                " a.Contapgs, a.Concs, a.Dataconcs, a.Usuconcs, a.Datalts," + ;
                " a.Dopes, a.Numes, a.Dopcs, a.Numcs, a.Vopers, a.CidChaves," + ;
                " a.Autos, a.GruConMoes, a.Ntrans, a.Nlancs, a.CotUsus" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Datas, a.Nopers"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar lan" + CHR(231) + "amentos:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROCEDURE CarregarPorCodigo(par_nNopers)
    *===========================================================================
    *-- Carrega lancamento pelo numero de operacao (Nopers)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Opers, a.Grupos, a.Contas," + ;
                " a.Moedas, a.Cotacaos, a.Valors, a.Hists, a.Hist2s, a.Shists," + ;
                " a.Nfs, a.Docus, a.Sgrupos, a.Scontas, a.Smoedas, a.Scotacaos," + ;
                " a.Svalors, a.Sopers, a.Vencs, a.Dtemis, a.Usualts, a.Jobs," + ;
                " a.Contapgs, a.Concs, a.Dataconcs, a.Usuconcs, a.Datalts," + ;
                " a.Dopes, a.Numes, a.Dopcs, a.Numcs, a.Vopers, a.CidChaves," + ;
                " a.Autos, a.GruConMoes, a.Ntrans, a.Nlancs, a.CotUsus" + ;
                " FROM SigMvCcr a" + ;
                " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND a.Nopers = " + TRANSFORM(par_nNopers)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *===========================================================================
    *-- Mapeia campos do cursor para propriedades this_*
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmps       = TratarNulo(Emps, "C")
            THIS.this_nNopers     = TratarNulo(Nopers, "N")
            THIS.this_dDatas      = IIF(ISNULL(Datas)  .OR. EMPTY(Datas),  {}, TTOD(Datas))
            THIS.this_dVencs      = IIF(ISNULL(Vencs)  .OR. EMPTY(Vencs),  {}, TTOD(Vencs))
            THIS.this_dDtemis     = IIF(ISNULL(Dtemis) .OR. EMPTY(Dtemis), {}, TTOD(Dtemis))
            THIS.this_cOpers      = TratarNulo(Opers, "C")
            THIS.this_cGrupos     = TratarNulo(Grupos, "C")
            THIS.this_cContas     = TratarNulo(Contas, "C")
            THIS.this_cMoedas     = TratarNulo(Moedas, "C")
            THIS.this_nCotacaos   = TratarNulo(Cotacaos, "N")
            THIS.this_nValors     = TratarNulo(Valors, "N")
            THIS.this_cSOpers     = TratarNulo(Sopers, "C")
            THIS.this_cSGrupos    = TratarNulo(Sgrupos, "C")
            THIS.this_cSContas    = TratarNulo(Scontas, "C")
            THIS.this_cSMoedas    = TratarNulo(Smoedas, "C")
            THIS.this_nSCotacaos  = TratarNulo(Scotacaos, "N")
            THIS.this_nSValors    = TratarNulo(Svalors, "N")
            THIS.this_cNfs        = TratarNulo(Nfs, "C")
            THIS.this_cDocus      = TratarNulo(Docus, "C")
            THIS.this_cHists      = TratarNulo(Hists, "C")
            THIS.this_cHist2s     = TratarNulo(Hist2s, "C")
            THIS.this_cShists     = TratarNulo(Shists, "C")
            THIS.this_cUsualts    = TratarNulo(Usualts, "C")
            THIS.this_cJobs       = TratarNulo(Jobs, "C")
            THIS.this_nContaPgs   = TratarNulo(Contapgs, "N")
            THIS.this_nConcs      = TratarNulo(Concs, "N")
            THIS.this_cGruConMoes = TratarNulo(GruConMoes, "C")
            THIS.this_cCidChaves  = TratarNulo(CidChaves, "C")
            THIS.this_lAutos      = (IIF(VARTYPE(Autos) = "L", Autos, (IIF(VARTYPE(Autos) = "L", Autos, (IIF(VARTYPE(Autos) = "L", Autos, (IIF(VARTYPE(Autos) = "L", Autos, (NVL(Autos, 0) = 1)))))))))
            THIS.this_cDopes      = TratarNulo(Dopes, "C")
            THIS.this_nNumes      = TratarNulo(Numes, "N")
            THIS.this_cDopcs      = TratarNulo(Dopcs, "C")
            THIS.this_nNumcs      = TratarNulo(Numcs, "N")
            THIS.this_cVOpers     = TratarNulo(Vopers, "C")
            THIS.this_nNtrans     = TratarNulo(Ntrans, "N")
            THIS.this_nNlancs     = TratarNulo(Nlancs, "N")
            THIS.this_cCotUsus    = TratarNulo(CotUsus, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE Inserir()
    *===========================================================================
    *-- Insere novo lancamento em SigMvCcr gerando Nopers sequencial
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        LOCAL loc_nProxNopers, loc_cCidChaves, loc_cGruConMoes
        LOCAL loc_cDataLanc, loc_cDataVenc, loc_cDataEmis
        loc_lResultado = .F.
        loc_nProxNopers = 0

        TRY
            *-- 1. Obter proximo Nopers para a empresa
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(Nopers), 0) + 1 AS ProxNopers" + ;
                " FROM SigMvCcr WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                "cursor_4c_ProxN")
            IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ProxN") = 0
                MsgErro("Erro ao gerar n" + CHR(250) + "mero de opera" + CHR(231) + CHR(227) + "o.", "Erro")
            ELSE
                SELECT cursor_4c_ProxN
                loc_nProxNopers = cursor_4c_ProxN.ProxNopers
                USE IN cursor_4c_ProxN

                THIS.this_nNopers    = loc_nProxNopers
                THIS.this_cEmps      = go_4c_Sistema.cCodEmpresa
                THIS.this_cUsualts   = gc_4c_UsuarioLogado
                THIS.this_lAutos     = .F.

                *-- 2. Calcular campos derivados (padrao do legado)
                THIS.this_cGruConMoes = ALLTRIM(THIS.this_cGrupos) + ;
                    ALLTRIM(THIS.this_cContas) + ALLTRIM(THIS.this_cMoedas)
                THIS.this_cCidChaves  = DTOS(THIS.this_dDatas) + ;
                    TRANSFORM(loc_nProxNopers, "@L 999999")

                *-- 3. Formatar datas para SQL
                loc_cDataLanc = IIF(EMPTY(THIS.this_dDatas), "NULL", ;
                    "'" + DTOS(THIS.this_dDatas) + "'")
                loc_cDataVenc = IIF(EMPTY(THIS.this_dVencs), "NULL", ;
                    "'" + DTOS(THIS.this_dVencs) + "'")
                loc_cDataEmis = IIF(EMPTY(THIS.this_dDtemis), "NULL", ;
                    "'" + DTOS(THIS.this_dDtemis) + "'")

                *-- 4. Montar INSERT
                loc_cSQL = "INSERT INTO SigMvCcr (Emps, Nopers, CidChaves, Datas, Vencs, Dtemis, Opers, Grupos, Contas, Moedas, Cotacaos, Valors, Sopers, Sgrupos, Scontas, Smoedas, Scotacaos, Svalors, Nfs, Docus, Hists, Hist2s, Shists, Usualts, Jobs, Contapgs, GruConMoes, Autos, Datalts, CotUsus) VALUES (" + ;
                    EscaparSQL(THIS.this_cEmps) + "," + ;
                    TRANSFORM(THIS.this_nNopers) + "," + ;
                    EscaparSQL(THIS.this_cCidChaves) + "," + ;
                    loc_cDataLanc + "," + ;
                    loc_cDataVenc + "," + ;
                    loc_cDataEmis + "," + ;
                    EscaparSQL(THIS.this_cOpers) + "," + ;
                    EscaparSQL(THIS.this_cGrupos) + "," + ;
                    EscaparSQL(THIS.this_cContas) + "," + ;
                    EscaparSQL(THIS.this_cMoedas) + "," + ;
                    FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                    FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                    EscaparSQL(THIS.this_cSOpers) + "," + ;
                    EscaparSQL(THIS.this_cSGrupos) + "," + ;
                    EscaparSQL(THIS.this_cSContas) + "," + ;
                    EscaparSQL(THIS.this_cSMoedas) + "," + ;
                    FormatarNumeroSQL(THIS.this_nSCotacaos) + "," + ;
                    FormatarNumeroSQL(THIS.this_nSValors) + "," + ;
                    EscaparSQL(THIS.this_cNfs) + "," + ;
                    EscaparSQL(THIS.this_cDocus) + "," + ;
                    EscaparSQL(THIS.this_cHists) + "," + ;
                    EscaparSQL(THIS.this_cHist2s) + "," + ;
                    EscaparSQL(THIS.this_cShists) + "," + ;
                    EscaparSQL(THIS.this_cUsualts) + "," + ;
                    EscaparSQL(THIS.this_cJobs) + "," + ;
                    TRANSFORM(THIS.this_nContaPgs) + "," + ;
                    EscaparSQL(THIS.this_cGruConMoes) + "," + ;
                    IIF(THIS.this_lAutos, "1", "0") + "," + ;
                    "GETDATE()," + ;
                    EscaparSQL(THIS.this_cCotUsus) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir lan" + CHR(231) + "amento:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Inserir: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ProxN")
            USE IN cursor_4c_ProxN
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE Atualizar()
    *===========================================================================
    *-- Atualiza lancamento existente em SigMvCcr
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        LOCAL loc_cDataLanc, loc_cDataVenc, loc_cDataEmis
        loc_lResultado = .F.

        TRY
            *-- Recalcular campos derivados
            THIS.this_cGruConMoes = ALLTRIM(THIS.this_cGrupos) + ;
                ALLTRIM(THIS.this_cContas) + ALLTRIM(THIS.this_cMoedas)

            *-- Formatar datas
            loc_cDataLanc = IIF(EMPTY(THIS.this_dDatas), "NULL", ;
                "'" + DTOS(THIS.this_dDatas) + "'")
            loc_cDataVenc = IIF(EMPTY(THIS.this_dVencs), "NULL", ;
                "'" + DTOS(THIS.this_dVencs) + "'")
            loc_cDataEmis = IIF(EMPTY(THIS.this_dDtemis), "NULL", ;
                "'" + DTOS(THIS.this_dDtemis) + "'")

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                " Datas = "      + loc_cDataLanc + "," + ;
                " Vencs = "      + loc_cDataVenc + "," + ;
                " Dtemis = "     + loc_cDataEmis + "," + ;
                " Opers = "      + EscaparSQL(THIS.this_cOpers) + "," + ;
                " Grupos = "     + EscaparSQL(THIS.this_cGrupos) + "," + ;
                " Contas = "     + EscaparSQL(THIS.this_cContas) + "," + ;
                " Moedas = "     + EscaparSQL(THIS.this_cMoedas) + "," + ;
                " Cotacaos = "   + FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                " Valors = "     + FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                " Sopers = "     + EscaparSQL(THIS.this_cSOpers) + "," + ;
                " Sgrupos = "    + EscaparSQL(THIS.this_cSGrupos) + "," + ;
                " Scontas = "    + EscaparSQL(THIS.this_cSContas) + "," + ;
                " Smoedas = "    + EscaparSQL(THIS.this_cSMoedas) + "," + ;
                " Scotacaos = "  + FormatarNumeroSQL(THIS.this_nSCotacaos) + "," + ;
                " Svalors = "    + FormatarNumeroSQL(THIS.this_nSValors) + "," + ;
                " Nfs = "        + EscaparSQL(THIS.this_cNfs) + "," + ;
                " Docus = "      + EscaparSQL(THIS.this_cDocus) + "," + ;
                " Hists = "      + EscaparSQL(THIS.this_cHists) + "," + ;
                " Hist2s = "     + EscaparSQL(THIS.this_cHist2s) + "," + ;
                " Shists = "     + EscaparSQL(THIS.this_cShists) + "," + ;
                " Jobs = "       + EscaparSQL(THIS.this_cJobs) + "," + ;
                " Contapgs = "   + TRANSFORM(THIS.this_nContaPgs) + "," + ;
                " GruConMoes = " + EscaparSQL(THIS.this_cGruConMoes) + "," + ;
                " CotUsus = "    + EscaparSQL(THIS.this_cCotUsus) + "," + ;
                " Datalts = GETDATE()" + ;
                " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND Nopers = " + TRANSFORM(THIS.this_nNopers)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *===========================================================================
    *-- Exclui lancamento: marca DatExcs/UsuExcs e depois deleta fisicamente
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- 1. Marcar data/usuario de exclusao (padrao do legado)
            loc_cSQL = "UPDATE SigMvCcr" + ;
                " SET DatExcs = GETDATE(), UsuExcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND Nopers = " + TRANSFORM(THIS.this_nNopers)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                *-- 2. Excluir fisicamente o registro
                loc_cSQL = "DELETE FROM SigMvCcr" + ;
                    " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                    " AND Nopers = " + TRANSFORM(THIS.this_nNopers)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir lan" + CHR(231) + "amento:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao marcar exclus" + CHR(227) + "o:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

