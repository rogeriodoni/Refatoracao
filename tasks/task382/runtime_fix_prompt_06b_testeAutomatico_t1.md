# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 412; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-29 23:23:02] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-29 23:23:02] [INFO] Config FPW: (nao fornecido)
[2026-07-29 23:23:02] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 23:23:02] [INFO] Timeout: 300 segundos
[2026-07-29 23:23:02] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5yynspdx.prg
[2026-07-29 23:23:02] [INFO] Conteudo do wrapper:
[2026-07-29 23:23:02] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCRC', 'C:\4c\tasks\task382', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCRC', 'C:\4c\tasks\task382', 'CRUD'
QUIT

[2026-07-29 23:23:02] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5yynspdx.prg
[2026-07-29 23:23:02] [INFO] VFP output esperado em: C:\4c\tasks\task382\vfp_output.txt
[2026-07-29 23:23:02] [INFO] Executando Visual FoxPro 9...
[2026-07-29 23:23:02] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5yynspdx.prg
[2026-07-29 23:23:02] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5yynspdx.prg
[2026-07-29 23:23:02] [INFO] Timeout configurado: 300 segundos
[2026-07-29 23:23:44] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-29 23:23:44] [INFO] VFP9 finalizado em 42.3508693 segundos
[2026-07-29 23:23:44] [INFO] Exit Code: 
[2026-07-29 23:23:44] [INFO] 
[2026-07-29 23:23:44] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-29 23:23:44] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5yynspdx.prg
[2026-07-29 23:23:44] [INFO] 
[2026-07-29 23:23:44] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-29 23:23:44] [INFO] * Auto-generated wrapper for parameters
[2026-07-29 23:23:44] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 23:23:44] [INFO] * Parameters: 'FormCRC', 'C:\4c\tasks\task382', 'CRUD'
[2026-07-29 23:23:44] [INFO] 
[2026-07-29 23:23:44] [INFO] * Anti-dialog protections for unattended execution
[2026-07-29 23:23:44] [INFO] SET SAFETY OFF
[2026-07-29 23:23:44] [INFO] SET RESOURCE OFF
[2026-07-29 23:23:44] [INFO] SET TALK OFF
[2026-07-29 23:23:44] [INFO] SET NOTIFY OFF
[2026-07-29 23:23:44] [INFO] SYS(2335, 0)
[2026-07-29 23:23:44] [INFO] 
[2026-07-29 23:23:44] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCRC', 'C:\4c\tasks\task382', 'CRUD'
[2026-07-29 23:23:44] [INFO] QUIT
[2026-07-29 23:23:44] [INFO] 
[2026-07-29 23:23:44] [INFO] === Fim do Wrapper.prg ===
[2026-07-29 23:23:44] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormCRC",
  "timestamp": "20260729232344",
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
      "detalhes": "Linha: 412"
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
      "detalhes": "AbrirLookup: 2 (ABRIRLOOKUPGRUPOCODIGO, ABRIRLOOKUPGRUPODESCRS) | KeyPress handlers: 3 (DGRUPOSKEYPRESS, GRUPOKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCRC.prg):
*==============================================================================
* FormCRC.prg - Cadastro de Caracteristicas de Contas (SIGCDCRC)
*==============================================================================
* Tarefa   : task382 - Migracao de SIGCDCRC
* Fase     : 8/8 - COMPLETO
* Tabela   : SigCrRac  |  PK: Codigos
* BO       : CRCBO.prg
*==============================================================================

