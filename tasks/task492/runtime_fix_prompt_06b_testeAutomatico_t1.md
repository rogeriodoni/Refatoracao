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
[22/08/2026 03:54:47 PM] FormOTI.InicializarForm: Property TABSTYLE is read-only.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-22 15:53:19] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-22 15:53:19] [INFO] Config FPW: (nao fornecido)
[2026-08-22 15:53:19] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 15:53:19] [INFO] Timeout: 300 segundos
[2026-08-22 15:53:19] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fzjkirjs.prg
[2026-08-22 15:53:19] [INFO] Conteudo do wrapper:
[2026-08-22 15:53:19] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormOTI', 'C:\4c\tasks\task492', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormOTI', 'C:\4c\tasks\task492', 'CRUD'
QUIT

[2026-08-22 15:53:19] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fzjkirjs.prg
[2026-08-22 15:53:19] [INFO] VFP output esperado em: C:\4c\tasks\task492\vfp_output.txt
[2026-08-22 15:53:19] [INFO] Executando Visual FoxPro 9...
[2026-08-22 15:53:19] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fzjkirjs.prg
[2026-08-22 15:53:19] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fzjkirjs.prg
[2026-08-22 15:53:19] [INFO] Timeout configurado: 300 segundos
[2026-08-22 15:54:47] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-22 15:54:47] [INFO] VFP9 finalizado em 88.0272338 segundos
[2026-08-22 15:54:47] [INFO] Exit Code: 
[2026-08-22 15:54:47] [INFO] 
[2026-08-22 15:54:47] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-22 15:54:47] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fzjkirjs.prg
[2026-08-22 15:54:47] [INFO] 
[2026-08-22 15:54:47] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-22 15:54:47] [INFO] * Auto-generated wrapper for parameters
[2026-08-22 15:54:47] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 15:54:47] [INFO] * Parameters: 'FormOTI', 'C:\4c\tasks\task492', 'CRUD'
[2026-08-22 15:54:47] [INFO] 
[2026-08-22 15:54:47] [INFO] * Anti-dialog protections for unattended execution
[2026-08-22 15:54:47] [INFO] SET SAFETY OFF
[2026-08-22 15:54:47] [INFO] SET RESOURCE OFF
[2026-08-22 15:54:47] [INFO] SET TALK OFF
[2026-08-22 15:54:47] [INFO] SET NOTIFY OFF
[2026-08-22 15:54:47] [INFO] SYS(2335, 0)
[2026-08-22 15:54:47] [INFO] 
[2026-08-22 15:54:47] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormOTI', 'C:\4c\tasks\task492', 'CRUD'
[2026-08-22 15:54:47] [INFO] QUIT
[2026-08-22 15:54:47] [INFO] 
[2026-08-22 15:54:47] [INFO] === Fim do Wrapper.prg ===
[2026-08-22 15:54:47] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormOTI",
  "timestamp": "20260822155447",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOTI.prg):
*==============================================================================
* FormOTI.prg - Formul" + CHR(225) + "rio de Cadastro de Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos
* Migrado de: sigCDOTI.SCX (SIGCDOTI / frmcadastro)
* Tabela: SigOpOpe
*==============================================================================

