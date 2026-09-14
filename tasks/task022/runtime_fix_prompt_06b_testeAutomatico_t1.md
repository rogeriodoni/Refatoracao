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
[2026-04-28 12:40:08] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-28 12:40:08] [INFO] Config FPW: (nao fornecido)
[2026-04-28 12:40:08] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-28 12:40:08] [INFO] Timeout: 300 segundos
[2026-04-28 12:40:08] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_yn1egpgc.prg
[2026-04-28 12:40:08] [INFO] Conteudo do wrapper:
[2026-04-28 12:40:08] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGACGCT', 'C:\4c\tasks\task022', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGACGCT', 'C:\4c\tasks\task022', 'CRUD'
QUIT

[2026-04-28 12:40:08] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_yn1egpgc.prg
[2026-04-28 12:40:08] [INFO] VFP output esperado em: C:\4c\tasks\task022\vfp_output.txt
[2026-04-28 12:40:08] [INFO] Executando Visual FoxPro 9...
[2026-04-28 12:40:08] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_yn1egpgc.prg
[2026-04-28 12:40:08] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_yn1egpgc.prg
[2026-04-28 12:40:08] [INFO] Timeout configurado: 300 segundos
[2026-04-28 12:40:10] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-28 12:40:10] [INFO] VFP9 finalizado em 1.347471 segundos
[2026-04-28 12:40:10] [INFO] Exit Code: 
[2026-04-28 12:40:10] [INFO] 
[2026-04-28 12:40:10] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-28 12:40:10] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_yn1egpgc.prg
[2026-04-28 12:40:10] [INFO] 
[2026-04-28 12:40:10] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-28 12:40:10] [INFO] * Auto-generated wrapper for parameters
[2026-04-28 12:40:10] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-28 12:40:10] [INFO] * Parameters: 'FormSIGACGCT', 'C:\4c\tasks\task022', 'CRUD'
[2026-04-28 12:40:10] [INFO] 
[2026-04-28 12:40:10] [INFO] * Anti-dialog protections for unattended execution
[2026-04-28 12:40:10] [INFO] SET SAFETY OFF
[2026-04-28 12:40:10] [INFO] SET RESOURCE OFF
[2026-04-28 12:40:10] [INFO] SET TALK OFF
[2026-04-28 12:40:10] [INFO] SET NOTIFY OFF
[2026-04-28 12:40:10] [INFO] SYS(2335, 0)
[2026-04-28 12:40:10] [INFO] 
[2026-04-28 12:40:10] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGACGCT', 'C:\4c\tasks\task022', 'CRUD'
[2026-04-28 12:40:10] [INFO] QUIT
[2026-04-28 12:40:10] [INFO] 
[2026-04-28 12:40:10] [INFO] === Fim do Wrapper.prg ===
[2026-04-28 12:40:10] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGACGCT",
  "timestamp": "20260428124009",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGACGCT.prg):
*==============================================================================
* FormSIGACGCT.prg - Formulario de Acesso Lancamentos
* Data: 2026-04-28
* Tabela: SigSyAgc | PK: cIdChaves (gerada por fUniqueIds)
* Legado: SIGACGCT.SCX (frmcadastro)
* FASE 8/8: Consolidacao final - todos os metodos implementados
*==============================================================================

