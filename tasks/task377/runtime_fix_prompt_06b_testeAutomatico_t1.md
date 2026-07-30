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
[2026-07-29 18:38:35] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-29 18:38:35] [INFO] Config FPW: (nao fornecido)
[2026-07-29 18:38:35] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 18:38:35] [INFO] Timeout: 300 segundos
[2026-07-29 18:38:35] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jnfkv5g5.prg
[2026-07-29 18:38:35] [INFO] Conteudo do wrapper:
[2026-07-29 18:38:35] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCNQ', 'C:\4c\tasks\task377', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCNQ', 'C:\4c\tasks\task377', 'CRUD'
QUIT

[2026-07-29 18:38:35] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jnfkv5g5.prg
[2026-07-29 18:38:35] [INFO] VFP output esperado em: C:\4c\tasks\task377\vfp_output.txt
[2026-07-29 18:38:35] [INFO] Executando Visual FoxPro 9...
[2026-07-29 18:38:35] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jnfkv5g5.prg
[2026-07-29 18:38:35] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jnfkv5g5.prg
[2026-07-29 18:38:35] [INFO] Timeout configurado: 300 segundos
[2026-07-29 18:39:16] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-29 18:39:16] [INFO] VFP9 finalizado em 41.2128267 segundos
[2026-07-29 18:39:16] [INFO] Exit Code: 
[2026-07-29 18:39:16] [INFO] 
[2026-07-29 18:39:16] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-29 18:39:16] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jnfkv5g5.prg
[2026-07-29 18:39:16] [INFO] 
[2026-07-29 18:39:16] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-29 18:39:16] [INFO] * Auto-generated wrapper for parameters
[2026-07-29 18:39:16] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 18:39:16] [INFO] * Parameters: 'FormCNQ', 'C:\4c\tasks\task377', 'CRUD'
[2026-07-29 18:39:16] [INFO] 
[2026-07-29 18:39:16] [INFO] * Anti-dialog protections for unattended execution
[2026-07-29 18:39:16] [INFO] SET SAFETY OFF
[2026-07-29 18:39:16] [INFO] SET RESOURCE OFF
[2026-07-29 18:39:16] [INFO] SET TALK OFF
[2026-07-29 18:39:16] [INFO] SET NOTIFY OFF
[2026-07-29 18:39:16] [INFO] SYS(2335, 0)
[2026-07-29 18:39:16] [INFO] 
[2026-07-29 18:39:16] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCNQ', 'C:\4c\tasks\task377', 'CRUD'
[2026-07-29 18:39:16] [INFO] QUIT
[2026-07-29 18:39:16] [INFO] 
[2026-07-29 18:39:16] [INFO] === Fim do Wrapper.prg ===
[2026-07-29 18:39:16] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormCNQ",
  "timestamp": "20260729183916",
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCODTAM) | KeyPress handlers: 2 (CODTAMKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCNQ.prg):
*==============================================================================
* FormCNQ.prg - Formulario de Cadastro de Conquilhas
* Tabela: SigCdCnq | PK: conquilhas+codtams (chave composta de negocio)
* Legado: SIGCDCNQ.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormCNQ AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 600
    Width        = 1000
    Caption      = "Cadastro de Conquilhas"
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
    this_cModoAtual      = "LISTA"
    this_cPkSelecionado  = ""
    this_cFiltroBusca    = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial (chamado pelo FormBase.Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("CNQBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar Business Object CNQBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                ENDIF

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormCNQ:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame principal com 2 paginas
    * Legado: Pagina Width=1003, Top=-29 (oculta abas do framework)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 629
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e Grid
    * Compensacao PageFrame +29 aplicada em todos os controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (cntSombra original: Top=2 -> 31 com compensacao)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1020
            .Height      = 80
            .BackStyle   = 0
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
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
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
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_op original: Top=-1 -> 29, Left=338 -> canonical 542)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 400
            .Height      = 85
            .BackStyle   = 0
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

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
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

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
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

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
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

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
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

        *-- Container saida canonico (CLAUDE.md regra #10: Left=917, Width=90)
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
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
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

        *-- Grid grd_4c_Lista - Legado: Grade (conquilhas/codtams/valors)
        *-- RecordSource e ControlSource configurados em CarregarLista() apos Buscar()
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid                    = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top                = 117
        loc_oGrid.Left               = 2
        loc_oGrid.Width              = 910
        loc_oGrid.Height             = 477
        loc_oGrid.ColumnCount        = 3
        loc_oGrid.GridLines          = 3
        loc_oGrid.GridLineColor      = RGB(238, 238, 238)
        loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
        loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle     = 2
        loc_oGrid.DeleteMark         = .F.
        loc_oGrid.RecordMark         = .F.
        loc_oGrid.RowHeight          = 16
        loc_oGrid.ScrollBars         = 2
        loc_oGrid.FontName           = "Verdana"
        loc_oGrid.FontSize           = 8
        loc_oGrid.ForeColor          = RGB(90, 90, 90)
        loc_oGrid.BackColor          = RGB(255, 255, 255)
        loc_oGrid.Visible            = .T.

        *-- BINDEVENTs (metodos PUBLIC para funcionar com BINDEVENT)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,  "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: campos Conquilha/CodTam/Valor + botoes
    * Legado: Get_conquilha(top=147,left=402,w=115), Get_codtam(top=174,left=402,w=59)
    *         Get_valor(top=202,left=402,w=59) | Compensacao PageFrame +29 aplicada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Label Conquilha (Say1: top=150+29=179, left=343)
        loc_oPagina.AddObject("lbl_4c_Conquilha", "Label")
        WITH loc_oPagina.lbl_4c_Conquilha
            .Caption   = "Conquilha :"
            .Top       = 179
            .Left      = 343
            .Width     = 57
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Conquilha (Get_conquilha: top=147+29=176, left=402, width=115)
        loc_oPagina.AddObject("txt_4c_Conquilha", "TextBox")
        WITH loc_oPagina.txt_4c_Conquilha
            .Value        = ""
            .Top          = 176
            .Left         = 402
            .Width        = 115
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .MaxLength    = 30
            .BackColor    = RGB(255, 255, 255)
            .ForeColor    = RGB(90, 90, 90)
            .Enabled      = .T.
            .Visible      = .T.
        ENDWITH

        *-- Label Codigo Tamanho/Aro (Say2: top=177+29=206, left=282)
        loc_oPagina.AddObject("lbl_4c_CodTam", "Label")
        WITH loc_oPagina.lbl_4c_CodTam
            .Caption   = "C" + CHR(243) + "digo Tamanho (Aro) :"
            .Top       = 206
            .Left      = 282
            .Width     = 118
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox CodTam (Get_codtam: top=174+29=203, left=402, width=59)
        *-- Lookup: fwBuscaExt em SigCdTam (cods/descs) - implementado em ValidarCodTam
        loc_oPagina.AddObject("txt_4c_CodTam", "TextBox")
        WITH loc_oPagina.txt_4c_CodTam
            .Value        = ""
            .Top          = 203
            .Left         = 402
            .Width        = 59
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .MaxLength    = 10
            .BackColor    = RGB(255, 255, 255)
            .ForeColor    = RGB(90, 90, 90)
            .Enabled      = .T.
            .Visible      = .T.
        ENDWITH

        *-- Label Valor (Say8: top=205+29=234, left=366)
        loc_oPagina.AddObject("lbl_4c_Valor", "Label")
        WITH loc_oPagina.lbl_4c_Valor
            .Caption   = "Valor :"
            .Top       = 234
            .Left      = 366
            .Width     = 34
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Valor (Get_valor: top=202+29=231, left=402, width=59)
        loc_oPagina.AddObject("txt_4c_Valor", "TextBox")
        WITH loc_oPagina.txt_4c_Valor
            .Value        = 0
            .Top          = 231
            .Left         = 402
            .Width        = 59
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .InputMask    = "999999.99"
            .Alignment    = 1
            .BackColor    = RGB(255, 255, 255)
            .ForeColor    = RGB(90, 90, 90)
            .Enabled      = .T.
            .Visible      = .T.
        ENDWITH

        *-- Container botoes de acao (Grupo_Salva original: Top=4 -> 33, Left=842)
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
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
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

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
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

        *-- BINDEVENTs campos (LostFocus, F4 e DblClick para lookup de Tamanho/Aro)
        BINDEVENT(loc_oPagina.txt_4c_CodTam, "KeyPress", THIS, "ValidarCodTam")
        BINDEVENT(loc_oPagina.txt_4c_CodTam, "KeyPress",  THIS, "CodTamKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_CodTam, "DblClick",  THIS, "CodTamDblClick")

        *-- BINDEVENTs botoes
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega registros no grid da Page1
    * Aplica this_cFiltroBusca como WHERE clause (vazio = todos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroBusca)
                IF USED("cursor_4c_Dados")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- Problema 36/48: RecordSource e ColumnCount FORA de WITH
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 3

                    *-- Problema 32: redefinir Headers APOS RecordSource + ControlSource
                    WITH loc_oGrid
                        .Column1.ControlSource   = "cursor_4c_Dados.conquilhas"
                        .Column1.Width           = 150
                        .Column1.Header1.Caption = "Conquilha"
                        .Column1.Alignment       = 0

                        .Column2.ControlSource   = "cursor_4c_Dados.codtams"
                        .Column2.Width           = 100
                        .Column2.Header1.Caption = "Aro"
                        .Column2.Alignment       = 1

                        .Column3.ControlSource   = "cursor_4c_Dados.valors"
                        .Column3.Width           = 100
                        .Column3.Header1.Caption = "Valor"
                        .Column3.Alignment       = 1
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "FormCNQ.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "FormCNQ.AlternarPagina")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Incluir novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.pgf_4c_Paginas.ActivePage = 2

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Conquilha", 5)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Conquilha.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cPK
        loc_cPK = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            SELECT cursor_4c_Dados
            loc_cPK = ALLTRIM(cursor_4c_Dados.conquilhas) + "|" + ALLTRIM(cursor_4c_Dados.codtams)
        ENDIF

        IF EMPTY(STRTRAN(loc_cPK, "|", ""))
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPK)
            THIS.BOParaForm()
            THIS.this_cPkSelecionado = loc_cPK
            THIS.this_cModoAtual     = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cPK
        loc_cPK = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            SELECT cursor_4c_Dados
            loc_cPK = ALLTRIM(cursor_4c_Dados.conquilhas) + "|" + ALLTRIM(cursor_4c_Dados.codtams)
        ENDIF

        IF EMPTY(STRTRAN(loc_cPK, "|", ""))
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPK)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cPkSelecionado = loc_cPK
            THIS.this_cModoAtual     = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cPK, loc_lConfirma
        loc_cPK = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            SELECT cursor_4c_Dados
            loc_cPK = ALLTRIM(cursor_4c_Dados.conquilhas) + "|" + ALLTRIM(cursor_4c_Dados.codtams)
        ENDIF

        IF EMPTY(STRTRAN(loc_cPK, "|", ""))
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
                                     "Confirmar Exclus" + CHR(227) + "o")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPK)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                THIS.this_cFiltroBusca = ""
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Buscar/filtrar registros por conquilha
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cConquilha, loc_cFiltro
        loc_cConquilha = INPUTBOX("Informe a conquilha para buscar (vazio = todos):", ;
                                   "Buscar Conquilha", "")

        IF EMPTY(ALLTRIM(loc_cConquilha))
            loc_cFiltro = ""
        ELSE
            loc_cFiltro = "conquilhas LIKE " + EscaparSQL("%" + ALLTRIM(loc_cConquilha) + "%")
        ENDIF

        THIS.this_cFiltroBusca = loc_cFiltro
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salvar alteracoes (chamado por cmd_4c_Confirmar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        *-- Validar campos obrigatorios ANTES do TRY (RETURN fora do TRY - regra #1)
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Conquilha", 5)
            IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Conquilha.Value))
                MsgAviso("Obrigat" + CHR(243) + "rio informar a Conquilha.")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Conquilha.SetFocus()
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!")
                THIS.this_cModoAtual   = "LISTA"
                THIS.this_cFiltroBusca = ""
                THIS.AlternarPagina(1)
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, "FormCNQ.BtnSalvarClick")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar e voltar para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do Form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Conquilha", 5)
            THIS.this_oBusinessObject.this_cConquilha = ALLTRIM(loc_oPg2.txt_4c_Conquilha.Value)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
            THIS.this_oBusinessObject.this_cCodTam = ALLTRIM(loc_oPg2.txt_4c_CodTam.Value)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Valor", 5)
            THIS.this_oBusinessObject.this_nValor = loc_oPg2.txt_4c_Valor.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do BO para o Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Conquilha", 5)
            loc_oPg2.txt_4c_Conquilha.Value = THIS.this_oBusinessObject.this_cConquilha
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
            loc_oPg2.txt_4c_CodTam.Value = THIS.this_oBusinessObject.this_cCodTam
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Valor", 5)
            loc_oPg2.txt_4c_Valor.Value = THIS.this_oBusinessObject.this_nValor
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos do formulario (Page2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Conquilha", 5)
            loc_oPg2.txt_4c_Conquilha.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
            loc_oPg2.txt_4c_CodTam.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Valor", 5)
            loc_oPg2.txt_4c_Valor.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de edicao (Page2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Conquilha e CodTam: editaveis apenas no INCLUIR (chave de negocio nao muda)
        IF PEMSTATUS(loc_oPg2, "txt_4c_Conquilha", 5)
            loc_oPg2.txt_4c_Conquilha.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
            loc_oPg2.txt_4c_CodTam.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Valor", 5)
            loc_oPg2.txt_4c_Valor.Enabled = par_lHabilitar
        ENDIF

        *-- Botao Confirmar: habilitado apenas em INCLUIR/ALTERAR
        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD conforme o modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_lNaLista
        loc_oPg1     = THIS.pgf_4c_Paginas.Page1
        loc_lNaLista = (THIS.this_cModoAtual = "LISTA")

        IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lNaLista
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lNaLista
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lNaLista
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lNaLista
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lNaLista
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Obrigatorio: percorre Pages de PageFrames E Controls de Containers
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
    * FormatarGridLista - Aplica formatacao visual padrao no grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, "FormCNQ.FormatarGridLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodTam - LostFocus: aciona lookup apenas se valor nao vazio
    * Legado: Get_codtam.Valid usava fwBuscaExt em SigCdTam (cods/descs)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodTam(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cCodTam
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cCodTam = ""

        IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
            loc_cCodTam = ALLTRIM(loc_oPg2.txt_4c_CodTam.Value)
        ENDIF

        IF !EMPTY(loc_cCodTam)
            THIS.AbrirLookupCodTam()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CodTamKeyPress - Handler de KeyPress: abre lookup ao pressionar F4 (28)
    *--------------------------------------------------------------------------
    PROCEDURE CodTamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupCodTam()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CodTamDblClick - Handler de DblClick: abre lookup de Tamanho/Aro
    *--------------------------------------------------------------------------
    PROCEDURE CodTamDblClick()
        THIS.AbrirLookupCodTam()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCodTam - Lookup em SigCdTam (cods/descs) via FormBuscaAuxiliar
    * Campo vazio: exibe lista completa. Nao-vazio: tenta exato primeiro.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCodTam()
        LOCAL loc_oPg2, loc_cCodTam, loc_oBusca
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cCodTam = ""

        IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
            IF !loc_oPg2.txt_4c_CodTam.Enabled
                RETURN
            ENDIF
            loc_cCodTam = ALLTRIM(loc_oPg2.txt_4c_CodTam.Value)
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTam", "cursor_4c_BuscaTam", "cods", loc_cCodTam, ;
                "Selecionar Tamanho (Aro)")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    *-- Registro exato encontrado e selecionado automaticamente
                    IF USED("cursor_4c_BuscaTam") AND PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
                        loc_oPg2.txt_4c_CodTam.Value = ALLTRIM(cursor_4c_BuscaTam.cods)
                    ENDIF
                ELSE
                    *-- Nao encontrou exato (ou campo vazio): mostrar grid para selecao
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "d Tam")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
                        IF PEMSTATUS(loc_oPg2, "txt_4c_CodTam", 5)
                            loc_oPg2.txt_4c_CodTam.Value = ALLTRIM(cursor_4c_BuscaTam.cods)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir lookup Tamanho:" + CHR(13) + loException.Message, "FormCNQ.AbrirLookupCodTam")
        ENDTRY

        IF USED("cursor_4c_BuscaTam")
            USE IN cursor_4c_BuscaTam
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao destruir FormCNQ:" + CHR(13) + loException.Message, "FormCNQ.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\CNQBO.prg):
*==============================================================================
* CNQBO.prg - Business Object para Conquilhas (CNQ)
* Tabela: SigCdCnq | PK: conquilhas+codtams (chave composta de negocio)
* Schema: codtams char(4), conquilhas char(10), valors numeric(6,3)
*==============================================================================