DEFINE CLASS FormOTI AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Business Object e estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.Caption = "Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos"

            THIS.this_oBusinessObject = CREATEOBJECT("OTIBO")

            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao instanciar OTIBO.", "FormOTI")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") # "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.InicializarForm")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 2
        loc_oPgf.Top       = -29
        loc_oPgf.Left      = 0
        loc_oPgf.Width     = THIS.Width
        loc_oPgf.Height    = THIS.Height
        loc_oPgf.Tabs      = .F.
        loc_oPgf.TabStyle  = 0
        loc_oPgf.Visible   = .T.

        WITH loc_oPgf.Page1
            .Caption = "Lista"
            .Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        WITH loc_oPgf.Page2
            .Caption = "Dados"
            .Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *==========================================================================
        LOCAL loc_oPagina, loc_oCab, loc_oCnt, loc_oGrid

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPagina.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Top       = 16
            .Left      = 11
            .Width     = 869
            .Height    = 46
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Top       = 15
            .Left      = 10
            .Width     = 869
            .Height    = 46
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        loc_oCnt = loc_oPagina.cnt_4c_Botoes
        WITH loc_oCnt
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Incluir
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
        BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Visualizar
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
        BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Alterar
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
        BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Excluir
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
        BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Buscar
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
        BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container saida (padrao canonico)
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
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top         = 117
        loc_oGrid.Left        = 12
        loc_oGrid.Width       = 895
        loc_oGrid.Height      = 483
        loc_oGrid.ColumnCount = 3
        WITH loc_oGrid
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

        WITH loc_oGrid.Column1
            .Width           = 60
            .Alignment       = 0
            .Header1.Caption = "N" + CHR(186)
            .Resizable       = .T.
        ENDWITH

        WITH loc_oGrid.Column2
            .Width           = 250
            .Alignment       = 0
            .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Resizable       = .T.
        ENDWITH

        WITH loc_oGrid.Column3
            .Width           = 80
            .Alignment       = 0
            .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .Resizable       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *==========================================================================
        LOCAL loc_oPagina

        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        *-- Container bot" + CHR(245) + "es Confirmar / Cancelar
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        *-- Linha 1: N" + CHR(186) + " Opera" + CHR(231) + CHR(227) + "o (readonly) + Descri" + CHR(231) + CHR(227) + "o + Cancelamento
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("txt_4c_Ndope", "TextBox")
        WITH loc_oPagina.txt_4c_Ndope
            .Value    = 0
            .Top      = 65
            .Left     = 688
            .Width    = 80
            .Height   = 23
            .ReadOnly = .T.
            .Enabled  = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "N" + CHR(186) + " Opera" + CHR(231) + CHR(227) + "o :"
            .Top       = 69
            .Left      = 605
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_Chk_Inativar", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_Inativar
            .Caption   = "Cancelamento"
            .Top       = 70
            .Left      = 298
            .Width     = 99
            .Height    = 15
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.chk_4c_Chk_Inativar, "InteractiveChange", THIS, "ChkInativarChanged")

        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 71
            .Left      = 73
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dope", "TextBox")
        WITH loc_oPagina.txt_4c_Dope
            .Value     = ""
            .Top       = 67
            .Left      = 140
            .Width     = 150
            .Height    = 23
            .MaxLength = 50
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 2: Opera" + CHR(231) + CHR(227) + "o CR/DB + Opera" + CHR(231) + CHR(227) + "o de Dep" + CHR(243) + "sito
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Top       = 93
            .Left      = 77
            .Width     = 59
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opcao_oper", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opcao_oper
            .ButtonCount = 2
            .Top         = 90
            .Left        = 135
            .Width       = 142
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opcao_oper.Buttons(1)
            .Caption   = "Cr" + CHR(233) + "dito"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 62
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opcao_oper.Buttons(2)
            .Caption   = "D" + CHR(233) + "bito"
            .BackStyle = 0
            .Left      = 70
            .Top       = 3
            .Width     = 62
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Dep" + CHR(243) + "sito :"
            .Top       = 94
            .Left      = 567
            .Width     = 116
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Opdepo", "TextBox")
        WITH loc_oPagina.txt_4c_Opdepo
            .Value     = ""
            .Top       = 90
            .Left      = 688
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Opdepo, "KeyPress", THIS, "ValidarOpdepo")

        *----------------------------------------------------------------------
        *-- Linha 3: Hist" + CHR(243) + "rico Padr" + CHR(227) + "o + Pend" + CHR(234) + "ncias
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Hist" + CHR(243) + "rico Padr" + CHR(227) + "o :"
            .Top       = 113
            .Left      = 49
            .Width     = 87
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Hists", "TextBox")
        WITH loc_oPagina.txt_4c_Hists
            .Value     = ""
            .Top       = 109
            .Left      = 140
            .Width     = 223
            .Height    = 23
            .MaxLength = 100
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oPagina.lbl_4c_Label24
            .Caption   = "Pend" + CHR(234) + "ncias :"
            .Top       = 116
            .Left      = 622
            .Width     = 61
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_Pend", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_Pend
            .ButtonCount = 2
            .Top         = 113
            .Left        = 683
            .Width       = 128
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Pend.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Pend.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 63
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 4: Valor Previsto + Complemento Hist" + CHR(243) + "rico (5 op" + CHR(231) + CHR(245) + "es)
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oPagina.lbl_4c_Label19
            .Caption   = "Valor Previsto :"
            .Top       = 132
            .Left      = 610
            .Width     = 73
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_valprev", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_valprev
            .ButtonCount = 2
            .Top         = 129
            .Left        = 683
            .Width       = 128
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_valprev.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_valprev.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 63
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Compl. Hist" + CHR(243) + "rico :"
            .Top       = 137
            .Left      = 50
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_Compl", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_Compl
            .ButtonCount = 5
            .Top         = 134
            .Left        = 135
            .Width       = 206
            .Height      = 53
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Compl.Buttons(1)
            .Caption   = "Nenhum"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 75
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Compl.Buttons(2)
            .Caption   = "Emitente"
            .BackStyle = 0
            .Left      = 5
            .Top       = 28
            .Width     = 75
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Compl.Buttons(3)
            .Caption   = "Portador"
            .BackStyle = 0
            .Left      = 83
            .Top       = 3
            .Width     = 75
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Compl.Buttons(4)
            .Caption   = "Ambos"
            .BackStyle = 0
            .Left      = 83
            .Top       = 28
            .Width     = 75
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Compl.Buttons(5)
            .Caption   = "Conta"
            .BackStyle = 0
            .Left      = 161
            .Top       = 3
            .Width     = 35
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 5: Bloquear C/C
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label26", "Label")
        WITH loc_oPagina.lbl_4c_Label26
            .Caption   = "Bloquear C/C :"
            .Top       = 149
            .Left      = 613
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_blqcc", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_blqcc
            .ButtonCount = 2
            .Top         = 146
            .Left        = 683
            .Width       = 128
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_blqcc.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_blqcc.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 63
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 6: Realizar Apenas Autorizados
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label27", "Label")
        WITH loc_oPagina.lbl_4c_Label27
            .Caption   = "Realizar Apenas Autorizados :"
            .Top       = 167
            .Left      = 537
            .Width     = 146
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_Transporte", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_Transporte
            .ButtonCount = 2
            .Top         = 162
            .Left        = 683
            .Width       = 128
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Transporte.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Transporte.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 63
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 7: Outros T" + CHR(237) + "tulos Auto + Identificador + N" + CHR(186) + " T" + CHR(237) + "tulo Autom" + CHR(225) + "tico
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label31", "Label")
        WITH loc_oPagina.lbl_4c_Label31
            .Caption   = "Outros Titulos (Auto) :"
            .Top       = 182
            .Left      = 573
            .Width     = 110
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Get_OutroTit", "OptionGroup")
        WITH loc_oPagina.obj_4c_Get_OutroTit
            .ButtonCount = 2
            .Top         = 179
            .Left        = 683
            .Width       = 128
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Get_OutroTit.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Get_OutroTit.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 63
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "N" + CHR(186) + " titulo autom" + CHR(225) + "tico :"
            .Top       = 188
            .Left      = 32
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_Numtit", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_Numtit
            .ButtonCount = 2
            .Top         = 185
            .Left        = 135
            .Width       = 110
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Numtit.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 46
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Numtit.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 54
            .Top       = 3
            .Width     = 46
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Identificador :"
            .Top       = 188
            .Left      = 303
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ident", "TextBox")
        WITH loc_oPagina.txt_4c_Ident
            .Value     = ""
            .Top       = 184
            .Left      = 378
            .Width     = 17
            .Height    = 21
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 8: Tipo (Opc_realprev) + Qtd. Vias Boleto
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oPagina.lbl_4c_Label17
            .Caption   = "Tipo :"
            .Top       = 200
            .Left      = 654
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_realprev", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_realprev
            .ButtonCount = 2
            .Top         = 197
            .Left        = 683
            .Width       = 128
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_realprev.Buttons(1)
            .Caption   = "C/C"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_realprev.Buttons(2)
            .Caption   = "Previsto"
            .BackStyle = 0
            .Left      = 63
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oPagina.obj_4c_Opc_realprev, "InteractiveChange", THIS, "OpcRealprevChanged")

        loc_oPagina.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPagina.lbl_4c_Label16
            .Caption   = "Qtd. Vias Boleto :"
            .Top       = 213
            .Left      = 287
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Vias", "TextBox")
        WITH loc_oPagina.txt_4c_Vias
            .Value    = 0
            .Top      = 208
            .Left     = 378
            .Width    = 24
            .Height   = 24
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Vias, "KeyPress", THIS, "ValidarVias")

        *----------------------------------------------------------------------
        *-- Linha 9: Imprime Boleto + Opera" + CHR(231) + CHR(227) + "o Realizado
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPagina.lbl_4c_Label15
            .Caption   = "Imprime Boleto :"
            .Top       = 213
            .Left      = 56
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_Impbol", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_Impbol
            .ButtonCount = 2
            .Top         = 210
            .Left        = 135
            .Width       = 110
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Impbol.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 46
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Impbol.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 54
            .Top       = 3
            .Width     = 46
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oPagina.lbl_4c_Label18
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o Realizado :"
            .Top       = 220
            .Left      = 578
            .Width     = 105
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DopReal", "TextBox")
        WITH loc_oPagina.txt_4c_DopReal
            .Value     = ""
            .Top       = 216
            .Left      = 688
            .Width     = 150
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DopReal, "KeyPress", THIS, "ValidarDopReal")

        *----------------------------------------------------------------------
        *-- Linha 10: Imprime Documento + Opera" + CHR(231) + CHR(227) + "o Cancelamento
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oPagina.lbl_4c_Label28
            .Caption   = "Imprime Documento :"
            .Top       = 234
            .Left      = 32
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_imprimedoc", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_imprimedoc
            .ButtonCount = 2
            .Top         = 231
            .Left        = 135
            .Width       = 110
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_imprimedoc.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 46
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_imprimedoc.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 54
            .Top       = 3
            .Width     = 46
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label30", "Label")
        WITH loc_oPagina.lbl_4c_Label30
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o Cancelamento :"
            .Top       = 245
            .Left      = 556
            .Width     = 127
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DopCanc", "TextBox")
        WITH loc_oPagina.txt_4c_DopCanc
            .Value     = ""
            .Top       = 241
            .Left      = 688
            .Width     = 150
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DopCanc, "KeyPress", THIS, "ValidarDopCanc")

        *----------------------------------------------------------------------
        *-- Linha 10: Dados Pagamento + Campo NF
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label32", "Label")
        WITH loc_oPagina.lbl_4c_Label32
            .Caption   = "Dados Pagamento :"
            .Top       = 273
            .Left      = 37
            .Width     = 99
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_DadosPg", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_DadosPg
            .ButtonCount = 2
            .Top         = 270
            .Left        = 135
            .Width       = 110
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_DadosPg.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 46
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_DadosPg.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 54
            .Top       = 3
            .Width     = 46
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label33", "Label")
        WITH loc_oPagina.lbl_4c_Label33
            .Caption   = "Campo NF :"
            .Top       = 273
            .Left      = 583
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opt_CampoNf", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opt_CampoNf
            .ButtonCount = 2
            .Top         = 270
            .Left        = 136
            .Width       = 128
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_CampoNf.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_CampoNf.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 63
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 11: Emitente=Portador + Compet" + CHR(234) + "ncia
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label34", "Label")
        WITH loc_oPagina.lbl_4c_Label34
            .Caption   = "Emit.=Portador :"
            .Top       = 295
            .Left      = 54
            .Width     = 82
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_EmiPor", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_EmiPor
            .ButtonCount = 2
            .Top         = 292
            .Left        = 135
            .Width       = 110
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_EmiPor.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 46
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_EmiPor.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 54
            .Top       = 3
            .Width     = 46
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label35", "Label")
        WITH loc_oPagina.lbl_4c_Label35
            .Caption   = "Compet" + CHR(234) + "ncia :"
            .Top       = 295
            .Left      = 574
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_Compet", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_Compet
            .ButtonCount = 2
            .Top         = 292
            .Left        = 683
            .Width       = 128
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Compet.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Compet.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 63
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 12: Filtra Conta p/ Grupo + Jobs
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label36", "Label")
        WITH loc_oPagina.lbl_4c_Label36
            .Caption   = "Filtra Conta p/ Grupo :"
            .Top       = 317
            .Left      = 17
            .Width     = 119
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_FiltContas", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_FiltContas
            .ButtonCount = 2
            .Top         = 314
            .Left        = 135
            .Width       = 110
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_FiltContas.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 46
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_FiltContas.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 54
            .Top       = 3
            .Width     = 46
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label37", "Label")
        WITH loc_oPagina.lbl_4c_Label37
            .Caption   = "Jobs :"
            .Top       = 317
            .Left      = 633
            .Width     = 36
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opt_Jobs", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opt_Jobs
            .ButtonCount = 2
            .Top         = 314
            .Left        = 683
            .Width       = 128
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_Jobs.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_Jobs.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 63
            .Top       = 3
            .Width     = 55
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 13: Limite Cr" + CHR(233) + "dito
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label38", "Label")
        WITH loc_oPagina.lbl_4c_Label38
            .Caption   = "Limite Cr" + CHR(233) + "dito :"
            .Top       = 339
            .Left      = 42
            .Width     = 94
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Opc_Limcres", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_Limcres
            .ButtonCount = 2
            .Top         = 336
            .Left        = 135
            .Width       = 110
            .Height      = 21
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Limcres.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 46
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Limcres.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 54
            .Top       = 3
            .Width     = 46
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 14: CheckBoxes
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("chk_4c_Congvs", "CheckBox")
        WITH loc_oPagina.chk_4c_Congvs
            .Caption   = "Cong" + CHR(234) + "neres"
            .Top       = 362
            .Left      = 20
            .Width     = 100
            .Height    = 17
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_BlqTits", "CheckBox")
        WITH loc_oPagina.chk_4c_BlqTits
            .Caption   = "Bloqueia T" + CHR(237) + "tulos"
            .Top       = 362
            .Left      = 128
            .Width     = 118
            .Height    = 17
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_Espobrigs", "CheckBox")
        WITH loc_oPagina.chk_4c_Espobrigs
            .Caption   = "Esp. Obrig."
            .Top       = 362
            .Left      = 255
            .Width     = 95
            .Height    = 17
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_LancCCEs", "CheckBox")
        WITH loc_oPagina.chk_4c_LancCCEs
            .Caption   = "Lan" + CHR(231) + ".C/C Emiss."
            .Top       = 362
            .Left      = 360
            .Width     = 112
            .Height    = 17
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_LancCCAs", "CheckBox")
        WITH loc_oPagina.chk_4c_LancCCAs
            .Caption   = "Lan" + CHR(231) + ".C/C Ato."
            .Top       = 362
            .Left      = 480
            .Width     = 105
            .Height    = 17
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_Obsobrigs", "CheckBox")
        WITH loc_oPagina.chk_4c_Obsobrigs
            .Caption   = "Obs. Obrig."
            .Top       = 362
            .Left      = 595
            .Width     = 95
            .Height    = 17
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("chk_4c_ObrCompet", "CheckBox")
        WITH loc_oPagina.chk_4c_ObrCompet
            .Caption   = "Obrig. Compet."
            .Top       = 362
            .Left      = 700
            .Width     = 115
            .Height    = 17
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 15: M" + CHR(225) + "scara NF + Dias Vcto + Juros + Moeda + Vlr.Lim.Aprov.
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label39", "Label")
        WITH loc_oPagina.lbl_4c_Label39
            .Caption   = "M" + CHR(225) + "scara NF :"
            .Top       = 387
            .Left      = 12
            .Width     = 82
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Mascara", "TextBox")
        WITH loc_oPagina.txt_4c_Mascara
            .Value     = ""
            .Top       = 383
            .Left      = 97
            .Width     = 75
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label40", "Label")
        WITH loc_oPagina.lbl_4c_Label40
            .Caption   = "Dias Vcto :"
            .Top       = 387
            .Left      = 178
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DiasVcto", "TextBox")
        WITH loc_oPagina.txt_4c_DiasVcto
            .Value     = 0
            .Top       = 383
            .Left      = 248
            .Width     = 40
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DiasVcto, "KeyPress", THIS, "ValidarDiasVcto")

        loc_oPagina.AddObject("lbl_4c_Label41", "Label")
        WITH loc_oPagina.lbl_4c_Label41
            .Caption   = "Juros Di" + CHR(225) + "rio(%) :"
            .Top       = 387
            .Left      = 296
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Juros", "TextBox")
        WITH loc_oPagina.txt_4c_Juros
            .Value     = 0.0
            .Top       = 383
            .Left      = 390
            .Width     = 55
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label42", "Label")
        WITH loc_oPagina.lbl_4c_Label42
            .Caption   = "Moeda :"
            .Top       = 387
            .Left      = 452
            .Width     = 47
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPagina.txt_4c_Moeda
            .Value     = ""
            .Top       = 383
            .Left      = 503
            .Width     = 35
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoeda")

        loc_oPagina.AddObject("lbl_4c_Label43", "Label")
        WITH loc_oPagina.lbl_4c_Label43
            .Caption   = "Vlr.Lim.Aprov. :"
            .Top       = 387
            .Left      = 544
            .Width     = 100
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_VlrLimApv", "TextBox")
        WITH loc_oPagina.txt_4c_VlrLimApv
            .Value     = 0.0
            .Top       = 383
            .Left      = 648
            .Width     = 95
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 16: Pasta(s)
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label44", "Label")
        WITH loc_oPagina.lbl_4c_Label44
            .Caption   = "Pasta(s) :"
            .Top       = 412
            .Left      = 37
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Pasta", "TextBox")
        WITH loc_oPagina.txt_4c_Pasta
            .Value     = ""
            .Top       = 408
            .Left      = 99
            .Width     = 620
            .Height    = 23
            .MaxLength = 250
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_BtnPastasCl", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnPastasCl
            .Caption       = "..."
            .Top           = 408
            .Left          = 538
            .Width         = 25
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_BtnPastasCl, "Click", THIS, "BtnPastasCClick")

        *----------------------------------------------------------------------
        *-- Linha 17: Grupos Padr" + CHR(227) + "o (Emitente/Portador/C.Custo/Ag.Cobrador)
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label45", "Label")
        WITH loc_oPagina.lbl_4c_Label45
            .Caption   = "Gr.Emitente :"
            .Top       = 437
            .Left      = 10
            .Width     = 82
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupo1", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo1
            .Value     = ""
            .Top       = 433
            .Left      = 97
            .Width     = 85
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label46", "Label")
        WITH loc_oPagina.lbl_4c_Label46
            .Caption   = "Gr.Portador :"
            .Top       = 437
            .Left      = 193
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupo2", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo2
            .Value     = ""
            .Top       = 433
            .Left      = 278
            .Width     = 85
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label47", "Label")
        WITH loc_oPagina.lbl_4c_Label47
            .Caption   = "Gr.C.Custo :"
            .Top       = 437
            .Left      = 374
            .Width     = 77
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupo3", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo3
            .Value     = ""
            .Top       = 433
            .Left      = 456
            .Width     = 85
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label48", "Label")
        WITH loc_oPagina.lbl_4c_Label48
            .Caption   = "Gr.Ag.Cobr. :"
            .Top       = 437
            .Left      = 548
            .Width     = 83
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupo4", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo4
            .Value     = ""
            .Top       = 433
            .Left      = 636
            .Width     = 85
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 18: T" + CHR(237) + "tulos dos Campos
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label49", "Label")
        WITH loc_oPagina.lbl_4c_Label49
            .Caption   = "Tit.Emitente :"
            .Top       = 461
            .Left      = 10
            .Width     = 82
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Txt01", "TextBox")
        WITH loc_oPagina.txt_4c_Txt01
            .Value     = ""
            .Top       = 457
            .Left      = 97
            .Width     = 90
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label50", "Label")
        WITH loc_oPagina.lbl_4c_Label50
            .Caption   = "Tit.Portador :"
            .Top       = 461
            .Left      = 196
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Txt02", "TextBox")
        WITH loc_oPagina.txt_4c_Txt02
            .Value     = ""
            .Top       = 457
            .Left      = 281
            .Width     = 90
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label51", "Label")
        WITH loc_oPagina.lbl_4c_Label51
            .Caption   = "Tit.C.Custo :"
            .Top       = 461
            .Left      = 380
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Txt03", "TextBox")
        WITH loc_oPagina.txt_4c_Txt03
            .Value     = ""
            .Top       = 457
            .Left      = 460
            .Width     = 90
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label52", "Label")
        WITH loc_oPagina.lbl_4c_Label52
            .Caption   = "Tit.Agente :"
            .Top       = 461
            .Left      = 560
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Txt04", "TextBox")
        WITH loc_oPagina.txt_4c_Txt04
            .Value     = ""
            .Top       = 457
            .Left      = 638
            .Width     = 90
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linhas 19-20: Grupos Cadastrais 1-2 e 3-4
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label53", "Label")
        WITH loc_oPagina.lbl_4c_Label53
            .Caption   = "Gr.Cad.1 :"
            .Top       = 487
            .Left      = 10
            .Width     = 66
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_GrpCad1", "TextBox")
        WITH loc_oPagina.txt_4c_GrpCad1
            .Value     = ""
            .Top       = 483
            .Left      = 80
            .Width     = 65
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_GrpCad1, "KeyPress", THIS, "ValidarGrpCad1s")

        loc_oPagina.AddObject("txt_4c_DGrpCad1", "TextBox")
        WITH loc_oPagina.txt_4c_DGrpCad1
            .Value     = ""
            .Top       = 483
            .Left      = 150
            .Width     = 200
            .Height    = 23
            .ReadOnly  = .T.
            .Enabled   = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label54", "Label")
        WITH loc_oPagina.lbl_4c_Label54
            .Caption   = "Gr.Cad.2 :"
            .Top       = 487
            .Left      = 365
            .Width     = 66
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_GrpCad2", "TextBox")
        WITH loc_oPagina.txt_4c_GrpCad2
            .Value     = ""
            .Top       = 483
            .Left      = 436
            .Width     = 65
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_GrpCad2, "KeyPress", THIS, "ValidarGrpCad2s")

        loc_oPagina.AddObject("txt_4c_DGrpCad2", "TextBox")
        WITH loc_oPagina.txt_4c_DGrpCad2
            .Value     = ""
            .Top       = 483
            .Left      = 506
            .Width     = 200
            .Height    = 23
            .ReadOnly  = .T.
            .Enabled   = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label55", "Label")
        WITH loc_oPagina.lbl_4c_Label55
            .Caption   = "Gr.Cad.3 :"
            .Top       = 511
            .Left      = 10
            .Width     = 66
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_GrpCad3", "TextBox")
        WITH loc_oPagina.txt_4c_GrpCad3
            .Value     = ""
            .Top       = 507
            .Left      = 80
            .Width     = 65
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_GrpCad3, "KeyPress", THIS, "ValidarGrpCad3s")

        loc_oPagina.AddObject("txt_4c_DGrpCad3", "TextBox")
        WITH loc_oPagina.txt_4c_DGrpCad3
            .Value     = ""
            .Top       = 507
            .Left      = 150
            .Width     = 200
            .Height    = 23
            .ReadOnly  = .T.
            .Enabled   = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label56", "Label")
        WITH loc_oPagina.lbl_4c_Label56
            .Caption   = "Gr.Cad.4 :"
            .Top       = 511
            .Left      = 365
            .Width     = 66
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_GrpCad4", "TextBox")
        WITH loc_oPagina.txt_4c_GrpCad4
            .Value     = ""
            .Top       = 507
            .Left      = 436
            .Width     = 65
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_GrpCad4, "KeyPress", THIS, "ValidarGrpCad4s")

        loc_oPagina.AddObject("txt_4c_DGrpCad4", "TextBox")
        WITH loc_oPagina.txt_4c_DGrpCad4
            .Value     = ""
            .Top       = 507
            .Left      = 506
            .Width     = 200
            .Height    = 23
            .ReadOnly  = .T.
            .Enabled   = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linhas 21-22: Classes Cont" + CHR(225) + "beis 1-4 com Obrigatoriedade
        *----------------------------------------------------------------------

        loc_oPagina.AddObject("lbl_4c_Label57", "Label")
        WITH loc_oPagina.lbl_4c_Label57
            .Caption   = "Classe 1 :"
            .Top       = 538
            .Left      = 10
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Class1", "TextBox")
        WITH loc_oPagina.txt_4c_Class1
            .Value     = ""
            .Top       = 534
            .Left      = 74
            .Width     = 30
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Class1, "KeyPress", THIS, "ValidarClass1s")

        loc_oPagina.AddObject("chk_4c_ObrigC1", "CheckBox")
        WITH loc_oPagina.chk_4c_ObrigC1
            .Caption   = "Obrigat" + CHR(243) + "ria"
            .Top       = 536
            .Left      = 109
            .Width     = 80
            .Height    = 17
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label58", "Label")
        WITH loc_oPagina.lbl_4c_Label58
            .Caption   = "Classe 2 :"
            .Top       = 538
            .Left      = 200
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Class2", "TextBox")
        WITH loc_oPagina.txt_4c_Class2
            .Value     = ""
            .Top       = 534
            .Left      = 264
            .Width     = 30
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Class2, "KeyPress", THIS, "ValidarClass2s")

        loc_oPagina.AddObject("chk_4c_ObrigC2", "CheckBox")
        WITH loc_oPagina.chk_4c_ObrigC2
            .Caption   = "Obrigat" + CHR(243) + "ria"
            .Top       = 536
            .Left      = 299
            .Width     = 80
            .Height    = 17
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label59", "Label")
        WITH loc_oPagina.lbl_4c_Label59
            .Caption   = "Classe 3 :"
            .Top       = 538
            .Left      = 395
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Class3", "TextBox")
        WITH loc_oPagina.txt_4c_Class3
            .Value     = ""
            .Top       = 534
            .Left      = 459
            .Width     = 30
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Class3, "KeyPress", THIS, "ValidarClass3s")

        loc_oPagina.AddObject("chk_4c_ObrigC3", "CheckBox")
        WITH loc_oPagina.chk_4c_ObrigC3
            .Caption   = "Obrigat" + CHR(243) + "ria"
            .Top       = 536
            .Left      = 494
            .Width     = 80
            .Height    = 17
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label60", "Label")
        WITH loc_oPagina.lbl_4c_Label60
            .Caption   = "Classe 4 :"
            .Top       = 538
            .Left      = 590
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Class4", "TextBox")
        WITH loc_oPagina.txt_4c_Class4
            .Value     = ""
            .Top       = 534
            .Left      = 654
            .Width     = 30
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Class4, "KeyPress", THIS, "ValidarClass4s")

        loc_oPagina.AddObject("chk_4c_ObrigC4", "CheckBox")
        WITH loc_oPagina.chk_4c_ObrigC4
            .Caption   = "Obrigat" + CHR(243) + "ria"
            .Top       = 536
            .Left      = 689
            .Width     = 80
            .Height    = 17
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista()
    *==========================================================================
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            loc_lResultado = .T.
        ELSE
            TRY
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_lResultado = .T.

                    IF TYPE("THIS.pgf_4c_Paginas.Page1.grd_4c_Lista") = "O"
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                        loc_oGrid.ColumnCount = 3
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Ndopes"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Dopes"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Opers"
                        loc_oGrid.Column1.Header1.Caption = "N" + CHR(186)
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormOTI.CarregarLista")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.AlternarPagina")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnIncluirClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_nNdope, loc_nResult
        loc_lResultado = .F.

        TRY
            *-- Gerar pr" + CHR(243) + "ximo Ndope via MAX+1
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(Ndopes),0)+1 AS ProxNdope FROM SigOpOpe", ;
                "cursor_4c_NdopeTmp")
            IF loc_nResult > 0 AND !EOF("cursor_4c_NdopeTmp")
                loc_nNdope = cursor_4c_NdopeTmp.ProxNdope
            ELSE
                loc_nNdope = 1
            ENDIF
            IF USED("cursor_4c_NdopeTmp")
                USE IN cursor_4c_NdopeTmp
            ENDIF

            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_oBusinessObject.this_nNdopes = loc_nNdope
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Ndope", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Ndope.Value = loc_nNdope
            ENDIF

            THIS.pgf_4c_Paginas.ActivePage = 2
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.BtnIncluirClick")
        ENDTRY

        IF USED("cursor_4c_NdopeTmp")
            USE IN cursor_4c_NdopeTmp
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_nNdopes
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro na lista.", "Visualizar")
            ELSE
                SELECT cursor_4c_Dados
                loc_nNdopes = cursor_4c_Dados.Ndopes
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNdopes)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.BOParaForm()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "FormOTI")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_nNdopes
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro na lista.", "Alterar")
            ELSE
                SELECT cursor_4c_Dados
                loc_nNdopes = cursor_4c_Dados.Ndopes
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNdopes)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.BOParaForm()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", "FormOTI")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_nNdopes, loc_lConfirma
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro na lista.", "Excluir")
            ELSE
                SELECT cursor_4c_Dados
                loc_nNdopes   = cursor_4c_Dados.Ndopes
                loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o selecionada?", "Excluir")
                IF loc_lConfirma
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nNdopes)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Opera" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + "da com sucesso!", "Excluir")
                            THIS.CarregarLista()
                            loc_lResultado = .T.
                        ELSE
                            MsgErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o.", "FormOTI")
                        ENDIF
                    ELSE
                        MsgErro("Erro ao localizar registro para exclus" + CHR(227) + "o.", "FormOTI")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_oBusca, loc_nNdope, loc_oGrid
        loc_lResultado = .F.

        TRY
            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Ndopes, Dopes, Opers FROM SigOpOpe ORDER BY Dopes", ;
                "cursor_4c_BuscaOpe")

            IF loc_nResult > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            ENDIF

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpe"
                loc_oBusca.mAddColuna("Ndopes", "", "N" + CHR(186))
                loc_oBusca.mAddColuna("Dopes",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("Opers",  "", "Opera" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                    loc_nNdope = cursor_4c_BuscaOpe.Ndopes
                    THIS.CarregarLista()
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR cursor_4c_Dados.Ndopes = loc_nNdope
                    ENDIF
                    loc_lResultado = .T.
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSalvarClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            IF PEMSTATUS(loc_oPg2, "txt_4c_Dope", 5)
                IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Dope.Value))
                    MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!", "Salvar")
                    loc_oPg2.txt_4c_Dope.SetFocus()
                    RETURN .F.
                ENDIF
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Opera" + CHR(231) + CHR(227) + "o salva com sucesso!", "Salvar")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao salvar opera" + CHR(231) + CHR(227) + "o.", "FormOTI")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.CancelarEdicao()
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.BtnCancelarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
    *==========================================================================
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Ndope", 5)
                loc_oBO.this_nNdopes = loc_oPg2.txt_4c_Ndope.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Dope", 5)
                loc_oBO.this_cDopes = ALLTRIM(loc_oPg2.txt_4c_Dope.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opcao_oper", 5)
                loc_oBO.this_cOpers = IIF(loc_oPg2.obj_4c_Opcao_oper.Value = 1, "CR", "DB")
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Chk_Inativar", 5)
                loc_oBO.this_nOpeCancs = IIF(loc_oPg2.chk_4c_Chk_Inativar.Value, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Hists", 5)
                loc_oBO.this_cHists = ALLTRIM(loc_oPg2.txt_4c_Hists.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Compl", 5)
                loc_oBO.this_nTpHists = loc_oPg2.obj_4c_Opc_Compl.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Ident", 5)
                loc_oBO.this_cIdentifics = ALLTRIM(loc_oPg2.txt_4c_Ident.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Opdepo", 5)
                loc_oBO.this_cOpdepos = ALLTRIM(loc_oPg2.txt_4c_Opdepo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Pend", 5)
                loc_oBO.this_nPendencias = loc_oPg2.obj_4c_Opc_Pend.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_valprev", 5)
                loc_oBO.this_nValprev = loc_oPg2.obj_4c_Opc_valprev.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_blqcc", 5)
                loc_oBO.this_nBlqccs = loc_oPg2.obj_4c_Opc_blqcc.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Transporte", 5)
                loc_oBO.this_nAltTrans = loc_oPg2.obj_4c_Opc_Transporte.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Get_OutroTit", 5)
                loc_oBO.this_nOutTits = loc_oPg2.obj_4c_Get_OutroTit.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Numtit", 5)
                loc_oBO.this_nTitauts = loc_oPg2.obj_4c_Opc_Numtit.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_realprev", 5)
                loc_oBO.this_nRealprevs = loc_oPg2.obj_4c_Opc_realprev.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Vias", 5)
                loc_oBO.this_nQtdBols = loc_oPg2.txt_4c_Vias.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Impbol", 5)
                loc_oBO.this_nImpbols = loc_oPg2.obj_4c_Opc_Impbol.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DopReal", 5)
                loc_oBO.this_cDopereals = ALLTRIM(loc_oPg2.txt_4c_DopReal.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_imprimedoc", 5)
                loc_oBO.this_nImpdocs = loc_oPg2.obj_4c_Opc_imprimedoc.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DopCanc", 5)
                loc_oBO.this_cDopCancs = ALLTRIM(loc_oPg2.txt_4c_DopCanc.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_DadosPg", 5)
                loc_oBO.this_nDadosPgs = loc_oPg2.obj_4c_Opc_DadosPg.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_CampoNf", 5)
                loc_oBO.this_nCampoNfs = loc_oPg2.obj_4c_Opt_CampoNf.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_EmiPor", 5)
                loc_oBO.this_nEmiPorDesp = loc_oPg2.obj_4c_Opc_EmiPor.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Compet", 5)
                loc_oBO.this_nCompets = loc_oPg2.obj_4c_Opc_Compet.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_FiltContas", 5)
                loc_oBO.this_nFiltContas = loc_oPg2.obj_4c_Opc_FiltContas.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_Jobs", 5)
                loc_oBO.this_nJobs = loc_oPg2.obj_4c_Opt_Jobs.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Limcres", 5)
                loc_oBO.this_nLimcres = loc_oPg2.obj_4c_Opc_Limcres.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Congvs", 5)
                loc_oBO.this_lCongvs = (loc_oPg2.chk_4c_Congvs.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_BlqTits", 5)
                loc_oBO.this_lBlqTits = (loc_oPg2.chk_4c_BlqTits.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Espobrigs", 5)
                loc_oBO.this_lEspobrigs = (loc_oPg2.chk_4c_Espobrigs.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_LancCCEs", 5)
                loc_oBO.this_lLancCCEs = (loc_oPg2.chk_4c_LancCCEs.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_LancCCAs", 5)
                loc_oBO.this_lLancCCAs = (loc_oPg2.chk_4c_LancCCAs.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Obsobrigs", 5)
                loc_oBO.this_lObsobrigs = (loc_oPg2.chk_4c_Obsobrigs.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrCompet", 5)
                loc_oBO.this_lObrCompet = (loc_oPg2.chk_4c_ObrCompet.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Mascara", 5)
                loc_oBO.this_cCnMascaras = ALLTRIM(loc_oPg2.txt_4c_Mascara.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DiasVcto", 5)
                loc_oBO.this_nDiasVcto = loc_oPg2.txt_4c_DiasVcto.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Juros", 5)
                loc_oBO.this_nJuros = loc_oPg2.txt_4c_Juros.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 5)
                loc_oBO.this_cMoedas = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_VlrLimApv", 5)
                loc_oBO.this_nVlrLimApv = loc_oPg2.txt_4c_VlrLimApv.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Pasta", 5)
                loc_oBO.this_cPastas = ALLTRIM(loc_oPg2.txt_4c_Pasta.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo1", 5)
                loc_oBO.this_cGrupo1s = ALLTRIM(loc_oPg2.txt_4c_Grupo1.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo2", 5)
                loc_oBO.this_cGrupo2s = ALLTRIM(loc_oPg2.txt_4c_Grupo2.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo3", 5)
                loc_oBO.this_cGrupo3s = ALLTRIM(loc_oPg2.txt_4c_Grupo3.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo4", 5)
                loc_oBO.this_cGrupo4s = ALLTRIM(loc_oPg2.txt_4c_Grupo4.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt01", 5)
                loc_oBO.this_cTxt01 = ALLTRIM(loc_oPg2.txt_4c_Txt01.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt02", 5)
                loc_oBO.this_cTxt02 = ALLTRIM(loc_oPg2.txt_4c_Txt02.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt03", 5)
                loc_oBO.this_cTxt03 = ALLTRIM(loc_oPg2.txt_4c_Txt03.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt04", 5)
                loc_oBO.this_cTxt04 = ALLTRIM(loc_oPg2.txt_4c_Txt04.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad1", 5)
                loc_oBO.this_cGrpCad1s = ALLTRIM(loc_oPg2.txt_4c_GrpCad1.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad2", 5)
                loc_oBO.this_cGrpCad2s = ALLTRIM(loc_oPg2.txt_4c_GrpCad2.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad3", 5)
                loc_oBO.this_cGrpCad3s = ALLTRIM(loc_oPg2.txt_4c_GrpCad3.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad4", 5)
                loc_oBO.this_cGrpCad4s = ALLTRIM(loc_oPg2.txt_4c_GrpCad4.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class1", 5)
                loc_oBO.this_cClass1s = ALLTRIM(loc_oPg2.txt_4c_Class1.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class2", 5)
                loc_oBO.this_cClass2s = ALLTRIM(loc_oPg2.txt_4c_Class2.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class3", 5)
                loc_oBO.this_cClass3s = ALLTRIM(loc_oPg2.txt_4c_Class3.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class4", 5)
                loc_oBO.this_cClass4s = ALLTRIM(loc_oPg2.txt_4c_Class4.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC1", 5)
                loc_oBO.this_lObrigC1 = (loc_oPg2.chk_4c_ObrigC1.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC2", 5)
                loc_oBO.this_lObrigC2 = (loc_oPg2.chk_4c_ObrigC2.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC3", 5)
                loc_oBO.this_lObrigC3 = (loc_oPg2.chk_4c_ObrigC3.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC4", 5)
                loc_oBO.this_lObrigC4 = (loc_oPg2.chk_4c_ObrigC4.Value = 1)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *==========================================================================
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Ndope", 5)
                loc_oPg2.txt_4c_Ndope.Value = loc_oBO.this_nNdopes
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Dope", 5)
                loc_oPg2.txt_4c_Dope.Value = loc_oBO.this_cDopes
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opcao_oper", 5)
                loc_oPg2.obj_4c_Opcao_oper.Value = IIF(loc_oBO.this_cOpers = "CR", 1, 2)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Chk_Inativar", 5)
                loc_oPg2.chk_4c_Chk_Inativar.Value = IIF(loc_oBO.this_nOpeCancs = 1, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Hists", 5)
                loc_oPg2.txt_4c_Hists.Value = loc_oBO.this_cHists
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Compl", 5)
                loc_oPg2.obj_4c_Opc_Compl.Value = loc_oBO.this_nTpHists
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Ident", 5)
                loc_oPg2.txt_4c_Ident.Value = loc_oBO.this_cIdentifics
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Opdepo", 5)
                loc_oPg2.txt_4c_Opdepo.Value = loc_oBO.this_cOpdepos
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Pend", 5)
                loc_oPg2.obj_4c_Opc_Pend.Value = loc_oBO.this_nPendencias
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_valprev", 5)
                loc_oPg2.obj_4c_Opc_valprev.Value = loc_oBO.this_nValprev
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_blqcc", 5)
                loc_oPg2.obj_4c_Opc_blqcc.Value = loc_oBO.this_nBlqccs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Transporte", 5)
                loc_oPg2.obj_4c_Opc_Transporte.Value = loc_oBO.this_nAltTrans
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Get_OutroTit", 5)
                loc_oPg2.obj_4c_Get_OutroTit.Value = loc_oBO.this_nOutTits
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Numtit", 5)
                loc_oPg2.obj_4c_Opc_Numtit.Value = loc_oBO.this_nTitauts
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_realprev", 5)
                loc_oPg2.obj_4c_Opc_realprev.Value = loc_oBO.this_nRealprevs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Vias", 5)
                loc_oPg2.txt_4c_Vias.Value = loc_oBO.this_nQtdBols
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Impbol", 5)
                loc_oPg2.obj_4c_Opc_Impbol.Value = loc_oBO.this_nImpbols
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DopReal", 5)
                loc_oPg2.txt_4c_DopReal.Value = loc_oBO.this_cDopereals
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_imprimedoc", 5)
                loc_oPg2.obj_4c_Opc_imprimedoc.Value = loc_oBO.this_nImpdocs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DopCanc", 5)
                loc_oPg2.txt_4c_DopCanc.Value = loc_oBO.this_cDopCancs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_DadosPg", 5)
                loc_oPg2.obj_4c_Opc_DadosPg.Value = loc_oBO.this_nDadosPgs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_CampoNf", 5)
                loc_oPg2.obj_4c_Opt_CampoNf.Value = loc_oBO.this_nCampoNfs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_EmiPor", 5)
                loc_oPg2.obj_4c_Opc_EmiPor.Value = loc_oBO.this_nEmiPorDesp
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Compet", 5)
                loc_oPg2.obj_4c_Opc_Compet.Value = loc_oBO.this_nCompets
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_FiltContas", 5)
                loc_oPg2.obj_4c_Opc_FiltContas.Value = loc_oBO.this_nFiltContas
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_Jobs", 5)
                loc_oPg2.obj_4c_Opt_Jobs.Value = loc_oBO.this_nJobs
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Limcres", 5)
                loc_oPg2.obj_4c_Opc_Limcres.Value = loc_oBO.this_nLimcres
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Congvs", 5)
                loc_oPg2.chk_4c_Congvs.Value = IIF(loc_oBO.this_lCongvs, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_BlqTits", 5)
                loc_oPg2.chk_4c_BlqTits.Value = IIF(loc_oBO.this_lBlqTits, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Espobrigs", 5)
                loc_oPg2.chk_4c_Espobrigs.Value = IIF(loc_oBO.this_lEspobrigs, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_LancCCEs", 5)
                loc_oPg2.chk_4c_LancCCEs.Value = IIF(loc_oBO.this_lLancCCEs, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_LancCCAs", 5)
                loc_oPg2.chk_4c_LancCCAs.Value = IIF(loc_oBO.this_lLancCCAs, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Obsobrigs", 5)
                loc_oPg2.chk_4c_Obsobrigs.Value = IIF(loc_oBO.this_lObsobrigs, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrCompet", 5)
                loc_oPg2.chk_4c_ObrCompet.Value = IIF(loc_oBO.this_lObrCompet, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Mascara", 5)
                loc_oPg2.txt_4c_Mascara.Value = loc_oBO.this_cCnMascaras
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DiasVcto", 5)
                loc_oPg2.txt_4c_DiasVcto.Value = loc_oBO.this_nDiasVcto
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Juros", 5)
                loc_oPg2.txt_4c_Juros.Value = loc_oBO.this_nJuros
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 5)
                loc_oPg2.txt_4c_Moeda.Value = loc_oBO.this_cMoedas
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_VlrLimApv", 5)
                loc_oPg2.txt_4c_VlrLimApv.Value = loc_oBO.this_nVlrLimApv
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Pasta", 5)
                loc_oPg2.txt_4c_Pasta.Value = loc_oBO.this_cPastas
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo1", 5)
                loc_oPg2.txt_4c_Grupo1.Value = loc_oBO.this_cGrupo1s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo2", 5)
                loc_oPg2.txt_4c_Grupo2.Value = loc_oBO.this_cGrupo2s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo3", 5)
                loc_oPg2.txt_4c_Grupo3.Value = loc_oBO.this_cGrupo3s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo4", 5)
                loc_oPg2.txt_4c_Grupo4.Value = loc_oBO.this_cGrupo4s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt01", 5)
                loc_oPg2.txt_4c_Txt01.Value = loc_oBO.this_cTxt01
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt02", 5)
                loc_oPg2.txt_4c_Txt02.Value = loc_oBO.this_cTxt02
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt03", 5)
                loc_oPg2.txt_4c_Txt03.Value = loc_oBO.this_cTxt03
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt04", 5)
                loc_oPg2.txt_4c_Txt04.Value = loc_oBO.this_cTxt04
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad1", 5)
                loc_oPg2.txt_4c_GrpCad1.Value = loc_oBO.this_cGrpCad1s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad1", 5)
                loc_oPg2.txt_4c_DGrpCad1.Value = loc_oBO.this_cDGrpCad1s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad2", 5)
                loc_oPg2.txt_4c_GrpCad2.Value = loc_oBO.this_cGrpCad2s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad2", 5)
                loc_oPg2.txt_4c_DGrpCad2.Value = loc_oBO.this_cDGrpCad2s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad3", 5)
                loc_oPg2.txt_4c_GrpCad3.Value = loc_oBO.this_cGrpCad3s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad3", 5)
                loc_oPg2.txt_4c_DGrpCad3.Value = loc_oBO.this_cDGrpCad3s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad4", 5)
                loc_oPg2.txt_4c_GrpCad4.Value = loc_oBO.this_cGrpCad4s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad4", 5)
                loc_oPg2.txt_4c_DGrpCad4.Value = loc_oBO.this_cDGrpCad4s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class1", 5)
                loc_oPg2.txt_4c_Class1.Value = loc_oBO.this_cClass1s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class2", 5)
                loc_oPg2.txt_4c_Class2.Value = loc_oBO.this_cClass2s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class3", 5)
                loc_oPg2.txt_4c_Class3.Value = loc_oBO.this_cClass3s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class4", 5)
                loc_oPg2.txt_4c_Class4.Value = loc_oBO.this_cClass4s
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC1", 5)
                loc_oPg2.chk_4c_ObrigC1.Value = IIF(loc_oBO.this_lObrigC1, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC2", 5)
                loc_oPg2.chk_4c_ObrigC2.Value = IIF(loc_oBO.this_lObrigC2, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC3", 5)
                loc_oPg2.chk_4c_ObrigC3.Value = IIF(loc_oBO.this_lObrigC3, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC4", 5)
                loc_oPg2.chk_4c_ObrigC4.Value = IIF(loc_oBO.this_lObrigC4, 1, 0)
            ENDIF

            *-- Ajustar habilita" + CHR(231) + CHR(227) + "o condicional ap" + CHR(243) + "s carregar
            THIS.OpcRealprevChanged()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
    *==========================================================================
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Ndope", 5)
                loc_oPg2.txt_4c_Ndope.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Dope", 5)
                loc_oPg2.txt_4c_Dope.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opcao_oper", 5)
                loc_oPg2.obj_4c_Opcao_oper.Value = 1
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Chk_Inativar", 5)
                loc_oPg2.chk_4c_Chk_Inativar.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Opdepo", 5)
                loc_oPg2.txt_4c_Opdepo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Hists", 5)
                loc_oPg2.txt_4c_Hists.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Compl", 5)
                loc_oPg2.obj_4c_Opc_Compl.Value = 2
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Pend", 5)
                loc_oPg2.obj_4c_Opc_Pend.Value = 1
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_valprev", 5)
                loc_oPg2.obj_4c_Opc_valprev.Value = 2
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_blqcc", 5)
                loc_oPg2.obj_4c_Opc_blqcc.Value = 2
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Transporte", 5)
                loc_oPg2.obj_4c_Opc_Transporte.Value = 1
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Get_OutroTit", 5)
                loc_oPg2.obj_4c_Get_OutroTit.Value = 2
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Numtit", 5)
                loc_oPg2.obj_4c_Opc_Numtit.Value = 1
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Ident", 5)
                loc_oPg2.txt_4c_Ident.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_realprev", 5)
                loc_oPg2.obj_4c_Opc_realprev.Value = 1
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Vias", 5)
                loc_oPg2.txt_4c_Vias.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Impbol", 5)
                loc_oPg2.obj_4c_Opc_Impbol.Value = 2
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DopReal", 5)
                loc_oPg2.txt_4c_DopReal.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_imprimedoc", 5)
                loc_oPg2.obj_4c_Opc_imprimedoc.Value = 2
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DopCanc", 5)
                loc_oPg2.txt_4c_DopCanc.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_DadosPg", 5)
                loc_oPg2.obj_4c_Opc_DadosPg.Value = 1
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_CampoNf", 5)
                loc_oPg2.obj_4c_Opt_CampoNf.Value = 1
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_EmiPor", 5)
                loc_oPg2.obj_4c_Opc_EmiPor.Value = 2
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Compet", 5)
                loc_oPg2.obj_4c_Opc_Compet.Value = 1
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_FiltContas", 5)
                loc_oPg2.obj_4c_Opc_FiltContas.Value = 2
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_Jobs", 5)
                loc_oPg2.obj_4c_Opt_Jobs.Value = 2
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Limcres", 5)
                loc_oPg2.obj_4c_Opc_Limcres.Value = 2
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Congvs", 5)
                loc_oPg2.chk_4c_Congvs.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_BlqTits", 5)
                loc_oPg2.chk_4c_BlqTits.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Espobrigs", 5)
                loc_oPg2.chk_4c_Espobrigs.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_LancCCEs", 5)
                loc_oPg2.chk_4c_LancCCEs.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_LancCCAs", 5)
                loc_oPg2.chk_4c_LancCCAs.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Obsobrigs", 5)
                loc_oPg2.chk_4c_Obsobrigs.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrCompet", 5)
                loc_oPg2.chk_4c_ObrCompet.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Mascara", 5)
                loc_oPg2.txt_4c_Mascara.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DiasVcto", 5)
                loc_oPg2.txt_4c_DiasVcto.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Juros", 5)
                loc_oPg2.txt_4c_Juros.Value = 0.0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 5)
                loc_oPg2.txt_4c_Moeda.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_VlrLimApv", 5)
                loc_oPg2.txt_4c_VlrLimApv.Value = 0.0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Pasta", 5)
                loc_oPg2.txt_4c_Pasta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo1", 5)
                loc_oPg2.txt_4c_Grupo1.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo2", 5)
                loc_oPg2.txt_4c_Grupo2.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo3", 5)
                loc_oPg2.txt_4c_Grupo3.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo4", 5)
                loc_oPg2.txt_4c_Grupo4.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt01", 5)
                loc_oPg2.txt_4c_Txt01.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt02", 5)
                loc_oPg2.txt_4c_Txt02.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt03", 5)
                loc_oPg2.txt_4c_Txt03.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt04", 5)
                loc_oPg2.txt_4c_Txt04.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad1", 5)
                loc_oPg2.txt_4c_GrpCad1.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad1", 5)
                loc_oPg2.txt_4c_DGrpCad1.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad2", 5)
                loc_oPg2.txt_4c_GrpCad2.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad2", 5)
                loc_oPg2.txt_4c_DGrpCad2.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad3", 5)
                loc_oPg2.txt_4c_GrpCad3.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad3", 5)
                loc_oPg2.txt_4c_DGrpCad3.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad4", 5)
                loc_oPg2.txt_4c_GrpCad4.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad4", 5)
                loc_oPg2.txt_4c_DGrpCad4.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class1", 5)
                loc_oPg2.txt_4c_Class1.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class2", 5)
                loc_oPg2.txt_4c_Class2.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class3", 5)
                loc_oPg2.txt_4c_Class3.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class4", 5)
                loc_oPg2.txt_4c_Class4.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC1", 5)
                loc_oPg2.chk_4c_ObrigC1.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC2", 5)
                loc_oPg2.chk_4c_ObrigC2.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC3", 5)
                loc_oPg2.chk_4c_ObrigC3.Value = 0
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC4", 5)
                loc_oPg2.chk_4c_ObrigC4.Value = 0
            ENDIF

            THIS.OpcRealprevChanged()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    *==========================================================================
        LOCAL loc_oPg2, loc_nTipo
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_nTipo = 1

        TRY
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_realprev", 5)
                loc_nTipo = loc_oPg2.obj_4c_Opc_realprev.Value
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_Dope", 5)
                loc_oPg2.txt_4c_Dope.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opcao_oper", 5)
                loc_oPg2.obj_4c_Opcao_oper.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Chk_Inativar", 5)
                loc_oPg2.chk_4c_Chk_Inativar.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Opdepo", 5)
                loc_oPg2.txt_4c_Opdepo.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Hists", 5)
                loc_oPg2.txt_4c_Hists.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Compl", 5)
                loc_oPg2.obj_4c_Opc_Compl.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Pend", 5)
                loc_oPg2.obj_4c_Opc_Pend.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_valprev", 5)
                loc_oPg2.obj_4c_Opc_valprev.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_blqcc", 5)
                loc_oPg2.obj_4c_Opc_blqcc.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Transporte", 5)
                loc_oPg2.obj_4c_Opc_Transporte.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Get_OutroTit", 5)
                loc_oPg2.obj_4c_Get_OutroTit.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Numtit", 5)
                loc_oPg2.obj_4c_Opc_Numtit.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Ident", 5)
                loc_oPg2.txt_4c_Ident.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_realprev", 5)
                loc_oPg2.obj_4c_Opc_realprev.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Vias", 5)
                loc_oPg2.txt_4c_Vias.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Impbol", 5)
                loc_oPg2.obj_4c_Opc_Impbol.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_imprimedoc", 5)
                loc_oPg2.obj_4c_Opc_imprimedoc.Enabled = par_lHabilitar
            ENDIF
            *-- DopReal: habilita s" + CHR(243) + " se par_lHabilitar E realprev=2
            IF PEMSTATUS(loc_oPg2, "txt_4c_DopReal", 5)
                loc_oPg2.txt_4c_DopReal.Enabled = par_lHabilitar AND (loc_nTipo = 2)
            ENDIF
            *-- DopCanc: habilita s" + CHR(243) + " se par_lHabilitar E realprev=1
            IF PEMSTATUS(loc_oPg2, "txt_4c_DopCanc", 5)
                loc_oPg2.txt_4c_DopCanc.Enabled = par_lHabilitar AND (loc_nTipo = 1)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_DadosPg", 5)
                loc_oPg2.obj_4c_Opc_DadosPg.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_CampoNf", 5)
                loc_oPg2.obj_4c_Opt_CampoNf.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_EmiPor", 5)
                loc_oPg2.obj_4c_Opc_EmiPor.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Compet", 5)
                loc_oPg2.obj_4c_Opc_Compet.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_FiltContas", 5)
                loc_oPg2.obj_4c_Opc_FiltContas.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opt_Jobs", 5)
                loc_oPg2.obj_4c_Opt_Jobs.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_Limcres", 5)
                loc_oPg2.obj_4c_Opc_Limcres.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Congvs", 5)
                loc_oPg2.chk_4c_Congvs.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_BlqTits", 5)
                loc_oPg2.chk_4c_BlqTits.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Espobrigs", 5)
                loc_oPg2.chk_4c_Espobrigs.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_LancCCEs", 5)
                loc_oPg2.chk_4c_LancCCEs.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_LancCCAs", 5)
                loc_oPg2.chk_4c_LancCCAs.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_Obsobrigs", 5)
                loc_oPg2.chk_4c_Obsobrigs.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrCompet", 5)
                loc_oPg2.chk_4c_ObrCompet.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Mascara", 5)
                loc_oPg2.txt_4c_Mascara.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DiasVcto", 5)
                loc_oPg2.txt_4c_DiasVcto.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Juros", 5)
                loc_oPg2.txt_4c_Juros.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 5)
                loc_oPg2.txt_4c_Moeda.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_VlrLimApv", 5)
                loc_oPg2.txt_4c_VlrLimApv.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Pasta", 5)
                loc_oPg2.txt_4c_Pasta.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "cmd_4c_BtnPastasCl", 5)
                loc_oPg2.cmd_4c_BtnPastasCl.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo1", 5)
                loc_oPg2.txt_4c_Grupo1.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo2", 5)
                loc_oPg2.txt_4c_Grupo2.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo3", 5)
                loc_oPg2.txt_4c_Grupo3.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo4", 5)
                loc_oPg2.txt_4c_Grupo4.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt01", 5)
                loc_oPg2.txt_4c_Txt01.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt02", 5)
                loc_oPg2.txt_4c_Txt02.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt03", 5)
                loc_oPg2.txt_4c_Txt03.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Txt04", 5)
                loc_oPg2.txt_4c_Txt04.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad1", 5)
                loc_oPg2.txt_4c_GrpCad1.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad2", 5)
                loc_oPg2.txt_4c_GrpCad2.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad3", 5)
                loc_oPg2.txt_4c_GrpCad3.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_GrpCad4", 5)
                loc_oPg2.txt_4c_GrpCad4.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class1", 5)
                loc_oPg2.txt_4c_Class1.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class2", 5)
                loc_oPg2.txt_4c_Class2.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class3", 5)
                loc_oPg2.txt_4c_Class3.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Class4", 5)
                loc_oPg2.txt_4c_Class4.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC1", 5)
                loc_oPg2.chk_4c_ObrigC1.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC2", 5)
                loc_oPg2.chk_4c_ObrigC2.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC3", 5)
                loc_oPg2.chk_4c_ObrigC3.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_ObrigC4", 5)
                loc_oPg2.chk_4c_ObrigC4.Enabled = par_lHabilitar
            ENDIF
            *-- Bot" + CHR(227) + "o Confirmar: s" + CHR(243) + " habilita em INCLUIR/ALTERAR
            IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
                IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                    loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE OpcRealprevChanged()
    *==========================================================================
        LOCAL loc_oPg2, loc_nTipo, loc_lHabilitar
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "obj_4c_Opc_realprev", 5)
                RETURN
            ENDIF

            loc_nTipo      = loc_oPg2.obj_4c_Opc_realprev.Value
            loc_lHabilitar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

            IF PEMSTATUS(loc_oPg2, "txt_4c_DopCanc", 5)
                loc_oPg2.txt_4c_DopCanc.Enabled = loc_lHabilitar AND (loc_nTipo = 1)
                IF loc_nTipo # 1
                    loc_oPg2.txt_4c_DopCanc.Value = ""
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DopReal", 5)
                loc_oPg2.txt_4c_DopReal.Enabled = loc_lHabilitar AND (loc_nTipo = 2)
                IF loc_nTipo # 2
                    loc_oPg2.txt_4c_DopReal.Value = ""
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.OpcRealprevChanged")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE ChkInativarChanged()
    *==========================================================================
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "chk_4c_Chk_Inativar", 5)
                RETURN
            ENDIF

            IF loc_oPg2.chk_4c_Chk_Inativar.Value
                IF PEMSTATUS(loc_oPg2, "obj_4c_Opc_realprev", 5)
                    loc_oPg2.obj_4c_Opc_realprev.Value = 1
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_DopCanc", 5)
                    loc_oPg2.txt_4c_DopCanc.Value   = ""
                    loc_oPg2.txt_4c_DopCanc.Enabled = .F.
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_DopReal", 5)
                    loc_oPg2.txt_4c_DopReal.Value   = ""
                    loc_oPg2.txt_4c_DopReal.Enabled = .F.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.ChkInativarChanged")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarOpdepo(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_oPg2, loc_cOpdepo, loc_oBusca, loc_cSQL, loc_nResult
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "txt_4c_Opdepo", 5)
                RETURN
            ENDIF
            loc_cOpdepo = ALLTRIM(loc_oPg2.txt_4c_Opdepo.Value)
            IF EMPTY(loc_cOpdepo)
                RETURN
            ENDIF

            *-- Testa match exato
            loc_cSQL    = "SELECT TOP 1 Operacaos FROM SigCdOpt WHERE Operacaos = " + EscaparSQL(loc_cOpdepo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpt")
            IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaOpt")
                RETURN
            ENDIF

            *-- Sem match exato - abre picker com todos registros
            IF USED("cursor_4c_BuscaOpt")
                USE IN cursor_4c_BuscaOpt
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
                "SELECT Operacaos, Descrs FROM SigCdOpt ORDER BY Operacaos", ;
                "cursor_4c_BuscaOpt")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Operacaos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs",    "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
                    loc_oPg2.txt_4c_Opdepo.Value = ALLTRIM(cursor_4c_BuscaOpt.Operacaos)
                ELSE
                    loc_oPg2.txt_4c_Opdepo.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.ValidarOpdepo")
        ENDTRY

        IF USED("cursor_4c_BuscaOpt")
            USE IN cursor_4c_BuscaOpt
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarDopReal(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_oPg2, loc_cDopReal, loc_cSQL, loc_nResult, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "txt_4c_DopReal", 5)
                RETURN
            ENDIF
            loc_cDopReal = ALLTRIM(loc_oPg2.txt_4c_DopReal.Value)
            IF EMPTY(loc_cDopReal)
                RETURN
            ENDIF

            loc_cSQL    = "SELECT Dopes FROM SigOpOpe WHERE RealPrevs <> 2"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpeR")

            IF loc_nResult > 0
                SELECT cursor_4c_TmpOpeR
                LOCATE FOR ALLTRIM(cursor_4c_TmpOpeR.Dopes) == ALLTRIM(loc_cDopReal)
                IF FOUND("cursor_4c_TmpOpeR")
                    loc_oPg2.txt_4c_DopReal.Value = ALLTRIM(cursor_4c_TmpOpeR.Dopes)
                ELSE
                    GO TOP IN cursor_4c_TmpOpeR
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_TmpOpeR"
                        loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_TmpOpeR")
                            loc_oPg2.txt_4c_DopReal.Value = ALLTRIM(cursor_4c_TmpOpeR.Dopes)
                        ELSE
                            loc_oPg2.txt_4c_DopReal.Value = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.ValidarDopReal")
        ENDTRY

        IF USED("cursor_4c_TmpOpeR")
            USE IN cursor_4c_TmpOpeR
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarDopCanc(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_oPg2, loc_cDopCanc, loc_cSQL, loc_nResult, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "txt_4c_DopCanc", 5)
                RETURN
            ENDIF
            loc_cDopCanc = ALLTRIM(loc_oPg2.txt_4c_DopCanc.Value)
            IF EMPTY(loc_cDopCanc)
                RETURN
            ENDIF

            loc_cSQL    = "SELECT Dopes FROM SigOpOpe WHERE OpeCancs = 1"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCanc")

            IF loc_nResult > 0
                SELECT cursor_4c_TmpCanc
                LOCATE FOR ALLTRIM(cursor_4c_TmpCanc.Dopes) == ALLTRIM(loc_cDopCanc)
                IF FOUND("cursor_4c_TmpCanc")
                    loc_oPg2.txt_4c_DopCanc.Value = ALLTRIM(cursor_4c_TmpCanc.Dopes)
                ELSE
                    GO TOP IN cursor_4c_TmpCanc
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_TmpCanc"
                        loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_TmpCanc")
                            loc_oPg2.txt_4c_DopCanc.Value = ALLTRIM(cursor_4c_TmpCanc.Dopes)
                        ELSE
                            loc_oPg2.txt_4c_DopCanc.Value = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.ValidarDopCanc")
        ENDTRY

        IF USED("cursor_4c_TmpCanc")
            USE IN cursor_4c_TmpCanc
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarVias(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_Vias", 5)
                IF loc_oPg2.txt_4c_Vias.Value < 0
                    MsgAviso("Valor Inv" + CHR(225) + "lido ...", "Vias Boleto")
                    loc_oPg2.txt_4c_Vias.Value = 0
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.ValidarVias")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarDiasVcto(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPg2, loc_oErro
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "txt_4c_DiasVcto", 5)
                IF loc_oPg2.txt_4c_DiasVcto.Value < 0
                    MsgAviso("Valor Inv" + CHR(225) + "lido ...", "Dias Vencimento")
                    loc_oPg2.txt_4c_DiasVcto.Value = 0
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.ValidarDiasVcto")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cMoeda, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "txt_4c_Moeda", 5)
                RETURN
            ENDIF
            loc_cMoeda = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)
            IF EMPTY(loc_cMoeda)
                RETURN
            ENDIF

            loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe")
            IF loc_nResult > 0
                SELECT cursor_4c_BuscaMoe
                LOCATE FOR ALLTRIM(cursor_4c_BuscaMoe.CMoes) == ALLTRIM(loc_cMoeda)
                IF FOUND("cursor_4c_BuscaMoe")
                    loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                ELSE
                    GO TOP IN cursor_4c_BuscaMoe
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMoe"
                        loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DMoes", "", "Moeda")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                            loc_oPg2.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                        ELSE
                            loc_oPg2.txt_4c_Moeda.Value = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.ValidarMoeda")
        ENDTRY

        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnPastasCClick()
    *==========================================================================
        LOCAL loc_oPg2, loc_cPasta, loc_oErro
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cPasta = GETDIR("", "Selecione a Pasta")
            IF !EMPTY(loc_cPasta)
                IF PEMSTATUS(loc_oPg2, "txt_4c_Pasta", 5)
                    loc_oPg2.txt_4c_Pasta.Value = loc_cPasta
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.BtnPastasCClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarGrpCad1s(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cCod, loc_cDesc, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "txt_4c_GrpCad1", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg2.txt_4c_GrpCad1.Value)
            IF EMPTY(loc_cCod)
                IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad1", 5)
                    loc_oPg2.txt_4c_DGrpCad1.Value = ""
                ENDIF
                RETURN
            ENDIF

            loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrpCad(loc_cCod)
            IF !EMPTY(loc_cDesc)
                IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad1", 5)
                    loc_oPg2.txt_4c_DGrpCad1.Value = loc_cDesc
                ENDIF
                RETURN
            ENDIF

            loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr1")
            IF loc_nResult > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr1"
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr1")
                        loc_oPg2.txt_4c_GrpCad1.Value = ALLTRIM(cursor_4c_BuscaGcr1.Codigos)
                        IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad1", 5)
                            loc_oPg2.txt_4c_DGrpCad1.Value = ALLTRIM(cursor_4c_BuscaGcr1.Descrs)
                        ENDIF
                    ELSE
                        loc_oPg2.txt_4c_GrpCad1.Value = ""
                        IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad1", 5)
                            loc_oPg2.txt_4c_DGrpCad1.Value = ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.ValidarGrpCad1s")
        ENDTRY

        IF USED("cursor_4c_BuscaGcr1")
            USE IN cursor_4c_BuscaGcr1
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarGrpCad2s(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cCod, loc_cDesc, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "txt_4c_GrpCad2", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg2.txt_4c_GrpCad2.Value)
            IF EMPTY(loc_cCod)
                IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad2", 5)
                    loc_oPg2.txt_4c_DGrpCad2.Value = ""
                ENDIF
                RETURN
            ENDIF

            loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrpCad(loc_cCod)
            IF !EMPTY(loc_cDesc)
                IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad2", 5)
                    loc_oPg2.txt_4c_DGrpCad2.Value = loc_cDesc
                ENDIF
                RETURN
            ENDIF

            loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr2")
            IF loc_nResult > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr2"
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr2")
                        loc_oPg2.txt_4c_GrpCad2.Value = ALLTRIM(cursor_4c_BuscaGcr2.Codigos)
                        IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad2", 5)
                            loc_oPg2.txt_4c_DGrpCad2.Value = ALLTRIM(cursor_4c_BuscaGcr2.Descrs)
                        ENDIF
                    ELSE
                        loc_oPg2.txt_4c_GrpCad2.Value = ""
                        IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad2", 5)
                            loc_oPg2.txt_4c_DGrpCad2.Value = ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.ValidarGrpCad2s")
        ENDTRY

        IF USED("cursor_4c_BuscaGcr2")
            USE IN cursor_4c_BuscaGcr2
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarGrpCad3s(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cCod, loc_cDesc, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "txt_4c_GrpCad3", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg2.txt_4c_GrpCad3.Value)
            IF EMPTY(loc_cCod)
                IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad3", 5)
                    loc_oPg2.txt_4c_DGrpCad3.Value = ""
                ENDIF
                RETURN
            ENDIF

            loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrpCad(loc_cCod)
            IF !EMPTY(loc_cDesc)
                IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad3", 5)
                    loc_oPg2.txt_4c_DGrpCad3.Value = loc_cDesc
                ENDIF
                RETURN
            ENDIF

            loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr3")
            IF loc_nResult > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr3"
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr3")
                        loc_oPg2.txt_4c_GrpCad3.Value = ALLTRIM(cursor_4c_BuscaGcr3.Codigos)
                        IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad3", 5)
                            loc_oPg2.txt_4c_DGrpCad3.Value = ALLTRIM(cursor_4c_BuscaGcr3.Descrs)
                        ENDIF
                    ELSE
                        loc_oPg2.txt_4c_GrpCad3.Value = ""
                        IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad3", 5)
                            loc_oPg2.txt_4c_DGrpCad3.Value = ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.ValidarGrpCad3s")
        ENDTRY

        IF USED("cursor_4c_BuscaGcr3")
            USE IN cursor_4c_BuscaGcr3
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarGrpCad4s(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cCod, loc_cDesc, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "txt_4c_GrpCad4", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg2.txt_4c_GrpCad4.Value)
            IF EMPTY(loc_cCod)
                IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad4", 5)
                    loc_oPg2.txt_4c_DGrpCad4.Value = ""
                ENDIF
                RETURN
            ENDIF

            loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrpCad(loc_cCod)
            IF !EMPTY(loc_cDesc)
                IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad4", 5)
                    loc_oPg2.txt_4c_DGrpCad4.Value = loc_cDesc
                ENDIF
                RETURN
            ENDIF

            loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr4")
            IF loc_nResult > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGcr4"
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr4")
                        loc_oPg2.txt_4c_GrpCad4.Value = ALLTRIM(cursor_4c_BuscaGcr4.Codigos)
                        IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad4", 5)
                            loc_oPg2.txt_4c_DGrpCad4.Value = ALLTRIM(cursor_4c_BuscaGcr4.Descrs)
                        ENDIF
                    ELSE
                        loc_oPg2.txt_4c_GrpCad4.Value = ""
                        IF PEMSTATUS(loc_oPg2, "txt_4c_DGrpCad4", 5)
                            loc_oPg2.txt_4c_DGrpCad4.Value = ""
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.ValidarGrpCad4s")
        ENDTRY

        IF USED("cursor_4c_BuscaGcr4")
            USE IN cursor_4c_BuscaGcr4
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarClass1s(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cCod, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "txt_4c_Class1", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg2.txt_4c_Class1.Value)
            IF EMPTY(loc_cCod)
                RETURN
            ENDIF

            loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss1")
            IF loc_nResult > 0
                SELECT cursor_4c_BuscaCss1
                LOCATE FOR ALLTRIM(cursor_4c_BuscaCss1.Classes) == ALLTRIM(loc_cCod)
                IF FOUND("cursor_4c_BuscaCss1")
                    loc_oPg2.txt_4c_Class1.Value = ALLTRIM(cursor_4c_BuscaCss1.Classes)
                ELSE
                    GO TOP IN cursor_4c_BuscaCss1
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss1"
                        loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss1")
                            loc_oPg2.txt_4c_Class1.Value = ALLTRIM(cursor_4c_BuscaCss1.Classes)
                        ELSE
                            loc_oPg2.txt_4c_Class1.Value = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.ValidarClass1s")
        ENDTRY

        IF USED("cursor_4c_BuscaCss1")
            USE IN cursor_4c_BuscaCss1
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarClass2s(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cCod, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "txt_4c_Class2", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg2.txt_4c_Class2.Value)
            IF EMPTY(loc_cCod)
                RETURN
            ENDIF

            loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss2")
            IF loc_nResult > 0
                SELECT cursor_4c_BuscaCss2
                LOCATE FOR ALLTRIM(cursor_4c_BuscaCss2.Classes) == ALLTRIM(loc_cCod)
                IF FOUND("cursor_4c_BuscaCss2")
                    loc_oPg2.txt_4c_Class2.Value = ALLTRIM(cursor_4c_BuscaCss2.Classes)
                ELSE
                    GO TOP IN cursor_4c_BuscaCss2
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss2"
                        loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss2")
                            loc_oPg2.txt_4c_Class2.Value = ALLTRIM(cursor_4c_BuscaCss2.Classes)
                        ELSE
                            loc_oPg2.txt_4c_Class2.Value = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.ValidarClass2s")
        ENDTRY

        IF USED("cursor_4c_BuscaCss2")
            USE IN cursor_4c_BuscaCss2
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarClass3s(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cCod, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "txt_4c_Class3", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg2.txt_4c_Class3.Value)
            IF EMPTY(loc_cCod)
                RETURN
            ENDIF

            loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss3")
            IF loc_nResult > 0
                SELECT cursor_4c_BuscaCss3
                LOCATE FOR ALLTRIM(cursor_4c_BuscaCss3.Classes) == ALLTRIM(loc_cCod)
                IF FOUND("cursor_4c_BuscaCss3")
                    loc_oPg2.txt_4c_Class3.Value = ALLTRIM(cursor_4c_BuscaCss3.Classes)
                ELSE
                    GO TOP IN cursor_4c_BuscaCss3
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss3"
                        loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss3")
                            loc_oPg2.txt_4c_Class3.Value = ALLTRIM(cursor_4c_BuscaCss3.Classes)
                        ELSE
                            loc_oPg2.txt_4c_Class3.Value = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.ValidarClass3s")
        ENDTRY

        IF USED("cursor_4c_BuscaCss3")
            USE IN cursor_4c_BuscaCss3
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ValidarClass4s(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cCod, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPg2, "txt_4c_Class4", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg2.txt_4c_Class4.Value)
            IF EMPTY(loc_cCod)
                RETURN
            ENDIF

            loc_cSQL    = "SELECT Classes, Descrs FROM SigCdCss WHERE LEN(RTRIM(Classes))=1 ORDER BY Classes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCss4")
            IF loc_nResult > 0
                SELECT cursor_4c_BuscaCss4
                LOCATE FOR ALLTRIM(cursor_4c_BuscaCss4.Classes) == ALLTRIM(loc_cCod)
                IF FOUND("cursor_4c_BuscaCss4")
                    loc_oPg2.txt_4c_Class4.Value = ALLTRIM(cursor_4c_BuscaCss4.Classes)
                ELSE
                    GO TOP IN cursor_4c_BuscaCss4
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCss4"
                        loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss4")
                            loc_oPg2.txt_4c_Class4.Value = ALLTRIM(cursor_4c_BuscaCss4.Classes)
                        ELSE
                            loc_oPg2.txt_4c_Class4.Value = ""
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.ValidarClass4s")
        ENDTRY

        IF USED("cursor_4c_BuscaCss4")
            USE IN cursor_4c_BuscaCss4
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    *==========================================================================
        LOCAL loc_oPg2, loc_oCnt, loc_lEdicao
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
                loc_oCnt = loc_oPg2.cnt_4c_BotoesAcao

                IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
                    loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lEdicao
                ENDIF

                IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
                    loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_nI, loc_nP, loc_oObjeto

        IF VARTYPE(par_oContainer) # "O"
            RETURN
        ENDIF

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
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
    *==========================================================================
        IF VARTYPE(par_oGrid) # "O"
            RETURN
        ENDIF

        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormOTI.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\OTIBO.prg):
*==============================================================================
* OTIBO.prg - Business Object para Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos
* Tabela principal: SigOpOpe (PK: dopes char(20))
* Tabela secund" + CHR(225) + "ria: SigCdPrg (acessos por opera" + CHR(231) + CHR(227) + "o)
* Migrado de: sigCDOTI.SCX
*==============================================================================

DEFINE CLASS OTIBO AS BusinessBase

    *-- Identifica" + CHR(231) + CHR(227) + "o do registro
    this_cDopes      = ""   && dopes      PK char(20) - descri" + CHR(231) + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o
    this_nNdopes     = 0    && ndopes     auto-gerado numeric(10,0)
    this_cOpers      = "CR" && opers      CR=cr" + CHR(233) + "dito / DB=d" + CHR(233) + "bito char(2)
    this_nOpeCancs   = 0    && opecancs   0=Ativo / 1=Cancelado numeric(1,0)

    *-- Opera" + CHR(231) + CHR(245) + "es relacionadas
    this_cDopereals  = ""   && dopereals  opera" + CHR(231) + CHR(227) + "o Realizado char(20)
    this_cDopCancs   = ""   && dopcancs   opera" + CHR(231) + CHR(227) + "o Cancelamento char(20)
    this_cOpdepos    = ""   && opdepos    opera" + CHR(231) + CHR(227) + "o Dep" + CHR(243) + "sito char(15)

    *-- Hist" + CHR(243) + "rico e texto
    this_cHists      = ""   && hists      hist" + CHR(243) + "rico padr" + CHR(227) + "o char(30)
    this_nTpHists    = 2    && tphists    tipo hist" + CHR(243) + "rico numeric(1,0)
    this_cIdentifics = ""   && identifics identificador char(1)
    this_cPastas     = ""   && pastas     caminho pasta (text NULL)

    *-- Configura" + CHR(231) + CHR(227) + "o do t" + CHR(237) + "tulo
    this_nDiasVcto   = 0    && diasvcto   dias vencimento numeric(2,0)
    this_nQtdBols    = 0    && qtdbols    qtd vias boleto numeric(2,0)
    this_cCnMascaras = ""   && cnmascaras m" + CHR(225) + "scara NF char(10)
    this_nJuros      = 0    && juros      juros di" + CHR(225) + "rio (%) numeric(4,2)
    this_cMoedas     = ""   && moedas     moeda totalizador char(3)
    this_nVlrLimApv  = 0    && vlrlimapv  valor limite aprova" + CHR(231) + CHR(227) + "o numeric(11,2)

    *-- Op" + CHR(231) + CHR(245) + "es (OptionGroups, valor 1-indexed)
    this_nDadosPgs   = 1    && dadospgs   dados pagamento numeric(1,0)
    this_nCampoNfs   = 1    && camponfs   campo NF numeric(1,0)
    this_nBlqccs     = 2    && blqccs     bloquear C/C numeric(1,0)
    this_nPendencias = 1    && pendencias pend" + CHR(234) + "ncias numeric(1,0)
    this_nRealprevs  = 1    && realprevs  real/previsto numeric(1,0)
    this_nEmiPorDesp = 2    && emipordesp emitente=portador numeric(1,0)
    this_nValprev    = 2    && valprev    valor previsto numeric(1,0)
    this_nTitauts    = 1    && titauts    n" + CHR(186) + " t" + CHR(237) + "tulo autom" + CHR(225) + "tico numeric(1,0)
    this_nImpbols    = 2    && impbols    imprime boleto numeric(1,0)
    this_nCompets    = 1    && compets    compet" + CHR(234) + "ncia numeric(1,0)
    this_nAltTrans   = 1    && alttrans   realizar apenas autorizados numeric(1,0)
    this_nOutTits    = 2    && outtits    outros t" + CHR(237) + "tulos auto numeric(1,0)
    this_nFiltContas = 2    && filtcontas filtra conta p/ grupo numeric(1,0)
    this_nJobs       = 2    && jobs       jobs numeric(1,0)
    this_nImpdocs    = 2    && impdocs    imprime documento numeric(1,0)
    this_nLimcres    = 2    && limcres    checar limite cr" + CHR(233) + "dito numeric(1,0)

    *-- Grupos padr" + CHR(227) + "o
    this_cGrupo1s    = ""   && grupo1s    emitente char(10)
    this_cGrupo2s    = ""   && grupo2s    portador char(10)
    this_cGrupo3s    = ""   && grupo3s    centro de custo char(10)
    this_cGrupo4s    = ""   && grupo4s    agente cobrador char(10)

    *-- Grupos cadastrais
    this_cGrpCad1s   = ""   && grpcad1s   grupo cadastral 1 char(10)
    this_cGrpCad2s   = ""   && grpcad2s   grupo cadastral 2 char(10)
    this_cGrpCad3s   = ""   && grpcad3s   grupo cadastral 3 char(10)
    this_cGrpCad4s   = ""   && grpcad4s   grupo cadastral 4 char(10)
    this_cDGrpCad1s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 1
    this_cDGrpCad2s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 2
    this_cDGrpCad3s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 3
    this_cDGrpCad4s  = ""   && descri" + CHR(231) + CHR(227) + "o exibi" + CHR(231) + CHR(227) + "o grupo cadastral 4

    *-- Classes cont" + CHR(225) + "beis char(1) - armazenadas como char no banco
    this_cClass1s    = ""   && class1s    classe cont" + CHR(225) + "bil 1 char(1)
    this_cClass2s    = ""   && class2s    classe cont" + CHR(225) + "bil 2 char(1)
    this_cClass3s    = ""   && class3s    classe cont" + CHR(225) + "bil 3 char(1)
    this_cClass4s    = ""   && class4s    classe cont" + CHR(225) + "bil 4 char(1)

    *-- T" + CHR(237) + "tulos dos campos
    this_cTxt01      = ""   && txt01      t" + CHR(237) + "tulo campo emitente char(15)
    this_cTxt02      = ""   && txt02      t" + CHR(237) + "tulo campo portador char(15)
    this_cTxt03      = ""   && txt03      t" + CHR(237) + "tulo campo centro custo char(15)
    this_cTxt04      = ""   && txt04      t" + CHR(237) + "tulo campo agente cobrador char(15)

    *-- Checkboxes (l" + CHR(243) + "gico; congvs=bit no banco, demais=numeric 0/1)
    this_lCongvs     = .F.  && congvs     bit NOT NULL
    this_lBlqTits    = .F.  && blqtits    numeric(1,0) NOT NULL
    this_lEspobrigs  = .F.  && espobrigs  numeric(1,0) NOT NULL
    this_lLancCCEs   = .F.  && lancCCEs   numeric(1,0) NOT NULL
    this_lLancCCAs   = .F.  && lancCCAs   numeric(1,0) NOT NULL
    this_lObsobrigs  = .F.  && obsobrigs  numeric(1,0) NOT NULL
    this_lObrigC1    = .F.  && obrigc1    numeric(1,0) NOT NULL
    this_lObrigC2    = .F.  && obrigc2    numeric(1,0) NOT NULL
    this_lObrigC3    = .F.  && obrigc3    numeric(1,0) NOT NULL
    this_lObrigC4    = .F.  && obrigc4    numeric(1,0) NOT NULL
    this_lObrCompet  = .F.  && obrcompet  numeric(1,0) NOT NULL

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpOpe"
            THIS.this_cCampoChave = "NDopes"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OTIBO.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN ALLTRIM(TRANSFORM(THIS.this_nNdopes))
    ENDPROC

    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = ""
            IF !EMPTY(par_cFiltro)
                loc_cWhere = " WHERE UPPER(dopes) LIKE '%" + UPPER(par_cFiltro) + "%'"
            ENDIF

            loc_cSQL = "SELECT dopes, opers, ndopes FROM SigOpOpe" + loc_cWhere + " ORDER BY dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (dopes C(20), opers C(2), ndopes N(10,0))
                    SET NULL OFF
                ENDIF
                IF !EOF("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar opera" + CHR(231) + CHR(245) + "es."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_nCodigo)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Reg")
                USE IN cursor_4c_Reg
            ENDIF

            loc_cSQL = "SELECT * FROM SigOpOpe WHERE NDopes = " + ALLTRIM(TRANSFORM(par_nCodigo))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Reg")

            IF loc_nResult >= 0 AND !EOF("cursor_4c_Reg")
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Reg")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado."
            ENDIF

            IF USED("cursor_4c_Reg")
                USE IN cursor_4c_Reg
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OTIBO.CarregarPorCodigo")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            IF EOF()
                loc_lResultado = .F.
            ENDIF

            THIS.this_cDopes      = ALLTRIM(dopes)
            THIS.this_nNdopes     = ndopes
            THIS.this_cOpers      = ALLTRIM(opers)
            THIS.this_nOpeCancs   = opecancs
            THIS.this_cDopereals  = ALLTRIM(dopereals)
            THIS.this_cDopCancs   = ALLTRIM(dopcancs)
            THIS.this_cOpdepos    = ALLTRIM(opdepos)
            THIS.this_cHists      = ALLTRIM(hists)
            THIS.this_nTpHists    = tphists
            THIS.this_cIdentifics = ALLTRIM(identifics)
            THIS.this_cPastas     = IIF(ISNULL(pastas), "", ALLTRIM(pastas))
            THIS.this_nDiasVcto   = diasvcto
            THIS.this_nQtdBols    = qtdbols
            THIS.this_cCnMascaras = ALLTRIM(cnmascaras)
            THIS.this_nJuros      = juros
            THIS.this_cMoedas     = ALLTRIM(moedas)
            THIS.this_nVlrLimApv  = vlrlimapv
            THIS.this_nDadosPgs   = dadospgs
            THIS.this_nCampoNfs   = camponfs
            THIS.this_nBlqccs     = blqccs
            THIS.this_nPendencias = pendencias
            THIS.this_nRealprevs  = realprevs
            THIS.this_nEmiPorDesp = emipordesp
            THIS.this_nValprev    = valprev
            THIS.this_nTitauts    = titauts
            THIS.this_nImpbols    = impbols
            THIS.this_nCompets    = compets
            THIS.this_nAltTrans   = alttrans
            THIS.this_nOutTits    = outtits
            THIS.this_nFiltContas = filtcontas
            THIS.this_nJobs       = jobs
            THIS.this_nImpdocs    = impdocs
            THIS.this_nLimcres    = limcres
            THIS.this_cGrupo1s    = ALLTRIM(grupo1s)
            THIS.this_cGrupo2s    = ALLTRIM(grupo2s)
            THIS.this_cGrupo3s    = ALLTRIM(grupo3s)
            THIS.this_cGrupo4s    = ALLTRIM(grupo4s)
            THIS.this_cGrpCad1s   = ALLTRIM(grpcad1s)
            THIS.this_cGrpCad2s   = ALLTRIM(grpcad2s)
            THIS.this_cGrpCad3s   = ALLTRIM(grpcad3s)
            THIS.this_cGrpCad4s   = ALLTRIM(grpcad4s)
            THIS.this_cClass1s    = ALLTRIM(class1s)
            THIS.this_cClass2s    = ALLTRIM(class2s)
            THIS.this_cClass3s    = ALLTRIM(class3s)
            THIS.this_cClass4s    = ALLTRIM(class4s)
            THIS.this_cTxt01      = ALLTRIM(txt01)
            THIS.this_cTxt02      = ALLTRIM(txt02)
            THIS.this_cTxt03      = ALLTRIM(txt03)
            THIS.this_cTxt04      = ALLTRIM(txt04)
            THIS.this_lCongvs     = (congvs <> 0)
            THIS.this_lBlqTits    = (blqtits <> 0)
            THIS.this_lEspobrigs  = (espobrigs <> 0)
            THIS.this_lLancCCEs   = (lancCCEs <> 0)
            THIS.this_lLancCCAs   = (lancCCAs <> 0)
            THIS.this_lObsobrigs  = (obsobrigs <> 0)
            THIS.this_lObrigC1    = (obrigc1 <> 0)
            THIS.this_lObrigC2    = (obrigc2 <> 0)
            THIS.this_lObrigC3    = (obrigc3 <> 0)
            THIS.this_lObrigC4    = (obrigc4 <> 0)
            THIS.this_lObrCompet  = (obrcompet <> 0)

            THIS.this_cDGrpCad1s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad1s)
            THIS.this_cDGrpCad2s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad2s)
            THIS.this_cDGrpCad3s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad3s)
            THIS.this_cDGrpCad4s  = THIS.BuscarDescricaoGrpCad(THIS.this_cGrpCad4s)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    FUNCTION ValidarDados()
    *==========================================================================
        IF EMPTY(THIS.this_cDopes)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.")
            RETURN .F.
        ENDIF
        IF THIS.this_nRealprevs = 2 AND EMPTY(THIS.this_cDopereals)
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Realizado obrigat" + CHR(243) + "ria quando tipo Previsto.")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    FUNCTION VerificarCodigoDuplicado()
    *==========================================================================
        LOCAL loc_nCount, loc_nResult
        loc_nCount = 0

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS total FROM SigOpOpe WHERE dopes = " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopes)), ;
                "cursor_4c_Dup")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Dup")
                loc_nCount = cursor_4c_Dup.total
            ENDIF
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN (loc_nCount > 0)
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterProximoNdopes()
    *==========================================================================
        LOCAL loc_nProximo, loc_nResult
        loc_nProximo = 1

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(ndopes),0)+1 AS proximo FROM SigOpOpe", ;
                "cursor_4c_NxtN")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_NxtN")
                loc_nProximo = cursor_4c_NxtN.proximo
            ENDIF
            IF USED("cursor_4c_NxtN")
                USE IN cursor_4c_NxtN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nProximo
    ENDPROC

    *==========================================================================
    FUNCTION BuscarDescricaoGrpCad(par_cCodigo)
    *==========================================================================
        LOCAL loc_cDescr, loc_nResult
        loc_cDescr = ""

        IF EMPTY(par_cCodigo)
            RETURN ""
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 descrs FROM SigCdGcr WHERE Codigos = " + ;
                EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_Gcr")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Gcr")
                loc_cDescr = ALLTRIM(cursor_4c_Gcr.descrs)
            ENDIF
            IF USED("cursor_4c_Gcr")
                USE IN cursor_4c_Gcr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cDescr
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InserirSigCdPrgSeNaoExiste(par_cProg, par_cParam, par_cDesc, par_cBarraForms)
    *==========================================================================
        LOCAL loc_nCount, loc_nResult, loc_cSQL
        loc_nCount = 0

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS total FROM SigCdPrg " + ;
                "WHERE Programas = " + EscaparSQL(par_cProg) + ;
                " AND RTRIM(Parametros) = " + EscaparSQL(RTRIM(par_cParam)), ;
                "cursor_4c_ChkPrg")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_ChkPrg")
                loc_nCount = cursor_4c_ChkPrg.total
            ENDIF
            IF USED("cursor_4c_ChkPrg")
                USE IN cursor_4c_ChkPrg
            ENDIF

            IF loc_nCount = 0
                loc_cSQL = "INSERT INTO SigCdPrg " + ;
                    "(Descricaos, Parametros, Programas, pkChaves, barraforms, barrapict) VALUES (" + ;
                    EscaparSQL(par_cDesc)       + ", " + ;
                    EscaparSQL(par_cParam)      + ", " + ;
                    EscaparSQL(par_cProg)       + ", " + ;
                    EscaparSQL(fUniqueIds())    + ", " + ;
                    EscaparSQL(par_cBarraForms) + ", " + ;
                    "''" + ")"
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CriarEntradasSigCdPrg(par_cDopes, par_nNdopes)
    *==========================================================================
        LOCAL loc_cProg, loc_cDesc, loc_cBarra
        loc_cProg  = "C" + PADL(TRANSFORM(par_nNdopes), 8, "0")
        loc_cDesc  = "Menu - Financeiro - T" + CHR(237) + "tulos - " + PROPER(ALLTRIM(par_cDopes))
        loc_cBarra = "SIGPGTIT WITH '" + ALLTRIM(par_cDopes) + "'"

        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "",          loc_cDesc,                                                                               loc_cBarra)
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "INSERIR",   loc_cDesc + " - [Inserir]",                                                             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTERAR",   loc_cDesc + " - [Alterar]",                                                             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "EXCLUIR",   loc_cDesc + " - [Excluir]",                                                             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LISTAR",    loc_cDesc + " - [Listar]",                                                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "TITULO",    loc_cDesc + " - [T" + CHR(237) + "tulo]",                                               "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "OCORR",     loc_cDesc + " - [Ocorr" + CHR(234) + "ncias]",                                          "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTDATAS",  loc_cDesc + " - [Alterar Datas]",                                                       "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIBVENCS",  loc_cDesc + " - [N" + CHR(227) + "o Checa Vcto. X Emiss" + CHR(227) + "o]",             "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "TRFREAL",   loc_cDesc + " - [Transfere para C/C]",                                                  "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LISTAGERAL",loc_cDesc + " - [Lista Geral]",                                                         "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "TRFPREV",   loc_cDesc + " - [Transfere p/ Previs" + CHR(227) + "o]",                                "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTCC",     loc_cDesc + " - [Altera Centro de Custo]",                                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "CANCELA",   loc_cDesc + " - [Cancelamento do T" + CHR(237) + "tulo ]",                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "PRORROGAR", loc_cDesc + " - [Prorrogar T" + CHR(237) + "tulo ]",                                    "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "CONFERIR",  loc_cDesc + " - [Conferir T" + CHR(237) + "tulo ]",                                     "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTERAAGC", loc_cDesc + " - [Altera Agente Cobrador]",                                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "AUTOBLQ",   loc_cDesc + " - [Inibir Alerta de Fora do Per" + CHR(237) + "odo]",                     "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIMPADTT",  loc_cDesc + " - [Desmarca Transporte]",                                                 "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "SUBSTITUI", loc_cDesc + " - [Substitui" + CHR(231) + CHR(227) + "o de T" + CHR(237) + "tulo]",      "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "FOLLOWUP",  loc_cDesc + " - [Follow up de Conta]",                                                  "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "FOLLOWUPI", loc_cDesc + " - [Follow up de Lan" + CHR(231) + "amento]",                              "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "BLOQVENCS", loc_cDesc + " - [Bloqueio de T" + CHR(237) + "tulos Vencidos]",                         "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTARQCON", loc_cDesc + " - [Altera Arq. Relac. na Consulta]",                                      "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "BLQDTLANC", loc_cDesc + " - [N" + CHR(227) + "o Altera Data de Lan" + CHR(231) + "amento]",         "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "MULTIAPROV",loc_cDesc + " - [Permite Aprovar Mais de um T" + CHR(237) + "tulo]",                    "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "APVVLRSUP", loc_cDesc + " - [Permite Aprovar Um T" + CHR(237) + "tulo Com Valor Acima do Permitido.]","")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "ALTERAVENC",loc_cDesc + " - [Permite Prorrogar o Vencimento.]",                                     "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "OUTRESPONS",loc_cDesc + " - [Permite Aprovar T" + CHR(237) + "tulos de Outros Respons" + CHR(225) + "veis.]","")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "OBSRESUMO", loc_cDesc + " - [Observa" + CHR(231) + CHR(227) + "o resumida.]",                       "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIBAPROV",  loc_cDesc + " - [Permite Alterar T" + CHR(237) + "tulos Aprovados.]",                   "")
        THIS.InserirSigCdPrgSeNaoExiste(loc_cProg, "LIBCARTAO", loc_cDesc + " - [Libera Visualizar Cart" + CHR(245) + "es.]",                           "")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_nNdopes = THIS.ObterProximoNdopes()

            loc_cSQL = "INSERT INTO SigOpOpe (" + ;
                "dopes, ndopes, ordes, datas, opers, " + ;
                "opdepos, hists, tphists, fixgrupes, grupoeps, identifics, " + ;
                "titauts, txt01, txt02, txt03, txt04, impbols, " + ;
                "grupo1s, grupo2s, grupo3s, grupo4s, " + ;
                "grpcad1s, grpcad2s, grpcad3s, grpcad4s, " + ;
                "valprev, qtdbols, compets, congvs, " + ;
                "dopereals, pendencias, realprevs, blqccs, alttrans, bloqueios, " + ;
                "impdocs, cnmascaras, dopcancs, opecancs, " + ;
                "blqtits, outtits, soldocs, camponfs, dadospgs, espobrigs, " + ;
                "juros, filtcontas, lancCCAs, lancCCEs, obsobrigs, jobs, " + ;
                "class1s, class2s, class3s, class4s, buscanome, " + ;
                "diasvcto, emipordesp, limcres, moedas, obrcompet, " + ;
                "obrigc1, obrigc2, obrigc3, obrigc4, " + ;
                "pastas, vlrlimapv, InibEmpHst, edthists, rateiocf" + ;
                ") VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopes))      + ", " + ;
                FormatarNumeroSQL(THIS.this_nNdopes)        + ", " + ;
                "0, GETDATE(), "                           + ;
                EscaparSQL(ALLTRIM(THIS.this_cOpers))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cOpdepos))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cHists))       + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpHists)       + ", " + ;
                "0, '', "                                  + ;
                EscaparSQL(ALLTRIM(THIS.this_cIdentifics))  + ", " + ;
                FormatarNumeroSQL(THIS.this_nTitauts)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt01))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt02))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt03))       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cTxt04))       + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpbols)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo1s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo2s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo3s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupo4s))     + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad1s))    + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad2s))    + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad3s))    + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrpCad4s))    + ", " + ;
                FormatarNumeroSQL(THIS.this_nValprev)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtdBols)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nCompets)       + ", " + ;
                IIF(THIS.this_lCongvs,   "1", "0")         + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopereals))   + ", " + ;
                FormatarNumeroSQL(THIS.this_nPendencias)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nRealprevs)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nBlqccs)        + ", " + ;
                FormatarNumeroSQL(THIS.this_nAltTrans)      + ", " + ;
                "0, "                                      + ;
                FormatarNumeroSQL(THIS.this_nImpdocs)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cCnMascaras))  + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopCancs))    + ", " + ;
                FormatarNumeroSQL(THIS.this_nOpeCancs)      + ", " + ;
                IIF(THIS.this_lBlqTits,   "1", "0")        + ", " + ;
                FormatarNumeroSQL(THIS.this_nOutTits)       + ", " + ;
                "0, "                                      + ;
                FormatarNumeroSQL(THIS.this_nCampoNfs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nDadosPgs)      + ", " + ;
                IIF(THIS.this_lEspobrigs, "1", "0")        + ", " + ;
                FormatarNumeroSQL(THIS.this_nJuros)         + ", " + ;
                FormatarNumeroSQL(THIS.this_nFiltContas)    + ", " + ;
                IIF(THIS.this_lLancCCAs,  "1", "0")        + ", " + ;
                IIF(THIS.this_lLancCCEs,  "1", "0")        + ", " + ;
                IIF(THIS.this_lObsobrigs, "1", "0")        + ", " + ;
                FormatarNumeroSQL(THIS.this_nJobs)          + ", " + ;
                EscaparSQL(THIS.this_cClass1s)              + ", " + ;
                EscaparSQL(THIS.this_cClass2s)              + ", " + ;
                EscaparSQL(THIS.this_cClass3s)              + ", " + ;
                EscaparSQL(THIS.this_cClass4s)              + ", " + ;
                "0, "                                      + ;
                FormatarNumeroSQL(THIS.this_nDiasVcto)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nEmiPorDesp)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nLimcres)       + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoedas))      + ", " + ;
                IIF(THIS.this_lObrCompet, "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC1,   "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC2,   "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC3,   "1", "0")        + ", " + ;
                IIF(THIS.this_lObrigC4,   "1", "0")        + ", " + ;
                IIF(EMPTY(THIS.this_cPastas), "NULL", EscaparSQL(THIS.this_cPastas)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrLimApv)    + ", " + ;
                "0, 0, 0)"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.CriarEntradasSigCdPrg(THIS.this_cDopes, THIS.this_nNdopes)
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir opera" + CHR(231) + CHR(227) + "o."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpOpe SET " + ;
                "opers       = " + EscaparSQL(ALLTRIM(THIS.this_cOpers))      + ", " + ;
                "opdepos     = " + EscaparSQL(ALLTRIM(THIS.this_cOpdepos))    + ", " + ;
                "hists       = " + EscaparSQL(ALLTRIM(THIS.this_cHists))      + ", " + ;
                "tphists     = " + FormatarNumeroSQL(THIS.this_nTpHists)      + ", " + ;
                "identifics  = " + EscaparSQL(ALLTRIM(THIS.this_cIdentifics)) + ", " + ;
                "titauts     = " + FormatarNumeroSQL(THIS.this_nTitauts)      + ", " + ;
                "txt01       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt01))      + ", " + ;
                "txt02       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt02))      + ", " + ;
                "txt03       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt03))      + ", " + ;
                "txt04       = " + EscaparSQL(ALLTRIM(THIS.this_cTxt04))      + ", " + ;
                "impbols     = " + FormatarNumeroSQL(THIS.this_nImpbols)      + ", " + ;
                "grupo1s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo1s))    + ", " + ;
                "grupo2s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo2s))    + ", " + ;
                "grupo3s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo3s))    + ", " + ;
                "grupo4s     = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo4s))    + ", " + ;
                "grpcad1s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad1s))   + ", " + ;
                "grpcad2s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad2s))   + ", " + ;
                "grpcad3s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad3s))   + ", " + ;
                "grpcad4s    = " + EscaparSQL(ALLTRIM(THIS.this_cGrpCad4s))   + ", " + ;
                "valprev     = " + FormatarNumeroSQL(THIS.this_nValprev)      + ", " + ;
                "qtdbols     = " + FormatarNumeroSQL(THIS.this_nQtdBols)      + ", " + ;
                "compets     = " + FormatarNumeroSQL(THIS.this_nCompets)      + ", " + ;
                "congvs      = " + IIF(THIS.this_lCongvs,   "1", "0")        + ", " + ;
                "dopereals   = " + EscaparSQL(ALLTRIM(THIS.this_cDopereals))  + ", " + ;
                "pendencias  = " + FormatarNumeroSQL(THIS.this_nPendencias)   + ", " + ;
                "realprevs   = " + FormatarNumeroSQL(THIS.this_nRealprevs)    + ", " + ;
                "blqccs      = " + FormatarNumeroSQL(THIS.this_nBlqccs)       + ", " + ;
                "alttrans    = " + FormatarNumeroSQL(THIS.this_nAltTrans)     + ", " + ;
                "impdocs     = " + FormatarNumeroSQL(THIS.this_nImpdocs)      + ", " + ;
                "cnmascaras  = " + EscaparSQL(ALLTRIM(THIS.this_cCnMascaras)) + ", " + ;
                "dopcancs    = " + EscaparSQL(ALLTRIM(THIS.this_cDopCancs))   + ", " + ;
                "blqtits     = " + IIF(THIS.this_lBlqTits,   "1", "0")       + ", " + ;
                "outtits     = " + FormatarNumeroSQL(THIS.this_nOutTits)      + ", " + ;
                "camponfs    = " + FormatarNumeroSQL(THIS.this_nCampoNfs)     + ", " + ;
                "dadospgs    = " + FormatarNumeroSQL(THIS.this_nDadosPgs)     + ", " + ;
                "espobrigs   = " + IIF(THIS.this_lEspobrigs, "1", "0")       + ", " + ;
                "juros       = " + FormatarNumeroSQL(THIS.this_nJuros)        + ", " + ;
                "filtcontas  = " + FormatarNumeroSQL(THIS.this_nFiltContas)   + ", " + ;
                "lancCCAs    = " + IIF(THIS.this_lLancCCAs,  "1", "0")       + ", " + ;
                "lancCCEs    = " + IIF(THIS.this_lLancCCEs,  "1", "0")       + ", " + ;
                "obsobrigs   = " + IIF(THIS.this_lObsobrigs, "1", "0")       + ", " + ;
                "jobs        = " + FormatarNumeroSQL(THIS.this_nJobs)         + ", " + ;
                "class1s     = " + EscaparSQL(THIS.this_cClass1s)             + ", " + ;
                "class2s     = " + EscaparSQL(THIS.this_cClass2s)             + ", " + ;
                "class3s     = " + EscaparSQL(THIS.this_cClass3s)             + ", " + ;
                "class4s     = " + EscaparSQL(THIS.this_cClass4s)             + ", " + ;
                "diasvcto    = " + FormatarNumeroSQL(THIS.this_nDiasVcto)     + ", " + ;
                "emipordesp  = " + FormatarNumeroSQL(THIS.this_nEmiPorDesp)   + ", " + ;
                "limcres     = " + FormatarNumeroSQL(THIS.this_nLimcres)      + ", " + ;
                "moedas      = " + EscaparSQL(ALLTRIM(THIS.this_cMoedas))     + ", " + ;
                "obrcompet   = " + IIF(THIS.this_lObrCompet, "1", "0")       + ", " + ;
                "obrigc1     = " + IIF(THIS.this_lObrigC1,   "1", "0")       + ", " + ;
                "obrigc2     = " + IIF(THIS.this_lObrigC2,   "1", "0")       + ", " + ;
                "obrigc3     = " + IIF(THIS.this_lObrigC3,   "1", "0")       + ", " + ;
                "obrigc4     = " + IIF(THIS.this_lObrigC4,   "1", "0")       + ", " + ;
                "pastas      = " + IIF(EMPTY(THIS.this_cPastas), "NULL", EscaparSQL(THIS.this_cPastas)) + ", " + ;
                "vlrlimapv   = " + FormatarNumeroSQL(THIS.this_nVlrLimApv)   + ;
                " WHERE NDopes = " + ALLTRIM(TRANSFORM(THIS.this_nNdopes))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.CriarEntradasSigCdPrg(THIS.this_cDopes, THIS.this_nNdopes)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar opera" + CHR(231) + CHR(227) + "o."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigOpOpe WHERE NDopes = " + ALLTRIM(TRANSFORM(THIS.this_nNdopes)))
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir opera" + CHR(231) + CHR(227) + "o."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OTIBO.ExecutarExclusao")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_aCursors[8], loc_i
        loc_aCursors[1] = "cursor_4c_Dados"
        loc_aCursors[2] = "cursor_4c_Reg"
        loc_aCursors[3] = "cursor_4c_Dup"
        loc_aCursors[4] = "cursor_4c_NxtN"
        loc_aCursors[5] = "cursor_4c_Gcr"
        loc_aCursors[6] = "cursor_4c_ChkPrg"
        loc_aCursors[7] = "cursor_4c_Lista"
        loc_aCursors[8] = "cursor_4c_Busca"
        FOR loc_i = 1 TO 8
            IF USED(loc_aCursors[loc_i])
                USE IN (loc_aCursors[loc_i])
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

ENDDEFINE

