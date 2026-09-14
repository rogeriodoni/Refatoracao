# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 429; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-22 22:01:54] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-22 22:01:54] [INFO] Config FPW: (nao fornecido)
[2026-08-22 22:01:54] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 22:01:54] [INFO] Timeout: 300 segundos
[2026-08-22 22:01:54] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lzcbg5ba.prg
[2026-08-22 22:01:54] [INFO] Conteudo do wrapper:
[2026-08-22 22:01:54] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormPMC', 'C:\4c\tasks\task500', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormPMC', 'C:\4c\tasks\task500', 'CRUD'
QUIT

[2026-08-22 22:01:54] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lzcbg5ba.prg
[2026-08-22 22:01:54] [INFO] VFP output esperado em: C:\4c\tasks\task500\vfp_output.txt
[2026-08-22 22:01:54] [INFO] Executando Visual FoxPro 9...
[2026-08-22 22:01:54] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lzcbg5ba.prg
[2026-08-22 22:01:54] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lzcbg5ba.prg
[2026-08-22 22:01:54] [INFO] Timeout configurado: 300 segundos
[2026-08-22 22:03:24] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-22 22:03:24] [INFO] VFP9 finalizado em 90.1458243 segundos
[2026-08-22 22:03:24] [INFO] Exit Code: 
[2026-08-22 22:03:24] [INFO] 
[2026-08-22 22:03:24] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-22 22:03:24] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lzcbg5ba.prg
[2026-08-22 22:03:24] [INFO] 
[2026-08-22 22:03:24] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-22 22:03:24] [INFO] * Auto-generated wrapper for parameters
[2026-08-22 22:03:24] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 22:03:24] [INFO] * Parameters: 'FormPMC', 'C:\4c\tasks\task500', 'CRUD'
[2026-08-22 22:03:24] [INFO] 
[2026-08-22 22:03:24] [INFO] * Anti-dialog protections for unattended execution
[2026-08-22 22:03:24] [INFO] SET SAFETY OFF
[2026-08-22 22:03:24] [INFO] SET RESOURCE OFF
[2026-08-22 22:03:24] [INFO] SET TALK OFF
[2026-08-22 22:03:24] [INFO] SET NOTIFY OFF
[2026-08-22 22:03:24] [INFO] SYS(2335, 0)
[2026-08-22 22:03:24] [INFO] 
[2026-08-22 22:03:24] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormPMC', 'C:\4c\tasks\task500', 'CRUD'
[2026-08-22 22:03:24] [INFO] QUIT
[2026-08-22 22:03:24] [INFO] 
[2026-08-22 22:03:24] [INFO] === Fim do Wrapper.prg ===
[2026-08-22 22:03:24] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormPMC",
  "timestamp": "20260822220324",
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
      "detalhes": "Linha: 429"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 559"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPMC.prg):
*==============================================================================
* FormPMC.prg - Cadastro: Tabela de Promo" + CHR(231) + CHR(245) + "es por Per" + CHR(237) + "odo
* Herda de: FormBase
* Entidade: PMC
* Tabela  : SigCdPmc (PK: codigo)
* Task    : task500
*==============================================================================

