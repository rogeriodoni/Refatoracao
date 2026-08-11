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
[2026-08-01 17:30:01] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-01 17:30:01] [INFO] Config FPW: (nao fornecido)
[2026-08-01 17:30:01] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 17:30:01] [INFO] Timeout: 300 segundos
[2026-08-01 17:30:01] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_43ruvoyp.prg
[2026-08-01 17:30:01] [INFO] Conteudo do wrapper:
[2026-08-01 17:30:01] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormENR', 'C:\4c\tasks\task406', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormENR', 'C:\4c\tasks\task406', 'CRUD'
QUIT

[2026-08-01 17:30:01] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_43ruvoyp.prg
[2026-08-01 17:30:01] [INFO] VFP output esperado em: C:\4c\tasks\task406\vfp_output.txt
[2026-08-01 17:30:01] [INFO] Executando Visual FoxPro 9...
[2026-08-01 17:30:01] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_43ruvoyp.prg
[2026-08-01 17:30:01] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_43ruvoyp.prg
[2026-08-01 17:30:01] [INFO] Timeout configurado: 300 segundos
[2026-08-01 17:30:51] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-01 17:30:51] [INFO] VFP9 finalizado em 50.1288496 segundos
[2026-08-01 17:30:51] [INFO] Exit Code: 
[2026-08-01 17:30:51] [INFO] 
[2026-08-01 17:30:51] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-01 17:30:51] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_43ruvoyp.prg
[2026-08-01 17:30:51] [INFO] 
[2026-08-01 17:30:51] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-01 17:30:51] [INFO] * Auto-generated wrapper for parameters
[2026-08-01 17:30:51] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 17:30:51] [INFO] * Parameters: 'FormENR', 'C:\4c\tasks\task406', 'CRUD'
[2026-08-01 17:30:51] [INFO] 
[2026-08-01 17:30:51] [INFO] * Anti-dialog protections for unattended execution
[2026-08-01 17:30:51] [INFO] SET SAFETY OFF
[2026-08-01 17:30:51] [INFO] SET RESOURCE OFF
[2026-08-01 17:30:51] [INFO] SET TALK OFF
[2026-08-01 17:30:51] [INFO] SET NOTIFY OFF
[2026-08-01 17:30:51] [INFO] SYS(2335, 0)
[2026-08-01 17:30:51] [INFO] 
[2026-08-01 17:30:51] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormENR', 'C:\4c\tasks\task406', 'CRUD'
[2026-08-01 17:30:51] [INFO] QUIT
[2026-08-01 17:30:51] [INFO] 
[2026-08-01 17:30:51] [INFO] === Fim do Wrapper.prg ===
[2026-08-01 17:30:51] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormENR",
  "timestamp": "20260801173051",
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormENR.prg):
*====================================================================
* FormENR.prg - Cadastro de Endere??os (SIGCDENR)
*
* Tabela: SigCdEnr (pkchaves PK)
* Tipo: CRUD (frmcadastro)
* BO: ENRBO
*====================================================================

