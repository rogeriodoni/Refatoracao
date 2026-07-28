# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-21 17:58:41] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-21 17:58:41] [INFO] Config FPW: (nao fornecido)
[2026-07-21 17:58:41] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 17:58:41] [INFO] Timeout: 300 segundos
[2026-07-21 17:58:41] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zma41xjm.prg
[2026-07-21 17:58:41] [INFO] Conteudo do wrapper:
[2026-07-21 17:58:41] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormAli', 'C:\4c\tasks\task346', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormAli', 'C:\4c\tasks\task346', 'CRUD'
QUIT

[2026-07-21 17:58:41] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zma41xjm.prg
[2026-07-21 17:58:41] [INFO] VFP output esperado em: C:\4c\tasks\task346\vfp_output.txt
[2026-07-21 17:58:41] [INFO] Executando Visual FoxPro 9...
[2026-07-21 17:58:41] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zma41xjm.prg
[2026-07-21 17:58:41] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zma41xjm.prg
[2026-07-21 17:58:41] [INFO] Timeout configurado: 300 segundos
[2026-07-21 17:59:16] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-21 17:59:16] [INFO] VFP9 finalizado em 34.8856581 segundos
[2026-07-21 17:59:16] [INFO] Exit Code: 
[2026-07-21 17:59:16] [INFO] 
[2026-07-21 17:59:16] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-21 17:59:16] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zma41xjm.prg
[2026-07-21 17:59:16] [INFO] 
[2026-07-21 17:59:16] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-21 17:59:16] [INFO] * Auto-generated wrapper for parameters
[2026-07-21 17:59:16] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 17:59:16] [INFO] * Parameters: 'FormAli', 'C:\4c\tasks\task346', 'CRUD'
[2026-07-21 17:59:16] [INFO] 
[2026-07-21 17:59:16] [INFO] * Anti-dialog protections for unattended execution
[2026-07-21 17:59:16] [INFO] SET SAFETY OFF
[2026-07-21 17:59:16] [INFO] SET RESOURCE OFF
[2026-07-21 17:59:16] [INFO] SET TALK OFF
[2026-07-21 17:59:16] [INFO] SET NOTIFY OFF
[2026-07-21 17:59:16] [INFO] SYS(2335, 0)
[2026-07-21 17:59:16] [INFO] 
[2026-07-21 17:59:16] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormAli', 'C:\4c\tasks\task346', 'CRUD'
[2026-07-21 17:59:16] [INFO] QUIT
[2026-07-21 17:59:16] [INFO] 
[2026-07-21 17:59:16] [INFO] === Fim do Wrapper.prg ===
[2026-07-21 17:59:16] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormAli",
  "timestamp": "20260721175916",
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
      "passou": true,
      "erro": "",
      "detalhes": "Page2 ativada com sucesso"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormAli.prg):
*==============================================================================
* FormAli.PRG - Fase 7/8: Form - Eventos Principais (completo)
* Formulario de Cadastro de Alineas (SIGCDALI)
*
* Tabela: SigCdAli
* Tipo: CRUD (frmcadastro)
* BO: AliBO
*==============================================================================