DEFINE CLASS CNQBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigCdCnq)
    this_cConquilha = ""    && Conquilhas CHAR(10)     - Conquilha
    this_cCodTam    = ""    && Codtams    CHAR(4)      - Codigo Tamanho (Aro) FK->SigCdTam.cods
    this_nValor     = 0     && Valors     NUMERIC(6,3) - Valor

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCnq"
        THIS.this_cCampoChave = "conquilhas"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cConquilha = TratarNulo(Conquilhas, "C")
                THIS.this_cCodTam    = TratarNulo(Codtams,    "C")
                THIS.this_nValor     = TratarNulo(Valors,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CNQBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica conquilha + codtam duplicados no INSERT
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nRes, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdCnq" + ;
                       " WHERE conquilhas = " + EscaparSQL(THIS.this_cConquilha) + ;
                       " AND codtams = " + EscaparSQL(THIS.this_cCodTam)

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (cursor_4c_Dup.Total > 0)
            ENDIF
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "CNQBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lDuplicado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cConquilha))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Conquilha.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarDuplicidade()
                MsgAviso("Conquilha j" + CHR(225) + " cadastrada para este tamanho (Aro).")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCnq
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCnq (conquilhas, codtams, valors)
                VALUES (
                    <<EscaparSQL(THIS.this_cConquilha)>>,
                    <<EscaparSQL(THIS.this_cCodTam)>>,
                    <<FormatarNumeroSQL(THIS.this_nValor, 3)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CNQBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCnq
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCnq
                SET valors = <<FormatarNumeroSQL(THIS.this_nValor, 3)>>
                WHERE conquilhas = <<EscaparSQL(THIS.this_cConquilha)>>
                AND codtams = <<EscaparSQL(THIS.this_cCodTam)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CNQBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCnq
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigCdCnq
                WHERE conquilhas = <<EscaparSQL(THIS.this_cConquilha)>>
                AND codtams = <<EscaparSQL(THIS.this_cCodTam)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CNQBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com conquilhas, codtams, valors
    * Ordenado por conquilhas (ordem original do legado)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (conquilhas C(10), codtams C(4), valors N(6,3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT conquilhas, codtams, valors FROM SigCdCnq"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY conquilhas"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar conquilhas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar conquilhas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CNQBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave composta "conquilhas|codtams"
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cChaveComposta)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConquilha, loc_cCodTam, loc_nSep
        loc_lSucesso = .F.

        TRY
            loc_nSep      = AT("|", par_cChaveComposta)
            loc_cConquilha = ALLTRIM(LEFT(par_cChaveComposta, loc_nSep - 1))
            loc_cCodTam    = ALLTRIM(SUBSTR(par_cChaveComposta, loc_nSep + 1))

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT conquilhas, codtams, valors
                FROM SigCdCnq
                WHERE conquilhas = <<EscaparSQL(loc_cConquilha)>>
                AND codtams = <<EscaparSQL(loc_cCodTam)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Conquilha n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CNQBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (para auditoria)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cConquilha) + "|" + ALLTRIM(THIS.this_cCodTam)
    ENDFUNC

ENDDEFINE

