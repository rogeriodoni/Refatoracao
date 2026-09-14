# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 56% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 429; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559; Teste 'BtnIncluirNavegacao': Unknown member THIS_OBUSINESSOBJECT. | Detalhes: Linha: 587, Proc: btnincluirclick

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-23 06:56:19] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-23 06:56:19] [INFO] Config FPW: (nao fornecido)
[2026-08-23 06:56:19] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-23 06:56:19] [INFO] Timeout: 300 segundos
[2026-08-23 06:56:19] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_t2sdupna.prg
[2026-08-23 06:56:19] [INFO] Conteudo do wrapper:
[2026-08-23 06:56:19] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormRec', 'C:\4c\tasks\task509', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormRec', 'C:\4c\tasks\task509', 'CRUD'
QUIT

[2026-08-23 06:56:19] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_t2sdupna.prg
[2026-08-23 06:56:19] [INFO] VFP output esperado em: C:\4c\tasks\task509\vfp_output.txt
[2026-08-23 06:56:19] [INFO] Executando Visual FoxPro 9...
[2026-08-23 06:56:19] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_t2sdupna.prg
[2026-08-23 06:56:19] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_t2sdupna.prg
[2026-08-23 06:56:19] [INFO] Timeout configurado: 300 segundos
[2026-08-23 06:57:58] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-23 06:57:58] [INFO] VFP9 finalizado em 98.9095303 segundos
[2026-08-23 06:57:58] [INFO] Exit Code: 
[2026-08-23 06:57:58] [INFO] 
[2026-08-23 06:57:58] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-23 06:57:58] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_t2sdupna.prg
[2026-08-23 06:57:58] [INFO] 
[2026-08-23 06:57:58] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-23 06:57:58] [INFO] * Auto-generated wrapper for parameters
[2026-08-23 06:57:58] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-23 06:57:58] [INFO] * Parameters: 'FormRec', 'C:\4c\tasks\task509', 'CRUD'
[2026-08-23 06:57:58] [INFO] 
[2026-08-23 06:57:58] [INFO] * Anti-dialog protections for unattended execution
[2026-08-23 06:57:58] [INFO] SET SAFETY OFF
[2026-08-23 06:57:58] [INFO] SET RESOURCE OFF
[2026-08-23 06:57:58] [INFO] SET TALK OFF
[2026-08-23 06:57:58] [INFO] SET NOTIFY OFF
[2026-08-23 06:57:58] [INFO] SYS(2335, 0)
[2026-08-23 06:57:58] [INFO] 
[2026-08-23 06:57:58] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormRec', 'C:\4c\tasks\task509', 'CRUD'
[2026-08-23 06:57:58] [INFO] QUIT
[2026-08-23 06:57:58] [INFO] 
[2026-08-23 06:57:58] [INFO] === Fim do Wrapper.prg ===
[2026-08-23 06:57:58] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormRec",
  "timestamp": "20260823065758",
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
      "passou": false,
      "erro": "Unknown member THIS_OBUSINESSOBJECT.",
      "detalhes": "Linha: 587, Proc: btnincluirclick"
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 3 (CDGRUPOKEYPRESS, DSGRUPOKEYPRESS, KEYPRESS)"
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
    "passou": 5,
    "falhou": 4,
    "percentual": 56
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRec.prg):
*==============================================================================
* FormRec.prg - Formulario de Cadastro Financeiro de Recebimentos
* Migrado de: SIGCDREC (frmcadastro)
* Tabela: SIGCDREC
* Chave: grupos char(10) - FK -> SigCdGcr.codigos
*==============================================================================