DEFINE CLASS FormPMC AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY - SCX Width=1000, Height=600)
    Height      = 600
    Width       = 1000
    Caption     = "Tabela de promocoes por periodo"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Business Object e estado interno
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cPkChaveAtual   = ""

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro em FormPMC.Init:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado, loc_oCab
        loc_lResultado = .F.

        TRY
            THIS.Caption = "Tabela de promo" + CHR(231) + CHR(245) + "es por per" + CHR(237) + "odo"

            THIS.this_oBusinessObject = CREATEOBJECT("PMCBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar PMCBO!" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Propagar caption para labels de titulo da Page1
                loc_oCab = THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
                IF VARTYPE(loc_oCab) = "O"
                    IF VARTYPE(loc_oCab.lbl_4c_Sombra) = "O"
                        loc_oCab.lbl_4c_Sombra.Caption = THIS.Caption
                    ENDIF
                    IF VARTYPE(loc_oCab.lbl_4c_Titulo) = "O"
                        loc_oCab.lbl_4c_Titulo.Caption = THIS.Caption
                    ENDIF
                ENDIF

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em FormPMC.InicializarForm:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria pgf_4c_Paginas com Page1 (Lista) e Page2 (Dados)
    * PageFrame.Top = -29 esconde abas; controles dentro das Pages compensam +29px
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Page1.Caption = "Lista"
            .Page2.Caption = "Dados"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: Cabecalho + containers botoes + Saida
    * Legado: cntSombra.Top=1, Grupo_op.Left=538 Top=-1, Grupo_Saida.Left=918 Top=-1
    * Compensacao +29px em todos os controles (PageFrame.Top=-29)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho escuro com titulo (cntSombra: Top=1+29=30, Left=0)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

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
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container botoes CRUD (Grupo_op: Left=538, Top=-1+29=28; canonico Left=542, Top=29)
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
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

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
        ENDWITH

        *-- Container Saida canonico (CLAUDE.md regra #10: Left=917, Width=90, cmd Width=75)
        *-- Grupo_Saida legado: Left=918, Top=-1 -> +29 compensacao = Top=28; canonico Top=29
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
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Grid de listagem (grade legado: Top=121+29=150; Left=12; 8 colunas)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 8
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 150
            .Left               = 12
            .Width              = 890
            .Height             = 460
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
            .Column1.Width      = 80
            .Column1.ReadOnly   = .T.
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column2.Width      = 150
            .Column2.ReadOnly   = .T.
            .Column2.Header1.Caption = "Produto"
            .Column3.Width      = 80
            .Column3.ReadOnly   = .T.
            .Column3.Header1.Caption = "Tipo"
            .Column4.Width      = 100
            .Column4.ReadOnly   = .T.
            .Column4.Header1.Caption = "Valor M" + CHR(237) + "nimo"
            .Column5.Width      = 90
            .Column5.ReadOnly   = .T.
            .Column5.Header1.Caption = "Dt In" + CHR(237) + "cio"
            .Column6.Width      = 90
            .Column6.ReadOnly   = .T.
            .Column6.Header1.Caption = "Dt final"
            .Column7.Width      = 80
            .Column7.ReadOnly   = .T.
            .Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
            .Column8.Width      = 90
            .Column8.ReadOnly   = .T.
            .Column8.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- BINDEVENTs botoes Page1 (handlers PUBLIC para funcionar com BINDEVENT)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: Container BotoesAcao
    * Legado: Grupo_Salva.Left=819, Top=9 -> +29 compensacao = Top=38
    * TextBoxes/Labels adicionados nas Fases 5-6
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Salvar/Cancelar (Grupo_Salva: Left=819, Top=9+29=38)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 38
            .Left        = 819
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
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
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH .cmd_4c_Cancelar
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
        ENDWITH

        *-- Label + TextBox: Codigo (getcodigo: Top=151+29=180, Left=387, ReadOnly)
        *-- Legado: When=RETURN .F. -> sempre ReadOnly; TabIndex=1
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 185
            .Left      = 343
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 180
            .Left          = 387
            .Width         = 80
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "!!!!!!!!!!"
            .ReadOnly      = .T.
            .Enabled       = .F.
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox: Produto (getCpros: Top=178+29=207, Left=387, MaxLength=14)
        *-- Legado: When=INLIST(INSERIR); Valid abre fwbuscaext em SigCdPro
        loc_oPagina.AddObject("lbl_4c_Produto", "Label")
        WITH loc_oPagina.lbl_4c_Produto
            .Caption   = "Produto :"
            .Top       = 210
            .Left      = 338
            .Width     = 47
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cpros", "TextBox")
        WITH loc_oPagina.txt_4c_Cpros
            .Value         = ""
            .Top           = 207
            .Left          = 387
            .Width         = 108
            .Height        = 21
            .MaxLength     = 14
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label + ComboBox: Tipo de Promocao (cmbTpDesc: Top=202+29=231, Left=387)
        *-- Legado: RowSourceType=1, RowSource="1-Brinde"; When=INLIST(INSERIR)
        loc_oPagina.AddObject("lbl_4c_TipoPromocao", "Label")
        WITH loc_oPagina.lbl_4c_TipoPromocao
            .Caption   = "Tipo de Promo" + CHR(231) + CHR(227) + "o :"
            .Top       = 234
            .Left      = 291
            .Width     = 94
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("cbo_4c_CmbTpDesc", "ComboBox")
        WITH loc_oPagina.cbo_4c_CmbTpDesc
            .Top           = 231
            .Left          = 387
            .Width         = 221
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "1-Brinde"
            .SpecialEffect = 1
            .ListIndex     = 1
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox: Data Inicial (getDtini: Top=227+29=256, Left=387, Width=80)
        *-- Legado: When=INLIST(INSERIR); Alignment=3; editavel apenas no INSERIR
        loc_oPagina.AddObject("lbl_4c_DataInicial", "Label")
        WITH loc_oPagina.lbl_4c_DataInicial
            .Caption   = "Data Inicial :"
            .Top       = 261
            .Left      = 323
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dtini", "TextBox")
        WITH loc_oPagina.txt_4c_Dtini
            .Value         = {}
            .Top           = 256
            .Left          = 387
            .Width         = 80
            .Height        = 24
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox: Data Final (GetDtfin: Top=254+29=283, Left=387, Width=80)
        *-- Legado: When=INLIST(INSERIR); Alignment=3; editavel apenas no INSERIR
        loc_oPagina.AddObject("lbl_4c_DataFinal", "Label")
        WITH loc_oPagina.lbl_4c_DataFinal
            .Caption   = "Data Final :"
            .Top       = 288
            .Left      = 328
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dtfin", "TextBox")
        WITH loc_oPagina.txt_4c_Dtfin
            .Value         = {}
            .Top           = 283
            .Left          = 387
            .Width         = 80
            .Height        = 24
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label + TextBox: Valor Minimo (GetValmin: Top=282+29=311, Left=387, Width=126)
        *-- Legado: InputMask="99,999,999.99"; Alignment=3; editavel em INSERIR e ALTERAR
        loc_oPagina.AddObject("lbl_4c_ValorMin", "Label")
        WITH loc_oPagina.lbl_4c_ValorMin
            .Caption   = "Valor Min :"
            .Top       = 316
            .Left      = 333
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Valmin", "TextBox")
        WITH loc_oPagina.txt_4c_Valmin
            .Value         = 0
            .Top           = 311
            .Left          = 387
            .Width         = 126
            .Height        = 24
            .Alignment     = 3
            .InputMask     = "99,999,999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- BINDEVENTs txt_4c_Cpros: F4/DblClick abre busca, LostFocus valida
        BINDEVENT(loc_oPagina.txt_4c_Cpros, "KeyPress",  THIS, "TeclaTxtCpros")
        BINDEVENT(loc_oPagina.txt_4c_Cpros, "DblClick",  THIS, "AbrirBuscaProduto")
        BINDEVENT(loc_oPagina.txt_4c_Cpros, "KeyPress", THIS, "ValidarProduto")

        *-- BINDEVENTs botoes Page2
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Busca registros e atualiza grid Page1
    * Grid (grd_4c_Lista) configurado na Fase 4
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lResultado = .F.
                ELSE
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                        loc_oGrid.ColumnCount = 8
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigo"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cpros"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tppro"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.valmin"
                        loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.dtini"
                        loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.dtfin"
                        loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.usualts"
                        loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.dtalts"
                        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                        loc_oGrid.Column2.Header1.Caption = "Produto"
                        loc_oGrid.Column3.Header1.Caption = "Tipo"
                        loc_oGrid.Column4.Header1.Caption = "Valor M" + CHR(237) + "nimo"
                        loc_oGrid.Column5.Header1.Caption = "Dt In" + CHR(237) + "cio"
                        loc_oGrid.Column6.Header1.Caption = "Dt final"
                        loc_oGrid.Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
                        loc_oGrid.Column8.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormPMC.CarregarLista:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
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
        CATCH TO loc_oErro
            MsgErro("Erro em FormPMC.AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles do container visiveis recursivamente
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
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
    * FormatarGridLista - Formata fonte do grid de listagem
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia inclusao de novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual    = "INCLUIR"
        THIS.this_cPkChaveAtual = ""
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Cpros", 5)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Cpros.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro na lista.", "Visualizar")
            ELSE
                SELECT cursor_4c_Dados
                IF EOF("cursor_4c_Dados")
                    MsgAviso("Selecione um registro na lista.", "Visualizar")
                ELSE
                    loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        THIS.this_cModoAtual    = "VISUALIZAR"
                        THIS.this_cPkChaveAtual = loc_cCodigo
                        THIS.BOParaForm()
                        THIS.HabilitarCampos(.F.)
                        THIS.AjustarBotoesPorModo()
                        THIS.AlternarPagina(2)
                    ELSE
                        MsgErro("Erro ao carregar registro!", "Visualizar")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnVisualizarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre registro selecionado para edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro na lista.", "Alterar")
            ELSE
                SELECT cursor_4c_Dados
                IF EOF("cursor_4c_Dados")
                    MsgAviso("Selecione um registro na lista.", "Alterar")
                ELSE
                    loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        THIS.this_oBusinessObject.EditarRegistro()
                        THIS.this_cModoAtual    = "ALTERAR"
                        THIS.this_cPkChaveAtual = loc_cCodigo
                        THIS.BOParaForm()
                        THIS.HabilitarCampos(.T.)
                        THIS.AjustarBotoesPorModo()
                        THIS.AlternarPagina(2)
                        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Valmin", 5)
                            THIS.pgf_4c_Paginas.Page2.txt_4c_Valmin.SetFocus
                        ENDIF
                    ELSE
                        MsgErro("Erro ao carregar registro!", "Alterar")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnAlterarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione um registro na lista.", "Excluir")
            ELSE
                SELECT cursor_4c_Dados
                IF EOF("cursor_4c_Dados")
                    MsgAviso("Selecione um registro na lista.", "Excluir")
                ELSE
                    loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
                    IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
                                   "Confirmar Exclus" + CHR(227) + "o")
                        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                            IF THIS.this_oBusinessObject.Excluir()
                                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
                                        "Exclu" + CHR(237) + "do")
                                THIS.CarregarLista()
                            ELSE
                                MsgErro("Erro ao excluir registro!", "Excluir")
                            ENDIF
                        ELSE
                            MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o!", "Excluir")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnExcluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Filtra registros no grid por codigo de produto
    * Legado: Procedure fazia LocateCursor('crSigCdPmc','cpros',valor)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_cTermoBusca, loc_oGrid
        loc_cTermoBusca = INPUTBOX("C" + CHR(243) + "digo ou parte do produto:", ;
                                   "Buscar promo" + CHR(231) + CHR(245) + "es", "")

        TRY
            IF !EMPTY(ALLTRIM(loc_cTermoBusca))
                loc_cFiltro = "cpros LIKE " + EscaparSQL(ALLTRIM(loc_cTermoBusca) + "%")
                IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                        loc_oGrid.ColumnCount = 8
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigo"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cpros"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tppro"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.valmin"
                        loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.dtini"
                        loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.dtfin"
                        loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.usualts"
                        loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.dtalts"
                        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                        loc_oGrid.Column2.Header1.Caption = "Produto"
                        loc_oGrid.Column3.Header1.Caption = "Tipo"
                        loc_oGrid.Column4.Header1.Caption = "Valor M" + CHR(237) + "nimo"
                        loc_oGrid.Column5.Header1.Caption = "Dt In" + CHR(237) + "cio"
                        loc_oGrid.Column6.Header1.Caption = "Dt final"
                        loc_oGrid.Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
                        loc_oGrid.Column8.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                ENDIF
            ELSE
                THIS.CarregarLista()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida e salva o registro (Page2 -> BO -> banco)
    * Legado: valida cpros/dtini/dtfin obrigatorios (so em INSERIR)
    *         PMCBO.ValidarPeriodo() tambem verifica sobreposicao de periodo
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oPg2, loc_cMsgVal
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes FORA do TRY para permitir RETURN
        IF THIS.this_cModoAtual = "INCLUIR"
            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Cpros.Value))
                MsgAviso("Produto n" + CHR(227) + "o pode ficar em branco!", ;
                          "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Cpros.SetFocus
                RETURN
            ENDIF
            IF EMPTY(loc_oPg2.txt_4c_Dtini.Value)
                MsgAviso("Data Inicial n" + CHR(227) + "o pode ficar em branco!", ;
                          "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Dtini.SetFocus
                RETURN
            ENDIF
            IF EMPTY(loc_oPg2.txt_4c_Dtfin.Value)
                MsgAviso("Data final n" + CHR(227) + "o pode ficar em branco!", ;
                          "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Dtfin.SetFocus
                RETURN
            ENDIF
            IF loc_oPg2.txt_4c_Dtini.Value > loc_oPg2.txt_4c_Dtfin.Value
                MsgAviso("As datas est" + CHR(227) + "o incompat" + CHR(237) + "veis!", ;
                          "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Dtini.SetFocus
                RETURN
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_cModoAtual = "INCLUIR"
                loc_cMsgVal = THIS.this_oBusinessObject.ValidarPeriodo()
                IF !EMPTY(loc_cMsgVal)
                    MsgAviso(loc_cMsgVal, "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ELSE
                    IF !THIS.this_oBusinessObject.GerarCodigo()
                        MsgErro("Erro ao gerar c" + CHR(243) + "digo!", "Erro")
                    ELSE
                        THIS.this_oBusinessObject.this_cUsualts = ALLTRIM(gc_4c_UsuarioLogado)
                        THIS.this_oBusinessObject.this_tDtalts  = DATETIME()
                        IF THIS.this_oBusinessObject.Salvar()
                            MsgInfo("Registro salvo com sucesso!", "Salvo")
                            THIS.this_cModoAtual = "LISTA"
                            THIS.AlternarPagina(1)
                            loc_lResultado = .T.
                        ELSE
                            MsgErro("Erro ao salvar registro!", "Salvar")
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                THIS.this_oBusinessObject.this_cUsualts = ALLTRIM(gc_4c_UsuarioLogado)
                THIS.this_oBusinessObject.this_tDtalts  = DATETIME()
                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Registro salvo com sucesso!", "Salvo")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AlternarPagina(1)
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao salvar registro!", "Salvar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnSalvarClick:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere campos do form para as propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
            THIS.this_oBusinessObject.this_cCpros   = ALLTRIM(loc_oPg2.txt_4c_Cpros.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbTpDesc", 5)
            THIS.this_oBusinessObject.this_nTppro   = loc_oPg2.cbo_4c_CmbTpDesc.ListIndex
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Valmin", 5)
            THIS.this_oBusinessObject.this_nValmin  = loc_oPg2.txt_4c_Valmin.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
            THIS.this_oBusinessObject.this_tDtini   = loc_oPg2.txt_4c_Dtini.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
            THIS.this_oBusinessObject.this_tDtfin   = loc_oPg2.txt_4c_Dtfin.Value
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos do form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
            loc_oPg2.txt_4c_Codigo.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
            loc_oPg2.txt_4c_Cpros.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbTpDesc", 5)
            loc_oPg2.cbo_4c_CmbTpDesc.ListIndex = THIS.this_oBusinessObject.this_nTppro
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Valmin", 5)
            loc_oPg2.txt_4c_Valmin.Value     = THIS.this_oBusinessObject.this_nValmin
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
            loc_oPg2.txt_4c_Dtini.Value      = THIS.this_oBusinessObject.this_tDtini
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
            loc_oPg2.txt_4c_Dtfin.Value      = THIS.this_oBusinessObject.this_tDtfin
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores dos campos editaveis da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O"
            RETURN
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
            loc_oPg2.txt_4c_Codigo.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
            loc_oPg2.txt_4c_Cpros.Value     = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbTpDesc", 5)
            loc_oPg2.cbo_4c_CmbTpDesc.ListIndex = 1
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Valmin", 5)
            loc_oPg2.txt_4c_Valmin.Value    = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
            loc_oPg2.txt_4c_Dtini.Value     = {}
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
            loc_oPg2.txt_4c_Dtfin.Value     = {}
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme modo
    * Legado When clauses: getcodigo=RETURN .F. (sempre RO)
    *        getCpros/getDtini/GetDtfin/cmbTpDesc = INLIST INSERIR
    *        GetValmin = sem restricao (editavel em INSERIR e ALTERAR)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lInserir
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2
        loc_lInserir = (THIS.this_cModoAtual = "INCLUIR")

        IF VARTYPE(loc_oPg2) != "O"
            RETURN
        ENDIF

        *-- Codigo sempre ReadOnly (legado: getcodigo.When = RETURN .F.)
        IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
            loc_oPg2.txt_4c_Codigo.ReadOnly = .T.
            loc_oPg2.txt_4c_Codigo.Enabled  = .F.
        ENDIF

        *-- Produto: editavel apenas no INSERIR
        IF PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
            loc_oPg2.txt_4c_Cpros.ReadOnly = !(par_lHabilitar AND loc_lInserir)
            loc_oPg2.txt_4c_Cpros.Enabled  = par_lHabilitar AND loc_lInserir
        ENDIF

        *-- Tipo desconto: editavel apenas no INSERIR
        IF PEMSTATUS(loc_oPg2, "cbo_4c_CmbTpDesc", 5)
            loc_oPg2.cbo_4c_CmbTpDesc.Enabled = par_lHabilitar AND loc_lInserir
        ENDIF

        *-- Valor minimo: editavel em INSERIR e ALTERAR
        IF PEMSTATUS(loc_oPg2, "txt_4c_Valmin", 5)
            loc_oPg2.txt_4c_Valmin.ReadOnly = !par_lHabilitar
            loc_oPg2.txt_4c_Valmin.Enabled  = par_lHabilitar
        ENDIF

        *-- Datas: editaveis apenas no INSERIR
        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtini", 5)
            loc_oPg2.txt_4c_Dtini.ReadOnly = !(par_lHabilitar AND loc_lInserir)
            loc_oPg2.txt_4c_Dtini.Enabled  = par_lHabilitar AND loc_lInserir
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Dtfin", 5)
            loc_oPg2.txt_4c_Dtfin.ReadOnly = !(par_lHabilitar AND loc_lInserir)
            loc_oPg2.txt_4c_Dtfin.Enabled  = par_lHabilitar AND loc_lInserir
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita Confirmar por modo
    * VISUALIZAR: Confirmar disabled, Cancelar enabled
    * INCLUIR/ALTERAR: ambos enabled
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_oBtns
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2) != "O"
            RETURN
        ENDIF
        IF !PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            RETURN
        ENDIF

        loc_oBtns = loc_oPg2.cnt_4c_BotoesAcao

        DO CASE
            CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                IF PEMSTATUS(loc_oBtns, "cmd_4c_Confirmar", 5)
                    loc_oBtns.cmd_4c_Confirmar.Enabled = .T.
                ENDIF
                IF PEMSTATUS(loc_oBtns, "cmd_4c_Cancelar", 5)
                    loc_oBtns.cmd_4c_Cancelar.Enabled = .T.
                ENDIF
            CASE THIS.this_cModoAtual = "VISUALIZAR"
                IF PEMSTATUS(loc_oBtns, "cmd_4c_Confirmar", 5)
                    loc_oBtns.cmd_4c_Confirmar.Enabled = .F.
                ENDIF
                IF PEMSTATUS(loc_oBtns, "cmd_4c_Cancelar", 5)
                    loc_oBtns.cmd_4c_Cancelar.Enabled = .T.
                ENDIF
        ENDCASE
    ENDPROC

    *==========================================================================
    * TeclaTxtCpros - KeyPress de txt_4c_Cpros: F4(115) ou F5(116) abre busca
    *==========================================================================
    PROCEDURE TeclaTxtCpros(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaProduto()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaProduto - Busca produto em SigCdPro via FormBuscaAuxiliar
    * Original: fwbuscaext em SigCdPro, campo CPros, descricao DPros
    *==========================================================================
    PROCEDURE AbrirBuscaProduto()
        LOCAL loc_oPg2, loc_cValor, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF THIS.this_cModoAtual != "INCLUIR"
            RETURN
        ENDIF

        loc_cValor = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
            loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Cpros.Value)
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cValor, ;
                "Selecionar Produto")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaPro") AND PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
                        loc_oPg2.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaPro.CPros)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
                        IF PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
                            loc_oPg2.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_BuscaPro.CPros)
                        ENDIF
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AbrirBuscaProduto:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaPro")
            USE IN cursor_4c_BuscaPro
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarProduto - LostFocus de txt_4c_Cpros: verifica codigo em SigCdPro
    * Original: fwbuscaext abre lista se nao achou; campo vazio -> limpa
    *==========================================================================
    PROCEDURE ValidarProduto(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cCpros, loc_cSQL, loc_nResult
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF THIS.this_cModoAtual != "INCLUIR"
            RETURN
        ENDIF
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        IF !PEMSTATUS(loc_oPg2, "txt_4c_Cpros", 5)
            RETURN
        ENDIF

        loc_cCpros = ALLTRIM(loc_oPg2.txt_4c_Cpros.Value)

        IF EMPTY(loc_cCpros)
            loc_oPg2.txt_4c_Cpros.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros)

            IF USED("cursor_4c_ValPro")
                USE IN cursor_4c_ValPro
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValPro")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValPro") > 0
                SELECT cursor_4c_ValPro
                loc_oPg2.txt_4c_Cpros.Value = ALLTRIM(cursor_4c_ValPro.CPros)
            ELSE
                THIS.AbrirBuscaProduto()
            ENDIF

            IF USED("cursor_4c_ValPro")
                USE IN cursor_4c_ValPro
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ValidarProduto:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValPro")
                USE IN cursor_4c_ValPro
            ENDIF
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\PMCBO.prg):
*==============================================================================
* PMCBO.prg - Business Object: Tabela de Promo??es por Per?odo
* Tabela: SigCdPmc (PK: codigo)
* Schema:
*   codigo   char(10)     PK  auto-gerado PMC+AAMM+SEQ
*   cpros    char(14)     FK SigCdPro.CPros
*   tppro    numeric(2,0) tipo (1=Brinde)
*   dtini    datetime     data inicial
*   dtfin    datetime     data final
*   valmin   numeric(9,2) valor minimo
*   usualts  char(10)     usuario ultima alteracao
*   dtalts   datetime     data/hora ultima alteracao
*==============================================================================
DEFINE CLASS PMCBO AS BusinessBase

    *-- Chave prim?ria
    this_cCodigo   = ""

    *-- Produto (FK SigCdPro.CPros)
    this_cCpros    = ""

    *-- Tipo de promo??o: 1=Brinde
    this_nTppro    = 0

    *-- Per?odo de vig?ncia
    this_tDtini    = {}
    this_tDtfin    = {}

    *-- Valor m?nimo da venda para conceder o brinde
    this_nValmin   = 0

    *-- Auditoria
    this_cUsualts  = ""
    this_tDtalts   = {}

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPmc"
        THIS.this_cCampoChave = "codigo"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cCodigo
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo   = TratarNulo(codigo,   "")
            THIS.this_cCpros    = TratarNulo(cpros,    "")
            THIS.this_nTppro    = TratarNulo(tppro,    0)
            THIS.this_tDtini    = TratarNulo(dtini,    {})
            THIS.this_tDtfin    = TratarNulo(dtfin,    {})
            THIS.this_nValmin   = TratarNulo(valmin,   0)
            THIS.this_cUsualts  = TratarNulo(usualts,  "")
            THIS.this_tDtalts   = TratarNulo(dtalts,   {})
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT lista para o grid
    * par_cFiltro: condi??o SQL adicional (sem WHERE), ou "" para todos
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT codigo, cpros, tppro, valmin, dtini, dtfin," + ;
                       " usualts, dtalts" + ;
                       " FROM SigCdPmc" + loc_cWhere + ;
                       " ORDER BY codigo"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar promo??es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.Buscar:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo c?digo (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigo, cpros, tppro, valmin, dtini, dtfin," + ;
                       " usualts, dtalts" + ;
                       " FROM SigCdPmc" + ;
                       " WHERE codigo = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.CarregarPorCodigo:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarCodigo - Gera c?digo auto no formato PMC+AAMM+SEQ (ex: PMC2608001)
    * Replica l?gica original: 'PMC'+SUBSTR(STR(YEAR),3)+PADL(MONTH,2,'0')+SEQ
    *==========================================================================
    PROCEDURE GerarCodigo()
    *==========================================================================
        LOCAL loc_cPrefixo, loc_cSQL, loc_nResult, loc_cCodigo, loc_nSeq, loc_lSucesso
        loc_lSucesso = .F.
        loc_cCodigo  = ""

        TRY
            loc_cPrefixo = "PMC" + SUBSTR(ALLTRIM(STR(YEAR(DATE()))), 3) + ;
                           PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPmc" + ;
                       " WHERE codigo LIKE " + EscaparSQL(loc_cPrefixo + "%")

            IF USED("cursor_4c_Seq")
                USE IN cursor_4c_Seq
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Seq")

            IF loc_nResult >= 0
                SELECT cursor_4c_Seq
                loc_nSeq    = cursor_4c_Seq.qtd + 1
                loc_cCodigo = loc_cPrefixo + PADL(ALLTRIM(STR(loc_nSeq)), 3, "0")
                USE IN cursor_4c_Seq
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao gerar c?digo PMC:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_Seq")
                    USE IN cursor_4c_Seq
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.GerarCodigo:" + CHR(13) + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_lSucesso
            THIS.this_cCodigo = loc_cCodigo
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDtIniFim - Valida que dtini <= dtfin e que o per?odo n?o existe
    * Retorna "" se OK, ou mensagem de erro
    *==========================================================================
    PROCEDURE ValidarPeriodo()
    *==========================================================================
        LOCAL loc_cMsg, loc_cSQL, loc_nResult, loc_cDtIni, loc_cDtFin, loc_lSucesso
        loc_cMsg     = ""
        loc_lSucesso = .T.

        TRY
            *-- Validar campos obrigat?rios
            IF EMPTY(THIS.this_cCpros)
                loc_lSucesso = "Produto n" + CHR(227) + "o pode ficar em branco!"
            ENDIF
            IF EMPTY(THIS.this_tDtini)
                loc_lSucesso = "Data Inicial n" + CHR(227) + "o pode ficar em branco!"
            ENDIF
            IF EMPTY(THIS.this_tDtfin)
                loc_lSucesso = "Data final n" + CHR(227) + "o pode ficar em branco!"
            ENDIF
            IF THIS.this_tDtini > THIS.this_tDtfin
                loc_lSucesso = "As datas est" + CHR(227) + "o incompat" + CHR(237) + "veis!"
            ENDIF

            *-- Verificar sobreposi??o de per?odo para o mesmo produto (s? no INSERT)
            IF THIS.this_lNovoRegistro
                loc_cDtIni = FormatarDataSQL(THIS.this_tDtini)
                loc_cDtFin = FormatarDataSQL(THIS.this_tDtfin)

                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPmc" + ;
                           " WHERE cpros = " + EscaparSQL(THIS.this_cCpros) + ;
                           " AND (" + ;
                           "  " + loc_cDtIni + " BETWEEN" + ;
                           "    LEFT(CONVERT(VARCHAR, dtini, 120), 10)" + ;
                           "    AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                           " OR " + ;
                           "  " + loc_cDtFin + " BETWEEN" + ;
                           "    LEFT(CONVERT(VARCHAR, dtini, 120), 10)" + ;
                           "    AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                           ")"

                IF USED("cursor_4c_Val")
                    USE IN cursor_4c_Val
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Val")

                IF loc_nResult >= 0
                    SELECT cursor_4c_Val
                    IF cursor_4c_Val.qtd > 0
                        loc_cMsg = "Esse intervalo j" + CHR(225) + " est" + CHR(225) + ;
                                   " cadastrado para esse produto!"
                    ENDIF
                    USE IN cursor_4c_Val
                ELSE
                    MsgErro("Erro ao validar per?odo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    IF USED("cursor_4c_Val")
                        USE IN cursor_4c_Val
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.ValidarPeriodo:" + CHR(13) + loException.Message, "Erro")
            loc_cMsg = "Erro interno ao validar per?odo."
        ENDTRY

        RETURN loc_cMsg
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdPmc" + ;
                       " (codigo, cpros, tppro, dtini, dtfin, valmin, usualts, dtalts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo)            + ", " + ;
                       EscaparSQL(THIS.this_cCpros)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTppro)       + ", " + ;
                       FormatarDataSQL(THIS.this_tDtini)         + ", " + ;
                       FormatarDataSQL(THIS.this_tDtfin)         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValmin)      + ", " + ;
                       EscaparSQL(THIS.this_cUsualts)           + ", " + ;
                       FormatarDataSQL(THIS.this_tDtalts)        + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir promo??o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.Inserir:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdPmc SET" + ;
                       " cpros   = " + EscaparSQL(THIS.this_cCpros)          + ", " + ;
                       " tppro   = " + FormatarNumeroSQL(THIS.this_nTppro)   + ", " + ;
                       " dtini   = " + FormatarDataSQL(THIS.this_tDtini)     + ", " + ;
                       " dtfin   = " + FormatarDataSQL(THIS.this_tDtfin)     + ", " + ;
                       " valmin  = " + FormatarNumeroSQL(THIS.this_nValmin)  + ", " + ;
                       " usualts = " + EscaparSQL(THIS.this_cUsualts)        + ", " + ;
                       " dtalts  = " + FormatarDataSQL(THIS.this_tDtalts)    + ;
                       " WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar promo??o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.Atualizar:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPmc WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir promo??o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.ExecutarExclusao:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

