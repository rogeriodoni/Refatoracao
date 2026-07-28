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
[25/07/2026 00:55:18] Erro: Erro em Formcfi.InicializarForm:Property TABSTRETCH is read-only.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-25 00:54:39] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-25 00:54:39] [INFO] Config FPW: (nao fornecido)
[2026-07-25 00:54:39] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-25 00:54:39] [INFO] Timeout: 300 segundos
[2026-07-25 00:54:39] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s0ny2vj3.prg
[2026-07-25 00:54:39] [INFO] Conteudo do wrapper:
[2026-07-25 00:54:39] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formcfi', 'C:\4c\tasks\task365', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcfi', 'C:\4c\tasks\task365', 'CRUD'
QUIT

[2026-07-25 00:54:39] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s0ny2vj3.prg
[2026-07-25 00:54:39] [INFO] VFP output esperado em: C:\4c\tasks\task365\vfp_output.txt
[2026-07-25 00:54:39] [INFO] Executando Visual FoxPro 9...
[2026-07-25 00:54:39] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s0ny2vj3.prg
[2026-07-25 00:54:39] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s0ny2vj3.prg
[2026-07-25 00:54:39] [INFO] Timeout configurado: 300 segundos
[2026-07-25 00:55:18] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-25 00:55:18] [INFO] VFP9 finalizado em 38.4086872 segundos
[2026-07-25 00:55:18] [INFO] Exit Code: 
[2026-07-25 00:55:18] [INFO] 
[2026-07-25 00:55:18] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-25 00:55:18] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_s0ny2vj3.prg
[2026-07-25 00:55:18] [INFO] 
[2026-07-25 00:55:18] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-25 00:55:18] [INFO] * Auto-generated wrapper for parameters
[2026-07-25 00:55:18] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-25 00:55:18] [INFO] * Parameters: 'Formcfi', 'C:\4c\tasks\task365', 'CRUD'
[2026-07-25 00:55:18] [INFO] 
[2026-07-25 00:55:18] [INFO] * Anti-dialog protections for unattended execution
[2026-07-25 00:55:18] [INFO] SET SAFETY OFF
[2026-07-25 00:55:18] [INFO] SET RESOURCE OFF
[2026-07-25 00:55:18] [INFO] SET TALK OFF
[2026-07-25 00:55:18] [INFO] SET NOTIFY OFF
[2026-07-25 00:55:18] [INFO] SYS(2335, 0)
[2026-07-25 00:55:18] [INFO] 
[2026-07-25 00:55:18] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcfi', 'C:\4c\tasks\task365', 'CRUD'
[2026-07-25 00:55:18] [INFO] QUIT
[2026-07-25 00:55:18] [INFO] 
[2026-07-25 00:55:18] [INFO] === Fim do Wrapper.prg ===
[2026-07-25 00:55:18] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formcfi",
  "timestamp": "20260725005518",
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfi.prg):
*==============================================================================
* Formcfi.prg - Formulario CRUD para ICMS Cupom Fiscal (SIGCDCFI)
*==============================================================================
* Herda de : FormBase
* BO       : cfiBO
* Tabela   : SIGCDCFI
* Caption  : "ICMS - Cupom Fiscal"
* Fase 8/8 : COMPLETO - todos os metodos implementados
*==============================================================================

