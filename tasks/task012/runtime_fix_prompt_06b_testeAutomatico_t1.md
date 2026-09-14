# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 421; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 551

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-04-11 17:10:05] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-11 17:10:05] [INFO] Config FPW: (nao fornecido)
[2026-04-11 17:10:05] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-11 17:10:05] [INFO] Timeout: 300 segundos
[2026-04-11 17:10:05] [INFO] Wrapper PRG criado para parametros: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_shkafkpd.prg
[2026-04-11 17:10:05] [INFO] Conteudo do wrapper:
[2026-04-11 17:10:05] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigmvccr', 'C:\4c\tasks\task012', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigmvccr', 'C:\4c\tasks\task012', 'CRUD'
QUIT

[2026-04-11 17:10:05] [INFO] Comando VFP: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_shkafkpd.prg
[2026-04-11 17:10:05] [INFO] VFP output esperado em: C:\4c\tasks\task012\vfp_output.txt
[2026-04-11 17:10:05] [INFO] Executando Visual FoxPro 9...
[2026-04-11 17:10:05] [INFO] Comando completo: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_shkafkpd.prg
[2026-04-11 17:10:05] [INFO] Executando: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_shkafkpd.prg
[2026-04-11 17:10:05] [INFO] Timeout configurado: 300 segundos
[2026-04-11 17:10:07] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-11 17:10:07] [INFO] VFP9 finalizado em 1.4697651 segundos
[2026-04-11 17:10:07] [INFO] Exit Code: 
[2026-04-11 17:10:07] [INFO] 
[2026-04-11 17:10:07] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-11 17:10:07] [INFO]   Wrapper.prg: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_shkafkpd.prg
[2026-04-11 17:10:07] [INFO] 
[2026-04-11 17:10:07] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-11 17:10:07] [INFO] * Auto-generated wrapper for parameters
[2026-04-11 17:10:07] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-11 17:10:07] [INFO] * Parameters: 'Formsigmvccr', 'C:\4c\tasks\task012', 'CRUD'
[2026-04-11 17:10:07] [INFO] 
[2026-04-11 17:10:07] [INFO] * Anti-dialog protections for unattended execution
[2026-04-11 17:10:07] [INFO] SET SAFETY OFF
[2026-04-11 17:10:07] [INFO] SET RESOURCE OFF
[2026-04-11 17:10:07] [INFO] SET TALK OFF
[2026-04-11 17:10:07] [INFO] SET NOTIFY OFF
[2026-04-11 17:10:07] [INFO] SYS(2335, 0)
[2026-04-11 17:10:07] [INFO] 
[2026-04-11 17:10:07] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigmvccr', 'C:\4c\tasks\task012', 'CRUD'
[2026-04-11 17:10:07] [INFO] QUIT
[2026-04-11 17:10:07] [INFO] 
[2026-04-11 17:10:07] [INFO] === Fim do Wrapper.prg ===
[2026-04-11 17:10:07] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigmvccr",
  "timestamp": "20260411171007",
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
      "detalhes": "AbrirLookup: 7 (ABRIRLOOKUPCONTA, ABRIRLOOKUPGRUPO, ABRIRLOOKUPJOB, ABRIRLOOKUPMOEDA, ABRIRLOOKUPSCONTA, ABRIRLOOKUPSGRUPO, ABRIRLOOKUPSMOEDA) | KeyPress handlers: 8 (CONTAKEYPRESS, GRUPOKEYPRESS, JOBKEYPRESS, KEYPRESS, MOEDAKEYPRESS, SCONTAKEYPRESS, SGRUPOKEYPRESS, SMOEDAKEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg):
*==============================================================================
* Formsigmvccr.prg - Formulario de Conta Corrente Geral
* Fase 8/8 - COMPLETO: LimparCampos, AjustarBotoesPorModo, consolidacao final
* Data: 2026-04-11
* Legado: SIGMVCCR (frmcadastro)
* Tabela: SigMvCcr
*==============================================================================

