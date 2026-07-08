# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigReFtp.prg] Procedure vazia (sem codigo): AlternarPagina
[FormSigReFtp.prg] Procedure vazia (sem codigo): BtnBuscarClick
[FormSigReFtp.prg] Procedure vazia (sem codigo): BtnSalvarClick
[FormSigReFtp.prg] Procedure vazia (sem codigo): HabilitarCampos
[FormSigReFtp.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReFtp.prg):
*==============================================================================
* FORMSIGREFTP.PRG
* Ficha T" + CHR(233) + "cnica do Produto
* Tipo: REPORT/OPERACIONAL (layout flat, sem PageFrame CRUD)
* Migrado de: SIGREFTP.SCX (frmrelatorio)
*
* Recebe parametros pcProd/pdProd ao ser instanciado. Utiliza cursor
* csDetalhes (DataSession=1 - publico) ja aberto pelo form chamador.
* O usuario marca/desmarca processos no grid antes de imprimir.
*
* FASE 3/8 - Estrutura base:
*   Init() armazena pcProd/pdProd antes de DODEFAULT
*   InicializarForm() instancia BO, inicializa cursor, monta cabecalho + botoes
*   ConfigurarCabecalho() faixa escura RGB(100,100,100) com titulo
*   ConfigurarBotoes() CommandGroup: Visualizar/Imprimir/Documento/Encerrar
*   FormParaRelatorio() repassa parametros ao BO antes de cada impressao
*   BtnVisualizarClick/BtnImprimirClick/BtnDocumentoClick/BtnSairClick
*   Destroy() libera BO (.NULL. - nao usar Release em objeto Custom)
*==============================================================================