DEFINE CLASS FormRec AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro Financeiro de Recebimentos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado pelo FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ELSE
                THIS.this_oBusinessObject = CREATEOBJECT("RecBO")

                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    MostrarErro("Erro ao criar RecBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "FormRec.InicializarForm")
                ELSE
                    THIS.ConfigurarPageFrame()

                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                    THIS.pgf_4c_Paginas.Visible   = .T.
                    THIS.pgf_4c_Paginas.ActivePage = 1
                    THIS.this_cModoAtual = "LISTA"

                    THIS.CarregarLista()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormRec:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRec.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame (Top=-29 esconde abas)
    * Todos os controles dentro das Pages compensam +29 no Top
    *==========================================================================
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

    *==========================================================================
    * ConfigurarPaginaLista - Page1: Cabecalho + Botoes CRUD + Grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho - Top=30 (1+29 compensacao PageFrame)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
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
            .Width     = THIS.Width - 20
            .Height    = 46
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

        *-- Container botoes CRUD - canonico Left=542, Top=29 (0+29 compensacao)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
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
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - valores canonicos CLAUDE.md regra #10
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
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem: Top=117 (88+29), Left=26, Width=890, Height=498
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 498
            .ColumnCount        = 2
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
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: Botoes Confirmar/Cancelar + campos do form
    * Campos: txt_4c_CdGrupo (codigos char(10)) + txt_4c_DsGrupo (descrs char(40))
    * Legado: get_cd_grupo (top=193, left=253) e get_ds_grupo (top=193, left=335)
    * Compensacao PageFrame +29: todos os tops recebem +29
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar - Top=33 (4+29 compensacao PageFrame)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
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
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label titulo secao (lbl_cadastro legado: top=175, left=255; compensado +29=204)
        loc_oPagina.AddObject("lbl_4c_Cadastro", "Label")
        WITH loc_oPagina.lbl_4c_Cadastro
            .Caption   = "Cadastro de Contas a Receber"
            .Top       = 204
            .Left      = 255
            .Width     = 280
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Grupo :" (lbl_grupo legado: top=198, left=206, width=38; compensado +29=227)
        loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPagina.lbl_4c_Grupo
            .Caption   = "Grupo :"
            .Top       = 227
            .Left      = 206
            .Width     = 38
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo do Grupo (get_cd_grupo legado: top=193,left=253,w=79,h=23; +29=222)
        *-- SigCdGcr.codigos char(10); editavel apenas no modo INCLUIR (get_cd_grupo.When)
        loc_oPagina.AddObject("txt_4c_CdGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_CdGrupo
            .Value     = ""
            .Top       = 222
            .Left      = 253
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 10
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "KeyPress", THIS, "ValidarCodigo")
        BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "KeyPress", THIS, "CdGrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "DblClick", THIS, "CdGrupoDblClick")

        *-- TextBox Descricao do Grupo (get_ds_grupo legado: top=193,left=335,w=150,h=23; +29=222)
        *-- SigCdGcr.descrs char(40); editavel apenas no modo INCLUIR (get_ds_grupo.When)
        loc_oPagina.AddObject("txt_4c_DsGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DsGrupo
            .Value     = ""
            .Top       = 222
            .Left      = 335
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 40
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsGrupo, "KeyPress", THIS, "ValidarDescricao")
        BINDEVENT(loc_oPagina.txt_4c_DsGrupo, "KeyPress", THIS, "DsGrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DsGrupo, "DblClick", THIS, "DsGrupoDblClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega cursor_4c_Dados no Grid da Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource e ColumnCount FORA do WITH (Problema 36)
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 2

                    WITH loc_oGrid
                        .Column1.ControlSource   = "cursor_4c_Dados.grupos"
                        .Column1.Width           = 100
                        .Column1.Header1.Caption = "Grupo"

                        .Column2.ControlSource   = "cursor_4c_Dados.descrs"
                        .Column2.Width           = 780
                        .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ELSE
                    loc_lResultado = .F.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Aplica formatacao visual ao grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1=Lista(1) e Page2=Dados(2)
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
    * BtnEncerrarClick - Fecha o formulario (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia inclusao de novo registro (PUBLIC para BINDEVENT)
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
    * BtnVisualizarClick - Visualiza registro selecionado (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cGrupo
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Visualizar")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cGrupo = ALLTRIM(cursor_4c_Dados.grupos)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Edita registro selecionado (PUBLIC para BINDEVENT)
    * Legado: em ALTERAR, campos ficam somente leitura (legado nao habilitava edicao)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cGrupo
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Alterar")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cGrupo = ALLTRIM(cursor_4c_Dados.grupos)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cGrupo, loc_lConfirma
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Excluir")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cGrupo = ALLTRIM(cursor_4c_Dados.grupos)
        loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo '" + ;
            loc_cGrupo + "'?", "Excluir Recebimento")
        IF loc_lConfirma
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Localiza registro via FormBuscaAuxiliar (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cGrupo, loc_lSelecionou
        loc_lSelecionou = .F.
        loc_cGrupo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SIGCDREC", "cursor_4c_BuscaRec", "grupos", "", ;
                "Buscar Recebimento")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("grupos", "", "Grupo")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRec")
                    SELECT cursor_4c_BuscaRec
                    loc_cGrupo      = ALLTRIM(cursor_4c_BuscaRec.grupos)
                    loc_lSelecionou = .T.
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro na busca:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaRec")
            USE IN cursor_4c_BuscaRec
        ENDIF

        IF loc_lSelecionou AND USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            LOCATE FOR ALLTRIM(grupos) = loc_cGrupo
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva o registro (PUBLIC para BINDEVENT, chamado de Page2)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        *-- Validacao ANTES do TRY (CLAUDE.md regra critica)
        IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CdGrupo.Value))
            MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_Paginas.Page2.txt_4c_CdGrupo.SetFocus()
            RETURN loc_lSucesso
        ENDIF

        *-- Verificar duplicidade apenas no INCLUIR (legado: ChkRegister)
        IF THIS.this_cModoAtual = "INCLUIR"
            IF THIS.this_oBusinessObject.VerificarCodigoExiste( ;
                ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CdGrupo.Value))
                MsgAviso("Grupo j" + CHR(225) + " cadastrado!", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                THIS.pgf_4c_Paginas.Page2.txt_4c_CdGrupo.SetFocus()
                RETURN loc_lSucesso
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Salvar")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta a lista (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere campos do form para o BO antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cGrupos = ALLTRIM(loc_oPagina.txt_4c_CdGrupo.Value)
        THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPagina.txt_4c_DsGrupo.Value)
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos do form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_CdGrupo.Value = THIS.this_oBusinessObject.this_cGrupos
        loc_oPagina.txt_4c_DsGrupo.Value = THIS.this_oBusinessObject.this_cDescrs
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores dos campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_CdGrupo.Value = ""
        loc_oPagina.txt_4c_DsGrupo.Value = ""
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos por modo
    * Legado: get_cd_grupo.When = INSERIR|PROCURAR; get_ds_grupo.When = INSERIR
    * Ambos os campos somente editaveis em INCLUIR
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_CdGrupo.ReadOnly = !(THIS.this_cModoAtual = "INCLUIR")
        loc_oPagina.txt_4c_DsGrupo.ReadOnly = !(THIS.this_cModoAtual = "INCLUIR")
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta botoes da Page2 conforme modo atual
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        DO CASE
            CASE THIS.this_cModoAtual = "VISUALIZAR"
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            OTHERWISE
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ENDCASE
    ENDPROC

    *==========================================================================
    * CdGrupoKeyPress - F4 em txt_4c_CdGrupo abre lookup SigCdGcr
    * PUBLIC obrigatorio: BINDEVENT requer PUBLIC (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE CdGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4 em VFP9
            THIS.AbrirBuscaGrupo("")
        ENDIF
    ENDPROC

    *==========================================================================
    * CdGrupoDblClick - DblClick em txt_4c_CdGrupo abre lookup SigCdGcr
    * PUBLIC obrigatorio: BINDEVENT requer PUBLIC (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE CdGrupoDblClick()
        THIS.AbrirBuscaGrupo("")
    ENDPROC

    *==========================================================================
    * DsGrupoKeyPress - F4 em txt_4c_DsGrupo abre lookup SigCdGcr por descricao
    * PUBLIC obrigatorio: BINDEVENT requer PUBLIC (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE DsGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDesc
        IF par_nKeyCode = 28  && F4 em VFP9
            loc_cDesc = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DsGrupo.Value)
            THIS.AbrirBuscaGrupo(loc_cDesc)
        ENDIF
    ENDPROC

    *==========================================================================
    * DsGrupoDblClick - DblClick em txt_4c_DsGrupo abre lookup SigCdGcr por descricao
    * PUBLIC obrigatorio: BINDEVENT requer PUBLIC (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE DsGrupoDblClick()
        LOCAL loc_cDesc
        loc_cDesc = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DsGrupo.Value)
        THIS.AbrirBuscaGrupo(loc_cDesc)
    ENDPROC

    *==========================================================================
    * ValidarCodigo - LostFocus de txt_4c_CdGrupo: busca descricao em SigCdGcr
    * Equivale a get_cd_grupo.Valid (fAcessoContab 'C') do legado
    * PUBLIC obrigatorio: BINDEVENT requer metodo PUBLIC (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE ValidarCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCodigo, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGrupo.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPagina.txt_4c_DsGrupo.Value = ""
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.BuscarGrupoGcr(loc_cCodigo, "C")
            IF USED("cursor_4c_BuscaGcr") AND RECCOUNT("cursor_4c_BuscaGcr") > 0
                SELECT cursor_4c_BuscaGcr
                IF ALLTRIM(UPPER(cursor_4c_BuscaGcr.grupos)) = UPPER(loc_cCodigo)
                    loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                ELSE
                    THIS.AbrirBuscaGrupo(loc_cCodigo)
                ENDIF
            ELSE
                THIS.AbrirBuscaGrupo(loc_cCodigo)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDescricao - LostFocus de txt_4c_DsGrupo: busca codigo em SigCdGcr
    * Equivale a get_ds_grupo.Valid (fAcessoContab 'D') do legado
    * PUBLIC obrigatorio: BINDEVENT requer metodo PUBLIC (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE ValidarDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDesc, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cDesc = ALLTRIM(loc_oPagina.txt_4c_DsGrupo.Value)

        IF EMPTY(loc_cDesc)
            loc_oPagina.txt_4c_CdGrupo.Value = ""
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.BuscarGrupoGcr(loc_cDesc, "D")
            IF USED("cursor_4c_BuscaGcr") AND RECCOUNT("cursor_4c_BuscaGcr") > 0
                SELECT cursor_4c_BuscaGcr
                IF RECCOUNT("cursor_4c_BuscaGcr") = 1
                    loc_oPagina.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.grupos)
                    loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                ELSE
                    THIS.AbrirBuscaGrupo(loc_cDesc)
                ENDIF
            ELSE
                THIS.AbrirBuscaGrupo(loc_cDesc)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaGrupo - Abre FormBuscaAuxiliar para selecao em SigCdGcr
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaGrupo(par_cFiltro)
        LOCAL loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "grupos", par_cFiltro, ;
                "Selecionar Grupo Cont" + CHR(225) + "bil")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("grupos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    loc_oPagina.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.grupos)
                    loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                ELSE
                    loc_oPagina.txt_4c_CdGrupo.Value = ""
                    loc_oPagina.txt_4c_DsGrupo.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao abrir busca de grupo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Necessario pois AddObject() cria controles com Visible=.F. por padrao
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
    * Destroy - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\RecBO.prg):
*====================================================================
* RecBO.prg
*
* Business Object para Cadastro Financeiro de Recebimentos
* Tabela: SIGCDREC
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS RecBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SIGCDREC)
    this_cGrupos    = ""    && grupos char(10) - PK (FK -> SigCdGcr.codigos)
    this_cDescrs    = ""    && descrs char(20)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SIGCDREC"
            THIS.this_cCampoChave = "grupos"
            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro ao inicializar RecBO:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna PK atual para auditoria (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cGrupos
    ENDFUNC

    *====================================================================
    * Buscar - SELECT todos os registros (PUBLIC)
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT grupos, descrs" + ;
                       " FROM SIGCDREC" + ;
                       " ORDER BY grupos"

            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar recebimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar recebimentos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pelo PK (PUBLIC)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cGrupos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT grupos, descrs" + ;
                       " FROM SIGCDREC" + ;
                       " WHERE grupos = " + EscaparSQL(par_cGrupos)

            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos = TratarNulo(grupos, "C")
            THIS.this_cDescrs = TratarNulo(descrs, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Inserir - INSERT na tabela SIGCDREC (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SIGCDREC (grupos, descrs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cGrupos) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Atualizar - UPDATE na tabela SIGCDREC (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDREC SET" + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescrs) + ;
                       " WHERE grupos = " + EscaparSQL(THIS.this_cGrupos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - DELETE na tabela SIGCDREC (PROTECTED)
    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCDREC" + ;
                       " WHERE grupos = " + EscaparSQL(THIS.this_cGrupos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir recebimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir recebimento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * ValidarDados - Valida regras de negocio antes de salvar (PUBLIC)
    *====================================================================
    FUNCTION ValidarDados()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF EMPTY(ALLTRIM(THIS.this_cGrupos))
            MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * VerificarCodigoExiste - Verifica se grupo ja cadastrado em SIGCDREC (PUBLIC)
    * Equivalente ao ChkRegister('SigCdRec','grupos',...) do legado
    *====================================================================
    FUNCTION VerificarCodigoExiste(par_cGrupos)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT grupos FROM SIGCDREC" + ;
                       " WHERE grupos = " + EscaparSQL(par_cGrupos)

            IF USED("cursor_4c_ChkCod")
                TABLEREVERT(.T., "cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkCod") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *====================================================================
    * BuscarGrupoGcr - Busca grupo em SigCdGcr por codigo ou descricao (PUBLIC)
    * Equivalente ao fAcessoContab() do legado
    * par_cTipo = 'C' busca por codigo, 'D' busca por descricao
    *====================================================================
    FUNCTION BuscarGrupoGcr(par_cValor, par_cTipo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF par_cTipo = "C"
                loc_cSQL = "SELECT grupos, descrs FROM SigCdGcr" + ;
                           " WHERE grupos = " + EscaparSQL(par_cValor) + ;
                           " ORDER BY grupos"
            ELSE
                loc_cSQL = "SELECT grupos, descrs FROM SigCdGcr" + ;
                           " WHERE grupos LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%") + ;
                           " ORDER BY grupos"
            ENDIF

            IF USED("cursor_4c_BuscaGcr")
                TABLEREVERT(.T., "cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Destroy - Libera cursores
    *====================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_ChkCod")
            USE IN cursor_4c_ChkCod
        ENDIF
        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

