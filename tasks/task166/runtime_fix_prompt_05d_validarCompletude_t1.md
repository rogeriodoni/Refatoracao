# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSIGPRCOT.prg] Indicador de pendencia: * Nao ha TextBoxes ou Labels independente
[FormSIGPRCOT.prg] Indicador de pendencia: * Salva alteracoes pendente
[FormSIGPRCOT.prg] Indicador de pendencia: * Descarta alteracoes pendente
[FormSIGPRCOT.prg] Indicador de pendencia: * Nao ha TextBoxes independente
[FormSIGPRCOT.prg] Indicador de pendencia: *-- No-op: grid inline sem campos independente
[FormSIGPRCOT.prg] Indicador de pendencia: * Nao ha TextBoxes independente

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
*===============================================================================
* FormSIGPRCOT.prg - Cota" + CHR(231) + CHR(227) + "o de Moeda
* Herda de: FormBase
* Tipo: OPERACIONAL (dialog modal para edicao de cotacoes de uma moeda)
* Chamada: CREATEOBJECT("FormSIGPRCOT", "USD")
*   par_cMoes = Codigo da moeda (C(3), ex: "USD", "EUR", "BRL")
* Aberto por: FormMoe (botao de cotacoes da moeda selecionada)
* Layout: cnt_4c_Cabecalho (80px) + grd_4c_Cotacoes + 3 botoes
* Fase 3/8: Estrutura base completa (Init, cabecalho, grid, botoes, handlers)
* Fase 4/8: Colunas do grid (ControlSource, Headers, InputMask) + BINDEVENTs de celula
* Fase 5/8: BINDEVENTs de validacao nas celulas (Data/Cotacao/Hora KeyPress)
* Fase 6/8: SetFocus apos Inserir/Excluir (UX PILAR 1); form completo - sem
*           Page2, lookups ou campos adicionais (form de grid inline puro)
* Fase 7/8: BtnIncluirClick/BtnExcluirClick delegam para Cmd*; Alterar/Visualizar
*           sao no-ops (compatibilidade FormBase, dialog sem Page2 separada)
*===============================================================================
DEFINE CLASS FormSIGPRCOT AS FormBase

    *-- Dimensoes exatas do original (SIGPRCOT Width=537, Height=377)
    Width        = 537
    Height       = 377
    AutoCenter   = .T.
    TitleBar     = 0
    WindowType   = 1
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    DataSession  = 2
    BorderStyle  = 2
    ClipControls = .F.
    ForeColor    = RGB(90, 90, 90)
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Codigo da moeda recebida como parametro de CREATEOBJECT
    this_cMoes = ""

    *-- RECNO() do registro em inclusao - controla edicao nas colunas do grid
    *-- Colunas so sao editaveis se RECNO() = this_nIncluir (nova linha)
    this_nIncluir = 0

    *-- Business Object de cotacoes
    this_oBusinessObject = .NULL.

    *===========================================================================
    * Init - Armazena par_cMoes ANTES de DODEFAULT invocar InicializarForm
    *===========================================================================
    PROCEDURE Init(par_cMoes)
        IF VARTYPE(par_cMoes) = "C" AND !EMPTY(ALLTRIM(par_cMoes))
            THIS.this_cMoes = ALLTRIM(par_cMoes)
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- DataSession=2 reseta SET DATE/CENTURY para default AMERICAN/OFF
            SET DATE TO BRITISH
            SET CENTURY ON

            *-- Imagem de fundo (new_background.jpg do legado)
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCOTBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Caption dinamico com nome da moeda
                THIS.Caption = "Cota" + CHR(231) + CHR(227) + "o do " + THIS.this_cMoes

                *-- Layout do form (cabecalho + grid + botoes) - form OPERACIONAL
                *-- nao usa PageFrame real, mas o metodo mantem o nome canonico
                *-- para orquestrar toda a montagem de controles.
                THIS.ConfigurarPageFrame()

                *-- Torna todos os controles visiveis (AddObject cria com Visible=.F.)
                THIS.TornarControlesVisiveis(THIS)

                *-- Carrega cotacoes do SQL Server (pula se validando UI sem conexao)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarCotacoes()
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SIGPRCOTBO.", "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Metodo canonico de layout (orquestrador)
    * Form OPERACIONAL sem PageFrame real; monta cabecalho e delega o corpo
    * (Grid de cotacoes + botoes CRUD) para ConfigurarPaginaLista.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Cabecalho cinza com titulo (equivalente ao cntSombra do legado)
        THIS.ConfigurarCabecalho()

        *-- "Pagina Lista" = grid de cotacoes + botoes de acao (unica vista)
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Monta o corpo do dialog: grid de cotacoes e botoes
    * Como este form OPERACIONAL nao possui PageFrame (nao ha Page1/Page2),
    * a "pagina lista" corresponde ao proprio form. Este metodo agrega o
    * Grid (grd_4c_Cotacoes) e os botoes CRUD (Inserir/Excluir/Encerrar) que
    * substituem os equivalentes do SCX legado (inserir/delete/sair).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- Grid de cotacoes com colunas Data, Hora, Cotacao e BINDEVENTs
        THIS.ConfigurarGrid()

        *-- Botoes Inserir / Excluir / Encerrar com BINDEVENT de Click
        THIS.ConfigurarBotoes()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Sem Page2 neste form OPERACIONAL
    * Form e um dialog modal com um unico grid de edicao inline.
    * Nao ha TextBoxes ou Labels independentes fora do grid.
    * Metodo existe para compatibilidade com o pipeline de migracao multi-fase.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- No-op: toda edicao ocorre diretamente nas celulas de grd_4c_Cotacoes
        RETURN
    ENDPROC

    *===========================================================================
    * AlternarPagina - Compatibilidade com contrato de forms multi-pagina
    * Este form OPERACIONAL nao possui PageFrame (dialog modal de uma unica
    * vista). O metodo existe para compatibilidade com o pipeline de migracao
    * e com forms que herdam/consultam este contrato. Nao ha pagina para
    * ativar - a unica pagina eh o proprio form.
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        *-- No-op: dialog modal sem pages. par_nPagina eh ignorado.
        RETURN
    ENDPROC

    *===========================================================================
    * ConfigurarCabecalho - Cria cnt_4c_Cabecalho (equivalente ao cntSombra)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = "Cota" + CHR(231) + CHR(227) + "o do " + THIS.this_cMoes

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

            *-- Sombra preta deslocada 1px para efeito 3D (lblSombra do legado)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Alignment = 0
                .Caption   = loc_cCaption
                .Visible   = .T.
            ENDWITH

            *-- Titulo branco sobre cinza (lblTitulo do legado)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Alignment = 0
                .Caption   = loc_cCaption
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarGrid - Cria grd_4c_Cotacoes com colunas, headers e BINDEVENTs
    * Colunas: data(Col1), hora(Col3/Order=2), cotacao(Col2/Order=3)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        THIS.AddObject("grd_4c_Cotacoes", "Grid")
        WITH THIS.grd_4c_Cotacoes
            .Top               = 85
            .Left              = 133
            .Width             = 270
            .Height            = 283
            .ColumnCount       = 3
            .FontName          = "Courier New"
            .FontSize          = 8
            .RowHeight         = 20
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .ReadOnly          = .F.
            .AllowHeaderSizing = .T.
            .Visible           = .T.

            *-- Column1: data (datas) - exibida na 1a posicao (ColumnOrder default)
            WITH .Column1
                .Width         = 80
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .F.
                .SelectOnEntry = .F.
                .Format        = "K"
                .ControlSource = "cursor_4c_Cotacoes.datas"
                .Header1.Caption   = "Data"
                .Header1.Alignment = 2
                .Text1.FontName    = "Courier New"
                .Text1.BorderStyle = 0
                .Text1.Format      = "K"
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .F.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column2: cotacao (valos) - ColumnOrder=3, exibida na 3a posicao
            WITH .Column2
                .ColumnOrder   = 3
                .Width         = 101
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .F.
                .SelectOnEntry = .F.
                .Format        = "K"
                .InputMask     = "99999.9999999"
                .ControlSource = "cursor_4c_Cotacoes.valos"
                .Header1.Caption   = "Cota" + CHR(231) + CHR(227) + "o"
                .Header1.Alignment = 2
                .Text1.FontName    = "Courier New"
                .Text1.BorderStyle = 0
                .Text1.Format      = "K"
                .Text1.Margin      = 0
                .Text1.ReadOnly    = .F.
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Column3: hora (horas) - ColumnOrder=2, exibida na 2a posicao
            WITH .Column3
                .ColumnOrder   = 2
                .Width         = 55
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .F.
                .InputMask     = "99:99"
                .ControlSource = "cursor_4c_Cotacoes.horas"
                .Header1.Caption   = "Hora"
                .Header1.Alignment = 2
                .Text1.FontName    = "Courier New"
                .Text1.BorderStyle = 0
                .Text1.Margin      = 0
                .Text1.ForeColor   = RGB(0, 0, 0)
                .Text1.BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        *-- BINDEVENT: AfterRowColChange - controle de editabilidade por linha
        BINDEVENT(THIS.grd_4c_Cotacoes, "AfterRowColChange", THIS, "GrdAfterRowColChange")

        *-- BINDEVENT: KeyPress nas celulas de data, cotacao e hora para validacao
        BINDEVENT(THIS.grd_4c_Cotacoes.Column1.Text1, "KeyPress", THIS, "GrdDataKeyPress")
        BINDEVENT(THIS.grd_4c_Cotacoes.Column2.Text1, "KeyPress", THIS, "GrdCotacaoKeyPress")
        BINDEVENT(THIS.grd_4c_Cotacoes.Column3.Text1, "KeyPress", THIS, "GrdHoraKeyPress")
    ENDPROC

    *===========================================================================
    * ConfigurarBotoes - Cria cmd_4c_Inserir, cmd_4c_Excluir, cmd_4c_Encerrar
    * com BINDEVENT para os handlers de Click
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- cmd_4c_Inserir (Left=312, TabIndex=1)
        THIS.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH THIS.cmd_4c_Inserir
            .Top             = 3
            .Left            = 312
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
            .Caption         = "Inserir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .TabIndex        = 1
            .Visible         = .T.
        ENDWITH

        *-- cmd_4c_Excluir (Left=387, TabIndex=2)
        THIS.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH THIS.cmd_4c_Excluir
            .Top             = 3
            .Left            = 387
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .TabIndex        = 2
            .Visible         = .T.
        ENDWITH

        *-- cmd_4c_Encerrar (Left=462, TabIndex=5, Cancel=.T. para ESC)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 462
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
            .Cancel          = .T.
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .TabIndex        = 5
            .Visible         = .T.
        ENDWITH

        *-- BINDEVENT dos botoes (metodos devem ser PUBLIC - sem PROTECTED)
        BINDEVENT(THIS.cmd_4c_Inserir,  "Click", THIS, "CmdInserirClick")
        BINDEVENT(THIS.cmd_4c_Excluir,  "Click", THIS, "CmdExcluirClick")
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
    ENDPROC

    *===========================================================================
    * CarregarCotacoes - Busca cotacoes da moeda e vincula ao grid
    *===========================================================================
    PROCEDURE CarregarCotacoes()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cMoes)
                MsgAviso("C" + CHR(243) + "digo da moeda n" + CHR(227) + "o informado.", "Aviso")
            ELSE
                loc_lSucesso = THIS.this_oBusinessObject.BuscarCotacoes(THIS.this_cMoes)
                IF loc_lSucesso AND USED("cursor_4c_Cotacoes")
                    THIS.grd_4c_Cotacoes.ColumnCount = 3
                    THIS.grd_4c_Cotacoes.RecordSource = "cursor_4c_Cotacoes"
                    SELECT cursor_4c_Cotacoes
                    GO BOTTOM
                    THIS.this_nIncluir = 0
                    THIS.grd_4c_Cotacoes.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar cota" + CHR(231) + CHR(245) + "es")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * CmdInserirClick - Insere nova cotacao para hoje nesta moeda
    * Replica inserir.Click do legado: verifica duplicata de hoje, insere nova
    * linha e posiciona grid para edicao do valor (valos)
    *===========================================================================
    PROCEDURE CmdInserirClick()
        LOCAL loc_lJaExiste
        TRY
            loc_lJaExiste = .F.

            IF USED("cursor_4c_Cotacoes")
                SELECT cursor_4c_Cotacoes
                SET ORDER TO cotacaos
                IF SEEK(ALLTRIM(THIS.this_cMoes) + DTOS(DATE()))
                    loc_lJaExiste = .T.
                ENDIF
                SET ORDER TO
            ENDIF

            IF loc_lJaExiste
                MsgAviso("J" + CHR(225) + " existe cota" + CHR(231) + CHR(227) + ;
                         "o para hoje nesta moeda.", "Aviso")
            ELSE
                IF THIS.this_oBusinessObject.InserirNovaCotacao(THIS.this_cMoes)
                    IF USED("cursor_4c_Cotacoes")
                        SELECT cursor_4c_Cotacoes
                        GO BOTTOM
                        THIS.this_nIncluir = RECNO()
                    ENDIF
                    THIS.grd_4c_Cotacoes.Refresh()
                    *-- Posicionar foco na coluna Data para usuario digitar imediatamente
                    THIS.grd_4c_Cotacoes.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir cota" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CmdExcluirClick - Exclui cotacao selecionada no grid
    * Replica delete.Click do legado: remove do SQL e recarrega cursor
    *===========================================================================
    PROCEDURE CmdExcluirClick()
        LOCAL loc_cCidChaves, loc_lProsseguir
        TRY
            loc_cCidChaves  = ""
            loc_lProsseguir = .F.

            IF USED("cursor_4c_Cotacoes")
                SELECT cursor_4c_Cotacoes
                IF !EOF() AND !BOF()
                    loc_cCidChaves  = ALLTRIM(cursor_4c_Cotacoes.cidchaves)
                    loc_lProsseguir = !EMPTY(loc_cCidChaves)
                ELSE
                    MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o.", "Aviso")
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF THIS.this_oBusinessObject.ExcluirCotacaoAtual(loc_cCidChaves)
                    THIS.this_nIncluir = 0
                    THIS.CarregarCotacoes()
                    *-- Reposicionar foco no grid apos exclusao (comportamento do legado)
                    THIS.grd_4c_Cotacoes.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir cota" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CmdEncerrarClick - Persiste alteracoes no SQL Server e fecha o form
    * Replica sair.Click do legado: remove invalidos, atualiza validos, fecha
    *===========================================================================
    PROCEDURE CmdEncerrarClick()
        TRY
            THIS.this_oBusinessObject.SalvarCotacoes()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao salvar cota" + CHR(231) + CHR(245) + "es")
        ENDTRY
        THIS.Release()
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Este form nao tem containers flutuantes - todos os controles ficam visiveis
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
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *===========================================================================
    * GrdAfterRowColChange - Controla editabilidade das colunas por linha
    * Apenas a linha de insercao (this_nIncluir) permanece editavel.
    * Replica AfterRowColChange do legado: zera Incluir ao mover de linha.
    *===========================================================================
    PROCEDURE GrdAfterRowColChange(par_nColIndex)
        IF USED("cursor_4c_Cotacoes")
            SELECT cursor_4c_Cotacoes
            IF RECNO() != THIS.this_nIncluir OR THIS.this_nIncluir = 0
                THIS.this_nIncluir = 0
                THIS.grd_4c_Cotacoes.Column1.ReadOnly = .T.
                THIS.grd_4c_Cotacoes.Column2.ReadOnly = .T.
                THIS.grd_4c_Cotacoes.Column3.ReadOnly = .T.
            ELSE
                THIS.grd_4c_Cotacoes.Column1.ReadOnly = .F.
                THIS.grd_4c_Cotacoes.Column2.ReadOnly = .F.
                THIS.grd_4c_Cotacoes.Column3.ReadOnly = .F.
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * GrdDataKeyPress - Valida que data nao esta vazia ao pressionar ENTER/TAB
    * Replica data.Text1.Valid do legado.
    *===========================================================================
    PROCEDURE GrdDataKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            IF USED("cursor_4c_Cotacoes")
                SELECT cursor_4c_Cotacoes
                IF EMPTY(cursor_4c_Cotacoes.datas)
                    MsgAviso("Informe a data da Cota" + CHR(231) + CHR(227) + "o.", "Aviso")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * GrdCotacaoKeyPress - Apos editar cotacao (ENTER/TAB): vai ao ultimo registro e refresha
    * Replica cotacao.Text1.Valid do legado: Select TmpCot / Go Bottom / Refresh
    *===========================================================================
    PROCEDURE GrdCotacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            IF USED("cursor_4c_Cotacoes")
                SELECT cursor_4c_Cotacoes
                GO BOTTOM
                THIS.grd_4c_Cotacoes.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * GrdHoraKeyPress - Verifica cotacao duplicada na data+hora ao pressionar ENTER/TAB
    * Replica hora.Text1.Valid do legado: detecta duplicidade e limpa hora.
    *===========================================================================
    PROCEDURE GrdHoraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cMoes, loc_dData, loc_cHora, loc_lDuplicada
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_Cotacoes") AND THIS.this_nIncluir > 0
                SELECT cursor_4c_Cotacoes
                IF RECNO() = THIS.this_nIncluir
                    loc_cMoes      = ALLTRIM(THIS.this_cMoes)
                    loc_dData      = cursor_4c_Cotacoes.datas
                    loc_cHora      = ALLTRIM(cursor_4c_Cotacoes.horas)
                    loc_lDuplicada = .F.

                    IF !EMPTY(loc_cHora) AND !EMPTY(loc_dData)
                        SET ORDER TO cotacaos
                        IF SEEK(loc_cMoes + DTOS(loc_dData) + loc_cHora)
                            *-- Encontrou registro - verificar se nao eh o proprio insert
                            IF RECNO() != THIS.this_nIncluir
                                loc_lDuplicada = .T.
                            ELSE
                                SKIP
                                IF !EOF()
                                    IF ALLTRIM(cmoes) + DTOS(datas) + ALLTRIM(horas) = ;
                                       loc_cMoes + DTOS(loc_dData) + loc_cHora
                                        loc_lDuplicada = .T.
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                        SET ORDER TO

                        IF loc_lDuplicada
                            MsgAviso("Cota" + CHR(231) + CHR(227) + "o j" + CHR(225) + " cadastrada !!!", "Aviso")
                            REPLACE cursor_4c_Cotacoes.horas WITH "  :  " IN cursor_4c_Cotacoes
                            THIS.grd_4c_Cotacoes.Refresh()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar hora")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Compatibilidade FormBase: delega para CmdInserirClick
    * Form OPERACIONAL sem Page2 - insercao ocorre diretamente no grid inline
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.CmdInserirClick()
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Compatibilidade FormBase: nao aplicavel neste dialog
    * Edicao ocorre diretamente na linha do grid (inline) sem pagina separada
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        *-- No-op: grid inline - usuario edita diretamente na linha de insercao
        RETURN
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Compatibilidade FormBase: nao aplicavel neste dialog
    * Nao existe modo visualizar/somente-leitura neste form OPERACIONAL
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        *-- No-op: dialog modal sem modo VISUALIZAR separado
        RETURN
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Compatibilidade FormBase: delega para CmdExcluirClick
    * Form OPERACIONAL sem Page2 - exclusao opera sobre linha selecionada no grid
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.CmdExcluirClick()
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Compatibilidade FormBase: nao aplicavel neste dialog
    * Form carrega todas as cotacoes da moeda no Init (sem filtro de busca)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        *-- No-op: dialog carrega cotacoes via BuscarCotacoes no Init
        RETURN
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Compatibilidade FormBase: delega para CmdEncerrarClick
    * Salva alteracoes pendentes no SQL Server e fecha o dialog
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Compatibilidade FormBase: nao aplicavel neste dialog
    * Salvamento ocorre em CmdEncerrarClick ao fechar o form (padrao do legado)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        *-- No-op: salvamento integrado ao Encerrar (replica comportamento do legado)
        RETURN
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Compatibilidade FormBase: fecha sem salvar
    * Descarta alteracoes pendentes e fecha o dialog imediatamente
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * CarregarLista - Compatibilidade FormBase: delega para CarregarCotacoes
    * "Lista" neste form = grid de cotacoes da moeda atual
    *===========================================================================
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarCotacoes()
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Compatibilidade FormBase: nao aplicavel neste dialog
    * Form OPERACIONAL sem modos INCLUIR/ALTERAR/VISUALIZAR separados
    * Editabilidade por linha controlada por GrdAfterRowColChange/this_nIncluir
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        *-- No-op: modo de edicao controlado por this_nIncluir (linha de insercao)
        RETURN
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Compatibilidade FormBase: nao aplicavel neste dialog
    * Nao ha TextBoxes independentes - toda edicao ocorre inline no grid
    *===========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        *-- No-op: grid inline sem campos independentes a habilitar/desabilitar
        RETURN
    ENDPROC

    *===========================================================================
    * LimparCampos - Compatibilidade FormBase: nao aplicavel neste dialog
    * Nao ha TextBoxes independentes para limpar fora do grid
    *===========================================================================
    PROCEDURE LimparCampos()
        *-- No-op: campos de edicao estao dentro do grid (inline)
        RETURN
    ENDPROC

    *===========================================================================
    * FormParaBO - Compatibilidade FormBase: nao aplicavel neste dialog
    * Edicao inline no grid; dados persistidos via InserirNovaCotacao/SalvarCotacoes
    * no BO. Nao ha mapeamento form->BO porque nao ha Page2 com TextBoxes.
    *===========================================================================
    PROCEDURE FormParaBO()
        *-- No-op: dados editados diretamente no cursor do grid (sem Page2)
        RETURN .T.
    ENDPROC

    *===========================================================================
    * BOParaForm - Compatibilidade FormBase: nao aplicavel neste dialog
    * Grid vinculado ao cursor_4c_Cotacoes (RecordSource) - dados ja no grid
    * sem necessidade de copia de propriedades BO->TextBoxes
    *===========================================================================
    PROCEDURE BOParaForm()
        *-- No-op: grid usa RecordSource direto no cursor (sem Page2 com TextBoxes)
        RETURN
    ENDPROC

    *===========================================================================
    * Destroy - Libera cursores e encerra o form
    *===========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Cotacoes")
            IF CURSORGETPROP("Buffering", "cursor_4c_Cotacoes") > 1
                TABLEREVERT(.T., "cursor_4c_Cotacoes")
            ENDIF
            USE IN cursor_4c_Cotacoes
        ENDIF
        IF USED("cursor_4c_CotacoesTemp")
            USE IN cursor_4c_CotacoesTemp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRCOTBO.prg):
