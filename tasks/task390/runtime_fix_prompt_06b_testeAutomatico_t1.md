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
[31/07/2026 22:28:31] Erro: Sem conexão com o banco de dados!


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-31 22:27:47] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-31 22:27:47] [INFO] Config FPW: (nao fornecido)
[2026-07-31 22:27:47] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-31 22:27:47] [INFO] Timeout: 300 segundos
[2026-07-31 22:27:47] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yw0kmxk3.prg
[2026-07-31 22:27:47] [INFO] Conteudo do wrapper:
[2026-07-31 22:27:47] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCVE', 'C:\4c\tasks\task390', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCVE', 'C:\4c\tasks\task390', 'CRUD'
QUIT

[2026-07-31 22:27:47] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yw0kmxk3.prg
[2026-07-31 22:27:47] [INFO] VFP output esperado em: C:\4c\tasks\task390\vfp_output.txt
[2026-07-31 22:27:47] [INFO] Executando Visual FoxPro 9...
[2026-07-31 22:27:47] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yw0kmxk3.prg
[2026-07-31 22:27:47] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yw0kmxk3.prg
[2026-07-31 22:27:47] [INFO] Timeout configurado: 300 segundos
[2026-07-31 22:28:31] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-31 22:28:31] [INFO] VFP9 finalizado em 44.5514309 segundos
[2026-07-31 22:28:31] [INFO] Exit Code: 
[2026-07-31 22:28:31] [INFO] 
[2026-07-31 22:28:31] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-31 22:28:31] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yw0kmxk3.prg
[2026-07-31 22:28:31] [INFO] 
[2026-07-31 22:28:31] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-31 22:28:31] [INFO] * Auto-generated wrapper for parameters
[2026-07-31 22:28:31] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-31 22:28:31] [INFO] * Parameters: 'FormCVE', 'C:\4c\tasks\task390', 'CRUD'
[2026-07-31 22:28:31] [INFO] 
[2026-07-31 22:28:31] [INFO] * Anti-dialog protections for unattended execution
[2026-07-31 22:28:31] [INFO] SET SAFETY OFF
[2026-07-31 22:28:31] [INFO] SET RESOURCE OFF
[2026-07-31 22:28:31] [INFO] SET TALK OFF
[2026-07-31 22:28:31] [INFO] SET NOTIFY OFF
[2026-07-31 22:28:31] [INFO] SYS(2335, 0)
[2026-07-31 22:28:31] [INFO] 
[2026-07-31 22:28:31] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCVE', 'C:\4c\tasks\task390', 'CRUD'
[2026-07-31 22:28:31] [INFO] QUIT
[2026-07-31 22:28:31] [INFO] 
[2026-07-31 22:28:31] [INFO] === Fim do Wrapper.prg ===
[2026-07-31 22:28:31] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormCVE",
  "timestamp": "20260731222831",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCVE.prg):
*==============================================================================
* FormCVE.prg - Formulario de Cadastro de Comissoes de Vendedores por Cargos
* Herda de: FormBase
* Tabela:   SigCcCmI
* BO:       CVEBO
* FASE 6/8: Menu integration + Copia de Periodo + Lookups completos
*==============================================================================