DEFINE CLASS FormCRC AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Caracter" + CHR(237) + "sticas de Contas"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de negocio
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - Inicializa o formulario
    * FormBase.Init() chama THIS.InicializarForm() automaticamente via DODEFAULT
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MostrarErro("Erro na inicializa" + CHR(231) + CHR(227) + "o do FormCRC:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), "FormCRC.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Configuracao completa chamada pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("CRCBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar CRCBO - VARTYPE: " + VARTYPE(THIS.this_oBusinessObject), "FormCRC.InicializarForm")
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

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormCRC:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), "FormCRC.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria pgf_4c_Paginas com Page1 (Lista) e Page2 (Dados)
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
            .Visible   = .T.

            .Page1.BackColor = RGB(90, 90, 90)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(90, 90, 90)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Estrutura da Page1 (Lista)
    * Cabecalho + Botoes CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar) + Grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (titulo do form)
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
            .Caption   = "Cadastro de Caracter" + CHR(237) + "sticas de Contas"
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
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
            .Caption   = "Cadastro de Caracter" + CHR(237) + "sticas de Contas"
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

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

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
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

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
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

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
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

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
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

        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Left=917, Width=90, cmd Width=75)
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

        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid da lista: 3 colunas do original (Grupos=80, Codigos=150, Descrs=290)
        *-- ColumnCount FORA do WITH (Problema 36)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 3

        WITH loc_oPagina.grd_4c_Lista
            .Top                = 126
            .Left               = 31
            .Width              = 937
            .Height             = 489
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

    *==========================================================================
    * ConfigurarPaginaDados - Estrutura da Page2 (Dados)
    * cnt_4c_Salva com botoes Confirmar + Cancelar
    * Fases 5-6 adicionam: Labels, TextBoxes e CheckBoxes
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes acao (Confirmar + Cancelar)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
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
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
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

        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- ===== FASE 5: Labels + TextBoxes (Codigos e Descrs) =====
        *-- Compensacao PageFrame: Top_original + 29

        *-- Label: Codigo (Say1 original: Top=174, Left=297, ForeColor=90,90,90)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 203
            .Left      = 297
            .Width     = 44
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox: Codigos (getCodigos original: Top=171, Left=341, Width=150, MaxLength=20)
        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Value         = ""
            .Top           = 200
            .Left          = 341
            .Width         = 150
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .MaxLength     = 20
            .Format        = "K!"
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label: Descricao (Say2 original: Top=201, Left=284, ForeColor=90,90,90)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 230
            .Left      = 284
            .Width     = 57
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox: Descrs (getDescrs original: Top=198, Left=341, Width=290, MaxLength=40)
        loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPagina.txt_4c_Descrs
            .Value         = ""
            .Top           = 227
            .Left          = 341
            .Width         = 290
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .MaxLength     = 40
            .Format        = "K!"
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label: Grupo (Say3 original: Top=228, Left=301, ForeColor=90,90,90)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Grupo :"
            .Top       = 257
            .Left      = 301
            .Width     = 40
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox: Grupo codigo (getGrupos: Top=225+29=254, Left=341, Width=80, MaxLength=10)
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value         = ""
            .Top           = 254
            .Left          = 341
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .MaxLength     = 10
            .Format        = "K!"
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *-- TextBox: Grupo descricao (getDGrupos: Top=225+29=254, Left=425, Width=290, MaxLength=40)
        *-- Habilitado apenas quando txt_4c_Grupo estiver vazio (legado: getDGrupos.When)
        loc_oPagina.AddObject("txt_4c_DGrupos", "TextBox")
        WITH loc_oPagina.txt_4c_DGrupos
            .Value         = ""
            .Top           = 254
            .Left          = 425
            .Width         = 290
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .MaxLength     = 40
            .Format        = "K!"
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- CheckBox: Lock (Check1: graphical style=1, Top=159+29=188, Left=494, 35x35)
        loc_oPagina.AddObject("chk_4c_Check1", "CheckBox")
        WITH loc_oPagina.chk_4c_Check1
            .Caption       = ""
            .Top           = 188
            .Left          = 494
            .Height        = 35
            .Width         = 35
            .Style         = 1
            .Picture       = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
            .Alignment     = 0
            .BackColor     = RGB(255, 255, 255)
            .BackStyle     = 1
            .SpecialEffect = 0
            .Themes        = .F.
            .Value         = 0
            .AutoSize      = .F.
            .Visible       = .T.
        ENDWITH

        *-- CheckBox: Automatico (chkAuto: Top=174+29=203, Left=535)
        loc_oPagina.AddObject("chk_4c_ChkAuto", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkAuto
            .Caption       = "Autom" + CHR(225) + "tico"
            .Top           = 203
            .Left          = 535
            .Height        = 17
            .Width         = 80
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Value         = 0
            .AutoSize      = .T.
            .Visible       = .T.
        ENDWITH

        *-- CheckBox: Bloquear Alteracoes (chkBloqueios: Top=256+29=285, Left=341)
        loc_oPagina.AddObject("chk_4c_ChkBloqueios", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkBloqueios
            .Caption       = "Bloquear Altera" + CHR(231) + CHR(245) + "es"
            .Top           = 285
            .Left          = 341
            .Height        = 17
            .Width         = 120
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Value         = 0
            .AutoSize      = .T.
            .Visible       = .T.
        ENDWITH

        *-- CheckBox: Lancamento Obrigatorio (chkObrigs: Top=279+29=308, Left=341)
        loc_oPagina.AddObject("chk_4c_ChkObrigs", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkObrigs
            .Caption       = "Lan" + CHR(231) + "amento Obrigat" + CHR(243) + "rio"
            .Top           = 308
            .Left          = 341
            .Height        = 17
            .Width         = 140
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Value         = 0
            .AutoSize      = .T.
            .Visible       = .T.
        ENDWITH

        *-- BINDEVENT lookups: Grupo (F4/LostFocus) e DGrupos (F4/LostFocus)
        BINDEVENT(loc_oPagina.txt_4c_Grupo,   "KeyPress",  THIS, "GrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Grupo,   "KeyPress", THIS, "GrupoLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_DGrupos, "KeyPress",  THIS, "DGruposKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DGrupos, "KeyPress", THIS, "DGruposLostFocus")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no cursor e configura o Grid da Page1
    * Grid: 3 colunas - Grupos(80), Codigos(150), Descrs(290)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    IF THIS.this_oBusinessObject.Buscar("")
                        *-- Configurar Grid apenas se ja foi adicionado a Page1 (Problema 36)
                        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                            *-- RecordSource FORA de WITH (Problema 36)
                            loc_oGrid.ColumnCount = 3
                            loc_oGrid.RecordSource = "cursor_4c_Dados"

                            *-- ControlSources APOS RecordSource (Problema 48)
                            loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.grupos"
                            loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.codigos"
                            loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"

                            loc_oGrid.Column1.Width = 80
                            loc_oGrid.Column2.Width = 150
                            loc_oGrid.Column3.Width = 290

                            *-- Headers OBRIGATORIO apos RecordSource (Problema 2 / Problema 32)
                            loc_oGrid.Column1.Header1.Caption = "Grupo"
                            loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
                            loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                            THIS.FormatarGridLista(loc_oGrid)
                        ENDIF
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), "FormCRC.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "FormCRC.AlternarPagina")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Cria novo registro e navega para Page2
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

            IF !EMPTY(loc_cCodigo)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        ELSE
            MsgAviso("Nenhum registro selecionado!")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

            IF !EMPTY(loc_cCodigo)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        ELSE
            MsgAviso("Nenhum registro selecionado!")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

            IF !EMPTY(loc_cCodigo)
                loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da caracteristica '" + ;
                    loc_cCodigo + "'?", "Excluir")
                IF loc_lConfirma
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgSucesso("Registro exclu" + CHR(237) + "do com sucesso!")
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ELSE
            MsgAviso("Nenhum registro selecionado!")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar para filtrar/localizar registro
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCrRac", "cursor_4c_BuscaCRC", "codigos", "", ;
                "Buscar Caracteristica")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("grupos",  "", "Grupo")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCRC")
                    SELECT cursor_4c_BuscaCRC
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaCRC.codigos)
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormCRC.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaCRC")
            USE IN cursor_4c_BuscaCRC
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Transfere dados do Form para o BO e salva
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()
        IF THIS.this_oBusinessObject.Salvar()
            MsgSucesso("Registro salvo com sucesso!")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela e retorna para a lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores de todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPag2, "txt_4c_Codigos", 5)
            loc_oPag2.txt_4c_Codigos.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Descrs", 5)
            loc_oPag2.txt_4c_Descrs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
            loc_oPag2.txt_4c_Grupo.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
            loc_oPag2.txt_4c_DGrupos.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_ChkAuto", 5)
            loc_oPag2.chk_4c_ChkAuto.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_ChkBloqueios", 5)
            loc_oPag2.chk_4c_ChkBloqueios.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_ChkObrigs", 5)
            loc_oPag2.chk_4c_ChkObrigs.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_Check1", 5)
            loc_oPag2.chk_4c_Check1.Value = 0
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos da Page2 conforme o modo atual
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag2, loc_lCodHabilitado
        loc_oPag2          = THIS.pgf_4c_Paginas.Page2
        loc_lCodHabilitado = (THIS.this_cModoAtual = "INCLUIR")

        IF PEMSTATUS(loc_oPag2, "txt_4c_Codigos", 5)
            loc_oPag2.txt_4c_Codigos.Enabled = loc_lCodHabilitado
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Descrs", 5)
            loc_oPag2.txt_4c_Descrs.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
            loc_oPag2.txt_4c_Grupo.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
            loc_oPag2.txt_4c_DGrupos.Enabled = .F.
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_ChkAuto", 5)
            loc_oPag2.chk_4c_ChkAuto.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_ChkBloqueios", 5)
            loc_oPag2.chk_4c_ChkBloqueios.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_ChkObrigs", 5)
            loc_oPag2.chk_4c_ChkObrigs.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_Check1", 5)
            loc_oPag2.chk_4c_Check1.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPag2, "cnt_4c_Salva", 5)
            loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
            loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do BO para os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPag2, "txt_4c_Codigos", 5)
            loc_oPag2.txt_4c_Codigos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Descrs", 5)
            loc_oPag2.txt_4c_Descrs.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
            loc_oPag2.txt_4c_Grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
            loc_oPag2.txt_4c_DGrupos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDGrupos)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_ChkAuto", 5)
            loc_oPag2.chk_4c_ChkAuto.Value = (THIS.this_oBusinessObject.this_nAutos .Value = IIF(THIS.this_oBusinessObject.this_nAutos = 1, 1, 0))
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_ChkBloqueios", 5)
            loc_oPag2.chk_4c_ChkBloqueios.Value = (THIS.this_oBusinessObject.this_nBloqueios .Value = IIF(THIS.this_oBusinessObject.this_nBloqueios = 1, 1, 0))
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_ChkObrigs", 5)
            loc_oPag2.chk_4c_ChkObrigs.Value = (THIS.this_oBusinessObject.this_nObrigs .Value = IIF(THIS.this_oBusinessObject.this_nObrigs = 1, 1, 0))
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_Check1", 5)
            loc_oPag2.chk_4c_Check1.Value = (THIS.this_oBusinessObject.this_nLocks .Value = IIF(THIS.this_oBusinessObject.this_nLocks = 1, 1, 0))
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere dados dos campos da Page2 para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPag2, "txt_4c_Codigos", 5)
            THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPag2.txt_4c_Codigos.Value)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Descrs", 5)
            THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPag2.txt_4c_Descrs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
            THIS.this_oBusinessObject.this_cGrupos = ALLTRIM(loc_oPag2.txt_4c_Grupo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_ChkAuto", 5)
            THIS.this_oBusinessObject.this_nAutos = IIF(loc_oPag2.chk_4c_ChkAuto.Value, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_ChkBloqueios", 5)
            THIS.this_oBusinessObject.this_nBloqueios = IIF(loc_oPag2.chk_4c_ChkBloqueios.Value, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_ChkObrigs", 5)
            THIS.this_oBusinessObject.this_nObrigs = IIF(loc_oPag2.chk_4c_ChkObrigs.Value, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "chk_4c_Check1", 5)
            THIS.this_oBusinessObject.this_nLocks = IIF(loc_oPag2.chk_4c_Check1.Value, 1, 0)
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao destruir FormCRC:" + CHR(13) + loc_oErro.Message, "FormCRC.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do Grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * GrupoKeyPress - F4 abre lookup de SigCdGcr pelo codigo do grupo
    *==========================================================================
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupoCodigo()
        ENDIF
    ENDPROC

    *==========================================================================
    * GrupoLostFocus - Ao sair do campo Grupo, valida codigo e preenche descricao
    * Reproduz logica de getGrupos.Valid -> fAcessoContab('C', ...)
    *==========================================================================
    PROCEDURE GrupoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag2, loc_cCodigo, loc_cDescricao
        loc_oPag2      = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo    = ""
        loc_cDescricao = ""

        IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
            loc_cCodigo = ALLTRIM(loc_oPag2.txt_4c_Grupo.Value)
        ENDIF

        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
                loc_oPag2.txt_4c_DGrupos.Value   = ""
                loc_oPag2.txt_4c_DGrupos.Enabled = (THIS.this_cModoAtual # "VISUALIZAR")
            ENDIF
        ELSE
            loc_cDescricao = THIS.this_oBusinessObject.BuscarDescricaoGrupo(loc_cCodigo)
            IF EMPTY(loc_cDescricao)
                MsgAviso("Grupo n" + CHR(227) + "o encontrado!")
                THIS.AbrirLookupGrupoCodigo()
            ELSE
                IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
                    loc_oPag2.txt_4c_DGrupos.Value   = loc_cDescricao
                    loc_oPag2.txt_4c_DGrupos.Enabled = .F.
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * DGruposKeyPress - F4 abre lookup de SigCdGcr pela descricao do grupo
    *==========================================================================
    PROCEDURE DGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupoDescrs()
        ENDIF
    ENDPROC

    *==========================================================================
    * DGruposLostFocus - Ao sair do campo DGrupos, pesquisa grupo por descricao
    * Reproduz logica de getDGrupos.Valid -> fAcessoContab('D', ...)
    *==========================================================================
    PROCEDURE DGruposLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag2, loc_cDescricao
        loc_oPag2      = THIS.pgf_4c_Paginas.Page2
        loc_cDescricao = ""

        IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
            loc_cDescricao = ALLTRIM(loc_oPag2.txt_4c_DGrupos.Value)
        ENDIF

        IF !EMPTY(loc_cDescricao)
            THIS.AbrirLookupGrupoDescrs()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupGrupoCodigo - Abre picker de SigCdGcr por codigo
    * Substitui fAcessoContab(Usuar, 'C', ...) do legado
    *==========================================================================
    PROCEDURE AbrirLookupGrupoCodigo()
        LOCAL loc_oBusca, loc_oPag2, loc_cCodigo, loc_cDescricao
        loc_oPag2      = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo    = ""
        loc_cDescricao = ""

        IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
            IF !loc_oPag2.txt_4c_Grupo.Enabled
                RETURN
            ENDIF
            loc_cCodigo = ALLTRIM(loc_oPag2.txt_4c_Grupo.Value)
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cCodigo, ;
                "Buscar Grupo de Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGcr.codigos)
                    loc_cDescricao = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                    IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
                        loc_oPag2.txt_4c_Grupo.Value = loc_cCodigo
                    ENDIF
                    IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
                        loc_oPag2.txt_4c_DGrupos.Value   = loc_cDescricao
                        loc_oPag2.txt_4c_DGrupos.Enabled = .F.
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao abrir busca de grupo:" + CHR(13) + loException.Message, ;
                "FormCRC.AbrirLookupGrupoCodigo")
        ENDTRY

        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupGrupoDescrs - Abre picker de SigCdGcr pela descricao
    * Substitui fAcessoContab(Usuar, 'D', ...) do legado
    *==========================================================================
    PROCEDURE AbrirLookupGrupoDescrs()
        LOCAL loc_oBusca, loc_oPag2, loc_cDescricao, loc_cCodigo
        loc_oPag2      = THIS.pgf_4c_Paginas.Page2
        loc_cDescricao = ""
        loc_cCodigo    = ""

        IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
            IF !loc_oPag2.txt_4c_DGrupos.Enabled
                RETURN
            ENDIF
            loc_cDescricao = ALLTRIM(loc_oPag2.txt_4c_DGrupos.Value)
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "descrs", loc_cDescricao, ;
                "Buscar Grupo de Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGcr.codigos)
                    loc_cDescricao = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                    IF PEMSTATUS(loc_oPag2, "txt_4c_Grupo", 5)
                        loc_oPag2.txt_4c_Grupo.Value = loc_cCodigo
                    ENDIF
                    IF PEMSTATUS(loc_oPag2, "txt_4c_DGrupos", 5)
                        loc_oPag2.txt_4c_DGrupos.Value   = loc_cDescricao
                        loc_oPag2.txt_4c_DGrupos.Enabled = .F.
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao abrir busca de grupo por descri" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loException.Message, "FormCRC.AbrirLookupGrupoDescrs")
        ENDTRY

        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD da Page1 conforme
    * disponibilidade de registros no cursor
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemRegistro, loc_oCnt
        loc_lTemRegistro = (USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND ;
            RECCOUNT("cursor_4c_Dados") > 0)

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            IF PEMSTATUS(loc_oCnt, "cmd_4c_Visualizar", 5)
                loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
            ENDIF
            IF PEMSTATUS(loc_oCnt, "cmd_4c_Alterar", 5)
                loc_oCnt.cmd_4c_Alterar.Enabled = loc_lTemRegistro
            ENDIF
            IF PEMSTATUS(loc_oCnt, "cmd_4c_Excluir", 5)
                loc_oCnt.cmd_4c_Excluir.Enabled = loc_lTemRegistro
            ENDIF
        ENDIF
    ENDPROC

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

ENDDEFINE


### BO (C:\4c\projeto\app\classes\CRCBO.prg):
*==============================================================================
* CRCBO.prg - Business Object: Caracteristicas de Contas (SigCrRac)
*==============================================================================
* Tarefa   : task382 - Migracao de SIGCDCRC
* Tabela   : SigCrRac
* PK       : Codigos  (char 20)
*==============================================================================

DEFINE CLASS CRCBO AS BusinessBase

    *-- ----------------------------------------------------------------
    *-- Campos da tabela SigCrRac
    *-- ----------------------------------------------------------------
    this_cCodigos   = ""    && codigos   char(20)  PK
    this_cDescrs    = ""    && descrs    char(40)
    this_cGrupos    = ""    && grupos    char(10)  FK -> SigCdGcr.Codigos
    this_nAutos     = 0     && autos     numeric(1,0)
    this_nLocks     = 0     && locks     numeric(1,0)
    this_nBloqueios = 0     && bloqueios numeric(1,0)
    this_nObrigs    = 0     && obrigs    numeric(1,0)
    this_nCodobs    = 0     && codobs    numeric(3,0)
    this_dDtInis    = {}    && dtinis    datetime NULL
    this_dDtFins    = {}    && dtfins    datetime NULL
    this_nOrdems    = 0     && ordems    numeric(3,0)
    this_cRelacs    = ""    && relacs    char(30)
    this_nTipoops   = 0     && tipoops   numeric(2,0)
    this_nTpprocs   = 0     && tpprocs   numeric(2,0)

    *-- Campo auxiliar de UI (descricao do grupo - vem de SigCdGcr.Descrs, nao persiste)
    this_cDGrupos   = ""

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo-chave do BusinessBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCrRac"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para o sistema de auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos   = TratarNulo(codigos,   "C")
                THIS.this_cDescrs    = TratarNulo(descrs,    "C")
                THIS.this_cGrupos    = TratarNulo(grupos,    "C")
                THIS.this_nAutos     = TratarNulo(autos,     "N")
                THIS.this_nLocks     = TratarNulo(locks,     "N")
                THIS.this_nBloqueios = TratarNulo(bloqueios, "N")
                THIS.this_nObrigs    = TratarNulo(obrigs,    "N")
                THIS.this_nCodobs    = TratarNulo(codobs,    "N")
                THIS.this_dDtInis    = TratarNulo(dtinis,    "T")
                THIS.this_dDtFins    = TratarNulo(dtfins,    "T")
                THIS.this_nOrdems    = TratarNulo(ordems,    "N")
                THIS.this_cRelacs    = TratarNulo(relacs,    "C")
                THIS.this_nTipoops   = TratarNulo(tipoops,   "N")
                THIS.this_nTpprocs   = TratarNulo(tpprocs,   "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CRCBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_nResultado, loc_cSQL
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!")
            loc_lValido = .F.
            RETURN loc_lValido
        ENDIF

        IF EMPTY(THIS.this_cDescrs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!")
            loc_lValido = .F.
            RETURN loc_lValido
        ENDIF

        *-- Verificar duplicidade de Codigos (apenas no INSERT)
        IF THIS.this_lNovoRegistro
            TRY
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCrRac" + ;
                    " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
                IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                    SELECT cursor_4c_ChkCod
                    IF cursor_4c_ChkCod.qtd > 0
                        MsgAviso("C" + CHR(243) + "digo da Caracter" + CHR(237) + "stica J" + CHR(225) + " Cadastrado!!!")
                        loc_lValido = .F.
                    ENDIF
                    USE IN cursor_4c_ChkCod
                ENDIF
            CATCH TO loException
                MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CRCBO.ValidarDados")
                loc_lValido = .F.
            ENDTRY
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCrRac
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCrRac (codigos, descrs, grupos, autos, locks, bloqueios, obrigs, codobs, dtinis, dtfins, ordems, relacs, tipoops, tpprocs)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cDescrs)>>,
                    <<EscaparSQL(THIS.this_cGrupos)>>,
                    <<FormatarNumeroSQL(THIS.this_nAutos,     0)>>,
                    <<FormatarNumeroSQL(THIS.this_nLocks,     0)>>,
                    <<FormatarNumeroSQL(THIS.this_nBloqueios, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nObrigs,    0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCodobs,    0)>>,
                    <<IIF(EMPTY(THIS.this_dDtInis), "NULL", FormatarDataSQL(THIS.this_dDtInis))>>,
                    <<IIF(EMPTY(THIS.this_dDtFins), "NULL", FormatarDataSQL(THIS.this_dDtFins))>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdems,    0)>>,
                    <<EscaparSQL(THIS.this_cRelacs)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipoops,   0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpprocs,   0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir caracteristica de conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CRCBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCrRac
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCrRac
                SET descrs    = <<EscaparSQL(THIS.this_cDescrs)>>,
                    grupos    = <<EscaparSQL(THIS.this_cGrupos)>>,
                    autos     = <<FormatarNumeroSQL(THIS.this_nAutos,     0)>>,
                    locks     = <<FormatarNumeroSQL(THIS.this_nLocks,     0)>>,
                    bloqueios = <<FormatarNumeroSQL(THIS.this_nBloqueios, 0)>>,
                    obrigs    = <<FormatarNumeroSQL(THIS.this_nObrigs,    0)>>,
                    codobs    = <<FormatarNumeroSQL(THIS.this_nCodobs,    0)>>,
                    dtinis    = <<IIF(EMPTY(THIS.this_dDtInis), "NULL", FormatarDataSQL(THIS.this_dDtInis))>>,
                    dtfins    = <<IIF(EMPTY(THIS.this_dDtFins), "NULL", FormatarDataSQL(THIS.this_dDtFins))>>,
                    ordems    = <<FormatarNumeroSQL(THIS.this_nOrdems,    0)>>,
                    relacs    = <<EscaparSQL(THIS.this_cRelacs)>>,
                    tipoops   = <<FormatarNumeroSQL(THIS.this_nTipoops,   0)>>,
                    tpprocs   = <<FormatarNumeroSQL(THIS.this_nTpprocs,   0)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar caracteristica de conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CRCBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCrRac
    * Verifica uso em SigClCrc antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.

        TRY
            *-- Verificar se a caracteristica esta sendo utilizada em SigClCrc
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigClCrc" + ;
                " WHERE Caracteris = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCrc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCrc")
                SELECT cursor_4c_ChkCrc
                loc_nUso = cursor_4c_ChkCrc.qtd
                USE IN cursor_4c_ChkCrc
                IF loc_nUso > 0
                    MsgAviso("Caracter" + CHR(237) + "stica Sendo Utilizada!!!")
                    loc_lSucesso = .F.
                ELSE
                    loc_cSQL = "DELETE FROM SigCrRac WHERE codigos = " + ;
                        EscaparSQL(THIS.this_cCodigos)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir caracteristica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ELSE
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CRCBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros para o grid da Page1
    * Grid original: Grupos(80), Codigos(150), Descrs(290)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (grupos C(10), codigos C(20), descrs C(40))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT grupos, codigos, descrs FROM SigCrRac"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar caracteristicas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar caracteristicas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CRCBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, grupos, autos, locks, bloqueios, obrigs," + ;
                " codobs, dtinis, dtfins, ordems, relacs, tipoops, tpprocs" + ;
                " FROM SigCrRac WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Caracteristica n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar caracteristica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CRCBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoGrupo - Busca descricao de grupo em SigCdGcr pelo codigo
    * Substitui fAcessoContab(Usuar, 'C', ...) do legado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDescricaoGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        TRY
            IF !EMPTY(par_cCodigo)
                loc_cSQL = "SELECT descrs FROM SigCdGcr" + ;
                    " WHERE codigos = " + EscaparSQL(par_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrp")
                IF loc_nResultado >= 0 AND USED("cursor_4c_BuscaGrp")
                    IF !EOF("cursor_4c_BuscaGrp")
                        SELECT cursor_4c_BuscaGrp
                        loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrp.descrs)
                    ENDIF
                    USE IN cursor_4c_BuscaGrp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar grupo:" + CHR(13) + loException.Message, "CRCBO.BuscarDescricaoGrupo")
        ENDTRY

        RETURN loc_cDescricao
    ENDPROC

ENDDEFINE