DEFINE CLASS Formcfi AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "ICMS - Cupom Fiscal"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de controle
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("cfiBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar cfiBO", "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Formcfi.InicializarForm:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *--------------------------------------------------------------------------
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        THIS.pgf_4c_Paginas.PageCount = 2
        WITH THIS.pgf_4c_Paginas
            .Top        = -29
            .Left       = 0
            .Width      = THIS.Width
            .Height     = THIS.Height + 29
            .Tabs       = .F.
            .TabStretch = 1
            .Visible    = .T.
            .Page1.Caption   = "Lista"
            .Page2.Caption   = "Dados"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page2.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *--------------------------------------------------------------------------
        LOCAL loc_oPagina, loc_oCnt
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho cinza escuro
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

        *-- Container botoes CRUD (lado direito - canonico Left=542)
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
        ENDWITH

        loc_oCnt = loc_oPagina.cnt_4c_Botoes

        loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Incluir
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Visualizar
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Alterar
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Excluir
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Buscar
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar canonico (Left=917, Width=90, Height=85)
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista (5 colunas: grupos, ests, icms, tpicms, tptribs)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 498
            .ColumnCount        = 5
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .FontName           = "Verdana"
            .FontSize           = 8
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *--------------------------------------------------------------------------
        LOCAL loc_oPagina, loc_oCnt
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH
        loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao

        loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Confirmar
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Cancelar
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
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Linha 1: Grupo (Say8 + txt_4c_Cgru + txt_4c_Dgru)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Grupo : "
            .Top       = 173
            .Left      = 262
            .Width     = 50
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cgru", "TextBox")
        WITH loc_oPagina.txt_4c_Cgru
            .Top       = 170
            .Left      = 311
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Verdana"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Cgru, "KeyPress", THIS, "ValidarGrupo")

        loc_oPagina.AddObject("txt_4c_Dgru", "TextBox")
        WITH loc_oPagina.txt_4c_Dgru
            .Top       = 170
            .Left      = 344
            .Width     = 150
            .Height    = 23
            .MaxLength = 20
            .FontName  = "Verdana"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Dgru, "KeyPress", THIS, "ValidarGrupoDesc")

        *-- Linha 2: Estado (Say3 + txt_4c_Estado)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Estado : "
            .Top       = 198
            .Left      = 259
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Estado", "TextBox")
        WITH loc_oPagina.txt_4c_Estado
            .Top       = 195
            .Left      = 311
            .Width     = 24
            .Height    = 23
            .MaxLength = 2
            .Format    = "K!"
            .FontName  = "Verdana"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Estado, "KeyPress", THIS, "ValidarEstado")

        *-- Linha 3: Aliq. ICMS (Say2 + txt_4c_Icm)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Aliq. (%) : "
            .Top       = 223
            .Left      = 246
            .Width     = 66
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Icm", "TextBox")
        WITH loc_oPagina.txt_4c_Icm
            .Top       = 220
            .Left      = 311
            .Width     = 52
            .Height    = 23
            .InputMask = "999.99"
            .FontName  = "Verdana"
            .FontSize  = 8
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Linha 4: Tipo ICMS (txt_4c_Tpicm + Say1 + Say4)
        loc_oPagina.AddObject("txt_4c_Tpicm", "TextBox")
        WITH loc_oPagina.txt_4c_Tpicm
            .Top       = 245
            .Left      = 311
            .Width     = 17
            .Height    = 23
            .MaxLength = 1
            .Format    = "K!"
            .FontName  = "Verdana"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Tipo : "
            .Top       = 248
            .Left      = 273
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "(T / S / I / N / F)"
            .Top       = 248
            .Left      = 333
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Linha 5: Tipo de Tributacao do ICMS (Say5 + txt_4c_TpTrib)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o do ICMS : "
            .Top       = 275
            .Left      = 138
            .Width     = 174
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_TpTrib", "TextBox")
        WITH loc_oPagina.txt_4c_TpTrib
            .Top       = 270
            .Left      = 311
            .Width     = 38
            .Height    = 23
            .MaxLength = 4
            .FontName  = "Verdana"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_TpTrib, "KeyPress", THIS, "ValidarTpTrib")

        *-- Linha 6: Situacao Tributaria ICMS (Say6 + txt_4c_Sittricm + txt_4c_Dsittricm)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS :"
            .Top       = 300
            .Left      = 154
            .Width     = 154
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Sittricm", "TextBox")
        WITH loc_oPagina.txt_4c_Sittricm
            .Top       = 295
            .Left      = 311
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Verdana"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Sittricm, "KeyPress", THIS, "ValidarSittricm")

        loc_oPagina.AddObject("txt_4c_Dsittricm", "TextBox")
        WITH loc_oPagina.txt_4c_Dsittricm
            .Top       = 295
            .Left      = 344
            .Width     = 290
            .Height    = 23
            .MaxLength = 40
            .Format    = "!"
            .FontName  = "Verdana"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Dsittricm, "KeyPress", THIS, "ValidarDsittricm")

        *-- Linha 7: CFOP (Say7 + txt_4c_Cfop) + Classificacao Fiscal (Say14 + txt_4c_Clfiscals)
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Cfop : "
            .Top       = 324
            .Left      = 269
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cfop", "TextBox")
        WITH loc_oPagina.txt_4c_Cfop
            .Top       = 321
            .Left      = 311
            .Width     = 47
            .Height    = 23
            .MaxLength = 10
            .Format    = "K!"
            .FontName  = "Verdana"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Cfop, "KeyPress", THIS, "ValidarCfop")

        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal : "
            .Top       = 324
            .Left      = 398
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Clfiscals", "TextBox")
        WITH loc_oPagina.txt_4c_Clfiscals
            .Top       = 321
            .Left      = 521
            .Width     = 111
            .Height    = 23
            .MaxLength = 10
            .Format    = "K!"
            .FontName  = "Verdana"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Clfiscals, "KeyPress", THIS, "ValidarClfiscals")

        *-- Shape decorativo da secao SAT
        loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPagina.shp_4c_Shape1
            .Top         = 389
            .Left        = 131
            .Width       = 505
            .Height      = 112
            .BackStyle   = 1
            .BorderColor = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        *-- Label secao Informacoes SAT (Say13)
        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "Informa" + CHR(231) + CHR(245) + "es especificas de Servi" + CHR(231) + "o (SAT)"
            .Top       = 374
            .Left      = 132
            .Width     = 242
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Linha 8: Aliq. ISSQN (Say11 + txt_4c_Issqn)
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "Aliq. ISSQN (%) : "
            .Top       = 399
            .Left      = 201
            .Width     = 108
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Issqn", "TextBox")
        WITH loc_oPagina.txt_4c_Issqn
            .Top       = 396
            .Left      = 311
            .Width     = 57
            .Height    = 23
            .InputMask = "999.99"
            .FontName  = "Verdana"
            .FontSize  = 8
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Linha 9: Item da Lista de Servicos (Say9 + txt_4c_Itemls)
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "Item da Lista de Servi" + CHR(231) + "os : "
            .Top       = 426
            .Left      = 148
            .Width     = 161
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Itemls", "TextBox")
        WITH loc_oPagina.txt_4c_Itemls
            .Top       = 421
            .Left      = 311
            .Width     = 57
            .Height    = 23
            .MaxLength = 5
            .FontName  = "Verdana"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Linha 10: Codigo Tributacao (Say10 + txt_4c_CodTrib)
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "Codigo Tributa" + CHR(231) + CHR(227) + "o : "
            .Top       = 451
            .Left      = 190
            .Width     = 119
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CodTrib", "TextBox")
        WITH loc_oPagina.txt_4c_CodTrib
            .Top       = 446
            .Left      = 311
            .Width     = 179
            .Height    = 23
            .MaxLength = 20
            .FontName  = "Verdana"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Linha 11: Natureza da Operacao (Say12 + txt_4c_NatOpe)
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "Natureza da Opera" + CHR(231) + CHR(227) + "o : "
            .Top       = 475
            .Left      = 166
            .Width     = 143
            .FontName  = "Verdana"
            .FontSize  = 8
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_NatOpe", "TextBox")
        WITH loc_oPagina.txt_4c_NatOpe
            .Top       = 471
            .Left      = 311
            .Width     = 38
            .Height    = 23
            .MaxLength = 4
            .FontName  = "Verdana"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca dados e vincula ao grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF THIS.this_oBusinessObject.Buscar("")
                *-- RecordSource + ColumnCount FORA do WITH (evita Unknown member)
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.ColumnCount  = 10

                WITH loc_oGrid
                    .Column1.ControlSource  = "cursor_4c_Dados.grupos"
                    .Column2.ControlSource  = "cursor_4c_Dados.ests"
                    .Column3.ControlSource  = "cursor_4c_Dados.icms"
                    .Column4.ControlSource  = "cursor_4c_Dados.tpicms"
                    .Column5.ControlSource  = "cursor_4c_Dados.tptribs"
                    .Column6.ControlSource  = "cursor_4c_Dados.cfops"
                    .Column7.ControlSource  = "cursor_4c_Dados.issqn"
                    .Column8.ControlSource  = "cursor_4c_Dados.itemls"
                    .Column9.ControlSource  = "cursor_4c_Dados.codtrib"
                    .Column10.ControlSource = "cursor_4c_Dados.natope"
                    .Column1.Width  = 40
                    .Column2.Width  = 40
                    .Column3.Width  = 60
                    .Column4.Width  = 40
                    .Column5.Width  = 80
                    .Column6.Width  = 60
                    .Column7.Width  = 60
                    .Column8.Width  = 100
                    .Column9.Width  = 130
                    .Column10.Width = 40
                    *-- Headers APOS RecordSource (obrigatorio)
                    .Column1.Header1.Caption  = "Grupo"
                    .Column2.Header1.Caption  = "Estado"
                    .Column3.Header1.Caption  = "Aliq. (%)"
                    .Column4.Header1.Caption  = "Tipo"
                    .Column5.Header1.Caption  = "Tipo Trib."
                    .Column6.Header1.Caption  = "CFOP"
                    .Column7.Header1.Caption  = "Aliq Iss"
                    .Column8.Header1.Caption  = "Item Lista Serv"
                    .Column9.Header1.Caption  = "Cod Tributa" + CHR(231) + CHR(227) + "o"
                    .Column10.Header1.Caption = "Nat Oper"
                ENDWITH

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Formcfi.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
    *--------------------------------------------------------------------------
        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
    *--------------------------------------------------------------------------
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
    *--------------------------------------------------------------------------
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *--------------------------------------------------------------------------
        LOCAL loc_nI, loc_nP, loc_oObjeto

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

    *--------------------------------------------------------------------------
    * ValidarGrupo - LostFocus de txt_4c_Cgru: lookup SigCdGrp por Cgrus
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
    *--------------------------------------------------------------------------
        LOCAL loc_cGrupo, loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina.txt_4c_Cgru) != "O"
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Cgru.Value)

        IF EMPTY(loc_cGrupo)
            loc_oPagina.txt_4c_Dgru.Value = ""
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGrp", "Cgrus", loc_cGrupo, ;
                "Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGrp")
                        SELECT cursor_4c_BuscaGrp
                        loc_oPagina.txt_4c_Cgru.Value = ALLTRIM(Cgrus)
                        loc_oPagina.txt_4c_Dgru.Value = ALLTRIM(Dgrus)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cgrus", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                        SELECT cursor_4c_BuscaGrp
                        loc_oPagina.txt_4c_Cgru.Value = ALLTRIM(Cgrus)
                        loc_oPagina.txt_4c_Dgru.Value = ALLTRIM(Dgrus)
                    ELSE
                        loc_oPagina.txt_4c_Cgru.Value = ""
                        loc_oPagina.txt_4c_Dgru.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrp")
                USE IN cursor_4c_BuscaGrp
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ValidarGrupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoDesc - LostFocus de txt_4c_Dgru: lookup SigCdGrp por Dgrus
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupoDesc(par_nKeyCode, par_nShiftAltCtrl)
    *--------------------------------------------------------------------------
        LOCAL loc_cDesc, loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina.txt_4c_Dgru) != "O"
            RETURN
        ENDIF

        loc_cDesc = ALLTRIM(loc_oPagina.txt_4c_Dgru.Value)

        IF EMPTY(loc_cDesc)
            loc_oPagina.txt_4c_Cgru.Value = ""
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGrp", "Dgrus", loc_cDesc, ;
                "Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGrp")
                        SELECT cursor_4c_BuscaGrp
                        loc_oPagina.txt_4c_Cgru.Value = ALLTRIM(Cgrus)
                        loc_oPagina.txt_4c_Dgru.Value = ALLTRIM(Dgrus)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Cgrus", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                        SELECT cursor_4c_BuscaGrp
                        loc_oPagina.txt_4c_Cgru.Value = ALLTRIM(Cgrus)
                        loc_oPagina.txt_4c_Dgru.Value = ALLTRIM(Dgrus)
                    ELSE
                        loc_oPagina.txt_4c_Cgru.Value = ""
                        loc_oPagina.txt_4c_Dgru.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrp")
                USE IN cursor_4c_BuscaGrp
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ValidarGrupoDesc:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEstado - LostFocus de txt_4c_Estado: lookup SigCdUfs por estados
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEstado(par_nKeyCode, par_nShiftAltCtrl)
    *--------------------------------------------------------------------------
        LOCAL loc_cEstado, loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina.txt_4c_Estado) != "O"
            RETURN
        ENDIF

        loc_cEstado = ALLTRIM(loc_oPagina.txt_4c_Estado.Value)

        IF EMPTY(loc_cEstado)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUfs", "cursor_4c_BuscaUfs", "estados", loc_cEstado, ;
                "Estado")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaUfs")
                        SELECT cursor_4c_BuscaUfs
                        loc_oPagina.txt_4c_Estado.Value = ALLTRIM(estados)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("estados", "", "Estado")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUfs")
                        SELECT cursor_4c_BuscaUfs
                        loc_oPagina.txt_4c_Estado.Value = ALLTRIM(estados)
                    ELSE
                        loc_oPagina.txt_4c_Estado.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaUfs")
                USE IN cursor_4c_BuscaUfs
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ValidarEstado:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTpTrib - LostFocus de txt_4c_TpTrib: lookup SigPrTri por Tipos
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTpTrib(par_nKeyCode, par_nShiftAltCtrl)
    *--------------------------------------------------------------------------
        LOCAL loc_cTipo, loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina.txt_4c_TpTrib) != "O"
            RETURN
        ENDIF

        loc_cTipo = ALLTRIM(loc_oPagina.txt_4c_TpTrib.Value)

        IF EMPTY(loc_cTipo)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrTri", "cursor_4c_BuscaTri", "Tipos", loc_cTipo, ;
                "Tipo de Tributa" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaTri")
                        SELECT cursor_4c_BuscaTri
                        loc_oPagina.txt_4c_TpTrib.Value = ALLTRIM(Tipos)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Tipos", "", "Tipo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTri")
                        SELECT cursor_4c_BuscaTri
                        loc_oPagina.txt_4c_TpTrib.Value = ALLTRIM(Tipos)
                    ELSE
                        loc_oPagina.txt_4c_TpTrib.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaTri")
                USE IN cursor_4c_BuscaTri
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ValidarTpTrib:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSittricm - LostFocus de txt_4c_Sittricm: lookup SigCdIcm por Codigos
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSittricm(par_nKeyCode, par_nShiftAltCtrl)
    *--------------------------------------------------------------------------
        LOCAL loc_cCod, loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina.txt_4c_Sittricm) != "O"
            RETURN
        ENDIF

        loc_cCod = ALLTRIM(loc_oPagina.txt_4c_Sittricm.Value)

        IF EMPTY(loc_cCod)
            loc_oPagina.txt_4c_Dsittricm.Value = ""
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", loc_cCod, ;
                "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaIcm")
                        SELECT cursor_4c_BuscaIcm
                        loc_oPagina.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
                        loc_oPagina.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
                        SELECT cursor_4c_BuscaIcm
                        loc_oPagina.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
                        loc_oPagina.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
                    ELSE
                        loc_oPagina.txt_4c_Sittricm.Value  = ""
                        loc_oPagina.txt_4c_Dsittricm.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaIcm")
                USE IN cursor_4c_BuscaIcm
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ValidarSittricm:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsittricm - LostFocus de txt_4c_Dsittricm: lookup SigCdIcm por Descricaos
    * Ativo apenas quando txt_4c_Sittricm esta vazio (busca por descricao)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsittricm(par_nKeyCode, par_nShiftAltCtrl)
    *--------------------------------------------------------------------------
        LOCAL loc_cDesc, loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina.txt_4c_Dsittricm) != "O"
            RETURN
        ENDIF

        loc_cDesc = ALLTRIM(loc_oPagina.txt_4c_Dsittricm.Value)

        IF EMPTY(loc_cDesc)
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Sittricm.Value))
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdIcm", "cursor_4c_BuscaIcm", "Descricaos", loc_cDesc, ;
                "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaIcm")
                        SELECT cursor_4c_BuscaIcm
                        loc_oPagina.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
                        loc_oPagina.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
                        SELECT cursor_4c_BuscaIcm
                        loc_oPagina.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
                        loc_oPagina.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
                    ELSE
                        loc_oPagina.txt_4c_Dsittricm.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaIcm")
                USE IN cursor_4c_BuscaIcm
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ValidarDsittricm:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCfop - LostFocus de txt_4c_Cfop: lookup SigCdCfo por codigos
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCfop(par_nKeyCode, par_nShiftAltCtrl)
    *--------------------------------------------------------------------------
        LOCAL loc_cCod, loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina.txt_4c_Cfop) != "O"
            RETURN
        ENDIF

        loc_cCod = ALLTRIM(loc_oPagina.txt_4c_Cfop.Value)

        IF EMPTY(loc_cCod)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCfo", "cursor_4c_BuscaCfo", "codigos", loc_cCod, "CFOP")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaCfo")
                        SELECT cursor_4c_BuscaCfo
                        loc_oPagina.txt_4c_Cfop.Value = ALLTRIM(codigos)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",    "", "CFOP")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfo")
                        SELECT cursor_4c_BuscaCfo
                        loc_oPagina.txt_4c_Cfop.Value = ALLTRIM(codigos)
                    ELSE
                        loc_oPagina.txt_4c_Cfop.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCfo")
                USE IN cursor_4c_BuscaCfo
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ValidarCfop:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarClfiscals - LostFocus de txt_4c_Clfiscals: lookup SigCdClf por Codigos
    *--------------------------------------------------------------------------
    PROCEDURE ValidarClfiscals(par_nKeyCode, par_nShiftAltCtrl)
    *--------------------------------------------------------------------------
        LOCAL loc_cCod, loc_oPagina, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPagina.txt_4c_Clfiscals) != "O"
            RETURN
        ENDIF

        loc_cCod = ALLTRIM(loc_oPagina.txt_4c_Clfiscals.Value)

        IF EMPTY(loc_cCod)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdClf", "cursor_4c_BuscaClf", "Codigos", loc_cCod, ;
                "Classifica" + CHR(231) + CHR(227) + "o Fiscal")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaClf")
                        SELECT cursor_4c_BuscaClf
                        loc_oPagina.txt_4c_Clfiscals.Value = ALLTRIM(Codigos)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
                        SELECT cursor_4c_BuscaClf
                        loc_oPagina.txt_4c_Clfiscals.Value = ALLTRIM(Codigos)
                    ELSE
                        loc_oPagina.txt_4c_Clfiscals.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaClf")
                USE IN cursor_4c_BuscaClf
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ValidarClfiscals:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
    *--------------------------------------------------------------------------
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(loc_oPagina.txt_4c_Cgru.Value)
        THIS.this_oBusinessObject.this_cEsts      = ALLTRIM(loc_oPagina.txt_4c_Estado.Value)
        THIS.this_oBusinessObject.this_nIcms      = loc_oPagina.txt_4c_Icm.Value
        THIS.this_oBusinessObject.this_cTpicms    = ALLTRIM(loc_oPagina.txt_4c_Tpicm.Value)
        THIS.this_oBusinessObject.this_cTptribs   = ALLTRIM(loc_oPagina.txt_4c_TpTrib.Value)
        THIS.this_oBusinessObject.this_cSittricms = ALLTRIM(loc_oPagina.txt_4c_Sittricm.Value)
        THIS.this_oBusinessObject.this_cCfops     = ALLTRIM(loc_oPagina.txt_4c_Cfop.Value)
        THIS.this_oBusinessObject.this_cClfiscals = ALLTRIM(loc_oPagina.txt_4c_Clfiscals.Value)
        THIS.this_oBusinessObject.this_nIssqn     = loc_oPagina.txt_4c_Issqn.Value
        THIS.this_oBusinessObject.this_cItemls    = ALLTRIM(loc_oPagina.txt_4c_Itemls.Value)
        THIS.this_oBusinessObject.this_cCodtrib   = ALLTRIM(loc_oPagina.txt_4c_CodTrib.Value)
        THIS.this_oBusinessObject.this_cNatope    = ALLTRIM(loc_oPagina.txt_4c_NatOpe.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o form
    * Carrega descricoes de lookup via SQL (nao armazenadas na tabela principal)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
    *--------------------------------------------------------------------------
        LOCAL loc_oPagina, loc_cSQL, loc_nRes, loc_cDgrus, loc_cDsittricms
        loc_oPagina     = THIS.pgf_4c_Paginas.Page2
        loc_cDgrus      = ""
        loc_cDsittricms = ""

        *-- Descricao do grupo (SigCdGrp.Dgrus - nao armazenada em SIGCDCFI)
        IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cGrupos))
            TRY
                IF USED("cursor_4c_BofGrp")
                    USE IN cursor_4c_BofGrp
                ENDIF
                loc_cSQL = "SELECT Dgrus FROM SigCdGrp WHERE Cgrus = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cGrupos))
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BofGrp")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_BofGrp") > 0
                    SELECT cursor_4c_BofGrp
                    loc_cDgrus = ALLTRIM(Dgrus)
                ENDIF
                IF USED("cursor_4c_BofGrp")
                    USE IN cursor_4c_BofGrp
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao carregar descricao do grupo:" + CHR(13) + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        *-- Descricao da situacao tributaria (SigCdIcm.Descricaos - nao armazenada em SIGCDCFI)
        IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cSittricms))
            TRY
                IF USED("cursor_4c_BofIcm")
                    USE IN cursor_4c_BofIcm
                ENDIF
                loc_cSQL = "SELECT Descricaos FROM SigCdIcm WHERE Codigos = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cSittricms))
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BofIcm")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_BofIcm") > 0
                    SELECT cursor_4c_BofIcm
                    loc_cDsittricms = ALLTRIM(Descricaos)
                ENDIF
                IF USED("cursor_4c_BofIcm")
                    USE IN cursor_4c_BofIcm
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao carregar descricao sit. tributaria:" + CHR(13) + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        loc_oPagina.txt_4c_Cgru.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
        loc_oPagina.txt_4c_Dgru.Value      = loc_cDgrus
        loc_oPagina.txt_4c_Estado.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cEsts)
        loc_oPagina.txt_4c_Icm.Value       = THIS.this_oBusinessObject.this_nIcms
        loc_oPagina.txt_4c_Tpicm.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cTpicms)
        loc_oPagina.txt_4c_TpTrib.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cTptribs)
        loc_oPagina.txt_4c_Sittricm.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cSittricms)
        loc_oPagina.txt_4c_Dsittricm.Value = loc_cDsittricms
        loc_oPagina.txt_4c_Cfop.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cCfops)
        loc_oPagina.txt_4c_Clfiscals.Value = ALLTRIM(THIS.this_oBusinessObject.this_cClfiscals)
        loc_oPagina.txt_4c_Issqn.Value     = THIS.this_oBusinessObject.this_nIssqn
        loc_oPagina.txt_4c_Itemls.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cItemls)
        loc_oPagina.txt_4c_CodTrib.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cCodtrib)
        loc_oPagina.txt_4c_NatOpe.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cNatope)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
    *--------------------------------------------------------------------------
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Cgru.Value      = ""
        loc_oPagina.txt_4c_Dgru.Value      = ""
        loc_oPagina.txt_4c_Estado.Value    = ""
        loc_oPagina.txt_4c_Icm.Value       = 0
        loc_oPagina.txt_4c_Tpicm.Value     = ""
        loc_oPagina.txt_4c_TpTrib.Value    = ""
        loc_oPagina.txt_4c_Sittricm.Value  = ""
        loc_oPagina.txt_4c_Dsittricm.Value = ""
        loc_oPagina.txt_4c_Cfop.Value      = ""
        loc_oPagina.txt_4c_Clfiscals.Value = ""
        loc_oPagina.txt_4c_Issqn.Value     = 0
        loc_oPagina.txt_4c_Itemls.Value    = ""
        loc_oPagina.txt_4c_CodTrib.Value   = ""
        loc_oPagina.txt_4c_NatOpe.Value    = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos da Page2
    * Grupo e Estado somente editaveis em modo INCLUIR (chave composta)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    *--------------------------------------------------------------------------
        LOCAL loc_oPagina, loc_lChave
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Chave composta editavel apenas em INCLUIR
        loc_lChave = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")

        loc_oPagina.txt_4c_Cgru.Enabled      = loc_lChave
        loc_oPagina.txt_4c_Dgru.Enabled      = loc_lChave
        loc_oPagina.txt_4c_Estado.Enabled    = loc_lChave
        loc_oPagina.txt_4c_Clfiscals.Enabled = loc_lChave

        *-- Demais campos
        loc_oPagina.txt_4c_Icm.Enabled       = par_lHabilitar
        loc_oPagina.txt_4c_Tpicm.Enabled     = par_lHabilitar
        loc_oPagina.txt_4c_TpTrib.Enabled    = par_lHabilitar
        loc_oPagina.txt_4c_Sittricm.Enabled  = par_lHabilitar
        loc_oPagina.txt_4c_Dsittricm.Enabled = par_lHabilitar
        loc_oPagina.txt_4c_Cfop.Enabled      = par_lHabilitar
        loc_oPagina.txt_4c_Issqn.Enabled     = par_lHabilitar
        loc_oPagina.txt_4c_Itemls.Enabled    = par_lHabilitar
        loc_oPagina.txt_4c_CodTrib.Enabled   = par_lHabilitar
        loc_oPagina.txt_4c_NatOpe.Enabled    = par_lHabilitar

        *-- Botao Confirmar: ativo apenas em INCLUIR/ALTERAR
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
            par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara form para novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
    *--------------------------------------------------------------------------
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
    *--------------------------------------------------------------------------
        LOCAL loc_cChave
        loc_cChave = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
           RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro na lista para alterar.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado para visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
    *--------------------------------------------------------------------------
        LOCAL loc_cChave
        loc_cChave = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
           RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro na lista para visualizar.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
    *--------------------------------------------------------------------------
        LOCAL loc_cChave
        loc_cChave = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
           RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro na lista para excluir.", "Excluir")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", ;
                        "Confirmar Exclus" + CHR(227) + "o")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                THIS.CarregarLista()
            ENDIF
        ELSE
            MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega lista completa
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
    *--------------------------------------------------------------------------
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD conforme modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
    *--------------------------------------------------------------------------
        LOCAL loc_oPg1, loc_lTemRegistro
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
                           !EOF("cursor_4c_Dados") AND ;
                           RECCOUNT("cursor_4c_Dados") > 0

        WITH loc_oPg1.cnt_4c_Botoes
            .cmd_4c_Incluir.Enabled    = .T.
            .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
            .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
            .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
            .cmd_4c_Buscar.Enabled     = .T.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida e persiste o registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
    *--------------------------------------------------------------------------
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        *-- Validacoes ANTES do TRY (NUNCA RETURN dentro de TRY/CATCH)
        IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cgru.Value))
            MsgAviso("Grupo em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPagina.txt_4c_Cgru.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Sucesso")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
    *--------------------------------------------------------------------------
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\cfiBO.prg):
*==============================================================================
* cfiBO.prg - Business Object para ICMS Cupom Fiscal (SIGCDCFI)
*==============================================================================
* Tabela : SIGCDCFI
* PK     : cidchaves char(20) - gerado via SYS(2015)
* Regra  : unicidade por grupos + ests + clfiscals (ChkRegister original)
*==============================================================================

