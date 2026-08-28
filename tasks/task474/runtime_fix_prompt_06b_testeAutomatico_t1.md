# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-21 18:57:01] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-21 18:57:01] [INFO] Config FPW: (nao fornecido)
[2026-08-21 18:57:01] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-21 18:57:01] [INFO] Timeout: 300 segundos
[2026-08-21 18:57:01] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iqi3fl2k.prg
[2026-08-21 18:57:01] [INFO] Conteudo do wrapper:
[2026-08-21 18:57:01] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormNcf', 'C:\4c\tasks\task474', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormNcf', 'C:\4c\tasks\task474', 'CRUD'
QUIT

[2026-08-21 18:57:01] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iqi3fl2k.prg
[2026-08-21 18:57:01] [INFO] VFP output esperado em: C:\4c\tasks\task474\vfp_output.txt
[2026-08-21 18:57:01] [INFO] Executando Visual FoxPro 9...
[2026-08-21 18:57:01] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iqi3fl2k.prg
[2026-08-21 18:57:01] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iqi3fl2k.prg
[2026-08-21 18:57:01] [INFO] Timeout configurado: 300 segundos
[2026-08-21 18:58:19] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-21 18:58:19] [INFO] VFP9 finalizado em 77.5932146 segundos
[2026-08-21 18:58:19] [INFO] Exit Code: 
[2026-08-21 18:58:19] [INFO] 
[2026-08-21 18:58:19] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-21 18:58:19] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_iqi3fl2k.prg
[2026-08-21 18:58:19] [INFO] 
[2026-08-21 18:58:19] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-21 18:58:19] [INFO] * Auto-generated wrapper for parameters
[2026-08-21 18:58:19] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-21 18:58:19] [INFO] * Parameters: 'FormNcf', 'C:\4c\tasks\task474', 'CRUD'
[2026-08-21 18:58:19] [INFO] 
[2026-08-21 18:58:19] [INFO] * Anti-dialog protections for unattended execution
[2026-08-21 18:58:19] [INFO] SET SAFETY OFF
[2026-08-21 18:58:19] [INFO] SET RESOURCE OFF
[2026-08-21 18:58:19] [INFO] SET TALK OFF
[2026-08-21 18:58:19] [INFO] SET NOTIFY OFF
[2026-08-21 18:58:19] [INFO] SYS(2335, 0)
[2026-08-21 18:58:19] [INFO] 
[2026-08-21 18:58:19] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormNcf', 'C:\4c\tasks\task474', 'CRUD'
[2026-08-21 18:58:19] [INFO] QUIT
[2026-08-21 18:58:19] [INFO] 
[2026-08-21 18:58:19] [INFO] === Fim do Wrapper.prg ===
[2026-08-21 18:58:19] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormNcf",
  "timestamp": "20260821185819",
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
      "detalhes": "AbrirLookup: 2 (ABRIRLOOKUPCANONICO, ABRIRLOOKUPEMPPAD) | KeyPress handlers: 1 (KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormNcf.prg):
*==============================================================================
* FormNcf.prg - Formulario de Nao-Conformidades
* Migrado de: SIGCDNCF.SCX (frmcadastro)
* Tabela: SigCdNcf
* Fase 7/8: Eventos principais CRUD + AjustarBotoesPorModo + SetFocus
*==============================================================================