DEFINE CLASS FormCVE AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - UX Fidelity)
    *--------------------------------------------------------------------------
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Comissoes de Vendedores por Cargos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    FontName    = "Tahoma"
    FontSize    = 8

    *--------------------------------------------------------------------------
    * Propriedades de estado
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - FormBase.Init() chama THIS.InicializarForm() via DODEFAULT
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormCVE:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Configuracao completa do formulario
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados!", "Erro")
            ELSE
                THIS.this_oBusinessObject = CREATEOBJECT("CVEBO")

                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    MsgErro("Erro ao criar CVEBO!", "Erro")
                ELSE
                    THIS.Caption = "Cadastro de Comiss" + CHR(245) + "es de " + ;
                                   "Vendedores por Cargos"

                    THIS.ConfigurarPageFrame()
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Visible = .T.
                    THIS.pgf_4c_Paginas.ActivePage = 1
                    THIS.this_cModoAtual = "LISTA"

                    IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                        THIS.CarregarLista()
                    ENDIF

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em InicializarForm:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")

            WITH THIS.pgf_4c_Paginas
                .PageCount = 2
                .Top       = -29
                .Left      = 0
                .Width     = THIS.Width
                .Height    = THIS.Height + 29
                .Tabs      = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Page1.Caption   = "Lista"
                .Page1.BackColor = RGB(100, 100, 100)
                .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.Caption   = "Dados"
                .Page2.BackColor = RGB(100, 100, 100)
                .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Visible = .T.
            ENDWITH

            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarPageFrame:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1 completa:
    *   Cabecalho, Botoes CRUD, Encerrar, Filtro de Periodo,
    *   Botao Copia, Container Copia flutuante, Grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_cCaption, loc_oGrid
        loc_oPagina  = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_cCaption = THIS.Caption

        TRY
            *-- Cabecalho (Top=2+29=31)
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 31
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Caption   = loc_cCaption
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
                    .Caption   = loc_cCaption
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

            *-- Botoes CRUD (Top=0+29=29, Left=542 - lado direito)
            loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPagina.cnt_4c_Botoes
                .Top         = 29
                .Left        = 542
                .Width       = 390
                .Height      = 85
                .BackColor   = RGB(53, 53, 53)
                .BackStyle   = 1
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Incluir", "CommandButton")
                WITH .cmd_4c_Incluir
                    .Caption         = "Incluir"
                    .Top             = 5
                    .Left            =  542
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
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Visualizar", "CommandButton")
                WITH .cmd_4c_Visualizar
                    .Caption         = "Visualizar"
                    .Top             = 5
                    .Left            =  542
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

                .AddObject("cmd_4c_Alterar", "CommandButton")
                WITH .cmd_4c_Alterar
                    .Caption         = "Alterar"
                    .Top             = 5
                    .Left            =  542
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

                .AddObject("cmd_4c_Excluir", "CommandButton")
                WITH .cmd_4c_Excluir
                    .Caption         = "Excluir"
                    .Top             = 5
                    .Left            =  542
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

                .AddObject("cmd_4c_Buscar", "CommandButton")
                WITH .cmd_4c_Buscar
                    .Caption         = "Buscar"
                    .Top             = 5
                    .Left            =  542
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
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

            *-- Encerrar - padrao canonico (CLAUDE.md Regra #10)
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
                    .Top             = 5
                    .Left            = 917
                    .Width           = 90
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .PicturePosition = 13
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

            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            *-- Filtro Periodo (top=119+29=148)
            loc_oPagina.AddObject("cnt_4c_Filtro", "Container")
            WITH loc_oPagina.cnt_4c_Filtro
                .Top         = 148
                .Left        = 11
                .Width       = 162
                .Height      = 33
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Periodo", "Label")
                WITH .lbl_4c_Periodo
                    .Caption   = "Per" + CHR(237) + "odo :"
                    .Top       = 9
                    .Left      = 23
                    .Width     = 50
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(255, 255, 255)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_FiltroMess", "TextBox")
                WITH .txt_4c_FiltroMess
                    .Value     = PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")
                    .Top       = 6
                    .Left      = 71
                    .Width     = 24
                    .Height    = 23
                    .InputMask = "99"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Barra", "Label")
                WITH .lbl_4c_Barra
                    .Caption   = "/"
                    .Top       = 9
                    .Left      = 100
                    .Width     = 8
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(255, 255, 255)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_FiltroAnos", "TextBox")
                WITH .txt_4c_FiltroAnos
                    .Value     = PADL(ALLTRIM(STR(YEAR(DATE()))), 4, "0")
                    .Top       = 6
                    .Left      = 113
                    .Width     = 38
                    .Height    = 23
                    .InputMask = "9999"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess, "KeyPress", THIS, "FiltroMesLostFocus")
            BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos, "KeyPress", THIS, "FiltroAnosLostFocus")

            *-- Botao Copia de Periodo (top=91+29=120, left=347)
            loc_oPagina.AddObject("cmd_4c_Copia", "CommandButton")
            WITH loc_oPagina.cmd_4c_Copia
                .Caption       = "C" + CHR(243) + "pia"
                .Top           = 120
                .Left          = 347
                .Width         = 105
                .Height        = 45
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .T.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.cmd_4c_Copia, "Click", THIS, "BtnCopiarClick")

            *-- Container flutuante Copia de Periodo (top=264+29=293, inicia oculto)
            loc_oPagina.AddObject("cnt_4c_Copia", "Container")
            WITH loc_oPagina.cnt_4c_Copia
                .Top         = 293
                .Left        = 226
                .Width       = 348
                .Height      = 77
                .BackColor   = RGB(240, 240, 240)
                .BackStyle   = 1
                .BorderWidth = 1
                .Visible     = .F.

                .AddObject("lbl_4c_TituloCopia", "Label")
                WITH .lbl_4c_TituloCopia
                    .Caption   = "C" + CHR(243) + "pia de Per" + CHR(237) + "odo"
                    .Top       = 5
                    .Left      = 8
                    .Width     = 150
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Origem", "Label")
                WITH .lbl_4c_Origem
                    .Caption   = "Per" + CHR(237) + "odo de Origem :"
                    .Top       = 27
                    .Left      = 28
                    .Width     = 97
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_OMess", "TextBox")
                WITH .txt_4c_OMess
                    .Value     = ""
                    .Top       = 24
                    .Left      = 128
                    .Width     = 24
                    .InputMask = "99"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_BarraO", "Label")
                WITH .lbl_4c_BarraO
                    .Caption   = "/"
                    .Top       = 27
                    .Left      = 157
                    .Width     = 8
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_OAnos", "TextBox")
                WITH .txt_4c_OAnos
                    .Value     = ""
                    .Top       = 24
                    .Left      = 166
                    .Width     = 38
                    .InputMask = "9999"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Destino", "Label")
                WITH .lbl_4c_Destino
                    .Caption   = "Per" + CHR(237) + "odo de Destino :"
                    .Top       = 52
                    .Left      = 26
                    .Width     = 99
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_DMess", "TextBox")
                WITH .txt_4c_DMess
                    .Value     = ""
                    .Top       = 48
                    .Left      = 128
                    .Width     = 24
                    .InputMask = "99"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_BarraD", "Label")
                WITH .lbl_4c_BarraD
                    .Caption   = "/"
                    .Top       = 51
                    .Left      = 157
                    .Width     = 8
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_DAnos", "TextBox")
                WITH .txt_4c_DAnos
                    .Value     = ""
                    .Top       = 48
                    .Left      = 166
                    .Width     = 38
                    .InputMask = "9999"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .T.
                ENDWITH

                .AddObject("cmd_4c_OkCopia", "CommandButton")
                WITH .cmd_4c_OkCopia
                    .Caption      = "Confirmar"
                    .Top          = 13
                    .Left         = 218
                    .Width        = 64
                    .Height       = 55
                    .FontName     = "Tahoma"
                    .FontSize     = 8
                    .FontBold     = .T.
                    .ForeColor    = RGB(90, 90, 90)
                    .BackColor    = RGB(255, 255, 255)
                    .Themes       = .T.
                    .MousePointer = 15
                    .Visible      = .T.
                ENDWITH

                .AddObject("cmd_4c_CancelarCopia", "CommandButton")
                WITH .cmd_4c_CancelarCopia
                    .Caption      = "Encerrar"
                    .Top          = 13
                    .Left         = 282
                    .Width        = 64
                    .Height       = 55
                    .FontName     = "Tahoma"
                    .FontSize     = 8
                    .FontBold     = .T.
                    .ForeColor    = RGB(90, 90, 90)
                    .BackColor    = RGB(255, 255, 255)
                    .Themes       = .T.
                    .MousePointer = 15
                    .Visible      = .T.
                ENDWITH
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_OkCopia,       "Click", THIS, "BtnOkCopiaClick")
            BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CancelarCopia, "Click", THIS, "BtnCancelarCopiaClick")

            *-- Grid (top=185, left=11)
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")

            loc_oGrid             = loc_oPagina.grd_4c_Lista
            loc_oGrid.ColumnCount = 8

            WITH loc_oGrid
                .Top                = 185
                .Left               = 11
                .Width              = 895
                .Height             = 390
                .FontName           = "Tahoma"
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

                WITH .Column1
                    .Width           = 110
                    .Header1.Caption = "Usu" + CHR(225) + "rio"
                ENDWITH
                WITH .Column2
                    .Width           = 35
                    .Header1.Caption = "M" + CHR(234) + "s"
                ENDWITH
                WITH .Column3
                    .Width           = 45
                    .Header1.Caption = "Ano"
                ENDWITH
                WITH .Column4
                    .Width           = 20
                    .Header1.Caption = "V"
                ENDWITH
                WITH .Column5
                    .Width           = 160
                    .Header1.Caption = "Cargo"
                ENDWITH
                WITH .Column6
                    .Width           = 70
                    .Alignment       = 2
                    .Header1.Caption = "Adicional"
                ENDWITH
                WITH .Column7
                    .Width           = 100
                    .Alignment       = 2
                    .Header1.Caption = "M" + CHR(237) + "nimo"
                ENDWITH
                WITH .Column8
                    .Width           = 100
                    .Alignment       = 2
                    .Header1.Caption = "Experi" + CHR(234) + "ncia"
                ENDWITH
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarPaginaLista:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2 com todos os campos de SigCcCmI
    *   Usuars (lookup SigCdUsu), Mess, Anos, Indivs, Setors (lookup SigCdCrg),
    *   Adics, Minimos, MinExps + botoes Confirmar/Cancelar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        TRY
            *-- Botoes Acao: Confirmar e Cancelar
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
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH

                .AddObject("cmd_4c_Cancelar", "CommandButton")
                WITH .cmd_4c_Cancelar
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
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

            *-- Label: Usu?rio (layout top=179 +29=208)
            loc_oPagina.AddObject("lbl_4c_Usuars", "Label")
            WITH loc_oPagina.lbl_4c_Usuars
                .Caption   = "Usu" + CHR(225) + "rio :"
                .Top       = 208
                .Left      = 248
                .Width     = 54
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- TextBox: Usu?rio (layout top=176 +29=205)
            loc_oPagina.AddObject("txt_4c_Usuars", "TextBox")
            WITH loc_oPagina.txt_4c_Usuars
                .Value     = ""
                .Top       = 205
                .Left      = 311
                .Width     = 80
                .Height    = 23
                .MaxLength = 10
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.txt_4c_Usuars, "DblClick",  THIS, "AbrirBuscaUsuars")
            BINDEVENT(loc_oPagina.txt_4c_Usuars, "KeyPress",  THIS, "TeclaLookupUsuars")
            BINDEVENT(loc_oPagina.txt_4c_Usuars, "KeyPress", THIS, "ValidarUsuars")

            *-- Label: Per?odo (layout top=204 +29=233)
            loc_oPagina.AddObject("lbl_4c_Periodo2", "Label")
            WITH loc_oPagina.lbl_4c_Periodo2
                .Caption   = "Per" + CHR(237) + "odo :"
                .Top       = 233
                .Left      = 248
                .Width     = 54
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- TextBox: M?s Per?odo (layout top=201 +29=230)
            loc_oPagina.AddObject("txt_4c_Mess", "TextBox")
            WITH loc_oPagina.txt_4c_Mess
                .Value     = ""
                .Top       = 230
                .Left      = 311
                .Width     = 24
                .Height    = 23
                .InputMask = "99"
                .MaxLength = 2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- Separador "/" entre M?s e Ano (layout top=202 +29=231)
            loc_oPagina.AddObject("lbl_4c_BarraMesAno", "Label")
            WITH loc_oPagina.lbl_4c_BarraMesAno
                .Caption   = "/"
                .Top       = 231
                .Left      = 340
                .Width     = 8
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- TextBox: Ano Per?odo (layout top=201 +29=230)
            loc_oPagina.AddObject("txt_4c_Anos", "TextBox")
            WITH loc_oPagina.txt_4c_Anos
                .Value     = ""
                .Top       = 230
                .Left      = 353
                .Width     = 38
                .Height    = 23
                .InputMask = "9999"
                .MaxLength = 4
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- Label: Vendedor (layout top=229 +29=258)
            loc_oPagina.AddObject("lbl_4c_Vendedor", "Label")
            WITH loc_oPagina.lbl_4c_Vendedor
                .Caption   = "Vendedor :"
                .Top       = 258
                .Left      = 236
                .Width     = 66
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- TextBox: Vendedor Individual S/N (layout top=226 +29=255)
            loc_oPagina.AddObject("txt_4c_Indivs", "TextBox")
            WITH loc_oPagina.txt_4c_Indivs
                .Value     = "N"
                .Top       = 255
                .Left      = 311
                .Width     = 17
                .Height    = 23
                .InputMask = "!"
                .MaxLength = 1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- Label: (S/N) (layout top=229 +29=258)
            loc_oPagina.AddObject("lbl_4c_IndivsSN", "Label")
            WITH loc_oPagina.lbl_4c_IndivsSN
                .Caption   = "(S/N)"
                .Top       = 258
                .Left      = 331
                .Width     = 33
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Label: Cargo (layout top=254 +29=283)
            loc_oPagina.AddObject("lbl_4c_Setors", "Label")
            WITH loc_oPagina.lbl_4c_Setors
                .Caption   = "Cargo :"
                .Top       = 283
                .Left      = 256
                .Width     = 46
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- TextBox: Cargo (layout top=251 +29=280)
            loc_oPagina.AddObject("txt_4c_Setors", "TextBox")
            WITH loc_oPagina.txt_4c_Setors
                .Value     = ""
                .Top       = 280
                .Left      = 311
                .Width     = 80
                .Height    = 23
                .MaxLength = 10
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.txt_4c_Setors, "DblClick",  THIS, "AbrirBuscaSetors")
            BINDEVENT(loc_oPagina.txt_4c_Setors, "KeyPress",  THIS, "TeclaLookupSetors")
            BINDEVENT(loc_oPagina.txt_4c_Setors, "KeyPress", THIS, "ValidarSetors")

            *-- Label: Adicional (layout top=278 +29=307)
            loc_oPagina.AddObject("lbl_4c_Adics", "Label")
            WITH loc_oPagina.lbl_4c_Adics
                .Caption   = "Adicional :"
                .Top       = 307
                .Left      = 240
                .Width     = 62
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- TextBox: Adicional % (layout top=275 +29=304)
            loc_oPagina.AddObject("txt_4c_Adics", "TextBox")
            WITH loc_oPagina.txt_4c_Adics
                .Value    = 0.00
                .Top      = 304
                .Left     = 311
                .Width    = 52
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Label: % (layout top=280 +29=309)
            loc_oPagina.AddObject("lbl_4c_PctAdics", "Label")
            WITH loc_oPagina.lbl_4c_PctAdics
                .Caption   = "%"
                .Top       = 309
                .Left      = 368
                .Width     = 14
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Label: M?nimo (layout top=303 +29=332)
            loc_oPagina.AddObject("lbl_4c_Minimos", "Label")
            WITH loc_oPagina.lbl_4c_Minimos
                .Caption   = "M" + CHR(237) + "nimo :"
                .Top       = 332
                .Left      = 251
                .Width     = 51
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- TextBox: M?nimo (layout top=300 +29=329)
            loc_oPagina.AddObject("txt_4c_Minimos", "TextBox")
            WITH loc_oPagina.txt_4c_Minimos
                .Value    = 0.00
                .Top      = 329
                .Left     = 311
                .Width    = 101
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Label: Experi?ncia (layout top=328 +29=357)
            loc_oPagina.AddObject("lbl_4c_MinExps", "Label")
            WITH loc_oPagina.lbl_4c_MinExps
                .Caption   = "Experi" + CHR(234) + "ncia :"
                .Top       = 357
                .Left      = 225
                .Width     = 77
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- TextBox: Experi?ncia m?nima (layout top=325 +29=354)
            loc_oPagina.AddObject("txt_4c_MinExps", "TextBox")
            WITH loc_oPagina.txt_4c_MinExps
                .Value    = 0.00
                .Top      = 354
                .Left     = 311
                .Width    = 101
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPagina)
        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarPaginaDados:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Containers excluidos (mantem Visible original):
    *   cnt_4c_Copia      - container flutuante de copia de periodo (inicia oculto)
    *   cnt_4c_Cabecalho  - cabecalho cinza (Visible gerenciado por ConfigurarPaginaLista)
    *   cnt_4c_BotoesAcao - botoes Confirmar/Cancelar (Visible gerenciado por HabilitarCampos)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                IF INLIST(loc_cNome, "CNT_4C_COPIA", "CNT_4C_CABECALHO", "CNT_4C_BOTOESACAO")
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                    LOOP
                ENDIF

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
    * FormatarGridLista - Formata visual do grid
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega grid com dados de SigCcCmI filtrados por periodo
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        LOCAL loc_cMesI, loc_cMesF, loc_cAnoI, loc_cAnoF
        LOCAL loc_oPagina, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oPagina = THIS.pgf_4c_Paginas.Page1
                loc_oGrid   = loc_oPagina.grd_4c_Lista

                loc_cMesI = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess.Value), 2, "0")
                loc_cAnoI = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.Value), 4, "0")
                loc_cMesF = IIF(loc_cMesI = "00", "12", loc_cMesI)
                loc_cAnoF = IIF(loc_cAnoI = "0000", "9999", loc_cAnoI)

                IF USED("crSigCcCmI")
                    USE IN crSigCcCmI
                ENDIF

                loc_cSQL = "SELECT cIdChaves, Usuars, Mess, Anos, Indivs, Setors," + ;
                           " Adics, Minimos, MinExps" + ;
                           " FROM SigCcCmI" + ;
                           " WHERE Mess BETWEEN " + EscaparSQL(loc_cMesI) + ;
                           " AND " + EscaparSQL(loc_cMesF) + ;
                           " AND Anos BETWEEN " + EscaparSQL(loc_cAnoI) + ;
                           " AND " + EscaparSQL(loc_cAnoF) + ;
                           " ORDER BY Anos, Mess, Usuars, Setors"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmI")

                IF loc_nResult < 0
                    MsgErro("Erro ao carregar comiss" + CHR(245) + "es:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    loc_oGrid.RecordSource           = "crSigCcCmI"
                    loc_oGrid.Column1.ControlSource  = "crSigCcCmI.Usuars"
                    loc_oGrid.Column2.ControlSource  = "crSigCcCmI.Mess"
                    loc_oGrid.Column3.ControlSource  = "crSigCcCmI.Anos"
                    loc_oGrid.Column4.ControlSource  = "crSigCcCmI.Indivs"
                    loc_oGrid.Column5.ControlSource  = "crSigCcCmI.Setors"
                    loc_oGrid.Column6.ControlSource  = "crSigCcCmI.Adics"
                    loc_oGrid.Column7.ControlSource  = "crSigCcCmI.Minimos"
                    loc_oGrid.Column8.ControlSource  = "crSigCcCmI.MinExps"

                    loc_oGrid.Column1.Width           = 110
                    loc_oGrid.Column2.Width           = 35
                    loc_oGrid.Column3.Width           = 45
                    loc_oGrid.Column4.Width           = 20
                    loc_oGrid.Column5.Width           = 160
                    loc_oGrid.Column6.Width           = 70
                    loc_oGrid.Column7.Width           = 100
                    loc_oGrid.Column8.Width           = 100

                    loc_oGrid.Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
                    loc_oGrid.Column2.Header1.Caption = "M" + CHR(234) + "s"
                    loc_oGrid.Column3.Header1.Caption = "Ano"
                    loc_oGrid.Column4.Header1.Caption = "V"
                    loc_oGrid.Column5.Header1.Caption = "Cargo"
                    loc_oGrid.Column6.Header1.Caption = "Adicional"
                    loc_oGrid.Column7.Header1.Caption = "M" + CHR(237) + "nimo"
                    loc_oGrid.Column8.Header1.Caption = "Experi" + CHR(234) + "ncia"

                    loc_oGrid.Column6.Alignment = 2
                    loc_oGrid.Column7.Alignment = 2
                    loc_oGrid.Column8.Alignment = 2

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FiltroMesLostFocus - Ao sair do campo mes, padroniza e foca ano
    *==========================================================================
    PROCEDURE FiltroMesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess.Value = ;
                PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroMess.Value), 2, "0")
            loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.SetFocus
        CATCH TO loc_oErro
            MsgErro("Erro em FiltroMesLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FiltroAnosLostFocus - Ao sair do campo ano, padroniza e recarrega grid
    *==========================================================================
    PROCEDURE FiltroAnosLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.Value = ;
                PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_FiltroAnos.Value), 4, "0")
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro("Erro em FiltroAnosLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara novo registro e navega para Page2
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Usuars.SetFocus
        CATCH TO loc_oErro
            MsgErro("Erro em BtnIncluirClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado e navega para Page2
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave
        TRY
            IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
                MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT crSigCcCmI
                loc_cChave = ALLTRIM(crSigCcCmI.cIdChaves)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Indivs.SetFocus
                ELSE
                    MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o!", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnAlterarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro em modo somente leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave
        TRY
            IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
                MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT crSigCcCmI
                loc_cChave = ALLTRIM(crSigCcCmI.cIdChaves)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                ELSE
                    MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o!", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnVisualizarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Confirma e exclui registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave, loc_lConfirma
        TRY
            IF !USED("crSigCcCmI") OR EOF("crSigCcCmI") OR RECCOUNT("crSigCcCmI") = 0
                MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT crSigCcCmI
                loc_cChave   = ALLTRIM(crSigCcCmI.cIdChaves)
                loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?", ;
                                            "Excluir")

                IF loc_lConfirma
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
                            THIS.CarregarLista()
                        ELSE
                            MsgErro("Erro ao excluir registro!", "Erro")
                        ENDIF
                    ELSE
                        MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o!", "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnExcluirClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega grid com filtro atual
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.CarregarLista()
            IF USED("crSigCcCmI") AND !EOF("crSigCcCmI")
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.SetFocus
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            *-- Ignorar erros ao fechar
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida e salva registro
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "")
                THIS.AlternarPagina(1)
            ELSE
                MsgErro("Erro ao salvar registro!", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnSalvarClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro("Erro em BtnCancelarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCopiarClick - Mostra container de copia de periodo
    *==========================================================================
    PROCEDURE BtnCopiarClick()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            loc_oPagina.grd_4c_Lista.Enabled  = .F.
            loc_oPagina.cnt_4c_Botoes.Enabled = .F.
            loc_oPagina.cnt_4c_Saida.Enabled  = .F.
            loc_oPagina.cmd_4c_Copia.Enabled  = .F.

            WITH loc_oPagina.cnt_4c_Copia
                .txt_4c_OMess.Value = ""
                .txt_4c_OAnos.Value = ""
                .txt_4c_DMess.Value = ""
                .txt_4c_DAnos.Value = ""
                .Visible = .T.
                .ZOrder(0)
                .txt_4c_OMess.SetFocus
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro em BtnCopiarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnOkCopiaClick - Executa copia de todos os registros do periodo origem
    *                   para o periodo destino no SQL Server
    *==========================================================================
    PROCEDURE BtnOkCopiaClick()
        LOCAL loc_oPagina, loc_cOMess, loc_cDMess, loc_cOAnos, loc_cDAnos
        LOCAL loc_nResult, loc_cSQL, loc_lCopiar
        loc_lCopiar = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            loc_cOMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_OMess.Value), 2, "0")
            loc_cOAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_OAnos.Value), 4, "0")
            loc_cDMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_DMess.Value), 2, "0")
            loc_cDAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_DAnos.Value), 4, "0")

            IF EMPTY(loc_cOMess) OR loc_cOMess = "00" OR VAL(loc_cOMess) = 0
                MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
                         "s de Origem!", "")
                loc_oPagina.cnt_4c_Copia.txt_4c_OMess.SetFocus
            ELSE
                IF EMPTY(loc_cOAnos) OR loc_cOAnos = "0000" OR VAL(loc_cOAnos) = 0
                MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Origem!", "")
                loc_oPagina.cnt_4c_Copia.txt_4c_OAnos.SetFocus
            ELSE
                IF EMPTY(loc_cDMess) OR loc_cDMess = "00" OR VAL(loc_cDMess) = 0
                MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
                         "s de Destino!", "")
                loc_oPagina.cnt_4c_Copia.txt_4c_DMess.SetFocus
            ELSE
                IF EMPTY(loc_cDAnos) OR loc_cDAnos = "0000" OR VAL(loc_cDAnos) = 0
                MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Destino!", "")
                loc_oPagina.cnt_4c_Copia.txt_4c_DAnos.SetFocus
            ELSE
                *-- Verificar se destino ja tem registros
                loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCcCmI" + ;
                           " WHERE Mess = " + EscaparSQL(loc_cDMess) + ;
                           " AND Anos = " + EscaparSQL(loc_cDAnos)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifDest")

                IF loc_nResult >= 0 AND USED("cursor_4c_VerifDest") AND ;
                   cursor_4c_VerifDest.Total > 0
                    IF MsgConfirma("O per" + CHR(237) + "odo de destino j" + CHR(225) + ;
                                   " possui registros. Deseja sobrepor?", "Confirmar")
                        loc_lCopiar = .T.
                    ENDIF
                ELSE
                    loc_lCopiar = .T.
                ENDIF

                IF USED("cursor_4c_VerifDest")
                    USE IN cursor_4c_VerifDest
                ENDIF

                IF loc_lCopiar
                    loc_cSQL = "INSERT INTO SigCcCmI" + ;
                               " (cIdChaves, Usuars, Indivs, Setors, Adics, Minimos, MinExps," + ;
                               " Mess, Anos)" + ;
                               " SELECT NEWID(), Usuars, Indivs, Setors, Adics, Minimos, MinExps," + ;
                               " " + EscaparSQL(loc_cDMess) + ", " + EscaparSQL(loc_cDAnos) + ;
                               " FROM SigCcCmI" + ;
                               " WHERE Mess = " + EscaparSQL(loc_cOMess) + ;
                               " AND Anos = " + EscaparSQL(loc_cOAnos) + ;
                               " AND NOT EXISTS (" + ;
                               "   SELECT 1 FROM SigCcCmI d" + ;
                               "   WHERE d.Mess = " + EscaparSQL(loc_cDMess) + ;
                               "   AND d.Anos = " + EscaparSQL(loc_cDAnos) + ;
                               "   AND d.Usuars = SigCcCmI.Usuars)"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CopRes")

                    IF loc_nResult >= 0
                        MsgInfo("Per" + CHR(237) + "odo copiado com sucesso!", "")
                        THIS.BtnCancelarCopiaClick()
                        THIS.CarregarLista()
                    ELSE
                        MsgErro("Erro ao copiar per" + CHR(237) + "odo: " + ;
                                CapturarErroSQL(), "Erro SQL")
                    ENDIF

                    IF USED("cursor_4c_CopRes")
                        USE IN cursor_4c_CopRes
                    ENDIF
                ENDIF
                ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnOkCopiaClick:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            IF USED("cursor_4c_VerifDest")
                USE IN cursor_4c_VerifDest
            ENDIF
            IF USED("cursor_4c_CopRes")
                USE IN cursor_4c_CopRes
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarCopiaClick - Oculta container de copia e reabilita area
    *==========================================================================
    PROCEDURE BtnCancelarCopiaClick()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            loc_oPagina.cnt_4c_Copia.Visible  = .F.
            loc_oPagina.grd_4c_Lista.Enabled  = .T.
            loc_oPagina.cnt_4c_Botoes.Enabled = .T.
            loc_oPagina.cnt_4c_Saida.Enabled  = .T.
            loc_oPagina.cmd_4c_Copia.Enabled  = .T.

            IF USED("crSigCcCmI")
                loc_oPagina.grd_4c_Lista.SetFocus
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnCancelarCopiaClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oPagina.txt_4c_Usuars.Value  = ""
            loc_oPagina.txt_4c_Mess.Value    = ""
            loc_oPagina.txt_4c_Anos.Value    = ""
            loc_oPagina.txt_4c_Indivs.Value  = "N"
            loc_oPagina.txt_4c_Setors.Value  = ""
            loc_oPagina.txt_4c_Adics.Value   = 0.00
            loc_oPagina.txt_4c_Minimos.Value = 0.00
            loc_oPagina.txt_4c_MinExps.Value = 0.00
        CATCH TO loc_oErro
            MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita todos os campos editaveis da Page2
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oPagina.txt_4c_Usuars.Enabled  = par_lHabilitar
            loc_oPagina.txt_4c_Mess.Enabled    = par_lHabilitar
            loc_oPagina.txt_4c_Anos.Enabled    = par_lHabilitar
            loc_oPagina.txt_4c_Indivs.Enabled  = par_lHabilitar
            loc_oPagina.txt_4c_Setors.Enabled  = par_lHabilitar
            loc_oPagina.txt_4c_Adics.Enabled   = par_lHabilitar
            loc_oPagina.txt_4c_Minimos.Enabled = par_lHabilitar
            loc_oPagina.txt_4c_MinExps.Enabled = par_lHabilitar
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .cmd_4c_Confirmar.Enabled = par_lHabilitar
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEditar
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

            WITH loc_oPagina.cnt_4c_BotoesAcao
                .cmd_4c_Confirmar.Enabled = loc_lEditar
                .cmd_4c_Cancelar.Enabled  = .T.
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lResultado, loc_oPagina, loc_oBO
        loc_lResultado = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oBO     = THIS.this_oBusinessObject

            loc_oPagina.txt_4c_Usuars.Value  = ALLTRIM(loc_oBO.this_cUsuars)
            loc_oPagina.txt_4c_Mess.Value    = ALLTRIM(loc_oBO.this_cMess)
            loc_oPagina.txt_4c_Anos.Value    = ALLTRIM(loc_oBO.this_cAnos)
            loc_oPagina.txt_4c_Indivs.Value  = IIF(EMPTY(ALLTRIM(loc_oBO.this_cIndivs)), ;
                                                    "N", UPPER(ALLTRIM(loc_oBO.this_cIndivs)))
            loc_oPagina.txt_4c_Setors.Value  = ALLTRIM(loc_oBO.this_cSetors)
            loc_oPagina.txt_4c_Adics.Value   = loc_oBO.this_nAdics
            loc_oPagina.txt_4c_Minimos.Value = loc_oBO.this_nMinimos
            loc_oPagina.txt_4c_MinExps.Value = loc_oBO.this_nMinExps

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormParaBO - Valida campos da Page2 e transfere para o BO
    * Retorna .T. se valido, .F. se ha erro de validacao
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lResultado, loc_oPagina, loc_oBO
        LOCAL loc_cUsuars, loc_cMess, loc_cAnos, loc_cIndivs, loc_cSetors
        LOCAL loc_cMsgDupI, loc_cMsgDupV
        loc_lResultado = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oBO     = THIS.this_oBusinessObject

            loc_cUsuars = UPPER(ALLTRIM(loc_oPagina.txt_4c_Usuars.Value))
            loc_cMess   = PADL(ALLTRIM(loc_oPagina.txt_4c_Mess.Value),  2, "0")
            loc_cAnos   = PADL(ALLTRIM(loc_oPagina.txt_4c_Anos.Value),  4, "0")
            loc_cIndivs = UPPER(ALLTRIM(loc_oPagina.txt_4c_Indivs.Value))
            loc_cSetors = UPPER(ALLTRIM(loc_oPagina.txt_4c_Setors.Value))

            IF EMPTY(loc_cUsuars)
                MsgAviso("Obrigat" + CHR(243) + "rio informar o Usu" + CHR(225) + "rio!!!", "")
                loc_oPagina.txt_4c_Usuars.SetFocus
            ELSE
                IF EMPTY(loc_cMess) OR loc_cMess = "00" OR VAL(loc_cMess) = 0
                MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
                         "s de Refer" + CHR(234) + "ncia!!!", "")
                loc_oPagina.txt_4c_Mess.SetFocus
            ELSE
                IF EMPTY(loc_cAnos) OR loc_cAnos = "0000" OR VAL(loc_cAnos) = 0
                MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Refer" + CHR(234) + ;
                         "ncia!!!", "")
                loc_oPagina.txt_4c_Anos.SetFocus
            ELSE
                IF !EMPTY(loc_cIndivs) AND !INLIST(loc_cIndivs, "S", "N")
                MsgAviso("Vendedor deve ser S ou N!!!", "")
                loc_oPagina.txt_4c_Indivs.SetFocus
            ELSE
                loc_oBO.this_cUsuars    = loc_cUsuars
                loc_oBO.this_cMess      = loc_cMess
                loc_oBO.this_cAnos      = loc_cAnos
                loc_oBO.this_cIndivs    = IIF(EMPTY(loc_cIndivs), "N", loc_cIndivs)
                loc_oBO.this_cSetors    = loc_cSetors
                loc_oBO.this_nAdics     = loc_oPagina.txt_4c_Adics.Value
                loc_oBO.this_nMinimos   = loc_oPagina.txt_4c_Minimos.Value
                loc_oBO.this_nMinExps   = loc_oPagina.txt_4c_MinExps.Value

                loc_cMsgDupI = loc_oBO.ValidarDuplicidadeEmSigCcCmI()
                IF !EMPTY(loc_cMsgDupI)
                    MsgAviso(loc_cMsgDupI, "")
                ELSE
                    loc_cMsgDupV = loc_oBO.ValidarDuplicidadeEmSigCcCmV()
                    IF !EMPTY(loc_cMsgDupV)
                        MsgAviso(loc_cMsgDupV, "")
                    ELSE
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
                ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AbrirBuscaUsuars - Abre picker FormBuscaAuxiliar para SigCdUsu
    *==========================================================================
    PROCEDURE AbrirBuscaUsuars()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Usuars.Value))

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                      "SigCdUsu", "cursor_4c_BuscaUsu", ;
                                      "Usuarios", loc_cValor, ;
                                      "Busca de Usu" + CHR(225) + "rios")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                    THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_BuscaUsu.Usuarios))
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Usuarios", "", "Usu" + CHR(225) + "rio")
                    loc_oBusca.mAddColuna("NComps",   "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                        loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                        THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_BuscaUsu.Usuarios))
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaUsu")
                USE IN cursor_4c_BuscaUsu
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirBuscaUsuars:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_BuscaUsu")
                USE IN cursor_4c_BuscaUsu
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * TeclaLookupUsuars - Dispara AbrirBuscaUsuars com F4 ou F5
    *==========================================================================
    PROCEDURE TeclaLookupUsuars(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaUsuars()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarUsuars - Valida codigo de usuario ao sair do campo
    *==========================================================================
    PROCEDURE ValidarUsuars(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResultado
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Usuars.Value))

            IF EMPTY(loc_cValor)
                RETURN
            ENDIF

            loc_cSQL       = "SELECT Usuars, NComps FROM SigCdUsu" + ;
                             " WHERE Usuars = " + EscaparSQL(loc_cValor)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValUsu")

            IF loc_nResultado > 0 AND USED("cursor_4c_ValUsu") AND ;
               RECCOUNT("cursor_4c_ValUsu") > 0
                loc_oPagina.txt_4c_Usuars.Value = ALLTRIM(cursor_4c_ValUsu.Usuars)
                THIS.PreencherPeriodoDoUsuario(ALLTRIM(cursor_4c_ValUsu.Usuars))
            ELSE
                IF USED("cursor_4c_ValUsu")
                    USE IN cursor_4c_ValUsu
                ENDIF
                *-- MsgAviso + clear-field removidos (Pattern #114): abrir picker direto preserva valor digitado para LIKE prefix
                THIS.AbrirBuscaUsuars()
                RETURN
            ENDIF

            IF USED("cursor_4c_ValUsu")
                USE IN cursor_4c_ValUsu
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ValidarUsuars:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValUsu")
                USE IN cursor_4c_ValUsu
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * PreencherPeriodoDoUsuario - Ao selecionar usuario sem periodo preenchido,
    * carrega o ultimo periodo cadastrado para ele (auto-preenchimento)
    *==========================================================================
    PROTECTED PROCEDURE PreencherPeriodoDoUsuario(par_cUsuars)
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Mess.Value)) OR ;
               ALLTRIM(loc_oPagina.txt_4c_Mess.Value) = "00"

                IF THIS.this_oBusinessObject.CarregarUltimoPeriodoUsuario(par_cUsuars)
                    IF USED("cursor_4c_UltPer") AND RECCOUNT("cursor_4c_UltPer") > 0
                        SELECT cursor_4c_UltPer
                        loc_oPagina.txt_4c_Mess.Value   = ALLTRIM(cursor_4c_UltPer.mess)
                        loc_oPagina.txt_4c_Anos.Value   = ALLTRIM(cursor_4c_UltPer.anos)
                        loc_oPagina.txt_4c_Indivs.Value = IIF(EMPTY(cursor_4c_UltPer.indivs), ;
                                                              "N", UPPER(cursor_4c_UltPer.indivs))
                        loc_oPagina.txt_4c_Setors.Value  = ALLTRIM(cursor_4c_UltPer.setors)
                        loc_oPagina.txt_4c_Adics.Value   = cursor_4c_UltPer.adics
                        loc_oPagina.txt_4c_Minimos.Value = cursor_4c_UltPer.minimos
                        loc_oPagina.txt_4c_MinExps.Value = cursor_4c_UltPer.minexps
                    ENDIF
                    IF USED("cursor_4c_UltPer")
                        USE IN cursor_4c_UltPer
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em PreencherPeriodoDoUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_UltPer")
                USE IN cursor_4c_UltPer
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaSetors - Abre picker FormBuscaAuxiliar para SigCdCrg (Cargos)
    *==========================================================================
    PROCEDURE AbrirBuscaSetors()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Setors.Value))

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                      "SigCdCrg", "cursor_4c_BuscaCrg", ;
                                      "CCargs", loc_cValor, ;
                                      "Busca de Cargos")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    loc_oPagina.txt_4c_Setors.Value = ALLTRIM(cursor_4c_BuscaCrg.CCargs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CCargs", "", "Cargo")
                    loc_oBusca.mAddColuna("DCargs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCrg")
                        loc_oPagina.txt_4c_Setors.Value = ALLTRIM(cursor_4c_BuscaCrg.CCargs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCrg")
                USE IN cursor_4c_BuscaCrg
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirBuscaSetors:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_BuscaCrg")
                USE IN cursor_4c_BuscaCrg
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * TeclaLookupSetors - Dispara AbrirBuscaSetors com F4 ou F5
    *==========================================================================
    PROCEDURE TeclaLookupSetors(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaSetors()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarSetors - Valida codigo de cargo ao sair do campo
    *==========================================================================
    PROCEDURE ValidarSetors(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cValor
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Setors.Value))

            IF EMPTY(loc_cValor)
                RETURN
            ENDIF

            THIS.AbrirBuscaSetors()
        CATCH TO loc_oErro
            MsgErro("Erro em ValidarSetors:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("crSigCcCmI")
                USE IN crSigCcCmI
            ENDIF
            IF USED("cursor_4c_VerifDest")
                USE IN cursor_4c_VerifDest
            ENDIF
            IF USED("cursor_4c_CopRes")
                USE IN cursor_4c_CopRes
            ENDIF
            IF USED("cursor_4c_BuscaUsu")
                USE IN cursor_4c_BuscaUsu
            ENDIF
            IF USED("cursor_4c_ValUsu")
                USE IN cursor_4c_ValUsu
            ENDIF
            IF USED("cursor_4c_BuscaCrg")
                USE IN cursor_4c_BuscaCrg
            ENDIF
            IF USED("cursor_4c_UltPer")
                USE IN cursor_4c_UltPer
            ENDIF
        CATCH TO loc_oErro
            *-- Ignorar erros no Destroy
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\CVEBO.prg):
*==============================================================================
* CVEBO.prg - Business Object para Comissoes de Vendedores por Cargos
* Tabela: SigCcCmI (Comissoes por Cargo - Inidividual)
* Chave:  cidchaves CHAR(20) - PK unica gerada por fUniqueIds()
*==============================================================================

DEFINE CLASS CVEBO AS BusinessBase

	*--------------------------------------------------------------------------
	* Propriedades da entidade (SigCcCmI)
	*--------------------------------------------------------------------------

	*-- PK
	this_cCidchaves  = ""  && cidchaves char(20) - chave prim" + CHR(225) + "ria UUID

	*-- Identificacao do usuario e periodo
	this_cUsuars     = ""  && usuars   char(10) - usu" + CHR(225) + "rio
	this_cMess       = ""  && mess     char(2)  - m" + CHR(234) + "s de refer" + CHR(234) + "ncia (01-12)
	this_cAnos       = ""  && anos     char(4)  - ano de refer" + CHR(234) + "ncia (0001-9999)
	this_cIndivs     = ""  && indivs   char(1)  - vendedor individual (S/N)

	*-- Cargo e supervisor
	this_cSetors     = ""  && setors   char(10) - c" + CHR(243) + "digo do cargo (FK SigCdCrg.CCargs)
	this_cSupervs    = ""  && supervs  char(10) - supervisor do setor

	*-- Valores de comiss" + CHR(227) + "o
	this_nAdics      = 0   && adics    numeric(5,2)  - adicional (%)
	this_nMinimos    = 0   && minimos  numeric(11,2) - valor m" + CHR(237) + "nimo
	this_nMinExps    = 0   && minexps  numeric(11,2) - experi" + CHR(234) + "ncia m" + CHR(237) + "nima

	*==========================================================================
	* Init - Configura tabela e campo-chave
	*==========================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCcCmI"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*==========================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*==========================================================================
	PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidchaves
	ENDPROC

	*==========================================================================
	* CarregarDoCursor - Carrega propriedades a partir de um cursor
	*==========================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
				THIS.this_cUsuars    = TratarNulo(usuars,    "C")
				THIS.this_cMess      = TratarNulo(mess,      "C")
				THIS.this_cAnos      = TratarNulo(anos,      "C")
				THIS.this_cIndivs    = TratarNulo(indivs,    "C")
				THIS.this_cSetors    = TratarNulo(setors,    "C")
				THIS.this_cSupervs   = TratarNulo(supervs,   "C")
				THIS.this_nAdics     = TratarNulo(adics,     "N")
				THIS.this_nMinimos   = TratarNulo(minimos,   "N")
				THIS.this_nMinExps   = TratarNulo(minexps,   "N")
				loc_lResultado = .T.
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarDoCursor: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*==========================================================================
	* Buscar - Retorna registros de SigCcCmI filtrados por periodo
	* par_cFiltro: "MM/AAAA" ou "MM/MMFINAL-AAAA/AAAFINAL" ou "" (todos)
	*==========================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		LOCAL loc_cMesIni, loc_cMesFin, loc_cAnoIni, loc_cAnoFin
		loc_lSucesso = .F.

		TRY
			*-- Por default filtra pelo mes/ano atual
			loc_cMesIni = SUBSTR(DTOS(DATE()), 5, 2)
			loc_cMesFin = loc_cMesIni
			loc_cAnoIni = SUBSTR(DTOS(DATE()), 1, 4)
			loc_cAnoFin = loc_cAnoIni

			IF !EMPTY(par_cFiltro)
				*-- Aceita filtro no formato "MM/AAAA"
				IF LEN(ALLTRIM(par_cFiltro)) >= 7
					loc_cMesIni = LEFT(ALLTRIM(par_cFiltro), 2)
					loc_cMesFin = loc_cMesIni
					loc_cAnoIni = RIGHT(ALLTRIM(par_cFiltro), 4)
					loc_cAnoFin = loc_cAnoIni
				ENDIF
			ELSE
				*-- Sem filtro: trazer todos
				loc_cMesIni = "01"
				loc_cMesFin = "12"
				loc_cAnoIni = "0001"
				loc_cAnoFin = "9999"
			ENDIF

			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE mess BETWEEN " + EscaparSQL(loc_cMesIni) + ;
			           " AND " + EscaparSQL(loc_cMesFin) + ;
			           " AND anos BETWEEN " + EscaparSQL(loc_cAnoIni) + ;
			           " AND " + EscaparSQL(loc_cAnoFin) + ;
			           " ORDER BY usuars, anos, mess"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmI")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar comiss" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Buscar: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* BuscarComFiltroPeriodo - Busca com mes/ano de filtro explicitoS
	*==========================================================================
	PROCEDURE BuscarComFiltroPeriodo(par_cMesIni, par_cMesFin, par_cAnoIni, par_cAnoFin)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE mess BETWEEN " + EscaparSQL(par_cMesIni) + ;
			           " AND " + EscaparSQL(par_cMesFin) + ;
			           " AND anos BETWEEN " + EscaparSQL(par_cAnoIni) + ;
			           " AND " + EscaparSQL(par_cAnoFin) + ;
			           " ORDER BY usuars, anos, mess"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmI")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar comiss" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em BuscarComFiltroPeriodo: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CarregarPorCodigo - Carrega comissao pela chave primaria (cidchaves)
	*==========================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ENDIF
				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MsgErro("Erro ao carregar comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Inserir - Insere novo registro em SigCcCmI (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Gerar UUID via SQL Server (fUniqueIds nao portada)
			IF EMPTY(THIS.this_cCidchaves)
				loc_nResultado = SQLEXEC(gnConnHandle, "SELECT NEWID() AS NovaChave", ;
				                         "cursor_4c_NovaChave")
				IF loc_nResultado >= 0 AND USED("cursor_4c_NovaChave") AND ;
				   RECCOUNT("cursor_4c_NovaChave") > 0
					THIS.this_cCidchaves = ALLTRIM(cursor_4c_NovaChave.NovaChave)
				ENDIF
				IF USED("cursor_4c_NovaChave")
					USE IN cursor_4c_NovaChave
				ENDIF
				IF EMPTY(THIS.this_cCidchaves)
					MsgErro("Erro ao gerar chave prim" + CHR(225) + "ria!", "Erro")
				ELSE
					loc_cSQL = "INSERT INTO SigCcCmI" + ;
					           " (cidchaves, usuars, mess, anos, indivs," + ;
					           "  setors, supervs, adics, minimos, minexps)" + ;
					           " VALUES (" + ;
					           EscaparSQL(THIS.this_cCidchaves) + ", " + ;
					           EscaparSQL(THIS.this_cUsuars)    + ", " + ;
					           EscaparSQL(THIS.this_cMess)      + ", " + ;
					           EscaparSQL(THIS.this_cAnos)      + ", " + ;
					           EscaparSQL(THIS.this_cIndivs)    + ", " + ;
					           EscaparSQL(THIS.this_cSetors)    + ", " + ;
					           EscaparSQL(THIS.this_cSupervs)   + ", " + ;
					           FormatarNumeroSQL(THIS.this_nAdics)   + ", " + ;
					           FormatarNumeroSQL(THIS.this_nMinimos) + ", " + ;
					           FormatarNumeroSQL(THIS.this_nMinExps) + ")"

					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("INSERT")
						loc_lSucesso = .T.
					ELSE
						MsgErro("Erro ao inserir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ELSE
				loc_cSQL = "INSERT INTO SigCcCmI" + ;
				           " (cidchaves, usuars, mess, anos, indivs," + ;
				           "  setors, supervs, adics, minimos, minexps)" + ;
				           " VALUES (" + ;
				           EscaparSQL(THIS.this_cCidchaves) + ", " + ;
				           EscaparSQL(THIS.this_cUsuars)    + ", " + ;
				           EscaparSQL(THIS.this_cMess)      + ", " + ;
				           EscaparSQL(THIS.this_cAnos)      + ", " + ;
				           EscaparSQL(THIS.this_cIndivs)    + ", " + ;
				           EscaparSQL(THIS.this_cSetors)    + ", " + ;
				           EscaparSQL(THIS.this_cSupervs)   + ", " + ;
				           FormatarNumeroSQL(THIS.this_nAdics)   + ", " + ;
				           FormatarNumeroSQL(THIS.this_nMinimos) + ", " + ;
				           FormatarNumeroSQL(THIS.this_nMinExps) + ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("INSERT")
					loc_lSucesso = .T.
				ELSE
					MsgErro("Erro ao inserir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Inserir: " + loException.Message, "Erro")
			IF USED("cursor_4c_NovaChave")
				USE IN cursor_4c_NovaChave
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Atualizar - Atualiza registro em SigCcCmI (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCcCmI SET" + ;
			           "  usuars  = " + EscaparSQL(THIS.this_cUsuars)            + ", " + ;
			           "  mess    = " + EscaparSQL(THIS.this_cMess)              + ", " + ;
			           "  anos    = " + EscaparSQL(THIS.this_cAnos)              + ", " + ;
			           "  indivs  = " + EscaparSQL(THIS.this_cIndivs)            + ", " + ;
			           "  setors  = " + EscaparSQL(THIS.this_cSetors)            + ", " + ;
			           "  supervs = " + EscaparSQL(THIS.this_cSupervs)           + ", " + ;
			           "  adics   = " + FormatarNumeroSQL(THIS.this_nAdics)      + ", " + ;
			           "  minimos = " + FormatarNumeroSQL(THIS.this_nMinimos)    + ", " + ;
			           "  minexps = " + FormatarNumeroSQL(THIS.this_nMinExps)    + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ExecutarExclusao - Exclui registro de SigCcCmI (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCcCmI" + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir comiss" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ValidarDuplicidadeEmSigCcCmI - Verifica se usuario ja existe no periodo
	* Retorna "" se ok, mensagem de erro se duplicado
	*==========================================================================
	PROCEDURE ValidarDuplicidadeEmSigCcCmI()
		LOCAL loc_cSQL, loc_nResultado, loc_cErro
		loc_cErro = ""

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
			           " AND mess = " + EscaparSQL(THIS.this_cMess) + ;
			           " AND anos = " + EscaparSQL(THIS.this_cAnos) + ;
			           " AND cidchaves <> " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupI")
			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_DupI") > 0
					loc_cErro = "Usu" + CHR(225) + "rio J" + CHR(225) + ;
					            " Cadastrado No Per" + CHR(237) + "odo!!!"
				ENDIF
				IF USED("cursor_4c_DupI")
					USE IN cursor_4c_DupI
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ValidarDuplicidadeEmSigCcCmI: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_cErro
	ENDPROC

	*==========================================================================
	* ValidarDuplicidadeEmSigCcCmV - Verifica se usuario ja existe em SigCcCmV
	* (tabela de vendedores individuais) para o mesmo periodo
	*==========================================================================
	PROCEDURE ValidarDuplicidadeEmSigCcCmV()
		LOCAL loc_cSQL, loc_nResultado, loc_cErro
		loc_cErro = ""

		TRY
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos" + ;
			           " FROM SigCcCmV" + ;
			           " WHERE usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
			           " AND mess = " + EscaparSQL(THIS.this_cMess) + ;
			           " AND anos = " + EscaparSQL(THIS.this_cAnos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupV")
			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_DupV") > 0
					loc_cErro = "Usu" + CHR(225) + "rio J" + CHR(225) + ;
					            " Cadastrado No Per" + CHR(237) + "odo Como Vendedor Individual!!!"
				ENDIF
				IF USED("cursor_4c_DupV")
					USE IN cursor_4c_DupV
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ValidarDuplicidadeEmSigCcCmV: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_cErro
	ENDPROC

	*==========================================================================
	* CarregarUltimoPeriodoUsuario - Carrega o ultimo periodo cadastrado para
	* o usuario (usado para auto-preencher o periodo seguinte em novos registros)
	*==========================================================================
	PROCEDURE CarregarUltimoPeriodoUsuario(par_cUsuars)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT TOP 1 cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE usuars = " + EscaparSQL(ALLTRIM(par_cUsuars)) + ;
			           " ORDER BY anos DESC, mess DESC"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltPer")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_UltPer") > 0
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarUltimoPeriodoUsuario: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CopiarPeriodo - Copia registros de um periodo para outro
	* par_cMesOri/par_cAnoOri: periodo de origem
	* par_cMesDes/par_cAnoDes: periodo de destino
	* Retorna .T. se copiou registros, .F. caso contrario
	*==========================================================================
	PROCEDURE CopiarPeriodo(par_cMesOri, par_cAnoOri, par_cMesDes, par_cAnoDes)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lInseriu, loc_lOk
		LOCAL loc_cNovaChave, loc_cErroCopia
		loc_lSucesso = .F.
		loc_lInseriu = .F.
		loc_lOk      = .T.

		TRY
			*-- Busca registros do periodo de origem
			loc_cSQL = "SELECT cidchaves, usuars, mess, anos, indivs," + ;
			           " setors, supervs, adics, minimos, minexps" + ;
			           " FROM SigCcCmI" + ;
			           " WHERE mess = " + EscaparSQL(par_cMesOri) + ;
			           " AND anos = " + EscaparSQL(par_cAnoOri) + ;
			           " ORDER BY usuars"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Origem")
			IF loc_nResultado < 0
				MsgErro("Erro ao buscar per" + CHR(237) + "odo de origem: " + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF RECCOUNT("cursor_4c_Origem") = 0
					MsgAviso("Nenhum Vendedor Est" + CHR(225) + " Cadastrado no Per" + ;
					        CHR(237) + "odo de Origem Informado!!!", "")
				ELSE
					SELECT cursor_4c_Origem
					GO TOP
					SCAN
						*-- Verifica se vendedor ja existe no periodo destino
						loc_cSQL = "SELECT cidchaves FROM SigCcCmI" + ;
						           " WHERE usuars = " + EscaparSQL(cursor_4c_Origem.usuars) + ;
						           " AND mess = " + EscaparSQL(par_cMesDes) + ;
						           " AND anos = " + EscaparSQL(par_cAnoDes)

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Busca")
						IF loc_nResultado >= 0
							IF RECCOUNT("cursor_4c_Busca") = 0
								*-- Insere novo registro no periodo destino
								loc_cNovaChave = fUniqueIds()
								loc_cSQL = "INSERT INTO SigCcCmI" + ;
								           " (cidchaves, usuars, mess, anos, indivs," + ;
								           "  setors, supervs, adics, minimos, minexps)" + ;
								           " VALUES (" + ;
								           EscaparSQL(loc_cNovaChave)                    + ", " + ;
								           EscaparSQL(cursor_4c_Origem.usuars)           + ", " + ;
								           EscaparSQL(par_cMesDes)                       + ", " + ;
								           EscaparSQL(par_cAnoDes)                       + ", " + ;
								           EscaparSQL(cursor_4c_Origem.indivs)           + ", " + ;
								           EscaparSQL(cursor_4c_Origem.setors)           + ", " + ;
								           EscaparSQL(cursor_4c_Origem.supervs)          + ", " + ;
								           FormatarNumeroSQL(cursor_4c_Origem.adics)     + ", " + ;
								           FormatarNumeroSQL(cursor_4c_Origem.minimos)   + ", " + ;
								           FormatarNumeroSQL(cursor_4c_Origem.minexps)   + ")"

								loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
								IF loc_nResultado >= 0
									loc_lInseriu = .T.
								ELSE
									loc_lOk = .F.
								ENDIF
							ENDIF
							IF USED("cursor_4c_Busca")
								USE IN cursor_4c_Busca
							ENDIF
						ELSE
							loc_lOk = .F.
						ENDIF
					ENDSCAN

					loc_lSucesso = loc_lInseriu AND loc_lOk
				ENDIF
			ENDIF

			IF USED("cursor_4c_Origem")
				USE IN cursor_4c_Origem
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CopiarPeriodo: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