DEFINE CLASS Formsigmvccr AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - UX Fidelity)
    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    * Propriedades do form
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"    && LISTA | INCLUIR | ALTERAR | VISUALIZAR

    *==========================================================================
    * INICIALIZACAO
    *==========================================================================

    *--------------------------------------------------------------------------
    * Init - apenas delega ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial (chamado pelo FormBase.Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigmvccrBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigmvccrBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Propagar Caption para labels do cabecalho
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra, "Caption", 5)
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo, "Caption", 5)
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                ENDIF

                *-- Carregar lista inicial (pular se validando UI)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            WITH THIS.pgf_4c_Paginas
                .PageCount  = 2
                .Top        = -29
                .Left       = 0
                .Width      = THIS.Width
                .Height     = THIS.Height + 29
                .Tabs       = .F.
                .Visible    = .T.
                .Page1.Caption   = "Lista"
                .Page2.Caption   = "Dados"
                .Page1.BackColor = RGB(240, 240, 240)
                .Page2.BackColor = RGB(240, 240, 240)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PAGE1 - LISTA COM GRID E BOTOES CRUD
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1: grid, botoes, filtro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *--------------------------------------------------------------------
            * Container cabecalho (titulo do form) - Top=2+29=31
            *--------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 31
                .Left        = 0
                .Width       = 935
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(53, 53, 53)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Top       = 15
                    .Left      = 10
                    .Width     = 909
                    .Height    = 40
                    .Caption   = "Conta Corrente Geral"
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Top       = 18
                    .Left      = 10
                    .Width     = 909
                    .Height    = 46
                    .Caption   = "Conta Corrente Geral"
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(255, 255, 255)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *--------------------------------------------------------------------
            * Container botoes CRUD (lado direito, Top=0+29=29)
            *--------------------------------------------------------------------
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

                *-- cmd_4c_Incluir
                .AddObject("cmd_4c_Incluir", "CommandButton")
                WITH .cmd_4c_Incluir
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
                    .FontSize        = 8
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                *-- cmd_4c_Visualizar
                .AddObject("cmd_4c_Visualizar", "CommandButton")
                WITH .cmd_4c_Visualizar
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
                    .FontSize        = 8
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                *-- cmd_4c_Alterar
                .AddObject("cmd_4c_Alterar", "CommandButton")
                WITH .cmd_4c_Alterar
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
                    .FontSize        = 8
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                *-- cmd_4c_Excluir
                .AddObject("cmd_4c_Excluir", "CommandButton")
                WITH .cmd_4c_Excluir
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
                    .FontSize        = 8
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                *-- cmd_4c_Buscar
                .AddObject("cmd_4c_Buscar", "CommandButton")
                WITH .cmd_4c_Buscar
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
                    .FontSize        = 8
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            *--------------------------------------------------------------------
            * Container saida - Encerrar (Top=0+29=29, Left=937)
            *--------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_Saida", "Container")
            WITH loc_oPagina.cnt_4c_Saida
                .Top         = 29
                .Left        = 937
                .Width       = 60
                .Height      = 85
                .BackStyle   = 1
                .BackColor   = RGB(53, 53, 53)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Encerrar", "CommandButton")
                WITH .cmd_4c_Encerrar
                    .Caption         = "Encerrar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            = 5
                    .Width           = 50
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontSize        = 8
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            *--------------------------------------------------------------------
            * Botao Movimento (Anexa) - Top=4+29=33, Left=847
            *--------------------------------------------------------------------
            loc_oPagina.AddObject("cmd_4c_Movimento", "CommandButton")
            WITH loc_oPagina.cmd_4c_Movimento
                .Caption         = "Movimento"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition = 13
                .Top             = 33
                .Left            = 847
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            *--------------------------------------------------------------------
            * Container filtro periodo (Top=114, abaixo do cabecalho+botoes)
            *--------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
            WITH loc_oPagina.cnt_4c_Filtros
                .Top         = 114
                .Left        = 0
                .Width       = 400
                .Height      = 36
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Periodo", "Label")
                WITH .lbl_4c_Periodo
                    .Caption   = "Per" + CHR(237) + "odo : "
                    .Top       = 10
                    .Left      = 17
                    .Width     = 54
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_DtInicial", "TextBox")
                WITH .txt_4c_DtInicial
                    .Top      = 6
                    .Left     = 73
                    .Width    = 80
                    .Height   = 21
                    .Value    = {}
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .Format   = "D"
                    .Visible  = .T.
                ENDWITH

                .AddObject("lbl_4c_Ate", "Label")
                WITH .lbl_4c_Ate
                    .Caption   = "at" + CHR(233)
                    .Top       = 10
                    .Left      = 158
                    .Width     = 20
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_DtFinal", "TextBox")
                WITH .txt_4c_DtFinal
                    .Top      = 6
                    .Left     = 184
                    .Width    = 80
                    .Height   = 21
                    .Value    = {}
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .Format   = "D"
                    .Visible  = .T.
                ENDWITH
            ENDWITH

            *--------------------------------------------------------------------
            * Cursor placeholder para o Grid (preserva colunas durante reloads)
            * O grid usa cursor_4c_Grade; os dados vem via ZAP+APPEND em CarregarLista()
            *--------------------------------------------------------------------
            SET NULL ON
            CREATE CURSOR cursor_4c_Grade ( ;
                Datas      T, ;
                Opers      C(1), ;
                Contas     C(10), ;
                Scontas    C(10), ;
                Hists      C(60), ;
                Valors     N(11,2), ;
                Svalors    N(11,2), ;
                Concs      L, ;
                Autos      L, ;
                Nfs        C(10), ;
                Docus      C(10), ;
                Nopers     N(7,0), ;
                Cidchaves  C(20) ;
            )
            SET NULL OFF

            *--------------------------------------------------------------------
            * Grid de dados (11 colunas, ordem visual identica ao legado)
            *--------------------------------------------------------------------
            loc_oPagina.AddObject("grd_4c_Dados", "Grid")
            loc_oGrid = loc_oPagina.grd_4c_Dados

            loc_oGrid.Top              = 150
            loc_oGrid.Left             = 5
            loc_oGrid.Width            = 986
            loc_oGrid.Height           = 472
            loc_oGrid.FontName         = "Verdana"
            loc_oGrid.FontSize         = 8
            loc_oGrid.ForeColor        = RGB(90, 90, 90)
            loc_oGrid.BackColor        = RGB(255, 255, 255)
            loc_oGrid.GridLineColor    = RGB(238, 238, 238)
            loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
            loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
            loc_oGrid.HighlightStyle   = 2
            loc_oGrid.DeleteMark       = .F.
            loc_oGrid.RecordMark       = .F.
            loc_oGrid.RowHeight        = 16
            loc_oGrid.ScrollBars       = 2
            loc_oGrid.GridLines        = 3
            loc_oGrid.Visible          = .T.

            *-- ColumnCount e RecordSource FORA de WITH (evita "Unknown member COLUMN1")
            loc_oGrid.ColumnCount  = 11
            loc_oGrid.RecordSource = "cursor_4c_Grade"

            *-- ControlSource APOS RecordSource (evita auto-bind por posicao)
            loc_oGrid.Column1.ControlSource  = "cursor_4c_Grade.Datas"
            loc_oGrid.Column2.ControlSource  = "cursor_4c_Grade.Opers"
            loc_oGrid.Column3.ControlSource  = "cursor_4c_Grade.Contas"
            loc_oGrid.Column4.ControlSource  = "cursor_4c_Grade.Scontas"
            loc_oGrid.Column5.ControlSource  = "cursor_4c_Grade.Hists"
            loc_oGrid.Column6.ControlSource  = "cursor_4c_Grade.Valors"
            loc_oGrid.Column7.ControlSource  = "cursor_4c_Grade.Svalors"
            loc_oGrid.Column8.ControlSource  = "cursor_4c_Grade.Concs"
            loc_oGrid.Column9.ControlSource  = "cursor_4c_Grade.Autos"
            loc_oGrid.Column10.ControlSource = "cursor_4c_Grade.Nfs"
            loc_oGrid.Column11.ControlSource = "cursor_4c_Grade.Docus"

            *-- Larguras das colunas
            loc_oGrid.Column1.Width  = 65     && Data
            loc_oGrid.Column2.Width  = 20     && O (D/C)
            loc_oGrid.Column3.Width  = 80     && Conta
            loc_oGrid.Column4.Width  = 80     && Contrapartida
            loc_oGrid.Column5.Width  = 225    && Historico
            loc_oGrid.Column6.Width  = 100    && Debito
            loc_oGrid.Column7.Width  = 100    && Credito
            loc_oGrid.Column8.Width  = 20     && [blank/Concs]
            loc_oGrid.Column9.Width  = 20     && [space/Autos]
            loc_oGrid.Column10.Width = 80     && NF
            loc_oGrid.Column11.Width = 80     && Documento

            *-- Alinhamento
            loc_oGrid.Column6.Alignment = 1   && Right para Debito
            loc_oGrid.Column7.Alignment = 1   && Right para Credito

            *-- Headers (APOS RecordSource e ControlSource - OBRIGATORIO)
            loc_oGrid.Column1.Header1.Caption  = "Data"
            loc_oGrid.Column2.Header1.Caption  = "O"
            loc_oGrid.Column3.Header1.Caption  = "Conta"
            loc_oGrid.Column4.Header1.Caption  = "Contrapartida"
            loc_oGrid.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
            loc_oGrid.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
            loc_oGrid.Column7.Header1.Caption  = "Cr" + CHR(233) + "dito"
            loc_oGrid.Column8.Header1.Caption  = ""
            loc_oGrid.Column9.Header1.Caption  = ""
            loc_oGrid.Column10.Header1.Caption = "NF"
            loc_oGrid.Column11.Header1.Caption = "Documento"

            *--------------------------------------------------------------------
            * BINDEVENTs para botoes
            *--------------------------------------------------------------------
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
            BINDEVENT(loc_oPagina.cmd_4c_Movimento,                 "Click", THIS, "BtnMovimentoClick")

            *-- BINDEVENTs para filtro de periodo
            BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtInicial, "LostFocus", THIS, "FiltroDataInicialLostFocus")
            BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtFinal,   "LostFocus", THIS, "FiltroDataFinalLostFocus")

            *-- Duplo clique no grid = Visualizar
            BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PAGE2 - DADOS/EDICAO
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 com todos os campos do legado
    * Posicoes da layout.json + 29 (compensacao PageFrame Top=-29, Tabs=.F.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *--------------------------------------------------------------------
            * Container botoes Confirmar/Cancelar (cabecalho direito - Top=29)
            *--------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .Top         = 29
                .Left        = 842
                .Width       = 160
                .Height      = 85
                .BackStyle   = 1
                .BackColor   = RGB(53, 53, 53)
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
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontSize        = 8
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Cancelar", "CommandButton")
                WITH .cmd_4c_Cancelar
                    .Caption         = "Cancelar"
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
                    .FontSize        = 8
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            *--------------------------------------------------------------------
            * Shapes - separadores visuais (top legado + 29)
            * Shape1: Painel superior dados (top=153+29=182)
            *--------------------------------------------------------------------
            loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oPagina.shp_4c_Shape1
                .Top          = 182
                .Left         = 9
                .Width        = 980
                .Height       = 64
                .BackStyle    = 1
                .BackColor    = RGB(220, 220, 220)
                .FillStyle    = 0
                .FillColor    = RGB(220, 220, 220)
                .BorderStyle  = 1
                .SpecialEffect = 0
                .Visible      = .T.
            ENDWITH

            *-- Shape3: Painel movimento esquerdo (top=224+29=253)
            loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
            WITH loc_oPagina.shp_4c_Shape3
                .Top          = 253
                .Left         = 9
                .Width        = 485
                .Height       = 117
                .BackStyle    = 1
                .BackColor    = RGB(220, 220, 220)
                .FillStyle    = 0
                .FillColor    = RGB(220, 220, 220)
                .BorderStyle  = 1
                .SpecialEffect = 0
                .Visible      = .T.
            ENDWITH

            *-- Shape2: Painel movimento direito (top=224+29=253)
            loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
            WITH loc_oPagina.shp_4c_Shape2
                .Top          = 253
                .Left         = 504
                .Width        = 485
                .Height       = 117
                .BackStyle    = 1
                .BackColor    = RGB(220, 220, 220)
                .FillStyle    = 0
                .FillColor    = RGB(220, 220, 220)
                .BorderStyle  = 1
                .SpecialEffect = 0
                .Visible      = .T.
            ENDWITH

            *-- Shape6: Painel historico (top=350+29=379)
            loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
            WITH loc_oPagina.shp_4c_Shape6
                .Top          = 379
                .Left         = 9
                .Width        = 980
                .Height       = 39
                .BackStyle    = 1
                .BackColor    = RGB(220, 220, 220)
                .FillStyle    = 0
                .FillColor    = RGB(220, 220, 220)
                .BorderStyle  = 1
                .SpecialEffect = 0
                .Visible      = .T.
            ENDWITH

            *--------------------------------------------------------------------
            * Labels - Say objects (top legado + 29)
            *--------------------------------------------------------------------
            *-- Say1 "Lancamento :" (top=165+29=194, left=43)
            loc_oPagina.AddObject("lbl_4c_Lancamento", "Label")
            WITH loc_oPagina.lbl_4c_Lancamento
                .Caption  = "Lan" + CHR(231) + "amento :"
                .Top      = 194
                .Left     = 43
                .Width    = 75
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say10 "Vencimento :" (top=165+29=194, left=234)
            loc_oPagina.AddObject("lbl_4c_Vencimento", "Label")
            WITH loc_oPagina.lbl_4c_Vencimento
                .Caption  = "Vencimento :"
                .Top      = 194
                .Left     = 234
                .Width    = 70
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say15 "Emissao :" (top=165+29=194, left=435)
            loc_oPagina.AddObject("lbl_4c_Emissao", "Label")
            WITH loc_oPagina.lbl_4c_Emissao
                .Caption  = "Emiss" + CHR(227) + "o :"
                .Top      = 194
                .Left     = 435
                .Width    = 55
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say7 "Nota Fiscal :" (top=165+29=194, left=615)
            loc_oPagina.AddObject("lbl_4c_NotaFiscal", "Label")
            WITH loc_oPagina.lbl_4c_NotaFiscal
                .Caption  = "Nota Fiscal :"
                .Top      = 194
                .Left     = 615
                .Width    = 70
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say6 "Usuario :" (top=165+29=194, left=818)
            loc_oPagina.AddObject("lbl_4c_Usuario", "Label")
            WITH loc_oPagina.lbl_4c_Usuario
                .Caption  = "Usu" + CHR(225) + "rio :"
                .Top      = 194
                .Left     = 818
                .Width    = 55
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say17 "Job :" (top=191+29=220, left=84)
            loc_oPagina.AddObject("lbl_4c_Job", "Label")
            WITH loc_oPagina.lbl_4c_Job
                .Caption  = "Job :"
                .Top      = 220
                .Left     = 84
                .Width    = 30
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say2 "Documento :" (top=191+29=220, left=613)
            loc_oPagina.AddObject("lbl_4c_Documento", "Label")
            WITH loc_oPagina.lbl_4c_Documento
                .Caption  = "Documento :"
                .Top      = 220
                .Left     = 613
                .Width    = 65
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say3 "Movimento :" Esquerdo (top=235+29=264, left=49)
            loc_oPagina.AddObject("lbl_4c_MovEsq", "Label")
            WITH loc_oPagina.lbl_4c_MovEsq
                .Caption  = "Movimento :"
                .Top      = 264
                .Left     = 49
                .Width    = 70
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say18 "[D/C]" Esquerdo (top=235+29=264, left=130)
            loc_oPagina.AddObject("lbl_4c_DcEsq", "Label")
            WITH loc_oPagina.lbl_4c_DcEsq
                .Caption  = "[D/C]"
                .Top      = 264
                .Left     = 130
                .Width    = 30
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say11 "Movimento :" Direito (top=235+29=264, left=544)
            loc_oPagina.AddObject("lbl_4c_MovDir", "Label")
            WITH loc_oPagina.lbl_4c_MovDir
                .Caption  = "Movimento :"
                .Top      = 264
                .Left     = 544
                .Width    = 70
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say14 "[D/C]" Direito (top=235+29=264, left=626)
            loc_oPagina.AddObject("lbl_4c_DcDir", "Label")
            WITH loc_oPagina.lbl_4c_DcDir
                .Caption  = "[D/C]"
                .Top      = 264
                .Left     = 626
                .Width    = 30
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say4 "Grupo :" Esquerdo (top=261+29=290, left=72)
            loc_oPagina.AddObject("lbl_4c_GrupoEsq", "Label")
            WITH loc_oPagina.lbl_4c_GrupoEsq
                .Caption  = "Grupo :"
                .Top      = 290
                .Left     = 72
                .Width    = 40
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say12 "Grupo :" Direito (top=261+29=290, left=567)
            loc_oPagina.AddObject("lbl_4c_GrupoDir", "Label")
            WITH loc_oPagina.lbl_4c_GrupoDir
                .Caption  = "Grupo :"
                .Top      = 290
                .Left     = 567
                .Width    = 40
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say5 "Conta :" Esquerdo (top=287+29=316, left=72)
            loc_oPagina.AddObject("lbl_4c_ContaEsq", "Label")
            WITH loc_oPagina.lbl_4c_ContaEsq
                .Caption  = "Conta :"
                .Top      = 316
                .Left     = 72
                .Width    = 40
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say13 "Conta :" Direito (top=287+29=316, left=567)
            loc_oPagina.AddObject("lbl_4c_ContaDir", "Label")
            WITH loc_oPagina.lbl_4c_ContaDir
                .Caption  = "Conta :"
                .Top      = 316
                .Left     = 567
                .Width    = 40
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say8 "Valor :" Esquerdo (top=313+29=342, left=77)
            loc_oPagina.AddObject("lbl_4c_ValorEsq", "Label")
            WITH loc_oPagina.lbl_4c_ValorEsq
                .Caption  = "Valor :"
                .Top      = 342
                .Left     = 77
                .Width    = 35
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say16 "Valor :" Direito (top=313+29=342, left=572)
            loc_oPagina.AddObject("lbl_4c_ValorDir", "Label")
            WITH loc_oPagina.lbl_4c_ValorDir
                .Caption  = "Valor :"
                .Top      = 342
                .Left     = 572
                .Width    = 35
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say_Cotacao "Cambio :" Esquerdo (top=313+29=342, left=303)
            loc_oPagina.AddObject("lbl_4c_CotacaoEsq", "Label")
            WITH loc_oPagina.lbl_4c_CotacaoEsq
                .Caption  = "C" + CHR(226) + "mbio :"
                .Top      = 342
                .Left     = 303
                .Width    = 50
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say_sCotacao "Cambio :" Direito (top=313+29=342, left=797)
            loc_oPagina.AddObject("lbl_4c_CotacaoDir", "Label")
            WITH loc_oPagina.lbl_4c_CotacaoDir
                .Caption  = "C" + CHR(226) + "mbio :"
                .Top      = 342
                .Left     = 797
                .Width    = 50
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say9 "Historico :" (top=362+29=391, left=60)
            loc_oPagina.AddObject("lbl_4c_Historico", "Label")
            WITH loc_oPagina.lbl_4c_Historico
                .Caption  = "Hist" + CHR(243) + "rico :"
                .Top      = 391
                .Left     = 60
                .Width    = 55
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *-- Say19 "Lancar Contas :" (top=362+29=391, left=758)
            loc_oPagina.AddObject("lbl_4c_LancarContas", "Label")
            WITH loc_oPagina.lbl_4c_LancarContas
                .Caption  = "Lan" + CHR(231) + "ar Contas :"
                .Top      = 391
                .Left     = 758
                .Width    = 85
                .Height   = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible  = .T.
            ENDWITH

            *--------------------------------------------------------------------
            * Campos de data (top legado + 29)
            *--------------------------------------------------------------------
            *-- fweditdata_DATA "Lancamento" (top=161+29=190, left=112, width=80)
            loc_oPagina.AddObject("txt_4c_Data", "TextBox")
            WITH loc_oPagina.txt_4c_Data
                .Top      = 190
                .Left     = 112
                .Width    = 80
                .Height   = 21
                .Value    = {}
                .Format   = "D"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- fweditdata_VENC "Vencimento" (top=161+29=190, left=300, width=80)
            loc_oPagina.AddObject("txt_4c_Venc", "TextBox")
            WITH loc_oPagina.txt_4c_Venc
                .Top      = 190
                .Left     = 300
                .Width    = 80
                .Height   = 21
                .Value    = {}
                .Format   = "D"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- getDtEmis "Emissao" (top=161+29=190, left=484, width=80)
            loc_oPagina.AddObject("txt_4c_Emis", "TextBox")
            WITH loc_oPagina.txt_4c_Emis
                .Top      = 190
                .Left     = 484
                .Width    = 80
                .Height   = 21
                .Value    = {}
                .Format   = "D"
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *--------------------------------------------------------------------
            * Campos textuais (top legado + 29)
            *--------------------------------------------------------------------
            *-- Get_Nota "Nota Fiscal" (top=161+29=190, left=678, width=80)
            loc_oPagina.AddObject("txt_4c_Nota", "TextBox")
            WITH loc_oPagina.txt_4c_Nota
                .Top      = 190
                .Left     = 678
                .Width    = 80
                .Height   = 21
                .Value    = SPACE(10)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- get_Usuario "Usuario" (top=161+29=190, left=865, width=80) - somente leitura
            loc_oPagina.AddObject("txt_4c_Usuario", "TextBox")
            WITH loc_oPagina.txt_4c_Usuario
                .Top      = 190
                .Left     = 865
                .Width    = 80
                .Height   = 21
                .Value    = SPACE(10)
                .ReadOnly = .T.
                .BackColor = RGB(224, 224, 224)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- getJob "Job" (top=187+29=216, left=112, width=80)
            loc_oPagina.AddObject("txt_4c_Job", "TextBox")
            WITH loc_oPagina.txt_4c_Job
                .Top      = 216
                .Left     = 112
                .Width    = 80
                .Height   = 23
                .Value    = SPACE(10)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- getDJob "Descricao Job" (top=187+29=216, left=195, width=290) - somente leitura
            loc_oPagina.AddObject("txt_4c_DJob", "TextBox")
            WITH loc_oPagina.txt_4c_DJob
                .Top      = 216
                .Left     = 195
                .Width    = 290
                .Height   = 23
                .Value    = SPACE(40)
                .ReadOnly = .T.
                .BackColor = RGB(224, 224, 224)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_DOCU "Documento" (top=187+29=216, left=678, width=80)
            loc_oPagina.AddObject("txt_4c_Docu", "TextBox")
            WITH loc_oPagina.txt_4c_Docu
                .Top      = 216
                .Left     = 678
                .Width    = 80
                .Height   = 21
                .Value    = SPACE(10)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *--------------------------------------------------------------------
            * Painel esquerdo (Movimento Debito)
            *--------------------------------------------------------------------
            *-- Get_OPER D/C esquerdo (top=231+29=260, left=112, width=15)
            loc_oPagina.AddObject("txt_4c_Oper", "TextBox")
            WITH loc_oPagina.txt_4c_Oper
                .Top      = 260
                .Left     = 112
                .Width    = 15
                .Height   = 21
                .Value    = SPACE(1)
                .MaxLength = 1
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_grupo esquerdo (top=257+29=286, left=112, width=80)
            loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
            WITH loc_oPagina.txt_4c_Grupo
                .Top      = 286
                .Left     = 112
                .Width    = 80
                .Height   = 23
                .Value    = SPACE(10)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_dgrupo desc. Grupo esquerdo (top=257+29=286, left=195, width=290) - RO
            loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
            WITH loc_oPagina.txt_4c_DGrupo
                .Top      = 286
                .Left     = 195
                .Width    = 290
                .Height   = 23
                .Value    = SPACE(40)
                .ReadOnly = .T.
                .BackColor = RGB(224, 224, 224)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_conta esquerdo (top=283+29=312, left=112, width=80)
            loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
            WITH loc_oPagina.txt_4c_Conta
                .Top      = 312
                .Left     = 112
                .Width    = 80
                .Height   = 21
                .Value    = SPACE(10)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_dconta desc. Conta esquerdo (top=283+29=312, left=195, width=290) - RO
            loc_oPagina.AddObject("txt_4c_DcConta", "TextBox")
            WITH loc_oPagina.txt_4c_DcConta
                .Top      = 312
                .Left     = 195
                .Width    = 290
                .Height   = 21
                .Value    = SPACE(40)
                .ReadOnly = .T.
                .BackColor = RGB(224, 224, 224)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_VALOR esquerdo (top=309+29=338, left=112, width=128)
            loc_oPagina.AddObject("txt_4c_Valor", "TextBox")
            WITH loc_oPagina.txt_4c_Valor
                .Top      = 338
                .Left     = 112
                .Width    = 128
                .Height   = 23
                .Value    = 0.00
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_MOEDA esquerdo (top=309+29=338, left=243, width=31)
            loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
            WITH loc_oPagina.txt_4c_Moeda
                .Top      = 338
                .Left     = 243
                .Width    = 31
                .Height   = 21
                .Value    = SPACE(3)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_COTACAO esquerdo (top=309+29=338, left=349, width=108)
            loc_oPagina.AddObject("txt_4c_Cotacao", "TextBox")
            WITH loc_oPagina.txt_4c_Cotacao
                .Top      = 338
                .Left     = 349
                .Width    = 108
                .Height   = 21
                .Value    = 0.0000000
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- alteracotacao "$" esquerdo (top=309+29=338, left=461, width=24)
            loc_oPagina.AddObject("cmd_4c_AlteraCotacao", "CommandButton")
            WITH loc_oPagina.cmd_4c_AlteraCotacao
                .Caption       = "$"
                .Top           = 338
                .Left          = 461
                .Width         = 24
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(192, 192, 192)
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH

            *--------------------------------------------------------------------
            * Painel direito (Movimento Credito)
            *--------------------------------------------------------------------
            *-- Get_SOPER D/C direito (top=231+29=260, left=607, width=15)
            loc_oPagina.AddObject("txt_4c_SOper", "TextBox")
            WITH loc_oPagina.txt_4c_SOper
                .Top      = 260
                .Left     = 607
                .Width    = 15
                .Height   = 21
                .Value    = SPACE(1)
                .MaxLength = 1
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_SGRUPO direito (top=257+29=286, left=607, width=80)
            loc_oPagina.AddObject("txt_4c_SGrupo", "TextBox")
            WITH loc_oPagina.txt_4c_SGrupo
                .Top      = 286
                .Left     = 607
                .Width    = 80
                .Height   = 23
                .Value    = SPACE(10)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_sdgrupo desc. Grupo direito (top=257+29=286, left=689, width=290) - RO
            loc_oPagina.AddObject("txt_4c_SDGrupo", "TextBox")
            WITH loc_oPagina.txt_4c_SDGrupo
                .Top      = 286
                .Left     = 689
                .Width    = 290
                .Height   = 23
                .Value    = SPACE(40)
                .ReadOnly = .T.
                .BackColor = RGB(224, 224, 224)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_SCONTA direito (top=283+29=312, left=607, width=80)
            loc_oPagina.AddObject("txt_4c_SConta", "TextBox")
            WITH loc_oPagina.txt_4c_SConta
                .Top      = 312
                .Left     = 607
                .Width    = 80
                .Height   = 21
                .Value    = SPACE(10)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_SDCONTA desc. Conta direito (top=283+29=312, left=689, width=290) - RO
            loc_oPagina.AddObject("txt_4c_SDcConta", "TextBox")
            WITH loc_oPagina.txt_4c_SDcConta
                .Top      = 312
                .Left     = 689
                .Width    = 290
                .Height   = 21
                .Value    = SPACE(40)
                .ReadOnly = .T.
                .BackColor = RGB(224, 224, 224)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_SVALOR direito (top=309+29=338, left=607, width=128)
            loc_oPagina.AddObject("txt_4c_SValor", "TextBox")
            WITH loc_oPagina.txt_4c_SValor
                .Top      = 338
                .Left     = 607
                .Width    = 128
                .Height   = 23
                .Value    = 0.00
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_smoeda direito (top=309+29=338, left=737, width=31)
            loc_oPagina.AddObject("txt_4c_SMoeda", "TextBox")
            WITH loc_oPagina.txt_4c_SMoeda
                .Top      = 338
                .Left     = 737
                .Width    = 31
                .Height   = 21
                .Value    = SPACE(3)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_SCOTACAO direito (top=309+29=338, left=843, width=108)
            loc_oPagina.AddObject("txt_4c_SCotacao", "TextBox")
            WITH loc_oPagina.txt_4c_SCotacao
                .Top      = 338
                .Left     = 843
                .Width    = 108
                .Height   = 21
                .Value    = 0.0000000
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- alterascotacao "$" direito (top=309+29=338, left=955, width=24)
            loc_oPagina.AddObject("cmd_4c_AlteraSCotacao", "CommandButton")
            WITH loc_oPagina.cmd_4c_AlteraSCotacao
                .Caption       = "$"
                .Top           = 338
                .Left          = 955
                .Width         = 24
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(192, 192, 192)
                .ForeColor     = RGB(0, 0, 0)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH

            *--------------------------------------------------------------------
            * Historico e Opcao
            *--------------------------------------------------------------------
            *-- Get_HIST "Historico" (top=358+29=387, left=112, width=300)
            loc_oPagina.AddObject("txt_4c_Hist", "TextBox")
            WITH loc_oPagina.txt_4c_Hist
                .Top      = 387
                .Left     = 112
                .Width    = 300
                .Height   = 21
                .Value    = SPACE(60)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Get_Hist2 "Historico 2" (top=358+29=387, left=415, width=300)
            loc_oPagina.AddObject("txt_4c_Hist2", "TextBox")
            WITH loc_oPagina.txt_4c_Hist2
                .Top      = 387
                .Left     = 415
                .Width    = 300
                .Height   = 21
                .Value    = SPACE(60)
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Opcao_conta "Lancar Contas" (top=356+29=385, left=844, width=99, height=27)
            loc_oPagina.AddObject("opt_4c_OpcaoConta", "OptionGroup")
            WITH loc_oPagina.opt_4c_OpcaoConta
                .Top         = 385
                .Left        = 844
                .Width       = 99
                .Height      = 27
                .ButtonCount = 2
                .BorderStyle = 0
                .Themes      = .F.
                .Value       = 1
                .Visible     = .T.
                WITH .Buttons(1)
                    .Caption   = "Sim"
                    .Left      = 2
                    .Top       = 3
                    .Width     = 47
                    .Height    = 21
                    .AutoSize  = .F.
                    .ForeColor = RGB(0, 0, 0)
                    .Themes    = .F.
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N" + CHR(227) + "o"
                    .Left      = 51
                    .Top       = 3
                    .Width     = 46
                    .Height    = 21
                    .AutoSize  = .F.
                    .ForeColor = RGB(0, 0, 0)
                    .Themes    = .F.
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *--------------------------------------------------------------------
            * BINDEVENTs Page2
            *--------------------------------------------------------------------
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
            BINDEVENT(loc_oPagina.cmd_4c_AlteraCotacao,                "Click", THIS, "BtnAlteraCotacaoClick")
            BINDEVENT(loc_oPagina.cmd_4c_AlteraSCotacao,               "Click", THIS, "BtnAlteraSCotacaoClick")

            *-- Lookups LostFocus (valida codigo ao sair do campo)
            BINDEVENT(loc_oPagina.txt_4c_Grupo,   "LostFocus", THIS, "GrupoLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_Conta,   "LostFocus", THIS, "ContaLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_Moeda,   "LostFocus", THIS, "MoedaLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_SGrupo,  "LostFocus", THIS, "SGrupoLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_SConta,  "LostFocus", THIS, "SContaLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_SMoeda,  "LostFocus", THIS, "SMoedaLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_Valor,   "LostFocus", THIS, "ValorLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_Cotacao, "LostFocus", THIS, "CotacaoLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_SValor,  "LostFocus", THIS, "SValorLostFocus")

            *-- Job LostFocus + KeyPress
            BINDEVENT(loc_oPagina.txt_4c_Job,    "LostFocus", THIS, "JobLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_Job,    "KeyPress",  THIS, "JobKeyPress")

            *-- F4 KeyPress para abrir lookup (handler com LPARAMETERS obrigatorio)
            BINDEVENT(loc_oPagina.txt_4c_Grupo,  "KeyPress", THIS, "GrupoKeyPress")
            BINDEVENT(loc_oPagina.txt_4c_Conta,  "KeyPress", THIS, "ContaKeyPress")
            BINDEVENT(loc_oPagina.txt_4c_Moeda,  "KeyPress", THIS, "MoedaKeyPress")
            BINDEVENT(loc_oPagina.txt_4c_SGrupo, "KeyPress", THIS, "SGrupoKeyPress")
            BINDEVENT(loc_oPagina.txt_4c_SConta, "KeyPress", THIS, "SContaKeyPress")
            BINDEVENT(loc_oPagina.txt_4c_SMoeda, "KeyPress", THIS, "SMoedaKeyPress")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CARGA DE DADOS E NAVEGACAO
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega movimentos no grid via cursor_4c_Grade (ZAP+APPEND)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid, loc_dInicio, loc_dFim
        LOCAL loc_cSQL, loc_cWhere, loc_nResult
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oGrid   = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                loc_dInicio = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtInicial.Value
                loc_dFim    = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_DtFinal.Value

                loc_cWhere = " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

                IF !EMPTY(loc_dInicio) AND !EMPTY(loc_dFim)
                    loc_cWhere = loc_cWhere + ;
                        " AND a.Datas >= " + FormatarDataSQL(loc_dInicio) + ;
                        " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(loc_dFim) + ")"
                ENDIF

                loc_cSQL = "SELECT a.Datas, a.Opers, a.Contas, a.Scontas," + ;
                           " a.Hists, a.Valors, a.Svalors, a.Concs, a.Autos," + ;
                           " a.Nfs, a.Docus, a.Nopers, a.Cidchaves" + ;
                           " FROM SigMvCcr a" + ;
                           loc_cWhere + ;
                           " ORDER BY a.Datas, a.Nopers"

                IF USED("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")

                IF loc_nResult < 0
                    MsgErro("Erro ao carregar movimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    *-- ZAP + APPEND: preserva colunas do grid (nao destroi cursor_4c_Grade)
                    ZAP IN cursor_4c_Grade
                    SELECT cursor_4c_Grade
                    APPEND FROM DBF("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp

                    IF USED("cursor_4c_Grade")
                        GO TOP IN cursor_4c_Grade
                    ENDIF

                    *-- Reconfigurar headers (seguranca apos operacoes no cursor)
                    loc_oGrid.Column1.Header1.Caption  = "Data"
                    loc_oGrid.Column2.Header1.Caption  = "O"
                    loc_oGrid.Column3.Header1.Caption  = "Conta"
                    loc_oGrid.Column4.Header1.Caption  = "Contrapartida"
                    loc_oGrid.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
                    loc_oGrid.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
                    loc_oGrid.Column7.Header1.Caption  = "Cr" + CHR(233) + "dito"
                    loc_oGrid.Column8.Header1.Caption  = ""
                    loc_oGrid.Column9.Header1.Caption  = ""
                    loc_oGrid.Column10.Header1.Caption = "NF"
                    loc_oGrid.Column11.Header1.Caption = "Documento"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgErro("Pagina invalida: " + TRANSFORM(par_nPagina), "AlternarPagina")
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BOTOES PAGE1 - CRUD
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave
        TRY
            IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade") OR BOF("cursor_4c_Grade")
                MsgAviso("Nenhum registro selecionado.", "Visualizar")
            ELSE
                SELECT cursor_4c_Grade
                loc_cChave = ALLTRIM(cursor_4c_Grade.Cidchaves)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                ELSE
                    MsgErro("Registro nao encontrado.", "Visualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave
        TRY
            IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade") OR BOF("cursor_4c_Grade")
                MsgAviso("Nenhum registro selecionado.", "Alterar")
            ELSE
                SELECT cursor_4c_Grade
                loc_cChave = ALLTRIM(cursor_4c_Grade.Cidchaves)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                ELSE
                    MsgErro("Registro nao encontrado.", "Alterar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave, loc_lConfirmou
        TRY
            IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade") OR BOF("cursor_4c_Grade")
                MsgAviso("Nenhum registro selecionado.", "Excluir")
            ELSE
                SELECT cursor_4c_Grade
                loc_cChave = ALLTRIM(cursor_4c_Grade.Cidchaves)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    loc_lConfirmou = MsgConfirma( ;
                        "Confirma a exclus" + CHR(227) + "o do movimento " + loc_cChave + "?", ;
                        "Excluir")

                    IF loc_lConfirmou
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgSucesso("Movimento exclu" + CHR(237) + "do com sucesso!")
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                ELSE
                    MsgErro("Registro nao encontrado.", "Excluir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarregar lista com filtro atual
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMovimentoClick - Abrir detalhe de movimento do registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnMovimentoClick()
        LOCAL loc_cChave
        TRY
            IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade") OR BOF("cursor_4c_Grade")
                MsgAviso("Selecione um registro para ver o movimento.", "Movimento")
            ELSE
                SELECT cursor_4c_Grade
                loc_cChave = ALLTRIM(cursor_4c_Grade.Cidchaves)

                IF EMPTY(loc_cChave)
                    MsgAviso("Registro sem chave de opera" + CHR(231) + CHR(227) + "o.", "Movimento")
                ELSE
                    THIS.this_cModoAtual = "VISUALIZAR"
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                        THIS.BOParaForm()
                        THIS.pgf_4c_Paginas.ActivePage = 2
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnMovimentoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOTOES PAGE2 - SALVAR / CANCELAR
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirmar inclusao ou alteracao
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSalvou, loc_oPagina
        loc_lSalvou = .F.
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Validacoes antes de salvar (equivalente ao legado Salva.Click)
            IF EMPTY(loc_oPagina.txt_4c_Data.Value)
                MsgAviso("Data inv" + CHR(225) + "lida.", "Salvar")
                loc_oPagina.txt_4c_Data.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_Oper.Value) OR ;
               !INLIST(UPPER(ALLTRIM(loc_oPagina.txt_4c_Oper.Value)), "D", "C")
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida! Use D ou C.", "Salvar")
                loc_oPagina.txt_4c_Oper.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_Grupo.Value)
                MsgAviso("Grupo inv" + CHR(225) + "lido.", "Salvar")
                loc_oPagina.txt_4c_Grupo.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_Conta.Value)
                MsgAviso("Conta inv" + CHR(225) + "lida.", "Salvar")
                loc_oPagina.txt_4c_Conta.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_Moeda.Value)
                MsgAviso("Moeda inv" + CHR(225) + "lida.", "Salvar")
                loc_oPagina.txt_4c_Moeda.SetFocus
                RETURN
            ENDIF

            IF loc_oPagina.txt_4c_Valor.Value = 0
                MsgAviso("Valor inv" + CHR(225) + "lido.", "Salvar")
                loc_oPagina.txt_4c_Valor.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_SOper.Value) OR ;
               !INLIST(UPPER(ALLTRIM(loc_oPagina.txt_4c_SOper.Value)), "D", "C")
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o de contrapartida inv" + CHR(225) + "lida! Use D ou C.", "Salvar")
                loc_oPagina.txt_4c_SOper.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_SGrupo.Value)
                MsgAviso("Grupo de contrapartida inv" + CHR(225) + "lido.", "Salvar")
                loc_oPagina.txt_4c_SGrupo.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_SConta.Value)
                MsgAviso("Conta de contrapartida inv" + CHR(225) + "lida.", "Salvar")
                loc_oPagina.txt_4c_SConta.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_oPagina.txt_4c_SMoeda.Value)
                MsgAviso("Moeda de contrapartida inv" + CHR(225) + "lida.", "Salvar")
                loc_oPagina.txt_4c_SMoeda.SetFocus
                RETURN
            ENDIF

            IF loc_oPagina.txt_4c_SValor.Value = 0
                MsgAviso("Valor de contrapartida inv" + CHR(225) + "lido.", "Salvar")
                loc_oPagina.txt_4c_SValor.SetFocus
                RETURN
            ENDIF

            *-- Vencimento obrigatorio se Contapgs = Sim (Value = 1)
            IF loc_oPagina.opt_4c_OpcaoConta.Value = 1
                IF EMPTY(loc_oPagina.txt_4c_Venc.Value)
                    MsgAviso("Vencimento obrigat" + CHR(243) + "rio para contas a pagar.", "Salvar")
                    loc_oPagina.txt_4c_Venc.SetFocus
                    RETURN
                ENDIF
                IF loc_oPagina.txt_4c_Venc.Value < loc_oPagina.txt_4c_Data.Value
                    MsgAviso("Vencimento n" + CHR(227) + "o pode ser menor que a data de lan" + CHR(231) + "amento.", "Salvar")
                    loc_oPagina.txt_4c_Venc.SetFocus
                    RETURN
                ENDIF
            ENDIF

            *-- Mesma moeda: cotacoes devem ser iguais
            IF ALLTRIM(loc_oPagina.txt_4c_Moeda.Value) = ALLTRIM(loc_oPagina.txt_4c_SMoeda.Value)
                IF loc_oPagina.txt_4c_Cotacao.Value <> loc_oPagina.txt_4c_SCotacao.Value
                    MsgAviso("Cota" + CHR(231) + CHR(227) + "o inconsistente para mesma moeda!", "Salvar")
                    loc_oPagina.txt_4c_Moeda.SetFocus
                    RETURN
                ENDIF
            ENDIF

            *-- Lancamento para a mesma conta e grupo: invalido
            IF ALLTRIM(loc_oPagina.txt_4c_Grupo.Value) + ALLTRIM(loc_oPagina.txt_4c_Conta.Value) + ;
               ALLTRIM(loc_oPagina.txt_4c_Moeda.Value) = ;
               ALLTRIM(loc_oPagina.txt_4c_SGrupo.Value) + ALLTRIM(loc_oPagina.txt_4c_SConta.Value) + ;
               ALLTRIM(loc_oPagina.txt_4c_SMoeda.Value)
                MsgAviso("Lan" + CHR(231) + "amento inconsistente! Grupos+Contas+Moedas iguais.", "Salvar")
                loc_oPagina.txt_4c_Moeda.SetFocus
                RETURN
            ENDIF

            IF THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    loc_lSalvou = .T.
                    MsgSucesso("Registro salvo com sucesso!")
                    THIS.AlternarPagina(1)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar edicao e retornar a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_oBusinessObject.CancelarEdicao()
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * DADOS - FormParaBO / BOParaForm
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - Le campos da Page2 e preenche propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_oPagina, loc_oBO
        loc_lSucesso = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oBO     = THIS.this_oBusinessObject

            loc_oBO.this_dDatas     = loc_oPagina.txt_4c_Data.Value
            loc_oBO.this_dVencs     = loc_oPagina.txt_4c_Venc.Value
            loc_oBO.this_dDtemis    = loc_oPagina.txt_4c_Emis.Value
            loc_oBO.this_cNfs       = ALLTRIM(loc_oPagina.txt_4c_Nota.Value)
            loc_oBO.this_cDocus     = ALLTRIM(loc_oPagina.txt_4c_Docu.Value)
            loc_oBO.this_cJobs      = ALLTRIM(loc_oPagina.txt_4c_Job.Value)
            loc_oBO.this_cOpers     = ALLTRIM(loc_oPagina.txt_4c_Oper.Value)
            loc_oBO.this_cGrupos    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
            loc_oBO.this_cContas    = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
            loc_oBO.this_cMoedas    = ALLTRIM(loc_oPagina.txt_4c_Moeda.Value)
            loc_oBO.this_nValors    = loc_oPagina.txt_4c_Valor.Value
            loc_oBO.this_nCotacaos  = loc_oPagina.txt_4c_Cotacao.Value
            loc_oBO.this_cSopers    = ALLTRIM(loc_oPagina.txt_4c_SOper.Value)
            loc_oBO.this_cSgrupos   = ALLTRIM(loc_oPagina.txt_4c_SGrupo.Value)
            loc_oBO.this_cScontas   = ALLTRIM(loc_oPagina.txt_4c_SConta.Value)
            loc_oBO.this_cSmoedas   = ALLTRIM(loc_oPagina.txt_4c_SMoeda.Value)
            loc_oBO.this_nSvalors   = loc_oPagina.txt_4c_SValor.Value
            loc_oBO.this_nScotacaos = loc_oPagina.txt_4c_SCotacao.Value
            loc_oBO.this_cHists     = ALLTRIM(loc_oPagina.txt_4c_Hist.Value)
            loc_oBO.this_cHist2s    = ALLTRIM(loc_oPagina.txt_4c_Hist2.Value)

            *-- OptionGroup: Value 1=Sim(contapgs=1), Value 2=Nao(contapgs=0)
            loc_oBO.this_nContapgs = IIF(loc_oPagina.opt_4c_OpcaoConta.Value = 1, 1, 0)

            *-- Empresa e usuario logado
            loc_oBO.this_cEmps    = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_oBO.this_cUsualts = ALLTRIM(gc_4c_UsuarioLogado)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Preenche campos da Page2 com propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_oPagina, loc_oBO
        loc_lSucesso = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oBO     = THIS.this_oBusinessObject

            loc_oPagina.txt_4c_Data.Value    = loc_oBO.this_dDatas
            loc_oPagina.txt_4c_Venc.Value    = loc_oBO.this_dVencs
            loc_oPagina.txt_4c_Emis.Value    = loc_oBO.this_dDtemis
            loc_oPagina.txt_4c_Nota.Value    = PADR(ALLTRIM(loc_oBO.this_cNfs), 10)
            loc_oPagina.txt_4c_Docu.Value    = PADR(ALLTRIM(loc_oBO.this_cDocus), 10)
            loc_oPagina.txt_4c_Job.Value     = PADR(ALLTRIM(loc_oBO.this_cJobs), 10)
            loc_oPagina.txt_4c_Oper.Value    = PADR(ALLTRIM(loc_oBO.this_cOpers), 1)
            loc_oPagina.txt_4c_Grupo.Value   = PADR(ALLTRIM(loc_oBO.this_cGrupos), 10)
            loc_oPagina.txt_4c_Conta.Value   = PADR(ALLTRIM(loc_oBO.this_cContas), 10)
            loc_oPagina.txt_4c_Moeda.Value   = PADR(ALLTRIM(loc_oBO.this_cMoedas), 3)
            loc_oPagina.txt_4c_Valor.Value   = loc_oBO.this_nValors
            loc_oPagina.txt_4c_Cotacao.Value = loc_oBO.this_nCotacaos
            loc_oPagina.txt_4c_SOper.Value   = PADR(ALLTRIM(loc_oBO.this_cSopers), 1)
            loc_oPagina.txt_4c_SGrupo.Value  = PADR(ALLTRIM(loc_oBO.this_cSgrupos), 10)
            loc_oPagina.txt_4c_SConta.Value  = PADR(ALLTRIM(loc_oBO.this_cScontas), 10)
            loc_oPagina.txt_4c_SMoeda.Value  = PADR(ALLTRIM(loc_oBO.this_cSmoedas), 3)
            loc_oPagina.txt_4c_SValor.Value  = loc_oBO.this_nSvalors
            loc_oPagina.txt_4c_SCotacao.Value = loc_oBO.this_nScotacaos
            loc_oPagina.txt_4c_Hist.Value    = PADR(ALLTRIM(loc_oBO.this_cHists), 60)
            loc_oPagina.txt_4c_Hist2.Value   = PADR(ALLTRIM(loc_oBO.this_cHist2s), 60)
            loc_oPagina.txt_4c_Usuario.Value = PADR(ALLTRIM(loc_oBO.this_cUsualts), 10)

            *-- OptionGroup: contapgs >= 1 = Sim, 0 = Nao
            loc_oPagina.opt_4c_OpcaoConta.Value = IIF(loc_oBO.this_nContapgs >= 1, 1, 2)

            *-- Carregar descricoes dos codigos (grupo, conta)
            THIS.CarregarDescricoesGruposConta(loc_oBO)

            *-- Habilitar/desabilitar campos conforme modo
            THIS.HabilitarCamposDados(THIS.this_cModoAtual != "VISUALIZAR")

            *-- Ajustar botoes conforme modo
            THIS.AjustarBotoesPorModo()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescricoesGruposConta - Busca descricoes de codigos no banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescricoesGruposConta(par_oBO)
        LOCAL loc_oPagina, loc_nRes, loc_cCod

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Descricao Grupo esquerdo (SigCdGcr.codigos/descrs)
            loc_cCod = ALLTRIM(par_oBO.this_cGrupos)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpDesc")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
                    SELECT cursor_4c_TmpDesc
                    loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
                ENDIF
                IF USED("cursor_4c_TmpDesc")
                    USE IN cursor_4c_TmpDesc
                ENDIF
            ELSE
                loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
            ENDIF

            *-- Descricao Conta esquerdo (SigCdCli: Iclis=codigo, Rclis=nome)
            loc_cCod = ALLTRIM(par_oBO.this_cContas)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpDesc")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
                    SELECT cursor_4c_TmpDesc
                    loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
                ENDIF
                IF USED("cursor_4c_TmpDesc")
                    USE IN cursor_4c_TmpDesc
                ENDIF
            ELSE
                loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
            ENDIF

            *-- Descricao Grupo direito
            loc_cCod = ALLTRIM(par_oBO.this_cSgrupos)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpDesc")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
                    SELECT cursor_4c_TmpDesc
                    loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
                ENDIF
                IF USED("cursor_4c_TmpDesc")
                    USE IN cursor_4c_TmpDesc
                ENDIF
            ELSE
                loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
            ENDIF

            *-- Descricao Conta direito (SigCdCli: Iclis=codigo, Rclis=nome)
            loc_cCod = ALLTRIM(par_oBO.this_cScontas)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpDesc")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
                    SELECT cursor_4c_TmpDesc
                    loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
                ENDIF
                IF USED("cursor_4c_TmpDesc")
                    USE IN cursor_4c_TmpDesc
                ENDIF
            ELSE
                loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
            ENDIF

            *-- Descricao Job (SigCdCli: Iclis=codigo, Rclis=nome - mesmo que Conta)
            loc_cCod = ALLTRIM(par_oBO.this_cJobs)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpDesc")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpDesc") > 0
                    SELECT cursor_4c_TmpDesc
                    loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_DJob.Value = SPACE(40)
                ENDIF
                IF USED("cursor_4c_TmpDesc")
                    USE IN cursor_4c_TmpDesc
                ENDIF
            ELSE
                loc_oPagina.txt_4c_DJob.Value = SPACE(40)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarDescricoesGruposConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCamposDados - Habilita ou desabilita campos de edicao da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCamposDados(par_lHabilitar)
        LOCAL loc_oPagina, loc_lRO

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_lRO     = !par_lHabilitar

            loc_oPagina.txt_4c_Data.ReadOnly     = loc_lRO
            loc_oPagina.txt_4c_Venc.ReadOnly     = loc_lRO
            loc_oPagina.txt_4c_Emis.ReadOnly     = loc_lRO
            loc_oPagina.txt_4c_Nota.ReadOnly     = loc_lRO
            loc_oPagina.txt_4c_Docu.ReadOnly     = loc_lRO
            loc_oPagina.txt_4c_Job.ReadOnly      = loc_lRO
            loc_oPagina.txt_4c_Oper.ReadOnly     = loc_lRO
            loc_oPagina.txt_4c_Grupo.ReadOnly    = loc_lRO
            loc_oPagina.txt_4c_Conta.ReadOnly    = loc_lRO
            loc_oPagina.txt_4c_Moeda.ReadOnly    = loc_lRO
            loc_oPagina.txt_4c_Valor.ReadOnly    = loc_lRO
            loc_oPagina.txt_4c_Cotacao.ReadOnly  = loc_lRO
            loc_oPagina.txt_4c_SOper.ReadOnly    = loc_lRO
            loc_oPagina.txt_4c_SGrupo.ReadOnly   = loc_lRO
            loc_oPagina.txt_4c_SConta.ReadOnly   = loc_lRO
            loc_oPagina.txt_4c_SMoeda.ReadOnly   = loc_lRO
            loc_oPagina.txt_4c_SValor.ReadOnly   = loc_lRO
            loc_oPagina.txt_4c_SCotacao.ReadOnly = loc_lRO
            loc_oPagina.txt_4c_Hist.ReadOnly     = loc_lRO
            loc_oPagina.txt_4c_Hist2.ReadOnly    = loc_lRO

            loc_oPagina.opt_4c_OpcaoConta.Enabled      = par_lHabilitar
            loc_oPagina.cmd_4c_AlteraCotacao.Enabled   = par_lHabilitar
            loc_oPagina.cmd_4c_AlteraSCotacao.Enabled  = par_lHabilitar
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCamposDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera todos os campos de edicao da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            loc_oPagina.txt_4c_Data.Value    = {}
            loc_oPagina.txt_4c_Venc.Value    = {}
            loc_oPagina.txt_4c_Emis.Value    = {}
            loc_oPagina.txt_4c_Nota.Value    = SPACE(10)
            loc_oPagina.txt_4c_Docu.Value    = SPACE(10)
            loc_oPagina.txt_4c_Job.Value     = SPACE(10)
            loc_oPagina.txt_4c_DJob.Value    = SPACE(40)
            loc_oPagina.txt_4c_Oper.Value    = SPACE(1)
            loc_oPagina.txt_4c_Grupo.Value   = SPACE(10)
            loc_oPagina.txt_4c_DGrupo.Value  = SPACE(40)
            loc_oPagina.txt_4c_Conta.Value   = SPACE(10)
            loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
            loc_oPagina.txt_4c_Moeda.Value   = SPACE(3)
            loc_oPagina.txt_4c_Valor.Value   = 0
            loc_oPagina.txt_4c_Cotacao.Value = 0
            loc_oPagina.txt_4c_SOper.Value   = SPACE(1)
            loc_oPagina.txt_4c_SGrupo.Value  = SPACE(10)
            loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
            loc_oPagina.txt_4c_SConta.Value  = SPACE(10)
            loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
            loc_oPagina.txt_4c_SMoeda.Value  = SPACE(3)
            loc_oPagina.txt_4c_SValor.Value  = 0
            loc_oPagina.txt_4c_SCotacao.Value = 0
            loc_oPagina.txt_4c_Hist.Value    = SPACE(60)
            loc_oPagina.txt_4c_Hist2.Value   = SPACE(60)
            loc_oPagina.txt_4c_Usuario.Value = SPACE(10)
            loc_oPagina.opt_4c_OpcaoConta.Value = 2  && Nao (default)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
    * Modos: INCLUIR (campos editaveis), ALTERAR (campos editaveis),
    *        VISUALIZAR (somente leitura), LISTA (na Page1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lEdicao, loc_oPagina
        TRY
            loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Confirmar: habilitado somente em INCLUIR ou ALTERAR
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao

            *-- Cancelar: sempre habilitado quando na Page2
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.

            *-- Botoes de cotacao: somente em edicao
            IF PEMSTATUS(loc_oPagina, "cmd_4c_AlteraCotacao", 5)
                loc_oPagina.cmd_4c_AlteraCotacao.Enabled  = loc_lEdicao
                loc_oPagina.cmd_4c_AlteraSCotacao.Enabled = loc_lEdicao
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LOOKUPS - GRUPO / CONTA / MOEDA (esquerdo e direito)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - Busca de Grupo financeiro em SigCdGcr (lado esquerdo)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_Busca", "codigos", loc_cValor, ;
                "Busca de Grupo Financeiro")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oPagina.txt_4c_Grupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
                        loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_oPagina.txt_4c_Grupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
                            loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSGrupo - Busca de Grupo financeiro em SigCdGcr (lado direito)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSGrupo()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_SGrupo.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_Busca", "codigos", loc_cValor, ;
                "Busca de Grupo Financeiro")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oPagina.txt_4c_SGrupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
                        loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_oPagina.txt_4c_SGrupo.Value  = PADR(ALLTRIM(cursor_4c_Busca.codigos), 10)
                            loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(cursor_4c_Busca.descrs), 40)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupSGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConta - Busca de Conta em SigCdCli (lado esquerdo)
    * Legado usa fAcessoContas que busca em SigCdCli (Iclis=PK, Rclis=nome)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupConta()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_Busca", "Iclis", loc_cValor, ;
                "Busca de Conta")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oPagina.txt_4c_Conta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
                        loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_oPagina.txt_4c_Conta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
                            loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSConta - Busca de Conta em SigCdCli (lado direito)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSConta()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_SConta.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_Busca", "Iclis", loc_cValor, ;
                "Busca de Conta")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oPagina.txt_4c_SConta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
                        loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_oPagina.txt_4c_SConta.Value   = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
                            loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupSConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoeda - Busca de Moeda em SigCdMoe (lado esquerdo)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Moeda.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_Busca", "cmoes", loc_cValor, ;
                "Busca de Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oPagina.txt_4c_Moeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_oPagina.txt_4c_Moeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSMoeda - Busca de Moeda em SigCdMoe (lado direito)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSMoeda()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_SMoeda.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_Busca", "cmoes", loc_cValor, ;
                "Busca de Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oPagina.txt_4c_SMoeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_oPagina.txt_4c_SMoeda.Value = PADR(ALLTRIM(cursor_4c_Busca.cmoes), 3)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupSMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupJob - Busca de Job/Projeto em SigCdCli (Iclis/Rclis)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupJob()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Job.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_Busca", "Iclis", loc_cValor, ;
                "Busca de Job/Projeto")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Busca")
                        SELECT cursor_4c_Busca
                        loc_oPagina.txt_4c_Job.Value  = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
                        loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_oPagina.txt_4c_Job.Value  = PADR(ALLTRIM(cursor_4c_Busca.Iclis), 10)
                            loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(cursor_4c_Busca.Rclis), 40)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirLookupJob")
        ENDTRY
    ENDPROC

    *==========================================================================
    * EVENT HANDLERS - LOOKUP (LostFocus e KeyPress)
    * DEVEM SER PUBLIC (BINDEVENT exige metodos publicos)
    *==========================================================================

    *--------------------------------------------------------------------------
    * GrupoLostFocus - Valida e carrega descricao do Grupo esquerdo
    *--------------------------------------------------------------------------
    PROCEDURE GrupoLostFocus()
        LOCAL loc_oPagina, loc_cCod, loc_nRes
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpGrupo")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpGrupo") > 0
                    SELECT cursor_4c_TmpGrupo
                    loc_oPagina.txt_4c_DGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
                    MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCod, "Grupo")
                    loc_oPagina.txt_4c_Grupo.Value = SPACE(10)
                ENDIF
                IF USED("cursor_4c_TmpGrupo")
                    USE IN cursor_4c_TmpGrupo
                ENDIF
            ELSE
                loc_oPagina.txt_4c_DGrupo.Value = SPACE(40)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GrupoLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoKeyPress - F4 abre lookup de Grupo esquerdo
    *--------------------------------------------------------------------------
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaLostFocus - Valida e carrega descricao da Conta esquerda (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE ContaLostFocus()
        LOCAL loc_oPagina, loc_cCod, loc_nRes
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpConta")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpConta") > 0
                    SELECT cursor_4c_TmpConta
                    loc_oPagina.txt_4c_DcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
                    MsgAviso("Conta n" + CHR(227) + "o encontrada: " + loc_cCod, "Conta")
                    loc_oPagina.txt_4c_Conta.Value = SPACE(10)
                ENDIF
                IF USED("cursor_4c_TmpConta")
                    USE IN cursor_4c_TmpConta
                ENDIF
            ELSE
                loc_oPagina.txt_4c_DcConta.Value = SPACE(40)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ContaLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaKeyPress - F4 abre lookup de Conta esquerda
    *--------------------------------------------------------------------------
    PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MoedaLostFocus - Valida Moeda esquerda em SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE MoedaLostFocus()
        LOCAL loc_oPagina, loc_cCod, loc_nRes
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Moeda.Value)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpMoeda")
                IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_TmpMoeda") = 0
                    MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Moeda")
                    loc_oPagina.txt_4c_Moeda.Value = SPACE(3)
                ENDIF
                IF USED("cursor_4c_TmpMoeda")
                    USE IN cursor_4c_TmpMoeda
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "MoedaLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MoedaKeyPress - F4 abre lookup de Moeda esquerda
    *--------------------------------------------------------------------------
    PROCEDURE MoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SGrupoLostFocus - Valida e carrega descricao do Grupo direito
    *--------------------------------------------------------------------------
    PROCEDURE SGrupoLostFocus()
        LOCAL loc_oPagina, loc_cCod, loc_nRes
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_SGrupo.Value)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpSGrupo")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpSGrupo") > 0
                    SELECT cursor_4c_TmpSGrupo
                    loc_oPagina.txt_4c_SDGrupo.Value = PADR(ALLTRIM(NVL(descrs, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
                    MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCod, "Grupo")
                    loc_oPagina.txt_4c_SGrupo.Value = SPACE(10)
                ENDIF
                IF USED("cursor_4c_TmpSGrupo")
                    USE IN cursor_4c_TmpSGrupo
                ENDIF
            ELSE
                loc_oPagina.txt_4c_SDGrupo.Value = SPACE(40)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SGrupoLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * SGrupoKeyPress - F4 abre lookup de Grupo direito
    *--------------------------------------------------------------------------
    PROCEDURE SGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupSGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SContaLostFocus - Valida e carrega descricao da Conta direita (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE SContaLostFocus()
        LOCAL loc_oPagina, loc_cCod, loc_nRes
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_SConta.Value)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpSConta")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpSConta") > 0
                    SELECT cursor_4c_TmpSConta
                    loc_oPagina.txt_4c_SDcConta.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
                    MsgAviso("Conta n" + CHR(227) + "o encontrada: " + loc_cCod, "Conta")
                    loc_oPagina.txt_4c_SConta.Value = SPACE(10)
                ENDIF
                IF USED("cursor_4c_TmpSConta")
                    USE IN cursor_4c_TmpSConta
                ENDIF
            ELSE
                loc_oPagina.txt_4c_SDcConta.Value = SPACE(40)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SContaLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * SContaKeyPress - F4 abre lookup de Conta direita
    *--------------------------------------------------------------------------
    PROCEDURE SContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupSConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SMoedaLostFocus - Valida Moeda direita em SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE SMoedaLostFocus()
        LOCAL loc_oPagina, loc_cCod, loc_nRes
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_SMoeda.Value)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpSMoeda")
                IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_TmpSMoeda") = 0
                    MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Moeda")
                    loc_oPagina.txt_4c_SMoeda.Value = SPACE(3)
                ENDIF
                IF USED("cursor_4c_TmpSMoeda")
                    USE IN cursor_4c_TmpSMoeda
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SMoedaLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * SMoedaKeyPress - F4 abre lookup de Moeda direita
    *--------------------------------------------------------------------------
    PROCEDURE SMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupSMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * JobLostFocus - Valida Job e carrega descricao (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE JobLostFocus()
        LOCAL loc_oPagina, loc_cCod, loc_nRes
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cCod    = ALLTRIM(loc_oPagina.txt_4c_Job.Value)
            IF !EMPTY(loc_cCod)
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_TmpJob")
                IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpJob") > 0
                    SELECT cursor_4c_TmpJob
                    loc_oPagina.txt_4c_DJob.Value = PADR(ALLTRIM(NVL(Rclis, "")), 40)
                ELSE
                    loc_oPagina.txt_4c_DJob.Value = SPACE(40)
                    MsgAviso("Job n" + CHR(227) + "o encontrado: " + loc_cCod, "Job")
                    loc_oPagina.txt_4c_Job.Value = SPACE(10)
                ENDIF
                IF USED("cursor_4c_TmpJob")
                    USE IN cursor_4c_TmpJob
                ENDIF
            ELSE
                loc_oPagina.txt_4c_DJob.Value = SPACE(40)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "JobLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * JobKeyPress - F4 abre lookup de Job
    *--------------------------------------------------------------------------
    PROCEDURE JobKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupJob()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValorLostFocus - Ao sair de Valor, calcula Svalors se moeda for R (Real)
    * Legado: get_conta.Valid busca saldo em SigMvSlc e propoe complemento
    *--------------------------------------------------------------------------
    PROCEDURE ValorLostFocus()
        LOCAL loc_oPagina, loc_nValor, loc_cOper
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_nValor  = loc_oPagina.txt_4c_Valor.Value
            loc_cOper   = ALLTRIM(loc_oPagina.txt_4c_Oper.Value)

            *-- Propor operacao inversa no lado direito se SOper vazio
            IF !EMPTY(loc_cOper) AND EMPTY(ALLTRIM(loc_oPagina.txt_4c_SOper.Value))
                loc_oPagina.txt_4c_SOper.Value  = IIF(UPPER(loc_cOper) = "D", "C", "D")
                loc_oPagina.txt_4c_SValor.Value = loc_nValor
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValorLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CotacaoLostFocus - Recalcula Svalors baseado na cotacao do Real
    *--------------------------------------------------------------------------
    PROCEDURE CotacaoLostFocus()
        LOCAL loc_oPagina, loc_nValor, loc_nCotacao
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_nValor   = loc_oPagina.txt_4c_Valor.Value
            loc_nCotacao = loc_oPagina.txt_4c_Cotacao.Value

            IF loc_nCotacao > 0
                loc_oPagina.txt_4c_SValor.Value = ROUND(loc_nValor * loc_nCotacao, 2)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CotacaoLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * SValorLostFocus - Recalcula SCotacao baseado nos valores
    *--------------------------------------------------------------------------
    PROCEDURE SValorLostFocus()
        LOCAL loc_oPagina, loc_nValor, loc_nSValor
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_nValor  = loc_oPagina.txt_4c_Valor.Value
            loc_nSValor = loc_oPagina.txt_4c_SValor.Value

            IF loc_nValor > 0 AND loc_nSValor > 0
                loc_oPagina.txt_4c_SCotacao.Value = ROUND(loc_nSValor / loc_nValor, 7)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SValorLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlteraCotacaoClick - Alterar cotacao/moeda (painel esquerdo)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlteraCotacaoClick()
        TRY
            THIS.AbrirLookupMoeda()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnAlteraCotacaoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlteraSCotacaoClick - Alterar cotacao/moeda (painel direito)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlteraSCotacaoClick()
        TRY
            THIS.AbrirLookupSMoeda()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnAlteraSCotacaoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FILTRO DE PERIODO
    *==========================================================================

    *--------------------------------------------------------------------------
    * FiltroDataInicialLostFocus - Sincroniza datas: se inicial > final, ajusta final
    *--------------------------------------------------------------------------
    PROCEDURE FiltroDataInicialLostFocus()
        LOCAL loc_dInicio, loc_dFim, loc_oFiltro
        TRY
            loc_oFiltro = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
            loc_dInicio = loc_oFiltro.txt_4c_DtInicial.Value
            loc_dFim    = loc_oFiltro.txt_4c_DtFinal.Value

            IF !EMPTY(loc_dInicio) AND !EMPTY(loc_dFim)
                IF loc_dInicio > loc_dFim
                    loc_oFiltro.txt_4c_DtFinal.Value = loc_dInicio
                    loc_oFiltro.txt_4c_DtFinal.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FiltroDataInicialLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltroDataFinalLostFocus - Sincroniza datas e recarrega grid
    *--------------------------------------------------------------------------
    PROCEDURE FiltroDataFinalLostFocus()
        LOCAL loc_dInicio, loc_dFim, loc_oFiltro
        TRY
            loc_oFiltro = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
            loc_dInicio = loc_oFiltro.txt_4c_DtInicial.Value
            loc_dFim    = loc_oFiltro.txt_4c_DtFinal.Value

            IF !EMPTY(loc_dFim) AND !EMPTY(loc_dInicio)
                IF loc_dFim < loc_dInicio
                    loc_oFiltro.txt_4c_DtInicial.Value = loc_dFim
                    loc_oFiltro.txt_4c_DtInicial.Refresh()
                ENDIF
            ENDIF

            IF THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.CarregarLista()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FiltroDataFinalLostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AUXILIARES
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Verdana"
                .FontSize = 8
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormatarGridLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Filtra por nome (_4c_) para nao afetar containers flutuantes (Visible=.F.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = LOWER(loc_oObjeto.Name)
                IF "_4c_" $ loc_cNome OR "lbl_" $ loc_cNome OR "shp_" $ loc_cNome
                    IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                        loc_oObjeto.Visible = .T.
                    ENDIF
                ENDIF
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cursor_4c_Grade")
            USE IN cursor_4c_Grade
        ENDIF
        IF USED("cursor_4c_DadosTemp")
            USE IN cursor_4c_DadosTemp
        ENDIF
        IF USED("cursor_4c_TmpDesc")
            USE IN cursor_4c_TmpDesc
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*==============================================================================
* sigmvccrBO.prg - Business Object para Movimentos de Conta Corrente
* Data: 2026-04-11
* Tabela: SigMvCcr | PK: cidchaves (clustered)
* Operacao principal: nopers (numero da operacao)
*==============================================================================

DEFINE CLASS sigmvccrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - campos BIT (logico)
    *--------------------------------------------------------------------------
    this_lAutos   = .F.    && autos   BIT - Lancamento automatico
    this_lConcs   = .F.    && concs   BIT - Conciliado

    *--------------------------------------------------------------------------
    * Propriedades - campos CHAR
    *--------------------------------------------------------------------------
    this_cEmps        = ""    && emps        CHAR(3)  - Empresa (FK)
    this_cEmpccs      = ""    && empccs      CHAR(3)  - Empresa contra-partida
    this_cEmpos       = ""    && empos       CHAR(3)  - Empresa origem

    this_cCidchaves   = ""    && cidchaves   CHAR(20) - Chave unica (PK)
    this_cGruconmoes  = ""    && gruconmoes  CHAR(23) - Grupos+Contas+Moedas (computado)
    this_cEmpdopncs   = ""    && empdopncs   CHAR(29) - Emps+Dopes+Numcs
    this_cEmpdopnums  = ""    && empdopnums  CHAR(29) - Emps+Dopes+Numes
    this_cDopotps     = ""    && dopotps     CHAR(23) - Dopes+Opers+Tipos+Pagos

    this_cDopes       = ""    && dopes       CHAR(20) - Operacao debito
    this_cDopcs       = ""    && dopcs       CHAR(20) - Operacao credito
    this_cVopers      = ""    && vopers      CHAR(13) - Operacao estendida
    this_cOpers       = ""    && opers       CHAR(1)  - Tipo D/C (debito/credito)
    this_cSopers      = ""    && sopers      CHAR(1)  - Tipo D/C contra-partida
    this_cTipos       = ""    && tipos       CHAR(1)  - Tipo de lancamento
    this_cPagos       = ""    && pagos       CHAR(1)  - Pago (S/N)

    this_cGrupos      = ""    && grupos      CHAR(10) - Grupo debito
    this_cContas      = ""    && contas      CHAR(10) - Conta debito
    this_cMoedas      = ""    && moedas      CHAR(3)  - Moeda debito
    this_cSgrupos     = ""    && sgrupos     CHAR(10) - Grupo credito
    this_cScontas     = ""    && scontas     CHAR(10) - Conta credito
    this_cSmoedas     = ""    && smoedas     CHAR(3)  - Moeda credito

    this_cContages    = ""    && contages    CHAR(10) - Conta gerencial
    this_cGrupages    = ""    && grupages    CHAR(10) - Grupo gerencial
    this_cContems     = ""    && contems     CHAR(10) - Conta empresa
    this_cGrupems     = ""    && grupems     CHAR(10) - Grupo empresa
    this_cLocals      = ""    && locals      CHAR(10) - Local
    this_cBcontas     = ""    && bcontas     CHAR(10) - Conta bancaria
    this_cBgrupos     = ""    && bgrupos     CHAR(10) - Grupo bancario
    this_cRcontas     = ""    && rcontas     CHAR(10) - Conta referencia
    this_cVlancs      = ""    && vlancs      CHAR(10) - Vinculo lancamento

    this_cNfs         = ""    && nfs         CHAR(10) - Numero nota fiscal
    this_cDocus       = ""    && docus       CHAR(10) - Documento
    this_cEspecienfs  = ""    && especienfs  CHAR(6)  - Especie NF
    this_cTpdocnf     = ""    && tpdocnf     CHAR(2)  - Tipo documento NF
    this_cTitulos     = ""    && titulos     CHAR(10) - Titulo
    this_cTitbans     = ""    && titbans     CHAR(12) - Titulo bancario
    this_cTitpais     = ""    && titpais     CHAR(10) - Titulo pai

    this_cHists       = ""    && hists       CHAR(60) - Historico
    this_cHist2s      = ""    && hist2s      CHAR(80) - Historico 2
    this_cShists      = ""    && shists      CHAR(40) - Historico complementar

    this_cJobs        = ""    && jobs        CHAR(10) - Job/Projeto
    this_cCompet      = ""    && compet      CHAR(7)  - Competencia (AAAAMM)
    this_cOridopnums  = ""    && oridopnums  CHAR(29) - Operacao origem
    this_cCotusus     = ""    && cotusus     CHAR(10) - Cotacao usuario

    this_cUsualts     = ""    && usualts     CHAR(10) - Usuario alteracao
    this_cUsuexcs     = ""    && usuexcs     CHAR(10) - Usuario exclusao
    this_cUsuconcs    = ""    && usuconcs    CHAR(10) - Usuario conciliacao
    this_cAuditors    = ""    && auditors    CHAR(10) - Auditor
    this_cUsuconfs    = ""    && usuconfs    CHAR(10) - Usuario confirmacao
    this_cUsupagos    = ""    && usupagos    CHAR(10) - Usuario pagamento

    this_cPastas      = ""    && pastas      TEXT     - Pasta (memo)

    *--------------------------------------------------------------------------
    * Propriedades - campos NUMERIC
    *--------------------------------------------------------------------------
    this_nNopers      = 0     && nopers      NUMERIC(7,0)   - Numero operacao
    this_nNumes       = 0     && numes       NUMERIC(6,0)   - Numero debito
    this_nNumcs       = 0     && numcs       NUMERIC(6,0)   - Numero credito
    this_nNlancs      = 0     && nlancs      NUMERIC(6,0)   - Numero lancamento
    this_nNtrans      = 0     && ntrans      NUMERIC(6,0)   - Numero transferencia
    this_nBorderos    = 0     && borderos    NUMERIC(6,0)   - Bordereau
    this_nIntconts    = 0     && intconts    NUMERIC(6,0)   - Integracao contabil
    this_nNopercancs  = 0     && nopercancs  NUMERIC(7,0)   - Numero operacao cancelada

    this_nCotacaos    = 0     && cotacaos    NUMERIC(15,7)  - Cotacao debito
    this_nScotacaos   = 0     && scotacaos   NUMERIC(15,7)  - Cotacao credito

    this_nValors      = 0     && valors      NUMERIC(11,2)  - Valor debito
    this_nSvalors     = 0     && svalors     NUMERIC(11,2)  - Valor credito
    this_nValliqs     = 0     && valliqs     NUMERIC(11,2)  - Valor liquido
    this_nValocurs    = 0     && valocurs    NUMERIC(11,2)  - Valor ocorrencia
    this_nValpags     = 0     && valpags     NUMERIC(11,2)  - Valor pago
    this_nValprev     = 0     && valprev     NUMERIC(11,2)  - Valor previsto
    this_nImpostos    = 0     && impostos    NUMERIC(11,2)  - Impostos

    this_nSaldos      = 0     && saldos      NUMERIC(15,2)  - Saldo geral
    this_nSaldocs     = 0     && saldocs     NUMERIC(15,2)  - Saldo credito
    this_nSaldons     = 0     && saldons     NUMERIC(15,2)  - Saldo debito

    this_nContapgs    = 0     && contapgs    NUMERIC(1,0)   - Opcao conta (0=Global/1=Cred/2=Deb)
    this_nTitcancs    = 0     && titcancs    NUMERIC(1,0)   - Titulo cancelado
    this_nTpimpostos  = 0     && tpimpostos  NUMERIC(2,0)   - Tipo imposto
    this_nRecor       = 0     && recor       NUMERIC(1,0)   - Recorrencia

    *--------------------------------------------------------------------------
    * Propriedades - campos DATETIME
    *--------------------------------------------------------------------------
    this_dDatas     = {}      && datas       DATETIME - Data lancamento
    this_dVencs     = {}      && vencs       DATETIME - Data vencimento
    this_dDtemis    = {}      && dtemis      DATETIME - Data emissao
    this_dDatalts   = {}      && datalts     DATETIME - Data alteracao
    this_dDatexcs   = {}      && datexcs     DATETIME - Data exclusao
    this_dDataconcs = {}      && dataconcs   DATETIME - Data conciliacao
    this_dDatatrans = {}      && datatrans   DATETIME - Data transferencia
    this_dDtaudits  = {}      && dtaudits    DATETIME - Data auditoria
    this_dDtconfs   = {}      && dtconfs     DATETIME - Data confirmacao

    *--------------------------------------------------------------------------
    * Propriedades de filtro para Buscar()
    *--------------------------------------------------------------------------
    this_dFiltroInicio = {}   && Data inicial do filtro de periodo
    this_dFiltroFim    = {}   && Data final do filtro de periodo

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
    * ObterChavePrimaria - Retorna chave para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista movimentos de conta corrente com filtro de periodo
    * par_cFiltro: clausula WHERE adicional (opcional)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF !EMPTY(THIS.this_dFiltroInicio) AND !EMPTY(THIS.this_dFiltroFim)
                loc_cWhere = loc_cWhere + ;
                    " AND a.Datas >= " + FormatarDataSQL(THIS.this_dFiltroInicio) + ;
                    " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dFiltroFim) + ")"
            ENDIF

            IF !EMPTY(par_cFiltro)
                loc_cWhere = loc_cWhere + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Vencs, a.Dtemis," + ;
                       " a.Grupos, a.Contas, a.Moedas, a.Opers," + ;
                       " a.Sgrupos, a.Scontas, a.Smoedas, a.Sopers," + ;
                       " a.Valors, a.Svalors, a.Cotacaos, a.Scotacaos," + ;
                       " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                       " a.Cidchaves, a.Autos, a.Concs," + ;
                       " a.Vopers, a.Dopes, a.Dopcs," + ;
                       " a.Jobs, a.Usualts, a.Contapgs," + ;
                       " a.Saldos, a.Saldocs, a.Saldons" + ;
                       " FROM SigMvCcr a" + ;
                       loc_cWhere + ;
                       " ORDER BY a.Datas, a.Nopers"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar movimentos de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Vencs, a.Dtemis," + ;
                       " a.Grupos, a.Contas, a.Moedas, a.Opers," + ;
                       " a.Sgrupos, a.Scontas, a.Smoedas, a.Sopers," + ;
                       " a.Valors, a.Svalors, a.Cotacaos, a.Scotacaos," + ;
                       " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                       " a.Cidchaves, a.Autos, a.Concs, a.Pagos," + ;
                       " a.Vopers, a.Dopes, a.Dopcs," + ;
                       " a.Jobs, a.Usualts, a.Contapgs," + ;
                       " a.Saldos, a.Saldocs, a.Saldons," + ;
                       " a.Valliqs, a.Valocurs, a.Valpags, a.Valprev," + ;
                       " a.Impostos, a.Tpimpostos," + ;
                       " a.Nlancs, a.Ntrans, a.Numes, a.Numcs," + ;
                       " a.Borderos, a.Intconts, a.Nopercancs," + ;
                       " a.Titulos, a.Titbans, a.Titpais," + ;
                       " a.Contages, a.Grupages, a.Contems, a.Grupems," + ;
                       " a.Locals, a.Bcontas, a.Bgrupos, a.Rcontas," + ;
                       " a.Vlancs, a.Cotusus, a.Compet," + ;
                       " a.Empccs, a.Empos, a.Oridopnums," + ;
                       " a.Datalts, a.Datexcs, a.Dataconcs, a.Datatrans," + ;
                       " a.Dtaudits, a.Dtconfs," + ;
                       " a.Usualts, a.Usuexcs, a.Usuconcs, a.Auditors," + ;
                       " a.Usuconfs, a.Usupagos," + ;
                       " a.Tipos, a.Gruconmoes, a.Empdopncs, a.Empdopnums," + ;
                       " a.Dopotps, a.Titcancs, a.Especienfs, a.Tpdocnf," + ;
                       " a.Recor" + ;
                       " FROM SigMvCcr a" + ;
                       " WHERE a.Cidchaves = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * SEMPRE usar SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves   = TratarNulo(cidchaves, "C")
                THIS.this_cEmps        = TratarNulo(emps, "C")
                THIS.this_nNopers      = TratarNulo(nopers, "N")
                THIS.this_dDatas       = TratarNulo(datas, "D")
                THIS.this_dVencs       = TratarNulo(vencs, "D")
                THIS.this_dDtemis      = TratarNulo(dtemis, "D")

                THIS.this_cGrupos      = TratarNulo(grupos, "C")
                THIS.this_cContas      = TratarNulo(contas, "C")
                THIS.this_cMoedas      = TratarNulo(moedas, "C")
                THIS.this_cOpers       = TratarNulo(opers, "C")
                THIS.this_cSgrupos     = TratarNulo(sgrupos, "C")
                THIS.this_cScontas     = TratarNulo(scontas, "C")
                THIS.this_cSmoedas     = TratarNulo(smoedas, "C")
                THIS.this_cSopers      = TratarNulo(sopers, "C")

                THIS.this_nValors      = TratarNulo(valors, "N")
                THIS.this_nSvalors     = TratarNulo(svalors, "N")
                THIS.this_nCotacaos    = TratarNulo(cotacaos, "N")
                THIS.this_nScotacaos   = TratarNulo(scotacaos, "N")

                THIS.this_cHists       = TratarNulo(hists, "C")
                THIS.this_cHist2s      = TratarNulo(hist2s, "C")
                THIS.this_cShists      = TratarNulo(shists, "C")
                THIS.this_cNfs         = TratarNulo(nfs, "C")
                THIS.this_cDocus       = TratarNulo(docus, "C")

                THIS.this_lAutos       = (IIF(VARTYPE(autos) = "L", autos, (NVL(autos, 0) = 1)))
                THIS.this_lConcs       = (IIF(VARTYPE(concs) = "L", concs, (NVL(concs, 0) = 1)))
                THIS.this_cPagos       = TratarNulo(pagos, "C")

                THIS.this_cVopers      = TratarNulo(vopers, "C")
                THIS.this_cDopes       = TratarNulo(dopes, "C")
                THIS.this_cDopcs       = TratarNulo(dopcs, "C")
                THIS.this_cJobs        = TratarNulo(jobs, "C")
                THIS.this_cUsualts     = TratarNulo(usualts, "C")
                THIS.this_nContapgs    = TratarNulo(contapgs, "N")

                THIS.this_nSaldos      = TratarNulo(saldos, "N")
                THIS.this_nSaldocs     = TratarNulo(saldocs, "N")
                THIS.this_nSaldons     = TratarNulo(saldons, "N")

                *-- Campos adicionais (presentes apenas em CarregarPorCodigo)
                IF PEMSTATUS((par_cAliasCursor), "nlancs", 8)
                    THIS.this_nNlancs    = TratarNulo(nlancs, "N")
                    THIS.this_nNtrans    = TratarNulo(ntrans, "N")
                    THIS.this_nNumes     = TratarNulo(numes, "N")
                    THIS.this_nNumcs     = TratarNulo(numcs, "N")
                    THIS.this_nBorderos  = TratarNulo(borderos, "N")
                    THIS.this_nIntconts  = TratarNulo(intconts, "N")
                    THIS.this_cTitulos   = TratarNulo(titulos, "C")
                    THIS.this_cTitbans   = TratarNulo(titbans, "C")
                    THIS.this_cTitpais   = TratarNulo(titpais, "C")
                    THIS.this_cContages  = TratarNulo(contages, "C")
                    THIS.this_cGrupages  = TratarNulo(grupages, "C")
                    THIS.this_cContems   = TratarNulo(contems, "C")
                    THIS.this_cGrupems   = TratarNulo(grupems, "C")
                    THIS.this_cLocals    = TratarNulo(locals, "C")
                    THIS.this_cBcontas   = TratarNulo(bcontas, "C")
                    THIS.this_cBgrupos   = TratarNulo(bgrupos, "C")
                    THIS.this_cRcontas   = TratarNulo(rcontas, "C")
                    THIS.this_cVlancs    = TratarNulo(vlancs, "C")
                    THIS.this_cCotusus   = TratarNulo(cotusus, "C")
                    THIS.this_cCompet    = TratarNulo(compet, "C")
                    THIS.this_cEmpccs    = TratarNulo(empccs, "C")
                    THIS.this_cEmpos     = TratarNulo(empos, "C")
                    THIS.this_cOridopnums = TratarNulo(oridopnums, "C")
                    THIS.this_dDatalts   = TratarNulo(datalts, "D")
                    THIS.this_dDatexcs   = TratarNulo(datexcs, "D")
                    THIS.this_dDataconcs = TratarNulo(dataconcs, "D")
                    THIS.this_dDatatrans = TratarNulo(datatrans, "D")
                    THIS.this_dDtaudits  = TratarNulo(dtaudits, "D")
                    THIS.this_dDtconfs   = TratarNulo(dtconfs, "D")
                    THIS.this_cUsuexcs   = TratarNulo(usuexcs, "C")
                    THIS.this_cUsuconcs  = TratarNulo(usuconcs, "C")
                    THIS.this_cAuditors  = TratarNulo(auditors, "C")
                    THIS.this_cUsuconfs  = TratarNulo(usuconfs, "C")
                    THIS.this_cUsupagos  = TratarNulo(usupagos, "C")
                    THIS.this_cTipos     = TratarNulo(tipos, "C")
                    THIS.this_cGruconmoes = TratarNulo(gruconmoes, "C")
                    THIS.this_cEmpdopncs  = TratarNulo(empdopncs, "C")
                    THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
                    THIS.this_cDopotps    = TratarNulo(dopotps, "C")
                    THIS.this_nTitcancs   = TratarNulo(titcancs, "N")
                    THIS.this_cEspecienfs = TratarNulo(especienfs, "C")
                    THIS.this_cTpdocnf    = TratarNulo(tpdocnf, "C")
                    THIS.this_nRecor      = TratarNulo(recor, "N")
                    THIS.this_nNopercancs = TratarNulo(nopercancs, "N")
                    THIS.this_nValliqs    = TratarNulo(valliqs, "N")
                    THIS.this_nValocurs   = TratarNulo(valocurs, "N")
                    THIS.this_nValpags    = TratarNulo(valpags, "N")
                    THIS.this_nValprev    = TratarNulo(valprev, "N")
                    THIS.this_nImpostos   = TratarNulo(impostos, "N")
                    THIS.this_nTpimpostos = TratarNulo(tpimpostos, "N")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigMvCcr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_nNopers, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Obter proximo nopers para a empresa
            loc_cSQL = "SELECT ISNULL(MAX(Nopers), 0) + 1 AS ProxNopers" + ;
                       " FROM SigMvCcr WITH (UPDLOCK, HOLDLOCK)" + ;
                       " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF USED("cursor_4c_ProxNoper")
                USE IN cursor_4c_ProxNoper
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxNoper")

            IF loc_nResult < 0 OR RECCOUNT("cursor_4c_ProxNoper") = 0
                MsgErro("Erro ao obter numero de operacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_ProxNoper")
                    USE IN cursor_4c_ProxNoper
                ENDIF
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_ProxNoper
            loc_nNopers = cursor_4c_ProxNoper.ProxNopers
            THIS.this_nNopers = loc_nNopers

            IF USED("cursor_4c_ProxNoper")
                USE IN cursor_4c_ProxNoper
            ENDIF

            *-- Gerar cidchaves: YYYYMMDD + nopers 6 digitos
            THIS.this_cCidchaves = DTOS(THIS.this_dDatas) + ;
                PADL(ALLTRIM(STR(loc_nNopers, 7, 0)), 7, "0")

            *-- Campos computados
            THIS.this_cGruconmoes  = ALLTRIM(THIS.this_cGrupos) + ;
                ALLTRIM(THIS.this_cContas) + ALLTRIM(THIS.this_cMoedas)
            THIS.this_cEmpdopncs   = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopcs) + ALLTRIM(STR(THIS.this_nNumcs, 6, 0))
            THIS.this_cEmpdopnums  = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopes) + ALLTRIM(STR(THIS.this_nNumes, 6, 0))
            THIS.this_cDopotps     = ALLTRIM(THIS.this_cDopes) + ;
                ALLTRIM(THIS.this_cOpers) + ALLTRIM(THIS.this_cTipos) + ;
                ALLTRIM(THIS.this_cPagos)

            *-- INSERT com colunas sem duplicatas (82 colunas)
            loc_cSQL = "INSERT INTO SigMvCcr (" + ;
                       " Emps, Nopers, Cidchaves, Datas, Vencs, Dtemis," + ;
                       " Grupos, Contas, Moedas, Opers," + ;
                       " Sgrupos, Scontas, Smoedas, Sopers," + ;
                       " Valors, Svalors, Cotacaos, Scotacaos," + ;
                       " Hists, Hist2s, Shists, Nfs, Docus," + ;
                       " Autos, Concs, Pagos, Tipos," + ;
                       " Vopers, Dopes, Dopcs, Jobs, Contapgs," + ;
                       " Saldos, Saldocs, Saldons," + ;
                       " Valliqs, Valocurs, Valpags, Valprev, Impostos, Tpimpostos," + ;
                       " Nlancs, Ntrans, Numes, Numcs, Borderos, Intconts, Nopercancs," + ;
                       " Titulos, Titbans, Titpais, Titcancs," + ;
                       " Contages, Grupages, Contems, Grupems," + ;
                       " Locals, Bcontas, Bgrupos, Rcontas, Vlancs, Cotusus," + ;
                       " Compet, Empccs, Empos, Oridopnums, Tpdocnf, Especienfs, Recor," + ;
                       " Gruconmoes, Empdopncs, Empdopnums, Dopotps," + ;
                       " Usualts, Usuexcs, Usuconcs, Auditors, Usuconfs, Usupagos" + ;
                       ") VALUES ("

            *-- Valores linha 1: chaves e datas (6 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + "," + ;
                FormatarNumeroSQL(THIS.this_nNopers) + "," + ;
                EscaparSQL(THIS.this_cCidchaves) + "," + ;
                FormatarDataSQL(THIS.this_dDatas) + "," + ;
                FormatarDataSQL(THIS.this_dVencs) + "," + ;
                FormatarDataSQL(THIS.this_dDtemis) + ","

            *-- Valores linha 2: grupos, contas, moedas, operacoes (8 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cGrupos) + "," + ;
                EscaparSQL(THIS.this_cContas) + "," + ;
                EscaparSQL(THIS.this_cMoedas) + "," + ;
                EscaparSQL(THIS.this_cOpers) + "," + ;
                EscaparSQL(THIS.this_cSgrupos) + "," + ;
                EscaparSQL(THIS.this_cScontas) + "," + ;
                EscaparSQL(THIS.this_cSmoedas) + "," + ;
                EscaparSQL(THIS.this_cSopers) + ","

            *-- Valores linha 3: valores e cotacoes (4 valores)
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                FormatarNumeroSQL(THIS.this_nScotacaos) + ","

            *-- Valores linha 4: historico, nf, documento (5 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cHists) + "," + ;
                EscaparSQL(THIS.this_cHist2s) + "," + ;
                EscaparSQL(THIS.this_cShists) + "," + ;
                EscaparSQL(THIS.this_cNfs) + "," + ;
                EscaparSQL(THIS.this_cDocus) + ","

            *-- Valores linha 5: flags, tipos, operacoes (11 valores)
            loc_cSQL = loc_cSQL + ;
                IIF(THIS.this_lAutos, "1", "0") + "," + ;
                IIF(THIS.this_lConcs, "1", "0") + "," + ;
                EscaparSQL(THIS.this_cPagos) + "," + ;
                EscaparSQL(THIS.this_cTipos) + "," + ;
                EscaparSQL(THIS.this_cVopers) + "," + ;
                EscaparSQL(THIS.this_cDopes) + "," + ;
                EscaparSQL(THIS.this_cDopcs) + "," + ;
                EscaparSQL(THIS.this_cJobs) + "," + ;
                FormatarNumeroSQL(THIS.this_nContapgs) + ","

            *-- Valores linha 6: saldos (3 valores)
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nSaldos) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldocs) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldons) + ","

            *-- Valores linha 7: valores complementares e numeradores (13 valores)
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nValliqs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValocurs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValpags) + "," + ;
                FormatarNumeroSQL(THIS.this_nValprev) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpostos) + "," + ;
                FormatarNumeroSQL(THIS.this_nTpimpostos) + "," + ;
                FormatarNumeroSQL(THIS.this_nNlancs) + "," + ;
                FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumcs) + "," + ;
                FormatarNumeroSQL(THIS.this_nBorderos) + "," + ;
                FormatarNumeroSQL(THIS.this_nIntconts) + "," + ;
                FormatarNumeroSQL(THIS.this_nNopercancs) + ","

            *-- Valores linha 8: titulos (4 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cTitulos) + "," + ;
                EscaparSQL(THIS.this_cTitbans) + "," + ;
                EscaparSQL(THIS.this_cTitpais) + "," + ;
                FormatarNumeroSQL(THIS.this_nTitcancs) + ","

            *-- Valores linha 9: contas gerenciais (6 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cContages) + "," + ;
                EscaparSQL(THIS.this_cGrupages) + "," + ;
                EscaparSQL(THIS.this_cContems) + "," + ;
                EscaparSQL(THIS.this_cGrupems) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cBcontas) + "," + ;
                EscaparSQL(THIS.this_cBgrupos) + "," + ;
                EscaparSQL(THIS.this_cRcontas) + "," + ;
                EscaparSQL(THIS.this_cVlancs) + "," + ;
                EscaparSQL(THIS.this_cCotusus) + ","

            *-- Valores linha 10: empresa/compet e campos computados (17 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCompet) + "," + ;
                EscaparSQL(THIS.this_cEmpccs) + "," + ;
                EscaparSQL(THIS.this_cEmpos) + "," + ;
                EscaparSQL(THIS.this_cOridopnums) + "," + ;
                EscaparSQL(THIS.this_cTpdocnf) + "," + ;
                EscaparSQL(THIS.this_cEspecienfs) + "," + ;
                FormatarNumeroSQL(THIS.this_nRecor) + "," + ;
                EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                EscaparSQL(THIS.this_cEmpdopncs) + "," + ;
                EscaparSQL(THIS.this_cEmpdopnums) + "," + ;
                EscaparSQL(THIS.this_cDopotps) + ","

            *-- Valores linha 11: usuarios de auditoria (6 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + ;
                ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigMvCcr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campos computados
            THIS.this_cGruconmoes  = ALLTRIM(THIS.this_cGrupos) + ;
                ALLTRIM(THIS.this_cContas) + ALLTRIM(THIS.this_cMoedas)
            THIS.this_cEmpdopncs   = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopcs) + ALLTRIM(STR(THIS.this_nNumcs, 6, 0))
            THIS.this_cEmpdopnums  = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopes) + ALLTRIM(STR(THIS.this_nNumes, 6, 0))
            THIS.this_cDopotps     = ALLTRIM(THIS.this_cDopes) + ;
                ALLTRIM(THIS.this_cOpers) + ALLTRIM(THIS.this_cTipos) + ;
                ALLTRIM(THIS.this_cPagos)

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                       " Datas = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " Vencs = " + FormatarDataSQL(THIS.this_dVencs) + "," + ;
                       " Dtemis = " + FormatarDataSQL(THIS.this_dDtemis) + "," + ;
                       " Grupos = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                       " Contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " Moedas = " + EscaparSQL(THIS.this_cMoedas) + "," + ;
                       " Opers = " + EscaparSQL(THIS.this_cOpers) + "," + ;
                       " Sgrupos = " + EscaparSQL(THIS.this_cSgrupos) + "," + ;
                       " Scontas = " + EscaparSQL(THIS.this_cScontas) + "," + ;
                       " Smoedas = " + EscaparSQL(THIS.this_cSmoedas) + "," + ;
                       " Sopers = " + EscaparSQL(THIS.this_cSopers) + ","

            loc_cSQL = loc_cSQL + ;
                       " Valors = " + FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                       " Svalors = " + FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                       " Cotacaos = " + FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                       " Scotacaos = " + FormatarNumeroSQL(THIS.this_nScotacaos) + "," + ;
                       " Hists = " + EscaparSQL(THIS.this_cHists) + "," + ;
                       " Hist2s = " + EscaparSQL(THIS.this_cHist2s) + "," + ;
                       " Shists = " + EscaparSQL(THIS.this_cShists) + "," + ;
                       " Nfs = " + EscaparSQL(THIS.this_cNfs) + "," + ;
                       " Docus = " + EscaparSQL(THIS.this_cDocus) + ","

            loc_cSQL = loc_cSQL + ;
                       " Contapgs = " + FormatarNumeroSQL(THIS.this_nContapgs) + "," + ;
                       " Jobs = " + EscaparSQL(THIS.this_cJobs) + "," + ;
                       " Vopers = " + EscaparSQL(THIS.this_cVopers) + "," + ;
                       " Dopes = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                       " Dopcs = " + EscaparSQL(THIS.this_cDopcs) + "," + ;
                       " Gruconmoes = " + EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                       " Empdopncs = " + EscaparSQL(THIS.this_cEmpdopncs) + "," + ;
                       " Empdopnums = " + EscaparSQL(THIS.this_cEmpdopnums) + "," + ;
                       " Dopotps = " + EscaparSQL(THIS.this_cDopotps) + "," + ;
                       " Usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                       " Datalts = GETDATE()" + ;
                       " WHERE Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " AND Nopers = " + FormatarNumeroSQL(THIS.this_nNopers)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro de SigMvCcr por cidchaves
    * Nota: Registra data/usuario de exclusao antes de deletar fisicamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Marcar exclusao logica primeiro (DatExcs/UsuExcs)
            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                       " Datexcs = GETDATE()," + ;
                       " Usuexcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " AND Nopers = " + FormatarNumeroSQL(THIS.this_nNopers)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdExc")

            IF loc_nResult < 0
                MsgErro("Erro ao marcar exclusao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_UpdExc")
                    USE IN cursor_4c_UpdExc
                ENDIF

                *-- Exclusao fisica
                loc_cSQL = "DELETE FROM SigMvCcr" + ;
                           " WHERE Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                           " AND Nopers = " + FormatarNumeroSQL(THIS.this_nNopers)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    IF USED("cursor_4c_Delete")
                        USE IN cursor_4c_Delete
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