*==============================================================================
* SIGPRCOTBO.prg - Business Object para Cotacoes de Moeda
* Tabela: SigCdCot
* PK: cidchaves
*==============================================================================
DEFINE CLASS SIGPRCOTBO AS BusinessBase

    *-- Campos da tabela SigCdCot
    this_cCmoes     = ""    && char(3)       - Codigo da moeda
    this_dDatas     = {}    && date          - Data da cotacao
    this_cHoras     = ""    && char(8)       - Hora da cotacao (HH:MM:SS)
    this_nValos     = 0     && numeric(11,6) - Valor da cotacao
    this_cCidChaves = ""    && char(20)      - Chave unica (PK)
    this_dDtAlts    = {}    && date          - Data de alteracao
    this_cUsuars    = ""    && char(10)      - Usuario que cadastrou

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdCot"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Substituto do fUniqueIds() do legado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarChaveUnica()
        RETURN LEFT(SYS(2015) + SYS(2015), 20)
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCmoes     = TratarNulo(cmoes,     "C")
            THIS.this_dDatas     = TratarNulo(datas,     "D")
            THIS.this_cHoras     = TratarNulo(horas,     "C")
            THIS.this_nValos     = TratarNulo(valos,     "N")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_dDtAlts    = TratarNulo(dtalts,    "D")
            THIS.this_cUsuars    = TratarNulo(usuars,    "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cCmoes)
            MsgAviso("Informe o c" + CHR(243) + "digo da moeda.", "Aviso")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDatas)
            MsgAviso("Informe a data da cota" + CHR(231) + CHR(227) + "o.", "Aviso")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cHoras)
            MsgAviso("Informe a hora da cota" + CHR(231) + CHR(227) + "o.", "Aviso")
            RETURN .F.
        ENDIF
        IF THIS.this_nValos = 0
            MsgAviso("Informe o valor da cota" + CHR(231) + CHR(227) + "o.", "Aviso")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarInsercao - Override BusinessBase: INSERT com this_* properties
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarInsercao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = THIS.GerarChaveUnica()
            ENDIF
            THIS.this_dDtAlts = DATE()
            THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)

            loc_cSQL = "INSERT INTO SigCdCot " + ;
                       "(cmoes, datas, horas, valos, cidchaves, dtalts, usuars) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCmoes))    + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas)         + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cHoras))    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValos)       + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtAlts)        + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cUsuars))   + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarAtualizacao - Override BusinessBase: UPDATE com this_* properties
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarAtualizacao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            THIS.this_dDtAlts = DATE()
            THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)

            loc_cSQL = "UPDATE SigCdCot SET " + ;
                       "datas  = " + FormatarDataSQL(THIS.this_dDatas)      + ", " + ;
                       "horas  = " + EscaparSQL(ALLTRIM(THIS.this_cHoras))  + ", " + ;
                       "valos  = " + FormatarNumeroSQL(THIS.this_nValos)    + ", " + ;
                       "dtalts = " + FormatarDataSQL(THIS.this_dDtAlts)     + ", " + ;
                       "usuars = " + EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Override BusinessBase: DELETE pela PK
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdCot WHERE cidchaves = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacoes - Carrega cotacoes de uma moeda no cursor de trabalho
    * Usa cursor temporario + ZAP/APPEND para nao destruir colunas do grid
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCotacoes(par_cMoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_cMoesFmt
        loc_lSucesso = .F.
        TRY
            loc_cMoesFmt = EscaparSQL(ALLTRIM(par_cMoes))
            loc_cSQL = "SELECT cmoes, datas, horas, valos, cidchaves, dtalts, usuars " + ;
                       "FROM SigCdCot " + ;
                       "WHERE cmoes = " + loc_cMoesFmt + " " + ;
                       "ORDER BY datas, horas"

            IF USED("cursor_4c_CotacoesTemp")
                USE IN cursor_4c_CotacoesTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotacoesTemp") > 0
                IF USED("cursor_4c_Cotacoes")
                    *-- Cursor ja existe (grid bound): apenas limpar e recarregar
                    SELECT cursor_4c_Cotacoes
                    ZAP
                    APPEND FROM DBF("cursor_4c_CotacoesTemp")
                    GO BOTTOM
                ELSE
                    *-- Primeira carga: criar cursor com estrutura e indices
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Cotacoes ;
                        (cmoes C(3) NULL, datas D NULL, horas C(8) NULL, ;
                         valos N(11,6) NULL, cidchaves C(20) NULL, ;
                         dtalts D NULL, usuars C(10) NULL)
                    SET NULL OFF
                    INDEX ON ALLTRIM(cidchaves) TAG cidchaves
                    INDEX ON ALLTRIM(cmoes) + DTOS(datas) + ALLTRIM(horas) TAG cotacaos
                    APPEND FROM DBF("cursor_4c_CotacoesTemp")
                    GO BOTTOM
                ENDIF
                USE IN cursor_4c_CotacoesTemp
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar cota" + CHR(231) + CHR(245) + "es.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirNovaCotacao - Insere nova linha com data/hora atuais e valos=0
    * Replica inserir.Click do legado: persiste no SQL + adiciona ao cursor local
    * O usuario preenche o valor (valos) diretamente no grid apos a insercao
    *--------------------------------------------------------------------------
    PROCEDURE InserirNovaCotacao(par_cMoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_cMoesFmt
        LOCAL loc_cDtFmt, loc_cHora, loc_cDtAltFmt, loc_cUsuFmt
        loc_lSucesso = .F.
        TRY
            loc_cChave    = THIS.GerarChaveUnica()
            loc_cMoesFmt  = EscaparSQL(ALLTRIM(par_cMoes))
            loc_cDtFmt    = FormatarDataSQL(DATE())
            loc_cHora     = TIME()
            loc_cDtAltFmt = FormatarDataSQL(DATE())
            loc_cUsuFmt   = EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))

            *-- Inserir no SQL Server sem valos (usuario preenche no grid)
            loc_cSQL = "INSERT INTO SigCdCot " + ;
                       "(cmoes, datas, horas, cidchaves, dtalts, usuars) " + ;
                       "VALUES (" + ;
                       loc_cMoesFmt          + ", " + ;
                       loc_cDtFmt            + ", " + ;
                       EscaparSQL(loc_cHora) + ", " + ;
                       EscaparSQL(loc_cChave)+ ", " + ;
                       loc_cDtAltFmt         + ", " + ;
                       loc_cUsuFmt           + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                *-- Adicionar ao cursor de trabalho para exibicao imediata no grid
                IF USED("cursor_4c_Cotacoes")
                    SELECT cursor_4c_Cotacoes
                    SET ORDER TO
                    INSERT INTO cursor_4c_Cotacoes ;
                        (cmoes, datas, horas, valos, cidchaves, dtalts, usuars) ;
                        VALUES ;
                        (par_cMoes, DATE(), loc_cHora, 0, ;
                         loc_cChave, DATE(), ALLTRIM(gc_4c_UsuarioLogado))
                ENDIF
                THIS.this_cCidChaves = loc_cChave
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirCotacaoAtual - Exclui cotacao do SQL Server pelo cidchaves
    * Replica delete.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirCotacaoAtual(par_cCidChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChaveFmt
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cCidChaves)
                MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            loc_cChaveFmt = EscaparSQL(ALLTRIM(par_cCidChaves))
            loc_cSQL = "DELETE FROM SigCdCot WHERE cidchaves = " + loc_cChaveFmt

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.this_cCidChaves = par_cCidChaves
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCotacaoDuplicada - Checa se ja existe cotacao para moeda+data+hora
    * Replica hora.Text1.Valid do legado
    * Retorna .T. se duplicata encontrada (excluindo o proprio registro atual)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCotacaoDuplicada(par_cMoes, par_dDatas, par_cHoras, par_cCidChavesAtual)
        LOCAL loc_lDuplicada
        loc_lDuplicada = .F.
        TRY
            IF USED("cursor_4c_Cotacoes")
                SELECT cursor_4c_Cotacoes
                SET ORDER TO cotacaos
                IF SEEK(ALLTRIM(par_cMoes) + DTOS(par_dDatas) + ALLTRIM(par_cHoras))
                    IF ALLTRIM(cidchaves) <> ALLTRIM(par_cCidChavesAtual)
                        loc_lDuplicada = .T.
                    ENDIF
                ENDIF
                SET ORDER TO
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicada
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarCotacoes - Persiste todas as alteracoes do cursor no SQL Server
    * Replica sair.Click do legado: remove invalidos e atualiza validos
    *--------------------------------------------------------------------------
    PROCEDURE SalvarCotacoes()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChaveFmt, loc_cDtFmt, loc_cHoraFmt, loc_cValFmt
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Cotacoes")
                loc_lSucesso = .F.
            ENDIF

            *-- Remover registros invalidos (sem data ou sem valor)
            SELECT cursor_4c_Cotacoes
            GO TOP
            SCAN
                IF EMPTY(cursor_4c_Cotacoes.datas) OR cursor_4c_Cotacoes.valos = 0
                    IF !EMPTY(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                        loc_cChaveFmt = EscaparSQL(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                        loc_cSQL = "DELETE FROM SigCdCot WHERE cidchaves = " + loc_cChaveFmt
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                    DELETE
                ENDIF
                SELECT cursor_4c_Cotacoes
            ENDSCAN

            *-- Atualizar registros validos no SQL Server com valores editados no grid
            SELECT cursor_4c_Cotacoes
            GO TOP
            SCAN
                IF !DELETED() AND !EMPTY(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                    loc_cChaveFmt = EscaparSQL(ALLTRIM(cursor_4c_Cotacoes.cidchaves))
                    loc_cDtFmt    = FormatarDataSQL(cursor_4c_Cotacoes.datas)
                    loc_cHoraFmt  = EscaparSQL(ALLTRIM(cursor_4c_Cotacoes.horas))
                    loc_cValFmt   = FormatarNumeroSQL(cursor_4c_Cotacoes.valos)

                    loc_cSQL = "UPDATE SigCdCot SET " + ;
                               "datas = " + loc_cDtFmt   + ", " + ;
                               "horas = " + loc_cHoraFmt + ", " + ;
                               "valos = " + loc_cValFmt  + " " + ;
                               "WHERE cidchaves = " + loc_cChaveFmt

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

ENDDEFINE