DEFINE CLASS FormAli AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Al" + CHR(237) + "neas"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("AliBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar AliBO", "Erro")
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
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria containers, grid e botoes da Page1 (Lista)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho cinza (Top = 2 + 29 = 31, compensacao PageFrame.Top=-29)
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
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
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (canonico: Top=29, Left=542, Width=390)
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Left=917, Width=90)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem (Top=88+29=117, Left=12, Width=890, Height=480)
        *-- RecordSource e ColumnCount FORA do WITH para criar colunas imediatamente
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oPg1.grd_4c_Lista.RecordSource = ""
        loc_oPg1.grd_4c_Lista.ColumnCount  = 4

        WITH loc_oPg1.grd_4c_Lista
            .Top                     = 117
            .Left                    = 12
            .Width                   = 890
            .Height                  = 480
            .FontName                = "Verdana"
            .FontSize                = 8
            .ForeColor               = RGB(90, 90, 90)
            .BackColor               = RGB(255, 255, 255)
            .GridLineColor           = RGB(238, 238, 238)
            .HighlightBackColor      = RGB(255, 255, 255)
            .HighlightForeColor      = RGB(15, 41, 104)
            .HighlightStyle          = 2
            .DeleteMark              = .F.
            .RecordMark              = .F.
            .RowHeight               = 16
            .ScrollBars              = 2
            .GridLines               = 3
            .ReadOnly                = .T.
            .Visible                 = .T.
            .Column1.Width           = 50
            .Column2.Width           = 415
            .Column3.Width           = 200
            .Column4.Width           = 160
            .Column1.ReadOnly        = .T.
            .Column2.ReadOnly        = .T.
            .Column3.ReadOnly        = .T.
            .Column4.ReadOnly        = .T.
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.Header1.Caption = "Oper. Autom. Cheque"
            .Column4.Header1.Caption = "Cond. Pag. Autom."
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria containers e botoes da Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oBotoesAcao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container botoes Confirmar/Cancelar (Top = 4 + 29 = 33)
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oBotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Confirmar
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Cancelar
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Label Codigo (Say1: top=171+29=200, left=288, width=42)
        loc_oPg2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg2.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 200
            .Left      = 288
            .Width     = 42
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (getCodigos: top=168+29=197, left=335, width=33)
        loc_oPg2.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPg2.txt_4c_Codigos
            .Value         = 0
            .Top           = 197
            .Left          = 335
            .Width         = 33
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .InputMask     = "999"
            .Visible       = .T.
        ENDWITH

        *-- Label Descricao (Say2: top=196+29=225, left=275, width=60)
        loc_oPg2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg2.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 225
            .Left      = 275
            .Width     = 60
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (getDescrs: top=193+29=222, left=335, width=290)
        loc_oPg2.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPg2.txt_4c_Descrs
            .Value         = ""
            .Top           = 222
            .Left          = 335
            .Width         = 290
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label Operacao Cheque Automatica (Say3: top=221+29=250, left=162, width=173)
        loc_oPg2.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg2.lbl_4c_Label3
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Cheque Autom" + CHR(225) + "tica :"
            .Top       = 250
            .Left      = 162
            .Width     = 173
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Operacao Cheque Automatica (getOpAutos: top=218+29=247, left=335, width=115)
        loc_oPg2.AddObject("txt_4c_OpAutos", "TextBox")
        WITH loc_oPg2.txt_4c_OpAutos
            .Value         = ""
            .Top           = 247
            .Left          = 335
            .Width         = 115
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_OpAutos, "KeyPress", THIS, "ValidarOpAutos")

        *-- Label Operacao Saida de Cheque (Say4: top=246+29=275, left=175)
        loc_oPg2.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg2.lbl_4c_Label4
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Saida de Cheque :"
            .Top       = 275
            .Left      = 175
            .Width     = 190
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Operacao Saida de Cheque (GetOpSaidas: top=243+29=272, left=335, width=115)
        loc_oPg2.AddObject("txt_4c_OpSaidas", "TextBox")
        WITH loc_oPg2.txt_4c_OpSaidas
            .Value         = ""
            .Top           = 272
            .Left          = 335
            .Width         = 115
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_OpSaidas, "KeyPress", THIS, "ValidarOpSaidas")

        *-- Label Condicao de Pagamento Automatica (Say5: top=271+29=300, left=148)
        loc_oPg2.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg2.lbl_4c_Label5
            .Caption   = "Condi" + CHR(231) + CHR(227) + "o de Pagamento Automatica :"
            .Top       = 300
            .Left      = 148
            .Width     = 215
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Condicao de Pagamento Automatica (GetFPagSAutos: top=268+29=297, left=335, width=94)
        loc_oPg2.AddObject("txt_4c_FPagSAutos", "TextBox")
        WITH loc_oPg2.txt_4c_FPagSAutos
            .Value         = ""
            .Top           = 297
            .Left          = 335
            .Width         = 94
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_FPagSAutos, "KeyPress", THIS, "ValidarFPagSAutos")

        *-- Label Gera Pendencias Financeiras (Say6: top=295+29=324, left=184)
        loc_oPg2.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg2.lbl_4c_Label6
            .Caption   = "Gera Pend" + CHR(234) + "ncias Financeiras :"
            .Top       = 324
            .Left      = 184
            .Width     = 180
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Gera Pendencias (optPefins: top=291+29=320, left=335, width=96, height=27)
        *-- Value=2 -> Nao selecionado por default; NAO setar Value em Buttons individuais
        loc_oPg2.AddObject("opt_4c_OptPefins", "OptionGroup")
        WITH loc_oPg2.opt_4c_OptPefins
            .ButtonCount = 2
            .Top         = 320
            .Left        = 335
            .Width       = 96
            .Height      = 27
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .Left      = 51
                .Top       = 5
                .Width     = 40
                .Height    = 17
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca alineas e carrega grid da Page1
    * Fase 3: Chama Buscar(). Fase 4 completa o wire do grid.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        loc_oGrid.ColumnCount = 4
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.opautos"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.fpagsautos"

                        loc_oGrid.Column1.Width = 50
                        loc_oGrid.Column2.Width = 415
                        loc_oGrid.Column3.Width = 200
                        loc_oGrid.Column4.Width = 160

                        loc_oGrid.Column1.ReadOnly = .T.
                        loc_oGrid.Column2.ReadOnly = .T.
                        loc_oGrid.Column3.ReadOnly = .T.
                        loc_oGrid.Column4.ReadOnly = .T.

                        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column3.Header1.Caption = "Oper. Autom. Cheque"
                        loc_oGrid.Column4.Header1.Caption = "Cond. Pag. Autom."

                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Lista (1) e Dados (2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
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
            MsgErro(loc_oErro.Message, "FormAli.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara form para inclusao de nova alinea
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BtnIncluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Abre registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_nCodigo = cursor_4c_Dados.codigos

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Abre registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_nCodigo = cursor_4c_Dados.codigos

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_nCodigo = cursor_4c_Dados.codigos

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
            RETURN .F.
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da al" + CHR(237) + ;
                        "nea " + TRANSFORM(loc_nCodigo) + "?", "Excluir")
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Al" + CHR(237) + "nea exclu" + CHR(237) + "da com sucesso!")
                THIS.CarregarLista()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Vai para Page2 no modo BUSCAR (localizar por codigo)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "BUSCAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BtnBuscarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Salva registro (ou localiza em modo BUSCAR)
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oPg2, loc_nCodBusca, loc_lResultado
        loc_lResultado = .F.

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes ANTES do TRY (RETURN valido aqui)
        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5) AND ;
           VAL(TRANSFORM(loc_oPg2.txt_4c_Codigos.Value)) = 0 AND ;
           THIS.this_cModoAtual = "INCLUIR"
            MsgAviso("O c" + CHR(243) + "digo " + CHR(233) + " obrigat" + CHR(243) + "rio.", "")
            loc_oPg2.txt_4c_Codigos.SetFocus
            RETURN .F.
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5) AND ;
           EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)) AND ;
           !INLIST(THIS.this_cModoAtual, "BUSCAR", "VISUALIZAR")
            MsgAviso("A descri" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria.", "")
            loc_oPg2.txt_4c_Descrs.SetFocus
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_cModoAtual = "BUSCAR"
                *-- Localiza pelo codigo digitado e volta para lista
                IF PEMSTATUS(loc_oPg2, "txt_4c_Codigos", 5)
                    loc_nCodBusca = VAL(TRANSFORM(loc_oPg2.txt_4c_Codigos.Value))
                ELSE
                    loc_nCodBusca = 0
                ENDIF
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                IF USED("cursor_4c_Dados") AND loc_nCodBusca > 0
                    SELECT cursor_4c_Dados
                    LOCATE FOR cursor_4c_Dados.codigos = loc_nCodBusca
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF THIS.FormParaBO()
                    IF THIS.this_oBusinessObject.Salvar()
                        MsgInfo("Al" + CHR(237) + "nea salva com sucesso!")
                        THIS.this_cModoAtual = "LISTA"
                        THIS.AlternarPagina(1)
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BtnConfirmarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Alias canonico para BtnConfirmarClick (padrao migracao)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        RETURN THIS.BtnConfirmarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            THIS.this_oBusinessObject.this_nCodigos    = loc_oPg2.txt_4c_Codigos.Value
            THIS.this_oBusinessObject.this_cDescrs     = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
            THIS.this_oBusinessObject.this_cOpAutos    = ALLTRIM(loc_oPg2.txt_4c_OpAutos.Value)
            THIS.this_oBusinessObject.this_cOpSaidas   = ALLTRIM(loc_oPg2.txt_4c_OpSaidas.Value)
            THIS.this_oBusinessObject.this_cFPagSAutos = ALLTRIM(loc_oPg2.txt_4c_FPagSAutos.Value)
            THIS.this_oBusinessObject.this_nPefins     = loc_oPg2.opt_4c_OptPefins.Value
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oPg2.txt_4c_Codigos.Value    = THIS.this_oBusinessObject.this_nCodigos
            loc_oPg2.txt_4c_Descrs.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
            loc_oPg2.txt_4c_OpAutos.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cOpAutos)
            loc_oPg2.txt_4c_OpSaidas.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cOpSaidas)
            loc_oPg2.txt_4c_FPagSAutos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cFPagSAutos)
            loc_oPg2.opt_4c_OptPefins.Value  = THIS.this_oBusinessObject.this_nPefins
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.BOParaForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Codigos.Value    = 0
            loc_oPg2.txt_4c_Descrs.Value     = ""
            loc_oPg2.txt_4c_OpAutos.Value    = ""
            loc_oPg2.txt_4c_OpSaidas.Value   = ""
            loc_oPg2.txt_4c_FPagSAutos.Value = ""
            loc_oPg2.opt_4c_OptPefins.Value  = 2
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lCodHabilitar
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Codigo habilitado somente em INCLUIR e BUSCAR
            loc_lCodHabilitar = INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR")
            loc_oPg2.txt_4c_Codigos.Enabled    = loc_lCodHabilitar
            loc_oPg2.txt_4c_Descrs.Enabled     = par_lHabilitar
            loc_oPg2.txt_4c_OpAutos.Enabled    = par_lHabilitar
            loc_oPg2.txt_4c_OpSaidas.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_FPagSAutos.Enabled = par_lHabilitar
            loc_oPg2.opt_4c_OptPefins.Enabled  = par_lHabilitar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao
        loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        TRY
            *-- Confirmar habilitado em INCLUIR, ALTERAR e BUSCAR; desabilitado em VISUALIZAR
            loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
            loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOpAutos - Lookup para Operacao de Cheque Automatica (SigCdOpt)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOpAutos(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cValor, loc_oBusca
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_OpAutos.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpt", "cursor_4c_BuscaOp", "Operacaos", loc_cValor, ;
                "Opera" + CHR(231) + CHR(227) + "es de Cheques")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Operacaos", "", "Opera" + CHR(231) + CHR(227) + "es")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOp")
                    SELECT cursor_4c_BuscaOp
                    loc_oPg2.txt_4c_OpAutos.Value = ALLTRIM(cursor_4c_BuscaOp.Operacaos)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.ValidarOpAutos")
        ENDTRY

        IF USED("cursor_4c_BuscaOp")
            USE IN cursor_4c_BuscaOp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOpSaidas - Lookup para Operacao de Saida de Cheque (SigCdOpt)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOpSaidas(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cValor, loc_oBusca
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_OpSaidas.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpt", "cursor_4c_BuscaOpSai", "Operacaos", loc_cValor, ;
                "Opera" + CHR(231) + CHR(227) + "es de Saida de Cheque")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Operacaos", "", "Opera" + CHR(231) + CHR(227) + "es")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpSai")
                    SELECT cursor_4c_BuscaOpSai
                    loc_oPg2.txt_4c_OpSaidas.Value = ALLTRIM(cursor_4c_BuscaOpSai.Operacaos)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.ValidarOpSaidas")
        ENDTRY

        IF USED("cursor_4c_BuscaOpSai")
            USE IN cursor_4c_BuscaOpSai
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFPagSAutos - Lookup para Condicao de Pagamento Automatica (SigOpFp)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFPagSAutos(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cValor, loc_oBusca
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_FPagSAutos.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigOpFp", "cursor_4c_BuscaFPag", "Fpags", loc_cValor, ;
                "Condi" + CHR(231) + CHR(227) + "o de Pagamento")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Fpags", "", "Condi" + CHR(231) + CHR(227) + "o de Pagamento")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFPag")
                    SELECT cursor_4c_BuscaFPag
                    loc_oPg2.txt_4c_FPagSAutos.Value = ALLTRIM(cursor_4c_BuscaFPag.Fpags)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.ValidarFPagSAutos")
        ENDTRY

        IF USED("cursor_4c_BuscaFPag")
            USE IN cursor_4c_BuscaFPag
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormAli.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\AliBO.prg):
*====================================================================
* AliBO.prg
*
* Business Object para Alineas
* Tabela: SIGCDALI
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS AliBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDALI)
	this_nCodigos    = 0    && codigos numeric(3,0) - PK
	this_cDescrs     = ""   && descrs char(40)
	this_cOpAutos    = ""   && opautos char(15) - FK SigCdOpt.Operacaos
	this_cOpSaidas   = ""   && opsaidas char(15) - FK SigCdOpt.Operacaos
	this_cFPagSAutos = ""   && fpagsautos char(12) - FK SigOpFp.Fpags
	this_nPefins     = 2    && pefins numeric(1,0) - 1=Sim, 2=Nao
	this_nReincids   = 0    && reincids numeric(4,2) - nao exibido no form

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDALI"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN TRANSFORM(THIS.this_nCodigos)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de alineas no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT codigos, descrs, opautos, fpagsautos, opsaidas, pefins, reincids" + ;
				           " FROM SigCdAli" + ;
				           " ORDER BY codigos"
			ELSE
				loc_cSQL = "SELECT codigos, descrs, opautos, fpagsautos, opsaidas, pefins, reincids" + ;
				           " FROM SigCdAli" + ;
				           " WHERE codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro))) + ;
				           " ORDER BY codigos"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar al" + CHR(237) + "neas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar al" + CHR(237) + "neas:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, descrs, opautos, fpagsautos, opsaidas, pefins, reincids" + ;
			           " FROM SigCdAli" + ;
			           " WHERE codigos = " + FormatarNumeroSQL(par_nCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_nCodigos    = TratarNulo(codigos, "N")
			THIS.this_cDescrs     = TratarNulo(descrs, "C")
			THIS.this_cOpAutos    = TratarNulo(opautos, "C")
			THIS.this_cOpSaidas   = TratarNulo(opsaidas, "C")
			THIS.this_cFPagSAutos = TratarNulo(fpagsautos, "C")
			THIS.this_nPefins     = TratarNulo(pefins, "N")
			THIS.this_nReincids   = TratarNulo(reincids, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdAli
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SigCdAli (codigos, descrs, opautos, opsaidas, fpagsautos, pefins)" + ;
			           " VALUES (" + ;
			           FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
			           EscaparSQL(THIS.this_cDescrs) + "," + ;
			           EscaparSQL(THIS.this_cOpAutos) + "," + ;
			           EscaparSQL(THIS.this_cOpSaidas) + "," + ;
			           EscaparSQL(THIS.this_cFPagSAutos) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPefins) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir al" + CHR(237) + "nea:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdAli
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdAli SET" + ;
			           " descrs = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
			           " opautos = " + EscaparSQL(THIS.this_cOpAutos) + "," + ;
			           " opsaidas = " + EscaparSQL(THIS.this_cOpSaidas) + "," + ;
			           " fpagsautos = " + EscaparSQL(THIS.this_cFPagSAutos) + "," + ;
			           " pefins = " + FormatarNumeroSQL(THIS.this_nPefins) + ;
			           " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar al" + CHR(237) + "nea:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigCdAli
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdAli WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir al" + CHR(237) + "nea:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