DEFINE CLASS FormSIGACGCT AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Acesso Lancamentos"
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
    FontName    = "Tahoma"
    FontSize    = 8
    ForeColor   = RGB(90, 90, 90)

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configuracao inicial do formulario
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Acesso  Lan" + CHR(231) + "amentos"

            THIS.this_oBusinessObject = CREATEOBJECT("SIGACGCTBO")

            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MostrarErro("Erro ao criar Business Object SIGACGCTBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Falha ao carregar nao impede abertura
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible  = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
            MostrarErro("Erro ao inicializar FormSIGACGCT:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Configura PageFrame principal
    * PageFrame.Top = -29 (oculta abas), compensar +29 nos containers
    *==========================================================================
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
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Compensacao PageFrame.Top=-29: todos os controles Top += 29
    * cntSombra.Top=2 -> 31 | Grupo_Op.Top=0 -> 29 | Grupo_Saida can?nico
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de cabecalho (cntSombra: Top=2 -> 31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1003
            .Height      = 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Acesso  Lan" + CHR(231) + "amentos"
            .Top       = 20
            .Left      = 20
            .Width     = 400
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (Grupo_Op: Left=544, Top=0 -> 29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Left=5)
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=80)
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Left=305)
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container canonico de saida (Grupo_Saida: Left=917, Top=0 -> 29)
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista (Grade: Top=117, Left=26, Width=890, Height=455)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 455
            .ColumnCount        = 5
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Compensacao PageFrame.Top=-29: todos os controles Top += 29
    * Fase 5/8: Botoes + Secao Usuario + Secao Grupo Contabil
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de botoes de acao (Grupo_Salva: Left=842, Top=4 -> 33)
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

        *-- Botao Confirmar (Salvar)
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .WordWrap        = .T.
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *======================================================================
        * SECAO USUARIO
        * Say2("Usuario"): top=105+29=134 | Shape1: top=122+29=151
        * Get_Grupo: top=126+29=155 | Get_Usuario: top=150+29=179
        *======================================================================

        *-- Shape1 - separador horizontal da secao Usuario (top=122+29=151)
        loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPagina.shp_4c_Shape1
            .Top         = 151
            .Left        = 159
            .Width       = 151
            .Height      = 2
            .BackColor   = RGB(90, 90, 90)
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Label "Usuario" - titulo da secao (Say2: top=105+29=134)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Usu" + CHR(225) + "rio"
            .Top       = 134
            .Left      = 166
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Grupo :" para campo txt_4c_Grupo (Say1: top=129+29=158)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Grupo : "
            .Top       = 158
            .Left      = 175
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Get_Grupo (txt_4c_Grupo: top=126+29=155, left=223, width=80)
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value     = ""
            .Top       = 155
            .Left      = 223
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoAcess")

        *-- Label "Nome :" para campo txt_4c_Usuario (Say3: top=154+29=183)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Nome : "
            .Top       = 183
            .Left      = 177
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Get_Usuario (txt_4c_Usuario: top=150+29=179, left=223, width=80)
        loc_oPagina.AddObject("txt_4c_Usuario", "TextBox")
        WITH loc_oPagina.txt_4c_Usuario
            .Value     = ""
            .Top       = 179
            .Left      = 223
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Usuario, "KeyPress", THIS, "ValidarUsuarioAcess")

        *======================================================================
        * SECAO GRUPO CONTABIL
        * Say7("Grupo Contabil"): top=195+29=224 | Shape3: top=212+29=241
        * Get_GrContab: top=216+29=245 | Get_DGrContab: top=216+29=245
        *======================================================================

        *-- Shape3 - separador horizontal da secao Grupo Contabil (top=212+29=241)
        loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPagina.shp_4c_Shape3
            .Top         = 241
            .Left        = 161
            .Width       = 301
            .Height      = 2
            .BackColor   = RGB(90, 90, 90)
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Label "Grupo Contabil" - titulo da secao (Say7: top=195+29=224)
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Grupo Cont" + CHR(225) + "bil"
            .Top       = 224
            .Left      = 166
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Grupo :" para campo txt_4c_GrContab (Say8: top=219+29=248)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Grupo : "
            .Top       = 248
            .Left      = 175
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Get_GrContab - codigo (txt_4c_GrContab: top=216+29=245, left=223, width=79)
        loc_oPagina.AddObject("txt_4c_GrContab", "TextBox")
        WITH loc_oPagina.txt_4c_GrContab
            .Value     = ""
            .Top       = 245
            .Left      = 223
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_GrContab, "KeyPress", THIS, "ValidarGrContab")

        *-- TextBox Get_DGrContab - descricao (txt_4c_DGrContab: top=216+29=245, left=303, width=150)
        loc_oPagina.AddObject("txt_4c_DGrContab", "TextBox")
        WITH loc_oPagina.txt_4c_DGrContab
            .Value     = ""
            .Top       = 245
            .Left      = 303
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DGrContab, "KeyPress", THIS, "ValidarDGrContab")

        *======================================================================
        * SECAO CONTA CORRENTE
        * Say6("Conta Corrente"): top=265+29=294 | Shape2: top=282+29=311
        * Say4 "Grupo :": top=290+29=319 | Say5 "Conta :": top=311+29=340
        * Get_GrConta: top=288+29=317 | Get_DGrConta: top=288+29=317
        * Get_CdConta: top=312+29=341 | Get_DCONTA: top=312+29=341
        *======================================================================

        *-- Shape2 - separador horizontal da secao Conta Corrente (top=282+29=311)
        loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPagina.shp_4c_Shape2
            .Top         = 311
            .Left        = 159
            .Width       = 513
            .Height      = 2
            .BackColor   = RGB(90, 90, 90)
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Label "Conta Corrente" - titulo da secao (Say6: top=265+29=294)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Conta Corrente"
            .Top       = 294
            .Left      = 166
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Grupo :" para campo txt_4c_GrConta (Say4: top=290+29=319)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Grupo : "
            .Top       = 319
            .Left      = 175
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Get_GrConta - codigo (txt_4c_GrConta: top=288+29=317, left=223, width=79)
        loc_oPagina.AddObject("txt_4c_GrConta", "TextBox")
        WITH loc_oPagina.txt_4c_GrConta
            .Value     = ""
            .Top       = 317
            .Left      = 223
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_GrConta, "KeyPress", THIS, "ValidarGrConta")

        *-- TextBox Get_DGrConta - descricao (txt_4c_DGrConta: top=288+29=317, left=303, width=150)
        loc_oPagina.AddObject("txt_4c_DGrConta", "TextBox")
        WITH loc_oPagina.txt_4c_DGrConta
            .Value     = ""
            .Top       = 317
            .Left      = 303
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DGrConta, "KeyPress", THIS, "ValidarDGrConta")

        *-- Label "Conta :" para campo txt_4c_CdConta (Say5: top=311+29=340)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Conta : "
            .Top       = 340
            .Left      = 176
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Get_CdConta - codigo da conta (txt_4c_CdConta: top=312+29=341, left=223, width=79)
        loc_oPagina.AddObject("txt_4c_CdConta", "TextBox")
        WITH loc_oPagina.txt_4c_CdConta
            .Value     = ""
            .Top       = 341
            .Left      = 223
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdConta, "KeyPress", THIS, "ValidarCdConta")

        *-- TextBox Get_DCONTA - descricao da conta (txt_4c_DCONTA: top=312+29=341, left=303, width=360)
        loc_oPagina.AddObject("txt_4c_DCONTA", "TextBox")
        WITH loc_oPagina.txt_4c_DCONTA
            .Value     = ""
            .Top       = 341
            .Left      = 303
            .Width     = 360
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DCONTA, "KeyPress", THIS, "ValidarDConta")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no grid da lista
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    IF USED("cursor_4c_Dados")
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        loc_oGrid.ColumnCount = 5
                        loc_oGrid.RecordSource = "cursor_4c_Dados"

                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.gracess"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.usuacess"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.grcontbs"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.grcontas"
                        loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cdcontas"

                        loc_oGrid.Column1.Header1.Caption = "Grupo Acesso"
                        loc_oGrid.Column2.Header1.Caption = "Usu" + CHR(225) + "rio Acesso"
                        loc_oGrid.Column3.Header1.Caption = "Gr. Cont" + CHR(225) + "bil"
                        loc_oGrid.Column4.Header1.Caption = "Gr. Conta"
                        loc_oGrid.Column5.Header1.Caption = "Conta"

                        loc_oGrid.Column1.Width = 100
                        loc_oGrid.Column2.Width = 140
                        loc_oGrid.Column3.Width = 120
                        loc_oGrid.Column4.Width = 100
                        loc_oGrid.Column5.Width = 200

                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLista: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.CarregarLista()
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Incluir novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alterar registro selecionado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cId
        loc_cId = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cId = ALLTRIM(NVL(cursor_4c_Dados.cIdChaves, ""))
        ENDIF

        IF EMPTY(loc_cId)
            MsgAviso("Selecione um registro para alterar.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cId)
            THIS.this_oBusinessObject.CarregarDescricoes()
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Erro ao carregar o registro selecionado.", "Erro")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cId
        loc_cId = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cId = ALLTRIM(NVL(cursor_4c_Dados.cIdChaves, ""))
        ENDIF

        IF EMPTY(loc_cId)
            MsgAviso("Selecione um registro para visualizar.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cId)
            THIS.this_oBusinessObject.CarregarDescricoes()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Erro ao carregar o registro selecionado.", "Erro")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Excluir registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cId, loc_lConfirmado
        loc_cId        = ""
        loc_lConfirmado = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cId = ALLTRIM(NVL(cursor_4c_Dados.cIdChaves, ""))
        ENDIF

        IF EMPTY(loc_cId)
            MsgAviso("Selecione um registro para excluir.", "Aviso")
            RETURN
        ENDIF

        loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?", ;
            "Confirmar Exclus" + CHR(227) + "o")

        IF loc_lConfirmado
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cId)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                ELSE
                    MsgErro("Erro ao excluir o registro.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao localizar o registro para exclus" + CHR(227) + "o.", "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Buscar/filtrar registros
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_oGrid
        loc_cFiltro = ALLTRIM(INPUTBOX("Filtrar por Grupo ou Usu" + CHR(225) + "rio:", "Buscar"))

        TRY
            IF THIS.this_oBusinessObject.Buscar(loc_cFiltro) AND USED("cursor_4c_Dados")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount = 5
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.gracess"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.usuacess"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.grcontbs"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.grcontas"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cdcontas"

                loc_oGrid.Column1.Header1.Caption = "Grupo Acesso"
                loc_oGrid.Column2.Header1.Caption = "Usu" + CHR(225) + "rio Acesso"
                loc_oGrid.Column3.Header1.Caption = "Gr. Cont" + CHR(225) + "bil"
                loc_oGrid.Column4.Header1.Caption = "Gr. Conta"
                loc_oGrid.Column5.Header1.Caption = "Conta"

                THIS.FormatarGridLista(loc_oGrid)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnBuscarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salvar registro (Confirmar na Page2)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cGrupo, loc_cUsuario, loc_cGrContab, loc_cGrConta, loc_cCdConta
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo    = ""
        loc_cUsuario  = ""
        loc_cGrContab = ""
        loc_cGrConta  = ""
        loc_cCdConta  = ""

        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
            loc_cUsuario = ALLTRIM(loc_oPagina.txt_4c_Usuario.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
            loc_cGrContab = ALLTRIM(loc_oPagina.txt_4c_GrContab.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
            loc_cGrConta = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
            loc_cCdConta = ALLTRIM(loc_oPagina.txt_4c_CdConta.Value)
        ENDIF

        IF INLIST(THIS.this_cModoAtual, "INCLUIR")
            IF EMPTY(loc_cGrupo) AND EMPTY(loc_cUsuario)
                MsgAviso("Usu" + CHR(225) + "rio/Grupo Inv" + CHR(225) + "lido !!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
                    loc_oPagina.txt_4c_Grupo.SetFocus()
                ENDIF
                RETURN
            ENDIF
        ENDIF

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            IF EMPTY(loc_cGrContab)
                MsgAviso("Grupo Cont" + CHR(225) + "bil Inv" + CHR(225) + "lido !!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
                    loc_oPagina.txt_4c_GrContab.SetFocus()
                ENDIF
                RETURN
            ENDIF

            IF EMPTY(loc_cGrConta)
                MsgAviso("Grupo Conta Corrente Inv" + CHR(225) + "lido !!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
                    loc_oPagina.txt_4c_GrConta.SetFocus()
                ENDIF
                RETURN
            ENDIF

            IF EMPTY(loc_cCdConta)
                MsgAviso("Conta Corrente Inv" + CHR(225) + "lida !!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
                    loc_oPagina.txt_4c_CdConta.SetFocus()
                ENDIF
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        *-- Verificar duplicidade antes de salvar (equivalente ao CursorQuery original)
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            IF THIS.this_oBusinessObject.VerificarDuplicidade()
                MsgAviso("Acesso j" + CHR(225) + " cadastrado !!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
                    loc_oPagina.txt_4c_GrContab.SetFocus()
                ENDIF
                RETURN
            ENDIF
        ENDIF

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Sucesso")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancelar e voltar para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere dados do formulario para o Business Object
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            THIS.this_oBusinessObject.this_cGrAcess = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
            THIS.this_oBusinessObject.this_cUsuAcess = ALLTRIM(loc_oPagina.txt_4c_Usuario.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
            THIS.this_oBusinessObject.this_cGrContbs = ALLTRIM(loc_oPagina.txt_4c_GrContab.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
            THIS.this_oBusinessObject.this_cGrContas = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
            THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(loc_oPagina.txt_4c_CdConta.Value)
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do Business Object para o formulario
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrAcess)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
            loc_oPagina.txt_4c_Usuario.Value = ALLTRIM(THIS.this_oBusinessObject.this_cUsuAcess)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
            loc_oPagina.txt_4c_GrContab.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrContbs)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
            loc_oPagina.txt_4c_DGrContab.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDGrContb)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
            loc_oPagina.txt_4c_GrConta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrContas)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
            loc_oPagina.txt_4c_DGrConta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDGrConta)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
            loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCdContas)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
            loc_oPagina.txt_4c_DCONTA.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDConta)
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos do formulario
    * Grupo e Usuario sao mutuamente exclusivos (When original)
    * DGrContab so editavel quando GrContab vazio (When original)
    * DGrConta  so editavel quando GrConta vazio  (When original)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_cGrupo, loc_cUsuario, loc_cGrContab, loc_cGrConta
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo    = ""
        loc_cUsuario  = ""
        loc_cGrContab = ""
        loc_cGrConta  = ""

        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
            loc_cUsuario = ALLTRIM(loc_oPagina.txt_4c_Usuario.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
            loc_cGrContab = ALLTRIM(loc_oPagina.txt_4c_GrContab.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
            loc_cGrConta = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)
        ENDIF

        *-- Grupo e Usuario: mutuamente exclusivos
        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            loc_oPagina.txt_4c_Grupo.Enabled = par_lHabilitar AND EMPTY(loc_cUsuario)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
            loc_oPagina.txt_4c_Usuario.Enabled = par_lHabilitar AND EMPTY(loc_cGrupo)
        ENDIF

        *-- GrContab: sempre editavel quando habilitado
        IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
            loc_oPagina.txt_4c_GrContab.Enabled = par_lHabilitar
        ENDIF
        *-- DGrContab: so editavel quando GrContab vazio (busca pela descricao)
        IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
            loc_oPagina.txt_4c_DGrContab.Enabled = par_lHabilitar AND EMPTY(loc_cGrContab)
        ENDIF

        *-- GrConta: sempre editavel quando habilitado
        IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
            loc_oPagina.txt_4c_GrConta.Enabled = par_lHabilitar
        ENDIF
        *-- DGrConta: so editavel quando GrConta vazio (busca pela descricao)
        IF PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
            loc_oPagina.txt_4c_DGrConta.Enabled = par_lHabilitar AND EMPTY(loc_cGrConta)
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
            loc_oPagina.txt_4c_CdConta.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
            loc_oPagina.txt_4c_DCONTA.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores dos campos do formulario
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            loc_oPagina.txt_4c_Grupo.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
            loc_oPagina.txt_4c_Usuario.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
            loc_oPagina.txt_4c_GrContab.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
            loc_oPagina.txt_4c_DGrContab.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
            loc_oPagina.txt_4c_GrConta.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
            loc_oPagina.txt_4c_DGrConta.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
            loc_oPagina.txt_4c_CdConta.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
            loc_oPagina.txt_4c_DCONTA.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme o modo atual
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEditando
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *==========================================================================
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

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * ValidarGrupoAcess - Lookup de Grupo de Acesso (Get_Grupo / SigCdAcG)
    * Mutualmente exclusivo com txt_4c_Usuario
    *==========================================================================
    PROCEDURE ValidarGrupoAcess(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cGrupo, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
            RETURN
        ENDIF
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        IF EMPTY(loc_cGrupo)
            *-- Grupo limpo: habilitar Usuario novamente
            IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
                loc_oPagina.txt_4c_Usuario.Enabled = .T.
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdAcG", "cursor_4c_BuscaGrAcess", "Grupos", loc_cGrupo, ;
                "Grupo de Acesso")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGrAcess")
                        SELECT cursor_4c_BuscaGrAcess
                        loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrAcess.Grupos)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Grupos", "", "Grupo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrAcess")
                        SELECT cursor_4c_BuscaGrAcess
                        loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrAcess.Grupos)
                    ENDIF
                ELSE
                    loc_oPagina.txt_4c_Grupo.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrAcess")
                USE IN cursor_4c_BuscaGrAcess
            ENDIF

            *-- Se Grupo preenchido: desabilitar Usuario (exclusao mutua)
            IF PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
                loc_oPagina.txt_4c_Usuario.Enabled = ;
                    EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao validar Grupo de Acesso: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarUsuarioAcess - Lookup de Usuario (Get_Usuario / SigCdUsu)
    * Mutualmente exclusivo com txt_4c_Grupo
    * Filtro: Not cAtivos='N' (apenas usuarios ativos)
    *==========================================================================
    PROCEDURE ValidarUsuarioAcess(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cUsuario, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_Usuario", 5)
            RETURN
        ENDIF
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        loc_cUsuario = ALLTRIM(loc_oPagina.txt_4c_Usuario.Value)

        IF EMPTY(loc_cUsuario)
            *-- Usuario limpo: habilitar Grupo novamente
            IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
                loc_oPagina.txt_4c_Grupo.Enabled = .T.
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", "cursor_4c_BuscaUsuario", "Usuarios", loc_cUsuario, ;
                "Usu" + CHR(225) + "rios")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaUsuario")
                        SELECT cursor_4c_BuscaUsuario
                        loc_oPagina.txt_4c_Usuario.Value = ALLTRIM(cursor_4c_BuscaUsuario.Usuarios)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Usuarios", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("CCargs",   "", "Cargo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsuario")
                        SELECT cursor_4c_BuscaUsuario
                        loc_oPagina.txt_4c_Usuario.Value = ALLTRIM(cursor_4c_BuscaUsuario.Usuarios)
                    ENDIF
                ELSE
                    loc_oPagina.txt_4c_Usuario.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaUsuario")
                USE IN cursor_4c_BuscaUsuario
            ENDIF

            *-- Se Usuario preenchido: desabilitar Grupo (exclusao mutua)
            IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
                loc_oPagina.txt_4c_Grupo.Enabled = ;
                    EMPTY(ALLTRIM(loc_oPagina.txt_4c_Usuario.Value))
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao validar Usu" + CHR(225) + "rio: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarGrContab - Lookup Grupo Contabil pelo codigo (Get_GrContab / SigCdGcr)
    * Ao confirmar, preenche tambem txt_4c_DGrContab com Descrs
    *==========================================================================
    PROCEDURE ValidarGrContab(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cCodigo, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
            RETURN
        ENDIF
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_GrContab.Value)

        IF EMPTY(loc_cCodigo)
            *-- Codigo limpo: habilitar DGrContab para busca pela descricao
            IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
                loc_oPagina.txt_4c_DGrContab.Value   = ""
                loc_oPagina.txt_4c_DGrContab.Enabled = .T.
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrContab", "Codigos", loc_cCodigo, ;
                "Grupo Cont" + CHR(225) + "bil")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGrContab")
                        SELECT cursor_4c_BuscaGrContab
                        loc_oPagina.txt_4c_GrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Codigos)
                        IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
                            loc_oPagina.txt_4c_DGrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Descrs)
                        ENDIF
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrContab")
                        SELECT cursor_4c_BuscaGrContab
                        loc_oPagina.txt_4c_GrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Codigos)
                        IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
                            loc_oPagina.txt_4c_DGrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Descrs)
                        ENDIF
                    ENDIF
                ELSE
                    loc_oPagina.txt_4c_GrContab.Value = ""
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
                        loc_oPagina.txt_4c_DGrContab.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrContab")
                USE IN cursor_4c_BuscaGrContab
            ENDIF

            *-- DGrContab: so editavel quando GrContab vazio
            IF PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
                loc_oPagina.txt_4c_DGrContab.Enabled = ;
                    EMPTY(ALLTRIM(loc_oPagina.txt_4c_GrContab.Value))
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao validar Grupo Cont" + CHR(225) + "bil: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarDGrContab - Lookup Grupo Contabil pela descricao (Get_DGrContab / SigCdGcr)
    * Ao confirmar, preenche tambem txt_4c_GrContab com Codigos
    *==========================================================================
    PROCEDURE ValidarDGrContab(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cDescr, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_DGrContab", 5)
            RETURN
        ENDIF
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        loc_cDescr = ALLTRIM(loc_oPagina.txt_4c_DGrContab.Value)

        IF EMPTY(loc_cDescr)
            IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
                loc_oPagina.txt_4c_GrContab.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrContab", "Descrs", loc_cDescr, ;
                "Grupo Cont" + CHR(225) + "bil")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGrContab")
                        SELECT cursor_4c_BuscaGrContab
                        loc_oPagina.txt_4c_DGrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Descrs)
                        IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
                            loc_oPagina.txt_4c_GrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Codigos)
                        ENDIF
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrContab")
                        SELECT cursor_4c_BuscaGrContab
                        loc_oPagina.txt_4c_DGrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Descrs)
                        IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
                            loc_oPagina.txt_4c_GrContab.Value = ALLTRIM(cursor_4c_BuscaGrContab.Codigos)
                        ENDIF
                    ENDIF
                ELSE
                    loc_oPagina.txt_4c_DGrContab.Value = ""
                    IF PEMSTATUS(loc_oPagina, "txt_4c_GrContab", 5)
                        loc_oPagina.txt_4c_GrContab.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrContab")
                USE IN cursor_4c_BuscaGrContab
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o Grupo Cont" + CHR(225) + ;
                "bil: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarGrConta - Lookup Grupo Conta Corrente pelo codigo (Get_GrConta / SigCdGcr)
    * Ao confirmar, preenche tambem txt_4c_DGrConta com Descrs
    * Habilita/desabilita DGrConta conforme mutuidade com GrConta
    *==========================================================================
    PROCEDURE ValidarGrConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cCodigo, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
            RETURN
        ENDIF
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)

        IF EMPTY(loc_cCodigo)
            *-- Codigo limpo: habilitar DGrConta para busca pela descricao
            IF PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
                loc_oPagina.txt_4c_DGrConta.Value   = ""
                loc_oPagina.txt_4c_DGrConta.Enabled = .T.
            ENDIF
            *-- Limpar CdConta e DCONTA pois dependem do grupo
            IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
                loc_oPagina.txt_4c_CdConta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
                loc_oPagina.txt_4c_DCONTA.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrConta", "Codigos", loc_cCodigo, ;
                "Grupo Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGrConta")
                        SELECT cursor_4c_BuscaGrConta
                        loc_oPagina.txt_4c_GrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Codigos)
                        IF PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
                            loc_oPagina.txt_4c_DGrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Descrs)
                        ENDIF
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrConta")
                        SELECT cursor_4c_BuscaGrConta
                        loc_oPagina.txt_4c_GrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Codigos)
                        IF PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
                            loc_oPagina.txt_4c_DGrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Descrs)
                        ENDIF
                    ENDIF
                ELSE
                    loc_oPagina.txt_4c_GrConta.Value = ""
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
                        loc_oPagina.txt_4c_DGrConta.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrConta")
                USE IN cursor_4c_BuscaGrConta
            ENDIF

            *-- DGrConta: so editavel quando GrConta vazio
            IF PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
                loc_oPagina.txt_4c_DGrConta.Enabled = ;
                    EMPTY(ALLTRIM(loc_oPagina.txt_4c_GrConta.Value))
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao validar Grupo Conta Corrente: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarDGrConta - Lookup Grupo Conta Corrente pela descricao (Get_DGrConta / SigCdGcr)
    * Ao confirmar, preenche tambem txt_4c_GrConta com Codigos
    *==========================================================================
    PROCEDURE ValidarDGrConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cDescr, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_DGrConta", 5)
            RETURN
        ENDIF
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        loc_cDescr = ALLTRIM(loc_oPagina.txt_4c_DGrConta.Value)

        IF EMPTY(loc_cDescr)
            IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
                loc_oPagina.txt_4c_GrConta.Value = ""
            ENDIF
            *-- Limpar CdConta e DCONTA pois dependem do grupo
            IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
                loc_oPagina.txt_4c_CdConta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
                loc_oPagina.txt_4c_DCONTA.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrConta", "Descrs", loc_cDescr, ;
                "Grupo Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGrConta")
                        SELECT cursor_4c_BuscaGrConta
                        loc_oPagina.txt_4c_DGrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Descrs)
                        IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
                            loc_oPagina.txt_4c_GrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Codigos)
                        ENDIF
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrConta")
                        SELECT cursor_4c_BuscaGrConta
                        loc_oPagina.txt_4c_DGrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Descrs)
                        IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
                            loc_oPagina.txt_4c_GrConta.Value = ALLTRIM(cursor_4c_BuscaGrConta.Codigos)
                        ENDIF
                    ENDIF
                ELSE
                    loc_oPagina.txt_4c_DGrConta.Value = ""
                    IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
                        loc_oPagina.txt_4c_GrConta.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrConta")
                USE IN cursor_4c_BuscaGrConta
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o Grupo Conta Corrente: " + ;
                loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarCdConta - Lookup Conta Corrente pelo codigo (Get_CdConta / SigCdCli)
    * Usa GrConta como filtro de grupo (equivalente a fAcessoContas modo 'C')
    * Ao confirmar, preenche txt_4c_DCONTA com RClis
    *==========================================================================
    PROCEDURE ValidarCdConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cCodigo, loc_cGrupo, loc_oBusca, loc_cFiltro
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
            RETURN
        ENDIF
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdConta.Value)
        loc_cGrupo  = ""

        IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
            loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)
        ENDIF

        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
                loc_oPagina.txt_4c_DCONTA.Value   = ""
                loc_oPagina.txt_4c_DCONTA.Enabled = .T.
            ENDIF
            RETURN
        ENDIF

        TRY
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "Grupos = " + EscaparSQL(loc_cGrupo)
            ELSE
                loc_cFiltro = ""
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaConta", "IClis", loc_cCodigo, ;
                "Conta Corrente", .T., .T., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaConta")
                        SELECT cursor_4c_BuscaConta
                        loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.IClis)
                        IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
                            loc_oPagina.txt_4c_DCONTA.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                        ENDIF
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("RClis", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                        SELECT cursor_4c_BuscaConta
                        loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.IClis)
                        IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
                            loc_oPagina.txt_4c_DCONTA.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                        ENDIF
                    ELSE
                        MsgAviso("Acesso Negado...", "Aviso")
                        loc_oPagina.txt_4c_CdConta.Value = ""
                        IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
                            loc_oPagina.txt_4c_DCONTA.Value = ""
                        ENDIF
                    ENDIF
                ELSE
                    MsgAviso("Acesso Negado...", "Aviso")
                    loc_oPagina.txt_4c_CdConta.Value = ""
                    IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
                        loc_oPagina.txt_4c_DCONTA.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            *-- DCONTA: so editavel quando CdConta vazio
            IF PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
                loc_oPagina.txt_4c_DCONTA.Enabled = ;
                    EMPTY(ALLTRIM(loc_oPagina.txt_4c_CdConta.Value))
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao validar Conta Corrente: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarDConta - Lookup Conta Corrente pela descricao (Get_DCONTA / SigCdCli)
    * Usa GrConta como filtro de grupo (equivalente a fAcessoContas modo 'D')
    * Ao confirmar, preenche txt_4c_CdConta com IClis
    *==========================================================================
    PROCEDURE ValidarDConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cDescr, loc_cGrupo, loc_oBusca, loc_cFiltro
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_DCONTA", 5)
            RETURN
        ENDIF
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        loc_cDescr = ALLTRIM(loc_oPagina.txt_4c_DCONTA.Value)
        loc_cGrupo = ""

        IF PEMSTATUS(loc_oPagina, "txt_4c_GrConta", 5)
            loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_GrConta.Value)
        ENDIF

        IF EMPTY(loc_cDescr)
            IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
                loc_oPagina.txt_4c_CdConta.Value = ""
            ENDIF
            RETURN
        ENDIF

        TRY
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "Grupos = " + EscaparSQL(loc_cGrupo)
            ELSE
                loc_cFiltro = ""
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaConta", "RClis", loc_cDescr, ;
                "Conta Corrente", .T., .T., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaConta")
                        SELECT cursor_4c_BuscaConta
                        loc_oPagina.txt_4c_DCONTA.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                        IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
                            loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.IClis)
                        ENDIF
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("RClis", "", "Nome")
                    loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                        SELECT cursor_4c_BuscaConta
                        loc_oPagina.txt_4c_DCONTA.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                        IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
                            loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.IClis)
                        ENDIF
                    ELSE
                        MsgAviso("Acesso Negado...", "Aviso")
                        loc_oPagina.txt_4c_DCONTA.Value = ""
                        IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
                            loc_oPagina.txt_4c_CdConta.Value = ""
                        ENDIF
                    ENDIF
                ELSE
                    MsgAviso("Acesso Negado...", "Aviso")
                    loc_oPagina.txt_4c_DCONTA.Value = ""
                    IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
                        loc_oPagina.txt_4c_CdConta.Value = ""
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o Conta Corrente: " + ;
                loc_oErro.Message, "Erro")
        ENDTRY
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

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGACGCTBO.prg):
*==============================================================================
* SIGACGCTBO.prg - Business Object: Acesso Lancamentos
* Tabela: SigSyAgc
* PK: cIdChaves (gerada por fUniqueIds)
*==============================================================================