DEFINE CLASS FormSigReFtp AS FormBase

    *-- Dimensoes baseadas nas posicoes dos controles originais
    *   (GrdProc bottom=551, BTNREPORT right=805)
    Height      = 575
    Width       = 820
    DataSession = 1
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Referencia ao BO de relatorio (SigReFtpBO)
    this_oRelatorio    = .NULL.

    *-- Parametros recebidos do form chamador via CREATEOBJECT(,pcProd,pdProd)
    this_cCodProd      = ""
    this_cNomProd      = ""

    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Armazena pcProd/pdProd ANTES do DODEFAULT para que
    *        InicializarForm() (chamado pelo FormBase.Init) acesse via THIS.*
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cCodProd, par_cNomProd)
        THIS.this_cCodProd = ALLTRIM(NVL(par_cCodProd, ""))
        THIS.this_cNomProd = ALLTRIM(NVL(par_cNomProd, ""))
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta estrutura visual plana (flat layout)
    *   1. Caption + Picture de fundo
    *   2. Instancia SigReFtpBO
    *   3. Inicializa cursor_4c_SelSigReFtp a partir de csDetalhes
    *      (operacao VFP local - sem SQL - pula apenas se csDetalhes ausente)
    *   4. Cabecalho escuro + CommandGroup de botoes
    *   5. BINDEVENT dos 4 botoes de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Ficha T" + CHR(233) + "cnica do Produto"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SigReFtpBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReFtpBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- InicializarCursorSelecao usa SELECT ... FROM csDetalhes INTO CURSOR
            *   (VFP local, sem SQL). Pula se csDetalhes nao existe (modo validacao UI).
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.InicializarCursorSelecao( ;
                        THIS.this_cCodProd, THIS.this_cNomProd)
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.Visible   = .T.
                loc_lSucesso   = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura layout principal do form REPORT (FLAT)
    *   Este form herda de FormBase mas e do tipo REPORT (frmrelatorio):
    *   NAO usa PageFrame com Page1=Lista/Page2=Dados. O layout e plano,
    *   com cabecalho + botoes + corpo (grid + filtros + botoes auxiliares).
    *
    *   Este metodo cria o container cnt_4c_Corpo que hospedara nas fases
    *   seguintes: grid de selecao de processos (Fase 4), labels e textboxes
    *   de produto/observacao/imagem (Fase 5), OptionGroup de tipo de
    *   relatorio + botoes Selecionar/Apagar (Fase 6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("cnt_4c_Corpo", "Container")
        WITH THIS.cnt_4c_Corpo
            .Top         = 85
            .Left        = 0
            .Width       = THIS.Width
            .Height      = THIS.Height - 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Faixa escura superior com titulo (cntSombra legado)
    *   Width = THIS.Width cobre toda a largura (cnt_4c_Saida transparente)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Ficha T" + CHR(233) + "cnica do Produto"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Ficha T" + CHR(233) + "cnica do Produto"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Original: BTNREPORT.Left=495, Width=310, 4 botoes de 75px cada
    *   Novo:     cmg_4c_Botoes.Left=529, Width=273, 4 botoes de 65px
    *   (padrao canonico frmrelatorio - ver regra critica btnReport)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar relat" + CHR(243) + "rio no v" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar relat" + CHR(243) + "rio para impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Documento"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Imprimir documento direto (sem prompt)"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere estado do form para o BO antes de imprimir
    *   this_nTipoRelatorio: atualizado na Fase 5-6 com opt_4c_TpRel.Value;
    *   por ora default=1 (Reduzida) ate o controle ser adicionado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_nTipo
        loc_nTipo = 1
        IF PEMSTATUS(THIS.cnt_4c_Corpo, "opt_4c_TpRel", 5)
            loc_nTipo = THIS.cnt_4c_Corpo.opt_4c_TpRel.Value
        ENDIF
        WITH THIS.this_oRelatorio
            .this_cCodProd       = THIS.this_cCodProd
            .this_cNomProd       = THIS.this_cNomProd
            .this_nTipoRelatorio = loc_nTipo
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe relatorio em preview na tela (PREVIEW NOCONSOLE)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime com prompt de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Imprime direto para impressora padrao (sem prompt)
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Documento()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario (ESC mapeado via .Cancel=.T. no botao 4)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Marca TODOS os processos para inclusao no relatorio
    *   Form REPORT (frmrelatorio): "Incluir" no contexto de selecao de
    *   processos significa adicionar todos os disponiveis para impressao.
    *   Equivale a clicar em "Selecionar Todos" (cmdSel.Click do legado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.MarcarTodos()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                RETURN
            ENDIF
        ENDIF
        IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
            THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterna marca do processo corrente (toggle lMarca)
    *   Form REPORT (frmrelatorio): "Alterar" no contexto de selecao significa
    *   inverter a marca do registro corrente no grid, refletindo no checkbox.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lAtual
        TRY
            IF !USED("cursor_4c_SelSigReFtp") OR EOF("cursor_4c_SelSigReFtp")
                MsgAviso("Nenhum processo selecionado no grid.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            SELECT cursor_4c_SelSigReFtp
            loc_lAtual = lMarca
            REPLACE lMarca WITH !loc_lAtual IN cursor_4c_SelSigReFtp
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
                THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
            ENDIF
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Desmarca TODOS os processos do relatorio
    *   Form REPORT (frmrelatorio): "Excluir" no contexto de selecao significa
    *   limpar todas as marcas (remover todos da fila de impressao).
    *   Equivale a clicar em "Limpar Selecao" (CmdApg.Click do legado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.DesmarcarTodos()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                RETURN
            ENDIF
        ENDIF
        IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
            THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Grid de selecao de processos + botoes auxiliares
    *   Equivalente a: GrdProc + cmdSel + CmdApg do legado SIGREFTP.
    *   Adicionados dentro de cnt_4c_Corpo (criado em ConfigurarPageFrame).
    *
    *   Posicoes originais (relativas ao form); ajustadas para cnt_4c_Corpo (Top=85):
    *     grd_4c_Dados:    top=79  (164-85), left=385, w=318, h=387
    *     cmd_4c_SelTodos: top=228 (313-85), left=707, w=100, h=25
    *     cmd_4c_LimparSel:top=268 (353-85), left=707, w=100, h=25
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oCorp, loc_oGrid
        TRY
            loc_oCorp = THIS.cnt_4c_Corpo

            *-- Grid de processos (GrdProc no legado)
            loc_oCorp.AddObject("grd_4c_Dados", "Grid")
            loc_oGrid = loc_oCorp.grd_4c_Dados
            WITH loc_oGrid
                .Top                = 79
                .Left               = 385
                .Width              = 318
                .Height             = 387
                .ColumnCount        = 4
                .RecordMark         = .F.
                .DeleteMark         = .F.
                .GridLines          = 1
                .ScrollBars         = 3
                .HighlightStyle     = 2
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .FontName           = "Verdana"
                .FontSize           = 8

                *-- Column1: CheckBox de selecao (lMarca)
                *   Ordem OBRIGATORIO: AddObject ANTES de CurrentControl,
                *   ControlSource SOMENTE apos CurrentControl (Error 1767)
                WITH .Column1
                    .Width          = 35
                    .Resizable      = .F.
                    .AddObject("Check1", "CheckBox")
                    .Check1.Caption = ""
                    .Check1.Value   = 0
                    .CurrentControl = "Check1"
                    .ControlSource  = "cursor_4c_SelSigReFtp.lMarca"
                ENDWITH

                WITH .Column2
                    .Width         = 45
                    .Resizable     = .F.
                    .ControlSource = "cursor_4c_SelSigReFtp.Ordems"
                ENDWITH

                WITH .Column3
                    .Width         = 45
                    .Resizable     = .F.
                    .ControlSource = "cursor_4c_SelSigReFtp.Grupos"
                ENDWITH

                WITH .Column4
                    .Width         = 193
                    .Resizable     = .T.
                    .ReadOnly      = .T.
                    .ControlSource = "cursor_4c_SelSigReFtp.Descrps"
                ENDWITH

                *-- RecordSource ao final (reset de cabecalhos!)
                IF USED("cursor_4c_SelSigReFtp")
                    .RecordSource     = "cursor_4c_SelSigReFtp"
                    .RecordSourceType = 1
                ENDIF

                *-- Redefinir cabecalhos APOS RecordSource (obrigatorio)
                .Column1.Header1.Caption = ""
                .Column2.Header1.Caption = "Ordem"
                .Column3.Header1.Caption = "Grupo"
                .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                .Visible = .T.
            ENDWITH

            *-- Botao Selecionar Todos (cmdSel no legado)
            loc_oCorp.AddObject("cmd_4c_SelTodos", "CommandButton")
            WITH loc_oCorp.cmd_4c_SelTodos
                .Top           = 228
                .Left          = 707
                .Width         = 100
                .Height        = 25
                .Caption       = "Selecionar Todos"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .Themes        = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- Botao Limpar Selecao (CmdApg no legado)
            loc_oCorp.AddObject("cmd_4c_LimparSel", "CommandButton")
            WITH loc_oCorp.cmd_4c_LimparSel
                .Top           = 268
                .Left          = 707
                .Width         = 100
                .Height        = 25
                .Caption       = "Limpar Sele" + CHR(231) + CHR(227) + "o"
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackColor     = RGB(255, 255, 255)
                .ForeColor     = RGB(90, 90, 90)
                .Themes        = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- BINDEVENTs: grid, checkbox da coluna 1, botoes auxiliares
            BINDEVENT(loc_oCorp.grd_4c_Dados, "AfterRowColChange", ;
                THIS, "GrdAfterRowColChange")
            BINDEVENT(loc_oCorp.grd_4c_Dados.Column1.Check1, "Click", ;
                THIS, "GrdCheckClick")
            BINDEVENT(loc_oCorp.cmd_4c_SelTodos,  "Click", THIS, "BtnSelTodosClick")
            BINDEVENT(loc_oCorp.cmd_4c_LimparSel, "Click", THIS, "BtnLimparSelClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Label Produto + textboxes codigo/descricao + imagem
    *   Fase 5 - Parte 1: primeiros 50% dos campos do corpo do form.
    *   Controles adicionados em cnt_4c_Corpo (Top=85).
    *   Coordenadas: top_relativo = top_original - 85 (cnt_4c_Corpo.Top).
    *
    *   lbl_4c_Label10 (Say10):  top=46, left=58  (original 131-85=46)
    *   txt_4c_Cpro    (getCpro): top=43, left=114 (original 128-85=43)
    *   txt_4c_Dpro    (getDpro): top=43, left=223 (original 128-85=43)
    *   img_4c_FigJpg  (ImgFigJpg): top=79, left=53 (original 164-85=79)
    *     img_4c_FigJpg comeca invisivel; GrdAfterRowColChange controla exibicao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oCorp
        TRY
            loc_oCorp = THIS.cnt_4c_Corpo

            *-- Label "Produto :" (Say10 no legado)
            loc_oCorp.AddObject("lbl_4c_Label10", "Label")
            WITH loc_oCorp.lbl_4c_Label10
                .Top       = 46
                .Left      = 58
                .Width     = 53
                .Height    = 15
                .Caption   = "Produto :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Codigo do produto - somente leitura (getCpro no legado)
            *   Recebe this_cCodProd passado ao Init pelo form chamador
            loc_oCorp.AddObject("txt_4c_Cpro", "TextBox")
            WITH loc_oCorp.txt_4c_Cpro
                .Top               = 43
                .Left              = 114
                .Width             = 108
                .Height            = 23
                .Value             = THIS.this_cCodProd
                .Enabled           = .F.
                .ReadOnly          = .T.
                .MaxLength         = 14
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .Visible           = .T.
            ENDWITH

            *-- Descricao do produto - somente leitura (getDpro no legado)
            *   Recebe this_cNomProd passado ao Init pelo form chamador
            loc_oCorp.AddObject("txt_4c_Dpro", "TextBox")
            WITH loc_oCorp.txt_4c_Dpro
                .Top               = 43
                .Left              = 223
                .Width             = 384
                .Height            = 23
                .Value             = THIS.this_cNomProd
                .Enabled           = .F.
                .ReadOnly          = .T.
                .MaxLength         = 40
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .Visible           = .T.
            ENDWITH

            *-- Imagem do processo selecionado no grid (ImgFigJpg no legado)
            *   Inicia invisivel; GrdAfterRowColChange exibe ao navegar no grid
            *   via STRTOFILE(FigProcs, arq) -> img_4c_FigJpg.Picture = arq
            loc_oCorp.AddObject("img_4c_FigJpg", "Image")
            WITH loc_oCorp.img_4c_FigJpg
                .Top     = 79
                .Left    = 53
                .Width   = 320
                .Height  = 199
                .Stretch = 1
                .Picture = ""
                .Enabled = .F.
                .Visible = .F.
            ENDWITH

            *-- EditBox de observacoes do processo (Obs no legado)
            *   Somente leitura; ControlSource: cursor_4c_SelSigReFtp.Obs
            *   Top relativo: 370-85=285
            loc_oCorp.AddObject("edt_4c_Obs", "EditBox")
            WITH loc_oCorp.edt_4c_Obs
                .Top               = 285
                .Left              = 52
                .Width             = 321
                .Height            = 112
                .ReadOnly          = .T.
                .ControlSource     = "cursor_4c_SelSigReFtp.Obs"
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .ScrollBars        = 2
                .Visible           = .T.
            ENDWITH

            *-- Label "Tipo de Ficha :" (Label1 no legado)
            *   Top relativo: 498-85=413
            loc_oCorp.AddObject("lbl_4c_TpRel", "Label")
            WITH loc_oCorp.lbl_4c_TpRel
                .Top       = 413
                .Left      = 52
                .Width     = 125
                .Height    = 14
                .Caption   = "Tipo de Ficha :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- OptionGroup Reduzida/Expandida (OptTpRel no legado)
            *   Top relativo: 497-85=412
            loc_oCorp.AddObject("opt_4c_TpRel", "OptionGroup")
            WITH loc_oCorp.opt_4c_TpRel
                .Top         = 412
                .Left        = 183
                .Width       = 87
                .Height      = 36
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Visible     = .T.

                WITH .Buttons(1)
                    .Caption   = "Reduzida"
                    .Value     = 1
                    .Height    = 17
                    .Left      = 5
                    .Top       = 1
                    .Width     = 79
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH

                WITH .Buttons(2)
                    .Caption   = "Expandida"
                    .Height    = 17
                    .Left      = 5
                    .Top       = 20
                    .Width     = 80
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - N/A para form REPORT de layout plano (flat)
    *   Mantido para compatibilidade com chamadas genericas do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdAfterRowColChange - Exibe imagem/observacao do processo selecionado
    *   Equivalente ao AfterRowColChange do GrdProc no legado:
    *     STRTOFILE(FigProcs, lcArq) -> ImgFigJpg.Picture/.Visible, Obs.Refresh
    *   img_4c_FigJpg e edt_4c_Obs adicionados em fase posterior.
    *   par_nColIndex: requerido pelo BINDEVENT AfterRowColChange
    *--------------------------------------------------------------------------
    PROCEDURE GrdAfterRowColChange(par_nColIndex)
        LOCAL loc_cArquivo, loc_oCorp
        TRY
            loc_cArquivo = SYS(2023) + "\SigrModP.Jpg"
            loc_oCorp    = THIS.cnt_4c_Corpo

            IF PEMSTATUS(loc_oCorp, "img_4c_FigJpg", 5)
                CLEAR RESOURCES
                loc_oCorp.img_4c_FigJpg.Picture = ""
                loc_oCorp.img_4c_FigJpg.Visible = .F.

                IF USED("cursor_4c_SelSigReFtp") AND !EOF("cursor_4c_SelSigReFtp")
                    SELECT cursor_4c_SelSigReFtp
                    IF !EMPTY(FigProcs) AND !ISNULL(FigProcs)
                        IF STRTOFILE(FigProcs, loc_cArquivo) > 0
                            loc_oCorp.img_4c_FigJpg.Picture = loc_cArquivo
                            loc_oCorp.img_4c_FigJpg.Visible = .T.
                        ENDIF
                    ENDIF
                ENDIF

                IF PEMSTATUS(loc_oCorp, "edt_4c_Obs", 5)
                    loc_oCorp.edt_4c_Obs.Refresh()
                ENDIF
            ENDIF

            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GrdAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdCheckClick - Sincroniza lMarca do cursor com o valor do checkbox
    *   Equivalente ao GrdProc.Column1.Check1.Click do legado:
    *     Replace csSelekTon.lMarca With This.Value In csSelekTon
    *--------------------------------------------------------------------------
    PROCEDURE GrdCheckClick()
        LOCAL loc_lNovaMarca, loc_nVal
        TRY
            IF USED("cursor_4c_SelSigReFtp") AND !EOF("cursor_4c_SelSigReFtp")
                loc_nVal = THIS.cnt_4c_Corpo.grd_4c_Dados.Column1.Check1.Value
                IF VARTYPE(loc_nVal) = "L"
                    loc_lNovaMarca = loc_nVal
                ELSE
                    loc_lNovaMarca = (loc_nVal = 1)
                ENDIF
                REPLACE lMarca WITH loc_lNovaMarca IN cursor_4c_SelSigReFtp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GrdCheckClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelTodosClick - Seleciona todos os processos (cmdSel.Click no legado)
    *   Replace All lMarca With .T. -> BO.MarcarTodos()
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelTodosClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.MarcarTodos()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        ENDIF
        IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
            THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnLimparSelClick - Desmarca todos os processos (CmdApg.Click no legado)
    *   Replace All lMarca With .F. -> BO.DesmarcarTodos()
    *--------------------------------------------------------------------------
    PROCEDURE BtnLimparSelClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.DesmarcarTodos()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        ENDIF
        IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
            THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (alias canonico de BtnSairClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - N/A para form REPORT com parametros (sem busca livre)
    *   Mantido para compatibilidade com pipeline generica de forms.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - N/A para form REPORT (sem persistencia de dados)
    *   Mantido para compatibilidade com pipeline generica de forms.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o formulario sem imprimir
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere estado do form para o BO (alias de FormParaRelatorio)
    *   Compatibilidade com pipeline generica que chama FormParaBO antes
    *   de acoes de persistencia/impressao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza campos do form com valores do BO
    *   Para form REPORT: atualiza apenas os campos de exibicao somente-leitura
    *   (codigo e descricao do produto) a partir das propriedades do BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF PEMSTATUS(THIS.cnt_4c_Corpo, "txt_4c_Cpro", 5)
            THIS.cnt_4c_Corpo.txt_4c_Cpro.Value = THIS.this_oRelatorio.this_cCodProd
        ENDIF
        IF PEMSTATUS(THIS.cnt_4c_Corpo, "txt_4c_Dpro", 5)
            THIS.cnt_4c_Corpo.txt_4c_Dpro.Value = THIS.this_oRelatorio.this_cNomProd
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - N/A para form REPORT (controles sao fixos/somente-leitura)
    *   Mantido para compatibilidade com pipeline generica de forms.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura selecao para estado inicial
    *   Desmarca todos os processos e reseta OptionGroup para Reduzida (1).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        TRY
            *-- Reseta tipo de relatorio para Reduzida
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "opt_4c_TpRel", 5)
                THIS.cnt_4c_Corpo.opt_4c_TpRel.Value = 1
            ENDIF

            *-- Desmarca todos os processos no cursor de selecao
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.DesmarcarTodos()
            ENDIF

            *-- Atualiza grid
            IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
                THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega grid a partir do cursor de selecao
    *   Para form REPORT: o cursor cursor_4c_SelSigReFtp ja existe;
    *   apenas reposiciona no inicio e atualiza o grid.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SelSigReFtp")
                GO TOP IN cursor_4c_SelSigReFtp
                IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
                    THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em CarregarLista")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - N/A para form REPORT (sem modos CRUD)
    *   Mantido para compatibilidade com pipeline generica de forms.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO (.NULL. - NAO usar .Release() em objeto Custom)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReFtpBO.prg):
*==============================================================================
* SIGREFTPBO.PRG
* Business Object para Relatorio - Ficha Tecnica do Produto
* Herda de RelatorioBase
*
* Descricao:
*   Gerencia a logica do relatorio SigReFtp (Ficha Tecnica do Produto).
*   Recebe parametros pcProd/pdProd do form chamador.
*   Utiliza cursor csDetalhes ja aberto no contexto do chamador para montar
*   cursor de selecao cursor_4c_SelSigReFtp, onde o usuario marca/desmarca
*   processos antes de imprimir.
*   Suporta dois layouts: Reduzida (SigReFtp.frx) e Expandida (SigReFt1.frx).
*==============================================================================

DEFINE CLASS SigReFtpBO AS RelatorioBase

    *-- Referencia ao cursor fonte (csDetalhes do contexto chamador)
    this_cTabela          = "csDetalhes"
    this_cCampoChave      = "Ordems"
    this_cMensagemErro    = ""

    *-- Parametros de entrada (populados pelo form via FormParaRelatorio)
    this_cCodProd         = ""   && Codigo do produto (pcProd)
    this_cNomProd         = ""   && Descricao do produto (pdProd)

    *-- Configuracao do relatorio
    this_nTipoRelatorio   = 1    && 1=Reduzida (SigReFtp.frx), 2=Expandida (SigReFt1.frx)

    *-- Cursor de selecao (equivalente ao csSelekTon do legado)
    this_cCursorSel       = "cursor_4c_SelSigReFtp"

    *-- Paths dos arquivos FRX (configurados no Init)
    this_cArqRelReduzido  = ""
    this_cArqRelExpandido = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cArqRelReduzido  = gc_4c_CaminhoReports + "SigReFtp.frx"
            THIS.this_cArqRelExpandido = gc_4c_CaminhoReports + "SigReFt1.frx"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursorSelecao - Cria cursor de selecao a partir de csDetalhes
    * Equivalente ao bloco SELECT/INDEX do Init() legado.
    * par_cCodProd: Codigo do produto
    * par_cNomProd: Descricao do produto
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursorSelecao(par_cCodProd, par_cNomProd)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED("csDetalhes")
                THIS.this_cMensagemErro = "Cursor csDetalhes n" + CHR(227) + ;
                    "o est" + CHR(225) + " aberto"
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cCodProd = ALLTRIM(NVL(par_cCodProd, ""))
            THIS.this_cNomProd = ALLTRIM(NVL(par_cNomProd, ""))

            *-- Fecha cursor anterior se existir
            IF USED(THIS.this_cCursorSel)
                USE IN (THIS.this_cCursorSel)
            ENDIF

            *-- Cria cursor de selecao com coluna lMarca adicional
            SELECT .F. AS lMarca, * ;
              FROM csDetalhes ;
              INTO CURSOR (THIS.this_cCursorSel) READWRITE

            *-- Cria indice para busca por Ordem+Grupo (mesmo do legado)
            SELECT (THIS.this_cCursorSel)
            INDEX ON STR(Ordems, 2) + Grupos TAG OrdGru
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Filtra csDetalhes com base nas marcacoes do usuario
    * Equivalente ao 'processamento' do legado:
    *   Recall All em csDetalhes, depois deleta os nao marcados
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cCursorSel
        loc_lSucesso  = .F.
        loc_cCursorSel = THIS.this_cCursorSel
        TRY
            IF !USED("csDetalhes")
                THIS.this_cMensagemErro = "Cursor csDetalhes n" + CHR(227) + ;
                    "o est" + CHR(225) + " aberto"
                loc_lSucesso = .F.
            ENDIF
            IF !USED(loc_cCursorSel)
                THIS.this_cMensagemErro = "Cursor de sele" + CHR(231) + CHR(227) + ;
                    "o n" + CHR(227) + "o inicializado"
                loc_lSucesso = .F.
            ENDIF

            *-- Restaura todos os registros deletados anteriormente
            SELECT csDetalhes
            RECALL ALL

            *-- Varre csDetalhes e deleta registros nao selecionados
            SCAN
                IF SEEK(STR(csDetalhes.Ordems, 2) + csDetalhes.Grupos, ;
                        loc_cCursorSel, "OrdGru")
                    IF !EVALUATE(loc_cCursorSel + ".lMarca")
                        DELETE IN csDetalhes
                    ENDIF
                ENDIF
            ENDSCAN

            *-- Posiciona no inicio de todos os cursores (igual ao legado)
            GO TOP IN (loc_cCursorSel)
            IF USED("csCabecalho")
                GO TOP IN csCabecalho
            ENDIF
            GO TOP IN csDetalhes

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em modo preview (PREVIEW NOCONSOLE)
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_nTipoRelatorio = 1
                REPORT FORM (THIS.this_cArqRelReduzido) PREVIEW NOCONSOLE
            ELSE
                REPORT FORM (THIS.this_cArqRelExpandido) PREVIEW NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com prompt de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_nTipoRelatorio = 1
                REPORT FORM (THIS.this_cArqRelReduzido) TO PRINTER PROMPT NOCONSOLE
            ELSE
                REPORT FORM (THIS.this_cArqRelExpandido) TO PRINTER PROMPT NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Imprime relatorio direto sem prompt
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_nTipoRelatorio = 1
                REPORT FORM (THIS.this_cArqRelReduzido) TO PRINTER
            ELSE
                REPORT FORM (THIS.this_cArqRelExpandido) TO PRINTER
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Seleciona todos os processos (cmdSel.Click do legado)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorSel)
                loc_lSucesso = .F.
            ENDIF
            REPLACE ALL lMarca WITH .T. IN (THIS.this_cCursorSel)
            GO TOP IN (THIS.this_cCursorSel)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todos os processos (CmdApg.Click do legado)
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorSel)
                loc_lSucesso = .F.
            ENDIF
            REPLACE ALL lMarca WITH .F. IN (THIS.this_cCursorSel)
            GO TOP IN (THIS.this_cCursorSel)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna codigo do produto (chave de contexto)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodProd
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursor de selecao proprio (NAO fecha csDetalhes)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorSel)
            USE IN (THIS.this_cCursorSel)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