DEFINE CLASS cfiBO AS BusinessBase

    *-- Chave primaria
    this_cCidchaves  = ""

    *-- Campos da tabela SIGCDCFI
    this_cEsts       = ""   && char(2)  - Estado (FK SigCdUfs.Estados)
    this_cGrupos     = ""   && char(3)  - Grupo (FK SigCdGrp.Cgrus)
    this_nIcms       = 0    && numeric(5,2) - Aliquota ICMS
    this_cTpicms     = ""   && char(1)  - Tipo ICMS: T/S/I/N/F
    this_cTptribs    = ""   && char(4)  - Tipo Tributacao (FK SigPrTri.Tipos)
    this_nOrdicms    = 0    && numeric(2,0) - Ordem ICMS
    this_cSittricms  = ""   && char(3)  - Situacao Tributaria ICMS (FK SigCdIcm.Codigos)
    this_cCfops      = ""   && char(10) - CFOP (FK SigCdCfo.codigos)
    this_cCodtrib    = ""   && char(20) - Codigo Tributacao
    this_nIssqn      = 0    && numeric(5,2) - Aliquota ISSQN
    this_cItemls     = ""   && char(5)  - Item da Lista de Servicos
    this_cNatope     = ""   && char(2)  - Natureza da Operacao
    this_cClfiscals  = ""   && char(10) - Classificacao Fiscal (FK SigCdClf.Codigos)

    *-- Campos de exibicao (lookup - nao armazenados em SIGCDCFI)
    this_cDgrus      = ""   && Descricao do Grupo (SigCdGrp.Dgrus)
    this_cDsittricms = ""   && Descricao Sit. Tributaria (SigCdIcm.Descricaos)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela      = "SIGCDCFI"
        THIS.this_cCampoChave  = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCidchaves
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cEsts       = TratarNulo(ests,       "C")
            THIS.this_cGrupos     = TratarNulo(grupos,     "C")
            THIS.this_nIcms       = TratarNulo(icms,       "N")
            THIS.this_cTpicms     = TratarNulo(tpicms,     "C")
            THIS.this_cTptribs    = TratarNulo(tptribs,    "C")
            THIS.this_nOrdicms    = TratarNulo(ordicms,    "N")
            THIS.this_cSittricms  = TratarNulo(sittricms,  "C")
            THIS.this_cCfops      = TratarNulo(cfops,      "C")
            THIS.this_cCodtrib    = TratarNulo(codtrib,    "C")
            THIS.this_nIssqn      = TratarNulo(issqn,      "N")
            THIS.this_cItemls     = TratarNulo(itemls,     "C")
            THIS.this_cNatope     = TratarNulo(natope,     "C")
            THIS.this_cClfiscals  = TratarNulo(clfiscals,  "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT geral com filtro opcional
    * par_cFiltro: string WHERE extra (vazio = todos)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.grupos, a.ests, a.icms," + ;
                       " a.tpicms, a.tptribs, a.ordicms, a.sittricms," + ;
                       " a.cfops, a.codtrib, a.issqn, a.itemls," + ;
                       " a.natope, a.clfiscals" + ;
                       " FROM SIGCDCFI a"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.grupos, a.ests, a.tpicms"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar registros de ICMS Cupom Fiscal:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela PK (cidchaves)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCidchaves)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.grupos, a.ests, a.icms," + ;
                       " a.tpicms, a.tptribs, a.ordicms, a.sittricms," + ;
                       " a.cfops, a.codtrib, a.issqn, a.itemls," + ;
                       " a.natope, a.clfiscals" + ;
                       " FROM SIGCDCFI a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidchaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Valida unicidade por grupos+ests+clfiscals
    *--------------------------------------------------------------------------
    FUNCTION VerificarDuplicidade()
    *--------------------------------------------------------------------------
        LOCAL loc_lDuplicado, loc_cSQL, loc_nResult
        loc_lDuplicado = .F.

        TRY
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SIGCDCFI" + ;
                       " WHERE grupos = " + EscaparSQL(THIS.this_cGrupos) + ;
                       " AND ests = " + EscaparSQL(THIS.this_cEsts) + ;
                       " AND clfiscals = " + EscaparSQL(THIS.this_cClfiscals)

            IF THIS.this_lNovoRegistro = .F.
                loc_cSQL = loc_cSQL + " AND cidchaves <> " + EscaparSQL(THIS.this_cCidchaves)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dup")
                TABLEREVERT(.T., "cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")

            IF loc_nResult >= 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (qtd > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.VerificarDuplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_cCidchaves = LEFT(SYS(2015), 20)

            IF THIS.VerificarDuplicidade()
                MsgErro("Grupo, Estado e Classifica" + CHR(231) + CHR(227) + "o j" + ;
                        CHR(225) + " cadastrado!", "Duplicidade")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "INSERT INTO SIGCDCFI" + ;
                           " (cidchaves, ests, grupos, icms, tpicms, tptribs," + ;
                           "  ordicms, sittricms, cfops, codtrib, issqn," + ;
                           "  itemls, natope, clfiscals)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                           EscaparSQL(THIS.this_cEsts)      + ", " + ;
                           EscaparSQL(THIS.this_cGrupos)    + ", " + ;
                           FormatarNumeroSQL(THIS.this_nIcms)   + ", " + ;
                           EscaparSQL(THIS.this_cTpicms)    + ", " + ;
                           EscaparSQL(THIS.this_cTptribs)   + ", " + ;
                           FormatarNumeroSQL(THIS.this_nOrdicms) + ", " + ;
                           EscaparSQL(THIS.this_cSittricms) + ", " + ;
                           EscaparSQL(THIS.this_cCfops)     + ", " + ;
                           EscaparSQL(THIS.this_cCodtrib)   + ", " + ;
                           FormatarNumeroSQL(THIS.this_nIssqn)  + ", " + ;
                           EscaparSQL(THIS.this_cItemls)    + ", " + ;
                           EscaparSQL(THIS.this_cNatope)    + ", " + ;
                           EscaparSQL(THIS.this_cClfiscals) + ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao incluir ICMS Cupom Fiscal:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF THIS.VerificarDuplicidade()
                MsgErro("Grupo, Estado e Classifica" + CHR(231) + CHR(227) + "o j" + ;
                        CHR(225) + " cadastrado!", "Duplicidade")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "UPDATE SIGCDCFI SET" + ;
                           " ests      = " + EscaparSQL(THIS.this_cEsts)      + "," + ;
                           " grupos    = " + EscaparSQL(THIS.this_cGrupos)    + "," + ;
                           " icms      = " + FormatarNumeroSQL(THIS.this_nIcms)   + "," + ;
                           " tpicms    = " + EscaparSQL(THIS.this_cTpicms)    + "," + ;
                           " tptribs   = " + EscaparSQL(THIS.this_cTptribs)   + "," + ;
                           " ordicms   = " + FormatarNumeroSQL(THIS.this_nOrdicms) + "," + ;
                           " sittricms = " + EscaparSQL(THIS.this_cSittricms) + "," + ;
                           " cfops     = " + EscaparSQL(THIS.this_cCfops)     + "," + ;
                           " codtrib   = " + EscaparSQL(THIS.this_cCodtrib)   + "," + ;
                           " issqn     = " + FormatarNumeroSQL(THIS.this_nIssqn)  + "," + ;
                           " itemls    = " + EscaparSQL(THIS.this_cItemls)    + "," + ;
                           " natope    = " + EscaparSQL(THIS.this_cNatope)    + "," + ;
                           " clfiscals = " + EscaparSQL(THIS.this_cClfiscals) + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao atualizar ICMS Cupom Fiscal:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCDCFI" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir ICMS Cupom Fiscal:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