DEFINE CLASS SIGACGCTBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (nao persistidas - configuradas no Init)
    *--------------------------------------------------------------------------
    this_cTabela     = "SigSyAgc"
    this_cCampoChave = "cIdChaves"

    *--------------------------------------------------------------------------
    * Campos da tabela SigSyAgc
    *--------------------------------------------------------------------------
    this_cIdChaves = ""    && PK (gerada por fUniqueIds)
    this_cGrAcess  = ""    && Grupo Acesso (FK -> SigCdAcG.Grupos)
    this_cUsuAcess = ""    && Usuario Acesso (FK -> SigCdUsu.Usuarios)
    this_cGrContbs = ""    && Grupo Contabil (FK -> SigCdGcr.Codigos)
    this_cGrContas = ""    && Grupo Conta Corrente (FK -> SigCdGcr.Codigos)
    this_cCdContas = ""    && Codigo Conta Corrente (FK -> SigCdCli.Iclis)

    *--------------------------------------------------------------------------
    * Campos de exibicao (nao persistidos na tabela - preenchidos via lookup)
    *--------------------------------------------------------------------------
    this_cDGrContb   = ""  && Descricao Grupo Contabil (SigCdGcr.Descrs)
    this_cDGrConta   = ""  && Descricao Grupo Conta Corrente (SigCdGcr.Descrs)
    this_cDConta     = ""  && Descricao Conta Corrente (SigCdCli.RClis)

    *==========================================================================
    * Init
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigSyAgc"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Para auditoria (override do BusinessBase)
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *==========================================================================
    * Buscar - Lista registros da tabela para o grid
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontbs," + ;
                       " grcontas, cdcontas" + ;
                       " FROM SigSyAgc" + ;
                       " ORDER BY gracess, usuacess"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontbs," + ;
                           " grcontas, cdcontas" + ;
                           " FROM SigSyAgc" + ;
                           " WHERE gracess LIKE " + EscaparSQL("%" + par_cFiltro + "%") + ;
                           " OR usuacess LIKE " + EscaparSQL("%" + par_cFiltro + "%") + ;
                           " ORDER BY gracess, usuacess"
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar acessos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo PK (cIdChaves)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cIdChaves, gracess, usuacess, grcontbs," + ;
                       " grcontas, cdcontas" + ;
                       " FROM SigSyAgc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades a partir de um cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves = TratarNulo(cIdChaves, "C")
            THIS.this_cGrAcess  = TratarNulo(gracess,   "C")
            THIS.this_cUsuAcess = TratarNulo(usuacess,  "C")
            THIS.this_cGrContbs = TratarNulo(grcontbs,  "C")
            THIS.this_cGrContas = TratarNulo(grcontas,  "C")
            THIS.this_cCdContas = TratarNulo(cdcontas,  "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDescricoes - Busca descricoes dos campos de lookup
    *==========================================================================
    PROCEDURE CarregarDescricoes()
        LOCAL loc_lResultado, loc_nRes
        loc_lResultado = .T.

        TRY
            IF USED("cursor_4c_Desc")
                USE IN cursor_4c_Desc
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cGrContbs))
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cGrContbs)), "cursor_4c_Desc")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Desc") > 0
                    SELECT cursor_4c_Desc
                    THIS.this_cDGrContb = TratarNulo(Descrs, "C")
                ELSE
                    THIS.this_cDGrContb = ""
                ENDIF
                IF USED("cursor_4c_Desc")
                    USE IN cursor_4c_Desc
                ENDIF
            ELSE
                THIS.this_cDGrContb = ""
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cGrContas))
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cGrContas)), "cursor_4c_Desc")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Desc") > 0
                    SELECT cursor_4c_Desc
                    THIS.this_cDGrConta = TratarNulo(Descrs, "C")
                ELSE
                    THIS.this_cDGrConta = ""
                ENDIF
                IF USED("cursor_4c_Desc")
                    USE IN cursor_4c_Desc
                ENDIF
            ELSE
                THIS.this_cDGrConta = ""
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cGrContas)) AND !EMPTY(ALLTRIM(THIS.this_cCdContas))
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT RClis FROM SigCdCli" + ;
                    " WHERE Grupos = " + EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + ;
                    " AND IClis = " + EscaparSQL(ALLTRIM(THIS.this_cCdContas)), ;
                    "cursor_4c_Desc")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Desc") > 0
                    SELECT cursor_4c_Desc
                    THIS.this_cDConta = TratarNulo(RClis, "C")
                ELSE
                    THIS.this_cDConta = ""
                ENDIF
                IF USED("cursor_4c_Desc")
                    USE IN cursor_4c_Desc
                ENDIF
            ELSE
                THIS.this_cDConta = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarDescricoes: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - INSERT na tabela SigSyAgc (PROTECTED - chamado pelo Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cPK
        loc_lResultado = .F.

        TRY
            loc_cPK = fUniqueIds()
            THIS.this_cIdChaves = loc_cPK

            loc_cSQL = "INSERT INTO SigSyAgc" + ;
                       " (cIdChaves, gracess, usuacess, grcontbs, grcontas, cdcontas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrAcess))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cUsuAcess)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrContbs)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCdContas)) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir acesso: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE na tabela SigSyAgc (PROTECTED - chamado pelo Salvar)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigSyAgc SET" + ;
                       " gracess  = " + EscaparSQL(ALLTRIM(THIS.this_cGrAcess))  + "," + ;
                       " usuacess = " + EscaparSQL(ALLTRIM(THIS.this_cUsuAcess)) + "," + ;
                       " grcontbs = " + EscaparSQL(ALLTRIM(THIS.this_cGrContbs)) + "," + ;
                       " grcontas = " + EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + "," + ;
                       " cdcontas = " + EscaparSQL(ALLTRIM(THIS.this_cCdContas)) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar acesso: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE na tabela SigSyAgc (PROTECTED - chamado por Excluir)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigSyAgc" + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir acesso: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se ja existe registro com a mesma chave composta
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lResultado = .F.
        loc_lDuplicado = .F.

        TRY
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_cSQL = "SELECT cIdChaves FROM SigSyAgc" + ;
                       " WHERE GrAcess  = " + EscaparSQL(ALLTRIM(THIS.this_cGrAcess))  + ;
                       " AND   UsuAcess = " + EscaparSQL(ALLTRIM(THIS.this_cUsuAcess)) + ;
                       " AND   GrContbs = " + EscaparSQL(ALLTRIM(THIS.this_cGrContbs)) + ;
                       " AND   GrContas = " + EscaparSQL(ALLTRIM(THIS.this_cGrContas)) + ;
                       " AND   CdContas = " + EscaparSQL(ALLTRIM(THIS.this_cCdContas))

            IF !THIS.this_lNovoRegistro
                loc_cSQL = loc_cSQL + ;
                    " AND cIdChaves <> " + EscaparSQL(THIS.this_cIdChaves)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")

            IF loc_nResultado >= 0
                loc_lDuplicado = (RECCOUNT("cursor_4c_Dup") > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_lResultado = loc_lDuplicado
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarDuplicidade: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

