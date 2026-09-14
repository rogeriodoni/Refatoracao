# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 429; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[22/08/2026 13:12:12] Erro: Connection handle is invalid.
[22/08/2026 13:12:12] Erro: Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-22 13:10:46] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-22 13:10:46] [INFO] Config FPW: (nao fornecido)
[2026-08-22 13:10:46] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 13:10:46] [INFO] Timeout: 300 segundos
[2026-08-22 13:10:46] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oqlnl2md.prg
[2026-08-22 13:10:46] [INFO] Conteudo do wrapper:
[2026-08-22 13:10:46] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormOrc', 'C:\4c\tasks\task489', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormOrc', 'C:\4c\tasks\task489', 'CRUD'
QUIT

[2026-08-22 13:10:46] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oqlnl2md.prg
[2026-08-22 13:10:46] [INFO] VFP output esperado em: C:\4c\tasks\task489\vfp_output.txt
[2026-08-22 13:10:46] [INFO] Executando Visual FoxPro 9...
[2026-08-22 13:10:46] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oqlnl2md.prg
[2026-08-22 13:10:46] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oqlnl2md.prg
[2026-08-22 13:10:46] [INFO] Timeout configurado: 300 segundos
[2026-08-22 13:12:12] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-22 13:12:12] [INFO] VFP9 finalizado em 86.3546144 segundos
[2026-08-22 13:12:12] [INFO] Exit Code: 
[2026-08-22 13:12:12] [INFO] 
[2026-08-22 13:12:12] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-22 13:12:12] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_oqlnl2md.prg
[2026-08-22 13:12:12] [INFO] 
[2026-08-22 13:12:12] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-22 13:12:12] [INFO] * Auto-generated wrapper for parameters
[2026-08-22 13:12:12] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 13:12:12] [INFO] * Parameters: 'FormOrc', 'C:\4c\tasks\task489', 'CRUD'
[2026-08-22 13:12:12] [INFO] 
[2026-08-22 13:12:12] [INFO] * Anti-dialog protections for unattended execution
[2026-08-22 13:12:12] [INFO] SET SAFETY OFF
[2026-08-22 13:12:12] [INFO] SET RESOURCE OFF
[2026-08-22 13:12:12] [INFO] SET TALK OFF
[2026-08-22 13:12:12] [INFO] SET NOTIFY OFF
[2026-08-22 13:12:12] [INFO] SYS(2335, 0)
[2026-08-22 13:12:12] [INFO] 
[2026-08-22 13:12:12] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormOrc', 'C:\4c\tasks\task489', 'CRUD'
[2026-08-22 13:12:12] [INFO] QUIT
[2026-08-22 13:12:12] [INFO] 
[2026-08-22 13:12:12] [INFO] === Fim do Wrapper.prg ===
[2026-08-22 13:12:12] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormOrc",
  "timestamp": "20260822131212",
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
      "detalhes": "AbrirLookup: 2 (ABRIRLOOKUPCANONICO, ABRIRLOOKUPMOEDA) | KeyPress handlers: 1 (KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOrc.prg):
*==============================================================================
* FormOrc.prg - Formulario de Cadastro de Orcamento/Previsao
* Migrado de: SIGCDORC.SCX (frmcadastro)
* Tabela: SigCdMrp (chave composta: cEmps+cMes+cAno+cTitulo+Moeda)
*==============================================================================