DEFINE CLASS FormNcf AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Nao-Conformidades"
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

    *--------------------------------------------------------------------------
    * Init - Retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormNcf.Init")
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
            THIS.Caption = "Cadastro de N" + CHR(227) + "o-Conformidades"

            THIS.this_oBusinessObject = CREATEOBJECT("NcfBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar NcfBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"
                loc_lResultado                 = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormNcf.InicializarForm")
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
            .PageCount       = 2
            .Top             = -29
            .Left            = 0
            .Width           = THIS.Width
            .Height          = THIS.Height + 29
            .Tabs            = .F.
            .Visible         = .T.
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
    * ConfigurarPaginaLista - Configura Page1: cabecalho + botoes CRUD + grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho cinza escuro (Top = 2 + 29 compensacao PageFrame)
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

        *-- Botao Incluir
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

        *-- Botao Visualizar
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

        *-- Botao Alterar
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

        *-- Botao Excluir
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

        *-- Botao Buscar
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

        *-- Container saida canonico (Left=917, Width=90, transparente)
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

        *-- Botao Encerrar (canonico)
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

        *-- Grid de lista: top=121+29=150 (compensacao PageFrame), left=12, width=940, height=470
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 2
        WITH loc_oGrid
            .Top                = 150
            .Left               = 12
            .Width              = 940
            .Height             = 470
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

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2: botoes + campos Codigo e Descricao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oSalva
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container botoes Salvar/Cancelar (Grupo_Salva original: Top=23, Left=616 -> Top=52 com +29)
        loc_oPg2.AddObject("cnt_4c_Salva", "Container")
        loc_oSalva = loc_oPg2.cnt_4c_Salva
        WITH loc_oSalva
            .Top         = 52
            .Left        = 616
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva original: Left=5, Top=5)
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

        *-- Botao Cancelar (Cancelar original: Left=80, Top=5)
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

        *-- Label Codigo (Label2: Top=237+29=266, Left=184, Width=42, Height=15)
        loc_oPg2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg2.lbl_4c_Label2
            .AutoSize  = .T.
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 266
            .Left      = 184
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (getCods: Top=234+29=263, Left=234, Width=80, MaxLength=10)
        loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPg2.txt_4c_Codigo
            .Value     = ""
            .Top       = 263
            .Left      = 234
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .MaxLength = 10
            .Visible   = .T.
        ENDWITH

        *-- Label Descricao (Label1: Top=262+29=291, Left=171, Width=55, Height=15)
        loc_oPg2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg2.lbl_4c_Label1
            .AutoSize  = .T.
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 291
            .Left      = 171
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (getDescs: Top=259+29=288, Left=234, Width=430, MaxLength=60)
        loc_oPg2.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPg2.txt_4c_Descricao
            .Value     = ""
            .Top       = 288
            .Left      = 234
            .Width     = 430
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .MaxLength = 60
            .Visible   = .T.
        ENDWITH

        *-- Label "Descricao Fixa :" (Say9: Top=286+29=315, Left=148)
        loc_oPg2.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPg2.lbl_4c_Label9
            .AutoSize  = .T.
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fixa :"
            .Top       = 315
            .Left      = 148
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Descricao Fixa (Opt_Menu: fixos 1=Sim/2=Nao, Top=284+29=313, Left=231)
        loc_oPg2.AddObject("opt_4c_OptMenu", "OptionGroup")
        WITH loc_oPg2.opt_4c_OptMenu
            .ButtonCount   = 2
            .Value         = 2
            .Top           = 313
            .Left          = 231
            .Width         = 89
            .Height        = 20
            .SpecialEffect = 0
            .BackStyle     = 0
            .BorderStyle   = 0
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg2.opt_4c_OptMenu.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 4
            .Top       = 2
            .AutoSize  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        WITH loc_oPg2.opt_4c_OptMenu.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 43
            .Top       = 2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Tipo :" (Say1: Top=306+29=335, Left=197)
        loc_oPg2.AddObject("lbl_4c_LabelTipo", "Label")
        WITH loc_oPg2.lbl_4c_LabelTipo
            .AutoSize  = .T.
            .Caption   = "Tipo :"
            .Top       = 335
            .Left      = 197
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Tipo (get_tipo: tipos 1-4, Top=304+29=333, Left=231, Width=279, Height=43)
        loc_oPg2.AddObject("opt_4c_GetTipo", "OptionGroup")
        WITH loc_oPg2.opt_4c_GetTipo
            .ButtonCount   = 4
            .Value         = 1
            .Top           = 333
            .Left          = 231
            .Width         = 279
            .Height        = 43
            .SpecialEffect = 0
            .BackStyle     = 0
            .BorderStyle   = 0
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg2.opt_4c_GetTipo.Buttons(1)
            .Caption   = "N" + CHR(227) + "o Conforme"
            .Left      = 4
            .Top       = 2
            .AutoSize  = .T.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        WITH loc_oPg2.opt_4c_GetTipo.Buttons(2)
            .Caption   = "Limite Qtd"
            .Left      = 115
            .Top       = 2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        WITH loc_oPg2.opt_4c_GetTipo.Buttons(3)
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o Peso"
            .Left      = 4
            .Top       = 21
            .Width     = 85
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        WITH loc_oPg2.opt_4c_GetTipo.Buttons(4)
            .Caption   = "Reposi" + CHR(231) + CHR(227) + "o S/Composi" + CHR(231) + CHR(227) + "o"
            .Left      = 115
            .Top       = 21
            .Width     = 137
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Empresa :" (Say20: Top=350+29=379, Left=176, Width=50, Height=15)
        loc_oPg2.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPg2.lbl_4c_Label20
            .AutoSize  = .T.
            .Caption   = "Empresa :"
            .Top       = 379
            .Left      = 176
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Empresa (Get_EmpPad: emps char(3), Top=347+29=376, Left=232, Width=34)
        loc_oPg2.AddObject("txt_4c_EmpPad", "TextBox")
        WITH loc_oPg2.txt_4c_EmpPad
            .Value     = ""
            .Top       = 376
            .Left      = 232
            .Width     = 34
            .Height    = 23
            .FontName  = "Courier New"
            .FontSize  = 8
            .Alignment = 3
            .ForeColor = RGB(0, 0, 0)
            .MaxLength = 3
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_EmpPad, "KeyPress", THIS, "EmpPadLostFocus")
        BINDEVENT(loc_oPg2.txt_4c_EmpPad, "DblClick",  THIS, "EmpPadDblClick")

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega registros no grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource          = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
                    loc_oGrid.Column1.Width         = 80
                    loc_oGrid.Column2.Width         = 290
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormNcf.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
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

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inicia inclusao de novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado para visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cods)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.BOParaForm()
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para alteracao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cods)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.BOParaForm()
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e exclui registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cDescricao, loc_lConfirma
        loc_cCodigo   = ""
        loc_cDescricao = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            SELECT cursor_4c_Dados
            loc_cCodigo    = ALLTRIM(cods)
            loc_cDescricao = ALLTRIM(descs)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da N" + CHR(227) + "o-Conformidade?" + ;
                                    CHR(13) + CHR(13) + ;
                                    "C" + CHR(243) + "digo: " + loc_cCodigo + CHR(13) + ;
                                    "Descri" + CHR(231) + CHR(227) + "o: " + loc_cDescricao, ;
                                    "Confirmar Exclus" + CHR(227) + "o")

        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Filtra registros na lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_oGrid
        loc_cFiltro = INPUTBOX("Buscar por c" + CHR(243) + "digo ou descri" + CHR(231) + CHR(227) + "o:", ;
                               "Buscar N" + CHR(227) + "o-Conformidade", "")

        IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
            loc_oGrid.ColumnCount = 2
            loc_oGrid.RecordSource          = "cursor_4c_Dados"
            loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
            loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
            loc_oGrid.Column1.Width         = 80
            loc_oGrid.Column2.Width         = 290
            loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
            loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            THIS.FormatarGridLista(loc_oGrid)
            loc_oGrid.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_nP

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida e salva registro (Confirmar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cCodigo, loc_cDescricao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
            loc_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)

            IF EMPTY(loc_cCodigo)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo!!!", "")
                loc_oPg2.txt_4c_Codigo.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_cDescricao)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar a Descri" + CHR(231) + CHR(227) + "o!!!", "")
                loc_oPg2.txt_4c_Descricao.SetFocus
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Salvar")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * EmpPadLostFocus / EmpPadDblClick - Handlers BINDEVENT para txt_4c_EmpPad
    *--------------------------------------------------------------------------
    PROCEDURE EmpPadLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.ValidarEmpPad()
    ENDPROC

    PROCEDURE EmpPadDblClick()
        THIS.AbrirLookupEmpPad()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpPad - Valida empresa no LostFocus; abre busca se nao encontrada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarEmpPad()
        LOCAL loc_oPg2, loc_cValor, loc_nResult, loc_lEncontrou
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2
        loc_lEncontrou = .F.

        IF !loc_oPg2.txt_4c_EmpPad.Enabled
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_EmpPad.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CEmps FROM SigCdEmp WHERE CEmps = " + EscaparSQL(loc_cValor), ;
                "cursor_4c_ValidaEmp")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValidaEmp") > 0
                loc_lEncontrou = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormNcf.ValidarEmpPad")
        ENDTRY

        IF USED("cursor_4c_ValidaEmp")
            USE IN cursor_4c_ValidaEmp
        ENDIF

        IF !loc_lEncontrou
            THIS.AbrirLookupEmpPad()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupEmpPad - Abre FormBuscaAuxiliar para SigCdEmp
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupEmpPad()
        LOCAL loc_oPg2, loc_nResult, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPg2.txt_4c_EmpPad.Enabled
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps", ;
                "cursor_4c_BuscaEmp")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
                    loc_oBusca.this_cTitulo        = "Empresas"
                    loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        SELECT cursor_4c_BuscaEmp
                        loc_oPg2.txt_4c_EmpPad.Value = ALLTRIM(CEmps)
                    ENDIF

                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormNcf.AbrirLookupEmpPad")
        ENDTRY

        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do Form para o BO (Fase 5: Codigo + Descricao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
        THIS.this_oBusinessObject.this_nFixos     = loc_oPg2.opt_4c_OptMenu.Value
        THIS.this_oBusinessObject.this_nTipos     = loc_oPg2.opt_4c_GetTipo.Value
        THIS.this_oBusinessObject.this_cEmps      = ALLTRIM(loc_oPg2.txt_4c_EmpPad.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o Form (Fase 5: Codigo + Descricao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_nFixos, loc_nTipos
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_nFixos = THIS.this_oBusinessObject.this_nFixos
        loc_nTipos = THIS.this_oBusinessObject.this_nTipos

        loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
        loc_oPg2.opt_4c_OptMenu.Value   = IIF(loc_nFixos >= 1 AND loc_nFixos <= 2, loc_nFixos, 2)
        loc_oPg2.opt_4c_GetTipo.Value   = IIF(loc_nTipos >= 1 AND loc_nTipos <= 4, loc_nTipos, 1)
        loc_oPg2.txt_4c_EmpPad.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos de edicao (Fase 5: Codigo + Descricao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Codigo: editavel apenas na inclusao (getCods When: apenas INSERIR/PROCURAR)
        loc_oPg2.txt_4c_Codigo.Enabled    = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
        loc_oPg2.txt_4c_Descricao.Enabled = par_lHabilitar
        *-- Opt_Menu/get_tipo/EmpPad: apenas INSERIR/ALTERAR (When: INSERIR/ALTERAR)
        loc_oPg2.opt_4c_OptMenu.Enabled   = par_lHabilitar
        loc_oPg2.opt_4c_GetTipo.Enabled   = par_lHabilitar
        loc_oPg2.txt_4c_EmpPad.Enabled    = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa campos do formulario (Fase 5: Codigo + Descricao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value    = ""
        loc_oPg2.txt_4c_Descricao.Value = ""
        loc_oPg2.opt_4c_OptMenu.Value   = 2
        loc_oPg2.opt_4c_GetTipo.Value   = 1
        loc_oPg2.txt_4c_EmpPad.Value    = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botao Confirmar por modo
    * VISUALIZAR: Confirmar disabled, Cancelar enabled
    * INCLUIR/ALTERAR: ambos enabled
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oSalva
        loc_oSalva = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_oSalva.cmd_4c_Confirmar.Enabled = .T.
        ELSE
            loc_oSalva.cmd_4c_Confirmar.Enabled = .F.
        ENDIF

        loc_oSalva.cmd_4c_Cancelar.Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
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


### BO (C:\4c\projeto\app\classes\NcfBO.prg):
*==============================================================================
* NcfBO.prg - Business Object para Nao-Conformidades
* Tabela: SigCdNcf
* Migrado de: SIGCDNCF.SCX (frmcadastro)
*==============================================================================
DEFINE CLASS NcfBO AS BusinessBase

    *-- Propriedades (this_* -> coluna SQL)
    this_cCodigo    = ""    && cods  char(10)  PK
    this_cDescricao = ""    && descs char(60)
    this_nFixos     = 2     && fixos numeric(1,0)  1=Sim / 2=Nao (Descricao Fixa)
    this_nTipos     = 1     && tipos numeric(1,0)  1=Nao Conforme / 2=Limite Qtd / 3=Variacao Peso / 4=Reposicao S/Composicao
    this_cEmps      = ""    && emps  char(3)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdNcf"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT lista de registros para o grid
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, fixos, tipos, emps" + ;
                       " FROM SigCdNcf" + ;
                       " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " OR emps = ' '" + ;
                       " ORDER BY cods"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar N" + CHR(227) + "o-Conformidades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao buscar N" + CHR(227) + "o-Conformidades:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, fixos, tipos, emps" + ;
                       " FROM SigCdNcf" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cods,  "C")
            THIS.this_cDescricao = TratarNulo(descs, "C")
            THIS.this_nFixos     = TratarNulo(fixos, "N")
            THIS.this_nTipos     = TratarNulo(tipos, "N")
            THIS.this_cEmps      = TratarNulo(emps,  "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdNcf (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdNcf (cods, descs, fixos, tipos, emps)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFixos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao inserir N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdNcf (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNcf SET" + ;
                       " descs = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " fixos = " + FormatarNumeroSQL(THIS.this_nFixos) + "," + ;
                       " tipos = " + FormatarNumeroSQL(THIS.this_nTipos) + "," + ;
                       " emps  = " + EscaparSQL(THIS.this_cEmps) + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao atualizar N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdNcf (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdNcf" + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

