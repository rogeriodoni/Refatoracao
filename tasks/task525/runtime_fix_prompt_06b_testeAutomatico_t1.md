# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 574

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-09-04 17:26:12] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-04 17:26:12] [INFO] Config FPW: (nao fornecido)
[2026-09-04 17:26:12] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-04 17:26:12] [INFO] Timeout: 300 segundos
[2026-09-04 17:26:12] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_u2uyqwkb.prg
[2026-09-04 17:26:12] [INFO] Conteudo do wrapper:
[2026-09-04 17:26:12] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSRV', 'C:\4c\tasks\task525', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSRV', 'C:\4c\tasks\task525', 'CRUD'
QUIT

[2026-09-04 17:26:12] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_u2uyqwkb.prg
[2026-09-04 17:26:12] [INFO] VFP output esperado em: C:\4c\tasks\task525\vfp_output.txt
[2026-09-04 17:26:12] [INFO] Executando Visual FoxPro 9...
[2026-09-04 17:26:12] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_u2uyqwkb.prg
[2026-09-04 17:26:12] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_u2uyqwkb.prg
[2026-09-04 17:26:12] [INFO] Timeout configurado: 300 segundos
[2026-09-04 17:27:53] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-04 17:27:53] [INFO] VFP9 finalizado em 100.3722808 segundos
[2026-09-04 17:27:53] [INFO] Exit Code: 
[2026-09-04 17:27:53] [INFO] 
[2026-09-04 17:27:53] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-04 17:27:53] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_u2uyqwkb.prg
[2026-09-04 17:27:53] [INFO] 
[2026-09-04 17:27:53] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-04 17:27:53] [INFO] * Auto-generated wrapper for parameters
[2026-09-04 17:27:53] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-04 17:27:53] [INFO] * Parameters: 'FormSRV', 'C:\4c\tasks\task525', 'CRUD'
[2026-09-04 17:27:53] [INFO] 
[2026-09-04 17:27:53] [INFO] * Anti-dialog protections for unattended execution
[2026-09-04 17:27:53] [INFO] SET SAFETY OFF
[2026-09-04 17:27:53] [INFO] SET RESOURCE OFF
[2026-09-04 17:27:53] [INFO] SET TALK OFF
[2026-09-04 17:27:53] [INFO] SET NOTIFY OFF
[2026-09-04 17:27:53] [INFO] SYS(2335, 0)
[2026-09-04 17:27:53] [INFO] 
[2026-09-04 17:27:53] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSRV', 'C:\4c\tasks\task525', 'CRUD'
[2026-09-04 17:27:53] [INFO] QUIT
[2026-09-04 17:27:53] [INFO] 
[2026-09-04 17:27:53] [INFO] === Fim do Wrapper.prg ===
[2026-09-04 17:27:53] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSRV",
  "timestamp": "20260904172753",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": true,
      "erro": "",
      "detalhes": "0 registros em cursor_4c_Dados"
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
      "detalhes": "Linha: 574"
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
      "detalhes": "AbrirLookup: 21 (ABRIRLOOKUPCANONICO, ABRIRLOOKUPCODOCORCOFINS, ABRIRLOOKUPCODOCORCSLL, ABRIRLOOKUPCODOCORINSS, ABRIRLOOKUPCODOCORIRRF, ABRIRLOOKUPCODOCORISS, ABRIRLOOKUPCODOCORPIS, ABRIRLOOKUPCONTACOFINS, ABRIRLOOKUPCONTACSLL, ABRIRLOOKUPCONTAIMPOSTOS, ABRIRLOOKUPCONTAINSS, ABRIRLOOKUPCONTAIRRF, ABRIRLOOKUPCONTAISS, ABRIRLOOKUPCONTAPIS, ABRIRLOOKUPGRUPOCOFINS, ABRIRLOOKUPGRUPOCSLL, ABRIRLOOKUPGRUPOIMPOSTOS, ABRIRLOOKUPGRUPOINSS, ABRIRLOOKUPGRUPOIRRF, ABRIRLOOKUPGRUPOISS, ABRIRLOOKUPGRUPOPIS) | KeyPress handlers: 23 (CODOCORCOFINSKEYPRESS, CODOCORCSLLKEYPRESS, CODOCORINSSKEYPRESS, CODOCORIRRFKEYPRESS, CODOCORISSKEYPRESS, CODOCORPISKEYPRESS, CONTACOFINSKEYPRESS, CONTACSLLKEYPRESS, CONTAIMPOSTOSKEYPRESS, CONTAINSSKEYPRESS, CONTAIRRFKEYPRESS, CONTAISSKEYPRESS, CONTAPISKEYPRESS, GRUPOCOFINSKEYPRESS, GRUPOCSLLKEYPRESS, GRUPOIMPOSTOSKEYPRESS, GRUPOINSSKEYPRESS, GRUPOIRRFKEYPRESS, GRUPOISSKEYPRESS, GRUPOPISKEYPRESS, KEYPRESS, PRODUTOCODIGOKEYPRESS, PRODUTODESCRICAOKEYPRESS)"
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
    "passou": 8,
    "falhou": 1,
    "percentual": 89
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSRV.prg):
*==============================================================================
* FormSRV.prg - Formulario de Cadastro de Servicos (Saidas/Entradas)
* Migrado de: SIGCDSRV.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormSRV AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width canonicos do framework)
    Height      = 600
    Width       = 1000
    Caption     = "Servi" + CHR(231) + "os de Sa" + CHR(237) + "das"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual       = "LISTA"

    *-- Contexto Saidas/Entradas (legado: SIGCDSRV.Init(lcTipo) / ThisForm.pcTipo)
    *-- "S" = Servicos de Saidas (default) / "E" = Servicos de Entradas
    *-- Alterar ANTES de Show() para abrir o form no contexto de Entradas
    this_cTipoServico = "S"

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SRVBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar SRVBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSRV.InicializarForm")
            ELSE
                *-- Propaga o contexto Saidas/Entradas para o BO (filtro cTipos)
                THIS.this_oBusinessObject.this_cTipo = THIS.this_cTipoServico

                *-- Caption dinamico conforme o tipo de servico (legado: ThisForm.Caption)
                IF THIS.this_cTipoServico = "E"
                    THIS.Caption = "Servi" + CHR(231) + "os de Entradas"
                ELSE
                    THIS.Caption = "Servi" + CHR(231) + "os de Sa" + CHR(237) + "das"
                ENDIF

                THIS.ConfigurarPageFrame()

                *-- Propaga o Caption dinamico para os labels do cabecalho (Page1)
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormSRV:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSRV.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD, grid lista
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oCab, loc_oBotoes, loc_oSaida
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Compensacao PageFrame +29: Top=31
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

        *-- Container Botoes CRUD (Grupo_op no legado: Left=313, Top=-1, Width=425, Height=85)
        *-- Canonico: Left=542, Top=29 (-1+29 compensacao), Width=390, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPagina.cnt_4c_Botoes
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

        *-- Container Encerrar (canonico CLAUDE.md #10: Left=917, Width=90)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPagina.cnt_4c_Saida
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

        *-- Grid lista: codservs (Codigo) + descservs (Descricao)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 2

        WITH loc_oPagina.grd_4c_Lista
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
            .Column1.Width           = 100
            .Column2.Width           = 760
            .Column1.ReadOnly        = .T.
            .Column2.ReadOnly        = .T.
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Botoes Confirmar/Cancelar +
    * PageFrame interno pgf_4c_1 com abas Impostos/Vencimentos/Retencao)
    * Aba Impostos completa (Fase 5). Vencimentos/Retencao na Fase 6.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container BotoesAcao (Grupo_Salva legado: Left=819, Top=9, Width=160, Height=85)
        *-- Compensacao PageFrame +29: Top=33 (4+29), Left=842
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor   = RGB(255, 255, 255)
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

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
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

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- PageFrame interno (legado: pgDados - Top=132,Left=29,Width=740,Height=417)
        *-- Compensacao PageFrame externo +29: Top=161
        *-- Abas visiveis (Tabs=.T.) para o usuario navegar Impostos/Vencimentos/Retencao
        loc_oPagina.AddObject("pgf_4c_1", "PageFrame")
        WITH loc_oPagina.pgf_4c_1
            .PageCount = 3
            .Top       = 161
            .Left      = 29
            .Width     = 740
            .Height    = 417
            .Visible   = .T.

            .Page1.Caption   = "Impostos"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page2.Caption   = "Vencimentos"
            .Page2.BackColor = RGB(255, 255, 255)
            .Page3.Caption   = "Reten" + CHR(231) + CHR(227) + "o"
            .Page3.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarAbaImpostos()
        THIS.ConfigurarAbaVencimentos()
        THIS.ConfigurarAbaRetencao()

        *-- Registra BINDEVENTs de lookup (F4 / DblClick) dos campos de
        *-- Grupo/Conta Contabil, Codigos de Ocorrencia e produtos
        THIS.ConfigurarBindingsLookup()

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarAbaImpostos - Aba "Impostos" do PageFrame interno pgf_4c_1
    * (codigo/descricao, aliquotas, valores minimos, base minima, recolhimento
    * mensal, lancamento financeiro, ocorrencias e conta contabil principal)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarAbaImpostos()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1

        *-- Moldura geral da aba
        loc_oAba.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oAba.shp_4c_Shape2
            .Top         = 1
            .Left        = 8
            .Width       = 721
            .Height      = 331
            .BorderColor = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Codigo / Descricao
        loc_oAba.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oAba.lbl_4c_Label3
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 16
            .Left      = 44
            .Width     = 54
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oAba.txt_4c_Codigos
            .Value         = ""
            .Top           = 11
            .Left          = 92
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oAba.txt_4c_Descricao
            .Value         = ""
            .Top           = 11
            .Left          = 173
            .Width         = 324
            .Height        = 23
            .MaxLength     = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Aliquotas (%)
        loc_oAba.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oAba.lbl_4c_Label6
            .Caption   = "Al" + CHR(237) + "quotas"
            .Top       = 36
            .Left      = 20
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oAba.shp_4c_Shape1
            .Top         = 44
            .Left        = 13
            .Width       = 712
            .Height      = 37
            .BorderColor = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oAba.lbl_4c_Label1
            .Caption   = "% ISS :"
            .Top       = 56
            .Left      = 19
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__ISS", "TextBox")
        WITH loc_oAba.txt_4c__ISS
            .Value         = 0
            .Top           = 52
            .Left          = 61
            .Width         = 50
            .Height        = 23
            .Format        = "999.99"
            .InputMask     = "999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oAba.lbl_4c_Label2
            .Caption   = "% PIS :"
            .Top       = 56
            .Left      = 126
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__PIS", "TextBox")
        WITH loc_oAba.txt_4c__PIS
            .Value         = 0
            .Top           = 53
            .Left          = 168
            .Width         = 50
            .Height        = 22
            .Format        = "99.99"
            .InputMask     = "99.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oAba.lbl_4c_Label4
            .Caption   = "% COFINS :"
            .Top       = 57
            .Left      = 234
            .Width     = 76
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__COFINS", "TextBox")
        WITH loc_oAba.txt_4c__COFINS
            .Value         = 0
            .Top           = 53
            .Left          = 303
            .Width         = 50
            .Height        = 22
            .Format        = "99.99"
            .InputMask     = "99.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oAba.lbl_4c_Label5
            .Caption   = "% IRRF :"
            .Top       = 57
            .Left      = 373
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__IRRF", "TextBox")
        WITH loc_oAba.txt_4c__IRRF
            .Value         = 0
            .Top           = 53
            .Left          = 423
            .Width         = 50
            .Height        = 22
            .Format        = "99.99"
            .InputMask     = "99.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oAba.lbl_4c_Label7
            .Caption   = "% INSS :"
            .Top       = 57
            .Left      = 491
            .Width     = 59
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__INSS", "TextBox")
        WITH loc_oAba.txt_4c__INSS
            .Value         = 0
            .Top           = 53
            .Left          = 544
            .Width         = 50
            .Height        = 22
            .Format        = "99.99"
            .InputMask     = "99.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oAba.lbl_4c_Label8
            .Caption   = "% CSLL :"
            .Top       = 57
            .Left      = 609
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__CSLL", "TextBox")
        WITH loc_oAba.txt_4c__CSLL
            .Value         = 0
            .Top           = 53
            .Left          = 661
            .Width         = 50
            .Height        = 22
            .Format        = "99.99"
            .InputMask     = "99.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Valores Minimos a recolher
        loc_oAba.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oAba.lbl_4c_Label25
            .Caption   = "Valores M" + CHR(237) + "nimos " + CHR(224) + " recolher"
            .Top       = 85
            .Left      = 20
            .Width     = 179
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("shp_4c_Shape7", "Shape")
        WITH loc_oAba.shp_4c_Shape7
            .Top         = 93
            .Left        = 13
            .Width       = 712
            .Height      = 37
            .BorderColor = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oAba.lbl_4c_Label10
            .Caption   = "PIS :"
            .Top       = 106
            .Left      = 21
            .Width     = 32
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__VMinPis", "TextBox")
        WITH loc_oAba.txt_4c__VMinPis
            .Value         = 0
            .Top           = 102
            .Left          = 48
            .Width         = 90
            .Height        = 22
            .Format        = "999999999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oAba.lbl_4c_Label11
            .Caption   = "COFINS :"
            .Top       = 106
            .Left      = 161
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__VMinCofins", "TextBox")
        WITH loc_oAba.txt_4c__VMinCofins
            .Value         = 0
            .Top           = 102
            .Left          = 212
            .Width         = 90
            .Height        = 22
            .Format        = "999999999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oAba.lbl_4c_Label12
            .Caption   = "IRRF :"
            .Top       = 106
            .Left      = 314
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__VMinIrrf", "TextBox")
        WITH loc_oAba.txt_4c__VMinIrrf
            .Value         = 0
            .Top           = 102
            .Left          = 348
            .Width         = 90
            .Height        = 22
            .Format        = "999999999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oAba.lbl_4c_Label13
            .Caption   = "INSS :"
            .Top       = 106
            .Left      = 451
            .Width     = 41
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__VMinInss", "TextBox")
        WITH loc_oAba.txt_4c__VMinInss
            .Value         = 0
            .Top           = 102
            .Left          = 487
            .Width         = 90
            .Height        = 22
            .Format        = "999999999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oAba.lbl_4c_Label14
            .Caption   = "CSLL :"
            .Top       = 107
            .Left      = 586
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__VMinCsll", "TextBox")
        WITH loc_oAba.txt_4c__VMinCsll
            .Value         = 0
            .Top           = 102
            .Left          = 621
            .Width         = 90
            .Height        = 22
            .Format        = "999999999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Base de calculo minima
        loc_oAba.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oAba.lbl_4c_Label28
            .Caption   = "Base de c" + CHR(225) + "lculo m" + CHR(237) + "nima"
            .Top       = 138
            .Left      = 20
            .Width     = 155
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oAba.shp_4c_Shape4
            .Top         = 146
            .Left        = 13
            .Width       = 712
            .Height      = 54
            .BorderColor = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oAba.lbl_4c_Label24
            .Caption   = "PIS :"
            .Top       = 158
            .Left      = 21
            .Width     = 32
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__VMinBPis", "TextBox")
        WITH loc_oAba.txt_4c__VMinBPis
            .Value         = 0
            .Top           = 155
            .Left          = 48
            .Width         = 90
            .Height        = 22
            .Format        = "999999999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("chk_4c_Chk_bpisms", "CheckBox")
        WITH loc_oAba.chk_4c_Chk_bpisms
            .Caption   = "Mensal"
            .Top       = 180
            .Left      = 48
            .Width     = 64
            .Height    = 15
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oAba.lbl_4c_Label22
            .Caption   = "COFINS :"
            .Top       = 159
            .Left      = 161
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__VMinBCofins", "TextBox")
        WITH loc_oAba.txt_4c__VMinBCofins
            .Value         = 0
            .Top           = 155
            .Left          = 212
            .Width         = 90
            .Height        = 22
            .Format        = "999999999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("chk_4c_Chk_bcofinms", "CheckBox")
        WITH loc_oAba.chk_4c_Chk_bcofinms
            .Caption   = "Mensal"
            .Top       = 180
            .Left      = 212
            .Width     = 64
            .Height    = 15
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oAba.lbl_4c_Label20
            .Caption   = "IRRF :"
            .Top       = 159
            .Left      = 314
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__VMinBIrrf", "TextBox")
        WITH loc_oAba.txt_4c__VMinBIrrf
            .Value         = 0
            .Top           = 155
            .Left          = 348
            .Width         = 90
            .Height        = 22
            .Format        = "999999999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("chk_4c_Chk_birrfms", "CheckBox")
        WITH loc_oAba.chk_4c_Chk_birrfms
            .Caption   = "Mensal"
            .Top       = 180
            .Left      = 348
            .Width     = 64
            .Height    = 15
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oAba.lbl_4c_Label18
            .Caption   = "INSS :"
            .Top       = 159
            .Left      = 451
            .Width     = 41
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__VMinBInss", "TextBox")
        WITH loc_oAba.txt_4c__VMinBInss
            .Value         = 0
            .Top           = 155
            .Left          = 487
            .Width         = 90
            .Height        = 22
            .Format        = "999999999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("chk_4c_Chk_binssms", "CheckBox")
        WITH loc_oAba.chk_4c_Chk_binssms
            .Caption   = "Mensal"
            .Top       = 180
            .Left      = 487
            .Width     = 64
            .Height    = 15
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oAba.lbl_4c_Label16
            .Caption   = "CSLL :"
            .Top       = 159
            .Left      = 586
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__vMinBCsll", "TextBox")
        WITH loc_oAba.txt_4c__vMinBCsll
            .Value         = 0
            .Top           = 155
            .Left          = 621
            .Width         = 90
            .Height        = 22
            .Format        = "999999999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("chk_4c_Chk_bcsllms", "CheckBox")
        WITH loc_oAba.chk_4c_Chk_bcsllms
            .Caption   = "Mensal"
            .Top       = 180
            .Left      = 621
            .Width     = 64
            .Height    = 15
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Lancamento Financeiro
        loc_oAba.AddObject("lbl_4c_Label26", "Label")
        WITH loc_oAba.lbl_4c_Label26
            .Caption   = "Lan" + CHR(231) + "amento Financeiro"
            .Top       = 201
            .Left      = 20
            .Width     = 154
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oAba.shp_4c_Shape3
            .Top         = 209
            .Left        = 13
            .Width       = 712
            .Height      = 31
            .BorderColor = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oAba.AddObject("chk_4c_Chk_LancFinPis", "CheckBox")
        WITH loc_oAba.chk_4c_Chk_LancFinPis
            .Caption   = "PIS"
            .Top       = 217
            .Left      = 27
            .Width     = 41
            .Height    = 15
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("chk_4c_Ck_LancFinCofins", "CheckBox")
        WITH loc_oAba.chk_4c_Ck_LancFinCofins
            .Caption   = "COFINS"
            .Top       = 217
            .Left      = 138
            .Width     = 67
            .Height    = 15
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("chk_4c_Ck_LancFinIrrf", "CheckBox")
        WITH loc_oAba.chk_4c_Ck_LancFinIrrf
            .Caption   = "IRRF"
            .Top       = 217
            .Left      = 279
            .Width     = 49
            .Height    = 15
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("chk_4c_Ck_LancFinCsll", "CheckBox")
        WITH loc_oAba.chk_4c_Ck_LancFinCsll
            .Caption   = "CSLL"
            .Top       = 217
            .Left      = 526
            .Width     = 49
            .Height    = 15
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("chk_4c_Ck_LancFinInss", "CheckBox")
        WITH loc_oAba.chk_4c_Ck_LancFinInss
            .Caption   = "INSS"
            .Top       = 217
            .Left      = 409
            .Width     = 50
            .Height    = 15
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("chk_4c_Ck_LancFinIss", "CheckBox")
        WITH loc_oAba.chk_4c_Ck_LancFinIss
            .Caption   = "ISS"
            .Top       = 217
            .Left      = 645
            .Width     = 41
            .Height    = 15
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Ocorrencias
        loc_oAba.AddObject("lbl_4c_Label27", "Label")
        WITH loc_oAba.lbl_4c_Label27
            .Caption   = "Ocorr" + CHR(234) + "ncias"
            .Top       = 250
            .Left      = 20
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("shp_4c_Shape8", "Shape")
        WITH loc_oAba.shp_4c_Shape8
            .Top         = 258
            .Left        = 13
            .Width       = 712
            .Height      = 35
            .BorderColor = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__CodOcorPis", "TextBox")
        WITH loc_oAba.txt_4c__CodOcorPis
            .Value         = ""
            .Top           = 265
            .Left          = 43
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oAba.lbl_4c_Label15
            .Caption   = "PIS"
            .Top       = 271
            .Left      = 20
            .Width     = 24
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__CodOcorCofins", "TextBox")
        WITH loc_oAba.txt_4c__CodOcorCofins
            .Value         = ""
            .Top           = 265
            .Left          = 178
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oAba.lbl_4c_Label17
            .Caption   = "COFINS"
            .Top       = 270
            .Left      = 129
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__CodOcorIrrf", "TextBox")
        WITH loc_oAba.txt_4c__CodOcorIrrf
            .Value         = ""
            .Top           = 265
            .Left          = 291
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oAba.lbl_4c_Label19
            .Caption   = "IRRF"
            .Top       = 270
            .Left      = 261
            .Width     = 32
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__CodOcorInss", "TextBox")
        WITH loc_oAba.txt_4c__CodOcorInss
            .Value         = ""
            .Top           = 265
            .Left          = 411
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oAba.lbl_4c_Label21
            .Caption   = "INSS"
            .Top       = 270
            .Left      = 377
            .Width     = 33
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__CodOcorCsll", "TextBox")
        WITH loc_oAba.txt_4c__CodOcorCsll
            .Value         = ""
            .Top           = 265
            .Left          = 529
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label23", "Label")
        WITH loc_oAba.lbl_4c_Label23
            .Caption   = "CSLL"
            .Top       = 270
            .Left      = 496
            .Width     = 32
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__CodOcoriSS", "TextBox")
        WITH loc_oAba.txt_4c__CodOcoriSS
            .Value         = ""
            .Top           = 265
            .Left          = 635
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label31", "Label")
        WITH loc_oAba.lbl_4c_Label31
            .Caption   = "ISS"
            .Top       = 269
            .Left      = 612
            .Width     = 24
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- Conta Contabil principal
        loc_oAba.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oAba.lbl_4c_Label9
            .Caption   = "Cta Cont" + CHR(225) + "bil :"
            .Top       = 306
            .Left      = 44
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oAba.txt_4c_Grupo
            .Value         = ""
            .Top           = 301
            .Left          = 127
            .Width         = 78
            .Height        = 23
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c_Contao", "TextBox")
        WITH loc_oAba.txt_4c_Contao
            .Value         = ""
            .Top           = 301
            .Left          = 206
            .Width         = 78
            .Height        = 23
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Descricao da conta (preenchida via lookup fAcessoContas - somente leitura)
        loc_oAba.AddObject("txt_4c_Dcontao", "TextBox")
        WITH loc_oAba.txt_4c_Dcontao
            .Value         = ""
            .Top           = 301
            .Left          = 285
            .Width         = 290
            .Height        = 23
            .MaxLength     = 60
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oAba)
    ENDPROC

    *===========================================================================
    * ConfigurarAbaVencimentos - Aba "Vencimentos" do PageFrame interno pgf_4c_1
    * (Grupo/Conta Contabil + vencimento por imposto: PIS/COFINS/IRRF/INSS/CSLL/ISS,
    * grid de produtos usados para cupons fiscais/NFe)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarAbaVencimentos()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2

        *-- Molduras gerais da aba
        loc_oAba.AddObject("shp_4c_Shape6", "Shape")
        WITH loc_oAba.shp_4c_Shape6
            .Top         = 13
            .Left        = 8
            .Width       = 719
            .Height      = 154
            .BorderColor = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oAba.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oAba.shp_4c_Shape4
            .Top         = 13
            .Left        = 61
            .Width       = 270
            .Height      = 154
            .BorderColor = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oAba.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oAba.shp_4c_Shape1
            .Top         = 176
            .Left        = 7
            .Width       = 719
            .Height      = 154
            .BorderColor = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label29", "Label")
        WITH loc_oAba.lbl_4c_Label29
            .Caption   = "Vencimentos"
            .Top       = 5
            .Left      = 69
            .Width     = 85
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oAba.lbl_4c_Label28
            .Caption   = "" + CHR(211) + "rg" + CHR(227) + "o Contribuinte"
            .Top       = 5
            .Left      = 335
            .Width     = 125
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- Linha PIS
        loc_oAba.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oAba.lbl_4c_Label16
            .Caption   = "PIS"
            .Top       = 28
            .Left      = 12
            .Width     = 24
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        THIS.CriarOptionVencimento(loc_oAba, "obj_4c_Opt_VencPis", 23)

        loc_oAba.AddObject("txt_4c__grupopis", "TextBox")
        WITH loc_oAba.txt_4c__grupopis
            .Value         = ""
            .Top           = 22
            .Left          = 342
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__contapis", "TextBox")
        WITH loc_oAba.txt_4c__contapis
            .Value         = ""
            .Top           = 22
            .Left          = 421
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__dcontapis", "TextBox")
        WITH loc_oAba.txt_4c__dcontapis
            .Value         = ""
            .Top           = 22
            .Left          = 500
            .Width         = 220
            .Height        = 22
            .MaxLength     = 50
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Linha COFINS
        loc_oAba.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oAba.lbl_4c_Label18
            .Caption   = "COFINS"
            .Top       = 50
            .Left      = 11
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        THIS.CriarOptionVencimento(loc_oAba, "obj_4c_Opt_VencCofins", 45)

        loc_oAba.AddObject("txt_4c__grupocofins", "TextBox")
        WITH loc_oAba.txt_4c__grupocofins
            .Value         = ""
            .Top           = 45
            .Left          = 342
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__contacofins", "TextBox")
        WITH loc_oAba.txt_4c__contacofins
            .Value         = ""
            .Top           = 45
            .Left          = 421
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__dcontacofins", "TextBox")
        WITH loc_oAba.txt_4c__dcontacofins
            .Value         = ""
            .Top           = 45
            .Left          = 500
            .Width         = 220
            .Height        = 22
            .MaxLength     = 50
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Linha IRRF
        loc_oAba.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oAba.lbl_4c_Label20
            .Caption   = "IRRF"
            .Top       = 72
            .Left      = 12
            .Width     = 32
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        THIS.CriarOptionVencimento(loc_oAba, "obj_4c_Opt_VencIrrf", 67)

        loc_oAba.AddObject("txt_4c__grupoirrf", "TextBox")
        WITH loc_oAba.txt_4c__grupoirrf
            .Value         = ""
            .Top           = 68
            .Left          = 342
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__contairrf", "TextBox")
        WITH loc_oAba.txt_4c__contairrf
            .Value         = ""
            .Top           = 68
            .Left          = 421
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__dcontairrf", "TextBox")
        WITH loc_oAba.txt_4c__dcontairrf
            .Value         = ""
            .Top           = 68
            .Left          = 500
            .Width         = 220
            .Height        = 22
            .MaxLength     = 50
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Linha INSS
        loc_oAba.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oAba.lbl_4c_Label22
            .Caption   = "INSS"
            .Top       = 94
            .Left      = 12
            .Width     = 33
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        THIS.CriarOptionVencimento(loc_oAba, "obj_4c_Opt_VencInss", 89)

        loc_oAba.AddObject("txt_4c__grupoinss", "TextBox")
        WITH loc_oAba.txt_4c__grupoinss
            .Value         = ""
            .Top           = 91
            .Left          = 342
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__containss", "TextBox")
        WITH loc_oAba.txt_4c__containss
            .Value         = ""
            .Top           = 91
            .Left          = 421
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__dcontainss", "TextBox")
        WITH loc_oAba.txt_4c__dcontainss
            .Value         = ""
            .Top           = 91
            .Left          = 500
            .Width         = 220
            .Height        = 22
            .MaxLength     = 50
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Linha CSLL
        loc_oAba.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oAba.lbl_4c_Label24
            .Caption   = "CSLL"
            .Top       = 116
            .Left      = 12
            .Width     = 32
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        THIS.CriarOptionVencimento(loc_oAba, "obj_4c_Opt_VencCsll", 111)

        loc_oAba.AddObject("txt_4c__grupocsll", "TextBox")
        WITH loc_oAba.txt_4c__grupocsll
            .Value         = ""
            .Top           = 114
            .Left          = 342
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__contacsll", "TextBox")
        WITH loc_oAba.txt_4c__contacsll
            .Value         = ""
            .Top           = 114
            .Left          = 421
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__dcontacsll", "TextBox")
        WITH loc_oAba.txt_4c__dcontacsll
            .Value         = ""
            .Top           = 114
            .Left          = 500
            .Width         = 220
            .Height        = 22
            .MaxLength     = 50
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Linha ISS
        loc_oAba.AddObject("lbl_4c_Label30", "Label")
        WITH loc_oAba.lbl_4c_Label30
            .Caption   = "ISS"
            .Top       = 138
            .Left      = 12
            .Width     = 24
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        THIS.CriarOptionVencimento(loc_oAba, "obj_4c_Opt_vencIss", 133)

        loc_oAba.AddObject("txt_4c__grupoiss", "TextBox")
        WITH loc_oAba.txt_4c__grupoiss
            .Value         = ""
            .Top           = 137
            .Left          = 342
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__contaiss", "TextBox")
        WITH loc_oAba.txt_4c__contaiss
            .Value         = ""
            .Top           = 137
            .Left          = 421
            .Width         = 78
            .Height        = 22
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__dcontaiss", "TextBox")
        WITH loc_oAba.txt_4c__dcontaiss
            .Value         = ""
            .Top           = 137
            .Left          = 500
            .Width         = 220
            .Height        = 22
            .MaxLength     = 50
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Produtos utilizados para cupons fiscais/NFe
        loc_oAba.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oAba.lbl_4c_Label1
            .Caption   = "Produtos (utilizado para cupons fiscais - NFe)"
            .Top       = 169
            .Left      = 16
            .Width     = 301
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("grd_4c_Dados", "Grid")
        loc_oAba.grd_4c_Dados.RecordSource = ""
        loc_oAba.grd_4c_Dados.ColumnCount  = 2

        WITH loc_oAba.grd_4c_Dados
            .Top                     = 187
            .Left                    = 14
            .Width                   = 430
            .Height                  = 138
            .FontName                = "Tahoma"
            .FontSize                = 8
            .ForeColor               = RGB(90, 90, 90)
            .BackColor               = RGB(255, 255, 255)
            .GridLineColor           = RGB(238, 238, 238)
            .HighlightBackColor      = RGB(255, 255, 255)
            .HighlightForeColor      = RGB(15, 41, 104)
            .HighlightStyle          = 2
            .DeleteMark              = .F.
            .RecordMark              = .F.
            .RowHeight               = 18
            .ScrollBars              = 2
            .GridLines               = 3
            .Visible                 = .T.
            .Column1.Width           = 100
            .Column2.Width           = 320
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        loc_oAba.AddObject("cmd_4c_CmdInserir", "CommandButton")
        WITH loc_oAba.cmd_4c_CmdInserir
            .Caption   = "Inserir"
            .Top       = 234
            .Left      = 448
            .Width     = 64
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("cmd_4c_CmdExcluir", "CommandButton")
        WITH loc_oAba.cmd_4c_CmdExcluir
            .Caption   = "Excluir"
            .Top       = 280
            .Left      = 448
            .Width     = 64
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        BINDEVENT(loc_oAba.cmd_4c_CmdInserir, "Click", THIS, "BtnInserirProdutoClick")
        BINDEVENT(loc_oAba.cmd_4c_CmdExcluir, "Click", THIS, "BtnExcluirProdutoClick")

        THIS.TornarControlesVisiveis(loc_oAba)
    ENDPROC

    *===========================================================================
    * CriarOptionVencimento - Cria OptionGroup padrao (3 opcoes: Titulo/
    * 10 D F Mes/Ult Dia Util Quinz Seg) usado nas 6 linhas de imposto da
    * aba Vencimentos (PIS/COFINS/IRRF/INSS/CSLL/ISS)
    *===========================================================================
    PROTECTED PROCEDURE CriarOptionVencimento(par_oAba, par_cNome, par_nTop)
        par_oAba.AddObject(par_cNome, "OptionGroup")
        WITH par_oAba.&par_cNome
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 1
            .Top         = par_nTop
            .Left        = 66
            .Width       = 261
            .Height      = 24
            .Value       = 1
            .Visible     = .T.
        ENDWITH

        WITH par_oAba.&par_cNome..Buttons(1)
            .Caption   = "T" + CHR(237) + "tulo"
            .Left      = 5
            .Top       = 5
            .Width     = 47
            .Height    = 14
            .AutoSize  = .T.
            .FontName  = "Verdana"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Themes    = .F.
        ENDWITH

        WITH par_oAba.&par_cNome..Buttons(2)
            .Caption   = "10 D F M" + CHR(234) + "s"
            .Left      = 52
            .Top       = 5
            .Width     = 76
            .Height    = 14
            .AutoSize  = .T.
            .FontName  = "Verdana"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Themes    = .F.
        ENDWITH

        WITH par_oAba.&par_cNome..Buttons(3)
            .Caption   = CHR(218) + "lt Dia " + CHR(218) + "til Quinz Seg"
            .Left      = 129
            .Top       = 5
            .Width     = 128
            .Height    = 14
            .AutoSize  = .T.
            .FontName  = "Verdana"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Themes    = .F.
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarAbaRetencao - Aba "Retencao" do PageFrame interno pgf_4c_1
    * (codigos de retencao PIS/COFINS/CSLL + bloco RPA: opcao Sim/Nao,
    * valor maximo de retencao INSS e codigos de receita no DARF)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarAbaRetencao()
        LOCAL loc_oAba, loc_oRPA
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page3

        *-- Bloco "Codigos de retencao" (nivel da propria aba)
        loc_oAba.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oAba.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digos de reten" + CHR(231) + CHR(227) + "o"
            .Top       = 6
            .Left      = 18
            .Width     = 135
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oAba.shp_4c_Shape1
            .Top         = 13
            .Left        = 5
            .Width       = 721
            .Height      = 37
            .BorderColor = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oAba.lbl_4c_Label2
            .Caption   = "PIS :"
            .Top       = 24
            .Left      = 196
            .Width     = 32
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__PIS", "TextBox")
        WITH loc_oAba.txt_4c__PIS
            .Value         = ""
            .Top           = 21
            .Left          = 228
            .Width         = 50
            .Height        = 22
            .MaxLength     = 5
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oAba.lbl_4c_Label4
            .Caption   = "COFINS :"
            .Top       = 24
            .Left      = 286
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__COFINS", "TextBox")
        WITH loc_oAba.txt_4c__COFINS
            .Value         = ""
            .Top           = 21
            .Left          = 344
            .Width         = 50
            .Height        = 22
            .MaxLength     = 5
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oAba.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oAba.lbl_4c_Label8
            .Caption   = "CSLL :"
            .Top       = 24
            .Left      = 399
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oAba.AddObject("txt_4c__CSLL", "TextBox")
        WITH loc_oAba.txt_4c__CSLL
            .Value         = ""
            .Top           = 21
            .Left          = 439
            .Width         = 50
            .Height        = 22
            .MaxLength     = 5
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Bloco RPA (container cnt_4c_RPA)
        loc_oAba.AddObject("cnt_4c_RPA", "Container")
        loc_oRPA = loc_oAba.cnt_4c_RPA
        WITH loc_oRPA
            .Top         = 64
            .Left        = 9
            .Width       = 721
            .Height      = 125
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oRPA.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oRPA.lbl_4c_Label3
            .Caption   = " RPA "
            .Top       = 1
            .Left      = 5
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oRPA.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oRPA.shp_4c_Shape2
            .Top         = 76
            .Left        = 1
            .Width       = 681
            .Height      = 2
            .BorderColor = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oRPA.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oRPA.lbl_4c_Label16
            .Caption   = "Servi" + CHR(231) + "o " + CHR(233) + " um RPA :"
            .Top       = 16
            .Left      = 123
            .Width     = 124
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oRPA.AddObject("obj_4c_Opt_RPA", "OptionGroup")
        WITH loc_oRPA.obj_4c_Opt_RPA
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 12
            .Left        = 249
            .Width       = 122
            .Height      = 24
            .Value       = 2
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        WITH loc_oRPA.obj_4c_Opt_RPA.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 4
            .Width     = 44
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Themes    = .F.
        ENDWITH

        WITH loc_oRPA.obj_4c_Opt_RPA.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 50
            .Top       = 4
            .Width     = 62
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Themes    = .F.
        ENDWITH

        loc_oRPA.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oRPA.lbl_4c_Label5
            .Caption   = "Valor M" + CHR(225) + "ximo p/ Reten" + CHR(231) + CHR(227) + "o do INSS :"
            .Top       = 43
            .Left      = 10
            .Width     = 237
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oRPA.AddObject("txt_4c__MaxRetInss", "TextBox")
        WITH loc_oRPA.txt_4c__MaxRetInss
            .Value         = 0
            .Top           = 40
            .Left          = 248
            .Width         = 90
            .Height        = 22
            .Format        = "999999999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oRPA.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oRPA.lbl_4c_Label6
            .Caption   = "C" + CHR(243) + "digos de Receita no DARF "
            .Top       = 69
            .Left      = 9
            .Width     = 187
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oRPA.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oRPA.lbl_4c_Label7
            .Caption   = "PIS :"
            .Top       = 94
            .Left      = 137
            .Width     = 32
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oRPA.AddObject("txt_4c_CodRecPis", "TextBox")
        WITH loc_oRPA.txt_4c_CodRecPis
            .Value         = ""
            .Top           = 91
            .Left          = 169
            .Width         = 50
            .Height        = 22
            .MaxLength     = 5
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oRPA.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oRPA.lbl_4c_Label9
            .Caption   = "COFINS :"
            .Top       = 94
            .Left      = 227
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oRPA.AddObject("txt_4c_CodRecCof", "TextBox")
        WITH loc_oRPA.txt_4c_CodRecCof
            .Value         = ""
            .Top           = 91
            .Left          = 285
            .Width         = 50
            .Height        = 22
            .MaxLength     = 5
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oRPA.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oRPA.lbl_4c_Label10
            .Caption   = "CSLL :"
            .Top       = 94
            .Left      = 340
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oRPA.AddObject("txt_4c_CodRecCsll", "TextBox")
        WITH loc_oRPA.txt_4c_CodRecCsll
            .Value         = ""
            .Top           = 92
            .Left          = 382
            .Width         = 50
            .Height        = 22
            .MaxLength     = 5
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        loc_oRPA.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oRPA.lbl_4c_Label11
            .Caption   = "IRRF :"
            .Top       = 94
            .Left      = 441
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oRPA.AddObject("txt_4c_CodRecIrrf", "TextBox")
        WITH loc_oRPA.txt_4c_CodRecIrrf
            .Value         = ""
            .Top           = 91
            .Left          = 483
            .Width         = 50
            .Height        = 22
            .MaxLength     = 5
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oAba)
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Deve iterar Pages E Controls para PageFrames
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

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

    *===========================================================================
    * CarregarLista - Carrega servicos do tipo atual (this_cTipoServico) no
    * Grid da Page1. Reconfigura ControlSource + Headers (RecordSource reseta
    * cabecalhos em VFP9)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (cidchaves C(20), codservs C(10), descservs C(40), ctipos C(1))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        loc_oGrid.ColumnCount  = 2
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codservs"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descservs"

                        loc_oGrid.Column1.Width = 100
                        loc_oGrid.Column2.Width = 760

                        loc_oGrid.Column1.ReadOnly = .T.
                        loc_oGrid.Column2.ReadOnly = .T.

                        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Lista (1) e Dados (2)
    *===========================================================================
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
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarBindingsLookup - Registra TODOS os BINDEVENTs de lookup
    * (KeyPress F4 + DblClick) dos campos de Grupo/Conta Contabil, Codigos
    * de Ocorrencia (aba Impostos) e das colunas do grid de Produtos (aba
    * Vencimentos)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarBindingsLookup()
        LOCAL loc_oImp, loc_oVen

        TRY
            loc_oImp = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
            loc_oVen = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2

            *-- Conta Contabil principal (aba Impostos)
            BINDEVENT(loc_oImp.txt_4c_Grupo,  "KeyPress", THIS, "GrupoImpostosKeyPress")
            BINDEVENT(loc_oImp.txt_4c_Grupo,  "DblClick", THIS, "GrupoImpostosDblClick")
            BINDEVENT(loc_oImp.txt_4c_Contao, "KeyPress", THIS, "ContaImpostosKeyPress")
            BINDEVENT(loc_oImp.txt_4c_Contao, "DblClick", THIS, "ContaImpostosDblClick")

            *-- Codigos de Ocorrencia (aba Impostos)
            BINDEVENT(loc_oImp.txt_4c__CodOcorPis,    "KeyPress", THIS, "CodOcorPisKeyPress")
            BINDEVENT(loc_oImp.txt_4c__CodOcorPis,    "DblClick", THIS, "CodOcorPisDblClick")
            BINDEVENT(loc_oImp.txt_4c__CodOcorCofins, "KeyPress", THIS, "CodOcorCofinsKeyPress")
            BINDEVENT(loc_oImp.txt_4c__CodOcorCofins, "DblClick", THIS, "CodOcorCofinsDblClick")
            BINDEVENT(loc_oImp.txt_4c__CodOcorIrrf,   "KeyPress", THIS, "CodOcorIrrfKeyPress")
            BINDEVENT(loc_oImp.txt_4c__CodOcorIrrf,   "DblClick", THIS, "CodOcorIrrfDblClick")
            BINDEVENT(loc_oImp.txt_4c__CodOcorInss,   "KeyPress", THIS, "CodOcorInssKeyPress")
            BINDEVENT(loc_oImp.txt_4c__CodOcorInss,   "DblClick", THIS, "CodOcorInssDblClick")
            BINDEVENT(loc_oImp.txt_4c__CodOcorCsll,   "KeyPress", THIS, "CodOcorCsllKeyPress")
            BINDEVENT(loc_oImp.txt_4c__CodOcorCsll,   "DblClick", THIS, "CodOcorCsllDblClick")
            BINDEVENT(loc_oImp.txt_4c__CodOcoriSS,    "KeyPress", THIS, "CodOcorIssKeyPress")
            BINDEVENT(loc_oImp.txt_4c__CodOcoriSS,    "DblClick", THIS, "CodOcorIssDblClick")

            *-- Grupo/Conta Contabil por imposto (aba Vencimentos)
            BINDEVENT(loc_oVen.txt_4c__grupopis,    "KeyPress", THIS, "GrupoPisKeyPress")
            BINDEVENT(loc_oVen.txt_4c__grupopis,    "DblClick", THIS, "GrupoPisDblClick")
            BINDEVENT(loc_oVen.txt_4c__contapis,    "KeyPress", THIS, "ContaPisKeyPress")
            BINDEVENT(loc_oVen.txt_4c__contapis,    "DblClick", THIS, "ContaPisDblClick")

            BINDEVENT(loc_oVen.txt_4c__grupocofins, "KeyPress", THIS, "GrupoCofinsKeyPress")
            BINDEVENT(loc_oVen.txt_4c__grupocofins, "DblClick", THIS, "GrupoCofinsDblClick")
            BINDEVENT(loc_oVen.txt_4c__contacofins, "KeyPress", THIS, "ContaCofinsKeyPress")
            BINDEVENT(loc_oVen.txt_4c__contacofins, "DblClick", THIS, "ContaCofinsDblClick")

            BINDEVENT(loc_oVen.txt_4c__grupoirrf,   "KeyPress", THIS, "GrupoIrrfKeyPress")
            BINDEVENT(loc_oVen.txt_4c__grupoirrf,   "DblClick", THIS, "GrupoIrrfDblClick")
            BINDEVENT(loc_oVen.txt_4c__contairrf,   "KeyPress", THIS, "ContaIrrfKeyPress")
            BINDEVENT(loc_oVen.txt_4c__contairrf,   "DblClick", THIS, "ContaIrrfDblClick")

            BINDEVENT(loc_oVen.txt_4c__grupoinss,   "KeyPress", THIS, "GrupoInssKeyPress")
            BINDEVENT(loc_oVen.txt_4c__grupoinss,   "DblClick", THIS, "GrupoInssDblClick")
            BINDEVENT(loc_oVen.txt_4c__containss,   "KeyPress", THIS, "ContaInssKeyPress")
            BINDEVENT(loc_oVen.txt_4c__containss,   "DblClick", THIS, "ContaInssDblClick")

            BINDEVENT(loc_oVen.txt_4c__grupocsll,   "KeyPress", THIS, "GrupoCsllKeyPress")
            BINDEVENT(loc_oVen.txt_4c__grupocsll,   "DblClick", THIS, "GrupoCsllDblClick")
            BINDEVENT(loc_oVen.txt_4c__contacsll,   "KeyPress", THIS, "ContaCsllKeyPress")
            BINDEVENT(loc_oVen.txt_4c__contacsll,   "DblClick", THIS, "ContaCsllDblClick")

            BINDEVENT(loc_oVen.txt_4c__grupoiss,    "KeyPress", THIS, "GrupoIssKeyPress")
            BINDEVENT(loc_oVen.txt_4c__grupoiss,    "DblClick", THIS, "GrupoIssDblClick")
            BINDEVENT(loc_oVen.txt_4c__contaiss,    "KeyPress", THIS, "ContaIssKeyPress")
            BINDEVENT(loc_oVen.txt_4c__contaiss,    "DblClick", THIS, "ContaIssDblClick")

            *-- Grid de Produtos (colunas Codigo/Descricao)
            BINDEVENT(loc_oVen.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "ProdutoCodigoKeyPress")
            BINDEVENT(loc_oVen.grd_4c_Dados.Column1.Text1, "DblClick", THIS, "ProdutoCodigoDblClick")
            BINDEVENT(loc_oVen.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "ProdutoDescricaoKeyPress")
            BINDEVENT(loc_oVen.grd_4c_Dados.Column2.Text1, "DblClick", THIS, "ProdutoDescricaoDblClick")
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.ConfigurarBindingsLookup")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirLookupGrupoContabil - Lookup generico de Grupo Contabil (SigCdGcr)
    * Usado por Grupo (Impostos) e Grupo Pis/Cofins/Irrf/Inss/Csll/Iss
    *===========================================================================
    PROTECTED PROCEDURE AbrirLookupGrupoContabil(par_oTxtGrupo)
        LOCAL loc_oBusca, loc_cValorAtual, loc_lMostrouGrid

        loc_cValorAtual = ALLTRIM(par_oTxtGrupo.Value)
        loc_lMostrouGrid = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cValorAtual, ;
                "Grupo Cont" + CHR(225) + "bil")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_lMostrouGrid = .T.
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                    par_oTxtGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                ELSE
                    IF loc_lMostrouGrid
                        par_oTxtGrupo.Value = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.AbrirLookupGrupoContabil")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirLookupContaContabil - Lookup generico de Conta (SigCdCli), filtrado
    * pelo Grupo ja informado (equivalente a fAcessoContas do legado).
    * Preenche tambem a descricao (par_oTxtDConta) com Rclis
    *===========================================================================
    PROTECTED PROCEDURE AbrirLookupContaContabil(par_oTxtConta, par_oTxtDConta, par_cGrupo)
        LOCAL loc_oBusca, loc_cValorAtual, loc_cFiltro, loc_lMostrouGrid

        loc_cValorAtual = ALLTRIM(par_oTxtConta.Value)
        loc_cFiltro = ""
        loc_lMostrouGrid = .F.
        IF !EMPTY(ALLTRIM(par_cGrupo))
            loc_cFiltro = "grupos = " + EscaparSQL(ALLTRIM(par_cGrupo))
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaConta", "Iclis", loc_cValorAtual, ;
                "Conta Cont" + CHR(225) + "bil", .F., .F., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_lMostrouGrid = .T.
                    loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Rclis", "", "Nome")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                    par_oTxtConta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
                    IF VARTYPE(par_oTxtDConta) = "O"
                        par_oTxtDConta.Value = ALLTRIM(TratarNulo(cursor_4c_BuscaConta.Rclis, "C"))
                    ENDIF
                ELSE
                    IF loc_lMostrouGrid
                        par_oTxtConta.Value = ""
                        IF VARTYPE(par_oTxtDConta) = "O"
                            par_oTxtDConta.Value = ""
                        ENDIF
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.AbrirLookupContaContabil")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirLookupOcorrencia - Lookup generico de Codigo de Ocorrencia
    * (SigOpOco), usado pelos 6 campos CodOcor* da aba Impostos
    *===========================================================================
    PROTECTED PROCEDURE AbrirLookupOcorrencia(par_oTxtCodOcor)
        LOCAL loc_oBusca, loc_cValorAtual, loc_lMostrouGrid

        loc_cValorAtual = ALLTRIM(par_oTxtCodOcor.Value)
        loc_lMostrouGrid = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigOpOco", "cursor_4c_BuscaOcor", "Codigos", loc_cValorAtual, ;
                "Ocorr" + CHR(234) + "ncias de T" + CHR(237) + "tulos")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_lMostrouGrid = .T.
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOcor")
                    par_oTxtCodOcor.Value = ALLTRIM(cursor_4c_BuscaOcor.Codigos)
                ELSE
                    IF loc_lMostrouGrid
                        par_oTxtCodOcor.Value = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.AbrirLookupOcorrencia")
        ENDTRY

        IF USED("cursor_4c_BuscaOcor")
            USE IN cursor_4c_BuscaOcor
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirLookupProdutoDoGrid - Lookup de Produto (SigCdPro) para a linha
    * atual do grid de Produtos, preenchendo Codigo (Column1) e Descricao
    * (Column2)
    *===========================================================================
    PROTECTED PROCEDURE AbrirLookupProdutoDoGrid()
        LOCAL loc_oGrid, loc_oBusca, loc_cValorAtual

        IF !USED("cursor_4c_Produtos")
            RETURN
        ENDIF

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2.grd_4c_Dados
        loc_cValorAtual = ALLTRIM(loc_oGrid.Column1.Text1.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProduto", "CPros", loc_cValorAtual, ;
                "Produtos")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
                    SELECT cursor_4c_Produtos
                    REPLACE CPros WITH ALLTRIM(cursor_4c_BuscaProduto.CPros), ;
                            DPros WITH ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.DPros, "C"))
                    loc_oGrid.Refresh()
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.AbrirLookupProdutoDoGrid")
        ENDTRY

        IF USED("cursor_4c_BuscaProduto")
            USE IN cursor_4c_BuscaProduto
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------
    * Grupo/Conta Contabil (aba Impostos)
    *---------------------------------------------------------------------
    PROCEDURE GrupoImpostosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupoImpostos()
        ENDIF
    ENDPROC

    PROCEDURE GrupoImpostosDblClick()
        THIS.AbrirLookupGrupoImpostos()
    ENDPROC

    PROCEDURE AbrirLookupGrupoImpostos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
        THIS.AbrirLookupGrupoContabil(loc_oPg.txt_4c_Grupo)
    ENDPROC

    PROCEDURE ContaImpostosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupContaImpostos()
        ENDIF
    ENDPROC

    PROCEDURE ContaImpostosDblClick()
        THIS.AbrirLookupContaImpostos()
    ENDPROC

    PROCEDURE AbrirLookupContaImpostos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
        THIS.AbrirLookupContaContabil(loc_oPg.txt_4c_Contao, loc_oPg.txt_4c_Dcontao, loc_oPg.txt_4c_Grupo.Value)
    ENDPROC

    *---------------------------------------------------------------------
    * Codigos de Ocorrencia (aba Impostos)
    *---------------------------------------------------------------------
    PROCEDURE CodOcorPisKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupCodOcorPis()
        ENDIF
    ENDPROC

    PROCEDURE CodOcorPisDblClick()
        THIS.AbrirLookupCodOcorPis()
    ENDPROC

    PROCEDURE AbrirLookupCodOcorPis()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
        THIS.AbrirLookupOcorrencia(loc_oPg.txt_4c__CodOcorPis)
    ENDPROC

    PROCEDURE CodOcorCofinsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupCodOcorCofins()
        ENDIF
    ENDPROC

    PROCEDURE CodOcorCofinsDblClick()
        THIS.AbrirLookupCodOcorCofins()
    ENDPROC

    PROCEDURE AbrirLookupCodOcorCofins()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
        THIS.AbrirLookupOcorrencia(loc_oPg.txt_4c__CodOcorCofins)
    ENDPROC

    PROCEDURE CodOcorIrrfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupCodOcorIrrf()
        ENDIF
    ENDPROC

    PROCEDURE CodOcorIrrfDblClick()
        THIS.AbrirLookupCodOcorIrrf()
    ENDPROC

    PROCEDURE AbrirLookupCodOcorIrrf()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
        THIS.AbrirLookupOcorrencia(loc_oPg.txt_4c__CodOcorIrrf)
    ENDPROC

    PROCEDURE CodOcorInssKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupCodOcorInss()
        ENDIF
    ENDPROC

    PROCEDURE CodOcorInssDblClick()
        THIS.AbrirLookupCodOcorInss()
    ENDPROC

    PROCEDURE AbrirLookupCodOcorInss()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
        THIS.AbrirLookupOcorrencia(loc_oPg.txt_4c__CodOcorInss)
    ENDPROC

    PROCEDURE CodOcorCsllKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupCodOcorCsll()
        ENDIF
    ENDPROC

    PROCEDURE CodOcorCsllDblClick()
        THIS.AbrirLookupCodOcorCsll()
    ENDPROC

    PROCEDURE AbrirLookupCodOcorCsll()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
        THIS.AbrirLookupOcorrencia(loc_oPg.txt_4c__CodOcorCsll)
    ENDPROC

    PROCEDURE CodOcorIssKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupCodOcorIss()
        ENDIF
    ENDPROC

    PROCEDURE CodOcorIssDblClick()
        THIS.AbrirLookupCodOcorIss()
    ENDPROC

    PROCEDURE AbrirLookupCodOcorIss()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
        THIS.AbrirLookupOcorrencia(loc_oPg.txt_4c__CodOcoriSS)
    ENDPROC

    *---------------------------------------------------------------------
    * Grupo/Conta Contabil por imposto (aba Vencimentos) - PIS
    *---------------------------------------------------------------------
    PROCEDURE GrupoPisKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupoPis()
        ENDIF
    ENDPROC

    PROCEDURE GrupoPisDblClick()
        THIS.AbrirLookupGrupoPis()
    ENDPROC

    PROCEDURE AbrirLookupGrupoPis()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
        THIS.AbrirLookupGrupoContabil(loc_oPg.txt_4c__grupopis)
    ENDPROC

    PROCEDURE ContaPisKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupContaPis()
        ENDIF
    ENDPROC

    PROCEDURE ContaPisDblClick()
        THIS.AbrirLookupContaPis()
    ENDPROC

    PROCEDURE AbrirLookupContaPis()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
        THIS.AbrirLookupContaContabil(loc_oPg.txt_4c__contapis, loc_oPg.txt_4c__dcontapis, loc_oPg.txt_4c__grupopis.Value)
    ENDPROC

    *---------------------------------------------------------------------
    * Grupo/Conta Contabil por imposto (aba Vencimentos) - COFINS
    *---------------------------------------------------------------------
    PROCEDURE GrupoCofinsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupoCofins()
        ENDIF
    ENDPROC

    PROCEDURE GrupoCofinsDblClick()
        THIS.AbrirLookupGrupoCofins()
    ENDPROC

    PROCEDURE AbrirLookupGrupoCofins()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
        THIS.AbrirLookupGrupoContabil(loc_oPg.txt_4c__grupocofins)
    ENDPROC

    PROCEDURE ContaCofinsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupContaCofins()
        ENDIF
    ENDPROC

    PROCEDURE ContaCofinsDblClick()
        THIS.AbrirLookupContaCofins()
    ENDPROC

    PROCEDURE AbrirLookupContaCofins()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
        THIS.AbrirLookupContaContabil(loc_oPg.txt_4c__contacofins, loc_oPg.txt_4c__dcontacofins, loc_oPg.txt_4c__grupocofins.Value)
    ENDPROC

    *---------------------------------------------------------------------
    * Grupo/Conta Contabil por imposto (aba Vencimentos) - IRRF
    *---------------------------------------------------------------------
    PROCEDURE GrupoIrrfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupoIrrf()
        ENDIF
    ENDPROC

    PROCEDURE GrupoIrrfDblClick()
        THIS.AbrirLookupGrupoIrrf()
    ENDPROC

    PROCEDURE AbrirLookupGrupoIrrf()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
        THIS.AbrirLookupGrupoContabil(loc_oPg.txt_4c__grupoirrf)
    ENDPROC

    PROCEDURE ContaIrrfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupContaIrrf()
        ENDIF
    ENDPROC

    PROCEDURE ContaIrrfDblClick()
        THIS.AbrirLookupContaIrrf()
    ENDPROC

    PROCEDURE AbrirLookupContaIrrf()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
        THIS.AbrirLookupContaContabil(loc_oPg.txt_4c__contairrf, loc_oPg.txt_4c__dcontairrf, loc_oPg.txt_4c__grupoirrf.Value)
    ENDPROC

    *---------------------------------------------------------------------
    * Grupo/Conta Contabil por imposto (aba Vencimentos) - INSS
    *---------------------------------------------------------------------
    PROCEDURE GrupoInssKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupoInss()
        ENDIF
    ENDPROC

    PROCEDURE GrupoInssDblClick()
        THIS.AbrirLookupGrupoInss()
    ENDPROC

    PROCEDURE AbrirLookupGrupoInss()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
        THIS.AbrirLookupGrupoContabil(loc_oPg.txt_4c__grupoinss)
    ENDPROC

    PROCEDURE ContaInssKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupContaInss()
        ENDIF
    ENDPROC

    PROCEDURE ContaInssDblClick()
        THIS.AbrirLookupContaInss()
    ENDPROC

    PROCEDURE AbrirLookupContaInss()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
        THIS.AbrirLookupContaContabil(loc_oPg.txt_4c__containss, loc_oPg.txt_4c__dcontainss, loc_oPg.txt_4c__grupoinss.Value)
    ENDPROC

    *---------------------------------------------------------------------
    * Grupo/Conta Contabil por imposto (aba Vencimentos) - CSLL
    *---------------------------------------------------------------------
    PROCEDURE GrupoCsllKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupoCsll()
        ENDIF
    ENDPROC

    PROCEDURE GrupoCsllDblClick()
        THIS.AbrirLookupGrupoCsll()
    ENDPROC

    PROCEDURE AbrirLookupGrupoCsll()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
        THIS.AbrirLookupGrupoContabil(loc_oPg.txt_4c__grupocsll)
    ENDPROC

    PROCEDURE ContaCsllKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupContaCsll()
        ENDIF
    ENDPROC

    PROCEDURE ContaCsllDblClick()
        THIS.AbrirLookupContaCsll()
    ENDPROC

    PROCEDURE AbrirLookupContaCsll()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
        THIS.AbrirLookupContaContabil(loc_oPg.txt_4c__contacsll, loc_oPg.txt_4c__dcontacsll, loc_oPg.txt_4c__grupocsll.Value)
    ENDPROC

    *---------------------------------------------------------------------
    * Grupo/Conta Contabil por imposto (aba Vencimentos) - ISS
    *---------------------------------------------------------------------
    PROCEDURE GrupoIssKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupoIss()
        ENDIF
    ENDPROC

    PROCEDURE GrupoIssDblClick()
        THIS.AbrirLookupGrupoIss()
    ENDPROC

    PROCEDURE AbrirLookupGrupoIss()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
        THIS.AbrirLookupGrupoContabil(loc_oPg.txt_4c__grupoiss)
    ENDPROC

    PROCEDURE ContaIssKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupContaIss()
        ENDIF
    ENDPROC

    PROCEDURE ContaIssDblClick()
        THIS.AbrirLookupContaIss()
    ENDPROC

    PROCEDURE AbrirLookupContaIss()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
        THIS.AbrirLookupContaContabil(loc_oPg.txt_4c__contaiss, loc_oPg.txt_4c__dcontaiss, loc_oPg.txt_4c__grupoiss.Value)
    ENDPROC

    *---------------------------------------------------------------------
    * Grid de Produtos (aba Vencimentos) - colunas Codigo/Descricao
    *---------------------------------------------------------------------
    PROCEDURE ProdutoCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupProdutoDoGrid()
        ENDIF
    ENDPROC

    PROCEDURE ProdutoCodigoDblClick()
        THIS.AbrirLookupProdutoDoGrid()
    ENDPROC

    PROCEDURE ProdutoDescricaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupProdutoDoGrid()
        ENDIF
    ENDPROC

    PROCEDURE ProdutoDescricaoDblClick()
        THIS.AbrirLookupProdutoDoGrid()
    ENDPROC

    *===========================================================================
    * BtnInserirProdutoClick - Adiciona uma linha em branco no grid de
    * Produtos (cursor_4c_Produtos), pronta para receber o codigo via F4
    *===========================================================================
    PROCEDURE BtnInserirProdutoClick()
        LOCAL loc_oGrid

        IF !USED("cursor_4c_Produtos")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Produtos
            IF !EMPTY(ALLTRIM(NVL(CPros, ""))) OR EOF("cursor_4c_Produtos")
                APPEND BLANK IN cursor_4c_Produtos
                REPLACE CidChaves WITH fUniqueIds(), ;
                        CodServs  WITH THIS.this_oBusinessObject.this_cCodigo ;
                        IN cursor_4c_Produtos
            ENDIF

            loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2.grd_4c_Dados
            GO BOTTOM IN cursor_4c_Produtos
            loc_oGrid.Refresh()
            loc_oGrid.SetFocus()
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.BtnInserirProdutoClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirProdutoClick - Remove a linha atual do grid de Produtos
    * (cursor_4c_Produtos)
    *===========================================================================
    PROCEDURE BtnExcluirProdutoClick()
        LOCAL loc_oGrid

        IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Produtos
            DELETE IN cursor_4c_Produtos
            SKIP IN cursor_4c_Produtos
            SKIP -1 IN cursor_4c_Produtos

            loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2.grd_4c_Dados
            loc_oGrid.Refresh()
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.BtnExcluirProdutoClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ObterDescricaoConta - Consulta SigCdCli.Rclis pelo codigo da conta
    * (Iclis). Usado para exibir os campos de descricao (Dcontao/DcontaPis/
    * etc.) ao carregar um registro existente (legado: CursorQuery SigCdCli
    * + Get_Dconta*.Value = crSigCdCli.rClis)
    *===========================================================================
    PROTECTED FUNCTION ObterDescricaoConta(par_cConta)
        LOCAL loc_cDescricao, loc_cSQL, loc_nResultado
        loc_cDescricao = ""

        IF EMPTY(ALLTRIM(NVL(par_cConta, "")))
            RETURN loc_cDescricao
        ENDIF

        TRY
            loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                       EscaparSQL(ALLTRIM(par_cConta))

            IF USED("cursor_4c_DescConta")
                USE IN cursor_4c_DescConta
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescConta")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescConta") > 0
                loc_cDescricao = ALLTRIM(TratarNulo(cursor_4c_DescConta.Rclis, "C"))
            ENDIF
        CATCH TO loException
            loc_cDescricao = ""
        ENDTRY

        IF USED("cursor_4c_DescConta")
            USE IN cursor_4c_DescConta
        ENDIF

        RETURN loc_cDescricao
    ENDFUNC

    *===========================================================================
    * AtualizarGridProdutos - (Re)vincula o Grid de Produtos (aba Vencimentos)
    * ao cursor_4c_Produtos gerenciado pelo SRVBO. Deve ser chamado sempre
    * que o cursor for (re)criado (NovoRegistro/LimparCampos) ou recarregado
    * (BOParaForm), pois RecordSource reseta ControlSource/Headers em VFP9
    *===========================================================================
    PROTECTED PROCEDURE AtualizarGridProdutos()
        LOCAL loc_oGrid

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2.grd_4c_Dados

            IF USED("cursor_4c_Produtos")
                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource = "cursor_4c_Produtos"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Produtos.CPros"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Produtos.DPros"
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.AtualizarGridProdutos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere TODOS os campos do Form (abas Impostos/
    * Vencimentos/Retencao) para as propriedades this_* do SRVBO
    *===========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_oImp, loc_oVen, loc_oRet, loc_oBO, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oImp = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
            loc_oVen = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
            loc_oRet = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page3
            loc_oBO  = THIS.this_oBusinessObject

            *-- Aba Impostos -------------------------------------------------
            loc_oBO.this_cCodigo    = ALLTRIM(loc_oImp.txt_4c_Codigos.Value)
            loc_oBO.this_cDescricao = ALLTRIM(loc_oImp.txt_4c_Descricao.Value)

            loc_oBO.this_nAliquotaPis    = loc_oImp.txt_4c__PIS.Value
            loc_oBO.this_nAliquotaCofins = loc_oImp.txt_4c__COFINS.Value
            loc_oBO.this_nAliquotaIrrf   = loc_oImp.txt_4c__IRRF.Value
            loc_oBO.this_nAliquotaInss   = loc_oImp.txt_4c__INSS.Value
            loc_oBO.this_nAliquotaCsll   = loc_oImp.txt_4c__CSLL.Value
            loc_oBO.this_nAliquotaIss    = loc_oImp.txt_4c__ISS.Value

            loc_oBO.this_nValorMinimoPis    = loc_oImp.txt_4c__VMinPis.Value
            loc_oBO.this_nValorMinimoCofins = loc_oImp.txt_4c__VMinCofins.Value
            loc_oBO.this_nValorMinimoIrrf   = loc_oImp.txt_4c__VMinIrrf.Value
            loc_oBO.this_nValorMinimoInss   = loc_oImp.txt_4c__VMinInss.Value
            loc_oBO.this_nValorMinimoCsll   = loc_oImp.txt_4c__VMinCsll.Value

            loc_oBO.this_nBaseMinimaPis    = loc_oImp.txt_4c__VMinBPis.Value
            loc_oBO.this_nBaseMinimaCofins = loc_oImp.txt_4c__VMinBCofins.Value
            loc_oBO.this_nBaseMinimaIrrf   = loc_oImp.txt_4c__VMinBIrrf.Value
            loc_oBO.this_nBaseMinimaInss   = loc_oImp.txt_4c__VMinBInss.Value
            loc_oBO.this_nBaseMinimaCsll   = loc_oImp.txt_4c__vMinBCsll.Value

            loc_oBO.this_lMensalPis    = loc_oImp.chk_4c_Chk_bpisms.Value
            loc_oBO.this_lMensalCofins = loc_oImp.chk_4c_Chk_bcofinms.Value
            loc_oBO.this_lMensalIrrf   = loc_oImp.chk_4c_Chk_birrfms.Value
            loc_oBO.this_lMensalInss   = loc_oImp.chk_4c_Chk_binssms.Value
            loc_oBO.this_lMensalCsll   = loc_oImp.chk_4c_Chk_bcsllms.Value

            loc_oBO.this_lLancFinPis    = loc_oImp.chk_4c_Chk_LancFinPis.Value
            loc_oBO.this_lLancFinCofins = loc_oImp.chk_4c_Ck_LancFinCofins.Value
            loc_oBO.this_lLancFinIrrf   = loc_oImp.chk_4c_Ck_LancFinIrrf.Value
            loc_oBO.this_lLancFinInss   = loc_oImp.chk_4c_Ck_LancFinInss.Value
            loc_oBO.this_lLancFinCsll   = loc_oImp.chk_4c_Ck_LancFinCsll.Value
            loc_oBO.this_lLancFinIss    = loc_oImp.chk_4c_Ck_LancFinIss.Value

            loc_oBO.this_cCodOcorPis    = ALLTRIM(loc_oImp.txt_4c__CodOcorPis.Value)
            loc_oBO.this_cCodOcorCofins = ALLTRIM(loc_oImp.txt_4c__CodOcorCofins.Value)
            loc_oBO.this_cCodOcorIrrf   = ALLTRIM(loc_oImp.txt_4c__CodOcorIrrf.Value)
            loc_oBO.this_cCodOcorInss   = ALLTRIM(loc_oImp.txt_4c__CodOcorInss.Value)
            loc_oBO.this_cCodOcorCsll   = ALLTRIM(loc_oImp.txt_4c__CodOcorCsll.Value)
            loc_oBO.this_cCodOcorIss    = ALLTRIM(loc_oImp.txt_4c__CodOcoriSS.Value)

            loc_oBO.this_cGrupoContab = ALLTRIM(loc_oImp.txt_4c_Grupo.Value)
            loc_oBO.this_cContaContab = ALLTRIM(loc_oImp.txt_4c_Contao.Value)

            *-- Aba Vencimentos -----------------------------------------------
            loc_oBO.this_cGrupoPis    = ALLTRIM(loc_oVen.txt_4c__grupopis.Value)
            loc_oBO.this_cContaPis    = ALLTRIM(loc_oVen.txt_4c__contapis.Value)
            loc_oBO.this_cGrupoCofins = ALLTRIM(loc_oVen.txt_4c__grupocofins.Value)
            loc_oBO.this_cContaCofins = ALLTRIM(loc_oVen.txt_4c__contacofins.Value)
            loc_oBO.this_cGrupoIrrf   = ALLTRIM(loc_oVen.txt_4c__grupoirrf.Value)
            loc_oBO.this_cContaIrrf   = ALLTRIM(loc_oVen.txt_4c__contairrf.Value)
            loc_oBO.this_cGrupoInss   = ALLTRIM(loc_oVen.txt_4c__grupoinss.Value)
            loc_oBO.this_cContaInss   = ALLTRIM(loc_oVen.txt_4c__containss.Value)
            loc_oBO.this_cGrupoCsll   = ALLTRIM(loc_oVen.txt_4c__grupocsll.Value)
            loc_oBO.this_cContaCsll   = ALLTRIM(loc_oVen.txt_4c__contacsll.Value)
            loc_oBO.this_cGrupoIss    = ALLTRIM(loc_oVen.txt_4c__grupoiss.Value)
            loc_oBO.this_cContaIss    = ALLTRIM(loc_oVen.txt_4c__contaiss.Value)

            loc_oBO.this_nVencimentoPis    = loc_oVen.obj_4c_Opt_VencPis.Value
            loc_oBO.this_nVencimentoCofins = loc_oVen.obj_4c_Opt_VencCofins.Value
            loc_oBO.this_nVencimentoIrrf   = loc_oVen.obj_4c_Opt_VencIrrf.Value
            loc_oBO.this_nVencimentoInss   = loc_oVen.obj_4c_Opt_VencInss.Value
            loc_oBO.this_nVencimentoCsll   = loc_oVen.obj_4c_Opt_VencCsll.Value
            loc_oBO.this_nVencimentoIss    = loc_oVen.obj_4c_Opt_vencIss.Value

            *-- Aba Retencao ---------------------------------------------------
            loc_oBO.this_cCodPis    = ALLTRIM(TRANSFORM(loc_oRet.txt_4c__PIS.Value))
            loc_oBO.this_cCodCofins = ALLTRIM(TRANSFORM(loc_oRet.txt_4c__COFINS.Value))
            loc_oBO.this_cCodCsll   = ALLTRIM(TRANSFORM(loc_oRet.txt_4c__CSLL.Value))

            loc_oBO.this_nRPA                     = loc_oRet.cnt_4c_RPA.obj_4c_Opt_RPA.Value
            loc_oBO.this_nValorMaximoRetencaoInss = loc_oRet.cnt_4c_RPA.txt_4c__MaxRetInss.Value
            loc_oBO.this_cCodRecPis               = ALLTRIM(loc_oRet.cnt_4c_RPA.txt_4c_CodRecPis.Value)
            loc_oBO.this_cCodRecCofins            = ALLTRIM(loc_oRet.cnt_4c_RPA.txt_4c_CodRecCof.Value)
            loc_oBO.this_cCodRecCsll              = ALLTRIM(loc_oRet.cnt_4c_RPA.txt_4c_CodRecCsll.Value)
            loc_oBO.this_cCodRecIrrf              = ALLTRIM(loc_oRet.cnt_4c_RPA.txt_4c_CodRecIrrf.Value)

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * BOParaForm - Transfere TODAS as propriedades this_* do SRVBO para os
    * campos do Form (abas Impostos/Vencimentos/Retencao). Reconsulta as
    * descricoes das contas contabeis (Dcontao/DcontaPis/etc - legado:
    * CursorQuery SigCdCli) e revincula o Grid de Produtos
    *===========================================================================
    PROTECTED FUNCTION BOParaForm()
        LOCAL loc_oImp, loc_oVen, loc_oRet, loc_oBO, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oImp = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
            loc_oVen = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
            loc_oRet = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page3
            loc_oBO  = THIS.this_oBusinessObject

            *-- Aba Impostos -------------------------------------------------
            loc_oImp.txt_4c_Codigos.Value   = loc_oBO.this_cCodigo
            loc_oImp.txt_4c_Descricao.Value = loc_oBO.this_cDescricao

            loc_oImp.txt_4c__ISS.Value    = loc_oBO.this_nAliquotaIss
            loc_oImp.txt_4c__PIS.Value    = loc_oBO.this_nAliquotaPis
            loc_oImp.txt_4c__COFINS.Value = loc_oBO.this_nAliquotaCofins
            loc_oImp.txt_4c__IRRF.Value   = loc_oBO.this_nAliquotaIrrf
            loc_oImp.txt_4c__INSS.Value   = loc_oBO.this_nAliquotaInss
            loc_oImp.txt_4c__CSLL.Value   = loc_oBO.this_nAliquotaCsll

            loc_oImp.txt_4c__VMinPis.Value    = loc_oBO.this_nValorMinimoPis
            loc_oImp.txt_4c__VMinCofins.Value = loc_oBO.this_nValorMinimoCofins
            loc_oImp.txt_4c__VMinIrrf.Value   = loc_oBO.this_nValorMinimoIrrf
            loc_oImp.txt_4c__VMinInss.Value   = loc_oBO.this_nValorMinimoInss
            loc_oImp.txt_4c__VMinCsll.Value   = loc_oBO.this_nValorMinimoCsll

            loc_oImp.txt_4c__VMinBPis.Value    = loc_oBO.this_nBaseMinimaPis
            loc_oImp.txt_4c__VMinBCofins.Value = loc_oBO.this_nBaseMinimaCofins
            loc_oImp.txt_4c__VMinBIrrf.Value   = loc_oBO.this_nBaseMinimaIrrf
            loc_oImp.txt_4c__VMinBInss.Value   = loc_oBO.this_nBaseMinimaInss
            loc_oImp.txt_4c__vMinBCsll.Value   = loc_oBO.this_nBaseMinimaCsll

            loc_oImp.chk_4c_Chk_bpisms.Value    = loc_oBO.this_lMensalPis
            loc_oImp.chk_4c_Chk_bcofinms.Value  = loc_oBO.this_lMensalCofins
            loc_oImp.chk_4c_Chk_birrfms.Value   = loc_oBO.this_lMensalIrrf
            loc_oImp.chk_4c_Chk_binssms.Value   = loc_oBO.this_lMensalInss
            loc_oImp.chk_4c_Chk_bcsllms.Value   = loc_oBO.this_lMensalCsll

            loc_oImp.chk_4c_Chk_LancFinPis.Value    = loc_oBO.this_lLancFinPis
            loc_oImp.chk_4c_Ck_LancFinCofins.Value  = loc_oBO.this_lLancFinCofins
            loc_oImp.chk_4c_Ck_LancFinIrrf.Value    = loc_oBO.this_lLancFinIrrf
            loc_oImp.chk_4c_Ck_LancFinInss.Value    = loc_oBO.this_lLancFinInss
            loc_oImp.chk_4c_Ck_LancFinCsll.Value    = loc_oBO.this_lLancFinCsll
            loc_oImp.chk_4c_Ck_LancFinIss.Value     = loc_oBO.this_lLancFinIss

            loc_oImp.txt_4c__CodOcorPis.Value    = loc_oBO.this_cCodOcorPis
            loc_oImp.txt_4c__CodOcorCofins.Value = loc_oBO.this_cCodOcorCofins
            loc_oImp.txt_4c__CodOcorIrrf.Value   = loc_oBO.this_cCodOcorIrrf
            loc_oImp.txt_4c__CodOcorInss.Value   = loc_oBO.this_cCodOcorInss
            loc_oImp.txt_4c__CodOcorCsll.Value   = loc_oBO.this_cCodOcorCsll
            loc_oImp.txt_4c__CodOcoriSS.Value    = loc_oBO.this_cCodOcorIss

            loc_oImp.txt_4c_Grupo.Value   = loc_oBO.this_cGrupoContab
            loc_oImp.txt_4c_Contao.Value  = loc_oBO.this_cContaContab
            loc_oImp.txt_4c_Dcontao.Value = THIS.ObterDescricaoConta(loc_oBO.this_cContaContab)

            *-- Aba Vencimentos -----------------------------------------------
            loc_oVen.txt_4c__grupopis.Value     = loc_oBO.this_cGrupoPis
            loc_oVen.txt_4c__contapis.Value     = loc_oBO.this_cContaPis
            loc_oVen.txt_4c__dcontapis.Value    = THIS.ObterDescricaoConta(loc_oBO.this_cContaPis)
            loc_oVen.txt_4c__grupocofins.Value  = loc_oBO.this_cGrupoCofins
            loc_oVen.txt_4c__contacofins.Value  = loc_oBO.this_cContaCofins
            loc_oVen.txt_4c__dcontacofins.Value = THIS.ObterDescricaoConta(loc_oBO.this_cContaCofins)
            loc_oVen.txt_4c__grupoirrf.Value    = loc_oBO.this_cGrupoIrrf
            loc_oVen.txt_4c__contairrf.Value    = loc_oBO.this_cContaIrrf
            loc_oVen.txt_4c__dcontairrf.Value   = THIS.ObterDescricaoConta(loc_oBO.this_cContaIrrf)
            loc_oVen.txt_4c__grupoinss.Value    = loc_oBO.this_cGrupoInss
            loc_oVen.txt_4c__containss.Value    = loc_oBO.this_cContaInss
            loc_oVen.txt_4c__dcontainss.Value   = THIS.ObterDescricaoConta(loc_oBO.this_cContaInss)
            loc_oVen.txt_4c__grupocsll.Value    = loc_oBO.this_cGrupoCsll
            loc_oVen.txt_4c__contacsll.Value    = loc_oBO.this_cContaCsll
            loc_oVen.txt_4c__dcontacsll.Value   = THIS.ObterDescricaoConta(loc_oBO.this_cContaCsll)
            loc_oVen.txt_4c__grupoiss.Value     = loc_oBO.this_cGrupoIss
            loc_oVen.txt_4c__contaiss.Value     = loc_oBO.this_cContaIss
            loc_oVen.txt_4c__dcontaiss.Value    = THIS.ObterDescricaoConta(loc_oBO.this_cContaIss)

            loc_oVen.obj_4c_Opt_VencPis.Value    = IIF(INLIST(loc_oBO.this_nVencimentoPis, 1, 2, 3), loc_oBO.this_nVencimentoPis, 1)
            loc_oVen.obj_4c_Opt_VencCofins.Value = IIF(INLIST(loc_oBO.this_nVencimentoCofins, 1, 2, 3), loc_oBO.this_nVencimentoCofins, 1)
            loc_oVen.obj_4c_Opt_VencIrrf.Value   = IIF(INLIST(loc_oBO.this_nVencimentoIrrf, 1, 2, 3), loc_oBO.this_nVencimentoIrrf, 1)
            loc_oVen.obj_4c_Opt_VencInss.Value   = IIF(INLIST(loc_oBO.this_nVencimentoInss, 1, 2, 3), loc_oBO.this_nVencimentoInss, 1)
            loc_oVen.obj_4c_Opt_VencCsll.Value   = IIF(INLIST(loc_oBO.this_nVencimentoCsll, 1, 2, 3), loc_oBO.this_nVencimentoCsll, 1)
            loc_oVen.obj_4c_Opt_vencIss.Value    = IIF(INLIST(loc_oBO.this_nVencimentoIss, 1, 2, 3), loc_oBO.this_nVencimentoIss, 1)

            *-- Aba Retencao ---------------------------------------------------
            loc_oRet.txt_4c__PIS.Value    = loc_oBO.this_cCodPis
            loc_oRet.txt_4c__COFINS.Value = loc_oBO.this_cCodCofins
            loc_oRet.txt_4c__CSLL.Value   = loc_oBO.this_cCodCsll

            loc_oRet.cnt_4c_RPA.obj_4c_Opt_RPA.Value      = IIF(loc_oBO.this_nRPA = 1, 1, 2)
            loc_oRet.cnt_4c_RPA.txt_4c__MaxRetInss.Value  = loc_oBO.this_nValorMaximoRetencaoInss
            loc_oRet.cnt_4c_RPA.txt_4c_CodRecPis.Value    = loc_oBO.this_cCodRecPis
            loc_oRet.cnt_4c_RPA.txt_4c_CodRecCof.Value    = loc_oBO.this_cCodRecCofins
            loc_oRet.cnt_4c_RPA.txt_4c_CodRecCsll.Value   = loc_oBO.this_cCodRecCsll
            loc_oRet.cnt_4c_RPA.txt_4c_CodRecIrrf.Value   = loc_oBO.this_cCodRecIrrf

            THIS.AtualizarGridProdutos()

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.BOParaForm")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * LimparCampos - Reseta TODOS os campos das abas Impostos/Vencimentos/
    * Retencao para os valores default (chamado em BtnIncluirClick/
    * BtnBuscarClick, apos NovoRegistro() ja ter recriado cursor_4c_Produtos)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oImp, loc_oVen, loc_oRet

        TRY
            loc_oImp = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
            loc_oVen = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
            loc_oRet = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page3

            loc_oImp.txt_4c_Codigos.Value   = ""
            loc_oImp.txt_4c_Descricao.Value = ""

            loc_oImp.txt_4c__ISS.Value    = 0
            loc_oImp.txt_4c__PIS.Value    = 0
            loc_oImp.txt_4c__COFINS.Value = 0
            loc_oImp.txt_4c__IRRF.Value   = 0
            loc_oImp.txt_4c__INSS.Value   = 0
            loc_oImp.txt_4c__CSLL.Value   = 0

            loc_oImp.txt_4c__VMinPis.Value    = 0
            loc_oImp.txt_4c__VMinCofins.Value = 0
            loc_oImp.txt_4c__VMinIrrf.Value   = 0
            loc_oImp.txt_4c__VMinInss.Value   = 0
            loc_oImp.txt_4c__VMinCsll.Value   = 0

            loc_oImp.txt_4c__VMinBPis.Value    = 0
            loc_oImp.txt_4c__VMinBCofins.Value = 0
            loc_oImp.txt_4c__VMinBIrrf.Value   = 0
            loc_oImp.txt_4c__VMinBInss.Value   = 0
            loc_oImp.txt_4c__vMinBCsll.Value   = 0

            loc_oImp.chk_4c_Chk_bpisms.Value    = 0
            loc_oImp.chk_4c_Chk_bcofinms.Value  = 0
            loc_oImp.chk_4c_Chk_birrfms.Value   = 0
            loc_oImp.chk_4c_Chk_binssms.Value   = 0
            loc_oImp.chk_4c_Chk_bcsllms.Value   = 0

            loc_oImp.chk_4c_Chk_LancFinPis.Value    = 0
            loc_oImp.chk_4c_Ck_LancFinCofins.Value  = 0
            loc_oImp.chk_4c_Ck_LancFinIrrf.Value    = 0
            loc_oImp.chk_4c_Ck_LancFinInss.Value    = 0
            loc_oImp.chk_4c_Ck_LancFinCsll.Value    = 0
            loc_oImp.chk_4c_Ck_LancFinIss.Value     = 0

            loc_oImp.txt_4c__CodOcorPis.Value    = ""
            loc_oImp.txt_4c__CodOcorCofins.Value = ""
            loc_oImp.txt_4c__CodOcorIrrf.Value   = ""
            loc_oImp.txt_4c__CodOcorInss.Value   = ""
            loc_oImp.txt_4c__CodOcorCsll.Value   = ""
            loc_oImp.txt_4c__CodOcoriSS.Value    = ""

            loc_oImp.txt_4c_Grupo.Value   = ""
            loc_oImp.txt_4c_Contao.Value  = ""
            loc_oImp.txt_4c_Dcontao.Value = ""

            loc_oVen.txt_4c__grupopis.Value     = ""
            loc_oVen.txt_4c__contapis.Value     = ""
            loc_oVen.txt_4c__dcontapis.Value    = ""
            loc_oVen.txt_4c__grupocofins.Value  = ""
            loc_oVen.txt_4c__contacofins.Value  = ""
            loc_oVen.txt_4c__dcontacofins.Value = ""
            loc_oVen.txt_4c__grupoirrf.Value    = ""
            loc_oVen.txt_4c__contairrf.Value    = ""
            loc_oVen.txt_4c__dcontairrf.Value   = ""
            loc_oVen.txt_4c__grupoinss.Value    = ""
            loc_oVen.txt_4c__containss.Value    = ""
            loc_oVen.txt_4c__dcontainss.Value   = ""
            loc_oVen.txt_4c__grupocsll.Value    = ""
            loc_oVen.txt_4c__contacsll.Value    = ""
            loc_oVen.txt_4c__dcontacsll.Value   = ""
            loc_oVen.txt_4c__grupoiss.Value     = ""
            loc_oVen.txt_4c__contaiss.Value     = ""
            loc_oVen.txt_4c__dcontaiss.Value    = ""

            loc_oVen.obj_4c_Opt_VencPis.Value    = 1
            loc_oVen.obj_4c_Opt_VencCofins.Value = 1
            loc_oVen.obj_4c_Opt_VencIrrf.Value   = 1
            loc_oVen.obj_4c_Opt_VencInss.Value   = 1
            loc_oVen.obj_4c_Opt_VencCsll.Value   = 1
            loc_oVen.obj_4c_Opt_vencIss.Value    = 1

            loc_oRet.txt_4c__PIS.Value    = ""
            loc_oRet.txt_4c__COFINS.Value = ""
            loc_oRet.txt_4c__CSLL.Value   = ""

            loc_oRet.cnt_4c_RPA.obj_4c_Opt_RPA.Value      = 2
            loc_oRet.cnt_4c_RPA.txt_4c__MaxRetInss.Value  = 0
            loc_oRet.cnt_4c_RPA.txt_4c_CodRecPis.Value    = ""
            loc_oRet.cnt_4c_RPA.txt_4c_CodRecCof.Value    = ""
            loc_oRet.cnt_4c_RPA.txt_4c_CodRecCsll.Value   = ""
            loc_oRet.cnt_4c_RPA.txt_4c_CodRecIrrf.Value   = ""

            THIS.AtualizarGridProdutos()
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.LimparCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os campos de edicao da Page2
    * (abas Impostos/Vencimentos/Retencao). Codigo (txt_4c_Codigos) fica
    * editavel somente em INCLUIR/BUSCAR (legado: getCodigos.When)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oImp, loc_oVen, loc_oRet, loc_lEdit, loc_lCodEdit
        loc_lEdit    = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
        loc_lCodEdit = (loc_lEdit AND INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR"))

        TRY
            loc_oImp = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1
            loc_oVen = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2
            loc_oRet = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page3

            *-- Aba Impostos ----------------------------------------------------
            loc_oImp.txt_4c_Codigos.ReadOnly        = !loc_lCodEdit
            loc_oImp.txt_4c_Descricao.ReadOnly      = !loc_lEdit
            loc_oImp.txt_4c__ISS.ReadOnly           = !loc_lEdit
            loc_oImp.txt_4c__PIS.ReadOnly           = !loc_lEdit
            loc_oImp.txt_4c__COFINS.ReadOnly        = !loc_lEdit
            loc_oImp.txt_4c__IRRF.ReadOnly          = !loc_lEdit
            loc_oImp.txt_4c__INSS.ReadOnly          = !loc_lEdit
            loc_oImp.txt_4c__CSLL.ReadOnly          = !loc_lEdit
            loc_oImp.txt_4c__VMinPis.ReadOnly       = !loc_lEdit
            loc_oImp.txt_4c__VMinCofins.ReadOnly    = !loc_lEdit
            loc_oImp.txt_4c__VMinIrrf.ReadOnly      = !loc_lEdit
            loc_oImp.txt_4c__VMinInss.ReadOnly      = !loc_lEdit
            loc_oImp.txt_4c__VMinCsll.ReadOnly      = !loc_lEdit
            loc_oImp.txt_4c__VMinBPis.ReadOnly      = !loc_lEdit
            loc_oImp.chk_4c_Chk_bpisms.Enabled      = loc_lEdit
            loc_oImp.txt_4c__VMinBCofins.ReadOnly   = !loc_lEdit
            loc_oImp.chk_4c_Chk_bcofinms.Enabled    = loc_lEdit
            loc_oImp.txt_4c__VMinBIrrf.ReadOnly     = !loc_lEdit
            loc_oImp.chk_4c_Chk_birrfms.Enabled     = loc_lEdit
            loc_oImp.txt_4c__VMinBInss.ReadOnly     = !loc_lEdit
            loc_oImp.chk_4c_Chk_binssms.Enabled     = loc_lEdit
            loc_oImp.txt_4c__vMinBCsll.ReadOnly     = !loc_lEdit
            loc_oImp.chk_4c_Chk_bcsllms.Enabled     = loc_lEdit
            loc_oImp.chk_4c_Chk_LancFinPis.Enabled  = loc_lEdit
            loc_oImp.chk_4c_Ck_LancFinCofins.Enabled = loc_lEdit
            loc_oImp.chk_4c_Ck_LancFinIrrf.Enabled  = loc_lEdit
            loc_oImp.chk_4c_Ck_LancFinCsll.Enabled  = loc_lEdit
            loc_oImp.chk_4c_Ck_LancFinInss.Enabled  = loc_lEdit
            loc_oImp.chk_4c_Ck_LancFinIss.Enabled   = loc_lEdit
            loc_oImp.txt_4c__CodOcorPis.ReadOnly    = !loc_lEdit
            loc_oImp.txt_4c__CodOcorCofins.ReadOnly = !loc_lEdit
            loc_oImp.txt_4c__CodOcorIrrf.ReadOnly   = !loc_lEdit
            loc_oImp.txt_4c__CodOcorInss.ReadOnly   = !loc_lEdit
            loc_oImp.txt_4c__CodOcorCsll.ReadOnly   = !loc_lEdit
            loc_oImp.txt_4c__CodOcoriSS.ReadOnly    = !loc_lEdit
            loc_oImp.txt_4c_Grupo.ReadOnly          = !loc_lEdit
            loc_oImp.txt_4c_Contao.ReadOnly         = !loc_lEdit
            loc_oImp.txt_4c_Dcontao.ReadOnly        = !loc_lEdit

            *-- Aba Vencimentos --------------------------------------------------
            loc_oVen.txt_4c__grupopis.ReadOnly     = !loc_lEdit
            loc_oVen.txt_4c__contapis.ReadOnly     = !loc_lEdit
            loc_oVen.txt_4c__dcontapis.ReadOnly    = !loc_lEdit
            loc_oVen.txt_4c__grupocofins.ReadOnly  = !loc_lEdit
            loc_oVen.txt_4c__contacofins.ReadOnly  = !loc_lEdit
            loc_oVen.txt_4c__dcontacofins.ReadOnly = !loc_lEdit
            loc_oVen.txt_4c__grupoirrf.ReadOnly    = !loc_lEdit
            loc_oVen.txt_4c__contairrf.ReadOnly    = !loc_lEdit
            loc_oVen.txt_4c__dcontairrf.ReadOnly   = !loc_lEdit
            loc_oVen.txt_4c__grupoinss.ReadOnly    = !loc_lEdit
            loc_oVen.txt_4c__containss.ReadOnly    = !loc_lEdit
            loc_oVen.txt_4c__dcontainss.ReadOnly   = !loc_lEdit
            loc_oVen.txt_4c__grupocsll.ReadOnly    = !loc_lEdit
            loc_oVen.txt_4c__contacsll.ReadOnly    = !loc_lEdit
            loc_oVen.txt_4c__dcontacsll.ReadOnly   = !loc_lEdit
            loc_oVen.txt_4c__grupoiss.ReadOnly     = !loc_lEdit
            loc_oVen.txt_4c__contaiss.ReadOnly     = !loc_lEdit
            loc_oVen.txt_4c__dcontaiss.ReadOnly    = !loc_lEdit
            loc_oVen.obj_4c_Opt_VencPis.Enabled    = loc_lEdit
            loc_oVen.obj_4c_Opt_VencCofins.Enabled = loc_lEdit
            loc_oVen.obj_4c_Opt_VencIrrf.Enabled   = loc_lEdit
            loc_oVen.obj_4c_Opt_VencInss.Enabled   = loc_lEdit
            loc_oVen.obj_4c_Opt_VencCsll.Enabled   = loc_lEdit
            loc_oVen.obj_4c_Opt_vencIss.Enabled    = loc_lEdit
            loc_oVen.grd_4c_Dados.ReadOnly         = !loc_lEdit
            loc_oVen.cmd_4c_CmdInserir.Enabled     = loc_lEdit
            loc_oVen.cmd_4c_CmdExcluir.Enabled     = loc_lEdit

            *-- Aba Retencao ------------------------------------------------------
            loc_oRet.txt_4c__PIS.ReadOnly    = !loc_lEdit
            loc_oRet.txt_4c__COFINS.ReadOnly = !loc_lEdit
            loc_oRet.txt_4c__CSLL.ReadOnly   = !loc_lEdit
            loc_oRet.cnt_4c_RPA.obj_4c_Opt_RPA.Enabled      = loc_lEdit
            loc_oRet.cnt_4c_RPA.txt_4c__MaxRetInss.ReadOnly = !loc_lEdit
            loc_oRet.cnt_4c_RPA.txt_4c_CodRecPis.ReadOnly   = !loc_lEdit
            loc_oRet.cnt_4c_RPA.txt_4c_CodRecCof.ReadOnly   = !loc_lEdit
            loc_oRet.cnt_4c_RPA.txt_4c_CodRecCsll.ReadOnly  = !loc_lEdit
            loc_oRet.cnt_4c_RPA.txt_4c_CodRecIrrf.ReadOnly  = !loc_lEdit

            *-- Botoes de acao (Confirmar habilitado em INCLUIR/ALTERAR/BUSCAR
            *-- e tambem em EXCLUIR - campos readonly mas usuario precisa
            *-- poder confirmar a exclusao - CLAUDE.md Erro140/Pattern #178)
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdit OR (THIS.this_cModoAtual = "EXCLUIR")
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.HabilitarCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita botoes CRUD da Page1 apenas em modo LISTA
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_lLista
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_lLista = (THIS.this_cModoAtual = "LISTA")

        TRY
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lLista
            loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = loc_lLista
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara form para inclusao de novo servico
    *===========================================================================
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
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.BtnIncluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre registro selecionado em modo somente leitura
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codservs)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre registro selecionado para edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codservs)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui servico selecionado apos confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codservs)

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            RETURN .F.
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do servi" + CHR(231) + "o " + loc_cCodigo + "?", "Excluir")
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Servi" + CHR(231) + "o exclu" + CHR(237) + "do com sucesso!")
                THIS.CarregarLista()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Vai para Page2 no modo BUSCAR (localizar por codigo)
    *===========================================================================
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
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.BtnBuscarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Salva o servico (ou localiza em modo BUSCAR)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oImp, loc_cCodBusca, loc_lResultado
        loc_lResultado = .F.

        loc_oImp = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page1

        *-- Validacoes antes do TRY (RETURN valido aqui)
        IF THIS.this_cModoAtual = "INCLUIR" AND EMPTY(ALLTRIM(loc_oImp.txt_4c_Codigos.Value))
            MsgAviso("O c" + CHR(243) + "digo do servi" + CHR(231) + "o " + CHR(233) + " obrigat" + CHR(243) + "rio.", "")
            loc_oImp.txt_4c_Codigos.SetFocus
            RETURN .F.
        ENDIF

        IF !INLIST(THIS.this_cModoAtual, "BUSCAR", "VISUALIZAR") AND EMPTY(ALLTRIM(loc_oImp.txt_4c_Descricao.Value))
            MsgAviso("A descri" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria.", "")
            loc_oImp.txt_4c_Descricao.SetFocus
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_cModoAtual = "BUSCAR"
                loc_cCodBusca = ALLTRIM(loc_oImp.txt_4c_Codigos.Value)
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                IF USED("cursor_4c_Dados") AND !EMPTY(loc_cCodBusca)
                    SELECT cursor_4c_Dados
                    LOCATE FOR ALLTRIM(cursor_4c_Dados.codservs) = loc_cCodBusca
                    IF !FOUND()
                        LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.descservs)) = UPPER(loc_cCodBusca)
                    ENDIF
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF THIS.FormParaBO()
                    IF THIS.this_oBusinessObject.Salvar()
                        MsgInfo("Servi" + CHR(231) + "o salvo com sucesso!")
                        THIS.this_cModoAtual = "LISTA"
                        THIS.AlternarPagina(1)
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela e volta para a lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loException
            MsgErro(loException.Message, "FormSRV.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SRVBO.prg):
*====================================================================
* SRVBO.prg
*
* Business Object para Cadastro de Servicos (Entradas/Saidas)
* Tabela: SigCdSrv (mestre) / SigSeRvp (detalhe - produtos do servico)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SRVBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdSrv)
    this_cCidChaves     = ""    && cidchaves char(20) - PK
    this_cCodigo        = ""    && codservs char(10)
    this_cDescricao     = ""    && descservs char(40)
    this_cTipo          = "S"   && ctipos char(1) - S=Saidas / E=Entradas

    *-- Aliquotas (%)
    this_nAliquotaPis     = 0   && apiss numeric(4,2)
    this_nAliquotaCofins  = 0   && acofinss numeric(4,2)
    this_nAliquotaIrrf    = 0   && airrfs numeric(4,2)
    this_nAliquotaInss    = 0   && ainss numeric(4,2)
    this_nAliquotaCsll    = 0   && acslls numeric(4,2)
    this_nAliquotaIss     = 0   && aiss numeric(4,2)

    *-- Valores minimos a recolher
    this_nValorMinimoPis     = 0   && vminpiss numeric(11,2)
    this_nValorMinimoCofins  = 0   && vmincofins numeric(11,2)
    this_nValorMinimoIrrf    = 0   && vminirrfs numeric(11,2)
    this_nValorMinimoInss    = 0   && vmininss numeric(11,2)
    this_nValorMinimoCsll    = 0   && vmincslls numeric(11,2)

    *-- Base de calculo minima
    this_nBaseMinimaPis     = 0   && vminbpiss numeric(11,2)
    this_nBaseMinimaCofins  = 0   && vminbcofin numeric(11,2)
    this_nBaseMinimaIrrf    = 0   && vminbirrfs numeric(11,2)
    this_nBaseMinimaInss    = 0   && vminbinss numeric(11,2)
    this_nBaseMinimaCsll    = 0   && vminbcslls numeric(11,2)

    *-- Recolhimento Mensal (checkboxes)
    this_lMensalPis     = .F.   && bpisms numeric(1,0)
    this_lMensalCofins  = .F.   && bcofinms numeric(1,0)
    this_lMensalIrrf    = .F.   && birrfms numeric(1,0)
    this_lMensalInss    = .F.   && binssms numeric(1,0)
    this_lMensalCsll    = .F.   && bcsllms numeric(1,0)

    *-- Lancamento Financeiro (checkboxes)
    this_lLancFinPis     = .F.   && nlanfpiss numeric(1,0)
    this_lLancFinCofins  = .F.   && nlanfcofin numeric(1,0)
    this_lLancFinIrrf    = .F.   && nlanfirrfs numeric(1,0)
    this_lLancFinInss    = .F.   && nlanfinss numeric(1,0)
    this_lLancFinCsll    = .F.   && nlanfcslls numeric(1,0)
    this_lLancFinIss     = .F.   && nlanfiss numeric(1,0)

    *-- Codigos de Ocorrencia (F4 - crSigOpOco)
    this_cCodOcorPis     = ""   && cocorpiss char(10)
    this_cCodOcorCofins  = ""   && cocorcofin char(10)
    this_cCodOcorIrrf    = ""   && cocorirrfs char(10)
    this_cCodOcorInss    = ""   && cocorinss char(10)
    this_cCodOcorCsll    = ""   && cocorcslls char(10)
    this_cCodOcorIss     = ""   && cocoriss char(10)

    *-- Codigos reduzidos de imposto (nao exibidos no form legado, mas fazem parte da tabela)
    this_cCodCofins  = ""   && codcofinss char(5)
    this_cCodCsll    = ""   && codcslls char(5)
    this_cCodPis     = ""   && codpiss char(5)

    *-- Conta contabil principal (Get_grupoo / Get_contao / Get_dcontao)
    this_cGrupoContab  = ""   && cgrupo char(10)
    this_cContaContab  = ""   && ccontab char(10)

    *-- Grupo/Conta contabil por imposto (aba Vencimentos)
    this_cGrupoPis      = ""   && cgrppiss char(10)
    this_cContaPis      = ""   && cctapiss char(10)
    this_cGrupoCofins   = ""   && cgrpcofins char(10)
    this_cContaCofins   = ""   && cctacofins char(10)
    this_cGrupoIrrf     = ""   && cgrpirrfs char(10)
    this_cContaIrrf     = ""   && cctairrfs char(10)
    this_cGrupoInss     = ""   && cgrpinss char(10)
    this_cContaInss     = ""   && cctainss char(10)
    this_cGrupoCsll     = ""   && cgrpcslls char(10)
    this_cContaCsll     = ""   && cctacslls char(10)
    this_cGrupoIss      = ""   && cgrpiss char(10)
    this_cContaIss      = ""   && cctaiss char(10)

    *-- Opcao de vencimento por imposto (OptionGroup 1/2/3)
    this_nVencimentoPis      = 0   && vcpis numeric(1,0)
    this_nVencimentoCofins   = 0   && vccofins numeric(1,0)
    this_nVencimentoIrrf     = 0   && vcirrf numeric(1,0)
    this_nVencimentoInss     = 0   && vcinss numeric(1,0)
    this_nVencimentoCsll     = 0   && vccsll numeric(1,0)
    this_nVencimentoIss      = 0   && vciss numeric(1,0)

    *-- RPA (Recibo de Pagamento Autonomo)
    this_nRPA                     = 0   && nrpas numeric(1,0) - OptionGroup S/N
    this_nValorMaximoRetencaoInss = 0   && maxretinss numeric(11,2)
    this_cCodRecCofins            = ""   && codreccof char(5)
    this_cCodRecPis               = ""   && codrecpis char(5)
    this_cCodRecCsll              = ""   && codreccsll char(5)
    this_cCodRecIrrf              = ""   && codrecirrf char(5)

    *-- Detalhe: produtos do servico (SigSeRvp) - gerenciado via cursor proprio
    this_cCursorProdutos = "cursor_4c_Produtos"   && cursor local do grid de produtos (codservs, cpros)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdSrv"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SRVBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna PK para auditoria (RegistrarAuditoria)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * LimparDados - Reseta todas as propriedades para novo registro
    *====================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves = ""
        THIS.this_cCodigo    = ""
        THIS.this_cDescricao = ""
        *-- this_cTipo NAO eh resetado: contexto Saidas/Entradas definido pelo Form

        THIS.this_nAliquotaPis    = 0
        THIS.this_nAliquotaCofins = 0
        THIS.this_nAliquotaIrrf   = 0
        THIS.this_nAliquotaInss   = 0
        THIS.this_nAliquotaCsll   = 0
        THIS.this_nAliquotaIss    = 0

        THIS.this_nValorMinimoPis    = 0
        THIS.this_nValorMinimoCofins = 0
        THIS.this_nValorMinimoIrrf   = 0
        THIS.this_nValorMinimoInss   = 0
        THIS.this_nValorMinimoCsll   = 0

        THIS.this_nBaseMinimaPis    = 0
        THIS.this_nBaseMinimaCofins = 0
        THIS.this_nBaseMinimaIrrf   = 0
        THIS.this_nBaseMinimaInss   = 0
        THIS.this_nBaseMinimaCsll   = 0

        THIS.this_lMensalPis    = .F.
        THIS.this_lMensalCofins = .F.
        THIS.this_lMensalIrrf   = .F.
        THIS.this_lMensalInss   = .F.
        THIS.this_lMensalCsll   = .F.

        THIS.this_lLancFinPis    = .F.
        THIS.this_lLancFinCofins = .F.
        THIS.this_lLancFinIrrf   = .F.
        THIS.this_lLancFinInss   = .F.
        THIS.this_lLancFinCsll   = .F.
        THIS.this_lLancFinIss    = .F.

        THIS.this_cCodOcorPis    = ""
        THIS.this_cCodOcorCofins = ""
        THIS.this_cCodOcorIrrf   = ""
        THIS.this_cCodOcorInss   = ""
        THIS.this_cCodOcorCsll   = ""
        THIS.this_cCodOcorIss    = ""

        THIS.this_cCodCofins = ""
        THIS.this_cCodCsll   = ""
        THIS.this_cCodPis    = ""

        THIS.this_cGrupoContab = ""
        THIS.this_cContaContab = ""

        THIS.this_cGrupoPis    = ""
        THIS.this_cContaPis    = ""
        THIS.this_cGrupoCofins = ""
        THIS.this_cContaCofins = ""
        THIS.this_cGrupoIrrf   = ""
        THIS.this_cContaIrrf   = ""
        THIS.this_cGrupoInss   = ""
        THIS.this_cContaInss   = ""
        THIS.this_cGrupoCsll   = ""
        THIS.this_cContaCsll   = ""
        THIS.this_cGrupoIss    = ""
        THIS.this_cContaIss    = ""

        THIS.this_nVencimentoPis    = 0
        THIS.this_nVencimentoCofins = 0
        THIS.this_nVencimentoIrrf   = 0
        THIS.this_nVencimentoInss   = 0
        THIS.this_nVencimentoCsll   = 0
        THIS.this_nVencimentoIss    = 0

        THIS.this_nRPA                     = 0
        THIS.this_nValorMaximoRetencaoInss = 0
        THIS.this_cCodRecCofins            = ""
        THIS.this_cCodRecPis               = ""
        THIS.this_cCodRecCsll              = ""
        THIS.this_cCodRecIrrf              = ""

        IF USED(THIS.this_cCursorProdutos)
            USE IN (THIS.this_cCursorProdutos)
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Produtos (CidChaves C(20), CodServs C(10), CPros C(14), DPros C(40))
        SET NULL OFF
    ENDPROC

    *====================================================================
    * Buscar - SELECT servicos do tipo atual (this_cTipo), filtro opcional
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, codservs, descservs, ctipos" + ;
                       " FROM SigCdSrv" + ;
                       " WHERE ctipos = " + EscaparSQL(THIS.this_cTipo)

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                    " AND (UPPER(codservs) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")" + ;
                    " OR UPPER(descservs) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + "))"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codservs"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar servicos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - SELECT registro por codigo (+ tipo atual) e produtos
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, codservs, descservs, ctipos," + ;
                " apiss, acofinss, airrfs, ainss, aiss, acslls," + ;
                " vminpiss, vmincofins, vminirrfs, vmininss, vmincslls," + ;
                " vminbpiss, vminbcofin, vminbirrfs, vminbinss, vminbcslls," + ;
                " bpisms, bcofinms, birrfms, binssms, bcsllms," + ;
                " nlanfpiss, nlanfcofin, nlanfirrfs, nlanfinss, nlanfcslls, nlanfiss," + ;
                " cocorpiss, cocorcofin, cocorirrfs, cocorinss, cocorcslls, cocoriss," + ;
                " codpiss, codcslls, codcofinss, cgrupo, ccontab," + ;
                " cgrppiss, cctapiss, cgrpcofins, cctacofins, cgrpirrfs, cctairrfs," + ;
                " cgrpinss, cctainss, cgrpcslls, cctacslls, cgrpiss, cctaiss," + ;
                " vcpis, vccofins, vcirrf, vcinss, vccsll, vciss," + ;
                " nrpas, maxretinss, codreccof, codrecpis, codreccsll, codrecirrf" + ;
                " FROM SigCdSrv" + ;
                " WHERE codservs = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                " AND ctipos = " + EscaparSQL(THIS.this_cTipo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                    THIS.CarregarProdutos(THIS.this_cCodigo)
                ENDIF
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar servico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor para as
    * propriedades this_* (chamado por CarregarPorCodigo)
    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidChaves = ALLTRIM(TratarNulo(cidchaves, "C"))
                THIS.this_cCodigo    = ALLTRIM(TratarNulo(codservs, "C"))
                THIS.this_cDescricao = ALLTRIM(TratarNulo(descservs, "C"))
                THIS.this_cTipo      = ALLTRIM(TratarNulo(ctipos, "C"))

                THIS.this_nAliquotaPis    = TratarNulo(apiss, "N")
                THIS.this_nAliquotaCofins = TratarNulo(acofinss, "N")
                THIS.this_nAliquotaIrrf   = TratarNulo(airrfs, "N")
                THIS.this_nAliquotaInss   = TratarNulo(ainss, "N")
                THIS.this_nAliquotaCsll   = TratarNulo(acslls, "N")
                THIS.this_nAliquotaIss    = TratarNulo(aiss, "N")

                THIS.this_nValorMinimoPis    = TratarNulo(vminpiss, "N")
                THIS.this_nValorMinimoCofins = TratarNulo(vmincofins, "N")
                THIS.this_nValorMinimoIrrf   = TratarNulo(vminirrfs, "N")
                THIS.this_nValorMinimoInss   = TratarNulo(vmininss, "N")
                THIS.this_nValorMinimoCsll   = TratarNulo(vmincslls, "N")

                THIS.this_nBaseMinimaPis    = TratarNulo(vminbpiss, "N")
                THIS.this_nBaseMinimaCofins = TratarNulo(vminbcofin, "N")
                THIS.this_nBaseMinimaIrrf   = TratarNulo(vminbirrfs, "N")
                THIS.this_nBaseMinimaInss   = TratarNulo(vminbinss, "N")
                THIS.this_nBaseMinimaCsll   = TratarNulo(vminbcslls, "N")

                THIS.this_lMensalPis    = (TratarNulo(bpisms, "N") = 1)
                THIS.this_lMensalCofins = (TratarNulo(bcofinms, "N") = 1)
                THIS.this_lMensalIrrf   = (TratarNulo(birrfms, "N") = 1)
                THIS.this_lMensalInss   = (TratarNulo(binssms, "N") = 1)
                THIS.this_lMensalCsll   = (TratarNulo(bcsllms, "N") = 1)

                THIS.this_lLancFinPis    = (TratarNulo(nlanfpiss, "N") = 1)
                THIS.this_lLancFinCofins = (TratarNulo(nlanfcofin, "N") = 1)
                THIS.this_lLancFinIrrf   = (TratarNulo(nlanfirrfs, "N") = 1)
                THIS.this_lLancFinInss   = (TratarNulo(nlanfinss, "N") = 1)
                THIS.this_lLancFinCsll   = (TratarNulo(nlanfcslls, "N") = 1)
                THIS.this_lLancFinIss    = (TratarNulo(nlanfiss, "N") = 1)

                THIS.this_cCodOcorPis    = ALLTRIM(TratarNulo(cocorpiss, "C"))
                THIS.this_cCodOcorCofins = ALLTRIM(TratarNulo(cocorcofin, "C"))
                THIS.this_cCodOcorIrrf   = ALLTRIM(TratarNulo(cocorirrfs, "C"))
                THIS.this_cCodOcorInss   = ALLTRIM(TratarNulo(cocorinss, "C"))
                THIS.this_cCodOcorCsll   = ALLTRIM(TratarNulo(cocorcslls, "C"))
                THIS.this_cCodOcorIss    = ALLTRIM(TratarNulo(cocoriss, "C"))

                THIS.this_cCodCofins = ALLTRIM(TratarNulo(codcofinss, "C"))
                THIS.this_cCodCsll   = ALLTRIM(TratarNulo(codcslls, "C"))
                THIS.this_cCodPis    = ALLTRIM(TratarNulo(codpiss, "C"))

                THIS.this_cGrupoContab = ALLTRIM(TratarNulo(cgrupo, "C"))
                THIS.this_cContaContab = ALLTRIM(TratarNulo(ccontab, "C"))

                THIS.this_cGrupoPis    = ALLTRIM(TratarNulo(cgrppiss, "C"))
                THIS.this_cContaPis    = ALLTRIM(TratarNulo(cctapiss, "C"))
                THIS.this_cGrupoCofins = ALLTRIM(TratarNulo(cgrpcofins, "C"))
                THIS.this_cContaCofins = ALLTRIM(TratarNulo(cctacofins, "C"))
                THIS.this_cGrupoIrrf   = ALLTRIM(TratarNulo(cgrpirrfs, "C"))
                THIS.this_cContaIrrf   = ALLTRIM(TratarNulo(cctairrfs, "C"))
                THIS.this_cGrupoInss   = ALLTRIM(TratarNulo(cgrpinss, "C"))
                THIS.this_cContaInss   = ALLTRIM(TratarNulo(cctainss, "C"))
                THIS.this_cGrupoCsll   = ALLTRIM(TratarNulo(cgrpcslls, "C"))
                THIS.this_cContaCsll   = ALLTRIM(TratarNulo(cctacslls, "C"))
                THIS.this_cGrupoIss    = ALLTRIM(TratarNulo(cgrpiss, "C"))
                THIS.this_cContaIss    = ALLTRIM(TratarNulo(cctaiss, "C"))

                THIS.this_nVencimentoPis    = TratarNulo(vcpis, "N")
                THIS.this_nVencimentoCofins = TratarNulo(vccofins, "N")
                THIS.this_nVencimentoIrrf   = TratarNulo(vcirrf, "N")
                THIS.this_nVencimentoInss   = TratarNulo(vcinss, "N")
                THIS.this_nVencimentoCsll   = TratarNulo(vccsll, "N")
                THIS.this_nVencimentoIss    = TratarNulo(vciss, "N")

                THIS.this_nRPA                     = TratarNulo(nrpas, "N")
                THIS.this_nValorMaximoRetencaoInss = TratarNulo(maxretinss, "N")
                THIS.this_cCodRecCofins            = ALLTRIM(TratarNulo(codreccof, "C"))
                THIS.this_cCodRecPis               = ALLTRIM(TratarNulo(codrecpis, "C"))
                THIS.this_cCodRecCsll              = ALLTRIM(TratarNulo(codreccsll, "C"))
                THIS.this_cCodRecIrrf              = ALLTRIM(TratarNulo(codrecirrf, "C"))

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Inserir - INSERT INTO SigCdSrv (todas as colunas) + produtos
    *====================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdSrv" + ;
                " (cidchaves, codservs, descservs, ctipos," + ;
                " apiss, acofinss, airrfs, ainss, aiss, acslls," + ;
                " vminpiss, vmincofins, vminirrfs, vmininss, vmincslls," + ;
                " vminbpiss, vminbcofin, vminbirrfs, vminbinss, vminbcslls," + ;
                " bpisms, bcofinms, birrfms, binssms, bcsllms," + ;
                " nlanfpiss, nlanfcofin, nlanfirrfs, nlanfinss, nlanfcslls, nlanfiss," + ;
                " cocorpiss, cocorcofin, cocorirrfs, cocorinss, cocorcslls, cocoriss," + ;
                " codpiss, codcslls, codcofinss, cgrupo, ccontab," + ;
                " cgrppiss, cctapiss, cgrpcofins, cctacofins, cgrpirrfs, cctairrfs," + ;
                " cgrpinss, cctainss, cgrpcslls, cctacslls, cgrpiss, cctaiss," + ;
                " vcpis, vccofins, vcirrf, vcinss, vccsll, vciss," + ;
                " nrpas, maxretinss, codreccof, codrecpis, codreccsll, codrecirrf)"

            loc_cSQL = loc_cSQL + " VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(THIS.this_cCodigo) + ", " + ;
                EscaparSQL(THIS.this_cDescricao) + ", " + ;
                EscaparSQL(THIS.this_cTipo) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nAliquotaPis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotaCofins) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotaIrrf) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotaInss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotaIss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotaCsll) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nValorMinimoPis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValorMinimoCofins) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValorMinimoIrrf) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValorMinimoInss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValorMinimoCsll) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nBaseMinimaPis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBaseMinimaCofins) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBaseMinimaIrrf) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBaseMinimaInss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBaseMinimaCsll) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(IIF(THIS.this_lMensalPis, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lMensalCofins, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lMensalIrrf, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lMensalInss, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lMensalCsll, 1, 0)) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinPis, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinCofins, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinIrrf, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinInss, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinCsll, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinIss, 1, 0)) + ","

            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCodOcorPis) + ", " + ;
                EscaparSQL(THIS.this_cCodOcorCofins) + ", " + ;
                EscaparSQL(THIS.this_cCodOcorIrrf) + ", " + ;
                EscaparSQL(THIS.this_cCodOcorInss) + ", " + ;
                EscaparSQL(THIS.this_cCodOcorCsll) + ", " + ;
                EscaparSQL(THIS.this_cCodOcorIss) + ","

            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCodPis) + ", " + ;
                EscaparSQL(THIS.this_cCodCsll) + ", " + ;
                EscaparSQL(THIS.this_cCodCofins) + ", " + ;
                EscaparSQL(THIS.this_cGrupoContab) + ", " + ;
                EscaparSQL(THIS.this_cContaContab) + ","

            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cGrupoPis) + ", " + ;
                EscaparSQL(THIS.this_cContaPis) + ", " + ;
                EscaparSQL(THIS.this_cGrupoCofins) + ", " + ;
                EscaparSQL(THIS.this_cContaCofins) + ", " + ;
                EscaparSQL(THIS.this_cGrupoIrrf) + ", " + ;
                EscaparSQL(THIS.this_cContaIrrf) + ","

            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cGrupoInss) + ", " + ;
                EscaparSQL(THIS.this_cContaInss) + ", " + ;
                EscaparSQL(THIS.this_cGrupoCsll) + ", " + ;
                EscaparSQL(THIS.this_cContaCsll) + ", " + ;
                EscaparSQL(THIS.this_cGrupoIss) + ", " + ;
                EscaparSQL(THIS.this_cContaIss) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nVencimentoPis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVencimentoCofins) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVencimentoIrrf) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVencimentoInss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVencimentoCsll) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVencimentoIss) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nRPA) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValorMaximoRetencaoInss) + ", " + ;
                EscaparSQL(THIS.this_cCodRecCofins) + ", " + ;
                EscaparSQL(THIS.this_cCodRecPis) + ", " + ;
                EscaparSQL(THIS.this_cCodRecCsll) + ", " + ;
                EscaparSQL(THIS.this_cCodRecIrrf) + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = THIS.SalvarProdutos(THIS.this_cCodigo)
                IF !loc_lResultado
                    MsgErro("Servico inserido mas erro ao salvar produtos.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao inserir servico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Atualizar - UPDATE SigCdSrv (todas as colunas editaveis) + produtos
    *====================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdSrv SET" + ;
                " descservs = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                " apiss = " + FormatarNumeroSQL(THIS.this_nAliquotaPis) + "," + ;
                " acofinss = " + FormatarNumeroSQL(THIS.this_nAliquotaCofins) + "," + ;
                " airrfs = " + FormatarNumeroSQL(THIS.this_nAliquotaIrrf) + "," + ;
                " ainss = " + FormatarNumeroSQL(THIS.this_nAliquotaInss) + "," + ;
                " aiss = " + FormatarNumeroSQL(THIS.this_nAliquotaIss) + "," + ;
                " acslls = " + FormatarNumeroSQL(THIS.this_nAliquotaCsll) + "," + ;
                " vminpiss = " + FormatarNumeroSQL(THIS.this_nValorMinimoPis) + "," + ;
                " vmincofins = " + FormatarNumeroSQL(THIS.this_nValorMinimoCofins) + "," + ;
                " vminirrfs = " + FormatarNumeroSQL(THIS.this_nValorMinimoIrrf) + "," + ;
                " vmininss = " + FormatarNumeroSQL(THIS.this_nValorMinimoInss) + "," + ;
                " vmincslls = " + FormatarNumeroSQL(THIS.this_nValorMinimoCsll)

            loc_cSQL = loc_cSQL + "," + ;
                " vminbpiss = " + FormatarNumeroSQL(THIS.this_nBaseMinimaPis) + "," + ;
                " vminbcofin = " + FormatarNumeroSQL(THIS.this_nBaseMinimaCofins) + "," + ;
                " vminbirrfs = " + FormatarNumeroSQL(THIS.this_nBaseMinimaIrrf) + "," + ;
                " vminbinss = " + FormatarNumeroSQL(THIS.this_nBaseMinimaInss) + "," + ;
                " vminbcslls = " + FormatarNumeroSQL(THIS.this_nBaseMinimaCsll) + "," + ;
                " bpisms = " + FormatarNumeroSQL(IIF(THIS.this_lMensalPis, 1, 0)) + "," + ;
                " bcofinms = " + FormatarNumeroSQL(IIF(THIS.this_lMensalCofins, 1, 0)) + "," + ;
                " birrfms = " + FormatarNumeroSQL(IIF(THIS.this_lMensalIrrf, 1, 0)) + "," + ;
                " binssms = " + FormatarNumeroSQL(IIF(THIS.this_lMensalInss, 1, 0)) + "," + ;
                " bcsllms = " + FormatarNumeroSQL(IIF(THIS.this_lMensalCsll, 1, 0))

            loc_cSQL = loc_cSQL + "," + ;
                " nlanfpiss = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinPis, 1, 0)) + "," + ;
                " nlanfcofin = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinCofins, 1, 0)) + "," + ;
                " nlanfirrfs = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinIrrf, 1, 0)) + "," + ;
                " nlanfinss = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinInss, 1, 0)) + "," + ;
                " nlanfcslls = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinCsll, 1, 0)) + "," + ;
                " nlanfiss = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinIss, 1, 0)) + "," + ;
                " cocorpiss = " + EscaparSQL(THIS.this_cCodOcorPis) + "," + ;
                " cocorcofin = " + EscaparSQL(THIS.this_cCodOcorCofins) + "," + ;
                " cocorirrfs = " + EscaparSQL(THIS.this_cCodOcorIrrf) + "," + ;
                " cocorinss = " + EscaparSQL(THIS.this_cCodOcorInss)

            loc_cSQL = loc_cSQL + "," + ;
                " cocorcslls = " + EscaparSQL(THIS.this_cCodOcorCsll) + "," + ;
                " cocoriss = " + EscaparSQL(THIS.this_cCodOcorIss) + "," + ;
                " codpiss = " + EscaparSQL(THIS.this_cCodPis) + "," + ;
                " codcslls = " + EscaparSQL(THIS.this_cCodCsll) + "," + ;
                " codcofinss = " + EscaparSQL(THIS.this_cCodCofins) + "," + ;
                " cgrupo = " + EscaparSQL(THIS.this_cGrupoContab) + "," + ;
                " ccontab = " + EscaparSQL(THIS.this_cContaContab) + "," + ;
                " cgrppiss = " + EscaparSQL(THIS.this_cGrupoPis) + "," + ;
                " cctapiss = " + EscaparSQL(THIS.this_cContaPis) + "," + ;
                " cgrpcofins = " + EscaparSQL(THIS.this_cGrupoCofins)

            loc_cSQL = loc_cSQL + "," + ;
                " cctacofins = " + EscaparSQL(THIS.this_cContaCofins) + "," + ;
                " cgrpirrfs = " + EscaparSQL(THIS.this_cGrupoIrrf) + "," + ;
                " cctairrfs = " + EscaparSQL(THIS.this_cContaIrrf) + "," + ;
                " cgrpinss = " + EscaparSQL(THIS.this_cGrupoInss) + "," + ;
                " cctainss = " + EscaparSQL(THIS.this_cContaInss) + "," + ;
                " cgrpcslls = " + EscaparSQL(THIS.this_cGrupoCsll) + "," + ;
                " cctacslls = " + EscaparSQL(THIS.this_cContaCsll) + "," + ;
                " cgrpiss = " + EscaparSQL(THIS.this_cGrupoIss) + "," + ;
                " cctaiss = " + EscaparSQL(THIS.this_cContaIss) + "," + ;
                " vcpis = " + FormatarNumeroSQL(THIS.this_nVencimentoPis)

            loc_cSQL = loc_cSQL + "," + ;
                " vccofins = " + FormatarNumeroSQL(THIS.this_nVencimentoCofins) + "," + ;
                " vcirrf = " + FormatarNumeroSQL(THIS.this_nVencimentoIrrf) + "," + ;
                " vcinss = " + FormatarNumeroSQL(THIS.this_nVencimentoInss) + "," + ;
                " vccsll = " + FormatarNumeroSQL(THIS.this_nVencimentoCsll) + "," + ;
                " vciss = " + FormatarNumeroSQL(THIS.this_nVencimentoIss) + "," + ;
                " nrpas = " + FormatarNumeroSQL(THIS.this_nRPA) + "," + ;
                " maxretinss = " + FormatarNumeroSQL(THIS.this_nValorMaximoRetencaoInss) + "," + ;
                " codreccof = " + EscaparSQL(THIS.this_cCodRecCofins) + "," + ;
                " codrecpis = " + EscaparSQL(THIS.this_cCodRecPis) + "," + ;
                " codreccsll = " + EscaparSQL(THIS.this_cCodRecCsll) + "," + ;
                " codrecirrf = " + EscaparSQL(THIS.this_cCodRecIrrf)

            loc_cSQL = loc_cSQL + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = THIS.SalvarProdutos(THIS.this_cCodigo)
                IF !loc_lResultado
                    MsgErro("Servico atualizado mas erro ao salvar produtos.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao atualizar servico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - DELETE SigSeRvp (produtos) + DELETE SigCdSrv
    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            *-- Remove produtos relacionados primeiro
            loc_cSQL = "DELETE FROM SigSeRvp WHERE codservs = " + ;
                       EscaparSQL(THIS.this_cCodigo)

            IF USED("cursor_4c_DelProd")
                TABLEREVERT(.T., "cursor_4c_DelProd")
                USE IN cursor_4c_DelProd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelProd")
            IF USED("cursor_4c_DelProd")
                USE IN cursor_4c_DelProd
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir produtos do servico:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Remove o registro principal
                loc_cSQL = "DELETE FROM SigCdSrv WHERE cidchaves = " + ;
                           EscaparSQL(THIS.this_cCidChaves)

                IF USED("cursor_4c_Del")
                    TABLEREVERT(.T., "cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir servico:" + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.ExecutarExclusao:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarProdutos - Carrega produtos do servico (SigSeRvp) no cursor
    * do grid (this_cCursorProdutos), com descricao via JOIN SigCdPro
    *====================================================================
    FUNCTION CarregarProdutos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorProdutos)
                USE IN (THIS.this_cCursorProdutos)
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Produtos (CidChaves C(20), CodServs C(10), CPros C(14), DPros C(40))
            SET NULL OFF

            IF !EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT a.cidchaves AS CidChaves, a.codservs AS CodServs," + ;
                           " a.cpros AS CPros, b.dpros AS DPros" + ;
                           " FROM SigSeRvp a" + ;
                           " LEFT JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                           " WHERE a.codservs = " + EscaparSQL(ALLTRIM(par_cCodigo))

                IF USED("cursor_4c_ProdTmp")
                    TABLEREVERT(.T., "cursor_4c_ProdTmp")
                    USE IN cursor_4c_ProdTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdTmp")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_Produtos
                    APPEND FROM DBF("cursor_4c_ProdTmp")
                    IF USED("cursor_4c_ProdTmp")
                        USE IN cursor_4c_ProdTmp
                    ENDIF
                ELSE
                    MsgErro("Erro ao carregar produtos do servico:" + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            GO TOP IN cursor_4c_Produtos
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.CarregarProdutos:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * SalvarProdutos - Persiste cursor_4c_Produtos em SigSeRvp
    * (remove todos os produtos do servico e reinsere os atuais)
    *====================================================================
    PROTECTED FUNCTION SalvarProdutos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_nTotal, loc_nI, loc_aProdutos[1]
        loc_lResultado = .F.

        TRY
            *-- Remove todos os produtos existentes para este servico
            loc_cSQL = "DELETE FROM SigSeRvp WHERE codservs = " + ;
                       EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_DelProdSalvar")
                TABLEREVERT(.T., "cursor_4c_DelProdSalvar")
                USE IN cursor_4c_DelProdSalvar
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelProdSalvar")
            IF USED("cursor_4c_DelProdSalvar")
                USE IN cursor_4c_DelProdSalvar
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar produtos do servico:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.

                *-- Coleta codigos de produto nao-vazios do cursor numa array
                IF USED(THIS.this_cCursorProdutos)
                    loc_nTotal = RECCOUNT(THIS.this_cCursorProdutos)
                    IF loc_nTotal > 0
                        DIMENSION loc_aProdutos[loc_nTotal]
                        SELECT (THIS.this_cCursorProdutos)
                        GO TOP
                        FOR loc_nI = 1 TO loc_nTotal
                            loc_aProdutos[loc_nI] = ALLTRIM(cursor_4c_Produtos.CPros)
                            IF !EOF(THIS.this_cCursorProdutos)
                                SKIP IN (THIS.this_cCursorProdutos)
                            ENDIF
                        ENDFOR

                        *-- Insere os produtos via SQL
                        FOR loc_nI = 1 TO loc_nTotal
                            IF !EMPTY(loc_aProdutos[loc_nI])
                                loc_cSQL = "INSERT INTO SigSeRvp (cidchaves, codservs, cpros)" + ;
                                           " VALUES (" + ;
                                           EscaparSQL(fUniqueIds()) + ", " + ;
                                           EscaparSQL(ALLTRIM(par_cCodigo)) + ", " + ;
                                           EscaparSQL(loc_aProdutos[loc_nI]) + ")"

                                IF USED("cursor_4c_InsProd")
                                    TABLEREVERT(.T., "cursor_4c_InsProd")
                                    USE IN cursor_4c_InsProd
                                ENDIF

                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsProd")
                                IF USED("cursor_4c_InsProd")
                                    USE IN cursor_4c_InsProd
                                ENDIF

                                IF loc_nResultado < 0
                                    MsgErro("Erro ao inserir produto " + loc_aProdutos[loc_nI] + ;
                                             ":" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                    loc_lResultado = .F.
                                ENDIF
                            ENDIF
                        ENDFOR
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.SalvarProdutos:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