DEFINE CLASS FormOrc AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Orcamento"
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

    *-- Controle de ultimo valor validado (evitar revalidacao no LostFocus)
    this_cUltimaEmpValidada   = ""
    this_cUltimoMesValidado   = ""
    this_cUltimoAnoValidado   = ""
    this_cUltimaMoedaValidada = ""

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar!
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
            THIS.Caption = "Or" + CHR(231) + "amento"

            THIS.this_oBusinessObject = CREATEOBJECT("OrcBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar OrcBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormOrc.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormOrc:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormOrc.InicializarForm")
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
    * ConfigurarPaginaLista - Configura Page1: Grid de lista + botoes CRUD
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado, Top=1+29=30)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 30
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
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
        ENDWITH

        *-- Container Botoes CRUD (Grupo_Op no legado, Top=0+29=29)
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        *-- Container Saida canonico (Left=917, Width=90, cmd Width=75)
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
        ENDWITH

        *-- Botao Copiar (cmdCopiar legado: Top=78+29=107, Left=614, W=115, H=55)
        loc_oPagina.AddObject("cmd_4c_Copiar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Copiar
            .Caption         = "Copiar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 107
            .Left            = 614
            .Width           = 115
            .Height          = 55
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
        ENDWITH

        *-- Grid de orcamentos (Top=117, abaixo do bloco cabecalho+botoes)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 4
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 450
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
            .ReadOnly           = .T.
            .GridLines          = 3
        ENDWITH

        WITH loc_oPagina.grd_4c_Lista
            .Column1.Header1.Caption = "Empresa"
            .Column1.Width           = 45

            .Column2.Header1.Caption = "M" + CHR(234) + "s/Ano"
            .Column2.Width           = 59

            .Column3.Header1.Caption = "Titulo"
            .Column3.Width           = 290

            .Column4.Header1.Caption = "Moeda"
            .Column4.Width           = 40
        ENDWITH

        *-- BINDEVENTs dos botoes (PUBLIC methods - sem PROTECTED)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.cmd_4c_Copiar,                   "Click", THIS, "BtnCopiarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2: botoes + campos cabecalho
    * Fase 5: Container BotoesAcao + Labels/TextBoxes do cabecalho
    * Fase 6: Total Orcado + Grids Grupos/Contas + Total Lancado
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes acao (Confirmar/Cancelar)
        *-- Original: Grupo_Salva.Top=4. Com compensacao +29: Top=33
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        *-- Label "Emp:" (Say6 - Top=164+29=193, Left=32)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Emp:"
            .Top       = 193
            .Left      = 32
            .Width     = 30
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox Empresa (Get_Emps - Top=160+29=189, Left=65, Width=31, Height=23)
        loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPagina.txt_4c_Emps
            .Value     = ""
            .Top       = 189
            .Left      = 65
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
        ENDWITH

        *-- Label "Mes:" (Say1 - Top=165+29=194, Left=104)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "M" + CHR(234) + "s:"
            .Top       = 194
            .Left      = 104
            .Width     = 26
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox Mes (Get_Mes - Top=160+29=189, Left=133, Width=24, Height=23)
        loc_oPagina.AddObject("txt_4c_Mes", "TextBox")
        WITH loc_oPagina.txt_4c_Mes
            .Value     = ""
            .Top       = 189
            .Left      = 133
            .Width     = 24
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 2
        ENDWITH

        *-- Label "Ano:" (Say4 - Top=165+29=194, Left=165)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Ano:"
            .Top       = 194
            .Left      = 165
            .Width     = 26
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox Ano (Get_Ano - Top=160+29=189, Left=193, Width=38, Height=23)
        loc_oPagina.AddObject("txt_4c_Ano", "TextBox")
        WITH loc_oPagina.txt_4c_Ano
            .Value     = ""
            .Top       = 189
            .Left      = 193
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 4
        ENDWITH

        *-- Label "Titulo :" (Say5 - Top=165+29=194, Left=238)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "T" + CHR(237) + "tulo :"
            .Top       = 194
            .Left      = 238
            .Width     = 38
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox Titulo (Get_Titulo - Top=160+29=189, Left=278, Width=280, Height=23)
        loc_oPagina.AddObject("txt_4c_Titulo", "TextBox")
        WITH loc_oPagina.txt_4c_Titulo
            .Value     = ""
            .Top       = 189
            .Left      = 278
            .Width     = 280
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 40
        ENDWITH

        *-- Label "Moeda :" (lbl_moeda - Top=165+29=194, Left=563, Width=41)
        loc_oPagina.AddObject("lbl_4c_Lbl_moeda", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_moeda
            .Caption   = "Moeda :"
            .Top       = 194
            .Left      = 563
            .Width     = 41
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox Codigo Moeda (Get_cd_Moeda - Top=160+29=189, Left=609, Width=31, Height=23)
        loc_oPagina.AddObject("txt_4c_Cd_Moeda", "TextBox")
        WITH loc_oPagina.txt_4c_Cd_Moeda
            .Value     = ""
            .Top       = 189
            .Left      = 609
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
        ENDWITH

        *-- TextBox Descricao Moeda (get_ds_moeda - Top=160+29=189, Left=643, Width=115, Height=23)
        loc_oPagina.AddObject("txt_4c__ds_moeda", "TextBox")
        WITH loc_oPagina.txt_4c__ds_moeda
            .Value     = ""
            .Top       = 189
            .Left      = 643
            .Width     = 115
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 40
        ENDWITH

        *-- Label "Total Orcado :" (Say7 - Top=192+29=221, Left=50, Height=15)
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Total Or" + CHR(231) + "ado :"
            .Top       = 221
            .Left      = 50
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox Total Orcado (get_nVlTots - Top=187+29=216, Left=132, Width=135, H=23)
        loc_oPagina.AddObject("txt_4c__nVlTots", "TextBox")
        WITH loc_oPagina.txt_4c__nVlTots
            .Value     = 0
            .Top       = 216
            .Left      = 132
            .Width     = 135
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999,999,999.99"
        ENDWITH

        *-- Label "Grupos" (Say2 - Top=214+29=243, Left=35, Width=54, Height=18)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Grupos"
            .Top       = 243
            .Left      = 35
            .Width     = 54
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- Grid Grupos (grd_Grupos - Top=233+29=262, Left=36, Width=719, Height=116)
        loc_oPagina.AddObject("grd_4c_Grupos", "Grid")
        loc_oPagina.grd_4c_Grupos.RecordSource = ""
        loc_oPagina.grd_4c_Grupos.ColumnCount  = 4
        WITH loc_oPagina.grd_4c_Grupos
            .Top                = 262
            .Left               = 36
            .Width              = 719
            .Height             = 116
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
            .Column1.Header1.Caption = "Grupo"
            .Column1.Width           = 80
            .Column1.ReadOnly        = .T.
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width           = 300
            .Column2.ReadOnly        = .T.
            .Column3.Header1.Caption = "Valor"
            .Column3.Width           = 170
            .Column3.Alignment       = 1
            .Column4.Header1.Caption = "%"
            .Column4.Width           = 100
            .Column4.Alignment       = 1
        ENDWITH

        *-- Label "Contas" (Say3 - Top=362+29=391, Left=39, Width=54, Height=18)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Contas"
            .Top       = 391
            .Left      = 39
            .Width     = 54
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- Grid Contas (grd_Contas - Top=380+29=409, Left=36, Width=719, Height=132)
        loc_oPagina.AddObject("grd_4c_Contas", "Grid")
        loc_oPagina.grd_4c_Contas.RecordSource = ""
        loc_oPagina.grd_4c_Contas.ColumnCount  = 4
        WITH loc_oPagina.grd_4c_Contas
            .Top                = 409
            .Left               = 36
            .Width              = 719
            .Height             = 132
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
            .Column1.Header1.Caption = "Conta"
            .Column1.Width           = 80
            .Column1.ReadOnly        = .T.
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width           = 300
            .Column2.ReadOnly        = .T.
            .Column3.Header1.Caption = "Valor"
            .Column3.Width           = 170
            .Column3.Alignment       = 1
            .Column4.Header1.Caption = "%"
            .Column4.Width           = 100
            .Column4.Alignment       = 1
        ENDWITH

        *-- Label "Total Lancado :" (Say8 - Top=528+29=557, Left=399, Width=87)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Total Lan" + CHR(231) + "ado :"
            .Top       = 557
            .Left      = 399
            .Width     = 87
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox Total Lancado (getTotLancado - Top=523+29=552, Left=488, Width=125, ReadOnly)
        loc_oPagina.AddObject("txt_4c_TotLancado", "TextBox")
        WITH loc_oPagina.txt_4c_TotLancado
            .Value     = 0
            .Top       = 552
            .Left      = 488
            .Width     = 125
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .InputMask = "999,999,999.99"
        ENDWITH

        *-- BINDEVENTs de validacao dos campos do cabecalho
        BINDEVENT(loc_oPagina.txt_4c_Emps,     "KeyPress", THIS, "ValidarEmps")
        BINDEVENT(loc_oPagina.txt_4c_Mes,       "KeyPress", THIS, "ValidarMes")
        BINDEVENT(loc_oPagina.txt_4c_Ano,       "KeyPress", THIS, "ValidarAno")
        BINDEVENT(loc_oPagina.txt_4c_Cd_Moeda,  "KeyPress", THIS, "ValidarMoedaCodigo")
        BINDEVENT(loc_oPagina.txt_4c__ds_moeda, "KeyPress", THIS, "ValidarMoedaDesc")
        BINDEVENT(loc_oPagina.txt_4c__nVlTots,  "KeyPress", THIS, "VlTotsLostFocus")
        BINDEVENT(loc_oPagina.grd_4c_Grupos,    "AfterRowColChange", THIS, "GruposAfterRowColChange")
        BINDEVENT(loc_oPagina.grd_4c_Contas,    "AfterRowColChange", THIS, "ContasAfterRowColChange")

        *-- BINDEVENTs dos botoes Page2
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Busca orcamentos e vincula cursor ao grid da Page1
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF !THIS.this_oBusinessObject.Buscar("")
                    MsgErro("Erro ao carregar or" + CHR(231) + "amentos.", "Erro")
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid.ColumnCount = 4
                    loc_oGrid.RecordSource          = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cemps"
                    loc_oGrid.Column2.ControlSource = [ALLTRIM(cursor_4c_Dados.cmes) + IIF(!EMPTY(cursor_4c_Dados.cmes), "/", "") + ALLTRIM(cursor_4c_Dados.cano)]
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.ctitulo"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.moeda"

                    *-- Reconfigurar cabecalhos apos RecordSource (obrigatorio - RecordSource reseta)
                    loc_oGrid.Column1.Header1.Caption = "Empresa"
                    loc_oGrid.Column2.Header1.Caption = "M" + CHR(234) + "s/Ano"
                    loc_oGrid.Column3.Header1.Caption = "Titulo"
                    loc_oGrid.Column4.Header1.Caption = "Moeda"

                    loc_oGrid.Column1.Width = 45
                    loc_oGrid.Column2.Width = 59
                    loc_oGrid.Column3.Width = 290
                    loc_oGrid.Column4.Width = 40

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "FormOrc.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *===========================================================================
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
        CATCH TO loException
            MostrarErro(loException, "FormOrc.AlternarPagina")
            loc_lResultado = .F.
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
    * BtnIncluirClick - Prepara novo orcamento e vai para Page2
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_oBusinessObject.BuscarGrupos()
        THIS.this_oBusinessObject.BuscarContas()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.AjustarBotoesPorModo()
        THIS.HabilitarCampos(.T.)
        THIS.ConfigurarGridsDetalhe()
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega orcamento selecionado para visualizacao
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cIdChaves
        loc_cIdChaves = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cIdChaves = ALLTRIM(cidchaves)
        ENDIF

        IF EMPTY(loc_cIdChaves)
            MsgAviso("Selecione um or" + CHR(231) + "amento para visualizar.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
            THIS.this_oBusinessObject.BuscarGrupos()
            THIS.this_oBusinessObject.BuscarContas()
            THIS.this_oBusinessObject.CarregarDetalhe()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.AjustarBotoesPorModo()
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega orcamento selecionado para edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cIdChaves
        loc_cIdChaves = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cIdChaves = ALLTRIM(cidchaves)
        ENDIF

        IF EMPTY(loc_cIdChaves)
            MsgAviso("Selecione um or" + CHR(231) + "amento para alterar.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
            THIS.this_oBusinessObject.BuscarGrupos()
            THIS.this_oBusinessObject.BuscarContas()
            THIS.this_oBusinessObject.CarregarDetalhe()
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.AjustarBotoesPorModo()
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui orcamento selecionado apos confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cIdChaves, loc_cDescricao, loc_lConfirma
        loc_cIdChaves = ""
        loc_cDescricao = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cIdChaves  = ALLTRIM(cidchaves)
            loc_cDescricao = ALLTRIM(ctitulo) + " (" + ALLTRIM(cmes) + "/" + ALLTRIM(cano) + ")"
        ENDIF

        IF EMPTY(loc_cIdChaves)
            MsgAviso("Selecione um or" + CHR(231) + "amento para excluir.", "Aviso")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o:" + CHR(13) + ;
            loc_cDescricao, "Confirmar Exclus" + CHR(227) + "o")

        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Or" + CHR(231) + "amento exclu" + CHR(237) + "do com sucesso.", "Sucesso")
                THIS.CarregarLista()
            ELSE
                MsgErro("Erro ao excluir or" + CHR(231) + "amento.", "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Filtra lista de orcamentos por titulo
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cBusca, loc_cFiltro, loc_oGrid
        loc_cBusca = INPUTBOX("T" + CHR(237) + "tulo para filtrar:", "Buscar Or" + CHR(231) + "amento", "")

        IF EMPTY(ALLTRIM(loc_cBusca))
            THIS.CarregarLista()
            RETURN
        ENDIF

        loc_cFiltro = "ctitulo LIKE " + EscaparSQL("%" + ALLTRIM(loc_cBusca) + "%")
        IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
            loc_oGrid.ColumnCount = 4
            loc_oGrid.RecordSource          = "cursor_4c_Dados"
            loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cemps"
            loc_oGrid.Column2.ControlSource = [ALLTRIM(cursor_4c_Dados.cmes) + IIF(!EMPTY(cursor_4c_Dados.cmes), "/", "") + ALLTRIM(cursor_4c_Dados.cano)]
            loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.ctitulo"
            loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.moeda"
            loc_oGrid.Column1.Header1.Caption = "Empresa"
            loc_oGrid.Column2.Header1.Caption = "M" + CHR(234) + "s/Ano"
            loc_oGrid.Column3.Header1.Caption = "Titulo"
            loc_oGrid.Column4.Header1.Caption = "Moeda"
            loc_oGrid.Refresh()
        ELSE
            MsgAviso("Nenhum or" + CHR(231) + "amento encontrado.", "Busca")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCopiarClick - Copia orcamento selecionado para novo registro
    * Carrega grupos/contas do original; usuario altera cabecalho e salva como novo
    *===========================================================================
    PROCEDURE BtnCopiarClick()
        LOCAL loc_cIdChaves
        loc_cIdChaves = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cIdChaves = ALLTRIM(cidchaves)
        ENDIF

        IF EMPTY(loc_cIdChaves)
            MsgAviso("Selecione um or" + CHR(231) + "amento para copiar.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
            IF THIS.this_oBusinessObject.BuscarGrupos() AND ;
               THIS.this_oBusinessObject.BuscarContas() AND ;
               THIS.this_oBusinessObject.CarregarDetalhe()

                THIS.this_oBusinessObject.NovoRegistro()
                THIS.this_cModoAtual = "INCLUIR"
                THIS.pgf_4c_Paginas.ActivePage = 2
            ELSE
                MsgErro("Erro ao carregar detalhe do or" + CHR(231) + "amento.", "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos do formulario
    *===========================================================================
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF
            IF USED("cursor_4c_Contas")
                USE IN cursor_4c_Contas
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao destruir FormOrc:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Iterar Pages E Controls para PageFrames
    *===========================================================================
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

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarGridsDetalhe - Vincula grd_4c_Grupos e grd_4c_Contas aos cursores
    * Chamado apos BuscarGrupos() e BuscarContas() estarem populados
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarGridsDetalhe()
        LOCAL loc_oPg2, loc_oGrdGrupos, loc_oGrdContas
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oGrdGrupos = loc_oPg2.grd_4c_Grupos
            IF USED("cursor_4c_Grupos")
                loc_oGrdGrupos.ColumnCount = 4
                loc_oGrdGrupos.RecordSource          = "cursor_4c_Grupos"
                loc_oGrdGrupos.Column1.ControlSource = "cursor_4c_Grupos.codigos"
                loc_oGrdGrupos.Column2.ControlSource = "cursor_4c_Grupos.descrs"
                loc_oGrdGrupos.Column3.ControlSource = "cursor_4c_Grupos.Valor"
                loc_oGrdGrupos.Column4.ControlSource = "cursor_4c_Grupos.Perc"
                loc_oGrdGrupos.Column1.Header1.Caption = "Grupo"
                loc_oGrdGrupos.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrdGrupos.Column3.Header1.Caption = "Valor"
                loc_oGrdGrupos.Column4.Header1.Caption = "%"
                loc_oGrdGrupos.Column1.Width = 80
                loc_oGrdGrupos.Column2.Width = 300
                loc_oGrdGrupos.Column3.Width = 170
                loc_oGrdGrupos.Column4.Width = 100
                GO TOP IN cursor_4c_Grupos
            ENDIF

            loc_oGrdContas = loc_oPg2.grd_4c_Contas
            IF USED("cursor_4c_Contas")
                *-- Indexar por grupos para viabilizar SET KEY TO (filtro de exibicao)
                SELECT cursor_4c_Contas
                INDEX ON ALLTRIM(grupos) TAG grupos
                loc_oGrdContas.ColumnCount = 4
                loc_oGrdContas.RecordSource          = "cursor_4c_Contas"
                loc_oGrdContas.Column1.ControlSource = "cursor_4c_Contas.iclis"
                loc_oGrdContas.Column2.ControlSource = "cursor_4c_Contas.rclis"
                loc_oGrdContas.Column3.ControlSource = "cursor_4c_Contas.Valor"
                loc_oGrdContas.Column4.ControlSource = "cursor_4c_Contas.Perc"
                loc_oGrdContas.Column1.Header1.Caption = "Conta"
                loc_oGrdContas.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrdContas.Column3.Header1.Caption = "Valor"
                loc_oGrdContas.Column4.Header1.Caption = "%"
                loc_oGrdContas.Column1.Width = 80
                loc_oGrdContas.Column2.Width = 300
                loc_oGrdContas.Column3.Width = 170
                loc_oGrdContas.Column4.Width = 100

                *-- Filtrar contas para o primeiro grupo
                IF USED("cursor_4c_Grupos") AND !EOF("cursor_4c_Grupos")
                    SELECT cursor_4c_Grupos
                    SET KEY TO ALLTRIM(codigos) IN cursor_4c_Contas
                    GO TOP IN cursor_4c_Contas
                ENDIF
            ENDIF

            THIS.RetornarTotalLancado()

        CATCH TO loException
            MostrarErro(loException, "FormOrc.ConfigurarGridsDetalhe")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do BO para os campos visuais da Page2
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Emps.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
            loc_oPg2.txt_4c_Mes.Value         = ALLTRIM(THIS.this_oBusinessObject.this_cMes)
            loc_oPg2.txt_4c_Ano.Value         = ALLTRIM(THIS.this_oBusinessObject.this_cAno)
            loc_oPg2.txt_4c_Titulo.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cTitulo)
            loc_oPg2.txt_4c_Cd_Moeda.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cMoeda)
            loc_oPg2.txt_4c__ds_moeda.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDescMoeda)
            loc_oPg2.txt_4c__nVlTots.Value    = THIS.this_oBusinessObject.this_nVlTots

            THIS.ConfigurarGridsDetalhe()
        CATCH TO loException
            MostrarErro(loException, "FormOrc.BOParaForm")
        ENDTRY
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere campos visuais da Page2 para o BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            THIS.this_oBusinessObject.this_cEmps      = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
            THIS.this_oBusinessObject.this_cMes       = ALLTRIM(loc_oPg2.txt_4c_Mes.Value)
            THIS.this_oBusinessObject.this_cAno       = ALLTRIM(loc_oPg2.txt_4c_Ano.Value)
            THIS.this_oBusinessObject.this_cTitulo    = ALLTRIM(loc_oPg2.txt_4c_Titulo.Value)
            THIS.this_oBusinessObject.this_cMoeda     = ALLTRIM(loc_oPg2.txt_4c_Cd_Moeda.Value)
            THIS.this_oBusinessObject.this_cDescMoeda = ALLTRIM(loc_oPg2.txt_4c__ds_moeda.Value)
            THIS.this_oBusinessObject.this_nVlTots    = loc_oPg2.txt_4c__nVlTots.Value
        CATCH TO loException
            MostrarErro(loException, "FormOrc.FormParaBO")
        ENDTRY
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos editaveis da Page2
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Emps.Value      = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_oPg2.txt_4c_Mes.Value        = ""
            loc_oPg2.txt_4c_Ano.Value        = ""
            loc_oPg2.txt_4c_Titulo.Value     = ""
            loc_oPg2.txt_4c_Cd_Moeda.Value   = ""
            loc_oPg2.txt_4c__ds_moeda.Value  = ""
            loc_oPg2.txt_4c__nVlTots.Value   = 0
            loc_oPg2.txt_4c_TotLancado.Value = 0
            THIS.this_cUltimaEmpValidada   = ""
            THIS.this_cUltimoMesValidado   = ""
            THIS.this_cUltimoAnoValidado   = ""
            THIS.this_cUltimaMoedaValidada = ""
        CATCH TO loException
            MostrarErro(loException, "FormOrc.LimparCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos da Page2 conforme modo
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lEdit
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_lEdit = (par_lHabilitar = .T.)

        TRY
            *-- Empresa: editavel apenas no INCLUIR (chave composta nao pode mudar no ALTERAR)
            loc_oPg2.txt_4c_Emps.Enabled     = loc_lEdit AND THIS.this_cModoAtual = "INCLUIR"
            loc_oPg2.txt_4c_Mes.Enabled      = loc_lEdit AND INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR")
            loc_oPg2.txt_4c_Ano.Enabled      = loc_lEdit AND INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR")
            loc_oPg2.txt_4c_Titulo.Enabled   = loc_lEdit AND INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR")
            loc_oPg2.txt_4c_Cd_Moeda.Enabled = loc_lEdit AND INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR")
            loc_oPg2.txt_4c__ds_moeda.Enabled = loc_lEdit AND ;
                INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR") AND ;
                EMPTY(ALLTRIM(loc_oPg2.txt_4c_Cd_Moeda.Value))
            loc_oPg2.txt_4c__nVlTots.Enabled = loc_lEdit AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

            *-- Grids: colunas 1 e 2 sempre ReadOnly; colunas 3 e 4 editaveis no INCLUIR/ALTERAR
            IF VARTYPE(loc_oPg2.grd_4c_Grupos) = "O"
                loc_oPg2.grd_4c_Grupos.ReadOnly        = !loc_lEdit
                loc_oPg2.grd_4c_Grupos.Column1.ReadOnly = .T.
                loc_oPg2.grd_4c_Grupos.Column2.ReadOnly = .T.
            ENDIF
            IF VARTYPE(loc_oPg2.grd_4c_Contas) = "O"
                loc_oPg2.grd_4c_Contas.ReadOnly        = !loc_lEdit
                loc_oPg2.grd_4c_Contas.Column1.ReadOnly = .T.
                loc_oPg2.grd_4c_Contas.Column2.ReadOnly = .T.
            ENDIF

            *-- Botoes
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdit
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loException
            MostrarErro(loException, "FormOrc.HabilitarCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida e salva o orcamento (Confirmar)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cEmps, loc_cMes, loc_cAno, loc_cTitulo, loc_cMoeda
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes FORA do TRY (CLAUDE.md regra #1)
        loc_cEmps   = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
        loc_cMes    = ALLTRIM(loc_oPg2.txt_4c_Mes.Value)
        loc_cAno    = ALLTRIM(loc_oPg2.txt_4c_Ano.Value)
        loc_cTitulo = ALLTRIM(loc_oPg2.txt_4c_Titulo.Value)
        loc_cMoeda  = ALLTRIM(loc_oPg2.txt_4c_Cd_Moeda.Value)

        IF EMPTY(loc_cEmps)
            MsgAviso("Informe a empresa.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Emps.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cMes)
            MsgAviso("Informe o m" + CHR(234) + "s.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Mes.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cAno)
            MsgAviso("Informe o ano.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Ano.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cTitulo)
            MsgAviso("Informe o t" + CHR(237) + "tulo.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Titulo.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cMoeda)
            MsgAviso("Informe a moeda.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Cd_Moeda.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()

        *-- Verificar duplicidade apenas para INCLUIR
        IF THIS.this_cModoAtual = "INCLUIR"
            IF THIS.this_oBusinessObject.VerificarDuplicidade()
                MsgAviso("J" + CHR(225) + " existe or" + CHR(231) + "amento para " + ;
                    loc_cEmps + "/" + loc_cMes + "/" + loc_cAno + "/" + ;
                    loc_cTitulo + "/" + loc_cMoeda + ".", "Duplicidade")
                RETURN
            ENDIF
        ENDIF

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Or" + CHR(231) + "amento salvo com sucesso.", "Sucesso")
            THIS.AlternarPagina(1)
        ELSE
            MsgErro("Erro ao salvar or" + CHR(231) + "amento.", "Erro")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela e retorna para a lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * ValidarEmps - Valida codigo de empresa (LostFocus do txt_4c_Emps)
    * Verifica existencia em SigCdEmp; padrao para empresa logada se vazio
    *===========================================================================
    PROCEDURE ValidarEmps(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cEmps, loc_nResult, loc_cSQL
        loc_cEmps = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.Value)

        IF loc_cEmps == THIS.this_cUltimaEmpValidada
            RETURN
        ENDIF
        THIS.this_cUltimaEmpValidada = loc_cEmps

        IF EMPTY(loc_cEmps)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            THIS.this_cUltimaEmpValidada = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT cemps FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cEmps)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpChk")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EmpChk")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.Value = PADR(loc_cEmps, 3)
            ELSE
                MsgAviso("Empresa " + loc_cEmps + " n" + CHR(227) + "o encontrada.", "Aviso")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                THIS.this_cUltimaEmpValidada = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.SetFocus()
            ENDIF
            IF USED("cursor_4c_EmpChk")
                USE IN cursor_4c_EmpChk
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOrc.ValidarEmps")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarMes - Valida mes entre 1 e 12 (LostFocus do txt_4c_Mes)
    *===========================================================================
    PROCEDURE ValidarMes(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cMes, loc_nMes
        loc_cMes = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Mes.Value)

        IF loc_cMes == THIS.this_cUltimoMesValidado
            RETURN
        ENDIF
        THIS.this_cUltimoMesValidado = loc_cMes

        IF EMPTY(loc_cMes)
            RETURN
        ENDIF

        loc_nMes = VAL(loc_cMes)
        IF !BETWEEN(loc_nMes, 1, 12)
            MsgAviso("M" + CHR(234) + "s inv" + CHR(225) + "lido, verifique!", "Aviso")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Mes.Value = ""
            THIS.this_cUltimoMesValidado = ""
            THIS.pgf_4c_Paginas.Page2.txt_4c_Mes.SetFocus()
        ELSE
            THIS.pgf_4c_Paginas.Page2.txt_4c_Mes.Value = PADL(TRANSFORM(loc_nMes), 2, "0")
            THIS.this_cUltimoMesValidado = THIS.pgf_4c_Paginas.Page2.txt_4c_Mes.Value
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarAno - Valida ano >= 1900 (LostFocus do txt_4c_Ano)
    * Expande ano de 2 digitos para 4 digitos (ex: "26" -> "2026")
    *===========================================================================
    PROCEDURE ValidarAno(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cAno, loc_nAno
        loc_cAno = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value)

        IF loc_cAno == THIS.this_cUltimoAnoValidado
            RETURN
        ENDIF
        THIS.this_cUltimoAnoValidado = loc_cAno

        IF EMPTY(loc_cAno)
            RETURN
        ENDIF

        loc_nAno = VAL(loc_cAno)
        IF loc_nAno < 100
            loc_nAno = 2000 + loc_nAno
        ENDIF

        IF loc_nAno < 1900
            MsgAviso("Ano inv" + CHR(225) + "lido, verifique!", "Aviso")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value = ""
            THIS.this_cUltimoAnoValidado = ""
            THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.SetFocus()
        ELSE
            THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value = TRANSFORM(loc_nAno)
            THIS.this_cUltimoAnoValidado = THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarMoedaCodigo - Valida codigo de moeda em SigCdMoe (LostFocus)
    * Se nao encontrado, abre lookup de selecao
    *===========================================================================
    PROCEDURE ValidarMoedaCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCod, loc_nResult, loc_cSQL
        loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Cd_Moeda.Value)

        IF loc_cCod == THIS.this_cUltimaMoedaValidada
            RETURN
        ENDIF

        IF EMPTY(loc_cCod)
            THIS.pgf_4c_Paginas.Page2.txt_4c__ds_moeda.Value = ""
            THIS.this_cUltimaMoedaValidada = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                       "WHERE cmoes = " + EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeChk")

            IF loc_nResult > 0 AND !EOF("cursor_4c_MoeChk")
                SELECT cursor_4c_MoeChk
                THIS.pgf_4c_Paginas.Page2.txt_4c_Cd_Moeda.Value  = ALLTRIM(cmoes)
                THIS.pgf_4c_Paginas.Page2.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                THIS.this_cUltimaMoedaValidada = ALLTRIM(cmoes)
            ELSE
                THIS.AbrirLookupMoeda()
            ENDIF

            IF USED("cursor_4c_MoeChk")
                USE IN cursor_4c_MoeChk
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOrc.ValidarMoedaCodigo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarMoedaDesc - Valida descricao de moeda em SigCdMoe (LostFocus)
    * Se nao encontrado, abre lookup de selecao
    *===========================================================================
    PROCEDURE ValidarMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDesc, loc_nResult, loc_cSQL
        loc_cDesc = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__ds_moeda.Value)

        IF EMPTY(loc_cDesc)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Cd_Moeda.Value = ""
            THIS.this_cUltimaMoedaValidada = ""
            RETURN
        ENDIF

        TRY
            THIS.AbrirLookupMoeda()
        CATCH TO loException
            MostrarErro(loException, "FormOrc.ValidarMoedaDesc")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirLookupMoeda - Abre FormBuscaAuxiliar para selecao de moeda (SigCdMoe)
    *===========================================================================
    PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
        loc_cCodigo    = ""
        loc_cDescricao = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
                ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Cd_Moeda.Value), ;
                "Buscar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    loc_cCodigo    = ALLTRIM(cmoes)
                    loc_cDescricao = ALLTRIM(dmoes)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Cd_Moeda.Value  = loc_cCodigo
                    THIS.pgf_4c_Paginas.Page2.txt_4c__ds_moeda.Value = loc_cDescricao
                    THIS.this_cUltimaMoedaValidada = loc_cCodigo
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOrc.AbrirLookupMoeda")
        ENDTRY
    ENDPROC

    *===========================================================================
    * VlTotsLostFocus - Disparado quando txt_4c__nVlTots perde foco
    * Se valor mudou, recalcula proporcoes de grupos e contas
    *===========================================================================
    PROCEDURE VlTotsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nVlTots, loc_nVlAnterior
        loc_nVlTots   = THIS.pgf_4c_Paginas.Page2.txt_4c__nVlTots.Value
        loc_nVlAnterior = THIS.this_oBusinessObject.this_nVlTots

        IF loc_nVlTots <> 0 AND loc_nVlTots <> loc_nVlAnterior
            THIS.this_oBusinessObject.this_nVlTots = loc_nVlTots
            THIS.RecalcularValores()
        ENDIF
    ENDPROC

    *===========================================================================
    * RecalcularValores - Recalcula Valor de grupos e contas a partir dos %
    * Replica logica do SIGCDORC.RecalculaValores no legado
    *===========================================================================
    PROTECTED PROCEDURE RecalcularValores()
        LOCAL loc_nVlTots, loc_nValor

        loc_nVlTots = THIS.this_oBusinessObject.this_nVlTots

        TRY
            IF USED("cursor_4c_Grupos")
                SELECT cursor_4c_Grupos
                SCAN
                    IF cursor_4c_Grupos.Perc <> 0
                        loc_nValor = ROUND(loc_nVlTots * (cursor_4c_Grupos.Perc / 100), 2)
                        REPLACE Valor WITH loc_nValor
                    ENDIF
                ENDSCAN
            ENDIF

            IF USED("cursor_4c_Contas")
                SELECT cursor_4c_Contas
                SCAN
                    IF cursor_4c_Contas.Perc <> 0
                        loc_nValor = ROUND(loc_nVlTots * (cursor_4c_Contas.Perc / 100), 2)
                        REPLACE Valor WITH loc_nValor
                    ENDIF
                ENDSCAN
            ENDIF

            THIS.RetornarTotalLancado()

            IF USED("cursor_4c_Grupos")
                THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
            ENDIF
            IF USED("cursor_4c_Contas")
                THIS.pgf_4c_Paginas.Page2.grd_4c_Contas.Refresh()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOrc.RecalcularValores")
        ENDTRY
    ENDPROC

    *===========================================================================
    * RetornarTotalLancado - Soma grupos + contas e exibe em txt_4c_TotLancado
    * Replica logica do SIGCDORC.RetTotLancado no legado
    * OBS: VFP SELECT SQL ignora SET KEY TO -> soma todos os registros (correto)
    *===========================================================================
    PROCEDURE RetornarTotalLancado()
        LOCAL loc_nTotGrupos, loc_nTotContas, loc_nVlLancado
        loc_nTotGrupos = 0
        loc_nTotContas = 0
        loc_nVlLancado = 0

        TRY
            IF USED("cursor_4c_Grupos")
                SELECT SUM(Valor) AS TotLancado FROM cursor_4c_Grupos ;
                    INTO CURSOR cursor_4c_TotGrp
                IF !EOF("cursor_4c_TotGrp")
                    loc_nTotGrupos = NVL(cursor_4c_TotGrp.TotLancado, 0)
                ENDIF
                IF USED("cursor_4c_TotGrp")
                    USE IN cursor_4c_TotGrp
                ENDIF
            ENDIF

            IF USED("cursor_4c_Contas")
                SELECT SUM(Valor) AS TotLancado FROM cursor_4c_Contas ;
                    INTO CURSOR cursor_4c_TotCta
                IF !EOF("cursor_4c_TotCta")
                    loc_nTotContas = NVL(cursor_4c_TotCta.TotLancado, 0)
                ENDIF
                IF USED("cursor_4c_TotCta")
                    USE IN cursor_4c_TotCta
                ENDIF
            ENDIF

            loc_nVlLancado = loc_nTotGrupos + loc_nTotContas
            THIS.pgf_4c_Paginas.Page2.txt_4c_TotLancado.Value = loc_nVlLancado
        CATCH TO loException
            MostrarErro(loException, "FormOrc.RetornarTotalLancado")
        ENDTRY
    ENDPROC

    *===========================================================================
    * GruposAfterRowColChange - Linha/coluna do grd_4c_Grupos mudou
    * Filtra cursor_4c_Contas pelo grupo atual e recalcula total lancado
    * BINDEVENT exige declaracao de par_nColIndex
    *===========================================================================
    PROCEDURE GruposAfterRowColChange(par_nColIndex)
        TRY
            IF USED("cursor_4c_Grupos") AND USED("cursor_4c_Contas") AND ;
               !EOF("cursor_4c_Grupos")
                SELECT cursor_4c_Grupos
                SET KEY TO ALLTRIM(codigos) IN cursor_4c_Contas
                GO TOP IN cursor_4c_Contas
                THIS.RetornarTotalLancado()
                THIS.pgf_4c_Paginas.Page2.grd_4c_Contas.Refresh()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOrc.GruposAfterRowColChange")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ContasAfterRowColChange - Linha/coluna do grd_4c_Contas mudou
    * Recalcula total lancado apos mudanca de valor em conta
    * BINDEVENT exige declaracao de par_nColIndex
    *===========================================================================
    PROCEDURE ContasAfterRowColChange(par_nColIndex)
        TRY
            THIS.RetornarTotalLancado()
        CATCH TO loException
            MostrarErro(loException, "FormOrc.ContasAfterRowColChange")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD da Page1
    * conforme modo atual: LISTA / INCLUIR / ALTERAR / VISUALIZAR
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lNaLista
        loc_oPg1    = THIS.pgf_4c_Paginas.Page1
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lNaLista = (THIS.this_cModoAtual = "LISTA")

        TRY
            *-- Botoes CRUD da Page1: habilitados apenas quando na lista
            WITH loc_oPg1.cnt_4c_Botoes
                .cmd_4c_Incluir.Enabled    = loc_lNaLista
                .cmd_4c_Visualizar.Enabled = loc_lNaLista
                .cmd_4c_Alterar.Enabled    = loc_lNaLista
                .cmd_4c_Excluir.Enabled    = loc_lNaLista
                .cmd_4c_Buscar.Enabled     = loc_lNaLista
                .Visible     = .T.
            ENDWITH
            loc_oPg1.cmd_4c_Copiar.Enabled = loc_lNaLista

            *-- Botoes da Page2: Confirmar habilitado so em INCLUIR/ALTERAR
            IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
                    INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = !loc_lNaLista
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "FormOrc.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\OrcBO.prg):
*====================================================================
* OrcBO.prg
*
* Business Object para Orc (Orcamento/Previsao)
* Tabela: SigCdMrp (multi-linha: uma por grupo/conta)
*
* Chave composta do "cabecalho": cEmps + cMes + cAno + cTitulo + Moeda
* Chave de linha: cIdChaves (UUID gerado por fUniqueIds)
*
* Estrutura SigCdMrp:
*   cemps     - Empresa       (C(3))
*   cmes      - Mes           (C(2))
*   cano      - Ano           (C(4))
*   ctitulo   - Titulo        (C(40))
*   moeda     - Cod. Moeda    (C(3))
*   nvltots   - Total orcado  (N(15,2))
*   cgrupos   - Cod. Grupo    (C(10)) - linha de grupo
*   iclis     - Cod. Cliente  (C(10)) - linha de conta
*   nvalors   - Valor         (N(15,2))
*   npercs    - Percentual    (N(9,6))
*   cidchaves - ID unico linha (C(20))
*====================================================================

DEFINE CLASS OrcBO AS BusinessBase

	*-- ==========================================
	*-- Propriedades do cabecalho (identificacao)
	*-- ==========================================
	this_cEmps      = ""  && Empresa (C(3))
	this_cMes       = ""  && Mes (C(2)) - "01" a "12"
	this_cAno       = ""  && Ano (C(4)) - "2026"
	this_cTitulo    = ""  && Titulo da previsao (C(40))
	this_cMoeda     = ""  && Codigo da moeda (C(3))
	this_cDescMoeda = ""  && Descricao da moeda - de SigCdMoe.dmoes
	this_nVlTots    = 0   && Total orcado (N(15,2))

	*-- ==========================================
	*-- Propriedades de linha (detalhe)
	*-- ==========================================
	this_cIdChaves  = ""  && ID unico da linha - gerado por fUniqueIds
	this_cGrupos    = ""  && Codigo do grupo - SigCdGcr.codigos
	this_cIClis     = ""  && Codigo da conta/cliente - SigCdCli.iclis
	this_nValors    = 0   && Valor alocado (N(15,2))
	this_nPercs     = 0   && Percentual alocado (N(9,6))

	*-- ==========================================
	*-- Propriedades de controle interno
	*-- ==========================================
	this_cChaveCompostaAnterior = ""  && Chave antes de edicao

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_lResultado = DODEFAULT()

			THIS.this_cTabela     = "SigCdMrp"
			THIS.this_cCampoChave = "cIdChaves"

		CATCH TO loException
			MsgErro("Erro em OrcBO.Init: " + loException.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave composta para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cEmps) + "+" + ;
		       ALLTRIM(THIS.this_cMes)  + "+" + ;
		       ALLTRIM(THIS.this_cAno)  + "+" + ;
		       ALLTRIM(THIS.this_cTitulo) + "+" + ;
		       ALLTRIM(THIS.this_cMoeda)
	ENDPROC

	*====================================================================
	* Buscar - Carrega cursor_4c_Dados com lista agrupada de orcamentos
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cWhere
		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_cWhere = " WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
			IF !EMPTY(par_cFiltro)
				loc_cWhere = loc_cWhere + " AND " + par_cFiltro
			ENDIF

			loc_cSQL = "SELECT cemps, cmes, cano, ctitulo, moeda, nvltots, " + ;
			           "MAX(cidchaves) AS cidchaves " + ;
			           "FROM SIGCDMRP" + ;
			           loc_cWhere + ;
			           " GROUP BY cemps, cmes, cano, ctitulo, moeda, nvltots" + ;
			           " ORDER BY cano, cmes, ctitulo"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
			IF loc_nResult > 0
				SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
				USE IN cursor_4c_DadosTmp
				GO TOP IN cursor_4c_Dados
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao carregar or" + CHR(231) + "amentos."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cEmps     = ALLTRIM(cemps)
				THIS.this_cMes      = ALLTRIM(cmes)
				THIS.this_cAno      = ALLTRIM(cano)
				THIS.this_cTitulo   = ALLTRIM(ctitulo)
				THIS.this_cMoeda    = ALLTRIM(moeda)
				THIS.this_nVlTots   = nvltots
				THIS.this_cIdChaves = ALLTRIM(cidchaves)

				THIS.this_cChaveCompostaAnterior = THIS.ObterChavePrimaria()

				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Cursor n" + CHR(227) + "o dispon" + CHR(237) + "vel."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro por cidchaves
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cChave)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cemps, cmes, cano, ctitulo, moeda, nvltots, cidchaves " + ;
			           "FROM SIGCDMRP " + ;
			           "WHERE cidchaves = " + EscaparSQL(par_cChave)

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CodTmp")
			IF loc_nResult > 0 AND !EOF("cursor_4c_CodTmp")
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_CodTmp")
				THIS.this_lNovoRegistro = .F.
			ELSE
				THIS.this_cUltimoErro = "Registro n" + CHR(227) + "o encontrado."
			ENDIF

			IF USED("cursor_4c_CodTmp")
				USE IN cursor_4c_CodTmp
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* BuscarGrupos - Carrega cursor_4c_Grupos de SigCdGcr (READWRITE)
	*====================================================================
	PROCEDURE BuscarGrupos()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_Grupos")
				USE IN cursor_4c_Grupos
			ENDIF

			loc_cSQL = "SELECT codigos, descrs, " + ;
			           "CAST(0.0 AS NUMERIC(15,2)) AS Valor, " + ;
			           "CAST(0.0 AS NUMERIC(9,6)) AS Perc " + ;
			           "FROM SigCdGcr " + ;
			           "ORDER BY codigos"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpTmp")
			IF loc_nResult > 0
				SELECT * FROM cursor_4c_GrpTmp INTO CURSOR cursor_4c_Grupos READWRITE
				USE IN cursor_4c_GrpTmp
				GO TOP IN cursor_4c_Grupos
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao carregar grupos."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* BuscarContas - Carrega cursor_4c_Contas de SIGCDCLI (READWRITE)
	*====================================================================
	PROCEDURE BuscarContas()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_Contas")
				USE IN cursor_4c_Contas
			ENDIF

			loc_cSQL = "SELECT grupos, iclis, rclis, " + ;
			           "CAST(0.0 AS NUMERIC(15,2)) AS Valor, " + ;
			           "CAST(0.0 AS NUMERIC(9,6)) AS Perc " + ;
			           "FROM SIGCDCLI " + ;
			           "ORDER BY rclis"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaTmp")
			IF loc_nResult > 0
				SELECT * FROM cursor_4c_CtaTmp INTO CURSOR cursor_4c_Contas READWRITE
				USE IN cursor_4c_CtaTmp
				GO TOP IN cursor_4c_Contas
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao carregar contas."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDetalhe - Popula Valor/Perc em cursor_4c_Grupos e cursor_4c_Contas
	*                   com os valores existentes no BD para o orcamento atual
	*====================================================================
	PROCEDURE CarregarDetalhe()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		LOCAL loc_cGrupo, loc_cConta, loc_nValor, loc_nPerc
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cgrupos, iclis, nvalors, npercs " + ;
			           "FROM SIGCDMRP " + ;
			           "WHERE cemps   = " + EscaparSQL(ALLTRIM(THIS.this_cEmps))   + ;
			           "  AND cmes    = " + EscaparSQL(ALLTRIM(THIS.this_cMes))    + ;
			           "  AND cano    = " + EscaparSQL(ALLTRIM(THIS.this_cAno))    + ;
			           "  AND ctitulo = " + EscaparSQL(ALLTRIM(THIS.this_cTitulo)) + ;
			           "  AND moeda   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Detalhe")
			IF loc_nResult > 0
				SELECT cursor_4c_Detalhe
				SCAN
					loc_cGrupo = ALLTRIM(cgrupos)
					loc_cConta = ALLTRIM(iclis)
					loc_nValor = nvalors
					loc_nPerc  = npercs

					IF !EMPTY(loc_cGrupo) AND USED("cursor_4c_Grupos")
						SELECT cursor_4c_Grupos
						LOCATE FOR ALLTRIM(codigos) == loc_cGrupo
						IF FOUND("cursor_4c_Grupos")
							SELECT cursor_4c_Grupos
							REPLACE Valor WITH loc_nValor, Perc WITH loc_nPerc
						ENDIF
					ENDIF

					IF !EMPTY(loc_cConta) AND USED("cursor_4c_Contas")
						SELECT cursor_4c_Contas
						LOCATE FOR ALLTRIM(iclis) == loc_cConta
						IF FOUND("cursor_4c_Contas")
							SELECT cursor_4c_Contas
							REPLACE Valor WITH loc_nValor, Perc WITH loc_nPerc
						ENDIF
					ENDIF
				ENDSCAN

				IF USED("cursor_4c_Detalhe")
					USE IN cursor_4c_Detalhe
				ENDIF

				IF USED("cursor_4c_Grupos")
					GO TOP IN cursor_4c_Grupos
				ENDIF
				IF USED("cursor_4c_Contas")
					GO TOP IN cursor_4c_Contas
				ENDIF
			ENDIF

			loc_lResultado = .T.

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Retorna .T. se chave composta ja existe no BD
	*====================================================================
	PROCEDURE VerificarDuplicidade()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtde FROM SIGCDMRP " + ;
			           "WHERE cemps   = " + EscaparSQL(ALLTRIM(THIS.this_cEmps))   + ;
			           "  AND cmes    = " + EscaparSQL(ALLTRIM(THIS.this_cMes))    + ;
			           "  AND cano    = " + EscaparSQL(ALLTRIM(THIS.this_cAno))    + ;
			           "  AND ctitulo = " + EscaparSQL(ALLTRIM(THIS.this_cTitulo)) + ;
			           "  AND moeda   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChk")
			IF loc_nResult > 0
				SELECT cursor_4c_DupChk
				loc_lResultado = (qtde > 0)
				USE IN cursor_4c_DupChk
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterDescricaoMoeda - Retorna SigCdMoe.dmoes para o codigo informado
	*====================================================================
	PROCEDURE ObterDescricaoMoeda(par_cCodMoeda)
		LOCAL loc_cDescricao, loc_cSQL, loc_nResult
		loc_cDescricao = ""

		TRY
			IF !EMPTY(par_cCodMoeda)
				loc_cSQL = "SELECT dmoes FROM SigCdMoe " + ;
				           "WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cCodMoeda))

				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")
				IF loc_nResult > 0 AND !EOF("cursor_4c_Moeda")
					SELECT cursor_4c_Moeda
					loc_cDescricao = ALLTRIM(dmoes)
				ENDIF
				IF USED("cursor_4c_Moeda")
					USE IN cursor_4c_Moeda
				ENDIF
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_cDescricao = ""
		ENDTRY

		RETURN loc_cDescricao
	ENDPROC

	*====================================================================
	* EfetuarSalvamento - Delta save de grupos e contas em SIGCDMRP
	*   Para cada grupo/conta: faz UPDATE se ja existe, INSERT se novo
	*   Para ALTERAR: deleta previamente linhas zeradas (removidas pelo usuario)
	*====================================================================
	PROTECTED PROCEDURE EfetuarSalvamento()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		LOCAL loc_cEmps, loc_cMes, loc_cAno, loc_cTitulo, loc_cMoeda, loc_nVlTots
		LOCAL loc_cCodigo, loc_cIdChaves, loc_cOper, loc_lOk
		loc_lResultado = .F.

		TRY
			loc_lOk     = .T.
			loc_cEmps   = EscaparSQL(ALLTRIM(THIS.this_cEmps))
			loc_cMes    = EscaparSQL(ALLTRIM(THIS.this_cMes))
			loc_cAno    = EscaparSQL(ALLTRIM(THIS.this_cAno))
			loc_cTitulo = EscaparSQL(ALLTRIM(THIS.this_cTitulo))
			loc_cMoeda  = EscaparSQL(ALLTRIM(THIS.this_cMoeda))
			loc_nVlTots = FormatarNumeroSQL(THIS.this_nVlTots)
			loc_cOper   = IIF(THIS.this_lNovoRegistro, "INSERT", "UPDATE")

			*-- Para ALTERAR: remover linhas de grupos zerados (usuario removeu do orcamento)
			IF !THIS.this_lNovoRegistro AND loc_lOk AND USED("cursor_4c_Grupos")
				SELECT cursor_4c_Grupos
				SCAN FOR cursor_4c_Grupos.Valor = 0 AND cursor_4c_Grupos.Perc = 0
					SELECT cursor_4c_Grupos
					loc_cCodigo = EscaparSQL(ALLTRIM(codigos))
					loc_cSQL = "DELETE FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps   + ;
					           "  AND cmes    = " + loc_cMes    + ;
					           "  AND cano    = " + loc_cAno    + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND cgrupos = " + loc_cCodigo + ;
					           "  AND iclis   = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao remover grupo zerado."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			*-- Para ALTERAR: remover linhas de contas zeradas
			IF !THIS.this_lNovoRegistro AND loc_lOk AND USED("cursor_4c_Contas")
				SELECT cursor_4c_Contas
				SCAN FOR cursor_4c_Contas.Valor = 0 AND cursor_4c_Contas.Perc = 0
					SELECT cursor_4c_Contas
					loc_cCodigo = EscaparSQL(ALLTRIM(iclis))
					loc_cSQL = "DELETE FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps   + ;
					           "  AND cmes    = " + loc_cMes    + ;
					           "  AND cano    = " + loc_cAno    + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND iclis   = " + loc_cCodigo + ;
					           "  AND cgrupos = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao remover conta zerada."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			*-- Salvar grupos com valor ou percentual
			IF loc_lOk AND USED("cursor_4c_Grupos")
				SELECT cursor_4c_Grupos
				SCAN FOR cursor_4c_Grupos.Valor <> 0 OR cursor_4c_Grupos.Perc <> 0
					SELECT cursor_4c_Grupos
					loc_cCodigo = ALLTRIM(codigos)

					*-- Verifica se linha ja existe no BD
					loc_cSQL = "SELECT cidchaves FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps + ;
					           "  AND cmes    = " + loc_cMes  + ;
					           "  AND cano    = " + loc_cAno  + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND cgrupos = " + EscaparSQL(loc_cCodigo) + ;
					           "  AND iclis   = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExiste")

					IF loc_nResult > 0 AND !EOF("cursor_4c_ChkExiste")
						SELECT cursor_4c_ChkExiste
						loc_cIdChaves = ALLTRIM(cidchaves)
						USE IN cursor_4c_ChkExiste
						loc_cSQL = "UPDATE SIGCDMRP SET " + ;
						           "nvalors = " + FormatarNumeroSQL(cursor_4c_Grupos.Valor) + ", " + ;
						           "npercs  = " + FormatarNumeroSQL(cursor_4c_Grupos.Perc)  + ", " + ;
						           "nvltots = " + loc_nVlTots + ;
						           " WHERE cidchaves = " + EscaparSQL(loc_cIdChaves)
					ELSE
						IF USED("cursor_4c_ChkExiste")
							USE IN cursor_4c_ChkExiste
						ENDIF
						loc_cIdChaves = fUniqueIds()
						loc_cSQL = "INSERT INTO SIGCDMRP " + ;
						           "(cemps, cmes, cano, ctitulo, moeda, nvltots, " + ;
						           "cgrupos, iclis, nvalors, npercs, cidchaves) " + ;
						           "VALUES (" + ;
						           loc_cEmps   + ", " + ;
						           loc_cMes    + ", " + ;
						           loc_cAno    + ", " + ;
						           loc_cTitulo + ", " + ;
						           loc_cMoeda  + ", " + ;
						           loc_nVlTots + ", " + ;
						           EscaparSQL(loc_cCodigo) + ", " + ;
						           EscaparSQL("") + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Grupos.Valor) + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Grupos.Perc)  + ", " + ;
						           EscaparSQL(loc_cIdChaves) + ")"
					ENDIF

					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao salvar grupo " + loc_cCodigo + "."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			*-- Salvar contas com valor ou percentual
			IF loc_lOk AND USED("cursor_4c_Contas")
				SELECT cursor_4c_Contas
				SCAN FOR cursor_4c_Contas.Valor <> 0 OR cursor_4c_Contas.Perc <> 0
					SELECT cursor_4c_Contas
					loc_cCodigo = ALLTRIM(iclis)

					*-- Verifica se linha ja existe no BD
					loc_cSQL = "SELECT cidchaves FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps + ;
					           "  AND cmes    = " + loc_cMes  + ;
					           "  AND cano    = " + loc_cAno  + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND iclis   = " + EscaparSQL(loc_cCodigo) + ;
					           "  AND cgrupos = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExiste")

					IF loc_nResult > 0 AND !EOF("cursor_4c_ChkExiste")
						SELECT cursor_4c_ChkExiste
						loc_cIdChaves = ALLTRIM(cidchaves)
						USE IN cursor_4c_ChkExiste
						loc_cSQL = "UPDATE SIGCDMRP SET " + ;
						           "nvalors = " + FormatarNumeroSQL(cursor_4c_Contas.Valor) + ", " + ;
						           "npercs  = " + FormatarNumeroSQL(cursor_4c_Contas.Perc)  + ", " + ;
						           "nvltots = " + loc_nVlTots + ;
						           " WHERE cidchaves = " + EscaparSQL(loc_cIdChaves)
					ELSE
						IF USED("cursor_4c_ChkExiste")
							USE IN cursor_4c_ChkExiste
						ENDIF
						loc_cIdChaves = fUniqueIds()
						loc_cSQL = "INSERT INTO SIGCDMRP " + ;
						           "(cemps, cmes, cano, ctitulo, moeda, nvltots, " + ;
						           "cgrupos, iclis, nvalors, npercs, cidchaves) " + ;
						           "VALUES (" + ;
						           loc_cEmps   + ", " + ;
						           loc_cMes    + ", " + ;
						           loc_cAno    + ", " + ;
						           loc_cTitulo + ", " + ;
						           loc_cMoeda  + ", " + ;
						           loc_nVlTots + ", " + ;
						           EscaparSQL("") + ", " + ;
						           EscaparSQL(loc_cCodigo) + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Contas.Valor) + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Contas.Perc)  + ", " + ;
						           EscaparSQL(loc_cIdChaves) + ")"
					ENDIF

					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao salvar conta " + loc_cCodigo + "."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			IF loc_lOk
				THIS.RegistrarAuditoria(loc_cOper)
				loc_lResultado = .T.
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Inserir - Override: delega para EfetuarSalvamento
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_lResultado = THIS.EfetuarSalvamento()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - Override: delega para EfetuarSalvamento
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_lResultado = THIS.EfetuarSalvamento()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui todas as linhas do orcamento no BD
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			loc_cSQL = "DELETE FROM SIGCDMRP " + ;
			           "WHERE cemps   = " + EscaparSQL(ALLTRIM(THIS.this_cEmps))   + ;
			           "  AND cmes    = " + EscaparSQL(ALLTRIM(THIS.this_cMes))    + ;
			           "  AND cano    = " + EscaparSQL(ALLTRIM(THIS.this_cAno))    + ;
			           "  AND ctitulo = " + EscaparSQL(ALLTRIM(THIS.this_cTitulo)) + ;
			           "  AND moeda   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao excluir or" + CHR(231) + "amento."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

ENDDEFINE