DEFINE CLASS FormENR AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *====================================================================
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init()
    *====================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.Caption = "Endere" + CHR(231) + CHR(111) + "s"

            THIS.this_oBusinessObject = CREATEOBJECT("ENRBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar ENRBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 2
        loc_oPgf.Top       = -29
        loc_oPgf.Left      = 0
        loc_oPgf.Width     = THIS.Width
        loc_oPgf.Height    = THIS.Height + 29
        loc_oPgf.Tabs      = .F.
        loc_oPgf.Visible   = .T.

        WITH loc_oPgf
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

    *====================================================================
    * ConfigurarPaginaLista - Page1: cabecalho + botoes CRUD + grid
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho cinza (Top = 2 + 29 = 31)
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

        *-- Botao Incluir (Left=5)
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
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=80)
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
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
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
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
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
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Left=305)
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
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Top=29, Left=917, Width=90)
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

        *-- Grid de lista (Top = 88+29 = 117, Width nao alcanca cnt_4c_Saida)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista

        *-- RecordSource e ColumnCount FORA de WITH (problema #36)
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 3

        WITH loc_oGrid
            .Top               = 117
            .Left              = 26
            .Width             = 880
            .Height            = 455
            .FontName          = "Verdana"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .GridLineColor     = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle    = 2
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 16
            .ScrollBars        = 2
            .GridLines         = 3
            .Visible           = .T.

            .Column1.Width           = 100
            .Column1.FontName        = "Verdana"
            .Column1.FontSize        = 8

            .Column2.Width           = 450
            .Column2.FontName        = "Verdana"
            .Column2.FontSize        = 8

            .Column3.Width           = 300
            .Column3.FontName        = "Verdana"
            .Column3.FontSize        = 8
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *====================================================================
    * ConfigurarPaginaDados - Page2: labels + campos + botoes Salvar/Cancelar
    * Campos txt_4c_CEP, txt_4c_Endereco, txt_4c_Bairro adicionados na Fase 5
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oSalva

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container botoes Salvar/Cancelar (canonico: Top=33, Left=842, Width=160)
        loc_oPg2.AddObject("cnt_4c_Salva", "Container")
        loc_oSalva = loc_oPg2.cnt_4c_Salva
        WITH loc_oSalva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Confirmar
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
        BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Cancelar
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
        BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label CEP (Say6: top=196+29=225, left=196)
        loc_oPg2.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg2.lbl_4c_Label6
            .Caption   = "CEP :"
            .Top       = 225
            .Left      = 196
            .Width     = 30
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

        *-- TextBox CEP (GetCEP: top=193+29=222, left=226, width=80)
        loc_oPg2.AddObject("txt_4c_CEP", "TextBox")
        WITH loc_oPg2.txt_4c_CEP
            .Value       = ""
            .Top         = 222
            .Left        = 226
            .Width       = 80
            .Height      = 23
            .MaxLength   = 9
            .InputMask   = "99999-999"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .F.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_CEP, "LostFocus", THIS, "LostFocusCEP")

        *-- Label Endere?o (Say4: top=219+29=248, left=170)
        loc_oPg2.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg2.lbl_4c_Label4
            .Caption   = "Endere" + CHR(231) + "o :"
            .Top       = 248
            .Left      = 170
            .Width     = 56
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

        *-- TextBox Endere?o (GetEndere?o: top=216+29=245, left=226, width=403)
        loc_oPg2.AddObject("txt_4c_Endereco", "TextBox")
        WITH loc_oPg2.txt_4c_Endereco
            .Value       = ""
            .Top         = 245
            .Left        = 226
            .Width       = 403
            .Height      = 23
            .MaxLength   = 60
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .F.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_Endereco, "LostFocus", THIS, "LostFocusEndereco")

        *-- Label Bairro (Say5: top=242+29=271, left=187)
        loc_oPg2.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg2.lbl_4c_Label5
            .Caption   = "Bairro :"
            .Top       = 271
            .Left      = 187
            .Width     = 40
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

        *-- TextBox Bairro (GetBairro: top=239+29=268, left=226, width=272, Format="K!" = uppercase)
        loc_oPg2.AddObject("txt_4c_Bairro", "TextBox")
        WITH loc_oPg2.txt_4c_Bairro
            .Value       = ""
            .Top         = 268
            .Left        = 226
            .Width       = 272
            .Height      = 23
            .MaxLength   = 60
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *====================================================================
    * CarregarLista - Consulta BO e vincula grid ao cursor crSigCdEnr
    *====================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- Desanexar grid antes de recarregar para evitar "Unknown member"
                loc_oGrid.RecordSource = ""

                IF THIS.this_oBusinessObject.Buscar("")
                    *-- Vincular grid ao cursor recriado pelo BO
                    loc_oGrid.RecordSource          = "crSigCdEnr"
                    loc_oGrid.Column1.ControlSource = "crSigCdEnr.ceps"
                    loc_oGrid.Column2.ControlSource = "crSigCdEnr.endes"
                    loc_oGrid.Column3.ControlSource = "crSigCdEnr.bairs"

                    *-- Reconfigura??o de headers apos RecordSource (obrigatorio - problema #32)
                    loc_oGrid.Column1.Header1.Caption = "CEP"
                    loc_oGrid.Column2.Header1.Caption = "Endere" + CHR(231) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Bairro"

                    *-- Larguras das colunas
                    loc_oGrid.Column1.Width = 100
                    loc_oGrid.Column2.Width = 450
                    loc_oGrid.Column3.Width = 300

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * FormatarGridLista - Aplica formatacao visual ao grid da lista
    *====================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *====================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *====================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * FormParaBO - Transfere valores do form para o BO
    *====================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
            THIS.this_oBusinessObject.this_cCep = ALLTRIM(loc_oPg2.txt_4c_CEP.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
            THIS.this_oBusinessObject.this_cEndereco = ALLTRIM(loc_oPg2.txt_4c_Endereco.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
            THIS.this_oBusinessObject.this_cBairro = ALLTRIM(loc_oPg2.txt_4c_Bairro.Value)
        ENDIF
    ENDPROC

    *====================================================================
    * BOParaForm - Transfere valores do BO para o form
    *====================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
            loc_oPg2.txt_4c_CEP.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCep)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
            loc_oPg2.txt_4c_Endereco.Value = ALLTRIM(THIS.this_oBusinessObject.this_cEndereco)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
            loc_oPg2.txt_4c_Bairro.Value = ALLTRIM(THIS.this_oBusinessObject.this_cBairro)
        ENDIF
    ENDPROC

    *====================================================================
    * LimparCampos - Limpa valores dos campos da Page2
    *====================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
            loc_oPg2.txt_4c_CEP.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
            loc_oPg2.txt_4c_Endereco.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
            loc_oPg2.txt_4c_Bairro.Value = ""
        ENDIF
    ENDPROC

    *====================================================================
    * HabilitarCampos - Habilita ou desabilita campos da Page2
    *====================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_oSalva
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_oSalva = loc_oPg2.cnt_4c_Salva

        IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
            loc_oPg2.txt_4c_CEP.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
            loc_oPg2.txt_4c_Endereco.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
            loc_oPg2.txt_4c_Bairro.Enabled   = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oSalva, "cmd_4c_Confirmar", 5)
            loc_oSalva.cmd_4c_Confirmar.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oSalva, "cmd_4c_Cancelar", 5)
            loc_oSalva.cmd_4c_Cancelar.Enabled = .T.
        ENDIF
    ENDPROC

    *====================================================================
    * AjustarBotoesPorModo - Configura botoes conforme o modo atual
    *====================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lPodeEditar, loc_oSalva
        loc_lPodeEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        loc_oSalva = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva

        IF PEMSTATUS(loc_oSalva, "cmd_4c_Confirmar", 5)
            loc_oSalva.cmd_4c_Confirmar.Enabled = loc_lPodeEditar
        ENDIF
        IF PEMSTATUS(loc_oSalva, "cmd_4c_Cancelar", 5)
            loc_oSalva.cmd_4c_Cancelar.Enabled = .T.
        ENDIF
    ENDPROC

    *====================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *====================================================================
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

    *====================================================================
    * BtnIncluirClick - Prepara form para inclusao de novo registro
    *====================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *====================================================================
    * BtnVisualizarClick - Abre registro selecionado em modo leitura
    *====================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cPk, loc_lCarregou
        loc_lCarregou = .F.

        IF !USED("crSigCdEnr") OR EOF("crSigCdEnr")
            MsgAviso("Nenhum registro selecionado para visualizar.")
            RETURN
        ENDIF

        TRY
            SELECT crSigCdEnr
            loc_cPk = ALLTRIM(crSigCdEnr.pkchaves)
            loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPk)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.BtnVisualizarClick")
        ENDTRY

        IF loc_lCarregou
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *====================================================================
    * BtnAlterarClick - Abre registro selecionado em modo edicao
    *====================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cPk, loc_lCarregou
        loc_lCarregou = .F.

        IF !USED("crSigCdEnr") OR EOF("crSigCdEnr")
            MsgAviso("Nenhum registro selecionado para alterar.")
            RETURN
        ENDIF

        TRY
            SELECT crSigCdEnr
            loc_cPk = ALLTRIM(crSigCdEnr.pkchaves)
            loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPk)
            IF loc_lCarregou
                THIS.this_oBusinessObject.EditarRegistro()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.BtnAlterarClick")
        ENDTRY

        IF loc_lCarregou
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *====================================================================
    * BtnExcluirClick - Exclui o registro selecionado apos confirmacao
    *====================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cPk, loc_lCarregou
        loc_lCarregou = .F.

        IF !USED("crSigCdEnr") OR EOF("crSigCdEnr")
            MsgAviso("Nenhum registro selecionado para excluir.")
            RETURN
        ENDIF

        TRY
            SELECT crSigCdEnr
            loc_cPk = ALLTRIM(crSigCdEnr.pkchaves)
            loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPk)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.BtnExcluirClick")
        ENDTRY

        IF loc_lCarregou
            IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste endere" + CHR(231) + "o?", "Excluir")
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Endere" + CHR(231) + "o exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *====================================================================
    * BtnBuscarClick - Recarrega a lista de registros
    *====================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *====================================================================
    * BtnEncerrarClick - Fecha o formulario
    *====================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *====================================================================
    * BtnSalvarClick - Valida, transfere form->BO e salva
    *====================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oPg2, loc_cCep, loc_cEndes, loc_cBairs, loc_cSQL
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Valida??o obrigatoria: CEP
        IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_CEP.Value))
                MsgAviso("Obrigat" + CHR(243) + "rio informar o CEP.")
                RETURN
            ENDIF
        ENDIF

        *-- Captura valores para verifica??o de duplicidade
        loc_cCep   = ""
        loc_cEndes = ""
        loc_cBairs = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
            loc_cCep = ALLTRIM(loc_oPg2.txt_4c_CEP.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
            loc_cEndes = ALLTRIM(loc_oPg2.txt_4c_Endereco.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
            loc_cBairs = ALLTRIM(loc_oPg2.txt_4c_Bairro.Value)
        ENDIF

        *-- Verifica duplicidade apenas no modo INSERIR
        IF THIS.this_cModoAtual = "INCLUIR"
            loc_cSQL = "SELECT COUNT(*) AS total FROM SigCdEnr" + ;
                       " WHERE ceps = " + EscaparSQL(loc_cCep) + ;
                       " AND endes = " + EscaparSQL(loc_cEndes) + ;
                       " AND bairs = " + EscaparSQL(loc_cBairs)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck") > 0
                IF !EOF("cursor_4c_DupCheck") AND cursor_4c_DupCheck.total > 0
                    MsgAviso("Endere" + CHR(231) + "o j" + CHR(225) + " cadastrado.")
                    IF USED("cursor_4c_DupCheck")
                        USE IN cursor_4c_DupCheck
                    ENDIF
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_DupCheck")
                USE IN cursor_4c_DupCheck
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!")
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    *====================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *====================================================================
    * LostFocusCEP - Ao sair do campo CEP, tenta preencher Endere?o e Bairro
    * Busca na propria tabela SigCdEnr se o CEP ja foi cadastrado antes
    *====================================================================
    PROCEDURE LostFocusCEP()
        LOCAL loc_lResultado, loc_cCep, loc_cSQL, loc_oPg2
        loc_lResultado = .F.
        loc_cCep = ""

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
                loc_cCep = ALLTRIM(loc_oPg2.txt_4c_CEP.Value)
            ENDIF

            IF !EMPTY(STRTRAN(loc_cCep, "-", ""))
                loc_cSQL = "SELECT TOP 1 endes, bairs FROM SigCdEnr" + ;
                           " WHERE ceps = " + EscaparSQL(loc_cCep)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCep") > 0
                    IF !EOF("cursor_4c_BuscaCep")
                        IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
                            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Endereco.Value))
                                loc_oPg2.txt_4c_Endereco.Value = ALLTRIM(cursor_4c_BuscaCep.endes)
                            ENDIF
                        ENDIF
                        IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
                            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Bairro.Value))
                                loc_oPg2.txt_4c_Bairro.Value = ALLTRIM(cursor_4c_BuscaCep.bairs)
                            ENDIF
                        ENDIF
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.LostFocusCEP")
        ENDTRY

        IF USED("cursor_4c_BuscaCep")
            USE IN cursor_4c_BuscaCep
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * LostFocusEndereco - Ao sair do campo Endere?o, busca CEP/Bairro na tabela
    * Original: GetEndere?o.LostFocus usa fwCep com modo NOMES para auto-completar
    * Equivalente: busca na SigCdEnr por endes LIKE valor digitado
    *====================================================================
    PROCEDURE LostFocusEndereco()
        LOCAL loc_lResultado, loc_cEndereco, loc_cSQL, loc_oPg2
        loc_lResultado = .F.
        loc_cEndereco  = ""

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
                loc_cEndereco = ALLTRIM(loc_oPg2.txt_4c_Endereco.Value)
            ENDIF

            *-- Endereco habilitado apenas quando CEP esta vazio (regra do legado:
            *-- GetEndere?o.When retorna .T. somente se Empty(getCEP))
            *-- Portanto, se o usuario digitou aqui, o CEP esta vazio -> buscar por endes
            IF !EMPTY(STRTRAN(loc_cEndereco, "-", ""))
                loc_cSQL = "SELECT TOP 1 ceps, endes, bairs FROM SigCdEnr" + ;
                           " WHERE endes LIKE " + EscaparSQL(loc_cEndereco + "%") + ;
                           " ORDER BY ceps"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEndes") > 0
                    IF !EOF("cursor_4c_BuscaEndes")
                        IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
                            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_CEP.Value))
                                loc_oPg2.txt_4c_CEP.Value = ALLTRIM(cursor_4c_BuscaEndes.ceps)
                            ENDIF
                        ENDIF
                        IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
                            loc_oPg2.txt_4c_Endereco.Value = ALLTRIM(cursor_4c_BuscaEndes.endes)
                        ENDIF
                        IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
                            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Bairro.Value))
                                loc_oPg2.txt_4c_Bairro.Value = ALLTRIM(cursor_4c_BuscaEndes.bairs)
                            ENDIF
                        ENDIF
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.LostFocusEndereco")
        ENDTRY

        IF USED("cursor_4c_BuscaEndes")
            USE IN cursor_4c_BuscaEndes
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Destroy - Libera recursos
    *====================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("crSigCdEnr")
            USE IN crSigCdEnr
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ENRBO.prg):
*====================================================================
* ENRBO.prg
*
* Business Object para Enderecos (Cadastro de Enderecos - SigCdEnr)
* Tabela principal: SigCdEnr (pkchaves PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS ENRBO AS BusinessBase

	*-- Propriedades da entidade (tabela: SigCdEnr)
	this_cPkChaves  = ""   && pkchaves char(20) - PK (ID gerado via SQL NEWID)
	this_cCep       = ""   && ceps     char(9)  - CEP (formato 99999-999)
	this_cEndereco  = ""   && endes    char(60) - Endereco
	this_cBairro    = ""   && bairs    char(40) - Bairro

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdEnr"
		THIS.this_cCampoChave = "pkchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cPkChaves)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de enderecos no cursor crSigCdEnr
	* par_cFiltro: trecho de CEP ou endereco para filtrar (vazio = todos)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT pkchaves, ceps, endes, bairs" + ;
				           " FROM SigCdEnr" + ;
				           " ORDER BY ceps"
			ELSE
				loc_cSQL = "SELECT pkchaves, ceps, endes, bairs" + ;
				           " FROM SigCdEnr" + ;
				           " WHERE ceps LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
				           " OR endes LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
				           " ORDER BY ceps"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEnr")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar endere" + CHR(231) + "os:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar endere" + CHR(231) + "os:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo pkchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cPkChaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT pkchaves, ceps, endes, bairs" + ;
			           " FROM SigCdEnr" + ;
			           " WHERE pkchaves = " + EscaparSQL(ALLTRIM(par_cPkChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
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
			THIS.this_cPkChaves  = TratarNulo(pkchaves, "C")
			THIS.this_cCep       = TratarNulo(ceps,     "C")
			THIS.this_cEndereco  = TratarNulo(endes,    "C")
			THIS.this_cBairro    = TratarNulo(bairs,    "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* VerificarDuplicado - Verifica se endereco ja esta cadastrado
	* Retorna .T. se ja existe (duplicado), .F. se pode inserir
	*====================================================================
	PROTECTED PROCEDURE VerificarDuplicado()
		LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
		loc_lDuplicado = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS total FROM SigCdEnr" + ;
			           " WHERE ceps  = " + EscaparSQL(THIS.this_cCep)      + ;
			           " AND   endes = " + EscaparSQL(THIS.this_cEndereco) + ;
			           " AND   bairs = " + EscaparSQL(THIS.this_cBairro)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DupCheck") > 0
				SELECT cursor_4c_DupCheck
				loc_lDuplicado = (cursor_4c_DupCheck.total > 0)
			ENDIF

			IF USED("cursor_4c_DupCheck")
				USE IN cursor_4c_DupCheck
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_DupCheck")
				USE IN cursor_4c_DupCheck
			ENDIF
		ENDTRY

		RETURN loc_lDuplicado
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdEnr
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(THIS.this_cCep))
				MsgAviso("Obrigat" + CHR(243) + "rio informar o CEP.", "Valida" + CHR(231) + CHR(227) + "o")
			ELSE
			    IF THIS.VerificarDuplicado()
				MsgErro("Endere" + CHR(231) + "o j" + CHR(225) + " cadastrado.", "Valida" + CHR(231) + CHR(227) + "o")
			ELSE
				*-- Gerar chave unica via SQL Server NEWID()
				loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
				IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
					SELECT cursor_4c_Uuid
					THIS.this_cPkChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
				ENDIF
				IF USED("cursor_4c_Uuid")
					USE IN cursor_4c_Uuid
				ENDIF

				IF EMPTY(THIS.this_cPkChaves)
					MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
				ELSE
					loc_cSQL = "INSERT INTO SigCdEnr (pkchaves, ceps, endes, bairs)" + ;
					           " VALUES (" + ;
					           EscaparSQL(THIS.this_cPkChaves)  + "," + ;
					           EscaparSQL(THIS.this_cCep)       + "," + ;
					           EscaparSQL(LEFT(THIS.this_cEndereco, 60)) + "," + ;
					           EscaparSQL(LEFT(THIS.this_cBairro, 40))   + ;
					           ")"

					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("INSERT")
						loc_lSucesso = .T.
					ELSE
						MsgErro("Erro ao inserir endere" + CHR(231) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			    ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdEnr
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdEnr SET" + ;
			           " ceps  = " + EscaparSQL(THIS.this_cCep)                      + "," + ;
			           " endes = " + EscaparSQL(LEFT(THIS.this_cEndereco, 60)) + "," + ;
			           " bairs = " + EscaparSQL(LEFT(THIS.this_cBairro, 40))   + ;
			           " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar endere" + CHR(231) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigCdEnr
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdEnr WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir endere" + CHR(231) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

