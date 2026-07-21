# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSIGPRCOT.prg] Indicador de pendencia: * recarrega cursor a partir de SigCdCot sem salvar alteracoes pendente

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.prg):
*==============================================================================
* FormSIGPRCOT.prg - Formulario Operacional: Cotacao de Moeda
* Tipo: OPERACIONAL (flat - sem PageFrame, popup modal pequeno)
* Migrado de SIGPRCOT.SCX
*
* Pilares:
*   UX   -> layout identico ao legado (537x377 - popup modal)
*   BD   -> SigCdCot via SQLEXEC (gnConnHandle)
*   CODE -> arquitetura em camadas (FormBase / SIGPRCOTBO)
*
* CHAMADA:
*   loForm = CREATEOBJECT("FormSIGPRCOT", loFormPai, lcMoeda)
*   loForm.Show()
*   par_oParent = form pai (objeto) - ex: FormSigPrCfn
*   par_cMoeda  = codigo da moeda a exibir cotacoes (ex: "USD")
*==============================================================================

DEFINE CLASS FormSIGPRCOT AS FormBase

    *-- Propriedades visuais (popup modal pequeno, identico ao legado)
    Height       = 377
    Width        = 537
    BorderStyle  = 2
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    DataSession  = 1
    WindowType   = 1
    FontName     = "Tahoma"
    FontSize     = 8
    ForeColor    = RGB(90, 90, 90)

    *-- Referencia ao form pai (SigPrCfn ou similar)
    this_oParent = .NULL.

    *-- Codigo da moeda sendo editada
    this_cMoeda  = ""

    *-- Numero do registro corrente ao inserir (replica ThisForm.Incluir do legado)
    this_nIncluir        = 0

    *-- Business Object
    this_oBusinessObject = .NULL.

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        LPARAMETERS par_oParent, par_cMoeda

        *-- Armazenar parametros ANTES de DODEFAULT() para que InicializarForm
        *-- tenha acesso ao form pai e ao codigo da moeda
        IF VARTYPE(par_oParent) = "O"
            THIS.this_oParent = par_oParent
        ENDIF

        IF VARTYPE(par_cMoeda) = "C"
            THIS.this_cMoeda = ALLTRIM(par_cMoeda)
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCOTBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SIGPRCOTBO", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Caption dinamico: "Cotacao do XXX"
            IF !EMPTY(THIS.this_cMoeda)
                THIS.Caption = "Cota" + CHR(231) + CHR(227) + "o do " + THIS.this_cMoeda
            ELSE
                THIS.Caption = "Cota" + CHR(231) + CHR(227) + "o"
            ENDIF

            *-- Configurar picture de fundo (new_background.jpg do Framework)
            THIS.ConfigurarPageFrame()

            *-- Configurar cabecalho cinza escuro (cntSombra do legado)
            THIS.ConfigurarCabecalho()

            *-- Configurar area principal: grid de cotacoes + botoes operacionais
            *-- (form flat OPERACIONAL - equivalente logico de Page1/Lista)
            THIS.ConfigurarPaginaLista()

            *-- Configurar area de dados (parte 1 dos campos principais):
            *-- vincula cabecalho ao grid de edicao inline
            THIS.ConfigurarPaginaDados()

            *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis()

            *-- Carregar dados somente quando conectado (pular em modo validacao UI)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.CarregarDados()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSIGPRCOT: " + loc_oErro.Message + ;
                    " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
    *==========================================================================
        *-- Form OPERACIONAL flat (sem PageFrame) - configura picture de fundo
        LOCAL loc_cImgFundo
        loc_cImgFundo = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
        LOCAL loc_nW, loc_cCaption
        loc_nW      = THIS.Width
        loc_cCaption = THIS.Caption

        *-- Container cabecalho cinza escuro (cntSombra do legado)
        *-- Ocupa largura total do form (Width=537), Height=80
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = loc_nW
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            *-- Label sombra: texto escuro deslocado 1px (efeito profundidade)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .Width     = loc_nW
                .Height    = 40
                .Top       = 18
                .Left      = 10
                .Caption   = loc_cCaption
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Alignment = 0
            ENDWITH

            *-- Label titulo: texto branco principal
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Width     = loc_nW
                .Height    = 46
                .Top       = 17
                .Left      = 10
                .Caption   = loc_cCaption
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Alignment = 0
            ENDWITH
        ENDWITH
        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
    *==========================================================================
        LPARAMETERS par_oContainer
        LOCAL loc_oContainer, loc_i, loc_oControl, loc_nP

        IF VARTYPE(par_oContainer) = "O"
            loc_oContainer = par_oContainer
        ELSE
            loc_oContainer = THIS
        ENDIF

        FOR loc_i = 1 TO loc_oContainer.ControlCount
            loc_oControl = loc_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF UPPER(ALLTRIM(loc_oControl.BaseClass)) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDados
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !EMPTY(THIS.this_cMoeda)
            loc_lSucesso = THIS.this_oBusinessObject.CarregarCotacoes(THIS.this_cMoeda)
            IF loc_lSucesso AND VARTYPE(THIS.grd_4c_Cotacoes) = "O"
                THIS.grd_4c_Cotacoes.ColumnCount             = 3
                THIS.grd_4c_Cotacoes.RecordSource            = "cursor_4c_Cotacoes"
                THIS.grd_4c_Cotacoes.Column1.ControlSource   = "cursor_4c_Cotacoes.datas"
                THIS.grd_4c_Cotacoes.Column2.ControlSource   = "cursor_4c_Cotacoes.horas"
                THIS.grd_4c_Cotacoes.Column3.ControlSource   = "cursor_4c_Cotacoes.valos"
                THIS.grd_4c_Cotacoes.Column1.Header1.Caption = "Data"
                THIS.grd_4c_Cotacoes.Column2.Header1.Caption = "Hora"
                THIS.grd_4c_Cotacoes.Column3.Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"
                THIS.grd_4c_Cotacoes.Refresh()
            ENDIF
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
    *==========================================================================
    *-- Form OPERACIONAL flat (sem PageFrame): agrupa configuracao da area de
    *-- listagem/edicao de cotacoes. Chamado uma unica vez em InicializarForm.
    *-- Equivalente logico ao "Page1 (Lista)" dos forms CRUD - contem:
    *--   - Grid de cotacoes (grd_4c_Cotacoes) com 3 colunas editaveis
    *--   - Botoes operacionais (Inserir, Excluir, Encerrar)
    *-- No legado (SIGPRCOT.SCX) equivale ao layout direto do form sem paginacao.
        THIS.ConfigurarGrid()
        THIS.ConfigurarBotoes()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
    *==========================================================================
    *-- Configuracao da area de dados/edicao (parte 1 - campos principais).
    *--
    *-- Fluxo neste form OPERACIONAL flat (popup modal 537x377):
    *--   1. Cabecalho cinza escuro (cnt_4c_Cabecalho) -> ja criado em
    *--      ConfigurarCabecalho() com o Caption dinamico
    *--      "Cotacao do <Moeda>", ocupando toda a largura do form (Width=537,
    *--      Height=80, BackColor=RGB(100,100,100)) com labels de sombra e titulo.
    *--   2. Area de dados: a edicao dos campos "Data", "Hora" e "Cotacao"
    *--      acontece diretamente DENTRO das celulas do grd_4c_Cotacoes
    *--      (Grid VFP herda o comportamento de edicao inline do fwgrade legado).
    *--      Nao ha TextBoxes/Labels avulsos na area de dados - toda entrada
    *--      passa por Column1.Text1 (Data), Column2.Text1 (Hora) e
    *--      Column3.Text1 (Cotacao), com validacoes ligadas via BINDEVENT
    *--      KeyPress em ConfigurarGrid().
    *--
    *-- Portanto esta procedure garante o vinculo entre o cabecalho ja
    *-- construido (Container cnt_4c_Cabecalho) e o grid de edicao ativo,
    *-- servindo como ponto unico de configuracao dos "campos principais"
    *-- neste form: reafirma o Caption dinamico do cabecalho (caso a moeda
    *-- tenha mudado) e assegura que o grid esta pronto para receber foco.
        LOCAL loc_cCaption
        IF !EMPTY(THIS.this_cMoeda)
            loc_cCaption = "Cota" + CHR(231) + CHR(227) + "o do " + THIS.this_cMoeda
        ELSE
            loc_cCaption = "Cota" + CHR(231) + CHR(227) + "o"
        ENDIF
        THIS.Caption = loc_cCaption

        IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
            IF PEMSTATUS(THIS.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cCaption
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cCaption
            ENDIF
        ENDIF

        *-- Garantir que o grid de edicao (unico "campo" da area de dados)
        *-- esteja visivel e pronto para uso pelas fases seguintes.
        IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
            THIS.grd_4c_Cotacoes.Visible = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid
    *==========================================================================
        THIS.AddObject("grd_4c_Cotacoes", "Grid")
        WITH THIS.grd_4c_Cotacoes
            .Top               = 85
            .Left              = 133
            .Width             = 270
            .Height            = 283
            .ColumnCount       = 3
            .FontName          = "Courier New"
            .RecordMark        = .F.
            .DeleteMark        = .F.
            .RowHeight         = 20
            .ScrollBars        = 2
            .AllowHeaderSizing = .T.
            .ReadOnly          = .F.

            WITH .Column1
                .Width         = 80
                .FontName      = "Courier New"
                .Movable       = .F.
                .Resizable     = .F.
                .SelectOnEntry = .F.
                .Format        = "K"
                WITH .Header1
                    .Alignment = 2
                    .Caption   = "Data"
                ENDWITH
            ENDWITH

            WITH .Column2
                .Width         = 55
                .FontName      = "Courier New"
                .Movable       = .F.
                .Resizable     = .F.
                .InputMask     = "99:99"
                WITH .Header1
                    .Alignment = 2
                    .Caption   = "Hora"
                ENDWITH
            ENDWITH

            WITH .Column3
                .Width         = 101
                .FontName      = "Courier New"
                .Movable       = .F.
                .Resizable     = .F.
                .InputMask     = "99999.9999999"
                WITH .Header1
                    .Alignment = 2
                    .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
                ENDWITH
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.grd_4c_Cotacoes, "AfterRowColChange", THIS, "GrdCotacoesAfterRowColChange")

        *-- Registros existentes nao editaveis por padrao (equivalente ao When do legado)
        *-- Apenas a linha nova (this_nIncluir) sera desbloqueada em CmdInserirClick
        THIS.grd_4c_Cotacoes.ReadOnly = .T.

        *-- Validacao por celula via KeyPress (substitui os eventos Valid/When do legado)
        BINDEVENT(THIS.grd_4c_Cotacoes.Column1.Text1, "KeyPress", THIS, "GrdDataText1KeyPress")
        BINDEVENT(THIS.grd_4c_Cotacoes.Column2.Text1, "KeyPress", THIS, "GrdHoraText1KeyPress")
        BINDEVENT(THIS.grd_4c_Cotacoes.Column3.Text1, "KeyPress", THIS, "GrdCotacaoText1KeyPress")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
    *==========================================================================
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        THIS.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH THIS.cmd_4c_Inserir
            .Top             = 3
            .Left            = 312
            .Width           = 75
            .Height          = 75
            .Caption         = "Inserir"
            .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
            .Themes          = .T.
            .DisabledPicture = loc_cIcones + "cadastro_inserir_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .WordWrap        = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "CmdInserirClick")

        THIS.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH THIS.cmd_4c_Excluir
            .Top             = 3
            .Left            = 387
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = loc_cIcones + "cadastro_excluir_60.jpg"
            .Themes          = .T.
            .DisabledPicture = loc_cIcones + "cadastro_excluir_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .WordWrap        = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")

        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 462
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .WordWrap        = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
    ENDPROC

    *==========================================================================
    PROCEDURE CmdInserirClick
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.InserirNovaCotacao(THIS.this_cMoeda)
            IF USED("cursor_4c_Cotacoes")
                SELECT cursor_4c_Cotacoes
                THIS.this_nIncluir = RECNO()
                *-- Desbloquear grid para edicao da nova linha (When do legado)
                THIS.grd_4c_Cotacoes.ReadOnly = .F.
            ENDIF
            THIS.RefrescarGrid()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE CmdExcluirClick
    *==========================================================================
        LOCAL loc_cChave, loc_lExcluiu
        IF !USED("cursor_4c_Cotacoes")
            RETURN
        ENDIF
        SELECT cursor_4c_Cotacoes
        IF EOF() OR BOF()
            RETURN
        ENDIF
        loc_cChave = ALLTRIM(cidchaves)
        IF EMPTY(loc_cChave)
            RETURN
        ENDIF
        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o desta cota" + CHR(231) + ;
                       CHR(227) + "o?", "Confirmar")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lExcluiu = THIS.this_oBusinessObject.ExcluirCotacaoAtual(loc_cChave)
                IF loc_lExcluiu
                    THIS.this_nIncluir = 0
                    THIS.grd_4c_Cotacoes.ReadOnly = .T.
                ENDIF
                THIS.RefrescarGrid()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE CmdEncerrarClick
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.SalvarAlteracoesCursor()
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE GrdCotacoesAfterRowColChange
    *==========================================================================
        LPARAMETERS par_nColIndex
        IF USED("cursor_4c_Cotacoes")
            SELECT cursor_4c_Cotacoes
            IF RECNO() != THIS.this_nIncluir
                THIS.this_nIncluir = 0
                *-- Bloquear grid ao navegar para registro existente (When do legado)
                THIS.grd_4c_Cotacoes.ReadOnly = .T.
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE GrdDataText1KeyPress
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
    *-- Equivalente ao data.Text1.Valid do legado:
    *-- Avisa quando data esta vazia ao sair com ENTER/TAB
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        IF !USED("cursor_4c_Cotacoes") OR THIS.this_nIncluir <= 0
            RETURN
        ENDIF
        SELECT cursor_4c_Cotacoes
        IF RECNO() = THIS.this_nIncluir AND EMPTY(datas)
            MsgAviso("Informe a data da Cota" + CHR(231) + CHR(227) + "o.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE GrdHoraText1KeyPress
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
    *-- Equivalente ao hora.Text1.Valid do legado:
    *-- Verifica cotacao duplicada (mesma moeda + data + hora) ao sair com ENTER/TAB
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cHoraDigitada, loc_dData, loc_nRecnoNovo
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        IF !USED("cursor_4c_Cotacoes") OR THIS.this_nIncluir <= 0
            RETURN
        ENDIF
        SELECT cursor_4c_Cotacoes
        IF RECNO() != THIS.this_nIncluir
            RETURN
        ENDIF
        *-- Capturar valores ANTES de acessar objeto do grid (evita mudanca de area de trabalho)
        loc_nRecnoNovo    = THIS.this_nIncluir
        loc_dData         = datas
        loc_cHoraDigitada = ALLTRIM(THIS.grd_4c_Cotacoes.Column2.Text1.Value)
        IF EMPTY(loc_cHoraDigitada) OR EMPTY(loc_dData)
            RETURN
        ENDIF
        *-- Restaurar area de trabalho apos acesso ao objeto do grid
        SELECT cursor_4c_Cotacoes
        *-- Procurar outra linha (nao a nova) com mesma moeda+data+hora
        LOCATE FOR ALLTRIM(cmoes) = ALLTRIM(THIS.this_cMoeda) ;
               AND datas = loc_dData ;
               AND ALLTRIM(horas) = loc_cHoraDigitada ;
               AND RECNO() != loc_nRecnoNovo
        IF FOUND()
            SELECT cursor_4c_Cotacoes
            GO (loc_nRecnoNovo)
            THIS.grd_4c_Cotacoes.Column2.Text1.Value = "  :  "
            MsgAviso("Cota" + CHR(231) + CHR(227) + "o j" + CHR(225) + ;
                     " cadastrada !!!", "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE GrdCotacaoText1KeyPress
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
    *-- Equivalente ao cotacao.Text1.Valid do legado:
    *-- Posiciona no ultimo registro e refresca o grid ao sair com ENTER/TAB
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        IF !USED("cursor_4c_Cotacoes")
            RETURN
        ENDIF
        SELECT cursor_4c_Cotacoes
        GO BOTTOM
        THIS.RefrescarGrid()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE RefrescarGrid
    *==========================================================================
        IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
            THIS.grd_4c_Cotacoes.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina
    *==========================================================================
        LPARAMETERS par_nPagina
        *-- Form operacional flat - sem alternancia de paginas
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Incluir nova cotacao (equivalente ao botao "inserir"
    * do SCX legado). Insere linha vazia no cursor cursor_4c_Cotacoes com
    * chave unica gerada, marca linha como editavel (this_nIncluir = RECNO())
    * e desbloqueia o grid para digitacao de Data/Hora/Cotacao.
    *==========================================================================
    PROCEDURE BtnIncluirClick
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.InserirNovaCotacao(THIS.this_cMoeda)
            IF USED("cursor_4c_Cotacoes")
                SELECT cursor_4c_Cotacoes
                THIS.this_nIncluir = RECNO()
                IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
                    THIS.grd_4c_Cotacoes.ReadOnly = .F.
                    THIS.grd_4c_Cotacoes.SetFocus()
                ENDIF
            ENDIF
            THIS.RefrescarGrid()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Editar cotacao selecionada. O SCX legado SIGPRCOT nao
    * possui botao "Alterar" (edicao acontece inline no fwgrade apenas para
    * o registro recem inserido, controlado pelo When(). Aqui replicamos essa
    * semantica: se o usuario selecionou uma linha existente, desbloqueamos o
    * grid, marcamos como "linha em edicao" (this_nIncluir = RECNO()) e damos
    * foco. Ao salvar em Encerrar, o BO.SalvarAlteracoesCursor persiste tudo.
    *==========================================================================
    PROCEDURE BtnAlterarClick
        IF !USED("cursor_4c_Cotacoes")
            MsgAviso("Nenhuma cota" + CHR(231) + CHR(227) + "o carregada.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        SELECT cursor_4c_Cotacoes
        IF EOF() OR BOF() OR RECCOUNT() = 0
            MsgAviso("Selecione uma cota" + CHR(231) + CHR(227) + "o para alterar.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        THIS.this_nIncluir = RECNO()
        IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
            THIS.grd_4c_Cotacoes.ReadOnly = .F.
            THIS.grd_4c_Cotacoes.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualizar cotacoes (modo somente-leitura). Este
    * form OPERACIONAL flat JA e o visualizador (popup modal listando todas as
    * cotacoes da moeda em grid). Este handler bloqueia o grid, cancela
    * qualquer edicao em andamento (this_nIncluir = 0), recarrega dados do
    * banco e da foco ao grid para navegacao.
    *==========================================================================
    PROCEDURE BtnVisualizarClick
        THIS.this_nIncluir = 0
        IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
            THIS.grd_4c_Cotacoes.ReadOnly = .T.
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !EMPTY(THIS.this_cMoeda)
            THIS.CarregarDados()
        ENDIF
        IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
            THIS.grd_4c_Cotacoes.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Excluir cotacao selecionada (equivalente ao botao
    * "delete" do SCX legado). Executa DELETE no SigCdCot via BO com chave
    * cidchaves da linha corrente, apos confirmacao do usuario.
    *==========================================================================
    PROCEDURE BtnExcluirClick
        LOCAL loc_cChave, loc_lExcluiu
        IF !USED("cursor_4c_Cotacoes")
            RETURN
        ENDIF
        SELECT cursor_4c_Cotacoes
        IF EOF() OR BOF() OR RECCOUNT() = 0
            RETURN
        ENDIF
        loc_cChave = ALLTRIM(cidchaves)
        IF EMPTY(loc_cChave)
            RETURN
        ENDIF
        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o desta cota" + CHR(231) + ;
                       CHR(227) + "o?", "Confirmar")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lExcluiu = THIS.this_oBusinessObject.ExcluirCotacaoAtual(loc_cChave)
                IF loc_lExcluiu
                    THIS.this_nIncluir = 0
                    IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
                        THIS.grd_4c_Cotacoes.ReadOnly = .T.
                    ENDIF
                ENDIF
                THIS.RefrescarGrid()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega/recarrega cotacoes no grid (alias de CarregarDados)
    * Chamado pelo fluxo padrao do FormBase e tambem por AjustarBotoesPorModo
    *==========================================================================
    PROCEDURE CarregarLista
        RETURN THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega cotacoes da moeda atual (refresh do grid)
    * O original nao tem botao Buscar; este handler serve para compatibilidade
    * com FormBase e permite que o pai chame um refresh do popup.
    *==========================================================================
    PROCEDURE BtnBuscarClick
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !EMPTY(THIS.this_cMoeda)
            THIS.this_nIncluir = 0
            IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
                THIS.grd_4c_Cotacoes.ReadOnly = .T.
            ENDIF
            THIS.CarregarDados()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Salva alteracoes do cursor e fecha o popup
    * Replica a logica do botao "sair" do SCX legado (SIGPRCOT.sair.Click):
    *   1. Remove registros incompletos (data vazia ou valor 0)
    *   2. Atualiza SigCdCot com os valores editados no cursor
    *   3. Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.SalvarAlteracoesCursor()
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Persiste alteracoes do cursor sem fechar o popup
    * Util quando o pai precisa que as cotacoes sejam salvas antes de
    * prosseguir mas mantem o popup aberto para mais edicoes.
    *==========================================================================
    PROCEDURE BtnSalvarClick
        LOCAL loc_lOK
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lOK = THIS.this_oBusinessObject.SalvarAlteracoesCursor()
            IF loc_lOK
                *-- Recarregar do banco para refletir o que foi persistido
                THIS.this_nIncluir = 0
                THIS.CarregarDados()
                IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
                    THIS.grd_4c_Cotacoes.ReadOnly = .T.
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Descarta edicoes nao salvas e recarrega do banco
    * Cancela qualquer insercao/alteracao em andamento, restaura ReadOnly e
    * recarrega cursor a partir de SigCdCot sem salvar alteracoes pendentes.
    *==========================================================================
    PROCEDURE BtnCancelarClick
        THIS.this_nIncluir = 0
        IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
            THIS.grd_4c_Cotacoes.ReadOnly = .T.
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !EMPTY(THIS.this_cMoeda)
            THIS.CarregarDados()
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Nao aplicavel a este form OPERACIONAL
    * A edicao acontece diretamente no cursor cursor_4c_Cotacoes via grid
    * inline; nao ha TextBoxes avulsos cujos valores precisem ser copiados
    * para o BO antes de salvar. SalvarAlteracoesCursor() le o cursor direto.
    *==========================================================================
    PROCEDURE FormParaBO
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Nao aplicavel a este form OPERACIONAL
    * Os dados ja estao no cursor cursor_4c_Cotacoes vinculado ao grid via
    * RecordSource/ControlSource. Nao ha TextBoxes avulsos para popular.
    *==========================================================================
    PROCEDURE BOParaForm
        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Controla habilitacao do grid conforme modo de edicao
    * par_lHabilitar = .T. -> grid editavel (nova linha em insercao/alteracao)
    * par_lHabilitar = .F. -> grid somente-leitura (modo consulta/inicial)
    *==========================================================================
    PROCEDURE HabilitarCampos
        LPARAMETERS par_lHabilitar
        LOCAL loc_lHabilitar
        IF VARTYPE(par_lHabilitar) = "L"
            loc_lHabilitar = par_lHabilitar
        ELSE
            loc_lHabilitar = .F.
        ENDIF
        IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
            THIS.grd_4c_Cotacoes.ReadOnly = !loc_lHabilitar
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Inserir) = "O"
            THIS.cmd_4c_Inserir.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta estado transiente do popup (cancela insercao ativa)
    * Usado internamente ao alternar entre registros ou ao encerrar edicao.
    *==========================================================================
    PROCEDURE LimparCampos
        THIS.this_nIncluir = 0
        IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
            THIS.grd_4c_Cotacoes.ReadOnly = .T.
            THIS.grd_4c_Cotacoes.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo corrente
    * Neste form OPERACIONAL flat, a logica de habilitacao dos botoes depende
    * de haver cotacoes carregadas e de haver (ou nao) uma insercao em curso.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo
        LOCAL loc_lTemRegistros, loc_lEmInsercao
        loc_lTemRegistros = USED("cursor_4c_Cotacoes") AND RECCOUNT("cursor_4c_Cotacoes") > 0
        loc_lEmInsercao   = (THIS.this_nIncluir > 0)

        *-- Inserir: disponivel sempre (permite adicionar nova cotacao)
        IF VARTYPE(THIS.cmd_4c_Inserir) = "O"
            THIS.cmd_4c_Inserir.Enabled = !loc_lEmInsercao
        ENDIF

        *-- Excluir: disponivel somente quando ha registros e nao ha insercao ativa
        IF VARTYPE(THIS.cmd_4c_Excluir) = "O"
            THIS.cmd_4c_Excluir.Enabled = loc_lTemRegistros AND !loc_lEmInsercao
        ENDIF

        *-- Encerrar: sempre disponivel (salva e fecha)
        IF VARTYPE(THIS.cmd_4c_Encerrar) = "O"
            THIS.cmd_4c_Encerrar.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
            IF USED("cursor_4c_Cotacoes")
                USE IN cursor_4c_Cotacoes
            ENDIF
        CATCH TO loc_oErro
            *-- Silencioso: erros de limpeza nao devem bloquear destruicao
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRCOTBO.prg):
*==============================================================================
* SIGPRCOTBO.prg - Business Object para Cotacao de Moeda
* Tabela principal: SigCdCot
* Tipo: OPERACIONAL
* Migracao de: SIGPRCOT.SCX
*==============================================================================
SET RESOURCE OFF
SET SAFETY OFF

DEFINE CLASS SIGPRCOTBO AS BusinessBase

    *-- Campos de SigCdCot (schema: docs/schema.sql)
    this_cMoes      = ""   && char(3)       - codigo da moeda
    this_dDatas     = {}   && date NULL      - data da cotacao
    this_cHoras     = ""   && char(8)        - hora da cotacao
    this_nValos     = 0    && numeric(11,6)  - valor da cotacao
    this_cCidChaves = ""   && char(20)       - chave unica (PK)
    this_dDtAlts    = {}   && date NULL      - data da ultima alteracao
    this_cUsuars    = ""   && char(10)       - usuario que inseriu/alterou

    *-- Nome do cursor de trabalho (grid de cotacoes)
    this_cCursorCotacoes = "cursor_4c_Cotacoes"

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdCot"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cMoes      = TratarNulo(cmoes,     "C")
            THIS.this_dDatas     = TratarNulo(datas,     "D")
            THIS.this_cHoras     = TratarNulo(horas,     "C")
            THIS.this_nValos     = TratarNulo(valos,     "N")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_dDtAlts    = TratarNulo(dtalts,    "D")
            THIS.this_cUsuars    = TratarNulo(usuars,    "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de inserir/atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cMoes))
            THIS.this_cMensagem = "Informe o c" + CHR(243) + "digo da moeda."
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDatas)
            THIS.this_cMensagem = "Informe a data da cota" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF
        IF THIS.this_nValos <= 0
            THIS.this_cMensagem = "Informe o valor da cota" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave unica char(20) para cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarChaveUnica()
        RETURN LEFT(SYS(2015) + SYS(2015), 20)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCotacoes - Carrega cotacoes de uma moeda no cursor de trabalho
    * O cursor resultante (cursor_4c_Cotacoes) eh READWRITE para edicao no grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCotacoes(par_cMoeda)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCotacoes)
                USE IN (THIS.this_cCursorCotacoes)
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Cotacoes ;
                (cmoes C(3) NULL, datas D NULL, horas C(8) NULL, ;
                 valos N(11,6) NULL, cidchaves C(20) NULL, ;
                 dtalts D NULL, usuars C(10) NULL)
            SET NULL OFF

            INDEX ON cidchaves                    TAG CidChaves
            INDEX ON cmoes + DTOS(datas) + horas  TAG Cotacaos

            loc_cSQL = "SELECT cmoes, CAST(datas AS date) AS datas, horas, valos, " + ;
                "cidchaves, CAST(dtalts AS date) AS dtalts, usuars " + ;
                "FROM SigCdCot " + ;
                "WHERE cmoes = " + EscaparSQL(par_cMoeda) + " " + ;
                "ORDER BY datas DESC, horas DESC"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotacoesTemp")

            IF loc_nRet > 0
                IF USED("cursor_4c_CotacoesTemp") AND RECCOUNT("cursor_4c_CotacoesTemp") > 0
                    SELECT cursor_4c_Cotacoes
                    APPEND FROM DBF("cursor_4c_CotacoesTemp")
                ENDIF
                IF USED("cursor_4c_CotacoesTemp")
                    USE IN cursor_4c_CotacoesTemp
                ENDIF

                SELECT cursor_4c_Cotacoes
                IF RECCOUNT() > 0
                    SET ORDER TO TAG Cotacaos
                    GO BOTTOM
                ENDIF
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                IF USED("cursor_4c_CotacoesTemp")
                    USE IN cursor_4c_CotacoesTemp
                ENDIF
                MsgErro("Erro ao carregar cota" + CHR(231) + CHR(245) + "es: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirNovaCotacao - Insere nova cotacao vazia para a moeda informada
    * Verifica duplicidade: somente insere se nao houver cotacao para hoje
    * Replica logica do botao "inserir" do legado (Click do SIGPRCOT.inserir)
    *--------------------------------------------------------------------------
    PROCEDURE InserirNovaCotacao(par_cMoeda)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_cCidChave, loc_dHoje, loc_cHoras
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorCotacoes)
            RETURN .F.
        ENDIF

        TRY
            loc_dHoje  = DATE()
            loc_cHoras = TIME()

            *-- Verificar duplicidade no cursor (cotacao para hoje ja existe?)
            *-- Usa LOCATE porque SET EXACT ON impede SEEK parcial em indice composto
            SELECT cursor_4c_Cotacoes
            LOCATE FOR ALLTRIM(cmoes) = ALLTRIM(par_cMoeda) AND datas = loc_dHoje
            IF FOUND()
                MsgAviso("J" + CHR(225) + " existe cota" + CHR(231) + CHR(227) + ;
                    "o cadastrada para hoje.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Gerar chave unica
                loc_cCidChave = THIS.GerarChaveUnica()

                *-- INSERT no SQL Server (valos=0 inicialmente; usuario edita no grid)
                loc_cSQL = "INSERT INTO SigCdCot " + ;
                    "(cmoes, datas, horas, valos, cidchaves, dtalts, usuars) " + ;
                    "VALUES (" + ;
                    EscaparSQL(ALLTRIM(par_cMoeda)) + ", " + ;
                    FormatarDataSQL(loc_dHoje) + ", " + ;
                    EscaparSQL(loc_cHoras) + ", " + ;
                    "0, " + ;
                    EscaparSQL(loc_cCidChave) + ", " + ;
                    FormatarDataSQL(loc_dHoje) + ", " + ;
                    EscaparSQL(gc_4c_UsuarioLogado) + ")"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet > 0
                    *-- Adicionar ao cursor de trabalho; APPEND BLANK deixa ponteiro no novo registro
                    SELECT cursor_4c_Cotacoes
                    SET ORDER TO
                    APPEND BLANK
                    REPLACE cmoes     WITH ALLTRIM(par_cMoeda)
                    REPLACE datas     WITH loc_dHoje
                    REPLACE horas     WITH loc_cHoras
                    REPLACE valos     WITH 0
                    REPLACE cidchaves WITH loc_cCidChave
                    REPLACE dtalts    WITH loc_dHoje
                    REPLACE usuars    WITH gc_4c_UsuarioLogado

                    THIS.this_cCidChaves = loc_cCidChave
                    THIS.RegistrarAuditoria("INSERIR")
                    loc_lSucesso = .T.
                ELSE
                    AERROR(loc_aErro)
                    MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o: " + ;
                        loc_aErro[2], "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirCotacaoAtual - Exclui cotacao pelo cidchaves do registro corrente
    * Replica logica do botao "delete" do legado
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirCotacaoAtual(par_cCidChave)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cCidChave))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigCdCot " + ;
                "WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidChave))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                *-- Remover do cursor de trabalho
                IF USED(THIS.this_cCursorCotacoes)
                    SELECT cursor_4c_Cotacoes
                    LOCATE FOR ALLTRIM(cidchaves) = ALLTRIM(par_cCidChave)
                    IF FOUND()
                        DELETE
                        PACK
                        IF RECCOUNT() > 0
                            SET ORDER TO TAG Cotacaos
                            GO BOTTOM
                        ENDIF
                    ENDIF
                ENDIF

                THIS.this_cCidChaves = par_cCidChave
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlteracoesCursor - Sincroniza cursor de cotacoes com SQL Server
    * Replica logica do botao "sair" do legado:
    * 1. Remove registros com data vazia ou valor zero/null
    * 2. Atualiza SigCdCot com os valores editados no cursor
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAlteracoesCursor()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cChave, loc_dDatas, loc_cHoras, loc_nValos
        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorCotacoes)
            RETURN .F.
        ENDIF

        TRY
            *-- Passo 1: Remover registros incompletos (data vazia ou valor <= 0)
            SELECT cursor_4c_Cotacoes
            SET ORDER TO
            GO TOP
            SCAN
                loc_cChave = ALLTRIM(cidchaves)
                IF EMPTY(datas) OR NVL(valos, 0) <= 0
                    IF !EMPTY(loc_cChave)
                        loc_cSQL = "DELETE FROM SigCdCot " + ;
                            "WHERE cidchaves = " + EscaparSQL(loc_cChave)
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                    SELECT cursor_4c_Cotacoes
                    DELETE
                ENDIF
                SELECT cursor_4c_Cotacoes
            ENDSCAN

            PACK

            *-- Passo 2: Atualizar SigCdCot com valores editados no cursor
            SELECT cursor_4c_Cotacoes
            GO TOP
            SCAN
                loc_cChave  = ALLTRIM(cidchaves)
                loc_dDatas  = datas
                loc_cHoras  = ALLTRIM(horas)
                loc_nValos  = valos

                IF !EMPTY(loc_cChave)
                    loc_cSQL = "UPDATE SigCdCot SET " + ;
                        "datas = " + FormatarDataSQL(loc_dDatas) + ", " + ;
                        "horas = " + EscaparSQL(loc_cHoras) + ", " + ;
                        "valos = " + FormatarNumeroSQL(loc_nValos, 6) + ", " + ;
                        "dtalts = GETDATE(), " + ;
                        "usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + " " + ;
                        "WHERE cidchaves = " + EscaparSQL(loc_cChave)
                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF

                SELECT cursor_4c_Cotacoes
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere nova cotacao usando propriedades this_* do BO
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro, loc_cCidChave
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF !THIS.ValidarDados()
            MsgAviso(THIS.this_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            loc_cCidChave         = THIS.GerarChaveUnica()
            THIS.this_cCidChaves  = loc_cCidChave
            THIS.this_dDtAlts     = DATE()
            THIS.this_cUsuars     = gc_4c_UsuarioLogado

            IF EMPTY(ALLTRIM(THIS.this_cHoras))
                THIS.this_cHoras = TIME()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdCot " + ;
                "(cmoes, datas, horas, valos, cidchaves, dtalts, usuars) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.this_cMoes) + ", " + ;
                FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                EscaparSQL(THIS.this_cHoras) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValos, 6) + ", " + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                FormatarDataSQL(THIS.this_dDtAlts) + ", " + ;
                EscaparSQL(THIS.this_cUsuars) + ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza cotacao existente usando propriedades this_* do BO
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF !THIS.ValidarDados()
            MsgAviso(THIS.this_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_dDtAlts = DATE()
            THIS.this_cUsuars = gc_4c_UsuarioLogado

            loc_cSQL = "UPDATE SigCdCot SET " + ;
                "datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                "horas = " + EscaparSQL(THIS.this_cHoras) + ", " + ;
                "valos = " + FormatarNumeroSQL(THIS.this_nValos, 6) + ", " + ;
                "dtalts = " + FormatarDataSQL(THIS.this_dDtAlts) + ", " + ;
                "usuars = " + EscaparSQL(THIS.this_cUsuars) + " " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao atualizar cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui cotacao de SigCdCot (chamado por Excluir() do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCot " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao em LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, Chave, Usuario, DataHora) VALUES (" + ;
                EscaparSQL("SigCdCot") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE

